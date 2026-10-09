Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFCA38F649;
	Fri,  9 Oct 2026 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791572595; cv=fail; b=SLDbOFzLB7rTZIbuMRp6EWcPip+rWCnu/rRYtuz9355c3QueXE+1JQrRyXZ9MACf8Jhs0x5D7xEjGmzLaxWlElNiMaKhtrZFaq/iMBIQYgeHvldR0cCS25TulLLPkfSFLZ2NnpAJ3LucyNnB9oA1UC8peDFq+5jTXigrO/tl0Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791572595; c=relaxed/simple;
	bh=ltiJ24Xy/sKol5S8KrE2dnbIOrb7xLSZD9q3PGP50cU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d8wfLjh3ZTRs/tdgwvl8YAaBWD1jkj0XGPf+us46llw5ytRA+rXOMZKH8jExatsJT85Zre5+DxMOH2zURbFaa8adx4OVj7xD5FZaB2+jdck7QvVe70N7fQPFqfX4NY60jflItjcmiD/4PDEGTLEgbki5pnsBrxmr9KnEepuXDa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MB72IMRm; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MB72IMRm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791572593; x=1823108593;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ltiJ24Xy/sKol5S8KrE2dnbIOrb7xLSZD9q3PGP50cU=;
  b=MB72IMRmeuKqSIMXTxOnHr/HGjD/XmLue0ft6wVllVggJnOlG6c6US7p
   mhzi55mTIr9ftkXRzD1+yjnBDKY6X0OKVQujek1mtbpYjOX/ldexJOQbv
   WLGDzRiB0AFXLsQONkY8b7jYSqi+B8ZYynHxFzf13ko/kXNJ7CScBF/c6
   gVg8kyuyHEFdJCAmw3WUJeI1HJLS2vyyx8i5BCY6qOnwTA8fqoY6wWEto
   cHLnN8Or31yNFpfmOHX0ttUT/wglYN5OzuSYn7hCNuzgfpCtxTtCyl+KS
   jEaP7VhNUnNPLBsv5xeQP6wE+ikC/VjEodokpu9cG0spPzxJzHx6AQakB
   Q==;
