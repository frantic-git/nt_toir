#Область ОбработчикиСобытий

&ИзменениеИКонтроль("ОбработкаПроведения")
Процедура проф_ОбработкаПроведения(Отказ, РежимПроведения)

	ШаблонСообщения = НСтр("ru = 'Есть непроведенный документ основание: %1'");
	МассивДокументовОснований = ОбщегоНазначения.ВыгрузитьКолонку(ДокументыОснования,"ДокументОснование");
	Запрос = Новый Запрос(	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	торо_ВнешнееОснованиеДляРабот.Ссылка КАК Ссылка,
	|	торо_ВнешнееОснованиеДляРабот.Проведен КАК Проведен
	|ИЗ
	|	Документ.торо_ВнешнееОснованиеДляРабот КАК торо_ВнешнееОснованиеДляРабот
	|ГДЕ
	|	торо_ВнешнееОснованиеДляРабот.Ссылка В(&МассивДокОсн)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	торо_ВыявленныеДефекты.Ссылка,
	|	торо_ВыявленныеДефекты.Проведен
	|ИЗ
	|	Документ.торо_ВыявленныеДефекты КАК торо_ВыявленныеДефекты
	|ГДЕ
	|	торо_ВыявленныеДефекты.Ссылка В(&МассивДокОсн)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	торо_ЗаявкаНаРемонт.Ссылка,
	|	торо_ЗаявкаНаРемонт.Проведен
	|ИЗ
	|	Документ.торо_ЗаявкаНаРемонт КАК торо_ЗаявкаНаРемонт
	|ГДЕ
	|	торо_ЗаявкаНаРемонт.Ссылка В(&МассивДокОсн)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	торо_НарядНаВыполнениеРемонтныхРабот.Ссылка,
	|	торо_НарядНаВыполнениеРемонтныхРабот.Проведен
	|ИЗ
	|	Документ.торо_НарядНаВыполнениеРемонтныхРабот КАК торо_НарядНаВыполнениеРемонтныхРабот
	|ГДЕ
	|	торо_НарядНаВыполнениеРемонтныхРабот.Ссылка В(&МассивДокОсн)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	торо_ПланГрафикРемонта.Ссылка,
	|	торо_ПланГрафикРемонта.Проведен
	|ИЗ
	|	Документ.торо_ПланГрафикРемонта КАК торо_ПланГрафикРемонта
	|ГДЕ
	|	торо_ПланГрафикРемонта.Ссылка В(&МассивДокОсн)");

	Запрос.УстановитьПараметр("МассивДокОсн", МассивДокументовОснований);
	Выборка = Запрос.Выполнить().Выбрать();

	Пока Выборка.Следующий() Цикл
		Если Не Выборка.Проведен Тогда
			ТекстСообщения = СтрШаблон(ШаблонСообщения, Строка(Выборка.Ссылка));
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения,,,,Отказ);
			Возврат;
		КонецЕсли;
	КонецЦикла;

	ПроверитьЗавершенностьОстановочных(Отказ);

	ПроверитьДатуДокумента(Отказ);

	РемонтыОборудованияТаблицаЗначений = РемонтыОборудования.Выгрузить(); 
	РемонтыОтсутствующиеВДокументахИсточниках = торо_Ремонты.ПроверитьНаличиеРемонтовВДокументахИсточникахПоIDРемонта(РемонтыОборудованияТаблицаЗначений);

	Если НЕ РемонтыОтсутствующиеВДокументахИсточниках = Неопределено Тогда

		Для каждого Ремонт Из РемонтыОтсутствующиеВДокументахИсточниках Цикл
			ШаблонСообщения = НСтр("ru = 'Для объекта ремонта ""%1"" отсутствует соответствующий ремонт в документе основании ""%2"".'");
			ТекстСообщения = СтрШаблон(ШаблонСообщения, Ремонт.ОбъектРемонта, Ремонт.ДокументИсточник);
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения,,,,Отказ);			
		КонецЦикла;

	КонецЕсли;

	Если НЕ Отказ Тогда
		УстановитьУправляемыеБлокировки();
		торо_ПроцентыВыполнения.СоздатьДокументыПлановыхЗатрат(РемонтыОборудования, РемонтныеРаботы, Ложь);
		ДвиженияПоРегистрам(РежимПроведения, Отказ);
	КонецЕсли;
	
	торо_РаботаСоСтатусамиДокументовСервер.УстановитьСтатусРемонтовПриПроведении(ЭтотОбъект);
	торо_РаботаСоСтатусамиДокументовСервер.ИзменитьСтатусыДокументовРемонта(Ссылка);
	
	торо_Ремонты.ОбновитьЗаписиНезависимыхРегистровПоРемонтам(ЭтотОбъект, РежимЗаписиДокумента.Проведение);
	
	#Вставка
	//++ Проф-ИТ, #340, Корнилов М.С., 28.11.2023
	Если ДополнительныеСвойства.Свойство("ПервоначальнаяЗагрузка") = Ложь Тогда 
		//++ Проф-ИТ, #222, Башинская А.Ю., 03.08.2023, создание док.Состояние ОР на основании 
		проф_СоздатьСостояниеОбъектовРемонтаНаОсновании();
		//-- Проф-ИТ, #222, Башинская А.Ю., 03.08.2023   
	КонецЕсли;
	//-- Проф-ИТ, #340, Корнилов М.С., 28.11.2023
	
	//++ Проф-ИТ, #66, Башинская А.Ю., 14.09.2023
	Если Не Отказ Тогда
		проф_ЗарегистрироватьИзмененияСметыДляИзмененияСтатусаВЕРП();
		//++ Проф-ИТ, #311, Корнилов М.С., 26.10.2023
		проф_СоздатьВнешнееОснованиеДляРабот();
		//-- Проф-ИТ, #311, Корнилов М.С., 26.10.2023
		//++ Проф-ИТ, #350, Соловьев А.А., 16.11.2023
		проф_ЗаполнитьПричинуОтменыВЗаказеНаВП();
		//-- Проф-ИТ, #350, Соловьев А.А., 16.11.2023
	КонецЕсли;
	//-- Проф-ИТ, #66, Башинская А.Ю., 14.09.2023  
	#КонецВставки 
	
КонецПроцедуры   

&ИзменениеИКонтроль("ОбработкаПроверкиЗаполнения")
Процедура проф_ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)

	МассивНепроверяемыхРеквизитов = Новый Массив;
	МассивВсехРеквизитов = Новый Массив;
	МассивРеквизитовОперации = Новый Массив;
	
	ОбщегоНазначенияУТКлиентСервер.ЗаполнитьМассивНепроверяемыхРеквизитов(
		МассивВсехРеквизитов,
		МассивРеквизитовОперации,
		МассивНепроверяемыхРеквизитов);
		
	#Вставка
	//++ Проф-ИТ, #326, Соловьев А.А., 01.11.2023
	Если РемонтныеРаботы.Найти(Ложь, "Выполнено") = Неопределено Тогда 
		ПроверяемыеРеквизиты.Удалить(ПроверяемыеРеквизиты.Найти("проф_ЭксплуатацияВозможна"));
	КонецЕсли;
	//-- Проф-ИТ, #326, Соловьев А.А., 01.11.2023
	#КонецВставки
	ФОИспользоватьХарактеристикиНоменклатуры = ПолучитьФункциональнуюОпцию("торо_ИспользоватьХарактеристикиНоменклатуры");
	МассивНепроверяемыхРеквизитов.Добавить("МатериальныеЗатраты.ХарактеристикаНоменклатуры");
	Если ФОИспользоватьХарактеристикиНоменклатуры = Истина Тогда
		ПараметрыПроверки = Новый Структура("СуффиксХарактеристики, ИмяТЧ", "Номенклатуры", "МатериальныеЗатраты");
		НоменклатураСервер.ПроверитьЗаполнениеХарактеристик(ЭтотОбъект,МассивНепроверяемыхРеквизитов,Отказ, ПараметрыПроверки);
	КонецЕсли;
	
	Если Не Отказ И ОбщегоНазначенияУТ.ПроверитьЗаполнениеРеквизитовОбъекта(ЭтотОбъект, ПроверяемыеРеквизиты) Тогда
		Отказ = Истина;
	КонецЕсли;

	ПроверитьДублиИсполнителей(Отказ);
	
	СписокТЧ = Новый Структура();
	СписокТЧ.Вставить("РемонтныеРаботы", "Ремонтные работы");
	СписокТЧ.Вставить("РемонтыОборудования", "Ремонты оборудования");
	
	ШаблонСообщения = НСтр("ru = 'В табличной части ""%1"" нет строк.'");
	Для каждого текТЧ из СписокТЧ Цикл
		Если ЭтотОбъект[ТекТЧ.Ключ].Количество() = 0 Тогда
			ТекстСообщения = СтрШаблон(ШаблонСообщения, ТекТЧ.Значение);
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения,,,,Отказ);
		КонецЕсли;
	КонецЦикла;
	
	Если Отказ тогда
		Возврат;
	КонецЕсли;
	
	ШаблонСообщения = НСтр("ru = 'Для объекта ремонта ""%1"" с видом ремонта ""%2"" отсутствуют строки в дереве ремонтных работ.'");
	Для Каждого СтрокаСРемонтом Из РемонтыОборудования Цикл
		МассивСтрок = РемонтныеРаботы.НайтиСтроки(Новый структура("РемонтыОборудования_ID", СтрокаСРемонтом.ID));
		Если МассивСтрок.Количество() = 0 Тогда			
			ТекстСообщения = СтрШаблон(ШаблонСообщения, СтрокаСРемонтом.ОбъектРемонта, СтрокаСРемонтом.ВидРемонтныхРабот);
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения,,,,Отказ);
			Возврат;			
		КонецЕсли;
	КонецЦикла;

	// Проверка заполнения табличных частей.
	ПроверитьЗаполнениеТабличнойЧастиРемонтыОборудования(Отказ);
	ПроверитьЗаполнениеТабличнойЧастиРемонтныеРаботы(РемонтныеРаботы, Отказ);
	ПроверитьЗаполнениеТабличнойЧастиМатериальныеЗатраты(Отказ);
	ПроверитьЗаполнениеТабличнойЧастиПоДокументамОснованиям(Отказ);
	ПроверитьЗаполнениеТабличнойЧастиТрудовыеЗатраты(Отказ);
	ПроверитьЗаполнениеТабличнойЧастиСерийныеЗапчасти(Отказ);
	ПроверитьЗаполнениеТабличнойЧастиИсполнители(Отказ); 
	
	Если Константы.торо_ЗапретитьПересечениеВремениРаботыСотрудниковСОдинаковойКвалификацией.Получить()
		И торо_ОбщегоНазначения.ПроверитьВремяРаботыСотрудников(ЭтотОбъект, "ТрудовыеЗатраты") Тогда 
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

&После("ПередЗаписью")
Процедура проф_ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	//++ Проф-ИТ, #401, Соловьев А.А., 11.12.2023
	Если РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда 
		проф_ОбщегоНазначенияВызовСервера.ПроверитьПризнакПодразделенияОрганизации(ЭтотОбъект["Подразделение"], Отказ);
	КонецЕсли;
	//-- Проф-ИТ, #401, Соловьев А.А., 11.12.2023
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

//++ Проф-ИТ, #222, Башинская А.Ю., 03.08.2023, создание док.Состояние ОР на основании
Процедура проф_СоздатьСостояниеОбъектовРемонтаНаОсновании()
	
	НайденныйДокумент = проф_НайтиСозданныйРанееДокументСостояниеОР();
	
	Если НайденныйДокумент = Неопределено Тогда
		// Нужно создавать документ
		ДокументСОР = Документы.торо_СостоянияОбъектовРемонта.СоздатьДокумент();
		ДокументСОР.Дата = ТекущаяДатаСеанса();
	Иначе  
		// Обновим уже созданный документ
		ДокументСОР = НайденныйДокумент.ПолучитьОбъект(); 
		ДокументСОР.ОбъектыРемонта.Очистить();
	КонецЕсли;
	
	ДокументСОР.Заполнить(Ссылка);  
	ДокументСОР.ВидОперации = Перечисления.торо_ВидыОперацийОтклоненияВРаботеОборудования.ВидЭксплуатации; 
	ДокументСОР.Автор = Ссылка.Автор;
	ДокументСОР.Ответственный = Ссылка.Ответственный;	
	ДокументСОР.Записать(РежимЗаписиДокумента.Проведение); 
	
КонецПроцедуры

Функция проф_НайтиСозданныйРанееДокументСостояниеОР()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	торо_СостоянияОбъектовРемонта.Ссылка КАК Ссылка
	|ИЗ
	|	Документ.торо_СостоянияОбъектовРемонта КАК торо_СостоянияОбъектовРемонта
	|ГДЕ
	|	НЕ торо_СостоянияОбъектовРемонта.ПометкаУдаления 
	|	И торо_СостоянияОбъектовРемонта.Проведен
	|	И торо_СостоянияОбъектовРемонта.ДокументОснование = &ДокументОснование";
	Запрос.УстановитьПараметр("ДокументОснование", Ссылка);
	РезультатЗапроса = Запрос.Выполнить();	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат	ВыборкаДетальныеЗаписи.Ссылка;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции
//-- Проф-ИТ, #222, Башинская А.Ю., 03.08.2023

//++ Проф-ИТ, #66, Башинская А.Ю., 14.09.2023
Процедура проф_ЗарегистрироватьИзмененияСметыДляИзмененияСтатусаВЕРП()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	торо_АктОВыполненииЭтапаРаботРемонтыОборудования.ID КАК ID,
	|	торо_ЗаявкиПоРемонтам.Регистратор КАК Смета
	|ИЗ
	|	Документ.торо_АктОВыполненииЭтапаРабот.РемонтыОборудования КАК торо_АктОВыполненииЭтапаРаботРемонтыОборудования
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_ЗаявкиПоРемонтам КАК торо_ЗаявкиПоРемонтам
	|		ПО торо_АктОВыполненииЭтапаРаботРемонтыОборудования.ID = торо_ЗаявкиПоРемонтам.IDРемонта
	|ГДЕ
	|	торо_АктОВыполненииЭтапаРаботРемонтыОборудования.Ссылка = &Ссылка";	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	Заявка = Неопределено;	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл  
		Если ЗначениеЗаполнено(ВыборкаДетальныеЗаписи.Смета) Тогда
			Заявка = ВыборкаДетальныеЗаписи.Смета;
		КонецЕсли;
	КонецЦикла;
	
	//++ Проф-ИТ, #225, Горетовская М.С., 06.09.2023 - Разработать обработку по загрузке исторических данных о фактических затратах на ОР
	Если Заявка = Неопределено Тогда 
		Возврат;
	КонецЕсли; 
	//-- Проф-ИТ, #225, Горетовская М.С., 06.09.2023 - Разработать обработку по загрузке исторических данных о фактических затратах на ОР
	
	ЗаявкаОбъект = Заявка.получитьОбъект();  
	ЗаявкаОбъект.ОбменДанными.Загрузка = Истина;
	ИмяПланаОбмена = "ОбменТОИР30ЕРП20";
	Если Заявка.Проведен Тогда
		РежимЗаписи = РежимЗаписиДокумента.Проведение;
	Иначе
		РежимЗаписи = РежимЗаписиДокумента.Запись;
	КонецЕсли;
	
	торо_ОбменТОИР30ЕРП20События.ОбменТОиР30ЕРП20_ЗарегистрироватьИзменениеДокументаПередЗаписью(ЗаявкаОбъект,
		Ложь, РежимЗаписи, РежимПроведенияДокумента.Неоперативный);
	Попытка
		ЗаявкаОбъект.Записать();
	Исключение
		ОписаниеОшибки = ОбработкаОшибок.ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(
		"Документ.торо_АктОВыполненииЭтапаРабот.проф_ЗарегистрироватьИзмененияСметыДляИзмененияСтатусаВЕРП",
		УровеньЖурналаРегистрации.Ошибка,
		Метаданные.Документы.торо_АктОВыполненииЭтапаРабот,
		Ссылка, 
		ОписаниеОшибки);
	КонецПопытки;
	
КонецПроцедуры 
//-- Проф-ИТ, #66, Башинская А.Ю., 14.09.2023


//++ Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"
&ИзменениеИКонтроль("ПодготовитьТаблицуМатериальныхЗатрат")
Функция проф_ПодготовитьТаблицуМатериальныхЗатрат(ТаблицаДвижений)

	ТаблицаМатериальныхЗатрат = Движения.торо_ФактическиеМатериальныеЗатратыРемонтныхРабот.Выгрузить();

	Если МатериальныеЗатраты.Количество()=0 Тогда

		Возврат ТаблицаМатериальныхЗатрат;

	КонецЕсли; 

	БуферМЗ = МатериальныеЗатраты.Выгрузить();
	БуферМЗ.Колонки.Добавить("Период");
	Для Каждого СтрокаТЗ Из БуферМЗ Цикл
		КоэффициентЕИ = СтрокаТЗ.ЕдиницаИзмерения.Коэффициент;
		СтрокаТЗ.Количество = СтрокаТЗ.Количество * ?(КоэффициентЕИ = 0, 1, КоэффициентЕИ);

		СтрокаРемонта = РемонтыОборудования.Найти(СтрокаТЗ.РемонтыОборудования_ID);
		Если СтрокаРемонта <> Неопределено Тогда
			СтрокаТЗ.Период = СтрокаРемонта.ДатаОкончания;
		КонецЕсли;
	КонецЦикла;

	БуферМЗ.Свернуть("ID, РемонтыОборудования_ID, Номенклатура, ХарактеристикаНоменклатуры,Период", "Количество");
