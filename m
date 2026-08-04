Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B84BC001
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876054; cv=none; b=VVH1/s8lzSSkAXDNV3OImU1LuAKX4VSS8/Qv6qs50dYzTytDBuU7C1b6cLS4hwWAB5y1/RkfZefXkOR2P0LgE7vsJiS1aWMbtQ+mISKCJoRbuLKTyT8411oEuh69yaKVCNgglA7tu9u7ncfKzBIQ5KyZg9KkfNrl5tWs/ptwiU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876054; c=relaxed/simple;
	bh=i6Y3AJDIc/+NHhYUrlPbZumjNKFm05ZnO0fppq94cvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GpmBU74utwy/RDq0cEpcpzsRIMvW//yummKlwK8SBOfFgQKSezu0DqbLk9Wk1bZGkxVKJlnQPnWlLiwmNnoAtwf3lja1tnnElVeu9myQ272GM72baB1IB2IIqtE+A6njqxjGKUaCitqPMEXsmZBB0H+MNhc30/LMYkJueV+hh4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PUWe9jjk; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PUWe9jjk"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so127973a12.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 13:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785876052; x=1786480852; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RVQO+0wsSIcqGCC1Ku5ayckl1cs0tZZdjNaS1/TooNk=;
        b=PUWe9jjkVvVq7qOUCfk0xrAuHvWYpqHjuZJFHHdCCd7u3XEMVfajeRiF9GQOza+Cgf
         /fbtUaIKK9v5LGILOOY7/Yg+lFwsn8o0pbeXOhfjECkZCMLNDaJLSuGfKsRRcgvpHKzK
         bfBL2PkIQViQ9xuO5xzqcWmjDVI0mO7xfPID98corv8BjiuEYtuH8dbBwP4BbKY6mqoW
         SGua+wGKuvyv1acURR599zQG3+9MGvJSg3g2BVSUuiQk1w7MrlOq9tHnL6Zpc+5asHW1
         1GT/fobd/UnWJEbrVRtRzHg1vpxWXvP+lEwK6JvvNPG5hzihuNq8/HFIJNd1Rk5O6bmo
         rmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876052; x=1786480852;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RVQO+0wsSIcqGCC1Ku5ayckl1cs0tZZdjNaS1/TooNk=;
        b=q562GRD63FsyJuxvypt84+mBn/QAzC3k9MtUJOQei60E4EpF9r6N6VCEoHD3LPX0If
         C+CzfjhUiE1BgcPNgNjyL1ydKZb3ZLeCJvSbNL7ix0WwAkxrtqay/APFZbfdvdx1YZSO
         +zaYzgA1xBgH02A6sJ7ViYDpBVAaKzg5FydjqIrFHmEx440VztMPcd3mefmuX6nfTBg4
         oR3TRWTClOMJPlUtu7H/6XzC/3KYxkrC7c44Ho65jjV35fBvKIFYRn1DBQH2ASWB2FTR
         kFJIPW2IDqng/2I/g7JXiHDjUIJh96GxoU/ZG1Fei4yv93CbDXtmnB8YcEm+xRx/aqJV
         vrbQ==
X-Gm-Message-State: AOJu0YypE9gig0Ky1z+EeNIDPEDDjtBavTjiw83dOkCc1cCc0B9l4VYu
	IKGI51/oxyzGLYdmKFyZbqduA/udEk6qaOr0jcmUbHU1PR0Hq3Zy3+dc4XpG/egCu6hdja4p1FX
	nMprIgg==
