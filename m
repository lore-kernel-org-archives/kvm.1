Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E4F374186;
	Thu,  1 Oct 2026 00:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790814757; cv=fail; b=hKdYFvkMCpjhOifMRWW8tZ0Lg8yk0Th1ePCS+2WoqefFjxby6G0TaXd8YCGBfHVtPiXIafFegm6x0z8W5DLKDzcdeER2eF4IAsxgEZvTmQZBtt3zxRgnAADcjUE/TASKWwcTi5/5E2uFYLLeEFOC7QD28LBCteMs4us7Iduyeu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790814757; c=relaxed/simple;
	bh=SfDTj2MGAhf1xgkYCrIXOqV2HI4TKJGTa+eCLnX/SG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AAjc1fw44pUASEw4etT0+2pQU0EBtN5fjOxZuktqrw+ftcvMPRk1E1Ck1C82qFuQEkfsJfeK0lF0PUrPVKpbAnhPxSYXXx0mxa6MZlN0UuOmXoGfhnv1KI5sxEJOmElaudYOs+XRsfUQkG11bpdkKGm2JZR7GDBVzWA8/qodX9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhBBr+yu; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhBBr+yu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790814752; x=1822350752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SfDTj2MGAhf1xgkYCrIXOqV2HI4TKJGTa+eCLnX/SG8=;
  b=NhBBr+yu/K0RdxEnIn/ILn0puFI9BkWo0p1KVT2wiOc+5naEoQCKKYpQ
   lNrxCDqsynTqLKc0lA00YG0XIOh0acl25ccpSwRkE+nT1qjbaBz4a+lJS
   kRRalL7zBI7/njAdgLXSw6fwFf2IaCB+Iyox+mHnUjGpZm0Qa1itDddMd
   8iWkX03A8NFjP202V/j2DA5y9cNbpaSUCerEgIQQKIongNd3cBUm/viDF
   GZvtaE6CG1HW8u9CHC4xWUxtLobXCCNrMN6tQ2pPcaRbPUUpLpvZjd7yu
   5CLlNgK1VyDD26klXhkbMBC+b5kKChS3orunXoLAOd0V8FU1Vpn0YV8kN
   g==;
X-CSE-ConnectionGUID: i95Xt48zShe2xsGUAfaPow==
X-CSE-MsgGUID: 2zRkTczWR4OsgKP0n8xjfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94279733"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94279733"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 17:32:23 -0700
X-CSE-ConnectionGUID: SJoqviXWS+ONnlKQ3b2GqA==
X-CSE-MsgGUID: Os5X8SqxQKmDnZV1sIP0JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="279142733"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 17:32:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 17:32:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 17:32:08 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 17:32:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0WWdm6ylAe2gajnXbu2mU3ywqtjzB1q3jFtjAlH6BYIvUfFbclHc1Hyo0QqA08+kC2uznu38tMe3LHm0C7oUe63yYddqNbR3CSjgA5dOXgtgWKoHjUU/rbkocdL9e5i05Oc3UP8S7vBeCnRELZyUjiXx1rxdoArqt8p7ZTfmOyHfNePRgzGHhjNzJTsrZ5BniFTGmnFCCKHp6/olVTJHkF6we/dA6eiK9tPrTCNZvy5Y/K3+YIulf48YOz0vjak0+2oWTTwzSWUR/SNN72ongPctir8roC9TODMRbGdENoPzRyoY0IbcfucM8BII39TbFyOtCoG83pxiFhaptRwKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfDTj2MGAhf1xgkYCrIXOqV2HI4TKJGTa+eCLnX/SG8=;
 b=dHIUTUBsVOPMPoRKSNx/BakvGcg95DJl4E1ayUzjTwm5t/4I73m3G222KFHzoR2u9gGdem5Ry2bCSHRA1uxJzHhGmjv6Pz2bXETLINdWWFW61+x9hoPflnGKaPWYGzGapQ+jhC8sb63YPO1HgKVdjbxaUkfv12zg7FPFRkcK1S66pkWFJMWbpXD/kfdbusc9Qfr+16CYySjX3VlkDs00P7d+ziY6+Z3CwZuRP5CvhVnDYPnHgwbz8E3Ou8zt3wurNbRAkrpkIcH1va6R+/nOjZBpVsM61OJnhQcii0F84cHDHUlgMJtDRvd6+LBuo3HM+FBvRUXEaBnm8U9+LHZPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB6736.namprd11.prod.outlook.com (2603:10b6:806:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 00:31:04 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Thu, 1 Oct 2026
 00:31:04 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "kas@kernel.org" <kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 04/10] x86/virt/tdx: Convert the tdmr metadata reader
Thread-Topic: [PATCH v3 04/10] x86/virt/tdx: Convert the tdmr metadata reader
Thread-Index: AQHdUJ5O/GOBU9oWnUSl5IE9c2LbD7bn1wqA
Date: Thu, 1 Oct 2026 00:31:03 +0000
Message-ID: <455d229c11dd2aa87133a44f3c16b2139f5e653c.camel@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
	 <20260930053901.22528-5-chao.gao@intel.com>
In-Reply-To: <20260930053901.22528-5-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB6736:EE_
x-ms-office365-filtering-correlation-id: b48fb430-7308-45ba-c2d1-08df1f5346ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: h+ZixSfoEE8PlzuEuVTRDldLFJrfo87RV4ozzaongSUneqTcOz9k57NXjz6gcyGqIY/ayqwWAxrN3/lj3pj6VmCHyPxO6dS7NV529LhTjKQ0L4IO3D4b5Y75g4glBsw0ihFJGccx0WNlDcR2q4dW12odTZQnBzWkjj4Ijdxwt6+EHXmIE23hUPZ8RS9xDT8+AL3pwFsEjnZBfOXkQcwAIlE3ZVj3xHmAdk4HWd7UamozC9ufx4ZVXcAdeSM3FPfHO2QcN5HnxGOEi9aj7MsUljg+BqHnem/mzMwwN0VypylmJYXCpNkZFwysczlbDs0stVzWYvm4Bx3QO1r+xNI8PDWqsI7duppVH5ti9gNAtbK1YcivIAeKHD4GmoeM9TcbB4WgxWS9g2Kim17jMR+8exjBr8SgUvT3SFFGcZLatyioIyehxU39DrMdtTVXiDZi12Sbb1z60o6MdHu5XPD+IOQPdN8bxKr5VYtK1YUCyfM7qD55NsdQSmnAhOWW0bI3ibQiclSARTteWI+IfZrnGzobjxkKvKggedmCCSM6UP4FqtiCJ2PM39jNNMFmwPa1ZiS+qmARCwjZraa3cZP1dfmv8UV2EEF6jkSz7kIhGRd1K/lavHKyEsnr5D5x8HAn1oOzh4kdlzQiFAvzhXCxZbdcK84RMu1Gm/fAcIZX4wToY2VkdUIxctuGDkXyUXCnBFvDKA+18RgEQuIrTHYGwih8C2UX7jlT2zIvolQ+Vog=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V00wOHg3eFpIQ0ZHRklvbDJFKzlZK1ZqRXc3SnI3QUNrUnFaTEE4QkRlZDZW?=
 =?utf-8?B?RjhXYUpzaWVNbm1NbGdSNWpINEM5Z0dBWW9IMXdHTmt0bWpjS3IwUEdoR3kr?=
 =?utf-8?B?R1BMWnoraGlJNmtyVndKNGVIZ2Q2NGJLSmI4YmlXVFgyaGNzZS9uNkZWcDBl?=
 =?utf-8?B?TGJDelUxSThvc0JzWUhvM1BTaUF1SDJsVngzQU5vT3BXMThFczAvUjg1K09X?=
 =?utf-8?B?NzV1N2VHbTlobU44SnhINjd4aXVtSHVVY2tEaTUzSkphbmRoV1U3eENSQnNE?=
 =?utf-8?B?Z2N2dTk0OENYWFQzanRWK2FrSXpWME5kd0VKS05DVEJIcGdNN3Z5NUFvb25U?=
 =?utf-8?B?TDFwQ0JYclp0UDNBN2tPUEZGYjJEVU5GbERRcmllS1BZK3VFRHpIRWhKUFhq?=
 =?utf-8?B?NERkSUxjNlRnOE9OMEVtczFpdkNDY0lYVXh1bWVHNWwydGZxUWNoMTFpL2ZN?=
 =?utf-8?B?SDkyNHNVQmxiRm5hQWFVRDFaV0s0SktyTHhxY3hRVCttRnozUGVoa1lHUXVZ?=
 =?utf-8?B?QnBDMWQxcWZmK1dTeml6ME5RemRtL2ZIMkd0TndvYlBaU3NsMmFycElhN3do?=
 =?utf-8?B?UGZQTDZuZERiM2xUbnF1Ni84Z2UwL3ROcmdGSUljZmJvNWtKOWR4VmphODhE?=
 =?utf-8?B?N2kvZlJ6cCtRRTJ0WW5DR2hKKys4dWlPOUUzMGppYW4rWUF2NmZxWXRlSWVZ?=
 =?utf-8?B?a3B0YUFock1jRTJnK2txMG9QSUlCRWR0REJDVXRTRklHTjQ1MG9BblIxMmJm?=
 =?utf-8?B?YnhqSWxmWndWRHNoTnpKemoxZjBaaEVRclBjalkzbXRnOTFoWjdMS1dwVU9J?=
 =?utf-8?B?dWkySnpqdlpud3hITC9mTWxDekNtR2ZBSmVncVE1MGVzYXZ4enR2bVh3UHdX?=
 =?utf-8?B?akQ3MzNlVGcvR3BZNWQ4azlRN3ZwUkpXUlVZUEcwbkZwR3ZicG1nTXY5WitK?=
 =?utf-8?B?MGVQNzd2c096bHQwbVpJSHg3bVQwTXpnSWVJK3cwUmkrK2tJTDRSUkhIYzJJ?=
 =?utf-8?B?VHB3SG5hUTQydnNiWmVrM2pGdU90WHoxMU95dTNzV1JLd0o0b084SDltdDJR?=
 =?utf-8?B?bTVXd2I5N0YrcEhwL3owazgzcTJVRmpIeTlmRTNZNGN5RzQyVVU4bzk4UVJp?=
 =?utf-8?B?WkdnMVBHM3hDK0s4VUhNWjhTd3oyYWo3QzZvTjJ2VjRVL2ZiR3lFQlpjV2h4?=
 =?utf-8?B?c3ExenVOYnlRSFVkcW11bE90S01RWXUyc2REVFZLdzFvQkJhS3JEZ1ZwbDF5?=
 =?utf-8?B?dFRwNzVvUEtqZThCSXFnMjVScld4bmhScm5DS3YyRkdpb25JU3JTL0MzVEpL?=
 =?utf-8?B?YWxqYjhpdFVHa2hRU250M1FHTTNCVmQzK3hGK3dTdlV1Z2JRNmd4ZjJFZUs4?=
 =?utf-8?B?VzA0ZzkxVkFzUFBXUFk3cEUwN011OGJ6OUEwNXc3NWFOZENmbEczcEM5TWdt?=
 =?utf-8?B?dldsVnZLci9RcnRWaThjOEFBZVlOSGQrK2FtK2tKUWNsOGZtV0huZjRSbXVv?=
 =?utf-8?B?WmZTdm9kVUVUa1pYS3Y2NThVL09uR3Y4Vy9BTVB6RHBPTnpoR2hmNCtRME41?=
 =?utf-8?B?dExBT09iQ1d0YkJSRVkrOVAwOG1scDdZMkhGQTZLOEdCZlBISk8yMHdBMmIr?=
 =?utf-8?B?SGVlTkFnNnMyMUlKR1hEc3U4djkzM1B5SGFFVXlSaFFGK2ZSZTBiSlJROVZ0?=
 =?utf-8?B?OUdvZnFTdXY5azk4UEpRRThDQ3ZYM0xDNjB5bmwvRkFYdDJqMnF2bEZCS0o2?=
 =?utf-8?B?LzBsTkZXUnVTL3ZLQ28vM00wbUg0aFhhM080andqWXZpRVo2S3hpekxPcjZv?=
 =?utf-8?B?aXRPSEFiWU1nZE1hYmEyd2dDU2hkZmxEN0pFbnEzbi9tS3NZS0VmTnp1NkNj?=
 =?utf-8?B?WWNveWl6Si9SVGErUDVOaUxSZU04QXlYWDhYOWEvYUppTFcvVXBKUDhJc1RU?=
 =?utf-8?B?UnA2dXAwL3ZwQTRITUtjZ3J2akgxaUlGODhZRmFSZG1PTDZVNG9pVVp6Sk5G?=
 =?utf-8?B?anFRejg1L1ZOY2M5U3YvV3ZRVkJENVkzZGRRdkE2NWdrTFJhNml4RnhaUzBX?=
 =?utf-8?B?YkZqZWhVOVJvd3U1QW5TcDV6amtONGwxaFJ3SGNMS09SOHlDY1RFQzNOUVd1?=
 =?utf-8?B?RnN4ang2VEFwQVFHanB6WVRzK1l1ZHJlbWI3d1NnVVdGU2J3aGFiRmxRWW9x?=
 =?utf-8?B?cGNMb3duSk9GM1QvZnI4bE43Wi95amtjUTQyNmplV3hueGhmSGJJbmxSenNH?=
 =?utf-8?B?WTl2N01WRUVsSWYxcTQ5UWI4Z1QzbE85Zk95WXFzaEFxUWlpRHJDeDVsck9P?=
 =?utf-8?B?L2pVUjdqZ09yZTd0UjNEVWphUThDU0FSVm9KS3FyUU95QlRYTjZCS3pVZmNM?=
 =?utf-8?Q?IaQYq/m2avIwjC7c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7652F315CEBB204BA20E86F2077BCCF8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AJL4ArdvWduYuk1ku9aNHvzPf1L8ADn3lN/+TpubelzyasQ7SI8sKOTtnhCIOxTdFUmObGkUi280VYXdPZphemdtsLos7b3gQFKGQGT5A2mDzYg2CjnAYM0wn72VL8ehecWIUAvTj/mJwPNrgvczWihjmOvXIMdt4BoWbBjRfv4BdfIgIVIwmGuGFkhGNRXHC8p9/VeELpOMB4fyqmXVBY38Vz7T8//jaOa74JMoWfw7PyJck9uv2mRcnRYCbJuefXaow5QK83HpVE/ffY4qmb0/r4Tzx1mr1ZYWPcOh0Z56jrvIx7xJMm69GdSp/EtVGYFdYY5ehhg+2i9WMnmVQw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48fb430-7308-45ba-c2d1-08df1f5346ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 00:31:04.0116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5Dx9ka8KMveKjcq8iUhsixfBxRtLcrDyjMjUsWSd9ZuhuQmpXvfBeSPms+t/divlovFU83TUwsCNjbzzRS+7yku2ER/tf0zIBzF198snK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6736
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTI5IGF0IDIyOjM4IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gQ29u
dGludWUgY29udmVydGluZyB0aGUgbWV0YWRhdGEgcmVhZGVycyB0byB0aGUgdGFibGUtZHJpdmVu
IGhlbHBlci4NCj4gDQo+IFRoZSAiVERNUiBpbmZvIiBtZXRhZGF0YSBjbGFzcyBoYXMgdHdvIHJl
YWRlcnM6IG9uZSBmb3IgdGhlIGZpZWxkcyB0aGF0IGFyZQ0KPiBhbHdheXMgcHJlc2VudCwgYW5k
IG9uZSBmb3IgdGhlIGZpZWxkcyB0aGF0IGV4aXN0IG9ubHkgd2hlbiB0aGUgbW9kdWxlDQo+IHN1
cHBvcnRzIER5bmFtaWMgUEFNVC4NCj4gDQo+IEFkZCBhIHRhYmxlIGZvciBlYWNoLCBib3RoIHBh
aXJpbmcgZmllbGQgSURzIHdpdGggdGhlICdzdHJ1Y3QNCj4gdGR4X3N5c19pbmZvX3RkbXInIG1l
bWJlcnMgdGhhdCBob2xkIHRoZWlyIHZhbHVlcywgYW5kIHJlYWQgYWxsIGZpZWxkcyBieQ0KPiB3
YWxraW5nIHRoZSB0YWJsZXMuDQo+IA0KPiBBbm5vdGF0ZSBib3RoIHRhYmxlcyBhcyBfX2luaXRj
b25zdCBzaW5jZSB0aGV5IGFyZSByZWZlcmVuY2VkIG9ubHkgZHVyaW5nDQo+IGluaXQuDQo+IA0K
PiBBSSB3YXMgdXNlZCB1bmRlciBzdXBlcnZpc2lvbiB0byByZXZpZXcgdGhlIGNvZGUgYW5kIHdv
cmtzaG9wIHRoZQ0KPiBjaGFuZ2Vsb2cuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFvIEdhbyA8
Y2hhby5nYW9AaW50ZWwuY29tPg0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAu
ZWRnZWNvbWJlQGludGVsLmNvbT4NCg==
