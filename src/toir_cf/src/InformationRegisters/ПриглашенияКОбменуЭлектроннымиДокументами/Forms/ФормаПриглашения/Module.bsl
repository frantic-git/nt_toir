
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Не Параметры.Свойство("Ключ") Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	КлючЗаписиПриглашения = Параметры.Ключ;
	КлючПриглашения = КлючЗаписиПриглашения.Ключ;
	ИдентификаторОрганизации = КлючЗаписиПриглашения.ИдентификаторОрганизации;
	Параметры.Свойство("ПараметрыИсправленияОшибок", ПараметрыИсправленияОшибок);
	ЗаполнитьДанные();
	НастроитьФорму();
	
	// ЭлектронноеВзаимодействие.ОбменСКонтрагентами.КонтекстныеПодсказкиБЭД
	КонтекстныеПодсказкиБЭД.КонтекстныеПодсказки_ПриСозданииНаСервере(ЭтотОбъект, Элементы.ПанельКонтекстныхНовостей);
	СформироватьКонтекст();
	// Конец ЭлектронноеВзаимодействие.ОбменСКонтрагентами.КонтекстныеПодсказкиБЭД
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	// ЭлектронноеВзаимодействие.ОбменСКонтрагентами.КонтекстныеПодсказкиБЭД
	КонтекстныеПодсказкиБЭДКлиент.КонтекстныеНовости_ПриОткрытии(ЭтотОбъект);
	// Конец ЭлектронноеВзаимодействие.ОбменСКонтрагентами.КонтекстныеПодсказкиБЭД

КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	РеквизитКонтрагент = ПроверяемыеРеквизиты.Найти("Контрагент");
	Если Не Элементы.Контрагент.Видимость И РеквизитКонтрагент <> Неопределено Тогда
		ПроверяемыеРеквизиты.Удалить(РеквизитКонтрагент);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ЭтоСобытиеИзмененияПриглашения(ИмяСобытия, Источник) Тогда
		ОбновитьФорму();
		ОповеститьОбИсправленииОшибок();
	КонецЕсли;
	
	// ЭлектронноеВзаимодействие.ОбменСКонтрагентами.КонтекстныеПодсказкиБЭД
	КонтекстныеПодсказкиБЭДКлиент.КонтекстныеНовости_ОбработкаОповещения(ЭтотОбъект, ИмяСобытия, Параметр, Источник);
	// Конец ЭлектронноеВзаимодействие.ОбменСКонтрагентами.КонтекстныеПодсказкиБЭД
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ИдентификаторОрганизацииОткрытие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если Не ЗначениеЗаполнено(ИдентификаторОрганизации) Тогда
		Возврат;
	КонецЕсли;
	
	УчетныеЗаписиЭДОКлиент.ОткрытьУчетнуюЗапись(ИдентификаторОрганизации);
	
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеКонтрагентаОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	Если НавигационнаяСсылкаФорматированнойСтроки = "ВыбратьКонтрагента" Тогда
		СтандартнаяОбработка = Ложь;

		ОповещениеОЗакрытии = Новый ОписаниеОповещения("ПослеВыбораКонтрагента", ЭтотОбъект);
		
		ПараметрыОтбора = Новый Структура("Наименование,ИНН,КПП");
		ПараметрыОтбора.ИНН = КонтрагентИНН;
	
		ИнтеграцияЭДОКлиент.ВыбратьКонтрагента(ПараметрыОтбора, ОповещениеОЗакрытии);
	ИначеЕсли НавигационнаяСсылкаФорматированнойСтроки = "СоздатьКонтрагентаИнтерактивно" Тогда
		СтандартнаяОбработка = Ложь;
		
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("КонтрагентСсылка", Неопределено);
		
		ОповещениеОСозданииКонтрагента = Новый ОписаниеОповещения("ПослеИнтерактивногоСозданияКонтрагента", ЭтотОбъект);
		
		РеквизитыКонтрагента = Новый Структура("Наименование,ИНН,КПП");
		РеквизитыКонтрагента.Наименование = КонтрагентНаименование;
		РеквизитыКонтрагента.ИНН = КонтрагентИНН;
		РеквизитыКонтрагента.КПП = КонтрагентКПП;
		
		ИнтеграцияЭДОКлиент.СоздатьКонтрагентаИнтерактивно(РеквизитыКонтрагента, ОповещениеОСозданииКонтрагента);	
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Принять(Команда)
	
	Если Не ПроверитьЗаполнение() Тогда  
		Возврат; 
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Контрагент) Тогда
		
		Если ЗначениеЗаполнено(НайденныйКонтрагент) Тогда
			Контрагент = НайденныйКонтрагент;
		ИначеЕсли СоздаватьКонтрагентовАвтоматически
			Или СоздатьКонтрагентаБезусловно Тогда
			
			РеквизитыКонтрагента = Новый Структура;
			РеквизитыКонтрагента.Вставить("Наименование", КонтрагентНаименование);
			РеквизитыКонтрагента.Вставить("ИНН", КонтрагентИНН);
			РеквизитыКонтрагента.Вставить("КПП", КонтрагентКПП);
			Контрагент = СоздатьНовогоКонтрагента(РеквизитыКонтрагента);
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(Контрагент) Тогда
			ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Не заполнен контрагент.'"));
			Возврат;
		КонецЕсли;
		
	КонецЕсли;
	
	Приглашение = ПриглашенияЭДОКлиент.НовоеВходящееПриглашение();
	Приглашение.КлючПриглашения = КлючПриглашения;
	Приглашение.ИдентификаторКонтрагента = ИдентификаторКонтрагента;
	Приглашение.ИдентификаторОрганизации = ИдентификаторОрганизации;
	Приглашение.Контрагент = Контрагент;
	
	Приглашения = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Приглашение);
	
	Контекст = Новый Структура;
	Контекст.Вставить("Действие", "Принять");
	
	Оповещение = Новый ОписаниеОповещения("ЗавершитьОтправкуОтветаНаПриглашение", ЭтотОбъект, Контекст);
	
	ПриглашенияЭДОСлужебныйКлиент.ПринятьПриглашения(Приглашения, ЭтаФорма, Оповещение);