X-Received: from pfaq9.prod.google.com ([2002:a05:6a00:a889:b0:84b:9a60:c9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b02:b0:847:8acd:747c
 with SMTP id d2e1a72fcca58-84f2e022980mr1250865b3a.13.1785876051512; Tue, 04
 Aug 2026 13:40:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 13:40:47 -0700
In-Reply-To: <20260804204048.3401810-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804204048.3401810-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804204048.3401810-3-seanjc@google.com>
Subject: [PATCH v2 2/2] KVM: selftests: Create one VM with many vCPUs for each
 major PMU counters test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To reduce the runtime of the PMU counters test by an order of magnitude,
create one VM per category of test (arch events, GP PMCs, fixed PMCs),
with N vCPUs per VM, where 'N' is the number of testscases to run per
category.  The vast majority of the test's runtime is spent creating VMs,
because while creating a VM only takes a few milliseconds, the total time
adds up when creating hundreds of VMs.  The only reason the test creates
so many VMs is because KVM disallows changing the virtual PMU model after
a vCPU runs, so rather than create an entirely new VM just to get a "fresh"
vCPUs, simply use a different vCPU.

On an Emerald Rapids host, this reduces the runtime from 75+ seconds to
less than 6 seconds.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86/pmu_counters_test.c     | 212 ++++++++++--------
 1 file changed, 122 insertions(+), 90 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
index 8abf17cc9469..c7c566220381 100644
--- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
@@ -87,14 +87,18 @@ static struct kvm_intel_pmu_event intel_event_to_feature(u8 idx)
 	return __intel_event_to_feature[idx];
 }
 
-static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
-						  void *guest_code,
-						  u8 pmu_version,
-						  u64 perf_capabilities)
+static struct kvm_vm *pmu_vm_create_with_vcpus(u32 nr_vcpus, void *guest_code,
+					       u8 pmu_version,
+					       u64 perf_capabilities,
+					       struct kvm_vcpu **__vcpus[])
 {
+	struct kvm_vcpu **vcpus = calloc(nr_vcpus, sizeof(struct kvm_vcpu));
 	struct kvm_vm *vm;
+	int i;
 
-	vm = vm_create_with_one_vcpu(vcpu, guest_code);
+	*__vcpus = vcpus;
+
+	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
 	sync_global_to_guest(vm, kvm_pmu_version);
 	sync_global_to_guest(vm, hardware_pmu_arch_events);
 
@@ -102,13 +106,22 @@ static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
 	 * Set PERF_CAPABILITIES before PMU version as KVM disallows enabling
 	 * features via PERF_CAPABILITIES if the guest doesn't have a vPMU.
 	 */
-	if (kvm_has_perf_caps)
-		vcpu_set_msr(*vcpu, MSR_IA32_PERF_CAPABILITIES, perf_capabilities);
+	for (i = 0; i < nr_vcpus; i++) {
+		if (kvm_has_perf_caps)
+			vcpu_set_msr(vcpus[i], MSR_IA32_PERF_CAPABILITIES, perf_capabilities);
+
+		vcpu_set_cpuid_property(vcpus[i], X86_PROPERTY_PMU_VERSION, pmu_version);
+	}
 
-	vcpu_set_cpuid_property(*vcpu, X86_PROPERTY_PMU_VERSION, pmu_version);
 	return vm;
 }
 
+static void pmu_vm_free(struct kvm_vm *vm, struct kvm_vcpu **vcpus)
+{
+	kvm_vm_free(vm);
+	free(vcpus);
+}
+
 static void run_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct ucall uc;
@@ -326,30 +339,72 @@ static void guest_test_arch_events(void)
 	GUEST_DONE();
 }
 
-static void test_arch_events(u8 pmu_version, u64 perf_capabilities,
-			     u8 length, u32 unavailable_mask)
+static void __test_arch_events(struct kvm_vcpu *vcpu, u64 perf_capabilities,
+			       u8 length, u32 unavailable_mask)
 {
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm;
-
-	/* Testing arch events requires a vPMU (there are no negative tests). */
-	if (!pmu_version)
-		return;
-
 	unavailable_mask &= GENMASK(X86_PROPERTY_PMU_EVENTS_MASK.hi_bit,
 				    X86_PROPERTY_PMU_EVENTS_MASK.lo_bit);
 
-	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_arch_events,
-					 pmu_version, perf_capabilities);
-
 	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH,
 				length);
 	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_EVENTS_MASK,
 				unavailable_mask);
 
 	run_vcpu(vcpu);
+}
 
