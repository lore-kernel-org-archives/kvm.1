Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C543517BAE
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972441; cv=none; b=IADYWYle+TOtgb5XSVgUsVIgJB1mvJRFyNmyvZCzlknVCa2gA4hsH5oOOfvJLiXC7qSdsI0UXU50YjpCKW6dIh1aTOVZkc1Mb/QBxc4EiYatexn9hyMGKWSAGuioB33mFcZycQRmOkpbkK3lsSsxo0twfDJiJC5iLJwhMbkkNE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972441; c=relaxed/simple;
	bh=nTTjxbUSdEozax9obSLSNWXxoo9CUZuc3+EB0zpaol0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKoL/0Syjgxl4fdpiPDkopaa+DYkzUX25tT5iQTUQyiLXHuKsg0rnCgTRE4gfyvghzXUeTU/WZVUvPOKHG7J+h3U5P3RHjPGUbXFC4bZ16ZVj1SlcRHaXmtie3qJ0/4EksULWsOvM5+HlTQaoNbKpFy01Pn6+Rt6CjGlJm5ld8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f0TR6dje; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0TR6dje"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d747ee1f9bso39285125ad.3
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972437; x=1791577237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eIDsXT01e2wNzwGXeXMYz6ST0ydza9G7rt8/7Fhz/tI=;
        b=f0TR6djebqlGzaHgO/qHTypdfud+ghGZWiWxHWm1c93Duu6AvjFTo9PYwvR+/Dtsfw
         WDcwsA1VO73bWSSZicMjEvT8a+0ypftxbd5etiTRiUKmbldzpifx9+9M5cCQfj5V8GrP
         LFJG/C3y7I+hdJgHuIHNKfu1/nCGYRqEAyhK18da8IajdMQldx4sA7TrYC+Wu0lgA0YX
         Ax2oy1/Q7wafLZwrLOmtLw+3+rdAGYAmKduTNFhNYzEEWEsQboitJ325U/2rebdr8OGH
         FhLK6IwF7veGc4AlUDWz1PrTrNMRzLbV+X6bpDBnlMxTfTKR2w52gFiuLIN/bnu0McVQ
         YMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972437; x=1791577237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eIDsXT01e2wNzwGXeXMYz6ST0ydza9G7rt8/7Fhz/tI=;
        b=XPdy6OJ8/JKMJHBJfoQJLArW2wlh3m+JFmIDJFiR0WXIhj54kPlb+eqi3ce+WTaYc5
         Xi/xdTzpTS5KLiuCefxh7OFlBwxEOpdsZkxMhxclr4NjcJ4ebMsuNjUo20uc9B8azUY0
         0Oap+HgH0yo9stq9C/pdD2+KXo2F6ZyNhW9T/5cMcEA9nfI3scLBnArDm+iM1DAPNgua
         A92cW9TMFtWZWDcBy4aRLS16g+W4Ini/T0+Fo2a3t3d+X5vRDZxCrAVhGvJaJuxQRuIP
         +s/4SbgHyn5xejopVIaLJ2fVCD/d3SlfXMj17afPQjC7eI55qk+yqDlpBu/vWKslTXEO
         prmg==
X-Forwarded-Encrypted: i=1; AKwUvBxGQbp9edsSKV+EZPG6FyzBrZ0cFR4Rw/kOLBZNN3mPLUSjJ/m9a94k8JzirnenlEfKupw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0Zn1BVzozfStN0xEGbFKfawkkn22B1LxFQM/+2kYSKMKmzfsN
	EtvYD00ucbyPc2po9xMzaDyUGeV96k/WuzmrTVBf2ei2qFeB2QOdAln81epMkLAvJJo=
X-Gm-Gg: AYBFou1/u6tkIFCyo3zzXeojbfKNIfql/opjqYLoAYhhvuMVmNaGihZKK5fXab0bCm1
	VkDq+VRWOw6IyeNKwFq3zHXLwLK5GSt6DvoLn7dS4VLfCkLZJIjnnI2ir4WjdMe4nAF1xLpYKJ6
	G7s5FBPwyq32YSWb6dsXq/vRb1hU6+Tr1ZADkdzANrA7VYHSBJE5M/fFtm0uwGp5Z6hv8JAY3Jf
	8a1Z7XnT+IviKbt2+HmguRQjk3Iam167HccKd97Pv0nyjQVC1TeHtAgu3lE9I5F66vqvzkQfVjV
	Z8rK6GMP7w2649Im3FKpTTF7PzIBgYZm1pLYN46b69yi3FlQCCoS6Rt3r/3/of3cJLR26BocDK4
	Qvi2stpIsQOq6LfFpJ+bl7vCp+ftM7YkzmSfhw89Vb3ulrpG7XEX0lDrh7FOhw0a/BNygzUh9cg
	0y5GHfzRG1P9U3jUysphCwsES2bPgSsXplN0ljLPHk/FQmTtDB1nNNL6kDyHDK7eZJnzCslvjdc
	D2aP3fvSX7wMO/YFRvCApPS
X-Received: by 2002:a17:903:234b:b0:2e4:a2ee:a4a3 with SMTP id d9443c01a7336-2e4a2eea54bmr27772115ad.5.1790972437467;
        Fri, 02 Oct 2026 13:20:37 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:37 -0700 (PDT)
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
Subject: [RFC v5 05/22] target/arm/kvm-rme: Initialize vCPU
Date: Fri,  2 Oct 2026 14:20:09 -0600
Message-ID: <20261002202026.1204110-6-mathieu.poirier@linaro.org>
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
index 06ebed4a8fdf..11877642414d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1070,6 +1070,9 @@ struct ArchCPU {
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
index 60272b8c040d..cfee9fe99f79 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2058,6 +2058,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
     }
 
+    kvm_arm_rme_vcpu_init(cpu);
+
     /* Do KVM_ARM_VCPU_INIT ioctl */
     ret = kvm_arm_vcpu_init(cpu);
     if (ret) {
@@ -2212,6 +2214,29 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
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
@@ -2323,7 +2348,11 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
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
@@ -2410,6 +2439,23 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
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
@@ -2521,7 +2567,11 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
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

