Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A6E21257F
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786062456; cv=none; b=fm0T5wZhGy48xa15VbC3mcfd9ncRCLPkdSgz5yV1YdWNxHmXiVmaL8L2XugLln6kwXmfOHX1vmJMMb0Nb/T3kGP5++F2JED3S2UicxGzXUkM937bMrmycbFVSNPEl2+NilQNviOP/5knSUQlPsXBZuh8w06A+yL7Sjn7Ioa32OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786062456; c=relaxed/simple;
	bh=s4ld6/Vfb2w1YRnUk1r2bL4X/XVPlnFkAw1PKPru48E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rTjMaDK9vrWIqIu8QJAcL7DkK23Cg+1iKk0Lvo5SydGgpEfM/X8jHMw2Tv2kFfyrWWsza5+MkXfLF1eXdkO9yaLM607m2V1vX1Eqk/83F5tEqxtPIb6CkGtQXlF9HvXGbF5Ri3Z8+pYnBsUSMyyDL3l1ZzNaZ1tIHOXMFnB+ZBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aw4uxcQW; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aw4uxcQW"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc5faecf01so51698245ad.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 17:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786062455; x=1786667255; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xKyn5cwk7Lgqnga1QgDwp0/460XhyRh/fsWVnYx/SKo=;
        b=aw4uxcQWO2jbSnyxtpjViirIoR70DDobR0UBhKOKSSqsLhsRABwLc4zSHbSQOmFvZc
         YakaV3tU9sujsaP4iplsT3uv+pdXfYVdpqqEXsYIh5W0Ym5DclrrGhMXR3wxFivAhpoE
         NpUYEIceexYM1HBecYAwtRk34skGNPaC0fseOXlzYyyJJmeWfLcmKWvP847ZSWOlQb+5
         wBsSgVKph55aXD6iDj3whV7mGL42pF1A459GAQRBhmD5+bFckUtSfDyWMPJmYl9JEcxo
         rqv5jIGGkmCB+Shu1sPwOFtVGm/idE52aKC+x8HzVRoCNMHFuOSjqbXUpNO7yA04ecbb
         zUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786062455; x=1786667255;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xKyn5cwk7Lgqnga1QgDwp0/460XhyRh/fsWVnYx/SKo=;
        b=i6G9Fi0Ik8HZMmUxcFj8XgtB9JwiIvlLB3eCV7yRgddbGhhHT4mH8+sWiifMzS9kJx
         UZk2aCZ4WEfgv6e6wGc6h3iLAWM0ek+Pxf13SLKmSt58k4F3kISVrxviLgryzJe1fgeX
         xnOOMUPinUutWLaj01jDCicLtsgFDcN+3r5EBzyD/m2wj1Xi/mVxjR7idXiT0b5dZpRK
         Q05poxfaUnkt1AK28IKroGu7SbVgy4ZGTOlMqVoqu4kdINN2rGTiynuF5rqXVNpD8J2T
         TL9w7hYOMtLt1pTkI06hfyro4iYhnI6CJOzniDKrVj+NPHsh2Kd1SpH0IAgL+q92VUuK
         1rBw==
X-Gm-Message-State: AOJu0YxVE6tshlTfpwveo0TWkHswTJQK1r0MZz94p4Djfd6TWYlymAVO
	qpJFr3VL0y+R3kK3WAZP5vqrk5lNlgYCOJeJfUXefNbtZ7VB6mzm5H261TSRczNpkaOTbDGz+uB
	V4+Bwkg==
