Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D6A38839F;
	Mon, 24 Aug 2026 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787599636; cv=fail; b=jM/R66BoXRHpT3FELtkFR0qhY3L2aB3zgosCuLj6u0Z+J/X39fB8QIWSNMShJodZYPBKLtDIRSrurccO6+WE8a4oATJA0NxdTePP0NmdNpCBlE+qBUxH18A6hox+q3RjNylothH4EYcLPcj4heS/1w6eOuAc+uK5YN01RjLF5VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787599636; c=relaxed/simple;
	bh=IId9RZcUACCWzs39spJq1ZC4SDvYSzYofFgotrYUHJ4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WH4XwUj96fzhzuUg7OPXVlijh2MTQPxnrbMfs0l0rZCKzBVRCEGAhJ63o5JS7i/nF+nHOvYfonyFQTRdaLEBD6p0fxn8UytDBOLHQ0hoU0YmeWqpaAtlVNTgKZIuhuxo5UaLsF0st+AI49fZdykbT/uUfIelpdio9Ecl0ZtrU4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XC/HdHDq; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XC/HdHDq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787599634; x=1819135634;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IId9RZcUACCWzs39spJq1ZC4SDvYSzYofFgotrYUHJ4=;
  b=XC/HdHDqggSP6vqrMyD9RwE55uEAhx6v/Kg3GK/kHmzynmNbbmHNgX9M
   UspMDwQkWqCgmwX8WuyHq5NfDex81ncnQ2FX1ANI9r0JUyAsTrWRAKgWu
   /RnBHeigkyVDybfA12MtjCVabkB5D5TntEr9OO+JLewD67hWWM1+TqQ92
   7wifLcluxx9dPwKXpJYoen4wu5sFCaC9B8Varli/gv7UtjmKN3Z95CJYT
   ltSUs1KsId6vlB+spwcO/NELUWFyhxC2QtCC0WqTKfF9CpPRKL4fEqnS0
   23ZE54evhv+BBb/gRNuFKqNiWwgh3AdyyxhsNCamfgdS307bX/noJODcu
   g==;
X-CSE-ConnectionGUID: 7pFJ9ZemS+adUBfBSLUbMA==
X-CSE-MsgGUID: AgVROFi1TxqDXmx9j6/gVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="91931664"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="91931664"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 12:27:13 -0700
X-CSE-ConnectionGUID: LgdjRDnsTxu13BIxzt0jwA==
X-CSE-MsgGUID: jP4hEXKqQm2Aovh96U4p8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="267667561"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 12:27:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 12:27:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 12:27:13 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 12:27:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0/+n4D/WEsk74XmLGahVSUsAcnmq8i1yOqyzQlKYmApeK+zz32sYsamH5xmCGhHlJhVlagjRijkR9OJPLYv+DF+OxwE4/bDc1Og/ledcJd7gnDzsu49stuCxCMGmBXS2Ve4+DwHnD+CC4Me8JLH2Ufvj0pCB/ky08fi0hnkv3M1YxqQCuutUdv7iWt65d1GhSNJrkpeqnLkuZ85SL0oNNG3a7j4W3RjDGISfW+Py88rZgV+4POxmYJb/q+fNe+YdTDtssVyn7n5rfB5wYzXIrm0v2bUoqM5AA/FmKtPzS2z32zv1QVLerkrVLddq7Al7uFYoqn4S74WKDX2g7XrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxoMzviAeExp00y3vOQ5gyfCKSSjsNGvZBhpCpra9B8=;
 b=e9m8+k0Xoo6ZdArbq732QisaGumh8L1DBmlWATS2kgh5b1eLJOXQPas+q6YNZQmVyCgu7uDV4RIEQ7ak0oYnpMlrjVBrmVLb8K8mDa2YCtYcZg9NT0P8/jwUyiU1BmJS8/sV32Wy9r3geUqjEmVHLa8xh+CqKcldYKi3ghI1hCwiLAv9TxbfXCEg7hxlN88QRHNd7+CngT5Ei39x0n8+j8jrVd28aiytMMslJGQRBo+hyIkrfWwQHYqxC3aq3eADl8ta7CC+yYzN0/PMjOv9V5z66L3HfYkKX9ncF0pCMfmsWKiStOBQosdYk85oNEejKXNSr2IWsMc6pBDewNbKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by CH3PR11MB8137.namprd11.prod.outlook.com
 (2603:10b6:610:15c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 19:27:09 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 19:27:08 +0000
Date: Mon, 24 Aug 2026 12:27:02 -0700
From: Peter Fang <peter.fang@intel.com>
To: Lisa Wang <wyihan@google.com>
CC: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng
	<ackerleytng@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, Ira Weiny
	<ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, "Kiryl
 Shutsemau" <kas@kernel.org>, <linux-kselftest@vger.kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, Ryan Afranji
	<afranji@google.com>, Sagi Shahar <sagis@google.com>, Sean Christopherson
	<seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li
	<xiaoyao.li@intel.com>, Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds
	<jmcrey@google.com>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v14 10/22] KVM: selftests: Set up TDX boot code region
