#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Документ = Параметры.Документ;
	ОбновитьСписокДокументов();
	УстановитьУсловноеОформление();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	РазвернутьВсеСтроки(Истина);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура ОбновитьСписок(Команда)
	ОбновитьСписокДокументов();
	РазвернутьВсеСтроки(Истина);
КонецПроцедуры

&НаКлиенте
Процедура Провести(Команда)
	
	ТекДанные = Элементы.ДеревоДокументов.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СписокВыделенныхСтрок = Новый СписокЗначений;
	СписокВыделенныхСтрок.ЗагрузитьЗначения(Элементы.ДеревоДокументов.ВыделенныеСтроки);
	СписокВыделенныхСтрок.СортироватьПоЗначению(НаправлениеСортировки.Возр);
	
	Для каждого Строка Из СписокВыделенныхСтрок Цикл
		ТекущаяСтрока = Элементы.ДеревоДокументов.ДанныеСтроки(Строка.Значение);	
		Если ТекущаяСтрока.ПометкаУдаления Тогда
			ШаблонСообщения = НСтр("ru = 'Помеченный на удаление документ ""%1"" не может быть проведен!'");
			ТекстСообщения = СтрШаблон(ШаблонСообщения, ТекущаяСтрока.Документ);
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
			Продолжить;
		КонецЕсли;
		
		Если ЗаписатьВыбранныйДокумент(РежимЗаписиДокумента.Проведение, ТекущаяСтрока.Документ, ТекущаяСтрока.ПолучитьИдентификатор()) Тогда
			ТекущаяСтрока.Картинка = ПолучитьИндексКартинкиВКоллекции(ТекущаяСтрока);
		КонецЕсли;

	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Процедура ОтменитьПроведение(Команда)
	
	ТекДанные = Элементы.ДеревоДокументов.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	СписокВыделенныхСтрок = Новый СписокЗначений;
	СписокВыделенныхСтрок.ЗагрузитьЗначения(Элементы.ДеревоДокументов.ВыделенныеСтроки);
	СписокВыделенныхСтрок.СортироватьПоЗначению(НаправлениеСортировки.Убыв);
	
	Для каждого Строка Из СписокВыделенныхСтрок Цикл
		ТекущаяСтрока = Элементы.ДеревоДокументов.ДанныеСтроки(Строка.Значение);
		
		Если ТипЗнч(ТекущаяСтрока.Документ) = Тип("БизнесПроцессСсылка.Задание") Тогда
			Продолжить;
		КонецЕсли;
		
		Если НЕ ТекущаяСтрока.Проведен Тогда
			ШаблонСообщения = НСтр("ru = 'Документ ""%1"" не проведен!'");
			ТекстСообщения = СтрШаблон(ШаблонСообщения, ТекущаяСтрока.Документ);
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
			Продолжить;
		КонецЕсли;
		
		Если ЗаписатьВыбранныйДокумент(РежимЗаписиДокумента.ОтменаПроведения, ТекущаяСтрока.Документ, ТекущаяСтрока.ПолучитьИдентификатор()) Тогда
			ТекущаяСтрока.Картинка = ПолучитьИндексКартинкиВКоллекции(ТекущаяСтрока);
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Процедура РазвернутьВсеСтроки(Команда)	
	
	Для Каждого ТекСтрока Из ДеревоДокументов.ПолучитьЭлементы() Цикл
		Элементы.ДеревоДокументов.Развернуть(ТекСтрока.ПолучитьИдентификатор(), Истина);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура СвернутьВсеСтроки(Команда)
	
	Для каждого Стр Из ДеревоДокументов.ПолучитьЭлементы() Цикл
		СвернутьПодчиненные(Стр);
		Элементы.ДеревоДокументов.Свернуть(Стр.ПолучитьИдентификатор());
	КонецЦикла; 
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСлужебныеПриИзменении(Элемент)
	ОбновитьСписокДокументов();
	РазвернутьВсеСтроки(Истина);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДокументыОснования
&НаКлиенте
Процедура СписокДокументовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ДанныеСтроки = Элементы.ДеревоДокументов.ТекущиеДанные;
	
	Если Не ДанныеСтроки = Неопределено Тогда
		ПоказатьЗначение(,ДанныеСтроки.Документ);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбновитьСписокДокументов()
	Если ТипЗнч(Документ) = Тип("ДокументСсылка.торо_АнализКоренныхПричин") Тогда
		МассивИД = Новый Массив();
		МассивИД.Добавить(Документ.ИДРемонта);
		СтруктураМассивID = Новый Структура("МассивID", МассивИД);
	ИначеЕсли ТипЗнч(Документ) = Тип("ДокументСсылка.торо_ПлановыеЗатраты") Тогда
		МассивИД = Новый Массив();
		МассивИД.Добавить(Документ.РемонтыОборудования_ID);
		СтруктураМассивID = Новый Структура("МассивID", МассивИД);
	ИначеЕсли ТипЗнч(Документ) = Тип("ДокументСсылка.торо_ПроектныеЗатратыНаРемонты") Тогда
		МассивИД = Новый Массив();
		МассивИД.Добавить(Документ.IDРемонта);
		СтруктураМассивID = Новый Структура("МассивID", МассивИД);
	ИначеЕсли ТипЗнч(Документ) = Тип("ДокументСсылка.торо_ВводНачальныхДанных") Тогда
		СтруктураМассивID = Новый Структура("МассивID", Новый Массив);
	Иначе
		СтруктураМассивID = торо_ПланированиеРемонтов.ПолучитьМассивIDРемонтов(Документ);
	КонецЕсли; 
	
	ТаблицаДокументовКО = Новый ТаблицаЗначений;
	МассивТипов = Новый Массив;
	МассивТипов.Добавить(Тип("ДокументСсылка.торо_АктОВыполненииРегламентногоМероприятия"));
	МассивТипов.Добавить(Тип("ДокументСсылка.торо_АктОВыполненииЭтапаРабот"));
	МассивТипов.Добавить(Тип("ДокументСсылка.торо_АктПриемкиОборудования"));
	МассивТипов.Добавить(Тип("ДокументСсылка.торо_ВнешнееОснованиеДляРабот"));
	МассивТипов.Добавить(Тип("ДокументСсылка.торо_ВыявленныеДефекты"));
	МассивТипов.Добавить(Тип("ДокументСсылка.торо_ГрафикРегламентныхМероприятийТОиР"));
	МассивТипов.Добавить(Тип("ДокументСсылка.торо_ЗакрытиеЗаявокИРемонтов"));
	МассивТипов.Добавить(Тип("ДокументСсылка.торо_ЗаявкаНаРемонт"));
	МассивТипов.Добавить(Тип("ДокументСсылка.торо_НарядНаВыполнениеРемонтныхРабот"));
	МассивТипов.Добавить(Тип("ДокументСсылка.торо_НарядНаРегламентноеМероприятие"));
	МассивТипов.Добавить(Тип("ДокументСсылка.торо_ОстановочныеРемонты"));
	МассивТипов.Добавить(Тип("ДокументСсылка.торо_ПланГрафикРемонта"));
	МассивТипов.Добавить(Тип("ДокументСсылка.торо_ПлановыеЗатраты"));
	МассивТипов.Добавить(Тип("ДокументСсылка.торо_ПроектныеЗатратыНаРемонты"));
	МассивТипов.Добавить(Тип("ДокументСсылка.торо_ПланРаботПодразделения"));
	МассивТипов.Добавить(Тип("ДокументСсылка.торо_АнализКоренныхПричин"));
	МассивТипов.Добавить(Тип("БизнесПроцессСсылка.Задание"));
	
	ТаблицаДокументовКО.Колонки.Добавить("Документ", Новый ОписаниеТипов(МассивТипов));
	ТаблицаДокументовКО.Колонки.Добавить("Значение", Новый ОписаниеТипов("Строка",, Новый КвалификаторыСтроки(36)));
	ТаблицаДокументовКО.Колонки.Добавить("Проведен", Новый ОписаниеТипов("Булево"));
	ТаблицаДокументовКО.Колонки.Добавить("ПометкаУдаления", Новый ОписаниеТипов("Булево"));
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ
	               |	КритерийОтбораСвязанныеДокументыПоРемонту.Ссылка КАК Документ,
	               |	КритерийОтбораСвязанныеДокументыПоРемонту.Ссылка.Проведен КАК Проведен,
	               |	КритерийОтбораСвязанныеДокументыПоРемонту.Ссылка.ПометкаУдаления КАК ПометкаУдаления,
	               |	&Значение КАК Значение
	               |ИЗ
	               |	КритерийОтбора.торо_СвязанныеДокументыПоРемонту(&Значение) КАК КритерийОтбораСвязанныеДокументыПоРемонту
	               |ГДЕ
	               |	НЕ КритерийОтбораСвязанныеДокументыПоРемонту.Ссылка ССЫЛКА Документ.торо_ПлановыеЗатраты
				   |    И НЕ КритерийОтбораСвязанныеДокументыПоРемонту.Ссылка ССЫЛКА Документ.торо_ПроектныеЗатратыНаРемонты";
	
	Если ПоказатьСлужебные Тогда
		ПодстрокаПоиска = "НЕ КритерийОтбораСвязанныеДокументыПоРемонту.Ссылка ССЫЛКА Документ.торо_ПлановыеЗатраты
				          |    И НЕ КритерийОтбораСвязанныеДокументыПоРемонту.Ссылка ССЫЛКА Документ.торо_ПроектныеЗатратыНаРемонты";
		Запрос.Текст = СтрЗаменить(Запрос.Текст, ПодстрокаПоиска, "ИСТИНА"); 
	КонецЕсли;
	
	Для Каждого ИДРемонта из СтруктураМассивID.МассивID Цикл
		Запрос.УстановитьПараметр("Значение", ИДРемонта);
		РезЗапроса = Запрос.Выполнить();
		Если НЕ РезЗапроса.Пустой() Тогда 
			Выборка = РезЗапроса.Выбрать();
			Пока Выборка.Следующий() Цикл
				НоваяСтрока = ТаблицаДокументовКО.Добавить();
				ЗаполнитьЗначенияСвойств(НоваяСтрока, Выборка);
			КонецЦикла;
		КонецЕсли;
	КонецЦикла;
	
	Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	|	ТаблицаДокументов.Документ КАК Документ,
	|	ТаблицаДокументов.Проведен КАК Проведен,
	|	ТаблицаДокументов.ПометкаУдаления КАК ПометкаУдаления,
	|	ТаблицаДокументов.Значение КАК Значение
	|ПОМЕСТИТЬ ДокументыТОИР
	|ИЗ
	|	&Таблица КАК ТаблицаДокументов
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДокументыТОИР.Документ КАК Документ,
	|	ДокументыТОИР.Проведен КАК Проведен,
	|	ДокументыТОИР.ПометкаУдаления КАК ПометкаУдаления,
	|	ДокументыТОИР.Значение КАК Значение
	|ПОМЕСТИТЬ ВТ_ДокументыТОИР
	|ИЗ
	|	ДокументыТОИР КАК ДокументыТОИР
	|
	|ОБЪЕДИНИТЬ
	|
	|ВЫБРАТЬ
	|	торо_ВыявленныеДефектыДокументыОснования.ДокументОснование,
	|	торо_ВыявленныеДефектыДокументыОснования.ДокументОснование.Проведен,
	|	торо_ВыявленныеДефектыДокументыОснования.ДокументОснование.ПометкаУдаления,
	|	""""
	|ИЗ
	|	Документ.торо_ВыявленныеДефекты.ДокументыОснования КАК торо_ВыявленныеДефектыДокументыОснования
	|ГДЕ
	|	торо_ВыявленныеДефектыДокументыОснования.Ссылка В
	|			(ВЫБРАТЬ
	|				ДокументыТОИР.Документ КАК Документ
	|			ИЗ
	|				ДокументыТОИР КАК ДокументыТОИР)
	|	И (торо_ВыявленныеДефектыДокументыОснования.ДокументОснование ССЫЛКА Документ.торо_ВнешнееОснованиеДляРабот
	|    ИЛИ торо_ВыявленныеДефектыДокументыОснования.ДокументОснование ССЫЛКА Документ.торо_УчетКонтролируемыхПоказателей)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Документ,
	|	Значение
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	торо_ИнтеграцияДокументов.ДокументЕРП КАК Документ,
	|	торо_ИнтеграцияДокументов.ДокументЕРП.Проведен КАК Проведен,
	|	торо_ИнтеграцияДокументов.ДокументЕРП.ПометкаУдаления КАК ПометкаУдаления,
	|	торо_ИнтеграцияДокументов.ДокументТОИР.Ссылка КАК Основание
	|ПОМЕСТИТЬ ДокументыМТО
	|ИЗ
	|	РегистрСведений.торо_ИнтеграцияДокументов КАК торо_ИнтеграцияДокументов
	|ГДЕ
	|	торо_ИнтеграцияДокументов.ID В(&МассивИД)
	|	И НЕ торо_ИнтеграцияДокументов.ДокументЕРП = НЕОПРЕДЕЛЕНО
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	торо_ЗаказПоставщикуДокументыОснования.Ссылка КАК Документ,
	|	торо_ЗаказПоставщикуДокументыОснования.Ссылка.ПометкаУдаления КАК ПометкаУдаления,
	|	торо_ЗаказПоставщикуДокументыОснования.Ссылка.Проведен КАК Проведен,
	|	торо_ЗаказПоставщикуДокументыОснования.ДокументОснование КАК Основание
	|ПОМЕСТИТЬ ВТ_ДокументыМТО
	|ИЗ
	|	Документ.торо_ЗаказПоставщику.ДокументыОснования КАК торо_ЗаказПоставщикуДокументыОснования
	|ГДЕ
	|	торо_ЗаказПоставщикуДокументыОснования.ДокументОснование В
	|			(ВЫБРАТЬ
	|				ДокументыМТО.Документ
	|			ИЗ
	|				ДокументыМТО)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ДокументыМТО.Документ,
	|	ДокументыМТО.ПометкаУдаления,
	|	ДокументыМТО.Проведен,
	|	ДокументыМТО.Основание
	|ИЗ
	|	ДокументыМТО КАК ДокументыМТО
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ВТ_ДокументыТОИР.Документ КАК Документ,
	|	ВТ_ДокументыТОИР.Проведен КАК Проведен,
	|	ВТ_ДокументыТОИР.ПометкаУдаления КАК ПометкаУдаления,
	|	ВЫБОР
	|		КОГДА НЕ торо_АктОВыполненииЭтапаРаботРемонтыОборудования.ДокументИсточник ЕСТЬ NULL
	|			ТОГДА торо_АктОВыполненииЭтапаРаботРемонтыОборудования.ДокументИсточник
	|		КОГДА НЕ торо_АктПриемкиОборудованияРемонтыОборудования.ДокументИсточник ЕСТЬ NULL
	|			ТОГДА торо_АктПриемкиОборудованияРемонтыОборудования.ДокументИсточник
	|		КОГДА НЕ торо_ЗакрытиеЗаявокИРемонтовЗакрываемыеРемонты.ДокументОснование ЕСТЬ NULL
	|			ТОГДА торо_ЗакрытиеЗаявокИРемонтовЗакрываемыеРемонты.ДокументОснование
	|		КОГДА НЕ торо_ЗакрытиеЗаявокИРемонтовЗакрываемыеЗаявки.Заявка ЕСТЬ NULL
	|			ТОГДА торо_ЗакрытиеЗаявокИРемонтовЗакрываемыеЗаявки.Заявка
	|		КОГДА НЕ торо_ЗаявкаНаРемонтРемонтыОборудования.ДокументИсточник ЕСТЬ NULL
	|			ТОГДА торо_ЗаявкаНаРемонтРемонтыОборудования.ДокументИсточник
	|		КОГДА НЕ торо_НарядНаВыполнениеРемонтныхРаботРемонтыОборудования.ДокументИсточник ЕСТЬ NULL
	|			ТОГДА торо_НарядНаВыполнениеРемонтныхРаботРемонтыОборудования.ДокументИсточник
	|		КОГДА НЕ торо_ОстановочныеРемонты.ДокументОснование ЕСТЬ NULL
	|			ТОГДА торо_ОстановочныеРемонты.ДокументОснование
	|		КОГДА НЕ торо_ОстановочныеРемонтыСвязанныеРемонты.ДокументИсточник ЕСТЬ NULL
	|			ТОГДА торо_ОстановочныеРемонтыСвязанныеРемонты.ДокументИсточник
	|        КОГДА НЕ торо_ПланРаботПодразделенияСписокРемонтовПлана.ДокументОснование ЕСТЬ NULL
	|			ТОГДА торо_ПланРаботПодразделенияСписокРемонтовПлана.ДокументОснование
	|		КОГДА НЕ торо_АктОВыполненииРегламентногоМероприятияМероприятия.ДокументИсточник ЕСТЬ NULL
	|			ТОГДА торо_АктОВыполненииРегламентногоМероприятияМероприятия.ДокументИсточник
	|		КОГДА НЕ торо_НарядНаРегламентноеМероприятиеРегламентныеМероприятия.ДокументИсточник ЕСТЬ NULL
	|			ТОГДА торо_НарядНаРегламентноеМероприятиеРегламентныеМероприятия.ДокументИсточник
	|		КОГДА НЕ торо_ВыявленныеДефектыДокументыОснования.ДокументОснование ЕСТЬ NULL
	|			ТОГДА торо_ВыявленныеДефектыДокументыОснования.ДокументОснование
	|		КОГДА торо_ПланГрафикРемонтаПланРемонтов.Ссылка.ВидОперации = ЗНАЧЕНИЕ(Перечисление.торо_ВидыОперацийПланаГрафикаППР.Корректировка)
	|			ТОГДА торо_ПланГрафикРемонтаПланРемонтов.Ссылка.ДокументОснование
	|		КОГДА торо_ГрафикРегламентныхМероприятийТОиРПланРемонтов.Ссылка.ВидОперации = ЗНАЧЕНИЕ(Перечисление.торо_ВидыОперацийПланаГрафикаППР.Корректировка)
	|			ТОГДА торо_ГрафикРегламентныхМероприятийТОиРПланРемонтов.Ссылка.ДокументОснование
	|		КОГДА НЕ торо_АнализКоренныхПричин.ДокументОснование ЕСТЬ NULL
	|			ТОГДА торо_АнализКоренныхПричин.ДокументОснование
	|        %Служебные%
	|		ИНАЧЕ """"
	|	КОНЕЦ КАК ДокументОснование
	|ПОМЕСТИТЬ ПодготовленныеДанные
	|ИЗ
	|	ВТ_ДокументыТОИР КАК ВТ_ДокументыТОИР
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_АктОВыполненииЭтапаРабот.РемонтыОборудования КАК торо_АктОВыполненииЭтапаРаботРемонтыОборудования
	|		ПО ВТ_ДокументыТОИР.Документ = торо_АктОВыполненииЭтапаРаботРемонтыОборудования.Ссылка
	|			И ВТ_ДокументыТОИР.Значение = торо_АктОВыполненииЭтапаРаботРемонтыОборудования.ID
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_АктПриемкиОборудования.РемонтыОборудования КАК торо_АктПриемкиОборудованияРемонтыОборудования
	|		ПО ВТ_ДокументыТОИР.Документ = торо_АктПриемкиОборудованияРемонтыОборудования.Ссылка
	|			И ВТ_ДокументыТОИР.Значение = торо_АктПриемкиОборудованияРемонтыОборудования.ID
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_ЗакрытиеЗаявокИРемонтов.ЗакрываемыеРемонты КАК торо_ЗакрытиеЗаявокИРемонтовЗакрываемыеРемонты
	|		ПО ВТ_ДокументыТОИР.Документ = торо_ЗакрытиеЗаявокИРемонтовЗакрываемыеРемонты.Ссылка
	|			И ВТ_ДокументыТОИР.Значение = торо_ЗакрытиеЗаявокИРемонтовЗакрываемыеРемонты.ID
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_ЗаявкаНаРемонт.РемонтыОборудования КАК торо_ЗаявкаНаРемонтРемонтыОборудования
	|		ПО ВТ_ДокументыТОИР.Документ = торо_ЗаявкаНаРемонтРемонтыОборудования.Ссылка
	|			И ВТ_ДокументыТОИР.Значение = торо_ЗаявкаНаРемонтРемонтыОборудования.ID
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_НарядНаВыполнениеРемонтныхРабот.РемонтыОборудования КАК торо_НарядНаВыполнениеРемонтныхРаботРемонтыОборудования
	|		ПО ВТ_ДокументыТОИР.Документ = торо_НарядНаВыполнениеРемонтныхРаботРемонтыОборудования.Ссылка
	|			И ВТ_ДокументыТОИР.Значение = торо_НарядНаВыполнениеРемонтныхРаботРемонтыОборудования.ID
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_ОстановочныеРемонты КАК торо_ОстановочныеРемонты
	|		ПО ВТ_ДокументыТОИР.Документ = торо_ОстановочныеРемонты.Ссылка
	|			И ВТ_ДокументыТОИР.Значение = торо_ОстановочныеРемонты.IDОсновногоРемонта
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_ОстановочныеРемонты.СвязанныеРемонты КАК торо_ОстановочныеРемонтыСвязанныеРемонты
	|		ПО ВТ_ДокументыТОИР.Документ = торо_ОстановочныеРемонтыСвязанныеРемонты.Ссылка
	|			И ВТ_ДокументыТОИР.Значение = торо_ОстановочныеРемонтыСвязанныеРемонты.ID
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_ПланРаботПодразделения.СписокРемонтовПлана КАК торо_ПланРаботПодразделенияСписокРемонтовПлана
	|		ПО ВТ_ДокументыТОИР.Документ = торо_ПланРаботПодразделенияСписокРемонтовПлана.Ссылка
	|			И ВТ_ДокументыТОИР.Значение = торо_ПланРаботПодразделенияСписокРемонтовПлана.ID
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_АктОВыполненииРегламентногоМероприятия.Мероприятия КАК торо_АктОВыполненииРегламентногоМероприятияМероприятия
	|		ПО ВТ_ДокументыТОИР.Документ = торо_АктОВыполненииРегламентногоМероприятияМероприятия.Ссылка
	|			И ВТ_ДокументыТОИР.Значение = торо_АктОВыполненииРегламентногоМероприятияМероприятия.ID
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_НарядНаРегламентноеМероприятие.РегламентныеМероприятия КАК торо_НарядНаРегламентноеМероприятиеРегламентныеМероприятия
	|		ПО ВТ_ДокументыТОИР.Документ = торо_НарядНаРегламентноеМероприятиеРегламентныеМероприятия.Ссылка
	|			И ВТ_ДокументыТОИР.Значение = торо_НарядНаРегламентноеМероприятиеРегламентныеМероприятия.ID
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_ЗакрытиеЗаявокИРемонтов.ЗакрываемыеЗаявки КАК торо_ЗакрытиеЗаявокИРемонтовЗакрываемыеЗаявки
	|		ПО ВТ_ДокументыТОИР.Документ = торо_ЗакрытиеЗаявокИРемонтовЗакрываемыеЗаявки.Ссылка
	|			И ВТ_ДокументыТОИР.Значение = торо_ЗакрытиеЗаявокИРемонтовЗакрываемыеЗаявки.ИДРемонта
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_ВыявленныеДефекты.ДокументыОснования КАК торо_ВыявленныеДефектыДокументыОснования
	|		ПО ВТ_ДокументыТОИР.Документ = торо_ВыявленныеДефектыДокументыОснования.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_ПланГрафикРемонта.ПланРемонтов КАК торо_ПланГрафикРемонтаПланРемонтов
	|		ПО ВТ_ДокументыТОИР.Значение = торо_ПланГрафикРемонтаПланРемонтов.ID
	|			И ВТ_ДокументыТОИР.Документ = торо_ПланГрафикРемонтаПланРемонтов.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_ГрафикРегламентныхМероприятийТОиР.ПланРемонтов КАК торо_ГрафикРегламентныхМероприятийТОиРПланРемонтов
	|		ПО ВТ_ДокументыТОИР.Значение = торо_ГрафикРегламентныхМероприятийТОиРПланРемонтов.ID
	|			И ВТ_ДокументыТОИР.Документ = торо_ГрафикРегламентныхМероприятийТОиРПланРемонтов.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_АнализКоренныхПричин КАК торо_АнализКоренныхПричин
	|		ПО ВТ_ДокументыТОИР.Документ = торо_АнализКоренныхПричин.Ссылка
	|			И ВТ_ДокументыТОИР.Значение = торо_АнализКоренныхПричин.ИДРемонта
	|        %СлужебныеСоединение%
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ВТ_ДокументыМТО.Документ,
	|	ВТ_ДокументыМТО.Проведен,
	|	ВТ_ДокументыМТО.ПометкаУдаления,
	|	ВТ_ДокументыМТО.Основание
	|ИЗ
	|	ВТ_ДокументыМТО КАК ВТ_ДокументыМТО
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Документ
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ПодготовленныеДанные.Документ КАК Документ,
	|	ПодготовленныеДанные.Проведен КАК Проведен,
	|	ПодготовленныеДанные.ПометкаУдаления КАК ПометкаУдаления,
	|	ПодготовленныеДанные.ДокументОснование КАК ДокументОснование
	|ИЗ
	|	ПодготовленныеДанные КАК ПодготовленныеДанные
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ПодготовленныеДанные.Документ КАК Документ
	|ИЗ
	|	ПодготовленныеДанные КАК ПодготовленныеДанные
	|ГДЕ
	|	ПодготовленныеДанные.ДокументОснование = """"
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Задание.Ссылка КАК Документ,
	|	Задание.Предмет КАК ДокументОснование,
	|	Задание.ПометкаУдаления КАК ПометкаУдаления,
	|	NULL КАК Проведен
	|ИЗ
	|	ПодготовленныеДанные КАК ПодготовленныеДанные
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ БизнесПроцесс.Задание КАК Задание
	|		ПО ПодготовленныеДанные.Документ = Задание.Предмет";
	
	Если ПоказатьСлужебные Тогда
		ПодстрокаЗамены = "КОГДА НЕ торо_ПроектныеЗатратыНаРемонты.ДокументИсточник ЕСТЬ NULL
	                      |    ТОГДА торо_ПроектныеЗатратыНаРемонты.ДокументИсточник
	                      |КОГДА НЕ торо_ПлановыеЗатраты.ДокументПлана ЕСТЬ NULL
	                      |	   ТОГДА торо_ПлановыеЗатраты.ДокументПлана";
		
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "%Служебные%", ПодстрокаЗамены);
		
		ПодстрокаЗамены = "ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_ПлановыеЗатраты КАК торо_ПлановыеЗатраты
	                      |ПО ВТ_ДокументыТОИР.Документ = торо_ПлановыеЗатраты.Ссылка
	                      |		И ВТ_ДокументыТОИР.Значение = торо_ПлановыеЗатраты.РемонтыОборудования_ID
	                      |ЛЕВОЕ СОЕДИНЕНИЕ Документ.торо_ПроектныеЗатратыНаРемонты КАК торо_ПроектныеЗатратыНаРемонты
	                      |ПО ВТ_ДокументыТОИР.Документ = торо_ПроектныеЗатратыНаРемонты.Ссылка
	                      |		И ВТ_ДокументыТОИР.Значение = торо_ПроектныеЗатратыНаРемонты.IDРемонта";
		
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "%СлужебныеСоединение%", ПодстрокаЗамены);
	Иначе 
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "%Служебные%", "");
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "%СлужебныеСоединение%", "");
	КонецЕсли;
	
	Запрос.УстановитьПараметр("Таблица", ТаблицаДокументовКО);
	Запрос.УстановитьПараметр("МассивИД", СтруктураМассивID.МассивID);
	УстановитьПривилегированныйРежим(Истина);
	РезЗапроса = Запрос.ВыполнитьПакет();
	УстановитьПривилегированныйРежим(Ложь); 
	Если РезЗапроса[4].Пустой() Тогда 
		Возврат;
	КонецЕсли;
	
	ТаблицаДляСвертки = РезЗапроса[5].Выгрузить();
	ДокументыТаблицы = ТаблицаДляСвертки.ВыгрузитьКолонку("Документ");
	ТаблицаДляСвертки.Колонки.Удалить("Документ");
	ТаблицаДляСвертки.Колонки.Добавить("Документ");
	ТаблицаДляСвертки.ЗагрузитьКолонку(ДокументыТаблицы, "Документ");
	
	ДокументыТаблицы = ТаблицаДляСвертки.ВыгрузитьКолонку("ДокументОснование");
	ТаблицаДляСвертки.Колонки.Удалить("ДокументОснование");
	ТаблицаДляСвертки.Колонки.Добавить("ДокументОснование");
	ТаблицаДляСвертки.ЗагрузитьКолонку(ДокументыТаблицы, "ДокументОснование");
	
	ТаблицаДляДопОбхода = РезЗапроса[6].Выгрузить();
	Для Каждого Строка Из ТаблицаДляДопОбхода Цикл
		МассивПодчиненныхДокументов = ПодчиненныеСвязанныеДокументы(Строка.Документ);		
		Для Каждого ПодчиненнаяСтрока Из МассивПодчиненныхДокументов Цикл
			НоваяСтрока = ТаблицаДляСвертки.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, ПодчиненнаяСтрока);
		КонецЦикла;
	КонецЦикла;
	
	Если ТипЗнч(Документ) = Тип("ДокументСсылка.торо_ВводНачальныхДанных") Тогда
		НоваяСтрока = ТаблицаДляСвертки.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Документ);
		НоваяСтрока.Документ = Документ;
		НоваяСтрока.ДокументОснование = "";	
	КонецЕсли;
	
	НомерРезультатаБизнесПроцессы = 7;
	ТаблицаДляДопОбхода = РезЗапроса[НомерРезультатаБизнесПроцессы].Выгрузить();
	Для Каждого Строка Из ТаблицаДляДопОбхода Цикл
		НоваяСтрока = ТаблицаДляСвертки.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка);
	КонецЦикла;
	
	ТаблицаДляСвертки.Свернуть("Документ, Проведен, ПометкаУдаления, ДокументОснование");
		
	СписокДокументов.Загрузить(ТаблицаДляСвертки);
	
	ДеревоДокументов.ПолучитьЭлементы().Очистить();
	
	Для Каждого Строка Из ТаблицаДляСвертки Цикл
		Если Строка.ДокументОснование = "" Тогда
			НоваяСтрока = ДеревоДокументов.ПолучитьЭлементы().Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка);
			НоваяСтрока.Картинка = ПолучитьИндексКартинкиВКоллекции(Строка);
			СоздатьВетвьДерева(НоваяСтрока);
		КонецЕсли; 
	КонецЦикла;  
	
КонецПроцедуры

&НаСервере
Функция ПодчиненныеСвязанныеДокументы(Документ)
	
	МассивДокументов = Новый Массив;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	СвязанныеДокументы.Ссылка КАК Документ,
	|	&Документ КАК ДокументОснование,
	|	СвязанныеДокументы.Ссылка.ПометкаУдаления КАК ПометкаУдаления,
	|	СвязанныеДокументы.Ссылка.Проведен КАК Проведен
	|ИЗ
	|	КритерийОтбора.СвязанныеДокументы(&Документ) КАК СвязанныеДокументы
	|ГДЕ
	|	НЕ СвязанныеДокументы.Ссылка ССЫЛКА Документ.торо_ПроектныеЗатратыНаРемонты";
	
	Если ПоказатьСлужебные Тогда
		ПодстрокаПоиска = "НЕ СвязанныеДокументы.Ссылка ССЫЛКА Документ.торо_ПроектныеЗатратыНаРемонты";
		Запрос.Текст = СтрЗаменить(Запрос.Текст, ПодстрокаПоиска, "ИСТИНА"); 
	КонецЕсли;
	
	Запрос.УстановитьПараметр("Документ", Документ);
	РезЗапроса = Запрос.Выполнить(); 
	Если НЕ РезЗапроса.Пустой() Тогда 
		ТаблицаДокументов = РезЗапроса.Выгрузить();
		Для каждого Строка Из ТаблицаДокументов Цикл
			СтруктураДокумента = Новый Структура("ДокументОснование, Документ, ПометкаУдаления, Проведен");
			ЗаполнитьЗначенияСвойств(СтруктураДокумента, Строка);
			МассивДокументов.Добавить(СтруктураДокумента);
			
			МассивПодчиненныхПодчиненному = ПодчиненныеСвязанныеДокументы(Строка.Документ);		
			Для каждого ВложеннаяСтрока Из МассивПодчиненныхПодчиненному Цикл
				МассивДокументов.Добавить(ВложеннаяСтрока);
			КонецЦикла; 
		КонецЦикла; 
	КонецЕсли;
	Возврат МассивДокументов;
КонецФункции

&НаСервере
Процедура СоздатьВетвьДерева(СтрокаДерева)
	
	ПараметрыОтбора = Новый Структура;
	ПараметрыОтбора.Вставить("ДокументОснование", СтрокаДерева.Документ);
	
	ДокументыПоОтбору = СписокДокументов.НайтиСтроки(ПараметрыОтбора);
	
	Для Каждого Строка Из ДокументыПоОтбору Цикл
		НоваяСтрокаДерева = СтрокаДерева.ПолучитьЭлементы().Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрокаДерева, Строка);
		НоваяСтрокаДерева.Картинка = ПолучитьИндексКартинкиВКоллекции(Строка);
		СоздатьВетвьДерева(НоваяСтрокаДерева);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ПолучитьИндексКартинкиВКоллекции(ДокументСтрока)
	
	Если ТипЗнч(ДокументСтрока.Документ) = Тип("БизнесПроцессСсылка.Задание") Тогда
		Если ДокументСтрока.ПометкаУдаления Тогда
			Возврат 9;
		Иначе
			Возврат 8;
		КонецЕсли;
	ИначеЕсли ДокументСтрока.Проведен Тогда
		Возврат 1;
	ИначеЕсли ДокументСтрока.ПометкаУдаления Тогда
		Возврат 2;
	Иначе
		Возврат 0;
	КонецЕсли;
	
КонецФункции

&НаСервере
Функция ЗаписатьВыбранныйДокумент(РежимЗаписи, ДокументСсылка, ИдентификаторСтроки)
	
	Если ДокументСсылка = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Попытка
		ДокОбъект = ДокументСсылка.ПолучитьОбъект();
		ДокОбъект.Записать(РежимЗаписи);
		
		СтрокаДерева = ДеревоДокументов.НайтиПоИдентификатору(ИдентификаторСтроки);
		СтрокаДерева.Проведен = ДокОбъект.Проведен;
		СтрокаДерева.ПометкаУдаления = ДокОбъект.ПометкаУдаления;
	Исключение
		Возврат Ложь;
	КонецПопытки;
	
	Возврат Истина;
	
КонецФункции

&НаКлиенте
Процедура СвернутьПодчиненные(Строка)
	
	Для каждого Стр Из Строка.ПолучитьЭлементы() Цикл
		СвернутьПодчиненные(Стр);
		Элементы.ДеревоДокументов.Свернуть(Стр.ПолучитьИдентификатор());
	КонецЦикла; 	
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	УсловноеОформление.Элементы.Очистить();
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ДеревоДокументовДокумент.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ДеревоДокументов.Документ");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Документ;

	Элемент.Оформление.УстановитьЗначениеПараметра("Шрифт", Новый Шрифт(,,Истина));

КонецПроцедуры
#КонецОбласти



