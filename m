Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E01643CEF7
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785312345; cv=pass; b=NmcjGhBuqHw+ETjhVuIIWNp8GqV6qx4siJ/+FEY3mYFmAy+BGEi4RTBYvct+ibHR3vTD1N338BjQ0CMrlnfTAaOSLaMtw4NDcP9RP7oXpYPh3mnOO13FjaSHKU4V7cuFK7vLs9I5lQYFNBbr3KZTmRIYmbjFa9VGnib8pMr6f1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785312345; c=relaxed/simple;
	bh=6XeGU1tZI1rP2JqBWVbT9jxUVJaAHU52PgL8ZlK6Pq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEO24J4vP5NXtuPFhpPwMlDZLvbyYxi05UTV6HIFh37zWtLykfum7WknL4alNBgBr086ectN5Tk//eYnoqKwX6sGzsmXINY6P1sfaRWuGJ180Wuf1k5rUhj9t93dsup7+BwKozz5WXKhMo+k4pfj6i7d/2B7ic8r8sbNAorFk2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=P+eSmfam; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="P+eSmfam"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso305787f8f.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 01:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785312340; cv=none;
        d=google.com; s=arc-20260327;
        b=ElnlKoM7xJweuo2GTtV2aSDvGfb9pD2fNZVgpG1JYtOBQQzJI3Jh4UxJIgmTo5k7vd
         YG9afM2JLvcfKKSQs6JuglQCNh8S+dTAl1y9FgPSoFKmDq10RZrD1ZfCRHRZBtzvCiVI
         FVdvLYW43ikFcPjwZsQCfH262uqKo5K2FWFV4ou3i7Y5HG5TQemmf9prpPuWtsFoBWNh
         Z53JSkh0qtgJdZRNWCI79gMTwVlCr//BM2UfMR6HTdAOSuf9rRVv6KAvUhZNpr79X3Y+
         1ziIix1Nmkm+xPJbMZTvhqzAHkvLRoEte49uEulBNuLVqxPjvRG2Dk9gVXVRB9sIoG4e
         Ylhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q0Yd6Q4AnWVaWzw13DT5nV/m2mi7w3GBu7PU7kHWGEs=;
        fh=PbJjz2wceEIjs2oI8n0RLh5/Orwgh52ud4p2mJ0Yg44=;
        b=UMT1s6y94PHP+fZDNyYo/N9pRBEMhlkIuOUzk/9abwQKsDc5RBsHBJQkOIP68qsm4M
         QnywJDFd4drZ3G2qqveGzeEXQ/iOG2zFYSmKYvkTUpK11hT0oyjOoVSlPi/905KPOiTh
         IFnlBfNVDPUeUzFrcDLrcwBtVjSRFKuK9XG7+kvcp7KJifE8Hw0S+DHpr/pGWdUyxm0M
         sl7Igao9jRf0GfoyHgodYlQMjk/ZMWe9o6aK6Fd/TkZO6ZU4WNVkDk2E8OwEsdAK1qzE
         6/jskGGLN6bwbHYgih5/AqMXTT380zbERLasr64xeZsF+NzTDJVPgKqFXiTVnSH4xSCn
         CMRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785312340; x=1785917140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q0Yd6Q4AnWVaWzw13DT5nV/m2mi7w3GBu7PU7kHWGEs=;
        b=P+eSmfamvtrbP0FfI2KjHseWl2eJxeqKZLAGHnCcUnc1L/Z2R40kC0kdSnKw45lZ9w
         nLxOZ+sqi9pdY2dOoPL7nl3gKK2EVEbf4y/yoWyRwtXH9zbSpqAAAV9Cd2FPZd4xD6g/
         zYI3csWB7XQwsU+f39agQVNNF/1w0HiR2vaHDQCDyzo0jxC/WWkRuDXZ0HU1oOEpUWBN
         EAQ1zGd1yVzzXLAeO5jfVh8Zcvs6crp3G3vr6C5DJcCo7bGp7/yQ1oafAcvQdfNKf8TU
         RgZsFPZnkTl5ozOcinahPC0vd8Bj7ALnDLUyvXmjn+ZawLx3I5nNWjdzSmwi0+sGepfV
         JwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785312340; x=1785917140;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q0Yd6Q4AnWVaWzw13DT5nV/m2mi7w3GBu7PU7kHWGEs=;
        b=Z8PJrTMEo5yUMMICEnEqbo9rXgSTv/5TBKiMGjti4IpXgosU5fA+Z9/qtMVq+Yj1Ys
         hr7zf1/HPPaNUWN02zRjYGbrmhkY1brZdYG2F8SKpaqN2LtpmZSym6tRVfamHsIg3Mmj
         kRDarTaQ1givcpKQ0Tk/okMl5IkybiA0oMSd5WQZJRwTGXnTSnQPKdddkD5qnpnxAI4L
         uR67H0ZndO0Ase24nal8V0zEc1ukVJpkQlrzHuGHBXyPfezJwFHjvBEpFj8ivh7Em94t
         jibPuOwRqNoD2DffDm+N8iIUDkzYp+hn9ccy4cNZGJz2o2Qlda7eerY9FBVb2QTiEszY
         AU4g==
X-Forwarded-Encrypted: i=1; AHgh+RpvItd44dmenxA4yTXvszova7QSe6tA+TsKi0wLbU7F5HD+smR2RndCk3VNUd69qNlGs4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIPYPpi50EHqk+yhSwhxnNueOAzFU7sEVsdinkGoiiI0/Mj/TW
	HJi4BEq3LBKg7QRSV9cfAavMBqCaraEQ3oqQjzMq2T7wQT+zxbrfe6sJ0p59afdALpO4o2cz2oQ
	BY3kZmmsn5+bj2AWQuEzokN9Byv6K8Rfi6FhcZWSWYg==
X-Gm-Gg: AR+sD12R0UO8n+gGZwLIuUPsuASgtCmt953Qyz9qPbHEbZcfEG8NCCTAFj/0KxScQRU
	daT5Lwc3FL8uHGSlNVwLhWVy1Yc7wRE0SA9zsKstHBIYgXGYuMsWwXnCeRJ3VnVDTZW4fmWLh8+
	TuP8LSc5ZdOFeV8vkk+7IO+Hsna1Aj0rgHO5abT8UmylfNAqWMY/TUuilnJca86xndO9Y0wqj2/
	qp+UjKptbfBC99irohYSE2zpBjYKWZ8CfkvOaaoeNTxg4WKGNAvjj0IzUCTJbCMF9WEICWLJ+07
	HzG2fxNeQBzrnfSdxqsHo40TSuQCt+JxvqdmHkUBnAHe6CgVevDzyCbF+nG+0UW9gRv4yAeVk2Q
	YMuk4KM9fHnwgIxf2I+CveJyTmSeZe1UF8JLWLnPG2emNmfAd1bXnppE4L6TDlOM=
X-Received: by 2002:a05:6000:25c6:b0:47f:9760:4d25 with SMTP id
 ffacd0b85a97d-47fb1ed9878mr6651215f8f.14.1785312340000; Wed, 29 Jul 2026
 01:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729070749.730218-1-shanbeeyoo@gmail.com>
In-Reply-To: <20260729070749.730218-1-shanbeeyoo@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 29 Jul 2026 13:35:28 +0530
X-Gm-Features: AUfX_mxBw2XjYIsxEgfq92ls8GlDDciTpiLck9rGbZxalgVjWkGw8ru_Xn3sDe0
Message-ID: <CAAhSdy0gaYBv3xktNsMGBA0qGNrOHdZ=Z1D7UTbVHCZuZcu1Nw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix spurious -EEXIST and clean up gstage
 fault path types
To: "Bingyu.Xian" <shanbeeyoo@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Quan Zhou <zhouquan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 12:37=E2=80=AFPM Bingyu.Xian <shanbeeyoo@gmail.com>=
 wrote:
>
> Two small fixes to the RISC-V G-stage page fault path, both suggested
> during review of the in-progress KVM Userfault port.
>
> 1. Treat -EEXIST from kvm_riscv_gstage_map_page() as a quiet success.
>
>    When a concurrent vCPU installs the same G-stage mapping while we
>    are waiting for mmu_lock, gstage_map_page() returns -EEXIST.  This
>    is not an error -- the page is correctly mapped and the faulting
>    vCPU can simply retry the guest instruction -- but KVM was treating
>    it as one: printing "Failed to map in G-stage" to dmesg and
>    propagating -EEXIST all the way to userspace.
>
>    Align RISC-V with x86 and arm64, which already swallow -EEXIST in
>    their respective fault handlers.  This also lets
>    kvm_release_faultin_page() drop its "ret && ret !=3D -EEXIST" special
>    case: with ret normalized to 0 the regular release path is correct.
>
> 2. Clean up fault path types.
>
>    - vma_pageshift: short -> unsigned int.  Bit widths and shift counts
>      conventionally use unsigned int in the kernel.
>
>    - fault_addr: unsigned long -> gpa_t.  RV32 with Sv32x4 has 34-bit
>      guest physical addresses that would be truncated when stored in a
>      32-bit unsigned long; gpa_t is u64 on RV32 and holds the full
>      address.  No functional change on RV64.

Don't squash multiple changes into one patch.

Create separate patches with appropriate Fixes tags.

Regards,
Anup

>
>    These type changes are in preparation for sharing a common
>    struct kvm_page_fault across architectures, as requested during
>    review.
>
> No functional change on RV64 beyond silencing the spurious -EEXIST.
>
> These are independent fixes with no dependencies; they can be merged
> on their own.  The KVM_MEM_USERFAULT port that motivated them will be
> sent separately as an RFC once the generic userfault series lands.
>
> Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programmin=
g")
> Assisted-by: YuanSheng: deepseek-v4-pro
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Bingyu Xian <shanbeeyoo@gmail.com>
> ---
>  arch/riscv/kvm/mmu.c       | 8 +++++---
>  arch/riscv/kvm/vcpu_exit.c | 3 ++-
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 8a0aa5e0e216..d2a06a54be17 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -541,7 +541,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>         kvm_pfn_t hfn;
>         bool is_hugetlb;
>         bool writable;
> -       short vma_pageshift;
> +       unsigned int vma_pageshift;
>         gfn_t gfn =3D gpa >> PAGE_SHIFT;
>         struct vm_area_struct *vma;
>         struct kvm *kvm =3D vcpu->kvm;
> @@ -652,11 +652,13 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct=
 kvm_memory_slot *memslot,
>                                                 vma_pagesize, true, true,=
 out_map);
>         }
>
> -       if (ret)
> +       if (ret =3D=3D -EEXIST)
> +               ret =3D 0;
> +       else if (ret)
>                 kvm_err("Failed to map in G-stage\n");
>
>  out_unlock:
> -       kvm_release_faultin_page(kvm, page, ret && ret !=3D -EEXIST, writ=
able);
> +       kvm_release_faultin_page(kvm, page, ret, writable);
>         write_unlock(&kvm->mmu_lock);
>         return ret;
>  }
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 6c8530b9f29e..76cceecee5ab 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -17,7 +17,8 @@ static int gstage_page_fault(struct kvm_vcpu *vcpu, str=
uct kvm_run *run,
>  {
>         struct kvm_gstage_mapping host_map;
>         struct kvm_memory_slot *memslot;
> -       unsigned long hva, fault_addr;
> +       unsigned long hva;
> +       gpa_t fault_addr;
>         bool writable;
>         gfn_t gfn;
>         int ret;
> --
> 2.54.0
>
