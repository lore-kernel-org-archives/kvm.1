Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A613E0C66
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966866; cv=none; b=Cl8JoYcxiG6dvAD+xsTibChf2ZDTeUcMLLUBzpJiKkO2oMDqcQur2p+05FLEyLc+qrBufS4oC4pb3udPJ4Wko6KkvTRHhZWNLq6ZJMHA1B/iPdRePbLt6jaEdpZo4Ji3Gt/KFOAYkKXPv9APzDF2Edy1x3+Kf4cko7DrFZ+j44I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966866; c=relaxed/simple;
	bh=m9d+7c85/6AA7n1Y3SufmsyrJZT30Ju59L4xiYM0eEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcfJVzwicqgbQLlqozKrufHqwAd5BnJX0Kl9qOsjRDNk3beRGsDsHYdNECyhXaFVwlvhXe5LCAXUBR/UtRLKte0MFLxbBpU0xeOEtwsinPcSYGzvDx+iOB0qNxuxu4yHCd3NLlExbY/BUDRf20R8q/Jx5V8Mm2kg9CQfKu8VnVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EoopqUq1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EoopqUq1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EoopqUq1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EoopqUq1"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 606BE66E71;
	Thu, 28 May 2026 11:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779966862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEeoYf36DgkNjRbVgvgO3600/eMNP6CHaFTWurqUvl4=;
	b=EoopqUq1/HALCKZBzKSd+hIjSDB7hc7w6sXcAq1ZVUhaxBvXGWSxljBv6xPTPgrG4jBob3
	wv8rw/YWfTljSpJIeE2u/CHLXomud5/Q5EHQ1wiPtyKuZ69Duojzmv19nAJ4yv5A0hRRtd
	ss3j+wpOIConwaVWuDC1/fSXwdip2gE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=EoopqUq1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779966862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEeoYf36DgkNjRbVgvgO3600/eMNP6CHaFTWurqUvl4=;
	b=EoopqUq1/HALCKZBzKSd+hIjSDB7hc7w6sXcAq1ZVUhaxBvXGWSxljBv6xPTPgrG4jBob3
	wv8rw/YWfTljSpJIeE2u/CHLXomud5/Q5EHQ1wiPtyKuZ69Duojzmv19nAJ4yv5A0hRRtd
	ss3j+wpOIConwaVWuDC1/fSXwdip2gE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1273A5AD61;
	Thu, 28 May 2026 11:14:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zI4yA44jGGrMMgAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 28 May 2026 11:14:22 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v2 4/5] KVM/x86: Return -errno instead of "1" for VMX related MSR emulation
Date: Thu, 28 May 2026 13:13:56 +0200
Message-ID: <20260528111357.264809-5-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528111357.264809-1-jgross@suse.com>
References: <20260528111357.264809-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 606BE66E71
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:email,suse.com:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]

Instead of a literal "1" for signalling an error, use a negative errno
value in the emulation code of VMX related MSR registers.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- use -errno instead of KVM_MSR_RET_ERR
---
 arch/x86/kvm/vmx/nested.c    |  2 +-
 arch/x86/kvm/vmx/pmu_intel.c | 16 +++---
 arch/x86/kvm/vmx/tdx.c       | 10 ++--
 arch/x86/kvm/vmx/vmx.c       | 96 ++++++++++++++++++------------------
 4 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 3fe88f29be7a..2236f15ffab2 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1611,7 +1611,7 @@ int vmx_get_vmx_msr(struct nested_vmx_msrs *msrs, u32 msr_index, u64 *pdata)
 		*pdata = msrs->vmfunc_controls;
 		break;
 	default:
-		return 1;
+		return -EINVAL;
 	}
 
 	return 0;
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 27eb76e6b6a0..4f7e354c4b50 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -362,7 +362,7 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		} else if (intel_pmu_handle_lbr_msrs_access(vcpu, msr_info, true)) {
 			break;
 		}
-		return 1;
+		return -EINVAL;
 	}
 
 	return 0;
@@ -379,14 +379,14 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	switch (msr) {
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		if (data & pmu->fixed_ctr_ctrl_rsvd)
-			return 1;
+			return -EINVAL;
 
 		if (pmu->fixed_ctr_ctrl != data)
 			reprogram_fixed_counters(pmu, data);
 		break;
 	case MSR_IA32_PEBS_ENABLE:
 		if (data & pmu->pebs_enable_rsvd)
-			return 1;
+			return -EINVAL;
 
 		if (pmu->pebs_enable != data) {
 			diff = pmu->pebs_enable ^ data;
@@ -396,13 +396,13 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_DS_AREA:
 		if (is_noncanonical_msr_address(data, vcpu))
-			return 1;
+			return -EINVAL;
 
 		pmu->ds_area = data;
 		break;
 	case MSR_PEBS_DATA_CFG:
 		if (data & pmu->pebs_data_cfg_rsvd)
-			return 1;
+			return -EINVAL;
 
 		pmu->pebs_data_cfg = data;
 		break;
@@ -411,7 +411,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		    (pmc = get_gp_pmc(pmu, msr, MSR_IA32_PMC0))) {
 			if ((msr & MSR_PMC_FULL_WIDTH_BIT) &&
 			    (data & ~pmu->counter_bitmask[KVM_PMC_GP]))
-				return 1;
+				return -EINVAL;
 
 			if (!msr_info->host_initiated &&
 			    !(msr & MSR_PMC_FULL_WIDTH_BIT))
@@ -427,7 +427,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			    (pmu->raw_event_mask & HSW_IN_TX_CHECKPOINTED))
 				reserved_bits ^= HSW_IN_TX_CHECKPOINTED;
 			if (data & reserved_bits)
-				return 1;
+				return -EINVAL;
 
 			if (data != pmc->eventsel) {
 				pmc->eventsel = data;
@@ -439,7 +439,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			break;
 		}
 		/* Not a known PMU MSR. */
-		return 1;
+		return -EINVAL;
 	}
 
 	return 0;
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 04ce321ebdf3..acc3242af4f4 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2158,12 +2158,12 @@ int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		return 0;
 	case MSR_IA32_MCG_EXT_CTL:
 		if (!msr->host_initiated && !(vcpu->arch.mcg_cap & MCG_LMCE_P))
-			return 1;
+			return -EINVAL;
 		msr->data = vcpu->arch.mcg_ext_ctl;
 		return 0;
 	default:
 		if (!tdx_has_emulated_msr(msr->index))
-			return 1;
+			return -EACCES;
 
 		return kvm_get_msr_common(vcpu, msr);
 	}
@@ -2175,15 +2175,15 @@ int tdx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	case MSR_IA32_MCG_EXT_CTL:
 		if ((!msr->host_initiated && !(vcpu->arch.mcg_cap & MCG_LMCE_P)) ||
 		    (msr->data & ~MCG_EXT_CTL_LMCE_EN))
-			return 1;
+			return -EINVAL;
 		vcpu->arch.mcg_ext_ctl = msr->data;
 		return 0;
 	default:
 		if (tdx_is_read_only_msr(msr->index))
-			return 1;
+			return -EACCES;
 
 		if (!tdx_has_emulated_msr(msr->index))
-			return 1;
+			return -EACCES;
 
 		return kvm_set_msr_common(vcpu, msr);
 	}
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b9103de01428..2eee599fca30 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2076,7 +2076,7 @@ int vmx_get_feature_msr(u32 msr, u64 *data)
 	switch (msr) {
 	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
 		if (!nested)
-			return 1;
+			return -EINVAL;
 		return vmx_get_vmx_msr(&vmcs_config.nested, msr, data);
 	default:
 		return KVM_MSR_RET_UNSUPPORTED;
@@ -2111,18 +2111,18 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_TSX_CTRL:
 		if (!msr_info->host_initiated &&
 		    !(vcpu->arch.arch_capabilities & ARCH_CAP_TSX_CTRL_MSR))
-			return 1;
+			return -EINVAL;
 		goto find_uret_msr;
 	case MSR_IA32_UMWAIT_CONTROL:
 		if (!msr_info->host_initiated && !vmx_has_waitpkg(vmx))
-			return 1;
+			return -EINVAL;
 
 		msr_info->data = vmx->msr_ia32_umwait_control;
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
 		    !guest_has_spec_ctrl_msr(vcpu))
-			return 1;
+			return -EINVAL;
 
 		msr_info->data = to_vmx(vcpu)->spec_ctrl;
 		break;
@@ -2139,14 +2139,14 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!kvm_mpx_supported() ||
 		    (!msr_info->host_initiated &&
 		     !guest_cpu_cap_has(vcpu, X86_FEATURE_MPX)))
-			return 1;
+			return -EINVAL;
 		msr_info->data = vmcs_read64(GUEST_BNDCFGS);
 		break;
 	case MSR_IA32_MCG_EXT_CTL:
 		if (!msr_info->host_initiated &&
 		    !(vmx->msr_ia32_feature_control &
 		      FEAT_CTL_LMCE_ENABLED))
-			return 1;
+			return -EINVAL;
 		msr_info->data = vcpu->arch.mcg_ext_ctl;
 		break;
 	case MSR_IA32_FEAT_CTL:
@@ -2155,16 +2155,16 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_SGXLEPUBKEYHASH0 ... MSR_IA32_SGXLEPUBKEYHASH3:
 		if (!msr_info->host_initiated &&
 		    !guest_cpu_cap_has(vcpu, X86_FEATURE_SGX_LC))
-			return 1;
+			return -EINVAL;
 		msr_info->data = to_vmx(vcpu)->msr_ia32_sgxlepubkeyhash
 			[msr_info->index - MSR_IA32_SGXLEPUBKEYHASH0];
 		break;
 	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
 		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_VMX))
-			return 1;
+			return -EINVAL;
 		if (vmx_get_vmx_msr(&vmx->nested.msrs, msr_info->index,
 				    &msr_info->data))
-			return 1;
+			return -EINVAL;
 #ifdef CONFIG_KVM_HYPERV
 		/*
 		 * Enlightened VMCS v1 doesn't have certain VMCS fields but
@@ -2180,19 +2180,19 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_RTIT_CTL:
 		if (!vmx_pt_mode_is_host_guest())
-			return 1;
+			return -EINVAL;
 		msr_info->data = vmx->pt_desc.guest.ctl;
 		break;
 	case MSR_IA32_RTIT_STATUS:
 		if (!vmx_pt_mode_is_host_guest())
-			return 1;
+			return -EINVAL;
 		msr_info->data = vmx->pt_desc.guest.status;
 		break;
 	case MSR_IA32_RTIT_CR3_MATCH:
 		if (!vmx_pt_mode_is_host_guest() ||
 			!intel_pt_validate_cap(vmx->pt_desc.caps,
 						PT_CAP_cr3_filtering))
-			return 1;
+			return -EINVAL;
 		msr_info->data = vmx->pt_desc.guest.cr3_match;
 		break;
 	case MSR_IA32_RTIT_OUTPUT_BASE:
@@ -2201,7 +2201,7 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 					PT_CAP_topa_output) &&
 			 !intel_pt_validate_cap(vmx->pt_desc.caps,
 					PT_CAP_single_range_output)))
-			return 1;
+			return -EINVAL;
 		msr_info->data = vmx->pt_desc.guest.output_base;
 		break;
 	case MSR_IA32_RTIT_OUTPUT_MASK:
@@ -2210,14 +2210,14 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 					PT_CAP_topa_output) &&
 			 !intel_pt_validate_cap(vmx->pt_desc.caps,
 					PT_CAP_single_range_output)))
-			return 1;
+			return -EINVAL;
 		msr_info->data = vmx->pt_desc.guest.output_mask;
 		break;
 	case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
 		index = msr_info->index - MSR_IA32_RTIT_ADDR0_A;
 		if (!vmx_pt_mode_is_host_guest() ||
 		    (index >= 2 * vmx->pt_desc.num_address_ranges))
-			return 1;
+			return -EINVAL;
 		if (index % 2)
 			msr_info->data = vmx->pt_desc.guest.addr_b[index / 2];
 		else
@@ -2359,7 +2359,7 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_DEBUGCTLMSR:
 		if (!vmx_is_valid_debugctl(vcpu, data, msr_info->host_initiated))
-			return 1;
+			return -EINVAL;
 
 		data &= vmx_get_supported_debugctl(vcpu, msr_info->host_initiated);
 
@@ -2377,10 +2377,10 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!kvm_mpx_supported() ||
 		    (!msr_info->host_initiated &&
 		     !guest_cpu_cap_has(vcpu, X86_FEATURE_MPX)))
-			return 1;
+			return -EINVAL;
 		if (is_noncanonical_msr_address(data & PAGE_MASK, vcpu) ||
 		    (data & MSR_IA32_BNDCFGS_RSVD))
-			return 1;
+			return -EINVAL;
 
 		if (is_guest_mode(vcpu) &&
 		    ((vmx->nested.msrs.entry_ctls_high & VM_ENTRY_LOAD_BNDCFGS) ||
@@ -2391,21 +2391,21 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_UMWAIT_CONTROL:
 		if (!msr_info->host_initiated && !vmx_has_waitpkg(vmx))
-			return 1;
+			return -EINVAL;
 
 		/* The reserved bit 1 and non-32 bit [63:32] should be zero */
 		if (data & (BIT_ULL(1) | GENMASK_ULL(63, 32)))
-			return 1;
+			return -EINVAL;
 
 		vmx->msr_ia32_umwait_control = data;
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
 		    !guest_has_spec_ctrl_msr(vcpu))
-			return 1;
+			return -EINVAL;
 
 		if (kvm_spec_ctrl_test_value(data))
-			return 1;
+			return -EINVAL;
 
 		vmx->spec_ctrl = data;
 		if (!data)
@@ -2430,9 +2430,9 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_TSX_CTRL:
 		if (!msr_info->host_initiated &&
 		    !(vcpu->arch.arch_capabilities & ARCH_CAP_TSX_CTRL_MSR))
-			return 1;
+			return -EINVAL;
 		if (data & ~(TSX_CTRL_RTM_DISABLE | TSX_CTRL_CPUID_CLEAR))
-			return 1;
+			return -EINVAL;
 		goto find_uret_msr;
 	case MSR_IA32_CR_PAT:
 		ret = kvm_set_msr_common(vcpu, msr_info);
@@ -2451,12 +2451,12 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		     !(to_vmx(vcpu)->msr_ia32_feature_control &
 		       FEAT_CTL_LMCE_ENABLED)) ||
 		    (data & ~MCG_EXT_CTL_LMCE_EN))
-			return 1;
+			return -EINVAL;
 		vcpu->arch.mcg_ext_ctl = data;
 		break;
 	case MSR_IA32_FEAT_CTL:
 		if (!is_vmx_feature_control_msr_valid(vmx, msr_info))
-			return 1;
+			return -EINVAL;
 
 		vmx->msr_ia32_feature_control = data;
 		if (msr_info->host_initiated && data == 0)
@@ -2481,70 +2481,70 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		    (!guest_cpu_cap_has(vcpu, X86_FEATURE_SGX_LC) ||
 		    ((vmx->msr_ia32_feature_control & FEAT_CTL_LOCKED) &&
 		    !(vmx->msr_ia32_feature_control & FEAT_CTL_SGX_LC_ENABLED))))
-			return 1;
+			return -EINVAL;
 		vmx->msr_ia32_sgxlepubkeyhash
 			[msr_index - MSR_IA32_SGXLEPUBKEYHASH0] = data;
 		break;
 	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
 		if (!msr_info->host_initiated)
-			return 1; /* they are read-only */
+			return -EINVAL; /* they are read-only */
 		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_VMX))
-			return 1;
+			return -EINVAL;
 		return vmx_set_vmx_msr(vcpu, msr_index, data);
 	case MSR_IA32_RTIT_CTL:
 		if (!vmx_pt_mode_is_host_guest() ||
 			vmx_rtit_ctl_check(vcpu, data) ||
 			vmx->nested.vmxon)
-			return 1;
+			return -EINVAL;
 		vmcs_write64(GUEST_IA32_RTIT_CTL, data);
 		vmx->pt_desc.guest.ctl = data;
 		pt_update_intercept_for_msr(vcpu);
 		break;
 	case MSR_IA32_RTIT_STATUS:
 		if (!pt_can_write_msr(vmx))
-			return 1;
+			return -EINVAL;
 		if (data & MSR_IA32_RTIT_STATUS_MASK)
-			return 1;
+			return -EINVAL;
 		vmx->pt_desc.guest.status = data;
 		break;
 	case MSR_IA32_RTIT_CR3_MATCH:
 		if (!pt_can_write_msr(vmx))
-			return 1;
+			return -EINVAL;
 		if (!intel_pt_validate_cap(vmx->pt_desc.caps,
 					   PT_CAP_cr3_filtering))
-			return 1;
+			return -EINVAL;
 		vmx->pt_desc.guest.cr3_match = data;
 		break;
 	case MSR_IA32_RTIT_OUTPUT_BASE:
 		if (!pt_can_write_msr(vmx))
-			return 1;
+			return -EINVAL;
 		if (!intel_pt_validate_cap(vmx->pt_desc.caps,
 					   PT_CAP_topa_output) &&
 		    !intel_pt_validate_cap(vmx->pt_desc.caps,
 					   PT_CAP_single_range_output))
-			return 1;
+			return -EINVAL;
 		if (!pt_output_base_valid(vcpu, data))
-			return 1;
+			return -EINVAL;
 		vmx->pt_desc.guest.output_base = data;
 		break;
 	case MSR_IA32_RTIT_OUTPUT_MASK:
 		if (!pt_can_write_msr(vmx))
-			return 1;
+			return -EINVAL;
 		if (!intel_pt_validate_cap(vmx->pt_desc.caps,
 					   PT_CAP_topa_output) &&
 		    !intel_pt_validate_cap(vmx->pt_desc.caps,
 					   PT_CAP_single_range_output))
-			return 1;
+			return -EINVAL;
 		vmx->pt_desc.guest.output_mask = data;
 		break;
 	case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
 		if (!pt_can_write_msr(vmx))
-			return 1;
+			return -EINVAL;
 		index = msr_info->index - MSR_IA32_RTIT_ADDR0_A;
 		if (index >= 2 * vmx->pt_desc.num_address_ranges)
-			return 1;
+			return -EINVAL;
 		if (is_noncanonical_msr_address(data, vcpu))
-			return 1;
+			return -EINVAL;
 		if (index % 2)
 			vmx->pt_desc.guest.addr_b[index / 2] = data;
 		else
@@ -2563,20 +2563,20 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (data & PERF_CAP_LBR_FMT) {
 			if ((data & PERF_CAP_LBR_FMT) !=
 			    (kvm_caps.supported_perf_cap & PERF_CAP_LBR_FMT))
-				return 1;
+				return -EINVAL;
 			if (!cpuid_model_is_consistent(vcpu))
-				return 1;
+				return -EINVAL;
 		}
 		if (data & PERF_CAP_PEBS_FORMAT) {
 			if ((data & PERF_CAP_PEBS_MASK) !=
 			    (kvm_caps.supported_perf_cap & PERF_CAP_PEBS_MASK))
-				return 1;
+				return -EINVAL;
 			if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DS))
-				return 1;
+				return -EINVAL;
 			if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DTES64))
-				return 1;
+				return -EINVAL;
 			if (!cpuid_model_is_consistent(vcpu))
-				return 1;
+				return -EINVAL;
 		}
 		ret = kvm_set_msr_common(vcpu, msr_info);
 		break;
-- 
2.54.0

