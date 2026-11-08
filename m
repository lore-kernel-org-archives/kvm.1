Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098648;
	b=q9WlHn2erccOW++QluXwiLwZPXtX5MNg9UtA/0E5wHCFDUp5Z3hh09PSyOlG8538Tjp8
	 SSEMqQQNX9LRVlGh4mtSSd3671zdYqrZFhZJZcAPZrg3910kjMxhPHcJu1QOMK05mzeJs
	 iyQBiHtdFAqnxetHpQo52/wU1w3Jito5wP/AyMDOu8uGv5dVw0PjQ/V5cO6HiAQgz4CR4
	 1lbDSQYJyqu41PExZ3mzxN1xnmwwC80XxfYI4DRt/KRvNFed1tBRTOjTAV0G4a5N8dNd5
	 pYUJCXl+7fKnd70Frebfogb/zwfezBYEsecDyfUDutufqfrGURBl1hYtp2UmZ4vgasA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098648;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hHiPeRDdKt6uysazh6qBj284sMmxoFfzZ0xM2cwi2rc=;
	b=ADorg9XaTbHKBCnN0BlaJpaJr0gl15C4PVxr6QhcibfAd5W+eoFbMW53ButZBXt+it8T
	 V+PfFAIbdY93HaFOJTGZnRATNA8A83jbFRd/u/m/9ydBOMjp4Syp58FVOwc14FKuHJ6uh
	 5cNe1Eti8jwSNcIXmQnggWnaBd2B21m7cGPlno1eJkA2hku9laKsYYRUrIVhwZuXRCrEN
	 /EETyTITkA2sLbUm5iGlP/i+efhgM+sr5sCao5uin5Np0nEuY+30zntDzpEzvpv/L5iiq
	 UbetI21PclIVYSJvejmFKB68gcd6uYvUHyD8PYFg+qtlkRXQQxpc9ZYLEkfTfv9m4NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qp1V0F7a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B318B606A333
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qp1V0F7a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B03C1F008A3;
	Sun,  8 Nov 2026 00:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098647;
	bh=hHiPeRDdKt6uysazh6qBj284sMmxoFfzZ0xM2cwi2rc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qp1V0F7afVq1QoTkzV65bnjQNfYbetwQuWDUtONFcWyMolB5oPENj2nXQ8jYxS0fj
	 eKcXYdNpspLK95vHqJMCUvrE988phEJnFlal0Y0zBXN0zzYkkpYMDjCqYNKy+1rqWE
	 /LnWaEUKDd6alrhTycbampppz9c+hndQVB0V2AmMhRB1IMWCjKQr+Z5Kv281sIJ2Ku
	 /CQwN0y0DQjfVrmLEMoqud+V8d7zCDQH3KNiXjcQ0It35C9vSuOz22pK6WmS5CM7OC
	 03ODBs0XxBwLASO9uNAqmZTD51DbufvRieXpdvVtoYb+VBDvCr8D1MT0u1vFqPn53+
	 r7lyGIcnpwxaw==
Message-ID: <sashiko-outbox-203450@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 39/88] KVM: guest_memfd: Support put_pfn_range
 provider op in PFN mode
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-39-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-39-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:06 +0000
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
- [Medium] KVM: guest_memfd: missing invalidate_lock in
  kvm_gmem_destroy_inode()
--

commit caed7fc7e8fd2f7ee37985c5b86064cab5aac2e9
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Support put_pfn_range provider op in PFN mode

This commit introduces the .put_pfn_range callback in struct
guest_memfd_provider_operations and invokes it after kvm_gmem_pfn_reclaim()
during hole punching and inode destruction in PFN mode.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b46907b480138..501c3e250fc98 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c

[ ... ]

> @@ -1730,8 +1738,12 @@ static void kvm_gmem_destroy_inode(struct inode *i=
node)
>  	 * Skip if the provider was not yet set up, as iput() can reach this on
>  	 * error paths before provider_ops is initialized.
>  	 */
> -	if (gi->provider_ops && kvm_gmem_is_pfn_mode(gi))
> -		kvm_gmem_pfn_reclaim(gi, 0, i_size_read(inode) >> PAGE_SHIFT);
> +	if (gi->provider_ops && kvm_gmem_is_pfn_mode(gi)) {
> +		pgoff_t nr_pages =3D i_size_read(inode) >> PAGE_SHIFT;
> +
> +		kvm_gmem_pfn_reclaim(gi, 0, nr_pages);
> +		gmem_provider_put_pfn_range(gi, 0, nr_pages);
> +	}
> =20
>  	gmem_provider_release(gi);

[Severity: Medium]
Should kvm_gmem_destroy_inode() hold filemap_invalidate_lock(inode->i_mappi=
ng)
across gmem_provider_put_pfn_range()?

The kernel-doc for struct guest_memfd_provider_operations documents that
.put_pfn_range() is called with the exclusive filemap invalidate lock held,
and kvm_gmem_destroy_inode() only takes filemap_invalidate_lock() later
around __mt_destroy(&gi->attributes):

virt/kvm/guest_memfd.c:kvm_gmem_destroy_inode() {
	...
	if (!mtree_empty(&gi->attributes)) {
		filemap_invalidate_lock(inode->i_mapping);
		__mt_destroy(&gi->attributes);
		filemap_invalidate_unlock(inode->i_mapping);
	}
}

Because the provider receives gmem_inode in .attach() and remains attached
until gmem_provider_release() runs after gmem_provider_put_pfn_range(), a
provider that asserts or relies on gmem_inode->i_mapping->invalidate_lock in
.put_pfn_range() will trigger a lockdep splat or race during inode teardown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D39
