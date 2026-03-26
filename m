Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685733F7AB2
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527625; cv=pass; b=Mc4iMF6H8U5XYFF4QzUpffithvINIF4nU0DAREOrVr940LVIYK3+SRviPFFxGUFfP6zp4XUqb32irtdRLMhIYRAVC8w7Bcz07DJZnzA4HVfGZIWiBtMRzpxWOLzdfIE0XXHd2y6gf/+wln+8Ju3DrzaXeWbI/oZnXOsukZ+BPEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527625; c=relaxed/simple;
	bh=JtWXXZPYrXa++S/WqiJ9Xp90Sb6b7/wKB1D6hfdsZoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/VNZl8KkoaWDchrMZFj3LVhtWtNTsDDjrTkvWBYYYKwHq3ycdeRW75TNvDv2Hkf7TRQ7g8pVIBlN/xHntMmOLI3JOvaxEzKwnYQhqypXIcj/LCbZZ/sjw2/r79xVmBvupIEdugCPwKrOPnAFV4w2wzUZ5AEIymD8FJusuHFvFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=m2A+5v5N; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="m2A+5v5N"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d7f592b8beso709121a34.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 05:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774527621; cv=none;
        d=google.com; s=arc-20240605;
        b=BpegRDQz+zoZhqgJA/N8IUoh6Ah5LRWKiBSsXPqwlnWuXcrBJsvHUpYPaNaWRaH7AJ
         kIN91hIyyoARYLpV4xEXAelrkvNhMzOTBJIIfxVNiuGBDqh5D+ZdZ7KUwjMrIFXAPEvq
         3x3p5+MzTa0VCYJ2d5rCzzwlFiHqwvea4BUuiTS/M3a6Fbg8iQXMoLu0lKsl5gDSL/ql
         LtadqIEcCKlPfKGMKvfga+fctpExAUJXJbgCMxYKCblcgB4/OU8WtkmsQdERR4LfiHCa
         XBPuNyLoJZS3qi8MD7W0OXj+saMFCxNLUb2FbnZRF5O/TVRZW/c6JTe6K4vV8VLJEsY/
         SE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TLtKjsIrqFE3XJacbTrbXb2MXfJwMr2KgfWkvdESg8k=;
        fh=rAteePwm0+a2APpAlIeP3NMEWIQyAKESBD6+imqZgKU=;
        b=NfcZLXcf4FHdqsJQP5zuVy1+A1dq2D6s3//ixqUOEcBOmd/oYC7SB40V2+p2O0V7Rg
         pW/gP6LMPoJOcBj7KTnlpKecplBycjemuJpDKeT5WaYsFD5G43fFeRGeGXJV6LkMYOz2
         J9ZgPThwv59eDGCKoMtlus1avOOQIFz0pUL5ti9OYOaEIDJTiWMwZIG6zGnwrC+LZ1Bo
         XQmbkcZso70Jn3p6qB7OFk9i0e1oj5560ALD5fZOHw4S/VOeAPWaFua5TK+epf00tNjd
         OjYOj5upeXnFIlgertGfMqEhRSAqFPqeLBoLSW0ZGqr0EzHMOhImC1rpVvgT1QMulvrw
         CkiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1774527621; x=1775132421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLtKjsIrqFE3XJacbTrbXb2MXfJwMr2KgfWkvdESg8k=;
        b=m2A+5v5NzXQPbSSRA9FZLfx7YCJxvzVRaYGqshlIeaDkD50AIJscTWI9YGjOBc54N4
         PSEQhz16wUPtoTgfLKGmlV0GO0KuQq75y/D32VAD+/dko51inDFaapL3JprL/gnfGobx
         +TJl82uaB4G7Cqs2lP+lr5/HMgVT3hYVn3i7M7ICdyj/ALN/RbfjbKqXTRHCN69uAT07
         x2fy/J2bSJvZl2FH7nGS9eNx+Q+9RVVJz0+R7XRcJadsFQk4ARGAtZro9q+9GlbtDxUS
         vZ0hwrfWaLVq5q5ONGXh5P8LBF4NvIdmOmRTjLXg9ROjMRI8ZfK8I8BB35u3N2XpAo0O
         3ENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774527621; x=1775132421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TLtKjsIrqFE3XJacbTrbXb2MXfJwMr2KgfWkvdESg8k=;
        b=svb5PxqfgbaVIxP6suZza+TobUrCb5Bwqj1Nh1dzj1rDX0Aq5oNUnarePpfHbE/SbL
         6XA21FiC1n3iXsDAlKE+8HjgujqX72WyE2/Kk1UMzOJGoE0t5NkheV1yAG0wwMNZpZyL
         Q2kc+qX3QlK5BrEf1bI2Vnv5ofBf2RUZzgzRiQozfBbRoLK3eRLX8DNsPlhULy+CNF/Y
         EMGIdhgJzc7+y+g54LMnV8F5321VLa5PNgtP26jtCRj13otvfXP4x63laWoUKHWOZG3o
         k2Qr/0iPjkLQ/PEUXu8Rp8FbwqXsW9J0Vsz7twIqjm9y+nzbMjWaMQtCoRnsVIOH+XAL
         D5iA==
X-Forwarded-Encrypted: i=1; AJvYcCWfqSB08bDDiGGVzOEuGN2sNJiwk6Xd6LI5SehwsPDOTpXB+BkqpKoOkiWjd64LrT2K/i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtrMNKlNTnllAlp8xshLgKpuUrVkXrnbSdeN5/80XGIHVtqu8H
	eBUlntg1xEWlmnKMrBdCRbeEwGLiD4l4k+/jO0CWZyDU/6kpAWPB2Uan4q7oWhzpaaXv0iALRDr
	A4cp9wv3PLSBpGH4OUtY8lfRL10Y5cn/aqfRTKb5O+Q==
X-Gm-Gg: ATEYQzyWis6gahXytuanAgMG2hBpqSiDRMtlStXQ/gS8S1tNyryNe6yBciQ++BiOTVs
	54tcG/XE6w55MqnVrHnOs7ouX2jlD1ctbZGbqzmlIdny1oUxsKsLf341EVkAWulPBQk8EzVUxLc
	6RI/KLN3b1R2ozqjGE5xbSZeZ6aU6PvlpHiS0ZuXB262gm7WZx2KjTArK7gEdiMw3VS6ZS6I85R
	1a/r1kEffMs5ThNsmHzEqJgyTCCYq0bJJHvJmK7j4Q7m/12TtK8WQmskioYVCZ0NoIf+XptwfcE
	3+T/Xdw9O8KwEOANSAOvUUJA9tqsJzNzaAyVBTHsVQOKQjU6c9dxOMHWTIE+mJ3e5cZxMZqkQn9
	grWFhRBTfoPlREaYohYU38IEiUwU=
X-Received: by 2002:a05:6820:1513:b0:67b:da68:955d with SMTP id
 006d021491bc7-67dff5a3bb7mr3973073eaf.66.1774527621183; Thu, 26 Mar 2026
 05:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204134507.33912-1-fangyu.yu@linux.alibaba.com> <20260204134507.33912-2-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260204134507.33912-2-fangyu.yu@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 26 Mar 2026 17:50:09 +0530
X-Gm-Features: AQROBzCP3YoIDo9fR8aNGoqhjha9CB5BAYUc6Z1GcC0bYiWRJbowoHYNiKExk4U
Message-ID: <CAAhSdy059XmTckHrX8xjk44pR=1BkaUuPQ-Cf+4BRTBoigBZ+g@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] RISC-V: KVM: Support runtime configuration for
 per-VM's HGATP mode
To: fangyu.yu@linux.alibaba.com
Cc: pbonzini@redhat.com, corbet@lwn.net, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, guoren@kernel.org, 
	radim.krcmar@oss.qualcomm.com, andrew.jones@oss.qualcomm.com, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 7:16=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Introduces one per-VM architecture-specific fields to support runtime
> configuration of the G-stage page table format:
>
> - kvm->arch.kvm_riscv_gstage_pgd_levels: the corresponding number of page
>   table levels for the selected mode.
>
> These fields replace the previous global variables
> kvm_riscv_gstage_mode and kvm_riscv_gstage_pgd_levels, enabling different
> virtual machines to independently select their G-stage page table format
> instead of being forced to share the maximum mode detected by the kernel
> at boot time.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  arch/riscv/include/asm/kvm_gstage.h | 20 +++++----
>  arch/riscv/include/asm/kvm_host.h   | 19 +++++++++
>  arch/riscv/kvm/gstage.c             | 65 ++++++++++++++---------------
>  arch/riscv/kvm/main.c               | 12 +++---
>  arch/riscv/kvm/mmu.c                | 20 +++++----
>  arch/riscv/kvm/vm.c                 |  2 +-
>  arch/riscv/kvm/vmid.c               |  3 +-
>  7 files changed, 84 insertions(+), 57 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm=
/kvm_gstage.h
> index 595e2183173e..b12605fbca44 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -29,16 +29,22 @@ struct kvm_gstage_mapping {
>  #define kvm_riscv_gstage_index_bits    10
>  #endif
>
> -extern unsigned long kvm_riscv_gstage_mode;
> -extern unsigned long kvm_riscv_gstage_pgd_levels;
> +extern unsigned long kvm_riscv_gstage_max_pgd_levels;
>
>  #define kvm_riscv_gstage_pgd_xbits     2
>  #define kvm_riscv_gstage_pgd_size      (1UL << (HGATP_PAGE_SHIFT + kvm_r=
iscv_gstage_pgd_xbits))
> -#define kvm_riscv_gstage_gpa_bits      (HGATP_PAGE_SHIFT + \
> -                                        (kvm_riscv_gstage_pgd_levels * \
> -                                         kvm_riscv_gstage_index_bits) + =
\
> -                                        kvm_riscv_gstage_pgd_xbits)
> -#define kvm_riscv_gstage_gpa_size      ((gpa_t)(1ULL << kvm_riscv_gstage=
_gpa_bits))
> +
> +static inline unsigned long kvm_riscv_gstage_gpa_bits(struct kvm_arch *k=
a)

Use "unsigned long pgd_levels" as parameter here.

> +{
> +       return (HGATP_PAGE_SHIFT +
> +               ka->kvm_riscv_gstage_pgd_levels * kvm_riscv_gstage_index_=
bits +
> +               kvm_riscv_gstage_pgd_xbits);
> +}
> +
> +static inline gpa_t kvm_riscv_gstage_gpa_size(struct kvm_arch *ka)

Same comment as above.

> +{
> +       return BIT_ULL(kvm_riscv_gstage_gpa_bits(ka));
> +}
>
>  bool kvm_riscv_gstage_get_leaf(struct kvm_gstage *gstage, gpa_t addr,
>                                pte_t **ptepp, u32 *ptep_level);
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 24585304c02b..0ace5e98c133 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -87,6 +87,23 @@ struct kvm_vcpu_stat {
>  struct kvm_arch_memory_slot {
>  };
>
> +static inline unsigned long kvm_riscv_gstage_mode(unsigned long pgd_leve=
ls)
> +{
> +       switch (pgd_levels) {
> +       case 2:
> +               return HGATP_MODE_SV32X4;
> +       case 3:
> +               return HGATP_MODE_SV39X4;
> +       case 4:
> +               return HGATP_MODE_SV48X4;
> +       case 5:
> +               return HGATP_MODE_SV57X4;
> +       default:
> +               WARN_ON_ONCE(1);
> +               return HGATP_MODE_OFF;
> +       }
> +}
> +

Move this function to kvm_gstage.h

>  struct kvm_arch {
>         /* G-stage vmid */
>         struct kvm_vmid vmid;
> @@ -103,6 +120,8 @@ struct kvm_arch {
>
>         /* KVM_CAP_RISCV_MP_STATE_RESET */
>         bool mp_state_reset;
> +
> +       unsigned long kvm_riscv_gstage_pgd_levels;

s/kvm_riscv_gstage_pgd_levels/pgd_levels/

Also define it right after pgd_phys.

>  };
>
>  struct kvm_cpu_trap {
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index b67d60d722c2..2d0045f502d1 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -12,22 +12,21 @@
>  #include <asm/kvm_gstage.h>
>
>  #ifdef CONFIG_64BIT
> -unsigned long kvm_riscv_gstage_mode __ro_after_init =3D HGATP_MODE_SV39X=
4;
> -unsigned long kvm_riscv_gstage_pgd_levels __ro_after_init =3D 3;
> +unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init =3D 3;
>  #else
> -unsigned long kvm_riscv_gstage_mode __ro_after_init =3D HGATP_MODE_SV32X=
4;
> -unsigned long kvm_riscv_gstage_pgd_levels __ro_after_init =3D 2;
> +unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init =3D 2;
>  #endif
>
>  #define gstage_pte_leaf(__ptep)        \
>         (pte_val(*(__ptep)) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC))
>
> -static inline unsigned long gstage_pte_index(gpa_t addr, u32 level)
> +static inline unsigned long gstage_pte_index(struct kvm_gstage *gstage,
> +                                            gpa_t addr, u32 level)
>  {
>         unsigned long mask;
>         unsigned long shift =3D HGATP_PAGE_SHIFT + (kvm_riscv_gstage_inde=
x_bits * level);
>
> -       if (level =3D=3D (kvm_riscv_gstage_pgd_levels - 1))
> +       if (level =3D=3D gstage->kvm->arch.kvm_riscv_gstage_pgd_levels - =
1)

This pointer chasing over here and every below is inefficient. It is better
to add "pgd_levels" in "struct kvm_gstage" which is set with value from
"pgd_levels" in "struct kvm_arch".

>                 mask =3D (PTRS_PER_PTE * (1UL << kvm_riscv_gstage_pgd_xbi=
ts)) - 1;
>         else
>                 mask =3D PTRS_PER_PTE - 1;
> @@ -40,12 +39,13 @@ static inline unsigned long gstage_pte_page_vaddr(pte=
_t pte)
>         return (unsigned long)pfn_to_virt(__page_val_to_pfn(pte_val(pte))=
);
>  }
>
> -static int gstage_page_size_to_level(unsigned long page_size, u32 *out_l=
evel)
> +static int gstage_page_size_to_level(struct kvm_gstage *gstage, unsigned=
 long page_size,
> +                                    u32 *out_level)
>  {
>         u32 i;
>         unsigned long psz =3D 1UL << 12;
>
> -       for (i =3D 0; i < kvm_riscv_gstage_pgd_levels; i++) {
> +       for (i =3D 0; i < gstage->kvm->arch.kvm_riscv_gstage_pgd_levels; =
i++) {
>                 if (page_size =3D=3D (psz << (i * kvm_riscv_gstage_index_=
bits))) {
>                         *out_level =3D i;
>                         return 0;
> @@ -55,21 +55,23 @@ static int gstage_page_size_to_level(unsigned long pa=
ge_size, u32 *out_level)
>         return -EINVAL;
>  }
>
> -static int gstage_level_to_page_order(u32 level, unsigned long *out_pgor=
der)
> +static int gstage_level_to_page_order(struct kvm_gstage *gstage, u32 lev=
el,
> +                                     unsigned long *out_pgorder)
>  {
> -       if (kvm_riscv_gstage_pgd_levels < level)
> +       if (gstage->kvm->arch.kvm_riscv_gstage_pgd_levels < level)
>                 return -EINVAL;
>
>         *out_pgorder =3D 12 + (level * kvm_riscv_gstage_index_bits);
>         return 0;
>  }
>
> -static int gstage_level_to_page_size(u32 level, unsigned long *out_pgsiz=
e)
> +static int gstage_level_to_page_size(struct kvm_gstage *gstage, u32 leve=
l,
> +                                    unsigned long *out_pgsize)
>  {
>         int rc;
>         unsigned long page_order =3D PAGE_SHIFT;
>
> -       rc =3D gstage_level_to_page_order(level, &page_order);
> +       rc =3D gstage_level_to_page_order(gstage, level, &page_order);
>         if (rc)
>                 return rc;
>
> @@ -81,11 +83,11 @@ bool kvm_riscv_gstage_get_leaf(struct kvm_gstage *gst=
age, gpa_t addr,
>                                pte_t **ptepp, u32 *ptep_level)
>  {
>         pte_t *ptep;
> -       u32 current_level =3D kvm_riscv_gstage_pgd_levels - 1;
> +       u32 current_level =3D gstage->kvm->arch.kvm_riscv_gstage_pgd_leve=
ls - 1;
>
>         *ptep_level =3D current_level;
>         ptep =3D (pte_t *)gstage->pgd;
> -       ptep =3D &ptep[gstage_pte_index(addr, current_level)];
> +       ptep =3D &ptep[gstage_pte_index(gstage, addr, current_level)];
>         while (ptep && pte_val(ptep_get(ptep))) {
>                 if (gstage_pte_leaf(ptep)) {
>                         *ptep_level =3D current_level;
> @@ -97,7 +99,7 @@ bool kvm_riscv_gstage_get_leaf(struct kvm_gstage *gstag=
e, gpa_t addr,
>                         current_level--;
>                         *ptep_level =3D current_level;
>                         ptep =3D (pte_t *)gstage_pte_page_vaddr(ptep_get(=
ptep));
> -                       ptep =3D &ptep[gstage_pte_index(addr, current_lev=
el)];
> +                       ptep =3D &ptep[gstage_pte_index(gstage, addr, cur=
rent_level)];
>                 } else {
>                         ptep =3D NULL;
>                 }
> @@ -110,7 +112,7 @@ static void gstage_tlb_flush(struct kvm_gstage *gstag=
e, u32 level, gpa_t addr)
>  {
>         unsigned long order =3D PAGE_SHIFT;
>
> -       if (gstage_level_to_page_order(level, &order))
> +       if (gstage_level_to_page_order(gstage, level, &order))
>                 return;
>         addr &=3D ~(BIT(order) - 1);
>
> @@ -125,9 +127,9 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstag=
e,
>                              struct kvm_mmu_memory_cache *pcache,
>                              const struct kvm_gstage_mapping *map)
>  {
> -       u32 current_level =3D kvm_riscv_gstage_pgd_levels - 1;
> +       u32 current_level =3D gstage->kvm->arch.kvm_riscv_gstage_pgd_leve=
ls - 1;
>         pte_t *next_ptep =3D (pte_t *)gstage->pgd;
> -       pte_t *ptep =3D &next_ptep[gstage_pte_index(map->addr, current_le=
vel)];
> +       pte_t *ptep =3D &next_ptep[gstage_pte_index(gstage, map->addr, cu=
rrent_level)];
>
>         if (current_level < map->level)
>                 return -EINVAL;
> @@ -151,7 +153,7 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstag=
e,
>                 }
>
>                 current_level--;
> -               ptep =3D &next_ptep[gstage_pte_index(map->addr, current_l=
evel)];
> +               ptep =3D &next_ptep[gstage_pte_index(gstage, map->addr, c=
urrent_level)];
>         }
>
>         if (pte_val(*ptep) !=3D pte_val(map->pte)) {
> @@ -175,7 +177,7 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gsta=
ge,
>         out_map->addr =3D gpa;
>         out_map->level =3D 0;
>
> -       ret =3D gstage_page_size_to_level(page_size, &out_map->level);
> +       ret =3D gstage_page_size_to_level(gstage, page_size, &out_map->le=
vel);
>         if (ret)
>                 return ret;
>
> @@ -217,7 +219,7 @@ void kvm_riscv_gstage_op_pte(struct kvm_gstage *gstag=
e, gpa_t addr,
>         u32 next_ptep_level;
>         unsigned long next_page_size, page_size;
>
> -       ret =3D gstage_level_to_page_size(ptep_level, &page_size);
> +       ret =3D gstage_level_to_page_size(gstage, ptep_level, &page_size)=
;
>         if (ret)
>                 return;
>
> @@ -229,7 +231,7 @@ void kvm_riscv_gstage_op_pte(struct kvm_gstage *gstag=
e, gpa_t addr,
>         if (ptep_level && !gstage_pte_leaf(ptep)) {
>                 next_ptep =3D (pte_t *)gstage_pte_page_vaddr(ptep_get(pte=
p));
>                 next_ptep_level =3D ptep_level - 1;
> -               ret =3D gstage_level_to_page_size(next_ptep_level, &next_=
page_size);
> +               ret =3D gstage_level_to_page_size(gstage, next_ptep_level=
, &next_page_size);
>                 if (ret)
>                         return;
>
> @@ -263,7 +265,7 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage *=
gstage,
>
>         while (addr < end) {
>                 found_leaf =3D kvm_riscv_gstage_get_leaf(gstage, addr, &p=
tep, &ptep_level);
> -               ret =3D gstage_level_to_page_size(ptep_level, &page_size)=
;
> +               ret =3D gstage_level_to_page_size(gstage, ptep_level, &pa=
ge_size);
>                 if (ret)
>                         break;
>
> @@ -297,7 +299,7 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gst=
age, gpa_t start, gpa_t end
>
>         while (addr < end) {
>                 found_leaf =3D kvm_riscv_gstage_get_leaf(gstage, addr, &p=
tep, &ptep_level);
> -               ret =3D gstage_level_to_page_size(ptep_level, &page_size)=
;
> +               ret =3D gstage_level_to_page_size(gstage, ptep_level, &pa=
ge_size);
>                 if (ret)
>                         break;
>
> @@ -319,39 +321,34 @@ void __init kvm_riscv_gstage_mode_detect(void)
>         /* Try Sv57x4 G-stage mode */
>         csr_write(CSR_HGATP, HGATP_MODE_SV57X4 << HGATP_MODE_SHIFT);
>         if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MODE_S=
V57X4) {
> -               kvm_riscv_gstage_mode =3D HGATP_MODE_SV57X4;
> -               kvm_riscv_gstage_pgd_levels =3D 5;
> +               kvm_riscv_gstage_max_pgd_levels =3D 5;
>                 goto done;
>         }
>
>         /* Try Sv48x4 G-stage mode */
>         csr_write(CSR_HGATP, HGATP_MODE_SV48X4 << HGATP_MODE_SHIFT);
>         if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MODE_S=
V48X4) {
> -               kvm_riscv_gstage_mode =3D HGATP_MODE_SV48X4;
> -               kvm_riscv_gstage_pgd_levels =3D 4;
> +               kvm_riscv_gstage_max_pgd_levels =3D 4;
>                 goto done;
>         }
>
>         /* Try Sv39x4 G-stage mode */
>         csr_write(CSR_HGATP, HGATP_MODE_SV39X4 << HGATP_MODE_SHIFT);
>         if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MODE_S=
V39X4) {
> -               kvm_riscv_gstage_mode =3D HGATP_MODE_SV39X4;
> -               kvm_riscv_gstage_pgd_levels =3D 3;
> +               kvm_riscv_gstage_max_pgd_levels =3D 3;
>                 goto done;
>         }
>  #else /* CONFIG_32BIT */
>         /* Try Sv32x4 G-stage mode */
>         csr_write(CSR_HGATP, HGATP_MODE_SV32X4 << HGATP_MODE_SHIFT);
>         if ((csr_read(CSR_HGATP) >> HGATP_MODE_SHIFT) =3D=3D HGATP_MODE_S=
V32X4) {
> -               kvm_riscv_gstage_mode =3D HGATP_MODE_SV32X4;
> -               kvm_riscv_gstage_pgd_levels =3D 2;
> +               kvm_riscv_gstage_max_pgd_levels =3D 2;
>                 goto done;
>         }
>  #endif
>
>         /* KVM depends on !HGATP_MODE_OFF */
> -       kvm_riscv_gstage_mode =3D HGATP_MODE_OFF;
> -       kvm_riscv_gstage_pgd_levels =3D 0;
> +       kvm_riscv_gstage_max_pgd_levels =3D 0;
>
>  done:
>         csr_write(CSR_HGATP, 0);
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 45536af521f0..786c0025e2c3 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -105,17 +105,17 @@ static int __init riscv_kvm_init(void)
>                 return rc;
>
>         kvm_riscv_gstage_mode_detect();
> -       switch (kvm_riscv_gstage_mode) {
> -       case HGATP_MODE_SV32X4:
> +       switch (kvm_riscv_gstage_max_pgd_levels) {
> +       case 2:
>                 str =3D "Sv32x4";
>                 break;
> -       case HGATP_MODE_SV39X4:
> +       case 3:
>                 str =3D "Sv39x4";
>                 break;
> -       case HGATP_MODE_SV48X4:
> +       case 4:
>                 str =3D "Sv48x4";
>                 break;
> -       case HGATP_MODE_SV57X4:
> +       case 5:
>                 str =3D "Sv57x4";
>                 break;
>         default:
> @@ -164,7 +164,7 @@ static int __init riscv_kvm_init(void)
>                          (rc) ? slist : "no features");
>         }
>
> -       kvm_info("using %s G-stage page table format\n", str);
> +       kvm_info("Max G-stage page table format %s\n", str);

s/Max G-stage page table format/highest G-stage page table mode is/

>
>         kvm_info("VMID %ld bits available\n", kvm_riscv_gstage_vmid_bits(=
));
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 4ab06697bfc0..458a2ed98818 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -67,7 +67,7 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, p=
hys_addr_t hpa,
>                 if (!writable)
>                         map.pte =3D pte_wrprotect(map.pte);
>
> -               ret =3D kvm_mmu_topup_memory_cache(&pcache, kvm_riscv_gst=
age_pgd_levels);
> +               ret =3D kvm_mmu_topup_memory_cache(&pcache, kvm->arch.kvm=
_riscv_gstage_pgd_levels);
>                 if (ret)
>                         goto out;
>
> @@ -186,7 +186,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>          * space addressable by the KVM guest GPA space.
>          */
>         if ((new->base_gfn + new->npages) >=3D
> -           (kvm_riscv_gstage_gpa_size >> PAGE_SHIFT))
> +            kvm_riscv_gstage_gpa_size(&kvm->arch) >> PAGE_SHIFT)
>                 return -EFAULT;
>
>         hva =3D new->userspace_addr;
> @@ -332,7 +332,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>         memset(out_map, 0, sizeof(*out_map));
>
>         /* We need minimum second+third level pages */
> -       ret =3D kvm_mmu_topup_memory_cache(pcache, kvm_riscv_gstage_pgd_l=
evels);
> +       ret =3D kvm_mmu_topup_memory_cache(pcache, kvm->arch.kvm_riscv_gs=
tage_pgd_levels);
>         if (ret) {
>                 kvm_err("Failed to topup G-stage cache\n");
>                 return ret;
> @@ -431,6 +431,7 @@ int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm)
>                 return -ENOMEM;
>         kvm->arch.pgd =3D page_to_virt(pgd_page);
>         kvm->arch.pgd_phys =3D page_to_phys(pgd_page);
> +       kvm->arch.kvm_riscv_gstage_pgd_levels =3D kvm_riscv_gstage_max_pg=
d_levels;
>
>         return 0;
>  }
> @@ -446,10 +447,12 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>                 gstage.flags =3D 0;
>                 gstage.vmid =3D READ_ONCE(kvm->arch.vmid.vmid);
>                 gstage.pgd =3D kvm->arch.pgd;
> -               kvm_riscv_gstage_unmap_range(&gstage, 0UL, kvm_riscv_gsta=
ge_gpa_size, false);
> +               kvm_riscv_gstage_unmap_range(&gstage, 0UL,
> +                       kvm_riscv_gstage_gpa_size(&kvm->arch), false);
>                 pgd =3D READ_ONCE(kvm->arch.pgd);
>                 kvm->arch.pgd =3D NULL;
>                 kvm->arch.pgd_phys =3D 0;
> +               kvm->arch.kvm_riscv_gstage_pgd_levels =3D 0;
>         }
>         spin_unlock(&kvm->mmu_lock);
>
> @@ -459,11 +462,12 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>
>  void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
>  {
> -       unsigned long hgatp =3D kvm_riscv_gstage_mode << HGATP_MODE_SHIFT=
;
> -       struct kvm_arch *k =3D &vcpu->kvm->arch;
> +       struct kvm_arch *ka =3D &vcpu->kvm->arch;
> +       unsigned long hgatp =3D kvm_riscv_gstage_mode(ka->kvm_riscv_gstag=
e_pgd_levels)
> +                             << HGATP_MODE_SHIFT;
>
> -       hgatp |=3D (READ_ONCE(k->vmid.vmid) << HGATP_VMID_SHIFT) & HGATP_=
VMID;
> -       hgatp |=3D (k->pgd_phys >> PAGE_SHIFT) & HGATP_PPN;
> +       hgatp |=3D (READ_ONCE(ka->vmid.vmid) << HGATP_VMID_SHIFT) & HGATP=
_VMID;
> +       hgatp |=3D (ka->pgd_phys >> PAGE_SHIFT) & HGATP_PPN;
>
>         ncsr_write(CSR_HGATP, hgatp);
>
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index 66d91ae6e9b2..4b2156df40fc 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -200,7 +200,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>                 r =3D KVM_USER_MEM_SLOTS;
>                 break;
>         case KVM_CAP_VM_GPA_BITS:
> -               r =3D kvm_riscv_gstage_gpa_bits;
> +               r =3D kvm_riscv_gstage_gpa_bits(&kvm->arch);
>                 break;
>         default:
>                 r =3D 0;
> diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
> index cf34d448289d..c15bdb1dd8be 100644
> --- a/arch/riscv/kvm/vmid.c
> +++ b/arch/riscv/kvm/vmid.c
> @@ -26,7 +26,8 @@ static DEFINE_SPINLOCK(vmid_lock);
>  void __init kvm_riscv_gstage_vmid_detect(void)
>  {
>         /* Figure-out number of VMID bits in HW */
> -       csr_write(CSR_HGATP, (kvm_riscv_gstage_mode << HGATP_MODE_SHIFT) =
| HGATP_VMID);
> +       csr_write(CSR_HGATP, (kvm_riscv_gstage_mode(kvm_riscv_gstage_max_=
pgd_levels) <<
> +                             HGATP_MODE_SHIFT) | HGATP_VMID);
>         vmid_bits =3D csr_read(CSR_HGATP);
>         vmid_bits =3D (vmid_bits & HGATP_VMID) >> HGATP_VMID_SHIFT;
>         vmid_bits =3D fls_long(vmid_bits);
> --
> 2.50.1
>
>

Regards,
Anup
