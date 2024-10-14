class_name Inventory


var _content: Array[Item] = []


func _init() -> void:
	_content.resize(42)
	SignalBus.change_item_position.connect(update_item)

func add_item(item: Item) -> void:
	var index = 0
	var first_empty_slot = null
	
	for _item in _content:
		index += 1
		
		if not _item and first_empty_slot == null:
			first_empty_slot = index - 1
			continue
		
		if not _item:
			continue
		
		if _item.name != item.name:
			continue
		
		if _item.stack_size == _item.quantity:
			continue
		
		if _item.stack_size < _item.quantity + item.quantity:
			continue
		
		_item.quantity += item.quantity
		SignalBus.inventory_updated.emit()
		return
	
	var new_item = item.duplicate()
	_content[first_empty_slot] = new_item
	
	SignalBus.inventory_updated.emit()


func update_item(item: Item, old_position: int, new_position: int):
	var item_to_be_swapped = _content[new_position]
	_content[new_position] = item
	
	_content[old_position] = item_to_be_swapped
	
	SignalBus.inventory_updated.emit()


func remove_item(item: Item, quantity: int = 1) -> void:
	var index = 0
	
	for _item in _content:
		index += 1
		
		if not _item:
			continue
		
		if _item.name != item.name:
			continue
		
		_item.quantity -= quantity
		
		if _item.quantity == 0:
			_content[index - 1] = null
		
		break
	
	SignalBus.inventory_updated.emit()


func get_items() -> Array[Item]:
	return _content


func get_item_by_name(item_name: String) -> Item:
	var found_item
	for item in _content:
		if not item:
			continue
		
		if item.name == item_name:
			found_item = item
			break
	
	return found_item


func has_all(items: Array[Item]) -> bool:
	var needed: Array[Item] = items.duplicate()
	
	for available in _content:
		if needed.size() == 0:
			break
		
		if not available:
			continue
		
		if available.quantity > 1:
			var removing = 0
			while removing < available.quantity:
				var remove_index = needed.find(available.name)
				needed.pop_at(remove_index)
				removing += 1
	
	return needed.is_empty()
