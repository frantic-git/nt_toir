///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Задает настройки, применяемые как стандартные для объектов подсистемы.
//
// Параметры:
//   Настройки - Структура - коллекция настроек подсистемы. Реквизиты:
//       * ВыводитьОтчетыВместоВариантов - Булево - умолчание для вывода гиперссылок в панели отчетов:
//           Истина - варианты отчетов по умолчанию скрыты, а отчеты включены и видимы.
//           Ложь   - варианты отчетов по умолчанию видимы, а отчеты отключены.
//           Значение по умолчанию: Ложь.
//       * ВыводитьОписания - Булево - умолчание для вывода описаний в панели отчетов:
//           Истина - значение по умолчанию. Выводить описания в виде подписей под гиперссылками вариантов
//           Ложь   - выводить описания в виде всплывающих подсказок
//           Значение по умолчанию: Истина.
//       * Поиск - Структура - настройки поиска вариантов отчетов:
//           ** ПодсказкаВвода - Строка - текст подсказки выводится в поле поиска когда поиск не задан.
//               В качестве примера рекомендуется указывать часто используемые термины прикладной конфигурации.
//       * ДругиеОтчеты - Структура - настройки формы "Другие отчеты":
//           ** ЗакрыватьПослеВыбора - Булево - закрывать ли форму после выбора гиперссылки отчета.
//               Истина - закрывать "Другие отчеты" после выбора.
//               Ложь   - не закрывать.
//               Значение по умолчанию: Истина.
//           ** ПоказыватьФлажок - Булево - показывать ли флажок ЗакрыватьПослеВыбора.
//               Истина - показывать флажок "Закрывать это окно после перехода к другому отчету".
//               Ложь   - не показывать флажок.
//               Значение по умолчанию: Ложь.
//       * РазрешеноИзменятьВарианты - Булево - показывать расширенные настройки отчета
//               и команды изменения варианта отчета.
//
// Пример:
//	Настройки.Поиск.ПодсказкаВвода = НСтр("ru = 'Например, себестоимость'");
//	Настройки.ДругиеОтчеты.ЗакрыватьПослеВыбора = Ложь;
//	Настройки.ДругиеОтчеты.ПоказыватьФлажок = Истина;
//	Настройки.РазрешеноИзменятьВарианты = Ложь;
//
Процедура ПриОпределенииНастроек(Настройки) Экспорт

	
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Настройки размещения отчетов

// Определяет разделы командного интерфейса, в которых предусмотрены панели отчетов.
// В Разделы необходимо добавить метаданные тех подсистем первого уровня,
// в которых размещены команды вызова панелей отчетов.
//
// Параметры:
//  Разделы - СписокЗначений - разделы, в которые выведены команды открытия панели отчетов:
//      * Значение - ОбъектМетаданныхПодсистема
//                 - Строка - подсистема раздела глобального командного интерфейса,
//                   либо ВариантыОтчетовКлиентСервер.ИдентификаторНачальнойСтраницы для начальной страницы.
//      * Представление - Строка - заголовок панели отчетов в этом разделе.
//
// Пример:
//	Разделы.Добавить(Метаданные.Подсистемы.Анкетирование, НСтр("ru = 'Отчеты по анкетированию'"));
//	Разделы.Добавить(ВариантыОтчетовКлиентСервер.ИдентификаторНачальнойСтраницы(), НСтр("ru = 'Основные отчеты'"));
//
Процедура ОпределитьРазделыСВариантамиОтчетов(Разделы) Экспорт
	
	// В подсистему "торо_НастройкаИАдминистрирование" добавляется в модуле менеджера 
	// обработки ПанельАдминистрированияБСП, в процедуре ПриОпределенииРазделовСВариантамиОтчетов. 
	// Здесь дублировать не нужно.

	Разделы.Добавить(Метаданные.Подсистемы.торо_ПоказателиЭксплуатации, НСтр("ru='Отчеты по показателям эксплуатации'"));
	Разделы.Добавить(Метаданные.Подсистемы.торо_ОборудованиеИНормативы, НСтр("ru='Отчеты по оборудованию и нормативам'"));
	Разделы.Добавить(Метаданные.Подсистемы.торо_МТО, НСтр("ru='Отчеты по МТО'"));
	Разделы.Добавить(Метаданные.Подсистемы.торо_ПланированиеТОиР, НСтр("ru='Отчеты по планированию ТОиР'"));
	Разделы.Добавить(Метаданные.Подсистемы.торо_НарядыИРаботы, НСтр("ru='Отчеты по нарядам и работам'"));
	Разделы.Добавить(Метаданные.Подсистемы.торо_УправлениеПерсоналом, НСтр("ru='Отчеты по управлению персоналом'"));
	Разделы.Добавить(Метаданные.Подсистемы.торо_НормативноСправочнаяИнформация, НСтр("ru='Отчеты по НСИ'"));
	Разделы.Добавить(Метаданные.Подсистемы.торо_ПоказателиKPI, НСтр("ru='Отчеты по мониторингу показателей KPI'"));
	Разделы.Добавить(ВариантыОтчетовКлиентСервер.ИдентификаторНачальнойСтраницы(), НСтр("ru='Основные отчеты'"));
	
