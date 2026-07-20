Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C028396567;
	Mon, 20 Jul 2026 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575383; cv=none; b=SN3JDxLhvGaBbdKIKUuzrZTtOmy0lIbkFN/V0F8a+eWk2EQ7TN7VaK5IJf6Kk8Ib7jz3iMSiOD2RPKkOOgFtz/9einz+ID6F95RvlFzJyVlAJe1P3UlALhZYTVLM/qlogEmodPAslPu57a3woEBub5C9JkcEoutVQl69sKii9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575383; c=relaxed/simple;
	bh=ISTZAMCU55OUei+IeaO6EDtRkxGddAjMtky941z4qIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZorDKy09gbiqJQHhxLvGBTJNegMK+8Bold7qwVjhBeJT/7qHZ4AZU+2s0w4A4l4Ati5wotlPC2niBnA7pzlm8lcOHJ98Im66HS+yJN1BcCcqHChNTus95B+dW1kLor9445KGefTqtcUAdsbAtMVIQAoX8HHcac8R/JHUycAyl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=EJifepmZ; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="EJifepmZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1784575382; x=1816111382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8fiV6Nmv6Y1yzw2FmTObOdyISUYo0Stlj4ukCozKF/8=;
  b=EJifepmZHxhCtQb6iSERP22bNFeT2iwbEC+Fu5DQGlfUiMcYIpoS4E6j
   IhIZSZUOTQnVL/e3oEn77u6hMcNloerbR67UxD9Bcti4mdVoln/05L0Qo
   MJ+I5hUwUY/Y8Qn0arM6vhhLYEuhDfibQyugZrUcaOqMC7stQfywa9JyB
   J5f/W+Sm8QDxXX3xFRjtGQNnYC65JIABNZYjc30zsWTzumIX/m5Q9CasJ
   Ee8yvKs8rIrLIKM+DyC5PhXZSVkHgNAnpCeoedBbNcEW9sEZKqAv/G6Fc
   vyYDtbGFZNnCsv6Aladtv/FFqabIBOxwwuIBE8qDqxbSlE/VBAN0GlHiu
   Q==;
X-CSE-ConnectionGUID: AJeSn9kkRoCYXy5ibXvBfA==
X-CSE-MsgGUID: ohPprauATByjZSib7WxVlA==
X-IronPort-AV: E=Sophos;i="6.25,175,1779148800"; 
   d="scan'208";a="24014699"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 19:22:59 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:16952]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.250:2525] with esmtp (Farcaster)
 id 30ec1870-a85d-44f4-83fd-d2177ef9adfc; Mon, 20 Jul 2026 19:22:58 +0000 (UTC)
X-Farcaster-Flow-ID: 30ec1870-a85d-44f4-83fd-d2177ef9adfc
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Mon, 20 Jul 2026 19:22:58 +0000
Received: from dev-dsk-absandze-1c-663c31a8.eu-west-1.amazon.com
 (172.19.91.26) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Mon, 20 Jul 2026
 19:22:57 +0000
From: Luka Absandze <absandze@amazon.de>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, <kvm@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, "Alexander
 Graf" <graf@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>, Luka Absandze
	<absandze@amazon.de>
Subject: [RFC PATCH 1/2] KVM: x86/pmu: Add CAP to disable SW accounting of emulated instructions
Date: Mon, 20 Jul 2026 19:22:20 +0000
Message-ID: <20260720192221.72912-2-absandze@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260720192221.72912-1-absandze@amazon.de>
References: <20260720192221.72912-1-absandze@amazon.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On a host with an emulated vPMU (guest PMU MSR accesses trap and each
guest counter is backed by a host perf_event), the per-emulated-
instruction PMU accounting added by commit 9cd803d496e7 ("KVM: x86: Update
vPMCs when retiring instructions") is catastrophically expensive.

For every instruction KVM emulates, kvm_skip_emulated_instruction(),
the emulator writeback path, and nested VMLAUNCH/VMRESUME call into
the retired-instruction accounting for PERF_COUNT_HW_INSTRUCTIONS and
PERF_COUNT_HW_BRANCH_INSTRUCTIONS. If the guest has a counter
programmed for retired instructions (0xc0) or retired branches (0xc2)
-- e.g. any guest running a profiler with an instructions-retired
event -- this walks the counters, software-increments the matching
one, and requests a full reprogram (KVM_REQ_PMU). The reprogram is
drained on the vCPU's next VM-entry, where reprogram_counter() runs
the full pmc_pause_counter() + perf_event_period() + perf_event_
enable() sequence: ctx->mutex, a ctx_resched() of the PMU context,
and a burst of serialized PMU-MSR writes.

Because the batched reprogram is serviced on the next VM-entry
regardless of which exit preceded it, ordinary exits -- notably the
guest's 1kHz timer tick -- absorb the cost, inflating timer
interrupts into the hundreds of microseconds. With certain workloads
this can escalate to a CSD lockup in the guest.

Add KVM_CAP_X86_DISABLE_PMU_SW_ACCOUNTING, a VM-scoped capability that
takes a bitmask of PERF_COUNT_HW_* event IDs and makes KVM skip the
software accounting of KVM-emulated instructions for those events.
KVM_CHECK_EXTENSION returns the set of events that can be disabled
(PERF_COUNT_HW_INSTRUCTIONS and PERF_COUNT_HW_BRANCH_INSTRUCTIONS --
the only events the retired-instruction path ever triggers).

The only functional change for an opted-in VM is reduced accuracy: a
guest counting instructions-retired or branches-retired undercounts by
the instructions KVM emulates in host context, i.e. the behavior that
predates the accounting cited above. Hardware-executed guest
instructions continue to be counted by the backing perf_event, and its
overflow/PMI path is unchanged. Default behavior (mask 0) is unchanged.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Luka Absandze <absandze@amazon.de>
---
 arch/x86/include/asm/kvm_host.h |  7 +++++++
 arch/x86/kvm/pmu.c              | 21 +++++++++++++++++++++
 arch/x86/kvm/pmu.h              |  9 +++++++++
 arch/x86/kvm/x86.c              | 15 +++++++++++++++
 include/uapi/linux/kvm.h        |  1 +
 5 files changed, 53 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 5f6c1ce9673b..522f66c44e6a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1560,6 +1560,13 @@ struct kvm_arch {
 	bool enable_pmu;
 	bool created_mediated_pmu;
 
+	/*
+	 * Bitmask of PERF_COUNT_HW_* event IDs for which software accounting
+	 * of KVM-emulated instructions is disabled (KVM_CAP_X86_DISABLE_PMU_
+	 * SW_ACCOUNTING). See kvm_pmu_trigger_event().
+	 */
+	u64 pmu_disable_sw_accounting;
+
 	u32 notify_window;
 	u32 notify_vmexit_flags;
 	/*
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index dd1c57593f48..fb3f2df068dc 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1145,14 +1145,35 @@ static void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu,
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 }
 
+/*
+ * Whether software accounting of KVM-emulated instructions for @perf_hw_id is
+ * disabled via KVM_CAP_X86_DISABLE_PMU_SW_ACCOUNTING. The capability only
+ * targets the emulated (perf-based) vPMU, where the accounting drives an
+ * expensive counter reprogram; a mediated vPMU increments pmc->counter
+ * directly (and may raise a PMI on overflow), so it is never skipped.
+ */
+static bool kvm_pmu_skip_sw_accounting(struct kvm_vcpu *vcpu, u64 perf_hw_id)
+{
+	if (kvm_vcpu_has_mediated_pmu(vcpu))
+		return false;
+
+	return vcpu->kvm->arch.pmu_disable_sw_accounting & BIT_ULL(perf_hw_id);
+}
+
 void kvm_pmu_instruction_retired(struct kvm_vcpu *vcpu)
 {
+	if (kvm_pmu_skip_sw_accounting(vcpu, PERF_COUNT_HW_INSTRUCTIONS))
+		return;
+
 	kvm_pmu_trigger_event(vcpu, vcpu_to_pmu(vcpu)->pmc_counting_instructions);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_pmu_instruction_retired);
 
 void kvm_pmu_branch_retired(struct kvm_vcpu *vcpu)
 {
+	if (kvm_pmu_skip_sw_accounting(vcpu, PERF_COUNT_HW_BRANCH_INSTRUCTIONS))
+		return;
+
 	kvm_pmu_trigger_event(vcpu, vcpu_to_pmu(vcpu)->pmc_counting_branches);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_pmu_branch_retired);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index a5821d7c87f9..e34b9e814355 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -23,6 +23,15 @@
 
 #define KVM_FIXED_PMC_BASE_IDX INTEL_PMC_IDX_FIXED
 
+/*
+ * Events for which KVM_CAP_X86_DISABLE_PMU_SW_ACCOUNTING can disable software
+ * accounting of emulated instructions. These are the only events KVM ever
+ * passes to kvm_pmu_trigger_event() (from the retired-instruction path).
+ */
+#define KVM_PMU_SW_ACCOUNTING_VALID_MASK			\
+	(BIT_ULL(PERF_COUNT_HW_INSTRUCTIONS) |			\
+	 BIT_ULL(PERF_COUNT_HW_BRANCH_INSTRUCTIONS))
+
 struct kvm_pmu_ops {
 	struct kvm_pmc *(*rdpmc_ecx_to_pmc)(struct kvm_vcpu *vcpu,
 		unsigned int idx, u64 *mask);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index afcac1042947..cc8a36f28aea 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4964,6 +4964,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_DISABLE_QUIRKS2:
 		r = kvm_caps.supported_quirks;
 		break;
+	case KVM_CAP_X86_DISABLE_PMU_SW_ACCOUNTING:
+		r = KVM_PMU_SW_ACCOUNTING_VALID_MASK;
+		break;
 	case KVM_CAP_X86_NOTIFY_VMEXIT:
 		r = kvm_caps.has_notify_vmexit;
 		break;
@@ -6730,6 +6733,18 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		return -EINVAL;
 
 	switch (cap->cap) {
+	case KVM_CAP_X86_DISABLE_PMU_SW_ACCOUNTING:
+		r = -EINVAL;
+		if (cap->args[0] & ~KVM_PMU_SW_ACCOUNTING_VALID_MASK)
+			break;
+
+		mutex_lock(&kvm->lock);
+		if (!kvm->created_vcpus) {
+			kvm->arch.pmu_disable_sw_accounting = cap->args[0];
+			r = 0;
+		}
+		mutex_unlock(&kvm->lock);
+		break;
 	case KVM_CAP_DISABLE_QUIRKS2:
 		r = -EINVAL;
 		if (cap->args[0] & ~kvm_caps.supported_quirks)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 419011097fa8..186054245b80 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -997,6 +997,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
+#define KVM_CAP_X86_DISABLE_PMU_SW_ACCOUNTING 250
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.47.3

