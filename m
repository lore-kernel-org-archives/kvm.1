Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6F526A9E
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057457; cv=none; b=L1WlGGSXs6XJ3JDDO9WEUpEpoY5CDyzOAzeTQiT8hVSNjxDHWU2rZ8GoSda/nYumRcRLO2UVrP9YrEemtkVDpUk2llVRkPa2010ppVeyYsWPTgi9I+qOwoAMiQI6qO5V+Am3EEDELEuWmGdDXTRy9yFaAhsmnjCW50zvZOTwMC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057457; c=relaxed/simple;
	bh=nyp1CjhE37fv/eNY3uNnSxmNlTELsiXYH+XE3jWaJT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZhSPxBbxEMlouKNtH8FU9vgoV8SBd3EUWTQq4BI9IWt0F322zfn52pTPYYc8VHyovTbEAFi/rB3qYcShFhYQGim1M2UCvSZszWwipPAnlHZ3InnNv4INW6dJRi94qEHiAMyW7XTLdCtC5DQUds7k468dgPfsuyFMD+2gXVkF9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=evSoW0ip; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="evSoW0ip"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso63565e9.2
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 09:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789057445; x=1789662245; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rXcm2H9Hj3wZMgLwTNPt9AcEfZj6H1K1nw4RELODNwU=;
        b=evSoW0iprlYTU7SV9A2T1T7qQl5bGzQW8nFla1X4A1noLiDynzqw4xyCO9IdNxzLlN
         tatMR6wtkKw24BRYy7t2+JeeVlUgZHCXD5d67Wpl74I2xiYer/sNB1YU+qf///yHJsyL
         c3tEmu8SKJcE/aGMBH3CpjT1A3qFueUrjM837SYlqWgOqgZ+WMSq9ONaffMFZXDHQCPT
         G/MCMQpdE6b/HM1rWcWE+6rU/5n6PF1f4Zphx3WgTyjCSPUgDfgBGgRMUeomWAILoCs4
         86ujp1ocJa29TbTq6QNX8mlmCF0sgeQVzUslTI2jQDXyIQUACYTF4o2T20agUSxSNeXS
         6e3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057445; x=1789662245;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rXcm2H9Hj3wZMgLwTNPt9AcEfZj6H1K1nw4RELODNwU=;
        b=B67f53mv341eDDJ4XD7rWn5ESZdLvcrCJovvmbMfKOfOhUUJWp4PkQ+mGCqRzkSiwe
         DQQJPHaWVV81/l0TcTX8PeoZxQYf1oUKlV1xagZc+w51LtmSlAuZp83mTOJYAiQeX3uI
         NYfMO5xQvbzksa2t5UFBnE3rmjTLLat9/bRNva9JiTyVRQBVuRYK2YE/FrVExZagOERo
         jxPEpJEybSvVYs31/KyoiuukNuhJsyPKTfTh1COm+/Fw6pS3E294rnZy5S/tHNg1x0pi
         IUL8uw6CDHh/VFhlGx6L2pUGC2LH1M1qZVwox2Wgxn0LGhicUTa0kc8tbmre7sQezOSc
         LmMw==
X-Forwarded-Encrypted: i=1; AKwUvByf+0SqTF9A7JBLA6hKDOCAbo8hm1Mn2Ji7if+DVy3cV+jWJy3snczcc5xsYJdpHl4Q4wM=@vger.kernel.org
X-Gm-Message-State: AFuF++lhdDLpgzhk9rpeFVAm5Xy+oSLgDBrjLNIytcD7gWJyxxemIzCP
	F6kfNO+qaPPFM2PJ8yDz5Y4iQ4FBz2s1hTi2Q1/3Ncr0WnK38RvjCfIQY6RovIEIUz/Df8Kx97T
	xPg==
X-Received: from wmdp17.prod.google.com ([2002:a05:600c:5d1:b0:493:b636:4ee9])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600d:6445:10b0:49c:fc6c:be09
 with SMTP id 5b1f17b1804b1-49cfc6cc00emr286275605e9.32.1789057443617; Thu, 10
 Sep 2026 09:24:03 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:21:40 +0000
In-Reply-To: <20260910162343.4092060-1-elver@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910162343.4092060-1-elver@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910162343.4092060-8-elver@google.com>
Subject: [PATCH RFC 07/10] KVM: x86: Add basic lock context annotations
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add basic lock context annotations across common x86, VMX, SVM, and
Hyper-V sources in preparation for enabling context analysis.

The only opted-out functions are tdx_acquire_vm_state_locks() and
tdx_release_vm_state_locks(), which dynamically acquire and release an
arbitrary number of locks that cannot be represented statically.

Because Clang context analysis evaluates lock expressions syntactically,
it cannot prove the equivalence of heap pointer aliases (e.g. `vcpu->kvm`
vs. `to_svm(vcpu)->vcpu.kvm`). When a callee expects a lock expression
through a different alias path than the caller, bridge the alias using
lockdep_assert_held() on the target expression. This dynamically validates
lock ownership under lockdep while satisfying the compiler's static analysis.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
 arch/x86/kvm/debugfs.c        |  1 +
 arch/x86/kvm/hyperv.c         | 21 +++++++++++++
 arch/x86/kvm/hyperv.h         | 16 +++++++---
 arch/x86/kvm/ioapic.c         | 24 ++++++++++++---
 arch/x86/kvm/irq.c            |  2 ++
 arch/x86/kvm/lapic.c          |  8 ++++-
 arch/x86/kvm/lapic.h          | 15 ++++++---
 arch/x86/kvm/mmu/page_track.c |  1 +
 arch/x86/kvm/mmu/page_track.h |  3 +-
 arch/x86/kvm/mmu/spte.h       |  3 +-
 arch/x86/kvm/msrs.c           |  5 +++
 arch/x86/kvm/msrs.h           |  3 +-
 arch/x86/kvm/regs.h           | 15 ++++++---
 arch/x86/kvm/smm.c            |  6 ++++
 arch/x86/kvm/smm.h            |  2 +-
 arch/x86/kvm/svm/hyperv.c     |  2 ++
 arch/x86/kvm/svm/hyperv.h     |  6 ++--
 arch/x86/kvm/svm/nested.c     | 30 ++++++++++++++++--
 arch/x86/kvm/svm/sev.c        | 18 +++++++++++
 arch/x86/kvm/svm/svm.c        | 32 +++++++++++++++++++
 arch/x86/kvm/svm/svm.h        | 28 +++++++++++------
 arch/x86/kvm/vmx/hyperv.h     |  6 ++--
 arch/x86/kvm/vmx/main.c       |  5 +++
 arch/x86/kvm/vmx/nested.c     | 54 ++++++++++++++++++++++++++++++--
 arch/x86/kvm/vmx/nested.h     | 19 ++++++++----
 arch/x86/kvm/vmx/sgx.c        |  3 ++
 arch/x86/kvm/vmx/sgx.h        |  3 +-
 arch/x86/kvm/vmx/tdx.c        |  9 ++++++
 arch/x86/kvm/vmx/vmx.c        | 11 +++++++
 arch/x86/kvm/vmx/x86_ops.h    | 24 ++++++++++-----
 arch/x86/kvm/x86.c            | 58 ++++++++++++++++++++++++++++++++---
 arch/x86/kvm/x86.h            | 37 +++++++++++++++-------
 32 files changed, 398 insertions(+), 72 deletions(-)

diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
index 0074a56e45b4..0bf8c021ee89 100644
--- a/arch/x86/kvm/debugfs.c
+++ b/arch/x86/kvm/debugfs.c
@@ -109,6 +109,7 @@ static int kvm_mmu_rmaps_stat_show(struct seq_file *m, void *v)
 	}
 
 	mutex_lock(&kvm->slots_lock);
+	__assume_shared_ctx_lock(&kvm->srcu); /* update-side lock is held */
 	write_lock(&kvm->mmu_lock);
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 604651cb2739..cca7c98a3808 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -268,6 +268,8 @@ static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
 	struct kvm_vcpu *vcpu = hv_synic_to_vcpu(synic);
 	int ret;
 
+	lockdep_assert_held(&vcpu->kvm->srcu);
+
 	if (!synic->active && (!host || data))
 		return 1;
 
@@ -780,6 +782,8 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 	struct hv_message_header hv_hdr;
 	int r;
 
+	lockdep_assert_held(&vcpu->kvm->srcu);
+
 	if (!(synic->msg_page & HV_SYNIC_SIMP_ENABLE))
 		return -ENOENT;
 
@@ -1056,6 +1060,7 @@ static bool kvm_hv_msr_partition_wide(u32 msr)
 }
 
 static int kvm_hv_msr_get_crash_data(struct kvm *kvm, u32 index, u64 *pdata)
+	__must_hold(&to_kvm_hv(kvm)->hv_lock)
 {
 	struct kvm_hv *hv = to_kvm_hv(kvm);
 	size_t size = ARRAY_SIZE(hv->hv_crash_param);
@@ -1068,6 +1073,7 @@ static int kvm_hv_msr_get_crash_data(struct kvm *kvm, u32 index, u64 *pdata)
 }
 
 static int kvm_hv_msr_get_crash_ctl(struct kvm *kvm, u64 *pdata)
+	__must_hold(&to_kvm_hv(kvm)->hv_lock)
 {
 	struct kvm_hv *hv = to_kvm_hv(kvm);
 
@@ -1076,6 +1082,7 @@ static int kvm_hv_msr_get_crash_ctl(struct kvm *kvm, u64 *pdata)
 }
 
 static int kvm_hv_msr_set_crash_ctl(struct kvm *kvm, u64 data)
+	__must_hold(&to_kvm_hv(kvm)->hv_lock)
 {
 	struct kvm_hv *hv = to_kvm_hv(kvm);
 
@@ -1085,6 +1092,7 @@ static int kvm_hv_msr_set_crash_ctl(struct kvm *kvm, u64 data)
 }
 
 static int kvm_hv_msr_set_crash_data(struct kvm *kvm, u32 index, u64 data)
+	__must_hold(&to_kvm_hv(kvm)->hv_lock)
 {
 	struct kvm_hv *hv = to_kvm_hv(kvm);
 	size_t size = ARRAY_SIZE(hv->hv_crash_param);
@@ -1175,6 +1183,7 @@ static bool compute_tsc_page_parameters(struct pvclock_vcpu_time_info *hv_clock,
  * TSC scaling is unsupported).
  */
 static inline bool tsc_page_update_unsafe(struct kvm_hv *hv)
+	__must_hold(&hv->hv_lock)
 {
 	return (hv->hv_tsc_page_status != HV_TSC_PAGE_GUEST_CHANGED) &&
 		hv->hv_tsc_emulation_control;
@@ -1397,6 +1406,8 @@ void kvm_hv_xsaves_xsavec_maybe_warn(struct kvm_vcpu *vcpu)
 
 static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 			     bool host)
+	__must_hold(&to_kvm_hv(vcpu->kvm)->hv_lock)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_hv *hv = to_kvm_hv(kvm);
@@ -1539,6 +1550,7 @@ static u64 current_task_runtime_100ns(void)
 }
 
 static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 
@@ -1652,6 +1664,7 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 
 static int kvm_hv_get_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 			     bool host)
+	__must_hold(&to_kvm_hv(vcpu->kvm)->hv_lock)
 {
 	u64 data = 0;
 	struct kvm *kvm = vcpu->kvm;
@@ -1910,6 +1923,7 @@ struct kvm_hv_hcall {
 
 static int kvm_hv_get_hc_data(struct kvm *kvm, struct kvm_hv_hcall *hc,
 			      u16 orig_cnt, u16 cnt_cap, u64 *data)
+	__must_hold_shared(&kvm->srcu)
 {
 	/*
 	 * Preserve the original count when ignoring entries via a "cap", KVM
@@ -1943,6 +1957,7 @@ static int kvm_hv_get_hc_data(struct kvm *kvm, struct kvm_hv_hcall *hc,
 
 static u64 kvm_get_sparse_vp_set(struct kvm *kvm, struct kvm_hv_hcall *hc,
 				 u64 *sparse_banks)
+	__must_hold_shared(&kvm->srcu)
 {
 	if (hc->var_cnt > HV_MAX_SPARSE_VCPU_BANKS)
 		return -EINVAL;
@@ -1953,6 +1968,7 @@ static u64 kvm_get_sparse_vp_set(struct kvm *kvm, struct kvm_hv_hcall *hc,
 }
 
 static int kvm_hv_get_tlb_flush_entries(struct kvm *kvm, struct kvm_hv_hcall *hc, u64 entries[])
+	__must_hold_shared(&kvm->srcu)
 {
 	return kvm_hv_get_hc_data(kvm, hc, hc->rep_cnt, hc->rep_cnt, entries);
 }
@@ -2034,6 +2050,7 @@ int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
 }
 
 static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	unsigned long *vcpu_mask = hv_vcpu->vcpu_mask;
@@ -2243,6 +2260,7 @@ static void kvm_hv_send_ipi_to_many(struct kvm *kvm, u32 vector,
 }
 
 static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	u64 *sparse_banks = hv_vcpu->sparse_banks;
@@ -2405,6 +2423,7 @@ static void kvm_hv_hypercall_set_result(struct kvm_vcpu *vcpu, u64 result)
 }
 
 static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	u32 tlb_lock_count = 0;
 	int ret;
@@ -2428,11 +2447,13 @@ static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
 }
 
 static int kvm_hv_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	return kvm_hv_hypercall_complete(vcpu, vcpu->run->hyperv.u.hcall.result);
 }
 
 static u16 kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct kvm_hv *hv = to_kvm_hv(vcpu->kvm);
 	struct eventfd_ctx *eventfd;
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 622a6553e9ac..09dbab1fddb1 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -197,7 +197,8 @@ static inline u32 kvm_hv_get_vpindex(struct kvm_vcpu *vcpu)
 	return hv_vcpu ? hv_vcpu->vp_index : vcpu->vcpu_idx;
 }
 
-int kvm_hv_set_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host);
+int kvm_hv_set_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
+	__must_hold_shared(&vcpu->kvm->srcu);
 int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host);
 
 static inline bool kvm_hv_hypercall_enabled(struct kvm_vcpu *vcpu)
@@ -205,9 +206,11 @@ static inline bool kvm_hv_hypercall_enabled(struct kvm_vcpu *vcpu)
 	return vcpu->arch.hyperv_enabled && to_kvm_hv(vcpu->kvm)->hv_guest_os_id;
 }
 
-int kvm_hv_hypercall(struct kvm_vcpu *vcpu);
+int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
-void kvm_hv_irq_routing_update(struct kvm *kvm);
+void kvm_hv_irq_routing_update(struct kvm *kvm)
+	__must_hold_shared(&kvm->irq_srcu);
 int kvm_hv_synic_set_irq(struct kvm_kernel_irq_routing_entry *e, struct kvm *kvm,
 			 int irq_source_id, int level, bool line_status);
 void kvm_hv_synic_send_eoi(struct kvm_vcpu *vcpu, int vector);
@@ -227,7 +230,8 @@ static inline bool kvm_hv_synic_auto_eoi_set(struct kvm_vcpu *vcpu, int vector)
 void kvm_hv_vcpu_uninit(struct kvm_vcpu *vcpu);
 
 bool kvm_hv_assist_page_enabled(struct kvm_vcpu *vcpu);
-int kvm_hv_get_assist_page(struct kvm_vcpu *vcpu);
+int kvm_hv_get_assist_page(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 static inline struct kvm_vcpu_hv_stimer *to_hv_stimer(struct kvm_vcpu *vcpu,
 						      int timer_index)
@@ -285,7 +289,8 @@ static inline bool kvm_hv_invtsc_suppressed(struct kvm_vcpu *vcpu)
 void kvm_hv_process_stimers(struct kvm_vcpu *vcpu);
 
 void kvm_hv_setup_tsc_page(struct kvm *kvm,
-			   struct pvclock_vcpu_time_info *hv_clock);
+			   struct pvclock_vcpu_time_info *hv_clock)
+	__must_hold_shared(&kvm->srcu);
 void kvm_hv_request_tsc_page_update(struct kvm *kvm);
 
 void kvm_hv_xsaves_xsavec_maybe_warn(struct kvm_vcpu *vcpu);
@@ -352,6 +357,7 @@ static inline bool kvm_hv_is_tlb_flush_hcall(struct kvm_vcpu *vcpu)
 }
 
 static inline int kvm_hv_verify_vp_assist(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (!to_hv_vcpu(vcpu))
 		return 0;
diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 0d59b9c758c2..d6865e557abe 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -36,9 +36,11 @@
 #include "x86.h"
 
 static int ioapic_service(struct kvm_ioapic *vioapic, int irq,
-		bool line_status);
+		bool line_status)
+	__must_hold(&vioapic->lock);
 
 static unsigned long ioapic_read_indirect(struct kvm_ioapic *ioapic)
+	__must_hold(&ioapic->lock)
 {
 	unsigned long result = 0;
 
@@ -76,20 +78,24 @@ static unsigned long ioapic_read_indirect(struct kvm_ioapic *ioapic)
 }
 
 static void rtc_irq_eoi_tracking_reset(struct kvm_ioapic *ioapic)
+	__must_hold(&ioapic->lock)
 {
 	ioapic->rtc_status.pending_eoi = 0;
 	bitmap_zero(ioapic->rtc_status.map, KVM_MAX_VCPU_IDS);
 }
 
-static void kvm_rtc_eoi_tracking_restore_all(struct kvm_ioapic *ioapic);
+static void kvm_rtc_eoi_tracking_restore_all(struct kvm_ioapic *ioapic)
+	__must_hold(&ioapic->lock);
 
 static void rtc_status_pending_eoi_check_valid(struct kvm_ioapic *ioapic)
+	__must_hold(&ioapic->lock)
 {
 	if (WARN_ON_ONCE(ioapic->rtc_status.pending_eoi < 0))
 		kvm_rtc_eoi_tracking_restore_all(ioapic);
 }
 
 static void __rtc_irq_eoi_tracking_restore_one(struct kvm_vcpu *vcpu)
+	__must_hold(&vcpu->kvm->arch.vioapic->lock)
 {
 	bool new_val, old_val;
 	struct kvm_ioapic *ioapic = vcpu->kvm->arch.vioapic;
@@ -137,12 +143,15 @@ static void kvm_rtc_eoi_tracking_restore_all(struct kvm_ioapic *ioapic)
 		return;
 
 	rtc_irq_eoi_tracking_reset(ioapic);
-	kvm_for_each_vcpu(i, vcpu, ioapic->kvm)
-	    __rtc_irq_eoi_tracking_restore_one(vcpu);
+	kvm_for_each_vcpu(i, vcpu, ioapic->kvm) {
+		lockdep_assert_held(&vcpu->kvm->arch.vioapic->lock); /* vcpu->kvm->arch.vioapic == ioapic */
+		__rtc_irq_eoi_tracking_restore_one(vcpu);
+	}
 }
 
 static void rtc_irq_eoi(struct kvm_ioapic *ioapic, struct kvm_vcpu *vcpu,
 			int vector)
+	__must_hold(&ioapic->lock)
 {
 	struct rtc_status *status = &ioapic->rtc_status;
 
@@ -156,6 +165,7 @@ static void rtc_irq_eoi(struct kvm_ioapic *ioapic, struct kvm_vcpu *vcpu,
 }
 
 static bool rtc_irq_check_coalesced(struct kvm_ioapic *ioapic)
+	__must_hold(&ioapic->lock)
 {
 	if (ioapic->rtc_status.pending_eoi > 0)
 		return true; /* coalesced */
@@ -164,6 +174,7 @@ static bool rtc_irq_check_coalesced(struct kvm_ioapic *ioapic)
 }
 
 static void ioapic_lazy_update_eoi(struct kvm_ioapic *ioapic, int irq)
+	__must_hold(&ioapic->lock)
 {
 	unsigned long i;
 	struct kvm_vcpu *vcpu;
@@ -187,6 +198,7 @@ static void ioapic_lazy_update_eoi(struct kvm_ioapic *ioapic, int irq)
 
 static int ioapic_set_irq(struct kvm_ioapic *ioapic, unsigned int irq,
 		int irq_level, bool line_status)
+	__must_hold(&ioapic->lock)
 {
 	union kvm_ioapic_redirect_entry entry;
 	u32 mask = 1 << irq;
@@ -246,6 +258,7 @@ static int ioapic_set_irq(struct kvm_ioapic *ioapic, unsigned int irq,
 }
 
 static void kvm_ioapic_inject_all(struct kvm_ioapic *ioapic, unsigned long irr)
+	__must_hold(&ioapic->lock)
 {
 	u32 idx;
 
@@ -330,6 +343,7 @@ void kvm_fire_mask_notifiers(struct kvm *kvm, unsigned irqchip, unsigned pin,
 }
 
 static void ioapic_write_indirect(struct kvm_ioapic *ioapic, u32 val)
+	__must_hold(&ioapic->lock)
 {
 	unsigned index;
 	bool mask_before, mask_after;
@@ -541,6 +555,7 @@ static void kvm_ioapic_update_eoi_one(struct kvm_vcpu *vcpu,
 				      struct kvm_ioapic *ioapic,
 				      int trigger_mode,
 				      int pin)
+	__must_hold(&ioapic->lock)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 	union kvm_ioapic_redirect_entry *ent = &ioapic->redirtbl[pin];
@@ -695,6 +710,7 @@ static int ioapic_mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
 }
 
 static void kvm_ioapic_reset(struct kvm_ioapic *ioapic)
+	__must_hold(&ioapic->lock)
 {
 	int i;
 
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 871977288272..5dd3bfe2aeb4 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -416,6 +416,8 @@ void kvm_scan_ioapic_routes(struct kvm_vcpu *vcpu,
 void kvm_arch_irq_routing_update(struct kvm *kvm)
 {
 #ifdef CONFIG_KVM_HYPERV
+	/* Update-side mutex kvm->irq_lock is held. */
+	__assume_shared_ctx_lock(&kvm->irq_srcu);
 	kvm_hv_irq_routing_update(kvm);
 #endif
 
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index e1f3cea14765..f5022de46725 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -901,6 +901,7 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
 }
 
 static int pv_eoi_put_user(struct kvm_vcpu *vcpu, u8 val)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 
 	return kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.pv_eoi.data, &val,
@@ -908,6 +909,7 @@ static int pv_eoi_put_user(struct kvm_vcpu *vcpu, u8 val)
 }
 
 static int pv_eoi_get_user(struct kvm_vcpu *vcpu, u8 *val)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 
 	return kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.pv_eoi.data, val,
@@ -920,6 +922,7 @@ static inline bool pv_eoi_enabled(struct kvm_vcpu *vcpu)
 }
 
 static void pv_eoi_set_pending(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (pv_eoi_put_user(vcpu, KVM_PV_EOI_ENABLED) < 0)
 		return;
@@ -928,6 +931,7 @@ static void pv_eoi_set_pending(struct kvm_vcpu *vcpu)
 }
 
 static bool pv_eoi_test_and_clr_pending(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	u8 val;
 
@@ -3378,6 +3382,7 @@ void __kvm_migrate_apic_timer(struct kvm_vcpu *vcpu)
  */
 static void apic_sync_pv_eoi_from_guest(struct kvm_vcpu *vcpu,
 					struct kvm_lapic *apic)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	int vector;
 
@@ -3428,6 +3433,7 @@ void kvm_lapic_sync_from_vapic(struct kvm_vcpu *vcpu)
  */
 static void apic_sync_pv_eoi_to_guest(struct kvm_vcpu *vcpu,
 					struct kvm_lapic *apic)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (!pv_eoi_enabled(vcpu) ||
 	    /* IRR set or many bits in ISR: could be nested. */
@@ -3443,7 +3449,7 @@ static void apic_sync_pv_eoi_to_guest(struct kvm_vcpu *vcpu,
 		return;
 	}
 
-	pv_eoi_set_pending(apic->vcpu);
+	pv_eoi_set_pending(vcpu);
 }
 
 void kvm_lapic_sync_to_vapic(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index bd1098c89d99..a193f32a5688 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -148,7 +148,8 @@ int kvm_apic_set_irq(struct kvm_vcpu *vcpu, struct kvm_lapic_irq *irq,
 int kvm_apic_local_deliver(struct kvm_lapic *apic, int lvt_type);
 void kvm_apic_update_apicv(struct kvm_vcpu *vcpu);
 int kvm_alloc_apic_access_page(struct kvm *kvm);
-void kvm_inhibit_apic_access_page(struct kvm_vcpu *vcpu);
+void kvm_inhibit_apic_access_page(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 bool kvm_irq_delivery_to_apic_fast(struct kvm *kvm, struct kvm_lapic *src,
 				   struct kvm_lapic_irq *irq, int *r);
@@ -179,9 +180,12 @@ void kvm_set_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu, u64 data);
 void kvm_apic_write_nodecode(struct kvm_vcpu *vcpu, u32 offset);
 void kvm_apic_set_eoi_accelerated(struct kvm_vcpu *vcpu, int vector);
 
-int kvm_lapic_set_vapic_addr(struct kvm_vcpu *vcpu, gpa_t vapic_addr);
-void kvm_lapic_sync_from_vapic(struct kvm_vcpu *vcpu);
-void kvm_lapic_sync_to_vapic(struct kvm_vcpu *vcpu);
+int kvm_lapic_set_vapic_addr(struct kvm_vcpu *vcpu, gpa_t vapic_addr)
+	__must_hold_shared(&vcpu->kvm->srcu);
+void kvm_lapic_sync_from_vapic(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
+void kvm_lapic_sync_to_vapic(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 int kvm_x2apic_icr_write_fast(struct kvm_lapic *apic, u64 data);
 int kvm_x2apic_msr_write(struct kvm_vcpu *vcpu, u32 msr, u64 data);
@@ -190,7 +194,8 @@ int kvm_x2apic_msr_read(struct kvm_vcpu *vcpu, u32 msr, u64 *data);
 int kvm_hv_vapic_msr_write(struct kvm_vcpu *vcpu, u32 msr, u64 data);
 int kvm_hv_vapic_msr_read(struct kvm_vcpu *vcpu, u32 msr, u64 *data);
 
-int kvm_lapic_set_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned long len);
+int kvm_lapic_set_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned long len)
+	__must_hold_shared(&vcpu->kvm->srcu);
 void kvm_lapic_exit(void);
 
 u64 kvm_x2apic_disable_read_intercept_reg_mask(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 7e8195a311bb..058a26d8065a 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -196,6 +196,7 @@ static int kvm_enable_external_write_tracking(struct kvm *kvm)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&kvm->slots_arch_lock);
+	__assume_shared_ctx_lock(&kvm->srcu); /* update-side lock is held */
 
 	/*
 	 * Check for *any* write tracking user (not just external users) under
diff --git a/arch/x86/kvm/mmu/page_track.h b/arch/x86/kvm/mmu/page_track.h
index d4d72ed999b1..8f7e176af858 100644
--- a/arch/x86/kvm/mmu/page_track.h
+++ b/arch/x86/kvm/mmu/page_track.h
@@ -21,7 +21,8 @@ void __kvm_write_track_remove_gfn(struct kvm *kvm,
 				  struct kvm_memory_slot *slot, gfn_t gfn);
 
 bool kvm_gfn_is_write_tracked(struct kvm *kvm,
-			      const struct kvm_memory_slot *slot, gfn_t gfn);
+			      const struct kvm_memory_slot *slot, gfn_t gfn)
+	__must_hold_shared(&kvm->srcu);
 
 #ifdef CONFIG_KVM_EXTERNAL_WRITE_TRACKING
 int kvm_page_track_init(struct kvm *kvm);
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index e730717824b3..cf8fc077ce04 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -568,7 +568,8 @@ u64 make_small_spte(struct kvm *kvm, u64 huge_spte,
 		    union kvm_mmu_page_role role, int index);
 u64 make_huge_spte(struct kvm *kvm, u64 small_spte, int level);
 u64 make_nonleaf_spte(u64 *child_pt, bool ad_disabled);
-u64 make_mmio_spte(struct kvm_vcpu *vcpu, u64 gfn, unsigned int access);
+u64 make_mmio_spte(struct kvm_vcpu *vcpu, u64 gfn, unsigned int access)
+	__must_hold_shared(&vcpu->kvm->srcu);
 u64 mark_spte_for_access_track(u64 spte);
 
 /* Restore an acc-track PTE back to a regular PTE */
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index dd3bb04878ca..a90d6576e3cf 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -1222,6 +1222,7 @@ static void kvm_get_xstate_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 }
 
 static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock, int sec_hi_ofs)
+	__must_hold_shared(&kvm->srcu)
 {
 	int version;
 	int r;
@@ -1264,9 +1265,12 @@ static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock, int sec_hi_o
 
 static void kvm_write_system_time(struct kvm_vcpu *vcpu, gpa_t system_time,
 				  bool old_msr, bool host_initiated)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct kvm_arch *ka = &vcpu->kvm->arch;
 
+	lockdep_assert_held(&vcpu->arch.pv_time.kvm->srcu); /* vcpu->arch.pv_time.kvm == vcpu->kvm */
+
 	if (vcpu->vcpu_id == 0 && !host_initiated) {
 		if (ka->boot_vcpu_runs_old_kvmclock != old_msr)
 			kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
@@ -1382,6 +1386,7 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 }
 
 static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	gpa_t gpa = data & ~0x3f;
 
diff --git a/arch/x86/kvm/msrs.h b/arch/x86/kvm/msrs.h
index 7cc182a15b3b..0736b0f61873 100644
--- a/arch/x86/kvm/msrs.h
+++ b/arch/x86/kvm/msrs.h
@@ -74,7 +74,8 @@ fastpath_t handle_fastpath_wrmsr(struct kvm_vcpu *vcpu);
 fastpath_t handle_fastpath_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg);
 
 int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
-int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
+int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 int kvm_add_user_return_msr(u32 msr);
 int kvm_find_user_return_msr(u32 msr);
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 447f0ec3e63e..3f6d4a0ac97f 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -56,15 +56,20 @@ static_assert(!(KVM_POSSIBLE_CR0_GUEST_BITS & X86_CR0_PDPTR_BITS));
 
 void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned long cr0);
 void kvm_post_set_cr4(struct kvm_vcpu *vcpu, unsigned long old_cr4, unsigned long cr4);
-int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
-int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3);
-int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
+int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
+	__must_hold_shared(&vcpu->kvm->srcu);
+int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
+	__must_hold_shared(&vcpu->kvm->srcu);
+int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
+	__must_hold_shared(&vcpu->kvm->srcu);
 int kvm_set_cr8(struct kvm_vcpu *vcpu, unsigned long cr8);
 int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val);
 unsigned long kvm_get_dr(struct kvm_vcpu *vcpu, int dr);
 unsigned long kvm_get_cr8(struct kvm_vcpu *vcpu);
-void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
-int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
+void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw)
+	__must_hold_shared(&vcpu->kvm->srcu);
+int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 static inline bool is_long_mode(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index 656a38dad7e7..5f93257961c3 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -418,6 +418,7 @@ static int rsm_load_seg_64(struct kvm_vcpu *vcpu,
 
 static int rsm_enter_protected_mode(struct kvm_vcpu *vcpu,
 				    u64 cr0, u64 cr3, u64 cr4)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	int bad;
 	u64 pcid;
@@ -463,6 +464,7 @@ static int rsm_enter_protected_mode(struct kvm_vcpu *vcpu,
 
 static int rsm_load_state_32(struct x86_emulate_ctxt *ctxt,
 			     const struct kvm_smram_state_32 *smstate)
+	__must_hold_shared(&((struct kvm_vcpu *)ctxt->vcpu)->kvm->srcu)
 {
 	struct kvm_vcpu *vcpu = ctxt->vcpu;
 	struct desc_ptr dt;
@@ -515,6 +517,7 @@ static int rsm_load_state_32(struct x86_emulate_ctxt *ctxt,
 #ifdef CONFIG_X86_64
 static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
 			     const struct kvm_smram_state_64 *smstate)
+	__must_hold_shared(&((struct kvm_vcpu *)ctxt->vcpu)->kvm->srcu)
 {
 	struct kvm_vcpu *vcpu = ctxt->vcpu;
 	struct desc_ptr dt;
@@ -578,6 +581,9 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 	u64 smbase;
 	int ret;
 
+	/* Called via struct x86_emulate_ops callback; assert SRCU dynamically. */
+	lockdep_assert_held(&vcpu->kvm->srcu);
+
 	smbase = vcpu->arch.smbase;
 
 	ret = kvm_vcpu_read_guest(vcpu, smbase + 0xfe00, smram.bytes, sizeof(smram));
diff --git a/arch/x86/kvm/smm.h b/arch/x86/kvm/smm.h
index db3c88f16138..6c15db642538 100644
--- a/arch/x86/kvm/smm.h
+++ b/arch/x86/kvm/smm.h
@@ -155,7 +155,7 @@ static inline bool is_smm(struct kvm_vcpu *vcpu)
 }
 
 void kvm_smm_changed(struct kvm_vcpu *vcpu, bool in_smm);
-void enter_smm(struct kvm_vcpu *vcpu);
+void enter_smm(struct kvm_vcpu *vcpu) __must_hold_shared(&vcpu->kvm->srcu);
 int emulator_leave_smm(struct x86_emulate_ctxt *ctxt);
 void process_smi(struct kvm_vcpu *vcpu);
 #else
diff --git a/arch/x86/kvm/svm/hyperv.c b/arch/x86/kvm/svm/hyperv.c
index 4f24dcb45116..117c069c5bfa 100644
--- a/arch/x86/kvm/svm/hyperv.c
+++ b/arch/x86/kvm/svm/hyperv.c
@@ -10,6 +10,8 @@ void svm_hv_inject_synthetic_vmexit_post_tlb_flush(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	lockdep_assert_held(&svm->vcpu.kvm->srcu); /* svm->vcpu.kvm == vcpu->kvm */
+
 	/*
 	 * The exit code used by Hyper-V for software-defined exits is reserved
 	 * by AMD specifically for such use cases.
diff --git a/arch/x86/kvm/svm/hyperv.h b/arch/x86/kvm/svm/hyperv.h
index f70d076911a6..e9990cabd332 100644
--- a/arch/x86/kvm/svm/hyperv.h
+++ b/arch/x86/kvm/svm/hyperv.h
@@ -48,14 +48,16 @@ static inline bool nested_svm_is_l2_tlb_flush_hcall(struct kvm_vcpu *vcpu)
 	       kvm_hv_is_tlb_flush_hcall(vcpu);
 }
 
-void svm_hv_inject_synthetic_vmexit_post_tlb_flush(struct kvm_vcpu *vcpu);
+void svm_hv_inject_synthetic_vmexit_post_tlb_flush(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
 #else /* CONFIG_KVM_HYPERV */
 static inline void nested_svm_hv_update_vm_vp_ids(struct kvm_vcpu *vcpu) {}
 static inline bool nested_svm_is_l2_tlb_flush_hcall(struct kvm_vcpu *vcpu)
 {
 	return false;
 }
-static inline void svm_hv_inject_synthetic_vmexit_post_tlb_flush(struct kvm_vcpu *vcpu) {}
+static inline void svm_hv_inject_synthetic_vmexit_post_tlb_flush(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu) {}
 #endif /* CONFIG_KVM_HYPERV */
 
 #endif /* __ARCH_X86_KVM_SVM_HYPERV_H__ */
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 73f37b050d0a..d421d6807166 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -38,9 +38,12 @@
 static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 				       struct x86_exception *fault,
 				       bool from_hardware)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb;
+
+	lockdep_assert_held(&svm->vcpu.kvm->srcu); /* svm->vcpu.kvm == vcpu->kvm */
 	u64 fault_stage;
 
 	/*
@@ -72,6 +75,7 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 }
 
 static u64 nested_svm_get_tdp_pdptr(struct kvm_vcpu *vcpu, int index)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u64 cr3 = svm->nested.ctl.nested_cr3;
@@ -293,6 +297,7 @@ int __init nested_svm_init_msrpm_merge_offsets(void)
  * may contain zero bits.
  */
 static bool nested_svm_merge_msrpm(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	nsvm_msrpm_merge_t *msrpm02 = svm->nested.msrpm;
@@ -713,6 +718,7 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
  */
 static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 			       bool nested_npt, bool reload_pdptrs)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (CC(!kvm_vcpu_is_legal_cr3(vcpu, cr3)))
 		return -EINVAL;
@@ -1065,7 +1071,7 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa, bool from_vmrun)
 	nested_vmcb02_prepare_control(svm);
 	nested_vmcb02_prepare_save(svm);
 
-	ret = nested_svm_load_cr3(&svm->vcpu, svm->nested.save.cr3,
+	ret = nested_svm_load_cr3(vcpu, svm->nested.save.cr3,
 				  nested_npt_enabled(svm), from_vmrun);
 	if (ret)
 		return ret;
@@ -1117,6 +1123,8 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	u64 vmcb12_gpa;
 	struct vmcb *vmcb01 = svm->vmcb01.ptr;
 
+	lockdep_assert_held(&svm->vcpu.kvm->srcu); /* svm->vcpu.kvm == vcpu->kvm */
+
 	if (!svm->nested.hsave_msr) {
 		kvm_inject_gp(vcpu, 0);
 		return 1;
@@ -1320,6 +1328,8 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	struct vmcb *vmcb01 = svm->vmcb01.ptr;
 	struct vmcb *vmcb02 = svm->nested.vmcb02.ptr;
 
+	lockdep_assert_held(&vcpu->kvm->srcu); /* vcpu == &svm->vcpu */
+
 	if (nested_svm_vmexit_update_vmcb12(vcpu))
 		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 
@@ -1467,14 +1477,17 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 }
 
 static void nested_svm_triple_fault(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	lockdep_assert_held(&svm->vcpu.kvm->srcu); /* svm->vcpu.kvm == vcpu->kvm */
+
 	if (!vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_SHUTDOWN))
 		return;
 
 	kvm_clear_request(KVM_REQ_TRIPLE_FAULT, vcpu);
-	nested_svm_simple_vmexit(to_svm(vcpu), SVM_EXIT_SHUTDOWN);
+	nested_svm_simple_vmexit(svm, SVM_EXIT_SHUTDOWN);
 }
 
 int svm_allocate_nested(struct vcpu_svm *svm)
@@ -1562,6 +1575,7 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 }
 
 static int nested_svm_exit_handled_msr(struct vcpu_svm *svm)
+	__must_hold_shared(&svm->vcpu.kvm->srcu)
 {
 	gpa_t base = svm->nested.ctl.msrpm_base_pa;
 	int write, bit_nr;
@@ -1587,6 +1601,7 @@ static int nested_svm_exit_handled_msr(struct vcpu_svm *svm)
 }
 
 static int nested_svm_intercept_ioio(struct vcpu_svm *svm)
+	__must_hold_shared(&svm->vcpu.kvm->srcu)
 {
 	unsigned port, size, iopm_len;
 	u16 val, mask;
@@ -1612,6 +1627,7 @@ static int nested_svm_intercept_ioio(struct vcpu_svm *svm)
 }
 
 static int nested_svm_intercept(struct vcpu_svm *svm)
+	__must_hold_shared(&svm->vcpu.kvm->srcu)
 {
 	u64 exit_code = svm->vmcb->control.exit_code;
 	int vmexit = NESTED_EXIT_HOST;
@@ -1679,11 +1695,14 @@ static bool nested_svm_is_exception_vmexit(struct kvm_vcpu *vcpu, u8 vector,
 }
 
 static void nested_svm_inject_exception_vmexit(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct kvm_queued_exception *ex = &vcpu->arch.exception_vmexit;
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb;
 
+	lockdep_assert_held(&svm->vcpu.kvm->srcu); /* svm->vcpu.kvm == vcpu->kvm */
+
 	vmcb->control.exit_code = SVM_EXIT_EXCP_BASE + ex->vector;
 
 	if (ex->has_error_code)
@@ -1719,9 +1738,12 @@ static inline bool nested_exit_on_init(struct vcpu_svm *svm)
 }
 
 static int svm_check_nested_events(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 	struct vcpu_svm *svm = to_svm(vcpu);
+
+	lockdep_assert_held(&svm->vcpu.kvm->srcu); /* svm->vcpu.kvm == vcpu->kvm */
 	/*
 	 * Only a pending nested run blocks a pending exception.  If there is a
 	 * previously injected event, the pending exception occurred while said
@@ -1946,6 +1968,7 @@ static int svm_get_nested_state(struct kvm_vcpu *vcpu,
 static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 				struct kvm_nested_state __user *user_kvm_nested_state,
 				struct kvm_nested_state *kvm_state)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb __user *user_vmcb = (struct vmcb __user *)
@@ -2086,7 +2109,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	 * thus MMU might not be initialized correctly.
 	 * Set it again to fix this.
 	 */
-	ret = nested_svm_load_cr3(&svm->vcpu, vcpu->arch.cr3,
+	ret = nested_svm_load_cr3(vcpu, vcpu->arch.cr3,
 				  nested_npt_enabled(svm), false);
 	if (ret)
 		goto out_free;
@@ -2105,6 +2128,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 }
 
 static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (WARN_ON(!is_guest_mode(vcpu)))
 		return true;
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5705723f1f41..ec9589cd0abe 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1117,6 +1117,7 @@ static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
 }
 
 static int sev_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
+	__must_hold(&kvm->lock)
 {
 	struct kvm_vcpu *vcpu;
 	unsigned long i;
@@ -1981,6 +1982,8 @@ static bool is_cmd_allowed_from_mirror(u32 cmd_id)
 }
 
 static int sev_lock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
+	__cond_acquires(0, &dst_kvm->lock)
+	__cond_acquires(0, &src_kvm->lock)
 {
 	struct kvm_sev_info *dst_sev = to_kvm_sev_info(dst_kvm);
 	struct kvm_sev_info *src_sev = to_kvm_sev_info(src_kvm);
@@ -2016,6 +2019,8 @@ static int sev_lock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
 }
 
 static void sev_unlock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
+	__releases(&dst_kvm->lock)
+	__releases(&src_kvm->lock)
 {
 	struct kvm_sev_info *dst_sev = to_kvm_sev_info(dst_kvm);
 	struct kvm_sev_info *src_sev = to_kvm_sev_info(src_kvm);
@@ -2473,6 +2478,7 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	 * situations.
 	 */
 	guard(mutex)(&kvm->slots_lock);
+	__assume_shared_ctx_lock(&kvm->srcu); /* update-side lock is held */
 
 	memslot = gfn_to_memslot(kvm, params.gfn_start);
 	if (!kvm_slot_has_gmem(memslot))
@@ -2503,6 +2509,7 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
 }
 
 static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
+	__must_hold(&kvm->lock)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
 	struct sev_data_snp_launch_update data = {};
@@ -2560,6 +2567,7 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 }
 
 static int snp_launch_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
+	__must_hold(&kvm->lock)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
 	struct kvm_sev_snp_launch_finish params;
@@ -3622,6 +3630,7 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 
 #define GHCB_SCRATCH_AREA_LIMIT		(16ULL * PAGE_SIZE)
 static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 min_len)
+	__must_hold_shared(&svm->vcpu.kvm->srcu)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
 	u64 ghcb_scratch_beg, ghcb_scratch_end;
@@ -4036,6 +4045,7 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	kvm_pfn_t pfn;
 
 	lockdep_assert_held(&svm->sev_es.snp_vmsa_mutex);
+	lockdep_assert_held(&vcpu->kvm->srcu);
 
 	/*
 	 * Clear use of the VMSA.  Ensure snp_guest_vmsa_gpa is written exactly
@@ -4216,6 +4226,7 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 }
 
 static int snp_handle_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_gpa)
+	__must_hold_shared(&svm->vcpu.kvm->srcu)
 {
 	struct sev_data_snp_guest_request data = {0};
 	struct kvm *kvm = svm->vcpu.kvm;
@@ -4262,10 +4273,13 @@ static int snp_req_certs_err(struct vcpu_svm *svm, u32 vmm_error)
 }
 
 static int snp_complete_req_certs(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb_control_area *control = &svm->vmcb->control;
 
+	lockdep_assert_held(&svm->vcpu.kvm->srcu); /* svm->vcpu.kvm == vcpu->kvm */
+
 	switch (READ_ONCE(vcpu->run->snp_req_certs.ret)) {
 	case 0:
 		return snp_handle_guest_req(svm, control->exit_info_1,
@@ -4285,6 +4299,7 @@ static int snp_complete_req_certs(struct kvm_vcpu *vcpu)
 }
 
 static int snp_handle_ext_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_gpa)
+	__must_hold_shared(&svm->vcpu.kvm->srcu)
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	struct kvm *kvm = vcpu->kvm;
@@ -4347,6 +4362,7 @@ static int snp_handle_ext_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t r
 }
 
 static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
+	__must_hold_shared(&svm->vcpu.kvm->srcu)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
@@ -4509,6 +4525,8 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	struct vmcb_control_area *control = &svm->vmcb->control;
 	u64 ghcb_gpa;
 
+	lockdep_assert_held(&svm->vcpu.kvm->srcu); /* svm->vcpu.kvm == vcpu->kvm */
+
 	/* Validate the GHCB */
 	ghcb_gpa = control->ghcb_gpa;
 	if (ghcb_gpa & GHCB_MSR_INFO_MASK)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7d59d301e1e5..c20b6a9fe8dd 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1432,10 +1432,13 @@ static void svm_srso_vm_destroy(void) { }
 #endif
 
 static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, vcpu->cpu);
 
+	lockdep_assert_held(&svm->vcpu.kvm->srcu); /* svm->vcpu.kvm == vcpu->kvm */
+
 	if (is_sev_es_guest(vcpu))
 		sev_es_unmap_ghcb(svm);
 
@@ -1533,6 +1536,7 @@ static bool svm_get_if_flag(struct kvm_vcpu *vcpu)
 }
 
 static void svm_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	kvm_register_mark_available(vcpu, reg);
 
@@ -1972,6 +1976,7 @@ static int svm_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 					 void *insn, int insn_len);
 
 static int npf_interception(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	int rc;
@@ -2094,6 +2099,7 @@ static int icebp_interception(struct kvm_vcpu *vcpu)
 }
 
 static int ud_interception(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	return handle_ud(vcpu);
 }
@@ -2193,12 +2199,15 @@ static int shutdown_interception(struct kvm_vcpu *vcpu)
 }
 
 static int io_interception(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u32 io_info = svm->vmcb->control.exit_info_1; /* address size bug? */
 	int size, in, string;
 	unsigned port;
 
+	lockdep_assert_held(&svm->vcpu.kvm->srcu); /* svm->vcpu.kvm == vcpu->kvm */
+
 	++vcpu->stat.io_exits;
 	string = (io_info & SVM_IOIO_STR_MASK) != 0;
 	in = (io_info & SVM_IOIO_TYPE_MASK) != 0;
@@ -2279,6 +2288,7 @@ static int vmsave_interception(struct kvm_vcpu *vcpu)
 }
 
 static int vmrun_interception(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (nested_svm_check_permissions(vcpu))
 		return 1;
@@ -2319,11 +2329,14 @@ static u64 svm_get_decoded_instr_exit_code(struct kvm_vcpu *vcpu)
  *   2) VMware backdoor
  */
 static int gp_interception(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u32 error_code = svm->vmcb->control.exit_info_1;
 	u64 svm_exit_code;
 
+	lockdep_assert_held(&svm->vcpu.kvm->srcu); /* svm->vcpu.kvm == vcpu->kvm */
+
 	/* Both #GP cases have zero error_code */
 	if (error_code)
 		goto reinject;
@@ -2562,11 +2575,14 @@ static int rsm_interception(struct kvm_vcpu *vcpu)
 
 static bool check_selective_cr0_intercepted(struct kvm_vcpu *vcpu,
 					    unsigned long val)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	unsigned long cr0 = vcpu->arch.cr0;
 	bool ret = false;
 
+	lockdep_assert_held(&svm->vcpu.kvm->srcu); /* svm->vcpu.kvm == vcpu->kvm */
+
 	if (!is_guest_mode(vcpu) ||
 	    (!(vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_SELECTIVE_CR0))))
 		return false;
@@ -2585,6 +2601,7 @@ static bool check_selective_cr0_intercepted(struct kvm_vcpu *vcpu,
 #define CR_VALID (1ULL << 63)
 
 static int cr_interception(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	int reg, cr;
@@ -2733,6 +2750,7 @@ static int dr_interception(struct kvm_vcpu *vcpu)
 }
 
 static int cr8_write_interception(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	u8 cr8_prev = kvm_get_cr8(vcpu);
 	int r;
@@ -2750,6 +2768,7 @@ static int cr8_write_interception(struct kvm_vcpu *vcpu)
 }
 
 static int efer_trap(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct msr_data msr_info;
 	int ret;
@@ -2988,6 +3007,7 @@ static int svm_set_vm_cr(struct kvm_vcpu *vcpu, u64 data)
 }
 
 static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	int ret = 0;
@@ -3265,6 +3285,7 @@ static int pause_interception(struct kvm_vcpu *vcpu)
 }
 
 static int invpcid_interception(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	unsigned long type;
@@ -3329,6 +3350,7 @@ static int bus_lock_exit(struct kvm_vcpu *vcpu)
 }
 
 static int vmmcall_interception(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	/*
 	 * Inject a #UD if L2 is active and the VMMCALL isn't a Hyper-V TLB
@@ -3713,10 +3735,13 @@ static void svm_get_entry_info(struct kvm_vcpu *vcpu, u32 *intr_info,
 }
 
 static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_run *kvm_run = vcpu->run;
 
+	lockdep_assert_held(&svm->vcpu.kvm->srcu); /* svm->vcpu.kvm == vcpu->kvm */
+
 	if (unlikely(exit_fastpath == EXIT_FASTPATH_EXIT_USERSPACE))
 		return 0;
 
@@ -4832,12 +4857,15 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 			       struct x86_instruction_info *info,
 			       enum x86_intercept_stage stage,
 			       struct x86_exception *exception)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	int vmexit, ret = X86EMUL_CONTINUE;
 	struct __x86_intercept icpt_info;
 	struct vmcb *vmcb = svm->vmcb;
 
+	lockdep_assert_held(&svm->vcpu.kvm->srcu); /* svm->vcpu.kvm == vcpu->kvm */
+
 	if (info->intercept >= ARRAY_SIZE(x86_intercept_map))
 		goto out;
 
@@ -5011,9 +5039,12 @@ static int svm_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 }
 
 static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	lockdep_assert_held(&svm->vcpu.kvm->srcu); /* svm->vcpu.kvm == vcpu->kvm */
+
 	if (!is_guest_mode(vcpu))
 		return 0;
 
@@ -5057,6 +5088,7 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 }
 
 static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb12;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e958943b8162..e62700fc678d 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -818,7 +818,8 @@ bool svm_smi_blocked(struct kvm_vcpu *vcpu);
 bool svm_nmi_blocked(struct kvm_vcpu *vcpu);
 bool svm_interrupt_blocked(struct kvm_vcpu *vcpu);
 void svm_set_gif(struct vcpu_svm *svm, bool value);
-int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code);
+int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
+	__must_hold_shared(&vcpu->kvm->srcu);
 void set_msr_interception(struct kvm_vcpu *vcpu, u32 *msrpm, u32 msr,
 			  int read, int write);
 void svm_complete_interrupt_delivery(struct kvm_vcpu *vcpu, int delivery_mode,
@@ -870,17 +871,21 @@ static inline bool nested_exit_on_nmi(struct vcpu_svm *svm)
 
 int __init nested_svm_init_msrpm_merge_offsets(void);
 
-int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb_gpa, bool from_vmrun);
+int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb_gpa, bool from_vmrun)
+	__must_hold_shared(&vcpu->kvm->srcu);
 void svm_leave_nested(struct kvm_vcpu *vcpu);
 void svm_free_nested(struct vcpu_svm *svm);
 int svm_allocate_nested(struct vcpu_svm *svm);
-int nested_svm_vmrun(struct kvm_vcpu *vcpu);
+int nested_svm_vmrun(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
 void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
 			  struct vmcb_save_area *from_save);
 void svm_copy_vmloadsave_state(struct vmcb *to_vmcb, struct vmcb *from_vmcb);
-void nested_svm_vmexit(struct vcpu_svm *svm);
+void nested_svm_vmexit(struct vcpu_svm *svm)
+	__must_hold_shared(&svm->vcpu.kvm->srcu);
 
 static inline void nested_svm_simple_vmexit(struct vcpu_svm *svm, u32 exit_code)
+	__must_hold_shared(&svm->vcpu.kvm->srcu)
 {
 	svm->vmcb->control.exit_code	= exit_code;
 	svm->vmcb->control.exit_info_1	= 0;
@@ -888,7 +893,8 @@ static inline void nested_svm_simple_vmexit(struct vcpu_svm *svm, u32 exit_code)
 	nested_svm_vmexit(svm);
 }
 
-int nested_svm_exit_handled(struct vcpu_svm *svm);
+int nested_svm_exit_handled(struct vcpu_svm *svm)
+	__must_hold_shared(&svm->vcpu.kvm->srcu);
 int nested_svm_check_permissions(struct kvm_vcpu *vcpu);
 int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu);
 int nested_svm_check_exception(struct vcpu_svm *svm, unsigned nr,
@@ -973,11 +979,13 @@ void avic_refresh_virtual_apic_mode(struct kvm_vcpu *vcpu);
 int pre_sev_run(struct vcpu_svm *svm, int cpu);
 void sev_init_vmcb(struct vcpu_svm *svm, bool init_event);
 void sev_vcpu_after_set_cpuid(struct vcpu_svm *svm);
-int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in);
+int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in)
+	__must_hold_shared(&svm->vcpu.kvm->srcu);
 void sev_es_recalc_msr_intercepts(struct kvm_vcpu *vcpu);
 void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
 void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_area *hostsa);
-void sev_es_unmap_ghcb(struct vcpu_svm *svm);
+void sev_es_unmap_ghcb(struct vcpu_svm *svm)
+	__must_hold_shared(&svm->vcpu.kvm->srcu);
 
 #ifdef CONFIG_KVM_AMD_SEV
 bool sev_vcpu_needs_initialization(struct kvm_vcpu *vcpu);
@@ -989,7 +997,8 @@ int sev_mem_enc_unregister_region(struct kvm *kvm,
 int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd);
 int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd);
 void sev_guest_memory_reclaimed(struct kvm *kvm);
-int sev_handle_vmgexit(struct kvm_vcpu *vcpu);
+int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 /* These symbols are used in common code and are stubbed below.  */
 
@@ -1010,7 +1019,8 @@ void sev_hardware_unsetup(void);
 int sev_cpu_init(struct svm_cpu_data *sd);
 int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
 extern unsigned int max_sev_asid;
-void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
+void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
+	__must_hold_shared(&vcpu->kvm->srcu);
 int sev_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, kvm_pfn_t nr_pages);
 void sev_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
 void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
diff --git a/arch/x86/kvm/vmx/hyperv.h b/arch/x86/kvm/vmx/hyperv.h
index 11a339009781..a0e126d2a5b4 100644
--- a/arch/x86/kvm/vmx/hyperv.h
+++ b/arch/x86/kvm/vmx/hyperv.h
@@ -52,14 +52,16 @@ static inline bool guest_cpu_cap_has_evmcs(struct kvm_vcpu *vcpu)
 	       to_vmx(vcpu)->nested.enlightened_vmcs_enabled;
 }
 
-u64 nested_get_evmptr(struct kvm_vcpu *vcpu);
+u64 nested_get_evmptr(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
 uint16_t nested_get_evmcs_version(struct kvm_vcpu *vcpu);
 int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 			uint16_t *vmcs_version);
 void nested_evmcs_filter_control_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 *pdata);
 int nested_evmcs_check_controls(struct vmcs12 *vmcs12);
 bool nested_evmcs_l2_tlb_flush_enabled(struct kvm_vcpu *vcpu);
-void vmx_hv_inject_synthetic_vmexit_post_tlb_flush(struct kvm_vcpu *vcpu);
+void vmx_hv_inject_synthetic_vmexit_post_tlb_flush(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
 #else
 static inline bool evmptr_is_valid(u64 evmptr)
 {
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 4c52ab8d0786..c2a0c259ceea 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -156,6 +156,7 @@ static fastpath_t vt_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 
 static int vt_handle_exit(struct kvm_vcpu *vcpu,
 			  enum exit_fastpath_completion fastpath)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (is_td_vcpu(vcpu))
 		return tdx_handle_exit(vcpu, fastpath);
@@ -174,6 +175,7 @@ static bool vt_unhandleable_emulation_required(struct kvm_vcpu *vcpu)
 }
 
 static int vt_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (unlikely(is_td_vcpu(vcpu)))
 		return tdx_set_msr(vcpu, msr_info);
@@ -233,6 +235,7 @@ static int vt_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 }
 
 static int vt_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (KVM_BUG_ON(is_td_vcpu(vcpu), vcpu->kvm))
 		return 0;
@@ -241,6 +244,7 @@ static int vt_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 }
 
 static int vt_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (KVM_BUG_ON(is_td_vcpu(vcpu), vcpu->kvm))
 		return 0;
@@ -722,6 +726,7 @@ static void vt_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 }
 
 static void vt_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (is_td_vcpu(vcpu))
 		return;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 151873407abd..506e206bad5d 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -250,6 +250,7 @@ static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
 }
 
 static bool nested_evmcs_handle_vmclear(struct kvm_vcpu *vcpu, gpa_t vmptr)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 #ifdef CONFIG_KVM_HYPERV
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -386,7 +387,8 @@ static void free_nested(struct kvm_vcpu *vcpu)
 void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
 {
 	vcpu_load(vcpu);
-	vmx_leave_nested(vcpu);
+	/* VM is being destroyed; vcpu->kvm->srcu is not held. */
+	context_unsafe(vmx_leave_nested(vcpu));
 	vcpu_put(vcpu);
 }
 
@@ -421,6 +423,7 @@ static void nested_ept_invalidate_addr(struct kvm_vcpu *vcpu, gpa_t eptp,
 static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 					 struct x86_exception *fault,
 					 bool from_hardware)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -587,6 +590,7 @@ static int nested_vmx_check_msr_bitmap_controls(struct kvm_vcpu *vcpu,
 
 static int nested_vmx_check_tpr_shadow_controls(struct kvm_vcpu *vcpu,
 						struct vmcs12 *vmcs12)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	gpa_t vtpr_gpa = vmcs12->virtual_apic_page_addr + APIC_TASKPRI;
 	u32 vtpr;
@@ -850,6 +854,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 
 static void nested_cache_shadow_vmcs12(struct kvm_vcpu *vcpu,
 				       struct vmcs12 *vmcs12)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct gfn_to_hva_cache *ghc = &vmx->nested.shadow_vmcs12_cache;
@@ -869,6 +874,7 @@ static void nested_cache_shadow_vmcs12(struct kvm_vcpu *vcpu,
 
 static void nested_flush_cached_shadow_vmcs12(struct kvm_vcpu *vcpu,
 					      struct vmcs12 *vmcs12)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct gfn_to_hva_cache *ghc = &vmx->nested.shadow_vmcs12_cache;
@@ -1095,6 +1101,7 @@ static int nested_vmx_store_msr_check(struct kvm_vcpu *vcpu,
  * for a capacity violation.
  */
 static u32 nested_vmx_load_msr(struct kvm_vcpu *vcpu, u64 gpa, u32 count)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	u32 i;
 	struct vmx_msr_entry e;
@@ -1159,6 +1166,7 @@ static bool nested_vmx_get_vmexit_msr_value(struct kvm_vcpu *vcpu,
 
 static bool read_and_check_msr_entry(struct kvm_vcpu *vcpu, u64 gpa, int i,
 				     struct vmx_msr_entry *e)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (kvm_vcpu_read_guest(vcpu,
 				gpa + i * sizeof(*e),
@@ -1178,6 +1186,7 @@ static bool read_and_check_msr_entry(struct kvm_vcpu *vcpu, u64 gpa, int i,
 }
 
 static int nested_vmx_store_msr(struct kvm_vcpu *vcpu, u64 gpa, u32 count)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	u64 data;
 	u32 i;
@@ -1208,6 +1217,7 @@ static int nested_vmx_store_msr(struct kvm_vcpu *vcpu, u64 gpa, u32 count)
 }
 
 static bool nested_msr_store_list_has_msr(struct kvm_vcpu *vcpu, u32 msr_index)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	u32 count = vmcs12->vm_exit_msr_store_count;
@@ -1234,6 +1244,7 @@ static bool nested_msr_store_list_has_msr(struct kvm_vcpu *vcpu, u32 msr_index)
 static int nested_vmx_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 			       bool nested_ept, bool reload_pdptrs,
 			       enum vm_entry_failure_code *entry_failure_code)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (CC(!kvm_vcpu_is_legal_cr3(vcpu, cr3))) {
 		*entry_failure_code = ENTRY_FAIL_DEFAULT;
@@ -2183,6 +2194,7 @@ static void copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx)
  */
 static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
 	struct kvm_vcpu *vcpu, bool from_launch)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 #ifdef CONFIG_KVM_HYPERV
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -2622,6 +2634,7 @@ static void vmcs_write_cet_state(struct kvm_vcpu *vcpu, u64 s_cet,
 }
 
 static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
+	__must_hold_shared(&vmx->vcpu.kvm->srcu)
 {
 	struct hv_enlightened_vmcs *hv_evmcs = nested_vmx_evmcs(vmx);
 
@@ -2760,11 +2773,14 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 			  bool from_vmentry,
 			  enum vm_entry_failure_code *entry_failure_code)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct hv_enlightened_vmcs *evmcs = nested_vmx_evmcs(vmx);
 	bool load_guest_pdptrs_vmcs12 = false;
 
+	lockdep_assert_held(&vmx->vcpu.kvm->srcu); /* vmx->vcpu.kvm == vcpu->kvm */
+
 	if (vmx->nested.dirty_vmcs12 || nested_vmx_is_evmptr12_valid(vmx)) {
 		prepare_vmcs02_rare(vmx, vmcs12);
 		vmx->nested.dirty_vmcs12 = false;
@@ -2968,6 +2984,7 @@ static bool nested_vmx_check_eptp(struct kvm_vcpu *vcpu, u64 new_eptp)
  */
 static int nested_check_vm_execution_controls(struct kvm_vcpu *vcpu,
                                               struct vmcs12 *vmcs12)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -3126,6 +3143,7 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
 
 static int nested_vmx_check_controls(struct kvm_vcpu *vcpu,
 				     struct vmcs12 *vmcs12)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (nested_check_vm_execution_controls(vcpu, vmcs12) ||
 	    nested_check_vm_exit_controls(vcpu, vmcs12) ||
@@ -3267,6 +3285,7 @@ static int nested_vmx_check_host_state(struct kvm_vcpu *vcpu,
 
 static int nested_vmx_check_vmcs_link_ptr(struct kvm_vcpu *vcpu,
 					  struct vmcs12 *vmcs12)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct gfn_to_hva_cache *ghc = &vmx->nested.shadow_vmcs12_cache;
@@ -3311,6 +3330,7 @@ static int nested_check_guest_non_reg_state(struct vmcs12 *vmcs12)
 static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
 					struct vmcs12 *vmcs12,
 					enum vm_entry_failure_code *entry_failure_code)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	bool ia32e = !!(vmcs12->vm_entry_controls & VM_ENTRY_IA32E_MODE);
 
@@ -3411,6 +3431,7 @@ static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
 
 #ifdef CONFIG_KVM_HYPERV
 static bool nested_get_evmcs_page(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -3440,6 +3461,7 @@ static bool nested_get_evmcs_page(struct kvm_vcpu *vcpu)
 #endif
 
 static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -3528,6 +3550,7 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 }
 
 static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 #ifdef CONFIG_KVM_HYPERV
 	/*
@@ -3555,6 +3578,7 @@ static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
 }
 
 static int nested_vmx_write_pml_buffer(struct kvm_vcpu *vcpu, gpa_t gpa)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vmcs12 *vmcs12;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -3790,6 +3814,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
  * for running an L2 nested guest.
  */
 static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vmcs12 *vmcs12;
 	enum nvmx_vmentry_status status;
@@ -4027,6 +4052,7 @@ static void vmcs12_save_pending_event(struct kvm_vcpu *vcpu,
 }
 
 static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int max_irr;
@@ -4070,6 +4096,7 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 }
 
 static void nested_vmx_inject_exception_vmexit(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct kvm_queued_exception *ex = &vcpu->arch.exception_vmexit;
 	u32 intr_info = ex->vector | INTR_INFO_VALID_MASK;
@@ -4303,6 +4330,7 @@ static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
  *     priority over external interrupts and lower priority events.
  */
 static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -4744,6 +4772,7 @@ static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
 static void prepare_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 			   u32 vm_exit_reason, u32 exit_intr_info,
 			   unsigned long exit_qualification, u32 exit_insn_len)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	/* update exit information fields: */
 	vmcs12->vm_exit_reason = vm_exit_reason;
@@ -4799,6 +4828,7 @@ static void prepare_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
  */
 static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 				   struct vmcs12 *vmcs12)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	enum vm_entry_failure_code ignored;
 	struct kvm_segment seg;
@@ -4958,6 +4988,7 @@ static inline u64 nested_vmx_get_vmcs01_guest_efer(struct vcpu_vmx *vmx)
 }
 
 static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -5230,6 +5261,7 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 }
 
 static void nested_vmx_triple_fault(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	kvm_clear_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 	nested_vmx_vmexit(vcpu, EXIT_REASON_TRIPLE_FAULT, 0, 0);
@@ -5368,6 +5400,7 @@ int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
 
 static int nested_vmx_get_vmptr(struct kvm_vcpu *vcpu, gpa_t *vmpointer,
 				int *ret)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	gva_t gva;
 	struct x86_exception e;
@@ -5475,6 +5508,7 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 
 /* Emulate the VMXON instruction. */
 static int handle_vmxon(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	int ret;
 	gpa_t vmptr;
@@ -5566,6 +5600,7 @@ static int handle_vmxon(struct kvm_vcpu *vcpu)
 }
 
 static inline void nested_release_vmcs12(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -5608,6 +5643,7 @@ static int handle_vmxoff(struct kvm_vcpu *vcpu)
 
 /* Emulate the VMCLEAR instruction */
 static int handle_vmclear(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u32 zero = 0;
@@ -5650,18 +5686,20 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
 
 /* Emulate the VMLAUNCH instruction */
 static int handle_vmlaunch(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	return nested_vmx_run(vcpu, true);
 }
 
 /* Emulate the VMRESUME instruction */
 static int handle_vmresume(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
-
 	return nested_vmx_run(vcpu, false);
 }
 
 static int handle_vmread(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vmcs12 *vmcs12 = is_guest_mode(vcpu) ? get_shadow_vmcs12(vcpu)
 						    : get_vmcs12(vcpu);
@@ -5768,6 +5806,7 @@ static bool is_shadow_field_ro(unsigned long field)
 }
 
 static int handle_vmwrite(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vmcs12 *vmcs12 = is_guest_mode(vcpu) ? get_shadow_vmcs12(vcpu)
 						    : get_vmcs12(vcpu);
@@ -5889,6 +5928,7 @@ static void set_current_vmptr(struct vcpu_vmx *vmx, gpa_t vmptr)
 
 /* Emulate the VMPTRLD instruction */
 static int handle_vmptrld(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	gpa_t vmptr;
@@ -5959,6 +5999,7 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 
 /* Emulate the VMPTRST instruction */
 static int handle_vmptrst(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	unsigned long exit_qual = vmx_get_exit_qual(vcpu);
 	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
@@ -5987,6 +6028,7 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
 
 /* Emulate the INVEPT instruction */
 static int handle_invept(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u32 vmx_instruction_info, types;
@@ -6067,6 +6109,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 }
 
 static int handle_invvpid(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u32 vmx_instruction_info;
@@ -6159,6 +6202,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 
 static int nested_vmx_eptp_switching(struct kvm_vcpu *vcpu,
 				     struct vmcs12 *vmcs12)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	u32 index = kvm_ecx_read(vcpu);
 	u64 new_eptp;
@@ -6191,6 +6235,7 @@ static int nested_vmx_eptp_switching(struct kvm_vcpu *vcpu,
 }
 
 static int handle_vmfunc(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmcs12 *vmcs12;
@@ -6280,6 +6325,7 @@ bool nested_vmx_check_io_bitmaps(struct kvm_vcpu *vcpu, unsigned int port,
 
 static bool nested_vmx_exit_handled_io(struct kvm_vcpu *vcpu,
 				       struct vmcs12 *vmcs12)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	unsigned long exit_qualification;
 	unsigned short port;
@@ -6305,6 +6351,7 @@ static bool nested_vmx_exit_handled_io(struct kvm_vcpu *vcpu,
 static bool nested_vmx_exit_handled_msr(struct kvm_vcpu *vcpu,
 					struct vmcs12 *vmcs12,
 					union vmx_exit_reason exit_reason)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	u32 msr_index;
 	gpa_t bitmap;
@@ -6434,6 +6481,7 @@ static bool nested_vmx_exit_handled_encls(struct kvm_vcpu *vcpu,
 
 static bool nested_vmx_exit_handled_vmcs_access(struct kvm_vcpu *vcpu,
 	struct vmcs12 *vmcs12, gpa_t bitmap)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	u32 vmx_instruction_info;
 	unsigned long field;
@@ -6561,6 +6609,7 @@ static bool nested_vmx_l0_wants_exit(struct kvm_vcpu *vcpu,
  */
 static bool nested_vmx_l1_wants_exit(struct kvm_vcpu *vcpu,
 				     union vmx_exit_reason exit_reason)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	u32 intr_info;
@@ -6908,6 +6957,7 @@ int nested_vmx_check_restored_vmcs12(struct kvm_vcpu *vcpu)
 static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 				struct kvm_nested_state __user *user_kvm_nested_state,
 				struct kvm_nested_state *kvm_state)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmcs12 *vmcs12;
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index c6de848bd9ce..3b8b6579c104 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -17,23 +17,29 @@ enum nvmx_vmentry_status {
 	NVMX_VMENTRY_KVM_INTERNAL_ERROR,/* KVM internal error */
 };
 
-void vmx_leave_nested(struct kvm_vcpu *vcpu);
+void vmx_leave_nested(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
 void nested_vmx_setup_ctls_msrs(struct vmcs_config *vmcs_conf, u32 ept_caps);
 void nested_vmx_hardware_unsetup(void);
 __init int nested_vmx_hardware_setup(int (*exit_handlers[])(struct kvm_vcpu *));
 void nested_vmx_set_vmcs_shadowing_bitmap(void);
-int nested_vmx_check_restored_vmcs12(struct kvm_vcpu *vcpu);
+int nested_vmx_check_restored_vmcs12(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
 void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu);
 enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
-						     bool from_vmentry);
-bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu);
+						     bool from_vmentry)
+	__must_hold_shared(&vcpu->kvm->srcu);
+bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
 void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 			 u32 exit_intr_info, unsigned long exit_qualification,
-			 u32 exit_insn_len);
+			 u32 exit_insn_len)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 static inline void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 				     u32 exit_intr_info,
 				     unsigned long exit_qualification)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	u32 exit_insn_len;
 
@@ -53,7 +59,8 @@ int vmx_get_vmx_msr(struct nested_vmx_msrs *msrs, u32 msr_index, u64 *pdata);
 int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
 			u32 vmx_instruction_info, bool wr, int len, gva_t *ret);
 bool nested_vmx_check_io_bitmaps(struct kvm_vcpu *vcpu, unsigned int port,
-				 int size);
+				 int size)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 static inline struct vmcs12 *get_vmcs12(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index 771c75a58343..588cc8ae1f8b 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -91,6 +91,7 @@ static int sgx_gva_to_gpa(struct kvm_vcpu *vcpu, gva_t gva, bool write,
 }
 
 static int sgx_gpa_to_hva(struct kvm_vcpu *vcpu, gpa_t gpa, unsigned long *hva)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	*hva = kvm_vcpu_gfn_to_hva(vcpu, PFN_DOWN(gpa));
 	if (kvm_is_error_hva(*hva)) {
@@ -216,6 +217,7 @@ static int __handle_encls_ecreate(struct kvm_vcpu *vcpu,
 }
 
 static int handle_encls_ecreate(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	gva_t pageinfo_gva, secs_gva;
 	gva_t metadata_gva, contents_gva;
@@ -296,6 +298,7 @@ static int handle_encls_ecreate(struct kvm_vcpu *vcpu)
 }
 
 static int handle_encls_einit(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	unsigned long sig_hva, secs_hva, token_hva, rflags;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
diff --git a/arch/x86/kvm/vmx/sgx.h b/arch/x86/kvm/vmx/sgx.h
index a400888b376d..08b1d5e90aa8 100644
--- a/arch/x86/kvm/vmx/sgx.h
+++ b/arch/x86/kvm/vmx/sgx.h
@@ -10,7 +10,8 @@
 #ifdef CONFIG_X86_SGX_KVM
 extern bool __read_mostly enable_sgx;
 
-int handle_encls(struct kvm_vcpu *vcpu);
+int handle_encls(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 void setup_default_sgx_lepubkeyhash(void);
 void vcpu_setup_sgx_lepubkeyhash(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b272c20586a7..7cf53c5dc712 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1155,6 +1155,7 @@ static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
 }
 
 static int tdx_emulate_vmcall(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	kvm_rax_write_raw(vcpu, to_tdx(vcpu)->vp_enter_args.r10);
 	kvm_rbx_write_raw(vcpu, to_tdx(vcpu)->vp_enter_args.r11);
@@ -1408,6 +1409,7 @@ static int tdx_complete_mmio_read(struct kvm_vcpu *vcpu)
 
 static inline int tdx_mmio_write(struct kvm_vcpu *vcpu, gpa_t gpa, int size,
 				 unsigned long val)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (!kvm_io_bus_write(vcpu, KVM_FAST_MMIO_BUS, gpa, 0, NULL)) {
 		trace_kvm_fast_mmio(gpa);
@@ -1422,6 +1424,7 @@ static inline int tdx_mmio_write(struct kvm_vcpu *vcpu, gpa_t gpa, int size,
 }
 
 static inline int tdx_mmio_read(struct kvm_vcpu *vcpu, gpa_t gpa, int size)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	unsigned long val;
 
@@ -1434,6 +1437,7 @@ static inline int tdx_mmio_read(struct kvm_vcpu *vcpu, gpa_t gpa, int size)
 }
 
 static int tdx_emulate_mmio(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 	int size, write, r;
@@ -1912,6 +1916,7 @@ static inline bool tdx_is_sept_violation_unexpected_pending(struct kvm_vcpu *vcp
 }
 
 static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	unsigned long exit_qual;
 	gpa_t gpa = to_tdx(vcpu)->exit_gpa;
@@ -2723,6 +2728,7 @@ static int tdx_read_cpuid(struct kvm_vcpu *vcpu, u32 leaf, u32 sub_leaf,
 typedef void *tdx_vm_state_guard_t;
 
 static tdx_vm_state_guard_t tdx_acquire_vm_state_locks(struct kvm *kvm)
+	__context_unsafe(/* multi-lock acquisition */)
 {
 	int r;
 
@@ -2750,6 +2756,7 @@ static tdx_vm_state_guard_t tdx_acquire_vm_state_locks(struct kvm *kvm)
 }
 
 static void tdx_release_vm_state_locks(struct kvm *kvm)
+	__context_unsafe(/* multi-lock release */)
 {
 	mutex_unlock(&kvm->slots_lock);
 	kvm_unlock_all_vcpus(kvm);
@@ -3213,6 +3220,7 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 }
 
 static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *cmd)
+	__must_hold(&vcpu->kvm->slots_lock)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 	struct kvm *kvm = vcpu->kvm;
@@ -3292,6 +3300,7 @@ int tdx_vcpu_unlocked_ioctl(struct kvm_vcpu *vcpu, void __user *argp)
 	CLASS(tdx_vm_state_guard, guard)(kvm);
 	if (IS_ERR(guard))
 		return PTR_ERR(guard);
+	lockdep_assert_held(&kvm->slots_lock);
 
 	if (!is_hkid_assigned(kvm_tdx) || kvm_tdx->state == TD_STATE_RUNNABLE)
 		return -EINVAL;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 612ab07d4100..ddf5c05955e1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5429,6 +5429,7 @@ static int vmx_handle_page_fault(struct kvm_vcpu *vcpu, u32 error_code)
 }
 
 static int handle_exception_nmi(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct kvm_run *kvm_run = vcpu->run;
@@ -5589,6 +5590,7 @@ static int handle_triple_fault(struct kvm_vcpu *vcpu)
 }
 
 static int handle_io(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	unsigned long exit_qualification;
 	int size, in, string;
@@ -5621,6 +5623,7 @@ void vmx_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hypercall)
 
 /* called to set cr0 as appropriate for a mov-to-cr0 exit. */
 static int handle_set_cr0(struct kvm_vcpu *vcpu, unsigned long val)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (is_guest_mode(vcpu)) {
 		struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
@@ -5647,6 +5650,7 @@ static int handle_set_cr0(struct kvm_vcpu *vcpu, unsigned long val)
 }
 
 static int handle_set_cr4(struct kvm_vcpu *vcpu, unsigned long val)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (is_guest_mode(vcpu)) {
 		struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
@@ -5676,6 +5680,7 @@ static int handle_desc(struct kvm_vcpu *vcpu)
 }
 
 static int handle_cr(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	unsigned long exit_qualification, val;
 	int cr;
@@ -6003,6 +6008,7 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 }
 
 static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	gpa_t gpa;
 
@@ -6140,6 +6146,7 @@ static int handle_monitor_trap(struct kvm_vcpu *vcpu)
 }
 
 static int handle_invpcid(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	u32 vmx_instruction_info;
 	unsigned long type;
@@ -6427,6 +6434,7 @@ static void vmx_destroy_pml_buffer(struct vcpu_vmx *vmx)
 }
 
 static void vmx_flush_pml_buffer(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u16 pml_idx, pml_tail_index;
@@ -6466,6 +6474,7 @@ static void vmx_flush_pml_buffer(struct kvm_vcpu *vcpu)
 }
 
 static void nested_vmx_mark_all_vmcs12_pages_dirty(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -6706,6 +6715,7 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
  * assistance.
  */
 static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	union vmx_exit_reason exit_reason = vmx_get_exit_reason(vcpu);
@@ -8144,6 +8154,7 @@ static __init void vmx_set_cpu_caps(void)
 static bool vmx_is_io_intercepted(struct kvm_vcpu *vcpu,
 				  struct x86_instruction_info *info,
 				  unsigned long *exit_qualification)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	unsigned short port;
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 054fd14bb2e1..f92ae9e60211 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -26,16 +26,20 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu);
 void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 void vmx_vcpu_put(struct kvm_vcpu *vcpu);
-int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath);
+int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
+	__must_hold_shared(&vcpu->kvm->srcu);
 void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu);
 int vmx_skip_emulated_instruction(struct kvm_vcpu *vcpu);
 void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu);
 bool vmx_unhandleable_emulation_required(struct kvm_vcpu *vcpu);
-int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
+int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+	__must_hold_shared(&vcpu->kvm->srcu);
 #ifdef CONFIG_KVM_SMM
 int vmx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection);
-int vmx_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram);
-int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram);
+int vmx_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
+	__must_hold_shared(&vcpu->kvm->srcu);
+int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
+	__must_hold_shared(&vcpu->kvm->srcu);
 void vmx_enable_smi_window(struct kvm_vcpu *vcpu);
 #endif
 int vmx_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
@@ -43,7 +47,8 @@ int vmx_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 int vmx_check_intercept(struct kvm_vcpu *vcpu,
 			struct x86_instruction_info *info,
 			enum x86_intercept_stage stage,
-			struct x86_exception *exception);
+			struct x86_exception *exception)
+	__must_hold_shared(&vcpu->kvm->srcu);
 bool vmx_apic_init_signal_blocked(struct kvm_vcpu *vcpu);
 void vmx_migrate_timers(struct kvm_vcpu *vcpu);
 void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu);
@@ -98,7 +103,8 @@ void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked);
 void vmx_enable_nmi_window(struct kvm_vcpu *vcpu);
 void vmx_enable_irq_window(struct kvm_vcpu *vcpu);
 void vmx_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr);
-void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu);
+void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
 void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu);
 void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr);
@@ -142,7 +148,8 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags);
 void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu);
 void tdx_vcpu_put(struct kvm_vcpu *vcpu);
 int tdx_handle_exit(struct kvm_vcpu *vcpu,
-		enum exit_fastpath_completion fastpath);
+		enum exit_fastpath_completion fastpath)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 void tdx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
 			   int trig_mode, int vector);
@@ -151,7 +158,8 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 		u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code);
 bool tdx_has_emulated_msr(u32 index);
 int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr);
-int tdx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr);
+int tdx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp);
 int tdx_vcpu_unlocked_ioctl(struct kvm_vcpu *vcpu, void __user *argp);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79468ddfe473..9893705d0dfa 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -321,7 +321,8 @@ static struct kmem_cache *kvm_alloc_emulator_cache(void)
 					  size - useroffset, NULL);
 }
 
-static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt);
+static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt)
+	__must_hold_shared(&emul_to_vcpu(ctxt)->kvm->srcu);
 
 /*
  * Handle a fault on a hardware virtualization (VMX or SVM) instruction.
@@ -1076,6 +1077,7 @@ static inline bool gtod_is_based_on_tsc(int mode)
 #endif
 
 static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool new_generation)
+	__must_hold(&vcpu->kvm->arch.tsc_write_lock)
 {
 #ifdef CONFIG_X86_64
 	struct kvm_arch *ka = &vcpu->kvm->arch;
@@ -1604,12 +1606,14 @@ static void kvm_make_mclock_inprogress_request(struct kvm *kvm)
 }
 
 static void __kvm_start_pvclock_update(struct kvm *kvm)
+	__acquires(&kvm->arch.tsc_write_lock)
 {
 	raw_spin_lock_irq(&kvm->arch.tsc_write_lock);
 	write_seqcount_begin(&kvm->arch.pvclock_sc);
 }
 
 static void kvm_start_pvclock_update(struct kvm *kvm)
+	__acquires(&kvm->arch.tsc_write_lock)
 {
 	kvm_make_mclock_inprogress_request(kvm);
 
@@ -1618,6 +1622,7 @@ static void kvm_start_pvclock_update(struct kvm *kvm)
 }
 
 static void kvm_end_pvclock_update(struct kvm *kvm)
+	__releases(&kvm->arch.tsc_write_lock)
 {
 	struct kvm_arch *ka = &kvm->arch;
 	struct kvm_vcpu *vcpu;
@@ -1716,11 +1721,14 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 				    struct kvm_vcpu *vcpu,
 				    struct gfn_to_pfn_cache *gpc,
 				    unsigned int offset)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct pvclock_vcpu_time_info *guest_hv_clock;
 	struct pvclock_vcpu_time_info hv_clock;
 	unsigned long flags;
 
+	lockdep_assert_held(&gpc->kvm->srcu); /* gpc->kvm == vcpu->kvm */
+
 	memcpy(&hv_clock, ref_hv_clock, sizeof(hv_clock));
 
 	read_lock_irqsave(&gpc->lock, flags);
@@ -2046,6 +2054,7 @@ void kvm_service_local_tlb_flush_requests(struct kvm_vcpu *vcpu)
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_service_local_tlb_flush_requests);
 
 static void record_steal_time(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct gfn_to_hva_cache *ghc = &vcpu->arch.st.cache;
 	struct kvm_steal_time __user *st;
@@ -2613,6 +2622,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 }
 
 static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct gfn_to_hva_cache *ghc = &vcpu->arch.st.cache;
 	struct kvm_steal_time __user *st;
@@ -4739,6 +4749,7 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 
 static int vcpu_mmio_write(struct kvm_vcpu *vcpu, gpa_t addr, int len,
 			   void *__v)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	const void *v = __v;
 	int handled = 0;
@@ -4762,6 +4773,7 @@ static int vcpu_mmio_write(struct kvm_vcpu *vcpu, gpa_t addr, int len,
 }
 
 static int vcpu_mmio_read(struct kvm_vcpu *vcpu, gpa_t addr, int len, void *v)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	int handled = 0;
 	int n;
@@ -4819,6 +4831,7 @@ gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
 static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 				      struct kvm_vcpu *vcpu, u64 access,
 				      struct x86_exception *exception)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 	void *data = val;
@@ -4851,6 +4864,7 @@ static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 				gva_t addr, void *val, unsigned int bytes,
 				struct x86_exception *exception)
+	__must_hold_shared(&emul_to_vcpu(ctxt)->kvm->srcu)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
@@ -4896,6 +4910,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_read_guest_virt);
 static int emulator_read_std(struct x86_emulate_ctxt *ctxt,
 			     gva_t addr, void *val, unsigned int bytes,
 			     struct x86_exception *exception, bool system)
+	__must_hold_shared(&emul_to_vcpu(ctxt)->kvm->srcu)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	u64 access = 0;
@@ -4911,6 +4926,7 @@ static int emulator_read_std(struct x86_emulate_ctxt *ctxt,
 static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 				      struct kvm_vcpu *vcpu, u64 access,
 				      struct x86_exception *exception)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 	void *data = val;
@@ -4941,6 +4957,7 @@ static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes
 static int emulator_write_std(struct x86_emulate_ctxt *ctxt, gva_t addr, void *val,
 			      unsigned int bytes, struct x86_exception *exception,
 			      bool system)
+	__must_hold_shared(&emul_to_vcpu(ctxt)->kvm->srcu)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	u64 access = PFERR_WRITE_MASK;
@@ -5001,6 +5018,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(handle_ud);
 
 static int vcpu_is_mmio_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 			    gpa_t gpa, bool write)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	/* For APIC access vmexit */
 	if ((gpa & PAGE_MASK) == APIC_DEFAULT_PHYS_BASE)
@@ -5017,6 +5035,7 @@ static int vcpu_is_mmio_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 				gpa_t *gpa, struct x86_exception *exception,
 				bool write)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 	u64 access = ((kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0)
@@ -5054,12 +5073,14 @@ struct read_write_emulator_ops {
 
 static int emulator_read_guest(struct kvm_vcpu *vcpu, gpa_t gpa,
 			       void *val, int bytes)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	return !kvm_vcpu_read_guest(vcpu, gpa, val, bytes);
 }
 
 static int emulator_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa,
 				void *val, int bytes)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	int ret;
 
@@ -5075,6 +5096,7 @@ static int emulator_read_write_onepage(unsigned long addr, void *val,
 				       struct x86_exception *exception,
 				       struct kvm_vcpu *vcpu,
 				       const struct read_write_emulator_ops *ops)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	gpa_t gpa;
 	int handled, ret;
@@ -5150,6 +5172,7 @@ static int emulator_read_write(struct x86_emulate_ctxt *ctxt,
 			void *val, unsigned int bytes,
 			struct x86_exception *exception,
 			const struct read_write_emulator_ops *ops)
+	__must_hold_shared(&emul_to_vcpu(ctxt)->kvm->srcu)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	int rc;
@@ -5229,6 +5252,7 @@ static int emulator_read_emulated(struct x86_emulate_ctxt *ctxt,
 				  void *val,
 				  unsigned int bytes,
 				  struct x86_exception *exception)
