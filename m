Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795230802;
	b=hWyYAWZILT26jS22HHAB/twGXY0LAgVKsbDNqZRH4XLjFQuoZv6M2bkOmQ2Wtk6Z93SK
	 G3jfuA8j95SnNS/no7lpSo0BbIWqN1ZlwhKW8IppH9klt/f/i4uGaZrZTbW/O2y5/q+2C
	 d5p9YFR2S6RoBHjPakWw0pzQ3cD61+hltCt+/AhSz3lrWrndMGyP7nNoF/TUhI2jHasJL
	 mFEezfiBLRGABnj/XxNe7wmxtD8LgK38LfQa0iyYwfJ2rvpSqc5Hr59m68DRqev5alEsz
	 Ht/L171sgbPsPV/sMK12T8q9RsxAVUfgXEMSeefJ6NeAqPePTppc3u+ukM1O7VJj0kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795230802;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:Content-Language:To:CC:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=42JXHM8aORkw/odVpWrAFVW5YhkViB2c7F9pK2astyU=;
	b=OVrIUBoDvzSR/pr6ZYd5gaEZrHe08F1pXNaS+SjQ8jyJIMWEFVqW67yJZPozz15cYoQS
	 z9CtUOK+d5yPmys6ENxuw7KPWE08lCwKPBVNML76eaezz9wNV0MXg4eiwaA9eOCyCsYRM
	 6GmdHT/1xD719RBoFMDGOQFW4ww2hiTD7i2xPSI3ZWc+lTByvxjkkNDvsCyz3AlRW4Z0j
	 CbhpLUdH/hYSvNmpgsjWqhiI3cWbq6l2awqemdr2oz4+sfqpHFSHOxJvC+8YYCpuW4IHz
	 ++CgF05yguV1lGNBrkRU7govIk99IF8JjdsvBPFoUXO3r4S6bneMIVfL/D87aQAmVNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gPdQYieM;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ZZhq0yie;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07210606A68B;
	Sat, 21 Nov 2026 03:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07210606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gPdQYieM;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ZZhq0yie
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795230801; x=1826766801;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QSaj+8XhtnEBhfY/bSUZT5KwkBSeqShXku4AA5Gty1o=;
  b=gPdQYieMx/R3DnwJJoORZMhnILcMZVnIxiK74RkiNE+qVQiEjqkKetzG
   8ebUpFb0fg1UYaEpRtViO2825MRuk6Ky1tcYwF98m+1CbzILiEGycSSjZ
   Td4h5JWFX1JHQ5swK89XiOjZs6teA2OKHMPY7HwPo2vyaCYNOZQu5SZ/K
   gPE67scZOi5HCGzPXYaIbLc6MVpmLIaMXHRcz3n6INIkGLVq6QjO5wkRS
   Ux9MSURbe9QmrPI3M4WQp39oV/76CwAhiOFfQkMYBgfZUdTzABXx6vo2x
   4/Ohor+r9ZOWfKOrJjPwYqTrZKy07S3+cPuaU71oj5ukz+ougbjMztLMi
   w==;
