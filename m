Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3C356A37;
	Fri, 27 Mar 2026 03:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774580731; cv=fail; b=duTDnrKSjxwJEQC+gGhxXbdS8a1S/SMYAEw9dXYoKhgWb57Tnok/gizTCvl/CU5IJVc/IidJArSsS0M7F3a84IgeQBYJhe6YFHT33Ab9NbKQ/K1kwnC4JygDF2enmkWwYT68CmrwPWmBACD0cLEbFzIBjnnF0NT5iMIPqYox6WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774580731; c=relaxed/simple;
	bh=uFDTwpAVF52yRd4lAlLX7e1+vjN1Y7+ZyxJpbNURo10=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VkD0PhJd605zQRm7VgGFDtuJKJibxY/bc/NJKrsxwUehcLfQbfQ2qocu+h98B/09pKgxyHHXHmuMNZLbw1NCaifLhK0wSLXwZgV2fKylb4wNak2qMUzQqQzsMVwTmYzhVg53TC919JBhR7P2iWd3JKSF3IV+9LimUNrGoLhVwNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0jkzGQP; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0jkzGQP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774580729; x=1806116729;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uFDTwpAVF52yRd4lAlLX7e1+vjN1Y7+ZyxJpbNURo10=;
  b=F0jkzGQPfSsAjszJdOtCzfyUHqzMu3+kR2eEyTWtMWNMI1gm+Xz+F21V
   N2KVPGnZ61e3NG2zqfSDVJwcQsdHNb4IpXgGPz0GhT7ctfHr5Ubf6D4RI
   sJp6yaoUh+uZboP8MuRaZ5VVyOmI9tWtTD17Oxi8SsKODyNqWQyveHjuL
   yznAQ88LvbfMVX4qO9pIzaIt92IaUvYm0NKj7F+G0bpWbS8r8ug7z9p4z
   s3egAjocDZvABsqMRYTXKLI8dc8dh1qJ3HexUhHI4a4CTzAs5HB1CIA1W
   yEGkMysznf5nXKEmD7IFfrLd2C+fWn84uGytYDRq/TuJfZ1Si3cb6x0lm
   A==;
X-CSE-ConnectionGUID: 0far/93bSOujO3+NymdQWw==
X-CSE-MsgGUID: HjyeU2UtR12qGrIVDef4Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="63207436"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="63207436"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 20:05:28 -0700
X-CSE-ConnectionGUID: zEEkPzFYRKmyNqGzQ9CfWA==
X-CSE-MsgGUID: 90JXI9NkSKWWPjVJFEsWNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="229660547"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 20:05:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 20:05:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 20:05:26 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 20:05:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjdtsG52XIGgQyDUS1F5VWjLe8YbIqWcN9+uBlsqH9fornrmP2nBoSjjNN5tDVBmO9brvhasupNd5bUs7Ot+VJkrFcBcPo/739jh+ybXwcyuX1gWcwgaJegDEHpMUfRP1HrFqPmbAP7pfEGkBabqEd3yCCPkFOi2fRBr1bu3Ao7ehpr4EXkzyyIHXX9xP+tREf/qehICLWLCf+qs0qdWwvA5B6/f+LIc4tUYUkj5L3JXaYFg3FtYY83d4+nsbbI3HxF1de/M6QYxmluxs5Vc+qVf6eR78i/eWGf4A+RxhKFjOysRXE4Z80TfKBVb4lRueyyvy5GT2DFMHluFVzlE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ck7KaO5vpWyfPE0q7H98ASrCV4rXf598QbVBM7xa81w=;
 b=ke1H8yKMPUJZzE1J5NqS8xpiiF85Ho8lN4+iPGiXsEwqgiB52qFrUvtLbVfKg/dow043a49FMndfS0JUtBILhAJD4bnRyWqQ8x91tEOralkC+0hympMwpUMdqqm4fx5SeChUJVa1GGpQiPrGnecNZhuYjZAtM0WHpzfF/mOAEaBG6oyxGE2HRWBq3MtDLyQ8ldMLK3upgKxTazR3qPa9L1OOvU9W6EWWhGm3ov/CmR5RA4V+m8ReLMnPgIyL4Vm+4EyrcvMJrRpu/Z06EH966scZKN14Lvl5aZ64mZJ0/gdN1cEcgGxuV4Q64e6Qx7xAq8vz+KLCzAW8/qjk8CN0MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 BL1PR11MB5953.namprd11.prod.outlook.com (2603:10b6:208:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Fri, 27 Mar
 2026 03:05:23 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%7]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 03:05:22 +0000
Message-ID: <da98d671-eb7e-4e78-97b0-fedeb9d01f69@intel.com>
Date: Fri, 27 Mar 2026 11:05:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Bonzini, Paolo" <pbonzini@redhat.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
 <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
 <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0073.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::18) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|BL1PR11MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 09357592-43de-450c-cd2e-08de8badafa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: s+xabrUsG3WB6A5GvrEmWBeFM9IBJsQHRi/DFUAALOaikwCD7Zca4kXygi3wa9qFxaYDSlNUKdFhhyRmzD+Rq8Bs4FFQik5jjfb7kJzdnmpn6b0KdMf3bYOLUquHTQgCC4i2hGO0QI05kKj6HcP9I0mG001W+4532SQFt1FBnU1Hqne9tYkJyjPYE65JiIUUfO3t4wEVUxGmc4zZlG/nL73cZ5jE7nDLgg9FKSGKZq3WlxEi72eMoG4SwFGrfqr65EG15K+P39qkRhHbMlO2RB/8uh/mOksGif6gRQvSwt/zOFpp+RD9ekNEdXjua3Va/CP7EfbpvRzMxvjwPZmMWRLAs5UGiCB2/tkDeA3iavExEPhjHlVrsaNnFMTzzg+ljdwYwDxbnjnu7+XpAPjjYLxY3DNK4MOTa/Zk4RAAV5XAGDaZ1F9PIQ9AkcqV00zZJ/fRdxaR5bQeV68S7JzvI3WF6kcxd+as9G6Qz/9E/f6ZaWeXlNE77W3hMILxUcYWHxD653DptrFD926vJogmFC24DQz8OD/+zZgoDFBI9kTk0jT6zknC5/nOTYeM314jlpaOrs8/GDD4eaH8a+OToajoNUP4jUZXhG6+FxXiAyXZBu1MD+YTyGVYB0QPnOMJsOw4Z52W2vYpKUZAkSKKA+hDEY4/m+OQbL/56jkdbD3vD53wu9MDqSAlfN6lzeHGWdljOPIXpIJls7tI5wHtYw+zfJxK8PDaEPn1KLTu50s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHpEclkrVWMyZHRJZ29HWDFUUSt2V3FkQzY1ZVNkUU5lUzVVOE5HdVRpRVpY?=
 =?utf-8?B?Mlo5TTBuZ1p0bDVLRXE1UmFjaE1obkFOenBWaUpGazVzUEJLNFRqZXJNRDlz?=
 =?utf-8?B?aWVKVFdjZ28zRGdXOUhISUtrQzZOanhWdEhGVkJlNTZodVkwT1VEb01HQ3Bm?=
 =?utf-8?B?YWR0SWtlV09xN0xQRzJHN01ic3ZMOHpLcnBmaEpIb2F1UTJ4azQ5UnhNRUQr?=
 =?utf-8?B?ZkMzRGV2OGljMDIyaE41cWZaSVEyM0wyN0RnM29XYTJwU3V4KzF0WldoSC9B?=
 =?utf-8?B?QlM3dXpVK0VaOFRHZjkwL3VqQmMwL0tHTFlYSXZmRWpFU1BXRUtzakVJWnF0?=
 =?utf-8?B?bmc2QzFwODZTOXlTZmdmN2R5Si9aOTgxVGp2bkxHbHYySDBjOG1hWFdDY2JG?=
 =?utf-8?B?bWNXS2Q4UUFrQ0dna2RzS3RVdndZamxrZ0Y3RjNNUGNMR3BTOXVleWltVG1w?=
 =?utf-8?B?ZmZObjFra25rd0tNS0k2Y0dSMDdVd3FicEZsNUUzR3E5ZDBnZjl2NUs3b09r?=
 =?utf-8?B?Z0lsY2NPU3RlN1hkZWNZdmhseFJPYTZLSGNLemUzS2puYXllMFdHUURmSExm?=
 =?utf-8?B?bElTb0xSclFRRGVBNndHa3NZQktGZ20xYUtyeVdMZnhLdWZGNlM4VFpNRFMv?=
 =?utf-8?B?b3NFdVp4UnoyWGhVUEJLRnpNYXZLZ25HcjdPVDhySVdqd3QrYkZsUERYZ0Vp?=
 =?utf-8?B?MVlBZVJTUTNJSWpCQ0hPOUtWQWF2alh0cnk3MWRCQ1RyV2J3NGx2bzlrUFlu?=
 =?utf-8?B?em80NUNNRlRrSUNKSDNxYzA1WVJ5Y3FBanlOV2M1NEVRK09sSG90cVJROG12?=
 =?utf-8?B?MkxYM0crOXBsUlZORTJDRTRXV0prNCtMMlNMckhPM3NiQXk0TmRCMi9ESWVm?=
 =?utf-8?B?SkVDcSt5NG5ieGxuVEhldXY3R0hhbVpOS3QvTkdXUFd0aDFoaTJGK1hQQWtW?=
 =?utf-8?B?OHFrYVk1THNLK05jcDhuS2ZQckUrRVo5SDgrRTF3cnhNQnlsdnFRL1NVVVBB?=
 =?utf-8?B?WHhJVmI2Nk1NakpMd1I1ZStVVXdpUHgrZGVYMEZQNTNHVEI5anl4ZFlhbFFq?=
 =?utf-8?B?aysvdmczNFlMOFA3V2Vvd1l1VTlYQjVraTl4cEdPRHEvMUhoTmM0Z0hVVFhV?=
 =?utf-8?B?TUI2Z1JaTlBjRkJoQkZLN09zODZ1RmVxdUxyV1ZtdVFuY1llTHh4KzRxbmNh?=
 =?utf-8?B?RVdySVZkS1lpdmMrYUJBWDJqTDJmeGNGMElGVGRUVlBSRHBQdG9oNjhmYXVQ?=
 =?utf-8?B?WDNqSzdkbDhWQk1iKzVxeUNya3Vqb0Y2RHJ1SGhjdlh3a01hbVgzcTlLVGJL?=
 =?utf-8?B?Ky9JQjZXOGdhL1hvOFVKVVBBSmdpdzVPWlovNWc5TGI1YnQzQUsxdTAvcjNI?=
 =?utf-8?B?OEVUek9WS1VObzMxUTduVldHby9URmw3U1pPK3poazBVSGNOWC94M1FKS2tX?=
 =?utf-8?B?bnlnR1dSclBYbWFOeWxzQ0o5UjV3bG9DaC9yR0U1UWlPSWlVdDNERTFDNlJR?=
 =?utf-8?B?eUNNRHI3V2hmM0VFcVNGczJ2aWliWWJPVmdZYkd4QncxWWFIbGlFU05jS09j?=
 =?utf-8?B?bEw1Y2UyL2ZtUEpJRmhYM3ZldmcwZ1pNNWNiZWtOV0pLVjlwZnNLQ2F5OFBQ?=
 =?utf-8?B?OWdtWDBtZDFBZCtyMTZZY0x5cEtlZlJCbEpOdWFXUkhpbDNUeXZldlNyVm94?=
 =?utf-8?B?b24wSXRQQk9FNTAzZG4xNGVQVHVFTWxNd3d1TmFkZGZwM01IeDRXd1hkK1RH?=
 =?utf-8?B?N0daV3dOSHZ3NTcwWDZMOGliZVUraC9MM0p2T29FaW1idUszc3FtNUlMZVNr?=
 =?utf-8?B?THRqd3hVSjBLVmUrNEFMbjQ4UlBUTW5sWmxXd3hacjBEbUxGaXVycDZpZ3d5?=
 =?utf-8?B?c25NYmpIQ3V0bThaK1picmhOdTlGcFR0UzJ6L1FYVjNoYkg0V3ZKWXVzQm5r?=
 =?utf-8?B?dTgvYUV6ZHJNWllFVzFHSW1ac1VyQU56RGsrd2hvTk1wMXR6cmg2RHVQV2Rh?=
 =?utf-8?B?aEU4K0h0UWtZMXNrdStDRXFydU9zMG5aNituNzNSSFRVbGpJVUc1R3gvcUE1?=
 =?utf-8?B?Z0wzNHM3aUZNakx4Uzg3TU5BcHZwUEUycnFMemFDUm1odXJIeUJZWjhMOEdE?=
 =?utf-8?B?Ymp5VXhmNnY0MVJLcFc3VW1SN0xERjhqVytmSFRDRDhsdURkc21rbEd3WFIr?=
 =?utf-8?B?U3Z2TEVtNVVuZklKT1dpVzJmaEdVazBIRzE0b3YrREpiRmdXSXBmWDdIQ0Vw?=
 =?utf-8?B?MTh3M29lOFZSSHhueDZvVU5ZSjRLTVhYZGdvTmY3RUNLRmF4ZE1TS1dNSDdR?=
 =?utf-8?B?c0RnUFZEM0xDNFA0eG03NmZ4THNhZ0tYaElJLzkvZTF2QWc3ZHladz09?=
X-Exchange-RoutingPolicyChecked: r0NnC1UTg11ig626dkM05CaJIVpkYaOROPNWcuywUdasMTML3VUMeEzA+jvjs/WvsNiLxkc+1oh5wyaXpjjBEq2enkt2zjQyrbXtMaKrgNyY21xWFsVcDCkYdnoOxIjkIw6pqfJHEX/Xc7hackLVXNYRKmRMBHd9nPQjbU9o5NUSCWi230vAX2R5mUwftArMqonUTb1eg2DFvP6Gnz4cT70Bey96FwapOKdIyb4RpX5S7J5689AVcXNj1fInWkUSNGmbjRGlpJZCBMgS76DujZyc+qlRGfPNfcNCdTSWdCJ9J+3PVY5S+JPxCMOlsNf0HLSoiZE9yx2a52srbx/PHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 09357592-43de-450c-cd2e-08de8badafa8
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 03:05:22.9031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBYZkELc7bAAAOom0sTxcIKYhNjTpUDSdsS3Q0N2JYk3xr0Jy30PNfuHJqcyeOznZiXg3O2XaON9/ofBuPYvYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5953
X-OriginatorOrg: intel.com



On 3/25/2026 6:29 PM, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Mar 25, 2026 at 2:04 AM Edgecombe, Rick P
> <rick.p.edgecombe@intel.com> wrote:
>>
>> On Tue, 2026-03-24 at 19:21 +0400, Marc-André Lureau wrote:
>>> In TDX guests, hotplugged memory (e.g., via virtio-mem) is never
>>> accepted before use. The first access triggers a fatal "SEPT entry in
>>> PENDING state" EPT violation and KVM terminates the guest.
>>>
>>> Fix this by registering a MEM_GOING_ONLINE memory hotplug notifier that
>>> calls tdx_accept_memory() for the range being onlined.
>>>
>>> The notifier returns NOTIFY_BAD on acceptance failure, preventing the
>>> memory from going online.
>>
>> Does this depend on patch 1 somehow?
> 
> Yes, if I plug, unplug and plug again I get this without PATCH 1:
> [root@rhel10-server ~]# [ 5707.392231] virtio_mem virtio5: plugged
> size: 0x80000000
> [ 5707.395583] virtio_mem virtio5: requested size: 0x0
> 
> [root@rhel10-server ~]# [ 5714.648501] virtio_mem virtio5: plugged
> size: 0x2e00000
> [ 5714.651808] virtio_mem virtio5: requested size: 0x80000000
> [ 5714.676296] tdx: Failed to accept memory [0x108000000, 0x110000000)
> [ 5714.683980] tdx: Failed to accept memory [0x110000000, 0x118000000)
> [ 5714.686997] tdx: Failed to accept memory [0x140000000, 0x148000000)
> [ 5714.689989] tdx: Failed to accept memory [0x128000000, 0x130000000)
> [ 5714.694981] tdx: Failed to accept memory [0x148000000, 0x150000000)
> [ 5714.704064] tdx: Failed to accept memory [0x138000000, 0x140000000)
> [ 5714.710144] tdx: Failed to accept memory [0x118000000, 0x120000000)
> [ 5714.722532] tdx: Failed to accept memory [0x130000000, 0x138000000)
> 
> My understanding is that QEMU should eventually unplug the memory and
> PUNCH_HOLE then KVM should TDH.MEM.PAGE.REMOVE, but that doesn't seem
> to happen. 

I guess it doesn't happen because virtio-mem in QEMU only PUNCH_HOLE the
shared memory by ram_block_discard_range() but it doesn't touch the private
memory which should be discarded by ram_block_discard_guest_memfd_range().

Is this strictly required? According to the specification,
> it may not be.
> 
> 

