Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26839D3D0
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474732; cv=pass; b=RpAhZnNL8k0B6m9IIzmX5ajXHHQLJ7yCpPG2zeQI+ZkMMeV4pWjOFq7iz577M3Hk2pAXtfx24JE5ZU7cx8IRyYmldxRfYOmaQ5pEkrUR0lxpKRjl9cer2ZMtKbyOFiD/uw7HlzrSOej31ZGwb+kVRYI5zHQJKqxMh0IGs9mBewY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474732; c=relaxed/simple;
	bh=qj9ba/tgg2WFDX5//QSKDt85yma2EdLQ358VwGHwrCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbL0N15L7+JweZWNR6aP+TZZHkSj8qcNvQgqR30bBVugrOkLOP9DD1HRrtqpWYCTy8sNSlec2s+vnuS7uckOhFbbbNJEyWie3sp9em/nkf19l/Ktk8zGeeAdtcxazfWsO4iNhguKVoZHTh4ORqvRWAEmLqAsuvyZqEE3j03GvTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=UZE4w1bW; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="UZE4w1bW"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e6da33a561so1005809a34.3
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 01:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780474730; cv=none;
        d=google.com; s=arc-20240605;
        b=Na/r9nSmwd5cnylNXN2/6+Y0GVkqwrTZiBbftri1iZ6EeCHemCU7ZhKjPrEgTDLVy2
         B7ITzM1KWfM9U6NiMvBtXTOOw50vAcSsd7I7+caIUuscebBS34KG0gEPw6TEzpyVgR0T
         gUP2vF2yvftU8QcySdF9dEKf7yHBqfoedN97uOoxXCppAarkOGbITUfXU3jFBjtDQgrv
         35wI0Lx91KXvuMBBJuDjrMwfrWEDsWkc73/7HfXoedhh0shbHzEAgJCDHHWrwrTwNz5V
         EWNeTVgiBUIf5x2rh0UWhMXcizho/vUKlRaTm5X5DeAcgS/PANiAMF3o8PwjCz12Vxtl
         nK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4egfNNVt2xLa6zMUvxHb6G3XcxjPLrCxY/SLCryO8sQ=;
        fh=EFGM5+sx0ilOGwsnp2XD/j0YQREj8i3+5l3+1YjA0LA=;
        b=QY3YKNimtG11t5dBAUbtqDxfds8MspusibViGecTc/2g7SOaRlKh/LBlqwDocw5yT/
         H2rQUmrGlHIM2XD3VoM4u9O56hb3QP1O/fNQZupAD7iH6JiSB1GAZo0lESLdH9kGGrmd
         2tz/VwMEVNBsBNtwDgKdINKNHhxtofoubNRWcCoU2DW2QnIBU4myS+BkdFkL3gi3F24I
         al73nCpE2N4baFF8ubDgqk41q/xZ1rzj86u9JFYRp4JpwHpVaV09J+MvNIjawXWMbyan
         inL0nwPaRtvQLq12pcfdFB2cweFPyKl76uDkKpErBGpVPl07VCwfAZqfigfUM5xcebEl
         pwqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780474730; x=1781079530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4egfNNVt2xLa6zMUvxHb6G3XcxjPLrCxY/SLCryO8sQ=;
        b=UZE4w1bW4MOUQMh4cLCZ1PDd3BA4ai0DuZM61Jvmbct7TjfzHqH76sjZ1njoBpo+9Q
         uvyR3u9j72qprqvweeYGdWJNdXumk1BcwnMV9C/Do0d1zgmUmfj09NT7alpKKvMOLKz8
         C91fewLiSrSxtUnndTz9Lxm2ICFvCOWd4cC28P2FyA0no//aO/Ks98GaeKPy8CICKsyS
         Jj6EwtS5MulCes1b5soLSg0g4kUFkK71n0QP5RefT/9bzmC/BY3FJRrMqOp/E6BJFlXO
         B8cSsgx42WuuCCQYO+uqqhysGI/ginvlC6gGbysln3bDFa0SmXRE8z4r8LpCQ79nJRkj
         7v6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780474730; x=1781079530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4egfNNVt2xLa6zMUvxHb6G3XcxjPLrCxY/SLCryO8sQ=;
        b=k0s4vQmHBqNBCYTLwywnZjJc6Zp6QU1o1XZ6pEEi72lbo7s9R1IRDaWMzavgkJUond
         fxzr7iqvFu6mjbvx5kR8BT7fgRx/PlXE000kcPuof+vctsUNdcKrjY2BiYaZe4fvYbXS
         z8XDoNSfNc3EjgSPnW3jJuDUjUFFTeH3/q4JtVtCQQZ/rsznfEWr5MlOEMPxHCi8H0J9
         XMbHUYUgArFpzU6HqBmpzMVNjT+47yYzRQ0ZTKPshvLW0I9EZZbY2r9WpXXklMWXE8xz
         B7C6rSJ6h59LMLXXSa+coqTN8QA9YOKm+9aR2FbQSVYIcwnAAbE1MR5X9i4scd9o9PpE
         iYBw==
