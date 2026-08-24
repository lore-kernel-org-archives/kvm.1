Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92AE355F4E
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787550051; cv=none; b=NFlTdStrRFssWwKzGXviQr4lsiuPcoVaffIfysqozApGlKwPqtpCSGWfkPX2IeTzLqH7KFfxmFfQRG4ei7yJxeU24drALgxwCgycO/qP3WjpxGUPdCxVSXntvEIhX3TLtn0ESKNr4zwuGLZxvQ/Q7RirhpAh5Bmav9BXXaCG8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787550051; c=relaxed/simple;
	bh=2wurZ0LMMZVTeMFjDnaTknvyiVroSys9HuDkS66ihfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfunQizfhett8kIz+i+tNFvj1O4oBSdyKxnSFFaeYMKHD+YG4keWnbGVQajSJSYdkMHRNfVOOaEsGrsIQXpErFIdhOE6KQLif3XbNWoBEnnWU5RPNjpbzFXhbi+I7uv5lAonhvldY9cbKbITGL4ApbaDB+fWQUF4fF1fvnVCc3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4MdHcCs; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4MdHcCs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787550050; x=1819086050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2wurZ0LMMZVTeMFjDnaTknvyiVroSys9HuDkS66ihfg=;
  b=X4MdHcCsoVspTkylteWvk7cYa3SktXKSIHeF5+scXPVGZkHi7MSTiK7G
   4RB2IoaHqMIqxI5B3JzTPuNsW/pXsCb253tggnb+vFEfGTH+IkbLTlc6y
   sKg9HIfOQtYA+DNVqU+d5lpHGJhEAn4JwiI/TyX3GoAzP7rVfYuHiSO2e
   vNpLfocUFP2OMkCg1/9cEnNDTYEOxxZ687fetThRX6EkFbWtE7miOsvHM
   l0e2x3GXEXUZO7vrPkq5hUDP4olMRPsgkZu3xTW5W3/0wuFsrYCf4iO/q
   QLhQ4modXDz2v7efD6nR2xkWUhTWfvtynQ3DTFoEc+vYpVMdMmxliZBk1
   Q==;
X-CSE-ConnectionGUID: OLHmibVWSOSHeBabgyEFKQ==
X-CSE-MsgGUID: OH0ogBkARUKzeqNCkkwOnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98582247"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98582247"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 22:40:49 -0700
X-CSE-ConnectionGUID: hDnCE9y2Q2C+HmtvHQtjUw==
X-CSE-MsgGUID: 4n02n5I0RKC/+IY0rv/OgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="267473279"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by orviesa009.jf.intel.com with ESMTP; 23 Aug 2026 22:40:47 -0700
Date: Mon, 24 Aug 2026 13:40:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v3 08/10] hw/i386: Reserve AMD IOMMU HT GPA range for
 Hygon
Message-ID: <aovZXpnT+Qc2MFtn@intel.com>
References: <20260824045314.162941-1-zhang_wei@open-hieco.net>
 <20260824045314.162941-9-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824045314.162941-9-zhang_wei@open-hieco.net>

On Mon, Aug 24, 2026 at 12:53:12PM +0800, Tina Zhang wrote:
> Date: Mon, 24 Aug 2026 12:53:12 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v3 08/10] hw/i386: Reserve AMD IOMMU HT GPA range for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> pc_memory_init() avoids the AMD IOMMU HyperTransport range below 1 TiB
> only for AMD vCPUs.  Dhyana therefore allows RAM, hotplug address space,
> or 64-bit PCI MMIO to overlap 0xfd00000000-0xffffffffff.
> 
> Linux supports Dhyana platforms in the AMD IOMMU driver.  The driver
> reports this range as reserved unless the IOMMU advertises
> FEATURE_HT_RANGE_IGNORE.  A VFIO device cannot DMA to guest addresses
> that QEMU places in the reserved range: VFIO_DMA_MAP may fail with
> -EINVAL, or the IOMMU may report an INVALID_DEVICE_REQUEST fault.
> 
> Apply the AMD IOMMU HT GPA layout to Hygon vCPUs.  When the possible
> address space reaches the reserved range, move RAM above 4 GiB to 1 TiB;
> also expose the range as reserved in E820 when the vCPU can address it.
> 
> Changing the GPA layout affects migration, so enable the Hygon behavior
> through x-hygon-vendor-abi-fixes.  pc-11.1 and older machine types retain
> their previous Hygon layout.  The existing enforce_amd_1tb_hole setting
> continues to preserve the AMD layout of pc/q35 machine types through 7.0.
> 
> Add functional tests for Dhyana with pc-q35-11.2 and with pc-q35-11.1
> compatibility.
> 
> Signed-off-by: Yanjing Zhou <zhouyanjing@hygon.cn>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  hw/i386/pc.c                                  | 26 ++++++++++----
>  .../functional/x86_64/test_mem_addr_space.py  | 36 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 7 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