X-CSE-ConnectionGUID: oFnemtnsSbGneIGDlX3ZeA==
X-CSE-MsgGUID: 6gsi3SptSxebakHZ5LG/WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="380416"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="380416"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 12:03:13 -0700
X-CSE-ConnectionGUID: aLRd9me2QrOud/kT3dDuFQ==
X-CSE-MsgGUID: 3vuvXX56SO2TkQyBuRyWww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="704964"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 12:03:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 12:03:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 12:03:12 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 12:03:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2CIjXJPDsbp1O+ciwiqWfk4fLwpmch1/MwGhms/sTq+n6CqLmerCWaS9PJYb55E43s1/2NRMcO0O1lu77xf0qSzhMWUP2TzvxAnKmObLgUALdtkVxbD06DYIq8JKgW/cXlsXM7H8PccE+ZsFk9KbgUTpfzvwNc089nhqpPSULZRjFfj9zAPmLNb9XnQPPseNPbgqhY5IypAdk2BqxU8W89DVQQY+MQtl4L/GtKMhDjAOP5JjSBoNUHbWVCEl+BLFIniWska2undfwUYKZ8fOzKmgPnh0IUrIaHvH2CKBKUSaOsSyYUNv2Y0pAttWHJngIGfBpibuTlNThowrlgrzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltiJ24Xy/sKol5S8KrE2dnbIOrb7xLSZD9q3PGP50cU=;
 b=saR8J3++10yNbY40kkkLvvjZg+hJS8f49bfnJwRE+klDZs58ZvQrotx8KSh4D20ISp93Nt8bT86z+EvfO4errHfhbRDt4b0sqqQ3vMJB8VBl5e8ADxhkgZrKBiRuNzLx/YO4FoPdmGsZt0dCGoorePUkwcwjt96+3dK7vHeL1yyOzZTrSagKDm5z5qVV57efD7m9Zb5mhDfUBCt7eUcdIzq2A94U9ak7a3UauLRBRN+LFxm5WWBrvv/b7+8PQ7ZZRK18qgmBezVxghQ98W046QdXeVpnFzKzZ22NIZANVJgyke0EcySBjNrkT92nIK4SZaM7+/2JKGBbAr2DiEu4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH7PR11MB7124.namprd11.prod.outlook.com (2603:10b6:510:20f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 19:03:08 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 19:03:08 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Xu,
 Yilun" <yilun.xu@intel.com>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>
Subject: Re: [PATCH v3 4/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Thread-Topic: [PATCH v3 4/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Thread-Index: AQHdVPFs70AHzD0N+E2vRzbscozWBbb1l8CA
Date: Fri, 9 Oct 2026 19:03:08 +0000
Message-ID: <1b142a6d4f4714796027876e765c0c27ae770eab.camel@intel.com>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
	 <20261006-tdx-module-ext-v3-4-db52cb05b918@linux.intel.com>
In-Reply-To: <20261006-tdx-module-ext-v3-4-db52cb05b918@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH7PR11MB7124:EE_
x-ms-office365-filtering-correlation-id: 673d3d70-58c2-4c50-e6fd-08df2637f4f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|23010399003|376014|10067099003|56012099006|11063799006|5023799004|6133799003|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: gdjlkn12CwhXUP4sqHrJVrhwTp/7W42jadVt23pUBiu5G0rxhX3EgSe3DlyoFt9pFxnphPXRBAtx+gDD5zTz7OQRqm/6rKyInOcUMWWxg2j1W9l6BOom7ocbAzzH9j6O9dnCSBQfOQ1u0/extjI/y+HylZsKhuwp7W552iobs4hvksC2HEtxrRiFZNCqLhz5C5rx/jzhdVkbgTDKfWn11ZbZBTPNCFsZx1MMg7+5ajrJWFsyy77hiPt+2+7s8FMG43NKOLWVgLhhEGPe5YlL37nw5+wAPnapREpNxA4oOq85Sl2ybfDnvPNTwy48iKGKnMDv4wxt2jLA8gNN59OZ1C5B8Mo9uEPqoX1Dk6bDEUMjoz/sJ631ymgUdOQ55lcc9wFve+IJSIBJ1v9ZIc5iD8XD+TPL+xEc2bgLAqla8FT/c1s93LUKI5iSG2xOZMDnwk+pD2cx5Xrkz6d0823lQ4CcTSxL9sbSMETtm5d6Ju2sFfuuzQhDD3FSeQnW7GzdqXx1PgmkiyrAGcTmVD+oF7mE91aTvBEmafrNgJUyVdhVkesAA0q1TxoD7oz7JXAApVUjFU84louHsg8e6Rm1gmsqJ56aKuO1qG9WdNoSCKX1VZ/Mlbcxx6QQeGlyLEcSo6t6YpNqHB8aNPEIhrj68GAeEFK2A+9GxtXAZxniDcushpNBBixnnwP8CdXsHgKN5VeIvcxFUtlccE6AB+6BqJfc9Xk6i63MQFBYEaehaOQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(5023799004)(6133799003)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXhNczYrZktIRUJWYjdTSzNjK2FWTUZ6ay9LcjJPY081MEFMM1cvU1ZRTG4v?=
 =?utf-8?B?R3NuTldmQjB2SUprUWZMWjVxbm5PdE5wdUpNNUhwbWVxQlU4bzNBbHMwd050?=
 =?utf-8?B?c3plcmp2TkR2UE1acDFkbEh4K3VTQmw4aitmbHRSdW9Nbms2N2NId1lmUUJU?=
 =?utf-8?B?cDBnb2VGV0N5TjZNY25XT0NBSm13RHdlbThhbXV2eUNobFZYZVlrSTNZNmZL?=
 =?utf-8?B?THFwUlgyWllzTXR3K3g1V3RrOU9STzdvK09UdFZoVTJPVE5MQm51SGVPSVQv?=
 =?utf-8?B?VU9UVUo5eW9jSWhJbUkvemk4SkMyYklMQXpzNTRkRHYzdEh5YjlEaE1PTmtW?=
 =?utf-8?B?WHN4emsxdWRVUkNxYi9wQzVlanZaVGlGU2tINWZhOUlwdUZGRlozOHZidXdp?=
 =?utf-8?B?YktQaEE0NlRaMEwxbTAvZWVnK3ZRTEhxOXhLTnYzZVp4YnMxWGhROG5hQUtJ?=
 =?utf-8?B?NVBDZU9ZK1hLMmhtQzB6bldFaXJuRmxrTnZCVk5KNDV0dE5qa1hkY3FySHk0?=
 =?utf-8?B?WUZnMmZkb1dVSVpoY3BKVUt2M21Rbm4yT2oyT0xGd3ovQ3E0emNPRVZFWHkx?=
 =?utf-8?B?MFF0WXpmWVMyQXBML1RVUVg0cGFJMDVlYTFkc0RzWERUekJsdVhSOW9CVDlS?=
 =?utf-8?B?R0xtcG9sRThVbDNmbjV5alVtRTNnSG11L0cxeXZpYXpoa29jQUV5Y1lRanZY?=
 =?utf-8?B?Z0VyQnNNTC9WeVBwTEI5QjNpeXNWYy84cU00a3F5TDl2MUhOcnl5bmFhc3FU?=
 =?utf-8?B?TC9PcXlGMnExZzNubXhhc0pscFE2ZjJQaTV6eWlSdjBxZEIyU0tVZ0YyejFX?=
 =?utf-8?B?ZDU1VmR2Y1VLS2VIcU54bDdYUnIyNWJBeDV0UmRaNkJNNDJPVnBGNTExZTAr?=
 =?utf-8?B?YjBOdGt5aURVL0lWVlU1c0dKTmZjeWZIenFrbHR1N1dvVjVFcmVJZUVxUVVu?=
 =?utf-8?B?UFhrMFlDY09CczlnWWx6UWpnZWcxRlRsK2piMjMvNS9pUjhDbWlKaTUyTU5M?=
 =?utf-8?B?eDdzTjNSYkZVbVB5aUpMMFlOVkNlVmt6RE9VQWZPVEgwOEFMNWJmOFUzL1Bs?=
 =?utf-8?B?UTFkbVRjdVgrVnlNT203UE9Jb005YWVTRWlBVUNBbk9LbXdwNHJrM1dPbEl1?=
 =?utf-8?B?TVJsL2ZSTDNYNnFkMnFFbVpFUmFRZW8vZVBKZlBGc2Z5bGl5ZmVVZC9NK1J0?=
 =?utf-8?B?V3FmV21WaUxNQzAyNUEyckVteEVPbDBTZ3pzV3RvanZ5NldXVUVZdEpFM2gy?=
 =?utf-8?B?RjJ4L0dadFJMV2ZCRktlZEM3dHdjSE1MNXdlM1hPM2g0cnpkelpkQWxJMS9G?=
 =?utf-8?B?Nm10NGlkbndIRzY4NGpNc0JtNEptWjNuRUdjbFFvczBuL3FRMU1mNW1jTVFI?=
 =?utf-8?B?eThwVEhUK2pNSEhqd254S05OVkJSUTlDcjV6aEJzdFlvNkttYXFpMFZCZjcv?=
 =?utf-8?B?VGxNTTN4akFSWGxxRVA4bHNQcXpVbnFIV3lhbFVFUk9JNnRMUEtHWVRaZE5R?=
 =?utf-8?B?SmVUYXBMbytnZU80ditZdUQ1NURKSVIzTFdiZklmTmg4ZWtxdm1UR3pEcDc1?=
 =?utf-8?B?ZTNhRG9GY2Z1MnV5b0pYT0VOVDRjWjgzRE9uSXJzSVY2M01OWTY2OFp2Q0dU?=
 =?utf-8?B?Z0RHdUk4T3BuSk1jMHpEbjlFMHdMYm5aaVNMamRVa2ErT0FhUHBaNnJrSjlM?=
 =?utf-8?B?YUptQ2VDTUlWeFBkNnB1bkpTMmY3Z0FWRllSSmIyYW9kL1YvRGIwWU9GUnhJ?=
 =?utf-8?B?Tk9WUy9kczN1WlZrRTlhQzBDUmFaOElZRisyaXBWcTdIQU1JS0pOZ2xYVTJk?=
 =?utf-8?B?VXcvc3lpejhlZmdaRnlzSVR5c2oyTjBXdy9GaHo0ZURyMkhEakpoYld6NTVO?=
 =?utf-8?B?OUh4aHRsUUgvK0grTlBLZnhnQk54MFlSVUNCbzQwQlIrV3FOYTFHMkxzUE1C?=
 =?utf-8?B?dmtBLzlsS1hCWDZGdmRCTVJoWXJKSThFekIxM05IWDh1amZsdXY0NU15SW0y?=
 =?utf-8?B?UURaNUltbS9KQXVzVjVNM0hDZGJ5SFM1QzNmYjd6bzlDMDVWdWx1eWhPS1V5?=
 =?utf-8?B?Sy9jK0RCb09HUGF3Vnd4Wm5EWGljUkpHMVI3RWZ6SzlFV1dwM0VLaDRJZFdm?=
 =?utf-8?B?YkNjNHJRQXhDTmp1a2Y2MEhEWFhLejIzUUdxK1V3bkd0T2ZrWEN1MGNRblBq?=
 =?utf-8?B?RGZJMzF4NnR3NG56UUU3TXFlWEp4YWt5eXhFbHdReEZtcWM1S2xpNmdFejJv?=
 =?utf-8?B?bENKa3JybGxOa0luNWZXQ0o5cnJDMmEwUXlxTzZQcDExMkhqL3E1RC9hM2tC?=
 =?utf-8?B?MTY2ZHBWQTZCZjFWWjdkc2ZiL2ZIckx2dkdJc09pbldaWnBNa09JV0VSdENC?=
 =?utf-8?Q?0kLo7sJu+mUX0ZE0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EAC3FCD21A6B445A395444B0C55D4D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UShrAFhqE8uQgrBJEFojBL3wDZCZ1NzvvipeMp6r0eT6jbjHkZV7g/F6QfW9aP2Y9C92J/jm49IEF+81Z8BincrAi8hW2ZUf8NxCbPVBNNsn+CQ12JNtOf4YxefoBNjnxh7ibfgneR2HAICIJl/Jkc0hZWfWYRyoF5hQgcx8TV6plU+QPD2vxlS0R4JoizCiFaTLry6+6VtrZgnLfovKHXJoZIyqK3kxJNcVqNAEkHFKIw2xH3qB+K1q9IL40j+6suwQL8VuYAzfsFI/QVJQrxXlh849NYv2yJM5WVi7XbXAKBc8zncXl2r0MLOtckqmmuKD3MODixjuD9K4dmmYqQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673d3d70-58c2-4c50-e6fd-08df2637f4f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 19:03:08.4436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZ1qlhLb9yGDKWR5FWXVvIuXgaAQP8FjYLlwnHk+jrCMEEPMvEuh8Y2LCgWJBwDs0ioqAGHMX5sP2UfTgMm5pbi+eJpUUKZ+Yq8rPzdFFgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7124
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTEwLTA2IGF0IDAxOjQxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gVERY
IG1vZHVsZSBleHRlbnNpb25zIG5lZWQgbWVtb3J5IGZvciB0aGVpciBleGVjdXRpb24gZW52aXJv
bm1lbnQNCj4gdG8gc2VydmUgU0VBTUNBTEwgbGVhZnMuIFNldmVyYWwgYWRkLW9uIGZlYXR1cmVz
IGRlcGVuZCBvbiB0aGUNCj4gZXh0ZW5zaW9ucyB0byBleGVjdXRlIHRoZWlyIFNFQU1DQUxMIGxl
YWZzLg0KDQpDYW4gd2UgZ2V0IGEgbGl0dGxlIG1vcmUgYWJvdXQgd2hhdCB0aGlzIFNFQU1DQUxM
IGlzIGFjdHVhbGx5IGRvaW5nPyBUbyBiZSBhYmxlDQp0byByZWFzb24gYWJvdXQgaG93IGxvbmcg
aXQgd2lsbCB0YWtlLiBPYnZpb3VzbHkgaXQgZG9lcyBub3RoaW5nIG5vdywgYnV0IHdoZW4NCndl
IGVuYWJsZSB0aGUgZmlzdCBleHRlbnNpb24uDQoNCj4gDQo+IEFmdGVyIHByb3ZpZGluZyBhbGwg
cmVxdWlyZWQgbWVtb3J5IHRvIHRoZSBURFggbW9kdWxlLCBpbml0aWFsaXplIFREWA0KPiBtb2R1
bGUgZXh0ZW5zaW9ucyB2aWEgVERILkVYVC5JTklULCB0aGVuIHRob3NlIGFkZC1vbiBmZWF0dXJl
cyBjYW4gdXNlDQo+IHRoZWlyIFNFQU1DQUxMIGxlYWZzIG5vcm1hbGx5Lg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogWHUgWWlsdW4gPHlpbHVuLnh1QGxpbnV4LmludGVsLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IFhpYW95YW8gTGkgPHhpYW95YW8ubGlAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogVG9u
eSBMaW5kZ3JlbiA8dG9ueS5saW5kZ3JlbkBsaW51eC5pbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5
OiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4gDQoNCldpdGggdGhh
dCBhZGRyZXNzZWQ6DQoNClJldmlld2VkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vj
b21lQGludGVsLmNvbT4NCg0K
