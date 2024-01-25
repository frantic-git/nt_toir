#Область ОбработчикиСобытий
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ЭтаФорма = ПараметрыВыполненияКоманды.Источник;
	
	Попытка
	    ОтборОбъектРемонта = ЭтаФорма.ОтборОбъектРемонта;	
	Исключение
		ОтборОбъектРемонта = Неопределено;
	КонецПопытки;
	
	ЭтаФорма.Элементы.НеОтображатьГруппы.Доступность = ЭтаФорма.Элементы.ФормаИерархическийПросмотр.Пометка;
	торо_РаботаСИерархией20КлиентСервер.УстановитьСостояниеИерархическогоПросмотра(ЭтаФорма, НЕ ЭтаФорма.ВключенИерархическийПросмотр);
	Если ЭтаФорма.Элементы.ФормаИерархическийПросмотр.Пометка = Ложь Тогда
		ЭтаФорма.НеОтображатьГруппы = Истина;
		ЭтаФорма.Элементы.НеОтображатьГруппы.Пометка = Истина;
		торо_РаботаСИерархией20Клиент.УправлениеОтборомВСписке(ЭтаФорма,,,ОтборОбъектРемонта, ЭтаФорма.НеОтображатьГруппы);
		торо_РаботаСИерархией20Клиент.УстановитьДоступностьКомандДереваПриАктивизацииСтроки(ЭтаФорма, ЭтаФорма.Элементы.Дерево.ТекущиеДанные);
	Иначе
		ЭтаФорма.НеОтображатьГруппы = Ложь;
		ЭтаФорма.Элементы.НеОтображатьГруппы.Пометка = Ложь;
		торо_РаботаСИерархией20Клиент.УправлениеОтборомВСписке(ЭтаФорма,,, ОтборОбъектРемонта, ЭтаФорма.НеОтображатьГруппы);
	КонецЕсли;
КонецПроцедуры
#КонецОбласти