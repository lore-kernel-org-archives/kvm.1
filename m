Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C0636C0CF;
	Fri, 20 Mar 2026 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041562; cv=none; b=B1R6j4ekl5pZKuCYszfIvuLwSyufwS1LSc/ah+gW47MjhDmeuUHwXRT1mbpUhgKb5EfVhMHss1kRk1rHDLAB6p5y+T2grQ1/BLgpWEAdiW9IAldf0i9ZUPquFU7Caha5iyWV8W6MvWucXdSZ+wi35zziO6dVsDU3Hg4lzt8RUh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041562; c=relaxed/simple;
	bh=baU0Dmv6xJhr7fEMpX6YuIpL/2bUzFVq2HtdDqeVB3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+kBj8lLwJZvyAAdenv8TGJ51bgux3f+Q7jIAqdORD71FEYwXzVP2yYeXeGiAX0kaKxdtqXjwMCa6bsl6x4Jxpkkw0RXOh9eQG8ww0t6rihfUlpTDql8/bZv3XdVdSQFD8nhMIglW2SlLKuj7aGLxlpyphprqhZ0SCIXwbLjPf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=QDekB95v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mNUjVYCU; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="QDekB95v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mNUjVYCU"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0A85E1400276;
	Fri, 20 Mar 2026 17:19:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 20 Mar 2026 17:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774041555;
	 x=1774127955; bh=ahTXUm431jw56FmmBnpl09lQjs/qOnN/i1iPZuzV6wc=; b=
	QDekB95v2yI1gqIiM6tcl5REAjnGACu36r8SPQ9VB2FHRJ4IZCoUdpAjvo87mzRP
	j4wHFL9PUG6lmG2gtwv41NF7eqqiRn6FjNK55giRvYgF1mvInPCn0eYfEyNjATY8
	kTOWShq6RLbFbqg+oPnIpUvi6b9aPSZ9d7MHAtrMzivxhALecvM62fs3dTeJ7vR1
	yEhgu2E6QEP/L2ihx2T+bg/InqdUYI91FKJbhMusPw7OpZnYtkZi6H6EivU033WK
	inyAc+YCC8Qsnv98troHibIOChk7E40qFbb/mATxonun/Su2h2LfhYr4zC4X/ZSg
	eSp46tkxwN2Gb0EUjLJYbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774041555; x=
	1774127955; bh=ahTXUm431jw56FmmBnpl09lQjs/qOnN/i1iPZuzV6wc=; b=m
	NUjVYCUQGxfc045qfZtGoiUSQfx4j4JKXja9q+MskeSDFtElky2X1/7RwVLKOLFV
	ZCX5Rn/700NtRFWcBv9Ee5GFntdq1WpCqDzlNZFaga+2a5jcS3jv9aWhgkTPczT1
	gntEPDro8cyKhym9UEOYxxpLFMTcDbIC/w7OrCAr16rU3DyRm6rzzSYtPw+7Gz7i
	XZaJ1g0R105W51w8g3nnV9XZb/G9KZRlwpx4KJD981iyc81jvDKhKhJrd380OND1
	q1QcLMuvSFy2q3zXKiWItJ0sMH2pSziVGW3P3pABNhVJw2gyKpjzRhBVImlfIQ6V
	fIPR3eJD+60RgV2RpOMWg==
X-ME-Sender: <xms:0rm9aRVNwX9DO8rsGhTa2h2nqX4XzQn9FOvvp_BQwUi18JNxt5q9yw>
    <xme:0rm9aboPOKh0HvTHjr4RNtS3XOAqu2tYMcdUb8zB6ge3DQXqWLR77HsH8Sp4U1S4F
    wk3dkknjKzmxYj_c2Rf3zdR_7zMtv5HAkgLFSZWSIlEI8fH_K1rog>
X-ME-Received: <xmr:0rm9adQpUj0uXHqnSx3-JftieeJkXmLNiuv49fLUBNFh-gxTWXUFkTtP9a0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghmrghsthhrohesfhgsrdgtohhmpdhrtghpthhtoh
    epughmrghtlhgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehshhhurghhsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhgvgiesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:0rm9aV1CaeO78IpE6doFjl_KyjdKbtq7t1tZE91NWnK2Udh9Gq49WQ>
    <xmx:0rm9aZCNuczNzEw6gARYruSo60l1bBDmUOATsM9us2B3r5p6_kqkfw>
    <xmx:0rm9aRjE2bUf75CrnvpH4h5tMuO6wlZv8GxKBqbW7gEOuOTxLNOJfg>
    <xmx:0rm9abOcRNJAz1dLM9JBJak1rdawMXHXSuxbMd-4JeFBH-0u9wpmGg>
    <xmx:07m9aSkZhDE2uYfCuUQwMGleACxCUyFGHgbw4YYAryVsJu15ORdyKrBn>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 17:19:14 -0400 (EDT)
Date: Fri, 20 Mar 2026 15:18:19 -0600
From: Alex Williamson <alex@shazbot.org>
To: Alex Mastro <amastro@fb.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH] vfio: selftests: fix crash in
 vfio_dma_mapping_mmio_test
Message-ID: <20260320151819.36bc13b1@shazbot.org>
In-Reply-To: <20260303-fix-mmio-test-v1-1-78b4a9e46a4e@fb.com>
References: <20260303-fix-mmio-test-v1-1-78b4a9e46a4e@fb.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Mar 2026 11:46:24 -0800
Alex Mastro <amastro@fb.com> wrote:

> Remove the __iommu_unmap() call on a region that was never mapped.
> When __iommu_map() fails (expected for MMIO vaddrs in non-VFIO
> modes), the region is not added to the dma_regions list, leaving its
> list_head zero-initialized. If the unmap ioctl returns success,
> __iommu_unmap() calls list_del_init() on this zeroed node and crashes.
> 
> This fixes the iommufd_compat_type1 and iommufd_compat_type1v2
> test variants.
> 
> Fixes: 080723f4d4c3 ("vfio: selftests: Add vfio_dma_mapping_mmio_test")
> Signed-off-by: Alex Mastro <amastro@fb.com>
> ---
> The bug was missed because the test was originally run against a kernel
> without commit afb47765f923 ("iommufd: Make vfio_compat's unmap succeed
> if the range is already empty"). Without that fix, the unmap ioctl
> returned -ENOENT, taking the early return before list_del_init().
> ---
>  tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
> index 957a89ce7b3a..d7f25ef77671 100644
> --- a/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
> @@ -100,7 +100,6 @@ static void do_mmio_map_test(struct iommu *iommu,
>  		iommu_unmap(iommu, &region);
>  	} else {
>  		VFIO_ASSERT_NE(__iommu_map(iommu, &region), 0);
> -		VFIO_ASSERT_NE(__iommu_unmap(iommu, &region, NULL), 0);
>  	}
>  }
>  
> 
> ---
> base-commit: 96ca4caf9066f5ebd35b561a521af588a8eb0215
> change-id: 20260303-fix-mmio-test-d3bd688105f3

Applied to vfio next branch for v7.1.  Thanks,

Alex
