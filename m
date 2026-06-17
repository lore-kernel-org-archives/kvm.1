Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044F37B00E
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781725111; cv=none; b=mN6oTEYpLz7cXoAADTC9h7UtUDpxj2hzAZbEP5b1GwrDVN6TiT2kPHb1YdhVBpn59lcvverxCHlloVYVGy9U12WkEznnI3KNah81I2UABqYYfm7RadjPx/YJp2NSuvRee85bNQRKwADARuStHcM8juuvfEFza9ZIkgbGFX96/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781725111; c=relaxed/simple;
	bh=l80OK3M4NqBia8Y4vK/TS/DhmAkEMgeBOsLvSv/fCDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZfsJCutVwRHTfEAJrKlk2vLH9fUffzRwn5yTuDpGx7PrbUVmPZanEucBVlNH7olzWQKFuBGlAFuHcQffpZDRWH9ZBkzEnkpSug+z62n0OT8XsVDfy36IX4V1pHhAVe+x3lRgyoOZrR6m0HhWCk/lZyonYZeQcq9SKX4Yvu6sOig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0RDgBq4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0RDgBq4"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d98b6f019so69725a91.2
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781725108; x=1782329908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoBeXfxl2EEXrQtGOe1J3VWk3iWfTTGdPupGKCUkKFQ=;
        b=A0RDgBq4ymlsdQpI0aiEI/OlF5qS/CDOYKkoz0oXKODUEhZQUGJtkOwsfwKPRk5hNq
         7DW0gjORY63uMQQY8efK+0ZC9Z3MdulzbqlzDAThECtLB5D8B6F++B3SzhuA8lySJXme
         7cdyPoDG4Ys2pzv/eJmTdt99v+9MpCfJAgoCDFD5/4JkzBuIW+mRoHe2lPY3qjPs6InI
         Y6OsR1/e7j2LVwrA0916/2qBF2hNTHnYT6B0Uj3Wbv6QIACNhWWCZkLq0H3WoevpDf2Q
         V6Y/L88jpulGCoG93W17vn49EgVs0UY61kRuXvAUYUUub7o659DPo6bPizKTVB7F5d6k
         Q25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781725108; x=1782329908;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WoBeXfxl2EEXrQtGOe1J3VWk3iWfTTGdPupGKCUkKFQ=;
        b=RDxx6ykMUBKckhcOVdVqVoQS0ddALI5k/ewuuhVDgxXCTl1pd6W8MXNhfen60fC+HI
         k5K0sRs/gaJqcnCuFxh4tEtbqhtBaSNTZTXMsUS/Tb8q2M5DdWOlpxrRFlFRjTNNZ0ts
         E54H5KTJk7DvRtHUK36Ace2FQnJwk0VdeHDnuO17q2aBEoT14kVuPfhkW3RGFUcTKg8F
         GxHnA5OGhDcydz37460PWT39Mvme/VviPGQCdczukHgGdUYk1XpNA02t43zFwEGl20Na
         3fbuQjSoCmeOj6wzRAFI8EB1th5cjW3gj3btuN4zG+KfkE4EkXRSx8ndFydXVuMW4Tth
         4XNw==
X-Forwarded-Encrypted: i=1; AFNElJ94/+Q06kGPWyoD8I7duZwHhh+7ZeY+2tNpFA3KyVLb/aug32F9NjZ7L4l/Ii4d5yr+yyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTbF5tQX8J+5ponzqHX9pWOPi+metHTRjgUUML44gMc7YsrxdR
	7AalcyWbxAJ1sEpDsOezvitaIM27xWXrYSuRETahjPmRroOTld15meKJ+xTwUoSu7la6dAxTKF6
	SCRKIxw==
