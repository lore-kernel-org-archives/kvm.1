Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6294833D6F8;
	Tue, 28 Apr 2026 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777401083; cv=fail; b=lZzMvjBKyTGnTlX8cZsiQvMpcAabMxz/unvN0CxhMvi1J+4fpKSDiGiEb+650ctMs4oi4TdPY188idKsZAbULxUN7agYpFFf7A5rUc6gEGlMJgWPsr2rF+QUCoRzi/k9+ZUd4pMY8DUaVaDqh271c4ztTRZwvemUDN/R4BagJSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777401083; c=relaxed/simple;
	bh=3kIELG/UAfq1AInRX6bsXeEu/gLshcdVgc9y9U10Al8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gzkfYG4ZlIyjTugoUjn4zgLzPge9E0HzywfEmct6GFK5KMQuAE3L55ZO9pVRZLk5dZbsglfPSmjFrWEriUI0qikPQX504eE9IVBbq8iOs6xl+pg+W7ejIYOAWh2vTQvKc/K6+w8kAbs+gv8tgDH5KjpjI2NAQZ+JheswGOHgXx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SlaS1Bmh; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SlaS1Bmh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777401082; x=1808937082;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3kIELG/UAfq1AInRX6bsXeEu/gLshcdVgc9y9U10Al8=;
  b=SlaS1BmhWdVehEznk4N9RPI3RoORelrfh/LDRIDm/TKX25ocdn/zT6C2
   Cf6JDHhrd2s0oUJpq5QHLehBqUgJVtM98omLSQ+BipmqvHHbtMQKuIMxl
   RDj/GxSuyx2Vhj38zX8i4Wenq9pzrbtybn41aijGLuMRS3BHWhqzbgmVY
   9xWZJXZe3irqD5JNi37RpVdamlDR6TMz/xvJZC8BazXXjEAtpNN0CgKl3
   7Kiy4tgh760WK+86OPPf88MrIB+ZCMXjMlZHCpiI/c0k9ttn4sg9X4x3t
   KmcsK7cT88I+fFBvZOcqMKrBsamlVuNGEKMrAlBtISeyv8zPCa6RLuEkM
   Q==;
