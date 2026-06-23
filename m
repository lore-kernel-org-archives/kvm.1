Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7878935DA7B
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246234; cv=none; b=WEURjiRw183dC8MeobMfxn0L8YEHBAdpWwsKDUw6uzhjsJvAD52kzHMsWfl24lbjinCEoxYFl0vipsjilhGDD4nPlLlSE2K2hoRdLCk+LXou6NUhFFwNwqB6K5tmogbKNlSsuRMH65i6GvYJLUywyQJeW5gTbnWN2JxtUHk68ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246234; c=relaxed/simple;
	bh=TMf7sYrM4BRP7pHSA+LbyCfawDFBWQK7WASMofFKCEA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p3iEn5Cf6zCcopizLQ4F9YpCQl5yUehCoN8tJb/zSYHMo0bMnqmU/QEoAAsrLynEz0HU1zw1AwYsU1sDUcMP/5qjJoTwk0Jr9Lz378pgothOaUJJ1s1RrkvwoMioYrFe6hbxMdfvh/cjEuVkWXS55mv0pPN+w/7zWXsRqi9HyIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=paASiZFs; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="paASiZFs"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0bf6904a6so3179305ad.1
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 13:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782246233; x=1782851033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PhCsk6gm09167ahnXNRd5Tc3HOZ2IFvvG/9MQPlCJ3s=;
        b=paASiZFs2Yq2uGmw/yccGkEf2MSDhCKel3IGXdWDGENZRTtpaTTwgQl6eEWHlzkv9+
         7GYL3cZSg7Iumuao0guEg5ZL7UUDHCsLV1rg8hknSJueuqarYDVVaSSlXMi0EX1oLsSp
         dlAR9Y8sMiLOGIf0bZwZeENogIqB1ovWRXuus18wB5i23LyAaKJGLAZYW1d0P5DAlkgu
         8oNXCFEfmcwPkJ6C7eWCtVpSM+Zpb2qJNwwY7/W3aN8dLh6APy2EQ+90fHzcsh98LO+N
         MvIvD3HsHr/HLy7D+KFxEGM64SmitFibOjmyhOVWSkkJzapnAp+uFoHH+NTvn/4XfXFD
         a81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782246233; x=1782851033;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PhCsk6gm09167ahnXNRd5Tc3HOZ2IFvvG/9MQPlCJ3s=;
        b=DiL2VP/vyVWg0C5b8GvyBR3MEwx5wFFL9IojAstcmrTsD41v3MAjSVljWrGNof4iZ7
         NYn0dnTos8YLUWQh609wYy3QWDeEo0jrQc+GRB/7RscjTsdUAFvpnJ76PoT+N8+yBpvM
         mK8iuhv4xgoh5WjzMamKr98d8BraM/eNDkYgqBKOD2CmS9XUATEj/hIdnLEOcMUocXE3
         0DWyNsuBfxeHnv1mi2+gDyxNAlrrckO4bR+/uzBWPCloKjFJ+v6EOP9Zg5BWpe1WMxU9
         xb2VhAbs5kA0XhZ5urFZfzzd7sNV63KQRT2CDaoxBkrFQMdbbEg/wzPzGKVKrfv6LZmK
         wmeQ==
X-Forwarded-Encrypted: i=1; AHgh+RoliICva0RU1eDOSSXDmqBxPOLLDIJ31odJWb4Vc7NPW50PhRRckbxy2E4OMwiqj/Amgx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+cDyxHr/RcS2XUa+jAlloZ8TUq8cdIQ+ShoS5nSH3dtR3FjO7
	Y/vcm/eVc10aJ07lrP7tIr94azPh36Ia/S6V+SiQZaHAAmooa/H5sF/39K8cxlVueQyXgUOg+6l
	Bxt//Mg==
