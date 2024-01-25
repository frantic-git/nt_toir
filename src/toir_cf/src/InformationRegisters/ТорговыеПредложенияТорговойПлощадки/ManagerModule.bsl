#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Регистрирует данные к обновлению в плане обмена ОбновлениеИнформационнойБазы
//  см. Стандарты и методики разработки прикладных решений: Параллельный режим отложенного обновления.
// 
// Параметры:
//  Параметры - см. ОбновлениеИнформационнойБазы.ОсновныеПараметрыОтметкиКОбработке.
//
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяРегистра = Метаданные.РегистрыСведений.ТорговыеПредложенияТорговойПлощадки.ПолноеИмя();
	
	ДополнительныеПараметры = ОбновлениеИнформационнойБазы.ДополнительныеПараметрыОтметкиОбработки();
	ДополнительныеПараметры.ЭтоНезависимыйРегистрСведений = Истина;
	ДополнительныеПараметры.ПолноеИмяРегистра = ПолноеИмяРегистра;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ТорговыеПредложенияТорговойПлощадки.ПрайсЛист,
		|	ТорговыеПредложенияТорговойПлощадки.Номенклатура,
		|	ТорговыеПредложенияТорговойПлощадки.Характеристика,
		|	ТорговыеПредложенияТорговойПлощадки.Упаковка
		|ИЗ
		|	РегистрСведений.ТорговыеПредложенияТорговойПлощадки КАК ТорговыеПредложенияТорговойПлощадки
		|ГДЕ
		|	ТорговыеПредложенияТорговойПлощадки.КратностьУпаковки = 0";
	
	Выгрузка = Запрос.Выполнить().Выгрузить();
	
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, Выгрузка, ДополнительныеПараметры);
	
КонецПроцедуры

// Обрабатывает данные, зарегистрированные в плане обмена ОбновлениеИнформационнойБазы
//  см. Стандарты и методики разработки прикладных решений: Параллельный режим отложенного обновления.
// 
// Параметры:
//  Параметры - см. ОбновлениеИнформационнойБазы.ОсновныеПараметрыОтметкиКОбработке.
//
Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	МетаданныеОбъекта = Метаданные.РегистрыСведений.ТорговыеПредложенияТорговойПлощадки;
	ПолноеИмяОбъекта  = МетаданныеОбъекта.ПолноеИмя();
	
	Если ОбновлениеИнформационнойБазы.ЕстьЗаблокированныеПредыдущимиОчередямиДанные(
		Параметры.Очередь, ПолноеИмяОбъекта) Тогда
		Параметры.ОбработкаЗавершена = ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(
			Параметры.Очередь, ПолноеИмяОбъекта);
		Возврат;
	КонецЕсли;
	
	ПараметрыВыборки = ОбновлениеИнформационнойБазы.ДополнительныеПараметрыВыборкиДанныхДляОбработки();
	ОбновляемыеДанные = ОбновлениеИнформационнойБазы.ВыбратьИзмеренияНезависимогоРегистраСведенийДляОбработки(
		Параметры.Очередь, ПолноеИмяОбъекта, ПараметрыВыборки);
	
	ЕстьОтработанныеЗаписи = Ложь;
	ПроизошлаОшибка        = Ложь;
	ТекстСообщения         = "";
	
	Пока ОбновляемыеДанные.Следующий() Цикл
		
		НачатьТранзакцию();
		
		Попытка
			
			НаборЗаписей = СоздатьНаборЗаписей();
			НаборЗаписей.Отбор.ПрайсЛист.Установить(ОбновляемыеДанные.ПрайсЛист);
			НаборЗаписей.Отбор.Номенклатура.Установить(ОбновляемыеДанные.Номенклатура);
			НаборЗаписей.Отбор.Характеристика.Установить(ОбновляемыеДанные.Характеристика);
			НаборЗаписей.Отбор.Упаковка.Установить(ОбновляемыеДанные.Упаковка);
			
			ОбщегоНазначенияБЭД.УстановитьУправляемуюБлокировкуПоНаборуЗаписей(НаборЗаписей);
			
			НаборЗаписей.Прочитать();
			
			Записать = Ложь;
			
			Если НаборЗаписей.Количество() > 0 Тогда
				
				ТекущаяЗапись = НаборЗаписей[0];
				
				Если ТекущаяЗапись.КратностьУпаковки = 0 Тогда
					
					Записать = Истина;
					
					ТекущаяЗапись.КратностьУпаковки = 1;
					
				КонецЕсли;
				
			КонецЕсли;
			
			Если Записать Тогда
				ОбновлениеИнформационнойБазы.ЗаписатьНаборЗаписей(НаборЗаписей);
			Иначе
				ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(НаборЗаписей);
			КонецЕсли;
			
			ЕстьОтработанныеЗаписи = Истина;
			ЗафиксироватьТранзакцию();
			
		Исключение
			
			ОтменитьТранзакцию();
			ШаблонСообщения = НСтр("ru = 'Не удалось обработать запись по торговому предложению %1 по причине: %2%3'");
			ПредставлениеОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ТекстСообщения = СтрШаблон(
				ШаблонСообщения, 
				ОбновляемыеДанные.ПрайсЛист, 
				Символы.ПС, 
				ПредставлениеОшибки);
			
			Событие = ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации();
			ЗаписьЖурналаРегистрации(
				Событие, 
				УровеньЖурналаРегистрации.Ошибка,
				МетаданныеОбъекта, 
				ОбновляемыеДанные.ПрайсЛист, 
				ТекстСообщения);
			
			ПроизошлаОшибка = Истина;
			
		КонецПопытки;
		
	КонецЦикла;
	
	Если Не ЕстьОтработанныеЗаписи И ПроизошлаОшибка Тогда
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;
	
	Параметры.ОбработкаЗавершена = 
		ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(Параметры.Очередь, ПолноеИмяОбъекта);
	
