Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6703A5E89
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632530; cv=none; b=s6CLYupJN9IWZ56xApXm5H1pSyInYGkjRKnBBzlMx1Yhl368flozyR0JQWhwiQ9tVdL7Q5JzwovoznEba6L4fgy2Z/BeXIOAQFOkjbft1FEc/gybO12rEAef9X0gDd2VRqj5Msb/i540mCNa4AwbSe15ro26HjBCSEKB5K3RdKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632530; c=relaxed/simple;
	bh=wyEbQvr0WV0ZnPjfcpm0VVT3tnoktd6L8vNFWCRTjco=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FC92xkVhSdMVfh5FoBheLqBrsrvfTUoSro6Vy84z43pT5jF4e3r39kTxVV4qzOXJfLFQyfl9Eq8rUi0OY8ikVRb+Hb/pB1wjRLwzGJ/UjUSdlAH1HzK5P8pYUrZwj8WaeJbiJPbfJEC2EaOLUktVa1OS/8FSLuHG33JrN17A2p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UC5sRJxT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UC5sRJxT"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c6a3ece0d8so5609485ad.3
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 10:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781632529; x=1782237329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXTEeiFwMNJwAREmW2qznxqP989VWLDzEiyMWvN/UzQ=;
        b=UC5sRJxTu0Bot0o09zLbqSXhKdfcrltDbLllnl11kIAcq8stm6DML4kS+4wzIcc0LN
         tX15Yqz5xo+ZPTcKtGKKm4qAIviwM8H0u4bx3ZpvOBB5OpCq0AgHpTnCXRWsdCKqOZPY
         B4/t/rYe5N7/t6uYsnM1LQ0PXGmGEJ7dFhWDukM/4NkVx5KGOmoRPgqmGn9sYOVDQUmD
         1NOtyATNbgjN/F1ScAbMh1cBMKcTlxxbcJowo21q0bCk+HF9kvjK9n0PhIAPojj5pxZf
         RzRduTqDt/lNsDSIS1Uxhl60qqpVz6WMj7B3As++GXdWT9FvU1xEjQ718tYpr2u1gMxS
         Bwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781632529; x=1782237329;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sXTEeiFwMNJwAREmW2qznxqP989VWLDzEiyMWvN/UzQ=;
        b=aqRpVO1/CyPVg9r9pGRkPXm3WJXKTuLp1JjAug+RfSMuIenSPtQm5obNoJKrfF1pfc
         +CoyNbBfXITApLSO5+np40oHq31hnu4yQnbPQWyTUcTDJ57SCPM73jZ2rldeVZ96tHp0
         d/hKAlzCSeJu4Qdi3YFPgbG4gsoLQB3KmZewTU2wps96q+DHIpeGSJGN6r+DY4YT6mer
         GbMvvw5ThW9GsX4vzTMO4Tn6qG8vgaxcOEbYFojiee2O43kEoIQcoij3ebKovOgYAXpe
         4uyAEFyVCaWWVXh9FkH2WBmihjg6Eg6cnZ2t33s8oU2bYmWBzxcbeyEZymC8TqymsNxI
         CXnQ==
X-Forwarded-Encrypted: i=1; AFNElJ8GJj01ylZpgd7/Cs+2DoCryp4y3sIpYF+9G4zb7vEQmlVY3RrjLlk9sBi2LMT81Jf0HU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2fGxqydHRZHG3joVk5ODa6qk5SMcLwd3wOw0oXqJ0/yGdYgFy
	4LrbUIUks9eCP2Y1QlLNNi8enpqnPptZHOcSwTEEidJiq7LrpQzSWCpcP/7adtGgwftPkzOJ8n/
	W+pY/kA==
X-Received: from plmm19.prod.google.com ([2002:a17:902:c453:b0:2c6:a230:e579])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c46:b0:2c0:bcff:e191
 with SMTP id d9443c01a7336-2c6bc27199amr384785ad.36.1781632528872; Tue, 16
 Jun 2026 10:55:28 -0700 (PDT)
