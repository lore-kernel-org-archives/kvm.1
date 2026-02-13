Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C423155C97
	for <kvm@vger.kernel.org>; Fri, 13 Feb 2026 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770942160; cv=none; b=AnT6GQ6AQadGVrMPf6Ac5sxs7v/39M3YCXjlRD6ZTWqnqWMu+qXLlIeUgkZg8mZMX6Jjp5pY8Fie28t7SI9XPcL9zrcOntCc1+LayW60EmsxokOVsLfwZ0tbT+9pJOpg+Mjz4w8EqLlgdLlg2z9jm2URGtwVOuYn4qHHvozZJWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770942160; c=relaxed/simple;
	bh=m42u3rxuqwa9/+0Zvo1orMIwN0VXCrh+y/mSnOEWwro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9oBCkut7w9bP09k5HBrQMLRoKb22WpnRgb9T5sWsrclnfN9OcHzk7aZSowiffQXVP0CGdauzyTpT73h3cOft7PU3j+3cZDGpqhm6WxwgtxhPsDYvvw/K/QDW9bNCxSob7vee094W7u0nI7Prf+xQgxo/zz1khbSDseg2nNUarA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DL2BCdue; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DL2BCdue"
Date: Fri, 13 Feb 2026 00:22:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770942157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yU1FYWSjiIRXq9/AGoROper71Z6i27jTjJmHbsvlDD4=;
	b=DL2BCdueDxk/9Wy8VU0QCAG6wy+5Bm0aXd9QWfunhN+Q9jn3qU+sOPKM8Rs+/2GZtjTXvV
	eJE58bL7x4b2yEi7jW/bcJHMFrKnEZ2ppRlGM0+zxylwtbfA5LFQi2RsmwOsBauHedC/hL
	IYBUH/E73kuJ6s/UmLMCwti4WG5cNBI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 2/8] KVM: x86: nSVM: Cache and validate vmcb12 g_pat
Message-ID: <y2c76qtfmwgy4ncypthcm25wedlapwknjnfyptu62qmlbdqa7k@udzmtcddsmwa>
References: <20260212155905.3448571-1-jmattson@google.com>
 <20260212155905.3448571-3-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212155905.3448571-3-jmattson@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 12, 2026 at 07:58:50AM -0800, Jim Mattson wrote:
> Cache g_pat from vmcb12 in vmcb_save_area_cached to avoid TOCTTOU issues,
> and add a validity check so that when nested paging is enabled for vmcb12,
> an invalid g_pat at emulated VMRUN causes an immediate VMEXIT with exit
> code VMEXIT_INVALID, as specified in the APM, volume 2: "Nested Paging and
> VMRUN/VMEXIT."
> 
> Fixes: 3d6368ef580a ("KVM: SVM: Add VMRUN handler")
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/svm/nested.c | 17 +++++++++++++----
>  arch/x86/kvm/svm/svm.h    |  1 +
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index b72a1f3c4144..91b35adb83f8 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -426,7 +426,8 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
>  
>  /* Common checks that apply to both L1 and L2 state.  */
>  static bool nested_vmcb_check_save(struct kvm_vcpu *vcpu,
> -				   struct vmcb_save_area_cached *save)
> +				   struct vmcb_save_area_cached *save,
> +				   bool check_gpat)
>  {
>  	if (CC(!(save->efer & EFER_SVME)))
>  		return false;
> @@ -462,6 +463,9 @@ static bool nested_vmcb_check_save(struct kvm_vcpu *vcpu,
>  	if (CC(!kvm_valid_efer(vcpu, save->efer)))
>  		return false;
>  
> +	if (check_gpat && CC(!kvm_pat_valid(save->g_pat)))
> +		return false;
> +
>  	return true;
>  }
>  
> @@ -573,6 +577,7 @@ static void __nested_copy_vmcb_save_to_cache(struct vmcb_save_area_cached *to,
>  
>  	to->rax = from->rax;
>  	to->cr2 = from->cr2;
> +	to->g_pat = from->g_pat;
>  
>  	svm_copy_lbrs(to, from);
>  }
> @@ -1036,7 +1041,8 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa, bool from_vmrun)
>  
>  	enter_guest_mode(vcpu);
>  
> -	if (!nested_vmcb_check_save(vcpu, &svm->nested.save) ||
> +	if (!nested_vmcb_check_save(vcpu, &svm->nested.save,
> +				    nested_npt_enabled(svm)) ||
>  	    !nested_vmcb_check_controls(vcpu, &svm->nested.ctl,
>  					svm->vmcb01.ptr->save.cr0))
>  		return -EINVAL;
> @@ -2006,13 +2012,16 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
>  
>  	/*
>  	 * Validate host state saved from before VMRUN (see
> -	 * nested_svm_check_permissions).
> +	 * nested_svm_check_permissions). Note that the g_pat field is not
> +	 * validated, because (a) it may have been clobbered by SMM before
> +	 * KVM_GET_NESTED_STATE, and (b) it is not loaded at emulated
> +	 * #VMEXIT.

(b) here means that svm_copy_vmrun_state() does not copy it to vmcb01,
and the value is restored by KVM_SET_MSRS, right?

If my understanding is correct:

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

>  	 */
>  	__nested_copy_vmcb_save_to_cache(&save_cached, save);
>  	if (!(save->cr0 & X86_CR0_PG) ||
>  	    !(save->cr0 & X86_CR0_PE) ||
>  	    (save->rflags & X86_EFLAGS_VM) ||
> -	    !nested_vmcb_check_save(vcpu, &save_cached))
> +	    !nested_vmcb_check_save(vcpu, &save_cached, false))
>  		goto out_free;
>  
>  
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 9850ed01e16e..a49c48459e0b 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -161,6 +161,7 @@ struct vmcb_save_area_cached {
>  	u64 isst_addr;
>  	u64 rax;
>  	u64 cr2;
> +	u64 g_pat;
>  	u64 dbgctl;
>  	u64 br_from;
>  	u64 br_to;
> -- 
> 2.53.0.239.g8d8fc8a987-goog
> 
