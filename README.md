# marvel-viper-uikit
##### App structure
1. Api layer
  * Generic fetcher
  * Heroes fetcher (uses Generic fetcher. Fetches data from https://gateway.marvel.com:443/v1/public. Batch size - 20 items.)
2. Database layer
  * Db storage (on disk-cahce for the data, received from api layer. Uses Realm.)
4. Service layer
  * HeroesService (responsible for communication between api layer and db layer.)
5. Modules (separate parts of the application.)
  * Heroes
    * HeroesModule (setup of the module, entry point of the application.)
    * HeroesView (view controller with only view logic. Displays list of heroes.)
    * HeroesInteraction (communication between service layer and presenter.)
    * HeroesPresenter (takes data from interraction and prepare it for the view.)
    * HeroesRouter (responsible for Heroes module navigation.)
  * HeroDetails
    * HeroDetailsModule (opens from HeroesModule)
    * HeroDetailsView (displays hero details. Segmented view with hero comics, series, stories, events).
    * HeroDetailsInteraction
    * HeroDetailsPresenter
6. Utils
  * Viper (viper interface)
  * Extensions (basic extensions, mostly for the presentation layer)
7. AppResources (application string resources)