КонецПроцедуры

&НаКлиенте
Процедура Отклонить(Команда)
	
	ВыполнитьДействиеСПриглашением("Отклонить");
	
КонецПроцедуры

&НаКлиенте
Процедура Отозвать(Команда)
	
	ВыполнитьДействиеСПриглашением("Отозвать");
	
КонецПроцедуры

&НаКлиенте
Процедура ОтправитьПовторно(Команда)
	
	ОчиститьСообщения();
	
	Если ОсновныеПараметрыОтправкиЗаполнены() Тогда
		ДанныеПриглашения = ДанныеПриглашения(КлючПриглашения, ИдентификаторОрганизации);
		ИсходящееПриглашение = СинхронизацияЭДОКлиент.НовоеПриглашениеНаИдентификатор();
		ЗаполнитьЗначенияСвойств(ИсходящееПриглашение, ДанныеПриглашения);	
	    ОбработчикОповещения = Новый ОписаниеОповещения("ОтправкаПриглашенияОповещениеОЗавершении", ЭтотОбъект);
		
		СинхронизацияЭДОКлиент.ОтправитьПриглашения(
			ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ИсходящееПриглашение),
			ЭтотОбъект,
			ОбработчикОповещения);	
	Иначе
		ОткрытьПомощникОтправкиПриглашения();
	КонецЕсли;

	
КонецПроцедуры

