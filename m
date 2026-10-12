Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D054AC176;
	Mon, 12 Oct 2026 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830708; cv=fail; b=WYEnNk89hM4jMX8IYWBa2TeM+waBb0SUSM48D6atQw2J5CGC34BsybOhgqm7ar+7Y5L6YllkbQDKRahkbtaTAaB92VOIDmViIBx22/VPXNJ4BwZeKMDsAFg5zRuLyfK6ycocqFIuENzOaycS++1YFq8ute0fL/7MrDGVFbpj9f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830708; c=relaxed/simple;
	bh=PApA+Am4PgS5/p03hCVxwdlN6qYMGdfTlaFQsV+GKAQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mT5hE6jTBWN/x5ILfhFe0pB/AM8P4J1JQmCbepk1E7Fxqh4SxQzHn92c0PzA+OZdtBb+bh/Qd6Y48s6faBWJx8941maFbU4JevRPcySMC/dffTsdqt/bLIyv+o1vO9b3ngi6uAmWHyB1i40YQS2qmChN/cIxGWpKz2V1OHHc9FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vlv0N1hU; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vlv0N1hU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791830706; x=1823366706;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PApA+Am4PgS5/p03hCVxwdlN6qYMGdfTlaFQsV+GKAQ=;
  b=Vlv0N1hUKPy/kqBocbz7/BebZIgZaGORJEGKIjVHW78zLMcTAl1DvyHI
   jPP9Mc8tUySpOk14P7kz8rb0jShe6nsR4iG5H8AfQaceLGVyn+Qr7At1g
   bxIfCoh0WsX0OobXeYlV1B+Klv2YxgU+CIU9ZyAdko2xtkF8wPmcfkqQl
   vV0tQsYPDmxYSXSH1EVo2TcnOEcLOfQpYPjjoCgqZ0Zpe9h4anxksp9FJ
   DAuVnEEXMG7caFdPHbQ8CzsMKCdwWsnhSxpvQ75XqegRU5Vvv3AAtJ67z
   uYCO9kpyEoMbLonvmP2/3pHaDhlcb1H0ZvI5WFwi5hFJ8UoLO3WKn9Xt8
   Q==;
X-CSE-ConnectionGUID: ACbY5uvmR2+sefvsBVkR6w==
X-CSE-MsgGUID: TaAXQUuAQSelwN+p0PUpOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="440522"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="440522"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 11:45:05 -0700
X-CSE-ConnectionGUID: 9ts7UbPGTLGn6g/TUSYXjA==
X-CSE-MsgGUID: gSHZ4i6bTbKEyVRkOsjA7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1299364"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 11:45:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 11:45:05 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 11:45:05 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 11:45:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKH9AxnxL0n/UDPTEDJX8ej9lHz394z4BTAcX0kIoF82LYuozCm6ybcwA1+/xd54MDpdVlIgY4Q1dtCJxcs+gFbegK+FuS/LSAifV/74zJc9GbK7ejZxcerr6nFaW3u01U9jyJ9Oiyc0HxICq0zC/8Fc0wAyVEdVzpgvnhjsEsrdu+/AvxfD6ZIiCSXVfffSISY52BITPdTJCQFL1TCd+t1278h/cdHtetoM+y1lsosma/4enZcbBhBkPpfax736k+Da+RoiNfnPD515oLWVPALgZ5kOhViY5HlNsyKuf9UAiJwJjzjhW057W/muRWNMam3QKjVYad6b+A+tnanaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiasoOBarIvVXhM6lfCrac7y5pibpjRusizoGEau6n4=;
 b=uLo7W3gxlm1vVbtL9fiM5azLh0mBnS5RY2IOudDeOiYVbFZskRqtQWjTneQLCcJ2G6MHEt/iQRre8ntXR5WQPcUZylUl8rjyPz5P2exCvwHXwwRhFDZFLsoDyGY98OMWQbowu95GoUexx8urzvWSTVOCrCH3HO53gGeOw3PJwzFeYWa/em2Z/NP5AUkJHLcZbzd6VCzz39zN/BrkoDpOM75cysXa7MjBTLki4CLvWUao1UmM22HjqzsF50JYEKVUTQRY5Wdw6QAd5ucKpaZ3J08NFZ+dajcS9Wr2/41c2HzjfjgbZ4uyuPoJ6cXOBXL3RKchHhI5NZYKyHYhCs/Vow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by IA1PR11MB7943.namprd11.prod.outlook.com (2603:10b6:208:3fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 12 Oct
 2026 18:44:55 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.018; Mon, 12 Oct 2026
 18:44:54 +0000
Message-ID: <918780dd-30ad-429d-ac35-25d79d47450d@intel.com>
Date: Mon, 12 Oct 2026 11:44:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] fs/resctrl: Assign counters to existing groups
 when enabling mbm_event
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
References: <cover.1791589412.git.babu.moger@amd.com>
 <3d966ae2e051ef54e1aedb1a2839c812ab880bcb.1791589412.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <3d966ae2e051ef54e1aedb1a2839c812ab880bcb.1791589412.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0231.namprd04.prod.outlook.com
 (2603:10b6:303:87::26) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|IA1PR11MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 992ba18f-5376-4168-2fd3-08df2890e846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|22082099003|4143699003|11063799006|260925021911599003|56012099006|261009223027099003|260925021311599003|260925022911599003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 6fVmGUaLgoWiqjFExXcew+IJ/fji8bWtCJlBSmoFzPDvb/7cN3D0dUK6Jv4CO26qlZCsA73gggIUw/5FMPjtsIKhqAKLPmitNpT1faGI2mQC/Y6+R4WHAv6LwTvE/R96Svse03zjX+asTREZ1cVRz0bw4jEil4kgWma5xQ3eGMMdgnVEHUULVxftzLcIT3WeHRC3Avipx6bAMy3LaKQ++A/YkKEBWPBEM9x8cMEoOrKp064LDV+MoEKPUYed5/NF2oc3z0WoVNfWCpm9gLlI2aRK1aIjWeusHKlNREgj96yPZjqs18OXFEcqaTLLw9/8F8jiDEZgVF538viuxpCIExiqT5UvyB247aDPasiwlx0VEI39iX9dGX5mBNKUOH98Ge7RE3scal80+fLdPllPOnYzfBuPuu/dionGjJpB3+LK7rtEGHPD3xw0pdniMv9cBtZ309SkyRV/1Rwd9COqM99Ognngc+zqTKN53l7CEgqufNSB/I4n4J6KbQQn0F3+hwEa1iSaJ7PKquO+Rdv3bIO0KCr4sdLbTFtsdZWhwZB3/DZyGGUZ/8nmLI9wAfkB/z8EKwFfubsgjvlR8CdDwMbnxQnvjb7+iJissOxIlck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(22082099003)(4143699003)(11063799006)(260925021911599003)(56012099006)(261009223027099003)(260925021311599003)(260925022911599003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEJrMXE3UE9zOTg4WGlzV3B2ZDVnZWxzOHdtbVJJNDRPNSs4U1k0RzBzd29T?=
 =?utf-8?B?dmEwTWR5VWdaWVRXa1kvOUtETzI2NnlHcVdHWDFPUDN3Z2gyUmNRTVltY1VV?=
 =?utf-8?B?bnQ4bC81V2V1dXlBeXVGaFhvL09IdzBsOVVVdE1iWVc5dDFDYVplUGo3RDht?=
 =?utf-8?B?Vnh6TGRKNm8vV0UwV2w1WWYrMUxHcW5YbjlIU2FQTzdwZHRiRHk1K0RkYSsy?=
 =?utf-8?B?Zk5XTFFDMmN4cGM1cEQwRFZHTzExYUJXOUdFdnN4RjR3ck5Ta1ZKMHRIb2lv?=
 =?utf-8?B?Q1o0bnBwTmRaQUtDd1U4Z0owSERTeWlhdDdFNnFTTnc4TkZOZ1NaMkhZN2ZD?=
 =?utf-8?B?Tkd3Y3QyVmdQd1FFQWtDcWVnN2d2WG45eEU4QXowcnVqN1JZNmxzL1FqOTJE?=
 =?utf-8?B?TTdsbUpaQ0hDT2diVnU2aGF0Z1F5Tm0xVWJ3TFpPeVAwQ0hqNmNuY1VFOS9X?=
 =?utf-8?B?VkNBellkSFh0dzdFSmVXMGpNVEVPRFlVU1d2SlpDam1IRURScDJFMGxiTVJV?=
 =?utf-8?B?ZnFLYzhZeEFLUkpaMlozSHZEdjdsUWJ5aHR6VlVCbTYyU3Y3RTYzMmZJMDND?=
 =?utf-8?B?RWtZTXFuU2VFaVdUK2FLSFR2dzJhZlV5UXp2MTZnNUd0OXpiVVcrSTZEVkhY?=
 =?utf-8?B?bXRQREZaRDNGcllrMXBnb3NkYmxsSFZiQnRGOG45clFET2NDbVRZVUlRaEVL?=
 =?utf-8?B?d2ZCMzBqTUNsRExBejkzaHVtZjgxMzM1ZHJrVzY2ZTduWE5XTnZvWnZtcEtj?=
 =?utf-8?B?UDdqQmt2QXVRODdEb296NSt6RHc2dFB1ZjNMYU1vR0VIdFR3YU9zU2FBQzFw?=
 =?utf-8?B?QU5hRGNPZGlEWVZlNUUxMEpCYzBwM3YwY0pXem1ERnVkVnFhYUZVY2NpYU1H?=
 =?utf-8?B?MHlpdmZpOTVaYThHUkJwWVJsVit2bzRYMklISW1yVlRqY1ZkbFpCM3dmNzE1?=
 =?utf-8?B?NUMzUUozWUdqWDJ6SEpDUkYzeFJkWnVMR2FHMHQycy8zOERIQkZQUkxVVXlN?=
 =?utf-8?B?SWs1UUpHRmJSeWFCVkdha3R1aGhZV1J2WmtoR1ZIZHpEbHE4UGU4VjlEOWxM?=
 =?utf-8?B?Vzh2MDB5M1NUZkhnUlQyY3pZdlNEL0hOOGZRMm9BSGp0elhoUUptQm93U1E0?=
 =?utf-8?B?MzViVW5McEJoQWYyTmpuQWg4WkdMZnVNTDU0SEhUQjczYWFEMzQrczlKNXRh?=
 =?utf-8?B?RVlIcThpWjJ2K3VKNGJ0VTdSWDZtY1BiUEZ5RmxmV1huV2h3Wk9VZUoxbTc3?=
 =?utf-8?B?eWVKMU96RVFhOFRxdEdieWl6RTRab0RmanVJYkQ0anFWa2V0UzYwbDdUOHBm?=
 =?utf-8?B?NzRtdlVsS0VDMTAyN0NuZXFudllseFBob0hBM2hoWThlcnlXdXFyc3hqbXY0?=
 =?utf-8?B?cnJhRUYvZFZqWVF6MThZVFFyZTIrWUtsOHUxYVF6cldFUC92dE9WQnNWdEo5?=
 =?utf-8?B?ZXdUMFJWWHJ0Y1FkNzBPMDBEL1RrWmtFVlA1akU0dFgrRitrZ0VDSkJKaFlB?=
 =?utf-8?B?aWJwek9rNmVHMmVKZGlkaXZydU5mYVZtZ0FabmFQNTlXSGk3NG9tYWRHRFFJ?=
 =?utf-8?B?L0ErNTQyMCs4UDhGdjNGL2dacHpnNENMZFJEeHkzdXhsRllTNldwTXg0QXIw?=
 =?utf-8?B?TkRsQWtxcTlDNDJ0NzdXVmxZOXVJem5iaTJHYzNIaXdpMWt0NTVQRkptelc2?=
 =?utf-8?B?RkRjcko4WWluVVdqTEtsV3BWZlpvam9xaVozTmY4OUljbzBDVWV4VUVuT0Iz?=
 =?utf-8?B?Nk13UG5XVmcvbTJmVER1Q1FyMklHZXBuUE5KR0dsb01iOElMV2JobnpZV3Vj?=
 =?utf-8?B?di9PRFNKdDNZR1U0OGIwK1JiWnFmeU5ZNjBpYkE5QjdETldyT09QeU51cnZk?=
 =?utf-8?B?ZXF6dDBFS2QvUlF2Y1NGWGxDM0lYQ3FBUTRmNWFCWjN3dEVja1BweUw1cm1i?=
 =?utf-8?B?R3FPaThZNit6eFdzc2RpUVRxZXlmRG41bTNYS0J6TE8xWEp3MldoSkxZemVn?=
 =?utf-8?B?b1cvTngvVDNweE5DTVR1Q0NVVFVieDhWV0NiV2ZCMVNSR01hd2dFeW5udTV2?=
 =?utf-8?B?bzUvYU1pU2dEL0dLS2lXdzNySlR1d0MxV0ZRZ3RGWTkxWno1ZVNPdksxLzVt?=
 =?utf-8?B?ZVVXaCt1TDJRS1I1VGNqaURJVmZlOTNRNWNLWE14eFVPNUdKMmM5citiZk42?=
 =?utf-8?B?cVRBMGFCNFJwazBIMExMczBFMUVzMkw2dTl4azY5eW9LTXJOZHdualYrSXJG?=
 =?utf-8?B?NnB6V2RndFBGZ0RBbDJucm04ZnUwU094Zmc3ckVFaDlqZ28ybkRwbFlzTi9F?=
 =?utf-8?B?M1Z1QVVLUVQ2Wi9SSHJMVzM1S0FaZFV2bFNJc1VnUGVJZk51SGJETk1LNFpK?=
 =?utf-8?Q?mCQHEnFV0mkCUGjs=3D?=
X-Exchange-RoutingPolicyChecked: adg9P2UyQ1XuwIjE1BTYc3j6YJeYCzSNTUWpNj35NswflGWMh0Sufts/8wykvb9pjv1TIZjBH1z3fovp4z8jR58kdLWJbU5wAFQokRKhhEj5IWlOGKhsSBovZW3fPByMBTExUZyHCQ1rHZvWwXogsAGuGvwUWnVplHeBzpDyre95YGm6dukmx7t4HBhU6lB96vO/To45uvy58+6xCnWPKztXKAVBdQWPESO/BJ5IH3qk/VPrnZyozRtochDMSUhSgApHtMIpnptb2OgVz9JSK5rs7zEZoM2YUvOr+XxN3HSLoaSJ/T7mgh1rGeBUUtWh4lkcyXzH+OL0yR0+I/wE2w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 992ba18f-5376-4168-2fd3-08df2890e846
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 18:44:54.9072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swIIO3Fuld9YV2SdhuC0KvMuU9omf5WycXcYN51pZ7zvhHmDSxm0cPWmBE7LSSanvFQtYtMMOFxlg6NwiU25Q7WKH0TA7sqOIewoC07pnik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7943
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/26 4:44 PM, Babu Moger wrote:
> When the user switches counter assignment mode by writing "mbm_event" to
> /sys/fs/resctrl/info/L3_MON/mbm_assign_mode, resctrl frees all assignable
> counters, resets per-domain RMID state, and enables counter auto-assignment
> exposed to user space as mbm_assign_on_mkdir.
> 
> Even though counter auto-assignment is enabled, groups that already exist
> at the time of the switch, including the default group created at mount,
> are not assigned a counter. All MBM events read "Unassigned" until the user
> assigns a counter by hand.
> 
> Walk every existing CTRL_MON and its MON children after the reset and
> assign counters to their MBM events. Enabling "mbm_event" now leaves the
> same per-group state that auto-assignment would have produced. There may be

nit: Related to more detailed comments later the above "that auto-assignment
would have produced" may not always be accurate. If the patch behavior is
maintained (more later) then one way around this may be to just instead say
"that auto-assignment could have produced". 

> fewer available counters than MBM events across the existing groups; in
> that case stop assignment when no counters remain. Events in the remaining
> groups read "Unassigned", matching the behavior of creating a group when no
> counters are available. Also revise the rdtgroup_assign_cntrs() function
> comments to account for the new callers.
> 
> Fixes: 8004ea01cf63 ("fs/resctrl: Introduce the interface to switch between monitor modes")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Cc: stable@vger.kernel.org
> ---

...

> ---
>  Documentation/filesystems/resctrl.rst |  7 ++--
>  fs/resctrl/monitor.c                  | 47 ++++++++++++++++++++++-----
>  2 files changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index b52795e03303..c8507580474a 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -370,8 +370,11 @@ with the following files:
>  	of counters available is described in the "num_mbm_cntrs" file. Changing the
>  	mode may cause all counters on the resource to reset.
>  
> -	Moving to mbm_event counter assignment mode requires users to assign the counters
> -	to the events. Otherwise, the MBM event counters will return 'Unassigned' when read.
> +	Moving to mbm_event counter assignment mode enables "mbm_assign_on_mkdir" and
> +	assigns counters to the events of all existing monitoring groups, including
> +	the default group, while counters remain available. Consult

This also adds the "including the default group" caveat that I will refer to later.

> +	"mbm_L3_assignments" after switching to "mbm_event" mode for counter
> +	assignment states of all monitoring groups.
>  
>  	The mode is beneficial for AMD platforms that support more CTRL_MON
>  	and MON groups than available hardware counters. By default, this
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index 04e4ea612b7c..9e705eafe873 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -1302,14 +1302,17 @@ static int rdtgroup_assign_cntr_event(struct rdt_l3_mon_domain *d, struct rdtgro
>  }
>  
>  /*
> - * rdtgroup_assign_cntrs() - Assign counters to MBM events. Called when
> - *			     a new group is created.
> + * rdtgroup_assign_cntrs() - Assign counters to enabled MBM events of a
> + *                         resource group

nit: please fix alignment. This patch inconsistently uses tabs vs spaces for this
alignment. That is not major since this file itself is not consistent in this
regard, but the file does consistently align the description irrespective of
character used.

>   *
>   * Each group can accommodate two counters per domain: one for the total
> - * event and one for the local event. Assignments may fail due to the limited
> - * number of counters. However, it is not necessary to fail the group creation
> - * and thus no failure is returned. Users have the option to modify the
> - * counter assignments after the group has been created.
> + * event and one for the local event. Assignments may fail due to the
> + * limited number of counters.
> + *
> + * Intended to be called in auto assignment scenarios ("mbm_assign_on_mkdir"
> + * enabled in "mbm_event" counter assignment mode) where counter assignment
> + * is not required to succeed. Thus no failure is returned. Users can modify
> + * the counter assignments afterwards if needed.
>   */
>  void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
>  {
> @@ -1328,6 +1331,22 @@ void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
>  					   &mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID]);
>  }
>  
> +/*
> + * resctrl_assign_cntrs_allrdtgrp() - Assign counters to the MBM events of
> + *				      every existing group.
> + */
> +static void resctrl_assign_cntrs_allrdtgrp(void)
> +{
> +	struct rdtgroup *prgrp, *crgrp;
> +
> +	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> +		rdtgroup_assign_cntrs(prgrp);
> +
> +		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
> +			rdtgroup_assign_cntrs(crgrp);
> +	}
> +}
> +
>  /*
>   * rdtgroup_free_unassign_cntr() - Unassign and reset the counter ID configuration
>   * for the event pointed to by @mevt within the domain @d and resctrl group @rdtgrp.
> @@ -1601,9 +1620,6 @@ ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
>  									   (READS_TO_LOCAL_MEM |
>  									    READS_TO_LOCAL_S_MEM |
>  									    NON_TEMP_WRITE_TO_LOCAL_MEM);
> -		/* Enable auto assignment when switching to "mbm_event" mode */
> -		if (enable)
> -			r->mon.mbm_assign_on_mkdir = true;
>  		/*
>  		 * Reset all the non-achitectural RMID state and assignable counters.
>  		 */
> @@ -1611,6 +1627,19 @@ ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
>  			mbm_cntr_free_all(r, d);
>  			resctrl_reset_rmid_all(r, d);
>  		}
> +
> +		/*
> +		 * Counters were freed above, so both new groups (via mkdir) and
> +		 * the groups that already exist need assignments. Groups created
> +		 * while in "default" mode have no counter assigned, including the
> +		 * default group created when resctrl is mounted. Assign counters

This patch refers three times to how "default group" receives counters during auto assignment.

How important is it that the default group is assigned counters when switching to "mbm_event" mode?

This patch implies that auto assignment will always include the default group but that cannot be
guaranteed since the default group is always at the end of the rdt_all_groups list. This means
that when traversing rdt_all_groups in resctrl_assign_cntrs_allrdtgrp(), whether default group
receives counters would depend on how many other CTRL_MON and MON groups there are.


> +		 * to them so that enabling the mode leaves the same assignments
> +		 * that mkdir would have made.

Related to previous comment is that the changelog mentions "same per-group state that auto-assignment
would have produced" that repeats a similat claim made above that states "same assignments that mkdir
would have made". This behavior assumes that a CTRL_MON group is created with all its MON groups before
the next CTRL_MON group is created *and* that enough counters are available for all groups. If
there are not enough counters then the most recent CTRL_MON groups will receive counters first potentially
leaving the first "mkdir" created CTRL_MON groups without counters. 

It is not clear to me whether default group requires counters. Separately, I do not see whether resctrl
can or should support the same ordering as what "mkdir" would have produced. If these are not actually
requirements then the patch is fine but the comments, documentation change, and changelog need to change
to match the code.

If the default group does require counters then we either need to change how groups
are added to rdt_all_groups or how resctrl_assign_cntrs_allrdtgrp() traverses the list.

> +		 */
> +		if (enable) {
> +			r->mon.mbm_assign_on_mkdir = true;
> +			resctrl_assign_cntrs_allrdtgrp();
> +		}
>  	}
>  
>  out_unlock:

Reinette
