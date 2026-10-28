Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202531;
	b=pGn4i1caJQvNKuz3+FKKsqpZP8/NtyUuVJeWVL9TkDCL8/IxquqMEdKDIDhejle6qXPV
	 8jiigikEUmnSFW3HU1cLnC7FT3oiLI5jZlmfydsExoiqtEDyX1ZePs2fHlmMgX5SznbWh
	 n3NnKxLkv7yCEb27OHGxUBpSlaGEzP9tiHihF93wr3Wy/mn4zOpksiMp1/CxaFfsc3Eo6
	 fVgfk820y2sM9bmz7S1e2UYb8HhAF4loM/YqlsoEVYOmRqMpI02Zps8bMyvnmpncPHyJ7
	 Ui92E2lpRv1PZ8zvPa044w8fGzXaZJY9oOQ2bXrBFdZWhk+Mq8WMFrds3/97voHlQVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202531;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NmmD4yO6695dLKaZcbJ6IgK3b4ZwhEaIV1ijeiKAe5Q=;
	b=2f69a/gQKutnbxan8u84QvoGx2g1YRdV2FchoHJ1twOxjPnkl4JggleKH6HwJ/ZSXK6e
	 lA0aGpfaoEwpUiW0eSv4+mUdZJQPnn5GC7e1QbX5oPFxmpTLRVADvXDkH9fV/ANpkylsV
	 juclHvBWZfW59beddNAVykVhSUDpv+aF65kqekCGltsfROVBODLP2U0oZvIvxFNCVZaxL
	 HFCTJBiYfT8ggW2ju1KetWgg7Hclq+ePKcz5VgkZHdGWokqdY7OojQ7HDkJWiZot8nKGG
	 4v1Yz18EnwFxFEELdFfAHe9+Xi7+z+5tVsB+hTf9RHlQkacgGiFJPFAfZk18T9LY6lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGj+M7N+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F2606A334
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGj+M7N+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CE31F031E3;
	Wed, 28 Oct 2026 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793202531;
	bh=NmmD4yO6695dLKaZcbJ6IgK3b4ZwhEaIV1ijeiKAe5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fGj+M7N+Mld43wuC92F96RpQkeLJn+L+JZ9bHpfMSf3K6FODlEm93QiYzXkUaILJu
	 LzkCOBB8OEarUGzeMQC/Fb4HgLUzZ0kb7l1mfzgzhvrfqoZ23eK85/9tDnP3yUJ89Q
	 f2xxaJL5zq4UHyWnbRUvhTAmRJ6b0xFatMkdY3bex2301uZVjFXEZEEAdCjtY12Soc
	 HwQHPsAsYbVa57sva9YPdXnw7ktvn5dmGy6bgMVhl1Mc8RqdTme8J8QNj3qY2ddPR4
	 X2w9Dk+skhviVEBCajjeFxiK65jpjapgyzjZpxrzNShy6XUkUt62GVNtryPPUny7jg
	 cdW1T0zAjfKWw==
Message-ID: <sashiko-outbox-188095@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 13/14] samples/kvm: Back absent pages on demand in
 the sample provider
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fred Griffoul" <griffoul@gmail.com>, "Ackerley Tng" <ackerleytng@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Sean Christopherson" <seanjc@google.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Kevin Tian" <kevin.tian@intel.com>
Cc: "Alex Williamson" <alex@shazbot.org>, "Alexander Graf" <graf@amazon.de>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Alexey Kardashevskiy" <aik@amd.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, "Ashish
 Kalra" <ashish.kalra@amd.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Baolu
 Lu" <baolu.lu@linux.intel.com>, "Bill Wendling" <morbo@google.com>, "Borislav
 Petkov" <bp@alien8.de>, "Catalin Marinas" <catalin.marinas@arm.com>, "Christian
 Brauner" <brauner@kernel.org>, =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Connor
 Williamson" <connordw@amazon.com>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, "David Hildenbrand" <david@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "David Woodhouse" <dwmw2@infradead.org>, "Erdem
 Aktas" <erdemaktas@google.com>, "Frank van der Linden" <fvdl@google.com>, "Gregory
 Price" <gourry@gourry.net>, "H . Peter Anvin" <hpa@zytor.com>, "Hugh
 Dickins" <hughd@google.com>, "Ingo Molnar" <mingo@redhat.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "James
 Houghton" <jthoughton@google.com>, "Jan Kara" <jack@suse.cz>, "Jianxiong
 Gao" <jxgao@google.com>, "Joerg Roedel" <joro@8bytes.org>, "Joey Gouly" <joey.gouly@arm.com>, "John
 Starks" <John.Starks@microsoft.com>, "Jonathan Corbet" <corbet@lwn.net>, "Justin
 Stitt" <justinstitt@google.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>, "Michael Roth" <michael.roth@amd.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, "Nicolin Chen" <nicolinc@nvidia.com>, "Oliver
 Upton" <oupton@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Robin Murphy" <robin.murphy@arm.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Shuah Khan" <shuah@kernel.org>, "Steffen
 Eiden" <seiden@linux.ibm.com>, "Steven Price" <steven.price@arm.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Thomas
 Gleixner" <tglx@kernel.org>, "Tom Lendacky" <thomas.lendacky@amd.com>, "Tycho
 Andersen" <tycho@kernel.org>, "Vishal Annapurve" <vannapurve@google.com>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Will Deacon" <will@kernel.org>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Yan
 Zhao" <yan.y.zhao@intel.com>, "Zenghui Yu" <yuzenghui@huawei.com>, x86@kernel.org, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Fuad Tabba" <fuad.tabba@linux.dev>, kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261027154649.91571-14-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com>
 <20261027154649.91571-14-griffoul@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:48:47 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] samples/kvm: lockless absent bitmap updates race in get_pfn() and =
put_pfn()
- [Medium] samples/kvm: mps_gmem_get_pfn() fills 2 MiB when reporting small=
er max_order
--

commit 2aa66dad428fa6322f520c9983287b30bb49a21a
Author: Fred Griffoul <fgriffo@amazon.co.uk>

samples/kvm: Back absent pages on demand in the sample provider

This commit adds the MPS_NEW_FILE_FILL flag to the KVM sample memory
provider so that get_pfn() backs an absent page along with the surrounding
2 MiB block on demand, and put_pfn_range() marks released pages as absent
again.

> diff --git a/samples/kvm/mem_provider_sample.c b/samples/kvm/mem_provider=
_sample.c
> index 670e36207e596..41e0ce5b6bc6a 100644
> --- a/samples/kvm/mem_provider_sample.c
> +++ b/samples/kvm/mem_provider_sample.c
> @@ -41,6 +41,7 @@ struct mps_info {
> =20
>  	unsigned long *absent;		/* taken away by MPS_SET_PRESENT */
>  	unsigned long *readonly;	/* set by MPS_SET_READONLY */
> +	bool fill;			/* MPS_NEW_FILE_FILL */
> =20
>  	struct inode *gmem_inode;
>  };
> @@ -62,8 +63,15 @@ static void mps_gmem_put_pfn_range(void *provider, pgo=
ff_t index,
>  				   size_t nr_pages)
>  {
>  	struct file *resource_file =3D provider;
> +	struct mps_info *info =3D resource_file->private_data;
> +	size_t i;
> =20
> -	mps_zero_range(resource_file->private_data, index, nr_pages);
> +	mps_zero_range(info, index, nr_pages);
> +	if (!info->fill || index >=3D info->npages)
> +		return;
> +	/* Lockless, like get_pfn(): guest_memfd holds its invalidate lock. */
> +	for (i =3D index; i < min_t(size_t, index + nr_pages, info->npages); i+=
+)
> +		set_bit(i, info->absent);
>  }

[Severity: High]
Can updating info->absent without info->lock in mps_gmem_put_pfn_range() and
mps_gmem_get_pfn() race with mps_set_present() and concurrent faults?

In samples/kvm/mem_provider_sample.c, mps_set_present() modifies
info->absent under info->lock using non-atomic bitmap_clear() and
bitmap_set() without holding guest_memfd's filemap_invalidate_lock:

samples/kvm/mem_provider_sample.c:mps_set_present() {
	mutex_lock(&info->lock);
	if (present) {
		bitmap_clear(info->absent, start, end - start);
		if (info->gmem_inode)
			kvm_gmem_restore(info->gmem_inode, start, end - start);
	} else {
		bitmap_set(info->absent, start, end - start);
		if (info->gmem_inode) {
			unsigned long pfn =3D info->base_pfn + start;

			kvm_gmem_revoke(info->gmem_inode, start, end - start, &pfn);
			mps_zero_range(info, start, end - start);
		}
	}
	mutex_unlock(&info->lock);
}