X-Received: from plbml3.prod.google.com ([2002:a17:903:34c3:b0:2c6:bebe:2819])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db03:b0:2c6:a185:be8b
 with SMTP id d9443c01a7336-2c7e1430108mr4430985ad.10.1782246232414; Tue, 23
 Jun 2026 13:23:52 -0700 (PDT)
Date: Tue, 23 Jun 2026 13:23:51 -0700
In-Reply-To: <LV0PR21MB6859D1AEF99FB84228C23620CAEE2@LV0PR21MB6859.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aiqtWVMqTK6vDoZ8@google.com> <aiqwjn2DVOumfr3T@8bytes.org>
 <ajGOELiYwKByXbVP@google.com> <ajJAYZAPxNrrsiYp@8bytes.org>
 <ajKadxZEMI253AoT@google.com> <ajKe-oboTRowcO_i@8bytes.org>
 <ajKjMIBb21qB46fh@google.com> <ajKnKeo1FV3zbjEt@8bytes.org>
 <ajqMvQLMGONiLn1S@google.com> <LV0PR21MB6859D1AEF99FB84228C23620CAEE2@LV0PR21MB6859.namprd21.prod.outlook.com>
Message-ID: <ajrrV4SHHkS6thjQ@google.com>
Subject: Re: [EXTERNAL] Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA
 at SNP_LAUNCH_UPDATE
From: Sean Christopherson <seanjc@google.com>
To: Jon Lange <jlange@microsoft.com>
Cc: "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	"x86@kernel.org" <x86@kernel.org>, "thomas.lendacky" <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"coconut-svsm@lists.linux.dev" <coconut-svsm@lists.linux.dev>, Joerg Roedel <joerg.roedel@amd.com>, 
	Jethro Beekman <jethro@fortanix.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026, Jon Lange wrote:
> On Tuesday, June 23, 2026 6:40 AM, Sean Christopherson wrote:
> > On Wed, Jun 17, 2026, J=C3=B6rg R=C3=B6del wrote:
> > > On Wed, Jun 17, 2026 at 06:37:52AM -0700, Sean Christopherson wrote:
> > > > Ok, so it took us a few times to learn our lesson.  I still don't s=
ee that as a
> > > > strong argument for new uAPI, especially not for VMSA pages.  I am =
very firmly
> > > > of the opinion that letting anything but the host kernel configure =
the VMSA is
> > > > beyond stupid, but unfortunately we're stuck with AP_CREATION.  Exp=
anding that
> > > > surface has a very, very, VERY high bar to get over.
> > >=20
> > > The strongest argument in my view (and the main reason we are doing t=
his) is
> > > actually the predictable launch measurement. On SEV-SNP this is a req=
uirement
> > > to use platform VM-identity features like the ID Block.
> >
> > And I'm saying that unless KVM *can't* provide a predictable launch mea=
surement,
> > which AIUI isn't the case, then the launch measurement *must* be stable=
 across
> > kernels because it's part of KVM's ABI.  So as I see it, the issue isn'=
t that
> > KVM is inherently unpredictable, it's that we lack tests to validate a =
thorny,
> > subtle piece of KVM's ABI.
>=20
> Joerg is suggesting that we need a launch measurement that is stable not =
just
> across multiple launches on the same system, but across multiple hypervis=
ors.

*sigh*

So that, and also the multi-VMPL implications, absolutely need to be decrib=
ed in
about this level of detail in the cover letter, and the changelog needs abo=
ut the
same level of documentation to justify the various design decisions.

Bluntly, all of the changelogs in this series are awful.  +200 lines of cod=
e in
arguably the nastiest bit of "architecture" KVM has to deal with, and the l=
ongest
changelog barely hits 6 lines.

And whatever uAPI we end up with needs tests, and a lot of them, including =
coverage
for negative testcases.  Because I'm working on fixing the third? guest-exp=
loitable
DoS that's unique to SNP this year, and I've reached my breaking point: I'm=
 not
taking new functionality like this without sufficient test coverage.

Rant(s) aside, thanks for the information, it's super helpful!
