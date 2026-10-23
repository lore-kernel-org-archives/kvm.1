Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798310;
	b=jcHTX/pmtHkTyrrHW0wZvIr/0POj7diuYPjQrcJjWDgLCYYRF7ckvoye6VSyB3IEQLxf
	 IXkxG4Vg65nCtCe/S42W9cZGWx2wxi1UDw6rBmrlmw8/yCknF08op2RImR3IdWHSRrUrq
	 GwxevXGl1p603yER5y/LOpqNPcWTvJX+XL5y+OzuxrfwokqiKrcJNdtAW3dxdPdqy4XzQ
	 aWwXGRnaHiKLpUkgtQibUCIEL84YjhdryAui5zA3L/Xn05xs7ZpDhTHclLO7CDx3JRsGa
	 WjLUILQ/Nrtfoi8/GAA0ZmjB7TyBHpH1Eh7F78CTNZ0Xwrh5GbTvfxrJLgNO3ecARNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798310;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N6oew5qL/EGvyQxxsjUH/pbhr45NldZJXrfEfFnr/kk=;
	b=cOtgHoQWKuSqPqvVK0liy7hNnRRGz3Kjx5bH3eZGlRfudSrYbdJk5iDD7uHomMpOV9JM
	 1vsYyJZYYKVSUCWEbjibF2AAJvDU/Cj7sagCbRVvi4t2zI8l3woesotQK7k7oj87KGTkT
	 lZ9ooyXArsh4x3fKSiR12ulZLV7PpIfoUS1usAEio9UxO8Gai3fiqJTrjuRF62MfbkYZw
	 SGEJjFREHOj7ft9DMo9j3MdReLA91e4iK5nIp/yQfTLQemX7neHknOcyM0Z4dCoMlG20f
	 FIbFZfHCGRt6ACkfqhP8+byzbzJP6ZeCmcXz9R7kSWA1qz9LuAoXT8XjWSTEVAJhBXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LRKQCUm4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B11606A31A
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 23:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LRKQCUm4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF941F01828;
	Fri, 23 Oct 2026 23:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792798310;
	bh=N6oew5qL/EGvyQxxsjUH/pbhr45NldZJXrfEfFnr/kk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LRKQCUm4Jw1b23J1ePMQCSwNabSprFxLieX6tQdjDJig9B3j5T4HQUPoDoQDRrfCI
	 FdD2n0HrhiKjTtoDcKOhrQMNki7/pe1rRywLIv8AO68MLtP0RESd3ssZfc2RuH1nxS
	 /KjcaKx/rY0GlMeuGqdj67n/m028GgXdYuE/LS3hKoKuDWj0Kk+WHHWSXcHkg2WOX8
	 anZq/J2JuIqGTbiK1W2O5g83IgOoADQ9LR9S/DN/R7LQr85fS8x+LJuTJxbsWKITZZ
	 OECtgSL1Y2Y42BzyxmYcnXwh3O0m//I8YK7Cq6Lw6iFWnOfiCR6CzSMEjAsxPhBdBr
	 DO5bl7ZJilUGw==
Message-ID: <sashiko-outbox-183368@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 04/50] KVM: guest_memfd: Support provider folio
 invalidation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>, "Alex Williamson" <alex@shazbot.org>, "Alexander
 Graf" <graf@amazon.de>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Alexey
 Kardashevskiy" <aik@amd.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, "Ashish Kalra" <ashish.kalra@amd.com>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "Baolu Lu" <baolu.lu@linux.intel.com>, "Bill
 Wendling" <morbo@google.com>, "Borislav Petkov" <bp@alien8.de>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Christian Brauner" <brauner@kernel.org>,
 =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Connor
 Williamson" <connordw@amazon.com>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, "David Hildenbrand" <david@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "David Woodhouse" <dwmw2@infradead.org>, "Erdem
 Aktas" <erdemaktas@google.com>, "Frank van der Linden" <fvdl@google.com>, "Fred
 Griffoul" <fgriffo@amazon.co.uk>, "Fred Griffoul" <griffoul@gmail.com>, "Gregory
 Price" <gourry@gourry.net>, "H. Peter Anvin" <hpa@zytor.com>, "Hugh Dickins" <hughd@google.com>, "Ingo
 Molnar" <mingo@redhat.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "James
 Houghton" <jthoughton@google.com>, "Jan Kara" <jack@suse.cz>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Jianxiong Gao" <jxgao@google.com>, "Joerg
 Roedel" <joro@8bytes.org>, "Joey Gouly" <joey.gouly@arm.com>, "John Starks" <John.Starks@microsoft.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Justin Stitt" <justinstitt@google.com>, "Kevin
 Tian" <kevin.tian@intel.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>, "Michael Roth" <michael.roth@amd.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, "Nicolin Chen" <nicolinc@nvidia.com>, "Oliver
 Upton" <oupton@kernel.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Robin
 Murphy" <robin.murphy@arm.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Sean
 Christopherson" <seanjc@google.com>, "Shuah Khan" <shuah@kernel.org>, "Steffen
 Eiden" <seiden@linux.ibm.com>, "Steven Price" <steven.price@arm.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Thomas
 Gleixner" <tglx@kernel.org>, "Tom Lendacky" <thomas.lendacky@amd.com>, "Tycho
 Andersen" <tycho@kernel.org>, "Vishal Annapurve" <vannapurve@google.com>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Will Deacon" <will@kernel.org>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Yan
 Zhao" <yan.y.zhao@intel.com>, "Zenghui Yu" <yuzenghui@huawei.com>, x86@kernel.org, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Fuad Tabba" <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261022-gmem-alternative-providers-v2-4-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261022-gmem-alternative-providers-v2-4-5dd1dc6c660a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 23:31:45 +0000
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
- [High] KVM: guest_memfd: AS_RELEASE_ALWAYS without release_folio() in kvm=
_gmem_aops
--

