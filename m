Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52CD379988;
	Thu, 24 Sep 2026 05:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229030; cv=fail; b=d97URoeGfGuNFWKPYJv3GgdfJ+1MF2SZkrmolxgVdoavkWWH7L+RytyfQBLXFfUx7RunlkaI4L7F90SRsy6kqbTZiXexU0oZCLEP0OeRywquOeUyhvAR5t6YTSUncD/waQSVMIfDKFWII0cmcYJFcBxefJ1uLTpnDYE9opc7e78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229030; c=relaxed/simple;
	bh=olDjEYdHKex+KQh7p41uVvWl1t1aioEY6yH5vpXJIaQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BHJy7Q7ZBj7leA4PjhX/DXqe+EKutbZhpWeXX3DnBQAdy9i6H6MvolYX2TUkUUt2DUN/4AQv6mqPnzzznVmWHCB+bZPEZnfq0KdMbY9+0VeOqB5bWMympdI5JH1XLpB97LeQzRm1bl6OXF3/uepJ4wbNOzdDbq9VZLJ2wmk2wKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpfKUZky; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpfKUZky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790229027; x=1821765027;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=olDjEYdHKex+KQh7p41uVvWl1t1aioEY6yH5vpXJIaQ=;
  b=lpfKUZkypHacCvNDuXs956JbNp+q3rxvfUN0TwKiQ2OSNhBR0T9vtIY9
   LAlS9tfYBKQJKMx64JSXZFuanVPlELNazN+kLZbBJqWfgcUoeIUcgqyrB
   E8ja1Y+eaqnnsek2KYviikJkaDa1+mOMalesdl4A9PjhTeixW4UPfHw8v
   gvZJMrJRKi2Dn4L/OWlQNkj1mHkE6jHMEzbnso4rDf0IVSEilkF70BK9D
   PGa/UwjefTtHRS5eRV7OmJv6Qz5M2LocD3jOMZPwfygjm/NxrBz+X5iZ7
   cEieD706simOCi5xKcZDykoE/gxDxii7lBGn/TwZSfL83xHIm4v8XHzMX
   g==;
