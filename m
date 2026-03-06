Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5139350A08;
	Fri,  6 Mar 2026 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795522; cv=none; b=tIytOe4NjWVmQBBbXGEmPsikghc7BwVNY5hPhdYmxC2hiv2K7GT2TfetXzsZ0AyjrGgyUeKWS53csyA8KuR8YJ0K0RfEOKebl98Hp3QfivRoVWI+oNI/oRgmaHL52pbEK7e4wmXoEOv1PinIkhyQaqA6QBxgIrJ5yzEmAAYMyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795522; c=relaxed/simple;
	bh=bGQPv3hoIx+/WP2tckqxP1wfRPx3+N82EsJdtp7ro1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLJcNwlwSKeOnKHVHTUwZRhqpVtJQqWaqHGwxiWNNa/hUMFopdE3OTGxZRYyRn8idWloaBl35impT5rTLOqBqrowyTapjO7AdCypbJQchIbS1hUJ8yS1J1ISDR2JPlPix6ctXHNhTsVBoiSKN3AbrQ7MlH80NaMCfHjZx4l+CLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1xVmcrj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1xVmcrj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B95C4CEF7;
	Fri,  6 Mar 2026 11:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772795522;
	bh=bGQPv3hoIx+/WP2tckqxP1wfRPx3+N82EsJdtp7ro1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L1xVmcrjSvLrgHkDWnFdpLhM5EkUuQo+JVlT0s5xnLp0DAhNsaITOZnaG4LxedWQr
	 fCKye6WWvwjQVW5XxY+wXSRq71hWJ4Oa3nCqtZeOj3UhoHL9vVHdGltdaXAYIQ1gv0
	 nA3yeBt7hhdB5fBjhdof3Z89/pRwfjrW90qye5BkLJsXf64Clz7q85jQLUcgK1yFSJ
	 pZ+vLH5YL3wNFQq41/bYDmXr6vRVp4nErnsgvEtbJE2EIXYb/Xa667KN40IUeuNTOP
	 651FUjIHAXOlu6nk/elNWoGXSeoXUFvEC8dSMcL0jWA2bxXhZCOZA51MVNvylkSvRe
	 MnglMHCg34Nwg==
Date: Fri, 6 Mar 2026 11:11:59 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Subject: Re: [PATCH v1 3/4] KVM: remove hugetlb.h inclusion
Message-ID: <305a98f5-0a28-4eb9-a647-a30716e61cb4@lucifer.local>
References: <20260306101600.57355-1-david@kernel.org>
 <20260306101600.57355-4-david@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306101600.57355-4-david@kernel.org>

On Fri, Mar 06, 2026 at 11:15:59AM +0100, David Hildenbrand (Arm) wrote:
> hugetlb.h is no longer required now that we moved vma_kernel_pagesize()
> to mm.h.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Aww this is the tiniest cutest patch evah!

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  virt/kvm/kvm_main.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 22f8a672e1fd..58059648b881 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -41,7 +41,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/compat.h>
>  #include <linux/srcu.h>
> -#include <linux/hugetlb.h>
>  #include <linux/slab.h>
>  #include <linux/sort.h>
>  #include <linux/bsearch.h>
> --
> 2.43.0
>

Cheers, Lorenzo
