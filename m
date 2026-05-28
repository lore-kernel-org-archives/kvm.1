Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467742FFFA4;
	Thu, 28 May 2026 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780002018; cv=fail; b=VxKJlcY2i23Vg/0JhWaMOIyZrz8jxLxn3vARlYtMznb9zd2a3cOq6b56X8XXgwcUyPXl8SZrh11DuK7RNFkmNVK5YJvYqekNusQmKNb3LdAH7k+tU6Qa2ikYrxb/nZIzhREB4JnkWOPIOeNOf4e9Pr/viWswPyEoxxSyGrlFQWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780002018; c=relaxed/simple;
	bh=cPl5McI6nnPK8YpxEfgKED4siUS7QxxglmCUR6ufvOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PuQXzFxWYfjqD2DnsnbZ3iHMebU35RuWsD6SLSJ57O3F7YcQxz0jNoObdiDBOVM7h+7n4NzW/nGfD7I2aIOP3WmX6eoeZOZ8hASCWaBuAZdkegNuxYuMKAYIc2k4G2lWJ4nZAfiAMkYg8lGnu8NGtQ34MQJVRePwpvlI6lsV1/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOPr/S3g; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOPr/S3g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780002017; x=1811538017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cPl5McI6nnPK8YpxEfgKED4siUS7QxxglmCUR6ufvOg=;
  b=BOPr/S3gTqC9InX2RzTWDRoIy6AlRafbCl5U7ZGvu/OHe2d3L5UOBfuA
   w4qCTuvvLf6SQHfsAe0brOQ954oBt/ORDpl62UM8kDhMz3MbEiI6lXZlu
   yfrhgHMC3Yg0liLjGiqzWtoVbL0z2HiAJIq+ejd1N0BxD9oW0Y409t9zz
   96gemjGoHHR9hILRWQoBt9f9XbWMh2QiSHmtBquhIMg60aS1pOqurP6nV
   7kdp7tZ2TE/geik48AlBpdZ9cPcVbLkaDVB48NUyHJq6D3gA8rZBjZWNW
   9WBta3WJ1lkv4FdSy/Eb0GakBXzRI8Rru/07iJRaVaHvfGrf+0/ZS0N0I
   Q==;