X-CSE-ConnectionGUID: qQEckFeRRX+/SWk6oPK0ZA==
X-CSE-MsgGUID: FcrfQZlHTCarr54cvd2AMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90053356"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90053356"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 22:50:26 -0700
X-CSE-ConnectionGUID: Rdh2DITQQQm/qRUuiaVORg==
X-CSE-MsgGUID: P0VmO2MVRAqA2scNoMvqsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="271768392"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 22:50:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 22:50:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 22:50:26 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 22:50:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RW/vVUebxc4KGwc75ZhglbNdhGQJTLGKajHhyYIEeW2dGs2Nl092bZXs3vvE7mLaccEy7pHltgbpKJ7eid6jZLz9diivEFNMuN9TeZpfNe2+uKL5ZeUKzJimHcLht83IbFkH/2VUVLF3ID/vH6sSN9QU+7D7dHBFOHwYBff2KzXNWRbry4MBpsxMT/UyejgyxKtgImBgJ6GBDS0m0cC+obnKD0EkAK0QVhvEpNzRU7ncCfjPNeIuzUA9dVA4a2CAkcd/dJAWs4RRq5hnRP22BN/+xQRvydArJrwNPYy9DhGJ6nKw30NYpkGLaw0jFmvCp1lGjMt0cr518lVT/xDxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxhUfzKQxWgBVQZjFzELw22NTh7vC9wbfP9ItLWcSkw=;
 b=iRpMfhAJo3hmXJjphvnmeqZHLtmRejZQ0AGy5e4H1PhEcr4PMb+W6OQjkKsj0I5OOU9oY16YtHCrPEniwUGEko46/OxtdT7qJxMU8tE5RPeYZO91/wyynMQq0KGtCIxAmOrQ1mPgPD5SnN6tU8NP2vR4CPPyD6iePYG5UKQjhSBzGlk+JomRGylKCfMN5NmEwYkumB6Qk0QL7IUNAPaupj6bkAdhv3zzeNanpfe8XTEhvE2txYaEBsCt+z0FXA0D58k6rIOnD2OvPNHDc+T7l+0eOAAqR42Ml68ZUq4K264z96phPWK9A8z/WA/LrYeHsxWZhraZyLPNYGw4rlNxNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by PH0PR11MB7423.namprd11.prod.outlook.com (2603:10b6:510:282::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 05:50:17 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 05:50:17 +0000
Date: Thu, 24 Sep 2026 13:50:07 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [RFC PATCH v2 02/10] x86/virt/tdx: Convert the version metadata
 reader
Message-ID: <arS6D6KoPbqVBtPl@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
 <20260918132946.76533-3-chao.gao@intel.com>
 <390fc4d56769f87d91949e900262640b52b505b7.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <390fc4d56769f87d91949e900262640b52b505b7.camel@intel.com>
X-ClientProxiedBy: TY6P301CA0027.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::6) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|PH0PR11MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 75facfe0-5549-41b1-319e-08df19ffb617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|10067099003|5023799004|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LROKUfTx3Cd2VIOnrXFEG4oRFXr1w/tQ3tdtLpsyhtLf/3l8FGH68GAR182tCBH2U0la2O5Z70uWa+AltD+OAV8hj0hvGWd0rhDmd9gSug+SKUCJAfWFErIhfHDLCUu6Qu4S8jEvtxCOGoAPQ6rQlmny0tGDVVjq/BhRJnbq3GBnS/iOe9Hmru0Vg+uV3aJXtpRwtHjEAqvUiszIsE9logDa9YA9qGENswjtkfY02sSOVg8JcY/+4QUlPVtPdh/4impuLipOs5cQ5qnyZSzmgBtVH14Dup1zcp5P8viS/HvZCNWHIRCD7yfr9Bpry7O9+x6fYZX3UWVCYqnPkoZ6gv3BfjKnbd2RogpHSFgEe0XeKiFA9JAaequfO0kh2DcMlxkJACmHqPyTlPpjw++0nqWjK5mFBlaoaK/gBwwNzkGzc8lsNUZL3Q/zGONB+kcaSTFN04geor+xAFKfJWarYDpq1ea50HsTgikzfgmEmFJqGwwyudX53bv6wPCRoozt/OXps2VwQ9zwGOEjYkRfEe2zyeWlmcyP5gz9c75OfI1Vk0PP5M97tJkY9/UxFJzJfEB+6FcDY5Z8gAtG8uX9XmUONRCYrKWdrLmYHzB0ZZ1IZjr7JBc9SAR1BE0Iy/PGvrO3CupBuhBW3kfbxJVHEQKX2judJdMdkKQWRNgLeZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10067099003)(5023799004)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kki3z/zyMeCJBLWObG1GuBi2qGJOa4/w2bOkgyKrWJeeXciBUoINgG+OrSRE?=
 =?us-ascii?Q?bP4icQeecPtRqmsMfNB8ysZv3XX4Gx1cFC5iNOlxz5LwyfKv5cX/8tehIKva?=
 =?us-ascii?Q?dCYYstIgaT3vyzw3hexzK2qD3/Wn5YHrnbiiH5jAnn+BGbzpJpBV0yR+kJeT?=
 =?us-ascii?Q?7+2jkM4jslMHWJt2U6sUKusecS0ojOeh6Ya29z1vE+YxxmvFrYOHJq9QzOP5?=
 =?us-ascii?Q?jDmIur2hFEXB+cColHh7GsrZ5+8mWfCZh7LnSkV7end1uq3jVMcc/wVEOHiJ?=
 =?us-ascii?Q?YwkLg13FfthdwGnwiskmSmYLHGJAL7ug0ku73ou1p+FbNHzUR4Js16q/SpI+?=
 =?us-ascii?Q?OIw1iHURBIT7B/rP7lVJ1VJxHf/Fyl+RnnHo8zjPbGA+dhpzxMV7Ndl0Muih?=
 =?us-ascii?Q?6X3a1nTvCy4vmAZJfUZ4UXL7JKc5LEA0uLvIoB6u6/9ntQy78zmEMF3QWkWh?=
 =?us-ascii?Q?d8ml9JhRD4fF3NwJToFcp29gncg5qNDCvs71tNzesq7YEjgyzs6h4Hg4LFE6?=
 =?us-ascii?Q?Hq9GZB70/uzF+lRQM4SGFpMKCKFPLClC0tZZNw5U2JpG4xLRnEcOfX7zSJxp?=
 =?us-ascii?Q?4XDXK3Xr5ug4/e+HlVMNSulVtZvx0+lDBK+X2OohjFNfvIIGLItTPxVjBxGp?=
 =?us-ascii?Q?7HbhiN/6pfUuwhJLW+vEerVu9TuDkXHC4Lf2ijQPRUc3nWuI49C8IWcqcMrf?=
 =?us-ascii?Q?6SqvL/9Zqi0APr9rOWVUEzSqWFdKscEmnQBs04i1tjfXWRYJJ5Xyex6T54PW?=
 =?us-ascii?Q?4vTE61+4FJ0oq/sdnHMgl/7eTMQ1E4Q0COucZ0nvu0q3H5taiWnsGs+p6zLr?=
 =?us-ascii?Q?aF9t5/i6hdjyLpAdM50JrFXzOjfJaosbbqYAHUdYxWPxWM+us3lbCYCiGhVw?=
 =?us-ascii?Q?f0ANeOZEoyWjIN+UIhKRB3TFgK6tly1ZAk1bVsq+oGMewuTcV2KgxEDBw2cJ?=
 =?us-ascii?Q?GIBY6DUILa5YuVEmLGy1o5qYpzM0O7iloI5tHyY75eLKsdNFOEBXW+vGPlxp?=
 =?us-ascii?Q?sRwSGMzcnll3P6TulTT67eYu/viYwV8Kunbgsta3ggA3QKRT0nNViObsdl1h?=
 =?us-ascii?Q?WvsgxPLxhGl1YltFOEjPUIKsz1SY6OHUuWlujehR+sYSyH7hV3vrFUM7mQEf?=
 =?us-ascii?Q?F0lEnmWKeUlR14B8jVJ4dL6W94HluGvk88x3S8X3YlQm6xOklfdZ57vtpaSY?=
 =?us-ascii?Q?ao8hCIIAiO8YGn6JHYX/io+S3SVBiarUFRvcwj8DbaRaGTpbDdh1GZoyz3k6?=
 =?us-ascii?Q?1UmDUzW1g5bt4tojtsaFLIc3rV8tqx6Lkbrn7o5zh3eucMDLVeeYHg7hV340?=
 =?us-ascii?Q?Tdo+u+COc+sL4fgInT7qHO7klNCj/XzZ68H98UegHNSsqxnIqSO4Y8a3yoM1?=
 =?us-ascii?Q?5ODNfyMR3WZglN5uqf5A9NipzTa4iJB5Z/ZbC0B+x40wQrqeZWtS791Pwq/x?=
 =?us-ascii?Q?OyfnxKeFGz+9C/3ZGo83/sbvW3Fop3CTOupepM/vEkpocc0vRKFVTxZIcEVw?=
 =?us-ascii?Q?rvxg7gikK7JPMuAN7BOnwnfMNOUtCKkG7DeevvVGAbkeqZ4dKARcsY4ByS8n?=
 =?us-ascii?Q?xUfVHSjXSz4o+Cx2QzOo6bmkWlx8Oi77r/J/5YTW3XVq4fTANJDKQZCRYU2u?=
 =?us-ascii?Q?8ajCnEo/f4IZG9MBb3wcDGpwQXjZumrqKpgQc8nlYUaC0fO+3aVl7iPBpVOB?=
 =?us-ascii?Q?MHM75qUZAsm0son34+Q7rBDt2vLnqYWzjqEkiyknu4t9FuegJ78/Z/plmPim?=
 =?us-ascii?Q?eK+7fveB2w=3D=3D?=
X-Exchange-RoutingPolicyChecked: ZiEo7fx1hpfvNbQDBwJMzQ3HLJ44BWpvzYnqx/ZS7HOtTgRCJYzl27BjpfhPMu+0FrmLlCMAfquynAfywcnOI4jc6RQk3z+LlL0nEKySBPnN9rYQraRzcPNKeOdl/EM6bCfz6Pco//+fRgoZSV8Uv41J/yE2Jch1v5C7moUFUM/yTN781SnNjL/fFBKje76pnSibuUrnUX7PzWASAryXDwnRjMYIvyCyBf3G/DY8XrIXq++xB/26lAfZvbvfOC5V/JqihVohyjI+ax9ldZtbxU+LvGBUEgHJpTzolUfWGLzxa/tvFRk5I317/c2e/PjH5JjcdqLiNMe5lmG2dPZJWg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 75facfe0-5549-41b1-319e-08df19ffb617
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 05:50:17.5320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5kmll5A/3Tx3Q6vEj8H05LSPsLTf7531mDf0GVzKfKpLSMz9qPE4HRzLA9WMkc2Tym87lZiQOAZONnC1ng+bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7423
X-OriginatorOrg: intel.com

>>  /* Read each metadata field listed in @mappings[] into @data. */
>> -static int __maybe_unused __read_sys_metadata_table(const struct field_mapping *mappings,
>> -						    int num_mappings, void *data)
>> +static int __read_sys_metadata_table(const struct field_mapping *mappings,
>> +				     int num_mappings, void *data)
>>  {
>>  	int i, ret;
>>  	u64 val;
>> @@ -431,6 +431,23 @@ static int __maybe_unused __read_sys_metadata_table(const struct field_mapping *
>>  	.size		= sizeof_field(_type, _member),		\
>>  }
>>  
>> +#define TDX_SYSINFO_MAP_VERSION(_field_id, _member) \
>> +	TDX_SYSINFO_MAP(_field_id, struct tdx_sys_info_version, _member)
>> +
>> +static const struct field_mapping version_mappings[] = {
>> +	TDX_SYSINFO_MAP_VERSION(MINOR_VERSION,  minor_version),
>> +	TDX_SYSINFO_MAP_VERSION(MAJOR_VERSION,  major_version),
>> +	TDX_SYSINFO_MAP_VERSION(UPDATE_VERSION, update_version),
>> +};
>> +
>> +#define read_sys_metadata_table(_table, _data) \
>> +	__read_sys_metadata_table(_table, ARRAY_SIZE(_table), _data)
>
>Should this go in the previous patch?

I didn't put it there because the previous patch doesn't strictly need
it; this patch is the first user.

Adding the macro in the previous patch while still tagging
__read_sys_metadata_table() __maybe_unused looks a bit odd:
the macro references the function, yet nothing uses either of them.

That said, I can move it if the oddness doesn't bother you.

>
>> +
>> +static int get_tdx_sys_info_version(struct tdx_sys_info_version *version)
>> +{
>> +	return read_sys_metadata_table(version_mappings, version);
>> +}
>
>I'm not sure we need all of these helpers that are each only called once?

I'd prefer to keep them, for a few reasons:

1. This one is actually called twice: from get_tdx_sys_info() and from
   tdx_module_run_update().

2. The helper name describes what is being read better than a bare
   read_sys_metadata_table() call.

3. Some helpers do more than read a table (see get_tdx_sys_info_td_conf()).
   Without per-class helpers, get_tdx_sys_info() would open-code
   read_sys_metadata_table() for some classes and call a helper for
   others, which looks inconsistent. With one helper per metadata class,
   every class is read the same way.
