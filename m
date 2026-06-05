Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6163EB811
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675920; cv=pass; b=RORpbP53K54UpR5yiYSGDp3Qq/Tw6dcQCqCsCETxZFIjighqxK8eCwH2K/xmhbYcRxbXVN8HKZVXPP5irrOsQD8Lj5VZRQme/3YXv06230EkckNHLN/L6t6nDj9HBZwQJy8HGZdK9z3UnopneDpGcrfApBN3XWRA8xz+GHZnieg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675920; c=relaxed/simple;
	bh=qZVXKpPDjxCeKYy683RF7BwrEKu02kXmgev0H0RYQKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjfIapsHmNRlVpNEEw4xMi7KNwzTck0ESoXcxTLGKa109e5JWas6s5ZixauezuBZbSC86YPt41Amp+VuNUr52YPxsppRNaK8CsXRnD6rKs5h+bA8zHjTROz2yU6282fkkTnlpQrWfKg1GmAuoY4Af2KNYCe4pitBi4sS9E59ve0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=jMtywR1m; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="jMtywR1m"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-517583cb07aso23052851cf.2
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 09:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780675916; cv=none;
        d=google.com; s=arc-20240605;
        b=jtRFB7m5d3u0kXrwhfFUgMs73m/cnjeRuSjAEIXMs4qFteKzlISOlSnHgLrZBs9qG9
         tKPy8VUAHAl6W4vhcssiUw+AwUlINnSWdVlEgrFNkK5/cYBbn47aGyU0JhloZ2Zn7Idx
         L2G6LGQjRtnxpkVN1R1IiEJXo28C0DvAiCeBGuUXLKyyWpKuwhe9lWuajL+sDYCXT2pB
         aKF6S+aJih6EorTFEPGI+kGwgo8z5o3qKHuCNQIkUlbRwF3RicssMAC/KLjkJcrkvNgn
         frism759xVxHyjkUdlzzsWSturlkeYeBDuAF5Pn3ECRH7sRSkifBtuW8T1CU4dYoraO5
         FB5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B8zHAowjm9o5sCCpDMwWhliapSVQZdoHydKt2nMqWDU=;
        fh=jdrhVY7B+gs1qhtiFs5L+aw7OEZPjm+IBcIH6d/i3hU=;
        b=Lb7Y6T81J0W6mR32phKru9uayobvYLdtI/f8A8Xym2vM1F8JdnjLG5+IY2v3GUCgUn
         qASQkSI20oRMSiviOYq0yOtvn2sM5xIsavk+YofUm1XuxDjYpSObNAVOJuoqruQHA1cx
         uJC/pNbTwua0voM7ZqTJcn58ukm/93Lfu7un365Fv8cfGvjzO766B68DKWe85VE1rFyJ
         GLLZzcDIFuThvF9hXHmtOkicf9jYQs619s3xf8oofhsbXwje+4+lkfdukJHznfW00rHz
         OSgcID2xBiJsG7z5T4Vanqrxvrv8MRlkdW3SbE6xUeY5d5qGDHtRudXVuO6kB0SJrXb6
         z/qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780675916; x=1781280716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8zHAowjm9o5sCCpDMwWhliapSVQZdoHydKt2nMqWDU=;
        b=jMtywR1mAflvEKL/DcgZ1lQ88kOb7YKj6nMPg9s7VnsqLzZ9DVSuzrc7hUOD1lLpMQ
         o8VaMhQoY6Of9wP0OZEdlDOs72pRouvHr/S5VDpjd5Q6PrtodYgniUotwvkKK+z4cro5
         McE9MTduCsiCjExOAVO4vsC8Q1Mt5MjzCPgAXsoHiYlCyNA+BalAV7e61GZ+rWLaaZ71
         uRcg8Qh3rQgSb49vFvk9lzCxhUjeG1ApzuMUr8kGWgk5yBi15IJHaWkVc/KubHfqm5kf
         +Np5AfPDRkWJcDb/CQ1vkcdB0NmzeFlCLlWy2Yi4FqZTSToVXSUAZ1B7SqJN0RtEc4Dv
         5FMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780675916; x=1781280716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B8zHAowjm9o5sCCpDMwWhliapSVQZdoHydKt2nMqWDU=;
        b=EgnAkbqG2fcHgX0uGgxx6WcO63buh4eMxW7LUf3w7+YAsJ5wTA8LbcEpiOIQaijZzm
         ivUM2WC3xHEfz6m2z1LHYxZrFAGeAq0ZibU0jE5A5wxNssbCxaJfuyC1Ccu2K3Lrtbg9
         kfbJky6R2LYcUep9OuhBN5wszLGYrzV/SGC/SDsS/6+KOofhJM194p9xfxoKW+IkcRFW
         UGyjLh02Ljn80jtQnX6PoWq38Q7vVyt8zQxEnbwbdex+EzRQQ6UeRAAOPZxEkk2fmjzq
         iSllPxekDvcGDOmcyLhkDKXLqNq34d2KRYGK3Fe841+53dVygQqVQni6PkPGPe/S7Rqn
         4+0w==
