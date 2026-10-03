Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232A388392
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 04:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791000156; cv=none; b=lHpFt3fqwhxqupZQn2A4bcoNfKOBrgp73rRaacrRQMF/Q2k2i4S5+OI2YQkYhVHWELD2ZA42QzqBteAkU/8NhPaI+eBglMAzcCwKEPHGHWaZrw45BTfleOCz6vHEKvNUGalCttMb3VbrkWLz3LmpcPC+OqaXGPUxdHu8+1gwo04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791000156; c=relaxed/simple;
	bh=DHf+N8sLAfAAiDtbstMHFBX0Xlx5TDyTO3nV1Op8V/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsvMF6NNDRBb4WX6SL0JWhT+OBJYKYr+V6HJ0jMOzKihGHzKP9tkOJ3zI5CE6W0re49jVN3yxWJm22D1FheHU5Ch2K5hqi13KxlIvOAP6lTRSXfmMPlYg1vVWp5cAxg9z9SGle0pHbGN8caYrJ/Z/CHVPAJWMbUQFisX+3wvT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7KYmbsi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7KYmbsi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0A51F00898
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 04:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791000154;
	bh=2ShSmRUtxWEdg8PYGPavnsBraONwW1LV3c/s5yV1NCs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=n7KYmbsikhCRwDIsEDTjeuN6Zwp5d4UnP9SMGVQzLIZEz4qvkknXFTP6F7xnYkzx2
	 LH90XwQ/O+DzlWJeDjwt/0PRFwP/0egrfoYq2YHSz//0WGzqutU2HXZnQKnmSlgBMJ
	 wOG+ZD7/fpD2ZRthhiv3JGU6WM5vkBFQvSDBrIovn0MN/iXgy6Z/6DTQMhFP+d6v6w
	 yokUdgl80oIErNZ6qAQ3WjY4L8EUR7iRzlNvmTHO5OcZ+4QW/EL2V9CqociQdlrdeV
	 XXn146ME1kYjrV4ExORsZdEP0qeN9499rC75L43wgmrMlVGe9zPpZ9ej+YWyx1niv0
	 I77qnsdfbPWJw==
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6ad186afdf4so153419a12.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 21:02:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwBKzKUYJ1jNH3jm1HSjkOQBoEJXnsoQ06Ea6M246oyiJ3L4KvQHFJTHnS+NTKiTuLC/bU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6tzqe+E0BNapDYMa2Dd7Y0lE8A4PMJ/sZaYiCDkbF7hbOKb+J
	vlZ+mluQJ5qdODarCCGBgKjyf5eJ98pUzlfalQRA1hStdwgTxhaZ5pycSMY7m5EkGIQTgdA81Gp
	OgliLA2I3woneuo/7h9tlzsvPcMcIjdI=
X-Received: by 2002:a05:6402:52c1:b0:6ae:550e:59ee with SMTP id
 4fb4d7f45d1cf-6af9e30f5a0mr2805647a12.36.1791000153376; Fri, 02 Oct 2026
 21:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923012356.1058379-1-maobibo@loongson.cn>
In-Reply-To: <20260923012356.1058379-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 3 Oct 2026 12:02:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5+pFcSbjKzH-wHsOR2+07Q8D51S73DF6qCyUjdwMiHjA@mail.gmail.com>
X-Gm-Features: AclHuK8QPrzkNUWV8LeYPocyeAeY7oS40yvBcmThzE45_K4ID_lbjWl7UEZ3Hfo
Message-ID: <CAAhV-H5+pFcSbjKzH-wHsOR2+07Q8D51S73DF6qCyUjdwMiHjA@mail.gmail.com>
Subject: Re: [PATCH] KVM: LoongArch: selftests: Enable HW PTW by auto
 detection method
To: Bibo Mao <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

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
