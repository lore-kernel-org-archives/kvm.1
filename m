Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862140DFBF
	for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774194989; cv=pass; b=B14+EG186TX9TLIqlogBcDVtqaHr/xl/ex+NFSd7tH3Lcb2vu1KKT+a0Xlz0pk0fC7gc++sXuiqxnPr0hojra4As+OgmwT9vZALOvaFE8tfHqu+VlJGmDi9FiyqdXuZXuXlEQHI0SF9ZEfQxiLxpi6rkV6MPtSP8jQYSxrkcl1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774194989; c=relaxed/simple;
	bh=OdDWWcazLt63r6yW7wQKXXNFVZ6zq9YIXeJTMK8dH9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ey/ykiQJRY07j5OVqxTmSVL6GvbMw4DACLNd9U0T0mMcxwdWqDledUZgS4bQImOWAMQzNSwjCyW99bJmsS34R6Fnd9JvHYiUZhSfyLJPMD2p7Qz5Amh8vgGYGKJksKGbURy1+sx1y1rsoYIIl49t5+DfOdoepMuz7CILj9UDgZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bt4IOb8w; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bt4IOb8w"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50b30d61be6so934401cf.0
        for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 08:56:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774194987; cv=none;
        d=google.com; s=arc-20240605;
        b=M6zxi4PuRfc0gW+7E9Rm+RXA+y/uJdsVjH8PGirJbqgQT4HWkuoYN60P8lBrc/GCZc
         HbBWGwi3ex5xpWK1VPQYpBzoOdNfj9GmN3JHnQoqbhg3VIZcQQNx0uvUOxtMJcHPiCFI
         5JPp2doVcaO3USya+RQ21AwKZNlcpZZ1zpunGeRFpdacEixaCzQbEoDQvjEgMdlYo8EZ
         Vy2LX6dlMq1fmbEnUqwWoFhBVhVVWG+WF+aTHvtxJZZ+HQH5WDKiT98AynV2fEemO6VX
         UQS7PQo9n6bZMGu0gjy4RC6u+OPJdPIcMKFAGujOWYXDkYI2yyFsuK8OyUrbxuN4EXeo
         3d3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FwMDzF2o2m81/v5dw831E3CHWbmSuwWgk63PblsZ1BE=;
        fh=N7Wk8ch9N0XUfDo+xuYugDXYH5dkS08CyaxCAWW8vU0=;
        b=Y7yUM4XOQd8UmPNc71pnjeD3ogS5XxfEKGrwS775n7ntsgi272dnsl2zYCCZ5NEzhi
         2u5cZCutDl2jM9jf1Lyc9wDmu3aJQ319fLLnSw7SCdgL09VaiepOz9khNt8F9GcyfnWw
         K4ZPRSA9zyBSaXXDQ+amnJLaNRs57nVNhs9Phm/vzNSj03SPHDSlsoQ76fRG0HqAvxVO
         3Fq1ccYBwyzmQMso9CnrXVbPlhWHljE/b9wbVR5TOpmE2I+g/I98Czm3OEpSU9KqljXa
         ipOab0DB6t062EqvV2vlF1Gf3XCvVwUl5wPDy9CWeAYarFPSiMsop84zqNCX1wmFyNsZ
         5YwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774194987; x=1774799787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FwMDzF2o2m81/v5dw831E3CHWbmSuwWgk63PblsZ1BE=;
        b=bt4IOb8w4YkrZMo8Oa9aLU5ENKSMNdJzmKxs+5UXxz8rTi+9mff7ij+L3XRJD7zVoy
         9UJgcDcgIUWFqE9fFBynszReOlga0efhpOeQKDo1dxk/PiLn3KaHqwJp2SYcMon+X6RP
         0l3XM2G6BWM0ihJS8UwqG4oG7X5dcPgIfBLIhoOVBSqKBmaMGU610bfLJ0B/HteKJBc5
         mk+RB/Pgr+hrxGtgwlfHIzui8XqA8IP9xh2KiBmTaZUSvDXm2tSWryHgtGQix56jszoz
         Lty59A0HatRTqCQCRO/tuJjWfUcCDRA3GkeiVjnqSUoY6D52GQLO+F72tBDmW4uRXJgL
         3nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774194987; x=1774799787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwMDzF2o2m81/v5dw831E3CHWbmSuwWgk63PblsZ1BE=;
        b=h7QI5R80g73qVCyysCux8tiTJkNfpbntzin1bdtE4vt4LyQ/8SwxLEsGVdbCQm/pFq
         n62aFY0k3wUkYhvHzAv04INSIsit4HbtIs+rk4L1xTao7ezjT+Ak0+OtI7N/8HpCB0Xi
         a5IaHgm0ZX2pwcB4LkzguFjj/nnJfmvfNyZ2373I4SUAuQtQEEEuc22Tt4VEXiCnBhFB
         X273ilw6r1tE7xbSlRiYAzHp7NqjWFBhx1Fy0BlISnEGo1UgyamNIN3bOQi8yNE2GhIG
         8L1AwMXXTanhmz1RfYuUb7vk0L3EVhViobJ1ySGLzgcSff0nDjMZhcE3vrcEuDKEpxyy
         FBBA==
