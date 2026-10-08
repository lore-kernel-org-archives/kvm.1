Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010E837E2E9;
	Thu,  8 Oct 2026 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791475597; cv=fail; b=Wqja+wT15xv+KrGRMGVoKBS4yshAwDxMbrDUahRDB0ZRwv10ZlrpBsL1pLXkrA9UDIb/C+lPJrV9EoCutiHOzBEE3jNUA4HoCWE2N4e2PFLQ6QLB5Ea/vgfCbTK6TyB52c1QT587Q14H8WW6Pi8yiSlLeQzKjXmOyZ5/D9+hFzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791475597; c=relaxed/simple;
	bh=Nuk+b3ORLnfTv+x1sPykELMlYz7ZIvA9cHZiLjPhvcI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hDbc4swpBll4wbKPYeuUB5z/NHZo3Gg2tLPzeXyJnEEGJ/uIIVPXxqU/Rvn52JiGnOaLbbmLqrnrXQjrCsGFnaT7eMpjp0c+XoXjB0mChw0jqqKQwuZWkvR3MPy0er1Q04SfwYUven2kYLQMOx8b73TqU1mI2NJgv9HNzyvIpS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VEZ+q77I; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEZ+q77I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791475597; x=1823011597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Nuk+b3ORLnfTv+x1sPykELMlYz7ZIvA9cHZiLjPhvcI=;
  b=VEZ+q77IokFyrUVXTsrrUFqrIf1LLr4fqvUmw7/EEsC1ChNUrmIZ2W3h
   0/oxFCaQOwKS5Q9kT0wT1decU0ViEDW41S+j+ufn22PR7T2/MBTZTB+iW
   8wojJSXS6RJDfoByq3YjeDk5bY1bIEgeOQiBVnV/9xc/CEF3fvvqjN+t4
   f6l8VcMGvTeNz5+n+FNSiRupHLAN0Yv4+Swg0SA5TU5Z4vyBlfvAFaBj9
   Onwpl5lkkpeE/T6NS5/BLV5j1aqEDu9WzhTLd9SjmwXBWT2UZWKK1W8Ce
   YOE70IphOHSHp1bW6ed5PCHWVJk+g1q08XFqYbCqeR2QaPABo1ydHGnjy
   Q==;
X-CSE-ConnectionGUID: soK9cZTkSp+jYgajtutDWQ==
X-CSE-MsgGUID: VhX465z4QreAWtH9d2rXig==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="273725"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="273725"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 09:06:36 -0700
X-CSE-ConnectionGUID: tWTel3zHTcCuH2wIeFCs7g==
X-CSE-MsgGUID: LjXF+KXvQO2HYlcKOYoM7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="89014"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 09:06:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 09:06:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 09:06:34 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 09:06:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEOsUeNyvlEM7usGl5zVw7Yf9D9mYNUPFWQhfOQV0fCGn+bJDl8hk+fhoQK3qGQY4ruTHFGc0bcVDau5zsGM3T1WpEfE79NxIznqxCz68l7dYvTWEJL2JXC8I12H7fE3VPANqTzDC9z0mK31Rz9CWAtv/s1OGn2Lyzf/ETXReNohkuvRvVFYRSP9/d2j6iHhmrKFo6zlNEigdGgnvyO0gIpkpY8PkSafYKHfP5Ho2hzMwYm/niK6y37O5cHA8Kfxr2dsdp/XjjAiMOtE2tdL4i31TbKlx/r+QFF3jiQxaHYvMBakGY2/oZvvFfJNW5LFXsUMQBKhRV9nNzHfdnToRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nuk+b3ORLnfTv+x1sPykELMlYz7ZIvA9cHZiLjPhvcI=;
 b=pDhLGlZzLPzc52FUFwRBoey2HGmuu8glkltYUCdu+yXe3iJGHk5jstWxvRo+rphb9KQTboktsS2m6kssKvSb32PcwNldNq2jQem5prAEsLaskifWmXokDKiFSCdGPZiynWWlBWIWyrnXPp47DJ4mLseFIzvxcISk3xVz0IyYdQSi4FBXtgPVkxC3WVwcBdYAz8JNYgbYUNcDFeSBZLBK+FU0EdvbfdaTLdaUxc9r5jPdn3Xm3seVl+e8ozOoIObBm/4AXBn0Grgf2+glJ6cu13lt4/DRxE2ujTkBPwRoIyUEoN6tLbbdwyy4EhSLIFN5ytwPeIqwrFwUS5Lya0U6Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DM3PPF027BB0053.namprd11.prod.outlook.com (2603:10b6:f:fc00::f05) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 16:06:28 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 16:06:27 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "Gao,
 Chao" <chao.gao@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Fang, Peter" <peter.fang@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 2/6] x86/virt/tdx: Configure add-on features on TDX
 module init
