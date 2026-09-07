Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DDC43CE64
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769449; cv=pass; b=qmtIns6/tuHrDFVU85vbPcHB+DEMDsAw2DpPE0GjV+fRRAr52FcAoCZVNlKZjfnmV4Or8lVcNo/zUCOC8coAXpyClc827xIlQ5GJIrMqirY3p1os2iOWw30UONHjtmxLafbOLuN+sgAEfAcygXLggbj/qGWzp0qAqCxuj8nAejg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769449; c=relaxed/simple;
	bh=eW2heI0TSrLo005hXEi9RN2qzKnbcSMx1USmy+ENf4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3OCmpycb4RuLklCVWj1GMbcCk4QBiX9ZJpDc56B1zShFzRo3ZSpv8QnHMBmFa4Infkaag4UvZXXW4RIqywe/7pqFPzYbqn4lD1E/5Kn8TBO71A8Nh9LTbXp1qeeDCWpw8Cflq5RRztQVfWj1IOUmANc4+imnNyZUo7gUmpybs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=tnlVPgTS; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="tnlVPgTS"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47de0093c42so3057109f8f.3
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 01:24:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788769445; cv=none;
        d=google.com; s=arc-20260327;
        b=rhh3HUr6bUJ/kdyYOSzwiq7cSpBiHSZf48lgMma9mHTguJcj828tuhwVbArcYQZJwA
         CHudAJ1djAOSwlp7LnX6VBEj0OE2SAV2GtYoDAjWDM5GBf4P/McYWU9VcY0YbCOzsBNr
         xj++jUjGPm+JkuFBHRiblQ+fu3IXXG+bmQPyGJ2pk9JFqzljkr7F+tXJNXNshNm/Y8UM
         5rwhXEs4pEa/EYW0gM8kW4KDKjIqbAMD8NuoqQP63NNDE8nU2W7JOwv3TCDf+tx8L2Qs
         YCC/4lPwQEEJ8SvW3efrZYa3cGW9cDzgHB2a5CFmhSrNEzd0L3GHREoqhx0aVovS6PW8
         mzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h6qiSySchwLDdn88HORNI+edfDP5k4+RIZ3ev8MYNCc=;
        fh=BNT0OoKQ7jwEaFSfH7IXtZ+BTQcNiHPbqLEB101JjuM=;
        b=sGB29+83H1IdBYYI1eseyKULiLmjfR6uF3jxy02sH9KIF985XuCnKVPmFG5aK8BRrL
         ZB+Moam9CPX2Nj6QayirNmdmXLMpDRaw3bQBXQT1gTGBIqNEN1Hui34L1a0R7sMlIaxW
         godzTrptqGwsPwYdzyyJFl9OsyxSvq5J7YvPOcA7Mdzh54iKoOKKiLiAGME0Q7a8nVx7
         24YPAjZeG4iSbRB1ZQeTT3YnimiLLijQhBwqlKY0GFWpfkSFkDrrwPtlVB0SvX5SNbzf
         Y2fUED4v0fBBqR5G3fAPvMdxyIew0D1su8n0S9a4UWXef6kXVu8siVU+/9pDPqpWB081
         CfGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1788769445; x=1789374245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h6qiSySchwLDdn88HORNI+edfDP5k4+RIZ3ev8MYNCc=;
        b=tnlVPgTSF8q/OgLN5frZT1u3+LYtgGYZyXDfZDcsLKYxbbF846W0zEJqK+9m8iI2vD
         VY+QxmuPaRNblSsA2BCDpPTGwUqqASFzFlyE3q2bCrhqv5uRN07GoZqvL2v7CzuKHKFw
         R8yWyVnp7Z4K3yvrD51gmwyb+VL8SOCeeWOFaTpuC854jUaqQ69F9032jsfIvKEty1ZX
         h+DZmScN650MD4UO28guWOldK3bf6Vg0y2Mo0XpjCmmv6wu1hAQAuhPj6DIgAHWSGVtJ
         LCHCqesXBXghjU0QVRuuko7s4IK6vlsOYkN+r5flmOIBFKCUzbsEuKkWtcLB3t0hki+7
         Ir6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788769445; x=1789374245;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h6qiSySchwLDdn88HORNI+edfDP5k4+RIZ3ev8MYNCc=;
        b=k5B3s5KL6A8N+PsCcF6avnq/RqTPXPQjWm0hvZ7bP4fSr5WTMxOIXE6WHdz4PcwSqR
         OH+GfBIPHEzCrT81mc0DNcqWDUwhUc8e/EoJRrdu4kY/5fzqBaBkvoMh43ivaDbXrnp7
         agTLPvGGjDvhLaHnRrnvyKI6pg0x8FGBBmzxYmuMEhQLEk5jS1quCZKBoBJ7GhyE+/ut
         sK97uO/iScS+myhi5+FtF0+B2OLCTxt7HkbCXx+sOkA94DijXttzvWvukkKNZ8uT2E8C
         AF3syp8pEwmcE82aa5lp8sEdIoAb70obLzsVDqHZs5epT+CVP+25TKs3+v1MkhiBfs1b
         i0gg==
X-Forwarded-Encrypted: i=1; AKwUvBxMXimnetRKTVT4tQWJer9IkbwOF8j4L6XpCfYLC5RTiIUyxtlQGZZlOqVKUAuHZMmnjRc=@vger.kernel.org
X-Gm-Message-State: AFuF++mxR3G8md0Re7ejI4Vi4nr7VW6k2g40pq0LbuZVDKNdJm3fkrJC
	tTewOgZiOB2K4lYSWYs27ar++bBzV6SCYxGVJYU4QwZVfcjRPO6bv0+WXIuqAolZhDQIESdGk3j
	AoKaUmMNOAPcrH9UzlQN2LWxYQTHldLw7oV2cTjbzFg==
X-Gm-Gg: AYBFou0E9dRmozGAOkZNqI5Umvb1Z0IOTG5fp+/fvlqRnDbx1mvVigCi0vTfQVhr4uG
	JhKK0Yq11kCt/SCFlbI6AdlnvOaUMIHei7l2TDHtk8VDqy//3COCDI2ij3qiM3Rm4torZdD7G8k
	Z9dvivbL2fw9l1MSvKyBymuEVbEazWpOU/KCoaaVyGIu64hZJJur+2F6sv0mGKj0eSTWETc0qfG
	340zslEV6DBtekY8RDiid3fF7DiFsob1aqHYX+NltasC7Jz80IOAP4QbqCrgYLepDR39amo9ee6
	GZ/CHgbGA4EvhT4WDOPEV1iYmT4FEiHlibruBrI3RJHSOZNRMsx6HtjP5F2AdJcqOFONIkUgI1X
	0QY7KXRfVq+MiKqYZjWg+UYlIfCmU0Dc1IgJ8YDWF1w0co+6vvsQh/Agmv/8IPQE=
X-Received: by 2002:a05:6000:2f82:b0:485:8c16:5ef7 with SMTP id
 ffacd0b85a97d-4858c166148mr18091871f8f.49.1788769445126; Mon, 07 Sep 2026
 01:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902164123.2546762-1-seanjc@google.com> <20260902164123.2546762-11-seanjc@google.com>
In-Reply-To: <20260902164123.2546762-11-seanjc@google.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 7 Sep 2026 13:53:53 +0530
X-Gm-Features: AcwNN1UOItNX8Zqa8yZNak7eVCaaP3xVxuE0lRNcn1acCna6Fm_hGPjVZ5FCvUw
Message-ID: <CAAhSdy1zxu0cGnvpZEq_mPYRj07m7a+TA_8f0-sa=Mu7xtXvjA@mail.gmail.com>
Subject: Re: [PATCH v2 10/20] KVM: selftests: Add a wrapper API to allocate
 multiple page table pages
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 10:11=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Add vm_alloc_page_table_pages() and use it throughout arch code to replac=
e
> open coded equivalents.
>
> No functional change intended.
>
> Reviewed-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

LGTM.

For KVM RISC-V:
Acked-by: Anup Patel <anup@brainfault.org>

Regards,
Anup


> ---
>  tools/testing/selftests/kvm/include/kvm_util.h    | 9 +++++++--
>  tools/testing/selftests/kvm/lib/arm64/processor.c | 4 +---
>  tools/testing/selftests/kvm/lib/riscv/processor.c | 4 +---
>  tools/testing/selftests/kvm/lib/s390/processor.c  | 8 ++------
>  4 files changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testi=
ng/selftests/kvm/include/kvm_util.h
> index d9d39a8894e2..c56f342b16fd 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -1013,10 +1013,15 @@ static inline gpa_t vm_phy_page_alloc(struct kvm_=
vm *vm, gpa_t min_gpa,
>         return vm_phy_pages_alloc(vm, 1, min_gpa, memslot);
>  }
>
> +static inline gpa_t vm_alloc_page_table_pages(struct kvm_vm *vm, size_t =
nr_pages)
> +{
> +       return vm_phy_pages_alloc(vm, nr_pages, KVM_GUEST_PAGE_TABLE_MIN_=
PADDR,
> +                                 vm->memslots[MEM_REGION_PT]);
> +}
> +
>  static inline gpa_t vm_alloc_page_table(struct kvm_vm *vm)
>  {
> -       return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR,
> -                                vm->memslots[MEM_REGION_PT]);
> +       return vm_alloc_page_table_pages(vm, 1);
>  }
>
>  /*
> diff --git a/tools/testing/selftests/kvm/lib/arm64/processor.c b/tools/te=
sting/selftests/kvm/lib/arm64/processor.c
> index 01325bf4d36f..2dcaa2c4a038 100644
> --- a/tools/testing/selftests/kvm/lib/arm64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/arm64/processor.c
> @@ -115,9 +115,7 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
>         if (vm->mmu.pgd_created)
>                 return;
>
> -       vm->mmu.pgd =3D vm_phy_pages_alloc(vm, nr_pages,
> -                                        KVM_GUEST_PAGE_TABLE_MIN_PADDR,
> -                                        vm->memslots[MEM_REGION_PT]);
> +       vm->mmu.pgd =3D vm_alloc_page_table_pages(vm, nr_pages);
>         vm->mmu.pgd_created =3D true;
>  }
>
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index ded5429f3448..c175dcd14114 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -69,9 +69,7 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
>         if (vm->mmu.pgd_created)
>                 return;
>
> -       vm->mmu.pgd =3D vm_phy_pages_alloc(vm, nr_pages,
> -                                        KVM_GUEST_PAGE_TABLE_MIN_PADDR,
> -                                        vm->memslots[MEM_REGION_PT]);
> +       vm->mmu.pgd =3D vm_alloc_page_table_pages(vm, nr_pages);
>         vm->mmu.pgd_created =3D true;
>  }
>
> diff --git a/tools/testing/selftests/kvm/lib/s390/processor.c b/tools/tes=
ting/selftests/kvm/lib/s390/processor.c
> index fb9dab92d4d1..33f49d743b5f 100644
> --- a/tools/testing/selftests/kvm/lib/s390/processor.c
> +++ b/tools/testing/selftests/kvm/lib/s390/processor.c
> @@ -20,9 +20,7 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
>         if (vm->mmu.pgd_created)
>                 return;
>
> -       gpa =3D vm_phy_pages_alloc(vm, PAGES_PER_REGION,
> -                                  KVM_GUEST_PAGE_TABLE_MIN_PADDR,
> -                                  vm->memslots[MEM_REGION_PT]);
> +       gpa =3D vm_alloc_page_table_pages(vm, PAGES_PER_REGION);
>         memset(addr_gpa2hva(vm, gpa), 0xff, PAGES_PER_REGION * vm->page_s=
ize);
>
>         vm->mmu.pgd =3D gpa;
> @@ -38,9 +36,7 @@ static u64 virt_alloc_region(struct kvm_vm *vm, int ri)
>  {
>         u64 taddr;
>
> -       taddr =3D vm_phy_pages_alloc(vm,  ri < 4 ? PAGES_PER_REGION : 1,
> -                                  KVM_GUEST_PAGE_TABLE_MIN_PADDR,
> -                                  vm->memslots[MEM_REGION_PT]);
> +       taddr =3D vm_alloc_page_table_pages(vm, ri < 4 ? PAGES_PER_REGION=
 : 1);
>         memset(addr_gpa2hva(vm, taddr), 0xff, PAGES_PER_REGION * vm->page=
_size);
>
>         return (taddr & REGION_ENTRY_ORIGIN)
> --
> 2.55.0.966.g6673acef38-goog
>