+	__must_hold_shared(&emul_to_vcpu(ctxt)->kvm->srcu)
 {
 	static const struct read_write_emulator_ops ops = {
 		.read_write_guest = emulator_read_guest,
@@ -5244,6 +5268,7 @@ static int emulator_write_emulated(struct x86_emulate_ctxt *ctxt,
 			    const void *val,
 			    unsigned int bytes,
 			    struct x86_exception *exception)
+	__must_hold_shared(&emul_to_vcpu(ctxt)->kvm->srcu)
 {
 	static const struct read_write_emulator_ops ops = {
 		.read_write_guest = emulator_write_guest,
@@ -5263,6 +5288,7 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 				     const void *new,
 				     unsigned int bytes,
 				     struct x86_exception *exception)
+	__must_hold_shared(&emul_to_vcpu(ctxt)->kvm->srcu)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	u64 page_line_mask;
@@ -5343,6 +5369,7 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 static int emulator_pio_in_out(struct kvm_vcpu *vcpu, int size,
 			       unsigned short port, void *data,
 			       unsigned int count, bool in)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	unsigned i;
 	int r;
@@ -5393,6 +5420,7 @@ static int emulator_pio_in_out(struct kvm_vcpu *vcpu, int size,
 
 static int emulator_pio_in(struct kvm_vcpu *vcpu, int size,
       			   unsigned short port, void *val, unsigned int count)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	int r = emulator_pio_in_out(vcpu, size, port, val, count, true);
 	if (r)
@@ -5413,6 +5441,7 @@ static void complete_emulator_pio_in(struct kvm_vcpu *vcpu, void *val)
 static int emulator_pio_in_emulated(struct x86_emulate_ctxt *ctxt,
 				    int size, unsigned short port, void *val,
 				    unsigned int count)
+	__must_hold_shared(&emul_to_vcpu(ctxt)->kvm->srcu)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	if (vcpu->arch.pio.count) {
@@ -5433,6 +5462,7 @@ static int emulator_pio_in_emulated(struct x86_emulate_ctxt *ctxt,
 static int emulator_pio_out(struct kvm_vcpu *vcpu, int size,
 			    unsigned short port, const void *val,
 			    unsigned int count)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	trace_kvm_pio(KVM_PIO_OUT, port, size, count, val);
 	return emulator_pio_in_out(vcpu, size, port, (void *)val, count, false);
@@ -5441,6 +5471,7 @@ static int emulator_pio_out(struct kvm_vcpu *vcpu, int size,
 static int emulator_pio_out_emulated(struct x86_emulate_ctxt *ctxt,
 				     int size, unsigned short port,
 				     const void *val, unsigned int count)
+	__must_hold_shared(&emul_to_vcpu(ctxt)->kvm->srcu)
 {
 	return emulator_pio_out(emul_to_vcpu(ctxt), size, port, val, count);
 }
@@ -5533,6 +5564,7 @@ static unsigned long emulator_get_cr(struct x86_emulate_ctxt *ctxt, int cr)
 }
 
 static int emulator_set_cr(struct x86_emulate_ctxt *ctxt, int cr, ulong val)
+	__must_hold_shared(&emul_to_vcpu(ctxt)->kvm->srcu)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	int res = 0;
@@ -6578,6 +6610,7 @@ static int complete_fast_pio_out(struct kvm_vcpu *vcpu)
 
 static int kvm_fast_pio_out(struct kvm_vcpu *vcpu, int size,
 			    unsigned short port)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	unsigned long val = kvm_rax_read_raw(vcpu);
 	int ret = emulator_pio_out(vcpu, size, port, &val, 1);
@@ -6625,6 +6658,7 @@ static int complete_fast_pio_in(struct kvm_vcpu *vcpu)
 
 static int kvm_fast_pio_in(struct kvm_vcpu *vcpu, int size,
 			   unsigned short port)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	unsigned long val;
 	int ret;
@@ -7192,6 +7226,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_x86_vendor_exit);
 #ifdef CONFIG_X86_64
 static int kvm_pv_clock_pairing(struct kvm_vcpu *vcpu, gpa_t paddr,
 			        unsigned long clock_type)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	struct kvm_clock_pairing clock_pairing;
 	struct timespec64 ts;
@@ -7571,6 +7606,7 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
  */
 static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 				       bool *req_immediate_exit)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	bool can_inject;
 	int r;
@@ -7868,6 +7904,7 @@ void __kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu)
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_vcpu_update_apicv);
 
 static void kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (!lapic_in_kernel(vcpu))
 		return;
@@ -8049,6 +8086,7 @@ static void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
  * userspace.
  */
 static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	int r;
 	bool req_int_win =
@@ -8561,6 +8599,7 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 
 /* Called within kvm->srcu read side.  */
 static inline int vcpu_block(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	bool hv_timer;
 
@@ -8629,6 +8668,7 @@ static inline int vcpu_block(struct kvm_vcpu *vcpu)
 
 /* Called within kvm->srcu read side.  */
 static int vcpu_run(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	int r;
 
@@ -9940,10 +9980,13 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 {
 	int i, r;
 	unsigned long hva, old_npages;
-	struct kvm_memslots *slots = kvm_memslots(kvm);
+	struct kvm_memslots *slots;
 	struct kvm_memory_slot *slot;
 
 	lockdep_assert_held(&kvm->slots_lock);
+	__assume_shared_ctx_lock(&kvm->srcu); /* update-side lock is held */
+
+	slots = kvm_memslots(kvm);
 
 	if (WARN_ON(id >= KVM_MEM_SLOTS_NUM))
 		return ERR_PTR_USR(-EINVAL);
@@ -10452,6 +10495,7 @@ static void kvm_del_async_pf_gfn(struct kvm_vcpu *vcpu, gfn_t gfn)
 }
 
 static inline int apf_put_user_notpresent(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	u32 reason = KVM_PV_REASON_PAGE_NOT_PRESENT;
 
@@ -10460,6 +10504,7 @@ static inline int apf_put_user_notpresent(struct kvm_vcpu *vcpu)
 }
 
 static inline int apf_put_user_ready(struct kvm_vcpu *vcpu, u32 token)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	unsigned int offset = offsetof(struct kvm_vcpu_pv_apf_data, token);
 
@@ -10468,6 +10513,7 @@ static inline int apf_put_user_ready(struct kvm_vcpu *vcpu, u32 token)
 }
 
 static inline bool apf_pageready_slot_free(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	unsigned int offset = offsetof(struct kvm_vcpu_pv_apf_data, token);
 	u32 val;
@@ -10892,9 +10938,11 @@ static void advance_sev_es_emulated_pio(struct kvm_vcpu *vcpu, unsigned count, i
 }
 
 static int kvm_sev_es_outs(struct kvm_vcpu *vcpu, unsigned int size,
-			   unsigned int port);
+			   unsigned int port)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 static int complete_sev_es_emulated_outs(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	int size = vcpu->arch.pio.size;
 	int port = vcpu->arch.pio.port;
@@ -10928,9 +10976,11 @@ static int kvm_sev_es_outs(struct kvm_vcpu *vcpu, unsigned int size,
 }
 
 static int kvm_sev_es_ins(struct kvm_vcpu *vcpu, unsigned int size,
-			  unsigned int port);
+			  unsigned int port)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 static int complete_sev_es_emulated_ins(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	unsigned count = vcpu->arch.pio.count;
 	int size = vcpu->arch.pio.size;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 0f5919b092e4..b97b23e2b262 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -249,6 +249,7 @@ static inline bool is_noncanonical_invlpg_address(u64 la, struct kvm_vcpu *vcpu)
 
 static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
 					gva_t gva, gfn_t gfn, unsigned access)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	u64 gen = kvm_memslots(vcpu->kvm)->generation;
 
@@ -266,6 +267,7 @@ static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
 }
 
 static inline bool vcpu_match_mmio_gen(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	return vcpu->arch.mmio_gen == kvm_memslots(vcpu->kvm)->generation;
 }
@@ -285,6 +287,7 @@ static inline void vcpu_clear_mmio_info(struct kvm_vcpu *vcpu, gva_t gva)
 }
 
 static inline bool vcpu_match_mmio_gva(struct kvm_vcpu *vcpu, unsigned long gva)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (vcpu_match_mmio_gen(vcpu) && vcpu->arch.mmio_gva &&
 	      vcpu->arch.mmio_gva == (gva & PAGE_MASK))
@@ -294,6 +297,7 @@ static inline bool vcpu_match_mmio_gva(struct kvm_vcpu *vcpu, unsigned long gva)
 }
 
 static inline bool vcpu_match_mmio_gpa(struct kvm_vcpu *vcpu, gpa_t gpa)
+	__must_hold_shared(&vcpu->kvm->srcu)
 {
 	if (vcpu_match_mmio_gen(vcpu) && vcpu->arch.mmio_gfn &&
 	      vcpu->arch.mmio_gfn == gpa >> PAGE_SHIFT)
@@ -328,7 +332,8 @@ void kvm_inject_realmode_interrupt(struct kvm_vcpu *vcpu, int irq, int inc_eip);
 u64 get_kvmclock_ns(struct kvm *kvm);
 uint64_t kvm_get_wall_clock_epoch(struct kvm *kvm);
 bool kvm_get_monotonic_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp);
-int kvm_guest_time_update(struct kvm_vcpu *v);
+int kvm_guest_time_update(struct kvm_vcpu *v)
+	__must_hold_shared(&v->kvm->srcu);
 
 void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value);
 u64 kvm_scale_tsc(u64 tsc, u64 ratio);
@@ -355,13 +360,16 @@ static inline void adjust_tsc_offset_host(struct kvm_vcpu *vcpu, s64 adjustment)
 
 int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
 	gva_t addr, void *val, unsigned int bytes,
-	struct x86_exception *exception);
+	struct x86_exception *exception)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 int kvm_write_guest_virt_system(struct kvm_vcpu *vcpu,
 	gva_t addr, void *val, unsigned int bytes,
-	struct x86_exception *exception);
+	struct x86_exception *exception)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
-int handle_ud(struct kvm_vcpu *vcpu);
+int handle_ud(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu,
 				   struct kvm_queued_exception *ex);
@@ -473,7 +481,8 @@ int kvm_emulate_mwait(struct kvm_vcpu *vcpu);
 int kvm_handle_invalid_op(struct kvm_vcpu *vcpu);
 int kvm_emulate_monitor(struct kvm_vcpu *vcpu);
 
-int kvm_fast_pio(struct kvm_vcpu *vcpu, int size, unsigned short port, int in);
+int kvm_fast_pio(struct kvm_vcpu *vcpu, int size, unsigned short port, int in)
+	__must_hold_shared(&vcpu->kvm->srcu);
 int kvm_emulate_cpuid(struct kvm_vcpu *vcpu);
 int kvm_emulate_halt(struct kvm_vcpu *vcpu);
 int kvm_emulate_halt_noskip(struct kvm_vcpu *vcpu);
@@ -526,7 +535,8 @@ void kvm_inject_nmi(struct kvm_vcpu *vcpu);
 int kvm_get_nr_pending_nmis(struct kvm_vcpu *vcpu);
 
 void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
-				     u32 size);
+				     u32 size)
+	__must_hold(&kvm->slots_lock);
 int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
 
 bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu);
@@ -840,13 +850,16 @@ static inline void kvm_machine_check(void)
 int kvm_handle_memory_failure(struct kvm_vcpu *vcpu, int r,
 			      struct x86_exception *e);
 void kvm_invalidate_pcid(struct kvm_vcpu *vcpu, unsigned long pcid);
-int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva);
+int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 int kvm_sev_es_mmio(struct kvm_vcpu *vcpu, bool is_write, gpa_t gpa,
-		    unsigned int bytes, void *data);
+		    unsigned int bytes, void *data)
+	__must_hold_shared(&vcpu->kvm->srcu);
 int kvm_sev_es_string_io(struct kvm_vcpu *vcpu, unsigned int size,
 			 unsigned int port, void *data,  unsigned int count,
-			 int in);
+			 int in)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 static inline void __kvm_prepare_emulated_mmio_exit(struct kvm_vcpu *vcpu,
 						    gpa_t gpa, unsigned int len,
@@ -886,7 +899,8 @@ static inline bool user_exit_on_hypercall(struct kvm *kvm, unsigned long hc_nr)
 }
 
 int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
-			      int (*complete_hypercall)(struct kvm_vcpu *));
+			      int (*complete_hypercall)(struct kvm_vcpu *))
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 #define __kvm_emulate_hypercall(_vcpu, cpl, complete_hypercall)			\
 ({										\
@@ -898,6 +912,7 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
 	__ret;									\
 })
 
-int kvm_emulate_hypercall(struct kvm_vcpu *vcpu);
+int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
+	__must_hold_shared(&vcpu->kvm->srcu);
 
 #endif
-- 
2.55.0.1003.g10538fe699-goog

