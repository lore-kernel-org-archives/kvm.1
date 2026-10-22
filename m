Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671079;
	b=P9ILKI1/jcOuLpzbNsD4vZkzy/hytCv44mNtckVDzApk9AAIRoFZru3d51L303xJTVsP
	 3gvrfFU5b7YvWntDUGXBX/8fhIukB4WJ7YmHyU0gv5K6yywErf9qz+hZx6HOCMUdDQHSQ
	 7UpdtT1g45O7RHbQMxOagyU7n6e/78ZDI/2JckVL2LnBhhPoCAgsXfSy4PboUAv/VIE0H
	 Rp9rwdC880dYIoHUbQQG4kfrEp4MX0kjREvVQS7LUDq3rtKK0htD4fe/zZn15WLdVZHk3
	 QTu7LCaMfWPFIYM87uFIRgJLNY4ltadiFanTqeI9sRQsukTssAMW2lfPbvdPrQI6KDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671079;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=R45se70P3EMmhMkKtYLGOoSJA2q332w3U9R9/qm3AvU=;
	b=V9BeVQuiBEN1NCMtLboaSVoyMJf3xRNTlj6KwlalcKrUMW/msBC3dSx0ATXipfjlkfhr
	 wA10peAd0ylm43eXZX01pwlc6KZzZJWfPcdMYlxOxJZ94bCd+zAEMobJONuTUswc4AQkh
	 Nx+NcaNk63H1HMHRveeQPErs+ObICgo9nRI1pNTH97xlbtbPvPleGSWBfr9SEfR5oPI+k
	 iGdD7P3b3s+Jk9sOsUTFu9jbXgPNMwNOMKmX8L3MYfI+OGt6KNhEEtbGH17R2Ihtaqk6Z
	 Xj/V4SQ7gnrvaTY2sbAb5xPdubdOHBRN76uzP8BnEpuT2p1GhNzoHpUaAecLZVM6FIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAUOmnUw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD93606A319;
	Thu, 22 Oct 2026 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAUOmnUw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5AD1F000C1;
	Thu, 22 Oct 2026 12:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792671079;
	bh=R45se70P3EMmhMkKtYLGOoSJA2q332w3U9R9/qm3AvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dAUOmnUwYmXnqjnb7xpvzxZUOGMYgicvXndxs7prGd8mnPM1HRCMzBTCy5Wqgajt0
	 7ydupNhuB0KEpvBHR5rfrH5IvHMKVlKDABORylIiEdm8FrF1lNL770+I6n0iaPeAVl
	 YC1M6XYdYp6OHunXm7cWdAcaU2dlpD3/998uXguRKcEj5GyZBrTEdi5TpuzW9WUY6V
	 uR+cGqMYiHlpxwrDQC84R50dPT0QbaRbkx4eFfEHe0Fx1GsqR0lASPJUmBltm4xaIO
	 vLuGnuxQA7/bhka5CHm5PNZw6Q7Lk2fsakVxVTvA/ssGxs5iP3VkeQW16AkZtzvLOY
	 hPwMuhCsUC5Uw==
Date: Thu, 22 Oct 2026 13:11:11 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Peter Xu <peterx@redhat.com>, 
	Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	=?utf-8?B?TG/Dr2M=?= Molinari <loic.molinari@collabora.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 1/4] mm/rmap: duplicate a PMD mapping as one in
 folio_dup_file_rmap_pmd()
Message-ID: <atn3SPG5MKpj2Unj@gremlin>
References: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
 <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-1-66f00b7a564c@virtuozzo.com>
 <atnEFyGRYGGf9shA@gremlin>
 <71101695-339d-4f8f-b9d8-dfadf7dbd0ed@virtuozzo.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71101695-339d-4f8f-b9d8-dfadf7dbd0ed@virtuozzo.com>

On Thu, Oct 22, 2026 at 12:44:40PM +0200, Konstantin Khorenko wrote:
> On 10/22/26 10:07, Lorenzo Stoakes (ARM) wrote:
> >> Fixes: d8ef5e311d7b ("mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()")
>
> > Was this a mistake in d8ef5e311d7b, or actually intentional for whatever reason?
> > If the latter this shouldn't be a fixes.
>
> commit d8ef5e311d7bfde54b60ab45026f206eff31b2d2
>
>     mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()
>
> ...
> +static inline void folio_dup_file_rmap_ptes(struct folio *folio,
> +               struct page *page, int nr_pages)
> +{
> +       __folio_dup_file_rmap(folio, page, nr_pages, RMAP_LEVEL_PTE);
> +}
>
> ...
> +static inline void folio_dup_file_rmap_pmd(struct folio *folio,
> +               struct page *page)
> +{
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       __folio_dup_file_rmap(folio, page, HPAGE_PMD_NR, RMAP_LEVEL_PTE);
> +#else
> +       WARN_ON_ONCE(true);
> +#endif
> +}

OK so it was just wrong at the time :)

>
> Both functions were introduced in a single commit, i think it's a simple copy-paste issue.
>
> The helper never had a caller, so nobody could hit it. If you prefer, I
> can drop the Fixes tag and only mention d8ef5e311d7b in the changelog, as
> there is nothing to backport.

I mean, it seems like a bug to me? If there's no harm in backporting it I think you
should add Cc: stable@vger.kernel.org in that case actually.

--
Cheers, Lorenzo
