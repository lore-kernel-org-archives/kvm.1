Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442DE26296
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787090180; cv=none; b=Gk8oeWLLBeZoDqIhpakYUCDUytCrh/NPWxQpWT9e4LAP6z2Hv/IF0shHkYVfO/sGlr9FpUwaUs/Q32rs9vapJbfB0YB77xI4zRQkZXWTqS/TaZX2xE8Ro1fLinhVU0+EpHECmDnjPIOdLU7Hi2LIDLz96/dmhEzvSN7FCX6HYCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787090180; c=relaxed/simple;
	bh=JuQe4wvhoTYyUuwxNJ/Cz6UJ4qgLwxXvjqd0Wlznc8c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uKKu16Q1xich/FaP2ukIsAn8vuzG8M4AHnlDlKBUuhF7PiJf8k4MDW04liEzK8nvlp4PrnSBfNqIZp7DGoh2J3+EG+fxSZ9y3GkDjCNll2lLEw9qPFBiKK8A2YisiMpaNpFZw/O4ixCFNuhh3sQE7gvTWvWnZ5dWKhsJpGts2EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aC1n6xqf; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aC1n6xqf"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d54187d8b0so6986675ad.0
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 14:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787090178; x=1787694978; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9gNRvVZWlKLU6Jjew/a+f7LZJn1aPJd/qJ+Prwj4wzc=;
        b=aC1n6xqf29lqkY94bDlwoonMkd35GGtQwyFojDW0QWYkfnwhd9Ahl6m17NJQwQABae
         0BRb5D+dHu2/hIP5N5WtuWJMgEvT8XM1Pg7rNFSyYPh8lnXhAjl94txv3jssH7MClTiQ
         9aSVOToccTRgVujsdJZXyFvT0tQdIQz/Xcm9OEV/68GpJvXBI7U87kaUD22ldwcA+8xv
         O64fpew4aIegrQPsZluugWbBr1p5ZEifCQ2V4BYZerhRY3tJa54cLYGM/W+XpE9Oe3Ls
         L6BWahnd14llBCK5lppBmqRJ41eoVInT3ViDNLGxCL8r3fzXZxNTkt7klvPuM09CC4wJ
         wW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787090178; x=1787694978;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9gNRvVZWlKLU6Jjew/a+f7LZJn1aPJd/qJ+Prwj4wzc=;
        b=BjbfUcOEWo+HJvF4+8mTwbDe9GHWYQcHSNu9Z9bXN3cwMZEPX2pbHtO4JVL+cZu2XK
         F6qnHquZdw4mRwTXglTyeUQLHZu66h3cWsrdZ7ITmvxe3PzSaETtU9gm6veBh9IgJYFT
         sIIhkdzOyg2j8Z7Sg66JKFBHrXR5jVfrA1gXM1auhom6aHUwB1C5xC9PXI+lS5h+F2uh
         +ZUSD4S5pA1Zdu4k0DiljsSvGA4EpNmtw7/NS4vrO6ltuAHNzSF1kyTRsND760X/rzPb
         MObmjqXZLkYz7g1D3U0NKM6JVYjNMaEGYWsdbv15WkeA3Wy5P4f9VA8bizUQTfjdZujb
         ufPw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9PZqR4LA/eXCtzscmtLvW9wGMSyC23dbrcVqR7uDh7ZXDU46Z5vG1ekBbo5LTQshBaZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8dfgRrd094qTFQBcKJY24SwcYHINeglfqv0+dJg/GyRZtDDxr
	LeJozC2TEhVaCc6OP25Fe5th5Zeox5sLctdSaIB9YP1gX14a2wLwchkw6O6uFo7I/dkpav44Abg
	bmyb4xA==
X-Received: from plkk3.prod.google.com ([2002:a17:902:c403:b0:2d3:2362:d799])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:944:b0:2ca:d91d:d3a7
 with SMTP id d9443c01a7336-2d5f6b21181mr14818565ad.10.1787090178421; Tue, 18
 Aug 2026 14:56:18 -0700 (PDT)
Date: Tue, 18 Aug 2026 14:56:17 -0700
In-Reply-To: <aoSTeLzhaWohymLf@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818165258.2613603-1-vkuznets@redhat.com> <20260818165258.2613603-5-vkuznets@redhat.com>
 <20260818170534.07B561F000E9@smtp.kernel.org> <aoSTeLzhaWohymLf@google.com>
Message-ID: <aoTVAdqoAAuVKi8L@google.com>
Subject: Re: [PATCH v2 4/4] KVM: selftests: Check VMPTRLD with active eVMCS
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 18, 2026, Sean Christopherson wrote:
> On Tue, Aug 18, 2026, sashiko-bot@kernel.org wrote:
> > > +	asm volatile(KVM_ASM_SAFE("vmptrld %[pa]")
> > > +		     "\n\tsetna %[failed]"
> > 
> > [Severity: Medium]
> > Will this setna instruction incorrectly evaluate CPU flags?
> > 
> > The KVM_ASM_SAFE macro executes xor %%r9, %%r9 on its success path, which
> > unconditionally clears the Carry Flag (CF=0) and sets the Zero Flag (ZF=1).
> 
> Shame on me, I should know better after dealing with ba5ca5e5e6a1 ("x86/retpoline:
> Don't clobber RFLAGS during srso_safe_ret()").
> 
> Untested, but I think the fix is simply:
> 
> diff --git tools/testing/selftests/kvm/include/x86/processor.h tools/testing/selftests/kvm/include/x86/processor.h
> index 6e6f70035508..119715ffe93f 100644
> --- tools/testing/selftests/kvm/include/x86/processor.h
> +++ tools/testing/selftests/kvm/include/x86/processor.h
> @@ -1318,7 +1318,7 @@ gva_t vm_alloc_stack(struct kvm_vm *vm, int nr_pages);
>         "lea 1f(%%rip), %%r10\n\t"                              \
>         "lea 2f(%%rip), %%r11\n\t"                              \
>         fep "1: " insn "\n\t"                                   \
> -       "xor %%r9, %%r9\n\t"                                    \
> +       "mov $0, %%r9\n\t"                                      \
>         "2:\n\t"                                                \
>         "mov  %%r9b, %[vector]\n\t"                             \
>         "mov  %%r10, %[error_code]\n\t"

Vitaly, I'll send a v3 of this series with a rather large pile of additional
selftests changes.  As often seems to be the case, my desire validate a simple
fix has snowballed...
