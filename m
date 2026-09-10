Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D87E368264;
	Thu, 10 Sep 2026 23:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789083897; cv=fail; b=eF4rZwQ3RnGiPMAtbnUXQOAfS/P7cXMYKBnBTsqmx0y2qC1hXeVNh2ekXSe3XzC3EaUgE7dkogMcJSMzfUP2B+T2/GA+pOhurufXFlvEfbPo8c44SVYPkL3D1/ZEY8bVtz88yj5iL47STJj47OD53L2YcFJWWFYTDYJHHZTS1XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789083897; c=relaxed/simple;
	bh=ma1kHaLuw987mVl5dFIvJF2pOFc+xRK7ar4SA3QVDV4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lOh1loa7Ney2O0SysSDfT7Ozu4oI47Ary0GCmsXrWrmv1a65i7oPzaknYbgEV3JHxla0khgwB5WfvciKhLfAUOQEENklmSXX6Z7dONY9eJAfm1r4BbZBCEmQshWFS3I+Nz8Ms9v+yFZznRPOYD+0S6pGPmkUlu6GMXwhsqSVzMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1auU8YL; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1auU8YL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789083895; x=1820619895;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ma1kHaLuw987mVl5dFIvJF2pOFc+xRK7ar4SA3QVDV4=;
  b=m1auU8YLtNPvTGAp1NKBWNyXFgkc//Sgn8wMMIDhx5ssreyDE5x1FVPO
   isO0YsfoM1Gt7wqcCg1jBJDtUjzB1S3AHe87BsFcMB9VNm7ppVWzs1kc5
   SPqsc9GFp5kQoNRl8DP0nPPAGbL0fesHMQbUSbk3bgZRLLeM13/phuSaT
   E3h5iDU+T+YiP4MT2ImlEA43nLyVowizbMS6mo9BTiVjaCDFKwj8hOCIZ
   fTpDxBSLIei4PBbuZ/dsQ13NWN+lU7wjJQqIbCalrcR09CGVC0Tt+B83b
   GPI77PV1dTC8bba0YLnojBPl5dhIf10mQxl8yamuDQ+f8tPXQkWfWdvCr
   g==;
X-CSE-ConnectionGUID: OC4zA2a1SJCUY6GhIvFvMQ==
X-CSE-MsgGUID: 0lj1pnguQZeP9AlQj/2kpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89418556"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89418556"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 16:44:55 -0700
X-CSE-ConnectionGUID: oq8mLiuxSFqYuwLJztOgNw==
X-CSE-MsgGUID: qzGFCTg6TXy/edB4fZ2Vrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="272281619"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 16:44:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 16:44:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 16:44:54 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 16:44:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3CQ3kl9Tw4Jpj9DG3QiD++U2HogS6+x7QVzr7PtY/LUg4stmogEHbEYZchtvtFFEkXAOwL3QFohc74M7VDiPi78Zv0GpLfqKsa1evyEGzZl///aCESR7oUDh0ZMTokE76I+wUo4kLSzie3m6HqSKo8/F5P93Hl0oQw9NJLrOM+XtZ4sCn0XQH79OTUncdM2CfzE7IEwRmks4CJnjLKY/H6szHqASAMHxsE7DsJ218PKbhw5ASxkyOJkZvdr9ZtHnzFPcG4CbyDcO/BYn2B2Vfb+bph5/p2E3B1wtRPYEa2eLuuwKjJ5sHZxSQzHuFR+G6dkl6ZCAfSfvxTxbKkVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma1kHaLuw987mVl5dFIvJF2pOFc+xRK7ar4SA3QVDV4=;
 b=SFSgXML67bhZrdcgyOcKASRskPkgF3mUGwO3B18V1CJCOTxxRu3U2kHcC9o6FHC+R8xoZY2hXs/A97yM9xe27goSAVatnCnoC8inXYzOGbJe7z44ycG+9Ae8KIIxd8/1Wcz2s9YuGOIZEf8CgHVR+tUNhOXVUANTYy9jNJ1I/88FBo1bzqBxTcmWXdwF06qHp4xc6UfLBxDwlOPtu1zEa7K4Si+tX/sJ+I9dDyVUSd+yPXOISb1aM+7UewHAj2JejVai6OaXY2xt1VfoDeUp7+JpZnkNlRCXQitEgco8PeTt/X2C6miG1e/0kCPv7lZJw4wVM8jShK234SFJClAkdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7121.namprd11.prod.outlook.com (2603:10b6:510:20c::7)
 by PH8PR11MB6753.namprd11.prod.outlook.com (2603:10b6:510:1c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 23:44:50 +0000
Received: from PH7PR11MB7121.namprd11.prod.outlook.com
 ([fe80::6b9c:c109:a0a8:2997]) by PH7PR11MB7121.namprd11.prod.outlook.com
 ([fe80::6b9c:c109:a0a8:2997%5]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 23:44:38 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "ak@linux.intel.com" <ak@linux.intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH 2/2] x86/early_printk: Avoid #VE emulation for TDX guest
 serial output
Thread-Topic: [PATCH 2/2] x86/early_printk: Avoid #VE emulation for TDX guest
 serial output
Thread-Index: AQHdQXSOhx1WlBp10UC/HbRcuVJPVLbIahWAgAAPrgA=
Date: Thu, 10 Sep 2026 23:44:38 +0000
Message-ID: <4977deebbf32eda411d3344d184b2914ebc5403d.camel@intel.com>
References: <20260910-b4-tdx_earlyprintk_tdcalls-v1-0-4b2b1bf9001b@intel.com>
	 <20260910-b4-tdx_earlyprintk_tdcalls-v1-2-4b2b1bf9001b@intel.com>
	 <20260910224829.C1F191F000FF@smtp.kernel.org>
In-Reply-To: <20260910224829.C1F191F000FF@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7121:EE_|PH8PR11MB6753:EE_
x-ms-office365-filtering-correlation-id: 41407ba0-c8a9-4450-c668-08df0f957a18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|5023799004|56012099006|11063799006|10067099003|18002099003|22082099003|4143699003|6133799003;
x-microsoft-antispam-message-info: 2rM/tSNeCQSpYpLbot/e46pYwhgJrYpXMbF3StTBWK/4iyufq0xG8VAMrrOZPibTq9ckYeNF3MIRtkJj3KSWh2wavyyZu7QEOMNgs38hy0HH3/ShqlBmTaBH+yvCGgTB1BNc33RA4YJRMzRAvu9ADWUqQYarGRxUZjCH7oVdtSV0RlN/MFIQEs7axRg6Bje+jE8+UcS5AZCGB9z6+RuLO/5ljJRaonux0GSbxQKaOZK99afEatNRtsZ+f8r1tZ/cbts1Decsnxh6B2/XbNoETBqD8terFR1pwyM1MJ36cxZ0/Z1wrzCYp3Di1gNUWU+8MG2MyY6vM2bwXm86yq+lR+e/1/KvO9xKgrjNBR3UFOxJciaEjeyD6o1135nLvzsD/XC0srZ8Tf59NUeAPomQtYXBNEiP4XWhwwDKWeDqOBvgfzbTORqBbvL/T51jkzxdZ4dbLOZBwFI5w4ufMZdzINAqCCYk53ArtXeW1I5J3aYSivZZdPoErVbReKCXg4JcP2t09A7Wb5E/YNRd93y+9uKEUhzqsB/QggVZ9r9uvr1q5riF35+1gtGfnUveWGuz9wLij5C50MFzm1VY54rzU9/xDqviXB8GCvhtv4G5Gr+exlzkEnUs9cE/MU5uPlLj0CNyr9u1lRv3acGfuVE2F8fg4NixMPajeXKTQFLJYIhONmLTec5iioxg1Ovqp8qQ1djgZsRTIi0HFZntseG+oRr6daeY1OmY/TbI61/CaE8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7121.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(5023799004)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(4143699003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1ZWTHBGTHBydWhWSklXTUJxSmR4bTVXSHN6bXF4ZWY2RmdiZXh0SFF4aGRG?=
 =?utf-8?B?aHVSYXFLYWdZTktKYlE0eTNzOVJTU3oyZm5HbEd3MGJuT3RwUmpic1IxbGgv?=
 =?utf-8?B?VXVpbHdjd3IwYXlTbVJWWDVQbE9IZUJvZTlqQ0FOcnhOeG4zTFpYOVZtM1FM?=
 =?utf-8?B?c0I2NUpncEk2dGVKb09aVVhabkFBZDZkNlBSQk5Ca3dCSUtDUVlvbkdSZjMr?=
 =?utf-8?B?YXhnemt3TjhnV1NSczdUVGFqYzYyQ1NPZS93eWNJdE5qdXV5M044RktUT0hL?=
 =?utf-8?B?VUxyZXRZNVdySkhmWHdaWlhUT2xrbFh6cVZXYWNJL1RUSDdVZDdrUE13YVdW?=
 =?utf-8?B?V1c4RHZHdnRrQllkcW1RV1hSM1NSclFKaEIzOGNPL3U0QUU0Q3krSEx6RXpS?=
 =?utf-8?B?SzI5MHlSZExDYjlYRXpXaG91Q0MwMEFpYlhEQktTN1paMllHVFNwczhIRTFm?=
 =?utf-8?B?VTdpTGdCNlhudnExL0p3Q1d0aXIvdUFIMmZNTzJnaDVLbWs1blNUS1NvVVNP?=
 =?utf-8?B?SXVqZ21NWWFiTWVEaUZwT0xFWCtoVTc2R3VkR21rYzhEbmlSR2tGdUQwTGlK?=
 =?utf-8?B?OUZBTldxYWtGOHpZSE9ha21oUkV4TkorRkVTSUVPeHpXa0l2MENmMDc3R1Jm?=
 =?utf-8?B?Q3JQZnhFbVY0bDdtdWx4WFN1ZDFpRFlMcHFtdFFrLzdHNTJrOG4vbUNsdjU4?=
 =?utf-8?B?REVIQU52a29NWFNMT09zclcvd0hWSnd1NDZjamxYeHF3ZjNXMDZ4U05hRTFs?=
 =?utf-8?B?WjJOcEd2NjcvZmZmTEZjYVp1OXBJRCtGRWo1NVlhY0pqRk9GUFUzajZEMTVJ?=
 =?utf-8?B?ZnBNekJzN3VyU0V4N3JmckFZd25WL2g1U0tNZGxhTytVOFI5d0hUNWVyVEFw?=
 =?utf-8?B?M2V2NkVhYzg1YnhxNEhnTG91ZnkxOWtBTHZiNlkva0YyWWp3L0duTldwa2pH?=
 =?utf-8?B?NlIzMXZKNm42a3ZMN05EUGM1dUEzN01ORFVjenJId2V0KzFzZW5YYnppanZr?=
 =?utf-8?B?a2orY3NuMDFnRGUvdWpxenpUUWpZQ2t0UUJTdXBvTFFjaDdxdnViTXAwZlJr?=
 =?utf-8?B?N2tmeWlNenJwbU1EK1FTUjVGTzRTOTVnd1pvTzhTdzFFQ3JOYXNUK0ZOZ2VG?=
 =?utf-8?B?NkNRcjUyZ1dhSmt3aFhKa2NqcXB4M0VPMzM1WDhXb0tTYTVOQnJ6LzhHZXhS?=
 =?utf-8?B?aDRhWWc4OXRiMkd2dEpNZm5IbVBydEtRMkNmSEprd1MvdEVKSmxoZnl5Tkh1?=
 =?utf-8?B?TUJYRVRGZDZGMDRMNTU5V0tRT2ErdjhvaUNZb1F4QXcyWHFLOFZLVmJibkZa?=
 =?utf-8?B?aW5wY3U3UG5oek0rYXk1ZUNyNTk1YVo0MVB0TGduZmU4MGRSVjJwMURSV1gy?=
 =?utf-8?B?Nm5ra3FiN1U1dmxLZm5NczRFQlA4VlFraUxtU0RsSDhFc3F5WEJpcjB4V1k2?=
 =?utf-8?B?bEhJYW5XMG1NZ2NNUlErM21qSHZQZmM4ZnpWUEZySElYMThkdW1qMFFYSnk4?=
 =?utf-8?B?TTl0R09YRFhaNDAyN2dsQTZzbUxNbHkrd2gwTlgwUUtWM2NTTi9LeHZwVGRO?=
 =?utf-8?B?NHdka3ZSaFU2RnB3L0N3UEtPOGp6WGtISEhWUFI1Y29LcUhkVnVzUUhoUzVk?=
 =?utf-8?B?dWpCYVZYckp0cHBvZnpjVDdUSEdoa0hOTjNncUFYU0czdHlWMk5qNUJ1T1pr?=
 =?utf-8?B?TkUrU3RkQnR5Wnc1anFmK3RsdFNPc0F6S0w4NWpKdEdReUFnQ3lsNjgyS053?=
 =?utf-8?B?WlVySHNJR2k2dURuUDJxSDM3YmNQcHpHcll3bkZaWnhGbTV1czg3d08wWGJm?=
 =?utf-8?B?c1MrYWNPcDBNWWNNUjNXREYycGNUODVJRmVjSHJQVG04WWpHUitOSi96RVBk?=
 =?utf-8?B?VTRUY3pJYTkyNmg4WFdCVi9MbFNGR0JEbWw4WWsrS3Z2TWpmVk4xUSs2OFRs?=
 =?utf-8?B?b2NBU3R3SHRBUlpady94Rm5ZdElFU25HVFROajlHczJhdGFqZjZUbmZ4K01v?=
 =?utf-8?B?QVBSZEdmNUl1NDM2Uy9OUXBkK25GSGdiRHIzNFQ1ZDM5RVdiWnhjL1F3N0FM?=
 =?utf-8?B?MVQyNGJ3ZWtNeWkxdWhmQlJWV05zMWZGUmh0WndVUFU4ZVBtUStLZGMyM2dK?=
 =?utf-8?B?d3RicUpjMFJhMStVYVJoVmxwTHQxMFRNeWpibGtLa0pkRkR6Skt0YmdYdXJ3?=
 =?utf-8?B?c0JTREY4Z0tFVDExOXcrNUF0cENtblZiRFBrajMvSlo1bDlQeTgxZ0paL0sz?=
 =?utf-8?B?d1VZUHR3REJxTkFKZ0Zrc2pUV2prdkNUa2c4UWFCcjljbWVyc05TbTBtOTlK?=
 =?utf-8?B?WU1VSFlOYW9ERlFPNHE0UlJzNjJ3Q3hBZXdZZUdIZzB3Vk5KbTVzdTQrckFq?=
 =?utf-8?Q?arqBlFyFwpUAbatU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A79BA5801BC2E428006841CF719DD60@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kIIgxjNt6bPSVj0R7oOdsdpNxtoZeNL5Ambq4V3l4fYPQ6ZBXNSRUj4e7oy3BihmesP+kDKxyGSfF1RAavYC7kBF2b7Q19XVF39M1xs0ojzl8YqykCXetYDOW9aBLGXOBSJsyVnlFpdVbTpyIVKp5n7BCWA4DeWgutgTIeQAdpVpr4oApIsGLvjroZN/jZ3vuR4zdXLp8fISo87X6ZhCRYG/FWa0XkT9KMl1cyHmAEfL7am06WZk88fjKMcXkNqLv/HLbZmkX1eOFhUyoKfkXIUN6oRzu3fl1fVBL9vfHFMVHrTUat/eFatzT05bp7tECMNy6tJC1xQDDshJNgO4dg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7121.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41407ba0-c8a9-4450-c668-08df0f957a18
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 23:44:38.2660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lnlaHHHncC5rPcbG0KtvAxCB/6fGFblvLsWhxaPfycUpZLd868LzBKuAfjDh5bLA6I5GEvJe+wzwQhMG/KICqgLR/eAh+h3fsCHIwqlvgyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6753
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTEwIGF0IDIyOjQ4ICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiANCj4gPiArLyogU3Vic3RpdHV0ZSB0aGUgaHlwZXJjYWxsIGFjY2Vzc29ycywg
YnV0IG9ubHkgaW4gYW4gYWN0dWFsIFREWCBndWVzdCAqLw0KPiA+ICtzdGF0aWMgX19pbml0IHZv
aWQgZWFybHlfc2VyaWFsX3RkeF9pbml0KHZvaWQpDQo+ID4gK3sNCj4gPiArCWlmICghY3B1X2Zl
YXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9URFhfR1VFU1QpKQ0KPiA+ICsJCXJldHVybjsNCj4g
PiArDQo+ID4gKwlzdGF0aWNfY2FsbF91cGRhdGUoc2VyaWFsX2luLCB0ZHhfc2VyaWFsX2luKTsN
Cj4gPiArCXN0YXRpY19jYWxsX3VwZGF0ZShzZXJpYWxfb3V0LCB0ZHhfc2VyaWFsX291dCk7DQo+
IA0KPiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4gV2lsbCBjYWxsaW5nIHN0YXRpY19jYWxsX3VwZGF0
ZSgpIGhlcmUgdHJpZ2dlciBhIFdBUk5fT05fT05DRSBkdXJpbmcgZWFybHkgYm9vdD8NCj4gDQo+
IEJvb3RpbmcgYSBURFggZ3Vlc3Qgd2l0aCBlYXJseXByaW50ayBpbnZva2VzIHBhcnNlX2Vhcmx5
X3BhcmFtKCksIHdoaWNoIGVuZHMNCj4gdXAgY2FsbGluZyBlYXJseV9zZXJpYWxfdGR4X2luaXQo
KSBiZWZvcmUgdGhlIHN0YXRpYyBjYWxsIGluZnJhc3RydWN0dXJlIGlzDQo+IGZ1bGx5IHNldCB1
cC4gQmVjYXVzZSBzdGF0aWNfY2FsbF9pbml0KCkgaXMgYW4gZWFybHlfaW5pdGNhbGwgdGhhdCBy
dW5zIG11Y2gNCj4gbGF0ZXIgaW4gdGhlIGJvb3Qgc2VxdWVuY2UsIHN0YXRpY19jYWxsX2luaXRp
YWxpemVkIGlzIHN0aWxsIDAgYXQgdGhpcyBwb2ludC4NCj4gDQo+IFRoaXMgdW5jb25kaXRpb25h
bGx5IHRyaWdnZXJzIHRoZSBXQVJOX09OX09OQ0UoIXN0YXRpY19jYWxsX2luaXRpYWxpemVkKQ0K
PiBzYWZldHkgY2hlY2sgaW4gX19zdGF0aWNfY2FsbF91cGRhdGUoKSwgd2hpY2ggZHVtcHMgYSBz
dGFjayB0cmFjZSB0byB0aGUNCj4gYm9vdCBsb2cgYW5kIHdpbGwgY3Jhc2ggdGhlIGJvb3QgcHJv
Y2VzcyBpZiBwYW5pY19vbl93YXJuIGlzIHNldC4NCj4gDQo+IFNob3VsZCB0aGlzIHVzZSB0aGUg
eDg2LXNwZWNpZmljIHN0YXRpY19jYWxsX3VwZGF0ZV9lYXJseSgpIG1hY3JvIGluc3RlYWQsDQo+
IHdoaWNoIGNoZWNrcyB0aGUgaW5pdGlhbGl6YXRpb24gc3RhdGUgYW5kIHNhZmVseSBwYXRjaGVz
IHRoZSB0cmFtcG9saW5lDQo+IGRpcmVjdGx5IGR1cmluZyBlYXJseSBib290Pw0KPiANCj4gDQpU
aGlzIFNhc2hpa28gcmVwb3J0IGlzIGEgZmFsc2UgcG9zaXRpdmUgLSBmb3IgeDg2J3Mgc2V0dXBf
YXJjaCgpLA0Kc3RhdGljX2NhbGxfaW5pdCgpIGhhcHBlbnMgYmVmb3JlIHBhcnNlX2Vhcmx5X3Bh
cmFtKCkuDQo=
