Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704DB36492D
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780081057; cv=none; b=VmNv1+hks9yTFWBgUNum/G2VW6n1xB1+Q1bakqijTPjdv1zfWBqo6zbLyOLVAdivWfSgl3fl5kAAaQ9d8cl5DgWJ4xW7r2fkNnZJkxPWSd3jrirKfkwqNnMTSOGw1xAeyPdEuDYNyd9gAQ9vxtno0XfzFUY7ngDz7/aNmWMbP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780081057; c=relaxed/simple;
	bh=0Ac6Y0XbIulsI8e3BoESoWqp4Ms/oUKG/jhOEdJSmhA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eqhxkz7+H5nS9qp1FFUwoB0iWdW5q92+sh/cHo2uGzJpeiXlT/j6HYYn3c4+D6dE0atmNtn/MjQeK7p0QyajEjnYZwLxhDkUHYKTS1fIdMQ8qgy6Wf1XELYxI7J7zTa9QRzd0yXG+2kLz9n5zNuzZYuv9fBzgBq4c71Vn5o1XuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SauZxRkt; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SauZxRkt"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bc02d28b6so900083a91.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780081056; x=1780685856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=trcaqpaPheQ9pegSLrZ7Icm7wT70eldJiw4H2do/7sU=;
        b=SauZxRktoPsuynO4ZMeyfuGk0OLrdzEAD6RfSDjb4T3pyfX83zbYQVqWjigLD579EG
         rqoTvY6RCixCUUiLEj1+tAXAa7ZXA1RfC3VC4OgY0yuDDWTi0FLrtDfzffSSjKM2/tYi
         6CZqT6VBsDvgYwMYom8Wy2RkWf4WMNVdS+M6PRUF5vn55ndJ64M7hkFbNDB7I4ofL/Vg
         U+v7aX1NZRJ9ZWVyPFoan+Ufjt9o7qIeHrM8AlpcUjFgyDoSgmD1iaB3icCNEhe/s1SZ
         zJNZhOJU+BEyZOOVK5Vq1y7jxwOIUxtHk8rS3x7mpuQXfgPro4VTBk3s5/t1orZyzMj0
         qXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780081056; x=1780685856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trcaqpaPheQ9pegSLrZ7Icm7wT70eldJiw4H2do/7sU=;
        b=IVx5fhziVO2DFG1BQjholOptK892TovauRIC9NR2EpdqxriR+c45P/ByJ44qOt6hRl
         DgoKmBR4tL/xhNE3p0Iofo1YTpErbUP8t/HZS4ZTTxKDgkSR8+Zt1khKoq+mdM5gKd1e
         xB8lNB3Cl/ggZDPPsg1iNIghKzeTltm6UGZE+sbyjM06Us1f0HePjSoPOYVtUDzb1bfg
         IIo4LTuqToWssdI/gIsjNCW8Cp0FzIcPR/aKGssatnbrjqhnAh24CsutlOso4xcBN+FT
         xTlS1AI/S/hG32IfeXCZ8/CDeiT4w3b+VBAA0ln1/jTsqe2X3fFoimcaJM9xrqr0RLz0
         RUvw==
X-Forwarded-Encrypted: i=1; AFNElJ9VeBYqaa+imKsbtQgH6SIiBFNNJKSEvDYB2DjgDRmLtgtSFx8fT99MFbhZVnHv/25oMyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWUr9cODkriCIdux3MOoEtxg0ZVtnrevn+nJYhTvlck0qcV8nP
	hbLQ1duwRtNsJy1kn2SbkucO4639P9fSMdmRRg5yfvMKI2whV5kyH2Zd7lQHw5zi/rIti7fCKpw
	oIFXAEw==
X-Received: from pgc24.prod.google.com ([2002:a05:6a02:2f98:b0:c80:192c:51ff])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce85:b0:2bd:4d4b:9143
 with SMTP id d9443c01a7336-2bf36795110mr12953405ad.8.1780081055498; Fri, 29
 May 2026 11:57:35 -0700 (PDT)
Date: Fri, 29 May 2026 11:57:34 -0700
In-Reply-To: <20260529181213.0B27A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-18-seanjc@google.com> <20260529181213.0B27A1F00893@smtp.kernel.org>
Message-ID: <ahnhnjvfIblFxTFX@google.com>
Subject: Re: [PATCH v4 17/47] x86/kvm: Mark TSC as reliable when it's constant
 and nonstop
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 29, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index 909d3e5e5bcd5..4fe9c69bf40b3 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> [ ... ]
> > @@ -1040,7 +1041,20 @@ static void __init kvm_init_platform(void)
> [ ... ]
> > -	kvmclock_init();
> > +        /*
> > +         * If the TSC counts at a constant frequency across P/T states, counts
> > +         * in deep C-states, and the TSC hasn't been marked unstable, treat the
> > +         * TSC reliable, as guaranteed by KVM.  Note, the TSC unstable check
> > +         * exists purely to honor the TSC being marked unstable via command
> > +         * line, any runtime detection of an unstable will happen after this.
> > +         */
> > +	tsc_is_reliable = boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> > +			  boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> > +			  !check_tsc_unstable();
> 
> [Severity: High]
> Does this evaluate check_tsc_unstable() too early to catch the command line
> parameter?

Huh, it does indeed.

> It looks like kvm_init_platform() is called from setup_arch(), but the
> tsc=unstable kernel parameter is parsed via __setup() later during
> parse_args() in start_kernel().
> 
> If check_tsc_unstable() evaluates to 0 here because the parameter hasn't
> been parsed yet, wouldn't it incorrectly force X86_FEATURE_TSC_RELIABLE
> and set prefer_tsc to true?

Yep, but this is a pre-existing problem that goes all the way back to the original
commit 7539b174aef4 ("x86: kvmguest: use TSC clocksource if invariant TSC is exposed").

We could try to fix that, but I'm _very_ strongly inclined to add (yet another)
patch to simply drop the check_tsc_unstable() since it has always been dead code.
