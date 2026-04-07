Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E5D21D3F5
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775585791; cv=pass; b=Pf3OzJaYCWHkpGFa9xOk10dIy0W11VgHi15Cl2o+8KvZ5C3IQPvm5mu9lD8vK0aHJ7aoRJrUk3e15rKx4LNQaLjzEwDgIpVzMDWDJRQ4Z0RckU6Y9Jx1MfOTN611MBUWV6xh82yT/J914R4NCKIIgZkcE7EBeT8aJY3Vl+lVlrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775585791; c=relaxed/simple;
	bh=W6jscBzEMJbJO/XmLXghl25PWfvdo5CVM/yBumOnlxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMU/HoxPF/iXTKH4Pz8t4m5FEv4bPg/55mI/28O6nEaw0Q1BNXEFWZ2Yk10XwXuSkhexJ8gZt3c+3VLIsDqrElC3awUm6IYPS23PnDNgkTLvYqC7Hs7xNveaCULhMLx4lJR7gX+sEKcSxp6iiSffPfG6a+OFf6y/CoJdsUEILTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jydYI3un; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jydYI3un"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a283c44478so5969472e87.3
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 11:16:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775585787; cv=none;
        d=google.com; s=arc-20240605;
        b=YBVCYeWsC4ZZ3J+JIABHz0tupG7hVmIzotFNkha7LcVF4wir68DT2ao85bwT2RV79l
         x3VJELNYVATm4+e7r3IG3IlEkogYgC2TOEGp0UeMKLtmS3RyqdI92CmOh2JInxPYtM/N
         bSipsnD+MqVUSkQNIc3wQ/FDr3eFoEoJMvmq6bJoEJTwsWSbPR7aqmys+w+ACxsqx+C0
         ufZHqOPddJjrgj936Q6yKJ6wRdBBB5Xi4ElDVME4MB+QLBh/ieAWEqUgvsUoLMRzXRpw
         MpPf1DEiLA05YlUg1yp5d+NbQ1FogAr6/1VrCNFk6/M3OsNG85fSjhJA7iN2TeIqaqmB
         /59w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yRsBgBmzp23y8ZAP8I/cBBmEnn+NnIzhpJUPzQOsQ6E=;
        fh=HLGelAaYpWNqdXjluQgBtL8CYD1QPkyCoZy6MNeDnds=;
        b=Czgh1Qt0Oe8ua7hz/y1VDdcWCmgm8EzGDu6QJdMAngiLh6/DjfcOCmGCkeXc59JB39
         FokkzZJwmDG6jMy9pHHpRmEy+tBBKlhxuqADqQhu3TpvCzSevY8b8UPx5ceR3AdwECTB
         TIz1xbFvBzsmFSFd4TKQSGe5Rbfb6uJrKxABO30QkaJwdzmHy2n9Ndsg8cFXYum0xizX
         veuS/NPlgMv53lmQN5jRu4wGeBPXyV82lQt5XOSrHDZcJDUMBbzxEozydDk3g9+2kVwC
         RTNyhOJVYVXLrCwCc9+q+XQEn5FDUezknkq2miwl8FuhVhYXMwRQxWFqUERu9eZa4RdK
         Rf5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775585787; x=1776190587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRsBgBmzp23y8ZAP8I/cBBmEnn+NnIzhpJUPzQOsQ6E=;
        b=jydYI3und1jEzGNu13y56kc2Lbxpuk83U9kprFZ/A0rFbKFZcHcnJS6Cc8r2h1JSbX
         Ch3ixFT+sk9VwjGqQ/n8Lnb3N93TjIJlQtLesl6AgJ72IUHPE24gBpIGEioLHMAxlHYU
         rrVxQCaQbnzDjQQTjCfu3uJJQ/OTtv5AQog99NhYOZK3oCf0TzZ4JlBCsVkPRpqSvdfA
         +zhkp2Ty+HcxTpfTZSB8Sr8qR5qBkcBH9uzDEael4tzzzu+T2h+KpCDjpruP3uSMRFsR
         ZveEG6BFs+7jo9e82dNWNRUwG3Zmenw2q+sdzrtsqz5/OXVMQE5juki8875V2TbrWwQQ
         FWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775585787; x=1776190587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yRsBgBmzp23y8ZAP8I/cBBmEnn+NnIzhpJUPzQOsQ6E=;
        b=k88UzizYT/irObCa7SgMWdWkXsaQKr5UlE/YcNMcTdnRzW54T/p947OVFN0/QIejLG
         okz8FvLNj0sBnVVqyi/XApjhvDI3Cvhh0gieQDCdnZlGlEzQAg+A6KMepyw0IUNYStqa
         kPjZpKZHSXrPkSLSr9FHYqVc+wvOfQGauLfCujwMWNjgioZW1wmiaEdPE8DMyMjZdmUM
         mdGhRgXpr00kSvOFk2Pgakt79eWY3gtU+WA3sczw8M1AnPe2Z23ltSogguvWNeGSoGdv
         dDRauiE88nYHSz1GwBluBxAhMRKnAXGTYGkxJPAIvNvxpr8/BEmaZB9a3aqEVMirlLSc
         T4nA==
X-Gm-Message-State: AOJu0YwIRF3JLivz4zXVnICv4KcWLvr1vctPwiQkWh8Ab1uDreNEPvKv
	neh/+tUDD1PmyiaUr8T1eEUr1eLLot/miLOz9asqOtu/Oty5H2p1BxXeXdMzBFyTI6GdJmDbWI/
	/D57NX1+cw8FKD+vC5iXV5Ww1tj8bvVDTJZGiqEI/
X-Gm-Gg: AeBDies+dOF5ckBalBtJW1dNmhSfOlA5ojrkapaXLoCGucJSEZGiuiw6ZJQGwQY7PwN
	iKam6FsB/VEEV3xlUan29VUEOFCewNaIQN1JlHDTs9OM4tUD2LY5x5GTDjXERcrd2PKXiEINn/o
	Fxx8tuj04ji0ME02MVPEJBxJqd1mbSE5ysf0scph3AM37Ds/K6/t99sObzH+vHiL/05IdLSHgPV
	+skkj5w+enl+kj8IXodQwiWqpeZKdMDKJomybboQW+Ve7IZKoGuJShjEVlUM3VRuROF8cdKXaO9
	G/nBewFFyrFg4fjrWLZIWNXLh3KJxg7ndEaa7dPB
X-Received: by 2002:a05:6512:110d:b0:5a1:2e0c:86f0 with SMTP id
 2adb3069b0e04-5a33758f31emr4771796e87.37.1775585786712; Tue, 07 Apr 2026
 11:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316224349.2360482-1-jingzhangos@google.com> <20260324114312.GA438107@e124191.cambridge.arm.com>
In-Reply-To: <20260324114312.GA438107@e124191.cambridge.arm.com>
From: Jing Zhang <jingzhangos@google.com>
Date: Tue, 7 Apr 2026 11:16:15 -0700
X-Gm-Features: AQROBzDArVOPc6ncoqbb__YZYRwX1sNbl8uVFaZ9pSAZu9OJrkYhbAp3gMqUG8o
Message-ID: <CAAdAUtjeYJ5sOQVB-t7U=KJ9JuCCmO9b2dwJsas7mkzNLu8WqA@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH v1 0/3] arm64: Add Stage-2 MMU and Nested
 Guest Framework
To: Joey Gouly <joey.gouly@arm.com>
Cc: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.linux.dev>, 
	Marc Zyngier <maz@kernel.org>, Andrew Jones <andrew.jones@linux.dev>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Oliver Upton <oliver.upton@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 4:43=E2=80=AFAM Joey Gouly <joey.gouly@arm.com> wro=
te:
>
> On Mon, Mar 16, 2026 at 03:43:46PM -0700, Jing Zhang wrote:
> > This patch series introduces a lightweight infrastructure for managing =
ARM64
> > Stage-2 translation tables and executing nested guests. These component=
s are
> > essential for testing advanced virtualization features such as nested
> > virtualization (NV) and GICv4 direct interrupt injection.
> >
> > The series provides a generic Stage-2 MMU library supporting multiple
> > translation granules (4K, 16K, 64K) and dynamic page table management.
> > Building on this, it adds a guest execution framework that handles gues=
t
> > lifecycle management, context switching and guest exit routing. A new t=
est
> > case for Stage-2 MMU demand paging to verify fault handling.
> >
> > Please note that this is a very preliminary implementation intended as =
a
> > startup baseline for future work in virtualization testing. Users shoul=
d be
> > aware that because this is an early-stage baseline, some portions of th=
e code
> > may just happen to work in its current state. There might be critical
> > architectural elements or edge-case handling missing that will need to =
be
> > addressed as the framework matures.
> >
>
> Hi,
>
> I'm interested in this, I had a much more barebones (aka no stage2) guest
> framework thing that I sent out [1], but it seems more useful to try get =
this
> series merged.
>
> I will try get my tests working with this new framework, one thing missin=
g for
> me is support for executing at EL0.
>
> Thanks,
> Joey
>
> [1] https://lore.kernel.org/kvmarm/20260306142656.2775185-1-joey.gouly@ar=
m.com/#t
>

Hi Joey,

Will you add support for executing at EL0?

Thanks,
Jing

> > ---
> >
> > Jing Zhang (3):
> >   lib: arm64: Add stage2 page table management library
> >   lib: arm64: Add bare-metal guest execution framework
> >   arm64: Add Stage-2 MMU demand paging test
> >
> >  arm/Makefile.arm64         |   4 +
> >  arm/stage2-mmu-test.c      | 100 +++++++++
> >  lib/arm64/asm/guest.h      | 156 ++++++++++++++
> >  lib/arm64/asm/stage2_mmu.h |  74 +++++++
> >  lib/arm64/guest.c          | 197 ++++++++++++++++++
> >  lib/arm64/guest_arch.S     | 263 ++++++++++++++++++++++++
> >  lib/arm64/stage2_mmu.c     | 402 +++++++++++++++++++++++++++++++++++++
> >  7 files changed, 1196 insertions(+)
> >  create mode 100644 arm/stage2-mmu-test.c
> >  create mode 100644 lib/arm64/asm/guest.h
> >  create mode 100644 lib/arm64/asm/stage2_mmu.h
> >  create mode 100644 lib/arm64/guest.c
> >  create mode 100644 lib/arm64/guest_arch.S
> >  create mode 100644 lib/arm64/stage2_mmu.c
> >
> >
> > base-commit: 86e53277ac80dabb04f4fa5fa6a6cc7649392bdc
> > --
> > 2.53.0.851.ga537e3e6e9-goog
> >
