Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050603D34AC
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 10:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283712; cv=fail; b=fOF7F2Xl3y/QBrGHtFJms5R7BvgHEXDr7WAisU5zEOk7h6FjKrOChGsmCwkWcn8AjKGLdB7fUiLDB0Kz/dHVM0e0oLOLUiR8HnUhfk/q6JOq7lymrrDTieY7bfAEr40D1DA7JOjToH7bGEuwWMWCaAUYxY0i4M8HoFy3wZgG9MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283712; c=relaxed/simple;
	bh=/Svuo5Ar/YS+HwyM4okLdf6oyR0eEZrW/47ztWC7d+A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K2g5rhyV/enm1nqhBtsRO7vOs7undWsWDoJvvcbYLhLk60QrB2q5axm3rYc9kt6h1WEVHitkSeW3UKnORtft83R2dNDZyG29hgEN7ndcXa+7wA8Lq95uGRdcA5zGatNmzo9JNrImV9m0+V8D3KmvuFbcG860bCjBq00D8vY75NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfme51Z0; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfme51Z0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784283709; x=1815819709;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/Svuo5Ar/YS+HwyM4okLdf6oyR0eEZrW/47ztWC7d+A=;
  b=mfme51Z0qGvC03f6g23RihBKcxzgansLhAZ+VpWI8wE9H2mH56YnpLUR
   02MyThaXSXmWWdhNvVcpB7TFfFFRTNFC2SARVX32DVYU057ipDnZ1XReF
   oIopld16ThuMrYesZgvOlOqt9LbDnPvw+/CiGn5vWTCq8Sknl+6vadBT6
   FChHPA4SnbplWQB5NG57ZPqJNZlslRDAvvA4pTsJFPU8D881iWHF5a3QV
   9m0LkdBnRUtsaRPpK0JMYGHXIo9koIhbrbfO5TEhokiPiKW8d0CybIaQX
   C+uD+pxc/vuqD76ZIW68RCmZsnv+SyQgiajGHN9ZrHBZheGsyI/jdn8db
   A==;
