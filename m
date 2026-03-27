Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244AF3A1E66
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774654840; cv=none; b=Gqtj49n2UuM8MACjvHO2NsVWcMD7uKJwsFGgT6LamtjIW6l3+CnjVy0oJzNSc1L1guSentegxqhmalrLHp7/3ShGemx+b6FeQpjR0WUprKEhUiyFKQmhS/fFmuDFf3ull0/EHH0jbeIp6fR7F1mJHGp0h1OOSZMmn5Zptv8ksls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774654840; c=relaxed/simple;
	bh=OuR5MnB8UCFuMwjbw9rq52TUW4H3/Wius8t683uVsjc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=snoV4B9hDajnhYrJ5d8gkzjWAQMYyI5NjNEvVBHAo/rON8xhXiW1Z6DRbsyivZpuPtd9CYsxyelyDYYV9q45bj++U4YvSHMqI0SEU1YhN3TSSIkSeYJya3ub9MYQ3pocKHA0sr+R9qTF1hPTT3PvjVKkzqld+Le9YVCU1HPqL44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GENvC0uo; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GENvC0uo"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35d9467e85aso158159a91.0
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 16:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774654837; x=1775259637; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7y5HwBTSkwgoBBimZJGgWbMuctVLczxWfxP1tKWmKTY=;
        b=GENvC0uocV7kZaorplM7AuKAW/NO3vXV/4eXpLzfG6Lu4u5XBKAxWdnMe5Mi9RfOXc
         So3bQpiHlQSriHyws3SvFq3Ge1W1nAg8jAyZ83FFYqgo32sdlWm7KpAwweOm3Y7AwEUN
         DtVgfEJh9Zr9U0xWtKklZPHmOmQyMp/BacLrFCCFiMUCaWcawc5KshUsevYyi4yhBh07
         cwLOK+LYlMGUer3pP80oEkE+bQlfNNpvDnoa60XAQYbXzM4wExs96X1Jk9yneWZqcGke
         SaVnX7FpADi6cbt88ubO88vy41HVBtwotJQGvqtXq1K9bKS21f/WUp/ODdo8NM7GjmKr
         +YNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774654837; x=1775259637;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7y5HwBTSkwgoBBimZJGgWbMuctVLczxWfxP1tKWmKTY=;
        b=W7MnYNKo9Bk/4WODkzXI3ck0vqD/kox5JYrwUPEtexcpCpgGlSNpqjXtiC/T/pTvfd
         fWIwapM6eyMR8y9KT+Wj19qEyC6cgq6Yxd0MNaySnRHD8Z4LkYV+J2x/Hh5uAU8+oAko
         DnBSbiniIohCrbl2TEOwjLXmM1/PJdydMa7dTo5Tw9EOcubVHfPmwl6MYF3MqVKTplUv
         /1uS+Dbpqqz8TZA6BsAt+25XvZPMBjBnX4urxHdiXizvvftKAkTmwv/NFiyou7F1oND8
         W/KNTmK8SkM2exKsKjibu6oPRrN67OkWhJP2klMaWamH80tDePmD0DfLS108DYq2Uovq
         VLQg==
X-Forwarded-Encrypted: i=1; AJvYcCVIeNKmzHezEbmSJtgEBoRQuYCVwhF2TlM7TDdQrygwFbljC5iFheuM6YyNoJK/Pv8ZVV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIzZl0M+eel26NdYHYV6PLRHDRX7H/ysnT0D9FnaMOX1y3If3b
	DAWP43aoL8y1ztl1wp8WCtRxqSqDJYYWU1P5hdWJ1+TWLAFZzrAKXQ3dte+i/W0fo85C5TPzKPA
	VjdJCuXTphpic7Q==
X-Received: from pjbhv24.prod.google.com ([2002:a17:90a:e418:b0:35d:9373:e7d3])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3b4f:b0:35c:cba:3453 with SMTP id 98e67ed59e1d1-35c30076fe2mr4269476a91.22.1774654837106;
 Fri, 27 Mar 2026 16:40:37 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:40:12 -0700
In-Reply-To: <20260327234023.2659476-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327234023.2659476-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327234023.2659476-6-jmattson@google.com>
Subject: [PATCH v7 5/9] KVM: x86: nSVM: Redirect IA32_PAT accesses to either
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

Use WARN_ON_ONCE to flag any host-initiated accesses originating from KVM
itself rather than userspace.

Use pr_warn_once to flag any use of the common MSR-handling code (now
shared by VMX and TDX) for IA32_PAT by a vCPU that is SVM-capable.

Fixes: 15038e147247 ("KVM: SVM: obey guest PAT")
Signed-off-by: Jim Mattson <jmattson@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c |  9 -------
 arch/x86/kvm/svm/svm.c    | 53 ++++++++++++++++++++++++++++++++++-----
 arch/x86/kvm/svm/svm.h    |  1 -
 arch/x86/kvm/x86.c        |  6 +++++
 4 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 8170042d5fb3..ccc556eb4d2f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -703,15 +703,6 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
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
index af808e83173e..34fd07d6ad4d 100644
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
+		if (is_guest_mode(&svm->vcpu) && !l2_has_separate_pat(svm))
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
index b43e37b0448c..0b0279734486 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -868,7 +868,6 @@ void nested_copy_vmcb_control_to_cache(struct vcpu_svm *svm,
 void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
 				    struct vmcb_save_area *save);
 void nested_sync_control_from_vmcb02(struct vcpu_svm *svm);
-void nested_vmcb02_compute_g_pat(struct vcpu_svm *svm);
 void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb);
 
 extern struct kvm_x86_nested_ops svm_nested_ops;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0b5d48e75b65..cfb2517f692a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4025,6 +4025,9 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		}
 		break;
 	case MSR_IA32_CR_PAT:
+		if (!(efer_reserved_bits & EFER_SVME))
+			pr_warn_once("%s: MSR_IA32_CR_PAT should be handled by AMD vendor-specific code\n", __func__);
+
 		if (!kvm_pat_valid(data))
 			return 1;
 
@@ -4436,6 +4439,9 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	}
 	case MSR_IA32_CR_PAT:
+		if (!(efer_reserved_bits & EFER_SVME))
+			pr_warn_once("%s: MSR_IA32_CR_PAT should be handled by AMD vendor-specific code\n", __func__);
+
 		msr_info->data = vcpu->arch.pat;
 		break;
 	case MSR_MTRRcap:
-- 
2.53.0.1018.g2bb0e51243-goog

