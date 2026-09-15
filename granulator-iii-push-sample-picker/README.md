# Push Sample Picker — changing Granulator III's sample from Push 3 standalone

Granulator III (the Max for Live instrument that ships with Live 12) runs on
Push 3 standalone, but you cannot change its sample there: the device loads
samples through its drop area (`live.drop`) and the file dialog, and neither
exists on Push. You can only play presets whose sample was set on the computer.

This folder is an exploration of the obvious fix: **add a small, stock-objects-
only "file picker" to the device whose controls are ordinary Live parameters**,
so the sample can be chosen from the Push encoders. The picker lists the sample
folders on the Push, lists the files in the chosen folder, and hands the chosen
file path to the device's `buffer~` — exactly what the drop area does on the
computer. A community mod for Granulator III already works this way (samples in
`User Library/Samples/Folders/<set>/`, Folder / Sample / Load / Reload / Random
dials on a second bank), which is good evidence the approach holds up on Push.

Granulator III itself is Ableton's copyrighted device and is not in this repo.
Everything here is generated from `build.py` and is meant to be pasted into
your own copy of the device (Live lets you edit any Max for Live device and save
it to your User Library).

## Files

| File | What it is |
| --- | --- |
| `build.py` | Generates the three files below from scratch. `python3 build.py` |
| `PushSamplePicker.maxpat` | The picker on its own, laid out for **Select All → Copy → Paste** into Granulator III. |
| `PushSampleTester.amxd` | A tiny instrument (`buffer~` + `groove~`) with the picker already wired in. Put it on Push first to verify folder scanning and sample loading work on your unit before touching Granulator III. |
| `PushSampleTester.maxpat` | Same as a plain Max patcher. |

Stock Max objects only (`folder`, `regexp`, `zl`, `sprintf`, `live.*`,
`buffer~`, …): no `js`, no externals, so it loads on desktop Live and on Push 3
standalone.

## The parameters (what you see on Push)

Bank **Sample**:

| Control | What it does |
| --- | --- |
| **Folder** | Index (1…) of the sub-folder inside the sample root. Changing it lists that folder's files. |
| **File** | Index (1…) of the file inside the chosen folder. |
| **Load** | Loads the selected file now. |
| **Auto** | When on (default), the file is loaded as soon as *File* or *Folder* changes, so you can scroll through samples with one encoder. |
| **Random** | Picks a random file in the current folder and loads it. |
| **Rescan** | Re-reads the folders and files (after you copied new samples to the Push). |
| **Folders** / **Files** | Read-outs: how many sub-folders / files were found. On Push this is your only feedback that the path is right, so if both say 0 the root is wrong. |

Bank **Sample Setup**:

| Control | What it does |
| --- | --- |
| **Root** | Where the sample root is: *Next to device* (`<device folder>/<sub-path>`), *User Library* (three folders up from the device, i.e. `User Library/<sub-path>` when the device is saved under `User Library/Presets/Instruments/Max Instrument/`), or *Custom path* (the text field is used as-is, e.g. an absolute path). |

On the computer there is also a text field for the sub-path (default
`Samples/Folders`), two menus showing the folder and file names, and two lines
of status (the resolved root and the last loaded file). The sub-path is stored
with the Live Set (`pattr` in parameter mode) and with the device when you save
it from the Max editor.

Push shows numbers, not file names, so name your files with a number prefix
(`01 kick.wav`, `02 snare.wav`, …); the picker sorts each list alphabetically.
Recognised extensions: wav, aif/aiff, flac, mp3, ogg. Hidden files (`.` prefix,
e.g. macOS `._foo.wav` sidecars) are skipped.

## Folder layout on the Push

Using the *User Library* root (the default), put your samples in

```
User Library/
  Samples/
    Folders/
      Drones/       01 drone.wav  02 drone.wav ...
      Textures/     ...
```

Transfer the `Folders` tree with Live's browser (*Places → Push 3 → User
Library → Samples*). If the root has no sub-folders at all, the picker treats
the root itself as the file folder (`Folders` shows 0, `Files` shows the count).

## Try it first with the tester

1. `python3 build.py`, then drop `PushSampleTester.amxd` on a MIDI track in Live.
   With samples under `User Library/Samples/Folders/...` it should show the
   folder count immediately; pick a folder and file, play a note (C3 = original
   pitch, the file loops).
