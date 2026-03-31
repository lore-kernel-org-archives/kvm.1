Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C593A6B93;
	Tue, 31 Mar 2026 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952523; cv=none; b=Zi5OcUZo5jP5fnHlLuusYI+IGVbuPeokSKdExGK2ulxx9I3dWPYnGWZIb7A5G9LL2AggR6adPoHu+eH0emHUeBfIcM8Zo1n5s1kqjjJZIj+XeQqIg1RzaTQOUDP5z+Ku0E+SyI7sUcC3H+y3tYpHvXOGzpczVEtSPvN2+TdAsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952523; c=relaxed/simple;
	bh=x/upyC6Flco2VSJUepGtrV3Mrfgu1ZtbmysiMpYZTuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsRZjeaGdqyngQrRWteQ9Y5xwVedA0tUoVO1Y9AsX0axnD7kvUwa1+Didvw8uKKJq1f7Cz2jZqOoViVpXl0d/RAfKg708dauGAh+806tKqO99FRJmHNUIoBTOczboBg1HdiCGYm6x3SATRmoEsJEps/QMy9F/ozlEmtfQZFdQYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nO2yrtRQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nO2yrtRQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774952522; x=1806488522;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x/upyC6Flco2VSJUepGtrV3Mrfgu1ZtbmysiMpYZTuU=;
  b=nO2yrtRQS+7kKfJOccl8a8iFZe+UOfj0DILsTs/rw5MYMEHH1+jHVHhH
   gk28AlFnOYPhDToRKDJRDLlOJ+j8QKtnwxOM55CQhV20rRDL/yUQt3CnY
   ivcqjuI/NcLN5/CSMqlbopM76sYt9Fxm6iDHHgdF8xhyIvYo6IHUZlURU
   gPCHffmAfq+JutP8/mP7pB5F5Xu/tBbT0ikQNDaZ4Xmfh9vQeJwH63LYY
   7OjcqehLKMX1ApPC4Z4qxPLu3mWbEdvPQdSSNF96XBtzFqYQOL20jL80b
   jblnOz26U3pHJngMe1PoOa6T87et0+yK2I/2vgCgFfIucmx4WQjDKLhGO
   A==;
X-CSE-ConnectionGUID: kzxZ5EK9TvG4oxrmC893YQ==
X-CSE-MsgGUID: uLxqDDWqRNSw2CKDAWkIYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93348349"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="93348349"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:22:02 -0700
X-CSE-ConnectionGUID: zNp3fHVxSqSJEvGsfmcNSw==
X-CSE-MsgGUID: v4F2eMqLQ9+BsCsUZpFQbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="223028735"
Received: from unknown (HELO [10.239.158.60]) ([10.239.158.60])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:21:56 -0700
Message-ID: <00403820-2767-4d3c-bca7-0341d9dd1500@intel.com>
Date: Tue, 31 Mar 2026 18:21:53 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/22] coco/tdx-host: Expose TDX module version
To: Chao Gao <chao.gao@intel.com>, x86@kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: binbin.wu@linux.intel.com, dan.j.williams@intel.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com,
 kas@kernel.org, nik.borisov@suse.com, paulmck@kernel.org,
 pbonzini@redhat.com, reinette.chatre@intel.com, rick.p.edgecombe@intel.com,
 sagis@google.com, seanjc@google.com, tony.lindgren@linux.intel.com,
 vannapurve@google.com, vishal.l.verma@intel.com, yilun.xu@linux.intel.com,
 yan.y.zhao@intel.com
References: <20260326084448.29947-1-chao.gao@intel.com>
 <20260326084448.29947-4-chao.gao@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260326084448.29947-4-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/2026 4:43 PM, Chao Gao wrote:
> For TDX module updates, userspace needs to select compatible update
> versions based on the current module version. This design delegates
> module selection complexity to userspace because TDX module update
> policies are complex and version series are platform-specific.
> 
> For example, the 1.5.x series is for certain platform generations, while
> the 2.0.x series is intended for others. And TDX module 1.5.x may be
> updated to 1.5.y but not to 1.5.y+1.
> 
> Expose the TDX module version to userspace via sysfs to aid module
> selection. Since the TDX faux device will drive module updates, expose
> the version as its attribute.
> 
> One bonus of exposing TDX module version via sysfs is: TDX module
> version information remains available even after dmesg logs are cleared.
> 
> == Background ==
> 
> The "faux device + device attribute" approach compares to other update
> mechanisms as follows:
> 
> 1. AMD SEV leverages an existing PCI device for the PSP to expose
>     metadata. TDX uses a faux device as it doesn't have PCI device
>     in its architecture.
> 
> 2. Microcode uses per-CPU virtual devices to report microcode revisions
>     because CPUs can have different revisions. But, there is only a
>     single TDX module, so exposing the TDX module version through a global
>     TDX faux device is appropriate
> 
> 3. ARM's CCA implementation isn't in-tree yet, but will likely follow a
>     similar faux device approach, though it's unclear whether they need
>     to expose firmware version information
> 
> Signed-off-by: Chao Gao<chao.gao@intel.com>
> Reviewed-by: Binbin Wu<binbin.wu@linux.intel.com>
> Reviewed-by: Tony Lindgren<tony.lindgren@linux.intel.com>
> Reviewed-by: Xu Yilun<yilun.xu@linux.intel.com>
> Reviewed-by: Kai Huang<kai.huang@intel.com>
> Reviewed-by: Kiryl Shutsemau (Meta)<kas@kernel.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
