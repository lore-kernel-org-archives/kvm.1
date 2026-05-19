Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90721A9B58
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152357; cv=none; b=At9NNl6rfNzL36Yo7cNFIdXGBQLrUt16OxsZWpGR5RmlIm7oruoQdQ31eDWVt27rufmNhDi3LDE+ZSyn4DKTMO8QP697MzLbp9WwlHE5ZGlOEvVVJdOOuEMzC6Hi8H/pxPzoy5srO2U11ZTXRjcGyRxeQH40HQU/8T79cBeRRvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152357; c=relaxed/simple;
	bh=rh89P16/oU7KuKChGPAARzVM3d+bN73c15krqTD79Xc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ISNwBQKYFA++g8y0vLIbJcoDGbpMBt3yHlt367YKR8klFKorIzIfSrPPP0UiIFAaM8S/7JvIy9rw/BF7QV01QDZMloCD/431kgqauuWMBCAJ1gYDjshozPGURMuTqzpyD+VdVyj+wFKGeItlO8bHaoFAES02q3MGoEyQG+AvgZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VjuonrPZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VjuonrPZ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso34118975ad.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779152355; x=1779757155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emAEVdJqXaLndzifpgbdJIJE33a6OJ6s+mz3Tmc6oL4=;
        b=VjuonrPZXUFRdbkmJqLXvV3J7eIbRbRzeH0FTxbGLDYe2BBXGkXRUeDEufFxpQkEyl
         LhxX6iO8fzMGNlCU2WCGSx3EXvKc7gvWHNvnR2apVWDh/ZzIjbMGC2GukKL3nB4/NT+K
         sSZ57SpT/23PfGvdo2VHIMoaEwrPsF20PM2owX9rlrqZ332CzMDFiNRjhHIxEslOGutj
         pW1prf1wsc8Jo23jlKOFsYKvln9C8p5ku7Ffyv1H6hqmP75o0FYND7tMZxGiy5pdVEJz
         iSyAJ6mDz8qgIWbhFadd4mAwBH48sy/FVnGNJsx9aGIwp6I9nYfsspO7U0hzfxZ41fJ/
         J1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779152355; x=1779757155;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=emAEVdJqXaLndzifpgbdJIJE33a6OJ6s+mz3Tmc6oL4=;
        b=Ch92hRpt/KbEeLSZxcAu71zs3C3xGmujxnXJec3YpqweuP1+dXej4px8JUupAgKYVa
         c3CEHDEkKp7KAwIo4gMhZOFn4I1LLwKx0VWK5GAqTN1w5YdT8aoUib4mMenC/Kztw/qp
         TpB7pJ8GCCDg1DJumpPFqDJz0mguNeAcI1xR48LAjboGZQ7auv2hyw883poVedDDxaqF
         Pq+GISfBQz7rCkZDm8y4QVNzKhJ+v3cql3RHOUdkcP4PXGkC7MD8vVHRuX6sMOU8YOYd
         jalvTprV2/DYyCPmW8qi/pAdE/+Eh9lcmElKIcr/GlRj9+AwSWK/NBZvV+GS35E3QOBs
         JiEA==
X-Forwarded-Encrypted: i=1; AFNElJ+/smUGHmVWLoLEsiinGp4jU7FRJmPe/iYBoQq9AZzRPqdRdbf3PdUW4pAqJ3/ZxiZkbJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4CHEqtNHKGAxGsE+0UyQ3pnD78kyrht21HoQ3HPCroEC1OGOs
	8xVxu3W0IkoqQwePGHnJ0yNdilW92HSiP4wUIWFFLnWvze16tEvdR9M6gJygdm9xXDX/KaYbZ2Y
	cmGYH7Q==
X-Received: from pfbem25.prod.google.com ([2002:a05:6a00:3759:b0:835:2a09:221c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72aa:b0:3a2:f14a:4287
 with SMTP id adf61e73a8af0-3b22e67d172mr18605845637.6.1779152354942; Mon, 18
 May 2026 17:59:14 -0700 (PDT)
Date: Mon, 18 May 2026 17:59:14 -0700
In-Reply-To: <b81cd916-a93f-4a8e-b534-2df59e61dd5f@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511150648.685374-1-pbonzini@redhat.com> <20260511150648.685374-18-pbonzini@redhat.com>
 <CAO9r8zMeg1ta0hL4panuB3D-10PmkwHL+9XKv_0NVjcpq0oJMg@mail.gmail.com> <b81cd916-a93f-4a8e-b534-2df59e61dd5f@intel.com>
Message-ID: <agu14rrLFYxgH6ls@google.com>
Subject: Re: [PATCH 17/22] KVM: x86/mmu: pull struct kvm_pagewalk out of
 struct kvm_mmu
From: Sean Christopherson <seanjc@google.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, jon@nutanix.com, mtosatti@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026, Kishen Maloor wrote:
> On 5/13/26 2:36 PM, Yosry Ahmed wrote:
> > > @@ -6767,11 +6748,11 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
> > >=20
> > >          vcpu->arch.mmu =3D &vcpu->arch.root_mmu;
> > >=20
> > > -       ret =3D __kvm_mmu_create(vcpu, &vcpu->arch.guest_mmu);
> > > +       ret =3D __kvm_mmu_create(vcpu, &vcpu->arch.guest_mmu, &vcpu->=
arch.tdp_walk);
> > >          if (ret)
> > >                  return ret;
> > >=20
> > > -       ret =3D __kvm_mmu_create(vcpu, &vcpu->arch.root_mmu);
> > > +       ret =3D __kvm_mmu_create(vcpu, &vcpu->arch.root_mmu, &vcpu->a=
rch.cpu_walk);
> > >          if (ret)
> > >                  goto fail_allocate_root;
> >=20
> > I admittedly did not take a close look at the series. Just wanted to
> > chime in about naming. I *love* that we are getting rid of nested_mmu
> > because I can never immediately tell the difference between guest_mmu
> > and nested_mmu, so thank you for that.
> >=20
> > However, I can't immediately tell what vcpu->arch.cpu_walk is doing
> > either (compared to vcpu->arch.tdp_walk), so maybe the names can be
> > improved? If these walks are tied to these MMUs, maybe name them as
> > such (e.g. root_pg_walk and guest_pg_walk)?

They aren't tied to MMUs in that way though.  If L1 is using shadow paging =
for L2,
than the so called "root" MMU is used for both L1 and L2, albeit with a dif=
ferent
role (kvm_mmu_page_role.guest_mode will be different).

> > I also think root_mmu and guest_mmu could still use some improvement
> > but that's probably outside the scope of this series. These are
> > essentially L1 MMU and L2 MMU, right?

Almost, but not quite.  See above.

> > Maybe just mmu and nested_mmu could work?=20

> > But I am not sure if we can reclaim the nested_mmu name, it's gonna scr=
ew
> > with anyone doing backports :/

Heh, could be fun.

> +1, and I wonder if it helps to name the walkers after what they walk, to
> shape one's conceptual model. E.g. cr3_walk (instead of cpu_walk) for the
> walker over CR3-rooted tables of the currently executing guest (L1's or L=
2's
> CR3), and nested_tdp_walk for the walker over L1's nested EPT/NPT when L0
> services L2. tdp_walk alone felt a bit vague =E2=80=94 it read as "the TD=
P MMU's
> walker," whereas this specifically applies to the nested TDP path.

Or maybe legacy_walk instead of cr3_walk?  Purely because of nCR3 with NPT =
:-/

Good xxx_mmu names remain elusive...
