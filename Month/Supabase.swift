import Foundation
import Supabase

private struct SupabaseCredentials {
    static let url = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as! String
    static let anonKey = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as! String
}


let supabase = SupabaseClient(
  supabaseURL: URL(string: SupabaseCredentials.url)!,
  supabaseKey: SupabaseCredentials.anonKey
) 
