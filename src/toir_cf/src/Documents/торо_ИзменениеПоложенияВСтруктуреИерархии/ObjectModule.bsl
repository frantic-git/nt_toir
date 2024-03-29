#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПЕРЕМЕННЫЕ
Перем БезусловнаяЗапись Экспорт; // Отключает проверки при записи документа

перем СтруктураДанных Экспорт;  // Структура, хранящая данные для работы с уведомлениями.

#Область ОбработчикиСобытий
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Организация = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("НастройкиТОиР", "ОсновнаяОрганизация", Истина);
	Подразделение = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("НастройкиТОиР", "ОсновноеПодразделение", Истина);
	Ответственный = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("НастройкиТОиР", "ОсновнойОтветственный", Справочники.Пользователи.ПустаяСсылка());
	
	Если НЕ ЗначениеЗаполнено(Ответственный) тогда
		Ответственный = Пользователи.ТекущийПользователь();
	КонецЕсли;

	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		
		Если ДанныеЗаполнения.Свойство("СтруктураИерархии") Тогда
			СтруктураИерархии = ДанныеЗаполнения.СтруктураИерархии;	
		КонецЕсли;
		
		Если ДанныеЗаполнения.Свойство("Организация") Тогда
			Организация = ДанныеЗаполнения.Организация;	
		КонецЕсли;

		Если ДанныеЗаполнения.Свойство("Подразделение") Тогда
			Подразделение = ДанныеЗаполнения.Подразделение;	
		КонецЕсли;
		
		Если ДанныеЗаполнения.Свойство("РодительИерархии") И ТипЗнч(ДанныеЗаполнения.РодительИерархии) = Тип("СправочникСсылка.торо_ОбъектыРемонта") Тогда
			РодительИерархии = ДанныеЗаполнения.РодительИерархии;
		Иначе
			РодительИерархии = Справочники.торо_ОбъектыРемонта.ПустаяСсылка();
		КонецЕсли;
		
		// Параметр МассивУдаляемых сохранен для совместимости со старыми функциями работы с иерархией до удаления модулей.
		// В РаботаСИерархией20 не используется, вместо него используется параметр Удаление.
		МассивУдаляемых = Неопределено;
		ДанныеЗаполнения.Свойство("МассивУдаляемых", МассивУдаляемых);
		
		Если ДанныеЗаполнения.Свойство("ОбъектИерархии") И ЗначениеЗаполнено(ДанныеЗаполнения.ОбъектИерархии) Тогда
						
			Если ТипЗнч(ДанныеЗаполнения.ОбъектИерархии) = Тип("СправочникСсылка.торо_ОбъектыРемонта") Тогда
				
				Если ДанныеЗаполнения.Свойство("ПредыдущееПоложение") Тогда
					ПредыдущееПоложение = ДанныеЗаполнения.ПредыдущееПоложение;
				Иначе
					ПредыдущееПоложение = торо_РаботаСИерархией20.ПолучитьТекущегоРодителяВИерархии(ДанныеЗаполнения.ОбъектИерархии, СтруктураИерархии);
				КонецЕсли;
				
				НС = ПоложенияВСтруктуреИерархии.Добавить();
				НС.ОбъектИерархии = ДанныеЗаполнения.ОбъектИерархии;
				НС.РодительИерархии = РодительИерархии;
				НС.ПредыдущееПоложение = ПредыдущееПоложение;
				
				Если ДанныеЗаполнения.Свойство("Удаление") Тогда
					НС.Удален = ДанныеЗаполнения.Удаление;
				ИначеЕсли МассивУдаляемых <> Неопределено Тогда
					НС.Удален = МассивУдаляемых.Найти(НС.ОбъектИерархии) <> Неопределено;
				КонецЕсли;
				
			ИначеЕсли ТипЗнч(ДанныеЗаполнения.ОбъектИерархии) = Тип("Массив") Тогда	
				
				Если ДанныеЗаполнения.Свойство("ИерархияИсточник") Тогда
				// Выполняется перенос из другой структуры иерархии.	
					
					Ветка = торо_РаботаСИерархией20.ПолучитьТекущихРодителейВИерархии(ДанныеЗаполнения.ОбъектИерархии,	ДанныеЗаполнения.ИерархияИсточник);
						
					ПреобразованнаяТаблица = торо_РаботаСИерархией20.ПреобразоватьТаблицуРодителейВИерархииДляПереноса(Ветка, ДанныеЗаполнения.РодительИсточник);	
					
					НеСохранятьИерархию = Ложь;
					Если ДанныеЗаполнения.Свойство("НеСохранятьИерархию") Тогда
						НеСохранятьИерархию = ДанныеЗаполнения.НеСохранятьИерархию;
					КонецЕсли;
					
					Для Каждого КлючИЗначение Из ПреобразованнаяТаблица Цикл
						
						НС = ПоложенияВСтруктуреИерархии.Добавить();
						НС.ОбъектИерархии = КлючИЗначение.Ключ;
						НС.РодительИерархии = ?(КлючИЗначение.Ключ = ДанныеЗаполнения.РодительИсточник ИЛИ НеСохранятьИерархию = Истина, РодительИерархии, КлючИЗначение.Значение);
						НС.ПредыдущееПоложение = КлючИЗначение.Значение;
						
						Если НЕ ЗначениеЗаполнено(НС.ПредыдущееПоложение) Тогда
							НС.ПредыдущееПоложение = "Внесен в структуру иерархии";
						КонецЕсли;
						
						Если ДанныеЗаполнения.Свойство("Удаление") Тогда
							НС.Удален = ДанныеЗаполнения.Удаление;
						ИначеЕсли МассивУдаляемых <> Неопределено Тогда
							НС.Удален = МассивУдаляемых.Найти(НС.ОбъектИерархии) <> Неопределено;
						КонецЕсли;
						
					КонецЦикла;
					
				Иначе
				// Выполняется перенос в пределах текущей структуры иерархии.	
					
					СоответствиеОРИРодителей = торо_РаботаСИерархией20.ПолучитьТекущихРодителейВИерархии(ДанныеЗаполнения.ОбъектИерархии, СтруктураИерархии);
					
					Для Каждого КлючИЗначение Из СоответствиеОРИРодителей Цикл
						
						НС = ПоложенияВСтруктуреИерархии.Добавить();
						НС.ОбъектИерархии = КлючИЗначение.Ключ;
						НС.РодительИерархии = РодительИерархии;
						НС.ПредыдущееПоложение = КлючИЗначение.Значение;
						
						Если ДанныеЗаполнения.Свойство("Удаление") Тогда
							НС.Удален = ДанныеЗаполнения.Удаление;
						ИначеЕсли МассивУдаляемых <> Неопределено Тогда
							НС.Удален = МассивУдаляемых.Найти(НС.ОбъектИерархии) <> Неопределено;
						КонецЕсли;
						
					КонецЦикла;
					
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)

	Движения.торо_РасположениеОРВСтруктуреИерархии.Очистить();
	
	Для Каждого ТекСтрокаПоложенияВСтруктуреИерархии Из ПоложенияВСтруктуреИерархии Цикл
		Движение = Движения.торо_РасположениеОРВСтруктуреИерархии.Добавить();
		Движение.Период = Дата;
		Движение.ОбъектИерархии = ТекСтрокаПоложенияВСтруктуреИерархии.ОбъектИерархии;
		Движение.СтруктураИерархии = СтруктураИерархии;
		Движение.РодительИерархии = ТекСтрокаПоложенияВСтруктуреИерархии.РодительИерархии;
		Движение.Удален = ТекСтрокаПоложенияВСтруктуреИерархии.Удален;
	КонецЦикла;

	Если НЕ ДополнительныеСвойства.Свойство("НеФормироватьДвиженияПоИстоииФМ") Тогда
		ВыполнитьДвиженияПоИсторииФМПриПроведении();
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаУдаленияПроведения(Отказ)
	
	ВыполнитьДвиженияПоИсторииФМПриОтменеПроведения();
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	Если ЭтоНовый() Тогда
		Автор = Пользователи.ТекущийПользователь();
	КонецЕсли;
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ВыполнитьДвиженияПоИсторииФМПриПроведении()
	
	ИспользоватьФункциональныеМеста = ПолучитьФункциональнуюОпцию("торо_ИспользоватьФункциональныеМеста");
	Если НЕ ИспользоватьФункциональныеМеста Тогда
		Возврат;
	КонецЕсли;
	
	СоответствиеУстановка = Новый Соответствие;
	СоответствиеПеремещениеУдаление = Новый Соответствие;
	
	Для каждого Строка из ПоложенияВСтруктуреИерархии Цикл
		Если Строка.Удален Тогда
			ДобавитьЭлементВМассивВСоответствии(СоответствиеПеремещениеУдаление, Строка.РодительИерархии, Строка.ОбъектИерархии); 
		Иначе
			Если ТипЗнч(Строка.ПредыдущееПоложение) = Тип("Строка") Тогда
				ДобавитьЭлементВМассивВСоответствии(СоответствиеУстановка, Строка.РодительИерархии, Строка.ОбъектИерархии);
			Иначе
		   	ДобавитьЭлементВМассивВСоответствии(СоответствиеПеремещениеУдаление, Строка.РодительИерархии, Строка.ОбъектИерархии);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Для каждого ЭлементСоответствия из СоответствиеУстановка Цикл
		торо_РаботаСФункциональнымиМестами.ДобавлениеВИерархию(ЭлементСоответствия.Значение, ЭлементСоответствия.Ключ, СтруктураИерархии);
	КонецЦикла;
	
	Для каждого ЭлементСоответствия из СоответствиеПеремещениеУдаление Цикл
		торо_РаботаСФункциональнымиМестами.Перетаскивание(ЭлементСоответствия.Значение, ЭлементСоответствия.Ключ, СтруктураИерархии);
	КонецЦикла;
	
КонецПроцедуры

Процедура ВыполнитьДвиженияПоИсторииФМПриОтменеПроведения()
	
	ИспользоватьФункциональныеМеста = ПолучитьФункциональнуюОпцию("торо_ИспользоватьФункциональныеМеста");
	Если НЕ ИспользоватьФункциональныеМеста Тогда
		Возврат;
	КонецЕсли;
	
	СоответствиеУстановка = Новый Соответствие;
	СоответствиеПеремещениеУдаление = Новый Соответствие;
	
	Для каждого Строка из ПоложенияВСтруктуреИерархии Цикл
		Если Строка.Удален Тогда
			ДобавитьЭлементВМассивВСоответствии(СоответствиеУстановка, Строка.ПредыдущееПоложение, Строка.ОбъектИерархии); 
		Иначе
			Если ТипЗнч(Строка.ПредыдущееПоложение) = Тип("Строка") Тогда
				ДобавитьЭлементВМассивВСоответствии(СоответствиеПеремещениеУдаление, Строка.ПредыдущееПоложение, Строка.ОбъектИерархии);
			Иначе
		   	ДобавитьЭлементВМассивВСоответствии(СоответствиеПеремещениеУдаление, Строка.ПредыдущееПоложение, Строка.ОбъектИерархии);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Для каждого ЭлементСоответствия из СоответствиеУстановка Цикл
		торо_РаботаСФункциональнымиМестами.ДобавлениеВИерархию(ЭлементСоответствия.Значение, ЭлементСоответствия.Ключ, СтруктураИерархии);
	КонецЦикла;
	
	Для каждого ЭлементСоответствия из СоответствиеПеремещениеУдаление Цикл
		торо_РаботаСФункциональнымиМестами.Перетаскивание(ЭлементСоответствия.Значение, ЭлементСоответствия.Ключ, СтруктураИерархии);
	КонецЦикла;
	
КонецПроцедуры

Процедура ДобавитьЭлементВМассивВСоответствии(СоответствиеЭлементов, Ключ, Элемент)
	
	МассивЭлементов = СоответствиеЭлементов[Ключ];
	Если МассивЭлементов = Неопределено Тогда
		МассивЭлементов = Новый Массив;
		СоответствиеЭлементов.Вставить(Ключ, МассивЭлементов);
	КонецЕсли;
	
	МассивЭлементов.Добавить(Элемент);
	
КонецПроцедуры

#КонецОбласти


#КонецЕсли