Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3663C253958
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402377; cv=none; b=ru7dSwJn7fAKzIoyMrdXsluMAcnsvOr5ZhxD6W9LC04y8mp+8q7e1UWJOCChRUzYofVbfg8mdDCu9nXhw6MFBo5Q9JYsJgE4wEpegauTRi34wW4Iwk89pKV01iM9JwNOGjq2IlHNGyXzcXoxumS9KkhkaY8lXxbgvWFSfn1ZcGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402377; c=relaxed/simple;
	bh=5nphQwRTm4dRsHeGfPoMW8sxguVrvWPhjOBBeyzKy8s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bSN4evyEsaBHVIgPmOCwZ3nZMCCqFNa3G3FyZllojv/6LJQQjqJvxU91grOR+cOt96CH2mpk4MIKXrJXtYNvvmQ+CKq2W8dIvipkpZtIzl/1kPU/xk4IbVXaVqCh9nIxt1058z4JnlA1Ni3dNSXBuwcCXLAHmpUxpY2Co2DzMYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CaJFYxKC; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CaJFYxKC"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c7e921550fso432695ad.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782402375; x=1783007175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2mKkwDWOAeARe21Udp6soz5zRiePOnk40Bo3CgS/YAA=;
        b=CaJFYxKC8WSUs/3kOpw7sGxA8PUneYRC1Q21ILzJjMUf9yfD9vzwZdyAXW2i+3qpDo
         p9ylWi6qKeztOi7H4CT3yvpOYYVu9KerQvkymQQQNgkkO+bgtPMCLkBeGlN0myUOIT/Q
         kC+0Kk4qRAAEq9xfrUOhWl66TTCAw1zCHqEkf4L94d1dfcg8/f24l9oo1zyXTJU9KHnY
         ztPUzA0U67zrz9aHFhywNTWEE/4xi9KDjhRdDIUeUba5yWEbnGo3tqASPLpw6VSn+vXw
         mTl0cRaAeWI3/oUgBj3yT7Fpi4vwNlo48mrQcS3vziOhmFXQpD5JH7uwFs6l8UBU+Zdl
         Yx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782402375; x=1783007175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mKkwDWOAeARe21Udp6soz5zRiePOnk40Bo3CgS/YAA=;
        b=kAdK/zpBrnai+E+ozQ1vHCy8loxk2AoeR7BYNnhugvsiEMIxxha+EAw7BjLrKiivSg
         D3sgob/obI9zUA0bRZ37TlpCdDWjEpe/E2hHpju/vymDYv2YAOO65ddmRIbVGShIZ4+q
         eLST5Qw+PXfS5ySxtmuHeJmVBX3vo4BbJbgkhaBhSa+RCJ6bmubKF7UNZVVWKBh/MLet
         nGQnJO/vy8UvmRHuiFnmpXigLUdJ5/Rq1ZUR3f0fihuFaCP7VgPhIYry6VxbYs+l4zWO
         94wH+fQjVSnMcA3kY75gUZNPLdz5beR2kiow7lUGAbItiN8tQ5zJoaJQ83gchb1Ed6D+
         BoOA==
X-Forwarded-Encrypted: i=1; AHgh+RqO7yFag6RozS+Jcvdftoshvjs1wEB7Ndz8rrI2DM5jZ2XJPsDwSbMgUBuuF2fzXLwlZ1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1F8Jmmc9yBEj4dHHW3JtT5dApySf1UvFciVHj8m1K7+l5gXww
	dMcC3eMDEVX3uHMZBrUHhVLrNXz9N+Oh8P+XDQAX/c5HJIqmDaXK0c7+Ahq4CCQ9D05Um6vclC5
	YEmJWww==
