Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263480;
	b=hfbcc/eYGpT8HFFgqyXFyjcE4Ij9tTzug72jy9Kh2x4CZB8bfDep8f8OABNqcxS18j+q
	 alBBYuEg7cam4gGQFVI/RQGC3KhnWDK2H1nYPf5kjQ+Ve3peoX/wDT6v4OE/aZaBhs55d
	 7rT5Dsv9G4Y4AD0BTXtcNmNewMm5N7tLThBoSMOBDEiFteQFP7uRLNJtyur5Pa084ivEA
	 8y9fkzBD6xbbEslHWj2xb8oI5KHoY5KNBWLQc3rSbVmblPloSdKK3Q2vIdEPTjzLqrCwc
	 td22qBOudBu7TrKGirTap0yKAYp8VtD1J84ChZOTQO1S+cAbg/wSKutU2b2nMAosqyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=APq0rgpfgD0cfK5j1kfRyGHVlYdjJtePZaGLkcs8ieg=;
	b=XY4O4/zeX+ySNhCi/6imFC7pXvVocddgJwzoJxv3VpQFPgb9UdbF10W9i3DnsUL9fbnd
	 ATJ1IqmA8UuHPxDMOD2ra7arjMcOjMLkJYqt3Ks4xDdmzJESdMEDkdWxVmsJ91pUreEyw
	 Yo9jeYapLDSvgtPKQxZekodbptdNQ2ZvS3QEiBagvq8LwifY3Jf69pz7/ygwmXGgcOW/9
	 2lAOysaPPNS9VmiqhIS2q9QGBnb/TQRC1oexHWQXy98WBF1zFXt4UNyZhKC935dbLx+vL
	 AZ+BbJ1gxrw5NBD/fH/oQHBJ9idUUjPuNrxeKdPtRpWuW+4uT8r7OCn0MPy82+vBS2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Yo4d7+9I;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C28606A33A
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6C28606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Yo4d7+9I
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so823420b3a.2
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263479; x=1794868279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=APq0rgpfgD0cfK5j1kfRyGHVlYdjJtePZaGLkcs8ieg=;
        b=Yo4d7+9ITj9cscBJHvB2MKvsY+oK3lgFlvA9mxaR0my+B0RYBt/n6eexoGAsqHkEq4
         10C3hKHQiBL2iTMrDp8iQhdNjFbsPWjRq+AybA0Hmq9bUAB137wqQ9bFomY2gWBFihea
         max7JWpLeExARaljHJJzmB/E33SfPV4Jet3vrEydVHImunfGaJl0/pKZ+U9P3IDRUQym
         qc9n26f1Xpp6vJjfbF5c5NdClqx8U8m9xVPyvrj9MUwQ99CP95ZA2unGHedZDm+9LPSQ
         uC59WMTUiR4/3ooegXNRgErPYFUeQDcIEXx4LvcAezv384IrhF7KosWCwARSIBsqU5vO
         IieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263479; x=1794868279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=APq0rgpfgD0cfK5j1kfRyGHVlYdjJtePZaGLkcs8ieg=;
        b=mLCn8WTkw0/qqQ81w5dqolNRUSZ+Fe2QwDldH3lDL+x3SYgFuzLxyCNRhJieI98kyc
         IWk4acTzEeOT2NdMg8IMu6xL1xRUQG4j83dne/Ow8DRGJNMxNOtWwIvidUBmEpnLjclj
         1TtUPW59CHzndEK19q3GIaO67b26rrveZUPLx/zs613Epqc9ejALmDHYK4BrtKEfg81/
         KL8sqyRh6+hLro4dIRJB7WEaHi0Upv38um6oAtZMtcWuviETmle3GHx/0/Exqes33hYm
         WY2RmiDdpIvqic91OhRMScI93ulTiEj5DheTZKklq3B6Urluscfl4W6N0fci5H8CnRX5
         kUPA==
X-Forwarded-Encrypted: i=1; AL+hErH2fqu6iE3LuIOjUjwNx8+7DiT385sVfBLsnwFP8kslkdTLFkbGyALnW5IuJykr8fYlbeE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YsLiJ01RqOdXB89sXRqdzb4yEj3IexLU1vdXX2xPoaRsq0pGB
	+XICvbkbs0Fn/2IFq8KRG63ioJuzQup0bF/TK/hnY8lxtGyRK6irYyB4Cb7HLIVtBhw=
X-Gm-Gg: AYBFou04iKll0NX/QITriAsUgA8i3dV2qDI+6XdhGxgewFBanBaWqYDAHCHSM+hjYUP
	krS00gaGl5ZJSCmHG0xWd8z92GUsK7/ABx/r0Nr3u9Uxg5HeU9R9EOsy8BIeF2n4oy7rtAPyVAI
	+YYddnnz8jvvGejp8NggzW/xTT+PU2yTmbjacuCkODFxTJCVZm80IrwwUE9omBCzEgD6CvzKGY9
	dreoKbG3+BnnsWDiZjQgcR9qcI9uLT3iULk5y1ZH2Es7ZrUc7XuALPLzgrQds6KJImCsxJMpIWt
	0KMAhqgnSoBug4Z38DuGrZn6Dftp4pvUN3+noblkOq/S5nQNLaPXLB6jtTgTxgSwxO94fjhUDpv
	LTSOqsx00CvCHmhc2NPh88KqmErQxRZbR5K7U+hE2XNoQfWXwSiazbsTHkde8suCILNkKFq/SZY
	HkdNu7gx+lfDITt/pUxE70jAkmG1Eu2bSxfk6+CQD9dbm4n/Ci9EdMzihad4LfEPuKJIFBD/YPH
	dqfqH5psz6PXxdZn8io5q0ou7QJQX+NBhndXmnCkzJL8ljrcEuSuEjjNhIAJA8nZ4/XQl8khuzx
	P9Ej6RsTsp9hbcc5L9bMS9pwJN2Gt4s+GbbO09zUjoYLwWG/TTg7NUPOACznuX5mOem+KMtekzw
	=
X-Received: by 2002:a05:6a00:4b56:b0:89d:29fb:b5e7 with SMTP id d2e1a72fcca58-8ba868a4e97mr1029357b3a.24.1794263479183;
        Mon, 09 Nov 2026 14:31:19 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:17 -0800 (PST)
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
	gshan@redhat.com,
	michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 03/23] target/arm/kvm-rme: Add mechanic to initialize realms
Date: Mon,  9 Nov 2026 16:30:50 -0600
Message-ID: <20261109223110.1619504-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialise an @rme_guest object and install a handler to get notified
when the Realm is ready to start.  That way we can finish readying the
Realm once we know everything is in place.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c | 51 ++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c     | 15 +++++++++++--
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 42e1d1e7b859..b3edfa8e0a95 100644
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
+    cgs->convert_in_place = true;
 }
 
 static void rme_guest_finalize(Object *obj)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index df86ad387c56..04dd85ee2776 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -34,6 +34,7 @@
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
 #include "system/address-spaces.h"
+#include "system/confidential-guest-support.h"
 #include "gdbstub/enums.h"
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
@@ -657,7 +658,8 @@ int kvm_arch_get_default_type(MachineState *ms)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
-    int ret;
+    Error *local_err = NULL;
+    int ret = 0;
     /* For ARM interrupt delivery is always asynchronous,
      * whether we are using an in-kernel VGIC or not.
      */
@@ -671,6 +673,15 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
 
+    /* Initialize confidential guest (Realm) if needed */
+    if (ms->cgs) {
+        ret = confidential_guest_kvm_init(ms->cgs, &local_err);
+        if (ret < 0) {
+            error_report_err(local_err);
+            return ret;
+        }
+    }
+
     /* Check whether user space can specify guest syndrome value */
     cap_has_inject_serror_esr =
         kvm_check_extension(s, KVM_CAP_ARM_INJECT_SERROR_ESR);
@@ -721,7 +732,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
-    return 0;
+    return ret;
 }
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
-- 
2.53.0

