Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85443264E7
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772899; cv=none; b=JObZ0H/ZGUniGwiBsSg3ZVxOiKfsiRP6mu8vYGlPtxu/ptf4eu6TiYkM02y40FoI28jNqYnJU9nnIlbPFg1fYMdW0emVlXlKqFCl8Fo2kyCK9J45w/xHBZY/ZT2hIN/yTA7eG7tLvQ+TfrhdUwCtb1OXVyz/CYxpLQddXx1Uwa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772899; c=relaxed/simple;
	bh=mfoVEtr0DCdj+Jl2XrghaG9xAy00LQXidjlElkNFttI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dBd4rz8zCo8zTJnw1JN4Wy88dk/NR3HL0aL/oqLBb2Ib8wVFoB3bE1d7A4SoqHZXvYNMnJ77kF3JXNibmjsquqMpstHzsO75pAziZKjxn9HrtbDLomtPJsnmO5r3qO6iwKaefxcJs177/fcSegXIPNKSuuX3BspKwswL9Zxplr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXyf6SPC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXyf6SPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8787A1F000E9;
	Thu, 18 Jun 2026 08:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781772898;
	bh=IyJ8F6L2SFku7ieO2cgU10qdTgeE8gibAPz2p7/G05s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CXyf6SPCHEt20btaZxDnqPVfqRs5XdF6uhXZovbCsSz193PWUyU64afcQA1uJDNic
	 tNeszoT8GVuzT+03zVnn6J3Fnaiy/h4pwpN/PZY2qjglmsA/8Yj9g8pDWFLX3vaHXc
	 27OS/iFOS53wFmk3CfwnqFwwA/TBWURjP0TBuafTnEuqtJX4764A9hubmYIJRHNQ3j
	 uteQPOHNQRtovMnOmhOTJMOZdyklCbkERoVcUYcXDbzUhavSQ13iqXDKAjr2T9HaPY
	 r/QWOCuIP2UOZ7fUWJ5u02G1vAL9vNkzXvo47yJipKH5BQ8lJ4x+1a8uWIUMZWwPsY
	 vUzNfGqLv1ODw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/17] x86/virt/tdx: Add extra memory to TDX module
 for the extensions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yilun" <yilun.xu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260618081355.3253581-5-yilun.xu@linux.intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-5-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 08:54:58 +0000
Message-Id: <20260618085458.8787A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Hardware PFN mismatch due to unaligned slab allocation for `hpa_li=
st` with debugging enabled.
- [Medium] Resource leak of un-added contiguous host memory on TDX module e=
rror path.
- [Medium] Improper use of node_online_map instead of N_MEMORY node states =
for allocation.
- [Low] Unnecessary early boot memory allocation error handling returning -=
ENOMEM.
--

commit e910725d57b782da4b05f3bb30b4df0fa4da1da3
Author: Xu Yilun <yilun.xu@linux.intel.com>

x86/virt/tdx: Add extra memory to TDX module for the extensions

This patch introduces a memory feeding process via SEAMCALL TDH.EXT.MEM.ADD
to allocate one-time memory for TDX module extensions during initialization.
It allocates contiguous memory and passes it to the module using a newly
defined HPA_LIST_INFO format.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 6f3596f11d250..dab17822c1c69 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c

[ ... ]

> +static __init int tdx_ext_mem_setup(unsigned int required_pages)
> +{
> +	struct tdx_hpa_list *hpa_list;
> +	struct page *page;
> +	unsigned int i;
> +	int ret;
> +
> +	/*
> +	 * memory_pool_required_pages =3D=3D 0 means no need to add pages,
> +	 * skip the memory setup.
> +	 */
> +	if (!required_pages)
> +		return 0;
> +
> +	hpa_list =3D kzalloc_obj(*hpa_list);

[Severity: High]
Does this code pass unaligned physical pages to the hardware if slab
debugging is enabled?

When CONFIG_SLUB_DEBUG or KASAN is enabled, slab objects are padded with
metadata, causing the object to start at a non-zero offset within a physical
page. The virt_to_page(hpa_list) call below will grab the base page frame
which the hardware will read from offset 0, leading it to consume SLUB
metadata instead of the valid hpa_list entries.

Should this allocation use the page allocator directly (e.g.,
__get_free_page()) to guarantee strict page alignment?

> +	if (!hpa_list)
> +		return -ENOMEM;
> +
> +	page =3D alloc_contig_pages(required_pages, GFP_KERNEL, numa_mem_id(),
> +				  &node_online_map);

[Severity: Medium]
Can this allocation fall back to memoryless nodes?

The node_online_map can include nodes without memory. The mm allocation
guidelines require using the N_MEMORY state mask (e.g., node_states[N_MEMOR=
Y])
to correctly constrain memory allocations to nodes that actually have memor=
y.

> +	if (!page) {
> +		ret =3D -ENOMEM;

[Severity: Low]
Is this complex error handling necessary here?

Since tdx_ext_mem_setup() is only called from the __init path, physical mem=
ory
should be available. If an allocation of this size fails during early boot,
the system likely cannot boot anyway, making graceful error cleanup here
largely dead code.

> +		goto out_free_hpa_list;
> +	}
> +
> +	i =3D 0;
> +	while (i < required_pages) {
> +		unsigned int nents =3D min(required_pages - i,
> +					 ARRAY_SIZE(hpa_list->phys));
> +		unsigned int j;
> +
> +		for (j =3D 0; j < nents; j++)
> +			hpa_list->phys[j] =3D page_to_phys(page + i + j);
> +
> +		ret =3D tdx_ext_mem_add(virt_to_page(hpa_list), nents);
> +		/*
> +		 * No SEAMCALLs to reclaim the added pages. For simple error
> +		 * handling, leak all pages.
> +		 */
> +		WARN(ret, "Fatal: TDX module rejected (%d) memory for extensions, stra=
nded all pages\n",
> +		     ret);
> +		if (ret)
> +			break;

[Severity: Medium]
Does this intentionally leak un-added host memory on the error path?

While pages that have already been accepted by the hardware cannot be
reclaimed, the remaining contiguous block of pages (from page + i to the en=
d)
are still entirely host-owned. Could these remaining un-added pages be safe=
ly
freed via free_contig_range() instead of permanently leaking tens of megaby=
tes?

> +
> +		i +=3D nents;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618081355.3253=
581-1-yilun.xu@linux.intel.com?part=3D4
