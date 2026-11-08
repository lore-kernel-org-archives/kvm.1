Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098646;
	b=zeFJy+YLtnzlXdSMrdemswpu6mBsyLUIqVzBYplw8cL1BuvTwmxND+JBhMn5J9YWikYQ
	 lvmEecGk09qmhNu8zJts9W/ovxzCdd4m2yMHoCMfYn9EE2Z2INjSH8g9qXINPDjLsikbo
	 Ha+bAOsmC8SZueIyKqTaakcBMxI8kccIT5kcC9h4fFhxfDQhQxOm1Z84jbrugUCHMvTLI
	 I0rdaKcIf0n6siZzIyvX8TRNZrNRvKX5cyDzyIJ67WuP0y+FthUD/sfwWQ4PDmWrExJxx
	 E7RHyVgR9erH2ZuwxZm9eIamtXqddnax8yXW8Y51dHhxbIjGJq+q1vvz/04xkPrcIAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098646;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MFHfJQl0vpDM2vBiOx1CxENcy6DvM3TwkDhq4VbpIww=;
	b=lD8ZJ0v9MqP3GKAP4xFk5WZgz+GmWTkP2Djt+ErTANYo69XbVfdbYllkdU5xlPjgjWGG
	 PZD9o/B7zL0ItvUuqLBtfZOOZlGsklA4sMK4Vd40GTbmrbVzmHk5IFUJhL6oX+kpfTYXy
	 7/103OJ2QpY6QROzX/Jm/JuA5QGn7GvsE8RR0R9atoTem7wy5eymMqxqOsqmYJ7cxRxHd
	 goDFdteCJ2RrZVqULEhAwK9um3vcXXSHTIA3Q2FUIW13atOLRikmYEInVf+BqlNcBjn50
	 6GZrhDDbB6ehKtO6cQAZyfiUjCR48mK3DWGJHH91N8HyMRHoTP60fX0i83KG8Ndeyig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQtMIkiz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B80606D80A
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQtMIkiz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300591F0089F;
	Sun,  8 Nov 2026 00:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098646;
	bh=MFHfJQl0vpDM2vBiOx1CxENcy6DvM3TwkDhq4VbpIww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TQtMIkiz1l1ncpO78lu7whfbRkUdp3ZpsvNwKa2upIvhOgt6ntgwUba/BlEEjfw6P
	 18+H6rp1elydTDn7rNhgvNgN6FiRTNOE7pyzmgra3kOaS0jtYaxDuFpq6veC0b70vD
	 UTsQlooeQwMI2HExThlaS+8M8WMkaHWbBT7sXn/K0YXrhLKA+y5sJCuRnjgdgYx226
	 nSQCcqIPlZfnQ7A1OU1NSF3oVKCCSV8zm1JfGXB1lL5G7LWzThlKB8ib7h5NvBCUUs
	 pL2dfJXmZNmnBu68h5QbDq8rrJU2UkZpTkVpz7fe2/omVS0VU8R6yP2akxwQ/h+01I
	 4CUhpCD6z9FCA==
Message-ID: <sashiko-outbox-203443@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 32/88] KVM: guest_memfd: Support user fault
 handling in PFN mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>, "Alexey Kardashevskiy" <aik@amd.com>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Fred
 Griffoul" <fgriffo@amazon.co.uk>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jianxiong
 Gao" <jxgao@google.com>, "John Starks" <John.Starks@microsoft.com>, "Michael
 Roth" <michael.roth@amd.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Sean Christopherson" <seanjc@google.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Vishal
 Annapurve" <vannapurve@google.com>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Fuad
 Tabba" <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261106-gmem-alternative-providers-v3-32-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-32-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:04 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] KVM: guest_memfd: false SIGBUS in kvm_gmem_pfn_mkwrite()
  after mprotect()
--

commit f3ec1839826136ca55a20572dfcf8ef47f4e0d64
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Support user fault handling in PFN mode

This commit adds user fault handling support for guest_memfd in PFN mode,
inserting PFNs with protections constrained by the provider's PFN
attributes and introducing kvm_gmem_pfn_vm_ops with a .pfn_mkwrite
callback.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 183e15775523f..e94f2359b7c9a 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -565,11 +565,40 @@ static bool kvm_gmem_supports_mmap(struct inode *in=
ode)
>  	return GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_MMAP;
>  }
> =20
> +/*
> + * In PFN mode, physical frame attributes are constant for the lifetime =
of the
> + * mapping. If a page was inserted read-only, it was because the provider
> + * reported a read-only PFN attribute, and write upgrades are never perm=
itted.
> + * Write faults on such pages must fail with SIGBUS.
> + */
> +static vm_fault_t kvm_gmem_pfn_mkwrite(struct vm_fault *vmf)
> +{
> +	return VM_FAULT_SIGBUS;
> +}
> +
> +static vm_fault_t gmem_insert_pfn(struct vm_fault *vmf, kvm_pfn_t pfn,
> +				 u64 pfn_attrs)
> +{
> +	struct vm_area_struct *vma =3D vmf->vma;
> +	vm_flags_t flags =3D vma->vm_flags;
> +
> +	if (pfn_attrs & GUEST_MEMFD_PFN_ATTRS_READONLY)
> +		flags &=3D ~VM_WRITE;
> +
> +	if ((vmf->flags & FAULT_FLAG_WRITE) && !(flags & VM_WRITE))
> +		return VM_FAULT_SIGBUS;
> +
> +	return vmf_insert_pfn_prot(vma, vmf->address, pfn,
> +				   vm_get_page_prot(flags));
> +}

[Severity: Medium]
Can kvm_gmem_pfn_mkwrite() deliver a spurious SIGBUS when userspace writes
to a writable PFN after mprotect(PROT_READ | PROT_WRITE)?

If userspace maps a guest_memfd with PROT_READ and MAP_SHARED and faults
in a writable PFN via a read access, gmem_insert_pfn() installs a clean,
read-only PTE because vma->vm_flags lacks VM_WRITE.  Because
kvm_gmem_pfn_vm_ops sets .pfn_mkwrite, vma_wants_writenotify() is true for
the VMA and vma_set_page_prot() keeps vma->vm_page_prot read-only;
a subsequent mprotect(..., PROT_READ | PROT_WRITE) therefore leaves the
clean PTE read-only (can_change_shared_pte_writable() checks
pte_dirty(pte)) so that the next write traps into .pfn_mkwrite, where
kvm_gmem_pfn_mkwrite() unconditionally returns VM_FAULT_SIGBUS.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D32
