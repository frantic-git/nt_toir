
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий

&После("ОбработкаПроведения")
Процедура проф_ОбработкаПроведения(Отказ, РежимПроведения)
	// ++ Профи-ИТ, #229, Карпов Д. Ю., 19.09.2023 
	
	Если Отказ Тогда 
		Возврат;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(проф_ДокументОснование) Тогда
		
		ФОИспользоватьСерии = Константы.ИспользоватьСерииНоменклатуры.Получить();
		ФОИспользоватьХарактеристики = Константы.торо_ИспользоватьХарактеристикиНоменклатуры.Получить(); 
		
		Блокировка = Новый БлокировкаДанных;	
		ЭлементБлокировки = Блокировка.Добавить("РегистрНакопления.проф_ЗаказыНаПеремещение");
		ЭлементБлокировки.ИсточникДанных = Товары;
		ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Номенклатура", "Номенклатура");
		Если ФОИспользоватьХарактеристики Тогда 
			ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Характеристика", "Характеристика");
		КонецЕсли;
		ЭлементБлокировки.УстановитьЗначение("ЗаказНаПеремещение", проф_ДокументОснование);
		Если ФОИспользоватьСерии Тогда 
			ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Серия", "Серия");
		КонецЕсли;
		Блокировка.Заблокировать();
	
		Движения.проф_ЗаказыНаПеремещение.Записывать = Истина;
	
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
						|	торо_РезервПодВнутреннийЗаказТовары.Ссылка КАК Ссылка,
						|	торо_РезервПодВнутреннийЗаказТовары.Номенклатура КАК Номенклатура,
						|	торо_РезервПодВнутреннийЗаказТовары.Характеристика КАК Характеристика,
						|	торо_РезервПодВнутреннийЗаказТовары.Серия КАК Серия,
						|	торо_РезервПодВнутреннийЗаказТовары.КодСтроки КАК КодСтроки,
						|	СУММА(торо_РезервПодВнутреннийЗаказТовары.КоличествоУпаковок) КАК КоличествоУпаковок,
						|	торо_РезервПодВнутреннийЗаказ.проф_ДокументОснование КАК проф_ДокументОснование
						|ПОМЕСТИТЬ ВТ_Товары
						|ИЗ
						|	Документ.торо_РезервПодВнутреннийЗаказ.Товары КАК торо_РезервПодВнутреннийЗаказТовары
						|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_РезервПодВнутреннийЗаказ КАК торо_РезервПодВнутреннийЗаказ
						|		ПО (торо_РезервПодВнутреннийЗаказТовары.Ссылка = торо_РезервПодВнутреннийЗаказ.Ссылка)
						|ГДЕ
						|	торо_РезервПодВнутреннийЗаказТовары.Ссылка = &Ссылка
                        |
						|СГРУППИРОВАТЬ ПО
						|	торо_РезервПодВнутреннийЗаказТовары.Ссылка,
						|	торо_РезервПодВнутреннийЗаказТовары.Номенклатура,
						|	торо_РезервПодВнутреннийЗаказТовары.Характеристика,
						|	торо_РезервПодВнутреннийЗаказТовары.Серия,
						|	торо_РезервПодВнутреннийЗаказТовары.КодСтроки,
						|	торо_РезервПодВнутреннийЗаказ.проф_ДокументОснование
                        |
						|ИНДЕКСИРОВАТЬ ПО
						|	Ссылка,
						|	Номенклатура,
						|	Характеристика,
						|	Серия,
						|	КодСтроки,
						|	проф_ДокументОснование
						|;
                        |
						|////////////////////////////////////////////////////////////////////////////////
						|ВЫБРАТЬ
						|	проф_ЗаказыНаПеремещениеОстатки.ЗаказНаПеремещение КАК ЗаказНаПеремещение,
						|	проф_ЗаказыНаПеремещениеОстатки.Номенклатура КАК Номенклатура,
						|	проф_ЗаказыНаПеремещениеОстатки.Характеристика КАК Характеристика,
						|	проф_ЗаказыНаПеремещениеОстатки.КодСтроки КАК КодСтроки,
						|	проф_ЗаказыНаПеремещениеОстатки.Серия КАК Серия,
						|	проф_ЗаказыНаПеремещениеОстатки.КОформлениюОстаток КАК КоличествоОстаток
						|ПОМЕСТИТЬ ВТ_ЗаказыНаПеремещениеОстаток
						|ИЗ
						|	РегистрНакопления.проф_ЗаказыНаПеремещение.Остатки(
						|			&Дата,
						|			(ЗаказНаПеремещение, Номенклатура, Характеристика, КодСтроки, Серия) В
						|				(ВЫБРАТЬ
						|					Т.проф_ДокументОснование КАК ЗаказНаПеремещение,
						|					Т.Номенклатура КАК Номенклатура,
						|					Т.Характеристика КАК Характеристика,
						|					Т.КодСтроки КАК КодСтроки,
						|					Т.Серия КАК Серия
						|				ИЗ
						|					ВТ_Товары КАК Т)) КАК проф_ЗаказыНаПеремещениеОстатки

						|ИНДЕКСИРОВАТЬ ПО
						|	ЗаказНаПеремещение,
						|	Номенклатура,
						|	Характеристика,
						|	КодСтроки,
						|	Серия
						|;

						|////////////////////////////////////////////////////////////////////////////////
						|ВЫБРАТЬ
						|	ВТ_Товары.Ссылка КАК Ссылка,
						|	ВТ_Товары.Номенклатура КАК Номенклатура,
						|	ВТ_Товары.Характеристика КАК Характеристика,
						|	ВТ_Товары.Серия КАК Серия,
						|	ВТ_Товары.КодСтроки КАК КодСтроки,
						|	ВТ_Товары.КоличествоУпаковок КАК Количество,
						|	ВТ_Товары.проф_ДокументОснование КАК проф_ДокументОснование,
						|	Ном.Представление КАК ПредставлениеНоменклатуры,
						//++ Проф-ИТ, #229, Горетовская М.С., 22.09.2023 - Автом. создания в ТОиР док.
						// "Резервирование на внутренние заказы" на основании док. "Перемещение", созданного в ERP						
						|	ЕстьNull(ВТ_ЗаказыНаПеремещениеОстаток.КоличествоОстаток,0) КАК КоличествоОстаток
						//-- Проф-ИТ, #229, Горетовская М.С., 22.09.2023 - Автом. создания в ТОиР док.
						// "Резервирование на внутренние заказы" на основании док. "Перемещение", созданного в ERP
						|ИЗ
						|	ВТ_Товары КАК ВТ_Товары
						|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ЗаказыНаПеремещениеОстаток КАК ВТ_ЗаказыНаПеремещениеОстаток
						|		ПО (ВТ_ЗаказыНаПеремещениеОстаток.ЗаказНаПеремещение = ВТ_Товары.проф_ДокументОснование)
						|			И (ВТ_ЗаказыНаПеремещениеОстаток.Номенклатура = ВТ_Товары.Номенклатура)
						|			И (ВТ_Товары.Характеристика = ВТ_ЗаказыНаПеремещениеОстаток.Характеристика)
						|			И (ВТ_Товары.Серия = ВТ_ЗаказыНаПеремещениеОстаток.Серия)
						|			И (ВТ_ЗаказыНаПеремещениеОстаток.КодСтроки = ВТ_Товары.КодСтроки)
						|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК Ном
						|		ПО (ВТ_Товары.Номенклатура = Ном.Ссылка)";
		Запрос.УстановитьПараметр("Ссылка", Ссылка);
		Запрос.УстановитьПараметр("Дата", Новый Граница(Дата, ВидГраницы.Исключая));
		Выборка = Запрос.Выполнить().Выбрать();
		Пока Выборка.Следующий() Цикл
			Разница = Выборка.КоличествоОстаток - Выборка.Количество;
			Если Разница < 0 Тогда
				ТекстСообщения = СтрШаблон(
					НСтр("ru = ' По заказам на перемещение обнаружен отрицательный остаток по номенклатуре <%1>.'"),
					Выборка.ПредставлениеНоменклатуры);
				ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, , , , Отказ);
			КонецЕсли; 
			
			Если Отказ Тогда
				Продолжить;
			КонецЕсли; 
			
			Движение = Движения.проф_ЗаказыНаПеремещение.Добавить();
			Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
			Движение.Период = Дата;
			Движение.ЗаказНаПеремещение = Выборка.проф_ДокументОснование;
			Движение.Номенклатура = Выборка.Номенклатура;
			Движение.Характеристика = Выборка.Характеристика;
			Движение.КодСтроки = Выборка.КодСтроки;
			Движение.Серия = Выборка.Серия;  
			Движение.КОформлению = Выборка.Количество;
	
		КонецЦикла;
	КонецЕсли;
	// -- Профи-ИТ, #229, Карпов Д. Ю., 19.09.2023
	
	//++ Проф-ИТ, #294, Соловьев А.А., 24.10.2023
	Движения.проф_ТоварыНаСкладах.Записывать = Истина;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	торо_РезервПодВнутреннийЗаказ.Ссылка КАК Регистратор,
	|	торо_РезервПодВнутреннийЗаказ.Дата КАК Период,
	|	торо_РезервПодВнутреннийЗаказТовары.Номенклатура КАК Номенклатура,
	|	торо_РезервПодВнутреннийЗаказТовары.Характеристика КАК Характеристика,
	|	ДокументЗаказНаВнутреннееПотребление.Склад КАК Склад,
	|	торо_РезервПодВнутреннийЗаказТовары.Серия КАК Серия,
	|	торо_РезервПодВнутреннийЗаказТовары.проф_НазначениеИсходное КАК НазначениеИсходное,
	|	торо_РезервПодВнутреннийЗаказТовары.проф_Назначение КАК Назначение,
	|	торо_РезервПодВнутреннийЗаказТовары.Количество КАК ВНаличии
	|ИЗ
	|	Документ.торо_РезервПодВнутреннийЗаказ КАК торо_РезервПодВнутреннийЗаказ
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_РезервПодВнутреннийЗаказ.Товары КАК торо_РезервПодВнутреннийЗаказТовары
	|		ПО торо_РезервПодВнутреннийЗаказ.Ссылка = торо_РезервПодВнутреннийЗаказТовары.Ссылка
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ЗаказНаВнутреннееПотребление КАК ДокументЗаказНаВнутреннееПотребление
	|		ПО торо_РезервПодВнутреннийЗаказ.ЗаказНаВнутреннееПотребление = ДокументЗаказНаВнутреннееПотребление.Ссылка
	|ГДЕ
	|	торо_РезервПодВнутреннийЗаказ.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		
		Если Не ЗначениеЗаполнено(Выборка.Назначение) 
			И Не ЗначениеЗаполнено(Выборка.НазначениеИсходное) Тогда 
			Продолжить;
		КонецЕсли;
		
		Движение = Движения.проф_ТоварыНаСкладах.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		ЗаполнитьЗначенияСвойств(Движение, Выборка);
		Движение.Назначение = Выборка.НазначениеИсходное;
		Если ОтменаРезерва Тогда 
			Движение.ВНаличии = Макс(Выборка.ВНаличии, -Выборка.ВНаличии);
		КонецЕсли;
		
		Движение = Движения.проф_ТоварыНаСкладах.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		ЗаполнитьЗначенияСвойств(Движение, Выборка);
		Если ОтменаРезерва Тогда 
			Движение.ВНаличии = Макс(Выборка.ВНаличии, -Выборка.ВНаличии);
		КонецЕсли;
		
	КонецЦикла;
	//-- Проф-ИТ, #294, Соловьев А.А., 24.10.2023
КонецПроцедуры

&После("ПередЗаписью")
Процедура проф_ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	//++ Проф-ИТ, #401, Соловьев А.А., 11.12.2023
	Если РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда 
		проф_ОбщегоНазначенияВызовСервера.ПроверитьПризнакПодразделенияОрганизации(ЭтотОбъект["Подразделение"], Отказ);
	КонецЕсли;
	//-- Проф-ИТ, #401, Соловьев А.А., 11.12.2023
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли