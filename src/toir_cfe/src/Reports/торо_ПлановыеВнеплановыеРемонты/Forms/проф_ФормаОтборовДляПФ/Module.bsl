#Область ОписаниеПеременных

#КонецОбласти

#Область ОбработчикиСобытийФормы

//++ Проф-ИТ, #83, Иванова Е.С., 25.09.2023

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("ИмяПечатнойФормы") Тогда
		ИмяКомандыПФ = Параметры.ИмяПечатнойФормы;
	КонецЕсли;
	
	Если Параметры.Свойство("ПериодОтчета") Тогда
		ПериодОтчета = Параметры.ПериодОтчета;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ИмяКомандыПФ) 
	И ИмяКомандыПФ = "ИД_ГодовойПланГрафикРемонта" Тогда
		Элементы.ВидРемонта.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Сформировать(Команда)
	
	Если ИмяКомандыПФ  = "ИД_ГодовойПланГрафикРемонта" Тогда 
		
		Идентификатор = "ИД_ГодовойПланГрафикРемонта";
		
		КоллекцияПечатныхФорм = УправлениеПечатьюКлиент.НоваяКоллекцияПечатныхФорм(Идентификатор);
		ОписаниеПечатнойФормы = УправлениеПечатьюКлиент.ОписаниеПечатнойФормы(КоллекцияПечатныхФорм, Идентификатор);
		ОписаниеПечатнойФормы.ТабличныйДокумент = проф_ПечатьГодовойГрафикППРиТО_Сервер(ПериодОтчета);
		
		УправлениеПечатьюКлиент.ПечатьДокументов(КоллекцияПечатныхФорм, , ЭтаФорма);
	КонецЕсли;
	
	Если ИмяКомандыПФ =  "ИД_МесячныйПланГрафикРемонта" Тогда
		
		Идентификатор = "ИД_МесячныйПланГрафикРемонта";
		
		КоллекцияПечатныхФорм = УправлениеПечатьюКлиент.НоваяКоллекцияПечатныхФорм(Идентификатор);
		ОписаниеПечатнойФормы = УправлениеПечатьюКлиент.ОписаниеПечатнойФормы(КоллекцияПечатныхФорм, Идентификатор);
		ОписаниеПечатнойФормы.ТабличныйДокумент = проф_ПечатьМесячныйГрафикППРиТО_Сервер(ПериодОтчета);
		
		УправлениеПечатьюКлиент.ПечатьДокументов(КоллекцияПечатныхФорм, , ЭтаФорма);
		
	КонецЕсли;
	
	Закрыть();
	
КонецПроцедуры

//-- Проф-ИТ, #83, Иванова Е.С., 25.09.2023

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы
// Код процедур и функций
#КонецОбласти

#Область ОбработчикиКомандФормы
// Код процедур и функций
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

//++ Проф-ИТ, #83, Иванова Е.С., 25.09.2023

// Проверяет Имя, КлючВарианта отчета и его период
// Добавляет команду на форму для необходимого отчета
&НаСервере
Функция проф_ПечатьГодовойГрафикППРиТО_Сервер(ПериодОтчета)

	ТабДок = Новый ТабличныйДокумент;
    ТабДок.КлючПараметровПечати = "ПараметрыПечати_ГодовойПланГрафикРемонта";
    ТабДок.ОриентацияСтраницы  = ОриентацияСтраницы.Ландшафт;
	ТабДок.ТолькоПросмотр = Истина;

	Макет = Отчеты.торо_ПлановыеВнеплановыеРемонты.ПолучитьМакет("проф_ПФ_MXL_ГодовойГрафикППРиТО"); 
    
    Запрос = Новый Запрос; 
    Запрос.УстановитьПараметр("ДатаНач", ПериодОтчета.ДатаНачала);
    Запрос.УстановитьПараметр("ДатаКон", ПериодОтчета.ДатаОкончания);
	Если ЗначениеЗаполнено(ОбъектРемонта) Тогда
		Запрос.УстановитьПараметр("ОбъектРемонтныхРабот", ОбъектРемонта);
	КонецЕсли;
    Запрос.Текст = ПолучитьТекстЗапросаГодовойГрафикППРиТО();
    Результат = Запрос.ВыполнитьПакет();
    
    ВыборкаДляОбластиШапкаТаблицы = Результат[Результат.ВГраница() - 1].Выбрать();	
    ВыборкаОбъектыРемонта = Результат[Результат.ВГраница()].Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);;
    
    ОбластьШапка = Макет.ПолучитьОбласть("ОбластьШапка"); 
    Дата = ПериодОтчета.ДатаНачала;
    ОбластьШапка.Параметры.текДата = Формат(ТекущаяДатаСеанса(), "ДФ='« дд » ММММ гггг ""г.""'");
    ОбластьШапка.Параметры.год = Формат(Дата, "ДФ=гггг");
    ТабДок.Вывести(ОбластьШапка);
    
    МассивОбластейДляПроверки = Новый Массив;
    Область = Макет.ПолучитьОбласть("ОбластьШапкаТаблицы");
    ТабДок.Вывести(Область);
    НомерЯчейки = 4;
    
    Пока ВыборкаДляОбластиШапкаТаблицы.Следующий() Цикл
    	ОбластьДопКолонки = Макет.ПолучитьОбласть("ОбластьДопКолонкиШапки");
    	ОбластьДопКолонки.Параметры.год = Формат(Дата, "ДФ=гггг");
    	ОбластьДопКолонки.Параметры.ВидРемонта = ВыборкаДляОбластиШапкаТаблицы.ВидРемонтныхРабот;
    	ОбластьДопКолонки.Параметры.НомерКолонки = НомерЯчейки;
    	НомерЯчейки = НомерЯчейки + 1;
    	ТабДок.Присоединить(ОбластьДопКолонки);
    КонецЦикла;
    
    МассивОбластейДляПроверки.Добавить(Область);
	

    Пока ВыборкаОбъектыРемонта.Следующий() Цикл
    	ОбластьТЧ = Макет.ПолучитьОбласть("ОбластьСтрокаТаблицы");
    	МассивОбластейДляПроверки.Добавить(ОбластьТЧ);
    	ОбластьТЧ.Параметры.Заполнить(ВыборкаОбъектыРемонта);
    	ТабДок.Вывести(ОбластьТЧ);
    	Выборка = ВыборкаОбъектыРемонта.Выбрать();
		Пока Выборка.Следующий() Цикл
    		ОбластьДопКолонки = Макет.ПолучитьОбласть("ОбластьДопКолонкиСтроки");
    		ОбластьДопКолонки.Параметры.Количество = Выборка.Количество;
    		ТабДок.Присоединить(ОбластьДопКолонки);
    	КонецЦикла;
    	
    КонецЦикла;	
    
    ОбъединитьЯчейкиВТабличномДокументе(ТабДок, "#");
 
	Возврат ТабДок;
	
КонецФункции

&НаСервере
Функция проф_ПечатьМесячныйГрафикППРиТО_Сервер(ПериодОтчета)

	ТабДок = Новый ТабличныйДокумент;
    ТабДок.КлючПараметровПечати = "ПараметрыПечати_МесячныйПланГрафикРемонта";
    ТабДок.ОриентацияСтраницы  = ОриентацияСтраницы.Ландшафт;
	ТабДок.ТолькоПросмотр = Истина;

	Макет = Отчеты.торо_ПлановыеВнеплановыеРемонты.ПолучитьМакет("проф_ПФ_MXL_МесячныйГрафикППРиТО"); 
    
    Запрос = Новый Запрос; 
    Запрос.УстановитьПараметр("ДатаНач", ПериодОтчета.ДатаНачала);
    Запрос.УстановитьПараметр("ДатаКон", ПериодОтчета.ДатаОкончания);
   	Если ЗначениеЗаполнено(ОбъектРемонта) Тогда
		Запрос.УстановитьПараметр("ОбъектРемонтныхРабот", ОбъектРемонта);
	КонецЕсли;
	Если ЗначениеЗаполнено(ВидРемонта) Тогда
		Запрос.УстановитьПараметр("ВидРемонтныхРабот", ВидРемонта);
	КонецЕсли;

    Запрос.Текст = ПолучитьТекстЗапросаМесячныйГрафикППРиТО();
    Результат = Запрос.ВыполнитьПакет();
    
    ВыборкаДляОбластиШапкаТаблицы = Результат[Результат.ВГраница() - 1].Выбрать();	
    ВыборкаОбъектыРемонта = Результат[Результат.ВГраница()].Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);;
    
    ОбластьШапка = Макет.ПолучитьОбласть("ОбластьШапка"); 
    Дата = ПериодОтчета.ДатаНачала;
    ОбластьШапка.Параметры.текДата = Формат(ТекущаяДатаСеанса(), "ДФ='« дд » ММММ гггг ""г.""'");
	ОбластьШапка.Параметры.год = Формат(Дата, "ДФ=гггг");
    ОбластьШапка.Параметры.месяц = Формат(Дата, "ДФ=ММММ");
    ТабДок.Вывести(ОбластьШапка);
    	
	ДобавитьШапкуТаблицы(ТабДок, Макет, ВыборкаДляОбластиШапкаТаблицы);
	
	Пока ВыборкаОбъектыРемонта.Следующий() Цикл
    	ОбластьТЧ = Макет.ПолучитьОбласть("ОбластьСтрокаТаблицы");
    	ОбластьТЧ.Параметры.Заполнить(ВыборкаОбъектыРемонта);
    	ТабДок.Вывести(ОбластьТЧ);
		Выборка = ВыборкаОбъектыРемонта.Выбрать();
		Пока Выборка.Следующий() Цикл
    		ОбластьДопКолонки = Макет.ПолучитьОбласть("ОбластьДопКолонкиСтроки");
    		ОбластьДопКолонки.Параметры.ВидРемонта = Выборка.ВидРемонтныхРабот;
    		ТабДок.Присоединить(ОбластьДопКолонки);
    	КонецЦикла;

		Если Не ТабДок.ПроверитьВывод(ОбластьТЧ) Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
			ДобавитьШапкуТаблицы(ТабДок, Макет, ВыборкаДляОбластиШапкаТаблицы);
		КонецЕсли;	
    	    	
	КонецЦикла;
	
    ОбъединитьЯчейкиВТабличномДокументе(ТабДок, "#");
	
	Возврат ТабДок;
	
КонецФункции

&НаСервереБезКонтекста
Процедура ДобавитьШапкуТаблицы(ТабличныйДокумент, Макет, ВыборкаДляОбластиШапкаТаблицы)
	
    Область = Макет.ПолучитьОбласть("ОбластьШапкаТаблицы");
    ТабличныйДокумент.Вывести(Область);
	
	Пока ВыборкаДляОбластиШапкаТаблицы.Следующий() Цикл
    	ОбластьДопКолонки = Макет.ПолучитьОбласть("ОбластьДопКолонкиШапки");
    	ОбластьДопКолонки.Параметры.ЧислоМесяца = Формат(ВыборкаДляОбластиШапкаТаблицы.Дата, "ДФ=дд");
    	ТабличныйДокумент.Присоединить(ОбластьДопКолонки);
    КонецЦикла;
    	
	ВыборкаДляОбластиШапкаТаблицы.Сбросить();
	
КонецПроцедуры

