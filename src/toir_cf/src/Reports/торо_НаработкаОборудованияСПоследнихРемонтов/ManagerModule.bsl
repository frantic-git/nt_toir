#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

// Настройки размещения в панели отчетов. (См. ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов).
//
// Параметры:
//   Настройки - Коллекция - Передается "как есть" из ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов().
//       Может использоваться для получения настроек варианта этого отчета при помощи функции ВариантыОтчетов.ОписаниеВарианта().
//   НастройкиОтчета - СтрокаДереваЗначений - Настройки этого отчета,
//       уже сформированные при помощи функции ВариантыОтчетов.ОписаниеОтчета() и готовые к изменению.
//       См. "Свойства для изменения" процедуры ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов().
//
Процедура НастроитьВариантыОтчета(Настройки, НастройкиОтчета) Экспорт
	
	НастройкиОтчета.ОпределитьНастройкиФормы = Истина;
	
	НастройкиОтчета.ФункциональныеОпции.Добавить("торо_УчетНаработкиОборудования");
	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, НастройкиОтчета, Истина);

	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "Основной");
	ОписаниеВарианта.ВидимостьПоУмолчанию = Истина;
	ОписаниеВарианта.Наименование = НСтр("ru = 'Наработка оборудования с последних ремонтов'");
	ОписаниеВарианта.Описание = НСтр("ru = 'Наработка оборудования на текущий момент времени с даты окончания последнего завершенного ремонта.'");

КонецПроцедуры

#КонецОбласти

#КонецЕсли