X-CSE-ConnectionGUID: fBofd6upTRuOHq1A28e/Aw==
X-CSE-MsgGUID: 2T+t/jWmRyC6k3/LyMJX1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="79889578"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="79889578"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 14:00:17 -0700
X-CSE-ConnectionGUID: Ng3m7CeiTu23aT+1FdTcjw==
X-CSE-MsgGUID: NCEJu8kjThG2uygYpDOAPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="236302092"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 14:00:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 14:00:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 14:00:16 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 14:00:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBPgPX8ijraz52WM/vSN6H2WEISzPNjnRqJK3y18ky9rDuch2YTdC+QhgNmFxMrqVIUwxRsYYoHHlIUS5xs9MCxH9/vj2aKX/mzLZIPGB5LeOPWTNoBfT9IxPFkdGxuhtFHSjVRoWbdMaBsR7vakRpwOSDgLEGNEaNwOSQPtBDJ8adnr7fUP1SUJ0Ubv3NLr7P+dHST5I7wxnbxixqNBjEMRPdPmzymJq5Y4dKrxWNeBnotFh2tOhcCJbauWAflxQh82eCEvKBlMogSDPU+L7wgVnoZko2uTX8YLbVGkF9hZhUFMqpAJg1r8eU8+osEtoVbBt1uNDuiVdG+6r07S8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPl5McI6nnPK8YpxEfgKED4siUS7QxxglmCUR6ufvOg=;
 b=Bs/vFdt7MyLNLgVBJJQVOqH2ZMDsNl8RA9dqw795dmIb3I/cDDyViqdw80OmjjLd2+e0V9lxLU3iTaxB2NI7ro6XezVWLiBnxtTC/kX2HpEYFjGOAfaiXPLcslonLPW218EiH07u+elNHqC94s3HuiIkxfK6xHBdQCghoNWXdunFofEgoz/YQg0Q0oAXQD7XfDatyyKbw7EXH0Xf9V1mG9iVNmZ86g11py6KeVqmh0sLcjT/h8C2aJDgyfU9IZt+WIiJybr6SMYr7gDhzXB77RmPXSSp9I86/S7BDytGLJjFLpaNe53/sx33F5PF4ASW93DF38MXjl0XvspDpDSalA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SJ2PR11MB8450.namprd11.prod.outlook.com (2603:10b6:a03:578::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 21:00:12 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 21:00:12 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Fang, Peter" <peter.fang@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"djbw@kernel.org" <djbw@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module
 Extensions
Thread-Topic: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module
 Extensions
Thread-Index: AQHc6aA9T+sLFts0xU6ca4lQ9VIhqbYj9rGA
Date: Thu, 28 May 2026 21:00:12 +0000
Message-ID: <fd3f9e1f70babe97f98852f2a705341b86ed1132.camel@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
	 <20260522034128.3144354-2-yilun.xu@linux.intel.com>
In-Reply-To: <20260522034128.3144354-2-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SJ2PR11MB8450:EE_
x-ms-office365-filtering-correlation-id: 8a914118-6aff-4e0c-c0f5-08debcfc1c2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: efYe86z3IYllKbiYBCOirY/yC9SsrGUv+OdioonZOZ50rjGVZ04QWc6wXTbjRdScPZ+Upr2WhPMQZXInCoV3lUfQi0U/nEqHRQRXvnDzhC6Wcx6oaUw9595swx+xmCTowKxo20W5rYvFNQ1inzMgIMbJU27tWaR/B8MleXVF5SAHjSc/R0uDlMdBikVtwMm7/3Hb51c3iyNlHRI3Rbhg8CwtNnkeqJ84uzG3CGEwywAU3mqSXC3rXgCPu6zk+SdMxgDjXkKVmpxQo1IEFazW11tNXQXqlpRgK2nxNrYPFemUBuda14T0AxP+tIYWF611cbLhzACvoqacWCBTwDCePKdc4oTkEqd/3gaerBHV2SzVz5QFChbLI6JUDauyu9tlgfx5PTT/I4eq/ZJwRXZsGxQuQSCc3s6ikcIGIVaXtyaX5j/4iheHPFtnm90ImZS9cAscNPv1mhIkPlVJfRt56fzXdKPBPORBMJMyF2siomdhM0QD7Yq/dAVm/d9oodUL0pnm3qRT+85kZY6Mu4yZzeAWZCL6p2iJwfvCu353s4r0C/BMVtH8lAMOm8m/G7IEbwGE65UsT6ReV3QecyD2C9PUOqFaIFqdpP2savZDDPrqjsn95IJxCrFMvTl6GKaTav/3LA2cWwjhubpW2qR+b/4EXlcMKEgBOSAY0vuD41EzCaYyz1RPGn80n4sHrYNwu8B1ySmsNY2qaFJ2rewU/g1Im6vNbvEw5lFXwg3KyXR0ELu5YbUHx9taGhOhl4X8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEo2ZEljQWFIZDhHUEhtV0NJcmx5cityL2NUOFdKNXp4allacGhXYTJHZlBZ?=
 =?utf-8?B?WjFtcHB1UzhJZXhWU0VxTmZVUE0rOFpsZDdZK1RKekRBZ2dWTXJ4RUNNcWJQ?=
 =?utf-8?B?ZGRWNVZCWDFVSDYzRjN1UEhLS01ZMW8vTmIrSGh3aUtMcnlRak1RRlNoNkRO?=
 =?utf-8?B?T0F5MGhucmFnWnVQbmJrWGJHZHY4ajFVbVZXQk5TMDI4WXl4Q0pVUzdQZWFx?=
 =?utf-8?B?M2p3VnFiNXNYcCsyVWxIWGpjR2xuY25oK1pKMk1yMmF1K3lqNzFCWG1oY0VF?=
 =?utf-8?B?bkp1TTZwL1krYXNTVjNONjJJUDlGWnh0UG00YTk2MGFoR0xXRWJpdmpWZ0lw?=
 =?utf-8?B?K0xRQnlKYW1JTXpXV1pBbVd4R2xYZWNpczVUcWJLclFjaEI0c1IrSmhTY3ZG?=
 =?utf-8?B?SGRPNElwVFhKNSsyN2JzWVNpZ0Z1RUc4akd1b3E4R1ZtRndzK1Q5Y0tiaXlZ?=
 =?utf-8?B?MGVyR1JrcHlKUnd1VWhsQ0JrSFJmVVJLcmlDVlRieHZkRlhiSW9mL1JkRDkx?=
 =?utf-8?B?QU9hZ0NyS1pDMSt3Z2p6cnFqL1JCVDVsc0g3RVZBbEpRMSszejJaUCt5UDJK?=
 =?utf-8?B?K21JamF1WmpMTkJBeGo3NWhjZ2RiMm90RzFhVFViM0RUUzg4L1BCVG1lbFZn?=
 =?utf-8?B?YzNuWGxrYXNpUEVpUFdpU3FwQ1YvTDRKM0xrMndDOE5vNW9kNnVVQnlqUDJl?=
 =?utf-8?B?U3BxamdBa2RUdmhZM3JZR3MzWmowRkxtQnJjR2dWeXczRnpKN0U0UXo5YTR0?=
 =?utf-8?B?RW1IWXhNdWlCRjJ5N3BTK3p6N2J0d09FdlNVek9EVzNWL29pejUzMzNwZENy?=
 =?utf-8?B?dDVsYXZvWGN3Sk1ZMzZxUnRqMGE4MlgrRHZkcFFHa3ZsVGQwN3NYeUFxNmRX?=
 =?utf-8?B?TjhLUzR2eHRkY1Z4STZheit1OFVrZnoweGV4eWg1bE1PaHVPRk9KeXpXR1VN?=
 =?utf-8?B?QUN6NzFJVE9pcHJFZW9ZTzkrYk8wRm9yVndwYjNtaHFIN204Tjdpc3ZRSVpC?=
 =?utf-8?B?Nk1lY0VBNkN1ei8vS01SVk9CREZQV2c0QU1vbHJ1OGIzbEh5QmFKQzJ3MVg0?=
 =?utf-8?B?Ri9VVnJJelZOWG5zZzhXdkJ1VnllcnMrTWdvUG1INXBocGFtOG9NK2k0bW5T?=
 =?utf-8?B?VUNwRTM0S3lqc2dIcFdRb0M2T0FEZU1kYUR0b2F4QTdSRkVSRVVxVjNzOVRw?=
 =?utf-8?B?VVRqQjRqUHp2czJlWlYrMEcyYTE1ekF6d3pxbE9LZWZiclpETGRnQUZzdi9q?=
 =?utf-8?B?Q0lvK1ZneXk2RWx6NHNWT2gwL3pybXU5NzRVM2FpYWkxOExqRDVrdTRDTkFl?=
 =?utf-8?B?QVpqNkhFM3NvK2pCelUxRWhlR3JrOEZKcnpxaEVYTmNhMmt5bkVYMXhENk0v?=
 =?utf-8?B?Q3dpbGNFSVFCMXdOU3lBLzdEd2FjWm9hcFRESVdWS1ZiU1lmU0RCMEFMU1hY?=
 =?utf-8?B?WC9ldnhHVkZ4aXlLZUx5dXZNMm1CVVZ5Z0JkdVBRREhxekpvU3JVeUNoa3N0?=
 =?utf-8?B?UjFZdEM1QzlMZ1FzTFMxQnI3R1E4VFhCV0dyL01FcUlRUENaTHVVbWlmZk1Z?=
 =?utf-8?B?YlBEbnpuRkVpRDlwNXlLbGlydy9vWjBMeUU5RzlSZnArNUZtQTZsNXV5U3Z0?=
 =?utf-8?B?bkNLUW4yRHdOWW1XbVFXMUwxNW00U0RHRGlTUE9wcEJKRG5wa1VTdFVFOWtE?=
 =?utf-8?B?M3RSWm1mWk8wYm1jRE1VSC9oY291ZkF6UENrSUpnZUovVVFiRTRoTVJhOWR2?=
 =?utf-8?B?Y09pK3RHWlI1Z1I2M0ZiKzRxNllUcE9PRzl3cU9qUXE5MEJpeFNQSVBCZmVM?=
 =?utf-8?B?SzljdjVXSEVoZ0REZGF3MkszUkN1WS82OHlhZzA3YVd1aW9KM0RIUHNCVWxx?=
 =?utf-8?B?RU5qR2lkQ2RsdE1WSWZyZy9YMHlBY0xlZjFwd2xybDBWUzE4aUhoRGtzTTdr?=
 =?utf-8?B?MkZSUitiTlVLeUs0bVpOc2lQbCtxRDVBdlFFaDRFaFdYQnljZDVPcnYzMWlz?=
 =?utf-8?B?ZmRKQ1BJa2wrcnE4Zjg5S3RZcHUwNDFYaEd6THBSYS9ubm1NNTJZUUw3NEJp?=
 =?utf-8?B?OFAyekZRMTYzb3lSUE4rc1czRVdxMUpHQ2dkbGxvQ29CbjJIZEcxUzFqMm5V?=
 =?utf-8?B?T2N5SWdHbWpCMnNuTUhRTndmK3U5cHJlQkp3dERMRUl3a3JIKzQ4eTB6UERS?=
 =?utf-8?B?M2pic2xpWGVyanViMFo0eGYwNEdMbkNUb0FhMFlkeEdqNE5HU0R2bzB1Vit3?=
 =?utf-8?B?RTA4WUlibU1OR2tkSVpOcU0vcGxhZVZTUWxqZFg5WUxNTURENE5ka0dKRkNQ?=
 =?utf-8?B?eFV5ZlBsOU9PWlQ0TlcwWVpZYWdUSktJUkY2Uy9NSjNjQllBMTB3bStRc2NW?=
 =?utf-8?Q?d37eHE63LrIu7L/A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A2A0DF20A97DB418FE4A1D807FC4FDD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: C7ZnIPF4F2J02rUEOlfysidyJumPThOW7pDr2zW57fwiPHTemYK6RxH6NZZFlRDHVgmXMJ1s8Hxl0rp+4zKUVvcndJg0S5M01PtWt+zQYK55RNE13DmSUp7hN8zH5a4HYuC+5todBHJzugW4zoSWiOSplyAw+0rVrKUOebHwf7RXBLy5l8ZzmC+mG1xmijwTR0wSnop8mnG0jugRTZhniPdG2t63cKsu0t6YU0cturjVKDPfuTUqZhA1zf2S//WIDM08J9SjcYJxwQ14IyD1vPiLgHEfhUPGFzcV33/fspI+YUy0DDiGEanqBwzQ+5ind3lThEFRWvuoS1ofQcZj2A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a914118-6aff-4e0c-c0f5-08debcfc1c2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 21:00:12.2528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXP43Az7shufWg8owK158Z2OQKTwT2tIaC7OXmVmu+3sbInSaHSxWgxF4rboVziAVZ3DbxGEcxG5V+Cn6e2WeGgByYtz6sZNlOHsf2s8uUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8450
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTIyIGF0IDExOjQxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gK3N0
cnVjdCB0ZHhfc3lzX2luZm9fZXh0IHsNCj4gKwl1MTYgbWVtb3J5X3Bvb2xfcmVxdWlyZWRfcGFn
ZXM7DQoNCj4gKwl1OCBleHRfcmVxdWlyZWQ7DQoNClRoZSBkb2NzIHNheSB0aGlzIGlzIGEgYm9v
bC4NCg0KPiArfTsNCj4gKw0KDQo=