First, if mps_set_present() runs concurrently with mps_gmem_put_pfn_range()
or mps_gmem_get_pfn() on indices within the same unsigned long word of
info->absent, the non-atomic read-modify-write in bitmap_set() or
bitmap_clear() can overwrite concurrent set_bit() or clear_bit() updates.

Second, during revocation in mps_set_present(..., false), bitmap_set() runs
before kvm_gmem_revoke() takes filemap_invalidate_lock, and mps_zero_range()
runs after kvm_gmem_revoke() releases filemap_invalidate_lock. If
mps_gmem_get_pfn() runs in either window, it observes test_bit(index,
info->absent) as true and clears info->absent for the 2 MiB block, which
can either cause kvm_gmem_revoke() to see the pages as present and skip
revoking exports, or allow a fault to map the page before or during
mps_zero_range().

Third, callers of kvm_gmem_pfn_get() (such as kvm_gmem_get_pfn(),
kvm_gmem_fault_user_mapping(), and kvm_gmem_allocate()) hold
filemap_invalidate_lock_shared(). While one thread is clearing the 512 bits
of info->absent in mps_gmem_get_pfn(), a second thread faulting in the same
2 MiB block can observe test_bit(index, info->absent) already cleared for
its index while higher bits in the 2 MiB block are still set, causing it to
compute a smaller *max_order and return before the first thread finishes
clearing the block or updating exports.

[ ... ]

> @@ -241,8 +251,16 @@ static int mps_gmem_get_pfn(void *provider, pgoff_t =
index, unsigned long *pfn,
>  	if (index >=3D info->npages)
>  		return -EINVAL;
> =20
> -	if (test_bit(index, info->absent))
> -		return -EFAULT;
> +	if (test_bit(index, info->absent)) {
> +		unsigned long first =3D ALIGN_DOWN(index, PTRS_PER_PMD);
> +		unsigned long i;
> +
> +		if (!info->fill)
> +			return -EFAULT;
> +		/* Absent pages are zeroed already. */
> +		for (i =3D first; i < min(first + PTRS_PER_PMD, info->npages); i++)
> +			clear_bit(i, info->absent);
> +	}

[Severity: Medium]
What happens to guest_memfd export notifications when mps_gmem_get_pfn()
clears info->absent for the full 2 MiB range, but returns a *max_order
smaller than PMD_ORDER (or when max_order is NULL in
kvm_gmem_pfn_mkwrite())?

In samples/kvm/mem_provider_sample.c, mps_gmem_get_pfn() computes *max_order
after clearing info->absent:

	if (!max_order)
		return 0;
	for (order =3D PUD_ORDER; order; order--) {
		unsigned long first =3D ALIGN_DOWN(index, 1UL << order);
		unsigned long n =3D 1UL << order;

		if (first + n <=3D info->npages &&
		    mps_bits_are(info->absent, first, n, false) &&
		    mps_bits_are(info->readonly, first, n, ro))
			break;
	}
	*max_order =3D order;

And in virt/kvm/guest_memfd.c, kvm_gmem_pfn_get() updates exports only for
the (1UL << order) block reported by get_pfn():

virt/kvm/guest_memfd.c:kvm_gmem_pfn_get() {
	if (!list_empty(&gi->exports))
		hole =3D gi->provider_ops->lookup_pfn_range(gi->provider, index,
							  &raw, &nr) =3D=3D -ENOENT;

	r =3D gmem_provider_get_pfn(gi, index, pfn, &order, attrs);
	if (r)
		return r;

	if (hole) {
		first =3D round_down(index, 1UL << order);
		kvm_gmem_update_exports(inode, first,
					min(first + (1UL << order), npages));
	}
}

If any page in the 2 MiB range has a different readonly setting in
info->readonly (via MPS_SET_READONLY), or if the remaining pages at the end
of the file (info->npages - first) are fewer than PTRS_PER_PMD and not
covered by a single power-of-two block around index, *max_order will be
smaller than PMD_ORDER.

Because info->absent was already cleared across the entire 2 MiB range,
kvm_gmem_pfn_get() only calls kvm_gmem_update_exports() for the smaller
(1UL << order) sub-block, and subsequent calls to kvm_gmem_pfn_get() on the
other pages in that 2 MiB block will see lookup_pfn_range() return 0
(hole =3D=3D false) and never notify exports for them either.

Should the loop clearing info->absent only clear the range corresponding to
the order that mps_gmem_get_pfn() can actually report back to guest_memfd?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027154649.9157=
1-1-griffoul@gmail.com?part=3D13
