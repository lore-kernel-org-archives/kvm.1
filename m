Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CBC472F72
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266808; cv=none; b=uS1SGjl+w2jMFzju/9WxCAUKUwWvD1lcSV20mRKrSUZ10Mjpo+owWy8bFkkdgwdUw2FehUN93mrN0s/B2YA9bFOLzMwhiMZYNKY+W4//k+skO1gnQJhwOah07D6j0SDJWj6xuHWpcmyjGpNBU53QDW3uF2y3Asr/s2/k35/9YgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266808; c=relaxed/simple;
	bh=9oNZYUkgnWPa8+1fFBiTRsY0iL73hBjwx/0YwM9GSy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1Ax98LLF9f1WRNryXpoPZKV0mi/azCzhalpCWSBNTWDgb725yFSpTNh95uPsBCxdmiaU1C+PGsE1MM7YwXvS9w7bW2n8SnH8XSD1KXLVwoOLG3BDdT7J7r77FuH9JQY2og294S5dPHrkF9IQ5ycvvXihFSG6J3FldVrKP0BJfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k5+Q339V; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k5+Q339V"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38f620399a0so146414a91.2
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266806; x=1785871606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P0YSgKbTi94FPXUFvygJmUQ5Zpn1OBxkC+C5ko65QCo=;
        b=k5+Q339VvKJ+9WzFMQO0nME5p2k7N7fOMsZjSlyJHDvn9Gst5HS0vgUMbkulPSAWHI
         PsW3K2/mYhFh0nczCb/UCDTRFD+QJ27Z2QPQ8OgPxwOGV1H5G+6g6FM983jROiAys+Ai
         h6o4HtXNteYmZP6qj9bw9PplCUJSbaipzkJkh7h6k+AhZPTDtx4qjqo9ZCURj5jLioPZ
         /zDjkAARPAMue5rPpp7YQXZ482RaavPfFmBNQZcBm8FDwaGCJ6SsEnx80Yve4HZ/KlBH
         SsuDnqvvfwLqPvAEWxVA3SclA514wntmF7XlyfeP+kIBixZ2ZsH9ZkDyErQ2cmQ76rJ/
         PooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266806; x=1785871606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P0YSgKbTi94FPXUFvygJmUQ5Zpn1OBxkC+C5ko65QCo=;
        b=UbbJYpAagjfmrWrWPycMjf6HN6+AsKb+w0nbAF0Dl9Sl8I3+uVKdwCpsIoyVXMPBoV
         wZHnxCmsUGIKAzBEUMHjDTyk5hdzdW3BimMZuSysOwTVfsiKaGQNLdulszdqZmbnPpSA
         Q3kdtELlZZC/b7oAkq7GLfUdD6JOKtrHG0ILrJfHrfEslmlSDRax41dwKA7pxg896TAn
         5LzPUZDuw1MmIy06ReZ00Oq5EQWO5Rva1/dfFWyxr2NWJfaJFq37BEybEIOiFaoe/Omg
         /OVlbkA1Fonu+076hSSGJn/FXpZd/FskSkil781Z6aNsHwtLUqU1y7LoeGeGhjlKdAGG
         5/Vw==
X-Forwarded-Encrypted: i=1; AHgh+Ro6yF+3V/i4XHWdFLrMdiMSY/+1PetGJ+SCx1T3eUuYkRTUuzo7krnr4YHMgd5FZXtP4YY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvf1XDysh8uH/J7aAtfeNnry0NK24gqW+JGVRZnsj9iNhH0Mk7
	ldt7imihHOOMdDXAWGP4vJtq94l8uxnrnVuuxCHVwAm5C47/dshkBVZ01n25pTwvVfA=
X-Gm-Gg: AR+sD11SGZ9FUC6zqjau5tb99mMjj9lw5aehbcPK3b2PYod5/WW9Gc09x8B3YVknCJb
	myjnglUYIjnmJXccK70N851CT0pkkRc0mnL4Ipns9AmIHrxon5kH+9CTAE0gboQUeNbIxIPkkkm
	9lAbLQeWxkRFabDBAYMliv7DR6yrGBrP+JUiblTTC95VVi9wisTmNLI/fRHRAh02FEazA/e4Rw3
	C1B5zU3XXsWQrO9hcsBzN9+wDyxR8l3HY6pltuv5+OHrU2xgSV8alP0fgQEUKx2UrbTa0+tyBhf
	Pw9akaCeqOoZkGP0+/ZlBDXKqCqhVG+GfRIvVcNy59FYk+Hli1DDQqKI8MBFSl1j/AN3TcvRo7T
	tXi7Vio2FVQc5+9KG6nKp3Fjhw/SHOQx0RckTCfhpnm7s5dw8+fyHtwguByFy+vZWElU53AF+bH
	qtJAoI+5v0sJ3yKKdXZZ6NKebopVui
X-Received: by 2002:a17:90b:50c3:b0:37d:ee77:78ac with SMTP id 98e67ed59e1d1-38f6a3aba5emr4059612a91.19.1785266805956;
        Tue, 28 Jul 2026 12:26:45 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:26:44 -0700 (PDT)
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
Subject: [RFC v2 06/24] target/arm/kvm-rme: Initialize vCPU
Date: Tue, 28 Jul 2026 13:26:12 -0600
Message-ID: <20260728192630.240375-7-mathieu.poirier@linaro.org>
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
index 03a30afcbed1..c7927036360c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1055,6 +1055,9 @@ struct ArchCPU {
     /* KVM steal time */
     OnOffAuto kvm_steal_time;
 
+    /* Realm Management Extension */
+    bool kvm_rme;
+
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index eb8e65ba438f..5d6814fcf9e5 100644
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

