Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889A3EB811
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675947; cv=pass; b=PABaTRr+7EcB5cNOkeZrr3vJEm1qmi0I5eqAggB752/+gUFGYg6w2lbX8mlrO1V78M1Wa7ZL+OFXwfcfdjkxqyOPvujPM979AP4O4KpQm4SwfKNLfKTYJT76uUj/+jUeLkbvm2KZRs89L2LDMY/QcdrYMfAAOPhep05O3H4rcdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675947; c=relaxed/simple;
	bh=3g7eYKuzKdj52Ojm8yO2gNodZzant4h/o/vsYDKG0KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2bmZQDyOUiUISpeayNIAPkfZZErSmr5E74D69bvvofrdCYA4mYedsvcySv36RfrCXbEbkEOruLY1yVsG4nTvimBAZX5Ct4qJ7iKO34+3DPXzu2SVBVwQsEJQuWj8hxV3+u8ejE7cvHE4mFmdhL60YTfigbI5ro0RYS7IUO1K24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AzXkcdre; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AzXkcdre"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-137eed84fc6so5742916c88.0
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 09:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780675945; cv=none;
        d=google.com; s=arc-20240605;
        b=O01BMIFcj4tydedJbDQMYJDg21omQL0ZiysqJz1YrJKxMBaOGAneYzk2ZvS9pmCivA
         60gZqybQZ78BPWPKTFGzGpFU56bVQf2nCgdoa6w1e6SLINAc4VdTv3oMs+0b8a0np/Ha
         SU8PoTG1r7vpBElcsanzyxfntxOMsXPI/MSC4whc82kNPcgm1unBwgqMhAKezVpMAvSS
         ear+DxSov39ZzgK/x79WXemQSzwlY17bLTuKqtuewSozFDHnXCvmRH4FLJKj68N2zB9r
         lnqB+RhLF3hcG1pIeh5oZAciScpJ/szoEflypTXCWQNmIdnNOL+z68RPYc9KmdsEmQ5V
         +o8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bgoqm9OosdYXkyWJvLWwn/Just9C3MWqroasfAHP0kc=;
        fh=NN9bo4O/d4qddgnVMKBFXSKl5JodK/aIiev/TIaCIho=;
        b=Pf/J/T7vz1M8bsiqPjCyMa0huid1Aecd0nR39G9FkyZTAxanswK5nGuoMKaaZuyZT9
         1L7ZY7Ne2akB4oendpe7ajU4HqulifCLSn5E5BCmC1nb+CoY0kvUpqibMe1FwMJLhOGx
         K7Hguz28FYA2gOzsfc+9YMz9Z23o8rT4DcmBeZnwoGxeIirsbheoiOESlKqe9a+URyQ7
         0d52e37W7zUxDxbye5m6YgdNoPFsnxcKo5NMamVjXQ/znINeUKjDGAFG8/msTV5moHXY
         bOu3tlHEcnxbSoZ1Mvtttl6WDAYmBM7TNUiWQphj5gZCP9ykVY4cJCLGWQD/cRbOKGCB
         62EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780675945; x=1781280745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgoqm9OosdYXkyWJvLWwn/Just9C3MWqroasfAHP0kc=;
        b=AzXkcdreY5UhAo6XrPeZrAJz0aDljAb+zl5vrS0i843pRDw22zZSrzz8vrCS8IJlZg
         zdPDYDx+vcQ66XsA+XiLOLVB0cXyKkI0Ta/GXkjFdRwYLkmMdGhsG+KwoUpazJrLRrzp
         Fi1Pdt9Wjr8fSIuANu9WvFTpV2KJJf6fwsUHntFf9sGOA4gJ/D6K4rBowEUgfoV3FskC
         mKGCJfTw9CUD1glaTLwhbIog7aKbzAD1dNs9yfMshCTg6sjyNmhOnCl15VvFmWXwf/PK
         59Dp0fIPN1CceEFmhr/qzwLIS7tdSGPWxVX13ARZHPy5EsvwOzl85T0hrRgS+8yRQFI8
         qNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780675945; x=1781280745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bgoqm9OosdYXkyWJvLWwn/Just9C3MWqroasfAHP0kc=;
        b=T921uXE18Uria+b2qnEBQmeDvC19LNArTipfIQU4/RtBxd9KCCYA14DKSxu3u42WEa
         vLeWsbiueIYWv6TCLf02IDgZxG/XuVUirxaWQ/DdGPU0NPOTYUpYbzSJqiO6vA73S/5P
         KhjFhLjcd/+pFti7ni9Nhz2FPLh0vSNKUWVsFwZauzLEi/rLV4VxPf4OVC9boYdrEXyB
         AV5iCulOgQ8+GItVpIYCNYjVO4b/i/ug2zF5NyP64rIRAYeVWCdWHeRXIJH62Rt7Pawq
         Wv8F6YzpOQ6NaDe5E2y+QI6ZlkPrGVPgpH454WrYdI+haxj14R3+Uh9UG3OKda6qx2M/
         ZAJQ==
X-Forwarded-Encrypted: i=1; AFNElJ/L9RrDw4OszHtMxU0StKCiCJf1Y8v/AVzXZS+FygEPUZyZrbvFX+n8MHI1oFsSVtmGSOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwklsnQCSXyUdmraAOqFmP17Dx1wzIzTHVogF9W9OVVt4PSsKP
	JFHy/g3UI5jRpixhdeQdNjprPZKWmGoqB/TwQXt/ceQXE+sDwMZgoOil7dKDUuaqyqlr1FBE5m0
	y8LlChW12OucC1ZvEjtQn8AMB25MArdAaXom/SQiD
X-Gm-Gg: Acq92OGDTNy/lAob92qmvS7F9RpxGfV9GBYmvg9WrIqG8TlP7EpgnWtzVRRn/w1ceb0
	5plXZ0lr+ZeIZKkIh0jBV0FxzYV9OCAUudNA/9E9HcAomSMKFG3j8NWI2Zz9LUk06dWLbJnwXCe
	forFzP5ErQRxY/yeQfNRf/KaV+IM9bP+8L1eGFNInmDZ6avQstblmk36l4LcFIEp0o67cz971lL
	2ndmKeJxPjdmVDZOQvYQ+KWwqAga91t98A+/93opMHcnwA9zFzw2lTVzfGi7cVfXKCHxIzyQMpH
	8FoIWRb0TnFzdeyIdQ==
X-Received: by 2002:a05:7022:6999:b0:138:104:439b with SMTP id
 a92af1059eb24-138067234ecmr2017024c88.19.1780675944435; Fri, 05 Jun 2026
 09:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602222941.3133236-1-jrhilke@google.com> <aiHW_1vBrukpuaW2@google.com>
 <CALzav=cb=SaTtkwdTpK32Nboq6Uj8WKiN_=wRfpO+zugdjLRCA@mail.gmail.com>
In-Reply-To: <CALzav=cb=SaTtkwdTpK32Nboq6Uj8WKiN_=wRfpO+zugdjLRCA@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 5 Jun 2026 09:11:56 -0700
X-Gm-Features: AVHnY4IG4c1v5aE_7MuPHMlLAw5N96PPqWZY97u0CTB01GjwbEtzJ4mUdoGQolI
Message-ID: <CALzav=dCjGHMfDaW87jKOhquUvY6uEns1i+wGY1Kbq2A7Pfreg@mail.gmail.com>
Subject: Re: [PATCH v6] vfio: selftests: Find devices that have VFIO selftest drivers
To: Sean Christopherson <seanjc@google.com>
Cc: Josh Hilke <jrhilke@google.com>, Alex Williamson <alex@shazbot.org>, 
	Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 1:30=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:
>
> On Thu, Jun 4, 2026 at 12:50=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Tue, Jun 02, 2026, Josh Hilke wrote:
> > > Add a new script, list_supported_devices.sh, which prints out the
> > > segment:bus:device.function (SBDF) numbers and names of devices on a
> > > machine that have a VFIO selftest driver. This makes it easier to
> > > determine if the system is capable of running VFIO selftests.
> > >
> > > Includes a -q (quiet) argument which prints just the SBDFs so that th=
e
> > > output can be passed to tools/testing/selftests/vfio/scripts/setup.sh
> > > (e.g. via xargs) to bind the devices to VFIO to use in VFIO selftests=
.
> > >
> > > Examples:
> > >
> > > $ ./list_supported_devices.sh
> > > 0000:6a:01.0 - Intel DSA SPR [8086:0b25]
> > > 0000:6f:01.0 - Intel DSA SPR [8086:0b25]
> > > 0000:74:01.0 - Intel DSA SPR [8086:0b25]
> > >
> > > $ ./list_supported_devices.sh -q
> > > 0000:6a:01.0
> > > 0000:6f:01.0
> > > 0000:74:01.0
> > >
> > > Suggested-by: Sean Christopherson <seanjc@google.com>
> > > Signed-off-by: Josh Hilke <jrhilke@google.com>
> >
> > NAK, until this stuff is fixed and properly documented.
> >
> > This script needs to (a) communicate that some of the devices may be on=
 VFIO's
> > denylist, (b) NOT report them by default, (c) let the user report denyl=
isted
> > devices, (d) make it *very* clear in the output that a device, and (e) =
ideally
> > provide the user with a hint of how that might be able to test a denied=
 device,
> > e.g. by reloading vfio-pci with disable_denylist=3D1.
> >
> > Nothing in here so much as mentions that these "supported" devices may =
be
> > disallowed by the kernel, including the devices that's USED AS THE EXAM=
PLE.
> >
> > The DSA SPR devices has been on the naughty list since commit 95feb3160=
eef ("VFIO:
> > Add the SPR_DSA and SPR_IAX devices to the denylist") from 2024, so I h=
ave a
> > very hard time believing y'all weren't aware of this.  And if you reall=
y truly
> > weren't aware of this quirk, than what exactly are you even testing!?!?
> >
> > C'mon.
>
> Yeah vfio_pci.disable_denylist=3DY is required to use the Intel DSA SPR
> device. This script is a great place to capture that previously hidden
> requirement.
>
> Your proposed (a)-(e) sound good to me.

Another direction we could go in here would be to set disable_denylist
to Y in setup.sh (if it is currently N) and set it back to N in
cleanup.sh (after the last device is cleaned up and only if it was
previously N). I was already thinking about doing something similar
for setting enable_srio to Y for Raghu's new SR-IOV uAPI test.

The only issue is that disable_denylist is not currently writable. I
don't see any functional reason why it can't be writable though. It is
just sampled during probe. And from a security perspective, privileged
users can already reload vfio-pci with different parameters if it is
built as a module. But for built-ins, this would enable the denylist
to be disabled.
