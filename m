Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7C13A453D;
	Tue, 17 Mar 2026 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741586; cv=none; b=oaubnnqSIT/hGC47JvqwCnC7Zmt3q6gn2wmhQ78/4FYOA6fek0mwKGpGatTtXsim7Rs2xUinf3A/j1fKdeUYSoyPqaQmEvzRNp2q+5nmluvtnZqIYU2KmiRm9LY1esylK11sC6+D5FJW6GVuTfgsEznkUogHu7ADMJcseAFf9Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741586; c=relaxed/simple;
	bh=g+eVOdZ0kolpTp6/DP6Ef5qnXsjhXJ7Y16PIYKPOiPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiacTTwg2Is/KZWE/VudlwYVmO5FhEm/+59c2WJ+XZUW0CuDDH/ALFyS36qz07cM0glSew5UKB3J4s5Dgk31DhhvyzLvkedlEp4KIrZnEc5e53FXi8nxRs51cAigm/h07APoOE4sceK610VhTfn39THWfi1GjT86pcNUn2BM86k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c20xy5UU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c20xy5UU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89773C4AF09;
	Tue, 17 Mar 2026 09:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773741585;
	bh=g+eVOdZ0kolpTp6/DP6Ef5qnXsjhXJ7Y16PIYKPOiPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c20xy5UUaIfPZ1Ke3YN0STfQuFoB65IQh6+L/nmlBGimw6YqXrd0DUbMeDU30mrSo
	 L3zev1cHWGmer+3bx1aP6UCb0YImGm9cdMj+EPkKfMaak/MAiAaZvc+vq5BYfCvFwM
	 lTSw6dyVsCO0/3fqU6EQHq6rTLaDpXC9htLdqrpt7Df32LXh2/ztPzQ3KMjxM5l+cI
	 zE7VYHOM9kzA2FX95+Ba6Ctum31TLD5h0UyAvh6c/5atjTprXqbGz1/OVfWpNpYNow
	 V4kTjnb1w6vh0HiVWpjKpNXpil53PhJTy2ed77TvXHkgmBz8deCaESXW8ssQKcCiBe
	 yFV6OxNPGgLxg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id A6F3AF40069;
	Tue, 17 Mar 2026 05:59:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 17 Mar 2026 05:59:43 -0400
X-ME-Sender: <xms:Dya5ac3ag53eqI3ckiY5bHhrAfp_zuvUlfQ9_NkVmtcpZxz-zac8Jg>
    <xme:Dya5aVmBSZDDNJRPCP-3how_yvqPkjgGI35QeLb4CIUKUZYV7cQLcqnRbtjAqt8dZ
    Ixl85gOX8HX4-v92jBrqUENrQtXSIcxztxYSWzbSdc4-oxDw4S2R0Q>
X-ME-Received: <xmr:Dya5afsv_ujFkAPAaIeYiA9kznp-qN3_NP4K2kSd94xwqWtLNBjRpmdzbzd8Cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeltddufedvffevueehteevheffveduvdduveeigfetueefudekfeetheefgedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkh
    gvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeh
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrghordhgrghosehinhhtvg
    hlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghotghosehlihhsthhsrdhlihhnuh
    igrdguvghvpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegsihhnsghinhdrfihusehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpth
    htohepuggrnhdrjhdrfihilhhlihgrmhhssehinhhtvghlrdgtohhmpdhrtghpthhtohep
    uggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhope
    hirhgrrdifvghinhihsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhgrihdrhhhurghn
    ghesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:Dya5acB7MF7xwCSYx2TnTXCHXbm7mUm8B18kDIMoECCyaPaz4HYL4g>
    <xmx:Dya5aak5GGp95bgPvoknIi4CIAE3joOszdxSmdgOhLwqKbQo3mm_CA>
    <xmx:Dya5aVgdiTzsrO1BLeG3IlXufOGEJTXmrpimD0nhJgM5zPkIgo76aA>
    <xmx:Dya5aTucMEpU3-hjvgSxqmC18sLZd7FbJrM8VNJff6Jl3XXodMLSqA>
    <xmx:Dya5acBm7C5Ox-L3OKBRI9CqMuDmjhiAYLeE7ebridK1VAM4MEDP9Ej5>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 05:59:42 -0400 (EDT)
Date: Tue, 17 Mar 2026 09:59:36 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, binbin.wu@linux.intel.com, dan.j.williams@intel.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com, Farrah Chen <farrah.chen@intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 04/22] x86/virt/seamldr: Introduce a wrapper for
 P-SEAMLDR SEAMCALLs
Message-ID: <abklvxoqJfFtATkF@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-5-chao.gao@intel.com>
 <abf-3xRg7ouZw-F4@thinkstation>
 <abijs4Ij97L4Rp9E@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abijs4Ij97L4Rp9E@intel.com>

On Tue, Mar 17, 2026 at 08:43:31AM +0800, Chao Gao wrote:
> >> +/*
> >> + * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
> >> + * interact with P-SEAMLDR simultaneously. Use raw version as the calls can
> >> + * be made with interrupts disabled.
> >
> >Hm. I am not sure how it explains use of raw_spinlock. What's wrong with
> >using plain spinlock with interrupts disabled?
> 
> We mustn't acquire sleeping lock with interrupts disabled. in RT kernel, a plain
> spinlock becomes a sleeping lock.
> 
> The lock doc [*] states:
>   On PREEMPT_RT kernels, these lock types are converted to sleeping locks:
>   local_lock
>   spinlock_t
>   rwlock_t
> 
> *:https://docs.kernel.org/locking/locktypes.html
> 
> and also see the test I did:
> 
>   https://lore.kernel.org/kvm/abPEit+Ckeqmypv+@intel.com/
> 
> How about:
> 
> /*
>  * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
>  * interact with P-SEAMLDR simultaneously. Use raw version as the calls can
>  * be made with interrupts disabled, where plain spinlocks are prohibited in
>  * PREEMPT_RT kernels as they become sleeping locks.
>  */

Looks better. Thanks for the explanation.

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
