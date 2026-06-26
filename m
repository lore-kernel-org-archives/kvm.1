Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646763F871B
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484076; cv=none; b=SDM8kQe/iqnS9O+VnAdj9/6fLiYopDVSJZiXts/jIaGGN7LhqPJCs1g/znwGLQg+Y7psdLz0syW8Xa+ac3KBbouc8gc53rVTXfgg0x7dSz7R/4HsEF7qrjUBdNgcdDAk3mKHIBDY5fbbYOnjf4On+TO0XjpVB3ZRUoGAxBXtMNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484076; c=relaxed/simple;
	bh=j74mLa4an6FUKWcGbPm5zIuMfCmCm8jiEpyP9u+oRMU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nTDhAhwMF20rjp7RjWEcmDSi8n6ACgTUQxUZR7Ows22xyWX9y49WTQ36wgjdmBIpwxkYGoO+szK0qCrIio4xj/rO9VtcRqU4LJ/Tt6mC1Hd95aBbJ5FjHV33CfBGC+7sb3QI8uXXdYZTaRJTR+K0f6E8nk+6Q7hKHJf9WZyRwu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lgco9qfK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lgco9qfK"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c8018f11fbso9967115ad.3
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782484068; x=1783088868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCJJmjJsx9ZpoPuR0fj0nKjX7eTBmSdWBoum/bdsThU=;
        b=lgco9qfKmV6qETXpFHw3OUczF/0PHsaUKQdqAgpAW618cM8+oFlas1jr9HZiMlzTm0
         nts1PFIFfdjKfHYu9+BgLtLp9+HxGmkGemrM6iTUDoEPnHBu49RJev3y1q+ASXtb2ArZ
         dVWqADCrah1QgiiyxNSZ/bRVG0p8NHR68m1mbdoRcKgxfOJ+sYLu/kNBxt4QML+ynHrW
         WEnZetWy0d1cNba2nYlGg2MWfTg1NZLPi9PYsgM7nql6s30ZkLVA/nDHJUxCGF+WhHaG
         1yuz6vj4KXM/dR/zO4wbpYXVV8alcF3cWbNr52DS/N8Lo6K/PcCOlpf4ypJXA6yP4NRk
         sP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782484068; x=1783088868;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cCJJmjJsx9ZpoPuR0fj0nKjX7eTBmSdWBoum/bdsThU=;
        b=LulLFjvz+//LqSA+Il8eSon8wdznv1FnzkRM9pHoFR0FlE8uzB9Mpu/v9VZLKnrMWR
         wtw3gt6WtTkJzHiEv23SwpJQlluU3wGWhG+q24hNfpYpiocABtm5ydVk5d1sXtVEP1pd
         /U2fRZA5v7ZtIl1uSGpekzGM1eORjcmjk2KggFA+qJ3yR0/ipsp38IF8wDinxnTCROiv
         sV03YV/TzZA9pFX1CQCYisGgP71yCOLASwetnQXxnNBtcffCSQH5OlQyQ0glzAWjYuMs
         ec6UmJ8mdNDCVnByEXZyIr7aeWlSWDn1JmIGL9hJLu+4fr7FI9Ak7gT/RxBXatfOigWX
         e8hw==
X-Forwarded-Encrypted: i=1; AHgh+RqYxP1e30boAp6kkSNn6Qy4JBM60fuOYhKaLP3Rmw6t4wq1pU7SDNFdx8ZbQ50VccuC0h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUUlpKzHFlq+i5HqCwwsqA9u4RhFso2Ew6J+JwfDBd9KiGvYMn
	JlcLIoKihDzgKPYBpzZCiz9gq/QgPt/w9J9N5SFypxd8XFpVrqQsww/Lce4jgveKaxLHGYC4Qem
	m5Z0JvA==
