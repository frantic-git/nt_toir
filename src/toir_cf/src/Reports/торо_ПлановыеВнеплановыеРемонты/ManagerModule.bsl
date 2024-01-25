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
	
	НастройкиОтчета.Размещение.Вставить(ВариантыОтчетовКлиентСервер.ИдентификаторНачальнойСтраницы());
	НастройкиОтчета.Размещение.Вставить(Метаданные.Подсистемы.торо_ПланированиеТОиР.Подсистемы.торо_ДолгосрочныеПланы, "Важный");
	НастройкиОтчета.Размещение.Вставить(Метаданные.Подсистемы.торо_ПланированиеТОиР.Подсистемы.торо_ОперативныеПланы, "Важный");
	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, НастройкиОтчета, Истина);

	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "ПлановыеВнеплановыеРемонты");
	ОписаниеВарианта.ВидимостьПоУмолчанию = Истина;
	ОписаниеВарианта.Наименование = НСтр("ru = 'Плановые и внеплановые ремонты'");
	ОписаниеВарианта.Описание = НСтр("ru = 'Статусы и даты фактического выполнения плановых и внеплановых ремонтов.'");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("торо_ИспользоватьППР");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("торо_ИспользоватьРегламентныеМероприятия");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("торо_ИспользоватьВнешниеОснованияДляРабот");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("торо_УчетВыявленныхДефектовОборудования");
	
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "ПлановыеРемонты");
	ОписаниеВарианта.ВидимостьПоУмолчанию = Истина;
	ОписаниеВарианта.Наименование = НСтр("ru = 'Плановые ремонты'");
	ОписаниеВарианта.Описание = НСтр("ru = 'Статусы и даты фактического выполнения плановых ремонтов.'");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("торо_ИспользоватьППР");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("торо_ИспользоватьРегламентныеМероприятия");
	ОписаниеВарианта.Размещение.Удалить(Метаданные.Подсистемы.торо_ПланированиеТОиР.Подсистемы.торо_ОперативныеПланы);
	
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "ВнеплановыеРемонты");
	ОписаниеВарианта.ВидимостьПоУмолчанию = Истина;
	ОписаниеВарианта.Наименование = НСтр("ru = 'Внеплановые ремонты'");
	ОписаниеВарианта.Описание = НСтр("ru = 'Статусы и даты фактичесого выполнения внеплановых ремонтов, а также время реакции и устранения дефектов.'");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("торо_ИспользоватьВнешниеОснованияДляРабот");
	ОписаниеВарианта.ФункциональныеОпции.Добавить("торо_УчетВыявленныхДефектовОборудования");
	ОписаниеВарианта.Размещение.Удалить(Метаданные.Подсистемы.торо_ПланированиеТОиР.Подсистемы.торо_ДолгосрочныеПланы);

	
КонецПроцедуры

#КонецОбласти

#КонецЕсли