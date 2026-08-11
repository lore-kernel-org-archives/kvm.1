Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA20A3064B5
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786446712; cv=fail; b=c30IDZY3NFIzXQd8SwpO2YWd39pJ6twa4kp6WgCwdEyRwrcXS/8xFRLTNQrKABEr1Ag7Li/WsDsj1ISuCRehHZ/z8Er7GJ2sKB8uWq+Y9++Iimui/I2Mxo35MPIJLOdmVL5UcOdmwkKYpvxppA32FvVJ2ujwr6L3sLdIsXeBzxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786446712; c=relaxed/simple;
	bh=qY7/Pj+a93s8+HVTTmxPYE2VlsORUD2rIoWyoAd3MAw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rQN+WwJpD/Ndk5IhrILrJ3Fd55gm5+e38+9l37zLNJs1EZcPVeIsNkrA6rcbv5i/ypqk93DJjPeCrBBI1SH6Dkd34Yq63PfYCQMMRetWoIvq3JF3Hfjt/qjgS5ZcxWPWgkkOiM0ZH52JAXb+hKNvYzGHVklGnxux1VXWu+XX1/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fM45IxXr; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fM45IxXr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786446710; x=1817982710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qY7/Pj+a93s8+HVTTmxPYE2VlsORUD2rIoWyoAd3MAw=;
  b=fM45IxXrMJVygHPYv0/oi+JSawHtkwmrY8M6yBCC/prh9Voxm4AzjTHw
   Odn5FQPpdta+1eS6XorPf+W6LhNZN+VQH0JzxrI57xMTR0+rLtVkjR318
   CYU4UHv1OzQ95IABZVRQXopGLPx0Vf+HTI8l1ZsOlDZehHkndiEbWZTnu
   6rcWoslEWOFrmDb0IRECewLwS/0DtGikGhqrTAUgj7JrZwLFhAdXNAYnG
   e6ywuCGgjQvF8BykuaGie5GUz4zCTG5bRcQoxsp2A6y8U06rKuH3rfucG
   FAXsTIs9kVtFK6y4tSemKFE2yTMqXVoSUOnSn+Eh/ko5cUcSFHU5AXZ+m
   g==;
X-CSE-ConnectionGUID: 5ZdNCcf5TVamDQEiZAE7NA==
X-CSE-MsgGUID: 5s+MhSpvT8GHY3GUEg7Hkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="109763931"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="109763931"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 04:11:50 -0700
X-CSE-ConnectionGUID: 8l8pIlvHQV22DjvAJ6rKdw==
X-CSE-MsgGUID: Vg9yS9vhRXaGNZfeCdccpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="267161767"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 04:11:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 04:11:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 04:11:48 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 04:11:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dS+6pyPquRP175MKBzHCMCNg20b1uc3jJ8wB+OLO8ZFi3FmroXZwATdb/XjTKYONS2Phs7a3Jp8S6hoHDhXiN5J41aBP3KvKzOe2JYqFJPNImB58fRfOkWzN7zIgWuP0mWeXIJBrqxQeOW385seLpXJhgWOVbDQrCnLvtyfoqZMCc4xAGOyjp1fL/bFd/Sxvd3ZxMgd+mBU2s2Up5zbKh6GRzYdQofbJH41IWK9QeCdyHylYaOwKECNMFqt01677avKjsxIoF7G/ufMAlk9+x8CEJwtoSVmTdeHNlH/YF5Hwbx/PbJGv1rEsh1j4Ic1cDJWKPm562/c3T5B6S8LaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qY7/Pj+a93s8+HVTTmxPYE2VlsORUD2rIoWyoAd3MAw=;
 b=aK9ff66ZNsaR5azhP6rWHnSc/FvkDYHKH6MzVglsD6gbJRFUyn2mGzWHf+z0MCCOxS24efvuLXzUPR37rQ8Qou9ZQmhEyxntZE/I9Q6proXrCu2DRxxI8fsjGwQsM8EQW2+SAfXw+0pGx1l5/RSDDFU/EvA8nlfQta72+1C/OJjLX5nQ+3xBcqwHEwL7M+UUXqU0Bt7U4DX5aUx4G/XfC0n0zbH8EQO80uhzG2Ga30/FRAyQirlMC25Y3EnlU8hnUc4S5CY56Yk6YTKSnj6m7vfop8uRrcz+xkHFm4Ac37kkpl7VR79QZ97zTREJgMdtb/qYghz8Wo6Cb0oM1X52Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18)
 by CH3PR11MB8187.namprd11.prod.outlook.com (2603:10b6:610:160::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 11:11:46 +0000
Received: from CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c]) by CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c%6]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 11:11:45 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "hao_zhang_kdev@163.com"
	<hao_zhang_kdev@163.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH v4 1/4] KVM: x86: ioapic: Update remote_irr only after
 successful delivery
Thread-Topic: [PATCH v4 1/4] KVM: x86: ioapic: Update remote_irr only after
 successful delivery
Thread-Index: AQHdKWPlmGatbGHB40aAJs2gHjVUwLaYsZmA
Date: Tue, 11 Aug 2026 11:11:45 +0000
Message-ID: <3b3db5de497f6196ddc17558b71aa746b0adf1e7.camel@intel.com>
References: <anrQfoE8HRvsaao_@192.168.1.215>
In-Reply-To: <anrQfoE8HRvsaao_@192.168.1.215>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5300:EE_|CH3PR11MB8187:EE_
x-ms-office365-filtering-correlation-id: 2933f40e-60ad-4f37-bcbf-08def79954d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: 3qC3T+fdJZkUREGatHhedmImQzYfz5hP+7dvZ31JHevWAAj9yc67Vm7ZU0nWCYRThskxYcFVumWdR7H+IpBHJ7pH4y1aXtWv/rwaHnIirR5j9gadEQQKEKSqyTb5eeErtgAi1KE9g+Q3Afb9g/hG50ue2duynUxeijWfsEcAFQaIdGOajCyny1Rito2fLd3XMSshdG4pl731hfpv4eqJeJ7Zv2WfwJteztAVt7mFnC1aYWjPsvjbHORA58lgUBzBwCz2qbfA27S1T1bDifdYzDVZL4WIaQyHK8ENvKOC5VrSpCzO8/w8q0j77q6pIxyhEYRdmOtlUB24cIABuGOn9QXMEm5eR7w7lXMbj8oeC4KBCO/7td60q0iufQV+rFn90iRFdXF1ib8wNqfFav3X9pnE1u+M+yMa4ZZ9k8D4K/EAeoBegM61kGUXTMScjRVlbg/ARk3awaznXgIkovX/iR6AIT5XrPP+EPivTX44kA+5D3YwuQdXutqg0Ckv2sDSXBSnNSNzIKuQGffvsi5YZvKG9r/0UuylM2rdGD5BtYbi3UD7XwMzF2rNclv/irkSjYcdNVDNgr09K0Ifq8HNeD6PXtoAbMSLuRUPssMzV59zAKxaJC3L+GEbgpAek7TaavhXohcpSf1iac+woQsIZUF6N28T4ZR3Mu3C50FvAwJEUgY7OwSoQz972eZo7e6R4CL8XKSVY6pT23VuzQsfFcemQZD0CjhKl/cKa50RHbA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5300.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlVzaEFON1ptZHNNVjFhZnRwN0ZCdnNoVUJTSGg2TlhzVVl2bXkzaFIwM3Q3?=
 =?utf-8?B?Y2pGYVhhcWczYmgzOGxEODVhenRDUDRsdjUzUXEvNXVKTGVIRDJqRXlRRjhD?=
 =?utf-8?B?aGhTRTR0TUErajhZTFA3Mm5CLzZhODBMRitTUFEvZVNxVTNmRzBYbmpFVkhT?=
 =?utf-8?B?U1FMU3Exc0t6bldkTzJzMjRqM1d2dkpkNjVoU1MwdSthNUFpVzE1T3pRSzhz?=
 =?utf-8?B?VVZ6WVdLWG16T0F6SVlxWU9KUjlwTDdmL0xqTGVKMDdzaVlhQmNybmc1NFlU?=
 =?utf-8?B?SEdGTDFxRUtNMzEvWDZBNXIxcWxxWEIxT3dLTWZjWWxSNzNKZ1BYa2xzMnRu?=
 =?utf-8?B?RG15K1BFNGNRU1dWbUE5Z3U5SnZaNzBuR0ZqMXh2a25PRGlKc0FXbE4xOTQ4?=
 =?utf-8?B?TTB0ZlpPZGl3VFlqT042OEdpRnZTaVFWaXJTbkhBOWdnL2JPNTJMbk95bW5Z?=
 =?utf-8?B?cFlMcU1nalNWS1Zidll0SmhjZklEVlBxa2pjdzdFQ1hISjlxNG50ekJhWktI?=
 =?utf-8?B?MlFYOWlVUlZxQmVIc1lWcExyR1RkTFJZQVhQdE5XNmpYRVo3NURMNzRSdnZW?=
 =?utf-8?B?dlNDcFdIVGhkNUQvSExVM2tkSzNtTTlCeFltbTBDSUN4YWdYNDIxODJ0cjls?=
 =?utf-8?B?Q0N0QTVvK1VGUElqcE1PTXJFUzg3N3JaUU1mQlFFUFJxKzBBbjdwTktkYUw3?=
 =?utf-8?B?OUJpV2NTL2tTNTRDTCtqOGg5OE1YVGpINklyVVNVTFhRRUFzaDByNUQ2MTBC?=
 =?utf-8?B?eFpHb01zcld4NUtyMTBONXlTOE1GMHhqcUVjb0xDT1N2dzdBVnZHTTFaODY2?=
 =?utf-8?B?dG0zT2JWWERtVENpYWM1SGQrdkE4WkMrY3c3T1UwSWVCU1ZkZmJTQkFKV0pr?=
 =?utf-8?B?alRWL1lRUWxEcWlwcWEvbFg4eDMzc2dDL0Zuc3ZMMmU1ZDQvTWRFN0YxMFBX?=
 =?utf-8?B?VmtVYitRdzI2Y0FuTitDMjJsOGtCQ3B1Zk1obzdFMFU3Q01maDE1UmRPa2JU?=
 =?utf-8?B?YUxGWTFsQ3htTnBteHVrb3ZPMkd1bFcyWTNNZnQ2Q3hReEhzT1VVcFA4WHFz?=
 =?utf-8?B?SUUxd1RrNXZnU1BRYmV2c2s0YU56NHprRGE3QXZROFhWRGgxdTdFT0llT3Yw?=
 =?utf-8?B?blpDNWpiUXRicFZzRnhkSnNmOVBzT0xvZG5CTmczRWF6UllGT0tlYW91aVNq?=
 =?utf-8?B?aWVvenNoMFV5enlEVEdtY2dHMW1Gb3psMkRpTmlJb0NwL1p3ZE5iaVo3RVRM?=
 =?utf-8?B?U0tDQkhEZDlhMlhVZWs2cjlxSkVLSDN4MnNabW9FSDBMUVQzSnk3c0t5NkpE?=
 =?utf-8?B?NW1HeHNueURYYVJTdXFBeEo2b2hoVlo5WnJOYTBlUm13YmRHNUtEMEJYTFpB?=
 =?utf-8?B?Wk5TRFBiQUtoWXZLQjdrS3l1cGQvYW9HSTZRTVJta1pZWE5rdUNRTFB4NTdK?=
 =?utf-8?B?ZlUxTzZyWTRWcXQ3NWZlVHo1aDg1MW5PakUzeVpjVzZJY3Fkck9vSlV5VWJI?=
 =?utf-8?B?OHF1dHM5NjFoYjE2Y3pIQk9BMCtkb2RKWWZKUzBOUWp0OUltaFZmOUJOa0JW?=
 =?utf-8?B?cHJ4ZEtGMTNLcVh4RW9yVVZEeStWTFNQbUpKUE5nNlI4QTRLQmswZHRTeXJW?=
 =?utf-8?B?RlI1MHNHeXVwSXNYWjg0Z3ZqSXJFTUtjUTlCajRiY3F3VzNraklLbTlmdktW?=
 =?utf-8?B?UHY4c2RxeFE3b3BPbTJtMUdIaCs5UmFYQTJ0V1JsZHAwYW51VEhMb0g3aHVu?=
 =?utf-8?B?azRtUTlseDQrSElOTy9qT3RyMk9HVGF2Nkh1UHIrUUJmT0xzWkNQbVgyOUZ3?=
 =?utf-8?B?K0VOMU80Rm5LR2s1M3NFRDBPQnRyREh4dk1jb3VRZ25peUI2Ujdib0RndHJa?=
 =?utf-8?B?NEMrdU5wRlZRRFIxeG4rd2h4aHU3dStqbHUrZThHWlN5dVQ1NjIwTEhzQ21G?=
 =?utf-8?B?Z3EybCtrUml3dmVoY1NzdVExQlgvcHRpRFBaaXRxQXFKQmo2TXJpOFFFczcv?=
 =?utf-8?B?Tlo3WUxEWm5lQm9nY2NlTmxhd1dSdFJpQk1NNitUKy9malBRcnZQcTUzUHFR?=
 =?utf-8?B?cmNHc0JSWkdPMUlGODFKY3BqL0lROUVlc2F1eFNaWDdzZDFvQ1B4YmcrNFJa?=
 =?utf-8?B?c0NiUXVDck4vKzczUUVXOGErcDdaUEdGQU9weGNSSkR1VkhqWWdBaHd0Vitt?=
 =?utf-8?B?Q3dQeTY1V21uT2I5Mm1YMjErc1h2WWtZVk5BS1FkaHJvMFVIYVN1VzNKVDBO?=
 =?utf-8?B?T2V1M2JpTUF1SGhlSGQxL0RZSVBKbzlSOTlhMzVrRUxsdkNRUlBaN01TVCtv?=
 =?utf-8?B?MUZka00wZnJpMVBOSjFEakMyR1pmdFNsZUIzZVJrTGpUeE1TT1UzZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B31EDC3B1C62C4598B8D812E8AF838D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KoWTybV8gtE0JMKB9HEhCYRnwEFbcqUKxlM3TRSAGLTvMLBI4bQ0frR8xgwM0LY6RGP4l5NH7Hf/+X7hHJ9VXdsN5vxdL1u2VkYud5qXUaBLn1c/7/o/5lJSLeiV/vDlQgPW7KBPrgJVfrEuXe5q0MVS11qBQ7ZvR4a0sL8VXSBZ56gBNkqC1MIAsnGsiqsBP4S39gXQZ2hDKFC++xPM0D0bHERcOEWxUgN/euk3RJ58e3i0dp1eHiTPKiZs9d1dRYjmJMg9Bvq6D6R6/5jzcgjMJdDC0KOhgguAcjZ+hJ6dxpJr51LgJNFERqFXJ9YxyLoVpZ2pQJpS/HRV2Qfybg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5300.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2933f40e-60ad-4f37-bcbf-08def79954d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 11:11:45.8766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o9eYjc1xtgt7Lrmh+rmfEXXFu2HhCqzDFJtwAVT+N8V6CwKOmxDrKZbmnUTYc1CB9Dp+Yuemjm4EMCgi0Ywf1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8187
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA4LTExIGF0IDE1OjM0ICswODAwLCBIYW8gWmhhbmcgd3JvdGU6DQo+IEZy
b206IEhhbyBaaGFuZyA8emhhbmdoYW8xQGt5bGlub3MuY24+DQo+IA0KPiBUaGUgSS9PIEFQSUMg
c2V0cyByZW1vdGVfaXJyIGZvciBsZXZlbC10cmlnZ2VyZWQgaW50ZXJydXB0cyB0aGF0IGhhdmUN
Cj4gYmVlbiBhY2NlcHRlZCBieSBhIGxvY2FsIEFQSUMgYW5kIGFyZSB3YWl0aW5nIGZvciBhbiBF
T0kuDQo+IA0KPiBpb2FwaWNfc2VydmljZSgpIGN1cnJlbnRseSB0cmVhdHMgYW55IG5vbi16ZXJv
IHJldHVybiBmcm9tDQo+IGt2bV9pcnFfZGVsaXZlcnlfdG9fYXBpYygpIGFzIHN1Y2Nlc3NmdWwg
ZGVsaXZlcnkuICBCdXQNCj4ga3ZtX2lycV9kZWxpdmVyeV90b19hcGljKCkgcmV0dXJucyAtMSB3
aGVuIG5vIGRlc3RpbmF0aW9uIGlzIGZvdW5kLg0KPiBTZXR0aW5nIHJlbW90ZV9pcnIgZm9yIHRo
YXQgZmFpbGVkIGRlbGl2ZXJ5IGxlYXZlcyB0aGUgcGluIGJsb2NrZWQNCj4gZm9yZXZlciB3YWl0
aW5nIGZvciBhbiBFT0kgdGhhdCB3aWxsIG5ldmVyIGJlIGdlbmVyYXRlZC4NCj4gDQo+IFVwZGF0
ZSByZW1vdGVfaXJyIG9ubHkgd2hlbiB0aGUgZGVsaXZlcnkgcmVzdWx0IGlzIHBvc2l0aXZlLCBp
LmUuIHdoZW4NCj4gYXQgbGVhc3Qgb25lIGxvY2FsIEFQSUMgYWNjZXB0ZWQgdGhlIGludGVycnVw
dC4NCj4gDQo+IEZpeGVzOiA0OTI1NjYzYTA3OWMgKCJLVk06IFJlcG9ydCBJUlEgaW5qZWN0aW9u
IHN0YXR1cyB0byB1c2Vyc3BhY2UuIikNCg0KVGhlIGNvZGUgTEdUTSwgYnV0IEkgYW0gbm90IHN1
cmUgdGhpcyBpcyB0aGUgcmlnaHQgY29tbWl0IGZvciB0aGUgRml4ZXMgdGFnLg0KDQpMb29raW5n
IGF0IHRoZSByZWxldmFudCBkaWZmOg0KDQorc3RhdGljIGludCBpb2FwaWNfc2VydmljZShzdHJ1
Y3Qga3ZtX2lvYXBpYyAqaW9hcGljLCB1bnNpZ25lZCBpbnQgaWR4KQ0KIHsNCiAgICAgICAgdW5p
b24gaW9hcGljX3JlZGlyX2VudHJ5ICpwZW50Ow0KKyAgICAgICBpbnQgaW5qZWN0ZWQgPSAtMTsN
CiANCiAgICAgICAgcGVudCA9ICZpb2FwaWMtPnJlZGlydGJsW2lkeF07DQogDQogICAgICAgIGlm
ICghcGVudC0+ZmllbGRzLm1hc2spIHsNCi0gICAgICAgICAgICAgICBpbnQgaW5qZWN0ZWQgPSBp
b2FwaWNfZGVsaXZlcihpb2FwaWMsIGlkeCk7DQorICAgICAgICAgICAgICAgaW5qZWN0ZWQgPSBp
b2FwaWNfZGVsaXZlcihpb2FwaWMsIGlkeCk7DQogICAgICAgICAgICAgICAgaWYgKGluamVjdGVk
ICYmIHBlbnQtPmZpZWxkcy50cmlnX21vZGUgPT0gSU9BUElDX0xFVkVMX1RSSUcpDQogICAgICAg
ICAgICAgICAgICAgICAgICBwZW50LT5maWVsZHMucmVtb3RlX2lyciA9IDE7DQogICAgICAgIH0N
Cg0KVGhpcyBjb21taXQgZGlkbid0IGNoYW5nZSBhbnkgbG9naWMgcmVsYXRlZCB0byByZW1vdGVf
aXJyLCBzaW5jZSBpdCBkaWRuJ3QgdG91Y2gNCmlvYXBpY19kZWxpdmVyKCkgYXQgYWxsLg0KDQpU
aGUgb25lIHRoYXQgaXMgY2xvc2Ugc2VlbXMgdG8gYmUgDQoNCiAgZmY0YjlkZjg3N2IzMCAoIktW
TTogSU9BUElDOiBvbmx5IHNldCByZW1vdGVfaXJyIGlmIGludGVycnVwdCB3YXMgaW5qZWN0ZWQi
KQ0KDQpzaW5jZSBpdCBhY3R1YWxseSB0b3VjaGVkIHRoZSBsb2dpYyBvZiB3aGVuIHRvIHNldCBy
ZW1vdGVfaXJyOg0KDQpAQCAtODksOCArODksOCBAQCBzdGF0aWMgdm9pZCBpb2FwaWNfc2Vydmlj
ZShzdHJ1Y3Qga3ZtX2lvYXBpYyAqaW9hcGljLCB1bnNpZ25lZA0KaW50IGlkeCkNCiAgICAgICAg
cGVudCA9ICZpb2FwaWMtPnJlZGlydGJsW2lkeF07DQogDQogICAgICAgIGlmICghcGVudC0+Zmll
bGRzLm1hc2spIHsNCi0gICAgICAgICAgICAgICBpb2FwaWNfZGVsaXZlcihpb2FwaWMsIGlkeCk7
DQotICAgICAgICAgICAgICAgaWYgKHBlbnQtPmZpZWxkcy50cmlnX21vZGUgPT0gSU9BUElDX0xF
VkVMX1RSSUcpDQorICAgICAgICAgICAgICAgaW50IGluamVjdGVkID0gaW9hcGljX2RlbGl2ZXIo
aW9hcGljLCBpZHgpOw0KKyAgICAgICAgICAgICAgIGlmIChpbmplY3RlZCAmJiBwZW50LT5maWVs
ZHMudHJpZ19tb2RlID09IElPQVBJQ19MRVZFTF9UUklHKQ0KICAgICAgICAgICAgICAgICAgICAg
ICAgcGVudC0+ZmllbGRzLnJlbW90ZV9pcnIgPSAxOw0KICAgICAgICB9DQoNCkJ1dCBsb29raW5n
IGNsb3NlciwgYXQgdGhhdCB0aW1lIHRoZSBpb2FwaWNfZGVsaXZlcigpIGNvdWxkIG9ubHkgcmV0
dXJuIDAgb3IgMQ0KKG9yID4xIEkgZGlkbid0IGNoZWNrKSwgaS5lLiwgaXQgY291bGRuJ3QgcmV0
dXJuIC0xIGF0IGFsbC4NCg0KSW4gZmFjdCwgZXZlbiB3aGVuIGNvbW1pdCA0OTI1NjYzYTA3OWMg
d2FzIG1lcmdlZCB0aGUgdGhlbiBpb2FwaWNfZGVsaXZlcigpDQpjb3VsZG4ndCByZXR1cm4gLTEu
DQoNClNvIEFGQUlDVCBib3RoIG9mIHRoZSBhYm92ZSB0d28gY29tbWl0cyBhcmUgbm90IHRoZSBy
aWdodCBvbmUuDQoNCkkgaGF2ZW4ndCBmb3VuZCB3aGljaCBvbmUgdG8gYmxhbWUsIGJ1dCBpdCBz
ZWVtcyBhdCBzb21lIHBvaW50IHRoZSBmdW5jdGlvbg0Ka3ZtX2lycV9kZWxpdmVyeV90b19hcGlj
KCkgd2FzIGludHJvZHVjZWQgYW5kIGF0IHNvbWUgb3RoZXIgcG9pbnQgaXQgd2FzIGNoYW5nZWQN
CnRvIGJlIGFibGUgdG8gcmV0dXJuIC0xLiAgQnV0IEkgZGlkbid0IGRpZyBmdXJ0aGVyLg0K
