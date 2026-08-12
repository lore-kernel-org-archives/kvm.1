Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB48390603
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553029; cv=none; b=JmF9bHklORKL1FvIYn0BzDpAPlW0lD5M308Vsgfte5D90KUYv7ucVgbqOmwi20GZkxehbTXJox8cAJfFxsyHNslE5clxNHMJOeHNEw85jHQ8+3ncyC1XiU2I5uwO4nJuykeQAe+hylrE1mnOGI6A8iFXRJumg54g8XmZwvkwxDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553029; c=relaxed/simple;
	bh=qLDEIioUL3e7c7lhtoaFmAMbbGSjhMZuTdeVLqKZKZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OG091HBfzJQU8KNCofj7cB0duLEWj+KfJHfN9M819/mPalh8ECM3lNFbswnptoYNFzWw0HhWn96hcpC5tmHzswnpov0pCymTzAXuqwsAJ6O/LOKEJcRzaX0wyI2YGnfXtolTYChCixclUpOF/r0cCXKkD8mUpp1v7D4aewjQN7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYtON+bQ; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYtON+bQ"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cca3673560so16652055ad.1
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786553027; x=1787157827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EVPNR6FWW7kQEwr41zGzOGzrHjzU+yGB7D+zhP7khak=;
        b=IYtON+bQ46itmarbFu/tTe4EPUMORSev6xJyYjuNuWihTifuFRM3DhiGMEumw9ikow
         n3dprJ8UFSPYBa+uXDQyZLFKxh976x7dgEga34i5d5FJc4Dq4JPKpiaOIlWaGJdiKO+9
         S6ymJ7Cb9i2V6YJnx6d2+xn4Zo/kOw8GBqDXuAz0SFBQF+KnchepqQUZN0WOwyiCq9s+
         w3+Pra8CunsG7F/ZjWRNAo8Mpv4zM5F8B9WbSBxCMzVCXK47PSZ6DQblM1kXLOdET89w
         sCm4F3D2JBUQt9rq9x695OxYttGPJlgyhtb4BKz+DTGa/I3mcS1jQF+ysMhrZdKhR8z0
         poAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786553027; x=1787157827;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EVPNR6FWW7kQEwr41zGzOGzrHjzU+yGB7D+zhP7khak=;
        b=E9nTCSDESYHV/8Ql1WRMIUkLX4bEyF+5S50niUM0sZjCEw0SdnghaL6PaCa1Rn42T5
         cvJyUmCseXhPko2jWu0nJzs8rdHyP1EBUOX8UyibKVZ9jTicL45KgdsDU/y+BS36JiGJ
         7Qug1wTp969WrNXyre/FhIIluiw2L+1T/032asLywDCeSuFdDQWZZLoKbi+5GELMLjAk
         +i8QvHrYViht6GTP5VI4AsP9++lZ1ll24vOgo+KAYMZv7J1iXZNI8kSeMhwBibwxp71j
         4ELRIPKhYHAzolUKv9Bo1CnGhV46yQVz8nQygTUt7A7O61pyZ48j51YVpm13CQFg+uqf
         J99Q==
X-Forwarded-Encrypted: i=1; AHgh+Rog2aTypjYSn5T6Afj3IJqUVjwNkJg48DyvyRLS1URXGyiMCyIqYF0bS/Fvr1Fk2zrKqSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO9X+e7E8epdXF5AE6uphAm8ZIXI5Yo+6AE7wbubfGYPjCqfdG
	N4o88K8LQgtfIMzZSG4LNxMesHp8iuPFKu9x3IjTYfPK07kR9Rkkw9kYnpSlFTRq7jCO8yhe/CS
	g3jBZZA==
X-Received: from plbkr8.prod.google.com ([2002:a17:903:808:b0:2cc:8741:f340])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2cb:b0:2ca:d658:d874
 with SMTP id d9443c01a7336-2d345713af3mr80782795ad.23.1786553027152; Wed, 12
 Aug 2026 09:43:47 -0700 (PDT)
Date: Wed, 12 Aug 2026 09:43:46 -0700
In-Reply-To: <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
 <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
 <anxvwV_Pz4UYaxxt@google.com> <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
Message-ID: <anyiwqi9i0NSv0QW@google.com>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "hpa@zytor.com" <hpa@zytor.com>, Xiaoyao Li <xiaoyao.li@intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Artem Bityutskiy <artem.bityutskiy@intel.com>, Peter Fang <peter.fang@intel.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026, Rick P Edgecombe wrote:
> On Wed, 2026-08-12 at 07:08 -0700, Sean Christopherson wrote:
> > > =C2=A0 |Normal quote=C2=A0=C2=A0=C2=A0 |Migration quote |Report size|=
Quote size|uAPI location=C2=A0 |
> > > -|----------------|----------------|-----------|----------|----------=
-----|
> > > 1|Platform scoped |Platform scoped |Grows=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |Grows=C2=A0=C2=A0=C2=A0=C2=A0 |TDX host driver|
> >=20
> > With my KVM hat on, this option looks very attractive.
> >=20
> > And with the caveat that I'm most definitely not an attestation expert,=
 from a
> > separate of concerns perspective, IMO it seems like the report should c=
ontain
> > the TD-specific information while the quote just wraps that information=
 in
> > platform-specific goo.
> >=20
> > In other words, to me, TD-scoped quotes feel like a hack that was throw=
n in to
> > avoid having to modify the guest because y'all didn't plan ahead.
>=20
> Caveman crypto person here too.=C2=A0It seems scattered and makes me simi=
larly
> suspicious about some lack of planning. But I kind of came to a different
> conclusion on what went wrong.
>=20
> It seems to me that from the overall solution level, the report should ne=
ver
> have had the details in it. It should just be some nonce or some type of =
thing
> that can tie the guest request to the quote that it ends up getting
> back.=C2=A0Doesn't it seem weird to get a bunch of details from the TDX m=
odule, then
> pass them from the guest to host KVM to host userspace then back to the T=
DX
> module... which already had all those details?

Hmm, my mental model of this is that the report contains the "real" payload=
, i.e.
the metadata describing what is running and whatnot, while the quote effect=
ively
signs the payload to prove the provenance of the report.  That's why I view=
 the
report as TD-specific (what's running) and the quote as platform-specific (=
provides
root of trust).

> My understanding was that the original SGX attestation was a complicator =
of the
> design of this stuff. Because I'm not sure that SGX had all those details=
 about
> the TD. In fact I can't see how it could have. Is that right Peter? So it=
 needs
> them all to be passed in. All the extra validations etc of this shuffling=
 is
> TDX's problems to deal with, but for Linux, it would be at least a lot le=
ss
> confusing if there was not two things that have the TD details in them.
>=20
> That said, from KVM POV, (1) kicks the attestation out of KVM. I see the
> benefit. But a TD quote is a TD scoped operation in concept. To me at lea=
st.
