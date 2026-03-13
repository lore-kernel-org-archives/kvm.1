Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40BA2877F6
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402436; cv=none; b=GT0u9F6wnRMouPF3b0aJfZzSZXsaxNzveeCjNYsLrJcHwoAhxac1SzCkJjpCSk70b5i9JEWuGrTTQi8Adyp5sCnCBryzXXMlVMUl8pSb9+nj2WrEgIyCJlKrflJq0HMgShvnBbrOBSBgeoD31hI2Qqmrj7ZY03Kg/EH83uBHd5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402436; c=relaxed/simple;
	bh=+Ty7/HUaEwr7kRN3mvNn87URf+WBFUQzJQ1FjLvGuBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aJhFrhx6nNg+RbTcqzc76FX92ixAmcI2/eBpmjeEUkhVo6dxji2Wz3XWWnmfBUkUFYsqPyO5why8925fLOu5iPfaBc5mykf4CKpfCFWAOYfs11ijgSzwHG1Bnb0OEBdXK2KfpnOxfuyF2G/nnSEWRnnHsC7FIKQWWqqZoXnmaaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=b54Kzddj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eOc/Kqts; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="b54Kzddj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eOc/Kqts"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E2E86140015D;
	Fri, 13 Mar 2026 07:47:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 13 Mar 2026 07:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773402432; x=1773488832; bh=YHTDFZmCdj
	pGgzTpFT8DScN1F9TlA0VrzlJKBZT3ZK8=; b=b54KzddjuOLH10y0aoAH3Phv/q
	HRs1adZi/4gwHVM+y7rAqrT5R8QRTpFITcJX8IqbdkMgeQSX3jGxqigsK8efgSbD
	LrLUQnWvpWWLUsqTskqULHelQFZ9fAYf0RkoDHJTN81bAO6DyredHX22ugMKGvVP
	gIYM2H6arVtKPVqaxjnsy+rP/5oYTlG19t3xK8217YavXdw7OCnd+JTG71thFSPy
	7O5YflWxrwqrBE5O4L+yku/RFlKtCN5n7w+msqNUPcPOvMSfyGpDuwdCsOEjyXkk
	czvg7yE/EnQjVuz6AOOBpdUz/880J967Sbt3is9vnZaOZgZvLxV1e9bYtIMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773402432; x=1773488832; bh=YHTDFZmCdjpGgzTpFT8DScN1F9TlA0VrzlJ
	KBZT3ZK8=; b=eOc/KqtsHeOw57hEAMyv6B0M771lF3tpCZUMS1yjT0SIsvZV3Dp
	od+wIcz5rZqQFRbaeG5HM3uPbSaWKfWIZJGUj8NUb9qP8LdU9kMOaWglTmi/F2CF
	60uWWrEud3VY7eVi+KGugKGkSVVXHRddCHgjYZ55pwGTEl/9X5ittu/9cu3ss1Jw
	7QXWyhJhH+c4P5oKv17zKRX/beI8HGURF/dLU2gIXyroBJLSAG4aalUA0PYKdso3
	5DCSEsh2viDCs9MtbTFtzpzWoZyUjk3mRYdaQZN5lXupOmrYq5xQivpbFi7/uTvu
	nGrKFM3JEMZs10KxmC8di3P5eH6JzzAGGYg==
X-ME-Sender: <xms:QPmzadDGmVAyezpDNvRIxE0XgqOpKbYWAK1Uc0sv6QTT9lF4YiTf3w>
    <xme:QPmzadyKpiD4qJJgxQDtVuRUoYMi3f4dn3sjFrPbGtqDb-peyVWx2xyKJfxEZVKER
    LcFc2Kk_q8pTHFSt_JMwHNw-bDb_cRhWrE5E4b2c58OkziYf0_Svw>
X-ME-Received: <xmr:QPmzaa2jvj1KKhhOUf8KldvPIVsLw6h8NObrEIpthNg3O3B6iwIDMj2RtKl-UPrKeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeelheekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:QPmzadyMZAmPefrWy1wC9wJsNW8XPC5uym53hJkhO180z3KB15G92Q>
    <xmx:QPmzaRF24kAW0718LFeaYbjmcY6A8M5W3f4Vgg90XHZsP6sFzxqASg>
    <xmx:QPmzaQbreP7vDmhypbZW6-PLWWDKWFZSPLaZIzIgE2W1kQGvm5tbJQ>
    <xmx:QPmzaTDRBU4LHSM9UJkpZ4tGno8bd-SwRO_gIVMdDbHsRu7mudxk_Q>
    <xmx:QPmzaSaycT3A_Az_75S-oyA_x3O20NXKs8t3-5ayamwIhhAXQZp_jHdf>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 07:47:12 -0400 (EDT)
Received: by fw12.qyliss.net (Postfix, from userid 1000)
	id D4F93888E2EA; Fri, 13 Mar 2026 12:47:08 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Eric Auger
 <eric.auger@redhat.com>, Miguel Luis <miguel.luis@oracle.com>
