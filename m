Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E04C3CB2E1;
	Mon,  9 Mar 2026 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063872; cv=none; b=MLnv2fG1YSX4+6T0eoMNh9NkOGi8dLFqZlSUNz8Ckznbav0NqQ7d3+NyeRuJZ5fYShjYnJmK/sCmFugi2QHtHhlVA62XLnSyJzd8YMuc0yBNemrqhNTJ9pDck8xNTxJeWBbSk4GYLmCrCFjIB10i3OfxzHQ/LyVjS7rjVyrOUJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063872; c=relaxed/simple;
	bh=uff3YTCVgqsL1iOsrMf8mkfHZ5TV2mh1epm2NrmtkBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ryh5THEXYuoliCWKNikP+8ciKRwhUD9/VEmBbrR6DugiqZqv1tMfivobrFoQmXj/ki0k0qEjCJm3ICCuYTxAq6SL5hzV+jjZtdq6NfHZhMST6IO0R8C1nDq7pKMQdJZE4W68rgQXbRnA6FEb3rQ6v5pJrjJVmPm8Dz8J6QqoCdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktkuMurA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktkuMurA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0E8C4CEF7;
	Mon,  9 Mar 2026 13:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773063871;
	bh=uff3YTCVgqsL1iOsrMf8mkfHZ5TV2mh1epm2NrmtkBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktkuMurADMf50LRwnbfN1+AJYnRdWEKFnD0sMhwDV9Qk044EpO1RsQJsCoizrusOH
	 29xj82RiF2RGwBmdLo0pT1VS7qJ3vVYUADrzug3p/vxCwbDuYsVlwT/lBGSbDErk6i
	 jQQ7gSkUXIIKvzOHZvXIfbiAnGOw0RzQuf5WfliG+/4nCwo0/ZTHFwAxYz7AVV9zfS
	 cytQdTnyw2vmLaFn52/q2fbpgQx2Xo/cj564DX6jwd7rYX7iewz6O+qlDY4gqp3XCw
	 y+PT9/CRU6M4iy9jhNd7YbUOjYayHZY8BYlakH7GFo0MVgJRM/PgAPyZ4xzCMcAdOE
	 WqUuFknTpY37Q==
Date: Mon, 9 Mar 2026 13:44:27 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 1/4] mm: move vma_kernel_pagesize() from hugetlb to
 mm.h
Message-ID: <27d52c59-e68f-4369-b133-4db71e1de0c6@lucifer.local>
References: <20260306101600.57355-1-david@kernel.org>
 <20260306101600.57355-2-david@kernel.org>
 <833950ef-e01d-4914-b5f9-bc1f6261b184@lucifer.local>
 <729e14d4-6949-4d46-9380-12331b5ad363@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <729e14d4-6949-4d46-9380-12331b5ad363@kernel.org>

On Fri, Mar 06, 2026 at 02:25:51PM +0100, David Hildenbrand (Arm) wrote:
> On 3/6/26 12:07, Lorenzo Stoakes (Oracle) wrote:
> > On Fri, Mar 06, 2026 at 11:15:57AM +0100, David Hildenbrand (Arm) wrote:
> >> In the past, only hugetlb had special "vma_kernel_pagesize()"
> >> requirements, so it provided its own implementation.
> >>
> >> In commit 05ea88608d4e ("mm, hugetlbfs: introduce ->pagesize() to
> >> vm_operations_struct") we generalized that approach by providing a
> >> vm_ops->pagesize() callback to be used by device-dax.
> >>
> >> Once device-dax started using that callback in commit c1d53b92b95c
> >> ("device-dax: implement ->pagesize() for smaps to report MMUPageSize")
> >> it was missed that CONFIG_DEV_DAX does not depend on hugetlb support.
> >>
> >> So building a kernel with CONFIG_DEV_DAX but without CONFIG_HUGETLBFS
> >> would not pick up that value.
> >>
> >> Fix it by moving vma_kernel_pagesize() to mm.h, providing only a single
> >> implementation. While at it, improve the kerneldoc a bit.
> >>
> >> Ideally, we'd move vma_mmu_pagesize() as well to the header. However,
> >> its __weak symbol might be overwritten by a PPC variant in hugetlb code.
> >> So let's leave it in there for now, as it really only matters for some
> >> hugetlb oddities.
> >>
> >> This was found by code inspection.
> >>
> >> Fixes: c1d53b92b95c ("device-dax: implement ->pagesize() for smaps to report MMUPageSize")
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >
> > LGTM, but you need to fix up VMA tests, I attach a patch below to do this. Will
> > this resolved:
>
> Thanks!
>
> I assume that should go into patch #2 instead?

(Sorry missed this on first reply)

It doesn't matter too much from compilation point of view but thought it made
more sense as this is where you pull vma_kernel_pagesize() in? But I'm fine with
either!

Cheers, Lorenzo
