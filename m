Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E918382F01
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860453; cv=pass; b=B+FQMl/2AAPrrwJ+ZfhfCD867WvzaEj8qY2er27HymNdho22VHPtdrAFGRPQPS/ISvAyDXjiM2wn6SObU9cTgg9JxZb9WH+dPJ79GOBghpTF/+wUyAEAwrkrR1iIBYBVQrN2KOwrDwoglykRiTa4neJFPoWnaOIsvKa4ojIsJDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860453; c=relaxed/simple;
	bh=ayGL+fNk/q9FZjIdrR01KNEeTAAkqFMR815dkVGppoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDrusNzVu7tKp7vYMNvzRjPAgo+eqVNLBnvCCzHYPZEeMNetGP0ihpVPxKBk24rDhO3ZUENwcLDI6A2YMx5RA/bVV6pECZTM65ZcIcEapUSUNtCHVcSbpx16XezfTRFnfSQK+dYYWg7HvRvy9jT3J1YQcJku+77P6yh3ZEh8RVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JQ65uwvd; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JQ65uwvd"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38a67221fe8so32947061fa.3
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 01:47:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774860450; cv=none;
        d=google.com; s=arc-20240605;
        b=iPJ1b5+728mwnBrGt61zG2UuZJH3fPzyhSZl1zuY/yes27E2iSdGKEzbS/irgiTzDM
         SxaEz+PwXd5r+2a5v1bvCEXy/ITWhqqWEti8XIbST5enxvsRnbc56MUxgaTaGk/D4zGJ
         uA8a5j0Cag5nUZOF2KCp28DTl9uZ316i55mgCWyCfJ5oakPCr3yhsnWS/lT+yAVradTq
         uyjhX+ZVu5/cfS7SuoMr5WlhJo7/WpGgom8iQhs+Yq7NnMnu7CugaXlakjSqsMnpj8ax
         IShhIb4y2D8EYJF+NJqRoIAtr4Snvythsn6Dl8v4+4CS7TUj7jwK9rTQGCAGYksvTp1p
         x2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0z804EtOQyak+k9FNjqOH/C9dI8Lsy1BOrYp255lB5A=;
        fh=fNhBt+9gGScbIhEXARpzEiUdhwUe2MzR6LjuxbQsmZQ=;
        b=IcTUtr9pL4rh0XbYyOijfcyY0TNaErIV+yVCnYeLGqNF+XygZAKsno4z2nUcLoKmsv
         jZisDUBPOy60G50hzI2kdKqRxNMttToRXWDus3zNaL2RLBnriQyPHS6if+/jAfZyuJA/
         mpV7732GPyN4tPhpibq+5+V3hXVvYe+qm6Nujd1feEwUrJVkhOB75hOBynnaSvwIsJcu
         xrKAub8FeAH9/lIToRDurBG2WgqjVG9S9rOvQP1X9P8JqxiIr0Jxq5Oz+hoe4+RmC5dj
         f4BmGbDW5JaXNFI5Y+mAgDrT0O9DJbS1+EuwV73TB7GzETNt9RE+oMaaU/WCaotIT7KJ
         cvIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1774860450; x=1775465250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0z804EtOQyak+k9FNjqOH/C9dI8Lsy1BOrYp255lB5A=;
        b=JQ65uwvdR3bq0HmsZDQHlVBU9KGdN05cyeRxZn8o9JMBmp/25VcHL2z+TtMlIicshC
         6MbubaPmCcr4mBJkaO8yvflwz2xBVBFzYRvcO/I40UGVy5LJldvlOoVMWLitFSbKm2ni
         S+DDnTzBAZdzeX7brh4yNjAchtitxDecN1aN5c2soGA7rX95wJSNdWvWc66aETKaOd2g
         cttfYG/6nQlvkhIWvdCos/6h3aiQPd3F689CRn9gX5T/PiXBTHeqOXGy+gCg3Du7+/Sf
         Pzm2TIdld1eFCh5aGdtgawcK5kmBh70JdzEB7RjdgKi3cOQe5i8KF5VxSimLp2oRiXxL
         5tpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774860450; x=1775465250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0z804EtOQyak+k9FNjqOH/C9dI8Lsy1BOrYp255lB5A=;
        b=FwvmGaDqNF3jCHtGTAy0PaLXhjDHjkO2YZGOJ/NjTv/om0F4IgKnDwhzvG+flXAELM
         BKkcjaqFiixuGDX3JmGbwlK/gW0XgNuLxQCTX3SDDXpMU92cOAzd0ksdseD97NCNjVZt
         CqdED9Q+EEiAUtf0/a00meib82LvSYRozkJNMQs5nfAnrq4VkztV+1LcqrliZhjMa4nY
         EtPIqH/N+4a7tJCfo146SyYMfncFq45MF1x4keCkbJE7xY5KwKc1KjOf5QhIrklg89nh
         xqO6OnKNVrJpaBRzZXEYhxL3iaKtLE5+hDWyO/T3HT6PqVfZwXb1xM4XzcRV/U6nTJGW
         sYsw==
X-Forwarded-Encrypted: i=1; AJvYcCX+cwan6WEaPazFWghxVBKJiNomG4KbKq5USXPvKW4z2RQBFsWErG9j5hRhHHS1wGZyU4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVDEU1tEr1WO2FIo25oymnbyRR7PqeVba7VJHxRrnRnbkea70q
	PoHz/Nvg6vU4WFtX19gc7EC5TqGxad1t/DSZ/Koxb88owok1C+YwrnIDzuJGHiMmm9AAZg8x9iS
	oE5Iv4uiqmHv5PgE5vMmuThopa7tKSzpLLQcAlLYQbg==
X-Gm-Gg: ATEYQzxiO3w6ZMwaYP6+wJ3p1ywMoDhIfdMs+nnLv75XE4YoQubVpCb9lU0ePMmIcJu
	mtlcVfgM3D8Yq2OpvOj1aD+923DYSiW9YB3Trj5psaLc1r+o8qS1NdhcBF7JZLr4mzFMpULxx9Q
	WJ7rOKvVsjF/Wry6gZo7dDH4mtAV9fRh/ncDC3k2XKZabnUWmOUIOL6SS2unvQXm85NdEl69x5S
	9O4DRqhdzaqyO4QVO4Rp1r4aKrPsxWuA1NMB40OID+Q/n8k5bp5UNttIB9Me1nK11fUzLQRsyP7
	Pr+RKgRJ2i8gfJnn0GnfSzlqoAEwmObAMrAqCuvY
X-Received: by 2002:a2e:2c0b:0:b0:386:9653:5d52 with SMTP id
 38308e7fff4ca-38c740304c1mr27739201fa.34.1774860449142; Mon, 30 Mar 2026
 01:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202603301608170032mtkGKX7wRcAkPKDQ5I-F@zte.com.cn> <202603301612587174XZ6QMCrymBqv30S6BN50@zte.com.cn>
In-Reply-To: <202603301612587174XZ6QMCrymBqv30S6BN50@zte.com.cn>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 30 Mar 2026 14:17:16 +0530
X-Gm-Features: AQROBzAXut-zCQs5ittjKmMsjpDf3KrRLMiZZNr2-vjcAbB818IPC2fsTpdAQHQ
Message-ID: <CAK9=C2Wpb-dObR-+tSeAwb+du321Wq7TxJfa93NXT-KLJnuM9Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=C2=A0=5BPATCH_v4_2=2F2=5D_RISC=2DV=3A_KVM=3A_Split_huge_pages_d?=
	=?UTF-8?Q?uring_fault_handling_for_dirty_logging?=
To: wang.yechao255@zte.com.cn
Cc: anup@brainfault.org, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 1:43=E2=80=AFPM <wang.yechao255@zte.com.cn> wrote:
>
> From: Wang Yechao <wang.yechao255@zte.com.cn>
>
> During dirty logging, all huge pages are write-protected. When the guest
> writes to a write-protected huge page, a page fault is triggered. Before
> recovering the write permission, the huge page must be split into smaller
> pages (e.g., 4K). After splitting, the normal mapping process proceeds,
> allowing write permission to be restored at the smaller page granularity.
>
> If dirty logging is disabled because migration failed or was cancelled,
> only recover the write permission at the 4K level, and skip recovering th=
e
> huge page mapping at this time to avoid the overhead of freeing page tabl=
es.
> The huge page mapping can be recovered in the ioctl context, similar to x=
86,
> in a later patch.
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/include/asm/kvm_gstage.h |   4 +
>  arch/riscv/kvm/gstage.c             | 126 ++++++++++++++++++++++++++++
>  2 files changed, 130 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm=
/kvm_gstage.h
> index 595e2183173e..373748c6745e 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -53,6 +53,10 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gstag=
e,
>                               bool page_rdonly, bool page_exec,
>                               struct kvm_gstage_mapping *out_map);
>
> +int kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
> +                                struct kvm_mmu_memory_cache *pcache,
> +                                gpa_t addr, u32 target_level, bool flush=
);
> +
>  enum kvm_riscv_gstage_op {
>         GSTAGE_OP_NOP =3D 0,      /* Nothing */
>         GSTAGE_OP_CLEAR,        /* Clear/Unmap */
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index d2001d508046..ffec3e5ddcaf 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -163,13 +163,32 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gst=
age,
>         return 0;
>  }
>
> +static void kvm_riscv_gstage_update_pte_prot(struct kvm_gstage *gstage, =
u32 level,
> +                                            gpa_t addr, pte_t *ptep, pgp=
rot_t prot)
> +{
> +       pte_t new_pte;
> +
> +       if (pgprot_val(pte_pgprot(ptep_get(ptep))) =3D=3D pgprot_val(prot=
))
> +               return;
> +
> +       new_pte =3D pfn_pte(pte_pfn(ptep_get(ptep)), prot);
> +       new_pte =3D pte_mkdirty(new_pte);
> +
> +       set_pte(ptep, new_pte);
> +
> +       gstage_tlb_flush(gstage, level, addr);
> +}
> +
>  int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
>                               struct kvm_mmu_memory_cache *pcache,
>                               gpa_t gpa, phys_addr_t hpa, unsigned long p=
age_size,
>                               bool page_rdonly, bool page_exec,
>                               struct kvm_gstage_mapping *out_map)
>  {
> +       bool found_leaf;
> +       u32 ptep_level;
>         pgprot_t prot;
> +       pte_t *ptep;
>         int ret;
>
>         out_map->addr =3D gpa;
> @@ -203,12 +222,119 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *g=
stage,
>                 else
>                         prot =3D PAGE_WRITE;
>         }
> +
> +       found_leaf =3D kvm_riscv_gstage_get_leaf(gstage, gpa, &ptep, &pte=
p_level);
> +       if (found_leaf) {
> +               /*
> +                * ptep_level is the current gstage mapping level of addr=
, out_map->level
> +                * is the required mapping level during fault handling.
> +                *
> +                * 1) ptep_level > out_map->level
> +                * This happens when dirty logging is enabled and huge pa=
ges are used.
> +                * KVM must track the pages at 4K level, and split the hu=
ge mapping
> +                * into 4K mappings.
> +                *
> +                * 2) ptep_level < out_map->level
> +                * This happens when dirty logging is disabled and huge p=
ages are used.
> +                * The gstage is split into 4K mappings, but the out_map =
level is now
> +                * back to the huge page level. Ignore the out_map level =
this time, and
> +                * just update the pte prot here. Otherwise, we would fal=
l back to mapping
> +                * the gstage at huge page level in `kvm_riscv_gstage_set=
_pte`, with the
> +                * overhead of freeing the page tables(not support now), =
which would slow
> +                * down the vCPUs' performance.
> +                *
> +                * It is better to recover the huge page mapping in the i=
octl context when
> +                * disabling dirty logging.
> +                *
> +                * 3) ptep_level =3D=3D out_map->level
> +                * We already have the ptep, just update the pte prot if =
the pfn not change.
> +                * There is no need to invoke `kvm_riscv_gstage_set_pte` =
again.
> +                */
> +               if (ptep_level > out_map->level) {
> +                       kvm_riscv_gstage_split_huge(gstage, pcache, gpa,
> +                                                   out_map->level, true)=
;
> +               } else if (ALIGN_DOWN(PFN_PHYS(pte_pfn(ptep_get(ptep))), =
page_size) =3D=3D hpa) {
> +                       kvm_riscv_gstage_update_pte_prot(gstage, ptep_lev=
el, gpa, ptep, prot);
> +                       return 0;
> +               }
> +       }
> +
>         out_map->pte =3D pfn_pte(PFN_DOWN(hpa), prot);
>         out_map->pte =3D pte_mkdirty(out_map->pte);
>
>         return kvm_riscv_gstage_set_pte(gstage, pcache, out_map);
>  }
>
> +static inline unsigned long make_child_pte(unsigned long huge_pte, int i=
ndex,
> +                                          unsigned long child_page_size)
> +{
> +       unsigned long child_pte =3D huge_pte;
> +       unsigned long child_pfn_offset;
> +
> +       /*
> +        * The child_pte already has the base address of the huge page be=
ing
> +        * split. So we just have to OR in the offset to the page at the =
next
> +        * lower level for the given index.
> +        */
> +       child_pfn_offset =3D index * (child_page_size / PAGE_SIZE);
> +       child_pte |=3D pte_val(pfn_pte(child_pfn_offset, __pgprot(0)));
> +
> +       return child_pte;
> +}
> +
> +int kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
> +                               struct kvm_mmu_memory_cache *pcache,
> +                               gpa_t addr, u32 target_level, bool flush)
> +{
> +       u32 current_level =3D kvm_riscv_gstage_pgd_levels - 1;
> +       pte_t *next_ptep =3D (pte_t *)gstage->pgd;
> +       unsigned long huge_pte, child_pte;
> +       unsigned long child_page_size;
> +       pte_t *ptep;
> +       int i, ret;
> +
> +       if (!pcache)
> +               return -ENOMEM;
> +
> +       while(current_level > target_level) {
> +               ptep =3D (pte_t *)&next_ptep[gstage_pte_index(addr, curre=
nt_level)];
> +
> +               if (!pte_val(ptep_get(ptep)))
> +                       break;
> +
> +               if (!gstage_pte_leaf(ptep)) {
> +                       next_ptep =3D (pte_t *)gstage_pte_page_vaddr(ptep=
_get(ptep));
> +                       current_level--;
> +                       continue;
> +               }
> +
> +               huge_pte =3D pte_val(ptep_get(ptep));
> +
> +               ret =3D gstage_level_to_page_size(current_level - 1, &chi=
ld_page_size);
> +               if (ret)
> +                       return ret;
> +
> +               next_ptep =3D kvm_mmu_memory_cache_alloc(pcache);
> +               if (!next_ptep)
> +                       return -ENOMEM;
> +
> +               for (i =3D 0; i < PTRS_PER_PTE; i++) {
> +                       child_pte =3D make_child_pte(huge_pte, i, child_p=
age_size);
> +                       set_pte((pte_t *)&next_ptep[i], __pte(child_pte))=
;
> +               }
> +
> +               set_pte(ptep, pfn_pte(PFN_DOWN(__pa(next_ptep)),
> +                               __pgprot(_PAGE_TABLE)));
> +
> +               if (flush)
> +                       gstage_tlb_flush(gstage, current_level, addr);
> +
> +               current_level--;
> +       }
> +
> +       return 0;
> +}
> +
>  void kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
>                              pte_t *ptep, u32 ptep_level, enum kvm_riscv_=
gstage_op op)
>  {
> --
> 2.47.3
>
> --
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv
