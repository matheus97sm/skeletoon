class_name Inventory


var _content: Array[Item] = []


func add_item(item: Item) -> void:
	for _item in _content:
		if _item.name == item.name:
			_item.quantity += item.quantity
			return
	
	var new_item = item.duplicate()
	_content.append(new_item)


func remove_item(item: Item, quantity: int = 1) -> void:
	for _item in _content:
		if _item.name == item.name:
			_item.quantity -= quantity
			
			if _item.quantity == 0:
				_content.erase(_item)
		


func get_items() -> Array[Item]:
	return _content


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
