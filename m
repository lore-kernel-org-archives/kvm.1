Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B693F6C42
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932080; cv=none; b=ekJRksb52aUMQqLuRulzAx8Ht55g1KeafaaIB/bhFUSAt6dC2V/ld4Qd5q+HSBGc+nhPT0Ir/nrW7g1GYSKjxL6mui2lGBqAs3RxnuOCOys2M1quVS9IMTY0ka7KtAfZQ0yDjGfYyPp4G5oODdjPQ6xNABoY7suu2W0gkim1xPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932080; c=relaxed/simple;
	bh=TllcPOqlup7SXA5RFjoQcTQnQnLKyJxzu6NP90Sb1l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElG8qIfK0gWmKfjWXvOaLOpYmxDGV5aIgHg3gDht9wHHexJUIKI+Aws5i+/ujtkGWN1og6F/+zAlBzkdbdMYOUDEgacJ8iwqO8xF05S4SK1MMxRhvbigwrSqqf2O8xZI6Rbs/EEdgr+lhGGFmTBXLxl6CUTyJz36ZZl2UELApb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C5AE5202948;
	Mon,  8 Jun 2026 17:21:15 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>
Cc: philmd@linaro.org,
	marcel.apfelbaum@gmail.com,
	zhao1.liu@intel.com,
	berrange@redhat.com,
	mst@redhat.com,
	cohuck@redhat.com,
	mtosatti@redhat.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	coconut-svsm@lists.linux.dev,
	joerg.roedel@amd.com
Subject: [RFC PATCH 07/10] hw/core/machine: Add device-plane property
Date: Mon,  8 Jun 2026 17:21:06 +0200
Message-ID: <20260608152109.356783-8-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608152109.356783-1-joro@8bytes.org>
References: <20260608152109.356783-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Add a property to the QEMU MachineState to specify the default plane
to send device interrupts to.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 hw/core/machine.c        | 22 ++++++++++++++++++++++
 include/hw/core/boards.h |  3 +++
 include/hw/core/qdev.h   |  1 +
 3 files changed, 26 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0aa77a57e956..62ea86512645 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1218,6 +1218,7 @@ static void machine_initfn(Object *obj)
     ms->kernel_cmdline = g_strdup("");
     ms->ram_size = mc->default_ram_size;
     ms->maxram_size = mc->default_ram_size;
+    ms->device_plane = 0;
 
     if (mc->nvdimm_supported) {
         ms->nvdimms_state = g_new0(NVDIMMState, 1);
@@ -1253,6 +1254,12 @@ static void machine_initfn(Object *obj)
                                    "ACPI Serial Port Console Redirection "
                                    "Table (spcr)");
 
+    /* Default Device Plane */
+    object_property_add_uint8_ptr(obj, "device-plane", &ms->device_plane,
+                                  OBJ_PROP_FLAG_READWRITE);
+    object_property_set_description(obj, "device-plane",
+                                    "Default plane to receive device IRQs");
+
     /* default to mc->default_cpus */
     ms->smp.cpus = mc->default_cpus;
     ms->smp.max_cpus = mc->default_cpus;
@@ -1675,6 +1682,12 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
                                    "on", false);
     }
 
+    if (machine->device_plane >= accel_nr_planes(machine)) {
+        error_report("Invalid plane specified: %d (highest supported plane: %d)",
+                     machine->device_plane, accel_nr_planes(machine) - 1);
+        exit(EXIT_FAILURE);
+    }
+
     accel_init_interfaces(ACCEL_GET_CLASS(machine->accelerator));
     machine_class->init(machine);
     phase_advance(PHASE_MACHINE_INITIALIZED);
@@ -1761,6 +1774,15 @@ void qdev_machine_creation_done(void)
     register_global_state();
 }
 
+uint8_t qdev_default_plane(void)
+{
+    if (current_machine != NULL) {
+        return current_machine->device_plane;
+    } else {
+        return 0;
+    }
+}
+
 static const TypeInfo machine_info = {
     .name = TYPE_MACHINE,
     .parent = TYPE_OBJECT,
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index b8dad0a1074d..d2d1336939ed 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -447,6 +447,9 @@ struct MachineState {
      * Set to false by default for all regular use.
      */
     bool new_accel_vmfd_on_reset;
+
+    /* Default plane to receive device IRQs */
+    uint8_t device_plane;
 };
 
 /*
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index f99a8979ccb1..83ad1d5f1550 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -560,6 +560,7 @@ void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
                                   DeviceState *dev, Error **errp);
 void qdev_machine_creation_done(void);
 bool qdev_machine_modified(void);
+uint8_t qdev_default_plane(void);
 
 /**
  * qdev_add_unplug_blocker: Add an unplug blocker to a device
-- 
2.53.0

