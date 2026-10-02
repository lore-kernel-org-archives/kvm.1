Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7971282F1E
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790923439; cv=pass; b=bU175Zke21zZBuDovL5Vdif0PQ3CPbAX6Exu9p16fnDVUusxgKsdgliYQtrrO7wkGJr1ijr8R1wR2YZXJCzFPpaW+RU1XFscMMgfZNlmq4YcGALHiCKoJrREe45QHC/+3ulFDdY3aQWr6UX5JZh6oTsaP/5AX5cfLK6g+A7LC9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790923439; c=relaxed/simple;
	bh=kN/ZfoXigEvjllCLgCtkDiiC554RlGPjYYRHakPpRPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPv/N34qXApmAFtr6pqQxz3jd7JrKklX+Bd4jIW9tF8/PYRgoRtEai43TBfmD0bknolAqOiI4CoMb5sOh8dNYqxtFVdDvnIIPky6FXrRA3i+6A7QwTskWVaMahv+WYTbf/UebSyvxUIeJOJZ9Q/uOZebe6W5zqj31lUQCtyOXAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=Jm0MZw7O; arc=pass smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="Jm0MZw7O"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b0f4efe31so773041f8f.2
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 23:43:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790923436; cv=none;
        d=google.com; s=arc-20260327;
        b=j1VW4yroMFD544XR1w8oRh7IyClkKrOCnqq+y+MFR2yLPSNC6EDKYKNHGdRox1d8Ee
         MxkwBizCsgjablusIPa9ymA36idofz9X9jXIV1n/qYhNPWKf5Pw/VUHnyQGOZ/39W6fz
         cXwpVr8dPJjdOZ8YGfi22/IoupEECgS2QnWQVoK9GJb6m+w3pgLTm7S9OiiuebbKlfTY
         ruvE5dXHhwqD8Rndxi0vAxvBlMzLfLS3nLSKU1ECzvp7qRyYcrHSUnC9Fo/vDWIhPi9z
         FZ7P0pUyOq05ITmFBAQxED2QBKqy4W83kwW0k8G5OcbqrkugTzwuIasjXPt84crZ4Aoi
         Gy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l84c6MY9kr7mtiSyCjFx+8uzC+nw3LEGUJpYcm7QQ/w=;
        fh=Ly2CowFblez5gIeTtwcfo6dm8THYEQwNiJzzO7/T/yI=;
        b=Y83g2zT9/Giv0rYWdD0l6OAEdsFByYUufQsdoYoSaRQpQbFYno4uAv7BV37+nUGXdE
         53W6N1jHQy6pMi9WJl0UDJWEg3pxsCG9E/08m6LW/aAw0fLIRcVjr1o/gN4xW+T70mdC
         qp3ULmDOtXpGFErkDkVDEcCZ92jNw8gJK2dlKFhZD6tv8UKeHyvgpKwbh6nQpdbrNtDX
         VRuhZx/Iy2fELMp1vQezU6OO2pYdJxt2BVWw1+VDVGyWDoIe6Y0JuFLfOz1mqc3c5IfM
         ++xc3nl43SowpDp7c+9GDSSdNd72CZISuSswpH46kLbzT7cvhv2irg3UPTmTs8uZ82uY
         OKuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1790923436; x=1791528236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l84c6MY9kr7mtiSyCjFx+8uzC+nw3LEGUJpYcm7QQ/w=;
        b=Jm0MZw7Olt+htIeokb76e34lufZfrJaAy/5hrLDipMjMTwg/t7WwlnlEJGg2sIjvL2
         SefuBP/Xa1ziPl6OsbOMxM4ES9bjK3ri2J/l+/Hpqxo2uyE7m97L+NbhLoYj8AXTvdst
         Z6RhwvXG2LKu2GPszAi+BH2bfcAYf9+gz0kWqg7ISQf+FXq7j5punEA3lmVRglHoEjlG
         nJGBS6zzH2BOCH98GSVG8/RvV7RajPDoxjEqP2O6r9u5TW+q/U+Su0un9DJhO4rPbVWH
         GiQuLt5rmF/MtgEJzIhfeemC87kRu+698zxFyaBzv4+7vpjRptlFku0ZzS2YKvojeBQ+
         qrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790923436; x=1791528236;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l84c6MY9kr7mtiSyCjFx+8uzC+nw3LEGUJpYcm7QQ/w=;
        b=fbTi+qISGqDzVp2/k5qBjcrKD5IF7g+a1+7RstHq/UzV93TkNra2pasm9Jy0dupOkL
         DtLNr1MDxSzw6SBjw2IyX7wSt3qZvt4tfZKPkJmBDXukDzOAHNUlPfdDKXflZIc9/WbL
         g5JoNbcwEODTuRxiOkuqlNN+cCOiy2s5+LZtfPFxX4PsMUcP6GjtOgMEhyAWgDL78fNF
         EL9jdxgUozZ50+eDX4l5DW+UPQhc2nkh7NSUjWUU1XUtpT9nmqB6AgisjjbS+Kga+ojW
         +qnHcPbZ0+/MVQQ0MjyCpxhWx6P/3Z2b7cHR1k2O8FdegP4dkmeJ0yR4ik7TPGLc6Kdm
         l3fg==
X-Forwarded-Encrypted: i=1; AKwUvBxD35D7wrovASxMtQYrCRex0eGbASHcF5jozCmMP49tef+Va/tm/n2GXgn9m2s7O+oJbpM=@vger.kernel.org
X-Gm-Message-State: AFuF++lIzL/IKxWbxrsOzHkwmdQsPAxcfptjk3x97nvhRnkTX6XOUwhH
	W35XoNDgYEjea9tbHomOpon6Lf6qS7ogjwkzq5179cxMPQupHP8Ih4VlQtW2o06BWESKmrnO7R8
	/3HgdBVxmrShyxjPilYm4nFi7xc+gvDrfr8otqoCWg2tycBBwVLEMMP8=
X-Gm-Gg: AYBFou0Qprm1408P1EULRMYeuUaQW1k3plPxdOWz++uAXzCRUf+OKWS20ulOOjXjVxq
	z3vYmFSCjeB6t6TCdGur7FAtokPtR+94AFXmrmj6TizW8wErV/z2MNQE1UCTZUScoPGu9oN6TZz
	cA3AFm+7XFRlZPeADOfba52haCCy2zVLSgcuEInapqFwjiwD1uZAGYrDIWZtZDkROP0Mfrsxk1z
	vz1l+0nnEjnP9xMExzUzxk2Aa71l3KWh3ZQFa7alen7n5S/6pX3JK3zJgXk65qNABI0i3MSktSF
	ddUnUsUtOK5XquzudeZ8mLrI8mbBkapwGXVRSzSl3hVh8VVUj0GXb+B5RaaXher+FK1ofe+qRGC
	gMyU0rBgzrqYWUDgcChZBI1a3uMuXe8Uf3s96l33sOGvE2QieOlbhLu1iKFuVIZfB6dK1KMa0N2
	o=
X-Received: by 2002:a05:600c:468b:b0:49d:1df8:156d with SMTP id
 5b1f17b1804b1-4a0276bfcc8mr30536265e9.18.1790923435973; Thu, 01 Oct 2026
 23:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3bb2f519-c70b-6c35-c404-6fbfe8adbeb1@kernel.org>
 <20260728161449.190058-1-fredwudi0305@gmail.com> <20260728161449.190058-4-fredwudi0305@gmail.com>
In-Reply-To: <20260728161449.190058-4-fredwudi0305@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 2 Oct 2026 12:13:43 +0530
X-Gm-Features: AclHuK8CD08vpUeFLfojAvm02ZvIIAgLzxbiawqJaJUjzDA2zDtrA-_OIsDgSg8
Message-ID: <CAAhSdy1SdSzBnZp54V_FrG8ccUhmmZOWWBCHxPn0+WPBG=SPAw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] KVM: riscv: Register ptdump with debugfs on guest creation
To: "Dylan.Wu" <fredwudi0305@gmail.com>
Cc: paul.walmsley@sifive.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, atish.patra@linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	Quan Zhou <zhouquan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 9:45=E2=80=AFPM Dylan.Wu <fredwudi0305@gmail.com> w=
rote:
>
> Implement the gstage page table dumper for RISC-V KVM, which exposes
> the guest's gstage page tables via debugfs. When
> CONFIG_PTDUMP_GSTAGE_DEBUGFS is enabled, a "gstage_page_tables" file
> will be created under each VM's debugfs directory.
>
> This reuses the ptdump framework from the kernel page table dumper,
> with gstage-specific attribute bits and level definitions.
>
> Assisted-by: YuanSheng: deepseek-v4-pro
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Dylan.Wu <fredwudi0305@gmail.com>
> ---
>  arch/riscv/kvm/Kconfig  |  12 +++
>  arch/riscv/kvm/Makefile |   1 +
>  arch/riscv/kvm/ptdump.c | 177 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 190 insertions(+)
>  create mode 100644 arch/riscv/kvm/ptdump.c
>
> diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
> index ec2cee0a3..6d62b967f 100644
> --- a/arch/riscv/kvm/Kconfig
> +++ b/arch/riscv/kvm/Kconfig
> @@ -37,4 +37,16 @@ config KVM
>
>           If unsure, say N.
>
> +config PTDUMP_GSTAGE_DEBUGFS
> +       bool "Present the gstage pagetables to debugfs"
> +       depends on KVM && DEBUG_KERNEL && DEBUG_FS && PTDUMP_DEBUGFS
> +       default n
> +       help
> +         Say Y here if you want to show the RISC-V KVM gstage guest
> +         page tables in debugfs under each VM's debugfs directory as
> +         a file named "gstage_page_tables". This allows inspection of
> +         the second-stage address translation setup for each guest.
> +
> +         If unsure, say N.
> +
>  endif # VIRTUALIZATION
> diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
> index 296c2ba05..905593d6f 100644
> --- a/arch/riscv/kvm/Makefile
> +++ b/arch/riscv/kvm/Makefile
> @@ -19,6 +19,7 @@ kvm-y +=3D isa.o
>  kvm-y +=3D main.o
>  kvm-y +=3D mmu.o
>  kvm-y +=3D nacl.o
> +kvm-$(CONFIG_PTDUMP_GSTAGE_DEBUGFS) +=3D ptdump.o
>  kvm-y +=3D tlb.o
>  kvm-y +=3D vcpu.o
>  kvm-y +=3D vcpu_config.o
> diff --git a/arch/riscv/kvm/ptdump.c b/arch/riscv/kvm/ptdump.c
> new file mode 100644
> index 000000000..f436ad48c
> --- /dev/null
> +++ b/arch/riscv/kvm/ptdump.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 SiFive
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/ptdump.h>
> +#include <linux/seq_file.h>
> +
> +#include <linux/kvm_host.h>
> +#include <asm/kvm_gstage.h>
> +#include <asm/pgtable.h>
> +#include <asm/ptdump.h>
> +
> +enum gstage_address_markers_idx {
> +       GSTAGE_GPA_START_NR,
> +       GSTAGE_GPA_END_NR,
> +       END_OF_GSTAGE_SPACE_NR
> +};
> +
> +static const struct ptdump_prot_bits gstage_pte_bits[] =3D {
> +       {
> +               .mask =3D _PAGE_DIRTY,
> +               .set =3D "D",
> +               .clear =3D ".",
> +       }, {
> +               .mask =3D _PAGE_ACCESSED,
> +               .set =3D "A",
> +               .clear =3D ".",
> +       }, {
> +               .mask =3D _PAGE_GLOBAL,
> +               .set =3D "G",
> +               .clear =3D ".",
> +       }, {
> +               .mask =3D _PAGE_USER,
> +               .set =3D "U",
> +               .clear =3D ".",
> +       }, {
> +               .mask =3D _PAGE_EXEC,
> +               .set =3D "X",
> +               .clear =3D ".",
> +       }, {
> +               .mask =3D _PAGE_WRITE,
> +               .set =3D "W",
> +               .clear =3D ".",
> +       }, {
> +               .mask =3D _PAGE_READ,
> +               .set =3D "R",
> +               .clear =3D ".",
> +       }, {
> +               .mask =3D _PAGE_PRESENT,
> +               .set =3D "V",
> +               .clear =3D ".",
> +       }
> +};
> +
> +static struct ptdump_pg_level gstage_pg_levels[] =3D {
> +       { /* pgd */
> +               .bits =3D gstage_pte_bits,
> +               .num =3D ARRAY_SIZE(gstage_pte_bits),
> +               .name =3D "PGD",
> +       }, { /* p4d */
> +               .bits =3D gstage_pte_bits,
> +               .num =3D ARRAY_SIZE(gstage_pte_bits),
> +               .name =3D "P4D",
> +       }, { /* pud */
> +               .bits =3D gstage_pte_bits,
> +               .num =3D ARRAY_SIZE(gstage_pte_bits),
> +               .name =3D "PUD",
> +       }, { /* pmd */
> +               .bits =3D gstage_pte_bits,
> +               .num =3D ARRAY_SIZE(gstage_pte_bits),
> +               .name =3D "PMD",
> +       }, { /* pte */
> +               .bits =3D gstage_pte_bits,
> +               .num =3D ARRAY_SIZE(gstage_pte_bits),
> +               .name =3D "PTE",
> +       },
> +};

As Sashiko pointed, this gstage dumper is already broken
because:
1) We cannot assume that all tables at all levels of G-stage are
of same size. For example, the root G-stage table is 16KB and
not 4KB
2) Number of page table levels can vary between two Guests/VMs
since we allow KVM user-space to change the number GPA bits
which in-turn changes the number of G-stage levels.

> +
> +static void gstage_note_page(struct ptdump_state *pt_st, unsigned long a=
ddr,
> +                            int level, u64 val)
> +{
> +       struct ptdump_pg_state *st =3D container_of(pt_st, struct ptdump_=
pg_state, ptdump);
> +
> +       note_page(pt_st, addr, level, val);
> +
> +       if (level >=3D 0)
> +               st->current_prot =3D val & gstage_pg_levels[level].mask;
> +}
> +
> +static void gstage_note_page_pte(struct ptdump_state *pt_st, unsigned lo=
ng addr, pte_t pte)
> +{
> +       gstage_note_page(pt_st, addr, 4, pte_val(pte));
> +}
> +
> +static void gstage_note_page_pmd(struct ptdump_state *pt_st, unsigned lo=
ng addr, pmd_t pmd)
> +{
> +       gstage_note_page(pt_st, addr, 3, pmd_val(pmd));
> +}
> +
> +static void gstage_note_page_pud(struct ptdump_state *pt_st, unsigned lo=
ng addr, pud_t pud)
> +{
> +       gstage_note_page(pt_st, addr, 2, pud_val(pud));
> +}
> +
> +static void gstage_note_page_p4d(struct ptdump_state *pt_st, unsigned lo=
ng addr, p4d_t p4d)
> +{
> +       gstage_note_page(pt_st, addr, 1, p4d_val(p4d));
> +}
> +
> +static void gstage_note_page_pgd(struct ptdump_state *pt_st, unsigned lo=
ng addr, pgd_t pgd)
> +{
> +       gstage_note_page(pt_st, addr, 0, pgd_val(pgd));
> +}
> +
> +static void gstage_note_page_flush(struct ptdump_state *pt_st)
> +{
> +       pte_t pte_zero =3D {0};
> +
> +       gstage_note_page(pt_st, 0, -1, pte_val(pte_zero));
> +}
> +
> +static int gstage_ptdump_show(struct seq_file *m, void *v)
> +{
> +       struct kvm *kvm =3D m->private;
> +       gpa_t gpa_size =3D kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels=
);
> +       struct addr_marker gpa_markers[] =3D {
> +               [GSTAGE_GPA_START_NR] =3D { 0, "Guest Physical Address St=
art" },
> +               [GSTAGE_GPA_END_NR]   =3D { gpa_size - 1, "Guest Physical=
 Address End" },
> +               [END_OF_GSTAGE_SPACE_NR] =3D { -1, NULL },
> +       };
> +       struct ptdump_pg_state st =3D {
> +               .seq =3D m,
> +               .marker =3D gpa_markers,
> +               .level =3D -1,
> +               .pg_level =3D gstage_pg_levels,
> +               .ptdump =3D {
> +                       .note_page_pte =3D gstage_note_page_pte,
> +                       .note_page_pmd =3D gstage_note_page_pmd,
> +                       .note_page_pud =3D gstage_note_page_pud,
> +                       .note_page_p4d =3D gstage_note_page_p4d,
> +                       .note_page_pgd =3D gstage_note_page_pgd,
> +                       .note_page_flush =3D gstage_note_page_flush,
> +                       .range =3D (struct ptdump_range[]) {
> +                               {0, gpa_size - 1},
> +                               {0, 0}
> +                       }
> +               }
> +       };
> +       unsigned int i, j;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(gstage_pg_levels); i++) {
> +               gstage_pg_levels[i].mask =3D 0;
> +               for (j =3D 0; j < ARRAY_SIZE(gstage_pte_bits); j++)
> +                       gstage_pg_levels[i].mask |=3D gstage_pte_bits[j].=
mask;
> +       }
> +
> +       if (kvm->arch.pgd_levels < 5)
> +               gstage_pg_levels[1].name =3D "PGD";
> +       if (kvm->arch.pgd_levels < 4)
> +               gstage_pg_levels[2].name =3D "PGD";
> +       if (kvm->arch.pgd_levels < 3)
> +               gstage_pg_levels[3].name =3D "PGD";
> +
> +       ptdump_walk_pgd(&st.ptdump, kvm->mm, kvm->arch.pgd);
> +
> +       return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(gstage_ptdump);
> +
> +void kvm_arch_create_vm_debugfs(struct kvm *kvm)
> +{
> +       debugfs_create_file("gstage_page_tables", 0400,
> +                           kvm->debugfs_dentry, kvm, &gstage_ptdump_fops=
);
> +}
> --
> 2.34.1
>

Regards,
Anup
