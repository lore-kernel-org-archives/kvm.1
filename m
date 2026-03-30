Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66CF393DFF
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 06:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774851971; cv=pass; b=nq11C2KP+cCG7/uUF8u8ryrj3kjIS87HOb+oMteLNICCbCmvj+AnUyKvNJD+c+gcEXd1KpV6b2D3LvKihYRBHrpdC/qurTwKLfEgNWGEtA+bcXpMkWLHOJs/f8msoOMTXezJdG91iOj/dQGdjbVgfEwA50Xm3wjhgMQokBZUA58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774851971; c=relaxed/simple;
	bh=1W3RUolmXmQh3DtnvDWG9XkNSC0W+7vCEX0lM0NUrqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nr0lnsXxtcUkYAFZ6SfTSbdYSCt6UEz1Nu442s1DJF5zXupspEBjikif96WoKD3CFg3CB2CkrksnWI8RJ/vuXjMdCTimNbkvuTExqVor/kWJGSvUcJeeFLTXB+DiQZbbyGc6sr+AaKT/g1qbGk2aoX4NLh+xjmmN83P5RxCBHxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=u8IIPYG2; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="u8IIPYG2"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-67e2c70864aso597690eaf.0
        for <kvm@vger.kernel.org>; Sun, 29 Mar 2026 23:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774851969; cv=none;
        d=google.com; s=arc-20240605;
        b=choGqe8i861hCWRBtJgB6bmdiLuW72s4DWld0U9Z7T8LfQqgD6q5ikmIOQP3wkZWmw
         Ugu9Vmg3bXbB4dnL1nTZuGTqovJJuYjrVUjfYjXy3DDjHNiGGns8HVMelcaYDZ6MXrgi
         CtCriYw+Qxq2mPZnQHe2wZFJFXVtWe6w3gXl4sUk/D1z7xc3bcst0+Ho/VEjFdbMxuuM
         p0uC4ExlLT696CiD//ab9oW2TmSAd2wpba08fknj6TbWhKqXzweoRF7J2KOJJT3JdiYw
         U2yWI7eAMEs26dOHa/vZW0lMsgTpBdkPeirQU+CTur+ETzEceRs4xaz/gDFA5jxsKTAc
         AkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S7ukPQa8UA4mhzoG0Xk36CRAuFWmAhxbj7qoH+L5GUg=;
        fh=JldkgcoCxPagkOKT/qsfypRdS65+wX/c6HX7/XwB138=;
        b=XVLLpHloUdPcSjDjxVFq9dFX45pDYbFEimunQiYaxJAcTLbyzVSq/1umHV2JNL3PQl
         OCCRZiL27ra9CTxlwvYf0vTh7lPd2V61S2nub0mus2WCT4cntUZ2nrZjnfzwL2X4HIwa
         cdTTbBnlLlDbJh7KzSkXQgOAv4mBNYx1NCpQDyXosrFGR9CSPcXvvb3gcLSJJrfPMAov
         rRDNRq2b56VlMLhId3n7KbQwe7hf72B76kV8i9gZAlLS+i1UXPzvMolfHV+1pJDMpjCN
         ujq8CN1MnU9qM2Z4L1SnnzsLLIj8d5FeCz8I6Lhewn17gL76CfP7hvY9F5OR6PtDPAcU
         a65g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1774851969; x=1775456769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7ukPQa8UA4mhzoG0Xk36CRAuFWmAhxbj7qoH+L5GUg=;
        b=u8IIPYG2/oGe6lO2Gr+2HlaQGUWF4cMptl4rOCfO94PNjhizXHVu22eT/woBc6RnnV
         6CRZsNbtXGYUWDoM+dXTHY4AAvPaTejoyOsdNNenJ5I+027Ll8j1WI3MFSb9MQ8JtToQ
         E7BJycwvGJjzhnx2t+b2Xjop9sfAUNaDbq/krzboHa6v4PTlqV5jvOUT5xcu2JfZ8df2
         L9T7GwLcG1Ehnv8PEgZ7f55hWMkYtoDoigFeDLfJrDX0q/nI7hS9fYteynAdq9jiyS3D
         YH8CqqlSAU0I2jBmK5iQWgbNQKQq8h171pGyHLUcNjEKjOEjb2sqwkOnQNvkZuCd+oWe
         MkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774851969; x=1775456769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S7ukPQa8UA4mhzoG0Xk36CRAuFWmAhxbj7qoH+L5GUg=;
        b=RjNSBHdJzOhMHJSgKWFDNtmCmKUMmFH01HfMYi27hZ+8JMEDVucWjA5lYlZqifA0G9
         ICX32PTwFAuj23rVKM2Uplh8OY7Almje5UvtH2bX8T3+J15AZfYKvhvX0Zn5i+ZpxTlb
         93dKvOsMMkSMxd2W2Fx03qXq2S/kcdgYqjD+JKYv7vprkGXzh8l4+kruxSG8McFYYAt/
         adq4RgEYy21wrLPJkX1plIYnKdqX/6WTIRjT++rrXvj5hulnm/L/wlOcP4GIKHQeBuXQ
         z6VN91/i4QfOvdu17IEaYn4dclixwAFGV+nB0BZMPjtmpf3EKS+w2nKP6/uF5D8dqtDZ
         Co4g==
X-Forwarded-Encrypted: i=1; AJvYcCXyd0URJCE4vSGzXVLT+vi4gAZvneCKCR3LndApsEY9b/UDz3fm+bO7oyC5vL87+AnNSaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA1GHzhcxMdPPpWggDvVywJ4abOkAC6pxWd62jYXShJe7bTl9Y
	6rCfutTp2UttCzs46BCH1eaqJSoTOuSE9fVlrLzZoLv+o+uRT+CRnp137arCttKDowkQmYQDLMC
	6IvVO59Qi9nwnoVS2Euzm+IWjkZa+hQAT9e1SQioQ8w==
X-Gm-Gg: ATEYQzyHjM30HlqR20YxtFUT45tC9TOta4YiKKveP9NyHUcpF3ERsOl4qoBqH23uBVw
	sRz3C171KxWHPpclpLB7EbGYPTlMpTUpZX+6Y+XyixZD6g9gqSW+pDu3QxeIvl0SUWdC7qT8cTc
	A35vBslg7wUAEfII3s83vbi8Pa51caQyP50UXdBo85fLKsJDVJAmG1GNmpvsR/zBFrDOaLIHWoH
	2MS2/rDXxn3pL4jYrmH9I3uGP1dBL/Z1J30Odh/fwMbul4UDeF1sWzIdb5GmY8ohS+uyYmiH9dq
	d5/qj47DehFZKm5H0jliUDtEpzkPsARa87AtI7V4YBeD9KMHfMsOmI2oTuvhp5VZ7Q2eelQ9AeI
	joGbR6m93cgqSHYQbTP1BOnOEmg==
X-Received: by 2002:a05:6820:4b8b:b0:67e:ca3:9c25 with SMTP id
 006d021491bc7-67e1863e4e3mr5724052eaf.28.1774851968771; Sun, 29 Mar 2026
 23:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316141234007qSAOsesu2cSQsj-LA-qq3@zte.com.cn> <20260316141836922ffC0zmiE01ptC2jpXl4zJ@zte.com.cn>
In-Reply-To: <20260316141836922ffC0zmiE01ptC2jpXl4zJ@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 30 Mar 2026 11:55:56 +0530
X-Gm-Features: AQROBzBDFmkMIaqvBMfy22hBMT2RUnYhvKcW62n6PtbYmFj9Ey95kgwKiNKUHAQ
Message-ID: <CAAhSdy0KTUjSbkpW=X_hbfw2qtEhWEVSr2i85ixBw4hzxuQsxQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] RISC-V: KVM: Allow splitting huge pages to
 arbitrary level
