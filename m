Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6A82D46C0
	for <kvm@vger.kernel.org>; Sun,  7 Jun 2026 05:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780811350; cv=pass; b=eOOFKltsFnNAVuJmTyy0is/keSpIcYlTviUzx0Ws/CjnxbD09NnB6tEBw5D3m/zUCSJ1cqZfcjQZzaXuVsZ2AaQTML4CHIHvtaWUqb+EaWvM3ljLzC6Iyg7VHomZ/ZGhLUP6As+gvyUw7bFyYG4s9jL8+U5v/mzzi4EJnZ+Cul0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780811350; c=relaxed/simple;
	bh=pHey/UkT9e6hjTUzyGtU0Bm6YFLJCQVuTA/OjxaEuDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFR1qMQmTraB4V7W0bC3F1MgyX2IhpZ3tidPzWjM9eyheOdQgS15BbqRKTFD6LEUzVcpjC3QIW5aLeR6q0AcWAmHiwIp7QFzwoMlNh6bsgwL14QQvFvQG4B1T4fvXV9QuyxjDHTQgDrpBXt3el9XnEvz8OjWAdZVazRrHEVKKRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TMUMl2yU; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TMUMl2yU"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39677242021so31765421fa.1
        for <kvm@vger.kernel.org>; Sat, 06 Jun 2026 22:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780811347; cv=none;
        d=google.com; s=arc-20240605;
        b=G4uTyvj6OFQt1I9HC34CUYh9FMY8TGYw5AsBRTqa4ovqDoug9rfuGo6dXuG7PBlenn
         BRlCyQgQCbrnTZN28isilYO3D6WrCkx7C0fOKvdmcB3lw/dAVUiXwq/2yrjK2+CKf8pn
         nridZ1wI7cegDlb5eiuRORSyjFuDJodBi1+ZQGx5YN5UNH7N7sIyqSqfvQ+HuXz6Q7nS
         EQQ1zo82wQ1+yvMeIVGwir3Bb9Tf1YOqlcBFVr6SlCFxpl9uv/otWfP5hjVzXuZwSrEt
         juXwiydDrZk2L+kN073gd2QrIY/1L7Vj8+oUNhqzyloL/WUQoBKTkXCBdxplUylXs3ef
         U0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NDGuX9OEdV0WxJZIy7dMh7D8y98iOZJkmyFqpGy0K+s=;
        fh=MCH+VWGkGhrEJGh8LAsJsCsGwMGiIhqoeBr66evAnYQ=;
        b=QY2mB41O6eRjacgY7BrtD4jhF3uCkGHZbnGbo3VV4l6oPIVwbapGVh1No7N+I1WBPS
         8D9s5lctitGevuQFGior60/A9MtlypAlVCuoAnLZnbzr35ETtU+QJKWr2bekXS39uec5
         bPd4MKaAqzwnTizgY02QxEl6KXngSYKgP+ckLJ0vSrU03f6Rv7Gx4dRWQp3W11Gs7lnL
         6djCp5NaOkcxtymdAA4oYeuZSLkzc9jZikbl0BQ2jDawoqjXzOLfLZhSdIzo62dN5aOC
         Gv8cC0ZaIcQYwfHrRoCpJfAK/ioDmKw3kVdZYIkDD9pOXALoMLp3imFJxdzLi7G9ZhoV
         bmJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1780811347; x=1781416147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDGuX9OEdV0WxJZIy7dMh7D8y98iOZJkmyFqpGy0K+s=;
        b=TMUMl2yUYPZIgMLNiRjxkiUVnH7G2pv7RkGju4QvuvKs336hKxnldpOt9w8I/9LdkM
         6bjYgon5Zgk/CP2xvg0uLs5uvy64nkHQnljH0ZcplAfirpZfryKdUQDnXfEVJVSXaYm5
         gnDV26SO/ASytyT42jtblxbplfXm7+39QR7DlqC++PobFbomXodBPpNaHbDX0jNJrAuo
         vNPrHXsyHcbtEjF1lYmTciBgbvpopsu4BvKSTEo/k+CXlzpxvpxBbgffp21eNWGqZVUS
         EJ/riSxJk6IFCY5XYRXehLR9pnniNjf11O6sZSVEf42yJluTrsQ0RwhIHYc0dC+8pj+N
         F7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780811347; x=1781416147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NDGuX9OEdV0WxJZIy7dMh7D8y98iOZJkmyFqpGy0K+s=;
        b=LOyXoCHAcp/1h/Y2zvufa8bVfqiin24+IY5VS18O15wcT8E5v2f6MpPusaqMwehwdh
         yS0va7WFcPOgL2277pPcRgvWCw9nsdpnApOeZUwefgdAomfSiu5oJVvl9BREjhD2CH0j
         5H2DlBVsTiKyBL9dp1Z8maENoXQadCo4Gvy9LweOTJ3BmFbfKNRIQE9bpjFMQ2GM43sl
         BwH4MPbgkk7AJk1NnR+6ovh83kp9IUPxpta0CaFUxNbRfciNZKwgUSTBwayQw7WViBp4
         vZXqq83ukAp5Wx32dFtEfYNgi8JAkHfWGGZTZz/eRXzl+iOPPAr4vbkBQNVsL/jECUQz
         OcJA==
X-Forwarded-Encrypted: i=1; AFNElJ9/9hp+sNpwLNqH1MR8Kv/hM62I1QKB+v4wnfc3Isb2ERz100/pXE87wsOEaaKxe/6MghQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWvUquRwlGfpIKUB4Sbom5zGWH5XM2Q9SbifXw0ypIRXTX4OiX
	tPMdahQAT7eXEg4JV7FgeyMLyez7XW4yIXhxjvcnkL+rx0MaOC7HPte+5CqagYV+0/nim56+unQ
	87b6rASWMVQGdzk6xmZV2EnBA/RhumR8a6DBWsWCIug==
X-Gm-Gg: Acq92OEoDCL/w73iDvJpAky7RwgJrMEtrbTbmUiI6smMVjaa7Up0xbb/ht83tblMHeQ
	5dkVTPIW3fRQMuzzN/tA+f2q6CoZuirUFYunQORUXohQ8l/ShREJHCGfoA/3KvnBeA9NLlRAo9B
	+2/PP5b93wBLUzdmW8ovDA7SikQ+r3z88n45++Iw9htAQgnm/rt/bMs18KyJY+SkH9pYriPiJER
	IrscAEdP5qlCzI1T/2X+pLNAcnVnfHWHHU8LOxCEZ7F88uoaj2BQQ+9LFlzIiEpNyNqMViMDT6Q
	j6C4ob+RR5w0Vj91hdwrwCelQe8x1rqn1vL/faUBM4UFhcWQwb2t
X-Received: by 2002:a05:6512:3f07:b0:5aa:6b19:b357 with SMTP id
 2adb3069b0e04-5aa87b8a247mr3429733e87.3.1780811346628; Sat, 06 Jun 2026
 22:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604142602.3582602-1-tjytimi@163.com> <20260604142602.3582602-2-tjytimi@163.com>
In-Reply-To: <20260604142602.3582602-2-tjytimi@163.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Sun, 7 Jun 2026 11:18:55 +0530
X-Gm-Features: AVVi8CfHf4TZOApnOTYpsrfb2YZXExiqoE3V-jWe65JblzsSS9KztXhZX9w1KXI
Message-ID: <CAK9=C2XGRgz+3c2Rf8bj8tPtAiCpHXrsm2sNC1b7qHt-5p6PZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: riscv: Check hugetlb block mappings against
 memslot bounds
