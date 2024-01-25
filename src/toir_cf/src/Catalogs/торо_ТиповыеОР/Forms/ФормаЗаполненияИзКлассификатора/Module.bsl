#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ЗаполнитьДеревоИзКлассификатора();
	Элементы.ТипыИзКлассификатора.Отображение = ОтображениеТаблицы.Дерево;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	РазвернутьДерево();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаполнитьИзКлассификатора(Команда)
	ЗаполнитьИзКлассификатораНаСервере();
	ОповеститьОбИзменении(Тип("СправочникСсылка.торо_ТиповыеОР"));
	Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура ОтметитьВсе(Команда)
	СтрокиДерева = ТипыИзКлассификатора.ПолучитьЭлементы();
	Для каждого СтрокаДерева Из СтрокиДерева Цикл
		СтрокаДерева.Выбран = Истина;
		ОбходДереваВниз(СтрокаДерева);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура СнятьПометкуСоВсех(Команда)
	СтрокиДерева = ТипыИзКлассификатора.ПолучитьЭлементы();
	Для каждого СтрокаДерева Из СтрокиДерева Цикл
		СтрокаДерева.Выбран = Ложь;
		ОбходДереваВниз(СтрокаДерева);
	КонецЦикла;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТипыИзКлассификатора

&НаКлиенте
Процедура ТипыИзКлассификатораВыбранПриИзменении(Элемент)
	ТекущиеДанные = Элементы.ТипыИзКлассификатора.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
	    Возврат;
	КонецЕсли;
	
	СтрокаДерева = ТипыИзКлассификатора.НайтиПоИдентификатору(ТекущиеДанные.ПолучитьИдентификатор());
	
	ОбходДереваВверх(СтрокаДерева);
	ОбходДереваВниз(СтрокаДерева);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьДеревоИзКлассификатора()
	Макет = Справочники.торо_ТиповыеОР.ПолучитьМакет("СписокСтандартныхТиповОбъектов");
	
#Область СтандартныеТипыОбъектов
	ОбластьДанных = Макет.ПолучитьОбласть("СтандартныеТипыОбъектов");
	ОбластьЯчеек = Макет.Область(1, 1, ОбластьДанных.ВысотаТаблицы, ОбластьДанных.ШиринаТаблицы);
	
	ПостроительЗапроса = Новый ПостроительЗапроса();
	ПостроительЗапроса.ИсточникДанных = Новый ОписаниеИсточникаДанных(ОбластьЯчеек);
	ПостроительЗапроса.Выполнить();
	РезультатЗапроса = ПостроительЗапроса.Результат;
	
	СтандартныеТипыОбъектов = РезультатЗапроса.Выгрузить();
#КонецОбласти
	
	Запрос = Новый Запрос();
	Запрос.Текст = "ВЫБРАТЬ
	               |	СтандартныеТипыОбъектов.Класс КАК Класс,
	               |	СтандартныеТипыОбъектов.Подкласс КАК Подкласс,
	               |	СтандартныеТипыОбъектов.ОбъектПодкласса КАК ОбъектПодкласса
	               |ПОМЕСТИТЬ ВТ_СтандартныеТипыОбъектов
	               |ИЗ
	               |	&СтандартныеТипыОбъектов КАК СтандартныеТипыОбъектов
	               |
	               |ИНДЕКСИРОВАТЬ ПО
	               |	Класс,
	               |	Подкласс,
	               |	ОбъектПодкласса
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ РАЗРЕШЕННЫЕ
	               |	торо_ТиповыеОР.Ссылка КАК Ссылка,
	               |	торо_ТиповыеОР.Наименование КАК ТОР,
	               |	торо_ТиповыеОР.Родитель.Наименование КАК РодительТОР,
				   |	торо_ТиповыеОР.ЭтоГруппа КАК ЭтоГруппа
	               |ПОМЕСТИТЬ ВТ_ТОР
	               |ИЗ
	               |	Справочник.торо_ТиповыеОР КАК торо_ТиповыеОР
	               |
	               |ИНДЕКСИРОВАТЬ ПО
	               |	ТОР,
	               |	РодительТОР,
				   |	ЭтоГруппа
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ РАЗЛИЧНЫЕ
	               |	ВТ_СтандартныеТипыОбъектов.Класс КАК КлассНаименование,
	               |	ВТ_СтандартныеТипыОбъектов.Подкласс КАК ПодклассНаименование,
	               |	ВТ_СтандартныеТипыОбъектов.ОбъектПодкласса КАК ОбъектПодклассаНаименование,
	               |	ЕСТЬNULL(ВТ_ТОРКлассы.Ссылка, ЗНАЧЕНИЕ(Справочник.торо_ТиповыеОР.ПустаяСсылка)) КАК Класс,
	               |	ЕСТЬNULL(ВТ_ТОРПодклассы.Ссылка, ЗНАЧЕНИЕ(Справочник.торо_ТиповыеОР.ПустаяСсылка)) КАК Подкласс,
	               |	ЕСТЬNULL(ВТ_ТОРОбъектыПодклассов.Ссылка, ЗНАЧЕНИЕ(Справочник.торо_ТиповыеОР.ПустаяСсылка)) КАК ОбъектПодкласса
	               |ИЗ
	               |	ВТ_СтандартныеТипыОбъектов КАК ВТ_СтандартныеТипыОбъектов
	               |		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ТОР КАК ВТ_ТОРКлассы
	               |		ПО ВТ_СтандартныеТипыОбъектов.Класс = ВТ_ТОРКлассы.ТОР
				   |			И ВТ_ТОРКлассы.ЭтоГруппа
	               |		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ТОР КАК ВТ_ТОРПодклассы
	               |		ПО ВТ_СтандартныеТипыОбъектов.Подкласс = ВТ_ТОРПодклассы.ТОР
	               |			И ВТ_СтандартныеТипыОбъектов.Класс = ВТ_ТОРПодклассы.РодительТОР
				   |			И ВТ_ТОРПодклассы.ЭтоГруппа
	               |		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ТОР КАК ВТ_ТОРОбъектыПодклассов
	               |		ПО ВТ_СтандартныеТипыОбъектов.ОбъектПодкласса = ВТ_ТОРОбъектыПодклассов.ТОР
	               |			И ВТ_СтандартныеТипыОбъектов.Подкласс = ВТ_ТОРОбъектыПодклассов.РодительТОР
				   |			И НЕ ВТ_ТОРОбъектыПодклассов.ЭтоГруппа
				   |ИТОГИ
				   |	МАКСИМУМ(Класс),
				   |	МАКСИМУМ(Подкласс),
				   |	МАКСИМУМ(ОбъектПодкласса)
				   |ПО
				   |	КлассНаименование,
				   |	ПодклассНаименование
				   |";
	
	Запрос.УстановитьПараметр("СтандартныеТипыОбъектов", СтандартныеТипыОбъектов);
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаКлассов = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока ВыборкаКлассов.Следующий() Цикл
		СтрокаКласса = ТипыИзКлассификатора.ПолучитьЭлементы().Добавить();
		СтрокаКласса.Наименование = ВыборкаКлассов.КлассНаименование;
		СтрокаКласса.Объект = ВыборкаКлассов.Класс;
		СтрокаКласса.ИндексКартинки = 0;
		
	    ВыборкаПодклассов = ВыборкаКлассов.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		Пока ВыборкаПодклассов.Следующий() Цикл
			СтрокаПодкласса = СтрокаКласса.ПолучитьЭлементы().Добавить();
			СтрокаПодкласса.Наименование = ВыборкаПодклассов.ПодклассНаименование;
			СтрокаПодкласса.Объект = ВыборкаПодклассов.Подкласс;
			СтрокаПодкласса.ИндексКартинки = 0;
			
		    ВыборкаОбъектовПодклассов = ВыборкаПодклассов.Выбрать();
			Пока ВыборкаОбъектовПодклассов.Следующий() Цикл
				Если Не ЗначениеЗаполнено(ВыборкаОбъектовПодклассов.ОбъектПодклассаНаименование) Тогда
				    Продолжить;
				КонецЕсли;
				
				СтрокаОбъектаПодкласса = СтрокаПодкласса.ПолучитьЭлементы().Добавить();
				СтрокаОбъектаПодкласса.Наименование = ВыборкаОбъектовПодклассов.ОбъектПодклассаНаименование;
				СтрокаОбъектаПодкласса.Объект = ВыборкаОбъектовПодклассов.ОбъектПодкласса;
				СтрокаОбъектаПодкласса.ИндексКартинки = 3;
			КонецЦикла;
		КонецЦикла;
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ОбходДереваВверх(СтрокаДерева)
	Родитель = СтрокаДерева.ПолучитьРодителя();
	Если Родитель = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДочерниеСтроки = Родитель.ПолучитьЭлементы();
	ЕстьВыбранные = Ложь;
	Для каждого Элемент Из ДочерниеСтроки Цикл
		Если Элемент.Выбран Тогда
			ЕстьВыбранные = Истина;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Родитель.Выбран = ЕстьВыбранные;
	
	ОбходДереваВверх(Родитель);
