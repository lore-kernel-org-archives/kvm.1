Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C799394793;
	Tue, 31 Mar 2026 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951670; cv=none; b=rymcZPtAFVcwj3w6aZZxyISe3drudLSQejkjx+xT7po0CCtu1objiF9XAfXK/qgeZNwE4AQwY4SyBaNI0VBwk3CewJ0Fwlzp1TFZU6R1j6PnhnNl2eNZh16zgSoiZ6g/EutUehiT9Mw62mOQ4X72R3ynfDANBCo6UyWGv+LRFX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951670; c=relaxed/simple;
	bh=3QZrA4YMv3/Wz4N/OrnUaPim84/7pShEFAyMqK0EHAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAHxmsuSRWLHRrQT4z7oBlU4cUDUa2t14O9XUBnmUmHEN+y1DJ7BpKJ4Qlee/DHsz1meJZGqpsM//0dXB3bxv96RM2zR1SRNRSDVoP4z20pfzf/c/3U260uUVK40kQX6UvzGoujOL9CDSW5+vVBgrJl9GkMtUBIIe0ImO500S6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nCVs65om; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nCVs65om"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774951670; x=1806487670;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3QZrA4YMv3/Wz4N/OrnUaPim84/7pShEFAyMqK0EHAc=;
  b=nCVs65om/KgubZgQo3T91ylp2CpA4lceU1KYtQpd9Ay2/rmSuLQ+FGP9
   1PU4MvQ8xeLJOn4Np3hvRYvGGv0c9fYb38JWQq7bQaCx6Kf3NkwoAob4R
   YKXIfu7oUXEsQl1EfTsRCxdqU2Gau/tjMp1UIiYMZ8zbDLLC0EaB4q6y0
   2DvkpaqQpmNb+IpujGsLJbnPDR2haRhuyJfUOnvQnduFkIR8Y9VRbEaED
   evsJjB/PoSb0selm+yF7VLmtMAeY2ZudJHAfZF18aYEYh1lxSG1QM78PG
   QP3ONmqCf+6/N992ZGZfXTBOS3HuxVaUSSythlSCyYzyhbrYxEC8/CCSQ
   g==;
X-CSE-ConnectionGUID: A1eaHIHrQqaobH6t3GhNQA==
X-CSE-MsgGUID: 0uIcsIgmQJaRmxwmbh8Tng==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75977375"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75977375"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:07:49 -0700
X-CSE-ConnectionGUID: G6uMBpbfTYq8QSYLgbifyw==
X-CSE-MsgGUID: i8fJAZOxTeWcGW8JEREtIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="226575108"
Received: from unknown (HELO [10.239.158.60]) ([10.239.158.60])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:07:43 -0700
Message-ID: <1e546570-68dd-4207-ad14-5276b37ab295@intel.com>
Date: Tue, 31 Mar 2026 18:07:40 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/22] coco/tdx-host: Introduce a "tdx_host" device
To: Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org
Cc: binbin.wu@linux.intel.com, dan.j.williams@intel.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com,
 kas@kernel.org, nik.borisov@suse.com, paulmck@kernel.org,
 pbonzini@redhat.com, reinette.chatre@intel.com, rick.p.edgecombe@intel.com,
 sagis@google.com, seanjc@google.com, tony.lindgren@linux.intel.com,
 vannapurve@google.com, vishal.l.verma@intel.com, yilun.xu@linux.intel.com,
 yan.y.zhao@intel.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20260326084448.29947-1-chao.gao@intel.com>
 <20260326084448.29947-3-chao.gao@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260326084448.29947-3-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/2026 4:43 PM, Chao Gao wrote:
> TDX depends on a platform firmware module that is invoked via instructions
> similar to vmenter (i.e. enter into a new privileged "root-mode" context to
> manage private memory and private device mechanisms). It is a software
> construct that depends on the CPU vmxon state to enable invocation of
> TDX module ABIs. Unlike other Trusted Execution Environment (TEE) platform
> implementations that employ a firmware module running on a PCI device with
> an MMIO mailbox for communication, TDX has no hardware device to point to
> as the TEE Secure Manager (TSM).
> 
> Create a virtual device not only to align with other implementations but
> also to make it easier to
> 
>   - expose metadata (e.g., TDX module version, seamldr version etc) to
>     the userspace as device attributes
> 
>   - implement firmware uploader APIs which are tied to a device. This is
>     needed to support TDX module runtime updates
> 
>   - enable TDX Connect which will share a common infrastructure with other
>     platform implementations. In the TDX Connect context, every
>     architecture has a TSM, represented by a PCIe or virtual device. The
>     new "tdx_host" device will serve the TSM role.
> 
> A faux device is used for TDX because the TDX module is singular within
> the system and lacks associated platform resources. Using a faux device
> eliminates the need to create a stub bus.
> 
> The call to tdx_get_sysinfo() ensures that the TDX module is ready to
> provide services.
> 
> Note that AMD has a PCI device for the PSP for SEV and ARM CCA will
> likely have a faux device [1].
> 
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
