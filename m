Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85F23D34A5
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778110780; cv=pass; b=EJ0wzUiP6QPQaTyJm7WxTlVLDWcdVXcHD4ELftULTctFDMP5kTpap+9oU0fIiBFWVv7bFnrJszPiDkHqFqJ8Y7ZsGkVywCz9hTnwUbULAWgCdE0ujTiHOmbUIyQ7V3d/vCn2hxCaOpYohDWFukDT6+gi75pJVOXr04A03plmDqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778110780; c=relaxed/simple;
	bh=ON7H+6CCrVC+WcgRTVacAgf0DDBCpn6Uy/WEkkrpFF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0/b1iFc7xzH/jKip4pxcjN7agS3w6wn+yFY5aQS44h+hJZLwHcD+18hKzSrUcGLFU4D+z1vWcUkEQK2Lp+UDNRES6IySNuRPIiKbrCeBC5k6S3ejbK3USZvjHofWgJnlG104Wy0nyxfhXanXI/+8Tzn6VZQWwaIg99yBKD2hF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f7K3EvHl; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7K3EvHl"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e61648f10so145361cf.1
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 16:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778110778; cv=none;
        d=google.com; s=arc-20240605;
        b=XY62okgisf+tiwIy5PSCeFMKEy3Djnbcj/z53glHkf2tGzu98/fIS3XP4fBHvISJy0
         5mK+2GJkoqm8Xu7sZ207YaninQT1/0gZmpcg6csgmJ5dG/VUDm+Zb+jt/vySsnUnU5rp
         1fTxHZw7Y/DEY8Ez7tv5aDaLAOPZ3ujhRx/xnRF5mBhs7MHmVGw3ktKT5ddqG4Pr8cCU
         tiQ6v3VXHdq6DneScFdXERDbYCIdBfuXMOClZE2AeZGl9zrJuBxvMMBrrtf3tkO3Blqk
         2Q2XS5YzQPXceREXnPdRoMXb51SQ5IQjsz8STqRVaJRhBy1pzFMTesWilSYNW/IfW9oW
         AxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fyhVGfSekSUv8Ifpy/7pbXxaFnAtASEKXTK5dlk8vsI=;
        fh=WsPsUtTY/5hgaciD5dE0GsgvLRRe5CnjrB1cqV7GQKk=;
        b=axlEiiy8bTC+QG2QQm80E84irtMRch4fe0drmNhVq3qb3Z+qYRukqjRLJfQoz7Mx3m
         xnyzsES6/0oKAqyRwuIXYOe6zX3j9bYjr2HIP6POqfaO/QUQ78MiFtU8jc6pGxT9SsJh
         vKB+CXojCeWhIM5DyU1gUTTfPVLaPVe2rBbgzYcWhU21GzEOpKWGGotSWSwQ/A620Ynu
         hMbSfOhBd8mpergctpnBHrxxhvRuxQ6ciFv4zhRgeq/VPpVTJiFnpAgfSBOxmGQ6vQh7
         y49Fvh66yIlIIARHYfyRv8C2mJ6i63Bhb7TXgbo8HwCqw/+IFUv6A8uDZIcHk6BCIsz4
         iHGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778110778; x=1778715578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyhVGfSekSUv8Ifpy/7pbXxaFnAtASEKXTK5dlk8vsI=;
        b=f7K3EvHlPR/oIYhnWTANGAidog7XpSvA9FyOQD1WO0VQgrmn20mX6r0pz7aTztvbOx
         rNiIO7uKaKDuuFnUaI8QzyR4UzghW0IIz+qmWfrmqiBSMvmI7TT0Ntt9OeCZ6AdL0TYd
         3KpeoEsIU3Euh/Fzja2EHoMDJn6mZVCS0WqTVNnGIYkFh1e6jNOFQzcQ0LWlGs7Om5qN
         ChXwjmo+CnWj8a8k43UsY93aRogToyXJDrA4xNOaL94Zo+7D/RJ9ngYvAfDG7H7WO4rK
         J05cjlj4AWzV5uFBKN9E/6LQKyx+KyBiyl9k8ipOeLgbGjigOpimwoYrRySe9t19zbuU
         GZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778110778; x=1778715578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fyhVGfSekSUv8Ifpy/7pbXxaFnAtASEKXTK5dlk8vsI=;
        b=Dengpz6wht/DbmeR/5KGdDAuobIqLRv0UEN+JwdX5S7u7ZO3v59S0gZ/aWVTYbrvv2
         zNmzXbmWxBq9tSABF+fVpsCnS3eHy4yOP/a80Av6MSV2zFqpQRDfsWjMM8iz7TO+FPSb
         zr9E7f5V7JyjXGabAZtOWul8hiY+FfBziWBMTVgtMXoD1uF5xBxWM67DOV7Ur9xXywmU
         hWm9dFB8Bxleq/4ZYftT4T1qIEcBB1M5x5gr0FUL1jwP37dF+GkrkmFugF0FvDg3APC4
         dpps5O03v5xjKeag/AEZNuyxnzT4El0JMmQwbsnsocvqPSBzm6Kgb0EIGvIW/VGs4+t+
         mWGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gcZAZwfdF8eazc7OhPrRFXufLy5h0ZcLHPzCYYbj08gcAaPHI3tvoHwdGAuHT/obalaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcETOS6rjgw+eFexTpJ81yT+msyGT/xSBSEP9IoYweA+fTrdl2
	AfVVmDsg2d0xhtelkrqC3li6c01oWdy+yDfkr2GGwCSbFT438JaJX5Y0VGJ86Xxs8aOWWbWtmD1
	L9mM+43bEkicZVWJUHd5zAheh1+8YOu13BGV2RJ048Gk6zrW5uRWXV4Fc
X-Gm-Gg: AeBDievBIqtgrdIGpcfPHBAOKtWkzlapB1MvQQpRokhbA+qKR1LbSDe6KHwmV+44R1B
	MYu7S3v0wTeCDEfzPnLfp7T7U5E7HKgzGslTOnVx1bJAgaX1pYJApj8017oooLac+x6JxSKtZi1
	zd1WowJ/KvgrEcqi1l53PeA4MXOG/4tQ4VKngbZLkfU2Ufjo+ORuAwUp8H8xCa50abE5uYwdvZ0
	RpPtZL74XP4qdtAV3LB6w5djpLJFmPpS/gZGImVMpxjnGt5HET7IYlzmn/VLmP8ioBNfM7vjUoy
	pPPOsOE29wBcYkP4xkgILJhknTHedLQVFhV71LmUuzNwmDBrwiyMOv88XgRXIw==
X-Received: by 2002:ac8:7f14:0:b0:50f:be7b:923a with SMTP id
 d75a77b69052e-51473d53735mr5687471cf.9.1778110777308; Wed, 06 May 2026
 16:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505014118.3783476-1-vannapurve@google.com>
 <20260505014118.3783476-3-vannapurve@google.com> <afvIuEuSYuktmtA2@google.com>
In-Reply-To: <afvIuEuSYuktmtA2@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 6 May 2026 16:39:25 -0700
X-Gm-Features: AVHnY4IWeFerPhMI1tIsn-_yOfP9Q2jGHuw56tjdFwA9vSus5f5pmDzsM2ljKaY
Message-ID: <CAGtprH98k7VdP4nAh7U2ioWkeTLzPs=SXeM23H0L+uj-EfXXJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: TDX: Disable pmu virtualization for TDX VMs
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, dave.hansen@linux.intel.com, 
	rick.p.edgecombe@intel.com, dapeng1.mi@linux.intel.com, mizhang@google.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 4:03=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Tue, May 05, 2026, FirstName LastName wrote:
> > From: Vishal Annapurve <vannapurve@google.com>
> >
> > TDX module virtualizes PMU for TDX VMs[1]. Host has following
> > toggles to control the PMU functionality exposed to TDX VMs:
> > 1) Configure TD_PARAMS to allow guests to use performance monitoring.
> > 2) Restrict the TD to a subset of the PEBS counters if supported.
> > 3) Limit the TD to setup a certain perfmon events using basic/enhanced
> >    event filtering.
> >
> > KVM will need to be enlightened to support these toggles. Explicitly
> > disable PMU virtualization for TDX VMs by default until such a support =
lands.
> >
> > [1] Section 15.2: https://cdrdv2.intel.com/v1/dl/getContent/733575
> >
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > ---
> >  arch/x86/kvm/vmx/tdx.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > index 1e47c194af53..01498c25942d 100644
> > --- a/arch/x86/kvm/vmx/tdx.c
> > +++ b/arch/x86/kvm/vmx/tdx.c
> > @@ -638,6 +638,12 @@ int tdx_vm_init(struct kvm *kvm)
> >       kvm->arch.has_private_mem =3D true;
> >       kvm->arch.disabled_quirks |=3D KVM_X86_QUIRK_IGNORE_GUEST_PAT;
> >
> > +     /*
> > +      * PMU support is provide by the TDX-Module (if enabled for the V=
M).
> > +      * From KVM's perspective, the VM doesn't have a virtual PMU.
> > +      */
> > +     kvm->arch.enable_pmu =3D false;
>
> Gah, I forgot that KVM_CAP_PMU_CAPABILITY allows re-enabling PMU support =
(which
> is really quite annoying).  Unless we want to risk breaking userspace, th=
e best
> idea I can come up with is to add a has_protected_pmu flag, and then disa=
llow
> KVM_CAP_PMU_CAPABILITY.
>
> The question then becomes, do we keep patch 1 and also clear enable_pmu i=
n tdx.c,
> or do we keep the ordering and have kvm_arch_init_vm() consume has_protec=
ted_pmu?
> Neither one is particularly awesome :-/

I am inclined to send the v2 with the latter option i.e. keep the
ordering the same and have kvm_arch_init_vm() consume
has_protected_pmu. Let's see how that goes.

>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index c470e40a00aa..8371dcaaed1a 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1422,6 +1422,7 @@ struct kvm_arch {
>         bool has_private_mem;
>         bool has_protected_state;
>         bool has_protected_eoi;
> +       bool has_protected_pmu;
>         bool pre_fault_allowed;
>         struct hlist_head *mmu_page_hash;
>         struct list_head active_mmu_pages;
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 04ce321ebdf3..3ba295bd44f8 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -635,6 +635,7 @@ int tdx_vm_init(struct kvm *kvm)
>          * i.e. all EOIs are accelerated and never trigger exits.
>          */
>         kvm->arch.has_protected_eoi =3D true;
> +       kvm->arch.has_protected_pmu =3D true;
>         kvm->arch.has_private_mem =3D true;
>         kvm->arch.disabled_quirks |=3D KVM_X86_QUIRK_IGNORE_GUEST_PAT;
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0a1b63c63d1a..57d78255c80c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6910,7 +6910,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>                         break;
>
>                 mutex_lock(&kvm->lock);
> -               if (!kvm->created_vcpus && !kvm->arch.created_mediated_pm=
u) {
> +               if (!kvm->created_vcpus && !kvm->arch.created_mediated_pm=
u &&
> +                   !kvm->arch.has_protected_pmu) {
>                         kvm->arch.enable_pmu =3D !(cap->args[0] & KVM_PMU=
_CAP_DISABLE);
>                         r =3D 0;
>                 }
