#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

&После("ДобавитьКомандыПечати")
Процедура проф_ДобавитьКомандыПечати(КомандыПечати)
	//++ Проф-ИТ, #76, Лавриненко Т.В.,11.09.2023
	// Карта ТО АТ
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.МенеджерПечати = "Документ.торо_ЗаявкаНаРемонт";
	КомандаПечати.Идентификатор = "проф_КартаТОАТ";
	КомандаПечати.Представление = НСтр("ru = 'Карта ТО АТ'");
	КомандаПечати.Обработчик = "торо_Печать.ЗапроситьУПользователяДополнительныеПараметрыПередПечатью";
	КомандаПечати.СразуНаПринтер = ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекЗагрузить(
		"НастройкиТОиР", "ПечатьДокументовБезПредварительногоПросмотра", Ложь);
    //-- Проф-ИТ, #76, Лавриненко Т.В.,11.09.2023   
	
	//++ Проф-ИТ, #130, Лавриненко Т.В.,12.09.2023
	// Карта ТО АТ
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.МенеджерПечати = "Документ.торо_ЗаявкаНаРемонт";
	КомандаПечати.Идентификатор = "проф_КартаТОДСТ";
	КомандаПечати.Представление = НСтр("ru = 'Карта ТО ДСТ'");
	КомандаПечати.Обработчик = "торо_Печать.ЗапроситьУПользователяДополнительныеПараметрыПередПечатью";
	КомандаПечати.СразуНаПринтер = ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекЗагрузить(
		"НастройкиТОиР", "ПечатьДокументовБезПредварительногоПросмотра", Ложь);
    //-- Проф-ИТ, #130, Лавриненко Т.В.,12.09.2023
	
	//++ Проф-ИТ, #131, Остапенко Е.В., 15.09.2023
	// Ремонтный лист
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.МенеджерПечати = "Документ.торо_ЗаявкаНаРемонт";
	КомандаПечати.Идентификатор = "проф_РемонтныйЛист";
	КомандаПечати.Представление = НСтр("ru = 'Ремонтный лист'");
	КомандаПечати.Обработчик = "торо_Печать.ЗапроситьУПользователяДополнительныеПараметрыПередПечатью";
	КомандаПечати.СразуНаПринтер = ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекЗагрузить(
		"НастройкиТОиР", "ПечатьДокументовБезПредварительногоПросмотра", Ложь);
	//-- Проф-ИТ, #131, Остапенко Е.В., 15.09.2023
	
	//++ Проф-ИТ, #323, Соловьев А.А., 03.11.2023
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.МенеджерПечати = "Документ.торо_ЗаявкаНаРемонт";
	КомандаПечати.Идентификатор = "проф_РемонтныйЛистСводно";
	КомандаПечати.Представление = НСтр("ru = 'Ремонтный лист (сводно)'");
	КомандаПечати.СразуНаПринтер = ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекЗагрузить(
		"НастройкиТОиР", "ПечатьДокументовБезПредварительногоПросмотра", Ложь);
	//-- Проф-ИТ, #323, Соловьев А.А., 03.11.2023
	
КонецПроцедуры

&После("Печать")
Процедура проф_Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода)
	//++ Проф-ИТ, #76, Лавриненко Т.В.,11.09.2023
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "проф_КартаТОАТ") Тогда
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм, 
			"проф_КартаТОАТ", 
			"Карта ТО АТ", 
			проф_ПечатьКартаТОАТ(МассивОбъектов, ПараметрыПечати),
			,
			"Документ.торо_ЗаявкаНаРемонт.проф_КартаТОАТ");		
	КонецЕсли; 
    //-- Проф-ИТ, #76, Лавриненко Т.В.,11.09.2023  
	
	//++ Проф-ИТ, #130, Лавриненко Т.В.,12.09.2023
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "проф_КартаТОДСТ") Тогда
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм, 
			"проф_КартаТОДСТ", 
			"Карта ТО ДСТ", 
			проф_ПечатьКартаТОДСТ(МассивОбъектов, ПараметрыПечати),
			,
			"Документ.торо_ЗаявкаНаРемонт.проф_КартаТОДСТ");		
	КонецЕсли; 
    //-- Проф-ИТ, #130, Лавриненко Т.В.,12.09.2023 
	
	//++ Проф-ИТ, #131, Остапенко Е.В., 15.09.2023
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "проф_РемонтныйЛист") Тогда
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм, 
			"проф_РемонтныйЛист", 
			"Ремонтный лист", 
			проф_ПечатьРемонтныйЛист(МассивОбъектов, ПараметрыПечати),
			,
			"Документ.торо_ЗаявкаНаРемонт.проф_РемонтныйЛист");		
	КонецЕсли;
	//++ Проф-ИТ, #131, Остапенко Е.В., 15.09.2023
	
	//++ Проф-ИТ, #323, Соловьев А.А., 03.11.2023
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "проф_РемонтныйЛистСводно") Тогда
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм, 
			"проф_РемонтныйЛистСводно", 
			"Ремонтный лист (сводно)", 
			проф_ПечатьРемонтныйЛистСводно(МассивОбъектов, ПараметрыПечати),
			,
			"Документ.торо_ЗаявкаНаРемонт.проф_РемонтныйЛист");
	КонецЕсли;
	//-- Проф-ИТ, #323, Соловьев А.А., 03.11.2023
