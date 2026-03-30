Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675446DCE1
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774851972; cv=pass; b=qFx94Y4ZSyvptNa089eFwPEhOJKjpVabaLFzMC/fznRgDb4zczM2bE/4Fl2cE+bLpJTt1rD9c1L/OnIXFA1lrzGPGgltIMq6+Yxgl+4EvHY1HyzK6FRrmPMRkLq3LZxTTyNCV040Y6FD92s3u2cEs6E1r0MRj6EzA8N9MXsDM8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774851972; c=relaxed/simple;
	bh=Rawj/CvTWFyCZgS3sxbkr8Sj0DOCvhRkgjnQWNtzyW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLksM2+QCgXXY/jDZQGmVLf7rrRPK2fT1jXKohjDZtwcMJaY+shZT0rYxbVi6P48HigLP/9MKnx3euDR4q7d41kW4bWX2+n+76+yG3OK9vJEJF533XtRhA9oyYD/bxPmUBO6DyD3dP71Wg483JRi/CFfvqzMcenFq4D0d3G4gXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=ue5SWqD1; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="ue5SWqD1"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d7f92bde91so2739637a34.1
        for <kvm@vger.kernel.org>; Sun, 29 Mar 2026 23:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774851970; cv=none;
        d=google.com; s=arc-20240605;
        b=fN16QbSMXYwv1i9eBQwJ9ASUMJ4YxlaS0Zw0eWd85wkMB8nmH/OZEt3M4xYVmEtXxS
         gZjc50q69Yfm9FcQ3eSHtgpVr9bdxNrU/BxSW2jfRV8LEOGS8NXqL9M+Klvs9XjAU8Ol
         B93t+ixFWAtg8dzN4CcK956ovydeRvvBsJVHdBI5ZNWfo3okVLpsuv/09r3dGxi2MEe6
         zw4/xCewP35r41TwOcArbzrdoblFlhWvyy4FYB/sMa1JqLlj9bZl+aRak7AvI3drHvWN
         9KX4se2rCxAYmXQiJZz5CsK7ehM2fh7UQNeBaeXEiGNBYdkZQvoDGf20NVVI02n9k6dR
         g88g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yrwvlaBx0LSVffRWiq7EdPDPOPDDTLgFInSvGTF5+7k=;
        fh=pma8upGwsHPY0tz8VOc86SZAWOxYU48De9h6K3VkWtQ=;
        b=CCT6N5q5vWgYPPHV1bwC01IKJjW5ooq0mSAriF3i78XVir258W7UfgIOqsGfgzciB2
         YmEcC3/yQjq9JzrKSG3SpUJglNqS3y8eoxKKYCtnc+a0ifN9u5Pz5r0niQi5fMUlK92/
         6xhRlzbvGM0wCB3SR5D0jnGuwFg3+PYmUMjX+vcF5Qu4dKFQa/F2r9Frt9UkhTalyV0E
         1m11h8gI0NbE2yWxm+A/pchlf/v/uqbcD8UmVYy7g2vAxkV2yVEKSOxWKE4nqUiM9Faw
         mjzcqL0oYRp9sHmesvyd/NYUpuQxN1Qz9s+uq2sD2xsiMbxIxJWCgMTO2NJPCvVBvrgM
         paLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1774851970; x=1775456770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrwvlaBx0LSVffRWiq7EdPDPOPDDTLgFInSvGTF5+7k=;
        b=ue5SWqD135UlNkuEUTgQj0mdUseb4CB/T15Oi37TEWEkFm0QbYjpv/Gg1ITW1oreF9
         4b8JiFR1l0seJZOzuk1hO6DSf4bqCIGQKHphhvuucIvnms5HdnEWBVKgBNDFnBlQoF5z
         nJYa6RI/aWuKzmLaClab7MSMVgCJ0PBswt0S8/6YKfwRnzjscbbI0m7T9RylLNkI5pyq
         +aZl/7xbBKsRZXgC9MkpAbfKX+AE/kbFNzxmAUhXg3kf0ZfFp/+leVEqMCexIv0v7gC2
         7v4so7mgK0UHEPWX/Qho6zoEgvT/xmBHtf3/w/KdCT7pPFrbEEtc1DW53pcRu0KXL9k3
         PJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774851970; x=1775456770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yrwvlaBx0LSVffRWiq7EdPDPOPDDTLgFInSvGTF5+7k=;
        b=Up2gO88XMxjJ23RSXlGWoW7yOunWBgvmmCcFWhIuWyw+V09/ucgii+0DHtEts0TSI5
         J39oFytxDa49C6otiKtXxxNbkeo9ZcWwSUwpc9B5+X6HyvUQfhoOywecCLV4otGGo/id
         b61F8Q6kMg2vk+eA0wqLWXexvvlOgxcluh9lGGoYWJhAzdNokNRqnCdfOJUDjxXUaUpQ
         r5CSBj72hjNbmTF+4Hns0BB16rNOD28igRLQn7dhUNSfHgkrGegrgIWDx5DI5XXf4xn7
         QuzjZMJWvgtAGYNitfZ5fpCF9NCMMVDwIzpht593D+xeGWJ1mTcrlF4P0jvciZy4FMCu
         14oA==
