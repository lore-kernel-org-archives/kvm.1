Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F56B377019;
	Tue, 23 Jun 2026 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174545; cv=none; b=IkL6vxwCfS4o9Kir5UfqtpAAbGEbUOmhGXOoGh/4dbXYdLfpDS55q9ZQrDkNRExCLBLSlgBiuZz4DR9PeMX8krcmU3Sq2ZWus9wU9oLWHkNmS0Aa8Stc2Enf1NlpoTCt+Ms8E42D/LAjB2l6hGmPZtvDcXzX9K2b8pQKqgUiyAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174545; c=relaxed/simple;
	bh=0dNsuqj2/M/DAp6kJZM9jT8x5imLFxi0V9qqMNhS9Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3cPkXKuqeAOCSUtoamNcUFHxca93HLlWiLJbNSrrT7TsrQozUoV/hOvP/taq3AoldQbrPDYPYL2sedfvQ8rrWvEYrFiX+QH2c3mRFnLVhUZRxwE3shyH3vDgDWSi/CTQs6qi6lr5Yex1pZ4+FK+VetIjzDYOa/tTFle1oBhaIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W44iws4S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W44iws4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDDD1F00A3A;
	Tue, 23 Jun 2026 00:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782174544;
	bh=OVUDYTnzLItVuk8jizRBbsnShs8QEiUHmGBBLjRQun0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W44iws4S/kVKzeO1KEnlcW6OVbNqETBfCiBGwEAhe1yFnF4KWSB7ut9JxWtWvkfMT
	 e246acgOHoLs9h5QKSa/G9Q+VrjARbDAC3WPJ1Kdx6meaeTuv20Yf47Gy2rMBxEtry
	 RTFe6285Iv06dYqoSv8dpkb78WjCky3QGDtNhrZ+NrwZeq+SgMsV1SLq7O4Ec6WxM/
	 z7zI3+u1a1Bjv9NvRbOBCSNpC/pdsaP/6/ymZH0BVEXfhhcZ/cCS5vXgpaq9MoAxjl
	 F81g20FCE3xmqszmqxMx1Upz/gPhTyhIFdSMyE0GgjG42bggB4w0xitKYU1EG3GdAE
	 +O+vSeVuPIScg==
Date: Tue, 23 Jun 2026 00:29:02 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Brendan Jackman <brendan.jackman@linux.dev>, 
	sashiko-reviews@lists.linux.dev, Brendan Jackman <jackmanb@google.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v2 06/13] KVM: VMX: Use higher-level allocator
Message-ID: <ajnTJ03IxVnBXWdp@google.com>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-6-31f31367d420@google.com>
 <20260622101056.4120C1F000E9@smtp.kernel.org>
 <DJFI4P57YE9X.20DPMTK9LL7LW@linux.dev>
 <ajm_dEqauYLBi-7T@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajm_dEqauYLBi-7T@google.com>

On Mon, Jun 22, 2026 at 04:04:20PM -0700, Sean Christopherson wrote:
> On Mon, Jun 22, 2026, Brendan Jackman wrote:
> > On Mon Jun 22, 2026 at 10:10 AM UTC, sashiko-bot wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > - [Medium] The commit message incorrectly states that `__alloc_pages_node()` allows passing `NUMA_NO_NODE`, while the opposite is true.
> > > --
> > >
> > > commit 7bd439c242125db27305b61b14c9972fb028282a
> > > Author: Brendan Jackman <jackmanb@google.com>
> > >
> > > KVM: VMX: Use higher-level allocator
> 
> While you're dealing with nits, can you massage the shortlog to something like:
> 
>   KVM: VMX: Use no-underscores API when allocating pages for a specific NUMA node
> 
> "Use higher-level allocator" is extremely vague, and arguably misleading because
> the "allocator" being used isn't changing.  Which is kinda the point: *nothing*
> is changing in practice.

Maybe "higher-level allocator API"?

no-underscores is just.. meh :P
