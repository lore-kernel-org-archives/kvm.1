Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1223F518137
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972437; cv=none; b=iOSAxVoYnyMxuvUABsSbfdYwHjWd5Dzv83GcP7RbljNcoof1ek1Z9MsOBAdh2yOnTS0x1sT0PW9jtkZd9raa6I3j30uscwU5gAGtbqmLtP4cL3bsf+JjxiMKCrEjQq9uFXOmobuAcySauMbAaeVGaXB8fPkNlWq7xrzfZUnJYlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972437; c=relaxed/simple;
	bh=SOdAHZJhxuvGXLpg4qQn0p09+MX1/PodQr6+1OYMnwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s64yoHjc62/MEwK9ChwRm7nZW3HyfJkqI/fDKrbCb8oxdArEqKIh9ojEHtNnSn2uFXnKyAv1CstCU6KNlGSX4L3hY+Jso9hRK/hnch3ziWbTCAYkrZV1tbov0ZMa6Y4CT2QO8Y9BncWBTw2Fo7p6b2UOKTIwez8O2S5A31RLH9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KAFM/Amv; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KAFM/Amv"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2e4ba830297so4382785ad.3
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972434; x=1791577234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PrymrVjLi9fRSqjPY1QcYorJ41+LlkOVk9x92OsHKf4=;
        b=KAFM/AmvbRUJ4aqfgUg4bSA0eUp2GgGCV3KckVa0rikryjyo30D6EiAU8Tc+30HPUQ
         j5wSq+3prcbPJX6WBhRhehwIpDkI7FxGROqqJILUvokztscCESUP5Qe6L0Q2btmsGfLU
         bJpqmcmczL/Axc/HTYzSjsR8eUDfa0WnVgqGjTyGD76hPdjW6g2QaA8tF/QRQLTWHzs1
         R3ZrDuHnAqIDNg5UVMlzqDIFn4reg6WgLYBaaK9zLAa2rgiXkFeVZ0e95s4QrFENVI7V
         JMop7zsZoNhv3syZsebZ6ZNOs34hIkrdMs9mcFqynZmtmS12thMVMnNDAD1DFcALFpvb
         /vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972434; x=1791577234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PrymrVjLi9fRSqjPY1QcYorJ41+LlkOVk9x92OsHKf4=;
        b=WRcgsgUgAGxvSLJbprrTiL/MMHpDNcrGl6jVxBxDwdpxyItj2YpXUs0qzugEc9RlsL
         SR5FNmC9jXuapPtYy9L77xkBglX0JVdTTDovLFwksoXIgK3noM2DQVRsyEg0P4vqOcdz
         Kmh6l2UDRBJqvZ2gOzBbAjrxqJZx01X2PCmNyfWPRsZ07bHLam7iq4HCymGu89067lpp
         iKcvsB8kuzG02Ty/EdinJw+ijO7EvwubkyitVT92FzkN/eTtAyKwCFnfR7fwE05YXtC3
         JPOSu7ThuvS+HtOcMRYolZzTIyQctGF9YTpaR+0Sddh4Eo5Za98AybRi8ClzDwdDJYa2
         rsyA==
X-Forwarded-Encrypted: i=1; AKwUvBy5jma3vSu/UYmTlSTHoJkgvNFMzqRKity/i+dI4XIweNNcPeS2c5zGLyi/0kVJwGzmKkM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWG2KtEo2T6uuMevwo44D1kcuikQuPKKufXQsekVlfJSuhigVI
	PSZV5R0yqN3WVa+QsZn+rlMF/Zw6/3eJEY+9TfCip7hSDaX+pQCgkEiyPkLASIkDf4b1eizQPeR
	pcgPl