#Вставка //++ Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"
	ТаблицаМатериальныхЗатрат.Колонки.Добавить("Выполнено",Новый ОписаниеТипов("Булево"));
#КонецВставки //-- Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"
	
	Для Каждого СтрокаТЗ Из БуферМЗ Цикл

		Если НЕ ЗначениеЗаполнено(СтрокаТЗ.ID) Тогда
			Продолжить;	
		КонецЕсли;

		НайденнаяСтрокаТЗ = РемонтныеРаботы.Найти(СтрокаТЗ.ID, "ID");
		Если Не НайденнаяСтрокаТЗ = Неопределено Тогда
			НовСтрокаТЗ = ТаблицаМатериальныхЗатрат.Добавить();
			ЗаполнитьЗначенияСвойств(НовСтрокаТЗ, СтрокаТЗ);
			НовСтрокаТЗ.РемонтнаяРабота = НайденнаяСтрокаТЗ.РемонтнаяРабота;
#Вставка //++ Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"
			НовСтрокаТЗ.Выполнено = НайденнаяСтрокаТЗ.Выполнено;
#КонецВставки //-- Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"
		КонецЕсли; 

	КонецЦикла; 

#Удаление
	ТаблицаМатериальныхЗатрат.Свернуть("ID, РемонтыОборудования_ID, Номенклатура, ХарактеристикаНоменклатуры,Период, РемонтнаяРабота", "Количество");
#КонецУдаления
#Вставка //++ Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"
	ТаблицаМатериальныхЗатрат.Свернуть("ID, РемонтыОборудования_ID, Номенклатура, ХарактеристикаНоменклатуры,Период, РемонтнаяРабота, Выполнено", "Количество");
#КонецВставки //-- Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"

	Возврат ТаблицаМатериальныхЗатрат;

КонецФункции

&ИзменениеИКонтроль("ДвиженияПоРегистру_торо_ФактическиеМатериальныеЗатратыРемонтныхРабот")
Процедура проф_ДвиженияПоРегистру_торо_ФактическиеМатериальныеЗатратыРемонтныхРабот(РежимПроведения, ТаблицаМатериальныхЗатрат, Отказ)

	Движения.торо_ФактическиеМатериальныеЗатратыРемонтныхРабот.Записывать = Истина;
#Вставка //++ Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"
	Движения.проф_МатериальныеЗатратыНаНевыполненныеРемонтныеРаботы.Записывать = Истина;
#КонецВставки //-- Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"
	Для Каждого ЗаписьМатериальныеЗатраты ИЗ ТаблицаМатериальныхЗатрат Цикл
#Вставка //++ Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"
		Если ЗаписьМатериальныеЗатраты.Выполнено тогда
#КонецВставки //-- Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"
		Движение = Движения.торо_ФактическиеМатериальныеЗатратыРемонтныхРабот.Добавить();
		Движение.ID = ЗаписьМатериальныеЗатраты.ID;
		Движение.РемонтыОборудования_ID = ЗаписьМатериальныеЗатраты.РемонтыОборудования_ID;
		Движение.Количество = ЗаписьМатериальныеЗатраты.Количество;
		Движение.Номенклатура = ЗаписьМатериальныеЗатраты.Номенклатура;
		Движение.Период = ЗаписьМатериальныеЗатраты.Период;
		Движение.РемонтнаяРабота = ЗаписьМатериальныеЗатраты.РемонтнаяРабота;
		Движение.ХарактеристикаНоменклатуры = ЗаписьМатериальныеЗатраты.ХарактеристикаНоменклатуры;
#Вставка //++ Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"
		иначе
			Движение = Движения.проф_МатериальныеЗатратыНаНевыполненныеРемонтныеРаботы.Добавить();
			Движение.ID = ЗаписьМатериальныеЗатраты.ID;
			Движение.РемонтыОборудования_ID = ЗаписьМатериальныеЗатраты.РемонтыОборудования_ID;
			Движение.Количество = ЗаписьМатериальныеЗатраты.Количество;
			Движение.Номенклатура = ЗаписьМатериальныеЗатраты.Номенклатура;
			Движение.Период = ЗаписьМатериальныеЗатраты.Период;
			Движение.РемонтнаяРабота = ЗаписьМатериальныеЗатраты.РемонтнаяРабота;
			Движение.ХарактеристикаНоменклатуры = ЗаписьМатериальныеЗатраты.ХарактеристикаНоменклатуры;
		КонецЕсли;
