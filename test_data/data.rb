require 'json'

def test_data
  data = JSON.parse('{
    "id": "PPA",
    "version": "0100",
    "transaction": {
      "id": "PPA12312345512333",
      "code": "PA",
      "description": "PIN Alert",
      "timestamp": 20131204155026,
      "reason": {
        "code": "AC",
        "description": "New Application Bank",
        "abvDescription": "New App Bank"
      }
    },
    "dtc": {
      "subcode": 1563080
    },
    "consumer": {
      "id": "118271201"
    },
    "product": {
      "code": "PID",
      "description": "Precise ID",
      "option": {
        "code": "6",
        "description": "Account OpeningScore",
        "type": {
          "code": "AP",
          "description": "New Application",
          "abvDescription": "New App"
        }
      },
      "transaction": {
        "id": "10425477"
      }
    },
    "client": {
      "subcode": 3456789,
      "name": "Bank of America",
      "abvName": "BAC",
      "description": "An American multinational banking and financial services corporation, the  largest  bank  holding  company  in  the  United  States,  by  assets,  and  the  second largest bank by market capitalization.",
      "abvDescription": "An   American   multinational   banking   and   financial   services corporation",
      "kob": {
        "code": "BB",
        "description": "Bank",
        "abvDescription": "Bank"
      },
      "contact": {
        "phone": 8007329194,
        "email": "frauddept@bac.com",
        "hours": "8 AM -5 PM EST, Monday thru Friday, except holidays",
        "address": {
          "street1": "P.O. Box 15019",
          "city": "Wilmington",
          "state": "DE",
          "zipcode": 198505019
        }
      }
    }
  }')
end
