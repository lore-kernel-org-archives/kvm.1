Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3BD22D7B5;
	Thu, 16 Apr 2026 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776303743; cv=fail; b=YLTGBdkED5aJ/vfRv4LRkTG/1wCY8+1+J8wr1jW6iClYahwE4bc4DDKE+MDYulXXlQHqvaS+peelVAYfGNvJ0tcWShxI5BePClcQfsD1ChzQtkCzJ/SoQ6Iqqumn5zwHmIG1fVgbDW7NqvbtEmDoS7uOF2pgVwuieyPtU6nO+ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776303743; c=relaxed/simple;
	bh=v2XBdQEQyrG+Xk6CdMmaJM0mo2FFg6fj4/j1evfkzdg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I2RmuTWyHCXNI/BUW/mH3AHTz9555Lh+sUkcWpPvwQbaj2mwCSELCXBYN2UhWtZ9CopvWemn+i+vvUP22KZB2+dxDCVNf5iczkwDpa11Rk7bqRB7iai4C6EvKLf0fmNWjXhyHcHaJMRJMh1ll4ysY8m4WXFkIeqSJwZrNOY3OMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnyD3+BW; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnyD3+BW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776303737; x=1807839737;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v2XBdQEQyrG+Xk6CdMmaJM0mo2FFg6fj4/j1evfkzdg=;
  b=hnyD3+BWKesxkw9bANUvE3pQxo0jytGeER3/d8HALOUDpypu9cp6cLXD
   SKO+QSp63dRIjYleRPK0Lx9//lT761TfL0g/DELyMx+BRjffnOXZniZNY
   mHBAAyl7v4SNwuGKQfSoHA3z7go3146RE2v7rP4E83rVLO0emUc+3VrAK
   PT+swxMqG06gAEBDx8bteH+rS5C4B/uNuSkON0TIscjRs1Lia3IKxpPmP
   AG05PeqHZfUaa6/Wzb6W6skNyFeN0r8ZxXaPJyjhAtDaGOrbvlymsymRu
   qKj81TFKRx2aAUp+TcnAvHeOsmKbW+BWzKJKgSVFLQ304mpp1fm7ifgoG
   A==;
