Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A3E38C425
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 23:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775519150; cv=none; b=cHfKRlLerTNVIG5Ls02KOxPs2lrCpN46K3gNmpswlq1n9OCsvJ6A6JGVqtQT9m5w9xYYXgKObMd6nVTdp0gM1rS8R71cGcvhqg2IGTvchIV8fFWybX9WdOjDgibSk1usrlnyA98KXZPflBnzvAYVZmlVNcZXjJNHCNzUYXrULqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775519150; c=relaxed/simple;
	bh=1GmhpUqf9fO7s3hkyN4u7j21yvNbJ4m/clW3o8hdXtU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JMh7Sd+iOkAJzXdGNacFPKps29aJo/8dMljnKuTAxhb3EfGAPLu7mFDYIn5beQJlzjnmUCsn+LPGlhg7xE6NA2zYRhFmS/FutkaApaVp7UO7wZIf7+KfVkpOBSiOYaH6Yh7RGS40fGjLFwk0jjGftGHcHchE04mtEh+lFgL/33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NbnTGzBN; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NbnTGzBN"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c89d4ce16so2907276b3a.2
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 16:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775519147; x=1776123947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmHv/QRdWjNmCOrnWn7i4BRsME4bDU1VH+TmtPQWX9I=;
        b=NbnTGzBNXO8gq1aTaXXhZJ7Uvgo80Q5Db/iOsPZ6h/CBcsX9iiv+Vq+7BzKY9y1U1Z
         K2Qm6BZneL6//Ou0L7sYEeRSngjCMtmquqp7mxjCL/RYEWYylAqy+JWfd2j+Wkt9lLT3
         t3geZPyZT/4W7Q6lyMNRr/qp5mifHJvsF4nmucZ11TNCoO2/0oyjoro7lL1kjJdTKBlT
         /jyafMtbg5GEmauLa5YiLPc2IHzxtGkdRI02yvAkqwNeouZXZCY6pKrE0H+Z8jCphy4B
         CJbXU4BXItl9awx4P5D+cY/D6/5ZziFijhA2wa8e3UhA0ab23RLeCzeTTMfTo1IFctEv
         jKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775519147; x=1776123947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmHv/QRdWjNmCOrnWn7i4BRsME4bDU1VH+TmtPQWX9I=;
        b=rfZiE2EzYi/wuRtboRelW1za9ojCCfGR3fPLTJexE+WVITWyrlVUZcoMCaoX/8CgrM
         J6K711HacLDLn0VzCLiFlZaUQYk9Cp99lJ3k4y7X+tyzvc0hWFRQAwSM6uYocLu9q6ph
         Al3dg16kBGQUugUKA1Zw+bR2X6pi6i82N/ml3a044O4ey2LIbneN7J3MA5xp/mGfgfAJ
         Ys3bgQpfLRXJA3XpmoKwfNLPYca2N6RIOh9s8oDQeqVBvyg2HI/OlgTsfkNywwjLxS4y
         Yiv86b1u0ENRAlXl+NyQLAGOU90bS1NjQmsZIwAllc4iqxXU7d+7O9WaHluiCZGKboqi
         Jsqg==
X-Forwarded-Encrypted: i=1; AJvYcCUJMapoY9WoigkOjfXTksILuzxFnTEkACnCt/Y376cixw2pkXNaOmUoXauKCMpK7ydvTSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy00tNfAJWuEww5XMzEA/fkre6HHDAP+rNt8vr+fIJ7N9MR5N6T
	BpEhfi43mm+b6lGoX/5ug58tvYs+QGGt8aoAPEUH3N9F3WIIIVwmPaA4EGsiudHt9rXXjFCrKAm
	CDuC+jQ==
X-Received: from pfbkq19.prod.google.com ([2002:a05:6a00:4b13:b0:829:93d2:8904])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8008:b0:82c:6c90:c76d
 with SMTP id d2e1a72fcca58-82d0dbac80amr13317782b3a.46.1775519147003; Mon, 06
 Apr 2026 16:45:47 -0700 (PDT)
