Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5B33F6C3B
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532732; cv=none; b=JfWxb26AD0p02HtiFYFs1CAPvEx80pCeKlZAvgKw08OyMZBQ93JMGxLZYCpTRoW2RKqmKbQU7ZFYZr5Mr+bOlHb+C2yDsVSDiUIJh2dkJaETm5WZLLISGHZOeDoTmbyI/lmAktgJHRSizpI/VvD7eynSrti/vDyA8QkRxGq9nuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532732; c=relaxed/simple;
	bh=bVKKlqMoMZT7ZIqI/tShpktD7NbvFFwWIAcipGBu0As=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hiqscf9PcqXLlJ1e8up2DWfvjQQLCp8Lu1WEJ6GAJPi3IXAw2WI/2xQpzSFSTvX1Bo+qxHmscP1Q9h4XrTDkKGa9wpevbd6xN+TdBbAlPwwUdEw5ugXpa3dBmf8rrexGxyE83PFkPGeyX9ZkYv+R6buw4BVBsS6j55tvda0muUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0f9WJma; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0f9WJma"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c2d65d9792so21819925ad.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 07:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781532731; x=1782137531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sf6ZRxRXE3E/hdonYM+tz1sS9z/iGh2J0kw14Af6L3c=;
        b=Z0f9WJmaBiL9jhwT+OxZD1WC4TE0X8AvP5geaFlve3J9qmVpE0a9aW5DrBHqOqmoxk
         ScekhUXmwQjwHSGlj9dfoKKjZeXotjnD8k0osnfgsq0g7fOyyTzXYubZawSx5jfgE2V3
         DeKkvucg9CxVE80j1cwcVH6vKBn1wzhjthG+YaDkBsPZ4PZo6QGxGlioegZgaiqCKifR
         a1SVQ7o1UIonaVgRlfJ4DkrcVMlYoH60CgD25FIDlT9h/2lsKFPPJXOj56SubhWWZDcH
         xBCrVf7nWAPNqvVVREc5aJ1hEEqUZT6QzAB7vMzyfzKKIBoj9O7Jw1poU3oOE+O1L294
         tAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781532731; x=1782137531;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sf6ZRxRXE3E/hdonYM+tz1sS9z/iGh2J0kw14Af6L3c=;
        b=UgeflsF6OOx2YzAizsuFLA5ud586IhnB72xfE3AUg9pEiOYbpEqx5Nv0iJGV/mZnHg
         0eSLBiRgtp2uU7W17NSELW2TPSMVhcHxb7QhUTBJ+hnp5mg181NyWqTsIN/VgU+Ti5Qt
         6JLrL+82iJHI0wW+5oRXGeDGVhh9ont1I/qpxxmRYONDbARsgp20bQEio1Vk9Z1HBpQ6
         TondJcX0jueT5m2jyQRPwifHO8UnW/MEjfRQKiroCm2PQZfViN+XjtJEsgTOYNMh0a6T
         IOW1abwRPXCLkSdX2DpSU97pjAKTHj1Ulqge634aKRuv9knKOR0+lGeUgBd8Bhxd4vhz
         JUhA==
X-Forwarded-Encrypted: i=1; AFNElJ/KxEk/RYYUowv2RQWmvf7Lmdy4TJjp4LbKZdavmU6Ht/UJpDmXYf+345t2HNJ2iFQfCio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0bk1IQUJNUeaEyWE8rj9+Gcy4GM/HBarbgDQeZwhZEg72V1nP
	VUJ/1GEWNGOJkNdy3tFpMQeZVLiFN8ywov7neMhloihS/mDHjyuPDekjJtykTI2CI036hnP9Hj8
	QAVBaFQ==
X-Received: from plbli14.prod.google.com ([2002:a17:903:294e:b0:2c0:a7f8:c132])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4587:b0:2c2:8659:da3a
 with SMTP id d9443c01a7336-2c4132039cbmr162587015ad.31.1781532730565; Mon, 15
 Jun 2026 07:12:10 -0700 (PDT)
Date: Mon, 15 Jun 2026 07:12:09 -0700
In-Reply-To: <a8eefe40b2b0a0a3d4afd675ed4fea6762934fdc.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230622.687665-5-seanjc@google.com> <20260612233017.1F9771F000E9@smtp.kernel.org>
 <aiyY8twOOlRKgQre@google.com> <a8eefe40b2b0a0a3d4afd675ed4fea6762934fdc.camel@infradead.org>
Message-ID: <ajAIOVLzf6AriO5r@google.com>
Subject: Re: [PATCH v2 4/8] KVM: Initialize a vCPU's index to '-1' while it's
 being created
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, 
	Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026, David Woodhouse wrote:
> On Fri, 2026-06-12 at 16:40 -0700, Sean Christopherson wrote:
> > >=20
> > > arch/x86/kvm/xen.c:kvm_xen_init_vcpu() {
> > > =C2=A0=C2=A0=C2=A0 ...
> > > =C2=A0=C2=A0=C2=A0 vcpu->arch.xen.vcpu_id =3D vcpu->vcpu_idx;
> >=20
> > I don't see how the existing code can be correct.=C2=A0 David/Paul, is =
this supposed
> > to be vcpu->vcpu_id?
>=20
> No, vcpu->vcpu_id is the APIC ID.=20
>=20
> But xen.vcpu_id is the Xen/ACPI ID. The kernel needs to know it in
> order to accelerate timer hypercalls. The vcpu->vcpu_idx is a
> reasonable default for that.

Right, but isn't vcpu_id also a reasonable default?  Ugh, never mind.  Even=
 if
it's conceptually a reasonable default, in practice using vcpu_id would lea=
d to
creating an illegal xen.vcpu_id since KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID restri=
cts
the ID to KVM_MAX_VCPUS, not KVM_MAX_VCPU_IDS (which is KVM_MAX_VCPUS * 4).

	case KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID:
		if (data->u.vcpu_id >=3D KVM_MAX_VCPUS)
			r =3D -EINVAL;
		else {
			vcpu->arch.xen.vcpu_id =3D data->u.vcpu_id;
			r =3D 0;
		}
		break;

> (As if this wasn't confusing enough, note ACPI !=3D APIC and neither of
> those are typos)
>=20
> > > =C2=A0=C2=A0=C2=A0 ...
> > > }
> > >=20
> > > Since the actual vcpu_idx isn't assigned until later in
> > > kvm_vm_ioctl_create_vcpu(), this leaves vcpu->arch.xen.vcpu_id as -1 =
instead
> > > of its previous default of 0.
> > >=20
> > > Could this cause guest hypercalls, such as VCPUOP_set_singleshot_time=
r,
> > > to fail with -EINVAL if a VMM relies on the previous default of 0 for=
 vCPU 0
> > > and doesn't explicitly invoke KVM_XEN_VCPU_SET_ATTR?
>=20
> Yeah, but it would be tolerable to just return !handled for the -1 case
> instead of "I handled that and it got -EINVAL". Then the hypercall gets
> punted to userspace.

Are you thinking this?

diff --git arch/x86/kvm/xen.c arch/x86/kvm/xen.c
index 694b31c1fcc9..7a94b84f6492 100644
--- arch/x86/kvm/xen.c
+++ arch/x86/kvm/xen.c
@@ -1607,7 +1607,7 @@ static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vc=
pu, bool longmode, int cmd,
        struct vcpu_set_singleshot_timer oneshot;
        struct x86_exception e;
=20
-       if (!kvm_xen_timer_enabled(vcpu))
+       if (!kvm_xen_timer_enabled(vcpu) || vcpu->arch.xen.vcpu_id < 0)
                return false;
=20
        switch (cmd) {

> I'd slightly prefer a deferred initialization, but I believe all known
> userspace explicitly *sets* the ID via KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID

Yeah, userspace pretty much has to, otherwise only vCPU0 could do
VCPUOP_set_singleshot_timer.  If we were implementing this for the first ti=
me,
I would be 100% in favor of deferred initialization, but since this will be=
 an
ABI change, explicitly initializing xen.vcpu_id to -1 feels "safer", becaus=
e at
least then there will be a fairly noisy failure (exit to userspace), versus=
 the
guest silently getting different behavior.

