Data Flow diagram for the test app

+-------------------+
|     UI Layer      | (SwiftUI Views)
|-------------------|
| - ReceipsMainView |
| - DetailView      |
+--------+----------+
         |
         | fetchReceipts() / fetchImage()
         v
+--------+----------+
|   ViewModel       | (ObservableObject)
|-------------------|
| - @Published var recepies         |
| - @Published var recipeImages     |
| - @Published var selectedCuisine  |
+--------+----------+
         |
         | async calls to appController
         v
+--------+----------+
|   AppController   | (AppControllerServices)
|-------------------|
| - getReceipties() |
| - getImage(url)   |
+--------+----------+
         |
         | delegating API & cache tasks
         v
+--------+----------+
| NetworkService    |
|-------------------|
| - fetch recipe JSON         |
| - download & cache image    |
| - NSCache for image memory  |
+--------+----------+
         |
         | uses HTTP/URLSession
         v
+-------------------+
|  Remote API       |
|-------------------|
| - JSON: [recipes] |
| - Images by URL   |
+-------------------+



---------------------------------------------------------------------
  Missing items
  
  data store with cache and core data implementaion
  all models will extend from DTOObject and map to their own entities
  Detail screen should cache the Larger image and not load them at run time every time
  
