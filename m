Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DFF3F6C41
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932082; cv=none; b=H/Qbrgot1y4LEzIi3TR1gbxI59eOqVJ59mnm7F3axHqZhPb8ou8gHkwWIGJgxu/KgAThz+FgypyHA3neqXLFosekehDu5c2k6rfFRK2dD/nbqtoCSrvIGGtxVnsG85lqtneJgl3shcXPilYCsQ1Ww8qim+u1BlJkrkaCPCcfAgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932082; c=relaxed/simple;
	bh=e9fICXGN84LJYErZLVGBHNG9b/a/u1rg6MgcDyBcNuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaJfOz+fZbKs9ZRtdYMXNLVwwJPeRcNrT9dj22a1kypH4vJHuyvNKD0yQzAQ7hiTYLkXCzCUG0w1A5ua/vk43w+BCqJhddNhVrqJ5KBjUCqi3y30DyKgL+SETaGnI53Mflwgl4RdYqt7HnDd6RprGB6ZECIIJDA5zQdnmnxkkyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id EFB49202949;
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
	joerg.roedel@amd.com,
	Luigi Leonardi <leonardi@redhat.com>
Subject: [RFC PATCH 08/10] qdev: Add plane property
Date: Mon,  8 Jun 2026 17:21:07 +0200
Message-ID: <20260608152109.356783-9-joro@8bytes.org>
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

Add a property to track the plane into which the qdev needs to inject
IRQs.

Co-developed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 hw/core/qdev.c                      | 26 ++++++++++++++++++++++++++
 include/hw/core/qdev.h              |  4 ++++
 tests/unit/test-qdev-global-props.c |  5 +++++
 tests/unit/test-qdev.c              |  5 +++++
 4 files changed, 40 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index e48616b2c6f2..73d18fc0d639 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -662,6 +662,28 @@ static bool device_get_hotplugged(Object *obj, Error **errp)
     return dev->hotplugged;
 }
 
+static void device_get_plane(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    uint8_t value = dev->plane;
+
+    visit_type_uint8(v, name, &value, errp);
+}
+
+static void device_set_plane(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    uint8_t value;
+
+    if (!visit_type_uint8(v, name, &value, errp)) {
+        return;
+    }
+
+    dev->plane = value;
+}
+
 static void device_initfn(Object *obj)
 {
     DeviceState *dev = DEVICE(obj);
@@ -674,6 +696,7 @@ static void device_initfn(Object *obj)
     dev->instance_id_alias = -1;
     dev->realized = false;
     dev->allow_unplug_during_migration = false;
+    dev->plane = qdev_default_plane();
 
     QLIST_INIT(&dev->gpios);
     QLIST_INIT(&dev->clocks);
@@ -796,6 +819,9 @@ static void device_class_init(ObjectClass *class, const void *data)
                                    device_get_hotplugged, NULL);
     object_class_property_add_link(class, "parent_bus", TYPE_BUS,
                                    offsetof(DeviceState, parent_bus), NULL, 0);
+    object_class_property_add(class, "plane", "uint8",
+                              device_get_plane, device_set_plane,
+                              NULL, NULL);
 }
 
 static void do_legacy_reset(Object *obj, ResetType type)
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 83ad1d5f1550..28d2efcbe455 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -295,6 +295,10 @@ struct DeviceState {
      * Used to prevent re-entrancy confusing things.
      */
     MemReentrancyGuard mem_reentrancy_guard;
+    /**
+     * @plane: Plane the device is assigned to.
+     */
+    uint8_t plane;
 };
 
 typedef struct DeviceListener DeviceListener;
diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
index 8ea362cbb902..2aca5bda22b9 100644
--- a/tests/unit/test-qdev-global-props.c
+++ b/tests/unit/test-qdev-global-props.c
@@ -71,6 +71,11 @@ static const TypeInfo subclass_type = {
     .parent = TYPE_STATIC_PROPS,
 };
 
+uint8_t qdev_default_plane(void)
+{
+    return 0;
+}
+
 /*
  * Initialize a fake machine, being prepared for future tests.
  *
diff --git a/tests/unit/test-qdev.c b/tests/unit/test-qdev.c
index 20eae38e03f4..6e3127b41afd 100644
--- a/tests/unit/test-qdev.c
+++ b/tests/unit/test-qdev.c
@@ -26,6 +26,11 @@ static const Property my_dev_props[] = {
                      qdev_prop_uint32, uint32_t),
 };
 
+uint8_t qdev_default_plane(void)
+{
+    return 0;
+}
+
 static void my_dev_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-- 
2.53.0

