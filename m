Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528784FC8C9
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464219; cv=none; b=hBEb4kMvEFhFPBS6+d5ejNYFy/n3GJJg0HiFWVfBY7vcZ1+QvFfvw4W5gICFdcgHp6dY4NP98zUZuoM6eOLskxZoSMor7VXiom2YApE+gog9V6yTRkhdJ9gPlvfuOtl00RPOE+o9CcSFZc454wxbuTlFp9indZRspMV5HQUZ9dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464219; c=relaxed/simple;
	bh=lkO3+OzwYLI17WMsduSe5hR+HjtjPjNXru1ZuauH2Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9v+u1hsZINDV5wwATZpcVrAbd4kn+h/lvG1saO21g/+3ByEuQNv0/zZ4zoPHRzUudTS9Di2oZtS1GxYnRRi/2VanDpLEDs40w3pOZrVqj9eyKlUsdyqLq4CmcQe+aUBn2WqCufei07WVP8PvfkvzqHB0yJBQs0uH/YkgERUzwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=alxA7S5H; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="alxA7S5H"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1cbb64a1fso374024a12.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464197; x=1789068997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZyMMTgmt2sQTNt+w2rcYuEGgP51if0I05nXqeLHxTK8=;
        b=alxA7S5Hd3vW+yNIRLGYP1ZdlPlU1QjeqZTkoigxM9KoPJr74LlNygDz3pLDd7Wa3h
         2xSBbqcIdq4E+W/LbvokfwUsZ++p17WkHfSTGJonF+vNII8eunBHr0bS/mvwJy/VgJfL
         2iYu2pkzSlQXNOX8CdMW5t8jyZxPpv+M9iaFmdhQlBa7Ttbpnj8wsKSTYifo5d9VaGjU
         uXHtFyKLhwOY4LsaQkcvqa6HzTUWQR29XqWLtbppzNG6gqyKvRr3RzcHUFeFXT/3Oym3
         U0w0OTxX36c/Gndz4M9SpOtBcnGBikC8elw7IAVB95zFPVKUcKUA24Y0j/MPnpcOmQpC
         RONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464197; x=1789068997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZyMMTgmt2sQTNt+w2rcYuEGgP51if0I05nXqeLHxTK8=;
        b=Vk37iJbXxapFOclo8IC6VcJvtNLEnhXWJbtBVAU8wcVy37Y8WNQR98V2mHW1S4TETc
         zD5QcgWgaFAMDhEpVXcmUkyuLSMN6jeuJfC16A+r751A5CP13MkzQT5NjjuHqBTkp3vV
         Bz2IkZhxhfhVAR3fyUV8/7sqLWhzo6Fy3rGiHvfEoTAVMQoSaXkfw+UixclSoXzzjJoX
         G98NiKbjw1Q/OvVaC7OFSI398Ot7BHbYrX0eMSSWGtYSRcQzFVYlVDD2zLcNNp6DvlcF
         Bcsh4Nr0TOs+jApwAx55Kyb4co1S0OlfQAFR+tgQtspiK6K14r8GMuL0JnNCtiiTVcc8
         4Z9A==
X-Forwarded-Encrypted: i=1; AKwUvBzzBfTVOSWSTl6L+sUf2NcOlC/HA0JI1wiZu6JWmQcR56CHKlGxFSU7eKU0PsJBdbBOzPs=@vger.kernel.org
X-Gm-Message-State: AFuF++n0Q4Cebcz/ofjMKduxY4xoqed7FG+dtLyJ6/zQOcHukHwgmzHs
	jLD2+x/Idy0WUKFQ9ndSAyAD0TrtGAlnLp/AjNSDMpQWlarI4wC8VyySvxRVMCFUlQk=
X-Gm-Gg: AYBFou2koEHGWW2F3lagmjCnQrerZ65EVw6HzorFQsiVsu2MLrl1O4LXjeCqL8NXzRo
	r5zJQabWQyVwqJFHkaFB2KhuAfoUWI1XPOVBCtVKpRZD5WA7TzqLnqmdfgqUXWKLtk/MAc8Ox47
	DzeOiJPefbNloLssuaU1XNpLzWg6iDXoF7UN7k6dL0FGoakw2rG7Q9lncT0XkvwozTrjbtVl+Wl
	XEaOqZzqlWco8edmmO37Lq2WYdadCi8n33fVd58G6GtETTTa7pJbzd2EeLWP19Pv4sefAEqkCGl
	uzl2iGomZU8UVIChp0S3PMhcy7PqxuCC19HVHP0sc1D1xg+TDWTiy4IrzqGDKQkG6TL8hDKJEzc
	DjQ4K2ktQDZ0zAiclD1mgysEZqzlcucENnLLFAKCKVn9GIx0PinLOf2G36t63gNdsATGLXgFN4a
	yXW4ivXOxf601pNPyIkj++vFiTgZFwK8iIgZk3djxFrlsgXMfM1NRzF7qvc31lYstyzMq69wzUi
	dEimQlnZUc0deI=
