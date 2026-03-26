Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC9039E196
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547410; cv=none; b=VJ7LsR0voHyqlaZTwLSh4lQJVI0/tnxhQAJyUpl4LU2p5U9AAQzqCnaKhbiUpYbAFY/0ryvbMVhFsBt2ewjV5d0SRsriifK6AG/H8ToONPyV1Vv7ag6jVl6GoHos4MLJIcS40dm7+6XnwqYXo/MRonOiBje1f2Iku1E9pthjL4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547410; c=relaxed/simple;
	bh=X62HksLg050YL9v3riIZda6b41B7umKzI21DaTgbf/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U34L3Vm3mOmrPcVt/btlvixQ4XQOZyXxKF1DHpzw30ovKRKEOPS7GbiWb0fne4K9MVYYcyrg1unIny1hEcK65uWiGr+l1QrPFSWA2lG+HQsHKcdZjBbSQ5ZhSRkLJvgiiRVvJg8kzZKE0mjYyt0vRBT8Na+PN33PdjtX+6pER3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JjWmzHeT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JjWmzHeT"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c74217894d9so831719a12.2
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 10:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774547408; x=1775152208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A9S2mDvA0dSmiYZiR+DNxsk39toXNnVepGluK15UcSI=;
        b=JjWmzHeTVfG0PLNnrvcQFZ5T6HiSSZmY4UB434zas6nYQTepL5rtQ6PFNla9QyGs50
         vffP5EbcM0loWJuT+w8/nINFkaZGiMz4FV2QPlVKL1sN5pIZbYT8t9z77mFUw0hnPpGw
         ECHUrHkDpHY67DtaZNn2e20XY8mohiQR6gDfoEBQkr9OAEmJXxypgD3hlM8kmjS9u3xD
         G1+7ARZH9medELUmDBSABgiAjaJGP7bb4drDnIn59XbTGTq7X97bczzindkjt6j+4/il
         U33i2uMvxKfkv89990FWJLm/RJ3sVEj30wz8AArNE8YW05qBED6N/MbutqbfrCk64G82
         n6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774547408; x=1775152208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9S2mDvA0dSmiYZiR+DNxsk39toXNnVepGluK15UcSI=;
        b=jsTHr79Au+2DdVPp+sBGWk16rBpc4Lo5tw6Eatf1D+C9UKsmNyIQQxzBj7zOjouIaL
         H2qvwZETipmYvxp4wg4xgZ9mUxwlvVI0ifpx1P0uCwdDB/AZCWRzPv9fnBvF2+s2fQ5z
         o3RQ3Y5PyD2l9qqguuTnJjjejocI5vl7vQKeW9HNjVtsEMIHtpTtJmrZ52WuHVD5V1af
         pUQlmMrDDXQIY6hf37pZpHv9eKuqfZPb9Pw0UtxMdrn1v1XpdGAuXDcWD4PObS35KpBn
         qcB/QblRxLWYYxXBKkK7c0eey7npge4rNpM/3UCEvFAfDTfCSX4DOi5s5eVE9J+HkkKa
         Xurg==
X-Forwarded-Encrypted: i=1; AJvYcCWS/z2pjMHpRbW8o7T1nzFLKxh+eiuML8OyLCzHlD1a4mtPNnJv9Fxt2hw8S5P07TRhz+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhk7BlORxBJmOsGaHPKxhDO4NmbpK7vX+YxeWx28th8BO61rGG
	tdEWOZRqyCERZEi8Cc364chcXOgFh++px49SLwhb+IL5dsts8MffQLHRSCXcjWR6q93Td9D7KgM
	8nzS6jOQeCa+JPQ==
X-Received: from pgww20.prod.google.com ([2002:a05:6a02:2c94:b0:c76:681a:7042])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:748a:b0:398:a060:a97b with SMTP id adf61e73a8af0-39c4aa57082mr9347105637.1.1774547407685;
 Thu, 26 Mar 2026 10:50:07 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:49:23 -0700
In-Reply-To: <20260326174944.3820245-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326174944.3820245-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326174944.3820245-6-jmattson@google.com>
Subject: [PATCH v6 05/10] KVM: x86: nSVM: Redirect IA32_PAT accesses to either
 hPAT or gPAT
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

When KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled and the vCPU is in
guest mode with nested NPT enabled, guest accesses to IA32_PAT are
redirected to the gPAT register, which is stored in VMCB02's g_pat field.

Non-guest accesses (e.g. from userspace) to IA32_PAT are always redirected
to hPAT, which is stored in vcpu->arch.pat.

