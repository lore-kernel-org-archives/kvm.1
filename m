Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098636;
	b=oB/gySrlVmdm1KHeK9i0SZSpm7r5BIe3190CWGObeadl3FtFtP++9bVDV+0VNYmbK/ZM
	 lamx+enjKjbWanrxPT07jiGKSsskzsFFk7aKF1b9J+4LjezUT6A26/ZNz2/xgtcLZBASq
	 Qo0sv4UXCuuUM723v7qcW27EJfsqGUrbQyO5emYruLSYYWQFmp4Kx7u2I2uChFW56RyxT
	 vIEr8V5s5yBZG5yKN9K0J8gGh5KjffAi8O/b37jF8HJBmhgVqGKB2cVhhvYp1A4f0Iy8R
	 lR20+GGn92sIxOz9g3TaCSttD2mCpJgTwdE3cvGNxNEJdSCDhX+oLROfMN/ecJfJlaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098636;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zDhvwxe5afuvG0cscGKypAl/DKIeZ21ysxl5HSrSzUY=;
	b=kijYxPmqquIzdZelu8ZJX75NPY8nseA8ZYgkFfGLXoVvJGjEKxRk1rrico7SzBVKk3ak
	 NL4FbYCBYWv0oGOhPXPNW2yhX0dKIfgF7uIDx0byBbGjFrx72shWQvww2VmvrC7dR3JAe
	 D5wQxabSjSDUbX0dptxnPHsfFTQf3aBqBIVUF/Z9aC+xrqFHIzMFUrIk6QqBrwjBqroBE
	 VMbxCZpGNSVPgC60X0AnsydvZYHn4r8U9hRJ0VYtHVCWcAK65gjxne9iNyJ90+CEpbCRg
	 A7cZylk5S+0hCAK3e8QOHyXMn/fGKIUToEbmnq9JK779YFGffZ9GbGAjKl309GMNSVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N834jSyC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9FA606A33E
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N834jSyC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4DD1F008AB;
	Sun,  8 Nov 2026 00:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098636;
	bh=zDhvwxe5afuvG0cscGKypAl/DKIeZ21ysxl5HSrSzUY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N834jSyCk3yngtaInhSTG+aG4iD4w6O0KHMtgVlTqOx+RT2zRJM8Ge0bNuC95lKES
	 F35F562EXYbYpH7wQgxqU3jb74BiX+6r51/mViDYvvuUoSD4ctLMG3fr4chrVBCwdU
	 Ul+Albq0niCn0RkrWoHKs1b3kmnKJCe0kN4hDSWOc2tgwYINsivugwy0TCHQHzUdhz
	 0KvHhE5HNtPLKdnFhvJpx+UUWBhVdVU89CdxSctY/Q6M4ZdMnoPtJ4JXznUxBuZB8w
	 iweT4tqzXWVWbQupowJAW9xgej6aBWiVbQwhPcxY3zZTXEXQZtBNac+fVEQkxwjTKw
	 td0sCqy7VTvqA==
Message-ID: <sashiko-outbox-203417@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 06/88] KVM: selftests: Add helper to create
 guest_memfd with a resource file
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-6-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-6-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:43:54 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] KVM: guest_memfd: missing release_folio() with
  mapping_set_release_always()
- [Medium] mm: shmem: unmovable guest_memfd folios allocated with
  GFP_HIGHUSER_MOVABLE
--

commit a3e5841f5c68c0e42d4540b30c82c6fced7d8d4f
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Add helper to create guest_memfd with a resource file

This commit syncs the KVM UAPI header for GUEST_MEMFD_FLAG_USE_RESOURCE and
adds selftest helpers to create a guest_memfd instance backed by a resource
file descriptor.

> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testi=
ng/selftests/kvm/include/kvm_util.h
> index e2618877619e1..eca296539db79 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -809,26 +809,39 @@ static inline bool is_smt_on(void)
> =20
>  void vm_create_irqchip(struct kvm_vm *vm);
> =20
> -static inline int __vm_create_guest_memfd(struct kvm_vm *vm, u64 size,
> -					  u64 flags)
> +static inline int __vm_create_guest_memfd_resource(struct kvm_vm *vm, u6=
4 size,
> +						   u64 flags, int resource_fd)
>  {
>  	struct kvm_create_guest_memfd guest_memfd =3D {
>  		.size =3D size,
>  		.flags =3D flags,
> +		.resource_fd =3D resource_fd,
>  	};
> =20
>  	return __vm_ioctl(vm, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
>  }

[Severity: High]
In the underlying kernel support for provider folio invalidation added
earlier in this series in commit "KVM: guest_memfd: Support provider folio
invalidation", kvm_gmem_init_inode() calls
mapping_set_release_always(inode->i_mapping), but kvm_gmem_aops does not
implement .release_folio.  Can this cause mapping_evict_folio() to warn and
evict guest_memfd folios without invalidating KVM MMU mappings or provider
accounting?

Because AS_RELEASE_ALWAYS is set, folio_needs_release() is true in
filemap_release_folio(), which falls back to try_to_free_buffers() when
a_ops->release_folio is NULL:

fs/buffer.c:try_to_free_buffers() {
	/* Misconfigured folio check */
	if (WARN_ON_ONCE(!folio_buffers(folio)))
		return true;

When soft_offline_in_use_page() calls mapping_evict_folio() on a clean,
unmapped guest_memfd folio, filemap_release_folio() triggers that warning
and returns true.  mapping_evict_folio() then removes the folio from the
page cache without calling kvm_gmem_invalidate_folio() or notifying the
KVM MMU, leaving stage-2 page tables pointing to the freed page and leaking
tmpfs provider block accounting.

> -static inline int vm_create_guest_memfd(struct kvm_vm *vm, u64 size,
> -					u64 flags)
> +static inline int __vm_create_guest_memfd(struct kvm_vm *vm, u64 size,
> +					  u64 flags)
> +{
> +	return __vm_create_guest_memfd_resource(vm, size, flags, 0);
> +}
> +
> +static inline int vm_create_guest_memfd_resource(struct kvm_vm *vm, u64 =
size,
> +						 u64 flags, int resource_fd)
>  {
> -	int fd =3D __vm_create_guest_memfd(vm, size, flags);
> +	int fd =3D __vm_create_guest_memfd_resource(vm, size, flags, resource_f=
d);
> =20
>  	TEST_ASSERT(fd >=3D 0, KVM_IOCTL_ERROR(KVM_CREATE_GUEST_MEMFD, fd));
>  	return fd;
>  }

[Severity: Medium]
When a guest_memfd is created with a tmpfs resource_fd (via commit "mm:
shmem: Implement guest_memfd provider operations for tmpfs" earlier in this
series), does shmem_gmem_alloc_folio() place unmovable folios into
ZONE_MOVABLE or MIGRATE_CMA?

kvm_gmem_init_inode() sets GFP_HIGHUSER (without __GFP_MOVABLE) and marks
the mapping AS_INACCESSIBLE because guest_memfd folios cannot be migrated.
However, shmem_gmem_alloc_folio() allocates with GFP_HIGHUSER_MOVABLE:

mm/shmem.c:shmem_gmem_alloc_folio() {
	...
	if (mpol)
		folio =3D folio_alloc_mpol(GFP_HIGHUSER_MOVABLE, 0, mpol, index,
					 numa_node_id());
	else
		folio =3D folio_alloc(GFP_HIGHUSER_MOVABLE, 0);

Once kvm_gmem_get_folio() inserts the folio into the AS_INACCESSIBLE
guest_memfd mapping, migration is rejected, pinning the page in
ZONE_MOVABLE or CMA and breaking CMA allocations or memory hot-unplug.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D6
