Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F745A294
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543705; cv=none; b=s3d4LGRzK5aeQIFYNF4mUnNcNCRsliLEz05yRhIlUir/7iwMf+04uEtSt/4+QB5VOCSNVVbnRBb5A/7OyfbP9MfcfbG1n89SqmyITlkSSI0lj4H+XPLTkwkX7tC3Ml/GqnIbEI+VmAFXY/CtP/D/QKq8HAdyrIt1DMx1C/cTEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543705; c=relaxed/simple;
	bh=os7EwiQe8RMHUG/v5Fc3T2deFHuXhjNIWcADyUdwYmM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OHuk90OxOKD2IgdZe/zGTSmXCcTnzOkGdEDUGkGe9Jhx82qMpKOw902T/AHs/JJPX7KsEyR+6Knj5J8hyFQ03zAaLGiMpo/Fn5j5iXVUMrJsZpE2SHiVTh/h+Qf6/KXa7/ETs/Abxqv7RliewiAtsO4zTYH/9aag7mlwiM75FG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k9phUrN0; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k9phUrN0"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e024d2129so1584003b3a.2
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 07:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786543703; x=1787148503; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o4LQ7ydwKo4pceut39Ff1DkZDhkgWaP2qESqJpFnuBc=;
        b=k9phUrN05kLXOsFUufRvPxLmlJhn0ZC1e15adh81ZcFUF5VIGidO/r4u4RvM7L8MGF
         AX43nm/vx84qHKLO8CIeoIQTrZ2RhcuIrm4jCPDSYOtZML5XYXRJABjC0NA1Pr0Ap7YG
         G18kOYZ6H01w/124hdwRRZiacGPAM55W58nwcrJlt1dnGFg+GZsLaVDWIyixIs7FtHbr
         d8giFMGRj5RSjaDLOLltNrPrwbEy7AXVsKDzGoNmHM2gzYRxxsa5hFY4CKLT55yp8KB8
         L0J2aDDGlfeYIPVTuAQ+BiWbzSHRag8aUhmKqqAHD6Eu6rEIL212d2oThlkq5K84Xvq2
         tGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786543703; x=1787148503;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o4LQ7ydwKo4pceut39Ff1DkZDhkgWaP2qESqJpFnuBc=;
        b=mLVYGYb22se04VXbso9QIVgqeQCf/uSw/DGaoVYcC1BpWidTgC4xkmbyO+RSm+/Hdi
         Lenne9nCuwj0G/HDbo+wL2vQSRpdmZ7wfWIlj2Eu3oDEMutwRWM8D1mr88a18XrRtKK4
         LwpwAgq2vYuR0o3JDfQEJjDAXSxJL5/xsCAaNE918b3z4HPqSML9ujgUgZLFxityO3Gb
         FFnkoDJO/yGdidstCyHHaagl+xHORM7djn71iRXCFOPQYEFqSxPyfnDtKW1KUEE1V+yk
         47NmaTiDsIcLEJWfipcKxpBc91meEaD/JCryr6ShnofjMD3FBS+CaMpLPhbWvjVRa+o0
         xjbg==
X-Forwarded-Encrypted: i=1; AHgh+RopfVroOP0eJgoTfL8gt3foEnpP+2lS0q1Y6wZ8QFfnKcA2Q9RGg76DCq10yCuQI10wggI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZcdROTEmUqT/jKiK1sv2XeRLhb1OJO2BLbc/LpLMNYXFOD3GV
	9AIN/3c9rqJc2NYTBckHQAqkXPerEtdMrpajVJuZx67Zod0OkC52i+utgFSZ66hzz8JsdXzrcEv
	9CzfHDw==
X-Received: from pfhp10.prod.google.com ([2002:a05:6a00:a0a:b0:84a:36a1:6b10])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:288e:b0:84e:7ec:aa42
 with SMTP id d2e1a72fcca58-84fb5408be0mr6236290b3a.10.1786543702948; Wed, 12
 Aug 2026 07:08:22 -0700 (PDT)
