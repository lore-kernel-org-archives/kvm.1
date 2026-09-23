Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339E63BFE5A
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 04:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790137537; cv=none; b=q/+ygyzTil4gQR23KlDOBt/MZcqIKmaqLRI03KqAe6KLNqo4kHZGMxdvvPMOQbKwCqYLssuxYGYT+AS9VbFnoVIUifV/kXBhQnnX8CQVS1Eq2L65U2uQJCiGYNMw78Hri+100Adbvoq2HriIF+MR0yXlodrjKne8jdFtwOoLh4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790137537; c=relaxed/simple;
	bh=nDIffy8Ui7Ukkiv/ZMLwEc0YmNmvoSTvU/vOMCTpJuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjgdNUMk11Ef4skt4c47tG4A/T9pu3quTgNd82vHCLwrDBLhwVheUcFpJKSVVsLQpjwAFivywpN6QuONRiildPjBs7jrCnqNdXBXuW2QIte92iObQUFsewas3QOLMXilcx289CPHT2mGrFR/+XZrY4SMrMY56+DfL+q2HeDFoRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj93yS6z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj93yS6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F362D1F0089A
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 04:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790137535;
	bh=Vdpf3PCZFlhl4pkSGtgF1HJjNWl2NcPykL1HMPHL2Wo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Bj93yS6zZuQznlcBxkUfgSIso3pb0Vh9g6Ow8iZEBlHfQEAm4570P9dSvVA+4SHgC
	 VYQY3J4M0YPZzp4oJJ3ADMPaAnH/LHZJ3em35gvUvE8tBqXdxJRqo9e1wtTtL8SgfP
	 AaHOZn73Lh3JSo3G9eqy7ThwDtrumHUE9tTI+KBx2OpyXM0SCLkjXppMfWURKkBxRT
	 aRc9ua9VaAsPJasuxnGOPFZQA2vKxObJW58hBOBy2uT2fWMChhILF3fa79GA6TMKIX
	 0LcIl5cnYJ8qF5U32rbU4GvTBlAkEQesTNEhR3uGQgmPnUTmxZs1jNBopuTXTthGv2
	 UGlCSWYCbnhbw==
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9adcso877451a12.0
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 21:25:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz0IpxtbqfhiWFNbHWDuZoOIs5JqDrgOOa0EOjCcVeWb+VUkdlYCi1zsgDg8zSZuPu8jL0=@vger.kernel.org
X-Gm-Message-State: AFuF++nAWCBBqj/q5mVBNlHD4mPmAjxzPQukG9H2AjLRbicJ8IRbRWzt
	MxFjsHGpslUu1XUpiCZHg2SLQuAqBl83/ZVUlcgxfxwFEVtjRJIVdkHu6qMeRmdfevrSTYn+scQ
	rG7dplVTGIttA8YVmAgTbv7mRk3h6/uc=
X-Received: by 2002:a05:6402:11c8:b0:6a9:bc61:7f80 with SMTP id
 4fb4d7f45d1cf-6aab3b4b9fdmr980413a12.27.1790137533480; Tue, 22 Sep 2026
 21:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923012356.1058379-1-maobibo@loongson.cn>
In-Reply-To: <20260923012356.1058379-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 23 Sep 2026 12:25:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4AvjyfmjPiUBxBsWjRNFpP5c4sWK0+ZH-e1gjtrxBhMg@mail.gmail.com>
X-Gm-Features: AcwNN1XAxUjeFmeUumiR-_MQxzHbJq692GVJ7naocC1NZSnNV46eKHaXQPViLcA
Message-ID: <CAAhV-H4AvjyfmjPiUBxBsWjRNFpP5c4sWK0+ZH-e1gjtrxBhMg@mail.gmail.com>
Subject: Re: [PATCH] KVM: LoongArch: selftests: Enable HW PTW by auto
 detection method
To: Bibo Mao <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Wed, Sep 23, 2026 at 9:31=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> Add HW PTW feature when VM is created. This feature is detected firstly,
> enable it if it is available on host machine. With HW PTW feature enabled=
,
> refill exception will not happen and it is not necessary to set refill
> exception entry.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  .../selftests/kvm/include/loongarch/processor.h  |  3 +++
>  .../selftests/kvm/lib/loongarch/processor.c      | 16 ++++++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/loongarch/processor.h b/=
tools/testing/selftests/kvm/include/loongarch/processor.h
> index 0e59daa8024e..8d9fabdc89e3 100644
> --- a/tools/testing/selftests/kvm/include/loongarch/processor.h
> +++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
> @@ -79,6 +79,7 @@
>  #define  CPUCFG2_LASX                  BIT(7)
>  #define  CPUCFG2_LLFTP                 BIT(14)
>  #define  CPUCFG2_LLFTPREV              GENMASK(17, 15)
> +#define  CPUCFG2_PTW                   BIT(24)
>
>  /* LoongArch Basic CSR registers */
>  #define LOONGARCH_CSR_CRMD             0x0 /* Current mode info */
> @@ -128,6 +129,8 @@
>  #define LOONGARCH_CSR_PGD              0x1b
>  #define LOONGARCH_CSR_PWCTL0           0x1c
>  #define LOONGARCH_CSR_PWCTL1           0x1d
> +#define  CSR_PWCTL1_PTW_SHIFT          24
> +#define  CSR_PWCTL1_PTW                        BIT_ULL(CSR_PWCTL1_PTW_SH=
IFT)
>  #define LOONGARCH_CSR_STLBPGSIZE       0x1e
>  #define LOONGARCH_CSR_CPUID            0x20
>  #define LOONGARCH_CSR_KS0              0x30
> diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tool=
s/testing/selftests/kvm/lib/loongarch/processor.c
> index 47bbde3e205a..35e35c62759f 100644
> --- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
> +++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
> @@ -282,6 +282,7 @@ void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
>         unsigned int cfg;
>         unsigned long val;
>         struct kvm_vm *vm =3D vcpu->vm;
> +       bool has_ptw =3D false;
>
>         switch (vm->mode) {
>         case VM_MODE_P36V47_16K:
> @@ -300,6 +301,12 @@ void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
>         ret =3D __kvm_has_device_attr(vm->fd, KVM_LOONGARCH_VM_FEAT_CTRL,=
 KVM_LOONGARCH_VM_FEAT_LASX);
>         if (!ret)
>                 cfg |=3D CPUCFG2_LASX;
> +       ret =3D __kvm_has_device_attr(vm->fd, KVM_LOONGARCH_VM_FEAT_CTRL,=
 KVM_LOONGARCH_VM_FEAT_PTW);
> +       if (!ret) {
> +               cfg |=3D CPUCFG2_PTW;
> +               has_ptw =3D true;
> +       }
> +
>         loongarch_set_cpucfg(vcpu, LOONGARCH_CPUCFG2, cfg);
>         cfg =3D read_cpucfg(LOONGARCH_CPUCFG6);
>         loongarch_set_cpucfg(vcpu, LOONGARCH_CPUCFG6, cfg);
> @@ -338,6 +345,9 @@ void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
>
>         /* PGD page shift and width */
>         val =3D (vm->page_shift + width * (vm->mmu.pgtable_levels - 1)) |=
 width << 6;
> +       if (has_ptw)
> +               val |=3D CSR_PWCTL1_PTW;
> +
>         loongarch_set_csr(vcpu, LOONGARCH_CSR_PWCTL1, val);
>         loongarch_set_csr(vcpu, LOONGARCH_CSR_PGDL, vm->mmu.pgd);
>
> @@ -345,8 +355,10 @@ void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
>          * Refill exception runs on real mode
>          * Entry address should be physical address
>          */
> -       val =3D addr_gva2gpa(vm, (unsigned long)handle_tlb_refill);
> -       loongarch_set_csr(vcpu, LOONGARCH_CSR_TLBRENTRY, val);
> +       if (!has_ptw) {
Why not just check CPUCFG2_PTW in cfg? In this way we can drop has_ptw.

Huacai

> +               val =3D addr_gva2gpa(vm, (unsigned long)handle_tlb_refill=
);
> +               loongarch_set_csr(vcpu, LOONGARCH_CSR_TLBRENTRY, val);
> +       }
>
>         /*
>          * General exception runs on page-enabled mode
>
> base-commit: 93f51579e7df248780214094418f205253383cc5
> --
> 2.39.3
>
