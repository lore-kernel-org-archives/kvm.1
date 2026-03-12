Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC011A9FB7
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773300971; cv=none; b=Ain7GW/yAtStEIEig/ErVuatHFKDhHi98cSFvLnCdvTeue0MIzr5331IbGYjRdv3EXX+vzGzgwRpo+9kJIzxVyJe5wVtwG8QopJCVQTaVdC6a4xG44YsSgrUTWuzY0nTp1UYCBqCqgH7//Y62B6tTf4ThNecAOzI9xLi0EqNgb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773300971; c=relaxed/simple;
	bh=4GQk47O0lTUVjXxu0lAVDy3R4GLgZqMZMqrYRzxREVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F4fOKI7jBJliWwxy2ZJ1qCoF9/rOoKUU5TlgYpRe9+S6y8zmW23wVkflT1ILH4ozT72pgXQdpaogDc5XyHLC1GYKFSHzzBo1oBN3blsfL7lvxoH8QW5pxh5AWMQ7+jAUrc2LFdaLT2GbuyvUXLgM/nK2WKvLPruXMNTVqaQyS1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=eRNuF6AX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DI1qXbrv; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="eRNuF6AX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DI1qXbrv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 64FA8140024C;
	Thu, 12 Mar 2026 03:36:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 03:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773300968; x=1773387368; bh=f47T68loaB
	NsaUfOWwH+cEMrROrgV8Uw7v2X24lMDzA=; b=eRNuF6AXU4KwlDRweLEJsSlpDM
	Hzu+KWJbR+wFcNU9jdpTDdlhOmboSWS/ICrNR3iiyRyBaNUiHC/B6ZQUfcykze4j
	NZK7TsPSPkZhwWNjd+oC5Nj77RRizJNl6L/3AbJCzpkiz+gcFNmkXKMvWs1VHqhx
	P9sPsCkQW9NUhe8OugyAeD5SWGZ7IYjDYwqNU0A2VQyAgMdzkcRGI92lQix5HnIl
	Ea/wQEcfhbKNgKdXohD3Vq6bfv+DR96zldB0xEm+3LVaqGnKwIKKqUUCFBtkdE77
	zX/Ly4qc8ctD+0dhOW+rF6bltT/RDIjveJE2jecFJvO7WCfPWjv91mhLa7Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773300968; x=1773387368; bh=f47T68loaBNsaUfOWwH+cEMrROrgV8Uw7v2
	X24lMDzA=; b=DI1qXbrv8KlDVEw8L5snXDx4ysEhQh5oGhEh0xHb/iqorPqZIel
	sel8nYEIMrGrvkWfiqO3x0RLGSyU6NL+ZZQCAsJSq3jUDemnb1lBd3eTr/bKpaun
	vEyLL7AgJiEXiIMf42k08Zi/Zjdsqi+Su1bKyzpmW0bW/CZf8Fuak0o6wjsu2jQG
	8V5DwF/j/OWQov/pt4qT40cevNaqvw0kisSdFmZSC32qSDWnRhjljKppE1MVyzUm
	/L+4LNeHnfb+OV8O0paQeyBTqRFmCb37D9gMyC4wop5hVKpdmQzZagtst73KU0xq
	euETj4UuQOz6vKN4m+7m6v5ix3y268fU1fg==
X-ME-Sender: <xms:52yyaWJT3Q3XdnDrERKxbG_F_gxhci-Z32e645svJx4A7Dt3LfKpFA>
    <xme:52yyaQaRTJlIHMk_Zs9NkmtKSjU_HO3En5y3Cw9AkQSu4dB-RoiwBVZVN4xsP7xuh
    qQCud-SHx1DdVzJw8VA1XpdmhB8X2LS6LOa5Y7Y4OFCi7jVDTTywg>
X-ME-Received: <xmr:52yyaY__sOBP_aO0IzjpQF6lB9Bl9T6yKOEOyPmOgFzU3SNsdkiE6_XaQAHoXRprbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeivddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkgggtsehgtderredttdejnecuhfhrohhmpeetlhihshhsrgcu
    tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeetheevud
    fgjefghefhieejudelkeeljeegvdekueeuhffhgedvveefteevgeetieenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrd
    hishdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    phgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmh
    huqdgrrhhmsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhes
    nhhonhhgnhhurdhorhhgpdhrtghpthhtohepmhhighhuvghlrdhluhhishesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtohepvghrihgtrdgruhhgvghrsehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkh
    hvmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:52yyaRa4etl953P07VeD7CYzQGg4TFf9ppvRfHVMGcxHnQSdji3lEQ>
    <xmx:6GyyacP5oOpiuZKTZAHus4cs4O7dKAI3N1MUihX9lWKFXQg_D8wIDQ>
    <xmx:6GyyadDpADNnOCzriUzmf7-kHhC_31PapB5XA2SmT2C0Yq6BCpZHJA>
    <xmx:6GyyaTLJDunWahFdbsN1L4KJqdDikQkWQPdA-eGZmauSNmV9MVR0fw>
    <xmx:6Gyyaet4Akpu0X_HvdTIj6pUpt9Nc1go0lY00qZ97zV0R7R9TJeh6EKM>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 03:36:07 -0400 (EDT)
