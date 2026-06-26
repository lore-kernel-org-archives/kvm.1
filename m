Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F6D78F2B
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782506812; cv=none; b=nk7oHWOUSatQLt10Cl3rsuDyWvL+OZ5gOQ/RHv8BJ1zI7lT7uaMp3k3Q0cP4EoqupRRMXBs865XvMjwgREjQoweOdva3c67kXf49Ftd99CYgdx2FzU/XaSkpMt7phmCMkTaXRGAbaI9NbsHswWH48vbUiR62pVHc9GONUncvX4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782506812; c=relaxed/simple;
	bh=e7J9uIK3Aofke44f4FDBkSxZh3Ga4jKB7NqOYQm2LHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hzbcBrWGuhM30HFcFIsDH9IBee/M3Z2wB46Coz8Asc7uqtOLphzpqliNpkbVpBky+RegV1T8KcD9Hwgwhy054a3QUQf2pgndCbpZjAsWWNNxIVf8G0/2zdrVC26l6aBzmjZrtRs68tXpqFUJPko/NGPc4hVkP3hpYiGLy+DI3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lmi2xh20; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lmi2xh20"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84534f17866so995903b3a.2
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 13:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782506811; x=1783111611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGydA0y/9gCZTrWkuXJsUrWFK6ou+XMOSPMt9MVQDVQ=;
        b=Lmi2xh207bVAbOfsfyhGOsoT6H/+82Q2c5fbFBuFDzffL0kqdR0KnFlkfHDuVSqh2X
         zLHVb4JqaAQHDBhN0FLXY04PBjNT3rx6cbFobbD3mKnfdIN0ASDV9pocdOtgXZNJf9QY
         ToEAoP8t9Bh3DIqS6GTWeVZYq46FTjN3MSjmQmpl+riOtRvtdt3q499KM13soDdK2j+G
         VPg9tfV+ms6dxgE/dbHY9ntHtcN6FN+ynm8LOR1iOeO/N3mLgzpV6QRR7dz79URGAHxO
         L0DygrZWP0Ispw7ztCZTO2g/6agBSLb1IttkCk60YtoBHPGD2QZmKz9bxs8FhSs1bUNG
         DJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782506811; x=1783111611;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KGydA0y/9gCZTrWkuXJsUrWFK6ou+XMOSPMt9MVQDVQ=;
        b=JiH8kCu1+EI7eHb+Pny3R+66rRankooUicB+dolk/9CFXsM53RprvFct6/rDpcCJX5
         ptozUXOlcC24fHI3+MOUOtlu9so6iZzGb3t5XoGniMBdVwEMQz9h2mGGBzDFiSDYymrN
         VQhVGovekY8eymag4such7g9RDoMWXqXw4wbaIahooC5ggLjD4mi/44KxAWL9lKblMkt
         1KSSPDe7RnHBgucA5XuZFwC3JJWngk51WWBqmuhrsfw8YfpXgaSP1XumLeHumNe5rmJ1
         E1lpMRG+ujWK6t0YxrvWShk8mfJkhsN4ujfoeRo0tA67mOzuzUtJDx90ntS84Nrr4cVn
         obRA==
X-Forwarded-Encrypted: i=1; AHgh+RrAd2bTz33WCCnI7PhG2s8bxLHMcgR8XcVi2G/9zE3pa83WNpJEhyVKjZ0yy7dSl4zI61s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb/e8A0jormWmjzo1a7X/Xt2lqpiSQRe7eoC02Ug1A7hSwzFWt
	bHr0ej57JJGeHIPU65vSR6bbs9KVbovQGCgDoyo3NKyhHoAkKzYKzTt/KA+tVzmA/6VjZLfef+i
	7QWgk4A==