#КонецВставки //-- Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"
	КонецЦикла;

КонецПроцедуры

&ИзменениеИКонтроль("ДвиженияПоРегистру_торо_ВыполненныеРемонтныеРаботы")
Процедура проф_ДвиженияПоРегистру_торо_ВыполненныеРемонтныеРаботы(РежимПроведения, ТабРемРаб, Отказ)

	Движения.торо_ВыполненныеРемонтныеРаботы.Записывать = Истина;
#Вставка //++ Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"
	Движения.проф_НевыполненныеРемонтныеРаботы.Записывать = Истина;
#КонецВставки //-- Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"

	Если ЗавершитьРемонтныеРаботы Тогда

		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВремТаб.РемонтыОборудования_ID КАК IDРемонта,
		|	ВремТаб.ID КАК IDОперации,
		|	ВремТаб.Родитель_ID
		|ПОМЕСТИТЬ Таб
		|ИЗ 
		|	&Таб КАК ВремТаб
		|
		|;
		|
		|ВЫБРАТЬ
		|	торо_ВыполненныеРемонтныеРаботыСрезПоследних.IDРемонта,
		|	торо_ВыполненныеРемонтныеРаботыСрезПоследних.IDОперации,
		|	торо_ВыполненныеРемонтныеРаботыСрезПоследних.Родитель_ID
		|ИЗ
		|	РегистрСведений.торо_ВыполненныеРемонтныеРаботы.СрезПоследних(, (IDОперации, IDРемонта, Родитель_ID) В (ВЫБРАТЬ Таб.IDОперации, Таб.IDРемонта, Таб.Родитель_ID ИЗ Таб КАК Таб)) КАК торо_ВыполненныеРемонтныеРаботыСрезПоследних";

		Запрос.УстановитьПараметр("Таб", ТабРемРаб);

		РезультатЗапроса = Запрос.Выполнить();

		ТабЗакрытыхРабот = РезультатЗапроса.Выгрузить();

	КонецЕсли;

	Для каждого СтрТаб Из ТабРемРаб Цикл

		ДелатьДвижение = Ложь;
		Если ЗавершитьРемонтныеРаботы Тогда
			МассивСтрок = ТабЗакрытыхРабот.НайтиСтроки(Новый Структура("IDОперации, IDРемонта, Родитель_ID", СтрТаб.ID, СтрТаб.РемонтыОборудования_ID, СтрТаб.Родитель_ID));
			Если МассивСтрок.Количество() Тогда
				Продолжить;
			КонецЕсли;
		КонецЕсли;

		Если ЗавершитьРемонтныеРаботы Тогда
			ПроцентВыполнения = (100 - (СтрТаб.ПроцентОперацийОстатокЗаплРем - СтрТаб.ПроцентВыполненияРабот)) * СтрТаб.Количество;
			ДелатьДвижение = Истина;
		Иначе
			Если ФОИспользоватьУсложненнуюСхемуЗакрытияНарядов Тогда
				Если СтрТаб.ПроцентВыполненияРабот = 100 Тогда
					ПроцентВыполнения = 100;
					ДелатьДвижение = Истина;
				КонецЕсли;
			Иначе
				Если СтрТаб.Выполнено Тогда
					ПроцентВыполнения = 100;
					ДелатьДвижение = Истина;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;

		Если ДелатьДвижение Тогда 
#Вставка //++ Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"
			Если СтрТаб.Выполнено тогда
#КонецВставки //-- Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"
			Движение = Движения.торо_ВыполненныеРемонтныеРаботы.Добавить();
			Движение.Период = Дата;
			Движение.IDОперации = СтрТаб.ID;
			Движение.IDРемонта = СтрТаб.РемонтыОборудования_ID;
			Движение.Родитель_ID = СтрТаб.Родитель_ID;
			Движение.ПроцентВыполнения = ПроцентВыполнения;
