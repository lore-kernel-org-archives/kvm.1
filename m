Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0513C37B40A;
	Wed, 16 Sep 2026 03:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529021; cv=fail; b=FlqmtVj1DSKMkcDFB6Eeax5qFpxN2NAKp6ysFjz+Q75jmaD3IzwdgJb/GyhS1iCF1X9cXFMVJle8c4DbUxIItDikHtKjc+X3G2pQsu5o/xUJj2ghROPz1Wj8q4yQD086lKcyi3QeRB9yhE6YFaU88Dhf720y98mRWe+osfVBQ0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529021; c=relaxed/simple;
	bh=v3lxUHgvnDFqEZfRo/8xjNQ9W8L9cKEsXeuSZdsWUtc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LWTaING2rlf/yXkHD6UUToHxcchL5WvK5B6RQlGADgDxa6zwSY/tB1m1V2cx2r2mQcw/j6FLnPKjp/VB9MwJaYjaheWRxt/coPwNAPg9abpRt8n6bXwun5ORzW8iuwGJy1TPjoyoNqDGNFbI6Nm4QJ5vGmYSYlcQmOt7UOJrSA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNERpBnY; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNERpBnY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789529017; x=1821065017;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=v3lxUHgvnDFqEZfRo/8xjNQ9W8L9cKEsXeuSZdsWUtc=;
  b=bNERpBnYPomX25GLxQpyTgGucndHFd5wRTIE+U4vVuyCRS4EIdbDsIb5
   BWr/eSpNGI2LyVwxeVqVMSkZAEMJmZhJfHEzN0MfR72VzMALimHP1hnla
   esLm7BnPxk48HAMvckAINnGNX8zr2rrMszTp+U1ShjP4bhWcVMP+mHwUW
   H4CkoXnX/4fSeuLFEIEz3LZJeKMcbQQYqRfpp972wrqm746zJlbwAPsSv
   lGyNMKp65JZBLZcgb4+uD3sVTP0azhqfpQa+e+gV1tmuORLYisXHzWGiy
   44h1M0wR2WQTyTj987zyfT8t00FQlRbcWWv3X9QguXW4giQuB3CHcpgyD
   g==;
X-CSE-ConnectionGUID: St9yuQPRShmToM+XNmaDhQ==
X-CSE-MsgGUID: uec8seeHQw2cDT3MdBFFkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89036218"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89036218"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 20:23:35 -0700
X-CSE-ConnectionGUID: hrnvaofJTg2rMK6ZcNS1kw==
X-CSE-MsgGUID: w9N4dfYuQfGjoqPkBUIaLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="268928048"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 20:23:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 20:23:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 20:23:34 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 20:23:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjUUs4gpKmicAXFYOd4NnWgxgFPe+4puFg/BbLsZeLbSX1ZMcmm6ugQatkWbSmvj6GAMj6lMnze4WfsWAyytbvS/UBpvbpAXAcvKWvXmVTJdeBy4jnRjYxmryV24DtQ0wTvgXDzglhknraqG27qh3VvPSeRZjofFLuxepE63ICp/EX47v6uTwAuOnSUpeZ0l1sAzjtnHk4cn8bgeLv0oVF9x3jdz3MUY4iw9BNhlAKCGmoZXNEXIfoAY6JsEDSdmiXDJ7h1j/Fu91H10uxmAtRj4VGp8bN607UBvv/WPC0Ua79AZBTQz/a81xuIMHoLMVf+iUTzn3JVmROcWPgdccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3lxUHgvnDFqEZfRo/8xjNQ9W8L9cKEsXeuSZdsWUtc=;
 b=m2RmmZ1i07zplg0QPAN2UPbLo6YpmInH9FIYpWJUQdnT1kBwB62sEIKNkzF23jcHgM8+6jFna/sKdzIWV1BSBJ+IFZeZ7IdTGoEkRpg47kUXo0kL/htaySSU6UEZfKTDr1PdJo1TdFiXNw0hYAOjzERKY4Sjk9tVsfmgJFEOkfYkp8oO1wRVY7eGM858Ul3cKb7u4IuZqd8ldMogzGnpO9/jzr2Cnlepur4GzVWLDtQ3rc000adERjTTK+w296Z/Zg00NEjy6/P6mPmJgUem2HNhKLwO5x/U3UhEW0qdhBwUF2ANXVdzr2yCHLQZvq4Bx9LbOestiso9TVAGHHEnsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8375.namprd11.prod.outlook.com (2603:10b6:806:38b::22)
 by IA3PR11MB9181.namprd11.prod.outlook.com (2603:10b6:208:571::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 03:23:32 +0000
Received: from SA1PR11MB8375.namprd11.prod.outlook.com
 ([fe80::540d:f5b9:7f09:6ae5]) by SA1PR11MB8375.namprd11.prod.outlook.com
 ([fe80::540d:f5b9:7f09:6ae5%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 03:23:32 +0000
Date: Wed, 16 Sep 2026 11:23:21 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@intel.com>, <xiaoyao.li@intel.com>,
	<sohil.mehta@intel.com>, <adrian.hunter@intel.com>,
	<kishen.maloor@intel.com>, <tony.lindgren@linux.intel.com>,
	<peter.fang@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <artem.bityutskiy@linux.intel.com>,
	<kvm@vger.kernel.org>, <nik.borisov@suse.com>
Subject: Re: [PATCH v2 2/5] x86/virt/tdx: Configure add-on features on TDX
 module init
Message-ID: <aqoLqXyeXUFkvnxF@intel.com>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
 <20260915102658.713079-3-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260915102658.713079-3-yilun.xu@linux.intel.com>
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To SA1PR11MB8375.namprd11.prod.outlook.com
 (2603:10b6:806:38b::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8375:EE_|IA3PR11MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 16747ebf-fae4-460f-5b74-08df13a1e2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jbYiI9TMdlakleSelEPA7UXtXae45lsuqhRYm8Y8VzitXEQwXXflm8EyCsoFQLbRfp/L1SZQewA7bo8QekR9gGCxpfeYG9n3U9yiYmTJV7ZRx2bGo+c0NUKQoL3QbBTWgWrhaTgLn71O9U5joHJt2YPb1SF/+5k/7j6ZmACWoH7LtP6QvtIxcflRjkSi+h14eDuNNXJdfG4877MJ5vO116/IOSIX2fwnPU9UyCRRydbDPEZGeXh+24D9kr2rW/FMMOudAGEy6Nozh47mm3Blv2OQYNB4JCsx/HPybyiFod7MZMuf219iGILkid6sJLMS33U5uqWjOAOt+yeECcedDs3Z6VAfNa1+jyyYtjCDMDWI3zfQ98AcSlzj71KVAY2ry32VLUpOSw1gicPGmZUWNft2ZFCCzp+WTiA709XW+9Imv0PImWyXbFpJewOITKGWY8d5KyBDd8NVtz1tgewnESBOyL1bSEJsfJbXIhzpEzM0qulu/WTch31jAfeI53C5UbrVFtNk0ZT27dl0DJZ5o0sUV76XTQ5uoX4u+twHE3wogmkAX2FIyiwdf/o0DbhHn+QIFaIv06eD1pcJN954p3mzdzXFO5tTaiCLe0xVi87njcRHqL5HM93sU1SPSyMFOgZ2vYRo7y4Uy8I4vGQsMcqxNe080+8LO12WLRiXeTU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9NK0y0h/gwOFHcs7ZTXfheaPsD6QLzchPnLoX1Cke4lR12zOOxQn9GI8Xbob?=
 =?us-ascii?Q?api/oQlZ7aEYBiMUlN7b0GaEFTJ7202QBDLtE8NdC+Y0wkEpspjfQ5S/XF8Q?=
 =?us-ascii?Q?AXvqyyRLSldZj+ft8f8eH7+z6Ac84KXNLsos8kywAIrn1K2mepxRjhizBo/3?=
 =?us-ascii?Q?1q3u3G0ievnnYHlT5UAbrwiRNARlLyZZ2oLkh5NxGe9BBrgvg8mOgog5S/5M?=
 =?us-ascii?Q?BJ95BbGjzrHJ3DBDPZNfB+Boly9Yzqlg8uiZGpGYyBExOZ8NW7gXeiJ7TP6a?=
 =?us-ascii?Q?cUpEe8WFnO4GGGe5f0zcfvAvd5WfN9HQoxfcryvozOxo6Jmz3Y3T5hvgzq2Y?=
 =?us-ascii?Q?ukoXI+Sj8RJz10rr+DQbV9fG8SlVM5p6hJ6Iz6oEZ4s1Jl6uehzD8Kj5DB80?=
 =?us-ascii?Q?q2y8W48vxl2CL0x5HEgA8CTY7mmlmJm5zY76IN09H3Imo5dUFqyfR55vKoOg?=
 =?us-ascii?Q?ALRuIFk6o389mZBQQEI4qSZO67wyiO5w+rbWzXpiLXwLQEzABkRN1T31FHRx?=
 =?us-ascii?Q?kEKSkcOe3EnSGgE8SS1FJZpP71yvaaw10BjpIdCbLbrN39DOyYtRWjTFGxsH?=
 =?us-ascii?Q?06uTTuCVi79DcZiFWLRKOMSXggiljFYTKuY7PKVrvFT87XIdZbrUfdDVeiZy?=
 =?us-ascii?Q?d63XZbNBeIMrt3nnoBFLqXIk8ABIBPCbiwCb/E/Gsp5I5bqjsbP0jutW+f2c?=
 =?us-ascii?Q?V7yCGJ6YSQsi2411aOF11BjVHOLIntJ6QEHrt4SqzvqAgDIBG0Ddd8uHKTru?=
 =?us-ascii?Q?iGFdnxp2RgqKNwqPvYZ7VnjqvexzE+Dy4lcliVmShTeb22kLUTqmV6mJvB4/?=
 =?us-ascii?Q?jNDO2i4rQ9nylzZBN9uRiAVdmJzs+HJqCe/2moRxnRXsrvrAx6BqeNAWDoIT?=
 =?us-ascii?Q?C/A5F3nX0a0uxFO/62t1cPv1WxZW2ADLu2qn5cOZHW5DaAYqTlUTkrQF97US?=
 =?us-ascii?Q?J1HNTYTDUhuDVPu/cCJiX//awn1thlEufSHqgz8lDq/fuptYfShjaQsQevZ3?=
 =?us-ascii?Q?gXKU3LIKwpFnVzt0kjZTXoginrRcb+Z0sVXhiX6tH4ZHq5cRkmRPTBjPoBBQ?=
 =?us-ascii?Q?MGzn01O5HGYZtqbvWaCejLMXMjQhSUu0enRSSS4xAZNkyr6AD2y9o8LlkNzo?=
 =?us-ascii?Q?ohmzoTY9Y03xdfJ5adklUp8DCU1OOfBbkfa3CNELz8rFrC9TCeSV3SqH69BU?=
 =?us-ascii?Q?Rx3unKundNhP/6UKX4OSfGZ+/sqoKLrkrOos4mFeCmX+y+3j9UunQdhJIZZP?=
 =?us-ascii?Q?DaS6di+X/JCt4bQQZVEumW5aFtWbmontRiD2izEciILYGUSkICQEvIsxkVqz?=
 =?us-ascii?Q?K4toqtP4sO2lX4f2kBb9aDaHgHEu1r4voPMVUTC4g68EIx473dOgJGwOm8Wy?=
 =?us-ascii?Q?PG+jb86oST3nJDuZlXf5DsT6viejKHz+uJNHLE5nuIkLGd715Xv844X7vK8x?=
 =?us-ascii?Q?tVaf9vXgpew0Wuwttt1mgyxvQsGfoNwVS/m/VTAwZPPoT5OFMmCiuf8tWawt?=
 =?us-ascii?Q?uIMpfLeHZQjmuY8CGVwnTYdYMKjiIxxu44pbGqDUmZGXyxiC8jZWXjybS95f?=
 =?us-ascii?Q?Tn5gHP3xsuAKJ5Ka8wNoiVUTMEyUy+QKK0LrVbfuxJSF/LooGnPEyam3Xz4N?=
 =?us-ascii?Q?So/E5s2XF5xhvhwpWl9Iy0WZbq6G7jzSjbBzdynRLpryxbHhvEt36JlpCVc2?=
 =?us-ascii?Q?SWeuXawrupafEcRPPYcMOdp6h63NhhDpOCZnqwuORG80/cs2Y5EqgJqXHQFW?=
 =?us-ascii?Q?0Am2NIFRlA=3D=3D?=
X-Exchange-RoutingPolicyChecked: weUsRV/y1Bol+DqT5g0rUfMUdFur7xjrwAmW/fn2gbgwKY6z7vCNZJzVIrwUPDOPABQrrXBlOvkQfZ9wt15StCiAjjB7it/CD23cyQtt8ZIxnX2F4PVB0Z8+MxLEpwP8r7UhJZF00MTeGUpTkdgJOu9QvMRZWFBBzJFVzHTxCcLy5x/p2CPB48KDhBayLMSAv0QBSxIy4zYqeMbr27oK3WhsIz4z3J1nu9oQcwOOtP5tTD7WGC4tPqmvfvGOqPK6zxiQNz9f28j3sH/Fqs50aFy1zR/vMxlv0FMPnKFhYTcxh+KO1jvO6BxJC0LktT5gD5ZBYlgnUmw7CXZPkN8qxQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 16747ebf-fae4-460f-5b74-08df13a1e2af
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 03:23:32.7131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mony1BTIrUfbaegkjXnwJtAWQ7iJOXol56N6cycR6eIKXu3W4CieCV1pBosxDh/Ch1YwI8T/HQuIQSJoq1GAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9181
X-OriginatorOrg: intel.com

On Tue, Sep 15, 2026 at 06:26:55PM +0800, Xu Yilun wrote:
>The TDX architecture identifies some features that are off by default
>but can be enabled by the host during TDX module initialization. They
>are classified as add-on features because enabling them affects existing
>TDX systems: they may change existing feature behavior, or reserve more
>memory.
>
>The TDX module extends TDH.SYS.CONFIG with a new register argument to
>specify which add-on features to enable. This new argument is a bitmap
>that uses the same feature bits as TDX_FEATURES0. Note that Dynamic PAMT
>is an exception: although it is an add-on feature, it is controlled via
>a legacy, dedicated register argument [1].
>
>The kernel needs to enable these add-on features when it supports them.
>Add a get_tdx_addon_features0() helper to return the bitmap of the add-on
>features that the module & kernel both support. Initially, this helper
>returns 0. It will be updated to return specific feature bits as full
>kernel support lands. Pass this extra bitmap to TDH.SYS.CONFIG wrapper.

The last sentence is stale: the bitmap is no longer passed to the wrapper.
