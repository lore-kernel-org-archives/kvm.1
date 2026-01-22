Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E978352C26
	for <kvm@vger.kernel.org>; Thu, 22 Jan 2026 01:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046749; cv=none; b=B+dPqRSY1rjj/OpWJoImFR+OXwgZK6RVF16duK/GcVVBMrrmAWWgoXm2h1rc227FC+5jRE9jCVj0QDHnjw9qf8FxzXtuv0GnhOCF3vVUmTNT3DewdifldmNRTeVUjttFmSiYlMN6zqwwrIPcmHn4mGFhA+jel2YAVm2DD61JLXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046749; c=relaxed/simple;
	bh=qYwAX/Pf7Ke5XbpM2EiaK/6q423NqH3TiaABIOWSx+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRltZuP6rY8QxlArj317NTcAx/Ldwl3iQW3trZoY7PWaZRgTJSlf3RRuD9Y+bds7Y+N+W5DR96eOzPzDgYuB0quXWQxG8xSiz3ALjYobf+AuyIf89fLOihpvrJRdMwyqFv2Z+8PxwLvN/GK7ffoe8I6NXpCGlx+YupLXSI1ra2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n8/HpKxo; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n8/HpKxo"
Date: Thu, 22 Jan 2026 01:52:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769046744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v8WrSN8hRo+4tyF0Y0UH5ZXDOaU9yhor4eMKJD38nAs=;
	b=n8/HpKxoYG6RNTHt3cPt9IAgrfdDAwIxXw6I7tvfCkyDrHkiofZX7TuC62s16AUtUVz6xL
	8GPShQM1IjdLZxFntaVmDso6Dc2LQXpNFAGMRgr0FleUJzUDyFcomtRoaH1Jyi+KNCQNCN
	vPeVuKDxeHgrcMiZDd7lwf+iVFuSekI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 6/8] KVM: x86: nSVM: Save/restore gPAT with
 KVM_{GET,SET}_NESTED_STATE
Message-ID: <mvornetnmvtjfljpecadzjqujotup6jxvf3q43ycnn4zyf3x6e@mc45ffhi3u6a>
References: <20260115232154.3021475-1-jmattson@google.com>
 <20260115232154.3021475-7-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115232154.3021475-7-jmattson@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 15, 2026 at 03:21:45PM -0800, Jim Mattson wrote:
> Add a 'flags' field to the SVM nested state header, and use bit 0 of the
> flags to indicate that gPAT is stored in the nested state.
> 
> If in guest mode with NPT enabled, store the current vmcb->save.g_pat value
> into the vmcb save area of the nested state, and set the flag.
> 
> Note that most of the vmcb save area in the nested state is populated with
> dead (and potentially already clobbered) vmcb01 state. A few fields hold L1
> state to be restored at VMEXIT. Previously, the g_pat field was in the
> former category.
> 
> Also note that struct kvm_svm_nested_state_hdr is included in a union
> padded to 120 bytes, so there is room to add the flags field without
> changing any offsets.
> 
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/include/uapi/asm/kvm.h |  3 +++
>  arch/x86/kvm/svm/nested.c       | 13 ++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index 7ceff6583652..80157b9597db 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -495,6 +495,8 @@ struct kvm_sync_regs {
>  
>  #define KVM_STATE_VMX_PREEMPTION_TIMER_DEADLINE	0x00000001
>  
> +#define KVM_STATE_SVM_VALID_GPAT	BIT(0)
> +
>  /* vendor-independent attributes for system fd (group 0) */
>  #define KVM_X86_GRP_SYSTEM		0
>  #  define KVM_X86_XCOMP_GUEST_SUPP	0
> @@ -530,6 +532,7 @@ struct kvm_svm_nested_state_data {
>  
>  struct kvm_svm_nested_state_hdr {
>  	__u64 vmcb_pa;
> +	__u32 flags;
>  };
>  
>  /* for KVM_CAP_NESTED_STATE */
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 5fb31faf2b46..c50fb7172672 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1789,6 +1789,8 @@ static int svm_get_nested_state(struct kvm_vcpu *vcpu,
>  	/* First fill in the header and copy it out.  */
>  	if (is_guest_mode(vcpu)) {
>  		kvm_state.hdr.svm.vmcb_pa = svm->nested.vmcb12_gpa;
> +		if (nested_npt_enabled(svm))
> +			kvm_state.hdr.svm.flags |= KVM_STATE_SVM_VALID_GPAT;
>  		kvm_state.size += KVM_STATE_NESTED_SVM_VMCB_SIZE;
>  		kvm_state.flags |= KVM_STATE_NESTED_GUEST_MODE;
>  
> @@ -1823,6 +1825,11 @@ static int svm_get_nested_state(struct kvm_vcpu *vcpu,
>  	if (r)
>  		return -EFAULT;
>  
> +	/*
> +	 * vmcb01->save.g_pat is dead now, so it is safe to overwrite it with
> +	 * vmcb02->save.g_pat, whether or not nested NPT is enabled.
> +	 */
> +	svm->vmcb01.ptr->save.g_pat = svm->vmcb->save.g_pat;
>  	if (copy_to_user(&user_vmcb->save, &svm->vmcb01.ptr->save,
>  			 sizeof(user_vmcb->save)))
>  		return -EFAULT;
> @@ -1904,7 +1911,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
>  		goto out_free;
>  
>  	/*
> -	 * Validate host state saved from before VMRUN (see
> +	 * Validate host state saved from before VMRUN and gPAT (see
>  	 * nested_svm_check_permissions).
>  	 */
>  	__nested_copy_vmcb_save_to_cache(&save_cached, save);
> @@ -1951,6 +1958,10 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
>  	if (ret)
>  		goto out_free;
>  
> +	if (is_guest_mode(vcpu) && nested_npt_enabled(svm) &&
> +	    (kvm_state.hdr.svm.flags & KVM_STATE_SVM_VALID_GPAT))
> +		svm->vmcb->save.g_pat = save_cached.g_pat;

is_guest_mode() should always be true here, right?

> +
>  	svm->nested.force_msr_bitmap_recalc = true;
>  
>  	kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
> -- 
> 2.52.0.457.g6b5491de43-goog
> 