Message-ID: <20260824192702.GA3694338@pedri>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-10-15ad654a50db@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722-tdx-selftests-v14-10-15ad654a50db@google.com>
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|CH3PR11MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d96c996-b17a-4bbb-2cc7-08df0215b072
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|3023799007|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sjw4XcQ4t6mshRKUtFz6KRqVFUx5j/KUlePtiOA9HZ84IU6Qm3hnLCL1DLLzmsxEQpvqY7OqfDsMVO+RHMConJUa8Oo9Hbz2rtPzIAZC9cUqfDIIZc0StUdpBEIhAUlwjdl1mVIjqAWzabOJIowJiqbbYCMdkuYL3C2at4dXHykc91puyWTf90gatPflkWMfKvdJft6S5h6U0zsn2oR78l+38JcE6aQ8PhB01UP1ASk2rWdFYylZQaiy/SRNNyIzaiXddKF8oyEYR5jR/0on6RsQLBoYl1BsswQfT/qTPTZLO8chrLPGNzefTcS9uxmMpN315+clWAA203KsvjvJzS2y00UQqGyqF+ZDhUE9hZe/yhQWTICWi8oqamxjYEgVdYl/BI9nW84m0IccTU6qjl6peIQTCKwFH9BGAQo4ISUSs6Aeo5M8IpMgQRVDKXf/mJMxLX3/YgAZozL8Db+EshyqozGk3ID82MG+QEpSIPC0aLKPZdOcL6u3CxVoe0UMgcL+aRCblXJ0y0sVZi/T+dxaptWj5VtE7zHKH4v5nOZPkeALjt5n0xt/YAnCHo02boxLm+SyGI95wNKnEt3cgr14PtuNl2R7sdBxJRg95vF5tYz8o17UnJU6TkKd0MJEuT1nAGyKSvswIjA13e6fhsJBudpNHx514CDGWp60FHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sjRnrwkEOB84fX2nlvFk4TfTl6Scvs2jQsX+jpz/O2GuC9YjxJAhF/nZxAyw?=
 =?us-ascii?Q?V4C6Zwiz/iqzGVCGySWYEPw36PDbBhjozeosqxZ+vIEhrRApPLzRJs34o+r3?=
 =?us-ascii?Q?xRh2I5dbXu43GqviCZURtibThab+C4ZKhBfr5a8ZzI6SSPagbmwXc+zyXouz?=
 =?us-ascii?Q?oFS373mupzxii3GijrAy3/M1qXvyuHitUkPLoc3Yy8u1rMreANEEn0FSI7tY?=
 =?us-ascii?Q?r9Frw5EVCOMHNK4BYYnx/PytS1hlYUjRdZIv24A682EdI43g10wBdmQHaAI4?=
 =?us-ascii?Q?vR2vha4ZKfxp8w6cW9KlAkeKypnOZILuhG6TgzUjl/sR+zDeitXze7UNDRnd?=
 =?us-ascii?Q?mY34VlPa68Xb+cdSz9AhXJCttxyGaE+4Q06atkCsgQaIupFlBS9d/N8lA24p?=
 =?us-ascii?Q?+gRFqaeotRXRLToI1jP7UurSaDaAt9C8I5rpvupTSTyygWfhOQtUG61VwXg5?=
 =?us-ascii?Q?yhiAd3dBjSNILpPUP9TsD9hVWjRAobQCPstQcM/cKNu+AmO8G9WkhZ5q/7nc?=
 =?us-ascii?Q?xJZDsKjpbByXVjr2ZilFjdMeWCf/cjfgg9usmQEs/TfMoWvaMUTvOIedOYlX?=
 =?us-ascii?Q?M6c8yuzmjQiMAivoq8T8Q3rzW2EiC/+Ci/gRxcjKv3jEPhUAhT/CBP03iAr3?=
 =?us-ascii?Q?WXWGe2WtBnNwS3ThOtssreK7y/3JsRVhMy4/05mv3OnMo3cyHratK3XYEuPD?=
 =?us-ascii?Q?Knu4hACFEwWS/SVw3TOzRrApjJjiIXI2j4BIbxXSa+wHs9t4BZKdGA7tZ9Gl?=
 =?us-ascii?Q?otkr+uONyZFFucv/45eTtK6Bz5WZCJPfX5l7M+IfQwyPQ7UX1VssTl0U+THw?=
 =?us-ascii?Q?lWDh8lpNIqmuwgTUg8l7Qd0lSEEhT+GA6mb5fmiGtqSTK0xpJs7gIzWORLGb?=
 =?us-ascii?Q?tEyTJ9wtVkYczJ6RQa0dXZlgQLeHrazGE5WfofSk4Y7G6NHLplos1JfK6BM4?=
 =?us-ascii?Q?ZefTWS1k9+PGsj1Imk440zS6BW2NIZg6VmsZ5WEjWwSAJrQVVWpaGLP3qp3A?=
 =?us-ascii?Q?hjif56eMTPZPg2r4sFQJU6J3yNxXtYxkznqhLh/aL4dxDMRKGDmGQGdNoCoe?=
 =?us-ascii?Q?7c9QZHRY/9nNN5UWLV6TX6cT8GsipuI9htzKhXPB4vxUx81lhsYbMTCxR2cx?=
 =?us-ascii?Q?mRWGm/FnBf+zfpMURhWUU9JR/ZQ9iZqKa8xbfSXqq2Kj721IceUHdzJ+1yIG?=
 =?us-ascii?Q?CAhK/E4ZfEdQomk/i+t701S2Eytu6+hHW/kGl0t37HZutTGIlgUZEZVGQvd3?=
 =?us-ascii?Q?pMnvqKpjAGTXqAdr5LMXreo1JydvUMqc1FFcEgYH9pyQfobWwlcACP7LTgse?=
 =?us-ascii?Q?yVVqgR4GfTaCgpIqIFCCUb53S/YpqPuRmxRjI5g0g1RTwK68GWPweOUzOmxn?=
 =?us-ascii?Q?6qNMjWiH30EToSFbn7qMwIoXvnPv0lmhiOadntrSzrg3XofjuNqvSth9GqsY?=
 =?us-ascii?Q?NdAnyn6CMKsKYil5agGYA9LU0AnYX4CJQT7J2HCNB4GCIbWBnOJLWzR9y+/P?=
 =?us-ascii?Q?UuDUQKYviivJTU8CjjwClyFnE6dKbVvBsnjK4WZDVOxiz7Ss2P0TDvCOZhep?=
 =?us-ascii?Q?19fMDIEOuJeFn/Kq0r7wINmxKkeMut/d2YZROj5z3Vn3QiwwAsJaEgn+DiES?=
 =?us-ascii?Q?945QamrCEPGthd3VVFkBTCJRHADTTO+4xUfQjwBw2TJmAjNmbtIqATvdPjrr?=
 =?us-ascii?Q?foql6L7ZmSpYDpPueSRuGbVyqed6r8wXm/sXNtGfYcq3cn/fh9Efe2nCAdDz?=
 =?us-ascii?Q?5EYkBJGlYQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: IeYDURk/iHwyPrSu/ONc0QMmVcNEc4fwIljvc1RFGPefcmBu/gvf9x9KAuKg29mbFDZsYwQT3PTtyhvYLSK6kFKmy2cVBzU9I/kmXJ4tqjZUF7zW7FtDS+1Lgdp2odkc0sF6ChsDBN32a0qIEHjtk52MxFVh3QfQftCmepKyTfnsTeX/KZJ+OSTBplhXrq+TFTuOjcKluWaBZvHX6lA5P6rVpZD1zacenABuPUyI3T/yBGZZ35u4qbaWQK/F7KiaNJfuCLYo98JGG1LQ7TIShleGjYVyaYseqKIt/yDvIroq7x80LJ2VWYhF5iLOJWcno+KfZO6R5UuEkMhtQ34khg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d96c996-b17a-4bbb-2cc7-08df0215b072
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 19:27:08.8860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQyI0/Sc2iT5klVgpgzxlAU3vX3tHOLKchM/uELTzzA0FIQs+joaYYXQE2ZR10rn/qNwt6Om9R3ychnsVJLyUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8137
X-OriginatorOrg: intel.com