КонецПроцедуры

&НаКлиенте
Процедура ОбходДереваВниз(СтрокаДерева)
	ДочерниеСтроки = СтрокаДерева.ПолучитьЭлементы();
	Для каждого ДочерняяСтрока Из ДочерниеСтроки Цикл
		ДочерняяСтрока.Выбран = СтрокаДерева.Выбран;
		ОбходДереваВниз(ДочерняяСтрока);
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьИзКлассификатораНаСервере()
	Для каждого СтрокаКласса Из ТипыИзКлассификатора.ПолучитьЭлементы() Цикл
		Если Не СтрокаКласса.Выбран Тогда
		    Продолжить;
		КонецЕсли;
		
	    Класс = ПолучитьСоздатьОбъект(СтрокаКласса);
		Если Не ЗначениеЗаполнено(Класс) Тогда
		    Продолжить;
		КонецЕсли;
		
		Для каждого СтрокаПодкласса Из СтрокаКласса.ПолучитьЭлементы() Цикл
			Если Не СтрокаПодкласса.Выбран Тогда
			    Продолжить;
			КонецЕсли;
			
		    Подкласс = ПолучитьСоздатьОбъект(СтрокаПодкласса,, Класс);
			Если Не ЗначениеЗаполнено(Подкласс) Тогда
			    Продолжить;
			КонецЕсли;
			
			Для каждого СтрокаОбъектаПодкласса Из СтрокаПодкласса.ПолучитьЭлементы() Цикл
				Если Не СтрокаОбъектаПодкласса.Выбран Тогда
				    Продолжить;
				КонецЕсли;
				
			    ОбъектПодкласса = ПолучитьСоздатьОбъект(СтрокаОбъектаПодкласса, Ложь, Подкласс);
				Если Не ЗначениеЗаполнено(ОбъектПодкласса) Тогда
				    Продолжить;
				КонецЕсли;
			КонецЦикла;
		КонецЦикла;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Функция ПолучитьСоздатьОбъект(СтрокаДерева, ЭтоГруппа = Истина, Родитель = Неопределено)
	Если Не ЗначениеЗаполнено(СтрокаДерева.Объект) Тогда
		НовыйОбъект = ?(ЭтоГруппа, Справочники.торо_ТиповыеОР.СоздатьГруппу(), Справочники.торо_ТиповыеОР.СоздатьЭлемент());
		НовыйОбъект.Наименование = СтрокаДерева.Наименование;
		НовыйОбъект.Родитель = Родитель;
		
		Если Не ЭтоГруппа Тогда
		    НовыйОбъект.ТипОбъекта = Перечисления.торо_ТипыОбъектовRCM.ФункциональноеМесто;
		КонецЕсли;
		
		Попытка
			НовыйОбъект.Записать();
			Возврат НовыйОбъект.Ссылка;
		Исключение
			ОписаниеОшибки = ОписаниеОшибки();
			ШаблонСообщения = НСтр("ru = 'Не удалось создать %1 ""%2"" по причине: %3'");
			ТекстСообщения = СтрШаблон(ШаблонСообщения, ?(ЭтоГруппа, "группу", "элемент"), СтрокаДерева.Наименование, ОписаниеОшибки);
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
			Возврат Неопределено;
		КонецПопытки;
	КонецЕсли;
	
	Возврат СтрокаДерева.Объект;
КонецФункции

&НаКлиенте
Процедура РазвернутьДерево(СПодчиненными = Ложь)
	Для каждого СтрокаДерева Из ТипыИзКлассификатора.ПолучитьЭлементы() Цикл
	    Элементы.ТипыИзКлассификатора.Развернуть(СтрокаДерева.ПолучитьИдентификатор(), СПодчиненными);
	КонецЦикла;
КонецПроцедуры

#КонецОбласти