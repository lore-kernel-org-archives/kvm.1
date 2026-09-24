Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA9D47C0F7
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246930; cv=none; b=S4K2KAN1XSqU7dQo2inwwVggP/Aoeg1u/P70jxXcJU+2l4iLTHEWd0tskW0jAq34thKVd4D+ebS5oCx5xJcQMbzSCbiH+DN6Tfi710bvzAY6IYc+kZjrPLJD+Hjo/wkHOizacojtiOR47CAWq2GP00b810bnYBaqgnxk4vBgMuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246930; c=relaxed/simple;
	bh=1hWgtPfIhcmv3uZPfqep7GdGFzx3WRZbppQTT269zZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srdvZSkV1Z0imDj6I8wfJ2jp919WN9D8c2INur/3arXrSoosh8CmL6Xjz2su1Fa9k2TLwUaWDEAZBpGSaj1/YfEcmHdeHiNtrj8WpWbngjAwxWpTSs5WtB0x8jVH5qFuZvNvkPvyExA7T7FINM+PGx9UVn2L9omPg9/TSWNMffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYyCRLcQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYyCRLcQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC251F00893;
	Thu, 24 Sep 2026 10:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790246928;
	bh=cLWE3vZSfhOjQIrpyo/dUTF60jux1MMRfTnmuAYv/Ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fYyCRLcQDm9N0BGT2zynJ7PzmFu98uEboFguQLlGf0ugJTLTl4cJpnK6ksSlcozR1
	 NWKjWeysa/UJLmxGpwJ9j5dZzRL5pXHJlXKi+9a5yv3IeEajHr+y1jkdOGiwcZFpmY
	 rkYu0XrpaB+UDuUdCPpLXpPk5ePhKiKeQktX0qf6adK1N5XN4zMniUURHivNdTFjY5
	 M3SQOLuNByeBj46t3oFF+0UbOs/jIeorRUOoZKlsgj7YvfyUzizC8SRQenLQy5qwLp
	 w1/8Fw/ccMFLsFnPXkRo95Q+Pes8RnQ5frpjL8beiSZzlqX/UijCYb6qcnzNytsjrk
	 zO8PrU6o2Whfw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id E0C06198004A;
	Thu, 24 Sep 2026 06:48:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Sep 2026 06:48:46 -0400
X-ME-Sender: <xms:DAC1aseGMwgkQOEFaf7M_HimEycrxI8D_w7f47ijeJ0sEtA9BPcYmA>
    <xme:DAC1am_IozfPiGEPP_Xq3_kZX4wcGcFhaPqZef2M7rr189QFSa74LdMr604neOt2T
    MfuGjgo_tOHLrDZ6HyQDG9gOqh7cK834hHipdFrL9ipUIaTzM6CBREGnw>
X-ME-Received: <xmr:DAC1asMwwynUTV28mz9XYcS1mQ2NodKBuQJnK4VBn2F0F0W773PCyLDiQmU>
X-ME-Proxy-Cause: dmFkZTF8Oqp9uz/uL1tbF7AGYLiKGb7Rfk8/p4H0lXUz7vf0d2Yt/12rzicSahsscybdEr
    WL9fNnP8oTBSHNR3sdwKGCzTXlvjnhakF5z6pQiXec7ooqMfUatbR9xRsNsqV3bvhK/ApN
    T4o+8GxU+dWV+e1aGtc5yMNFWGHKDZAkeGlRO1Q+pXvji5E8rCz695bgDiELnwXoljZ9kN
    LcafiPTDyl287TPiY6qlpT7A51V9fQgP4btC1j1CWo2jitBDj61vmcW0JCOKz+eR42Nb5P
    pGYexAmPe+NZE1GLDCUfAXCSajPulPPN6tuy32e4hBVn4xmYrxedlZ5rwbScmRGRzPqEGW
    duSso7nYdS82CllG6HB7bvD+mXJKjLvBk19aP/7vcWBm5UzReheIyiR5tzdShqj2ljB28C
    BWPGWmZuFn1g7YN/vo3p5LKavVldVLmOeQ6QhHCFDJKq0uNfJtWqEgtnyqu/Ovjrpau+je
    lLM0Z8VMPqdw2u/HglPc5Vs8ZU7toVhmfYZct0q5ICiqB/u9BQS9cpl/8EEoTXhOHiOg+8
    HLe2w/lmZ4mSZZ74Iw9f+wljulAbIvJkux87VKSwJB20NvyZGhSNHmgGxHdjchZuZ3bg7s
    maFxe/XY0YwZV+382/kwj8xdXSTC3+R40yJc7G/uZ2T1z1IbbhuXQazMsc1Q
X-ME-Proxy: <xmx:DAC1akWMyZV4TBbWSQ8XPZXR-VNfA4aSB-zfAr4_yO1vDf5ypoyi4g>
    <xmx:DAC1ash2KZw_Uqqsvp7-z8G1tYeRI0bLck0mke0G18CVQki5wvN9EA>
    <xmx:DAC1as_5tbK52RfLpIOX6f2u-bqTZktsOtmo1fTO4USmWj2ix1P3UA>
    <xmx:DAC1arRgZXgnBECFuxY16327g7KBhVqKX2GFc7n-xczoJQiJrsx8NA>
    <xmx:DAC1ajtC36rASewiYyOT28evRb-ceQpqYzAkQcJzwqIFg7-5zxSmJj0H>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 06:48:43 -0400 (EDT)
Date: Thu, 24 Sep 2026 11:48:42 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"ak@linux.intel.com" <ak@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/tdx: Remove the early #VE handler
Message-ID: <arT_p-dhkHix5fyj@thinkstation>
References: <20260910-b4-tdx_remove_early_ve_handler-v1-1-bf47a4d360c5@intel.com>
 <b41da075607d1eaa9d96eddbf3acc24502edd604.camel@intel.com>
 <aqPTIyi--7f2Fzxm@thinkstation>
 <4238bd74efaeea1a6158b79f9475a5f8d1aa7e0a.camel@intel.com>
 <arJVpaAi9TqEfV7E@thinkstation>
 <d940f1bb8bf51915c7efb19f79760859ad8a45df.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d940f1bb8bf51915c7efb19f79760859ad8a45df.camel@intel.com>

On Tue, Sep 22, 2026 at 05:45:03PM +0000, Verma, Vishal L wrote:
> On Tue, 2026-09-22 at 11:19 +0100, Kiryl Shutsemau wrote:
> > 
> > Could you just check what happens you panic early (like in
> > tdx_early_init()) with and without the patch?
> 
> Tested this:
> 
> ---
> 
>  arch/x86/coco/tdx/tdx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index f904a636d449..fcb2ecf055d1 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -1192,4 +1192,7 @@ void __init tdx_early_init(void)
>  	x86_cpuinit.parallel_bringup = false;
> 
>  	tdx_announce();
> +
> +	panic("early #VE window panic test");
>  }
> 
> ---
> 
> In both cases, with and without the removal patch, the guest just hangs
> without any actual text in the serial output. I didn't add any panic=
> cmdline, and CONFIG_PANIC_TIMEOUT was the default 0.

Okay, I run out of excuses. We can revert it later, if there's an actual
problem I cannot recall.

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
