Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263497;
	b=vFxjiU5OyGnf/KgZ4EVRju+XbyZyF9gb9B5POb3br97kbTvJA7Ys7KHxYSmdMOp/EB1P
	 GpkvYJA2htQSezxzWlAjftJhLq7svpabTMqZSEA40b3EjFaXlJUc4n+NCecWpvbqlmVvX
	 VxBj10wMMvVqEYIJaePaO5SorCgd1NLiy9og9Pnypvnyt84RAiZlcVmxucGWFpV6MyZct
	 EqNO+q9Ul4wohqejdaMZ+h/K7FiWHS1NaPLS8TTPlLHqntHdZmjyAPz6uOEuxZaW7ZwaL
	 Uv4Hg0CAG4oHlDRRR7V4NH0a5uEO9rQrfMkRRU/Nq0E2Zapm2qaTR8EJOJb3k+L65Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qffBcw2XnFNxd/1mYXvqBIjMdDc+fw6jbgfRGioxHxs=;
	b=fbmtSH0gqYmithlCWl9Kglpf0xvnZaFHIAq2gmK9rYn9SdUOp04PmI4LhxmvFa0SDLAG
	 Cf+VQjYEwfDhqkcjcDIl1cj6IZzZRBEN/vpT1BFn2kfmAiH2+gD6WX8/5TZWZ8R/DKVI9
	 gSQ+64nJXPvijRAruKbTcKip+F12wPgrUTPlrNP1rr4QhgqG3ED0SQO3SGCaY41aidiVB
	 OWDq2P98cEubqbc33HF3Bm9+mX/BYOqiTvoxw/kEBhhpmsUWI2OvDVFRiQSq3Do/l0kRP
	 vcsB4ysl6npWCW3+Y4q8NT2uI5KJFSHb60QVDSI1CMsLf49WYAVXt2z8L2iB/Y61j1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CkHRtPcW;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5AA606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F5AA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CkHRtPcW
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ccca948203aso666721a12.3
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263497; x=1794868297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qffBcw2XnFNxd/1mYXvqBIjMdDc+fw6jbgfRGioxHxs=;
        b=CkHRtPcW8+t9/qisddL7cr8QDf3yqmdyyZeV65OwgKD9v7pv1W421EC/3hX9cXR5tS
         syGdEwApXQ+ZaTEaRkw68BlTdGJO8YVW0+EyKK+sxA0nututJSHCCPnygQor3a+GWIkO
         zF1DHLQ3llbNj7yx78aVDgjIPecjck/i3TCZXH81+TzJmeM9xTbqksydao8pjRdc49Fe
         scRBDsalnuRb0MMzHSVjAdSL7gyldLVXfp6VJrjRyMrWN4CxIIbYt9EsEhszYz+HDxqs
         78BvTrnlLAwgE8B3wj4ghK8/HUtnvBXjqNWG8uV3xdhvm/Q7+OBwXd71zV8iY3/JCBYR
         uzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263497; x=1794868297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qffBcw2XnFNxd/1mYXvqBIjMdDc+fw6jbgfRGioxHxs=;
        b=GIKmsIm2Wt06GjQ59ZwnXeaP3K8u22iQ9+nHAUpsHjpXrR+ighcOUTGmtGiknivN06
         YQ021C/R0ORaFUW+Nw5maKWmgacQbRFArVFnMi7eiQXRb0ll/lzY4AV+4LdmRa0aXjoY
         T0sJ1qf/8HyptVFwdiwB+Atz/Y9SRiz0FZnvWVYka4+ZbToeVzXeA1ThjIPR2INdAq09
         NpztsvfbQQsCDn6ST9w1Pt0aeU9SEkwAuPgyU9kMIuxDpbuSY4v3u+Yh7z1vAgpBXHpl
         9JqoDP6x+YpwyJs2RB7JMXtYdJbyWu4Huxx1H0Y/XiGfDtf3GUkUfzrz/UBWidlIgxBU
         Cxhg==
X-Forwarded-Encrypted: i=1; AL+hErE+exNPhcSzLm17pQyxfOZkP7BjBzsDQ63W5IQGskVAaFgmEx5rjZHlghAWE45ECDpw3jA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nmdnlmJdQZfcREZqIUwYogJ/FVtPojzbpx//Vj4hVy+ddcsYA
	fDKr5oj4Vhz40oP/OHcPNUJe9ajmEJcJ7022ekZjyppj9NOSTGX/s+wtbxu28X7lgLg=
X-Gm-Gg: AYBFou02eyYQVM4GMSja7GhzXwH1RusqHNWnU1wz25jzTcksYptMb+gffc0lQUHwzaz
	iS4jj7MqeKbOauI3NSQNtIf4BZk9qcLllpQAi30v+NQ1dvZ/fPOVuTCY9fJ9lZjL79os6blpxJG
	q8DKNgpsy1VAV4tKzbRPP7WafsQ3TYe8jQM6FaeeZvf4zO33FzeGb+y/w1DVT1WedEL0vna7SFW
	oC3TReGkiqhJxC+8zmYbli26DKCV9O+fsXcAa8xfIWdtkoAKXeHynjQwYcatJXvOF0L2mrDy87X
	BiGMLFqXKlFnxeomepm5FAHnA8ivja2gS4E9JI7SOpbPR/qoxvVH1pNsdurw6fDS8NEuM9SU6j4
	d6a542c4I7a/NUaOz2oqCmyY6vcdTlJFHj5P0Gz4EzxFrrxJXUr60AROwrmxJDdeL1nWlv9y+p8
	figJHFq1xy2X42CMVA/+P+jvvKwbdqpz3U6ZVl9I9J4qDmKXNSNqgh/pZWVnDQAkI8pbpusvKpN
	gPNBnD2GzdjD6JdDZFTfvaNAMdJYLTZWnEbCdDfzJ/lBHsgVR0XCV8aiywPNmU6eQLmK4xbqgzT
	3EZ8jvrVZdCydjJ7FdarKvlJ1bobQ7vTCXlhoxONC8cOK2GoXMfq6w==
X-Received: by 2002:a05:6a21:320b:b0:3e0:c346:734c with SMTP id adf61e73a8af0-3f190e9a4admr544580637.89.1794263496430;
        Mon, 09 Nov 2026 14:31:36 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:35 -0800 (PST)
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
	gshan@redhat.com,
	michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 12/23] target/arm/cpu: Set number of PMU counters in KVM
Date: Mon,  9 Nov 2026 16:30:59 -0600
Message-ID: <20261109223110.1619504-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
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
index 1c2f31db0d30..635ac2168b58 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -77,7 +77,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
     "kvm-no-adjvtime", "kvm-steal-time",
     "pauth", "pauth-impdef", "pauth-qarma3", "pauth-qarma5",
-    "num-breakpoints", "num-watchpoints",
+    "num-breakpoints", "num-watchpoints", "num-pmu-counters",
     NULL
 };
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index dfabcfc5eda1..f36a9678a8cb 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1207,6 +1207,7 @@ struct ArchCPU {
     /* Override the default configuration, only for RME vCPUs */
     uint8_t num_bps;
     uint8_t num_wps;
+    int8_t num_pmu_ctrs;
 };
 
 typedef struct ARMCPUInfo {
@@ -2166,6 +2167,8 @@ FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
 FIELD(MFAR, NS, 63, 1)
 
+FIELD(PMCR, N, 11, 5)
+
 /* If adding a feature bit which corresponds to a Linux ELF
  * HWCAP bit, remember to update the feature-bit-to-hwcap
  * mapping in linux-user/elfload.c:get_elf_hwcap().
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index a34de3d2947c..42383cb22431 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -764,12 +764,53 @@ static void arm_cpu_set_num_bps(Object *obj, Visitor *v, const char *name,
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
     object_property_add(obj, "num-breakpoints", "uint8", &uint8_type_info,
                         arm_cpu_get_num_bps, arm_cpu_set_num_bps, NULL, NULL);
     object_property_add(obj, "num-watchpoints", "uint8", &uint8_type_info,
                         arm_cpu_get_num_wps, arm_cpu_set_num_wps, NULL, NULL);
+
+    cpu->num_pmu_ctrs = -1;
+    object_property_add(obj, "num-pmu-counters", "uint8", &uint8_type_info,
+                        arm_cpu_get_num_pmu_ctrs, arm_cpu_set_num_pmu_ctrs,
+                        NULL, NULL);
 }
 #endif /* CONFIG_KVM */
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index c8a821d7fab6..572d0e294b1c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1025,9 +1025,43 @@ static void kvm_arm_configure_aa64dfr0(ARMCPU *cpu)
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
2.53.0

