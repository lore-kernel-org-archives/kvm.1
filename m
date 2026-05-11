Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807E12D6E72
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 23:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778542509; cv=none; b=YszDuTYWsloTmde5oTRqTsaLAA/3ubYII7ULQGc+UZqXoBHxSeymXtVBJ2FnwBWwS7ffeRVtrTs0W0TAV6ljT4idLhpjjGxQAFJPu0luaQy57pUv4Kn/YaU/tdjFmg4tovt4uP49FfSWSHnB7F8GNtDJbqz/Q+Ov7itH/+QXpbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778542509; c=relaxed/simple;
	bh=Ji/g90BvsHSv60ZUBpCxZ9AKzBdvPAlczFuLYpKfKjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C07Waj5JvKmpUUPN1sPAXu9lnLWzC90T8XD4Wr3gwGonG8K6jrFctnhEZpVpil9prGZ52BNy6B+Y0k9TTtPcb+KP5z8DXb5/tuIkt1Cbk1B/bKK+/xDU+BW32Q5i7ANXluqsk2inyFHZ52m65JEdeNMpq9XZxtObP/xaeXLwWBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xsw1nCSO; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xsw1nCSO"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8353df9bc7eso4639717b3a.2
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 16:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778542508; x=1779147308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0jrLObVTajcjOJDJF3S4+2X11nmDT/l3IIL/Yw0FiJQ=;
        b=Xsw1nCSOB6xQlWHSkrX0QQCiJkBxLQYMcBefWiVaxczei465z52tjG37ad7TAWI6Vi
         48dNZNTjcR5/5JUhrORrCLvs49a6LwyTw8615woOcpUCXwCOFZxBtRANDEDw46LNrtts
         OpHVZxTHjvCudArqpFIsThyjasPK9ZUJGEa4fErxrmU0d3qKPYhm7kEl6os4BKmqabil
         DQFjzOV5fLqNoPFqbZ17/vXJFd70JrCDVH80KzXpfWJUvzMLPoVrPWU1zeX9ENjbXwRd
         pN59yK4Sh5KFfP2lDKTUALPmE8EzoL61RbqMFs2nITrnxoG3hOogXtAI5Bekk9oPXhsN
         2v0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778542508; x=1779147308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jrLObVTajcjOJDJF3S4+2X11nmDT/l3IIL/Yw0FiJQ=;
        b=nEAeyFqW6z/7npLzxoSHp0khqJiWLsylXLH9FYwwQ2FooBlfIknYQsMzrDBeu+MGw4
         9iIXcTmKv1wMFu0unCho+TMM2LIRP8WAmGBtveOPCLszna07jcP2VzMiDO12+HlqZLON
         2I/K1grdYPQyCiG9xNw0f1a/Qu5R78HgHeEZDdgek1/UxtnvtCQbiY8IHmiR6wyBA2nd
         L/FVlx3L0q5s+yyLuW5dNkW1IR3wyaVR8Sh3N0+zgOqaGLRgQCPL83+6j6518hCPsWqq
         iJun3aqiSV7lzg2CGVhQiiyt2njcMSF5dSiP2t3KDJvLXDttDcScenSOkphmuzNFhj9l
         fJdA==
X-Gm-Message-State: AOJu0YzN9faFbdlq2uszTpn9QtjcxA6VmLC4Ju9FfqlrnStbE48gx1/B
	/nKM9NbLhea/a8ou5YqU5GeVE8V1IOpJj8JLb/cbc9UXL3UOdnwFsbUAKhhC61IT6t62ZrDlW2V
	lFjjOKA==