-	kvm_vm_free(vm);
+static void test_arch_events(u8 pmu_version, u64 perf_capabilities)
+{
+	struct kvm_vcpu **vcpus;
+	struct kvm_vm *vm;
+	int i = 0;
+	u32 k;
+	u8 j;
+
+	/*
+	 * To keep the total runtime reasonable, test only a handful of select,
+	 * semi-arbitrary values for the mask of unavailable PMU events.  Test
+	 * 0 (all events available) and all ones (no events available) as well
+	 * as alternating bit sequencues, e.g. to detect if KVM is checking the
+	 * wrong bit(s).
+	 */
+	const u32 unavailable_masks[] = {
+		0x0,
+		0xffffffffu,
+		0xaaaaaaaau,
+		0x55555555u,
+		0xf0f0f0f0u,
+		0x0f0f0f0fu,
+		0xa0a0a0a0u,
+		0x0a0a0a0au,
+		0x50505050u,
+		0x05050505u,
+	};
+
+	pr_info("Testing arch events, PMU version %u, perf_caps = %lx\n",
+		pmu_version, perf_capabilities);
+
+	/* Testing arch events requires a vPMU (there are no negative tests). */
+	if (!pmu_version)
+		return;
+
+	vm = pmu_vm_create_with_vcpus((NR_INTEL_ARCH_EVENTS + 2) * ARRAY_SIZE(unavailable_masks),
+				      guest_test_arch_events, pmu_version,
+				      perf_capabilities, &vcpus);
+
+	/*
+	 * Test single bits for all PMU version and lengths up the number of
+	 * events +1 (to verify KVM doesn't do weird things if the guest length
+	 * is greater than the host length).  Explicitly test a mask of '0' and
+	 * all ones i.e. all events being available and unavailable.
+	 */
+	for (j = 0; j <= NR_INTEL_ARCH_EVENTS + 1; j++) {
+		for (k = 1; k < ARRAY_SIZE(unavailable_masks); k++)
+			__test_arch_events(vcpus[i++], perf_capabilities, j,
+					   unavailable_masks[k]);
+	}
+
+	pmu_vm_free(vm, vcpus);
 }
 
 /*
@@ -493,21 +548,27 @@ static void guest_test_gp_counters(void)
 	GUEST_DONE();
 }
 
-static void test_gp_counters(u8 pmu_version, u64 perf_capabilities,
-			     u8 nr_gp_counters)
+static void test_gp_counters(u8 pmu_version, u64 perf_capabilities)
 {
-	struct kvm_vcpu *vcpu;
+	u8 nr_gp_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
+	struct kvm_vcpu **vcpus;
 	struct kvm_vm *vm;
+	u8 j;
 
-	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_gp_counters,
-					 pmu_version, perf_capabilities);
+	pr_info("Testing %u GP counters, PMU version %u, perf_caps = %lx\n",
+		nr_gp_counters, pmu_version, perf_capabilities);
 
-	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_NR_GP_COUNTERS,
-				nr_gp_counters);
+	vm = pmu_vm_create_with_vcpus(nr_gp_counters + 1, guest_test_gp_counters,
+				      pmu_version, perf_capabilities, &vcpus);
 
-	run_vcpu(vcpu);
+	for (j = 0; j <= nr_gp_counters; j++) {
+		vcpu_set_cpuid_property(vcpus[j], X86_PROPERTY_PMU_NR_GP_COUNTERS,
+					nr_gp_counters);
 
-	kvm_vm_free(vm);
+		run_vcpu(vcpus[j]);
+	}
+
+	pmu_vm_free(vm, vcpus);
 }
 
 static void guest_test_fixed_counters(void)
@@ -559,59 +620,53 @@ static void guest_test_fixed_counters(void)
 	GUEST_DONE();
 }
 
-static void test_fixed_counters(u8 pmu_version, u64 perf_capabilities,
-				u8 nr_fixed_counters, u32 supported_bitmask)
+static void __test_fixed_counters(struct kvm_vcpu *vcpu, u8 nr_fixed_counters,
+				  u32 supported_bitmask)
 {
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm;
-
-	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_fixed_counters,
-					 pmu_version, perf_capabilities);
-
 	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK,
 				supported_bitmask);
 	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_NR_FIXED_COUNTERS,
 				nr_fixed_counters);
 
 	run_vcpu(vcpu);
-
-	kvm_vm_free(vm);
 }
 
-static void test_intel_counters(void)
+static void test_fixed_counters(u8 pmu_version, u64 perf_capabilities)
 {
 	u8 nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
-	u8 nr_gp_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
+	struct kvm_vcpu **vcpus;
+	struct kvm_vm *vm;
+	int i = 0;
+	u32 k;
+	u8 j;
+
+	pr_info("Testing %u fixed counters, PMU version %u, perf_caps = %lx\n",
+		nr_fixed_counters, pmu_version, perf_capabilities);
+
+
+	vm = pmu_vm_create_with_vcpus((nr_fixed_counters + 1) * BIT(nr_fixed_counters),
+				      guest_test_fixed_counters,
+				      pmu_version, perf_capabilities, &vcpus);
+
+	for (j = 0; j <= nr_fixed_counters; j++) {
+		for (k = 0; k <= (BIT(nr_fixed_counters) - 1); k++)
+			__test_fixed_counters(vcpus[i++], j, k);
+	}
+
+	pmu_vm_free(vm, vcpus);
+}
+
+static void test_intel_counters(void)
+{
 	u8 pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
 	unsigned int i;
-	u8 v, j;
-	u32 k;
+	u8 v;
 
 	const u64 perf_caps[] = {
 		0,
 		PMU_CAP_FW_WRITES,
 	};
 
-	/*
-	 * To keep the total runtime reasonable, test only a handful of select,
-	 * semi-arbitrary values for the mask of unavailable PMU events.  Test
-	 * 0 (all events available) and all ones (no events available) as well
-	 * as alternating bit sequencues, e.g. to detect if KVM is checking the
-	 * wrong bit(s).
-	 */
-	const u32 unavailable_masks[] = {
-		0x0,
-		0xffffffffu,
-		0xaaaaaaaau,
-		0x55555555u,
-		0xf0f0f0f0u,
-		0x0f0f0f0fu,
-		0xa0a0a0a0u,
-		0x0a0a0a0au,
-		0x50505050u,
-		0x05050505u,
-	};
-
 	/*
 	 * Test up to PMU v5, which is the current maximum version defined by
 	 * Intel, i.e. is the last version that is guaranteed to be backwards
@@ -647,32 +702,9 @@ static void test_intel_counters(void)
 			if (!kvm_has_perf_caps && perf_caps[i])
 				continue;
 
-			pr_info("Testing arch events, PMU version %u, perf_caps = %lx\n",
-				v, perf_caps[i]);
-
-			/*
-			 * Test single bits for all PMU version and lengths up
-			 * the number of events +1 (to verify KVM doesn't do
-			 * weird things if the guest length is greater than the
-			 * host length).  Explicitly test a mask of '0' and all
-			 * ones i.e. all events being available and unavailable.
-			 */
-			for (j = 0; j <= NR_INTEL_ARCH_EVENTS + 1; j++) {
-				for (k = 1; k < ARRAY_SIZE(unavailable_masks); k++)
-					test_arch_events(v, perf_caps[i], j, unavailable_masks[k]);
-			}
-
-			pr_info("Testing GP counters, PMU version %u, perf_caps = %lx\n",
-				v, perf_caps[i]);
-			for (j = 0; j <= nr_gp_counters; j++)
-				test_gp_counters(v, perf_caps[i], j);
-
-			pr_info("Testing fixed counters, PMU version %u, perf_caps = %lx\n",
-				v, perf_caps[i]);
-			for (j = 0; j <= nr_fixed_counters; j++) {
-				for (k = 0; k <= (BIT(nr_fixed_counters) - 1); k++)
-					test_fixed_counters(v, perf_caps[i], j, k);
-			}
+			test_arch_events(v, perf_caps[i]);
+			test_gp_counters(v, perf_caps[i]);
+			test_fixed_counters(v, perf_caps[i]);
 		}
 	}
 }
-- 
2.55.0.571.g244d577d93-goog

