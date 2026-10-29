Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793254707;
	b=fkCU/F7Z23gbpUdOHChyGfUye9MTua5TTSMi+fm8Eas4RcygJjsxAMtBc8XH3d91bvRG
	 hrySuuCDkuy6hJC9xJUMknm16xXS6HoFIQG7jWak5bQEGBdwCO2xxBkVoEfGsnIUb6fX4
	 vAjvt4UzUlg0kuZgUNPfcQhmA7YSvQn3TUr8mgwLkcSLlpf7Cqll/gCGWnyZqXxjNBdSR
	 tsHauBZTG2Hjw0c8JfTXycDUS4/36GyzSZNc7fYjY5Dk5UG1i76cCaobrWDWmp70ykUld
	 p52kYt3s66u/zJhToMw4rwPmj2imXX9juim0lE4pVhUqlFdsGgGiBg98bSGQcyo1vUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254707;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:CC:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=Lb8ueSg1cPYlTA0gF9c9lzKeb+tpxTp92Qfya7K3hlM=;
	b=ywILvscWDwF1hN6atJPv1IXRbLbtRgJrNv/H+II2UApOvvf9B9OmsvLEvVuwbfPUroa6
	 vaMJhm9W5L7nMVGMGGzoVafVjSUAsVMB0263jJGf2AG9DwAtTz4+WUUDzAJuJ2cYIPESh
	 WSZmxXPSaTyunQriyGVi5vyLkgNh4oBglsWhRw5TTScyWgJ3lkdN3g8wu93sXuCxGDRom
	 AjA+7YdFn+QBF2bOmwWjkPK65No5MEkooPXUgNPFl9HR8L+QaN80AfNAYkJsW2e3VB8hY
	 xcDCTRJcIHplMb/nai1W80vt66/hj8c4MBT6itJrM/Lr2bd5zqASAo5otEmn0pb7GoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F0in9AlJ;
	arc=fail smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC3606A31C;
	Thu, 29 Oct 2026 06:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77AC3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F0in9AlJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793254706; x=1824790706;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nCxT9trzhZfEF0ysC4p0wqxBbd4L6r9K305e3NTQjpc=;
  b=F0in9AlJPA+WHTcjhu9iyMzTaqPuWko9IhK9Du61PiHR76yAcmwjod/H
   EGfuE5f0u+QuAdyQaXeVE2SAm6HtYK+IhmPKmrz9gFp+xsTrg+jB9/wmk
   9TTfHRIECkq7UmJRypUF0vfkUNAg1t2mNpGJMY5Kmi3yLjJgchXAZl1Vd
   j/cfv4BAwSAQ++HIsqEHEMQaN79O4tF8rfl017v7PndDMGqbqXqzaVKqr
   GPyMCibyREuy1Tk+uhaKZtnXaq2EeKsjPNSaxJqqtjz19+J7Y4A315oAC
   owq46k6iDeLm8add4O7+QfIQ+tO0WX8b9s1K8FGFGcRabnef7YBV1yDwx
   Q==;
X-CSE-ConnectionGUID: MvPs8YFZToeS4mmSSgD5Rw==
X-CSE-MsgGUID: /mxLQUQPSNK1/B/MazF7ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2015419"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2015419"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 23:18:25 -0700
X-CSE-ConnectionGUID: Svc3FlUTRZWrPl3jU9m0dw==
X-CSE-MsgGUID: 4D67vUiWRwK56gNOrUAcFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5575721"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 23:18:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 23:18:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 23:18:23 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 23:18:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u75ExJ3EFGY96rA9NjgVsmfLrNIvrQyLvXEIBmDdBxXFXXG9iMFrHBPO2Xm4LvynTGH7zIFwgM8ra9sKsoevi6GpbsFqjm1BJPjtMj11iH28QMV36Tf7ZBo/JgGqceZ0pcJmhf04bBuT2iFyBSOB6bDsPdpptMNQzO0YWE94Tw24YWvNTe2sCZLRJcjQ2Kpc4Ozq1Oopxdd37j/7U4Nh+UQgo2kKOok5z5jU61BKHDBmr2RoXKoL2DPRPbvUecmDP8vgolBNoIJ78ol3Lt6XqGfPSjjN/to3PS9D8lv6JbCur0YQrm7dqrxbVFTtBK5kv3boldHQRc5O9yjNYqks6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb8ueSg1cPYlTA0gF9c9lzKeb+tpxTp92Qfya7K3hlM=;
 b=XF1TkrNAZe9Cva1wvn0/xAGQMXTuQjcP3xawtE7TskJYUrRTT9h8/E8pJZjJ09EktSbsuTEBLm4YcbAJmst+VpJd32KDS1be2IYu+V7xP9IZYKQ+s0ltsTPpnMcOGi0L07HzVXXyVXNE7tJU7w7g+VzSNNto++VapCOUfulGwvnfxNpNaxkLuwWsJfkryQf6w6RGRWEG55OfjHHIcHOegQ0v0q2dg26laycZTrmELquHjFkaWR1htmWXXiX38wsFYcuBM1lExE7/Bmdyzd1qi9dQcQnZg69upsh/igoZKDB4bBCCaFwLSV/nOp0vRqzLHBVRmyUrfDpmIjXTjEM+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by SJ1PR11MB6154.namprd11.prod.outlook.com (2603:10b6:a03:45f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 29 Oct
 2026 06:18:20 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%5]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 06:18:20 +0000
Message-ID: <64ec4478-8c4a-4d98-9c71-da703234c18e@intel.com>
Date: Wed, 28 Oct 2026 23:18:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 10/28] KVM: VMX: Add support for saving and restoring
 FRED MSRs
Content-Language: en-US
To: Binbin Wu <binbin.wu@linux.intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Xin Li
	<xin@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>, David Matlack
	<dmatlack@google.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-11-sohil.mehta@intel.com>
 <9ef4e795-1222-49bb-a6a5-0823c57afce1@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <9ef4e795-1222-49bb-a6a5-0823c57afce1@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:334::15) To CY8PR11MB7846.namprd11.prod.outlook.com
 (2603:10b6:930:79::14)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|SJ1PR11MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 53cc4751-90ec-43dc-f7eb-08df35846dba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|23010399003|1800799024|376014|22082099003|18002099003|261026140227099003|261028144727099003|3023799007|261026121527099003|261022105027099003|11063799006|4143699003|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 13sJs8zhz8CNGn/QXlH+Ig72puEnrwkcT6oCsbB4oXqlzdZUVYvKB6X6dtzpUz+5d4NKXFMlT2kvoCyw4WrPO5VGgF53e31rJJ4htLXpuz+geDF17eoZaZFWtUAbs8UHdSAenng9qxsN1/Cbc6xyQf1NQ64vvKW6qAlyHk5WrFbpA8CBO1NqVtLBrb3OyTz7jjo0Rd583j0bWA1cfzk51qHTuriqmGfBnTUn/aD1hLbshUYSgE8Enfq6ZgLap7I1uzNTG8u+edcfHBwUndDFbNAkr0R+c9EjdrUVNnankTIyfoXP3+KsS4+6QwGvwzd9IeZyVmkyLZ/Sm6IRXOZNsgK91pWsuFRkVsksWxax+YqiAWnsFj/2oLRDHNyOBCc2D6k0AnjDt5+xWRL1PT49CYSYMH7zhDNBK2QRAmOf2+wHEAMk2/PLHLCIGEhtmivakB7iJ2Yw8N0jnbT4sYN4H0+1jLEgEJoJ7Rb/3nteODtfp+7PjxLE8YVAJD95jmp4oxARS47L7WaYobD42Ceoa1opdqhhm8sRndYTTP1deuFVs5pL5vyCz6tUgVcxR2ApN/l+Z2JVrPVL2ccqu6d69zwlCeVw6n2YXNOTVdduIK7WjiI7+HHD50OemOBKIKiYHIJhBWmjmyMU/SezEecw+tGnyE0Ud5D2uBL2+FzoFts=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(261026140227099003)(261028144727099003)(3023799007)(261026121527099003)(261022105027099003)(11063799006)(4143699003)(261009223027099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REJlcndXaTFWbTdIZm5GNm1qUERVZHZyZDZIUFRkL1pzWExvNTI0WlZlbkZX?=
 =?utf-8?B?cVlLUHNDNklnUUxkTGR1RUR0M1VVcFZ3REJDSGd5ZXIrUlNJR3hMdmRhTmYv?=
 =?utf-8?B?MU5pRWNFLy9Cellia3ZNUzFreG05dGxVRVdMZzdMMkJvUEJyL2ZBSGRMbW9W?=
 =?utf-8?B?YWR0N0tpNnVENExaZEx4ZUQ5azl6U3hvMysvOGJzYVRKQmN6cGtmRlFhNDdj?=
 =?utf-8?B?UjBUbXVNalU2UW0vdU9McmNQb0FSN0JldXFVQ3MxRW95OVBCam1KT0ttVnhn?=
 =?utf-8?B?MUhSVWNRbm1Ud3d4cHJ6U3ZtOVkvN2twYzBYUGw5OE5LT3RDT0NvdHZWK1Iw?=
 =?utf-8?B?UG4wS2JnN3M0RGRrUTIrNkdnSDV0Mk9CV2VCQTFQQmt3czhWZnU3MGlHNkky?=
 =?utf-8?B?OGIvNTNUVERTVlJNaGhzekVXWDdzdUhoYVBObHVhZHROZzI1MWhIRUd1cVJa?=
 =?utf-8?B?YURZVUc0R1E4NzhWNGF4QWZ6Q2podXpGTndxcC8vM1hkbzRmdkhpUWZ3UGdr?=
 =?utf-8?B?VTJwRFB0UVo1UDkvajhVUTdkUk02S2lZTDFLY3UxbVA2U1c5S0NhcWFhRzUx?=
 =?utf-8?B?Q2hUbjBQZXgraHJKV3ZrdmYwMVBzQzAzeFQ2aHl1RWRoNkNNNzQzWmtma2ho?=
 =?utf-8?B?WTNKVkJtOUZnY0doM0Q2UWFIRE1kTnpDei9lMFp5d20ya0U2TnEvaVlmTks1?=
 =?utf-8?B?L1FEQkxWRkczTG14WWd4aktubE9SdUFNcjd3cWZjeTI2bUdzRWpXcUNNUjF5?=
 =?utf-8?B?Rm5rd2NvTXFNQUNnK0krM3RiQ0loZytpb3ZXcVgvelRXdit5eFBRbjRtejFy?=
 =?utf-8?B?azh2dytlbXV2alFibU9xQythblRyZjhieGdCN1ZLWWxoMWZCeEhFUk9NTmNl?=
 =?utf-8?B?QVEvMTl5cWlSd1FVK2Q5SVVuRStjbWNUUzdic2g1RTJYUXI0L3VabjhwLzVS?=
 =?utf-8?B?QWtrSHdFRVphQitVZ1JOM25ZQjJmWUdtemsrOE5UbGVsV0pLUm5zYkRZaWRN?=
 =?utf-8?B?TUxYMjNmZlNhdlR6WVU2MFNiK1dVVXFmbU1QOXdxLy80eUZ2ZWFYUDZRM3Rz?=
 =?utf-8?B?bUFxYWJWNHVHR0RWWW9qNjdSYVk0cGxtR0hPWmZWWGl3ZFE1dHFKTkJYMWZj?=
 =?utf-8?B?YmljUmE3UjJuNWoyL0ZhYXl2TFJDY29ER2s5S1NGRktuVU15OEFGQ3FTbEY0?=
 =?utf-8?B?QTQreUVEbTR2OElnTzZvL1VybGpzNlRyNW5HcEkzOFBXV1BVdkVZZ2VvblU2?=
 =?utf-8?B?QllLdXNZTittNU1ZdWdUVFgxcC8welREUG1kbml0NFpwUU15Zk0zZ2U4eGFW?=
 =?utf-8?B?TnpkblFjZUt3VXUrWDdMSldJSkkwU0tLcjQwNE1aTHk5WDA2Yk5wcFNGbDRG?=
 =?utf-8?B?RjRkNS9lTE5JWnNvMEpPS3hTQTM2ZUs0dkY0M1dCTitHYnRVajlpQ3dPcE5j?=
 =?utf-8?B?Zy9MZlNJVnZIRFFlSGMwVnpEMm9KbUlUeEVJMGZVOGhzRk9hWG82c05sTWcx?=
 =?utf-8?B?cW5ORFNDSkJYcnZacWc3WGtIUG5STzM0aVJwem1UVG0raTNjRkxtRjVROUhY?=
 =?utf-8?B?UmF6VmV6cFhOdHNQV2lxblJnR2lJbEJ0V0JPTlh6SnRPM250TFB5ZGJCNEYv?=
 =?utf-8?B?OGRBY1JRTGRIc2l6NTRHS0huSGpRTXE5TnozSGkrdzhqbGNkbTJtMmVKM0M1?=
 =?utf-8?B?YWExNEl1SUdPbDJBWEU0Q2JlaEk4YWk1ZVUvSXFSTEsybXZ0ZGlobFVFV0ZR?=
 =?utf-8?B?aEJDTy9DVVB5MmtUOGpYT2VDOWFScWoxRC9qVHhSaEJZUHIyVU1GRWdQYTVl?=
 =?utf-8?B?SENtbGlVeU9LelNUc2Y3OVhSUU8zYUhacjNad2xTRmlZb2pUL2lFYzF0WUxk?=
 =?utf-8?B?VTlqTUNKOGpXWGtvMjA1ZTdrdmU2VUlpbXNiNVhabFhpQ0NkRGFwQis1U21N?=
 =?utf-8?B?TzJxNjVwTWtFeU1BSWtBd3VnbmdkVGQxZS9rZ2xXdXArdU9mWmhBVVFRaFZq?=
 =?utf-8?B?ZTNpaytwTUxnNHlYU2ZzUVlSQlM5WS9pSDVMMDNDbmIvdlMxWmN4QjViWGhW?=
 =?utf-8?B?TVc0SWdyMmNycWZGa20yRHczdWFWQ25PUklZdGt3T05ZbWJ1UmV6RXdMSTIv?=
 =?utf-8?B?WDYrWEtSN21HdnNlNlNwZ0JBQlBQSSs3Y0JLZzJCNmpzNG5Ec0hoMGtuTEZP?=
 =?utf-8?B?R2N5YnV4RndxQmxiZkNOYlFJOTl4cFRoYWdNcU5NSU9GSExRKzdXaEc0SE40?=
 =?utf-8?B?d2NSYXA3cnRUUUNqNU16blFKclpOdlJsaVFRZ1lDRU1QSFR5Z3E3MzB1dmdT?=
 =?utf-8?B?RWowSEc0VWRwcE9nYytIQUtRaFAzL0tsTlIxTjVza3VEWTdYR0crQT09?=
X-Exchange-RoutingPolicyChecked: GQZVb9sOC1++vAOBIW4mjwwihGsv36EutotFnn/+XFNCjg37sE7RP/FpRa+Z3alI5xxIOPwloTrztHWSfLeDMuj++h8PHkfU/0jLyq7a2id+gcJrgfHd2Vk2OR5OIZSW4tv0xc7rxNQkGjuQn34MQFWAa/cXGp0bXMTV0Ujed4lrMlQVvLgD9HXCa4ycXTmkjaDjzPjb2mS/bmejQ4TKRr6wKaltt09v8mjJhHI26KLG2M5n169bnr68aVLzFZEXQooNi8h9P/CK5u/X3hJ4XwtjfVxwedF3bKifCH3xYYc5DZKzm8XDnnJGRTG9zGuY3n9nrO9G2EGUhAK7gn1G8g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cc4751-90ec-43dc-f7eb-08df35846dba
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 06:18:20.3982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDiWFGnKo7GE0I2bTazhSHkAzDsjLaqS+8HRlp0rJwr3fwz2LVlQ/6phlXWCGw7x5pFFAkyQJjjHF9ilmqgUjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6154
X-OriginatorOrg: intel.com


>> Specially, intercept accesses to the FRED SSP0 MSR (IA32_PL0_SSP), which
>> remains accessible when FRED is enumerated even if CET is not. 
> 
> Nit:
> It sounds like the patch adds interception. But the patch emulates the access
> of the MSR. 
> 

Yes, will change the wording to reflect that only the emulation of the
access is being added.

>> This
>> ensures the guest value is fully virtual and does not alter the hardware
>> FRED SSP0 MSR.
>>

...

>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 8d3999772ac2..0fd5d4edeebb 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -1032,6 +1032,11 @@ struct kvm_vcpu_arch {
>>  #if IS_ENABLED(CONFIG_HYPERV)
>>  	hpa_t hv_root_tdp;
>>  #endif
>> +	/*
>> +	 * Stores the FRED SSP0 MSR when CET is not supported, prompting KVM
> Nit:
> CET could be more specific, i.e. SHSTK. I am not sure if there is a situation
> that one is supported, but the other is not.
> 

Agreed SHSTK is more precise that CET. I think KVM can clear SHSTK but
keep IBT in some situations.

> "prompting KVM to intercept its accesses" is confusing to me.

I believe it meant to say that fred_ssp0_fallback stores the SSP0 MSR
value and the intercepted accesses are emulated using this field. I'll
reword it to be less ambiguous.

>> +	 * to intercept its accesses.
>> +	 */
>> +	u64 fred_ssp0_fallback;
>>  };
> 
> [...]

