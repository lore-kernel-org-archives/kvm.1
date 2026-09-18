Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD845226B8
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763117; cv=fail; b=M9T3PAynl3NpC2v6+nHzPKPY1TRLtKWWdYh2oMKbKwSjEi9il3CGVTr+8qgvZumpaNhSw9SaBkVqjuiLMK8mYV45VSyOQ5+Uf6FIxxCPZc2olKZQ7G92PNHuMTfZqLCaQdKPTxUpAYngbepdkQSzBw7A8x95DqreU2Jpp8J4Lds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763117; c=relaxed/simple;
	bh=T95o/cb7iDF/SByX7ElGwHT4IyIwS+AhvjA26YhoGHU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DYIxOkbSnLWDdO9Ixo7fE5TTD4YeWIjiZoM+dydvNqjmX9omwksbyp5lSG7lXRwT1Yx2zm/APwn0BYv1Dw7vAK3Qjs5OtGyrQmGz8ksQE5qmttzVNu6pjSGJg4C3az73QppVgKNYgkTDl7DC5OlBFHWD3zD3v9scbe6dG2tiJNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HctfmqR7; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HctfmqR7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789763116; x=1821299116;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=T95o/cb7iDF/SByX7ElGwHT4IyIwS+AhvjA26YhoGHU=;
  b=HctfmqR7lRKHYz02gTihfftFkTdswPTFnXhmMzssEe4ADpyPN9VJ2F9P
   cG1v3Vjn8jxj9IxHr5ExwdCtgUvHPEP1ZkGY9g7FbNVLy0jZ+7TK1QvyV
   UczweABIEfGWkCBQkzgZLV7nGa47D0qyNQlmu/0dm48WTkLvKLuXvuDpf
   GFBFvdp5xyKG0w6y09Rey49YgzcYJAvxFLW6fEasRjl1NhRD25i/hgM+n
   TcVl9CBYXnruPyCULfo3xrUHk5fHI5EWamvWx+tmaOfNYfqynYo48QbHK
   CqSRHrsKAZITDaFWztmcdkpAovXfES15R2Pg3aI3lLcf1QYkKBSvwnLZV
   A==;