To: Jinyu Tang <tjytimi@163.com>
Cc: Anup Patel <anup@brainfault.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 7:58=E2=80=AFPM Jinyu Tang <tjytimi@163.com> wrote:
>
> RISC-V KVM has used the hugetlb VMA size directly as the G-stage
> mapping size since stage-2 page table support was added. That is safe
> only if the block covered by the fault is fully contained in the
> memslot and the userspace address has the same offset as the GPA
> within that block.
>
> The THP path already checks those constraints before installing a PMD
> block mapping. The hugetlb path did not, so an unaligned memslot could
> make KVM install a PMD or PUD sized G-stage block that covers memory
> outside the slot or maps the wrong host pages.
>
> Pass the target mapping size into fault_supports_gstage_huge_mapping().
> The same helper can be used for both THP PMD mappings and hugetlb
> PMD/PUD mappings.
>
> Select hugetlb mapping sizes through the same memslot-boundary check,
> falling back from PUD to PMD to PAGE_SIZE. When a smaller hugetlb
> mapping size is selected, fault the GFN aligned to that selected size
> instead of the original VMA size.
>
> Also keep hugetlb mappings out of transparent_hugepage_adjust(). Once
> the hugetlb path has chosen PAGE_SIZE, promoting it again through the
> THP helper would miss the hugetlb fallback decision.
>
> Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programmin=
g")
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

> ---
> v1 -> v2:
>   - Squash the helper parameterization into this hugetlb fix.
>   - Use the ALIGN()/ALIGN_DOWN() form suggested by Nutty Liu and Anup
>     for the memslot boundary check.
>
>  arch/riscv/kvm/mmu.c | 54 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 44 insertions(+), 10 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 2d3def024..0adf017a2 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -286,7 +286,8 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn=
_range *range)
>  }
>
>  static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *m=
emslot,
> -                                              unsigned long hva)
> +                                              unsigned long hva,
> +                                              unsigned long map_size)
>  {
>         hva_t uaddr_start, uaddr_end;
>         gpa_t gpa_start;
> @@ -300,8 +301,8 @@ static bool fault_supports_gstage_huge_mapping(struct=
 kvm_memory_slot *memslot,
>
>         /*
>          * Pages belonging to memslots that don't have the same alignment
> -        * within a PMD for userspace and GPA cannot be mapped with g-sta=
ge
> -        * PMD entries, because we'll end up mapping the wrong pages.
> +        * within a huge page for userspace and GPA cannot be mapped with
> +        * g-stage block entries, because we'll end up mapping the wrong =
pages.
>          *
>          * Consider a layout like the following:
>          *
> @@ -321,7 +322,7 @@ static bool fault_supports_gstage_huge_mapping(struct=
 kvm_memory_slot *memslot,
>          *   e -> g
>          *   f -> h
>          */
> -       if ((gpa_start & (PMD_SIZE - 1)) !=3D (uaddr_start & (PMD_SIZE - =
1)))
> +       if ((gpa_start & (map_size - 1)) !=3D (uaddr_start & (map_size - =
1)))
>                 return false;
>
>         /*
> @@ -336,7 +337,8 @@ static bool fault_supports_gstage_huge_mapping(struct=
 kvm_memory_slot *memslot,
>          * userspace_addr or the base_gfn, as both are equally aligned (p=
er
>          * the check above) and equally sized.
>          */
> -       return (hva >=3D ALIGN(uaddr_start, PMD_SIZE)) && (hva < ALIGN_DO=
WN(uaddr_end, PMD_SIZE));
> +       return (hva >=3D ALIGN(uaddr_start, map_size)) &&
> +              (hva < ALIGN_DOWN(uaddr_end, map_size));
>  }
>
>  static int get_hva_mapping_size(struct kvm *kvm,
> @@ -404,7 +406,7 @@ static unsigned long transparent_hugepage_adjust(stru=
ct kvm *kvm,
>          * sure that the HVA and GPA are sufficiently aligned and that th=
e
>          * block map is contained within the memslot.
>          */
> -       if (fault_supports_gstage_huge_mapping(memslot, hva)) {
> +       if (fault_supports_gstage_huge_mapping(memslot, hva, PMD_SIZE)) {
>                 int sz;
>
>                 sz =3D get_hva_mapping_size(kvm, hva);
> @@ -421,12 +423,33 @@ static unsigned long transparent_hugepage_adjust(st=
ruct kvm *kvm,
>         return PAGE_SIZE;
>  }
>
> +static unsigned long hugetlb_mapping_size(struct kvm_memory_slot *memslo=
t,
> +                                         unsigned long hva,
> +                                         unsigned long map_size)
> +{
> +       switch (map_size) {
> +       case PUD_SIZE:

As pointed out by sashiko-bot, we need a "#ifndef CONFIG_32BIT" over here.
I have taken care at the time of merging this patch.

> +               if (fault_supports_gstage_huge_mapping(memslot, hva, PUD_=
SIZE))
> +                       return PUD_SIZE;
> +               fallthrough;
> +       case PMD_SIZE:
> +               if (fault_supports_gstage_huge_mapping(memslot, hva, PMD_=
SIZE))
> +                       return PMD_SIZE;
> +               fallthrough;
> +       case PAGE_SIZE:
> +               return PAGE_SIZE;
> +       default:
> +               return map_size;
> +       }
> +}
> +
>  int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *mem=
slot,
>                       gpa_t gpa, unsigned long hva, bool is_write,
>                       struct kvm_gstage_mapping *out_map)
>  {
>         int ret;
>         kvm_pfn_t hfn;
> +       bool is_hugetlb;
>         bool writable;
>         short vma_pageshift;
>         gfn_t gfn =3D gpa >> PAGE_SHIFT;
> @@ -460,16 +483,23 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct=
 kvm_memory_slot *memslot,
>                 return -EFAULT;
>         }
>
> -       if (is_vm_hugetlb_page(vma))
> +       is_hugetlb =3D is_vm_hugetlb_page(vma);
> +       if (is_hugetlb)
>                 vma_pageshift =3D huge_page_shift(hstate_vma(vma));
>         else
>                 vma_pageshift =3D PAGE_SHIFT;
>         vma_pagesize =3D 1ULL << vma_pageshift;
>         if (logging || (vma->vm_flags & VM_PFNMAP))
>                 vma_pagesize =3D PAGE_SIZE;
> +       else if (is_hugetlb)
> +               vma_pagesize =3D hugetlb_mapping_size(memslot, hva, vma_p=
agesize);
>
> +       /*
> +        * For hugetlb mappings, vma_pagesize might have been reduced fro=
m the
> +        * VMA size to a smaller safe mapping size.
> +        */
>         if (vma_pagesize =3D=3D PMD_SIZE || vma_pagesize =3D=3D PUD_SIZE)
> -               gfn =3D (gpa & huge_page_mask(hstate_vma(vma))) >> PAGE_S=
HIFT;
> +               gfn =3D ALIGN_DOWN(gpa, vma_pagesize) >> PAGE_SHIFT;
>
>         /*
>          * Read mmu_invalidate_seq so that KVM can detect if the results =
of
> @@ -511,8 +541,12 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct =
kvm_memory_slot *memslot,
>         if (mmu_invalidate_retry(kvm, mmu_seq))
>                 goto out_unlock;
>
> -       /* Check if we are backed by a THP and thus use block mapping if =
possible */
> -       if (!logging && (vma_pagesize =3D=3D PAGE_SIZE))
> +       /*
> +        * Check if we are backed by a THP and thus use block mapping if
> +        * possible. Hugetlb mappings already selected their target size =
above,
> +        * so do not promote them through the THP helper.
> +        */
> +       if (!logging && !is_hugetlb && vma_pagesize =3D=3D PAGE_SIZE)
>                 vma_pagesize =3D transparent_hugepage_adjust(kvm, memslot=
, hva, &hfn, &gpa);
>
>         if (writable) {
> --
> 2.43.0
>

Queued this patch for Linux-7.2

Thanks,
Anup