X-Forwarded-Encrypted: i=1; AJvYcCUdAknnhDunwsgSclYOdN8pyqW0JR33/777RFHqcUmU1WkZsFa2DDsjqoHXKPLZpwp4uvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYvYeVFMDJeLSaf+MDPOaF4nqtPOgHCydyW0gICHAzvvB7Oup+
	ZgxxJtfutE9w/ugtUrIBOWblfT+Sb0kRL/R8M2Qn+HoOTDnTAlASdvBggdbNI9lAZOn4HD/E9Ad
	3+HEWFb33xLPT5AxQkFm+FfLv0i7ifxr8bhyiFcDMdw==
X-Gm-Gg: ATEYQzwbmHvDSOtxNWyWWFYGYJ2Du//oCB/olFVMcf96AZE8Zc7OxmYSy7FoVXV/NEJ
	1fcRkludhdhJbZEelxeas7fEuSX+i6SkKPPZ+Tx5XSwcLvpcMku7ntB1HkIHttcHLiV5v8x/BTZ
	HC3MFmFWmId/gZp+df4gFCaaGV6NilmwA+v+ZxehpQmnrgSLdIj+aO0D/CTPN25THUVZcI3xZ3D
	LjUKWhXblQfE9cUXpCQHz/1EB3hOEN4v3tTgMF+8sMHZovNfTHx1IGy7IfRaFMuoqgslxAeQ41O
	2ofpR7MUKozhrUzzLvWoRQIzDxPgBso6/SOTTMYaz2Tuhdqs19fpZpxuBAezlCwKabVbFNbxCoy
	BfDHhCbUCc/eudeUDiZoUi9Dy3g==
X-Received: by 2002:a4a:edcb:0:b0:67b:c368:1369 with SMTP id
 006d021491bc7-67e18789a18mr6118049eaf.67.1774851970320; Sun, 29 Mar 2026
 23:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316141234007qSAOsesu2cSQsj-LA-qq3@zte.com.cn> <20260316142017362R7MOT-xQWGMPiGnD0zuht@zte.com.cn>
In-Reply-To: <20260316142017362R7MOT-xQWGMPiGnD0zuht@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 30 Mar 2026 11:55:59 +0530
X-Gm-Features: AQROBzBSVCFROHxb8xNa1XL2q6xBhknLcFRs-3GhKLKb_1oKXuQ7G-6tU_lxD0U
Message-ID: <CAAhSdy0Yc_iViKv7r69=m+XrpHxpvWKQNgqBYDKM+dQtNB_8ng@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] RISC-V: KVM: Split huge pages during fault
 handling for dirty logging
