Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7D647142B;
	Wed, 23 Sep 2026 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151862; cv=fail; b=N/0MonBeURYfiBIn868SMH9s4P2/xGF8YSsDzS7oGqUDXHn5jgOQDT18ia7RpDH+UB619V62jjrrDMhwiq5NKM7j0IAjHgV8dQqelN5FqzcdpeUwKKiMg67W4glC2qiTxTuqq1BHsuBLEPhJKSc1KU1zIXtcbSa/IOwvvRJEt78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151862; c=relaxed/simple;
	bh=UhwU7Yyz+Dji7d5FqvwXx5AwISDwWw0L0KS18DrvNUU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sLeSTGZ/1RheQNRjmXiJXbEIu/sajxh7ctwjRVx/6VdAqKv+T+kllJdoIlTat+kI/SEhdyHvn3klZ6Gl1P5rLiVubFcEVX4AF8wI0vGGWkq+nhzwJ4cXJUfgzLBt7xN/ca1czL0ofuW338oXX18HB7BPuS708Xus4XBnClzhhk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYhb8JcV; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYhb8JcV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790151854; x=1821687854;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=UhwU7Yyz+Dji7d5FqvwXx5AwISDwWw0L0KS18DrvNUU=;
  b=gYhb8JcVJTACwxnEZBfUeoqcyAUdxKNunTvXzpLwnTQqVxOgUAHGf6a9
   QArNIBmLbK49zloWldNNkouC8pp2qxnsBVVdKMRRtYMfyeKjf3uB8LBzG
   pIJ5U+bmMd7TPaY6L60ukEamsQ9W9otKWAXeKO/VbeHm/z9ZXRJ+VyRCV
   Qs1JoXMYQ0YX4jzTUmf5mgzYKflD1m6Bv4nEvR22mQ7h6cb9T/QytxexS
   0UNuPmg8gph2XP40mbYtErPPevxxMKaYCzlywp8XBq6yr9nyWY68PP8fP
   rp3eAfYc0ea5vJnK8cFR3gxW4LEHLdiBPJj6CgxVGsobOohivnFuy1gXQ
   A==;
X-CSE-ConnectionGUID: gkJZWMf2T/KmLfxMo4CUvg==
X-CSE-MsgGUID: /Xp9TTiISwmmlSxDNTPisQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="78376575"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="78376575"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 01:24:09 -0700
X-CSE-ConnectionGUID: wbE9eSxOSuKMXz6hSBj5Vg==
X-CSE-MsgGUID: 2hn6OioZQ4udV2vVJsOwKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4565280"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 01:24:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 01:24:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 01:24:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 01:24:06 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 01:24:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecSOd3tBZ4WSkTC3BxCdu8WLNqxTGltAIauoHjYvppKK7ZDLQhUIPNOCLI75ooYW3NNgEuPbEyjkHTCTmAOJrwbXegCXEfiRjeLLsNaemWcQSsqiQ6GhuCgc+vsHev/2I84m/vvDFtsSQuQjVmn0vZnyhTRbZIM8ArQY4gec1kvjOADtdP+2tO6WKWKWFDX8QdPdcA7Quu4sEM6N1HtE0VnPWNs1QbYZt54TaxSXSP51v7dmpyBsLraK+WdQwLgFo3b1fNCBAQF8TcEkK1SZYiN/Le2hXdw/aHBWD0U3J/r3AIAfi+IGGgSrKuTwUOImi206UUDvH5jKnJhdVLEWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTfom16nguk16lT8X2Bffx2ZaX+JuCfiSKdh8ezk3Qw=;
 b=G68e7ICv4BfdKPdy0EKLksIunmfzI582iMAhvFgYI3QEzUE0r6OLYJ+GdKCmVSJu/CGE4nV73KC3MBYye7VlkA1PoU72Vc6tXDSqhwoq9MAAPIUcxHOO+9HBZbwWOuBqRYflIJ16sv4DAg0paEiYIguMrz8duvrWMVDzgeKUuJbzU4YdmSSQfGXveZRTJxoH7KOmfrpm6ZMQYMOM2O4L5rgpauPo/vpNEjuGGZyyPUgJrIGIwH0UEHfzA99GYOG4w2duXlL3rzBeEA7I0d39N65hPYkrbLzB+x3NsMX574bIgDWY8zE79KXl07HGKfcGr9v6VvACu6fO79d0NVKzrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by PH0PR11MB5901.namprd11.prod.outlook.com (2603:10b6:510:143::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 08:23:58 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 08:23:58 +0000
Date: Wed, 23 Sep 2026 16:23:48 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"kas@kernel.org" <kas@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>
Subject: Re: [RFC PATCH v2 00/10] TDX: Stop auto-generating the global
 metadata code
Message-ID: <arOMlGbXRcd7XyBv@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
 <c320ac55c4e0c0e8e8d3c9c399a63f15d949d109.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c320ac55c4e0c0e8e8d3c9c399a63f15d949d109.camel@intel.com>
X-ClientProxiedBy: TP0P295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::13) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|PH0PR11MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: 7599cad0-1cd5-4d89-02c4-08df194c0417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4qTQ/bZqCudjM9tWUQScRzQJS/Ezjthvb4ZawtS86axDPQmNU9a8mwd8BE5zK57ZlhRbSKXF/4Reozymk3qMNEsevNLCFgE/jBZikW6d0neFO5LgI5pdGh0Pj483VD4kF3NEz6YMT5DzTYAQelVWeiWUx4GBrannXQLZGY8gGO1L8TJBV+wURVlfgH883xMCHiPbyLBXBWCowSNm1XEgl9KJtBUMTtW3pTVxteYFnWnIGrrG3En8YoxJaFXKRNvn5MPVaTiQo3hU07NIpB3k5gqtNzHeSg/WfG1m5xqK9WHafk3MI9+ZZMx8OWIJzYcOZ1PqTrZZ9OjP/hzGAsE4yeAkQ/4qDo211a0/hszd1XEnwatPy65wEH29YUgJl5LaKiE9DBwRUst0oXy76M/YPFSKw3jrI3NWaIvDk7EBQkVmhvLNg0McYWd0oVkSsbQ2kJ0vB5GHDuUH5UUuL+vBC9LeYTe0BqHI+CI+BQBYAfzxeV9ncA8zKHwcJhVcp4DqFkKpgFpLNQgyDLHB3p0wUnv8tN3AYHi8OI3sPmFbEvxRB33jcxF0xSdihMQiUX7FgypJiDe9wdQw+/TWjH7XbUoHe0udqMumXV55rvJVF0eJZvHcfcMa0Oyo1qxjlolhZ6AS9O+FT4soqBtMEjan++heFc0MRbe1zs7E+h13zCs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0dcIZRJ5/iZJPH3vjsagg7PteFMW5EbpyHdDg4gzJ4jxJ0v2m76v1pM42C?=
 =?iso-8859-1?Q?cfFEkXE59d0ih843GEdrb4S5jte8LkZYFtpm2wm3cRk1GFVRQc16xAtpbZ?=
 =?iso-8859-1?Q?Mqm1ewM8GrphAsRp0fbpCKe5tHxb9afTDBifGDsl0KWoOW5bJhIJ6T7yqZ?=
 =?iso-8859-1?Q?yGWuhjlJXNlJ1RIg5B1kAvKG3gMj5ZRjiFgcLcHRiL9pWowoesi88i+XYh?=
 =?iso-8859-1?Q?JfnYrwdQ1YPcpRb4sa5Shfi0dg6N3HMWDIXyG5ddFAb1+BNcm3GOmTinrW?=
 =?iso-8859-1?Q?u6O5e7WbOhmVaah0oDL/mcHpRlTbRt3qni2n6EmUJetrZLxjOmFuzrSpC6?=
 =?iso-8859-1?Q?zU0SpyjCv+Na+3GhVf1+m6vS15Qf0geRwVF3MUsNsQQUH5ULRJFzgoHBl5?=
 =?iso-8859-1?Q?D1ZAzvXzhXTHOGITGiYD4nRuZX9mCLtLuyEKZvUwqVOD5UknxTQRSgdAF2?=
 =?iso-8859-1?Q?qekWR1sjj4n5jLgk1hPlC5ar760OAbwSaHV/rxEPpX1vdf7x3tWhXNgUbL?=
 =?iso-8859-1?Q?KBq1yWD4OvuDsd64EnWf+PSEvRWjf4bz/P/QPfrqZtTHMpHLq2sKk+pjpH?=
 =?iso-8859-1?Q?/mmo5HI9t7zOX2p1XF92kIwx+M3DHgJjjvKtCYE+4vBMDJdsuCVl2Fc7rS?=
 =?iso-8859-1?Q?/u1K40xwSQ0K95+T4VxU7YPDTBOfzPKaqz6rb9A0+gQXVClaQ4aj/lCL5f?=
 =?iso-8859-1?Q?LNIor/2xyIj5oxPpimUt1E4L5z1F/nz0TG7RJeY9Uk2A0u21umWlRFIYWM?=
 =?iso-8859-1?Q?vLH8mu0BmIGPpnZakn7//XiVV5GfOFy+U3G6tNk0G38U7l7z8J4ODEvDMO?=
 =?iso-8859-1?Q?WTn9r57dtaCaT0L/YQNd9IhB7mWJz9CoP4+tBNrp1fGr8hzwNdEL9stfB2?=
 =?iso-8859-1?Q?1ZQFSVCwlLRQ65Qs4Ojrq8GCxYqLKOd8/0b6HPceAEzdBhMTt9qFmZI0lZ?=
 =?iso-8859-1?Q?RQ2PCSsOAiD/9mX/q8SYIGfqB/T0Hl++W+wjuZSoH0phMVnCwJGmJk8Epn?=
 =?iso-8859-1?Q?D7w7ckfJjWFJ81utlzfTrs1rCkd3BAstwTCDai2HDfh1Ltqq7XdXn7Vi0M?=
 =?iso-8859-1?Q?rL5Omw/ez1QGCKBER2WCu5QQM7jg1GdK0fQm/iwfEbfkXSPhQEmKU5SQt1?=
 =?iso-8859-1?Q?u+lghUsy6wOUOuNLbyJmj0oZeGWhRLHBPfGlm5Z1oeGJHdjeXQ9NjGc5cL?=
 =?iso-8859-1?Q?A4sjc9WwzNOP7XaLgJ6MuNcxE6L8OoOOM4pTZysXhlDkOsee7gevCLrS5T?=
 =?iso-8859-1?Q?Mw22qYqbCj1jL6vK9F8s5u1PdlVhvrZ8CSRvlfEP7vJSZiPmXn33zsnecz?=
 =?iso-8859-1?Q?NinBpdI/2cDNxGTvCdeC5Agf3+D6gpqGciERoH/qi3TgavOG9h+86vwsHo?=
 =?iso-8859-1?Q?2P0n+o/5FI8jvpyZrZshAb29jXREUaKTztPksKB9rM3uKHNQN8tRu1U7wi?=
 =?iso-8859-1?Q?93FbgQj1PPnjRl/mdy+2TRl8kVvajbu3NoIrAWDMlP8a619479ioG5Jtrk?=
 =?iso-8859-1?Q?XWlcGIV/QxXinWStPAkjdhg1V2B3VIPjLgyoH0D6bKr4I168ldlrng4IIp?=
 =?iso-8859-1?Q?cJx29EFWDGSH7EB8LeEfFw/s4MtTm5NDEyf68tG6NhHcILV+FpbbYnzD4N?=
 =?iso-8859-1?Q?v7htKJf/YIFwt86ZtnaHUqMouRudff85LuJfFrCDmkOTSidLSh3R6ZRQBt?=
 =?iso-8859-1?Q?rnUrnzqQopXPbCZU16lrUZ8HgbvbaIOqPehseONkZKzcJkpNTzVyjIdkS+?=
 =?iso-8859-1?Q?FnCNCb4jHEy6RDc2PjZU3l01U0x1qlegv60jp4pDrCMnKtqP/DtQ62y9P/?=
 =?iso-8859-1?Q?yBz6Lw5doQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: tOa6pH6XxdAGau+7h05DmnKsG+aWOgMeNsHEOTeLCXERloJJtcPoY2vnd15i1VaIv3JZSmzYPXd4mo/XuSYCa/i+K46eFrsab2JGP1frszvOB+rP5kVhHlLsZbk2VROhlXYTxKP7UkXINYD6sm7KTTpnnEZwl+vY8K6QuWUrtQd7JNLEvMkSqIVB/sPZe6MzQPg5gMj/5C2On50HLsb+ak4xfCnhyGieNWPwjAuVaPRa+gNogANabIkgrnhclmq9leCpglj2lh/SGMjglpQgzpVFOCuHYk4Feu+rMVDGN5njH0u18r22FTCr1NdO2CKUr2udOnYIPEtA7onpU626qw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7599cad0-1cd5-4d89-02c4-08df194c0417
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 08:23:58.7757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPTODUoMGHupJPaTeUwFgfbWJwq0WII15tkDAkndlVRALAFxYta4LwIXf3/nU6cuc25k4YCf+rXJLpzC42oJOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5901
X-OriginatorOrg: intel.com

On Wed, Sep 23, 2026 at 08:47:13AM +0800, Edgecombe, Rick P wrote:
>On Fri, 2026-09-18 at 06:29 -0700, Chao Gao wrote:
>> Chao Gao (10):
>>   x86/virt/tdx: Add a helper to read a table of metadata fields
>>   x86/virt/tdx: Convert the version metadata reader
>>   x86/virt/tdx: Convert the features metadata reader
>>   x86/virt/tdx: Convert the tdmr metadata reader
>>   x86/virt/tdx: Convert the td_ctrl metadata reader
>>   x86/virt/tdx: Convert the handoff metadata reader
>>   x86/virt/tdx: Convert the td_conf metadata reader
>>   x86/virt/tdx: Remove tdx_global_metadata.c
>>   x86/virt/tdx: Use early returns in get_tdx_sys_info()
>>   x86/virt/tdx: Verify structure member sizes against metadata field IDs
>> 
>>  arch/x86/virt/vmx/tdx/tdx.c                 | 222 +++++++++++++++++++-
>>  arch/x86/virt/vmx/tdx/tdx.h                 |  54 +++++
>>  arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 154 --------------
>>  3 files changed, 275 insertions(+), 155 deletions(-)
>>  delete mode 100644 arch/x86/virt/vmx/tdx/tdx_global_metadata.c
>> 
>> --
>> 2.52.0
>
>What is the base commit?

Commit e61c837817ac ("Documentation/x86: Add documentation for TDX's Dynamic PAMT")
from the tip/x86/tdx branch.
