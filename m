Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106512E424F;
	Mon, 25 May 2026 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779721411; cv=none; b=laW6FhBUAdlWv1aLh+JEYTXK5HTV5TV50oB5TSYM/UDrJXkF2Ee/aiCRBdk72YyBJWO6JqhqKqG4Gkx1eHpDt5+6Qdt/CNp/BNS+oSldEWeJgL42b5EUiwZEYIV5e5761fKmJOa9zgtktMUNPWayyu1hjXsZs6A5v1Id2z9ajUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779721411; c=relaxed/simple;
	bh=bSEG/KPXQREyIquyRdOVpZpdwLepWUrpEgqsghUk2Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQ2h5vvVN795nlqcIKo26sN74jg+6wPRfwkl122zkvrNTHlcqMKZtvXk+ZT4ixpHJfilsqcFPFvFY63BQ8amqIH+uZIg26E0AiD/uqsqDrZFtQPhEtEjhdLciKtU9T5FoIxqi+yenPd3Ipd0kptYq+CiNgAuxtUTX8jSbVDNSgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=03IsWniT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tmc/uU83; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="03IsWniT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tmc/uU83"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 5855C13001E9;
	Mon, 25 May 2026 11:03:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 25 May 2026 11:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1779721408; x=1779728608; bh=SXzZ6FbcGPN2pMfLDn9YDPXN9/7MMjZw
	WofNjo0GBTY=; b=03IsWniTRnh1R8EAfEv5ai1Zo8MK0BrKuK0/hG1OqccgJOKE
	61QEpso0G5CifSJLVCpwlP5flwvH4QmrPIrFTX+OZwZjHkKXvAOlGdpqD8Gd7tfw
	p8KCNiIsHuIycy1Hr5qs3Acd7gaEzoCtkrziqEN3OyrgjHHvMXGZ4SV0o1hZTrEC
	R+hrmqWb76Xf3fxEiiIgIVZYMvtxKwyOd9m5pEHmrb99sSY9lG7CE1uLy8xkfRoh
	u1vg76o1i8SkHwTwEgDBwZeCLXPNHm5vqOo+5WVEKyh5ajitTIr6857pn/xzgnIn
	YIp/ctVEbQMmcvJRb4+JwvoZ9pFi+AvjUvkiDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779721408; x=
	1779728608; bh=SXzZ6FbcGPN2pMfLDn9YDPXN9/7MMjZwWofNjo0GBTY=; b=t
	mc/uU83cU2iH2hS8K3ryhyqfxqojV4CyPJ3fM1ysHdcz2jyFPiHx9kI8YPE/kJzN
	t+/rLHVGNjjxx9LrCLwM2AgJkhv3PfJwbxj16o3y0bvZefZ1CzDtyaFs3w5fq/9z
	FfD0A/kcxSHCnVsAY/mKEQUAq8U4g6DHZr+g+i+vK1lYBzuA9ymKs64ehLkNO1M6
	LlT+IpTK8B7balmGjYTNxwwA+zPBMkPulfcslwyzqbE1/kRCrCiGuDdG99RoravM
	dQHxlL03CxG9hYePKEsj/0R9sB81z195Y89huv438+dIzgs/3kRlS3734EIsHCyO
	3Tmr57n1jLmguaDmQsXLw==
X-ME-Sender: <xms:v2QUavaJr7C9BVIC8VOg3HPIMfv-TiLnJ9Om-GUEwvq3xnUEalgO9Q>
    <xme:v2QUamxK1nhAF7UtfBFTnCVDUo-MzoqyXoo_wlwkpEqJJdPivyFAdUVbQphPxxa_L
    0OJPB4sBUIAyUiYk6Pzk1Sqf29IBd3qzQfGIYQSwh_hKZrX6PndbA>
