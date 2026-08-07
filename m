Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D991C474258
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120835; cv=pass; b=sS5PrRBissKvWqVa3ue9Tt61Zezgnh6ay/3Pe21263u/OB9S6RF5CGlVMVP3MKKGV22yJytKN3qUQ0idhFz3819ZSARTvnk3GjRO/+tLvay9PrV8SzKoRcTrLd99xRUSA9oZQXOLaopuvvvW/WtKpUSaPm4BvOYjXlLxbR6XREE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120835; c=relaxed/simple;
	bh=2HgwHZgTsQh36SFFCo0O64QWVhGbiodNcVh9j5w48WE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrRLJurWF1UYGnrwQdls0NU9jeWdddl0wkJLnBDRd/ryZbKnUoj9I1o7OKnvQManzDkX1u4ZqD97E2NKZZr6/gLJR8hEtsFRYL7YKYVssH+RLfh/Vd+UWCOXw42qKZrfpsRq9F34bTSaDnKrJEJGPl6GYJHwJ3z2r8FIeRJFd2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=iJJwYyIH; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="iJJwYyIH"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so12352195e9.3
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 09:40:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786120828; cv=none;
        d=google.com; s=arc-20260327;
        b=kw60SH7CDI7pZ8UETqhlKiKCp6sAtSxi13FGSE6laBUI35FGpZEiSr7WhdBpu03H7U
         xK7EfUQiaSu5SEYu22uzeyx67g1YbWje93BKRe6Wz3bX5JHwKORIoK/dnIUkMXYv+Qrj
         zhHGYxRCFE0hRmlimsa/uUd/J0yiZeo5BE8nGf5dmDyahUFxwrXwUSE6jLa8KC7MTsou
         yLh4dSRpGaZL+ciSz17WWb44DlsFHmq1MWmQPARNFQ2I7Y8DnSyNiPF0wy1JBFnLIcpV
         t9rKsgTSl6ICi9crKrsqi6WWJIfFPkIaQelCW/PVd8Z59glULVLszewqxYpSdqhc4oF5
         4VgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GSyds6W5OQ66XFXpi1LlEJdTPFK3iE4acomSvTp9bj8=;
        fh=TqkDo7HJm6C2bTHYqbzn7b/i6oYTm+CMOZGiIKAd8p4=;
        b=JwYsTL+/qKfvYmH2G+PHNx+MBgrLrArAi+iksP749pwaGXoWDU+XVtYUBpI4NrybKW
         NDiDLNAQT7nxr2/DSdYPTe0jH/ZKoROscgqGlqxaKQVZDs/7ufKJ+kmGPIlnX9QL7kE0
         dLElHResiPU4oynerTrrXOx7LrA0zsgmIL8mKFn0tvjGXA4TPQun0wdHX53K9PCLXQM8
         1TAYcpeu8zcIXD6G/zXpfe8WfyhTx+xj3qVy1m0k19nMm1Qb5TeQthQnvD+Yxmwv80QS
         dqJsj89lpiDsPGWmwt6DeGPJa0hclenstZ35hy/48C+9Ndcl4RcWGgg8YdJmwWRFjHSY
         inYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1786120828; x=1786725628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GSyds6W5OQ66XFXpi1LlEJdTPFK3iE4acomSvTp9bj8=;
        b=iJJwYyIHiIV2W4dVHE+5u5jVDfhi2bT4K6FUQKiqjeJV68stK8t1ibqpxcfMl6LfdQ
         XvbR5D/QLnA4JcqHt2zy3LphcXlZHNcJA1Lsb3PK2aXMXinJm5rUaUnNkrNXGjozdrYy
         t2NsZSb5M7rKUQAxsDY1NiySUFMGtzlpV679UKtUT2YsCDBnfzR6a67O2WknMpbce6Vq
         zi2LfA+BPQOizSes/hi1hZg7KXygneJYvbcKDs8vRK0uvcA1R4u9GDJQ1d8KhnzZ0Rrp
         idBx6b3F8G1xXbH0NuXqPc5cA0KBK9ovYfi3oSaGiBpJ5LEWUIAbbznaitldBGPlXSIs
         K18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786120828; x=1786725628;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GSyds6W5OQ66XFXpi1LlEJdTPFK3iE4acomSvTp9bj8=;
        b=GNLFJ9W7+Z33fpWa5JWMp0d3YDnh++s0pO3rio9vWbqpaRbIHZ9P8L5454ZgCrnxQ3
         laAJMXbBWkME4DsLi4jgELZlIODO6+Fg7u33Kxul4QolbSRNDRgYMojcMBJcbz5hIxkO
         1eLYpHYHXeZ0Swp5yBXwhBdlb7DKG9B0vt3e31fvErKi78VvFYJbrQTG/O4IaGmT8vs6
         QmSHoFCWkGobcJmDDWS7K5od0X7nlplZsu7qH/ZCylN6i3KeCuiadl9wrgBLFasA9/0H
         NvEsv/z7XYkZRspjcHm1N1+TiPgz7jTXbsg75hQfk0lO+eQ3XWzyLgD/IZCH8QDwVdh7
         TkSg==
X-Gm-Message-State: AOJu0YyoBeMBjDn5ZTxkypurKJmry6kNg/P52o2XE63Hbdcr++yskpxs
	rDl1C8g/GE1lRjtQa2/WiH15xMqnf84+lQEJSO40Mz/E9O5zTkm3NuRE0Oe4fbPmV5XWXM3YR78
	ECQizQxspISVSF6UnHLMyBD3j0MRX3s8ejZRE4iGwnA==
X-Gm-Gg: AR+sD12ASDJDDFV+49MHyQQP4LbvRlGkZ1t7bVR+C7Bg/v8k7OxngedKdwlpI1MtE5g
	wETO9L0vko2wVkuSSt3VugKthZpfLVLRqqrTlVSlKBScWCjwr04LvR9yzwstIV403FwrsPxDl51
	6nRcaUsIQgmQfACHTNcpznSoeu8hs14JlbPgns+1TVgMhBKBWhKvdR2JGIfu/3HH7EUILHxCvVy
	/1kHi9Rb9XhY0F6yaLQ6LvJIprzsQZExh1RABHjibhcs4ZpFSfnriBEY8PxrcKeI9CE4sBWQA9N
	fRdLCHmAZ51SCOx0MRVGzWq1/xJK3MI50rLahPA9plbCfXL5+dTtvUv+/b2cuixWDz5P7ytNA3A
	MjotdYB4zfGcnkSa62+ewZAgBVU6oo7X9j2B/f+8vEcrK9aFU4fpAffE2c7EgvhDm
X-Received: by 2002:a05:600c:3545:b0:499:52dd:c1f0 with SMTP id
 5b1f17b1804b1-49952ddd05amr206480125e9.1.1786120828407; Fri, 07 Aug 2026
 09:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717080654.877151-1-wang.yechao255@zte.com.cn>
In-Reply-To: <20260717080654.877151-1-wang.yechao255@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 7 Aug 2026 22:10:16 +0530
X-Gm-Features: AUfX_mzs5xvuhUuNS2PSxFtD2Spckea2gbhirvVXYUtFbIp9N-L4RwLlBOai4MM
Message-ID: <CAAhSdy1g5Qa0OVUyjfz4c+bySkcXyk12LcSnsuDUOCCQo=7_ZQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Improve dirty log clearing by skipping zero
 bits in mask
To: Wang Yechao <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 1:39=E2=80=AFPM Wang Yechao <wang.yechao255@zte.com=
.cn> wrote:
>
> The existing kvm_riscv_gstage_wp_range() walks the entire [start, end)
> range to apply write protection for dirty log clearing, even when the
> provided mask has zero bits (i.e., many GFNs do not need protection).
> This leads to unnecessary page table walks when the mask is sparse.
>
> Replace the range-based approach with a new function
> kvm_riscv_gstage_wp_pt_masked() that iterates only over the set bits in
> the mask. For each set bit, it looks up the leaf PTE and applies write
> protection. Once a huge page is encountered, the entire huge-page range
> is processed in one go, and the corresponding bits in the mask are cleare=
d
> using bitmap_clear().
>
> Performance was measured with KVM selftests dirty_log_perf_test on a
> Spacemit k3 host with the following configuration:
> - vCPUs: 2 (-v 2)
> - Memory: 1GB (-b 1G)
> - Iterations: 3 (-i 3)
> - Write percentage varied via -w parameter to simulate different
>   dirty mask densities.
>
> The following data shows the time spent in the clear-dirty-log phase
> (i.e., the KVM_CLEAR_DIRTY_LOG ioctl) under each configuration.
>
> +------------------+------------------+------------------+-------------+
> | Write Percentage | Original (s)     | Patched (s)      | Improvement |
> +------------------+------------------+------------------+-------------+
> | 10%              | 0.012905         | 0.009213         | +28.6%      |
> | 30%              | 0.014217         | 0.010287         | +27.6%      |
> | 50%              | 0.014606         | 0.011772         | +19.4%      |
> | 70%              | 0.014735         | 0.013199         | +10.4%      |
> | 100%             | 0.014759         | 0.015294         | -3.6%       |
> +------------------+------------------+------------------+-------------+
>
> The performance improvement is most significant when the dirty mask is
> sparse (low write percentage), which is common in real-world scenarios
> with low to moderate memory write intensity. In the worst-case scenario
> where the mask is fully set (100% write), the optimization introduces
> a slight 3.6% overhead due to the additional bit operations, which is
> acceptable given the substantial gains in common cases.
>
> This change significantly reduces the number of page-table walks when
> the dirty mask has many zero bits, improving the efficiency of
> KVM_CLEAR_DIRTY_LOG and related ioctls.
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.3

Thanks,
Anup


> ---
>  arch/riscv/include/asm/kvm_gstage.h |  3 ++
>  arch/riscv/kvm/gstage.c             | 59 +++++++++++++++++++++++++++++
>  arch/riscv/kvm/mmu.c                |  2 +-
>  3 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm=
/kvm_gstage.h
> index 21e2019df0cf..50c74527ddd2 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -82,6 +82,9 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gs=
tage,
>
>  bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, g=
pa_t end);
>
> +bool kvm_riscv_gstage_wp_pt_masked(struct kvm_gstage *gstage, gfn_t base=
_gfn,
> +                                  unsigned long mask);
> +
>  void kvm_riscv_gstage_mode_detect(void);
>
>  static inline unsigned long kvm_riscv_gstage_mode(unsigned long pgd_leve=
ls)
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index c4c3b79567f1..9af86b1c5e3c 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -472,6 +472,65 @@ bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gs=
tage, gpa_t start, gpa_t end
>         return flush;
>  }
>
> +static inline void clear_huge_mask(unsigned long *mask, unsigned long pa=
ge_size,
> +                                  gfn_t base_gfn, gpa_t addr)
> +{
> +       unsigned long start_index =3D 0;
> +       unsigned long end_index =3D BITS_PER_LONG - 1;
> +       unsigned long end_gfn =3D base_gfn + end_index;
> +       unsigned long aligned_start_gfn =3D addr >> PAGE_SHIFT;
> +       unsigned long aligned_end_gfn =3D aligned_start_gfn + (page_size =
>> PAGE_SHIFT) - 1;
> +       unsigned int nbits =3D 0;
> +
> +       if (aligned_start_gfn > base_gfn)
> +               start_index =3D aligned_start_gfn - base_gfn;
> +
> +       if (aligned_end_gfn < end_gfn)
> +               end_index =3D aligned_end_gfn - base_gfn;
> +
> +       nbits =3D end_index - start_index + 1;
> +       bitmap_clear(mask, start_index, nbits);
> +}
> +
> +bool kvm_riscv_gstage_wp_pt_masked(struct kvm_gstage *gstage, gfn_t base=
_gfn,
> +                                  unsigned long mask)
> +{
> +       unsigned long page_size;
> +       bool flush =3D false;
> +       bool found_leaf;
> +       u32 ptep_level;
> +       pte_t *ptep;
> +       gpa_t addr =3D 0;
> +       int ret;
> +
> +       while (mask) {
> +               addr =3D (base_gfn + __ffs(mask)) << PAGE_SHIFT;
> +
> +               found_leaf =3D kvm_riscv_gstage_get_leaf(gstage, addr, &p=
tep, &ptep_level);
> +               ret =3D gstage_level_to_page_size(gstage, ptep_level, &pa=
ge_size);
> +               if (ret)
> +                       break;
> +
> +               if (found_leaf) {
> +                       if (ptep_level) {
> +                               addr =3D ALIGN_DOWN(addr, page_size);
> +                               clear_huge_mask(&mask, page_size, base_gf=
n, addr);
> +                       }
> +
> +                       flush |=3D kvm_riscv_gstage_op_pte(gstage, addr, =
ptep,
> +                                                        ptep_level, GSTA=
GE_OP_WP);
> +
> +                       if (ptep_level)
> +                               continue;
> +               }
> +
> +               /* clear the first set bit*/
> +               mask &=3D mask - 1;
> +       }
> +
> +       return flush;
> +}
> +
>  void __init kvm_riscv_gstage_mode_detect(void)
>  {
>  #ifdef CONFIG_64BIT
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 082f9b261733..7eab58ff63f9 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -110,7 +110,7 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct k=
vm *kvm,
>
>         kvm_riscv_gstage_init(&gstage, kvm);
>
> -       flush =3D kvm_riscv_gstage_wp_range(&gstage, start, end);
> +       flush =3D kvm_riscv_gstage_wp_pt_masked(&gstage, base_gfn, mask);
>         if (flush)
>                 kvm_flush_remote_tlbs_range(kvm, start >> PAGE_SHIFT,
>                                             (end - start) >> PAGE_SHIFT);
> --
> 2.27.0
>
