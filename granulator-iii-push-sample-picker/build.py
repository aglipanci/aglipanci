#!/usr/bin/env python3
"""Build the "Push Sample Picker" for Granulator III (and a stand-alone tester).

Granulator III on Push 3 standalone cannot change its sample: the device loads
samples through a drop area / file dialog, and neither exists on Push. This
script generates a Max for Live *module* that picks WAV/AIFF files from a folder
on the Push (or on the computer) with ordinary Live parameters, so the file can
be chosen from the Push encoders, and hands the chosen path to whatever
`buffer~` the host device uses.

Only stock Max objects are used (no js, no externals) so the result loads on
desktop Live and on Push 3 standalone.

Outputs (written next to this script):

  PushSamplePicker.maxpat   The module on its own. Open it in Max, Select All,
                            Copy, and paste it into the Granulator III patcher
                            (see README.md for the two connections to make).
  PushSampleTester.amxd     A tiny instrument (buffer~ + groove~) that embeds
                            the module, to test folder scanning and sample
                            loading on Push before touching Granulator III.
  PushSampleTester.maxpat   Same as a plain Max patcher.

Usage:  python3 build.py
"""

from __future__ import annotations

import json
import struct
from pathlib import Path

HERE = Path(__file__).resolve().parent

MODULE_NAME = "PushSamplePicker"
TESTER_NAME = "PushSampleTester"

# Default sub-path (relative to the chosen root) that holds one sub-folder per
# sample set, e.g.  <User Library>/Samples/Folders/Drones/*.wav
DEFAULT_SUBPATH = "Samples/Folders"

# Live parameter long names. Prefixed so they cannot collide with parameters
# that already exist in Granulator III when the module is pasted in.
P_FOLDER = "Smp Folder"
P_FILE = "Smp File"
P_LOAD = "Smp Load"
P_AUTO = "Smp Auto"
P_RANDOM = "Smp Random"
P_RESCAN = "Smp Rescan"
P_FOLDERS = "Smp Folders"
P_FILES = "Smp Files"
P_ROOT = "Smp Root"

ROOT_ITEMS = ["Next to device", "User Library", "Custom path"]

BANK_MAIN = ("Sample", [P_FOLDER, P_FILE, P_LOAD, P_AUTO, P_RANDOM, P_RESCAN, P_FOLDERS, P_FILES])
BANK_SETUP = ("Sample Setup", [P_ROOT])

# Name shared by the module and the host device. `---` is expanded per device
# instance by Max for Live, so several devices never talk to each other.
PATH_SEND = "---push_sample_path"

MAX_ITEMS = 1024  # files per folder / folders per root we can list

APPVERSION = {"major": 8, "minor": 6, "revision": 5, "architecture": "x64", "modernui": 1}


class PatcherBuilder:
    """Accumulates boxes and patchlines for one patcher."""

    def __init__(self) -> None:
        self.boxes: list[dict] = []
        self.lines: list[dict] = []
        self._n = 0

    def _id(self) -> str:
        self._n += 1
        return f"obj-{self._n}"

    def add(self, maxclass: str, rect, **kw) -> str:
        box = {"id": self._id(), "maxclass": maxclass, "patching_rect": [float(v) for v in rect]}
        box.update(kw)
        self.boxes.append({"box": box})
        return box["id"]

    def obj(self, text: str, rect, numinlets: int, outlets: list[str], **kw) -> str:
        return self.add("newobj", rect, text=text, numinlets=numinlets,
                        numoutlets=len(outlets), outlettype=outlets, **kw)

    def msg(self, text: str, rect, **kw) -> str:
        return self.add("message", rect, text=text, numinlets=2, numoutlets=1, outlettype=[""], **kw)

    def comment(self, text: str, rect, **kw) -> str:
        return self.add("comment", rect, text=text, numinlets=1, numoutlets=0, **kw)

    def connect(self, src: str, outlet: int, dst: str, inlet: int) -> None:
        self.lines.append({"patchline": {"source": [src, outlet], "destination": [dst, inlet]}})

    def patcher(self, rect, **kw) -> dict:
        p = {
            "fileversion": 1,
            "appversion": APPVERSION,
            "classnamespace": "box",
            "rect": [float(v) for v in rect],
            "bglocked": 0,
            "openinpresentation": 0,
            "default_fontsize": 12.0,
            "default_fontface": 0,
            "default_fontname": "Arial",
            "gridonopen": 1,
            "gridsize": [15.0, 15.0],
            "gridsnaponopen": 1,
            "objectsnaponopen": 1,
            "statusbarvisible": 2,
            "toolbarvisible": 1,
            "lefttoolbarpinned": 0,
            "toptoolbarpinned": 0,
            "righttoolbarpinned": 0,
            "bottomtoolbarpinned": 0,
            "toolbars_unpinned_last_save": 0,
            "tallnewobj": 0,
            "boxanimatetime": 200,
            "enablehscroll": 1,
            "enablevscroll": 1,
            "devicewidth": 0.0,
            "description": "",
            "digest": "",
            "tags": "",
            "style": "",
            "subpatcher_template": "",
            "assistshowspatchername": 0,
            "boxes": self.boxes,
            "lines": self.lines,
        }
        p.update(kw)
        return p


# --------------------------------------------------------------------------- live.* helpers

def live_param(longname: str, shortname: str, **valueof) -> dict:
    v = {"parameter_longname": longname, "parameter_shortname": shortname}
    v.update(valueof)
    return {
        "parameter_enable": 1,
        "saved_attribute_attributes": {"valueof": v},
        "varname": longname.lower().replace(" ", "_"),
    }


def _pres(present, prect) -> dict:
    if not present:
        return {}
    return {"presentation": 1, "presentation_rect": [float(v) for v in prect]}


def numbox(pb, name, short, rect, present, prect, mmin, mmax, initial) -> str:
    """live.numbox holding an integer parameter."""
    return pb.add(
        "live.numbox", rect, numinlets=1, numoutlets=2, outlettype=["", "float"],
        **_pres(present, prect),
        **live_param(name, short, parameter_type=1, parameter_mmin=float(mmin),
                     parameter_mmax=float(mmax), parameter_initial_enable=1,
                     parameter_initial=[float(initial)], parameter_unitstyle=0),
    )


def button(pb, name, short, rect, present, prect) -> str:
    return pb.add(
        "live.button", rect, numinlets=1, numoutlets=1, outlettype=["bang"],
        **_pres(present, prect),
        **live_param(name, short, parameter_type=2, parameter_enum=["off", "on"],
                     parameter_mmax=1, parameter_unitstyle=0),
    )


def toggle(pb, name, short, rect, present, prect, initial) -> str:
    return pb.add(
        "live.toggle", rect, numinlets=1, numoutlets=2, outlettype=["", "float"],
        **_pres(present, prect),
        **live_param(name, short, parameter_type=2, parameter_enum=["off", "on"],
                     parameter_mmax=1, parameter_initial_enable=1,
                     parameter_initial=[float(initial)], parameter_unitstyle=0),
    )


def menu(pb, name, short, rect, present, prect, items, initial) -> str:
    return pb.add(
        "live.menu", rect, numinlets=1, numoutlets=3, outlettype=["", "", "float"],
        **_pres(present, prect),
        **live_param(name, short, parameter_type=2, parameter_enum=list(items),
                     parameter_mmax=len(items) - 1, parameter_initial_enable=1,
                     parameter_initial=[initial], parameter_unitstyle=0),
    )


# --------------------------------------------------------------------------- the picker module

def add_picker(pb: PatcherBuilder, x0: float, y0: float, present: bool, prect_of=None) -> dict:
    """Add the whole sample picker to `pb`, with its top-left corner at (x0, y0).

    present: put the UI objects in presentation mode (True for the tester device,
             False for the paste-in module so nothing lands on top of the host UI).
    prect_of: callable(name) -> presentation rect for the UI objects.
    Returns ids of a few objects the host may want to connect to.
    """
    P = prect_of or (lambda name: [0, 0, 40, 15])

    def X(col):  # column -> x
        return x0 + col * 150

    def Y(row):  # row -> y
        return y0 + row * 32

    pb.comment("PUSH SAMPLE PICKER - picks a file in <root>/<sub-path>/<folder>/ and sends its "
               f"path to [s {PATH_SEND}]. Stock objects only (works on Push 3 standalone).",
               [X(0), Y(0), 900, 20], fontsize=11.0, fontface=1)

    # ---- UI / parameters ------------------------------------------------------------------
    pb.comment("parameters (these show up on the Push encoders)", [X(0), Y(1), 320, 20], fontsize=10.0)
    root = menu(pb, P_ROOT, "Root", [X(0), Y(2), 110, 15], present, P("root"), ROOT_ITEMS, 1)
    path_edit = pb.add("textedit", [X(1), Y(2), 220, 22], numinlets=1, numoutlets=4,
                       outlettype=["", "int", "", ""], text=DEFAULT_SUBPATH, **_pres(present, P("path")))
    rescan_btn = button(pb, P_RESCAN, "Rescan", [X(3), Y(2), 24, 24], present, P("rescan"))
    folder_menu = pb.add("umenu", [X(0), Y(3), 140, 22], numinlets=1, numoutlets=3,
                         outlettype=["int", "", ""], items=[], **_pres(present, P("folder_menu")))
    folder_num = numbox(pb, P_FOLDER, "Folder", [X(1), Y(3), 44, 15], present, P("folder"), 1, 999, 1)
    file_menu = pb.add("umenu", [X(2), Y(3), 140, 22], numinlets=1, numoutlets=3,
                       outlettype=["int", "", ""], items=[], **_pres(present, P("file_menu")))
    file_num = numbox(pb, P_FILE, "File", [X(3), Y(3), 44, 15], present, P("file"), 1, 999, 1)
    load_btn = button(pb, P_LOAD, "Load", [X(0), Y(4), 24, 24], present, P("load"))
    auto_tog = toggle(pb, P_AUTO, "Auto", [X(0) + 40, Y(4), 15, 15], present, P("auto"), 1)
    random_btn = button(pb, P_RANDOM, "Random", [X(1), Y(4), 24, 24], present, P("random"))
    folders_num = numbox(pb, P_FOLDERS, "Folders", [X(2), Y(4), 44, 15], present, P("folders"), 0, 999, 0)
    files_num = numbox(pb, P_FILES, "Files", [X(3), Y(4), 44, 15], present, P("files"), 0, 999, 0)
    resolved = pb.comment("root: (not scanned yet)", [X(0), Y(5), 600, 18], fontsize=9.0,
                          **_pres(present, P("resolved")))
    loaded = pb.comment("loaded: -", [X(0), Y(6), 600, 18], fontsize=9.0, **_pres(present, P("loaded")))

    # ---- sub-path text: default on load, user edits, and the value saved with the Live set --
    pb.comment("sub-path: default / textedit / saved in the set (pattr in parameter mode)",
               [X(0), Y(7), 460, 20], fontsize=10.0)
    loadbang = pb.obj("loadbang", [X(0), Y(8), 60, 22], 1, ["bang"])
    lb_t = pb.obj("t b b b", [X(0), Y(9), 60, 22], 1, ["bang", "bang", "bang"])
    default_msg = pb.msg(DEFAULT_SUBPATH, [X(0), Y(10), 110, 22])
    to_sym = pb.obj("tosymbol", [X(1), Y(9), 60, 22], 1, [""])
    path_pattr = pb.add(
        "newobj", [X(1), Y(10), 200, 22], text="pattr smp_subpath", numinlets=2, numoutlets=3,
        outlettype=["", "", ""], parameter_enable=1,
        saved_attribute_attributes={"valueof": {
            "parameter_longname": "Smp Subpath", "parameter_shortname": "Subpath",
            "parameter_type": 3, "parameter_invisible": 1}},
    )
    sub_route = pb.obj("route symbol int float bang", [X(1), Y(11), 180, 22], 1, ["", "", "", "", ""])
    sub_t = pb.obj("t b s s s", [X(1), Y(12), 80, 22], 1, ["bang", "", "", ""])
    sub_set = pb.obj("prepend set", [X(2), Y(12), 80, 22], 1, [""])
    thisdevice = pb.obj("live.thisdevice", [X(3), Y(8), 100, 22], 1, ["bang", "int", "int"])
    td_t = pb.obj("t b b b", [X(3), Y(9), 60, 22], 1, ["bang", "bang", "bang"])
    arm_msg = pb.msg("1", [X(3) + 80, Y(9), 30, 22])
    arm_gate = pb.obj("gate", [X(3) + 80, Y(10), 40, 22], 2, [""])
    pb.comment("no sample is loaded by the picker until the device finished loading (live.thisdevice), "
               "so a Set restores its own sample", [X(3) + 130, Y(9), 520, 20], fontsize=9.0)
    pb.connect(td_t, 2, arm_msg, 0)
    pb.connect(arm_msg, 0, arm_gate, 0)

    # default text (fires before the set's saved value, which then overrides it)
    pb.connect(loadbang, 0, lb_t, 0)
    pb.connect(lb_t, 0, default_msg, 0)
    pb.connect(default_msg, 0, sub_route, 0)
    # typed text -> symbol -> store in pattr (saved with the set) and use it
    pb.connect(path_edit, 0, to_sym, 0)
    pb.connect(to_sym, 0, path_pattr, 0)
    pb.connect(path_pattr, 0, sub_route, 0)
    # after Live restored the parameters, re-emit the saved value then scan
    pb.connect(thisdevice, 0, td_t, 0)
    pb.connect(td_t, 1, path_pattr, 0)  # bang -> pattr outputs its value (nothing if unset)
    pb.connect(sub_route, 0, sub_t, 0)  # "symbol x"
    pb.connect(sub_route, 4, sub_t, 0)  # bare symbol
    pb.connect(sub_t, 3, sub_set, 0)
    pb.connect(sub_set, 0, path_edit, 0)

    # ---- resolve the root folder ----------------------------------------------------------
    pb.comment("root folder: device folder (thispatcher), User Library (= 3 levels up), or the text as-is",
               [X(0), Y(14), 640, 20], fontsize=10.0)
    tp_msg = pb.msg("path", [X(0), Y(15), 40, 22])
    thispatcher = pb.obj("thispatcher", [X(0), Y(16), 80, 22], 1, ["", ""])
    r_path = pb.obj("route path", [X(0), Y(17), 70, 22], 1, ["", ""])
    dev_t = pb.obj("t s s", [X(0), Y(18), 45, 22], 1, ["", ""])
    dev_reg = pb.obj("zl reg", [X(0), Y(19), 60, 22], 2, ["", ""])
    # strip "/Presets/Instruments/Max Instrument" (or any 3 trailing components) -> User Library
    up3 = pb.obj("regexp ^(.*)/[^/]+/[^/]+/[^/]+/?$", [X(1), Y(18), 230, 22], 1, ["", "", "", ""])
    ul_reg = pb.obj("zl reg", [X(1), Y(19), 60, 22], 2, ["", ""])
    root_sel = pb.obj("sel 0 1 2", [X(2), Y(16), 80, 22], 4, ["bang", "bang", "bang", ""])
    join_dev = pb.obj("sprintf symout %s/%s", [X(0), Y(20), 130, 22], 2, [""])
    join_ul = pb.obj("sprintf symout %s/%s", [X(1), Y(20), 130, 22], 2, [""])
    custom_reg = pb.obj(f"zl reg @zlmaxsize {MAX_ITEMS}", [X(2), Y(20), 140, 22], 2, ["", ""])
    base_reg = pb.obj(f"zl reg @zlmaxsize {MAX_ITEMS}", [X(0), Y(21), 140, 22], 2, ["", ""])

    pb.connect(lb_t, 1, tp_msg, 0)  # ask thispatcher for the device folder before any scan
    pb.connect(tp_msg, 0, thispatcher, 0)
    pb.connect(thispatcher, 0, r_path, 0)
    pb.connect(r_path, 0, dev_t, 0)
    pb.connect(dev_t, 1, dev_reg, 1)
    pb.connect(dev_t, 0, up3, 0)
    pb.connect(up3, 0, ul_reg, 1)
    # sub-path goes into the cold inlets of the joiners
    pb.connect(sub_t, 1, join_dev, 1)
    pb.connect(sub_t, 1, join_ul, 1)
    pb.connect(sub_t, 1, custom_reg, 1)
    # Root value -> one of three ways to build the base path
    root_i = pb.obj("int", [X(2), Y(15), 40, 22], 2, ["int"])
    root_t = pb.obj("t b i", [X(2), Y(14), 45, 22], 1, ["bang", "int"])
    pb.connect(root, 0, root_t, 0)
    pb.connect(root_t, 1, root_i, 1)
    pb.connect(root_i, 0, root_sel, 0)
    pb.connect(root_sel, 0, dev_reg, 0)
    pb.connect(dev_reg, 0, join_dev, 0)
    pb.connect(root_sel, 1, ul_reg, 0)
    pb.connect(ul_reg, 0, join_ul, 0)
    pb.connect(root_sel, 2, custom_reg, 0)
    for j in (join_dev, join_ul, custom_reg):
        pb.connect(j, 0, base_reg, 0)

    # ---- rescan: list sub-folders of the base path ----------------------------------------
    pb.comment("rescan: [folder] lists the sub-folders (types fold), sorted, counted, into a umenu",
               [X(3), Y(14), 560, 20], fontsize=10.0)
    rescan_t = pb.obj("t b b b b", [X(3), Y(15), 75, 22], 1, ["bang", "bang", "bang", "bang"])
    auto_int = pb.obj("int", [X(4) + 100, Y(15), 40, 22], 2, ["int"])
    noload_msg = pb.msg("0", [X(4) + 150, Y(15), 30, 22])
    reset_fold = pb.obj("t b b", [X(4), Y(15), 45, 22], 1, ["bang", "bang"])
    zero_msg_f = pb.msg("0", [X(4), Y(16), 30, 22])
    zlclear_f = pb.msg("zlclear", [X(4) + 40, Y(16), 55, 22])
    base_t = pb.obj("t b b s s s", [X(3), Y(22), 90, 22], 1, ["bang", "bang", "", "", ""])
    set_res = pb.obj("prepend set root:", [X(5), Y(22), 110, 22], 1, [""])
    types_fold = pb.msg("types fold", [X(4), Y(21), 70, 22])
    folder_f = pb.obj("folder", [X(4), Y(23), 60, 22], 1, [""])
    r_fold = pb.obj("route clear append", [X(4), Y(24), 120, 22], 1, ["", "", ""])
    rx_fold = pb.obj("regexp ^([^.].*)$", [X(4), Y(25), 120, 22], 1, ["", "", "", ""])
    grp_f = pb.obj(f"zl group {MAX_ITEMS} @zlmaxsize {MAX_ITEMS}", [X(4), Y(26), 190, 22], 2, ["", ""])
    sort_f = pb.obj(f"zl sort @zlmaxsize {MAX_ITEMS}", [X(4), Y(27), 150, 22], 2, ["", ""])
    sortt_f = pb.obj("t l l l", [X(4), Y(28), 60, 22], 1, ["", "", ""])
    reg_f = pb.obj(f"zl reg @zlmaxsize {MAX_ITEMS}", [X(4), Y(29), 140, 22], 2, ["", ""])
    len_f = pb.obj(f"zl len @zlmaxsize {MAX_ITEMS}", [X(5), Y(29), 140, 22], 2, ["int", ""])
    cnt_f = pb.obj("int", [X(5), Y(30), 40, 22], 2, ["int"])
    menu_clear_f = pb.msg("clear", [X(6), Y(29), 40, 22])
    iter_f = pb.obj("iter", [X(6), Y(30), 40, 22], 1, [""])
    app_f = pb.obj("prepend append", [X(6), Y(31), 100, 22], 1, [""])
    after_f = pb.obj("t b", [X(3), Y(23), 30, 22], 1, ["bang"])
    cnt_f_t = pb.obj("t i i", [X(3), Y(24), 45, 22], 1, ["int", "int"])
    sel0_f = pb.obj("sel 0", [X(3), Y(25), 45, 22], 2, ["bang", ""])
    bang_folder_num = pb.obj("t b", [X(3), Y(26), 30, 22], 1, ["bang"])
    basecopy_reg = pb.obj(f"zl reg @zlmaxsize {MAX_ITEMS}", [X(3), Y(27), 140, 22], 2, ["", ""])

    # triggers of a full rescan
    pb.connect(td_t, 0, rescan_t, 0)          # after load (parameters restored)
    pb.connect(rescan_btn, 0, rescan_t, 0)
    pb.connect(root_t, 0, rescan_t, 0)        # changing Root (after its value was stored)
    pb.connect(sub_t, 0, rescan_t, 0)         # new sub-path text
    # order: reset (right), compute base (middle), continue after listing (left)
    pb.connect(rescan_t, 3, noload_msg, 0)     # a rescan never loads a file by itself ...
    pb.connect(rescan_t, 2, reset_fold, 0)
    pb.connect(reset_fold, 1, zlclear_f, 0)
    pb.connect(reset_fold, 0, zero_msg_f, 0)
    pb.connect(zlclear_f, 0, grp_f, 0)
    pb.connect(zlclear_f, 0, reg_f, 0)
    pb.connect(zero_msg_f, 0, cnt_f, 1)
    pb.connect(zero_msg_f, 0, folders_num, 0)
    pb.connect(zero_msg_f, 0, menu_clear_f, 0)
    pb.connect(menu_clear_f, 0, folder_menu, 0)
    pb.connect(rescan_t, 1, root_i, 0)        # bang int -> sel -> builds base -> base_reg outputs
    pb.connect(rescan_t, 0, auto_int, 0)      # ... then Auto is back in charge
    pb.connect(base_reg, 0, base_t, 0)
    pb.connect(base_t, 4, set_res, 0)
    pb.connect(set_res, 0, resolved, 0)
    pb.connect(lb_t, 2, types_fold, 0)
    pb.connect(types_fold, 0, folder_f, 0)
    pb.connect(base_t, 2, folder_f, 0)        # symbol -> folder lists it (synchronously)
    pb.connect(folder_f, 0, r_fold, 0)
    pb.connect(r_fold, 1, rx_fold, 0)         # "append name" -> name
    pb.connect(rx_fold, 0, grp_f, 0)
    pb.connect(base_t, 1, grp_f, 0)           # bang -> output what was collected
    pb.connect(grp_f, 0, sort_f, 0)
    pb.connect(sort_f, 0, sortt_f, 0)
    pb.connect(sortt_f, 2, reg_f, 1)
    pb.connect(sortt_f, 1, len_f, 0)
    pb.connect(len_f, 0, cnt_f, 1)
    pb.connect(len_f, 0, folders_num, 0)
    pb.connect(sortt_f, 0, iter_f, 0)
    pb.connect(iter_f, 0, app_f, 0)
    pb.connect(app_f, 0, folder_menu, 0)
    # continue: no sub-folders -> the base itself holds the files; else pick current Folder
    pb.connect(base_t, 0, after_f, 0)
    pb.connect(after_f, 0, cnt_f, 0)
    pb.connect(cnt_f, 0, cnt_f_t, 0)
    pb.connect(cnt_f_t, 0, sel0_f, 0)
    pb.connect(sel0_f, 1, bang_folder_num, 0)
    pb.connect(bang_folder_num, 0, folder_num, 0)
    pb.connect(base_t, 3, basecopy_reg, 1)    # keep a copy of the base for the no-sub-folder case

    # ---- select a folder: index -> name -> path -> list its files -------------------------
    pb.comment("folder select: Folder param -> clip -> zl nth -> path -> [folder] lists files -> filter by extension",
               [X(0), Y(32), 700, 20], fontsize=10.0)
    fold_ti = pb.obj("t i i", [X(0), Y(33), 45, 22], 1, ["int", "int"])
    fold_setmenu = pb.obj("- 1", [X(1), Y(33), 40, 22], 2, ["int"])
    fold_setmsg = pb.obj("prepend set", [X(1), Y(34), 80, 22], 1, [""])
    clip_f = pb.obj("clip 1 1", [X(0), Y(34), 60, 22], 3, ["int"])
    fold_tbi = pb.obj("t b i", [X(0), Y(35), 45, 22], 1, ["bang", "int"])
    nth_f = pb.obj(f"zl nth @zlmaxsize {MAX_ITEMS}", [X(0), Y(36), 140, 22], 2, ["", ""])
    join_folder = pb.obj("sprintf symout %s/%s", [X(0), Y(37), 130, 22], 2, [""])
    folderpath_reg = pb.obj(f"zl reg @zlmaxsize {MAX_ITEMS}", [X(0), Y(38), 140, 22], 2, ["", ""])
    fp_t = pb.obj("t b b s s", [X(0), Y(39), 80, 22], 1, ["bang", "bang", "", ""])
    reset_files = pb.obj("t b b", [X(1), Y(39), 45, 22], 1, ["bang", "bang"])
    zero_msg_x = pb.msg("0", [X(1), Y(40), 30, 22])
    zlclear_x = pb.msg("zlclear", [X(1) + 40, Y(40), 55, 22])
    folder_x = pb.obj("folder", [X(2), Y(40), 60, 22], 1, [""])
    r_files = pb.obj("route clear append", [X(2), Y(41), 120, 22], 1, ["", "", ""])
    rx_files = pb.obj("regexp (?i)^([^.].*[.](?:wav|aiff?|flac|mp3|ogg))$", [X(2), Y(42), 300, 22], 1,
                      ["", "", "", ""])
    grp_x = pb.obj(f"zl group {MAX_ITEMS} @zlmaxsize {MAX_ITEMS}", [X(2), Y(43), 190, 22], 2, ["", ""])
    sort_x = pb.obj(f"zl sort @zlmaxsize {MAX_ITEMS}", [X(2), Y(44), 150, 22], 2, ["", ""])
    sortt_x = pb.obj("t l l l", [X(2), Y(45), 60, 22], 1, ["", "", ""])
    reg_x = pb.obj(f"zl reg @zlmaxsize {MAX_ITEMS}", [X(2), Y(46), 140, 22], 2, ["", ""])
    len_x = pb.obj(f"zl len @zlmaxsize {MAX_ITEMS}", [X(3), Y(46), 140, 22], 2, ["int", ""])
    cnt_x = pb.obj("int", [X(3), Y(47), 40, 22], 2, ["int"])
    cnt_r = pb.obj("int", [X(3) + 50, Y(47), 40, 22], 2, ["int"])
    menu_clear_x = pb.msg("clear", [X(4), Y(46), 40, 22])
    iter_x = pb.obj("iter", [X(4), Y(47), 40, 22], 1, [""])
    app_x = pb.obj("prepend append", [X(4), Y(48), 100, 22], 1, [""])
    after_x = pb.obj("t b", [X(0), Y(40), 30, 22], 1, ["bang"])
    gate_auto_f = pb.obj("gate", [X(0), Y(41), 40, 22], 2, [""])

    pb.connect(folder_num, 0, fold_ti, 0)
    pb.connect(folder_menu, 0, fold_setmenu_in := pb.obj("+ 1", [X(1), Y(32), 40, 22], 2, ["int"]), 0)
    pb.connect(fold_setmenu_in, 0, folder_num, 0)
    pb.connect(fold_ti, 1, fold_setmenu, 0)
    pb.connect(fold_setmenu, 0, fold_setmsg, 0)
    pb.connect(fold_setmsg, 0, folder_menu, 0)
    pb.connect(fold_ti, 0, clip_f, 0)
    pb.connect(cnt_f_t, 1, clip_f, 2)         # clip max is set before the folder is selected
    pb.connect(clip_f, 0, fold_tbi, 0)
    pb.connect(fold_tbi, 1, nth_f, 1)
    pb.connect(fold_tbi, 0, reg_f, 0)
    pb.connect(reg_f, 0, nth_f, 0)
    pb.connect(nth_f, 0, join_folder, 0)
    pb.connect(base_t, 3, join_folder, 1)     # base path in the cold inlet
    pb.connect(join_folder, 0, folderpath_reg, 0)
    pb.connect(sel0_f, 0, basecopy_reg, 0)    # no sub-folders: the base itself holds the files
    pb.connect(basecopy_reg, 0, folderpath_reg, 0)
    pb.connect(folderpath_reg, 0, fp_t, 0)
    pb.connect(fp_t, 3, reset_files, 0)
    pb.connect(reset_files, 1, zlclear_x, 0)
    pb.connect(reset_files, 0, zero_msg_x, 0)
    pb.connect(zlclear_x, 0, grp_x, 0)
    pb.connect(zlclear_x, 0, reg_x, 0)
    pb.connect(zero_msg_x, 0, cnt_x, 1)
    pb.connect(zero_msg_x, 0, cnt_r, 1)
    pb.connect(zero_msg_x, 0, files_num, 0)
    pb.connect(zero_msg_x, 0, menu_clear_x, 0)
    pb.connect(menu_clear_x, 0, file_menu, 0)
    pb.connect(fp_t, 2, folder_x, 0)
    pb.connect(folder_x, 0, r_files, 0)
    pb.connect(r_files, 1, rx_files, 0)
    pb.connect(rx_files, 0, grp_x, 0)
    pb.connect(fp_t, 1, grp_x, 0)
    pb.connect(grp_x, 0, sort_x, 0)
    pb.connect(sort_x, 0, sortt_x, 0)
    pb.connect(sortt_x, 2, reg_x, 1)
    pb.connect(sortt_x, 1, len_x, 0)
    pb.connect(len_x, 0, cnt_x, 1)
    pb.connect(len_x, 0, cnt_r, 1)
    pb.connect(len_x, 0, files_num, 0)
    pb.connect(sortt_x, 0, iter_x, 0)
    pb.connect(iter_x, 0, app_x, 0)
    pb.connect(app_x, 0, file_menu, 0)
    # after listing: load the current File if Auto is on
    pb.connect(fp_t, 0, after_x, 0)
    pb.connect(after_x, 0, gate_auto_f, 1)
    pb.connect(auto_tog, 0, auto_int, 0)
    pb.connect(auto_int, 0, gate_auto_f, 0)
    pb.connect(noload_msg, 0, gate_auto_f, 0)

    # ---- pick a file and emit its path -----------------------------------------------------
    pb.comment("load: File param (or Load / Random) -> clip -> zl nth -> <folder>/<file> -> "
               f"[s {PATH_SEND}]", [X(0), Y(49), 640, 20], fontsize=10.0)
    file_ti = pb.obj("t i i", [X(0), Y(50), 45, 22], 1, ["int", "int"])
    file_idx = pb.obj("int", [X(0), Y(51), 40, 22], 2, ["int"])
    file_setmenu = pb.obj("- 1", [X(1), Y(50), 40, 22], 2, ["int"])
    file_setmsg = pb.obj("prepend set", [X(1), Y(51), 80, 22], 1, [""])
    gate_auto_x = pb.obj("gate", [X(0), Y(52), 40, 22], 2, [""])
    load_now = pb.obj("t b", [X(0), Y(53), 30, 22], 1, ["bang"])
    guard = pb.obj("sel 0", [X(0), Y(54), 45, 22], 2, ["bang", ""])
    guard_b = pb.obj("t b", [X(0), Y(55), 30, 22], 1, ["bang"])
    clip_x = pb.obj("clip 1 1", [X(0), Y(56), 60, 22], 3, ["int"])
    file_tbi = pb.obj("t b i", [X(0), Y(57), 45, 22], 1, ["bang", "int"])
    nth_x = pb.obj(f"zl nth @zlmaxsize {MAX_ITEMS}", [X(0), Y(58), 140, 22], 2, ["", ""])
    join_file = pb.obj("sprintf symout %s/%s", [X(0), Y(59), 130, 22], 2, [""])
    out_t = pb.obj("t s s", [X(0), Y(60), 45, 22], 1, ["", ""])
    set_loaded = pb.obj("prepend set loaded:", [X(1), Y(60), 120, 22], 1, [""])
    send_path = pb.obj(f"s {PATH_SEND}", [X(0), Y(61), 160, 22], 1, [])

    pb.connect(file_num, 0, file_ti, 0)
    pb.connect(file_menu, 0, file_setmenu_in := pb.obj("+ 1", [X(1), Y(49), 40, 22], 2, ["int"]), 0)
    pb.connect(file_setmenu_in, 0, file_num, 0)
    pb.connect(file_ti, 1, file_idx, 1)
    pb.connect(file_ti, 1, file_setmenu, 0)
    pb.connect(file_setmenu, 0, file_setmsg, 0)
    pb.connect(file_setmsg, 0, file_menu, 0)
    pb.connect(file_ti, 0, gate_auto_x, 1)
    pb.connect(auto_int, 0, gate_auto_x, 0)
    pb.connect(gate_auto_x, 0, load_now, 0)
    pb.connect(gate_auto_f, 0, load_now, 0)
    pb.connect(load_btn, 0, load_now, 0)
    pb.connect(load_now, 0, arm_gate, 1)
    pb.connect(arm_gate, 0, cnt_x, 0)         # how many files? 0 -> nothing to load
    pb.connect(cnt_x, 0, guard, 0)
    pb.connect(guard, 1, guard_b, 0)
    pb.connect(guard_b, 0, file_idx, 0)
    pb.connect(file_idx, 0, clip_x, 0)
    pb.connect(len_x, 0, clip_x, 2)
    pb.connect(clip_x, 0, file_tbi, 0)
    pb.connect(file_tbi, 1, nth_x, 1)
    pb.connect(file_tbi, 0, reg_x, 0)
    pb.connect(reg_x, 0, nth_x, 0)
    pb.connect(nth_x, 0, join_file, 0)
    pb.connect(fp_t, 3, join_file, 1)         # folder path in the cold inlet
    pb.connect(join_file, 0, out_t, 0)
    pb.connect(out_t, 1, set_loaded, 0)
    pb.connect(set_loaded, 0, loaded, 0)
    pb.connect(out_t, 0, send_path, 0)

    # ---- random file in the current folder --------------------------------------------------
    rnd_t = pb.obj("t b b", [X(2), Y(50), 45, 22], 1, ["bang", "bang"])
    rnd = pb.obj("random 1", [X(2), Y(51), 70, 22], 2, ["int"])
    rnd_plus = pb.obj("+ 1", [X(2), Y(52), 40, 22], 2, ["int"])
    rnd_tii = pb.obj("t b i i", [X(2), Y(53), 60, 22], 1, ["bang", "int", "int"])
    rnd_setnum = pb.obj("prepend set", [X(3), Y(53), 80, 22], 1, [""])
    pb.connect(random_btn, 0, rnd_t, 0)
    pb.connect(rnd_t, 1, cnt_r, 0)
    pb.connect(cnt_r, 0, rnd, 1)
    pb.connect(rnd_t, 0, rnd, 0)
    pb.connect(rnd, 0, rnd_plus, 0)
    pb.connect(rnd_plus, 0, rnd_tii, 0)
    pb.connect(rnd_tii, 2, rnd_setnum, 0)
    pb.connect(rnd_setnum, 0, file_num, 0)
    pb.connect(rnd_tii, 2, file_setmenu, 0)
    pb.connect(rnd_tii, 1, file_idx, 1)
    pb.connect(rnd_tii, 0, load_now, 0)

    # ---- Push bank registration (manual, for the paste-in case) --------------------------------
    pb.comment("Push banks: click once after pasting into a device that already has banks, then save the device. "
               "(The tester registers its banks automatically when none exist.)",
               [X(4), Y(32), 620, 34], fontsize=10.0)
    reg_msg = pb.msg("REGISTER PUSH BANKS", [X(4), Y(34), 150, 22])
    manual_t = pb.obj("t b b", [X(4), Y(35), 45, 22], 1, ["bang", "bang"])
    manual_mode = pb.msg("2", [X(4) + 60, Y(35), 30, 22])
    auto_in = pb.obj("t b b", [X(6), Y(34), 45, 22], 1, ["bang", "bang"])
    auto_mode = pb.msg("1", [X(6) + 60, Y(35), 30, 22])
    getcount = pb.msg("getcount", [X(4), Y(36), 65, 22])
    banks = pb.obj("live.banks", [X(4), Y(42), 70, 22], 1, [""])
    r_count = pb.obj("route count", [X(5), Y(36), 80, 22], 2, ["", ""])
    mode_gate = pb.obj("gate 2", [X(5), Y(37), 60, 22], 2, ["", ""])
    only_if_none = pb.obj("sel 0", [X(5), Y(38), 45, 22], 2, ["bang", ""])
    zero_bank = pb.msg("0", [X(5), Y(39), 30, 22])
    defer = pb.obj("deferlow", [X(5) + 80, Y(38), 60, 22], 1, [""])
    bank_t = pb.obj("t i i", [X(5), Y(40), 45, 22], 1, ["int", "int"])
    bank_plus = pb.obj("+ 1", [X(5) + 60, Y(41), 40, 22], 2, ["int"])
    new_main = pb.obj("sprintf new %d " + " ".join(f'"{p}"' for p in [BANK_MAIN[0], *BANK_MAIN[1]]),
                      [X(5), Y(42), 620, 22], 1, [""])
    new_setup = pb.obj("sprintf new %d " + " ".join(f'"{p}"' for p in [BANK_SETUP[0], *BANK_SETUP[1]]),
                       [X(5), Y(43), 300, 22], 1, [""])
    pb.comment("<- auto: bang here on load registers the banks only if the device has none",
               [X(6) + 50, Y(34), 420, 20], fontsize=9.0)
    # manual: append the banks after the existing ones
    pb.connect(reg_msg, 0, manual_t, 0)
    pb.connect(manual_t, 1, manual_mode, 0)
    pb.connect(manual_mode, 0, mode_gate, 0)
    pb.connect(manual_t, 0, getcount, 0)
    # auto: only when the device has no banks at all
    pb.connect(auto_in, 1, auto_mode, 0)
    pb.connect(auto_mode, 0, mode_gate, 0)
    pb.connect(auto_in, 0, getcount, 0)
    pb.connect(getcount, 0, banks, 0)
    pb.connect(banks, 0, r_count, 0)
    pb.connect(r_count, 0, mode_gate, 1)
    pb.connect(mode_gate, 0, only_if_none, 0)
    pb.connect(only_if_none, 0, zero_bank, 0)
    pb.connect(zero_bank, 0, defer, 0)
    pb.connect(mode_gate, 1, defer, 0)
    pb.connect(defer, 0, bank_t, 0)
    pb.connect(bank_t, 1, new_main, 0)
    pb.connect(bank_t, 0, bank_plus, 0)
    pb.connect(bank_plus, 0, new_setup, 0)
    pb.connect(new_main, 0, banks, 0)
    pb.connect(new_setup, 0, banks, 0)

    return {"thisdevice": thisdevice, "auto_banks": auto_in, "loadbang": loadbang}


def parameters_block(boxes: list[dict], banks: list[tuple[str, list[str]]], existing: dict | None = None,
                     first_index: int = 0) -> dict:
    """The patcher-level "parameters" map: one entry per parameter object plus the Push banks."""
    params = dict(existing or {})
    for b in boxes:
        bx = b["box"]
        v = bx.get("saved_attribute_attributes", {}).get("valueof", {})
        if "parameter_longname" in v:
            params[bx["id"]] = [v["parameter_longname"], v["parameter_shortname"], 0]
    pbanks = dict(params.get("parameterbanks", {}))
    for i, (name, names) in enumerate(banks):
        idx = first_index + i
        pbanks[str(idx)] = {"index": idx, "name": name, "parameters": (list(names) + [""] * 8)[:8]}
    params["parameterbanks"] = pbanks
    params.setdefault("inherited_shortname", 1)
    return params


# --------------------------------------------------------------------------- module patcher

def build_module() -> dict:
    pb = PatcherBuilder()
    pb.comment(
        "HOW TO USE IN GRANULATOR III: Select All, Copy, paste into the Granulator III patcher. "
        f"Then add [r {PATH_SEND}] and connect it to the SAME inlet the live.drop outlet feeds "
        "(the object that receives the dropped file path). Click REGISTER PUSH BANKS once, save the device.",
        [20, 15, 1000, 34], fontsize=11.0,
    )
    add_picker(pb, 20, 60, present=False)
    patcher = pb.patcher([60, 80, 1300, 2100])
    patcher["dependency_cache"] = []
    patcher["autosave"] = 0
    return {"patcher": patcher}


# --------------------------------------------------------------------------- tester device

def build_tester() -> dict:
    pb = PatcherBuilder()

    # presentation layout (device strip is 169 px tall)
    prects = {
        "root": [8, 22, 100, 15],
        "path": [114, 19, 230, 22],
        "rescan": [350, 18, 24, 24],
        "folder_menu": [8, 48, 140, 22],
        "folder": [154, 52, 44, 15],
        "file_menu": [206, 48, 140, 22],
        "file": [352, 52, 44, 15],
        "load": [8, 80, 24, 24],
        "auto": [72, 84, 15, 15],
        "random": [128, 80, 24, 24],
        "folders": [206, 84, 44, 15],
        "files": [300, 84, 44, 15],
        "resolved": [8, 112, 400, 18],
        "loaded": [8, 132, 400, 18],
    }
    pb.comment(TESTER_NAME, [20, 15, 160, 24], presentation=1, presentation_rect=[8, 2, 160, 20],
               fontsize=13.0, fontface=1)
    pb.comment("MIDI notes play the loaded file (C3 = original pitch)", [190, 15, 300, 20],
               presentation=1, presentation_rect=[170, 4, 300, 18], fontsize=9.0)
    for text, rect in (("Rescan", [378, 22, 50, 18]), ("Load", [34, 86, 40, 18]), ("Auto", [88, 84, 40, 18]),
                       ("Random", [154, 86, 50, 18]), ("Folders", [252, 84, 50, 18]), ("Files", [346, 84, 40, 18])):
        pb.comment(text, [0, 0, 50, 18], presentation=1, presentation_rect=rect, fontsize=9.0)

    ids = add_picker(pb, 20, 60, present=True, prect_of=lambda k: prects[k])

    # ---- the host side: receive the path, load the buffer, play it -------------------------
    x0, y0 = 1100, 60
    pb.comment("HOST SIDE (this is what Granulator III does with a dropped file)", [x0, y0, 420, 20],
               fontsize=11.0, fontface=1)
    recv = pb.obj(f"r {PATH_SEND}", [x0, y0 + 30, 160, 22], 0, [""])
    rep = pb.obj("prepend replace", [x0, y0 + 60, 100, 22], 1, [""])
    buf = pb.obj("buffer~ ---smp", [x0, y0 + 90, 100, 22], 1, ["float", "bang"])
    info = pb.obj("info~ ---smp", [x0, y0 + 120, 100, 22], 1,
                  ["float", "float", "int", "int", "float", "", "", "", "", ""])
    pb.connect(recv, 0, rep, 0)
    pb.connect(rep, 0, buf, 0)
    loaded_t = pb.obj("t b b", [x0, y0 + 150, 45, 22], 1, ["bang", "bang"])
    pb.connect(buf, 1, loaded_t, 0)
    pb.connect(loaded_t, 1, info, 0)          # loop end first ...

    notein = pb.obj("notein", [x0 + 250, y0 + 30, 60, 22], 1, ["int", "int", "int"])
    strip = pb.obj("stripnote", [x0 + 250, y0 + 60, 70, 22], 2, ["int", "int"])
    t_bi = pb.obj("t b i", [x0 + 250, y0 + 90, 45, 22], 1, ["bang", "int"])
    rate = pb.obj("expr pow(2., ($i1 - 60) / 12.)", [x0 + 250, y0 + 120, 170, 22], 1, ["float"])
    sig = pb.obj("sig~ 1.", [x0 + 250, y0 + 150, 50, 22], 1, ["signal"])
    startloop = pb.msg("startloop", [x0 + 250, y0 + 180, 65, 22])
    loop_on = pb.msg("loop 1", [x0 + 330, y0 + 180, 50, 22])
    loop_start = pb.msg("0", [x0 + 390, y0 + 180, 30, 22])
    groove = pb.obj("groove~ ---smp 2", [x0 + 250, y0 + 220, 110, 22], 3, ["signal", "signal", "signal"])
    gain = pb.add(
        "live.gain~", [x0 + 250, y0 + 260, 60, 130], numinlets=2, numoutlets=5,
        outlettype=["signal", "signal", "", "float", "list"],
        presentation=1, presentation_rect=[560, 4, 56, 160],
        **live_param("Gain", "Gain", parameter_type=0, parameter_mmin=-70.0, parameter_mmax=6.0,
                     parameter_initial_enable=1, parameter_initial=[0.0], parameter_unitstyle=4),
    )
    plugout = pb.obj("plugout~", [x0 + 250, y0 + 410, 70, 22], 2, ["signal", "signal"])
    pb.connect(notein, 0, strip, 0)
    pb.connect(notein, 1, strip, 1)
    pb.connect(strip, 0, t_bi, 0)             # note-ons only
    pb.connect(t_bi, 1, rate, 0)
    pb.connect(rate, 0, sig, 0)
    pb.connect(t_bi, 0, startloop, 0)
    pb.connect(sig, 0, groove, 0)
    pb.connect(startloop, 0, groove, 0)
    pb.connect(ids["loadbang"], 0, loop_on, 0)
    pb.connect(ids["loadbang"], 0, loop_start, 0)
    pb.connect(loop_on, 0, groove, 0)
    pb.connect(loop_start, 0, groove, 1)
    pb.connect(info, 1, groove, 2)            # length in ms -> loop end
    pb.connect(loaded_t, 0, startloop, 0)     # ... then play the new file from the start
    pb.connect(groove, 0, gain, 0)
    pb.connect(groove, 1, gain, 1)
    pb.connect(gain, 0, plugout, 0)
    pb.connect(gain, 1, plugout, 1)

    # ---- Push banks: register on load if the device has none (Pumper-style) -------------
    pb.connect(ids["thisdevice"], 0, ids["auto_banks"], 0)

    patcher = pb.patcher([60, 80, 1700, 2100], openinpresentation=1)
    patcher["dependency_cache"] = []
    patcher["autosave"] = 0
    patcher["parameters"] = parameters_block(
        pb.boxes, [BANK_MAIN, (BANK_SETUP[0], [*BANK_SETUP[1], "Gain"])])
    return {"patcher": patcher}


