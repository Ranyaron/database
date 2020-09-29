DROP DATABASE IF EXISTS snet1;
CREATE DATABASE snet1 CHARACTER SET utf8mb4;
USE snet1;

CREATE TABLE `communities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `name` (`name`)
);

INSERT INTO communities (name) VALUES 
('PHP')
,('Planetaro')
,('Ruby')
,('Vim')
,('РђСЃСЃРµРјР±Р»РµСЂ РІ Linux РґР»СЏ РїСЂРѕРіСЂР°РјРјРёСЃС‚РѕРІ C')
,('РђС„С„РёРЅРЅС‹Рµ РїСЂРµРѕР±СЂР°Р·РѕРІР°РЅРёСЏ')
,('Р‘РёРѕР»РѕРіРёСЏ РєР»РµС‚РєРё')
,('Р”СЂРµРІРЅРµРєРёС‚Р°Р№СЃРєРёР№ СЏР·С‹Рє')
,('Р—РЅР°РєРѕРјСЃС‚РІРѕ СЃ РјРµС‚РѕРґРѕРј РјР°С‚РµРјР°С‚РёС‡РµСЃРєРѕР№ РёРЅРґСѓРєС†РёРё')
,('Р�РЅС„РѕСЂРјР°С†РёСЏ, СЃРёСЃС‚РµРјС‹ СЃС‡РёСЃР»РµРЅРёСЏ')
;
INSERT INTO communities (name) VALUES 
('РљРѕРґРёСЂРѕРІР°РЅРёРµ С‚РµРєСЃС‚Р° Рё СЂР°Р±РѕС‚Р° СЃ РЅРёРј')
,('РљРѕРјРїР»РµРєСЃРЅС‹Рµ С‡РёСЃР»Р°')
,('Р›РёРЅРіРІР° РґРµ РїР»Р°РЅРµС‚Р°')
,('Р›РёСЃРї')
,('РњР°С‚РµРјР°С‚РёРєР° СЃР»СѓС‡Р°СЏ')
,('РњРёРєСЂРѕРјРёСЂ, СЌР»РµРјРµРЅС‚Р°СЂРЅС‹Рµ С‡Р°СЃС‚РёС†С‹, РІР°РєСѓСѓРј')
,('РњРѕСЃРєРѕРІСЃРєР°СЏ РѕР»РёРјРїРёР°РґР° РїРѕ РёРЅС„РѕСЂРјР°С‚РёРєРµ')
,('РћС†РёС„СЂРѕРІРєР° РїРµС‡Р°С‚РЅС‹С… С‚РµРєСЃС‚РѕРІ')
,('Р РµР°Р»РёР·Р°С†РёРё Р°Р»РіРѕСЂРёС‚РјРѕРІ')
,('Р РµРіСѓР»СЏСЂРЅС‹Рµ РІС‹СЂР°Р¶РµРЅРёСЏ')
;
INSERT INTO communities (name) VALUES 
('Р РµРєСѓСЂСЃРёСЏ')
,('Р СѓСЃСЃРєРёР№ СЏР·С‹Рє')
,('РЎРѕР·РґР°РЅРёРµ СЌР»РµРєС‚СЂРѕРЅРЅРѕР№ РєРѕРїРёРё РєРЅРёРіРё РІ С„РѕСЂРјР°С‚Рµ DjVu РІ Linux')
,('РўРѕРєРёРїРѕРЅР°')
,('РЈС‡РµР±РЅРёРє Р»РѕРіРёС‡РµСЃРєРѕРіРѕ СЏР·С‹РєР°')
,('Р§С‚Рѕ С‚Р°РєРѕРµ РІС‹С‡РёСЃР»РёС‚РµР»СЊРЅР°СЏ РјР°С‚РµРјР°С‚РёРєР°')
,('Р­Р»РµРєС‚СЂРѕРЅРЅС‹Рµ С‚Р°Р±Р»РёС†С‹ РІ Microsoft Excel')
,('Р­СЃРїРµСЂР°РЅС‚Рѕ? Р—Р°С‡РµРј?')
,('РЇР·С‹Рє РЎРё РІ РїСЂРёРјРµСЂР°С…')
,('РЇРїРѕРЅСЃРєРёР№ СЏР·С‹Рє')
;