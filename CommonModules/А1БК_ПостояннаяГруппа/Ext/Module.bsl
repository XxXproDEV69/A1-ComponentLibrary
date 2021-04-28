﻿// Предназначен для создания группы, которая при отсутствии видимых подчиненных элементов не пропадает, а становится недоступной. 
//
// Параметры:
//  МассивОписаний	 - 	 - 
//  ИмяКомпонента	 - 	 - 
//  РодительЭлемента - Строка,ЭлементФормы	 - 
//  ПередЭлементом	 - 	 - 
//  Параметры		 - 	 - 
//  Действия		 - 	 - 
// 
// Возвращаемое значение:
//   - 
//
Функция ДобавитьОписание(МассивОписаний, ИмяКомпонента, Заголовок = "", РодительЭлемента = Неопределено, ПередЭлементом = Неопределено, Параметры = Неопределено, Действия = Неопределено) Экспорт
	РабочиеПараметры = А1Э_Структуры.СкопироватьВШаблон(Параметры,
	"ИмяЭлемента", ИмяКомпонента,
	);
	РабочиеДействия = А1Э_Структуры.Скопировать(Действия);
	А1Э_УниверсальнаяФорма.ДобавитьОбработчикМодуляКДействиям(РабочиеДействия, ИмяМодуля(), "ФормаОбновитьСвойстваЭлементов");
	А1Э_Формы.ДобавитьОписаниеГруппы(МассивОписаний, ИмяКомпонента, Заголовок, РодительЭлемента, ПередЭлементом, РабочиеПараметры, РабочиеДействия);
	А1Э_Формы.ДобавитьОписаниеКомандыИКнопки2(МассивОписаний, ИмяКомпонента + "___Пустышка", "А1Э_Общее.Ничего", "-", ИмяКомпонента, , А1Э_Структуры.Создать(
	"Доступность", Ложь,
	));
КонецФункции

Функция ФормаОбновитьСвойстваЭлементов(ИмяКомпонента, Форма) Экспорт
	Компонент = Форма.Элементы[ИмяКомпонента];
	ЕстьВидимыеВИерархии = ЕстьВидимыеВИерархии(Компонент);
	Компонент.Доступность = ЕстьВидимыеВИерархии;
	Компонент.ТолькоПросмотр = НЕ ЕстьВидимыеВИерархии;
	Форма.Элементы[ИмяКомпонента + "___Пустышка"].Видимость = НЕ ЕстьВидимыеВИерархии;
КонецФункции

Функция ЕстьВидимыеВИерархии(Элемент)
	Если Элемент.Видимость = Ложь Тогда Возврат Ложь КонецЕсли;
	Если ТипЗнч(Элемент) <> Тип("ГруппаФормы") Тогда Возврат Истина; КонецЕсли;
	Для Каждого ПодчиненныйЭлемент Из Элемент.ПодчиненныеЭлементы Цикл
		Если ЕстьВидимыеВИерархии(ПодчиненныйЭлемент) Тогда Возврат Истина; КонецЕсли;
	КонецЦикла;
	Возврат Ложь;			
КонецФункции

Функция ИмяМодуля() Экспорт
	Возврат "А1БК_ПостояннаяГруппа";	
КонецФункции 