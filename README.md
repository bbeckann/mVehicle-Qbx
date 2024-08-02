
[![docs](https://img.shields.io/badge/Documents-Read-232323?logo=readthedocs&logoColor=white)](https://mono-scripts.gitbook.io/mono-docs/mono-documents/mvehicle)
[![discord](https://img.shields.io/badge/Join-Discord-blue?logo=discord&logoColor=white)](https://discord.gg/Vk7eY8xYV2)
![Discord](https://img.shields.io/discord/1048630711881568267?style=flat&label=Online%20Users&color=green)
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2FMono-94%2FmVehicle&count_bg=%23E9A711&title_bg=%23232323&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)



# mVehicles  - QBX
*Este não é um sistema de garagem, é apenas para gerenciar veículos. Você pode usar este código simplesmente para o sistema de chaves.*

## Features
- Totalmente compatível com QBX  (requer banco de dados)
- Veículos são persistentes.
- Capacidade de adicionar metadados aos veículos.
- Registra o total de quilômetros percorridos pelos veículos.
- Sistema de chaves via item ou banco de dados.
- Ignição do motor por item de chave/banco de dados
- Menu para compartilhamento de chaves.
- Placa Falsa funciona apenas com veículos gerados pelo Vehicles.CreateVehicle() e item ox_inventory
- LockPick, Hotwire + Adapte seu skillscheck e dispatch via Config.LockPickItem e Config.HotWireItem
 

- ## **Comandos**
 - `/givecar [source]`
 - - Set a player [source] a vehicle temporarily/indefinitely
 - `/setcarowner [source]`
  - - Establish ownership of the vehicle in which the player is located. [source]
 - `/saveAllcars true/false` 
 - - If true, deletes all vehicles; if false, only save vehicles.
 - `/spawnAllcars` 
 -  Forces spawning vehicles outside garages.
<details>
<summary>Image</summary>

![GiveCar](https://i.imgur.com/3ja1LQG.png)

![CarKeysMenu](https://i.imgur.com/b3eAY84.png)

![ManageVehicleKeys](https://i.imgur.com/82KfzBc.png)
</details>

## Outras Funcionalidades
- Target for managing the trailer tr2.

## Dependencies
* **OneSync**
* [OXMYSQL](https://github.com/overextended/oxmysql)
* [ox_lib](https://github.com/overextended/ox_lib)
* [ox_inventory](https://github.com/overextended/ox_inventory) (only keys as item)
* [ox_target](https://github.com/overextended/ox_target) (target Carkey and Trailer manager)
* [ox_fuel](https://github.com/overextended/ox_fuel) 

Recommended latest 
[FiveM  GameBuild](https://docs.fivem.net/docs/server-manual/server-commands#sv_enforcegamebuild-build)

## Shared file
```lua 
shared_scripts { '@mVehicle/import.lua' }
```


## Install 
1. **update SQL**
2. **Server.cfg**
3. **set mVehicle:Persistent true/false** (Default false) 
4. **start the code after the dependencies of ox and your framework**


<details>
<summary>SQL </summary>

# DataBase 
## QBOX 
- Original player_vehicles
```sql
CREATE TABLE `player_vehicles` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`license` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`citizenid` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`vehicle` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`hash` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`mods` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	`plate` VARCHAR(15) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`fakeplate` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`garage` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`fuel` INT(11) NULL DEFAULT '100',
	`engine` FLOAT NULL DEFAULT '1000',
	`body` FLOAT NULL DEFAULT '1000',
	`state` INT(11) NULL DEFAULT '1',
	`depotprice` INT(11) NOT NULL DEFAULT '0',
	`drivingdistance` INT(50) NULL DEFAULT NULL,
	`status` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`glovebox` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`trunk` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`mileage` INT(11) NULL DEFAULT '0',
	`coords` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`lastparking` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`type` VARCHAR(20) NOT NULL DEFAULT 'automobile' COLLATE 'utf8mb4_unicode_ci',
	`job` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`pound` VARCHAR(60) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`stored` TINYINT(4) NOT NULL DEFAULT '0',
	`keys` LONGTEXT NULL DEFAULT '[]' COLLATE 'utf8mb4_unicode_ci',
	`metadata` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`parking` VARCHAR(60) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `plate` (`plate`) USING BTREE,
	INDEX `citizenid` (`citizenid`) USING BTREE,
	INDEX `license` (`license`) USING BTREE,
	CONSTRAINT `player_vehicles_ibfk_1` FOREIGN KEY (`citizenid`) REFERENCES `players` (`citizenid`) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT `player_vehicles_ibfk_2` FOREIGN KEY (`license`) REFERENCES `players` (`license`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8mb4_unicode_ci'
ENGINE=InnoDB
AUTO_INCREMENT=139
;

```

## How to use
- READING IS NOT LAVA


# Items 
<details>
<summary> Items </summary>


```lua
['carkey'] = {
	label = 'Carkey',
},

['lockpick'] = {
	label = 'Lockpick',
	weight = 160,
	decay = true,
	server = {
		export = 'mVehicle.lockpick'
	}
},

['hotwire'] = {
	label = 'Cutter',
	weight = 160,
	server = {
		export = 'mVehicle.hotwire'
	}
},

['fakeplate'] = {
	label = 'Fake Plate',
	consume = 0,
	server = {
		export = 'mVehicle.fakeplate'
	}
},
```
</details>

# Functions

**Vehicles.VehickeKeysMenu() Client**
```lua
--  all player vehicles
Vehicles.VehickeKeysMenu()

--  Specific plate, 
Vehicles.VehickeKeysMenu('MONO 420', function()
  print('On Close menu or Set/remove key player')
end)
``` 

**Vehicles.ItemCarKeysClient() Client**
* action = 'delete' or 'add' | string
* plate  =  vehicle plate    | string *GetVehicleNumberPlateText()*
```lua
  -- with shared import
  Vehicles.ItemCarKeysClient(action, plate)

    -- or 
  exports.mVehicle:ItemCarKeysClient(action, plate)
```

**Vehicles.ItemCarKeys() Server**
* source = player source    | number 
* action = 'delete' or 'add' | string
* plate  =  vehicle plate    | string 
```lua
  -- with shared import
  Vehicles.ItemCarKeys(source, action, plate)

  -- or ox_inventory export 
  -- add
  exports.ox_inventory:AddItem(source, 'carkey', 1, { plate = plate, description = plate })
  -- delete
  exports.ox_inventory:RemoveItem(source, 'carkey', 1, { plate = plate, description = plate })
 
 -- or 
  exports.mVehicle:ItemCarKeys(source, action, plate)
```

**Vehicles.CreateVehicle() Server**
```lua
local CreateVehicleData = {
    temporary = false, -- if vehicle temporary | date format 'YYYYMMDD HH:MM'     example '20240422 03:00' or false
    job = nil,  -- string or false, nil ...
    setOwner = true,    -- Set vehicle Owner? if Temporary date set true
    owner = 'char:12asd76asd5asdas',    -- player identifier
    coords = vector4(1.0, 1.0, 1.0, 1.0), --vector4 or table with xyzw
    -- Vehicle, you can set as many properties as you want
    vehicle = {                             
        model = 'sulta',                   -- required
        plate = Vehicles.GeneratePlate(),  -- required
        fuelLevel = 100,                   -- required
        color1 = [0,0,0],
        color2 = [0,0,0],                 
    },
}

Vehicles.CreateVehicle(CreateVehicleData, function(data, Vehicle)
   print(json.encode(data, { indent = true} ))

 -- Set Metadata
  Vehicle.SetMetadata('mono', { 
    smoke = 'seems to be very smoked', 
    hungry = 'the subject is very hungry'
  }) 
  Wait(1000)
  -- Get Metadata
  local metadata = Vehicle.GetMetadata('mono',)
  print(('%s, %s'):format(metadata.smoke, metadata.hungry))
  Wait(1000)
  -- delete espeific Metadata
  Vehicle.DeleteMetadata('mono', 'smoke')
  Wait(1000)
  -- Get new metadata
  local metadataNew = Vehicle.GetMetadata('mono')
  print(('%s'):format(metadataNew.hungry))
  Wait(1000)
  -- delete all metadata from 'mono' return nil 
  Vehicle.DeleteMetadata('mono')
  

  --GarageActions
  -- Store/Retry
  Vehicle.StoreVehicle('Pillbox Hill')

  Vehicle.RetryVehicle(CreateVehicleData.coords)

  -- impound
  Vehicle.ImpoundVehicle('Impound Car', 100, 'Vehicle impond', '2024/05/2 15:43')

  Vehicle.RetryImpound('Pillbox Hill', CreateVehicleData.coords)
end)

```
**Vehicles.GetClientProps()** *Server*
- Returns vehicle props
```lua
local vehicleProps = Vehicles.GetClientProps(SourceID, VehicleNetworkID)

```
**Vehicles.GetVehicle()** *Server*

```lua
local Vehicle = Vehicles.GetVehicle(entity) 
Vehicle.SetMetadata(key, data)
Vehicle.DeleteMetadata(key, value) 
Vehicle.GetMetadata(key)     
Vehicle.Savemetadata()
Vehicle.AddKey(source) 
Vehicle.RemoveKey(source)
Vehicle.GetKeys()
Vehicle.SaveProps(props)
Vehicle.StoreVehicle(parking)
Vehicle.RetryVehicle(coords)
Vehicle.ImpoundVehicle(impound, price, note, date, endPound)
Vehicle.RetryImpound(ToGarage, coords)
Vehicle.SetFakePlate(plate)
Vehicle.SetFakePlate(boolean)
Vehicle.DeleteVehicle(fromDatabaseBoolean)
```


**GetVehicleByPlate** *Server*
= Vehicles.GetVehicle()
```lua
 local Vehicles.GetVehicleByPlate(plate)
```

**Vehicles.GetVehicleId** *Server*
```lua 
local vehicle = Vehicles.GetVehicleId(id) 
```
**Delete All Vehicles** *Server*

```lua 
local AllVechiles = Vehicles.GetAllVehicles(source, VehicleTable, haveKeys) 
```

**Vehicles.GetAllVehicles()** *Server*
* soruce  = player source
* VehicleTable = boolean | true get vehicles from table mVehicles false get vehicles from DB
* haveKeys = boolean  | Have player keys ?
* return all vehicles from source

```lua 
local AllVechiles = Vehicles.GetAllVehicles(source, VehicleTable, haveKeys) 
```

**Set Vehicle Owner** *Server*
```lua 
Vehicles.SetVehicleOwner({
    job = ?,
    owner = ?,
    parking = ?,
    plate = ?,
    type = ?,
    vehicle = ?,
})
```

**SetCarOwner** *Server*
```lua
Vehicles.SetCarOwner(src)
```

**Delete All Vehicles** *Server*
```lua 
Vehicles.DelAllVehicles() 
```

**save all vehicles** *Server*
true/false to delete vehicles
```lua 
Vehicles.SaveAllVehicles(delete)
```

**plate exists?** *Server*
return boolean
```lua 
Vehicles.PlateExist(plate) 
```

**Generate plate** *Server*
return plate string
```lua 
Vehicles.GeneratePlate()
```



![image](https://i.imgur.com/Y9RXYBH.png)