2. Copy the device to the Push (drag it into *Places → Push 3 → User Library →
   Presets*), load it there, and check the *Folders* / *Files* read-outs on the
   *Sample* bank. Turn *Folder* and *File*, play a pad. If the counts stay at 0,
   try the other *Root* choices on the *Sample Setup* bank; the one that gives
   a non-zero count tells you how paths resolve on the Push.

## Putting it into Granulator III

1. In Live, drop Granulator III on a track and click its **Edit** button (the
   Max editor opens). Immediately *File → Save As…* into your User Library
   (e.g. `Granulator III Push.amxd`) so the original stays untouched.
2. *File → Open…* `PushSamplePicker.maxpat`, **Select All**, **Copy**, switch to
   the Granulator III patcher and **Paste**. The pasted objects are not in
   presentation mode, so nothing lands on top of the device UI.
3. Find the object that Granulator III's `live.drop` outlet connects to (the
   object that receives the dropped file's path; it feeds the `buffer~` via a
   `replace` message and probably updates the file-name display and waveform
   too). Add a `[r ---push_sample_path]` object and connect its outlet to that
   **same inlet**. That's the whole integration: the picker outputs the file
   path exactly like `live.drop` does.
4. Click the **REGISTER PUSH BANKS** message box once. It appends two banks
   (*Sample*, *Sample Setup*) after Granulator III's existing Push banks.
   Alternatively add them by hand in the Max editor's *Parameters* window
   (*Banks* tab).
5. Save the device, then copy it to the Push like any other Max for Live device.

The parameter names are prefixed (`Smp Folder`, `Smp File`, …) so they cannot
collide with Granulator III's own parameters; Push shows the short names
(*Folder*, *File*, …).

## What still needs checking on real hardware

These are the assumptions the exploration rests on; each is easy to verify with
the tester and the *Folders* / *Files* read-outs:

* `thispatcher path` returns the device's folder on Push (used by the
  *Next to device* and *User Library* roots). If it does not, use *Custom path*
  with the absolute path of the Push's User Library (find it once with the
  tester on the computer connected to the Push, or from the status line on the
  desktop).
* `folder` lists directories with `types fold` and files without a type filter
  on the Push's Linux file system (the community mod suggests yes).
* `buffer~ replace <absolute path>` loads on Push (the community mod relies on
  it, so this should be fine).
* `zl sort` orders symbols alphabetically; if not, files come in file-system
  order and the number prefix trick still keeps things predictable on desktop.
* Push shows `live.numbox` integer parameters and `live.button` triggers on the
  encoders (Pumper already uses `live.button` this way).
* How Granulator III reacts to a new sample while grains are playing is
  Granulator III's business; on the desktop the drop area does the same thing.

## Ideas for the next iteration

* A **Next / Prev** pair of buttons instead of the *File* index, so one encoder
  turn steps through the folder without overshooting.
* Show the file **name** on Push: Push can only display parameter names and
  values, so the trick would be a `live.menu` parameter whose enum is rebuilt
  from the file list. `live.menu` items are fixed at design time, so this needs
  a fixed slot count (e.g. 64 entries) and re-labelling is not possible at
  run-time; the numeric index is the honest fallback.
* Save the picked file path with the preset (a second invisible `pattr`) and
  reload it on the Push when the Set opens, so a Set built on Push recalls its
  samples without the computer.

Sources used for the Push facts:
[Max for Live devices on Push 3 (standalone) – Ableton](https://help.ableton.com/hc/en-us/articles/8506527153308-Max-for-Live-Devices-on-Push-3-standalone),
[Granulator 3 on Push 3 standalone – Ableton forum](https://forum.ableton.com/viewtopic.php?t=249450),
[Push 3 SA Granulator 3 – how to load samples – Ableton forum](https://forum.ableton.com/viewtopic.php?t=250785),
[Push 3 Granulator 3 Sample Selector (community mod)](https://unavisionagradable.gumroad.com/l/kxbin),
[A guide to the Granulator III Sample Selector](https://lame.buanzo.org/max4live_blog/a-guide-to-the-granulator-iii-sample-selector-for-push-performance-enhancement.html),
[Making Max for Live devices work on Push 3 standalone – CDM](https://cdm.link/making-max-for-live-devices-work-on-push-and-push-3-standalone/).