To: wang.yechao255@zte.com.cn
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 11:49=E2=80=AFAM <wang.yechao255@zte.com.cn> wrote:
>
> From: Wang Yechao <wang.yechao255@zte.com.cn>
>
> This patch introduces the function kvm_riscv_gstage_split_huge().
> It splits the huge page covering a given guest physical address down
> to a specified target level (e.g., from 1G to 2M or 4K). The caller
> provides a memory cache for allocating any intermediate page tables
> and may request a TLB flush after the split.
>
> This functionality will be used by subsequent patches to split huge
> pages before handling the write-protection fault, or for other operations
> that require page-level granularity.
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---
>  arch/riscv/include/asm/kvm_gstage.h |  4 ++
>  arch/riscv/kvm/gstage.c             | 69 +++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm=
/kvm_gstage.h
> index 595e2183173e..373748c6745e 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -53,6 +53,10 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gstag=
e,
>                               bool page_rdonly, bool page_exec,
>                               struct kvm_gstage_mapping *out_map);
>
> +int kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
> +                                struct kvm_mmu_memory_cache *pcache,
> +                                gpa_t addr, u32 target_level, bool flush=
);
> +
>  enum kvm_riscv_gstage_op {
>         GSTAGE_OP_NOP =3D 0,      /* Nothing */
>         GSTAGE_OP_CLEAR,        /* Clear/Unmap */
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index d2001d508046..5356abb18932 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -209,6 +209,75 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gst=
age,
>         return kvm_riscv_gstage_set_pte(gstage, pcache, out_map);
>  }
>
> +static inline unsigned long make_child_pte(unsigned long huge_pte, int i=
ndex,
> +                                          unsigned long child_page_size)
> +{
> +       unsigned long child_pte =3D huge_pte;
> +       unsigned long child_pfn_offset;
> +
> +       /*
> +        * The child_pte already has the base address of the huge page be=
ing
> +        * split. So we just have to OR in the offset to the page at the =
next
> +        * lower level for the given index.
> +        */
> +       child_pfn_offset =3D index * (child_page_size / PAGE_SIZE);
> +       child_pte |=3D pte_val(pfn_pte(child_pfn_offset, __pgprot(0)));
> +
> +       return child_pte;
> +}
> +
> +int kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
> +                               struct kvm_mmu_memory_cache *pcache,
> +                               gpa_t addr, u32 target_level, bool flush)
> +{
> +       u32 current_level =3D kvm_riscv_gstage_pgd_levels - 1;
> +       pte_t *next_ptep =3D (pte_t *)gstage->pgd;
> +       pte_t *ptep;
> +       unsigned long huge_pte, child_pte;
> +       unsigned long child_page_size;
> +       int i, ret;

Declare local variables in inverted pyramid fashion.

> +
> +       while(current_level > target_level) {
> +               ptep =3D (pte_t *)&next_ptep[gstage_pte_index(addr, curre=
nt_level)];
> +
> +               if (!pte_val(ptep_get(ptep)))
> +                       break;
> +
> +               if (!gstage_pte_leaf(ptep)) {
> +                       next_ptep =3D (pte_t *)gstage_pte_page_vaddr(ptep=
_get(ptep));
> +                       current_level--;
> +                       continue;
> +               }
> +
> +               huge_pte =3D pte_val(ptep_get(ptep));
> +
> +               ret =3D gstage_level_to_page_size(current_level - 1, &chi=
ld_page_size);
> +               if (ret)
> +                       return ret;
> +
> +               if (!pcache)
> +                       return -ENOMEM;

This checks needs to be outside while-loop.

> +               next_ptep =3D kvm_mmu_memory_cache_alloc(pcache);
> +               if (!next_ptep)
> +                       return -ENOMEM;
> +
> +               for (i =3D 0; i < PTRS_PER_PTE; i++) {
> +                       child_pte =3D make_child_pte(huge_pte, i, child_p=
age_size);
> +                       set_pte((pte_t *)&next_ptep[i], __pte(child_pte))=
;
> +               }
> +
> +               set_pte(ptep, pfn_pte(PFN_DOWN(__pa(next_ptep)),
> +                               __pgprot(_PAGE_TABLE)));
> +
> +               if (flush)
> +                       gstage_tlb_flush(gstage, current_level, addr);
> +
> +               current_level--;
> +       }
> +
> +       return 0;
> +}
> +
>  void kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
>                              pte_t *ptep, u32 ptep_level, enum kvm_riscv_=
gstage_op op)
>  {
> --
> 2.27.0

The kvm_riscv_gstage_split_huge() function introduced here
is only used in PATCH3 so better sqash this patch into PATCH3.

Regards,
Anup
