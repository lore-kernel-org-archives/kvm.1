Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD26415B83
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385409; cv=pass; b=INUUc5qHolbfF6cHaNKV3p2wOPfqjFvtIpIKrGirBX6CytBYLKvUlwwS3VUB+G+n1878ygFHh1I/sQJ0o3WFaLjfRaKukdio3mYf7xOR4K2UzvauHlOgeLh5qXetv5PTbC0FRq8wUBFCDvY6s6aU3BLepOphub3ZnWlzO2Da1+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385409; c=relaxed/simple;
	bh=iIJ9VRV62J828IXH+cZGzWJDkR65fWoXDHscgCTYQdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ts/cM1wTUUFV89FDbkl+ox8f9XUyH7zfNAgu8T1ga4nioOgZmAICyDQtGO/UuhF7v/3+XkRMKqJTr9/HGJlkvrvH+iChWdRSsNwrQX75VQNu6P2XSYamOESF3184OebtCUF+oQZJT4vRXdOvlc2gjQwn9wDQzz2JNOLPZ7H3tmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZfR9y8o/; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZfR9y8o/"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2569aa5116so59239366b.0
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 14:43:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788385385; cv=none;
        d=google.com; s=arc-20260327;
        b=sjtj8Js+uJXtGnHQM72CASBcExObqe2j8AmVp6ThyWSTzvCZar+cEDowOhaPgDoV5J
         Ez65PaUxdTD+r0ho98q1/qogzGjOHPfvb6TsGR/6wLk4YnPY5Ah1GxkSCwXjiTmLZMX5
         lj4J+zJgIFbhGiyQaYU4ySaXJyvOuog2Dj8P8IXmHscSHwaS1SzD0Jbi7U0YUfqiNDce
         FY4NJNNx3Mcm5eGus1Ar8cAcbgbUybWGwoHAlUoSMagQ8dmlxr5T63q6C24nQimOF9pV
         1SguzIsS89PmDsNHsEkunq7I2rbxs4JDYr6Jrpm7QIDU56Btql4MLqnXXi2rdWQURACD
         OdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AVzqU+HWsj+X0U1337zklumQ6o5zEX9OVb8vnO7RrHs=;
        fh=5nLU2Pel50fcuBH7YDAG6FK0ZsTPX+cDCRSMGkc5Ylg=;
        b=lVij0KyRg2KYmAhkQte8TI4i42sA6DL6fDf8PTmSK7BpMBBSXRl9dw43u7yTm+IZm/
         GpzCHGnqzhcod5KPtdn+hgce8T9Opv86a8NMkOnmtwdHJnjsPykBUPZhyx7o9eJkMKMc
         OXwPTWWUjH3NUnXYwYzEvsEg6w05lsdQBmUgfq7rsxSFhF817c/KN0vqGZRHSo0PbBnH
         2u05ACw1XDJp9FOW+IRFcEWsxMbD/LIDCNijReXR2Zw8FddqyWNaiVeraHpWHFlhjbaw
         K4d+/l1EOqZMmp5aMsluVCc8YwGvqaGYgKK5V1zJTKQ96m4a7xm+662wBzWukkgb4C7Q
         hqqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788385385; x=1788990185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AVzqU+HWsj+X0U1337zklumQ6o5zEX9OVb8vnO7RrHs=;
        b=ZfR9y8o/I8pZRHU8EMHmG9tqe4vWbLuzIsSRcYoJ2/vx9dITSCMFQ/uLqej0h4+LNb
         8UBUe8hsHEmTD+EFrkNPXLc0FI1qbx0E4jZW1/Efp/1CiHT4ny6ld/y3vuHNHDbvexVx
         KUn7TvPUJWF0W5JTNlEAl64QGw+rHJQIlSyS/3IRaBljxMLNtuFnXI23yZT33VXGMq95
         SN0uxCAtdhRXhoEAK9fY22xhB6KvTHuHJ3VK0Ky6o854zqdyl9Us4ebjLia0bjN+pX09
         eoJOj7rgiLP7wLXTMVKfwwmWg+Kqs2bJNFdabVB9b6VI6f2IoAWqbVv3PMrDuDAQzOVA
         FWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788385385; x=1788990185;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVzqU+HWsj+X0U1337zklumQ6o5zEX9OVb8vnO7RrHs=;
        b=l5PuauQiPlyl1F1TO3jyKQiNFDJ34cJSzN3FMHMgGBKR4zqhUpF5/1xdb0F7Bg5lrG
         HooPBeOT/wxf2TTEd4+o0AZIqTNeHdpATxQsY/RhiiIaoYYONFyKCMDGL14IbGoEkY+/
         u4Kh9uoIj2Klc0waa9iuAut3RbOsnsUOw+Td3sYEB4a74fuOtW/vlqQxYGyaOi7LJXiJ
         xGvNjoxsdmBS/JOAepK2zGcskTyS3FDV7yfQzPx1nvA85d7cwHsdWW/Jyw7v8JUq9AtW
         MPq6E6BdY0hwrVwYlIasNA4Y28yxeBoHXCNVlR3swyU8Q6K8yu9XIRV5cNwdIrF6j3Ho
         9wgQ==
X-Forwarded-Encrypted: i=1; AKwUvBxXl9hpBDLheuM4synOW9Qpsya8NGwKTGXRAO39T3xAAsSgNYJTBZTSB6S7TPOvWmjBhn8=@vger.kernel.org
X-Gm-Message-State: AFuF++nffAlcFN54zNq8FzWFouXIgCftQdaUpHRxjHzvuyFeksSSXmB0
	DAlY6jy4IMJ+wqffy9gh3YJEMpiuuIj/cfbk5nHve3JaT7/WpC7u2kCH12G0/a1EZWvnoAJwPXm
	IAP2vPkcvmGlkMd4FrUYoXPUGVEFkrfPIXTLbPwcrmN9DxGsY7e0QvTBo
X-Gm-Gg: AYBFou1Ly7mFqqS37PGEOYO2KmOja1BDgfuw6BaFokwgjwgdUXKZnqWptOAREMofglS
	/hRQanN9gJQgjhzMhp/euEadOOIrgmW/DGGJzB+S5/08Bc0hxoDHnb6uH91BgU1y3aqCrsoKvaw
	LgdThpt2gauVHXflPQjKsoz8PGDz3JbYcVBoAzXiPbbXPoggRKiLqzu41SlMOaDXW0/d8VqkvUP
	EZvY9IW2qZ7CCRNsKQC2kUvdEcUN6dFo2+eXpkbDDzisOadvKaBnz6K0eE81OQF94Hx1lvlEAOc
	2eJw3PS9tCUE1G5bU6boqeDp7eke17ZAOKZBnbM4e/OWHtjFGS/n1LadEiCtDd16/DQMA5d0DKI
	wc6waE0jK/J4gb+zJc+jSoIxNut89fzgzqU71H9Y3mEFX5AqBfUsZFyhpjUvPhu1RtyH9fYRUhY
	PkN89k+dNO2WKP
X-Received: by 2002:a17:907:6ea0:b0:c24:d6f0:aa0 with SMTP id
 a640c23a62f3a-c25f009ff4cmr130511666b.11.1788385384963; Wed, 02 Sep 2026
 14:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902211759.2700289-1-seanjc@google.com>
