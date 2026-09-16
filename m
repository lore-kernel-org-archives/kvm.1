Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3F64AA03D;
	Wed, 16 Sep 2026 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551206; cv=fail; b=leMvozOpwVhq16wV1DxcjTTfdG4vdQKfR17Zn9x5D2CigJycwoq96WbWdSqwvA9bt2pfpttjeOGApA/J9cVpx++mfUxrzWK6WE0flyTjsvTrbZJmlFhOFAbmCox2aTE902bv/58SpnR5CUJ51sPGqb0La89hQwzOBDjg6mnK+tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551206; c=relaxed/simple;
	bh=Z/NjYNtKSxlkbzDKeUvk/dXnfbWGL5kczdWRII3ZgX0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lAnXcofQMwMJxYdA/AKELqlRGJHwnRguH+QXz72KO2g8cko8lGiFJxSnOpNW5vA8e9YMESKI1U8UYjiWjL5d6k4Jti78zhCSEUCFJFAWnITZvDcrddV3+/pGWMrJzhEANfMzaY87bloEt4ogC6fZvA80Kxyw/1ZammUYRigPZko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhmFnmfW; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhmFnmfW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789551193; x=1821087193;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z/NjYNtKSxlkbzDKeUvk/dXnfbWGL5kczdWRII3ZgX0=;
  b=WhmFnmfWF1GD21FGEj7f5Ma7ao9dsmcI3dEDW+BuiLFW7Qs6vaFz1I2Q
   M8t/8Lu3ilYwpYVeuunKO5bogdd1nMWtUmp6tSp2Q2mk4x1QVbAepIght
   z9JSnnjd2L5PeDXvak6lRuLTE6B+1B6AKqO4R9YUDHvUk0uID113n1ghc
   dgNcwZ99jWA/gwk7wPy2gtHGW9uI/YJj5QqV/f16FXGQpuo3Jak8VXBwd
   KSKvYxIOIXs/JVNkmB05LMo+v6MDUuEDkJM1fvKSMCk+QJRz8zUX6d4Za
   ulGYkNMnVdZhjR+Zq4FCX3W2ql9+Pu2gmRxqlrygt9LGqmYgwaidSlQLO
   Q==;