# --------------------------------------------------------------------------- Granulator III

GRANULATOR_OUT = "Granulator III Push.amxd"
GRANULATOR_BANKS_FROM = 8  # the stock device has banks 0..7


def read_frozen(raw: bytes) -> tuple[bytes, list[dict]]:
    """Parse a *frozen* .amxd (device with embedded dependencies).

    Layout inside the "ptch" chunk:
      "mx@c" | u32be 16 | u32be 0 | u32be dir_offset
      <data of every embedded file, back to back, starting at offset 16>
      "dlst" | u32be len | ("dire" | u32be len | fields...)*
    Each "dire" holds fields "type", "fnam", "sz32", "of32", "vers", "flag", "mdat"
    as  tag | u32be len (incl. this 8-byte header) | value.  Offsets are relative
    to the start of the "mx@c" header.  The first entry is the device patcher.
    Returns (outer 32-byte header, entries) where every entry has its raw
    directory bytes and its data.
    """
    assert raw[:4] == b"ampf" and raw[24:28] == b"ptch", "not an .amxd file"
    size = struct.unpack("<I", raw[28:32])[0]
    pl = raw[32:32 + size]
    assert pl[:4] == b"mx@c", "not a frozen device (no mx@c header)"
    dir_off = struct.unpack(">I", pl[12:16])[0]
    assert pl[dir_off:dir_off + 4] == b"dlst"
    dl = struct.unpack(">I", pl[dir_off + 4:dir_off + 8])[0]
    dlst = pl[dir_off + 8:dir_off + dl]
    entries = []
    j = 0
    while j < len(dlst):
        assert dlst[j:j + 4] == b"dire"
        el = struct.unpack(">I", dlst[j + 4:j + 8])[0]
        e = dlst[j:j + el]
        j += el
        fields = {}
        m = 8
        while m < len(e):
            tag = e[m:m + 4]
            fl = struct.unpack(">I", e[m + 4:m + 8])[0]
            fields[tag] = (m + 8, e[m + 8:m + fl])
            m += fl
        sz = struct.unpack(">I", fields[b"sz32"][1])[0]
        of = struct.unpack(">I", fields[b"of32"][1])[0]
        entries.append({
            "name": fields[b"fnam"][1].rstrip(b"\0").decode("utf-8"),
            "dire": e,
            "sz_pos": fields[b"sz32"][0],
            "of_pos": fields[b"of32"][0],
            "data": pl[of:of + sz],
        })
    return raw[:32], entries


