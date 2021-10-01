# TODO
# 
# balance numbers
# higher values?
# display numbers as "1.27 billion" etc.
# extra stats: time elapsed, physical clicks per second, etc.
# reset with multiplier bonus
# save/load
# bonus things to "catch" in background

extends Node2D

const BASE_CPS = 0.1

onready var purchase_list = [
        Purchasable.new("Baker", 10, BASE_CPS, $"Buttons/Baker"),
        Purchasable.new("Factory", 100, BASE_CPS * 15, $"Buttons/Factory"),
        Purchasable.new("City", 1000, BASE_CPS * 15 * 15, $"Buttons/City"),
        Purchasable.new("State", 10000, BASE_CPS * 15 * 15 * 15, $"Buttons/State"),
        Purchasable.new("Nation", 100000, BASE_CPS * 15 * 15 * 15 * 15, $"Buttons/Nation"),
        Purchasable.new("Planet", 1000000, BASE_CPS * 15 * 15 * 15 * 15, $"Buttons/Planet"),
        Purchasable.new("Solar System", 10000000, BASE_CPS * 15 * 15 * 15 * 15 * 15, $"Buttons/Solar System"),
        Purchasable.new("Galaxy", 100000000, BASE_CPS * 15 * 15 * 15 * 15 * 15 * 15, $"Buttons/Galaxy"),
        Purchasable.new("Universe", 1000000000, BASE_CPS * 15 * 15 * 15 * 15 * 15 * 15 * 15, $"Buttons/Universe"),
]

onready var info = $"Information"

var clicks = 0
var cookies = 0.0
var cookies_per_sec = 0.0

class Purchasable:
        var button: Button
        var count: int
        var cost: int
        var cps: float
        var name: String

        func _init(a_name, a_cost, a_cps, a_button):
                self.name = a_name
                self.cost = a_cost
                self.cps = a_cps
                self.button = a_button
                self.button.text = "%s (%d c, %0.2f cps)" % [self.name, self.cost, self.cps]
                self.count = 0

        func add():
                self.count += 1
                

func _process(delta):
        cookies += cookies_per_sec * delta
        for p in purchase_list:
                p.button.disabled = cookies < p.cost
        update_info()

func _ready():
        update_info()

func _on_Baker_Button_pressed():
        on_button_pressed("Baker")

func _on_Cookie_Button_pressed():
        cookies += 1
        clicks += 1

func _on_Factory_pressed():
        on_button_pressed("Factory")

func get_purchasable(name):
        for p in purchase_list:
                if p.name == name:
                        return p
        return null

func on_button_pressed(name):
        var p = get_purchasable(name)
        cookies -= p.cost
        p.add()
        update_cps()
        clicks += 1

func update_cps():
        cookies_per_sec = 0
        for p in purchase_list:
                cookies_per_sec += p.cps * p.count

func update_info():
        info.text = "Cookies: %d (%.2f)\n" % [cookies, cookies]
        for p in purchase_list:
                info.text += "%s: %d (%.2f cps)\n" % [p.name, p.count, p.cps*p.count]
        info.text += "Total clicks: %d\n" % clicks
        info.text += "Cookies Per Second: %.2f\n" % cookies_per_sec


func _on_City_pressed():
        on_button_pressed("City")

func _on_State_pressed():
        on_button_pressed("State")

func _on_Nation_pressed():
        on_button_pressed("Nation")

func _on_Planet_pressed():
        on_button_pressed("Planet")

func _on_Solar_System_pressed():
        on_button_pressed("Solar System")

func _on_Galaxy_pressed():
        on_button_pressed("Galaxy")

func _on_Universe_pressed():
        on_button_pressed("Universe")
