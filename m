Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D5389DF3
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827745; cv=pass; b=SE1P3iNWpWL2ADcePUpWKxKPI4T92wI5cRjUrlMBSWT2ayxrxUT+nKEegq8gPDgPkJTo/h69aBwsCfSj7CZPWC41/vKCkmZcNW90lTO+dMozPZYR2ux69hTPb5iduafrXizykVK8AC/RG8ezh64rp87RMOAox7I2ISQWUp8EY90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827745; c=relaxed/simple;
	bh=f47kUb4LMQksQb+Wjk8JDEGBdcDr8vKzCh650ZNV8ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwlysXY2G0dHTn5eMR9GIM4CSJX5Sa6GCHGKyzLLmn/wpwh98NTaFvVQdhRc9nN9X8BAHs59xO7s8Wf5Dw9rRrUSLjgSkJqfMJ2nFSOCI54hfIpSUfZ5uUWrWvr108U7EQEayYpWD/bT/gsT0UGPGAjm0Eb5TDqpWhAHZD0EtQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=knPfcEl0; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="knPfcEl0"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-479d5ff103aso4437209b6e.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 23:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778827742; cv=none;
        d=google.com; s=arc-20240605;
        b=NgipX7zsUeYiZMtVY2iQqPVuw8Dh3fqLdIMYPv8Pz7R6huj8e4+tHJBIaEUHrLShk4
         3jgfLVUseK1s4LK1hDFGCm7fFJyBRRe1U5FTSrOas8fE4GuYzsU8FsrlcLoudgT37oKf
         e6zEyDGIYwxqwTvNHHy4MNmL84H/TMQCKNDIP5AVyHTZGC9QCYBuJM8cJgyypCo4Qd9S
         JCWCDAcmdJ5QQ2nZoyfjnEuHyE9oUYVi4wNUf/ADDGvp3w5V+E4h1GJPhLS3gBYgnti7
         vHYQKAceHhoBNU2X3EKx4R4GGx350Hz5Z1Gh1gzSurUmT7tzSdUVFOFBXbxQfO9241Eq
         Ii3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FHfxsuw0D4onwKk/YyQ8YkX6C3b41IlcaLUUVhpqyNo=;
        fh=3EGx8Pd/7wCz4tWXNHqCti/Y7dOiwIYkRTS7gOLRUgY=;
        b=jepfbMDs965BqQQNnzlFpG5FtJfkNHoNTOct0hngrhtpCiyMUMBD8EGzRR3unEwqX+
         6tG3xR9FB8yughduiu08ZgibeGpODXSw1biFHQy6PWia8Iq4cyER1nzYQWpg6Dog2B0v
         R9Ov0q17Hnr8w/ZavhDEGx2CNFaVOp+UhHTaFApR50dABpRuUWIsMNGgcHoyL4P1IMfw
         h3meEbxajzPUgg7AC5hurLaDnzhjbq0GKkzNv45k0hQVax5e3oE8D9kqBATCqQ/8rRa2
         Rwb4+PnDp2yhGNDpX+nG2BHuiT6q77qdlDNU91Ia5rfEnRKdZBdI3lULgTJFPISXjLE6
         9TBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1778827742; x=1779432542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHfxsuw0D4onwKk/YyQ8YkX6C3b41IlcaLUUVhpqyNo=;
        b=knPfcEl02ftbaeiJi2KIlRenZYGBmor5EMZNds7JZoR8XsNVclGeV1ItTj2vgGOl6C
         wVO8oq2seerbUzrAKkNOfEnqtKy7aK0iS48s7/4rm+yGOMLuT2NncUVrmqGVnL2bHINp
         AdmWaR3QT7NutJWR3SlZvOkCLAb1myi3rt/Wqo3GMEFJ3BOB8GjK5gv2KBk+gaE3eEht
         0XbVlKx5AUMTlvpXVL7gvUidHVHHAwK9mNFdNEQ2VzRgsrpWnW+Us2AG5xw4liwDInnn
         fUvCoRFga1krJaIln2HAr0wSuiMxY/9WNBaq6W6GdOs/7xKDFlvALrxBnRrEI2/+Vnj5
         SiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778827742; x=1779432542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FHfxsuw0D4onwKk/YyQ8YkX6C3b41IlcaLUUVhpqyNo=;
        b=qI4X/DSXaDYL9efKqZbucg71iFUnyMDIKpS+IHpNjkfXsnMPhH6YZXzL+ToVriGJR8
         9tY3BGKgqLqDbxLiexweaKRjPt5pyMVEnOqXUx2gk9rCFYux41YvMBHcurhIWm/RBDFx
         ItcLTQxsvApuTm/SlElaXj2hVBlUIP/ts91nME+E/r5XdUKqXTgIFA4rHYE+2hDP2TJa
         AHFEaATH2xgZf/u4It/ndsh5NBNFlUMdDeBBmiNLgFrbn1qYZ5p8btd/ONJt7YgSsFLZ
         G4BFm3ZYQC4wEuSvTHzgcMNF9ZHUeD1EWwikYuv+CjkkSjRKvGdD3jzVLc+Kz/LhXfPf
         /LJg==
