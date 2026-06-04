//
//  Supabase.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Supabase
 
let supabaseURL = URL(string: "https://wbrpsjwtskjtogwdrpub.supabase.co")!
 
let supabase = SupabaseClient(
    
    supabaseURL: supabaseURL,
    
    supabaseKey: "sb_publishable_ocyXB2OBQZmJQVeZSFgPYw_au2EBT1n",
    
    options: SupabaseClientOptions(
        auth: .init(
            // Opt-in to the new behavior for session handling
            emitLocalSessionAsInitialSession: true
        )
    )
    
)
