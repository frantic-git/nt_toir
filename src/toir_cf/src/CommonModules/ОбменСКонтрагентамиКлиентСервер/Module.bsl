#Область ПрограммныйИнтерфейс

#Область ТекущиеДелаЭДО

// Возвращает набор параметров для отбора данных рабочего места "Текущие дела ЭДО"
// 
// Возвращаемое значение:
//  Структура - набор возможных отборов при работе с рабочим местом "Текущие дела ЭДО"
//  * РежимОтображения - Произвольный - режим отображения рабочего места, один из значений структуры, 
//                                      возвращаемой см. РежимыОтображенияТекущихДелЭДО. 
//  * Раздел - Произвольный - раздел рабочего места. , один из значений структуры, возвращаемой см. РазделыТекущихДелЭДО.
//  * ОтборВРазделеСоздать - Массив Из см. НовыйЭлементОтбораТекущихДелЭДО - отборы, которые нужно установить 
//                           на объект учета в разделе "Создать". 
//  * ОтборВходящихЭлектронныхДокументов - Массив Из см. НовыйЭлементОтбораТекущихДелЭДО - отборы, которые нужно установить
//                                         на входящие электронные документы.
//    ОтборИсходящихЭлектронныхДокументов - Массив Из см. НовыйЭлементОтбораТекущихДелЭДО - отборы, которые нужно установить
//                                          на исходящие электронные документы.	
Функция ПараметрыОтбораТекущихДелЭДО() Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("РежимОтображения", "");
	Результат.Вставить("Раздел", "");
	Результат.Вставить("ОтборВРазделеСоздать", Новый Массив);
	Результат.Вставить("ОтборВходящихЭлектронныхДокументов", Новый Массив);
	Результат.Вставить("ОтборИсходящихЭлектронныхДокументов", Новый Массив);
	
	Возврат Результат;
	
КонецФункции

// Доступные режимы отображения Текущих дел ЭДО
// 
// Возвращаемое значение:
// 	Структура - возможные режимы:
//  * КИсполнению - Произвольный - режим, в котором отбираются документы, требующие действий от текущего пользователя.
//  * МоиДокументы - Произвольный - режим, в котором отбираются документы, по которым ответственным является текущий пользователь.
//  * ВсеДокументы - Произвольный - режим отображения всех документов с незавершенным ЭДО.
Функция РежимыОтображенияТекущихДелЭДО() Экспорт 
	
	Результат = Новый Структура;
	Результат.Вставить("ВсеДокументы", "ВсеДокументы");
	Результат.Вставить("МоиДокументы", "МоиДокументы");
	Результат.Вставить("КИсполнению", "КИсполнению");
	
	Возврат Результат;
	
КонецФункции

// Доступные разделы Текущих дел ЭДО
// 
// Возвращаемое значение:
// 	Структура - доступные разделы:
//    * Входящие - произвольный
//    * ОтразитьВУчете - произвольный 
//    * УтвердитьВходящие - произвольный
//    * ПодписатьВходящие - произвольный
//    * ИсправитьВходящие - произвольный
//    * АннулироватьВходящие - произвольный
//    * НаКонтролеВходящие - произвольный
//    * Исходящие - произвольный
//    * Создать - произвольный
//    * ПодписатьИсходящие - произвольный
//    * ИсправитьИсходящие - произвольный
//    * АннулироватьИсходящие - произвольный
//    * НаКонтролеИсходящие - произвольный
Функция РазделыТекущихДелЭДО() Экспорт 
	
	Результат = Новый Структура;
	Результат.Вставить("Входящие", "Входящие");
	Результат.Вставить("ОтразитьВУчете", "Обработать");
	Результат.Вставить("УтвердитьВходящие", "Утвердить");
	Результат.Вставить("ПодписатьВходящие", "Подписать");
	Результат.Вставить("ИсправитьВходящие", "Исправить");
	Результат.Вставить("АннулироватьВходящие", "Аннулировать");
	Результат.Вставить("НаКонтролеВходящие", "НаКонтроле");
	Результат.Вставить("Исходящие", "Исходящие");
	Результат.Вставить("Создать", "Сформировать");
	Результат.Вставить("ПодписатьИсходящие", "ПодписатьИсх");
	Результат.Вставить("ИсправитьИсходящие", "ИсправитьИсх");
	Результат.Вставить("АннулироватьИсходящие", "АннулироватьИсх");
	Результат.Вставить("НаКонтролеИсходящие", "НаКонтролеИсх");
	
	Возврат Результат;
	
КонецФункции

// Формирует описание элемента отбора для рабочего места Текущие дела ЭДО.
// 
// Параметры:
//  Поле - Строка - путь к данным, на которые устанавливается отбор.
//  ВидСравнения - ВидСравненияКомпоновкиДанных - вид сравнения отбора. Допустимо использовать виды сравнения "Равно" и "В списке".
//  Значение - Произвольный - значение отбора.
// Возвращаемое значение:
//  Произвольный - описание элемента отбора 	
Функция НовыйЭлементОтбораТекущихДелЭДО(Поле, ВидСравнения, Значение) Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("Поле", Поле);
	Результат.Вставить("ВидСравнения", ВидСравнения);
	Результат.Вставить("Значение", Значение);
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#КонецОбласти