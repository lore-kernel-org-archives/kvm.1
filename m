Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A23876CD;
	Wed, 12 Aug 2026 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786574867; cv=fail; b=UybJpFcuzZ4svVoBEnp9+GvNrYUCbuO+JITlHARMTY2SUkpgms7Xh+hBFvHM0RZwVzjGhFjid7K/uCA01DN8ZO+U2RYQoYCL6v2M+mG6v8bQDeB/xqMZrBJCp+ufmJyQ1DDLpJAUWfsraXbxTuXpTDYDPaI1SeLTnTZ/CnXJOxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786574867; c=relaxed/simple;
	bh=EsS3ZLsfEKgAUd/YOo+oyKpM1hCPxsgNRqQd7kCLGfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jNbj/KQHj3xwjCDPD2TyTxr6EATXAUBWevJUbN4uzn/0SYRtfXUIwlkakgniA6oAt3wie5aEjeKu4xGuUfVKUw2piGyhbVAgC5ZStVD/hdWkSAymoW14xfrb6FGmVzJDeXGFqTG7L7HUODwrPP7prPfCJx9HMT5i2EK3DakvyWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ft6Lm+5k; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ft6Lm+5k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786574866; x=1818110866;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EsS3ZLsfEKgAUd/YOo+oyKpM1hCPxsgNRqQd7kCLGfs=;
  b=Ft6Lm+5kcxTdPsI2mQSYs28+W/0SN9o4MUPV0+08GDrIOAuUY96He+PM
   gii5LT8RpqUs2skyuVjClXCz7bv9bMgGg2j6NC61kp1UJPLgl4+pK+0cu
   R4NzxyLMLGMApUCpW6oS6oGZkwFcADVTOY6hoOatjJqcyrbXQsixs5pFx
   mkcGeWStoz3W45yPTv6KbR72vx3boo4MzZg5Gabe/mYwPEZQLEYLo8SHJ
   vfaYIPh5dHwSGgg6iZ/IBYiybRcWcq9QhUC208m+sK6exFo6ANj0TcLtN
   manObE4zT1u7WpcC9L6WT59aprt3vBEyKWmY83rYfqSTqbQSN3RpiXrtA
   g==;
X-CSE-ConnectionGUID: mQZ1OpUMS+iM1YP3Iq8mLg==
X-CSE-MsgGUID: Fx5dnnjgRuOQT/Lv7BRksQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="89665513"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="89665513"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 15:47:40 -0700
X-CSE-ConnectionGUID: jIEdqMNaSjCTywNEvJ7u4Q==
X-CSE-MsgGUID: CowTW/07S5edf2QJPtjsig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="268947402"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 15:47:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 15:47:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 15:47:38 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 15:47:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1X/aRKcavhLA17pK/7HUEk/QCkzeYBuTKBg0k4vh8u9ckyPgq5tfuYhG4J3z4xqGEi7xQDGxsmbgk3UB/JD4LS38ZRhr5peDoxYQ6SWKKqfxWVIgtFJqVVn3nrNV/WDsuxl+GyZUD1bc5fWlMh1n5pHT/Dcv1wQ1FMhPJ4Jvsr3vvzaCeL8X8F2Uo7Cv5my07TBzN0qhTtdfV/8xgSn3Rap3z+X0Qb2yF9X3CSYDuTjlo7j+5P0g6v0GVbqDJYLYkZlyxiY3vspa1bQ84rZbK5Z+1LF/D47UlPAIRFR8b2EHAHhvxzbontWVzADpc9KJTJJzdtHPCCnSV10eyWe1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsS3ZLsfEKgAUd/YOo+oyKpM1hCPxsgNRqQd7kCLGfs=;
 b=qgjUll8k9r3DHRoub6Ix82IzMmaSKL1AAHwm+c4pFvcXPfmw2KZgIig2rKLy3rxPcHQWIGIVz6bCT+ivLgxmAkAFx9r5R1Br9CKw5Xx383aHlNmD7tk5U7ogNP5c8qRHTtxYvI3jYdhX09u90ge5/jd1Zm5+Xr7L3DItNvjA+5LW3U+bqC7Mtf71984ArsmUGEAmtXvI2ldJy0aPzXGZYBLGwEWD7qFhvj7ZP5JVa3Dswbrn3sKE71/KtzljY++fO4z+Fy3slEs5+NLH2YymAGVtUveHaWEQBHLjrMC8uFAWac1HSd9gKeyK6CuxqanvYuEe/AxgAmrA3Ak+iSCi2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 22:47:29 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 22:47:29 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Fang, Peter" <peter.fang@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>, "kas@kernel.org"
	<kas@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Bityutskiy,
 Artem" <artem.bityutskiy@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Topic: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Index: AQHdH1YE/ME7/hSMIEe/+GB5P8Iam7aFAbAAgBSEcgCAAQNDAIAAIM6AgAAKnQCAAAuxgIAAVwiAgAAC5QA=