In-Reply-To: <20260902211759.2700289-1-seanjc@google.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 2 Sep 2026 14:42:27 -0700
X-Gm-Features: AcwNN1VeO8TYciymngnBsSlPYiBdyLGjyWdU872Dzb37acgJe2Y965PvjiSGM8o
Message-ID: <CADrL8HULbB2HUSOJ0ivZnkz7V4Ok_jgDQk3hAc0tR6NKHp+6-g@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: Always guard rmaps with mmu_lock on
 PREEMPT_RT=y kernels
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 2:29=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> For all intents and purposes, revert KVM's ability to walk rmaps outside =
of
> mmu_lock when running on a realtime (PREEMPT_RT=3Dy) kernel.  I.e. don't =
use
> a non-sleepable bit-spinlock to protect rmap entries, as realtime kernels
> are highly unlikely to benefit from increased aging throughput and reduce=
d
> jitter for memory-overcommitted nested VMs, whereas using a non-sleepable
> lock is currently buggy and goes against the spirit of realtime kernels.
>
> Because KVM's rmap locks are hand-crafted bit-spinlocks, preemption must =
be
> disabled before acquiring the lock, otherwise a preempted lock holder wil=
l
> result in all other walkers of the locked rmap to spin and wait, with no
> tracked owner for PI to boost.  For non-RT kernels, acquiring mmu_lock
> suffices, as mmu_lock is a non-sleepable rwlock.  But on RT, where mmu_lo=
ck
> becomes sleepable, preemption is left enabled for rmap writers:
>
>   WARNING: arch/x86/kvm/mmu/mmu.c:920 at __kvm_rmap_lock+0x1a7/0x1e0 [kvm=
], CPU#16: vmx_apic_update/3708
>   CPU: 16 UID: 0 PID: 3708 Comm: vmx_apic_update Not tainted 7.2.0-rc7 #5=
2 PREEMPT_{RT,LAZY}
>   RIP: 0010:__kvm_rmap_lock+0x1a7/0x1e0 [kvm]
>   Call Trace:
>    pte_list_add+0x67/0x4d0 [kvm]
>    __link_shadow_page+0x249/0x480 [kvm]
>    ept_fetch+0x4d5/0x1220 [kvm]
>    ept_page_fault+0x60b/0x850 [kvm]
>    kvm_mmu_do_page_fault+0x252/0x690 [kvm]
>
> Alternatively, KVM could manually disable preemption when grabbing an rma=
p
> lock, but as above, that isn't what RT kernels generally want, and it's
> actually more complex to implement (cleanly).
>
> To not completely lose the scaling advantage of per-rmap locks, take
> mmu_lock for read in the aging path, i.e. allow multiple concurrent aging
> tasks, as the aging code needs to use atomic SPTE accesses no matter what=
,
> i.e. no extra code/work is required to guard against concurrent aging of
> SPTEs.
>
> Reported-by: David Woodhouse <dwmw2@infradead.org>
> Closes: https://lore.kernel.org/all/8d47b43e1829ac92703723e6a1a4afc7a2eaa=
cb5.camel@infradead.org
> Fixes: 4834eaded91e ("KVM: x86/mmu: Add infrastructure to allow walking r=
maps outside of mmu_lock")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Thanks, Sean. A small comment below. Feel free to add:

Reviewed-by: James Houghton <jthoughton@google.com>

> ---
>  arch/x86/kvm/mmu/mmu.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 064ecc33b926..5bf833550f84 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -895,6 +895,7 @@ static struct kvm_memory_slot *gfn_to_memslot_dirty_b=
itmap(struct kvm_vcpu *vcpu
>   */
>  #define KVM_RMAP_MANY  BIT(0)
>
> +#ifndef CONFIG_PREEMPT_RT
>  /*
>   * rmaps and PTE lists are mostly protected by mmu_lock (the shadow MMU =
always
>   * operates with mmu_lock held for write), but rmaps can be walked witho=
ut
> @@ -1008,7 +1009,8 @@ static unsigned long kvm_rmap_get(struct kvm_rmap_h=
ead *rmap_head)
>   * actual locking is the same, but the caller is disallowed from modifyi=
ng the
>   * rmap, and so the unlock flow is a nop if the rmap is/was empty.
>   */
> -static unsigned long kvm_rmap_lock_readonly(struct kvm_rmap_head *rmap_h=
ead)
> +static unsigned long kvm_rmap_lock_readonly(struct kvm *kvm,
> +                                           struct kvm_rmap_head *rmap_he=
ad)
>  {
>         unsigned long rmap_val;
>
> @@ -1032,6 +1034,35 @@ static void kvm_rmap_unlock_readonly(struct kvm_rm=
ap_head *rmap_head,
>         __kvm_rmap_unlock(rmap_head, old_val);
>         preempt_enable();
>  }
> +#else
> +static unsigned long kvm_rmap_get(struct kvm_rmap_head *rmap_head)
> +{
> +       return atomic_long_read(&rmap_head->val);
> +}
> +static unsigned long kvm_rmap_lock(struct kvm *kvm,
> +                                  struct kvm_rmap_head *rmap_head)
> +{
> +       lockdep_assert_held_write(&kvm->mmu_lock);
> +       return kvm_rmap_get(rmap_head);
> +}
> +
> +static void kvm_rmap_unlock(struct kvm *kvm,
> +                           struct kvm_rmap_head *rmap_head,
> +                           unsigned long new_val)
> +{
> +       atomic_long_set_release(&rmap_head->val, new_val);
> +}
> +
> +static unsigned long kvm_rmap_lock_readonly(struct kvm *kvm,
> +                                           struct kvm_rmap_head *rmap_he=
ad)
> +{
> +       lockdep_assert_held_read(&kvm->mmu_lock);
> +       return kvm_rmap_get(rmap_head);
> +}
> +
> +static void kvm_rmap_unlock_readonly(struct kvm_rmap_head *rmap_head,
> +                                    unsigned long old_val) { }
> +#endif
>
>  /*
>   * Returns the number of pointers in the rmap chain, not counting the ne=
w one.
> @@ -1745,11 +1776,15 @@ static bool kvm_rmap_age_gfn_range(struct kvm *kv=
m,
>         gfn_t gfn;
>         int level;
>
> +#ifdef CONFIG_PREEMPT_RT
> +       guard(read_lock)(&kvm->mmu_lock);
> +#endif

Future me would be happier if there were a comment here. :)

Also, how about BUILD_BUG_ON(!CONFIG_KVM_MMU_LOCKLESS_AGING)?

> +
>         for (level =3D PG_LEVEL_4K; level <=3D KVM_MAX_HUGEPAGE_LEVEL; le=
vel++) {
>                 for (gfn =3D range->start; gfn < range->end;
>                      gfn +=3D KVM_PAGES_PER_HPAGE(level)) {
>                         rmap_head =3D gfn_to_rmap(gfn, level, range->slot=
);
> -                       rmap_val =3D kvm_rmap_lock_readonly(rmap_head);
> +                       rmap_val =3D kvm_rmap_lock_readonly(kvm, rmap_hea=
d);
>
>                         for_each_rmap_spte_lockless(rmap_val, &iter, spte=
p, old_spte) {
>                                 if (!is_accessed_spte(old_spte))
>
> base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
> --
> 2.55.0.970.g62bdec98f9-goog
>
>
