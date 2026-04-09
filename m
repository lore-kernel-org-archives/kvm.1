Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503B51F30A9
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 06:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775714599; cv=pass; b=OvD8220cmineKN5ls1s0OKpt+VibRkQDmLfF0JuSwVExTRpfz8ca0nMc3Ka22VI3CqromJVjOI+q91Rgo48WGOn0VurHrOULSdHn+X+C5U4JfVrrJRxlEB3KikDOXtagaVCsaWntEBGEXgs/EEIjVs3/vrvhvcznym2PrKJBWJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775714599; c=relaxed/simple;
	bh=AmeUVSI9xp7BBsOGi0wZvND1u7Vdcf+GEptHOvZa6AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkbIjXvspv4aKbhm7PHjDI2THbrtvMjOPyBxCa5NCUGUvuh1fi97GHDSl6BP9Roo7mXaA3sTx9lOGixk8ciPXiIQBOrzLKDKvxXQ2T2wW/f0NLUf5CYbs8rw1zPCdqCEBWOTrgYboQ0G/cgfMWjzCgHE+ACR05mBJtN5ZEyfQmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=BKOs1wGh; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BKOs1wGh"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a3d2824e4bso644100e87.3
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 23:03:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775714595; cv=none;
        d=google.com; s=arc-20240605;
        b=frpWVzqhTUig6brWrwzdsEnaNUcaNyx+Wig2fFURwSQ2UOAlzFhW2roRbTEOZDXSUR
         Ayx91Zqit8Kr1mVtO5PUJ4nuhQlpUwqM+2qefUwdgnmKpXtI8CXVHnLzCvm7EfTPdB6o
         2gWfVZrvcxzvj3vZtygCzHClU3oKO5OKMQhg7wiyWCRbezPm1BUFjBlSP/H1sJ4kmXNq
         Qt8TCKYRaFpxuZ6N3p43toXRbpIzEZcAKG2d2z5TDWE3DYmyBNPjABhjvIavCCQteExH
         VJTpxeKe/kkGoHwVNMVEKgq6S474ZlGP3g+VkH9/6bj+T6XcZVr7Vdkyjh67Y/2R+TS8
         MSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QgfMIwmza3zBePWSEjft/5gjBqA0GmY5rVKRgLC/y4g=;
        fh=f4dz+FL9ua7dHPEvBoUblya+IwClEe29eJ/K24c8nqQ=;
        b=MKLsc0tBgv6A6ZJQJrVISj5ThRACNqyFjvZTlol2yxCGLJHfg/Qri6xTVj8jZ578jj
         JF1KTRD7H4SPC0y70dxXpDFzd4WpEq0e5/2j1jpJA4DZeu9fV2shQaW3/e0BOHGsEufF
         9zHPs+6RrBIAFTQ6CWyR+fKcMUdBBKPwhzrTikffwRgIs8V3oKuXPwJDNIQdYbqsTR+g
         WrHnybmZa9ff0GGRbvjTEMBoOX2TC5+2szm1E8u1WmSv20uQ8PJmhvGg9SfLYPz5nedm
         LjuXGoJJW/AVVrrXaUHjMCRY4qM4szZwBwURZha3NBEeYCv/qImVnAndcIDoxqo0b3pU
         3mng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1775714595; x=1776319395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgfMIwmza3zBePWSEjft/5gjBqA0GmY5rVKRgLC/y4g=;
        b=BKOs1wGhOHLK4nnh53Ffdj79avyfTUDotWbcbDwX6QauI8rpXoaRPvPBjIM0QJW7jc
         mvpBfUNNl9E35DKPiy477QH/yhxLgtnge3EkUFldhcTaf9RL7Puyu20Z4mCU6sjJdFeO
         OYaV/FctqRae9QH4D7wG7B1tNMgr3VBzpcNxsKbc2wrIX7KmWvFjgot3OP9n90rhJo3G
         xSCumST1wnMMSy0OqekLnVDG6TsozJYPt5XizT3thM8wsHXQbvX61Xshbe4Py1rZyx04
         JD+hop8fmMyDcvXmjaB77OAdKrnFDPrU478dRYkhz3zOlWjX53jDfyT/d2lvBkUeFcro
         qhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775714595; x=1776319395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QgfMIwmza3zBePWSEjft/5gjBqA0GmY5rVKRgLC/y4g=;
        b=KiOS4cG2Q7XFY3kUJljOT7xZT/I7dVGwY39n0xrITmfHPM6lp/riCVGb95OEE/WAKT
         HoPeRGscpEWfZxqZcdzgtcR/tjU7ddFO1zLnUD6T/G/LHk2op1NKM+merBS1YzqJ6pF4
         KNG6qvUkY5JFrGOmrlUKBDEnunsYOCGMcDqcr5eatWZ9MrC+crLwPWiQB68TCWHfkKW3
         cPg973CrqnmpCt3MOXTi7ZGNLXFQkO0tHNTxVlzxSI/5W6m+I+Omz/0TVyERvMjN2+7B
         HNwv+k/SsoH7w5D9Bzj6DpNPwNt44qsWaifJ2L6jEsoLaO/eDkI70jgZZa2oPbSSeez2
         pIng==
