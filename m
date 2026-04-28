Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2137047CC80;
	Tue, 28 Apr 2026 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777404539; cv=fail; b=HWqeZjUnsxb5Urf29k7R/nhLjO0IsWsVxCD9qI72tjTV4LDfbz7UlWAk59l57brsfl8f2BMkXuiMkIpaokNXu7QAVA0PzIOUAJg8aVfbpad2b1Scyk3IgISWb4q0DizYuR1M65r7OGYJ/sSuz1s/GeF2I2jslzx9ikS6MbwDjPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777404539; c=relaxed/simple;
	bh=1Sb7kVz3nSZ3DgWNSv10k5ryC9uOzXM1DNeSBW0++gQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NczBOnHihdF9Pe6NrqqR2sjIe83nU6srL5ElFrckTKy2iekrKxc+QbIsd1A1EN8u4retf+3rk/rs3W3/NXZpeGIIMpbUO2vk2iSATV8rejqYrous75x4zFurkH31Bu1nGSJDtN2PNDaiJwY1fTdJ8XBF9BnPr5QobszecZnGw58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SsqQclYs; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SsqQclYs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777404537; x=1808940537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1Sb7kVz3nSZ3DgWNSv10k5ryC9uOzXM1DNeSBW0++gQ=;
  b=SsqQclYs6FQ48ZASdUSRlyigIPOFlPVV7ymUFhyh1qdUhwGtYK4UoTzC
   s1YdfNSwaFitAIFxRrQio3xnpgziIfJOeAVMJalED4TKes69HMWetd+Wf
   C6MQoxwWP7wOiZVv80xCCuJRcD87bETVG4x3EmA4A9aVf/UHsaFLKSfcm
   ORR2OQrTEjIpdiDa5vhxUQqou2Y3QER1Lkn1sd09tb8ABXd/so92ZmoeM
   0DyTa8AyXMJY9iKdJxi5vVYHSqNrWyv3tHF7nbo0lCiyLRIMGzBKNRYdK
   OOZGkxtK2OoutAIiLvdhEtFDHLASeDUSrhplSCZfepZu538Bh1heC2iTu
   w==;
X-CSE-ConnectionGUID: O8Hwa+cISiaSsXUfTvy/Yw==
X-CSE-MsgGUID: hCXejyrRTJuQ7GO6Xct7qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78308926"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="78308926"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 12:28:56 -0700
X-CSE-ConnectionGUID: SfOhSSnvSTib/vI9OICobA==
X-CSE-MsgGUID: b7ArW6JQRNuZr3LlWO53wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="233023582"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 12:28:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 12:28:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 12:28:55 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 12:28:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLXr6DxpaCJlupsXYz0i4X4TWUYEbuhZBqidcIEjdH+tY+HFWGZYxKrVmahFnV73Lj8O6n1wd7ivFTp8hO9y8TznW2OnD5iAjaDYOxpTm5YjNMulITkxT7NvV6svxUTNhuJquhLd10Z7560E/l340A3n5Li6ksaRqj0HE6l5CVDldQ1ZgzHC90dlWPEFOh79AaYNsDCxVBnrzzA33Yi3e7GM1rCrPoh3h/ycZdSWQXYN6r2CAFmh/HgWEllMW1/w7yeqSgxuSfZUWpgvJlotBTlXcsu9wt/d5bI77ZnVZX2/UbL9bBpljeaeZfPAFMWhspRpvaiRKTY4XSVD+r+QTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Sb7kVz3nSZ3DgWNSv10k5ryC9uOzXM1DNeSBW0++gQ=;
 b=iGX5qhLmd6YDADic+4Y5rMlfoGmhl7A4BWP/H+tKPq6fZquy1AZX+Af4edpUCFpHK6XU5rDlxU2+8ySXlNxPDv3PNUfHPK8PAX2sUEY7iMtnuD5rzWQC9DSKJemkz4eQ1mukSNydJ3EplfrDWM16I70+2sLtcw9NoAHOhi0xhRv+jWtTiTZkEozU41c0s9btXwaLhNN0gDeHtJzNpEp1a9DiBudslrqGSVT+nEYuhlqC5iGZ/PVCw4ImewCHi2VZkzLj+E5kcrwhZeaH+xezFN5M01quQPTjovd8wYjkUJZry49KvPFF0ttChjCiaGL+qO+FOrMcR0xRskVh5zMudQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA3PR11MB9488.namprd11.prod.outlook.com (2603:10b6:806:465::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 19:28:52 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 19:28:52 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] KVM: TDX: Allow TDs to read MSR_IA32_PLATFORM_ID
Thread-Topic: [PATCH 1/2] KVM: TDX: Allow TDs to read MSR_IA32_PLATFORM_ID
Thread-Index: AQHc1rjc48hzBFaYnUOC9vPasmTOELX0W1IAgABPw4CAACHcAIAAA5QAgAAMhYA=
Date: Tue, 28 Apr 2026 19:28:52 +0000
Message-ID: <80e6526c042e6f78aee7cbc60a825c64bf75fad7.camel@intel.com>
References: <20260428024746.1040531-1-binbin.wu@linux.intel.com>
	 <20260428024746.1040531-2-binbin.wu@linux.intel.com>
	 <afCdoufK0D+1hKAR@intel.com> <afDgiz38tARlIQNr@google.com>
	 <b8c413a52c0285534d552c8646f9071fca4351f4.camel@intel.com>
	 <afD_8se-aOikeHTT@google.com>
In-Reply-To: <afD_8se-aOikeHTT@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA3PR11MB9488:EE_
x-ms-office365-filtering-correlation-id: 201d4043-5e0b-436b-53f1-08dea55c6163
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info: DnVSCC5CeeL5nwMj4+Vkqp9uYSQ/gO3d73Flem3nexZnArmEbZB68WHExVOcj+jN3wQGGspGqQjSAEpCUjZo91l23ZhMOj4Da8VyYgA4sxPAh46DKGomWgBLX+XYVz5uVwMy0JcJAo91T7WFsjUghEt6effsrz1TvPWR0CuXzJIxXugtKTWGu0GYqqP6S2rEAwxzgwJvbeU7yhJAZWV0NV3IotMcUwr5/GzCYf0qC4HIgHWz/tBbkV2umV30hpM31OhvcYPtTw8Gurp+6Eu7wBwMcQ/TPkZXle5fTpC7B4HbnREaKPvUZpdAr7/T1roRgPGLhdy8vFM86C0YLc1rHZ/ITujCsGvipu5QNksxzS++VlZYisyL0ZkamCDajuslj7lytmPAL26qCfunzHelP2mH7D3E9xnjApbq60WUmgiK2620DPPADGApKkzQY4xTZY+1hIaMg/5/hgzHZpN5epx/oiPsSZUgiC7jZCAI+8mN8FKyqnvAzRfGWLHDHlPjTYPj16wqUlYzoEYnU35AjBBBvq4lE7PQIYgoY7p0SI0LR7EJNE/OC3lGsqh8Y72e3L2cc5792RM3KQARAY2/0daBRs83BxApwiElhH0gnfVBYKH+ysUxE2DfTOw7+fYF1qWFJGAT5DcVu51s1Xh+YqT8hWoykGV74KrQtg/CXITL2yT3Mldw/oHCAfvJm8aPh7i3PL+ua0A46vdnUHQieY3sxOUAd8DhpUHZsbEGt8dr6tTRa3Whiia1tVQgTdWZanDH8Gzc7293rSgc1+NI5XWYAaXVpEjhn0u7sIFXkPc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1FiS3RaTEZaNFlhRkdMNkVRZDhONWoyMGFES0ZoNWNKZjVaMXhzaWpDRVVK?=
 =?utf-8?B?aGtVaThDVzZkS21qYjNQOU9McWptaHl6MGZKWmxXNnpRVlA1dSsvaldZSU0w?=
 =?utf-8?B?T05rbWpSVGpFYUNlajl6UXIzWmx3OHhUZkIyeGNlRzhvRjQzeFlXT0J2TGE3?=
 =?utf-8?B?bzExWTJMcUxsOUswOUZCaVBTVHNlVDgvVkhkelVNVlR5ME5DNzdBY2gwb0JF?=
 =?utf-8?B?U0N6YXBEb3h4YnoxUHRIUlVUaERMRFg0Z09oV2E2VHd2ajZXT3o1Z2dtNXg2?=
 =?utf-8?B?cGlXbTNTVjZ2bGo4dmZxVzdRNVpjTmVhZC9velpRQWV1WUY4azU3QmRrYWg3?=
 =?utf-8?B?NVQrdkxaRWlVYkRzQTNpTWF0ZUVHR1liWkl5UTVWb3RZZzBaczdwT3VaeDlj?=
 =?utf-8?B?VnZZNVhCT1RReHFxdnZOZzNXVHN2UGlVRUtnSi9FWXRGSzNjUlFZTk1WczVw?=
 =?utf-8?B?SWpUSXVxbEZGSHREMUl0K2ltWmVHeEpoSGpHcnhLdkFCOEZEK01xYTFsRjZD?=
 =?utf-8?B?SXFQeXlJYWwyY0ErL3BBKzB1bnJaWnNzU1NzNzZ6RkFKMTZrZlYrYUs1aHNF?=
 =?utf-8?B?UWhwcUZsWWRja1N4WXdkU1VaNE5YOGlkak1OU0pockJvZ2RWaHF3SWxQem5k?=
 =?utf-8?B?U1dYUi9nK3VNQnhLNnJnbkpXVFFKYXZpdkowTmNEV3ZZOUlaTlo2SURBaWVY?=
 =?utf-8?B?RWpWK1l6YlFLbUVPTHhWMFA2K3hqWGVlTEp1VHdOcDk2bXEwT05yWjBCR2N4?=
 =?utf-8?B?bFQ3TExhUzdDajlJb083QXhnSXNrNHdYdGEwbzd2VEpBbk10L2h2TCtFMmRS?=
 =?utf-8?B?V0piaG9OMGY1RU1yZDEyaDhjQ2ZtcXdWM0cwKzZiODJXMVZYb3FHZ29tOXY3?=
 =?utf-8?B?TFdwaTgvOURKRlM4eEFsV3VXbS9VQWliRXRxbWxDVVd6aEVrS2NJTVQrNFor?=
 =?utf-8?B?OUdrL0ZZbjR1WklxQXowdXBzcDA5SUpJSG5odDBPWHdCazd5bXBwNEduWEU2?=
 =?utf-8?B?eURibjV1UlhxS0trN2xYYXJUOUF2UXZ6akJveEg4dXFnNUhxOXE5a3NwRk1M?=
 =?utf-8?B?UHZRMFAySEpoSkNQWC9GQWFUYWVwWGs4VHFoclRwQnp3anV5YVNTWVpmSTBV?=
 =?utf-8?B?YXRrSlUwQ1B3dmFGbkhOSG1lWU1qdVVQUzBFdk1QZnZ4MU9jSFZxVDljRHhR?=
 =?utf-8?B?aXJlT3FTVW9xNGFncjdqMlNWcWZQenN6MnVQYXpNUi9XaXZXajFzSkU1V0JD?=
 =?utf-8?B?eTVoSGU5b2lHYmpkYzlpWUoxdVFtRjNOK3M4ejRjcGw2bldXbkd3RnNzRUUx?=
 =?utf-8?B?VXBnR3NjWGQwYXpER0ZtWlVCcHdiYzY3UC9LUW0yVUgwU2VPMmx4b0R2STZR?=
 =?utf-8?B?bm9sbU5nVUxWSUlGanN6YjBYdWtTUG9EemxCQUJVY2QzbXpxbVc4VFFGUmZt?=
 =?utf-8?B?WnYrbjNydnFGWm84MEl4SEhBbVNiNWh2Q2hFNUR3WXNFTzd5Ym5WbWFSUVBZ?=
 =?utf-8?B?Sm1UY3duNjF4UHlOWXNCekZVb1czU0V6aVBiazJIb0RQL2gvZ09iN3JvaEth?=
 =?utf-8?B?Sko4YXdrZVU4cEp3eG0yUjhHWU91MEplbUJ5Q2EzNHFFUmJtVlY5WE5JZUhH?=
 =?utf-8?B?UFVHOFJkaFA0cTN1cDVNWXAxZVRiNnJPN0VnaENOdk5ObmxPa2dlT2Z5NGNh?=
 =?utf-8?B?Q054L3FmeDdxR1FiZ21RUDIybk5oREViYTZhcjZaSDBlNVdWbjE1aTlJeCtG?=
 =?utf-8?B?MDBYVlg2TUR3TytqS1Y0ZWZaWmM5ODFib3NPcU0veExzK2ZFanlzQnl4bGdQ?=
 =?utf-8?B?S204TXZmY2szeUpMUGlYVDIrZ3pDQXRlbVpRVWx2OVRYYWErL1RPZ3Zpakcx?=
 =?utf-8?B?WEx4M3haU3p0SVVodkNDZ3Eza0dHQm94UUlRU3Z6d0lNUnJkT2FBSEFoZmN3?=
 =?utf-8?B?M3FmdkI3NUNISldZaFFpeE9PWGxuVXRYVWt2cnVhNmFTRDRnbStYakdVQ2U2?=
 =?utf-8?B?Z1VmeHBHVHIzMDFFRDhWTG5pNlhLeWZXOVdSSG1UVEw0cGc1MC9WYVR3c1Jo?=
 =?utf-8?B?S0RiQ0xlbHhYc2V1L291RXVuWjdGQnYxeFBZZzUwMlFEcTNrRFJocDVIWHMz?=
 =?utf-8?B?KzlnNFNxemRNU29MdU95R3duMTZIY256bCtrTm5GdjJpVVRwaVpNTXVCcEJZ?=
 =?utf-8?B?Y2pGTmRzWUdsLzQwY2JuOFp3L1MzN0pIczdXQmtmdlp0bFpvRmNIOEpScTQv?=
 =?utf-8?B?Y2VBS05UdGcyeUVyWGNzYmJ6K0FCb3ViVk1SQ3h0c3diQ21pbk5Za3pzVEpF?=
 =?utf-8?B?b3pETU9hMTVWMXp3STBEOHpRSnQ1V3R5VG5LNzluWkd0UHFlVzVMcWF1d244?=
 =?utf-8?Q?N1/dP1KEwwNoMZAM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89F9F914AEDF5C48A3DEF31036B011EE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HxAUAWuu0qPqxvfPGiNTTp6pWjDTwOPgHMczit8R7S+FViCku8PjrbkhRlnD4qae53nnr0lb9FlcqoL9Aw2HWTQX2DWcyCrTU1d7OQTsvxpCb3CVe19SzSqohWXrhZJmZuFtcuy7HMP0efJxy/Mx3ery6+cc6rK/0ZQIV3h+ibCG48fnAOh5t/h5KD9+0qt+cxRHvDO6LkcJ+aTZElYhYxigy8i2KroQ9ixvI13kHmf7/cxX/tRygr8KrF2vB8emTua41PNvwLThJp811jogv83np31XwAnY688l9zblKwStDWQb5KA7rwOW1/ek01xD2/J68WT4zPbiqe5pHJrmFw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201d4043-5e0b-436b-53f1-08dea55c6163
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 19:28:52.2392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n30nhAG6Y00b6PclDUxQwDWK4NrcfaS1R1Tp55sppZyxgbapa9WkpeuYEZMFURhEmZIe0SGYxiW2R5TH+slsP2544vn3FI5sutJ9JOLnIsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9488
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTI4IGF0IDExOjQ0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IFRoaXMgaXMgYSBwcm9ibGVtIHdpdGggdGhlIGJhcmUgbWV0YWwgS1ZNIGJlaGF2
aW9yIHRvbywgYW5kIGl0J3MganVzdCBzdXBlcg0KPiA+IG9sZD8NCj4gDQo+IE5vP8KgIE9oLCBJ
IHNlZSB3aGF0IHlvdSdyZSBhc2tpbmcuwqDCoA0KDQpJIG1lYW4gdGhhdCBLVk0gaGFzIGhhY2tl
ZCBBQkkgYXJvdW5kIHRoaXMgYWxyZWFkeS4gU28gaGVyZSB3ZSBqdXN0IGRvbid0IGRvIGl0DQph
Z2Fpbi4NCg0KPiBJJ20gbW9zdGx5IGNvbmNlcm5lZCBhYm91dCB0aGUgaG9zdCBzaWRlIG9mIHRo
aW5ncy7CoCBUaGUgcHJvYmxlbSB3aXRoIFREWCBpcw0KPiB0aGF0IGEgVERYLU1vZHVsZSB1cGRh
dGUgY291bGQgZWZmZWN0aXZlbHkNCj4gY2hhbmdlIEtWTSdzIGJlaGF2aW9yLCBpLmUuIGlmIHRo
ZSBURFgtTW9kdWxlIGRlY2lkZXMgaXQgbmVlZHMgdG8gZW11bGF0ZQ0KPiBQTEFURk9STV9JRCBm
b3Igd2hhdGV2ZXIgcmVhc29uLg0KDQpXZSBoYXZlIHNpbWlsYXIgcHJvYmxlbXMgd2l0aCBDUFVJ
RCBiaXRzLg0KDQpCZXNpZGVzIHRoYXQsIHRoZSBndWVzdCBjYW4gYWN0dWFsbHkgY2hhbmdlIHNv
bWUgTVNSIGhhbmRsaW5nLiBUaGUgcmVkdWNlZCAjVkUNCnRoaW5nLg0KDQo+IMKgIFNvIG5vdCBv
bmx5IHdvdWxkIEtWTSBuZWVkIHRvIGVudW1lcmF0ZSB0byB1c2Vyc3BhY2UgdGhhdCB0aGUgTVNS
IGlzDQo+IHN1cHBvcnRlZC9lbXVsYXRlZCBmb3IgVERYIGd1ZXN0cywgS1ZNIHdvdWxkIGFsc28g
bmVlZCB0byBkaWZmZXJlbnRpYXRlDQo+IGJldHdlZW4gZW11bGF0ZWQgYnkgS1ZNIGFuZCBlbXVs
YXRlZCBieSB0aGUgVERYLU1vZHVsZS4NCg0KVGhlIEtWTSBzdXBwb3J0ZWQgYW5kIFREWC1Nb2R1
bGUgc3VwcG9ydGVkIG9uZXMgYXJlIGFscmVhZHkgZWZmZWN0aXZlbHkgc2VwYXJhdGUNCnRoaW5n
cy4gQW5kIHRoZSBndWVzdCBjYW4gZXZlbiBrbm93IHdoaWNoIG9uZSBpdCBpcyBhY2Nlc3Npbmcu
DQoNCkkgYWdyZWUgd2UgY2FuIGp1c3Qgbm90IHN1cHBvcnQgdGhpcyBNU1IgZm9yIG5vdywgYnV0
IEkgdGhpbmsgQ2hhbyBpcyByaWdodCB3ZQ0KbmVlZCBhIHBsYW4gZm9yIHRoaXMuIEkgZG9uJ3Qg
aGF2ZSBhbnkgY2xlYXIgYW5kIGNvbmZpZGVudCBpZGVhcy4NCg0KSSdtIHNlZWluZyBhIGxvdCBv
ZiBwYXJyYWxsZWxzIHRvIHRoZSBDUFVJRCBiaXQgY2xlYW51cCBlZmZvcnQuIEJpbmJpbiBhbmQg
dGhlDQp0ZWFtIGRpZCBhIGJ1bmNoIG9mIHBvbmRlcmluZyB0byBmaW5kIHRoZSByaWdodCBsaW5l
IGJldHdlZW4gb3B0LWlucyBldmVyeXdoZXJlDQphbmQgYXZvaWRpbmcgYmFja3dhcmRzIEFCSSBp
c3N1ZXMuIFdlIHByb2JhYmx5IG5lZWQgdG8gZG8gdGhpcyBoZXJlIHRvby4NCg0KPiANCj4gPiBG
b3IgVERYLCBobW0uIEkgZ3Vlc3MgdGhlIHN0YW5kYXJkIHRoaW5nIHRvIGRvIGluIG9yZGVyIHRv
IGF2b2lkIGNyZWF0aW5nIGENCj4gPiBLVk0gQUJJIHByb2JsZW1zIGlzIGp1c3QgbWF0Y2ggdGhl
IGFyY2ggYmVoYXZpb3IuIEJ1dCBmb3IgVERzLCBpdCBpcyBhIHZlcnkNCj4gPiBzcGVjaWFsIHR5
cGUgb2YgVk0uIFRoZSBzcGVjaWFsIFREWCBndWVzdCB0aGluZ3MgY2FuJ3Qgd29yayBvbiBiYXJl
IG1ldGFsLg0KPiA+IEZ1cnRoZXJtb3JlLCBndWVzdCBvcHQgaW5zIGNhbiBjaGFuZ2Ugd2hhdCBh
cmNoIGlzIGV2ZW4gc3VwcG9zZWQgdG8gYmUNCj4gPiB2aXJ0dWFsaXplZC4gU28gdGhlIG5vcm1h
bCBLVk0gZGVmYXVsdCB0aGluZyB0byBkbyBkb2Vzbid0IGFsd2F5cyBmaXQuDQo+ID4gDQo+ID4g
U28gaW5zdGVhZCB3ZSB3aWxsIGp1c3QgdmlydHVhbGl6ZSBhcyBsaXR0bGUgYXMgcG9zc2libGUg
dG8ga2VlcCBMaW51eCBndWVzdA0KPiA+IHJ1bm5pbmc/IE9rLg0KPiANCj4gWWVhaCwgYW5kIHRo
ZSBzZXF1ZW5jZSBvZiBldmVudHMgbWF0dGVycy7CoCBNb3N0IG9mIEtWTSdzIGhhbGYtaGVhcnRl
ZA0KPiBlbXVsYXRpb24gb2YgcmFuZG9tIE1TUnMgZXhpc3RzIGJlY2F1c2UgS1ZNIG5lZWRlZCB0
byBiZSBhYmxlIHRvIHJ1biBleGlzdGluZw0KPiBrZXJuZWxzLsKgQnV0IG9uY2UgS1ZNIChhbmQg
b3RoZXIgaHlwZXJ2aXNvcnMpIGV4aXN0ZWQsIGtlcm5lbHMgbGVhcm5lZCB0byBydW4NCj4gYXMg
Z3Vlc3RzIChhbmQgaGFyZHdhcmUgdmVuZG9ycyBsYXJnZWx5IGRpZCBhIGJldHRlciBqb2Igb2Yg
ZXhwbGljaXRseQ0KPiBlbnVtZXJhdGluZyBNU1JzIGFuZCB3aGF0bm90KSwgYW5kIHNvIHRoZSBu
ZWVkIHRvIHRocm93IGhhY2tzIGludG8gS1ZNIG1vc3RseQ0KPiB3ZW50IGF3YXkuDQoNClNvIG5v
dyB3ZSBkb24ndCB3YW50IHRvIHRocm93IGhhY2tzIGluIGFnYWluLiBCdXQgd2UgKEludGVsIFRE
WCBmb2xrcykgbmVlZCB0bw0KbWFrZSBzdXJlIFREWCBhcmNoIG1ha2VzIGl0IHNvIHRoZXJlIGlz
bid0IGEgcHJlc3N1cmUgZm9yIGhhY2tzIHRvby4NCg==