Date: Mon, 6 Apr 2026 16:45:45 -0700
In-Reply-To: <20260327234023.2659476-6-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327234023.2659476-1-jmattson@google.com> <20260327234023.2659476-6-jmattson@google.com>
Message-ID: <adRFqdTKAtfzPMnG@google.com>
Subject: Re: [PATCH v7 5/9] KVM: x86: nSVM: Redirect IA32_PAT accesses to
 either hPAT or gPAT
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 27, 2026, Jim Mattson wrote:
> When KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled and the vCPU is in
> guest mode with nested NPT enabled, guest accesses to IA32_PAT are
> redirected to the gPAT register, which is stored in VMCB02's g_pat field.
> 
> Non-guest accesses (e.g. from userspace) to IA32_PAT are always redirected
> to hPAT, which is stored in vcpu->arch.pat.
> 
> Directing host-initiated accesses to hPAT ensures that KVM_GET/SET_MSRS and
> KVM_GET/SET_NESTED_STATE are independent of each other and can be ordered
> arbitrarily during save and restore. gPAT is saved and restored separately
> via KVM_GET/SET_NESTED_STATE.
> 
> Use WARN_ON_ONCE to flag any host-initiated accesses originating from KVM
> itself rather than userspace.
> 
> Use pr_warn_once to flag any use of the common MSR-handling code (now
> shared by VMX and TDX) for IA32_PAT by a vCPU that is SVM-capable.
> 
> Fixes: 15038e147247 ("KVM: SVM: obey guest PAT")
> Signed-off-by: Jim Mattson <jmattson@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/nested.c |  9 -------
>  arch/x86/kvm/svm/svm.c    | 53 ++++++++++++++++++++++++++++++++++-----
>  arch/x86/kvm/svm/svm.h    |  1 -
>  arch/x86/kvm/x86.c        |  6 +++++
>  4 files changed, 53 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 8170042d5fb3..ccc556eb4d2f 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -703,15 +703,6 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
>  	return 0;
>  }
>  
> -void nested_vmcb02_compute_g_pat(struct vcpu_svm *svm)
> -{
> -	if (!svm->nested.vmcb02.ptr)
> -		return;
> -
> -	/* FIXME: merge g_pat from vmcb01 and vmcb12.  */
> -	vmcb_set_gpat(svm->nested.vmcb02.ptr, svm->vmcb01.ptr->save.g_pat);
> -}
> -
>  static bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
>  {
>  	return guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index af808e83173e..34fd07d6ad4d 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2776,6 +2776,47 @@ static bool sev_es_prevent_msr_access(struct kvm_vcpu *vcpu,
>  	       !msr_write_intercepted(vcpu, msr_info->index);
>  }
>  
> +static bool svm_pat_accesses_gpat(struct kvm_vcpu *vcpu, bool from_host)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +
> +	/*
> +	 * When nested NPT is enabled, L2 has a separate PAT from L1.  Guest

Hmm, do we also want to add "and KVM's quirk is disabled"?

	/*
	 * When nested NPT is enabled and KVM's quirk is disabled, L2 has a
	 * separate PAT from L1.  Guest accesses to IA32_PAT while running L2
	 * target L2's gPAT; host-initiated accesses always target L1's hPAT so
	 * that KVM_GET/SET_MSRS and KVM_GET/SET_NESTED_STATE are independent
	 * of each other and can be ordered arbitrarily during save and restore.
	 */

> +	 * accesses to IA32_PAT while running L2 target L2's gPAT;
> +	 * host-initiated accesses always target L1's hPAT so that
> +	 * KVM_GET/SET_MSRS and KVM_GET/SET_NESTED_STATE are independent of
> +	 * each other and can be ordered arbitrarily during save and restore.
> +	 */
> +	WARN_ON_ONCE(from_host && vcpu->wants_to_run);
> +	return !from_host && is_guest_mode(vcpu) && l2_has_separate_pat(svm);
> +}
> +
> +static u64 svm_get_pat(struct kvm_vcpu *vcpu, bool from_host)
> +{
> +	if (svm_pat_accesses_gpat(vcpu, from_host))
> +		return to_svm(vcpu)->vmcb->save.g_pat;
> +	else
> +		return vcpu->arch.pat;
> +}
> +
> +static void svm_set_pat(struct kvm_vcpu *vcpu, bool from_host, u64 data)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +
> +	if (svm_pat_accesses_gpat(vcpu, from_host)) {
> +		vmcb_set_gpat(svm->vmcb, data);
> +		return;
> +	}
> +
> +	svm->vcpu.arch.pat = data;
> +
> +	if (npt_enabled) {
> +		vmcb_set_gpat(svm->vmcb01.ptr, data);
> +		if (is_guest_mode(&svm->vcpu) && !l2_has_separate_pat(svm))
> +			vmcb_set_gpat(svm->vmcb, data);
> +	}
> +}
> +
>  static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
> @@ -2892,6 +2933,9 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_AMD64_DE_CFG:
>  		msr_info->data = svm->msr_decfg;
>  		break;
> +	case MSR_IA32_CR_PAT:
> +		msr_info->data = svm_get_pat(vcpu, msr_info->host_initiated);
> +		break;
>  	default:
>  		return kvm_get_msr_common(vcpu, msr_info);
>  	}
> @@ -2975,13 +3019,10 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  
>  		break;
>  	case MSR_IA32_CR_PAT:
> -		ret = kvm_set_msr_common(vcpu, msr);
> -		if (ret)
> -			break;
> +		if (!kvm_pat_valid(data))
> +			return 1;
>  
> -		vmcb_set_gpat(svm->vmcb01.ptr, data);
> -		if (is_guest_mode(vcpu))
> -			nested_vmcb02_compute_g_pat(svm);
> +		svm_set_pat(vcpu, msr->host_initiated, data);
>  		break;
>  	case MSR_IA32_SPEC_CTRL:
>  		if (!msr->host_initiated &&
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index b43e37b0448c..0b0279734486 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -868,7 +868,6 @@ void nested_copy_vmcb_control_to_cache(struct vcpu_svm *svm,
>  void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
>  				    struct vmcb_save_area *save);
>  void nested_sync_control_from_vmcb02(struct vcpu_svm *svm);
> -void nested_vmcb02_compute_g_pat(struct vcpu_svm *svm);
>  void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb);
>  
>  extern struct kvm_x86_nested_ops svm_nested_ops;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0b5d48e75b65..cfb2517f692a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4025,6 +4025,9 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		}
>  		break;
>  	case MSR_IA32_CR_PAT:
> +		if (!(efer_reserved_bits & EFER_SVME))
> +			pr_warn_once("%s: MSR_IA32_CR_PAT should be handled by AMD vendor-specific code\n", __func__);