X-CSE-ConnectionGUID: GuWjFl0JSXOAOgbTDMX9UQ==
X-CSE-MsgGUID: Umw07/DWRc+7GPDQ2ZE+UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84075545"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="84075545"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 03:21:47 -0700
X-CSE-ConnectionGUID: rM/vO+s2T7228P+nYH/8Fw==
X-CSE-MsgGUID: YAwDhu8RTSqPlGilt8y01g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="260571349"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 03:21:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 03:21:45 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 03:21:45 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 03:21:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yX22pvAPx9wix6RLlKKn/sW4ThpmNd3bBvp8YuF90A+fhvYNk2yxHjfIKQTeu7UZEiEhMtBtNRdYCfVS4bN3YA/sLbnPRCpmbim6y48WNhpJereoPNLRZCgPPqmu9zNjeUbXgXTkUo2JLM6U7HUMSlArx/Hj5rja9hdEjGHDur+CCyGoVgFxMBmkYjXuYpZlUuEG1xabiHiFmT5iZTn7xR53troficGrO/7uSVDbCF7wBTBcQWt5Lrhfbok1tfLnLCgPg7SACKh76MnHJvnvmEFjMD3HumiVQAbesxRdvr3sVcuBRB9jfbEdbGOIscUkGnLQGrbeAEHnciCD5izAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUyTzNbXrIIgxcbxX0MrqeaSg1Isye+ExA6Hgjz7uyM=;
 b=kJqBuVsmM5ZkbJXWpicuS7noFXJ5wNbtUzGHmRFr6oGzSxU75S6R+bQRUqycm/3XDCFfiK7FNDrDhJJU4TyeY1XVeXeSfdSra0rxyrLJ4tlMJ//9RlW2pBDfDZ74hZUGepR2E09qBLn3tkBjjoWS7TaSpWWyMnzV2yHOmf1QpeBrnqhV88KPf990Y6BN0pR6d06TBiMdFeQ9NM7YLzRxVDUu52JsRmneLFrMf//UGB6ouItQmAYD5y1yRVP56+enMbFx+Gl4J0IDNTKgqh06m1BMLO1g/clIjaPlsf3UofyWl2JUbbLh+g1O8RtnWPorjznJvnKUM5JIyyWZQg7Xow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5643.namprd11.prod.outlook.com (2603:10b6:510:d5::21)
 by CY5PR11MB6390.namprd11.prod.outlook.com (2603:10b6:930:39::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Fri, 17 Jul
 2026 10:21:43 +0000
Received: from PH0PR11MB5643.namprd11.prod.outlook.com
 ([fe80::db77:8171:4d1:22c0]) by PH0PR11MB5643.namprd11.prod.outlook.com
 ([fe80::db77:8171:4d1:22c0%3]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 10:21:43 +0000
Date: Fri, 17 Jul 2026 03:21:42 -0700
From: Peter Fang <peter.fang@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
Subject: Re: [PATCH 2/2] virt: tdx-guest: Allocate Quote buffer dynamically
Message-ID: <20260717102142.GF3178326@pedri>
References: <20260612110853.3188196-3-peter.fang@intel.com>
 <20260612112202.82E011F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260612112202.82E011F000E9@smtp.kernel.org>
X-ClientProxiedBy: BY3PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::11) To PH0PR11MB5643.namprd11.prod.outlook.com
 (2603:10b6:510:d5::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5643:EE_|CY5PR11MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 1530e0b5-04ed-404d-5d29-08dee3ed32d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|4143699003|6133799003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: sUKR/rnU4SjYHY0OOZzn/EztgxFaAMtKf9cR1kuXOGACoCFhTP0SAPHgtiRY6qs7kvpRlLWBOkOzqdw/0m2HhgXkWk5Uc0HRkwmBkgxUn9Oe17ob9mSoHBIx32ztH6AJOcQY1cBad+LgNh2jQTBL4bvs8aNuLZyl/146qN7usUK6RWIiWHzWqBuE4zd608BXmsk/vw6BtJ7KZ/thJF3E21znkRSZoXS7jA+HiH6l3IoEry7b0lz3++nYf5WKCQWy2sEn0A7tOzCtYlNs519MZpsoM9RYPgWyAadt2asnmPc42Hv5rLFDQ6FntyprJD4LAHMqYs47oDNy3ZPXxVniPqN9s7fsOQ4Tp8RTT03chIpet8+UdwCyuWOV8rfqJstSI13Ji71hbCsRS+S8OuhNq8wg//pH6k9OGFQImRGKqNJyn4+P9KtQD0m3MU+/z3M+KH745nNqvbNROTDdWwKaoIIsJDyec4II104gzju7bfw2v2c85sXkzG52I0vX43eTnZUafPDJiW6AdZLIyjFsXSzZVrsTXIpLhkmUFKsY/3EufR3x4X+vR55QmdXquHXrs07ZWNcyNGthMtGqWapW5Zkk3f0ELt1DR+Am1ePtwrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5643.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(6133799003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UStCbDlJMlllTm5JUVhSb1dicWVKWkhaY1BDZkRtejI4RTR0UnE1Y3RsZ3k0?=
 =?utf-8?B?WU12SzdRdC9WQTU4NnJlOURleDdRWnNEOXc4QnVRU1h6OGRzTDJMbGN2bG4z?=
 =?utf-8?B?SWtzakVtWmFoZ0VJZXgrNk1TdkZDNE9vUEV4Tjd4RU5JNGlnbG5jVFhVU1pS?=
 =?utf-8?B?UHpUZWEwR3VLV25FTVJhRVF5VzFHTGU1Q1M0S1paeG5kcEJ4LzR1K094a3FL?=
 =?utf-8?B?TUlZRjlJZllkS21mNHBCeFlPQjRZdno0KzBxb3hjaklKd002Tm41ZXdxaS85?=
 =?utf-8?B?S3FXaXF1Si85eDl4eHAyS1ZmZTRDelp5b0FtTklkdEZtTEtCUDAzUTREb3Az?=
 =?utf-8?B?NFNzUnRONGRpTStSNFl0U0hLM0NCMVV2bHl6Y0VaeDVJQXlrRTBEVkhVZ3pz?=
 =?utf-8?B?QnlJOFZMUFpXN3dobXpSQzlOTmNMT05RTlRTODYyRHNqNXlBdVZwWWRUZFpK?=
 =?utf-8?B?MzVnbFZSUUF2T29QYWEzeVU3QUdmYWpyUWxQZlJhVWVSQXRTTDJaelBvTWlT?=
 =?utf-8?B?VUh5MHZGY3dqMlJxVkZ5aDVzanNncjBxQ1V5TlAwNkFqZC9MeFJqa1NEd3Zq?=
 =?utf-8?B?Y3E3ODcwS25JTVF3bTlpRHp0WTVzb3VNNE9naHM2OWJIS0RjeWtvRDUwcEdH?=
 =?utf-8?B?dUI4SitmMGFsTDJpZ2tMRDlFT09LWWpZQ1U1RFUzSDdhMmNwaGx2SWxvQXJu?=
 =?utf-8?B?NitRTUg3YWVxREJYbGl5VmRibmFzOFJmOXZvOVY5dTNWOWgwWUhmNnNGYXdx?=
 =?utf-8?B?Z05BY1A4UG10aXB1ZEFSNHlWQVloR2NtZCtXRDYwdWVtV3dBQjF5M2VBNzBD?=
 =?utf-8?B?RXVSQ3FGaTJkd0JVSlpzY21XM1RGbzN1TUxtZitLZnVzT1JtOVVTL3RtRXBO?=
 =?utf-8?B?VDVsZUZNcnArMk8rWURnQ0hFdjhvNUNzVkdoMkE1VkZ3S2lsOTlvNk0xSlRZ?=
 =?utf-8?B?YzVUaDVnWXR6MnVpSjVTMlRzOFY4SDd6enk5TXloenc1T29iR1BHb1dwRHdu?=
 =?utf-8?B?TFFOdXYwbUpnbmVOdHZtWVg4K2JBaWZMS1V0Z2N5dnRWOHlNWTM3SksrdFFq?=
 =?utf-8?B?MWkveXdWRUpvQkgzRXdKSTJFV3l4SmZ0eDF1d3BrcWp2c1BDNThER0VyeU13?=
 =?utf-8?B?cHRlRGpXUVhSU05sclNNVHRhbVdqdEtDUEtCR1ZrZEhxRDFMVmw2SjhzV0M4?=
 =?utf-8?B?aDQ1RFlmTFV1SUp6WUd3OXFaZThPbHlnUTMyTVVUNTBadGdFVFI1WHVtNHpR?=
 =?utf-8?B?YzFkdVFGRmJHWXdBZW9RdkF0cXhpTFBlVVRDWFIrbjVEOUQxbnE2NDZFS3BI?=
 =?utf-8?B?bk9icU9Lcyt0TTQ1R25jSnVodW9iR1BFL3pEUE8xTTMvakkrYW9DNWVqN3U5?=
 =?utf-8?B?NzdKSTgrZ3NBbGpjdVkweG4wWitqTC80VlJML2VnTW1KKy9QZXgxRmNzU3N0?=
 =?utf-8?B?WnRWWlZORHFrcWdpVWt1K1M3NzJoanVhTklCaVBaRGNtTEdtT3Q1eDZ5Ykly?=
 =?utf-8?B?YnRXTE02UDJKcmlXMnRHM2E4TURGd210MGlpb09GYkt5YlRLYitwbDh0SzhX?=
 =?utf-8?B?V3VTeElFVU5BTlNMZVpFU3k1Smx3RmJIdGRSeXJTSFYyQnJYTVYyWmFKbTJT?=
 =?utf-8?B?N0xsZElDZ2N5NTJHaUFId1gvY2RueTQ3NW9DWVhaK2EvMko5V0M2SHZLL3Yy?=
 =?utf-8?B?blFrMHFNNldhREgvVTUzR1lrekZmV1M5RVJqWWlEaVQ3S1V2RmNSWC91NCs3?=
 =?utf-8?B?aVZid0tCL3FlMVE2cW55YmZtbDBEZ0FoRXNsNEhNNEhWbG11aUtWMXpqOWMy?=
 =?utf-8?B?c044ZmdYNzVLc2svQkZWUFJmbE01d3Fnem9JeHQ2K0NMQXVwcitlTFFWOW1x?=
 =?utf-8?B?ZGVWSjdhSVJMN2hkRzQxMllsbFluUUdubUR3cHNpNmluNnJJZk1OcGZzNlFu?=
 =?utf-8?B?RUxVS0R4VHAzMkRrcUV0SXM1dWlBaW9uVDNYdHRXcVFWVE5PMkNKZTJ3blQx?=
 =?utf-8?B?Y1p4NGdNU2UvK1JBelpWd1hpL3lkK1FXbHY0elAzakJzYU9VVlJxcG1aQXRn?=
 =?utf-8?B?K3F2Vm5vN2VLTHNNVXd2VkM1R3JBbGdYZzlCNUljOXVtbFN0cVEwOUlzSnQv?=
 =?utf-8?B?ZXI3UjN5S004Sm9ST1BxWW1nOWNGQk9tTTJCNW1ObEo3NDVIcUJ3bTg4RDlp?=
 =?utf-8?B?N0Zva2pZR2JoU3JEcWwxR1djUkE4MzhLSU1OU2RDREhTUERTV3ZQUitmMmQr?=
 =?utf-8?B?cThMU1BCdURPV2hETkhobHpaVm9QZ0Fvd2hIR0xoOHNnRysveU5vcG0vdXlj?=
 =?utf-8?B?emZkbXhjaitsYUVXSGZjQVZwYll2OXF0cGxqcmRkQ2xESzNLSHRBdz09?=
X-Exchange-RoutingPolicyChecked: hxjJoUe5dyXmxfWOshRr6RDIZBSBW54GFEOIjNVM5I4dLWMxCPTgPQQFN7jlUEv/1bLonqP620Bx+UwG69Jt6SOVD+7k5qr0XOrd8WdKlaok+H/dieWVxWG0aiZqtS/Drao7SK0xmuApnmQBCqneF0uNjwpNveXdl/XwxWCnIa2K5BRIRAMduH5MNgYbEWkGAojkTgcGb3IJM9DGR/hFtLxLCBFq5NVwZAPt5HSa8jqoVzERM4Iua6uPuKHFuRrX2oeDmMaZFsEo5c/qeeuVMR5WNTczkXrTPo6aRbF/TdGqn0zh4kBsITy4ANSo3eSY9LBoUCSAXfZzz/8+pW/oTw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1530e0b5-04ed-404d-5d29-08dee3ed32d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 10:21:43.5011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMNAEPA5WQo/zYzf1AP7lebWQEF2OegGDpnwzQtmYpTtS3yfZSG9+KQI6cj7gVNIzdKDxp7JrCbm5Rn5WPogvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6390
X-OriginatorOrg: intel.com

On Fri, Jun 12, 2026 at 11:22:02AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unbounded host-provided quote size causes guest kernel warning (and potential panic) during allocation.
> --
> 
> commit 918e9fdc48e5a03b41dab3a999be1a3f631327c1
> Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> virt: tdx-guest: Allocate Quote buffer dynamically
> 
> This commit modifies the TDX attestation driver to allocate the Quote
> buffer dynamically based on the size reported by the TDX module. It falls
> back to a default 128 KB buffer if the reported size is unavailable,
> supporting larger quotes needed for newer schemes.
> 
> > +
> > +static void *alloc_quote_buf(size_t *buflen)
> > +{
> > +	unsigned int count;
> > +	size_t len;
> >  	void *addr;
> >  
> > +	len = get_quote_buf_size();
> > +
> > +	/*
> > +	 * This fails if the requested size exceeds the buddy allocator's
> > +	 * maximum order (order-10, 4MB).
> > +	 */
> >  	addr = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);
> 
> [Severity: High]
> If the host provides an excessively large quote_sz, could this allocation
> trigger a kernel warning?
> 
> The comments indicate the buddy allocator will fail requests exceeding
> its maximum order. However, passing an unbounded, host-controlled size
> directly to alloc_pages_exact() without __GFP_NOWARN will trigger a
> WARN_ON_ONCE_GFP in the page allocator's slow path before failing.
> 
> If a host is malicious or misconfigured, could this be used to spam the
> guest's kernel log or cause a denial-of-service crash if the guest runs
> with panic_on_warn=1?
> 
> Would it be better to explicitly check the size against a reasonable upper
> bound or include the __GFP_NOWARN flag here?

Good point. I'll add __GFP_NOWARN here since the host is untrusted.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260612110853.3188196-1-peter.fang@intel.com?part=2
