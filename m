Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA33546F5
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 05:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476419; cv=pass; b=ZsXeGqckSY1JKD8sVcgsrjaAHjGWN8lLkmpovyat8YMKJ42PeS4k2PYgIoMeGIzlEYt2feBKROAn49QmcaBkR1SoqCBDsKVoGc91YT/io67Ze5q67Le/XS3TzQjk7RNojyIs8FPwJZEx2P1ex1QsRksqiWnbo6H8QlXwMtFyPkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476419; c=relaxed/simple;
	bh=yCOxsCP5FjswD6/JD3lOyb++wlj0QaCK82fMme6NfvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTLOuhoI8e7pv2cD9l5zeMKEiuFAJGV1rkL7nbpulq5HZQqzU+usJZKomUoiMNkO86PIyW5VAKCkTq+WWC6m07JghGHkBJ1YDplNU43J6PAASqAuxGODutMIp6awQotlNHz5M4+pPnMmVdn5wP5N4b2sksI9agsjn5T7xapD1tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=WZjdo872; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="WZjdo872"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso296945f8f.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 22:40:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785476416; cv=none;
        d=google.com; s=arc-20260327;
        b=haUgI9htSQ/gYhGgRYEhN3Gm03C6toVCO/xt+4oxB7YRz23bfxwmHwcoNx+Y0Qn9NK
         W+w8k9Y9qhYHgmUZZXLgSzTketWyNYNyON5jPmY2X+/NqYXf7z4LvD+sFb73H2i+KNGV
         497d4sA8mzZtVSj1FdTEiO5Bt7SbfdS9EoQ0RPHdNxW7jrMilrE1tBzLTLbyUmAKRHJG
         EzyDMZ2gGqSQFcO49lqraZ4+GMt2x63W3wtfE7ew3a6Zpn1BkxfxLVM6k5793S415abz
         zlwSTOOTrvi7kI28clSTUlzWvPL1gdiM6RptxkVQRudU4GRkEWkZJ+xu2G+NzI9ZM6iB
         vTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0omocJjS8eqmheD3jm/ULSwl3AEEjllC2DI99vOpdYo=;
        fh=TqkDo7HJm6C2bTHYqbzn7b/i6oYTm+CMOZGiIKAd8p4=;
        b=h2Syqbvzr2EN7+vXB9zt3H/FUi3P4OE6sQaMNqt8/6QrXEPXi0CHdp3zIGrQPvjLbL
         bQ29zUUkfQ/BeT58OUj6I5wNmgeTLJF6DbHlU5xKdYj04HjqEBvkPX7SsHaL1CTK1jgH
         xR6jbb2/KYUXG3gQbRewv2Av/cn68Ow/2JP/hxKLu4k/TEeGsP8y6DPml5+AgCjMipyO
         m3SJhl7FAcm2BPdJBPYJ2rNuLUjfo+vzs/mqMhpznwWW5ckoLxTGxwF9aHcNDewgtVwo
         jEjYYuaWsf9TqtEpy35e8OF/0EEP1qMekISQ1OZZJw9Rnk99j9qb3O3brtgLy+66gbXq
         wxFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785476416; x=1786081216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0omocJjS8eqmheD3jm/ULSwl3AEEjllC2DI99vOpdYo=;
        b=WZjdo872dWruBY2CEmMaGX4/0bfVa+YP5A5PwvmAbBJp/b90vXdzKubteFFf9Ig9nv
         P6DNrBOdXD22CtH07cTAUZsIdTP4pxL1KPh+4Y1bZxrIpPx6Y4IZjAxONSblMrTX7wJ0
         On878Rh427iX6fS8to1RGQfnm+fOZ5RrRVLMetFe2gM0LAYDEjB89EZ2wKpmuIsL1udq
         xTtRPkP83pBTvZM2HJYidKmMaP0QA2B3q3gxE+ZbXSJQNjoVpi6GegpAOo765COJIkw6
         5aiXKXoEmCrvIY+1we0CmAH+cjJbAeM6qrTFH/C+weNfIwJieidV00dsUCZ4IkF/XcKy
         9QEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785476416; x=1786081216;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0omocJjS8eqmheD3jm/ULSwl3AEEjllC2DI99vOpdYo=;
        b=absOvh2VFWOFsKBVOf0c+mooyA4dc2nX685Xo+yTFhJQMYkMUqso7mkgOl7JaLIIye
         WW6vfwW20gquzm9lflTd1jLWp8eRXyJnkdUSLHVXM+/xjFFAjs9Z6GKnOrUlXESYxNwx
         jgUyvx9DB+Fh0X2zICoeKLWsTKKGSTOUB/IiOflzgIlpeRhFOJL6xMHjE1i9TVLUYzOG
         /IFXn+9czFNB/vvlxYn3tHLH6hMBXCnOFCgzfugDsZJPFZ2bqkjh8tPjs4WDk5MOlwZ8
         sZPFP4E6Wo7wNV/CCyyDA+tc3ynz2MhOS3+/RZ47CaaXv8ArMhtR88Q9Ye+KETCqYZ11
         Pjdg==
X-Gm-Message-State: AOJu0YxsR6XimsOsrfgYjTMxHjrzZcOQPdMRHb1CMtOa2Fi6fETdFg5S
	qvQRSt4DaDEctJbtm6gkLVzyroPdxchEy7AC9ZjJnCxBC8ZsI8ts0UtcveHkcOtoBLolBpPziwD
	YSbt76gwdscIhiC/LAxqzS9I3yGLQAzicuoNQhENsNw==
X-Gm-Gg: AR+sD13qPCqU5reV6ly2O9oyipQx6P2aithOMzBxSeHrYkdVNH4C/vaM9uXEJpier9y
	NGJk6oNMCPjXfJIUHd2N0Cbfa0GJoq9+b/YiipfPuUHWoTdEP7IDgc8htrPK3nfkv8DRrNRaYjl
	fyTd76sFqNszjag/pA5pSvznUJqtQdj34Zq0ekx0zl7iBUnm5xn2b7VTnEuItbW1MGg7vDaSV03
	xu5A6wVOPdZ8GE3FghgZHMk0/TJNj3qzmCgqANpC7CnLqpNxzcK1lA6xXmEygaoIwSUSPmDsl9J
	glillKlItM4kCvq0mJObXAiuK33di9YDpcdiv4vEoY6gVD31IVclKjgWiVD/9yKPMUIGEj2eVja
	chxrGc8BnFfx/TUI2OVHdvsUP+av4csOKp1AlF4X/nYVWpgbMw2TrHzQN+YxSUzf2PHp8jpaEqV
	s=
X-Received: by 2002:a05:6000:615:b0:47f:8866:bd6a with SMTP id
 ffacd0b85a97d-47fd2adb314mr1566410f8f.19.1785476415658; Thu, 30 Jul 2026
 22:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701120954.129873-1-wang.yechao255@zte.com.cn> <20260701120954.129873-3-wang.yechao255@zte.com.cn>
In-Reply-To: <20260701120954.129873-3-wang.yechao255@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 31 Jul 2026 11:10:03 +0530
X-Gm-Features: AUfX_mx1Mzg1rGHueKOelxZjzflxPV7482x4d_OjLboj8Tn5ZoAi5d4b2o2gs0c
Message-ID: <CAAhSdy2AKgcpEokcx2pVWUeB+kS0FAXX1Y2MkJoisqnVZmRO+A@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] RISC-V: KVM: Split huge pages when dirty logging
 is enabled
To: Wang Yechao <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 5:41=E2=80=AFPM Wang Yechao <wang.yechao255@zte.com.=
cn> wrote:
>
> Split huge pages eagerly when enabling dirty logging. The goal is to
> avoid doing it while faulting on write-protected pages, which
> negatively impacts guest performance.
>
> The benefits of eager page splitting are the same as in x86 and arm64,
> added with commit a3fe5dbda0a4 ("KVM: x86/mmu: Split huge pages mapped
> by the TDP MMU when dirty logging is enabled") and commit e7bf7a490c68
> ("KVM: arm64: Split huge pages when dirty logging is enabled")
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---
>  arch/riscv/include/asm/kvm_gstage.h |  6 +--
>  arch/riscv/kvm/gstage.c             | 23 ++++++---
>  arch/riscv/kvm/mmu.c                | 76 +++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+), 10 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm=
/kvm_gstage.h
> index 21e2019df0cf5..f726279780177 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -64,9 +64,9 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage=
,
>                               bool page_rdonly, bool page_exec,
>                               struct kvm_gstage_mapping *out_map);
>
> -int kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
> -                               struct kvm_mmu_memory_cache *pcache,
> -                               gpa_t addr, u32 target_level, bool flush)=
;
> +bool kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
> +                                struct kvm_mmu_memory_cache *pcache,
> +                                gpa_t addr, u32 target_level, bool flush=
);
>
>  enum kvm_riscv_gstage_op {
>         GSTAGE_OP_NOP =3D 0,      /* Nothing */
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index c4c3b79567f10..4815233f9788d 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -303,19 +303,20 @@ static inline unsigned long make_child_pte(unsigned=
 long huge_pte, int index,
>         return child_pte;
>  }
>
> -int kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
> -                               struct kvm_mmu_memory_cache *pcache,
> -                               gpa_t addr, u32 target_level, bool flush)
> +bool kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
> +                                struct kvm_mmu_memory_cache *pcache,
> +                                gpa_t addr, u32 target_level, bool flush=
)
>  {
>         u32 current_level =3D gstage->pgd_levels - 1;
>         pte_t *next_ptep =3D (pte_t *)gstage->pgd;
>         unsigned long huge_pte, child_pte;
>         unsigned long child_page_size;
> +       bool need_flush =3D false;
>         pte_t *ptep;
>         int i, ret;
>
>         if (!pcache)
> -               return -ENOMEM;
> +               return false;
>
>         while(current_level > target_level) {
>                 ptep =3D (pte_t *)&next_ptep[gstage_pte_index(gstage, add=
r, current_level)];
> @@ -333,27 +334,35 @@ int kvm_riscv_gstage_split_huge(struct kvm_gstage *=
gstage,
>
>                 ret =3D gstage_level_to_page_size(gstage, current_level -=
 1, &child_page_size);
>                 if (ret)
> -                       return ret;
> +                       return need_flush;
>
>                 next_ptep =3D kvm_mmu_memory_cache_alloc(pcache);
>                 if (!next_ptep)
> -                       return -ENOMEM;
> +                       return need_flush;
>
>                 for (i =3D 0; i < PTRS_PER_PTE; i++) {
>                         child_pte =3D make_child_pte(huge_pte, i, child_p=
age_size);
>                         set_pte((pte_t *)&next_ptep[i], __pte(child_pte))=
;
>                 }
>
> +               /*
> +                * Ensure the writes to the child PTEs are visible before
> +                * linking the new page table to the parent PTE.
> +                */
> +               smp_wmb();
> +
>                 set_pte(ptep, pfn_pte(PFN_DOWN(__pa(next_ptep)),
>                                 __pgprot(_PAGE_TABLE)));
>
>                 if (flush)
>                         gstage_tlb_flush(gstage, current_level, addr);
> +               else
> +                       need_flush =3D true;
>
>                 current_level--;
>         }
>
> -       return 0;
> +       return need_flush;
>  }
>
>  bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 9cf69bc28b9c5..363238efaedb4 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -97,6 +97,62 @@ void kvm_riscv_mmu_iounmap(struct kvm *kvm, gpa_t gpa,=
 unsigned long size)
>                                             size >> PAGE_SHIFT);
>  }
>
> +static bool need_topup_split_caches_or_resched(struct kvm *kvm, int coun=
t)
> +{
> +       struct kvm_mmu_memory_cache *cache;
> +
> +       if (need_resched() || rwlock_needbreak(&kvm->mmu_lock))
> +               return true;
> +
> +       cache =3D &kvm->arch.pgd_split_page_cache;
> +       return kvm_mmu_memory_cache_nr_free_objects(cache) < count;
> +}
> +
> +static bool mmu_split_huge_pages(struct kvm_gstage *gstage,
> +                                phys_addr_t start, phys_addr_t end)
> +{
> +       struct kvm *kvm =3D gstage->kvm;
> +       struct kvm_mmu_memory_cache *pcache =3D &kvm->arch.pgd_split_page=
_cache;
> +       phys_addr_t addr =3D ALIGN_DOWN(start, PMD_SIZE);
> +       phys_addr_t last_flush_gfn =3D addr >> PAGE_SHIFT;
> +       int count =3D gstage->pgd_levels;
> +       bool flush =3D false;
> +       int ret;
> +
> +       lockdep_assert_held_write(&kvm->mmu_lock);
> +
> +       while (addr < end) {
> +               if (need_topup_split_caches_or_resched(kvm, count)) {
> +                       if (flush) {
> +                               kvm_flush_remote_tlbs_range(kvm, last_flu=
sh_gfn,
> +                                         (addr >> PAGE_SHIFT) - last_flu=
sh_gfn);
> +                               last_flush_gfn =3D addr >> PAGE_SHIFT;
> +                               flush =3D false;
> +                       }
> +
> +                       write_unlock(&kvm->mmu_lock);
> +                       cond_resched();
> +
> +                       ret =3D kvm_mmu_topup_memory_cache(pcache, count)=
;
> +                       if (ret) {
> +                               kvm_err("Failed to toup split page cache\=
n");
> +                               write_lock(&kvm->mmu_lock);
> +                               return flush;
> +                       }
> +                       write_lock(&kvm->mmu_lock);
> +               }
> +
> +               if (!kvm->arch.pgd)
> +                       return flush;
> +
> +               flush |=3D kvm_riscv_gstage_split_huge(gstage, pcache, ad=
dr, 0, false);
> +
> +               addr +=3D PMD_SIZE;
> +       }
> +
> +       return flush;
> +}
> +
>  void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
>                                              struct kvm_memory_slot *slot=
,
>                                              gfn_t gfn_offset,
> @@ -151,6 +207,25 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>                                             size >> PAGE_SHIFT);
>  }
>
> +static void mmu_split_memory_region(struct kvm *kvm, int slot)
> +{
> +       struct kvm_memslots *slots =3D kvm_memslots(kvm);
> +       struct kvm_memory_slot *memslot =3D id_to_memslot(slots, slot);
> +       phys_addr_t start =3D memslot->base_gfn << PAGE_SHIFT;
> +       phys_addr_t end =3D (memslot->base_gfn + memslot->npages) << PAGE=
_SHIFT;
> +       struct kvm_gstage gstage;
> +       bool flush;
> +
> +       kvm_riscv_gstage_init(&gstage, kvm);
> +
> +       write_lock(&kvm->mmu_lock);
> +       flush =3D mmu_split_huge_pages(&gstage, start, end);
> +       write_unlock(&kvm->mmu_lock);
> +
> +       if (flush)
> +               kvm_flush_remote_tlbs_memslot(kvm, memslot);
> +}
> +
>  void kvm_arch_commit_memory_region(struct kvm *kvm,
>                                 struct kvm_memory_slot *old,
>                                 const struct kvm_memory_slot *new,
> @@ -164,6 +239,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>                 if (kvm_dirty_log_manual_protect_and_init_set(kvm))
>                         return;
>                 mmu_wp_memory_region(kvm, new->id);
> +               mmu_split_memory_region(kvm, new->id);
>         }
>  }
>
> --
> 2.43.5
>

Make sure this works with 1G hugepages.

Otherwise, it looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup
