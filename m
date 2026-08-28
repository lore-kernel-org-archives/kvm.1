Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB7F34F279
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787926987; cv=none; b=O9V36i9oE3+kXCWUagR6RQItNfnmlcH3Gyv86KE5+RrSGpCwUDcTHwuj9irWxYVXY+t+8aXW0GM0ExYYwaXhnbkrWv5HSBhJNIKBAovkS6gwDqOz9q1g4CFSAU0+Jg/Por/iuplvrYpJKbrrDgBsnV0/gAQQpXfLKXioh3Z7gYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787926987; c=relaxed/simple;
	bh=KN68LRoIM5aVi7AQOx7nnvGNWU1Z0eIPdG2ZcjuBWZ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AKfyYMRlOacfniaUEGQP86GUTNPaCAvLns9FMhoLyJZ2LQcNsRHRKCSJRY0lVIZkRsweYzlER3iAIZpOS2ClylUJxI0o3vKPs8vu0iLa1IZd6NuSvtytn6l+YmlYMx7hP5lWSwrUl+IS50v5RKEV7VlRTy/qCMVCqjU++/7z3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AtBGxg8+; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AtBGxg8+"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d7151120d6so20370655ad.3
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 07:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787926985; x=1788531785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uMXimE85N6j1kkWKNP1joCUzxKs1AFORqZCP5bF0HOI=;
        b=AtBGxg8+z7PPqyjmmc+Ee5rZdI/3S10JrWN9jhx26tPUm0Gc75OeVKGXkyPPj4LT4U
         0fmCZrdEezc8BX5nVCDj8TD1Fbksl5y0vGyVsYIEI8WVeE79nikqz88yyhaE0y+gzeLp
         ib+gUmLUonUmrLc3Eo+EQ33YwPTGliJwxz0G7RHNrc+kLXmuJMXW5JCUhy5io3gy64cT
         yukhD6UOcbivKBMumpC4wkpm36Sz9zFY9dcJLI9Q30l83moMLqr6AvOIfbeQgpqi8EuF
         +7mk6ymBQfJP5a2tMrnFx0YPlEaDeNlr4cuw+Q6eRQJ20/hE3qdBALKM/PvlAP8tfkJw
         lmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787926985; x=1788531785;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uMXimE85N6j1kkWKNP1joCUzxKs1AFORqZCP5bF0HOI=;
        b=XaR5GfhSEos6CujJDiLFgnzoqfZ6QCCTMof1HhFlPRrlIMKSQDhsUfyDXiuMsoPJf7
         tH3gHn3vGpSbcmMLORh2t+8cdvnvV2TmWMg2sAqqVopxUbvyLfgaPqnmd39OgaRuteko
         6uMLdh+TWltcgFLxArvctFDaunSsNPBUGV4itl+RjV8BzySsZHDdpsKgsly8G/ejJZ5y
         IKNEWBUFxOwCWYT/cfILpFMtSh9CsF1Z2p+KaceWPlVwqTdxkmBVjw0KF1fiCku1mNaX
         suZm3qRg+PynYyIyN7oPMAUJ39342DZpo9WE/pMt6q/4LuDUQuYAdyZ8FKGyjNInKuUp
         gMbA==
X-Forwarded-Encrypted: i=1; AHgh+RqHMcYs1ZmhTePhHsnu4u4Uh+MwZbrnjwFSsKNRb8tDrUVIkz9EzNEqlg9+WRhb4bORFWQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nJ40AhXxSDR75ldX8A9A2O+NhPiBJTjaamTic+vleBQGVS3i3L
	p6vGX6dQlk8LRziCp6l6VIu6z8Tx5vP+RBiKpybAeZmvbfI7IoOmvKOCpakKaaFCJx/bfi2isBt
	WExdTmQ==
X-Received: from pgea25.prod.google.com ([2002:a05:6a02:5399:b0:c88:b675:3609])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9204:b0:3d3:aec2:4dc8
 with SMTP id adf61e73a8af0-3d3aec25083mr394376637.20.1787926984486; Fri, 28
 Aug 2026 07:23:04 -0700 (PDT)
Date: Fri, 28 Aug 2026 07:23:03 -0700
In-Reply-To: <33dfede6cca76de14ecffaaa92fd89da4114c94d.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <8d47b43e1829ac92703723e6a1a4afc7a2eaacb5.camel@infradead.org>
 <apCwV7xenDh2qmr7@google.com> <apC3lYri5r4KUM3T@google.com>
 <20260828104537.pXtV2G8D@linutronix.de> <33dfede6cca76de14ecffaaa92fd89da4114c94d.camel@infradead.org>
Message-ID: <apGZx3fhmzRl4Td2@google.com>
Subject: Re: KVM: x86/mmu: __kvm_rmap_lock() preemption assert trips on PREEMPT_RT
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, James Houghton <jthoughton@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026, David Woodhouse wrote:
> On Fri, 2026-08-28 at 12:45 +0200, Sebastian Andrzej Siewior wrote:
> > On 2026-08-27 15:17:57 [-0700], Sean Christopherson wrote:
> > > > @@ -1745,11 +1754,15 @@ static bool kvm_rmap_age_gfn_range(struct k=
vm *kvm,
> > > > =C2=A0	gfn_t gfn;
> > > > =C2=A0	int level;
> > > > =C2=A0
> > > > +#ifdef CONFIG_PREEMPT_RT
> > > > +	guard(read_lock)(&kvm->mmu_lock);
> > > > +#endif
> > >=20
> > > And now I remember why I swept this under the rug.=C2=A0 This really =
should take
> > > mmu_lock for write, otherwise concurrent aging threads could theoreti=
cally get
> > > stuck competing for KVM_RMAP_LOCKED.=C2=A0 Which is silly, because th=
ey don't actually
> > > need to take a lock of any kind.=C2=A0 I.e. it's not super trivial?
> > >=20
> > > Wait, duh.=C2=A0 It is trivial if mmu_lock is held, because then KVM =
can operate on
> > > rmaps without any KVM_RMAP_LOCKED shenanigans.=C2=A0 I wouldn't test =
this because it
> > > might break horribly, but I think this?
> >=20
> > So you drop the bit spinlock and rely on kvm->mmu_lock instead?

Ya, it's basically a revert of the per-rmap locking, but just for PREEMPT_R=
T.

> > No sure why it should break horribly but it looks reasonable.

I wasn't worried about the locking, I was worried I was forgetting an rmap =
detail,
e.g. I almost forgot to update rmap_head->val in the "unlock" path.

> FWIW it survived the night in my GPC invalidation torture tests.

Awesome!  I'll throw a PREEMPT_RT kernel through the normal testing and hop=
efully
get a patch posted today.
