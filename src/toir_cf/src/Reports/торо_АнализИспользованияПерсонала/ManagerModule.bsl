
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
	
	НастройкиОтчета.Размещение.Вставить(Метаданные.Подсистемы.торо_УправлениеПерсоналом.Подсистемы.торо_Сотрудники, "Важный");
	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, НастройкиОтчета, Истина);

	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "АнализИспользованияПерсоналаПоОР");
	ОписаниеВарианта.ВидимостьПоУмолчанию = Истина;
	ОписаниеВарианта.Наименование = НСтр("ru = 'Анализ использования персонала: по объектам ремонта'");
	ОписаниеВарианта.Описание = НСтр("ru = 'Анализ использования персонала по ремонтным работам в разрезе конкретных сотрудников (группировка по объектам ремонта).'");
	
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "АнализИспользованияПерсоналаПоСотрудникам");
	ОписаниеВарианта.ВидимостьПоУмолчанию = Истина;
	ОписаниеВарианта.Наименование = НСтр("ru = 'Анализ использования персонала: по сотрудникам'");
	ОписаниеВарианта.Описание = НСтр("ru = 'Анализ использования персонала по ремонтным работам в разрезе конкретных сотрудников (группировка по сотрудникам).'");

	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "АнализИспользованияПерсоналаПоОрганизациям");
	ОписаниеВарианта.ВидимостьПоУмолчанию = Истина;
	ОписаниеВарианта.Наименование = НСтр("ru = 'Анализ использования персонала: по организациям'");
	ОписаниеВарианта.Описание = НСтр("ru = 'Анализ использования персонала по ремонтным работам в разрезе организаций и подразделений (группировка по организациям и подразделениям).'");
КонецПроцедуры

#КонецОбласти

#КонецЕсли