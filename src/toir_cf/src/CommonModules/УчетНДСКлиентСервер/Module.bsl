#Область СлужебныеПроцедурыИФункции

// Применяемые типы налогообложения НДС
// 
// Параметры:
// 	Продажи - Булево -
// 	Закупки - Булево -
// Возвращаемое значение:
// 	СписокЗначений из ПеречислениеСсылка.ТипыНалогообложенияНДС -
//
Функция ПрименяемыеТипыНалогообложенияНДС() Экспорт
	
	ТипыНалогообложения = Новый СписокЗначений();
	
	Представление = НСтр("ru = 'Облагается НДС';
						 |en = 'Subject to VAT'");
	ТипыНалогообложения.Добавить(ПредопределенноеЗначение("Перечисление.ТипыНалогообложенияНДС.ПродажаОблагаетсяНДС"), Представление);
	
	Представление = НСтр("ru = 'Не облагается НДС';
						 |en = 'VAT-exempt'");
	
	ТипыНалогообложения.Добавить(ПредопределенноеЗначение("Перечисление.ТипыНалогообложенияНДС.ПродажаНеОблагаетсяНДС"), Представление);
	
	ТипыНалогообложения.Добавить(ПредопределенноеЗначение("Перечисление.ТипыНалогообложенияНДС.ПродажаНаЭкспорт"), НСтр("ru = 'Экспорт';
																							|en = 'Export'"));
	
	ТипыНалогообложения.Добавить(ПредопределенноеЗначение("Перечисление.ТипыНалогообложенияНДС.НалоговыйАгентПоНДС"), НСтр("ru = 'Налоговый агент по НДС';
																							   |en = 'VAT tax agent'"));
	
	ТипыНалогообложения.Добавить(ПредопределенноеЗначение("Перечисление.ТипыНалогообложенияНДС.ОблагаетсяНДСУПокупателя"), НСтр("ru = 'Облагается НДС у покупателя';
																									|en = 'Subject to VAT at customer'"));
	Возврат ТипыНалогообложения;
	
КонецФункции

#КонецОбласти