Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794572207;
	b=XPQ1elGi40SRbNa97EJfo6u5vhZOo+Na/1O7CotBH7eQBTxE247IwIJ+CSo3IBpQsUl2
	 BDOOyWOogEEBxkMJQEkLRWu1zStWND9UU/Myei1jwanmEuNaoQ40NW0LWfWXHjvhcoo3j
	 YPB2Dk73Yl80GiqtPAyIaZcaUawm/ff19ZHcFY2dKDWS0VENPwhW51ecqdT/xQR9gCaRf
	 Sov39PRxBkc9BVp17zVhKNJGqWbmrfnYSUDZCRCYtlj1HB5zWijeDsXmYEmedLhniTJXW
	 qNsGpsYea3w3uWX1rSoxGXoYprcJ6yG8j+REtypLAgPcyk9I14Hje5eeX9yHeB4ODUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yh//LwFAWkhuSX27zp/CKGjXWFK/r7pkuQ5AkJ8bS8k=;
	b=NqfmUHA4sE2JeRRAaBmfVnhdKiLxSs1TFLcWCwMbk7/Xn0hPx7x3DmEWaH/7ZXJqTWZr
	 9skNr4nVOxhQSgIjNPOtOegGFUvvtgSVwXgTp322W5UZIhulj2D2AmJ2CTe9NS+6yeStI
	 +GjVSoezrFeOwZnIX6XCMdb7jNV1ae8/EoLRM4XRKbyiQcXm+eOFwcMhyEw25Xs0b6TOk
	 8B0LL532EH9cNoMfQwFE69np1OINnYfqC5wVA0daAi+wmz6b6UtN8DEd/lUK4wGKRRn5J
	 PXhPHF+SRvhRsdFNa+DdbM2YhfDH7JCbMMtlIPVRXL02fA1i/RJRD/j5yqikU1o3tPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b="e/Zx56Yb";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A703606A321
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 12:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A703606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=e/Zx56Yb
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so1825665a12.3
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 04:16:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794572205; cv=none;
        d=google.com; s=arc-20260327;
        b=ENFfTonRk/rlZRE2nGDh4oKOb4yl0OOedWAdRRcPnhZ1ZVut8Y/K2+ipWG2y8dymUX
         zTocfbj48Phsk7F4iwGEeIBkiZNYvDNhAm0/TD9Pbf94tA1rDukjJDDRJ1iiqA3PYVX2
         tjH6OoiJEIxSqbr5V964fzxGJ5DFgnr6VvabAEdCme2MlvxcL2sivx+wGCgUrwIeOlfj
         pMlUP6t4JsaI5wUmZT7B533F92BvQPCuIvA6oIA9amgljpFNTEeoK4xivhQULqwY6KP6
         d05nmDZyML5+wGpRqnN0DT4yLftbsOOQMJ9Gl8LNQPWrwdQZCVe+GnecdBLhI+SUg4tf
         1q3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yh//LwFAWkhuSX27zp/CKGjXWFK/r7pkuQ5AkJ8bS8k=;
        fh=MwN6bCj4eNLzK1pKhCjc0H4KMrXt2c009THC92xWbSQ=;
        b=JTLBi4WwGg7tWXlW5pdnIHSDWlbeZJBLfvHIA7s4LKckKePnIccbsM46jhi62WQRZM
         CblamApOcnI/F0byx/ZCqVdRwi0BXvJzZ0Fo42HhIdFgA1yzgrH0P1HEdTALKTpwFO7o
         e2O22xN8yRRF7zkVHcDCOh7Tx2G0JB2OQIlv8owfOK3+hgIM29yaEK7g8Eveo7fYCvMG
         JcQV7isdbhIGZAmSM0Nu8WkrayssnroRNkETPcnFi8hVgEBeEWCF0tA78ndqjTPa0uhE
         34yW3+pty/0YTz1fbHbq3Vidg76hIR/alsiZyXFXHHYqsOOvqXEbJ8oh01b1Uab5aAg2
         JkXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794572205; x=1795177005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yh//LwFAWkhuSX27zp/CKGjXWFK/r7pkuQ5AkJ8bS8k=;
        b=e/Zx56YbBCjgsMtG5kmlIHcHvE1J6P4joVmzF9dfp0gpew/WcvK+LQo86o3z5cIQyI
         yK/1GAJiVW9CEyH9ubTAy6Wzcuk5LfuDIOU4HSPzBZO5VsDaBgG2mvNLrS2jZjQJafOb
         5uoSaa7DjtWrkm4WowzVwxq7KrrQiGO5+QN2QGNBX+f9fsL/G6ONSjLQou0mIqQ6dBZe
         nNvWPGqi8QX9PFdJFbuKvu5RxG62KdLZmrUdVIhSKPNC/tw+lME1WznJ1/o993s+XHQ2
         37yB4jGRiscVgqNWd5/ZqJaK6+rBt172tp8VegOdRm6TG5pTfXaby5H26I5BjOqDhAui
         MNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794572205; x=1795177005;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yh//LwFAWkhuSX27zp/CKGjXWFK/r7pkuQ5AkJ8bS8k=;
        b=gN1oU+OfcMqM+jemmbNUO5/bcNi1ran24pyUFJzRftxrfTuGya5qjombQBelmDhERc
         hT4EMFbBa7Z2TJdL8WydQCjeFEPMdL2WkL/RVubixwfJvSXN4AkOoZX1qQFpRzrnUMIX
         6BFOJg0ZldYfaNFTN2bE4QfO05V+tdk8WE5VtpGK1B81r2spZfBUdFb3V0GVRHXX58FA
         ZV3Fh+zBLtMOpurLSZyHtVQ3QTHkfNS39iRp4yBnndHDGV36UFoga4rq1vzY0Ffj+kEv
         iF4vBRSLr7w9dG8qxMuMFzPo70FBYv+zNcce+7+5m5UPNxX9WQa52FJOp2mz/nHD00AW
         DvSw==
