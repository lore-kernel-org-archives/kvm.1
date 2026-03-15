Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0F026D4DD
	for <kvm@vger.kernel.org>; Sun, 15 Mar 2026 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773566747; cv=none; b=gI0NsUjoq2VZgcBKz+uSX6GH3sONmNVoRjSCsMc9NAPl/+Ejpm72xl+E8bFGWf+wQYlfWZwZYM4QDNquzjGPNkLAvpeRDp3a2k6Zh9A6JUn/dA6myWs0hDz6KWzQiyAH87/UHm8tx+kv6nDu1rJnDY+qfX6ji1YZIWzqggwBdHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773566747; c=relaxed/simple;
	bh=kTMtkniWi7IuUW+SusNKQutRMbFn4nH1psWc2CRD1P8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QbKG30ha4K7wEMkcwInjoVJOkPdsr7VAn1IuKEoH96bE0zhSN+GzZ967FfM2RDb+VyC+m4vZA5bQSsc/YqI1fahXWk5dc86nKeSr62tkyCj9kZU15j3S8kch4LFVeg1o+7JpDhD+JG99qn1ai9S+22H6KhyZPfA+nbozTPupKCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=pBFheLjM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GdUgJJix; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="pBFheLjM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GdUgJJix"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 590541D00163;
	Sun, 15 Mar 2026 05:25:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 15 Mar 2026 05:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773566742; x=1773653142; bh=AI9EBvIhSJ
	L51T3pR3nWRZei9IvwjbCjAavH2TVzADk=; b=pBFheLjMVwgcQdyziVr5Nh09Y3
	21DF2kCcsd0zz6lc7n5TccvaHpzDVABJPJoiHe2NHekqEBxQidmmm9ym9b1J08W3
	2oDBJEKFBZP0Np/MpbfPHDzN/wmsCC/2XWTQjgvE9asVsH7ORrSE3Js6LFHChk/M
	We5Kk8BooRYX4Ys4tRzbmqhhGjPUz6DfaGWc0lexCH79rMIGmgn7zRBuft1+HdLx
	2Q9pT7rS/rb+f1aagLmIUEzUTTBxW7D+Fvt9WDbPsZHQM2GCe2AcgN/R4IVpdGdy
	z5+byA9kCpHZo+RC885vrnsqpnR3LVg6w5EZJGcmN+hbwBJHFdfFGCxOt7ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773566742; x=1773653142; bh=AI9EBvIhSJL51T3pR3nWRZei9IvwjbCjAav
	H2TVzADk=; b=GdUgJJix8oL5JsMLSBDAG51AP3bWyQbN2bV59aYa5v++Z7hSFDe
	5xlPNxUUr1fhU2ThNEBVzEIkpLKYsflaNdyx/IRshEGiTBZJb78+6CpkiXgk/Ctt
	tt8y0eP3glEzP18TmSRSicaLAbDhxHNcHxEO1AWO8Zpq5rpYGCSo/ZxFqWTLzQLq
	ZdXf/8uu6dj//s4LuBQwYdip/HF1GuB4It8Q2tl+VZ+EcGu3Hqf6XxevpUV+//Uc
	p1TDG2EAYBfA8shAJ6FBywS5CqS0ZewdeBnBvPejbBxWaOiTuQVDXg+7vXfambly
	xW1qCKQkwDDcEXxXDOBw2t4cPK4IAwFJMGw==
X-ME-Sender: <xms:FXu2aUHZrge03tE5x-V2AQzVNc7TA8FU4GTyWse2jJdj3j4HYwMK3g>
    <xme:FXu2afnqXAG24VD26ZA7OupOC1l8fakuR-Yux4ByN7qkgmi-X5aU4A6E5BGgP7G0b
    p6VzU6I3VwuSeRjrpOwVjIoknkwKUf6toCHPnP4rBzxRDB0VVfjHg>
X-ME-Received: <xmr:FXu2aQaee4ZxAdQVPQSP0_GsdJG85Aq89CEIYnXrzAzfrTCC1u-g4NESfjPDFnwXVe_290ITAdRR7HxpslQ5fmxbXEPzt0PwKN6lQIIS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleehudduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:FXu2acEa08JgitFyhwjU2EfVunDTRI-_MCECqOw9lMAO-pW5q-eRxw>
    <xmx:FXu2aZKejO3gbFDDYO8PxTJrWdSRNPTfJKKVJwJQYXRIOhQUHDj-ow>
    <xmx:FXu2afMPPJgKe5TjRnAihXEf1hv2kj_Rep5EPuMz3R0wZQmPs1NJxA>
    <xmx:FXu2aRl4xanJ5ZNc9oDLTpBa9EfeTwkCT5j9ArCrsoItKsZkUrj3qg>
    <xmx:Fnu2aXvWUiz3HJ_2jlXtbex9BSVY1bbfMsdeBkkDC5SRLIGxLylikkTK>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Mar 2026 05:25:41 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 4D1B678E34F9; Sun, 15 Mar 2026 10:25:35 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Eric Auger
 <eric.auger@redhat.com>, Miguel Luis <miguel.luis@oracle.com>
Subject: Re: [PATCH] target/arm/kvm: fall back if nested unsupported
In-Reply-To: <CAFEAcA8ycT250JaECAYTKF+U2a4m6jauLPLbD8PVx2atd70A7g@mail.gmail.com>
References: <20260311095405.26297-1-hi@alyssa.is>
 <CAFEAcA8ycT250JaECAYTKF+U2a4m6jauLPLbD8PVx2atd70A7g@mail.gmail.com>
Date: Sun, 15 Mar 2026 10:25:33 +0100
Message-ID: <87ms09v3zm.fsf@alyssa.is>
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
> There is no guarantee that the machine is "virt" or that every
> KVM-supporting machine has a "virtualization" property, and
> the target/ code isn't really supposed to do board-specific stuff.
>
> The board-independent way to say "are we trying to enable EL2" is
> to look at the CPU property has_el2. But the CPU isn't created at
> this point, so it's too early to do that here.
>
> Similar things where the early accelerator code wants information
> from the board we have handled with a method in MachineClass,
> like get_physical_address_range. We could do that here, but
> maybe it's a bit over-engineered? IDK.

What do you envisage this looking like for other platforms?  Something I
considered when working on this patch was moving "virtualization" from a
machine to an accelerator property, but I ran into the problem that such
a property isn't exposed on e.g. x86_64 as far as I can tell.  This
MachineState method would have the same problem.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCabZ7DgAKCRBbRZGEIw/w
oshiAQCuquVQl2VMEHIiIi8ybSl1FvstII7T8HrpbHj5MWjF6wD9H0djKqy20VXH
12EGrrib9qD/m78eJcPNupmzxGYzBQ4=
=Vey7
-----END PGP SIGNATURE-----
--=-=-=--
