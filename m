Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8992D47F4
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780242332; cv=pass; b=ARE9l/6ytigKFZ+WQ0uu3qbAEEMN9wP2rVoOlR9gJoTMMkHfjgSFYIxNZU7L74i4EiqneLh+0odCOZlh2u2wiMpSPy+uohn/QshJWSxjVF53emhx8xtdlc2VVKIKHmFBbPsm9CRhV64J2JtEEr0XBON45u0Fo+9HWNyfTsHB/tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780242332; c=relaxed/simple;
	bh=zZ0VIiAhFt1dJc1Sm6GXu1YPi2or8SGlMOhfYo5YgRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRDZFf3u3hQNsL0z5FnTbUS935iSfQcU+T3L2wC9/nQgAnUo24Ml8xHOuL5VbtreYWmmF55z/coRgElPbQAxgheeuzFpd0dLrBal8y358a+1VoGXq7UlOFt/Ag0XoSAYPRMhYOsCLIGDzzuXLneTkTf+CcmAsvkzeVhhljoUEVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=ciXu/eHf; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="ciXu/eHf"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e6b5737bb2so675402a34.1
        for <kvm@vger.kernel.org>; Sun, 31 May 2026 08:45:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780242330; cv=none;
        d=google.com; s=arc-20240605;
        b=Ps7n5P+x5sm7Q3yPpPENh48TXwLO8Xxq/wWDdJepmjP6A8M7Xb9oftwzF1j5JVvAGS
         70UnhUrNrJPPsuXxNCwZfvs6mXsm7X6LWJnu6LTOyv9riA/HTesA/3lfq+FnUzIzCZ8W
         Uy4kRaa8SepKcGgKgITnyOfrbtviQM7ZtUaZiw0iFBOO06k9mNRJJ2t2ys1AcF0nni8d
         0uJBzwoQB1Yx7CS0xvWeWKGbN+qtiO7skCS5hMlAthsjYaDgmtN1GTWPxpCyCspBkhkU
         cFLjYk8O0y1mrDBzRxNO+C9ibL9G42bE2l7YfLtmfXqs4LnjT7UxQYEiZVT0b5Y/aFqk
         pgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ffVvusGSBvIBKqQ+1VFWDbjNlRr00R68pk/cT7yA5RI=;
        fh=MZIK5YZK0Wx50y1IRbYPrpw0pvHoGi5PfLdHgVIiZ0c=;
        b=ccqNU0knsddqk0K1xH9CZwSgkHfMgYJFcrNe2w6H6prY1o/hwSkJK5+Ij3VXDzzzF4
         VZGlGAESCg1N1P/PqDdxJvcKOG2qA2sGLQS94sVCWKF5DhA17sAZ4xTwTW/LYeyrvlCt
         v2X28tOseENhyjvaQLye6RMSbnFFQfQTevXlQPJAcaQRfjpJyJk8+Am1Ie2T4JpEOyBZ
         abhDQY0VYOghpAIEWWcg2ULMBTJaae79Ne6FrylM4+70W30HxiJXaWtG0VPHRIyWAhe1
         m0BzCwDmXCvDmAzaC3QbN/Zp8nUUDcivJLdOus8SwxwjHYmS00ppUT2Uao6dWhPMzjce
         3NpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780242330; x=1780847130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffVvusGSBvIBKqQ+1VFWDbjNlRr00R68pk/cT7yA5RI=;
        b=ciXu/eHf8iuIBKAvIVz3QaiEZkfHh6hOdzgxbi0IsvCkxwv9AyE6O5mojit0DBWcfm
         jjuwjZvndTwhaRKdUbMkGKw3CHAIOEDjYjvmLTAldqQlFUf6fwqpZcMue5hFgJgKWITU
         GjGiOBh6zE4bVHarQS0rEFD7Y6tDAV0J5m8mAGMrWJ77SN25hpTthSt4o0M8jGzR0unG
         tOLEUcpu6I2YamQGUW1ZEOkBwSwlx1jdlnA61hYuMCubQc7fYMG0D4EvGXyDswqNw590
         nzXlYITLYv539BkBhD2EC9S4XeA09ZvMYHhTIgNNFmVMIbPOpvGasBcZOp51Z6yS6uh1
         GiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780242330; x=1780847130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ffVvusGSBvIBKqQ+1VFWDbjNlRr00R68pk/cT7yA5RI=;
        b=c/JIHyQnCsFNxqwP07X2AAtPKtcZD522qw8cwdtXU+cHNXN1Jd0mxh5RCVTnBLMdDD
         ObiDjoz0rsY3hVmLznwTSKfehEjshyvEkRNCtPKBWfii5X33zUyuEEVdhX07rRkrBqLm
         i4FdfamcaeUbDPyEWJm3IHM/TP1XgSGSWc1gZGZY4yYZGR8qLYHkfXr01gloywjop/ty
         zT8uOhJLBorNhDs2Ma9dMkthNTi5Uvu3HAJrahX1Q8EkRQTKsVsu2yqi84xcaAUHcAkN
         hSwFwzgX92a1wMgAvu/lFdV1Uihbbl3PPIfR0JmRTgzWbVXQnZZmTsu3o98fhve4+ReJ
         DbwA==
