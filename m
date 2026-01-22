Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1785B328B56
	for <kvm@vger.kernel.org>; Thu, 22 Jan 2026 01:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046890; cv=none; b=hk9baFDp36vithUkA4AHPTmsukWanC3aAhgAMhnNLwvAoKSf17S8HY+kzrAKUNeodCPyudBBEGBta2zkMIc1uQM8XMEIHBGSYbJUzipJfL3AXQ9vPcQgpOyXwH1hgaRsHlCY4DE35m8YcD+V4rVus1zo9oi+Bo5hR4duZ+TivAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046890; c=relaxed/simple;
	bh=9CHejTIkSvIOr8hdKUWa4ZQwIJO3qAcjD9z3ijURVgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlAICKL4edOIs0SOIJ8kAu8VR5JqPal3pWSpDfGvp+Ptrstx0tEp10lJY7jh9VpWxHzTm93YhOZQ5oN9XY+ZOYtXqrGDNrMrXAV69CqvwnMFnR79XckBS4rs+XX71On4+BIFkQ8foVDmc+Lo+EqxEiiJGOXtQyCKC5ccoSdluag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tqSlSD5q; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tqSlSD5q"
Date: Thu, 22 Jan 2026 01:54:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769046887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3FADtjDRNC5Zb8yoHTgprxMeVlzMfpAC0C5YPyUk0hY=;
	b=tqSlSD5qC6eR5CO7mvLWvwW841rsSAbWCOydAYbBrJd6eS9QoQZoLECgSm6hBXkD0CVv1s
	fKoyRhnCGnc+CGgC2FRBlgjyGbJ5JbfQhUYHAz9epSXoruIP2r3OVHZQQ2f1nEeDGjpKNQ
	AG8Ynvtz5f00Qyp9zwLuagFltW5MeCU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/8] KVM: x86: nSVM: Set vmcb02.g_pat correctly for
 nested NPT
Message-ID: <kj7lqm5dsyaywgbpykat5iuy6lr25xb4myxuw73zrekgo6fdzk@pfvq24hkexyx>
References: <20260115232154.3021475-1-jmattson@google.com>
 <20260115232154.3021475-5-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115232154.3021475-5-jmattson@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 15, 2026 at 03:21:43PM -0800, Jim Mattson wrote:
> When nested NPT is enabled in vmcb12, copy the (cached and validated)
> vmcb12 g_pat field to the guest PAT register. Under KVM, the guest PAT
> register lives in the vmcb02 g_pat field.
> 
> When NPT is enabled, but nested NPT is disabled, copy L1's IA32_PAT MSR to
> the vmcb02 g_pat field, since L2 shares the IA32_PAT MSR with L1,
> 
> When NPT is disabled, the vmcb02 g_pat field is ignored by hardware.
> 
> Fixes: 15038e147247 ("KVM: SVM: obey guest PAT")
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/svm/nested.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index e65291434be9..b0c0184e6e24 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -656,9 +656,6 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
>  	struct vmcb *vmcb02 = svm->nested.vmcb02.ptr;
>  	struct kvm_vcpu *vcpu = &svm->vcpu;
>  
> -	nested_vmcb02_compute_g_pat(svm);

This is last use of the function, right? Should we drop it now?

> -	vmcb_mark_dirty(vmcb02, VMCB_NPT);
> -
>  	/* Load the nested guest state */
>  	if (svm->nested.vmcb12_gpa != svm->nested.last_vmcb12_gpa) {
>  		new_vmcb12 = true;
> @@ -666,6 +663,19 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
>  		svm->nested.force_msr_bitmap_recalc = true;
>  	}
>  
> +	if (npt_enabled) {
> +		if (nested_npt_enabled(svm)) {
> +			if (unlikely(new_vmcb12 ||
> +				     vmcb_is_dirty(vmcb12, VMCB_NPT))) {
> +				vmcb02->save.g_pat = svm->nested.save.g_pat;
> +				vmcb_mark_dirty(vmcb02, VMCB_NPT);
> +			}
> +		} else {
> +			vmcb02->save.g_pat = vcpu->arch.pat;
> +			vmcb_mark_dirty(vmcb02, VMCB_NPT);
> +		}
> +	}
> +
>  	if (unlikely(new_vmcb12 || vmcb_is_dirty(vmcb12, VMCB_SEG))) {
>  		vmcb02->save.es = vmcb12->save.es;
>  		vmcb02->save.cs = vmcb12->save.cs;
> -- 
> 2.52.0.457.g6b5491de43-goog
> 