X-CSE-ConnectionGUID: 2HYjHbpqR6uzONlrStEQ3g==
X-CSE-MsgGUID: R6e3YFMaRq6a8KE104cgNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93625765"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93625765"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 02:32:59 -0700
X-CSE-ConnectionGUID: hCqp09I4RK+Abzjy5bThWw==
X-CSE-MsgGUID: pTYF48SXQvGnkuo0rwzUcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270013508"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 02:32:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 02:32:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 02:32:58 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 02:32:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsFHEIizOuU4A/yzuw6FsDU4J0Bcf/Fdjll5FEfl1S/3r51hjIHOwDPmoMHWMJGQsIYFJATym0qUqei6ECedg7E/zRZbsOS/xXKEY2s+jCHqw9anZyeYCSW0BTV6cMYsCErPiD8q1O77ol+R7w4GK7QhsRuJcAvWmfcOyRFj0JAZPkVVuYFVCrKVWOqV/xl7ho+oDF8PDd8eOuNzePCt9FXD35D4LZ+HJSFqeVf0BxQqvse+SQJj5rawuj3z9KmmSFZ+xVl5WX6WtZGmBvDIEGXHiIO0wUmbf4CbNTbvI3iCW3h95RLHTybkVXgSM9GMaq9TdfPeNlwaNqRRYt9iTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=js179uBChgsRWf7V+qXBvxsZMlKpqE7WYI9wKgvM6R0=;
 b=EFQfzPQpd7jBx7FtRoQzXmnwkqM5XdSBKQiNR6F3/inSx4AmTwUpf1+GlyNY5qICY56FrgxhgKbTA7J3vVe/Ur/IdFSDcuBfp/17O5oivuuc1dechqm1/ri98ztkpVJ8b+UZhSRwlIkL2JinH47NZGusuP9aw+AwPjfBcgZAG8L+zYlIHw7+I7pU2HXnYF7kV5SP7y42lz8b7DJqy1uQ6R8q48t3ZpUFQlryzMo5/TXUo4ab1rY2YkdeXup+Zpx6/AxIJmnbiomOhWYdH7Y93JpUg9w7eth3AlWdmGQdLmaCtKjwkVgDfof/I9Ez1CVQwZaiK8u+mHXc0ZYX6jCWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by PH0PR11MB4885.namprd11.prod.outlook.com
 (2603:10b6:510:35::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 09:32:56 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 09:32:56 +0000
Date: Wed, 16 Sep 2026 02:32:53 -0700
From: Peter Fang <peter.fang@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Li, Xiaoyao" <Xiaoyao.Li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 3/4] virt: tdx-guest: Use a variable to store the
 Quote buffer size
Message-ID: <aqpiRfPez9EReEl8@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-4-peter.fang@intel.com>
 <af483218-5c87-4ce1-b4a3-06132dcc3c49@linux.intel.com>
 <apit+fXmapCA2qlc@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <apit+fXmapCA2qlc@intel.com>
X-ClientProxiedBy: BY3PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::15) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|PH0PR11MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: 5816ec67-b5cc-448b-b6b4-08df13d57d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: h1wU/mEzGruwTa8MtoSyik6G6iXiRZV8LilbT/7u0g1hQgW0y5srqcBYSDbw5zJLn74flBZNsBXHUIg5YyOXO7WMJc12kHYCXedPSi71oNjSY39Ni+8nW5J7e+Q00C94CJPpXWvKbI/YinNEZ093QRI4Li5MAsXqRP9tSBWuI10UT+sV5/zI/ytzu/Zaouz1CeHY9mQ6VMz1IsN0QJJ7/sadHN6NT0mRUBLuDtjg1heBosOiCmzHXbE8Pb/Kp8fIQvZMX0hdlQJFK/Y6VUXFbwU7GWX3tc4OYTC6KcrZFBa3Zvy9W18gKyylZszd5/XXesn7wOBwhujWo7zd/vY1kvEDKhOXvS1mlHP4fZTitSPtVInCrRAcGxKaS8m8VoVvT9vj2hPQj2JeSx8MqPWT4fO//5fvOA/shp+08loMEEmMsRHQ+kv4c/b3ezYhk5ikycrzA7MRxkAu9QenMPAssmkaTwszk7ajZJRxssFb9LiM4yKU9FCX/WieXWcGf4Y/n6REmeCx3uFssORdq0g4HCfOlp7z+qEE/4KJk4tXvz2uuLolNWEJBhKcLIfik1Cwi0829LcBmvJqVVcg/91gkQfbKr/MH5amzKUXijDooB/+/5tXGuLhIRJFUnROWtiaru/g0n9dyy2UaGPuqbXW5C05TnPZ0USe7iHCJoNtt00=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?af+zrajwPgrhVJBoT8MO7WqYfMgNaljf7FwItBDCZsmYDfG6pxb93P1ifzeX?=
 =?us-ascii?Q?Nt6bKmHq8Dgi4FY3sBmdQpAhJorf2JXsXAN9fkGeJnFzN0bpHpG2NlADUej0?=
 =?us-ascii?Q?F/OgIk46x4OuYNbniMuEikIR8H36D/1faUArks5Ff4893XLRSfHBNegu3DX2?=
 =?us-ascii?Q?A/cVkhb/p/oho+GZknkE0fmX+RXc0lRW0FNaBp0WYdtCXl+lKXmFb8/XhvFk?=
 =?us-ascii?Q?dXdbx7IbgmmvVYqObIDPup6vHGTVqBQtP3Oib1FItI/qmN/MLuCTUkGEgkTn?=
 =?us-ascii?Q?YfedrZH2JBymwNfZlg4d5Fqdzk2Mwzszpl0kETIbQZVvtycT4xSLzko8cphn?=
 =?us-ascii?Q?drCvcthvRPfsIncb07oAMK+rMZP2SHmvKUKFgqgckzmfzyG+Kku1Uz69nOtd?=
 =?us-ascii?Q?vTGpPOm6Ht7NkfCyYYnb79hxc1srRbfoJr02Qu8tPCpBiqHCdz3+er6u/H3i?=
 =?us-ascii?Q?oBQw/A+Em48c44rdO0F6ztLuvs3fSdDZhDc87XoPsN5YKUEfjygmAlY8LeW/?=
 =?us-ascii?Q?Byy0Z8+fHsrkQldHwsNZ/0g3mHbj5L4Jjzde4lYgUYsCVjmihHQ6aR8K67rf?=
 =?us-ascii?Q?MGXYmqFz4FLG0s4155YROLu6hM1K0pszV9Z2AV6ghj8OWRxf6Tdokcy2SdiP?=
 =?us-ascii?Q?WKMhs9TA8BvWQd7foi2kOGvL34H4/bBBU1pMSQpLhBE6zFbo4HJalIt2jr/A?=
 =?us-ascii?Q?QfGX/J43yFuLsMOKEXQCK58lKSAnGxGFLN/dvFLAa7yITAnNqsnVToy7u97v?=
 =?us-ascii?Q?JAD74CgVpt/AACrsBFjajkBvfUkGUJpKDuRa7ySThYye/sOb/P9/SFVDrUW3?=
 =?us-ascii?Q?58xDjSj1nXbGKpgax1tpuFJkOtmpoR2npaw3eKACyErdqapv3xL37FOQ3nCP?=
 =?us-ascii?Q?IQUBAdlhAFuZAZF4Tug7+RzMKZPDuBGrbmrtdbL9un3JDOaDWe3fUS9SEXQW?=
 =?us-ascii?Q?ji+DZNvqA7+01b893opeHlbbcCxc9afHidrp3+sH05P053UF3ksL6Ct88UK9?=
 =?us-ascii?Q?90ifpqy2CaFAwU05fVQS2dvhNy7eyQi9Wk9suIXLRPQi1/xXb2ibIbE2oP2V?=
 =?us-ascii?Q?6tRlNU22i29N3P7gwxP6ZOkhgEnTu63aLR0nNGRGaROfo3IFdsN8zbVfeUm+?=
 =?us-ascii?Q?alt/W1ktP8c8rI6fDMXtq7n/XZn94ASGacGGEAERzVbX+iaApGf5yIMj0NG2?=
 =?us-ascii?Q?2B6Ml5Pt4mYBct2gXqIIb37eQhB2k04Y0vnWFTezjRFe4gi04I2PEUeS4vUc?=
 =?us-ascii?Q?6MqDyTilX9j8mEK3/4OIoKR5+SNRWTWTdSpp33B1cE8h4dK1Y0C2OT2md6DK?=
 =?us-ascii?Q?1VHbl5WSpsD1ZdscMrv988iF6bN1ep0vm8v2/tMWw5Lptfosn61znz9aiCus?=
 =?us-ascii?Q?B8ZUPllCFPeCLYTJT3JadUfLwFV3pnVmJmL6dNIhGTsAcjUT+yB8vCj132kz?=
 =?us-ascii?Q?eszIQEeQrVwu6T3mKxRWIPTmnGsOf+I6AvkOWsViwO65UCenDcUI4Bj45GTK?=
 =?us-ascii?Q?snIYR37+6vYuiTjpvEhk/gTdvABEGNXKALVvtq6OCKMWlBsTEMJ7B+wwNI7p?=
 =?us-ascii?Q?gTTzVNo/Yt/3Uvs+l+RjiXCLmbcglajCrwl56p+C5Za5gHmoAufXrQbkoBfi?=
 =?us-ascii?Q?c6cIS/V986grzZL6EnJhOIBGVm5UjL+tsew3GGjTxG05p0vRwH0X5ni04MNg?=
 =?us-ascii?Q?QjT8RwBbZILUzLsO0yGag5UosY5WJ+Rf5EEhw3pl3H4CvrwuiNhCe1J2UVUl?=
 =?us-ascii?Q?3om0Cg80Ww=3D=3D?=
