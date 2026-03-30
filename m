Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039C83D413D
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877907; cv=none; b=qVODa8JCnb4OvYsDEZec9qttm4DS77MhrU7XtsK1o7ykJTcR/rhu0Ga+kf8eF8p4M8xDRFWPaJ1SCzm54CjLHSogDecFHunB6FLNaCT4987wZBgc5vD5jLXv/jCMXihCT5mNDRV4EUg+WaJo3wBUNdYRU//GR914ejXwnBGaekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877907; c=relaxed/simple;
	bh=RrqPwUTqEGSLs/qe8j7V9519WR0mB2p6TiOM/sI99YI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxWa8WBPyoZGbpxZHBkeWiEtRF7Xhzp7FgKaw6eGAhmj+0BwKK6sFTDcyFL/NWUws2uv2uGciPcgIAit2jvTlXW2ipTDntoyfDfDyflW+f4MqQjAbU2tjlIHDYMnm74et35e0sBLlmtXFscPfbJyliHJwZe8OAe/En8/mbS2PDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pA3iVf4a; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pA3iVf4a"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483487335c2so47985175e9.2
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 06:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774877904; x=1775482704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K6y9UsF1LewekM6lbBYNrYJF23PRCqYpwk55A2eahA=;
        b=pA3iVf4at0n1Dk+uCuV0jywyOz8zydHO5R+WDOoxWu7iYnP9sf7Km9D2Y1AW054ruT
         QTt9f+KSObhvgPiBTK5JYhRzvVxE8Me1DOkAITgtScc2xB39tUMMUXDaH+HiUCw8JuJF
         hTgvzbnkMkUbDTwtLACwmKxaDuA+RJo25Xu3rTc3wq7Mj70x0vEjYaOIOmBbN5Eb7OqU
         IZR1V0Mi0HrJbqnTjmm9f8jxOxnzC+sykXUzw5a3TE/QegKH3tFk1vEdCrQ6D14jvMSg
         fni65n7PJR/bO+j1mIH4eVeKxHJ4C7xjBx7wQGJ2ItiVbKZzEpCYpIv6lmmcQ13iAZeW
         1kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774877904; x=1775482704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1K6y9UsF1LewekM6lbBYNrYJF23PRCqYpwk55A2eahA=;
        b=Bca75cjzG4TrBymJmp7Vto2EoSAcMTYL+OfQ6x6PuXggIFWXf5xb9WWTKVFB+WgGlK
         js55TWwPR8YA3wjhz5k8hxhwouRJLUG15l2WYM+A08YS7Z1OOhPgMRPHwlLbtBItVC3T
         lEklkqizsDzQAy+s6v6gZlgLCuMSvgGLRQlqR7t/R8wbL9bRkPnpnymy1uwZVuiM9Lhk
         xLZ+XU4HxjexBEKC6tGTjTmjYBeZWVBOc0ObdJTXDx8AGnwv+eWEnVma1JZx2YGMb5hQ
         8IXhtEVG9qsod0NgUoHZ85bPUUZrUHYjXKE2eGqEEeDsABQXMI2J2SgB+9OUv2e54oEF
         P/bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhY4p8HAikZO3JEjs6RrX+OGQlMj34UwKabU5e5B1xuu3UJldViccRn4ctNGwtGi3mlQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOys2wlE8qvi3cQCO/JO2BnYUEoXre9tac1qTHtSIC7hXQ7Pc0
	CIF0Kybs8AxR3vQMFrTwNwjEAqr0OiOVe1PRmuq5YsDsUTO2IvjA3ABg
X-Gm-Gg: ATEYQzxLj1852ACEbCM2G3M59Qi+Pi4P3A7li8l3YlAaawj4gjC1nu0NlbqSUtLeX2h
	wopArVZBrxRuMuROHMMNFv9kK03LA0ErR9DIyp8OutqBf9ONib4ymjcPJ9FKaV5LiTyw/zm55V6
	zL9LCUsWWB7n1leLsqRrRk+qlEpuBSQ4Anc8S70h7Nm1IlRDm/QyvROaV1S//TJYPveATp6EbSX
	L+Wr4xPSl/jreiyTiX2Lj6YKZT0ReWLR+K9mGEc0aByuoQ6lJ02PyDNS8CJ3uLjY6BdsmaBhPwL
	Tp/9Y2NZeOL/zqPL6iJOAM1H7Uh3M4aqrPPpJAhgAwtlQBUl7WhYwLbRLWQPM3s0QviPUlM2EaE
	42O5YMCPAWucweDaZNiMtNLIrz0iqrn0IZHIjh1rxz9+voIgGjSf8OPob/KQyWU4Z3iyesLAJFo
	ivFjxwwHZUaHv+qpTFcDCpPaq9BU7lyJiFAVxiC4ZnIw2NngB2r7qM/bqcCXZ7
X-Received: by 2002:a05:600c:5249:b0:487:386:3714 with SMTP id 5b1f17b1804b1-48727f7bb08mr231528425e9.17.1774877904186;
        Mon, 30 Mar 2026 06:38:24 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d40741sm294000475e9.13.2026.03.30.06.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:38:23 -0700 (PDT)
Date: Mon, 30 Mar 2026 14:38:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: "Bird, Tim" <Tim.Bird@sony.com>, "pmladek@suse.com" <pmladek@suse.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>, "senozhatsky@chromium.org"
 <senozhatsky@chromium.org>, Shashank Balaji <shashankbalaji02@gmail.com>,
 "john.ogness@linutronix.de" <john.ogness@linutronix.de>,
 "francesco@valla.it" <francesco@valla.it>, "geert@linux-m68k.org"
 <geert@linux-m68k.org>, "linux-embedded@vger.kernel.org"
 <linux-embedded@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, x86@kernel.org, Paolo Bonzini
 <bonzini@gnu.org>, Sean Christopherson <seanjc@google.com>, KVM
 <kvm@vger.kernel.org>
Subject: Re: [PATCH v3] printk: fix zero-valued printk timestamps in early
 boot
Message-ID: <20260330143820.605b29ed@pumpkin>
In-Reply-To: <87fr5ib6ks.ffs@tglx>
References: <39b09edb-8998-4ebd-a564-7d594434a981@bird.org>
	<20260210234741.3262320-1-tim.bird@sony.com>
	<87zf3ud92r.ffs@tglx>
	<MW5PR13MB5632FC91EE0EF8754331400DFD57A@MW5PR13MB5632.namprd13.prod.outlook.com>
	<87jyuvboo2.ffs@tglx>
	<87fr5ib6ks.ffs@tglx>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 00:42:59 +0200
Thomas Gleixner <tglx@kernel.org> wrote:

...
> If you want to have early timestamps then you have to go through the low
> level code on every architecture and do the proper sanity checks,
> enumerations, etc. no matter what. There is no guarantee that you can
> use any clock unconditionally during very early boot.
> 
> As you have to do that anyway, there is _zero_ justification for an
> extra facility side stepping sched clock, which would just create
> another pile of technical debt.
> 
> Quite the contrary, I'm going to get rid of technical debt:
> 
>   The get_cycles() related changes in tsc.h are going to end up in a
>   obviously revised formal patch tomorrow as there is exactly _zero_
>   requirement to provide this as a functional interface.
> 
>   1) The default implementation in asm-generic returns 0
> 
>      Ergo any code depending on a functional implementation is broken
>      by definition.
> 
>   2) The ops/cycles metrics are as bogus as the infamous BogoMIPS metrics
>   
>      The "cycle" counter runs on almost all contemporary CPUs at a fixed
>      frequency, which is completely unrelated to the actual CPU
>      frequency and therefore to the actual CPU cycles.
> 
>      The only realistic metric is ops/sec and nothing else and that can
>      be trivially achieved by using the generic time getter interfaces.

ops/sec is also horrid because you get all all the interrupt time getting
in the way.
Additionally it is only any use for relative comparisons done on exactly
the same hardware, and is entirely useless is you are trying to show that
a short code loop is running at/near the theoretical rate.

The only thing I've found that works is the PERF_COUNT_HW_CPU_CYCLES
counter (low 32 bits).
In userspace you do have to directly read the register (rather than using
the library function - too much overhead), and ignore any silly values
generated by interrupts and process switches.
But it is accurate enough to time single function calls and see the
effect of things like mispredicted branches and the data-dependency of
divide instructions.

But I do agree that the TSC is entirely useless for measuring what it was
originally intended to measure.

	David

> 
>      Those might end up resulting in bogus benchmark results too if the
>      underlying clocksource is jiffies, but that's again a matter of
>      accepting reality.
> 
>      If people really mandate that ops/bogo_cycles is required for the
>      very wrong reasons, then I'm happy to bring it back with a global
>      name change from get_cycles() to get_bogo_cycles() which excludes
>      it from any serious usage including printk.
> 
> Thanks,
> 
>         tglx
