Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2643EC808;
	Tue,  6 Oct 2026 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309102; cv=fail; b=H8NhqSskKTkdk7TDcWUBWD7m8+wzJeXIYF3RGLS0KeVoVdNLZLLg2R68R/19cDSAV5D3ZtU+GobpBkrTyOWu0UZ3/M46q2/v9qfZd7tNM7LVUnVolVfZmXejG8kjsRouOtWexzOshpteUdgfdecN7S97QOYIYGhJTPm9ZrCMMcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309102; c=relaxed/simple;
	bh=fHmkopuq5xaAA/90GQrBJ1rEIsUeFaIJ3kRk1zWkdSE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fqbaQyJk8xh0eqo+oM6sqVg6dhLTjq4KZkaBDU3cWDGcXXTaiP8LFkyi01qhaldmO1qSLv9PoRmVrbGOa9x24BOcoayawcSbVJLrCpkmv14uNhdVC7jROqLOJ5Y8vSBquINbTszDCXmNT8ikz/WpkeOTLcGUAi03mo1m93+HntM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GahLtUIf; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GahLtUIf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791309097; x=1822845097;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fHmkopuq5xaAA/90GQrBJ1rEIsUeFaIJ3kRk1zWkdSE=;
  b=GahLtUIfe/d+8MRNkoKrBG+qLWDrP5OVPnnVSp0tCEWXxm2HYpskslPm
   yQLcs3N824mzAW3RZ9nypbdJ5xZd6IXz8FZdsjM7jDLkIxKNcLNyAJ3Rh
   MYPtcfFTIEKMXUx99ZuJXcUa61fBm2Hmn2SRGX6lfiSqKHICxKToNQRVd
   CGiTffTF/7E6XWvUvPcpcPnPPc3eYWeCP5GLpA8uBy58WlQ27VV52EmCN
   7UcIR0w2At76qA52eV8/3YwLoN+xcWwID57EhjNVDJHm1nB93ju3ndTpD
   QFS7fvtBFDKlxBmBO3VMrbPaPo1qr++2sl1yKgYftYuHoYEGBbgQPzoec
   w==;
X-CSE-ConnectionGUID: ri8kcnQiSN2W+uTgxWgPPg==
X-CSE-MsgGUID: TTsyuxfYSzGXT5Byu+Lccg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="161937"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="161937"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 10:51:28 -0700
X-CSE-ConnectionGUID: lvrfyERTTz2WgrBuoj0Vzw==
X-CSE-MsgGUID: ODx/mL6hS5iCMWEpFKAp7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="277351606"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 10:51:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 10:51:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 10:51:26 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 10:51:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDaCMFpw9+XvXsc8bjN+CIaoQjSOutwUBBFaEn8VQmsgQyjBtTAzWPz4MKniXttk63hC3iwwMGWED18VCMwfwV3csesPYZoDookG/2RPWsIONg1Ta4+zF7+tEUzIQTL8yExWhP7PKoh1sAJBQ8d6f4g2WI0jPjoJ8mGmTe+dIoH6VvehNPQJzTtD+R44/98aHFrJR5UZn7OOPaeGQOTvAEeFcTk9ZeGmIGPMAzoTux+IJyB8fsrV80re6z0sDR48rtKHIq/FAYjNMz/HOib4SWvytKFPtoMDK+xLVWFrFeCBnWh9H6vEbi9jLmZGVSLoJIAdC9v8ckSjD2f/YOAXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzRBdXrC+fJsBhYQ5ADiy8pLxvZwQBFFg7/xjs1MWVI=;
 b=JpFZxDjh30/XRE5A2Z4SsNMO0S1j5AqR/xtSxn5iM83pVSbxixqOJQ9FwMWvSBz8QXQpGkZV0MrMqr2JDbyxp033d0iUo8ZAUZhoTqjpIVa9oGazo4LyR+AwYljj+sZ/OMP/K/mkW2cv6O2Gz0zngdKXES7WNtlh9xgXtW62seYAaDf837fOmDGRmD0lXZT4GvIiolh1UW3afF/SSnLd8aWlUgOOlbZBbqP4e+YYK2XyTno6JUrxruEd0NyXfgxahYDARTlaWcxWPdgXaPsM0s9Q2g6TgeLJrElsk/uZokYXeroRKAJFaBM3mT3VnGG4+3NY21VUK9kCgEJDOpEI3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8379.namprd11.prod.outlook.com (2603:10b6:208:488::20)
 by PH0PR11MB5111.namprd11.prod.outlook.com (2603:10b6:510:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 17:51:22 +0000
Received: from IA0PR11MB8379.namprd11.prod.outlook.com
 ([fe80::549f:e4b3:e10d:aaa6]) by IA0PR11MB8379.namprd11.prod.outlook.com
 ([fe80::549f:e4b3:e10d:aaa6%6]) with mapi id 15.21.0451.024; Tue, 6 Oct 2026
 17:51:22 +0000
Message-ID: <4afdd80e-45cd-4d42-b871-fb25e1fd5fa9@intel.com>
Date: Tue, 6 Oct 2026 10:51:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] fs/resctrl: Assign counters to existing groups
 when enabling mbm_event
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
References: <cover.1790976400.git.babu.moger@amd.com>
 <09f0e27da685476211c43fa8ed85b49646305078.1790976400.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <09f0e27da685476211c43fa8ed85b49646305078.1790976400.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0271.namprd04.prod.outlook.com
 (2603:10b6:303:89::6) To IA0PR11MB8379.namprd11.prod.outlook.com
 (2603:10b6:208:488::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8379:EE_|PH0PR11MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ed3a95-2cdb-4a76-8510-08df23d26efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|11063799006|56012099006|4143699003|260925021311599003|260925022911599003|260925021911599003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: UGu5UXOdWHf3IUuS7qBsyPT/oSBqRnlHtq010NlI+sTVAoKO2maIm+ZBZZP8CLWHe74qecykkrmsmKpBLQwreJlPzSauOu3MUIXTRKpfz2OBTj6QMgqwtXlTAdY/M6e6yoZwpJgq0InY3fI0cVA2nA2cMwAqob404/3bLCzVZZOgFVGI6vrDQwiXamwSpp8BVLbjqlQ8CI66duq31lR+KEv3MTH+yuHVEpiNnaKPe9APp7wK7gqYxqyoKJRgIqTYg9AdbHwWx79Nk5RjVxFWcsNZTSr2lWDoICMjT4N4XWYeuS2WUKiI4yQhH4WowtbYhg4O+WGuHswPlfR8T2ujt6Jy1lm42jV1Z5200WH/ScLGGEN5JXsbWd+0G4sy30FJYL3VFJDwyMev3CFvmbdFN0fDFE8iZONIg8BQu61iyGRX5TMBkH3GqK+3g0RHVx7ueL0fEGn0a+z4mwneY8vwHJQkKRaLxbSWSHCvu6UqppeL9iw1Z8N+oGdgA+KpaNLpKtADGihII5805yvAEf1cK/YeimfutWsuzEt/etFxm/eTyYIlgvcJAiiSBkGEBxNuERx3eTbEyLekK6djwnxYfQFTr5VTm8Lfv7ZH8fZYAKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8379.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWQ4Z2FyMlBIRTNIc3dNTVJnSnNENHBXV0ErOFRIZ3krUjZhb1o3eDljeHFr?=
 =?utf-8?B?d1g3dUpmOGlPTXFMYUVabzNhcTVaVE1JbDBWTlg2VDJlRm5NWU85U0VsaTM1?=
 =?utf-8?B?aTBjbW5kakNJSERTOHI3NzV2bXEyZWcrNTA1aE5tdVN0TTRZSFNKU3k5VHNu?=
 =?utf-8?B?d0JtU29vT1hhUlBJRERRVnBWbzRSTHZkRlpPZWpiRFZacXhmeTFYLzE2V2dU?=
 =?utf-8?B?b1M1UFFNSDFKUURYcks1TzZDdmNSWlUrL0RkbSsrUkpQTzI5MXdaOE9CQU5i?=
 =?utf-8?B?d2dzMUVSL2ZWYVRMUW1LMFZyazZoWEVIdjZRVmo4UjFhUDBFdGtqWkIwTFhl?=
 =?utf-8?B?R1ZjbHNZSDB3VXZkUEsyUm1ReVd0QnhUN1hoYWtBdEZnMFlPNHlQTlRiVWdX?=
 =?utf-8?B?Wi81dk1pZmtpYXM0eklQSU05RWZtdU9mbmtGLytiTWk0a3UzaG5sVzV2eGxE?=
 =?utf-8?B?cGNEdVdqT3NHMGFXbC9yTDdLWDBJWUR3OUVpa0hLZG94bTRHVU9tMkdpL2RY?=
 =?utf-8?B?T2twbjVNVUUvd28xd2IvZmlXNFVkL2pyY1VqNjQzdnFWcjJ6MlErTWNZbURJ?=
 =?utf-8?B?cEtmYVdwSmdGTzNTV0M1SlEyUUFkT2RHNEJHQjhMbEU5bjVsY21YTzBJYi9F?=
 =?utf-8?B?Q0Fuejl1cVpkMStjc1BZVkdwL1dPMy9qVTRCbUM2STdGMW9JaHMrL0xMK0Ni?=
 =?utf-8?B?UnhhbWdCeE5GbytDMlJ4L2JvbFlMcCtSTlFQMU1TNGQ5U1hSWmJNUFZXa3Fn?=
 =?utf-8?B?TTVzdSttZjZwa0tqbk56aXJ5NWRjRG9BZXNVRUIwQktPeHdTbEZrcjNUcDFl?=
 =?utf-8?B?aEVjaUVOUGlmeHorUllqMXdMRXpNbUZYSWxmY2pJRUo2TVNpeXE1V0J5bTdm?=
 =?utf-8?B?dW45SUhuaXpYdWdyRkRWQU1SMEh2VGM4SjZTYjFnRGdKUlR1cFhCRElwd3Fp?=
 =?utf-8?B?MFFQcEJBUUpLWUNFbm9kditFUlhOVXQ3UmZScXJnSlVkUDlwU0IxaS9mTWtw?=
 =?utf-8?B?NXIwbXZ5c0lFTXdSZ1FXSjVwOUJ1ZlVFTm1SWVRWZmJkTnoydlpnaWNLM1Qv?=
 =?utf-8?B?N3M1YnhqYkhkY0ZWZjRoa3FzZEhMdWxscHBlU1IwTDJEVWNNSzdXdXBxN2hz?=
 =?utf-8?B?aXhvcFNhR0lXdC9aS203Q3ZSWGpsRlhyblZVSEcwNVJROE9SZ21xdUZZS2ZB?=
 =?utf-8?B?R1grSW4ySGREY2FNeldEekViaU9aa2JpZEl2djBkRjlJL2JuRHVrWjlFa0d3?=
 =?utf-8?B?bEJVZmRlN2RoYWpDWVVNRjY2WFpySWxFazZDUGlFMVpWM0ovZmZ3SWdMZ1Uz?=
 =?utf-8?B?bDBYT2dWVmFMNDVDR1I0SzhSRmJRMy9pcXZSNENuS1BkNDRON0pJOEU3bUJI?=
 =?utf-8?B?Nm5KYWlsVENvR2ZRS3d1ZWI3NHRJekFSc3dzNks2RVoybVF6NVhrclgwVTZF?=
 =?utf-8?B?NEg5U2luS1ZYV0FaS2tiZ3Zjd3E1aGs5SUxLMjBSdGVBLzVwRklwTlRBd1R2?=
 =?utf-8?B?VkgrUlZrZ29Ja1kzZ1p0SGRqOGxZTEQ3TDJLbUEvRy9lMmdzVjhLWjFxYmZV?=
 =?utf-8?B?UXZCZzZQSlVMb1RFbzEyaS9vb0RvTm5WeUdwbVRJNlEra3JRRmJwSXNnUndR?=
 =?utf-8?B?akJvZTRiSWFtWTl1eExCSG5JSk1OanZRVmx1MjhVUjlxVms5L21ZRDFVOUVO?=
 =?utf-8?B?Q3M3V3FEMElZMDVNelRtcFdqK0ZmS2NndUhzbjEvdy9DVm96dUxBa2YxWkxF?=
 =?utf-8?B?Y1ZxOFVQVk4wVjNMREFpWHN1N1BYOVNkZWQ4RU5BUWpEcFd0QnpMK1JTemxz?=
 =?utf-8?B?Yms1ei85Vm5VSytJSGpkOE9IWFFGYnpsNFNCc1oxdTF5NnE3UGxYN3hocmdX?=
 =?utf-8?B?VStsMHpvUGtrUVV1clBDV09Yc2ZUd043K1NkWFU2d21WN1ppb3cyekRGZGdG?=
 =?utf-8?B?UFU2SmlUeGxubUh4K2hNUzJSQXlaa1hDNmp6Mlp3ZmpKdHFpSmhSaVJWL1U4?=
 =?utf-8?B?MUh2bEFEdHc5SU0wZXhzQ2Zkd2ZWM3hLN2tuV003dmZrT0pUcTJyYW5RNCtk?=
 =?utf-8?B?SjYzSktHL0k4N2tRbGN6bDJlRkNzTjMwUVVhQ0d3ODI1NkZUZTQ4cG1GSzcz?=
 =?utf-8?B?SkZiSnBLZ0ZlYm5KWUd4RXRicFlQMWYwT3E0K3Vpb1ZyYmhpOWRoRUQwZVIv?=
 =?utf-8?B?Y0MzaUlPc1QwenpSenVWS1BJMHdHamxFQW44d1ZzZDBuNnh5Y3d6RTc5N2t4?=
 =?utf-8?B?TFlLdXExUzlxQjBVS0VQNWgzVlRkZmR6eWtpcXh6MnpiN3F6anQwcWZVUWhU?=
 =?utf-8?B?SVRKdm9aWXdObDJxamJRNk1lYThqOWNVbHJyb3VMZHVYenFJWWtXTjhQNHl2?=
 =?utf-8?Q?DAEUFxkSj70TOgcQ=3D?=
X-Exchange-RoutingPolicyChecked: eMPxTnPfeNPi/OKmGty7wMVJM174+h19YIRWGLK1JeRy/R9gfdteM1er0eYsFqhkFAGvjA4Xjbf9cp8VRAWYXJ5Aay67opP3NrqhYpZVmomSvpB2vhLCH4jllMPAJSK8y6ZNZhDlsFYZmatxn2rfLIrTTkcJ727f+0MsDd75z97cvNV/J7MygfKzqNMz5nKkxwRZ5ZlyNELEv0SybNxnSz7vy9sabuiXFt1wQ8KPNKz7KPbYE6vuMWHpPqfwPZuhB1tGKlahvYeHFpuynV7EZDmDT3hPkbMSJtIGQWzQ5tKF6TasvEuIXhYwrIuu2UBLioG5iI2rqHMu5Lvy93CEPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ed3a95-2cdb-4a76-8510-08df23d26efe
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8379.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 17:51:22.4144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GHkAaFOIIiUUtLddMG7gUedQia9F1h0sUkoBDGVvuXX5uvnZd5hykCy8dSc7sSUu9+IKyO/8VYNXvt9LBvUe8WfyqwAY3GSS2E23Upn+4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5111
X-OriginatorOrg: intel.com

Hi Babu,

On 10/2/26 2:26 PM, Babu Moger wrote:
> When the user enables counter assignment mode by writing "mbm_event"
> to /sys/fs/resctrl/info/L3_MON/mbm_assign_mode, resctrl resets all
> monitoring state and sets mbm_assign_on_mkdir for subsequent mkdir, but
> does not assign counters to groups that already exist, including the
> default group created at mount. The counters of those groups return
> "Unassigned" until the user assigns counters by hand.

Above summarizes the context and then below follows with the change,
what makes this deserve a "Fixes:" tag? What is the issue needing fixing?


Consider, for example:

      When the user switches counter assignment mode by writing
      "mbm_event" to /sys/fs/resctrl/info/L3_MON/mbm_assign_mode,
      resctrl frees all assignable counters, resets per-domain RMID
      state, and enables counter auto-assignment exposed to user space
      as mbm_assign_on_mkdir.

      Even though counter auto-assignment is enabled, groups that
      already exist at the time of the switch, including the default
      group created at mount, are not assigned a counter. All MBM
      events read "Unassigned" until the user assigns a counter by hand.

      Walk every existing CTRL_MON and its MON children after the reset
      and assign counters to their MBM events. Enabling "mbm_event" now
      leaves the same per-group state that auto-assignment would have
      produced. There may be fewer available counters than MBM events
      across the existing groups; in that case stop assignment when no
      counters remain. Events in the remaining groups read "Unassigned",
      matching the behavior of creating a group when no counters are
      available.

> 
> Enable mbm_assign_on_mkdir and assign counters, while there are some
> available, to existing CTRL_MON and MON groups so the switch matches
> mkdir auto-assignment. An event left without a counter reads
> "Unassigned".
> 
> Fixes: 8004ea01cf63 ("fs/resctrl: Introduce the interface to switch between monitor modes")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
> Cc: stable@vger.kernel.org

tip tag order places "Cc:" after author's SoB.

> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---


> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index 73413cb128ea..fca0734bf346 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -1300,8 +1300,7 @@ static int rdtgroup_assign_cntr_event(struct rdt_l3_mon_domain *d, struct rdtgro
>  }
>  
>  /*
> - * rdtgroup_assign_cntrs() - Assign counters to MBM events. Called when
> - *			     a new group is created.
> + * rdtgroup_assign_cntrs() - Assign counters to MBM events.

This patch adds another caller of rdtgroup_assign_cntrs() and above thus correctly
updates the function comments to not just mention the original caller ...

>   *
>   * Each group can accommodate two counters per domain: one for the total
>   * event and one for the local event. Assignments may fail due to the limited

... but the detailed function comments trimmed here still considers original
caller as the only use case and uses original caller to justify why it does not
need to return an error. 

Reinette
