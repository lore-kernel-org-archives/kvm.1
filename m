Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65A3321A1
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683560; cv=none; b=f/vCwCpwWXU+wq5YqJP/fd6JQO2/9BiETj16DC24EdFYH99fYubyNlY0Xgrbp3b/J6u0oPTg1s6HtnJAJ3qK7jmjEMBkim3Z6Y8MvCUFfZFmLIDFlgi+PIc4I0HEsvHh95tW8n6S1G5CpzXWIISoPI/04io/04CVJLppkg9IxSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683560; c=relaxed/simple;
	bh=Yr6vlU5uN1Rvu2qE4K5YjxOtjvs318XDeJLoCnQIHMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hbxa8SfSJcEpQTTDkEFZebjd/txY1edsrX0Lilxg155e9a5UA49JrMOA4K+HCnduOpcjdmZ8TgD6/rUKeUXEUx3KETrVeYS9oq4HP/obbyky4F7o39Mz2pzJbFahNtmsa0veVjYieeSIz5vA0ZopG5W3FLNkuvtDtZtZBJ7yIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YJqvOvkz; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJqvOvkz"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84235f9b91fso1638887b3a.2
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 11:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780683558; x=1781288358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYFvzKbsK6D4Xy2ltfO6sZRZcUgY+ILfavGIQrQIlFo=;
        b=YJqvOvkztBJ3gtS+jV5Zx/oQ2f0t+VBD0QQQ6JCSfn1Etk6rtR+6OJEwdfoSpTmy8o
         Ho+879sxN8Oy+tm4HxrIZ0eeKyD6Hb9uQEJ9Kx2R19TsYuapKJqLNtP71i7vchS5tpz0
         wd4bsYdb1yuwvf8H0KNUrMoqOWGWJpUHDKd9Fj/OgdckpTHhmx7DPr/vQmUg/Gy2Sc6y
         BibOIW+GDXSiO3YQ7jxflom3AMaBGfHdMB0RWj920khr/Br45QZSgSQcxpXIzHK8xJt6
         LVHQktGOblBuZM0UU1SrBCumzUIu0pAQVHUzoy5fom6POQyybhoMfrKRG9ZKq3VdpfYq
         djWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780683558; x=1781288358;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EYFvzKbsK6D4Xy2ltfO6sZRZcUgY+ILfavGIQrQIlFo=;
        b=Gmuoa9HJQd5DEHWXneQ7bDCZcpj9T0YSjLSEcoyKjZVuIXvnX9gy4C/GFyIvH2+XlB
         XLuteg41jtxUZrljbfoHRuWr9Ay7Nq9HOfQHTJkpiNhG1ljDvTINPBbSVriI9WlNNVYG
         d0HmOufyasnusWf6RExJE98b41BivDbTg4Y/Gjr5Y0vKO54hVga7clmKfK9zcBTtZcAs
         XRi6PjuV0plOkqTeantk1rpZOSg19Z/hIOvbdw40HmDWhZolvts86vdMU//JGoVmPty9
         RSdSGuvRwDEbNV/AnX6fn3BwyRwnO/ETx0CwEg+dlp863ngW9SOxBO9ZUEJtVhEN8hzL
         FrZw==
X-Forwarded-Encrypted: i=1; AFNElJ+yjZWntih7lS0oNnJ0qbReKD4TWkp+yCywfc+z0pbWCtcx1gSK76K5FZnhDFe0mPiYDQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2nUGbJbnTbuVRPskVzQNPi1DgBwcgNtzNmVNIKUd+27sm+rdA
	KZIAsJGMnadhz4sMStFA/AMDWqHzzEJitzVkNP7A4EP2o3GLlD/7FiJVUXW/lnS8Hra/7oID7/k
	O9Rvz7A==
X-Received: from pfms21.prod.google.com ([2002:aa7:8295:0:b0:842:39c0:1203])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9084:b0:842:7e6f:f487
 with SMTP id d2e1a72fcca58-842b0e5cdb6mr4900494b3a.15.1780683558116; Fri, 05
 Jun 2026 11:19:18 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:19:17 -0700
In-Reply-To: <CALzav=dCjGHMfDaW87jKOhquUvY6uEns1i+wGY1Kbq2A7Pfreg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602222941.3133236-1-jrhilke@google.com> <aiHW_1vBrukpuaW2@google.com>
 <CALzav=cb=SaTtkwdTpK32Nboq6Uj8WKiN_=wRfpO+zugdjLRCA@mail.gmail.com> <CALzav=dCjGHMfDaW87jKOhquUvY6uEns1i+wGY1Kbq2A7Pfreg@mail.gmail.com>
Message-ID: <aiMTJa1KHHgpTbDq@google.com>
Subject: Re: [PATCH v6] vfio: selftests: Find devices that have VFIO selftest drivers
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Josh Hilke <jrhilke@google.com>, Alex Williamson <alex@shazbot.org>, 
	Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2026, David Matlack wrote:
> On Thu, Jun 4, 2026 at 1:30=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
> >
> > On Thu, Jun 4, 2026 at 12:50=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Tue, Jun 02, 2026, Josh Hilke wrote:
> > > > Add a new script, list_supported_devices.sh, which prints out the
> > > > segment:bus:device.function (SBDF) numbers and names of devices on =
a
> > > > machine that have a VFIO selftest driver. This makes it easier to
> > > > determine if the system is capable of running VFIO selftests.
> > > >
> > > > Includes a -q (quiet) argument which prints just the SBDFs so that =
the
> > > > output can be passed to tools/testing/selftests/vfio/scripts/setup.=
sh
> > > > (e.g. via xargs) to bind the devices to VFIO to use in VFIO selftes=
ts.
> > > >
> > > > Examples:
> > > >
> > > > $ ./list_supported_devices.sh
> > > > 0000:6a:01.0 - Intel DSA SPR [8086:0b25]
> > > > 0000:6f:01.0 - Intel DSA SPR [8086:0b25]
> > > > 0000:74:01.0 - Intel DSA SPR [8086:0b25]
> > > >
> > > > $ ./list_supported_devices.sh -q
> > > > 0000:6a:01.0
> > > > 0000:6f:01.0
> > > > 0000:74:01.0
> > > >
> > > > Suggested-by: Sean Christopherson <seanjc@google.com>
> > > > Signed-off-by: Josh Hilke <jrhilke@google.com>
> > >
> > > NAK, until this stuff is fixed and properly documented.
> > >
> > > This script needs to (a) communicate that some of the devices may be =
on VFIO's
> > > denylist, (b) NOT report them by default, (c) let the user report den=
ylisted
> > > devices, (d) make it *very* clear in the output that a device, and (e=
) ideally
> > > provide the user with a hint of how that might be able to test a deni=
ed device,
> > > e.g. by reloading vfio-pci with disable_denylist=3D1.
> > >
> > > Nothing in here so much as mentions that these "supported" devices ma=
y be
> > > disallowed by the kernel, including the devices that's USED AS THE EX=
AMPLE.
> > >
> > > The DSA SPR devices has been on the naughty list since commit 95feb31=
60eef ("VFIO:
> > > Add the SPR_DSA and SPR_IAX devices to the denylist") from 2024, so I=
 have a
> > > very hard time believing y'all weren't aware of this.  And if you rea=
lly truly
> > > weren't aware of this quirk, than what exactly are you even testing!?=
!?
> > >
> > > C'mon.
> >
> > Yeah vfio_pci.disable_denylist=3DY is required to use the Intel DSA SPR
> > device. This script is a great place to capture that previously hidden
> > requirement.
> >
> > Your proposed (a)-(e) sound good to me.
>=20
> Another direction we could go in here would be to set disable_denylist
> to Y in setup.sh (if it is currently N) and set it back to N in
> cleanup.sh (after the last device is cleaned up and only if it was
> previously N). I was already thinking about doing something similar
> for setting enable_srio to Y for Raghu's new SR-IOV uAPI test.
>=20
> The only issue is that disable_denylist is not currently writable. I
> don't see any functional reason why it can't be writable though. It is
> just sampled during probe. And from a security perspective, privileged
> users can already reload vfio-pci with different parameters if it is
> built as a module. But for built-ins, this would enable the denylist
> to be disabled.

IMO, any changes to setup.h are completely orthogonal.  list_supported_devi=
ces.sh
can and will be run independently, e.g. by people like me, and so absolutel=
y needs
to claim a device is supported when it's obviously not.

Actually, that's a good amendment to (b) above.  Instead of *never* reporti=
ng
denylisted devices by default, have the script check disable_denylist and a=
ct
accordingly.  And then it's "just" a matter of communicating these details =
to
the user, e.g. so that a user can find devices that are supported by selfte=
sts,
but not by their currently loaded kernel+modules.
