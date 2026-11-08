Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098649;
	b=1tvNDfbL5/ZPt6hc3EihWxaYGMQqIXg84ALm5+UkVSjFi2/iIVc5v2kcxoMriGWdzRNc
	 GSrNk1Qka0YL17DUkITy7xsCxHiLaMdMwJ+XnjGwKTt7YYjTWWgqX5+jxP3odmfy7W+9k
	 ebyM8vPwIkSg/l0u1fK/wEL2TinnaUKDeLg6QKBpiIiVQkqfq5Ku1bHwahvzLcEDaXP1d
	 YTrjp2j48mXfht36APWLcqiKZZfcd/g0CUgKw2ahwszkqdMOFXhK4l0H70QkQXWee5Rzx
	 +t0b5E3W0tzxyLt9Gp0+YIcc7yEjI+n+fQQJFM72rIOKWhWO2JsjW6/IaxQXQunWzng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098649;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v+jhNrXXVDS4u+Yd6VZIyLG/BiyfW1WPw7MYWGJkhqU=;
	b=GkJ0T0NtZDTZd3S/YWTUl0TOxoKEodmcIYEws0Vk5zFE4XlziFqwMfizC5PsHTF9fF7e
	 u0nRksN8GkNtn+CsnIppem9o2iI+B6G2U3ep8vR9NdRCJ+CXMCkyqu0NLQtLpMJADj6UO
	 NX/QDsF2J1okTSz9dQjQ0qkqInp92McFdhp/T7lRVyPwg5FQZPAJj63aHIRnd8TPepd+Y
	 /elU6PielLFz7dUbpjxL0X9Dp2M5gmk8MXx2EcUHNkEF/VICek7DpUK3o0bpDBXd6aChP
	 rbDzd0d+dkyqioE/s6Cpz4u8WTLjhcDVSN3D2DsX1JQZIIx6yOXnGsP2EaZYKB1uHeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ml2bXKue;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5079F606D805
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ml2bXKue
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1466A1F0089F;
	Sun,  8 Nov 2026 00:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098649;
	bh=v+jhNrXXVDS4u+Yd6VZIyLG/BiyfW1WPw7MYWGJkhqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ml2bXKuet1505fUBnmoB87l+0gzcl/0EbyRzXhZAyefnHuIj1veZwCY1sWza0nNUi
	 STfnrpMTvMrnJDQ7wDBPcCwloqmPrzpByN20LGqoXAhSzRv6AwLZFna9uyLKBFpKKP
	 Er1PZ3GhkNbd/AoDYvsfzYNjHmEI1g4SqcAsH64OOnMW+UCmxzx09Mhd207Id1sHFe
	 VVPWf+SZcLRV2BTJ8FDt8SDV6QW6TIH6ZKFBovpjEQKzPdRQJYXeeHVvkxJHVZ9ULG
	 xYij8zhUp6dLnoFt4gnokQlu7A6rGKKRQfoY3VR+xxp9mSOV5m23YOBJlKjLl/WMHE
	 KrL9NTLTAdMCw==
Message-ID: <sashiko-outbox-203453@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 42/88] KVM: guest_memfd: Export kvm_gmem_revoke
 for provider-driven revocation
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-42-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-42-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:07 +0000
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
- [High] KVM: guest_memfd: race between kvm_gmem_revoke() and inode
  teardown
- [Low] KVM: guest_memfd: stray @mmap kernel-doc entry in guest_memfd.h
--

commit 3bc97f7ff873e4720a82787260ba8378c8ce9990
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Export kvm_gmem_revoke for provider-driven revocation

This commit introduces __kvm_gmem_revoke() and exports kvm_gmem_revoke()
so external memory providers can revoke physical memory ranges from
guest_memfd without calling back into .put_pfn_range().

> diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
> index 697f8f8c9b0ae..fb2279a001ebf 100644
> --- a/include/linux/guest_memfd.h
> +++ b/include/linux/guest_memfd.h
> @@ -28,8 +28,13 @@ struct mempolicy;
>   *           @pfn with uniform @pfn_attrs in @max_order. Once @get_pfn s=
ucceeds,
>   *           the provider must keep the @index-to-@pfn mapping and @pfn_=
attrs
>   *           constant, and the memory accessible, until guest_memfd stop=
s using
> - *           this page. Returns a negative error code on failure. The pr=
ovider
> - *           must define @lookup_pfn_range when @get_pfn is defined.
> + *           this page. Do not take locks held across kvm_gmem_revoke().
> + *           Returns a negative error code on failure. The provider must=
 define
> + *           @lookup_pfn_range when @get_pfn is defined.
> + * @mmap: Optional callback to set up user mappings. Called when userspa=
ce calls
> + *        mmap() on guest_memfd. The provider can customize VMA flags,
> + *        cacheability/protections, or reject the mapping. If not define=
d,
> + *        guest_memfd falls back to default mapping behavior.

