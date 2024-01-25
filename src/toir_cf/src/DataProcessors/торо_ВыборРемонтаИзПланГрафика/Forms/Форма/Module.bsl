#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если ЭтаФорма.Параметры.Свойство("СсылкаНаППР") И ЭтаФорма.Параметры.СсылкаНаППР <> Документы.торо_ПланГрафикРемонта.ПустаяСсылка() Тогда
	
		Объект.ПланГрафикРемонта = ЭтаФорма.Параметры.СсылкаНаППР;
		
		Элементы.Группа1.ТекущаяСтраница = Элементы.РемонтыППРДляВыбора;
		
		УстановитьЗначенияПараметровДинамическихСписков();
		
		
		
		
	ИначеЕсли ЭтаФорма.Параметры.Свойство("СсылкаНаАкт") И ЭтаФорма.Параметры.СсылкаНаАкт <> Документы.торо_АктОВыполненииЭтапаРабот.ПустаяСсылка() Тогда
		
		Объект.АктОВыполненииЭтапаРабот = ЭтаФорма.Параметры.СсылкаНаАкт;
		
		Элементы.АктОВыполненииЭтапаРабот.Заголовок = Строка(Объект.АктОВыполненииЭтапаРабот);
		
		Контрагент = ЭтаФорма.Параметры.Контрагент;
		
		Элементы.Группа1.ТекущаяСтраница = Элементы.РемонтыДляВыбораАкт;
		
		УстановитьЗначенияПараметровДинамическихСписков();
		
		ЭтаФорма.АвтоЗаголовок = Ложь;
		ЭтаФорма.Заголовок = НСтр("ru='Выбор ремонта из акта'");
	Иначе	
		
		Отказ = Истина;
				
	КонецЕсли; 
	
		
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписокОбъектовРемонта
&НаКлиенте
Процедура СписокОбъектовРемонтаПриАктивизацииСтроки(Элемент)
	
	Если Элементы.Группа1.ТекущаяСтраница = Элементы.РемонтыППРДляВыбора Тогда
		РемонтыИЗППР.Отбор.Элементы.Очистить();
		ЭлементОтбора = РемонтыИЗППР.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбора.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
		ЭлементОтбора.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("ОбъектРемонта");
		ЭлементОтбора.ПравоеЗначение = Элементы.СписокОбъектовРемонта.ТекущиеДанные.ОбъектРемонта;
		ЭлементОтбора.Использование  = Истина;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыРемонтыИЗППР
&НаКлиенте
Процедура РемонтыИЗППРВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	НайдСтроки = ВыбранныеРемонтыТаблица.НайтиСтроки(Новый Структура("ID_Ремонта", Элемент.ТекущиеДанные.ID_Ремонта));
	
	Если НайдСтроки.Количество() > 0 Тогда
		
		ТекстСообщения = НСтр("ru = 'Данный вид ремонта уже добален.'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
		
	Иначе
		
		НС = ВыбранныеРемонтыТаблица.Добавить();
		ЗаполнитьЗначенияСвойств(НС,Элемент.ТекущиеДанные);
		
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыРемонтыИзАкта
&НаКлиенте
Процедура РемонтыИзАктаВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
		
	СтандартнаяОбработка = Ложь;
	
	НайдСтроки = ВыбранныеРемонтыТаблица.НайтиСтроки(Новый Структура("ID_Ремонта", Элемент.ТекущиеДанные.ID_Ремонта));
	
	Если НайдСтроки.Количество() > 0 Тогда
		
		ТекстСообщения = НСтр("ru = 'Данный вид ремонта уже добален.'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
		
	Иначе
		
		НС = ВыбранныеРемонтыТаблица.Добавить();
		ЗаполнитьЗначенияСвойств(НС,Элемент.ТекущиеДанные);
		
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура Выбрать(Команда)
	
	ОповеститьОВыборе(ПолучитьТаблицуМассивом());
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
&НаСервере 
Процедура УстановитьЗначенияПараметровДинамическихСписков()
	
	СписокОбъектовРемонта.Параметры.УстановитьЗначениеПараметра("Ссылка", Объект.ПланГрафикРемонта);
	РемонтыИЗППР.Параметры.УстановитьЗначениеПараметра("Ссылка"         , Объект.ПланГрафикРемонта);
	РемонтыИзАкта.Параметры.УстановитьЗначениеПараметра("Ссылка"        , Объект.АктОВыполненииЭтапаРабот);
	РемонтыИзАкта.Параметры.УстановитьЗначениеПараметра("Контрагент"    , Контрагент);	
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьТаблицуМассивом()

	Массив = Новый Массив;
		
	Для Каждого Строка ИЗ ВыбранныеРемонтыТаблица Цикл
	
		СтруктураДанныхСтроки = Новый Структура;
		
		СтруктураДанныхСтроки.Вставить("ID"                , Строка.ID_Ремонта);
		СтруктураДанныхСтроки.Вставить("ВидРемонтныхРабот" , Строка.ВидРемонта);
		СтруктураДанныхСтроки.Вставить("ДатаНач"           , Строка.ДатаНачала);
		СтруктураДанныхСтроки.Вставить("ДатаКон"           , Строка.ДатаОкончания);
		СтруктураДанныхСтроки.Вставить("ОбъектРемонта"     , Строка.ОбъектРемонта);
		
		Если ЗначениеЗаполнено(Объект.ПланГрафикРемонта) Тогда
			
			СтруктураДанныхСтроки.Вставить("СуммаРемонта"      , Строка.СуммаРемонта);
		
		КонецЕсли; 

		Массив.Добавить(СтруктураДанныхСтроки);
		
	КонецЦикла; 

	Возврат Массив;
	
КонецФункции 

#КонецОбласти