X-Forwarded-Encrypted: i=1; AFNElJ/x1/pOFDjcvLyxm2lGKOT9L6XabjO8SkDjMRcD4gOQHShx8NB6i3rILGXRKWt6CkTvOWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZXriNyp8bLDK5pXFt3RE03OasR9KzqqHdxSPLnMmKrQ9Dygvh
	0znhQBPJor2sBg50eVjIokgktuAO09Tf4F2YTyasNOEAJFUE7QMg8q3wUFnDqjgMRQqjF2FZQnG
	JTYuUYhJfo/217iO1q9Q3GL9h+iXfHdVWXgmA1tZU4A==
X-Gm-Gg: Acq92OFfnd0BZpXEMbMJcFT6eLJlzvI/EXEewLvRv/3XQx4tgvcsBWrqDtA/9Ln5HEk
	J36afNoD+ft6lKtVAmisV5xzHXWoPqLMeCvw78oAkPQxDVix909URNKonDserGpR2a6wKexJZL/
	rvPw2oTZWDDhDcB2y15ikeMR54yBlDy310CrlLJ3bzgXDI9ojUgjestms3zGE6pf4WubR+ng3wI
	Q6+qzLReHQK6bL/st6341/oDKsq08Vj0MX3iA8LoWSFcv8Q9wUUGueUDVA2R6mPBneXum9f/Pw0
	Wh0kDqw4Wkl4hlhH9BBYcKbI9tWYa921I73+/pwAKbkRFHF5TT0IGMGavBqe8F+52s1P9aDTeN3
	Ld2cyS3+ihgVAdE6o40WqzoojWtKOvcmJuKtr
X-Received: by 2002:a05:622a:47ce:b0:514:5d67:7a30 with SMTP id
 d75a77b69052e-51795c74e62mr59512281cf.43.1780675915711; Fri, 05 Jun 2026
 09:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-kvm-get_reg_list-v2-v5-0-415d08a2813b@sifive.com> <20260601-kvm-get_reg_list-v2-v5-2-415d08a2813b@sifive.com>
In-Reply-To: <20260601-kvm-get_reg_list-v2-v5-2-415d08a2813b@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 5 Jun 2026 21:41:43 +0530
X-Gm-Features: AVVi8CdMjAT0z7-9b8EOLBKxYkX64w5Y19kWLNobId7ujEDIshFbGvocPy1UTls
Message-ID: <CAAhSdy1QsWMYvn9ma5gSLHyezY32t=2YGpddOgrCzqCR9qa_ug@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] KVM: RISC-V: SBI FWFT: Add optional init()
 callback for hardware probing
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, greentime.hu@sifive.com, vincent.chen@sifive.com, 
	zong.li@sifive.com, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, inochiama@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 3:56=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifive=
.com> wrote:
>
> Add an optional init() callback to separate one-time hardware probing
> from runtime availability checks. For pointer masking, this allows
> probing supported PMM lengths during initialization while checking ISA
> extension availability at runtime.
>
> Fix try_to_set_pmm() to restore the previous HENVCFG.PMM value after
> probing, preventing side effects from hardware detection. Add preemption
> protection to ensure CSR probe sequences complete atomically on the same
> CPU.
>
> Fixes: 6f576fc0aeb9 ("RISC-V: KVM: Add support for SBI_FWFT_POINTER_MASKI=
NG_PMLEN")
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi_fwft.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index 5e4aafb0cbf1..aee951f2b8e6 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -35,6 +35,16 @@ struct kvm_sbi_fwft_feature {
>          */
>         bool (*supported)(struct kvm_vcpu *vcpu);
>
> +       /**
> +        * @init: Probe and initialize the feature on the vcpu
> +        *
> +        * This callback is optional. If provided, it will be called duri=
ng
> +        * vcpu initialization to probe the feature availability and perf=
orm
> +        * any necessary initialization. Returns true if the feature is s=
upported
> +        * and initialized successfully, false otherwise.
> +        */
> +       bool (*init)(struct kvm_vcpu *vcpu);
> +
>         /**
>          * @reset: Reset the feature value irrespective whether feature i=
s supported or not
>          *
> @@ -131,19 +141,30 @@ static long kvm_sbi_fwft_get_misaligned_delegation(=
struct kvm_vcpu *vcpu,
>
>  static bool try_to_set_pmm(unsigned long value)
>  {
> +       unsigned long prev;
> +       bool ret;
> +
> +       prev =3D csr_read_clear(CSR_HENVCFG, ENVCFG_PMM);
>         csr_set(CSR_HENVCFG, value);
> -       return (csr_read_clear(CSR_HENVCFG, ENVCFG_PMM) & ENVCFG_PMM) =3D=
=3D value;
> +       ret =3D (csr_read_clear(CSR_HENVCFG, ENVCFG_PMM) & ENVCFG_PMM) =
=3D=3D value;
> +       csr_write(CSR_HENVCFG, prev);
> +
> +       return ret;
>  }
>
>  static bool kvm_sbi_fwft_pointer_masking_pmlen_supported(struct kvm_vcpu=
 *vcpu)
>  {
> -       struct kvm_sbi_fwft *fwft =3D vcpu_to_fwft(vcpu);
> +       return riscv_isa_extension_available(vcpu->arch.isa, SMNPM);
> +}
>
> -       if (!riscv_isa_extension_available(vcpu->arch.isa, SMNPM))
> -               return false;
> +static bool kvm_sbi_fwft_pointer_masking_pmlen_init(struct kvm_vcpu *vcp=
u)
> +{
> +       struct kvm_sbi_fwft *fwft =3D vcpu_to_fwft(vcpu);
>
> +       preempt_disable();
>         fwft->have_vs_pmlen_7 =3D try_to_set_pmm(ENVCFG_PMM_PMLEN_7);
>         fwft->have_vs_pmlen_16 =3D try_to_set_pmm(ENVCFG_PMM_PMLEN_16);
> +       preempt_enable();
>
>         return fwft->have_vs_pmlen_7 || fwft->have_vs_pmlen_16;
>  }
> @@ -231,6 +252,7 @@ static const struct kvm_sbi_fwft_feature features[] =
=3D {
>                 .first_reg_num =3D offsetof(struct kvm_riscv_sbi_fwft, po=
inter_masking.enable) /
>                                  sizeof(unsigned long),
>                 .supported =3D kvm_sbi_fwft_pointer_masking_pmlen_support=
ed,
> +               .init =3D kvm_sbi_fwft_pointer_masking_pmlen_init,
>                 .reset =3D kvm_sbi_fwft_reset_pointer_masking_pmlen,
>                 .set =3D kvm_sbi_fwft_set_pointer_masking_pmlen,
>                 .get =3D kvm_sbi_fwft_get_pointer_masking_pmlen,
> @@ -365,6 +387,9 @@ static int kvm_sbi_ext_fwft_init(struct kvm_vcpu *vcp=
u)
>                 else
>                         conf->supported =3D true;
>
> +               if (conf->supported && feature->init)
> +                       conf->supported =3D feature->init(vcpu);
> +
>                 conf->enabled =3D conf->supported;
>                 conf->feature =3D feature;
>         }
>
> --
> 2.43.7
>
