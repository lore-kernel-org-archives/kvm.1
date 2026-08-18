Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5097237AA98
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085467; cv=none; b=Ybx/TyB+LCBSRmt9oEshPbbKZkqfy6fVWYniFHH73dvViGSQbjHDo5Qz9BqfyNeRCh6N5XeFFVUgC1yBMT6VvyMGkF4qq2ZbeQrKOOdccqXYbqjTutg7Ic2NLbh/sEFcj1FyNP8qHCNM52uCqb0gLPcFjSud0CtskvngNbe7aaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085467; c=relaxed/simple;
	bh=6iPIb/NGfhyw66q8Gzx9C/Hh1IrKPQkJh6eoXaONCgI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZOR+EgYc6pvdOmQzxVrW4BqGi4e5UaNPchFhzcMf9cXAOAohZeRPJVO73NNAEmpHBSWRGfnQoQj4ldJU5kNW6gew2R11aukTym/+1LhaYVVZU+Ba03Y8m3d8fvmidW/Ze48V8CQtYdpEnjyxXVUPj5WWVViYUyGB0TGyzSvNWag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OF0T8gZz; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OF0T8gZz"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3950b1371a7so445188a91.2
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 13:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787085465; x=1787690265; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5bvSIbOOi/LGDNWtBrRegseU7kGQ5JA6GPeCKC+/MNs=;
        b=OF0T8gZzWFtb5XnwqvJMi5AKGmKV3VumsjLdWoxryvh8Cy+wBdPqa+BTn41hHKKE93
         XuCWU/d3Wem9XJCgA5PQ+xgTVYlWvoQFmOdSaLn9b9qF0AlE116l/OXXl6g2xxJWF4xR
         UOtPrAdewcWIsj65eL6Cl2/vjKEByUfRZhgVJpDw76UWNJhY0fnj7ubYl86FLgPR3+zm
         jj0F2Ocl7uGOomB/n6+ph/V0D8Vf+ahYi4MZAFm3vJwP8c/h6CJKeQWqSrgrOF+WohAH
         cspNcrUHOc/zZfHDKwg/7/wuoHie6NKsM9Jw1Wx0B/7cFRa9kCKSrO5kErVQVxt8GmjW
         /XPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787085465; x=1787690265;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5bvSIbOOi/LGDNWtBrRegseU7kGQ5JA6GPeCKC+/MNs=;
        b=mvJdGblDNVDjNg5r/Nz4RCm0bRmJYmgs8+XuUblzksGq++rHxH+9MZSS+1dFbVUvlF
         HPw89Rz7e6qlDsEXlUpWckqKiTsIahL1K2dygf6ZDQuyo53he7fVWeLNChjDXULhX7ZH
         +SVbcAQPUCfCphnSyKVkwqJBDi1VuirJ+rX5y7p0+5/oeO+3tIiG8DJMz9f8h4siAzeJ
         eS6wSAxlhpds0gK3I6UINvNMoMIrV6mlenUL0japDmVJYOCH28hbjLGZ+g7C/C8e/bdq
         UCaxJRzEq9ik3LBtSUSSOzIYXiKpoLF5RarfIjuCC3QdTS8spNmg62NDq8QJ6r6BwCTF
         vpsQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTXnfbJ2hPa0Pm0RAcy4ql7Scsh6DP9SGMeRMmpTYGHqLGPRt/6U6R8+tLBsOtyY2uyZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXk0RI1YP+Qca/rFzRuqqO3xIgHyeNr61+yXY3iEmM0g1Wr5D
	dABNHussLyGjsNo4Wi3oNYmypbsLmWDjmfNhhXYTBsh1jI0uk9mBdsyzqGHy8TxOP4gS+40rp8R
	Ew8XDWw==
X-Received: from pjbga10.prod.google.com ([2002:a17:90b:38a:b0:381:fafe:3071])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e50:b0:38e:2524:724f
 with SMTP id 98e67ed59e1d1-3957b2d203amr652642a91.12.1787085465373; Tue, 18
 Aug 2026 13:37:45 -0700 (PDT)
Date: Tue, 18 Aug 2026 13:37:44 -0700
In-Reply-To: <98dcc8a12f117745a1cb9981dc8f0f1548e9c96f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
 <anxvwV_Pz4UYaxxt@google.com> <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
 <anyiwqi9i0NSv0QW@google.com> <ed4891a59096c59e43a893910c9f17d0ff6086b8.camel@intel.com>
 <20260812223707.GD1013044@pedri> <6191a69559e58e04c8e3f1efa776e9639796af3d.camel@intel.com>
 <anz9b6CDkhr5D5RG@google.com> <c697ff1d97fe62882eaf3bd86a4213bf2e79fc09.camel@intel.com>
 <98dcc8a12f117745a1cb9981dc8f0f1548e9c96f.camel@gmail.com>
Message-ID: <aoTCmJXjQQbXRKqv@google.com>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
From: Sean Christopherson <seanjc@google.com>
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	Peter Fang <peter.fang@intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026, Artem Bityutskiy wrote:
> IOW: in the SGX-based design, it is impossible to add TD evidence to
> the quote. In the DICE-based design, it is possible.
>=20
> But the question is - OK, it is possible, but why should it be done?
>=20
> 3. Why freezing TD report size
>=20
> Linux supports 1024-byte TD reports via the `TDX_CMD_GET_REPORT0`
> ioctl. It is already full, no more TD evidence fits, and changing TD
> report size would require a new ioctl.

So instead of adding new uAPI for the guest, TDX adds new uAPI to KVM?  Tha=
t's
not a very compelling argument.

> Also, as I understand it, based on TDX feature requests from customers, t=
here
> may be a need to increase TD report size more often and more significantl=
y
> than one would expect.

Who cares?  And I mean that literally, i.e. "who" as in "what chunk of code=
 is
negatively affected if the TD report size changes".  "GET" ioctls whose pay=
loads
have varying size aren't novel, nor are they particularly difficult to impl=
ement
or work with.  What's so bad about adding e.g. TDX_CMD_GET_REPORT0_2 to all=
ow for
a variable sized payload and any other mistakes we made with TDX_CMD_GET_RE=
PORT0?

> Therefore, for DICE-based attestation the TDX module adds new TD
> evidence in the quote instead of expanding the TD report.
>=20
> Is this the cleanest approach? Maybe not. A clear separation of
> concern, with TD evidence in the report and the quote only adding
> signature and trust material, does feel cleaner.
>=20
> But on the other hand:
>  - The quote itself is already a per-TD data structure
>  - The it is inherently variable size because it contains
>    cryptographic=C2=A0material and trust data
>  - A fixed-size TD report means that at least one of them is fixed
>    size, not both.

Taking this argument a step further, why even have a TD report?  If DICE-ba=
sed
attestation can "add evidence" at quote-time, then just throw away the sepa=
rate
report entirely.

> 4. Migration-specific case
>=20
> For the normal user attestation path, the TD report is TD-scoped. For

That's not a TD report.  Call it whatever you want, but it's not a report a=
bout
a TD.  If the claim is that "TD" can mean something other than a TDX VM, de=
pending
on the context, then that needs to stop, because there is no way anyone is =
going
to be able to follow along.

> migration, the report is effectively platform-scoped, just because the
> migration flow does not need TD-specific evidence.
>=20
> I would say that clean design is when Linux does not need to know this
> and care about this specific case: be able to treat all TD reports as
> per-TD.