On Wed, Jul 22, 2026 at 11:13:15PM +0000, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Add memory for TDX boot code in a separate memslot.
> 
> Use virt_map() to get identity map in this memory region to allow for
> seamless transition from paging disabled to paging enabled code.
> 
> Copy the boot code into the memory region and set up the reset vector
> at this point. While it's possible to separate the memory allocation and
> boot code initialization into separate functions, having all the
> calculations for memory size and offsets in one place simplifies the
> code and avoids duplications.
> 
> Handcode the reset vector as suggested by Sean Christopherson.
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>  .../selftests/kvm/include/x86/tdx/tdx_util.h       |  1 +
>  tools/testing/selftests/kvm/lib/x86/processor.c    |  4 +-
>  tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 46 ++++++++++++++++++++++
>  3 files changed, 50 insertions(+), 1 deletion(-)
> 

[ ... ]

> +
> +void tdx_vm_setup_boot_code_region(struct kvm_vm *vm)
> +{
> +	size_t total_code_size = TD_BOOT_CODE_SIZE + X86_RESET_VECTOR_SIZE;
> +	gpa_t boot_code_gpa = X86_RESET_VECTOR - TD_BOOT_CODE_SIZE;
> +	gpa_t alloc_gpa = round_down(boot_code_gpa, PAGE_SIZE);
> +	size_t nr_pages = DIV_ROUND_UP(total_code_size, PAGE_SIZE);
> +	const u64 gmem_flags = 0;
> +	gpa_t gpa;
> +	u8 *hva;
> +
> +	vm_mem_add(vm, VM_MEM_SRC_SHMEM, alloc_gpa, TD_BOOT_CODE_SLOT,
> +		   nr_pages, KVM_MEM_GUEST_MEMFD, -1, 0, gmem_flags);
> +
> +	gpa = vm_phy_pages_alloc(vm, nr_pages, alloc_gpa, TD_BOOT_CODE_SLOT);
> +	TEST_ASSERT(gpa == alloc_gpa, "Failed vm_phy_pages_alloc\n");
> +
> +	virt_map(vm, alloc_gpa, alloc_gpa, nr_pages);
> +	hva = addr_gpa2hva(vm, boot_code_gpa);
> +	memcpy(hva, td_boot, TD_BOOT_CODE_SIZE);
> +
> +	hva += TD_BOOT_CODE_SIZE;
> +	TEST_ASSERT(hva == addr_gpa2hva(vm, X86_RESET_VECTOR),
> +		    "Expected RESET vector at hva 0x%lx, got %lx",
> +		    (unsigned long)addr_gpa2hva(vm, X86_RESET_VECTOR), (unsigned long)hva);
> +
> +	/*
> +	 * Handcode "JMP rel8" at the RESET vector to jump back to the TD boot
> +	 * code, as there are only 16 bytes at the RESET vector before RIP will
> +	 * wrap back to zero. Insert a trailing int3 so that the vCPU crashes in
> +	 * case the JMP somehow falls through. Note! The target address is
> +	 * relative to the end of the instruction!
> +	 */
> +	TEST_ASSERT(TD_BOOT_CODE_SIZE + 2 <= 128,
> +		    "TD boot code not addressable by 'JMP rel8'");
> +	hva[0] = 0xeb;
> +	hva[1] = 256 - 2 - TD_BOOT_CODE_SIZE;
> +	hva[2] = 0xcc;

This handcoding has persisted for several versions (since v9) so I only
want to comment gently... The current code looks correct but I think
this could be simpler. But feel free to keep the current implementation.

I can see handcoding "JMP rel8" generates a jump instruction
predictably. But having to calculate and sanity check the boot code
offset by hand seems quite painful. And the math is quite tricky. I was
thinking the assembler could do a lot more heavy lifting here.

A nice property of this boot code is the fact that it's executed in
32-bit mode from the get go. So there's no need for 16-bit programming
and "JMP rel32" is readily available. I.e. a "jmp td_boot" in td_boot.S
should suffice and the assembler screams if td_boot isn't reachable. And
the int3's after the jump can probably go away as well since the jump is
now very, very likely to succeed.

There shouldn't be a need to "pad reset_vector to its full size of 16
bytes" as stated in v8 [1]. The exported "reset_vector" symbol in v8,
plus the boot code start & end markers, should be enough to help
tdx_vm_setup_boot_code_region() put this boot blob in the right place.


[1] https://lore.kernel.org/all/aJpO_zN3buvaQoAW@google.com/


> +}
> +
>  static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
>  {
>  	static struct kvm_tdx_capabilities *tdx_cap;
> 
> -- 
> 2.55.0.229.g6434b31f56-goog
> 
> 
