Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56833D3CF6;
	Thu, 19 Mar 2026 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931081; cv=none; b=rAX3tGlqpYTM3v1WbMDoDykawJPMsRdSFGInB4i+jWevUJMFLiFFi+T56KlPs6QcpnrzjpDvsEMyvT+PA27zMUto3mkMkS+nD1E/1Eib2BNkb5hyjnQ7lcrzptq68/TJO147Ji4fYt8ZlwepK9viVbC0kYFb2cfhtSAp/YacEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931081; c=relaxed/simple;
	bh=dLL4T4AsWeRRcTT8C8DlpHTVVAA4pAr3Ee/mY1wd3og=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qvwCAsQ9wnFee0gCmgytEB3IimLEPtg/ZbNwGL9kuOJd4NwbHemlUF6M2MUADBSsjXuhpj6bD1hEzlt6p4MP4y7xbP657KmY8UygIZNATm2XIrdfKEw1qW5ZECQv/RoQPYwUimTqSjAq68b+TSIw8HmunVNGDmgmsr4XsVFpDVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Qs/73dgF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=adc+zojt; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Qs/73dgF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="adc+zojt"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AB65D1400143;
	Thu, 19 Mar 2026 10:37:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 10:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773931078;
	 x=1774017478; bh=BIIQ4TBdnqXq3eiGG2xVsD6/52sHGx009ooGi07Zwn4=; b=
	Qs/73dgF+FI35+9otjAo8hbMBIh0u6diQ6x5Uffltn7p/uW9m8G1m9JhHP2ycy0q
	LNV4Sj3iukh7fUYeyeiENNcx+zI8bXuThoI8fORKRQsazN+3i0aJmRYZcpeJ2JFk
	bXUqt++nXW9+2xRZKDoanjGNdqe0MMkAELnPDMemQGqsBqq2hY56eppkMJJv6nfR
	I0F0AL8uixBwGfLbn0A26f9sbpEZHDqrwiEXb/mi7kOzczjDRf0Nbqm70Jj1oK85
	ePYaykXzisuO7Z9cJ4ch6OvVFYLBLzeLaMWTN3SSHEUE42EaPoIlg1ofMCfQ0x4w
	8b8jaxhncuACwHFySPmTCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773931078; x=
	1774017478; bh=BIIQ4TBdnqXq3eiGG2xVsD6/52sHGx009ooGi07Zwn4=; b=a
	dc+zojtJHxZ2PmNz7m0D4qaQO3UkTI4aVx2CIsgCWkfnSixHsRsIglw9B5MOq4Bm
	pDSSf4gtMMTBvwIHvdklY13Djw9OhZMvyHH4wAR/nwc1vgY6iowLI37PbhKdbet+
	yJLkDPVJ44ICyt2OxE2prnKwOP2G+0Hjua8tf73MusEZVK6q6giEWtzIoX2wNE96
	ObtHGfOrPJgSo64rKE54kUQjg133aTlrtGAVI0yXnoM6poiSIiLlekVi7Sio7Hmf
	ViSc2lYsRfKny/9EzXJeV3NoswV2nzItOSsKiGNElKzZOVxdZglfd1xkgtikCZTL
	F5o9qe8SRda1yrzbJ4zCA==
X-ME-Sender: <xms:Rgq8aRVGlAOICkMHo5JD78mWhUgJ5p0NaPOTD1h916jB5_hzYpWz3w>
    <xme:Rgq8admyLG8G0Pwy0mgv9hTEe2z3uQ5erUj3MpJ3yNSGjOC4rgY31TvXuucSqO4d_
    MwyXmQiw8FN8frdgviq-YONpco3S_QK-sYmjmiAxgN9zfvqj36VEQ>
X-ME-Received: <xmr:Rgq8aflshg_eG-mAiyvWlSmsMPAYCEsCGnhJ6ZtDF1nBFu81RRV7YoPftuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheejieetffefueeiteejtdejffdvleelvdeuvdffvdefteeghfevkeeu
    vdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrg
    htthgvvhesmhgvthgrrdgtohhmpdhrtghpthhtohepthgvughlohhgrghnsehfsgdrtgho
    mhdprhgtphhtthhopegumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhvmhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigsehshhgriigsohhtrd
    horhhg
