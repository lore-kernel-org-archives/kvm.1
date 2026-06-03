Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14C54C0433
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 23:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527929; cv=none; b=hMLyYulFx25e6FRiJUuEekyY7c+vJ/Fv8kz1wMdVtsgO10xfYaJTKPdqRFkm5YRhjxIexeV+A5Bz/Z301OK2Sc+YAD2MxgfbnWzlehvawjEqokc6ChsYzDJKbK/avzYsRFaYc96+hIaV0DephBN/CnYZ1D3r/zDKGe3qFuNjNJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527929; c=relaxed/simple;
	bh=FOTbKkTXFqCfnmkiCIO0Haw1vdPADRRItZxNEblPyBI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V/BPNt5ARZ6fSLewVCOoPyV7wkD6I9c+JE8qnRUrw9P4mkQnEOJi6avgkSeTXgFTWG3KNk2EKAZR0m8zBZPoaffYqbFQh41tOmCQMyU86ANPeQy5RMPlfaSduAuT8n1Cg9ODDDeyV42szQUVvlNwz2PEJpOzQVKPoAG6Xht6rzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZnRNctw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZnRNctw"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c10cd7df22so1212985ad.2
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 16:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780527926; x=1781132726; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+3s+E4xxG7mauxLjz9Wjjj+rgbDiBrMTMhVLzEeXd/g=;
        b=DZnRNctwhFC/U6d3RL9PAotjezVQMt6DA57PPVJKtnfxZmP9RIvGTKFcwOY6v8wDRk
         HInFltNhmdjPxCLImNEuDvdRDC6hRLGvBCezKvFHSftabOJNt/jdgzYW6yZBlLlWLBf+
         E10htIRjvYqKKjfzG71RpL6TuUCHaYYFdhMgUmV/11PePaFf8jD/JZpt+jIwrFoKWsfg
         /DtIzUnOobZNJGckDN5NhTpmp5nGPYUFd7CC1OyKYsJUjbq+nnu1WX+n046NVhQnn1Pt
         QChH5h0D3bvGItndf+8oatX+NwY5tVpy/OVvS/GIS1zLjImekOqp8uNOsJZ8h+Mc/sqy
         5BYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780527926; x=1781132726;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3s+E4xxG7mauxLjz9Wjjj+rgbDiBrMTMhVLzEeXd/g=;
        b=Xf73q3ZHbWwhQezW1pK1KdpMqrtKhTWQo8z2865BrSn351XZjJajCQjaswm4iGGqMY
         y/ECZtvTotCzeAuzD/0zB7+D4YUYgiVqbbeqhtWhPShKdEHhlqjmcr2NnXkbtMTvgoX1
         pHUPGoqzW0C72dVfbT5XzJtg/J2gM+DIU8gciyw8QrqOE5nYckq/xfxOAuBnbcCmKk0/
         8kPQZycLcdU8Tw5BOnUP8nivm5YkdmP1viUH2dGWxPpfJj4CZ1PSqQFUVr/Q6gpielq7
         5EYnxxkxCxUqShNxxO2AMWMDF3jp8I2H7tFOXx1YoiHGq+AcLYGRu5K2+SVOTjwmP+3/
         /+pg==
X-Forwarded-Encrypted: i=1; AFNElJ+9Qc2Hxq0NS296NnBUnu3oUsj5ZSwP6rvqdrE7Gm044+rknJ0xa0X1Z/dg2UPiqsB7HU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8pj7TOGKl5MPUVgHRHzQhGhs9TiVSNbkjCDYldfiTGs6pcKBY
	WaeY7fKAJLH7MYVTDbDo7nITGd3XsEW5yC0HsaGBaCiIFu2H4k7O0MnedPsw2mLramZD2Zos/Pd
	PA4ZFiA==
X-Received: from pltg8.prod.google.com ([2002:a17:902:6b48:b0:2b9:a1d0:9f13])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:42c4:b0:2c0:af09:f3c7
 with SMTP id d9443c01a7336-2c1640ae3demr32304785ad.30.1780527925809; Wed, 03
 Jun 2026 16:05:25 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:05:25 -0700
