class_name Inventory


var _content: Array[Item] = []


func add_item(item: Item) -> void:
	for _item in _content:
		if _item.name == item.name:
			_item.quantity += item.quantity
			SignalBus.inventory_updated.emit()
			return
	
	var new_item = item.duplicate()
	_content.append(new_item)
	
	SignalBus.inventory_updated.emit()


func remove_item(item: Item, quantity: int = 1) -> void:
	for _item in _content:
		if _item.name == item.name:
			_item.quantity -= quantity
			
			if _item.quantity == 0:
				_content.erase(_item)
	
	SignalBus.inventory_updated.emit()


func get_items() -> Array[Item]:
	return _content


func get_item_by_name(item_name: String) -> Item:
	var found_item
	for item in _content:
		if item.name == item_name:
			found_item = item
			break
	
	return found_item


func has_all(items: Array[Item]) -> bool:
	var needed: Array[Item] = items.duplicate()
	
	for available in _content:
		if available.quantity > 1:
			var removing = 0
			while removing < available.quantity:
				var remove_index = needed.find(available.name)
				needed.pop_at(remove_index)
				removing += 1
	
	return needed.is_empty()
