Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA77283FE5
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 22:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170120; cv=none; b=XgO4xZ9LhXJ8GTLxg08i1ob9aQ4b4Zah5h+uOk3yZyJeegDtgZP+BelUH/hGvo1ZPWceb2zeqST7agWQN1luy9+uN33BnI4WNakXXjDVxzTNs52rAVBbA8nxDZA/ZrR2EWohk6Pbv51tXs0jMJ6pfO0y6Ch/Xhmg2BCi3ag7Qa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170120; c=relaxed/simple;
	bh=1EzzDduWEFqymsRBJbY5RhdXSfv7g6cDY0SmpQfH8X8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=q2RiAIb4dG+lXxkG9+p45lnHGM3IOPpUJWLljZ+Zw+7/TFIYlJwOnClOcDDn0uMpULS9YJfDjQ4XthmOd8+p1B+iL6sPUhWOxa+xC3L5oVhkAcQWxZ+OSOJwmVwuSWZnngbKbA1FGI6TAflcSsT62+Ed+P03/8k3CI9Fi2FCfGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4Uhn7zH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4Uhn7zH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BA8C116C6;
	Thu,  2 Apr 2026 22:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775170119;
	bh=1EzzDduWEFqymsRBJbY5RhdXSfv7g6cDY0SmpQfH8X8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=n4Uhn7zHfBrrJJZshYM3N1hNIjGs16uAQJwLNXt4X9pDdLzrB+jf4Fe6dM9KqTjVk
	 MDJwLTfCbv0IdfczfcpEfpIey/B5pJjndp/Nfv8yy/jsd4K45SvdQUC8CQ/XU2LMqw
	 wd7ARtNJNZSwYU5Apjs+xBCMiulldzbZIelboPn2f5yIFJ2le6iK/sIaM97/fgOuLU
	 uNHKRZs3/633Wxb2HdWt6rZwNb7i/QRkJIgnp8HQ/1fkBP1ekMfCm7jXohJavBCxMN
	 a4ZMocwi3fkZGDW6WDTTSyNCIaSmceryoLYCULzxn8iaWhq0aEVJr9QySoqgPoPFTD
	 HR6psiXzI/qXA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 954A4F40086;
	Thu,  2 Apr 2026 18:48:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 02 Apr 2026 18:48:38 -0400
X-ME-Sender: <xms:RvLOaX47WS4sAboNNLfzB-6oejnTC5ITbJhme8zJnhjpERDmLFt_Ig>
    <xme:RvLOacWsAB96sJEm0WRzV8GbokJYuoi_uyTe292wApLHlWi6uVZXpdb3F32iEzetw
    7enzAWA-K7TRoZSguJ5RFN84elnhqQ7-KCGlTxMzSg3WU6A1dpxRNw>
X-ME-Received: <xmr:RvLOafiSSX7ZEr39C-nrWOhhwBKL3VTP2C1tCmZLa60fIRWUAPcRQYjIA2NDVW5VVmnMeu025Pm6DgElcE_j-t0F8fpDu6RA1p8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevkfgjfhfugggtgfesthejredttddtjeenucfhrhhomhepffgrnhcuhghilhhl
    ihgrmhhsuceoughjsgifsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    dvteegfffhfedtffduhedtgfffjeelfeffhfevhfejjeefkeffudfgvdeivdfgnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegujhgsfidomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqudejjedvfedtgeehhedqfeeffeelgedtgeejqdgujhgsfieppehkvghrnhgvlh
    drohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedugedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohephihilhhunhdrgihusehlihhnuhigrdhinhhtvg
    hlrdgtohhmpdhrtghpthhtoheptghhrghordhgrghosehinhhtvghlrdgtohhmpdhrtghp
    thhtohepuggrvhgvrdhjihgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepsggroh
    hluhdrlhhusehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephihilhhunhdr
    gihusehinhhtvghlrdgtohhmpdhrtghpthhtohepiihhvghniihhohhnghdrughurghnse
    hinhhtvghlrdgtohhmpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrihgtkhdrphdrvggughgvtghomhgsvgesihhnthgvlhdrtghomh
    dprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:RvLOacfWqJ8bE8pwtpWvrklrtfzQeODyhOwpQsgH576TyjRVXWcikQ>
    <xmx:RvLOae2sMZ40I4Z2ZGNVXrwkZ0GMYxDt2stuDfCbe-EvJevOhPwP-g>
    <xmx:RvLOaYpekUOIha95qKmoCAOhJXw1Oo4tDhMYbitRUctjjVztDc-Grg>
    <xmx:RvLOaWhHuE3WT0t_t0xVhv1bwvgigaD5ZO8ED0ffqrZ9lYPPzmiK8A>
    <xmx:RvLOack2MV-nQZW0ez9eEtARUOy62wQOgDFDjWqNUZvQKtZuxuDt5WKM>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 18:48:38 -0400 (EDT)
Date: Thu, 02 Apr 2026 15:48:36 -0700
From: Dan Williams <djbw@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: chao.gao@intel.com, 
 dave.jiang@intel.com, 
 baolu.lu@linux.intel.com, 
 yilun.xu@linux.intel.com, 
 yilun.xu@intel.com, 
 zhenzhong.duan@intel.com, 
 kvm@vger.kernel.org, 
 rick.p.edgecombe@intel.com, 
 dave.hansen@linux.intel.com, 
 kas@kernel.org, 
 xiaoyao.li@intel.com, 
 vishal.l.verma@intel.com, 
 linux-kernel@vger.kernel.org
Message-ID: <69cef244d7c91_55682100ed@djbw-dev.notmuch>
In-Reply-To: <20260327160132.2946114-15-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-15-yilun.xu@linux.intel.com>
Subject: Re: [PATCH v2 14/31] PCI/TSM: Report active IDE streams per host
 bridge
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xu Yilun wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> The first attempt at an ABI for this failed to account for naming
> collisions across host bridges:
> 
> Commit a4438f06b1db ("PCI/TSM: Report active IDE streams")
> 
> Revive this ABI with a per host bridge link that appears at first stream
> creation for a given host bridge and disappears after the last stream is
> removed.
> 
> For systems with many host bridge objects it allows:
> 
>     ls /sys/class/tsm/tsmN/pci*/stream*
> 
> ...to find all the host bridges with active streams without first iterating
> over all host bridges. Yilun notes that is handy to have this short cut [1]
> and from an administrator perspective it helps with inventory for
> constrained stream resources.
> 
> Link: http://lore.kernel.org/aXLtILY85oMU5qlb@yilunxu-OptiPlex-7050 [1]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Oh, looks like I had yet to get this reviewed on the list. Can I add
your review and / or test tags and take this for v7.1?
