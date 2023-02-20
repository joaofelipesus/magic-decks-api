defmodule MagicDecks.MagicApi.MagicCardTest do
  use ExUnit.Case
  alias MagicDecks.MagicApi.MagicCard

  describe "build/1" do
    test "returns an MagicCard with correct assignments" do
      params = %{
        "artist" => "Terese Nielsen",
        "cmc" => 8.0,
        "colorIdentity" => ["W"],
        "colors" => ["W"],
        "flavor" => "\"Wrath is no vice when inflicted upon the deserving.\"",
        "foreignNames" => [
          %{
            "flavor" =>
              "„Zorn ist kein Laster, wenn er sich gegen die richtet, die ihn verdienen.\"",
            "imageUrl" =>
              "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=482952&type=card",
            "language" => "German",
            "multiverseid" => 482_952,
            "name" => "Akroma, Engel des Zorns",
            "text" =>
              "Fliegend, Erstschlag, Wachsamkeit, verursacht Trampelschaden, Eile, Schutz vor Schwarz und vor Rot",
            "type" => "Legendäre Kreatur — Engel"
          },
          %{
            "flavor" =>
              "\"La ira no es moralmente incorrecta cuando se inflige a aquellos que la merecen\".",
            "imageUrl" =>
              "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=483203&type=card",
            "language" => "Spanish",
            "multiverseid" => 483_203,
            "name" => "Akroma, ángel de ira",
            "text" =>
              "Vuela, daña primero, vigilancia, arrolla, prisa, protección contra negro y contra rojo.",
            "type" => "Criatura legendaria — Ángel"
          },
          %{
            "flavor" => "La colère est justifiée si on la déchaîne sur ceux qui le méritent.",
            "imageUrl" =>
              "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=483454&type=card",
            "language" => "French",
            "multiverseid" => 483_454,
            "name" => "Akroma, ange de la Colère",
            "text" =>
              "Vol, initiative, vigilance, piétinement, célérité, protection contre le noir et contre le rouge",
            "type" => "Créature légendaire : ange"
          },
          %{
            "flavor" => "\"La collera non è un vizio quando inflitta a chi lo merita.\"",
            "imageUrl" =>
              "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=483705&type=card",
            "language" => "Italian",
            "multiverseid" => 483_705,
            "name" => "Akroma, Angelo della Distruzione",
            "text" =>
              "Volare, attacco improvviso, cautela, travolgere, rapidità, protezione dal nero e dal rosso",
            "type" => "Creatura Leggendaria — Angelo"
          },
          %{
            "flavor" => "「報いられるべき者に対する怒りは悪ではない。」",
            "imageUrl" =>
              "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=483956&type=card",
            "language" => "Japanese",
            "multiverseid" => 483_956,
            "name" => "怒りの天使アクローマ",
            "text" => "飛行、先制攻撃、警戒、トランプル、速攻、プロテクション（黒）、プロテクション（赤）",
            "type" => "伝説のクリーチャー — 天使"
          },
          %{
            "flavor" => "\"A ira não é pecado quando voltada contra os que a merecem.\"",
            "imageUrl" =>
              "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=484207&type=card",
            "language" => "Portuguese (Brazil)",
            "multiverseid" => 484_207,
            "name" => "Akroma, Anjo da Ira",
            "text" =>
              "Voar, iniciativa, vigilância, atropelar, ímpeto, proteção contra o preto, proteção contra o vermelho",
            "type" => "Criatura Lendária — Anjo"
          },
          %{
            "flavor" => "Гнев — это не rpex, когда он обращен на тех, кто этого заслуживает.",
            "imageUrl" =>
              "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=484458&type=card",
            "language" => "Russian",
            "multiverseid" => 484_458,
            "name" => "Акрома, Ангел Ярости",
            "text" =>
              "Полет, Первый удар, Бдительность, Пробивной удар, Ускорение, Защита от черного и от красного",
            "type" => "Легендарное Существо — Ангел"
          }
        ],
        "id" => "e4c94bde-8bd2-5b5d-bd7b-aa7c4b0b2fcd",
        "imageUrl" =>
          "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=482701&type=card",
        "layout" => "normal",
        "legalities" => [
          %{"format" => "Commander", "legality" => "Legal"},
          %{"format" => "Duel", "legality" => "Legal"},
          %{"format" => "Legacy", "legality" => "Legal"},
          %{"format" => "Modern", "legality" => "Legal"},
          %{"format" => "Premodern", "legality" => "Legal"},
          %{"format" => "Vintage", "legality" => "Legal"}
        ],
        "manaCost" => "{5}{W}{W}{W}",
        "multiverseid" => "482701",
        "name" => "Akroma, Angel of Wrath",
        "number" => "73",
        "originalText" =>
          "Flying, first strike, vigilance, trample, haste, protection from black and from red",
        "originalType" => "Legendary Creature — Angel",
        "power" => "6",
        "printings" => ["A25", "C20", "DDC", "DVD", "LGN", "SLD", "TSB", "V15"],
        "rarity" => "Mythic",
        "set" => "C20",
        "setName" => "Commander 2020",
        "subtypes" => ["Angel"],
        "supertypes" => ["Legendary"],
        "text" =>
          "Flying, first strike, vigilance, trample, haste, protection from black and from red",
        "toughness" => "6",
        "type" => "Legendary Creature — Angel",
        "types" => ["Creature"]
      }

      result = MagicCard.build(params)

      assert %MagicDecks.MagicApi.MagicCard{
               colors: ["W"],
               image_url:
                 "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=482701&type=card",
               mana_cost: "{5}{W}{W}{W}",
               name_en: "Akroma, Angel of Wrath",
               name_pt: "Akroma, Anjo da Ira",
               power: "6",
               rarity: :mythic,
               set: "Commander 2020",
               set_number: "73",
               toughness: "6",
               types: ["Creature"]
             } == result
    end
  end
end
