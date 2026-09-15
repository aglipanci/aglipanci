{
	"patcher": {
		"fileversion": 1,
		"appversion": {
			"major": 8,
			"minor": 6,
			"revision": 5,
			"architecture": "x64",
			"modernui": 1
		},
		"classnamespace": "box",
		"rect": [
			60.0,
			80.0,
			1300.0,
			2100.0
		],
		"bglocked": 0,
		"openinpresentation": 0,
		"default_fontsize": 12.0,
		"default_fontface": 0,
		"default_fontname": "Arial",
		"gridonopen": 1,
		"gridsize": [
			15.0,
			15.0
		],
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
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "comment",
					"patching_rect": [
						20.0,
						15.0,
						1000.0,
						34.0
					],
					"text": "HOW TO USE IN GRANULATOR III: Select All, Copy, paste into the Granulator III patcher. Then add [r ---push_sample_path] and connect it to the SAME inlet the live.drop outlet feeds (the object that receives the dropped file path). Click REGISTER PUSH BANKS once, save the device.",
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 11.0
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "comment",
					"patching_rect": [
						20.0,
						60.0,
						900.0,
						20.0
					],
					"text": "PUSH SAMPLE PICKER - picks a file in <root>/<sub-path>/<folder>/ and sends its path to [s ---push_sample_path]. Stock objects only (works on Push 3 standalone).",
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 11.0,
					"fontface": 1
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "comment",
					"patching_rect": [
						20.0,
						92.0,
						320.0,
						20.0
					],
					"text": "parameters (these show up on the Push encoders)",
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 10.0
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "live.menu",
					"patching_rect": [
						20.0,
						124.0,
						110.0,
						15.0
					],
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Smp Root",
							"parameter_shortname": "Root",
							"parameter_type": 2,
							"parameter_enum": [
								"Next to device",
								"User Library",
								"Custom path"
							],
							"parameter_mmax": 2,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								1
							],
							"parameter_unitstyle": 0
						}
					},
					"varname": "smp_root"
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "textedit",
					"patching_rect": [
						170.0,
						124.0,
						220.0,
						22.0
					],
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"int",
						"",
						""
					],
					"text": "Samples/Folders"
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "live.button",
					"patching_rect": [
						470.0,
						124.0,
						24.0,
						24.0
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Smp Rescan",
							"parameter_shortname": "Rescan",
							"parameter_type": 2,
							"parameter_enum": [
								"off",
								"on"
							],
							"parameter_mmax": 1,
							"parameter_unitstyle": 0
						}
					},
					"varname": "smp_rescan"
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "umenu",
					"patching_rect": [
						20.0,
						156.0,
						140.0,
						22.0
					],
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"int",
						"",
						""
					],
					"items": []
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "live.numbox",
					"patching_rect": [
						170.0,
						156.0,
						44.0,
						15.0
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Smp Folder",
							"parameter_shortname": "Folder",
							"parameter_type": 1,
							"parameter_mmin": 1.0,
							"parameter_mmax": 999.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								1.0
							],
							"parameter_unitstyle": 0
						}
					},
					"varname": "smp_folder"
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "umenu",
					"patching_rect": [
						320.0,
						156.0,
						140.0,
						22.0
					],
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"int",
						"",
						""
					],
					"items": []
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "live.numbox",
					"patching_rect": [
						470.0,
						156.0,
						44.0,
						15.0
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Smp File",
							"parameter_shortname": "File",
							"parameter_type": 1,
							"parameter_mmin": 1.0,
							"parameter_mmax": 999.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								1.0
							],
							"parameter_unitstyle": 0
						}
					},
					"varname": "smp_file"
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "live.button",
					"patching_rect": [
						20.0,
						188.0,
						24.0,
						24.0
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Smp Load",
							"parameter_shortname": "Load",
							"parameter_type": 2,
							"parameter_enum": [
								"off",
								"on"
							],
							"parameter_mmax": 1,
							"parameter_unitstyle": 0
						}
					},
					"varname": "smp_load"
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "live.toggle",
					"patching_rect": [
						60.0,
						188.0,
						15.0,
						15.0
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Smp Auto",
							"parameter_shortname": "Auto",
							"parameter_type": 2,
							"parameter_enum": [
								"off",
								"on"
							],
							"parameter_mmax": 1,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								1.0
							],
							"parameter_unitstyle": 0
						}
					},
					"varname": "smp_auto"
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "live.button",
					"patching_rect": [
						170.0,
						188.0,
						24.0,
						24.0
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Smp Random",
							"parameter_shortname": "Random",
							"parameter_type": 2,
							"parameter_enum": [
								"off",
								"on"
							],
							"parameter_mmax": 1,
							"parameter_unitstyle": 0
						}
					},
					"varname": "smp_random"
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "live.numbox",
					"patching_rect": [
						320.0,
						188.0,
						44.0,
						15.0
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Smp Folders",
							"parameter_shortname": "Folders",
							"parameter_type": 1,
							"parameter_mmin": 0.0,
							"parameter_mmax": 999.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							],
							"parameter_unitstyle": 0
						}
					},
					"varname": "smp_folders"
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "live.numbox",
					"patching_rect": [
						470.0,
						188.0,
						44.0,
						15.0
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Smp Files",
							"parameter_shortname": "Files",
							"parameter_type": 1,
							"parameter_mmin": 0.0,
							"parameter_mmax": 999.0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								0.0
							],
							"parameter_unitstyle": 0
						}
					},
					"varname": "smp_files"
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "comment",
					"patching_rect": [
						20.0,
						220.0,
						600.0,
						18.0
					],
					"text": "root: (not scanned yet)",
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9.0
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "comment",
					"patching_rect": [
						20.0,
						252.0,
						600.0,
						18.0
					],
					"text": "loaded: -",
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9.0
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "comment",
					"patching_rect": [
						20.0,
						284.0,
						460.0,
						20.0
					],
					"text": "sub-path: default / textedit / saved in the set (pattr in parameter mode)",
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 10.0
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						316.0,
						60.0,
						22.0
					],
					"text": "loadbang",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						348.0,
						60.0,
						22.0
					],
					"text": "t b b b",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"bang",
						"bang",
						"bang"
					]
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "message",
					"patching_rect": [
						20.0,
						380.0,
						110.0,
						22.0
					],
					"text": "Samples/Folders",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "newobj",
					"patching_rect": [
						170.0,
						348.0,
						60.0,
						22.0
					],
					"text": "tosymbol",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "newobj",
					"patching_rect": [
						170.0,
						380.0,
						200.0,
						22.0
					],
					"text": "pattr smp_subpath",
					"numinlets": 2,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Smp Subpath",
							"parameter_shortname": "Subpath",
							"parameter_type": 3,
							"parameter_invisible": 1
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "newobj",
					"patching_rect": [
						170.0,
						412.0,
						180.0,
						22.0
					],
					"text": "route symbol int float bang",
					"numinlets": 1,
					"numoutlets": 5,
					"outlettype": [
						"",
						"",
						"",
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "newobj",
					"patching_rect": [
						170.0,
						444.0,
						80.0,
						22.0
					],
					"text": "t b s s s",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"bang",
						"",
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "newobj",
					"patching_rect": [
						320.0,
						444.0,
						80.0,
						22.0
					],
					"text": "prepend set",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "newobj",
					"patching_rect": [
						470.0,
						316.0,
						100.0,
						22.0
					],
					"text": "live.thisdevice",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"bang",
						"int",
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "newobj",
					"patching_rect": [
						470.0,
						348.0,
						60.0,
						22.0
					],
					"text": "t b b b",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"bang",
						"bang",
						"bang"
					]
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "message",
					"patching_rect": [
						550.0,
						348.0,
						30.0,
						22.0
					],
					"text": "1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "newobj",
					"patching_rect": [
						550.0,
						380.0,
						40.0,
						22.0
					],
					"text": "gate",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "comment",
					"patching_rect": [
						600.0,
						348.0,
						520.0,
						20.0
					],
					"text": "no sample is loaded by the picker until the device finished loading (live.thisdevice), so a Set restores its own sample",
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9.0
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "comment",
					"patching_rect": [
						20.0,
						508.0,
						640.0,
						20.0
					],
					"text": "root folder: device folder (thispatcher), User Library (= 3 levels up), or the text as-is",
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 10.0
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "message",
					"patching_rect": [
						20.0,
						540.0,
						40.0,
						22.0
					],
					"text": "path",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-34",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						572.0,
						80.0,
						22.0
					],
					"text": "thispatcher",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-35",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						604.0,
						70.0,
						22.0
					],
					"text": "route path",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-36",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						636.0,
						45.0,
						22.0
					],
					"text": "t s s",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						668.0,
						60.0,
						22.0
					],
					"text": "zl reg",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-38",
					"maxclass": "newobj",
					"patching_rect": [
						170.0,
						636.0,
						230.0,
						22.0
					],
					"text": "regexp ^(.*)/[^/]+/[^/]+/[^/]+/?$",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-39",
					"maxclass": "newobj",
					"patching_rect": [
						170.0,
						668.0,
						60.0,
						22.0
					],
					"text": "zl reg",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "newobj",
					"patching_rect": [
						320.0,
						572.0,
						80.0,
						22.0
					],
					"text": "sel 0 1 2",
					"numinlets": 4,
					"numoutlets": 4,
					"outlettype": [
						"bang",
						"bang",
						"bang",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						700.0,
						130.0,
						22.0
					],
					"text": "sprintf symout %s/%s",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-42",
					"maxclass": "newobj",
					"patching_rect": [
						170.0,
						700.0,
						130.0,
						22.0
					],
					"text": "sprintf symout %s/%s",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-43",
					"maxclass": "newobj",
					"patching_rect": [
						320.0,
						700.0,
						140.0,
						22.0
					],
					"text": "zl reg @zlmaxsize 1024",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-44",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						732.0,
						140.0,
						22.0
					],
					"text": "zl reg @zlmaxsize 1024",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-45",
					"maxclass": "newobj",
					"patching_rect": [
						320.0,
						540.0,
						40.0,
						22.0
					],
					"text": "int",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-46",
					"maxclass": "newobj",
					"patching_rect": [
						320.0,
						508.0,
						45.0,
						22.0
					],
					"text": "t b i",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-47",
					"maxclass": "comment",
					"patching_rect": [
						470.0,
						508.0,
						560.0,
						20.0
					],
					"text": "rescan: [folder] lists the sub-folders (types fold), sorted, counted, into a umenu",
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 10.0
				}
			},
			{
				"box": {
					"id": "obj-48",
					"maxclass": "newobj",
					"patching_rect": [
						470.0,
						540.0,
						75.0,
						22.0
					],
					"text": "t b b b b",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"bang",
						"bang",
						"bang",
						"bang"
					]
				}
			},
			{
				"box": {
					"id": "obj-49",
					"maxclass": "newobj",
					"patching_rect": [
						720.0,
						540.0,
						40.0,
						22.0
					],
					"text": "int",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-50",
					"maxclass": "message",
					"patching_rect": [
						770.0,
						540.0,
						30.0,
						22.0
					],
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-51",
					"maxclass": "newobj",
					"patching_rect": [
						620.0,
						540.0,
						45.0,
						22.0
					],
					"text": "t b b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					]
				}
			},
			{
				"box": {
					"id": "obj-52",
					"maxclass": "message",
					"patching_rect": [
						620.0,
						572.0,
						30.0,
						22.0
					],
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-53",
					"maxclass": "message",
					"patching_rect": [
						660.0,
						572.0,
						55.0,
						22.0
					],
					"text": "zlclear",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-54",
					"maxclass": "newobj",
					"patching_rect": [
						470.0,
						764.0,
						90.0,
						22.0
					],
					"text": "t b b s s s",
					"numinlets": 1,
					"numoutlets": 5,
					"outlettype": [
						"bang",
						"bang",
						"",
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-55",
					"maxclass": "newobj",
					"patching_rect": [
						770.0,
						764.0,
						110.0,
						22.0
					],
					"text": "prepend set root:",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-56",
					"maxclass": "message",
					"patching_rect": [
						620.0,
						732.0,
						70.0,
						22.0
					],
					"text": "types fold",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-57",
					"maxclass": "newobj",
					"patching_rect": [
						620.0,
						796.0,
						60.0,
						22.0
					],
					"text": "folder",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-58",
					"maxclass": "newobj",
					"patching_rect": [
						620.0,
						828.0,
						120.0,
						22.0
					],
					"text": "route clear append",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-59",
					"maxclass": "newobj",
					"patching_rect": [
						620.0,
						860.0,
						120.0,
						22.0
					],
					"text": "regexp ^([^.].*)$",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-60",
					"maxclass": "newobj",
					"patching_rect": [
						620.0,
						892.0,
						190.0,
						22.0
					],
					"text": "zl group 1024 @zlmaxsize 1024",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-61",
					"maxclass": "newobj",
					"patching_rect": [
						620.0,
						924.0,
						150.0,
						22.0
					],
					"text": "zl sort @zlmaxsize 1024",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-62",
					"maxclass": "newobj",
					"patching_rect": [
						620.0,
						956.0,
						60.0,
						22.0
					],
					"text": "t l l l",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-63",
					"maxclass": "newobj",
					"patching_rect": [
						620.0,
						988.0,
						140.0,
						22.0
					],
					"text": "zl reg @zlmaxsize 1024",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-64",
					"maxclass": "newobj",
					"patching_rect": [
						770.0,
						988.0,
						140.0,
						22.0
					],
					"text": "zl len @zlmaxsize 1024",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"int",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-65",
					"maxclass": "newobj",
					"patching_rect": [
						770.0,
						1020.0,
						40.0,
						22.0
					],
					"text": "int",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-66",
					"maxclass": "message",
					"patching_rect": [
						920.0,
						988.0,
						40.0,
						22.0
					],
					"text": "clear",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-67",
					"maxclass": "newobj",
					"patching_rect": [
						920.0,
						1020.0,
						40.0,
						22.0
					],
					"text": "iter",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-68",
					"maxclass": "newobj",
					"patching_rect": [
						920.0,
						1052.0,
						100.0,
						22.0
					],
					"text": "prepend append",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-69",
					"maxclass": "newobj",
					"patching_rect": [
						470.0,
						796.0,
						30.0,
						22.0
					],
					"text": "t b",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					]
				}
			},
			{
				"box": {
					"id": "obj-70",
					"maxclass": "newobj",
					"patching_rect": [
						470.0,
						828.0,
						45.0,
						22.0
					],
					"text": "t i i",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"int",
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-71",
					"maxclass": "newobj",
					"patching_rect": [
						470.0,
						860.0,
						45.0,
						22.0
					],
					"text": "sel 0",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-72",
					"maxclass": "newobj",
					"patching_rect": [
						470.0,
						892.0,
						30.0,
						22.0
					],
					"text": "t b",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					]
				}
			},
			{
				"box": {
					"id": "obj-73",
					"maxclass": "newobj",
					"patching_rect": [
						470.0,
						924.0,
						140.0,
						22.0
					],
					"text": "zl reg @zlmaxsize 1024",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-74",
					"maxclass": "comment",
					"patching_rect": [
						20.0,
						1084.0,
						700.0,
						20.0
					],
					"text": "folder select: Folder param -> clip -> zl nth -> path -> [folder] lists files -> filter by extension",
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 10.0
				}
			},
			{
				"box": {
					"id": "obj-75",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1116.0,
						45.0,
						22.0
					],
					"text": "t i i",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"int",
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-76",
					"maxclass": "newobj",
					"patching_rect": [
						170.0,
						1116.0,
						40.0,
						22.0
					],
					"text": "- 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-77",
					"maxclass": "newobj",
					"patching_rect": [
						170.0,
						1148.0,
						80.0,
						22.0
					],
					"text": "prepend set",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-78",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1148.0,
						60.0,
						22.0
					],
					"text": "clip 1 1",
					"numinlets": 3,
					"numoutlets": 1,
					"outlettype": [
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-79",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1180.0,
						45.0,
						22.0
					],
					"text": "t b i",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-80",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1212.0,
						140.0,
						22.0
					],
					"text": "zl nth @zlmaxsize 1024",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-81",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1244.0,
						130.0,
						22.0
					],
					"text": "sprintf symout %s/%s",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-82",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1276.0,
						140.0,
						22.0
					],
					"text": "zl reg @zlmaxsize 1024",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-83",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1308.0,
						80.0,
						22.0
					],
					"text": "t b b s s",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"bang",
						"bang",
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-84",
					"maxclass": "newobj",
					"patching_rect": [
						170.0,
						1308.0,
						45.0,
						22.0
					],
					"text": "t b b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					]
				}
			},
			{
				"box": {
					"id": "obj-85",
					"maxclass": "message",
					"patching_rect": [
						170.0,
						1340.0,
						30.0,
						22.0
					],
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-86",
					"maxclass": "message",
					"patching_rect": [
						210.0,
						1340.0,
						55.0,
						22.0
					],
					"text": "zlclear",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-87",
					"maxclass": "newobj",
					"patching_rect": [
						320.0,
						1340.0,
						60.0,
						22.0
					],
					"text": "folder",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-88",
					"maxclass": "newobj",
					"patching_rect": [
						320.0,
						1372.0,
						120.0,
						22.0
					],
					"text": "route clear append",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-89",
					"maxclass": "newobj",
					"patching_rect": [
						320.0,
						1404.0,
						300.0,
						22.0
					],
					"text": "regexp (?i)^([^.].*[.](?:wav|aiff?|flac|mp3|ogg))$",
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"",
						"",
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-90",
					"maxclass": "newobj",
					"patching_rect": [
						320.0,
						1436.0,
						190.0,
						22.0
					],
					"text": "zl group 1024 @zlmaxsize 1024",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-91",
					"maxclass": "newobj",
					"patching_rect": [
						320.0,
						1468.0,
						150.0,
						22.0
					],
					"text": "zl sort @zlmaxsize 1024",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-92",
					"maxclass": "newobj",
					"patching_rect": [
						320.0,
						1500.0,
						60.0,
						22.0
					],
					"text": "t l l l",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-93",
					"maxclass": "newobj",
					"patching_rect": [
						320.0,
						1532.0,
						140.0,
						22.0
					],
					"text": "zl reg @zlmaxsize 1024",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-94",
					"maxclass": "newobj",
					"patching_rect": [
						470.0,
						1532.0,
						140.0,
						22.0
					],
					"text": "zl len @zlmaxsize 1024",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"int",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-95",
					"maxclass": "newobj",
					"patching_rect": [
						470.0,
						1564.0,
						40.0,
						22.0
					],
					"text": "int",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-96",
					"maxclass": "newobj",
					"patching_rect": [
						520.0,
						1564.0,
						40.0,
						22.0
					],
					"text": "int",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-97",
					"maxclass": "message",
					"patching_rect": [
						620.0,
						1532.0,
						40.0,
						22.0
					],
					"text": "clear",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-98",
					"maxclass": "newobj",
					"patching_rect": [
						620.0,
						1564.0,
						40.0,
						22.0
					],
					"text": "iter",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-99",
					"maxclass": "newobj",
					"patching_rect": [
						620.0,
						1596.0,
						100.0,
						22.0
					],
					"text": "prepend append",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-100",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1340.0,
						30.0,
						22.0
					],
					"text": "t b",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					]
				}
			},
			{
				"box": {
					"id": "obj-101",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1372.0,
						40.0,
						22.0
					],
					"text": "gate",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-102",
					"maxclass": "newobj",
					"patching_rect": [
						170.0,
						1084.0,
						40.0,
						22.0
					],
					"text": "+ 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-103",
					"maxclass": "comment",
					"patching_rect": [
						20.0,
						1628.0,
						640.0,
						20.0
					],
					"text": "load: File param (or Load / Random) -> clip -> zl nth -> <folder>/<file> -> [s ---push_sample_path]",
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 10.0
				}
			},
			{
				"box": {
					"id": "obj-104",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1660.0,
						45.0,
						22.0
					],
					"text": "t i i",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"int",
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-105",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1692.0,
						40.0,
						22.0
					],
					"text": "int",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-106",
					"maxclass": "newobj",
					"patching_rect": [
						170.0,
						1660.0,
						40.0,
						22.0
					],
					"text": "- 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-107",
					"maxclass": "newobj",
					"patching_rect": [
						170.0,
						1692.0,
						80.0,
						22.0
					],
					"text": "prepend set",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-108",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1724.0,
						40.0,
						22.0
					],
					"text": "gate",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-109",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1756.0,
						30.0,
						22.0
					],
					"text": "t b",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					]
				}
			},
			{
				"box": {
					"id": "obj-110",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1788.0,
						45.0,
						22.0
					],
					"text": "sel 0",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-111",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1820.0,
						30.0,
						22.0
					],
					"text": "t b",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					]
				}
			},
			{
				"box": {
					"id": "obj-112",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1852.0,
						60.0,
						22.0
					],
					"text": "clip 1 1",
					"numinlets": 3,
					"numoutlets": 1,
					"outlettype": [
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-113",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1884.0,
						45.0,
						22.0
					],
					"text": "t b i",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-114",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1916.0,
						140.0,
						22.0
					],
					"text": "zl nth @zlmaxsize 1024",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-115",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1948.0,
						130.0,
						22.0
					],
					"text": "sprintf symout %s/%s",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-116",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						1980.0,
						45.0,
						22.0
					],
					"text": "t s s",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-117",
					"maxclass": "newobj",
					"patching_rect": [
						170.0,
						1980.0,
						120.0,
						22.0
					],
					"text": "prepend set loaded:",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-118",
					"maxclass": "newobj",
					"patching_rect": [
						20.0,
						2012.0,
						160.0,
						22.0
					],
					"text": "s ---push_sample_path",
					"numinlets": 1,
					"numoutlets": 0,
					"outlettype": []
				}
			},
			{
				"box": {
					"id": "obj-119",
					"maxclass": "newobj",
					"patching_rect": [
						170.0,
						1628.0,
						40.0,
						22.0
					],
					"text": "+ 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-120",
					"maxclass": "newobj",
					"patching_rect": [
						320.0,
						1660.0,
						45.0,
						22.0
					],
					"text": "t b b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					]
				}
			},
			{
				"box": {
					"id": "obj-121",
					"maxclass": "newobj",
					"patching_rect": [
						320.0,
						1692.0,
						70.0,
						22.0
					],
					"text": "random 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-122",
					"maxclass": "newobj",
					"patching_rect": [
						320.0,
						1724.0,
						40.0,
						22.0
					],
					"text": "+ 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-123",
					"maxclass": "newobj",
					"patching_rect": [
						320.0,
						1756.0,
						60.0,
						22.0
					],
					"text": "t b i i",
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"bang",
						"int",
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-124",
					"maxclass": "newobj",
					"patching_rect": [
						470.0,
						1756.0,
						80.0,
						22.0
					],
					"text": "prepend set",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-125",
					"maxclass": "comment",
					"patching_rect": [
						620.0,
						1084.0,
						620.0,
						34.0
					],
					"text": "Push banks: click once after pasting into a device that already has banks, then save the device. (The tester registers its banks automatically when none exist.)",
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 10.0
				}
			},
			{
				"box": {
					"id": "obj-126",
					"maxclass": "message",
					"patching_rect": [
						620.0,
						1148.0,
						150.0,
						22.0
					],
					"text": "REGISTER PUSH BANKS",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-127",
					"maxclass": "newobj",
					"patching_rect": [
						620.0,
						1180.0,
						45.0,
						22.0
					],
					"text": "t b b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					]
				}
			},
			{
				"box": {
					"id": "obj-128",
					"maxclass": "message",
					"patching_rect": [
						680.0,
						1180.0,
						30.0,
						22.0
					],
					"text": "2",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-129",
					"maxclass": "newobj",
					"patching_rect": [
						920.0,
						1148.0,
						45.0,
						22.0
					],
					"text": "t b b",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					]
				}
			},
			{
				"box": {
					"id": "obj-130",
					"maxclass": "message",
					"patching_rect": [
						980.0,
						1180.0,
						30.0,
						22.0
					],
					"text": "1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-131",
					"maxclass": "message",
					"patching_rect": [
						620.0,
						1212.0,
						65.0,
						22.0
					],
					"text": "getcount",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-132",
					"maxclass": "newobj",
					"patching_rect": [
						620.0,
						1404.0,
						70.0,
						22.0
					],
					"text": "live.banks",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-133",
					"maxclass": "newobj",
					"patching_rect": [
						770.0,
						1212.0,
						80.0,
						22.0
					],
					"text": "route count",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-134",
					"maxclass": "newobj",
					"patching_rect": [
						770.0,
						1244.0,
						60.0,
						22.0
					],
					"text": "gate 2",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-135",
					"maxclass": "newobj",
					"patching_rect": [
						770.0,
						1276.0,
						45.0,
						22.0
					],
					"text": "sel 0",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-136",
					"maxclass": "message",
					"patching_rect": [
						770.0,
						1308.0,
						30.0,
						22.0
					],
					"text": "0",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-137",
					"maxclass": "newobj",
					"patching_rect": [
						850.0,
						1276.0,
						60.0,
						22.0
					],
					"text": "deferlow",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-138",
					"maxclass": "newobj",
					"patching_rect": [
						770.0,
						1340.0,
						45.0,
						22.0
					],
					"text": "t i i",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"int",
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-139",
					"maxclass": "newobj",
					"patching_rect": [
						830.0,
						1372.0,
						40.0,
						22.0
					],
					"text": "+ 1",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					]
				}
			},
			{
				"box": {
					"id": "obj-140",
					"maxclass": "newobj",
					"patching_rect": [
						770.0,
						1404.0,
						620.0,
						22.0
					],
					"text": "sprintf new %d \"Sample\" \"Smp Folder\" \"Smp File\" \"Smp Load\" \"Smp Auto\" \"Smp Random\" \"Smp Rescan\" \"Smp Folders\" \"Smp Files\"",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-141",
					"maxclass": "newobj",
					"patching_rect": [
						770.0,
						1436.0,
						300.0,
						22.0
					],
					"text": "sprintf new %d \"Sample Setup\" \"Smp Root\"",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					]
				}
			},
			{
				"box": {
					"id": "obj-142",
					"maxclass": "comment",
					"patching_rect": [
						970.0,
						1148.0,
						420.0,
						20.0
					],
					"text": "<- auto: bang here on load registers the banks only if the device has none",
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9.0
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": [
						"obj-28",
						2
					],
					"destination": [
						"obj-29",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-29",
						0
					],
					"destination": [
						"obj-30",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-19",
						0
					],
					"destination": [
						"obj-20",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-20",
						0
					],
					"destination": [
						"obj-21",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-21",
						0
					],
					"destination": [
						"obj-24",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-5",
						0
					],
					"destination": [
						"obj-22",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-22",
						0
					],
					"destination": [
						"obj-23",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-23",
						0
					],
					"destination": [
						"obj-24",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-27",
						0
					],
					"destination": [
						"obj-28",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-28",
						1
					],
					"destination": [
						"obj-23",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-24",
						0
					],
					"destination": [
						"obj-25",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-24",
						4
					],
					"destination": [
						"obj-25",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-25",
						3
					],
					"destination": [
						"obj-26",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-26",
						0
					],
					"destination": [
						"obj-5",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-20",
						1
					],
					"destination": [
						"obj-33",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-33",
						0
					],
					"destination": [
						"obj-34",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-34",
						0
					],
					"destination": [
						"obj-35",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-35",
						0
					],
					"destination": [
						"obj-36",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-36",
						1
					],
					"destination": [
						"obj-37",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-36",
						0
					],
					"destination": [
						"obj-38",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-38",
						0
					],
					"destination": [
						"obj-39",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-25",
						1
					],
					"destination": [
						"obj-41",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-25",
						1
					],
					"destination": [
						"obj-42",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-25",
						1
					],
					"destination": [
						"obj-43",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-4",
						0
					],
					"destination": [
						"obj-46",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-46",
						1
					],
					"destination": [
						"obj-45",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-45",
						0
					],
					"destination": [
						"obj-40",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-40",
						0
					],
					"destination": [
						"obj-37",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-37",
						0
					],
					"destination": [
						"obj-41",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-40",
						1
					],
					"destination": [
						"obj-39",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-39",
						0
					],
					"destination": [
						"obj-42",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-40",
						2
					],
					"destination": [
						"obj-43",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-41",
						0
					],
					"destination": [
						"obj-44",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-42",
						0
					],
					"destination": [
						"obj-44",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-43",
						0
					],
					"destination": [
						"obj-44",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-28",
						0
					],
					"destination": [
						"obj-48",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-6",
						0
					],
					"destination": [
						"obj-48",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-46",
						0
					],
					"destination": [
						"obj-48",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-25",
						0
					],
					"destination": [
						"obj-48",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-48",
						3
					],
					"destination": [
						"obj-50",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-48",
						2
					],
					"destination": [
						"obj-51",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-51",
						1
					],
					"destination": [
						"obj-53",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-51",
						0
					],
					"destination": [
						"obj-52",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-53",
						0
					],
					"destination": [
						"obj-60",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-53",
						0
					],
					"destination": [
						"obj-63",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-52",
						0
					],
					"destination": [
						"obj-65",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-52",
						0
					],
					"destination": [
						"obj-14",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-52",
						0
					],
					"destination": [
						"obj-66",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-66",
						0
					],
					"destination": [
						"obj-7",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-48",
						1
					],
					"destination": [
						"obj-45",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-48",
						0
					],
					"destination": [
						"obj-49",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-44",
						0
					],
					"destination": [
						"obj-54",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-54",
						4
					],
					"destination": [
						"obj-55",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-55",
						0
					],
					"destination": [
						"obj-16",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-20",
						2
					],
					"destination": [
						"obj-56",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-56",
						0
					],
					"destination": [
						"obj-57",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-54",
						2
					],
					"destination": [
						"obj-57",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-57",
						0
					],
					"destination": [
						"obj-58",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-58",
						1
					],
					"destination": [
						"obj-59",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-59",
						0
					],
					"destination": [
						"obj-60",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-54",
						1
					],
					"destination": [
						"obj-60",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-60",
						0
					],
					"destination": [
						"obj-61",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-61",
						0
					],
					"destination": [
						"obj-62",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-62",
						2
					],
					"destination": [
						"obj-63",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-62",
						1
					],
					"destination": [
						"obj-64",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-64",
						0
					],
					"destination": [
						"obj-65",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-64",
						0
					],
					"destination": [
						"obj-14",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-62",
						0
					],
					"destination": [
						"obj-67",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-67",
						0
					],
					"destination": [
						"obj-68",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-68",
						0
					],
					"destination": [
						"obj-7",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-54",
						0
					],
					"destination": [
						"obj-69",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-69",
						0
					],
					"destination": [
						"obj-65",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-65",
						0
					],
					"destination": [
						"obj-70",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-70",
						0
					],
					"destination": [
						"obj-71",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-71",
						1
					],
					"destination": [
						"obj-72",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-72",
						0
					],
					"destination": [
						"obj-8",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-54",
						3
					],
					"destination": [
						"obj-73",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-8",
						0
					],
					"destination": [
						"obj-75",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-7",
						0
					],
					"destination": [
						"obj-102",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-102",
						0
					],
					"destination": [
						"obj-8",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-75",
						1
					],
					"destination": [
						"obj-76",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-76",
						0
					],
					"destination": [
						"obj-77",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-77",
						0
					],
					"destination": [
						"obj-7",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-75",
						0
					],
					"destination": [
						"obj-78",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-70",
						1
					],
					"destination": [
						"obj-78",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-78",
						0
					],
					"destination": [
						"obj-79",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-79",
						1
					],
					"destination": [
						"obj-80",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-79",
						0
					],
					"destination": [
						"obj-63",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-63",
						0
					],
					"destination": [
						"obj-80",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-80",
						0
					],
					"destination": [
						"obj-81",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-54",
						3
					],
					"destination": [
						"obj-81",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-81",
						0
					],
					"destination": [
						"obj-82",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-71",
						0
					],
					"destination": [
						"obj-73",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-73",
						0
					],
					"destination": [
						"obj-82",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-82",
						0
					],
					"destination": [
						"obj-83",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-83",
						3
					],
					"destination": [
						"obj-84",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-84",
						1
					],
					"destination": [
						"obj-86",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-84",
						0
					],
					"destination": [
						"obj-85",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-86",
						0
					],
					"destination": [
						"obj-90",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-86",
						0
					],
					"destination": [
						"obj-93",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-85",
						0
					],
					"destination": [
						"obj-95",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-85",
						0
					],
					"destination": [
						"obj-96",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-85",
						0
					],
					"destination": [
						"obj-15",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-85",
						0
					],
					"destination": [
						"obj-97",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-97",
						0
					],
					"destination": [
						"obj-9",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-83",
						2
					],
					"destination": [
						"obj-87",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-87",
						0
					],
					"destination": [
						"obj-88",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-88",
						1
					],
					"destination": [
						"obj-89",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-89",
						0
					],
					"destination": [
						"obj-90",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-83",
						1
					],
					"destination": [
						"obj-90",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-90",
						0
					],
					"destination": [
						"obj-91",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-91",
						0
					],
					"destination": [
						"obj-92",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-92",
						2
					],
					"destination": [
						"obj-93",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-92",
						1
					],
					"destination": [
						"obj-94",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-94",
						0
					],
					"destination": [
						"obj-95",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-94",
						0
					],
					"destination": [
						"obj-96",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-94",
						0
					],
					"destination": [
						"obj-15",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-92",
						0
					],
					"destination": [
						"obj-98",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-98",
						0
					],
					"destination": [
						"obj-99",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-99",
						0
					],
					"destination": [
						"obj-9",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-83",
						0
					],
					"destination": [
						"obj-100",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-100",
						0
					],
					"destination": [
						"obj-101",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-12",
						0
					],
					"destination": [
						"obj-49",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-49",
						0
					],
					"destination": [
						"obj-101",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-50",
						0
					],
					"destination": [
						"obj-101",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-10",
						0
					],
					"destination": [
						"obj-104",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-9",
						0
					],
					"destination": [
						"obj-119",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-119",
						0
					],
					"destination": [
						"obj-10",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-104",
						1
					],
					"destination": [
						"obj-105",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-104",
						1
					],
					"destination": [
						"obj-106",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-106",
						0
					],
					"destination": [
						"obj-107",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-107",
						0
					],
					"destination": [
						"obj-9",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-104",
						0
					],
					"destination": [
						"obj-108",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-49",
						0
					],
					"destination": [
						"obj-108",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-108",
						0
					],
					"destination": [
						"obj-109",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-101",
						0
					],
					"destination": [
						"obj-109",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-11",
						0
					],
					"destination": [
						"obj-109",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-109",
						0
					],
					"destination": [
						"obj-30",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-30",
						0
					],
					"destination": [
						"obj-95",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-95",
						0
					],
					"destination": [
						"obj-110",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-110",
						1
					],
					"destination": [
						"obj-111",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-111",
						0
					],
					"destination": [
						"obj-105",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-105",
						0
					],
					"destination": [
						"obj-112",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-94",
						0
					],
					"destination": [
						"obj-112",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-112",
						0
					],
					"destination": [
						"obj-113",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-113",
						1
					],
					"destination": [
						"obj-114",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-113",
						0
					],
					"destination": [
						"obj-93",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-93",
						0
					],
					"destination": [
						"obj-114",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-114",
						0
					],
					"destination": [
						"obj-115",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-83",
						3
					],
					"destination": [
						"obj-115",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-115",
						0
					],
					"destination": [
						"obj-116",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-116",
						1
					],
					"destination": [
						"obj-117",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-117",
						0
					],
					"destination": [
						"obj-17",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-116",
						0
					],
					"destination": [
						"obj-118",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-13",
						0
					],
					"destination": [
						"obj-120",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-120",
						1
					],
					"destination": [
						"obj-96",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-96",
						0
					],
					"destination": [
						"obj-121",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-120",
						0
					],
					"destination": [
						"obj-121",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-121",
						0
					],
					"destination": [
						"obj-122",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-122",
						0
					],
					"destination": [
						"obj-123",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-123",
						2
					],
					"destination": [
						"obj-124",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-124",
						0
					],
					"destination": [
						"obj-10",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-123",
						2
					],
					"destination": [
						"obj-106",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-123",
						1
					],
					"destination": [
						"obj-105",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-123",
						0
					],
					"destination": [
						"obj-109",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-126",
						0
					],
					"destination": [
						"obj-127",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-127",
						1
					],
					"destination": [
						"obj-128",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-128",
						0
					],
					"destination": [
						"obj-134",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-127",
						0
					],
					"destination": [
						"obj-131",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-129",
						1
					],
					"destination": [
						"obj-130",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-130",
						0
					],
					"destination": [
						"obj-134",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-129",
						0
					],
					"destination": [
						"obj-131",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-131",
						0
					],
					"destination": [
						"obj-132",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-132",
						0
					],
					"destination": [
						"obj-133",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-133",
						0
					],
					"destination": [
						"obj-134",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-134",
						0
					],
					"destination": [
						"obj-135",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-135",
						0
					],
					"destination": [
						"obj-136",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-136",
						0
					],
					"destination": [
						"obj-137",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-134",
						1
					],
					"destination": [
						"obj-137",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-137",
						0
					],
					"destination": [
						"obj-138",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-138",
						1
					],
					"destination": [
						"obj-140",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-138",
						0
					],
					"destination": [
						"obj-139",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-139",
						0
					],
					"destination": [
						"obj-141",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-140",
						0
					],
					"destination": [
						"obj-132",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-141",
						0
					],
					"destination": [
						"obj-132",
						0
					]
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}