[Severity: Low]
Does this @mmap kernel-doc entry belong in this commit?
struct guest_memfd_provider_operations has no mmap field here, which
triggers a scripts/kernel-doc warning and leaves a duplicate @mmap entry
once commit "KVM: guest_memfd: Support mmap provider operation" adds its
own description later in the series.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 1b6fc44ba00bb..023bf095340be 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c

[ ... ]

> @@ -469,6 +482,45 @@ static long kvm_gmem_punch_hole(struct inode *inode,=
 loff_t offset, loff_t len)
>  	return 0;
>  }
> =20
> +static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff=
_t len)
> +{
> +	return __kvm_gmem_revoke(inode, offset >> PAGE_SHIFT, len >> PAGE_SHIFT,
> +				 NULL, true);
> +}
> +
> +/**
> + * kvm_gmem_revoke - Revoke and reclaim a range of memory in guest_memfd.
> + * @inode:    The guest_memfd inode.
> + * @start:    Starting page index within the file.
> + * @nr_pages: Number of pages to revoke.
> + * @pfn:      The physical address / frame number being revoked. Directly
> + *            reclaims this physical range without querying the provider=
's
> + *            .lookup_pfn_range().
> + *
> + * guest_memfd will do everything to make sure the range revoked is no l=
onger in
> + * use across guest and host mappings, as well as reclaim any confidenti=
al
> + * architecture state.
> + *
> + * Before calling kvm_gmem_revoke(), the caller must ensure that future
> + * .get_pfn() calls for the revoked range will fail so new mappings cann=
ot be
> + * faulted back in after kvm_gmem_revoke() releases the inode's invalida=
te_lock.
> + * Must be called before accessing, freeing, resetting, or powering down=
 the
> + * backing resource, and the caller must keep the @start-to-PFN mapping =
valid
> + * and accessible until kvm_gmem_revoke() returns. .put_pfn_range() will=
 not be
> + * called.
> + *
> + * Acquires @inode->i_mapping->invalidate_lock exclusively; callers must=
 not
> + * hold any lock that is also acquired inside provider callbacks.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int kvm_gmem_revoke(struct inode *inode, pgoff_t start, size_t nr_pages,
> +		    const unsigned long *pfn)
> +{
> +	return __kvm_gmem_revoke(inode, start, nr_pages, pfn, false);
> +}
> +EXPORT_SYMBOL_GPL(kvm_gmem_revoke);

[Severity: High]
Can kvm_gmem_revoke() race with inode teardown in
kvm_gmem_destroy_inode()?

virt/kvm/guest_memfd.c:kvm_gmem_destroy_inode() {
    ...
	if (gi->provider_ops && kvm_gmem_is_pfn_mode(gi)) {
		pgoff_t nr_pages =3D i_size_read(inode) >> PAGE_SHIFT;

		kvm_gmem_pfn_reclaim(gi, 0, nr_pages);
		gmem_provider_put_pfn_range(gi, 0, nr_pages);
	}

	gmem_provider_release(gi);
    ...
}

Because provider callbacks cannot take provider locks held across
kvm_gmem_revoke(), inode->i_mapping->invalidate_lock is the only lock
serializing kvm_gmem_revoke() against reclaim and .put_pfn_range(), yet
kvm_gmem_destroy_inode() runs both without holding
filemap_invalidate_lock() before gmem_provider_release() detaches the
provider:

CPU0                                  CPU1
iput(inode)
  evict()
    kvm_gmem_destroy_inode()
      kvm_gmem_pfn_reclaim()
        gmem_provider_lookup_pfn_range()
                                      /* provider marks range absent */
                                      kvm_gmem_revoke(inode, ..., &pfn)
                                        filemap_invalidate_lock()
                                        kvm_arch_gmem_reclaim(*pfn, ...)
                                        filemap_invalidate_unlock()
                                      /* provider frees or resets memory */
        kvm_arch_gmem_reclaim(pfn, ...)
          <-- concurrent reclaim / use-after-free
      gmem_provider_put_pfn_range()

Since kvm_gmem_destroy_inode() does not hold filemap_invalidate_lock(),
kvm_gmem_revoke() can run kvm_arch_gmem_reclaim() concurrently on the same
PFNs and return 0 to the provider while CPU0 is still reclaiming and
releasing the backing pages.  In folio mode, evict() also runs
truncate_inode_pages_final() and clear_inode() before
kvm_gmem_destroy_inode() calls gmem_provider_release(), allowing a
concurrent kvm_gmem_revoke() to call truncate_inode_pages_range() during
or after final inode truncation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D42
