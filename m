Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685E73DB325
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464200; cv=none; b=PznGTELJL6yWjlpTsI6ebd6XyPAf8hwrl1xNzdhPOi5rzR3BDeyaF5adtECYtS5efc/8KRtdndGp8EdQHm2jZfydsYXnXYBi65YHnT7flO8H1GQK/QrOGNA203Tn+xA+YGV1eoEZg3Isk+haCZCJrFWY4Anvdp0FofKuFRlAoXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464200; c=relaxed/simple;
	bh=Wc5jdbTWuxQuVEVRZzyTFqI4oxWlC+yDHl27+OIqKRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+40z9x6CwdwV30UB6jq1Lbw5ue0NE6BUZ59XZ7IWybtm6sg40eWmfwpcEp4jAXuGTdY6eryExf7VoZWTbg9jB1aAf5Lwz5TLP0VV0orDedqeSisXYefiDsT+bYsmH6d7OI9Fdw1Pbtc+yWP4CGujNpID0F9kzw9KJxojui/aA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tZ1c2N0l; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tZ1c2N0l"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cab973140bso1141095ad.3
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464199; x=1784068999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dR3NfNdVtBBic7lSVzoRn85byyneAw/58XsEkxNw3ag=;
        b=tZ1c2N0lDtCtX+c7nawDhgNokcNtW9ZPGzeNIOJGorRStVxvMhwTdDbWDFkhJKegbY
         WgQtKf1wMa2IkWMj1clu52aczwIIIkRhRtYJ45Qx7ADs4pVToodHJgvPbZQjYHSIfkdA
         QYm8QFmqy+G6oKSPTbq8bk6WtpIHwDT1lN4hJv/D5s5x7QXkrtzpd6Gi8kniAmNSYaXp
         z1+ltExVTydaVJu9bkOx4NjdpY+d1Rdb4JKhI5bS+Tqfh7uFVdLA56ByHLAN5oqam9Ij
         dHFyZ/VsMlFjvPtWD2okG2hqSpayVolKM3TqvoiyJYE950GVA4wFNRVbE0dcSXj1P42/
         cXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464199; x=1784068999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dR3NfNdVtBBic7lSVzoRn85byyneAw/58XsEkxNw3ag=;
        b=p4GBdg+LOWHoYP/sNfZiyodrdJz0rE6KZhfvK3sMkAfGpIRbFEgTqbZNwsd0u8TfiZ
         n5ThsCFRGJkrixxPwuvQEwW9NUO5wk3qRe/yQYzccqqvYiMKOfK+j8Q56JfQ6Q1X/RHv
         vp/SQVmIqTdvhMYDqc/hH44XqdUWQCvFFnnbu3eOxZxKHAn33rFP0YdrfHX6asUNadtj
         sTQnAeutTwqVaIj54x+N1/vrHRA/uOa4AQi2RiDZ4z1Q3QVpPSsMWmAY6tTV/yS9JqOA
         r4eXjHeAQnqUSsab9jkYtnjSfDGs9BHPXpNimUnwCYvm6dN9PXxga5QmJGvbiQFBdmiT
         7lOA==
X-Forwarded-Encrypted: i=1; AHgh+RrYx62yIE8a6VeQbIPfv5XL2UDNc+dYT4ktQ4zKLntJPKeBDGIDBcOJpWl/2VNorVwqP8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztnw+piVJqD3vYyrNgpIQO193o1xDSKPS5KiafFPM9ZKkvocU9
	msekpGHNdCpx05HyVYXq8Xyk+upI3Es+2DUsFR7yp2/prsSwRy4sHpzNUYrUnxbK3kw=
X-Gm-Gg: AfdE7ckzNKssmWgNxxFyG7qtTzjb1z3D89PHCgmetdDxftDALtRH1YH3iHkf3NVUPmt
	HOZ50v/Z7y6xKYPi6a2ROD18jSub+s1/vJ1QrApw+1y7uF2a33wjybUfNbTKm3Z1hL+pH4QpnCy
	cuKIks5+7OBjTaziMYX3MKKkni7qBZhPNB0bbFN3odVn1mszydu6CsLwzwTcvTROyvZgLCcQUEm
	8UwGplhylcsWa291IA6zflk0KGhL5gFbMFddQ8lopZcc2m1I5tIQWNUqkfm3jJDg6JJWwfzW95k
	Zo3HJo2AjiR7xpxiX+7c5BXbZt9y1BQyuJchkBSwxLqdbbfZNsL6KnwvS6l7VZdGScoPpvuiGD/
	GHtL3VPLAmSXhHvhTgvlAh6LGh5CnO54ombmG8nSDHK2E9JXpPUzzr7Svtdo9sax8Z2kt0vgHAY
	kKHwltXnpRwKG6XCNmutXY9SP5jEWaAP9NutEeAD4=