X-Exchange-RoutingPolicyChecked: KcvMNZtiVph1PKHUp9kwWfVvnhS6ReMZhaV/7r2vu8ilSCTC00Vo4h3bfgsWmRV83lsoJQikIi7FAazIvCxxTn6iBHP9842eRMrmCCYljn6d8ED2C/n5OA4iiMQqnA176gZu0SIV7C4bdLTSesT1pPWQzlVw421MFMGiUwni/tkniFWIObtSJBoH+ntpBzfT9mr3KO698lkyWYQSqmOzS5WkJViAdSeECD4I6jRLOetLbmyfpqbOFOcYHNQi3e6d6IzqsowXbhd77Sn10Djy/tt2WSIJDDznNq+zhKTvADOIjxRhYz5KIdNsCt1uS2+wXsKJUSpEyOGxS3Jb5lUMdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5816ec67-b5cc-448b-b6b4-08df13d57d2b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 09:32:55.9744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YK0ux1Of2ZRZ+4H7XcXVm5KL0SqVOVH3v1xHXMMMDiXQYGMgTMSw/Q0EmtKJMRw3ug7Vwx97ebAEEgoFOc9xbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4885
X-OriginatorOrg: intel.com

On Wed, Sep 02, 2026 at 04:15:05PM -0700, Peter Fang wrote:
> > 
> > > constant with a variable.
> > > 
> > > The size is currently a constant sprinkled across several places. Store
> > > it in a variable and have all the users read it from there.
> > 
> > You are also dropping PAGE_ALIGN() in alloc and free calls. You can
> > mention it in commit log.
> 
> Good catch. I will add this next time.

I ended up not dropping PAGE_ALIGN() in v4 [1]. To be more precise
PAGE_ALIGN() got moved out of the alloc and free calls, but was kept
when initializing quote_data_len. So this didn't make it into the commit
log.

[1] https://lore.kernel.org/all/20260915092632.2822169-4-peter.fang@intel.com/

> 
