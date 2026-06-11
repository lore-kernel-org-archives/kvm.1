Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807BA328616;
	Thu, 11 Jun 2026 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194947; cv=fail; b=h6AU4aOAFIJvdLd9PIQ7Gkdfbm+4SxyEvn/inezhjGyP5P4Yk1mEEYHOCQ72B9ZAZWTTYSKdynnNNEWnZ0JV1ljlQcVvnr7x6h+NTt9qFFsgn/bkHuUF6DH7rvIw+M797YKU73MfSWFTcS6au9kGg4r/gWZiMKf1CBXtniYvaDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194947; c=relaxed/simple;
	bh=J3VzSLJkhS8+9FQD/yCK9H4GNHVJS2NejEDy8R6Pry0=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T7lQ8gNS9+9w5JsvjojCAvMeDeqPL+ePCosNx5TbiA3TkabM6xpPHnq6dDhhfvaZjigFxRh0owE+33YQU2cXNUME14HDk1sbeCoXtc+xHgbdnaUff53FlIHft0VEz4nyj7O/LC4g/vc/41ftQVt/WQp5lVAF18wAO9mF7qeD9ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mG8xdsxA; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mG8xdsxA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781194946; x=1812730946;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J3VzSLJkhS8+9FQD/yCK9H4GNHVJS2NejEDy8R6Pry0=;
  b=mG8xdsxAwGvgX6Kz9vT0opcE9ZL9q9IXjunIeFYRDYUIsiHPOdMBm2AB
   o1XtItIqlsXDpQkqO3yip5uhlC4KwLQkRmsfj1ZBct5trjbWqXtmMxNQp
   jSIOsVsU+YdXC2g7ja7EA7hH0swS91RkPRP9O77MCg2c0uWemYXdWGg9S
   /KcupAKCbvXtGr9VQ1bADt7OkTx7IT6y0r/cLDITJSTIdMNBYYmidJOFI
   QfNZDIkuHL37a5wDRZ+zxOqvdah0IkGZxTz3CSfFZpsIUMVCdhERJFJnm
   DsMHDQdQfWpZ1S+fV/m46CWTadxdhCb6EB5BCvkUdOCJS74lPpIRBTBXM
   w==;
X-CSE-ConnectionGUID: TrGoPxy0RdOPAq0jxLkRvw==
X-CSE-MsgGUID: IQeMZBruRHuyu0QoB7Yz0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82058202"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82058202"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:22:26 -0700
X-CSE-ConnectionGUID: DJaS4vwOQpO5Cc/OwfxbbQ==
X-CSE-MsgGUID: tA4COtcGTOmsNGpF1EiDyA==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:22:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 09:22:25 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 09:22:25 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 09:22:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vh8gaMHHjb+PZdq+eRzeR5HGiOd9LStP3F3Qk0T7hq0ZP4n8DbtNrVFsrUBvn4gZDRDYSrKl9m2aIKky0XgQQ6Kopg9jL/W4hcpzHo6GYDDP93dchylZ/V7OO9YOGKJwqJzw2TahQ0f5+0P9SDFWPPJZmBIFkyPLIEKJFni+jXq3ofJ+DIYR9cjdfhKPPdYgaooN8uWlNejy4f/NT3xosc0untF+3IM8BpvRRRPw3DPgYXJPeqnuxzqlH4ZEibiKrrrm3nrCdoI0LPysOBbeCSykrWr1vP6L51zqMTCRLfgEb+MIstE++JsJdckN2s78DT6ToqXPVkwB+RsSpN9tvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdhBJgRRcSUVJaMYnESmj8eZsIQG+Gw9cmBV8jh6p30=;
 b=DZw00knBgiouk1y6B+9ZsULlOOWage2dei+NejthmEdOt9Cs35okQX6IbqwlidwuLIn93AAkmsz7aKEuUC5eS8/trSfjJKA4MdYynGfSF/V46c85bUurtWqX5yb4CnCTCERhG4RkTFnz7LNP1iiCirqXmarBA3YFSKphE+ADdZB78hWTveG3pllCg5aCTWEMFKMPJOqww2UxxmMS7zmKyBD3n6AaRo2VkGBwFdK48Aiy6JWBxpd+SMcsv1nuXWx69akzXH5ahlq4foAKmkqu9rqPrzt4lC+DfEcr37jtDlTLfkkwyvbL2oMnhOMDqdQq2nwasIbWoenc4THNh2rH/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB9528.namprd11.prod.outlook.com (2603:10b6:806:4c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 16:22:24 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 16:22:23 +0000
Message-ID: <55b1972a-bfc9-4229-a7c6-7d46b03d9e6c@intel.com>
Date: Thu, 11 Jun 2026 19:22:18 +0300
User-Agent: Mozilla Thunderbird
From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 06/15] x86/virt/tdx: Initialize Quoting extension
 during bringup
To: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <peter.fang@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <sohil.mehta@intel.com>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-7-yilun.xu@linux.intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260522034128.3144354-7-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0243.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::11) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB9528:EE_
X-MS-Office365-Filtering-Correlation-Id: 7401cf8f-eb1f-4873-94b7-08dec7d59e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: sYk0/pfbxkFZfsvgJCn9mQkvehcHw/X0r7cBGsv9Ta+hzyHReuSsR58bmQrmHjsj5X6Mxha+dH1NxvXazUQ/1n5Z1OgGN1NJ6Xm7B2oNofJrff2ldX1Gom2tk8fLuipBQY7IE2WBeLWWycXCvAHydd1wz3Of8O0i2r7TiVKk6YEcSY7MQOnGXSq58x+9Cl0ZM3Nsxz7q9xBTb70x4F4QeOxHS1XyE0/942l8vsTzH1m8WQx4UvOohMk/iQpyNnPoEA8LquVVoA4vpcf9PUIFpqRw/192qD6yoTsPngLMns2wIAftQPXu4T4JUzyl2DToZ8AGUOyUIankHK+i2nJeEWjVmJ3j/E0skK4xWGh+MfvaCreMFB8OKs2NOOzBNK5FZ6ix6GXL+toprA67Pm/mAA99VCADy9cOVn64eFwWZg8nzK3jrl1eZLL5CvCBHLT6EP3Ex3O+dve9DHCt0+e532HwqzcYLGbVGiD7JcpEFiL/khiwdCqX7j6xCS+6uWSoH0e3v4YtQDKgVu39CaXrthOdWH0qTHBcgx2WZC5ikYsiPKpvI35cW/POLJac2tGyXH6hz1lajOP73D9rItyAPIJ9wWqDp2UySf1HGhol1roQe6XjubSIZMbF/DnwUN7uCYSVCgdERE4MW43qNTHxOVxJYax7hTx7PT4Zsk++/rhqbxyLTHZTnIvwkOg73i/c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEN1ZHBLWjAvekdPaXhWcjNsZ0lGYVhoQ2hZazlMMXF3N290blloN3FkeXdv?=
 =?utf-8?B?LzhuaUxLWTFsd1dwcmtCZ2FmeEdOa1ZXQlNYRUVMOTBMTWJSYkpwZjZwVVVR?=
 =?utf-8?B?U3BJZVJ1cTRPeEhJSDh6VjFKQ2x0bFBVbnBERGdEdEg2MzlwL3hLc3dBenBV?=
 =?utf-8?B?VUVlOWxYRkk0d1ErbGgvYy9LZUdFVmQwWEY4a25YcVpuVDdrWmxORWgwRURI?=
 =?utf-8?B?aWk0QUpUaGdDV2tZT3VXdkRFTzNjc2ZFYkhLUDdLdGU5aFFvbU1XQ21EenU0?=
 =?utf-8?B?UURJbFVHaUpQTTV1Sy9kYWVOMUU4R3J3NnRBVkg5UTdVU2ZnVW5NMEZ5NUVU?=
 =?utf-8?B?WDRnY3J2RUxsSVBTUW5EVkVzVEg5NFpMQ1EyRUZOSmlYSEt3K1VZSjliS0RC?=
 =?utf-8?B?NFR0YmFBUFYwbEIvd1B3ZEZkUlhwUDFNaHpXdXBxUHdEb3R0WkNPa0VsR1R0?=
 =?utf-8?B?cW5IVS92dlJYdUg0ZmdnY1hVVC9VMExZSjVQblZLUUdVR2pxVld0Mmx5TDZT?=
 =?utf-8?B?bUE3dk5hMDVsNys1U2VTaTJRQXhyR1dFbGYwdkVSOHZPWU5xKzBaV1ZrTHdG?=
 =?utf-8?B?ck1LdlBrdEdNdmkvY3RJRmJ3OGJuRDhHS2F2UndXU3R2TUd5YzRFcFphRldn?=
 =?utf-8?B?eXlHWXVRVzljcmtpUnRkM0t3cXJOUmJpK0ZTVlFSY0VkdGczT1FvYnJIVjlu?=
 =?utf-8?B?UVNkWktYd1JUNnBoUUowREErRllqNStIMktmN0lMZ2QxWWZuT1ZOSVAyeXc5?=
 =?utf-8?B?dVhYdEdZOTBlSTQ0bXBSZEEwaHo1VTBNbWZDQ2xZSFRYVlpVOElIKy94SFpk?=
 =?utf-8?B?Z0tDenBHNXlIenBFb2V2UzdLWUxuZ3lsamxhYmh5NnlwUVNtMTFhWksyRGlq?=
 =?utf-8?B?b0Y5aWJkbTFLb2VPc3dFb1FNc0llMHYwZWZqa28xdGVVd3V2MUNUbUowNHZG?=
 =?utf-8?B?bVpIbVY4SWNOMzJFbmlLN3E3cHBUTDN5UFVSUC9qQTExL01ISDFZYU5TVlBB?=
 =?utf-8?B?dUc1WWtPczhIUjF4L2ZGRDh0YzdMZlRSeU0rUVhqdFZQdjR0ejM0bjNJS2Jz?=
 =?utf-8?B?RzYwSkhuSjVld0VsUmdJT1hvWmpLVUN2bmY4WEtsOFhEWDJsdUxVRmF3WkZo?=
 =?utf-8?B?M0JjL2hUZjRsR2M2RlUyYVVvdVQzdHJNT2NEeTFwQmFqWHUwdzJNN29ZSy9E?=
 =?utf-8?B?S0tDWUVyMHo4T2pqYUlNdURZeUUvdnU0WE5rZmVSTFM5VFY3ZUo4TGVXbm0w?=
 =?utf-8?B?MHFKSDI0dHlQU2lON1R4RG9jRWtIOXZyL29oNXl4RjBlQ2k0Ry81dS9jMlBV?=
 =?utf-8?B?K0ZmbFQ5ZWlUUVloNjRSVFBzeHUzTXlaK1JFYWFxNkJUTG9vNjRPWTVFTEww?=
 =?utf-8?B?akR6M2xDZ2FGa0JLb1ZMODNBYUZZcTVjWEFQdXpaSXJnQ2lvMk1EaWNUcXhp?=
 =?utf-8?B?NFhkcWd0alROWTNEL0Q2a05mOFI0bmlaeW5yc0Z3SmloS0VxMkd2NDIrbGIx?=
 =?utf-8?B?WFhxZWtwRk15ZzlSQnhZTmVYWFN6M1hVVjJ1MzcvUjZDTjRLWlJMYzRoVXd0?=
 =?utf-8?B?VytDbWRvVG0vSzFDNFhkUzRGelZpVE53cEJrQXpqTmdQUFBlV0pvVEdDR2Z0?=
 =?utf-8?B?SGljU2d5RkZWZnA5T3BzSUMxT0t1L3c5R3M4RVo5NXpQYThwNGkrTDVnSmlW?=
 =?utf-8?B?K3VyYWZGVWFheE1GZVlwelVlVnR0NjU0L1kza05RTFJubWVhWnpFdzNjNnAy?=
 =?utf-8?B?UjJlSzRqd2V6b3N3bDd3L2I1Q3dERTZLRnlabEhzZjV0cTZnbWgxN3BsNzZt?=
 =?utf-8?B?Z0hxdDMzeWJOd0g5OHNOOWM0dzBqNVJqL2lXKzArdjJvRVJobzhzSHl1KzA2?=
 =?utf-8?B?cHY2SUJxMmY5b2o2SjlIbXFJUExkWmsxZ3hQNW9JU0VjemM1NXNxWStaTmhK?=
 =?utf-8?B?YWk3QWU3Skt6S21zUktvRUF6dTBTMjBCcnYwMDhpcEdWTFQvc3NaN1A0VXJa?=
 =?utf-8?B?RW9OMVh0Q01oZnp4VHZTSWpxU1pNS2FJUmtrYjArODY2RGdrNWwzWlM3cVRw?=
 =?utf-8?B?VWZ4Y3VTM3gwS3JTTU56QWxGb1BCQU5maTRidFhXclR5Smx0NnJFUWVtZytO?=
 =?utf-8?B?QmJwMGtnMnJRQzhIUlFrUWFtL1ZaNmdkS0hSalB3N1FIOXVSVFFKY3pJaVVG?=
 =?utf-8?B?QVF0YmhzQlVxeDdENFlLSWx1Sy9oVHM2NGFJbFFMbVdMNG5VNWl4L1NWbi9B?=
 =?utf-8?B?d1V5WEVVSUQvbCtKWVZUekhFOUphOWhSZkJxR2ZiZkdtNmdUR3JNTFd0Vktz?=
 =?utf-8?B?ZU14bDFkVFI0TGt5K1U5NmJBRlU5TWFBWEJlTENOVGlXVUs3QXk4RmRrREc4?=
 =?utf-8?Q?GTruEJAzHHG9bO1U=3D?=
X-Exchange-RoutingPolicyChecked: R1E3NjoEYdaUAbCykk27TZxGMyu39fHtktpkmC4f7Z3W8moFAr1KssozEWH7MENIoFvKpKH8RRnrAYITximXNofYVjeOkF4c219/6vG7pUbsKWpX0QSBa2UfPmj79zLK7wot6LizEMMT9S/mrBiMe7plhk+JAS3Mv5uld4T1cmJ9VbIQNiN32t2qIo3j86JfyipVFjDrs+kyJkdadUi52xlXnniaTfSFvcz2Uxta1sStOvGzYJJHzs2wP0jTqW6mMwHu+pnPl8DcAwyOLHOXumyGhX3LVjP+DUMabLWoeqTQVwvKT4SnZR1hIPnLD66HVx1cJ5DWArf5eCnMgV04vw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7401cf8f-eb1f-4873-94b7-08dec7d59e9c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:22:23.8542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oDZl9FqUuUPiBxpfBMSLr0og9z1WDSlRfX2mXC5vnrYzpafGxfZ35Gqs7TurHGb6WbtMpxRQQmvzz6J45pjDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9528
X-OriginatorOrg: intel.com

On 22/05/2026 06:41, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> Initialize the Quoting extension and fetch its metadata during TDX
> bringup.
> 
> Because Quoting is an optional TDX feature, do not let its
> initialization failures cause TDX bringup to fail.

Is there a reason Linux needs to support TDX with failed Quote
extension initialization?

> +static void tdx_quote_init(void)
> +{
> +	struct tdx_module_args args = {};
> +	u64 r;
> +
> +	do {
> +		r = seamcall(TDH_QUOTE_INIT, &args);
> +	} while (r == TDX_INTERRUPTED_RESUMABLE);
> +
> +	if (r)

Elsewhere it tends to be:

	if (r != TDX_SUCCESS)

> +		return;
> +
> +	/* Quoting metadata is valid only after initialization */
> +	get_tdx_sys_info_quote(&tdx_sysinfo.quote);
