﻿Функция ДобавитьОписание(МассивОписаний, Знач ИмяКомпонента = Неопределено, ПутьКТаблице, ИмяКолонки, РодительЭлемента = Неопределено, ПередЭлементом = Неопределено, Параметры = Неопределено, Действия = Неопределено) Экспорт  
	Если ИмяКомпонента = Неопределено Тогда
		ИмяКомпонента = "А1БК_НаборКнопокБулевойКолонки_" + СтрЗаменить(ПутьКТаблице, ".", "_") + "_" + ИмяКолонки;
	КонецЕсли;
	
	А1Э_УниверсальнаяФорма.ДобавитьОписаниеНастроекКомпонента(МассивОписаний, ИмяКомпонента,
	А1Э_Структуры.Создать(
	"ПутьКТаблице", А1Э_Строки.Разделить(ПутьКТаблице, "."),
	"ИмяКолонки", ИмяКолонки,
	));
	РабочиеПараметры = А1Э_Структуры.СкопироватьВШаблон(Параметры,
	"ИмяЭлемента", ИмяКомпонента,
	"Вид", ВидГруппыФормы.ГруппаКнопок,
	);
	А1Э_Формы.ДобавитьОписаниеГруппы(МассивОписаний, ИмяКомпонента, , РодительЭлемента, ПередЭлементом, РабочиеПараметры);
	А1Э_Формы.ДобавитьОписаниеКомандыИКнопки(МассивОписаний, ИмяКомпонента + "___Установить", ИмяМодуля() + ".Установить", , , ИмяКомпонента, , , 
	А1Э_Структуры.Создать(
	"Картинка", БиблиотекаКартинок.УстановитьФлажки,
	"Отображение", ОтображениеКнопки.Картинка,
	));
	А1Э_Формы.ДобавитьОписаниеКомандыИКнопки(МассивОписаний, ИмяКомпонента + "___Снять", ИмяМодуля() + ".Снять", , , ИмяКомпонента, , ,
	А1Э_Структуры.Создать(
	"Картинка", БиблиотекаКартинок.СнятьФлажки,
	"Отображение", ОтображениеКнопки.Картинка,
	)); 
КонецФункции

#Если Клиент Тогда
	
	Функция Установить(Форма, Команда) Экспорт
		ИзменитьЗначениеКолонки(Форма, Команда, Истина);
	КонецФункции
	
	Функция Снять(Форма, Команда) Экспорт
		ИзменитьЗначениеКолонки(Форма, Команда, Ложь);
	КонецФункции
	
	Функция ИзменитьЗначениеКолонки(Форма, Команда, Значение)
		Настройки = А1Э_УниверсальнаяФорма.НастройкиКомпонента(Форма, А1Э_Строки.ПередСКонца(Команда.Имя, "___"));
		Таблица = А1Э_Иерархии.ЗначениеСвойства(Форма, Настройки.ПутьКТаблице);
		ИмяКолонки = Настройки.ИмяКолонки;
		Для Каждого Строка Из Таблица Цикл
			Строка[ИмяКолонки] = Значение;
		КонецЦикла;
		
	КонецФункции 
#КонецЕсли

Функция ИмяМодуля() Экспорт
	Возврат "А1БК_НаборКнопокБулевойКолонки";
КонецФункции 