X-Forwarded-Encrypted: i=1; AJvYcCXcTrPKz890gqxQN3IkD1k7xqoB1z/s/ofKTNCAi2HmE3ZvmKo+gXzWq1/DgyD+QbODme8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdZuuLcZiXpbUngpLTJTX9vtu5bomRycl4xH9n6gPL9pcYOU/5
	gdG+VUX2G9PvKcNNVwhloZ/tYKo/PkbqtuVYxE7TrJqornnhWfbD5E9gE+wa5ovn69yO2Y4d6nz
	wkZBaO/Tjo74mIv61abRKcl4v+PJxCagRAVCJvfV2jg==
X-Gm-Gg: AeBDievS2wFqBU6yaWFk7tX7E7T+IWeGi9HvZLuCis4UrXlJ/+cHMtWmBKiGY5MuDaJ
	CwoG/t1nrghMw9oHteO9NrQ3iC+KZJdhDkq7qeGOhmPTcBsMKqlSnVys2aiJ+jBKJ87Dnwi6j0t
	45RSgLmuAAVLsg1RIjebMvemVwa9K3FhiloGFM2VrrLpN3KTu7UohT5iPOSg9B0q4r2jHYhWhjI
	I41IpKsXsuzwNaloUfUkT27JnYZ6B4R21UZtsQEbaxHDZjcur5PKdMVZ/6qsBZNyyUg9Eyohva0
	NbBZJ0HqPcHGSqv8ZP7Ib2MAbwLvuUwv+uyZm7XP
X-Received: by 2002:a05:6512:ad4:b0:5a2:c1b5:f70d with SMTP id
 2adb3069b0e04-5a3e7a16afcmr652273e87.6.1775714595238; Wed, 08 Apr 2026
 23:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408161133.244669-1-tjytimi@163.com>
In-Reply-To: <20260408161133.244669-1-tjytimi@163.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 9 Apr 2026 11:33:02 +0530
X-Gm-Features: AQROBzCd0e5Nq8zWa95qDN95DDLMnatiDUmUrq6-JgL3DTMKQgJeQ2iYycRLjEo
Message-ID: <CAK9=C2Wjr-N8H+xnXAw5RFRsgiDqp=hoB2y2RuzGX079Y_RLCQ@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: KVM: Batch stage-2 remote TLB flushes
To: Jinyu Tang <tjytimi@163.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 9:43=E2=80=AFPM Jinyu Tang <tjytimi@163.com> wrote:
>
> KVM RISC-V triggers a TLB flush for every single stage-2 PTE
> modification (unmap or write-protect) now. Although KVM coalesces the
> hardware IPIs, the software overhead of executing the flush work
> for every 4K page is large, especially during dirty page tracking.
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
>         # time ./demand_paging_test -b 1G -v 4
>    - Total execution time reduced from ~2m33s to ~2m25s
> 2. dirty_log_perf_test (1GB memory)
>         # ./dirty_log_perf_test -b 1G -v 4
>         - "Clear dirty log time" per iteration dropped significantly from
>      ~3.02s to ~0.19s
>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> ---
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
>  arch/riscv/include/asm/kvm_gstage.h |  6 ++---
>  arch/riscv/kvm/gstage.c             | 35 +++++++++++++++----------
>  arch/riscv/kvm/mmu.c                | 40 ++++++++++++++++++++++-------
>  3 files changed, 56 insertions(+), 25 deletions(-)

This patch conflicts with other patches in the riscv_kvm_next
branch at https://github.com/kvm-riscv/linux.git

Please rebase on latest riscv_kvm_next and send v4 ?

Regards,
Anup

>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm=
/kvm_gstage.h
> index 595e21831..b003a07f1 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -59,13 +59,13 @@ enum kvm_riscv_gstage_op {
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
> index b67d60d72..f008ccf1d 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -209,35 +209,36 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gs=
tage,
>         return kvm_riscv_gstage_set_pte(gstage, pcache, out_map);
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
>         ret =3D gstage_level_to_page_size(ptep_level, &page_size);
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
>                 ret =3D gstage_level_to_page_size(next_ptep_level, &next_=
page_size);
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
> @@ -247,11 +248,13 @@ void kvm_riscv_gstage_op_pte(struct kvm_gstage *gst=
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
> @@ -260,6 +263,7 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage *=
gstage,
>         bool found_leaf;
>         unsigned long page_size;
>         gpa_t addr =3D start, end =3D start + size;
> +       bool flush =3D false;
>
>         while (addr < end) {
>                 found_leaf =3D kvm_riscv_gstage_get_leaf(gstage, addr, &p=
tep, &ptep_level);
> @@ -271,8 +275,8 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage *=
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
> @@ -284,9 +288,11 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage =
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
> @@ -294,6 +300,7 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gst=
age, gpa_t start, gpa_t end
>         bool found_leaf;
>         gpa_t addr =3D start;
>         unsigned long page_size;
> +       bool flush =3D false;
>
>         while (addr < end) {
>                 found_leaf =3D kvm_riscv_gstage_get_leaf(gstage, addr, &p=
tep, &ptep_level);
> @@ -305,12 +312,14 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *g=
stage, gpa_t start, gpa_t end
>                         goto next;
>
>                 if (!(addr & (page_size - 1)) && ((end - addr) >=3D page_=
size))
> -                       kvm_riscv_gstage_op_pte(gstage, addr, ptep,
> -                                               ptep_level, GSTAGE_OP_WP)=
;
> +                       flush |=3D kvm_riscv_gstage_op_pte(gstage, addr, =
ptep,
> +                                                        ptep_level, GSTA=
GE_OP_WP);
>
>  next:
>                 addr +=3D page_size;
>         }
> +
> +       return flush;
>  }
>
>  void __init kvm_riscv_gstage_mode_detect(void)
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 0b75eb2a1..b9a57f0a9 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -23,6 +23,7 @@ static void mmu_wp_memory_region(struct kvm *kvm, int s=
lot)
>         phys_addr_t start =3D memslot->base_gfn << PAGE_SHIFT;
>         phys_addr_t end =3D (memslot->base_gfn + memslot->npages) << PAGE=
_SHIFT;
>         struct kvm_gstage gstage;
> +       bool flush;
>
>         gstage.kvm =3D kvm;
>         gstage.flags =3D 0;
> @@ -30,9 +31,10 @@ static void mmu_wp_memory_region(struct kvm *kvm, int =
slot)
>         gstage.pgd =3D kvm->arch.pgd;
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
> @@ -88,6 +90,7 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, p=
hys_addr_t hpa,
>  void kvm_riscv_mmu_iounmap(struct kvm *kvm, gpa_t gpa, unsigned long siz=
e)
>  {
>         struct kvm_gstage gstage;
> +       bool flush;
>
>         gstage.kvm =3D kvm;
>         gstage.flags =3D 0;
> @@ -95,8 +98,12 @@ void kvm_riscv_mmu_iounmap(struct kvm *kvm, gpa_t gpa,=
 unsigned long size)
>         gstage.pgd =3D kvm->arch.pgd;
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
> @@ -108,13 +115,17 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct=
 kvm *kvm,
>         phys_addr_t start =3D (base_gfn +  __ffs(mask)) << PAGE_SHIFT;
>         phys_addr_t end =3D (base_gfn + __fls(mask) + 1) << PAGE_SHIFT;
>         struct kvm_gstage gstage;
> +       bool flush;
>
>         gstage.kvm =3D kvm;
>         gstage.flags =3D 0;
>         gstage.vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
>         gstage.pgd =3D kvm->arch.pgd;
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
> @@ -140,6 +151,7 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>         gpa_t gpa =3D slot->base_gfn << PAGE_SHIFT;
>         phys_addr_t size =3D slot->npages << PAGE_SHIFT;
>         struct kvm_gstage gstage;
> +       bool flush;
>
>         gstage.kvm =3D kvm;
>         gstage.flags =3D 0;
> @@ -147,8 +159,11 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>         gstage.pgd =3D kvm->arch.pgd;
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
> @@ -253,9 +268,11 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm=
_gfn_range *range)
>         gstage.flags =3D 0;
>         gstage.vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
>         gstage.pgd =3D kvm->arch.pgd;
> -       kvm_riscv_gstage_unmap_range(&gstage, range->start << PAGE_SHIFT,
> -                                    (range->end - range->start) << PAGE_=
SHIFT,
> -                                    range->may_block);
> +       if (kvm_riscv_gstage_unmap_range(&gstage, range->start << PAGE_SH=
IFT,
> +                                        (range->end - range->start) << P=
AGE_SHIFT,
> +                                        range->may_block))
> +               kvm_flush_remote_tlbs_range(kvm, range->start,
> +                                           range->end - range->start);
>         return false;
>  }
>
> @@ -579,6 +596,7 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>  {
>         struct kvm_gstage gstage;
>         void *pgd =3D NULL;
> +       bool flush =3D false;
>
>         spin_lock(&kvm->mmu_lock);
>         if (kvm->arch.pgd) {
> @@ -586,13 +604,17 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>                 gstage.flags =3D 0;
>                 gstage.vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
>                 gstage.pgd =3D kvm->arch.pgd;
> -               kvm_riscv_gstage_unmap_range(&gstage, 0UL, kvm_riscv_gsta=
ge_gpa_size, false);
> +               flush =3D kvm_riscv_gstage_unmap_range(&gstage, 0UL,
> +                                                    kvm_riscv_gstage_gpa=
_size, false);
>                 pgd =3D READ_ONCE(kvm->arch.pgd);
>                 kvm->arch.pgd =3D NULL;
>                 kvm->arch.pgd_phys =3D 0;
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
>
> --
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv
