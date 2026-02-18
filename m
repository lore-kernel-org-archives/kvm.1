Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08138D
	for <kvm@vger.kernel.org>; Wed, 18 Feb 2026 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771456532; cv=none; b=DoSuQK3JjbVKJMPXTcoogy7AvmrByAyycHz7l09C2OFqpVDS/k1FNhrnY1Qy1ibnXCgPWpOXwO4ZUvR5SBv7LnQKdOZkjTTSj9jWJJSafNOo4+F5EvS5AV/7GDxwMrmNyt2nUSzNR+KwSiWj3jm8SY96qVXQuu/9wZZgiZ2Cfnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771456532; c=relaxed/simple;
	bh=JVGyebwggzFLo4QTr11b83BjwjOQ4Vk1sipabHp/uaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRNSu/yoelRS/VNjp9/mf3KwclCE56WtD1lYMlx+4BeGjQlqj/Yhvc84AOUEfKmqQ16K9Fa7o0A7wDeqqx0nigieXnWYXyzIzqW8vnVb6GwhWSbVsmAjGz9oe90XieKvpNrifp3PazKg+a1Y5dnVrE5ZiIZ6xpHbsCplwQwQQeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FvFulrru; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FvFulrru"
Date: Wed, 18 Feb 2026 23:15:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771456528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+3wQ5Sza20sMBTWsGhakDjJD8yCV1E+YfoSCsoquAg=;
	b=FvFulrruPqn7H4P2S5cAJrt2DGWwrMAloU2cxNob6b3WsTOK+Op52dtt+87oJCPqms3L2M
	mbtB70kmWfwkuLUiZGP8GUtvorlwQ9cdhZhT7IgSPZ2g43Xj+mhnAuWZs2U8t7HNuHVbl0
	TNRvISmDykIIrP8Po5hJRshvsOFipQQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] KVM: SVM: Explicitly mark vmcb01 dirty after
 modifying VMCB intercepts
Message-ID: <dfw3gcpk36jri774l42oseqxembnobtby7bl35uo6eawydwkto@cmlkbs3ponkb>
References: <20260218230958.2877682-1-seanjc@google.com>
 <20260218230958.2877682-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218230958.2877682-2-seanjc@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 18, 2026 at 03:09:51PM -0800, Sean Christopherson wrote:
> When reacting to an intercept update, explicitly mark vmcb01's intercepts
> dirty, as KVM always initially operates on vmcb01, and nested_svm_vmexit()
> isn't guaranteed to mark VMCB_INTERCEPTS as dirty.  I.e. if L2 is active,
> KVM will modify the intercepts for L1, but might not mark them as dirty
> before the next VMRUN of L1.
> 
> Fixes: 116a0a23676e ("KVM: SVM: Add clean-bit for intercetps, tsc-offset and pause filter count")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> ---
>  arch/x86/kvm/svm/nested.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index de90b104a0dd..66701106a51b 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -128,11 +128,13 @@ void recalc_intercepts(struct vcpu_svm *svm)
>  	struct vmcb_ctrl_area_cached *g;
>  	unsigned int i;
>  
> -	vmcb_mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
> +	vmcb_mark_dirty(svm->vmcb01.ptr, VMCB_INTERCEPTS);
>  
>  	if (!is_guest_mode(&svm->vcpu))
>  		return;
>  
> +	vmcb_mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
> +
>  	c = &svm->vmcb->control;
>  	h = &svm->vmcb01.ptr->control;
>  	g = &svm->nested.ctl;
> -- 
> 2.53.0.345.g96ddfc5eaa-goog
> 
