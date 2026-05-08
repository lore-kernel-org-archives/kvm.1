Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7F8377EDD;
	Fri,  8 May 2026 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280536; cv=none; b=jjayp+yf68Z3TZYqdbbKRgZ0nLUunbaRsd1PAZXRTbTEaDqUfzcSSLBArY0P2XhWc+m+RalFyuSkpM2dkszZKG/8G88ZToaCK53Pln9TT0EpWRfnza8watf3WExCJRaJCI9/p/kjEg7WFWQPCQ+3an6uBtDCb5zHGzOTz1uPYhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280536; c=relaxed/simple;
	bh=6sz+vBdkuTvEzmaVLVonZ/ivfq2/k1Il2bgKgF4N7rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsSAPg2/uS6e8O6YYuXqsxgiUn5tjwH1k9MePHSoQNRmGJvgGhnf8Tts1rB6fYOzExR7ErBhHzfPdQ0PNxhFxZEYn8rF+JwFGN+vQhrOcr3xkQbNjA+cqXmURQ7Oep7aCR3t+p38KvhpzkyIlD5M2q0f3aVsGyjEB+ZCCPLuFFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giwf11MK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giwf11MK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D723C2BCB4;
	Fri,  8 May 2026 22:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280536;
	bh=6sz+vBdkuTvEzmaVLVonZ/ivfq2/k1Il2bgKgF4N7rA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=giwf11MKzluYBUgCH2GW0ROQyazLOtO9+H2Ex5ow7pYlfQqA9iDXYHdZYmsUVEuyd
	 HGi7nNesirt4s8aeWPI0CTw0OxOycGJax8Eo6EnEsjrEBMGINQ5ngVwtkRsuZ6kkVv
	 T6RpAhdaGpj0vNEX+lmIXr38xADiW7h44Ue3HdaphpUgbtePffpPCvpPZkLkXnfHxd
	 QTXNlmQ9+BxiwIZAe/Ek40tdHTwFPo3Np/cGDqXreE/tV2QMopGG7nToaZeMuVrl+c
	 +Hq/02Pj/WmWEQOkQSuNokMy38ErkmwcFyktq6r94y7HsAFsmaHtteGxHun8wsjH30
	 tstTqXQXNo6PA==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9B7BEF4007C;
	Fri,  8 May 2026 18:48:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 08 May 2026 18:48:54 -0400
X-ME-Sender: <xms:Vmj-aeMrTOhfPeM7Lm1aS1S5iGEHVZrY5gO8qRAqJkBfpdgQAGVZEw>
    <xme:Vmj-aV9nl_5mxVSKhaYrCbl6c37ZyGP0O4-dT_C8eJiDqZNNLf1tnuyRzmC1wf2Nv
    yMlVssTyhbCCeOItHTOdvb03vlCmY6r5bFPty4pDufxsJM6tywRT2PI>
X-ME-Received: <xmr:Vmj-ae9wx9F_B8SVKtl0vJNnrcbVCbaA96kfhpY3mOjen9SSkeTLWcZEeCB1Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudduheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefmihhrhihlucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhn
    vghlrdhorhhgqeenucggtffrrghtthgvrhhnpeffffekgeffjefgkedvjeeggedttdelje
    ekhffhudeiudfhiefgudeugffhheffudenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepgeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    eprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghrgiesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohepuggrvhhiugeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhjsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhurhgvnhgssehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehvsggrsghkrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthho
    peiiihihsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:Vmj-aVofAgSl9mSIiINXpTPQ8XI8WMb3JHJcwje24GO0tznJGlGTmQ>
    <xmx:Vmj-aZJR0VFqVsZL7-CO3Z_G4jsNBRFVMeB-AoHye3zAVaeTZeh4Mw>
    <xmx:Vmj-aa11GWmX_VLUA9xJWrlCC40s3BoSlAn9uZOeoj7AMM-MlkvNSg>
    <xmx:Vmj-aS6bZWY5AwPgbOjfbsSRXt6YDwbIIHO7jjp0HSAS-RdjuO0ONg>
    <xmx:Vmj-aYOglhxgNoFgXF7xSym8II-0Oh9NL6Qz8Bkxc0pGKRZEyvb9HTB2>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 18:48:54 -0400 (EDT)
Date: Fri, 8 May 2026 23:48:53 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: rppt@kernel.org, peterx@redhat.com, david@kernel.org, ljs@kernel.org, 
	surenb@google.com, vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, seanjc@google.com, 
	pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, sj@kernel.org, 
	usama.arif@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 00/14] userfaultfd: working set tracking for VM guest
 memory
Message-ID: <af5eALk9yO8pPcHv@thinkstation>
References: <cover.1778254670.git.kas@kernel.org>
 <20260508103220.aa46427b6f4c5d0247d2afb0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508103220.aa46427b6f4c5d0247d2afb0@linux-foundation.org>

On Fri, May 08, 2026 at 10:32:20AM -0700, Andrew Morton wrote:
> On Fri,  8 May 2026 16:55:12 +0100 "Kiryl Shutsemau (Meta)" <kas@kernel.org> wrote:
> 
> > This series adds userfaultfd support for tracking the working set of
> > VM guest memory, so a VMM can identify cold pages and evict them to
> > tiered or remote storage.
> > 
> > v1: https://lore.kernel.org/all/20260427114607.4068647-1-kas@kernel.org/
> 
> Thanks.  I'll duck v2 for now, await more review.

Sure.

> > Assisted-by: Claude:claude-opus-4-6
> 
> For my education, and perhaps for others: can you please explain how
> you used Claude in the preparation of this series?

I'm no expert by any means, but here's how I used it here.

For this particular project there was quite a bit of path-finding.
I had a phase where I bounced ideas off Claude. It helped me
understand the problem space better and formulate possible solutions.
Rubber ducking on steroids.

Once it's clear _what_ to do, we formulate a plan on _how_. It also
involves back and forth.

Once the plan was done, I gave the go-ahead on executing it.

Userfaultfd already had a test suite, and it was extended to cover the new
functionality. I have some scripts to build the kernel and run it in a VM.
Claude knows how to use them, so at the end of plan execution I had a
functional feature.

Then the review phase. The most time-consuming and draining part.
I carefully reviewed all patches.

At this stage I use Claude as an editor.

Some of the changes I asked for required substantial rework of the whole
patchset, and I had to start the review from scratch. A good test suite and
build-test harness help to keep the whole thing from falling apart.

It took me quite a few review rounds before I was happy with the result.
Maybe between 8 and 10. I think better instructions can cut this number down.

And I need to rethink how I do the review. Reading the git log in
parallel with examining the code in the editor and giving instructions to
Claude is not very ergonomic. There's room for improvement.

Once I was happy with the patchset to give it Signed-off-by, I ran it
through Chris' review prompts several times, addressing the issues.

I hope it is helpful. I would also be glad if other folks shared their
workflow. There is probably a better way to achieve the same result.
I am new to the game.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