X-Forwarded-Encrypted: i=1; AL+hErG3ozn31iOdnBWki1kyisiY+WbYOeSbNH37qMRlNwYXRQqeRMyaaEAIsdK6Ip2222xGjuU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/j2ny7QFJc2qFVufSRbUbE4EB1T9GSBe3chx8OosCyAhzNOB1c
	S64H/yD1KKIUKKeWtcj+5+fIixQBYaQCmfpmpeyS+HjL7PFCJxvnNMlntOJ5hCpNIfpHyDuopbJ
	zQJIzAZl1dgYnWv7UkV5o7lFFnSzSnN7eM6HHMOCPiQ==
X-Gm-Gg: AYBFou2A7d85DNvgxYC61Db1COmXG+FI4xpZGyGLdLkyM10XbK030uYSHOvc4NzgrJq
	f0oqAhlBEKf6ikc/IrtH202q/MOuhgJ8qdIh5lt4lgfbzOH4vqx/qstxk/4ZTPC+sEG3ZpgWsV2
	7bbPfC9w89uWezXX0D9JplkmI3M6Qqc611rLaKt3d4P2MbL8UYqq55KtjvlBpMTGeSZ5xpUGHek
	4Z6Jy8Cjpv4J0W0bBN7dVQtAQxxOT652T+Mzcm+Bih/8L5By0aLPKg0kQtZpBkdjvg/HYpVf7IM
	kZ5I/ljQdU2o+9fOtFBg8HrCMaP1znTZny8pikfkhD+dpqqNXfUgIgXpwSJ81gZRm2gICP2857n
	aassi1CZ1WedexQwtIV3hsAc/ZpbUv6yXH7T/oetHwMFdbw6ouwPd5kKd5UUfLAhTCzs3dxoptj
	mabSSwtSiTIBzYs6rWLVFwb583byKM8L020B+MwoYnPh+APsH+l3tEQq3+IjDHLYibOxHgHGK/F
	luh
