#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.УправлениеДоступом
// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация, NULL КАК ИСТИНА, ПустаяСсылка КАК ИСТИНА)
	|	И ЗначениеРазрешено(Подразделение, NULL КАК ИСТИНА, ПустаяСсылка КАК ИСТИНА)";

	Ограничение.ТекстДляВнешнихПользователей = Ограничение.Текст;
	
КонецПроцедуры
// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецЕсли