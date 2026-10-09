Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900C53CE489
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551305; cv=none; b=TV7pR1QoirqQ0FkEGLSCyFyRJK5Yz0/+f9M94Z6iCgOWit7PItzeLfoaZqtnS/gioly7M8sxL41/eQYBOmZQOoKlapAT652b37YHosmCiAO8C4aDhBSa/0jMHiHYiPTDfV8vuSI/V+hm7giyz2eC/r+t0pk85XSGPCgr92p3t2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551305; c=relaxed/simple;
	bh=yhTc7H+0IqN4frsO9baGH1rCR17Pji1FxlEXnUH5cBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1a91Eujv/3U/82fjMn4DuiLgNbz6bkCd2joyS58fIkFE4a8bXa+hSLKlFuugooaJxJq88RhQvBdNPneW8dPuhjO9kqvoVtj5NsTNk4lCfeeIb9MH9ElcyyopxckSpp1Xm3RqVNtuokctOmf4PGtjMkcFfkVheUCy/dAhty1UWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2qqCgv0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2qqCgv0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416191F00898;
	Fri,  9 Oct 2026 13:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791551303;
	bh=FpUIQG2ildfJUJXlKIPJfIgmZEi5bWUOemoR8HcahF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c2qqCgv0D58/0e+k9zxI9o6dg3GYpDAHOtqCZbpcGXac3qwbIvxYpa3bQHSmqrAyV
	 VsbnWIASJih0kFuAw4OTbBagMheW9GxPXdx7eadF0QUvCJ7NM2xmMlSZ0qprbBTc/K
	 n20YP9NzuQfludLWwDvLQjdb6QoK3liPhRuyryMZHAyPbZs9AAR4Px0k1NL88KQp9u
	 UxYSlHPSPJvYXRhzh37T9CMKT8VZVA9w3hFuCqZVVCu9jX6FPCT7ecTe605nzua1sr
	 biOTq+gYuahC7BnenqIHkldbrWfR2yghlxyKT0NuYKmSdqfectrWBgw2AirTZ9L/f5
	 k1njNHyfO800Q==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 92507198003A;
	Fri,  9 Oct 2026 09:08:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 09 Oct 2026 09:08:19 -0400
X-ME-Sender: <xms:P-fIajBkki790Caehe3DTmvhDY-2WDVcOvDkZdaUGk9ejDcosdz3Dg>
    <xme:P-fIagwvaFs17JgJc6_4-W7UbnqQzsF00tXRD44Ft0Mpp3sF00kmWh0Z59Kxq7Hnd
    rmJaBJp73yKvYu3vIy-zqeVTfQMwnZm1yehbW3roBzX6WbUpYs9YlXq>
X-ME-Received: <xmr:P-fIanIyPDsDm4HxWS_Ml4co6ihgNtYzg3RKCqcIjKXd1hLONamUEkACkww>
X-ME-Proxy-Cause: dmFkZTFj6c6YPtf1RuC5ge2DhrVWepaKzhdu396taV7DKjafJHPQen98eiWB0+ajyHRDBo
    V9e4R6BapcDruKkFzt7wbLaUPtObKYs7i9noBdPNd/Q6HdaKBiK7wc4jCqMfUhvS89D9zD
    6H8Qa2Lh150MpeNHzv+CKjV1NHARmiVAuljI7sPclv0uj2VaIlohhugxZpGz+KzF2cLXXD
    aw9miqNb9hjy9GUg6ZWhHJkCKHUPOnumFVmQYAyIbqyiR9vu2DTsyIAAhfPUlXZgZ4aiFu
    QOaOGft0y6E/laBs0cB6CcqW5Ibby+5XmFvevcK3EPGURVWQnT6jrlijFDsdGYcPZOA3gT
    mvvTl13TDo8h6/vmkHXJs1G7Ql6NxAv+Ch5hGDhY70m3VIQ9uhGLUoy9F7cLI/eJu4b/nH
    lZHFRwYYsu8dWgU8q3poX6OpVnmzbYLjMIAvFBb07hNoBj1OAiC7+LOJNVo0Wlqf709ua/
    unpiNAskSwxOrVmfClu4Wi6a5hNXGTwKeZao5bkjWPxcs5imNSE0IINWKBTC4avlAQQbZ3
    AMAI7l/Pat2dhWY2egMZFwwCy61AKkUl32pYmptN5sGsIrbFue5WT2TB2Y5QPmTWSaFT7q
    dOeSzIVEOjElCH6Rc9LqzfHAEcPBk6BUIy5wGHyo0tpH6H2v3Ux0jgPpbRAQ
X-ME-Proxy: <xmx:P-fIajKGf4zhBmdyhwypcQ3169QKNwWnxMm41auc61SakHcDgCHoRw>
    <xmx:QOfIagXlsaiZSwUyCDE55Ioe3vzwaWNk2BaouJcaTtI-Kf8uBsnZXQ>
    <xmx:QOfIav8zCruYSxG2TPYpmSt9_vRXpdghozhNXpAW4iJ7KTnDHAg_bA>
    <xmx:QOfIaiJAi-7lJkBSB5Hj-ngVS49AhBqCuLjBaj271j_CoRja9LoXSQ>
    <xmx:QOfIal0RcBbcM0t8osyWDiAAsLKGGpsCc6xY5E_m7UlM0spMTe9MHwpK>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 09:08:14 -0400 (EDT)
Date: Fri, 9 Oct 2026 14:08:13 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com, kvm@vger.kernel.org, yilun.xu@intel.com, 
	xiaoyao.li@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com, 
	kishen.maloor@intel.com, tony.lindgren@linux.intel.com, peter.fang@intel.com, 
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, chao.gao@intel.com, 
	artem.bityutskiy@linux.intel.com, nik.borisov@suse.com
Subject: Re: [PATCH v3 1/6] x86/virt/tdx: Move TDH.SYS.CONFIG operations into
 a wrapper
Message-ID: <asjnNXbMfro4k2t8@thinkstation>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-1-db52cb05b918@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-tdx-module-ext-v3-1-db52cb05b918@linux.intel.com>

On Tue, Oct 06, 2026 at 01:41:45AM +0800, Xu Yilun wrote:
> In Linux, SEAMCALL wrappers are introduced to avoid broad SEAMCALL
> access by exposing only a selection of SEAMCALL leafs, but also to
> abstract the SEAMCALL register ABIs. The abstraction improves
> readability and reuse for SEAMCALL leafs that are called multiple times.
> 
> Some SEAMCALL leafs are not explicitly wrapped because the level of TDX
> ABI details needed to perform the call is low enough to flow well with
> the calling code.
> 
> For some of the currently unwrapped SEAMCALL leafs, the TDX architecture
> has evolved the ABI to introduce new leaf versions. The host can select
> the version to call based on what is supported by the loaded TDX module.
> When future kernel implements this version selection, more ABI details
> will leak into the surrounding caller code, which decreases the
> readability of the caller logic. To keep the ABI details contained, move
> the SEAMCALL leaf that will need version selection into a wrapper.
> 
> When defining the wrapper, the cleanest separation would be to have
> kernel data types for the SEAMCALL wrapper arguments, and have them
> marshaled into SEAMCALL leaf ABI types (often u64s) inside the wrapper.
> This works for many SEAMCALL leafs but becomes cumbersome when the
> register ABI type is a physical address which points to a buffer for an
> in-memory ABI. If the SEAMCALL wrapper only accepts kernel data types,
> it may need duplicate buffer allocation and copies to match the
> in-memory ABI. Another solution is to define a named helper structure
> that mirrors the in-memory ABI, populate it in a separate flow, then
> pass it to the SEAMCALL wrapper. struct seamldr_params is an existing
> example of this pattern.
> 
> TDH.SYS.CONFIG requires a list of TDMR information in the form of a PA
> array. The PA array is the in-memory ABI. Create a structure for the PA
> array, use it as the argument when creating the wrapper for
> TDH.SYS.CONFIG.
> 
> For readability, adjust a bit of the existing PA array size calculation:
> use the new PA array structure's element type instead of hardcoding u64.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
