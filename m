Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108843D904C
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785312009; cv=pass; b=V77QKBKz4oz/fo5630iT19aVcdAb6B6YEggZgegHFnH1v/OJkHIADszAk8eOZLSBvVPMKzYSvMHlmSBtoiYcKccs5gtxq974mQZi8Vpo85GAMZvD95Pc6AAfYi5Ng+38LUVvRJgoTgYXgCWxMYIuXtmy29eiXUtJc7cV7jOePXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785312009; c=relaxed/simple;
	bh=mlWWYbcU/4fVtH4HQ25dgPxY9o42fc+klNP6TBPkQIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSnPArH7TRqla2CgA1t6TPHg/5aou81HdTdxhvH7HRNWlUzCNMf+jT1936n4hSOLVXqbQTq77yu5oCJopfYDsjkqS+MM0z+q0KszDfl0rFHs6z8tUZs42/xjNhhWCKbk+hHM8SosGeJffCfwxCSNnEtB8b2YIlhDvMNqdchkLAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=sIjQJb0a; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="sIjQJb0a"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-472326ca506so472223f8f.2
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 01:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785312006; cv=none;
        d=google.com; s=arc-20260327;
        b=DMLAUeBGydjz7AuBSdx5RoxBP3Kri1p60v7SvQWjkWNvypM911FMDbACYxDZrXJ+bn
         TOVEMGQ1XNhmyKp/Ctp1++x1UJnFRgN0xeB6kUqRu2hkpodgujHIcm7mH5nmINVSE1Fx
         UR48ILHU1ncpMwQ8YavFwVm2vMTmEbRB7XSHphNyAgS92RC/FhIIG/QOCYruhW08hPlr
         Y8F44scjsS2yurLmQmCheRFGqCuxWimhluUz6CH/9ALyHsLYwb+Biam9ExelB4eQR09I
         bHCdfenclES1Yy3lvn1n2ss7M1Jb/IX2TJaTqfzRa/HAx5JRSD+IB73CjhS+HbzDEJXJ
         cxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rci5JZNGuacWnB92Os9ssONVUy8Ji8/sE2wdKdAgC1Y=;
        fh=ebf1GRnB4/Rs0I1YjsKl5K0kHRRzOuCjylxjqgE/WLs=;
        b=maR36zxC/Lm3+M6w0ugp+fdn4UUxlfD1vPgu1YPQpguR8kieA+U4cMd0J4+OoK8f9e
         3WtYZSikzfizQFPu+nJcNhXsKl1iBt475TCC6VsXvBhEdaLLEv9/7FhXdEkgooPjRlse
         Fsa//foQngEb+9kWC+n7epI544U0CIgHBdiRVq0dBQiEge2wQrrmf5vxJxbvfuaTVD0z
         ClasCgKONhGX8E2KSMOKUuKavl2GLuUqfx+gyIhwmbjL0ZUo6ex9du2redi0U8XGiPbz
         ow9A78s+ZA10szq2NuQxeoxXBShSWDKCDZMt6XtpDFC8//lqVHNIzSMiM1yn4xbbaCtd
         ynnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785312006; x=1785916806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rci5JZNGuacWnB92Os9ssONVUy8Ji8/sE2wdKdAgC1Y=;
        b=sIjQJb0aUi6RaAr+rIhuBwxv9vNSXCWL0xgPVoR7W7vzqqzfctqbz4xt4kr+F36dqy
         gLI+4r//sgI+oF3LQU5i88ahE1jCmwDGpFpHap/lmne+OQNicuwaoY3KJUv0WaDAKH6v
         HIL8KP1LHKEwYSmfY7LA2jKHa5+tgpRmYBCMRaHuVV6bGwrgvuIoOrS9Y7FOeYLapXiO
         mtgV/KyL4BCItqawanu9en+skk96QhsoK/6hjnQWT25wS+KsjN6Qm2cDNyj0mH/OV9do
         jI1GBPaWBcZyLUT/UexKMPg6mNp5VNgYz/C66axI7HxTWPRnoyaat3O8sCtOIsTGXKwS
         urOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785312006; x=1785916806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rci5JZNGuacWnB92Os9ssONVUy8Ji8/sE2wdKdAgC1Y=;
        b=HSC+RD+hLNSVDnHP9U4+XF41PE4P4bKAv7SoDtCUxBfmlygyJjbMc6RtGCw6717tPQ
         aMdnHP+IU6x2j9GVhGGSPilwbDQhylMN6iFkud8f9bokmxSdwvvqthyuynKxSjy5DcU+
         y+R1FD2rmwvAcj9G3XJA9S5LQpbOTd6QP/vGk9YUW/FRrVvHjzEmr0vuhjKOB4uzf8z4
         INqUeYy091U3FDVwqubeu73NstSydZ55+nl2aIp/wGOn6H1vIZMWAPIwuB0PXHWJ0s5s
         h06TsUPTJzSm3IyltN6dMsbh6a5xbz/Fg5eF5JGHQNJdK/2W0O3R8Th6JsO4gSn12EMM
         JJiw==
X-Forwarded-Encrypted: i=1; AHgh+RqlPUF+XhJ2KwOu8dCwYYCuWmL8wfAqk7hUEuaP4gIpN8gTuPlUcrcbpNOe2iMy3hAqdXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNgEBQ2F65nOTylp1PDa1o6KEjehE1CcCzpQiyD3YT2v+u9sGQ
	sgVJJScPero7EJP/JnTs/J93UewkoJum/qcSt2DCvq9/4clVF7v4fHpIRBPjkTpy6sslC+V9XF7
	UbI5tTl25I1HL6K3nPFsq4pdTEF6UtTo0OQPIr+cWLg==
X-Gm-Gg: AR+sD11O98ynrvhwMD6Vfq4PCykvRXurYIbZLxOdydo08aAc/jVG/HTbbqgDvw+mi6V
	+gVSSoUb4eqYOPVL9jIfp/ETgAT8hdXL3fueZP31wlgounjHvdFsGpb2djaQlDpcDrAoZjih+P6
	wLoJlTG6u4YxpsHnLArfs/Nm6o3+HjTvFWWgoLoUdYy3V/f4BxNSFEo2MhAbr9DijXCRlbXNbqC
	F7JbpkxbGSezyzNk8dn3Gs31jw4CktzL2oHkahXZR9qJ1AJjcVUipFJNSbf9wAUpF5srT0iaBtv
	K03CnzgMjinLGjcja37LS7k6vZPkPX/oQYv0+HkGns+GpcjjRQ7a/9+hLKrgtjam/z44MHLolcx
	i93iwdrUJJ44GvDRrK83e06l3sxLIr3FRDGwYSZZgjYNIe1IfIrILMLhzxb9iV9iR4B7VbMJjSg
	==
X-Received: by 2002:a05:6000:2305:b0:47f:9cc2:ddd2 with SMTP id
 ffacd0b85a97d-47fb1f12564mr6605912f8f.35.1785312005784; Wed, 29 Jul 2026
 01:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706021154.210289-1-inochiama@gmail.com> <20260706021154.210289-3-inochiama@gmail.com>
In-Reply-To: <20260706021154.210289-3-inochiama@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 29 Jul 2026 13:29:54 +0530
X-Gm-Features: AUfX_mzA13dUOuvRHNAI3CYEINk5v4YYOQCfEpDt04tRyGPj1v-cqDo2CrT7xfE
Message-ID: <CAAhSdy2roJqQGtCXjfm4WoeSbXxMt5GSk_WO=4fAvJ4WEbjYeg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] RISC-V: KVM: Add SBI FWFT validation support
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 7:42=E2=80=AFAM Inochi Amaoto <inochiama@gmail.com> =
wrote:
>
> Since the KVM SBI has extension parameters validation support,
> implement it for the SBI FWFT support.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi_fwft.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index bc514ae6521d..0aa1f9a57c90 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -604,6 +604,30 @@ static void kvm_sbi_ext_fwft_reset(struct kvm_vcpu *=
vcpu)
>         }
>  }
>
> +static void kvm_sbi_ext_fwft_validate(struct kvm_vcpu *vcpu)
> +{
> +       struct kvm_sbi_fwft *fwft =3D vcpu_to_fwft(vcpu);
> +       const struct kvm_sbi_fwft_feature *feature;
> +       struct kvm_sbi_fwft_config *conf;
> +       int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(features); i++) {
> +               feature =3D &features[i];
> +               conf =3D &fwft->configs[i];
> +               if (!conf->supported)
> +                       continue;
> +
> +               if (!feature->supported || feature->supported(vcpu))
> +                       continue;
> +
> +               conf->enabled =3D false;
> +               conf->flags =3D 0;
> +
> +               if (feature->reset)
> +                       feature->reset(vcpu);
> +       }
> +}
> +
>  static unsigned long kvm_sbi_ext_fwft_get_reg_count(struct kvm_vcpu *vcp=
u)
>  {
>         unsigned long max_reg_count =3D sizeof(struct kvm_riscv_sbi_fwft)=
 / sizeof(unsigned long);
> @@ -756,6 +780,7 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft=
 =3D {
>         .init =3D kvm_sbi_ext_fwft_init,
>         .deinit =3D kvm_sbi_ext_fwft_deinit,
>         .reset =3D kvm_sbi_ext_fwft_reset,
> +       .validate =3D kvm_sbi_ext_fwft_validate,
>         .state_reg_subtype =3D KVM_REG_RISCV_SBI_FWFT,
>         .get_state_reg_count =3D kvm_sbi_ext_fwft_get_reg_count,
>         .get_state_reg_id =3D kvm_sbi_ext_fwft_get_reg_id,
> --
> 2.55.0
>
