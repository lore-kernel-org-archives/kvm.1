Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E9F360ECE
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907459; cv=none; b=TC5Pp/872xc+u5kyTYHLpjswrZWi3tbmUWkKLYvSllp+jdtfWZt1LRYVcCYIDa69XK/RPx6GNTNrl5LxA2oPvz67UNvdXf/VnyfLkQTV1ruEhM8p5qBv2f18W8Q07nrG7ZlUysWQ0qGkR2F+JPUw1s+L43ULduJBN7lWI5uNtcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907459; c=relaxed/simple;
	bh=jFwwXAmoKlLbPhgfvyB4c2YG/Fd7525AOmwv1U1etj8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZrcM68UENkLemEV/SDMqVoNWphWHJ4v4LiaLaOPnjXC8ZKMg5DB6yRQ7/Fw7F3paLjdSAndRi5pnjULKmPwjLsdMsvIA1YNvTZAvIAFIQWhiI63ImkKwkip7vXEzy4n5AzjDGtyuRBQeAlWdQR3j7JpnUKinU/5lERPP2au07fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=osdgsY0v; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="osdgsY0v"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84865f326efso603733b3a.0
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 08:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784907456; x=1785512256; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bd6rBCUFArbIbFmAvnBI9n9FkkdWN3SxUwjoIXz6Gz0=;
        b=osdgsY0vLsVtizLMTE/Xd4bter6qFGfsQOMW9sv1aF8k7udde9DzOJn7bNIGZGSTCX
         Zc7yNw8deFO2sz+FE+8ScP6Olfl2c51LWNYgoG7pYr0DvLuzaCmPKLSEQFnfC7edQV7P
         PT/Gg5MX1goz6j/u/KSGDijqeaeqk0HoRlZAOVTlX4fVXBxF1rXYYSfRHgT/TbvBHkc8
         lzDK/f1fP4vfX6b/qJPGQcLHaVagiUvwUjY1UBrvFNfEn2dBijxmXnFY7fykIc6QyCMm
         NqQQN5kvyUwjG7DfEyTjRiVbZSoW+ERtp3DYPjJR+4fF6o+pa4diKMSvLVU7rrfmpyUD
         m+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784907456; x=1785512256;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bd6rBCUFArbIbFmAvnBI9n9FkkdWN3SxUwjoIXz6Gz0=;
        b=CmC1O43LQZ0H8DCgL32Z/VLmdtXZo/roIgbR8mOciDFbFbwl5iUxe+Bsa8AJNMUWHv
         iscx3EJNdla3VXJpsmNEa9iPa/7FVgIV3T9evIFLgZ50oHjvwv7WBlHFzpRIUJjwKPcp
         H2Vj7qcus7MsQJUCkTg43uSr2bar9avZYfol0DUSdpuzAGFOKmZKkZ7XE6uIJYFuqRpR
         5h4BnTFMokIDyyoZpu90x2QbSobpeyryMK637BUktCjmLXjH9007GDmLE0DrU5DECQhB
         uGKNYe2VbU9vO0kR2bTQ/oXOv6QeBOTlf784HXvu37+szCE0+5SEt7T8aPTsdZ9ONFgQ
         FdQA==
X-Forwarded-Encrypted: i=1; AHgh+RrmrUje2Dnvq/ioCir5gjCgag1zrtt6PWdF1BpiCGvSAsjiDlQKX/H86W2qZq/TsHtPlWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0V+4tUlj9p/2yopa0E/MJLnUmuH2jNS15lZHfM+Y+5UYDyY4d
	/C4XVFQXjlpTIi/FkxoryGhYw8FqzE3OMOWRtTt9hBkWyfe5sV+GkkOmhR10dy5kFOvHkThviT7
	Vq6iXxA==
X-Received: from pfem19.prod.google.com ([2002:a05:6a00:c093:b0:84e:101:e491])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:178b:b0:847:770f:da4c
 with SMTP id d2e1a72fcca58-84e2b7e3fffmr8697141b3a.16.1784907455817; Fri, 24
 Jul 2026 08:37:35 -0700 (PDT)
Date: Fri, 24 Jul 2026 08:37:35 -0700
In-Reply-To: <20260629183746.699840-7-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-7-yosry@kernel.org>
Message-ID: <amOGv2t9l9DpoW2a@google.com>
Subject: Re: [PATCH v3 06/10] KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOBBER_HACK
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 29, 2026, Yosry Ahmed wrote:
> Now that nVMX test codes preserves GPRs across nested VM-Exits
> (specifically RBP, RDX, and RDI among others), drop the ucall-specific
> hack to avoid clobbering these registers.
> 
> Assisted-by: Gemini:gemini-3.1-pro

Did Gemini really help you write this patch?  It's ok if it did, I just want to
be precise with documenting how AI was used so that when I get a patch that was
indeed heavily helped by AI, I can actually key off the "AI was used" information
for context when reviewing.

> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  tools/testing/selftests/kvm/lib/x86/ucall.c | 32 ++-------------------
>  1 file changed, 2 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/selftests/kvm/lib/x86/ucall.c
> index e7dd5791959ba..38050c60a0670 100644
> --- a/tools/testing/selftests/kvm/lib/x86/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
> @@ -10,36 +10,8 @@
>  
>  void ucall_arch_do_ucall(gva_t uc)
>  {
> -	/*
> -	 * FIXME: Revert this hack (the entire commit that added it) once nVMX
> -	 * preserves L2 GPRs across a nested VM-Exit.  If a ucall from L2, e.g.
> -	 * to do a GUEST_SYNC(), lands the vCPU in L1, any and all GPRs can be
> -	 * clobbered by L1.  Save and restore non-volatile GPRs (clobbering RBP
> -	 * in particular is problematic) along with RDX and RDI (which are
> -	 * inputs), and clobber volatile GPRs. *sigh*
> -	 */
> -#define HORRIFIC_L2_UCALL_CLOBBER_HACK	\
> -	"rcx", "rsi", "r8", "r9", "r10", "r11"
> -
> -	asm volatile("push %%rbp\n\t"
> -		     "push %%r15\n\t"
> -		     "push %%r14\n\t"
> -		     "push %%r13\n\t"
> -		     "push %%r12\n\t"
> -		     "push %%rbx\n\t"
> -		     "push %%rdx\n\t"
> -		     "push %%rdi\n\t"
> -		     "in %[port], %%al\n\t"
> -		     "pop %%rdi\n\t"
> -		     "pop %%rdx\n\t"
> -		     "pop %%rbx\n\t"
> -		     "pop %%r12\n\t"
> -		     "pop %%r13\n\t"
> -		     "pop %%r14\n\t"
> -		     "pop %%r15\n\t"
> -		     "pop %%rbp\n\t"
> -		: : [port] "d" (UCALL_PIO_PORT), "D" (uc) : "rax", "memory",
> -		     HORRIFIC_L2_UCALL_CLOBBER_HACK);
> +	asm volatile("in %[port], %%al"
> +		: : [port] "d" (UCALL_PIO_PORT), "D" (uc) : "rax", "memory");
>  }
>  
>  void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
