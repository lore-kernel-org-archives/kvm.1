Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A962B3D0930
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787165109; cv=none; b=mJ/7mpuMEOvgqCWx89IV8sNev3fR0R/jZqWPoJCygN5qTKFRh4FJnmwNnMUIYcuh0VyIxgy8z2UkFxTNMAwAWCfb/uSOgtWUNOIIKJtBV7kN2JmQiqbRr/saaIAlJJsH7eePOiiqJ+8mktRALdgllFsjQzX+EwROl2Kd8G1ESYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787165109; c=relaxed/simple;
	bh=yUbh9q4/j0SCopnm9+kqCeIz9+ESUtedgAp9LXSl/3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qYe9p0Vbyt7fJfFMvCSJtgI4R5VVwQ6d+eGt08uumnB76rwd5FR1Rzfy8zcIHg81lKLmFUE071/r6ka1HjoLnhyZDrOOOt/+VyFu9heB336i5Nj8CS0kDyJ2SQ7p28MZw5yHLX6jffNAVUIbn9LwT01/3mAap3LbRRIw+o5ABLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BYvCnUym; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYvCnUym"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848474825ffso140749b3a.0
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 11:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787165107; x=1787769907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k4p14h0rjsNJW1bNQwRsqWqcvxVCIyueUJIc9pTWh3w=;
        b=BYvCnUymSZeuYk7yPgTy21FanMngTPFmBWcKe60IycDn5uarnWZUWQ8rXfKYTRVtEp
         LNgyWU2n+KqvdQTJzPgfeVYlbpN6QeW4PkSDU9ifPPcvM/pAaq2hMsbt3cmRTGIRT8C0
         jopJV+u04xrrmoHDRhVdneO6BuJWlawY6IOUQSxKyV34f2JXC2CPn9IaN5BKyrJOOGt3
         WCkUo4+3Ql02rX2fjucc5X2S1oN1RHq7YK04krn+5fLRaQvD7ze2JTUFJ8TIHiHrqodJ
         +7aQeQT0h5m4dZkW8WkBFvasB3VlV6/Ke0tdquetTGop6EJqEjCn2YYFYmiupXpwuZRY
         Y9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787165107; x=1787769907;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k4p14h0rjsNJW1bNQwRsqWqcvxVCIyueUJIc9pTWh3w=;
        b=EJzEkiXQDUkUVXwZQj/d0htn2bUX4vMgqTmOEfd5EM7wkoxkYb4TobyU1/GQVdYreK
         EZ7F0/g/oYzwm5xIw5JJV4ngsozEUrotOQ88PfZUjIn79Lf/i3/GEwwZZmZ0enMmCnM2
         1iLsdyx8UC1AxDug6MNeDKOrnLrxCQnQWlQg9prdZTb5ZOkag6xT6vsRSKLesCicGci2
         ylcfcQd55yPCDgJVjxwhTy06OG9Y+Y27DMRv26FeGuj6wa2chucb38A2wSeGJmINw+FP
         x+9UxvfFqIHpHL64e5LheKw1rnmSEH4c12Fhg/eR1OIZOHkt7Q34dFdY4ejFu9ndRiah
         PNvQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0R/IqsMJf0Jk4DwkrZXe9VDEIO33diLb0DQ5i94s68+NblgJAxat/SaLf5es65FxCoIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJMpDKfHs+BkIm2twEp6s3n5eTVK1jZnFHlruyqMELx17uAOPa
	tE0f4FrI+tkbi7M7ZGZjtvlMeuq6hublHUa6r1DeLOGYu3/ZWcRUmpmlKdpCRudPBcHdP+UepdG
	uF06oZg==