commit 761ef1ff98198357ffc1c8f5492a708cb9b2d9ab
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Support provider folio invalidation

This commit adds a provider invalidate_folio callback to guest_memfd and wi=
res
it up to address_space_operations.invalidate_folio and the filemap_add_foli=
o()
error path in kvm_gmem_get_folio(). It also sets AS_RELEASE_ALWAYS on the
inode mapping in kvm_gmem_init_inode() so truncate_cleanup_folio() invokes
.invalidate_folio.

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
> =20
>  	gi->flags =3D flags;
> =20

[Severity: High]
Does setting mapping_set_release_always() in kvm_gmem_init_inode() without
providing a .release_folio callback in kvm_gmem_aops cause filemap_release_=
folio()
to fall back to try_to_free_buffers() and allow mapping_evict_folio() to ev=
ict
guest_memfd folios?

When AS_RELEASE_ALWAYS is set, folio_needs_release(folio) returns true. If
mapping->a_ops->release_folio is NULL, filemap_release_folio() falls through
to try_to_free_buffers():

mm/filemap.c:filemap_release_folio() {
	if (!folio_needs_release(folio))
		return true;
	if (folio_test_writeback(folio))
		return false;

	if (mapping && mapping->a_ops->release_folio)
		return mapping->a_ops->release_folio(folio, gfp);
	return try_to_free_buffers(folio);
}

fs/buffer.c:try_to_free_buffers() {
	/* Misconfigured folio check */
	if (WARN_ON_ONCE(!folio_buffers(folio)))
		return true;
}

When a folio is allocated in kvm_gmem_get_folio(), filemap_add_folio() plac=
es
it on the unevictable LRU with PG_lru set. If the folio is not mapped into
userspace page tables (such as private guest_memfd folios or unmapped shared
folios, even while mapped in KVM Stage-2/TDP page tables), its refcount is 1
and it is clean.

If soft_offline_page() in mm/memory-failure.c runs on that PFN (or if
__do_fault() in mm/memory.c encounters a PageHWPoison guest_memfd folio), it
calls mapping_evict_folio() in mm/truncate.c:

soft_offline_page()
  -> get_hwpoison_page()
  -> soft_offline_in_use_page()
    -> mapping_evict_folio()
      -> filemap_release_folio()
        -> try_to_free_buffers()
      -> remove_mapping()

Because mapping_evict_folio() does not check mapping_unevictable(), it calls
filemap_release_folio(), triggers WARN_ON_ONCE(!folio_buffers(folio)) in
try_to_free_buffers(), and receives true. It then proceeds to remove_mappin=
g(),
which removes the folio from inode->i_mapping without holding
filemap_invalidate_lock, without zapping KVM Stage-2 mappings, and without
invoking kvm_gmem_invalidate_folio(), leaking the provider's allocation
accounting (such as tmpfs sbinfo->used_blocks).

Should kvm_gmem_aops also implement .release_folio (or avoid
mapping_set_release_always()) so that filemap_release_folio() does not fall
through to try_to_free_buffers() and permit eviction via mapping_evict_foli=
o()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-gmem-alter=
native-providers-v2-0-5dd1dc6c660a@google.com?part=3D4
