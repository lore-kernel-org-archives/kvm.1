Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126EE31195C
	for <kvm@vger.kernel.org>; Sat,  6 Jun 2026 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780739437; cv=none; b=us0AiM9kzv6BAyzpkDwmmiHj3P0tzLVt54cYOmLwYHx6mqxirzJUC5xsOC0zW+7pR4ZmkwzC8n9QBBFFXrpKh3lsizeONX3LLwr4DHkMzJM9fYUbu0PmZp2lapnoHGQJTNkUeD4o6D2jsQIcyNSUybckZD441xmKFSAwFj8Vw0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780739437; c=relaxed/simple;
	bh=U5x9DUBcvfPlFMOS3st1TCgH4rBXUlgVCsGuHTLzRss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOoBGVpg9SyMy3da4l0gNTEf17eZlCYb1HoVy7v4zTjSMX8848ggH/XkF3C/von4pzaiW4PBLxJpQ5H0znpxgPrQuGfR7f3ZCqOfuaJi5sMWLYyOG8KEMQFjeF2W4Jxqy3AvKlb+fv/4ZDa/w+rsHS3xzkfTh2gprckX2oJljKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITKAek0m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITKAek0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DE51F00899
	for <kvm@vger.kernel.org>; Sat,  6 Jun 2026 09:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780739435;
	bh=dIQrknRsjBAHl4aEgXEyi6Oms2qM48T6fb0nQzKRdl4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ITKAek0mWYMmFelauybftDFeMORQCcsFQWt4TgN5Pb2jEz5/f3hVkab/uoPl+yJzH
	 +Q8toWb4Y9/h+IIcAgcQDvlykLmM7iq9zJ2Lmdr71I9ZTI4cjAjubOfoHC/himVVXL
	 yCPTt8rOT833kqyenrig6rp6fdixKH/dsmYTTn/E4xgH2Nh0KxNHtgzymfFVUobX8A
	 mrXH24pKc36o1MVQrqPQI1FWQjJMzqczE5qSjhMW4UQqYyBKROyJ9+5YkfwNOQS0kl
	 9KbTZj7YrUlW8pelEy+RVmeJ6XsjcxmjZVUeklF2cJzDDiK+kv84qAIDXldlsvqZ/U
	 XweGjIDvL4ijA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-beb44f97561so340437766b.0
        for <kvm@vger.kernel.org>; Sat, 06 Jun 2026 02:50:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+NqTnDUpJhb0Pb7JTUKLea+N7M0rnFuRl2pj+9rBm6+c8j2wrqPyNHjopk6j61P2iBDuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8sROvV8Oe/gBe60NAUlIKKoBCv4XLt/Tm5XygTYxPAQ5/m0lu
	D0GyVwrVi0ozUnQlQ3an/D+CfEtocCSG63WtAOn8P+A2NsnSSIM63kYNogBUOnWamhQuH2QIFnS
	Z88Vwc3MKMHyw46bSKpxhgB5df/flVRM=
X-Received: by 2002:a17:907:6d24:b0:bd4:f3e5:b0f6 with SMTP id
 a640c23a62f3a-bf37234be28mr389444366b.28.1780739434444; Sat, 06 Jun 2026
 02:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602074316.1647373-1-maobibo@loongson.cn> <20260602074316.1647373-5-maobibo@loongson.cn>
 <9ea14f0d-eb89-bff0-17b0-023da342cfe4@loongson.cn>
