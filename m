Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B56A304BA3
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775110305; cv=pass; b=lF3vM3m9fmvD8NM5SReme9d24PhM95VT4OviKw+suPz57EbswIErupZ0s/L88FaKOF/+J1enEdUotgnnyV61yk1LmAl/Z3XGCn90R9iui3h7AhO12ukLb1mGnS6NS3EasKJ8yeRl0Atp0tVhrBXKT4NQQYWQStIgzfy0P53lT8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775110305; c=relaxed/simple;
	bh=2inAwwmxvMsOD0dQSQt7PqpasNCk/jY+ou5JuFEU6jI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNfWupNJL2BtCsyefIHQ3l2NBW1VOf5V+vycyFwgAiQMvajvNRPeRbe4Bo6tgzkvFyXPtQcxnFbgc4VnYDsF3Iv3Fy3NFYazn+bFbghZMZPhwCQUniBIsftRVNOPNclS+wphfG6p8UTk5QcdBH1086JMugFNzSneCRb0zlcgIgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=0GHZnFvx; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="0GHZnFvx"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-679f6ee3fb0so185053eaf.2
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 23:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775110303; cv=none;
        d=google.com; s=arc-20240605;
        b=SfUGsfiU0GoOGf5c9yY8L787I2sxVp9NgGgpnVC+FwV8HCh+SOIRjnp25l4X9yfwVr
         nXfGr8LmK9gJkDca56Mje26ug5/aW/+FRrUU+sGT2X6L2rZqB1WaICXlwfYWnP81bC1e
         s5FRSlFY3rNqvEPj9jdEJSxprga3NJ9Vmoe2KshqsYL5pVN/qGUAkNj8MnSt8D50kqR9
         fgiRxxU/hVQswtmQhHpO4QAcgm0hBFo0+pVhSYPQh5C2OLr26LPgHX6NTTOhB4g8f+36
         O7J/F+u3qSw/Ya2ecpBEbJ3ANbYH2E96tNK63jFXSpth6FW0t1ljs+0oZAHI2xdeHFs2
         +mcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pL1U1X8L0MBeaAtFAdao9wMT8iVJB+/YlV5xVdfvBD8=;
        fh=jfbHnI0DYY78QN11dUZrSd+YVwKTenvU0Yrzd+kbEUg=;
        b=Tk4NX6jrkwXTWjoPDFhtrwHWDZuAzdOCgEecIu0hd4UrgNJfn00ZyrxKnq/hc8w3Qo
         dsD/xg6URH5buqU2hewpqYIcPt1XEHDW1hNQVzrhLHsJaNrfaBnPxI0bLaxVV9ptzIja
         xkGNgv3u8AvFBLmzls5Xro4s+srTH0Dk2Cv2kMXNp7zi5kyI96DYiTJDBwwS3HyNZrTg
         1IFF/Y2uPxKk71G2jsKMkcjemz0p7EuT7/nBODREMObXRr4B15PqqWZ6zKFUMl2Ib09m
         QowJy9tibZBS6vVm3OTD6pHC5F8dOQU7MubRFlw9phpW3oqakP9sTJjPIH0sHLuif9qt
         I1kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1775110303; x=1775715103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL1U1X8L0MBeaAtFAdao9wMT8iVJB+/YlV5xVdfvBD8=;
        b=0GHZnFvxMLThlqB+FRRyWnAYuIj1jiXkQkynbF41d/308d7bIXR1YWHO95HDIU1pRA
         ajRPGZSKXC39acq/V/aHyKvLM0IgPtiN+PokXxMRWfXUS7c2zQI+Q1CDC1CungeEigb/
         so2edndYZro3GAHe9urXgaUqYgQyU/T0rloA51WjSIiPSJMCZoBHYPdCF6Ul2RFVA+9f
         O+ib1vJ4/k14LhuvpuXyft5Uy2MR9sQ+sgdKTagQu0j+UOfRnqmQQmuw7kELYyw+z4vC
         gdjgynx4YIVxghdhtPj5Rwcnp6LUJ6O5dsKw/8sfZLC4dEpH11T04yPwzOMHZDDE1mRN
         3XSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775110303; x=1775715103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pL1U1X8L0MBeaAtFAdao9wMT8iVJB+/YlV5xVdfvBD8=;
        b=HNnfms/Rx8YKQxNtSirSfg9dnYo7jFH9JOcNo1vx+GRtoIo5ZnnROm03SwdSx2lo0u
         zAU5UhBzL0Uo9wMCCqGASSn7K+qSbFlvdZLiTgQwPDRe8NNSFXSyObQhI/efVuKWuwji
         dIJ75lwb5hSD3gl0/01Xuq68S5wJKvNRVtZqd6QG1uYa5V720OTxH4V2Dkm6sG5kZ6OU
         /vZvP/p3vVq3zMKzhNb9Mc3il89gMvUI8sSfxaC3b5WVglKS4LB7uKrkf1bnmvolFDPG
         c+XEmHAYueAvNB0EyFj9+CHj45AEDWIyC81bvXgJ1AzTUtQEaVTqJkr+gpncfiFblAjQ
         h7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUoUv5KWrkdz7kpDKhBdB7thzMA71QR8ID/LUtjvEbUbxB5uAmNIO2nu8TVxTR8Gka6pSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy1My8sl6YXoEVwUzm+giKWNyJguzZ7TbklZtwxhGX/pK6gFhq
	Emxm5AoPBbSCHTGAnZg9qprQuhsQdBMsSP8Sj634k7zZz6BTePBnqjZWGZrl9AEIh9+axvjlYA4
	nWTt4Nhk8bqCTG2sAxUJXjZDapIfFjDtwE2HGlPAYvw==
X-Gm-Gg: ATEYQzyq3WPtLjWadTiFOeH12hReP4TLLGH5u3zAnsvnDT4lC6vh82Dsm323TnbxyYA
	D4VqFYSlpLL/z2AEgOufnN245gFc5r3gdWatPBLqUWguNdBuzFAu4UvCtNXebTcv3EuHJXCO7JU
	WYV252mO0gtzSCgqtn/S9YvOtOXQrpzZtgKQ9oTUgUrNaQp3ux71EqyG9p3wPsbVbZYN68tBUSu
	VHeg41scS3JOTCO8114cpQV5PqSKk4iBQA+pmKg63xqwdiSdfrU/HOxUiknq6fvbBRCgMI0pyRG
	vm0n4b63bFSVEM9wyYKOEyBKS+Q4KxFH/icLOA8o95D5ySl5aIc1LYyLUrqk4e+lscIbg2VKfMH
	nV4oxbNwowoLs36I7I61JtsrNcqc=
X-Received: by 2002:a05:6820:80f:b0:67d:f679:16de with SMTP id
 006d021491bc7-67fabbeceb2mr3288061eaf.5.1775110302955; Wed, 01 Apr 2026
 23:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318123534.2166919-1-tjytimi@163.com>
In-Reply-To: <20260318123534.2166919-1-tjytimi@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 2 Apr 2026 11:41:31 +0530
X-Gm-Features: AQROBzA_0uVWEd5VmqoQYcu3tw-iMEkq_FSLEaVnn8kAhXRxULe8ZSAIj4S8i4M
Message-ID: <CAAhSdy2PqSUA-X1tfVLe7ZDCvPQgrgJ7gk5yZLVZgYh7C45S9Q@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: KVM: Batch stage-2 remote TLB flushes
To: Jinyu Tang <tjytimi@163.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 6:05=E2=80=AFPM Jinyu Tang <tjytimi@163.com> wrote:
>
> KVM RISC-V triggers a TLB flush for every single stage-2 PTE
> modification (unmap or write-protect) now. Although KVM coalesces the
> hardware IPIs, the software overhead of executing the flush work
> for every 4K page is large, especially during dirty page tracking.
>
> Following the approach used in x86 and arm64, this patch optimizes
> the MMU logic by making the PTE manipulation functions return a boolean
> indicating if a leaf PTE was actually changed. The outer MMU functions
> bubble up this flag to batch the remote TLB flushes. This change makes
> the generic KVM MMU callbacks (e.g., `kvm_unmap_gfn_range()`) actually
> effective by returning the true flush requirement rather than `false`.
>
> Consequently, the flush operation is executed only once per batch.
> Moving it outside of the `mmu_lock` also reduces lock contention.
> For directory pages, we keep the synchronous flush to ensure safety.
>
> Tested with tools/testing/selftests/kvm on a 4-vCPU guest (Host
> environment: QEMU 10.2.1 RISC-V)
> 1. demand_paging_test (1GB memory)
>         # time ./demand_paging_test -b 1G -v 4
>    - Total execution time reduced from ~2m33s to ~2m25s
> 2. dirty_log_perf_test (1GB memory)
>         # ./dirty_log_perf_test -b 1G -v 4
>         - "Clear dirty log time" per iteration dropped significantly from
>      ~3.02s to ~0.20s
>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> ---
> v1 -> v2:
> Changes in v2:
> - Fixed alignment issues in multi-line function calls supported by
>   Nutty Liu.
>
>  arch/riscv/include/asm/kvm_gstage.h |  6 ++--
>  arch/riscv/kvm/gstage.c             | 46 +++++++++++++++++++----------
>  arch/riscv/kvm/mmu.c                | 38 +++++++++++++++++-------
>  3 files changed, 62 insertions(+), 28 deletions(-)
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
> index b67d60d72..798719ac1 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -209,49 +209,59 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gs=
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
> -               if (op =3D=3D GSTAGE_OP_CLEAR)
> +                       flush |=3D kvm_riscv_gstage_op_pte(gstage, addr +=
 i * next_page_size,
> +                                                        &next_ptep[i], n=
ext_ptep_level, op);
> +               if (op =3D=3D GSTAGE_OP_CLEAR) {
> +                       gstage_tlb_flush(gstage, ptep_level, addr);
> +                       flush =3D false;
>                         put_page(virt_to_page(next_ptep));
> +               }

gstage_tlb_flush() should not be called for non-leaf PTEs.

Only "flush |=3D kvm_riscv_gstage_op_pte(...)" is sufficient over here.

>         } else {
>                 old_pte =3D *ptep;
>                 if (op =3D=3D GSTAGE_OP_CLEAR)
>                         set_pte(ptep, __pte(0));
>                 else if (op =3D=3D GSTAGE_OP_WP)
>                         set_pte(ptep, __pte(pte_val(ptep_get(ptep)) & ~_P=
AGE_WRITE));
> -               if (pte_val(*ptep) !=3D pte_val(old_pte))
> -                       gstage_tlb_flush(gstage, ptep_level, addr);
> +               if (pte_val(*ptep) !=3D pte_val(old_pte)) {
> +                       if (gstage->flags & KVM_GSTAGE_FLAGS_LOCAL)
> +                               gstage_tlb_flush(gstage, ptep_level, addr=
);
> +                       else
> +                               flush =3D true;

Since, we are requiring callers of kvm_riscv_gstage_op_pte() to do the
TLB flushing, this should only set "flush =3D true".

> +               }
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
> @@ -260,6 +270,7 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage *=
gstage,
>         bool found_leaf;
>         unsigned long page_size;
>         gpa_t addr =3D start, end =3D start + size;
> +       bool flush =3D false;
>
>         while (addr < end) {
>                 found_leaf =3D kvm_riscv_gstage_get_leaf(gstage, addr, &p=
tep, &ptep_level);
> @@ -271,8 +282,8 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage *=
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
> @@ -284,9 +295,11 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage =
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
> @@ -294,6 +307,7 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gst=
age, gpa_t start, gpa_t end
>         bool found_leaf;
>         gpa_t addr =3D start;
>         unsigned long page_size;
> +       bool flush =3D false;
>
>         while (addr < end) {
>                 found_leaf =3D kvm_riscv_gstage_get_leaf(gstage, addr, &p=
tep, &ptep_level);
> @@ -305,12 +319,14 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *g=
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
> index 0b75eb2a1..dde5afe57 100644
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
> @@ -147,8 +159,10 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>         gstage.pgd =3D kvm->arch.pgd;
>
>         spin_lock(&kvm->mmu_lock);
> -       kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false);
> +       flush =3D kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false)=
;
>         spin_unlock(&kvm->mmu_lock);
> +       if (flush)
> +               kvm_flush_remote_tlbs(kvm);

Why nuke the whole TLB over here ?
I think kvm_flush_remote_tlbs_range() is sufficient here.

>  }
>
>  void kvm_arch_commit_memory_region(struct kvm *kvm,
> @@ -253,10 +267,9 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm=
_gfn_range *range)
>         gstage.flags =3D 0;
>         gstage.vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
>         gstage.pgd =3D kvm->arch.pgd;
> -       kvm_riscv_gstage_unmap_range(&gstage, range->start << PAGE_SHIFT,
> -                                    (range->end - range->start) << PAGE_=
SHIFT,
> -                                    range->may_block);
> -       return false;
> +       return kvm_riscv_gstage_unmap_range(&gstage, range->start << PAGE=
_SHIFT,
> +                                           (range->end - range->start) <=
< PAGE_SHIFT,
> +                                           range->may_block);

The caller of this function (aka kvm_handle_hva_range()) nukes the
entire TLB which is not efficient.

Better to do kvm_flush_remote_tlbs_range() over here and return false
like before.

>  }
>
>  bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
> @@ -579,6 +592,7 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>  {
>         struct kvm_gstage gstage;
>         void *pgd =3D NULL;
> +       bool flush =3D false;
>
>         spin_lock(&kvm->mmu_lock);
>         if (kvm->arch.pgd) {
> @@ -586,13 +600,17 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
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

Overall, this is good change. Please address the above comments.

Regards,
Anup
