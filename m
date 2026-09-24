Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C934078CC
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271055; cv=none; b=dWFaY1J9KnKt6OdZdnn/hQGhMS+cmx4DFJExNHio54ajkBbb+DPytk95H4ccKQKHLlTQyETy3tnR+J7XGzUbq7OK6Hke5p7ZxYAnHJyqzlMdXHb5rk7N1fU/OL6wNnYp3krVSm+WLwFATVmIlaa8bYjpQQ2PT6QvfPdreCoqeqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271055; c=relaxed/simple;
	bh=iO4o5vvCigqMl1XTIvNVuWo+6sIhtcYU1fPxvKjwIEw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UtKHGDXYXqXcPOC6t48/uQVOx27xOpzN9EuT0nBpvFI9JnEidjJfs/VQtHxb7uuqrDrrHRpNqZstYE70nQmRt/kFBS5rwn6AoGaQjqfqJ8FjkJg9T+ND4PRKyy1xm+xEZE0TLHtfZ1Phn4aYu0yxPb/RVIZtUkIPZbN4jono+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfzMQoYk; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfzMQoYk"
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b28dbf4197so205972b6e.2
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271052; x=1790875852; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p9ajE4KB/2zz+KUwHLTVbTKktfg0s/rVmELPB+FKPIc=;
        b=lfzMQoYk7n1HFkDXUzOED/8O0UkHiAazNBzzPEy9YEypHnecZi7cphNnP1GKoBsb1Z
         ADYHtaidiwmJZ2jGP8M1Mka79PDliBHLfc8e1RDp8/f9MA3Ahx+47E7PXH4nq4ErmDXb
         BgR+epNhcVa9usB9yGC8tSfOUXSMqfKZBNNqsAlFIZbb78oBlC5TRiK9a2pZ7uPOZWkt
         jFCJTpelwLvPQEqXGsQ0nPKmj/nz71fDUIRiLB0E/XzG+4Zii6EF8v1Oa2DSln6Vv3r/
         gjW9rg07M1gZkCeR5hfbHooc7BeaXhkZWejSUcnC9Yhwzddiq8/6H0KeYXFPQckyX3E5
         K3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271052; x=1790875852;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p9ajE4KB/2zz+KUwHLTVbTKktfg0s/rVmELPB+FKPIc=;
        b=H/6PJrswUUuGKJsrBoReNpVS/KYE2GZFf2nryqd5StuJydeEM24qR14S1S2N3aixb9
         2N5i/UsRrijm8JlDAS/q9zzy9skEd0nXcHHTpnS4BuEcbMD2B406Y/EcmBjzT8Rqg0Fo
         kJ3Nz+MiFHG+3wzM4uJCAAnhplthPG4AK/VhwhIZDnahLP2rrKpmj3v3Nwa6R8QmSabF
         THpTNZ7cMoxtYDMAZ9p8lGCCfWKLffMqU7wVyw8mpV6S2LkoRJ4rvC4UtoCYS5atqHK9
         m00h0H4YlLnKj8HWlil5QEALDGPH8SEk0Tu0UrY9vB/BolPZkp9MHBRm8amh6dgC92bs
         VT8A==
X-Forwarded-Encrypted: i=1; AKwUvBwmZ7S2Lc6gbhpjWtb4ouMLNg3cnkPAmWbON5eo/3wSVXZtWY1E4wQTfb45YsgTag2bWXs=@vger.kernel.org
X-Gm-Message-State: AFuF++nONsa/OnjuQcl6/idEJAvWpywkujanKdqyAGHPvtz5yKiCQsrM
	5qc5h9CBYQWzLf807j0C6TMHzszJkjaF6kk++kowjxgXepy5x8IQ3kPbsTXeAWLf2boFj+ax3PE
	UZt1JpIugfwAiCXi0Ajjln75yhg==
X-Received: from ilbed8.prod.google.com ([2002:a05:6e02:4808:b0:50d:48ca:d970])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3c48:b0:4d6:93e2:5bc1 with SMTP id 5614622812f47-4d72f2476f0mr2919401b6e.66.1790271052204;
 Thu, 24 Sep 2026 10:30:52 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:30:51 +0000
In-Reply-To: <20260924172928.2110956-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924173051.2117637-1-coltonlewis@google.com>
Subject: [PATCH] target/arm: Enable KVM PMU partitioning and counter limit
From: Colton Lewis <coltonlewis@google.com>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvmarm@lists.linux.dev
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mingwei Zhang <mizhang@google.com>, kvm@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Add CPU properties to configure KVM ARM64 PMU counter partitioning:
- 'pmu-partition' (bool): enables KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION
- 'pmu-num-counters' (uint32): sets KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS

When 'pmu-partition=on' and 'pmu-num-counters=N' are passed via -cpu,
QEMU enables hardware PMU partitioning and reserves N general-purpose
event counters for the guest prior to calling KVM_ARM_VCPU_PMU_V3_INIT.

Note that this patch is an example to demonstrate the KVM ARM64 PMU
Partitioning uAPI [1]. That is why it aborts immediately if setting the
device attributes does not succeed.

[1] https://lore.kernel.org/kvmarm/20260924172928.2110956-1-coltonlewis@google.com/

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 target/arm/cpu.c | 20 ++++++++++++++++++++
 target/arm/cpu.h |  4 ++++
 target/arm/kvm.c | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f58a1db843..7538c6a24c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1359,6 +1359,20 @@ static bool arm_get_pmu(Object *obj, Error **errp)
     return cpu->has_pmu;
 }
 
+static bool arm_get_pmu_partition(Object *obj, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    return cpu->kvm_pmu_partition;
+}
+
+static void arm_set_pmu_partition(Object *obj, bool value, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    cpu->kvm_pmu_partition = value;
+}
+
 static void arm_set_pmu(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -1604,6 +1618,12 @@ static void arm_cpu_post_init(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
         cpu->has_pmu = true;
         object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
+        object_property_add_bool(obj, "pmu-partition",
+                                 arm_get_pmu_partition,
+                                 arm_set_pmu_partition);
+        object_property_add_uint32_ptr(obj, "pmu-num-counters",
+                                       &cpu->kvm_pmu_nr_counters,
+                                       OBJ_PROP_FLAG_READWRITE);
     }
 
     /*
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e3f931dba2..1320e76fd4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1004,6 +1004,10 @@ struct ArchCPU {
     bool has_el3;
     /* CPU has PMU (Performance Monitor Unit) */
     bool has_pmu;
+    /* CPU has PMU Partitioning enabled in KVM mode */
+    bool kvm_pmu_partition;
+    /* Number of PMU counters allocated to guest in KVM mode */
+    uint32_t kvm_pmu_nr_counters;
     /* CPU has VFP */
     bool has_vfp;
     /* CPU has 32 VFP registers */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ed99be7fd8..3aa8243278 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1846,6 +1846,10 @@ static bool kvm_arm_set_device_attr(ARMCPU *cpu, struct kvm_device_attr *attr,
     return true;
 }
 
+#ifndef KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION
+#define KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION 5
+#endif
+
 void kvm_arm_pmu_init(ARMCPU *cpu)
 {
     struct kvm_device_attr attr = {
@@ -1856,6 +1860,34 @@ void kvm_arm_pmu_init(ARMCPU *cpu)
     if (!cpu->has_pmu) {
         return;
     }
+
+    if (cpu->kvm_pmu_partition) {
+        uint32_t partition = 1;
+        struct kvm_device_attr part_attr = {
+            .group = KVM_ARM_VCPU_PMU_V3_CTRL,
+            .attr = KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION,
+            .addr = (intptr_t)&partition,
+        };
+
+        if (!kvm_arm_set_device_attr(cpu, &part_attr, "PMU partition")) {
+            error_report("failed to enable KVM PMU partition");
+            abort();
+        }
+    }
+
+    if (cpu->kvm_pmu_nr_counters > 0) {
+        struct kvm_device_attr cnt_attr = {
+            .group = KVM_ARM_VCPU_PMU_V3_CTRL,
+            .attr = KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS,
+            .addr = (intptr_t)&cpu->kvm_pmu_nr_counters,
+        };
+
+        if (!kvm_arm_set_device_attr(cpu, &cnt_attr, "PMU nr_counters")) {
+            error_report("failed to set KVM PMU nr_counters");
+            abort();
+        }
+    }
+
     if (!kvm_arm_set_device_attr(cpu, &attr, "PMU")) {
         error_report("failed to init PMU");
         abort();

base-commit: 014b1f730c0faa08067f8e9b5829e62ea3d4b177
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

