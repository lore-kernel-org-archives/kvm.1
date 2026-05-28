Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34003E0730
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966871; cv=none; b=q62Q/rBpbigO8LNqVfKdFLcC/TE6h0t0M/m5uQEkDGNZu84hbxe9YUokdlOkoRrhCPjWquRXv6PUiMZu9ZmTc9+hhpMHhUWIuv9ohAbMidqK2GGOjS2OPrwozVq4MaiImbDQquFYBmHdx+GvD2wrPbMWUpxJ/Yflz5hyMaN+EAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966871; c=relaxed/simple;
	bh=7f5srVmH0Xx0XEVGgWQLheUGHQMkiUXvXlV4c4bqp74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9RozeVNnShfYF4ToIOwOkgdE0uyrYEXUyPT4238fkOOv8lH5956Leiossq7v/+DLT8OYqjKiciYpnaGep9USflRJyEi8Ot0+nRN/L/kD8zqzA3eQa40s2yUBQbo/cdKxhGcFbWIp2gBUs0dW9iRHzl9Sx55IxBf9jKGGmhQKGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KnA3uXOJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NuhpXqAu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KnA3uXOJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NuhpXqAu"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EAA426AFE9;
	Thu, 28 May 2026 11:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779966868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MAdbQ14wwNd5QTrRHnWRpm3W34C4IvV7gYCGkiD+Grs=;
	b=KnA3uXOJ/DRdG4O4V/40Hc0ltd7OrKNou/3ADMrzGlltszI4E/nzI2Y6ZkmURZkAesPPpv
	gkIiCtzfByTosobK1kQgE4Bh+Ws23ixcKYhW5zYQO46R+DvL77UCZhBFNmi87uUH9tv+tX
	LQBD8kpMIuNyj3VJqe5W1jtOrV1AKGI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779966867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MAdbQ14wwNd5QTrRHnWRpm3W34C4IvV7gYCGkiD+Grs=;
	b=NuhpXqAuNZpLT99iqstdHg8SqwaCrXrI8xE4D+ggrpXawvLQYgtEehBYQaVgHye0s7trvn
	0wdl4fMUOD0hnh8IMbH6Q1n+OliZMWs2l32F3cg0yB6iA6cczb+e3N24j51kg0HCSsqx6R
	jpBXEmfOIuM+jg4FuQeYTxIaAA+kh8s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABCC55AD61;
	Thu, 28 May 2026 11:14:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pgPiKJMjGGrkMgAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 28 May 2026 11:14:27 +0000
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
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 5/5] KVM/x86: Return -errno instead of "1" for SVM related MSR emulation
Date: Thu, 28 May 2026 13:13:57 +0200
Message-ID: <20260528111357.264809-6-jgross@suse.com>
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
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	RCVD_TLS_ALL(0.00)[]

Instead of a literal "1" for signalling an error, use a negative errno
value in the emulation code of SVM related MSR registers.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- use -errno instead of KVM_MSR_RET_ERR
---
 arch/x86/kvm/svm/pmu.c |  4 ++--
 arch/x86/kvm/svm/svm.c | 36 ++++++++++++++++++------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 7aa298eeb072..1c325d602baa 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -144,7 +144,7 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		return 0;
 	}
 
-	return 1;
+	return -EINVAL;
 }
 
 static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
@@ -173,7 +173,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		return 0;
 	}
 
-	return 1;
+	return -EINVAL;
 }
 
 static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e02a38da5296..f8d9df822ab3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2791,7 +2791,7 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_TSC_RATIO:
 		if (!msr_info->host_initiated &&
 		    !guest_cpu_cap_has(vcpu, X86_FEATURE_TSCRATEMSR))
-			return 1;
+			return -EINVAL;
 		msr_info->data = svm->tsc_ratio_msr;
 		break;
 	case MSR_STAR:
@@ -2860,7 +2860,7 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
 		    !guest_has_spec_ctrl_msr(vcpu))
-			return 1;
+			return -EINVAL;
 
 		if (boot_cpu_has(X86_FEATURE_V_SPEC_CTRL))
 			msr_info->data = svm->vmcb->save.spec_ctrl;
@@ -2870,7 +2870,7 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_VIRT_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
 		    !guest_cpu_cap_has(vcpu, X86_FEATURE_VIRT_SSBD))
-			return 1;
+			return -EINVAL;
 
 		msr_info->data = svm->virt_spec_ctrl;
 		break;
@@ -2907,7 +2907,7 @@ static int svm_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
 		return kvm_complete_insn_gp(vcpu, err);
 
 	svm_vmgexit_inject_exception(svm, X86_TRAP_GP);
-	return 1;
+	return -EINVAL;
 }
 
 static int svm_set_vm_cr(struct kvm_vcpu *vcpu, u64 data)
@@ -2916,7 +2916,7 @@ static int svm_set_vm_cr(struct kvm_vcpu *vcpu, u64 data)
 	int svm_dis, chg_mask;
 
 	if (data & ~SVM_VM_CR_VALID_MASK)
-		return 1;
+		return -EINVAL;
 
 	chg_mask = SVM_VM_CR_VALID_MASK;
 
@@ -2930,7 +2930,7 @@ static int svm_set_vm_cr(struct kvm_vcpu *vcpu, u64 data)
 
 	/* check for svm_disable while efer.svme is set */
 	if (svm_dis && (vcpu->arch.efer & EFER_SVME))
-		return 1;
+		return -EINVAL;
 
 	return 0;
 }
@@ -2952,7 +2952,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_TSCRATEMSR)) {
 
 			if (!msr->host_initiated)
-				return 1;
+				return -EINVAL;
 			/*
 			 * In case TSC scaling is not enabled, always
 			 * leave this MSR at the default value.
@@ -2962,12 +2962,12 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 			 * Ignore this value as well.
 			 */
 			if (data != 0 && data != svm->tsc_ratio_msr)
-				return 1;
+				return -EINVAL;
 			break;
 		}
 
 		if (data & SVM_TSC_RATIO_RSVD)
-			return 1;
+			return -EINVAL;
 
 		svm->tsc_ratio_msr = data;
 
@@ -2989,10 +2989,10 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr->host_initiated &&
 		    !guest_has_spec_ctrl_msr(vcpu))
-			return 1;
+			return -EINVAL;
 
 		if (kvm_spec_ctrl_test_value(data))
-			return 1;
+			return -EINVAL;
 
 		if (boot_cpu_has(X86_FEATURE_V_SPEC_CTRL))
 			svm->vmcb->save.spec_ctrl = data;
@@ -3017,10 +3017,10 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	case MSR_AMD64_VIRT_SPEC_CTRL:
 		if (!msr->host_initiated &&
 		    !guest_cpu_cap_has(vcpu, X86_FEATURE_VIRT_SSBD))
-			return 1;
+			return -EINVAL;
 
 		if (data & ~SPEC_CTRL_SSBD)
-			return 1;
+			return -EINVAL;
 
 		svm->virt_spec_ctrl = data;
 		break;
@@ -3115,7 +3115,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		}
 
 		if (data & DEBUGCTL_RESERVED_BITS)
-			return 1;
+			return -EINVAL;
 
 		if (svm->vmcb->save.dbgctl == data)
 			break;
@@ -3131,7 +3131,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		if (!lbrv)
 			return KVM_MSR_RET_UNSUPPORTED;
 		if (!msr->host_initiated)
-			return 1;
+			return -EINVAL;
 		*svm_vmcb_lbr(svm, ecx) = data;
 		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
 		break;
@@ -3143,7 +3143,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		 * originating from those kernels.
 		 */
 		if (!msr->host_initiated && !page_address_valid(vcpu, data))
-			return 1;
+			return -EINVAL;
 
 		svm->nested.hsave_msr = data & PAGE_MASK;
 		break;
@@ -3156,10 +3156,10 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		u64 supported_de_cfg;
 
 		if (svm_get_feature_msr(ecx, &supported_de_cfg))
-			return 1;
+			return -EINVAL;
 
 		if (data & ~supported_de_cfg)
-			return 1;
+			return -EINVAL;
 
 		svm->msr_decfg = data;
 		break;
-- 
2.54.0

