Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3582521773D
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947481; cv=pass; b=enSdpaDAAVa1veofKuW0MO/NLUSEzNYEBmGso3v6q5xl66dZFl6GDjZWVDlo83vbEJHyEKNQcVnUdeJBypk1ssaMBy+3Xq9uKioSnBg/kNeuM5feXjBlEG5HwgxFsyP/fWSqZh6hSXx68G5WrWewWXHWnxSVKy0veel7kmrIZu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947481; c=relaxed/simple;
	bh=/dnZ7zCnkvmnBNCDKG5nkZbkdNu4Qyv/nBQpyqBhdAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZIkaIWecsk152j3qdTWdccKm3efdJ6vCvcPfZ9P18imBHlfsPq1q9UQmsprL7DubEmuDq+FCsF/EO61+2RgO6ht4ANgIe5/WAgKauesu1EmP/yM4p+eJNkg/wWiVgUATSOrwd2iTgcm5XBobh6k6MW/6U9Kc6aAkj5IyIDjgeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=Eb/mbpTp; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="Eb/mbpTp"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so16436735e9.0
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 05:57:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783947478; cv=none;
        d=google.com; s=arc-20260327;
        b=S6vuFCFlpkw5LiqGvVnL1ZGsNJo5T0STO2BHQbzutHwhk0Gr2P5+kkH2x1/1diXwGI
         GYpKGG24pYhzf14GMkBqxXVqRbdfEiF1tpqX1CIu7tmbiGtkck0anoL9kyqaH8WcPp2V
         XBFNey3Sr2RJP6JgcHSmAdCnD+SuLJNaWlqjWOPY+lT0yLrxNvP6zHFTuXIFfJsYXyM7
         zon8jTK1ILIkJYam1Oa0Ctr4uN4WbFXKd9A6YctglMCAKv2tqCB/olXIX1yL8XgqQbAm
         1at8FMUE7aNmBq6c8dWIvPXt9j+3gTtZQoBL09LvkMg2cSVP4Epo6bXzoWNqwgYzU2ww
         7wUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tXeqG3zuIObLsUUPmSnJNLKn59cdNhsnjYph6ZlnxA4=;
        fh=HFhHZSt0Sda2je8hmIf1HNI01854R5SVyEEuOUuLrOM=;
        b=JxC8PH3w3pDEGGEs4fCnXa4+McLxCcKio/74dNSJaGBIuDBkinC5fWP11XvqfutC3z
         uHX8YUcdPcUYjZ6ViCbFT6f5cGwVAQen7/96JzTNDY4Zpe1pumjT3pBoACNkKC1/WfPL
         qJDhOfnySc/BJ84uz2CsFGBr880m8Q+EWhT+4QFNPqWLyYrZQKStqWiAbexqzq+YOURy
         xvJ4TlWf1TsuvkyoIXo1JnhxeyXMW4pFT8F8MDXim92SIN5+ar9fKCVnmeYfR1OOHjGT
         rAvmt6DNYwNkUUyoz5ZUUkMwjomq/9pYNCa7RRc5QTiDVDPxy1GjSqjWlCsNrJKBsJEt
         1oAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1783947478; x=1784552278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tXeqG3zuIObLsUUPmSnJNLKn59cdNhsnjYph6ZlnxA4=;
        b=Eb/mbpTpHWGCk+w5uS1KPRs5ESmV4JJQ9RTUSYuS2MOn3gUx3UAugZ+i0EhOsQ3ywf
         Y6iSyQsAMbWLBGPAXtr6Fr1e29OdYrhgbIHjgM8PSJ6r7tK1CVttXDkKIqTbhiXGKoSc
         ZezJNECfm9OJXCsKXighSuK/IqZqojap2X59dpL0aDPFz/q/E1cV+uQNHZ9uamO9N0dq
         qu6N21WwWOMZ0B2qlO98eJSDamxDFeIPINgRservb2V4SnRiLR1XYNE4F0kt82yVc1cm
         FOiyEyPxlQcPv7oHz8oRzQhcxPhRRIPmoJrRIWnl4/AGHsa6ZLDtwHQzhR210V+nRstK
         aJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947478; x=1784552278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tXeqG3zuIObLsUUPmSnJNLKn59cdNhsnjYph6ZlnxA4=;
        b=LmcyKqPrrYULbWe1VOzw6VM5BYZjOfL9mFf7F9RaSOuTeHWZDatJVec0FbKPyoqC6J
         hJJmW/XIhiSnXSvc8pyHqVqW+17jwByI2GVtnGMOShhqflwC3H4t5sVpPXx0ogY6+juB
         aZSRfh8eP6MT7CcuoEt35oxggYjjlrpaQ+dNhRHyFIyZQHE0WuBAJOvWBUBrpD9AOFM+
         C+kcUW1h6UZ7istXnNk9jkDnGuTjW3Lz+xJ1QdDXuuZfAxtrDJOxA70wnpXUM+umEZgA
         rrHgieCarrCXkb1rx/LYSAiYg2jO38QBRuDQIXrrHxi5Z0H93bfriSuHzlWqr6xoFIZq
         7qpA==
X-Forwarded-Encrypted: i=1; AHgh+RpTD2he00RvFNsgr6CyAmKIylXj7IdfP1MfFDq68Dgxwy5mExtCBvq45Dkw+36a15u3OGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj7yI5ermjl5ZZqqe/s+zVl6qkKpBQ/5lQNrOKO7x8xhOfI+1P
	/N6gKVdJ0WMqe8OTgApxCOBpDzEB6T3amEbulfqSoKwOhVeVcr1ZZbiinbQxpnTnMqq54DNnrmR
	3WmCou8JtBgZoIvd62aCm1FLdFn6sZG4dlSxpBGnByA==
X-Gm-Gg: AfdE7cnncjhttZAJC8k/wDrzkjZX5pAP0tb5E2IeUivbBFMlYto0rad60QSWwAu4faJ
	wR8rPwqox0RwlhdBKzLFWRULuta6yNEj/JgxHLFJmjaC5l8ty3nBjKv1OdrggJPaSpgnWnM3V5n
	Hmfx0roQxLg8mkfezjEYyfW2Vb5zO9QPYh+UzSl34BaU4ackAw7TVdA0rANXXdWE8o6A6B2/OTu
	9v0IHVirzljR3Xx9ObgeLtiRGnZol6EZTZZqSviU81+JYUHJ9mZe5hDCVg3AEgB/THnXPOOl79/
	P8zlTI/PDDq1VmdopRmXSg4O1KR58M9mmsdyzPmtv86DewoOAS0Pbgh6EE2+WlSVZPq/PzSmnW6
	Z+rxUZV1CQJHT/0D14qvL6XTsag==
X-Received: by 2002:a05:600c:a47:b0:493:c83b:50d7 with SMTP id
 5b1f17b1804b1-493fa5ebd55mr76298675e9.6.1783947478052; Mon, 13 Jul 2026
 05:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706181522.2003922-1-anup.patel@oss.qualcomm.com>
In-Reply-To: <20260706181522.2003922-1-anup.patel@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 13 Jul 2026 18:27:46 +0530
X-Gm-Features: AUfX_mznFq7jX5befSvsp60hLHfBrfMBiRvyp7t191jwa3YkScOz4hbTAguUPZ4
Message-ID: <CAAhSdy2Z1Rm+pFsv=SV8p9ZoYcu5uZNb1ihjYi46L3uQV2MHtA@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: KVM: Zicbo[m|z|p] block sizes should be always
 present in ONE_REG
To: Anup Patel <anup.patel@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atish.patra@linux.dev>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 11:45=E2=80=AFPM Anup Patel <anup.patel@oss.qualcomm=
.com> wrote:
>
> All config and core registers of the KVM RISC-V ONE_REG interface are
> expected to be always available to the KVM user-space and the KVM
> get-reg-list selftest assumes these registers to be as base registers.
>
> Currently, the Zicbo[m|z|p] block size config registers are only
> available when corresponding ISA extension is present on the host
> which breaks the above expectation. In fact, KVM get-reg-list selftest
> fails when any of the Zicbo[m|z|p] ISA extension is not present on
> host. To address this issue, drop the ISA extension checks from
> kvm_riscv_vcpu_get/set_reg_config() and copy_config_reg_indices()
> functions.
>
> Fixes: 031f9efafc08 ("KVM: riscv: Add KVM_GET_REG_LIST API support")
> Fixes: a044ef71043e ("RISC-V: KVM: use ENOENT in *_one_reg() when extensi=
on is unavailable")
> Fixes: 48e2febcda74 ("RISC-V: KVM: Provide UAPI for Zicbop block size")
> Fixes: cf05b059d59f ("RISC-V: KVM: Introduce common kvm_riscv_isa_check_h=
ost()")
> Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>

Queued this patch as a fix for Linux-7.2-rcX

Thanks,
Anup

> ---
> Changes since v2:
>  - Update kvm_riscv_vcpu_set_reg_config() to return -EINVAL
>    only when value is non-zero and does not match underlying
>    host cache block size.
> Changes since v1:
>  - Update kvm_riscv_vcpu_set_reg_config() to return -EINVAL
>    only when Zicbo[m|z|p] ISA extension is enabled for VCPU
> ---
>  arch/riscv/kvm/vcpu_onereg.c | 38 ++++++------------------------------
>  1 file changed, 6 insertions(+), 32 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index bb920e8923c9..61988382570f 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -50,19 +50,13 @@ static int kvm_riscv_vcpu_get_reg_config(struct kvm_v=
cpu *vcpu,
>                 reg_val =3D vcpu->arch.isa[0] & KVM_RISCV_BASE_ISA_MASK;
>                 break;
>         case KVM_REG_RISCV_CONFIG_REG(zicbom_block_size):
> -               if (kvm_riscv_isa_check_host(ZICBOM))
> -                       return -ENOENT;
> -               reg_val =3D riscv_cbom_block_size;
> +               reg_val =3D (kvm_riscv_isa_check_host(ZICBOM)) ? 0 : risc=
v_cbom_block_size;
>                 break;
>         case KVM_REG_RISCV_CONFIG_REG(zicboz_block_size):
> -               if (kvm_riscv_isa_check_host(ZICBOZ))
> -                       return -ENOENT;
> -               reg_val =3D riscv_cboz_block_size;
> +               reg_val =3D (kvm_riscv_isa_check_host(ZICBOZ)) ? 0 : risc=
v_cboz_block_size;
>                 break;
>         case KVM_REG_RISCV_CONFIG_REG(zicbop_block_size):
> -               if (kvm_riscv_isa_check_host(ZICBOP))
> -                       return -ENOENT;
> -               reg_val =3D riscv_cbop_block_size;
> +               reg_val =3D (kvm_riscv_isa_check_host(ZICBOP)) ? 0 : risc=
v_cbop_block_size;
>                 break;
>         case KVM_REG_RISCV_CONFIG_REG(mvendorid):
>                 reg_val =3D vcpu->arch.mvendorid;
> @@ -144,21 +138,15 @@ static int kvm_riscv_vcpu_set_reg_config(struct kvm=
_vcpu *vcpu,
>                 }
>                 break;
>         case KVM_REG_RISCV_CONFIG_REG(zicbom_block_size):
> -               if (kvm_riscv_isa_check_host(ZICBOM))
> -                       return -ENOENT;
> -               if (reg_val !=3D riscv_cbom_block_size)
> +               if (reg_val && reg_val !=3D riscv_cbom_block_size)
>                         return -EINVAL;
>                 break;
>         case KVM_REG_RISCV_CONFIG_REG(zicboz_block_size):
> -               if (kvm_riscv_isa_check_host(ZICBOZ))
> -                       return -ENOENT;
> -               if (reg_val !=3D riscv_cboz_block_size)
> +               if (reg_val && reg_val !=3D riscv_cboz_block_size)
>                         return -EINVAL;
>                 break;
>         case KVM_REG_RISCV_CONFIG_REG(zicbop_block_size):
> -               if (kvm_riscv_isa_check_host(ZICBOP))
> -                       return -ENOENT;
> -               if (reg_val !=3D riscv_cbop_block_size)
> +               if (reg_val && reg_val !=3D riscv_cbop_block_size)
>                         return -EINVAL;
>                 break;
>         case KVM_REG_RISCV_CONFIG_REG(mvendorid):
> @@ -614,20 +602,6 @@ static int copy_config_reg_indices(const struct kvm_=
vcpu *vcpu,
>                 u64 size;
>                 u64 reg;
>
> -               /*
> -                * Avoid reporting config reg if the corresponding extens=
ion
> -                * was not available.
> -                */
> -               if (i =3D=3D KVM_REG_RISCV_CONFIG_REG(zicbom_block_size) =
&&
> -                   kvm_riscv_isa_check_host(ZICBOM))
> -                       continue;
> -               else if (i =3D=3D KVM_REG_RISCV_CONFIG_REG(zicboz_block_s=
ize) &&
> -                        kvm_riscv_isa_check_host(ZICBOZ))
> -                       continue;
> -               else if (i =3D=3D KVM_REG_RISCV_CONFIG_REG(zicbop_block_s=
ize) &&
> -                        kvm_riscv_isa_check_host(ZICBOP))
> -                       continue;
> -
>                 size =3D IS_ENABLED(CONFIG_32BIT) ? KVM_REG_SIZE_U32 : KV=
M_REG_SIZE_U64;
>                 reg =3D KVM_REG_RISCV | size | KVM_REG_RISCV_CONFIG | i;
>
> --
> 2.43.0
>
