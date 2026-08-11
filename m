Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC94842643A
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786490050; cv=none; b=AN0SNbKaBJDtbJiZ8noCQ75sEfM/k9dmIpClFRUkiYdZNjKzWj8fyNiSGkJpuEk6abXAyipy5BJ685qVsR03S0SwxNDHh7Hw8mGuUFWVgIhQUYihX6aJNzx5ufcXfo6HMMYYLfEr76k6mP+WiByu0NgitBC4nVLKiEas2ZbUX7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786490050; c=relaxed/simple;
	bh=eTsKS/p1yVC2Lax9wd0GxNhGxmDx0nu+r7cGaHMy4LY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lsU1GtgFqmHqHL94c1XbrrdGEIpr+gILQLG/woImT5ta63e0Y+U48VNU7glq7dCzysEdY09GhCd5Vgjrn4sNCkdt81ukqMM+ui+1qJpqzMuDg4s6QvSZMZknF7vbuSBlizu+pbBOTJdGGjY3c2V/UtUewKLzYZP++JGBsvwASrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sSVWtS92; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sSVWtS92"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e048a801dso507381b3a.3
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 16:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786490048; x=1787094848; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eTsKS/p1yVC2Lax9wd0GxNhGxmDx0nu+r7cGaHMy4LY=;
        b=sSVWtS92NG0ooEW0xMXwq5mi/3nLH+vMIO8uI/9m0ss5S0ztIe+1YKM78oMPZ/zBSN
         f+liOpCRKtJf2yLwR2i5zARbTQ+f8mXexH7F4LGuA26nJy6dQXFHQVTbcflsTmwD7tFC
         BvQZkS+HhZAcQtYKR6rerXC+4Y/seDII8tjz2kxcqgxDG0aWQf3+6xY6hQUvH/C2jaRP
         ZDUGKfkyyX+o0FX81Ejnd+U5KSMYUaBWhleaDlculk95zIt7WOrIfbOwwmun3AovMM+x
         gJssFmOqxovDMimOqwxM1SUkgprWznhpnej3TGtPWqHKFBoFMwR4DltY0X3nFeTAnOD0
         cXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786490048; x=1787094848;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eTsKS/p1yVC2Lax9wd0GxNhGxmDx0nu+r7cGaHMy4LY=;
        b=f4816Gyy9gSRqNhbpxxi9ogGatKpKjw2b8R9XEvqGuD4yGDovsXQW7qsVePGTaL0AR
         6Q2j0SpVblE3XXxdS1ySwK7xKSM/S7l54sh4Z1/31Q/uRGqkeqE1w1B5WGXm+dvC0bIW
         m58lJ+UNBw+oaXvqaYvHzpCrcOqWC88NyyUnY0ZkZRJ6tzmYPtkyMZalZfZYGQMv3MSj
         rMjoiqd5yh6coHQQk/r2b6d6RFce2ySvxCeIPExktI5+PXJP0Sz8gejjgM10hAx8uAqy
         WhJCOFTSsKs0DyaCpdHjQ4uSkboCPwuuYV5XVgDN7sRB2t3Btni/eXjCQ/rfeI4cZH9H
         zgsA==
X-Forwarded-Encrypted: i=1; AHgh+RrzgIREYITkTsV/KW3QhwXvFhIz6OIMxTLqNTlMg06zoRstFnFRvGRTPfkZABe0FGqI/+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8nVj49KJUIkwtJCASpOnNfTrT4mkWkf+bjAagF8DW/mCbuZ1j
	sYTjlvLQlszq/70OftQPv0XPtVbgNh0NqMa/Vt7D4WHZotd0POLo/BQkzK8g331udt4aRs0jH9a
	RJyf4tg==
X-Received: from pgcc19.prod.google.com ([2002:a63:1c13:0:b0:cbe:9dc7:9ef6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3497:b0:845:e8b9:347
 with SMTP id d2e1a72fcca58-84fb5404a23mr903157b3a.13.1786490048024; Tue, 11
 Aug 2026 16:14:08 -0700 (PDT)
Date: Tue, 11 Aug 2026 16:14:07 -0700
In-Reply-To: <5efe7a3914a3610ee00a487379caff84af6aa731.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ansywxh0VX5rtfWc@google.com> <e256fa4af96e916ba30019cbba501fa896025fb0.camel@infradead.org>
 <antQYJvRxJxOjtut@google.com> <f5dc701cf3319a7b3c8fd1497f26d051aa9fa3ba.camel@infradead.org>
 <antb01WqOrs-tztm@google.com> <6ab49538675d97f1f4bf01574b1b066aae0bc05c.camel@infradead.org>
 <ants4VjfAiblaWsl@google.com> <3dc73f745b6abfd1eb53e7d3fce2067eaa3b3c92.camel@infradead.org>
 <anuYNxD81OE3MrQw@google.com> <5efe7a3914a3610ee00a487379caff84af6aa731.camel@infradead.org>
Message-ID: <anusv0DloFhLMMoW@google.com>
Subject: Re: [PATCH v7 17/36] KVM: x86: Allow KVM master clock mode when TSCs
 are offset from each other
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026, David Woodhouse wrote:
> On Tue, 2026-08-11 at 14:46 -0700, Sean Christopherson wrote:
> > On Tue, Aug 11, 2026, David Woodhouse wrote:
> > > On Tue, 2026-08-11 at 11:41 -0700, Sean Christopherson wrote:
> > >=20
> > > >=20
> > > > Ok, I think I finally understand the goal.=C2=A0 I got turned aroun=
d by the combination
> > > > of the name SET_CLOCK_GUEST and the full pvclock structure being pa=
ssed to the
> > > > guest.=C2=A0 I was expecting SET_CLOCK_GUEST to literally set the e=
ntire clock, e.g.
> > > > mul+shift, timestamp, etc.
> > >=20
> > > That's an implementation detail.=C2=A0
> >=20
> > Yes and no.=C2=A0 If the payload didn't literally have all the assets n=
eeded to set
> > the kvmclock fields, then I wouldn't care.=C2=A0 But I don't think I'd =
be the only
> > person to see a GET+SET pair and expect GET to return exactly what was =
written
> > via SET.
>=20
> Sure, but right now, even a sequence of GET+GET+GET won't necessarily ret=
urn
> the same answer three times in a row =E2=80=94 not just because we haven'=
t fully
> eliminated the non-masterclock mode (which we might never do) but because=
 the
> masterclock mode itself isn't truly the first-class citizen =E2=80=94 so =
we have to
> kind of reverse-engineer it into the per-VM clock data, and then build ea=
ch
> vCPU's pvclock back out of that again.

True.

> We *ought* to live in a world where that pvclock information *is* the
> canonical source of truth, and any series of GET/SET/GET/GET/SET should n=
ever
> see it change. And we can build our future-looking API around that model.
>=20
> I think I do stand by my claim that SET/GET/GET potentially having *three=
*
> slightly different sets of data is an implementation detail that we will
> strive to eliminate.

I'm not totally opposed to a broader GET, but we should definitely get Paol=
o's
eyes on this sooner than later.