X-Received: by 2002:a17:902:daca:b0:2ca:e565:7b15 with SMTP id d9443c01a7336-2ccbe50aa04mr67799045ad.10.1783464198645;
        Tue, 07 Jul 2026 15:43:18 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:18 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	jpb@kernel.org,
	lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 04/25] target/arm/kvm-rme: Add mechanic to initialize realms
Date: Tue,  7 Jul 2026 16:42:45 -0600
Message-ID: <20260707224306.1202330-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Initialise an @rme_guest object and install a handler to get notified
when the Realm is ready to start.  That way we can finish reading the
Realm once we know everything is in place.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c  | 50 +++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm-stub.c |  5 +++++
 target/arm/kvm.c      |  7 +++++-
 target/arm/kvm_arm.h  |  9 ++++++++
 4 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 42e1d1e7b859..b86b9d6a25cb 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -13,6 +13,7 @@
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qom/object_interfaces.h"
 #include "system/confidential-guest-support.h"
 #include "system/kvm.h"
@@ -29,14 +30,63 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
                                           CONFIDENTIAL_GUEST_SUPPORT,
                                           { TYPE_USER_CREATABLE }, { })
 
+static RmeGuest *rme_guest;
+
+static void rme_vm_state_change(void *opaque, bool running, RunState state)
+{
+    if (!running) {
+        return;
+    }
+
+    kvm_mark_guest_state_protected();
+}
+
 static void rme_guest_class_init(ObjectClass *oc, const void *data)
 {
 }
 
 static void rme_guest_init(Object *obj)
 {
+    if (rme_guest) {
+        error_report("a single instance of RmeGuest is supported");
+        exit(1);
+    }
+    rme_guest = RME_GUEST(obj);
 }
 
 static void rme_guest_finalize(Object *obj)
 {
 }
+
+int kvm_arm_rme_init(MachineState *ms, KVMState *s)
+{
+    static Error *rme_mig_blocker;
+    ConfidentialGuestSupport *cgs = ms->cgs;
+
+    if (!rme_guest) {
+        return 0;
+    }
+
+    if (!cgs) {
+        error_report("missing -machine confidential-guest-support parameter");
+        return -EINVAL;
+    }
+
+    if (!kvm_vm_check_extension(s, KVM_CAP_ARM_RMI)) {
+        error_report("KVM doesn't support Realms");
+        return -ENODEV;
+    }
+
+    error_setg(&rme_mig_blocker, "RME: migration is not implemented");
+    migrate_add_blocker(&rme_mig_blocker, &error_fatal);
+
+    /*
+     * The realm activation is done last, when the VM starts, after all images
+     * have been loaded and all vcpus finalized.
+     */
+    qemu_add_vm_change_state_handler(rme_vm_state_change, NULL);
+
+    cgs->require_guest_memfd = true;
+    cgs->ready = true;
+    return 0;
+}
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 88cbe8d85c41..eec1ca3dd2e5 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -119,3 +119,8 @@ char *kvm_print_register_name(uint64_t regidx)
 {
     g_assert_not_reached();
 }
+
+int kvm_arm_rme_init(MachineState *ms, KVMState *s)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ed99be7fd80c..28d5643d6779 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -660,7 +660,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
-    return 0;
+    ret = kvm_arm_rme_init(ms, s);
+    if (ret) {
+        error_report("Failed to enable RME: %s", strerror(-ret));
+    }
+
+    return ret;
 }
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index e7c40fb003e4..6d058b0e08a2 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -240,4 +240,13 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
  */
 char *kvm_print_register_name(uint64_t regidx);
 
+/**
+ * kvm_arm_rme_init
+ * @ms: the machine state
+ * @s: State of KVM
+ *
+ * Prepare the machine to be a Realm, if the user enabled it.
+ */
+int kvm_arm_rme_init(MachineState *ms, KVMState *s);
+
 #endif
-- 
2.43.0