X-Received: from plda18.prod.google.com ([2002:a17:902:ee92:b0:2ca:cbc9:76fd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e852:b0:2ca:10c6:f69b
 with SMTP id d9443c01a7336-2d0ca7b54ebmr187122615ad.5.1786062454618; Thu, 06
 Aug 2026 17:27:34 -0700 (PDT)
Date: Thu, 6 Aug 2026 17:27:34 -0700
In-Reply-To: <anN_J_KZhVJ1zIeI@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com> <20260804233923.3504629-6-seanjc@google.com>
 <20260805000221.B63F61F00A3A@smtp.kernel.org> <anN_J_KZhVJ1zIeI@google.com>
Message-ID: <anUmdhx0Dh-yd89z@google.com>
Subject: Re: [PATCH v8 05/17] KVM: x86: Avoid NTP frequency skew for KVM clock
 on 32-bit host
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 05, 2026, Sean Christopherson wrote:
> On Wed, Aug 05, 2026, sashiko-bot@kernel.org wrote:
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 3107878a6fe5d..8f469fd9863f9 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > 
> > [ ... ]
> > 
> > > @@ -915,13 +914,6 @@ static s64 get_kvmclock_base_ns(void)
> > >  	/* Count up from boot time, but with the frequency of the raw clock.  */
> > >  	return ktime_to_ns(ktime_add(ktime_get_raw(), pvclock_gtod_data.offs_boot));
> > 
> > [Severity: Low]
> > Will reading the 64-bit pvclock_gtod_data.offs_boot without seqcount
> > protection or data_race() annotations trigger KCSAN data race warnings on
> > 32-bit systems?
> > 
> > By removing the ktime_get_boottime_ns() fallback, this read now executes on
> > 32-bit architectures where it compiles to two non-atomic 32-bit accesses.
> > If a KVM vCPU thread calls get_kvmclock_base_ns() while a timer interrupt
> > runs timekeeping_update(), it overwrites offs_boot.
> > 
> > Even though the value only actually changes during suspend when the freezer
> > subsystem guarantees vCPU threads are frozen (preventing functional tearing),
> > overwriting the identical value concurrently with an unprotected read still
> > introduces a formal C11 data race.
> 
> Huh.  And strictly speaking, 64-bit could tear the store/load.  Stealing heavily
> from ktime_mono_to_any(), this as a prep patch plus fixup (not yet tested)?

LOL, hilarious.  I was cherry-picking the rest of the series on top to run the
tests, and discovered that "Compute kvmclock base without pvclock_gtod_data"
does exactly that: uses ktime_mono_to_any() directly.  So at least I went in the
right direction?

David, is there any reason that patch needs to be 25/36?  AFAICT, it slots in
very nicely before this patch.  Then we don't need to do the below, because
ktime_mono_to_any() already takes care of 32-bit.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b6e1dfd6db6a..57679d871581 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -921,7 +921,8 @@ static void update_pvclock_gtod(struct timekeeper *tk)
>  
>         vdata->wall_time_sec            = tk->xtime_sec;
>  
> -       vdata->offs_boot                = tk->offs_boot;
> +       /* Pairs with the READ_ONCE() in get_kvmclock_base_ns(). */
> +       WRITE_ONCE(vdata->offs_boot, tk->offs_boot);
>  
>         write_seqcount_end(&vdata->seq);
>  }
> @@ -929,7 +930,26 @@ static void update_pvclock_gtod(struct timekeeper *tk)
>  static s64 get_kvmclock_base_ns(void)
>  {
>         /* Count up from boot time, but with the frequency of the raw clock.  */
> -       return ktime_to_ns(ktime_add(ktime_get_raw(), pvclock_gtod_data.offs_boot));
> +       struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
> +       ktime_t raw = ktime_get_raw();
> +       ktime_t now;
> +
> +       /*
> +        * Synchronization with clock updates isn't required on 64-bit as only
> +        * one field is being consume
> +        * */
> +#ifdef CONFIG_X86_64
> +       now = ktime_add(raw, READ_ONCE(gtod->offs_boot));
> +#else
> +       unsigned int seq;
> +
> +       do {
> +               seq = read_seqcount_begin(&gtod->seq);
> +               now = ktime_add(raw, *offset);
> +       } while (read_seqcount_retry(gtod->seq, seq));
> +#endif
> +
> +       return ktime_to_ns(now);
>  }
>  
>  static uint32_t div_frac(uint32_t dividend, uint32_t divisor)