// Процедура - Объединить ячейки в табличном документе
// Находит ячейки, содержащие в тексте МаркерОбъединения
// Объединяет ячейки, располагающиеся рядом, содержащие одинаковый текст и маркер объединения
//
// Параметры:
//  ТабличныйДокумент	 - ТабличныйДокумент
//  МаркерОбъединения	 - Строка
//
&НаСервереБезКонтекста
Процедура ОбъединитьЯчейкиВТабличномДокументе(ТабличныйДокумент, МаркерОбъединения) Экспорт
	
	ОбъединяемыеЯчейки = НайтиОбластиТабличногоДокументаПоВхождениюПодстроки(ТабличныйДокумент, МаркерОбъединения);
	ОбъединяемыеЯчейки.Колонки.Добавить("Диапазон");
	ОбъединяемыеЯчейки.Сортировать("Верх, Лево");
	
	Для Каждого Строка из ОбъединяемыеЯчейки Цикл
		Отбор = Новый Структура("Текст, Верх, Лево", Строка.Текст, Строка.Верх - 1, Строка.Лево);
		НайденныеСтроки = ОбъединяемыеЯчейки.НайтиСтроки(Отбор);
		Если НайденныеСтроки.Количество() Тогда
			Строка.Диапазон = НайденныеСтроки[0].Диапазон;
			Строка.Диапазон.Низ = Макс(Строка.Диапазон.Низ, Строка.Верх);
			Продолжить;
		КонецЕсли;
		
		Отбор = Новый Структура("Текст,Верх,Лево", Строка.Текст, Строка.Верх, Строка.Лево - 1);
		НайденныеСтроки = ОбъединяемыеЯчейки.НайтиСтроки(Отбор);
		Если НайденныеСтроки.Количество() Тогда
			Строка.Диапазон = НайденныеСтроки[0].Диапазон;
			Строка.Диапазон.Право = Макс(Строка.Диапазон.Право, Строка.Лево);
			Продолжить;
		КонецЕсли;
		
		СтруктураДиапазон = Новый Структура("Текст, Верх, Лево, Низ, Право");
		ЗаполнитьЗначенияСвойств(СтруктураДиапазон, Строка);
		СтруктураДиапазон.Низ = Строка.Верх;
        СтруктураДиапазон.Право = Строка.Лево;
		
		Строка.Диапазон = СтруктураДиапазон;
	КонецЦикла;
	
	ОбъединяемыеЯчейки.Свернуть("Диапазон");
	Для Каждого Строка Из ОбъединяемыеЯчейки Цикл
		Диапазон = Строка.Диапазон;
		Область = ТабличныйДокумент.Область(Диапазон.Верх, Диапазон.Лево, Диапазон.Низ, Диапазон.Право);
		Область.Объединить();
		
		// Удалим маркер объединения из текст ячейки
		Область.Текст = СтрЗаменить(Область.Текст, МаркерОбъединения, "");
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция НайтиОбластиТабличногоДокументаПоВхождениюПодстроки(ТабличныйДокумент, ПодстрокаПоиска) Экспорт
	
	НайденныеОбласти = Новый ТаблицаЗначений;
	НайденныеОбласти.Колонки.Добавить("Область");
	НайденныеОбласти.Колонки.Добавить("Текст");
	НайденныеОбласти.Колонки.Добавить("Верх");
	НайденныеОбласти.Колонки.Добавить("Лево");
	
	НайденнаяОбласть = ТабличныйДокумент.НайтиТекст(ПодстрокаПоиска);
	
	Пока НЕ НайденнаяОбласть = Неопределено Цикл
		
		НоваяСтрока = НайденныеОбласти.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, НайденнаяОбласть);
		НоваяСтрока.Область = НайденнаяОбласть;
		
		НайденнаяОбласть = ТабличныйДокумент.НайтиТекст(ПодстрокаПоиска, НайденнаяОбласть);
		
	КонецЦикла;
	
	Возврат НайденныеОбласти;
	
КонецФункции