X-CSE-ConnectionGUID: Q+MnA3dsQKKQr1hJGCm11A==
X-CSE-MsgGUID: PntzEBMuR+m6zPzunwKocQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4217073"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="4217073"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 19:13:20 -0800
X-CSE-ConnectionGUID: BAGZZARfRTKjpMRwxYjiOw==
X-CSE-MsgGUID: Van+9MGaQVSRRYB4i7rLmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="11132211"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 19:13:19 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 19:13:19 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 19:13:19 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.31) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 19:13:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myCicLgJg220sEnYAxu9k6bHVl1BbkyRIADf04SwG7je15TECEGy8hVDbOYW8gjwAsWqP3ospogNbtD9EzMSCiQseFs5l9O9eX+cOoCLTYH/uCrU9G/hrbZTl0Y25Cs0ALD+xU9RzT584Sm+sgMh5PMdyD6+a9RYOEAmmkzJ22b+YvZZ+gYkAkt51K6gHhu9vycd0EJZvVPc+gXJLH3/8/H5EUxPYbdb3qhjCAnsqZlMQbXIZgZWoemHi3JQ+YQ2/HOgTZVCVAAYViQlkoxi8ZkgOPAg34zRt/QrKAE7g88OBFRx8SQYB0QmWGJjetbh9WPVbxFNVVhVjJeeWnDQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42JXHM8aORkw/odVpWrAFVW5YhkViB2c7F9pK2astyU=;
 b=Pet1yq4EGweBehFaiLS2OBL8EG8vrmAh9nhUTzq8fVpHMeF3VQARwNRP1JiSJa7VClQ6sd0eIlfjaN2aybTGNhRGQPSJ4j2B3GgKESIU3KVVex3QjNB6Lag51pXx0PNWQ1a0O1JMy+NVUk69dDmvixir+qbcbVjP3dDNa2o6YaPVI7hVx59FEMNINiDepqUDszWv7aLAOoFSFY32PFrVyxpBHeXj4Hi+wcpxv2PMQOKvmbJK6uW+mZjOSNeW9NG5xuO2vrYhkXvpqt9u40TT5eG/QPWklwHKNm+BpsSojTuH+ZdMWsSplipCJh05hHwCLmuETK5uPjP3tUGhKZncnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42JXHM8aORkw/odVpWrAFVW5YhkViB2c7F9pK2astyU=;
 b=ZZhq0yieTCGHdwbnIjpQ6PBZ22aDdvRG/23J02IT3VLhPvIRlADdE3ujS2E4tZ6j9IyeBtYffuUaxxTAOEzvXAgyFe1XJldQhd3Ap7FaGjEOpoaQNXgwm2Wm9/83QAzg8ZVN1YPqx7WpNYgPuKhv2vOwPlQTfL5IcxaaM+m9qRI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by DS0PR11MB7927.namprd11.prod.outlook.com (2603:10b6:8:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Sat, 21 Nov
 2026 03:13:10 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 03:13:09 +0000
Message-ID: <a31cb0af-1f23-4f5d-8c7f-3622f8d79ef7@intel.com>
Date: Fri, 20 Nov 2026 19:13:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/28] x86/cea: Use array indexing to simplify
 exception stack access
Content-Language: en-US
To: <kvm@vger.kernel.org>, <x86@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Xin Li
	<xin@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed
	<yosry@kernel.org>, David Matlack <dmatlack@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-6-sohil.mehta@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260911213659.2025974-6-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:a03:338::22) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|DS0PR11MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe29f37-bbea-4afd-ea17-08df477d5ec9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|261026121527099003|10067099003|4143699003|5023799004|11063799006|56012099006|261009223027099003|261021121427099003|261102130727099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: KXzf5Bu77GudqpusQcO7e+KNpCqxhwxCzN6K3X5mSc4RVsWz7srZ62TfwCYDjdGikbUCdiNbg0pMBSk4z4ALjNYDSq2KkWimDhtS+KUUn+eH8HtQkppxr0HJIV8Af9xwJbBs41isvuN0VMrCmzGeke5VkeHFK00+yzFChDMcd6BH/OL+1YEFihk0Nco1DlxH+QD9VhAg/iiuCIFes2pAPGuhcfSMXIHzzf5zDB+JcIaxOlco8QfbWt0o/skcQYO4pkE2Rjq++M5HKTLeJPLRfzzYbzMazrpUVDdRzyEG1YC2QW3ViYfKcxVf4oTxB+PccCQ5iTZBjzgwieQVLmAsRacvoU77BOASI8x4DAoW6pmllAa99wT+PGQ6s79H0GFXTwPy0eKsx97+iVQerjYQppUFMZ63WhdNLOIL9BkjswXCCGAJDkkJfXHLikF4aaa/CM+3qj7vea0Xx5+MlW9cuU86tWvBcp3Ft00AjGTXcnuklOkEzCELvcgAN1P55+XpqqFMMkX2RG7Uv5wNDmARos+O/TLntnCmjQtcGLw6lOg7Q7oPEd4NuT0jqFCnY1x2F+32YIUg26hAp6kqtHPQG6WDkOjCYOOkPWz8Eg38D/y4tuIC8yVsZ1E9+X1OJkN3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(261026121527099003)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261102130727099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUlzZWN4dmJEZXZPY3hXQWdZOHBGTjJGWkltQTRGNEszUFBOekorK1dvcEl0?=
 =?utf-8?B?OXpLSGVlTmxOazMxVXdyaHRBQTR0VnRBNGdYSkxWdnc4czFqSzFmYXdlQ08v?=
 =?utf-8?B?UHdLQVV5aWxkNHNpQ0RtMkU0M2dIQXRqVVpLSnV3TDdCL3M3Z0hwd2ZjdUE5?=
 =?utf-8?B?eDBOWExlV2h4b2U0Z0tqejhmd2NuUGF3ZXdjL3ppcWVOem8rZlFIZXdQZGRC?=
 =?utf-8?B?K1UyeVZmNitFOVBlZDJNRzRWbGVWLyswb0Q0R1pIZWFtSzRlL0hNRTJYNGtV?=
 =?utf-8?B?MkkweG1GSGVLZTBuMmN2MXM5OENQWFV5RmdRd3JnR3lBR1JNQlNiTTdHVFo2?=
 =?utf-8?B?VkFlZm1pWUp0SnRyblVJenlraU1YNmF0TnVaY2ZkV2V1Vk9rbEhwTWZ6WWxH?=
 =?utf-8?B?akY0M2RpRVR2elUxSFhCaHhidDZCb3BIcWw2UHJ2T1dMMlIzZmVnSkJyUHp1?=
 =?utf-8?B?WGZhTHNyZW01ano1T2g3N2RxMTFBY01vVDVIMHNhVkNGTWtPZWZSSlhpenNT?=
 =?utf-8?B?WXUwNnAzY05teDJaLy8xUDdmcm9nRFlLM2FnSlJmWjZKN3VxZUY0NDQ2NU9t?=
 =?utf-8?B?aGhIRDZWTFdMZTFjaWlYMXhkR2xFWHVHSG1hL0RwZUNwK2R2OFRJN3BJSkZu?=
 =?utf-8?B?elNUM1hFQ2MyaUNVSW4vdEFJQlJoTjBDQU9YYk8xQjhGblFkcG8vRzI4dzlZ?=
 =?utf-8?B?amplSitrUkU1TFk0d1JXSDdXejE2WjhHWXluWEtlbWRnclpFL3RLUTVmNnlI?=
 =?utf-8?B?KysvRm82QXBVQm9hMGt4YU1BZXp1UFg0OWJ5dlZHZkFCZlBpdWdHU1VYUFJm?=
 =?utf-8?B?cXRlVCttVm9aZU14WDl1U2FKT0JiZFJpc0liRW9uS09NSXE1QXNXYUVQM3l3?=
 =?utf-8?B?TzNzTm1mSGRLTHFIOFB4VUQwUnpIUzlEdzRJUWgzMzF0NmtpMFpjbzVyL0dD?=
 =?utf-8?B?M2NKWFBRZDViT0VFUnlmWmRLL3Mwblp1Q1FmT2dpOVFBVThtVWQwUFB4cWkz?=
 =?utf-8?B?bWRlOWtZcEZnU3g5Z1RYS2lpR2ZVbWFPaFVwQlJJWEJObjFOS1hqeFpnMXRu?=
 =?utf-8?B?NVFLTDFJUCtoR051OHRaSGhOQUJpNEhISXRCUEpOV01XeWtQZ3F5YmlrL0pE?=
 =?utf-8?B?aTh1RHEvamhYYU9STXV1L0NyNXp5MzREWjVLMDBCNGhsRnpYdjRPMllLT2dt?=
 =?utf-8?B?NlBCRXJYdkg4NDNSRTA5MlZyOENST3VMM0tvcmZIbWRSeEdIMWVvZ01aRkU1?=
 =?utf-8?B?Ukd2SEdMa2U0SFliVU9wczhaNGhFWFIxRDUvU0tQQTNoMUJKck8veXhlbmFm?=
 =?utf-8?B?WVl5ZzZLdEJLMmVRdzc1bm9sWlNqdmVsSUZobW9lamlEUTVJOFc2aG9jV1BE?=
 =?utf-8?B?dnJNQmZJQk9FS3VBUW9NTGcrN2oveGZUMVpnVzk0SEFFWHlyMVI3V2hYUGU5?=
 =?utf-8?B?OWxBVUtWbnZZMENTaFNzNlVrQmRPOUw2TEhNcjFGTTBSaEhpZkgwUmhkU2Rh?=
 =?utf-8?B?djRVcW1UNzZFdFNTVys4UzEza1M1YUZyclROdExJM0Vsc29FRkVEUkN2MmNh?=
 =?utf-8?B?SllkMjI4UGZvYUhQeEJzWEVwVjJwYzhEeEFFeFNDTnN2bHQ4OFBWMXM4SUtz?=
 =?utf-8?B?dDVydENPVGNzWkdDSVBwYXhpb04yZUFSbWxDVXhwdi9EUG5wT2V4d2FUOFY4?=
 =?utf-8?B?RXRlSUxwaUxXY2lIZkpBMzN3MC8xS2dTbnFmbnVEUWYwTUFDb1BNdExybjNZ?=
 =?utf-8?B?eGFQeFFydlJjUlVRbVNvekg4TjZRVTNmVVJrSk5IekdWNmM1TU14aG5GTkps?=
 =?utf-8?B?S3ByblQ3RzhNZi9SU09DUFlwbE5BSXpjeDd4Z3hGUlJBOXZkV2U3U3lmWWFm?=
 =?utf-8?B?R09Ma3FCOGlLSjVqQzNyNTJkam1DUVMvRGRvVnJubDZBY1QwQ2JUOWlreEtR?=
 =?utf-8?B?RmpYWGZuUUh4M0YydU8yQlJ2TTVjUUhjNi9oVGpSYTNRUEQxUHlQaVlQTUZB?=
 =?utf-8?B?RXVxN3VnSHdPNEtjRUwxdWc2cVZSYWcvVkdFYlMxaVJNTDJLZFFLckVnempB?=
 =?utf-8?B?WnJybVR3cmlGc0FZSGF5RVNDRWpzTHh5OERSQXdvRHgzUjZENytMOFBBbmFI?=
 =?utf-8?B?SEVVQVRTNndlMzJaNE12bXFQWUVsU0E3Si90RVhFN2tMVmFjcGk0MGtITjJG?=
 =?utf-8?B?TzI0RDlsczgvbk9UcUVyRzQ1ZW5GM2xpNFlqQVpEOHRhbkxhc2hIaCtXb0RZ?=
 =?utf-8?B?NkJoaGJ1SEF3RmJrSWZGTjNWWnB4WTc3RWs0aWs3WVBlOVVFRk5qVHB6SXRw?=
 =?utf-8?B?dlNNVVBhNHAyaEU5QnpyNDh5NmxxY0lsY3lEdkRNRjRGNU1rRmlNZz09?=
X-Exchange-RoutingPolicyChecked: UWj2zmT7o9aXMUvX9Ds19IrE46RORhxjLbKxyzZTpGilDin/FEoHqyFbvFvjeX4yaIwAmYnRsKedtKbjIGfyjwUgpdVSiw16+2VUXFT+I/fQxkEeC4I2mL2FWNhvO3nN8yTI+BM8N79iDdzvEtyx20UH7PGGkiYVxHRDFyAOnGoSenbew2DvaWEM7cOfPkQwFS6DA9irApgpUo4zSK7QDoHwip26N8VPtL+tUOjr6Epr28Tm/EyKWxfeygwUwbXmrmQJndqQdRLtDQaM59H+6wmd1vZff8Fi1GBTumsYoXmPoO161nyXY37HKTBGB1oniKi++w27bL8Aj4leBcHBUA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe29f37-bbea-4afd-ea17-08df477d5ec9
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 03:13:09.8316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sxt3B7EsSi+AWjLTzOkihAudWC8X/KqIGbluDiVibpRiTDYuVAsDTLPqDz8/YExhXeGudGxXgxb4LS6SEiBxyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7927
X-OriginatorOrg: intel.com

On 9/11/2026 2:36 PM, Sohil Mehta wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> Refactor struct cea_exception_stacks to leverage array indexing for
> exception stack access, improving code clarity and eliminating the
> need for the ESTACKS_MEMBERS() macro.
> 
> Convert __this_cpu_ist_{bottom,top}_va() from macros to functions,

While, separating out these patches, I realized that this is no longer
needed. this_cpu_fred_rsp() is planned to be exported instead of
__this_cpu_ist_top_va().

So the FRED KVM enabling doesn't depend on patches 4 and 5 anymore. Even
without the macro conversion the cleanups are useful. So, I posted them
separately.

https://lore.kernel.org/lkml/20261120235025.2809042-1-sohil.mehta@intel.com/

Planning to stop carrying the CEA patches in the FRED KVM series.

> -#define __this_cpu_ist_top_va(name)					\
> -	CEA_ESTACK_TOP(__this_cpu_read(cea_exception_stacks), name)
> -
> -#define __this_cpu_ist_bottom_va(name)					\
> -	CEA_ESTACK_BOT(__this_cpu_read(cea_exception_stacks), name)
> -
>  #endif

...


> +/*
> + * Typically invoked by entry code, so must be noinstr.
> + */
> +noinstr unsigned long __this_cpu_ist_bottom_va(enum exception_stack_ordering stack)
> +{
> +	struct cea_exception_stacks *s;
> +
> +	BUILD_BUG_ON(ESTACK_DF != 0);
> +	BUG_ON(stack >= N_EXCEPTION_STACKS);
> +
> +	s = __this_cpu_read(cea_exception_stacks);
> +
> +	return (unsigned long)&s->event_stacks[stack].stack;
> +}
> +
> +noinstr unsigned long __this_cpu_ist_top_va(enum exception_stack_ordering stack)
> +{
> +	return __this_cpu_ist_bottom_va(stack) + EXCEPTION_STKSZ;
> +}
> +
>  static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, _cea_offset);
