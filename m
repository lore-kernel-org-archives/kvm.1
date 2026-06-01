Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD23345757
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294990; cv=pass; b=nFn/rHtlEXym1wNVrY49QwCv4JuAe45yNRdHuLGiHmYaU/5T7MSAUay8u8iL24uj53kWUpfuL8RKKOHw3JV7volJVHJmfJJwXeeler6e+erVkTt/woZJ0i6oDDvaw2VblLsDYjfYoiENuPnd1QRf4xKaoOIK6WxpmiOs5ZPWJ7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294990; c=relaxed/simple;
	bh=mx+ytcD6tQy9XWan0u2kzlA5IT9lB7tg3bVhonOtC9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndDIoMy+vYk25GJb4y113FXHrjD0WPbtvTlnr60Hc8+386cpbEZmOb4VN+iEjLI0GeaVmO+vhLzvQZ6HdYO2NmUekaB9+vi/VwUU3Vg+ybzVYi6m9VlfweV5tOk5sXK23Ax4TGit4bGS3p7VtZMPmak6ZyMvxkE3F6qYl6oCkNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=ca7+rRUH; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="ca7+rRUH"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e6b574c125so898531a34.1
        for <kvm@vger.kernel.org>; Sun, 31 May 2026 23:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780294988; cv=none;
        d=google.com; s=arc-20240605;
        b=FZH9DU3kS28HPND9yC+0nR43yyxxcunY0fSvjX3nLZJn9MDAD5PBWrg8lv0AMDbgGf
         1/96PQnBIqCFPWgRHzn291AMqtzoTpUK7ghnukGs6bM4+aipQ00ZD1pejoGIf7Z+BakL
         Jm9uh/mgRwmL04Y3TXe8O9RSa2BQBp1VEuE/JycesWcaD8rpxU/XIgKgJmVJpzngq8DU
         W7pQ72SANEgNgqG1BwPgJC8lKyRd0amzIhXi7SMLx6hZhkQIWk97B+YCFXmMJ5jL6+ka
         mCTJOf1pRAy8WrMyrPgVZPOZ211+iHfq9ASKZjVeUa/frXIxSYZYoRuHdrCxkAg8zRSM
         scAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kWHpaPNjlLn1h4xW7W+h38NolXiKY+AKV1544G3Mpp8=;
        fh=LOrFTfzQSTarUcwXGCcFhX8b/Y3Xg0OrqvXlxC6oEZs=;
        b=kq4s2QuuZy2wkW10pTWQw/ulz+evex5HRdVp10BtRj2iRyxYLTbFxwA1rc6wSn6ikN
         PmsG1fb3FRbrCl0SYXr/rJQjpbiHVj2yck89efECHJpKVToQ33V8InSoT8JnQvGU/5OV
         cqsEX8GREvM+til1vNDe8Nb4bzvhQHM9ipJaich8Jgabw9A6dRLbm00Nap0Q8qShOAgt
         PzQvZbKywsZsGUFUKH6Yany3IpnE31O9SKT/lbWTVpbWAPNl9o7d8odOmzHjGctM/+AY
         F7X6zo7weUHoXW+rzwpSHg7Yqk4PRIRJ61Hf/kynzfqDIel0KOBR4Iu2MwgfWdSi831h
         DPjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780294988; x=1780899788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWHpaPNjlLn1h4xW7W+h38NolXiKY+AKV1544G3Mpp8=;
        b=ca7+rRUHEUapWaRDGq7i6hVRPbhqTW5CtFMzJs2tM82LtFbMUFH3plHMJ9YiB/lsT6
         GbSywHeDYHTCanaK+rvJg8FhD2BIDxTX1/V9GuR/ucvdzF/jKeTKf7q/WLqQMmaw63CR
         ePvv3X3E4eUpOtylkF26JhRL9n84ewfPyAv4//bqSJYzIwuIqSDnAr8RCfxVomJFJWtt
         zZZ4HiXboHfXDNaaj9jzgsoINHpfAYZw8jVyoDG9hCzVJ3GGimSXqmHUax2nOjd9iE8n
         IEMgqFSryWCkxvtntwCcUUSwxGAInvVoK4gHp198scH/0ly37dnv7tMZqCNrgnSa8vZv
         21jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294988; x=1780899788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kWHpaPNjlLn1h4xW7W+h38NolXiKY+AKV1544G3Mpp8=;
        b=ExE5QG3xjldew2hvAlmXiQfi+jzYk+eShzH+4jIMneaMteZNZJb9yLvIoYC9qLWdXx
         hsLaKjjaRm8vb3SaDitHxgnjVCNrxUJ7DvdwGpEKYOLYuDw54/8dSC/PalKj28YWEKjI
         4fUrepltdE5slYkv8egjnEiK10jt87vVLsikkLAJJVBMdU4bEzwTSmUl6Ff5SfnQc6Dx
         sYb6IqxOcJDS6d9BPciC0bVtSF1B7xZCq/5wCIlID9HPD6hIDp4Ev1DMj/MJ6MsrNjOw
         RSr3v/+/OFJh3pfJobmG+hK3O5/lHjHRLfRF9gvvL4hIHKsCMeJwLje+t5Rr3ha/l8Jw
         oozA==
X-Forwarded-Encrypted: i=1; AFNElJ8YHXuqwCRlowfV3s3G+uo4svEeeVaXsULBQV5C9Ky/uKLLQ1Nk+b+msIlFONtosJn9tEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzzhJKkoxd1XcamLGpyeySqdHGr5cS7E9qZ/n0l3UuZX1X38N7
	71A1Qz3Hnsj65ucRTBTz+h8hNrbFaDeKB4BVu1STxhEW6VaZuMETlQlRaiwV8tiGTj6kUlLkeDI
	JPtBUMY8XJbbuSKfStVwLmvkgZV9x/uTe23NT3o37JA==
X-Gm-Gg: Acq92OHfvlwdMwAdMt8rnFNoTuTOKMfX3xLjlIkFDbtaFv3ZeWZnzwLOsAUzzDHeLJk
	lQdNbS3bxhrlnQ8K4jIdaYhSiAo2RgjsY0QjeV+V6X/0+zbQfXOXAfANbDiyYnsNtigD2nQ8+mB
	9uwXYB0e9s3u7KV+hRylRZ/WJUoQDZKwd7BPZx+vBMjr0LL01HQXIVap2mXvS+kXQWB/idrIzck
	BqABOhCULhsRpYcPTh16erfl77LdHyzZWe5MkhmXSGIOekoayg/8CMz18TCJjh4NdYiHxTCR9b/
	PyPTG7E4kYH7d2e9YzbP3kYace4I3jFInrDOgdnJQurfdOQqgIoUB+ONR69p0tzLYiI/la9NoAU
	RKNoPvv5lzHElDNSv6xVtxlJQ8OJ4su7JEu2r6A==
X-Received: by 2002:a4a:ee18:0:b0:69d:ad54:5162 with SMTP id
 006d021491bc7-69e10192d83mr5068054eaf.4.1780294988377; Sun, 31 May 2026
 23:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429173002565bdp1o7P0bvOs6yTz64yNx@zte.com.cn> <20260429173539941luiwhNDDtflTHOClbNtk4@zte.com.cn>
In-Reply-To: <20260429173539941luiwhNDDtflTHOClbNtk4@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 1 Jun 2026 11:52:56 +0530
X-Gm-Features: AVHnY4Il1BNEsVMx4Pb2vyy_duFGTWacQ7iMEvgRHWuEuaREC5jjQWVrV55h8tQ
Message-ID: <CAAhSdy1LE+oTMgO_C9SBvpqF=SHLOdDLGms5_ajO8pqDm=fFuA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_3=2F3=5D_RISC=2DV=3A_KVM=3A_Recover_gstage_huge_?=
	=?UTF-8?Q?page_mappings_during=C2=A0disable=2Ddirty=2Dlog?=
