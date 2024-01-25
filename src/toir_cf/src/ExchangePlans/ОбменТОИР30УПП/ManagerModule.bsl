#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ОбработчикиСобытийСинхронизацииДанных

// Процедура - При получении настроек
//
// Параметры:
//  Настройки	 - Структура - ключ - имя настройки, значение – значение настройки
//
Процедура ПриПолученииНастроек(Настройки) Экспорт
	
	Настройки.ПредупреждатьОНесоответствииВерсийПравилОбмена = Ложь;
	Настройки.Алгоритмы.ПриПолученииДанныхОтправителя = Истина;
	Настройки.Алгоритмы.ПриПолученииОписанияВариантаНастройки = Истина;
	Настройки.Алгоритмы.НастроитьИнтерактивнуюВыгрузку = Истина;
	
	Настройки.ПланОбменаИспользуетсяВМоделиСервиса = Ложь;
	
КонецПроцедуры

// Процедура - При получении описания варианта настройки
//
// Параметры:
//  ОписаниеВарианта	 - Структура - Переченьдоступных свойств варианта настройки
//  ИдентификаторНастройки	 - Строка - Строковый идентификатор варианта настройки
//  ПараметрыКонтекста	 - Структура - Режим работы метода через контекст его выполнения
//
Процедура ПриПолученииОписанияВариантаНастройки(ОписаниеВарианта, ИдентификаторНастройки, ПараметрыКонтекста) Экспорт
	
	ОписаниеВарианта.ЗаголовокПомощникаСозданияОбмена = НСтр("ru='Настройка синхронизации с 1С:УПП, ред. 1.3'");
	ОписаниеВарианта.ЗаголовокУзлаПланаОбмена = НСтр("ru='Синхронизация с 1С:УПП, ред. 1.3'");
	
	ОписаниеВарианта.ИмяФайлаНастроекДляПриемника = НСтр("ru = 'Настройки синхронизации для EAM УПП'");
	ОписаниеВарианта.ИмяФормыСозданияНачальногоОбраза = "";
	ОписаниеВарианта.ИспользоватьПомощникСозданияОбменаДанными = Истина;
	ОписаниеВарианта.ИспользуемыеТранспортыСообщенийОбмена = ИспользуемыеТранспортыСообщенийОбмена();
	ОписаниеВарианта.КраткаяИнформацияПоОбмену = НСтр("ru = 'Данная настройка позволит синхронизировать данные между программами 1С:ТОИР Управление ремонтами и обслуживанием оборудования КОРП, редакция 3.0 и 1С:Управление производственным предприятием, редакция 1.3.'");
	
	Если ОбщегоНазначения.РазделениеВключено() Тогда
		ОписаниеВарианта.ПодробнаяИнформацияПоОбмену =  "http://its.1c.ru/db/bspdoc#content:120:1:IssOgl2_Обмен%2520с%2520Библиотекой%2520стандартных%2520подсистем";
	Иначе
		ОписаниеВарианта.ПодробнаяИнформацияПоОбмену =  "ПланОбмена.ОбменТОИР30УПП.Форма.ПодробнаяИнформация";
	КонецЕсли;
	ОписаниеВарианта.ПояснениеДляНастройкиПараметровУчета =  НСтр("ru = '??????'");
	
	ОписаниеВарианта.ОбщиеДанныеУзлов = "";
	ОписаниеВарианта.ИмяКонфигурацииКорреспондента = "1С:УПП, ред. 1.3";
	ОписаниеВарианта.НаименованиеКонфигурацииКорреспондента = "1С:УПП, ред. 1.3";

КонецПроцедуры

// Обработчик события при получении данных узла-отправителя.
// Событие возникает при получении данных узла-отправителя,
// когда данные узла прочитаны из сообщения обмена, но не записаны в информационную базу.
// В обработчике можно изменить полученные данные или вовсе отказаться от получения данных узла.
//
// Параметры:
//  Отправитель - ПланОбменаОбъект, Структура - узел плана обмена, от имени которого выполняется получение данных.
//  Игнорировать - Булево - признак отказа от получения данных узла.
//                         Если в обработчике установить значение этого параметра в Истина,
//                         то получение данных узла выполнена не будет. Значение по умолчанию - Ложь.
//
Процедура ПриПолученииДанныхОтправителя(Отправитель, Игнорировать) Экспорт
	
	Если ТипЗнч(Отправитель) = Тип("Структура") Тогда
		
		Если Отправитель.Свойство("РежимВыгрузкиСправочников") Тогда
			ПоменятьЗначения(Отправитель, "РежимВыгрузкиСправочников", "РежимВыгрузкиСправочниковКорреспондента");
		КонецЕсли;
		
		Если Отправитель.Свойство("РежимВыгрузкиДокументов") Тогда
			ПоменятьЗначения(Отправитель, "РежимВыгрузкиДокументов", "РежимВыгрузкиДокументовКорреспондента");
		КонецЕсли;
		
	Иначе
		
		ПоменятьЗначения(Отправитель, "РежимВыгрузкиСправочников", "РежимВыгрузкиСправочниковКорреспондента");
		ПоменятьЗначения(Отправитель, "РежимВыгрузкиДокументов", "РежимВыгрузкиДокументовКорреспондента");
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ПереопределяемаяНастройкаДополненияВыгрузки

