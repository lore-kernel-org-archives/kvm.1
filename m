Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794547498;
	b=TGvNNdfuQPC4JbuczdoKuKNx5bKelkIh8pb6FDNsEahMYhkpR+R4WcBIRmC1UvPO7Tvv
	 K4nSykXKBU+7huCO723oQSWhzOoR7O0O+kFMmIfI5cFIw7/p7uwXn3jvw9VnqcAegKJGv
	 Ip4ZUIg3ASGQh9r4HR5vFZARCP+IJnvnqeFb95HimkAZjajWrLggaIgbDxXUsdUHTEsi4
	 7tP/I8j0TbGd7IBAmaDb7fTzPuNTbj5xDYVMsuSk1rgEcBRGjMKwH5NRHGaKUfTf41/UB
	 1JxsBj0DK15hEH+ZjAoPHwi3mg46fayETACiKt1sA9g8GHY86rR3iHqTdODumSAvXtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yyGnZvbKuVxJeYLGr7afe2GvCrqIF86oRsOwclnwbQk=;
	b=T0kUOf/EgIjpANfhc3yiejYHJqvH8UwgVUD81G/I7rkmhAtH2wp2x1w11OsY5qRhX6eI
	 iVCxjmVIw/3gfriUlJKa+s2RhBtAx3mZPfT1aS0D0srux+buMRtJzqE6yza1IID5Dspeg
	 s1CbH0QiMPbCQXulDflV6KCzPqmCBTwWxC9zFWlrog+24Jm3mvVdDSzznPWgDHO0KDKkp
	 Q4UgoxkTsp1uncI7L0ox6qScUBGHHcHVoDaFe+J0ujFV29aR3R1UgvnNlL0lseRU795SN
	 LhZ+/mCS6Knpw0kS4WzDXv0tf0yQfjfpIp00AAQH+CrG9t2IARlJZw+esCWReHfvMNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=YntGo9az;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EC8606A31C
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3EC8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=YntGo9az
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4910b863b84so943346f8f.0
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 21:24:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794547495; cv=none;
        d=google.com; s=arc-20260327;
        b=ksgpLpKnVeUBCdeiryz7ng621zox1HPRgOKOTPLZ/8pgxvKhSJHpEGM+LW40zT7EUE
         30XrHy20DhMigYYlWbm0mcBodBJ774QMuQwn8zpumWkeDzKXBsicfUSY/kQJ5MXvI6Ms
         kPAXgDdMHBEtkZqZ+FUD/nFX/OlEPp+CPhEoAS3LqbHsQBT02Z834Db/iLJ9SoOx6tfE
         288ih0r3ph5TfpDP8GEKuEQTRlP31IayCd0KqvZn8St1HAtjK33rkUOxJ1xi+esCK+z9
         E41/XZTaQyviY0sw51LJ7Ai10YPERdWfDNKVqorVONHQPaXpbUz/a6I82Wd+mCvlSwNT
         2s+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yyGnZvbKuVxJeYLGr7afe2GvCrqIF86oRsOwclnwbQk=;
        fh=esaTA7V/jgi5fpzxIvA6CEskiKsuq+pFxa/XwJktOWo=;
        b=ptyqFgpdtzDKH+eu36LKNQWczZgxqLHPiiu/zKo+hWMBfzM6Rrx3oPiw/tA498zW4t
         amnOWJlwhRqouQIjvvPlmQgg2Z3zEPZ2gji8TwP4vbV+Pdz5oVBRvl4LpTGhlLvTdGVq
         c0FJ6Q9kbmxaQDL7G11UPPmYh/t7qJA80b4jViZeDIru+g5kj95myYg0MBvTXBYyhYLM
         mopjJ/67pAfVcDCH85Y4aBIRRlKyZPgxdneSvlAxFicdV1XghUxXraRizHoviCcJI4bO
         E5jAvJRNlNpbpvdpUIfuFCEnMy6qCwWx+LDx/B+jEL6vLDZSItT6Rbv/MgZHDlglVEnO
         u/JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794547495; x=1795152295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yyGnZvbKuVxJeYLGr7afe2GvCrqIF86oRsOwclnwbQk=;
        b=YntGo9azVnPrhKr/cJ2ddcMHIaTl/dYYmHPry0+XGplt53458PZq24AJuyrk0JbTN7
         3W7lSmczC7KHnfnOvRLbGWVsjUK3HHBl5e0duHR2eQujhkWegFMHSgCcNIhpfHffPbhb
         3NUvOoAm3OTC1pD6fPH0hujj4n7WzUscxQY83Feptf1Ha3vhkAg3YIunQL8LVq+nwTSq
         6ERhODOeOL1XmdwTlNdaYqkMui5C4YTkXbu66CokHkFjev71nrLovDZ5nxd3MEMgynca
         bHQ7ZOpgqi54eq8dBq7ileMhkF4wNmImSAXoTk38S9dITzXA4LmcVSu2ZBAFbTZY0+dS
         DYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794547495; x=1795152295;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yyGnZvbKuVxJeYLGr7afe2GvCrqIF86oRsOwclnwbQk=;
        b=b2rbMyV6CFsrEhAtbTw9me8NIVig4j+26AIfYIWaMdDyCfsVQkFjlVKi/0O9Q1hJBa
         c7t7/Th7IgNa5msJLXhWQI/E34UnBj6wEQNT8M6zNxNrLI7EWFhFLgmxXIexJngyiIAa
         cOIdF71QvkcTl71TZymEBkrudLzGpfc9YrvTuY0z+FKKzyG+C8Wpuv7RrRmK0mY9m8NE
         TopqE77CgACdfC0+DJzh27AzRTktBp4oJ/rWKzhl8g8d8Plfue3hJjxFLqFUNPx/Xfu+
         hZo0Zk9BBYVgKkij4cJCUmaA/yYneG/CLs2Hvr+xqmJs46IQ7T1m+QU7thSH8kd+4abo
         NY/Q==
X-Forwarded-Encrypted: i=1; AL+hErHOfX889EWNK0P95OdYQjo9ToLr9EJdC4UcFd3REasnMPJDnTBwDaIlFGraRUpNTm5PSlc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VqN3ngl5PCCJRYtxiIFAlySs+sewXLPaHrs14rxhWxliiwHC+
	6E/flbHSdMUG5DVy3i+2Bvox4JhUlFamE30ynNbp95bX4Z4hRinwqsu3zEBQtyLmmntuQMqAaUo
	M8ZIQegzuRht0PdUjd1o5t5b4uoYQyFzA4Z1gw2SgDpnBtg3SyI8d
X-Gm-Gg: AYBFou1mDfnQlNyK+wCs1PVjwkrljkaX+48Uv1roYwazpNpssyfxhisjNAcd/4D/TIu
	3cjFZi2EeJ49CJDoYa9vmZEM5/sI3FRfvMLtR39/zu5KW0nwhciqLByYtOc0lxYemc8EnE5qPR/
	/YdHviCNMBfYxNWyHHW3ZyD9gTd+LWqQmvygFGeA/pH5XXXStIOH2C+B2NpJ8Ne5gkPxLGQ02RS
	GonowIotIUD4v/4/p9KD1bnYTP3AQ1vuXESxt28D9RIkD6zuIji0zZ7cRhLYrU80YMmuNh1C4lO
	D6A2P2w/mgXZiEpzdBTdKPNnBhUzoA9vq1up1OkcRKiWgJqtIxsGdQ4jyEeULkEMZh+pZ4alTyn
	5cV2vT6vVBGSyLnv3lR+veassIUdkYlr7iFMY4dIWET13CvruK+01L6Gq8n0ERX2xsWqlwD4zv4
	dADPjybKQZKCEx2mQWzV+JRA0uUHezUpYZlUu6SOlTdsFBz+HCSLckjRk5
X-Received: by 2002:a05:600c:2784:b0:4a1:d49e:9ce with SMTP id
 5b1f17b1804b1-4bb4e2918b1mr89107465e9.2.1794547495131; Thu, 12 Nov 2026
 21:24:55 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260920123117.49830-1-qican5708@163.com> <20260920140831.75097-1-qican5708@163.com>
