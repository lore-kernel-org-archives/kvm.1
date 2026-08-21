Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5277D3E3C7A;
	Fri, 21 Aug 2026 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351466; cv=none; b=MP6GMBvA6EcqqbePiTC/ESHiO+BGUy3j7JkkPzteePgTfpswEl7pLDBsEvcxQpTH4GUfOMuW8I0X6Oac0Xkkk8un46Io1y6Hnvfb+O84NkK00oEefBA74FUFMTmn5+hSfBoFHqinOIocc/xwCl/AiNJEn4mJtSg4ThyR+pMWjpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351466; c=relaxed/simple;
	bh=T5e0WUC7wLVP7glG00IOVfxeVgZVzScvLjhA2yi0tvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u58bghdx1nSNVOcNhxQqFRYzAR/X9nK64wtysXTcD4fb2ct2scxKFpdYldkrHsq1dd8iuRQ4I3sLW7bq0PuNe5ea3CLziO09tR8FSJpUJper95ek9y37/EbqamdSAwi5K7QqJOeItG7lxBCRH/4TwE4ElKppOfhS5d8tdwEPcPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbsPVbs+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbsPVbs+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351464; x=1818887464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T5e0WUC7wLVP7glG00IOVfxeVgZVzScvLjhA2yi0tvU=;
  b=VbsPVbs+b04o1dl3mvtbDf384G2pZSYqSPe727BS/XHhyLu8egt6KnrW
   qw6uyvshkT0XLuFmuMMrSOsfRyx3r2jpXszJ4FPEbCgvBudVqV/NqhHxt
   5PP4WaNbZrX+XocSG+ArCSB6qgXrKgof03krovsHuqeAGEFrgJBkKL18+
   NVrnt2uQjdE+DnNEqW4puxESmrbzabl96Id2h0LxsZ6sDO30xIzbq4xi5
   CabDZ8JMjDO1AMImB1cYvBx4MZJtQAnLm9CaOCxlnVwYAu3ruMtNMjdG0
   ZOMIafjZzWDziQ5FcMx1QoAWHKvIBSyWub1yekI1aGU9O+K/snUR8adZ8
   Q==;
X-CSE-ConnectionGUID: 70iEQQOVRhyJLiAX3kIIFg==
X-CSE-MsgGUID: FtSd4e1AT+GY9s3+XSuTpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032630"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032630"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:50 -0700
X-CSE-ConnectionGUID: SQtF2LA0T465NIvTy42+bQ==
X-CSE-MsgGUID: UOBHyJrCScOGvnFv+er4Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679783"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:50 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Jim Mattson <jmattson@google.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH 14/23] KVM: x86/pmu, perf/x86: Update effective PMU partition mask
Date: Fri, 21 Aug 2026 15:19:53 -0700
Message-ID: <20260821222002.54907-15-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821222002.54907-1-zide.chen@intel.com>
References: <20260821222002.54907-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The static system-wide mask x86_pmu.partition_mask defines the global
maximum guest capability, while a guest may have its own mask, which
is a subset of x86_pmu.partition_mask.

The per-guest mask, which on Intel is backed by the PERFMON_MASK VMCS
field, is the effective mask while a vCPU is loaded. Whenever it
changes -- e.g. during kvm_arch_vcpu_{load,put}() -- perf/x86 needs to
be told so it can keep its own per-CPU copy in sync.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/core.c            |  8 ++++++++
 arch/x86/include/asm/perf_event.h |  1 +
 arch/x86/kvm/pmu.c                | 13 +++++++++++++
 arch/x86/kvm/pmu.h                |  3 +++
 arch/x86/kvm/x86.c                |  4 ++++
 5 files changed, 29 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 282170f7c1e1..f485f927967a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1883,6 +1883,14 @@ void perf_put_guest_lvtpc(void)
 		apic_write(APIC_LVTPC, APIC_DM_NMI);
 }
 EXPORT_SYMBOL_FOR_KVM(perf_put_guest_lvtpc);
+
+void perf_set_current_partition_mask(u64 mask)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	cpuc->partition_mask = mask & READ_ONCE(x86_pmu.partition_mask);
+}
+EXPORT_SYMBOL_FOR_KVM(perf_set_current_partition_mask);
 #endif /* CONFIG_PERF_GUEST_MEDIATED_PMU */
 
 static int
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index aaaa34062f8c..5be4f6a93b14 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -794,6 +794,7 @@ static inline void perf_check_microcode(void) { }
 extern void perf_pmu_partition_preload(void);
 extern void perf_load_guest_lvtpc(u32 guest_lvtpc);
 extern void perf_put_guest_lvtpc(void);
+extern void perf_set_current_partition_mask(u64 mask);
 #endif
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index f944a15160cb..c447f32c1cb1 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -46,6 +46,19 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(enable_mediated_pmu);
 u64 __read_mostly perfmon_mask;
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(perfmon_mask);
 
+void kvm_pmu_vcpu_load(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	perf_set_current_partition_mask(kvm_vcpu_has_perfmon_mask(vcpu) ?
+					pmu->perfmon_mask : 0);
+}
+
+void kvm_pmu_vcpu_put(struct kvm_vcpu *vcpu)
+{
+	perf_set_current_partition_mask(0);
+}
+
 struct kvm_x86_pmu_event_filter {
 	__u32 action;
 	__u32 nevents;
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 057e3258e473..c5feeb60bcf6 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -70,6 +70,9 @@ void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops);
 
 void kvm_handle_guest_mediated_pmi(void);
 
+void kvm_pmu_vcpu_load(struct kvm_vcpu *vcpu);
+void kvm_pmu_vcpu_put(struct kvm_vcpu *vcpu);
+
 static inline bool kvm_pmu_has_perf_global_ctrl(struct kvm_pmu *pmu)
 {
 	/*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 26a3b7a267b5..07e3fe5b53f8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2538,6 +2538,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	kvm_request_l1tf_flush_l1d();
 
+	kvm_pmu_vcpu_load(vcpu);
+
 	if (vcpu->scheduled_out && pmu->version && pmu->event_count) {
 		pmu->need_cleanup = true;
 		kvm_make_request(KVM_REQ_PMU, vcpu);
@@ -2686,6 +2688,8 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 
 	kvm_x86_call(vcpu_put)(vcpu);
 	vcpu->arch.last_host_tsc = rdtsc();
+
+	kvm_pmu_vcpu_put(vcpu);
 }
 
 static int kvm_vcpu_ioctl_get_lapic(struct kvm_vcpu *vcpu,
-- 
2.55.0