X-Received: from pfm4.prod.google.com ([2002:a05:6a00:724:b0:845:bf85:3f1a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6c9a:b0:845:b758:90aa
 with SMTP id d2e1a72fcca58-845d2857835mr1434306b3a.47.1782506810703; Fri, 26
 Jun 2026 13:46:50 -0700 (PDT)
Date: Fri, 26 Jun 2026 13:46:50 -0700
In-Reply-To: <b3b60c37-aaf5-44b4-87bc-6aacd49be717@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623091556.1500930-1-joro@8bytes.org> <20260623091556.1500930-2-joro@8bytes.org>
 <b3b60c37-aaf5-44b4-87bc-6aacd49be717@amd.com>
Message-ID: <aj7lOltxzAej13RH@google.com>
Subject: Re: [PATCH 1/4] kvm: sev: Fix user-space triggerable WARN_ON on
 snp_launch_update path
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026, Tom Lendacky wrote:
> On 6/23/26 04:15, J=C3=B6rg R=C3=B6del wrote:
> > From: Joerg Roedel <joerg.roedel@amd.com>
> >=20
> > Sashiko reported on an unrelated patch:
> >=20
> >   [Severity: High]
> >   This is a pre-existing issue, but can a host userspace process trigge=
r a
> >   kernel warning by passing a NULL user address (uaddr =3D 0) here?
> >=20
> >   If params.uaddr is 0, src becomes NULL and passes the PAGE_ALIGNED(sr=
c)
> >   check. kvm_gmem_populate() skips fetching the user page and passes
> >   src_page =3D NULL to sev_gmem_post_populate().
> >=20
> >   That function then unconditionally evaluates:
> >=20
> >   WARN_ON_ONCE(sev_populate_args->type !=3D KVM_SEV_SNP_PAGE_TYPE_ZERO =
&&
> >                !src_page)
> >=20
> >   Since the type isn't ZERO, won't this allow an unprivileged user to s=
pam
> >   the kernel log?
>=20
> It would only be one warning that is emitted, "spam the kernel log" sound=
s
> like you could fill it with warnings. And I would say that the severity i=
s
> only "High" should the kernel be configured with PANIC_ON_WARN.

Yeah, ignore any and all complaints about panic_on_warn=3D1 leading to DoS.

https://lore.kernel.org/all/CABgObfZJV5hU_7WoPWLRH3-EvKts%2BUBZOwtCXmwVZYJP=
8dDo2A@mail.gmail.com

> > The assessment is correct, so check for this condition earlier in the
> > snp_launch_update() path to avoid the WARN_ON_ONCE.
>=20
> I'm not positive, but isn't it technically possible that the userspace
> virtual address can be 0?

Yep, though it requires an explicit opt-in.

  config DEFAULT_MMAP_MIN_ADDR
	int "Low address space to protect from user allocation"
	depends on MMU
	default 4096
	help
	  This is the portion of low virtual memory which should be protected
	  from userspace allocation.  Keeping a user from writing to low pages
	  can help reduce the impact of kernel NULL pointer bugs.

	  For most ppc64 and x86 users with lots of address space
	  a value of 65536 is reasonable and should cause no problems.
	  On arm and other archs it should not be higher than 32768.
	  Programs which use vm86 functionality or have some need to map
	  this low address space will need CAP_SYS_RAWIO or disable this
	  protection by setting the value to 0.

	  This value can be changed after boot using the
	  /proc/sys/vm/mmap_min_addr tunable.

> In which case, should this be fixed in the kvm_gmem_populate() API with m=
aybe
> a new parameter that indicates whether src is valid or not?

Nah, treating 0/NULL as invalid is perfectly acceptable.  It doesn't work t=
oday,
i.e. there's no risk of breaking anyone, and just because userspace can use=
 VA=3D0
for other things doesn't mean KVM needs to support that for all of its uAPI
surface.

FWIW, I was initially opposed to using 0/NULL to mean "invalid", and even c=
alled
it ridiculous, but David W. convinced me that accepting 0/NULL in modern KV=
M uAPI
would violate the principle of least surprise.  So now I get to claim using=
 NULL
to mean invalid as my own original idea ;-)

https://lore.kernel.org/all/a2cfad68277cae67791f07646c842672593a8dca.camel@=
infradead.org