X-CSE-ConnectionGUID: rPhrg/DsSp2emIYKhBfH5A==
X-CSE-MsgGUID: h5lkPLCOQXmqZpE06d+JDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78027098"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="78027098"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 11:31:21 -0700
X-CSE-ConnectionGUID: MoAkq8xTRLugm0VL+B+GSg==
X-CSE-MsgGUID: QKfQRR7uROajVPN+6tOsBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="238365074"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 11:31:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 11:31:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 11:31:20 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.54) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 11:31:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSb7nuzQ2GBcnQiCs92Q/8OxsFkIrD6pWlpWk0zXwWp5XmZ8oWpJYOIrOMvmDLEsfDLWxzISJF4RXsou2PzqvEamtz7g2PLwO6eE9VexrT+uDkFNBU07c0fUl453gG7hw6jfkvNRIXa6IZK2/w1PD7B3nfhZYyR8AXI2L6EtSq3B9h4HjeiGPRthCyHtYAH9Ub7QCBhDa9qxWpsd+01xYsRXq8/E3yvnjr9gPIcCaW/FqXLbJik1vopDhnVMHzOPg3h/HoWkB5zr28x4a5MOrv/4J24z7jivW0qheZjdQaPQJ8X6UTcfvnV07BMiBoGKESReo4deIIZVGh/HP1k3bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kIELG/UAfq1AInRX6bsXeEu/gLshcdVgc9y9U10Al8=;
 b=gAHxPaz00EBF6XnjVSbiASCV0e0FtagrXYzA9AMnlg5WN2EL1p2TgfZ7FNvDjfGXrFcuEGW8aVjZfDBssrYBd7LNHcj9fZXecyXx+bqJW55Mlo1RGaNN9zt0ERbBbmbOq52kpCnW6ZIIM/OZLhuogx66npFOFiWIQEsnPBDkvxivA/upoDoFaqAkyQdJ91R6ADfuXBJcV6yROORv0Zp4J86j77tCF6yLpC25K9XVov6Kw24h/YrhrKsKgM6A7gffFR+eUaD9SSh9q/ljbuSHmgg3qoZj5wJFgkkpYZdl25u/LAhAz1/DeCAvtYl5RxwE3Cmikrgu2ICDKVXEUXxw+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM3PR11MB8734.namprd11.prod.outlook.com (2603:10b6:8:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 18:31:16 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 18:31:15 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "Gao, Chao" <chao.gao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Verma, Vishal
 L" <vishal.l.verma@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] KVM: TDX: Allow TDs to read MSR_IA32_PLATFORM_ID
Thread-Topic: [PATCH 1/2] KVM: TDX: Allow TDs to read MSR_IA32_PLATFORM_ID
Thread-Index: AQHc1rjc48hzBFaYnUOC9vPasmTOELX0W1IAgABPw4CAACHcAA==
Date: Tue, 28 Apr 2026 18:31:15 +0000
Message-ID: <b8c413a52c0285534d552c8646f9071fca4351f4.camel@intel.com>
References: <20260428024746.1040531-1-binbin.wu@linux.intel.com>
	 <20260428024746.1040531-2-binbin.wu@linux.intel.com>
	 <afCdoufK0D+1hKAR@intel.com> <afDgiz38tARlIQNr@google.com>
In-Reply-To: <afDgiz38tARlIQNr@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM3PR11MB8734:EE_
x-ms-office365-filtering-correlation-id: fbe4c011-fed7-4d94-0234-08dea5545533
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: nhNPANEcRO5h0WHHEqrEAi2EN8sFgfcMOgcc56ype2c9W0ZOtvlOKM1dSblOrobzXQZqppG5c3jzr3G+FmKlVtKyjJcHrlYiz+Jc/n7mNT6nsVkLJAbZKUHPOkCDHJVqnvDCCs0qz5QoEe7lDQa4G+DfGFbaZSOkBSnKtWE544FvZlsV/KX/5PlJJ65g9Qm7+mlWcY9UtiG153gABXyz2BwcnUDP+MfTRO7UiZVEms3bGqzb8JTJ6ENISLu37EHoxTUryb0ROkGtHmE0xxY8SFZd+lus5Z82wxAABN/PeYSucQXs/4Pcd+XBtcwrJBt9dmV/li1ORyZhSFokDvbHkCV0z/jiuuCyQQgKxYu61ei8/yGd93Qxn0BuLS148KLXtx+GqSi5ra0NGDs4PdIeeqZtIkFH6IjZtobFuuuvzQk7qqnSQuvbxLlut0Obz/YRaAMqQ+2bxxGVBg3srNAvOqrzPsWqLdiGbjEhdHmGj5NkubNKH2AOMLtIMdB+Pj4giDA9jl+AevKySb4DY2F6w6EBmbMA1YdqJsmqRTn3DnEdW9gV4i9zCA6Ba//v5Q2VOX8swcoSeIsvMuDl2na4sXPwGtJdBXol5eVNFLEUf/oWnC5Yf3BgMSm5ejmjfacJMLBiMOQQprxQES/LsZlMj+7OQWu2M/CtMSc9RlM5uCi2e+XVFeiLCAeOa2n3m0QQ8ZHwQM6Hht0xu68WxoEda8lEnvIX93gDoyK3WgDiYkDnLnzYw5G4koGGfQuYZePXeTPSNvK2eQm/Q/DgxfgE9/aETBGkHWl3qtwiRBkOl78=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OCtsTTlHNmd5ejBmN3BDcEloREY4L0ZHeFFtdm8rd21sSzByYjF1WkZYNGJx?=
 =?utf-8?B?UStEandxR2ZuY0ZsRUxSRFU0SUd5eENSUUt2MkdRL2QrWFowaWVITEQ1cHZX?=
 =?utf-8?B?NFRGL3p6Q09ocXhwYjRZM0FXaWcxcVJ1YXdiRWZHVXpQbytaOFlNRDRKSjg0?=
 =?utf-8?B?QWFKUkxVY2NCUitJNXM3RDNONnZ5cWZkWjVTRTl2OFBMbzk3Zk05M2NoZXVZ?=
 =?utf-8?B?T2grT2xxZlZGZDhDMk9uYU5ZRTlsdWZhZzJqV0lrb2FhR040WW4vbktEMEtw?=
 =?utf-8?B?K1UzQms4anQyTEYzUEM4ODJORThacm5IT3RyMGt2d3pwbVI2Z0RvLy9JanJo?=
 =?utf-8?B?akRZZUR3UTRwOVRBNkU1dG9jaWIySXU4dlQ2UndVazFwSHZxNkN2N1ZZMno4?=
 =?utf-8?B?U29waDRWVlcrNW9ldU05M1RlR3A1T0RnMm1Fc0hBSmp4dnRmcVZiUCtDRUpL?=
 =?utf-8?B?dHRWV3hHWUxyZXdLM2RDRVF4T0JJbGZCN2hMaDREMDhpWnpBQVFGS2lucW9V?=
 =?utf-8?B?cmdFbjd2c2Vnc3ZVT3p1TEh1SGNlMFNQNUxMcEFST04zR3JocjZZTkNNR3RI?=
 =?utf-8?B?aUNyV0RCVG9DajVKd3BFODJYdHdUSnY2dnNpQ1JBMEY0RG1pZS9PbVlwdnFa?=
 =?utf-8?B?Sk5QZGM2RElPR254bGxRdUVkTTBoVXU4WG90aE9jSnJwd1phTzd6WGJuUGNq?=
 =?utf-8?B?dUh6MDIxV2Y3TW95eEdPVDQzVFR4cnhjVFpOK0Z5V0FobzVOeVJWRE9rTEdV?=
 =?utf-8?B?T1luRitrZEh4REx1VWhlaGt1S01MaDNWODhCOGJnQVBkOFM5eUEyMk0yQVVY?=
 =?utf-8?B?UlRwQUJLNG0yQk92Si8xcHQ2S09kNW95Y2tzMFdVSUpYekhiMFlXaU9Cc00x?=
 =?utf-8?B?MVNuaDgzM0lSdVN1SGhLcGh6S3VTVVBWb3ZRMUxFL3UyTXJMMkcrSmNObXM3?=
 =?utf-8?B?THIwN1VGWFRJemk4ZXBFSEJ0c2ZRd3laL3JRYTVudlVJUmZuWFFUa0VpSDlX?=
 =?utf-8?B?MTg5aC96amFoUEp5bHJmZXE4VHhWVUZkZmpXUERHV3lYS3VqUy9WSXFjYU9N?=
 =?utf-8?B?dkg5ZUthMHY0YkhBMG8xUE8xemxPMTgva1ZkU0loancxRk9KQmxjRDZnODVp?=
 =?utf-8?B?QlFJVGVIT1U5UHJLM0V4T2RNSDQ2YzRTRW5rUDZidGVHUEhOLzk5YXJINjNF?=
 =?utf-8?B?WFVtdmVJSDY3SlRDLzVJVVczYkF1ZlZoekRCc0hFOXFnOXEybE1FUG03QkZX?=
 =?utf-8?B?RVFPendkWFFSN0lqVmxqQlB2RWhpbUJZUklud01VUE1HNnpNcitOOURwNWNx?=
 =?utf-8?B?am5CRVNWNlFtbHQvekJ2djlxZG9lMEZLWXRpS2d3WlRtQmJ5TUdmTVRCWi9S?=
 =?utf-8?B?cmR1QXZEQ1UvczlvL0UwaER4TFk5eGM4ckEzb2dWUlpuSmVOclM2WUY1VXNp?=
 =?utf-8?B?ZXFJNzEwL3N5NitLZjFXWUFpYVFxRXVkdm1mN01sNVhCL1Z5WU9sWWxMZm8z?=
 =?utf-8?B?ek9NS29FUlFlN2R5eVA5cmJQNWhEZDBMYmhjVUZlcFcvTVUvT1RGenZSN05j?=
 =?utf-8?B?YXVzR2s0aTZWY0pwSDE3NG1YM2hLSTBVZHRMUnFXTS9xMVdtWFJNYXhPREVQ?=
 =?utf-8?B?Myt2Zk0wSnl5OXBzdk1TSldSRmFKc0U5SzNTWGdUdVpKa28vb1NzWTVUTkpj?=
 =?utf-8?B?Y29YNzFmZjFobWNFcE9kMlNYdkdwV2Y5SENPdnp3Uy9XbWMwa012clhRQnRM?=
 =?utf-8?B?KzdlRjZleTdLMHMzbFZoNHlaSEZnK0dHQ21ZZThXb2pTU3NQRFFOYUxyN1Za?=
 =?utf-8?B?NitUNGN3S1JIeWg1bzJrYlY1aWlVeFRYK2Vic3RVZlVTdTRpTzZTRk1MYVlY?=
 =?utf-8?B?aVZPYjhBL29TMHFXZlBRcnh2alZVNUpSNkhuYTg4Ry9JTHVCK3FkYmZwZmVS?=
 =?utf-8?B?ODY2NE5kUDRqOXR0WFBEakl2cSs5dTY1NmJ5MXZEblplb3VSNGZHTXBUbkEx?=
 =?utf-8?B?VytVd2REb1VMeEZQRlNuazI1bUNrMlEyU0hwOFRVeFkvd2pqQmY0bjJXZWU4?=
 =?utf-8?B?NFg3ZGt6ZG1QU0FmaFNTNlY1blE2YXlIaU43cm01NkFVdHVwNkVFRlVkN05x?=
 =?utf-8?B?UEVUTlNRbjRNK2w4elJsdVlSb3FjcDJWSTBZd0xMNmxvQkEweitGellnTE1R?=
 =?utf-8?B?RmVGN1BSdXVtSFl3QUhZWHBNQ1o3TXZicEJQY2o0YXdUam04R0RIaVpWR1NU?=
 =?utf-8?B?Z3pzZ0JVM3JGSCtmbUx4azlsQlVURWRoK2dMVUtCQWFRcE5RQWxkQ2tIbHcv?=
 =?utf-8?B?dTdlcXZ6clBmdyt1d0xyekhVb2ROL3dGV1QvZ0psZytXNmthdHh6QWZLYXM3?=
 =?utf-8?Q?9/NwwXxNe5jfPgNQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38475795B3729A439ADC8D69AB89AC22@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l/r1cVSaIgAnj8XRqFytjGAzAdaZBEB/gDRFHQoJMa5cewpfddLtVHn0Qt857nfGpb0NhXsFs3p72Xc0nr9tQcsWr662bg9nJp5D2XD5R9TegHugckq6rdulOXBM57j7k3FlN5rdsnQWPwB8rOWe8UjKwwMWF5aLRI2kC7ywddRctA7RfTbE/hhLR450teogP07rq+qFer2CkLah9m+U3kA+d0gsLHddpSmMgmkaoo0rvY7ejNuonaTjSrZILQswbIu5KsPTzifKH43aiPKmAeYF4VmzMUB3bzyVtGjAZB9lVkZZzacayCU18vqirxvTVBIshA7beUAZKQkUDimZjw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe4c011-fed7-4d94-0234-08dea5545533
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 18:31:15.8268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQokdINhauRHVjuaup5my5LsUow1dklXAGwsKxQT9Nk5gxyxPR+EQiRNweyaQLWcNWw8CxGFJkC1AO59ePNUemJS2NvkB9suCv7jDFjB184=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8734
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTI4IGF0IDA5OjMwIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IFRoaXMgcGF0Y2ggbG9va3MgZ29vZCB0byBtZS4gQnV0IHRoZSBydWxlIGZvciB3
aGljaCBNU1JzIHNob3VsZCBiZSBlbXVsYXRlZA0KPiA+IGJ5IEtWTSBmb3IgVERYIGlzIG5vdCB2
ZXJ5IGNsZWFyIHRvIG1lLg0KPiANCj4gSSB3b3VsZCBzdHJvbmdseSBwcmVmZXIgdG8gbm90IHRh
a2UgdGhpcyBwYXRjaCwgYW5kIGluc3RlYWQgZml4IHRoZSBndWVzdC7CoA0KPiBUaGlzIGlzbid0
IHNvbWUgbGF0ZW50L3ByZS1leGlzdGluZyBndWVzdCBiZWhhdmlvciwgaXQncyBicmFuZCBuZXcN
Cj4gZnVuY3Rpb25hbGl0eS4gSS5lLiBMaW51eC1hcy1hLVREWC1ndWVzdCBicm9rZSBpdHNlbGYu
DQo+IA0KPiBNb3JlIGltcG9ydGFudGx5IGZyb20gYSBndWVzdCBzZWN1cml0eSBwZXJzcGVjdGl2
ZSwgY29uc3VtaW5nDQo+IE1TUl9JQTMyX1BMQVRGT1JNX0lEIGlzIGFjdGl2ZWx5IGRhbmdlcm91
cy7CoCBFLmcuIGl0IGNvdWxkIGFsbG93IHRoZSB1bnRydXN0ZWQNCj4gaG9zdCB0byBzdGVlciB0
aGUgZ3Vlc3QncyBiZWhhdmlvciB3aXRoIHJlc3BlY3QgdG8gZmVhdHVyZSBkZXRlY3Rpb24gYW5k
DQo+IGVuYWJsZW1lbnQuDQoNCkkgZmVlbCBsaWtlIHlvdSBjb3VsZCBtYWtlIHNpbWlsYXIgY2Fz
ZXMgYWJvdXQgYSBsb3QgdGhlIFZNTSBjb250cm9sbGVkIE1TUnMuDQoNCj4gDQo+IEFuZCBvbmNl
IEtWTSBhbGxvd3MgcmVhZHMgZnJvbSBNU1JfSUEzMl9QTEFURk9STV9JRCwgdGhlcmUncyBubyBn
b2luZyBiYWNrLsKgDQo+IEUuZy4gaWYgdGhlIFREWC1Nb2R1bGUgd2FudHMgdG8gZW11bGF0ZSBN
U1JfSUEzMl9QTEFURk9STV9JRCwgYmVjYXVzZSB0aGVyZSdzDQo+IGFuIGFjdHVhbCAqbmVlZCog
dG8gZG8gc28sIHRoZW4gd2UncmUgZ29pbmcgdG8gaGF2ZSBhIChtaW5vcikgbWVzcyB3aXRoIEtW
TSdzDQo+IEFCSS4NCg0KVGhpcyBpcyBhIHByb2JsZW0gd2l0aCB0aGUgYmFyZSBtZXRhbCBLVk0g
YmVoYXZpb3IgdG9vLCBhbmQgaXQncyBqdXN0IHN1cGVyIG9sZD8NCg0KRm9yIFREWCwgaG1tLiBJ
IGd1ZXNzIHRoZSBzdGFuZGFyZCB0aGluZyB0byBkbyBpbiBvcmRlciB0byBhdm9pZCBjcmVhdGlu
ZyBhIEtWTQ0KQUJJIHByb2JsZW1zIGlzIGp1c3QgbWF0Y2ggdGhlIGFyY2ggYmVoYXZpb3IuIEJ1
dCBmb3IgVERzLCBpdCBpcyBhIHZlcnkgc3BlY2lhbA0KdHlwZSBvZiBWTS4gVGhlIHNwZWNpYWwg
VERYIGd1ZXN0IHRoaW5ncyBjYW4ndCB3b3JrIG9uIGJhcmUgbWV0YWwuIEZ1cnRoZXJtb3JlLA0K
Z3Vlc3Qgb3B0IGlucyBjYW4gY2hhbmdlIHdoYXQgYXJjaCBpcyBldmVuIHN1cHBvc2VkIHRvIGJl
IHZpcnR1YWxpemVkLiBTbyB0aGUNCm5vcm1hbCBLVk0gZGVmYXVsdCB0aGluZyB0byBkbyBkb2Vz
bid0IGFsd2F5cyBmaXQuDQoNClNvIGluc3RlYWQgd2Ugd2lsbCBqdXN0IHZpcnR1YWxpemUgYXMg
bGl0dGxlIGFzIHBvc3NpYmxlIHRvIGtlZXAgTGludXggZ3Vlc3QNCnJ1bm5pbmc/IE9rLg0KDQo+
IA0KPiA+IE1heWJlIHdlIGNhbiBkb2N1bWVudCB0aGUgcnVsZSBoZXJlLCBpZiB0aGVyZSBpcyBv
bmUuIFRoYXQgd291bGQgbWFrZSBpdA0KPiA+IG11Y2ggZWFzaWVyIHRvIHRlbGwgd2hldGhlciBm
dXR1cmUgaXNzdWVzIGxpa2UgdGhpcyBhcmUgZ3Vlc3QgcmVncmVzc2lvbnMNCj4gPiBvciBtaXNz
aW5nIEtWTSBoYW5kbGluZy4NCg0KU3BlYWtpbmcgaW4gZ2VuZXJhbCBub3cgYWJvdXQgVERYIGd1
ZXN0IEFCSSwgbm90IGFib3V0IHRoaXMgc3BlY2lmaWMgTVNSLiBJDQphZ3JlZSBpdCB3b3VsZCBi
ZSBnb29kIHRvIGhhdmUgc29tZSBzdG9yeSBhYm91dCBob3cgdGhpcyBpcyBzdXBwb3NlZCB0byB3
b3JrIGFuZA0KZXZvbHZlLiBTaW1pbGFyIHRvIHRoZSBDUFVJRCBiaXQgc3R1ZmYgd2UgYXJlIHRy
eWluZyB0byBjbGVhbiB1cC4NCg0KSSdtIGFsc28gcmVtZW1iZXJpbmcgdGhlIGRlYmF0ZSBhYm91
dCB3aGF0IHRvIGRvIGFib3V0IHRoZSBNVFJSIGJpdCBiZWluZyBmb3JjZWQNCm9uLCBidXQgbm90
IGJlaW5nIGFibGUgdG8gYXBwbHkgdGhlIEtWTSBzb2x1dGlvbiAod2hpY2ggZ290IHJpcHBlZCBv
dXQgYW55d2F5KQ0KdG8gdGhlIFMtRVBULiBPciB0aGUgZ3Vlc3QgbWF4cGZuIHRoaW5nLCB3aGVy
ZSB3ZSBnb3QgdGhlIFREWCBtb2R1bGUgdG8gYWRkDQpDUFVJRCBiaXQgc3VwcG9ydCB3ZSBuZWVk
ZWQuIEJ5IGRlZmF1bHQsIHdlIGNhbiB0cnkgdG8gbWFrZSBpdCBzbyB0aGUgVERYIG1vZHVsZQ0K
d2lsbCwgb3Igd2lsbCBsZXQgdXMsIGZhaXRoZnVsbHkgbWF0Y2ggdGhlIG5vcm1hbCB4ODYgYXJj
aCBiaXQgYmVoYXZpb3IuDQo=
