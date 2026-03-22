Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AFA40DFCE
	for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774193874; cv=pass; b=hQmsUoU5d11kYNfJAZ3FsuX+t4hoxt9wQWJmwH6qdrEiS+a4WuRpk+LQBD7T8VjGQZBdzjB4CPTkG5MDU5iVU7NzmJLd2JRaPCt9iv9QigAzU6PWP4IkV5Y9eXems2e4d10IeWSzCW0L10IK3oFtykYgB+k25x1WPz+Ljg/04yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774193874; c=relaxed/simple;
	bh=+LNE+MzMocq6UV5snjgoPgnWIGGRUa/ms921P2bHFvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pe2a8kFj5clj+K4oyV9U7bvPTlmQqeE/R+y0UEYuESWaQBp1WN3P0E3zAALvcYtsRUfXI+wD75aKEsECQ/Ty+T89tFHOetF82gTsx42QFa1O6ivPEiJ2RSPYsdcBxK0GE3zrK5Yco4BrnLt/m/gwkNdjUhTjgGDFWrWlppVfQ7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KQKkrriF; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KQKkrriF"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-509062d829dso779431cf.1
        for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 08:37:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774193871; cv=none;
        d=google.com; s=arc-20240605;
        b=B2cpCjJgdk7qM4iF/POnmfr7tDQFcd6q3+NRy4HKU2TnAA4whqV5UttC8GELIYsIL9
         TO0Yv8rWzSHqRhwWjOLB07Xa2cFmpO3cQLKjdoEFXzag0rOlOFc2wsZvmsJR7Bz/nS4j
         FhPiFPYLrHhpR9pZ3E+sMkx7doOEoy/dS8FmnObl4vT1nJkIxQKES7VHtTokOubTZAcT
         PVYjXNMM8J0zyurpMp7En+hK0KUHvfXUgMoRhKXWadfudn6Z7TRJvDVLvZTv+N5OaaYm
         vKS9colxoprwAUEzP9ekimNGdtcuwmsTQb5KJCp1znHwvp9YdFZQnxb9pXC8P2TAg6al
         VnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fuR+54+tQE6XrGnnBxOq8qWtA7CinZ4OjktX2EB6ezY=;
        fh=mbqatOAspj0oDNlDrB5DyayeQWWaTigsNASrYqsms34=;
        b=PxrrHYg2N2MLu5mqGRe79dsklCMiFIpTFCWgCZfmLywgaWahfMvpNxXwmkDXb9KAG6
         I4S9nAOKoaCb7CqCZgDUKDfBA/GIGwWltewK4e61O79+gAqzX+EyqjfyAyx03ZPbIl0Z
         F295H1douSvjKLQd2BvAkePcw60VMqd4XTf1ICGTFqwrdxwzDK5IiUAM6NinaO0rp/D/
         qXZbZAiWscrwEiv063+DikBoC1erdSEPxpgF5mnPLrvm+pukQetJeYyLvL1QLZN3Q2ax
         ZGOkwFMWLyTXH4NKZwRnEJzfwnNNOJKGsmHj0l9INCF0oTknH7UTjotE48mlzWodYHAX
         xbwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774193871; x=1774798671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fuR+54+tQE6XrGnnBxOq8qWtA7CinZ4OjktX2EB6ezY=;
        b=KQKkrriFElb6BU+LPStm9ylxKJs+OACUVWt2MIU83ksRLLDzrFH5dL6SvEAW9DunfV
         7rGPj0IIsUftUYw3nlK38Hi+3EY4s1TfcARILeZzy6V0efjAvBUT9YY6Wl8RTq8maTol
         Jwb/IiQQZrFVCKZ4+6AyjkALJY97RZ3uvGI3vBhQnC2t1RWJsG3xOaj+ixF76ydVEC6R
         9nlX+n/+JB6tV1FvfXzsAqCqyHocD5fWRjsGDsLFTJWyRkgSXNezkSEXMVxoXaRXGotU
         2wcOk0kDJk7u5uTwJ3F9IKc2xKumWA9ih84fKvoywpC4Zfb51D0xxq5MPwEi1tqXaFv5
         ce/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774193871; x=1774798671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuR+54+tQE6XrGnnBxOq8qWtA7CinZ4OjktX2EB6ezY=;
        b=eEbgMvWLufxSaFJqUP7X/bAQZh4ajVFfaqkFY0VFAET6gL5f6kWcZSebAjPhl+uCyy
         m8KdMyFyMevtP6JCY0rW1aogYNKdpfKSbVYZQXdCweyL32jwABz3vk3aaa6eo+4THePg
         Ictki7PDu2djRP25eQZUA+Miwuyv7geIIrOfjgrX2t0bjP79acyGvMmvQzAf8QwPyxaw
         NsMbnV93bnnzAR8H8d1k6ZcKuRrzVJBuNr+wuKMtOhKrznVrE+EKq1svnuM3CMrMlXRs
         w1Y+oNARfEa6A6tyuXfIeox2uimWeW1CC8koXKtd+wlxDvVfpdSvN4fbht7rBCVXgfN6
         mOHg==
