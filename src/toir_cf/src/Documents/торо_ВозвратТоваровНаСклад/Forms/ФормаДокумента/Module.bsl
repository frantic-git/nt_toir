&НаКлиенте
Перем КэшированныеЗначения; // используется механизмом обработки изменения реквизитов ТЧ

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства

	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтаФорма);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтаФорма);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПриЧтенииСозданииНаСервере();
	КонецЕсли;
	
	торо_РаботаСДиалогами.УстановитьЗаголовокФормыДокумента(Объект, ЭтаФорма, "");
	
	Если Параметры.ЗначенияЗаполнения.Свойство("ИзРабочегоМестаПередачаВозврат") Тогда
		ИзРабочегоМестаПередачаВозврат = Параметры.ЗначенияЗаполнения.ИзРабочегоМестаПередачаВозврат;	
	ИначеЕсли Параметры.Свойство("ИзРабочегоМестаПередачаВозврат") Тогда 
		ИзРабочегоМестаПередачаВозврат = Параметры.ИзРабочегоМестаПередачаВозврат;
	Иначе
		ИзРабочегоМестаПередачаВозврат = Ложь;
	КонецЕсли;
	
	УстановитьУсловноеОформление();	 
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
	
	ПриЧтенииСозданииНаСервере();
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииСозданииНаСервере()
	ЗаполнитьСлужебныеРеквизитыПоНоменклатуре();
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	// СтандартныеПодсистемы.Свойства
    УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	Если ИзРабочегоМестаПередачаВозврат И НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда 
		Модифицированность = Истина;
	КонецЕсли;

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
	
	ЗаполнитьСлужебныеРеквизитыПоНоменклатуре();
	
	// Заголовок формы++
	торо_РаботаСДиалогами.УстановитьЗаголовокФормыДокумента(Объект, ЭтаФорма, "");
	// Заголовок формы--
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
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Если ИзРабочегоМестаПередачаВозврат Тогда 
		ПараметрыОбновления = Новый Структура("Проведен", ПараметрыЗаписи.РежимЗаписи <> РежимЗаписиДокумента.Запись);
		Оповестить("ВозвратТовараЗаписан", ПараметрыОбновления); 
	КонецЕсли;
	
	ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
	
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
Процедура ЗаказНаВнутреннееПотреблениеОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	Если ТипЗнч(ВыбранноеЗначение) <> Тип("Тип") Тогда 
		Если ВыбранноеЗначение <> Объект.ЗаказНаВнутреннееПотребление Тогда
			Если ЗначениеЗаполнено(Объект.Товары) Тогда
				СтандартнаяОбработка = Ложь; 
				ОповещениеОбОтвете = Новый ОписаниеОповещения("ЗавершитьВыборРаспоряжения", ЭтаФорма, Новый Структура("НовыйДокумент", ВыбранноеЗначение));
				ПоказатьВопрос(ОповещениеОбОтвете, 
					НСтр("ru = 'Табличная часть будет перезаполнена по выбранному заказу на внутреннее потребление. Продолжить?'"), 
					РежимДиалогаВопрос.ДаНет);
			Иначе
				ПолучитьТабличнуюЧастьПоЗаказу(ВыбранноеЗначение);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СкладПриИзменении(Элемент)
	ЕстьЗаполненныйСклад = Ложь;
	Для Каждого Строка Из Объект.Товары Цикл
		Если ЗначениеЗаполнено(Строка.Склад) Тогда
			ЕстьЗаполненныйСклад = Истина;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Если ЕстьЗаполненныйСклад Тогда
		Оповещение = Новый ОписаниеОповещения("ВопросОПерезаполненииСкладаЗавершение", ЭтотОбъект);
		ТекстВопроса = НСтр("ru='Перезаполнить склад в табличной части?'");
		ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	Иначе
		ЗаполнитьСкладИзШапки(Истина);
	КонецЕсли;
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
	СтруктураДействий.Вставить("ПроверитьЗаполнитьУпаковкуПоВладельцу", ТекущаяСтрока.Упаковка);
	СтруктураДействий.Вставить("ПересчитатьКоличествоЕдиниц");
	СтруктураДействий.Вставить("НоменклатураПриИзмененииПереопределяемый", Новый Структура("ИмяФормы, ИмяТабличнойЧасти",
		ЭтаФорма.ИмяФормы, "Товары"));

	ОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущаяСтрока, СтруктураДействий, КэшированныеЗначения);
	ТекущаяСтрока.ХарактеристикиИспользуются = торо_НоменклатураСервер.ПолучитьХарактеристикиИспользуются(ТекущаяСтрока.Номенклатура);
	ТекущаяСтрока.СерииИспользуются = ПолучитьСерииИспользуются(ТекущаяСтрока.Номенклатура);
	ТекущаяСтрока.Серия = Неопределено;
КонецПроцедуры

&НаКлиенте
Процедура ТоварыКоличествоУпаковокПриИзменении(Элемент)
	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	СтруктураДействий = Новый Структура;
	СтруктураДействий.Вставить("ПересчитатьКоличествоЕдиниц");
	ОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущаяСтрока, СтруктураДействий, КэшированныеЗначения);
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
	ПараметрыПолученияДанных.Отбор.Вставить("ВидНоменклатуры", ВидНоменклатуры);
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
Процедура ТоварыСерияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ТекДанные =  Элементы.Товары.ТекущиеДанные;
	Если Не ТекДанные = Неопределено Тогда
		СтандартнаяОбработка = Ложь;
		ВидНоменклатуры = торо_ОбщегоНазначенияВызовСервера.ЗначениеРеквизитаОбъекта(ТекДанные.Номенклатура, "ВидНоменклатуры");
		ПараметрыФормы = Новый Структура("Отбор", Новый Структура("ВидНоменклатуры", ВидНоменклатуры));
		ОткрытьФорму("Справочник.СерииНоменклатуры.ФормаВыбора", ПараметрыФормы, Элемент);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

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

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьСлужебныеРеквизитыПоНоменклатуре()
	
	НоменклатураСервер.ЗаполнитьСлужебныеРеквизитыПоНоменклатуреВКоллекции(
		Объект.Товары,
		Новый Структура("ЗаполнитьПризнакХарактеристикиИспользуются, ЗаполнитьПризнакТипНоменклатуры, ЗаполнитьПризнакАртикул, ЗаполнитьПризнакСерииИспользуются",
			Новый Структура("Номенклатура", "ХарактеристикиИспользуются"),
			Новый Структура("Номенклатура", "ТипНоменклатуры"),
			Новый Структура("Номенклатура", "Артикул"),
			Новый Структура("Номенклатура", "СерииИспользуются")));
	
КонецПроцедуры

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
Процедура УстановитьУсловноеОформление() 
	// Оформление серий
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТоварыСерия.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.Товары.СерииИспользуются");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", WebЦвета.НейтральноСерый);
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru = '<серии не используются>'"));
	Элемент.Оформление.УстановитьЗначениеПараметра("ОтметкаНезаполненного", Ложь);
	Элемент.Оформление.УстановитьЗначениеПараметра("Доступность", Ложь);
	
	// Оформление упаковок
	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТоварыНоменклатураЕдиницаИзмерения.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.Товары.Упаковка");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Заполнено;
	Элемент.Оформление.УстановитьЗначениеПараметра("Отображать", Ложь);
	
	// Оформление характеристик
	Элемент = УсловноеОформление.Элементы.Добавить();

	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ТоварыХарактеристика.Имя);

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.Товары.ХарактеристикиИспользуются");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.ТекстЗапрещеннойЯчейкиЦвет);
	Элемент.Оформление.УстановитьЗначениеПараметра("ОтметкаНезаполненного", Ложь);
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru = '<характеристики не используются>'"));
	Элемент.Оформление.УстановитьЗначениеПараметра("ТолькоПросмотр", Истина);
КонецПроцедуры

