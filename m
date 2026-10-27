Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793118982;
	b=v0QXzyqOJKgf4SZa3aCNOfiy207j/jPW0qKTxWNflHtAncOOcjjfaLhG+muG9aTUIxKC
	 k2SEe5LWpPStY21SGqZWV4jqn787Url//KE6dZ4cBqdokz5Wbm9innC4GIiocDTknpBcN
	 iQXE/EYe/JvUwzuoX8IGTA1obZwDZ9yODyPAIw8707C/Z7ai5isF0b6rvBblTTdTTTWmJ
	 OpK1al3GQR80g67uFGSSpP/rJbgbAxl9afn6PCIaJYzUFz9EEyk2n8SARqtVLBnIXuE6D
	 pWr+OJ+7q6Qwm7/isyHD9MdM+X0moux56W8z/cScEXA5QwO0KcEU29z08TpFe7NqylQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118982;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=rDlGdlPqrxe20803Rw4nucxmUzP7t4lNaWKtazBehAc=;
	b=QwNC0gn02wtzHHKZdWT7pX6K2Qt++s6xIyfLEI7K/BfSzfN1hPBI63uGTcDYeLyDV2v+
	 82vN6wc69GZR9GVkmMsTAb1fds9rtfZS+YwphstMs7R8Nt9fDnrGNjEat0rDmIqs7lVFw
	 PMe0uq1Dg6M8lUQ6rbcVrVZnjeME+EdHp4xuo9JpWw5dItPjWzp1G3vaQLdATMQTJBiA6
	 /IG+mjdH5r5lSmzBYzUlhTZbDvDvEOL5eT28BmLMyGYLQdF7wjs2I5LVxVvuMznRhvoXs
	 tCckGJuMohDAKkYMIcIwW4t5VgpQ1Bdvpn6PylBk1bL7iVJcY4lw74s7Egb+102QzJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W+ufP52Y;
	arc=fail smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55363606A322;
	Tue, 27 Oct 2026 16:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55363606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W+ufP52Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793118982; x=1824654982;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Crc/rUnGbNYX7mGZ0FbxyxtZr11pZxNvJ9S/qX08khA=;
  b=W+ufP52YMI7sBtZN8mE/pd++AKSkxZjNbBZeJC2tj2ythi6EHZ9UsH0R
   BoueVI9KugciIaoRv7Zr3jz203/4DqR/M96mL0nfZ5AXi9oPx3Dk50V0H
   pKx8z3rdRFIHigLe4y+eWQP4CiAtgnOctc0ylcJhEWZudIdK2I9n57O2Y
   I2dzjjJu6JPxIi2Hcp/TK0UF7YzCeCUK28PY6aMldZ/57ANYfgXNr+jaa
   JFY+BTyqDOXOCg55MiuKGkcal4VCaaLpJV4A39NYyLC8hZU0bensTxqDM
   2rb3N+XKVabKwc21xC7l24/AIgLeJaMwZHq7lN21an6lA+eOU2HNWBQpt
   g==;
X-CSE-ConnectionGUID: vcSudkVVRMy8JxNUQh1G0A==
X-CSE-MsgGUID: ocbh/pc5SoaOG5zIYPLLKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1916024"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1916024"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:36:20 -0700
X-CSE-ConnectionGUID: 8lD42n53SsiNUmAmFGJ5fQ==
X-CSE-MsgGUID: E+0ZfZInRFeHUvyNyChFsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6354860"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:36:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 09:36:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 09:36:15 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 09:36:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8TatAdWkSdYEul3F3bnI40veNNc3ycteK/8BB3b+vZZuF7TKuEx2dINI0EFZEePhX/HQFDOgkyPTMEaYwwBTgQrcobHOKpPB5XttMV+KojKtvvZzDONSwKjqs8TrdBWxoM51ovyPKhi8YPOlVTNtY72i0z5Ba0HLL25bADOS4iN8eSJeuBig+3YV/TsTkxrS3RwJlFCTtad5TSCV/2gXWP4SZLMIYFYRvpKX1Qkrfebso036guGEul+My0pmdpUho6hgzFFY/u9jc1FabaxJtrSrd7lom9La/khW9XizfL2cJu+0hfiTgO8NeC804OxBWHPMkocGtecaPVg8hMQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDlGdlPqrxe20803Rw4nucxmUzP7t4lNaWKtazBehAc=;
 b=HamHQZd/yAQzJ8PxEGgxuIiy66oB0u/oWJ9QfjuGaY2jtFcM+8WGvE7aDNYEnXrpBXRyEQbnHZ3MHsH2CiV4HLTg310beyQ/k2hoBYNuV4vXaQ+W71A+Cgz6DSA6kROwgfrkgeyKwZpnLaWbk8QVTFYDQPuBbB/nOP+k6RPAIZvzCaL7Ejk7UkFTrMN4qcebyAQZ2gkRIBvv4/GhdR3mtL4cf2K/p2pnoNE9AkQciY8CA5P39Wr9f2ukrRFMxZTOX4x9M2iD/emdvCdDqnFe4o7+bolgbs9bffNeUau+LJSQq4JEvk8eovPr8fb/dxuqanb/GQRJdLPX81AvQHa0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by MN2PR11MB4662.namprd11.prod.outlook.com (2603:10b6:208:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:36:08 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0546.016; Tue, 27 Oct 2026
 16:36:05 +0000
Message-ID: <98597562-0c2c-4b32-a0b0-77777b8076c8@intel.com>
Date: Tue, 27 Oct 2026 09:36:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] x86,fs/resctrl: Keep mbm_assign_mode in default
 mode at boot
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
References: <cover.1792627082.git.babu.moger@amd.com>
 <1a8f3900e9e14ec19f5f7204fd64716eb0aa8427.1792627082.git.babu.moger@amd.com>
 <0082b675-5749-410c-9fec-9ce9b23b2498@intel.com>
 <9778fb3e-f5f8-4137-be2a-598cd44fc6f4@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <9778fb3e-f5f8-4137-be2a-598cd44fc6f4@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:303:8e::23) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|MN2PR11MB4662:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b1716ad-cdf1-4e89-d7d2-08df34486585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|261009223027099003|261022105027099003|261021121427099003|261021135927099003|261022075727099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|11063799006|4143699003|261026140227099003;
X-Microsoft-Antispam-Message-Info: mwRTAc5yHl4F2+eL5ndF8RQf08uUj3RYbRaFYm+U2JzaMZ+RNZ8sPXaOqVB4meJx6J8Tcl6aosTumjtpASrh0QTplD5lq2aGpyaqIfs/ojVqQJgsvnk5NC85i5nZXgpn4XkfJ536uz+ngjYcKhHUgRS5j0DKMaBjUjn1L5wQ/YEhVImf4Y6OFRca9JLoyAo8XfN2qBuMe8RQw8Es2+HqK4g5M8xI9/ulR9bsEoYvDLgHeax3lrwIY56vEw5LauiRJWogw0sAv/VgHlGWO5j048hgt52EoUCzhNv6x8NmoctV44oDPCFzyJxSoT2JFkQ+ICuxdZO/5CgfPHrd9ixEwkFmrKjs76oSGWa+IHHCedhMepIjyq714F2BbqngT9onvqX4Z04TaGS4AjzFp/TUAWb2hBSqItcwUWKBU5O3DyWbeSCl3woVLd77O1ywagulJY6U+A6RHD19vQHQxxR36b5vLQSApYVQmbF5ANdlBcVZmXiF648LISW/Bs5jAQO00MWw3Ik0vLp3VmBEAuhEc1Q+9g0Qh6w2Ph+VjPbkQDIIwUxmW7VWD+WorpTYMHLMd9EhzJDRAFLf7lOVAa5yj6Ubrjf1Lw9t8StlzahUt5X3yQNqjAQPnb9WKBWWV+SVrl6SarPiRaaathdVvtK2g+9Ll5k3roJoQbZvmaBTxtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(261022105027099003)(261021121427099003)(261021135927099003)(261022075727099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(11063799006)(4143699003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDQ5TGhqRmFyY3BTdGdOZVk0a1RieGRhQUxZNUNwZm5EejBFbWNNMlFlWUZW?=
 =?utf-8?B?T3lTd1orYk1iclYrcnM4eVU5TTgyVHhZS0ZOSDAyb0FxWHlGQStFR1I3T24x?=
 =?utf-8?B?dlhsZGNBUzRyR3hwWWd5OWg1K21ZRS9tZklJVEhIRDJnT1p4Uk8zNjlPZlRL?=
 =?utf-8?B?anFwRXVtM2dGMHl5aVkwWHlac05oNWpabWV1cnlmakY2QkpXSnNqODMyMndp?=
 =?utf-8?B?NVdnWG14eFlIWnZJWFlLamZSNCtsOVk1VGhpbzZqbThEcjBKMGtRSno2d25k?=
 =?utf-8?B?WkUrckdBVHhMV3JhdDhpUGIwWVYxNHFaR1VBQXRDT29SL2VzQWRRQ2JtSEdh?=
 =?utf-8?B?YVZKcnJEZHVpZ3dIVVpkWkcyRlkvOEdyb0Z3RlhvaWI5ZGFxSEkvWmkwemFj?=
 =?utf-8?B?TkJOTjA3R0xtZ3lIejkwbDNsK0RqamVsSDRheDRSemFrNjNpUkdtc01pNXhH?=
 =?utf-8?B?SlUySFg5SnR6Y2pROWtFWVIvVERqZVVGWks5Y05KckFBOXkrWXM0UG9vcmVv?=
 =?utf-8?B?RWtrQ3dDOWd5YTB1WXBzNU0wZjAwUFRKNVkyK282K2x1Mm1MSTFtYTV5Mmdj?=
 =?utf-8?B?ZEJMMnNBWnpubEFsbWN1bmR0ZWllencrbG5HQWpramNCdFFxWnJDc1FRdTZ6?=
 =?utf-8?B?S1hmdXRhTk9hT2xFL2h5MUF3TGhCVjhrZXZlK3FsaUxJUFgvNWtyS3RSeW9I?=
 =?utf-8?B?dlo3UXE3dFdFa1ZONFBvQkdmTzJqZUVUaTdQSWVuWTRtVEtOeHN6NWRSeWxm?=
 =?utf-8?B?aDE4T0hVdTZtYUZRS3BuRlNqblpBby9yWTJSeHhSQi93OUwrWENQSXd6RWVq?=
 =?utf-8?B?SGJzYVRWdFptckoyeG9RUjBwQ1l0QlFrMnAyZmZDUnRSOURER3hNbUZlOVVV?=
 =?utf-8?B?TUZweEh4b0d1YkZTWCtWT1FxVmE4SDRCVmhJOHowakdUT3JOOCs1OUEzaGdE?=
 =?utf-8?B?TCt0NUhXc1o1MUhPeVhidHgyRHA3Ujk1NHlZOXU2Ky9GU3VwdFZvOFpSK2Iv?=
 =?utf-8?B?RWwxMXlUY1UxOVRCQlBGeDJEZTZzbGdnMzB5ZTJrakh1NFNPUENrMmlNZ1dW?=
 =?utf-8?B?azQ5WENQWjlYd21HV2g5bVJ3cU56ZVYxMUk3ZFRCNUV6ZlpEdVl2Z2ZHMVU5?=
 =?utf-8?B?VzhDa3Z5MzQ3ek1kNlRZVXl4eHJqSXJ0RDdwTGtEQkhURUQ5ZnkzaktWODBp?=
 =?utf-8?B?WTAraTlpUG16cnpXcVkxSlRJZ0tIVVpsMElwdlVMeTdnWVorQ1ptVm9UNnYr?=
 =?utf-8?B?TnBOeHBVbjhZblY2R1RkUHNWYW9aVGxJMmJUVS9GUTJqZjRZdTRPeHp1ZXIw?=
 =?utf-8?B?RUNsQjRiQVFxQzY2bmVhRzg2eU0xRnQ5WkF2M01uM3hXN1ArMWQzbFJQNnBO?=
 =?utf-8?B?UmJBNlJmQVhSbU9tTlo1OXVnSGZhd2FkeG1xSzNXS3QzajZ3UE1jZ3pKSG9q?=
 =?utf-8?B?VGRCQjYyTDlVeXlNYlltVUVPc3FPT25OaW45a1BwVVA0cFRSMEVTZVZuZU9S?=
 =?utf-8?B?UU9XSzdzYVRsSU5RbTBJNE44dUlPbmE4LytzaEROeDRnMXhEQUExbit6WUgv?=
 =?utf-8?B?d2NXOWdDNnRnY21TU3MreEU2djEybG1OZElEOWd3V2NHZFl6eHEzNWFEc2Ja?=
 =?utf-8?B?c2JCY1BBbHF5cnpFL3J4NFpycTFQQ1d2aGZQenhSelFtalVERGlvNFNKK2pW?=
 =?utf-8?B?MVNFTll3THZxSjNOdXJrQVlORGNFZEJKL2ljSnlsdUZtZEtwUzhnYVBuVUZM?=
 =?utf-8?B?NHhuS1ZPWlVUREUrVTh5OUhuT1NoTmoxVVRPUTk3alBnWXFNNWY5QXM1U2VO?=
 =?utf-8?B?bzdudVpROHdzQjkvNnNwQlFFenZyMTlzSVFBR2ErS3pGd1dmYnRPNFRQYTdq?=
 =?utf-8?B?dGdxTkEzcjQ0UXJxbEcxUExXcjRRWjE4YzRFNHBzUXIxQzhQTnpvRi9uYnd6?=
 =?utf-8?B?QTlXdnltZ3Zoa0VNcVRCMXI3TWxuWUo2bUQyYVZlcVZQcnRYZzI4Rlc0UVFV?=
 =?utf-8?B?bno5Z2MybU8rL2tYUTlWS0J2KzJHZm9qcXZ0MXpiTU1QS2dCbGN4LzhTUjk5?=
 =?utf-8?B?TVRaemVxMmVpVmIrVURGV3VoeE0xZDVxZE1Vd0lsR1lrcWx2RlE5ejZleCtS?=
 =?utf-8?B?TjhBc2hKeHp6VjJQdm1oMFA4OXZZM3dNditpeUd4ZG9sWnNmVVkzVnVXc0JJ?=
 =?utf-8?B?aytKN2tkOG5NZGlaRFBIb09hQ1crbTNOUjd1L3V2ckJrMFJuUW01bkwrTndC?=
 =?utf-8?B?Tjg1OXdwcmNvZDh5WmZrSEhOSWNlSkN4UTMwWTlsbEZlb3NvOGJ2dWFlZmtM?=
 =?utf-8?B?dnVudlczam10d3lyRFFXVTB3cmRmY2NJZVM1WmwvUXR2S09zdERjcERXbTdr?=
 =?utf-8?Q?ABCul9oIgS1vdD3s=3D?=
X-Exchange-RoutingPolicyChecked: FggsIJihOCHR0x8608SSrgh6eOp01R0b+FCIunFtOKYk6QJu+QFtcdvFQuU6LJ/g94gV/tU38VyWH/skQ07yp+0W/51zh1dNjPvrRzUZw5x2mPXaGqg5XC6KJunxXWexkUbOfY69s05ZFvaRByt3gyGHQ71clcHLD6MVOlm5SMgGK3ATMt0mqki2V9UlWphm2rVlM4r/p7Qu3F6ddaWZK2sC9LTbCWB3VLMt5K406MM0I7EPHpyrdu7Akoog/j7RijiZSYXDSn+USPhwPqmRLO95Y39zwAxV20ZtDiisTRaCaRAL3rhEqH6mfIY61Apk4rbjyVxR8MbDIb9C0ML6vg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1716ad-cdf1-4e89-d7d2-08df34486585
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 16:36:05.6553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQEUjRbTNc45H0w3SuPrcfc1FEnX/r1Ny2EzQRD0ZLgt4w3W5gcE8bvAmIaIfEUBm7iAYpspL/b32u7zDKVOqxiaAryLBDdtY9QpnWfJyRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4662
X-OriginatorOrg: intel.com

Hi Babu,

On 10/27/26 7:48 AM, Babu Moger wrote:
> On 10/26/26 19:15, Reinette Chatre wrote:
>> On 10/21/26 4:58 PM, Babu Moger wrote:

...

>>
>>> +  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>> +  [default]
>>> +  mbm_event
>>> +
>>> +The "default" mode is enabled. "mbm_event" is supported but not enabled.
>>>   +b. Enable "mbm_event" mode. Switching the mbm_assign_mode may
>>> +reset all the MBM counters (and thus all MBM events) of all the resctrl groups.
>>> +::
>>> +
>>> +  # echo "mbm_event" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>>     [mbm_event]
>>>     default
>>>   
>>
>> The above changes could be merged together under a single step "a" that
>> will significantly reduce the churn when considering this is a stable patch.
> 
> Yes. We can. But because of auto assign is not enabled on mode switch, we still have to touch few steps. Your choice.

Understood. The benefit here is that the patch will only change actual information.

Specifically, changes like the two below that just updates the letter
associated with the step:

>>> -b. Check how many assignable counters are supported.
>>> +c. Check how many assignable counters are supported.
>>>   ::
>>>       # cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
>>>     0=32;1=32

and

>>>   -c. Check how many assignable counters are available for assignment in each domain.
>>> +d. Check how many assignable counters are available for assignment in each domain.
>>>   ::

will be dropped from the patch. They distract from the core change and do not
seem appropriate for a patch headed to stable.

...

>>>   -h. Read the events mbm_total_bytes and mbm_local_bytes of the default group. There is
>>> +i. Read the events mbm_total_bytes and mbm_local_bytes of the default group. There is
>>>   no change in reading the events with the assignment.
>>>   ::
>>
>> Could you please remind me if the first read after assignment returns
>> "Unavailable" or a valid count?
> 
> 
> As far as I have observed, mbm_event mode (ABMC) returns either 0
> when there is no activity or a valid count. I have not personally
> encountered an Unavailable value. However, the specification allows
> Unavailable to be returned when the count is not available.

Thank you for checking. I just wanted to confirm that the values shown
reasonably represents what a user may see.

Reinette
