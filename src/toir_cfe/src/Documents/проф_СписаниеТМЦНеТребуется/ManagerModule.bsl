#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

#Область Проведение

//++ Проф-ИТ, #329, Соловьев А.А., 07.11.2023

Процедура ИнициализироватьДанныеДокумента(ДокументСсылка, ДополнительныеСвойства, Регистры = Неопределено) Экспорт
	
	Запрос = Новый Запрос;
	ЗаполнитьПараметрыИнициализации(Запрос, ДокументСсылка);
	
	ТекстыЗапроса = Новый СписокЗначений;
	ТекстЗапроса(Запрос, ТекстыЗапроса, Регистры);
	
	ПроведениеСервер.ИницализироватьТаблицыДляДвижений(Запрос, ТекстыЗапроса, ДополнительныеСвойства.ТаблицыДляДвижений);
	
КонецПроцедуры

Процедура ЗаполнитьПараметрыИнициализации(Запрос, ДокументСсылка)
	
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);
	
КонецПроцедуры

Функция ТекстЗапроса(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "проф_ОстатокТМЦКСписаниюПоЗакрытымАктамНаРемонт";
	
	Если НЕ ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) КАК ВидДвижения,
	|	проф_СписаниеТМЦНеТребуется.АктОВыполненииЭтапаРабот КАК АктОВыполненииЭтапаРабот,
	|	проф_СписаниеТМЦНеТребуется.Дата КАК Период,
	|	проф_СписаниеТМЦНеТребуетсяТовары.Номенклатура КАК Номенклатура,
	|	проф_СписаниеТМЦНеТребуетсяТовары.Характеристика КАК Характеристика,
	|	проф_СписаниеТМЦНеТребуетсяТовары.Количество КАК Количество
	|ИЗ
	|	Документ.проф_СписаниеТМЦНеТребуется.Товары КАК проф_СписаниеТМЦНеТребуетсяТовары
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.проф_СписаниеТМЦНеТребуется КАК проф_СписаниеТМЦНеТребуется
	|		ПО проф_СписаниеТМЦНеТребуетсяТовары.Ссылка = проф_СписаниеТМЦНеТребуется.Ссылка
	|ГДЕ
	|	проф_СписаниеТМЦНеТребуется.Ссылка = &Ссылка";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции

Функция ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры)

	Если ЗначениеЗаполнено(Регистры) Тогда
		
		Если ТипЗнч(Регистры) = Тип("Строка") Тогда
			МассивРегистров = Новый Структура(Регистры);
		Иначе
			МассивРегистров = Регистры;
		КонецЕсли;
		
		Если НЕ МассивРегистров.Свойство(ИмяРегистра) Тогда
			Возврат Ложь;
		КонецЕсли; 
		
	КонецЕсли; 
	
	Возврат Истина;

КонецФункции

//-- Проф-ИТ, #329, Соловьев А.А., 07.11.2023

#КонецОбласти

#КонецОбласти

#КонецЕсли