X-CSE-ConnectionGUID: n1vbr+PzQjikECDUUGOb4w==
X-CSE-MsgGUID: 3i7bHR4GT7e9mkWKx2Xq8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="90309956"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="90309956"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 13:25:15 -0700
X-CSE-ConnectionGUID: Tbeik0OrTSW550UwI+bNHw==
X-CSE-MsgGUID: MX6p7I/WRT6Kx5I04L1+ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="270275254"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 13:25:13 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 13:25:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 13:25:13 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 13:25:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnyrAmQxGa8XO9csC8Ae6JATVqUJUAGRABKwpPswxt2eJCv1ZOtHQPmPRWMje2OIvUzLb55Dkj+MXUoNS6W3u7I5QnNfyAFGb3dKj0Cw20MbS1IMqtJCuGqmuQJ36Mlozyj+2rZONaIss4k0oU8SFlAMl2Q0z66QFGvEbj4nBe7ga1jGPCzLh1K4+ckj/P4bYf1b4Ie/MuQ5wdC9QSBAOfnql+1THqnMpG/VcDEDoc1Zk9QX9Q1g9Qi4mOXzU0LJHG9UkK21XmdisLi8zAkQgqzqfBZG6LUmRaVCljV7vaUN7Ng7pUZTz9DgATfRr+D3hV7B0tjIkgd/cKw4ZPuPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7P78GqVNsyWbadSRLKeZWTLvPbL4g7XMRTwKKninmw=;
 b=XQTN7dp8nUsQVMSvrnOMNaUxIMigI22/+KEH+MRc1s8qaJ+LhIiJfCLfAAqKkV40Jfe7eO9TninmQhqBTO1RNHNervKjSJ6eYCw1S4WYSo34nGKcOhResvtiiQFkWgOHqkZGNTh1b2yNhi1vwgSEzRNOhLcsWXLLGpvWhiePVCAr2QMNIPLNkLxYZEUryUqQf87h96WiFdglnBqW/BvyaWNt5FxjJGXzrLl99jzvqKJMnFOcPICRizmSFSDI688Nts5nczHzV5Nifobz4nkHvkZe4eDlFs/UO5KW15wJQmKRx65WisUVdXxKNnySyGAioYtnZ8EL7eM5Pr6aDQLKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by DS4PR11MB331194.namprd11.prod.outlook.com
 (2603:10b6:8:53e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 20:25:11 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 20:25:10 +0000
Date: Fri, 18 Sep 2026 13:25:09 -0700
From: Peter Fang <peter.fang@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
CC: <dave.hansen@linux.intel.com>, <rick.p.edgecombe@intel.com>,
	<xiaoyao.li@intel.com>, <linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Subject: Re: [PATCH v2] x86/tdx: Harden exports
Message-ID: <aq2eJTrHj_xsSCHx@intel.com>
References: <20260917110714.1587301-1-nik.borisov@suse.com>
 <aq0GHXV67ROAhILB@intel.com>
 <477fe308-0028-4ce6-a57e-fefa1a611126@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <477fe308-0028-4ce6-a57e-fefa1a611126@suse.com>
X-ClientProxiedBy: SJ0PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:a03:338::33) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|DS4PR11MB331194:EE_
X-MS-Office365-Filtering-Correlation-Id: 582c7e5d-5f15-49d3-722e-08df15c2f038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QlB1oGtmBrajVTVgoeywkuF7TqTXGb14aAIoiybtoXAqFqnVsbuLWIIuxsPMWKgtVdjXxEkeSbhRJHdjR656TbMTEfKyT5/zt9e+H8wLQVOIKu1KQjm17qx/JlQ+TMpy69AXBsS0J2qWvRivXKhiXUxfvsyCNa5T/L0nBU4C/LGlO680J8ZTK+CebomJrA20x2lNXmPzG2QGCm7wHhBqdijGqHWtVD1MZBB5iniUsX1Xg1oK6rZKkv8iS69gXP7mxPMo0VerwVmsQUV85g/wMw4CgZ8aCXKJwctjcZPAOeALO2raCfpRD0lXGVuhLD4D1WdXuupO4MqJBuiPY6UAn3gRXbhW0t4/0jEYfWsw8V6Fgxk0QL6uW4aZ8zn61fEX56/BNXWcrGsBUoesD9v60eD3HdHggza4y0ETx5VERlJUkxpq3r4oLC5nRJDYIMt7q1Q3fJ/A8dCkkIEMmrAA296u34YeL8/7UlzsDUGH5I53qBFlbAfaqaYWHJ0agN6JmvVZT1NA18az+ARNP3EeYVhVGTzux4sNH8e/Kc+k4prXXDLLUT3hL/tQnaEtWf+DSCkkIHk0YXnUbDVuslV7UsH3Mcgk2UkpnZLOl9waI85SBF0itr2ftrNC/fz0u1aqntH7EO2tgr59W/dBj9OiaSf1W727MMIhOcbCEaMBBsE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFp0VHhhV1JFZi8zU2VGR0pvM0VVeTZCdUY1LzdjYlJTNnh5SG5vZzJuc0hN?=
 =?utf-8?B?RncveCtiT1lLd0ZyTVZlL3FUbkV1Q2JjSWtkL0pudEl0bFR2UGFZRy9Ia2Vw?=
 =?utf-8?B?L1V1S202cHJMV21INS9QeGJyY09WZWhTQkNHaXNSdm9DNVVydTJ4V0tQbkwy?=
 =?utf-8?B?b3B1VVdFVlJEbUN3VFVsQ2JONGFwbWd3aUtPeTFRSWptN1ZtWm1Eb0ZWY1Fw?=
 =?utf-8?B?aC9KZ1g5SkRpN1IrN2hCemhXMDJ2VW5Ea0hrTXlNQXlndmVoVjBscUphRisx?=
 =?utf-8?B?ZXhPUnZFbzBCNHJLaUduWC9WVDAzM1RyOFQyc3R2RVRlcG4wQlBadmhBOG5G?=
 =?utf-8?B?a2JxajFaNnF5NjdSMDQ1MUdyOEJ1d2xsYzhENHJrZGRxMXFNMm4rUUdCVDU3?=
 =?utf-8?B?VFhRVjIrR0JraCtqd1JiQjVNcUFyVmNBZXlEazZtckoxWWNKWHY3Mk4zanpW?=
 =?utf-8?B?L0NkMllKSXl0NE5yTFBYN2t0MlcxWXdDaHhIaXM1N0lwZGQrU2ZCbnRXT3ds?=
 =?utf-8?B?RzRCWWtpdkN6akJaVXpXWFZSTEhPcjJNcHI4eHBWT2wwNEg3U1dObElzbi9I?=
 =?utf-8?B?ZWpSZWxESWFGVXVjdmx4dllVa0xKU3hGY2w1d2YzcjJkZVJsRDgzdlBzY1dH?=
 =?utf-8?B?NCt3clJrZWFWeVEwNy9seGNVWjZZZWxLQzVOOWZiTWZJTm9HMG9GamRINWJN?=
 =?utf-8?B?dGJqMVBxMU1XV2tvdUk2SnRqQktRRS84SjFXNUFaVWlhUTBVUkRSbTNDZXky?=
 =?utf-8?B?emtoaDYxTDRyVldLVVY3aGIwdWpQTXB2M0FUMmxoL09qV0Roa09qdHlHUmNC?=
 =?utf-8?B?bUNMakN3bm9GN25RNTc5bHRkMDg0dmdHUGE3MTFyamJYUmdmYTRnc3pxRlda?=
 =?utf-8?B?WmtJbThWZmNJQzFCYUwwUVFDQm83ZTRnVS8wRUN3ckpUNENlRm1ZYW5PQ3po?=
 =?utf-8?B?Yzl3TStuaHRhR3hzeWhPRzFjY2ViSHIvaTN2WGNNM0gwanlRK1RNdnpzS2Jl?=
 =?utf-8?B?TEFicHFoTVo5WG5jTW91c283UGs0TjlMOExzci9FRlhDSWphSFJSNzVjZXJj?=
 =?utf-8?B?NSs0NEdHRXV5L3UxQlV6c3M4WXJUVzBNdDhpLys3MGxPME9KZllZRjgwMElV?=
 =?utf-8?B?OS9wWDdOMU5lSS9wcFdOU1FxSWRGMU0xYWJqN1A4K3hjL0xyWWd3c3EyQmtJ?=
 =?utf-8?B?YTEyS3pWeGMxYU8xVFZHam8yOTZlNE1jNm5xVWdndk5VK1J2SmdWUWY1RUt3?=
 =?utf-8?B?ZStFeFJBUjdRNjVzMU01LzZSVFlIaWdTSTl5OXYza0hHQlBCN1hqcWRNSTJM?=
 =?utf-8?B?alVscFFUTGVYMDY1MStwREI2UEl2c2w3b3I1ZzQ2c2lTLzFYek5lekVHdGhV?=
 =?utf-8?B?MGI0bUZrdDhCRFlGSWhYQzJrTzFnNW9wT3IvMjhrcTRMb0RsM3RQTWxSSTh6?=
 =?utf-8?B?eU5Nb1E3bkRBNTByZnQweTRpOE9Zd3dsZnZ6ZGZJeFY0ekFZZDI0cDJ5aFdu?=
 =?utf-8?B?bVNkRUlwUDh4T2RwU1B5REgzZmJ1dnhBVGpBa1kxOWZCdUVWaU5hbHg2Zk1U?=
 =?utf-8?B?UWtBSzEzTDhsTVFTQkhTTjlQR2x3b1hrbTNBMzRyY0hSY04raE9yTWtDMm8v?=
 =?utf-8?B?UmxSaUJMQUV5OEhIc05zdjJGSVF2ZGRoYXlqSVlhUkZPMnU0Z1FvZTJmVysx?=
 =?utf-8?B?Y2pURXZkdEdjeG5GRU5oWWc2MnYvdnB3MFpuMS8zclRoc1BQM2FVakdMZ0Rs?=
 =?utf-8?B?Smp2YzQzZ2JrNFJ4Rm5GQ0NlWnBCT2RDdy9TS3NPWlFOS0hheHJoRGJCWUFh?=
 =?utf-8?B?c3h6aVpUMWcyTWtpMU1nMXh1TXpIaTYyOFZmUXlleHVsZUJNT2VXMGV1RTVB?=
 =?utf-8?B?Z0JrMkZSbG1LcjljM0NKZ1RGTnI3Y3BXbEVQZElGby9yM2xla1RLNzdTQkx4?=
 =?utf-8?B?WlpMZGwyOWdYWmRzSDEybzQrRHFZditFaDY0MWJWTnBXOS9hY3FHRHdwMGZs?=
 =?utf-8?B?cnluKzg1QUk2emlvbmJ3T2Excms0UnhubTJLVktnTUtsZXVPckZYNlorVTZD?=
 =?utf-8?B?Z1RBRDF2K3ZHWUhrWDZVVW1YL2c2SUZyZkRMVEhwNXpEK3FwWERUSEgzZnMz?=
 =?utf-8?B?bUdLUlBTYVFIcVg2UWVycXFJMUh3SGF6MndIOGFZVUlXaWhwZDRlemFXMWk0?=
 =?utf-8?B?OGd5ckR2MmJDeW14bkFaMlN2VjZhM1NxYWRuMXNrVCthTzI0NWtlOUJMUnFq?=
 =?utf-8?B?WWV3Z0p5SDhDaEJMVjlwemhlSmxOalU0aHJTNk5nK3FVbXZKQkkrNW10ZnBk?=
 =?utf-8?B?NU1OK09FM1JLa2pUQ0VLNWliTFVSbjhlekUrbm1GNXhSam14dFAzdz09?=
