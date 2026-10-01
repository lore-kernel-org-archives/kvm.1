Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B873035C1B1
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856860; cv=none; b=NVIu0zG1d0bEQDJwKgpSBR9mXAqj3DoTY+tQL6bfvarEcLWfHMcnP2bsm+NVZ8kWqJdxqpMDKGWI8n16dsnMwhFVgRdQLBnONoC6pp6Ax0aWLs3v56pywr5id0YHfeVisuUAcBLqhhpxuwbLfdx0r0GjxbPezlUEMWO01EutsvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856860; c=relaxed/simple;
	bh=eKttG8SaITSxoK/QoG0cajgTN6vm4423JvmMnQkI0KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGxU0xHJyjwy2dZJyJr79pvJB2eBl/1DziWbDYrIQM7U/0mgZg4r++4ZmPf5a7GbLGwnA0/S5CSrChqD8vzlfhikEY2ofUkzyhbezKLRux66TTZwkSzfn2PtXmNqfO3yFVnB+kJ1JhlaJZWUYDXzXU1j9BzQDAWbY9y3X8YhAoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRRL5KLc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRRL5KLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9981F00899;
	Thu,  1 Oct 2026 12:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790856858;
	bh=tsTu+ivO6nYzU4UB6TTwTcgRRAX1fh6kgYdba3siVbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JRRL5KLcH48x0OIw/ozR2YJp8SyMd8D5UX3BfD3BNMOc9TZXfOtgSLr4T5ZbWbqId
	 SSkUV+8G8rFGuX9dZMXJuk3Ls1DNaL30LqePZECSqHEtusV/NTrIIWScjhjBxK2SZE
	 s7BaFNqGb5QPeZt8anTe4Ey0kfwICJKR8wz/zTxmkrGKg8JrcOtonEfnWMc41zKwhL
	 mBQCxJ0El3kNrq5S1WzFUjno5ktW05R+4AfWP2xA7f1rH8U0jE+618qfJ7oa6bEXha
	 eMJcUW7q5nH5UUgmtByLuRnR1UOt8GFggqy65zhg7lbMwhnXg6ue/VMJMlOto1JFTt
	 Ef0sUKDwc8BXA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id 56776198003A;
	Thu,  1 Oct 2026 08:14:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 01 Oct 2026 08:14:16 -0400
X-ME-Sender: <xms:lE6-albcSYUMh1UwShli0-nZ02yJ8v_z08SDST-EvSd6LIlWA2bTAA>
    <xme:lE6-avtYiSQtACDjxI4oKvESDn0zR1gHVzbWSzttq7QnBrLj7ZhmvzYT8NY99owzQ
    g5V8wI_HTF3WoV4bZ3ivquqKRFNjiJULytXB-ig8XF3ohblfmYDvbVC>
X-ME-Received: <xmr:lE6-ajxTYpy_U7fdumzfaZe58yaheXTcpgWZRMJdDwFIOKb0viORfDCiJTs>
X-ME-Proxy-Cause: dmFkZTGscorWyNN2o5LoOyItHMer0FeaqXCPDWR9S3cL5Rwiug+O4GIdVilaSv6JhPGdG5
    L/Wy49rTf1gkxMjNx/S7wpW9dLiYyBW7/49BDiOyJci22P2iMTmh1TIDWdAPGoTJOQdxZn
    Uav/JbHdjXXPh+FENIckI9RqhLeExhEl6VwpdYfL5HQ2/LFYbnhmLlMPtg5vJdOBnQO2y1
    14s80keGJvgpI2GwGqJk0Ts5bZoUE3RPCBx06BZb2T4UCCU1tlUdtL3DY2jGeg9KuHDZ6z
    JoIGXCmbpiWX7BEfp28NKmdKnCPCi1XcSD6nuDLpNntEVV7PzliheVkmJ1q5gg2cqekHee
    Sw1qMXFp93587VCU1BcQkup1tPXqhXP9q7imnKRmOADFEAx7e91e4wC9fgthFSCx04zw9c
    Xor1c/V5L4oTan3+NBLTKIZrdlwU+wFVMn52T9ce+BL2oK0e/7ElhJmjgn8Pe3s2yCGa/H
    hRTHwKYQ758Ps/hzWeeUGvYoNLjSNPFXH0Cwq+Z4LDeiArDyMBrc8lyW/kNfnCrxeAuT36
    P8vcHNlGAvZZuKbYM7r79yZz8GSdG2a3OxlORQNIAPwfxNzQDB8VgQtMDEaxOCRReBWqkv
    OAVtji2tHLKjvxovFAfgkrsXB9i6oIyLM0nZhOIiaXXS9nyXvsdTlp5m5Cww
X-ME-Proxy: <xmx:lE6-am0CLb4v3S1hwidglAeGPV5GhfFVnBCdmujhHzaZ1oIpQkX_tQ>
    <xmx:lE6-aklAo2BvMUoat_-PI5FijphxVMVRS06AehdBDAfcbL4i97QrmA>
    <xmx:lE6-al44ZLJoltFNc3h-6fgUSlMfQu7sAxiMKoeMMSb-NygZMOM78w>
    <xmx:lE6-agx6zfKilukC_qEmxfsawQ-FdvZjHP5A3Mk0uIs57szINDdQEA>
    <xmx:lE6-algzCZQaa0YSa07kkQNnOOMlE0mliUbknQcezRzJTxDrT5aNkY7l>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 08:14:12 -0400 (EDT)
Date: Thu, 1 Oct 2026 13:14:11 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "Gao, Chao" <chao.gao@intel.com>, 
	"Xu, Yilun" <yilun.xu@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, 
	"Maloor, Kishen" <kishen.maloor@intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, 
	"Fang, Peter" <peter.fang@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH v2 4/5] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Message-ID: <ar5M-jQA-rejFjdw@thinkstation>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-5-yilun.xu@linux.intel.com>
 <c373197ce8a8a7238696ce94bcd3dd7ba8be092e.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c373197ce8a8a7238696ce94bcd3dd7ba8be092e.camel@intel.com>

On Tue, Sep 15, 2026 at 09:19:14PM +0000, Edgecombe, Rick P wrote:
> Hey Kiryl,
> 
> On Tue, 2026-09-15 at 18:26 +0800, Xu Yilun wrote:
> > An alternative solution is to use a loop that gives memory on a memory
> > error code - TDX_EXT_MEMORY_POOL_REQUIRED, add one page per iteration
> > until TDH.EXT.INIT succeeds. Something like:
> > 
> > 	do {
> > 		ret = tdh_sys_init();
> > 		if (ret == TDX_EXT_MEMORY_POOL_REQUIRED)
> > 			tdh_ext_mem_add(); //single page
> > 	} while (ret == TDX_EXT_MEMORY_POOL_REQUIRED);
> > 
> > This approach is slightly simpler as we don't have to query the module
> > for the total memory, no memory pre-allocation or segmentation math.
> > But allocating a single 4K page per iteration may cause permanent memory
> > fragmentation.
> 
> So this is definitely a bad thing to do? Even if this is running at boot before
> much fragmentation could have happened? Don't early boot allocations tend to be
> more physically contiguous?

Not necessarily. See CONFIG_SHUFFLE_PAGE_ALLOCATOR, which default Y.

But even with shuffling, page allocator shouldn't claim new non-movable
page block just to keep shuffling satisfied.

It is better to check what happens in practice.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