X-Forwarded-Encrypted: i=1; AJvYcCV/ICoMcde67kBYWx3cWoTPJl15PdVSgDtmRsFkaQdfVvBnyfVNQb85MeULYwfcduGSsLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyxeU9LtUO2d2klaGedj+N9piOYgDyD/spQJfo13N1Ta+glEjy
	p5EKu2DYF2pi20kFcsN08BZUPBlSuZdCfcLD5ZYfaRw1tQbfVJ/h4CYIFpnmxSJ8DhRGPMysAen
	yF3atmzstI4IdazLZwiGQJHe77OpAuRZeTauVmoQE
X-Gm-Gg: ATEYQzzcfEEYfPF9qFfLZu3o1AzoXL/kMf1yfcXs7jTO/2FZor7E1EjPWxdYHkuDefv
	mPjprymAVW9AIsJR5toNA5+7sJsTQFvBwiGaoklsKJV+kRcrTXf/cyMX8wSCDADudH5NVfIDEWZ
	mFuXtJrQPHrDnjJDfQALxRFzqaiE0hoo5Q6iHe3Tq1nSM4pkcTbb9tH8xpJ5Wlx/unjtBDhVNYu
	0+CS7yRv7gw5TV7VfBbdTE3b02LMvTw0glfzWK7gUTEOdCbDwYvvRWzXkmZKxnUPLWrh4C7ChX4
	gz6RAomE
X-Received: by 2002:a05:622a:5597:b0:509:123c:f317 with SMTP id
 d75a77b69052e-50b46a6754emr18967271cf.0.1774194987102; Sun, 22 Mar 2026
 08:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321212419.2803972-1-maz@kernel.org> <20260321212419.2803972-6-maz@kernel.org>
In-Reply-To: <20260321212419.2803972-6-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Sun, 22 Mar 2026 15:55:50 +0000
X-Gm-Features: AQROBzB171gbCFjgkSVfN6aZYQOGmgdPg7i9k7vMUHnCAcyMTiTZr6INNRnWzgs
Message-ID: <CA+EHjTyRjYBn5UZyz79m4ULV4iW_FLZu7z1LaRwx9FdAQcbKhw@mail.gmail.com>
Subject: Re: [PATCH 5/5] KVM: arm64: Remove extra ISBs when using msr_hcr_el2
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Will Deacon <will@kernel.org>, 
	Mostafa Saleh <smostafa@google.com>, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Mar 2026 at 21:24, Marc Zyngier <maz@kernel.org> wrote:
>
> The msr_hcr_el2 macro is slightly awkward, as it provides an ISB
> when CONFIG_AMPERE_ERRATUM_AC04_CPU_23 is present, and none
> otherwise. Note that this this option is 'default y', meaning that
> it is likely to be selected.
>
> Most instances of msr_hcr_el2 are also immediately followed by an ISB,
> meaning that in most cases, you end-up with two back-to-back ISBs.
> This isn't a big deal, but once you have seen that, you can't unsee it.
>
> Rework the msr_hcr_el2 macro to always provide the ISB, and drop
> the superfluous ISBs everywhere else.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/include/asm/el2_setup.h | 2 --
>  arch/arm64/include/asm/sysreg.h    | 6 ++----
>  arch/arm64/kernel/hyp-stub.S       | 1 -
>  arch/arm64/kvm/hyp/nvhe/host.S     | 1 -
>  4 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> index 85f4c1615472d..3e58d6264581e 100644
> --- a/arch/arm64/include/asm/el2_setup.h
> +++ b/arch/arm64/include/asm/el2_setup.h
> @@ -50,7 +50,6 @@
>          * effectively VHE-only or not.
>          */
>         msr_hcr_el2 x0          // Setup HCR_EL2 as nVHE
> -       isb
>         mov     x1, #1          // Write something to FAR_EL1
>         msr     far_el1, x1
>         isb
> @@ -64,7 +63,6 @@
>  .LnE2H0_\@:
>         orr     x0, x0, #HCR_E2H
>         msr_hcr_el2 x0
> -       isb
>  .LnVHE_\@:
>  .endm
>
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index f4436ecc630cd..ca66b8017fa87 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -1114,11 +1114,9 @@
>         .macro  msr_hcr_el2, reg
>  #if IS_ENABLED(CONFIG_AMPERE_ERRATUM_AC04_CPU_23)
>         dsb     nsh
> -       msr     hcr_el2, \reg
> -       isb
> -#else
> -       msr     hcr_el2, \reg
>  #endif
> +       msr     hcr_el2, \reg
> +       isb                     // Required by AMPERE_ERRATUM_AC04_CPU_23
>         .endm
>  #else
>
> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> index 085bc9972f6bb..634ddc9042444 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -103,7 +103,6 @@ SYM_CODE_START_LOCAL(__finalise_el2)
>         // Engage the VHE magic!
>         mov_q   x0, HCR_HOST_VHE_FLAGS
>         msr_hcr_el2 x0
> -       isb
>
>         // Use the EL1 allocated stack, per-cpu offset
>         mrs     x0, sp_el1
> diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
> index 465f6f1dd6414..ff10cafa0ca81 100644
> --- a/arch/arm64/kvm/hyp/nvhe/host.S
> +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> @@ -125,7 +125,6 @@ SYM_FUNC_START(__hyp_do_panic)
>         mrs     x0, hcr_el2
>         bic     x0, x0, #HCR_VM
>         msr_hcr_el2 x0
> -       isb
>         tlbi    vmalls12e1
>         dsb     nsh
>  #endif
> --
> 2.47.3
>
