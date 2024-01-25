
#Область ПрограммныйИнтерфейс

// Формирует дерево значений с колонками Наименование, Оператор, Сдвиг
//
// Возвращаемое значение:
//  ДеревоЗначений - дерево операторов.
//
Функция ПолучитьПустоеДеревоОператоров() Экспорт
	
	Дерево = Новый ДеревоЗначений();
	Дерево.Колонки.Добавить("Наименование");
	Дерево.Колонки.Добавить("Оператор");
	Дерево.Колонки.Добавить("Сдвиг", Новый ОписаниеТипов("Число"));
	
	Возврат Дерево;
	
КонецФункции

// Добавляет в дерево операторов группу операторов с переданным наименованием
//
// Параметры:
//  Дерево - ДеревоЗначений - дерево операторов с колонками Наименование, Оператор, Сдвиг.
//  Наименование - Строка - наименование группы дерева операторов.
//
// Возвращаемое значение:
//  СтрокаДереваЗначений - новая группа операторов.
//
Функция ДобавитьГруппуОператоров(Дерево, Наименование) Экспорт
	
	НоваяГруппа = Дерево.Строки.Добавить();
	НоваяГруппа.Наименование = Наименование;
	
	Возврат НоваяГруппа;
	
КонецФункции

// Добавляет в дерево операторов группу операторов с переданным наименованием.
//
// Параметры:
//  Дерево        - ДеревоЗначений - дерево операторов с колонками Наименование, Оператор, Сдвиг
//  Родитель      - СтрокаДереваЗначений - Группа операторов, в которую необходимо добавить оператор
//  Наименование  - Строка - наименование группы дерева операторов
//  Оператор      - Строка - Представление оператора на встроенном языке
//  Сдвиг         - Число - необходим для определения позиции курсора.
//
// Возвращаемое значение:
//  СтрокаДереваЗначений - новый оператор.
//
Функция ДобавитьОператор(Дерево, Наименование, Родитель = Неопределено, Оператор = Неопределено, Сдвиг = 0) Экспорт
	
	НоваяСтрока = ?(Родитель <> Неопределено, Родитель.Строки.Добавить(), Дерево.Строки.Добавить());
	НоваяСтрока.Наименование = Наименование;
	НоваяСтрока.Оператор = ?(ЗначениеЗаполнено(Оператор), Оператор, Наименование);
	НоваяСтрока.Сдвиг = Сдвиг;
	
	Возврат НоваяСтрока;
	
КонецФункции

// Формирует дерево со стандартными операторами "+", "-", "*", "/"
//
// Возвращаемое значение:
//  ДеревоЗначений - дерево операторов.
//
Функция ПолучитьСтандартноеДеревоОператоров() Экспорт
	
	Дерево = ПолучитьПустоеДеревоОператоров();
	ГруппаОператоров = ДобавитьГруппуОператоров(Дерево, "Операторы");
	ДобавитьОператор(Дерево, "+", ГруппаОператоров, " + ");
	ДобавитьОператор(Дерево, "-", ГруппаОператоров, " - ");
	ДобавитьОператор(Дерево, "*", ГруппаОператоров, " * ");
	ДобавитьОператор(Дерево, "/", ГруппаОператоров, " / ");
	
	Возврат Дерево;
	
КонецФункции

// Заполняет дерево операторов для конструктора формул.
//
// Параметры:
//  Параметры  - Структрура - содержит виды операторов, которые необходимо добавить в дерево.
//  УникальныйИдентификатор  - УникальныйИдентификатор - уникальный идентификатор формы, в которой выполняется действия, 
//                 необходим для корректного помещения во временное хранилище.
//
// Возвращаемое значение:
//  Строка - Адрес дерева во временном хранилище.
Функция ПостроитьДеревоОператоров(Параметры, УникальныйИдентификатор) Экспорт
	
	Дерево = торо_РаботаСФормулами.ПолучитьПустоеДеревоОператоров();
	
	Если Параметры.Свойство("СтандартныеОператоры") И Параметры.СтандартныеОператоры Тогда
		ДобавитьГруппуСтандартныхОператоров(Дерево);
	КонецЕсли;
	
	Если Параметры.Свойство("ЛогическиеОператоры") И Параметры.ЛогическиеОператоры Тогда
		ДобавитьГруппуЛогическихОператоров(Дерево);
	КонецЕсли;
	
	Если Параметры.Свойство("Функции") И Параметры.Функции Тогда
		ДобавитьГруппуФункции(Дерево);
	КонецЕсли;
	
	Возврат ПоместитьВоВременноеХранилище(Дерево, УникальныйИдентификатор);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ДобавитьГруппуСтандартныхОператоров(Дерево)

	ГруппаОператоров = торо_РаботаСФормулами.ДобавитьГруппуОператоров(Дерево, НСтр("ru='Операторы'"));
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, "+", ГруппаОператоров, " + ");
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, "-", ГруппаОператоров, " - ");
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, "*", ГруппаОператоров, " * ");
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, "/", ГруппаОператоров, " / ");

КонецПроцедуры

Процедура ДобавитьГруппуЛогическихОператоров(Дерево)

	ГруппаОператоров = торо_РаботаСФормулами.ДобавитьГруппуОператоров(Дерево, НСтр("ru='Логические операторы и константы'"));
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, "<",  ГруппаОператоров, " < ");
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, ">",  ГруппаОператоров, " > ");
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, "<=", ГруппаОператоров, " <= ");
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, ">=", ГруппаОператоров, " >= ");
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, "=",  ГруппаОператоров, " = ");
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, "<>", ГруппаОператоров, " <> ");
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, НСтр("ru='И'"),      ГруппаОператоров, " " + НСтр("ru='И'")      + " ");
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, НСтр("ru='ИЛИ'"),    ГруппаОператоров, " " + НСтр("ru='ИЛИ'")    + " ");
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, НСтр("ru='НЕ'"),     ГруппаОператоров, " " + НСтр("ru='НЕ'")     + " ");
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, НСтр("ru='ИСТИНА'"), ГруппаОператоров, " " + НСтр("ru='ИСТИНА'") + " ");
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, НСтр("ru='ЛОЖЬ'"),   ГруппаОператоров, " " + НСтр("ru='ЛОЖЬ'")   + " ");

КонецПроцедуры

Процедура ДобавитьГруппуФункции(Дерево)

	ГруппаОператоров = торо_РаботаСФормулами.ДобавитьГруппуОператоров(Дерево, НСтр("ru='Функции'"));
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, НСтр("ru='Максимум'"),                  ГруппаОператоров, НСтр("ru='Макс(,)'"), 2);
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, НСтр("ru='Минимум'"),                   ГруппаОператоров, НСтр("ru='Мин(,)'"),  2);
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, НСтр("ru='Округление'"),                ГруппаОператоров, НСтр("ru='Окр(,)'"),  2);
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, НСтр("ru='Целая часть'"),               ГруппаОператоров, НСтр("ru='Цел()'"),   1);
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, НСтр("ru='Условие'"),                   ГруппаОператоров, "?(,,)",              3);
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, НСтр("ru='Предопределенное значение'"), ГруппаОператоров, НСтр("ru='ПредопределенноеЗначение()'"));
	торо_РаботаСФормулами.ДобавитьОператор(Дерево, НСтр("ru='Значение заполнено'"),        ГруппаОператоров, НСтр("ru='ЗначениеЗаполнено()'"));

КонецПроцедуры

#КонецОбласти