X-Gm-Gg: AYBFou3fkqJsmJGG+XHdKLX18LTM3TQ96eA0OI/AhlWspAHZQ0w52UwFeCkOX/MJFfj
	Xz3ULy/Hc3UlmLULCwdOlWAr3gLYUhrYk7GpxHjdfO0aXycB5jwNPkP2YMCIJMPeNZTPuRMNpik
	pf1I6ycM+wRsqHA4IahAB5RrFTrGEFuv/TECWb1dbkhSeabKoSGMUieYNe1Eot5r5h4lIo43IDI
	DKBc/UQ95X57wzd6lRX4hsYjtoBtgTXqPRlip5LrTqPP7lpqanxkQWbXGyYaUQfhNgCLSIu/HCS
	oNFWbN+MnCjHAO9yRbsGNQ49aSXdj8Yq62Vt4DvMy8T8xQPHJQ6bacoPa5K3ab5uEQuW5nQRvE3
	ekSLYsy8m19ezZghEMG40SWXXu45pJkABEjHKlsSoGrFqpao1Pqyc2bZPKkaXU2jmZR+wsoUJY2
	r8lPqZ7zM/KrejRVebhIN24xMVhUa9VaqdxAZ2aDD9p/AX8oGuNeIQxEeQ8+xHJxBtcg8PVWx7p
	tuiJLt5yfVgCYypWtDR1aq1Czfo+R9cOqVC
X-Received: by 2002:a17:902:ec8c:b0:2dd:ad74:ac7f with SMTP id d9443c01a7336-2e49b6808d3mr33171375ad.26.1790972434068;
        Fri, 02 Oct 2026 13:20:34 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:33 -0700 (PDT)
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
	enju.kohei@fujitsu.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 03/22] target/arm/kvm-rme: Add mechanic to initialize realms
Date: Fri,  2 Oct 2026 14:20:07 -0600
Message-ID: <20261002202026.1204110-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialise an @rme_guest object and install a handler to get notified
when the Realm is ready to start.  That way we can finish reading the
Realm once we know everything is in place.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c | 51 ++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c     | 15 +++++++++++--
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 42e1d1e7b859..a4a5e195c196 100644
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
@@ -29,12 +30,62 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
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
+static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
+{
+    KVMState *s = KVM_STATE(current_accel());
+    static Error *rme_mig_blocker;
+
+    if (!rme_guest) {
+        return 0;
+    }
+
+    if (!kvm_vm_check_extension(s, KVM_CAP_ARM_RMI)) {
+        error_setg(errp, "VM doesn't support Realms");
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
+
 static void rme_guest_class_init(ObjectClass *oc, const void *data)
 {
+    ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
+
+    klass->kvm_init = kvm_arm_rme_init;
 }
 
 static void rme_guest_init(Object *obj)
 {
+    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
+
+    if (rme_guest) {
+        error_report("a single instance of RmeGuest is supported");
+        exit(1);
+    }
+    rme_guest = RME_GUEST(obj);
+    cgs->allow_convert_in_place = true;
 }
 
 static void rme_guest_finalize(Object *obj)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 3d905f8565de..8b6f602ebe77 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -33,6 +33,7 @@
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
 #include "system/address-spaces.h"
+#include "system/confidential-guest-support.h"
 #include "gdbstub/enums.h"
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
@@ -639,7 +640,8 @@ int kvm_arch_get_default_type(MachineState *ms)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
-    int ret;
+    Error *local_err = NULL;
+    int ret = 0;
     /* For ARM interrupt delivery is always asynchronous,
      * whether we are using an in-kernel VGIC or not.
      */
@@ -653,6 +655,15 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
 
+    /* Initialize confidential guest (Realm) if needed */
+    if (ms->cgs) {
+        ret = confidential_guest_kvm_init(ms->cgs, &local_err);
+            if (ret < 0) {
+                error_report_err(local_err);
+                return ret;
+        }
+    }
+
     /* Check whether user space can specify guest syndrome value */
     cap_has_inject_serror_esr =
         kvm_check_extension(s, KVM_CAP_ARM_INJECT_SERROR_ESR);
@@ -703,7 +714,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
-    return 0;
+    return ret;
 }
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
-- 
2.43.0