&НаСервере
Функция ПолучитьТекстЗапросаГодовойГрафикППРиТО()

	Текст = "ВЫБРАТЬ
	        |	торо_ПланГрафикРемонта.ОбъектРемонтныхРабот КАК ОбъектРемонтныхРабот,
	        |	торо_ПланГрафикРемонта.ID КАК ID,
	        |	торо_ПланГрафикРемонта.Регистратор КАК Регистратор,
	        |	торо_ПланГрафикРемонта.Период КАК Период
	        |ПОМЕСТИТЬ ВТ_ПлановыеРемонты
	        |ИЗ
	        |	РегистрСведений.торо_ПлановыеРемонтныеРаботы.СрезПоследних(, Регистратор ССЫЛКА Документ.торо_ПланГрафикРемонта) КАК торо_ПланГрафикРемонта
	        |ГДЕ
	        |	торо_ПланГрафикРемонта.Отменен = ЛОЖЬ
	        |	И торо_ПланГрафикРемонта.Замещен = ЛОЖЬ
	        |;
	        |
	        |////////////////////////////////////////////////////////////////////////////////
	        |ВЫБРАТЬ
	        |	ВТ_ПлановыеРемонты.ОбъектРемонтныхРабот КАК ОбъектРемонтныхРабот,
	        |	торо_ПланГрафикРемонтаПланРемонтов.ВидРемонтныхРабот КАК ВидРемонтныхРабот,
	        |	КОЛИЧЕСТВО(торо_ПланГрафикРемонтаПланРемонтов.ВидРемонтныхРабот) КАК Количество
	        |ПОМЕСТИТЬ ВТ_ПлановыеРаботыСКоличеством
	        |ИЗ
	        |	ВТ_ПлановыеРемонты КАК ВТ_ПлановыеРемонты
	        |		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_ПланГрафикРемонта.ПланРемонтов КАК торо_ПланГрафикРемонтаПланРемонтов
	        |			ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_АктуальныеПлановыеДатыРемонтов КАК торо_АктуальныеПлановыеДатыРемонтов
	        |			ПО (торо_АктуальныеПлановыеДатыРемонтов.IDРемонта = торо_ПланГрафикРемонтаПланРемонтов.ID)
	        |		ПО ВТ_ПлановыеРемонты.Регистратор = торо_ПланГрафикРемонтаПланРемонтов.Ссылка
	        |			И ВТ_ПлановыеРемонты.ID = торо_ПланГрафикРемонтаПланРемонтов.ID
	        |			И ВТ_ПлановыеРемонты.ОбъектРемонтныхРабот = торо_ПланГрафикРемонтаПланРемонтов.ОбъектРемонтныхРабот
	        |ГДЕ
	        |	торо_ПланГрафикРемонтаПланРемонтов.ДатаКон <= &ДатаКон
	        |	И торо_ПланГрафикРемонтаПланРемонтов.ДатаНач >= &ДатаНач
	        |	И НЕ торо_ПланГрафикРемонтаПланРемонтов.Замещен
	        |	И НЕ торо_ПланГрафикРемонтаПланРемонтов.Отменен
	        |	И НЕ торо_АктуальныеПлановыеДатыРемонтов.ДокументОснование ССЫЛКА Документ.торо_ЗакрытиеЗаявокИРемонтов
	        |	%ОбъектРемонта
	        |
	        |СГРУППИРОВАТЬ ПО
	        |	ВТ_ПлановыеРемонты.ОбъектРемонтныхРабот,
	        |	торо_ПланГрафикРемонтаПланРемонтов.ВидРемонтныхРабот
	        |;
	        |
	        |////////////////////////////////////////////////////////////////////////////////
	        |ВЫБРАТЬ
	        |	ВТ_ПлановыеРаботыСКоличеством.ВидРемонтныхРабот КАК ВидРемонтныхРабот
	        |ПОМЕСТИТЬ ВТ_ВидыРемРабот
	        |ИЗ
	        |	ВТ_ПлановыеРаботыСКоличеством КАК ВТ_ПлановыеРаботыСКоличеством
	        |
	        |СГРУППИРОВАТЬ ПО
	        |	ВТ_ПлановыеРаботыСКоличеством.ВидРемонтныхРабот
	        |;
	        |
	        |////////////////////////////////////////////////////////////////////////////////
	        |ВЫБРАТЬ
	        |	ВТ_ПлановыеРаботыСКоличеством.ОбъектРемонтныхРабот КАК ОбъектРемонтныхРабот
	        |ПОМЕСТИТЬ ВТ_ОбъектыРемонта
	        |ИЗ
	        |	ВТ_ПлановыеРаботыСКоличеством КАК ВТ_ПлановыеРаботыСКоличеством
	        |
	        |СГРУППИРОВАТЬ ПО
	        |	ВТ_ПлановыеРаботыСКоличеством.ОбъектРемонтныхРабот
	        |;
	        |
	        |////////////////////////////////////////////////////////////////////////////////
	        |ВЫБРАТЬ
	        |	ВТ_ОбъектыРемонта.ОбъектРемонтныхРабот КАК ОбъектРемонтныхРабот,
	        |	ВТ_ВидыРемРабот.ВидРемонтныхРабот КАК ВидРемонтныхРабот
	        |ПОМЕСТИТЬ ВТ_Подготовительная
	        |ИЗ
	        |	ВТ_ОбъектыРемонта КАК ВТ_ОбъектыРемонта,
	        |	ВТ_ВидыРемРабот КАК ВТ_ВидыРемРабот
	        |;
	        |
	        |////////////////////////////////////////////////////////////////////////////////
	        |ВЫБРАТЬ
	        |	ВТ_ВидыРемРабот.ВидРемонтныхРабот КАК ВидРемонтныхРабот
	        |ИЗ
	        |	ВТ_ВидыРемРабот КАК ВТ_ВидыРемРабот
	        |
	        |УПОРЯДОЧИТЬ ПО
	        |	ВидРемонтныхРабот
	        |;
	        |
	        |////////////////////////////////////////////////////////////////////////////////
	        |ВЫБРАТЬ
	        |	ВТ_Подготовительная.ОбъектРемонтныхРабот КАК ОбъектРемонтныхРабот,
			|	ПРЕДСТАВЛЕНИЕ(ВТ_Подготовительная.ОбъектРемонтныхРабот) КАК ОбъектРемонта,
	        |	ВТ_Подготовительная.ВидРемонтныхРабот КАК ВидРемонтныхРабот,
	        |	ЕСТЬNULL(ВТ_ПлановыеРаботыСКоличеством.Количество, 0) КАК Количество,
	        |	ЕСТЬNULL(торо_ОбъектыРемонта.ИнвентарныйНомер, """") КАК ИнвНомер,
	        |	ЕСТЬNULL(торо_ОбъектыРемонта.ЗаводскойНомер, """") КАК ЗаводскойНомерОР,
	        |	ЕСТЬNULL(торо_ОбъектыРемонта.проф_Марка, """") КАК МаркаОР
	        |ИЗ
	        |	ВТ_Подготовительная КАК ВТ_Подготовительная
	        |		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ПлановыеРаботыСКоличеством КАК ВТ_ПлановыеРаботыСКоличеством
	        |		ПО ВТ_Подготовительная.ОбъектРемонтныхРабот = ВТ_ПлановыеРаботыСКоличеством.ОбъектРемонтныхРабот
	        |			И ВТ_Подготовительная.ВидРемонтныхРабот = ВТ_ПлановыеРаботыСКоличеством.ВидРемонтныхРабот
	        |		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.торо_ОбъектыРемонта КАК торо_ОбъектыРемонта
	        |		ПО ВТ_Подготовительная.ОбъектРемонтныхРабот = торо_ОбъектыРемонта.Ссылка
	        |
	        |УПОРЯДОЧИТЬ ПО
	        |	ОбъектРемонтныхРабот,
	        |	ВидРемонтныхРабот
	        |ИТОГИ
	        |	МАКСИМУМ(ИнвНомер),
	        |	МАКСИМУМ(ЗаводскойНомерОР),
	        |	МАКСИМУМ(МаркаОР)
	        |ПО
	        |	ОбъектРемонтныхРабот";
	
	Если ЗначениеЗаполнено(ОбъектРемонта) Тогда
		Текст = СтрЗаменить(Текст, "%ОбъектРемонта", "И ВТ_ПлановыеРемонты.ОбъектРемонтныхРабот = &ОбъектРемонтныхРабот");
	Иначе
		Текст = СтрЗаменить(Текст, "%ОбъектРемонта", "");
	КонецЕсли;
	
	Возврат Текст;

КонецФункции 

&НаСервере
Функция ПолучитьТекстЗапросаМесячныйГрафикППРиТО()

	Текст = "ВЫБРАТЬ
	        |	ДанныеПроизводственногоКалендаря.Дата КАК Дата
	        |ПОМЕСТИТЬ ВТ_ДатыЗаПериод
	        |ИЗ
	        |	РегистрСведений.ДанныеПроизводственногоКалендаря КАК ДанныеПроизводственногоКалендаря
	        |ГДЕ
	        |	ДанныеПроизводственногоКалендаря.Дата МЕЖДУ &ДатаНач И &ДатаКон
	        |;
	        |
	        |////////////////////////////////////////////////////////////////////////////////
	        |ВЫБРАТЬ
	        |	торо_ПланГрафикРемонта.ОбъектРемонтныхРабот КАК ОбъектРемонтныхРабот,
	        |	торо_ПланГрафикРемонта.ID КАК ID,
	        |	торо_ПланГрафикРемонта.Регистратор КАК Регистратор,
	        |	торо_ПланГрафикРемонта.Период КАК Период
	        |ПОМЕСТИТЬ ВТ_ПлановыеРемонты
	        |ИЗ
	        |	РегистрСведений.торо_ПлановыеРемонтныеРаботы.СрезПоследних(, Регистратор ССЫЛКА Документ.торо_ПланГрафикРемонта) КАК торо_ПланГрафикРемонта
	        |ГДЕ
	        |	торо_ПланГрафикРемонта.Отменен = ЛОЖЬ
	        |	И торо_ПланГрафикРемонта.Замещен = ЛОЖЬ
	        |;
	        |
	        |////////////////////////////////////////////////////////////////////////////////
	        |ВЫБРАТЬ
	        |	ВТ_ПлановыеРемонты.ОбъектРемонтныхРабот КАК ОбъектРемонтныхРабот,
	        |	торо_ПланГрафикРемонтаПланРемонтов.ВидРемонтныхРабот КАК ВидРемонтныхРабот,
	        |	торо_ПланГрафикРемонтаПланРемонтов.ДатаНач КАК ДатаПланируемогоРемонта
	        |ПОМЕСТИТЬ ВТ_ПлановыеРаботыСДатами
	        |ИЗ
	        |	ВТ_ПлановыеРемонты КАК ВТ_ПлановыеРемонты
	        |		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_ПланГрафикРемонта.ПланРемонтов КАК торо_ПланГрафикРемонтаПланРемонтов
	        |			ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_АктуальныеПлановыеДатыРемонтов КАК торо_АктуальныеПлановыеДатыРемонтов
	        |			ПО (торо_АктуальныеПлановыеДатыРемонтов.IDРемонта = торо_ПланГрафикРемонтаПланРемонтов.ID)
	        |		ПО ВТ_ПлановыеРемонты.Регистратор = торо_ПланГрафикРемонтаПланРемонтов.Ссылка
	        |			И ВТ_ПлановыеРемонты.ID = торо_ПланГрафикРемонтаПланРемонтов.ID
	        |			И ВТ_ПлановыеРемонты.ОбъектРемонтныхРабот = торо_ПланГрафикРемонтаПланРемонтов.ОбъектРемонтныхРабот
	        |ГДЕ
	        |	торо_ПланГрафикРемонтаПланРемонтов.ДатаНач МЕЖДУ &ДатаНач И &ДатаКон
	        |	И НЕ торо_ПланГрафикРемонтаПланРемонтов.Замещен
	        |	И НЕ торо_ПланГрафикРемонтаПланРемонтов.Отменен
	        |	И НЕ торо_АктуальныеПлановыеДатыРемонтов.ДокументОснование ССЫЛКА Документ.торо_ЗакрытиеЗаявокИРемонтов
	        |	%ОбъектРемонта
	        |	%ВидРемонтныхРабот
	        |;
	        |
	        |////////////////////////////////////////////////////////////////////////////////
	        |ВЫБРАТЬ
	        |	ВТ_ПлановыеРаботыСДатами.ОбъектРемонтныхРабот КАК ОбъектРемонтныхРабот
	        |ПОМЕСТИТЬ ВТ_ОбъектыРемонта
	        |ИЗ
	        |	ВТ_ПлановыеРаботыСДатами КАК ВТ_ПлановыеРаботыСДатами
	        |
	        |СГРУППИРОВАТЬ ПО
	        |	ВТ_ПлановыеРаботыСДатами.ОбъектРемонтныхРабот
	        |;
	        |
	        |////////////////////////////////////////////////////////////////////////////////
	        |ВЫБРАТЬ
	        |	ВТ_ОбъектыРемонта.ОбъектРемонтныхРабот КАК ОбъектРемонтныхРабот,
	        |	ВТ_ДатыЗаПериод.Дата КАК Дата
	        |ПОМЕСТИТЬ ВТ_Предварительная
	        |ИЗ
	        |	ВТ_ДатыЗаПериод КАК ВТ_ДатыЗаПериод,
	        |	ВТ_ОбъектыРемонта КАК ВТ_ОбъектыРемонта
	        |;
	        |
	        |////////////////////////////////////////////////////////////////////////////////
	        |ВЫБРАТЬ
	        |	ВТ_ДатыЗаПериод.Дата КАК Дата
	        |ИЗ
	        |	ВТ_ДатыЗаПериод КАК ВТ_ДатыЗаПериод
	        |;
	        |
	        |////////////////////////////////////////////////////////////////////////////////
	        |ВЫБРАТЬ
	        |	ВТ_Предварительная.ОбъектРемонтныхРабот КАК ОбъектРемонтныхРабот,
			|	ПРЕДСТАВЛЕНИЕ(ВТ_Предварительная.ОбъектРемонтныхРабот) КАК ОбъектРемонта,
	        |	ВТ_Предварительная.Дата КАК Дата,
	        |	ЕСТЬNULL(ВТ_ПлановыеРаботыСДатами.ВидРемонтныхРабот, ЗНАЧЕНИЕ(Справочник.торо_ВидыРемонтов.ПустаяСсылка)) КАК ВидРемонтныхРабот,
	        |	ЕСТЬNULL(торо_ОбъектыРемонта.ИнвентарныйНомер, """") КАК ИнвНомер,
	        |	ЕСТЬNULL(торо_ОбъектыРемонта.ЗаводскойНомер, """") КАК ЗаводскойНомерОР,
	        |	ЕСТЬNULL(торо_ОбъектыРемонта.проф_Марка, """") КАК МаркаОР
	        |ИЗ
	        |	ВТ_Предварительная КАК ВТ_Предварительная
	        |		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ПлановыеРаботыСДатами КАК ВТ_ПлановыеРаботыСДатами
	        |		ПО ВТ_Предварительная.ОбъектРемонтныхРабот = ВТ_ПлановыеРаботыСДатами.ОбъектРемонтныхРабот
	        |			И ВТ_Предварительная.Дата = ВТ_ПлановыеРаботыСДатами.ДатаПланируемогоРемонта
	        |		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.торо_ОбъектыРемонта КАК торо_ОбъектыРемонта
	        |		ПО ВТ_Предварительная.ОбъектРемонтныхРабот = торо_ОбъектыРемонта.Ссылка
	        |ИТОГИ
	        |	МАКСИМУМ(ИнвНомер),
	        |	МАКСИМУМ(ЗаводскойНомерОР),
	        |	МАКСИМУМ(МаркаОР)
	        |ПО
	        |	ОбъектРемонтныхРабот";
	
	Если ЗначениеЗаполнено(ОбъектРемонта) Тогда
		Текст = СтрЗаменить(Текст, "%ОбъектРемонта", "И ВТ_ПлановыеРемонты.ОбъектРемонтныхРабот = &ОбъектРемонтныхРабот");
	Иначе
		Текст = СтрЗаменить(Текст, "%ОбъектРемонта", "");
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ВидРемонта) Тогда
		Текст = СтрЗаменить(Текст, "%ВидРемонтныхРабот", "И торо_ПланГрафикРемонтаПланРемонтов.ВидРемонтныхРабот = &ВидРемонтныхРабот");
	Иначе
		Текст = СтрЗаменить(Текст, "%ВидРемонтныхРабот", "");
	КонецЕсли;
	
	Возврат Текст;
	
КонецФункции

//-- Проф-ИТ, #83, Иванова Е.С., 25.09.2023

#КонецОбласти