X-CSE-ConnectionGUID: TPSZYsgfS3+0ZdZBd1Rwew==
X-CSE-MsgGUID: WfuiQw6fRDun4Xe2JYNqWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77313728"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77313728"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 18:42:16 -0700
X-CSE-ConnectionGUID: 431d9q/sTaWbGboVy+zZBQ==
X-CSE-MsgGUID: 6+qfbJASSumD1Cp3tpT0Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="234964128"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 18:42:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 18:42:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 18:42:15 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 18:42:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdglHsi799Bbvl7r0G6EmoH/3u2o7S6cpRXsqBjO01aQrhop+3Yt2PxRXBtkupao3WeT+GmKCDYQ8NE6meUMzydQ00W9xXZk2ls9OxcHA4WoN55xyIu2w99jDBZSNyfMxoyEIVHN+6FdMNCB+liqcXb2oi/b6v6qS6cCUGtsYaj6FCmDx2yMgKJno9f4r8A4e5BOXpKI8j9eeh9yOV7xLrsEdg6O08AIN3pCyLHkmBw0CNKbXFUZW5+Zei3ba5tQl+T2iVrh0n5szfGXbZWr3K4j5uN9o3j8E/nGJSl4ckJ5djdRz+cBNLD22qw0RXXtHsC7KyiDwpsL9k2KhTHzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2XBdQEQyrG+Xk6CdMmaJM0mo2FFg6fj4/j1evfkzdg=;
 b=VqTja1bf+jUhI/h79voCrvqibhyaa+7L+UAM1JDqSkhKmDMO6PYt6tT6miQbkYPR2qIL6eCkBdEWX6DN2ftw0R5Yr10/KhdWxckH4PkiGD7JgaLTsRy0P3A+DvZ66aQJqNbJYpROt4Aee+ZFNyoY6AdfwYS7FgVFGU1cMDYJUyNMk8sITy1WY/oQ8q8PTAWBEJKo2wM0lTND8pSUXLVNxJ5N4p7wo/YqXPezYdMHbMl0ufkKry2MCr9Q9yeKiCECHVh9N6+yUUcgb0R59vz2JBrzL7M0a2UW6bM3YKKIQ6cKsQMmU8+2FxYDpAuuL0YNd8X6fYBx5qykLSLHxO/q1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA3PR11MB7656.namprd11.prod.outlook.com (2603:10b6:806:320::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Thu, 16 Apr 2026 01:42:13 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:42:13 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yosry@kernel.org" <yosry@kernel.org>
Subject: Re: [PATCH 10/11] Revert "KVM: VMX: Read 32-bit GPR values for ENCLS
 instructions outside of 64-bit mode"
Thread-Topic: [PATCH 10/11] Revert "KVM: VMX: Read 32-bit GPR values for ENCLS
 instructions outside of 64-bit mode"
Thread-Index: AQHcyHzxtT3+BPhg5ki9CODwDmR2bbXg84KA
Date: Thu, 16 Apr 2026 01:42:13 +0000
Message-ID: <d0e331e029c2d2bf367530e86c50af026b0f2ba2.camel@intel.com>
References: <20260409235622.2052730-1-seanjc@google.com>
	 <20260409235622.2052730-11-seanjc@google.com>
In-Reply-To: <20260409235622.2052730-11-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA3PR11MB7656:EE_
x-ms-office365-filtering-correlation-id: 3113cbdf-658a-434c-821a-08de9b59624e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: U8JLUYDlzMX1FdunM9iHZb0Hg7qyEofUIT4ZC+y4dkwQat31brH9ebAWI+HUibCfRIkb+oZ3wWtAWM7Z2TYcNq9ZYCAlTJ2WOclIJciTbaqcMorKIDyHcVq8nCB1D7Eqm3JbTfXuzbX/UKAYJ6BoTpQGnXepSLQsdH0e4VdhX6F1MSPLrdFsBaN8FiFB8wp+IyT4+jW+HZHL2mpCDtTD6gl8lmBgR8nk71FN1BTVpcuYIQZR2RQhpI38B90cNVeykhEIkbWnIz9ikXR9C4G2sqEfXaft/R1KD41kBglr/IoW3TDcEtv1DJ9JkdmlpR07azDXlTL+amt8+pFbU7UhCoWx35pskaqpDdO7TK5USvO+BdgI3i1kqwsXW8ue+5VQnPOGsw/8m0XlE2BwsCmuSkxpdfg3579Kwb4yqqTOe4QPENXcl0sQ27mj2cQpR6cUZ9NiCgwftiocs8d/VQ5UvFI/EyAlFAcEKqwG4aXCVK7uafIoEWtAeKPTopAw5q1VkRBMBxBt9rt9sCJTb67q0bco9ocQK75C40vsSX6HBp+L6E2tRrd692CqJRVztZkNUJm4fo27ZAwUL/NKjM4wgqPqv/GFdhgf9Kfrc5DyTWV6G8ySmmL5YYzyD6RVLmZSAwjzLpNotOmFDvIHFWGsyntMe968jQlhlih8/C97NY8YASIXSt2p6b5vrnJcctZTzPII9JTXhPzrfGlFHijd8s5HgVAKPr+hfXsvb6Y/w0BDuMTpRrwDuhU4wp7jvUdD2U7fAcxUUqOnYlVIpDZiVNjygoOO4MMSvek61Z1K8xc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVB5eStrbFJIWGx1c0F4aUJ4YlFPV3ZlRjU4QWx3dS9UdmVGb0Y5cURNOTI5?=
 =?utf-8?B?aEQ3d3F6OXdIRHp6TU4zbzdVTmFjUkFCRnArd0FXU0tIZW1MZUgxT1d4QTlv?=
 =?utf-8?B?NWZZSFpsbkNaMDJ3UWRCTUJBWCtVQ0F5RUlVZWRVVHVBaGZtL212Uld3TE4r?=
 =?utf-8?B?enA3S2x4T0V0clcrSTdXcUNzNm1kTittVGJUQjRYWVFEdElaR2VNaEt6T2lz?=
 =?utf-8?B?Qy8ydS9oYkIyTkNyU2dweGxSVkc2ZjFUTlZSNm1tb3p5SVEwR2RTWlFHb0dh?=
 =?utf-8?B?cjFUUHBVYnRNYXdiNmdwcGYzNFpRU1FLbWVFejMvMFBLSllqbzBUVDNRWmg0?=
 =?utf-8?B?V1B4OUE5Z1RjU1JIL0JkbExqRmh0UzZpaUN6bXZTRW13S2J4R0QzZHFGMkpT?=
 =?utf-8?B?cDN4c2dEY2FnNlVzUThZSGNoNTVZdjhIVG1TbldGalI4Y1JpN2Z2cStMT25t?=
 =?utf-8?B?Q3FNQnl0MC80R2NwNk5mNnBCUm1RSFVRNDE1d0c3c3RNMUJuWXVoemxacFRr?=
 =?utf-8?B?eGpEZXZLTXBPU3AzSGoydWtkdUlGMTUwYVh5OU1YcUtlR1RPck96ZzlHdXR4?=
 =?utf-8?B?MERSeFhJK1RWbG14cVFiSUVHQWtVK1JnbEYxNFQ3WVBUUVQxZFVSYXdVWi9v?=
 =?utf-8?B?TVV1TjhpMXB0akxwSUJqd0FZcnV0djIxb0FQMkN4K0pyU1NWU0QveDhteFlo?=
 =?utf-8?B?ZVZkZ1pYTnV6RGs3TyswejRhRjFZMFJMeTNmcGRzajBwak1nNGdPY0ZmRWl1?=
 =?utf-8?B?WGNWOGJVN0NYOUt3ckZHSlhiZXV0aitESk9hL3VESm91NUxTNVgrREZoVmln?=
 =?utf-8?B?NUViOE9yenJPYlRLQXB6WlNBaU0zOFVoU3RHaWpoQjRSTXFuYmszWVcwckEy?=
 =?utf-8?B?Z0gzbEZUaHNNVjR4T05NcGZRU09OLzA4SXlNMzVIcG5wTmlCVkFtTlRFckZi?=
 =?utf-8?B?ZDM0YkNqMEtBUVpydFh6L0hwVFlMNWVydGptZnVSWnFYQk1JcnVBQmF0RWZY?=
 =?utf-8?B?a3g1b1lyY1FvbmpXZHFQUzlzdEJpQ1VHaWlta3ZFQmNEK2lIVEZOK3NCSlNC?=
 =?utf-8?B?NE90NU9Ia3JuV0NCejc1TlViQ2JLRENERjBrTE5xV1VXV3QrL0J6QmRXS2pi?=
 =?utf-8?B?ZFpwMHBhSk5YendoVzdSNjB1ZDkwY1htMHlvV2pScFU0QnRhdFBvZFlDVUQ0?=
 =?utf-8?B?SnJwczIwdXEzamxKOUVoWHJUUi9OQlFwRllleG4yM1NCS05Ua21KMjcycWE1?=
 =?utf-8?B?bjFKektQcmJ1Y3pPU0ZFU3hPQnlJQkl6MEZVOGM2M2VSOWZEN0x4bTVxZWNy?=
 =?utf-8?B?dlNINjZzamkxWlM3OEFtUFpCSlJrTHZ1a0xSZ2llQ1kxRUUydVVQUm5zaENM?=
 =?utf-8?B?cVBtOWUwTzNuOVFhaGxnZHpCODkyc29lRHI3cWtURTVYZ2lFOXFPb1E3TWg0?=
 =?utf-8?B?SXB3eE5mc3Y0Wk0zK2RGaEpGcU55aHlYUzdVbzhXN1lFdkttY1NBQm9CamZo?=
 =?utf-8?B?M21Pd0RWdGM5VkJpelNQcjk4SlRJdytsam43T21HaExOb0ErdDh6aDl6VmJt?=
 =?utf-8?B?bnFQUGc3dk4vZFpGSnY1dEtJQXlmKy9hNUoyVGJTWGNrRFZjWFZRQ2FXaDFr?=
 =?utf-8?B?aHFDSDdpWWdKakFCT1pqQ2tqdlB1c1JnTlVBZ0lldnBFTGovb0FuYmRTV2la?=
 =?utf-8?B?QW1zbDlZb3QyRFNYSWZzU3V4UW03UWVuQjk2eWJxVXJvUVlvYlcrQlM2ZVhJ?=
 =?utf-8?B?cW9jRDIrSkVtQnQ1aG83dDdTeXhuMkNSTmZVRm0vTzZlQzRlVjBteitpWEw0?=
 =?utf-8?B?RW8xZVlyaEV1VjNBdHhKNHJaK3IzWUo4UjNLK0pHQlltVm1CSnJjdmR5Mmkx?=
 =?utf-8?B?SXRMbEhmNG94Z3lDZXp4ODY3eGgxQUdxSmt4ZkNkRkowcy9tZXJtMEtmd1Zo?=
 =?utf-8?B?T3MvUWYrMWhuTysrZ0U3eTVIcGNsdnIwazV2dHYrbmRGc296YW9IV2xTL0My?=
 =?utf-8?B?cm5PSnhGNHRLQklHYWNwU2hMaVdYUGdDdHcybTRiRmlzOGdzalFGdDA5bDY2?=
 =?utf-8?B?aHo3cTVQY2djWkRMbVJ1TTJONXBWZFUvbkVYYlJrMmFVRjRUT1hVT1RnUGEy?=
 =?utf-8?B?U3RJa3pnRFBTNTVabGVRdlZHOHFHMVk2SWFaTVovaS9KdVFjTUFDOXFINVRK?=
 =?utf-8?B?SktyRTM3bVpFaStuSzBjMFNrd05sRTBQTFRYWFlMWmxQbVZweTJsam9jRHd5?=
 =?utf-8?B?d3Yzb25KRXJjNUxZdHZQWGRTM2FQSkRhZUJZVHNYUGVuVmNqcXVqOTNMUUZu?=
 =?utf-8?B?Ym4wV011djgrMmg0ZURoeXA5Y2hWK2JoOTVYZllJdmtlWnR1SnllQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51088FFF6621F247BC352C29552513FC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IRCRMjgcSSEdBYNT0oi5I73sQKhPxXwkdHB4HTwXPOWPNm/8FAiZ/E9XP8yllPVz2iLD8RjL5ZDVH+vs65dJLUqjrPxXJy0HjUlw2R8EJToGTEvEMOPAfzFlp4Dy7q53AyXs5e9R1b/uoHXP6+TD78QHA6K1fTMDW7FJ2QOOFu/bNGKUiWHZ6bXKMSJzAmEJS0nlQMD9odONwn8xTCGE2Z+yQfw0vianPHCZqLJZdYRSOswi5BBLnf1rU8JAVbagNCysoXX/+GUTKhYPoA61jPvF5nYr8WjYETbhMovaS9S/WeSR9CLZ22/13TLoHq05+W2RgEqpJdQ3X0zbptWNBQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3113cbdf-658a-434c-821a-08de9b59624e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:42:13.6306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YMxPTCj5wnYEZw3k26fFuRXmQIQAFwROfh3tS609hGbr9+nmje7j9tyOnu6TJU1ovSFVyCFoZkfbTrXQQ/9Lyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7656
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTA5IGF0IDE2OjU2IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBOb3cgdGhhdCBrdm1fPHJlZz5fcmVhZCgpIGFyZSBtb2RlIGF3YXJlLCBpLmUuIGFy
ZSBmdW5jdGlvbmFsbHkgZXF1aXZhbGVudA0KPiB0byBrdm1fcmVnaXN0ZXJfcmVhZCgpLCByZXZl
cnQgYWJhY2sgdG8gdGhlIGxlc3MgdmVyYm9zZSB2ZXJzaW9ucy4NCj4gDQo+IE5vIGZ1bmN0aW9u
YWwgY2hhbmdlIGludGVuZGVkLg0KPiANCj4gVGhpcyByZXZlcnRzIGNvbW1pdCA2MDkxOWVjY2Y2
NzY0YzcxY2VmMzFhMWFmZWFhMWEzNmI4ZTVhYjg1Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2Vh
biBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQoNCkFja2VkLWJ5OiBLYWkgSHVh
bmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=