In-Reply-To: <20260920140831.75097-1-qican5708@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 13 Nov 2026 10:54:43 +0530
X-Gm-Features: AclHuK_NyRq3fRIWopl3pB05XkJi1K4oe3ExC2dqJ7ieEtKoOYRvfTJs8viPxCA
Message-ID: <CAAhSdy3739feEFzv3z_WPNMGtaxWvE3qDFmY3pJCg6bv8XryMg@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: riscv: Free detached G-stage page tables outside mmu_lock
To: Can Qi <qican5708@163.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Quan Zhou <zhouquan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 7:38=E2=80=AFPM Can Qi <qican5708@163.com> wrote:
>
> kvm_riscv_mmu_free_pgd() currently walks the entire G-stage address
> space and recursively frees lower-level page-table pages while holding
> mmu_lock for write. Teardown of a large VM can therefore hold mmu_lock
> for a long time.
>
> Detach the active G-stage root under mmu_lock and free the detached tree
> after dropping the lock. Make live G-stage users acquire the active root
> under mmu_lock, and make walkers that drop and reacquire the lock verify
> that the root is still active before continuing.
>
> Before freeing the detached tree, quiesce guest and host HLV/HLVX
> hardware users using KVM_REQ_OUTSIDE_GUEST_MODE and the
> READING_SHADOW_PAGE_TABLES protocol. Prevent a detached root from being
> reinstalled in HGATP or used for guest entry, and request invalidation
> of stale G-stage translations for the old VMID.
>
> Free only page-table pages from the detached tree and periodically call
> cond_resched() while walking it.
>
> Also replace the KVM-wide split page cache with a per-operation cache.
> The huge-page split path can drop mmu_lock while topping up its cache or
> rescheduling, so keeping the cache local avoids sharing its lifetime
> with G-stage teardown.
>
> Assisted-by: LLM
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Can Qi <qican5708@163.com>

Please check the issues pointed by shasiko

Regards,
Anup

> ---
> Changes in v2:
>
> - Keep mmu_lock held across the complete HLV/HLVX access.
> - Restore local IRQs before read_unlock() to avoid a PREEMPT_RT warning.
>
>  arch/riscv/include/asm/kvm_gstage.h |   9 +-
>  arch/riscv/include/asm/kvm_host.h   |   1 -
>  arch/riscv/kvm/gstage.c             |  37 ++++++++
>  arch/riscv/kvm/mmu.c                | 138 ++++++++++++++--------------
>  arch/riscv/kvm/vcpu.c               |  10 +-
>  arch/riscv/kvm/vcpu_exit.c          |  16 ++++
>  6 files changed, 139 insertions(+), 72 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm=
/kvm_gstage.h
> index aaf080ba1b77..b5a9563754d0 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -87,6 +87,8 @@ bool kvm_riscv_gstage_wp_pt_masked(struct kvm_gstage *g=
stage, gfn_t base_gfn,
>
>  void kvm_riscv_gstage_mode_detect(void);
>
> +void kvm_riscv_gstage_free(struct kvm_gstage *gstage);
> +
>  static inline unsigned long kvm_riscv_gstage_mode(unsigned long pgd_leve=
ls)
>  {
>         switch (pgd_levels) {
> @@ -104,13 +106,18 @@ static inline unsigned long kvm_riscv_gstage_mode(u=
nsigned long pgd_levels)
>         }
>  }
>
> -static inline void kvm_riscv_gstage_init(struct kvm_gstage *gstage, stru=
ct kvm *kvm)
> +static inline bool kvm_riscv_gstage_init(struct kvm_gstage *gstage, stru=
ct kvm *kvm)
>  {
> +       lockdep_assert_held(&kvm->mmu_lock);
> +       if (!kvm->arch.pgd)
> +               return false;
> +
>         gstage->kvm =3D kvm;
>         gstage->flags =3D 0;
>         gstage->vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
>         gstage->pgd =3D kvm->arch.pgd;
>         gstage->pgd_levels =3D kvm->arch.pgd_levels;
> +       return true;
>  }
>
>  #endif
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index a30600579231..2ab999f75151 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -86,7 +86,6 @@ struct kvm_arch {
>         pgd_t *pgd;
>         phys_addr_t pgd_phys;
>         unsigned long pgd_levels;
> -       struct kvm_mmu_memory_cache pgd_split_page_cache;
>
>         /* Guest Timer */
>         struct kvm_guest_timer timer;
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index e5002cb9cbef..5ab3c4ba5a6a 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -414,6 +414,37 @@ bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gsta=
ge, gpa_t addr,
>         return flush;
>  }
>
> +/* The caller has detached this tree and quiesced its hardware users. */
> +static void gstage_free_level(pte_t *ptep, u32 level, unsigned long nr_e=
ntries,
> +                             unsigned int *processed)
> +{
> +       pte_t pte, *child;
> +       unsigned long i;
> +
> +       for (i =3D 0; i < nr_entries; i++) {
> +               pte =3D ptep_get(&ptep[i]);
> +               if (level && pte_val(pte) && !gstage_pte_leaf(&pte)) {
> +                       child =3D (pte_t *)gstage_pte_page_vaddr(pte);
> +                       gstage_free_level(child, level - 1, PTRS_PER_PTE,=
 processed);
> +                       put_page(virt_to_page(child));
> +               }
> +               /* Leaf PFNs belong to the guest backing memory, not this=
 tree. */
> +               if (++*processed =3D=3D PTRS_PER_PTE) {
> +                       *processed =3D 0;
> +                       cond_resched();
> +               }
> +       }
> +}
> +
> +void kvm_riscv_gstage_free(struct kvm_gstage *gstage)
> +{
> +       unsigned int processed =3D 0;
> +
> +       gstage_free_level((pte_t *)gstage->pgd, gstage->pgd_levels - 1,
> +                         PTRS_PER_PTE << kvm_riscv_gstage_pgd_xbits, &pr=
ocessed);
> +       free_pages((unsigned long)gstage->pgd, get_order(kvm_riscv_gstage=
_pgd_size));
> +}
> +
>  bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
>                                   gpa_t start, gpa_t size, bool may_block=
)
>  {
> @@ -426,6 +457,12 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage =
*gstage,
>         bool flush =3D false;
>
>         while (addr < end) {
> +               /* cond_resched_rwlock_write() may have let teardown deta=
ch us. */
> +               if (!(gstage->flags & KVM_GSTAGE_FLAGS_LOCAL) &&
> +                   (!gstage->kvm->arch.pgd ||
> +                    gstage->pgd !=3D gstage->kvm->arch.pgd))
> +                       break;
> +
>                 found_leaf =3D kvm_riscv_gstage_get_leaf(gstage, addr, &p=
tep, &ptep_level);
>                 ret =3D gstage_level_to_page_size(gstage, ptep_level, &pa=
ge_size);
>                 if (ret)
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 6035b5ec9503..2d7ad70ff765 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -26,12 +26,11 @@ static void mmu_wp_memory_region(struct kvm *kvm, int=
 slot)
>         phys_addr_t start =3D memslot->base_gfn << PAGE_SHIFT;
>         phys_addr_t end =3D (memslot->base_gfn + memslot->npages) << PAGE=
_SHIFT;
>         struct kvm_gstage gstage;
> -       bool flush;
> -
> -       kvm_riscv_gstage_init(&gstage, kvm);
> +       bool flush =3D false;
>
>         write_lock(&kvm->mmu_lock);
> -       flush =3D kvm_riscv_gstage_wp_range(&gstage, start, end);
> +       if (kvm_riscv_gstage_init(&gstage, kvm))
> +               flush =3D kvm_riscv_gstage_wp_range(&gstage, start, end);
>         write_unlock(&kvm->mmu_lock);
>         if (flush)
>                 kvm_flush_remote_tlbs_memslot(kvm, memslot);
> @@ -44,7 +43,7 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, p=
hys_addr_t hpa,
>         pgprot_t prot;
>         unsigned long pfn;
>         phys_addr_t addr, end;
> -       unsigned long pgd_levels =3D kvm->arch.pgd_levels;
> +       unsigned long pgd_levels =3D kvm_riscv_gstage_max_pgd_levels;
>         struct kvm_mmu_memory_cache pcache =3D {
>                 .gfp_custom =3D (in_atomic) ? GFP_ATOMIC | __GFP_ACCOUNT =
: 0,
>                 .gfp_zero =3D __GFP_ZERO,
> @@ -52,8 +51,6 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, p=
hys_addr_t hpa,
>         struct kvm_gstage_mapping map;
>         struct kvm_gstage gstage;
>
> -       kvm_riscv_gstage_init(&gstage, kvm);
> -
>         end =3D (gpa + size + PAGE_SIZE - 1) & PAGE_MASK;
>         pfn =3D __phys_to_pfn(hpa);
>         prot =3D pgprot_noncached(PAGE_WRITE);
> @@ -72,7 +69,10 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, =
phys_addr_t hpa,
>                         goto out;
>
>                 write_lock(&kvm->mmu_lock);
> -               ret =3D kvm_riscv_gstage_set_pte(&gstage, &pcache, &map);
> +               if (kvm_riscv_gstage_init(&gstage, kvm))
> +                       ret =3D kvm_riscv_gstage_set_pte(&gstage, &pcache=
, &map);
> +               else
> +                       ret =3D -EFAULT;
>                 write_unlock(&kvm->mmu_lock);
>                 if (ret)
>                         goto out;
> @@ -88,12 +88,11 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa,=
 phys_addr_t hpa,
>  void kvm_riscv_mmu_iounmap(struct kvm *kvm, gpa_t gpa, unsigned long siz=
e)
>  {
>         struct kvm_gstage gstage;
> -       bool flush;
> -
> -       kvm_riscv_gstage_init(&gstage, kvm);
> +       bool flush =3D false;
>
>         write_lock(&kvm->mmu_lock);
> -       flush =3D kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false)=
;
> +       if (kvm_riscv_gstage_init(&gstage, kvm))
> +               flush =3D kvm_riscv_gstage_unmap_range(&gstage, gpa, size=
, false);
>         write_unlock(&kvm->mmu_lock);
>
>         if (flush)
> @@ -101,14 +100,12 @@ void kvm_riscv_mmu_iounmap(struct kvm *kvm, gpa_t g=
pa, unsigned long size)
>                                             size >> PAGE_SHIFT);
>  }
>
> -static bool need_topup_split_caches_or_resched(struct kvm *kvm, int coun=
t)
> +static bool need_topup_split_cache(struct kvm *kvm,
> +                                  struct kvm_mmu_memory_cache *cache, in=
t count)
>  {
> -       struct kvm_mmu_memory_cache *cache;
> -
>         if (need_resched() || rwlock_needbreak(&kvm->mmu_lock))
>                 return true;
>
> -       cache =3D &kvm->arch.pgd_split_page_cache;
>         return kvm_mmu_memory_cache_nr_free_objects(cache) < count;
>  }
>
> @@ -116,7 +113,8 @@ static bool mmu_split_huge_pages(struct kvm_gstage *g=
stage,
>                                  phys_addr_t start, phys_addr_t end)
>  {
>         struct kvm *kvm =3D gstage->kvm;
> -       struct kvm_mmu_memory_cache *pcache =3D &kvm->arch.pgd_split_page=
_cache;
> +       struct kvm_mmu_memory_cache cache =3D { .gfp_zero =3D __GFP_ZERO =
};
> +       struct kvm_mmu_memory_cache *pcache =3D &cache;
>         phys_addr_t addr =3D ALIGN_DOWN(start, PMD_SIZE);
>         phys_addr_t last_flush_gfn =3D addr >> PAGE_SHIFT;
>         int count =3D gstage->pgd_levels;
> @@ -126,7 +124,7 @@ static bool mmu_split_huge_pages(struct kvm_gstage *g=
stage,
>         lockdep_assert_held_write(&kvm->mmu_lock);
>
>         while (addr < end) {
> -               if (need_topup_split_caches_or_resched(kvm, count)) {
> +               if (need_topup_split_cache(kvm, pcache, count)) {
>                         if (flush) {
>                                 kvm_flush_remote_tlbs_range(kvm, last_flu=
sh_gfn,
>                                           (addr >> PAGE_SHIFT) - last_flu=
sh_gfn);
> @@ -141,19 +139,22 @@ static bool mmu_split_huge_pages(struct kvm_gstage =
*gstage,
>                         if (ret) {
>                                 kvm_err("Failed to toup split page cache\=
n");
>                                 write_lock(&kvm->mmu_lock);
> -                               return flush;
> +                               break;
>                         }
>                         write_lock(&kvm->mmu_lock);
>                 }
>
> -               if (!kvm->arch.pgd)
> -                       return flush;
> +               if (!kvm->arch.pgd || gstage->pgd !=3D kvm->arch.pgd)
> +                       break;
>
>                 flush |=3D kvm_riscv_gstage_split_huge(gstage, pcache, ad=
dr, 0, false);
>
>                 addr +=3D PMD_SIZE;
>         }
>
> +       write_unlock(&kvm->mmu_lock);
> +       kvm_mmu_free_memory_cache(pcache);
> +       write_lock(&kvm->mmu_lock);
>         return flush;
>  }
>
> @@ -167,7 +168,8 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct k=
vm *kvm,
>         phys_addr_t end =3D (base_gfn + __fls(mask) + 1) << PAGE_SHIFT;
>         struct kvm_gstage gstage;
>
> -       kvm_riscv_gstage_init(&gstage, kvm);
> +       if (!kvm_riscv_gstage_init(&gstage, kvm))
> +               return;
>
>         kvm_riscv_gstage_wp_pt_masked(&gstage, base_gfn, mask);
>
> @@ -205,12 +207,11 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>         gpa_t gpa =3D slot->base_gfn << PAGE_SHIFT;
>         phys_addr_t size =3D slot->npages << PAGE_SHIFT;
>         struct kvm_gstage gstage;
> -       bool flush;
> -
> -       kvm_riscv_gstage_init(&gstage, kvm);
> +       bool flush =3D false;
>
>         write_lock(&kvm->mmu_lock);
> -       flush =3D kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false)=
;
> +       if (kvm_riscv_gstage_init(&gstage, kvm))
> +               flush =3D kvm_riscv_gstage_unmap_range(&gstage, gpa, size=
, false);
>         write_unlock(&kvm->mmu_lock);
>         if (flush)
>                 kvm_flush_remote_tlbs_range(kvm, gpa >> PAGE_SHIFT,
> @@ -224,12 +225,11 @@ static void mmu_split_memory_region(struct kvm *kvm=
, int slot)
>         phys_addr_t start =3D memslot->base_gfn << PAGE_SHIFT;
>         phys_addr_t end =3D (memslot->base_gfn + memslot->npages) << PAGE=
_SHIFT;
>         struct kvm_gstage gstage;
> -       bool flush;
> -
> -       kvm_riscv_gstage_init(&gstage, kvm);
> +       bool flush =3D false;
>
>         write_lock(&kvm->mmu_lock);
> -       flush =3D mmu_split_huge_pages(&gstage, start, end);
> +       if (kvm_riscv_gstage_init(&gstage, kvm))
> +               flush =3D mmu_split_huge_pages(&gstage, start, end);
>         write_unlock(&kvm->mmu_lock);
>
>         if (flush)
> @@ -334,12 +334,10 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kv=
m_gfn_range *range)
>         struct kvm_gstage gstage;
>         bool flush;
>
> -       if (!kvm->arch.pgd)
> -               return false;
> -
>         lockdep_assert_held_write(&kvm->mmu_lock);
>
> -       kvm_riscv_gstage_init(&gstage, kvm);
> +       if (!kvm_riscv_gstage_init(&gstage, kvm))
> +               return false;
>         flush =3D kvm_riscv_gstage_unmap_range(&gstage, range->start << P=
AGE_SHIFT,
>                                              (range->end - range->start) =
<< PAGE_SHIFT,
>                                              range->may_block);
> @@ -356,12 +354,10 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_ra=
nge *range)
>         u64 size =3D (range->end - range->start) << PAGE_SHIFT;
>         struct kvm_gstage gstage;
>
> -       if (!kvm->arch.pgd)
> -               return false;
> -
>         WARN_ON(size !=3D PAGE_SIZE && size !=3D PMD_SIZE && size !=3D PU=
D_SIZE);
>
> -       kvm_riscv_gstage_init(&gstage, kvm);
> +       if (!kvm_riscv_gstage_init(&gstage, kvm))
> +               return false;
>         if (!kvm_riscv_gstage_get_leaf(&gstage, range->start << PAGE_SHIF=
T,
>                                        &ptep, &ptep_level))
>                 return false;
> @@ -376,12 +372,10 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_g=
fn_range *range)
>         u64 size =3D (range->end - range->start) << PAGE_SHIFT;
>         struct kvm_gstage gstage;
>
> -       if (!kvm->arch.pgd)
> -               return false;
> -
>         WARN_ON(size !=3D PAGE_SIZE && size !=3D PMD_SIZE && size !=3D PU=
D_SIZE);
>
> -       kvm_riscv_gstage_init(&gstage, kvm);
> +       if (!kvm_riscv_gstage_init(&gstage, kvm))
> +               return false;
>         if (!kvm_riscv_gstage_get_leaf(&gstage, range->start << PAGE_SHIF=
T,
>                                        &ptep, &ptep_level))
>                 return false;
> @@ -563,12 +557,12 @@ static bool kvm_riscv_mmu_dirty_log_write_fault_fas=
t(struct kvm *kvm,
>         bool dirty_marked =3D false;
>         bool ret;
>
> -       kvm_riscv_gstage_init(&gstage, kvm);
>         mmu_seq =3D kvm->mmu_invalidate_seq;
>
>         read_lock(&kvm->mmu_lock);
>
> -       if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn)) {
> +       if (!kvm_riscv_gstage_init(&gstage, kvm) ||
> +           mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn)) {
>                 ret =3D false;
>                 goto out_unlock;
>         }
> @@ -639,8 +633,6 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>         struct kvm_gstage gstage;
>         struct page *page;
>
> -       kvm_riscv_gstage_init(&gstage, kvm);
> -
>         /* Setup initial state of output mapping */
>         memset(out_map, 0, sizeof(*out_map));
>
> @@ -649,7 +641,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>                 return 0;
>
>         /* We need minimum second+third level pages */
> -       ret =3D kvm_mmu_topup_memory_cache(pcache, kvm->arch.pgd_levels);
> +       ret =3D kvm_mmu_topup_memory_cache(pcache, kvm_riscv_gstage_max_p=
gd_levels);
>         if (ret) {
>                 kvm_err("Failed to topup G-stage cache\n");
>                 return ret;
> @@ -719,6 +711,11 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct =
kvm_memory_slot *memslot,
>
>         write_lock(&kvm->mmu_lock);
>
> +       ret =3D -EFAULT;
> +       if (!kvm_riscv_gstage_init(&gstage, kvm))
> +               goto out_unlock;
> +
> +       ret =3D 0;
>         if (mmu_invalidate_retry(kvm, mmu_seq))
>                 goto out_unlock;
>
> @@ -764,7 +761,6 @@ int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm)
>         kvm->arch.pgd =3D page_to_virt(pgd_page);
>         kvm->arch.pgd_phys =3D page_to_phys(pgd_page);
>         kvm->arch.pgd_levels =3D kvm_riscv_gstage_max_pgd_levels;
> -       kvm->arch.pgd_split_page_cache.gfp_zero =3D __GFP_ZERO;
>
>         return 0;
>  }
> @@ -772,41 +768,45 @@ int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm)
>  void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>  {
>         struct kvm_gstage gstage;
> -       void *pgd =3D NULL;
> -       bool flush =3D false;
>
>         write_lock(&kvm->mmu_lock);
> -       if (kvm->arch.pgd) {
> -               kvm_riscv_gstage_init(&gstage, kvm);
> -               flush =3D kvm_riscv_gstage_unmap_range(&gstage, 0UL,
> -                       kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels), =
false);
> -               pgd =3D READ_ONCE(kvm->arch.pgd);
> -               kvm->arch.pgd =3D NULL;
> -               kvm->arch.pgd_phys =3D 0;
> -               kvm->arch.pgd_levels =3D 0;
> +       if (!kvm_riscv_gstage_init(&gstage, kvm)) {
> +               write_unlock(&kvm->mmu_lock);
> +               return;
>         }
> +       /* Live walkers must acquire mmu_lock and check the active root. =
*/
> +       WRITE_ONCE(kvm->arch.pgd, NULL);
> +       kvm->arch.pgd_phys =3D 0;
> +       kvm->arch.pgd_levels =3D 0;
>         write_unlock(&kvm->mmu_lock);
>
> -       if (flush)
> -               kvm_flush_remote_tlbs(kvm);
> -
> -       if (pgd)
> -               free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage=
_pgd_size));
> +       /* Quiesce hardware users before freeing the detached page tables=
. */
> +       kvm_make_all_cpus_request(kvm, KVM_REQ_OUTSIDE_GUEST_MODE);
>
> -       kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
> +       /*
> +        * Request an old-VMID HFENCE. Queue-full fallback can flush the =
current
> +        * VMID, so the hardware quiescing above protects the tree lifeti=
me.
> +        */
> +       kvm_riscv_hfence_gvma_vmid_all(kvm, -1UL, 0, gstage.vmid);
> +       kvm_riscv_gstage_free(&gstage);
>  }
>
>  void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
>  {
>         struct kvm_arch *ka =3D &vcpu->kvm->arch;
> -       unsigned long hgatp =3D kvm_riscv_gstage_mode(ka->pgd_levels)
> -                             << HGATP_MODE_SHIFT;
> -
> -       hgatp |=3D (READ_ONCE(ka->vmid.vmid) << HGATP_VMID_SHIFT) & HGATP=
_VMID;
> -       hgatp |=3D (ka->pgd_phys >> PAGE_SHIFT) & HGATP_PPN;
> +       unsigned long hgatp =3D 0;
> +
> +       /* Serialize the root snapshot and HGATP install against root det=
ach. */
> +       read_lock(&vcpu->kvm->mmu_lock);
> +       if (ka->pgd) {
> +               hgatp =3D kvm_riscv_gstage_mode(ka->pgd_levels) << HGATP_=
MODE_SHIFT;
> +               hgatp |=3D (READ_ONCE(ka->vmid.vmid) << HGATP_VMID_SHIFT)=
 & HGATP_VMID;
> +               hgatp |=3D (ka->pgd_phys >> PAGE_SHIFT) & HGATP_PPN;
> +       }
>
>         ncsr_write(CSR_HGATP, hgatp);
>
>         if (!kvm_riscv_gstage_vmid_bits())
>                 kvm_riscv_local_hfence_gvma_all();
> +       read_unlock(&vcpu->kvm->mmu_lock);
>  }
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index e062ca19f9d8..35bf948bd451 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -708,6 +708,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>   *
>   * Return: 1 if we should enter the guest
>   *         0 if we should exit to userspace
> + *         negative error code if guest entry is no longer possible
>   */
>  static int kvm_riscv_check_vcpu_requests(struct kvm_vcpu *vcpu)
>  {
> @@ -755,6 +756,12 @@ static int kvm_riscv_check_vcpu_requests(struct kvm_=
vcpu *vcpu)
>                         return 0;
>         }
>
> +       /* A detached G-stage must not be reused after processing its HFE=
NCE. */
> +       if (!READ_ONCE(vcpu->kvm->arch.pgd)) {
> +               kvm_riscv_mmu_update_hgatp(vcpu);
> +               return -EIO;
> +       }
> +
>         return 1;
>  }
>
> @@ -980,7 +987,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>                 /* Update HVIP CSR for current CPU */
>                 kvm_riscv_update_hvip(vcpu);
>
> -               if (kvm_riscv_gstage_vmid_ver_changed(&vcpu->kvm->arch.vm=
id) ||
> +               if (!READ_ONCE(vcpu->kvm->arch.pgd) ||
> +                   kvm_riscv_gstage_vmid_ver_changed(&vcpu->kvm->arch.vm=
id) ||
>                     kvm_request_pending(vcpu) ||
>                     xfer_to_guest_mode_work_pending()) {
>                         vcpu->mode =3D OUTSIDE_GUEST_MODE;
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 88e0c369b354..144b9f71f0a1 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -90,7 +90,20 @@ unsigned long kvm_riscv_vcpu_unpriv_read(struct kvm_vc=
pu *vcpu,
>         register unsigned long ttmp asm("a1");
>         unsigned long flags, val, tmp, old_stvec, old_hstatus;
>
> +       /*
> +        * Prevent G-stage teardown while HLV/HLVX can walk the page tabl=
es.
> +        * The active-root check prevents a new walk from starting after =
detach.
> +        */
> +       read_lock(&vcpu->kvm->mmu_lock);
> +       if (!vcpu->kvm->arch.pgd) {
> +               read_unlock(&vcpu->kvm->mmu_lock);
> +               trap->scause =3D EXC_LOAD_GUEST_PAGE_FAULT;
> +               trap->stval =3D guest_addr;
> +               return 0;
> +       }
>         local_irq_save(flags);
> +       /* Publish the hardware walk before accessing guest memory. */
> +       smp_store_mb(vcpu->mode, READING_SHADOW_PAGE_TABLES);
>
>         old_hstatus =3D csr_swap(CSR_HSTATUS, vcpu->arch.guest_context.hs=
tatus);
>         old_stvec =3D csr_swap(CSR_STVEC, (ulong)&__kvm_riscv_unpriv_trap=
);
> @@ -146,7 +159,10 @@ unsigned long kvm_riscv_vcpu_unpriv_read(struct kvm_=
vcpu *vcpu,
>         csr_write(CSR_STVEC, old_stvec);
>         csr_write(CSR_HSTATUS, old_hstatus);
>
> +       /* Complete all HLV/HLVX accesses before publishing OUTSIDE. */
> +       smp_store_release(&vcpu->mode, OUTSIDE_GUEST_MODE);
>         local_irq_restore(flags);
> +       read_unlock(&vcpu->kvm->mmu_lock);
>
>         return val;
>  }
> --
> 2.34.1
>
