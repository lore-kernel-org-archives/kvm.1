Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3CF3A4F50
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791063197; cv=pass; b=oSCvgPNZ9pQTpPc7T+eKKPgVBA/gRr8vHn/pfW0odI+Tgq7xkjSFPnDd2u2CAeePeC5cOqu4fMYX5DlGfhE9FpTAfWkiBJGaXhpDewdaIoTYdzmV/qTSkcntI2itWElO74YTa68voUFg7j7RWRGkvM1ritXdh0AVjUK39C7QKVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791063197; c=relaxed/simple;
	bh=ZIBhrntP8+qxeEqIpQb91mOxIVspTOx+NPlmlo2K79c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcABouMJpWfJ1iDE5NCX0Qml/zM8OPQI3JfNjdKC3Gr5ONZGKQFzrFQy23U9tLXuVDziT5ObPyONxfmyec27JvnQwsApMXertvC294NvDTkpvMLhOv31EkyQFq6iN8CoLMM33IaysREb2emhsbLvtOUSOrHWOZorP/subW2m8M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=b9h1mQB3; arc=pass smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="b9h1mQB3"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-48b0fc598f8so298580f8f.2
        for <kvm@vger.kernel.org>; Sat, 03 Oct 2026 14:33:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791063193; cv=none;
        d=google.com; s=arc-20260327;
        b=dN6+cND8U1xLfuT95dR+YY5P6x+rR/24lNRRRldiZOsecMKDCHg8Nz1oH66BpR6sSD
         AUh5eEnRLcW2B1mOm/MoebGIPcDToimLYxLxfe+crMHK2w0ReGoHNgL2MDK/Lm9q9cLk
         drzZjhJUymNo7dmiRq96/byDwreYMYHwlNMR+uzPZU+x4z6JtPJQTayEdojDI6QajhIw
         ursIW6vGM3SfRWEuimQF8+QFqNQvlm7+0xXk1GRPoT2CQk+zJz77SpPsPMl/snagw4t4
         XMeJ1WYlWs6cdY1xSdzN7TyVDAYafi/zLywX8d2DMgDui5AAM6/cShqNh0xFYmvOXTlu
         74bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qfZvs7JHnwLbB5TOb4/EZHNkBzF/EHZB9b3YDWrj+qc=;
        fh=oeWbIiiAJhRNK2jJTGqHPS0CjegpmiaaonlT00w9q8c=;
        b=op5TqswaAtERDDoVTGI9xC6GUR4OqhAgpSsOA1L+aZ1eqhsVaTE4FaKeN5FUwtaSco
         nZb1nLw+r7nPaQfoIOA4qMnViGdzHIAefiuyg9ahQmDJ03wDzuEpnF9W4YxUAfJamN+J
         CK6IwZJZnvdTdJcl4PAEWU5aAqDRnKJe27o+EO1Gjn+iRNCu2qBzgSbRslJzhdCaUUQR
         zv0z8UWk18oihFxZosL8aOwBS4vZ0HhD1RPeqzvIrFbLuem1jmYsusmELJeCWO1r5NnO
         IlR4DcmBeNAgyi9HBlAHc9oAyZoavLYMBOpisP3J6zSBROd+xmI1JmeWeQ2yDhJ3b022
         +gsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1791063193; x=1791667993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qfZvs7JHnwLbB5TOb4/EZHNkBzF/EHZB9b3YDWrj+qc=;
        b=b9h1mQB33U3g6N/GXja/y9MG8VQxGFxSa2PhDrVi3pbIz4xsK2O+n9cewvNgKpUBa7
         DQd07QiPH6WUxIUnS+fin0JICEUlfthjSm1mmCjhmuVxePQZovQbEkUGxC5+F0ZaiCDB
         o50ML1y4TlaNXiTTjP1qijbKzhqvwpa2dxEfCmralxS7QiGBAdIxztRnef6yPuVfdqSk
         24ejB+8jCJpVOgNCJAgp2UJWCBXG2Y94cbzIQNmA7MhPlMhuc7vEnM1Gh8ZgFtAbgS7J
         kwOD9umHAhbKsL9+bTohv40oEl81Vsyi4q5b8WiJOAxS+VV+0d1OJ+ZF0DH4sk28ipUb
         vq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791063193; x=1791667993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qfZvs7JHnwLbB5TOb4/EZHNkBzF/EHZB9b3YDWrj+qc=;
        b=I360pHRi7sTsiRAgrHyOCSx+VuUdUItFt9gOWsuZvWlKcpC2wvP79IvQGPZRdrGH/y
         16Rw/vgi8+3QGQ7Mk0ZOLybtyaCdYqmL+nZAASi0gAegAlPYIpZb6CHoq4/3AVdkd38V
         6hRFysjTjCneLo+LT//5TDetZgauEK2OY3npTh6KuQx9tj6rsSirRD9eixR5XDfar1q0
         0E6ONjEXgYLgUeb5pCzk56UowteqeLshmNBn4yqV1W41dhXqGgajx89Y0BHat8aiTSck
         wIHPFH9wqveM4hc7wntnfeHj7Vcx08MIpoWHy3G+deryjV5nKpO4IEr7lFxmvjybTk/L
         mYyA==
X-Forwarded-Encrypted: i=1; AKwUvBx5IMVFQ/W+3jFW3f/9UAoD166R4PT0frgxWOI1sWgcq8B0AA43cZUVQ+9t3C4AeP6rol4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlxHvMyq34PZl/kPTF89WpI0sHpDCWYO4NuoR1rHOxe0Ni6vID
	zKnQex48P796ShPLebvmr6MCBygenKSMnyEe1/XocMDnEx8vlNOh4KcL2suSkF9e7ibOLIwimYx
	ZzFK0irAYaL8u/TMwu7U4EBuCmco0kgqW3ywBYtsIIA==
X-Gm-Gg: AYBFou1JL4cEKO9UEj/Fzfqv4pDzEvca6AzAPODq3P1dQ1C++3mrS+YudzNP7DgwsB8
	qsbiCYF/W/fTBQ/Hnm/AHiuaxuVkWFY4POHqD5h7sNsoV6w6ioGFmUOumw2IZzJ5508jx/Br6u8
	G+ROmCvQPx/Dq1X5GHPjVBLeGj3zyjixxOc0j5Kir2EeWfjJlcGfDDjdSoQ+8NckN+3i7Do50em
	hQF1hPBQAt5RmtPBgTgAE4avVZ/8NkrH/q95q4mvZLgLc/n1pokV8rAnRu/0n2Y2V4WSia/xvGC
	o9IS1VviXIhj/5lFP6MMWo+V4z3rFRJ4T7TItLwsh+4GUl7nStY+FdvZgp8zkvHQeV3XB1mukLV
	2N5ZD0xLTDrZWsw6Ye/lozTErQYBI62XZxtiRvWtm1wQFt65oKE1DMltUOWvp2U9otVadMarqhc
	XcDM5MgVtf
X-Received: by 2002:a05:6000:2008:b0:48c:557d:ab24 with SMTP id
 ffacd0b85a97d-48c557daf9fmr296756f8f.4.1791063192798; Sat, 03 Oct 2026
 14:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815102833.864330-1-jinyu.tang@linux.dev> <20260815103123.864738-1-jinyu.tang@linux.dev>
In-Reply-To: <20260815103123.864738-1-jinyu.tang@linux.dev>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 4 Oct 2026 03:00:50 +0530
X-Gm-Features: AclHuK_HLZyYPpTxHZ72T9yKE8JtgWcR285DcDxiQ-zUi9vakSvTlMiSylojJss
Message-ID: <CAAhSdy01fWGXx37Nq1LsVWajoH8B_O=hvU0b4vw5AsnOQm054w@mail.gmail.com>
Subject: Re: [PATCH v4 RESEND 1/5] KVM: riscv: Avoid overwriting G-stage
 tables with huge leaves
To: Jinyu Tang <jinyu.tang@linux.dev>
Cc: Anup Patel <apatel@ventanamicro.com>, Atish Patra <atish.patra@linux.dev>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Yong-Xuan Wang <yongxuan.wang@sifive.com>, 
	Nutty Liu <nutty.liu@hotmail.com>, Jinyu Tang <tjytimi@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 4:01=E2=80=AFPM Jinyu Tang <jinyu.tang@linux.dev> w=
rote:
>
> RISC-V KVM can overwrite an existing G-stage table entry when
> installing a huge leaf mapping. If the target huge range already has a
> lower-level page table, kvm_riscv_gstage_set_pte() can replace the
> non-leaf entry with a leaf PTE and disconnect the lower-level page
> table.
>
> Reject replacing a valid table entry with a leaf PTE. If huge-page
> installation hits such a conflict, fall back to a 4K mapping for the
> original faulting GPA in the MMU fault path, where the original GPA and
> HFN are still available.
>
> Suggested-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programmin=
g")
> Signed-off-by: Jinyu Tang <jinyu.tang@linux.dev>
> ---
>  arch/riscv/kvm/gstage.c |  6 ++++++
>  arch/riscv/kvm/mmu.c    | 24 +++++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index e5002cb9cbef..54d45addf18f 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -174,6 +174,12 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gsta=
ge,
>
>         if (pte_val(*ptep) !=3D pte_val(map->pte)) {
>                 bool was_invalid =3D !pte_val(*ptep);
> +
> +               /* Avoid replacing an existing lower-level table with a l=
eaf mapping. */
> +               if (!gstage_pte_leaf(ptep) && !was_invalid &&
> +                   gstage_pte_leaf(&map->pte))
> +                       return -EEXIST;
> +
>                 set_pte(ptep, map->pte);
>                 if (gstage_pte_leaf(ptep) &&
>                     !(was_invalid && riscv_has_extension_unlikely(RISCV_I=
SA_EXT_SVVPTC)))
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 6035b5ec9503..bfd6168ebe30 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -625,10 +625,11 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct=
 kvm_memory_slot *memslot,
>                       struct kvm_gstage_mapping *out_map)
>  {
>         int ret;
> -       kvm_pfn_t hfn;
> +       kvm_pfn_t fault_hfn, hfn;
>         bool is_hugetlb;
>         bool writable;
>         unsigned int vma_pageshift;
> +       gpa_t fault_gpa =3D gpa;
>         gfn_t gfn =3D gpa >> PAGE_SHIFT;
>         struct vm_area_struct *vma;
>         struct kvm *kvm =3D vcpu->kvm;
> @@ -709,6 +710,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>         }
>         if (is_error_noslot_pfn(hfn))
>                 return -EFAULT;
> +       fault_hfn =3D hfn + ((fault_gpa >> PAGE_SHIFT) - gfn);
>
>         /*
>          * If logging is active then we allow writable pages only
> @@ -734,9 +736,29 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct =
kvm_memory_slot *memslot,
>                 mark_page_dirty_in_slot(kvm, memslot, gfn);
>                 ret =3D kvm_riscv_gstage_map_page(&gstage, pcache, gpa, h=
fn << PAGE_SHIFT,
>                                                 vma_pagesize, false, true=
, out_map);
> +               if (ret =3D=3D -EEXIST) {
> +                       /*
> +                        * Retry at 4K granularity for the original fault=
ing GPA
> +                        * when a huge leaf cannot replace an existing ta=
ble.
> +                        */
> +                       ret =3D kvm_riscv_gstage_map_page(&gstage, pcache=
, fault_gpa,
> +                                                       fault_hfn << PAGE=
_SHIFT,
> +                                                       PAGE_SIZE, false,=
 true,
> +                                                       out_map);
> +               }

If you were attempting to map 1G hugepage then you should first try
2M and not 4K. This patch needs more work.

>         } else {
>                 ret =3D kvm_riscv_gstage_map_page(&gstage, pcache, gpa, h=
fn << PAGE_SHIFT,
>                                                 vma_pagesize, true, true,=
 out_map);
> +               if (ret =3D=3D -EEXIST) {
> +                       /*
> +                        * Retry at 4K granularity for the original fault=
ing GPA
> +                        * when a huge leaf cannot replace an existing ta=
ble.
> +                        */
> +                       ret =3D kvm_riscv_gstage_map_page(&gstage, pcache=
, fault_gpa,
> +                                                       fault_hfn << PAGE=
_SHIFT,
> +                                                       PAGE_SIZE, true, =
true,
> +                                                       out_map);
> +               }
>         }
>
>         if (ret)
> --
> 2.43.0
>

Regards,
Anup