&НаКлиенте
Процедура СкопироватьОписание(Команда)
	
	БуферОбмена = СтрШаблон(
		"<!DOCTYPE html>
		|<html>
		|	<body onload='copy()'>
		|		<input id='input' type='text'/>
		|		<script>
		|			function copy() {
		|				var text = '%1';
		|				var ua = navigator.userAgent;
		|				if (ua.search(/MSIE/) > 0 || ua.search(/Trident/) > 0) {
		|					window.clipboardData.setData('Text', text);
		|				} else {
		|					var copyText = document.getElementById('input');
		|					copyText.value = text;
		|					copyText.select();
		|					document.execCommand('copy');
		|				}
		|			}
		|		</script>
		|	</body>
		|</html>", ОписаниеОшибки);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьДанные()
	
	СоздаватьКонтрагентовАвтоматически = НастройкиЭДО.СоздаватьКонтрагентовАвтоматически();
	
	ДанныеПриглашения = ДанныеПриглашения(КлючПриглашения, ИдентификаторОрганизации);
	Если ДанныеПриглашения = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтатусПодключения          = ДанныеПриглашения.Статус;
	Контрагент                 = ДанныеПриглашения.Контрагент;
	КонтрагентНаименование     = ?(ЗначениеЗаполнено(Контрагент),
		ДанныеПриглашения.КонтрагентПредставление, ДанныеПриглашения.КонтрагентНаименование);
	КонтрагентИНН              = ДанныеПриглашения.КонтрагентИНН;
	КонтрагентКПП              = ДанныеПриглашения.КонтрагентКПП;
	ИдентификаторКонтрагента   = ДанныеПриглашения.ИдентификаторКонтрагента;
	Организация                = ДанныеПриглашения.Организация;
	ИдентификаторОрганизации   = ДанныеПриглашения.ИдентификаторОрганизации;
	ОписаниеОшибки             = ДанныеПриглашения.ОписаниеОшибки;
	ТекстПриглашения           = ДанныеПриглашения.ТекстПриглашения;
	ЭлектроннаяПочта           = ДанныеПриглашения.ЭлектроннаяПочта;
	ОператорКонтрагента        = ДанныеПриглашения.ОператорКонтрагента;
	ОператорОрганизации        = ДанныеПриглашения.ОператорОрганизации;
	ПричинаОтказаОтПриглашения = ДанныеПриглашения.ПричинаОтказа;
	EmailОрганизации           = ДанныеПриглашения.EmailОрганизации;
	СпособОбмена               = ДанныеПриглашения.СпособОбмена;
	
	СоздатьКонтрагентаБезусловно = ПриглашенияЭДОСлужебный.СоздатьКонтрагентаБезусловно(КонтрагентИНН, КонтрагентКПП);
	
КонецПроцедуры

&НаСервере
Процедура НастроитьФорму()
	
	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаОсновная;
		
	ОбновитьПредставлениеКонтрагента();
	
	Элементы.ИдентификаторКонтрагента.Видимость = ЗначениеЗаполнено(ИдентификаторКонтрагента);
	
	Если СтатусПодключения = Перечисления.СтатусыПриглашений.ТребуетсяСогласие Тогда
		Элементы.Принять.Видимость   = Истина;
		Элементы.Принять.КнопкаПоУмолчанию = Истина;
		Элементы.Отклонить.Видимость = Истина;
		Элементы.Отозвать.Видимость = Ложь;
		
	ИначеЕсли СтатусПодключения = Перечисления.СтатусыПриглашений.Принято Тогда
		Элементы.Принять.Видимость   = Ложь;
		Элементы.Отклонить.Видимость = Ложь;
		Элементы.Отозвать.Видимость = НастройкиЭДО.ЕстьПравоНастройкиОбмена();
		Элементы.Закрыть.КнопкаПоУмолчанию = Истина;
		
	ИначеЕсли СтатусПодключения = Перечисления.СтатусыПриглашений.ОжидаемСогласия
		Или СтатусПодключения = Перечисления.СтатусыПриглашений.НастройкаРоуминга Тогда
		
		Элементы.Принять.Видимость   = Ложь;
		Элементы.Отклонить.Видимость = Ложь;
		Элементы.Отозвать.Видимость = НастройкиЭДО.ЕстьПравоНастройкиОбмена();
		Элементы.Закрыть.КнопкаПоУмолчанию = Истина;
		
	Иначе
		Элементы.Принять.Видимость   = Ложь;
		Элементы.Отклонить.Видимость = Ложь;
		Элементы.Отозвать.Видимость = Ложь;
		Элементы.Закрыть.КнопкаПоУмолчанию = Истина;
	КонецЕсли;
	
	Элементы.ОтправитьПовторно.Видимость = СтатусПодключения = Перечисления.СтатусыПриглашений.Отклонено
		ИЛИ СтатусПодключения = Перечисления.СтатусыПриглашений.Ошибка
		ИЛИ СтатусПодключения = Перечисления.СтатусыПриглашений.ТребуетсяОтправить;
	Если СтатусПодключения = Перечисления.СтатусыПриглашений.ТребуетсяОтправить Тогда
		Элементы.ОтправитьПовторно.Заголовок = НСтр("ru = 'Отправить'");
	Иначе
		Элементы.ОтправитьПовторно.Заголовок = НСтр("ru = 'Отправить повторно'");
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ОписаниеОшибки) Тогда
		Элементы.ГруппаОписаниеОшибки.Видимость = Истина;
		Элементы.БуферОбмена.Видимость = Истина;
		Элементы.ДекорацияОписаниеОшибки.Заголовок = ОписаниеОшибки;
	Иначе
		Элементы.ГруппаОписаниеОшибки.Видимость = Ложь;
		Элементы.БуферОбмена.Видимость = Ложь;
	КонецЕсли;
	
	Если СтатусПодключения = Перечисления.СтатусыПриглашений.Ошибка
		Или СтатусПодключения = Перечисления.СтатусыПриглашений.Отклонено Тогда
		ЦветФона = ЦветаСтиля.ЦветОтклоненногоПриглашенияКЭДО;
	ИначеЕсли СтатусПодключения = Перечисления.СтатусыПриглашений.Принято Тогда
		ЦветФона = ЦветаСтиля.ЦветПринятогоПриглашенияКЭДО;
	Иначе
		ЦветФона = ЦветаСтиля.ЦветОбрабатываемогоПриглашенияКЭДО;
	КонецЕсли;
	
	Элементы.ГруппаСостояние.ЦветФона = ЦветФона;
	
	Если Не НастройкиЭДО.ЕстьПравоНастройкиОбмена() Тогда
		Элементы.ОтправитьПовторно.Видимость = Ложь;
		Элементы.Принять.Видимость = Ложь;
		Элементы.Отклонить.Видимость = Ложь;
		Элементы.Отозвать.Видимость = Ложь;
	КонецЕсли;
	
	СвязиПараметровВыбора = Новый Массив;
	ИмяРеквизитаИНН = ИнтеграцияЭДО.ИмяНаличиеОбъектаРеквизитаВПрикладномРешении("ИННКонтрагента");
	Если ИмяРеквизитаИНН <> Неопределено Тогда
		ИмяСвязи = СтрШаблон("Отбор.%1", ИмяРеквизитаИНН);
		СвязьПараметраВыбора = Новый СвязьПараметраВыбора(ИмяСвязи, "КонтрагентИНН");
		СвязиПараметровВыбора.Добавить(СвязьПараметраВыбора);
		Элементы.Контрагент.СвязиПараметровВыбора = Новый ФиксированныйМассив(СвязиПараметровВыбора);
	КонецЕсли;
	
	Элементы.ПричинаОтказаОтПриглашения.Видимость = ЗначениеЗаполнено(ПричинаОтказаОтПриглашения)
		И СтатусПодключения = ПредопределенноеЗначение("Перечисление.СтатусыПриглашений.Отклонено");
		
	Элементы.EmailОрганизации.Видимость = ЗначениеЗаполнено(EmailОрганизации);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция СоздатьНовогоКонтрагента(Знач РеквизитыКонтрагента)

	Возврат ИнтеграцияЭДО.СоздатьКонтрагента(РеквизитыКонтрагента);

