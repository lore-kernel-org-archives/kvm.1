Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC862E88AE;
	Wed, 28 Jan 2026 03:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769572145; cv=none; b=G24tIj2TOn/u8C2MOEMDWpcZnK9845t9/9PNkTbWLEEhDpRI1IkzNoAVOZgqBLngTHRM+B2hxNGrlWtM7Nqoc2nlBauK1q240vQTrFV9zv9RbCv0vR7EDNUByZfEsZuOJBp2VnsYgcgJ5z7S9MoM3bSYk0BnRCubSN+CUjNvRRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769572145; c=relaxed/simple;
	bh=JEInsxDBPN2DIxqOvjK28VDDL0LDVEEQdtfiKhFcBZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dqcwpoy0xPdgCEbOYrRFdwcGU6ZwHTGpW1tdHi6K0Uu397P/190N6yhbJmfrUHIWwcWWNV/WCZUIdpE0s+MFTvNL250GTjNE2Rk7TIB1PWn9s3rDeM0r8aa5Wh8hhKFXgrJuAGe0/zZLiwhnKZHOMdYD2FKvoDPHExIY+IBHvsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CSz8Kgpq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CSz8Kgpq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769572143; x=1801108143;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JEInsxDBPN2DIxqOvjK28VDDL0LDVEEQdtfiKhFcBZU=;
  b=CSz8Kgpq102Egk0+/PpkNvlItBGNOMc1t3SPsWl9XaoY5lxoWAkA1Dre
   Xkp24Ag9fpzkgZL5HS/KEllTf4ulgQMl1ouH7jOTzXtpvPegLI2s8oATS
   sgZPjtfwtvG+ZHyEY6bH0ndlBgWBV0RBVc6qQvArBi2DrJg6c5mQXEugS
   vC4WoVZeuQHQ+L+cN487xqqDI7QKWVbfcszHBXtSGd1bLFyRyMXeYpEzZ
   t618+RBSPSEXf4mecAKKP7w0EHiocmFE5MBl8klIMzNyqW9LFGQP/LVxA
   FCKyrm/uKykJPnMFm1YE+uqLtPOrQRb5+RMhmBxOCxzPpA5h+4Ac2JeQ7
   Q==;
X-CSE-ConnectionGUID: 7VH/t2QAQpm0A1dc1JdlmQ==
X-CSE-MsgGUID: aMV8WLBOSga/LZKA4EXCuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70494623"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70494623"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 19:49:02 -0800
X-CSE-ConnectionGUID: V80mBH3QRqmUGfVZd+f6CQ==
X-CSE-MsgGUID: YsNrojkCRyK6tsHjtXu9WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="231102849"
Received: from unknown (HELO [10.238.1.231]) ([10.238.1.231])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 19:48:57 -0800
Message-ID: <851f39a1-1db8-4d54-a5cd-e44cca12b5eb@linux.intel.com>
Date: Wed, 28 Jan 2026 11:48:55 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/26] coco/tdx-host: Expose TDX Module version
To: Chao Gao <chao.gao@intel.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, x86@kernel.org, reinette.chatre@intel.com,
 ira.weiny@intel.com, kai.huang@intel.com, dan.j.williams@intel.com,
 yilun.xu@linux.intel.com, sagis@google.com, vannapurve@google.com,
 paulmck@kernel.org, nik.borisov@suse.com, zhenzhong.duan@intel.com,
 seanjc@google.com, rick.p.edgecombe@intel.com, kas@kernel.org,
 dave.hansen@linux.intel.com, vishal.l.verma@intel.com
References: <20260123145645.90444-1-chao.gao@intel.com>
 <20260123145645.90444-6-chao.gao@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260123145645.90444-6-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/2026 10:55 PM, Chao Gao wrote:
> For TDX Module updates, userspace needs to select compatible update
> versions based on the current module version. This design delegates
> module selection complexity to userspace because TDX Module update
> policies are complex and version series are platform-specific.
> 
> For example, the 1.5.x series is for certain platform generations, while
> the 2.0.x series is intended for others. And TDX Module 1.5.x may be
> updated to 1.5.y but not to 1.5.y+1.
> 
> Expose the TDX Module version to userspace via sysfs to aid module
> selection. Since the TDX faux device will drive module updates, expose
> the version as its attribute.
> 
> This approach follows the pattern used by microcode updates and other
> CoCo implementations:
> 
> 1. AMD has a PCI device for the PSP for SEV which provides an existing
>    place to hang their equivalent metadata.
> 
> 2. ARM CCA will likely have a faux device (although it isn't obvious if
>    they have a need to export version information there) [1]
> 
> 3. Microcode revisions are exposed as CPU device attributes
> 
> One bonus of exposing TDX Module version via sysfs is: TDX Module
> version information remains available even after dmesg logs are cleared.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Link: https://lore.kernel.org/all/2025073035-bulginess-rematch-b92e@gregkh/ # [1]

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

