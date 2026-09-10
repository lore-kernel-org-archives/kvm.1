Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401EE488D84
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048756; cv=pass; b=Ij+/06R/TQPQZPr0G53+nVRKE3jitd0xMwqufC7SXNMPFWQHs5nXzEodD0RldzCwGAO/FnRx8b04Iv96cWwbqI32MRMTuvBQKr6/ZNP02L0p5hp0TZCPVAD5rhCHCRtNjQNnqF1LOeKg4FJFVSE9UEdLh4VfZX7Q0VoUyc+OtpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048756; c=relaxed/simple;
	bh=ZZvvuoaYfIXmr8UO0wotjAdQWitg9LH2mpC2WJGAYbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBUjl5SNH/XEbmhY831mkpoE8RQjg7aTOiyWxE5+9WNgnnJueIl54hh9CbajOELJbeey+zpO+vfsSUBoPJO0hO6vrCy+49vah744qY/+8XjGxV9wBhD8Tq/Lfp7oUyNgb5pr84j+iR1nzgxJNfsUIEbqxAljy1mYDZ7WoqIHXnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=ZOm+TsBW; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="ZOm+TsBW"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c2790ccso1479248f8f.1
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 06:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789048751; cv=none;
        d=google.com; s=arc-20260327;
        b=JGymiAAtXfesZ6ruxTw9iCqu9iQeek47qlUy2RW/CP7tabnTwIiXBqIN08P9fvg6Dg
         i1tZj6auxHyzku/IFizspf3YxAm4bpNKkUJuYW+4+oE9l6G2icoXcccjxd9cjjWAUhh0
         fMAtrGKhBloRCH8rAGZo2SzgPRIXTw5eOGukRPXnXabHvnbj7gaQPhYX8i7ntuj2L3dM
         ISQT9oNXw6+N2yNsxfjn3KogCOFgA2dilC0H2NhpsVqEbGWSGpNnytce9BrlFIjyuGSK
         +6D3CuSvza2L0arZJQrJMPM8HWtyXrHREjoNZzc3vh090hKPgIrp/nlXoe7lCj7qFdxM
         CG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ntUgUOcZUM5+aK8XwHOyZhsMc69vpZvSuPPgaYDDMnc=;
        fh=rTnyuI0f6lCmpstHXLDkyJr91iyalUdMVmbabMNrgLg=;
        b=OdBsX9558dQqvQpfeNKJOHNkBh15biTPktXjcqgu1ZHHoL+TeX3TbacmsxhheroQq/
         Tgw2dOqsH1ATk+Xwf2kZLwX3YxTS/yn23Ml0ZL+p+ZFZ+LTuRJS16dJznRCxTUOHD3x3
         lYbLZW7pmrfCx90UX79ek/7aeySs4BHHDGwyEbZu1MN+i+UkiZdyySuucxqrhj0QeEGn
         GFIDgPzv+fQLiFifQ5QEm/M4tfa8ytEqdgLAoaDJ6C6AyiHwfQuVrBxLDRLhFWHLcHdL
         AuCc1r80b0hOq+uL6KDvdm2GlT7Z0+tr4QWgv3pq73R3LrOGvT7nMTbG2JirMQJuEIMV
         jBhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1789048751; x=1789653551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ntUgUOcZUM5+aK8XwHOyZhsMc69vpZvSuPPgaYDDMnc=;
        b=ZOm+TsBW9E6FYiIdVN4eF/oW5j+SgDOQpPiZ8tkY4wK1H4belKr2Ov1LXuAdBTv096
         Wda8bSUSbXM537LBrFoA8lT8sbV7xvjab1AqlmdDwhnaDdBoqtCDD8Hq4FxKDZKYF+KA
         UJs3ohuadmzBsiJ02927Op6M8h2dZB6IrVP97e7tMvKoJ6gYYcxGwLSHAG8VrqWhHvJi
         VgmuOP3BT0H5ofYIuVW5I7E57mMlyzvVyUmJ7JHXQlq39f/btYhsZ2bocXl+hKoxwymx
         lq+FREiVIgfiv+yrTeS92gNkhJbliOKbvlVjX1rIojxU25SPtCGshi9sczB1YDsQ2J2R
         JsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048751; x=1789653551;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ntUgUOcZUM5+aK8XwHOyZhsMc69vpZvSuPPgaYDDMnc=;
        b=LDm3AbwID27if5LCkmHSmhuLjf4s6Y/5GX8j06pOlzDP1crMbFD5+xbJcbpV5O1RdG
         oOiVB7QQJKc2Sp/TBbyIi7890rHbt21ymLalUjUeFv6Mj24Y7IVp1LkH8hp2HdnsI3D/
         fBgcIGPOcsmhthEmF2PijtwVa0UzkHJfM2iHwt9zOuXP+EB4aMjwBQA6oZd2RsGzgcuo
         WHQgSFrsc25dT6NUP/ietCkQWWJXemuwfrTTe350gumlcue/s8qp3/CcwutNoLClVfo4
         OqfstnjhLKE/5YTbfdIA2jPdKKRCzIAzTKVL3zJdfuZ8or7d63TXoAT07KbuIP6Fm2xh
         zTTg==
