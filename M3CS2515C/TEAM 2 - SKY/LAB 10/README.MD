Lab Work 10
RESTful API
1. Group of 4
2. Create new flutter project or use the existing.
3. Run the project on the smartphone or AVD.
4. Create new laravel project on XAMP/Laragon/Ubuntu/Docker.
5. Create REST API Using Laravel. (example: https://blog.treblle.com/how-to-create-rest-api-using-laravel/ )
6. Create Sample Database and perform REST API CRUD using Laravel. (example: https://techsolutionstuff.com/post/laravel-rest-api-crud-tutorial)
7. Integrate Laravel REST API into Flutter App.
(example: https://blog.codemagic.io/rest-api-in-flutter/ )
8. Highlight on YouTube using the timestamps.
9. Github page README.md should highlight on VSCode final coding pages + Speedcode.

# GROUP:
M3CS2515C
AKMAL FARHAN BIN AHMAD ANNUAR (2022660498)

NURUL IFFAH HASYIMAH BINTI HASAN (2022457982)

ZUHAIRAH NURHIDAYAH BINTI ZAINUDIN (2022457722)

NURFADLIYANA 'AQILAH BINTI SULAIMAN (2022824754)


Youtube: https://youtu.be/BdX0TLjEIFE

```
### LARAVEL (MIGRATION DRINKS CODE)
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDrinksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('drinks', function (Blueprint $table) {
            $table->id();
            $table->string('name'); // Name of the drink
            $table->text('description')->nullable(); // Description of the drink (optional)
            $table->decimal('price', 8, 2); // Price of the drink
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('drinks');
    }
}

```

```
### LARAVEL (Drinks.php)
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Drinks extends Model
{
    // Define the fillable properties
    protected $fillable = [
        'name', 'description', 'price', 
    ];

    // Additional methods or relationships can be added here

    // Example: If you have a relationship with another model (e.g., Drink belongs to a Category)
    // public function category()
    // {
    //     return $this->belongsTo(Category::class);
    // }
}


```
### LARAVEL (DrinksController.php)
<?php

namespace App\Http\Controllers;

use App\Drinks;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class DrinksController extends Controller
{
    // Get all drinks
    public function index()
    {
        $drinks = Drinks::all();
        return response()->json($drinks, 200);
    }

    // Update an existing drink
    public function update(Request $request, $id)
    {
        $drink = Drinks::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'name' => 'string|max:255',
            'description' => 'nullable|string',
            'price' => 'numeric',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }

        $drink->update($request->all());

        return response()->json($drink, 200);
    }

    // Create a new drink
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'price' => 'required|numeric',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }

        $drink = Drinks::create($request->all());

        return response()->json($drink, 201);
    }

    // Delete an existing drink
    public function destroy($id)
    {
        $drink = Drinks::findOrFail($id);
        $drink->delete();

        return response()->json(null, 204);
    }
}



```


### LARAVEL (Routes/api.php)
<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\DrinksController;

Route::get('/drinks', [DrinksController::class, 'index']);
Route::get('/drinks/{drink}', [DrinksController::class, 'show']);
Route::post('/drinks', [DrinksController::class, 'store']);
Route::put('/drinks/{drink}', [DrinksController::class, 'update']);
Route::delete('/drinks/{drink}', [DrinksController::class, 'destroy']);



```

### LARAVEL (Routes/api.php)
<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\DrinksController;

Route::get('/drinks', [DrinksController::class, 'index']);
Route::get('/drinks/{drink}', [DrinksController::class, 'show']);
Route::post('/drinks', [DrinksController::class, 'store']);
Route::put('/drinks/{drink}', [DrinksController::class, 'update']);
Route::delete('/drinks/{drink}', [DrinksController::class, 'destroy']);



```

```

### Flutter(Main.dart)
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class Drink {
  final int id; // Assuming your API response includes an 'id' field
  final String name;
  final String description;
  final double price;

  Drink(
      {required this.id,
      required this.name,
      required this.description,
      required this.price});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] is String)
          ? double.tryParse(json['price']) ?? 0.0
          : json['price'].toDouble(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drinks App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Drink> drinks = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.178:8000/api/drinks'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        drinks = jsonResponse.map((data) => Drink.fromJson(data)).toList();
      });
    } else {
      // Handle errors
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<void> createDrink() async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create Drink'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Price'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog

                final response = await http.post(
                  Uri.parse('http://192.168.1.178:8000/api/drinks'),
                  headers: {'Content-Type': 'application/json'},
                  body: json.encode({
                    'name': nameController.text,
                    'description': descriptionController.text,
                    'price': double.parse(priceController.text),
                  }),
                );

                if (response.statusCode == 201) {
                  final dynamic jsonResponse = json.decode(response.body);
                  final newDrink = Drink.fromJson(jsonResponse);
                  setState(() {
                    drinks.add(newDrink);
                  });
                } else {
                  // Handle errors
                  print('Request failed with status: ${response.statusCode}');
                }
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateDrink(int index) async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Drink'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController..text = drinks[index].name,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: descriptionController
                  ..text = drinks[index].description ?? '',
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: priceController
                  ..text = drinks[index].price.toString(),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Price'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog

                final response = await http.put(
                  Uri.parse(
                      'http://192.168.1.178:8000/api/drinks/${drinks[index].id}'),
                  headers: {'Content-Type': 'application/json'},
                  body: json.encode({
                    'name': nameController.text,
                    'description': descriptionController.text,
                    'price': double.parse(priceController.text),
                  }),
                );

                if (response.statusCode == 200) {
                  final dynamic jsonResponse = json.decode(response.body);
                  final updatedDrink = Drink.fromJson(jsonResponse);
                  setState(() {
                    drinks[index] = updatedDrink;
                  });
                } else {
                  // Handle errors
                  print('Request failed with status: ${response.statusCode}');
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteDrink(int index) async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.178:8000/api/drinks/${drinks[index].id}'),
    );

    if (response.statusCode == 204) {
      setState(() {
        drinks.removeAt(index);
      });
    } else {
      // Handle errors
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drinks App'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: createDrink,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: drinks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(drinks[index].id.toString()),
            onDismissed: (direction) => deleteDrink(index),
            child: ListTile(
              title: Text(drinks[index].name),
              subtitle: Text(drinks[index].description ?? 'No description'),
              trailing: Text('\$${drinks[index].price.toStringAsFixed(2)}'),
              onTap: () => updateDrink(index),
            ),
          );
        },
      ),
    );
  }
}


```