X-Received: from plsc3.prod.google.com ([2002:a17:902:b683:b0:2c7:75c1:68f8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:40d1:b0:2c0:db23:4a4
 with SMTP id d9443c01a7336-2c7fc9cdc4dmr31964125ad.36.1782402375114; Thu, 25
 Jun 2026 08:46:15 -0700 (PDT)
Date: Thu, 25 Jun 2026 15:46:14 +0000
In-Reply-To: <0c183f0f-f23d-45ce-af22-a1f936b9bf2c@0in.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <177749023441.304242.8022456530166067549.reportbug@mspc2024debian.lan>
 <177902420697.2035014.8796825668567298024@eldamar.lan> <agsXnbjjKdrq8e-T@google.com>
 <db210e1d-0d3b-4501-89c5-de7d7de66b03@0in.de> <aiNCq17MbKfs3hGy@google.com> <0c183f0f-f23d-45ce-af22-a1f936b9bf2c@0in.de>
Message-ID: <aj1NRsUIVQRGBqM1@google.com>
Subject: Re: Bug#1135235: linux-image-6.19.13+deb14-amd64: Reoccuring host
 crash "Invalid SPTE change" with gaming win kvm/qemu guest and device passthrough
From: Sean Christopherson <seanjc@google.com>
To: Maximilian Senftleben <kernel@0in.de>
Cc: 1135235@bugs.debian.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

+lists to capture this for posterity

On Wed, Jun 24, 2026, Maximilian Senftleben wrote:
> I tried a 7.0.10 with KASAN for several days, and now I am running
> 7.0.12+deb14.1-amd64 since a couple of days, and at least so far I was not
> able to reproduce my issue, i.e. I had no crash so far.

That, and the fact that 7.0.7 was fine, strongly suggests a broken fix got
backported and landed in 7.0.8 or 7.0.9, and then a fix-for-the-fix landed in
7.10.  There aren't any KVM commits of interest anywhere in that range, which
supports my theory that KVM is an innocent bystander that ran afoul of memory
corruption due to a bug elsewhere in the kernel.

Unless you want to bisect to figure out exactly what commit broken things, and
what commit fixed things, I think it makes sense to consider this resolved unless
the problem occurs on a 7.0.10+ kernel.

> On 05.06.26 23:42, Sean Christopherson wrote:
> > On Wed, Jun 03, 2026, Maximilian Senftleben wrote:
> > > Hi,
> > > 
> > > sorry for the late reply, took me a while to first built the kernel with
> > > that options and then actually find time to play long enough.
> > > 
> > > If I did everything correctly, then I build 7.0.7 with
> > > - CONFIG_VMAP_STACK=y
> > > - CONFIG_KASAN=y
> > > 
> > > I did not get it to crash on that built kernel yet, however I booted
> > > 7.0.9+deb14-amd64 once, and after playing a while got a crash again.
> > > 
> > > I will try using the built kernel next week to see if I can get it to crash
> > > as well.
> > Hmm, can you try 7.0.9 with KASAN?  Or even just a 7.0.9 kernel that you built?
> > It's possible there's a bug somewhere between 7.0.7 and 7.0.9.
> > 
> > > Or do I have to look somewhere else if kasan is active?
> > KASAN reports issues in dmesg.  But generally speaking, if the error is bad
> > enough to crash the kernel, you'll see a KASAN splat *and* a crash.
> > 
> > > On 18.05.26 15:43, Sean Christopherson wrote:
> > > > Odds are very good this is due to host memory corruption, and is not a bug in
> > > > KVM's MMU.  We (Google) had a period of time where our kernel was triggering stack
> > > > overflows if a networking IRQ hit at just the right/wrong time, and whenever the
> > > > overflow wandered into KVM page tables, it would result in failures like these.
> > > > I got quite familiar with the signature :-)
> > > Not sure if it could be something else, however I at least run memtest for
> > > ~12h without problems.
> > > > If you aren't already, can you try running with CONFIG_VMAP_STACK=y?  Stack
> > > > overflow doesn't seem likely in this case since the gfn would put the SPTE in the
> > > > middle of the page table, but it's easy enough to rule out.
> > > > 
> > > > The other thing to try would be to run with CONFIG_KASAN=y.  That might make your
> > > > gaming quite miserable, but if this is indeed due to a rogue write, it's the best
> > > > shot for catching the culprit.
> > > 
> > > Regards
> > > 
