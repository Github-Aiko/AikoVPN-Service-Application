package com.sail_tunnel.sail.utils

import android.annotation.SuppressLint
import android.app.Application
import android.content.Context
import androidx.work.Configuration

class DeviceStorageApp : Application(), Configuration.Provider {
    override fun getWorkManagerConfiguration(): Configuration {
        // Provide the necessary WorkManager configuration
        return Configuration.Builder()
            // Set your desired configuration options
            .build()
    }
}