X-Received: from pgbdm4.prod.google.com ([2002:a05:6a02:d84:b0:c79:39f0:12f2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8c2:b0:848:4c3a:a359
 with SMTP id d2e1a72fcca58-851dfab861bmr893070b3a.19.1787165106725; Wed, 19
 Aug 2026 11:45:06 -0700 (PDT)
Date: Wed, 19 Aug 2026 11:45:05 -0700
In-Reply-To: <4f8428e0784224c55a2026eb32d046a2051193ea.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814224509.2342760-1-seanjc@google.com> <3a622cdb03b553cc9f8ce55b6df3c0091b3b06b9.camel@intel.com>
 <aoT_6cnARCAYTrYG@google.com> <bd8f77eb6605f771fafbcef55a47211ecbb70e19.camel@intel.com>
 <aoXSKH4QLTA5DTXe@google.com> <4f8428e0784224c55a2026eb32d046a2051193ea.camel@intel.com>
Message-ID: <aoX5sbITQYeB7USY@google.com>
Subject: Re: [PATCH] KVM: VMX: Explicitly track TDX VMs' root level instead of
 guessing it from CPUID
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	Kai Huang <kai.huang@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026, Rick P Edgecombe wrote:
> On Wed, 2026-08-19 at 08:56 -0700, Sean Christopherson wrote:
> > FWIW, I don't view keying off gfn_direct_bits as being simpler.=C2=A0 I=
t might be
> > less code, but conceptually it's more complex when reading
> > kvm_mmu_get_tdp_level(). E.g. the comment would need to explain the con=
nection
> > between "direct bits" and the mirror root level, which most non-TDX rea=
ders
> > simply won't care about.
> >=20
> > Hmm, but the comment I provided isn't very good either, as it too bleed=
s in
> > details about the S-bit pivot, and at the end of the day that's not the=
 true
> > reason why the mirror root has/needs a predefined level.=C2=A0 The true=
 reason is
> > very simple: KVM needs to mirror the external page tables, and obviousl=
y that
> > means using the same number of levels.
> >=20
> > 	/*
> > 	 * If the VM has mirror roots, then the root level is predefined as
> > the
> > 	 * mirror root (and by extension the normal root) needs to match the
> > 	 * root level that was configured for the external page tables that
> > are
> > 	 * being mirrored by KVM.
> > 	 */
> > 	if (vcpu->kvm->arch.mirror_root_level)
> > 		return vcpu->kvm->arch.mirror_root_level;
> >=20
> > But IMO that's a moot point, because this isn't a matter of simple vs.
> > complex. Keying of gfn_direct_bits is wrong/flawed, so whether or not i=
t's
> > simpler is irrelevant.
>=20
> I was just thinking that the patch was kind of doing two things with one =
change.

Oh, yeah, it kinda is.  More at the bottom.

> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index c519e8e8d646..c78897510a1e 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -5928,19 +5928,21 @@ void __kvm_mmu_refresh_passthrough_bits(struct
> > kvm_vcpu *vcpu,
> > =C2=A0
> > =C2=A0static inline int kvm_mmu_get_tdp_level(struct kvm_vcpu *vcpu)
> > =C2=A0{
> > -	int maxpa;
> > -
> > -	if (vcpu->kvm->arch.vm_type =3D=3D KVM_X86_TDX_VM)
> > -		maxpa =3D cpuid_query_maxguestphyaddr(vcpu);
> > -	else
> > -		maxpa =3D cpuid_maxphyaddr(vcpu);
> > -
> > =C2=A0	/* tdp_root_level is architecture forced level, use it if nonzer=
o */
> > =C2=A0	if (tdp_root_level)
> > =C2=A0		return tdp_root_level;
> > =C2=A0
> > +	/*
> > +	 * If the VM has mirror roots, then the root level is predefined as
> > the
> > +	 * mirror root (and by extension the normal root) needs to match the
> > +	 * root level that was configured for the external page tables that
> > are
> > +	 * being mirrored by KVM.
> > +	 */
> > +	if (vcpu->kvm->arch.mirror_root_level)
>=20
> Elsewhere we use kvm_has_mirrored_tdp(vcpu->kvm) for these kind of checks=
. Would
> be nice to be consistent and not add any uncertainty of whether
> mirror_root_level can be set without kvm_has_mirrored_tdp() being true.

Hmm, for defense in depth, I want to explicitly check mirror_root_level, be=
cause
returning '0' would likely have dire consequences.  How about this?

	if (kvm_has_mirrored_tdp(vcpu->kvm) &&
	    !WARN_ON_ONCE(!vcpu->kvm->arch.mirror_root_level))
		return vcpu->kvm->arch.mirror_root_level;

> > @@ -2760,6 +2754,14 @@ DEFINE_CLASS(tdx_vm_state_guard, tdx_vm_state_gu=
ard_t,
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_ERR(_T)) tdx_release_vm_state_l=
ocks(_T),
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 tdx_acquire_vm_state_locks(kvm), struct=
 kvm *kvm);
> > =C2=A0
> > +static __always_inline void tdx_set_mirror_root_level(struct kvm *kvm,=
 int
> > level)
> > +{
> > +	BUILD_BUG_ON(level !=3D 4 && level !=3D 5);
> > +
> > +	kvm->arch.mirror_root_level =3D level;
> > +	kvm->arch.gfn_direct_bits =3D gpa_to_gfn(BIT_ULL(level =3D=3D 4 ? 47 =
:
> > 51));
>=20
> No need to remove TDX_SHARED_BIT_PWL_4/5 in this patch either anymore. Si=
nce
> this lives in TDX code.

Killing them off dedups the code, and more importantly makes it all but imp=
ossible
for mirror_root_level and the mirror root level to get out of sync.  E.g. w=
ith this

	if (td_params->config_flags & TDX_CONFIG_FLAGS_MAX_GPAW) {
		kvm->arch.gfn_direct_bits =3D TDX_SHARED_BIT_PWL_5;
		tdx_set_mirror_root_level(kvm, 5);
	} else {
		kvm->arch.gfn_direct_bits =3D TDX_SHARED_BIT_PWL_4;
		tdx_set_mirror_root_level(kvm, 4);
	}

then it's possible we could fat-finger a change and end up with:


	if (td_params->config_flags & TDX_CONFIG_FLAGS_MAX_GPAW) {
		kvm->arch.gfn_direct_bits =3D TDX_SHARED_BIT_PWL_5;
		tdx_set_mirror_root_level(kvm, 4);
	} else {
		kvm->arch.gfn_direct_bits =3D TDX_SHARED_BIT_PWL_4;
		tdx_set_mirror_root_level(kvm, 5);
	}

But, as you note above, that can be a separate patch.