X-Forwarded-Encrypted: i=1; AFNElJ81bCWPrqD22VPnoIAOuWAyVsoe2Qslg3z2cHhU4wpqWLLDHAaVGjyzuTqVU+aZrujinU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXKH9sshrWLd7xG3AJfTbcdPNQg5BxbNunrIcUAKJlaJbFZqg4
	tyYemOTCQ8Ujrgf4Ae7o2QEsYK7pUWbiXJ8G+vfZdFUGKZiD5kgoCEe/SVIOdG+E07rfxQJt6Tw
	Wm2wGLsh7A8AbPqnamZzHVOEOIBevOFhCzGrT3AcOX7016Uv17eNo
X-Gm-Gg: Acq92OH6QMnZqUSNIkPeRTWQ2qMfL9fvIzbwPCMbmwVG1LPt93pJwrvJ8RXjrwf6tcj
	iTjA6szordxflV3Q8Ozh+AObStPV/Un9vd7aN+iHeDijDEehl0pQZXm8WaYz62NgrSdttvl+gSC
	AfrkHCVPAQXZBg1mFbFiL1jaAZXONH7v3FGPhHh11kcfF7wUacYS3tDs6eGveygmfxaR/9654zJ
	1BySSIriiST99RBmC/QLrlLlTxANrPsttsFyfAavFcZD89FiDNG+B4Jmd/ANXM0H9qxEy+wsOrw
	NG377Q80rHSAz0NqHlVK/Yxw95EMNIaXN2qowJrNwuOpXgsxj8iUrnzBSGQRasP6jWHts7Cp7i3
	hM7qN6Kw1dM4myNsERMI8X/wK3tyyg0WSuhvS+Q==
X-Received: by 2002:a05:6820:627:b0:69b:95dd:46f0 with SMTP id
 006d021491bc7-69c9437cddemr1610219eaf.33.1778827742447; Thu, 14 May 2026
 23:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514173642.41448-1-osama.abdelkader@gmail.com> <20260514173642.41448-2-osama.abdelkader@gmail.com>
In-Reply-To: <20260514173642.41448-2-osama.abdelkader@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 15 May 2026 12:18:49 +0530
X-Gm-Features: AVHnY4LXgXrzLbMRAQUcA2m5MJLX3u-xm7PLLcuSO_7vFtenzJgf3TlQ9hZcJyI
Message-ID: <CAAhSdy2+CpDu4YFXVqSDji268fapqO3sgXOSUD+fNZs9Fdb2-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: kvm: return SBI_ERR_FAILURE for pmu_event_info OOM
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 11:06=E2=80=AFPM Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> kvm_riscv_vcpu_pmu_event_info() returned -ENOMEM from the
> SBI extension handler, which caused kvm_riscv_vcpu_sbi_ecall()
> to abort KVM_RUN and surface the error to userspace instead of
> completing the ECALL with a negative SBI error in a0.
> Use SBI_ERR_FAILURE and the normal retdata path, matching other PMU
> handlers and kvm_sbi_ext_pmu_handler comment.
>
> Fixes: e309fd113b9f ("RISC-V: KVM: Implement get event info function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this as fix for Linux-7.1-rcX

Thanks,
Anup


> ---
>  arch/riscv/kvm/vcpu_pmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 91aa0155a420..bb46dcbfb24d 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -501,8 +501,10 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *v=
cpu, unsigned long saddr_low
>         }
>
>         einfo =3D kzalloc(shmem_size, GFP_KERNEL);
> -       if (!einfo)
> -               return -ENOMEM;
> +       if (!einfo) {
> +               ret =3D SBI_ERR_FAILURE;
> +               goto out;
> +       }
>
>         ret =3D kvm_vcpu_read_guest(vcpu, shmem, einfo, shmem_size);
>         if (ret) {
> --
> 2.43.0
>
