#Область СлужебныЙПрограммныйИнтерфейс

// Свойства сервера МЧД.
// 
// Возвращаемое значение:
//  Структура:
//  * АдресСервера - Строка
//  * АдресСервераБезАутентификации - Строка
//  * РесурсКорняAPI - Строка
//  * ЛогинОператора - Строка
//  * ПарольОператора - Строка
//  * ИспользоватьРасширенияAPI - Булево
// 
Функция СвойстваСервераМЧД() Экспорт
	
	СтруктураАдреса = Константы.АдресРеестраМЧД.ПрочитатьАдрес();
	СтруктураАдреса.Вставить("АдресСервераБезАутентификации",	СтруктураАдреса.АдресСервера);
	СтруктураАдреса.Вставить("ЛогинОператора", 					"");
	СтруктураАдреса.Вставить("ПарольОператора", 				"");
	
	Возврат СтруктураАдреса;
	
КонецФункции

// Используется режим тестирования.
// 
// Возвращаемое значение:
//  Булево
//  
Функция ИспользуетсяРежимТестирования() Экспорт
	
	Возврат Константы.РежимТестированияМЧД.Получить();
	
КонецФункции

#КонецОбласти
