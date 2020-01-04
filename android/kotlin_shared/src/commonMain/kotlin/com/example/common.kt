package com.example

expect fun platformName(): String

fun greetFromKotlin() : String {
    return "Kotlin Rocks on ${platformName()}"
}