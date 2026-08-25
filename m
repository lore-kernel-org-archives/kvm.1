Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0206237F33F
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695279; cv=none; b=f4n5Tmt3SIR1JH4G5pD5G1kWmUVdcjo8+dxi/OWFDdcpT9whm3JKVIZaSiYk5U3cCLky6OVWHKEZUT4/qu2V3oVLPkUiSPS0zCdLDS6T1rrZ+CmaaE97NDJvlABZxwj495N97qFur+ZMYSuxEAuU2Y4IwJi8Jjt9h/PE8LYG2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695279; c=relaxed/simple;
	bh=QWH2HCVd8ozLjQ7WDk1XlYPN0KrOFPDGtrgfct7Kw6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lirZog0/zy1v+2IbFBMP+43DGw9jZhxfm7bJuM/ihVtvSHd1V1u2n5ACbQukn6eBs0wynKNnlSB1K7HP7akcwDiGyl4/+I37dvftSskIogVeEtNFaKUh4SlXKCG/TmA33cygzCaDS6u2eXDPZOGY9gdn2vl7wvMoqxmHbH2Cg1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sjodzitv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sjodzitv"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d01663d816so3278005ad.1
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695277; x=1788300077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dUaq16H7ZXtgfYq4uM1fj/RNffDp9uuh97XM96tiJL0=;
        b=sjodzitv8n5/paeZCBYuoerwAAAiNKw63d/zccnEuARnSVTNSc4vaM4IV34X6PlLIP
         azNQuFCvAbLwXLERP7vZxPJyCmK81yOPdmIZTfqocESVljOf1iYIsGlYaf6NjRyC629h
         iVvpeIdi9jDJXCYgSdG2iqhKRtR9bd/AsZJx1IP/P5W2uR9IAawK91Xg7lP2CsHUEwyt
         Yo7EgOu7n/Z8Uzxf60UvW3lq3aoWQZTs5O1IkFYVMmBXSxExKvv9edBE4n5GlEMJDvBK
         uROLO/Aa4bfonhXFLqF7LayREhD7CaW93nLs12bmNT3ZsBKT4defRkpiOYaGP0xK9nkb
         s2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695277; x=1788300077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dUaq16H7ZXtgfYq4uM1fj/RNffDp9uuh97XM96tiJL0=;
        b=jWwUHxtfh8cjV7MrU7uICHbGC91aqLc22G2w0EoPEprriPICL/W12kDjFcgWAmNcEd
         CUQ/aHvKoSiCuH/a9Syd+1gg61ooI05kHFCCzPR79HYmBp2rK8q398R1Iq6mJVYLmiiO
         q9m4FSZPWm2E4mksbBXY56wQY8NrU8lpd1Q6uhku4J3jYA/2hEuzH3qBhMp6lFcFwUiv
         Cl9SBNKiLGb+xbHimSu27ygdidsDyzIXuAWJ+NC08fIv+Im6SpC3PWBoFJfIuxkVFJP/
         1OniAPXdmDRFqhkZwh8o+/RKBsMI+wSPqUHBPeu/PhMcdOFNZmpzcAoLKibsB+uV/blv
         Yz0w==
X-Forwarded-Encrypted: i=1; AHgh+RrqIPu996yXznuxFFUgmSKiX7MxM7XWlpXGlPnqHyVY7gU0O+je2fWNSEXcmajTWOzyApc=@vger.kernel.org
X-Gm-Message-State: AFuF++nmAeO3WMVTQIYc47K3HKDjYdKs/TN4nldDph/iOR67HDde73Ka
	pOb4ajpJxQQDKqERx7o8Xm18JwhYm84Yuk4ZQEAOcqThh7tvhENd6c5KgzPk6VM/eQQ=
X-Gm-Gg: AR+sD11bDNHqWb8lKhefFXrbyk3Gn2t9jawwhgrOImC1jFf1saZ+pBoIdSRUpjZP6iH
	hJP3jZYU3trjAyCTFvyJ7V7zmnKdBWD9FSyh/1/uWdRbeTaLoXMi3qsuWoYU2KZx2LbfztZZvMb
	s7gnlhIuwXCw7W+xXsQ28mi9ycC/EyX2EOpdW2P+iY8X5sc9fXmwy0JyxNE/dorgmKowo2A0SDK
	BFwtfdQZvxJQHZIVIvGYJoztl3sB4fI02QVHUa9Nta4Gjd5K2I6/Swea/9Vwtup/L4g2kYipCyx
	ohL3NI5RyWn31jVgEzT3hfUTPtzT3adD26Jz3Q4Pw65h6tHOHXb3eJ/7VeTmv4k4P/YS3jKVSze
	RpI6RrdoBLjETRoagwPLD0grsJdn2XgHPVGwRO6Z7dLvDQbeYaTH/IujzAGZT+wI/IEsO4p9NbZ
	icbH4ZcDyhiHjxXSrjsOar+qkr5EmSItHtpcr1f6KL0iDDijeNJo08F4tqnUGPHz54q76pUAYgn
	BKWd3OEv1YroUk=
X-Received: by 2002:a17:90b:4a8d:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-3966d412ab2mr4040417a91.9.1787695277070;
        Tue, 25 Aug 2026 15:01:17 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:15 -0700 (PDT)
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
Subject: [RFC v3 06/24] target/arm/kvm-rme: Initialize vCPU
Date: Tue, 25 Aug 2026 16:00:43 -0600
Message-ID: <20260825220101.3443954-7-mathieu.poirier@linaro.org>
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The target code calls kvm_arm_vcpu_init() to mark the vCPU as part of a
Realm. For a Realm vCPU, only x0-x7 can be set at runtime. Before boot,
the PC can also be set, and is ignored at runtime. KVM also accepts a
few system register changes during initial configuration, as returned by
KVM_GET_REG_LIST.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/cpu.h      |  3 +++
 target/arm/kvm-rme.c  |  9 ++++++++
 target/arm/kvm-stub.c |  5 ++++
 target/arm/kvm.c      | 54 +++++++++++++++++++++++++++++++++++++++++--
 target/arm/kvm_arm.h  | 10 ++++++++
 5 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 85552b573c47..ee26a74c8e80 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1038,6 +1038,9 @@ struct ArchCPU {
     /* KVM steal time */
     OnOffAuto kvm_steal_time;
 
+    /* Realm Management Extension */
+    bool kvm_rme;
+
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index a4a5e195c196..f7c2cc786e2c 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -69,6 +69,15 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
     return 0;
 }
 
+void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
+{
+    if (!rme_guest) {
+        return;
+    }
+
+    cpu->kvm_rme = true;
+}
+
 static void rme_guest_class_init(ObjectClass *oc, const void *data)
 {
     ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 88cbe8d85c41..5fde96f9b281 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -119,3 +119,8 @@ char *kvm_print_register_name(uint64_t regidx)
 {
     g_assert_not_reached();
 }
+
+void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 33ac9528c45f..ff179a66b821 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2012,6 +2012,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
     }
 
+    kvm_arm_rme_vcpu_init(cpu);
+
     /* Do KVM_ARM_VCPU_INIT ioctl */
     ret = kvm_arm_vcpu_init(cpu);
     if (ret) {
@@ -2166,6 +2168,29 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
+static int kvm_arm_rme_put_core_regs(CPUState *cs, Error **errp)
+{
+    int i, ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    /* The RME ABI only allows us to set 8 GPRs and the PC */
+    for (i = 0; i < 8; i++) {
+        ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
+                              &env->xregs[i]);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.pc), &env->pc);
+    if (ret) {
+        return ret;
+    }
+
+    return 0;
+}
+
 static int kvm_arm_put_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
@@ -2277,7 +2302,11 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
     int ret;
     ARMCPU *cpu = ARM_CPU(cs);
 
-    ret = kvm_arm_put_core_regs(cs, errp);
+    if (cpu->kvm_rme) {
+        ret = kvm_arm_rme_put_core_regs(cs, errp);
+    } else {
+        ret = kvm_arm_put_core_regs(cs, errp);
+    }
     if (ret) {
         return ret;
     }
@@ -2364,6 +2393,23 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
+static int kvm_arm_rme_get_core_regs(CPUState *cs, Error **errp)
+{
+    int i, ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    for (i = 0; i < 8; i++) {
+        ret = kvm_get_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
+                              &env->xregs[i]);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
@@ -2475,7 +2521,11 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     int ret;
     ARMCPU *cpu = ARM_CPU(cs);
 
-    ret = kvm_arm_get_core_regs(cs, errp);
+    if (cpu->kvm_rme) {
+        ret = kvm_arm_rme_get_core_regs(cs, errp);
+    } else {
+        ret = kvm_arm_get_core_regs(cs, errp);
+    }
     if (ret) {
         return ret;
     }
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index e7c40fb003e4..d95381c13afa 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -240,4 +240,14 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
  */
 char *kvm_print_register_name(uint64_t regidx);
 
+/**
+ * kvm_arm_rme_vcpu_init
+ * @cs: the CPU
+ *
+ * If the user requested a Realm, setup the given vCPU accordingly. Realm vCPUs
+ * behave a little differently, for example most of their register state is
+ * hidden from the host.
+ */
+void kvm_arm_rme_vcpu_init(ARMCPU *cpu);
+
 #endif
-- 
2.43.0

