
#Область СлужебныйПрограммныйИнтерфейс

////////////////////////////////////////////////////////////////////////////////
// Обработчики событий формы Сотрудника

Процедура СотрудникиПередЗаписью(Форма, Отказ, ПараметрыЗаписи) Экспорт
	
	СотрудникиКлиентБазовый.СотрудникиПередЗаписью(Форма, Отказ, ПараметрыЗаписи);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Обработчики событий формы Физического лица

Процедура ФизическиеЛицаПередЗаписью(Форма, Отказ, ПараметрыЗаписи, ОповещениеЗавершения = Неопределено, ЗакрытьПослеЗаписи = Истина) Экспорт
	
	СотрудникиКлиентБазовый.ФизическиеЛицаПередЗаписью(Форма, Отказ, ПараметрыЗаписи, ОповещениеЗавершения, ЗакрытьПослеЗаписи);
	
КонецПроцедуры

Процедура ФизическиеЛицаОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник) Экспорт
	
	СотрудникиКлиентБазовый.ФизическиеЛицаОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Обработчики событий элементов форм сотрудника и физического лица
// содержащих уникальные значения.

Процедура ФизическиеЛицаИННПриИзменении(Форма, Элемент) Экспорт
	
	СотрудникиКлиентБазовый.ФизическиеЛицаИННПриИзменении(Форма, Элемент);
	ПроверитьУникальностьФизическогоЛица(Форма, "ИНН");
	
КонецПроцедуры

Процедура ФизическиеЛицаСтраховойНомерПФРПриИзменении(Форма, Элемент) Экспорт
	
	СотрудникиКлиентБазовый.ФизическиеЛицаСтраховойНомерПФРПриИзменении(Форма, Элемент);
	ПроверитьУникальностьФизическогоЛица(Форма, "СтраховойНомерПФР");
	
КонецПроцедуры

// Обработчик события "ПриИзменении".
// Параметры:
//		Форма - ФормаКлиентскогоПриложения - форма документа.
Процедура ДокументыФизическихЛицВидДокументаПриИзменении(Форма) Экспорт
	
	СотрудникиКлиентБазовый.ДокументыФизическихЛицВидДокументаПриИзменении(Форма);
	ПроверитьУникальностьФизическогоЛица(Форма, "Документ");
	
КонецПроцедуры

// Обработчик события "ПриИзменении".
// Параметры:
//		Форма - ФормаКлиентскогоПриложения - форма документа.
//		Элемент - ПолеВвода - элемент формы.
Процедура ДокументыФизическихЛицНомерПриИзменении(Форма, Элемент) Экспорт
	
	СотрудникиКлиентБазовый.ДокументыФизическихЛицНомерПриИзменении(Форма, Элемент);
	ПроверитьУникальностьФизическогоЛица(Форма, "Документ");
	
КонецПроцедуры

Процедура ПроверитьУникальностьФизическогоЛица(Форма, ПроверяемыеИдентификатор) Экспорт
	
	Если ПроверяемыеИдентификатор = "ИНН"
		И НЕ ЗначениеЗаполнено(Форма.ФизическоеЛицо.ИНН) Тогда
		Возврат;
	КонецЕсли; 
	
	Если ПроверяемыеИдентификатор = "СтраховойНомерПФР"
		И НЕ ЗначениеЗаполнено(Форма.ФизическоеЛицо.СтраховойНомерПФР) Тогда
		Возврат;
	КонецЕсли; 
	
	Если ПроверяемыеИдентификатор = "Документ"
		И (НЕ ЗначениеЗаполнено(Форма.ДокументыФизическихЛиц.ВидДокумента)
		ИЛИ НЕ ЗначениеЗаполнено(Форма.ДокументыФизическихЛиц.Номер)) Тогда
		Возврат;
	КонецЕсли; 
	
	РезультатыПроверки = СотрудникиВызовСервераРасширенный.РезультатыПроверкиУникальностиФизическогоЛица(
							Форма.ФизическоеЛицоСсылка,
							?(ПроверяемыеИдентификатор = "ИНН", Форма.ФизическоеЛицо.ИНН, ""),
							?(ПроверяемыеИдентификатор = "СтраховойНомерПФР", Форма.ФизическоеЛицо.СтраховойНомерПФР, ""),
							?(ПроверяемыеИдентификатор = "Документ", Форма.ДокументыФизическихЛиц.ВидДокумента, ПредопределенноеЗначение("Справочник.ВидыДокументовФизическихЛиц.ПустаяСсылка")),
							?(ПроверяемыеИдентификатор = "Документ", Форма.ДокументыФизическихЛиц.Серия, ""),
							?(ПроверяемыеИдентификатор = "Документ", Форма.ДокументыФизическихЛиц.Номер, ""));
							
	Если Форма.Параметры.Свойство("Ключ") Тогда
		ВедущийОбъект = Форма.Параметры.Ключ;
	Иначе
		ВедущийОбъект = Форма.ВладелецФормы.Параметры.Ключ;
	КонецЕсли;
	
	ВызовИзФормыСотрудника = ТипЗнч(ВедущийОбъект) = Тип("СправочникСсылка.Сотрудники");
							
	Если НЕ РезультатыПроверки.ФизическоеЛицоУникально Тогда
		
		ДанныеФизическихЛицДоступны = РезультатыПроверки.ДанныеФизическихЛицДоступны;
		
		Если ДанныеФизическихЛицДоступны И ВедущийОбъект.Пустая() Тогда
			
			ПараметрыОткрытия = Новый Структура("ЗаголовокФормы,ТекстИнформационнойНадписи,ДанныеФизическихЛиц");
			
			Если РезультатыПроверки.ДанныеФизическихЛиц.Количество() = 1 Тогда
				
				ПараметрыОткрытия.ЗаголовокФормы = НСтр("ru='Найден человек с похожими данными'");
				
				Если ВызовИзФормыСотрудника Тогда
					
					ПараметрыОткрытия.ТекстИнформационнойНадписи = 
						НСтр("ru='Если принимаете на работу того же человека (например, при повторном приеме на работу) нажмите ""Да, это тот, кто мне нужен"".
							|Если это другой человек, нажмите ""Отмена"" и обратитесь к администратору информационной системы для устранения проблемы.'");
							
				Иначе
					
					ПараметрыОткрытия.ТекстИнформационнойНадписи = 
						НСтр("ru='Если вводите данные того же человека нажмите ""Да, это тот, кто мне нужен"".
							|Если это другой человек, нажмите ""Отмена"" и обратитесь к администратору информационной системы для устранения проблемы.'");
							
				КонецЕсли;
				
			Иначе
				
				ПараметрыОткрытия.ЗаголовокФормы = НСтр("ru='Найдены люди с похожими данными.'");
				
				Если ВызовИзФормыСотрудника Тогда
					
					ПараметрыОткрытия.ТекстИнформационнойНадписи = 
						НСтр("ru='Если принимаете на работу одного из приведенных в списке людей (например, при повторном приеме на работу), выберите его и нажмите ""Отмеченный человек тот, кто мне нужен"".
							|Если это другой человек, нажмите ""Отмена"" и обратитесь к администратору информационной системы для устранения проблемы.'");
							
				Иначе
					
					ПараметрыОткрытия.ТекстИнформационнойНадписи = 
						НСтр("ru='Если вводите данные  одного из приведенных в списке людей, выберите его и нажмите ""Отмеченный человек тот, кто мне нужен "".
							|Если это другой человек, ""Отмена"" и обратитесь к администратору информационной системы для устранения проблемы.'");
							
				КонецЕсли;
				
			КонецЕсли;
			
			ОписаниеПредметовПроверки = "";
			
			Если РезультатыПроверки.СообщенияПроверки.Количество() = 1 Тогда
				
				ОписаниеПредметовПроверки = РезультатыПроверки.СообщенияПроверки[0].ТекстСообщенияОбОшибке;
				
				Если РезультатыПроверки.ДанныеФизическихЛиц.Количество() > 1 Тогда
					
					ОписаниеПредметовПроверки = СтрЗаменить(ОписаниеПредметовПроверки,
						НСтр("ru = 'Найдена запись о человеке, имеющем такой же'"),
						НСтр("ru = 'Найдены записи о людях, имеющих такой же'"));
					
				КонецЕсли;
				
			Иначе
				
				Для каждого СообщениеПроверки Из РезультатыПроверки.СообщенияПроверки Цикл
					
					Если СообщениеПроверки.ИмяПоля = "ИНН" Тогда
						
						ОписаниеПредметовПроверки = ?(ПустаяСтрока(ОписаниеПредметовПроверки), "", ОписаниеПредметовПроверки + ", ") 
							+ СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
								НСтр("ru='ИНН (%1)'"),
								Форма.ФизическоеЛицо.ИНН);
						
					ИначеЕсли СообщениеПроверки.ИмяПоля = "СтраховойНомерПФР" Тогда
						
						ОписаниеПредметовПроверки = ?(ПустаяСтрока(ОписаниеПредметовПроверки), "", ОписаниеПредметовПроверки + ", ")
							+ СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
								НСтр("ru='СНИЛС (%1)'"),
								Форма.ФизическоеЛицо.СтраховойНомерПФР);
						
					Иначе
						
						ОписаниеПредметовПроверки = ?(ПустаяСтрока(ОписаниеПредметовПроверки), "", ОписаниеПредметовПроверки + ", ")
							+ СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
								НСтр("ru='документом, удостоверяющим личность'"),
								Форма.ДокументыФизическихЛиц.ВидДокумента,
								?(ПустаяСтрока(Форма.ДокументыФизическихЛиц.Серия), "", Форма.ДокументыФизическихЛиц.Серия),
								Форма.ДокументыФизическихЛиц.Номер);
						
					КонецЕсли;
					
				КонецЦикла;
				
				Если РезультатыПроверки.ДанныеФизическихЛиц.Количество() = 1 Тогда
					
					ОписаниеПредметовПроверки = НСтр("ru='Найдена запись о человеке, имеющем такие же'")
						+ " " + ОписаниеПредметовПроверки;
					
				Иначе
						
					ОписаниеПредметовПроверки = НСтр("ru='Найдены записи о людях, имеющих такие же'")
						+ " " + ОписаниеПредметовПроверки;
						
				КонецЕсли;
				
			КонецЕсли;
			
			ПараметрыОткрытия.ТекстИнформационнойНадписи = ОписаниеПредметовПроверки + "."
				+ Символы.ПС + ПараметрыОткрытия.ТекстИнформационнойНадписи;
			
			ПараметрыОткрытия.ДанныеФизическихЛиц = РезультатыПроверки.ДанныеФизическихЛиц;
			ПараметрыОткрытия.Вставить("СкрытьКомандуДругойЧеловек", Истина);
			
			РезультатВыбора = Неопределено;
				
			Если РезультатВыбора <> Неопределено Тогда
				
				Если ВызовИзФормыСотрудника Тогда
					
					СотрудникиКлиент.УстановитьФизическоеЛицоВФормеСотрудника(Форма, РезультатВыбора);
					
				Иначе
					
					Форма.Модифицированность = Ложь;
					Форма.Закрыть();
					
					ОткрытьФорму("Справочник.ФизическиеЛица.ФормаОбъекта", Новый Структура("Ключ", РезультатВыбора));
					
				КонецЕсли;
				
			КонецЕсли;
			
		Иначе
			
			ТекстПредупреждения = РезультатыПроверки.СообщенияПроверки[0].ТекстСообщенияОбОшибке;
			
			Если НЕ ВедущийОбъект.Пустая() 
				И РезультатыПроверки.ДоступнаРольСохранениеДанныхЗадвоенныхФизическихЛиц Тогда
				ТекстПредупреждения = ТекстПредупреждения + Символы.ПС + Символы.ПС
					+ НСтр("ru = 'Не рекомендуется записывать дублирующиеся личные данные.
						|Тем не менее, можно записать текущие личные данные после чего принять меры для устранения проблемы.'");
			Иначе
				ТекстПредупреждения = ТекстПредупреждения + Символы.ПС + Символы.ПС
					+ СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
						НСтр("ru = 'Записать %1 с этими личными данными невозможно.
							|Внесите изменения или обратитесь к администратору информационной системы для устранения проблемы.'"),
						Форма.ФизическоеЛицо.ФИО);
			КонецЕсли;
			
			ПоказатьПредупреждение(Неопределено,ТекстПредупреждения);
			
		КонецЕсли;
			
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти