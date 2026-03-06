Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A2535E956;
	Fri,  6 Mar 2026 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795549; cv=none; b=KBI5lPI3g/OYf1n4/RdIro/oO8A5TvG8+cXEBGmILdePDzkvr3U9HUUcdC8OrsWa1oO9djrJt/O59MlnQK224ZpEV8SIyxPTyGDhz77NOoopPf7lvypelN4oLKyo8OX8JqqD5eseKpm8R+NeJFBSDRYH6Y5MVAz4QxugbQ/2s1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795549; c=relaxed/simple;
	bh=0Ke5eZ//15clBpSAjnQRnmOa0hryc2fy44XRrBa5OZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9SW5c/3GLYOxyLiuQXh8JlMRegK/94pnuKtPDuRbfng2JfX6oTdvls8AvjxgHDULPh9JDzcKhUYRi5HK49k0+xAf+MeuGdkYS89wkTHyI4lYYr3gQ+O4uiXbbzh16dNV7fww0+Nz8vXoDFbXocy8DnrJfySjRnsJonMe1CKSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEvdu6gn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEvdu6gn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3080C4CEF7;
	Fri,  6 Mar 2026 11:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772795549;
	bh=0Ke5eZ//15clBpSAjnQRnmOa0hryc2fy44XRrBa5OZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jEvdu6gnFrMR/jaM1eC2XOup9hwsvDUiBF11qNOw09xdkEyBBO9FAE9ams+odLwvd
	 33sBKFnJaUA+PNxEDQfpwSqHvWcGNBc4/7WW379CL92582oYijNtnOOELNIR6MKgyw
	 WP09l3vJL1R65yPpsXkejCBvIOx5CypvyWMn4ywh8jJKvKdQXERPnkBu5Fey7G/0J9
	 H7CGTyaXAEQcbhiBzD9f3vJCyhgVzdz3tDU/OErQ80gE4HJXgLniNvA4X8G6Sby6d8
	 cKW4Ximsknhlr+thYxHOXKZACMFOoz8Yw6/gYqkEXcSy9XnOMWPMmnb/hSRgpczViu
	 XJcuAdCXwXIcQ==
Date: Fri, 6 Mar 2026 11:12:26 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Subject: Re: [PATCH v1 4/4] KVM: PPC: remove hugetlb.h inclusion
Message-ID: <7d708a94-d25a-45cf-a49c-a86a6d1be753@lucifer.local>
References: <20260306101600.57355-1-david@kernel.org>
 <20260306101600.57355-5-david@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306101600.57355-5-david@kernel.org>

On Fri, Mar 06, 2026 at 11:16:00AM +0100, David Hildenbrand (Arm) wrote:
> hugetlb.h is no longer required now that we moved vma_kernel_pagesize()
> to mm.h.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

You've gone mega cute on this one too! <3

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  arch/powerpc/kvm/book3s_hv.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 08e5816fdd61..61dbeea317f3 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -36,7 +36,6 @@
>  #include <linux/gfp.h>
>  #include <linux/vmalloc.h>
>  #include <linux/highmem.h>
> -#include <linux/hugetlb.h>
>  #include <linux/kvm_irqfd.h>
>  #include <linux/irqbypass.h>
>  #include <linux/module.h>
> --
> 2.43.0
>

Cheers, Lorenzo
