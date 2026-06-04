Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BC83C343B
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 05:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780551649; cv=pass; b=WhU32H8M8xNxQA86kq/eQqyt00AxJU217MDPtHt4hdqDroD4aKFxNLmywz+CWeEMXcQgEwuG6amUgdFKBjThnxbh5Jxca7525DoVXVutj23pJI7h8vj3B4qyav5gVHA0xqOW2LTJDDuNVGRQ+WVmb+ZUtIUPk7TbRzgS4ChKzfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780551649; c=relaxed/simple;
	bh=9GDRbWGSKEmbQKGvnLmi6IQXhSmCCrKRFTup1xhmosE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/qnYuhFnB9woCXnoTM+a7RlKie6q0XcxD9jb4hqvs5GQUqkdwflhUwB8ZfwqBPxUPL6WHEvlo+4yivtdUgjSp899ThujnIVl/ZW9o9imoiFUP+aa0zZVU8lJlQQhWe54WRLuDOPrJxJxb1zdkd7yOdqLGEpkg+A/JaiolrWTSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=KBZC7xmO; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="KBZC7xmO"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e6f27619e7so215680a34.2
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 22:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780551645; cv=none;
        d=google.com; s=arc-20240605;
        b=FfwvUFRTNlCBzNwEoWPUW6eVdkfWJGisKn7NiDVupCIFB5Yy8U9oWfJcL2B/xxB9Q5
         +wKoqBNfPiRkz/XbfKMc3QM3PbnixzjI4ZylUbup50IedtEmux0vWqTbdmSFPh0u8pfs
         HTWEBWnUFG/BsMpAagsaSSQRl4T3udVJ3OXRUTBn203BvyQE1pL/mKoSTzgmR14nxsq2
         rG9Wtz12pyPG7XMekky87NXwSJuNzNsw8pxkYxdQcqp+AZXhHk1h/z2GIAbvYFOO9O3L
         O5euY3uRdZ/+GlYpNDGeeNNJWMf1pV1XwaJTUpoiYE6/JTVt0a+qLJzqO3EWAh1xTAuy
         bAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=usx7JIclZBP48czky2PIbdzhjqBH7d8Co30aVJaLTDs=;
        fh=X4r6SuV8iow/GZ8hcrTRJpHEikBdOrXOFSVC3Khkw1U=;
        b=bqvT8Pai/+KytlO3R9nHI+3RJROpkS8tOSSEGXsclUS0UPvCL6CCnPx/Pe+oUi3Vh1
         Z1UeoOPH/P/ZooINY2cL05gnVO90EHoNjFTHpTuM76XsQhQFiYCIgpo0NwZD9CZznj3k
         1dwHCg6W3q5SrR0IIy0qFWkwLjrWnu5seaZv9zMWuTVI96JfnJPY+hGa64gLuQ/aKi9E
         57QyRSwiciL+su/Zu08+d4JuSiOit1MeqlZvl3pZnPyjmpc/pFY/WDWnUYZLIy27e5kE
         s68qsMDHEs+xCmoL1MVzhyAfixMAl6PgZg5c5OT8nEya1crTdQQZ8YKKBibBl889/qHL
         WTWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780551645; x=1781156445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usx7JIclZBP48czky2PIbdzhjqBH7d8Co30aVJaLTDs=;
        b=KBZC7xmOKBbWzrAU2TPZJsDkltp1Ci4TVVG1m0q7WGVmZDzw3mPGVVIb+YYM8wOhHX
         smwyWIgrHTCS+uMtSIsS24YVux9Ysg8xEQ5QLVwdHH+JOpjmxc/7O3Z0vCdFuZAl+RPM
         zJ82qghVQoaYx06z3KfBf7xyBDtvCOwVpdjdRumkv9o/Fm5TOLcetRydW7J2cPDMrcdk
         Nv4PUHPSQdnowjOCeRKPG97GAYgiETqTM/kyQ7cElKaIDzt/M6+pACPbTFGyqChF5DLx
         d+c6z8gwWknxhNZkHBVChFNUaISYKdbib76nf4GxeUFkz9sMZOAQSTmw3TioB9X4TGya
         xI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780551645; x=1781156445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=usx7JIclZBP48czky2PIbdzhjqBH7d8Co30aVJaLTDs=;
        b=I9TFcoAvmBYSNMxOrAPt5v5/topTxgEdLKfd9WrYxQy2pDu2TQNHCpsgIjDdysvRgi
         Yhtl63AJeDHlutkINJxIiW/71qIMu1XSk8NSOBfTAxtkwwc/wOCsF5HtQFGQbFGT/UcI
         mEf+5tGKjVGesCjmXEQ+9rzcQuHTeH1991yrYY2I19moCueJ9lyyZcyTmc/iRgxOJdNZ
         kWGXxEnIM93DKpFBCHkl0UhHchVH5xZ6/qWg4VMeMQSFeHXDPWnVGgtMMBTw8ywlhVlE
         X03ChKqgtqlytgfbztyyNbMfWwWPASZ+6xNifLQFt+Ik6ysd73yo+wXH5lH5+PQ0ynIq
         /+sQ==
X-Forwarded-Encrypted: i=1; AFNElJ8aBSSkpdzk4VqngogAUDImNGmVTAC4+/mgaM1qhOsqd0Re/2RJoQfRmAvt0i0f6Y6i9l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhE01NDB//t+635LQiEFg1VN9wL4Lzwq+5LS21S4SjiJxU8TMw
	33UQdXrTHEB6npeXYY6OC5bJbpjggKfKQpU+NC91/O/cK3pN0A/AoxtV1AbKaJR/+tSGsKEmyYO
	3h8NXPmEYws320gpc4/Amja5tIbORDXeGzlBz9pnW5w==
X-Gm-Gg: Acq92OFmquLycc/l5a2elOttYtIypt/YRALWky7De6hFSMhxZJCnVEr51XPSyCNwEIH
	y+x6gEN+G/llkbZ+06LWod0k7DfjysulJdmHoNg4nB6muDOj/oCfs+oYPRcTEgdkRfUSwPEPuXR
	gEKfC3VFReIkmEWkHXQlcj3EnrEaRuroDEc+c1v7KWG6GhekxZRJmXWmliBD/diYTVkNl0lK7SR
	XgEKpcEIWNJqwD0MDbcKzqBLKytQmsk7dzrT35z3CPS+6ob/urx4KRkXxoLNRMzQ3s9JQoofBDx
	E+DYjF/AxomD1UkL5uN4ysGsPRdu516ZyDB2W6IDygdFTQV7PqQUakjezKzCm6LuyRU7S8hiWwG
	6tzorz1V+SnjwgxrFaVinS+L/UMQK1FvnsBjCSgCuxQNhG2A=
X-Received: by 2002:a05:6820:f064:b0:69d:e4c8:86f6 with SMTP id
 006d021491bc7-69e47e92580mr2972770eaf.15.1780551644917; Wed, 03 Jun 2026
 22:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520152148.131272-1-tjytimi@163.com> <20260520152148.131272-3-tjytimi@163.com>
In-Reply-To: <20260520152148.131272-3-tjytimi@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 4 Jun 2026 11:10:32 +0530
X-Gm-Features: AVHnY4KLKxgI8rZ055_ZYdjTGmDv_9K6n7Qflz8bYHec2u1kZ7uWSMP1jn70no8
Message-ID: <CAAhSdy2MhnN_6t2_Gpds-bVk+LzYCZsYTe+QXw-CMHdc58o2EA@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: riscv: Check hugetlb block mappings against
 memslot bounds
To: Jinyu Tang <tjytimi@163.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, kvm <kvm@vger.kernel.org>, 
	kvm-riscv <kvm-riscv@lists.infradead.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 8:52=E2=80=AFPM Jinyu Tang <tjytimi@163.com> wrote:
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
> ---
>  arch/riscv/kvm/mmu.c | 40 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 10be8f683..d2378bb1f 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -423,12 +423,33 @@ static unsigned long transparent_hugepage_adjust(st=
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
> +               if (fault_supports_gstage_huge_mapping(memslot, hva, PUD_=
SIZE))

This patch is marked with a Fixes tag but does not include the changes
adding map_size parameter to fault_supports_gstage_huge_mapping().

I think it is better to sqash PATCH1 into this patch for completness of
this patch as Fix.

Regards,
Anup

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
> @@ -462,16 +483,23 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct=
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
> @@ -513,8 +541,12 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct =
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
