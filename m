Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF4031F983
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 21:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783459538; cv=none; b=csWkYdY7DT5GDVynwD8zROnPQkQTeKFncJDmoMdM3EHrzqn2HDyEqKtX8xCtVqOUrvO1lEYnGK6oiOE1BlvtEWUu0koSCIHHxtot8xR5hLPvph9FDccH73ODVb21OeRE6DRd1E9n/bjdRHMahdocPL9bNrW09xKC1yOyf6yPHSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783459538; c=relaxed/simple;
	bh=pOdXM2oymvr/smId1Omver3teKkaw9mprd4E/4+VOz0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=irslMH+289KeJSuYVLiHdXXd3D+m3LX9WJPzkefvVX4PTv/8nEzcGvEs4u0ze51+opc7rxe6kuz0dUl9G/5Z/bDikmbAIq8pzYyiNTSLR/fLjDIZIRDkTzSINV2KFXzfgo8+Hyr7I2GlYzGqvYqzNCSpK+kEs5r18mwZASg8HBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q8/Yg795; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8/Yg795"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cc77a6943eso1223935ad.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 14:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783459536; x=1784064336; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZUVoSE8UgGc/A9+Kf+89pNsJjY/CmRXkhT+zbp2ozz0=;
        b=q8/Yg795TXs5wdjYUEwqXfN3toNwB9VEmE0qYLHzDKs0M9db/Mn3Ctl7l9+1Wpp4RU
         BOgD+U2kJZjgW/tunnVRjEnDZ+URZ00OXFbuU8ICyZB/RHRzwRjFN+82d+cG/1uVtHT7
         8go69zdiYREwQDo1eVZk1tCZeZZMl53bNjl02PD/KVfLCTqfhWUQLDGV9tAMXnVISaC3
         Y2C7PC41KOPYtowH8jnEfZYlj4sYObjY+YvRtMHkf7q0kffF0+oSE+OdG67uHnsxrHGK
         d5r50qO7nv0E3WWtCMsJwzS40XZ9cSOzIyTnQjB4xNlj7ijRR3WUaVYWN9eLi2VQJU0+
         qJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783459536; x=1784064336;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZUVoSE8UgGc/A9+Kf+89pNsJjY/CmRXkhT+zbp2ozz0=;
        b=g9tnt1+shMwDlNIsRMzVXtg5e+T+3kVNB0kjxmTNjZgGm++b8im6JIzZ7heorV7ILs
         8g+yIPiIsaw16M2krdAugNmBXpL+uh92SfYPJk5J2JpkzcgSx7L+U3pqJUchkWWBPNn9
         S/MnXV6kaFlqMC6oFh4yR2ypCoup4HGTwPkZdQtjXEmDd/9ed5+acrwRkMSkrdXLkx27
         Ql3BBHoqd5w0K77q1vEBTiS8Q+019cJLulDSJD9Un4V+HMavmZWf+hQ3I7lyZB7dJi5j
         7KGeHAXFWUNwizRcsm7aqfNrPZDA8bp6Qd3XWKX+A2vwE88TZ3xLdWe3De2MRyW6O/q4
         FwvA==
X-Forwarded-Encrypted: i=1; AHgh+RrZIzkts0gK2CUmvD9izHdCjn4mCDnBfeQ665bICT78Zj1v8t5wFYtOOXjeqC0X85Df6kA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz71/q5PWHk6VEfaEtMMdc0kvaWYtHhMS0RP9WDnZurGpBZToXh
	vJfadBCmp7OE9t4u1RFMKNco6ml+awU/2/lYB8k/VoYOE5B63Y4WEqC8yRJbdTGBZ2fD85n6fsv
	rRRQEBg==
X-Received: from plpn4.prod.google.com ([2002:a17:902:9684:b0:2cc:8aff:d1e5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:248c:b0:2ca:11af:5ee9
 with SMTP id d9443c01a7336-2ccbf0515c7mr46279875ad.25.1783459536408; Tue, 07
 Jul 2026 14:25:36 -0700 (PDT)
Date: Tue, 7 Jul 2026 14:25:35 -0700
In-Reply-To: <20260625212001.3B6561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <86078441-92eb-4461-b823-7d3539ac5859@mail.kernel.org> <20260625212001.3B6561F000E9@smtp.kernel.org>
Message-ID: <ak1uzySYz-i1EImO@google.com>
Subject: Re: [PATCH v2] KVM: x86: Exempt in-kernel PIC from "disappearing"
 interrupt warning
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: syzbot <syzbot@kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 25, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> [ ... ]
> > @@ -10857,7 +10857,9 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
> >  		if (r) {
> >  			int irq = kvm_cpu_get_interrupt(vcpu);
> >  
> > -			if (!WARN_ON_ONCE(irq == -1)) {
> > +			WARN_ON_ONCE(irq == -1 && !pic_in_kernel(vcpu->kvm));
> 
> [Severity: Medium]
> Does this inadvertently suppress the warning for APIC bugs in the default
> full-irqchip mode?
> 
> Since pic_in_kernel() evaluates to true when the in-kernel PIC is present,
> checking !pic_in_kernel() disables the warning entirely for all interrupt
> sources in that configuration. This appears to contradict the commit message
> intent of preserving the warning for other sources like the APIC.
> 
> [Severity: High]
> This is a pre-existing issue, but can a malicious guest still trigger this
> warning when KVM is configured with a split irqchip and Xen emulation is
> enabled?

Argh, yes.  

> If a guest concurrently toggles its evtchn_upcall_pending flag in memory
> while the host executes the event injection loop, it seems this path is
> directly reachable. 

Even more coarsely, userspace could disable Xen event stuff entirely via
KVM_XEN_HVM_CONFIG.  The easiest fix would be to condition the WARN on
!IS_ENABLED(CONFIG_KVM_XEN).  We could track if the VM has ever used Xen
emulation, but I don't think that's worth doing given that many deployments can
and should disable Xen emulation.

The other annoying issue is that vmx_check_nested_events() has the same flaw.
And I definitely don't want to toss that WARN either, because it recently found
a real bug that actually matters.

I'll send a v2 in the near-ish future to weed out CONFIG_KVM_XEN, and fix the
nVMX case as well, hopefully without having to duplicate too much code.
