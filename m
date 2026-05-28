Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B853E4C8A
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968208; cv=none; b=k+4bQSS5t003JuzGi/ml6qLMYokkTic7ImZSXGBl7TdQDrrzV4jQ8nlWcM522gNbQUH61TSsMCSA1p7XkdwH9N8NqnWLIAxhHXs4h5N/IaDKMiho+rUWsO6atPT6Q/JVdC9eVSMsNxyJkpxuZQCo9sCNlZCFA0IDdT0VDFj0eUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968208; c=relaxed/simple;
	bh=D5HALjg+7SU7Og/xkW3ZLo9f3TpFGJncAcMxgUD/Os4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3FyWdqd9e3OfpN1thn2bavg47W9wpTQdFH4Z5dpDhPeCtAj/uT3XVrwm55653HCuWDk0F0w5aMXpvsdwg8DyKC0R9G2Na3F7elWUL3PGrRRJ0xOatrg1W9ib2l7d40ws7vISx7p0WyUBKOw/Gru3MAEzEft7DBRa5wb4geM8RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3EF6566D81;
	Thu, 28 May 2026 11:36:45 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E93BF5AD78;
	Thu, 28 May 2026 11:36:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uBLeN8woGGqPSgAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 28 May 2026 11:36:44 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>
Subject: [PATCH v2 6/6] KVM/x86: Return -errno instead of "1" for common MSR emulation
Date: Thu, 28 May 2026 13:36:05 +0200
Message-ID: <20260528113605.267111-7-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528113605.267111-1-jgross@suse.com>
References: <20260528113605.267111-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 3EF6566D81
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

Instead of a literal "1" for signalling an error, use a negative errno
value in the common emulation code of MSR registers.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- use -errno instead of KVM_MSR_RET_ERR
---
 arch/x86/kvm/mtrr.c |   6 +--
 arch/x86/kvm/pmu.c  |   8 ++--
 arch/x86/kvm/x86.c  | 102 ++++++++++++++++++++++----------------------
 arch/x86/kvm/xen.c  |  10 ++---
 4 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/arch/x86/kvm/mtrr.c b/arch/x86/kvm/mtrr.c
index 6f74e2b27c1e..57c7cfa74a35 100644
--- a/arch/x86/kvm/mtrr.c
+++ b/arch/x86/kvm/mtrr.c
@@ -99,10 +99,10 @@ int kvm_mtrr_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 
 	mtrr = find_mtrr(vcpu, msr);
 	if (!mtrr)
-		return 1;
+		return -EINVAL;
 
 	if (!kvm_mtrr_valid(vcpu, msr, data))
-		return 1;
+		return -EINVAL;
 
 	*mtrr = data;
 	return 0;
@@ -126,7 +126,7 @@ int kvm_mtrr_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
 
 	mtrr = find_mtrr(vcpu, msr);
 	if (!mtrr)
-		return 1;
+		return -EINVAL;
 
 	*pdata = *mtrr;
 	return 0;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index e218352e3423..bc7273106f32 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -857,7 +857,7 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	switch (msr) {
 	case MSR_CORE_PERF_GLOBAL_STATUS:
 		if (!msr_info->host_initiated)
-			return 1; /* RO MSR */
+			return -EINVAL; /* RO MSR */
 		fallthrough;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
 		/* Per PPR, Read-only MSR. Writes are ignored. */
@@ -865,7 +865,7 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			break;
 
 		if (data & pmu->global_status_rsvd)
-			return 1;
+			return -EINVAL;
 
 		pmu->global_status = data;
 		break;
@@ -874,7 +874,7 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		fallthrough;
 	case MSR_CORE_PERF_GLOBAL_CTRL:
 		if (!kvm_valid_perf_global_ctrl(pmu, data))
-			return 1;
+			return -EINVAL;
 
 		if (pmu->global_ctrl != data) {
 			diff = pmu->global_ctrl ^ data;
@@ -894,7 +894,7 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		 * GLOBAL_STATUS, and so the set of reserved bits is the same.
 		 */
 		if (data & pmu->global_status_rsvd)
-			return 1;
+			return -EINVAL;
 		fallthrough;
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
 		if (!msr_info->host_initiated)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c1a72d749084..edb620631672 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -683,7 +683,7 @@ int kvm_set_user_return_msr(unsigned slot, u64 value, u64 mask)
 		return 0;
 	err = wrmsrq_safe(kvm_uret_msrs_list[slot], value);
 	if (err)
-		return 1;
+		return -EINVAL;
 
 	msrs->values[slot].curr = value;
 	kvm_user_return_register_notifier(msrs);
@@ -1859,7 +1859,7 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
 	case MSR_CSTAR:
 	case MSR_LSTAR:
 		if (is_noncanonical_msr_address(data, vcpu))
-			return 1;
+			return -EINVAL;
 		break;
 	case MSR_IA32_SYSENTER_EIP:
 	case MSR_IA32_SYSENTER_ESP:
@@ -1879,12 +1879,12 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
 		break;
 	case MSR_TSC_AUX:
 		if (!kvm_is_supported_user_return_msr(MSR_TSC_AUX))
-			return 1;
+			return -EINVAL;
 
 		if (!host_initiated &&
 		    !guest_cpu_cap_has(vcpu, X86_FEATURE_RDTSCP) &&
 		    !guest_cpu_cap_has(vcpu, X86_FEATURE_RDPID))
-			return 1;
+			return -EINVAL;
 
 		/*
 		 * Per Intel's SDM, bits 63:32 are reserved, but AMD's APM has
@@ -1896,7 +1896,7 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
 		 * provide consistent behavior for the guest.
 		 */
 		if (guest_cpuid_is_intel_compatible(vcpu) && (data >> 32) != 0)
-			return 1;
+			return -EINVAL;
 
 		data = (u32)data;
 		break;
@@ -1906,11 +1906,11 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
 		    !guest_cpu_cap_has(vcpu, X86_FEATURE_IBT))
 			return KVM_MSR_RET_UNSUPPORTED;
 		if (!kvm_is_valid_u_s_cet(vcpu, data))
-			return 1;
+			return -EINVAL;
 		break;
 	case MSR_KVM_INTERNAL_GUEST_SSP:
 		if (!host_initiated)
-			return 1;
+			return -EINVAL;
 		fallthrough;
 		/*
 		 * Note that the MSR emulation here is flawed when a vCPU
@@ -1933,10 +1933,10 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
 		if (index == MSR_IA32_INT_SSP_TAB && !guest_cpu_cap_has(vcpu, X86_FEATURE_LM))
 			return KVM_MSR_RET_UNSUPPORTED;
 		if (is_noncanonical_msr_address(data, vcpu))
-			return 1;
+			return -EINVAL;
 		/* All SSP MSRs except MSR_IA32_INT_SSP_TAB must be 4-byte aligned */
 		if (index != MSR_IA32_INT_SSP_TAB && !IS_ALIGNED(data, 4))
-			return 1;
+			return -EINVAL;
 		break;
 	}
 
@@ -1975,12 +1975,12 @@ static int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
 	switch (index) {
 	case MSR_TSC_AUX:
 		if (!kvm_is_supported_user_return_msr(MSR_TSC_AUX))
-			return 1;
+			return -EINVAL;
 
 		if (!host_initiated &&
 		    !guest_cpu_cap_has(vcpu, X86_FEATURE_RDTSCP) &&
 		    !guest_cpu_cap_has(vcpu, X86_FEATURE_RDPID))
-			return 1;
+			return -EINVAL;
 		break;
 	case MSR_IA32_U_CET:
 	case MSR_IA32_S_CET:
@@ -1990,7 +1990,7 @@ static int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
 		break;
 	case MSR_KVM_INTERNAL_GUEST_SSP:
 		if (!host_initiated)
-			return 1;
+			return -EINVAL;
 		fallthrough;
 	case MSR_IA32_PL0_SSP ... MSR_IA32_INT_SSP_TAB:
 		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK))
@@ -3944,7 +3944,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return KVM_MSR_RET_UNSUPPORTED;
 
 		if (data & ~kvm_caps.supported_perf_cap)
-			return 1;
+			return -EINVAL;
 
 		/*
 		 * Note, this is not just a performance optimization!  KVM
@@ -3963,7 +3963,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 		if (!msr_info->host_initiated) {
 			if ((!guest_has_pred_cmd_msr(vcpu)))
-				return 1;
+				return -EINVAL;
 
 			if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
 			    !guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_IBPB))
@@ -3980,7 +3980,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			reserved_bits |= PRED_CMD_SBPB;
 
 		if (data & reserved_bits)
-			return 1;
+			return -EINVAL;
 
 		if (!data)
 			break;
@@ -3991,10 +3991,10 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_FLUSH_CMD:
 		if (!msr_info->host_initiated &&
 		    !guest_cpu_cap_has(vcpu, X86_FEATURE_FLUSH_L1D))
-			return 1;
+			return -EINVAL;
 
 		if (!boot_cpu_has(X86_FEATURE_FLUSH_L1D) || (data & ~L1D_FLUSH))
-			return 1;
+			return -EINVAL;
 		if (!data)
 			break;
 
@@ -4014,19 +4014,19 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		 */
 		if (data & ~(BIT_ULL(18) | BIT_ULL(24))) {
 			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
-			return 1;
+			return -EINVAL;
 		}
 		vcpu->arch.msr_hwcr = data;
 		break;
 	case MSR_FAM10H_MMIO_CONF_BASE:
 		if (data != 0) {
 			kvm_pr_unimpl_wrmsr(vcpu, msr, data);
-			return 1;
+			return -EINVAL;
 		}
 		break;
 	case MSR_IA32_CR_PAT:
 		if (!kvm_pat_valid(data))
-			return 1;
+			return -EINVAL;
 
 		vcpu->arch.pat = data;
 		break;
@@ -4059,7 +4059,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!msr_info->host_initiated) {
 			/* RO bits */
 			if ((old_val ^ data) & MSR_IA32_MISC_ENABLE_PMU_RO_MASK)
-				return 1;
+				return -EINVAL;
 
 			/* R bits, i.e. writes are ignored, but don't fault. */
 			data = data & ~MSR_IA32_MISC_ENABLE_EMON;
@@ -4069,7 +4069,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT) &&
 		    ((old_val ^ data)  & MSR_IA32_MISC_ENABLE_MWAIT)) {
 			if (!guest_cpu_cap_has(vcpu, X86_FEATURE_XMM3))
-				return 1;
+				return -EINVAL;
 			vcpu->arch.ia32_misc_enable_msr = data;
 			vcpu->arch.cpuid_dynamic_bits_dirty = true;
 		} else {
@@ -4079,7 +4079,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	}
 	case MSR_IA32_SMBASE:
 		if (!IS_ENABLED(CONFIG_KVM_SMM) || !msr_info->host_initiated)
-			return 1;
+			return -EINVAL;
 		vcpu->arch.smbase = data;
 		break;
 	case MSR_IA32_POWER_CTL:
@@ -4099,7 +4099,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return KVM_MSR_RET_UNSUPPORTED;
 
 		if (data & ~vcpu->arch.guest_supported_xss)
-			return 1;
+			return -EINVAL;
 		if (vcpu->arch.ia32_xss == data)
 			break;
 		vcpu->arch.ia32_xss = data;
@@ -4107,7 +4107,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_SMI_COUNT:
 		if (!msr_info->host_initiated)
-			return 1;
+			return -EINVAL;
 		vcpu->arch.smi_count = data;
 		break;
 	case MSR_KVM_WALL_CLOCK_NEW:
@@ -4141,14 +4141,14 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return KVM_MSR_RET_UNSUPPORTED;
 
 		if (kvm_pv_enable_async_pf(vcpu, data))
-			return 1;
+			return -EINVAL;
 		break;
 	case MSR_KVM_ASYNC_PF_INT:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
 			return KVM_MSR_RET_UNSUPPORTED;
 
 		if (kvm_pv_enable_async_pf_int(vcpu, data))
-			return 1;
+			return -EINVAL;
 		break;
 	case MSR_KVM_ASYNC_PF_ACK:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
@@ -4168,10 +4168,10 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return KVM_MSR_RET_UNSUPPORTED;
 
 		if (unlikely(!sched_info_on()))
-			return 1;
+			return -EINVAL;
 
 		if (data & KVM_STEAL_RESERVED_MASK)
-			return 1;
+			return -EINVAL;
 
 		vcpu->arch.st.msr_val = data;
 
@@ -4186,7 +4186,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return KVM_MSR_RET_UNSUPPORTED;
 
 		if (kvm_lapic_set_pv_eoi(vcpu, data, sizeof(u8)))
-			return 1;
+			return -EINVAL;
 		break;
 
 	case MSR_KVM_POLL_CONTROL:
@@ -4195,7 +4195,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 		/* only enable bit supported */
 		if (data & (-1ULL << 1))
-			return 1;
+			return -EINVAL;
 
 		vcpu->arch.msr_kvm_poll_control = data;
 		break;
@@ -4248,44 +4248,44 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_AMD64_OSVW_ID_LENGTH:
 		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_OSVW))
-			return 1;
+			return -EINVAL;
 		vcpu->arch.osvw.length = data;
 		break;
 	case MSR_AMD64_OSVW_STATUS:
 		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_OSVW))
-			return 1;
+			return -EINVAL;
 		vcpu->arch.osvw.status = data;
 		break;
 	case MSR_PLATFORM_INFO:
 		if (!msr_info->host_initiated)
-			return 1;
+			return -EINVAL;
 		vcpu->arch.msr_platform_info = data;
 		break;
 	case MSR_MISC_FEATURES_ENABLES:
 		if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
 		    (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
 		     !supports_cpuid_fault(vcpu)))
-			return 1;
+			return -EINVAL;
 		vcpu->arch.msr_misc_features_enables = data;
 		break;
 #ifdef CONFIG_X86_64
 	case MSR_IA32_XFD:
 		if (!msr_info->host_initiated &&
 		    !guest_cpu_cap_has(vcpu, X86_FEATURE_XFD))
-			return 1;
+			return -EINVAL;
 
 		if (data & ~kvm_guest_supported_xfd(vcpu))
-			return 1;
+			return -EINVAL;
 
 		fpu_update_guest_xfd(&vcpu->arch.guest_fpu, data);
 		break;
 	case MSR_IA32_XFD_ERR:
 		if (!msr_info->host_initiated &&
 		    !guest_cpu_cap_has(vcpu, X86_FEATURE_XFD))
-			return 1;
+			return -EINVAL;
 
 		if (data & ~kvm_guest_supported_xfd(vcpu))
-			return 1;
+			return -EINVAL;
 
 		vcpu->arch.guest_fpu.xfd_err = data;
 		break;