In-Reply-To: <9ea14f0d-eb89-bff0-17b0-023da342cfe4@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 6 Jun 2026 17:50:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7WyyK5OMwTnOHGdYk8BPS6gUap=-4Vg-eUHTnUSLV=fg@mail.gmail.com>
X-Gm-Features: AVVi8Ce8l9om2b7h99ChItsdbowLiNVnLeIIe-TlLPcrRBBkurXM0xFQeMMQTMs
Message-ID: <CAAhV-H7WyyK5OMwTnOHGdYk8BPS6gUap=-4Vg-eUHTnUSLV=fg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] LoongArch: KVM: Remove KVM_LARCH_LASX and KVM_LARCH_LSX
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Tue, Jun 2, 2026 at 4:55=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2026/6/2 =E4=B8=8B=E5=8D=883:43, Bibo Mao wrote:
> > In kvm_lose_fpu() FPU state will save in vcpu::arch::fpu, its FPU
> > state comes from vcpu->arch.aux_inuse. Instead existing API
> > vm_guest_has_xxx() can be used also, and bit KVM_LARCH_LASX and
> > KVM_LARCH_LSX in arch.aux_inuse are removed. It makes the logic
> > simpler than ever.
> >
> > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/kvm_host.h |  2 --
> >   arch/loongarch/kvm/vcpu.c             | 17 +++++++++--------
> >   2 files changed, 9 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/inc=
lude/asm/kvm_host.h
> > index bad16c5f963c..aa2000cfb58a 100644
> > --- a/arch/loongarch/include/asm/kvm_host.h
> > +++ b/arch/loongarch/include/asm/kvm_host.h
> > @@ -158,8 +158,6 @@ enum emulation_result {
> >   };
> >
> >   #define KVM_LARCH_FPU               (0x1 << 0)
> > -#define KVM_LARCH_LSX                (0x1 << 1)
> > -#define KVM_LARCH_LASX               (0x1 << 2)
> >   #define KVM_LARCH_LBT               (0x1 << 3)
> >   #define KVM_LARCH_PMU               (0x1 << 4)
> >   #define KVM_LARCH_SWCSR_LATEST      (0x1 << 5)
> > diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> > index 53abf7aa61f8..523d4cf88343 100644
> > --- a/arch/loongarch/kvm/vcpu.c
> > +++ b/arch/loongarch/kvm/vcpu.c
> > @@ -1392,7 +1392,7 @@ int kvm_own_lsx(struct kvm_vcpu *vcpu)
> >       kvm_restore_lsx(&vcpu->arch.fpu);
> >
> >       trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_LSX);
> > -     vcpu->arch.aux_inuse |=3D KVM_LARCH_LSX | KVM_LARCH_FPU;
> > +     vcpu->arch.aux_inuse |=3D KVM_LARCH_FPU;
> >
> >       return 0;
> >   }
> > @@ -1408,7 +1408,7 @@ int kvm_own_lasx(struct kvm_vcpu *vcpu)
> >       kvm_restore_lasx(&vcpu->arch.fpu);
> >
> >       trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_LASX);
> > -     vcpu->arch.aux_inuse |=3D KVM_LARCH_LASX | KVM_LARCH_LSX | KVM_LA=
RCH_FPU;
> > +     vcpu->arch.aux_inuse |=3D KVM_LARCH_FPU;
> >
> >       return 0;
> >   }
> > @@ -1417,31 +1417,32 @@ int kvm_own_lasx(struct kvm_vcpu *vcpu)
> >   /* Save context and disable FPU */
> >   void kvm_lose_fpu(struct kvm_vcpu *vcpu)
> >   {
> > +     if (!(vcpu->arch.aux_inuse & KVM_LARCH_FPU))
> > +             return;
> here is problem with AI review
>
> https://sashiko.dev/#/patchset/20260602074316.1647373-1-maobibo@loongson.=
cn?part=3D4
>
> kvm_lose_fpu() implies that kvm_lose_lbt(), there is problem returning
> directly without calling kvm_lose_lbt().
So we need V4? Maybe we can move the if condition after
preempt_disable() and then goto the callsite of kvm_lose_lbt().


Huacai

>
> Regards
> Bibo Mao
> > +
> >       preempt_disable();
> >
> >       kvm_check_fcsr_alive(vcpu);
> > -     if (vcpu->arch.aux_inuse & KVM_LARCH_LASX) {
> > +     if (kvm_guest_has_lasx(&vcpu->arch)) {
> >               kvm_save_lasx(&vcpu->arch.fpu);
> > -             vcpu->arch.aux_inuse &=3D ~(KVM_LARCH_LSX | KVM_LARCH_FPU=
 | KVM_LARCH_LASX);
> >               trace_kvm_aux(vcpu, KVM_TRACE_AUX_SAVE, KVM_TRACE_AUX_LAS=
X);
> >
> >               /* Disable LASX & LSX & FPU */
> >               clear_csr_euen(CSR_EUEN_FPEN | CSR_EUEN_LSXEN | CSR_EUEN_=
LASXEN);
> > -     } else if (vcpu->arch.aux_inuse & KVM_LARCH_LSX) {
> > +     } else if (kvm_guest_has_lsx(&vcpu->arch)) {
> >               kvm_save_lsx(&vcpu->arch.fpu);
> > -             vcpu->arch.aux_inuse &=3D ~(KVM_LARCH_LSX | KVM_LARCH_FPU=
);
> >               trace_kvm_aux(vcpu, KVM_TRACE_AUX_SAVE, KVM_TRACE_AUX_LSX=
);
> >
> >               /* Disable LSX & FPU */
> >               clear_csr_euen(CSR_EUEN_FPEN | CSR_EUEN_LSXEN);
> > -     } else if (vcpu->arch.aux_inuse & KVM_LARCH_FPU) {
> > +     } else {
> >               kvm_save_fpu(&vcpu->arch.fpu);
> > -             vcpu->arch.aux_inuse &=3D ~KVM_LARCH_FPU;
> >               trace_kvm_aux(vcpu, KVM_TRACE_AUX_SAVE, KVM_TRACE_AUX_FPU=
);
> >
> >               /* Disable FPU */
> >               clear_csr_euen(CSR_EUEN_FPEN);
> >       }
> > +     vcpu->arch.aux_inuse &=3D ~KVM_LARCH_FPU;
> >       kvm_lose_lbt(vcpu);
> >
> >       preempt_enable();
> >
>
>