X-Forwarded-Encrypted: i=1; AFNElJ8tl32oW9BkPf9bANj+Mvsj3nF2SoRT2VQ3BVrtl7MUBi1psbGQsGNFgEhNpu2V8ya7Xoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhnhCVrfKsilSBlZjIXAWdeE63YoiMBJX+P+JeA6408A8hXL4b
	GW5nKAGvrFqgz81nhFsuphUyNCG3Y4psxPHu61xOw/ROywdIclGv9L1fJutcq9JAko+XIcOsGEc
	3bqs+62X1NotLc2yTRn3w6Muatba0LFEcfXiTpoVjaA==
X-Gm-Gg: Acq92OEZj2N6uYFuZieq46QBidH+i8dugXJf74GsExXGTGj26sVma7yyUCZ7GjYiH7x
	b4UQ0yh+z2o7f5Cdefld797N3cKiwNukFI5TXxm+2B6H6wKjAKKEUsWaAHfEKEnVB6nmnwF51lb
	vGHtUJe+fb4WkzwWCG4xBjI595YaTHtYPXE8wIUF2JyyavQOf60EBoFgd8+HnVA4CusKKyEfXHY
	6oApz5NUxhhJqpNc5g8+CCYzW0bbai319qSduiDzZZggq/JgvpCeNCKHslZ0AnXxuuOBw9Rrb5h
	iCIiBJj5TEY1L3MCnXpqRXfMZY5CRc6I6o36mY4aA/emsIeQFFVbl5bRM1c0rbhcc1dNVz99Myr
	eoKC8xDYamOT/NNPD35L7f3D6eL6e53AwtQ31sg==
X-Received: by 2002:a05:6820:1527:b0:69d:521d:a4f1 with SMTP id
 006d021491bc7-69e1044ceedmr3931061eaf.55.1780242329785; Sun, 31 May 2026
 08:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412023822.83341-1-tjytimi@163.com>
In-Reply-To: <20260412023822.83341-1-tjytimi@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 31 May 2026 21:15:18 +0530
X-Gm-Features: AVHnY4IPLkH2PAfrNFMXoZbFd0wUOukcHZWo0aW3NnKEBn7hoIOQo0dRaZewGq0
Message-ID: <CAAhSdy3pi+XqFKDynFafb0mg8+vJJaCvoWbBUmB5p1QB586Piw@mail.gmail.com>
Subject: Re: [PATCH v4] RISC-V: KVM: Batch stage-2 TLB flushes
To: Jinyu Tang <tjytimi@163.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 8:08=E2=80=AFAM Jinyu Tang <tjytimi@163.com> wrote:
>
> KVM RISC-V triggers a TLB flush for every single stage-2 PTE
> modification (unmap or write-protect) now. Although KVM coalesces the
> hardware IPIs, the software overhead of executing the flush work
> for every page is large, especially during dirty page tracking.
>
> Following the approach used in x86 and arm64, this patch optimizes
> the MMU logic by making the PTE manipulation functions return a boolean
> indicating if a leaf PTE was actually changed. The outer MMU functions
> bubble up this flag to batch the remote TLB flushes.
>
> Consequently, the flush operation is executed only once per batch.
> Moving it outside of the `mmu_lock` also reduces lock contention.
>
> Tested with tools/testing/selftests/kvm on a 4-vCPU guest (Host
> environment: QEMU 10.2.1 RISC-V)
> 1. demand_paging_test (1GB memory)
>   time ./demand_paging_test -b 1G -v 4
> - Total execution time reduced from ~2m39s to ~2m31s
> 2. dirty_log_perf_test (1GB memory)
>   ./dirty_log_perf_test -b 1G -v 4
> - "Clear dirty log time" per iteration dropped significantly from
>    ~3.40s to ~0.18s
>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Signed-off-by: Jinyu Tang <tjytimi@163.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.2

