Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7243546DC
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 05:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476099; cv=pass; b=NE7nE/vN8ECMOnNqRF7TVkjGiUYC13oG1xpm3FbDxDkaBAVhIqrblWZN6aja3Av9JrX8XCtF6HIctRXWkX0zF4E4vS3VunwIBCnPPlKVLvzqodPP9GoBYf+QqX9CRvbj7oqrZ22qLR4KLqE/QJWZVfds+BAtBF+RuOlfTlsNQys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476099; c=relaxed/simple;
	bh=lpnCisGfnjKP55mrgSjBhKrw0Jv1s9bGELYR9JoCWQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocHprzyskQhSbMoGF+FqJkICHQ0DsUudx880Cpjx9lUya/Hf8wuzwRtFVetPMoQDIm+Vimqk6GaDVKFs72K0hajNzpwPTVxGVim2SqmG4+/JYa6/EkWyyQ2U7w+/JtzlH8YiBe0MuXd+CwbxEN80hVoK5Ny15Ay36fTkl5TK2AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=nz3QFpWf; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="nz3QFpWf"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47de0093c42so473380f8f.3
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 22:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785476095; cv=none;
        d=google.com; s=arc-20260327;
        b=CHZ1smO+W5ht+fsBxWU5/Vh8vESL5RGkC8IKzlX/FmDyLEiq69iWV+hZIGug/4+Pok
         JN4g97lcErJHUduh1e7fSJEpXVU5KHgTAcll5AP4ggl0SctWRppJ1UuM2vyuYXqf4Iof
         CKubSwhnDsGJWAI04ydJuadozf3/JmnyoyEikF44einFCEGTdi5hhpnzI8qsmE6TAJ1c
         5iFgkU8iLF53s2Sv7bjWZC7WJOX2gQ0H3GuoGMFhvaO9pXzSYKxO5DSoouuQsa3aBETC
         dL0Zmquzm64GnV2sBHefYdpfx3yPDCSlvPWRXST2SuAW5MPKEngubEZLHnXGQHwFx/dM
         bQ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NpDPKiNmGUabqt3eiQx1uoLP1i93SqQSGHcFDJqZaIs=;
        fh=TqkDo7HJm6C2bTHYqbzn7b/i6oYTm+CMOZGiIKAd8p4=;
        b=L0XOdGjObdjgvbHpzVc9f0HSph3WB8HyHM6fKchnwtLkcRFRBX0Hz/HZzIi8n1M7yK
         sAkQNjLaYbwHdCaeEqfN4R/RG0SiuxilIAIeE8ONn4OYMV8d+LVZ3E+HkCu4Qbz/uvud
         9yxcmaE/k+GUYxE+t7h2PJK3HEX/z+PEi59gM4nXxA4qxZgBug7ENWkbVhHhTexfvuYg
         5SSm9vb1aSWupazqotFX6iHeSXs5aqqTNyYhoK9eALEgus2UKCqjE9TMAF1UrWQp/ihg
         tHjak+LDwUM67h+8auoOBsefQaF9dirWgrdc7EutJGvl6kip3d0CB0vnZzPthbsx1IfY
         T4AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785476095; x=1786080895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NpDPKiNmGUabqt3eiQx1uoLP1i93SqQSGHcFDJqZaIs=;
        b=nz3QFpWfV5wGy31KD7Tuh8ff2Tf4tlUPw8kTcyUtdh+///gu6qHjtUPJD3Kc7uybj4
         qAuCF7rGUsMyWS4TxgyPd5MUmrQHTcWSwUtq9/FaXzfWWYvdQ8UpAfNfvmHjSnARQbON
         DBSyTErQoJXc3i0pWqo2DGAxZhldAgrQB/KDyfSxCQZd0p81JrdUZCIRduUtmBY91LXG
         T14Bc+w8WFAqyUW6dOThBkv2un93SlKUoAivVLbx2ELyocs3fxHRCLoqgTcG35Em50NM
         6EEVzPfgMKwQs66by+s/Igr4+fo+KyNhszEljnwMSDzgWjrWUD5/DfrmMMKUmYg8NAvb
         beMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785476095; x=1786080895;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NpDPKiNmGUabqt3eiQx1uoLP1i93SqQSGHcFDJqZaIs=;
        b=VdZPuZuFaqDLrPBgXuNWDWO4ACNp83c/BqQPiMCHv5vdu0oGYM/+W11qf/uD79/RyG
         YtHQEsok8io1SK8Vq+ViloLXG1fPfOgSF/PFHkeqz3n8oBwS2CK1D270kKRbDs+7d9fl
         64KNg3rpjLprWs52sxnn9XCpQDJNyIjjhjrHuHNkYmyFYnrglq4snaBMUsqV1U/y0Y/Q
         Dmj7rJnmEUg1jPUzdmX4A4Xd05msrE9maHtUQ2zj/b2gjOvrOOaNGqIkjTFXXxC8l35v
         yL/y9WGJ5aePEjfke/2LoL8HYVK/ynL1oAGFW1/c7AUbfuoCFUeyaPNipITzOF6jJue7
         pwLQ==
X-Gm-Message-State: AOJu0YxfOJpRtz4khjHzz30KiBJMQxbwD8vQxZv3oh4KInCBf9ktNk3t
	A0KThyJ/V4boz9Fv2rRmKxMXiSM1hGA+yLdFhjPwdiKuVbUC7rJsoTrV9fVUYX7+eXV6WgfBdy3
	Fq6Q7oTdGzuzLXRm0SNocMa1v1CyCtFND5gx3qrnmfw==
X-Gm-Gg: AR+sD11rc98yjKxj4Iqm19Mehy9CtWggLpzyy11dLk5+QrIoMwbteMWeOshTM3DRgX/
	CXLg+M62s8qTAMn9hX3iDWKE9iD0+75qV8j2atjzxqHqImrSN2Las4aoWzfCY5XWUQy9WsqNlu/
	1MMf7yGAFE1hvvvV41H9F2Yx8ToPx24ajSppABKOB3EuiVkYug3GumTdvWbHBI9S9B5HBxe4B1K
	uMZMrFMUS9GCR3jI49BbiAmIW4qvNo0DEf5MUxhjh5mfWpFFWMNWjER4nMzmsngHrW3hvPksH5x
	389GfHKfLIqbRtTGWicZhgMXOFol1z0ejh4/WMOJoLbYm43UIuIGpmiEnK2iMLi5NjhKCW50G1j
	lyPjrv83vMFrKGgTRCt/dKEZjSTMeXPGItEbAEhsAWiYOPNSY6G3Z3A0OPuZPQQU=
X-Received: by 2002:a05:6000:2311:b0:47f:cbbd:30ea with SMTP id
 ffacd0b85a97d-47fd2adbd1bmr1653851f8f.14.1785476094426; Thu, 30 Jul 2026
 22:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701120954.129873-1-wang.yechao255@zte.com.cn> <20260701120954.129873-2-wang.yechao255@zte.com.cn>
In-Reply-To: <20260701120954.129873-2-wang.yechao255@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 31 Jul 2026 11:04:42 +0530
X-Gm-Features: AUfX_mz-aI72aPwGaPZcnLKH5SWuqKULd4t8IFNAhAJTGqns5eM5RX6MLLFbxew
Message-ID: <CAAhSdy0_dCHC+ZVG7HZdtUxZWWX_KG3YfN=ngVdpy-7_pquUFA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] RISC-V: KVM: Add the split page cache for ioctl context
To: Wang Yechao <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 5:41=E2=80=AFPM Wang Yechao <wang.yechao255@zte.com.=
cn> wrote:
>
> Add the split page cache for dirty logging enablement and the
> KVM_CLEAR_DIRTY_LOG ioctl.
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---
>  arch/riscv/include/asm/kvm_host.h | 1 +
>  arch/riscv/kvm/mmu.c              | 1 +
>  arch/riscv/kvm/vm.c               | 6 ++++++
>  3 files changed, 8 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 60017ceec9d2a..69f73fd106a94 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -86,6 +86,7 @@ struct kvm_arch {
>         pgd_t *pgd;
>         phys_addr_t pgd_phys;
>         unsigned long pgd_levels;
> +       struct kvm_mmu_memory_cache pgd_split_page_cache;
>
>         /* Guest Timer */
>         struct kvm_guest_timer timer;
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 082f9b2617338..9cf69bc28b9c5 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -676,6 +676,7 @@ int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm)
>         kvm->arch.pgd =3D page_to_virt(pgd_page);
>         kvm->arch.pgd_phys =3D page_to_phys(pgd_page);
>         kvm->arch.pgd_levels =3D kvm_riscv_gstage_max_pgd_levels;
> +       kvm->arch.pgd_split_page_cache.gfp_zero =3D __GFP_ZERO;
>
>         return 0;
>  }
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index a9f083feeb767..be38f24a297d6 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -54,6 +54,12 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>         kvm_destroy_vcpus(kvm);
>
>         kvm_riscv_aia_destroy_vm(kvm);
> +
> +       /*
> +        * Free the split page cache after all vCPUs and devices are dest=
royed.
> +        * At this point, there are no concurrent accesses to the cache.
> +        */
> +       kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);

Better to do this in kvm_riscv_mmu_free_pgd()

Regards,
Anup
