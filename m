Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E833538655E;
	Mon,  1 Jun 2026 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300258; cv=none; b=nAn28EOuPTTzBqq4gOsb5Oor4rE2rOvSef1enPRnQsmGcM33UQr3xmTIpjeLxmHT2xwmXmyqgi7DgMQcrH7RMCUj1WtnU25wZuw1VQ4TKJOnae0amDzchQNBolzSfeuPMxovqNd0XT9deZq7QrwNXk5WNquvl37hShKerQDDW04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300258; c=relaxed/simple;
	bh=rDdFHwWnO2TwFrMoqFq4Z4EPKlJsNLzIE/Otcr40dNY=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=Vu7cHaG9JrE2iXrDHAja/oq0FeKzkSVXj634/cK59CqykXFeuMbkEihsxdTx25LDJsgfPJMf9mmr/OFOG+m36TvykbqTdl9EXgN7R5sRvi6xCFvwuBhzE9BC5LkczEQ0OnbVgui/G2ytt5erOj19+9PJORmQuE0+Ii91SKVicXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gTR3G1L8Xz55y2M;
	Mon, 01 Jun 2026 15:50:50 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
	by mse-fl2.zte.com.cn with SMTP id 6517oWPM054581;
	Mon, 1 Jun 2026 15:50:32 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
	by mapi (Zmail) with MAPI id mid12;
	Mon, 1 Jun 2026 15:50:34 +0800 (CST)
X-Zmail-TransId: 2b046a1d39ca433-27457
X-Mailer: Zmail v1.0
Message-ID: <20260601155034636JGXXXIkBJCy5tetcmoevj@zte.com.cn>
In-Reply-To: <CAAhSdy1LE+oTMgO_C9SBvpqF=SHLOdDLGms5_ajO8pqDm=fFuA@mail.gmail.com>
References: 20260429173002565bdp1o7P0bvOs6yTz64yNx@zte.com.cn,20260429173539941luiwhNDDtflTHOClbNtk4@zte.com.cn,CAAhSdy1LE+oTMgO_C9SBvpqF=SHLOdDLGms5_ajO8pqDm=fFuA@mail.gmail.com
Date: Mon, 1 Jun 2026 15:50:34 +0800 (CST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <anup@brainfault.org>
Cc: <atish.patra@linux.dev>, <pjw@kernel.org>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <kvm@vger.kernel.org>,
        <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAzLzNdIFJJU0MtVjogS1ZNOiBSZWNvdmVyIGdzdGFnZSBodWdlIHBhZ2UgbWFwcGluZ3MgZHVyaW5nwqBkaXNhYmxlLWRpcnR5LWxvZw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6517oWPM054581
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 01 Jun 2026 15:50:50 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A1D39DA.000/4gTR3G1L8Xz55y2M

> > From: Wang Yechao <wang.yechao255@zte.com.cn>
> >
> > When dirty logging is enabled, the gstage mappings are split into
> > 4K pages to track dirty pages. If the migration fails or is canceled,
> > in order to keep the VM's performance consistent with that before
> > dirty logging was enabled, the gstage huge page mappings are recoverd
> > when dirty logging is disabled.
> >
> > With this patch, dirty_log_perf_test shows a decrease in the number of
> > vCPU faults:
> >
> > $ perf stat -e kvm:kvm_page_fault \
> > /dirty_log_perf_test -s anonymous_hugetlb_1gb -v 1 -e -b 1G
> >
> > Before: 524,819      kvm:kvm_page_fault
> > After : 263,211      kvm:kvm_page_fault
> >
> > Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> > ---
> >  arch/riscv/include/asm/kvm_gstage.h |  4 +++
> >  arch/riscv/kvm/gstage.c             | 42 ++++++++++++++++++++++++++
> >  arch/riscv/kvm/mmu.c                | 47 +++++++++++++++++++++++++++++
> >  3 files changed, 93 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
> > index 9c908432bc17..a074493596d1 100644
> > --- a/arch/riscv/include/asm/kvm_gstage.h
> > +++ b/arch/riscv/include/asm/kvm_gstage.h
> > @@ -64,6 +64,10 @@ int kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
> >                                 struct kvm_mmu_memory_cache *pcache,
> >                                 gpa_t addr, u32 target_level, bool flush);
> >
> > +void kvm_riscv_gstage_recover_huge(struct kvm_gstage *gstage, gpa_t addr,
> > +                                  unsigned long taget_page_size,
> > +                                  unsigned long *page_size);
> > +
> >  enum kvm_riscv_gstage_op {
> >         GSTAGE_OP_NOP = 0,      /* Nothing */
> >         GSTAGE_OP_CLEAR,        /* Clear/Unmap */
> > diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> > index d9fe8be2a151..e2c8cbac30d9 100644
> > --- a/arch/riscv/kvm/gstage.c
> > +++ b/arch/riscv/kvm/gstage.c
> > @@ -337,6 +337,48 @@ int kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
> >         return 0;
> >  }
> >
> > +void kvm_riscv_gstage_recover_huge(struct kvm_gstage *gstage, gpa_t addr,
> > +                                  unsigned long target_page_size,
> > +                                  unsigned long *page_size)
> > +{
> > +       u32 current_level = gstage->pgd_levels - 1;
> > +       pte_t *next_ptep = (pte_t *)gstage->pgd;
> > +       u32 target_level, out_level;
> > +       pte_t *ptep, *child_ptep;
> > +       int ret;
> > +
> > +       out_level = 0;
> > +       ret = gstage_page_size_to_level(gstage, target_page_size, &target_level);
> > +       if (ret)
> > +               goto out;
> > +
> > +       while (current_level >= target_level) {
> > +               ptep = (pte_t *)&next_ptep[gstage_pte_index(gstage, addr, current_level)];
> > +
> > +               out_level = current_level;
> > +               if (!pte_val(ptep_get(ptep)))
> > +                       goto out;
> > +
> > +               /* The mapping is already a huge page mapping. */
> > +               if (gstage_pte_leaf(ptep))
> > +                       goto out;
> > +
> > +               next_ptep = (pte_t *)gstage_pte_page_vaddr(ptep_get(ptep));
> > +               current_level--;
> > +       }
> > +
> > +       /* Replace the huge PTE with the first PTE entry of the child.*/
> > +       child_ptep = (pte_t *)&next_ptep[0];
> > +       if (gstage_pte_leaf(child_ptep)) {
> > +               set_pte(ptep, __pte(pte_val(ptep_get(child_ptep))));
> > +               gstage_tlb_flush(gstage, target_level, addr);
> > +               put_page(virt_to_page(next_ptep));
> > +       }
> > +
> > +out:
> > +       gstage_level_to_page_size(gstage, out_level, page_size);
> > +}
> > +
> >  void kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
> >                              pte_t *ptep, u32 ptep_level, enum kvm_riscv_gstage_op op)
> >  {
> > diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> > index dc6a8efde99e..789e3362144f 100644
> > --- a/arch/riscv/kvm/mmu.c
> > +++ b/arch/riscv/kvm/mmu.c
> > @@ -16,6 +16,8 @@
> >  #include <asm/kvm_mmu.h>
> >  #include <asm/kvm_nacl.h>
> >
> > +static void kvm_mmu_recover_huge_pages(struct kvm *kvm, int slot);
> > +
> >  static void mmu_wp_memory_region(struct kvm *kvm, int slot)
> >  {
> >         struct kvm_memslots *slots = kvm_memslots(kvm);
> > @@ -160,6 +162,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
> >                 if (kvm_dirty_log_manual_protect_and_init_set(kvm))
> >                         return;
> >                 mmu_wp_memory_region(kvm, new->id);
> > +       } else {
> > +               /*
> > +                * Recover huge page mappings in the slot now that dirty logging
> > +                * is disabled, i.e. now that KVM does not have to track guest
> > +                * writes at 4KiB granularity.
> > +                *
> > +                * Dirty logging might be disabled by userspace if an ongoing VM
> > +                * live migration is cancelled and the VM must continue running
> > +                * on the source.
> > +                */
> > +               kvm_mmu_recover_huge_pages(kvm, new->id);
> >         }
> >  }
> >
> > @@ -598,3 +611,37 @@ void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
> >         if (!kvm_riscv_gstage_vmid_bits())
> >                 kvm_riscv_local_hfence_gvma_all();
> >  }
> > +
> > +static void kvm_mmu_recover_huge_pages(struct kvm *kvm, int slot)
> > +{
> > +       struct kvm_memslots *slots = kvm_memslots(kvm);
> > +       struct kvm_memory_slot *memslot = id_to_memslot(slots, slot);
> > +       unsigned long hva = gfn_to_hva(kvm, memslot->base_gfn);
> > +       phys_addr_t start = memslot->base_gfn << PAGE_SHIFT;
> > +       phys_addr_t end = (memslot->base_gfn + memslot->npages) << PAGE_SHIFT;
> > +       phys_addr_t addr = start;
> > +       struct kvm_gstage gstage;
> > +       unsigned long page_size;
> > +
> > +       if (!fault_supports_gstage_huge_mapping(memslot, hva))
> > +               return;
> > +
> > +       kvm_riscv_gstage_init(&gstage, kvm);
> > +
> > +       spin_lock(&kvm->mmu_lock);
> > +
> > +       while (addr < end) {
> > +               if (get_hva_mapping_size(kvm, hva) < PMD_SIZE) {
> 
> This is hard-coded to work only for 2MB hugepages.
> 
This does not only apply to 2M hugepages; 1G hugepages can also work. 
However, for 1G hugepages, they will only be recovered into 2M mappings, 
rather than being restored to the original 1G mapping before splitting.

In the next version, for 1G hugepages, I will consider recovering the gstage
mapping into 1G mappings.

Best regards,
Yechao

> > +                       addr += PMD_SIZE;
> > +                       hva  += PMD_SIZE;
> > +                       continue;
> > +               }
> > +
> > +               kvm_riscv_gstage_recover_huge(&gstage, addr, PMD_SIZE, &page_size);
> > +
> > +               addr += page_size;
> > +               hva  += page_size;
> > +               cond_resched_lock(&kvm->mmu_lock);
> > +       }
> > +       spin_unlock(&kvm->mmu_lock);
> > +}
> > --
> > 2.43.5
> 
> Regards,
> Anup
