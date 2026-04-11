Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8DA8C1F;
	Sat, 11 Apr 2026 02:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775873018; cv=fail; b=G7Meb6lllOT+VEMNwztcgHC28EbeuHDdgxnvfrV5s61KtQAnw4ofZ0Lk9Lat3Kjc3/DaD/xIuSCRMrIX7nOfeMjpkKAUB2TWoeuT4aSefCpf/WM0d2nTrwT2NRiDYrZBEcoQekm6/Nz6CyKC7Aml+ahe2vWC4Ej5oclyCgnnlUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775873018; c=relaxed/simple;
	bh=j/JEOKIBTnVbYoLjWbWdfA2CwvfCOX8NaSdJCLxrcBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HaRp92kDiCn0k7lRRLOZF3heRJ8GH8pgSX+SyLrf7kyEoAdbsiAyEEphQnrsk7fwRid7IXNvzkprmrWX/qljKiGhbWxpX5zO8TD/JOjfYYrICFhSVv0UcJ4KYp4vJPVaBmnuQwi3YrKrAmV0ml3ApCYsV8cDY+54LtvBkNj6gAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekZtUNZf; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekZtUNZf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775873016; x=1807409016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=j/JEOKIBTnVbYoLjWbWdfA2CwvfCOX8NaSdJCLxrcBs=;
  b=ekZtUNZf4qsjiINXJLJOzxrpAvAYKbBQFHc8ANCfkv0HlHYXTbWvetcY
   yQU99wNhlWAVjdr3naM+WrdxQ2xQm9kJsbUZ7m3ENA9SkCfoRN/b8Y+Mq
   pa6qWSJqNBttaUmGcFBTKiVzqae8gMqn35nyBEKCyhL4bf4OWdVLrhj1g
   C5obsBAqR9z/C/1294AHBdyuIqcTY+G7eP8azBAPwyo9jemb3eluYY5S8
   LN8VWMR3Ke06V7rbP++uo2Gagtf+wiz7ZLnbQD984cvG4zvo8UvF+kJsx
   mZHybOJjMNc25bgawlN/6FnurF5vMg7NBxE4ekFQ1qiHvNNtOkuzWFEtY
   g==;
X-CSE-ConnectionGUID: QOPnO8JBQbORZOCXs7QOvA==
X-CSE-MsgGUID: 5fQ262XKR36Mh1MRjL9zhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="102353753"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="102353753"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 19:03:36 -0700
X-CSE-ConnectionGUID: g4QY4RNfTKSjrihXnl2TXg==
X-CSE-MsgGUID: I929TynESBiDglV7hsADFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="228224825"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 19:03:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 19:03:35 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 19:03:35 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.21) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 19:03:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBTaoLm5lzFxwQvZF0jdAZ6bX62kqh6Z+8dQrKGRRRN+gqJVWPbKTsfMpZnTZHmWr0zd+AFJTOZc6JRwkqlDAIbuFkPl2VqDLpQ+5Ckv9d2w7KaiTCyUgKTzELkmWRc4Bni5bCNJ/P35XMhW+rWSmYganGaQscnErWv31QaxG9Xc7K2PU2J6zJWKQTmNb2AqWuapUV/WawpNRTTDuXg4QAoEB9LWoEifMnQs+W7DraZu0nNssn9gYdkYvSC9CU6gM1KyPuz9P78jlxhlZM5/tDrAwLZr8QtJx4JmQRTwMk/drhPzpb3Z8xbypGdvHGCXQJr/M+CyU+gcrW74hM72VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/JEOKIBTnVbYoLjWbWdfA2CwvfCOX8NaSdJCLxrcBs=;
 b=M7Y/LfJM8C92qUXOw90Gs3TwPsHg4Y/TOCfHamlxNpkoI6zuWh+DSQ6MOlL07yktzGJG1bQquQFH6ZMCwkU2tgCx+23XLLIsVIeuUyPfC9NPD+YGPzfaXv/aOEhZ0sp4fw4UAkckopweLN1MLduBqSG9PAtOmVSA2seZ96eGPGeodVJIU+0x1i1gZ+YVj1vw5/x+9RIfo3UvknFL6wNbHbX1gBYyBbuI466DI4kE2ToujqPUa6OE93R2B2v+yvaJJWmhGdXK/vl6gVeS8xfE23oDhplxIoBSgklkNOQslFfsooAepUhjDuTEwRr9cn+c5ialpKuky9tgRkxkQTqoEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB8717.namprd11.prod.outlook.com (2603:10b6:8:1ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Sat, 11 Apr
 2026 02:03:22 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.014; Sat, 11 Apr 2026
 02:03:21 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 14/22] x86/virt/seamldr: Do TDX per-CPU initialization
 after updates
Thread-Topic: [PATCH v7 14/22] x86/virt/seamldr: Do TDX per-CPU initialization
 after updates
Thread-Index: AQHcwQwEN7/Ej+KUrUi93mxPDcy4I7XZLKaA
Date: Sat, 11 Apr 2026 02:03:21 +0000
Message-ID: <1eadbc6e8b304e6b98686f7f99826728d24d80e3.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-15-chao.gao@intel.com>
In-Reply-To: <20260331124214.117808-15-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB8717:EE_
x-ms-office365-filtering-correlation-id: 9c0487e2-e4a3-4198-9924-08de976e8217
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: WrCMeZWz80r7HZpma3OI0twn/75AZl21YBdm9wx/ylfZXI3+Xk+at1sa3P7G6KKKF9fxta8zE9BSzTjMPb8OaDyU2f8zjU52I4qWHHWpSwTc50UGQeri9StpKg86orMUMbRTBrpwMvLW8+XkgfC7vlZpZL/jL/WID63pQD/H6Y0QTwQrHI9Q4gUDoI4z7dgANjrROL66/YJ8qhEpqEhm7nBOhF0mzns1Tg7s7ruDlkBW8+zKCYmMKKNzAE+G2IbWcEJJnNyPRp4d5kU5tYAGdCyUP8rL1UaW78dLftdtDHyFsWO9AQoVawKoXc1DS0B/Kh+Mw1Zc26X5YCkSvwVhulpw4/B4aNVIzsdEurSeMi1O+Ixx0Sp9oxnxbdM0Y6INsbnZ13oiohl+3NCZuEVWyXau8bsKcD3mjyUMxSeVrWjgg26vgNrE+w6eEHv4o0oiBRE9UYEBEeJDwFmu+64XxQeS723SC3dRr6GGliT56OH0fwiaQHM6wqmihjR/YssS0R1pOiR5nN7jzIZJ0UTcDjFMHKFTH5RsllcsnOZsiGzlkPD9tr/BGxiGmhVpdPep1ZlZxRJtrdKE//8zCjW9VcAnmvkDF+c47T46tmRYf7M+EFD+AhRyskehgHjh1S3teNeIyRThqjCfFXqGvBeIwKBSSWFP6ODVD4To8ixDZMFyY6Rz+WyoIvJ+5HFuMkO7kkwUNF5VWqouYwXGR2rYsQtQldiU0gvb6b9zIfQgjJ3vD3+rBbexHWBmTiTZN/QImGb3a4WxOhekjSJluqRju9Rm1hgc1FlL/t5f1IzXw64=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUo4QXNWV3lTNktLSDROTEhEZnJESnpmRHdqTUdDUFNYTVhHUFBDbHNUSEZi?=
 =?utf-8?B?S0RxR015YXdLbjZDL0x6MEtXYU9uMlNhdHJEbWpoU0hzY3IzQ0QrL2RBR1NW?=
 =?utf-8?B?M0sxVk8velFlSXNWN25QRXdPeHRDbzIwWlk4ZHBFdE56aTFoblBXVXVZL3kr?=
 =?utf-8?B?SVdJZjhmMmVqNWYyc1laemUva3NEME45REFxNFpFbk9CbVdCaHNhamtPcWVq?=
 =?utf-8?B?djhkT1FOUGhvdkh2eG1PdmI5eGFqSkw1Nm5GR0F2aGxoMk1EWnNLenhOUFB1?=
 =?utf-8?B?UUFTditaSWo0c0ViNVhNRjZVZ2JCUGU2bzZPbitlR2xXS1lhM3EraFFGNnUw?=
 =?utf-8?B?ZWpXY3p2WDhkR2dqS2tDWUJYN2diRGthT2hHUmtyMWNGdFdYTXlPMXZqa21D?=
 =?utf-8?B?bStiUEY4RldNVkhsQ0JtZWM3emZDcWpDWm52Tk5SQXo1bjJXaVN5Unl3SVh1?=
 =?utf-8?B?OFJpU2pkUGlwNytLU1hUelZDY3RuanFCK0tDYThUN2xMU3JIdVZ1VHMwNlhr?=
 =?utf-8?B?ZGg5SUdwVCtHbmVCVmt4VnZ1TjZUeHhjek8wNGc2Q21MaE9STElKQ20wc2Rj?=
 =?utf-8?B?VFNLMndDSWdIakZxKzhKdEFkVURBYktZVzFJTnpLbWxMQ3QxMFFxWUJ0amFv?=
 =?utf-8?B?a2txOUhvUTFSUHgyNEVwdGY5bVFETFRkTzFZbzljT0xsL2grbFFTL2luQ1JB?=
 =?utf-8?B?d0hJanoxMzAzUnppSWhKdUtNeUw1L1dLNUFYZ3ZGY2J4ak9IM1JXMEhIQWJB?=
 =?utf-8?B?Sm5ScXp2Z2RIZjBRNThBLzErK0EvNEg3eUZJQklHWGtBSklUdisyK3gwSWNU?=
 =?utf-8?B?Vlk3T0RtK2Y5RGdzaXpabFlsSU45czZLOG0xYTY4b08rMmRzOTVhYms1RUJ2?=
 =?utf-8?B?eXFsQ3huNnBZcnNlYytKT3hNOWw0amxXQ25QWmJUWjF0Ky9GNWZFWjBDam96?=
 =?utf-8?B?UTQ2bnV1dFdYUjR6amtkQm1kcWhuVGxEU2ZPT1BJWkJkb3o0WnY4cEdyVnZa?=
 =?utf-8?B?ZzlLemVFeXhXWmIvOG43aEVkc2NLazFkazlrZTBDenkxalNhMSs5cE9iL2hV?=
 =?utf-8?B?bnZ4eW9xdzdwN3A2dmdVaDBTVStLdVVUeVFmQVprV1JBZi8yN1dBc1BlY3cx?=
 =?utf-8?B?clFTZzNPN1ByQVBUWUpSc3AwOFdnYS9jMHlpTHJUMExJWVpVM2wrallnNTI2?=
 =?utf-8?B?VVpuc3pjMXAzV09hbEJuMVFvWUZvNDE2c1dwUjdRSE1vOWprTnJwNFFDQTkx?=
 =?utf-8?B?NXVHRldPcTNMZEI5bHZBWjhhUFJQQWw2d080b1hkNG1CQmFrYjRMek1MbmdR?=
 =?utf-8?B?WU95dlpTZWt1V0gwbEQvM1VxRXJYTm16R0JpbFFad1ZyOXlpMkNuaXZFVFJO?=
 =?utf-8?B?bjh6UGdheng3YTFxNjBZSnlZVXY2U1BnTFhQdTZqZnBwUlBoa2RGc20rb1dW?=
 =?utf-8?B?ak9FUkxqMXVtK0hEaitmVlpORFpqUFQzS1BVY04vcFI4ZktJbTh2NE9QS09r?=
 =?utf-8?B?WFhTYk15TGV4NnN1d1Izb3czeFFyb2VjTzhETm54Sno4WGV3SzJLRlBsK2pt?=
 =?utf-8?B?Skx6ZUk3eEg1WW0wMzJtU1dlNTJERjIrcGY4bmZzNlhnT202Tzd5SmtpalV2?=
 =?utf-8?B?c3YycnpxU05UK3Z0cjh2ZjhhSWsyY3M0V294eTBLaEpBc3VrNFpXR2JaaUVa?=
 =?utf-8?B?NExmUXdzclhOTjI1U0o1VGU0Y3UxaC9iWDFXK2g3WGhQVzZBSjFOMmUyeGlE?=
 =?utf-8?B?N2cyWS9NU2VGTitLQWNHS1ZRRThTaDhEOWFUS2xmU0NmVGlzdzRtUUk1TVZZ?=
 =?utf-8?B?MWliRjdueUR1aURZRFRxdkJET2lVYlhSd1c2SUU1dCt0dzlXQXJYRFBqRmVZ?=
 =?utf-8?B?aGhIYUtlSUMyRWNFVVQ4MGRSOUErdS9aVjVTdFBIcEl2MXlaUTNtSGNtY0oz?=
 =?utf-8?B?Y0FnV1c4ZVkzTVhldjZjYXZGVU5aQ0o5RDY0RGRYT3ZoaXhkazZtN2M2ZEJk?=
 =?utf-8?B?c1RCUmV3R2I0K0pGRS9ZY0YxTVJuclNrbnYvY3VMdDB1RHc5ZE1LekY1d2pH?=
 =?utf-8?B?cGxXMUFONXVQUkJUUDRJeUlDamdwQUN5bTh5L0NpL280S1A4RW5YckM2UHBq?=
 =?utf-8?B?TmtUNXJ6akk0ZUJIT0Y4ODNiZWpMaS9CVERJVGFQWktPMjQweGRqUENzUk5j?=
 =?utf-8?B?VWJWMHhmWjF5UzZIdzFZYmtmdjhoWGxHOHkvU2V6Nkx6Mm5UT3ZFTkxncVFQ?=
 =?utf-8?B?ajBDY2g5ZGR2eEtSTXRiM2dLejhhTjJFVGFoRkxQNTRrRTNyT3BieFZhWTJL?=
 =?utf-8?B?Q0FZUlRkWVRCYUttVEY3MjZaRS9aT0gwZlprSzJ3eTZsd0JXaCtCMVpHaitq?=
 =?utf-8?Q?6clIutlZYzGc0/aA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A13F913FE1D0E4497F57F360684D912@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kLoYtEGUOExv/OSq+9D+BOGGe7nNoEHblAdA6ng4SRDiObzA4WUmAE4zU1t3dGY1oS5AzXLOzrXeHILx9ZbsjQK1WeJBzQzWKDJbGpOryb7BNIRLX1US67a9lfgC1ij6DMMol5l9bLMw/hIHhzRgxqJM//zJrDyao9V1dg11prmWSS4MzXg6bBGf88oKkOZ86qjxNyqTR3FHsxrtHUXYG4kmnRkAno4yGaxHsGrc4ByQAbbYsqh+J3NNQI+0oN6q6jGWbU2ttfoRWYVrQhfUb1tF63R7lWxHxcL8eZVT9h4WPN93695v1aK1DQ98ii1MKTaFr6j/djUs5gPUX2htYg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0487e2-e4a3-4198-9924-08de976e8217
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2026 02:03:21.7805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: szu9AQjhhslEcVru0qaPKA8OJFTYnkUYdNnKSWvqh7stQYhYDpvasYJxI0J8/xsFgLn3Syla9CCCHs+ymDqrilt/5k3K+39DFb6S26Sr4GI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8717
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDA1OjQxIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gQWZ0
ZXIgaW5zdGFsbGluZyB0aGUgbmV3IFREWCBtb2R1bGUsIGVhY2ggQ1BVIG5lZWRzIHRvIGJlIGlu
aXRpYWxpemVkDQo+IGFnYWluIHRvIG1ha2UgdGhlIENQVSByZWFkeSB0byBydW4gYW55IG90aGVy
IFNFQU1DQUxMcy4gU28sIGNhbGwNCj4gdGR4X2NwdV9lbmFibGUoKSBvbiBhbGwgQ1BVcy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IENoYW8gR2FvIDxjaGFvLmdhb0BpbnRlbC5jb20+DQo+IFJldmll
d2VkLWJ5OiBYdSBZaWx1biA8eWlsdW4ueHVAbGludXguaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1i
eTogVG9ueSBMaW5kZ3JlbiA8dG9ueS5saW5kZ3JlbkBsaW51eC5pbnRlbC5jb20+DQo+IFJldmll
d2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBL
aXJ5bCBTaHV0c2VtYXUgKE1ldGEpIDxrYXNAa2VybmVsLm9yZz4NCj4gLS0tDQoNClJldmlld2Vk
LWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo=
