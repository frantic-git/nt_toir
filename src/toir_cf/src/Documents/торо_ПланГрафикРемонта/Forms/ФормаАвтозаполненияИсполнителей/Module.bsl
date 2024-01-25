&НаКлиенте
Перем МассивВыбранныхВидовРемонтов;

#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("ДокументППР") Тогда
		ДокументППР = Параметры.ДокументППР;
	КонецЕсли;
	
	Если Параметры.Свойство("ТаблицаРемонтовИзППР") Тогда
		ТаблицаРемонтовИзППР.Загрузить(Параметры.ТаблицаРемонтовИзППР.Выгрузить());
	Иначе
		ТаблицаРемонтовИзППР.Загрузить(ДокументППР.ПланРемонтов.Выгрузить());
	КонецЕсли;
	
	Для каждого Ремонт Из ТаблицаРемонтовИзППР Цикл
	    Если ЗначениеЗаполнено(Ремонт.Исполнитель) Тогда
		    Ремонт.ИсполнительЗаполнен = Истина;
		Иначе
			Ремонт.ИсполнительЗаполнен = Ложь;
		КонецЕсли; 
	КонецЦикла; 
	
	Если Параметры.Свойство("МассивДоступныхДляКорректировкиСтрок") Тогда 
		Для Каждого СтрокаДоступности Из Параметры.МассивДоступныхДляКорректировкиСтрок Цикл
			Если СтрокаДоступности.ДоступенДляРедактирования Тогда
				СтрокиРемонта = ТаблицаРемонтовИзППР.НайтиСтроки(Новый Структура("ID", СтрокаДоступности.ID));
				Если СтрокиРемонта.Количество() > 0 И Не СтрокиРемонта[0].Замещен Тогда
					СтрокиРемонта[0].ДоступенДляРедактирования = Истина;
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Элементы.ДокументППР.Заголовок = Строка(ДокументППР);
	
	ТолькоДляНеустановленныхИсполнителей = Истина;
	НеОчищатьИсполнителей = Истина;
	НеМенятьСпособВыполнения = Истина;
		
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	УстановитьФлажки(Элементы.ТаблицаРемонтовИзППРУстановитьФлажки);
	УстановитьДоступностьКонтрагентаПодразделения();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СпособВыполненияПриИзменении(Элемент)
	УстановитьДоступностьКонтрагентаПодразделения();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура УстановитьФлажки(Команда)
	
	Для каждого СтрокаТабличнойЧасти Из ТаблицаРемонтовИзППР Цикл
		СтрокаТабличнойЧасти.Пометка = СтрокаТабличнойЧасти.ДоступенДляРедактирования;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьФлажки(Команда)
	         
	Для каждого СтрокаТабличнойЧасти Из ТаблицаРемонтовИзППР Цикл
		СтрокаТабличнойЧасти.Пометка = Ложь;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ИнвертироватьФлажки(Команда)
	
	Для каждого СтрокаТабличнойЧасти Из ТаблицаРемонтовИзППР Цикл
		СтрокаТабличнойЧасти.Пометка = (Не СтрокаТабличнойЧасти.Пометка И СтрокаТабличнойЧасти.ДоступенДляРедактирования);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыборПоВидуРемонта(Команда)
	
	МассивВидовРемонтов = Новый Массив;
	Для каждого Ремонт Из ТаблицаРемонтовИзППР Цикл
	    Если МассивВидовРемонтов.Найти(Ремонт.ВидРемонтныхРабот) = Неопределено Тогда
			МассивВидовРемонтов.Добавить(Ремонт.ВидРемонтныхРабот);
		КонецЕсли; 
	КонецЦикла; 
	
	ПараметрыФормы = Новый Структура("ДокументППР, МассивВыбранныхВидовРемонтов, МассивВидовРемонтов", ДокументППР, МассивВыбранныхВидовРемонтов, МассивВидовРемонтов);
	ОписаниеОповещения = Новый ОписаниеОповещения("ВыборПоВидуРемонтаЗавершение", ЭтотОбъект);
	ОткрытьФорму("Документ.торо_ПланГрафикРемонта.Форма.ФормаВыбораВидовРемонтов", ПараметрыФормы, Элементы.ТаблицаРемонтовИзППР,,,,ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыборПоВидуРемонтаЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Массив") Тогда
		Для каждого СтрокаТЗ Из ТаблицаРемонтовИзППР Цикл
			Если СтрокаТЗ.ДоступенДляРедактирования Тогда
				СтрокаТЗ.Пометка = Истина;
			    Если Результат.Найти(СтрокаТЗ.ВидРемонтныхРабот) = Неопределено Тогда
					СтрокаТЗ.Пометка = Ложь;
				КонецЕсли;
			КонецЕсли; 			
		КонецЦикла;
		
		МассивВыбранныхВидовРемонтов = Результат;
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура НезаполненныеИсполнителиПриИзменении(Элемент)
	Если НезаполненныеИсполнители Тогда
		Элементы.ТаблицаРемонтовИзППР.ОтборСтрок = Новый ФиксированнаяСтруктура("ИсполнительЗаполнен", Ложь);
	Иначе
		Элементы.ТаблицаРемонтовИзППР.ОтборСтрок = Неопределено;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьИсполнителей(Команда)
	
	СтруктураВозврата = ПолучитьПредопределенныеЗначенияНаСервере();
	СпособыСтроительстваПустаяСсылка = СтруктураВозврата.СпособыСтроительстваПустаяСсылка;
	СпособыСтроительстваХозспособ = СтруктураВозврата.СпособыСтроительстваХозспособ;
	СпособыСтроительстваПодрядный = СтруктураВозврата.СпособыСтроительстваПодрядный;
	СтруктураПредприятияПустаяСсылка = СтруктураВозврата.СтруктураПредприятияПустаяСсылка;
	КонтрагентыПустаяСсылка = СтруктураВозврата.КонтрагентыПустаяСсылка;
	
	Для каждого СтрокаТабличнойЧасти Из ТаблицаРемонтовИзППР Цикл
		ИзменятьСтроку = СтрокаТабличнойЧасти.Пометка И (НезаполненныеИсполнители И Не СтрокаТабличнойЧасти.ИсполнительЗаполнен Или Не НезаполненныеИсполнители);
		Если ИзменятьСтроку Тогда
			Если СтрокаТабличнойЧасти.СпособВыполнения = Неопределено 
				ИЛИ СтрокаТабличнойЧасти.СпособВыполнения = СпособыСтроительстваПустаяСсылка
				ИЛИ НЕ НеМенятьСпособВыполнения Тогда
				Если Не СтрокаТабличнойЧасти.СпособВыполнения = СпособВыполнения Тогда
					СтрокаТабличнойЧасти.СпособВыполнения = СпособВыполнения;
					СтрокаТабличнойЧасти.Исполнитель = Неопределено;
				КонецЕсли;
			КонецЕсли;
			Если СтрокаТабличнойЧасти.СпособВыполнения = СпособыСтроительстваХозспособ Тогда 
				Если НЕ Подразделение = СтруктураПредприятияПустаяСсылка 
					или (Подразделение = СтруктураПредприятияПустаяСсылка и НЕ НеОчищатьИсполнителей) Тогда 
					Если СтрокаТабличнойЧасти.Исполнитель = СтруктураПредприятияПустаяСсылка
						или НЕ ТолькоДляНеустановленныхИсполнителей 
						или СтрокаТабличнойЧасти.Исполнитель = Неопределено 
						или (ТолькоДляНеустановленныхИсполнителей и СтрокаТабличнойЧасти.Исполнитель = Неопределено)Тогда 
						СтрокаТабличнойЧасти.Исполнитель = Подразделение;
						торо_ЗаполнениеДокументовКлиент.ЗаполнитьСклад(СтрокаТабличнойЧасти.Исполнитель, СтрокаТабличнойЧасти.Склад);
						СтрокаТабличнойЧасти.ИсполнительЗаполнен = ?(ЗначениеЗаполнено(Подразделение), Истина, Ложь);
					КонецЕсли;
				КонецЕсли;
			ИначеЕсли СтрокаТабличнойЧасти.СпособВыполнения = СпособыСтроительстваПодрядный Тогда 
				Если Не Контрагент = КонтрагентыПустаяСсылка
					или (Контрагент = КонтрагентыПустаяСсылка и НЕ НеОчищатьИсполнителей) Тогда 
					Если СтрокаТабличнойЧасти.Исполнитель = КонтрагентыПустаяСсылка 
						или НЕ ТолькоДляНеустановленныхИсполнителей
						или СтрокаТабличнойЧасти.Исполнитель = Неопределено 
						или (ТолькоДляНеустановленныхИсполнителей и (СтрокаТабличнойЧасти.Исполнитель = КонтрагентыПустаяСсылка или СтрокаТабличнойЧасти.Исполнитель = Неопределено))Тогда 
						СтрокаТабличнойЧасти.Исполнитель = Контрагент;
						СтрокаТабличнойЧасти.ИсполнительЗаполнен = ?(ЗначениеЗаполнено(Контрагент), Истина, Ложь);
					КонецЕсли;
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Если НезаполненныеИсполнители Тогда
		Элементы.ТаблицаРемонтовИзППР.ОтборСтрок = Новый ФиксированнаяСтруктура("ИсполнительЗаполнен", Ложь);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОК(Команда)
	
	СоответствиеИсполнителей = Новый Соответствие;
	Для каждого Строка из ТаблицаРемонтовИзППР Цикл
		СоответствиеИсполнителей.Вставить(Строка.ID, Строка);
	КонецЦикла;
	
	Закрыть(СоответствиеИсполнителей);
	
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
&НаСервереБезКонтекста
Функция ПолучитьПредопределенныеЗначенияНаСервере()
	
	Возврат Новый Структура("СпособыСтроительстваПустаяСсылка, СпособыСтроительстваХозспособ, СпособыСтроительстваПодрядный, СтруктураПредприятияПустаяСсылка, КонтрагентыПустаяСсылка",
	Перечисления.СпособыСтроительства.ПустаяСсылка(), Перечисления.СпособыСтроительства.Хозспособ, Перечисления.СпособыСтроительства.Подрядный, Справочники.СтруктураПредприятия.ПустаяСсылка(), Справочники.Контрагенты.ПустаяСсылка());
	
Конецфункции

&НаКлиенте
Процедура УстановитьДоступностьКонтрагентаПодразделения()
	
	СпособВыполненияЗаполнен = ЗначениеЗаполнено(СпособВыполнения);
	ДоступностьЭлементов = (СпособВыполнения = ПредопределенноеЗначение("Перечисление.СпособыСтроительства.Хозспособ"));
	Элементы.Контрагент.Доступность = СпособВыполненияЗаполнен И НЕ ДоступностьЭлементов;
	Элементы.Подразделение.Доступность = СпособВыполненияЗаполнен И ДоступностьЭлементов;
	
	Если НЕ Элементы.Контрагент.Доступность Тогда
		Контрагент = ПредопределенноеЗначение("Справочник.Контрагенты.ПустаяСсылка");
	КонецЕсли;
	
	Если НЕ Элементы.Подразделение.Доступность Тогда
		Подразделение = ПредопределенноеЗначение("Справочник.СтруктураПредприятия.ПустаяСсылка");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаРемонтовИзППРПередНачаломИзменения(Элемент, Отказ)
	Если Не Элементы.ТаблицаРемонтовИзППР.ТекущиеДанные.ДоступенДляРедактирования Тогда
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаРемонтовИзППРПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	ТекДанные = Элементы.ТаблицаРемонтовИзППР.ТекущиеДанные;
	
	Если ЗначениеЗаполнено(ТекДанные.Исполнитель) Тогда
	    ТекДанные.ИсполнительЗаполнен = Истина;
		Если НезаполненныеИсполнители Тогда
		    Элементы.ТаблицаРемонтовИзППР.ОтборСтрок = Новый ФиксированнаяСтруктура("ИсполнительЗаполнен", Ложь);
		КонецЕсли; 
	Иначе
	    ТекДанные.ИсполнительЗаполнен = Ложь;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаРемонтовИзППРСпособВыполненияПриИзменении(Элемент)
	ТекущиеДанные = Элементы.ТаблицаРемонтовИзППР.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		Если ТекущиеДанные.СпособВыполнения = ПредопределенноеЗначение("Перечисление.СпособыСтроительства.Хозспособ") Тогда
			ТекущиеДанные.Исполнитель = ПредопределенноеЗначение("Справочник.СтруктураПредприятия.ПустаяСсылка");
		Иначе	
			ТекущиеДанные.Исполнитель = ПредопределенноеЗначение("Справочник.Контрагенты.ПустаяСсылка");
		КонецЕсли; 
	КонецЕсли;
КонецПроцедуры

#КонецОбласти
