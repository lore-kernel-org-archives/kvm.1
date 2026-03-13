Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3321370D74;
	Fri, 13 Mar 2026 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773390539; cv=fail; b=oPHt3p9NppF3wCigcUClFbd1rQ6w02XgnK4kG1cNbFwGlGLi52CphubXXZ2SCG/spqwpLi053bM6C6NDLtilCSGyKDv0tCiS5y9y5clsO9KLRr4kVYw+kFScTOOgCw43+v8tLpDH7dAWiv4EqdTf8hYNvNi9t18ptDQJ7Hn11D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773390539; c=relaxed/simple;
	bh=gnTd/GxFcdgNgZSxzEgpy/jLRFWCARpz0jN/IWB71pw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J90x7jsHBoN3jNCbrLw0R5sT19TppoPI01BcA5bZJBPSYzxlrlcypfK6saf3+0NtAyn0wl4ayicjc9plGBzTivHkb+rSgJdYKUsbMM0Abv+MNMTVjyuwLHUvHUSLqdYL3FtxG0z/6A1ExwXynTqJ2e8mmIF6ceuOKH/9Vbcozk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pi5g97Yc; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pi5g97Yc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773390538; x=1804926538;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gnTd/GxFcdgNgZSxzEgpy/jLRFWCARpz0jN/IWB71pw=;
  b=Pi5g97YcHIJ0rX20sR4Xhibmp4UmluKpg3h3NHbWMOJom36wOWnTf25c
   B+o/dgQO06sguERk9lrjn0LIsKOF0kolbT3ujAcRCv5dzYwzgOLQ0STv9
   k7lan74B6MS0PydeNukR0OZTsBrcUqoGiJiKHXtuv4O+WFSApoAW5+nzz
   2kX7QUntAgg1nEynk4sHeUW5LRb7BP1bIL2xVcImppjv2oprf15/QMoJO
   pbTS2GmuQAEBam1Zmiv53JgjTerkSyzozg7Uj8nDIcs9EQRx71FmdfkT1
   J0MHuJrmh2VSZQ3fBYO9x34yjpoufuBC6oXPSq91YrZJmCxN0eRfNOoGF
   g==;
X-CSE-ConnectionGUID: Sii+qa4fQkyBnySRdW3eOQ==
X-CSE-MsgGUID: JMk4m75RQq2RjJDD7FLKGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85125045"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="85125045"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 01:28:57 -0700
X-CSE-ConnectionGUID: +DwJEHluT52C9GAPIZjWjA==
X-CSE-MsgGUID: WzPAqNKdRUG0qJHlHCKAJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="218447669"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 01:28:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 01:28:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 01:28:56 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 01:28:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtRv33qDOww80nZwjAVT1cMpcCVSvDvFPBgRg+RV220dh3AjYIDj5KvowJBhoqJ8bP2+S8sc6GmeOFu2IU9Ha1S7GRWc1qULxF1BdYrWdYkdzr7Q1ynC9C/Kf9eSLZRcRk0Oe2QPbU5ZQNYgYE5BTX2gwfW5rBxOSZ/nmSBnXcz4WJ9rIWukJ9G7z4ZtXORUW0wdhuV8yFy08TsQf0XYglZpnQqjD52/hzuzHr0BtW50o621ntktsrtPKL01H11PodDhs+ep62XVvEQRRkNU/FlNi3TiaZOAuFyKRwvjJaLoWMptX+OEJ6cv4j+O9NjCYtCk52wablNs7G9+LR9WBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eyi/6OQxA+sJDGMJ3YXwjH1B/gY1vz0+oXFIUEZ2qro=;
 b=mXCfn4ncrE8sp2JkNx+lvRFZwoo7A/NkjSZMeijcUVkiaYO5p5v7ucx5ysIqgA2Xt6K6M4HeXJV2UzxiXizx3ZvKj9eiBX8OsgC1X6LjYeFrzsZWTaneeSGx85BUqwPzsrJOJFLWgi3dBDALWDcna1cBzLTb6j7H1QWGCXEdJn+P+bJfto6nWdlqkBs8BfRIGforQKoe1Eb/sLpU6xaOOdKiE6ydrmxthtVtR5AD1nn9DRlByRynrvPaqdPG7JJgpS30UhaCWm3tQTSqOqdes4v1H6qzjDzb4Y8ScqmvdAfTyvh9fb1/dCATji2753/Do+ijU+5NvpKSDJDLHxrJXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH7PR11MB5863.namprd11.prod.outlook.com (2603:10b6:510:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 08:28:53 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 08:28:52 +0000
Date: Fri, 13 Mar 2026 16:28:38 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <reinette.chatre@intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <dan.j.williams@intel.com>,
	<yilun.xu@linux.intel.com>, <sagis@google.com>, <vannapurve@google.com>,
	<paulmck@kernel.org>, <nik.borisov@suse.com>, <zhenzhong.duan@intel.com>,
	<seanjc@google.com>, <rick.p.edgecombe@intel.com>, <kas@kernel.org>,
	<dave.hansen@linux.intel.com>, <vishal.l.verma@intel.com>,
	<binbin.wu@linux.intel.com>, <tony.lindgren@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 07/24] coco/tdx-host: Implement firmware upload sysfs
 ABI for TDX Module updates
Message-ID: <abPKtjkkf3o4sqB6@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
 <20260212143606.534586-8-chao.gao@intel.com>
 <5b8d6f33-272b-4879-98ae-11c3cae3ccac@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5b8d6f33-272b-4879-98ae-11c3cae3ccac@intel.com>
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH7PR11MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3bcc04-1775-4b56-7439-08de80da8f22
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KuLaWud6TPc+s9co0wi9NaGUQedTohrdvCdldGjJbRTcWg1H3kWVNCBj0TsOXTRhUsVx04e8g6esE4DMgqVsShIHq/G08YU+a+cLVY1ZZow3p2OCvBo+yQjtC0RHUf5sMNao+m0vDCLOhTgaBvKDwu9WQ0Bo0SHdq1pJ3mxgzXPLUrLZ1iou+FyvCjJbCzqbLMDFlcEzMXSgM6Y4kskE1XEovRiKqzjGrH/Iiish/0Tm7PzGeZLwyrjvh8dHWPNl4tPJTFBQibXuGptK+zTckir3//Q3qs8KTdIvi+U6JJTc0JgMH0Kbov0EHDxRhfTz6Mx9ts7k2rzYx9VzzVGh2/w5V9PgKbAQFFBgxqX+T5Dlrai256HNZitT42AMTbHNStHZhr4zlTJulKteOHbtz0/F4f3QWT5TvYnCHRX8FgEYc0esiOmQMbWD0yHhmmED1jol4BcbDnTsQkqwqKcBJs1GmFnHZsNsjuu6Dmfhi0mRBrU8B+iiNEzcNhzYAKdGZ8pTzT5bOALwDrIvMqNeHaVeriISF9N2dhv6plDzPBT+KTQinrMebHMFgZK2UBWh+WIgug8Jh8eJXikkieqYGLrGU/fs77UzU9Ai2wwfXOdrTbDamVKjsSJU5BmT9E+Vl3VOssrZ1Ms9BI8KIcAlBMX6WtZdYiNDCb5uDMhk8fNVBZISUdKgmYF7/nkC2haSEdYWPEHvj8bZzqxhQNseWrz1wOzsPnaClOCKk4qtsdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?usP0UYz2QLvwIRwS9yOviodgieVyCqCmfX4GcLdwmXKvGouxRHqEGVt3oqvW?=
 =?us-ascii?Q?WG7JksmnF8jLGmT90kbvZHhSWq6XMd2YJzO1N6m15uq5C+NZ+ru8vUJZMgeW?=
 =?us-ascii?Q?VVSYJ64ez52bJucjj2Q4GWbOBNRneE4GnBqcGrIT3oZbwNVYizs/bGZ6svAa?=
 =?us-ascii?Q?wtBPQZXa08XLQDBrSlwGHWJkX6UaXIkSJyQ2ICqBoBe+4abLyRC1FcFLAq6L?=
 =?us-ascii?Q?BDjuHJVoPqAOBkMCRx8qGihLDx1wIw205X9iAT6MeVLooeOsMLiVFfdW6myk?=
 =?us-ascii?Q?GDCevs5pBFWh6p2WHtnT6k1CXhoImIYD2oBXzN/mswH8TAsJS/qM86k2Xou7?=
 =?us-ascii?Q?YGPe/DacH15SaK5roVLx9aFw25k8RJo+ws8Wx/NThbEiYDrrYeAYhTRWgKwC?=
 =?us-ascii?Q?2V8+haVo8g/xZCSmNsM3XxYTmaYpDUGQMNzhVQn9qPf1JGUOB1db6gliBZsv?=
 =?us-ascii?Q?DnZbQ3vy2UWus18aGXA0JNqhUgxU6fRcP8OpL1zCxs43elngozLkRYR1aTbq?=
 =?us-ascii?Q?oXuJRt+9eOaB9X42694GgpY1mMJVMdC5/vX0rz7MX4jZtIYPX5lJ6drDUsQ1?=
 =?us-ascii?Q?SvZYyqbpQAJZhjPtRwl98L+AMEv7ufmB1NkMfYaafSk8N0fpq0LPysIjr8GQ?=
 =?us-ascii?Q?j14e8TeHxaLGazoZAgxkpXJVUR78CM5gQrmoUnsgXG8zTIRFYc5dSVDrz0AV?=
 =?us-ascii?Q?CYksy416J0EY/y9pCmob+zhwz//Z74jY4LexOz+LQ23oxO1uJKIwYFWoHbPZ?=
 =?us-ascii?Q?L01V0cdWcPtALxpWiWtWLo7f2Z8rHQEfVFc6M3ez4vUbU3qDpBwoq5HAJs7/?=
 =?us-ascii?Q?henTycI/OC676ggITnS6iWY7FWdAkcM6BYTIeNkr6eLSZHVP3aVQ4daa/Bru?=
 =?us-ascii?Q?U+lYwo2Wkuz/j+Ls6edWDpO/RrMhRh5MWJzRu5p5xOmXcp469va8gYQyJkKr?=
 =?us-ascii?Q?z+JMO0Vr5c3mwe5gGOvc+5ck7GPtWyIoVpKc6kPngWV96H0+u0icK+/fLquO?=
 =?us-ascii?Q?lg7bzO8kVwN8pFJ1mAo2KXobbi1hO5SgZBns+FQ83wyInvPTxdG+NUzJyanG?=
 =?us-ascii?Q?5pAqwGaHoFqigtW4ElZ7SwTRvqchC5oZ2FHObZpVl7pM93AWkoX6hAXTPM6l?=
 =?us-ascii?Q?WCLrxCyk66rLMiPUmiiamFLbvYs+O+9q6bKz1Pphyoh37n9Z9rIFr07LvfoR?=
 =?us-ascii?Q?IDuyfls6Wsc/7bAO/lB5Hf7Gtn1gpm4aXa/SzKj2IMJKyXdjKmhwllm7lz2u?=
 =?us-ascii?Q?Ii+/KH9kftOIEu9cfHqrbRfp2di901a/rW3MPfMLxmazL87Ki61d4zhU2RF4?=
 =?us-ascii?Q?TB0c0cw0AzvQYyw5CtDodYugBjnKVSnb/TTOdftECSWGJAxbpzKxbFZbW/oE?=
 =?us-ascii?Q?V+zo7Z+yIJAqgepgSdxKNjS+lkTgQj5k2mpAp0N/ZiD8/UpvwoOkCaFxtMd0?=
 =?us-ascii?Q?SGisKkdwMcwU+5g+0qbnuD2kBL0M35O4fr472oh0XVX1Qkhg0G4uwEN8+04V?=
 =?us-ascii?Q?eawxDflDnbMPb6MYYxPsG92ju8p0R9kNv6ZGFp9bMoxakKbF4P7VYq0bhU2E?=
 =?us-ascii?Q?wjMMGf1+em16k2qKQtgpxRr26bOvIkv80iIa1J23Dt225fwtwx9P+MJRUthP?=
 =?us-ascii?Q?a4Xrn4+Gw1rD5JOhlb/suQcTa2AevrirLYjlxUPe95VoB5prrhXJ8c12kGcn?=
 =?us-ascii?Q?z4X/EHjLvsmK3etuQBbuCoDzZLRRL7F1hUy4lW6NfLPLF6NpN5fvENl6IijX?=
 =?us-ascii?Q?UKxcHgry8g=3D=3D?=