Thread-Topic: [PATCH v3 2/6] x86/virt/tdx: Configure add-on features on TDX
 module init
Thread-Index: AQHdVPFmExIGsUMl602vvqA16jCvyrbxMrAAgAHbloCAAMXIAA==
Date: Thu, 8 Oct 2026 16:06:27 +0000
Message-ID: <de96abb56350a2b91b9f1409a618bc4b90537d09.camel@intel.com>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
	 <20261006-tdx-module-ext-v3-2-db52cb05b918@linux.intel.com>
	 <51a0f0e33d523fa652b3c664ea1083a9459bd323.camel@intel.com>
	 <ascZmXRuxiiAAv2+@yilunxu-OptiPlex-7050>
In-Reply-To: <ascZmXRuxiiAAv2+@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DM3PPF027BB0053:EE_
x-ms-office365-filtering-correlation-id: 52352719-d824-450e-4a9f-08df25561bdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|11063799006|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info: kAo8HRmZmEMm062SXMnNoy5GNpEnQmESrME2I5Ojukf+kaO23pd1hAJIfSijFko0GZZ4LVok6F6g6uk8ChSdqIzLbY/nG7i9pAAFQuMP+R8zFa/KCBenhSSNE1IKLcl88y0o/zYsq2iIKt0Z6oVpD4pZmN0E11yD9dMSkMPVFnUKVxAS+ClikL/FuvO6oBg2/hGxEXSLsWscJlHUAov9WpiTntMz4czBBl23yHWlubrzgfgb+8TK6VFuK0KnNR0U/q4GO7+LpC6BWN45g3T/dd8LcVnF7ER1b5u6IXCoJl5wsrmYCWAtg9rRKbMHMhkhMyKLF8lu6jdiH4B7jg7pCDgpsOtaGVdHc/yi7vBCWerDIwa1auVcyDH72Ywt337gTD1U90evzrC5SnWllKyURzH5hquYX5Ye9+nPnKt+1W56n3gPYPNYiHcYEJV/9y303qIRtbp2YOoP99oRvNdZKBXtuexZ44L6IhPvbiKx8Q2MH3ZkByUHapP1Ce1B5gFx5Ao1Gsu++TrEw4Dt69DTlPvaRMbgUAFbLw4taqOY1QpO1mv7Dd/1mAOgAeTvyWFn+YHs0xc1YvZ1Adj7LsEsF1PBS9SYPSyjM2kkcscWZghNhS+WzVcEveimmTiOxIUfBiY9WC7FDUFb/lo9L7LYO9YWGwPbVkaPpMKTlddRqVAMYeXFMUetOjltXieLqL+ihAIqcQoqM/KD+DTgz8apFEPnnJpv+I3pN/q0/GN63iI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rzh0NzVrRmVmTC8vd1hvb01aUkhBUkVZYnlEUG50amlSOXlVaWZHbzl1VVAy?=
 =?utf-8?B?OGR2Zm9nMjFZbEsyZmQxcmF1L0JWdUhqZFd4MzJrOEJnYVI3VGRSUDJDYWI2?=
 =?utf-8?B?ZnMrYXJRc3oxdjZVSHpHRjBRQXpPOXVSYlJmaW9DcElBLy9CY0ZxRjl2K2RD?=
 =?utf-8?B?OC8zOTFJWnlOdnZCRGdYRWJKOHJDcXkvNGhjdFF5Wkt4czNId3B5L3pid1hH?=
 =?utf-8?B?UW9LZXhNdFo3LzI4YmNkVG9JdVl4RnpwSDBxSGxMeG9ZRkIrRThYdm9ZbW5W?=
 =?utf-8?B?aTgvK0xLWXJ5ZVk1TGJCc2xLSjdXWEh1dlBnOVJtcXRNbVZSMEczNEhkRWFI?=
 =?utf-8?B?dTBJekVLVno0WVNyTU9BY2EzQnd3ZXJkV1BHaEEwNGRlRHEvL2NZZWhEcm4z?=
 =?utf-8?B?bncrSi8wMUtWN0FZSXEvRDZ2RXpidHo3OE9TOW9ObkNBem1jbjRKUG5xc1oy?=
 =?utf-8?B?d1F6RXpoTVRqaVB6OElHNUZIaDFPc1ZMQmU3NXEzMjN2b0piUUwyTGFJaUI3?=
 =?utf-8?B?RUF3YmtrYXJKUVFsRmVhSlIzWlo2dXF6eDQvK3RIbDdQNm9idXhrSER0UXVp?=
 =?utf-8?B?RHhaV1BJNjNxbTNTWk5jcDAwTnQ1STA4WFk4ZW1vQXZTbnJCSE1Tck1KeVgx?=
 =?utf-8?B?TXFTM25GcG9uRU81b2U5M3piODI4VFUwVzJrOS9SeVlFMzVxMitTWHExSkVN?=
 =?utf-8?B?VVI1dSt1N283RDlDTllBM1NFbWIrSjVTRHc4djh3WjNDZE04S1kzYTFnODgx?=
 =?utf-8?B?MjEvYnlpUDFYKzl3eGRpMVEvWDBrOW1RdEVJem5rRXJYanBtMkQwY2VpNVdx?=
 =?utf-8?B?WlphaUhIbXIwOGE3SFArcW5sMXpRYUhWNFpESFdaajZJZ3BOUFhoUy94Z0xW?=
 =?utf-8?B?RGFmdXAyYXRaSkl0TVlTdVkwT2hpb1U1KzNiMUxjTVJUMGl2ZE1wa21xSEdI?=
 =?utf-8?B?aVU0ZjU2MitXZnRzb2ZHWEdhdzA3N0ZpUm1jT2YxOGRLaFNCeFpBL2FwQnhv?=
 =?utf-8?B?SGVJeVZPRHFsb21Ua2lxOFVqbmVNUHhheG1iVG1jWmViUXQzZDJJYTJpaDd3?=
 =?utf-8?B?NUtpYUJPa245REpyOFFzV1JILzNJYW5hOEtlK1hRV0RubmhLa3ljR1hMMllq?=
 =?utf-8?B?S0x0TThCWjREZjNKeWZCNjFxUXZ5bURGVVFLNDJNSE10ZCtraEgzNllIWU11?=
 =?utf-8?B?cUxXaXlQZUYwYnJIcnJNWUlLVmtROU05SmtUMEF1Y21QR3NMbnlRNUtDdHZn?=
 =?utf-8?B?eGQ3S0U4ak5NYWVaZHlKMGc0Z2Q4SDh1eTA4QWxiV2RUQjZyNDJEWXBWZUIw?=
 =?utf-8?B?MjhmeVgwNzZVSVRHY2xTWTlxVmlRdWRGeE1rb3gzL29LQjJmQXFuVFkzQ083?=
 =?utf-8?B?WElDRjJpTU9UOVpQejRpRFlFd1h0cGFRbjFCV1pTSXRnemY2M0NzODJadjc1?=
 =?utf-8?B?Ry9jdXZLTTZob3VYOHB6T1dybDhtcnVrRkhmeHY4OHUxaDM2Z0k2R1JpZlIw?=
 =?utf-8?B?QUJjUUF4Uk9ES1BEU1FsSDZOZ1ByaFllYmlya0V3cVNQd1RLMmpPbTZLOUdr?=
 =?utf-8?B?Y2hlRnR4K0pCK2tHUlhTemFBVy9oNGJDb2diZFZsSWhSZkRuNzgrWkxwSGJD?=
 =?utf-8?B?a0tVRUpLL2FPOTB2VHBFK2RFL1l2bncwR2tJZ3o1UnYrbllqU2pxbEZzcnlk?=
 =?utf-8?B?QSs2ODVXczdrcWs3Mm5jMlFEMTBENldURnNzQTJBbWMrMmtVM29Ta0M5MC9t?=
 =?utf-8?B?ZzZMUm5iZGxZMGp3UHgvTDA3RVJjUzBNeGhNNFY5cng2NlEzUUxhRlBJbThz?=
 =?utf-8?B?b3JvejV4NlJaR0VkeE1aSXp3eWNKNDY2QXJsQk82SW9iZUkyMWx2N0lPNjh2?=
 =?utf-8?B?eUpRQjZObFcxMmNJdlJMdFZydkhPUUVxRndFY0QwYnB0bHhBTk9LVmVCc1px?=
 =?utf-8?B?c0tpM3g1OE9BdlBBbFpZbTJZUkU4cUh5VFg0K2RYSjJDTStBU3k3Q0o3ZGFu?=
 =?utf-8?B?cVAyeE9qc1U1enY1R3ZXWmZ3TUErWDBpRUR6emRYS3l0aVNZMFUxdSsvM3hs?=
 =?utf-8?B?bzM4bW15NDlJOUNxSmVaVEJ6U1dLYzJFQjlrZkQxV1QvY0JhVnFGd0dpTUVM?=
 =?utf-8?B?R0o0dzZ2NzJRTnNDWHZpQUxEL3kzTGgwT1JJZUo0dlZHSVU2cWtXVEorR25p?=
 =?utf-8?B?TzJvbi9mSFdKNG9OQndRSGdkbitmNkJ6aENYZGR2ODQvSVpVWXo0dzE1c1Iz?=
 =?utf-8?B?bjNFWHpOaDJkRVYyKzl0WGZ2U2k1Q3RsTHZqUXZQTE45UmJkT0w0a2VwekdG?=
 =?utf-8?B?Vy9WeEJvN0pPZG9iWE80eVB2L3hUTzlXZkdnVjlWdStoazZCeTRUSHlmakxK?=
 =?utf-8?Q?JLvPWLhbQn+fWPBc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64C755A50C7C874A810EA9DF8D509C17@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Kh91Ncaa7DIfJp3Rhz3nE3DFu7Vzqae0fW00fKpTG1IUFnKxP9xedb//ZcW2JYenj8OgLP7c+nj1OSN+birgHD+Nz0Gn/TBuksg8Vzyjk6HSyv75vsZcwV1O3HaNJR5WC4YlpYN8LHx9TtkcQ7EC+VQICxmnBar1i6rXvPRZeqJpSVpH5lQVTjSCCFrybDwSWHJ8JSo9rdeJJowFeCrBFZKYG5Z2TYFGCaXETJLFaPHJ09TrskIqAh7zbIJGQUwJdd2uUo47Kh/cAr7ZXAt9ZyKsRH1GJ4h6ydlQWBQGdUg2tNW+ZxpTkUfVzgFIFbh078+NvmAB/Hi/wJJdXBMphg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52352719-d824-450e-4a9f-08df25561bdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 16:06:27.4350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yKagrPJk9SeGIDbDceKL8il2NKh+rjmEi1cURoSwbxFktEdqiFGTLGOAPqNHanRT8QFv7qT5r6bh/8SeVgwtrP5sd2oBPcOSANY5Ce90g1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF027BB0053
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTEwLTA4IGF0IDEyOjE4ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gSG93
IGFib3V0Og0KPiANCj4gCXN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgYXJncyA9IHsNCj4gCQkucmN4
ID0gX19wYSh0ZG1yX3BhX2FycmF5KSwNCj4gCQkucmR4ID0gbnJfdGRtcl9wYSwNCj4gCQkucjgg
PSBnbG9iYWxfa2V5aWQsDQo+IAkJLnI5ID0gYWRkb25fZmVhdHVyZXMwLA0KPiAJfTsNCj4gDQo+
IAkuLi4NCj4gDQo+IAlpZiAoYXJncy5yOSkNCj4gCQlhcmdzLnZlcnNpb24gPSAxOw0KDQpTb3Jy
eSBpZiBpdCB3YXMgd3JpdHRlbiBpbiBhIGNvbmZ1c2luZyB3YXkuIEkgd2FzIGFjdHVhbGx5IHNh
eWluZyBJIHRoaW5rIHRoZQ0KZXhpc3RpbmcgY29kZSBpcyBnb29kLiBCdXQgbG9nZ2luZyB0byB0
aGUgbGlzdCB3aHksIHNpbmNlIEkgdGhpbmsgaXQgd2FzDQpkZWJhdGFibGUuDQo=