#Вставка //++ Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"
			Иначе
				Движение = Движения.проф_НевыполненныеРемонтныеРаботы.Добавить();
				Движение.Период = Дата;
				Движение.IDОперации = СтрТаб.ID;
				Движение.IDРемонта = СтрТаб.РемонтыОборудования_ID;
				Движение.Родитель_ID = СтрТаб.Родитель_ID;
				Движение.ПроцентВыполнения = ПроцентВыполнения;
			КонецЕсли;
#КонецВставки //-- Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"
		КонецЕсли;

	КонецЦикла;

КонецПроцедуры

//-- Проф-ИТ, #289, Горетовская М.С., 04.10.2023 - Наполнение РС "Невыполненные ремонтные работы"

//++ Проф-ИТ, #311, Корнилов М.С., 26.10.2023
Процедура проф_СоздатьВнешнееОснованиеДляРабот()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	торо_ВнешнееОснованиеДляРабот.Ссылка КАК Ссылка
	|ИЗ
	|	Документ.торо_ВнешнееОснованиеДляРабот КАК торо_ВнешнееОснованиеДляРабот
	|ГДЕ
	|	торо_ВнешнееОснованиеДляРабот.ДокументОснование = &ДокументОснование
	|	И торо_ВнешнееОснованиеДляРабот.Проведен";
	
	Запрос.УстановитьПараметр("ДокументОснование", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда 
		ВнешнееОснованиеОбъект = Документы.торо_ВнешнееОснованиеДляРабот.СоздатьДокумент();
		ВнешнееОснованиеОбъект.Заполнить(Ссылка);
		Если ВнешнееОснованиеОбъект.РемонтныеРаботы.Количество() > 0 Тогда 
			ВнешнееОснованиеОбъект.Записать(РежимЗаписиДокумента.Проведение);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры
//-- Проф-ИТ, #311, Корнилов М.С., 26.10.2023

//++ Проф-ИТ, #329, Соловьев А.А., 08.11.2023
&После("ДвиженияПоРегистрам")
Процедура проф_ДвиженияПоРегистрам(РежимПроведения, Отказ)
	
	Если Не Отказ Тогда
		Документы.торо_АктОВыполненииЭтапаРабот.проф_ДвиженияПоРегистру_проф_СоответствиеАктовИВнутреннегоПотребления(Ссылка);
		проф_ДвиженияПоРегистру_проф_ОстатокТМЦКСписаниюПоЗакрытымАктамНаРемонт(РежимПроведения, Отказ);
	КонецЕсли;
	
КонецПроцедуры

Процедура проф_ДвиженияПоРегистру_проф_ОстатокТМЦКСписаниюПоЗакрытымАктамНаРемонт(РежимПроведения, Отказ)
	
	Движения.проф_ОстатокТМЦКСписаниюПоЗакрытымАктамНаРемонт.Записывать = Истина;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) КАК ВидДвижения,
	|	&Дата КАК Период,
	|	торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты.Ссылка КАК АктОВыполненииЭтапаРабот,
	|	торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты.Номенклатура КАК Номенклатура,
	|	торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты.ХарактеристикаНоменклатуры КАК Характеристика,
	|	СУММА(торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты.Количество) КАК Количество
	|ИЗ
	|	Документ.торо_АктОВыполненииЭтапаРабот.МатериальныеЗатраты КАК торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_АктОВыполненииЭтапаРабот.РемонтыОборудования КАК торо_АктОВыполненииЭтапаРаботРемонтыОборудования
	|		ПО торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты.Ссылка = торо_АктОВыполненииЭтапаРаботРемонтыОборудования.Ссылка
	|			И торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты.РемонтыОборудования_ID = торо_АктОВыполненииЭтапаРаботРемонтыОборудования.ID
	|ГДЕ
	|	торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты.Ссылка = &Ссылка
	|
	|СГРУППИРОВАТЬ ПО
	|	торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты.Ссылка,
	|	торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты.Номенклатура,
	|	торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты.ХарактеристикаНоменклатуры";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("Дата", Дата);
	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		Движение = Движения.проф_ОстатокТМЦКСписаниюПоЗакрытымАктамНаРемонт.Добавить();
		ЗаполнитьЗначенияСвойств(Движение, Выборка);
	КонецЦикла;
	
КонецПроцедуры
//-- Проф-ИТ, #329, Соловьев А.А., 08.11.2023

