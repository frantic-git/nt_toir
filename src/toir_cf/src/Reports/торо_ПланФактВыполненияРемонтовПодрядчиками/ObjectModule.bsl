#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	ТекИерархия = торо_ОтчетыСервер.ПолучитьЗначениеСтруктурыИерархии(КомпоновщикНастроек);
	
	торо_ОтчетыСервер.УстановитьЗапросыНаборовДанныхИерархииОР(СхемаКомпоновкиДанных, ТекИерархия, "КонецПериода");
	
	Если ТекИерархия.СтроитсяАвтоматически Тогда
				
		СхемаКомпоновкиДанных.НаборыДанных.Объекты.Запрос =
		ПолучитьСодержательнуюЧастьЗапроса()+
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	Данные.ID КАК ID,
		|	Данные.ДатаНачалаРемонтныхРабот КАК ДатаНачалаРемонтныхРабот,
		|	Данные.ДатаОкончанияРемонтныхРабот КАК ДатаОкончанияРемонтныхРабот,
		|	Данные.ДатаНачалаФакт КАК ДатаНачалаФакт,
		|	Данные.ДатаОкончанияФакт КАК ДатаОкончанияФакт,
		|	Данные.ОбъектРемонтныхРабот КАК ОбъектРемонтныхРабот,
		|	Данные.ВидРемонтныхРабот КАК ВидРемонтныхРабот,
		|	Данные.Исполнитель КАК Исполнитель,
		|	Данные.ДокументНачалаЦепочки КАК ДокументНачалаЦепочки,
		|	Данные.Акт КАК Акт,
		|	Данные.СтатусРаботыПодрядчика КАК СтатусРаботыПодрядчика,
		|	Данные.РемонтЗавершен КАК РемонтЗавершен,
		|	торо_ОбъектыРемонта." + ТекИерархия.РеквизитОР + " КАК ОбъектИерархии
		|ИЗ
		|	Данные КАК Данные
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.торо_ОбъектыРемонта КАК торо_ОбъектыРемонта
		|		ПО Данные.ОбъектРемонтныхРабот = торо_ОбъектыРемонта.Ссылка";

		торо_ОтчетыКлиентСервер.УстановитьТипИерархическойГруппировкиВНастройках(КомпоновщикНастроек, "ОбъектИерархии", ТипГруппировкиКомпоновкиДанных.Иерархия);
		
	Иначе

		торо_ОтчетыКлиентСервер.УстановитьТипИерархическойГруппировкиВНастройках(КомпоновщикНастроек, "ОбъектИерархии", ТипГруппировкиКомпоновкиДанных.ТолькоИерархия);

		СхемаКомпоновкиДанных.НаборыДанных.Объекты.Запрос = 
		ПолучитьСодержательнуюЧастьЗапроса()+
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	Данные.ID КАК ID,
		|	Данные.ДатаНачалаРемонтныхРабот КАК ДатаНачалаРемонтныхРабот,
		|	Данные.ДатаОкончанияРемонтныхРабот КАК ДатаОкончанияРемонтныхРабот,
		|	Данные.ДатаНачалаФакт КАК ДатаНачалаФакт,
		|	Данные.ДатаОкончанияФакт КАК ДатаОкончанияФакт,
		|	Данные.ОбъектРемонтныхРабот КАК ОбъектРемонтныхРабот,
		|	Данные.ВидРемонтныхРабот КАК ВидРемонтныхРабот,
		|	Данные.Исполнитель КАК Исполнитель,
		|	Данные.ДокументНачалаЦепочки КАК ДокументНачалаЦепочки,
		|	Данные.Акт КАК Акт,
		|	Данные.СтатусРаботыПодрядчика КАК СтатусРаботыПодрядчика,
		|	Данные.РемонтЗавершен КАК РемонтЗавершен,
		|	торо_ОбъектыРемонта.Ссылка КАК ОбъектИерархии
		|ИЗ
		|	Данные КАК Данные
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.торо_ОбъектыРемонта КАК торо_ОбъектыРемонта
		|		ПО Данные.ОбъектРемонтныхРабот = торо_ОбъектыРемонта.Ссылка";
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
	
	Настройки.ЗагрузитьНастройкиПриИзмененииПараметров = ЗагрузитьНастройкиПриИзмененииПараметров();

КонецПроцедуры

Функция ЗагрузитьНастройкиПриИзмененииПараметров()  
	
	Параметры = Новый Массив;
	Параметры.Добавить(Новый ПараметрКомпоновкиДанных("ИерархияТип"));	
	Возврат Параметры;
	
КонецФункции

Функция ПолучитьСодержательнуюЧастьЗапроса() 
	ЗапросТекст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	торо_ОбщиеДанныеПоРемонтам.IDРемонта КАК IDРемонта,
	|	ЕСТЬNULL(торо_МаршрутыРегламентныхМероприятий.ОбъектРемонта, торо_ОбщиеДанныеПоРемонтам.ОбъектРемонта) КАК ОбъектРемонта,
	|	торо_ОбщиеДанныеПоРемонтам.ВидРемонта КАК ВидРемонта,
	|	торо_ОбщиеДанныеПоРемонтам.Завершен КАК РемонтЗавершен,
	|	торо_АктуальныеПлановыеДатыРемонтов.ДатаНачала КАК ДатаНачалаРемонтныхРабот,
	|	торо_АктуальныеПлановыеДатыРемонтов.ДатаОкончания КАК ДатаОкончанияРемонтныхРабот,
	|	торо_АктуальныеПлановыеДатыРемонтов.ДокументНачалаЦепочки КАК ДокументНачалаЦепочки,
	|	торо_МаршрутыРегламентныхМероприятий.СписокОбъектов КАК СписокОбъектов
	|ПОМЕСТИТЬ ВТ_Ремонты
	|ИЗ
	|	РегистрСведений.торо_ОбщиеДанныеПоРемонтам КАК торо_ОбщиеДанныеПоРемонтам
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.торо_АктуальныеПлановыеДатыРемонтов КАК торо_АктуальныеПлановыеДатыРемонтов
	|		ПО торо_ОбщиеДанныеПоРемонтам.IDРемонта = торо_АктуальныеПлановыеДатыРемонтов.IDРемонта
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_МаршрутыРегламентныхМероприятий КАК торо_МаршрутыРегламентныхМероприятий
	|		ПО торо_ОбщиеДанныеПоРемонтам.ОбъектРемонта = торо_МаршрутыРегламентныхМероприятий.СписокОбъектов
	|ГДЕ
	|	ВЫБОР
	|			КОГДА торо_ОбщиеДанныеПоРемонтам.ВидДокументаНачалаЦепочки = ЗНАЧЕНИЕ(Перечисление.торо_ВидыДокументовНачалаЦепочкиРемонтов.ВыявленныйДефект)
	|				ТОГДА &ПоказыватьДефекты = ИСТИНА
	|			КОГДА торо_ОбщиеДанныеПоРемонтам.ВидДокументаНачалаЦепочки = ЗНАЧЕНИЕ(Перечисление.торо_ВидыДокументовНачалаЦепочкиРемонтов.ВнешнееОснованиеДляРабот)
	|				ТОГДА &ПоказыватьВнешниеОснования = ИСТИНА
	|			КОГДА торо_ОбщиеДанныеПоРемонтам.ВидДокументаНачалаЦепочки = ЗНАЧЕНИЕ(Перечисление.торо_ВидыДокументовНачалаЦепочкиРемонтов.ПланГрафикППР)
	|				ТОГДА &ПоказыватьППР = ИСТИНА
	|			КОГДА торо_ОбщиеДанныеПоРемонтам.ВидДокументаНачалаЦепочки = ЗНАЧЕНИЕ(Перечисление.торо_ВидыДокументовНачалаЦепочкиРемонтов.ГрафикРегламентныхМероприятий)
	|				ТОГДА &ПоказыватьРМ = ИСТИНА
	|			ИНАЧЕ ЛОЖЬ
	|		КОНЕЦ
	|	И НЕ торо_ОбщиеДанныеПоРемонтам.Отменен
	|	И НЕ торо_ОбщиеДанныеПоРемонтам.Замещен
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	IDРемонта
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ВТ_Ремонты.IDРемонта КАК IDРемонта,
	|	ВТ_Ремонты.ОбъектРемонта КАК ОбъектРемонта,
	|	ВТ_Ремонты.ВидРемонта КАК ВидРемонта,
	|	ВТ_Ремонты.РемонтЗавершен КАК РемонтЗавершен,
	|	ВТ_Ремонты.ДатаНачалаРемонтныхРабот КАК ДатаНачалаРемонтныхРабот,
	|	ВТ_Ремонты.ДатаОкончанияРемонтныхРабот КАК ДатаОкончанияРемонтныхРабот,
	|	ВТ_Ремонты.ДокументНачалаЦепочки КАК ДокументНачалаЦепочки,
	|	торо_ПлановыеИсполнителиРемонтов.Исполнитель КАК Исполнитель,
	|	ВТ_Ремонты.СписокОбъектов КАК СписокОбъектов
	|ПОМЕСТИТЬ ВТ_План
	|ИЗ
	|	ВТ_Ремонты КАК ВТ_Ремонты
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.торо_ПлановыеИсполнителиРемонтов КАК торо_ПлановыеИсполнителиРемонтов
	|		ПО ВТ_Ремонты.IDРемонта = торо_ПлановыеИсполнителиРемонтов.IDРемонта
	|ГДЕ
	|	торо_ПлановыеИсполнителиРемонтов.СпособВыполнения = ЗНАЧЕНИЕ(Перечисление.СпособыСтроительства.Подрядный)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	IDРемонта,
	|	Исполнитель
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	|	ВТ_Ремонты.IDРемонта КАК IDРемонта,
	|	ВТ_Ремонты.ОбъектРемонта КАК ОбъектРемонта,
	|	ВТ_Ремонты.ВидРемонта КАК ВидРемонта,
	|	ВТ_Ремонты.РемонтЗавершен КАК РемонтЗавершен,
	|	ВТ_Ремонты.ДатаНачалаРемонтныхРабот КАК ДатаНачалаРемонтныхРабот,
	|	ВТ_Ремонты.ДатаОкончанияРемонтныхРабот КАК ДатаОкончанияРемонтныхРабот,
	|	ВТ_Ремонты.ДокументНачалаЦепочки КАК ДокументНачалаЦепочки,
	|	ВТ_Ремонты.СписокОбъектов КАК СписокОбъектов,
	|	торо_АктОВыполненииЭтапаРаботРемонтыОборудования.ДатаНачала КАК ДатаНачалаФакт,
	|	торо_АктОВыполненииЭтапаРаботРемонтыОборудования.ДатаОкончания КАК ДатаОкончанияФакт,
	|	торо_АктОВыполненииЭтапаРаботИсполнителиПоРемонтам.Ссылка КАК Акт,
	|	торо_АктОВыполненииЭтапаРаботИсполнителиПоРемонтам.Исполнитель КАК Исполнитель
	|ПОМЕСТИТЬ ВТ_Факт
	|ИЗ
	|	ВТ_Ремонты КАК ВТ_Ремонты
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_АктОВыполненииЭтапаРабот.ИсполнителиПоРемонтам КАК торо_АктОВыполненииЭтапаРаботИсполнителиПоРемонтам
	|		ПО ВТ_Ремонты.IDРемонта = торо_АктОВыполненииЭтапаРаботИсполнителиПоРемонтам.РемонтыОборудования_ID
	|			И (торо_АктОВыполненииЭтапаРаботИсполнителиПоРемонтам.Исполнитель ССЫЛКА Справочник.Контрагенты)
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_АктОВыполненииЭтапаРабот.РемонтыОборудования КАК торо_АктОВыполненииЭтапаРаботРемонтыОборудования
	|		ПО ВТ_Ремонты.IDРемонта = торо_АктОВыполненииЭтапаРаботРемонтыОборудования.ID
	|ГДЕ
	|	торо_АктОВыполненииЭтапаРаботИсполнителиПоРемонтам.Ссылка.Проведен
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВТ_Ремонты.IDРемонта,
	|	ВТ_Ремонты.ОбъектРемонта,
	|	ВТ_Ремонты.ВидРемонта,
	|	ВТ_Ремонты.РемонтЗавершен,
	|	ВТ_Ремонты.ДатаНачалаРемонтныхРабот,
	|	ВТ_Ремонты.ДатаОкончанияРемонтныхРабот,
	|	ВТ_Ремонты.ДокументНачалаЦепочки,
	|	ВТ_Ремонты.СписокОбъектов,
	|	торо_АктОВыполненииЭтапаРаботМероприятия.ДатаНачала,
	|	торо_АктОВыполненииЭтапаРаботМероприятия.ДатаОкончания,
	|	торо_АктОВыполненииРегламентногоМероприятияПодрядчикиРемонтныхРабот.Ссылка,
	|	торо_АктОВыполненииРегламентногоМероприятияПодрядчикиРемонтныхРабот.Контрагент
	|ИЗ
	|	ВТ_Ремонты КАК ВТ_Ремонты
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_АктОВыполненииРегламентногоМероприятия.ПодрядчикиРемонтныхРабот КАК торо_АктОВыполненииРегламентногоМероприятияПодрядчикиРемонтныхРабот
	|		ПО ВТ_Ремонты.IDРемонта = торо_АктОВыполненииРегламентногоМероприятияПодрядчикиРемонтныхРабот.РемонтыОборудования_ID
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_АктОВыполненииРегламентногоМероприятия.Мероприятия КАК торо_АктОВыполненииЭтапаРаботМероприятия
	|		ПО ВТ_Ремонты.IDРемонта = торо_АктОВыполненииЭтапаРаботМероприятия.ID
	|ГДЕ
	|	торо_АктОВыполненииРегламентногоМероприятияПодрядчикиРемонтныхРабот.Ссылка.Проведен
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	торо_ОбщиеДанныеПоРемонтам.IDРемонта,
	|	торо_ОбщиеДанныеПоРемонтам.ОбъектРемонта,
	|	торо_ОбщиеДанныеПоРемонтам.ВидРемонта,
	|	торо_ОбщиеДанныеПоРемонтам.Завершен,
	|	торо_АктуальныеПлановыеДатыРемонтов.ДатаНачала,
	|	торо_АктуальныеПлановыеДатыРемонтов.ДатаОкончания,
	|	торо_ОбщиеДанныеПоРемонтам.ДокументНачалаЦепочки,
	|	NULL,
	|	торо_АктОВыполненииЭтапаРаботРемонтыОборудования.ДатаНачала,
	|	торо_АктОВыполненииЭтапаРаботРемонтыОборудования.ДатаОкончания,
	|	торо_АктОВыполненииЭтапаРаботИсполнителиПоРемонтам.Ссылка,
	|	торо_АктОВыполненииЭтапаРаботИсполнителиПоРемонтам.Исполнитель
	|ИЗ
	|	РегистрСведений.торо_ОбщиеДанныеПоРемонтам КАК торо_ОбщиеДанныеПоРемонтам
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_Ремонты КАК ВТ_Ремонты
	|		ПО торо_ОбщиеДанныеПоРемонтам.IDРемонта = ВТ_Ремонты.IDРемонта
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_АктОВыполненииЭтапаРабот.ИсполнителиПоРемонтам КАК торо_АктОВыполненииЭтапаРаботИсполнителиПоРемонтам
	|		ПО торо_ОбщиеДанныеПоРемонтам.IDРемонта = торо_АктОВыполненииЭтапаРаботИсполнителиПоРемонтам.РемонтыОборудования_ID
	|			И (торо_АктОВыполненииЭтапаРаботИсполнителиПоРемонтам.Исполнитель ССЫЛКА Справочник.Контрагенты)
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_АктОВыполненииЭтапаРабот.РемонтыОборудования КАК торо_АктОВыполненииЭтапаРаботРемонтыОборудования
	|		ПО торо_ОбщиеДанныеПоРемонтам.IDРемонта = торо_АктОВыполненииЭтапаРаботРемонтыОборудования.ID
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.торо_АктуальныеПлановыеДатыРемонтов КАК торо_АктуальныеПлановыеДатыРемонтов
	|		ПО торо_ОбщиеДанныеПоРемонтам.IDРемонта = торо_АктуальныеПлановыеДатыРемонтов.IDРемонта
	|			И (ВЫБОР
	|				КОГДА торо_ОбщиеДанныеПоРемонтам.ВидДокументаНачалаЦепочки = ЗНАЧЕНИЕ(Перечисление.торо_ВидыДокументовНачалаЦепочкиРемонтов.ВыявленныйДефект)
	|					ТОГДА &ПоказыватьДефекты = ИСТИНА
	|				КОГДА торо_ОбщиеДанныеПоРемонтам.ВидДокументаНачалаЦепочки = ЗНАЧЕНИЕ(Перечисление.торо_ВидыДокументовНачалаЦепочкиРемонтов.ВнешнееОснованиеДляРабот)
	|					ТОГДА &ПоказыватьВнешниеОснования = ИСТИНА
	|				КОГДА торо_ОбщиеДанныеПоРемонтам.ВидДокументаНачалаЦепочки = ЗНАЧЕНИЕ(Перечисление.торо_ВидыДокументовНачалаЦепочкиРемонтов.ПланГрафикППР)
	|					ТОГДА &ПоказыватьППР = ИСТИНА
	|				ИНАЧЕ ЛОЖЬ
	|			КОНЕЦ)
	|ГДЕ
	|	ВТ_Ремонты.IDРемонта ЕСТЬ NULL
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	торо_ОбщиеДанныеПоРемонтам.IDРемонта,
	|	торо_ОбщиеДанныеПоРемонтам.ОбъектРемонта,
	|	торо_ОбщиеДанныеПоРемонтам.ВидРемонта,
	|	торо_ОбщиеДанныеПоРемонтам.Завершен,
	|	торо_АктуальныеПлановыеДатыРемонтов.ДатаНачала,
	|	торо_АктуальныеПлановыеДатыРемонтов.ДатаОкончания,
	|	торо_ОбщиеДанныеПоРемонтам.ДокументНачалаЦепочки,
	|	NULL,
	|	торо_АктОВыполненииЭтапаРаботМероприятия.ДатаНачала,
	|	торо_АктОВыполненииЭтапаРаботМероприятия.ДатаОкончания,
	|	торо_АктОВыполненииРегламентногоМероприятияПодрядчикиРемонтныхРабот.Ссылка,
	|	торо_АктОВыполненииРегламентногоМероприятияПодрядчикиРемонтныхРабот.Контрагент
	|ИЗ
	|	РегистрСведений.торо_ОбщиеДанныеПоРемонтам КАК торо_ОбщиеДанныеПоРемонтам
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_Ремонты КАК ВТ_Ремонты
	|		ПО торо_ОбщиеДанныеПоРемонтам.IDРемонта = ВТ_Ремонты.IDРемонта
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_АктОВыполненииРегламентногоМероприятия.ПодрядчикиРемонтныхРабот КАК торо_АктОВыполненииРегламентногоМероприятияПодрядчикиРемонтныхРабот
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.торо_ВыполненныеМероприятияОбъектов КАК торо_ВыполненныеМероприятияОбъектов
	|			ПО торо_АктОВыполненииРегламентногоМероприятияПодрядчикиРемонтныхРабот.РемонтыОборудования_ID = торо_ВыполненныеМероприятияОбъектов.ID
	|				И торо_АктОВыполненииРегламентногоМероприятияПодрядчикиРемонтныхРабот.Ссылка = торо_ВыполненныеМероприятияОбъектов.Регистратор
	|		ПО торо_ОбщиеДанныеПоРемонтам.IDРемонта = торо_АктОВыполненииРегламентногоМероприятияПодрядчикиРемонтныхРабот.РемонтыОборудования_ID
	|			И (&ПоказыватьРМ)
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.торо_АктуальныеПлановыеДатыРемонтов КАК торо_АктуальныеПлановыеДатыРемонтов
	|		ПО торо_ОбщиеДанныеПоРемонтам.IDРемонта = торо_АктуальныеПлановыеДатыРемонтов.IDРемонта
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_АктОВыполненииРегламентногоМероприятия.Мероприятия КАК торо_АктОВыполненииЭтапаРаботМероприятия
	|		ПО торо_ОбщиеДанныеПоРемонтам.IDРемонта = торо_АктОВыполненииЭтапаРаботМероприятия.ID
	|ГДЕ
	|	ВТ_Ремонты.IDРемонта ЕСТЬ NULL
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	IDРемонта,
	|	Исполнитель
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ЕСТЬNULL(ВТ_План.IDРемонта, ВТ_Факт.IDРемонта) КАК ID,
	|	ЕСТЬNULL(ВТ_План.ДатаНачалаРемонтныхРабот, ВТ_Факт.ДатаНачалаРемонтныхРабот) КАК ДатаНачалаРемонтныхРабот,
	|	ЕСТЬNULL(ВТ_План.ДатаОкончанияРемонтныхРабот, ВТ_Факт.ДатаОкончанияРемонтныхРабот) КАК ДатаОкончанияРемонтныхРабот,
	|	ВТ_Факт.ДатаНачалаФакт КАК ДатаНачалаФакт,
	|	ВТ_Факт.ДатаОкончанияФакт КАК ДатаОкончанияФакт,
	|	ЕСТЬNULL(ВТ_План.ОбъектРемонта, ВТ_Факт.ОбъектРемонта) КАК ОбъектРемонтныхРабот,
	|	ЕСТЬNULL(ВТ_План.ВидРемонта, ВТ_Факт.ВидРемонта) КАК ВидРемонтныхРабот,
	|	ЕСТЬNULL(ВТ_Факт.Исполнитель, ВТ_План.Исполнитель) КАК Исполнитель,
	|	ЕСТЬNULL(ВТ_План.ДокументНачалаЦепочки, ВТ_Факт.ДокументНачалаЦепочки) КАК ДокументНачалаЦепочки,
	|	ВТ_Факт.Акт КАК Акт,
	|	ВЫБОР
	|		КОГДА ВТ_План.IDРемонта ЕСТЬ NULL
	|			ТОГДА ""Привлечение данного подрядчика не планировалась""
	|		КОГДА ВТ_Факт.IDРемонта ЕСТЬ NULL
	|				И НЕ ВТ_План.Исполнитель В (ЗНАЧЕНИЕ(Справочник.Контрагенты.ПустаяСсылка), НЕОПРЕДЕЛЕНО)
	|			ТОГДА ""Подрядчик не выполнил работы""
	|		КОГДА ВТ_Факт.IDРемонта ЕСТЬ NULL
	|			ТОГДА ""Подрядчик не выбран""
	|		КОГДА НЕ ВТ_Факт.IDРемонта ЕСТЬ NULL
	|				И НЕ ВТ_План.IDРемонта ЕСТЬ NULL
	|				И ВТ_План.Исполнитель В (ЗНАЧЕНИЕ(Справочник.Контрагенты.ПустаяСсылка), НЕОПРЕДЕЛЕНО)
	|			ТОГДА ""Привлечение данного подрядчика не планировалась""
	|		ИНАЧЕ ""Плановое выполнение работ подрядчиком""
	|	КОНЕЦ КАК СтатусРаботыПодрядчика,
	|	ЕСТЬNULL(ВТ_План.СписокОбъектов, ВТ_Факт.СписокОбъектов) КАК СписокОбъектов,
	|	ЕСТЬNULL(ВТ_План.РемонтЗавершен, ВТ_Факт.РемонтЗавершен) КАК РемонтЗавершен
	|ПОМЕСТИТЬ Данные
	|ИЗ
	|	ВТ_План КАК ВТ_План
	|		ПОЛНОЕ СОЕДИНЕНИЕ ВТ_Факт КАК ВТ_Факт
	|		ПО ВТ_План.IDРемонта = ВТ_Факт.IDРемонта
	|			И (ВТ_План.Исполнитель = ВТ_Факт.Исполнитель
	|				ИЛИ ВТ_План.Исполнитель В (ЗНАЧЕНИЕ(Справочник.Контрагенты.ПустаяСсылка), НЕОПРЕДЕЛЕНО))
	|{ГДЕ
	|	ВТ_Факт.ДатаНачалаФакт <= &КонецПериода
	|		ИЛИ ВТ_План.ДатаНачалаРемонтныхРабот <= &КонецПериода,
	|	ВТ_Факт.ДатаОкончанияФакт >= &НачалоПериода
	|		ИЛИ ВТ_План.ДатаОкончанияРемонтныхРабот >= &НачалоПериода}
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ОбъектРемонтныхРабот"
	
	+ "
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|";
	
	Возврат ЗапросТекст;
	
КонецФункции

#КонецОбласти

#КонецЕсли