КонецПроцедуры

// Задает расширенные настройки отчетов конфигурации, такие как:
// - описание отчета;
// - поля поиска: наименования полей, параметров и отборов (для отчетов не на базе СКД);
// - размещение в разделах командного интерфейса
//   (начальная настройка размещения отчетов по подсистемам автоматически определяется из метаданных,
//    ее дублирование не требуется);
// - признак Включен (для контекстных отчетов);
// - режима вывода в панелях отчетов (с группировкой по отчету или без);
// - и другие.
// 
// В процедуре задаются только настройки отчетов (и вариантов отчетов) конфигурации.
// Для настройки отчетов из расширений конфигурации следует включать их в подсистему ПодключаемыеОтчетыИОбработки.
//
// Для задания настроек следует использовать следующие вспомогательные процедуры и функции:
//   ВариантыОтчетов.ОписаниеОтчета, 
//   ВариантыОтчетов.ОписаниеВарианта, 
//   ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов, 
//   ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера.
//
// Изменяя настройки отчета, можно изменить настройки всех его вариантов.
// Однако, если явно получить настройки варианта отчета, то они станут самостоятельными,
// т.е. более не будут наследовать изменения настроек от отчета.
//   
// Функциональные опции предопределенного варианта отчета объединяются с функциональными опциями этого отчета по правилам:
// (ФО1_Отчета ИЛИ ФО2_Отчета) И (ФО3_Варианта ИЛИ ФО4_Варианта).
// При этом для пользовательских вариантов отчета действуют только функциональные опции отчета
// - они отключаются только с отключением всего отчета.
//
// Параметры:
//   Настройки - ТаблицаЗначений - коллекция предопределенных вариантов отчетов, где:
//       * Отчет - СправочникСсылка.ИдентификаторыОбъектовРасширений
//               - СправочникСсылка.ДополнительныеОтчетыИОбработки
//               - СправочникСсылка.ИдентификаторыОбъектовМетаданных
//               - Строка - полное имя или ссылка на идентификатор отчета.
//       * Метаданные - ОбъектМетаданныхОтчет - метаданные отчета.
//       * ИспользуетСКД - Булево - признак использования в отчете основной СКД.
//       * КлючВарианта - Строка - идентификатор варианта отчета.
//       * ОписаниеПолучено - Булево - признак того, что описание строки уже получено.
//       * Включен - Булево - если Ложь, то вариант отчета не регистрируется в подсистеме
//       * ВидимостьПоУмолчанию - Булево - если Ложь, то вариант отчета по умолчанию скрыт в панели отчетов.
//       * Наименование - Строка - наименование варианта отчета.
//       * Описание - Строка - пояснение назначения отчета.
//       * Размещение - Соответствие из КлючИЗначение - настройки размещения варианта отчета в разделах (подсистемах), где:
//             ** Ключ - ОбъектМетаданных - подсистема, в которой размещается отчет или вариант отчета.
//             ** Значение - Строка - настройки размещения в подсистеме (группе) - "", "Важный", "СмТакже".
//       * НастройкиДляПоиска - Структура - дополнительные настройки для поиска этого варианта отчета, где:
//             ** НаименованияПолей - Строка - имена полей варианта отчета.
//             ** НаименованияПараметровИОтборов - Строка - имена настроек варианта отчета.
//             ** КлючевыеСлова - Строка - дополнительная терминология (в т.ч. специализированная или устаревшая).
//             ** ИменаМакетов - Строка - используется вместо НаименованияПолей.
//       * СистемнаяИнформация - Структура - другая служебная информация.
//       * Тип - Строка - перечень идентификаторов типов.
//       * ЭтоВариант - Булево - признак того, что описание отчета относится к варианту отчета.
//       * ФункциональныеОпции - Массив из Строка - коллекция идентификаторов функциональных опций, где:
//       * ГруппироватьПоОтчету - Булево - признак необходимости группировки вариантов по отчету-основанию.
//       * КлючЗамеров - Строка - идентификатор замера производительности отчета.
//       * ОсновнойВариант - Строка - идентификатор основного варианта отчета.
//       * ФорматНастроекСКД - Булево - признак хранения настроек в формате СКД.
//       * ОпределитьНастройкиФормы - Булево - отчет имеет программный интерфейс для тесной интеграции с формой отчета,
//           в том числе может переопределять некоторые настройки формы и подписываться на ее события.
//           Если Истина и отчет подключен к общей форме ФормаОтчета,
//           тогда в модуле объекта отчета следует определить процедуру по шаблону:
//               
//               // Задать настройки формы отчета.
//               //
//               // Параметры:
//               //   Форма - ФормаКлиентскогоПриложения, Неопределено - 
//               //   КлючВарианта - Строка, Неопределено - 
//               //   Настройки - см. значение ОтчетыКлиентСервер.НастройкиОтчетаПоУмолчанию
//               //
//               Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
//               	// Код процедуры.
//               КонецПроцедуры
//
// Пример:
//
//  // Добавление варианта отчета в подсистему.
//	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, Метаданные.Отчеты.ИмяОтчета, "<ИмяВарианта>");
//	НастройкиВарианта.Размещение.Вставить(Метаданные.Подсистемы.ИмяРаздела.Подсистемы.ИмяПодсистемы);
//
//  // Отключение варианта отчета.
//	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, Метаданные.Отчеты.ИмяОтчета, "<ИмяВарианта>");
//	НастройкиВарианта.Включен = Ложь;
//
//  // Отключение всех вариантов отчета, кроме одного.
//	НастройкиОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ИмяОтчета);
//	НастройкиОтчета.Включен = Ложь;
//	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "<ИмяВарианта>");
//	НастройкиВарианта.Включен = Истина;
//
//  // Заполнение настроек для поиска - наименования полей, параметров и отборов:
//	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, Метаданные.Отчеты.ИмяОтчетаБезСхемы, "");
//	НастройкиВарианта.НастройкиДляПоиска.НаименованияПолей =
//		НСтр("ru = 'Контрагент
//		|Договор
//		|Ответственный
//		|Скидка
//		|Дата'");
//	НастройкиВарианта.НастройкиДляПоиска.НаименованияПараметровИОтборов =
//		НСтр("ru = 'Период
//		|Ответственный
//		|Контрагент
//		|Договор'");
//
//  // Переключение режима вывода в панелях отчетов:
//  // Группировка вариантов отчета по этому отчету:
//	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, Метаданные.Отчеты.ИмяОтчета, Истина);
//  // Без группировки по отчету:
//	Отчет = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ИмяОтчета);
//	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, Отчет, Ложь);
//
Процедура НастроитьВариантыОтчетов(Настройки) Экспорт
	
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ПланМТОТрудозатратИнструментов);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ОстановочныеРемонты);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_СписокОборудования);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ПланФактЗатрат);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ПланФактТрудозатрат);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_СостояниеОборудования);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ПрямыеЗатратыНаВыполнениеРемонтов);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ПлановыеВнеплановыеРемонты);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ПланФактныйАнализППР);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_НаработкаОборудованияСПоследнихРемонтов);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_НаработкаНаОтказ);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ФактическиеЗатратыПоОбъектамРемонта);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ИсторияИзмененияДатРемонта);
	
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ВнешниеОснования);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ВыявленныеДефекты);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_РецидивныеДефекты);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ЗапланированныеРемонтыОбъектовРемонта);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ИсторияОстановаЗапускаОборудования);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_НаработкаОборудования);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_НаработкаОРПоДатам);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ОтказыОборудования);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ОтчетПоКонтролируемымПоказателям);

	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ОтчетПоОперациям);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ПлановыеОстановыОборудования);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ПланФактВыполненияРемонтовПодрядчиками);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ПринятиеКУчетуВыбытиеОборудования);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ПричиныОтменыПлановыхРемонтов);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ПростойОборудования);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ЖурналСостоянийОборудования);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_КТГОборудования);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ТекущееСостояниеОборудования);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_СтатусыРемонтовПоЗаявкам);
	
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_АнализДефектовИПотерь);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_АнализЧастотыКоренныхПричинДефектов);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ЖурналКорректирующихМероприятий);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ЖурналПроведенныхАнализовКоренныхПричин);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_СводнаяДиаграммаГрафиковППР);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_АнализИспользованияПерсонала);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ПланФактТрудозатрат);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_БазаДанныхПоПодрядчикамСИсторией);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_АнализЗагруженностиБригад);
	
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.ВедомостьПоТоварамНаСкладах);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ВедомостьПоТоварамНаРуках);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ЗатратыНоменклатуры);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_МинимальныеОстатки);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ОстаткиНоменклатурыНаРуках);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ОстаткиНоменклатурыНаСкладах);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_СостояниеОбеспеченияЗаказов);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_СтатистикаПотребленияНоменклатурыПоМесяцам);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_СтатистикаПотребленияНоменклатурыПоГодам);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ОбеспеченностьПлановойПотребностиВТМЦ);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ПланЗакупок);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ГрафикРаботыСотрудника);
	
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.торо_ДлительностьСогласованияДокументов);
	
	// Перенос универсального отчета в область "см. также"
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.УниверсальныйОтчет);
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "Основной");
	ОписаниеВарианта.Размещение.Вставить(Метаданные.Подсистемы.торо_ПоказателиЭксплуатации, "СмТакже");
	ОписаниеВарианта.Размещение.Вставить(Метаданные.Подсистемы.торо_ОборудованиеИНормативы, "СмТакже");
	ОписаниеВарианта.Размещение.Вставить(Метаданные.Подсистемы.торо_МТО, "СмТакже");
	ОписаниеВарианта.Размещение.Вставить(Метаданные.Подсистемы.торо_ПланированиеТОиР, "СмТакже");
	ОписаниеВарианта.Размещение.Вставить(Метаданные.Подсистемы.торо_НарядыИРаботы, "СмТакже");
	ОписаниеВарианта.Размещение.Вставить(Метаданные.Подсистемы.торо_УправлениеПерсоналом, "СмТакже");
	ОписаниеВарианта.Размещение.Вставить(Метаданные.Подсистемы.торо_НормативноСправочнаяИнформация, "СмТакже");

	// Отображение отчетов по задачам в разделе "Главное" на панели "Основные отчеты"
	// Зависшие задачи
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ЗависшиеЗадачи);
	ОписаниеОтчета.ВидимостьПоУмолчанию = Истина;
	ОписаниеОтчета.Размещение.Вставить(ВариантыОтчетовКлиентСервер.ИдентификаторНачальнойСтраницы());
	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, ОписаниеОтчета, Истина);
	
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "СводкаПоЗависшимЗадачам");
	ОписаниеВарианта.ВидимостьПоУмолчанию = Истина;
	ОписаниеВарианта.Размещение.Вставить(ВариантыОтчетовКлиентСервер.ИдентификаторНачальнойСтраницы());
	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, ОписаниеВарианта, Истина);
	
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "ЗависшиеЗадачиПоИсполнителям");
	ОписаниеВарианта.ВидимостьПоУмолчанию = Истина;
	ОписаниеВарианта.Размещение.Вставить(ВариантыОтчетовКлиентСервер.ИдентификаторНачальнойСтраницы());
	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, ОписаниеВарианта, Истина);
	
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "ЗависшиеЗадачиПоОбъектамАдресации");
	ОписаниеВарианта.ВидимостьПоУмолчанию = Истина;
	ОписаниеВарианта.Размещение.Вставить(ВариантыОтчетовКлиентСервер.ИдентификаторНачальнойСтраницы());
	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, ОписаниеВарианта, Истина);
	
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "ПросроченныеЗадачи");
	ОписаниеВарианта.ВидимостьПоУмолчанию = Истина;
	ОписаниеВарианта.Размещение.Вставить(ВариантыОтчетовКлиентСервер.ИдентификаторНачальнойСтраницы());
	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, ОписаниеВарианта, Истина);
	
	// Задачи
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.Задачи);
	ОписаниеОтчета.ВидимостьПоУмолчанию = Истина;
	ОписаниеОтчета.Размещение.Вставить(ВариантыОтчетовКлиентСервер.ИдентификаторНачальнойСтраницы());
	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, ОписаниеОтчета, Истина);
	
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "ТекущиеЗадачи");
	ОписаниеВарианта.ВидимостьПоУмолчанию = Истина;
	ОписаниеВарианта.Размещение.Вставить(ВариантыОтчетовКлиентСервер.ИдентификаторНачальнойСтраницы());
	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, ОписаниеВарианта, Истина);
	
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "СправкаПоИсполнительскойДисциплине");
	ОписаниеВарианта.ВидимостьПоУмолчанию = Истина;
	ОписаниеВарианта.Размещение.Вставить(ВариантыОтчетовКлиентСервер.ИдентификаторНачальнойСтраницы());
	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, ОписаниеВарианта, Истина);
	
	// Задачи, истекающие на дату
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ЗадачиИстекающиеНаДату);
	ОписаниеОтчета.ВидимостьПоУмолчанию = Истина;
	ОписаниеОтчета.Размещение.Вставить(ВариантыОтчетовКлиентСервер.ИдентификаторНачальнойСтраницы());
	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, ОписаниеОтчета, Истина);
	
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "ЗадачиИстекающиеНаДату");
	ОписаниеВарианта.ВидимостьПоУмолчанию = Истина;
	ОписаниеВарианта.Размещение.Вставить(ВариантыОтчетовКлиентСервер.ИдентификаторНачальнойСтраницы());
	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, ОписаниеОтчета, Истина);
	
	// Просроченные задачи
	ОписаниеОтчета = ВариантыОтчетов.ОписаниеОтчета(Настройки, Метаданные.Отчеты.ПросроченныеЗадачи);
	ОписаниеОтчета.ВидимостьПоУмолчанию = Истина;
	ОписаниеОтчета.Размещение.Вставить(ВариантыОтчетовКлиентСервер.ИдентификаторНачальнойСтраницы());
	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, ОписаниеОтчета, Истина);
	
	ОписаниеВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, ОписаниеОтчета, "ЗадачиВыполненныеСНарушениемСроков");
	ОписаниеВарианта.ВидимостьПоУмолчанию = Истина;
	ОписаниеВарианта.Размещение.Вставить(ВариантыОтчетовКлиентСервер.ИдентификаторНачальнойСтраницы());
	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, ОписаниеОтчета, Истина);

	
