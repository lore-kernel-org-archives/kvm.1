Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7B93EB10C
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946952; cv=none; b=Ox1K1WXNiB8iJaiEIGt3P3MI1M5A69d2KxjVTD9nK180gBzjeTgN0WDnfKZJCla7Ka09zbK/5c1QD6h04YGRDD2kvhhkps4fijOj0+t2kF0ZO77k9fHX0288tx+2AbVI9lKTjn+M/ExMBHdwp/4Euv/h9yYjWuYM5ePOnXnmA2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946952; c=relaxed/simple;
	bh=hzAEZfHfz3LBP2Um9gcgl4RChWFL9tShRjbTlGb2/U4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gTxC40MUcl4QJZ1HW4YiC6hgmQxrMHTq/rWQI6OTNvC10raE7pRUyOFoX43k1+iKy3UcBm2wfbO+MbMl1xGR6rV8YCxWYAPzBOVZLkS9yRaJAme8Qmp5jgPm8RByOoEJs+MKKNtr4qhC0LwGvKQQXN0ReoFLGHk+BAJ9pyU53VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EgCK0ctD; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EgCK0ctD"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cce14a21faso461505ad.0
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785946950; x=1786551750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uvAahgqgkqHs7pRp0ExYF6yyigspnFoR+gCKglHPWIY=;
        b=EgCK0ctDupjRYM4vFBSBZ0uLtswJLZL+GhrXpvzhTbZbr9aNso8AXhpQ2ZXbIaN/tq
         E6vQrcZPbRygn8K/O8mqZJTn4QLtLBeX1tuFQ0aSFJ4VesPhBrjpx6FCG1Mm7dNKjkS7
         hcIIxprGsKusTPRWCcYOfxZYVl3k7uZJU5lGd+30lmhzL9uOHqElLSzqJ7FsB21///CR
         H3SgPfI66qtHGz7ZGptodX2scGohm1l1uuc0iDkmp67/egWVoNrDknDngzYSQfvx4SHX
         zrAOM5Smi1rheOeLGbOSlcits4VuJOAkbuCiwkJmJx/H16ALTMSxvcf6KhiuV5Ea9gwa
         6JXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946950; x=1786551750;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uvAahgqgkqHs7pRp0ExYF6yyigspnFoR+gCKglHPWIY=;
        b=UCFI3ALx/qDaGiVsVXHT3oz4iEtvJjjFsxLQ5w7NDW52kCzBhVm7X1oL89IkYOEr/T
         xVlk+p509jI2Sz5iH+CZlGX3jmd3nam8yByixK9LfAb5aXKQChtpci+JwJmokUlFScXf
         6rVyVqOcNeCdNTAjGE82gPZ4+3Kr4XNrAWgWUJyPaxwqDTBcJIr+rnUCGAJo2d/EVlqn
         T2iMSz6+mz5qBIh4+lQPX+Obxi/heHTujsAO39a2e/mw7ohvOfWAi4XFAP4NCItq8GCI
         d1tVvloa1AK4K42JWGOftVwpecHZ97gTEAFC1+S3JG+t3eFKVw0Xzrf4PNsPKC16AKb0
         18bA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4TC4YYltK/YMg4f9K0k9eIyroZH7hpmPSHt8UIXhr54nppF+E3bwUo5tliAP21KbKI0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtbUebOQk05PJ4flSlIjX6aIbnSBrF3PW/p0CKSH5MuLpmcyrL
	sChYgH49ZV0PKmE5JnEBHE/CBNExAqAOxAsVbveAHNQmiBIX4egg30s3Nq7JcDVmt3A6meY79ET
	OQX4Trg==
X-Received: from plbd20.prod.google.com ([2002:a17:902:f154:b0:2c7:ef74:dfc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fd8d:b0:2d0:8c40:a788
 with SMTP id d9443c01a7336-2d0f1adb05cmr1635525ad.18.1785946949861; Wed, 05
 Aug 2026 09:22:29 -0700 (PDT)
Date: Wed, 5 Aug 2026 09:22:29 -0700
In-Reply-To: <04c395bb7d7a63e6b38a8d5684cffde1a1ebcf3f.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com> <20260804233923.3504629-14-seanjc@google.com>
 <20260804235652.56E811F00A3A@smtp.kernel.org> <anNTtCYh7BpURA3n@google.com> <04c395bb7d7a63e6b38a8d5684cffde1a1ebcf3f.camel@infradead.org>
Message-ID: <anNjRbdR1P0yZZa2@google.com>
Subject: Re: [PATCH v8 13/17] KVM: x86: Disable preemption, not IRQs, when
 getting TSC+freq pair
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2026, David Woodhouse wrote:
> On Wed, 2026-08-05 at 08:16 -0700, Sean Christopherson wrote:
> >=20
> > David, any thoughts?=C2=A0 I'm leaning towards keeping IRQs disabled to=
 minimize the
> > chances of introducing a regression, even though I highly doubt disabli=
ng IRQs
> > to provide an atomic-ish pair was ever done deliberately.=C2=A0 My main=
 concern with
> > disabling IRQs is that it will further muddy the waters with respect to=
 what is
> > actually necessary, versus weird things KVM does for historical reasons=
.=C2=A0 Though
> > that can largely be solved with a verbose changelog.
>=20
> I'm not sure I'd bother. There are plenty of other places we use an
> "atomic-ish pair", although I've tried to kill most of those by the
> time we get to the end of my series. And we don't disable interrupts
> around them all; why should this one do so just because it accidentally
> inherited it for other reasons?

Ya, after trying to write a changelog and reconcile the new "rule" with the
existing code, I agree.  For kvmclock, the badness is that the guest's view=
 of
time would be off by a smidge until the next kvm_guest_time_update(), but t=
hat's
a complete non-issue when considering that a host IRQ at any time immediate=
ly
introduces significantly lag into the guest's read of "now".

TSC catchup due to an unstable TSC is a similar story.  The "bad" offset wi=
ll be
corrected on the next kvm_arch_vcpu_load().

So it's really just the "always catchup" mode for software-based TSC scalin=
g that
would have a persistent flaw, because as Sashiko pointed out, KVM would adj=
ust
the offset by "too much".  But that's a fundamental flaw in the catchup log=
ic:
KVM should compute an guest TSC as an absolute value by using the current t=
ime
and a reference time, not by accumulating delta.
