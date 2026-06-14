Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004D02F8E80;
	Sun, 14 Jun 2026 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421041; cv=fail; b=a7n1ioTOjIvApLSZLHgizfD49jUESkUfJwxYEMwTz8qfKNgvzvI/QsNnjWi3rWDo+Ul2v9bFK1TV5sAL6jp2V0ck7aj0FQvzLBYoow6MbvwOkkDgbmMAcAVeNylfvvO+VOwgo1BNFuk+YjWuBC0HgVBmD0P2If0WEBjeJv+6NFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421041; c=relaxed/simple;
	bh=B4f5r+hQJe/jtCmP58U0h7e+jqERbnXUd5HiNQv4ITM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hargcKIZRZPI8OPvPdQc/enCMW+mv+BwwvzsXZTXWP14wWKenJM7EVvZyKXkrau0Xwe5txgWXiSP9kFes+vms79iaRwNN6NKDcyb1ltHe9SZAWLXmpeJcuJUQ/0jqbnVEYv/mM6IF69aZTwhdclZsPlLuDw0EK6VcJD9jaNPerw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCepJzzA; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCepJzzA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781421039; x=1812957039;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=B4f5r+hQJe/jtCmP58U0h7e+jqERbnXUd5HiNQv4ITM=;
  b=bCepJzzAzTHT0vFuh9o7RBnXZqP1MpcJ7giQ5CcQpul84ioY4D+Qf/1S
   /4+DXJ9A2f2P5zcWQLkYCAyLPD1izisK8pVyWMl9GcU5fabJ6RqxyUoj9
   7Dg+7LjIf9Ql/iijRzId6br3vNzyQLTznfwmqwBw8MDMQTqYwprmm5NwX
   888Q9XFjFuGxapyrfQzX3DfhVsdG1V6N78Zlh96fdKee0yzKnm6fuq0cJ
   eGXFzzVfRJW05oisec9+iRQbllXinnBVRxTvVej4BQtHkKx4zOOu0NWqh
   DgPCPU25xH02FE/6+b5r15g1WA9z/lpPPwKokfatjJWCdIG9snRqnilmJ
   A==;
X-CSE-ConnectionGUID: yBjB9KIdSbaTUdMWEAt9sw==
X-CSE-MsgGUID: 3xjm+GjDSJ6+l14GSzl9Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="82258295"
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="82258295"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 00:10:38 -0700
X-CSE-ConnectionGUID: GuwoViQQRsuDmetTwOEnQQ==
X-CSE-MsgGUID: MKM/K+cySDurAyvd29NhPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="246082140"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 00:10:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 00:10:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 00:10:37 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 00:10:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVhTJBdkzkrRyPBrEh48eytg5ViOwss55MZb4SEeR99sFwhIqu9ccCZbnw8xKu878yaxk5fpkbR8tjQ+6uPxwqRZggeVHUDdevk/0zS45qwBTfPsEbLYOAg7W9A39x7z6a0brQe8KFZSKhkOUeM/4zZpwQkpRw4yTQEX3gUeGmS+CDtncEtT50zB1di8b/fXu1x9c+Jx2oohoMP8myMzK6z6mv4Uu3xiJfamna/wMnttvD8ZvtNPALgyPmMJMchsl5ICqbzgQ/rbHgzr+ix6546z02ESz5PpH3RhxuzKWfDrsLQg8NXMPcyhCzeYRR0icaljAf3KsJz+xrap2z38cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0wDP6Vmr4T67B18EaYF9YVu7KDntvZHRL9/fVKxdz8=;
 b=r41ogULpPlr3krMeEiYs2+g7kfx4GAkcDC9SdHT8wn1dE114+5T/W7lcZz3yWIBTGLuKYzIX3MGafBMrRyHzJRtjFyo20m3ctwhsqabBGnc464YkTmuAxjy8bjQDB0aELEq1Br3hBIHeQxH8sfPbyjKv2vozMz7nAIovN6eBQ7xMy5JDDDtBqEsuwjsdxqcDE6nMgQNNB3Jrl/Sjn4r1q+cF9oSsv7FWjvehcfIRhYpM/kXpGEU2a222t0C9hi1hYo+WW67mWuVZS+vIIdz7iG1sEQ2wSnjHlb+O7q/jfmhrsWnRupOeW+7SZRB4TdkZWAwER9SNCM2AF3PW+1o3ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SJ5PPF0D72A1BA6.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 07:10:24 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 07:10:24 +0000
Date: Sun, 14 Jun 2026 00:10:23 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kas@kernel.org" <kas@kernel.org>, "djbw@kernel.org" <djbw@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [RFC PATCH 06/15] x86/virt/tdx: Initialize Quoting extension
 during bringup
Message-ID: <20260614071023.GC3200182@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-7-yilun.xu@linux.intel.com>
 <f9ebc92839c94430055fe2a48114054a39b0e56e.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9ebc92839c94430055fe2a48114054a39b0e56e.camel@intel.com>
X-ClientProxiedBy: BY1P220CA0041.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::13) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SJ5PPF0D72A1BA6:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2094b7-b22c-4e17-f695-08dec9e4015e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|4143699003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: CIRtfwPlpuSGtigiG+7V4VXAvQo+QfGqoj6JzU89MxZfgHyN15Fbjn1Yz9SlfI9pPtNWSUcf4ob4D6eUBRAj7CqbKqELOtIQyjZnTDzyE3f3c6gjWjEPEBtL/yY9J6D6Q7NHF2yQf7Wq3vC5W2nZaN7IcJ+YIqAqXAM2GRZE9ZopeRKQCJE4l711iHiaQeds3NcVSedFM7G2Tbq282i8rMly0cBhJ2qO9B95Nj8T5D1mjyOjNdKDy9uu4ktDtJDpZwodrYkighq8IwkDehyxWOKjN2tiMvVj5E+K2UsRO2otMRdpbyU9uhOJTs3bADHMvOFlRJgjXBCIjCxuKoz9Db3S6BS07QzJWJIzDWd7lkEolmzy31GmRDMxtz4M8XzrjpGBatsQRQxl4jG16tlICsZCuGXIh/8eiRo4AGbV7KnEaUHdb+fWcEAemt0FcnBgI4kcxW4kJ9WjpngmHh6BazbBmXi7h/uXkvkOS9bp8H9G40ar2JnWCzNOGuCgpiXXSfHhfkglnTaCWRnBLzT5ReHTGVMgk5NA364JWUPtgqGS4ExBngrUXNHLeFGvpSM4RQx7fjvtITcmoQyGiED9Txk0hHbw8aCZe1m/mLEE4s/s6yRxMdth3yAgOnbFykwOBFKP9Y6j9glKktn628G7Yrh/Z12kir41CsUcVkwGpQnZVG9BW5FgWlu4W4n3/xe+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(4143699003)(56012099006)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym5CeDEzdTZGY2JPNld3aDJkcHl4Yk1OTUkzc3hHWnFpTE5INys5TTBjeXlC?=
 =?utf-8?B?ZHNlOEh2b3g2NFRxQ2JCMWJ1N3lXMnBNNjlBZmRPQWhoQzlORDRJSlhKRWN3?=
 =?utf-8?B?YjNrc1BYOG1aTm9jc1BpcklCU3hISXc3aENhbmlyTnM5Z3ZMWlcydWVqWkV4?=
 =?utf-8?B?Q3FTaFI3ZG5YZkEyejhFY2lOdHBXR3lLelM5ZkczL0pTVTZHdi80OWFNaG43?=
 =?utf-8?B?bDArd21yVDNHQ1FmQTFtQmFKT09YekRLSzRuL2xETmN5cURBcTRiSzdwN0Nw?=
 =?utf-8?B?K2JMOFdra3BJdUJXMXZkU2FwQUcvV2I5dGlNL2RvNFhLOVFRQUdyc1o1TWJL?=
 =?utf-8?B?Z09RcmE2YTRUSHJudTNsR0tGUFNhTHN5VnlSY2dQeHhQSUhJUEwxVElhTFFz?=
 =?utf-8?B?Z1lwVGxZN3FlUWpESEFSZU1aakZHWmowQ3JPUWkvTk93YVZjMHo3V2VORUdU?=
 =?utf-8?B?cWVsaVpmYitKM2dIYmJLSkEvSExPRmt0cjNBQVRqTkpjM2VZK1NhQVpaS2hn?=
 =?utf-8?B?dzBxQjAwL1l3bjczaVFaNXFhV3VBRDBQK1Zkcjk1ZlhOU0xqOHI1VXVLUlNS?=
 =?utf-8?B?UUxaYnhZRjRSUnhTUVgvZlpRMWQxR0drWVFMajRibGZMTzNub3hEZW1ocVRn?=
 =?utf-8?B?OFFyNEI1UzUzL3ZXdFF5OGNmY0pTUWsreXNGTXJRbGllbUlucVBkQnZUY2pZ?=
 =?utf-8?B?Njg4MlJJMk5Qb1V0Q21CRnYzUjYvdXpXZ3FTTGZUTU9jYklhZEduYXliWWU0?=
 =?utf-8?B?aGQ1MXJRMFlROExKbUkySVJ5bEc3K1RTdUxXSUhVUXNCZTlVWVUvNTVDNmhi?=
 =?utf-8?B?MTNucTh3Nmx6MVkzYVpiUTEyQ3M2TExZSGw5VlpwRjhsb3BvYUxPRlpoWnZj?=
 =?utf-8?B?MlJ4d25tclY3Mk9TZTVMVEFxRlkwby9IZDZCZCs1aVYxeFYyVHpHcThrbzJU?=
 =?utf-8?B?TzduSUhtRm1jc3huVEwrMzh6SWFqMllzeTM2bVd5TFVWdllleDRUUGRtS1dG?=
 =?utf-8?B?Vi9KemcydkJ1MEJNeXA1czZmZi9mQjFPQjZITWJseG9USVpOZmRRYnNvWlIz?=
 =?utf-8?B?NDh2ZUVkOHNWMGlpOVoxMHk0QnkvdDVWVlhwU2kwUjFCOSsycDlrREY2Szlw?=
 =?utf-8?B?K3NVTFhxeUdFVWppZFVSekl3K3hhOERMenFnRkxNOFk4WkQ3TDlYQTc1Q0xB?=
 =?utf-8?B?N1l1L3I2ZmxQaVB2dVZkZFl2WkZ4S3IrYmFTL2pYR29SUVIzUXJiOEUzeENQ?=
 =?utf-8?B?dTdRWmFmRFV5VmFlNzZKeE8vVlZTL2kvdGRUcWtJMkZGRnhDSFZYM3hXUnNK?=
 =?utf-8?B?a2FYaUM5Mk1JL29IOCtoWHhZd3h5SUFoQWJUekJzM3RmOGhqRWN0QlN5K1ZL?=
 =?utf-8?B?N1hEZEM0eEp1WFJFeFh3V0RjWUw1c2VwRWtXZ293SjJQdTBGVCthT1B1b0wr?=
 =?utf-8?B?RjNaS2pRbnRWUVBGRWZUcHk2RGlJZzdxajQvK3h0TjMxMlROakFyS09vVkVE?=
 =?utf-8?B?TFU3d3hLczBnNUZqcG1ONmV5a0NBQVNYSUw3Y3N5eVQxQlp3MHo1SDFkZTBs?=
 =?utf-8?B?UURSMmgwbXZMcXBrd1Q5RkRUMVNFN1pBU1l4a0pJdVVsTDR3NlpGQkhaV1VS?=
 =?utf-8?B?OUNLejJOSTR3UGkwNXYvZitwWlEzbTJwV2NUbzVKa1ZTSzZwTlBXQytRQmxj?=
 =?utf-8?B?QTNQVmNWMkdRZjhJM0xOSms5LzRQRXY4bUlCTFRCcVlBMXpUTURMRVJBTU9B?=
 =?utf-8?B?NnlyazI5SWdNMWxGVjMyRXJMcHF6VTg5Qk8wZjFpTy9YTCtRRytpTGZXYUxn?=
 =?utf-8?B?TUZCTXhjK1RNVkdTc3hMbXdxRHFYWldpQjRmamlINFVmM0huVmROTjlBL1pq?=
 =?utf-8?B?ME4vLzF0cnZmWkl1Z0hGSm9uOXZ5dndhMExCTEEwdWZ3RHBlQ21xclJzVXZa?=
 =?utf-8?B?SC90SlhZMWgyckRqSVRjQzJ5TzV1RFh3RUdBY3luWDNnaHhHMkJEOTQrTDdk?=
 =?utf-8?B?c29sTTVHSkNXMWNGZGRFK09ENUs4bG10UUdreDBJSmRkY0xJaC9VbDlNdGtl?=
 =?utf-8?B?dUorY01NaHZwQm1idkYxZ0FWNjV3R1RLRlNRa3ZBNGV5TFF1OG9WVzVCMjJ6?=
 =?utf-8?B?SjB1SCt4YlhIS2x2RXZ2Q2NMZE5MdlBYd01HeUJrMjh1SnJGMGxUQm9KSzJT?=
 =?utf-8?B?QWRGcm1qdi95YVFMMTV0cUNSUkFqUytydmNnYkRWQTBTRmV2bjZjUTJCNjlC?=
 =?utf-8?B?b09YbWdqWGZpY3BSaktGVWVRcXZLdG51UmdxNEJycFJmdmVjVXZZL0xzTG1X?=
 =?utf-8?B?WUgwV2RKanJYUDNrb2xuWUYrVWZCanFoSEE0WmtmL01CbXZrSURmQT09?=
X-Exchange-RoutingPolicyChecked: JsqqzyNWfszByE5xdhT6bDDTYMH8tpy+C1RuAAq7aJfEN8rg73XfNfPaIE4W7s/sUGHD43YODtJARD9is5CLty1RiEQbl2Vg7dsiykx7qGZzUfWaTtqArvYAVJkgff7KtF7phb4zGuWIQMzdePXUVj4jNEiCHiatReYGxwrE4TCXOTgfADYcP0gHBiICbCQSRjDAuZoaIF1dViF5eV5fnuNVdCn1xmqZyRUd0682sMthFYwQWwheS6jEjon3qspPpEGvQtBPEAMUnCP2s16M9k3QKYY6J6kl88TUgvQTQs6qIpVa48vvgvq+xnKCFwJKN/0hdozg3NsKuL5hjfQHrQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2094b7-b22c-4e17-f695-08dec9e4015e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 07:10:24.8141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/cu8wV5nMN/dwG5CpzkaWhbMoQUUDcSC1KHFqebo8CpvqsFB/hQcoCg35nE10MV0Y+rpgvnEmVS9AnaGUfsMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0D72A1BA6
X-OriginatorOrg: intel.com

On Thu, May 28, 2026 at 02:35:49PM -0700, Edgecombe, Rick P wrote:
> On Fri, 2026-05-22 at 11:41 +0800, Xu Yilun wrote:
> > From: Peter Fang <peter.fang@intel.com>
> > 
> > Initialize the Quoting extension and fetch its metadata during TDX
> > bringup.
> > 
> > Because Quoting is an optional TDX feature, do not let its
> > initialization failures cause TDX bringup to fail.
> > 
> > This patch
> > 
> 
> Don't say "this patch" in tip logs. The patch is a temporary format, and some
> x86 maintainers hate the term in logs.

Thanks, will fix in the next revision.

> 
> >  does not include the opt-in portion of the initialization.
> > It mainly lays the groundwork for TDX Quoting support. Opt-in will be
> > added in a follow-up patch once the feature can be properly used by the
> > system.
> 
> This could be imperative mood.

Will fix this as well.

> 
> > 
> > Signed-off-by: Peter Fang <peter.fang@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> 
