#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

// Заполняет список команд печати.
//
// Параметры:
// КомандыПечати – ТаблицаЗначений – состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	
КонецПроцедуры

Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт
	
КонецПроцедуры

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	
	Ограничение.Текст =
	"РазрешитьЧтение
	|ГДЕ 
	|	ЗначениеРазрешено(Организация)
	|	И ЗначениеРазрешено(Подразделение)
	|;
	|РазрешитьИзменениеЕслиРазрешеноЧтение
	|ГДЕ
	|	ДляВсехСтрок(&Ограничение_ОР)";

	ОграничениеОР = торо_УправлениеДоступом.ПолучитьОграничениеДоступаДляОбъектаРемонтаВТаблице("ОбъектыРемонта.ОбъектРемонта", Истина);
	Ограничение.Текст = СтрЗаменить(Ограничение.Текст, "&Ограничение_ОР", ОграничениеОР);

	Ограничение.ТекстДляВнешнихПользователей = Ограничение.Текст;

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецЕсли