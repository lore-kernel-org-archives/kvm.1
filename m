Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339FD1A9F96
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 00:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784767595; cv=none; b=rLDnRyn6by9BNYTj3gpwIdFgHd3FK30MPVmqzASka4glu593qDG5FQfagFNpMRM99ZStZ1UrXeurgvCN7mJROneWRJrQp9NcuJx1gv6GpernIJm92dLs0ylzvmAyDrOrcjo8i09HAtGFhKd3BjlaqrtPMuibXwWz895Fs+oxy0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784767595; c=relaxed/simple;
	bh=mJhDJ4wuqKOqnygiiCPKcSW2lydIlEwMcX960VTrxGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JXDJe+jVzXJL0qYwCu4isNtKWtYHts92z+DQKdHoSg/Llhn0DvB/zRDWYuhzu+bXKrz4WJVvvBdRYAEc++Wyqvc39msAKahlZAfsya88a9qOl6uLMDIbKI6KaP7pMv5zMqWzIg1PbLel+XPIHxfuZ6K3fvBT+tLPmTWPLm7UmyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QJCfmIJi; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJCfmIJi"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc77a6943eso3902525ad.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 17:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784767592; x=1785372392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iZ0hpTloGG/G9ddHfgB5VGCnW/abthdzeJrDqZKbAcA=;
        b=QJCfmIJiF18kcUH/0+CHO8yQBpCxqOLALOKykFUynKlO0bm6/aAZl8uMGCjw3cUzIM
         GWI3KlyYc4XLeiV7VUmH2yX8fWSykxKakUiH/hth9VdqJ9wnQsKgnfg3SRfK1J6/2XO2
         W/xkforiVjLrgux2v4ILhBTnSmPdO0bptcRvVxONSjfz7wMMMZPsO4ZzO4Qh+3UI/b7J
         N2IZNPO8x/DXQe7QvbLTkOiZDWMbxosgWe8xcoY6oV9P7fNYzPIR4wnOA7XfryrQ+iYR
         DhaUzRCuDeAiFynXvyvCLc6RR8mFeUl/4fC+OpHNZdXoQEkdWYxTcB3WWcZ43Ituhwgy
         1wwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784767592; x=1785372392;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iZ0hpTloGG/G9ddHfgB5VGCnW/abthdzeJrDqZKbAcA=;
        b=ZOcMYdWCcKE5fTTdQ7HDg/w79Y3M8zUR+wibFKLbXmDekiXtC4QVS7iqOHEAC52ZoM
         7R04J7mK+iFuoLYTqvSInAuSAkeYndf6bYoKh/5TKKQa1XSIYnai24UquxzgX8nP5Grd
         cbtURcCHPwlbMRJ15kS+cBjOd3GcSvicJMtCxpPvTdPhJ3iRLJwBsAqIAe44VinR3r7n
         Vj5PNum96WVdoeDurQmQPPc+JBj4sGZnC/oc4vCkYIlGHiNEngl2yg4Jth+wtGYj+smJ
         dScpO0I8Fz2ygb/b+HUmviBtdnNsj7fl8qQmtSoXI3tjDAPeg/kKeLvdAZ3roZ7XVhwN
         emMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrzsV9U0CUkz+mkyhWpIbUUr02o5hcZ3PUi1U80K+kJNplXaBBdMQf0BMKypNM4tUn9YhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvB7V79US32SWnhv4q+FxS4xC1ErzPfkaIgM+dKwKugXfP+vdH
	9S/57a3/i/24hXncdib2bwi5BMYuMCe/yMdXSm231BZoaq1ld/EClRd5uFGkeMx5ODJ6KXZ8fzl
	DAWDMWw==
X-Received: from plbji11.prod.google.com ([2002:a17:903:324b:b0:2cc:b904:3254])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:26c6:b0:2ca:a03a:29b2
 with SMTP id d9443c01a7336-2cfa71b761amr12107325ad.8.1784767592187; Wed, 22
 Jul 2026 17:46:32 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:46:31 -0700
In-Reply-To: <CAO9r8zPSEw0snypASanWEdaaTnqf-ZvzRgZpEc=M+sPjELQbSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-18-yosry@kernel.org> <20260616012056.669B91F000E9@smtp.kernel.org>
 <CAO9r8zPRmcwKAtHch995Gm5EKxv07-3f90+H71g+w=iZ+VZfiQ@mail.gmail.com> <CAO9r8zPSEw0snypASanWEdaaTnqf-ZvzRgZpEc=M+sPjELQbSA@mail.gmail.com>
Message-ID: <amFkZwsaoPvuNWDA@google.com>
Subject: Re: [RFC PATCH v2 17/25] KVM: nSVM: Service local TLB flushes before
 nested transitions
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026, Yosry Ahmed wrote:
> On Tue, Jun 16, 2026 at 11:06=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> w=
rote:
> > > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > > index 234724d8b4c54..7b19191e0e43f 100644
> > > > --- a/arch/x86/kvm/svm/nested.c
> > > > +++ b/arch/x86/kvm/svm/nested.c
> > > > @@ -717,9 +717,16 @@ static void svm_switch_vmcb(struct vcpu_svm *s=
vm, struct kvm_vmcb_info *target_v
> > > >  {
> > > >       struct kvm_vcpu *vcpu =3D &svm->vcpu;
> > > >
> > > > +     /*
> > > > +      * TLB flushes are applied to the VMCB, so apply any pending =
TLB flushes
> > > > +      * on the current VMCB before switching to a new one..
> > > > +      */
> > > > +     kvm_service_local_tlb_flush_requests(vcpu);
> > >
> > > [Severity: High]
> > > Does this clear global TLB flush requests (like KVM_REQ_TLB_FLUSH_GUE=
ST)
> > > while applying them only to the outgoing VMCB?
> > >
> > > If a host-initiated flush occurs (e.g., from page reclaim), the reque=
st
> > > bit will be consumed and applied to the outgoing VMCB, leaving the in=
coming
> > > VMCB to miss the flush and run with a stale TLB.
> >
> > Yeah it is intentional to apply the flushes to the
> > current/old/outgoing context. If there are flushes needed in the new
> > context, they are queued by nested_svm_{entry/exit}_tlb_flush().
> > That's similar to what VMX does.
> >
> > >
> > > Also, is there a context mismatch here during nested VM-Exit?
> > >
> > > In nested_svm_vmexit(), leave_guest_mode(vcpu) is called before
> > > svm_switch_vmcb(svm, &svm->vmcb01).
> > >
> > > Because of this, kvm_service_local_tlb_flush_requests() will see
> > > is_guest_mode(vcpu) as false. If Hyper-V is enabled, this means
> > > kvm_hv_purge_tlb_flush_fifo() will incorrectly target L1's FIFO while=
 the
> > > hardware flushes are actually being applied to L2's vmcb02.
> >
> > Ugh.. yes. This is annoying. kvm_service_local_tlb_flush_requests()
> > needs to be called on both the current/old/outgoing VMCB *and* guest
> > mode. So we'll need to open-code the call in a bunch of places before
> > svm_switch_vmcb() and {enter/leave}_guest_mode(). I really liked
> > putting it in svm_switch_vmcb() together with
> > nested_svm_{entry/exit}_tlb_flush() so that all the TLB flushing logic
> > for nested transitions live in one place and the ordering needs to be
> > handled in one place.
>=20
> Maybe we can just re-order the code to always call svm_switch_vmcb()
> before {enter/leave}_guest_mode(). We already do that on the entry
> side, and seems to be straightforward on the exit side.

As stated earlier, I'd prefer to explicitly do flushing stuff where it fits=
 from
an architectural perspective.

> With that, we can keep kvm_service_local_tlb_flush_requests() and
> nested_svm_{entry/exit}_tlb_flush() inside svm_switch_vmcb(). We can
> add a WARNING to kvm_service_local_tlb_flush_requests() to make sure
> the calls remains in the correct context (i.e. VMCB matches guest
> mode).