@@ -4321,7 +4321,7 @@ static int get_msr_mce(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
 		break;
 	case MSR_IA32_MCG_CTL:
 		if (!(mcg_cap & MCG_CTL_P) && !host)
-			return 1;
+			return -EINVAL;
 		data = vcpu->arch.mcg_ctl;
 		break;
 	case MSR_IA32_MCG_STATUS:
@@ -4330,10 +4330,10 @@ static int get_msr_mce(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
 	case MSR_IA32_MC0_CTL2 ... MSR_IA32_MCx_CTL2(KVM_MAX_MCE_BANKS) - 1:
 		last_msr = MSR_IA32_MCx_CTL2(bank_num) - 1;
 		if (msr > last_msr)
-			return 1;
+			return -EINVAL;
 
 		if (!(mcg_cap & MCG_CMCI_P) && !host)
-			return 1;
+			return -EINVAL;
 		offset = array_index_nospec(msr - MSR_IA32_MC0_CTL2,
 					    last_msr + 1 - MSR_IA32_MC0_CTL2);
 		data = vcpu->arch.mci_ctl2_banks[offset];
@@ -4341,14 +4341,14 @@ static int get_msr_mce(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
 	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1:
 		last_msr = MSR_IA32_MCx_CTL(bank_num) - 1;
 		if (msr > last_msr)
-			return 1;
+			return -EINVAL;
 
 		offset = array_index_nospec(msr - MSR_IA32_MC0_CTL,
 					    last_msr + 1 - MSR_IA32_MC0_CTL);
 		data = vcpu->arch.mce_banks[offset];
 		break;
 	default:
-		return 1;
+		return -EINVAL;
 	}
 	*pdata = data;
 	return 0;
@@ -4475,7 +4475,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_SMBASE:
 		if (!IS_ENABLED(CONFIG_KVM_SMM) || !msr_info->host_initiated)
-			return 1;
+			return -EINVAL;
 		msr_info->data = vcpu->arch.smbase;
 		break;
 	case MSR_SMI_COUNT:
@@ -4562,7 +4562,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_XSS:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))
-			return 1;
+			return -EINVAL;
 		msr_info->data = vcpu->arch.ia32_xss;
 		break;
 	case MSR_K7_CLK_CTL:
@@ -4607,18 +4607,18 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_AMD64_OSVW_ID_LENGTH:
 		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_OSVW))
-			return 1;
+			return -EINVAL;
 		msr_info->data = vcpu->arch.osvw.length;
 		break;
 	case MSR_AMD64_OSVW_STATUS:
 		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_OSVW))
-			return 1;
+			return -EINVAL;
 		msr_info->data = vcpu->arch.osvw.status;
 		break;
 	case MSR_PLATFORM_INFO:
 		if (!msr_info->host_initiated &&
 		    !vcpu->kvm->arch.guest_can_read_msr_platform_info)
-			return 1;
+			return -EINVAL;
 		msr_info->data = vcpu->arch.msr_platform_info;
 		break;
 	case MSR_MISC_FEATURES_ENABLES:
@@ -4631,14 +4631,14 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_XFD:
 		if (!msr_info->host_initiated &&
 		    !guest_cpu_cap_has(vcpu, X86_FEATURE_XFD))
-			return 1;
+			return -EINVAL;
 
 		msr_info->data = vcpu->arch.guest_fpu.fpstate->xfd;
 		break;
 	case MSR_IA32_XFD_ERR:
 		if (!msr_info->host_initiated &&
 		    !guest_cpu_cap_has(vcpu, X86_FEATURE_XFD))
-			return 1;
+			return -EINVAL;
 
 		msr_info->data = vcpu->arch.guest_fpu.xfd_err;
 		break;
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 91fd3673c09a..d7bcd59603f7 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1291,7 +1291,7 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 		 */
 		if (kvm->arch.xen.shinfo_cache.active &&
 		    kvm_xen_shared_info_init(kvm))
-			r = 1;
+			r = -EINVAL;
 	}
 	mutex_unlock(&kvm->arch.xen.xen_lock);
 
@@ -1309,7 +1309,7 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 		int i;
 
 		if (page_num)
-			return 1;
+			return -EINVAL;
 
 		/* mov imm32, %eax */
 		instructions[0] = 0xb8;
@@ -1328,7 +1328,7 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 			if (kvm_vcpu_write_guest(vcpu,
 						 page_addr + (i * sizeof(instructions)),
 						 instructions, sizeof(instructions)))
-				return 1;
+				return -EFAULT;
 		}
 	} else {
 		/*
@@ -1343,7 +1343,7 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 		int ret;
 
 		if (page_num >= blob_size)
-			return 1;
+			return -EINVAL;
 
 		blob_addr += page_num * PAGE_SIZE;
 
@@ -1354,7 +1354,7 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 		ret = kvm_vcpu_write_guest(vcpu, page_addr, page, PAGE_SIZE);
 		kfree(page);
 		if (ret)
-			return 1;
+			return -EFAULT;
 	}
 	return 0;
 }
-- 
2.54.0