def write_frozen(entries: list[dict], device_type: bytes = b"iiii") -> bytes:
    data = b""
    dires = b""
    for e in entries:
        of = 16 + len(data)
        data += e["data"]
        d = bytearray(e["dire"])
        d[e["sz_pos"]:e["sz_pos"] + 4] = struct.pack(">I", len(e["data"]))
        d[e["of_pos"]:e["of_pos"] + 4] = struct.pack(">I", of)
        dires += bytes(d)
    dir_off = 16 + len(data)
    payload = (b"mx@c" + struct.pack(">III", 16, 0, dir_off) + data
               + b"dlst" + struct.pack(">I", 8 + len(dires)) + dires)
    header = (
        b"ampf" + struct.pack("<I", 4) + device_type
        + b"meta" + struct.pack("<I", 4) + struct.pack("<I", 7)
        + b"ptch" + struct.pack("<I", len(payload))
    )
    return header + payload


def patch_granulator(doc: dict) -> dict:
    """Add the picker to the Granulator III main patcher (in place) and return it."""
    p = doc["patcher"]
    boxes = {b["box"]["id"]: b["box"] for b in p["boxes"]}

    # the two objects we hook into
    drop = next(i for i, b in boxes.items() if b["maxclass"] == "live.drop")
    filehandling = next(i for i, b in boxes.items() if b.get("text") == "p FileHandling")
    for l in p["lines"]:
        s_, d_ = l["patchline"]["source"], l["patchline"]["destination"]
        if s_[0] == drop and d_[0] == filehandling:
            break
    else:
        raise SystemExit("live.drop -> p FileHandling connection not found; is this Granulator III?")
    names = {b.get("saved_attribute_attributes", {}).get("valueof", {}).get("parameter_longname")
             for b in boxes.values()}
    clash = names & {P_FOLDER, P_FILE, P_LOAD, P_AUTO, P_RANDOM, P_RESCAN, P_FOLDERS, P_FILES, P_ROOT}
    assert not clash, f"parameter names already used: {clash}"

    pb = PatcherBuilder()
    pb._n = max(int(i.split("-")[1]) for i in boxes)  # new ids continue after the existing ones
    max_y = max(b["patching_rect"][1] + b["patching_rect"][3] for b in boxes.values())
    x0, y0 = 30, max_y + 120

    # presentation: a new column to the right of the stock UI (device gets wider)
    col = float(p["devicewidth"]) + 6
    p["devicewidth"] = col + 259
    prects = {
        "root": [col, 24, 100, 15],
        "path": [col + 104, 21, 122, 20],
        "rescan": [col + 230, 19, 20, 20],
        "folder_menu": [col, 48, 150, 20],
        "folder": [col + 156, 51, 44, 15],
        "file_menu": [col, 74, 150, 20],
        "file": [col + 156, 77, 44, 15],
        "load": [col, 100, 20, 20],
        "auto": [col + 60, 103, 15, 15],
        "random": [col + 110, 100, 20, 20],
        "folders": [col + 156, 103, 44, 15],
        "files": [col + 206, 103, 44, 15],
        "resolved": [col, 126, 250, 18],
        "loaded": [col, 146, 250, 18],
    }
    pb.add("panel", [x0, y0 - 100, 260, 169], numinlets=1, numoutlets=0, presentation=1,
           presentation_rect=[col - 3, 0, 262, 169], bgfillcolor_type="color",
           bgfillcolor_color=[0.13, 0.13, 0.13, 1.0], bgfillcolor_color1=[0.13, 0.13, 0.13, 1.0],
           bgfillcolor_color2=[0.13, 0.13, 0.13, 1.0], rounded=0)
    pb.comment("Push Sample", [x0 + 270, y0 - 100, 100, 20], presentation=1,
               presentation_rect=[col, 3, 100, 18], fontsize=11.0, fontface=1,
               textcolor=[0.9, 0.9, 0.9, 1.0])
    for text, rect in (("Rescan", [col + 205, 21, 24, 18]), ("Load", [col + 22, 102, 34, 18]),
                       ("Auto", [col + 76, 102, 32, 18]), ("Rnd", [col + 132, 102, 24, 18]),
                       ("Fld", [col + 200, 79, 24, 18]), ("File", [col + 200, 53, 24, 18])):
        pb.comment(text, [x0 + 270, y0 - 80, 50, 18], presentation=1, presentation_rect=rect,
                   fontsize=9.0, textcolor=[0.8, 0.8, 0.8, 1.0])
    pb.comment("Push Sample Picker (added): Select folder / file with the Smp parameters, "
               "the path goes to p FileHandling exactly like a dropped file.",
               [x0, y0 - 40, 900, 20], fontsize=11.0, fontface=1)
    add_picker(pb, x0, y0, present=True, prect_of=lambda k: prects[k])

    # hook: receive the path, store it in live.drop (so the Set / preset remembers it) and load it
    recv = pb.obj(f"r {PATH_SEND}", [x0 + 700, y0 - 100, 160, 22], 0, [""])
    t_ss = pb.obj("t s s", [x0 + 700, y0 - 70, 45, 22], 1, ["", ""])
    set_drop = pb.obj("prepend set", [x0 + 760, y0 - 40, 80, 22], 1, [""])
    pb.connect(recv, 0, t_ss, 0)
    pb.connect(t_ss, 1, set_drop, 0)
    pb.connect(set_drop, 0, drop, 0)
    pb.connect(t_ss, 0, filehandling, 0)

    p["boxes"].extend(pb.boxes)
    p["lines"].extend(pb.lines)
    p["parameters"] = parameters_block(pb.boxes, [BANK_MAIN, BANK_SETUP], existing=p["parameters"],
                                       first_index=GRANULATOR_BANKS_FROM)
    return doc


def build_granulator(orig: Path, out: Path) -> None:
    header, entries = read_frozen(orig.read_bytes())
    assert entries[0]["name"].endswith(".amxd"), entries[0]["name"]
    raw_json = entries[0]["data"]
    doc = json.loads(raw_json[:raw_json.rfind(b"}") + 1].decode("utf-8"))
    patch_granulator(doc)
    text = json.dumps(doc, indent="\t", ensure_ascii=False) + "\n"
    entries[0]["data"] = text.encode("utf-8") + b"\x00"
    out.write_bytes(write_frozen(entries, header[8:12]))
    p = doc["patcher"]
    print(f"wrote {out.name} ({len(p['boxes'])} boxes, {len(p['lines'])} connections, "
          f"{len(entries)} embedded files, devicewidth {p['devicewidth']})")


# --------------------------------------------------------------------------- .amxd container

def pack_amxd(patcher_json: str, device_type: bytes = b"iiii") -> bytes:
    """Wrap patcher JSON in the .amxd container (layout Max 8 writes).

      "ampf" | u32le 4 | type ("aaaa" audio fx / "iiii" instrument / "mmmm" midi fx)
      "meta" | u32le 4 | u32le 0
      "ptch" | u32le size | <json utf-8> NUL
    """
    payload = patcher_json.encode("utf-8") + b"\x00"
    header = (
        b"ampf" + struct.pack("<I", 4) + device_type
        + b"meta" + struct.pack("<I", 4) + struct.pack("<I", 0)
        + b"ptch" + struct.pack("<I", len(payload))
    )
    return header + payload


def main() -> None:
    import argparse

    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--granulator", metavar="AMXD", type=Path,
                    help="path to your copy of Granulator III.amxd; writes 'Granulator III Push.amxd' next to it")
    args = ap.parse_args()

    module = build_module()
    text = json.dumps(module, indent="\t", ensure_ascii=False) + "\n"
    (HERE / f"{MODULE_NAME}.maxpat").write_text(text, encoding="utf-8")
    print(f"wrote {MODULE_NAME}.maxpat ({len(module['patcher']['boxes'])} boxes, "
          f"{len(module['patcher']['lines'])} connections)")

    tester = build_tester()
    text = json.dumps(tester, indent="\t", ensure_ascii=False) + "\n"
    (HERE / f"{TESTER_NAME}.maxpat").write_text(text, encoding="utf-8")
    (HERE / f"{TESTER_NAME}.amxd").write_bytes(pack_amxd(text, b"iiii"))
    print(f"wrote {TESTER_NAME}.maxpat and {TESTER_NAME}.amxd ({len(tester['patcher']['boxes'])} boxes, "
          f"{len(tester['patcher']['lines'])} connections)")

    if args.granulator:
        build_granulator(args.granulator, args.granulator.parent / GRANULATOR_OUT)


if __name__ == "__main__":
    main()
