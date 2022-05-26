--[[
    Vocabulary game: Vocabulanes

    -- Main Program --

    Author: Eric Bertschy

    
]]

-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
--
-- https://github.com/Ulydev/push
push = require 'push'

-- the "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods
--
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'class'

-- our Paddle class, which stores position and dimensions for each Paddle
-- and the logic for rendering them
require 'Paddle'

-- our Slide class, which isn't much different than a Paddle structure-wise
-- but which will mechanically function very differently
require 'Slide'

require 'Obstacle'

require 'Bubble'

utf8 = require 'utf8'

-- size of our actual window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- size we're trying to emulate with push
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
FONT_HEIGHT = 16

-- player movement speed
PADDLE_SPEED = 200

FRENCH_TBL = {
    ["as"] = "comme",
    ["I"] = "je",
    ["his"] = "son",
    ["that"] = "que",
    ["he"] = "il",
    ["was"] = "Était",
    ["for"] = "pour",
    ["on"] = "sur",
    ["are"] = "sont",
    ["with"] = "avec",
    ["they"] = "ils",
    ["be"] = "Être",
    ["at"] = "À ",
    ["one"] = "un",
    ["have"] = "avoir",
    ["this"] = "ce",
    ["from"] = "À partir de",
    ["by"] = "par",
    ["hot"] = "chaud",
    ["word"] = "mot",
    ["but"] = "mais",
    ["what"] = "que",
    ["some"] = "certains",
    ["is"] = "est",
    ["it"] = "il",
    ["you"] = "vous",
    ["or"] = "ou",
    ["had"] = "eu",
    ["the"] = "la",
    ["of"] = "de",
    ["to"] = "À ",
    ["and"] = "et",
    ["a"] = "un",
    ["in"] = "dans",
    ["we"] = "nous",
    ["box"] = "boÎte",
    ["out"] = "dehors",
    ["other"] = "autre",
    ["were"] = "Étaient",
    ["which"] = "qui",
    ["do"] = "faire",
    ["their"] = "leur",
    ["time"] = "temps",
    ["if"] = "si",
    ["will"] = "volontÉ",
    ["how"] = "comment",
    ["said"] = "dit",
    ["an"] = "un",
    ["each"] = "chaque",
    ["tell"] = "dire",
    ["does"] = "ne",
    ["set"] = "ensemble",
    ["three"] = "trois",
    ["want"] = "vouloir",
    ["air"] = "air",
    ["well"] = "bien",
    ["also"] = "aussi",
    ["play"] = "jouer",
    ["small"] = "petit",
    ["end"] = "fin",
    ["put"] = "mettre",
    ["home"] = "maison",
    ["read"] = "lire",
    ["hand"] = "main",
    ["port"] = "port",
    ["large"] = "grand",
    ["spell"] = "Épeler",
    ["add"] = "ajouter",
    ["even"] = "mÊme",
    ["land"] = "terre",
    ["here"] = "ici",
    ["must"] = "il faut",
    ["big"] = "grand",
    ["high"] = "haut",
    ["such"] = "tel",
    ["follow"] = "suivre",
    ["act"] = "acte",
    ["why"] = "pourquoi",
    ["ask"] = "interroger",
    ["men"] = "hommes",
    ["change"] = "changement",
    ["went"] = "est allÉ",
    ["light"] = "lumiÈre",
    ["kind"] = "genre",
    ["off"] = "de",
    ["need"] = "besoin",
    ["house"] = "maison",
    ["picture"] = "image",
    ["try"] = "essayer",
    ["us"] = "nous",
    ["again"] = "encore",
    ["animal"] = "animal",
    ["point"] = "point",
    ["mother"] = "mÈre",
    ["world"] = "monde",
    ["near"] = "prÈs de",
    ["build"] = "construire",
    ["self"] = "soi",
    ["earth"] = "terre",
    ["father"] = "pÈre",
    ["any"] = "tout",
    ["new"] = "nouveau",
    ["work"] = "travail",
    ["part"] = "partie",
    ["take"] = "prendre",
    ["get"] = "obtenir",
    ["place"] = "lieu",
    ["made"] = "fabriquÉ",
    ["live"] = "vivre",
    ["where"] = "oÀ¹",
    ["after"] = "aprÈs",
    ["back"] = "arriÈre",
    ["little"] = "peu",
    ["only"] = "seulement",
    ["round"] = "tour",
    ["man"] = "homme",
    ["year"] = "annÉe",
    ["came"] = "est venu",
    ["show"] = "montrer",
    ["every"] = "tous",
    ["good"] = "bon",
    ["me"] = "moi",
    ["give"] = "donner",
    ["our"] = "notre",
    ["under"] = "sous",
    ["name"] = "nom",
    ["very"] = "trÈs",
    ["through"] = "par",
    ["just"] = "juste",
    ["form"] = "forme",
    ["sentence"] = "phrase",
    ["great"] = "grand",
    ["think"] = "penser",
    ["say"] = "dire",
    ["help"] = "aider",
    ["low"] = "faible",
    ["line"] = "ligne",
    ["differ"] = "diffÉrer",
    ["turn"] = "tour",
    ["cause"] = "la cause",
    ["much"] = "beaucoup",
    ["mean"] = "signifier",
    ["before"] = "avant",
    ["move"] = "dÉmÉnagement",
    ["right"] = "droit",
    ["boy"] = "garÀ§on",
    ["old"] = "vieux",
    ["too"] = "trop",
    ["same"] = "mÊme",
    ["she"] = "elle",
    ["all"] = "tous",
    ["there"] = "lÀ",
    ["when"] = "quand",
    ["up"] = "jusqu'â",
    ["use"] = "utiliser",
    ["your"] = "votre",
    ["way"] = "maniÈre",
    ["about"] = "sur",
    ["many"] = "beaucoup",
    ["then"] = "puis",
    ["them"] = "les",
    ["write"] = "Écrire",
    ["would"] = "voudrais",
    ["like"] = "comme",
    ["so"] = "si",
    ["these"] = "ces",
    ["her"] = "son",
    ["long"] = "long",
    ["make"] = "faire",
    ["thing"] = "chose",
    ["see"] = "voir",
    ["him"] = "lui",
    ["two"] = "deux",
    ["has"] = "a",
    ["look"] = "regarder",
    ["more"] = "plus",
    ["day"] = "jour",
    ["could"] = "pourrait",
    ["go"] = "aller",
    ["come"] = "venir",
    ["did"] = "fait",
    ["number"] = "nombre",
    ["sound"] = "son",
    ["no"] = "aucun",
    ["most"] = "plus",
    ["people"] = "personnes",
    ["my"] = "ma",
    ["over"] = "sur",
    ["know"] = "savoir",
    ["water"] = "eau",
    ["than"] = "que",
    ["call"] = "appel",
    ["first"] = "premiÈre",
    ["who"] = "qui",
    ["may"] = "peut",
    ["down"] = "vers le bas",
    ["side"] = "cÀ´tÉ",
    ["been"] = "ÉtÉ",
    ["now"] = "maintenant",
    ["find"] = "trouver",
    ["head"] = "tÊte",
    ["stand"] = "supporter",
    ["own"] = "propre",
    ["page"] = "page",
    ["should"] = "devrait",
    ["country"] = "pays",
    ["found"] = "trouvÉ",
    ["answer"] = "rÉponse",
    ["school"] = "École",
    ["grow"] = "croÎtre",
    ["study"] = "Étude",
    ["still"] = "encore",
    ["learn"] = "apprendre",
    ["plant"] = "usine",
    ["cover"] = "couvercle",
    ["food"] = "nourriture",
    ["sun"] = "soleil",
    ["four"] = "quatre",
    ["between"] = "entre",
    ["state"] = "État",
    ["keep"] = "garder",
    ["eye"] = "Å“il",
    ["never"] = "jamais",
    ["last"] = "dernier",
    ["let"] = "laisser",
    ["thought"] = "pensÉe",
    ["city"] = "ville",
    ["tree"] = "arbre",
    ["cross"] = "traverser",
    ["farm"] = "ferme",
    ["hard"] = "dur",
    ["start"] = "dÉbut",
    ["might"] = "puissance",
    ["story"] = "histoire",
    ["saw"] = "scie",
    ["far"] = "loin",
    ["sea"] = "mer",
    ["draw"] = "tirer",
    ["left"] = "gauche",
    ["late"] = "tard",
    ["run"] = "courir",
    ["donâ€™t"] = "needs a context",
    ["while"] = "tandis que",
    ["press"] = "presse",
    ["close"] = "proche",
    ["night"] = "nuit",
    ["real"] = "rÉel",
    ["life"] = "vie",
    ["few"] = "peu",
    ["north"] = "nord",
    ["book"] = "livre",
    ["carry"] = "porter",
    ["took"] = "a pris",
    ["science"] = "science",
    ["eat"] = "manger",
    ["room"] = "chambre",
    ["friend"] = "ami",
    ["began"] = "a commencÉ",
    ["idea"] = "idÉe",
    ["fish"] = "poisson",
    ["mountain"] = "montagne",
    ["stop"] = "ArrÊtez",
    ["once"] = "une fois",
    ["base"] = "base",
    ["hear"] = "entendre",
    ["horse"] = "cheval",
    ["cut"] = "coupe",
    ["sure"] = "sÀ»r",
    ["watch"] = "regarder",
    ["color"] = "couleur",
    ["face"] = "face",
    ["wood"] = "bois",
    ["main"] = "principal",
    ["open"] = "ouvert",
    ["seem"] = "paraÎtre",
    ["together"] = "ensemble",
    ["next"] = "suivant",
    ["white"] = "blanc",
    ["children"] = "enfants",
    ["begin"] = "commencer",
    ["got"] = "eu",
    ["walk"] = "marcher",
    ["example"] = "exemple",
    ["ease"] = "facilitÉ",
    ["paper"] = "papier",
    ["group"] = "groupe",
    ["always"] = "toujours",
    ["music"] = "musique",
    ["those"] = "ceux",
    ["both"] = "tous les deux",
    ["mark"] = "marque",
    ["often"] = "souvent",
    ["letter"] = "lettre",
    ["until"] = "jusquâ ce que",
    ["mile"] = "mile",
    ["river"] = "riviÈre",
    ["car"] = "voiture",
    ["feet"] = "pieds",
    ["care"] = "soins",
    ["second"] = "deuxiÈme",
    ["enough"] = "assez",
    ["plain"] = "plaine",
    ["girl"] = "fille",
    ["usual"] = "habituel",
    ["young"] = "jeune",
    ["ready"] = "prÊt",
    ["above"] = "au-dessus",
    ["ever"] = "jamais",
    ["red"] = "rouge",
    ["list"] = "liste",
    ["though"] = "bien que",
    ["feel"] = "sentir",
    ["talk"] = "parler",
    ["bird"] = "oiseau",
    ["soon"] = "bientÀ´t",
    ["body"] = "corps",
    ["dog"] = "chien",
    ["family"] = "famille",
    ["direct"] = "direct",
    ["pose"] = "pose",
    ["leave"] = "laisser",
    ["song"] = "chanson",
    ["measure"] = "mesurer",
    ["door"] = "porte",
    ["product"] = "produit",
    ["black"] = "noir",
    ["short"] = "court",
    ["numeral"] = "chiffre",
    ["class"] = "classe",
    ["wind"] = "vent",
    ["question"] = "question",
    ["happen"] = "arriver",
    ["complete"] = "complÈte",
    ["ship"] = "navire",
    ["area"] = "zone",
    ["half"] = "moitiÉ",
    ["rock"] = "rock",
    ["order"] = "ordre",
    ["fire"] = "feu",
    ["south"] = "sud",
    ["problem"] = "problÈme",
    ["piece"] = "piÈce",
    ["told"] = "dit",
    ["knew"] = "savait",
    ["pass"] = "passer",
    ["since"] = "depuis",
    ["top"] = "haut",
    ["whole"] = "ensemble",
    ["king"] = "roi",
    ["street"] = "rue",
    ["inch"] = "pouce",
    ["multiply"] = "multiplier",
    ["nothing"] = "rien",
    ["course"] = "cours",
    ["stay"] = "rester",
    ["wheel"] = "roue",
    ["full"] = "plein",
    ["force"] = "force",
    ["blue"] = "bleu",
    ["object"] = "objet",
    ["decide"] = "dÉcider",
    ["surface"] = "surface",
    ["deep"] = "profond",
    ["moon"] = "lune",
    ["island"] = "Île",
    ["foot"] = "pied",
    ["system"] = "systÈme",
    ["busy"] = "occupÉ",
    ["test"] = "test",
    ["record"] = "record",
    ["boat"] = "bateau",
    ["common"] = "commun",
    ["gold"] = "or",
    ["possible"] = "possible",
    ["plane"] = "plan",
    ["stead"] = "place",
    ["dry"] = "sec",
    ["wonder"] = "se demander",
    ["laugh"] = "rire",
    ["thousand"] = "mille",
    ["ago"] = "il ya",
    ["ran"] = "ran",
    ["check"] = "vÉrifier",
    ["game"] = "jeu",
    ["shape"] = "forme",
    ["equate"] = "assimiler",
    ["hot"] = "chaud",
    ["miss"] = "manquer",
    ["brought"] = "apportÉ",
    ["heat"] = "chaleur",
    ["snow"] = "neige",
    ["tire"] = "pneu",
    ["bring"] = "apporter",
    ["yes"] = "oui",
    ["distant"] = "lointain",
    ["fill"] = "remplir",
    ["east"] = "est",
    ["paint"] = "peindre",
    ["language"] = "langue",
    ["among"] = "entre",
    ["unit"] = "unitÉ",
    ["power"] = "puissance",
    ["town"] = "ville",
    ["fine"] = "fin",
    ["certain"] = "certain",
    ["fly"] = "voler",
    ["fall"] = "tomber",
    ["lead"] = "conduire",
    ["cry"] = "cri",
    ["dark"] = "sombre",
    ["machine"] = "machine",
    ["note"] = "Note",
    ["wait"] = "patienter",
    ["plan"] = "plan",
    ["figure"] = "figure",
    ["star"] = "Étoile",
    ["box"] = "boÎte",
    ["noun"] = "nom",
    ["field"] = "domaine",
    ["rest"] = "reste",
    ["correct"] = "correct",
    ["able"] = "capable",
    ["pound"] = "livre",
    ["done"] = "TerminÉ",
    ["beauty"] = "beautÉ",
    ["drive"] = "entraÎnement",
    ["stood"] = "rÉsistÉ",
    ["contain"] = "contenir",
    ["front"] = "avant",
    ["teach"] = "enseigner",
    ["week"] = "semaine",
    ["final"] = "finale",
    ["gave"] = "donnÉ",
    ["green"] = "vert",
    ["oh"] = "oh",
    ["quick"] = "rapide",
    ["develop"] = "dÉvelopper",
    ["ocean"] = "ocÉan",
    ["warm"] = "chaud",
    ["free"] = "gratuit",
    ["minute"] = "minute",
    ["strong"] = "fort",
    ["special"] = "spÉcial",
    ["mind"] = "esprit",
    ["behind"] = "derriÈre",
    ["clear"] = "clair",
    ["tail"] = "queue",
    ["produce"] = "produire",
    ["fact"] = "fait",
    ["space"] = "espace",
    ["heard"] = "entendu",
    ["best"] = "meilleur",
    ["hour"] = "heure",
    ["better"] = "mieux",
    ["true"] = "vrai",
    ["during"] = "pendant",
    ["hundred"] = "cent",
    ["five"] = "cinq",
    ["remember"] = "rappeler",
    ["step"] = "Étape",
    ["early"] = "tÀ´t",
    ["hold"] = "tenir",
    ["west"] = "ouest",
    ["ground"] = "sol",
    ["interest"] = "intÉrÊt",
    ["reach"] = "atteindre",
    ["fast"] = "rapide",
    ["verb"] = "verbe",
    ["sing"] = "chanter",
    ["listen"] = "Écouter",
    ["six"] = "six",
    ["table"] = "table",
    ["travel"] = "Voyage",
    ["less"] = "moins",
    ["morning"] = "matin",
    ["ten"] = "dix",
    ["simple"] = "simple",
    ["several"] = "plusieurs",
    ["vowel"] = "voyelle",
    ["toward"] = "vers",
    ["war"] = "guerre",
    ["lay"] = "poser",
    ["against"] = "contre",
    ["pattern"] = "modÈle",
    ["slow"] = "lent",
    ["center"] = "centre",
    ["love"] = "amour",
    ["person"] = "personne",
    ["money"] = "argent",
    ["serve"] = "servir",
    ["appear"] = "apparaÎtre",
    ["road"] = "route",
    ["map"] = "carte",
    ["rain"] = "pluie",
    ["rule"] = "rÈgle",
    ["govern"] = "gouverner",
    ["pull"] = "tirer",
    ["cold"] = "froid",
    ["notice"] = "avis",
    ["voice"] = "voix",
    ["energy"] = "Énergie",
    ["hunt"] = "chasse",
    ["probable"] = "probable",
    ["bed"] = "lit",
    ["brother"] = "frÈre",
    ["egg"] = "Å“uf",
    ["ride"] = "tour",
    ["cell"] = "cellule",
    ["believe"] = "croire",
    ["perhaps"] = "peut-Être",
    ["pick"] = "choisir",
    ["sudden"] = "soudain",
    ["count"] = "compter",
    ["square"] = "carrÉ",
    ["reason"] = "raison",
    ["length"] = "longueur",
    ["represent"] = "reprÉsenter",
    ["art"] = "art",
    ["subject"] = "sujet",
    ["region"] = "rÉgion",
    ["size"] = "taille",
    ["vary"] = "varier",
    ["settle"] = "rÉgler",
    ["speak"] = "parler",
    ["weight"] = "poids",
    ["general"] = "gÉnÉral",
    ["ice"] = "glace",
    ["matter"] = "question",
    ["circle"] = "cercle",
    ["pair"] = "paire",
    ["include"] = "inclure",
    ["divide"] = "fracture",
    ["syllable"] = "syllabe",
    ["felt"] = "feutre",
    ["grand"] = "grandiose",
    ["ball"] = "balle",
    ["yet"] = "encore",
    ["wave"] = "vague",
    ["drop"] = "tomber",
    ["heart"] = "cÅ“ur",
    ["am"] = "h",
    ["present"] = "prÉsent",
    ["heavy"] = "lourd",
    ["dance"] = "danse",
    ["engine"] = "moteur",
    ["position"] = "position",
    ["arm"] = "bras",
    ["wide"] = "large",
    ["sail"] = "voile",
    ["material"] = "matÉriel",
    ["fraction"] = "fraction",
    ["forest"] = "forÊt",
    ["sit"] = "sâ€™asseoir",
    ["race"] = "course",
    ["window"] = "fenÊtre",
    ["store"] = "magasin",
    ["summer"] = "ÉtÉ",
    ["train"] = "train",
    ["sleep"] = "sommeil",
    ["prove"] = "prouver",
    ["lone"] = "seul",
    ["leg"] = "jambe",
    ["exercise"] = "exercice",
    ["wall"] = "mur",
    ["catch"] = "capture",
    ["mount"] = "monture",
    ["wish"] = "souhaiter",
    ["sky"] = "ciel",
    ["board"] = "conseil",
    ["joy"] = "joie",
    ["winter"] = "hiver",
    ["sat"] = "sat",
    ["written"] = "Écrit",
    ["wild"] = "sauvage",
    ["instrument"] = "instrument",
    ["kept"] = "conservÉ",
    ["glass"] = "verre",
    ["grass"] = "herbe",
    ["cow"] = "vache",
    ["job"] = "emploi",
    ["edge"] = "bord",
    ["sign"] = "signe",
    ["visit"] = "visite",
    ["past"] = "passÉ",
    ["soft"] = "doux",
    ["fun"] = "amusement",
    ["bright"] = "clair",
    ["gas"] = "gaz",
    ["weather"] = "temps",
    ["month"] = "mois",
    ["million"] = "million",
    ["bear"] = "porter",
    ["finish"] = "finition",
    ["happy"] = "heureux",
    ["hope"] = "espoir",
    ["flower"] = "fleur",
    ["clothe"] = "vÊtir",
    ["strange"] = "Étrange",
    ["gone"] = "disparu",
    ["trade"] = "commerce",
    ["melody"] = "mÉlodie",
    ["trip"] = "voyage",
    ["office"] = "bureau",
    ["receive"] = "recevoir",
    ["row"] = "rangÉe",
    ["mouth"] = "bouche",
    ["exact"] = "exact",
    ["symbol"] = "symbole",
    ["die"] = "mourir",
    ["least"] = "moins",
    ["trouble"] = "difficultÉ",
    ["shout"] = "cri",
    ["except"] = "sauf",
    ["wrote"] = "Écrit",
    ["seed"] = "semence",
    ["tone"] = "ton",
    ["join"] = "joindre",
    ["suggest"] = "suggÉrer",
    ["clean"] = "propre",
    ["break"] = "pause",
    ["lady"] = "dame",
    ["yard"] = "cour",
    ["rise"] = "augmenter",
    ["bad"] = "mauvais",
    ["blow"] = "coup",
    ["oil"] = "huile",
    ["blood"] = "sang",
    ["touch"] = "toucher",
    ["grew"] = "a augmentÉ",
    ["cent"] = "cent",
    ["mix"] = "mÉlanger",
    ["team"] = "Équipe",
    ["wire"] = "fil",
    ["cost"] = "coÀ»t",
    ["lost"] = "perdu",
    ["brown"] = "brun",
    ["wear"] = "porter",
    ["garden"] = "jardin",
    ["equal"] = "Égal",
    ["sent"] = "expÉdiÉ",
    ["choose"] = "choisir",
    ["fell"] = "est tombÉ",
    ["fit"] = "sâ€™adapter",
    ["flow"] = "dÉbit",
    ["fair"] = "juste",
    ["bank"] = "banque",
    ["collect"] = "recueillir",
    ["save"] = "sauver",
    ["control"] = "contrÀ´le",
    ["decimal"] = "dÉcimal",
    ["ear"] = "oreille",
    ["else"] = "autre",
    ["quite"] = "tout À  fait",
    ["broke"] = "cassÉ",
    ["case"] = "cas",
    ["middle"] = "milieu",
    ["kill"] = "tuer",
    ["son"] = "fils",
    ["lake"] = "lac",
    ["moment"] = "moment",
    ["scale"] = "Échelle",
    ["loud"] = "fort",
    ["spring"] = "printemps",
    ["observe"] = "observer",
    ["child"] = "enfant",
    ["straight"] = "droit",
    ["consonant"] = "consonne",
    ["nation"] = "nation",
    ["dictionary"] = "dictionnaire",
    ["milk"] = "lait",
    ["speed"] = "vitesse",
    ["method"] = "mÉthode",
    ["organ"] = "organe",
    ["pay"] = "payer",
    ["age"] = "À¢ge",
    ["section"] = "section",
    ["dress"] = "robe",
    ["cloud"] = "nuage",
    ["surprise"] = "surprise",
    ["quiet"] = "calme",
    ["stone"] = "pierre",
    ["tiny"] = "minuscule",
    ["climb"] = "montÉe",
    ["cool"] = "frais",
    ["design"] = "conception",
    ["poor"] = "pauvres",
    ["lot"] = "lot",
    ["experiment"] = "expÉrience",
    ["bottom"] = "bas",
    ["key"] = "clÉ",
    ["iron"] = "fer",
    ["single"] = "unique",
    ["stick"] = "bÀ¢ton",
    ["flat"] = "plat",
    ["twenty"] = "vingt",
    ["skin"] = "peau",
    ["smile"] = "sourire",
    ["crease"] = "pli",
    ["hole"] = "trou",
    ["jump"] = "sauter",
    ["baby"] = "bÉbÉ",
    ["eight"] = "huit",
    ["village"] = "village",
    ["meet"] = "se rencontrent",
    ["root"] = "racine",
    ["buy"] = "acheter",
    ["raise"] = "augmenter",
    ["solve"] = "rÉsoudre",
    ["metal"] = "mÉtal",
    ["whether"] = "si",
    ["push"] = "pousser",
    ["seven"] = "sept",
    ["paragraph"] = "paragraphe",
    ["third"] = "troisiÈme",
    ["shall"] = "doit",
    ["held"] = "en attente",
    ["hair"] = "cheveux",
    ["describe"] = "dÉcrire",
    ["cook"] = "cuisinier",
    ["floor"] = "Étage",
    ["either"] = "chaque",
    ["result"] = "rÉsultat",
    ["burn"] = "brÀ»ler",
    ["hill"] = "colline",
    ["safe"] = "coffre-fort",
    ["cat"] = "chat",
    ["century"] = "siÈcle",
    ["consider"] = "envisager",
    ["type"] = "type",
    ["law"] = "droit",
    ["bit"] = "peu",
    ["coast"] = "cÀ´te",
    ["copy"] = "copie",
    ["phrase"] = "phrase",
    ["silent"] = "silencieux",
    ["tall"] = "haut",
    ["sand"] = "sable",
    ["soil"] = "sol",
    ["roll"] = "rouleau",
    ["temperature"] = "tempÉrature",
    ["finger"] = "doigt",
    ["industry"] = "industrie",
    ["value"] = "valeur",
    ["fight"] = "lutte",
    ["lie"] = "mensonge",
    ["beat"] = "battre",
    ["excite"] = "exciter",
    ["natural"] = "naturel",
    ["view"] = "vue",
    ["sense"] = "sens",
    ["capital"] = "capital",
    ["wonâ€™t"] = "ne sera pas",
    ["chair"] = "chaise",
    ["danger"] = "danger",
    ["fruit"] = "fruit",
    ["rich"] = "riche",
    ["thick"] = "Épais",
    ["soldier"] = "soldat",
    ["process"] = "processus",
    ["operate"] = "fonctionner",
    ["practice"] = "pratique",
    ["separate"] = "sÉparÉ",
    ["difficult"] = "difficile",
    ["doctor"] = "mÉdecin",
    ["please"] = "sâ€™il vous plaÎt",
    ["protect"] = "protÉger",
    ["noon"] = "midi",
    ["crop"] = "rÉcolte",
    ["modern"] = "moderne",
    ["element"] = "ÉlÉment",
    ["hit"] = "frapper",
    ["student"] = "Étudiant",
    ["corner"] = "coin",
    ["party"] = "partie",
    ["supply"] = "alimentation",
    ["whose"] = "dont",
    ["locate"] = "localiser",
    ["ring"] = "anneau",
    ["character"] = "caractÈre",
    ["insect"] = "insecte",
    ["caught"] = "pris",
    ["period"] = "pÉriode",
    ["indicate"] = "indiquer",
    ["radio"] = "radio",
    ["spoke"] = "rayon",
    ["atom"] = "atome",
    ["human"] = "humain",
    ["history"] = "histoire",
    ["effect"] = "effet",
    ["electric"] = "Électrique",
    ["expect"] = "attendre",
    ["bone"] = "os",
    ["rail"] = "rail",
    ["imagine"] = "imaginer",
    ["provide"] = "fournir",
    ["agree"] = "se mettre dâ€™accord",
    ["thus"] = "ainsi",
    ["gentle"] = "doux",
    ["woman"] = "femme",
    ["captain"] = "capitaine",
    ["guess"] = "deviner",
    ["necessary"] = "nÉcessaire",
    ["sharp"] = "net",
    ["wing"] = "aile",
    ["create"] = "crÉer",
    ["neighbor"] = "voisin",
    ["wash"] = "lavage",
    ["bat"] = "chauve-souris",
    ["rather"] = "plutÀ´t",
    ["crowd"] = "foule",
    ["corn"] = "blÉ",
    ["compare"] = "comparer",
    ["poem"] = "poÈme",
    ["string"] = "chaÎne",
    ["bell"] = "cloche",
    ["depend"] = "dÉpendre",
    ["meat"] = "viande",
    ["rub"] = "rub",
    ["tube"] = "tube",
    ["famous"] = "cÉlÈbre",
    ["dollar"] = "dollar",
    ["stream"] = "courant",
    ["fear"] = "peur",
    ["sight"] = "vue",
    ["thin"] = "mince",
    ["triangle"] = "triangle",
    ["planet"] = "planÈte",
    ["hurry"] = "se dÉpÊcher",
    ["chief"] = "chef",
    ["colony"] = "colonie",
    ["clock"] = "horloge",
    ["mine"] = "mine",
    ["tie"] = "lien",
    ["enter"] = "entrer",
    ["major"] = "majeur",
    ["fresh"] = "frais",
    ["search"] = "recherche",
    ["send"] = "envoyer",
    ["yellow"] = "jaune",
    ["gun"] = "pistolet",
    ["allow"] = "permettre",
    ["print"] = "impression",
    ["dead"] = "mort",
    ["spot"] = "place",
    ["desert"] = "dÉsert",
    ["suit"] = "costume",
    ["current"] = "courant",
    ["lift"] = "ascenseur",
    ["rose"] = "rose",
    ["arrive"] = "arriver",
    ["master"] = "maÎtre",
    ["track"] = "piste",
    ["parent"] = "mÈre",
    ["shore"] = "rivage",
    ["division"] = "division",
    ["sheet"] = "feuille",
    ["substance"] = "substance",
    ["favor"] = "favoriser",
    ["connect"] = "relier",
    ["post"] = "poste",
    ["spend"] = "passer",
    ["chord"] = "corde",
    ["fat"] = "graisse",
    ["glad"] = "heureux",
    ["original"] = "original",
    ["share"] = "part",
    ["station"] = "station",
    ["dad"] = "papa",
    ["bread"] = "pain",
    ["charge"] = "charger",
    ["proper"] = "propre",
    ["bar"] = "bar",
    ["offer"] = "proposition",
    ["segment"] = "segment",
    ["slave"] = "esclave",
    ["duck"] = "canard",
    ["instant"] = "instant",
    ["market"] = "marchÉ",
    ["degree"] = "degrÉ",
    ["populate"] = "peupler",
    ["chick"] = "poussin",
    ["dear"] = "cher",
    ["enemy"] = "ennemi",
    ["reply"] = "rÉpondre",
    ["drink"] = "boisson",
    ["occur"] = "se produire",
    ["support"] = "support",
    ["speech"] = "discours",
    ["nature"] = "nature",
    ["range"] = "gamme",
    ["steam"] = "vapeur",
    ["motion"] = "mouvement",
    ["path"] = "chemin",
    ["liquid"] = "liquide",
    ["log"] = "enregistrer",
    ["meant"] = "signifiait",
    ["quotient"] = "quotient",
    ["teeth"] = "dents",
    ["shell"] = "coquille",
    ["neck"] = "cou",
    ["oxygen"] = "oxygÈne",
    ["sugar"] = "sucre",
    ["death"] = "dÉcÈs",
    ["pretty"] = "assez",
    ["skill"] = "compÉtence",
    ["women"] = "femmes",
    ["season"] = "saison",
    ["solution"] = "solution",
    ["magnet"] = "aimant",
    ["silver"] = "argent",
    ["thank"] = "merci",
    ["branch"] = "branche",
    ["match"] = "rencontre",
    ["suffix"] = "suffixe",
    ["especially"] = "particuliÈrement",
    ["fig"] = "figue",
    ["afraid"] = "peur",
    ["huge"] = "Énorme",
    ["sister"] = "sÅ“ur",
    ["steel"] = "acier",
    ["discuss"] = "discuter",
    ["forward"] = "avant",
    ["similar"] = "similaire",
    ["guide"] = "guider",
    ["experience"] = "expÉrience",
    ["score"] = "score",
    ["apple"] = "pomme",
    ["bought"] = "achetÉ",
    ["led"] = "LED",
    ["pitch"] = "pas",
    ["coat"] = "manteau",
    ["mass"] = "masse",
    ["card"] = "carte",
    ["band"] = "bande",
    ["rope"] = "corde",
    ["slip"] = "glissement",
    ["win"] = "gagner",
    ["dream"] = "rÊver",
    ["evening"] = "soirÉe",
    ["condition"] = "condition",
    ["feed"] = "alimentation",
    ["tool"] = "outil",
    ["total"] = "total",
    ["basic"] = "de base",
    ["smell"] = "odeur",
    ["valley"] = "vallÉe",
    ["nor"] = "ni",
    ["double"] = "double",
    ["seat"] = "siÈge",
    ["continue"] = "continuer",
    ["block"] = "bloc",
    ["chart"] = "graphique",
    ["hat"] = "chapeau",
    ["sell"] = "vendre",
    ["success"] = "succÈs",
    ["company"] = "entreprise",
    ["subtract"] = "soustraire",
    ["event"] = "ÉvÉnement",
    ["particular"] = "particulier",
    ["deal"] = "accord",
    ["swim"] = "baignade",
    ["term"] = "terme",
    ["opposite"] = "opposÉ",
    ["wife"] = "femme",
    ["shoe"] = "chaussure",
    ["shoulder"] = "Épaule",
    ["spread"] = "propagation",
    ["arrange"] = "organiser",
    ["camp"] = "camp",
    ["invent"] = "inventer",
    ["cotton"] = "coton",
    ["born"] = "nÉ",
    ["determine"] = "dÉterminer",
    ["quart"] = "litre",
    ["nine"] = "neuf",
    ["truck"] = "camion",
    ["noise"] = "bruit",
    ["level"] = "niveau",
    ["chance"] = "chance",
    ["gather"] = "recueillir",
    ["shop"] = "boutique",
    ["stretch"] = "tronÀ§on",
    ["throw"] = "jeter",
    ["shine"] = "Éclat",
    ["property"] = "propriÉtÉ",
    ["column"] = "colonne",
    ["molecule"] = "molÉcule",
    ["select"] = "sÉlectionner",
    ["wrong"] = "mal",
    ["gray"] = "gris",
    ["repeat"] = "rÉpÉtition",
    ["require"] = "exiger",
    ["broad"] = "large",
    ["prepare"] = "prÉparer",
    ["salt"] = "sel",
    ["nose"] = "nez",
    ["plural"] = "pluriel",
    ["anger"] = "colÈre",
    ["claim"] = "revendication",
    ["continent"] = "continent"
}

SWEDISH_TBL = {
    ["week"] = "vecka",
    ["year"] = "år",
    ["today"] = "idag",
    ["tomorrow"] ="imorgon",
    ["yesterday"] = "igår",
    ["calendar"] = "Kalender",
    ["second"] = "sekund",
    ["hour"] = "timme",
    ["minute"] = "minut",
    ["clock"] = "klocka",
    ["one hour"] = "en timme",
    ["can"] = "kan",
    ["use"] = "använda",
    ["do"] = "göra",
    ["go"] = "gå",
    ["come"] = "komma",
    ["laugh"] = "skratta",
    ["yes"] = "ja",
    ["no"] = "nej",
    ["good"] = "bra",
    ["hello"] = "hej",
    ["morning"] = "morgan",
    ["night"] = "natt",
    ["please"] = "snalla",
    ["goodbye"] = "hej da",
    ["please"] = "snalla du",
    ["train"] = "taget",
    ["bus"] = "bussen",
    ["tram"] = "sparvagn",
    ["train station"] = "Tagstationen",
    ["my"] = "mitt",
    ["restrooms"] = "toalett",
    ["men"] = "herrar",
    ["women"] = "damer",
    ["open"] = "oppen",
    ["closed"] = "stangd",
    ["cheers"] = "skal",
    ["chill"] = "tagga ned",
    ["I"] = "jag",
    ["his"] = "hans",
    ["that"] = "att",
    ["as"] = "som",
    ["he"] = "han",
    ["was"] = "var",
    ["on"] = "på",
    ["with"] = "med",
    ["they"] = "de",
    ["be"] = "vara",
    ["at"] = "vid",
    ["one"] = "ett",
    ["have"] = "ha",
    ["this"] = "detta",
    ["from"] = "från",
    ["by"] = "genom",
    ["hot"] = "het",
    ["word"] = "ord",

    ["for"] = "för",
    ["are"] = "är",
    ["with"] = "med",
    ["they"] = "de",
    ["by"] = "genom",
    ["what"] = "vad",
    ["some"] = "några",
    ["is"] = "är",
    ["it"] = "den",
    ["you"] = "du",
    ["or"] = "eller",
    ["had"] = "hade",
    ["the"] = "den",
    ["of"] = "av",
    ["to"] = "till",
    ["and"] = "och",
    ["a"] = "en",
    ["in"] = "i",
    ["we"] = "vi",
    ["can"] = "kan",
    ["out"] = "ut",
    ["other"] = "andra",
    ["were"] = "var",
    ["which"] = "vilken",
    ["do"] = "göra",
    ["their"] = "deras",
    ["time"] = "tid",
    ["if"] = "om",
    ["will"] = "kommer",
    ["how"] = "hur",
    ["said"] = "sa",
    ["an"] = "ett",
    ["each"] = "varje",
    ["tell"] = "berätta",
    ["does"] = "gör",
    ["set"] = "uppsättning",
    ["three"] = "tre",
    ["want"] = "vill",
    ["air"] = "luft",
    ["well"] = "väl",
    ["also"] = "också",
    ["play"] = "spela",
    ["small"] = "liten",
    ["end"] = "ände",
    ["put"] = "sätta",
    ["home"] = "hem",
    ["read"] = "läsa",
    ["hand"] = "sidan",
    ["port"] = "port",
    ["large"] = "stor",
    ["spell"] = "stava",
    ["add"] = "lägg",
    ["even"] = "även",
    ["land"] = "mark",
    ["here"] = "här",
    ["must"] = "must",
    ["big"] = "stor",
    ["high"] = "hög",
    ["such"] = "sådan",
    ["follow"] = "följ",
    ["act"] = "handling",
    ["why"] = "varför",
    ["ask"] = "be",
    ["men"] = "män",
    ["change"] = "förändring",
    ["went"] = "gick",
    ["light"] = "ljus",
    ["kind"] = "slag",
    ["off"] = "off",
    ["need"] = "behöver",
    ["house"] = "hus",
    ["picture"] = "bilden",
    ["try"] = "försök",
    ["us"] = "oss",
    ["again"] = "igen",
    ["animal"] = "djur",
    ["point"] = "punkt",
    ["mother"] = "mor",
    ["world"] = "världen",
    ["near"] = "nära",
    ["build"] = "bygga",
    ["self"] = "själv",
    ["earth"] = "jord",
    ["father"] = "far",
    ["any"] = "någon",
    ["new"] = "ny",
    ["work"] = "arbete",
    ["part"] = "delen",
    ["take"] = "ta",
    ["get"] = "få",
    ["place"] = "plats",
    ["made"] = "gjort",
    ["live"] = "lever",
    ["where"] = "där",
    ["after"] = "efter",
    ["back"] = "tillbaka",
    ["little"] = "liten",
    ["only"] = "endast",
    ["round"] = "rund",
    ["man"] = "människa",
    ["year"] = "år",
    ["came"] = "kom",
    ["show"] = "visar",
    ["every"] = "varje",
    ["good"] = "bra",
    ["me"] = "mig",
    ["give"] = "ge",
    ["our"] = "vår",
    ["under"] = "enligt",
    ["name"] = "namn",
    ["very"] = "mycket",
    ["through"] = "genom",
    ["just"] = "bara",
    ["form"] = "formulär",
    ["sentence"] = "meningen",
    ["great"] = "bra",
    ["think"] = "tro",
    ["say"] = "säga",
    ["help"] = "hjälpa",
    ["low"] = "låg",
    ["line"] = "linje",
    ["differ"] = "skiljer",
    ["turn"] = "tur",
    ["cause"] = "orsak",
    ["much"] = "mycket",
    ["mean"] = "betyda",
    ["before"] = "före",
    ["move"] = "drag",
    ["right"] = "höger",
    ["boy"] = "pojke",
    ["old"] = "gammal",
    ["too"] = "alltför",
    ["same"] = "samma",
    ["she"] = "hon",
    ["all"] = "alla",
    ["there"] = "där",
    ["when"] = "när",
    ["up"] = "upp",
    ["use"] = "använda",
    ["your"] = "din",
    ["way"] = "sätt",
    ["about"] = "ca",
    ["many"] = "många",
    ["bicycle shop"] = "cykelverkstad",
    ["them"] = "dem",
    ["write"] = "skriva",
    ["would"] = "skulle",
    ["like"] = "liknande",
    ["so"] = "så",
    ["these"] = "dessa",
    ["her"] = "hennes",
    ["long"] = "lång",
    ["make"] = "göra",
    ["thing"] = "sak",
    ["see"] = "se",
    ["him"] = "honom",
    ["two"] = "två",
    ["has"] = "har",
    ["look"] = "ser",
    ["more"] = "mer",
    ["day"] = "dag",
    ["could"] = "kunde",
    ["go"] = "gå",
    ["come"] = "komma",
    ["did"] = "gjorde",
    ["number"] = "antal",
    ["sound"] = "sund",
    ["no"] = "nej",
    ["most"] = "mest",
    ["people"] = "människor",
    ["my"] = "min",
    ["over"] = "över",
    ["know"] = "vet",
    ["water"] = "vatten",
    ["than"] = "än",
    ["call"] = "samtal",
    ["first"] = "först",
    ["who"] = "som",
    ["may"] = "får",
    ["down"] = "ner",
    ["side"] = "sida",
    ["been"] = "varit",
    ["now"] = "nu",
    ["find"] = "hitta",
    ["head"] = "huvud",
    ["stand"] = "stå",
    ["own"] = "egen",
    ["page"] = "sida",
    ["should"] = "bör",
    ["country"] = "land",
    ["found"] = "funnen",
    ["answer"] = "svar",
    ["school"] = "skola",
    ["grow"] = "växa",
    ["study"] = "studie",
    ["still"] = "fortfarande",
    ["learn"] = "lära",
    ["plant"] = "växt",
    ["cover"] = "lock",
    ["food"] = "mat",
    ["sun"] = "sol",
    ["four"] = "fyra",
    ["between"] = "mellan",
    ["state"] = "tillstånd",
    ["keep"] = "hålla",
    ["eye"] = "öga",
    ["never"] = "aldrig",
    ["last"] = "sista",
    ["let"] = "låt",
    ["thought"] = "trodde",
    ["city"] = "ort",
    ["tree"] = "träd",
    ["cross"] = "korsa",
    ["farm"] = "gård",
    ["hard"] = "hård",
    ["start"] = "start",
    ["might"] = "kanske",
    ["story"] = "berättelse",
    ["saw"] = "sågen",
    ["far"] = "långt",
    ["sea"] = "hav",
    ["draw"] = "rita",
    ["left"] = "vänster",
    ["late"] = "sen",
    ["run"] = "köra",
    ["donâ€™t"] = "inte",
    ["while"] = "medan",
    ["press"] = "tryck",
    ["close"] = "nära",
    ["night"] = "natt",
    ["real"] = "verklig",
    ["life"] = "liv",
    ["few"] = "några",
    ["north"] = "norr",
    ["book"] = "boken",
    ["carry"] = "bära",
    ["took"] = "tog",
    ["science"] = "vetenskap",
    ["eat"] = "äta",
    ["room"] = "rum",
    ["friend"] = "vän",
    ["began"] = "började",
    ["idea"] = "idé",
    ["fish"] = "fisk",
    ["mountain"] = "berg",
    ["stop"] = "stoppa",
    ["once"] = "en gång",
    ["base"] = "bas",
    ["hear"] = "höra",
    ["horse"] = "häst",
    ["cut"] = "snitt",
    ["sure"] = "säker",
    ["watch"] = "klocka",
    ["color"] = "färg",
    ["face"] = "ansikte",
    ["wood"] = "trä",
    ["main"] = "huvud",
    ["open"] = "öppen",
    ["seem"] = "tyckas",
    ["together"] = "tillsammans",
    ["next"] = "nästa",
    ["white"] = "vit",
    ["children"] = "barn",
    ["begin"] = "börja",
    ["got"] = "fick",
    ["walk"] = "gå",
    ["example"] = "exempel",
    ["ease"] = "lindra",
    ["paper"] = "papper",
    ["group"] = "grupp",
    ["always"] = "alltid",
    ["music"] = "musik",
    ["those"] = "de som",
    ["both"] = "båda",
    ["mark"] = "märke",
    ["often"] = "ofta",
    ["letter"] = "bokstav",
    ["until"] = "tills",
    ["mile"] = "mil",
    ["river"] = "flod",
    ["car"] = "bil",
    ["feet"] = "fot",
    ["care"] = "vård",
    ["second"] = "andra",
    ["enough"] = "tillräckligt",
    ["plain"] = "vanlig",
    ["girl"] = "flicka",
    ["usual"] = "vanligt",
    ["young"] = "ung",
    ["ready"] = "klar",
    ["above"] = "ovan",
    ["ever"] = "någonsin",
    ["red"] = "röd",
    ["list"] = "lista",
    ["though"] = "though",
    ["feel"] = "känna",
    ["talk"] = "diskussion",
    ["bird"] = "fågel",
    ["soon"] = "snart",
    ["body"] = "kropp",
    ["dog"] = "hund",
    ["family"] = "familj",
    ["direct"] = "direkt",
    ["pose"] = "pose",
    ["leave"] = "lämna",
    ["song"] = "sång",
    ["measure"] = "mäta",
    ["door"] = "dörr",
    ["product"] = "produkt",
    ["black"] = "svart",
    ["short"] = "kort",
    ["numeral"] = "siffran",
    ["class"] = "klass",
    ["wind"] = "vind",
    ["question"] = "fråga",
    ["happen"] = "hända",
    ["complete"] = "fullständig",
    ["ship"] = "skepp",
    ["area"] = "område",
    ["half"] = "halv",
    ["rock"] = "vagga",
    ["order"] = "för",
    ["fire"] = "eld",
    ["south"] = "söder",
    ["problem"] = "problemet",
    ["piece"] = "stycke",
    ["told"] = "sa",
    ["knew"] = "visste",
    ["pass"] = "passera",
    ["since"] = "sedan",
    ["top"] = "topp",
    ["whole"] = "hela",
    ["king"] = "kung",
    ["street"] = "gata",
    ["inch"] = "tum",
    ["multiply"] = "multiplicera",
    ["nothing"] = "ingenting",
    ["course"] = "Naturligtvis",
    ["stay"] = "bo",
    ["wheel"] = "hjul",
    ["full"] = "fullständig",
    ["force"] = "kraft",
    ["blue"] = "blå",
    ["object"] = "objektet",
    ["decide"] = "besluta",
    ["surface"] = "yta",
    ["deep"] = "djup",
    ["moon"] = "månen",
    ["island"] = "ö",
    ["foot"] = "fot",
    ["system"] = "systemet",
    ["busy"] = "upptagen",
    ["test"] = "testet",
    ["record"] = "register",
    ["boat"] = "båt",
    ["common"] = "gemensam",
    ["gold"] = "guld",
    ["possible"] = "möjlig",
    ["plane"] = "plan",
    ["stead"] = "stead",
    ["dry"] = "torka",
    ["wonder"] = "undra",
    ["laugh"] = "skratt",
    ["thousand"] = "tusen",
    ["ago"] = "sedan",
    ["ran"] = "ran",
    ["check"] = "ta",
    ["game"] = "spel",
    ["shape"] = "form",
    ["equate"] = "likställa",
    ["hot"] = "het",
    ["miss"] = "miss",
    ["brought"] = "bringas",
    ["heat"] = "hetta",
    ["snow"] = "snö",
    ["tire"] = "däcket",
    ["bring"] = "bringa",
    ["yes"] = "ja",
    ["distant"] = "avlägsen",
    ["fill"] = "fylla",
    ["east"] = "öst",
    ["paint"] = "måla",
    ["language"] = "språk",
    ["among"] = "bland",
    ["unit"] = "enhet",
    ["power"] = "kraft",
    ["town"] = "stad",
    ["fine"] = "fin",
    ["certain"] = "viss",
    ["fly"] = "flyga",
    ["fall"] = "falla",
    ["lead"] = "bly",
    ["cry"] = "rop",
    ["dark"] = "mörk",
    ["machine"] = "maskin",
    ["note"] = "anteckning",
    ["wait"] = "vänta",
    ["plan"] = "planen",
    ["figure"] = "figur",
    ["star"] = "stjärna",
    ["box"] = "låda",
    ["noun"] = "subst",
    ["field"] = "fält",
    ["rest"] = "resten",
    ["correct"] = "korrekt",
    ["able"] = "kunna",
    ["pound"] = "pund",
    ["done"] = "klar",
    ["beauty"] = "skönhet",
    ["drive"] = "enhet",
    ["stood"] = "stod",
    ["contain"] = "innehålla",
    ["front"] = "främre",
    ["teach"] = "undervisa",
    ["week"] = "vecka",
    ["final"] = "slutlig",
    ["gave"] = "gav",
    ["green"] = "grön",
    ["oh"] = "ack",
    ["quick"] = "sammanfattning",
    ["develop"] = "utveckla",
    ["ocean"] = "ocean",
    ["warm"] = "varm",
    ["free"] = "fri",
    ["minute"] = "minut",
    ["strong"] = "stark",
    ["special"] = "speciell",
    ["mind"] = "sinne",
    ["behind"] = "bakom",
    ["clear"] = "klar",
    ["tail"] = "svans",
    ["produce"] = "producera",
    ["fact"] = "faktum",
    ["space"] = "space",
    ["heard"] = "hört",
    ["best"] = "bäst",
    ["hour"] = "timme",
    ["better"] = "bättre",
    ["true"] = "sann",
    ["during"] = "under",
    ["hundred"] = "hundra",
    ["five"] = "fem",
    ["remember"] = "minnas",
    ["step"] = "steg",
    ["early"] = "tidig",
    ["hold"] = "håll",
    ["west"] = "väster",
    ["ground"] = "jord",
    ["interest"] = "intresse",
    ["reach"] = "nå",
    ["fast"] = "snabb",
    ["verb"] = "verb",
    ["sing"] = "sjunger",
    ["listen"] = "lyssna",
    ["six"] = "sex",
    ["table"] = "tabell",
    ["travel"] = "resor",
    ["less"] = "mindre",
    ["morning"] = "morgon",
    ["ten"] = "tio",
    ["simple"] = "enkel",
    ["several"] = "flera",
    ["vowel"] = "vokal",
    ["toward"] = "mot",
    ["war"] = "krig",
    ["lay"] = "låg",
    ["against"] = "mot",
    ["pattern"] = "mönster",
    ["slow"] = "långsam",
    ["center"] = "centrum",
    ["love"] = "kärlek",
    ["person"] = "personen",
    ["money"] = "pengar",
    ["serve"] = "tjäna",
    ["appear"] = "synas",
    ["road"] = "väg",
    ["map"] = "karta",
    ["rain"] = "regn",
    ["rule"] = "regel",
    ["govern"] = "regera",
    ["pull"] = "dra",
    ["cold"] = "förkylning",
    ["notice"] = "meddelande",
    ["voice"] = "röst",
    ["energy"] = "energi",
    ["hunt"] = "jakt",
    ["probable"] = "trolig",
    ["bed"] = "bädd",
    ["brother"] = "bror",
    ["egg"] = "ägg",
    ["ride"] = "ritt",
    ["cell"] = "cell",
    ["believe"] = "tro",
    ["perhaps"] = "kanske",
    ["pick"] = "plocka",
    ["sudden"] = "plötslig",
    ["count"] = "räkna",
    ["square"] = "kvadrat",
    ["reason"] = "anledningen",
    ["length"] = "längd",
    ["represent"] = "representerar",
    ["art"] = "teknikområdet",
    ["subject"] = "ämne",
    ["region"] = "region",
    ["size"] = "storlek",
    ["vary"] = "varierar",
    ["settle"] = "sedimentera",
    ["speak"] = "tala",
    ["weight"] = "vikt",
    ["general"] = "allmän",
    ["ice"] = "is",
    ["matter"] = "materia",
    ["circle"] = "cirkel",
    ["pair"] = "par",
    ["include"] = "inkluderar",
    ["divide"] = "divide",
    ["syllable"] = "stavelse",
    ["felt"] = "kände",
    ["grand"] = "stors",
    ["ball"] = "boll",
    ["yet"] = "ännu",
    ["wave"] = "våg",
    ["drop"] = "släpp",
    ["heart"] = "hjärta",
    ["am"] = "jag",
    ["present"] = "föreliggande",
    ["heavy"] = "tung",
    ["dance"] = "dans",
    ["engine"] = "motor",
    ["position"] = "ställning",
    ["arm"] = "beväpnar",
    ["wide"] = "bred",
    ["sail"] = "segel",
    ["material"] = "materialet",
    ["fraction"] = "fraktion",
    ["forest"] = "skog",
    ["sit"] = "sitta",
    ["race"] = "ras",
    ["window"] = "fönster",
    ["store"] = "lagra",
    ["summer"] = "sommar",
    ["train"] = "tåg",
    ["sleep"] = "sömn",
    ["prove"] = "bevisa",
    ["lone"] = "ensam",
    ["leg"] = "ben",
    ["exercise"] = "övning",
    ["wall"] = "vägg",
    ["catch"] = "fångst",
    ["mount"] = "fäste",
    ["wish"] = "vill",
    ["sky"] = "himmelsblå",
    ["board"] = "ombord",
    ["joy"] = "glädje",
    ["winter"] = "vinter",
    ["sat"] = "satellit",
    ["written"] = "skriven",
    ["wild"] = "vild",
    ["instrument"] = "instrumentet",
    ["kept"] = "hålls",
    ["glass"] = "glas",
    ["grass"] = "gräs",
    ["cow"] = "ko",
    ["job"] = "jobb",
    ["edge"] = "kanten",
    ["sign"] = "tecken",
    ["visit"] = "besök",
    ["past"] = "förbi",
    ["soft"] = "mjuk",
    ["fun"] = "kul",
    ["bright"] = "ljust",
    ["gas"] = "gas",
    ["weather"] = "väder",
    ["month"] = "månad",
    ["million"] = "miljoner",
    ["bear"] = "bära",
    ["finish"] = "yta",
    ["happy"] = "lycklig",
    ["hope"] = "hoppas",
    ["flower"] = "blomma",
    ["clothe"] = "kläder",
    ["strange"] = "främmande",
    ["gone"] = "borta",
    ["trade"] = "handel",
    ["melody"] = "melodi",
    ["trip"] = "resa",
    ["office"] = "kontor",
    ["receive"] = "motta",
    ["row"] = "rad",
    ["mouth"] = "mun",
    ["exact"] = "exakta",
    ["symbol"] = "symbol",
    ["die"] = "dö",
    ["least"] = "minst",
    ["trouble"] = "besvär",
    ["shout"] = "rop",
    ["except"] = "utom",
    ["wrote"] = "skrev",
    ["seed"] = "frö",
    ["tone"] = "ton",
    ["join"] = "ansluta",
    ["suggest"] = "föreslår",
    ["clean"] = "ren",
    ["break"] = "paus",
    ["lady"] = "damen",
    ["yard"] = "gård",
    ["rise"] = "stiga",
    ["bad"] = "dålig",
    ["blow"] = "smäll",
    ["oil"] = "olja",
    ["blood"] = "blod",
    ["touch"] = "Rör",
    ["grew"] = "växte",
    ["cent"] = "cent",
    ["mix"] = "blanda",
    ["team"] = "lag",
    ["wire"] = "tråd",
    ["cost"] = "kostnad",
    ["lost"] = "förlorat",
    ["brown"] = "brun",
    ["wear"] = "slitage",
    ["garden"] = "trädgård",
    ["equal"] = "lika",
    ["sent"] = "skickat",
    ["choose"] = "välja",
    ["fell"] = "föll",
    ["fit"] = "passa",
    ["flow"] = "flöde",
    ["fair"] = "verkligt",
    ["bank"] = "bank",
    ["collect"] = "samla",
    ["save"] = "spara",
    ["control"] = "kontroll",
    ["decimal"] = "decimala",
    ["ear"] = "örat",
    ["else"] = "annars",
    ["quite"] = "ganska",
    ["broke"] = "bröt",
    ["case"] = "fall",
    ["middle"] = "mitten",
    ["kill"] = "döda",
    ["son"] = "son",
    ["lake"] = "sjö",
    ["moment"] = "ögonblick",
    ["scale"] = "skala",
    ["loud"] = "högt",
    ["spring"] = "fjäder",
    ["observe"] = "observera",
    ["child"] = "barn",
    ["straight"] = "rak",
    ["consonant"] = "konsonant",
    ["nation"] = "nation",
    ["dictionary"] = "ordbok",
    ["milk"] = "mjölk",
    ["speed"] = "hastighet",
    ["method"] = "metod",
    ["organ"] = "organ",
    ["pay"] = "betala",
    ["age"] = "okänd",
    ["section"] = "sektion",
    ["dress"] = "klänning",
    ["cloud"] = "moln",
    ["surprise"] = "överraskning",
    ["quiet"] = "ro",
    ["stone"] = "sten",
    ["tiny"] = "liten",
    ["climb"] = "klättra",
    ["cool"] = "sval",
    ["design"] = "konstruktion",
    ["poor"] = "dålig",
    ["lot"] = "mycket",
    ["experiment"] = "experiment",
    ["bottom"] = "botten",
    ["key"] = "nyckel",
    ["iron"] = "järn",
    ["single"] = "singel",
    ["stick"] = "pinne",
    ["flat"] = "platt",
    ["twenty"] = "tjugo",
    ["skin"] = "hud",
    ["smile"] = "le",
    ["crease"] = "veck",
    ["hole"] = "hål",
    ["jump"] = "hoppa",
    ["baby"] = "barn",
    ["eight"] = "åtta",
    ["village"] = "by",
    ["meet"] = "möts",
    ["root"] = "rot",
    ["buy"] = "köpa",
    ["raise"] = "höja",
    ["solve"] = "lösa",
    ["metal"] = "metall",
    ["whether"] = "huruvida",
    ["push"] = "tryck",
    ["seven"] = "sju",
    ["paragraph"] = "punkt",
    ["third"] = "tredje",
    ["shall"] = "skall",
    ["held"] = "vänt",
    ["hair"] = "hår",
    ["describe"] = "beskriva",
    ["cook"] = "kock",
    ["floor"] = "våningen",
    ["either"] = "antingen",
    ["result"] = "resultat",
    ["burn"] = "bränna",
    ["hill"] = "kulle",
    ["safe"] = "säker",
    ["cat"] = "cat",
    ["century"] = "talet",
    ["consider"] = "överväga",
    ["type"] = "typ",
    ["law"] = "lag",
    ["bit"] = "bitars",
    ["coast"] = "kust",
    ["copy"] = "kopia",
    ["phrase"] = "fras",
    ["silent"] = "tyst",
    ["tall"] = "tall",
    ["sand"] = "sand",
    ["soil"] = "jord",
    ["roll"] = "rulle",
    ["temperature"] = "temperatur",
    ["finger"] = "finger",
    ["industry"] = "industrin",
    ["value"] = "värde",
    ["fight"] = "slagsmål",
    ["lie"] = "lie",
    ["beat"] = "slå",
    ["excite"] = "excitera",
    ["natural"] = "naturlig",
    ["view"] = "vy",
    ["sense"] = "känsla",
    ["capital"] = "kapital",
    ["wonâ€™t"] = "kommer inte",
    ["chair"] = "stol",
    ["danger"] = "fara",
    ["fruit"] = "frukt",
    ["rich"] = "rik",
    ["thick"] = "tjock",
    ["soldier"] = "soldat",
    ["process"] = "processen",
    ["operate"] = "fungera",
    ["practice"] = "praktiken",
    ["separate"] = "separat",
    ["difficult"] = "svårt",
    ["doctor"] = "läkare",
    ["please"] = "vänligen",
    ["protect"] = "skydda",
    ["noon"] = "middagstid",
    ["crop"] = "gröda",
    ["modern"] = "moderna",
    ["element"] = "elementet",
    ["hit"] = "hit",
    ["student"] = "studenten",
    ["corner"] = "hörn",
    ["party"] = "parti",
    ["supply"] = "försörjning",
    ["whose"] = "vars",
    ["locate"] = "lokalisera",
    ["ring"] = "ring",
    ["character"] = "karaktär",
    ["insect"] = "insekt",
    ["caught"] = "fångad",
    ["period"] = "period",
    ["indicate"] = "indikerar",
    ["radio"] = "radio",
    ["spoke"] = "talade",
    ["atom"] = "atomen",
    ["human"] = "humant",
    ["history"] = "historia",
    ["effect"] = "effekt",
    ["electric"] = "elektrisk",
    ["expect"] = "förvänta",
    ["bone"] = "ben",
    ["rail"] = "skena",
    ["imagine"] = "föreställa sig",
    ["provide"] = "tillhandahålla",
    ["agree"] = "enas",
    ["thus"] = "sålunda",
    ["gentle"] = "mild",
    ["woman"] = "kvinna",
    ["captain"] = "kapten",
    ["guess"] = "gissa",
    ["necessary"] = "nödvändig",
    ["sharp"] = "skarp",
    ["wing"] = "vinge",
    ["create"] = "skapa",
    ["neighbor"] = "granne",
    ["wash"] = "tvätt",
    ["bat"] = "slagträ",
    ["rather"] = "snarare",
    ["crowd"] = "publiken",
    ["corn"] = "majs",
    ["compare"] = "jämföra",
    ["poem"] = "dikt",
    ["string"] = "sträng",
    ["bell"] = "klocka",
    ["depend"] = "bero",
    ["meat"] = "kött",
    ["rub"] = "gnida",
    ["tube"] = "röret",
    ["famous"] = "känd",
    ["dollar"] = "dollarn",
    ["stream"] = "ström",
    ["fear"] = "rädsla",
    ["sight"] = "syn",
    ["thin"] = "tunn",
    ["triangle"] = "triangel",
    ["planet"] = "planet",
    ["hurry"] = "skynda",
    ["chief"] = "chef",
    ["colony"] = "koloni",
    ["clock"] = "klocka",
    ["mine"] = "gruva",
    ["tie"] = "slips",
    ["enter"] = "ange",
    ["major"] = "större",
    ["fresh"] = "färsk",
    ["search"] = "sök",
    ["send"] = "skicka",
    ["yellow"] = "gul",
    ["gun"] = "pistol",
    ["allow"] = "tillåta",
    ["print"] = "tryck",
    ["dead"] = "död",
    ["spot"] = "fläck",
    ["desert"] = "öken",
    ["suit"] = "kostym",
    ["current"] = "ström",
    ["lift"] = "lift",
    ["rose"] = "ros",
    ["arrive"] = "anländer",
    ["master"] = "mästare",
    ["track"] = "spår",
    ["parent"] = "förälder",
    ["shore"] = "stranden",
    ["division"] = "delning",
    ["sheet"] = "ark",
    ["substance"] = "substans",
    ["favor"] = "gynna",
    ["connect"] = "ansluta",
    ["post"] = "inlägg",
    ["spend"] = "spendera",
    ["chord"] = "ackord",
    ["fat"] = "fett",
    ["glad"] = "glad",
    ["original"] = "original",
    ["share"] = "andel",
    ["station"] = "station",
    ["dad"] = "pappa",
    ["bread"] = "bröd",
    ["charge"] = "debitera",
    ["proper"] = "ordentlig",
    ["bar"] = "baren",
    ["offer"] = "erbjudandet",
    ["segment"] = "segment",
    ["slave"] = "slav",
    ["duck"] = "anka",
    ["instant"] = "omedelbar",
    ["market"] = "marknad",
    ["degree"] = "grad",
    ["populate"] = "befolka",
    ["chick"] = "fågelunge",
    ["dear"] = "kära",
    ["enemy"] = "fiende",
    ["reply"] = "svara",
    ["drink"] = "dryck",
    ["occur"] = "inträffa",
    ["support"] = "stöd",
    ["speech"] = "tal",
    ["nature"] = "natur",
    ["range"] = "intervall",
    ["steam"] = "ånga",
    ["motion"] = "rörelse",
    ["path"] = "bana",
    ["liquid"] = "vätska",
    ["log"] = "logga",
    ["meant"] = "innebar",
    ["quotient"] = "kvoten",
    ["teeth"] = "tänder",
    ["shell"] = "skal",
    ["neck"] = "hals",
    ["oxygen"] = "syre",
    ["sugar"] = "socker",
    ["death"] = "död",
    ["pretty"] = "ganska",
    ["skill"] = "Förmåga",
    ["women"] = "kvinnor",
    ["season"] = "säsong",
    ["solution"] = "lösning",
    ["magnet"] = "magnet",
    ["silver"] = "silver",
    ["thank"] = "tack",
    ["branch"] = "gren",
    ["match"] = "matchen",
    ["suffix"] = "suffixet",
    ["especially"] = "speciellt",
    ["fig"] = "fig",
    ["afraid"] = "rädd",
    ["huge"] = "enormt",
    ["sister"] = "syster",
    ["steel"] = "stål",
    ["discuss"] = "diskutera",
    ["forward"] = "framåt",
    ["similar"] = "liknande",
    ["guide"] = "guide",
    ["experience"] = "erfarenhet",
    ["score"] = "poäng",
    ["apple"] = "äpple",
    ["bought"] = "köpt",
    ["led"] = "ledde",
    ["pitch"] = "tonhöjd",
    ["coat"] = "kappa",
    ["mass"] = "massa",
    ["card"] = "kort",
    ["band"] = "band",
    ["rope"] = "rep",
    ["slip"] = "halka",
    ["win"] = "win",
    ["dream"] = "dröm",
    ["evening"] = "kväll",
    ["condition"] = "tillstånd",
    ["feed"] = "foder",
    ["tool"] = "verktyg",
    ["total"] = "totalt",
    ["basic"] = "grundläggande",
    ["smell"] = "lukt",
    ["valley"] = "dal",
    ["nor"] = "eller",
    ["double"] = "dubbel",
    ["seat"] = "säte",
    ["continue"] = "fortsätta",
    ["block"] = "blocket",
    ["chart"] = "diagram",
    ["hat"] = "keps",
    ["sell"] = "sälja",
    ["success"] = "framgång",
    ["company"] = "företaget",
    ["subtract"] = "subtrahera",
    ["event"] = "händelse",
    ["particular"] = "särskilt",
    ["deal"] = "affär",
    ["swim"] = "simma",
    ["term"] = "term",
    ["opposite"] = "motsatt",
    ["wife"] = "fru",
    ["shoe"] = "sko",
    ["innovation"] = "innovation",
    ["spread"] = "spridning",
    ["arrange"] = "ordna",
    ["camp"] = "läger",
    ["invent"] = "uppfinna",
    ["cotton"] = "bomull",
    ["born"] = "Född",
    ["determine"] = "bestämma",
    ["quart"] = "quart",
    ["nine"] = "nio",
    ["truck"] = "lastbil",
    ["noise"] = "buller",
    ["level"] = "nivå",
    ["chance"] = "chans",
    ["gather"] = "samla",
    ["shop"] = "butik",
    ["stretch"] = "sträcka",
    ["throw"] = "kasta",
    ["shine"] = "glans",
    ["property"] = "egenskap",
    ["column"] = "kolonn",
    ["molecule"] = "molekyl",
    ["select"] = "välj",
    ["wrong"] = "fel",
    ["gray"] = "grå",
    ["repeat"] = "upprepning",
    ["require"] = "kräva",
    ["broad"] = "bred",
    ["prepare"] = "förbereda",
    ["salt"] = "salt",
    ["nose"] = "näsa",
    ["plural"] = "plural",
    ["anger"] = "ilska",
    ["claim"] = "krav",
    ["continent"] = "kontinent"    
}

TRANSLATION_TBL = FRENCH_TBL
REVERSED_TBL = {}


englishWord = ""

OBSTACLE_TBL = {}
BUBBLE_TBL = {}
tempObstacledx = {}
tempObstacledy = {}
tempBubbledx = {}
tempBubbledy = {}
tempSlidedy = 0

correctBubble = 1

testingword = ''
testingtbl = {}
newBubbleWord = true

level = false

--[[
    Called just once at the beginning of the game; used to set up
    game objects, variables, etc. and prepare the game world.
]]

function love.load()
    -- set love's default filter to "nearest-neighbor", which essentially
    -- means there will be no filtering of pixels (blurriness), which is
    -- important for a nice crisp, 2D look
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- set the title of our application window
    love.window.setTitle('Vocabulanes')

    -- seed the RNG so that calls to random are always random
    math.randomseed(os.time())

    -- initialize our nice-looking retro text fonts
    smallFont = love.graphics.newFont('ARLRDBD.ttf', 8, 'normal', 2)
    largeFont = love.graphics.newFont('ARLRDBD.ttf', 16, 'normal', 2)
    scoreFont = love.graphics.newFont('ARLRDBD.ttf', 32, 'normal', 2)
    love.graphics.setFont(smallFont)

    -- set up our sound effects; later, we can just index this table and
    -- call each entry's `play` method
    -- Irreducible by ComaStudio
    sounds = {
        ['correct'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['death'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['speed_up'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
        ['background'] = love.audio.newSource('sounds/background.mp3','stream'),
    }


    -- initialize our virtual resolution, which will be rendered within our
    -- actual window no matter its dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        canvas = false
    })

    -- initialize our player paddles; make them global so that they can be
    -- detected by other functions and modules

    player1 = Paddle(10, VIRTUAL_HEIGHT-70, 10, 10)

    -- place a ball in the middle of the screen
    slide = Slide(2, 0, -60, VIRTUAL_WIDTH, 60, 25, 0)

    -- initialize score variables
    player1Score = 0

    -- the state of our game; can be any of the following:
    -- 1. 'start' (the beginning of the game, before first slide)
    -- 2. 'play' (the slide is in play, bouncing between paddles)
    -- 3. 'done' (the game is over, with a victor, ready for restart)
    gameState = 'start'
end

function love.resize(w, h)
    push:resize(w, h)
end

function randomkey(tbl)
    choice = "F"
    n = 0
    for i, o in pairs(tbl) do
        n = n + 1
        if math.random() < (1/n) then 
            choice = i
        end
    end
    return choice
end

function distractors(tbl, englishWord)
    n = 0
    temptbl = {}
    temptbl2 = {}
    
    for k, v in pairs(tbl) do
        if k ~= englishWord then
            n = n + 1
            temptbl[n] = v
        end
    end
    for i = 1,slide.num_options,1 do
        randval = math.random(1,#temptbl)
        temptbl2[i] = table.remove(temptbl,randval)
    end
    return temptbl2
end

function love.update(dt) 
    if not sounds['background']:isPlaying() then
        love.audio.play(sounds['background'])
    end
    if gameState == 'start' then
        englishWord = randomkey(TRANSLATION_TBL)
        swedishWords = distractors(TRANSLATION_TBL,englishWord)   
    end 
    if gameState == 'resuming' then
        if level == true then
            slide.dy = tempSlidedy
            for i=1,#OBSTACLE_TBL,1 do 
                OBSTACLE_TBL[i].dx = tempObstacledx[i]
                OBSTACLE_TBL[i].dy = tempObstacledy[i]
            end
        else
            for i=1,#BUBBLE_TBL,1 do 
                BUBBLE_TBL[i].dx = tempBubbledx[i]
                BUBBLE_TBL[i].dy = tempBubbledy[i]
            end
        end
        gameState = 'play'
    end
    if gameState == 'play' then
        if level == true then
            if slide:collides(player1) then
                if slide.x+(slide.width/slide.num_options)*(slide.correct-1) < player1.x+player1.width/2 and
                slide.x+(slide.width/slide.num_options)*(slide.correct) > player1.x+player1.width/2 then
                    player1Score = player1Score + 1
                    sounds['correct']:play()
                    if player1Score % 3 == 0 and #OBSTACLE_TBL < 6 then
                        OBSTACLE_TBL[player1Score/3] = Obstacle(math.min(60,math.max(20,math.random(10,#OBSTACLE_TBL*15))), math.min(60,math.max(20,math.random(10,#OBSTACLE_TBL*15))), math.random(30,slide.dy))
                    end
                    if player1Score % 5 == 0 and slide.num_options < 5 then
                        FONT_HEIGHT = FONT_HEIGHT - 2
                        largeFont = love.graphics.newFont('ARLRDBD.ttf', FONT_HEIGHT, 'normal', 2)
                        slide = Slide(slide.num_options+1, 0, -60, VIRTUAL_WIDTH, 60, math.min(80, slide.dy*1.05), slide.reverse)
                    else
                        slide = Slide(slide.num_options, 0, -60, VIRTUAL_WIDTH, 60, math.min(80, slide.dy*1.05), slide.reverse)
                    end
                    if player1Score % 10 == 0 then
                        slide.reverse = slide.reverse + 1
                    end
                    if player1Score == 20 then
                        level = false
                    end
                    if slide.reverse % 2 == 0 then
                        englishWord = randomkey(TRANSLATION_TBL)
                        swedishWords = distractors(TRANSLATION_TBL,englishWord)
                    else 
                        for k,v in pairs(TRANSLATION_TBL) do
                            REVERSED_TBL[v] = k
                        end
                        englishWord = randomkey(REVERSED_TBL)
                        swedishWords = distractors(REVERSED_TBL,englishWord)
                    end

                else
                    sounds['death']:play()
                    gameState = 'death'
                    for i = 1, #OBSTACLE_TBL,1 do
                        OBSTACLE_TBL[i]:reset()
                    end
                    OBSTACLE_TBL = {}
                    if slide.reverse % 2 ~= 0 then
                        englishWord = REVERSED_TBL[englishWord]
                    end
                    slide:reset()
                    FONT_HEIGHT = 16
                end
            end
            for i = 1, #OBSTACLE_TBL,1 do
                if OBSTACLE_TBL[i].x+OBSTACLE_TBL[i].width < 0 or OBSTACLE_TBL[i].x > VIRTUAL_WIDTH or OBSTACLE_TBL[i].y > VIRTUAL_HEIGHT then
                    OBSTACLE_TBL[i]:reset()
                    OBSTACLE_TBL[i].width = math.min(60,math.max(20,math.random(10,#OBSTACLE_TBL*15)))
                    OBSTACLE_TBL[i].width = math.min(60,math.max(20,math.random(10,#OBSTACLE_TBL*15)))
                end
                if OBSTACLE_TBL[i]:collides(player1) then
                    sounds['death']:play()
                    gameState = 'death'
                    if slide.reverse % 2 ~= 0 then
                        englishWord = REVERSED_TBL[englishWord]
                    end
                    slide:reset()
                    for i = 1, #OBSTACLE_TBL,1 do
                        OBSTACLE_TBL[i]:reset()
                    end
                    OBSTACLE_TBL = {}
                    break
                end
            end
        
        else
            if newBubbleWord == true then
                BUBBLE_TBL = {}
                englishWord = bubbleWord()
                testingword = englishWord
                bubbleXCoord = {}
                bubbleYCoord = {}
                for i=1, string.len(TRANSLATION_TBL[englishWord]), 1 do 
                    bubbleCoords(i)   
                end
                for i=1, string.len(TRANSLATION_TBL[englishWord]), 1 do
                    BUBBLE_TBL[i] = Bubble(bubbleXCoord[i],bubbleYCoord[i],20,math.random(-90,90),math.random(-90,90),utf8_sub2(TRANSLATION_TBL[englishWord],i,i))
                end
                newBubbleWord = false
            end
            for i=1,#BUBBLE_TBL,1 do
                added = false
                if BUBBLE_TBL[i]:collides(player1) then
                    if BUBBLE_TBL[i].letter == BUBBLE_TBL[correctBubble].letter then
                        sounds['correct']:play()
                        BUBBLE_TBL[i]:pop()
                        correctBubble = correctBubble + 1
                    else
                        sounds['death']:play()
                        gameState = 'death'
                        for j = 1, #BUBBLE_TBL,1 do
                            BUBBLE_TBL[i]:pop()
                        end
                        player1Score = 0
                        newBubbleWord = true
                        correctBubble = 1
                        break
                    end
                    if correctBubble-1 == #BUBBLE_TBL then
                        newBubbleWord = true
                        player1Score = player1Score + 1
                        correctBubble = 1
                    end
                    if player1Score == 30 then
                        level = true
                    end
                end
            end

        end
        if player1Score == 100 then
            gameState = 'done'
        end
    end

    --
    -- paddles can move no matter what state we're in
    --
    -- player 1
    if gameState ~= 'pause' then
        if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
            player1.dx = -PADDLE_SPEED
        elseif love.keyboard.isDown('right') or love.keyboard.isDown('d') then
            player1.dx = PADDLE_SPEED
        else
            player1.dx = 0
        end

        if love.keyboard.isDown('up') or love.keyboard.isDown('w') then
            player1.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('down') or love.keyboard.isDown('s') then
            player1.dy = PADDLE_SPEED
        else
            player1.dy = 0
        end
    else 
        player1.dx = 0
        player1.dy = 0
    end

    -- update our ball based on its DX and DY only if we're in play state;
    -- scale the velocity by dt so movement is framerate-independent
    if (gameState == 'play' or gameState == 'pause') and level == true then
        slide:update(dt)
        for i = 1, #OBSTACLE_TBL,1 do
            OBSTACLE_TBL[i]:update(dt)
        end
    end

    bubbleUpdate(dt)

    if gameState == 'pausing' and level == true then
        tempSlidedy = slide.dy
        slide.dy = 0
        for i=1,#OBSTACLE_TBL,1 do 
            tempObstacledx[i] = OBSTACLE_TBL[i].dx
            tempObstacledy[i] = OBSTACLE_TBL[i].dy
            OBSTACLE_TBL[i].dx = 0
            OBSTACLE_TBL[i].dy = 0
        end
        gameState = 'pause'
    end

    if gameState == 'pausing' and level == false then
        for i=1,#BUBBLE_TBL,1 do 
            tempBubbledx[i] = BUBBLE_TBL[i].dx
            tempBubbledy[i] = BUBBLE_TBL[i].dy
            BUBBLE_TBL[i].dx = 0
            BUBBLE_TBL[i].dy = 0
        end
        gameState = 'pause'
    end

    player1:update(dt)
end

function utf8_sub2(s, start_char_idx, end_char_idx)
    start_byte_idx = utf8.offset(s, start_char_idx)
    end_byte_idx = utf8.offset(s, end_char_idx + 1)
    if start_byte_idx == nil then
        start_byte_idx = 1
    end
    if end_byte_idx == nil then
        end_byte_idx = -1
    else
        end_byte_idx = end_byte_idx - 1
    end
    return string.sub(s, start_byte_idx, end_byte_idx)
end

function love.keypressed(key)
    -- `key` will be whatever key this callback detected as pressed
    
    if key == 'space' then
        if gameState == 'play' then
            gameState = 'pausing'
        elseif gameState == 'pause' then
            gameState = 'resuming'
        end
    end
    if key == 'escape' then
        -- the function LÖVE2D uses to quit the application
        love.event.quit()
    elseif key == 'backspace' then
        gameState = 'start'
        slide:reset()
        -- reset scores to 0
        player1Score = 0
    
    elseif key == '1' then
        if gameState == 'start' then
            TRANSLATION_TBL = FRENCH_TBL
        end
    elseif key == '2' then
        if gameState == 'start' then
            TRANSLATION_TBL = SWEDISH_TBL
        end
    elseif key == 'enter' or key == 'return' then
        if gameState == 'done' or gameState == 'death' or gameState == 'start' then
            englishWord = randomkey(TRANSLATION_TBL)
            swedishWords = distractors(TRANSLATION_TBL,englishWord)
            FONT_HEIGHT = 16
            gameState = 'play'
            -- reset scores to 0
            player1Score = 0
        end
    end
end

function bubbleWord()
    englishWord = randomkey(TRANSLATION_TBL)
    if string.len(TRANSLATION_TBL[englishWord]) > 8 then
        return bubbleWord()
    end
    return englishWord
end

function love.draw()
    -- begin drawing with push, in our virtual resolution
    push:start()

    love.graphics.clear(0/255,0/255,0/255,255/255)

    -- render different things depending on which part of the game we're in
    if gameState == 'start' then
        -- UI messages
        love.graphics.setFont(smallFont)
        love.graphics.setColor(255/255,195/255,0/255,255/255)
        love.graphics.printf('Welcome to Vocabulanes!', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('WASD or Arrow Keys to move.', 0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Pick a language!', 0, 50, VIRTUAL_WIDTH, 'center')
        height = 100
        if TRANSLATION_TBL == FRENCH_TBL then
            love.graphics.setFont(largeFont)
            height = height-5
        end
        love.graphics.printf('1. French', 0, height, VIRTUAL_WIDTH/2, 'center')
        love.graphics.setFont(smallFont)
        height = 100
        if TRANSLATION_TBL == SWEDISH_TBL then
            love.graphics.setFont(largeFont)  
            height = height-5
        end
        love.graphics.printf('2. Swedish', VIRTUAL_WIDTH/2, height, VIRTUAL_WIDTH/2, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press return to start.', 0, VIRTUAL_HEIGHT-50, VIRTUAL_WIDTH,'center')
    elseif (gameState == 'play' or gameState == 'pause') and level == true then
        love.graphics.setFont(scoreFont)
        if slide.reverse % 2 == 0 then
            love.graphics.setColor(255/255,195/255,0/255,255/255)
        else
            love.graphics.setColor(255/255,87/255,51/255,255/255)
        end
        love.graphics.printf(englishWord, 0, VIRTUAL_HEIGHT-50, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(largeFont)
        if slide.reverse % 2 == 0 then
            slide:render(TRANSLATION_TBL, englishWord, swedishWords)
        else
            slide:render(REVERSED_TBL, englishWord, swedishWords)
        end
        for i = 1, #OBSTACLE_TBL,1 do
            OBSTACLE_TBL[i]:render()
        end
    elseif (gameState == 'play' or gameState == 'pause') and level == false then
        for i = 1, #BUBBLE_TBL,1 do 
            BUBBLE_TBL[i]:render()
        end
        love.graphics.setFont(scoreFont)
        love.graphics.setColor(0, 1, 0, 255/255)
        if correctBubble ~= 0 then
            love.graphics.printf(TRANSLATION_TBL[englishWord]:sub(0,correctBubble-1),0,10,VIRTUAL_WIDTH,'center')
        end
        love.graphics.printf(englishWord, 0, VIRTUAL_HEIGHT-50, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'death' then
        love.graphics.setFont(scoreFont)
        love.graphics.setColor(255/255, 0, 0, 255/255)
        love.graphics.printf(englishWord, 0, VIRTUAL_HEIGHT/2-40, VIRTUAL_WIDTH, 'center')
        love.graphics.printf(TRANSLATION_TBL[englishWord], 0, VIRTUAL_HEIGHT/2+10, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(255/255,195/255,0/255,255/255)
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Enter to restart!', 0, VIRTUAL_HEIGHT-60, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press backspace to return to menu.', 0, VIRTUAL_HEIGHT-40, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'done' then
        -- UI messages
        love.graphics.setFont(largeFont)
        love.graphics.printf('You win!',0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Enter to restart!', 0, 30, VIRTUAL_WIDTH, 'center')
    end

    -- show the score before ball is rendered so it can move over the text
    
    player1:render()

    displayScore()
    
    -- end our drawing to push
    push:finish()
end

function displayScore()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(242/255, 174/255, 255/255, 255/255)
    love.graphics.print('Score: ' .. tostring(player1Score), 10, 10)
    love.graphics.setColor(255/255,87/255,51/255,255/255)
end

function bubbleUpdate(dt)
    if (gameState == 'play' or gameState == 'pause') and level == false then
        for i=1,#BUBBLE_TBL,1 do
            if BUBBLE_TBL[i].popped == false then
                for j=i+1,#BUBBLE_TBL,1 do 
                    if BUBBLE_TBL[i]:bounce(BUBBLE_TBL[j]) then
                        if BUBBLE_TBL[i].x < BUBBLE_TBL[j].x then
                            BUBBLE_TBL[i].x = BUBBLE_TBL[i].x-2
                            BUBBLE_TBL[j].x = BUBBLE_TBL[j].x+2
                        else
                            BUBBLE_TBL[i].x = BUBBLE_TBL[i].x+2
                            BUBBLE_TBL[j].x = BUBBLE_TBL[j].x-2
                        end
                        if BUBBLE_TBL[i].y < BUBBLE_TBL[j].y then
                            BUBBLE_TBL[i].y = BUBBLE_TBL[i].y-2
                            BUBBLE_TBL[j].y = BUBBLE_TBL[j].y+2
                        else
                            BUBBLE_TBL[i].y = BUBBLE_TBL[i].y+2
                            BUBBLE_TBL[j].y = BUBBLE_TBL[j].y-2
                        end
                        tempDX = BUBBLE_TBL[j].dx
                        tempDY = BUBBLE_TBL[j].dy
                        BUBBLE_TBL[j].dx = BUBBLE_TBL[i].dx
                        BUBBLE_TBL[j].dy = BUBBLE_TBL[i].dy
                        BUBBLE_TBL[i].dx = tempDX
                        BUBBLE_TBL[i].dy = tempDY
                    end
                end

                if BUBBLE_TBL[i].x-BUBBLE_TBL[i].radius < 0 then
                    BUBBLE_TBL[i].dx = -BUBBLE_TBL[i].dx
                    BUBBLE_TBL[i].x = 2+BUBBLE_TBL[i].radius
                elseif BUBBLE_TBL[i].x+BUBBLE_TBL[i].radius > VIRTUAL_WIDTH then
                    BUBBLE_TBL[i].dx = -BUBBLE_TBL[i].dx
                    BUBBLE_TBL[i].x = VIRTUAL_WIDTH-2-BUBBLE_TBL[i].radius
                end
                if BUBBLE_TBL[i].y-BUBBLE_TBL[i].radius < 0 then
                    BUBBLE_TBL[i].dy = -BUBBLE_TBL[i].dy
                    BUBBLE_TBL[i].y = 2+BUBBLE_TBL[i].radius
                elseif BUBBLE_TBL[i].y+BUBBLE_TBL[i].radius > VIRTUAL_HEIGHT then
                    BUBBLE_TBL[i].dy = -BUBBLE_TBL[i].dy
                    BUBBLE_TBL[i].y = VIRTUAL_HEIGHT-2-BUBBLE_TBL[i].radius
                end
                BUBBLE_TBL[i]:update(dt)
            end
        end
    end
end

function bubbleCoords(i)
    
    leftright = math.random(0,1)
    updown = math.random(0,1)

    if player1.x<81 then
        x = math.random(player1.x+player1.width+60,VIRTUAL_WIDTH-20)
    elseif player1.x>VIRTUAL_WIDTH-61 then
        x = math.random(20,player1.x-60)
    else
        if leftright == 0 then
            x = math.random(20,player1.x-60)
        else 
            x = math.random(player1.x+player1.width+60,VIRTUAL_WIDTH-20)
        end
    end

    if player1.y<81 then 
        y = math.random(player1.y+player1.height,VIRTUAL_HEIGHT-20)
    elseif player1.y+player1.height>VIRTUAL_HEIGHT-81 then
        y = math.random(20,player1.y-60)
    else
        if updown == 0 then
            y = math.random(20,player1.y-60)
        else 
            y = math.random(player1.y+player1.height+60,VIRTUAL_HEIGHT-20)
        end
    end
    
    bubbleXCoord[i] = x
    bubbleYCoord[i] = y

    for j = 1, #bubbleXCoord,1 do 
        if bubbleXCoord[j] < x then
            if bubbleXCoord[j]+41 > x then
                bubbleCoords(i)
            end
        elseif bubbleXCoord[j] > x then
            if bubbleXCoord[j]-41 < x then
                bubbleCoords(i)
            end
        elseif bubbleYCoord[j] < y then
            if bubbleYCoord[j]+41 > y then
                bubbleCoords(i)
            end
        elseif bubbleYCoord[j] > y then
            if bubbleYCoord[j]-41 < y then
                bubbleCoords(i)
            end 
        end
    end
end

--  angle = math.atan(1.dy/1.dx)
