Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334302;
	b=JmOUUwNT0TYO7UoGvWQoJWn5J31m9g1aQJdLelhrpVR2ci493Xzoi58h4eniBGgfaXlx
	 EC6uS1RLOWfyDIGQEGntmGj4bdjGHN/zen262NiVZTMByi6FeRIMxf1jV0r8m11kKnqQc
	 9z6OH/rF6cTKZtYnkil/kYZBD4M+DIOB68+0mqQDEhM8EG2dfGSKD/87D0/DVNrokjuzA
	 3Mdr54ppiNRk+mRUijLJEkP/kaTMFj9CiHQVd0h+y6ZRK89/6EyyN/7EjHf4HTSPc4+s0
	 8PuJN+5qzKZ5EQsUD0d98fsmSNEAKMPaSJHy5mG9m1BJBXivIET7lMToF2zzgYJI9/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334302;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=6UWz2r4tRe+d5sBTZILDgcPvXY2QrlO5HEjGBHt0YeY=;
	b=EpXEmWewMbIN4kk5uOaeXWLF+SKqNvJGL6tsAWs1RNwB3OgVyDZMrCjmb8tzc852UP2T
	 eTd8aiZK0QQm0YCgk3TQMRKTwZVWQzb95nkyRCKNX3Wni5serRyvLh0TrCOoE6+MDZa8/
	 ceXg0n7NWf4uhhUeOoXXwqAH9yKmf7+02GBM99jlu5LzpqP3X5cRyBQ391X3An6fd9P2t
	 FfZokZXFsGv0zjp/OlkAYTTxRDBa0u6+y9X61inAJnx5iQB66pNkfzhVy+m5Ws16jZpjD
	 wTUsFDN+bgLHPKRwet2rkpeEiYOB1nAHViNhtt/QZLPIhk7e1SvmNMJr3ap4PV/b9mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SE+99AQJ;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB94606A31C;
	Fri, 30 Oct 2026 04:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDB94606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SE+99AQJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793334302; x=1824870302;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JN7BobmyqJQz8QBWSFXXVHvnF+XO9EeeYbr8xgk6MLM=;
  b=SE+99AQJL6C2dJ3d6bU2xZ4Z67GNzPqKZjkcH32bdfyKQqS7NGWSApjd
   Y76O85cXV/jGJjckMD/7D4H0RWgPmM62o5ytFGkHVKsUHixPNVeiUHPAK
   EaJ11wAiaX7ji4PrOHBiJ4SKhMLD1kmjd/WrtnN0QoAsRoFlKwcU1HGsZ
   nkFvZIK7HznrWv2I76MIDAlIlu1HtVrCV7C3QwllfGtViMSGKlqWnxjb1
   oubkCSNYJq92gI2H+T1TKIG8jwB9QWnXgi95klkLVEct9V//zIhJqeT2n
   +T1Z4Og9dlwFw58VL6aJ/lnZwStxvK0mSh+lKbRr/UDw2iQ8UhP5c2LSW
   w==;
X-CSE-ConnectionGUID: KT4+xEJ2QB+BoQd5ID4xlA==
X-CSE-MsgGUID: G5a03fyYQTW4gw9GrhfxkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2000148"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2000148"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 21:25:01 -0700
X-CSE-ConnectionGUID: Qtddq/EBT++4lUoxFz+C5w==
X-CSE-MsgGUID: +WO64qkMRV+E/MtMOoE/KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5735215"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 21:24:56 -0700
Message-ID: <3be0b56c-4689-46cb-b6e4-b1ae43be5b08@linux.intel.com>
Date: Fri, 30 Oct 2026 12:24:54 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Pranjal Shrivastava <praan@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma
 <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>,
 Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 04/18] iommu: Implement IOMMU domain preservation
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-5-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261025021930.674647-5-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
> Add IOMMU domain ops that can be implemented by the IOMMU drivers if
> they support IOMMU domain preservation across liveupdate. The new IOMMU
> domain preserve, unpreserve and restore APIs call these ops to perform
> respective live update operations.
> 
> Reviewed-by: Pranjal Shrivastava<praan@google.com>
> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> ---
>   drivers/iommu/liveupdate.c       | 119 +++++++++++++++++++++++++++++++
>   include/linux/iommu-liveupdate.h |  11 +++
>   include/linux/iommu.h            |   5 ++
>   3 files changed, 135 insertions(+)

This patch looks good to me,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