To: wang.yechao255@zte.com.cn
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 3:05=E2=80=AFPM <wang.yechao255@zte.com.cn> wrote:
>
> From: Wang Yechao <wang.yechao255@zte.com.cn>
>
> When dirty logging is enabled, the gstage mappings are split into
> 4K pages to track dirty pages. If the migration fails or is canceled,
> in order to keep the VM's performance consistent with that before
> dirty logging was enabled, the gstage huge page mappings are recoverd
> when dirty logging is disabled.
>
> With this patch, dirty_log_perf_test shows a decrease in the number of
> vCPU faults:
>
> $ perf stat -e kvm:kvm_page_fault \
> /dirty_log_perf_test -s anonymous_hugetlb_1gb -v 1 -e -b 1G
>
> Before: 524,819      kvm:kvm_page_fault
> After : 263,211      kvm:kvm_page_fault
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---
>  arch/riscv/include/asm/kvm_gstage.h |  4 +++
>  arch/riscv/kvm/gstage.c             | 42 ++++++++++++++++++++++++++
>  arch/riscv/kvm/mmu.c                | 47 +++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm=
/kvm_gstage.h
> index 9c908432bc17..a074493596d1 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -64,6 +64,10 @@ int kvm_riscv_gstage_split_huge(struct kvm_gstage *gst=
age,
>                                 struct kvm_mmu_memory_cache *pcache,
>                                 gpa_t addr, u32 target_level, bool flush)=
;
>
> +void kvm_riscv_gstage_recover_huge(struct kvm_gstage *gstage, gpa_t addr=
,
> +                                  unsigned long taget_page_size,
> +                                  unsigned long *page_size);
> +
>  enum kvm_riscv_gstage_op {
>         GSTAGE_OP_NOP =3D 0,      /* Nothing */
>         GSTAGE_OP_CLEAR,        /* Clear/Unmap */
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index d9fe8be2a151..e2c8cbac30d9 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -337,6 +337,48 @@ int kvm_riscv_gstage_split_huge(struct kvm_gstage *g=
stage,
>         return 0;
>  }
>
> +void kvm_riscv_gstage_recover_huge(struct kvm_gstage *gstage, gpa_t addr=
,
> +                                  unsigned long target_page_size,
> +                                  unsigned long *page_size)
> +{
> +       u32 current_level =3D gstage->pgd_levels - 1;
> +       pte_t *next_ptep =3D (pte_t *)gstage->pgd;
> +       u32 target_level, out_level;
> +       pte_t *ptep, *child_ptep;
> +       int ret;
> +
> +       out_level =3D 0;
> +       ret =3D gstage_page_size_to_level(gstage, target_page_size, &targ=
et_level);
> +       if (ret)
> +               goto out;
> +
> +       while (current_level >=3D target_level) {
> +               ptep =3D (pte_t *)&next_ptep[gstage_pte_index(gstage, add=
r, current_level)];
> +
> +               out_level =3D current_level;
> +               if (!pte_val(ptep_get(ptep)))
> +                       goto out;
> +
> +               /* The mapping is already a huge page mapping. */
> +               if (gstage_pte_leaf(ptep))
> +                       goto out;
> +
> +               next_ptep =3D (pte_t *)gstage_pte_page_vaddr(ptep_get(pte=
p));
> +               current_level--;
> +       }
> +
> +       /* Replace the huge PTE with the first PTE entry of the child.*/
> +       child_ptep =3D (pte_t *)&next_ptep[0];
> +       if (gstage_pte_leaf(child_ptep)) {
> +               set_pte(ptep, __pte(pte_val(ptep_get(child_ptep))));
> +               gstage_tlb_flush(gstage, target_level, addr);
> +               put_page(virt_to_page(next_ptep));
> +       }
> +
> +out:
> +       gstage_level_to_page_size(gstage, out_level, page_size);
> +}
> +
>  void kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
>                              pte_t *ptep, u32 ptep_level, enum kvm_riscv_=
gstage_op op)
>  {
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index dc6a8efde99e..789e3362144f 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -16,6 +16,8 @@
>  #include <asm/kvm_mmu.h>
>  #include <asm/kvm_nacl.h>
>
> +static void kvm_mmu_recover_huge_pages(struct kvm *kvm, int slot);
> +
>  static void mmu_wp_memory_region(struct kvm *kvm, int slot)
>  {
>         struct kvm_memslots *slots =3D kvm_memslots(kvm);
> @@ -160,6 +162,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>                 if (kvm_dirty_log_manual_protect_and_init_set(kvm))
>                         return;
>                 mmu_wp_memory_region(kvm, new->id);
> +       } else {
> +               /*
> +                * Recover huge page mappings in the slot now that dirty =
logging
> +                * is disabled, i.e. now that KVM does not have to track =
guest
> +                * writes at 4KiB granularity.
> +                *
> +                * Dirty logging might be disabled by userspace if an ong=
oing VM
> +                * live migration is cancelled and the VM must continue r=
unning
> +                * on the source.
> +                */
> +               kvm_mmu_recover_huge_pages(kvm, new->id);
>         }
>  }
>
> @@ -598,3 +611,37 @@ void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcp=
u)
>         if (!kvm_riscv_gstage_vmid_bits())
>                 kvm_riscv_local_hfence_gvma_all();
>  }
> +
> +static void kvm_mmu_recover_huge_pages(struct kvm *kvm, int slot)
> +{
> +       struct kvm_memslots *slots =3D kvm_memslots(kvm);
> +       struct kvm_memory_slot *memslot =3D id_to_memslot(slots, slot);
> +       unsigned long hva =3D gfn_to_hva(kvm, memslot->base_gfn);
> +       phys_addr_t start =3D memslot->base_gfn << PAGE_SHIFT;
> +       phys_addr_t end =3D (memslot->base_gfn + memslot->npages) << PAGE=
_SHIFT;
> +       phys_addr_t addr =3D start;
> +       struct kvm_gstage gstage;
> +       unsigned long page_size;
> +
> +       if (!fault_supports_gstage_huge_mapping(memslot, hva))
> +               return;
> +
> +       kvm_riscv_gstage_init(&gstage, kvm);
> +
> +       spin_lock(&kvm->mmu_lock);
> +
> +       while (addr < end) {
> +               if (get_hva_mapping_size(kvm, hva) < PMD_SIZE) {

This is hard-coded to work only for 2MB hugepages.

> +                       addr +=3D PMD_SIZE;
> +                       hva  +=3D PMD_SIZE;
> +                       continue;
> +               }
> +
> +               kvm_riscv_gstage_recover_huge(&gstage, addr, PMD_SIZE, &p=
age_size);
> +
> +               addr +=3D page_size;
> +               hva  +=3D page_size;
> +               cond_resched_lock(&kvm->mmu_lock);
> +       }
> +       spin_unlock(&kvm->mmu_lock);
> +}
> --
> 2.43.5

Regards,
Anup
