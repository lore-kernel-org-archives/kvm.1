Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816B366DB5;
	Wed, 18 Mar 2026 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822087; cv=none; b=FP9tyCgsjWfji3SNl7ep0w1CS5zrzeO4f455F38RLjZZbHfzNFYQxJ/6Cm/9kYbtygzz88Dtr9QYi2A6IOt3ow+lJD9xHxtib+1gWNaZaaYw/zwCxX27eq264CAdx2XTnIO2vHwQCxj6IAChWrjITYccQ9k97+SF/CVIH4g1G/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822087; c=relaxed/simple;
	bh=FPudge3zWky4JgkJ2CzWImBQKCAamkvAEd84fTbUDFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOYI2OYyXwa45LtbDNtswv8yml/U+gmF9K0STZNN5o+9WViqz2vDdmM1PkHrzkNZD6JGIaJTwxBPatDYV2DmGEAiRlLsOdQLM9+fQgL0We60/z6m5Yut7WOkYOg9LODSrZ/rPpHRkEqXYdAFScbStbHaxOahaHxWIDVeTVnYOiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZ6RWISd; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZ6RWISd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773822086; x=1805358086;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FPudge3zWky4JgkJ2CzWImBQKCAamkvAEd84fTbUDFw=;
  b=hZ6RWISdM2UOAejsuqUxwYOZn3wraUUAU1PkijbYa6YY75PV62ZNOfqE
   oTrJk0uiPkRpVLbTClYxktLarmX+3/O+CDuKvJLFsCuY1hx4QQOM1atU2
   N9Ci/ZcHxKcOqiK6R26lQ5v5Qzzj3BMyPej3edz3Awp2g28V3C0ppB8eP
   tdchLvoI/JJ+3xKy7bFpg1sn/pqxWdYz+le8LbodgonekE1m+8aKTACDP
   la4D+iBfl13GH8fsl2T0b2s5Ui0eZXjI8vOC4Wz9EK57LBLxf2b1uuk1I
   OPfSU4YZOY+YqwlngMbrUUh7Q1OTFOPgmQJaBcfLlmZRdFqeQl9eHdvfd
   w==;
X-CSE-ConnectionGUID: IgmCpgr9T3ig+mxtMn2Mbw==
X-CSE-MsgGUID: EaqH3Oi9QgqJ/XcJnr+nng==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74900226"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74900226"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:21:05 -0700
X-CSE-ConnectionGUID: SRkrFRMpTUaBBmE7YvOBmQ==
X-CSE-MsgGUID: x4yMd9LTQKWFZxFPnVhlfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="222603434"
Received: from unknown (HELO [10.239.158.72]) ([10.239.158.72])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:20:58 -0700
Message-ID: <3614e6fb-bdad-4e59-9769-5dc9869e03bf@intel.com>
Date: Wed, 18 Mar 2026 16:20:54 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/22] coco/tdx-host: Expose P-SEAMLDR information via
 sysfs
To: Chao Gao <chao.gao@intel.com>, Kiryl Shutsemau <kas@kernel.org>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, binbin.wu@linux.intel.com,
 dan.j.williams@intel.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
 kai.huang@intel.com, nik.borisov@suse.com, paulmck@kernel.org,
 pbonzini@redhat.com, reinette.chatre@intel.com, rick.p.edgecombe@intel.com,
 sagis@google.com, seanjc@google.com, tony.lindgren@linux.intel.com,
 vannapurve@google.com, vishal.l.verma@intel.com, yilun.xu@linux.intel.com
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-7-chao.gao@intel.com> <abkmceqUtMTnLI0V@thinkstation>
 <abpMHxwhYqbmrX8s@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <abpMHxwhYqbmrX8s@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/2026 2:54 PM, Chao Gao wrote:
>>> +
>>> +What:		/sys/devices/faux/tdx_host/seamldr/version
>>> +Contact:	linux-coco@lists.linux.dev
>>> +Description:	(RO) Report the version of the loaded SEAM loader. The SEAM
>>> +		loader version is formatted as x.y.z, where "x" is the major
>>> +		version, "y" is the minor version and "z" is the update version.
>>> +		Versions are used for bug reporting and compatibility checks.
>>> +
>>> +What:		/sys/devices/faux/tdx_host/seamldr/num_remaining_updates
>>> +Contact:	linux-coco@lists.linux.dev
>>> +Description:	(RO) Report the number of remaining updates. TDX maintains a
>>> +		log about each TDX module that has been loaded. This log has
>>> +		a finite size, which limits the number of TDX module updates
>>> +		that can be performed.
>>> +
>>> +		After each successful update, the number reduces by one. Once it
>>> +		reaches zero, further updates will fail until next reboot. The
>>> +		number is always zero if the P-SEAMLDR doesn't support updates.
>>> +
>>> +		See Intel® Trust Domain Extensions - SEAM Loader (SEAMLDR)
>>> +		Interface Specification, Revision 343755-003, Chapter 3.3
>>> +		"SEAMLDR_INFO" and Chapter 4.2 "SEAMLDR.INSTALL" for more
>>> +		information.
>>
>> Do you think revision and chapter numbers useful here?
> 
> I think it's nice-to-have. Without specific references, people would need to
> read the entire 26-page spec. But I can drop them if they make it too verbose.

I have some concerns about the "revision". The good thing is that it can 
tell what the attribute was built against while the bad thing is that it 
might not be easy for people to find an old revision years later.

