Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793197560;
	b=BeBjGItdmOqr9qn0UApaV7yvlmxl6j6Eu+fElkX/Mk3vO9e+zOaNyWrEznvFy8IYRfdm
	 JmJDRVbK97n2ghbcXJMnDbUK5b6XAruIrEGY7UH3I44EPI2wpUkta+Uet8ToSvJd03AqT
	 2arr34p+m/KtOOx4r9HGLtBAF9WabigSkwK5zHNemtuHsneAbAZGTrMEZ80lwM9mxoSXv
	 8Anc5m1xnMulXEtOPZCQkPnPTJKO3HusyvDwk98iiPvtu6LNnByBHgBH8k81yDiQsSWmT
	 yAtUGn3l48T0I0HxIqnoFcWNTC5xwv4drY4mcuoioHTf68pzAGkB2dpJAGkXpMgc+8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sVJnEkkaWyS3Mhu2w9u2jCkAacOtPK3HyLqTOhRVQ6A=;
	b=CsNGpimVieeVRkrOWZj4jUjFiLU1sAG/LptX6medJ0rcfT7G8pIqFZkVY3lDxvyv8+xz
	 m7GpCLds5rSRE2fl4bG7oxdwy0XBns1EzWXNXVoIl8u3LqgmFBMhq/5McKZQMDb/CgK8H
	 Q49VC+civgX/EygmGU4XjbC2Nw5SchQHD56bUSTjgW31u/bEcchvbxFCYJpxnoxxA67dG
	 RGFQOws1W3Yoekn2HE3IJg1yReU4j1QDNm8INd086VJbeWfuD45bysPrZn7LrpmSg8QXD
	 uiS9hHPKetWVkITfY7GUINDpRIGXfe76gM/qwrcfhNB+I7OnkgQrx7NWCzjSptbT47g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=brD7IDE9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C0606A31C
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 14:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 823C0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=brD7IDE9
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5337c7b9937so361081cf.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 07:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793197558; cv=none;
        d=google.com; s=arc-20260327;
        b=mJIwpDbICXuUM/8IYZZbz8P2mFxi9M2YWwo/4FXF4PM/Z5VG5s0RIzTgINyulpvyxY
         7jocWkwfN1cjaZZV1C/U5PVReHogs4y4bpMcrgV/zB87Ol/e9pJlgQnoFIbw1945dzVd
         +gyJzcGiD29Nu1w8jmuG9Qgn1FH4t4obYEreIQj14/PIBpexGN+3rE0YFWtrS2mySlaz
         lD/qJryJTkDj8l2zi8ooD6cSiexgxP3vHXNmMhWSuM10mvW6tSu54fFLLPc8AslQn2Xr
         viXc3SqUF9owFIX06fCy6AKWWPC3vcDIt0oy1jZqIIaTHpw3PJ0DmDFepVWdQYhNL22Q
         mLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sVJnEkkaWyS3Mhu2w9u2jCkAacOtPK3HyLqTOhRVQ6A=;
        fh=p0KZFyZmKukuQgcgRq3tMSQQyLPBZvxqpQZfdRhv0x0=;
        b=Y3GiU/pezwdfd7eqYoEeEZNvyEKbogv0NriTzarQrKqBPYsv+GWluo0UOj9Q7TE3yD
         9pRT+brj0lOYa6tNvR5DDABUkm9frxwRXPOZBSwNHuMtyeHW/3FDapN+UcClx5n6SxKf
         3SLMnunypHIc3V9vWF2DwRUz7dLOveQEUvnCbU2ETs401na5AvfZwusolC6j0//pz2QL
         RMu97eJ/zNJagSBe8j7r0M/QPYXDlya4/nynYSIoFIw9SxvZXTqgrdb8BHo4Y6vOPp/C
         Lsztq/oJBoUy4jEvll1x2Nf2FIdOYTuylfI7EKQLJGT1kBrRFV7rqTtXyt384FHWJM4Y
         kjyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793197558; x=1793802358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sVJnEkkaWyS3Mhu2w9u2jCkAacOtPK3HyLqTOhRVQ6A=;
        b=brD7IDE947T6D/aBrnEkNLot/JQlZs1GDnEQ7U3EJeTPft6utw7s83SMHXvYfrsBQZ
         rveD2dexzb2bgX/rWhFpFI1P5WcMQeHB/7VYsKX4v3PKVWxntAodR01hVDiVjtb3FaMB
         1IBFQqddxh2XsiAnmEvq442JYGPuZKxITaWXwcpfEOdqW+j/AvtWFl1cPCfYac4wP9Lo
         8TchXfRV76Y+TKxwfE4ZfewLzsv9uf9nWhhyNxgm7Kfy6LzdWjUfWrbgjH4YF4cmWMjC
         QtoyDn7yHZoljGbzUc+jFJCKWtUts86AZF3HWGbDMcLBAqlYnyOuGhjHb7UN4KpnmX0Y
         WkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197558; x=1793802358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sVJnEkkaWyS3Mhu2w9u2jCkAacOtPK3HyLqTOhRVQ6A=;
        b=tfp0NogQOPUXKPwOlQtUFEPTT818xRwfNtG1+LZv/pWieujDIG9C/Z83/S/LPJIf3l
         3K5KWE88dZS5h1bAHBeThkj7sH4L9CQxFNemq5t9tW2USw8rv5t0IMLsIIOQKE8+fb4j
         y8FeAX6+EYNFx2nXLOTd0+aNkE5p4grnqN2w/CJLS12YKigepSYgoLutsTJQ6mHKoTuj
         OJS9mDkE9L4owIEeDTQumUipZaninyJq65+Iq30eOiSCaLJVC4Wj9BFIN8WG5ieC+wPh
         b+K/6Yc9vqZG5wtb7UWR5JmtYRRT+JqimLmvIagEQZC5zB7Ip+jEQc/ANHB7J/z3mg3u
         vF1g==
X-Forwarded-Encrypted: i=1; AKwUvBwvlhpXX66MBE8g7xmxnD4gJoJUpZo6owuysBsVgl18xYLzcASTq04m2SN7IgACRjDNc4E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkL8sqXQVrvVwyZBVCwxUQRri1lG42kxobWKNrnU2e0Ws3lj1k
	MDc43u4bmmf7PxLESDMWntdKjggALp68o2lYpb08HCnHU2bayhRsd6aPJMiMx4Ne66tIo1ps9+K
	JzFz295vk5gl6YjM09CPZn8PG3LW8+fU2KN8bTSU0
X-Gm-Gg: AYBFou10L+uO4GJTIGz14fxMtoi5y5Ka4bUM/F0GzMFzAgDk8ygYVQ0Ju+KpSQ7KymN
	M7Wh5JWeElwG3rqMaPbflxAmhtz0WjrBNUIxHdkd8KrM/Qu7YYkFm8h9IDCr0vExYWS0UehNcYP
	fnrWf+53MzBhv+kDpUoZ66jvM7363EP44mns/zsm3OzlAIsvb+clGc0siHDUfALCD9Li2Ikxbjj
	3zkxV19COucNR0Ht4U1CkhuyrKjnmOqVWiv571RMoOR5oME1SYvOJ6Njo0okjyTo6IjF3363UGe
	pIwD4Q3stEGZrgqP5M5wDBGKDiXyhmOgnYEwqLNo2/U1pVWX82VShFj2j15btzD6+L4bTpkqv3L
	yEJlMr3iEPdurKip4zinuHN4I90SHrBECfNZc
X-Received: by 2002:a05:622a:4c1a:b0:536:3ee4:81cd with SMTP id
 d75a77b69052e-53ff26f72f0mr18093951cf.4.1793197557717; Wed, 28 Oct 2026
 07:25:57 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-5-zide.chen@intel.com>
In-Reply-To: <20260827223755.143247-5-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 28 Oct 2026 07:25:44 -0700
X-Gm-Features: AclHuK-xtYfw983mE5Q7smgMFsswwoQHfGy-LeJFK4rz25_4O2Brshc8dDEycC8
Message-ID: <CALMp9eTq-yPoQwwoEFPYLqvLNc_2n-4kGbnZ=x=-ZAJjyOrvnw@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] KVM: x86/pmu: Gate BUFFER_OVF reserved bit on
 guest DS
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 3:49=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> global_status_rsvd unconditionally clears GLOBAL_STATUS_BUFFER_OVF
> (bit 62), even when the guest does not have X86_FEATURE_DS feature.
> Clear it only when guest_cpu_cap_has(vcpu, X86_FEATURE_DS), matching
> hardware behavior.
>
> Fixes: f5132b01386b ("KVM: Expose a version 2 architectural PMU to a gues=
ts")
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2: new patch.
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 11c9161dc853..9fdae437e569 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -576,8 +576,16 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>                          ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << K=
VM_FIXED_PMC_BASE_IDX));
>         pmu->global_ctrl_rsvd =3D counter_rsvd;
>
> -       pmu->global_status_rsvd =3D pmu->global_ctrl_rsvd
> -                       & ~(GLOBAL_STATUS_BUFFER_OVF | GLOBAL_STATUS_COND=
_CHG);
> +       /*
> +        * Layout of bits 48:0 in IA32_PERF_GLOBAL_CTRL is identical to
> +        * IA32_PERF_GLOBAL_STATUS, but IA32_PERF_GLOBAL_STATUS has addit=
ional
> +        * bits.
> +        */
> +       pmu->global_status_rsvd =3D pmu->global_ctrl_rsvd;
> +       if (guest_cpu_cap_has(vcpu, X86_FEATURE_DS))
> +               pmu->global_status_rsvd &=3D ~GLOBAL_STATUS_BUFFER_OVF;

According to Intel SDM Vol. 4, Table 2-2 ("IA-32 Architectural MSRs"), bit
62 (OvfBuf / ClrOvfBuf) in IA32_PERF_GLOBAL_STATUS (0x38e) and
IA32_PERF_GLOBAL_STATUS_RESET (0x390) is supported "If CPUID.0AH:EAX[7:0] >
0", and bit 62 (Set OvfBuf) in IA32_PERF_GLOBAL_STATUS_SET (0x391) is
supported "If CPUID.0AH:EAX[7:0] > 3". Though it makes some sense, a
dependency on CPUID.01H:EDX.DS[bit 21] is not documented in the SDM.

In mediated PMU mode, vmx_pebs_supported() is false, so KVM clears
X86_FEATURE_DS for mediated PMU guests. However, when PMU global controls
don't have to be intercepted, MSR_CORE_PERF_GLOBAL_STATUS,
MSR_CORE_PERF_GLOBAL_OVF_CTRL, and MSR_CORE_PERF_GLOBAL_STATUS_SET are
passed through directly to the guest. Hardware certainly allows bit 62 to
be written to IA32_PERF_GLOBAL_OVF_CTRL or IA32_PERF_GLOBAL_STATUS_SET.

If a guest sets bit 62 in hardware via IA32_PERF_GLOBAL_STATUS_SET,
intel_mediated_pmu_put() will save bit 62 into pmu->global_status, and
subsequent KVM_SET_MSRS(MSR_CORE_PERF_GLOBAL_STATUS) or intercepted writes
to MSR_CORE_PERF_GLOBAL_OVF_CTRL will fail the pmu->global_status_rsvd
check.

Essentially, this means that we can't pass through the PMU global controls
unless their reserved bits match hardware.
