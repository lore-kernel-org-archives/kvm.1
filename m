Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF753E835E
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695295; cv=none; b=QYRBmXAZeyEE6LQSgPFJDs1ppa/8cxiQtd1dJLeBpjSO/J5btJtmq1psPjrN6EykJPsiO40H/oxKR+uwkKAUJor+ShhwMAZXSbgzhnd2dKd4rkC4f5aa73fbn3PKYFvE4B7CjR9RpZWX3UgJ8u/DkFXa1CUuVSUnTaC0k/tAWyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695295; c=relaxed/simple;
	bh=lbiT9YnRTru9qKVbxGJB1Q1nkjp2RTM1WPIinxYx14Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCT1/MKvFoXJFOuTGxnZ48YIoEqnrOfxxjw3x92Iv+qiW0I98B8Pjp0sI4ktcVtHsT17q5LAthy/7gKEH/EigVy94xk9M5JaFMX+dU/FT0vbUY60YVFTvnaMLzGOjLBwtMHPMLVrIJzVUArSsnSQXFcqceI613g1FD2rfQjD5ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mq9ljy1U; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mq9ljy1U"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so389523a91.0
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695294; x=1788300094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6PlYTxLys8FyXXQC36kcwbteM/tzVHbDeJa1sLv5MJI=;
        b=Mq9ljy1UDEOwZzP24/lit7Px4OwsgqyHzVYlcE2SUk48JmHDM6F5hCaQReIFL87SBC
         Mh/jbuY0e1qSFbacQ09GBV0mg+CK7IBJpRmwXS2nEXIkB9JntLKWxffpupOmW7CRN8S/
         IYVpn9SySeI1m8klCe4oz4e4DqYrmxDVWut9tawCQn2llWAiywZndJ7X5NsPTpei7570
         BLk95bRSwSP0u5SmgIFsCLumo4KfxY3gL8NMk+TnRxB9Zimi3Og0BDz6vBOa/VrEH52o
         1/QwBDp5cB56LjbDrgq//8o7PxgWX9coAufie2kg1IkQRzQ9/JM8u20tYQ7JaWcMBf01
         df8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695294; x=1788300094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6PlYTxLys8FyXXQC36kcwbteM/tzVHbDeJa1sLv5MJI=;
        b=rRnH3qGtGiwvhX6E/ey/NJnmq5w0ijpBoPPAu4+MTz0nAN2kceE/jsPKpJ+RCwuYmN
         GKxsUHeV561R0NKa7f/eLVyx2AdqRug34gHRs/kOXoWaQez8aGJRKSdu1GH5a9SPA03g
         mJJaB8YGqMrI0Zlce2wOJPg4zOZwXLHwa42/2t4j7O4UUfO5MGGy9zD8Si9fS5xstHKm
         jWh+I9zDYbZGU0StOlKBhKR7yKZVLuLY33M3hBK0F0aK3fgc2jvcuTfZq/0MhTx/ejEd
         dSXBVl5hBtfRtLGm/V3lOtvAHUEETqLQ4VZjOvPg3fVO+H0jjXGy0KBJpnprgn3WewWz
         IeNA==
X-Forwarded-Encrypted: i=1; AHgh+RoSz29/E2V6GrEMwrw2QfX60Hz/q1CHnHy0TfXgykIE/di7WmvutlXZL7NfucmCxQtn9NE=@vger.kernel.org
X-Gm-Message-State: AFuF++kw3Afy1wQTuZh3zuT2U/KDnsyj8fKDO7cX1XEtE1NNBueg+/zq
	xPw7Zoy9PLzoIZW/btnlYm9xK8lqJuzgTd8RoOZgRfxKA7IhZezt9vzay0HdPuF3xv4=
X-Gm-Gg: AR+sD13kx1/fU9KwkG0kqpXecnHkG/FPlrlwVr7ejm1NMJfqSOM7gS0PaJQAvPXlKSt
	FXyRMFAVqK0nzNZkB6+Hvg02XCs8th6LxtBS+v3uIdidKUvv2Smcc48n7QIaGrdN6fgG81c1vpa
	NBx5nhAhHsjkEY8hKJDP528Usxxy+f7HjfFWGbQPAxclapRMmffwN0K5wu4wbLOvlv1lVWma7Sd
	nvUvvyDARhd2Revtk8PAh0h//VVB9OhFEt3uZdtfIZml2vWCjx2spACkm91ngosKei8o79Q6HXY
	ea8AmMmV61fIWzcG5yhnpA480EoWdKcSXHYwun9jYdan/AZUPhQq4w8cQCQTlHFFC9OkIhjyAzq
	CXkZTRSj2sJC2L2ufKgUvVyiZQSqQcLixMvZsz0M1KqdzpmYLm9Ohmj6LUOOFF+1Ytyt0Cn4PmG
	r6vQKNq0WrYVxuagjKV0DJNXlaRR/El6xmKiUXbfyg3/brxZwiNnLD7Cp5gG5rdV7VvQfcS1u+I
	z+WoiQ8OH6ck4icbeKz2kO/zg==
X-Received: by 2002:a17:90b:164b:b0:38e:6a44:671b with SMTP id 98e67ed59e1d1-3966cdf6813mr4226592a91.0.1787695293024;
        Tue, 25 Aug 2026 15:01:33 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:32 -0700 (PDT)
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
Subject: [RFC v3 13/24] target/arm/cpu: Set number of PMU counters in KVM
Date: Tue, 25 Aug 2026 16:00:50 -0600
Message-ID: <20260825220101.3443954-14-mathieu.poirier@linaro.org>
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
index bc21291eb3e5..da46254ae0c4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1161,6 +1161,7 @@ struct ArchCPU {
     /* Allows to override the default configuration */
     uint8_t num_bps;
     uint8_t num_wps;
+    int8_t num_pmu_ctrs;
 };
 
 typedef struct ARMCPUInfo {
@@ -2109,6 +2110,8 @@ FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
 FIELD(MFAR, NS, 63, 1)
 
+FIELD(PMCR, N, 11, 5)
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
 /* If adding a feature bit which corresponds to a Linux ELF
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 72c0176420fa..d46d6789d886 100644
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
index ff5034397746..85c9cbd57114 100644
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

