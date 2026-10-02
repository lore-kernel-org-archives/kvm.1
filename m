Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2274C51589D
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972451; cv=none; b=lGoi83IOAdNRqm64Nj8oTMjXfAKI2KkoOxpOk7EuUJyq4GxQ8CLWn9Qb1CnCILIs0ZAyB5WzEAhehZVrakpiZ/kOTB9uXxyPQAs6ShTe5jkDfRUrbdL4Oe9MCQGNODLJzhus5JuAFVKHSSriSzvVCa6knejqpemuxIrImkOuvQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972451; c=relaxed/simple;
	bh=m1EUMzxqCddEoTM4ZhoMT0cLKDHs8BioXMs4YhSMSa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DySIRrXPzP0iJzRAoFozblnCPCKq5aajJGjLJWaD/VfSZtFB0fFHuBdaZGT3qbjeOcLjYkaGuQo0Kwp7OPri9ugFZwhfTr4vLof4/gIyhxTsUhzkDYedVIaA7zwyYqzzqfBIy8e0LeePBybla4tA/vPlb2bEjfQNRw6yPdS/3Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BFHpVAfq; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BFHpVAfq"
Received: by mail-pj2-f39.google.com with SMTP id d9443c01a7336-2e2d2bbcab2so18103905ad.2
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972449; x=1791577249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6DwGY+dTgmWXHvT/Uc+wVJeKOjzNv5zK48BpM+cp2kU=;
        b=BFHpVAfq4P4C6O2OY3yWd1CV9gIlBLWHLkkc4X6HBx4dbaNfpwn1c4RSVh7UnuzPg3
         oxjXBfpm0D0nHLGbQTfd9/PavOJEH7UvgD5+pUO/y9uf5WLV5e6o1AJ13I9OiVLax6+b
         YQa5uMvVIYhfxsK+5cm9WpwlppYkj9iuzaPWTX6ft8o56eqVAJyBW5aLwjKjL1jb1lHT
         7HMlhVEFW0hXzDvul5yYXP9osMi18wTLvyyAViDKmCTImXn8Z2yVV3gVSWI+4oU8JeBz
         5izvdWER68ZSs/4BkEDBjBiTOe6iSMbFr4IHqjl/LmltgqXkBfi9XYmJr+1tGG7f0ZjS
         h5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972449; x=1791577249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6DwGY+dTgmWXHvT/Uc+wVJeKOjzNv5zK48BpM+cp2kU=;
        b=oY+UQZeFfCmYDwJfS/KChWimhBFhyS1TcO6LwlMi6pLjnVyfZ+74heAAa0M6JdgjFN
         kwCWk0JuLAE/94lhcVjaTh/xhrvRXqhC7+UnIWgQS5KiaSYQeikDSZl+RBsUTCqHOFkG
         I7UXeDpg85aAB0Zj79BB7BEeSfg8irKLBb0sTCW72OnyeGy+4pyPhu/I1PZXCYLDI3yo
         wpkbrfeuciazGauOtC9TxbB9NJEKPGtLy2Q/FqNkX86PjergkdZ8WQU8b22fp09wa6gj
         E+4HaPuVFvtyw5ugMsSR6jbAT1TCeNiGsSADCBQCBIwJZrTOUqQs4pmfo8cWxRBZZa52
         pRQA==
X-Forwarded-Encrypted: i=1; AKwUvBxrZSS7KODUd3D9e2tUnpolk/B95HIwb5QFugOFa39d03MyCsN0GbjDrn44/th7rqdHcDw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUthsFKS4NeJo0M+rNAE6O4Rk0jgKe0OftujQjqWnuQ7GUEJMF
	cv4CRWc91N0ojZU+shSyCnfk8zqi+brJCl+q4LhBLpnQ4CZsa/t+8RRIggwbUeV9yLY=
X-Gm-Gg: AYBFou2MbZnmRZ/Mgw+B6muJECAvaBlH5MpfSXYkJPdyxRC6V1HRXLKZROUOlTeomUP
	kldBa5Jl+/luDTmzJtO1hMZzQCiW2vOCbAbN7OzIFpKuIEVFW+Wpw30P/SQL4tq56Tt6sK6naVb
	ciyoez5w2bsBrmx0JPzsrM5Q14Q9jj8NjGqgfLTZmmRbomYt1r1v2s4qaz1aU+H46KVeuNRTUhy
	j0R+qwFtXkfFuNqya8ASP5TaaDTSSyMoaAn7nk+6ZK4MPMkUs1zrUt2x35iD6ZplunUbmkgNzDZ
	Fen2P0kdq4gzxt6qA6bOptc4wGdSrue1F6kRr+vRa0xR68f8gy02Gll4gr6r/gs+Jhp+9H9vvoz
	agZtiHTj+t8MaryA8k/YsX/k1uGWW7yO5Ci42C/REsBIkLNnwwVLyzQsIoVCCeU9qurqKUHBQQh
	d6WAnMUkdHgMWAmZr/NHAJEJRD2XGCxXZ57knfAZGwVgkkLlKf0a9s5vxOiYmxt9zqIdzwHiJZS
	zMgkJfpOVtN6/iLPyrhe+mO
X-Received: by 2002:a17:902:ec92:b0:2dd:8e7d:90f7 with SMTP id d9443c01a7336-2e49b6052bfmr37376585ad.9.1790972449156;
        Fri, 02 Oct 2026 13:20:49 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:48 -0700 (PDT)
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
Subject: [RFC v5 11/22] target/arm/cpu: Set number of PMU counters in KVM
Date: Fri,  2 Oct 2026 14:20:15 -0600
Message-ID: <20261002202026.1204110-12-mathieu.poirier@linaro.org>
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
index 2e41c2be3b71..a5b8b7ccc70b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1201,6 +1201,7 @@ struct ArchCPU {
     /* Allows to override the default configuration */
     uint8_t num_bps;
     uint8_t num_wps;
+    int8_t num_pmu_ctrs;
 };
 
 typedef struct ARMCPUInfo {
@@ -2158,6 +2159,8 @@ FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
 FIELD(MFAR, NS, 63, 1)
 
+FIELD(PMCR, N, 11, 5)
+
 /* If adding a feature bit which corresponds to a Linux ELF
  * HWCAP bit, remember to update the feature-bit-to-hwcap
  * mapping in linux-user/elfload.c:get_elf_hwcap().
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 483441dfabe3..22a8394a9f4e 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -745,12 +745,53 @@ static void arm_cpu_set_num_bps(Object *obj, Visitor *v, const char *name,
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
index 1acf62545e7a..28d00f520e9f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1000,9 +1000,43 @@ static void kvm_arm_configure_aa64dfr0(ARMCPU *cpu)
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

