Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DB93016FD;
	Mon,  1 Dec 2025 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582308; cv=none; b=ftArw/nSpytJe+QpMeSaz9jfj6nMdeuWTHSD+fuekY6q1Sd84lprXc0z9nKCCeoXtTNYhSFWRpTW7EIAjekotlv3Ir4mua//cjBcLYHigoSWuULp/K8hsM2SwWJrnDBJv8unvyO6FkWlp4kzyVi+4TOduAFdt2rREM7ZJB7N3hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582308; c=relaxed/simple;
	bh=rdtCxxB5s1rRp0qlqZHRr7DJ+FojzBoesEnYtkJmFIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcDHu9Gg9IN27yB+RsPLcThUJtOtyQMOJoKcV9iOPpBwajI957HFOI+pqW3Ia3xfyKieqlbZajmJLHtSmlNKck6jWIqbf4GfVYcHPup5fNAPK8q7rj28cWBtsnuLdyokHKwfXqa6vjWx50vSse88fRl0sGaHV6MOMOqRwNFvJQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1vQ0Sn-0002g6-00; Mon, 01 Dec 2025 10:44:57 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 50392C088F; Mon,  1 Dec 2025 10:43:53 +0100 (CET)
Date: Mon, 1 Dec 2025 10:43:53 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Yury Norov <yury.norov@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: kvm: simplify kvm_mips_deliver_interrupts()
Message-ID: <aS1jWTUu9SDEoF2g@alpha.franken.de>
References: <20250716172918.26468-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716172918.26468-1-yury.norov@gmail.com>

On Wed, Jul 16, 2025 at 01:29:17PM -0400, Yury Norov wrote:
> The function opencodes for_each_set_bit() macro, which makes it bulky.
> Using the proper API makes all the housekeeping code go away.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/mips/kvm/interrupt.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
