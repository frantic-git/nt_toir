#Область ПрограммныйИнтерфейс

// Обработчик события ПриОткрытии поля ввода формы для открытия формы ввода значения реквизита на разных языках.
//
// Параметры:
//  Форма   - ФормаКлиентскогоПриложения - форма содержащая мультиязычные реквизиты.
//  Объект  - ДанныеФормыСтруктура - объект на форме:
//   * Ссылка - ЛюбаяСсылка - 
//  Элемент - ПолеФормы - Элемент формы, для которого будет открыта форма ввода на разных языках.
//  СтандартнаяОбработка - Булево - Признак выполнения стандартной (системной) обработки события.
//
Процедура ПриОткрытииРеквизитаТЧ(Форма, Объект, Элемент, СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	
	СтрукрураПараметров = Форма.ПараметрыМультиязычныхРеквизитовТЧ[Элемент.Имя];
   ИмяРеквизита = СтрукрураПараметров.ИмяРеквизита;
	ИмяТабличнойЧасти = СтрукрураПараметров.ИмяТабличнойЧасти;
	
	ТекущиеДанные = Форма.Элементы[ИмяТабличнойЧасти].ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Ссылка",          Объект.Ссылка);
	ПараметрыФормы.Вставить("ИмяРеквизита",    ИмяРеквизита);
	ПараметрыФормы.Вставить("ТекущиеЗначение", Элемент.ТекстРедактирования);
	ПараметрыФормы.Вставить("ТолькоПросмотр",  Элемент.ТолькоПросмотр);
	ПараметрыФормы.Вставить("ИмяТабличнойЧасти",  ИмяТабличнойЧасти);
	
	Представления = Новый Структура();
		
	Представления.Вставить(ИмяРеквизита, ТекущиеДанные[ИмяРеквизита]);
	Представления.Вставить(ИмяРеквизита + "Язык1", ТекущиеДанные[ИмяРеквизита + "Язык1"]);
	Представления.Вставить(ИмяРеквизита + "Язык2", ТекущиеДанные[ИмяРеквизита + "Язык2"]);
		
	ПараметрыФормы.Вставить("ЗначенияРеквизитов", Представления);
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ТекущиеДанные", ТекущиеДанные);
	ДополнительныеПараметры.Вставить("ИмяРеквизита", ИмяРеквизита);
	ДополнительныеПараметры.Вставить("Форма", Форма); // Чтобы проставить Модифицированность.
	
	Оповещение = Новый ОписаниеОповещения("ПослеВводаСтрокНаРазныхЯзыках", торо_МультиязычностьКлиент, ДополнительныеПараметры);
	ОткрытьФорму("ОбщаяФорма.ВводНаРазныхЯзыках", ПараметрыФормы,,,,, Оповещение);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПослеВводаСтрокНаРазныхЯзыках(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) <> Тип("Структура") Тогда
		Возврат;
	КонецЕсли;
	
	ТекущиеДанные = ДополнительныеПараметры.ТекущиеДанные;
	Для каждого Представление Из Результат.ЗначенияНаРазныхЯзыках Цикл
		ТекущиеДанные[ДополнительныеПараметры.ИмяРеквизита + Представление.Суффикс]= Представление.ЗначениеРеквизита;
	КонецЦикла;
		
	Если Результат.Свойство("СтрокаНаТекущемЯзыке") Тогда
		ТекущиеДанные[ДополнительныеПараметры.ИмяРеквизита] = Результат.СтрокаНаТекущемЯзыке;
	КонецЕсли;
	
	ДополнительныеПараметры.Форма.Модифицированность = Истина;

КонецПроцедуры

#КонецОбласти
