Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140042;
	b=1tKuvp/XK3CgNiL6WsUcSnYwciCyIH0QbFSayhSQCjhSg3Tpcm4OStxkrJqx8/kWCYSS
	 58Y8Xl6YLO/IL/GckJL1+ah0R8M/zPKURjbMlJFzCRt5s04ZFpQZwAeF5YLEkhb2PKaYv
	 hLYhp+9C2cVayNSpjKe30jAK5qMYQUGqqfz8gbR3rIUP9BxaxOjXSjML02LgyLBl94NAz
	 jpIzfjPdgyuSFf5wwvE5ymp5ZMCY9y6D6Qm/SwiDbRZPFmSpC8TMWal68r5gQx/14YTOS
	 SRBqfO39U2kyEsgR1o3XWHhMr54rPYWByCD+zuCp0ZvW3l6u7rpts8lFY0Vs2czMVmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140042;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j2kkTwVdoNDYdukCLdwYv5WjwZpCQ2FkHyy+v8NzJj8=;
	b=jHJqDIvUtLZqRhm4wShCRtHEs+PqxUDqrR8ikS2zQNvs3ucS95cMlLWc43IwdUQ1YwpL
	 9THknw5P4z5j9AC0Vrd6I8C4zRW2mWcnKEs8cbECK/OSVTx0QzLslR/ropgqSMq7UGDBk
	 ZHP86+IEk9pMmt8lxXGyD8LalZzEX0YJNGBLHvyh8rrPAxr6Q8IQo61mP2ZPjh1Zn6ZfS
	 dQiGow+PsCnB1JgAmBP2luK6xZGUYl3OGGwf5vh+1aRDKwrCbaiwUn4vFdznO9omV7Sj3
	 Ow+A467arJXIxic0n6KONLf22gu5NM/tusYuGn9zZE0/Tl+qhLyGSXtfG27X3sc/dcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VR0eVFKq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C97606A31A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VR0eVFKq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECA61F01825;
	Tue, 27 Oct 2026 22:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793140041;
	bh=j2kkTwVdoNDYdukCLdwYv5WjwZpCQ2FkHyy+v8NzJj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VR0eVFKqhQN8Uut+7XOw6PIf9z3+QKz9tFiO+GtDlZGyai0lf833Ndy7SfM/kooQM
	 QJGakoR51tT+br+Hcv0LhTYWPD80gMWV4uU1woHJjeDXljWdL8oazWoSX0ULXNdJf/
	 68Xlrc/tHq87O7VZhYieBUBw6xMWlKKvBtgEucUysBjGo73A+u+6E9oRCcPDdv0wDl
	 aBtpZFfZTl8IqbduVWGjz3WmUnCuh/o+b54vxOQfcrceiokM6Y329FqDNDA3eCLy+Q
	 uG4if9RJsRR6J49N5VVnh5sSUqlysW1JUmcs5sNlkcTkZlWCJtX3oxe9m8qYRt9Ker
	 MsALnfF7yAYFw==
Message-ID: <sashiko-outbox-187159@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/15] KVM: x86: Unmap VMAs for KVM-internal memslots
 when the memslot is freed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261027221209.1560865-5-seanjc@google.com>
References: <20261027221209.1560865-1-seanjc@google.com>
 <20261027221209.1560865-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 22:27:21 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM: x86: premature VMA unmap in kvm_arch_free_memslot() while SMM=
 slot is active
--

commit 6659f140d07225e838a8f211264ec11bfb5e9df2
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Unmap VMAs for KVM-internal memslots when the memslot is freed

This commit moves the VMA unmapping for x86 KVM-internal memslots from
__x86_set_memory_region() into kvm_arch_free_memslot(), and removes the
explicit internal memslot teardown from kvm_arch_destroy_vm().

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 32563a91fba99..0f3fa45713097 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -10058,8 +10058,7 @@ void __user * __x86_set_memory_region(struct kvm =
*kvm, int id, gpa_t gpa,
>  		if (!slot || !slot->npages)
>  			return NULL;
> =20
> -		old_npages =3D slot->npages;
> -		hva =3D slot->userspace_addr;
> +		hva =3D 0;
>  	}
> =20
>  	for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
> @@ -10075,9 +10074,6 @@ void __user * __x86_set_memory_region(struct kvm =
*kvm, int id, gpa_t gpa,
>  			return ERR_PTR_USR(r);
>  	}
> =20
> -	if (!size)
> -		vm_munmap(hva, old_npages * PAGE_SIZE);
> -
>  	return (void __user *)hva;
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(__x86_set_memory_region);

[ ... ]

> @@ -10159,6 +10141,18 @@ void kvm_arch_free_memslot(struct kvm *kvm, stru=
ct kvm_memory_slot *slot)
>  	}
> =20
>  	kvm_page_track_free_memslot(slot);
> +
> +	/*
> +	 * Unmap VMAs allocated on behalf of userspace for internal memslots,
> +	 * unless the memory map has changed due to process exit or fd copying.
> +	 * Do the unmap only for the non-SMM slot, as the same VMA is used for
> +	 * both non-SMM and SMM memslots.  Leak the mapping on failure, e.g.
> +	 * if the task is killed.  Worst case scenario, the page(s) will be
> +	 * reclaimed when the process exits.
> +	 */
> +	if (current->mm =3D=3D kvm->mm && slot->id >=3D KVM_USER_MEM_SLOTS &&
> +	    !slot->as_id && !WARN_ON_ONCE(!slot->npages))
> +		vm_munmap(slot->userspace_addr, slot->npages * PAGE_SIZE);

[Severity: High]
Does unmapping the shared VMA in arch/x86/kvm/x86.c:kvm_arch_free_memslot()
when !slot->as_id cause a premature unmap while the SMM memslot (as_id =3D=
=3D 1)
is still active?

When an internal memslot is deleted at runtime while vCPUs are running, such
as via arch/x86/kvm/lapic.c:kvm_inhibit_apic_access_page():

	if (kvm->arch.apic_access_memslot_enabled) {
		__x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT, 0, 0);

__x86_set_memory_region() iterates over the address spaces from i =3D 0 to
kvm_arch_nr_memslot_as_ids(kvm) - 1:

	for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
		struct kvm_userspace_memory_region2 m;

		m.slot =3D id | (i << 16);
		m.flags =3D 0;
		m.guest_phys_addr =3D gpa;
		m.userspace_addr =3D hva;
		m.memory_size =3D size;
		r =3D kvm_set_internal_memslot(kvm, &m);
		if (r < 0)
			return ERR_PTR_USR(r);
	}

Previously, vm_munmap() was called only after this loop finished deleting t=
he
memslot from all address spaces.

With this change, on iteration i =3D 0 (as_id =3D=3D 0), the call chain:

  kvm_set_internal_memslot()
    -> kvm_set_memory_region()
      -> kvm_set_memslot(..., KVM_MR_DELETE)
        -> kvm_commit_memory_region()
          -> kvm_free_memslot()
            -> kvm_arch_free_memslot()

sees !slot->as_id and immediately calls vm_munmap(slot->userspace_addr, ...=
),
releasing mmap_write_lock before iteration i =3D 1 begins.

Until iteration i =3D 1 calls kvm_invalidate_memslot() on the SMM slot, the
memslot in kvm->memslots[1] remains active and valid while pointing to the
already-unmapped userspace_addr. If a vCPU in SMM accesses or faults on that
GPA during this window, couldn't it resolve the active SMM memslot to an
unmapped HVA (failing KVM_RUN with -EFAULT) or to an unrelated VMA if anoth=
er
host thread concurrently calls mmap()?

In addition, if iteration i =3D 1 fails in virt/kvm/kvm_main.c:kvm_set_mems=
lot()
when allocating invalid_slot:

	if (change =3D=3D KVM_MR_DELETE || change =3D=3D KVM_MR_MOVE) {
		invalid_slot =3D kzalloc_obj(*invalid_slot, GFP_KERNEL_ACCOUNT);
		if (!invalid_slot) {
			mutex_unlock(&kvm->slots_arch_lock);
			return -ENOMEM;
		}
		kvm_invalidate_memslot(kvm, old, invalid_slot);
	}

__x86_set_memory_region() aborts after as_id =3D=3D 0 has already been dele=
ted and
unmapped. Because __x86_set_memory_region() checks id_to_memslot(slots, id)=
 in
as_id =3D=3D 0 on entry and returns NULL if !slot, wouldn't the SMM memslot=
 in
kvm->memslots[1] be left permanently active with a dangling userspace_addr?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027221209.1560=
865-1-seanjc@google.com?part=3D4
