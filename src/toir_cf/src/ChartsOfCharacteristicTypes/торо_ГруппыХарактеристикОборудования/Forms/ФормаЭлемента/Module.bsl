
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		Объект.ТипЗначения = Новый ОписаниеТипов("Число");
	КонецЕсли;
	
	ОбновитьДоступностьТаблиц(ЭтаФорма);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПодборХарактеристик(Команда)
	
	ПараметрыФормы = Новый Структура("ТипЗначения, ЗакрыватьПриВыборе", Объект.ТипЗначения, Ложь);
	ОткрытьФорму("ПланВидовХарактеристик.торо_ГруппыХарактеристикОборудования.Форма.ФормаПодбораХарактеристик", ПараметрыФормы, Элементы.СписокХарактеристик, Объект.Ссылка,,,,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ПодборПараметров(Команда)
	
	ПараметрыФормы = Новый Структура("ЗакрыватьПриВыборе", Ложь);
	ОткрытьФорму("ПланВидовХарактеристик.торо_ГруппыХарактеристикОборудования.Форма.ФормаПодбораНаименований", ПараметрыФормы, Элементы.ПараметрыАвтозаполнения, Объект.Ссылка,,,,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ЗаполнятьАвтоматическиПриИзменении(Элемент)
	ОбновитьДоступностьТаблиц(ЭтаФорма);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыПараметрыАвтозаполнения

&НаКлиенте
Процедура ПараметрыАвтозаполненияНаименованиеХарактеристикиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ПараметрыФормы = Новый Структура("ЗакрыватьПриВыборе", Истина);
	ОткрытьФорму("ПланВидовХарактеристик.торо_ГруппыХарактеристикОборудования.Форма.ФормаПодбораНаименований", ПараметрыФормы, Элемент, Объект.Ссылка,,,,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ПараметрыАвтозаполненияНаименованиеХарактеристикиОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если ТипЗнч(ВыбранноеЗначение) = Тип("Строка") Тогда  
		МассивСтрок = Объект.ПараметрыАвтозаполнения.НайтиСтроки(Новый Структура("НаименованиеХарактеристики", ВыбранноеЗначение));
		Если МассивСтрок.Количество() > 0 Тогда
			ТекстСообщения = НСтр("ru = 'Этот параметр автозаполнения уже добавлен'");
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
			СтандартнаяОбработка = Ложь;
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПараметрыАвтозаполненияОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если ТипЗнч(ВыбранноеЗначение) = Тип("Строка") Тогда  
		МассивСтрок = Объект.ПараметрыАвтозаполнения.НайтиСтроки(Новый Структура("НаименованиеХарактеристики", ВыбранноеЗначение));
		Если МассивСтрок.Количество() > 0 Тогда
			ТекстСообщения = НСтр("ru = 'Этот параметр автозаполнения уже добавлен'");
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
			Возврат;
		КонецЕсли;
		
		НСтр = Объект.ПараметрыАвтозаполнения.Добавить();
		НСтр.НаименованиеХарактеристики = ВыбранноеЗначение;
	КонецЕсли;	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписокХарактеристик

&НаКлиенте
Процедура СписокХарактеристикХарактеристикаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ПараметрыФормы = Новый Структура("ТипЗначения, ЗакрыватьПриВыборе", Объект.ТипЗначения, Истина);
	ОткрытьФорму("ПланВидовХарактеристик.торо_ГруппыХарактеристикОборудования.Форма.ФормаПодбораХарактеристик", ПараметрыФормы, Элемент, Объект.Ссылка,,,,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокХарактеристикХарактеристикаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если ВыбранноеЗначение <> Неопределено Тогда
		ТипЗначенияСовпадает = ПроверитьТипЗначения(ВыбранноеЗначение, Объект.ТипЗначения);
		Если НЕ ТипЗначенияСовпадает Тогда
			ТекстСообщения = НСтр("ru = 'Характеристика не соответсвует указанному типу значения'");
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
			СтандартнаяОбработка = Ложь;
			Возврат;
		КонецЕсли;
		
		МассивСтрок = Объект.СписокХарактеристик.НайтиСтроки(Новый Структура("Характеристика", ВыбранноеЗначение));
		Если МассивСтрок.Количество() > 0 Тогда
			ТекстСообщения = НСтр("ru = 'Эта характеристика уже добавлена'");
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
			СтандартнаяОбработка = Ложь;
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокХарактеристикОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если ТипЗнч(ВыбранноеЗначение) = Тип("ПланВидовХарактеристикСсылка.ДополнительныеРеквизитыИСведения") Тогда
		МассивСтрок = Объект.СписокХарактеристик.НайтиСтроки(Новый Структура("Характеристика", ВыбранноеЗначение));
		Если МассивСтрок.Количество() > 0 Тогда
			ТекстСообщения = НСтр("ru = 'Эта характеристика уже добавлена'");
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
			Возврат;
		КонецЕсли;
		
		НСтр = Объект.СписокХарактеристик.Добавить();
		НСтр.Характеристика = ВыбранноеЗначение;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьДоступностьТаблиц(Форма)
	
	Элементы = Форма.Элементы;
	ЗаполнятьАвтоматически = Форма.Объект.ЗаполнятьАвтоматически;
	
	Элементы.СписокХарактеристик.ТолькоПросмотр = ЗаполнятьАвтоматически;
	Элементы.ПараметрыАвтозаполнения.Видимость = ЗаполнятьАвтоматически;
	Элементы.СписокХарактеристикПодборХарактеристик.Доступность = НЕ ЗаполнятьАвтоматически;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПроверитьТипЗначения(Характеристика, ТипЗначения)
	
	Возврат ПланыВидовХарактеристик.торо_ГруппыХарактеристикОборудования.ТипЗначенияПодходит(ТипЗначения, Характеристика.ТипЗначения);
	
КонецФункции

#КонецОбласти



