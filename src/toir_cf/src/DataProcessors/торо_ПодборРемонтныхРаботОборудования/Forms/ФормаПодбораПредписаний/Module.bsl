////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПЕРЕМЕННЫЕ
&НаКлиенте
Перем ПараметрыТекущейСтроки;

&НаКлиенте
Перем ПараметрыТекущейСтрокиРемонтовОборудования;

#Область ОбработчикиСобытийФормы
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Если ТипЗнч(Владелец) =  Тип("ДокументСсылка.торо_ВыявленныеДефекты") Тогда
		Элементы.ДеревоРемонтныхРабот.Видимость = Ложь;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Владелец = Параметры.Владелец;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы
&НаКлиенте
Процедура ФлажокОбработанныеПриИзменении(Элемент)
	
	Если ФлажокОбработанные Тогда
		Элементы.Предписания.ОтборСтрок = Неопределено;
	Иначе
		Элементы.Предписания.ОтборСтрок = Новый ФиксированнаяСтруктура("Обработано", Ложь);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыПредписания
&НаКлиенте
Процедура ПредписанияПриАктивизацииСтроки(Элемент)
	
	ТекДанные = Элементы.Предписания.ТекущиеДанные;
	
	Если Не ТекДанные = Неопределено И НЕ ТекДанные.ID = Неопределено
		И НЕ ТекДанные.ДокументОснование = ПредопределенноеЗначение("Документ.торо_ВыявленныеДефекты.ПустаяСсылка") 
		И НЕ торо_ОбщегоНазначенияКлиент.СравнитьПараметрыТекущейСтроки("СтрРемОборудования", Элементы.Предписания.ТекущаяСтрока, ПараметрыТекущейСтрокиРемонтовОборудования) Тогда
		
		торо_ОбщегоНазначенияКлиент.ЗапомнитьПараметрыТекущейСтроки("СтрРемОборудования", Элементы.Предписания.ТекущаяСтрока, ПараметрыТекущейСтрокиРемонтовОборудования);
		
		СписокРО = Элементы.Предписания.ВыделенныеСтроки;
		ЗаполнитьДеревоРемонтныхРабот(СписокРО);
		
	КонецЕсли;
	
	Если НЕ ТекДанные = Неопределено И ДеревоРемонтныхРабот.ПолучитьЭлементы().Количество()>0 Тогда
		Элементы.ДеревоРемонтныхРабот.Развернуть(ДеревоРемонтныхРабот.ПолучитьЭлементы()[0].ПолучитьИдентификатор(),Истина);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПредписанияВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекДокОснование = Элементы.ДокументыОснования.ТекущиеДанные;
	Если ВыбраннаяСтрока <> Неопределено И ТекДокОснование <> Неопределено Тогда
		Строка = Объект.Предписания.НайтиПоИдентификатору(ВыбраннаяСтрока);
		Если Строка <> Неопределено Тогда
			СтруктураПоискаДО = Новый Структура("ОбъектРемонта", Строка.ОбъектРемонта);
			
			МассивРО = Объект.Предписания.НайтиСтроки(СтруктураПоискаДО);
			Для Каждого ЭлементМассиваРО Из МассивРО Цикл
				Если Не Элементы.Предписания.ПроверитьСтроку(ЭлементМассиваРО.ПолучитьИдентификатор()) Тогда
					Продолжить;
				КонецЕсли;
				
				СтрокаРемонтовОборудования = Новый Структура("ID, ПлановаяДата, Обработано, ОбъектРемонта, ОписаниеРемонта, Предписания",
				ЭлементМассиваРО.ID, ЭлементМассиваРО.ПлановаяДата, ЭлементМассиваРО.Обработано, ЭлементМассиваРО.ОбъектРемонта, ЭлементМассиваРО.ОписаниеРемонта, Истина);
				
				СтруктураПоиска = Новый Структура("РемонтыОборудования_ID", ЭлементМассиваРО.ID);
				
				МассивСтрок = Объект.РемонтныеРаботы.НайтиСтроки(СтруктураПоиска);
				
				МассивСтрокРемонтныхРабот = Новый Массив;
				Для каждого Элем Из МассивСтрок Цикл
					СтруктураДобавления = Новый Структура("РемонтнаяРабота, Количество, Родитель_ID, РемонтыОборудования_ID, ID", Элем.РемонтнаяРабота, Элем.Количество, Элем.Родитель_ID, Элем.РемонтыОборудования_ID, Элем.ID);
					
					МассивСтрокРемонтныхРабот.Добавить(СтруктураДобавления);
					
				КонецЦикла;
				
				СтруктураВыбора = Новый Структура();
				
				СтруктураВыбора.Вставить("ДокументОснование", ЭлементМассиваРО.ДокументОснование);
				СтруктураВыбора.Вставить("СтрокаРемонтовОборудования", СтрокаРемонтовОборудования);
				СтруктураВыбора.Вставить("МассивСтрокРемонтныхРабот", МассивСтрокРемонтныхРабот);
				
				ПолучитьМатИТрудЗатраты(СтруктураВыбора);
				ОповеститьОВыборе(СтруктураВыбора);
				
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоРемонтныхРабот
&НаКлиенте
Процедура ДеревоРемонтныхРаботВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекДокОснование = Элементы.ДокументыОснования.ТекущиеДанные;
	СтрокаРО = Элементы.Предписания.ТекущиеДанные;
	
	Если ВыбраннаяСтрока <> Неопределено И ТекДокОснование <> Неопределено И СтрокаРО <> Неопределено Тогда
		Строка = ДеревоРемонтныхРабот.НайтиПоИдентификатору(ВыбраннаяСтрока);
		Если Строка <> Неопределено И Строка.ПолучитьРодителя() <> Неопределено Тогда
			
			СтрокаРемонтовОборудования = Новый Структура("ID, ПлановаяДата, Обработано, ОбъектРемонта, ОписаниеРемонта, Предписания",
			СтрокаРО.ID, СтрокаРО.ПлановаяДата, СтрокаРО.Обработано, СтрокаРО.ОбъектРемонта, СтрокаРО.ОписаниеРемонта, Истина);
			
			МассивСтрокРемонтныхРабот = Новый Массив;
			СтруктураДобавления = Новый Структура("РемонтнаяРабота, Количество, Родитель_ID, РемонтыОборудования_ID, ID", Строка.РемонтнаяРабота, Строка.Количество, Строка.Родитель_ID, Строка.РемонтыОборудования_ID, Строка.ID);
			
			МассивСтрокРемонтныхРабот.Добавить(СтруктураДобавления);
			
			Родитель = Строка.ПолучитьРодителя();
			
			Пока Родитель.РемонтнаяРабота <> "Ремонтные работы" Цикл
				
				СтруктураДобавления = Новый Структура("РемонтнаяРабота, Количество, Родитель_ID, РемонтыОборудования_ID, ID", Родитель.РемонтнаяРабота, Родитель.Количество, Родитель.Родитель_ID, Родитель.РемонтыОборудования_ID, Родитель.ID);
				
				МассивСтрокРемонтныхРабот.Добавить(СтруктураДобавления);
				
				Родитель = Родитель.ПолучитьРодителя();
				
			КонецЦикла;
			
			СтруктураВыбора = Новый Структура();
			
			СтруктураВыбора.Вставить("ДокументОснование", ТекДокОснование.ДокументОснование);
			СтруктураВыбора.Вставить("СтрокаРемонтовОборудования", СтрокаРемонтовОборудования);
			СтруктураВыбора.Вставить("МассивСтрокРемонтныхРабот", МассивСтрокРемонтныхРабот);
			
			ПолучитьМатИТрудЗатраты(СтруктураВыбора);			
			ОповеститьОВыборе(СтруктураВыбора);
			
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДокументыОснования
&НаКлиенте
Процедура ДокументыОснованияДокументОснованиеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПараметрыОтбора = Новый Структура("Проведен", Истина);
	ПараметрыФормы = Новый Структура("Отбор", ПараметрыОтбора);
	
	ОткрытьФорму("Документ.торо_ВнешнееОснованиеДляРабот.ФормаВыбора", ПараметрыФормы, Элемент, ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументыОснованияПриАктивизацииСтроки(Элемент)
	
	ТекДанные = Элементы.ДокументыОснования.ТекущиеДанные;
	
	Если Не ТекДанные = Неопределено И НЕ ТекДанные.ДокументОснование = Неопределено
		И НЕ ТекДанные.ДокументОснование = ПредопределенноеЗначение("Документ.торо_ВнешнееОснованиеДляРабот.ПустаяСсылка") 
		И НЕ торо_ОбщегоНазначенияКлиент.СравнитьПараметрыТекущейСтроки("СтрДокОснование", Элементы.ДокументыОснования.ТекущаяСтрока, ПараметрыТекущейСтроки) Тогда
		
		торо_ОбщегоНазначенияКлиент.ЗапомнитьПараметрыТекущейСтроки("СтрДокОснование", Элементы.ДокументыОснования.ТекущаяСтрока, ПараметрыТекущейСтроки);
		
		ДокументОснование = ТекДанные.ДокументОснование;
		
		СписокДО = Элементы.ДокументыОснования.ВыделенныеСтроки;
		
		ЗаполнитьПредписания(СписокДО);
		
		ФлажокОбработанныеПриИзменении(Элементы.ФлажокОбработанные);
		
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументыОснованияДокументОснованиеПриИзменении(Элемент)
	
	ДокументыОснованияПриАктивизацииСтроки(Элементы.ДокументыОснования);
	Если Объект.Предписания.Количество() Тогда
		Элементы.Предписания.ТекущаяСтрока = Объект.Предписания[0].ПолучитьИдентификатор();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура Выбрать(Команда)
	
	Если Элементы.ДокументыОснования.ВыделенныеСтроки.Количество() > 0 Тогда
		Для Каждого СтрокаДокументыОснования Из Элементы.ДокументыОснования.ВыделенныеСтроки Цикл
			Строка = Объект.ДокументыОснования.НайтиПоИдентификатору(СтрокаДокументыОснования);
			Если Строка <> Неопределено Тогда
				СтруктураПоискаДО = Новый Структура("ДокументОснование", Строка.ДокументОснование);
				
				МассивРО = Объект.Предписания.НайтиСтроки(СтруктураПоискаДО);
				Для Каждого ЭлементМассиваРО Из МассивРО Цикл
					Если Не Элементы.Предписания.ПроверитьСтроку(ЭлементМассиваРО.ПолучитьИдентификатор()) Тогда
						Продолжить;
					КонецЕсли;
					
					СтрокаРемонтовОборудования = Новый Структура("ID, ПлановаяДата, Обработано, ОбъектРемонта, ОписаниеРемонта, Предписания",
							ЭлементМассиваРО.ID, ЭлементМассиваРО.ПлановаяДата, ЭлементМассиваРО.Обработано, ЭлементМассиваРО.ОбъектРемонта, ЭлементМассиваРО.ОписаниеРемонта, Истина);
					
					СтруктураПоиска = Новый Структура("РемонтыОборудования_ID", ЭлементМассиваРО.ID);
					
					МассивСтрок = Объект.РемонтныеРаботы.НайтиСтроки(СтруктураПоиска);
					
					МассивСтрокРемонтныхРабот = Новый Массив;
					Для каждого Элем Из МассивСтрок Цикл
						СтруктураДобавления = Новый Структура("РемонтнаяРабота, Количество, Родитель_ID, РемонтыОборудования_ID, ID", Элем.РемонтнаяРабота, Элем.Количество, Элем.Родитель_ID, Элем.РемонтыОборудования_ID, Элем.ID);
						
						МассивСтрокРемонтныхРабот.Добавить(СтруктураДобавления);
						
					КонецЦикла;
					
					СтруктураВыбора = Новый Структура();
					
					СтруктураВыбора.Вставить("ДокументОснование", ЭлементМассиваРО.ДокументОснование);
					СтруктураВыбора.Вставить("СтрокаРемонтовОборудования", СтрокаРемонтовОборудования);
					СтруктураВыбора.Вставить("МассивСтрокРемонтныхРабот", МассивСтрокРемонтныхРабот);
					
					ПолучитьМатИТрудЗатраты(СтруктураВыбора);
					ОповеститьОВыборе(СтруктураВыбора);
					
				КонецЦикла;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
&НаСервере 
Процедура ПолучитьМатИТрудЗатраты(СтруктураВыбора)
	
	тз = Новый ТаблицаЗначений;
	ксИД = новый КвалификаторыСтроки(36);
	типС = Новый ОписаниеТипов("Строка",,,,ксид);
	тз.Колонки.Добавить("РемонтнаяРабота", Новый ОписаниеТипов("СправочникСсылка.торо_ТехнологическиеОперации"));
	тз.Колонки.Добавить("РемонтыОборудования_ID", типС);
	тз.Колонки.Добавить("ID", типС);
	
	Для каждого текСтрока из СтруктураВыбора.МассивСтрокРемонтныхРабот Цикл
		нс = тз.Добавить();
		ЗаполнитьЗначенияСвойств(нс, текСтрока);
	КонецЦикла;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	Таб.РемонтнаяРабота,
	               |	Таб.РемонтыОборудования_ID,
	               |	Таб.ID
	               |ПОМЕСТИТЬ Вт_Док
	               |ИЗ
	               |	&Табл КАК Таб
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	торо_ТехнологическиеОперацииМатериальныеЗатраты.Номенклатура,
	               |	торо_ТехнологическиеОперацииМатериальныеЗатраты.Характеристика,
	               |	торо_ТехнологическиеОперацииМатериальныеЗатраты.Качество,
	               |	торо_ТехнологическиеОперацииМатериальныеЗатраты.Количество,
	               |	торо_ТехнологическиеОперацииМатериальныеЗатраты.ЕдиницаИзмерения,
	               |	торо_ТехнологическиеОперацииМатериальныеЗатраты.Упаковка,
	               |	торо_ТехнологическиеОперацииМатериальныеЗатраты.КоличествоУпаковок,
				   |	Вт_Док.РемонтыОборудования_ID,
				   |	Вт_Док.ID
	               |ИЗ
	               |	Вт_Док КАК Вт_Док
	               |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.торо_ТехнологическиеОперации.МатериальныеЗатраты КАК торо_ТехнологическиеОперацииМатериальныеЗатраты
	               |		ПО Вт_Док.РемонтнаяРабота = торо_ТехнологическиеОперацииМатериальныеЗатраты.Ссылка
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	торо_ТехнологическиеОперацииТрудовыеЗатраты.Квалификация,
	               |	торо_ТехнологическиеОперацииТрудовыеЗатраты.Количество,
	               |	торо_ТехнологическиеОперацииТрудовыеЗатраты.ВремяРаботы,
				   |	Вт_Док.РемонтыОборудования_ID,
				   |	Вт_Док.ID
	               |ИЗ
	               |	Вт_Док КАК Вт_Док
	               |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.торо_ТехнологическиеОперации.ТрудовыеЗатраты КАК торо_ТехнологическиеОперацииТрудовыеЗатраты
	               |		ПО Вт_Док.РемонтнаяРабота = торо_ТехнологическиеОперацииТрудовыеЗатраты.Ссылка";
				   
	Запрос.УстановитьПараметр("Табл", тз);
	
	Результат = Запрос.ВыполнитьПакет();
	
	матЗатраты = Результат[1].Выгрузить();
	трудЗатраты = Результат[2].Выгрузить();
	
	массивПараметров = Новый массив;
	Для каждого текСтрока из матЗатраты цикл
		струк = Новый Структура("Номенклатура, Характеристика, Качество, Количество, ЕдиницаИзмерения, Упаковка, КоличествоУпаковок,РемонтыОборудования_ID, ID");
		ЗаполнитьЗначенияСвойств(струк, текСтрока);
		массивПараметров.Добавить(струк);
	КонецЦикла;
	СтруктураВыбора.вставить("матЗатраты", массивПараметров);
	
	массивПараметров = Новый Массив;
	Для каждого текСтрока из трудЗатраты цикл
		струк = Новый Структура("Квалификация, Количество, ВремяРаботы,РемонтыОборудования_ID, ID");
		ЗаполнитьЗначенияСвойств(струк, текСтрока);
		массивПараметров.Добавить(струк);
	КонецЦикла;
	СтруктураВыбора.вставить("трудЗатраты", массивПараметров);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПредписания(СписокДокументОснование)
	
	ТаблицаЗначений = Новый ТаблицаЗначений;
	ТаблицаЗначений.Колонки.Добавить("ТехКарта");
	ТаблицаЗначений.Колонки.Добавить("ID");
	
	Объект.Предписания.Очистить();
	Объект.РемонтныеРаботы.Очистить();
	
	ТаблицаОтбора = новый ТаблицаЗначений;
	ТаблицаОтбора.Колонки.Добавить("ДокументОснование");
	
	ТипДокОснования = ТипЗнч(СписокДокументОснование);
	
	Если Документы.ТипВсеСсылки().СодержитТип(ТипДокОснования) Тогда
		Нс = ТаблицаОтбора.Добавить();
		Нс.ДокументОснование = СписокДокументОснование;
	ИначеЕсли ТипДокОснования = Тип("Массив") Тогда
		Для Каждого ТекСтрока Из СписокДокументОснование Цикл
			Строка = Объект.ДокументыОснования.НайтиПоИдентификатору(ТекСтрока);
			Если Строка <> Неопределено Тогда
				НС = ТаблицаОтбора.Добавить();
				НС.ДокументОснование = Строка.ДокументОснование;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Если Не СписокДокументОснование = Неопределено Тогда
		
		Для Каждого Стр Из ТаблицаОтбора Цикл
			ДокументОснование = Стр.ДокументОснование;
			
			Запрос = Новый Запрос;
				Запрос.Текст = 
				"ВЫБРАТЬ
				|	торо_Предписания.Регистратор,
				|	торо_Предписания.НомерСтроки,
				|	торо_Предписания.ОбъектРемонта,
				|	торо_Предписания.ID,
				|	торо_Предписания.Описание,
				|	торо_Предписания.ПлановаяДатаРемонта,
				|	торо_Предписания.Обработано
				|ПОМЕСТИТЬ idПредписаний
				|ИЗ
				|	РегистрСведений.торо_ВнешниеОснованияДляРабот КАК торо_Предписания
				|ГДЕ
				|	торо_Предписания.Регистратор = &Ссылка
				|;
				|
				|////////////////////////////////////////////////////////////////////////////////
				|ВЫБРАТЬ
				|	idПредписаний.ОбъектРемонта,
				|	idПредписаний.ID,
				|	idПредписаний.Описание КАК ОписаниеРемонта,
				|	idПредписаний.ПлановаяДатаРемонта,
				|	торо_ПредписанияСрезПоследних.Обработано КАК Обработано,
				|	idПредписаний.Регистратор
				|ИЗ
				|	idПредписаний КАК idПредписаний
				|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.торо_ВнешниеОснованияДляРабот.СрезПоследних КАК торо_ПредписанияСрезПоследних
				|		ПО idПредписаний.ID = торо_ПредписанияСрезПоследних.ID
				|			И idПредписаний.ОбъектРемонта = торо_ПредписанияСрезПоследних.ОбъектРемонта";
				
										   
				Запрос.УстановитьПараметр("Ссылка", ДокументОснование);
				ТаблицаПредписания = Запрос.Выполнить().Выгрузить();
				
				Для Каждого СтрокаТЧ Из ТаблицаПредписания Цикл 
					
					ДобавлятьРемонт = Истина;
					
					Если ЗначениеЗаполнено(ДатаНачала) Тогда
						Если СтрокаТЧ.ПлановаяДатаРемонта < ДатаНачала Тогда
							ДобавлятьРемонт = Ложь;
						КонецЕсли;
					КонецЕсли;
					
					Если ЗначениеЗаполнено(ДатаОкончания) Тогда
						Если СтрокаТЧ.ПлановаяДатаРемонта > ДатаОкончания Тогда
							ДобавлятьРемонт = Ложь;
						КонецЕсли;
					КонецЕсли;
					
					Если Не ДобавлятьРемонт Тогда 
						Продолжить;
					КонецЕсли;
					
					НовСтрокаРО = Объект.Предписания.Добавить();
					НовСтрокаРО.ID                = СтрокаТЧ.ID;
					НовСтрокаРО.ОбъектРемонта     = СтрокаТЧ.ОбъектРемонта;
					НовСтрокаРО.ПлановаяДата      = СтрокаТЧ.ПлановаяДатаРемонта;
					НовСтрокаРО.ОписаниеРемонта   = СтрокаТЧ.ОписаниеРемонта;
					НовСтрокаРО.ДокументОснование = СтрокаТЧ.Регистратор;
					НовСтрокаРО.Обработано 		  = СтрокаТЧ.Обработано;
					
				КонецЦикла; 
				
				Запрос = Новый Запрос;
				Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ
				               |	торо_Предписания.ID,
				               |	торо_Предписания.ОбъектРемонта,
				               |	торо_Предписания.ПлановаяДатаРемонта КАК ПлановаДата,
				               |	торо_Предписания.ОписаниеРемонта
				               |ПОМЕСТИТЬ ТаблицаРемонтовОборудования
				               |ИЗ
				               |	&ТаблицаПредписания КАК торо_Предписания
				               |;
				               |
				               |////////////////////////////////////////////////////////////////////////////////
				               |ВЫБРАТЬ
				               |	торо_ЗаявкаНаРемонтРемонтныеРаботы.ID,
				               |	торо_ЗаявкаНаРемонтРемонтныеРаботы.РемонтнаяРабота,
				               |	торо_ЗаявкаНаРемонтРемонтныеРаботы.Родитель_ID,
				               |	торо_ЗаявкаНаРемонтРемонтныеРаботы.Количество,
				               |	торо_ЗаявкаНаРемонтРемонтныеРаботы.Предписание_ID
				               |ПОМЕСТИТЬ ТаблицаРемонтныхРабот
				               |ИЗ
				               |	РегистрСведений.торо_ОперацииВнешнихОснованийДляРабот КАК торо_ЗаявкаНаРемонтРемонтныеРаботы
				               |ГДЕ
				               |	торо_ЗаявкаНаРемонтРемонтныеРаботы.Регистратор = &Ссылка
				               |;
				               |
				               |////////////////////////////////////////////////////////////////////////////////
				               |ВЫБРАТЬ
				               |	ТаблицаРемонтныхРабот.ID,
				               |	ТаблицаРемонтныхРабот.РемонтнаяРабота,
				               |	ТаблицаРемонтныхРабот.Родитель_ID,
				               |	ТаблицаРемонтныхРабот.Количество,
				               |	ТаблицаРемонтныхРабот.Предписание_ID КАК РемонтыОборудования_ID
				               |ИЗ
				               |	ТаблицаРемонтныхРабот КАК ТаблицаРемонтныхРабот
				               |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ТаблицаРемонтовОборудования КАК ТаблицаРемонтовОборудования
				               |		ПО ТаблицаРемонтныхРабот.Предписание_ID = ТаблицаРемонтовОборудования.ID";
							   
							   
				Запрос.УстановитьПараметр("ТаблицаПредписания", ТаблицаПредписания);
				Запрос.УстановитьПараметр("Ссылка", ДокументОснование);
				ТаблицаРемонтныхРабот = Запрос.Выполнить().Выгрузить();

				
				Для Каждого СтрокаТЧ Из ТаблицаРемонтныхРабот Цикл 
					
					НовСтрокаРР = Объект.РемонтныеРаботы.Добавить();
					ЗаполнитьЗначенияСвойств(НовСтрокаРР, СтрокаТЧ);
					
				КонецЦикла; 
				
			
		КонецЦикла;
	КонецЕсли;
					
КонецПроцедуры

&НаСервере
// Процедура выполняет первоначальное заполнение элемента формы "ДеревоРемонтныхРабот".
//
Процедура ЗаполнитьДеревоРемонтныхРабот(СписокРемонтовОборудования)
		
	ДеревоЗначение = РеквизитФормыВЗначение("ДеревоРемонтныхРабот");
	
	ДеревоЗначение.Строки.Очистить();
	
	Для Каждого СтрокаРемОборудования Из СписокРемонтовОборудования Цикл
		
		СтрокаРемонтовОборудования = Объект.Предписания.НайтиПоИдентификатору(СтрокаРемОборудования);
		
		Если СтрокаРемонтовОборудования = Неопределено Тогда
			
			Для Каждого СтрокаТЧ Из Объект.Предписания Цикл
				
				// 0 - й уровень дерева
				КорневаяСтрока = ДеревоЗначение.Строки.Добавить();
				КорневаяСтрока.РемонтнаяРабота = "Ремонтные работы";
				КорневаяСтрока.Картинка = 4;
				КорневаяСтрока.РемонтыОборудования_ID = СтрокаТЧ.ID;
				
				МассивСтрок  = Объект.РемонтныеРаботы.НайтиСтроки(Новый Структура("РемонтыОборудования_ID", СтрокаТЧ.ID));
				ТаблицаСтрок = Объект.РемонтныеРаботы.Выгрузить(МассивСтрок);
				
				ТекущиеЗначения = Новый Структура("Родитель_ID, РемонтыОборудования_ID, ID", КорневаяСтрока.Родитель_ID, КорневаяСтрока.РемонтыОборудования_ID, КорневаяСтрока.ID);
				торо_Ремонты.СоздатьВетвьДереваПоТабличнойЧасти(ДеревоЗначение, ТекущиеЗначения, ТаблицаСтрок);
				
			КонецЦикла; 
			
		Иначе
			
			// 0 - й уровень дерева
			КорневаяСтрока = ДеревоЗначение.Строки.Добавить();
			КорневаяСтрока.РемонтнаяРабота = "Ремонтные работы";
			КорневаяСтрока.Картинка = 4;
			КорневаяСтрока.РемонтыОборудования_ID = СтрокаРемонтовОборудования.ID;
			
			МассивСтрок  = Объект.РемонтныеРаботы.НайтиСтроки(Новый Структура("РемонтыОборудования_ID", СтрокаРемонтовОборудования.ID));
			ТаблицаСтрок = Объект.РемонтныеРаботы.Выгрузить(МассивСтрок);
			
			ТекущиеЗначения = Новый Структура("Родитель_ID, РемонтыОборудования_ID, ID", КорневаяСтрока.Родитель_ID, КорневаяСтрока.РемонтыОборудования_ID, КорневаяСтрока.ID);
			торо_Ремонты.СоздатьВетвьДереваПоТабличнойЧасти(ДеревоЗначение, ТекущиеЗначения, ТаблицаСтрок);
			
		КонецЕсли; 
		
		Элементы.ДеревоРемонтныхРабот.НачальноеОтображениеДерева = НачальноеОтображениеДерева.РаскрыватьВсеУровни;
	КонецЦикла;
	
	ЗначениеВРеквизитФормы(ДеревоЗначение, "ДеревоРемонтныхРабот");
	
КонецПроцедуры

#КонецОбласти
