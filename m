Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578174FB9DF
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464200; cv=none; b=JhKwH5QHphc+PYKTX9FF6qJ6XpgcTE16+K7ebWXK8w4FUiLfT7Pu3d5gWv4/oN7n9bHRZftUyzMuBAuPBOzOQhbYM550j07GDo9Swd5fYDCJd8CAC3zX+gCvb2IbdakgBvLPajqbSEpW+/lCwLK053xi94YnBg7OcyRacn07gJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464200; c=relaxed/simple;
	bh=IJtZq9Rp09yHeBnVeOCVKIcmdBeD8QGpBc9DZxk0jI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQ73rraXxqvOnIIQkH5iwjxr9NPkhe7XGZimNQrelb/OuqtFbQxC9mcfCOlkgSgErdFcGkpczAhQj7HcW2ujGnRwg4ogojzXo+HwDhdUpNwarMVvGX0MXbPoEItva3D2wvWY1Zr/sRUYnMLfta7Ll8gnA9aVgvygMOw3tHjL6QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fpRcbXyA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpRcbXyA"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d9201076b3so2862085ad.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464184; x=1789068984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pjEnAWjV/7L51IbxCkjqlwouDh6XAo827NCEZ3RXico=;
        b=fpRcbXyAKCs9uDWI9dtjSxU0f/va18HbHUwrc2PKT0RR+bh1xwfOhk8/DadSo3W14N
         dWajURL0KuvqJ4OHaN60AmWvTOklNgji7RHn0AHbRM+/OytFloMyR/j/DQTD+466qaf7
         oOpmL59qJQlZcQPxz2uW7vQ0MSDgJUaU5zkXrkMEJvVlN8fS/DtdcpbCftSU1KpGGEbp
         7q6xqraFveGpyb7gmKTKPQGODoTTf9z6lY30M8b/KAThOrI04K+aRYIiWIHT2ez+Ni1K
         s7yM/oWTSNAfyrb4YyrdNqPhwIDB8pM0CyPpY8aXJ4IAbSCOTo4PxRxNOTKm6hDPO+NO
         8YtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464184; x=1789068984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pjEnAWjV/7L51IbxCkjqlwouDh6XAo827NCEZ3RXico=;
        b=XZ5TDgO6Phg2kHNHQmP4nvutgmEh15869x0mYzxFB9GdAicEoO5Xlv5lIE/8TU9fnp
         l/oWDh8SX8C7K6n2PhzLakvjAZgS1H965deTxALZU7g2KKswKb+5JvZpPU/Yn+lpRxPB
         AtDYhmurRZ5NYgmOqa1PypIn58WEFAz3Yry1m5uLiGCn1w7YuULZZ0taf6QMOx8+0Eh3
         c9JGD++qKIbCAsERBTAtYJmbBONIP3Q0iNx1V6t7/FBuh+EAXiisqlUkxSF9URia17wh
         mUmIdQD2CrLsM2IiaoKyTB/H4hLwQeqS+BwnLIBcnYG4nIfw5agGjFzD8XO+Vi+89ZKU
         f9dg==
X-Forwarded-Encrypted: i=1; AKwUvBzJP3UV7RylC5h9c5uiOkqDaL6M3NtlwABlp2gXsmW0P278omPtbkH1ml8DuZekmazYWjc=@vger.kernel.org
X-Gm-Message-State: AFuF++mupRSsVIs78/debBk2WU9LUFCthMu2Ey1GbhN5D3WgTkz0uN7h
	UDKA1GsGB/rhXG7ZOQFv11HF6owmp1dbWpvt/GGmFUILNTiNA/cRnwvnKsS7Tk8SYUg=
X-Gm-Gg: AYBFou2fbZYGP1PfPTzrL/LBbSJPnq/8wF0xr435Mm8goiYBAZtSgxmXToIpr/2gzk2
	gzFgPMwykkdpVWqg5ZpWxRSACPwzx1XLFRy1VzSe116YDRR32rxhWQr8Y+ZFYIwxF6ijf38E2eF
	BI3z/iYJ2sp34w08rfdwooUz2kQg/1faH8ze+ZYDcEoaKfVZdaw0lxX+I1B4pMTCgvNUcKdI9DL
	cosJlXsyYSQrnihdAF7K6mr/cG5VqiTDA0RRbh3WwWDdz0y5hnUx0979Wsb5mFrtAMXACW/rATy
	g18MItYwwYdATotiALrlPKh5uvHqxmDQjcXCXUSrGwmF0HKdNcz4ovWoLcIOtfsBLEACCd3X+vg
	SPLRlQ01VQXOK+Ug5shT0hQRQzuyV249W0yJBw7LcdfgNEyDKW9e1jOkr6LZydr8k+iYdl3vbIl
	/wb3BssiEKNa2A2GepcWfZ/13+pFWumZZtMORoPLDMfiqGwfhX9H7unoY6VEEsou68YYRjeqc0I
	a8Sd+5ZznOWBNY=
X-Received: by 2002:a17:90b:4c4a:b0:398:bc52:825b with SMTP id 98e67ed59e1d1-39b2624c32amr1003136a91.21.1788464184154;
        Thu, 03 Sep 2026 12:36:24 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:23 -0700 (PDT)
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
Subject: [RFC v4 06/24] target/arm/kvm-rme: Initialize vCPU
Date: Thu,  3 Sep 2026 13:35:53 -0600
Message-ID: <20260903193611.1058589-7-mathieu.poirier@linaro.org>
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
index e3f931dba26b..6bbc942f9a59 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1054,6 +1054,9 @@ struct ArchCPU {
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
index 33c3763aebfa..b4c6da1fb9f3 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2015,6 +2015,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
     }
 
+    kvm_arm_rme_vcpu_init(cpu);
+
     /* Do KVM_ARM_VCPU_INIT ioctl */
     ret = kvm_arm_vcpu_init(cpu);
     if (ret) {
@@ -2169,6 +2171,29 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
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
@@ -2280,7 +2305,11 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
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
@@ -2367,6 +2396,23 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
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
@@ -2478,7 +2524,11 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
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