X-Received: from plqt1.prod.google.com ([2002:a17:902:a5c1:b0:2c0:a677:42a6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3b88:b0:2c1:ea95:8297
 with SMTP id d9443c01a7336-2c7fc75a973mr71403235ad.7.1782484067938; Fri, 26
 Jun 2026 07:27:47 -0700 (PDT)
Date: Fri, 26 Jun 2026 07:27:47 -0700
In-Reply-To: <123bd3932db959a9c26b9ede46632e482dbdc4ab.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625223623.3376478-1-seanjc@google.com> <20260625223623.3376478-5-seanjc@google.com>
 <123bd3932db959a9c26b9ede46632e482dbdc4ab.camel@infradead.org>
Message-ID: <aj6MY_9wx_uaDvHN@google.com>
Subject: Re: [PATCH v3 04/10] KVM: x86/xen: Punt singleshot timer hcalls to
 userspace if Xen vCPU ID isn't set
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026, David Woodhouse wrote:
> On Thu, 2026-06-25 at 15:36 -0700, Sean Christopherson wrote:
> > Explicitly invalidate KVM's internal Xen vCPU ID during vCPU creation
> > instead of *trying* to set the Xen ID to the vCPU index by default, and
> > forward singleshot timer hypercalls to userspace if the VMM hasn't set =
the
> > Xen ID via KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID.=C2=A0 Using the vCPU's index=
 as its
> > default Xen ID is reasonable in concept, but in practice is horribly fl=
awed
> > as the index is left as '0' until after vCPU initialization completes, =
i.e.
> > every vCPU gets a Xen ID of '0' by default.
> >=20
> > Forward hypercalls to userspace instead of trying to salvage any kind o=
f
> > default behavior, as all userspace implementations that support multipl=
e
> > vCPUs either don't enable the timer, are guaranteed to set Xen ID, or w=
ork
> > only because *all* guests also screw up the singleshot timer hypercalls=
.
> > The last scenarios is extremely unlikely given that Linux-as-a-guest us=
es
> > the actual Xen vCPU ID when making timer hypercalls.=C2=A0 In other wor=
ds, for
> > all intents and purposes, KVM's ABI is already that userspace must set =
the
> > Xen vCPU ID, so just commit to that ABI.
> >=20
> > Note, KVM's handling of KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID restricts the ID=
 to
> > KVM_MAX_VCPUS, so there's no chance of a valid ID colliding with -1u.
>=20
> Nit: XEN_VCPU_ID_INVALID isn't -1u; it's U32_MAX.
>=20
> I'd have been slightly happier if you'd used an explicit -1U, perhaps
> with a name of its own (although I guess we wouldn't want to call it
> KVM_VCPU_IDX_INVALID in the *Xen* part).

Ya, I was 50/50 on having KVM define its own INVALID macro versus reusing w=
hat
the Xen-the-guest has.  I didn't want to open code the literal, because tha=
t
would require open coding a somewhat magical value in multiple locations.  =
And
having XEN_VCPU_ID_INVALID and KVM_XEN_VCPU_ID_INVALID, with the same value=
,
seemed even worse than reusing a macro that isn't strictly owned by KVM.

What if I also add a compile-timer assertion?  In the end, KVM doesn't care=
 what
value XEN_VCPU_ID_INVALID uses, so long as it can't colled with what is all=
owed
by KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID.

diff --git arch/x86/kvm/xen.c arch/x86/kvm/xen.c
index 3ed6686e0a1a..5c60ed9ef2cc 100644
--- arch/x86/kvm/xen.c
+++ arch/x86/kvm/xen.c
@@ -1103,6 +1103,8 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, stru=
ct kvm_xen_vcpu_attr *data)
                break;
=20
        case KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID:
+               BUILD_BUG_ON(XEN_VCPU_ID_INVALID < KVM_MAX_VCPUS);
+
                if (data->u.vcpu_id >=3D KVM_MAX_VCPUS)
                        r =3D -EINVAL;
                else {
