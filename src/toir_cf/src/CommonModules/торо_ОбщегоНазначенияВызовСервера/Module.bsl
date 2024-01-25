////////////////////////////////////////////////////////////////////////////////
// торо_ОбщегоНазначенияВызовСервера: общие методы
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Проверяет, что открыто несколько сеансов у этого пользователя.
// Возвращаемое значение:
//		Булево - открыто несколько сеансов.
Функция ПроверитьОткрытиеНесколькихСеансов() Экспорт
	
	Возврат торо_ОбщегоНазначения.ПроверитьОткрытиеНесколькихСеансов();
	
КонецФункции

// Обертка к платформенной функции ПравоДоступа.
// Параметры:
//		Право - Строка - название права доступа.
//		ТипОбъектаМетаданных - Строка - название типа "Справочники", "Документы" и т.п.
//		ИмяОбъекта - Строка - название конкретного справочника или документа.
//
// Возвращаемое значение:
//		Булево - Истина, если право есть.
Функция ЕстьПраво(Право,ТипОбъектаМетаданных,ИмяОбъекта) Экспорт
	Возврат ПравоДоступа(Право, Метаданные[ТипОбъектаМетаданных][ИмяОбъекта]);
КонецФункции

// Функция проверят наличие ролей с префиксом "торо", если отсутствует роль "Базовые права ТОиР".
// Возвращаемое значение:
//		Булево - доступна ли роль.
Функция ДоступностьРолиТОиРБазовыеПрава() Экспорт
	Возврат торо_ОбщегоНазначения.ДоступностьРолиТОиРБазовыеПрава();	
КонецФункции

// Проверяет право доступа на конфигурацию в целом.
// Параметры:
//		Право - Строка - проверяемое право.
// Возвращаемое значение:
//		Булево - есть ли право.
Функция ЕстьПравоУКонфигурации(Право) Экспорт
	Возврат ПравоДоступа(Право, Метаданные);
КонецФункции

// Заполняет переданную структуру с названиями ФО значениями этих ФО.
// Параметры:
//		СтруктураЗначенийФО - Структура - структура, где ключи - имена функциональных опций.
Процедура ЗаполнитьСтруктуруФункциональныхОпций(СтруктураЗначенийФО) Экспорт 
	
	Для каждого КлючИЗначение из СтруктураЗначенийФО Цикл
		ЗначениеФО = ПолучитьФункциональнуюОпцию(КлючИЗначение.Ключ);
		СтруктураЗначенийФО[КлючИЗначение.Ключ] = ЗначениеФО;
	КонецЦикла;
	
КонецПроцедуры

// Обертка для функции модуля ОбщегоНазначения.
// Параметры:
//		Тип - ОписаниеТипов - тип переменной.
//
// Возвращаемое значение:
//		Строка - строковое представление типа.
Функция СтроковоеПредставлениеТипа(Тип) Экспорт

	Возврат ОбщегоНазначения.СтроковоеПредставлениеТипа(Тип);
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Обертки для функций модуля ОбщегоНазначения.

Функция ЗначениеРеквизитаОбъекта(Ссылка, ИмяРеквизита, ВыбратьРазрешенные = Ложь, КодЯзыка = Неопределено) Экспорт
	
	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, ИмяРеквизита, ВыбратьРазрешенные, КодЯзыка);
	
КонецФункции

Функция ЗначенияРеквизитовОбъекта(Ссылка, Знач Реквизиты, ВыбратьРазрешенные = Ложь, КодЯзыка = Неопределено) Экспорт

	Возврат ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ссылка, Реквизиты, ВыбратьРазрешенные, КодЯзыка);
	
КонецФункции

Функция ЗначенияРеквизитовОбъектов(Ссылки, Знач Реквизиты, ВыбратьРазрешенные = Ложь, КодЯзыка = Неопределено) Экспорт
	
	Возврат ОбщегоНазначения.ЗначенияРеквизитовОбъектов(Ссылки, Реквизиты, ВыбратьРазрешенные, КодЯзыка);

КонецФункции

Функция ЗначениеРеквизитаОбъектов(МассивСсылок, ИмяРеквизита, ВыбратьРазрешенные = Ложь, КодЯзыка = Неопределено) Экспорт
	
	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъектов(МассивСсылок, ИмяРеквизита, ВыбратьРазрешенные, КодЯзыка);
	
КонецФункции

#КонецОбласти
