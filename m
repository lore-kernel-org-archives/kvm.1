Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CD240FDBE
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474735; cv=pass; b=Ko82ePAvjbdaDcVZ8oHB9+HRYH8HUP4igXwqYbHNlbUhbf2DQDUoNdaP+RpFZBdKWyjvef5NglwAkDgLFE+0e4F4GJdQA9rTonWzy6Z1iPR+wFenUrhJ3pc+QJPsd151niXdsIej5JNjwWXbrQA7m+qotn+1LoVvaz7J5ryqJjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474735; c=relaxed/simple;
	bh=9LYE03si7jha94qNg639WpYfpbPeoION4b178yhnHSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfOYm7n+OcIr0ozOQ/N3gETKNUxy9vWI1JJBOGLAOzLDor6lWQm+Rpf+F0MGGM2clntVaZgtb9zd3SybbE+Qyl7WiSuL6oRSygehrgdRD12Srv1axcj013WwuEKCaVCjoZmEb5o79SZNBpb69j7Los9hQs4t1I/CDu2bUqPtkPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=sCrFSLM1; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="sCrFSLM1"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e6b571750bso2690342a34.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 01:18:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780474733; cv=none;
        d=google.com; s=arc-20240605;
        b=AeFNkyDEQFiwpmSoQgIFcvQ0XEcboROdVE6ewKCwCoZvUrbBYY6tBaiTb7L99iFssq
         TU4ia554wga9itECDxZaXrN7jiDBjCX6z6FaR3oJ+Ak1UuA2lE0KnD0Xd/sd+rMfubHg
         3Q3JVo1X9r+KpXEUtFsgpArlj+wBZu8UY/DJObXVVn7gtYaMTAndlM2EmJ0bN0RMR9vy
         SAYPFe8dXeKSLUFgl+AQSmPACkL7acHr5AmDHwcB81EZsSl3PNpB/oZVuCNwViK7Qw1l
         R730gn2a86moU+QyUgRnpQY6lKB7Zt70rpe+MMxhrVFaU59fLctZQ+TzupbxS046laBu
         Ws7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kFeTv/Mtw5rUnQHNWc9zOtQG7POGqdE/BRFIOTGTTdw=;
        fh=h/n418oKg1+Rp9sLuFUR53gt5lnlvyEQjLYV/qpoRjY=;
        b=gTFgxcdNPsrH0zQsF/+habkMy7nsVSRLOTPsn7jY8gqr4n4y5LRM3snrmtpNKspGEY
         mralT9CGE2y32inV15ksH+BQWJRm+ItSTweZSagxkk0DsAYL2Ybryf8mDpYDPCQcnIAi
         djdy3RdkCIwcYRrj4f/uHW3ToD3rNjCjU0hDxFPTDKLf08ta2HW62oHBw2OA9a7+4QQy
         IPWOvJmLKPhUdkH7ZHGFjA9vvFvWJZ2nPIdJN21pnDANNqZVUYhdnHkQSQ23SH0LYifp
         sIsM+9vYjrkjp9lhTdfB1azTNiyZx4Crp/rmS2xtS/+jrQwH89FEicb2CKd8W8cNBfSd
         wRMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780474733; x=1781079533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFeTv/Mtw5rUnQHNWc9zOtQG7POGqdE/BRFIOTGTTdw=;
        b=sCrFSLM1gYIWUhaDACSrz/Rzm7RYSSIhFhO8VPuuYXpNMfL94c0IyeJX7nXQamzUxA
         4bpzoYx70zYcxNi/h/6hVS/9CT7fv/miZk/hSaBC6ClW3kU1yPYLxlNnEPxHkl8fhIh6
         OpHAGFJ3ugCMcXk1xf/VUzM9Lzj77JOFuRob4vpc8crDL6vxBxNgm+PxDpvcJb7oUGfG
         Zu1a8BhtU4V5xYgtdgKBmaVthJK2QbcZgQ/tpT6iiKPVRiK0I/bY5U3DvwrvckEamVMg
         0DPN3mIcZfdd3FslHQDP6OhjKvDU8NiWKKUhLWLwZL23GK4ygSiIHKRQNacudzmur22R
         bjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780474733; x=1781079533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kFeTv/Mtw5rUnQHNWc9zOtQG7POGqdE/BRFIOTGTTdw=;
        b=ldE1GhAhu3Ua1d46O67S65IozXJNLCH7lexsAgvjmgEOdhFfSSW5D5GlEY3xc3rhhx
         RPNldC1v1+no6t4rxV1/G4ehfuMmKllTfoL1FJE3xY4WYJg0FtINq5vYIo3ycCov/pq4
         PoajQAguvKa5OcDHdu5DyIkpfP2gApm9c5j5Io9Ir2iXQtogrsLLmVanK21YbA6KsNtW
         gdZn/MUQBQOiMzLxzEzfPmjZXrv5Hp6WnAtgat+aZAc7v/W6tqPLcPdnXPa5xnQ0DvUy
         AXBRmJwoFRtqdJDNtTtUc+TVw1zUexpyhqHzFEZAHMbaG8KH/47XQgzEbq/105SSFZ4c
         R2GA==
X-Forwarded-Encrypted: i=1; AFNElJ/5d87R+kQTMimQpkDCJJwPuo+Sra8XVHWcUcp3dzqV8TGrjvpuL+It0S+jzCSBC32tJjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsHMe8q9g8eI0fWH40SmQlfk6vBARek3Io+Bf2NJ94JZ+6fTeA
	0K6zBdfXIaOY4tr6Btbb/TD9+x0zWeGgHBNp6Q4B09BCeckot5f28w/1Ah3YAkBcotzJ0RQb0gU
	juDldZcYQLKiJ+0CZdjWW1xjXA571wLmUBxutYJxY+Q==
X-Gm-Gg: Acq92OEmZNJlNxk0HJ7yjy0eu0+orV9jgRG0SYJgSsB4zuoYWQjyVSSMroqjfrBXkJu
	hHNQk0HQiGvzgx8fYw1QIg85FeuywPtY83tO9tfVhTjp8L6yJq6MDU7gp3UA2YGlqQRB1dpGUFp
	YyP7bS1/WZa8aAn1dh3OJxEZ0kywqjdv8t7UbBbypQZs5rJbchV5aYg3aWrtArnKGJayscUON7i
	ppYVe6zaPtpR2fBw7zw3H+VkMFyh5Ehp5KV9mBrzEZv+Lg/0D7LGoL5GIZXcN4Ra9NEmXqQEo2H
	6lN0wjUjUClsIBFhneARxqBpzjZaSfI3CYbboc6ZLtirqKcLTRBng2GMsrvVucC6gMobwHizuA7
	CTIqkj9HHFl2KZC7dQTzEZNAbFhI29KQqDhc/YQ==
X-Received: by 2002:a4a:e053:0:b0:696:84a7:1c9e with SMTP id
 006d021491bc7-69e480ca3afmr1083284eaf.54.1780474732678; Wed, 03 Jun 2026
 01:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513153656847l3c4fI5hBsAyoIZi8aGIs@zte.com.cn> <20260513154125023xfKNqfea7TklqO9_RRrkt@zte.com.cn>
In-Reply-To: <20260513154125023xfKNqfea7TklqO9_RRrkt@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 3 Jun 2026 13:48:41 +0530
X-Gm-Features: AVHnY4KFDoPAklYlm9v6C3lajzcXBdS812tUFjYiyrvVraXpwSqHdXHXDDLKwNc
Message-ID: <CAAhSdy28AR=Gs90nofSWPkh9z_gmwmmTjsae_PCyyL_5qXcGhQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_2=2F4=5D_RISC=2DV=3A_KVM=3A_Split_huge_pages_when_d?=
	=?UTF-8?Q?irty_logging_is=C2=A0enabled?=
To: wang.yechao255@zte.com.cn
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 1:11=E2=80=AFPM <wang.yechao255@zte.com.cn> wrote:
>
> From: Wang Yechao <wang.yechao255@zte.com.cn>
>
> Split huge pages eagerly when enabling dirty logging. The goal is to
> avoid doing it while faulting on write-protected pages, which
> negatively impacts guest performance.
>
> The benefits of eager page splitting are the same as in x86 and arm64,
> added with commit a3fe5dbda0a4 ("KVM: x86/mmu: Split huge pages mapped
> by the TDP MMU when dirty logging is enabled") and commit e7bf7a490c68
> ("KVM: arm64: Split huge pages when dirty logging is enabled")
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---
>  arch/riscv/kvm/mmu.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 85a3fb2622a4..14c558ee5f15 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -90,6 +90,50 @@ void kvm_riscv_mmu_iounmap(struct kvm *kvm, gpa_t gpa,=
 unsigned long size)
>         spin_unlock(&kvm->mmu_lock);
>  }
>
> +static bool need_topup_split_caches_or_resched(struct kvm_mmu_memory_cac=
he *cache,
> +                                              int count)
> +{
> +       if (need_resched())
> +               return true;
> +
> +       return kvm_mmu_memory_cache_nr_free_objects(cache) < count;
> +}
> +
> +/* the caller must held mmu lock */
> +static void kvm_riscv_split_huge_pages(struct kvm_gstage *gstage,
> +                                      phys_addr_t start, phys_addr_t end=
,
> +                                      bool flush)

s/kvm_riscv_split_huge_pages/mmu_split_huge_pages/

> +{
> +       struct kvm *kvm =3D gstage->kvm;
> +       struct kvm_mmu_memory_cache *pcache =3D &kvm->arch.split_page_cac=
he;
> +       int count =3D gstage->pgd_levels;
> +       phys_addr_t addr =3D start;
> +       int ret;
> +

lockdep_assert_held ??

> +       while (addr < end) {
> +               if (need_topup_split_caches_or_resched(pcache, count)) {
> +                       spin_unlock(&kvm->mmu_lock);
> +                       cond_resched();
> +
> +                       ret =3D kvm_mmu_topup_memory_cache(pcache, count)=
;
> +                       if (ret) {
> +                               kvm_err("Failed to toup split page cache\=
n");
> +                               spin_lock(&kvm->mmu_lock);
> +                               return;
> +                       }
> +                       spin_lock(&kvm->mmu_lock);
> +               }
> +
> +               ret =3D kvm_riscv_gstage_split_huge(gstage, pcache, addr,=
 0, flush);
> +               if (ret !=3D 0) {
> +                       kvm_err("split huge page for addr(0x%llx) failed =
%d\n", addr, ret);
> +                       break;
> +               }
> +
> +               addr +=3D PMD_SIZE;
> +       }
> +}
> +
>  void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
>                                              struct kvm_memory_slot *slot=
,
>                                              gfn_t gfn_offset,
> @@ -136,6 +180,23 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>         spin_unlock(&kvm->mmu_lock);
>  }
>
> +static void kvm_riscv_split_memory_region(struct kvm *kvm, int slot)

s/kvm_riscv_split_memory_region/mmu_split_memory_region/

> +{
> +       struct kvm_memslots *slots =3D kvm_memslots(kvm);
> +       struct kvm_memory_slot *memslot =3D id_to_memslot(slots, slot);
> +       phys_addr_t start =3D memslot->base_gfn << PAGE_SHIFT;
> +       phys_addr_t end =3D (memslot->base_gfn + memslot->npages) << PAGE=
_SHIFT;
> +       struct kvm_gstage gstage;
> +
> +       kvm_riscv_gstage_init(&gstage, kvm);
> +
> +       spin_lock(&kvm->mmu_lock);
> +       kvm_riscv_split_huge_pages(&gstage, start, end, false);
> +       spin_unlock(&kvm->mmu_lock);
> +
> +       kvm_flush_remote_tlbs_memslot(kvm, memslot);
> +}
> +
>  void kvm_arch_commit_memory_region(struct kvm *kvm,
>                                 struct kvm_memory_slot *old,
>                                 const struct kvm_memory_slot *new,
> @@ -150,6 +211,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>                 if (kvm_dirty_log_manual_protect_and_init_set(kvm))
>                         return;
>                 mmu_wp_memory_region(kvm, new->id);
> +               kvm_riscv_split_memory_region(kvm, new->id);
>         }
>  }
>
> --
> 2.27.0

Regards,
Anup