X-Exchange-RoutingPolicyChecked: wdOfuERbAAX/IUNQq97Jjq+0369Ax3i5XGjx2B53bP5VkeoyFWVMwviNJy88Yci0K8lxCTn0Emgr9r9UPPkknoYPl9qiAAfq8GP7f5lmH6PmtLQWKy/3Ks3W1GtAX0kXDYFi1KF5XR8A5x3kV2s3xL2DqmsCT9GJ9dAQfcBfUWoJ+eoVSpzZyoelVrEJ/++jG+RcBBQV+MShPZB9WzPaZqpi5vZNG/QVWNCapxqEvg8vjD9PFq4gAjKEX8tDqCqKV656A4RAx+EVMB6tRl4RDXQzWvjwFxn4NOH6cEpV8pkGWJoLUZr7A1G/dxFs2wglrohP0hFwUy28p+gCjuARTA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3bcc04-1775-4b56-7439-08de80da8f22
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:28:52.7601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rJn70vfzsn1nvFQT367UKHbxBTCT0/ECMfua1WAVDx1Un/JMCaCs2zaHFXQ+CJFwerCrV5Njr67/5ToFsxVgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5863
X-OriginatorOrg: intel.com

On Thu, Mar 12, 2026 at 01:20:59PM -0700, Dave Hansen wrote:
>On 2/12/26 06:35, Chao Gao wrote:
>> + * @data: Pointer to the TDX module update blob. It should be vmalloc'd
>> + *        memory.
>
>Why?!?! What does it matter? Why enforce this?

The firmware upload framework stores firmware from userspace in vmalloc memory.
I added this check because a later patch uses vmalloc_to_pfn() to obtain
physical addresses.

As we discussed offline, I'll remove all is_vmalloc_addr() checks. Since
vmalloc_to_pfn/page() already has a BUG_ON, future implementation changes
of firmware upload framework will produce a call trace anyway. So, no need
to duplicate the debug code.
