Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5343E3E63BD
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464204; cv=none; b=q4JTVgxvUgE43eSscTr02jcznmVZOYxQafPXci6U14GMTVfglGdkAfP983wIVGqoBigmoLL+N0AnJYhsIUBcgpbn2ZNDbdyQfCRdYJ1BKCC+VgXaBFaPinddHH4XGbH2I9Edusw/zfczBa5VCcRGXdFJeCvwug8NliOYQznnw5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464204; c=relaxed/simple;
	bh=NglxYvczm+es2eJsk84Q1jYbG1GCGymK2cDTOOe6R8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zz7D5iELiOp7Da253qptcklUWxrECY4hRVihwhKpUyg5odfsc5J4v7qsVuj6Y/wMJ0Ty03Imwn/MkbXGn+xvUlb1IpTinsTg7T2xF4h1PUJR/E4/tgFim8J7Wka1pf9d9lFgvj0XdciUIfPZoCwJ2j3+O0zw6tUa1uYYIYTJX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LiEWrPhx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LiEWrPhx"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2caed617615so761285ad.3
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464203; x=1784069003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+Uo2EB9jLwY0LEkC0O2VfYLiSzWX0HxD0y0hCTws0U=;
        b=LiEWrPhx7djj2QCL0AadsX6KKaj5FsoCKtiaDpGX0dCSX6e5v8xqsdK5gXDGr26Dp8
         88uWpLUz+HgD1vvHOGbuVbxa475y+9yfS0/m7fWSy7DwgEwBWDSXTAC/BuPwYVQqjPC1
         0XkBDivwMo6L0huQhifM7aFwP9FnIH5+34/YRI8etcpJaTcgdpoUmQApkagUr27USMS9
         AblEb3y/zksTPV1IJLppofbZ4XZ9y18z5p2v8NcmNrDO4xfJfB6Z1vAhn08AU3g9tF9I
         Y45K+j5ZoUfTp5EdFRMhE4uypDUIZdL2nOVyxmCXDwaiQPuEWe5T/NCMg7TrTthp2+Ky
         W+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464203; x=1784069003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+Uo2EB9jLwY0LEkC0O2VfYLiSzWX0HxD0y0hCTws0U=;
        b=qARMYaQcyqC9WSGImNGlQmltGoT8Y7MkGebgOsvX89onTxy717YQ1/l/1eYGvTziOa
         Mqvcb5yv7tnEEG1xOgLe9UZrwKA7esgikCUo1J6WPwh1ck8/pneNGGgyPdt2IK7I8GRQ
         EPsdKAMDUlGSWAWZnsmQHQvgkoyNSl8rdrLqM4iH09Zpfx/OFRhHAHSXDLJu2+OUz457
         iViAjGFbUC8gAg1/6oVyee3bKIN/2NhXYyiPPwBLk/6Y/+ZmdEhnQuMjlRk/PJXplAVR
         9V1ajVryt2Gwuyj8gHeB5MSJ0Fd+y493DUPUeOdZSh2XEVCj4ZPu+HG3EUTeBiN/BWdo
         sKhw==
X-Forwarded-Encrypted: i=1; AHgh+RpudzeT2vpjKghMLES7XNhruGDYqUPJZqwZf2sE4PkweARcDaySU+uEECmW63umY2LJUJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Lva3sHqQq1rK0HDgQTf8vOHG4HbXkBGFMsIbPt9ji6QdKelE
	hUrb5PcDZP56baVoV2dauV7meJ5PvCqfy1pReAURx71iw31LTK+1DphjFowF2FjCDs4=
X-Gm-Gg: AfdE7cmqAgZYjGbGVwXm2DStBZY2t+PtVLTk2GJ+mxpioKTPrblDi73IFgpIyFgz/a6
	9WstV1Vo3Ri4KWJvZjM9e+tMjZN/Fy/gTDkorHN4bRdndmpFFl0aBPdwFl//EwmtoRjFGbXWXCC
	17sTzTACk2QKekOO2KiTWchZFPgukvwqjLDiryfCASnK/zvuZ7VHmkYmlWZj0/o8pFgVCV8LUCH
	EHhuPC6ojgXfvuVbg8jMV3zdoEz/E1XtHX7uS2nj4CRPcS5cJySzNWcuNV7bDva2uw7+ZILWhKM
	LGgbJ9uqoLvQixti/C7M5KSa/tB8LMfWjvwlADQU2tbrXJoR4Ei/YNp0rXhcIEgh9oOfKFxu2Do
	lNSr0DZdNlHx3OnuMmAAkJer4weJWgzKADVWUuOgNmwgAmrtJJd5/kQBtjXNeUSBI2QJF0babGX
	r3M0qLjxzBMJGRv/E5Gdpd7Sc0ZCCbI+NFJ09BjDnuWuifrnLQzA==
X-Received: by 2002:a17:903:3843:b0:2cb:ea0b:9164 with SMTP id d9443c01a7336-2ccbe3feba0mr70429385ad.6.1783464202589;
        Tue, 07 Jul 2026 15:43:22 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:22 -0700 (PDT)
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
Subject: [RFC v1 06/25] target/arm/kvm-rme: Initialize vCPU
Date: Tue,  7 Jul 2026 16:42:47 -0600
Message-ID: <20260707224306.1202330-7-mathieu.poirier@linaro.org>
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
index b86b9d6a25cb..90c1d30ba24c 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -90,3 +90,12 @@ int kvm_arm_rme_init(MachineState *ms, KVMState *s)
     cgs->ready = true;
     return 0;
 }
+
+void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
+{
+    if (!rme_guest) {
+        return;
+    }
+
+    cpu->kvm_rme = true;
+}
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index eec1ca3dd2e5..4ab6f08637d1 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -124,3 +124,8 @@ int kvm_arm_rme_init(MachineState *ms, KVMState *s)
 {
     g_assert_not_reached();
 }
+
+void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b609f29c11c6..4c212ed0c337 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2009,6 +2009,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
     }
 
+    kvm_arm_rme_vcpu_init(cpu);
+
     /* Do KVM_ARM_VCPU_INIT ioctl */
     ret = kvm_arm_vcpu_init(cpu);
     if (ret) {
@@ -2163,6 +2165,29 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
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
@@ -2274,7 +2299,11 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
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
@@ -2361,6 +2390,23 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
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
@@ -2472,7 +2518,11 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
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
index 6d058b0e08a2..12ed1eee18b4 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -249,4 +249,14 @@ char *kvm_print_register_name(uint64_t regidx);
  */
 int kvm_arm_rme_init(MachineState *ms, KVMState *s);
 
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