Directing host-initiated accesses to hPAT ensures that KVM_GET/SET_MSRS and
KVM_GET/SET_NESTED_STATE are independent of each other and can be ordered
arbitrarily during save and restore. gPAT is saved and restored separately
via KVM_GET/SET_NESTED_STATE.

Add WARN_ON_ONCE to flag any host-initiated accesses originating from KVM
itself rather than userspace.

Fixes: 15038e147247 ("KVM: SVM: obey guest PAT")
Signed-off-by: Jim Mattson <jmattson@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c |  9 -------
 arch/x86/kvm/svm/svm.c    | 53 ++++++++++++++++++++++++++++++++++-----
 arch/x86/kvm/svm/svm.h    |  1 -
 3 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 405209f8c4cd..14063bef36f1 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -697,15 +697,6 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 	return 0;
 }
 
-void nested_vmcb02_compute_g_pat(struct vcpu_svm *svm)
-{
-	if (!svm->nested.vmcb02.ptr)
-		return;
-
-	/* FIXME: merge g_pat from vmcb01 and vmcb12.  */
-	vmcb_set_gpat(svm->nested.vmcb02.ptr, svm->vmcb01.ptr->save.g_pat);
-}
-
 static bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
 {
 	return guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index af808e83173e..6cf5fa87b4d4 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2776,6 +2776,47 @@ static bool sev_es_prevent_msr_access(struct kvm_vcpu *vcpu,
 	       !msr_write_intercepted(vcpu, msr_info->index);
 }
 
+static bool svm_pat_accesses_gpat(struct kvm_vcpu *vcpu, bool from_host)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	/*
+	 * When nested NPT is enabled, L2 has a separate PAT from L1.  Guest
+	 * accesses to IA32_PAT while running L2 target L2's gPAT;
+	 * host-initiated accesses always target L1's hPAT so that
+	 * KVM_GET/SET_MSRS and KVM_GET/SET_NESTED_STATE are independent of
+	 * each other and can be ordered arbitrarily during save and restore.
+	 */
+	WARN_ON_ONCE(from_host && vcpu->wants_to_run);
+	return !from_host && is_guest_mode(vcpu) && l2_has_separate_pat(svm);
+}
+
+static u64 svm_get_pat(struct kvm_vcpu *vcpu, bool from_host)
+{
+	if (svm_pat_accesses_gpat(vcpu, from_host))
+		return to_svm(vcpu)->vmcb->save.g_pat;
+	else
+		return vcpu->arch.pat;
+}
+
+static void svm_set_pat(struct kvm_vcpu *vcpu, bool from_host, u64 data)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (svm_pat_accesses_gpat(vcpu, from_host)) {
+		vmcb_set_gpat(svm->vmcb, data);
+		return;
+	}
+
+	svm->vcpu.arch.pat = data;
+
+	if (npt_enabled) {
+		vmcb_set_gpat(svm->vmcb01.ptr, data);
+		if (is_guest_mode(&svm->vcpu) && !nested_npt_enabled(svm))
+			vmcb_set_gpat(svm->vmcb, data);
+	}
+}
+
 static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -2892,6 +2933,9 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_DE_CFG:
 		msr_info->data = svm->msr_decfg;
 		break;
+	case MSR_IA32_CR_PAT:
+		msr_info->data = svm_get_pat(vcpu, msr_info->host_initiated);
+		break;
 	default:
 		return kvm_get_msr_common(vcpu, msr_info);
 	}
@@ -2975,13 +3019,10 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 
 		break;
 	case MSR_IA32_CR_PAT:
-		ret = kvm_set_msr_common(vcpu, msr);
-		if (ret)
-			break;
+		if (!kvm_pat_valid(data))
+			return 1;
 
-		vmcb_set_gpat(svm->vmcb01.ptr, data);
-		if (is_guest_mode(vcpu))
-			nested_vmcb02_compute_g_pat(svm);
+		svm_set_pat(vcpu, msr->host_initiated, data);
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr->host_initiated &&
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 3588f6d3fb9b..220b8cb0c80f 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -864,7 +864,6 @@ void nested_copy_vmcb_control_to_cache(struct vcpu_svm *svm,
 void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
 				    struct vmcb_save_area *save);
 void nested_sync_control_from_vmcb02(struct vcpu_svm *svm);
-void nested_vmcb02_compute_g_pat(struct vcpu_svm *svm);
 void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb);
 
 extern struct kvm_x86_nested_ops svm_nested_ops;
-- 
2.53.0.1018.g2bb0e51243-goog