Subject: Re: [PATCH] target/arm/kvm: fall back if nested unsupported
In-Reply-To: <CAFEAcA8ycT250JaECAYTKF+U2a4m6jauLPLbD8PVx2atd70A7g@mail.gmail.com>
References: <20260311095405.26297-1-hi@alyssa.is>
 <CAFEAcA8ycT250JaECAYTKF+U2a4m6jauLPLbD8PVx2atd70A7g@mail.gmail.com>
Date: Fri, 13 Mar 2026 12:47:07 +0100
Message-ID: <87fr64vtms.fsf@alyssa.is>
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 11 Mar 2026 at 09:54, Alyssa Ross <hi@alyssa.is> wrote:
>>
>> If I create a machine with more CPUs than KVM supports, but specify
>> multiple accelerator options, QEMU will fall back to the next
>> accelerator.  This is great, because if I've explicitly specified
>> multiple accelerators, I've told QEMU I'm fine with any of them being
>> used to provide the machine I want.
>>
>> When I create a machine with nested virtualization enabled, though,
>> this doesn't happen.  KVM often doesn't support it, but TCG always
>> does.  The nice thing to do would be for QEMU to fall back to TCG if
>> KVM can't provide, like it does when too many CPUs are requested.
>> This patch adjusts the behaviour to do that.
>>
>> This is very helpful for OS development scripts that run an OS in QEMU
>> =E2=80=94 I want everybody to be able to run the script, always with
>> virtualization enabled because the OS requires it, but for it to take
>> advantage of KVM acceleration when available.
>>
>> Signed-off-by: Alyssa Ross <hi@alyssa.is>
>> ---
>>  hw/arm/virt.c    | 6 ------
>>  target/arm/kvm.c | 8 ++++++++
>>  2 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 7456614d05..0b63b2eac3 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -2372,12 +2372,6 @@ static void machvirt_init(MachineState *machine)
>>          exit(1);
>>      }
>>
>> -    if (vms->virt && kvm_enabled() && !kvm_arm_el2_supported()) {
>> -        error_report("mach-virt: host kernel KVM does not support provi=
ding "
>> -                     "Virtualization extensions to the guest CPU");
>> -        exit(1);
>> -    }
>> -
>>      if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled=
()) {
>>          error_report("mach-virt: %s does not support providing "
>>                       "Virtualization extensions to the guest CPU",
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index d4a68874b8..20dcc6a820 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -615,6 +615,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>          ret =3D -EINVAL;
>>      }
>>
>> +    if (object_property_find(OBJECT(ms), "virtualization") &&
>> +        object_property_get_bool(OBJECT(ms), "virtualization", NULL) &&
>> +        !kvm_arm_el2_supported()) {
>> +        error_report("Using ARM nested virtualization with KVM requires=
 "
>> +                     "a host kernel with KVM_CAP_ARM_EL2");
>> +        ret =3D -EINVAL;
>> +    }
>
> Looking a bit closer at this, it's a bit awkward that we're
> looking at a machine property in generic target/arm code.

Isn't SMP a machine property that we're looking at just above?

> There is no guarantee that the machine is "virt" or that every
> KVM-supporting machine has a "virtualization" property, and
> the target/ code isn't really supposed to do board-specific stuff.

FWIW: there's another arm board with the same property, which I think
would have the same requirements.  That's why I chose to just check the
property rather than checking machine type =E2=80=94 the idea being to esta=
blish
the convention that machines /do/ have a virtualization property where
it makes sense.

> The board-independent way to say "are we trying to enable EL2" is
> to look at the CPU property has_el2. But the CPU isn't created at
> this point, so it's too early to do that here.

I spent a day or so trying to make something involving has_el2 work, but
ultimately couldn't get anywhere with it.

> Similar things where the early accelerator code wants information
> from the board we have handled with a method in MachineClass,
> like get_physical_address_range. We could do that here, but
> maybe it's a bit over-engineered? IDK.

I'll give it a go and see if I can make it work.

> There are other cases also where the virt board will error
> out for "KVM and some config we could do with TCG":
>  * KVM + EL2 + GICv2
>  * KVM + EL2 + kernel-irqchip=3Doff
>  * KVM + GICv2 but host hardware doesn't support GICv2 emulation
>  * KVM + GICv3 but host hardware doesn't support GICv3 emulation
>  * KVM + MTE but host hardware/kernel doesn't support MTE
>
> The first two are "always fails", but if we're going to have
> a mechanism for "figure out in kvm_arch_init what KVM features
> the board is going to want to enable" then it might be nice
> to also be able to use it for the last 3.

I can try that.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQGoGac7QfI+H5ZtFCZddwkt31pFQUCabP5OwAKCRCZddwkt31p
FUe+AP4wXHU1v9+cv/Z4Eg7x6u42pMaZVgpHbFLUGsvhpnpJWgEAoRK2++2ZN1AS
f8gMqGYDRuW9K56fU0SALQXUVmii2wo=
=UeI1
-----END PGP SIGNATURE-----
--=-=-=--
