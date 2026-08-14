Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C991F45C710
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725879; cv=none; b=SyTVe66h5dCUp/vurmNzJkrZJDJIanKtFKRvWh2gPFmbCYu7lp+DRSpS0hrLxdCgOU82IELVRYVOLeVb0KujEg5NlN7U72/ZmqwobJLVbPomAiJWyjnD+FB+cY5+2Ei0s1c16IG6BuUEhynnQTMOjbfTPP0hTYY3wgFgBOU6PaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725879; c=relaxed/simple;
	bh=SXMUBMpWqjsSZ8UZUax/xd2jiHPkqWpJd/+6vxgoa0s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ejamlj7M5PHuO5NTqdH0eziurH3BzH4MzVWTe7jHfl59JOtTEab68T7sw/SkqB7KtU05o+bHrAvCwtoytaMeebw7/C+NK8lSpVeqD4BgadU8Fu3s0A6bQhg2ka6h9kRGTMm6Fk2lM0AJo5OlzvGs9r6msTYJl3hibq1MaFhbafE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Guon7HHi; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Guon7HHi"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb5cc1e13f8so980472a12.3
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786725877; x=1787330677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OHHH7uTWtnNMDgIrudvSIouxtfc87FvfYM1qiAcx7gY=;
        b=Guon7HHiGBtZqJhU2zoxeptoiX6XU8sOCSxE7I8bjSTDxeS7n4pFMht/gedEt34AM6
         7C1loXpzWTsZquOeZ1+s3SneCWnVXJpeJ5bjVFzoWKyoInK4WekzI4mjquJvV9yzaNdz
         URIK7Y5vtn0Cat3yE/mMQBuf8ieh+rzT5YAr6KY8U5p9Mhh7MWTQWR6fypS8bJyLKcqC
         9ogzH2GzIeJNOMFyv2EFPINVLkg+oHTdeD5FH8P+l51GM7zcdozWvo6Z9VpalKT2zIiE
         N/dxT6P2lZ+DMBtGDhKFd9AqdZfu0rCISuspIDHiMDhc/OEG0neyTz84I9CcTOepotSn
         bQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786725877; x=1787330677;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OHHH7uTWtnNMDgIrudvSIouxtfc87FvfYM1qiAcx7gY=;
        b=hSeJwo74XuTGGmCcylA/t9C1G+HqpbwJRY3fE7v+TbChmVpu40fyPwmCKKYyLV1co0
         nx5YxOtqHEAKFCLjk1D6fI+GoL3L/tgRx4BqsjgqG+juKHjYqRuK1YrkM9n7HJ2My2PR
         BL9GZ99Vjo08N1E7SBPwDgKqPu22fjBHNjijP3phxdF/Iirz6B/nqdxG3T9BZFVirzUI
         0LyU3RQaRaS415NFcbglSXROQwf1FjLeUHBZT1Az5lgpoDcnRTup9sbm2zH7ZIM4vKrj
         nUEGJqEUAVWwp3uk3O2o0bY8NirIjJKMhUbHuPZlZMnNWZCiAosyIFSN7g/FYnAZwiYa
         JJpQ==
X-Forwarded-Encrypted: i=1; AHgh+RqT4PO/pjdmJty8BL8alHGmplzZW44PrTjk6X29d4GrC7S7VDFuvSSRfdkN0WsmAs8JHZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf/mKS56RHPArvzocAkK4z6o7euzisvXv1L5AF99yQ1b3mexno
	jqSMPQk4mUpAmN+fRWN8LoRpk4Hr8IQ6NZ4tXhDs8UEY2fb2yW7NDMdE5oemJVMYls1k8I8tH9e
	WRa8Pvw==
X-Received: from pfbgp14.prod.google.com ([2002:a05:6a00:3b8e:b0:847:8e58:df6f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21c8:b0:847:973b:3cf6
 with SMTP id d2e1a72fcca58-84fddde3c32mr7348818b3a.0.1786725876826; Fri, 14
 Aug 2026 09:44:36 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:44:36 -0700
In-Reply-To: <20260814163207.D8C5D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814162221.2144473-1-vkuznets@redhat.com> <20260814162221.2144473-3-vkuznets@redhat.com>
 <20260814163207.D8C5D1F000E9@smtp.kernel.org>
Message-ID: <an9F9EJj4yLkc8Op@google.com>
Subject: Re: [PATCH 2/4] KVM: nVMX: Make VMPTRST return eVMCS GPA when it is used
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > index c78c67525ac9b..d13a4d47bc68f 100644
> > --- a/arch/x86/kvm/vmx/nested.c
> > +++ b/arch/x86/kvm/vmx/nested.c
> [ ... ]
> > @@ -5958,8 +5958,14 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
> >  	if (!nested_vmx_check_permission(vcpu))
> >  		return 1;
> > =20
> > -	if (unlikely(nested_vmx_is_evmptr12_valid(to_vmx(vcpu))))
> > -		return 1;
> > +	/*
> > +	 * Hyper-V TLFS does not specify the behavior of VMPTRST when eVMCS i=
s used
> > +	 * but genuine Hyper-V seems to be returning eVMCS GPA.
> > +	 */
> > +	if (nested_vmx_is_evmptr12_valid(to_vmx(vcpu)))
> > +		current_vmptr =3D to_vmx(vcpu)->nested.hv_evmcs_vmptr;
>=20
> [Severity: Low]
> Will this cause a build failure when CONFIG_KVM_HYPERV is disabled?
>=20
> Because nested_vmx_is_evmptr12_valid() is a static inline function rather
> than a preprocessor macro, the compiler still evaluates and type-checks
> this branch even when the helper is hardcoded to return false. If the
> hv_evmcs_vmptr member in struct nested_vmx is conditionally compiled base=
d
> on CONFIG_KVM_HYPERV, the compiler will fail to find it here.

Yep.

arch/x86/kvm/vmx/nested.c: In function =E2=80=98handle_vmptrst=E2=80=99:
arch/x86/kvm/vmx/nested.c:5971:53: error: =E2=80=98struct nested_vmx=E2=80=
=99 has no member named =E2=80=98hv_evmcs_vmptr=E2=80=99
 5971 |                 current_vmptr =3D to_vmx(vcpu)->nested.hv_evmcs_vmp=
tr;
      |                                                     ^