If we want to add a sanity check, simply do

		WARN_ON_ONCE(efer_reserved_bits & EFER_SVME)?

so that bugs fail loudly.

Hrm.  Though I'm leaning towards saying we should keep the "common" behavior in
x86.c.  If VMX and TDX didn't need to add get() APIs, I would say move the common
code to vmx/common.h, but that ends up being pretty ugly.

If we do that, the total diff for svm.c is quite nice.  Duplicating the
kvm_pat_valid() sucks, but it seems like the lesser of all evils :-/

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e7fdd7a9c280..6281599d5311 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2767,6 +2767,21 @@ static bool sev_es_prevent_msr_access(struct kvm_vcpu *vcpu,
               !msr_write_intercepted(vcpu, msr_info->index);
 }
 
+static bool svm_pat_accesses_gpat(struct kvm_vcpu *vcpu, bool from_host)
+{
+       struct vcpu_svm *svm = to_svm(vcpu);
+
+       /*
+        * When nested NPT is enabled, L2 has a separate PAT from L1.  Guest
+        * accesses to IA32_PAT while running L2 target L2's gPAT;
+        * host-initiated accesses always target L1's hPAT so that
+        * KVM_GET/SET_MSRS and KVM_GET/SET_NESTED_STATE are independent of
+        * each other and can be ordered arbitrarily during save and restore.
+        */
+       WARN_ON_ONCE(from_host && vcpu->wants_to_run);
+       return !from_host && is_guest_mode(vcpu) && l2_has_separate_pat(svm);
+}
+
 static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
        struct vcpu_svm *svm = to_svm(vcpu);
@@ -2883,6 +2898,12 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
        case MSR_AMD64_DE_CFG:
                msr_info->data = svm->msr_decfg;
                break;
+       case MSR_IA32_CR_PAT:
+               if (svm_pat_accesses_gpat(vcpu, msr_info->host_initiated)) {
+                       msr_info->data = to_svm(vcpu)->vmcb->save.g_pat;
+                       break;
+               }
+               return kvm_get_msr_common(vcpu, msr_info);
        default:
                return kvm_get_msr_common(vcpu, msr_info);
        }
@@ -2966,14 +2987,23 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 
                break;
        case MSR_IA32_CR_PAT:
+               if (svm_pat_accesses_gpat(vcpu, msr->host_initiated)) {
+                       if (kvm_pat_valid(data))
+                               return 1;
+
+                       vmcb_set_gpat(svm->vmcb, data);
+                       break;
+               }
+
                ret = kvm_set_msr_common(vcpu, msr);
                if (ret)
                        break;
 
-               svm->vmcb01.ptr->save.g_pat = data;
-               if (is_guest_mode(vcpu))
-                       nested_vmcb02_compute_g_pat(svm);
-               vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
+               if (npt_enabled) {
+                       vmcb_set_gpat(svm->vmcb01.ptr, data);
+                       if (is_guest_mode(&svm->vcpu) && !l2_has_separate_pat(svm))
+                               vmcb_set_gpat(svm->vmcb, data);
+               }
                break;
        case MSR_IA32_SPEC_CTRL:
                if (!msr->host_initiated &&

> +
>  		if (!kvm_pat_valid(data))
>  			return 1;
>  
> @@ -4436,6 +4439,9 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		break;
>  	}
>  	case MSR_IA32_CR_PAT:
> +		if (!(efer_reserved_bits & EFER_SVME))
> +			pr_warn_once("%s: MSR_IA32_CR_PAT should be handled by AMD vendor-specific code\n", __func__);

And obviously the same here..

> +
>  		msr_info->data = vcpu->arch.pat;
>  		break;
>  	case MSR_MTRRcap:
> -- 
> 2.53.0.1018.g2bb0e51243-goog
> 
