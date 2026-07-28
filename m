Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7187D472F8E
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266803; cv=none; b=cm61mfCeikqkS4+TDNhEQMgjtQ/v7RspsZSNHAJuT+cyH5J/rKH4FnpjRc9w99t+FubU+uw0k2yganMRSD4tNPuWerMTKWz2V/tVhwTOBa+7l4ewF0Dcon+rwmqQyfWl1Lb4rIyJyWZfsYUmkfAPTETFJgbWNfdrJR3QhirsskM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266803; c=relaxed/simple;
	bh=1V3zdYqxeMxlyDWzyaqkpMHnHFs1wLaaEZhyLKLAmTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIJs3AUou76oL68NzXxSg9vT2g99tgTaw4UqhCZJjY2pe0CkcIPQp61GGF/+Dfbtj3b+Ilw8Y/8vIV8xOff/+OiglxMrYYH7nGzhA7r8HH31tAD/EOPNtoBBx2BnMGFlIZFRp+kAsAFjzic5SlDHo5IcWeuB8NE78ueMEy4dTYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aFtwgb7q; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFtwgb7q"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38101f85591so1268674a91.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266802; x=1785871602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FPcLPI8Xklacd9X4zG4SydQQX6Mfa0kQr3DHTZ+XxOQ=;
        b=aFtwgb7qSdB0EDEzZoZxrDapmn1T9Ld7DkWScGk13xzZzzB1m9VltbiVV8q0m57m1Q
         ZHfROLQwVfBKoZn+pEx7nXn4gTMPO/jopefG84j8DZTyKSt1rnEKP//UVXGTWfbwz/Aj
         J6vtRl2Vfs4J0CMSWCEy/cq/9fdWY3tBrCvrqsr1+VzFNJ3NgE66Imon2eXHpkYGpx60
         WkzLGGAR+l+y75w9sVVu3A6gxMYUZUGBsBxsPbCQ9u98L9FKFL6eogaC1AuxaXvN4wl4
         OHEUZ1UTBnAYfHbMgSpy2E/FyKl3yQUllupFMoZOyt/wGaF3d90vH55Rmru9aMVLgWw6
         sO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266802; x=1785871602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FPcLPI8Xklacd9X4zG4SydQQX6Mfa0kQr3DHTZ+XxOQ=;
        b=tZhkSyha0lcae0tSZuDhqapOva2RNDU3YRJe/JTXuE+tYH91WVMPGd2DtoVzlIykH9
         qYL+Way1X9aowJ6QQ96SPJ9hxDp3uWMa3mBlDfQeLL+8mtJFrDRjnNu6A4T8hx9tqJ2C
         tfA44fmJUecrWhc+OCVufx8F4Ik/LtJVgSm0SF3FLmb2FtA734mMCEs3NyXkxfmLMwPU
         M4GKJRTmV53fweRdS40YfkmvBmo2dI8ayvLWAKRHidUfGDFsza+1H6Q2hDBxouDRAEZn
         cNCwfgabeSPeXi5Lmg6iXbIZ+69VQAkzoJc/TOmqgrOEw1QnMJMpNcEiYGIFVE+DtIUP
         EqBQ==
X-Forwarded-Encrypted: i=1; AHgh+RquDZY3Q9k+yFXwQiMpWBn+x8y+0HacxA/Hm15VsKYk9lRcTTjXZ1vqMSX3TEf6xKEfAuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzStyKcvgAmzSjDzzI/TSRsq01dsSdxIfu3rcjKRmtGUt98COj
	i3KwnjOZV0G7yXiM0VCw/QwjgMvqv5MFKQYfWZwa+VLYAY6cesoetBQofTkwn1GXWIA=
X-Gm-Gg: AR+sD10HH7o7a2jgIbHpM08kzmxAyVbF6sQgcnTa7UOtEau8SANKHHrVZlzsEuddLln
	/puSDaGrG/3PaYirZFY/4tqEGLeMT0jSaSaf89tDwkPeTNUjXzkpHQwAXgX7qfddrhPj8ibivCD
	suD5jXIctaqq7Nbpim9fNlZqmgttkkTU3lEiyImPYly+uRQDJss+GF0hY2bbmpt7QUiSgVAFQCQ
	lZDC3v/MF3o5bbVuAgPjDhfmISpuv0ZUfACLYBeVnRobtHLwPEGlFp1l98q31CHR8zOIeKxReDl
	DrRphAwt+KUUhqwtISFkdeI3aT7uWzunVltr5xX2ziHV44nVbDbfeWrAbPHetJhOE686yOJqVKX
	RS317rPzprd5YLJyYxiM3zkJc1hMPgZyY0WLTehSGmI6MiwL7gvIO1mqZTCJZD142CBbtGnN2iA
	qDO2tTmro9WtZhdWq+dt1fNZqKTExZzKUT9mWUmiCbEv/ugPuSFZ9bTcq6JFSv122gQOEhiGhpw
	C18FG1jJRsLOzA=
X-Received: by 2002:a17:90b:3908:b0:385:3ab:fecb with SMTP id 98e67ed59e1d1-38f6a205db2mr3283785a91.4.1785266801692;
        Tue, 28 Jul 2026 12:26:41 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:26:41 -0700 (PDT)
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
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 04/24] target/arm/kvm-rme: Add mechanic to initialize realms
Date: Tue, 28 Jul 2026 13:26:10 -0600
Message-ID: <20260728192630.240375-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
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
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c     | 15 ++++++++++++--
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 42e1d1e7b859..eb8e65ba438f 100644
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
@@ -29,12 +30,59 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
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
+    if (rme_guest) {
+        error_report("a single instance of RmeGuest is supported");
+        exit(1);
+    }
+    rme_guest = RME_GUEST(obj);
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

