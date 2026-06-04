//
//  Supabase.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 1/6/2026.
//

import Foundation
import Supabase

// IMPORTANT: Replace these with your actual Supabase project details
// You can find these in your Supabase Project Settings > API
let supabase = SupabaseClient(
    supabaseURL: URL(string: "https://your-project-url.supabase.co")!,
    supabaseKey: "your-anon-key"
)