// Предназначена для настройки вариантов интерактивной настройки выгрузки по сценарию узла.
// Для настройки необходимо установить значения свойств параметров в необходимые значения.
//
// Используется для контроля режимов работы помощника интерактивного обмена данными.
//
// Параметры:
//     Получатель - ПланОбменаСсылка - Узел, для которого производится настройка
//     Параметры  - Структура        - Параметры для изменения. Содержит поля:
//
//         ВариантБезДополнения - Структура     - настройки типового варианта "Не добавлять".
//                                                Содержит поля:
//             Использование - Булево - флаг разрешения использования варианта. По умолчанию Истина.
//             Порядок       - Число  - порядок размещения варианта на форме помощника, сверху вниз. По умолчанию 1.
//             Заголовок     - Строка - позволяет переопределить название типового варианта.
//             Пояснение     - Строка - позволяет переопределить текст пояснения варианта для пользователя.
//
//         ВариантВсеДокументы - Структура      - настройки типового варианта "Добавить все документы за период".
//                                                Содержит поля:
//             Использование - Булево - флаг разрешения использования варианта. По умолчанию Истина.
//             Порядок       - Число  - порядок размещения варианта на форме помощника, сверху вниз. По умолчанию 2.
//             Заголовок     - Строка - позволяет переопределить название типового варианта.
//             Пояснение     - Строка - позволяет переопределить текст пояснения варианта для пользователя.
//
//         ВариантПроизвольныйОтбор - Структура - настройки типового варианта "Добавить данные с произвольным отбором".
//                                                Содержит поля:
//             Использование - Булево - флаг разрешения использования варианта. По умолчанию Истина.
//             Порядок       - Число  - порядок размещения варианта на форме помощника, сверху вниз. По умолчанию 3.
//             Заголовок     - Строка - позволяет переопределить название типового варианта.
//             Пояснение     - Строка - позволяет переопределить текст пояснения варианта для пользователя.
//
//         ВариантДополнительно - Структура     - настройки дополнительного варианта по сценарию узла.
//                                                Содержит поля:
//             Использование            - Булево            - флаг разрешения использования варианта. По умолчанию Ложь.
//             Порядок                  - Число             - порядок размещения варианта на форме помощника, сверху вниз. 
//																				  По умолчанию 4.
//             Заголовок                - Строка            - название варианта для отображения на форме.
//             ИмяФормыОтбора           - Cтрока            - Имя формы, вызываемой для редактирования настроек.
//             ЗаголовокКомандыФормы    - Cтрока            - Заголовок для отрисовки на форме команды 
//                                                            открытия формы настроек.
//             ИспользоватьПериодОтбора - Булево            - флаг того, что необходим общий отбор по периоду. 
//                                                            По умолчанию Ложь.
//             ПериодОтбора             - СтандартныйПериод - значение периода общего отбора, предлагаемого по умолчанию.
//
//             Отбор                    - ТаблицаЗначений   - содержит строки с описанием подробных отборов по сценарию узла.
//                                                            Содержит колонки:
//                 ПолноеИмяМетаданных - Строка                - полное имя метаданных регистрируемого объекта, 
//                                                               отбор которого описывает строка.
//                                                               Например "Документ._ДемоПоступлениеТоваров". 
//                                                               Можно  использовать специальные 
//                                                               значения "ВсеДокументы" и "ВсеСправочники" 
//                                                               для отбора соответственно всех 
//                                                               документов и всех справочников, регистрирующихся 
//                                                               на узле Получатель.
//                 ВыборПериода        - Булево                - флаг того, что данная строка описывает отбор с общим периодом.
//                 Период              - СтандартныйПериод     - значение периода общего отбора для метаданных строки, 
//                                                               предлагаемого по умолчанию.
//                 Отбор               - ОтборКомпоновкиДанных - отбор по умолчанию. Поля отбора формируются в 
//                                                               соответствии с общим правилами
//                                                               формирования полей компоновки. Например, для 
//                                                               указания отбора по реквизиту
//                                                               документа "Организация", необходимо использовать 
//                                                               поле "Ссылка.Организация".
//
//
//     		Если для всех вариантов флаги разрешения использования установлены в Ложь, 
//     		то страница дополнения выгрузки в помощнике
//     		интерактивного обмена данными будет пропущена и дополнительная регистрация объектов 
//     		производится не будет. Например, инициализация вида:
//
//          		Параметры.ВариантВсеДокументы.Использование      = Ложь;
//          		Параметры.ВариантБезДополнения.Использование     = Ложь;
//          		Параметры.ВариантПроизвольныйОтбор.Использование = Ложь;
//          		Параметры.ВариантДополнительно.Использование     = Ложь;
//
//     		Приведет к тому, что шаг дополнения выгрузки будет полностью пропущен.
//
Процедура НастроитьИнтерактивнуюВыгрузку(Получатель, Параметры) Экспорт
	
	// Настраиваем стандартные варианты
	Параметры.ВариантБезДополнения.Использование     = Истина;
	Параметры.ВариантБезДополнения.Порядок           = 2;
	Параметры.ВариантВсеДокументы.Использование      = Ложь;
	Параметры.ВариантПроизвольныйОтбор.Использование = Ложь;
	
		
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПоменятьЗначения(Данные, Знач Свойство1, Знач Свойство2)
	
	Значение = Данные[Свойство1];
	
	Данные[Свойство1] = Данные[Свойство2];
	Данные[Свойство2] = Значение;
	
КонецПроцедуры

Функция ИспользуемыеТранспортыСообщенийОбмена()
	
	Результат = Новый Массив;
	Результат.Добавить(Перечисления.ВидыТранспортаСообщенийОбмена.FILE);
	Результат.Добавить(Перечисления.ВидыТранспортаСообщенийОбмена.COM);
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#КонецЕсли
