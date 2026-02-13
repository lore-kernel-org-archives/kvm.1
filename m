Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FD8185B48
	for <kvm@vger.kernel.org>; Fri, 13 Feb 2026 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770942805; cv=none; b=VF2+ZDg3sa4Q/E/bUrfYo8LmGrfugmzOWG2FDXM46Y+Wm/ajG2AiTUO0g/wlzexu93FTGxLEh0nBwLSa9x6WMnFyZUgvssx2unU6nm05Ms/iht3ME0MUDHAmXdiUkIyVhza0M/2PrMi2aOcDV93HUMQ7O6P/qOYxhgMrpuCtRu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770942805; c=relaxed/simple;
	bh=PkJqMK0xbv67aQxeFs5sdlQpXx27obGJUhEUK+jKkVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUJJkaQf4yDQV6iX/ylPEEUCaGqqA2aCBlDfuRgz7XIUboszT2LeEIuqgAAVh3/V60dS+L+KYSWmJ/oslC4/mEXxm14m4AslHcQAR/RtdpP6gTRwXEdcvDfEATvF0Gps7GXgtz1LacF6SkDbhhU2JbaO4tmjnIUatdvLO2Ly7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MZfuICVj; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MZfuICVj"
Date: Fri, 13 Feb 2026 00:33:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770942801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=757LaK5nPeInnPZgg552gduOrVZyVOCJMA4UqyQZnJg=;
	b=MZfuICVj7PZMtVoC21ivcrR4kfJrY+/ygLQd2KL+iPpPLSX/wdwaqky7eI2eNfKo1HE1xN
	NQ11piIkXIeRNE4u/NBNYrVBLCiJTnIo/9LnJoKEiwGNeT2aiQhhrZu1lZaav258FXKX43
	nIJl328kPnfI5B/gHeoi5HiHwIYjZ9U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 5/8] KVM: x86: nSVM: Save gPAT to vmcb12.g_pat on
 VMEXIT
Message-ID: <dafxl5osu7mpu3ltsalmuo6l4vs52vyhhvnccj7k5s6p4s2htl@3uwdw2hzkkbb>
References: <20260212155905.3448571-1-jmattson@google.com>
 <20260212155905.3448571-6-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212155905.3448571-6-jmattson@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 12, 2026 at 07:58:53AM -0800, Jim Mattson wrote:
> According to the APM volume 3 pseudo-code for "VMRUN," when nested paging
> is enabled in the vmcb, the guest PAT register (gPAT) is saved to the vmcb
> on emulated VMEXIT.
> 
> When nested NPT is enabled, save the vmcb02 g_pat field to the vmcb12 g_pat
> field on emulated VMEXIT.
> 
> Fixes: 15038e147247 ("KVM: SVM: obey guest PAT")
> Signed-off-by: Jim Mattson <jmattson@google.com>

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> ---
>  arch/x86/kvm/svm/nested.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 69b577a4915c..26f758e294ab 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1312,6 +1312,9 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
>  	vmcb12->save.dr6    = svm->vcpu.arch.dr6;
>  	vmcb12->save.cpl    = vmcb02->save.cpl;
>  
> +	if (nested_npt_enabled(svm))
> +		vmcb12->save.g_pat = vmcb02->save.g_pat;
> +
>  	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK)) {
>  		vmcb12->save.s_cet	= vmcb02->save.s_cet;
>  		vmcb12->save.isst_addr	= vmcb02->save.isst_addr;
> -- 
> 2.53.0.239.g8d8fc8a987-goog
> 
