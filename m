Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F70B3E51F1
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253424; cv=none; b=bzhM/62HtJerQj8vUMJXGIYLhaz1QXFwa0SgBZwRvzNGlqzN75XPDqEeUAw1+w5CqUHDT6JyDmXD+DWpzBAc+nY/65JngvhSJtVs0AdEbypOjVpc2GwRw+ElqTCCjvaDcgv4MGbmAVcz1kDW7D3eMbvcHlUvVIrrZPESaUUeraE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253424; c=relaxed/simple;
	bh=Xe7v8zZqnxwIjLSXhsmw16dwan/+Il6Fo7oTzdzlTbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAJsIC+cAvnL27PoMgVsGGRlYiOiJJhqiTkJ/mvmu9fmHoqngTdL2PMssARnq1MeYrsrvQUElF64RrEv0Rkgi/SnmHCsizGdCrA76HMiLYOB+jcc/ILOARHiXubh02BYKa+e53ktAPNjsSCC1+itLvEDDc2tAyRY4ml1Ihq10BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RC544ctX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RC544ctX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E3AC19425
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 18:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773253424;
	bh=Xe7v8zZqnxwIjLSXhsmw16dwan/+Il6Fo7oTzdzlTbg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RC544ctXEdokBDHqlo2a05Bz4rekl5saTM+Xr83lmvnZ1aWwF+bU04/gbP9DLws56
	 wC5vd01usOjCpALkw2PDX8Mgpjy+pMX9oxGsc21yDBzUd0Lc79ab/jhPh0O5p9u9tD
	 7G9Oq6XLThTj16rnZTQCagn+ATwFYDFFIL9sYYPARiII+RyNHNn2d1CbS9dIXn7F/a
	 NmY/9kVYfN+e0dbHlLq2NNeRsQwdDRM2cq0wnVr48Qr7B/xGNanjlSsi+sn0PmHYsz
	 H65WPlaMi0fJGYkd/UC9zgWZTS865wn/MF5t/WYO1zTjlttLs5Dxr5Sb9EINKkpRrx
	 Z60QKQzWRg6DQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9704cd6951so11328266b.3
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 11:23:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVpN86riv/QkD0TflFEA/mRftY+Xy9OWAxEEj77ATaNVw1KL4HypRE8+LrGO83+y3KJVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5s8yasx2lxm8RylUMHaL+0GJvNvdQx0SMl+iWXrIKAssJwCq5
	+XpEgEVAPbIPtP3KpgqKMkJphYVD/auWS1istJMBivzjRIRO8OiJ5MpqYXFCKYGfuqv0TNqdO0F
	/ugPiEhbdME3oDnVOT2THiK4OwPqJ6io=
X-Received: by 2002:a17:906:f5a8:b0:b93:c5a9:a5ec with SMTP id
 a640c23a62f3a-b972e26b5eamr209957266b.3.1773253422815; Wed, 11 Mar 2026
 11:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310224546.2582118-1-seanjc@google.com> <20260310224546.2582118-3-seanjc@google.com>
 <CAO9r8zMTEi++JvAfKbMd2676Z8cTPQKcWA+mydzXGYPenUrG6g@mail.gmail.com> <abFtshMZLoLLbbXO@google.com>
In-Reply-To: <abFtshMZLoLLbbXO@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 11 Mar 2026 11:23:29 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOJoc6R9WnYqKxFhssk5d7+TFt+6WGok1Nof=-DJK8pcw@mail.gmail.com>
X-Gm-Features: AaiRm5093F_8x8SnnfNjuA0hBTOKQ92FLl8ADKHC3f_dPNuKTsjsRDC33bKUH4s
Message-ID: <CAO9r8zOJoc6R9WnYqKxFhssk5d7+TFt+6WGok1Nof=-DJK8pcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: x86: Suppress WARNs on nested_run_pending after
 userspace exit
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 6:27=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Mar 10, 2026, Yosry Ahmed wrote:
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 879cdeb6adde..cad16c83dcff 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -12090,6 +12090,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu =
*vcpu)
> > >         if (r <=3D 0)
> > >                 goto out;
> > >
> > > +       /*
> > > +        * If userspace may have modified vCPU state, mark nested_run=
_pending
> > > +        * as "untrusted" to avoid triggering false-positive WARNs.
> > > +        */
> > > +       if (vcpu->arch.nested_run_pending =3D=3D KVM_NESTED_RUN_PENDI=
NG)
> > > +               vcpu->arch.nested_run_pending =3D KVM_NESTED_RUN_PEND=
ING_UNTRUSTED;
> > > +
> >
> > Why not inside kvm_x86_vcpu_pre_run()?
>
> That, is a very good question.  /facepalm

After moving it to kvm_x86_vcpu_pre_run(), feel free to add:

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
