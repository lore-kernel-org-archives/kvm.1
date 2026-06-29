Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E81DED4C
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782764792; cv=pass; b=m+3mgp4SjdXnZy7pgK0hZXCjIjS+tRvVanktxjMl61/I0eyV2/ueZKMCIQ61aKdjuYRE1mwXh2CNWC9YhMhPugBGuA6yBO5V1m5/9ZkOmSc8OSRLBi9CsKKHZayyHqLZMbvN6y8+0C9ThaLbQXtvR56WHBwOmKp8HABzfNGY5nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782764792; c=relaxed/simple;
	bh=MY09JxyG9hMdQzyhoPmIVD3awpBb1JpfMGTAFRP/ZJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mkcfi0ejwEODXLsJn6FM4MirfRuzrmFtdWJ063zELAiTxLG5Y6dH3tKjUdFJg+nFuDa8wFEfYzl66yAzM+PsI+i4OAQ5TyLy8wa7T9khFzSdUeamj9PCOnyly7p1y2NJD+7k1/K8DcdzEczKMXF1deSP1X1mbi3XUIoXV2GgYqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahs/IiZA; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahs/IiZA"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b27c7451so11183725e9.0
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 13:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782764790; cv=none;
        d=google.com; s=arc-20260327;
        b=jkoTB4zCA3lyKwlX2XF6Kt8qzN3mQz+SYb2Atb7GusNgbYoMpuzeoC6f8bN3dBfIt7
         2IEpYAPRTIGvWHnltX8q69n2JLhSQ+X9QkWh+FSYRxaIJXca2UmpRIpzx/ZY7Cv06jF9
         xtufhtOxqcUULM76Mu6s4CIejdAfuf8GvHwEawfYkXWg2ySYKvsj8vEflBM8ujtDeLnv
         8A1PougpcPkR7I6HCMwZcwJbthEz0Y4F+PV7A8hkvn5AXHkktmbGhGjIjoIEggghYksW
         6THZFL9gmxQ7ofTXfJC0G9rByzVC5bu/j+kFTsGoKAY54yaUC3W3wb1hq+jsuO/hC4Tv
         vgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RDrF/yyIMpS6ZA2Riz+vcoNoOC8Zd0lhJXN7Go9GtGA=;
        fh=TH9rRKutAnIPpIT4IhSOMSRR6udniKjIQZtlLstB+js=;
        b=H3y8r84WxSEg6QtmhwRszKKu1qzvYN2Qcxz83RkVPWG2DJaEtpHsavHkeX1u96v/0p
         UT9WRXVwfombYOaBwNdAh6+OBLT27cSsyFzy4m3SHZkM7ywbuDw7b6U4UOftCirIFIaj
         rA8ODUeHMOdtGj74wyRFBtQxzzSEp7LPM+DPLQZqn3rebe5sF5dA6sLfryz03DeXiFRI
         pYsBsOWzrNOfioa0zCvyMwL60PKGXwXpCAAmM2mMez3o8tMJMpppPrhAOfKPKoGbG7wj
         9U5JQw/Bur0tK3OwxTUW05VC9O1qPmLNHSWRC2vNBGXllk5rMwuQTYAuywcd4G0U7Ghb
         5cDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782764790; x=1783369590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDrF/yyIMpS6ZA2Riz+vcoNoOC8Zd0lhJXN7Go9GtGA=;
        b=ahs/IiZAT1D4ZUNH/eo0GWK7kkSLcG30YWdjLvpvKRlhFLHNx8pQ7jsJ8lgR3pyXUQ
         ePkT6RuKgnzJU8onOjEhSJrC7swN9PkGMMDEAZGVJMa8gki7kXb+PyG7245asH0WivrR
         bvZ0+34PnqR/ItfCVNmC9rwTXYoJKI21uoPpMPs1hrEdxZJxUtSDvtz+ykjjgSpjiUoj
         yP37fv4DTPqj7Wpx4VMnF7nnf9otAxcQkxLjjGAJSb7G/qin/PXt4ybL4gQiSxvy+XJ0
         h9LLfb3yIxpC+0ffQ/ycbu/rcLcN6GzyqPrbFBhbkok5xFTkN1t9X+uMYHn4vIjShjAt
         Bonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782764790; x=1783369590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RDrF/yyIMpS6ZA2Riz+vcoNoOC8Zd0lhJXN7Go9GtGA=;
        b=gvw0oBTcEact+tnxq1tUfc4UvPO3eS5CXdqWDv2rbtRMU8Xu9C9ASXsY9QcoG4MQCb
         S1PLsveUkVX9uZAuWxPJZz0kX8TSlGVaVsyuwANIKyJoWVtZ8g/hf3F0HcAnu1Q994LQ
         D707pdsOzeDg9pH7fAe5zsqEx8TMioZFQGVbn21fMIfce7r/14OQ5vsYdP69RaKgjmuJ
         czM03DPXtqRCI4eiC6hfF7kN02Zh1O90LRKXIcbJNE7AFcJ0bquQMV79tXyhFwsVb8bP
         aQh11gwChGwheZpNwsrnntr9NZbpMGtUUWt/VZHOStPAvj6JOhND5Zf2QjGjg89RGWcf
         aVpQ==
X-Forwarded-Encrypted: i=1; AFNElJ9TY5/JHI8EDjRlM1+9n3MStOk1NLv2KivFxvBBrWQ6RLZ/fqrUax4OTBHkPJlgunkCf94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH/FxQYdgxIoTyhBGEWYsP2bG1z2S/0BzFwQJtQm45FpdvC+Is
	W6M17sVnRPgz1eynBRNh/D5/8iyN1+9BUYwz4caudvqDheiHfE82cR7V3UIfBdT71n4TNFT4uPa
	+WPqDH8OTNFWK9VIr2UfeJHpuhKJLLKc=
X-Gm-Gg: AfdE7cm4woSSnXg4tjHm4LehBj9qxCgY01xpv6rm8NpIacZgpt99W7a/pjSZDtkkvLm
	XATSvkWMY9r4/p1gtSFBOWiyClkmaNXwjhvLvj2B7pYIYx93c32YTEe1H2aYOtxlG/QHpP15EkP
	YgR6s4V0m8YxD3w6WjDzwtcZN5td+oYv0B2m+3/YKEUs4+MTS9vUKmxIZUu7QZpFDL5Vht0szNJ
	t47SbrkFM4O7tBoo+6V1YKFx6DZYNQGRjxtQ7JHvtOW3eMqQg4G11PV470C6an4diE8EdmsU0qG
	JViHtbLMwYh1CGb5MLQlXKS3ZX7dE4iPamwTpV5g
X-Received: by 2002:a05:600c:2307:b0:47d:52ef:c572 with SMTP id
 5b1f17b1804b1-493b8c362f0mr8930275e9.1.1782764789542; Mon, 29 Jun 2026
 13:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com> <20260621-riscv_insn_table-v2-8-7f0810ee2274@gmail.com>
In-Reply-To: <20260621-riscv_insn_table-v2-8-7f0810ee2274@gmail.com>
From: Jesse T <mr.bossman075@gmail.com>
Date: Mon, 29 Jun 2026 16:25:53 -0400
X-Gm-Features: AVVi8CfcJ5_Gyn04QD1uaVCzrs31IcTfWuPBgWH8Bbn0CKPr59m0ofaAdOQj3Go
Message-ID: <CAJFTR8T33Yw-wqPFVLe8it2cWjXCz_xPpRCRmoVMQyn7_=UBqw@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] riscv: kvm: Use generated instruction headers
 for csr code
To: thecharlesjenkins@gmail.com
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Nam Cao <namcao@linutronix.de>, 
	Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 1:08=E2=80=AFAM Charlie Jenkins via B4 Relay
<devnull+thecharlesjenkins.gmail.com@kernel.org> wrote:
>
> From: Charlie Jenkins <thecharlesjenkins@gmail.com>
>
> Migrate the csr parsing code to use the generated instruction headers
> instead of the hand-written instruction composition functions.
>
> Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
>
> ---
>
> This is a simple transformation that I have again validated through
> brute force.
> ---
>  arch/riscv/kvm/vcpu_insn.c | 47 +++++++++++++++++++++++-----------------=
------
>  1 file changed, 24 insertions(+), 23 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index f09f9251d1f0..8ccf6ec722f0 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c
> @@ -146,43 +146,44 @@ int kvm_riscv_vcpu_csr_return(struct kvm_vcpu *vcpu=
, struct kvm_run *run)
>
>  static int csr_insn(struct kvm_vcpu *vcpu, struct kvm_run *run, ulong in=
sn)
>  {
> +       #define GET_REG(_rd) (*((unsigned long *)(&vcpu->arch.guest_conte=
xt) + _rd))
> +

IMO it would be better to make this a static inline function, otherwise.

Reviewed-by: Jesse Taube <jtaubepe@redhat.com>

>         int i, rc =3D KVM_INSN_ILLEGAL_TRAP;
> -       unsigned int csr_num =3D insn >> SH_RS2;
> -       unsigned int rs1_num =3D (insn >> SH_RS1) & MASK_RX;
> -       ulong rs1_val =3D GET_RS1(insn, &vcpu->arch.guest_context);
> +       unsigned int csr_num;
>         const struct csr_func *tcfn, *cfn =3D NULL;
>         ulong val =3D 0, wr_mask =3D 0, new_val =3D 0;
>
>         /* Decode the CSR instruction */
> -       switch (GET_FUNCT3(insn)) {
> -       case GET_FUNCT3(INSN_MATCH_CSRRW):
> +       if (riscv_insn_is_csrrw(insn)) {
>                 wr_mask =3D -1UL;
> -               new_val =3D rs1_val;
> -               break;
> -       case GET_FUNCT3(INSN_MATCH_CSRRS):
> -               wr_mask =3D rs1_val;
> +               new_val =3D GET_REG(riscv_insn_csrrw_extract_xs1(insn));
> +               csr_num =3D riscv_insn_csrrw_extract_csr(insn);
> +       } else if (riscv_insn_is_csrrs(insn)) {
> +               wr_mask =3D GET_REG(riscv_insn_csrrs_extract_xs1(insn));
>                 new_val =3D -1UL;
> -               break;
> -       case GET_FUNCT3(INSN_MATCH_CSRRC):
> -               wr_mask =3D rs1_val;
> +               csr_num =3D riscv_insn_csrrs_extract_csr(insn);
> +       } else if (riscv_insn_is_csrrc(insn)) {
> +               wr_mask =3D GET_REG(riscv_insn_csrrs_extract_xs1(insn));
>                 new_val =3D 0;
> -               break;
> -       case GET_FUNCT3(INSN_MATCH_CSRRWI):
> +               csr_num =3D riscv_insn_csrrc_extract_csr(insn);
> +       } else if (riscv_insn_is_csrrwi(insn)) {
>                 wr_mask =3D -1UL;
> -               new_val =3D rs1_num;
> -               break;
> -       case GET_FUNCT3(INSN_MATCH_CSRRSI):
> -               wr_mask =3D rs1_num;
> +               new_val =3D riscv_insn_csrrwi_extract_imm(insn);
> +               csr_num =3D riscv_insn_csrrwi_extract_csr(insn);
> +       } else if (riscv_insn_is_csrrsi(insn)) {
> +               wr_mask =3D riscv_insn_csrrwi_extract_imm(insn);
>                 new_val =3D -1UL;
> -               break;
> -       case GET_FUNCT3(INSN_MATCH_CSRRCI):
> -               wr_mask =3D rs1_num;
> +               csr_num =3D riscv_insn_csrrsi_extract_csr(insn);
> +       } else if (riscv_insn_is_csrrci(insn)) {
> +               wr_mask =3D GET_REG(riscv_insn_csrrwi_extract_imm(insn));
>                 new_val =3D 0;
> -               break;
> -       default:
> +               csr_num =3D riscv_insn_csrrwi_extract_csr(insn);
> +       } else {
>                 return rc;
>         }
>
> +       #undef GET_REG
> +
>         /* Save instruction decode info */
>         vcpu->arch.csr_decode.insn =3D insn;
>         vcpu->arch.csr_decode.return_handled =3D 0;
>
> --
> 2.54.0
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
