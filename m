Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23E3D0BE5
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896475; cv=none; b=S4RPC2fCdispDCOucZq39hZOkFt6YlXiSM1ddQf3ycFyI2chcLxXOMa08UwOMVGzwGLfRO5GhwUVFoPB/fAXi5gjWPwjRZFv9orInHF5fNZeWp9EA07+n8qlgyljrIvijZ/bC2DiuHJ459YFDieZB1WNLDumGf+ibbXL6AZbi08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896475; c=relaxed/simple;
	bh=0Rhjk21hZ6lZTimafBQ0Ma4YsC6s1PNHBgjuxCWjeXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lpwo+gZaQQeprXymxLyd2zrd258ph2WprGaxu0ACULdA8nNr4WGzuY2BdcUJ4lsX5AyMoscrTN8bubmSg0udlzkW7B4oVr/bLgO/6GNIcnsbDUGMQvqSjF8p99iUkvqj5s8nTnM7uHp6i4XWb+Rcu6es9sRpmd3nwd3XLUt10mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fsg3Cn16; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fsg3Cn16"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82bd90afbbso6056799a12.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779896473; x=1780501273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Rhjk21hZ6lZTimafBQ0Ma4YsC6s1PNHBgjuxCWjeXY=;
        b=Fsg3Cn16Q+YiWEyuROxt3lx+RT3n9tRqUokf4LpfWdSgOf0LvYPEe4NBBtRqFIr9AF
         jKAwD/00zwgTyEiNWLpto0v3o/ES7/2IE/Ni4Y0gWMsyvYb3Q4sSA7c3SCabqNGSqzQv
         4YlI5OZG86bAbAnk8YmqzHcfDCbRRvIOAF2MkNHpUS3ZY/FUf+PTSzQepNDQAXb8RltC
         rdhECwtukApdGWWIc4e7p3LXPjKCJIvK816VSb+VpSWQdFZiLZfr4P/iDyCzph5PSA17
         M+eZkDgHeTw7swd0nxcfYQgSjBH5toW+qhTIdZIcDjE4/wEiO5UM3SrmLvENEU945PxU
         Lgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779896473; x=1780501273;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Rhjk21hZ6lZTimafBQ0Ma4YsC6s1PNHBgjuxCWjeXY=;
        b=kAQT4Hz+QCD3yX37q01xWPSwDn10teSgzGF1kwjrj3PkweNZwRI9ieIW3E43KUGafI
         PMNR0oMF0jQSsMOVkz7W71Wm1icMBmfziW4fa6fkbZwu5zaBrKQFXn76N8IEFoAIDKaV
         G4nTJUKkSmIr3pOd4i+p8PpHiVZgjw3+IpMdPjgU+epG1SHs9Ul49DvVmj0zFGdHRlo5
         gxuY5EnwQP3H3NBItNu5iyL+GJH+5/tZRDu7AmFOX/V5mYsMmwJZuscoDfp67UjG3HDs
         kmKpT9HDKcnySDeRUkIe2+VaG4LXiTXZHukxaLO3rATZ5ApJA0tgRyWunYhJqFXkrH6D
         ZRog==
X-Forwarded-Encrypted: i=1; AFNElJ/3hqWf1OhfjDvCmMlv5/vBb5cCaNU0v247UXEuINi6WHPynmfHbXKiLyQwwYnFX94Xeks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+iP4Wezk+ngRMOfxy53aXoEYKlXMU9IUT4Zp7fVMXnScmqovH
	27DsBydjKd1nmpLag+wXmd3nNicKnKKhRKp5D3rz02P/Bg2UKpp0PllWmV1q2KqC9PFqQ8UUBH/
	qUfw9sg==
X-Received: from pgiz7.prod.google.com ([2002:a63:c047:0:b0:c82:7907:76fe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:914d:b0:3b3:11b8:f5e1
 with SMTP id adf61e73a8af0-3b32935e201mr24427726637.34.1779896473054; Wed, 27
 May 2026 08:41:13 -0700 (PDT)
Date: Wed, 27 May 2026 08:41:12 -0700
In-Reply-To: <09aad595-c4ef-4cc1-8aaf-e2300fe5a619@grsecurity.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com> <d2f3be07-b930-402d-bac5-63a21877f6e2@redhat.com>
 <092d0688-0c8d-4b82-bb62-abeb26845df3@grsecurity.net> <CABgObfayKKDr9birEVn=QMj3Lxi5wo9GnxsSDcZByxEC+HA+Ng@mail.gmail.com>
 <09aad595-c4ef-4cc1-8aaf-e2300fe5a619@grsecurity.net>
Message-ID: <ahcQmNWSroRQj5B0@google.com>
Subject: Re: [kvm-unit-tests PATCH v3 00/20] x86: Better backtraces for leaf functions
From: Sean Christopherson <seanjc@google.com>
To: Mathias Krause <minipli@grsecurity.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026, Mathias Krause wrote:
> On 21.05.26 12:48, Paolo Bonzini wrote:
> > On Thu, May 21, 2026 at 12:35=E2=80=AFPM Mathias Krause <minipli@grsecu=
rity.net> wrote:
> >>> I'm applying patches 1-18, adding the last two give
> >>
> >> Looks like Sean already integrated them into
> >> https://github.com/kvm-x86/kvm-unit-tests, including the fixups that
> >> came up during review.
> >=20
> > Oopsie. I've merged manually everything from there up to commit
> > 0ddb0873cf4f1bd584c0981836778b795bab94f0.
> >=20
> > Let's post what's left as a new submission to the mailing list.
>=20
> In this case, Sean, can you please fold in the fixup for bbe76fbda4e1
> ("x86: Prevent realmode test code instrumentation with nop-mcount") I
> posted at [1]?

Given that the last two patches are yours, and that I can barely follow wha=
t the
patches are doing, can you post a new standalone mini-series with those two=
 patches,
and whatever changes are needed to make 'em work?

> The cc-option test for -mfentry is probably too conservative but there
> were versions of gcc between 8 and 9 that did support -mnop-mcount but
> not -mfentry and the latter was, apparently, not needed until recently.
>=20
> [1]
> https://lore.kernel.org/kvm/092d0688-0c8d-4b82-bb62-abeb26845df3@grsecuri=
ty.net/
>=20
> Thanks,
> Mathias
