# Consumable System

Enhance your FiveM server with a versatile consumable system.

## Features

- Consume drinks and food with emotes
- Track item durability and remove items when durability is depleted
- Place items on surfaces

## Requirements

- FiveM server
- ESX framework
- MySQL

## Installation

1. Download the script
2. Place the script in your FiveM server's resources folder
3. Add the following to your server.cfg:

```
start ConsumableSystem
```

## Usage

- Players can consume items by using the command `/useitem <itemName>`
- Players can place items on surfaces by using the command `/placeitem <itemName>`

## Configuration

The script can be configured in the `config.lua` file. You can add new consumables, alcohol, and surfaces by editing the `Config.Consumables`, `Config.Alcohol`, and `Config.Surfaces` tables respectively.

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=consumable-system&utm_content=bottom) — describe it in one sentence and get the full source code.