X-ME-Proxy: <xmx:Rgq8aVb8Y_j-6dST6HU47aalPOsPj7WDzLhVXDSFOA_9aUq54sxbNA>
    <xmx:Rgq8aZSJrVEOBVpbqMNvEl5WIlrt-ahscMi8MX5jdYdfSBYDv-maPw>
    <xmx:Rgq8aXtBe-rmEZXg8PZWauLhOW52padUbY_6YhovkWsA78Td-aRJBw>
    <xmx:Rgq8aTGTMxxSOK8-aDRRUu8LzGrjBG_pjCYpdmjAfLCWL7NYQK2mdg>
    <xmx:Rgq8aTSp5QTLm6s8HUZ17l2ixwxY5UDqU_Bk1BCBazs6mnzJZ9YFhepK>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 10:37:57 -0400 (EDT)
Date: Thu, 19 Mar 2026 08:37:56 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <mattev@meta.com>
Cc: Ted Logan <tedlogan@fb.com>, David Matlack <dmatlack@google.com>, Shuah
 Khan <shuah@kernel.org>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex@shazbot.org
Subject: Re: [PATCH] vfio: selftests: Build tests on aarch64
Message-ID: <20260319083756.34d02e1e@shazbot.org>
In-Reply-To: <0cb46c4d-90aa-4ef3-9098-9c5554714982@meta.com>
References: <20260317-vfio-selftests-aarch64-v1-1-2266077563e7@fb.com>
	<20260318165513.49c3830d@shazbot.org>
	<0cb46c4d-90aa-4ef3-9098-9c5554714982@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Mar 2026 13:51:29 +0000
Matt Evans <mattev@meta.com> wrote:

> Hi Alex,
> 
> On 18/03/2026 22:55, Alex Williamson wrote:
> > On Tue, 17 Mar 2026 16:25:18 -0700
> > Ted Logan <tedlogan@fb.com> wrote:
> >   
> >> Also build vfio self-tests on aarch64 variants, in addition to arm64 and
> >> x86_64.
> >>
> >> Reported-by: Matt Evans <mattev@meta.com>
> >> Closes: https://lore.kernel.org/all/e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com/ 
> >> ---
> >> Signed-off-by: Ted Logan <tedlogan@fb.com>  
> > 
> > Careful, this is a good way to get your Sign-off lost in the tooling.
> >   
> >> ---
> >>  tools/testing/selftests/vfio/Makefile | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> >> index 8e90e409e91d..98bc8d6271a4 100644
> >> --- a/tools/testing/selftests/vfio/Makefile
> >> +++ b/tools/testing/selftests/vfio/Makefile
> >> @@ -1,4 +1,4 @@
> >> -ARCH ?= $(shell uname -m)
> >> +ARCH ?= $(shell uname -m | sed -e 's/aarch64.*/arm64/')  
> > 
> > Are we intentionally enabling aarch64_be with this glob or is that just
> > carry-over from similar in the mm selftest Makefile?
> > 
> > Big endian ARM64 support is really not on my radar for vfio, but it
> > wouldn't be our first foray into big endian systems.
> > 
> > If it wasn't intentional, maybe just add "aarch64" to the below filter
> > list directly.  Thanks,  
> 
> I think that won't work for cross-builds passing in ARCH=arm64 "from
> above".  We can just drop the `.*` part of the sed regexp, giving
> ARCH=arm64 or arm64_be (the latter would fail to match in the filter below).
  
> >>  ifeq (,$(filter $(ARCH),arm64 x86_64))

Sorry, I don't fully follow.  If we expand the above "arm64 x86_64" to
include "aarch64" rather than distill the latter into "arm64", how does
that break the cross-builds?  Thanks,

Alex

> >>  # Do nothing on unsupported architectures
> >>
> >> ---
> >> base-commit: 96ca4caf9066f5ebd35b561a521af588a8eb0215
> >> change-id: 20260317-vfio-selftests-aarch64-636abf0f7674
> >>
> >> Best regards,  
> >   
> 
> 

