Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9111536C59E
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782425106; cv=none; b=bUXb2b00eUP7rJL425Qcx0Gq33UNzlz90HZRCtOfZgDsWp/KXgecIqN3IG5h994dtx3q6pMu/LMTvpsfZw4iuTGaExgVxoNikKJYrL63y8guyzfpTcSxhJiKIP+kbuxEfNjfR4RstYg+lrOU5RxCetnEXCe7FdbqX2oZa4N+2P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782425106; c=relaxed/simple;
	bh=YaAsyBxs6SNJBM2n7iCrP4/1qE8wy9B8RS1IYuYyXT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tdi6aKCN2B87/XDUbx7zE4qyT2e83Azr/ibJxLAi2FJQuinevgcZQPIJCm34CDngNL2iaIlqV4LH6YmWL1YKrB0ckgzbhUrOMuPlgwQlkbtPP+Lr87BDK/p54iIiaOPw+Fogj2gAWE8TE0F2vlA+nrh6ObWRVVGxlIdDPmhg/d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5jXSAZK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5jXSAZK"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c6a9bbcc53so2916135ad.2
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782425104; x=1783029904; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=skRaqSuRB/4SGbrF8G+Bq8UtIp7H2CAA2i7IdxeGuuA=;
        b=P5jXSAZKTEuGQB5Baj+XaN89pjhdeaLkN7nLtRsjnRW/RUKoylZ7fr4eEtYSdAt9Ef
         z2r1B9FOIsxYFvv7oRXEP8u9hYpoWhyPpO9bMWC4odqlaZhfwySxzgcQBk4EvVgbRWR/
         mjPDYCbBSs4kh6WLb/4o7JUOcQdt/tw8i8kXUfN92mLWEK6CRmBXKHbS2UNQhc4BPach
         fJSBHQIoDywDyn67Cxny28DMiHKrKOpHguTIjQk7YkwmlqGjbe7n1eyB5Cp4qxpUy1Ah
         y9dXtL31KXPMSSyi/8+OHmgUAYja6aef3G/lgyrB0IL8DNm+N7PSxTA3LoKHsl+SXutp
         LQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782425104; x=1783029904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skRaqSuRB/4SGbrF8G+Bq8UtIp7H2CAA2i7IdxeGuuA=;
        b=jARxi9LNnbrH8Wtls6bvO9CWfbKSYjdvd5K1IrMGK40WXK5G7odfmWYwRG2kcPtuMJ
         DlNXC4omSp9eBesURx5iqpbhtYFzSxQ8ULTBbJnnhiNJ7BQBpsCQX9TUAJ2w/g7up2gx
         rYn5JwP9tqrG/MH136X6nB5TRY5wJtwhzz7E48p6V1pLO9BwVSFO1QqGMxG6baVRDa7t
         yPsM0DQvmjeDPxzGOLofon3XHzx9FUJhZWENiAn1N8UBV0Z82ZAlhnHkjFocWg9E0IgI
         cN+QgEz9O7nTFtRCC28LYQ0UvjyHe+Df1UaYwAhcD0uk4+YpnuC5Smb65m1hpxNlCqYk
         mylw==
X-Gm-Message-State: AOJu0YzzvSjObN2k6/kodochmxPLAIzU4ArDu5nTtigDCc7foextm9e6
	S7Wv81YfvEpjznCvsZQK/YFjbqT6cd3hQIoKDWUMf2ZR2Fg1CVEwXGTSjH3k/tfaakYv9RF///P
	r3cesPg==
X-Received: from pleg12.prod.google.com ([2002:a17:902:e38c:b0:2c7:edca:a181])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8b:b0:2c6:f350:e89e
 with SMTP id d9443c01a7336-2c7fca1543dmr40428915ad.20.1782425103605; Thu, 25
 Jun 2026 15:05:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:04:50 -0700
In-Reply-To: <20260625220450.3354415-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625220450.3354415-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625220450.3354415-10-seanjc@google.com>
Subject: [PATCH 9/9] KVM: x86: Move "struct kvm_vcpu_hv" and all children from
 kvm_host.h => hyperv.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move "struct kvm_vcpu_hv" and all of its child structures to hyperv.h,
guarded by CONFIG_KVM_HYPERV=y, as "struct kvm_vcpu_arch" holds a pointer
to the structure, i.e. only needs the structure to be declared, not fully
defined.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 91 +--------------------------------
 arch/x86/kvm/hyperv.h           | 90 ++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 89 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 90efc3c90b41..fdb8953aeeb1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -648,95 +648,6 @@ struct kvm_mtrr {
 	u64 deftype;
 };
 
-/* Hyper-V SynIC timer */
-struct kvm_vcpu_hv_stimer {
-	struct hrtimer timer;
-	int index;
-	union hv_stimer_config config;
-	u64 count;
-	u64 exp_time;
-	struct hv_message msg;
-	bool msg_pending;
-};
-
-/* Hyper-V synthetic interrupt controller (SynIC)*/
-struct kvm_vcpu_hv_synic {
-	u64 version;
-	u64 control;
-	u64 msg_page;
-	u64 evt_page;
-	atomic64_t sint[HV_SYNIC_SINT_COUNT];
-	atomic_t sint_to_gsi[HV_SYNIC_SINT_COUNT];
-	DECLARE_BITMAP(auto_eoi_bitmap, 256);
-	DECLARE_BITMAP(vec_bitmap, 256);
-	bool active;
-	bool dont_zero_synic_pages;
-};
-
-/* The maximum number of entries on the TLB flush fifo. */
-#define KVM_HV_TLB_FLUSH_FIFO_SIZE (16)
-/*
- * Note: the following 'magic' entry is made up by KVM to avoid putting
- * anything besides GVA on the TLB flush fifo. It is theoretically possible
- * to observe a request to flush 4095 PFNs starting from 0xfffffffffffff000
- * which will look identical. KVM's action to 'flush everything' instead of
- * flushing these particular addresses is, however, fully legitimate as
- * flushing more than requested is always OK.
- */
-#define KVM_HV_TLB_FLUSHALL_ENTRY  ((u64)-1)
-
-enum hv_tlb_flush_fifos {
-	HV_L1_TLB_FLUSH_FIFO,
-	HV_L2_TLB_FLUSH_FIFO,
-	HV_NR_TLB_FLUSH_FIFOS,
-};
-
-struct kvm_vcpu_hv_tlb_flush_fifo {
-	spinlock_t write_lock;
-	DECLARE_KFIFO(entries, u64, KVM_HV_TLB_FLUSH_FIFO_SIZE);
-};
-
-/* Hyper-V per vcpu emulation context */
-struct kvm_vcpu_hv {
-	struct kvm_vcpu *vcpu;
-	u32 vp_index;
-	u64 hv_vapic;
-	s64 runtime_offset;
-	struct kvm_vcpu_hv_synic synic;
-	struct kvm_hyperv_exit exit;
-	struct kvm_vcpu_hv_stimer stimer[HV_SYNIC_STIMER_COUNT];
-	DECLARE_BITMAP(stimer_pending_bitmap, HV_SYNIC_STIMER_COUNT);
-	bool enforce_cpuid;
-	struct {
-		u32 features_eax; /* HYPERV_CPUID_FEATURES.EAX */
-		u32 features_ebx; /* HYPERV_CPUID_FEATURES.EBX */
-		u32 features_edx; /* HYPERV_CPUID_FEATURES.EDX */
-		u32 enlightenments_eax; /* HYPERV_CPUID_ENLIGHTMENT_INFO.EAX */
-		u32 enlightenments_ebx; /* HYPERV_CPUID_ENLIGHTMENT_INFO.EBX */
-		u32 syndbg_cap_eax; /* HYPERV_CPUID_SYNDBG_PLATFORM_CAPABILITIES.EAX */
-		u32 nested_eax; /* HYPERV_CPUID_NESTED_FEATURES.EAX */
-		u32 nested_ebx; /* HYPERV_CPUID_NESTED_FEATURES.EBX */
-	} cpuid_cache;
-
-	struct kvm_vcpu_hv_tlb_flush_fifo tlb_flush_fifo[HV_NR_TLB_FLUSH_FIFOS];
-
-	/*
-	 * Preallocated buffers for handling hypercalls that pass sparse vCPU
-	 * sets (for high vCPU counts, they're too large to comfortably fit on
-	 * the stack).
-	 */
-	u64 sparse_banks[HV_MAX_SPARSE_VCPU_BANKS];
-	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
-
-	struct hv_vp_assist_page vp_assist_page;
-
-	struct {
-		u64 pa_page_gpa;
-		u64 vm_id;
-		u32 vp_id;
-	} nested;
-};
-
 struct kvm_hypervisor_cpuid {
 	u32 base;
 	u32 limit;
@@ -767,6 +678,8 @@ struct kvm_vcpu_xen {
 };
 #endif
 
+struct kvm_vcpu_hv;
+
 struct kvm_queued_exception {
 	bool pending;
 	bool injected;
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 1c8f7aaab063..6258ed277a7b 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -27,6 +27,96 @@
 
 #ifdef CONFIG_KVM_HYPERV
 
+
+/* Hyper-V SynIC timer */
+struct kvm_vcpu_hv_stimer {
+	struct hrtimer timer;
+	int index;
+	union hv_stimer_config config;
+	u64 count;
+	u64 exp_time;
+	struct hv_message msg;
+	bool msg_pending;
+};
+
+/* Hyper-V synthetic interrupt controller (SynIC)*/
+struct kvm_vcpu_hv_synic {
+	u64 version;
+	u64 control;
+	u64 msg_page;
+	u64 evt_page;
+	atomic64_t sint[HV_SYNIC_SINT_COUNT];
+	atomic_t sint_to_gsi[HV_SYNIC_SINT_COUNT];
+	DECLARE_BITMAP(auto_eoi_bitmap, 256);
+	DECLARE_BITMAP(vec_bitmap, 256);
+	bool active;
+	bool dont_zero_synic_pages;
+};
+
+/* The maximum number of entries on the TLB flush fifo. */
+#define KVM_HV_TLB_FLUSH_FIFO_SIZE (16)
+/*
+ * Note: the following 'magic' entry is made up by KVM to avoid putting
+ * anything besides GVA on the TLB flush fifo. It is theoretically possible
+ * to observe a request to flush 4095 PFNs starting from 0xfffffffffffff000
+ * which will look identical. KVM's action to 'flush everything' instead of
+ * flushing these particular addresses is, however, fully legitimate as
+ * flushing more than requested is always OK.
+ */
+#define KVM_HV_TLB_FLUSHALL_ENTRY  ((u64)-1)
+
+enum hv_tlb_flush_fifos {
+	HV_L1_TLB_FLUSH_FIFO,
+	HV_L2_TLB_FLUSH_FIFO,
+	HV_NR_TLB_FLUSH_FIFOS,
+};
+
+struct kvm_vcpu_hv_tlb_flush_fifo {
+	spinlock_t write_lock;
+	DECLARE_KFIFO(entries, u64, KVM_HV_TLB_FLUSH_FIFO_SIZE);
+};
+
+/* Hyper-V per vcpu emulation context */
+struct kvm_vcpu_hv {
+	struct kvm_vcpu *vcpu;
+	u32 vp_index;
+	u64 hv_vapic;
+	s64 runtime_offset;
+	struct kvm_vcpu_hv_synic synic;
+	struct kvm_hyperv_exit exit;
+	struct kvm_vcpu_hv_stimer stimer[HV_SYNIC_STIMER_COUNT];
+	DECLARE_BITMAP(stimer_pending_bitmap, HV_SYNIC_STIMER_COUNT);
+	bool enforce_cpuid;
+	struct {
+		u32 features_eax; /* HYPERV_CPUID_FEATURES.EAX */
+		u32 features_ebx; /* HYPERV_CPUID_FEATURES.EBX */
+		u32 features_edx; /* HYPERV_CPUID_FEATURES.EDX */
+		u32 enlightenments_eax; /* HYPERV_CPUID_ENLIGHTMENT_INFO.EAX */
+		u32 enlightenments_ebx; /* HYPERV_CPUID_ENLIGHTMENT_INFO.EBX */
+		u32 syndbg_cap_eax; /* HYPERV_CPUID_SYNDBG_PLATFORM_CAPABILITIES.EAX */
+		u32 nested_eax; /* HYPERV_CPUID_NESTED_FEATURES.EAX */
+		u32 nested_ebx; /* HYPERV_CPUID_NESTED_FEATURES.EBX */
+	} cpuid_cache;
+
+	struct kvm_vcpu_hv_tlb_flush_fifo tlb_flush_fifo[HV_NR_TLB_FLUSH_FIFOS];
+
+	/*
+	 * Preallocated buffers for handling hypercalls that pass sparse vCPU
+	 * sets (for high vCPU counts, they're too large to comfortably fit on
+	 * the stack).
+	 */
+	u64 sparse_banks[HV_MAX_SPARSE_VCPU_BANKS];
+	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
+
+	struct hv_vp_assist_page vp_assist_page;
+
+	struct {
+		u64 pa_page_gpa;
+		u64 vm_id;
+		u32 vp_id;
+	} nested;
+};
+
 /* "Hv#1" signature */
 #define HYPERV_CPUID_SIGNATURE_EAX 0x31237648
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

