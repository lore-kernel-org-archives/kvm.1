Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5130BBB8;
	Fri, 17 Apr 2026 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776456123; cv=fail; b=p4ZBVmx9dkz5r3wJXRtfmJRAfogX+omuRPUWIzetX6dHdBVBTYvCxBRAiK+SHg4CyQ1joZeiw+AFLQ3HQlZmw5TJzGRoQzi+1YNF+hpBZkBna9YFhiojYAW+5ozRFMnUZZNPcUWxnaVxdHpqgafTcAdxD/Dh1amfhnXSKqDHcr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776456123; c=relaxed/simple;
	bh=Qw6Ahj7cbIKQHmDUcCKpLpPoyxyGzR3C99O0bPqOy54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SlgP5GwJ9hL7xL4kIVpznpZKniNrJFtbLBiY6X7StYgwQzjZ3I2FQvdxi6J0TqhaRSe8xyRHTnR+iITRu6/6s7iiDmte1ZlGmDqXlG3NRyZ5tyWsyKwrnCnrXwqC8GHQA7Elj5JOK13mX62WjdGv/LY3IwmsckWB5GFqbdED9hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTCTNPc2; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTCTNPc2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776456122; x=1807992122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Qw6Ahj7cbIKQHmDUcCKpLpPoyxyGzR3C99O0bPqOy54=;
  b=hTCTNPc2TNxMhh0V/bBB7Mp6P0kFpceRjLu+G7saibJo3AVaOylehShW
   9kWllQd0yF0cdB0sBPRhTAVrgLnLI4sswWm5rDHI9ra1KpitsebDUO1TY
   Z+Wuw+j57wrUBkIwIAOx+CG/wqnHUorvvQBHtvKBlcfOlqhZ5a8WdW6hm
   bLo52G2W2XjADkJVgBtLoclWjoU7aER7c9JTYqH1OC1YnHjw+3tJjmYsx
   VWlXezno0Qu+vJRs6q1r+WnvPLOeeiVnNRBJboF3OK7hBBUh+VXnHHE3x
   7Cg6WxInHZQ1+U0Mj0Df5aGt9n3bfWPDyjFZ2p4jeKmwuzSASoCjNseuQ
   A==;
X-CSE-ConnectionGUID: JQ/Nc1ZgS+iVbP7qbJMD5A==
X-CSE-MsgGUID: D3cNnM+fTSaQPcX0bB/M2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77594066"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="77594066"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 13:02:01 -0700
X-CSE-ConnectionGUID: pRw3NtjRTGmdLG12yLzerQ==
X-CSE-MsgGUID: wCzx5CgAQNOVxsz5B41zwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="230124468"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 13:02:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 13:02:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 17 Apr 2026 13:02:00 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 13:01:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f60NnVQ25PUvwrUF2dKLj3KYT6Do0smDwZYGGzUumTWgzgStd6Y9S99dy6KpyLNYCF3YptU77dwQkp4vEt0VBkNXpGrXOkz2Y8plAGJ4Mw5cSlZZDJmbgBz53ozQIzPiRCfQytF80FPtz2uAX0YWeht1k2w1awgbdlt5r98Hy88tI77de/T3jgV0fCMY4Ric1Tlft5Wa87wpQalEGjEVIpSTauUFiX6QJxp+pxDq98jYTeXkRaVLDPGcxeL/WU/Sedq08hhFHO09WWmfPUdFesD7KZ+rKEK6qz5T/LVUERj2txpK/CKBVq0SbsMfT5hKGqoaicovGVdB+oyHSkAH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qw6Ahj7cbIKQHmDUcCKpLpPoyxyGzR3C99O0bPqOy54=;
 b=ktC+giLb3Ra3khiMwWMKU6KYY2FluSTxRn4sjo0T9dEhIZeL8yIfZXq7PZKvrQiYIqjKCK++G7Ziw+uv+epetRslS+3musLwwrHkfGkm8lZu75h/49fTRELEUfn8oqh5pQXRLVJ/vHbvXEXD6o7GTh17BoMlivzk6ERie5zUBSsNOlyAVwdm3ROzMdzseGcnMHB3oEYPz3k2yee3sZJNj5OfuF9q0tnX5+4QeKQsr9O//7tE3tUouT0wnu6RnWxaUuqYXxRQCJ//+7AuXZbwons+Ls36nsl5WPGwkk6NqWdqDZJeFLKSQVS6vQ4kOV7c99vCW5nBK1EPXSWTjs9iJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB6218.namprd11.prod.outlook.com (2603:10b6:208:3ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 20:01:56 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 20:01:56 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Tng, Ackerley" <ackerleytng@google.com>,
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, "Shahar, Sagi"
	<sagis@google.com>, "tglx@kernel.org" <tglx@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "Annapurve, Vishal" <vannapurve@google.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [RFC PATCH v5 00/45] TDX: Dynamic PAMT + S-EPT Hugepage
Thread-Topic: [RFC PATCH v5 00/45] TDX: Dynamic PAMT + S-EPT Hugepage
Thread-Index: AQHckLzMgOFs0IWDNkC8x8uQeMOUcrXhIcOAgALT8oCAADLlgA==
Date: Fri, 17 Apr 2026 20:01:56 +0000
Message-ID: <7359b8e57ab944ecf44ff52f3e39cf265f00bcce.camel@intel.com>
References: <20260129011517.3545883-1-seanjc@google.com>
	 <0f25c1c247c08f19d36ca774608bc8162d2454a4.camel@intel.com>
	 <aeJnAfIryxf5Bzpe@google.com>
In-Reply-To: <aeJnAfIryxf5Bzpe@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB6218:EE_
x-ms-office365-filtering-correlation-id: 3f715c41-4905-42a2-aae6-08de9cbc2d9a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: I5m9RIev7r6QQlN0BHf+A++bMxXKt9gTU6pMd7i7fjwyfMAROhQTMoJotsvh9E046GDKsd9nu30Sxys5GU6yL5I1ep2FO/6k2kJUZ7sYADQ2QsYiCj3LtwBiQy+7O1b4JANChyLQgPfRzMhNL31WgacImTBhevGVXX1bqUmclwoHgctFqZ63rKqXA1LeLgcGT2mKG1O2EMsMFnXB+qx+Ue/zuCnJkyHkoV83nOPvm0EkQH/gdM9qs5VQiBppGR8bSg8pmW6ym4wRa1ed+s1BxXC3yup74TbZkOs0aHB1wd8MtbR9tRc+w2Kb1Dl9G/SPzNMKmgbrRw5caK0y0keNcWBYOkUtipmyxKsVEYudowUYB9rSnke2SUMEQn/Ii+pgsFhfoAyh+nPqtRq5mUVLPLduWbiHoP7PKnvRwrmq7Gba1eueKlSn5cmxFoCIhCKwxp0mBi7siUpVSAV6FrplbWeskG340BZlDp5GM3Fcnn+y1gKu6xUNppGJnj7vCStXCW17ATMXog+nHJ5nFJ/jg7wtDdwKMs7JS0AZEaaUbh/5atRtcL9jRs37dShqCda/3xQ0ErD8Yg4Vt158ifpgL48FxxkFG4p6/hb/PWWqTBPfH1eCq990cRhGUA6pLPkaLfQfWWWaZJMn8Gn1TstUaISvJA88XYQlPxnLIlfVKWaMjD9pSxESuvzc5uc5LOWnXdJZwSkkZcLCw6qoBjMOJ57YVmRBeJf+jq7FB1OJIMxtqHeXmoc4OW3FhFhhoG00L+hFklWLy/Q9YGd4fcrZ8CE2RENXMg/KHbPuRSdP5e0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clh2RC9EdFRxNTB0ZndGZGpueTlZTjZ1M200RkVFTGpKSTVEeVlXaEJnVlRy?=
 =?utf-8?B?Mm9Dc1d1OFNDM0ZvOStMb1RWSmlSM2ZLc2lqZVpGZUpNSGgwdEM1WUZ5aGhB?=
 =?utf-8?B?Wll1bThUWHQvUWdscURycEhwNlZETGpxR0VkR0ZpbHNQVEJyMExPQ25CYmRj?=
 =?utf-8?B?SkN3ZEs3ZzdSWE9DZjFUa0RzNStpSVpNN1dPcFFyS0RFbDZ0OXRUZ2V5ZThV?=
 =?utf-8?B?K3FOWGlYRm9WcTZGKzhVSWFtWmdZNjE4djRFKzVRc2poWjJKK1dwRkhFU08w?=
 =?utf-8?B?c1kvaG5kWS9TOXhud1hBTlZFaDE3ZUVjalY3L0pMUm9Xci9SSXd4cWkvaUVP?=
 =?utf-8?B?VmRYVk5EMHR1Q0VuV2YyOWpBZEIzbkNkYVZYUXB6SWE5Qk5PZlViUDBENmZN?=
 =?utf-8?B?YTZjUE5BTEN5a0I2M1Rjc1Qwc0swUnIrQmdzN0F5SENWbmN5REpSTnF4UTY1?=
 =?utf-8?B?UVlzbUZOeWljdkR6bHFRcTVXUEFFakdJNGxiVWR5VXlrRXdobUZVK3laUldt?=
 =?utf-8?B?U0oydnhTbUZqSU1jekNmYUNHaHMzM1d4UXY2SS9DNW43cTdrd3I3aHVDanl0?=
 =?utf-8?B?dlZDUE14WmZSTG1FQm9EUU00Qy9JeW5ZWThOL2U4ayt2UUEwNmZYeWZSRGNJ?=
 =?utf-8?B?WEN6SjJhTGJCRS9jTE8rbHdUMXMvZ1NMWXkrUVdRbEFGMmpHNzdjOURkcHpi?=
 =?utf-8?B?N0FTTkR0NzlIYVZXd2RCNi9EV2pIK1VhTWErOVI1c3FZeGV5cDBVNDJRYUN1?=
 =?utf-8?B?NDVVWjNmc09aQjlJUDdiYUVVT1VHV3NoTlo0UGRJTzNxbHo1aFBYcUE0N0RJ?=
 =?utf-8?B?SWJsazVWTHJWQi9LVmFYd2tZUG9ta2tpV2pFYlRBVXJNQmJJT1p0WHliUTdi?=
 =?utf-8?B?aW03L1RLS09RMUdYQUxkRng1Z2MrMDEwK0laeHFjY3Fuc0dNWlk2RWZVMWt2?=
 =?utf-8?B?Zm5oc0xPN3ZKNGFMZVB0NkFRZXd5QVB2Z2tHc2FtWFUyZlNOeFY3RFVWRHdP?=
 =?utf-8?B?TFZzQ1Yxck1sQzJRUUxZTFdNRjdseG13cFNHaC83cWhrSTZ1bGJ3bHAyZFli?=
 =?utf-8?B?eDh5VDRhcmNQeE83MnljNFhFR1pzcndZRERwT1ZhWDdTeXRyOEJRdTN6bXZk?=
 =?utf-8?B?dFo0MnJlMjNrNEw0cGFxaHdxSDI0WWgvUE1UNms0cHVsUEttVUNkamFsZllC?=
 =?utf-8?B?SVI2S0E3TklWZmFkSHVTWjE3a2ZpTGJjMDRyTGExYVl5MVBZTkNmNmFqK2ZQ?=
 =?utf-8?B?T0QvZ3FZQWhDWkpTVTdtamsyRjBVUW9jWHVVMXNOZ1N6dVIrWWdSQ2pNZHFa?=
 =?utf-8?B?RGw1Wmhidm5qNW40N0VucERZVEVHNkEzSGNlN0RGb0ZXdFRFZE9VU0VWL1Y3?=
 =?utf-8?B?Yk5XYmNuZXhZUDdXcGN2K2NRT2dxdXkwZi9YSmUyWStSUUlmdG05KzBtdy9G?=
 =?utf-8?B?YVkxeXlRdW8wTEEyMHpRWUQ1UXp3Qkw1dUxiUHVGUk9rckc1MVNLWWYwM3Bk?=
 =?utf-8?B?Tm5RbTBLajNUOE5HR1NmT09QMWVyQVVWcU5COXZSa0N4V2haM2pQcmV4Wklx?=
 =?utf-8?B?TjZoakd5bEd3Z3p5NTVSQlVXTTR6emJESWE2QjhtTlJkNE5vQVdoQXNjZ3pJ?=
 =?utf-8?B?Q1MzVUZ3L0RDOGd5eUJsSThQOFc5L1kyNVlyK3NuVXZvZHp2WFViOW9VZzRh?=
 =?utf-8?B?YVJ1OTFwR1djVHE3R25jMS91THFUNWRWamt3bzcyNzJqNjR2Zm1iUFE0dmt2?=
 =?utf-8?B?RjVoSUxjRWlWcW1neldqQTFjSlZGOVU0eGNPNW44K0xKTisrd2dmVVB5L2w5?=
 =?utf-8?B?L0J0MmdDY3FIOHp4UUV0VHMwMU5xaUd3RXJHRHY1NE1Zbk5ZK1NTT1ZjTXUz?=
 =?utf-8?B?S01MaUMvUFBpcUU3dWtGVFNpZFlTQlMwbm5EKzk5dmY0alJhZkV5QlFLR1Fm?=
 =?utf-8?B?U3c5Q2xlckJvS2U3VnEyWXV0VXJKdGFoUUN4NWxuNDVZQklMQTdwaFFudkRX?=
 =?utf-8?B?c3ZRT1BORzRaVlRnQU1ENDBXTnZRcWVrT2NKcE1IbGpIWmtLcGtZSVZoOUNQ?=
 =?utf-8?B?TjhlTVJMZVVqK1V3YTRZSk03MTZ0OHluak9TYzJEN043a3VIVVYvT3FvcVVU?=
 =?utf-8?B?R2ZUWGI3ODlBWjk1V0E4KytVWk1aL2Vwa1VqL1F5RnRxZUhkN2dQd3pWTjZR?=
 =?utf-8?B?bFNITHRsNjU5ZkNicG1nKy81dlFZdmJUbHpHY3BYWGZvcXFOeEhJU1V0ZE1J?=
 =?utf-8?B?UFF6UkcxRWNiUDljelNtWStYb0l2eHpQR1NSZUovek55ZFJUS0ttMDdaU3Z3?=
 =?utf-8?B?MGZQZ3pnL2N6QnJrZFFaNUV6NFo1STVyc0NEVFNEQzRoYXA5SXNMOUFKRG1V?=
 =?utf-8?Q?7GXMESrybXVqzJ6E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB10C1A6D30CD143B3B14A5AE51C3C4B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: scIuEjvkXrl+0kk0r+oUvVqpVoDHXG3IKrmbkMMfm0cOPItMMH1qkMOxl2t8aXEQc5pWfvrhDz69fODPzrYpy7KEv3AifK99Hw2sEWRR9Jd3YNfquUnXzvlyab/NhDKI1mJqywvmzeQT57eP43UQE3zuPohnqfHyE1mxyu7opCCD9sLg9Nlia5YvdASudEt/ZLX3mzSzqWo3tviv+WPgTqwxX7AO0qpZqK29Ic4qTHiyN2Iumn7mRc+FxA5y4bp6lkUYw4RvDef4uK3eW+xE1OUnvWhsLqpupzOyqPHZP8q7tzYZ0+vFezeb/7X4l+Zgq9GTUDeXuTQcW7j0uQV1Bw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f715c41-4905-42a2-aae6-08de9cbc2d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 20:01:56.5527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /KdokwaEn62G56G+oAluMXIoOj5GducS0CtAR3TMtGcHqPwKf1IrlRK+nnjc/I6PrJtXyT43hIOJVm+4HCDR+TXJzQGlNdPWInpLsizVwHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6218
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA0LTE3IGF0IDA5OjU5IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IFlhLsKgIEknbGwgYXBwbHkgMS00IGFuZCBjcmVhdGUgYSBzdGFibGUgdGFnIGZv
ciBwYXRjaCAxJ3MgY29tbWl0IGZvciA3LjIuwqANCj4gPiBJZiBpdCB3b24ndCB0aHJvdyBhIHdy
ZW5jaCBpbiB0aGluZ3MgZm9yIHlvdSwgSSdsbCB3YWl0IHVudGlsIDcuMS1yYzIgdG8gZ2V0DQo+
ID4gJ2VtIGFwcGxpZWQuwqAgSSd2ZSBiZWVuIGJ1cm5lZCBtb3JlIHRoYW4gYSBmZXcgdGltZXMg
d2hlbiB1c2luZyByYzEgYXMgdGhlDQo+ID4gYmFzZSBmb3IgdG9waWMgYnJhbmNoZXMuDQoNClNv
dW5kcyBncmVhdCBmcm9tIG15IHNpZGUuIFRoYW5rcyENCg==
