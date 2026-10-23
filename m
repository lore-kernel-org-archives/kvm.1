Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750637;
	b=lZRakikVteadmJkd6KTVSPCTZoz0EZETmq/y3sIV4XnW4A0x1H+EC1pcn8Jxn1J09+C+
	 XpXRkF24N0jJszLI8HryuTXylsrnRxDZ2zzoXQh93EAP81clmSE+TU2sVab7i7hd4voR6
	 LgIaK/BF89QD96JkCDb1hshVhtRxPYvqfApoRjPJAwIEfYriTsmua3XQ1KKupVgY1ceW4
	 NMaTrEWEO/zfWox+q4xTqXxOnFWLNweEkySurB3/KUyW/hC1wTwtfenMPKeHCmDa8ZQmR
	 WVe5cZxEgiqcgfPltwBSmY1bsK8hMnMhmrTeSYed0f0Hgcnxd/nLBMERE/Sgqzj/ETg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750637;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=gpeLZJVtpiJlPDO3HGOLqYYd8BW6Z+Hn1e4Q/28eTGA=;
	b=dw7L76MQ+BAhh8ijk+p7XX96Gh2HzcSbFmTLefx12mSTYUwiIet+hbi/At41gjQb4B9c
	 RJUxYsEiBb8prM51wylpcv67JvvUCH53glsO+A/HB0hbf7tS8r1pUyooF93AnLtCBNiLD
	 8N0QNpmrQjcBUdCT02mbMyHWuACUfl9k8Ul7sbOcTxDhk6mk/8ZALRub66JlevYfIFcfK
	 SdhkpL9UAbtss4xqw2CGbKjrPLB0b7pCk0TzavXJ3JoNfo64QdKXhwBHc6+YFnO/GBXFu
	 Jv2Y8ozZOUr06UR6uMQLXYpmavASMM0oKO3xUGm8cv/jH3wXmdJwh8ZlGJirqVZjLXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VYk/D+3k";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C730606A31A;
	Fri, 23 Oct 2026 10:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VYk/D+3k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73411F01825;
	Fri, 23 Oct 2026 10:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792750636;
	bh=gpeLZJVtpiJlPDO3HGOLqYYd8BW6Z+Hn1e4Q/28eTGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VYk/D+3kbKnN4Td708RzwXNiZQVZkFWUmZxiuigbcwG+CdlVoZzrggmWEYTIZLwuh
	 AzXJb59AXe41gthqxiYcdHMvmnpJEdZaoscSDro0jUBpaQEzorZAmc/U0kFk91XQwy
	 ak0p76QwdoFgt6Uxn2BIe3th7Ohg6KmkLYhX3sGt/7cOKh2U6xoEzL+9ncKD9Gtlki
	 3tUvSxvqITPkB8czRLZuV/ZsDod6v3hlLKdk4wT1ygaQznFpM9OFOy60We3qObERos
	 NC37C3T09OtndSaZM/duFZcoS4/5fy9dfm/7jHIc048POkCIMSzGm/jgTpk7PMk+MP
	 XzcuznffEhkGQ==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 6975A198003A;
	Fri, 23 Oct 2026 06:17:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 06:17:14 -0400
X-ME-Sender: <xms:JzTbamcM6thTVQGnNUGh5O7vXtFmn-fFEBcx-um2RSE3YGq57VkFrw>
    <xme:JzTbagFRooSn3XcuAnLfBtgpWGZp6Evs0rL_gpPZ6UNyH9ycxo5F3rvatpJzelQm8
    yIbvAUMe5JL4TA5XMciswkJl9IZIUdHxi4VrrpsMk_77z5fvsmn903N>
X-ME-Received: <xmr:JzTbak1qpy8Z6yC8grYUdBiyEYMJdJ6LcAeUO9Oo4InJHUdVFjUbJS33WjU>
X-ME-Proxy-Cause: dmFkZTErg9z4G4UhidklPuc8uFrLu2Z2aaxmgnGy3D0KEdUY6W7O/OlsaLOLS5DbOc08LB
    +5/iEztytUd59/o2IkmcrQGmA/fZJJD1NOHadjZHONHNkkocRANUoUv+g0S8bKlfeTQ+Fl
    JWTd5e9DLxWLLLAP+rGKsOMDHdiWSzUzgTQlZp+FcF6FlQHgqwNAX3euVj9+ZJdBXcMrk3
    sFB4RuHQI1wi9F9fPlEHNIObiUrEWqNOoCQvC36+l3uwhPwTowNT04EaTvE+HV8B7IJgqo
    ZNY6ia+NrtfoBJmiriJ0t9g0M7mlpIN/h6AJiITfUM4iGRmbdgNy+hX4rzpdjUQJVckkcf
    R1FVprDjCR3M6+GS67BrJ7uOzJWXeVND86gwtT679fhrrz/yzaXzvahEraMbK+H3fWzZ0l
    D7RO0rkhGNX47LUnKuFs96ULJscKhEltHMup9JV9Rj315617++feXwpPDC0whXS7AA9x7b
    mA0+gnFZQ6jYx0lpO+PXUIRO9ORhl8mmBvzWQbUpvLohOhrhZsec5F5s67HXOOq7jfoQB8
    cRa6EzcDscpNfcGPtWkNkYRO9fSCuGryHQZrwPOCHytoRDDhHXG80raBJQzcjV9KwzBmJW
    RD7huo7vf95k76ktT8jRXuqaB+ZECAwZoI3eIyDaZksX5riQla3+0EgstAeQ
X-ME-Proxy: <xmx:JzTbagIodmA06YeFG2ObXsM6bu0asV1jbKGP6NOGcj-5aH96uXehzg>
    <xmx:JzTbav2poA5KMbiX94TINoYMtbvJpT-_VEIvxX1OZP50l6jn_Z1YJg>
    <xmx:JzTbarj0NwG5BPrVWnS-ubsq0QLHh7HGrL4iAC3ITKbu9PcKc1kpCQ>
    <xmx:JzTbav09oRLTFwhhGukdOsryfPzJVIQmk2dREs0dOn1q15jyLK5i9A>
    <xmx:JzTbamdL2cE8AUTDCr-OJSFGboKtUIfnCbTufQJR-RwIrkFOAH0qbs-9>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 06:17:11 -0400 (EDT)
Date: Fri, 23 Oct 2026 11:17:10 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: moe@flashbots.net
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dan Williams <djbw@kernel.org>, Jun Miao <jun.miao@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] virt: tdx-guest: Fix and speed up the wait for a
 Quote
Message-ID: <atsz9rdU4CCjhSD2@thinkstation>
References: <20261022-tdx-guest-quote-poll-v2-0-7543c6eb2d36@flashbots.net>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-tdx-guest-quote-poll-v2-0-7543c6eb2d36@flashbots.net>

On Thu, Oct 22, 2026 at 04:31:40PM +0000, Moe Mahhouk via B4 Relay wrote:
> Getting a TDX Quote takes at least one second, because
> wait_for_quote_completion() sleeps a full second before each status
> check, while a local Quote Generation Service answers in a few
> milliseconds. Patch 2 polls with an exponential backoff instead.
> 
> In v1, Kiryl noticed that the same loop gets a real timeout wrong.
> Patch 1 fixes that on its own, so that it can be backported; patch 2
> then replaces the loop.

For the series:

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