X-Received: by 2002:a05:6402:5177:b0:6b6:fddc:dbc1 with SMTP id
 4fb4d7f45d1cf-6b7c08b08admr1438436a12.6.1794572204712; Fri, 13 Nov 2026
 04:16:44 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <tencent_C8B170AF63DC42F81A47F9EA044BB4B11C09@qq.com>
In-Reply-To: <tencent_C8B170AF63DC42F81A47F9EA044BB4B11C09@qq.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 13 Nov 2026 17:46:32 +0530
X-Gm-Features: AclHuK-Kyzf_3Aa78LNIir_Q7TGPINiFuQF__Q3gkCjYhZcKlm3MtE70aN1T8Lg
Message-ID: <CAAhSdy3K1AFB-DWKznNru+x2hNiP5_M+uTZEZBHWwdvLfJrNQA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix G-stage page table memory leak on VM destroy
To: Yangyu Chen <cyy@cyyself.name>
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 12:28=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wro=
te:
>
> kvm_riscv_mmu_free_pgd() tears down the G-stage with
> kvm_riscv_gstage_unmap_range() over the whole guest physical address
> space. That function looks up each address with
> kvm_riscv_gstage_get_leaf(), which walks down to the leaf PTE, and then
> clears only that leaf. kvm_riscv_gstage_op_pte() frees a page table only
> when it is called on a non-leaf PTE, which never happens here, so every
> page table below the PGD is leaked when a VM is destroyed. With 4 KiB
> mappings this is one page per 2 MiB of guest memory that was ever
> mapped, plus the upper-level tables.
>
> The leaked pages are not slab, vmalloc or page cache, so they show up
> only as unaccounted used memory. On a SpacemiT K3 host, a workload that
> creates and destroys tens of thousands of small VMs leaked 0.5-1 MiB per
> VM and ran the host out of memory after about 20,000 VMs.
>
> Add kvm_riscv_gstage_unmap_all(), which calls kvm_riscv_gstage_op_pte()
> with GSTAGE_OP_CLEAR on every PGD entry. That recursively clears all
> leaf PTEs and frees each page table below the PGD. Use it in
> kvm_riscv_mmu_free_pgd().
>
> Tested with a reproducer script that builds a minimal KVM host kernel
> from a source tree and boots it under QEMU 11.0.2 (TCG, rv64 with H,
> Sv57x4 G-stage). Its init creates 10 VMs one after another. Each guest
> writes one word in every 2 MiB of an 8 GiB RAM region (anonymous memory
> with MADV_NOHUGEPAGE, so 4 KiB G-stage mappings) and then shuts down,
> so each VM needs 4096 last-level page tables (16 MiB). MemFree lost per
> VM, after one warm-up VM:
>
>   before:  16415 kB  (RESULT: LEAK)
>   after:    1636 kB  (RESULT: OK, noise)
>
> The bug was found while investigating the host OOM, and the fix and
> reproducer were written with the help of an AI coding assistant
> (Claude). The analysis, fix and test results above were reviewed by
> the submitter.
>
> Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programmin=
g")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

Good catch. Thanks for the fix.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as a fix for Linux-7.4-rcX

Thanks,
Anup

