Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B327128816
	for <kvm@vger.kernel.org>; Fri, 13 Feb 2026 00:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770941849; cv=none; b=I8yFGmZOZdhoVfcshRdAKgFFEmJfeGctYnsPxxSE8YjzDbG6ZfH4aBiPjLd7wRK4a9D9/eEcPTmPydeXLOwFexJ87osdKvZ5fNMdzTxxxrgs3wgWtkQrxmnPG5EhSFUV/u9kSwyUF4iUIf2l7tbSgb50O9UnEkZMwfFrUW0vnBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770941849; c=relaxed/simple;
	bh=RflqIWVthJfeDZ2gIeA+bvUFvUd96/pAwLr1jaVWUD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nn6hXzoUM6x6DL0aA6gYND+rHToOqSSgzFwi8RWp03FAqYUB3jfAk2MFPU4X+XonHiQmpFheDINHtehLoPvobJgjCqD5Cd25XVYazr+k75LKiPUyheY8OPMet0qCbTmFTgvXcuAFY5DEtu1bBiYAU8mCvFkzUCe6B7EJRqeshqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ow8goAlv; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ow8goAlv"
Date: Fri, 13 Feb 2026 00:17:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770941836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f651VO7JxKZ/lJSDbKascp6f8THc3lWJvuWJJypOBTM=;
	b=ow8goAlvpmMtkOJdZbBzOrdpZIWit7rs23cqFCG7WryFzF52iEZKZmbyb/WHFPvE2LHtBL
	f+abimbJD7tNPtdFw3flGYhR77J5WZ5K5kUXPj+3PNU3yz9rUpKy4EVcxbFfe0ClXLu5qc
	7pKQBbkeuMjNHTwROK+22aVVPnV3fiY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 1/8] KVM: x86: nSVM: Clear VMCB_NPT clean bit when
 updating hPAT from guest mode
Message-ID: <f72gve6ia3aqcpkqxzuwnleaxzxmesapzmoaus6bwaibsq5f2g@hgq4z5mqxykh>
References: <20260212155905.3448571-1-jmattson@google.com>
 <20260212155905.3448571-2-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212155905.3448571-2-jmattson@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 12, 2026 at 07:58:49AM -0800, Jim Mattson wrote:
> When running an L2 guest and writing to MSR_IA32_CR_PAT, the host PAT value
> is stored in both vmcb01's g_pat field and vmcb02's g_pat field, but the
> clean bit was only being cleared for vmcb02.
> 
> Introduce the helper vmcb_set_gpat() which sets vmcb->save.g_pat and marks
> the VMCB dirty for VMCB_NPT. Use this helper in both svm_set_msr() for
> updating vmcb01 and in nested_vmcb02_compute_g_pat() for updating vmcb02,
> ensuring both VMCBs' NPT fields are properly marked dirty.
> 
> Fixes: 4995a3685f1b ("KVM: SVM: Use a separate vmcb for the nested L2 guest")
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/svm/nested.c | 2 +-
>  arch/x86/kvm/svm/svm.c    | 3 +--
>  arch/x86/kvm/svm/svm.h    | 9 +++++----
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index d80b1bde6630..b72a1f3c4144 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -707,7 +707,7 @@ void nested_vmcb02_compute_g_pat(struct vcpu_svm *svm)
>  		return;
>  
>  	/* FIXME: merge g_pat from vmcb01 and vmcb12.  */
> -	svm->nested.vmcb02.ptr->save.g_pat = svm->vmcb01.ptr->save.g_pat;
> +	vmcb_set_gpat(svm->nested.vmcb02.ptr, svm->vmcb01.ptr->save.g_pat);
>  }
>  
>  static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 364915f42e13..529cbac57814 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2924,10 +2924,9 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  		if (ret)
>  			break;
>  
> -		svm->vmcb01.ptr->save.g_pat = data;
> +		vmcb_set_gpat(svm->vmcb01.ptr, data);
>  		if (is_guest_mode(vcpu))
>  			nested_vmcb02_compute_g_pat(svm);
> -		vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
>  		break;
>  	case MSR_IA32_SPEC_CTRL:
>  		if (!msr->host_initiated &&
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 0bb93879abfe..9850ed01e16e 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -434,14 +434,15 @@ static inline void vmcb_mark_dirty(struct vmcb *vmcb, int bit)
>  	vmcb->control.clean &= ~(1 << bit);
>  }
>  
> -static inline bool vmcb_is_dirty(struct vmcb *vmcb, int bit)

Huh, I assume the removed of vmcb_is_dirty() was not intentional?

> +static inline bool vmcb12_is_dirty(struct vmcb_ctrl_area_cached *control, int bit)
>  {
> -        return !test_bit(bit, (unsigned long *)&vmcb->control.clean);
> +	return !test_bit(bit, (unsigned long *)&control->clean);
>  }
>  
> -static inline bool vmcb12_is_dirty(struct vmcb_ctrl_area_cached *control, int bit)
> +static inline void vmcb_set_gpat(struct vmcb *vmcb, u64 data)
>  {
> -	return !test_bit(bit, (unsigned long *)&control->clean);
> +	vmcb->save.g_pat = data;
> +	vmcb_mark_dirty(vmcb, VMCB_NPT);
>  }
>  
>  static __always_inline struct vcpu_svm *to_svm(struct kvm_vcpu *vcpu)
> -- 
> 2.53.0.239.g8d8fc8a987-goog
> 
