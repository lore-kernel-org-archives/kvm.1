Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B793C3C13;
	Fri, 27 Mar 2026 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774597400; cv=fail; b=lLGZsIVXQnJTMQHbQj7qerWczPhN9jJbbb5/DQYRfI+R8zZzQ71kjwH3SKMOkZvOncO4fBSviC/IAOfHtSgIWNw2PVVzClEsptw7y+BU1kW8CYcvyOj6lEJqTN+t7pBjqQvNHwwSNoa2QUWaMpmxzNfhVFKZmY/UxTDm89dPdR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774597400; c=relaxed/simple;
	bh=Ell2f2r1XJA9eRewFLHrMbUb5LhNDORDxgD09i1P4w4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=izUQGtSeRJyvBk79XkNjJYcx9N0Qx7jHodANnacGbn6SW/uOU3NcZFakz1Bs+BzbZnmy0KexwdoGyfqDpuhf9PUEnKJq4WaJBfhKTcjemGsLAqqMuPZvB0htfqpcLDLAS/G/8VLdmDoN1fP4DYJXfab5Ylcn/x4Nz6hbhhjStQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/2mrD7b; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/2mrD7b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774597394; x=1806133394;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=Ell2f2r1XJA9eRewFLHrMbUb5LhNDORDxgD09i1P4w4=;
  b=j/2mrD7bjEYBR9ON2K4e5O/N2VUYNi6eDi5XvxH/u+1n3FvEFLVtoe08
   ZeP/GWLCdYbnkvnY4+BmgJHa3Q4S5JvBbEA+I3rLD8MtFNk9y/34iP1ED
   5f301t2wGcq8ucq8ii42U4xUcOS+CYvsW0silm9Bcf56xqJlP+neIav/R
   N/qjPSAlSpC+HE9uXW8d3sNzZ8L4I/TvAw0660c7xy7hk8bss5VMygMv+
   FrNzX0Sr7XCbc7zfTAqiQfYeoiqVfg1KWLwGXzFWHvb4su030vSda3dcV
   mCbDwvuE4LyO9nIveJJM99zenhG+ypjmbfPaOAe8IpnU6Erh8yRkeIDnM
   g==;
X-CSE-ConnectionGUID: OOBFQi6NQseJe6JfHZ22IA==
X-CSE-MsgGUID: +40x4p7ZT3+owQNh7DtNYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75781063"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75781063"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:43:12 -0700
X-CSE-ConnectionGUID: 95/FsdqbQr+LgfCh22JtKQ==
X-CSE-MsgGUID: GDKFd3NiSxqykxhdN9ecqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="220393130"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:43:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 00:43:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 00:43:10 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 00:43:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzAEcB7V70Ij/1r/9KILAxBvP84v1cXYAlwco1d+GDVBCX9IT2piZH2lD2emZc4bF6/ghYwCR3MEzfmu5VWnmOHH8r1wiV/AYQLahaXJSQLYyGD0wQo1aV5bhVj7x1deiI8GI4c/kYPqTtq8VTm4mCfOnnUxaHE1PSW/cKQPjr0WJKm+bwKPlRG5mYyu5xMh92PsmfX/jLA3r5zHBcuwc88tpJILlUkfEW61K9JnqW4VJp9VkSHDm6to26rAPu51jyYr+ePC7598iUVYcijTgRf1GaWjjEweTvnp0Pfx4OatnAP5VIzAlBz6NLT8WI4kbLQrA2TzH7j87pNFcjNIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0DqXcpYSptwhxElgeKOje66Gf5dimp3W+O4rcF5e34=;
 b=lFGJutYqU70wyt1nj3zXE5+kzsI+R/cTjoA41vSwyOTCe8aPRtY5st9MDkx8guRus7oOST7FfuCIBLTRrw2zol6UmjwVnrvMmDiDUlrE9m6MLYNoa8xzOBqc3vFKpLN2ZAyjiVnlIEiUlYajpeReG4CgofTQq9nMyXHCVLGaoaicUikbTbij7M/YQ6ic6T3GA4Osu6MKDD8yE5z9DXBPvSK5HRD+Wp44ihp+lkQXp1qfTTIIzxY5zRMWaaIihCog3rBLmgjDPKY6MaDdWE41Yo03V6zW9iU9Y4Au3V9Cp78BiFxIFJ9BNT5GrEp88pPwksUheFwj84d+pGyZytvujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by MW4PR11MB6740.namprd11.prod.outlook.com (2603:10b6:303:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Fri, 27 Mar
 2026 07:43:07 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 07:43:07 +0000
Date: Fri, 27 Mar 2026 15:03:32 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yamahata,
 Isaku" <isaku.yamahata@intel.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"tglx@kernel.org" <tglx@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
Message-ID: <acYrxIxoENyZhKCV@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
 <20260319005703.8983-1-yan.y.zhao@intel.com>
 <a14531ab-f069-41f9-8c5c-9fe6f28a9454@intel.com>
 <acOmoOP2fFUyOByC@yzhao56-desk.sh.intel.com>
 <189f00877360117ab91ec3a6cb8b8239f4fff06a.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <189f00877360117ab91ec3a6cb8b8239f4fff06a.camel@intel.com>
X-ClientProxiedBy: KUZPR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:26::13) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|MW4PR11MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b706f30-d136-4c46-ddde-08de8bd47c32
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YBd9ZoEp8Kx3d2j/xfgVm/Bh5dEpBXfI/FRBXfo//YHTqfQHFF5PlzN+5N5lLxQBW8HWiDIVbbhfOU0hfoCi9D3kKCbxBwAOxNR21IHlvNKboioK+Q+wfeXBMT5uS+FlZ7BG+DvAXMZInejeJGBAr7BojNcI3h0eOOdupr4gYu9j3WDv5NOWgFNNA2+wa8yKZW4ZgpB8NVqgtVKR95pbKHOYgTYx6+8d66G1hQRLbuEWPdD0vAKOGTEXkrbSemQSUGFSlwiIwxW5md8gQBDVDZ/C6sVeDCJe+GZ+8mPrh1GhkBqB7cWmYvjYwH86JshhQvECTXig8tjOhYAg8kTp93CQ0XZk49Sasu1QOPsxFzvZp+Vn83CmO1KAI8LJMNMa4mZ5x+mPnN9uc5fzUAVO+Ckgcw38V9aw892q0W2m8YqQgSf1YKAC2+4ue9m4RFNF/P/J2xtzUvY3YLqhhoRrW2OI0QyulJ6jk0XU3p9LfaLdJ8VmLu9/HB5/OQTMgWj6CI4sogZXshQuZGrbE0PnUcs9ea3BnlL6KLBMmewX6KVFJPHNGj6nWC8b1qfTbLC24IYTW/RtI/LHPY8MKf3Ghnh0IyGbV/zfJ0/WgsfbXWlyrAlNRZUit5GKerNYivEhMuWRozuyJE9KxoFeXLhu3yYj7Tq568Fp5XfTIjHzHhtvJKvcwrKZERVMwmQadCg4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M/r52yyzhu700b/53mV5XWG/8aOpHLaHNhcqL08+y9n7L4mxvD/Vv9TRQyDm?=
 =?us-ascii?Q?WHJ8j4o278TkFhTtnOWsAOOyz7EAsu9kaz6kwK8ivZ5LRc/FsFaqFSg+igtY?=
 =?us-ascii?Q?8MnN5ruIibTRIMwpI7nOOZghN8ZJfXG12Rl7SS2zfKgp04ytSPwzkg6CJvDn?=
 =?us-ascii?Q?baraI2380Q+RvgXIZZB21V8d5GqUGbaY7NzE6Tlt2PDs/rS65S439iw3LDy0?=
 =?us-ascii?Q?2GX9DlzCivdJ7MCAIFAoDWTSzDMPDL41Tivm+ho9LaMhQ7aOKzI/d4ukcsZS?=
 =?us-ascii?Q?J0jBNKm6+nG9/audmjStxhlKCD4QlpmM8THnV35vYOvFFujfZ7eIh58wqie/?=
 =?us-ascii?Q?BZM+GWAv+vkTwi/Mi+VLrP09JtF3AUS6cy/7R0vxSdCVazGGocibngCaFCTe?=
 =?us-ascii?Q?cTNlQadOEXbE0Ot4VBCgL61Z2Psd841BGRVtRR3WClaMm5rhQcjdUFuTyz7M?=
 =?us-ascii?Q?43Q7DSmPBMKkJMG4gsQDLIKwOTUljjSn2/vWvyYgrtc5xJKrXouz0sIoHD5P?=
 =?us-ascii?Q?7643i16rB3bF3JwJRjbpEBtjflDbjkTXPaMXIJjkAxNfq7IDcicniqUCW9B0?=
 =?us-ascii?Q?87fcd6neZ/ILQ1TKHkOqaZwfvwDVAHxAYMEh44PP0P4CiLPi69ousBkqcAzU?=
 =?us-ascii?Q?5FvBV8xQX7ga2fYeRvjw6jxu6DjuPvjzpWafzt3kMcSFmgyjtdUkm/fkHXs3?=
 =?us-ascii?Q?nlmJ1zA/liyKBqVUx1+HvqYli4OuO7L+LzcGyJQrzjaOdZux3jvjZnbp3hqs?=
 =?us-ascii?Q?wk8XNi9KLj0Duo8eAZ7IOyFoxbdzy0y0F/cxaLbnSWR7zOYB9c2xrmUgw97o?=
 =?us-ascii?Q?KnT4L9Eveo0N7m/ixTCs6O2BYUgeoCjCGP9MROfwQg7xSc35HpcjpWQ96xMT?=
 =?us-ascii?Q?1LylS7i7qUJNE8BsOmBpBOIpiRVIuTQmYbCI/kM0J31k2QdhMbDcEavyqzD0?=
 =?us-ascii?Q?nVgIq4OI07uEECbThjtXBzCD6Iu3O0BV7+Wa4OJSpNOkGDyoefuUGyl5x3IM?=
 =?us-ascii?Q?U2yLLWqIUlfyckYAnQgbh9Ik+7KWOgg6Fq62EaZZxpdvsZ9OHdOE2WX8ijfU?=
 =?us-ascii?Q?33pjWKDk0rRJ3PI00ZBL7pNdyuPAjtN567gSlnI111mF2C8YUwe0mcWrEfHT?=
 =?us-ascii?Q?5+qzyLpaCA9iTLFio4TLAQm8e2MV2jbJ1sGf4uH5wwE65mK3WI1pH5rutm8R?=
 =?us-ascii?Q?yxGAylw3iAK9/VE4HD/cuSotkhAv8eeR4gJNCqyzNTw6WrK0hmW5o2bgYj+p?=
 =?us-ascii?Q?7dKUDQoFnuAYNEwKdTz+IjIgwNgsa/HtgxUsHg/KRUj/1ReTwUrOmajvhCSg?=
 =?us-ascii?Q?sz4u1IGwwUHva9ffzNmNTVtr2DEfkvRw6I4nDdX5R1CvK3QNV1XJyDuwMfrj?=
 =?us-ascii?Q?oosjkQArf7WwvzKLsJgHCTIE0VvEqRnJO26d/5vnTjH8fPaT7hn8nSpwxFME?=
 =?us-ascii?Q?46834Fn8Vn1XIABRMFY+K08WoBXAWgl1erUl1rWdBm8AfDvbFSzBK96E5RY1?=
 =?us-ascii?Q?mYrH8fAoLKDSt8pf9bSuX7/94K14FLReTgznAcnkQ0tq1z3a+K3GCJ2KdCak?=
 =?us-ascii?Q?086ZpYdy0NJ++MKnligTt7wuTdQhjrcfr37cYUwcwXWxR5zoX++hxGi+XazG?=
 =?us-ascii?Q?ZMOTdxYkdKCnWH7mmPZEvzvVSLuaD1k3+cHLvZij1jtT1E5+BzDpfEbpxb30?=
 =?us-ascii?Q?Eo1zCr6hzS0NcZEwgWrJTTBLNXRvmlsxV/4MnyrBVMmT3PfJsVLbqLnqtylk?=
 =?us-ascii?Q?bGLvDh2PVg=3D=3D?=
X-Exchange-RoutingPolicyChecked: R6dqyjbS0ciTBkBcSfCfDed6jDvqPOG5d6uuGw9b8i6OEuTzuVy6yusoli6Vw+RgldojAL+zZilBQqYeRGqSHnNXw9mnEhAvUVEpsg7Rw7Drhm3Kv1UzgHKuOtln4pSShfRuCtc01BRuPJQdUgzuwC51VSrNEckZjWG2yyjC1AzPzPidkdIk0PCbKUwfUjdMzC7MHzF65sliEEI5LbM5D3CFfz1TpKrT+c121J+Q74UCWJi3o+6qtfW2jG6uNpfLALYz4e1w+hN96DsWV4WPcYDG5Mv9ycrCeSkDhFYDwWfK+X589CJ9v4xHg4OItKD+A+VoxBhPmotfUZUEzsidhQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b706f30-d136-4c46-ddde-08de8bd47c32
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 07:43:07.0505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsiAKiq7Oc78VRen5Dcgi+h8cLKkZnY5k7GtaOzr/Z0J2idqPmfhWDkNe3WVcbrR5WVVeq5nsyPc+XbGTHkU8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6740
X-OriginatorOrg: intel.com

On Thu, Mar 26, 2026 at 12:57:26AM +0800, Edgecombe, Rick P wrote:
> On Wed, 2026-03-25 at 17:10 +0800, Yan Zhao wrote:
> > > I don't really understand what this is saying.
> > > 
> > > Is the concern that KVM might want to set up page tables for memory
> > > that differ from how it was allocated? I'm a bit worried that this
> > > assumes something about folios that doesn't always hold.
> > > 
> > > I think the hugetlbfs gigantic support uses folios in at least a
> > > few spots today.
> > Below is the background of this problem. I'll try to include a short
> > summary in the next version's patch logs.
> 
> While this patchset is kind of pre-work for TDX huge pages, the reason
> to separate it out and push it earlier is because it has some value on
> it's own. So I'd think to focus mostly on the impact of the change
> today.
> 
> How about this justification:
> 1. Because KVM handles guest memory as PFNs, and the SEAMCALLs under
> discussion are only used there, PFN is more natural.
> 
> 2. The struct page was partly making sure we didn't pass a wrong arg
> (typical type safety) and partly ensuring that KVM doesn't pass non-
> convertible memory, however the SEAMCALLs themselves can check this for
> the kernel. So the case is already covered by warnings.
> 
> In conclusion, the PFN is more natural and the original purpose of
> struct page is already covered.
> 
> 
> Sean said somewhere IIRC that he would have NAKed the struct page thing
> if he had seen it, for even the base support. And the two points above
> don't actually require discussion of even huge pages. So does it
> actually add any value to dive into the issues you list below?
I wanted to mention the issues listed below because I'm not sure if anyone has
the same question as me: why do we have to convert struct page to PFN if they
can both achieve the same purpose, given that currently all private memory
allocated by gmem has struct page backing?

The background can also reduce confusion if the patch log mentions hugepage and
single folio.

So, maybe also avoid mentioning hugepage and single folio things if you think
it's better to just mention the above two points?

> > In TDX huge page v3, I added logic that assumes PFNs are contained in
> > a single folio in both TDX's map/unmap paths [1][2]:
> > 	if (start_idx + npages > folio_nr_pages(folio))
> > 		return TDX_OPERAND_INVALID;
> > This not only assumes the PFNs have corresponding struct page, but
> > also assumes they must be contained in a single folio, since with
> > only base_page + npages, it's not easy to get the ith page's pointer
> > without first ensuring the pages are contained in a single folio.
> > 
> > This should work since current KVM/guest_memfd only allocates memory
> > with struct page and maps them into S-EPT at a level lower than or
> > equal to the backend folio size. That is, a single S-EPT mapping
> > cannot span multiple backend folios.
> > 
> > However, Ackerley's 1G hugetlb-based gmem splits the backend folio
> > [3] ahead of splitting/unmapping them from S-EPT [4], due to
> > implementation limitations mentioned at [5]. It makes the warning in
> > [1] hit upon invoking TDX's unmap callback.
> > 
> > Moreover, Google's future gmem may manage PFNs independently in the
> > future,
> 
> I think we can adapt to such changes when they eventually come up. It's
> not just about not merging code to be used by out-of-tree code. It also
> shrinks what we have to consider at each stage. So we can eventually
> get there.
Ok.

> >  so TDX's private memory may have no corresponding struct page, and
> > KVM would map them via VM_PFNMAP, similar to mapping pass-through
> > MMIOs or other PFNs without struct page or with non-refcounted struct
> > page in normal VMs. Given that KVM has
> > suffered a lot from handling VM_PFNMAP memory for non-refcounted
> > struct page [6] in normal VMs, and TDX mapping/unmapping callbacks
> > have no semantic reason to dictate where and how KVM/guest_memfd
> > should allocate and map memory, Sean suggested dropping the
> > unnecessary assumption that memory to be mapped/unmapped to/from S-
> > EPT must be contained in a single folio (though he didn't object
> > reasonable sanity checks on if the PFNs are TDX convertible).
> > 
> > 
> > [1]
> > https://lore.kernel.org/kvm/20260106101929.24937-1-yan.y.zhao@intel.com
> > [2]
> > https://lore.kernel.org/kvm/20260106101826.24870-1-yan.y.zhao@intel.com
> > [3]
> > https://github.com/googleprodkernel/linux-cc/blob/wip-gmem-conversions-hugetlb-restructuring-12-08-25/virt/kvm/guest_memfd.c#L909
> > [4]
> > https://github.com/googleprodkernel/linux-cc/blob/wip-gmem-conversions-hugetlb-restructuring-12-08-25/virt/kvm/guest_memfd.c#L918
> > [5] https://lore.kernel.org/kvm/diqzqzrzdfvh.fsf@google.com/
> > [6]
> > https://lore.kernel.org/all/20241010182427.1434605-1-seanjc@google.com
> 
