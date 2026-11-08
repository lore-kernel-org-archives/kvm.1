Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098633;
	b=ocZiR22RQliuMKywjfZDvspywrUudmT28LThkj69QBNIs1HnJ9sw6CC4+6KCR0Ig8Lh8
	 gN0Vk7k9kHQZhYz3DzXm8hk4MJ2KMgNCGE1bOmPFQl+97Y0SaCKCx5QlR6DmyxJExwK6r
	 vKPtdXVCoxbpVh3ofSlCihV0IEV8VQvGJW5kxAepxeAMrvF7ARYSONfgcfbLeDDLCrPUT
	 xMZcZa9K82bWuICCHpQ0wpHuT/G7kIaXDUzez+1dmbCq9SpBEAX+nHcLMO1cJUlU8TVfc
	 NceZKnwT/MATDOvc6GvkeCius3uK/6bliXdiG9fM8+V4FECrs7nGa7qe0+XDpgU/SKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098633;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CqmiBlIkVv2SuMbRjvFgJNQIb4gZ0ITbB/CfU8y6+Z0=;
	b=1+yYObgrexPXgDI1ycrfNHro5mG1qp8PxyVPrh9XwzysWSmNHFaR2YzgMXocnOgxgSLz
	 qp+TpaS6N3qAcoJ/n+pgfqJJBdRUPwobzlojq/WCLwPLk0d9hme3zoHM74PvapiwfmJ0F
	 vr8Hxf2fQUxtqR6/b1NTrS2PaWHtjlLplDXDNfqwe5WKVZUf7y+QTjYYxHVd3uTNxhhqB
	 dISz4+T5lV2udptPyuyWoIEjdPWHi3XMPF9L9hvwqZYnbB7jDWMHTgGUX9v21BR3m6sCK
	 6BTsb4IiYgD6edyDtnbL6+OlZZ3gcACtuV/1agcIYvcdllxq53pmxaQMuXwXXE0485w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNpmm0k4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35892606A333
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNpmm0k4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A181F008A5;
	Sun,  8 Nov 2026 00:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098633;
	bh=CqmiBlIkVv2SuMbRjvFgJNQIb4gZ0ITbB/CfU8y6+Z0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cNpmm0k4uTjSQOK0Pfe7mwdnEJlmaNrsFZXsO0nFarGW+FzcZR9xEZfBM7FXL7i7p
	 bH26q8JfzF2ED0iiKR7z594P7IVtIy9N3/Qom7yWatbl/olaGUqsPIpDRijSV3zbJx
	 Yu+SK9SqTIqiH95a9hkavxN99XfGAETSJpJidvaLXvOjj23kC/ojjR3cXItFl4W0PH
	 YpTDjFFTaM1E9m+G4YucZxBOObf6ZClCsmM+lB8GjilkbB2CRWtT1S3z+k6EDB3Uj9
	 8IzIoLdz5RlWBXEGJ0NeMKdVl6Uknn9YXgrcYhZYL1MDnDpug2e0Fu+kYso8xGD4yr
	 8fYMfpjRk05XQ==
Message-ID: <sashiko-outbox-203415@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 04/88] KVM: guest_memfd: Support provider folio
 invalidation
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-4-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-4-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:43:51 +0000
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
- [High] KVM: guest_memfd: AS_RELEASE_ALWAYS set without release_folio()
  in kvm_gmem_aops
--

commit 2a00824af3a696cc40b4c36a78f74b7c53a20eb3
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Support provider folio invalidation

This commit adds a provider .invalidate_folio() callback to guest_memfd
and sets mapping_set_release_always() on the guest_memfd address_space so
truncate paths invoke kvm_gmem_invalidate_folio().

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 545c3e646e9c1..ee823f2ef0368 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c

[ ... ]

> @@ -942,10 +950,24 @@ static void kvm_gmem_free_folio(struct folio *folio)
>  }
>  #endif
> =20
> +static void kvm_gmem_invalidate_folio(struct folio *folio, size_t offset,
> +				      size_t len)
> +{
> +	struct inode *inode =3D folio->mapping->host;
> +	struct gmem_inode *gi =3D GMEM_I(inode);
> +
> +	/* guest_memfd only allows truncating full folios. */
> +	if (WARN_ON_ONCE(offset !=3D 0 || len !=3D folio_size(folio)))
> +		return;
> +
> +	gmem_provider_invalidate_folio(gi, folio);
> +}
> +
>  static const struct address_space_operations kvm_gmem_aops =3D {
>  	.dirty_folio =3D noop_dirty_folio,
>  	.migrate_folio	=3D kvm_gmem_migrate_folio,
>  	.error_remove_folio =3D kvm_gmem_error_folio,
> +	.invalidate_folio =3D kvm_gmem_invalidate_folio,
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
>  	.free_folio =3D kvm_gmem_free_folio,
>  #endif
> @@ -984,6 +1006,7 @@ static int kvm_gmem_init_inode(struct inode *inode, =
loff_t size, u64 flags)
>  	 */
>  	mapping_set_inaccessible(inode->i_mapping);
>  	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> +	mapping_set_release_always(inode->i_mapping);

[Severity: High]
Does calling mapping_set_release_always() without a .release_folio
callback in kvm_gmem_aops cause filemap_release_folio() to fall back to
try_to_free_buffers() and evict guest_memfd folios without invalidation?

Because mapping_set_release_always() makes folio_needs_release() return
true, filemap_release_folio() runs on the folio and falls back to
try_to_free_buffers() when a_ops->release_folio is absent:

mm/filemap.c:filemap_release_folio() {
	if (mapping && mapping->a_ops->release_folio)
		return mapping->a_ops->release_folio(folio, gfp);
	return try_to_free_buffers(folio);
}

fs/buffer.c:try_to_free_buffers() {
	/* Misconfigured folio check */
	if (WARN_ON_ONCE(!folio_buffers(folio)))
		return true;
...
}

When soft_offline_page() -> soft_offline_in_use_page() ->
mapping_evict_folio() runs on a clean guest_memfd folio with no extra
references (for example, a private folio mapped only in the guest page
tables, as kvm_gmem_get_pfn() drops its folio reference before returning),
mapping_evict_folio() calls filemap_release_folio().  try_to_free_buffers()
triggers a kernel warning and returns true, allowing mapping_evict_folio()
to call remove_mapping() directly.  That removes the folio from
inode->i_mapping without calling kvm_gmem_invalidate_folio() (leaking the
provider's per-folio accounting) and without holding
filemap_invalidate_lock or zapping guest page tables.

Implementing a .release_folio callback in kvm_gmem_aops that returns false
would satisfy the mapping_set_release_always() contract and prevent
mapping_evict_folio() from evicting guest_memfd folios behind KVM's back.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D4