КонецПроцедуры

#КонецОбласти
	
#Область СлужебныеПроцедурыИФункции

Функция ДанныеКратностиУпаковокПубликуемыхТорговыхПредложений(ПрайсЛист, КратностьПоУмолчанию = Ложь) Экспорт
	
	Результат = Новый Массив;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ТорговыеПредложенияТорговойПлощадки.Номенклатура,
		|	ТорговыеПредложенияТорговойПлощадки.Характеристика,
		|	ТорговыеПредложенияТорговойПлощадки.Упаковка,
		|	ТорговыеПредложенияТорговойПлощадки.КратностьУпаковки
		|ИЗ
		|	РегистрСведений.ТорговыеПредложенияТорговойПлощадки КАК ТорговыеПредложенияТорговойПлощадки
		|ГДЕ
		|	ТорговыеПредложенияТорговойПлощадки.ПрайсЛист = &ПрайсЛист
		|	И ТорговыеПредложенияТорговойПлощадки.Публикуется
		|	И &ПолучитьВсеЗаписи";
	
	Если КратностьПоУмолчанию Тогда
		Текст = СтрЗаменить(
			Запрос.Текст, "&ПолучитьВсеЗаписи", "ТорговыеПредложенияТорговойПлощадки.КратностьУпаковки = 1");
	Иначе
		Текст = СтрЗаменить(
			Запрос.Текст, "&ПолучитьВсеЗаписи", "ТорговыеПредложенияТорговойПлощадки.КратностьУпаковки > 1");
	КонецЕсли;
	Запрос.Текст = Текст;
	
	Запрос.УстановитьПараметр("ПрайсЛист", ПрайсЛист);
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		
		ДанныеКратности = ТорговыеПредложенияСлужебный.НовыеДанныеКратностиУпаковок();
		ЗаполнитьЗначенияСвойств(ДанныеКратности, ВыборкаДетальныеЗаписи);
		Результат.Добавить(ДанныеКратности);
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Процедура ИзменитьКратностьУпаковкиЗаписи(ПрайсЛист, ДанныеЗаписи, Отказ = Ложь, Удалить = Ложь) Экспорт
	
	НачатьТранзакцию();
	
	Попытка
		
		// Установка объектной блокировки.
		ЗначениеКлюча = Новый Структура;
		ЗначениеКлюча.Вставить("ПрайсЛист", ПрайсЛист);
		ЗначениеКлюча.Вставить("Номенклатура", ДанныеЗаписи.Номенклатура);
		ЗначениеКлюча.Вставить("Характеристика", ДанныеЗаписи.Характеристика);
		ЗначениеКлюча.Вставить("Упаковка", ДанныеЗаписи.Упаковка);
		КлючЗаписи = СоздатьКлючЗаписи(ЗначениеКлюча);
		
		ЗаблокироватьДанныеДляРедактирования(КлючЗаписи);
		
		// Установка транзакционной блокировки.
		БлокировкаДанных = Новый БлокировкаДанных;
		ЭлементБлокировкиДанных = БлокировкаДанных.Добавить("РегистрСведений.ТорговыеПредложенияТорговойПлощадки");
		ЭлементБлокировкиДанных.УстановитьЗначение("ПрайсЛист", ПрайсЛист);
		ЭлементБлокировкиДанных.УстановитьЗначение("Номенклатура", ДанныеЗаписи.Номенклатура);
		ЭлементБлокировкиДанных.УстановитьЗначение("Характеристика", ДанныеЗаписи.Характеристика);
		ЭлементБлокировкиДанных.УстановитьЗначение("Упаковка", ДанныеЗаписи.Упаковка);
		ЭлементБлокировкиДанных.Режим = РежимБлокировкиДанных.Исключительный;
		БлокировкаДанных.Заблокировать();
		
		МенеджерЗаписи = СоздатьМенеджерЗаписи();
		МенеджерЗаписи.ПрайсЛист = ПрайсЛист;
		МенеджерЗаписи.Номенклатура = ДанныеЗаписи.Номенклатура;
		МенеджерЗаписи.Характеристика = ДанныеЗаписи.Характеристика;
		МенеджерЗаписи.Упаковка = ДанныеЗаписи.Упаковка;
		МенеджерЗаписи.Прочитать();
		
		Если ДанныеЗаписи.КратностьУпаковки <> МенеджерЗаписи.КратностьУпаковки Тогда
			МенеджерЗаписи.КратностьУпаковки = ДанныеЗаписи.КратностьУпаковки;
		КонецЕсли;
		
		Если МенеджерЗаписи.Модифицированность() Тогда
			МенеджерЗаписи.Записать();
		КонецЕсли;
		
		ЗафиксироватьТранзакцию();
		
	Исключение
		
		ОтменитьТранзакцию();
		
		ВидОперации = 
			НСтр("ru = 'Изменение кратности упаковки торгового предложения'", ОбщегоНазначения.КодОсновногоЯзыка());
		ПодробныйТекстОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЭлектронноеВзаимодействие.ОбработатьОшибку(
			ВидОперации, ПодробныйТекстОшибки, ПодробныйТекстОшибки, "ТорговыеПредложения");
		
		ВызватьИсключение;
		
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли