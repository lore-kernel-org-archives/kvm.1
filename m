Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348E23B531A
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311991; cv=pass; b=GvL4c7IjUPBcDg73m48qTY2JHZslPz1ieE8d2YoOuBa8gwmFNNElJvG3oTPRx4p0VJAj0ZS5FhWgxKeuQtzI1szP/o+U0syD1OAD4qIewM6uUVRQKGeR4k8QlSYTyUjFNh4CJD3hlcqdXltxMuqOjyUQdRtUadg7p/9m4METwBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311991; c=relaxed/simple;
	bh=wY/aLSr1rt/R3yau5yLpmoKSbA0z1w0ZIpCeZuGmjvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dK/Idtb4SL1gyqbnWIZxxv/CKWuA+DEocQ1P2AlwgNA/QVii64ntw5JtYr8l3EJ4DxbzFbNLRBdsnH98Nr7KwStKbiFPalLawVmqLz/0gMM6Qdcf+CLNnjtrGx/UpJA/11/OiKpEPa6NzeDql99E7dXD1u2GNstPuW05phCAEG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=iHycGlUJ; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="iHycGlUJ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4956869750eso4429355e9.2
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 00:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785311988; cv=none;
        d=google.com; s=arc-20260327;
        b=rri4BsK7DwP2RbsIckiA9O4QbEtpJwesBd2uVz8atYzlbRVdUX1uXTDbB6/OWGMoZR
         u3A6NHX2vg8VR6eEUeK5xoE7P/d3qZgF7DYdyvgXxxyJ6/DxJngbGh1yCsrixKoNlXfR
         L9a0VPEVXyLxaEBHipAIvhblJ1y8nkkfWRSciLhoNZTatKoHph6oP2r9Sd+SGPfGXoPK
         ScktKIwsgURzutesH2eLTiIUum/NSCP6F63NoxITg85ps0p2i5IiieZ0ZC9XC7yYiExn
         oyP/rb9cdP+zUfi87Jw0c5p60CU64dbcnNtfSApVSScmEBidc8NI+CZgYzf+XctpnZEi
         TkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QVvOzRbPCBlb9W0NH5g6QA4DgSsn5yXPXhOYOe+ERRA=;
        fh=d0Y2frRbgXsYNYKp/1JyOL8IFL/sCPg2qe42ao2ZdmU=;
        b=YIGP2xMZchZkoB/usMoDy7g0dXc27NeekbrxOYZTSM2uGHSHfxZg1v4jaGM278+d5U
         CTAlGgUeCvD3At8m5yEiHoViWTdJrg+mhaGiw1cKE43aqzbcGEPAJHpoz+4MXFRcjp3E
         LOrSa4/d8pT27higae8i1o/vQxa80zV7sqVNKgJ/Q39pWbXRkiobOFGpADGsgaN8z3RU
         NfryNhcyuvch9XmtnR17jOhthkeFQrBcpFSlfBNc220tNc8cCQDHiu95Q0JR2P6wG7LL
         C6V/ggjDjPdnnArgne5EJxwa4WojAkhrFzvlH3EZ4xPuj/e8vZviaVaBdr0Fw7IprG4b
         Dojw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785311988; x=1785916788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QVvOzRbPCBlb9W0NH5g6QA4DgSsn5yXPXhOYOe+ERRA=;
        b=iHycGlUJoJmPHH2gLn9QZB3P69ubyeaRQa3JoK9VEZEOVic7nYIjSur7jJ2647uzFe
         Iz0PzygyjoYxnA0Xwe2/r3m61ecNORzXg03iYZbCcFT3s0GgcHHiyeLmVxXgy3PNBD3N
         tKHcFotepYWSW6XEan/R5jaXJRaREQ/RxUJfHczQ88cr4rGW6kSe6ySO5/KQNJoF3DuD
         oZIYBXHwVcJBOeIIvVz6Ilaog+XCVTqTEY88gzdv9Ha1y+0G8Z//L4cxBQiyhMv8AO0E
         wRsUaQkoCSJRs3BtADXw+fmtkuMz6SaDCcSSQq6bo8VModgzrRv+d6jaEcZKzedur2aH
         Rk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311988; x=1785916788;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QVvOzRbPCBlb9W0NH5g6QA4DgSsn5yXPXhOYOe+ERRA=;
        b=U4kNVzUjA3SNXvqDPOIMJNepDzWi+WQhuOTa95c6b7XA1Y4k52nN9oRldeMYTmUfTe
         mh5r92ODoWkGVYUGDusiQljoOwTW3gPAN2JDZpeK2eNbsnidu+CFdf7b3xTSjRjha3pg
         UtNPkvDyVXKK/besE5YdXL+jJPFH0HL25nIJfkRBBKOl+iDXpIgsDlXaa8m85lJJFE15
         MTDmBFuFqEczwuJwY9ULwuWR+zqFzfdUwHeHc4+iCsi9K/GU1teWdLLAdWbDvyx0Qw62
         bIZaAbCD3HqQu9EZLV8x9Sqn8FxbancdagemdLBYcZbFc0i6SVt6597SycDdoShO2YA2
         4XCA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3/NcjnSab0ZaaDflKs+XyujlQMeY8LQ40EkMKx0x/ZT1E972bmtLFwZMHwkV2B6XsgLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaavRDdhSIg8sacUrabc9X7t0u0X98M6g4bLw1zCNRxq2gmQeV
	defLvot6c0YGHSb0BeYoMdMQLjj6mTjT1niIrcHFde4cdVz2PGRjGOoZT+fOsni78dIMBmhxtHL
	3mJJQPGRo2O4EkLrmFn7+0NKsXtfdLyTlEVRSYFZAJg==
X-Gm-Gg: AR+sD11kB1r9NAPTVPp8cFHDJDgc7a8LAxrPoV7pt79Exb9IqzDJ7/gJg2bq7ZBiT0i
	N3cwNlKCh0c5LCzwMDy+Cwacjg71pfuQ2Y423STZf6/iY63h1Al2GeE4X/ab+N8+r4/2NQXWKY3
	9ANlqYEzGNbMesc1iqPKZZ2M2MS/E3iZAnkpYk6W/SRE0jKLtkkbgDfxwVX5CEsShbeF23Mi4T8
	PeumCxnAqFgG62FR/Ft/rxqSYSoKQyf/AqO+D47iqT3O6k0lpuJd+D16Tke4N0j2O31w3djhNSx
	BI7WEmEFgfkrk5DmKTcgUupk58OhA9m6wDvR+eYDUYYUcAd2w7ZsOqz6mwk+ehGD7a6F9ZXAq4O
	/8+/9w+B6XvcCmk5RxBPya79ubJQAHPT0DKfkUxVqNRdrG6Wt3DHujvVH3xqRbIs=
X-Received: by 2002:a05:600c:c8f:b0:496:bbcb:b0bb with SMTP id
 5b1f17b1804b1-496c6568fd1mr61344235e9.18.1785311987732; Wed, 29 Jul 2026
 00:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706021154.210289-1-inochiama@gmail.com> <20260706021154.210289-2-inochiama@gmail.com>
In-Reply-To: <20260706021154.210289-2-inochiama@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 29 Jul 2026 13:29:34 +0530
X-Gm-Features: AUfX_mz4RJR30cfbJm3UUOJRSHu0t8jpNEHG-kXI5W1mmhuMCQSt5po-UTYLcn8
Message-ID: <CAAhSdy0h03mwK7_N1G+o+0y9Gcb-HEUw1-FepLtHO_1NTpjJaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] RISC-V: KVM: Add SBI extension validate callback
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
> When user disable FWFT extension after setting any value of the
> FWFT feature, the state of vCPU will be broken since the value
> of disable FWFT feature is still functional.
>
> Add the generic SBI extension validate callback so the FWFT
> extension can fix its parameters before the first run.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/include/asm/kvm_vcpu_sbi.h |  4 ++++
>  arch/riscv/kvm/vcpu_config.c          |  2 ++
>  arch/riscv/kvm/vcpu_sbi.c             | 23 +++++++++++++++++++++++
>  3 files changed, 29 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/a=
sm/kvm_vcpu_sbi.h
> index c1a7e3b40d9c..f01a2860c751 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -60,6 +60,9 @@ struct kvm_vcpu_sbi_extension {
>
>         void (*reset)(struct kvm_vcpu *vcpu);
>
> +       /* Allow the extension to correct its parameters before the first=
 run */
> +       void (*validate)(struct kvm_vcpu *vcpu);
> +
>         unsigned long state_reg_subtype;
>         unsigned long (*get_state_reg_count)(struct kvm_vcpu *vcpu);
>         int (*get_state_reg_id)(struct kvm_vcpu *vcpu, int index, u64 *re=
g_id);
> @@ -93,6 +96,7 @@ int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, str=
uct kvm_run *run);
>  void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
>  void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu);
>  void kvm_riscv_vcpu_sbi_reset(struct kvm_vcpu *vcpu);
> +void kvm_riscv_vcpu_sbi_validate(struct kvm_vcpu *vcpu);
>
>  #ifdef CONFIG_RISCV_SBI_V01
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_v01;
> diff --git a/arch/riscv/kvm/vcpu_config.c b/arch/riscv/kvm/vcpu_config.c
> index 238418fed2b9..b68aa830aaf5 100644
> --- a/arch/riscv/kvm/vcpu_config.c
> +++ b/arch/riscv/kvm/vcpu_config.c
> @@ -69,6 +69,8 @@ void kvm_riscv_vcpu_config_ran_once(struct kvm_vcpu *vc=
pu)
>
>         if (vcpu->guest_debug)
>                 cfg->hedeleg &=3D ~BIT(EXC_BREAKPOINT);
> +
> +       kvm_riscv_vcpu_sbi_validate(vcpu);
>  }
>
>  void kvm_riscv_vcpu_config_load(struct kvm_vcpu *vcpu)
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index 46ab7b989432..b737e9a7a12a 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -723,3 +723,26 @@ void kvm_riscv_vcpu_sbi_reset(struct kvm_vcpu *vcpu)
>                 ext->reset(vcpu);
>         }
>  }
> +
> +void kvm_riscv_vcpu_sbi_validate(struct kvm_vcpu *vcpu)
> +{
> +       struct kvm_vcpu_sbi_context *scontext =3D &vcpu->arch.sbi_context=
;
> +       const struct kvm_riscv_sbi_extension_entry *entry;
> +       const struct kvm_vcpu_sbi_extension *ext;
> +       int idx, i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(sbi_ext); i++) {
> +               entry =3D &sbi_ext[i];
> +               ext =3D entry->ext_ptr;
> +               idx =3D entry->ext_idx;
> +
> +               if (idx < 0 || idx >=3D ARRAY_SIZE(scontext->ext_status))
> +                       continue;
> +
> +               if (scontext->ext_status[idx] !=3D KVM_RISCV_SBI_EXT_STAT=
US_ENABLED ||
> +                   !ext->validate)
> +                       continue;
> +
> +               ext->validate(vcpu);
> +       }
> +}
> --
> 2.55.0
>
