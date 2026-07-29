Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF11481664
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330173; cv=pass; b=EznoeB3uuHpQqaWE0qXGVGi/TzIuY9ffydlA5ZAom8e8yq6/nP4Prkfn0YO2QDOiR8Ya78TQ7OgkQgMiZYCvD4a+NyFfMZBdfMnyaILKRKo1Xe8ClrY75fwGUwhi0ERfuv+iJcAEFmMsLoH+5zl2tovqFMc/90xRDvFP+Pp7IkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330173; c=relaxed/simple;
	bh=eDqo2iDGEPiXODUhjSnQVeqKbgf2WIdc1/PE6oVTP+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMG+9Qdppkby/3JumDqUIz/ZCJphazRFlHO40JpCZhrXVKOBsg4DFFnGgCTdOeORZhPu8uKQlDKZCCtwUGZT4XvrfQIatufJtIVAl4r08pjqndOmpBmYCMkW1DErawKoWeMEiigSS251Ts2YXZaR6Ahzui32z4J3ATNLiJUeX/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=EVw16Iyc; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="EVw16Iyc"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso827979f8f.3
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 06:02:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785330167; cv=none;
        d=google.com; s=arc-20260327;
        b=NaXCTRlehistwVzVV5u3qvkqqu/6dD1a0P6VVZFAJVqyTY5TWh/ZgTzz7bE4qKNfjm
         oAIa8UQSBzhOtyUTTNQMaZrwdL08g4H2WWeL6iUg+OjgSGRw11ONW1u9VdfTQv5prCMv
         EXcd//qJkPbYC2GrFjelasu7KhOXvp7cC7Y9RskNsYmtqaD2WQw+HkmqPvEoZLPSaSJA
         xrMfY6qqiEmL2jDkxGUeniczq6C3fPlPm+xoWdu+wNWsqMLHkG0GgC3E4Bc8Xy/WaG7H
         wu/e4hTh/dZ99gLx115Ct5YON3xqCN9UQ7B0gYM+/XaAg4YCzaeNOFVwURnj8K5fFdfV
         fVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xwG4KZ8DundkT4/gQU792HRUkxOVMwanRijYp1dPzBA=;
        fh=FHBr2p1e2lj0LXnpO2wXr3AoDhQeTKR4k8WxVTQ89E8=;
        b=Wt6bj65k1GB+F9Pr7MYOE7k4mppTIoI+u0v4uNlsyEPv3D2wFhthSiVYhFcDe8YD+k
         GXvn8Pg0NGAswuoxZruhnNANKI8kiB37QYQOqc4d1vv4XvXpeY6TCtFPMy6pLZcMsj+9
         Uf2jOPh3IPAe75gxG+IzVQ4WQFISvlAgmEJKnRMPkovo/tiN2Zs6BQAHjMJZta4NNMO5
         nspe6jpbtBnDV+clAUa/FTagG4oN48SJ9wBhlVX0wtK/qzarOlNPqcr4QybBYWGWR5V1
         AulDc0VlzQlsu6qUWB0e/d59rOqEI4z82rJSD8twTG7YL95j3/AnXToF5JgCgEvNCyfl
         DAfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785330167; x=1785934967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xwG4KZ8DundkT4/gQU792HRUkxOVMwanRijYp1dPzBA=;
        b=EVw16IyccdgQ7aSi73T06rGPlPlX9ivLdW+GtJMsd1WDDlFHVqttHstozV7F2Wenbe
         FG9xit9VExKqzVY3AepqY3Sle16SkE8T5JN+0xHub91edY7GjE5CG9xAddZE7jwc3GnW
         wRHsgeukuFfFDkD/1iInvoSMS02QfIie4P6rceIGyiJHj4aGdF5NlZbrHOxfrntsh1QE
         tuBBGpQIMi4LyGxN07WsNKDtnLA92mobFFaT76cCELwAMUaoitq48yB6vIJgdlPBDmLz
         PeMvpRDtekgH5htA9+/fFAkSA+HtVT+XFcB18L7lc9XvtfdsReA2U0+Z5wXnMmZViDG1
         avlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785330167; x=1785934967;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xwG4KZ8DundkT4/gQU792HRUkxOVMwanRijYp1dPzBA=;
        b=nf/tLk/ShZE1uMHmHZCZV2SYHlDj97FgNxLXsGqa5JSU/w/Bt5xgzBwQol+YBhOvI3
         Rs3Qnbx+IhZlBCnCVjFIOGKroQgVnji8Dyq83eAZAuxsy00ThPPDwwAf5frNiQ8s0Qve
         yLEtXRzlYMc6DEVV7kS4jk6vSzVYnKe1ngAsbteGFK4seVi0I0ayCB1yzjuLiNZiMar8
         lttQx5Tmprq43BNgoXnylcdN+RyF0OvD0tOXB9l8UoYBHEtU1padXVrRTtYnWVLjs07D
         czgYdEgI5GGHxzsHm/cadryEVvWPYe1r3EjBYebZAoQPGPxF3N5zHo+Fz/WSLk+Au6uZ
         ZBdg==
X-Forwarded-Encrypted: i=1; AHgh+Rppk8MzoIwkBB8YGzRrHZNhBPcxBx9dzE63r2/XNe0JB2ATC5H1ilk2Fy4WfhhfU5vlZyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqJWk1O/FRc8maBSV0kTG8oJM+/uTYukbVwrCHwlLVPahaE1Zn
	4+mxGAhcAHqyErku+RnsQUE0yzwBM74acimDySBvH6pOvmn6L0BP+tdSnhygJUF5suu6UwtLq3R
	a8jfkgFYlosjQriO45XP/j92yEMq2oXDdI/0njTeIdg==
X-Gm-Gg: AR+sD13c9cDvitoGmRrt2sfrolGLIpEgNm7vqpIdcCiAR1x2uOXBIz2JYoGMzSmvoWf
	PrMeaIOG+gmW72KTAMBg0sDUohLXRKNN3t+XaP70SxC8alvSbb6KFlZeWGkFwmNkLJxOTWtvEks
	TYQLGokT+c2Z6E0X1dyEaaPaJPut6XpLl5qNupmCEy/G3ihUOF+WC+lAKmJvcyabbeJytBsd9TD
	g0ere0XeVwnoJ8Z+w0BORjXmlzZ+GemuPXlmJoov6ZNWEYb+FsKnYbyMFGPidUIb0McvUam4nm3
	UCuXakEuBWMSFIhCe59AbUJtswkHAUeEH9n1miHiNpdfFUcll+tw9nxcDI5Fg1fmEGon9DeDLS1
	/zdrnGlUNvyjEBbC0cJHS1fEqeHj8BPQjwJchBKS4se+L41w1FwwuE3w85JsLAek=
X-Received: by 2002:a05:6000:2905:b0:47f:87f5:ed32 with SMTP id
 ffacd0b85a97d-47fb1f1ee67mr8269589f8f.46.1785330167110; Wed, 29 Jul 2026
 06:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713010302.303278-1-inochiama@gmail.com> <20260713010302.303278-6-inochiama@gmail.com>
In-Reply-To: <20260713010302.303278-6-inochiama@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 29 Jul 2026 18:32:35 +0530
X-Gm-Features: AUfX_mwE8ZwJxVamoxay-s7b9HbXLhua7tMXOSg40tFpb0mLvfWDnTva0izJLrg
Message-ID: <CAAhSdy2Eg3H73At808Bq8yXv64j+nowRXzHZfMBsC=MDke7Bzg@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] RISC-V: KVM: Handle software-check exits for VCPU
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Patra <atish.patra@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Andy Chiu <andybnac@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Deepak Gupta <debug@rivosinc.com>, 
	Thomas Huth <thuth@redhat.com>, Sergey Matyukevich <geomatsi@gmail.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 6:34=E2=80=AFAM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
>
> The extension Zicfiss/Zicfilp introduces a software-check exception
> to the privilege architecture. Delegate this exception to VS mode
> when vCPU enable Zicfiss/Zicfilp so the CFI violations in VU/VS could
> be reported.

The patch6 must be squashed into this patch.

Regards,
Anup

>
> Assisted-by: YuanSheng:claude-4.7-opus
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  arch/riscv/include/asm/csr.h | 1 +
>  arch/riscv/kvm/vcpu_exit.c   | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 31b8988f4488..224af9facf1f 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -117,6 +117,7 @@
>  #define EXC_INST_PAGE_FAULT    12
>  #define EXC_LOAD_PAGE_FAULT    13
>  #define EXC_STORE_PAGE_FAULT   15
> +#define EXC_SOFTWARE_CHECK             18
>  #define EXC_INST_GUEST_PAGE_FAULT      20
>  #define EXC_LOAD_GUEST_PAGE_FAULT      21
>  #define EXC_VIRTUAL_INST_FAULT         22
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 0bb0c51e3c89..12eebeabdf14 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -243,6 +243,10 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struc=
t kvm_run *run,
>                 run->exit_reason =3D KVM_EXIT_DEBUG;
>                 ret =3D 0;
>                 break;
> +       case EXC_SOFTWARE_CHECK:
> +               if (vcpu->arch.cfg.henvcfg & (ENVCFG_LPE | ENVCFG_SSE))
> +                       ret =3D vcpu_redirect(vcpu, trap);
> +               break;
>         default:
>                 break;
>         }
> --
> 2.55.0
>
