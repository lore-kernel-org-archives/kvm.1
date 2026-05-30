Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637E3932CD
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780131433; cv=none; b=gDgNWl+VEe9YD/HP+d8VcsL7QADFFFqXJ7iccoaIPrqJJavRku8rIsNk9rK/8beAgaGuIfMAuJLjSHMoVXu+jyg76aBvkzZysrWfNpH2b8Pq2HO6g5wc8FK+FEIWou5wOuQaYIXBohLFQaAHu14SPBwoHhXWU41whdeUxr00wxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780131433; c=relaxed/simple;
	bh=tkdJsdM/etynhcmwy2gWuWkjg5LRKMaoYK6Yckd5/9Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QCGGD+7v8vUhBHlvaEcEQakFcCATnH/Vh4+6eVLsNLi0/Re+04YdZyay8w/dQEjv8v87JOGYIte4GNvq7Xa334UXQZHw+cdFRxEHJYPqNbo2GAdOTepiTkuzsfNW+5DbpRNDTaiJeUBlykrkF8AMKDKSkANQ0BpqCMh1E1dkzbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wh4CLJ7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wh4CLJ7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26C01F00893;
	Sat, 30 May 2026 08:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780131432;
	bh=6ssKnt+FTXSruqZ/9Qe2Oyw6fVpF9pgfWO/ZfO8OVLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wh4CLJ7nNf5le96VbCWD6sOoFGoNpyK3kzidTeFW1qCI6UExDn48rIHlFPIf2kqR0
	 RU8QqClh+7b/IIS/cYgDWq5yePaNXecFz5lfV+9K8b7lPt6KZwhgTcUO6HpPr9gsSA
	 GdpM/C+Ti5wGa/VLaWEeBL4BF2numPQiqxeppXVU2MsjYtu2QsxfScarEkvON3QxBS
	 v6bFHHy4RFxqQQ1uWlyqcGCr9zcBJMyeIWCTd3fyL56Y50BiwrhhCR5DEFe7BZCdke
	 XUj52Wqe4Gi9uA9oFyCdrXXTIhd/4kSdwsEQ1CbpJUDsD/EFrYB7SIWQhp5CvmlbW0
	 JMmTaMjgRMGMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 24/27] KVM: s390: arm64: Implement vm/vcpu create
 destroy.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-25-seiden@linux.ibm.com>
References: <20260529155050.2902245-25-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 08:57:11 +0000
Message-Id: <20260530085711.D26C01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] In `kvm_arch_init_vm`, `kvm->arch.mem_limit` is improperly set to =
the inclusive hardware limit (`kvm_max_guest_address()`) instead of the VM'=
s requested IPA size (`kvm->arch.guest_phys_size`). This causes `gmap_prepa=
re_memory_region` to incorrectly reject perfectly sized memslots (because i=
t compares an exclusive memslot size against an inclusive limit) and allows=
 userspace to map memslots far beyond the VM's requested address space. The=
se out-of-bounds memslots are then silently ignored during the commit phase=
 by `_dat_walk_gfn_range` (due to `DAT_WALK_IGN_HOLES`), creating a fatal d=
esynchronization between KVM's memslots and the hardware DAT tables.
- [High] `gmap_commit_memory_region` performs a fallible memory allocation =
(`kvm_s390_new_mmu_cache()`) during the KVM memslot commit phase, which is =
architecturally required to be non-failable (it returns `void`). If this al=
location fails, the function aborts and silently skips updating the gmap DA=
T tables.

Pre-existing issues:
- [High] `gmap_get_dirty_log()` uses a non-atomic `memset()` to clear the m=
emory slot's `dirty_bitmap` after copying it to userspace via `kvm_get_dirt=
y_log()`. This introduces a severe race condition against concurrent caller=
s of `mark_page_dirty()` (e.g., from interrupt injection in `s390/kvm/s390/=
interrupt.c` or nested virtualization), which use atomic bit operations (`s=
et_bit_le`).
--

commit 001e0a58ea811dbd19411f46d5babaaf3bbbbc47
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement vm/vcpu create destroy.

Implement init and destroy IOCTLS for vcpu and vm.
Implement arch vm IOCTL. Use s390 gmap.

> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> index 591e2e874891a..79ce6570fa031 100644
> --- a/arch/s390/kvm/arm64/arm.c
> +++ b/arch/s390/kvm/arm64/arm.c
> @@ -45,6 +48,61 @@ static u64 kvm_max_guest_address(void)
>  	return ALIGN_DOWN(max_addr + 1, 1 << 30) - 1;
>  }

[ ... ]

> +int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
> +{

[ ... ]

> +	ret =3D kvm_gmap_init(kvm);
> +	if (ret)
> +		goto out_err;
> +	kvm->arch.mem_limit =3D kvm_max_guest_address();

[Severity: High]
Does setting kvm->arch.mem_limit to the inclusive hardware limit
kvm_max_guest_address() instead of kvm->arch.guest_phys_size cause
memslot validation issues?

When gmap_prepare_memory_region() validates the memory slots:

arch/s390/kvm/gmap/mmu.c:gmap_prepare_memory_region() {
        ...
        if ((new->base_gfn + new->npages) * PAGE_SIZE > kvm->arch.mem_limit)
                return -EINVAL;
        ...
}

It compares an exclusive size against this inclusive limit. Could this
incorrectly reject perfectly sized memslots?

Additionally, since it uses the maximum host physical capacity instead of
the VM's requested IPA size, could it allow userspace to map memslots beyond
the VM's address space, resulting in a desynchronization between KVM and
the hardware DAT tables?

[ ... ]

> @@ -107,6 +201,52 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kv=
m_irq_level *irq_level,
>  	return 0;
>  }
> =20
> +int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
> +			       struct kvm_dirty_log *log)
> +{
> +	return gmap_get_dirty_log(kvm, log);
> +}

[Severity: High]
This is a pre-existing issue, but is it safe to use gmap_get_dirty_log()
here given how it clears the dirty bitmap?

In the underlying implementation:

arch/s390/kvm/gmap/mmu.c:gmap_get_dirty_log() {
        ...
        if (is_dirty) {
                n =3D kvm_dirty_bitmap_bytes(memslot);
                memset(memslot->dirty_bitmap, 0, n);
        }
        ...
}

The memset() is non-atomic. Could this permanently clobber concurrently set
dirty bits from mark_page_dirty(), which uses atomic bit operations? Any
dirty bits set concurrently during or immediately before the memset could
be lost.

[ ... ]

> +void kvm_arch_commit_memory_region(struct kvm *kvm,
> +				   struct kvm_memory_slot *old,
> +				   const struct kvm_memory_slot *new,
> +				   enum kvm_mr_change change)
> +{
> +	gmap_commit_memory_region(kvm, old, new, change);
> +}

[Severity: High]
Is it safe to rely on a fallible allocation inside the void
kvm_arch_commit_memory_region() phase?

Calling gmap_commit_memory_region() here triggers a memory allocation:

arch/s390/kvm/gmap/mmu.c:gmap_commit_memory_region() {
        ...
        mc =3D kvm_s390_new_mmu_cache();
        if (!mc) {
                rc =3D -ENOMEM;
                goto out;
        }
        ...
}

Since the commit phase returns void and cannot fail to userspace, if this
allocation fails under memory pressure, it will silently skip updating
the gmap DAT tables. Could this cause KVM's generic memslots to become
permanently desynchronized from the hardware gmap state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D24