КонецФункции

&НаСервереБезКонтекста
Функция ДанныеПриглашения(КлючПриглашения, ИдентификаторОрганизации)
	
	ПолныйКлючПриглашения = ПриглашенияЭДОКлиентСервер.НовыйКлючПриглашения();
	ПолныйКлючПриглашения.Ключ = КлючПриглашения;
	ПолныйКлючПриглашения.ИдентификаторОрганизации = ИдентификаторОрганизации;
	
	ДанныеПриглашения = ПриглашенияЭДОСлужебный.ДанныеПриглашения(ПолныйКлючПриглашения);	
	
	Возврат ДанныеПриглашения;	
	
КонецФункции

&НаКлиенте
Процедура ЗавершитьОтправкуОтветаНаПриглашение(Результат, Контекст) Экспорт
	
	Если Не Результат.Успех Тогда
		
		ОбработкаНеисправностейБЭДКлиент.ОбработатьОшибки(Результат.КонтекстДиагностики);
		
		Если Контекст.Действие = "Отозвать" Тогда
			Элементы.Отозвать.Доступность = Истина;
		Иначе
			Элементы.Принять.Доступность   = Истина;
			Элементы.Отклонить.Доступность = Истина;
		КонецЕсли;
		
		Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаОсновная;
		Возврат;
	КонецЕсли;
	
	Если Контекст.Действие = "Принять" Тогда
		Текст = НСтр("ru = 'Приглашение принято.
			|Теперь можно обмениваться с контрагентом электронными документами.'");
		Элементы.Принять.Видимость   = Ложь;
		Элементы.Отклонить.Видимость = Ложь;
		
	ИначеЕсли Контекст.Действие = "Отклонить" Тогда
		Текст = НСтр("ru = 'Приглашение отклонено.
			|Теперь прием и отправка электронных документов невозможны.'");
		Элементы.Принять.Видимость   = Ложь;
		Элементы.Отклонить.Видимость = Ложь;
		
	ИначеЕсли Контекст.Действие = "Отозвать" Тогда
		Текст = НСтр("ru = 'Приглашение отозвано.
			|Теперь прием и отправка электронных документов невозможны.'");
		Элементы.Отозвать.Видимость = Ложь;
		
	КонецЕсли;
	
	Элементы.НадписьВыполнено.Заголовок = Текст;
	
	Элементы.Закрыть.КнопкаПоУмолчанию = Истина;
	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаВыполнено;
	
	Оповестить("ОбновитьСостояниеПриглашений");
	ОповеститьОбИсправленииОшибок();
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПомощникОтправкиПриглашения()
	
	ПараметрыОткрытия = ПриглашенияЭДОСлужебныйКлиент.НовыеПараметрыОткрытияПомощникаОтправкиПриглашения();
	ПараметрыОткрытия.КлючПриглашения = КлючПриглашения;
	ПараметрыОткрытия.Организация = Организация;
	ПараметрыОткрытия.ИдентификаторОрганизации = ИдентификаторОрганизации;
	ПараметрыОткрытия.Контрагент = Контрагент;
	Если ЗначениеЗаполнено(ИдентификаторКонтрагента) Тогда
		ПараметрыОткрытия.ИдентификаторКонтрагента = ИдентификаторКонтрагента;
	ИначеЕсли ЗначениеЗаполнено(ОператорКонтрагента) Тогда
		ПараметрыОткрытия.ОператорКонтрагента = ОператорКонтрагента;
	ИначеЕсли ЗначениеЗаполнено(ЭлектроннаяПочта) Тогда
		ПараметрыОткрытия.ЭлектроннаяПочта = ЭлектроннаяПочта;
	КонецЕсли;
	
	ПриглашенияЭДОСлужебныйКлиент.ОткрытьПомощникОтправкиПриглашения(ПараметрыОткрытия);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьФорму()
	
	ЗаполнитьДанные();
	НастроитьФорму();
	
КонецПроцедуры

&НаКлиенте
Функция ЭтоСобытиеИзмененияПриглашения(ИмяСобытия, Источник)
	
	Если ТипЗнч(Источник) = Тип("РегистрСведенийКлючЗаписи.ПриглашенияКОбменуЭлектроннымиДокументами") Тогда
		КлючЗаписи = Источник;
	КонецЕсли;
	
	Если ОбщегоНазначенияБЭДКлиент.ЭтоСобытиеИзменениеОбъекта(КлючЗаписи, ИмяСобытия)
		И Источник = КлючЗаписи Тогда
		Возврат Истина;
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции

&НаКлиенте
Функция ОсновныеПараметрыОтправкиЗаполнены()
	
	ИменаОсновныхПараметровОтправки = Новый Массив();
	ИменаОсновныхПараметровОтправки.Добавить("КлючПриглашения");
	ИменаОсновныхПараметровОтправки.Добавить("Контрагент");
	ИменаОсновныхПараметровОтправки.Добавить("ИдентификаторКонтрагента");
	ИменаОсновныхПараметровОтправки.Добавить("Организация");
	ИменаОсновныхПараметровОтправки.Добавить("ИдентификаторОрганизации");
	ИменаОсновныхПараметровОтправки.Добавить("ТекстПриглашения");
		
	Для Каждого ИмяОсновногоПараметра Из ИменаОсновныхПараметровОтправки Цикл
		Если Не ЗначениеЗаполнено(ЭтаФорма[ИмяОсновногоПараметра]) Тогда
			Возврат Ложь;	
		КонецЕсли;
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

&НаКлиенте
Процедура ОтправкаПриглашенияОповещениеОЗавершении(Результат, ДополнительныеПараметры) Экспорт

	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;

	КонтекстДиагностики = Результат.КонтекстДиагностики;
	
	ТекстЗаголовка = НСтр("ru = 'Отправка приглашения'");
	ЗакрытьФорму = Ложь;
	Если Результат.Успех Тогда
		ТекстСообщенияШаблон = НСтр("ru = 'Приглашение к обмену отправлено контрагенту: %1'");
		ТекстСообщения = СтрШаблон(ТекстСообщенияШаблон, КонтрагентНаименование);
		СтатусОповещения = СтатусОповещенияПользователя.Информация;
		Оповестить("ОбновитьСостояниеПриглашений");
		ЗакрытьФорму = Истина;
	Иначе
		ТекстСообщенияШаблон = НСтр("ru = 'Не удалось отправить приглашение к обмену контрагенту: %1. 
			|Подробности в журнале регистрации'");
		ТекстСообщения = СтрШаблон(ТекстСообщенияШаблон, КонтрагентНаименование);
		СтатусОповещения = СтатусОповещенияПользователя.Важное;	
	КонецЕсли;
	
	ПоказатьОповещениеПользователя(ТекстЗаголовка, , ТекстСообщения, , СтатусОповещения);
		
	Если ОбработкаНеисправностейБЭДКлиентСервер.ЕстьОшибки(КонтекстДиагностики) Тогда
		ОбработкаНеисправностейБЭДКлиент.ОбработатьОшибки(КонтекстДиагностики);
	КонецЕсли;
	
	Если ЗакрытьФорму И Открыта() Тогда
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

#Область КонтекстныеПодсказки

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ПанельКонтекстныхНовостей_ЭлементУправленияНажатие(Элемент)
	
	КонтекстныеПодсказкиБЭДКлиент.ЭлементУправленияНажатие(ЭтотОбъект, Элемент);
	
КонецПроцедуры

&НаСервере
Процедура СформироватьКонтекст(КатегорииПересчета = Неопределено) 
	
	Если Не КонтекстныеПодсказкиБЭД.ФункционалКонтекстныхПодсказокДоступен() Тогда 
		Возврат;
	КонецЕсли;
	
	Категория = КонтекстныеПодсказкиБЭДКатегоризацияВызовСервера.Категория_ОператорАбонента();
	Если ЗначениеЗаполнено(Категория)  
			И ?(ЗначениеЗаполнено(КатегорииПересчета), КатегорииПересчета.Найти(Категория) <> Неопределено, Истина) Тогда 
		Значение = КонтекстныеПодсказкиБЭДКатегоризация.ОператорАбонента(ИдентификаторКонтрагента); 
		КонтекстныеПодсказкиБЭДКлиентСервер.УстановитьЗначениеКатегорииКонтекстаФормы(ЭтаФорма, Категория, Значение);
	КонецЕсли;
	
	Категория = КонтекстныеПодсказкиБЭДКатегоризацияВызовСервера.Категория_КодОператораУчетнойЗаписиОрганизации();
	Если ЗначениеЗаполнено(Категория)  
			И ?(ЗначениеЗаполнено(КатегорииПересчета), КатегорииПересчета.Найти(Категория) <> Неопределено, Истина) Тогда 
		Значение = КонтекстныеПодсказкиБЭДКатегоризация.КодОператораУчетнойЗаписиОрганизации(Организация); 
		КонтекстныеПодсказкиБЭДКлиентСервер.УстановитьЗначениеКатегорииКонтекстаФормы(ЭтаФорма, Категория, Значение);
	КонецЕсли;

	КонтекстныеПодсказкиБЭД.ОтобразитьАктуальныеДляКонтекстаНовости(ЭтотОбъект);
	
КонецПроцедуры

//@skip-warning
// Процедура показывает новости, требующие прочтения (важные и очень важные).
//
// Параметры:
//  Нет.
&НаКлиенте
Процедура Подключаемый_ПоказатьНовостиТребующиеПрочтенияПриОткрытии()

	ИдентификаторыСобытийПриОткрытии = "ПриОткрытии";	
	КонтекстныеПодсказкиБЭДКлиент.КонтекстныеНовости_ПоказатьНовостиТребующиеПрочтенияПриОткрытии(ЭтотОбъект, ИдентификаторыСобытийПриОткрытии);

КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ПанельКонтекстныхНовостейОбработкаНавигационнойСсылки(Элемент, ПараметрНавигационнаяСсылка, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;

	КонтекстныеПодсказкиБЭДКлиент.ПанельКонтекстныхНовостей_ЭлементПанелиНовостейОбработкаНавигационнойСсылки(
		ЭтотОбъект,
		Элемент,
		ПараметрНавигационнаяСсылка,
		СтандартнаяОбработка);

КонецПроцедуры

#КонецОбласти 

&НаКлиенте
Процедура ОповеститьОбИсправленииОшибок() 
	
	Если ЗначениеЗаполнено(ПараметрыИсправленияОшибок) Тогда
		ОбработкаНеисправностейБЭДКлиент.ОповеститьОбИсправленииОшибок(ПараметрыИсправленияОшибок.ИсправленныеОшибки);
		Оповестить(ОбработкаНеисправностейБЭДКлиент.ИмяСобытияИсправлениеВидаОшибки(), ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(КлючЗаписи));
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьДействиеСПриглашением(Действие)
	
	Если Действие = "Отозвать" Тогда
		Элементы.Отозвать.Доступность = Ложь;
	Иначе
		Элементы.Принять.Доступность = Ложь;
		Элементы.Отклонить.Доступность = Ложь;
	КонецЕсли;
	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаОжидание;
	
	Приглашение = ПриглашенияЭДОКлиент.НовоеВходящееПриглашение();
	Приглашение.КлючПриглашения = КлючПриглашения;
	Приглашение.ИдентификаторКонтрагента = ИдентификаторКонтрагента;
	Приглашение.ИдентификаторОрганизации = ИдентификаторОрганизации;
	Приглашение.Организация = Организация;
	Приглашение.СпособОбмена = СпособОбмена;
	Приглашение.Статус = СтатусПодключения;
	Приглашение.Контрагент = ?(ЗначениеЗаполнено(Контрагент), Контрагент, 
								ПредопределенноеЗначение("Справочник.Контрагенты.ПустаяСсылка"));
	
	Приглашения = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Приглашение);
	
	Контекст = Новый Структура;
	Контекст.Вставить("Действие", Действие);
	
	Оповещение = Новый ОписаниеОповещения("ЗавершитьОтправкуОтветаНаПриглашение", ЭтотОбъект, Контекст);
	
	Если Действие = "Принять" Тогда
		ПриглашенияЭДОСлужебныйКлиент.ПринятьПриглашения(Приглашения, ЭтаФорма, Оповещение);
	ИначеЕсли Действие = "Отклонить" Тогда
		ПриглашенияЭДОСлужебныйКлиент.ОтклонитьПриглашения(Приглашения, ЭтаФорма, Оповещение);
	ИначеЕсли Действие = "Отозвать" Тогда
		ПриглашенияЭДОСлужебныйКлиент.ОтозватьПриглашения(Приглашения, ЭтаФорма, Оповещение);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьПредставлениеКонтрагента()
	
	Если ЗначениеЗаполнено(Контрагент) Тогда
		ПредставлениеКонтрагента = Новый ФорматированнаяСтрока(КонтрагентНаименование,,,, ПолучитьНавигационнуюСсылку(Контрагент));
		Элементы.ПредставлениеКонтрагента.ОтображениеПодсказки = ОтображениеПодсказки.Авто;
	Иначе
		Если ЗначениеЗаполнено(КонтрагентКПП) Тогда
			Шаблон = НСтр("ru = '%1 (ИНН: %2 КПП: %3)'");
			ПредставлениеКонтрагента = Новый ФорматированнаяСтрока(СтрШаблон(Шаблон, КонтрагентНаименование, КонтрагентИНН, КонтрагентКПП));
		Иначе
			Шаблон = НСтр("ru = '%1 (ИНН: %2)'");
			ПредставлениеКонтрагента = Новый ФорматированнаяСтрока(СтрШаблон(Шаблон, КонтрагентНаименование, КонтрагентИНН));
		КонецЕсли;
		
		Если Не СоздаватьКонтрагентовАвтоматически
			И Не СоздатьКонтрагентаБезусловно Тогда
			
			Пробел = " ";
			
			МассивСтрок = Новый Массив;
			МассивСтрок.Добавить(НСтр("ru = 'Не удалось найти контрагента по реквизитам из приглашения, необходимо'"));
			МассивСтрок.Добавить(Пробел);
			МассивСтрок.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = 'выбрать'"),, ЦветаСтиля.ГиперссылкаЦвет,, "ВыбратьКонтрагента"));
			МассивСтрок.Добавить(Пробел);
			МассивСтрок.Добавить(НСтр("ru = 'его вручную или'"));
			МассивСтрок.Добавить(Пробел);
			МассивСтрок.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = 'создать'"),, ЦветаСтиля.ГиперссылкаЦвет,, "СоздатьКонтрагентаИнтерактивно"));
			МассивСтрок.Добавить(Пробел);
			МассивСтрок.Добавить(НСтр("ru = 'нового.'"));
		
			Элементы.ПредставлениеКонтрагента.РасширеннаяПодсказка.Заголовок = Новый ФорматированнаяСтрока(МассивСтрок);
			Элементы.ПредставлениеКонтрагента.ОтображениеПодсказки = ОтображениеПодсказки.ОтображатьСнизу;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыбораКонтрагента(ВыбранныйКонтрагент, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныйКонтрагент = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Контрагент = ВыбранныйКонтрагент;
	ИзменитьКонтрагентаВПриглашении();
	ОповеститьОбУстраненииОшибкиПустогоКонтрагента();
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеИнтерактивногоСозданияКонтрагента(НовыйКонтрагент, ДополнительныеПараметры) Экспорт
	
	Если НовыйКонтрагент = Неопределено Или ЗначениеЗаполнено(Контрагент) Тогда
		Возврат;
	КонецЕсли;
	
	Контрагент = НовыйКонтрагент;
	ИзменитьКонтрагентаВПриглашении();
	ОповеститьОбУстраненииОшибкиПустогоКонтрагента();

КонецПроцедуры

&НаКлиенте
Процедура ОповеститьОбУстраненииОшибкиПустогоКонтрагента()
	
	ИмяСобытия = ОбработкаНеисправностейБЭДКлиент.ИмяСобытияИсправлениеВидаОшибки();
	
	ПолныйКлючПриглашения = ПриглашенияЭДОКлиентСервер.НовыйКлючПриглашения();
	ПолныйКлючПриглашения.Ключ = КлючПриглашения;
	ПолныйКлючПриглашения.ИдентификаторОрганизации = ИдентификаторОрганизации;
	
	КлючЗаписиПриглашения = ПриглашенияЭДОСлужебныйВызовСервера.КлючЗаписиПриглашения(ПолныйКлючПриглашения);
	Параметр = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(КлючЗаписиПриглашения);
	
	ОповеститьОбИзменении(КлючЗаписиПриглашения);
	Оповестить(ИмяСобытия, Параметр);
	
КонецПроцедуры

&НаСервере
Процедура ИзменитьКонтрагентаВПриглашении()
		
	ПолныйКлючПриглашения = ПриглашенияЭДОКлиентСервер.НовыйКлючПриглашения();
	ПолныйКлючПриглашения.Ключ = КлючПриглашения;
	ПолныйКлючПриглашения.ИдентификаторОрганизации = ИдентификаторОрганизации;
	
	ПриглашенияЭДОСлужебный.ИзменитьКонтрагентаВПриглашении(ПолныйКлючПриглашения, Контрагент);
	ОбновитьФорму();
	
КонецПроцедуры

#КонецОбласти