Received: by fw12.qyliss.net (Postfix, from userid 1000)
	id 861028887ECA; Thu, 12 Mar 2026 08:36:04 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, Eric
 Auger <eric.auger@redhat.com>, Miguel Luis <miguel.luis@oracle.com>
Subject: Re: [PATCH] target/arm/kvm: fall back if nested unsupported
In-Reply-To: <CABgObfavGAHLz0FZy66QTbXHTS7YqWxc_eVmEWnCWo+QBPiN1g@mail.gmail.com>
References: <20260311095405.26297-1-hi@alyssa.is>
 <CAFEAcA8GCz2c18e3+bwFooAxYZzBrX3OjjQ58CWJOdLfTYL_dA@mail.gmail.com>
 <CABgObfavGAHLz0FZy66QTbXHTS7YqWxc_eVmEWnCWo+QBPiN1g@mail.gmail.com>
Date: Thu, 12 Mar 2026 08:36:03 +0100
Message-ID: <87ikb1wlcs.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paolo Bonzini <pbonzini@redhat.com> writes:

> On Wed, Mar 11, 2026 at 6:03=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
>>
>> On Wed, 11 Mar 2026 at 09:54, Alyssa Ross <hi@alyssa.is> wrote:
>> >
>> > If I create a machine with more CPUs than KVM supports, but specify
>> > multiple accelerator options, QEMU will fall back to the next
>> > accelerator.  This is great, because if I've explicitly specified
>> > multiple accelerators, I've told QEMU I'm fine with any of them being
>> > used to provide the machine I want.
>> >
>> > When I create a machine with nested virtualization enabled, though,
>> > this doesn't happen.  KVM often doesn't support it, but TCG always
>> > does.  The nice thing to do would be for QEMU to fall back to TCG if
>> > KVM can't provide, like it does when too many CPUs are requested.
>> > This patch adjusts the behaviour to do that.
>> >
>> > This is very helpful for OS development scripts that run an OS in QEMU
>> > =E2=80=94 I want everybody to be able to run the script, always with
>> > virtualization enabled because the OS requires it, but for it to take
>> > advantage of KVM acceleration when available.
>> >
>> > Signed-off-by: Alyssa Ross <hi@alyssa.is>
>> > ---
>> >  hw/arm/virt.c    | 6 ------
>> >  target/arm/kvm.c | 8 ++++++++
>> >  2 files changed, 8 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> > index 7456614d05..0b63b2eac3 100644
>> > --- a/hw/arm/virt.c
>> > +++ b/hw/arm/virt.c
>> > @@ -2372,12 +2372,6 @@ static void machvirt_init(MachineState *machine)
>> >          exit(1);
>> >      }
>> >
>> > -    if (vms->virt && kvm_enabled() && !kvm_arm_el2_supported()) {
>> > -        error_report("mach-virt: host kernel KVM does not support pro=
viding "
>> > -                     "Virtualization extensions to the guest CPU");
>> > -        exit(1);
>> > -    }
>> > -
>> >      if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabl=
ed()) {
>> >          error_report("mach-virt: %s does not support providing "
>> >                       "Virtualization extensions to the guest CPU",
>>
>> I think there is a bigger problem here. The code in the virt
>> board init assumes that the accelerator has already been
>> selected: based on whether kvm_enabled() or tcg_enabled()
>> it decides things like which GIC version can be used, whether
>> "-machine gic-version=3Dhost" is valid or not, and so on.
>>
>> This bit we're deleting here is just one of multiple checks
>> we do that assume that we know the accelerator already. If
>> we actually don't know if we're going to be using TCG or KVM
>> then all this code needs to be rethought.
>
> We do. This code runs at the very end of qemu_init()
> (qmp_x_init_preconfig->qemu_init_board->machine_run_board_init).
>
> The bug is on the KVM side, as it lets the configuration slip even
> though it's not valid; the above KVM check should really be more of an
> abort() if anything. (This is also why I picked it despite it touching
> hw/arm/virt.c - from my point of view the KVM fix made the above code
> go dead).

Yeah, the problem isn't that we don't know which accelerator is in use
in the virt board =E2=80=94 we do.  It's that by that point it's too late to
fall back to the next acceptable accelerator if KVM can't provide
nested virtualization, so we need to check earlier.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQGoGac7QfI+H5ZtFCZddwkt31pFQUCabJs4wAKCRCZddwkt31p
FaGsAPoClLOMTH0PFjQ+SO6LUd9RVHiVb73Qb7iZZzNthkTMAQEAjlYgpX+Tq1+A
jEPAcpZcR/gw7MnBbL+mPkAGjriTgQ8=
=n5cX
-----END PGP SIGNATURE-----
--=-=-=--
