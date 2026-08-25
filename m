Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E5D3CD8C9
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695274; cv=none; b=fyRCx6ik/vvZzYKyPgecsHasz+te8eX6U4iycNVfLvFk/5GUkgdHLEi5rz12aE+7ZEV8724UgmTCziozu+JGvcqTmlbPdCJKfXLu89IfW+FZ4pXh/TpB6lPxHZl2KfAnu/q7plnvNWr12///0Aw57JoSdlbkwH2XvW4V9Veqs20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695274; c=relaxed/simple;
	bh=UKP/g6cxI/U1Viyj7lei+Fu3vxBHAV54rEaaYSlc1RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCyX+MZi6TOQU0s63Kj35GcU556BlGPBu9+fwQf8y1BQ+9+vtq/WWfkRZO/VJVhnpjgKd0Hl8vnw+ck/E2D9IimbLg89/qJk73nMJpjgz6nkEiYQg4TGF+IkA16EFPZJ32GjY4zaj/By50DPuP6eLVWu9Mw8aJ3TQj1Ydi/7aHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m3TF7DFf; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3TF7DFf"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so478109a91.3
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695273; x=1788300073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zhh1+5fS76RIWmolCJw0xzFIMsNDMIy/frSA7jNg4AM=;
        b=m3TF7DFfeawcOApAnBDJm+hJAc4+z7laAIDrmL8SK2ceChHQuSHoEOnRYWMGxcZYiq
         d19FERyMxXGjGng/nkxLHjQY3aZvYQw3Av0keWQWe9K3KQab+IC2ztH+Rn4A8fmXR0h2
         Bs+tBD93hiO82+VHu7vzJKJWBsMemIomYJZ4MZmOhQkoIvUgDcKXz00v5zxBEsNiRl55
         rhrMSznqrTLtt2AZX/2Ex/GmDCT4EBNVh8iTJOnFLeCFJ/owfWyO/1evwRjNP1LfNBLM
         DlLi3phu35RXAJBI8hyX1sdPr1SnpbdNCeO/rAiBOKEmZUoWy+fY4K2XS7tbuDD0taC4
         OuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695273; x=1788300073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zhh1+5fS76RIWmolCJw0xzFIMsNDMIy/frSA7jNg4AM=;
        b=Ep+aBfrtY2cTwtBgAqwf5Xglf1xCsTBuJc2C8wuC/6UEK/X+MsgBfrpEa0kgzuMy6+
         VvVRLzEE6FC0DQIv790l1fkhxpBvT24AcuPLyGdQ52BZhk836PrwSBcGejpK7bzRs3K+
         mMSVsC6Ca8S9Nhn0JVyE5IMq3YyQ7huFE6SyxJBSety9guzFtMdkBlAkvbm5yqPRmbSN
         xxSLCt75lYacWzBGFWQmzNp0VJhZuDLxlJiWgfkdE/9jNHRSyZXh7jhQdbtK/WV0iSOs
         pmn9Oghavp7W48iSfVW7K5PcRQl6hg678YL9CQOhXnyQdMjr0OAIyo2MvkcTMD/I50F7
         X0lw==
X-Forwarded-Encrypted: i=1; AHgh+RoEkgJsMXWBU8QMEPL+xCrmhY60gcnJAIHdzCaZApO4eO/+ibOLemGZELC0AeW0cIyYJS0=@vger.kernel.org
X-Gm-Message-State: AFuF++kpLHYz/m+AKH421EaUIZCEayC4b9iQHEG0p5lizmK65q5KMhoE
	knJxAgz9Y9pzJL1zRRhFOrny+9fnW6PaCo+N25ne7hw8XCFWJPP4xntmXX3pOh0wcxc=
X-Gm-Gg: AR+sD13eFGE5xPpevyjS69G3DuPpxhI0aPSln4EmrK04r8p9OuOQzCHgNMGqcRKF0xN
	sIFT6R+6qmgxMCz58Uh+wgKrO3NCfG5m35rxg4bew/Md/9tOtPGTvTk3YVRgKBVP2aegikKGme7
	ghu88zr0QwVwxbAigxaGrUeFBcwGW8BuUJOATsekEJRw3/OJZ9fVKcU5s3JICYu8ywIVZ1spwU6
	WGveQIKn7uNugyinzLletBJPp6bruShoxpTaD4uhafwRxi8TyzVHiAB0Sbl3srY3z77A+QBfBsz
	Mb8FDm6v3SpahO6s9vbzd3YPIxYI/MDOvPbTSnZr4SH0qlF8qPHQNqtlxlZ5wGx3TuKaknRj0hm
	/kwuKsDpMh5EnTyEHIBU5wFcg6XCMckn4iAiRmI/xFtnLRPtAIqK4YjPommqqBtSBffGcVDZAZp
	c3R2WpdMcTNw7uTiM1DcDzgBzSxml8qGCtBTnmfGOvdcgKS0FFSSJ4DblmZRAjLEkDD1uKVdtSS
	zZuWy6iaYxZnUk=
X-Received: by 2002:a17:90a:e7ca:b0:38f:de97:b06 with SMTP id 98e67ed59e1d1-3966d3ba166mr4266274a91.5.1787695272551;
        Tue, 25 Aug 2026 15:01:12 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:11 -0700 (PDT)
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
Subject: [RFC v3 04/24] target/arm/kvm-rme: Add mechanic to initialize realms
Date: Tue, 25 Aug 2026 16:00:41 -0600
Message-ID: <20260825220101.3443954-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
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
index 20b39d10b766..0c853d17413e 100644
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