//++ Проф-ИТ, #350, Соловьев А.А., 16.11.2023
Процедура проф_ЗаполнитьПричинуОтменыВЗаказеНаВП()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	торо_ИнтеграцияДокументов.ДокументЕРП КАК ЗаказНаВнутреннееПотребление
	|ПОМЕСТИТЬ ЗаказыНаВП
	|ИЗ
	|	РегистрСведений.торо_ИнтеграцияДокументов КАК торо_ИнтеграцияДокументов
	|ГДЕ
	|	торо_ИнтеграцияДокументов.ID В(&СписокID)
	|	И торо_ИнтеграцияДокументов.ДокументЕРП.Проведен
	|	И ТИПЗНАЧЕНИЯ(торо_ИнтеграцияДокументов.ДокументЕРП) = ТИП(Документ.ЗаказНаВнутреннееПотребление)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЗаказНаВнутреннееПотреблениеТовары.Ссылка КАК Ссылка,
	|	ЗаказНаВнутреннееПотреблениеТовары.КодСтроки КАК КодСтроки,
	|	торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты.проф_Отменено КАК Отменено
	|ИЗ
	|	Документ.торо_АктОВыполненииЭтапаРабот.МатериальныеЗатраты КАК торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ЗаказНаВнутреннееПотребление.проф_ТоварыИсточника КАК ТоварыИсточника
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ЗаказНаВнутреннееПотребление.Товары КАК ЗаказНаВнутреннееПотреблениеТовары
	|				ВНУТРЕННЕЕ СОЕДИНЕНИЕ ЗаказыНаВП КАК ЗаказыНаВП
	|				ПО ЗаказНаВнутреннееПотреблениеТовары.Ссылка = ЗаказыНаВП.ЗаказНаВнутреннееПотребление
	|			ПО ТоварыИсточника.КодСтроки = ЗаказНаВнутреннееПотреблениеТовары.КодСтроки
	|		ПО торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты.ID = ТоварыИсточника.ID
	|			И торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты.РемонтыОборудования_ID = ТоварыИсточника.РемонтыОборудования_ID
	|			И торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты.Номенклатура = ТоварыИсточника.Номенклатура
	|			И торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты.ХарактеристикаНоменклатуры = ТоварыИсточника.Характеристика
	|			И торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты.ЕдиницаИзмерения = ТоварыИсточника.Упаковка
	|ГДЕ
	|	торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты.Ссылка = &Ссылка
	|	И торо_АктОВыполненииЭтапаРаботМатериальныеЗатраты.проф_Отменено <> ЗаказНаВнутреннееПотреблениеТовары.Отменено
	|ИТОГИ ПО
	|	Ссылка";
	
	Запрос.УстановитьПараметр("СписокID", РемонтыОборудования.ВыгрузитьКолонку("ID"));
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда 
		Возврат;
	КонецЕсли;
	
	ВыборкаСсылка = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	
	НачатьТранзакцию();
	
	Попытка
		
		Пока ВыборкаСсылка.Следующий() Цикл
			
			ДокументЗВПОбъект = ВыборкаСсылка.Ссылка.ПолучитьОбъект();
			
			Выборка = ВыборкаСсылка.Выбрать();
			
			Пока Выборка.Следующий() Цикл
				
				СтрокаТовары = ДокументЗВПОбъект.Товары.Найти(Выборка.КодСтроки, "КодСтроки");
				Если СтрокаТовары = Неопределено Тогда
					Продолжить;
				КонецЕсли;
				
				СтрокаТовары.Отменено = Выборка.Отменено;
				Если СтрокаТовары.Отменено Тогда 
					СтрокаТовары.проф_ПричинаОтмены = Ссылка;
				Иначе
					СтрокаТовары.проф_ПричинаОтмены = Документы.торо_АктОВыполненииЭтапаРабот.ПустаяСсылка();
				КонецЕсли;
				
			КонецЦикла;
			
			ДокументЗВПОбъект.БезусловнаяЗапись = Истина;
			ДокументЗВПОбъект.Записать(РежимЗаписиДокумента.Проведение);
			
		КонецЦикла;
		
		ЗафиксироватьТранзакцию();
		
	Исключение
		
		ОтменитьТранзакцию();
		ТекстСообщения = НСтр("ru = 'Не удалось внести изменения в документ Заказ на внутреннее потребление по причине: %1'");
		ТекстСообщения = СтрШаблон(ТекстСообщения, ОписаниеОшибки());
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
		
	КонецПопытки;
	
КонецПроцедуры
//-- Проф-ИТ, #350, Соловьев А.А., 16.11.2023

#КонецОбласти


