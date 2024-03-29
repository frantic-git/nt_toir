////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПЕРЕМЕННЫЕ
&НаКлиенте
Перем КэшированныеЗначения; // используется механизмом обработки изменения реквизитов ТЧ

#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
	УстановитьУсловноеОформление();
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		СлужебныеРеквизитыЗаполнитьНаСервере();
	КонецЕсли;
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтаФорма);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// Заголовок формы++
	торо_РаботаСДиалогами.УстановитьЗаголовокФормыДокумента(Объект, ЭтаФорма, "");
	// Заголовок формы--
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства

КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства

КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	// Заголовок формы++
	торо_РаботаСДиалогами.УстановитьЗаголовокФормыДокумента(Объект, ЭтаФорма, "");
	// Заголовок формы--
	
	СлужебныеРеквизитыЗаполнитьНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства

	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения

	СлужебныеРеквизитыЗаполнитьНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.Свойства 
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	Если ИсточникВыбора.ИмяФормы = "Обработка.торо_ПодборНоменклатуры.Форма.Форма" Тогда
		
		ДобавитьНоменклатуруИзПодбора(ВыбранноеЗначение);
		
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПодразделениеПриИзменении(Элемент)
	
	торо_ЗаполнениеДокументовКлиент.ЗаполнитьСклад(Объект.Подразделение, Объект.Склад);
	
КонецПроцедуры

&НаКлиенте
Процедура КомментарийНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ОбщегоНазначенияКлиент.ПоказатьФормуРедактированияКомментария(
		Элемент.ТекстРедактирования, ЭтотОбъект, "Объект.Комментарий");	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары
&НаКлиенте
Процедура ТоварыНоменклатураПриИзменении(Элемент)
	
	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	
	СтруктураДействий = Новый Структура;
	СтруктураДействий.Вставить("ПроверитьХарактеристикуПоВладельцу", ТекущаяСтрока.Характеристика);
	СтруктураДействий.Вставить("ПересчитатьСумму", "Количество");
	СтруктураДействий.Вставить("ЗаполнитьПризнакАртикул", Новый Структура("Номенклатура", "Артикул"));
	СтруктураДействий.Вставить("ЗаполнитьПризнакТипНоменклатуры", Новый Структура("Номенклатура", "ТипНоменклатуры"));

	СтруктураДействий.Вставить("НоменклатураПриИзмененииПереопределяемый", Новый Структура("ИмяФормы, ИмяТабличнойЧасти",
		ЭтаФорма.ИмяФормы, "Товары"));

	ОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущаяСтрока, СтруктураДействий, КэшированныеЗначения);
	
	ТекущаяСтрока.СерииИспользуются = ПолучитьСерииИспользуются(ТекущаяСтрока.Номенклатура);
	ТекущаяСтрока.Серия = Неопределено;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыХарактеристикаПриИзменении(Элемент)
	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	
	СтруктураДействий = Новый Структура;
	
	СтруктураДействий.Вставить("ХарактеристикаПриИзмененииПереопределяемый", Новый Структура("ИмяФормы, ИмяТабличнойЧасти",
		ЭтаФорма.ИмяФормы, "Товары"));

	ОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущаяСтрока, СтруктураДействий, КэшированныеЗначения);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;

	СтруктураДействий = Новый Структура;
	ДобавитьВСтруктуруДействияПриИзмененииКоличества(СтруктураДействий);

	ОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущаяСтрока, СтруктураДействий, КэшированныеЗначения);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСерияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ТекДанные =  Элементы.Товары.ТекущиеДанные;
	Если Не ТекДанные = Неопределено Тогда
		СтандартнаяОбработка = Ложь;
		ВидНоменклатуры = торо_ОбщегоНазначенияВызовСервера.ЗначениеРеквизитаОбъекта(ТекДанные.Номенклатура, "ВидНоменклатуры");
		ПараметрыФормы = Новый Структура("Отбор", Новый Структура("ВидНоменклатуры", ВидНоменклатуры));
		ОткрытьФорму("Справочник.СерииНоменклатуры.ФормаВыбора", ПараметрыФормы, Элемент);
	КонецЕсли;		
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСерияАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	
	Если Ожидание > 0 Тогда
		ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
		ВидНоменклатуры = торо_ОбщегоНазначенияВызовСервера.ЗначениеРеквизитаОбъекта(ТекущиеДанные.Номенклатура, "ВидНоменклатуры");
		ПараметрыПолученияДанных.Отбор.Вставить("ВидНоменклатуры",ВидНоменклатуры);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСерияОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	ВидНоменклатуры = торо_ОбщегоНазначенияВызовСервера.ЗначениеРеквизитаОбъекта(ТекущиеДанные.Номенклатура, "ВидНоменклатуры");
	ПараметрыПолученияДанных.Отбор.Вставить("ВидНоменклатуры",ВидНоменклатуры);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСерияОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено И ЗначениеЗаполнено(ВыбранноеЗначение) Тогда
		ВидНоменклатуры = торо_ОбщегоНазначенияВызовСервера.ЗначениеРеквизитаОбъекта(ТекущиеДанные.Номенклатура, "ВидНоменклатуры");
		ВидНоменклатурыВыбранный = торо_ОбщегоНазначенияВызовСервера.ЗначениеРеквизитаОбъекта(ВыбранноеЗначение, "ВидНоменклатуры");
		Если ВидНоменклатуры <> ВидНоменклатурыВыбранный Тогда
			СтандартнаяОбработка = Ложь;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыХарактеристикаСоздание(Элемент, СтандартнаяОбработка)
	Если Элементы.Товары.ТекущиеДанные <> Неопределено И ЗначениеЗаполнено(Элементы.Товары.ТекущиеДанные.Номенклатура) Тогда
		Вид = торо_ОбщегоНазначенияВызовСервера.ЗначениеРеквизитаОбъекта(Элементы.Товары.ТекущиеДанные.Номенклатура, "ВидНоменклатуры");
		СтруктураПараметров = Новый Структура("ВидНоменклатуры, Владелец", Вид, Элементы.Товары.ТекущиеДанные.Номенклатура);
		ОткрытьФорму("Справочник.ХарактеристикиНоменклатуры.Форма.ФормаЭлемента", СтруктураПараметров);
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСерияСоздание(Элемент, СтандартнаяОбработка)
	Если Элементы.Товары.ТекущиеДанные <> Неопределено И ЗначениеЗаполнено(Элементы.Товары.ТекущиеДанные.Номенклатура) Тогда
		СтруктураПараметров = Новый Структура("ВидНоменклатуры", торо_ОбщегоНазначенияВызовСервера.ЗначениеРеквизитаОбъекта(Элементы.Товары.ТекущиеДанные.Номенклатура, "ВидНоменклатуры"));
		ОткрытьФорму("Справочник.СерииНоменклатуры.Форма.ФормаЭлемента", СтруктураПараметров);
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТоварыХарактеристикаОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		ВидНоменклатуры = торо_ОбщегоНазначенияВызовСервера.ЗначениеРеквизитаОбъекта(ТекущиеДанные.Номенклатура, "ВидНоменклатуры");
		ИспользованиеХарактеристик = торо_ОбщегоНазначенияВызовСервера.ЗначениеРеквизитаОбъекта(ВидНоменклатуры, "ИспользованиеХарактеристик");
		ПараметрыПолученияДанных.Отбор.Очистить();
		Если ИспользованиеХарактеристик = ПредопределенноеЗначение("Перечисление.ВариантыИспользованияХарактеристикНоменклатуры.ОбщиеДляВидаНоменклатуры") Тогда
			ПараметрыПолученияДанных.Отбор.Вставить("Владелец", ВидНоменклатуры);
		Иначе
			ПараметрыПолученияДанных.Отбор.Вставить("Владелец", ТекущиеДанные.Номенклатура);
		КонецЕсли; 
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТоварыХарактеристикаАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		ВидНоменклатуры = торо_ОбщегоНазначенияВызовСервера.ЗначениеРеквизитаОбъекта(ТекущиеДанные.Номенклатура, "ВидНоменклатуры");
		ИспользованиеХарактеристик = торо_ОбщегоНазначенияВызовСервера.ЗначениеРеквизитаОбъекта(ВидНоменклатуры, "ИспользованиеХарактеристик");
		ПараметрыПолученияДанных.Отбор.Очистить();
		Если ИспользованиеХарактеристик = ПредопределенноеЗначение("Перечисление.ВариантыИспользованияХарактеристикНоменклатуры.ОбщиеДляВидаНоменклатуры") Тогда
			ПараметрыПолученияДанных.Отбор.Вставить("Владелец", ВидНоменклатуры);
		Иначе
			ПараметрыПолученияДанных.Отбор.Вставить("Владелец", ТекущиеДанные.Номенклатура);
		КонецЕсли; 
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры
 
&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
	ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры
 
&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры
 
&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.Свойства 
&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

&НаСервере
Процедура СлужебныеРеквизитыЗаполнитьНаСервере()

	НоменклатураСервер.ЗаполнитьСлужебныеРеквизитыПоНоменклатуреВКоллекции(
		Объект.Товары,
		Новый Структура("ЗаполнитьПризнакХарактеристикиИспользуются",
			Новый Структура("Номенклатура", "ХарактеристикиИспользуются")));
			
	НоменклатураСервер.ЗаполнитьСлужебныеРеквизитыПоНоменклатуреВКоллекции(
		Объект.Товары,
		Новый Структура("ЗаполнитьПризнакСерииИспользуются",
			Новый Структура("Номенклатура", "СерииИспользуются")));
		
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();

	//

	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТоварыХарактеристика.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.Товары.ХарактеристикиИспользуются");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", WebЦвета.НейтральноСерый);
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru = '<характеристики не используются>'"));
	Элемент.Оформление.УстановитьЗначениеПараметра("ОтметкаНезаполненного",Ложь);
	Элемент.Оформление.УстановитьЗначениеПараметра("Доступность",Ложь);
	
	// Оформление поля Серия	
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТоварыСерия.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.Товары.СерииИспользуются");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", WebЦвета.НейтральноСерый);
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru = '<серии не используются>'"));
	Элемент.Оформление.УстановитьЗначениеПараметра("ОтметкаНезаполненного",Ложь);
	Элемент.Оформление.УстановитьЗначениеПараметра("Доступность",Ложь);

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ДобавитьВСтруктуруДействияПриИзмененииКоличества(СтруктураДействий)
	
КонецПроцедуры

&НаСервере
Функция ПолучитьСерииИспользуются(Номенклатура)
	
	Возврат Номенклатура.ВидНоменклатуры.ИспользоватьСерии;
	
КонецФункции

&НаКлиенте
Процедура ПодобратьТовары(Команда)
	Отказ = Ложь;
	
	Если Не ЗначениеЗаполнено(Объект.Склад) Тогда
		ОчиститьСообщения();
		ТекстСообщения = НСтр("ru = 'Поле ""Склад"" не заполнено'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения, Объект.Ссылка, "Объект.Склад",, Отказ);
	КонецЕсли;
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Склад",                                     Объект.Склад);
	ПараметрыФормы.Вставить("РежимПодбораБезСуммовыхПараметров",         Истина);
	ПараметрыФормы.Вставить("ИспользоватьДатыОтгрузки",                  Истина);
	ПараметрыФормы.Вставить("СкрыватьКолонкуВидЦены",                    Истина);
	ПараметрыФормы.Вставить("СкрыватьКомандуЦеныНоменклатуры",           Истина);
	ПараметрыФормы.Вставить("Заголовок",                                 НСтр("ru = 'Подбор товаров'"));
	ПараметрыФормы.Вставить("ЗаголовокКнопкиЗапрашиватьКоличествоИЦену", НСтр("ru = 'Запрашивать количество'"));
	ПараметрыФормы.Вставить("Дата",                                      Объект.Дата);
	ПараметрыФормы.Вставить("Документ",                                  Объект.Ссылка);
	ПараметрыФормы.Вставить("КлючНазначенияИспользования",				 "ПростойПодборНоменклатуры");
	ПараметрыФормы.Вставить("ВидимостьСерий",				 			 Истина);

	масПараметр = ПолучитьМассивТиповНоменклаутры();
	ПараметрыФормы.Вставить("ОтборПоТипуНоменклатуры",	масПараметр);
	
	ОткрытьФорму("Обработка.торо_ПодборНоменклатуры.Форма", ПараметрыФормы, ЭтаФорма, УникальныйИдентификатор);
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьМассивТиповНоменклаутры()
	масПараметр = Новый Массив();
	Для каждого текСтрока из Перечисления.ТипыНоменклатуры Цикл
		Если текСтрока = Перечисления.ТипыНоменклатуры.Услуга Тогда Продолжить; КонецЕсли;
		масПараметр.Добавить(текСтрока);
	КонецЦикла;
	
	Возврат масПараметр;
КонецФункции

&НаСервере 
Процедура ДобавитьНоменклатуруИзПодбора(Адрес)
	
	ТаблицаПодбора = ПолучитьИзВременногоХранилища(Адрес);
	СтруктураДействий = Новый Структура;
	
	Для каждого текСтрока из ТаблицаПодбора Цикл
		
		НайденныеСтроки = Объект.Товары.НайтиСтроки(Новый Структура("Номенклатура, Характеристика, Серия", 
			текСтрока.Номенклатура, текСтрока.Характеристика, текСтрока.Серия));
		Если НайденныеСтроки.Количество() = 0 Тогда
			НоваяСтрока = Объект.Товары.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, текСтрока);
			НоваяСтрока.Количество = текСтрока.КоличествоУпаковок;
		Иначе
			НоваяСтрока = НайденныеСтроки[0];
			НоваяСтрока.Количество = НоваяСтрока.Количество + текСтрока.КоличествоУпаковок;
		КонецЕсли;
		
		ОбработкаТабличнойЧастиВызовСервера.ОбработатьСтрокуТЧ(НоваяСтрока, СтруктураДействий, Неопределено);		
		
		Модифицированность = Истина;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти