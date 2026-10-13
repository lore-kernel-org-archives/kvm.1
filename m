Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C798C522699;
	Tue, 13 Oct 2026 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915829; cv=fail; b=mzLMwfo/C49aaIEBD482V7sPpGVEfF7/tu7cuh12ELi6CK3bCKvXZ2zNKnkDD3gTA0lLYLTWVht+7A9/hfICPBSOX7dHobparrjpHfQ4+dKwoG3oSxYq2ujJot8iFgFv65bu9u4efQiVfJHV4nP6it6R7simfVcIERylymRo5ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915829; c=relaxed/simple;
	bh=CQd0vb8+l5O0ob0kOhYmFyhuFeRhirKo1T5iDazzQtc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rcEXa/+0/Hxw26EeskDl2+1MzTqEnf1FPBKJ2KmAU3lX+91m7QWfXC3bF7dhGnF+zhW2MennXg+2oDL/6s7vXN8MLyVEPSP027fyBgvQ0325F5AA/vXRElM1lakU4kgDnX59ltf7wGkBXPdNgscX8uQYstImZ4sJQM5xcnbGuPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMz53XGa; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMz53XGa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791915826; x=1823451826;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CQd0vb8+l5O0ob0kOhYmFyhuFeRhirKo1T5iDazzQtc=;
  b=QMz53XGa297wAK+YZVKc+aIiR1vGIWIbamlBBh/EoTg6ekfvnE0B2IOZ
   RPd3CCWm998PYyGk65gYqZrd7UY6wQtblKEmy6ontHCdmF1Zm7l5uRZEE
   1SZjPT1lsd5JhOFAG47zTjyR3DT9VF7+4/KoElo0O+anzh7slvQRxFtXo
   O/meVOSuZZ9Tu/bwZDuTsKaiCs+fRik31tFUnl1cGv+GZnDyQSezbuTI4
   5DTB0fv4jB78C2JShwPatyNkrGnDo8Yw5nxfS6gXP7KII+vU8FGigRziP
   rtULOoSgGlp5lLt3jBdlCfZEpkYr2dempjkMHl5N4X1CLiuw7+FR0ki72
   g==;
X-CSE-ConnectionGUID: HTUexFZcQquQQ7/kwSMJuA==
X-CSE-MsgGUID: nBplXukJRhqlZovgK3Kebw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="753659"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="753659"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:22:19 -0700
X-CSE-ConnectionGUID: KuxE3ocmQFaiC7+XfQceyg==
X-CSE-MsgGUID: 8Vre9E+ORmOhvrg55Iuoag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1155923"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:22:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 11:22:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 11:22:18 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.69)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 11:22:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ta7wkTKbwqLyGs8G4W2L/OFEM9yUxAda9Fu2F/bq+sFUSXPQY6VkajJvPHtjLjM8zzOGlWjxmlTXKhXOFaRk4P5Ll0h9xIK393Ua7qocaFgfBWPdICacKPCuEJHiw/28ihv1vYadpcyStAoh/arQ+NQah/dfbQNvytlTDPGmgCbGrSLX0aP7CrDpBPEC2hg+CyHw6R4th4foXzW5qN6GhFbxkUG6MYSqI+4BpONPQghHFHxu71Dv2HquVpfdzbvXTm4ZXXGxnyMNoVjAKJ4VrMgpRm45LNMLQKbZmNVh5xOv6gazKDGyeZSCpsCKI6QCTrmwudsT+Y/umo8o00vRAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+Zn6uIr4XsOTS7zRQzhUzPKptFR/zuUHVM/AgMKRoc=;
 b=oZReJl6xKAk80HaJdAMLFrENsNUQAfjOMb7zsRoN1j2nPbjla7GOhfaEHW6pASwLkJMRwXkI/iGwWoQpsDHVZmExJGAZpAuqeu7HJ9GM2LJn3kaLvdI+h1xwHIRtSwD+z/Xb+l6OszqNpmH+mLTxAWZZOX80B56ouUqKSxUrt+h8ae0+lIpHKWYVUzT1fk9skb+T0s12ne1MwECCLuREJztIV/rcl5KSFyJmvKA62TELzUvsMFhxyyyOkH0bvqX+6bAbUm48Ev+28cO33V1Bu3T67s2Q8oazSFrcKARbq7pBHO6E1nI/UsbwIMBOXurI6+dcF1eMSWLfiZCkW/upIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 18:22:14 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 18:22:14 +0000
Message-ID: <4af177a1-7602-4b0a-a8ba-81575f1ec80f@intel.com>
Date: Tue, 13 Oct 2026 11:22:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] fs/resctrl: Assign counters to existing groups
 when enabling mbm_event
To: Babu Moger <babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
References: <cover.1791589412.git.babu.moger@amd.com>
 <3d966ae2e051ef54e1aedb1a2839c812ab880bcb.1791589412.git.babu.moger@amd.com>
 <f79c5f94-3c5e-4c64-9b6f-95f186e1bdd7@arm.com>
 <171f92a3-fa2e-44fb-b0d1-1250c72e31d1@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <171f92a3-fa2e-44fb-b0d1-1250c72e31d1@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::21) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|MN0PR11MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a02b6d8-037f-47f8-1a13-08df2956e7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|11063799006|56012099006|261009223027099003|4143699003|260925022911599003|260925021311599003|10067099003|260925021911599003|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: MDhuNnJzwVJTf3GIe8MK5dG7v3ytuhzUXPQ5SvnlE6QD6K4J2bNlnkU4eyBa4FLLTrOlbjannWOqPdSHOaLnbwlnOauQrbXBujOgE2/8WF9+DLQyRMYvf4e9qaxj1lc02bYlxZ+DX2BaHZZxzvN/3I1d2h9D6wpbsAPrtOhfTlNwM9DsbEfHKLYnMkKCgoOjj3UpTL/94QfCsaKma2yZqO2XvxTGJ3Dca/t6gc3cnZrGFQtS7MkQpcnAaf94A77nmcpM2UZdsnAtJBL5bjLkek3Xs//QTItLihIUp7Xzn5wq6gcfkkLcCph+9vpdsTnvDabTUiDykTUTw0kOvQxw/vWyL8ljiN7mci8YDkomTNVmQ2rh+TTd5krOGzL+d4w2bbr6P4a5sdUYpfY/cfB4QOyqaehHay5p/0mJa4ND8heAYtyhuKkrr7QQYqiw2/xFfGzA5vjO7KnaPu0IllsNrwD2ra3NOjFy2w0VqXNMkMRseou6EwieQlwAe3KVlCdplq0g+BkroRbLCGqm037yzIkh0yQbm77nvK/iP3Vt1uzPfy+lzmokTAZgzOOdOZoVZa82D4qvr3pB0dRr9KeXk+LhejFu5nuxwiBhhvQEuhw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(11063799006)(56012099006)(261009223027099003)(4143699003)(260925022911599003)(260925021311599003)(10067099003)(260925021911599003)(22082099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0R5RTh3S1BuT0xHZkp4bjBIcTlyY1R0REgrR2xidWhUSHEyUmordEJvckpp?=
 =?utf-8?B?OStraU95NW5zMFR0U3dYWTg1NjNCM1ArcFpUcTZhbzJwVGRlNGZwV2ZQejlW?=
 =?utf-8?B?VDNDOWZUZVBPRU9sb1l1WTVRd1pndWsrQ2JyMENlZkpQa3pQNWgvdURYNTlz?=
 =?utf-8?B?NENTSHY2TmVCbS83Q3RjdUs1a3NiUTVoRU5tUjBsc1Y4MTZ5MEhyRjAwL1Q0?=
 =?utf-8?B?bHdva2lNOVlSVHc0QjY0clF1eU01L2I3anhuVGp4dFZGeWJBYVBnOW14Ri9w?=
 =?utf-8?B?cHJBY2gxUmZ5VCtRaE1TaGpFOWk2MG1uM3RTV3RQRjNEY0dXREVIaHpzUHNW?=
 =?utf-8?B?a0N6QmozemlWM2RYaGZnOHNheHl1RTQwU2duc1lqZEg5TnZhMzFrRHh2M1Fp?=
 =?utf-8?B?R0pQbGdzNFBUOHFsQ0VDL1k5TStudE1MUzJDVlc1N1hEV1A1TXVKQWkyczBP?=
 =?utf-8?B?RnEreUR2QkpOYnM4Q1pZTmMrSnBDeDRBdXNyVFhTWjc5bXNPemJRMjFvRm1x?=
 =?utf-8?B?d0V6UytQVWVzWUljTjJOcGkwN0VmM2RmMkpHYUt1R1A4Qzd4cWJnUHFxcXZp?=
 =?utf-8?B?ZUtrellyQkZnYTRGMUEybEdRS21aMlZpZ2xLYkhzeW5ucmwrU0lDY2Z3VEl6?=
 =?utf-8?B?VUJnM3cwSDlZMWtEamFOYmxLQ2Y3L2dlY3A5Wit0Vzl5MC9LU3J1ZXJvQ0tQ?=
 =?utf-8?B?WGpyREdnbzluYnErZzZqeGhvVmh0TGVKSGxURG9QZTRpRFBGK0RFRmp6U3NP?=
 =?utf-8?B?K2tYRXlWVlo3TXI5aWpINElnNE40cUYrT0ZyUFdNdXkvNU9ETzdlNjJ4QlFG?=
 =?utf-8?B?cEpFL3RrM1ZHMTJVYlNna1d1NXJhWDNMN1BoMmNQeVYzM2JlTHRPQkkvNUFL?=
 =?utf-8?B?blZ0bjlSWkZ6anZxb25rUmhra1A1ZUVnL25FN05UNDAvOTFHVXNBVDFMdm1q?=
 =?utf-8?B?dkhBczhZd3BmanNOcEJ3cWc0aEx1NXlsNzFnTVQrUTI2M04yZzBDVThKRmln?=
 =?utf-8?B?dzE1Vk05ajljZ0wwcGhKR09lNXY1alJvSXVQNDZFUkZPMmdHazBhZWl0QTFX?=
 =?utf-8?B?b2pmd1g3OXIwekJkYmJPL09Yc0tjdEduYVlreU1RL3dZQ01IYWF6YmZ1aEMx?=
 =?utf-8?B?cm95bEV3cUUydzNFS29yZW56MVdITDJrd3gxZkFNazJ1eWtZU0pmM2p5NzVL?=
 =?utf-8?B?cy8wN0dwajkvWU56R1haUEhici9GWFliUDkxYW5CMS9Cakdzc3lFSVg2NHRj?=
 =?utf-8?B?QVAxMWp6ekQ1SWdCMDhJU3AvcFRiSWFUQ1RyNm9TeUp0TE9IZ1ZWNUM1N2JI?=
 =?utf-8?B?ZzJaN0ZSczJldTQwZmRLc3E1eUdONSsvMnF2c1Q0R0VvemNhcmVFeEhxMXYv?=
 =?utf-8?B?RXB4aDZLTmtsUnhUbURNSi9FSmxFSzdLVENQUHhhdzhEVkR2WGdBckg0Vkdu?=
 =?utf-8?B?V0J0TVRkUWNOL1lCVXFpcmw5WGoxSzV2TE0yQVlMdkhYNjBJRGFNNXQvTU0z?=
 =?utf-8?B?c0tlMFVHa3F0bFhzemNhUkx4Wm10dlFGZTRpQy9wYWMvSEhHSE5UcVJhYjYy?=
 =?utf-8?B?elQ5andwMkdiL3hJNHZCb3RKWkVCZzlhTkQxZG1kTnlmOGdDdzZ4aG1BNDYr?=
 =?utf-8?B?Y3ZiL2tvTlZxeTY1b3poWThNVkhaQkZLREkzV0xDSHBIbkNzSU9tUUQ1RTho?=
 =?utf-8?B?TXBvdzVxNXlDV1hFMUFGdS9UaFNIbnJwSlBSMHpIS21KL1YxNS8xN3BmOUVn?=
 =?utf-8?B?cWlpZGRWVG1lcGhsTDgxdzdJNVV2QU1TZ1YrQyt5MXVyaUVPMnNncERscnNT?=
 =?utf-8?B?akVlZ2NnSTAybTlkSGFwWmlEZVJ2ZGhyazhmZUR2V0VaaW1rMCtYc21tNHpQ?=
 =?utf-8?B?SE5FZXhnM0NYTTdhWTJTQUpnUmRhdks0Z2IvcEJiTmdJT2E0NFcrczcrY1p6?=
 =?utf-8?B?ZndIU1pXQU9Qd3p4NjQwWlJ1UW9rVDVWbk5Kai83dWgwYndod1RTamFIVmxr?=
 =?utf-8?B?RytxWGdQZGwxVzhGVm8vZzBvWHlPZzMwem54NmQwTW9UQmJIblB1QzJVVlVl?=
 =?utf-8?B?K05JUUV5UlBqSFdWNnp2M2l1Z0hwV1loVWhTcXlkRU8wNnFPR1BIVHB4OWgv?=
 =?utf-8?B?bnNrN1pNdWJ5YUkxekpBQk5reW1SaTZvd2phRk1NL1BSa0tzeGtsRW9lL096?=
 =?utf-8?B?dCtLL1VBTkNFOGk1WWJmdWxhYmNjNGIvR1VHTlp4MnMwVXlneDNvYzNuU3dv?=
 =?utf-8?B?Uk8xUlpkajhiK1pKdjRsS29aSitReUwySHNQcXpEY044Rnp5SEw4cFdTcWQ0?=
 =?utf-8?B?VUpYU1JpZUY4eUR0N1c2MllpNkhhQ29WemQ3RmZPM2cwWXRFY2Z1cG1YR2hO?=
 =?utf-8?Q?vwDrKEFiM1uJtBp4=3D?=
X-Exchange-RoutingPolicyChecked: o0J2l4csH+aRb2+at7lUqFpY07sintOxEy1rN85VBeh+g+2hBj61ZMqh+wtYiERX7a0smW1juuAd8eNgNOAztY20C4ApSptyE0CEs0ql7Cz1ehPL+oHpCoUj3TgfAns0Q/J5G7doCGdErz82fgfudncl6ph0NUl7AyCaRA8lR5VZrCj0UA05zzSm9V8S7Gt2mLG26aLDEbY5wIXxeehJWa13oqvz2yzvwR8SApevkdit0iWBaoOQ6RDYrEVSfbXcwC2iXEhwAb3Mob2X5Rbml9KngvArhMfsw1Tn409ij0Dx6PEScLOESv45+MyCXKXn5wDtPg2m6DmdZFvUJur0Rw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a02b6d8-037f-47f8-1a13-08df2956e7ef
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:22:14.6635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Osg5AuMcbgt97i6lKX53e+gU/H4adHUm7gdMKxR/iZBBOuNBckuXabj1IZnG3bjMmTl48B12pM27LY2YDAB4OzvurYBwgoVnezVdRMoi8L8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6011
X-OriginatorOrg: intel.com

Hi Babu,

On 10/13/26 9:51 AM, Babu Moger wrote:
> On 10/13/26 10:57, Ben Horgan wrote:
>> On 10/10/2026 00:44, Babu Moger wrote:
>>> When the user switches counter assignment mode by writing "mbm_event" to
>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_mode, resctrl frees all assignable
>>> counters, resets per-domain RMID state, and enables counter auto-assignment
>>> exposed to user space as mbm_assign_on_mkdir.
>>>
>>> Even though counter auto-assignment is enabled, groups that already exist
>>> at the time of the switch, including the default group created at mount,
>>> are not assigned a counter. All MBM events read "Unassigned" until the user
>>> assigns a counter by hand.
>>>
>>> Walk every existing CTRL_MON and its MON children after the reset and
>>> assign counters to their MBM events. Enabling "mbm_event" now leaves the
>>> same per-group state that auto-assignment would have produced. There may be
>>> fewer available counters than MBM events across the existing groups; in
>>> that case stop assignment when no counters remain. Events in the remaining
>>> groups read "Unassigned", matching the behavior of creating a group when no
>>> counters are available. Also revise the rdtgroup_assign_cntrs() function
>>> comments to account for the new callers.
>>>
>>> Fixes: 8004ea01cf63 ("fs/resctrl: Introduce the interface to switch between monitor modes")
>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>> Closes: https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>> v4: Changelog update (Reinette's input).
>>>      Function comment update for rdtgroup_assign_cntrs().
>>>
>>> v3: Changelog update.
>>>      Code comment cleanup.
>>>      Added Cc to stable.
>>>      Added Reported-by and Closes tags.
>>>
>>> v2: New patch.
>>>      This patch addresses the Sashiko comment about documentation issue where
>>>      counters are not assigned automatically when mode is switched to mbm_event.
>>>      https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614efe244.1784322818.git.babu.moger%40amd.com
>>>      In fact, it exposed a real issue. When switching to mbm_event mode, existing
>>>      monitoring groups should be assigned counters whenever counters are available.
>>>      This provides a smooth transition between modes and aligns the behavior with
>>>      the existing auto-assignment mechanism.
>>
>>
>> Given the name of the option is 'mbm_assign_on_mkdir' I expected the auto assignment to only occur
>> on the creation of ctrl groups or monitor groups. That's not my concern though. As you are now
>> treating this as more of a general auto assignment should the assignment also be done when a resctrl
>> domain is brought back online.
>>
>> For illustration on an MPAM model I see:
>>
>> /sys/fs/resctrl# cat mbm_L3_assignments
>> mbm_total_bytes:2=e;3=e
>>
>> # offline one domain
>> /sys/fs/resctrl# for i in $(seq 0 3); do echo 0 > /sys/devices/system/cpu/cpu$i/online; done
>> /sys/fs/resctrl# cat mbm_L3_assignments
>> mbm_total_bytes:3=e
>>
>> # bring the domain back online
>> /sys/fs/resctrl# cat mbm_L3_assignments
>> mbm_total_bytes:2=_;3=e # Would it be better, or worse, for auto-assignment to occur here?
>>
> Interesting.
> 
> We don't know the previous state. What if it looked like this before the CPU was taken offline?
> 
> /sys/fs/resctrl# cat mbm_L3_assignments
> mbm_total_bytes:2=_;3=e
> 
> In that case, forcing auto-assignment may not be the right thing to do.
> Since we don't know the previous state, we can only speculate.
> 
> It may be best to leave this decision to the user.
I think this raises an important point. To get a better idea I looked back at the original
bug report referenced by the "Closes:" tag and I do not think this is a relevant fix for
that bug.

Let me elaborate ...

The bug reported by Sashiko was in response to the patch that added a step to 
"Examples on working with mbm_assign_mode" to switch to mbm_event mode from default
mode. The rest of the example was not changed to accommodate the assign mode change
and the documentation thus reflected the state of a system that was in mbm_event mode when
the resource groups were created, not in the new default mode. 

In this new version of the series the documentation change looks different - it does
not imply that the system started out in default mode and thus does not imply any
mode under which those resource groups were created. 

I agree with your final statement "It may be best to leave this decision to the user.".
It is not possible for resctrl to know how user intends to assign counters. Why not just
leave them all unassigned when switching to mbm_event mode?

Reinette