КонецПроцедуры 

//++ Проф-ИТ, #76, Лавриненко Т.В.,11.09.2023
 Функция проф_ПечатьКартаТОАТ(МассивОбъектов, ПараметрыПечати) 
	
	ОбработкаПечати = Обработки.проф_ПечатьКартаТОАТ.Создать();
	Возврат ОбработкаПечати.ПечатьКартаТОАТ(МассивОбъектов, ПараметрыПечати);
		
КонецФункции
//-- Проф-ИТ, #76, Лавриненко Т.В.,11.09.2023

//++ Проф-ИТ, #130, Лавриненко Т.В.,12.09.2023
 Функция проф_ПечатьКартаТОДСТ(МассивОбъектов, ПараметрыПечати) 
	
	ОбработкаПечати = Обработки.проф_ПечатьКартаТОДСТ.Создать();
	Возврат ОбработкаПечати.ПечатьКартаТОДСТ(МассивОбъектов, ПараметрыПечати);
		
КонецФункции
//-- Проф-ИТ, #130, Лавриненко Т.В.,12.09.2023 

//++ Проф-ИТ, #131, Остапенко Е.В., 15.09.2023
Функция проф_ПечатьРемонтныйЛист(МассивОбъектов, ПараметрыПечати) 
	
	ОбработкаПечати = Обработки.проф_ПечатьРемонтныйЛист.Создать();
	Возврат ОбработкаПечати.ПечатьРемонтныйЛист(МассивОбъектов, ПараметрыПечати);
		
КонецФункции
//++ Проф-ИТ, #131, Остапенко Е.В., 15.09.2023

//++ Проф-ИТ, #323, Соловьев А.А., 03.11.2023
Функция проф_ПечатьРемонтныйЛистСводно(МассивОбъектов, ПараметрыПечати) 
	
	ОбработкаПечати = Обработки.проф_ПечатьРемонтныйЛист.Создать();
	Возврат ОбработкаПечати.ПечатьРемонтныйЛистСводно(МассивОбъектов, ПараметрыПечати);
	
КонецФункции
//-- Проф-ИТ, #323, Соловьев А.А., 03.11.2023

#КонецОбласти

//++ Проф-ИТ, #359, Соловьев А.А., 23.11.2023
#Область Назначения

// Возвращает шаблон для генерации назначения товаров в документе.
//
// Параметры:
// 		Объект - ДокументОбъект.ЗаказНаРемонт, ДанныеФормыСтруктура - заказ на ремонт, по которому необходимо получить шаблон назначения.
//
// Возвращаемое значение:
// 		См. Справочники.Назначения.ШаблонНового
//
Функция ШаблонНазначения(Объект) Экспорт
	
	ШаблонНазначения = Справочники.проф_Назначения.ШаблонНового();
	
	ШаблонНазначения.НаправлениеДеятельности = Объект.проф_НаправлениеДеятельности;
	
	ШаблонНазначения.Заказ = Объект.Ссылка;
	
	Возврат ШаблонНазначения;
	
КонецФункции

Функция ЭтоНаправлениеДеятельностиСОбособлениемТоваровИРабот(Ссылка) Экспорт
	
	Если ЗначениеЗаполнено(Ссылка) Тогда
		
		УстановитьПривилегированныйРежим(Истина);
		Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "УчетЗатрат");
		
	Иначе
		
		Возврат Ложь;
		
	КонецЕсли;
	
КонецФункции

#КонецОбласти
//-- Проф-ИТ, #359, Соловьев А.А., 23.11.2023

#КонецЕсли