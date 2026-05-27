Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F0B3EDAA6
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779879388; cv=none; b=oBcHfJt5i+gsyMHhLEtFTBrONe0uZRp5Kp+qquBq7eEeDrVz3utd2ox2X2NCfyzg/I67xLYMs6gs7VngB7xH7tCuplCqu1L9spOuSNF4YjdNKACqdAgUdFS9JyUhezZbUdKzxsbEiygCFXXE3vr2WnPHKGx61UwiP6oLMxEMAQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779879388; c=relaxed/simple;
	bh=rNUmpZLe1fbwIvKXE+to8JaQxK8DTUurXcsabTl7BFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOv9FAzaydrXxHSUUcnrFEdOt7NdeblJFkTRKzec/q23cJy/mniLfTy1y/4bJ/R0dCSt7EdVzZ0TSFZXftYoV0qkaG6KDBANATrk7FXXblL6IIxCjN2MdOxVPJYJxp6RVLy0f+N0t4+euMeeDMEiENppmzCZDiH9ahh4M5W1sm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5Xvc4gv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5Xvc4gv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E991F000E9;
	Wed, 27 May 2026 10:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779879387;
	bh=5n7mSfHGX4F9t6WFOipELPIaR8w8e1jVF9EKHmy/yUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n5Xvc4gv8yShfiPpCU2dDxRwTgag+yIwrvXY8AWOnopExhdn2fkZ3XAYdXfQQu+L/
	 JkOcb5Afw1in1R4H901TI78dXj46HGrilneUpOHHxgatePKVhLqWwbjCbbEVKY4HNv
	 L8Il3WyXVU8eiTSQ4YzSHwjlzSN7WmeIAta+z8XQrKKOs2Kv87qoRKC5/v5EhSh20f
	 NecXJl0EDhYWXrxxZgUgHKfYY9q+gUF3zBSASAh+jga/ZZAAIsOsKTphCj1oQef+3T
	 vXcVHqlg2xx9feiOVTE07rbc9oLpvful9IrwloIQBl/pJCIDpq51ehhwTNzZY7vAis
	 HpVaKuoSy0FyQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 44C97F4007E;
	Wed, 27 May 2026 06:56:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 27 May 2026 06:56:26 -0400
X-ME-Sender: <xms:2s0Walh6RpAtLZ19OxiiKiKAMKA4Mbak-E-1_7-JdzrB_Rrga-4ZYw>
    <xme:2s0WahBP_f-lAoCp9YhA47Du6c0Xs01jv_xQIZzWhe2NQsy9fNG6R7rWnLldTw_WC
    TGsz4aIf8BaCHrOrpxNR5WaXBKr5aPfm6_PddnfonnoRsqokU26dNA>
X-ME-Received: <xmr:2s0WahZHD3Q9JUNPmuRSujSZ2ezeZ_aJYJz_W1zroIMyObcO8aDxM0iJeQpmkg>
X-ME-Proxy-Cause: dmFkZTFXA2uWKoyT6YuTKua2PHcWTP+H8rYOTTZC7SKk+/8FqKG5UzIFAWbnYVusP9hZi2
    BhsBP+F/nACgys+U/v4S/1wCXD6SBbofLCIX6j/pcPC6vgN8rt495hiyh68/UlWrI9IQTQ
    pyD8fuwUF+xRJlXU07eUNU1h19KMjNpIUDhSNVBgmIeijZDfbu3QmxTi4vrB9U9QlWGdfY
    p2b9nGLSST/JJ+wFEQiQexL3loY48QgkfIr1e1khw0rl1laJu3ExZuVSXmcadfbMplAv36
    XIEPyx23TPPg5xwSxEeOW5bKM3f1kjgpk8TYjFrIKrgFg1PuzLUzjRir3m5+uRGzhT1cG6
    Fql1KyhNpIoeubO4Ki9v1U1KbFwVug1p/TJiU4Cha+GdM5nmL9+OlQP7KgOvGizr5tf5MQ
    hH2W1eBMZdhXS7xYL+Gyzsgrxix10lK9f5OZkCjoUHxgw1ln4zcYEXNscVh3ffJQFAKXWh
    3UWWVuh8FN5LaZ1TVgYI9xjmgV7ICUkmqzeReh2Bg1blWNOPrSXoa0QTOJbVcf1nf+4XwN
    E/lCog4HdNNIPSy3tJNz/Pu8dlKVapbCjHOE2LO6/XqqU7RMnXcv4zJdSNSi7FclN3KFvT
    0VXi6BvKS5QAa8CysVVlmXQ8GaFzYysFgpNPRisQDidwlsgAA8lZdx3yEgcA
X-ME-Proxy: <xmx:2s0WahKfJJ8Vkzz8WytEbwDDVr8UFDULYxGg-91sqUyVeuLI-y42qA>
    <xmx:2s0WapbnZFl2HVurfrX-OQHwfrEELtdTg9ASf6MqkIKc6MzLAZf50Q>
    <xmx:2s0WajXnN2YGUF64FM24ULXKFmcp6h8VrLGBjTiHk93pFZzSl9Cp1w>
    <xmx:2s0WaitBgk1CHcOf40c8GXA_lG_rvCVnWywQxw9P6XjHOkevJsYWpQ>
    <xmx:2s0WahzegFRyyXiPSE9ZN9zjQVCjpNF1mXqdHAt_rhMKpMhjAgrPQBMg>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 06:56:24 -0400 (EDT)
Date: Wed, 27 May 2026 11:56:20 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>, rick.p.edgecombe@intel.com
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, binbin.wu@linux.intel.com, dave.hansen@linux.intel.com, 
	djbw@kernel.org, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, sagis@google.com, 
	seanjc@google.com, tony.lindgren@linux.intel.com, vannapurve@google.com, 
	vishal.l.verma@intel.com, yilun.xu@linux.intel.com, xiaoyao.li@intel.com, 
	yan.y.zhao@intel.com, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v10 04/25] x86/virt/tdx: Move TDX_FEATURES0 bits to
 asm/tdx.h
Message-ID: <ahbND9ttKiLFHX9W@thinkstation>
References: <20260520133909.409394-1-chao.gao@intel.com>
 <20260520133909.409394-5-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520133909.409394-5-chao.gao@intel.com>

On Wed, May 20, 2026 at 06:38:07AM -0700, Chao Gao wrote:
> Future changes will add support for new TDX features exposed as
> TDX_FEATURES0 bits. The presence of these features will need to be checked
> outside of arch/x86/virt. So the feature query helpers, and the
> TDX_FEATURES0 defines they reference, will need to live in the widely
> accessible asm/tdx.h header. Move the existing TDX_FEATURES0 to asm/tdx.h
> so that they can all be kept together.
> 
> Opportunistically switch to BIT_ULL() since TDX_FEATURES0 is 64-bit.
> 
> No functional change intended.

I don't have a problem with the patch, but it seems to be colliding with
DPAMT patchset that also moves the define around.

Rick, I assume this patchset going upstream first, right?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