X-Exchange-RoutingPolicyChecked: BmcXZYR7/gpAOT1jBjW0T1v8myfDykxRqNCEG7di1h4xPbOBrYwB0jU7k2lzGp38uSsulvu51QCcnIhhETklzZU/61w2EpqFibTa6MVdBWDFK0DMiyFaKf8nq7HbNsSkovEeuxYh/8C24XkaMiLiRQrEMsWMqrCNJkxD4x/nDVjx1ZLA2PQs8K13sv3u7khnMr43SYJsnSqMxqj1K/iGLBf+jSF6uzng0BxlQ5RhmwUzqT72Ns7P9qc4NmvPujMxq3JxiBWCiOnmfteNWRZo5iuTqztGHJSZ5DoC9ofo/Yt9sl9J8flyi2McA6cIm2LTy5+x4SroFVmXJd2ZmSH2pQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 582c7e5d-5f15-49d3-722e-08df15c2f038
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 20:25:10.8897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LN2E/XECE6WAApwxm4lwwqLVGctt9SwyneuYfhLBCfF6m0mkkDlnm6SCinuZsXJwe82IMLG2rWYhdlqu120Wyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB331194
X-OriginatorOrg: intel.com

On Fri, Sep 18, 2026 at 01:03:46PM +0300, Nikolay Borisov wrote:
> 
> 
> On 18.09.26 г. 12:36 ч., Peter Fang wrote:
> > On Thu, Sep 17, 2026 at 02:07:14PM +0300, Nikolay Borisov wrote:
> > > tdx_* function aren't supposed to be used by the kernel at large, rather
> > > they are mostly used by KVM and a very small number of them are exposed
> > > via the tdx-guest/tdx-host drivers. Reflect this fact in their
> > 
> > "exposed via" sounds a bit off? Perhaps "exposed to"?
> 
> What I meant was that the functionality of those functions is exposed via
> the tdx-guest/tdx-host drivers. I.e those drivers present interfaces to
> userspace to enable them to use the functionality of said functions. I.e
> those functions are only used by those drivers.

Ah I see. Maybe a tiny bit of polishing would be enough. Thanks.

> 
> 
> > 
> > And this patch only touches functions exported to tdx-guest... In fact
> > tdx-host only uses functions from arch/x86/virt/vmx/tdx/ (guest code vs
> > host code). Maybe the log could be a bit more precise.
> 
> Fair point.
> 
> > 
