Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D36445ADA
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464198; cv=none; b=AqlQUrLbzH1dZmvjG21obJB1NhLLcm8s9j/MBwSfgY5/LfkY2AVmKBxTaoDzdwU3wP0drW8BwUFSLHF8bl8Wu9/uWlDvAlzIzDINC6zKXdcPt4/+9TMgQD4qH9a3CrPjn3xa59RbdcJVM8PmO1uqgmT4KdTZ7nt5qjliV8MGABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464198; c=relaxed/simple;
	bh=+vTgaXBxd9wREuYIfIkKQhuzujqV9hZQKEbExTzrLJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXTh92L0TW4sOX1Ygr1cOaOm6FJU3mI6487fMTn49Qecq5db4obNpTOwA/e4QzkabMyJf+Dqj1sedaMW9R+Dh29/1mZE4t5cYUQOay34fXauvZoHhUYdqODlfhI+sraruOjD/eF+BHyDvYd4i9XDED9/nqoBGA301b05IGWUGC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ti9cid00; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ti9cid00"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc439bfb2d8so262333a12.2
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464180; x=1789068980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i3s4/uL2nCcl6R6HIOwHPfPYar75XVk8sVrkSd1EszE=;
        b=ti9cid00AI6EXNFRiP7pI3SMcuUJ8TYFfOnxrRlbbC/Mxyp7XoWd5/KqzxeYYBVc1y
         001M9q23f1gcFVTAVr1cALmLq3MV1LqNUo+z0Qv0so8k/UmCoq71V7wIzkMxuHIFdzQA
         FUJsit1KLlXaXImuWKLKv/DzzEVxpu7nbnzMuEkP9ffS0rDZEjLlyA1BkZL6X2DRYtjH
         vyezw2BYTmKzDHODckAShEJCjivmTvhpNZNhjsHJA/AIUzgdBuBGCUQIujgW85GC643G
         +06YT5iZnmeyiYXNAsaZ+DjNp687+R0mJSdVt/0Kw6LJ5qoakbRLDhWrmvVPhXKQAl88
         +F+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464181; x=1789068981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i3s4/uL2nCcl6R6HIOwHPfPYar75XVk8sVrkSd1EszE=;
        b=i8xb8RLs/89gbmNvCMD6aLEajNqSUwgHlp1VOwyTJPn0UbE7Ht3Vpi1QvHVIbZhTJ1
         M0AKIwL/WdsF9xv/BvHd9IjChimQhQjzWbYYkWRZkTwoz1mO7WpzEamV5cSGtX6dX4eM
         JQV5ZSxCDC1qejG8c6tfoKE1YF/o9/1nwiKq99Z3sYmfxajWTv4THTNTbZcB6CQGaFW0
         tqMezDCgPKFoBSMsLiUFOfmqZ4WTGbUrQf2Sg2dJHatwnfrVIcPYge9z0ggJZjVbE0Jc
         /C2WycxEicIIt5Z1MzFSIyLKmzkXRjNbhASvS1Pd11vn72F138Rsh8F0fAvpExZ3K2pm
         kqmw==
X-Forwarded-Encrypted: i=1; AKwUvByaXj1d3k29iZQ50TM9Ql4M2gWy5cBq3/QnIGeDgjc3ZFBzdPDVFxmV6XDHkxrksPr/JQ0=@vger.kernel.org
X-Gm-Message-State: AFuF++kUUI74XOAt6ujWxRpHdnV+im9SjZX045NZRJG4NBsY6mpt9A26
	e3NiPi8FZEun7QLOmJEUTz5QYrW/PCQsfUMa+I8uUtkeWlsc8W1u6w/2Jm4+Eeabx7M=
X-Gm-Gg: AYBFou0v6calB7O0OuTVGUYTUwoYTNzuAJWYve9zoKDrgwA85jBOfnswOenp2TCQf/a
	aVJS3BI6FiwJi90J/cmbJPoVjrf4ZuLfwZxT0eaM8j33iYtdkUcqfLm0x+ly8BQJYs9BjYqDJOU
	m7NlZv8XODA05yxWnOERzN9UrnlB+KbsSIKx6HQV9wHJ0Paw44ZEiNfIGSOSR2iyXDCMVtZZcAC
	irmrtiTig9bjX2rTePpPrVKZ9bavrdHTDPv31o+5f9lxQ9Abfuod+sz/v4/KfMw5dTel86Pk06d
	ZMQ9ZPf6bgBlh1Gd6L1O2Y8tquwSwi5+RuL1VX+OvB/fbxCuHWKLJ4O3sQ9ic8IxDD7KArbKwkO
	k8qoJ/to7XNsMyrTymFHclnT8jkN8d6TxliXDYVwD51vfAqQzivqFIOF/R/uEeS3XDMnb4mNlzO
	9mfg64Snoo6o8otT7qr4kp5FsJx88CCWztlifbEMPZ3mhFo4z2dX9cNL+yGdqkUwBHHMvdB1StU
	Mm+wyGtP7Nczf0=
X-Received: by 2002:a17:90b:264e:b0:398:9bd1:3215 with SMTP id 98e67ed59e1d1-39b262e28cdmr1126889a91.22.1788464180505;
        Thu, 03 Sep 2026 12:36:20 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:20 -0700 (PDT)
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
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	mathieu.poirier@linaro.org
Subject: [RFC v4 04/24] target/arm/kvm-rme: Add mechanic to initialize realms
Date: Thu,  3 Sep 2026 13:35:51 -0600
Message-ID: <20260903193611.1058589-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
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
index ed99be7fd80c..401a6f669cbb 100644
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
@@ -596,7 +597,8 @@ int kvm_arch_get_default_type(MachineState *ms)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
-    int ret;
+    Error *local_err = NULL;
+    int ret = 0;
     /* For ARM interrupt delivery is always asynchronous,
      * whether we are using an in-kernel VGIC or not.
      */
@@ -610,6 +612,15 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
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
@@ -660,7 +671,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
-    return 0;
+    return ret;
 }
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
-- 
2.43.0