Date: Wed, 12 Aug 2026 07:08:22 -0700
In-Reply-To: <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com> <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
Message-ID: <anxvwV_Pz4UYaxxt@google.com>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, Peter Fang <peter.fang@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Artem Bityutskiy <artem.bityutskiy@intel.com>, 
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026, Rick P Edgecombe wrote:
> Sean, Dave,=C2=A0Kiryl,
>=20
> In PUCK we talked about how the TD scoped quote operation avoids changes=
=20
> in the guest. But this series is actually changing the guest, so is=20
> somewhat at odds to that assertion. It turns out there are some tradeoffs=
=20
> here that also connect to TDX migration uAPI. Please see below for an=20
> explanation and recommended course of action.
>=20
> As a gentle recall helper... The general attestation flow converts a=20
> report to a quote, which then gets checked by a verifier. The report is=
=20
> like a snapshot of the guest and its environment. The quote is a signed=
=20
> version of the report plus hardware certs. It's signed with a hardware ke=
y=20
> and can use different kinds of crypto.
>=20
> These pieces are evolving to handle a few problems at once:
> - The stuff that needs to be attested is growing. Basically more platform=
=20
>   details and devices are getting added to the blobs.
> - The crypto stuff is growing. The post quantum crypto stuff is large,=20
>   etc. That stuff lives in the quote.
> - Migration wants a quote that is platform specific and not TD specific.
>=20
> Because the platform details are growing, they need to either go into a=
=20
> larger report or added later via a TD scoped quote. But the post quantum=
=20
> crypto stuff is going to bloat the quote either way.
>=20
> If the report grows to include all the TD specific details, then the QUOT=
E=20
> seamcall can be platform scoped because all the details that it needs are=
=20
> passed in as args.
>=20
> But if it is TD scoped, the report can stay the same size and the extra=
=20
> details can just be added during the quote operation. For migration, it=
=20
> only needs a platform scoped quote. If there are extra details about a=20
> specific TD, the migration stuff can be fine to just ignore them. (i.e. i=
t=20
> can get what it needs from TD scoped quotes or platform scoped quotes).
>=20
> The current QUOTE seamcall supports both: platform scoped and TD scoped=
=20
> operations. But since we could get by with either only a platform or TD=
=20
> scoped seamcall for both operations, we could reduce the kernel's uAPIs,=
=20
> or change the API's location. Per recent discussion, Sean sees TD scoped=
=20
> APIs living in KVM and platform scoped things living in the host=20
> driver/tip. So all that leaves us with something like this:
>=20
>  |Normal quote    |Migration quote |Report size|Quote size|uAPI location =
 |
> -|----------------|----------------|-----------|----------|--------------=
-|
> 1|Platform scoped |Platform scoped |Grows      |Grows     |TDX host drive=
r|

With my KVM hat on, this option looks very attractive.

And with the caveat that I'm most definitely not an attestation expert, fro=
m a
separate of concerns perspective, IMO it seems like the report should conta=
in the
TD-specific information while the quote just wraps that information in plat=
form-
specific goo.

In other words, to me, TD-scoped quotes feel like a hack that was thrown in=
 to
avoid having to modify the guest because y'all didn't plan ahead.

> 2|TD scoped       |TD scoped       |Fixed      |Grows     |KVM           =
 |
> 3|TD scoped       |Platform scoped |Fixed      |Grows     |Both          =
 |
>=20
>=20
> I'm thinking we should proceed with 2 because only the quote size changes=
.=20
> So less guest changes over time. 3 is not really a disaster either, but w=
e=20
> shouldn't need 2 uABIs. For 1, from early discussion it seems it can be=
=20
> made to work but sounds like it will require some more extensive changes=
=20
> to the TDX attestation stuff. So probably needs a bit more investigation=
=20
> before we can say it won't disturb some other VMM vendor, etc.