X-Received: from pjbnu8.prod.google.com ([2002:a17:90b:1b08:b0:37c:582b:2c0b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e710:b0:37c:6cd1:a157
 with SMTP id 98e67ed59e1d1-37c9392a787mr4752547a91.13.1781725107663; Wed, 17
 Jun 2026 12:38:27 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:38:27 -0700
In-Reply-To: <20260617180507.GB2704872.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602222941.3133236-1-jrhilke@google.com> <aiHW_1vBrukpuaW2@google.com>
 <CALzav=cb=SaTtkwdTpK32Nboq6Uj8WKiN_=wRfpO+zugdjLRCA@mail.gmail.com>
 <CALzav=dCjGHMfDaW87jKOhquUvY6uEns1i+wGY1Kbq2A7Pfreg@mail.gmail.com>
 <aiMTJa1KHHgpTbDq@google.com> <ajK_P2AEGLvKD5US@google.com>
 <20260617161412.GA2704872.vipinsh@google.com> <CALzav=fcHk5SiVc=q0G3dWR_USw5OFNoqXucfiEvxbLBXrda3A@mail.gmail.com>
 <20260617180507.GB2704872.vipinsh@google.com>
Message-ID: <ajL3s6TybZPBC5vJ@google.com>
Subject: Re: [PATCH v6] vfio: selftests: Find devices that have VFIO selftest drivers
From: Sean Christopherson <seanjc@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: David Matlack <dmatlack@google.com>, Josh Hilke <jrhilke@google.com>, 
	Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026, Vipin Sharma wrote:
> On Wed, Jun 17, 2026 at 09:34:18AM -0700, David Matlack wrote:
> > On Wed, Jun 17, 2026 at 9:28=E2=80=AFAM Vipin Sharma <vipinsh@google.co=
m> wrote:
> > >
> > > On Wed, Jun 17, 2026 at 03:37:35PM +0000, David Matlack wrote:
> > > > On 2026-06-05 11:19 AM, Sean Christopherson wrote:
> > > > > On Fri, Jun 05, 2026, David Matlack wrote:
> > > > > > On Thu, Jun 4, 2026 at 1:30=E2=80=AFPM David Matlack <dmatlack@=
google.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jun 4, 2026 at 12:50=E2=80=AFPM Sean Christopherson <=
seanjc@google.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jun 02, 2026, Josh Hilke wrote:
> > > > > > > > > Add a new script, list_supported_devices.sh, which prints=
 out the
> > > > > > > > > segment:bus:device.function (SBDF) numbers and names of d=
evices on a
> > > > > > > > > machine that have a VFIO selftest driver. This makes it e=
asier to
> > > > > > > > > determine if the system is capable of running VFIO selfte=
sts.
> > > > > > > > >
> > > > > > > > > Includes a -q (quiet) argument which prints just the SBDF=
s so that the
> > > > > > > > > output can be passed to tools/testing/selftests/vfio/scri=
pts/setup.sh
> > > > > > > > > (e.g. via xargs) to bind the devices to VFIO to use in VF=
IO selftests.
> > > > > > > > >
> > > > > > > > > Examples:
> > > > > > > > >
> > > > > > > > > $ ./list_supported_devices.sh
> > > > > > > > > 0000:6a:01.0 - Intel DSA SPR [8086:0b25]
> > > > > > > > > 0000:6f:01.0 - Intel DSA SPR [8086:0b25]
> > > > > > > > > 0000:74:01.0 - Intel DSA SPR [8086:0b25]
> > > > > > > > >
> > > > > > > > > $ ./list_supported_devices.sh -q
> > > > > > > > > 0000:6a:01.0
> > > > > > > > > 0000:6f:01.0
> > > > > > > > > 0000:74:01.0
> > > > > > > > >
> > > > > > > > > Suggested-by: Sean Christopherson <seanjc@google.com>
> > > > > > > > > Signed-off-by: Josh Hilke <jrhilke@google.com>
> > > > > > > >
> > > > > > > > NAK, until this stuff is fixed and properly documented.
> > > > > > > >
> > > > > > > > This script needs to (a) communicate that some of the devic=
es may be on VFIO's
> > > > > > > > denylist, (b) NOT report them by default, (c) let the user =
report denylisted
> > > > > > > > devices, (d) make it *very* clear in the output that a devi=
ce, and (e) ideally
> > > > > > > > provide the user with a hint of how that might be able to t=
est a denied device,
> > > > > > > > e.g. by reloading vfio-pci with disable_denylist=3D1.
> > > > > > > >
> > > > > > > > Nothing in here so much as mentions that these "supported" =
devices may be
> > > > > > > > disallowed by the kernel, including the devices that's USED=
 AS THE EXAMPLE.
> > > > > > > >
> > > > > > > > The DSA SPR devices has been on the naughty list since comm=
it 95feb3160eef ("VFIO:
> > > > > > > > Add the SPR_DSA and SPR_IAX devices to the denylist") from =
2024, so I have a
> > > > > > > > very hard time believing y'all weren't aware of this.  And =
if you really truly
> > > > > > > > weren't aware of this quirk, than what exactly are you even=
 testing!?!?
> > > > > > > >
> > > > > > > > C'mon.
> > > > > > >
> > > > > > > Yeah vfio_pci.disable_denylist=3DY is required to use the Int=
el DSA SPR
> > > > > > > device. This script is a great place to capture that previous=
ly hidden
> > > > > > > requirement.
> > > > > > >
> > > > > > > Your proposed (a)-(e) sound good to me.
> > > > > >
> > > > > > Another direction we could go in here would be to set disable_d=
enylist
> > > > > > to Y in setup.sh (if it is currently N) and set it back to N in
> > > > > > cleanup.sh (after the last device is cleaned up and only if it =
was
> > > > > > previously N). I was already thinking about doing something sim=
ilar
> > > > > > for setting enable_srio to Y for Raghu's new SR-IOV uAPI test.
> > > > > >
> > > > > > The only issue is that disable_denylist is not currently writab=
le. I
> > > > > > don't see any functional reason why it can't be writable though=
. It is
> > > > > > just sampled during probe. And from a security perspective, pri=
vileged
> > > > > > users can already reload vfio-pci with different parameters if =
it is
> > > > > > built as a module. But for built-ins, this would enable the den=
ylist
> > > > > > to be disabled.
> > > > >
> > > > > IMO, any changes to setup.h are completely orthogonal.  list_supp=
orted_devices.sh
> > > > > can and will be run independently, e.g. by people like me, and so=
 absolutely needs
> > > > > to claim a device is supported when it's obviously not.
> > > > >
> > > > > Actually, that's a good amendment to (b) above.  Instead of *neve=
r* reporting
> > > > > denylisted devices by default, have the script check disable_deny=
list and act
> > > > > accordingly.  And then it's "just" a matter of communicating thes=
e details to
> > > > > the user, e.g. so that a user can find devices that are supported=
 by selftests,
> > > > > but not by their currently loaded kernel+modules.
> > > >
> > > > SGTM
> > > >
> > > > Josh can you do this in v7? We'll probably need a flag to control
> > > > whether the script lists devices not currently supported due to
> > > > denylist, and how to convey all that to the user. I lean towards
> > > > list_supported_devices.sh printing as much information as possible =
when
> > > > run without arguments. So maybe a flag to hide denylisted devices.
> > >
> > > Do we need then flag to hide denylisted devices? Instead, I think it =
should be
> > > opposite (I think that what Sean is suggesting as amendment). If
> > > the script finds vfio_pci.disable_denylist param value is:
> > >  - Y, then just show those DSA devices if they are available on the
> > >    host. Don't differenciate.
> > >  - N, then don't show these denylist devices.

That's going to be extremely frustrating for users like me, that aren't eve=
n aware
that there's a denylist (well, now I am, but I wasn't when I ran the script=
).

> > > A flag can be added to show all of the VFIO selftests supported devic=
es
> > > present on the host with the warning next to denylisted devices or gr=
oup
> > > them in the output.
> > >
> > > Flag case is for human consumption only.

I disagree, strongly, with this particular statement.  IMO, the sole requir=
ement
we should be considering with respect to flags is the default behavior for =
humans.
Everything beyond that should be an implementation detail.  Saying "flags a=
re only
for humans" is placing pointless constraints on the implementation.

> > Can you explain why it should be that way?
> >=20
> > IMO running list_supported_devices.sh without any arguments should
> > display as much information as possible. I think that will maximimize
> > the probability that people running VFIO selftests for the first time
> > will be able to figure things out for themselves.
>=20
> My view is that setup.sh should get supported device list by default
> using the list_supported_devices.sh which should correctly tell what is
> supported based on the kernel one has booted and wanted to test.

That's fine, but how setup.sh behaves is largely orthogonal.

> We also have in-progress series for IGB and MLX devices selftest driver
> support, these devices are not in the denylist.

How is that relevant?

> People running VFIO selftests will be intentionally running them on
> supported hardware.=20

Uh, no.  I'm proof that that's not the case.  I'm using the script to see i=
f a
system has a supported device.

> They will also first need to check/read scripts on how to use the setup.s=
h,
> run.sh, and cleanup.sh, or manually pass device BDF value (via args or
> environment variable). These things are not default and one will not have=
 a
> successful run in the first try without knowing these internal details.

I disagree.  I have pre-existing scripts to configure VFIO devices, the *on=
ly*
thing I need from list_supported_devices.sh is what its name literally says=
: a
list of supported devices.

> vfio-pci module default is to disable use of these denylist devices. To
> use these devices one has to set Y to the vfio_pci.disable_denytlist
> module param and reboot the kernel.

No, most kernels build vfio-pci as an actual module.  A reboot isn't requir=
ed,
just a module reload.

> So, a pre-requisite for running VFIO selftest is to be an advance user an=
d

I again disagree very strongly.  The goal should be to make it as easy as p=
ossible
for people to run tests.  Claiming that only advanced users will or should =
run
tests is only going to reduce the overall health of the kernel.

> I don't think they will have any trouble in figuring out these things.

I did.  In fact, I was so frustrated with the whole experience that I liter=
ally
stepped away for several hours.

> If they see no run has happened or they want to explore more,
> list_supported_devices.sh will be an easy read to discover flags.

Why make the user jump through an extra hoop or two?

> I think my suggested approach is advocating for keeping things in sync
> with what kernel default is or booted with. It looks cleaner to me and
> respect safeguards provided by the kernel.

Printing out that "Hey, this device is supported, but it's denylisted by th=
e
kernel by fault" isn't disprecting kernel safeguards.
