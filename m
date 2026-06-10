Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72BE29D281;
	Wed, 10 Jun 2026 05:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781070235; cv=fail; b=rkU2LYKLb63mdf1HJ9Ox01W8sJhDUhS09GGJsdyO/aSLzMf4PVUgJQqVgYz9nOnySbp6sIWmCS/3SF3IWNQ06goqM+OljXfMhRAzKLtM+D4Ts6CuLlgzR2M6iq7l/Iik7ZLZw6gADxKbxm7VOpg9w1rlEN58RalGoXwFQoxL2mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781070235; c=relaxed/simple;
	bh=FdYvW6Cq2AET/7xq63hmulAaal8i/toZa9eRCnChvqs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BWhoc9UOOllowQQJEGs7rLUnel4CilVaTSt99fSmdhp1ZLZRBCdIhyTyOB+P47q6FZRUCA+m5QFkzfgq4ztQBgPz4ZY7yc9hijhcD/T5+3TcbV0w5qDpwIBXqf8d6dP/9Rhvy5Kt+DaRzhZ0sPBY2ZqlRcmJJaWwrETTDPMW5Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qk8R3Dgx; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qk8R3Dgx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781070234; x=1812606234;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FdYvW6Cq2AET/7xq63hmulAaal8i/toZa9eRCnChvqs=;
  b=Qk8R3DgxEQSJTeOazJdgWPS29bsE355hDPEuWPAMlMMOl3M6ElAhpIBG
   uoYMN9Bxb2Ps/3D+6KLQWkSnf6V+DyaLzlCCUKaPAlMrYpHoazPmpDw02
   v3FwqgZ8OXYwCj3PuYhb1jhC5N91iJxcJdEIxNOwxL0Dv/G8AfTDnhFZe
   c6HUcbzZZQTLAy0MaRzDZXzTHOcuW/6qPkcemoTV9nC8BiyrdLEAXLEoP
   B1GydRPYSSbLG25u4QqObw+EuG1dnyebtNlqbNrHKBHw7mOAp/n0mTz28
   E5KBAEmrmaKuWM1C/sLHCgGXtjXQeSg5zwZy6dSNG4i3Tn2JtHCeV1K1g
   g==;
X-CSE-ConnectionGUID: hqroUYJDQCqBFV0aR/vkAQ==
X-CSE-MsgGUID: ZRDD8wWaQNGGzhIHGDi8NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81965658"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81965658"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 22:43:53 -0700
X-CSE-ConnectionGUID: pEU88hysS+Gkw28AlIp2XA==
X-CSE-MsgGUID: 4YnfNyDCQImBwerUQ1roGA==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 22:43:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 22:43:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 22:43:52 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 22:43:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5AwQwVnFFj7vTqQwX0/m7khffn95TG+Ey6PZ0IW5Sue/QjJ6NjMZTOzXoUcGE0bseYRWQdPBss1eal3OVHOZULoR9n1aGVgjZGqoc+yGDriKgoa48HlNdBbws8ocBPUxDUVKYee5bluUKKuPrRVIqnNnGZkXUpRyjS4uVcB/3VzAOhJU734SjVoKR/kyTZER4viTaJqv4lZHav97Bex6pwh6NgbZdNlqik6T+n3POFN8jmd1lS7HzJJZ8M3h5Ms3ClMnSDF0VRBab57Fx4CVmCZITEA4Fnp4hJE9njzjdb8oV0qFtCL/o2vCmpLT8KNYRZhxXgalv6CO6jPpP6S8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRszSoFTSlPj7OQY8GXD+y4AbICGZtQfPr9L1ADR0Yk=;
 b=NNVCiE1IZR4Yup+rVOmhKEORW3wh4t5Z9ZYHCl4aKOU0uLDi0parIa5hTTWNBZpCXO8yeqQvtZAEv/rIRK7VW1oSezLVzkvt92baE8Khal7N7kGXSIbC5ip9ZCUC01t6pzvcTGooVBziVQgC7njkUzXIPNXS/0vEpbbABl8ocewQAomVUP2mJLZMmve+cwceWl1I0FJVJIwkrlaTmQgAo7gEKnwGVUt4v+EoAvbO9GMsPDnO+c9sX35OfwVTLDCoykvYp8Nw1SNDidjP7fsKM95NqTZTy2iVUaFwW9/28OqG+GiJY8BQ6/7dClG3J880t4K4DNvIzfSIl+Pg4gGutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS0PR11MB8687.namprd11.prod.outlook.com (2603:10b6:8:1be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 05:43:49 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 05:43:49 +0000
Message-ID: <33974159-ec7c-4c5a-845f-02ea4e67a0c4@intel.com>
Date: Wed, 10 Jun 2026 08:43:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] x86/virt/tdx: Add extra memory to TDX Module for
 Extensions
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <kas@kernel.org>, <djbw@kernel.org>, <rick.p.edgecombe@intel.com>,
	<x86@kernel.org>, <peter.fang@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<sohil.mehta@intel.com>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-3-yilun.xu@linux.intel.com>
 <f7238ced-73a0-44f3-8a50-23eb5a2da5dc@intel.com>
 <aijygJ9YqskIOvB3@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <aijygJ9YqskIOvB3@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0023.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::7) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS0PR11MB8687:EE_
X-MS-Office365-Filtering-Correlation-Id: 119a20c9-24b4-4d83-2ee2-08dec6b33ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|22082099003|3023799007|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: /UlqwV5dAeeTXIVq2jSLEnD3qztT1N52uF9FI4FDnhBkC7jY4Aznolpabdj16arY8dNe0nOCs+th90H0n5+WQBaXXb4z3t23r2eadOZMidKvjgega9pblX8lRBUK1wJkg4MCkIHFF15YAMq7Sq15qhpQNiKPE8Av/d2/DoOm3vYlQitSLzpybQ0ufR6DeTyh2vcKGL8yaiO23//qShZHnNKeSTPObKEATv73uklcjC9VWvX4+MKaWz2rR5MQ6lh/KDH8vNb0GIPws3B2hIueRUCDdETWYDUUBKb+wXcuM4i90jsCAPmFSoB4UVh7d14b/FOhR0XvtN/sRcGdDo2lGLDbBxtChYNodXWCbPwkeM71mwyCuXyx34C7LTajemypCga7EsFTG2oVzEWwRiV7ZhJ8CD+dOXygQQUTSFp7BUK3gIo+sLGeigjvGeAZ8NN2lvMqdTERpqn+33QmVIr7MVaMm3R8bqSz0Lxb0hEO/F9yOvbfx+tJ2G5HMPQqPpehQKfupsF+3GQ2c9hfmr+/4XszBsy+A+oyiNpJA/IKHFcwf67S0h5PfgGsR6NK+TpXUhEvMqhgQwqniw5ZuLYIOG213ercQANCWfjIy35u/ddbUYTIpumfYkhyZCNETI/VkcXWbEkkmEVWw3m3snb9s30LiUdPYPg8F8a+0cuKAlpnh5tCrQrmGtMom5qRCabE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(3023799007)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2lobUZtWnNoRXNONGNmSkpoNXZaRm14YW5xd2N1RlZrZjE0alRFM3d6bFd3?=
 =?utf-8?B?QlBqNzVGMVpFQitYRjdkRDkxcWlJOFZhK3ErUmhJK29NSGI3MTYycUNEam40?=
 =?utf-8?B?LzZNcThiZi9BL1JxN2xyaTdtSkxIeHg4UGp2ZDViY1NTQ3I4c3BwY0w5bmNv?=
 =?utf-8?B?SVNpQUlUNmhzMzR4VkxjUVp6Uml0V1ozSmhwVW5KRHJzbDVBLzB6TGdMN1N2?=
 =?utf-8?B?MjV3SkVhRlRRaU1NdkdKV05Od25vRXRtTkYwdVdMcE5JS3dkU2g2dUQzSk5M?=
 =?utf-8?B?RUtUOSszQ002VEVzWmM1aWRnb05Ed0tJZE1ZR2dsQzljU2hidmE1VHdBa2lI?=
 =?utf-8?B?dXptL2IyNW5GQWJUejdmVVhHeGJZcWJXcnR2TEhsWGNxS0txM2dxUzRaWWRn?=
 =?utf-8?B?RkxlRVRDSmZLc3BVeEdOVUs5TkJlSkFvT0JQY2pueDhOSEJFbFNSZW5OSDc5?=
 =?utf-8?B?SkM5MVYwSWM2STRmeGlGN0lCZnZiRks3SCtpWGpEYXJCTlkyUENUeWU1WXFP?=
 =?utf-8?B?NzVWelNIcnRZVnRiMFNnVThrNlRXV1JYSGVjL09jc3R1VUpIU2FjaWxSNnIx?=
 =?utf-8?B?SEkyb2RONjNNT09ET2x2dEhnZmFpZ1lZeHBUOHB3TjZuZk5CcmFJaXA3dWdM?=
 =?utf-8?B?YW14YW4vUW9QR1pTTUkzMWZnVXdKRUhUZWJOeW5MckFoMk5UcWVtWXJ2VHky?=
 =?utf-8?B?OEpzUURVMUVLVlJHOHdNY0UvS1RPczFkeTk5TFI1RjhvVDd2QWZjODFTcUQv?=
 =?utf-8?B?WFdIWE5SUmFYQ0cxRXp4TFZHdlZuSG44V3pZYXFKQlhMb0szWWh1UnRCSG1P?=
 =?utf-8?B?OGpSR2JKdmcxUDRoK3Zyd3dSSnBnS1dvR3orOXhJZ1dCZnlrTXJ3amU3bDhP?=
 =?utf-8?B?ZjMxNVZ6N3N3VmhRaUl1UEtZNGZQL2VrcGdMSE95Y0F4dEV2b21SYytrSXkw?=
 =?utf-8?B?VWhMTlRYTVMvL0YzZGhtVHdEWjZydzluQWlTVE5PcHRra28wMWJ0VWlrQUow?=
 =?utf-8?B?OFhzVDkzR2pyZitvWFY2UkhGblVsYTNiZEtndWNCN1cwRVNhaWorU25tUWVH?=
 =?utf-8?B?MkV3WTl5bkNhRG16b3ZHZVNXQU9ZTUdqTk5uZzAvdmIvZmk4S00wVzRLVFJY?=
 =?utf-8?B?M1U5TDFDSlBGMXdzb1pVczcxbW5jdUdvRzVHcjQ5eWhwYlhsY0VMRGVPV1Rn?=
 =?utf-8?B?T0h2UkkrZlBwYllZdXVjSE1LbGVpVVBPNHFXRWNNR05hbDdPdUU1bll1Q2lJ?=
 =?utf-8?B?Qk5QUU5DR1hxUnQrMStFT1hPdThxaWxHU1R5bjFKWWVsUDBQK3E1NmdNNzlX?=
 =?utf-8?B?OVpBSXJNaTdFSXpqTVRBUE1GT3BvNGY5Z3d4aHM3RFBGbmdjZGhjMmNqS2I5?=
 =?utf-8?B?UkFzZmJZM1daZ1I0YnVzWWFvY1FlVmVCeTg1Yk1FeUs4dU1XWlVSM2V4NmR6?=
 =?utf-8?B?OWRpdnVqYmo5TUJmMWtPcTBpQ1RLWHpJOVVOd01KcGlUYUNVWVl4ZXR1VVVJ?=
 =?utf-8?B?Tytsb3VXN05QMGZTUTFIMzBLT0RCQ3BaRGlNQ2ROc1BheHo3ZGUvYU55aDN0?=
 =?utf-8?B?RGZQNmdueWNVeWFRYkNDclpSL1VlSlVWLyt4UmJCMEd1dVc0YmFWSUtvOVpR?=
 =?utf-8?B?Ylk0eExPc2x5WDNLemV2Wnd2aXFNTlFYR3pQdUVaamRjTmt0QWptQ1ZJV3pH?=
 =?utf-8?B?Rm5MWm45VXk0NEZTbFQ5K3BsdHgyYjF5ZXZVcnFJSXFibDBKanZtUVlrTUJC?=
 =?utf-8?B?M1RzSjdOUzZ0MDF0dE9SSkdrd2tPZ3o0T21adFBYK3hGOE44dFFJd3llMzFu?=
 =?utf-8?B?eldpaFFGSEc5REpTVnZyRzJsdDAzM1R3dmRpTkJ2bytWREdvTEpENU9rNnY4?=
 =?utf-8?B?TzBuWUlwRHhGblpKamtYa1paR1l5Slc5UkkveWppUW5JZmp6SWZ4cHFnclpN?=
 =?utf-8?B?NTAwaGMxQVY0MXdLQUUxWGVjSjBSS2hGK3dEemxPMlRlMkNLQlBmWW1ROG15?=
 =?utf-8?B?ZGlHZEc2Tm5vbFdGSUhobUk2WEl0eWU0MUFoQ3pSMVFIYXJxVDNEa2cxMVd3?=
 =?utf-8?B?eHI2ek1oVHpCenRsZ2l0ZXJvWktUYnp0dFdQMFdxYjF1SU5TUWxzMTVPQWh3?=
 =?utf-8?B?cGNUbkN1QjgvUm12TEtiTjg4eWJWZmZyVm9WZEIyc2I2M2dzRW9zRkVHdlFJ?=
 =?utf-8?B?cHdva0t1MzN4eUh4OUt0Qmt3b3pNSjVQeVEvMjlldGpXUmMwVmlsLzU3WXVB?=
 =?utf-8?B?cjQyalROSTZOMlJmVGdrV1N5eWs5ZVFuaVdnLzE3UGFoWjl2WU03ZFkrYkZ3?=
 =?utf-8?B?RUJOVmdKTXJYNjQ2dlIzVC8xS0FBdUgrZGdTQ1U4eFRyQlNWVS83ZEY2QnV4?=
 =?utf-8?Q?MLNW9T9/v5slzars=3D?=
X-Exchange-RoutingPolicyChecked: KP0fhLFhi0RIxKWliZfuF6SK3xC29xR/lJ86ZTuN7cS5ajS/9EMK1bGwm0SY/7DmQ5M+786xGQvnYfcV+ZqYrH7kCisRr45amShZcyc7bGYmYKXcWZoyk+dKPIE+vr+Hkq/c3rsgHFlT3L1JzZrcj2vNG5lXWAjOpZD1Tq4pwUQLnis/azKbZ5jy7K0S3bq+DMbjxOkDc7/pnUa3KSbg2Z8q7PGgjvs4sGLoUy+TXYA9yxXvVS7GCSasvHXMDx0CnHKC36hmlihpksEIvBjmc4KQVIqwD++3i2QLmri4jWhkl6oPphBqVVjSGPA46gfn8Z3Rdf6mNnBqnIHC5MNOQw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 119a20c9-24b4-4d83-2ee2-08dec6b33ee7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 05:43:49.2056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LC960N8ToPhcV0oWu0+6cnYmTITKlRdJy69/9yBjg0WlrWykMUvjPkw4QfRNv3zSJJXVCnVgbzIw/6jkd4C51A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8687
X-OriginatorOrg: intel.com

On 10/06/2026 08:13, Xu Yilun wrote:
> On Tue, Jun 09, 2026 at 04:38:31PM +0300, Adrian Hunter wrote:
>> On 22/05/2026 06:41, Xu Yilun wrote:
>>> +static int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
>>> +{
>>> +	struct tdx_module_args args = {
>>> +		.rcx = to_hpa_list_info(root, nr_pages),
>>> +	};
>>> +	u64 r;
>>> +
>>> +	tdx_clflush_hpa_list(root, nr_pages);
>>> +
>>> +	do {
>>> +		/*
>>> +		 * TDH_EXT_MEM_ADD is designed to use output parameter RCX to
>>> +		 * override/update input parameter RCX, so the caller doesn't
>>> +		 * have to do manual parameter update on retry call.
>>> +		 */
>>> +		r = seamcall_ret(TDH_EXT_MEM_ADD, &args);
>>> +	} while (r == TDX_INTERRUPTED_RESUMABLE);
>>
>> Kishon already mentioned checking only the status
> 
> Could you elaborate on why we should mask? I assume the mask is only
> needed when the lower bits ([31:0]) are defined to contain extra
> information. TDX_INTERRUPTED_RESUMABLE is not the case so we could make
> the code change simpler.
> 
> And if some non-zero bits appears there, it is a Module bug that we
> should not skip.

Agreed

> 
>>
>>> +
>>> +	if (r != TDX_SUCCESS)
>>
>> Similarly could this also be TDX_EXT_MEMORY_POOL_FULL?
> 
> I don't think we should pass the case. The Module provides the number of
> required pages via metadata, host follows and feeds pages but the Module
> said "Sorry, I'm already full". This is inconsistent behavior that we
> should call out.

TDX_EXT_MEMORY_POOL_FULL is not an error code. It is a success code,
so the question is whether it will ever show up on, say, the very last
TDH_EXT_MEM_ADD.

> 
>>
>>> +		return -EFAULT;
>>> +
>>> +	return 0;
>>> +}
>>