X-Forwarded-Encrypted: i=1; AJvYcCVEd8ykkBwkZVzjm2/+SvJjkRqqPV19qkcIDiy9JRSaW97NMm3k6nQuZc5bXY2IMsoe938=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy87UGibFbm3rf8EVLq0H7ZQyHjrxAixbidIxTjX4sesP7ezZk7
	3lYaWw+w5HrCdwgqAlLKI9bsQj8tiouMhpbnp4Yzf5JJ63kLrelb2J+CJyi24XKCI25IWaaljsv
	YapcVnq10OpxgpcGaW51FSwt+MF0zOG2qGQ4wEMde
X-Gm-Gg: ATEYQzybnoJ2+uDyMM8HdrFs0aDBsKlsJc0YgvURv4iFMusFPvUYYcDuWYZ3b7CYwGJ
	No4sSj+ftrhvywC84XMhawGOGchLHuLGfbdC6axlUD56Pmdd5KMpSxJu+l6rGceU4ULmKBKiro4
	9EQBVtQ860g80szjGD3J1x5Osp9Jd0AoT6n5WGS+3xeVIU0wk78zPjuxeYogRveDglHeoV48KnW
	cxLL2YDzl0Z1jVslgHkxkPrBfsJ5VkHCQ2fim1ur5YzywNk2F6vdoYCoaOnB5qMshxrCGIBmWSP
	LGl0/j+t
X-Received: by 2002:a05:622a:2d1:b0:4ff:cb72:7c03 with SMTP id
 d75a77b69052e-50b48062695mr17650241cf.3.1774193871175; Sun, 22 Mar 2026
 08:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321212419.2803972-1-maz@kernel.org> <20260321212419.2803972-3-maz@kernel.org>
In-Reply-To: <20260321212419.2803972-3-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Sun, 22 Mar 2026 15:37:14 +0000
X-Gm-Features: AQROBzCYF63bg2F-Z9cPsy4KXnsrkxV-B-1xhNDq36LfpfgZNex4zdlpfFtoy30
Message-ID: <CA+EHjTwfVkT4B87jn1Jhko=kf2us-1S4kCzj+stEOAm6ugFeAw@mail.gmail.com>
Subject: Re: [PATCH 2/5] KVM: arm64: pkvm: Simplify BTI handling on CPU boot
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Will Deacon <will@kernel.org>, 
	Mostafa Saleh <smostafa@google.com>, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Mar 2026 at 21:24, Marc Zyngier <maz@kernel.org> wrote:
>
> In order to perform an indirect branch to kvm_host_psci_cpu_entry()
> on a BTI-aware system, we first branch to a 'BTI j' landing pad,
> and from there branch again to the target.
>
> While this works, this is really not required:
>
> - BLR works with 'BTI c' and 'PACIASP' as the landing pad
>
> - Even if LR gets clobbered by BLR, we are going to restore the
>   host's registers, so it is pointless to try and avoid touching
>   LR
>
> Given the above, drop the veneer and directly call into C code.
> If we were to come back from it, we'd directly enter the error
> handler.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/kvm/hyp/nvhe/host.S     | 10 ----------
>  arch/arm64/kvm/hyp/nvhe/hyp-init.S |  9 +++++----
>  2 files changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
> index eef15b374abb0..465f6f1dd6414 100644
> --- a/arch/arm64/kvm/hyp/nvhe/host.S
> +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> @@ -291,13 +291,3 @@ SYM_CODE_START(__kvm_hyp_host_forward_smc)
>
>         ret
>  SYM_CODE_END(__kvm_hyp_host_forward_smc)
> -
> -/*
> - * kvm_host_psci_cpu_entry is called through br instruction, which requires
> - * bti j instruction as compilers (gcc and llvm) doesn't insert bti j for external
> - * functions, but bti c instead.
> - */
> -SYM_CODE_START(kvm_host_psci_cpu_entry)
> -       bti j
> -       b __kvm_host_psci_cpu_entry
> -SYM_CODE_END(kvm_host_psci_cpu_entry)
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> index 5d00bde092010..55e0dce65dc56 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> @@ -213,12 +213,13 @@ SYM_CODE_START_LOCAL(__kvm_hyp_init_cpu)
>         mov     x0, x28
>         bl      ___kvm_hyp_init                 // Clobbers x0..x2
>
> -       /* Leave idmap. */
> +       /* Leave idmap -- using BLR is OK, LR is restored from host context */
>         mov     x0, x29
> -       ldr     x1, =kvm_host_psci_cpu_entry
> -       br      x1
> +       ldr     x1, =__kvm_host_psci_cpu_entry
> +       blr     x1
>
> -       // The core booted in EL1. KVM cannot be initialized on it.
> +       // The core booted in EL1, or the C code unexpectedly returned.
> +       // Either way, KVM cannot be initialized on it.
>  1:     wfe
>         wfi
>         b       1b
> --
> 2.47.3
>