Thanks,
Anup

> ---
> v3 -> v4:
> Rebase to branch linux-riscv_kvm_next and retest performance
>
> v2 -> v3:
> Addressed review comments from Anup Patel:
> - Removed gstage_tlb_flush() for non-leaf PTEs only set flush flag
> - Removed KVM_GSTAGE_FLAGS_LOCAL check
> - Used kvm_flush_remote_tlbs_range() instead of full flushes in
>   kvm_arch_flush_shadow_memslot() and kvm_unmap_gfn_range() to avoid
>   unnecessary global TLB flush.
>
> v1 -> v2:
> - Fixed alignment issues in multi-line function calls supported by
>   Nutty Liu.
>
>  arch/riscv/include/asm/kvm_gstage.h |  6 ++--
>  arch/riscv/kvm/gstage.c             | 35 ++++++++++++++---------
>  arch/riscv/kvm/mmu.c                | 44 +++++++++++++++++++++++------
>  3 files changed, 60 insertions(+), 25 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm=
/kvm_gstage.h
> index 9c908432b..f820c6783 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -70,13 +70,13 @@ enum kvm_riscv_gstage_op {
>         GSTAGE_OP_WP,           /* Write-protect */
>  };
>
> -void kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
> +bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
>                              pte_t *ptep, u32 ptep_level, enum kvm_riscv_=
gstage_op op);
>
> -void kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
> +bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
>                                   gpa_t start, gpa_t size, bool may_block=
);
>
> -void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, g=
pa_t end);
> +bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, g=
pa_t end);
>
>  void kvm_riscv_gstage_mode_detect(void);
>
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index d9fe8be2a..e020b334a 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -337,35 +337,36 @@ int kvm_riscv_gstage_split_huge(struct kvm_gstage *=
gstage,
>         return 0;
>  }
>
> -void kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
> +bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
>                              pte_t *ptep, u32 ptep_level, enum kvm_riscv_=
gstage_op op)
>  {
>         int i, ret;
>         pte_t old_pte, *next_ptep;
>         u32 next_ptep_level;
>         unsigned long next_page_size, page_size;
> +       bool flush =3D false;
>
>         ret =3D gstage_level_to_page_size(gstage, ptep_level, &page_size)=
;
>         if (ret)
> -               return;
> +               return false;
>
>         WARN_ON(addr & (page_size - 1));
>
>         if (!pte_val(ptep_get(ptep)))
> -               return;
> +               return false;
>
>         if (ptep_level && !gstage_pte_leaf(ptep)) {
>                 next_ptep =3D (pte_t *)gstage_pte_page_vaddr(ptep_get(pte=
p));
>                 next_ptep_level =3D ptep_level - 1;
>                 ret =3D gstage_level_to_page_size(gstage, next_ptep_level=
, &next_page_size);
>                 if (ret)
> -                       return;
> +                       return false;
>
>                 if (op =3D=3D GSTAGE_OP_CLEAR)
>                         set_pte(ptep, __pte(0));
>                 for (i =3D 0; i < PTRS_PER_PTE; i++)
> -                       kvm_riscv_gstage_op_pte(gstage, addr + i * next_p=
age_size,
> -                                               &next_ptep[i], next_ptep_=
level, op);
> +                       flush |=3D kvm_riscv_gstage_op_pte(gstage, addr +=
 i * next_page_size,
> +                                                        &next_ptep[i], n=
ext_ptep_level, op);
>                 if (op =3D=3D GSTAGE_OP_CLEAR)
>                         put_page(virt_to_page(next_ptep));
>         } else {
> @@ -375,11 +376,13 @@ void kvm_riscv_gstage_op_pte(struct kvm_gstage *gst=
age, gpa_t addr,
>                 else if (op =3D=3D GSTAGE_OP_WP)
>                         set_pte(ptep, __pte(pte_val(ptep_get(ptep)) & ~_P=
AGE_WRITE));
>                 if (pte_val(*ptep) !=3D pte_val(old_pte))
> -                       gstage_tlb_flush(gstage, ptep_level, addr);
> +                       flush =3D true;
>         }
> +
> +       return flush;
>  }
>
> -void kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
> +bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
>                                   gpa_t start, gpa_t size, bool may_block=
)
>  {
>         int ret;
> @@ -388,6 +391,7 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage *=
gstage,
>         bool found_leaf;
>         unsigned long page_size;
>         gpa_t addr =3D start, end =3D start + size;
> +       bool flush =3D false;
>
>         while (addr < end) {
>                 found_leaf =3D kvm_riscv_gstage_get_leaf(gstage, addr, &p=
tep, &ptep_level);
> @@ -399,8 +403,8 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage *=
gstage,
>                         goto next;
>
>                 if (!(addr & (page_size - 1)) && ((end - addr) >=3D page_=
size))
> -                       kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> -                                               ptep_level, GSTAGE_OP_CLE=
AR);
> +                       flush |=3D kvm_riscv_gstage_op_pte(gstage, addr, =
ptep,
> +                                                        ptep_level, GSTA=
GE_OP_CLEAR);
>
>  next:
>                 addr +=3D page_size;
> @@ -412,9 +416,11 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage =
*gstage,
>                 if (!(gstage->flags & KVM_GSTAGE_FLAGS_LOCAL) && may_bloc=
k && addr < end)
>                         cond_resched_lock(&gstage->kvm->mmu_lock);
>         }
> +
> +       return flush;
>  }
>
> -void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, g=
pa_t end)
> +bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, g=
pa_t end)
>  {
>         int ret;
>         pte_t *ptep;
> @@ -422,6 +428,7 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gst=
age, gpa_t start, gpa_t end
>         bool found_leaf;
>         gpa_t addr =3D start;
>         unsigned long page_size;
> +       bool flush =3D false;
>
>         while (addr < end) {
>                 found_leaf =3D kvm_riscv_gstage_get_leaf(gstage, addr, &p=
tep, &ptep_level);
> @@ -433,11 +440,13 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *g=
stage, gpa_t start, gpa_t end
>                         goto next;
>
>                 addr =3D ALIGN_DOWN(addr, page_size);
> -               kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> -                                       ptep_level, GSTAGE_OP_WP);
> +               flush |=3D kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> +                                                ptep_level, GSTAGE_OP_WP=
);
>  next:
>                 addr +=3D page_size;
>         }
> +
> +       return flush;
>  }
>
>  void __init kvm_riscv_gstage_mode_detect(void)
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 2d3def024..8469ed932 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -23,13 +23,15 @@ static void mmu_wp_memory_region(struct kvm *kvm, int=
 slot)
