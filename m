Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202528;
	b=FT8RqgyzBX0PkK4ATvIn2eH4jgVbow8Vl5Y3gfkrAfTyBY/ngyO+jaNrjNATTFJHrBrz
	 dSyM5Rug1kvzpWA5Fju8dqjt7b9I8oClaO5sMsVop6br5WJyvyotwiTYgsPR1h3KjdNdn
	 3JX/8aLMhmCtSkIxEQ2dKsLH0VBhXn2eNNj3Ogv8fUnwPb4s/O5RuZ0rvIrMUHA+h7i+B
	 zkI0k9PvqdmH4eKNdJgViDj74JlU+7GX5Gz1Bl9vMJiHFehkwuwAQTFeMTgmwKZ0L81yW
	 NJjsr5RkiG20yN0SOtI6buLASMD9FvlW5Kz2To0GpaCgTteCnmxoLiEVcUEKuHvxK4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202528;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sgJp/0Bmza7ipLqb+lZFfXeJ26JvK37iVpiObAP88/8=;
	b=hpV+5HBcrcThTloZ9FI+bNZ22h/31S9MLXMrHuvylPHpynXeuoe5GssL57o6hJC/22B+
	 IuAa6UlO9bYp/TiSaNRoNJdEzE3BOv+5yznv4TEOvz4FOGPKrmGbX0EFP5swySAZmC4c8
	 /cGBSdbmE+qE4doc6Qb+IoAjIe+htgIPqBm3gM9TSRYex4VKH/I/sCk1H5uH5Ccv984J7
	 /zO2ZcCafcVsNMJHmej5/bL8gpXBaQdph2fAz6ANTPBRJ5J4wmFK7+exfznCHE/7axMIx
	 /cqycj+EcvqLp2TIIg/RDz4BXZ/HdUPlTU3zipY4FtYNaFfOWNEkcjcy9YHrU5WIBkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHrUnolf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE7606A758
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHrUnolf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A94E1F01828;
	Wed, 28 Oct 2026 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793202527;
	bh=sgJp/0Bmza7ipLqb+lZFfXeJ26JvK37iVpiObAP88/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lHrUnolfy+YsLFeyY2tP7vYLm7i3gMc9YoxQBihnfLd27aOjScxlVDU+LhJDcuIGk
	 9qv7MFaNczHRsglMpcqDCwhS4qiUU3IpO3D391xTblXQUT57ysbcvEYFErI43cnjeL
	 9K1jZ1PWdN43Pw9j8eoEnNsR+B2fHKp3G4sBvX2Wr8aaaGW6UPd1ej+lILxKKC6cIi
	 rGd98CbkfubRGrPRcR0rNhK/IOS5vnTbO/pdIARDcX/VuOUfszYRa9TYAXbv/nan2q
	 zWcN8fNOylcY36JomFflZ6CeOtAgsiZT9Ss+/qhfZFn6HEm2jY/v1dhfx7dkNS/Ujs
	 UPY816FNkHuWw==
Message-ID: <sashiko-outbox-188091@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 09/14] iommufd: Map guest_memfd files
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
In-Reply-To: <20261027154649.91571-10-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com>
 <20261027154649.91571-10-griffoul@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:48:43 +0000
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
- [Medium] iommufd: missing iova page-alignment check for gmem in iopt_inse=
rt_area()
--

commit bbd05c04a17efd9d7e027af5dc5147510ebf160e
Author: Fred Griffoul <fgriffo@amazon.co.uk>

iommufd: Map guest_memfd files

This commit allows IOMMU_IOAS_MAP_FILE to map guest_memfd files using
guest_memfd's export interface without pinning pages. It maps PAGE_SIZE
entries and updates IOMMU mappings upon guest_memfd update notifications.

> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd=
/io_pagetable.c
> index 43d518e4ce585..62fa553cdffc0 100644
> --- a/drivers/iommu/iommufd/io_pagetable.c
> +++ b/drivers/iommu/iommufd/io_pagetable.c
> @@ -217,9 +217,13 @@ static int iopt_insert_area(struct io_pagetable *iop=
t, struct iopt_area *area,
>  		return -EPERM;
> =20
>  	area->iommu_prot =3D iommu_prot;
> +	area->gmem =3D iopt_is_gmem(pages);
>  	area->page_offset =3D start_byte % PAGE_SIZE;
>  	if (area->page_offset & (iopt->iova_alignment - 1))
>  		return -EINVAL;
> +	/* guest_memfd frames are mapped whole, see iopt_gmem_map(). */
> +	if (area->gmem && (area->page_offset || !PAGE_ALIGNED(length)))
> +		return -EINVAL;

[Severity: Medium]
Should iopt_insert_area() also check !PAGE_ALIGNED(iova) when area->gmem
is set?

When userspace calls IOMMU_IOAS_MAP_FILE (or IOMMU_IOAS_COPY) with
IOMMU_IOAS_MAP_FIXED_IOVA, iopt_alloc_area_pages() validates the IOVA
through iopt_check_iova(), which only checks iova & (iopt->iova_alignment -=
 1).
Unlike iopt->disable_large_pages in iopt_calculate_iova_alignment(), a
guest_memfd area does not force iopt->iova_alignment to PAGE_SIZE, so
iopt->iova_alignment is 1 when no domain is attached yet, or smaller than
PAGE_SIZE when attached to a domain supporting sub-PAGE_SIZE granules:

drivers/iommu/iommufd/io_pagetable.c:iopt_calculate_iova_alignment() {
	/* See batch_iommu_map_small() */
	if (iopt->disable_large_pages)
		new_iova_alignment =3D PAGE_SIZE;
	else
		new_iova_alignment =3D 1;
}

Later, iopt_gmem_map() derives iova from iopt_area_index_to_iova(area, inde=
x)
and passes it to batch_iommu_map_small(), which expects PAGE_SIZE alignment:

drivers/iommu/iommufd/pages.c:batch_iommu_map_small() {
	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
		WARN_ON(paddr % PAGE_SIZE || iova % PAGE_SIZE ||
			size % PAGE_SIZE);

	while (size) {
		rc =3D iommu_map(domain, iova, paddr, PAGE_SIZE, prot,
			       GFP_KERNEL_ACCOUNT);
}

This allows userspace to trigger the WARN_ON() in batch_iommu_map_small()
when CONFIG_IOMMUFD_TEST is enabled, or pass an unaligned iova with
PAGE_SIZE to iommu_map() during mapping or asynchronously in
iopt_gmem_update().

Also, in iopt_alloc_area_pages():

> @@ -289,6 +293,9 @@ static int iopt_alloc_area_pages(struct io_pagetable =
*iopt,
>  		case IOPT_ADDRESS_DMABUF:
>  			start =3D elm->start_byte + elm->pages->dmabuf.start;
>  			break;
> +		case IOPT_ADDRESS_GMEM:
> +			start =3D elm->start_byte + elm->pages->gmem.start;
> +			break;
>  		}
>  		rc =3D iopt_alloc_iova(iopt, dst_iova, start, length);

Because iopt_alloc_gmem_pages() sets pages->gmem.start =3D start without
subtracting start_byte (unlike iopt_alloc_file_pages() and
iopt_alloc_dmabuf_pages()), if an unaligned start is passed without
IOMMU_IOAS_MAP_FIXED_IOVA, start_byte is added twice here before
iopt_insert_area() rejects area->page_offset. Should iopt_alloc_gmem_pages()
reject unaligned start or strip start_byte up front?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027154649.9157=
1-1-griffoul@gmail.com?part=3D9