Date: Wed, 12 Aug 2026 22:47:28 +0000
Message-ID: <6191a69559e58e04c8e3f1efa776e9639796af3d.camel@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
	 <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
	 <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
	 <anxvwV_Pz4UYaxxt@google.com>
	 <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
	 <anyiwqi9i0NSv0QW@google.com>
	 <ed4891a59096c59e43a893910c9f17d0ff6086b8.camel@intel.com>
	 <20260812223707.GD1013044@pedri>
In-Reply-To: <20260812223707.GD1013044@pedri>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SJ0PR11MB5214:EE_
x-ms-office365-filtering-correlation-id: 425200a5-7cc7-4f4e-6b6a-08def8c3b01a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|38070700021|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: J+l315YcxuHWxhzkeevciOUxBT0LTd3aGC5ssRkaJEXlqSl2zu/ZWwvC5xByH9c5ntjlfQvyQiuesNI1fPdmfTW+4prl3Ohxt+EEcuHq6QoZTYq2SJ19q0t0IE/jBC+gtMo4wyhet+lcqQqvd/tO8xwUrO2A1lFTOqk5gl0pJIwrleZf/B9iZSFfaL8TOXOIWdtaA11M5dfxnlRB2RuWMopZMWJw56jza12FQDDuEOYw0MG/tk1ZqgTbm4pTIj4eix3JR6oAeHHXI/JY9Dz0+uS12Uyg1rQ9zZle1f7nxQhmavlenpOsoL7LixNstM5xXZBsC/mcSo/CQrWeFn9l1r3uPYOmaHgAffzcjcBuFjhUNcy6z682Y40esdFBJ/sUEq50h6zeV9dvAhE7jxmSz7cRDtGB73/l2PKXz9ZflPT6X5aFDIXS0mLaoIjF94/9VpLSYUIT4uDJTuQWjlQHJ2DkSfxyhVo98mTbRWl2MBgn64bnLTX+gSuhQHgisj3X5OGiGbxsPyRgBV91zX8c/5JXcIMr5lx1WW/UHFm9OaSU8Kgqp603wmdqXZ6Um9ttxerBnFRDJbv6WV6oG6rnDkRVvQSoBo0X+mfRK1ig+hhjX25tMcgn8jZqw2Ng178dSxtE7d69CToQFHjQYWQUGL3ecNCo13FV8YoE4wsZFJis5CJpfwcZxh9jlteqQh1cllDTFVsa7uvXc0LpweHswEJvIDEqTlAbB+87dsCZvYs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzlsR0U4MThEL1JzMmtGVHNWa1pka0hBMHNWYXJ1bHFWc1E1Sk5VSFdJTTRN?=
 =?utf-8?B?cFAyRzJFMTVpZXJlcDVJQ1NhMCtEaHV0WnNZbW5TNGxwZmx1QklPczRXQ3l3?=
 =?utf-8?B?TzZXSHB5dVJ4amhMTmZaTkxBTzdMdnl1Q3FIV3VUVHpKeEkrN09MY0VFdU53?=
 =?utf-8?B?T3FqekNGYTNhV1M3VnMwVm11dVU1enNIMHZXN1kwTitMMmI4aTUxTnROQkFl?=
 =?utf-8?B?WEh1aW94NFB6TkZ1UG52d2kvampzQWxvako4N0ZPWGZMYmxIa0RtbE00Q2d3?=
 =?utf-8?B?bGxXaHZEZnNleEsydmo0NGZuK3FkNHZKaTY5bFdBNFNWOTVBT0dSdVVaR1pX?=
 =?utf-8?B?Q2dkMjBxb3BFa2w1ckszRWZSV2hFU0pkbEVmQzZrOFE2UEdLbTRXUWFKcnlH?=
 =?utf-8?B?d25JR2lPVDNDNkQwazhxcFZSZnlkMmdlaE96VUxrdzkyeW0rY2ZQRGEra2lV?=
 =?utf-8?B?dXNwTFpFaTl6WHp6eTFIMzNTTm5kV2VnZnY4VE0zMEFTaVhJREk1c0huZC9X?=
 =?utf-8?B?djd4YWpxblhNakRDUDJVcW10ckwwRW43SHR1c0hsd01pRmdxTEtVSUtEWFZz?=
 =?utf-8?B?eHJpVE1JSWt3WjZ3RG5LUUJnZWpVbEtVbXluWGhrOHMyVElpL2l3Y1V5YVBt?=
 =?utf-8?B?QnhIak14WHVzOVhCdG9MWE1UZTI3WkZ1WG9QdnE3cXE0UkRMRFFKeDY3R3J1?=
 =?utf-8?B?bU1pQTR6N2N5QkU3NzhiZU9lVVlVZHltOW1rQ3BTMFk5WmNkd09WMGthSUpK?=
 =?utf-8?B?eVN6QXRTdEM3VTZYZVhua2I4enNEQ1Y0S05GUEExVkxoYy96dHhIUjh2ZFVR?=
 =?utf-8?B?STdoTVR5NGVCWnBUbHcvTGh4S2w1ZzVJdTJSRDhCZHp2VlJyQnA3U2pTTlhp?=
 =?utf-8?B?a2xDR0RNNUpOQ3p5TlBPcW85NHZac0kvTEhwSm5RV1lqK0UxVU81YnVPMUdP?=
 =?utf-8?B?K01FK0hoWW5YR2dER2Q3VVV1Q09DVFhjbFVjSWxnY3hTOEI2cVVUV0g5UFZk?=
 =?utf-8?B?ai9Nd2tZN25iMERjRVUvaEtwSGpsb2xQUlZSSHpmQmM1dm02S3lyb2JYTWNz?=
 =?utf-8?B?NG85UUFGWlRKVjZYOFJ1T0RnLys3SVMxK0xXcS9nQVZrZzNVT2xCc3Q5VWhB?=
 =?utf-8?B?QnBBZTZIN21rRTBDUlhIOC91U2ErSWNNakpmbm1EYkh0bUludUFOSmxjRlVl?=
 =?utf-8?B?ckJqNmRzYXJoT3RVcDZFWHdnVjFzYVpQMGx6OWRWZnU1VERQSjlqQXBTNUk3?=
 =?utf-8?B?Z2I1NmR0QmFJNis2cXYvdHJLV2xLL3NqWUdNK0laWHA3UGZBdGRBalI5MGY0?=
 =?utf-8?B?NEVwdUt4SGNTU0t1cDh6bkNlQmszN1Rxd0pTeFhCQm5JUGU4NVlkOEZjM2pv?=
 =?utf-8?B?OGZjVGxSMUpiTEVZdHV0aC9Kb0NxZTdaT0pvZVpTa0RxbU5HYW00SUI1QTdw?=
 =?utf-8?B?K1JJL3JtMlNJbzI2RC9RaHdRdytMczF5TE1ra2s1cDFtSzMzYXRhVHFQejNG?=
 =?utf-8?B?MlZzVlVUdlROTnFjZnMvbWRtbUdPQnJ2Sk1IcWhZeWhFaW5ZU0tycnM0ZkpC?=
 =?utf-8?B?dzFjOStjRWZTUjFTUFMrdDViMWg1OFdaR1VwTHBsbXphV1FxdDBGWDBTb3Rm?=
 =?utf-8?B?c21SeldZSi9OUk9hQ2J1YW9UVGRHQkFIRy90QzdVem02bjZWK0k4TFg4QjdX?=
 =?utf-8?B?ZkFIMkV4TkdvSXU0V3JxZnRIQXdiTkFwcHBEUVhvbkduVUlSMjQ5VmEwWC94?=
 =?utf-8?B?VHM3ank1TlNXckZRbEducE5vSjJHQ1ZQbVA0T1Q3VE5CTVgxcHI4VFBRbitw?=
 =?utf-8?B?ZFBMWlQ4Sjg5eXhEU1pzMlNSZjdJV3RNWTl0RlY1QTlocHZ2WHZXM0QrUXd1?=
 =?utf-8?B?bFdScHBJcGtjZnRzQTZJSFBtTSsya0J4T3owTVRiOVVkUndTZllHNXBTZDJP?=
 =?utf-8?B?bktjUWk4SXg2MEFCNkdDK0o3SCtaek1TMjF0WE9MMFFOa29nSlJMZ0lmaDM4?=
 =?utf-8?B?ekpKaU1wYWk5bnc1bVBHQWExS3lMNGl0d0QzTTFVYlM4c0M3OWo5Um5vVXZQ?=
 =?utf-8?B?Z1JBbGRxWFh5MjE3RS9RajRhZzhnN2RRbVJ0OUZxU1BrbTFmZ2p6T1YwVUVL?=
 =?utf-8?B?UndVVjRyS3hwWmZQQ1BjSFd2Tmo5ZlN0WnJlRDhaM2JSOVVQam5qMnNmZEFu?=
 =?utf-8?B?VisrS2ZIaWNEbzlpWjNqRTd3cnBIalFGZml2d2xkbGJXeE5Ybk80bnBUVWtN?=
 =?utf-8?B?L1FneU5RZXZyVnplS0hVTzhNSXQ1ZTVEcWE1QW1xemswNStJTC8wYjg1N21E?=
 =?utf-8?B?ck5RMmN4QVp0Nmx1dnY1R1NOWHBTdXpaZ1NiQTJnd25ZUlhJQWJlVE5xa1d5?=
 =?utf-8?Q?+PEUBuQKFTHGYYzU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59B2FECDD68F8B438822B7C19B64FADB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iRzLubVaRWYUJ1Mo6TJsw2ERJcov0tNDmOXOI/coEv0Aq6yY2Jd9omcztF7F2psYs04Y4Ibxsk671Vt96c4UIlP2mtLbp6oWOIx5FQldey7kPCaLDA6KsWrUn0O9QNzOeZFl6CTpuHaSXX8iqDMfeUfHXqHVV9lydToQHDO1Ww4GomgVh4KVgy/+I1Tr50d+LySdXan7FvHbklXKAoWrKFwCe5rEZ58XE3zgY9i6SrUtRiFNf2GW7CQTSeTM5Cu/4AbLcTJf3oycCVVQwf1NMtvyuEL6g3W2JDQwd64WH9XOIO0b4mI5AEtuhJydef8/9B/rw3SvE+lUXboWlLuFvw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425200a5-7cc7-4f4e-6b6a-08def8c3b01a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 22:47:28.9626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNRViySOFmu3ekBTBIyz2tbE3uG0Z2pExJj0QfqGpkoAySwgmmp7tl+UUqSLy73OUG0Hc4xg4kSiWMobscoeODSyyMyBq2yts8HcBsydZkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5214
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTEyIGF0IDE1OjM3IC0wNzAwLCBQZXRlciBGYW5nIHdyb3RlOg0KPiA+
IA0KPiA+IEJ1dCBwYXJ0IG9mIHRoaXMgdG9vLCBpcyB0aGF0ICJESUNFIiBpcyBhbiBpbmR1c3Ry
eSBzdGFuZGFyZCBbMF0uIFNvbWUgb2YNCj4gPiB0aGUgZXhpc3RpbmcgVERYIGF0dGVzdGF0aW9u
IGZvcm1hdCBpcyBURFggc3BlY2lmaWMsIGFuZCBtb3ZpbmcgdG8gdGhlDQo+ID4gc3RhbmRhcmQg
aXMgZXhwZWN0ZWQgdG8gbWFrZSB0aGUgdmVyaWZpZXIgYmV0dGVyLiBTbyBURFggZG9lcyBub3Qg
aGF2ZSBmdWxsDQo+ID4gZmxleGliaWxpdHkgaW4gY2hvb3Npbmcgd2hpY2ggYml0cyBnbyB3aGVy
ZS4gVGhlcmUgaXMgc29tZS4gQnV0IEknbSBub3Qgc3VyZQ0KPiA+IHdoaWNoLg0KPiANCj4gSW4g
dGhlIFNHWCBlcmEsIGEgbG90IG9mIHRoaXMgYXR0ZXN0YXRpb24gc3R1ZmYgd2FzIEludGVsIHBy
b3ByaWV0YXJ5DQo+IGFuZCB0aGF0IGNhdXNlZCBhIGxvdCBvZiBwYWluLiBUbyBmb2xsb3cgdGhl
IERJQ0Ugc3RhbmRhcmQgdGhlIGJpdHMgaW4NCj4gdGhlIHJlcG9ydCBoYXZlIHNwZWNpZmljIHBs
YWNlcyB0byBnbyBpbnNpZGUgdGhlIHF1b3RlIGJsb2IuIElPVyB0aGUNCj4gRElDRSBxdW90ZSBk
b2Vzbid0IGp1c3QgY2FycnkgdGhlIHJlcG9ydCBsaWtlIGFuIGF0dGFjaG1lbnQsIGFuZCBzbyB0
aGUNCj4gdHdvIGNhbid0IGJlIHNlcGFyYXRlZCAobm90IHdpdGhvdXQgYnJlYWtpbmcgdGhlIHN0
YW5kYXJkIGluIHNvbWUgd2F5KS4NCg0KWWVhIHRoYXQgd2FzIG15IHN1c3BpY2lvbi4gSSdtIG5v
dCBzdXJlIGlmIHNlcGFyYXRpbmcgdGhlbSB3YXMgcmVhbGx5IFNlYW4ncw0KdW5kZXJzdGFuZGlu
ZyBvciBub3QuIEJ1dCB0aGUgb3RoZXIgcGFydCBpcyB0aGF0wqB0aGUgdmVyaWZpZXJzIGFuZCBv
dGhlciBWTU0NCmluZnJhc3RydWN0dXJlcyBhcmUgYWxyZWFkeSBleHBlY3RpbmcgdGhpcyBzdGFu
ZGFyZCBmb3JtYXQuIEl0IHdvdWxkIGhhdmUgYSBsb3QNCm9mIGRvd25zaWRlcy4NCg0KQnV0IHRo
ZSAiZ3JvdyB0aGUgcmVwb3J0IiBvciAiZ3JvdyB0aGUgcmVwb3J0IGFuZCBxdW90ZSIgYXJlIHN0
aWxsIG9wdGlvbnMgdGhhdA0KbGVhdmUgdGhlIHF1b3RlIGluIHRoZSBleHBlY3RlZCBESUNFIGZv
cm1hdCwgcmlnaHQ/IFNlYW4gSSdsbCBhc3N1bWUgeW91IHN0aWxsDQpwcmVmZXIgdGhlICJncm93
IGJvdGgiIG9wdGlvbiBmb3IgdGhlIHNha2Ugb2Yga2lja2luZyB0aGUgcXVvdGluZw0KcmVzcG9u
c2liaWxpdGllcyBvdXQgb2YgS1ZNLiBJZiBzbywgbGV0J3Mgc2VlIGlmIERhdmUgY2FuIHdlaWdo
IGluLg0K