> ---
> How to reproduce:
>
> The reproducer script is at
> https://gist.github.com/cyyself/23abb87a8ad9ee8c64ce03cca78669fc
> and needs riscv64-linux-gnu-gcc, qemu-system-riscv64 and cpio. Run it
> from the top of a kernel source tree:
>
>         $ cd linux
>         $ /path/to/kvm-riscv-gstage-leak.sh
>
> It builds a minimal riscv64 KVM host kernel (allnoconfig + KVM) into
> .kvm-leak-build/ and boots it under QEMU (TCG, -cpu rv64,h=3Dtrue) with a
> static test program as /init. The test creates 10 VMs one after another.
> Each guest touches one page in every 2 MiB of 8 GiB of guest RAM, so it
> needs 16 MiB of last-level G-stage page tables. The test then prints how
> much MemFree each VM leaves behind. The first run takes about 1.5
> minutes, mostly kernel build; reruns take about 10 seconds.
>
> Without this patch:
>
>         10 VMs, each touching one 4 KiB page per 2 MiB of 8 GiB guest RAM
>         MemFree 2037664 -> 1873512 kB: 16415 kB lost per VM (a leaking ke=
rnel loses ~16384 kB)
>         RESULT: LEAK
>
> With this patch:
>
>         MemFree 2054080 -> 2037716 kB: 1636 kB lost per VM (a leaking ker=
nel loses ~16384 kB)
>         RESULT: OK
>
> The exit status is 0 for OK, 1 for LEAK and 2 if the test could not
> run. IMAGE=3D<path/to/Image> boots an existing kernel instead of building
> one. That kernel needs CONFIG_KVM=3Dy, CONFIG_BLK_DEV_INITRD=3Dy and
> CONFIG_DEVTMPFS=3Dy.
>
> I also tested VMs that select Sv39x4, Sv48x4 and Sv57x4 through
> KVM_CAP_VM_GPA_BITS, and four VMs with mixed modes alive at the same
> time, destroyed one by one while the remaining VMs kept running and
> were checked for correct guest memory contents. With this patch, no
> memory was lost in any mode and no guest data was corrupted. Without
> it, every mode leaked about 16 MiB per VM.
> ---
>  arch/riscv/include/asm/kvm_gstage.h |  2 ++
>  arch/riscv/kvm/gstage.c             | 22 ++++++++++++++++++++++
>  arch/riscv/kvm/mmu.c                |  3 +--
>  3 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm=
/kvm_gstage.h
> index aaf080ba1b77..90ec9e0b34b1 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -80,6 +80,8 @@ bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage,=
 gpa_t addr,
>  bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
>                                   gpa_t start, gpa_t size, bool may_block=
);
>
> +bool kvm_riscv_gstage_unmap_all(struct kvm_gstage *gstage);
> +
>  bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, g=
pa_t end);
>
>  bool kvm_riscv_gstage_wp_pt_masked(struct kvm_gstage *gstage, gfn_t base=
_gfn,
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index e5002cb9cbef..c912cdc2021f 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -456,6 +456,28 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage =
*gstage,
>         return flush;
>  }
>
> +/*
> + * Clear every G-stage mapping and free all page tables below the PGD.
> + * kvm_riscv_gstage_unmap_range() only clears leaf PTEs and leaves the
> + * page tables in place, so it cannot be used to tear down a G-stage.
> + */
> +bool kvm_riscv_gstage_unmap_all(struct kvm_gstage *gstage)
> +{
> +       u32 level =3D gstage->pgd_levels - 1;
> +       pte_t *pgd =3D (pte_t *)gstage->pgd;
> +       unsigned long i, page_size;
> +       bool flush =3D false;
> +
> +       if (gstage_level_to_page_size(gstage, level, &page_size))
> +               return false;
> +
> +       for (i =3D 0; i < kvm_riscv_gstage_pgd_size / sizeof(pte_t); i++)
> +               flush |=3D kvm_riscv_gstage_op_pte(gstage, i * page_size,=
 &pgd[i],
> +                                                level, GSTAGE_OP_CLEAR);
> +
> +       return flush;
> +}
> +
>  bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, g=
pa_t end)
>  {
>         int ret;
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 371fccaf9df0..87838a0f6bb9 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -784,8 +784,7 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>         write_lock(&kvm->mmu_lock);
>         if (kvm->arch.pgd) {
>                 kvm_riscv_gstage_init(&gstage, kvm);
> -               flush =3D kvm_riscv_gstage_unmap_range(&gstage, 0UL,
> -                       kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels), =
false);
> +               flush =3D kvm_riscv_gstage_unmap_all(&gstage);
>                 pgd =3D READ_ONCE(kvm->arch.pgd);
>                 kvm->arch.pgd =3D NULL;
>                 kvm->arch.pgd_phys =3D 0;
> --
> 2.53.0
>