КонецПроцедуры

// Регистрирует изменения в именах вариантов отчетов.
// Используется при обновлении в целях сохранения ссылочной целостности,
// в частности для сохранения пользовательских настроек и настроек рассылок отчетов.
// Старое имя варианта резервируется и не может быть использовано в дальнейшем.
// Если изменений было несколько, то каждое изменение необходимо зарегистрировать,
// указывая в актуальном имени варианта последнее (текущее) имя варианта отчета.
// Поскольку имена вариантов отчетов не выводятся в пользовательском интерфейсе,
// то рекомендуется задавать их таким образом, что бы затем не менять.
// В Изменения необходимо добавить описания изменений имен вариантов
// отчетов, подключенных к подсистеме.
//
// Параметры:
//   Изменения - ТаблицаЗначений - таблица изменений имен вариантов. Колонки:
//       * Отчет - ОбъектМетаданных - метаданные отчета, в схеме которого изменилось имя варианта.
//       * СтароеИмяВарианта - Строка - старое имя варианта, до изменения.
//       * АктуальноеИмяВарианта - Строка - текущее (последнее актуальное) имя варианта.
//
// Пример:
//	Изменение = Изменения.Добавить();
//	Изменение.Отчет = Метаданные.Отчеты.<ИмяОтчета>;
//	Изменение.СтароеИмяВарианта = "<СтароеИмяВарианта>";
//	Изменение.АктуальноеИмяВарианта = "<АктуальноеИмяВарианта>";
//
Процедура ЗарегистрироватьИзмененияКлючейВариантовОтчетов(Изменения) Экспорт
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Настройки команд отчетов

// Определяет объекты конфигурации, в модулях менеджеров которых предусмотрена процедура ДобавитьКомандыОтчетов,
// описывающая команды открытия контекстных отчетов.
// Синтаксис процедуры ДобавитьКомандыОтчетов см. в документации.
//
// Параметры:
//  Объекты - Массив - объекты метаданных (ОбъектМетаданных) с командами отчетов.
//
Процедура ОпределитьОбъектыСКомандамиОтчетов(Объекты) Экспорт
	
	Объекты.Добавить(Метаданные.Справочники.торо_ОбъектыРемонта);
	Объекты.Добавить(Метаданные.Справочники.торо_РемонтныеБригады);
	Объекты.Добавить(Метаданные.Справочники.Номенклатура);
	Объекты.Добавить(Метаданные.Справочники.Склады);
	Объекты.Добавить(Метаданные.Справочники.Сотрудники);
	Объекты.Добавить(Метаданные.Справочники.Контрагенты);
	Объекты.Добавить(Метаданные.Справочники.СхемыОбеспечения);
	
	Объекты.Добавить(Метаданные.Документы.торо_ВыявленныеДефекты);
	Объекты.Добавить(Метаданные.Документы.торо_ЗаявкаНаРемонт);
	Объекты.Добавить(Метаданные.Документы.торо_ПланГрафикРемонта);
	Объекты.Добавить(Метаданные.Документы.торо_ОстановочныеРемонты);
	Объекты.Добавить(Метаданные.Документы.ЗаказНаВнутреннееПотребление);
		
КонецПроцедуры

// Определение списка глобальных команд отчетов.
// Событие возникает в процессе вызова модуля повторного использования.
//
// Параметры:
//  КомандыОтчетов - ТаблицаЗначений - таблица команд для вывода в подменю, где:
//   * Идентификатор - Строка   - идентификатор команды.
//   * Представление - Строка   - представление команды в форме.
//   * Важность      - Строка   - суффикс группы в подменю, в которой следует вывести эту команду.
//                                Допустимо использовать: "Важное", "Обычное" и "СмТакже".
//   * Порядок       - Число    - порядок размещения команды в группе. Используется для настройки под конкретное
//                                рабочее место.
//   * Картинка      - Картинка - картинка команды.
//   * СочетаниеКлавиш - СочетаниеКлавиш - сочетание клавиш для быстрого вызова команды.
//   * ТипПараметра - ОписаниеТипов - типы объектов, для которых предназначена эта команда.
//   * ВидимостьВФормах    - Строка - имена форм через запятую, в которых должна отображаться команда.
//                                    Используется когда состав команд отличается для различных форм.
//   * ФункциональныеОпции - Строка - имена функциональных опций через запятую, определяющих видимость команды.
//   * УсловияВидимости    - Массив - определяет видимость команды в зависимости от контекста.
//                                    Для регистрации условий следует использовать процедуру
//                                    ПодключаемыеКоманды.ДобавитьУсловиеВидимостиКоманды().
//                                    Условия объединяются по "И".
//   * ИзменяетВыбранныеОбъекты - Булево - определяет доступность команды в ситуации,
//                                         когда у пользователя нет прав на изменение объекта.
//                                         Если Истина, то в описанной выше ситуации кнопка будет недоступна.
//                                         Необязательный. Значение по умолчанию: Ложь.
//   * МножественныйВыбор - Булево
//                        - Неопределено - если Истина, то команда поддерживает множественный выбор.
//                                         В этом случае в параметре выполнения будет передан список ссылок.
//                                         Необязательный. Значение по умолчанию: Истина.
//   * РежимЗаписи - Строка - действия, связанные с записью объекта, которые выполняются перед обработчиком команды, где:
//                 "НеЗаписывать" - объект не записывается, а в параметрах обработчика вместо ссылок передается
//                                  вся форма. В этом режиме рекомендуется работать напрямую с формой,
//                                  которая передается в структуре 2 параметра обработчика команды.
//                 "ЗаписыватьТолькоНовые" - записывать новые объекты.
//                 "Записывать"            - записывать новые и модифицированные объекты.
//                 "Проводить"             - проводить документы.
//                 Перед записью и проведением у пользователя запрашивается подтверждение.
//                 Необязательный. Значение по умолчанию: "Записывать".
//   * ТребуетсяРаботаСФайлами - Булево - если Истина, то в веб-клиенте предлагается
//                                        установить расширение для работы с 1С:Предприятием.
//                                        Необязательный. Значение по умолчанию: Ложь.
//   * Менеджер - Строка - полное имя объекта метаданных, отвечающего за выполнение команды.
//                         Например, "Отчет._ДемоКнигаПокупок".
//   * ИмяФормы - Строка - имя формы, которую требуется открыть или получить для выполнения команды.
//                         Если Обработчик не указан, то у формы вызывается метод "Открыть".
//   * КлючВарианта - Строка - имя варианта отчета, открываемого при выполнении команды.
//   * ИмяПараметраФормы - Строка - имя параметра формы, в который следует передать ссылку или массив ссылок.
//   * ПараметрыФормы - Неопределено
//                    - Структура - параметры формы, указанной в ИмяФормы.
//   * Обработчик - Строка - описание процедуры, обрабатывающей основное действие команды.
//                  Формат "<ИмяОбщегоМодуля>.<ИмяПроцедуры>" используется когда процедура размещена в общем модуле.
//                  Формат "<ИмяПроцедуры>" используется в следующих случаях:
//                  1) если ИмяФормы заполнено то в модуле указанной формы ожидается клиентская процедура,
//                  2) если ИмяФормы не заполнено то в модуле менеджера этого объекта ожидается серверная процедура.
//   * ДополнительныеПараметры - Структура - параметры обработчика, указанного в Обработчик.
//
//  Параметры - Структура - сведения о контексте исполнения, где:
//   * ИмяФормы - Строка - полное имя формы.
//   
//  СтандартнаяОбработка - Булево - если установить в Ложь, то событие "ДобавитьКомандыОтчетов" менеджера объекта не
//                                  будет вызвано.
//
Процедура ПередДобавлениемКомандОтчетов(КомандыОтчетов, Параметры, СтандартнаяОбработка) Экспорт
	
	Если ПравоДоступа("Просмотр", Метаданные.Отчеты.торо_ИсторияИзмененияДатРемонта) Тогда
		ТипыДокументовСРемонтами = Новый Массив;
		ТипыДокументовСРемонтами.Добавить(Тип("ДокументСсылка.торо_ВыявленныеДефекты"));
		ТипыДокументовСРемонтами.Добавить(Тип("ДокументСсылка.торо_ВнешнееОснованиеДляРабот"));
		ТипыДокументовСРемонтами.Добавить(Тип("ДокументСсылка.торо_ПланГрафикРемонта"));
		ТипыДокументовСРемонтами.Добавить(Тип("ДокументСсылка.торо_ЗаявкаНаРемонт"));
		ТипыДокументовСРемонтами.Добавить(Тип("ДокументСсылка.торо_НарядНаВыполнениеРемонтныхРабот"));
		ТипыДокументовСРемонтами.Добавить(Тип("ДокументСсылка.торо_АктОВыполненииЭтапаРабот"));
		ТипыДокументовСРемонтами.Добавить(Тип("ДокументСсылка.торо_ОстановочныеРемонты"));
		ТипыДокументовСРемонтами.Добавить(Тип("ДокументСсылка.торо_ЗакрытиеЗаявокИРемонтов"));
		ТипыДокументовСРемонтами.Добавить(Тип("ДокументСсылка.торо_ПланРаботПодразделения"));
		ТипыДокументовСРемонтами.Добавить(Тип("ДокументСсылка.торо_ГрафикРегламентныхМероприятийТОиР"));
		ТипыДокументовСРемонтами.Добавить(Тип("ДокументСсылка.торо_НарядНаРегламентноеМероприятие"));
		ТипыДокументовСРемонтами.Добавить(Тип("ДокументСсылка.торо_АктОВыполненииРегламентногоМероприятия"));
		
		Команда = КомандыОтчетов.Добавить();
		Команда.Представление      = НСтр("ru = 'История изменения дат ремонтов'");
		Команда.Идентификатор 		= "Отчет_ИсторияИзмененияДатРемонта_ГлобальнаяКоманда";
		Команда.МножественныйВыбор = Ложь;
		Команда.КлючВарианта       = "Основной";
		Команда.Обработчик         = "торо_ОтчетыКлиент.ОткрытьКонтекстныйОтчет_ИсторияИзмененияДатРемонта";
		Команда.ТипПараметра = Новый ОписаниеТипов(ТипыДокументовСРемонтами);
	КонецЕсли;

КонецПроцедуры

#КонецОбласти