&НаСервере
Процедура ПолучитьТабличнуюЧастьПоЗаказу(ЗаказНаВнутреннееПотребление, Ошибка = Ложь)
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ТоварыНаРуках.Номенклатура КАК Номенклатура,
	               |	ТоварыНаРуках.Характеристика КАК Характеристика,
	               |	ТоварыНаРуках.Склад КАК Склад,
	               |	ТоварыНаРуках.Серия КАК Серия,
	               |	ТоварыНаРуках.КоличествоОстаток КАК Количество,
	               |	ТоварыНаРуках.КоличествоОстаток КАК КоличествоУпаковок
	               |ИЗ
	               |	РегистрНакопления.торо_ТоварыНаРуках.Остатки(, ЗаказНаВнутреннееПотребление = &ЗаказНаВнутреннееПотребление) КАК ТоварыНаРуках";
	Запрос.УстановитьПараметр("ЗаказНаВнутреннееПотребление", ЗаказНаВнутреннееПотребление);
	Если НЕ Константы.ИспользоватьСерииНоменклатуры.Получить() Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ТоварыНаРуках.Серия", """""");
	КонецЕсли;
	Если НЕ Константы.торо_ИспользоватьХарактеристикиНоменклатуры.Получить() Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ТоварыНаРуках.Характеристика", """""");
	КонецЕсли;
	РезЗапроса = Запрос.Выполнить();
	Если РезЗапроса.Пустой() Тогда
		ОбщегоНазначения.СообщитьПользователю(НСтр("ru = 'Для выбранного заказа на внутреннее потребление нет доступных к возврату на склад товаров, выданных на руки.'"));
		Ошибка = Истина;
	Иначе
		Объект.Товары.Загрузить(Запрос.Выполнить().Выгрузить());
		ЗаполнитьСлужебныеРеквизитыПоНоменклатуре();
	КонецЕсли;
КонецПроцедуры

&НаСервере
Функция ПолучитьСерииИспользуются(Номенклатура)
	Возврат Номенклатура.ВидНоменклатуры.ИспользоватьСерии;
КонецФункции

&НаКлиенте
Процедура ЗавершитьВыборРаспоряжения(Результат, ДопПараметры) Экспорт
	Если Результат = КодВозвратаДиалога.Да Тогда
		Ошибка = Ложь;
		ПолучитьТабличнуюЧастьПоЗаказу(ДопПараметры.НовыйДокумент, Ошибка);
		Объект.ЗаказНаВнутреннееПотребление = ДопПараметры.НовыйДокумент;
		Если Ошибка Тогда 
			Объект.Товары.Очистить();
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьСкладИзШапки(ПерезаполнятьСклад)
	Для Каждого Строка Из Объект.Товары Цикл
		Если НЕ ЗначениеЗаполнено(Строка.Склад) ИЛИ ПерезаполнятьСклад Тогда
			Строка.Склад = Объект.Склад;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ВопросОПерезаполненииСкладаЗавершение(Результат, ДополнительныеПараметры) Экспорт
	ПерезаполнятьСклад = (Результат = КодВозвратаДиалога.Да);
	ЗаполнитьСкладИзШапки(ПерезаполнятьСклад);
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьМассивТиповНоменклаутры()
	масПараметр = Новый Массив();
	Для каждого текСтрока из Перечисления.ТипыНоменклатуры Цикл
		Если текСтрока = Перечисления.ТипыНоменклатуры.Услуга
			ИЛИ текСтрока = Перечисления.ТипыНоменклатуры.Работа Тогда Продолжить; КонецЕсли;
		масПараметр.Добавить(текСтрока);
	КонецЦикла;
	
	Возврат масПараметр;
КонецФункции

&НаСервере 
Процедура ДобавитьНоменклатуруИзПодбора(Адрес)
	
	ТаблицаПодбора = ПолучитьИзВременногоХранилища(Адрес);
	
	Для каждого текСтрока из ТаблицаПодбора Цикл
		
		НайденныеСтроки = Объект.Товары.НайтиСтроки(Новый Структура("Номенклатура, Характеристика, Серия", 
			текСтрока.Номенклатура, текСтрока.Характеристика, текСтрока.Серия));
		Если НайденныеСтроки.Количество() = 0 Тогда
			НоваяСтрока = Объект.Товары.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, текСтрока);
			НоваяСтрока.Количество = текСтрока.КоличествоУпаковок;
		Иначе
			НоваяСтрока = НайденныеСтроки[0];
			НоваяСтрока.КоличествоУпаковок = НоваяСтрока.КоличествоУпаковок + текСтрока.КоличествоУпаковок;
		КонецЕсли;
		
		Модифицированность = Истина;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