X-Received: by 2002:a17:90b:528e:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-39b25ee67f0mr1432023a91.0.1788464197492;
        Thu, 03 Sep 2026 12:36:37 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:37 -0700 (PDT)
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
Subject: [RFC v4 13/24] target/arm/cpu: Set number of PMU counters in KVM
Date: Thu,  3 Sep 2026 13:36:00 -0600
Message-ID: <20260903193611.1058589-14-mathieu.poirier@linaro.org>
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

Add a "num-pmu-counters" CPU parameter to configure the number of
counters that KVM presents to the guest. This is needed for Realm VMs,
whose parameters include the number of PMU counters and influence the
Realm Initial Measurement.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/arm-qmp-cmds.c |  2 +-
 target/arm/cpu.h          |  3 +++
 target/arm/cpu64.c        | 41 +++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c          | 34 ++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 9ed65eb090d7..9350dc30d12f 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -76,7 +76,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
     "kvm-no-adjvtime", "kvm-steal-time",
     "pauth", "pauth-impdef", "pauth-qarma3", "pauth-qarma5",
-    "num-breakpoints", "num-watchpoints",
+    "num-breakpoints", "num-watchpoints", "num-pmu-counters",
     NULL
 };
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d256d66a3e1b..608c5e0124b9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1177,6 +1177,7 @@ struct ArchCPU {
     /* Allows to override the default configuration */
     uint8_t num_bps;
     uint8_t num_wps;
+    int8_t num_pmu_ctrs;
 };
 
 typedef struct ARMCPUInfo {
@@ -2133,6 +2134,8 @@ FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
 FIELD(MFAR, NS, 63, 1)
 
+FIELD(PMCR, N, 11, 5)
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
 /* If adding a feature bit which corresponds to a Linux ELF
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 18adb06d78ad..3581268cd718 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -737,12 +737,53 @@ static void arm_cpu_set_num_bps(Object *obj, Visitor *v, const char *name,
     cpu->num_bps = val;
 }
 
+static void arm_cpu_get_num_pmu_ctrs(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    if (cpu->num_pmu_ctrs == -1) {
+        val = FIELD_EX64(cpu->isar.reset_pmcr_el0, PMCR, N);
+    } else {
+        val = cpu->num_pmu_ctrs;
+    }
+
+    visit_type_uint8(v, name, &val, errp);
+}
+
+static void arm_cpu_set_num_pmu_ctrs(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint8_t max_ctrs = FIELD_EX64(cpu->isar.reset_pmcr_el0, PMCR, N);
+
+    if (!visit_type_uint8(v, name, &val, errp)) {
+        return;
+    }
+
+    if (val > max_ctrs) {
+        error_setg(errp, "invalid number of PMU counters");
+        return;
+    }
+
+    cpu->num_pmu_ctrs = val;
+}
+
 static void aarch64_add_kvm_writable_properties(Object *obj)
 {
+    ARMCPU *cpu = ARM_CPU(obj);
+
     object_property_add(obj, "num-breakpoints", "uint8", arm_cpu_get_num_bps,
                         arm_cpu_set_num_bps, NULL, NULL);
     object_property_add(obj, "num-watchpoints", "uint8", arm_cpu_get_num_wps,
                         arm_cpu_set_num_wps, NULL, NULL);
+
+    cpu->num_pmu_ctrs = -1;
+    object_property_add(obj, "num-pmu-counters", "uint8",
+                        arm_cpu_get_num_pmu_ctrs, arm_cpu_set_num_pmu_ctrs,
+                        NULL, NULL);
 }
 #endif /* CONFIG_KVM */
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 93686b038263..b8cb04f7eeb1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -957,9 +957,43 @@ static void kvm_arm_configure_aa64dfr0(ARMCPU *cpu)
     }
 }
 
+#define KVM_REG_ARM_PMCR_EL0            ARM64_SYS_REG(3, 3, 9, 12, 0)
+
+static void kvm_arm_configure_pmcr(ARMCPU *cpu)
+{
+    int ret;
+    uint64_t val, newval;
+    CPUState *cs = CPU(cpu);
+
+    if (cpu->num_pmu_ctrs == -1) {
+        return;
+    }
+
+    newval = FIELD_DP64(cpu->isar.reset_pmcr_el0, PMCR, N, cpu->num_pmu_ctrs);
+    ret = kvm_set_one_reg(cs, KVM_REG_ARM_PMCR_EL0, &newval);
+    if (ret) {
+        error_report("Failed to set KVM_REG_ARM_PMCR_EL0");
+        return;
+    }
+
+    /*
+     * Check if the write succeeded, since older versions of KVM ignore it.
+     */
+    ret = kvm_get_one_reg(cs, KVM_REG_ARM_PMCR_EL0, &val);
+    if (ret) {
+        error_report("Failed to get KVM_REG_ARM_PMCR_EL0");
+        return;
+    }
+
+    if (val != newval) {
+        error_report("Failed to update KVM_REG_ARM_PMCR_EL0");
+    }
+}
+
 static void kvm_arm_configure_vcpu_regs(ARMCPU *cpu)
 {
     kvm_arm_configure_aa64dfr0(cpu);
+    kvm_arm_configure_pmcr(cpu);
 }
 
 /**
-- 
2.43.0