In-Reply-To: <20260603-snp-selftest-cleanup-v1-1-73b29fe31ce6@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603-snp-selftest-cleanup-v1-1-73b29fe31ce6@google.com>
Message-ID: <aiCzNbtQ4FPu2yCR@google.com>
Subject: Re: [PATCH] KVM: selftests: Make guest_code_xsave more friendly
From: Sean Christopherson <seanjc@google.com>
To: ackerleytng@google.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.roth@amd.com, jackyli@google.com, liruxin@google.com, 
	darwinguo@google.com, jacobhxu@google.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 03, 2026, Ackerley Tng via B4 Relay wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> The original implementation of guest_code_xsave makes a jmp to
> guest_sev_es_code in inline assembly. When code that uses guest_sev_es_code
> is removed, guest_sev_es_code will be optimized out, leading to a linking
> error since guest_code_xsave still tries to jmp to guest_sev_es_code.

So, don't do that?

> Rewrite guest_code_xsave() to instead make a call, in C, to
> guest_sev_es_code(), so that usage of guest_sev_es_code() is made known to
> the compiler.
> 
> This rewriting also gives a name to the xsave inline assembly, improving
> readability.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  tools/testing/selftests/kvm/x86/sev_smoke_test.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> index 1a49ee3915864..8b859adf4cf6f 100644
> --- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> +++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> @@ -80,13 +80,23 @@ static void guest_sev_code(void)
>  	GUEST_DONE();
>  }
>  
> -/* Stash state passed via VMSA before any compiled code runs.  */

Uh, so as the comment says, the goal is to stash state before _any_ compiled
code runs.  Shoving the code into inline asm breaks that.  The compiler *probably*
won't shove anything before the first inline assembly, but there are absolutely
no guarantees.  E.g. you're subtly relying on a tail-call optimization to avoid
any stack operations.  If I force guest_sev_es_code() to be inlined, then the
prologue becomes:

0000000000402a10 <guest_code_xsave>:
  402a10:       48 83 ec 08                                     sub    $0x8,%rsp
  402a14:       b8 07 00 00 00                                  mov    $0x7,%eax
  402a19:       31 d2                                           xor    %edx,%edx
  402a1b:       0f ae 27                                        xsave  (%rdi)
  402a1e:       b9 31 01 01 c0                                  mov    $0xc0010131,%ecx

and we're hosed.

> -extern void guest_code_xsave(void);
> -asm("guest_code_xsave:\n"
> -    "mov $" __stringify(XFEATURE_MASK_X87_AVX) ", %eax\n"
> -    "xor %edx, %edx\n"
> -    "xsave (%rdi)\n"
> -    "jmp guest_sev_es_code");
> +static void xsave_all_registers(void *addr)
> +{
> +	__asm__ __volatile__(
> +		"mov $" __stringify(XFEATURE_MASK_X87_AVX) ", %eax\n"
> +		"xor %edx, %edx\n"

This doesn't even build.  When using input and/or output params, named registers
like eax and edx need an extra '%' to escape them, e.g.

	asm volatile("mov $" __stringify(XFEATURE_MASK_X87_AVX) ", %%eax\n\t"
		     "xor %%edx, %%edx\n\t"
		     "xsave (%0)"
		:
		: "r"(addr)
		: "eax", "edx", "memory"
	 );

> +		"xsave (%0)"
> +		:
> +		: "r"(addr)
> +		: "eax", "edx", "memory"
> +	 );
> +}
> +
> +static void guest_code_xsave(void *vmsa_gva)
> +{
> +	xsave_all_registers(vmsa_gva);
> +	guest_sev_es_code();
> +}
>  
>  static void compare_xsave(u8 *from_host, u8 *from_guest)
>  {
> 
> ---
> base-commit: 0d9b37717aaa4a73362520af5ba4db7febf09123
> change-id: 20260603-snp-selftest-cleanup-bf97734c6902
> 
> Best regards,
> --
> Ackerley Tng <ackerleytng@google.com>
> 
> 
