Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF35E3E49DB
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790923686; cv=pass; b=dx0XpIShE+FmEBAtXgReG3T0aROuk/eMys0xnhkP17dmDfLydeW2G3Ao5OW1XT/HmSWW/15l7tS/EYgQdxYUlsyXfWE/HK5VEpNv0q9xhIal+VX8b5Pv7At4nKYFA+zoLR1qetZvzdGtZh7AU5yDPf9J+C0BqeGE0QfVzxxp3vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790923686; c=relaxed/simple;
	bh=IfxCsQfIXOhm9duIZ5PaRvU0vF/ULsc6oL/xWYLg1cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsD8hEekEVkhMio41O4FD63ln7x5Q3uIv/k/QgOC87h0JugQILY7aR5wEtkJMSpU0/msxYxgvkYJ+9XxI4vJeUX6RR/zE/wJ9dNpTgP3VIse+hs90bs1z09Hgka5dTRnWd635svXd5yCFT+KM9toaZ2MzLnp4b77Xs+qQbqIcJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=BHVDLLJ9; arc=pass smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="BHVDLLJ9"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-48b104f6aa3so651706f8f.0
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 23:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790923682; cv=none;
        d=google.com; s=arc-20260327;
        b=YJ+4YM5hyHyuPDzK+X05taqdQKfgQj7jZWqZ4mO613REv7FBXpcYrKFsyvwf3MA0TD
         vLrxs7lCZXRLpDEHrZ4Iv8k629OjpLKoet306k3AVcBRugmVnqAPt8//Je7KBXbCWD3q
         /edqPK3BuaI1hu6hffPcjFOLWSbV6fc7lierHsvRPj4YWCPMKBdIKH6d/XtnyNF/cpf6
         hVkqYxqhiIXGBtD4vBOW1M6iUxjViUqJFiHUugNfIFDYOv/6bTgHdpA5aje4mStWiuBx
         YIZ/IhqBFjrddGMAWbV5TcfNmnm8g41nHLKzIkk+a0mNAOvJJfU5uqEHMNIkFieb9IuG
         HFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vMIvcSqpnAcev0LvZqzsQlju0HUUMmzyz0rX4omO44Q=;
        fh=x44siXPH/zXn8MeZCm7AU+RWLp/a64BbWVKfYkdWEjc=;
        b=izcjM4lMqPpwxV+hYzZYiLIObjlXZcevNMN9MUkZ5ps/DimasmAaXPMUs+TvE2FyHS
         vb1ohHFIllBwFBmWEG7DDXDl1WU7jQfmNlYIlCMunR24rnEas/VJ+ypUfrsW1UhM+sBA
         IDUtoZ9gp3qX9zRuCO4EbDECI9JxaqEExW+7f5La+Y6I1XD9GAWkO4BoWA4kUiYKulyf
         yquAnnUtIdo/jczIYlGxvtEklHSMcOgNwor34oADdAfxk2siSreL73MM3oSBDBsbSYEy
         c+JC1Q6rnuvL9zNIk7PLWhaHE6LjUGb1UwDeeZG+kQedGlyOt3UnHNjGB5tMM54dSuKW
         6sQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1790923682; x=1791528482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vMIvcSqpnAcev0LvZqzsQlju0HUUMmzyz0rX4omO44Q=;
        b=BHVDLLJ98SNjt4c3210jaPmlJxRWBtB2xHenM0ZL7qPrNyzXHih8R6jD5wTy+3TW9j
         4fG0Z7EIMCdHf2vuRwhcdRFM78/NM+o+HhmHW+umZPGeQojn3T5yoBztH87ay89oWaJV
         JV53QMyu29SPbb1brDR/bsQpWXINrPpXTRFbtA+h4RblnFe7c6oBwNZ1JDLYTfov84Ve
         QXpaVJzYBWTjBLPD6fDdTeh95XY22YBg14ILhnFxQJ6Ueq6gZMwq5r4Mu4/3mSTaFbXp
         mNxpFaEfmMsBsSIPz+1wdliKcV5TAfXer9SGujP4Tml2fkLFocCXFimPHHFf6RVdyii9
         VoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790923682; x=1791528482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vMIvcSqpnAcev0LvZqzsQlju0HUUMmzyz0rX4omO44Q=;
        b=jTRw4fnjI1G/RVFp/3NGtOYCeWZURT01c6YhVG49iflZDWttU0JxWYiso8rcBlVTSb
         leHmDWgfJTjNYrEAdCV5nJpqAeZvvhzcgCvWiUr9HetlEtAjh5I2Xkt2M4AAyGmffdIJ
         bwaPPY9lR9f2qo6wry9HthxUMdthOXphYvuJTqEnHmkmvDD+F/qT1mhwOVXbShFggO5A
         KVK4cvKLoSrE5YndNDqKmtBgcgxrbdvSRd5gp2GLtWxRzx+0iNIJlsz2NfY/tVhtIsx2
         c17KcFoFszY5gbbZd6a3B28L1G6xikgf6IApXqcgWIW1Rx4Vm2TA/R/d4j50xVcmwF2O
         SodA==
X-Forwarded-Encrypted: i=1; AKwUvBwigkpeqbqe0mc7/aDckGGIOlM3ai+J0XBfnwHIKfd2WRF6lCo8oXA8lv8eruvMcL1J1gE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfAalPRLbvAe7pR2Uq6BtMWknTyIhGx6fV6upqARZ9pyX46ScN
	BnrD/r01ZTNpmb7ElIE+3y5rrY2AvUlHWi2rBzID1bAG07DPiYSY/ZS38wDByMju6eVwKfyUD0r
	3cjHBlBWP9CaS0i2G0Tb4JIkKu6UVmsrBuIxapXMx1g==
X-Gm-Gg: AYBFou1Mh5ZQFYwWeczfQGvXAJc2+K9eYJN0xECKSb8FQMBPs1n2HC9JAYx2toC3McB
	6k1tsqYkmoW5jwHpFgFT8dYC2YCEt/u8BpTaJAC1WulxmqUcJHxguVwdlpO3AHihik6E8rOe4fC
	wKmDmAIZm2G2tzq2e934qBePN2AGcgP7DIBFWAkFRXWfF8CjFFn/qImmSw70d5lxlI9F3XBW2ya
	6FVx24JbeWJm9TljRQA7RIPl6vJjosJWobRyxud+df9AUiqNGfOTavpyij7h6aryhbe3zwVpRBv
	cmqyCJuD2mqpHppfe/4xbNwXoVtJBO0BtDjcZIzV7iA2gqOtBJX+T6Ee5JdDrj/VrpgWz6CErea
	Tr5Uq33gkrtlISC4w/E/JxNpKdkqgIyhD2u45ScQQ17EN00CQvWLnOYraeZPp6qTXQmRtvxLqaX
	8T
X-Received: by 2002:a5d:64c9:0:b0:487:91e:d8ed with SMTP id
 ffacd0b85a97d-48b12702290mr3229174f8f.2.1790923681806; Thu, 01 Oct 2026
 23:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721024236.14761-1-xb@ultrarisc.com>
In-Reply-To: <20260721024236.14761-1-xb@ultrarisc.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 2 Oct 2026 12:17:49 +0530
X-Gm-Features: AclHuK9UOCVZ6vodJjvCC76-FwtaW02UpOlI0apEZivkAZ5yfpYjH_mX6sQE75Y
Message-ID: <CAAhSdy0fqbBTfzab1H96a5B469mzuMmi4c54opPXw1-+z8_Pvw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Add SBI DBTR extension forwarding
To: Xie Bo <xb@ultrarisc.com>
Cc: Atish Patra <atish.patra@linux.dev>, kvm-riscv@lists.infradead.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 8:12=E2=80=AFAM Xie Bo <xb@ultrarisc.com> wrote:
>
> The SBI headers define the Debug Triggers extension and its function IDs,
> but KVM does not currently allow a VMM to expose DBTR to a guest.
>
> Add DBTR to the KVM SBI extension list and forward its calls to userspace
> through the existing KVM_EXIT_RISCV_SBI path. Keep the extension disabled
> by default so that userspace must explicitly enable it through the SBI
> extension ONE_REG interface before running the VCPU.

Blindly forwarding SBI DBTR calls to KVM user-space will not work because
(just like SBI PMU) we will be sharing HW debug triggers between host and
guest where KVM RISC-V will have a separate path through the perf subsystem
to configure debug triggers for guests.

We (Qualcomm) are already working on a series for SBI DBTR virtualization
in KVM RISC-V so stay tuned.

Regards,
Anup

>
> Signed-off-by: Xie Bo <xb@ultrarisc.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_sbi.h | 1 +
>  arch/riscv/include/uapi/asm/kvm.h     | 1 +
>  arch/riscv/kvm/vcpu_sbi.c             | 4 ++++
>  arch/riscv/kvm/vcpu_sbi_forward.c     | 7 +++++++
>  4 files changed, 13 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/a=
sm/kvm_vcpu_sbi.h
> index c1a7e3b40..53406b02f 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -104,6 +104,7 @@ extern const struct kvm_vcpu_sbi_extension vcpu_sbi_e=
xt_rfence;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_srst;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_hsm;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn;
> +extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbtr;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_susp;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft;
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index 504e73305..047d82f05 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -221,6 +221,7 @@ enum KVM_RISCV_SBI_EXT_ID {
>         KVM_RISCV_SBI_EXT_SUSP,
>         KVM_RISCV_SBI_EXT_FWFT,
>         KVM_RISCV_SBI_EXT_MPXY,
> +       KVM_RISCV_SBI_EXT_DBTR,
>         KVM_RISCV_SBI_EXT_MAX,
>  };
>
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index 46ab7b989..ed21239c5 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -70,6 +70,10 @@ static const struct kvm_riscv_sbi_extension_entry sbi_=
ext[] =3D {
>                 .ext_idx =3D KVM_RISCV_SBI_EXT_DBCN,
>                 .ext_ptr =3D &vcpu_sbi_ext_dbcn,
>         },
> +       {
> +               .ext_idx =3D KVM_RISCV_SBI_EXT_DBTR,
> +               .ext_ptr =3D &vcpu_sbi_ext_dbtr,
> +       },
>         {
>                 .ext_idx =3D KVM_RISCV_SBI_EXT_SUSP,
>                 .ext_ptr =3D &vcpu_sbi_ext_susp,
> diff --git a/arch/riscv/kvm/vcpu_sbi_forward.c b/arch/riscv/kvm/vcpu_sbi_=
forward.c
> index 5a3c75eb2..8ac31b53f 100644
> --- a/arch/riscv/kvm/vcpu_sbi_forward.c
> +++ b/arch/riscv/kvm/vcpu_sbi_forward.c
> @@ -26,6 +26,13 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn =
=3D {
>         .handler =3D kvm_riscv_vcpu_sbi_forward_handler,
>  };
>
> +const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbtr =3D {
> +       .extid_start =3D SBI_EXT_DBTR,
> +       .extid_end =3D SBI_EXT_DBTR,
> +       .default_disabled =3D true,
> +       .handler =3D kvm_riscv_vcpu_sbi_forward_handler,
> +};
> +
>  const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_mpxy =3D {
>         .extid_start =3D SBI_EXT_MPXY,
>         .extid_end =3D SBI_EXT_MPXY,
>
> base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
> --
> 2.54.0
>