X-Forwarded-Encrypted: i=1; AKwUvBzK6AkGSSDMHqDnbmi1Pu4mmhrVdfD/2Oc8PL35cns2pSOkyDoza26jp2jZqPUvHtdqb1M=@vger.kernel.org
X-Gm-Message-State: AFuF++mTTcdJ+CNzOq2NRMYniAA3CCJwAcH20A3C4YVYRA0xAECL5SbC
	j9pptAvLHqNOvby3If7wbGnFyyxfaWqcxYUaE5MJe3nj/2aDRG+7P54/VQdBQtVDVDD6iGv1fXY
	Xe+xq5gnLmD1tFZ2qdxEb3Q1ofj7YMiqHe0cgV0Amow==
X-Gm-Gg: AYBFou1k/SVID0JAc9TlAxcVPH4S/R3ik1ZMO2FhuwgtrGsVL7Weuhh/XQBnxH+bC9v
	YNFMff1QOmYbT1CElTt0sTbmCBzMbIjYLhiMsI7vZfoByjHBru/gLZn4D8fauZvdGJbq4buaAKq
	V1UbWIJFCAPOQUOWlRaY7Tar+K2A9eZbbZrRHP1pRwrLeHx08ytAfCzPzZwPu9MtN9SJbNldRtG
	BkfxpRZbiUI4WLmeR0QdfxXB0CD5GidFAeMBUzI4KPVL6zVrbsTiSC2S1oEeri68Bij5vpx7BNS
	dFMcNFNyrS9gUZ2ojuObRKMvaicOZE5fQ3h1udgOUSKRA2LPwHxO9T9FPwNyOozQuMZfXuufRlt
	YZbwglWDu6lq5M/Mq2FTWp0CpGYJ0D0h/gkbi1ARwcVx6jGKd35ETsSvy7cFwME5ideFKc1SLPQ
	==
X-Received: by 2002:a05:6000:402c:b0:485:acfd:4fa2 with SMTP id
 ffacd0b85a97d-485acfd572dmr20259573f8f.28.1789048750919; Thu, 10 Sep 2026
 06:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810051544.3953925-1-xb@ultrarisc.com> <20260810051544.3953925-2-xb@ultrarisc.com>
In-Reply-To: <20260810051544.3953925-2-xb@ultrarisc.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 10 Sep 2026 19:28:58 +0530
X-Gm-Features: AcwNN1VoynwwDilW3Qq5_YgkFrLdSifis-TkUfgosx4SiSWNhFsAD_CF6I0IGk8
Message-ID: <CAAhSdy16n_zWBudDS0_E8xK=mhKBOvLMz00SRWnY0ArDkJF=qw@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] RISC-V: KVM: Release unused page after MMU invalidation
To: Xie Bo <xb@ultrarisc.com>
Cc: kvm-riscv@lists.infradead.org, Atish Patra <atish.patra@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 10:46=E2=80=AFAM Xie Bo <xb@ultrarisc.com> wrote:
>
> If an MMU invalidation races with a G-stage fault, the fault handler skip=
s
> installing the page but leaves ret set to zero. As a result,
> kvm_release_faultin_page() treats the page as used and can unnecessarily
> mark it dirty.
>
> Track the invalidation retry separately and release the page as unused,
> while preserving the existing return value so that the vCPU retries the
> fault.
>
> Fixes: 2ed90cb0938a ("KVM: RISC-V: Retry fault if vma_lookup() results be=
come invalid")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xie Bo <xb@ultrarisc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this as a fix for Linux-7.3-rcX

Thanks,
Anup


> ---
>  arch/riscv/kvm/mmu.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 6035b5e..d189fd5 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -627,6 +627,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>         int ret;
>         kvm_pfn_t hfn;
>         bool is_hugetlb;
> +       bool unused =3D false;
>         bool writable;
>         unsigned int vma_pageshift;
>         gfn_t gfn =3D gpa >> PAGE_SHIFT;
> @@ -719,8 +720,10 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct =
kvm_memory_slot *memslot,
>
>         write_lock(&kvm->mmu_lock);
>
> -       if (mmu_invalidate_retry(kvm, mmu_seq))
> +       if (mmu_invalidate_retry(kvm, mmu_seq)) {
> +               unused =3D true;
>                 goto out_unlock;
> +       }
>
>         /*
>          * Check if we are backed by a THP and thus use block mapping if
> @@ -743,7 +746,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>                 kvm_err("Failed to map in G-stage\n");
>
>  out_unlock:
> -       kvm_release_faultin_page(kvm, page, ret && ret !=3D -EEXIST, writ=
able);
> +       kvm_release_faultin_page(kvm, page,
> +                                unused || (ret && ret !=3D -EEXIST), wri=
table);
>         write_unlock(&kvm->mmu_lock);
>         return ret;
>  }
>
