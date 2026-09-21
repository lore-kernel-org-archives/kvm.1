Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827BD3515FD
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790031670; cv=fail; b=dkf7r0rJy6zab1BNgg1/aOHG+J52fuH3iFVcu4w4G1lkKvbY4qYXJi+ujl7dWUDJTBwVJ5ORUh8NgJ7aT23dF+gVESF5h0MNpSHbN/fgqGEE/8vLw6XzwkSeFSQGfOOcH+GZ+n5uhZW8ArrN+etkW3lx6abiDBQobZkX/UV2/fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790031670; c=relaxed/simple;
	bh=+6JmkhCiejhlxtZHgbcLXz9Cnvg2LIjWfUUptZFgfdc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PAO/c9vusjvAidYReKlYqrWUPo50yxUpNCZrfRDacfGxdtl9QLtuY6lPbNHG4gg/ZL7FtiOQD/dO606PNMVN18zV0276XljO5hwIUgATkTxcnjqC6l6i5aukuDpw05FhmVgC6SuSx8JyYeA4PwYvxj8g9H8ivGDI2GmkRcpXB/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1Zw/VGK; arc=fail smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1Zw/VGK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790031669; x=1821567669;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+6JmkhCiejhlxtZHgbcLXz9Cnvg2LIjWfUUptZFgfdc=;
  b=g1Zw/VGKQ3XE5HgdpnzBAqOfDanmALV7D2ZXkg5V4EC7WNJ1s1zF0Scj
   FSNvFDgqPy1NjsdDReaU2es8COpDGafUjmsheqZKpxT/mzbMWEdUIlSKw
   wRGFs6VDY1iuUi009M+/dNUTd7usftCI2IFECkgftykxbyRJ1KNccDAR9
   DF028wDMi+RyDa3wzimEaYSVqRB0m6w8Du4cn2cQEIVdmVQDuHLZ8Y3sx
   /WJUFkkFZtOSLsp3qQcypaEhctuDZBcOfP7alAR0KyujpOd6YeEDf8rc0
   j6o3D6b2M1u8IDyFVvOnOrCjDtS8zhQ5pO0NSYnsFFYZV+pYVxw9El7rQ
   w==;
X-CSE-ConnectionGUID: gMnGIeU9RlOc2tyii/DOfw==
X-CSE-MsgGUID: Qsr1pSnUTm2cgRPadXyB7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1091067"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="1091067"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 16:01:08 -0700
X-CSE-ConnectionGUID: 2u15fcDKRAi30INR9QPjKg==
X-CSE-MsgGUID: FbxKB1mGSM+QW3uAYKsZXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="300802930"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 16:01:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 16:01:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 16:01:07 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 16:01:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJ2Kst4mZZQpqscy6Hzrmz3szykYRTf80/c7HeOQQGpr3twh3IiDGJ8jSAdP5Exe8Xp7qQzTBilkcIKlq2Vk4twjnQeqLnku1RIEiNitDnvyqBH0tNaKT5ZTE7LjVEST1QTpxB/Q0DIaBdzOEOyh1ZJktUcPVjHRHDyw4yDX2FyAzpqiuf7+vIEwcXlaif+sBS8uYW+WBrGyixwc7m1cyBCSslB72w1/IMbcyW97jnV6qwWO0hDxpP55j26iMjr5fKNOn54izGqrGlSqCMwRtrycs3EXTFmODJSt+FjAzk3GBbELj0IpVvEVKsjb8Y3CHI0BYKU46JiokxipgibQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSNXOXnst/bRH8GS9gFnNYbHHnCm0nZ88dysEVouq44=;
 b=AEb6YDQ6D4x3P6mSZBrEQpnxxSl+Qyf+8NtcSSVm8cx0mMnOEOsTSc+zyu3DCl/b0D62KZJhCI4efIFJR2yp4lwu/ybibq3uv//C3d1+5SagHosGMvZyeFyJwMazOfXw2BjjmhsTko4xeLsiTvMYVcyl0hkUTx5MKP/oJ5lA3K/OtmdqQMkhw0deIvqMH41484wh4WI9WcCsqfMa2CbRyrMQSjAqQDFOCx0TX9Jtvzp3uHinaz47RivghPqwG9q1CoNaMo+frtVCanEOdls5d1c8+iVI7sspGFOXl4FC0PoT/5O8k+INlXt3hPeqDZ8FFro6C6tF89z2rSk+NkaQpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PR11MB057924.namprd11.prod.outlook.com (2603:10b6:8:508::17)
 by PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 23:01:03 +0000
Received: from DS4PR11MB057924.namprd11.prod.outlook.com
 ([fe80::fbf2:d243:7bca:5080]) by DS4PR11MB057924.namprd11.prod.outlook.com
 ([fe80::fbf2:d243:7bca:5080%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 23:01:03 +0000
Date: Mon, 21 Sep 2026 16:00:58 -0700
From: Peter Fang <peter.fang@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Rick P Edgecombe <rick.p.edgecombe@intel.com>, Yilun Xu
	<yilun.xu@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, Binbin Wu
	<binbin.wu@intel.com>, Dave Hansen <dave.hansen@intel.com>, Vishal Annapurve
	<vannapurve@google.com>, "kas@kernel.org" <kas@kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Subject: Re: TDG quote analysis
Message-ID: <arG3KvaVqWCDAyM9@intel.com>
References: <28f7a805c57da35d86b5c495cdf2b613a61d235e.camel@intel.com>
 <aqvtG90zWq6SkU8L@google.com>
 <3f97caf660cbe460b8bbaf3f2a72e4b6a3ea83d9.camel@intel.com>
 <aqxGN2Zc8sOl2RKx@google.com>
 <906d0cb6515b396f4e9d74f1d546c902ea3ce49a.camel@intel.com>
 <aqyAED5ZK48eEZtq@google.com>
 <56a61983c03806120e607dfd1e1b7c9046c1f54b.camel@intel.com>
 <aq048KmPN5WPQ4sQ@google.com>
 <7d40bcd97e01390a345ce1dbe26264e7b064a619.camel@intel.com>
 <aq2t5wJGLtsltMza@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aq2t5wJGLtsltMza@google.com>
X-ClientProxiedBy: SJ0PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::11) To DS4PR11MB057924.namprd11.prod.outlook.com
 (2603:10b6:8:508::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR11MB057924:EE_|PH7PR11MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3cbbca-b07a-4649-488c-08df18343632
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|3023799007|5023799004|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: sfNsDibSd9vqqJ+b6ugNsE3z0h3kpTce6owh3OzEyXwi9A6hmYGqDXzgqJpTBDPVxcqXK3rMVyU/ThGtT7HxM6gm//3RKiPQ0WKr6dnRk/FfreGOxZ0IkYOGSUh9/8vwUxjEuPxNvaK9uQAboCqB4Lz7yGW7x/k9Ip/ncHttMyh9wNKZLLhKvOPWicInHUNwidb/7TB+h6tDtmFCDMUxP23jjknft1mynEtl2E6jOyFN9wy4dv/jvMkb8fGqHrMi5UmVXsUP9XtLfaziaMrWXw9L99oAv5b/CsfZ5uQfhIal/3tl1ghFIe5/iYwZ/h/81Yfz/cTMqAl5c+kAQsWZRrUqaPCSiFFdS2lNGGAyWYYzLp0jpMTgNVMFDsN/ixvMp6TpfeJusWH86c3LuQRKU9cY3xQRRnZS2iUyJmYEMxTmoITwlKGTSMsbvRJUSGKBapV3sYbsXaiDXi++ZwhRlS+QbRWiBCmdqJ/DDgspB9FCdYaaacSA4H7BU7fBbnT/orBX6XXLXlw0q0HYw66vdUQSklLLOwwnrKOOGohybQ0VPPcDLjDZrzt0q8OWtT3e3xYTK04hNKMOwFPhrnmhZ4fz8N9w7gRqF+Ybsqts3IuCC4v9slm8O2yL7gakfkQV8OA3oJZCfZ1xmWM2g3lmwM7caQCh1hFf2fVahEIswvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR11MB057924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(3023799007)(5023799004)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmNOK2pGQjI1ZVdNVy9aV09uY2phdmc2ZmFNZWRmSkttSFFjbXM1YjFWTVZs?=
 =?utf-8?B?YkdGaGZiQXVta0NxdkNlaytuSUQyU0FuMVhUbmttQnFSSWdnZmRvZXZIells?=
 =?utf-8?B?UU56Q0xlQmpQZnU3akpTM0NXMVJyVUNJRVRndGp2U056bkRMS0RhTzNKTXM4?=
 =?utf-8?B?M2VtSm50N1VjenJ6bzdkRnJUMjJoQkU2em5qc1poeDhNQjQ0amI0YWROZlNu?=
 =?utf-8?B?ZW1hckNNYzlHRFdHZXdWL1BBS0Jsa0lmNE5SUHE0dmt0T2ZpMFVlUDdqMERR?=
 =?utf-8?B?bEoybjZzcXE1dTRncFBoNUk0QlViUjdjZDZ2TldhNVVHdDFLajJUYlVRUXpK?=
 =?utf-8?B?bGNqbGxIM2E5cEFxZDlDQklNTlFKaDJaNGo5UWVDd0F6emFob0x1MWhpeW5C?=
 =?utf-8?B?QUNzQ0xObU15SGw3VWkvYk96RHNaYnNnTSttcmJxVDhFNzZnWkZZNzhQRkZ1?=
 =?utf-8?B?OEdTVHBlZVovSTBzaHNueTdKS09nencvUVZqT09JTzdBY0FtTDdrRUpScTNu?=
 =?utf-8?B?aDBBbnVKbDd2cEdKME9rQ3ZHTGd5eTNWU2gyeVVqalFTc3N0N0ZMai91WVlt?=
 =?utf-8?B?RDQ5ZFZlWE5pTWg5blFRQ3FpRVcxUVRTbWJWakhEVXdmNVFsM3lhbVI4N3RG?=
 =?utf-8?B?VU5Ma1c0anYrdjQxdmM2c3J0T2FlYXZTL3hvRU9PbjFDUmlkUFA1Z0lrcmZo?=
 =?utf-8?B?TVliNzFxZEJmYnpDa1hrc056anR2bHl1Ylhua2VxRVRoRTZiSUFhdU5XTFFi?=
 =?utf-8?B?MDhodEFTcFZSSmdydDExMmZjYlEvWjBxQ05BTk91TXF5ZzREd0pOV3hBTTZj?=
 =?utf-8?B?Z1ZBdG5rdFdyank1QnR2TzFlTjNMTDkzdmdIMjFjS29vc1phOVY0MWV3RU1Q?=
 =?utf-8?B?RE1mNk5WMXUrcHB4SnlPWFZJWEVPVDNTdS92eDZKNzI5dWdsS2RDQWhkZENO?=
 =?utf-8?B?QmZ1aGFIY3lja1NPMGtVTXZuRXEvbXE3SStIMTB1bVA4REh0QWU0cmhHL2V0?=
 =?utf-8?B?NGVnaXRNRXR6NDN2MjZlc2kwQ09yQkNON21xRC9hZE42SUVmbEQ5REQ5YnI3?=
 =?utf-8?B?dnNBQWlzdC9zVkxrU2VqUiszMUVjZlJzWm9UYWhPdmFoL1JYY1g4NmY2MHFz?=
 =?utf-8?B?cTdkNUhzc2dRR1ZHekhVUFRIVjBVNjB5ck1RMW1vRzFPbWFlNVN1c2pYTjdN?=
 =?utf-8?B?MlcrK2EzZmlFWXBhVERZVERCMzVhLzhxTnovT2U2YmZSUytqeTJHM0FyeUxs?=
 =?utf-8?B?RE5rRDRnY0plME1Mci9kdDZ5VHFrdUJzSmxGWWJQS3JXUDJsa0UzTkhOeEJp?=
 =?utf-8?B?VFNwam5aVVJRdDJDSHlobmZmeEZsa1dXWWlXdXZqQUgyMTJNUkhGMkZmYjE0?=
 =?utf-8?B?bk83SWtqUkFNWUxnWmRHMkptSFkwS2RJWEF4MVJ3bkVMMDdvbXl4cDcwb1ZI?=
 =?utf-8?B?WVljN1lBTFMvNjV1SW1DTFJXejE2RHZFSi9EemM4NEdwNHRvN3ZKOFJwUjRF?=
 =?utf-8?B?TmFIMUk5RS9RcU54YnQ4aUFLdVY3NVN5am1tbS9zN1RPVFdxbFgzZG1iTjFE?=
 =?utf-8?B?WUEwNUplelVJd01DT04xUEFsTHNmZEM4RVVrNnhrNG0rUDdIUVB0RmdGY2Vw?=
 =?utf-8?B?dTBRK2RBeFpxQ3ppeEhPUEJxVkJXdmpJbk95NE85ajBadTMycHFtSnFZbTBn?=
 =?utf-8?B?VFBacTlMZ0ZkOEJ5NmR5NGgwWTZ4anUrNlkwcmJ1bmF1WWtTd0QrQVgzN2J3?=
 =?utf-8?B?U1p0eWFtREdMeG5QditqdUpnOWZzand3UjdhQnRBMWxnNll1MG50TlRJV0FQ?=
 =?utf-8?B?ZUNNVmVKUXBBZmVDVU42NmQwaVYyN2d6K0lYOU1BbEkxY3p1WkFwZGhxL0RC?=
 =?utf-8?B?Wm1VNVVDK1Ryd2YxcXdNNXNKc09ReE0yVW05WW1jaTZ1Y2dQSCtjNUtxUW9r?=
 =?utf-8?B?VlZheDByaTdJRGlZUlNFRHU2MCtuQTN4cjg0UzZkMU81TG9NbkE2M05CbU9B?=
 =?utf-8?B?MXNRYmhYd1htenlFSHFFS2MwQk1PQlVxUFl6MzdzMDl0bzZQQStaUHY1MFh6?=
 =?utf-8?B?Zm5OUzFEb2VhRlFVSXhEa0Q1b29pR3ZnalVYNTFNUnhYNENJV0kvV2tlejg0?=
 =?utf-8?B?cHJqbWtiMEVQK2VrY0xpU0NUWmhpK0hPMnNPT1FBRWlSRHE0WEhUOVNKZjcx?=
 =?utf-8?B?QTViVzUvLysxaUh2a2cwUityMEo1bGM5cm1aeml3WmpNazZZVzQrVDlaR2VO?=
 =?utf-8?B?NCt6VFpESmJnYmpzd2FyWmYxQjVvTUc4NXhFWFpxbGpQbGljc3VZRTFxaUhO?=
 =?utf-8?B?K2lLbXdNRUJ4YVNGeUlDQjcxTFJLOFAvS2ZPbFZnVU1ac0tVQW5tZz09?=
X-Exchange-RoutingPolicyChecked: XGEKJgij10BcQvF3ZVSCwALyAuY0uYbfjRi+TJaPeIE8SXvpHEJ64eWOaQFlOrLONjzmIk5AGtBr0q8OjIjOMA1pXLraVWg1hHza5cl0nGmttuZgLjOqRblvibx8ev9pW4FJa0K10ClxMXSIqDJBaG3wXgy67qtRF7ppcHxvudFiVYmhyD9K6ScKD9E6f2lBNB+0KKgK/y8+hjG/2Xj9V98CVbagMvL9FOp+FOC47xZ0nlOTDs5H0WA3XF1zwWNwV4j/w8WlilvPml1BhuLygbD8cTdfQMC+cdzCvdUrit4SeeVSM3R9o8hgiCNHy+96bPnsqhlfjj+5PndtHSXmug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3cbbca-b07a-4649-488c-08df18343632
X-MS-Exchange-CrossTenant-AuthSource: DS4PR11MB057924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 23:01:03.7920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kH6BkNNGZd9sRRIoHhulb/4jdNZDUDbvbUS+HBPVSrsfXpyde/QoU0VfrEvy6f8uosMX/LBxNFPwTI5hcfqWVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6451
X-OriginatorOrg: intel.com

On Fri, Sep 18, 2026 at 02:32:23PM -0700, Sean Christopherson wrote:
> On Fri, Sep 18, 2026, Rick P Edgecombe wrote:
> > On Fri, 2026-09-18 at 06:13 -0700, Sean Christopherson wrote:
> > >  But given that you say "This idea came up before actually", maybe chunking
> > > the quote operation isn't a big lift?
> > 
> > The idea that came up was to have a saved state are per-TD. But this only
> > eliminated concurrency issues in the SW based flow. In the future a HW based
> > flow would be S3M limited. Which is why I keep saying a redesigned solution
> > should be robust to concurrency limitations.
> 
> IMO, that's the complete wrong way to look at this.  HW-based is inherently
> serialized, it does NOT have concurrency, period.  SW-based is has no inherent
> concurrency restrictions beyond existing CPU contention.
> 
> Trying to find a perfect one-size-fits-all solution is impossible, because the
> problems with each are so very different.  The problem you want to solve for
> SW-based is how to support preemption.  The problem you want to solve for HW-based
                             ^ more discussion below

> is how to hide the fact that someone in the future might think following AMD's
> lead and putting a precious resource into a tiny microprosser on a slow bus is a
> fantastic idea.

As shocking as it sounds, there are actually cloud providers out there
that are wanting this, or at the very least wanting to see how it goes
in real deployment. I think memory side channel attacks are a real
concern for some of them. But yeah this is not great from a performance
perspective.

> 
> By creating these system-wide thread pools, TDX has effectively created a bizarre
> M:N scheduling problem, *and* introduced a completely avoidable noisy-neighbor
> problem.

Hmm... Then how about M:M? Then the problem can be reduced to 1:1. I
think it would take some TDX module investigative work to say for sure
what this would look like. But just throwing it out there as an idea?

> 
> Assuming my understanding is (finally) correct, and the SW-based flows do all the
> work on the CPU, then the only way making the SW-based flows asynchronous adds
> value is if the host is willing to set aside CPU cores for such chores.  And for
> the use cases where TDX makes sense, AFAIK no CSP *wants* to do that.  Not to
> mention the RFC doesn't even support that, because KVM doesn't resume the vCPU
> until the quote is ready.

There was also the fairness/starvation problem at play. In RFC if the
vCPU thread waited on the lock (say using down_timeout(), or even some
kind of fancier waitqueue) and gave it up to reenter TD to handle a
guest interrupt, it would have to retry the lock again later. And then
there would be preemption-retry livelock risks. Moving this lock into
the TDX module could still create the same problem, because basically
the guest would be re-calling the TDCALL after preemption instead. So I
think there would need to be some sort of additional smarts to handle
both preemption and fairness at the same time.

> 
> > But now I'm wondering what your specific interest is. It seems you have more
> > interest in non-KVM in-the-loop guest side latency than you did on host side.
> > Which is fine. But it makes me want to double check: You want an average and
> > worse case latency for the first DICE attestation "SW" flow?
> 
> I care about future me not getting pulled into a customer issue because a vCPU
> got waylaid by a system-wide mutex for multiple seconds.

I think quoting is typically a once-per-TD-boot type of thing. Or it is
not usually expected to happen very often in a TD. Can you share what
kind of performance expectations you have for this? E.g. is seeing a
high steal time during TD boot a non-starter?

Thanks,
Peter
