![Banner](https://i.imgur.com/8kdbVbC.png)

**mta-add-models** is a MTA resource that acts as a library, making use of [engineRequestModel](https://wiki.multitheftauto.com/wiki/EngineRequestModel) function to add new peds (skins), vehicles and objects:

- syncs all added models with all players
- minimalistic, optimized and bug free

In simpler terms, with this resource you can make scripts/change your scripts to add new skins, vehicles and objects to your server! For example we can now add all SA-MP objects whilst keeping their IDs.

MTA forum topic: [here](https://forum.mtasa.com/topic/133212-rel-add-new-models-library/#comment-1003395)

Contact (author): Nando#7736 **(Discord)**

## Your opinion matters

Click the button to check the project's feedback page:

[<img src="https://i.imgur.com/x19GaN1.png?1">](https://github.com/Fernando-A-Rocha/mta-add-models/issues/7)

## Getting Started

### Prerequisites

- Required minimum MTA Server & Client version `1.5.9-9.21437.0`
- Get the installers from [nightly.mtasa.com](https://nightly.mtasa.com/)
- ![https://i.imgur.com/BmkUosO.png](https://i.imgur.com/BmkUosO.png)
- Client will auto-update upon joining the server
- *Find out what the build numbers mean here: [buildinfo.mtasa.com](https://buildinfo.mtasa.com/)*
- **If you don't have the right version these resources will not work correctly**

### Includes

- [newmodels](/newmodels): main library resource
- (optional) [newmodels-example](/[examples]/newmodels-example): an example implementation to add new objects/skins/etc to your server
- (optional) [sampobj_reloaded](/[examples]/sampobj_reloaded): a resource that adds all SA-MP object models to your server
  - 👉 [Download](https://www.mediafire.com/file/mgqrk0rq7jrgsuc/models.zip/file) `models.zip` containing all dff/txd/col files required
- (optional) [unittest_newmodels](/[examples]/unittest_newmodels): a resource for testing the main scripts

### Install

- Get the latest release: [here](https://github.com/Fernando-A-Rocha/mta-add-models/releases/latest)
- Download the source code Zip and extract it
- Place the `newmodels` folder in your server's resources
- Use command `start newmodels` in server console

### Quick Testing

- Place mod files [newmodels/models](/newmodels/models) (dff & txd (& col for objects))
- List them in [newmodels/meta.xml](/newmodels/meta.xml) like the example
- As of version 2.0, files have the `download="false"` attribute, causing newmodels to handle downloading them later only when needed
- Define them in [newmodels/mod_list.lua](/newmodels/mod_list.lua) inside `modList` like the example
- Use the [commands](#commands) to test, have fun!

### Commands

Main testing commands in `newmodels`:

- /listmods **lists all defined mods**
- /allocatedids **shows all allocated mod IDs in realtime**
- /selements **lists all streamed in elements for debugging purposes**
- /myskin [ID] **sets your skin to a default or new ID**
- /makeped [ID] **creates a ped and sets its model to a default or new ID**
- /makeobject [ID] **creates an object and sets its model to a default or new ID**
- /makevehicle [ID] **creates a vehicle and sets its model to a default or new ID**

Testing command(s) in `newmodels-example`: [here](/[examples]/newmodels-example/server.lua)

Testing command(s) in `sampobj_reloaded`: [here](/[examples]/sampobj_reloaded/server.lua)

Testing command(s) in `unittest_newmodels`: [here](/[examples]/unittest_newmodels/server.lua)

## How to Use

- [General Information/Guide](/docs/implementations/README.md)
- [Lua Code Examples](/docs/EXAMPLES.md)
- [Newmodels in Map Editor](/docs/custom_editor/README.md)

## NandoCrypt

There is support for encrypted model files using the [NandoCrypt](https://github.com/Fernando-A-Rocha/mta-nandocrypt) resource.

## Object .col Files

Object mods need a .col file to define its collisions. Ped and vehicles don't need any because the collisions are automatically generated by the game engine.

There's a tool to generate a `.col` file from a given `.dff` model. Check out the tutorial [here](https://github.com/Fernando-A-Rocha/mta-samp-maploader/blob/main/TUTORIAL_COL.md).

## Final Note

Feel free to update the documentation in this repository and contribute to the code via pull requests.

Thank you for reading, have fun!