X-ME-Received: <xmr:v2QUasP94d7p0-T0j59dhp6_nf_9BtetJEYa4gj8twWSLOBQKDSpU_uT-_uJSw>
X-ME-Proxy-Cause: dmFkZTG1wMCWpF+jWh6JnSJRhnqCk8CHl4QtqDfProGnjDknbTusgbpse+me6X77xlp8sU
    pPNxIj+Mp+FdEPWI05pC3HZcM0qkOFDj4/tQ8sG9sMRhjP7fWYuRX0pEYH/g2EsphcjVGq
    9MAevLENFONJ+wVfywlf7YE9Bs6NntmPIbsNW5CXGsmDD9YGnkmsDNfDQc4r2ovKlufsa/
    Uz2NHnI41MmeV+FXzhmNvyFKUNJf+mNu2Gv9qFUBO/q4AVDJAqPTStv1i7KbreaRmq7P7T
    JAC1hLjWmv43jXlh+xP8ebsETokOEoVOATwSiRSi21F3NWJyrIb+XpEy5jSNJBS8Ir9cVj
    jdysgh+hAl6d2YdjAzJThYEATI/wa/dFbqQHExdIK4RThCagFnaeS0aA+bGUkXbsVNztNE
    ZsVizg+x4f6GA9wsgLe9QkLn8I6h1P+f1lLMWfdkuRDL1yOxYjzv+Jyy61c6ebXR7mC8I3
    lW9eHQOEirXnGa4mSmwz+N8Ih+ElakvuT6QfjMMIm58bhCuyQ742HyN135kkpjeaqOow2A
    hxD3ZnePQheD048cxkFPSWmQoO2CcAO2GaSIInb3foDl8W0cc+6xM43FEdgNynpCVO859A
    55hlF3n1FZ+3bfSQFB/YtAhTiFKIbz93aq7YVB56Hb0w+KLMlfQhY0ddSJow
X-ME-Proxy: <xmx:v2QUaqNH2RFPr464jd7IZ01S4AOzG5mV9iey23pXW65mvzu-tAAXww>
    <xmx:v2QUan9xKwpQh8OBcLNwEykEIaFn_p9kXm63OvTQ_5pLeki04V7ubQ>
    <xmx:v2QUahZN58hm6EJFRMNWDcratJG7qQtbMP4seq78FZjndW3XELmcqA>
    <xmx:v2QUatF9lOxG64uz_XBfM4O_IZEFpPPsHfguDQDVBpLaerzNBFzF_A>
    <xmx:wGQUaiF9GbJdr7UaaFw8v8MKqP3w8hxqSDjoCEd2WD0j5MrJhohR-a7S>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 11:03:26 -0400 (EDT)
Date: Mon, 25 May 2026 16:03:26 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, akpm@linux-foundation.org, rppt@kernel.org, 
	peterx@redhat.com, david@kernel.org, ljs@kernel.org, surenb@google.com, 
	vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, 
	aarcange@redhat.com, sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v4 05/14] mm: add MM_CP_UFFD_RWP change_protection() flag
Message-ID: <ahRj49iYG7bWz5kh@thinkstation>
References: <20260525113737.1942478-6-kas@kernel.org>
 <20260525121319.3B03D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525121319.3B03D1F000E9@smtp.kernel.org>

On Mon, May 25, 2026 at 12:13:18PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] UFFD_RWP silently fails to apply PAGE_NONE protection on
> architectures without CONFIG_ARCH_HAS_PTE_PROTNONE.

CONFIG_USERFAULTFD_RWP depends on ARCH_HAS_PTE_PROTNONE (mm/Kconfig)
and VM_UFFD_RWP is VM_NONE without it (include/linux/mm.h), so
UFFDIO_REGISTER_MODE_RWP is rejected and change_protection() is never
called with MM_CP_UFFD_RWP on such archs.

> - [High] Resolving UFFD_RWP incorrectly clears UFFD_WP PTE markers.

WP and RWP are mutually exclusive at registration (the explicit reject
in userfaultfd_register()), and UFFDIO_SET_MODE only toggles RWP_ASYNC,
not the WP/RWP mode itself. A VMA armed with one can't carry the
other's markers; the (uffd_wp_resolve || uffd_rwp_resolve) OR is safe.

> 
> Pre-existing issues:
> - [High] mprotect() silently drops userfaultfd protection bits from
> migration and device-private swap entries.

Confirmed and pre-existing -- change_softleaf_pte() preserves
pte_swp_soft_dirty but not pte_swp_uffd when rebuilding a migration
or device_private_write entry. Plain mprotect() over a migrating page
strips the bit, breaking the trap on swap-in. Will address in a
separate fix after this series.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260525113737.1942478-1-kas@kernel.org?part=5

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