X-Received: from pfbgo19.prod.google.com ([2002:a05:6a00:3b13:b0:82f:8a3b:87f0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:230a:b0:823:d2c:b156
 with SMTP id d2e1a72fcca58-83a5b6d0a01mr26153297b3a.5.1778542507570; Mon, 11
 May 2026 16:35:07 -0700 (PDT)
Date: Mon, 11 May 2026 16:35:06 -0700
In-Reply-To: <20260102142429.896101-5-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260102142429.896101-1-griffoul@gmail.com> <20260102142429.896101-5-griffoul@gmail.com>
Message-ID: <agJnqh7ACEkB-ftx@google.com>
Subject: Re: [PATCH v4 04/10] KVM: nVMX: Implement cache for L1 APIC pages
From: Sean Christopherson <seanjc@google.com>
To: Fred Griffoul <griffoul@gmail.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, vkuznets@redhat.com, 
	shuah@kernel.org, dwmw@amazon.co.uk, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Fred Griffoul <fgriffo@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 02, 2026, Fred Griffoul wrote:
> From: Fred Griffoul <fgriffo@amazon.co.uk>
> 
> Replace kvm_host_map usage with gfn_to_pfn_cache for L1 APIC
> virtualization pages (APIC access, virtual APIC, and posted interrupt
> descriptor pages) to improve performance with unmanaged guest memory.
> 
> The conversion involves several changes:
> 
> - Page loading in nested_get_vmcs12_pages(): load vmcs02 fields with
>   pfncache PFNs after each cache has been checked and possibly activated
>   or refreshed, during OUTSIDE_GUEST_MODE vCPU mode.
> 
> - Invalidation window handling: since nested_get_vmcs12_pages() runs in
>   OUTSIDE_GUEST_MODE, there's a window where caches can be invalidated
>   by MMU notifications before entering IN_GUEST_MODE. implement
>   is_nested_state_invalid() callback to monitor cache validity between
>   OUTSIDE_GUEST_MODE and IN_GUEST_MODE transitions. This triggers
>   KVM_REQ_GET_NESTED_STATE_PAGES when needed.
> 
> - Cache access in event callbacks: the virtual APIC and posted interrupt
>   descriptor pages are accessed by KVM in has_events() and
>   check_events() nested_ops callbacks. These use the kernel HVA following
>   the pfncache pattern of check/refresh, with both callbacks able to sleep
>   if cache refresh is required.
> 
> This eliminates expensive memremap/memunmap cycles for each L2 VM
> entry/exit, providing substantial performance improvements when using
> unmanaged memory.
> 
> Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
> ---
>  arch/x86/kvm/vmx/nested.c | 182 +++++++++++++++++++++++++++++---------
>  arch/x86/kvm/vmx/vmx.h    |   8 +-
>  include/linux/kvm_host.h  |   5 ++
>  3 files changed, 150 insertions(+), 45 deletions(-)

Please split this up; one "cache" per patch.  It's a bit gratutious, but the usage
of the vapic and pid structures is just complex enough to make this more than a
straightforward, "boring" conversion.

> @@ -3112,8 +3173,9 @@ static int nested_vmx_check_controls(struct kvm_vcpu *vcpu,
>  static int nested_vmx_check_controls_late(struct kvm_vcpu *vcpu,
>  					  struct vmcs12 *vmcs12)
>  {
> -	void *vapic = to_vmx(vcpu)->nested.virtual_apic_map.hva;
> -	u32 vtpr = vapic ? (*(u32 *)(vapic + APIC_TASKPRI)) >> 4 : 0;
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	void *vapic;
> +	u32 vtpr = 0;
>  
>  	/*
>  	 * Don't bother with the consistency checks if KVM isn't configured to
> @@ -3130,6 +3192,12 @@ static int nested_vmx_check_controls_late(struct kvm_vcpu *vcpu,
>  	if (!warn_on_missed_cc)
>  		return 0;
>  
> +	vapic = nested_lock_vapic(vmx);
> +	if (vapic) {
> +		vtpr = (*(u32 *)(vapic + APIC_TASKPRI)) >> 4;
> +		nested_unlock_vapic(vmx);

This is *very* dangerous.  vapic will still be a legal kernel pointer, and the
code _relies_ on it to be non-NULL, but the pointer could become stale at any time.
Happily, my CLASS() approach makes this a non-issue.

> +	}
> +
>  	if ((exec_controls_get(to_vmx(vcpu)) & CPU_BASED_TPR_SHADOW) &&
>  	    nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW) &&
>  	    !nested_cpu_has_vid(vmcs12) &&

...

> @@ -3543,7 +3609,16 @@ static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
>  
>  static bool vmx_is_nested_state_invalid(struct kvm_vcpu *vcpu)
>  {
> -	return false;
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +
> +	/*
> +	 * @vcpu is in IN_GUEST_MODE, eliminating the need for individual gpc

This is straight up wrong.

gpc->active is effectively protected by vcpu->mutex.

And for gpc->valid, it's not completely wrong, but it's partially wrong and
definitely misleading.  It too is protected by vcpu->mutex, but only for %false
=> %true transitions.  And even for %true => %false transitions, IN_GUEST_MODE
doesn't exactly provide safety, rather it ensures that KVM will to kick the vCPU
out of the guest before completing the invalidation.

But that's all moot, because the very existence of this code feels wrong.  KVM
should be sending a "no action" request and then requiring vendor code to check
out-of-band data to proxy that into a "real" request.

Presumably older code that you're reverting used KVM_REQ_OUTSIDE_GUEST_MODE;
that doesn't necessary mean it was a good idea, it got yanked out for a reason :-)

IMO, the least awful way to deal with this is to tag KVM_REQ_GET_NESTED_STATE_PAGES
with KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP, and then pass the specific request
that needs to be made when invalidating a vCPU-mapped gpc as part of
__kvm_gpc_init() (though maybe call it vcpu_gpc_init() instead?).  That way KVM
doesn't need this wonky request => kvm_gpc_invalid() => request proxying, and we
should be avoid to entirely avoid the confusingly-named kvm_gpc_invalid().
