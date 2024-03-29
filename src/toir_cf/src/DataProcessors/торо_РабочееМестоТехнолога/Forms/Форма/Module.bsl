#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ТипПоиска = "Наименование";
	
	ТекСтруктураИерархии = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
	"НастройкиТОиР",
	"ОсновнаяСтруктураИерархии",
	Истина);
	
	Инициатор = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
	"НастройкиТОиР",
	"ОсновнойИнициаторДефекта",
	Неопределено);
	
	ИерархияДляВводаНовыхОР = Константы.торо_ИерархияДляВводаНовыхОР.Получить();
	ИспользоватьКартинкиТОР = Константы.торо_ИспользоватьКартинкиТиповыхОбъектов.Получить();
		
	Если НЕ ЗначениеЗаполнено(ТекСтруктураИерархии) Тогда
		ТекСтруктураИерархии = ИерархияДляВводаНовыхОР;
	КонецЕсли;
	
	ПолучатьСтатусыВУчете = ПолучитьФункциональнуюОпцию("торо_ИспользоватьДокументыПринятияИСписанияОборудования"); 
	СписокСтатусов.ЗагрузитьЗначения(торо_СтатусыОРВУчете.СписокСтатусовДляПодбора());

	ОбработатьИзменениеИерархииНаСервере();
	
	ПравоИнтерактивнаяПометкаУдаления = ПравоДоступа("ИнтерактивнаяПометкаУдаления", Метаданные.Справочники.торо_ОбъектыРемонта);
	ПравоРедактирование = ПравоДоступа("Редактирование", Метаданные.Справочники.торо_ОбъектыРемонта);
	ПравоИнтерактивноеДобавление = Ложь;
	
	РазрешитьПеретаскиваниеОРВИерархии = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("НастройкиТОиР", "РазрешитьПеретаскиваниеОРВИерархии", Истина);
	
	Если ИспользоватьКартинкиТОР Тогда 
		Элементы.Дерево.ПутьКДаннымКартинкиСтроки = "Дерево.КартинкаОтображаемая";
	Иначе 
		Элементы.Дерево.ПутьКДаннымКартинкиСтроки = "Дерево.Картинка";
	КонецЕсли;
	 
	ИсключитьАвтоматические = Истина;
	УстановитьПараметрыЗапросовНаСервере(ТекСтруктураИерархии);

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если НЕ ЗначениеЗаполнено(ИерархияДляВводаНовыхОР) Тогда
		Отказ = Истина;
		ПоказатьПредупреждение(Неопределено, Новый ФорматированнаяСтрока(НСтр("ru = 'Не заполнено значение константы ""Иерархия для ввода новых объектов ремонта""!'"),,,,"e1cib/app/Обработка.торо_ПанельАдминистрированияТОиР"));
		Возврат;
	КонецЕсли;
	
	торо_РаботаСИерархией20Клиент.УстановитьДоступностьКомандФормы(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ИзмененаПометкаУдаленияОР" Тогда
		торо_РаботаСИерархией20Клиент.ОбработкаОповещенияОбИзмененииПометкиУдаленияОбъектаРемонта(ЭтаФорма, Параметр);
		Если ИспользоватьКартинкиТОР Тогда
			ОбновитьКартинкиЭлементовДереваНаСервере();
		КонецЕсли;
	ИначеЕсли ИмяСобытия = "ЗаписанОбъектРемонта" Тогда
		торо_РаботаСИерархией20Клиент.ОбработкаОповещенияОЗаписиОбъектаРемонта(ЭтаФорма, Параметр);
		Если ИспользоватьКартинкиТОР Тогда
			ОбновитьКартинкиЭлементовДереваНаСервере();
		КонецЕсли;
	ИначеЕсли ИмяСобытия = "ИзмененПорядокОбъектаРемонта" Тогда
		Если Параметр.СтруктураИерархии = ТекСтруктураИерархии Тогда
			торо_НастройкаПорядкаЭлементовКлиент.ИзменитьПорядокЭлементаВДереве(ЭтаФорма, Параметр);
		КонецЕсли;
	ИначеЕсли ИмяСобытия = "ИзмененаСтруктураИерархииОР" Тогда
		Если Параметр = Неопределено ИЛИ Параметр = ТекСтруктураИерархии Тогда
			торо_РаботаСИерархией20Клиент.ОбновитьДеревоИерархии(ЭтаФорма);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ТипПоискаПриИзменении(Элемент)
	ВыполнитьПоискВСпискеОР(ЗначениеПоиска);
КонецПроцедуры

&НаКлиенте
Процедура ТипПоискаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если ВыбранноеЗначение <> ТипПоиска Тогда
		ОтменитьПоискВПискеОР();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗначениеПоискаПриИзменении(Элемент)
	ВыполнитьПоискВСпискеОР(ЗначениеПоиска);
КонецПроцедуры

&НаКлиенте
Процедура ЗначениеПоискаОчистка(Элемент, СтандартнаяОбработка)
	ОтменитьПоискВПискеОР();
КонецПроцедуры

&НаКлиенте
Процедура ЗначениеПоискаАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	
	Если Ожидание > 0 Тогда
		ВыполнитьПоискВСпискеОР(Текст);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ЗначениеПоискаОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	ЗначениеПоиска = Текст;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДерево

&НаКлиенте
Процедура ДеревоВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ОценкаПроизводительностиКлиент.ЗамерВремени(ПредопределенноеЗначение("Справочник.КлючевыеОперации.торо_ОткрытиеФормыОбъектовРемонта"),,Истина);
	
	СтандартнаяОбработка = Ложь;
	торо_РаботаСИерархией20Клиент.ПередНачаломИзменения(Элемент, Ложь, ЭтаФорма);	
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	торо_РаботаСИерархией20Клиент.ОбработатьВыборОРДляДерева(ЭтаФорма,ВыбранноеЗначение);
КонецПроцедуры

&НаКлиенте
Процедура ДеревоПриАктивизацииСтроки(Элемент)
	
	ТекущиеДанные = Элементы.Дерево.ТекущиеДанные;
	ТекущийОбъект = ?(ТекущиеДанные = Неопределено, Неопределено, ТекущиеДанные.Ссылка);
	УстановитьПараметрыЗапросовНаСервере(ТекСтруктураИерархии, ТекущийОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоПередНачаломИзменения(Элемент, Отказ)
	торо_РаботаСИерархией20Клиент.ПередНачаломИзменения(Элемент, Отказ, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ДеревоПередРазворачиванием(Элемент, Строка, Отказ)
	
	торо_РаботаСИерархией20Клиент.ДеревоПередРазворачиванием(Дерево, Строка, СтруктураПараметровИерархии, ПолучатьСтатусыВУчете, СписокСтатусов);
	Если ИспользоватьКартинкиТОР Тогда
		ОбновитьКартинкиЭлементовДереваНаСервере(Строка);
	КонецЕсли;
	ВыделитьНесоответствующиеВДереве(Дерево);
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоНачалоПеретаскивания(Элемент, ПараметрыПеретаскивания, Выполнение)
	Выполнение = РазрешитьПеретаскиваниеОРВИерархии;
КонецПроцедуры

&НаКлиенте
Процедура ДеревоПроверкаПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	торо_РаботаСИерархией20Клиент.ПроверкаПеретаскивания(ЭтаФорма, Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Истина);
КонецПроцедуры

&НаКлиенте
Процедура ДеревоПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	торо_РаботаСИерархией20Клиент.ОбработкаПеретаскивания(ЭтаФорма, Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Истина);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ОценкаПроизводительностиКлиент.ЗамерВремени(ПредопределенноеЗначение("Справочник.КлючевыеОперации.торо_ОткрытиеФормыОбъектовРемонта"),,Истина);
	
	СтандартнаяОбработка = Ложь;
	Если Не Элементы.Список.ТекущиеДанные = Неопределено Тогда
		ПоказатьЗначение(Неопределено, Элементы.Список.ТекущиеДанные.Ссылка);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	ТекущийОбъект = ?(ТекущиеДанные = Неопределено, Неопределено, ТекущиеДанные.Ссылка);
	УстановитьПараметрыЗапросовНаСервере(ТекСтруктураИерархии, ТекущийОбъект);
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура СписокПриПолученииДанныхНаСервере(ИмяЭлемента, Настройки, Строки)
	
	ИспользоватьКартинкиТОР = Константы.торо_ИспользоватьКартинкиТиповыхОбъектов.Получить();
	торо_РаботаСИерархией20.СписокПриПолученииДанныхНаСервере(ИмяЭлемента, Настройки, Строки, ИспользоватьКартинкиТОР);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписокНесоответствующихОР
&НаКлиенте
Процедура СписокНесоответствующихОРВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ТекущиеДанные = Элемент.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено И ЗначениеЗаполнено(ТекущиеДанные.ОбъектРемонта) Тогда 
		торо_РаботаСИерархией20Клиент.ВыделитьОРВДереве(ЭтаФорма, ТекущиеДанные.ОбъектРемонта);
	КонецЕсли;
		
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ДобавитьНовоеФМ(Команда)
	
	ТекущиеДанныеДерева = Элементы.Дерево.ТекущиеДанные;
	ТекущийРодитель = ?(ТекущиеДанныеДерева = Неопределено, Неопределено, ТекущиеДанныеДерева.Ссылка);
	ТекущаяСсылка = ?(ТекущиеДанныеДерева = Неопределено, Неопределено, ТекущиеДанныеДерева.Ссылка);
	ИндексКартинки = ?(ТекущиеДанныеДерева = Неопределено, Неопределено, ТекущиеДанныеДерева.Картинка);
	
	торо_РаботаСИерархией20Клиент.СоздатьОбъектРемонтаСОткрытиемФормы(ЭтаФорма, Ложь, Ложь, ТекущийРодитель, ТекущаяСсылка, ИндексКартинки, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьИзДругойИерархии(Команда)
	
	ТекущиеДанныеДерева = Элементы.Дерево.ТекущиеДанные;
	ТекущаяСсылка = ?(ТекущиеДанныеДерева = Неопределено, Неопределено, ТекущиеДанныеДерева.Ссылка);
	
	торо_РаботаСИерархией20Клиент.ВыбратьИерархиюИзКоторойДобавитьОР(ЭтаФорма, ТекущаяСсылка, "Дерево", Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьСоответствиеОграничениям(Команда)
	
	СписокНесоответствующихОР.Очистить();
	СнятьВыделениеНесоответствующихВДереве();

	ТекущиеДанные = Элементы.Дерево.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено И ЗначениеЗаполнено(ТекущиеДанные.Ссылка) Тогда
		
		МассивОбъектов = Новый Массив;
		Если ТипЗнч(ТекущиеДанные.Ссылка) = Тип("СправочникСсылка.торо_СтруктурыОР") Тогда
			СтрокиДерева = Дерево.ПолучитьЭлементы();
			Если СтрокиДерева.Количество() > 0 Тогда
				Для каждого СтрокаДерева Из СтрокиДерева[0].ПолучитьЭлементы() Цикл
					МассивОбъектов.Добавить(СтрокаДерева.ОбъектРемонта);
				КонецЦикла;
			КонецЕсли;
		ИначеЕсли ТипЗнч(ТекущиеДанные.Ссылка) = Тип("СправочникСсылка.торо_ОбъектыРемонта") Тогда
			МассивОбъектов.Добавить(ТекущиеДанные.Ссылка);
		КонецЕсли;
		
		МассивПодчиненных = торо_РаботаСИерархией20.ПолучитьМассивПодчиненныхОбъектов(МассивОбъектов, ТекСтруктураИерархии);
		Если МассивПодчиненных.Количество() > 0 Тогда
			ЗаполнитьСписокНесоответствующихОР(МассивПодчиненных);
			ВыделитьНесоответствующиеВДереве(ТекущиеДанные);
		КонецЕсли;
		
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Оповещение о закрытии, вызывается при выполнении команды "Настройка иерархии".
&НаКлиенте
Процедура НастройкаИерархииЗавершение(ВыбранноеЗначение, ДополнительныеПараметры) Экспорт
	
	Если ВыбранноеЗначение <> Неопределено Тогда
		ТекСтруктураИерархии = ВыбранноеЗначение;
		ОбработатьИзменениеИерархииНаСервере();
		торо_РаботаСИерархией20Клиент.ОбработатьИзменениеИерархииНаКлиенте(ЭтаФорма);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработатьИзменениеИерархииНаСервере()
	
	торо_РаботаСИерархией20.ЗаполнитьПараметрыИерархии(ЭтаФорма);
	СтруктураПараметровИерархии.КонечныеЭлементыВДереве = Истина;
	ПустойРодитель = торо_РаботаСИерархией20.ПустойРодительПоСтруктуреИерархии(СтруктураПараметровИерархии);
	торо_РаботаСИерархией20.УстановитьЗапросВСпискеПоИерархии(Список, СтруктураПараметровИерархии, ПустойРодитель, ПолучатьСтатусыВУчете);
	торо_РаботаСИерархией20КлиентСервер.УстановитьОтборСпискаПоРодителю(Список, ПустойРодитель, Ложь);
	торо_РаботаСИерархией20КлиентСервер.НачатьЗаполнениеДереваИерархии(Дерево, СтруктураПараметровИерархии, ПустойРодитель, ПолучатьСтатусыВУчете, СписокСтатусов);
	
	Если ИспользоватьКартинкиТОР Тогда
		ОбновитьКартинкиЭлементовДереваНаСервере();
	КонецЕсли;

КонецПроцедуры

&НаСервере 
Процедура ОбновитьКартинкиЭлементовДереваНаСервере(ИдентификаторСтроки = 0)
	торо_РаботаСИерархией20.ОбновитьКартинкиЭлементовДереваНаСервере(Дерево, ИдентификаторСтроки);
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьПоискВСпискеОР(Текст)
	
	Если СтрДлина(Текст) = 0 Тогда
		ОтменитьПоискВПискеОР();
		Возврат;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ТипПоиска) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, ТипПоиска, Текст, ВидСравненияКомпоновкиДанных.Содержит,,Истина);
		Если ПолучатьСтатусыВУчете Тогда
			ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "СтатусВУчете", СписокСтатусов, 
				ВидСравненияКомпоновкиДанных.ВСписке,,Истина);	
		КонецЕсли;
	КонецЕсли;
	
	Элементы.СтраницыГруппаЛевая.ТекущаяСтраница = Элементы.ГруппаТаблицаПоиска;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтменитьПоискВПискеОР()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, ТипПоиска, "", ВидСравненияКомпоновкиДанных.Содержит,,Ложь);
	Элементы.СтраницыГруппаЛевая.ТекущаяСтраница = Элементы.ГруппаДерево;
	
КонецПроцедуры

&НаСервере 
Процедура УстановитьПараметрыЗапросовНаСервере(ТекСтруктураИерархии, ТекОбъект = Неопределено)
	
	ОбъектФМ = Неопределено;
	ТиповойОР = Неопределено;
	
	Если ТекОбъект <> Неопределено И ТипЗнч(ТекОбъект) = Тип("СправочникСсылка.торо_ОбъектыРемонта") Тогда
		Если ТекОбъект.ТипОбъекта = Перечисления.торо_ТипыОбъектовRCM.ФункциональноеМесто Тогда
			ОбъектФМ = ТекОбъект;
		ИначеЕсли ТекОбъект.ТипОбъекта = Перечисления.торо_ТипыОбъектовRCM.Объект Тогда
			ОбъектФМ = ПолучитьФункциональноеМесто(ТекОбъект);
		КонецЕсли;
		
		Если ЗначениеЗаполнено(ОбъектФМ) И НЕ ОбъектФМ.ЭтоГруппа Тогда
			ТиповойОР = ОбъектФМ.ТиповойОР;
		КонецЕсли;
	КонецЕсли;
	
	СписокОграничений.Параметры.УстановитьЗначениеПараметра("ФункциональноеМесто", ОбъектФМ);
	СписокОграничений.Параметры.УстановитьЗначениеПараметра("ТекущаяИерархия", ТекСтруктураИерархии);
	СписокОграничений.Параметры.УстановитьЗначениеПараметра("ТиповойОР", ТиповойОР);
	ЗаполнитьСписокХарактеристик(ТекОбъект);
	
КонецПроцедуры

&НаСервере
Функция ПолучитьФункциональноеМесто(ОбъектРемонта)
	Возврат торо_РаботаСИерархией20.ПолучитьТекущегоРодителяВИерархии(ОбъектРемонта, ТекСтруктураИерархии,, Истина, Истина);
КонецФункции

&НаСервере
Процедура ЗаполнитьСписокХарактеристик(ОбъектРемонта = Неопределено)
	
	СписокХарактеристик.Очистить();
	
	Если ЗначениеЗаполнено(ОбъектРемонта) И ТипЗнч(ОбъектРемонта) = Тип("СправочникСсылка.торо_ОбъектыРемонта") 
		И НЕ ОбъектРемонта.ЭтоГруппа И ОбъектРемонта.ТипОбъекта = Перечисления.торо_ТипыОбъектовRCM.Объект Тогда
		
		ФункциональноеМесто = ПолучитьФункциональноеМесто(ОбъектРемонта);
		ТиповоеФМ = ?(ЗначениеЗаполнено(ФункциональноеМесто) И НЕ ФункциональноеМесто.ЭтоГруппа, ФункциональноеМесто.ТиповойОР, Неопределено);
		
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ
		               |	торо_ТиповыеОРДополнительныеРеквизиты.Свойство КАК Свойство,
		               |	торо_ТиповыеОРДополнительныеРеквизиты.Значение КАК Значение
		               |ПОМЕСТИТЬ ВТ_ИзТипового
		               |ИЗ
		               |	Справочник.торо_ТиповыеОР.ДополнительныеРеквизиты КАК торо_ТиповыеОРДополнительныеРеквизиты
		               |ГДЕ
		               |	торо_ТиповыеОРДополнительныеРеквизиты.Ссылка = &ТиповойОР
		               |;
		               |
		               |////////////////////////////////////////////////////////////////////////////////
		               |ВЫБРАТЬ РАЗРЕШЕННЫЕ
		               |	торо_ОбъектыРемонтаДополнительныеРеквизиты.Свойство КАК Свойство,
		               |	торо_ОбъектыРемонтаДополнительныеРеквизиты.Значение КАК Значение
		               |ПОМЕСТИТЬ ВТ_ИзОР
		               |ИЗ
		               |	Справочник.торо_ОбъектыРемонта.ДополнительныеРеквизиты КАК торо_ОбъектыРемонтаДополнительныеРеквизиты
		               |ГДЕ
		               |	торо_ОбъектыРемонтаДополнительныеРеквизиты.Ссылка = &ЕдиницаОборудования
		               |;
		               |
		               |////////////////////////////////////////////////////////////////////////////////
		               |ВЫБРАТЬ
		               |	ЕСТЬNULL(ВТ_ИзОР.Свойство, ВТ_ИзТипового.Свойство) КАК Характеристика,
		               |	ВЫБОР
		               |		КОГДА ВТ_ИзОР.Свойство ЕСТЬ NULL
		               |			ТОГДА ВТ_ИзТипового.Значение
		               |		ИНАЧЕ ВТ_ИзОР.Значение
		               |	КОНЕЦ КАК Значение
		               |ПОМЕСТИТЬ ВТ_ДопРеквизиты
		               |ИЗ
		               |	ВТ_ИзТипового КАК ВТ_ИзТипового
		               |		ПОЛНОЕ СОЕДИНЕНИЕ ВТ_ИзОР КАК ВТ_ИзОР
		               |		ПО ВТ_ИзТипового.Свойство = ВТ_ИзОР.Свойство
		               |;
		               |
		               |////////////////////////////////////////////////////////////////////////////////
		               |ВЫБРАТЬ РАЗРЕШЕННЫЕ
		               |	МАКСИМУМ(торо_ЗначенияКонтролируемыхПоказателейСрезПоследних.Период) КАК Период,
		               |	торо_ЗначенияКонтролируемыхПоказателейСрезПоследних.ОбъектРемонта КАК ОбъектРемонта,
		               |	торо_ЗначенияКонтролируемыхПоказателейСрезПоследних.Показатель КАК Показатель
		               |ПОМЕСТИТЬ ВТ_МаксПериод
		               |ИЗ
		               |	РегистрСведений.торо_ЗначенияКонтролируемыхПоказателей.СрезПоследних(, ОбъектРемонта = &ЕдиницаОборудования) КАК торо_ЗначенияКонтролируемыхПоказателейСрезПоследних
		               |
		               |СГРУППИРОВАТЬ ПО
		               |	торо_ЗначенияКонтролируемыхПоказателейСрезПоследних.ОбъектРемонта,
		               |	торо_ЗначенияКонтролируемыхПоказателейСрезПоследних.Показатель
		               |
		               |ИНДЕКСИРОВАТЬ ПО
		               |	Период,
		               |	ОбъектРемонта,
		               |	Показатель
		               |;
		               |
		               |////////////////////////////////////////////////////////////////////////////////
		               |ВЫБРАТЬ РАЗРЕШЕННЫЕ
		               |	ВТ_МаксПериод.Показатель КАК Характеристика,
		               |	торо_ЗначенияКонтролируемыхПоказателей.Значение КАК Значение
		               |ПОМЕСТИТЬ ВТ_Показатели
		               |ИЗ
		               |	ВТ_МаксПериод КАК ВТ_МаксПериод
		               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_ЗначенияКонтролируемыхПоказателей КАК торо_ЗначенияКонтролируемыхПоказателей
		               |		ПО ВТ_МаксПериод.Период = торо_ЗначенияКонтролируемыхПоказателей.Период
		               |			И ВТ_МаксПериод.ОбъектРемонта = торо_ЗначенияКонтролируемыхПоказателей.ОбъектРемонта
		               |			И ВТ_МаксПериод.Показатель = торо_ЗначенияКонтролируемыхПоказателей.Показатель
		               |;
		               |
		               |////////////////////////////////////////////////////////////////////////////////
		               |ВЫБРАТЬ
		               |	ВТ_ДопРеквизиты.Характеристика КАК Характеристика,
		               |	ВТ_ДопРеквизиты.Значение КАК Значение
		               |ПОМЕСТИТЬ ВТ_ХарактеристикиОР
		               |ИЗ
		               |	ВТ_ДопРеквизиты КАК ВТ_ДопРеквизиты
		               |
		               |ОБЪЕДИНИТЬ ВСЕ
		               |
		               |ВЫБРАТЬ
		               |	ВТ_Показатели.Характеристика,
		               |	ВТ_Показатели.Значение
		               |ИЗ
		               |	ВТ_Показатели КАК ВТ_Показатели
		               |;
		               |
		               |////////////////////////////////////////////////////////////////////////////////
		               |ВЫБРАТЬ РАЗРЕШЕННЫЕ
		               |	ОграниченияИзТипового.Ограничение КАК Ограничение
		               |ПОМЕСТИТЬ ВТ_Ограничения
		               |ИЗ
		               |	Справочник.торо_ТиповыеОР.ОграниченияНаХарактеристикиОборудования КАК ОграниченияИзТипового
		               |ГДЕ
		               |	ОграниченияИзТипового.Ссылка = &ТиповоеФМ
		               |	И (ОграниченияИзТипового.СтруктураИерархии = &ТекущаяИерархия
		               |			ИЛИ ОграниченияИзТипового.СтруктураИерархии = ЗНАЧЕНИЕ(Справочник.торо_СтруктурыОР.ПустаяСсылка))
		               |
		               |ОБЪЕДИНИТЬ
		               |
		               |ВЫБРАТЬ
		               |	торо_ОграниченияНаХарактеристикиОборудования.Ограничение
		               |ИЗ
		               |	РегистрСведений.торо_ОграниченияНаХарактеристикиОборудования КАК торо_ОграниченияНаХарактеристикиОборудования
		               |ГДЕ
		               |	торо_ОграниченияНаХарактеристикиОборудования.ФункциональноеМесто = &ФункциональноеМесто
		               |	И (торо_ОграниченияНаХарактеристикиОборудования.СтруктураИерархии = &ТекущаяИерархия
		               |			ИЛИ торо_ОграниченияНаХарактеристикиОборудования.СтруктураИерархии = ЗНАЧЕНИЕ(Справочник.торо_СтруктурыОР.ПустаяСсылка))
		               |;
		               |
		               |////////////////////////////////////////////////////////////////////////////////
		               |ВЫБРАТЬ РАЗРЕШЕННЫЕ
		               |	торо_Ограничения.Характеристика КАК Характеристика,
		               |	торо_Ограничения.Значение КАК Значение,
		               |	торо_Ограничения.ВидСравнения КАК ВидСравнения
		               |ПОМЕСТИТЬ ВТ_СписокОграниченийСГруппами
		               |ИЗ
		               |	Справочник.торо_ОграниченияНаХарактеристикиОборудования.СписокОграничений КАК торо_Ограничения
		               |ГДЕ
		               |	торо_Ограничения.Ссылка В
		               |			(ВЫБРАТЬ
		               |				ВТ_Ограничения.Ограничение КАК Ограничение
		               |			ИЗ
		               |				ВТ_Ограничения КАК ВТ_Ограничения)
		               |;
		               |
		               |////////////////////////////////////////////////////////////////////////////////
		               |ВЫБРАТЬ РАЗРЕШЕННЫЕ
		               |	СписокХарактеристикГруппы.Характеристика КАК Характеристика,
		               |	ВТ_СписокОграниченийСГруппами.ВидСравнения КАК ВидСравнения,
		               |	ВТ_СписокОграниченийСГруппами.Значение КАК Значение
		               |ПОМЕСТИТЬ ВТ_СписокОграничений
		               |ИЗ
		               |	ВТ_СписокОграниченийСГруппами КАК ВТ_СписокОграниченийСГруппами
		               |		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ПланВидовХарактеристик.торо_ГруппыХарактеристикОборудования.СписокХарактеристик КАК СписокХарактеристикГруппы
		               |		ПО ВТ_СписокОграниченийСГруппами.Характеристика = СписокХарактеристикГруппы.Ссылка
		               |ГДЕ
		               |	ТИПЗНАЧЕНИЯ(ВТ_СписокОграниченийСГруппами.Характеристика) = ТИП(ПланВидовХарактеристик.торо_ГруппыХарактеристикОборудования)
		               |
		               |ОБЪЕДИНИТЬ
		               |
		               |ВЫБРАТЬ
		               |	ВТ_СписокОграниченийСГруппами.Характеристика,
		               |	ВТ_СписокОграниченийСГруппами.ВидСравнения,
		               |	ВТ_СписокОграниченийСГруппами.Значение
		               |ИЗ
		               |	ВТ_СписокОграниченийСГруппами КАК ВТ_СписокОграниченийСГруппами
		               |ГДЕ
		               |	НЕ ТИПЗНАЧЕНИЯ(ВТ_СписокОграниченийСГруппами.Характеристика) = ТИП(ПланВидовХарактеристик.торо_ГруппыХарактеристикОборудования)
		               |;
		               |
		               |////////////////////////////////////////////////////////////////////////////////
		               |ВЫБРАТЬ
		               |	ВТ_ХарактеристикиОР.Характеристика КАК Характеристика,
		               |	ВТ_ХарактеристикиОР.Значение КАК Значение,
		               |	ВЫБОР
		               |		КОГДА СписокОграничений.Характеристика ЕСТЬ NULL
		               |			ТОГДА ИСТИНА
		               |		КОГДА СписокОграничений.ВидСравнения = ЗНАЧЕНИЕ(Перечисление.торо_ВидыСравнения.Равно)
		               |				И СписокОграничений.Значение = ВТ_ХарактеристикиОР.Значение
		               |			ТОГДА ИСТИНА
		               |		КОГДА СписокОграничений.ВидСравнения = ЗНАЧЕНИЕ(Перечисление.торо_ВидыСравнения.НеРавно)
		               |				И СписокОграничений.Значение <> ВТ_ХарактеристикиОР.Значение
		               |			ТОГДА ИСТИНА
		               |		КОГДА СписокОграничений.ВидСравнения = ЗНАЧЕНИЕ(Перечисление.торо_ВидыСравнения.Больше)
		               |				И ВТ_ХарактеристикиОР.Значение > СписокОграничений.Значение
		               |			ТОГДА ИСТИНА
		               |		КОГДА СписокОграничений.ВидСравнения = ЗНАЧЕНИЕ(Перечисление.торо_ВидыСравнения.БольшеИлиРавно)
		               |				И ВТ_ХарактеристикиОР.Значение >= СписокОграничений.Значение
		               |			ТОГДА ИСТИНА
		               |		КОГДА СписокОграничений.ВидСравнения = ЗНАЧЕНИЕ(Перечисление.торо_ВидыСравнения.Меньше)
		               |				И ВТ_ХарактеристикиОР.Значение < СписокОграничений.Значение
		               |			ТОГДА ИСТИНА
		               |		КОГДА СписокОграничений.ВидСравнения = ЗНАЧЕНИЕ(Перечисление.торо_ВидыСравнения.МеньшеИлиРавно)
		               |				И ВТ_ХарактеристикиОР.Значение <= СписокОграничений.Значение
		               |			ТОГДА ИСТИНА
		               |		ИНАЧЕ ЛОЖЬ
		               |	КОНЕЦ КАК СоответствуетОграничению
		               |ПОМЕСТИТЬ ВТ_Итог
		               |ИЗ
		               |	ВТ_ХарактеристикиОР КАК ВТ_ХарактеристикиОР
		               |		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_СписокОграничений КАК СписокОграничений
		               |		ПО ВТ_ХарактеристикиОР.Характеристика = СписокОграничений.Характеристика
		               |;
		               |
		               |////////////////////////////////////////////////////////////////////////////////
		               |ВЫБРАТЬ
		               |	ВТ_Итог.Характеристика КАК Характеристика,
		               |	МИНИМУМ(ВТ_Итог.СоответствуетОграничению) КАК СоответствуетОграничению,
		               |	МАКСИМУМ(ВТ_Итог.Значение) КАК Значение
		               |ИЗ
		               |	ВТ_Итог КАК ВТ_Итог
		               |
		               |СГРУППИРОВАТЬ ПО
		               |	ВТ_Итог.Характеристика";
		
		Запрос.УстановитьПараметр("ЕдиницаОборудования", ОбъектРемонта);
		Запрос.УстановитьПараметр("ТиповойОР", ОбъектРемонта.ТиповойОР);
		Запрос.УстановитьПараметр("ФункциональноеМесто", ФункциональноеМесто);
		Запрос.УстановитьПараметр("ТиповоеФМ", ТиповоеФМ);
		Запрос.УстановитьПараметр("ТекущаяИерархия", ТекСтруктураИерархии); 
		
		Результат = Запрос.Выполнить();
		
		Если НЕ Результат.Пустой() Тогда
			СписокХарактеристик.Загрузить(Результат.Выгрузить());
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокНесоответствующихОР(МассивОР)

	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц();
	Запрос.Текст = 	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	               	|	торо_РасположениеОРВСтруктуреИерархииСрезПоследних.РодительИерархии КАК РодительИерархии,
	               	|	торо_РасположениеОРВСтруктуреИерархииСрезПоследних.ОбъектИерархии КАК ОбъектИерархии,
	               	|	торо_РасположениеОРВСтруктуреИерархииСрезПоследних.СтруктураИерархии КАК СтруктураИерархии
	               	|ПОМЕСТИТЬ ВТ_ВсеРодители
	               	|ИЗ
	               	|	РегистрСведений.торо_РасположениеОРВСтруктуреИерархии.СрезПоследних(
	               	|			,
	               	|			ОбъектИерархии В (&МассивОР)
	               	|				И СтруктураИерархии = &СтруктураИерархии) КАК торо_РасположениеОРВСтруктуреИерархииСрезПоследних
	               	|ГДЕ
	               	|	торо_РасположениеОРВСтруктуреИерархииСрезПоследних.Удален = ЛОЖЬ
	               	|
	               	|ОБЪЕДИНИТЬ
	               	|
	               	|ВЫБРАТЬ
	               	|	торо_ИерархическиеСтруктурыОР.РодительИерархии,
	               	|	торо_ИерархическиеСтруктурыОР.ОбъектИерархии,
	               	|	торо_ИерархическиеСтруктурыОР.СтруктураИерархии
	               	|ИЗ
	               	|	РегистрСведений.торо_ИерархическиеСтруктурыОР КАК торо_ИерархическиеСтруктурыОР
	               	|ГДЕ
	               	|	торо_ИерархическиеСтруктурыОР.СтруктураИерархии = &СтруктураИерархии
	               	|	И торо_ИерархическиеСтруктурыОР.ОбъектИерархии В(&МассивОР)
	               	|;
	               	|
	               	|////////////////////////////////////////////////////////////////////////////////
	               	|ВЫБРАТЬ
	               	|	ВТ_ВсеРодители.РодительИерархии КАК ФункциональноеМесто,
	               	|	ВТ_ВсеРодители.ОбъектИерархии КАК ОбъектРемонта,
	               	|	ВТ_ВсеРодители.СтруктураИерархии КАК СтруктураИерархии
	               	|ПОМЕСТИТЬ ВТ_ОРДляПроверки
	               	|ИЗ
	               	|	ВТ_ВсеРодители КАК ВТ_ВсеРодители
	               	|ГДЕ
	               	|	НЕ ВТ_ВсеРодители.РодительИерархии.ЭтоГруппа
	               	|	И НЕ ВТ_ВсеРодители.ОбъектИерархии.ЭтоГруппа
	               	|	И ВТ_ВсеРодители.РодительИерархии.ТипОбъекта = ЗНАЧЕНИЕ(Перечисление.торо_ТипыОбъектовRCM.ФункциональноеМесто)
	               	|	И ВТ_ВсеРодители.ОбъектИерархии.ТипОбъекта = ЗНАЧЕНИЕ(Перечисление.торо_ТипыОбъектовRCM.Объект)
	               	|
	               	|ОБЪЕДИНИТЬ ВСЕ
	               	|
	               	|ВЫБРАТЬ
	               	|	ВТ_ВсеРодители.РодительИерархии,
	               	|	ВТ_ВсеРодители.ОбъектИерархии,
	               	|	ЗНАЧЕНИЕ(Справочник.торо_СтруктурыОР.ПустаяСсылка)
	               	|ИЗ
	               	|	ВТ_ВсеРодители КАК ВТ_ВсеРодители
	               	|ГДЕ
	               	|	НЕ ВТ_ВсеРодители.РодительИерархии.ЭтоГруппа
	               	|	И НЕ ВТ_ВсеРодители.ОбъектИерархии.ПометкаУдаления
	               	|	И ВТ_ВсеРодители.РодительИерархии.ТипОбъекта = ЗНАЧЕНИЕ(Перечисление.торо_ТипыОбъектовRCM.ФункциональноеМесто)
	               	|	И ВТ_ВсеРодители.ОбъектИерархии.ТипОбъекта = ЗНАЧЕНИЕ(Перечисление.торо_ТипыОбъектовRCM.Объект)
	               	|
	               	|ИНДЕКСИРОВАТЬ ПО
	               	|	ОбъектРемонта,
					|	ФункциональноеМесто,
					|	СтруктураИерархии
	               	|;
	               	|
	               	|////////////////////////////////////////////////////////////////////////////////
	               	|УНИЧТОЖИТЬ ВТ_ВсеРодители";

	Запрос.УстановитьПараметр("МассивОР", МассивОР);
	Запрос.УстановитьПараметр("СтруктураИерархии", ТекСтруктураИерархии);
	
	Результат = Запрос.Выполнить();

	ТабНесоответствующихОР = торо_РаботаСФункциональнымиМестами.ПолучитьНесоответствующиеОР(Запрос.МенеджерВременныхТаблиц);
	ТабКолонкаОР = ТабНесоответствующихОР.Скопировать(,"ОбъектРемонта");
	СписокНесоответствующихОР.Загрузить(ТабКолонкаОР);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыделитьНесоответствующиеВДереве(ТекущиеДанные)
	
	Для каждого Строка Из СписокНесоответствующихОР Цикл
		СтруктураПоиска = Новый Структура("ОбъектРемонта", Строка.ОбъектРемонта);
		МассивВыделяемыхСтрок = торо_ДанныеФормыДеревоКлиентСервер.НайтиСтроки(ТекущиеДанные, СтруктураПоиска);
		Для каждого Строка Из МассивВыделяемыхСтрок Цикл
			Строка.ВыделитьСтрокуДерева = Истина;
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьВыделениеНесоответствующихВДереве()
	
	СтруктураПоиска = Новый Структура("ВыделитьСтрокуДерева", Истина);
	МассивВыделенныхСтрок = торо_ДанныеФормыДеревоКлиентСервер.НайтиСтроки(Дерево, СтруктураПоиска);
	Для каждого Строка Из МассивВыделенныхСтрок Цикл
		Строка.ВыделитьСтрокуДерева = Ложь;
	КонецЦикла;
	
КонецПроцедуры
#КонецОбласти