To: wang.yechao255@zte.com.cn
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 11:50=E2=80=AFAM <wang.yechao255@zte.com.cn> wrote:
>
> From: Wang Yechao <wang.yechao255@zte.com.cn>
>
> During dirty logging, all huge pages are write-protected. When the guest
> writes to a write-protected huge page, a page fault is triggered. Before
> recovering the write permission, the huge page must be split into smaller
> pages (e.g., 4K). After splitting, the normal mapping process proceeds,
> allowing write permission to be restored at the smaller page granularity.
>
> If dirty logging is disabled because migration failed or was cancelled,
> only recover the write permission at the 4K level, and skip recovering th=
e
> huge page mapping at this time to avoid the overhead of freeing page tabl=
es.
> The huge page mapping can be recovered in the ioctl context, similar to x=
86,
> in a later patch.
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---
>  arch/riscv/kvm/gstage.c | 56 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index 5356abb18932..4bee042f3c7f 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -163,6 +163,21 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gsta=
ge,
>         return 0;
>  }
>
> +static int kvm_riscv_gstage_update_pte_prot(pte_t *ptep, pgprot_t prot)
> +{
> +       pte_t new_pte;
> +
> +       if (pgprot_val(pte_pgprot(ptep_get(ptep))) =3D=3D pgprot_val(prot=
))
> +               return 0;
> +
> +       new_pte =3D pfn_pte(pte_pfn(ptep_get(ptep)), prot);
> +       new_pte =3D pte_mkdirty(new_pte);
> +
> +       set_pte(ptep, new_pte);
> +
> +       return 1;
> +}
> +
>  int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
>                               struct kvm_mmu_memory_cache *pcache,
>                               gpa_t gpa, phys_addr_t hpa, unsigned long p=
age_size,
> @@ -171,6 +186,9 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gsta=
ge,
>  {
>         pgprot_t prot;
>         int ret;
> +       pte_t *ptep;
> +       u32 ptep_level;
> +       bool found_leaf;
>
>         out_map->addr =3D gpa;
>         out_map->level =3D 0;
> @@ -203,6 +221,44 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gst=
age,
>                 else
>                         prot =3D PAGE_WRITE;
>         }
> +
> +       found_leaf =3D kvm_riscv_gstage_get_leaf(gstage, gpa, &ptep, &pte=
p_level);
> +       if (found_leaf) {
> +               /*
> +                * ptep_level is the current gstage mapping level of addr=
, out_map->level
> +                * is the required mapping level during fault handling.
> +                *
> +                * 1) ptep_level > out_map->level
> +                * This happens when dirty logging is enabled and huge pa=
ges are used.
> +                * KVM must track the pages at 4K level, and split the hu=
ge mapping
> +                * into 4K mappings.
> +                *
> +                * 2) ptep_level < out_map->level
> +                * This happens when dirty logging is disabled and huge p=
ages are used.
> +                * The gstage is split into 4K mappings, but the out_map =
level is now
> +                * back to the huge page level. Ignore the out_map level =
this time, and
> +                * just update the pte prot here. Otherwise, we would fal=
l back to mapping
> +                * the gstage at huge page level in `kvm_riscv_gstage_set=
_pte`, with the
> +                * overhead of freeing the page tables(not support now), =
which would slow
> +                * down the vCPUs' performance.
> +                *
> +                * It is better to recover the huge page mapping in the i=
octl context when
> +                * disabling dirty logging.
> +                *
> +                * 3) ptep_level =3D=3D out_map->level
> +                * We already have the ptep, just update the pte prot if =
the pfn not change.
> +                * There is no need to invoke `kvm_riscv_gstage_set_pte` =
again.
> +                */
> +               if (ptep_level > out_map->level) {
> +                       kvm_riscv_gstage_split_huge(gstage, pcache, gpa,
> +                                                   out_map->level, true)=
;
> +               } else if (ALIGN_DOWN(PFN_PHYS(pte_pfn(ptep_get(ptep))), =
page_size) =3D=3D hpa) {
> +                       if (kvm_riscv_gstage_update_pte_prot(ptep, prot))
> +                               gstage_tlb_flush(gstage, ptep_level, out_=
map->addr);

Why not call gstage_tlb_flush() from kvm_riscv_gstage_update_pte_prot() and
return void from kvm_riscv_gstage_update_pte_prot() ?

> +                       return 0;
> +               }
> +       }
> +
>         out_map->pte =3D pfn_pte(PFN_DOWN(hpa), prot);
>         out_map->pte =3D pte_mkdirty(out_map->pte);
>
> --
> 2.27.0

Regards,
Anup