>         phys_addr_t start =3D memslot->base_gfn << PAGE_SHIFT;
>         phys_addr_t end =3D (memslot->base_gfn + memslot->npages) << PAGE=
_SHIFT;
>         struct kvm_gstage gstage;
> +       bool flush;
>
>         kvm_riscv_gstage_init(&gstage, kvm);
>
>         spin_lock(&kvm->mmu_lock);
> -       kvm_riscv_gstage_wp_range(&gstage, start, end);
> +       flush =3D kvm_riscv_gstage_wp_range(&gstage, start, end);
>         spin_unlock(&kvm->mmu_lock);
> -       kvm_flush_remote_tlbs_memslot(kvm, memslot);
> +       if (flush)
> +               kvm_flush_remote_tlbs_memslot(kvm, memslot);
>  }
>
>  int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
> @@ -82,12 +84,17 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa,=
 phys_addr_t hpa,
>  void kvm_riscv_mmu_iounmap(struct kvm *kvm, gpa_t gpa, unsigned long siz=
e)
>  {
>         struct kvm_gstage gstage;
> +       bool flush;
>
>         kvm_riscv_gstage_init(&gstage, kvm);
>
>         spin_lock(&kvm->mmu_lock);
> -       kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false);
> +       flush =3D kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false)=
;
>         spin_unlock(&kvm->mmu_lock);
> +
> +       if (flush)
> +               kvm_flush_remote_tlbs_range(kvm, gpa >> PAGE_SHIFT,
> +                                           size >> PAGE_SHIFT);
>  }
>
>  void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
> @@ -99,10 +106,14 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct =
kvm *kvm,
>         phys_addr_t start =3D (base_gfn +  __ffs(mask)) << PAGE_SHIFT;
>         phys_addr_t end =3D (base_gfn + __fls(mask) + 1) << PAGE_SHIFT;
>         struct kvm_gstage gstage;
> +       bool flush;
>
>         kvm_riscv_gstage_init(&gstage, kvm);
>
> -       kvm_riscv_gstage_wp_range(&gstage, start, end);
> +       flush =3D kvm_riscv_gstage_wp_range(&gstage, start, end);
> +       if (flush)
> +               kvm_flush_remote_tlbs_range(kvm, start >> PAGE_SHIFT,
> +                                           (end - start) >> PAGE_SHIFT);
>  }
>
>  void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *me=
mslot)
> @@ -128,12 +139,16 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>         gpa_t gpa =3D slot->base_gfn << PAGE_SHIFT;
>         phys_addr_t size =3D slot->npages << PAGE_SHIFT;
>         struct kvm_gstage gstage;
> +       bool flush;
>
>         kvm_riscv_gstage_init(&gstage, kvm);
>
>         spin_lock(&kvm->mmu_lock);
> -       kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false);
> +       flush =3D kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false)=
;
>         spin_unlock(&kvm->mmu_lock);
> +       if (flush)
> +               kvm_flush_remote_tlbs_range(kvm, gpa >> PAGE_SHIFT,
> +                                           size >> PAGE_SHIFT);
>  }
>
>  void kvm_arch_commit_memory_region(struct kvm *kvm,
> @@ -231,17 +246,24 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kv=
m_gfn_range *range)
>  {
>         struct kvm_gstage gstage;
>         bool mmu_locked;
> +       bool flush;
>
>         if (!kvm->arch.pgd)
>                 return false;
>
>         kvm_riscv_gstage_init(&gstage, kvm);
>         mmu_locked =3D spin_trylock(&kvm->mmu_lock);
> -       kvm_riscv_gstage_unmap_range(&gstage, range->start << PAGE_SHIFT,
> -                                    (range->end - range->start) << PAGE_=
SHIFT,
> -                                    range->may_block);
> +
> +       flush =3D kvm_riscv_gstage_unmap_range(&gstage, range->start << P=
AGE_SHIFT,
> +                                            (range->end - range->start) =
<< PAGE_SHIFT,
> +                                            range->may_block);
> +
>         if (mmu_locked)
>                 spin_unlock(&kvm->mmu_lock);
> +
> +       if (flush)
> +               kvm_flush_remote_tlbs_range(kvm, range->start,
> +                                           range->end - range->start);
>         return false;
>  }
>
> @@ -557,11 +579,12 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>  {
>         struct kvm_gstage gstage;
>         void *pgd =3D NULL;
> +       bool flush =3D false;
>
>         spin_lock(&kvm->mmu_lock);
>         if (kvm->arch.pgd) {
>                 kvm_riscv_gstage_init(&gstage, kvm);
> -               kvm_riscv_gstage_unmap_range(&gstage, 0UL,
> +               flush =3D kvm_riscv_gstage_unmap_range(&gstage, 0UL,
>                         kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels), =
false);
>                 pgd =3D READ_ONCE(kvm->arch.pgd);
>                 kvm->arch.pgd =3D NULL;
> @@ -570,6 +593,9 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>         }
>         spin_unlock(&kvm->mmu_lock);
>
> +       if (flush)
> +               kvm_flush_remote_tlbs(kvm);
> +
>         if (pgd)
>                 free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage=
_pgd_size));
>  }
> --
> 2.43.0
>
