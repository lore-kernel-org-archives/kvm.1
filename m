Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F304734D0
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266825; cv=none; b=KO6LlRxTCMiYFgwoRSGHTbbEAshopauBbWaBliGDDcDr3znlO3D3cmf9Qqki/MfLJ6upfB6XQ23o6xhTTWK34mKC20zp285mbFPusqxqhOC9wIVGt3KDI3i8LCx2NUlc5YJlJwteSXQMiFKQkPgfZ1eIRdp5Sju2MvThkE1kBaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266825; c=relaxed/simple;
	bh=7IndefbIN/RXXdyeNG8hCQAshkwQNlrpF0WuV1+eyqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rH7EzUs5z4j3qN4zOGKgoi4N6C7VcrOq2etR+D6s2i3VGV/pEkOal5xaxGA54QhEmMuXaP4R1QBQln1zXaJR2SxUBCQW58zldHW1NtYyIYoFlAkG/PSqW26HDu8wPRENLP2aKU/IWTToRR/XKJyB8414qdUqtjHkbzLRMO5dsXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ahs/u8Rd; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ahs/u8Rd"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso257652a91.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266822; x=1785871622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/8GltLr+b3V/6euRVKmuC1vGLuoDnwfsRwYpfR+HJng=;
        b=Ahs/u8RdYeThiRSyDn79QudgpJ/LLjnBr0AwF/Cw92Q3lzcu2+8PM3mR8lCeDEgIpq
         KTv0V7LMsVDnFgVUeEemeh/fMZx41yhIBDxywjFnHBXC4WG+rXGEKziibGg5Oo+s2ua5
         LeR6QWMftgiYPKUw45TKP+L7qSRbaIPN+i6EDAYwhjFiPE66ZhoVwWT00S0L/jjKEWnc
         oWeIgfSzZSoqDm9zRli18OBm+R30/NLGzs5jy33aVYQ+dfDNJX6Q60BAszsXVWeHtcBT
         DmU8S1Z1d9bhrnrO5rAuUO3FB2EEJFzDAXDpPrSAmP1BzvLxMlMXpCjouqB50exwdKc/
         +NYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266822; x=1785871622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/8GltLr+b3V/6euRVKmuC1vGLuoDnwfsRwYpfR+HJng=;
        b=GRzOhfEwZfjXtXOhWEIjwgYIRJR8pPkzwuUooRJKLRXjy2WEDGzNn4QHDBzbStzIvs
         qVOK+lPKB90GUHCNn8cm7A/qWchDrVAf9CrjEZ1/EotJM+2sLYDm1KadJcwsA/rqg66J
         xNS15p1/8u3uTsZPM/7Yt2utSfBaoIeW6RWgZ8IynnnZjsIYIjkiwZSrZTs7r+z8xL06
         DB4tHo49lFhQioaFg2d0yxhh0ysSqtkD/KXinm2frZ6vPiyETN0Jegs+8F1tCAqodYD0
         33N4gs9Gc4zgUle5Mye/zwDrgZZ6z9OE2KGHZusGH+94d4/nzf5ZZYtTSUhXKEeKctSj
         tnaQ==
X-Forwarded-Encrypted: i=1; AHgh+RpFjVYjSi3wU32zcObk9abib/36yAmPycVcpSouTavsJnntMi7Pg36tnwrgji/5L/zYfsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsSClTjlhcJo602RCZtLeyhd8QJMCfISGV49Zd09bdQL+Ez/3o
	hlKBV6tZ7QcFtlu6fqHgyxaYKNP8QF1os0wQCr2Ec0/qevVoAPqTvxpRsZ+G0idXoGc=
X-Gm-Gg: AR+sD12HA0kH9WiM/cxeHJhdxqjS9oEga2K7m5uAVS3Hsl2ItAmF+dywIrMs+lBiNcu
	Ftvhh3ntitnkQIXlBhr6vKod+5fGxLRxSzKfs3ft6xb9lBJk8fThGevAVck957QPCSA6rz3L15h
	mwe+JuSKIAiYRPwEJlvZ1jR7XbNPh1hKzbQ1dbHYJKr2/cb5DPgRrHkKCcZxssB2wUrtKJIOBzM
	/R8rTi4M9R6ZrFrLowM+6R3k2isHMeA9OavROtn/tLCicx0Gvi30GLexVfL3XPDWmwuFLMF5UrT
	NvcZ8ZPTXeo2f6ADE8guU0iCGKkpk2ytzjcGp/3hypASh4NP+zpPb6tOkqayg3xTJKG33Sk8+zq
	fsADGlZkIwJ6paU7AmgnXE+JZx55GGVToDH/bwTKTfcklw+13ultpGZnibTpS3Jz1meRyr44hCl
	k/OzqswxfGAswnWRzN8pEnjclUwNXR69KS5qnitcFdvdti/MnkDg6JIaye9r/3kg03D6kqyGHUX
	uIepMj8it7b9U5EFutWirkPfA==
X-Received: by 2002:a17:90b:4423:b0:381:e74f:8a6a with SMTP id 98e67ed59e1d1-38f6a40f23dmr2808925a91.16.1785266822134;
        Tue, 28 Jul 2026 12:27:02 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:27:01 -0700 (PDT)
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
Subject: [RFC v2 13/24] target/arm/cpu: Set number of PMU counters in KVM
Date: Tue, 28 Jul 2026 13:26:19 -0600
Message-ID: <20260728192630.240375-14-mathieu.poirier@linaro.org>
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
index d6f64daec2a3..50d482b09b0d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1178,6 +1178,7 @@ struct ArchCPU {
     /* Allows to override the default configuration */
     uint8_t num_bps;
     uint8_t num_wps;
+    int8_t num_pmu_ctrs;
 };
 
 typedef struct ARMCPUInfo {
@@ -2134,6 +2135,8 @@ FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
 FIELD(MFAR, NS, 63, 1)
 
+FIELD(PMCR, N, 11, 5)
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
 /* If adding a feature bit which corresponds to a Linux ELF
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 3f12009befa8..00b3511dcbc3 100644
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

