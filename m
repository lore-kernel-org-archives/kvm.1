Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78B64C651C
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773216; cv=none; b=mDZR65eXnFzJ/RGnx+OCGleABMf3wvc91ckqLokv0MtNmc2tZ1hbYAdEPJpqvgnZZwHfSbceYb5Un6Vf3vjEOoh8SwJfiWvP7lM4sRg8TYTMkD3b9skT9z0MnNmFW2KrgYDngaYOjAFu0oIKGqXC1/weH8w6ajZHnVc/yjz0vdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773216; c=relaxed/simple;
	bh=H/AldlVMjk/oQNta6Hs1FIuCqnbxULD8ohl+C5FSSSs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lamRxwLpyQgY0kWc3j8SOgYDPO+wUfjVi0jstI2LxeNo9+FbZUa5jYVJY+VeeVeLOFc62LaXpvkvBQtdePIbZ3ws1soQ0JDoDEiTXvBnrkFZ8ayAQE7fJfZQyPRxMZy40sC6UpQSEl/6rw6FLUZA4NXmlgrsrWjFujufNV0Dko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KSWpbFwv; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSWpbFwv"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2df5a65671eso23223075ad.1
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 06:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790773202; x=1791378002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uxkJXleKpEm3giS9KW70/l1fmv0cN3weadq8nwqYF/s=;
        b=KSWpbFwviLu7L1JN79qOZyKx7mStDbHc0rfVhyZtPCkMVoi8YmbYOpDpcYTwoI8fwm
         QlNMwNluHAjNIrfInjob7rZ713BJxNiww88Avr6muahE3bhFqV2Su8WpZLHDB/DcGFTT
         URimU1wQAUqeY8I4logHISM+LhDuqJn0z+eCNo9jMa/fNWzbj1pma7adIp8UwtGjDHG+
         a33K4g00gCX/Tk866rrM4r8/oS+Nv1Jkr4c3pWJ3HCtLdiOuBH5pvSRofGIsDgeBtKtN
         RC4DOuPZA7YQUipfAgtyWOK/4MyoXdolZcn9s+t/2Xt+XtOrkhTq/Hiwod3o/prXXLTf
         E9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790773202; x=1791378002;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uxkJXleKpEm3giS9KW70/l1fmv0cN3weadq8nwqYF/s=;
        b=H/ei72buhXv/lx8qHKDCriLte5+g7ZbHWsVqercH3gJ3n4mkGwDj/TeyjI2XQqRytq
         sPuPtejKyma8es2vTYxOc4dXoOhvYQTsDgHOetuoJT5heSmn1xo4wRWUIAFd/64XOnAW
         49AMLPfqj9kDBI5tjIljzrN6falTn1vkXAmhT/8HEhOu7dOq+FOT2p+ohUUe8S1E7XFt
         7j5mlanZwQCcCZfV8fgkpZgY1FGNGK7bmjRtXm+gI0Idf/raBFCaKsLnfA65ITJFYdLR
         uYoNOsKJ/UdCBnkOH0RsVTcqSE5lO2wE6ZwTrw9wXSoUMjA1ze+BOYv0u0krP+pzAEYh
         Jabw==
X-Gm-Message-State: AFq9FYKQhF5RfB/OrWbbRBocNIyHix5DBeS9tOMqYDic5INti3mgqG3S
	OqRYPqeeGkBIK3vkWyyldJdkba+HLwGaGsT3v6o1SkwZ3fCJiosr2T98ziX5OP2xDGPsf6pC3Nt
	i6L0O0g==
X-Received: from plmo19.prod.google.com ([2002:a17:903:18d3:b0:2e2:c37a:5ebc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f712:b0:2dd:a937:9bfb
 with SMTP id d9443c01a7336-2e2e4b3213bmr8506045ad.10.1790773201544; Wed, 30
 Sep 2026 06:00:01 -0700 (PDT)
Date: Wed, 30 Sep 2026 05:59:52 -0700
In-Reply-To: <20260930012809.331EB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930011313.3197688-1-seanjc@google.com> <20260930011313.3197688-6-seanjc@google.com>
 <20260930012809.331EB1F000FF@smtp.kernel.org>
Message-ID: <ar0HyDZ_mUqUK5cn@google.com>
Subject: Re: [PATCH v5 05/12] KVM: x86: WARN if fixed-1 DR6 bits aren't
 already set when delivering payload
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] kvm/x86: host DoS via WARN_ON_ONCE in kvm_deliver_exception_payl=
oad
> --
>=20
> commit 55e3dfb3c54d9318de7a4a9b55c84a0a9acf4aa2
> Author: Sean Christopherson <seanjc@google.com>
>=20
> KVM: x86: WARN if fixed-1 DR6 bits aren't already set when delivering pay=
load
>=20
> This commit adds a WARN_ON_ONCE to kvm_deliver_exception_payload() to ass=
ert
> that fixed-1 bits in DR6 are already set when delivering a #DB payload. I=
t
> also switches to using kvm_get_dr6_fixed_1() for the check.
>=20
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 99518e3265b45..5b3918a4ed521 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> [ ... ]
> > @@ -440,8 +442,10 @@ void kvm_deliver_exception_payload(struct kvm_vcpu=
 *vcpu,
> >  		 * breakpoint), it is reserved and must be zero in DR6.
> >  		 */
> >  		vcpu->arch.dr6 &=3D ~BIT(12);
> > -		vcpu->arch.dr6 |=3D DR6_FIXED_1;
> > +		if (WARN_ON_ONCE((vcpu->arch.dr6 & dr6_fixed_1) !=3D dr6_fixed_1))
> > +			vcpu->arch.dr6 |=3D dr6_fixed_1;
>=20
> [Severity: High]
> Can an unprivileged host-userspace process trigger this warning in
> kvm_deliver_exception_payload() in arch/x86/kvm/x86.c by injecting a
> malformed dr6 state?
>=20
> If host-userspace invokes the kvm_vcpu_ioctl_x86_set_debugregs() via the
> KVM_SET_DEBUGREGS ioctl in arch/x86/kvm/regs.c with dbgregs.dr6 =3D 0, it
> clears all fixed-1 bits in vcpu->arch.dr6, since kvm_dr6_valid() only
> validates the upper 32 bits.

Drat.  I had reservations about adding the sanity check even before Sashiko
chimed in, so I'll just drop it.

>=20
> Then, if it invokes kvm_vcpu_ioctl_x86_set_vcpu_events() in
> arch/x86/kvm/x86.c via the KVM_SET_VCPU_EVENTS ioctl to queue a pending
> #DB exception with an unchecked payload and runs the VCPU via KVM_RUN,
> kvm_deliver_exception_payload() will evaluate this newly added
> WARN_ON_ONCE before the fixed-1 bits are restored.
>=20
> On systems with panic_on_warn=3D1, could this result in a host kernel pan=
ic
> and a denial of service?
>=20
> >  		break;
> > +	}
> >  	case PF_VECTOR:
> >  		vcpu->arch.cr2 =3D ex->payload;
> >  		break;
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930011313.31=
97688-1-seanjc@google.com?part=3D5