X-Forwarded-Encrypted: i=1; AFNElJ/L0EBGeq0OwZXCObuMGrhA86YOmzqUkJxKjFD7jd9CGm89nkR4DkGmd5FgaYs7tOn74LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbC+ehmnDRqfmfkp30KcynaxfeK1c0KCGzX5kUl6vwJJqxhf9Z
	KfJyydWDZakpnfTMHzNDYpGtkcWsLn/U+QQmQXEyhPMD3mZeCJxJ2Ufhn9K8r8pn0ogHQ3Z6YHH
	ohopsMJ+ZIzvxPElVoWbUfIbpRVDZHiBe5SGSOlmGmA==
X-Gm-Gg: Acq92OHvQuEJ5SXKoJlL5T16fiU4PfFWXAPuu5Ms/PZ/WHqVFb6N1HcdbuiPY7deHAm
	bbiYRkC16A1fMaURc7BPWOeFbACNxaRLugRSbOjn6AovNzSN6N7tVB311k3aDAd1JPYP+GgxBhL
	hETJAFnpNHduOQWOpOMs/VA16hFm9m8xr796Nl3BRD0mSSj7ERRECNhPqjK2O4h7y1CzESA5bxW
	ZQp5zv+uyyl1lQR9eGxu6IJGgL33UwxAhcRRBr2RQQoe9AfFPDuGrvnzF+zv9DwolnQfAVLTaUV
	nlfWkBQGd76sfZkPcSe4rUpBUiNqljwN+9+4GQzcBZyC+5OB4R/CMMeWCOwmXxUmAB2tQHdglN9
	KDugpoj6kOqL9OTWzg9xN+lVBmwXudKo98W/aag==
X-Received: by 2002:a05:6820:54c3:b0:69d:d865:92a1 with SMTP id
 006d021491bc7-69e480c295amr1114390eaf.46.1780474730648; Wed, 03 Jun 2026
 01:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513153656847l3c4fI5hBsAyoIZi8aGIs@zte.com.cn> <20260513153901371U0gWZRa45N893VGbU7Gf9@zte.com.cn>
In-Reply-To: <20260513153901371U0gWZRa45N893VGbU7Gf9@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 3 Jun 2026 13:48:38 +0530
X-Gm-Features: AVHnY4LEigot4AhNtC66fZLcPPwlJCbOuFMHio3ko1GV9_2T4M4j-tjxNz4y7Bc
Message-ID: <CAAhSdy0Wd2=hmJ_1ZXa1mB6ojt32HeA8AW43=GLh52_5DuZqmw@mail.gmail.com>
Subject: Re: [PATCH 1/4] RISC-V: KVM: Add the split page cache for ioctl context
To: wang.yechao255@zte.com.cn
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 1:09=E2=80=AFPM <wang.yechao255@zte.com.cn> wrote:
>
> From: Wang Yechao <wang.yechao255@zte.com.cn>
>
> Add the split page cache for dirty logging enablement and the
> KVM_CLEAR_DIRTY_LOG ioctl.
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---
>  arch/riscv/include/asm/kvm_host.h | 2 ++
>  arch/riscv/kvm/mmu.c              | 3 +++
>  2 files changed, 5 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 75b0a951c1bc..e2f40854305f 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -93,6 +93,8 @@ struct kvm_arch {
>
>         /* KVM_CAP_RISCV_MP_STATE_RESET */
>         bool mp_state_reset;
> +
> +       struct kvm_mmu_memory_cache split_page_cache;

Rename it to pgd_split_page_cache and add it below
pgd_levels.

>  };
>
>  struct kvm_cpu_trap {
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 2d3def024270..85a3fb2622a4 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -549,6 +549,7 @@ int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm)
>         kvm->arch.pgd =3D page_to_virt(pgd_page);
>         kvm->arch.pgd_phys =3D page_to_phys(pgd_page);
>         kvm->arch.pgd_levels =3D kvm_riscv_gstage_max_pgd_levels;
> +       kvm->arch.split_page_cache.gfp_zero =3D __GFP_ZERO;
>
>         return 0;
>  }
> @@ -572,6 +573,8 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>
>         if (pgd)
>                 free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage=
_pgd_size));
> +
> +       kvm_mmu_free_memory_cache(&kvm->arch.split_page_cache);
>  }
>
>  void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
> --
> 2.27.0

Regards,
Anup