Date: Tue, 16 Jun 2026 10:55:28 -0700
In-Reply-To: <aiqwjn2DVOumfr3T@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611123528.572255-1-joro@8bytes.org> <20260611123528.572255-5-joro@8bytes.org>
 <aiqtWVMqTK6vDoZ8@google.com> <aiqwjn2DVOumfr3T@8bytes.org>
Message-ID: <ajGOELiYwKByXbVP@google.com>
Subject: Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at SNP_LAUNCH_UPDATE
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>, Jethro Beekman <jethro@fortanix.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+Jethro

On Thu, Jun 11, 2026, J=C3=B6rg R=C3=B6del wrote:
> Hi Sean,
>=20
> On Thu, Jun 11, 2026 at 05:43:05AM -0700, Sean Christopherson wrote:
> > On Thu, Jun 11, 2026, J=C3=B6rg R=C3=B6del wrote:
> > > From: Joerg Roedel <joerg.roedel@amd.com>
> > >=20
> > > Support setting a VMSA in guest physical memory during the SEV-SNP
> > > launch process. Only one VMSA can be provided which will then be used
> > > for the BSP. All of the APs will not have a VMSA allocated or assigne=
d
> > > when this feature is used.
> > >
> > > This ensures stable launch measurements on SEV-SNP which are
> > > independent of the number of VCPUs the VM is launched with.
> >=20
> > This needs a *much* longer explanation and more justification for exact=
ly why
> > this needs to be handled in KVM.  I understand most of the words and ac=
ronyms,
> > but that's about where my understanding stops.
>=20
> Sure, how about:
>=20
> For SEV-SNP VMs KVM currently allocates and measures one VMSA per VCPU in=
to the
> initial memory image.  Historically this behavior comes from the SEV-ES
> implementation, which has no concept of a guest-provided or guest-owned V=
MSA.
> So on SEV-ES there is no other choice than allocating the VMSAs in KVM.
>=20
> In contrast, on SEV-SNP each VMSA has a GPA assigned and is (in theory)
> guest-owned, so that the old SEV-ES behavior of letting KVM manage the
> VMSAs causes several problems (especially together with IGVM-loading)
> and inefficiencies:
>=20
> 	1. With the current KVM behavior the initial launch measurement depends
> 	   on the number of VCPUs the VM has assigned.
>=20
> 	2. Current SEV-SNP guest code will not use the KVM-allocated VMSAs for
> 	   APs. Both EDK2 and the Linux kernel will allocate and provide their
> 	   own VMSA pages for every AP. So the current allocation dance KVM is
> 	   doing is useless for the APs.
>=20
> 	3. The current behavior makes it impossible to implement the
> 	   IGVM-promise of a predictable launch measurement derived from only
> 	   the IGVM file and the target platform.
>=20
> To solve these problems this patch adds support to measure an IGVM-provid=
ed
> VMSA page into the initial SEV-SNP memory image. Only one VMSA page is
> supported for now, which aligns with the IGVM requirement that each file =
can
> only provide one VP-context. The VMSA will be checked by KVM for supporte=
d SEV
> features and VMPL0 before being accepted.
>=20
> When a VMSA page is measured in this way it will be used as the launch VM=
SA of
> the BSP for the VM. For all other VCPUs KVM will not allocate or measure =
VMSA
> pages, keeping the launch measurement in sync with the IGVM image. The gu=
est
> has to provide VMSAs for all APs it intends to use, which common guest
> components already do anyway.

Isn't this essentially the same thing as hot-plugging vCPUs after launch?  =
I
have yet to review it in depth (sorry Jethro), but it looks a *lot* simpler=
.

https://lore.kernel.org/all/20d3a189-5649-4864-81cd-5a421267f21b@fortanix.c=
om
