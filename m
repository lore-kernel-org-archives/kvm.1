Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D012D23A6;
	Wed, 23 Sep 2026 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790122592; cv=fail; b=upOc6bJU4sHXzPvRQdRQOZ/qvR1R5pcyrYCm/SP1FsgTD35MY47KZg37sUVMK2vpcSDJWIpQfhBlmo8PeIsIsF9gj2Fx7HsORoPUILyvZkguyNjUln0/TgzUI4ldj0agm9jZA2UK+v8OZAkXlCVleyYPM1zjsM764XGLt3AUYgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790122592; c=relaxed/simple;
	bh=EXk0QY9cPABaW+W8dlW6HQoADOMpUCqfc85k/qhwTDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S2fy69g77HvRwRsZCMkrdubQmBvb7usZx/mSaSsXvAus626aCYrdc8RPhB1dlNO9txXYwAszB6EgYO/MX/dNTHtYW6j/xMjcKHWSthXczrkV8SDmUZayW/Gd2IN+hQrSvk6F6agTVZYD6+r8dwJ7w9UgbXhq3WhCzwWbD8yY7Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L94tjPr6; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L94tjPr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790122589; x=1821658589;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EXk0QY9cPABaW+W8dlW6HQoADOMpUCqfc85k/qhwTDg=;
  b=L94tjPr63GoRKEeUPLzi4EAd4SNNRpzOlNvnJ6dk3QrrsDJ7FF4PJWp8
   7Pxc+PUc9YKGClesjnwT5JIS3otH0qNT3+I7/WdDtl14IEvLwkRFLDyfK
   toDqOlzzUINeS/KvTxAqB1bl84p/7bDWbbwYUsG+bZvxK2nLgCUcJFoR4
   7MgaOElzuDbW2kFFfN1g5jVkkyi1ByW4PZLFVBmhipNRC5i1kU96248MX
   w1M3LuMhKuX8tIg7PTo3kCEdETMZHpQ8RcUum8a+rIvXIlHy39JWxVPfA
   uJuHbIQt5jqu+4U7HXjO89RsR6KzsfrnW035EpLaW9ZsgoMMD2cdQQjB2
   A==;
X-CSE-ConnectionGUID: SWw66mBqQW+zrG4kfckiHQ==
X-CSE-MsgGUID: 7ZrX4jebT2G+X8ZHbpr9SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90644533"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="90644533"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:16:29 -0700
X-CSE-ConnectionGUID: 3WHrDzH+QxOcQG29WbKWMQ==
X-CSE-MsgGUID: 4QRt3CG3S02pI79sQKzQJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="4418672"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:16:30 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 17:16:28 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 17:16:28 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 17:16:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTIORqijNXWX7H5AgV8reHz34tz847N68WYhqhklrrjSHZFvs2KUCWH1ZiEeys5hSQHGsd12Rln7Bd8DxohE4ylLaF+/HuAapmY3N4Ew3oMvr/CIkK1ujH93eKSz3QsnoKmA9GKJRg8n6x1Gi+S9qxSMDRmTbmI5BpraUZlwMfrq+bITbHk6/ox6GSKaUAadI1rckNjAkfqYmlsMpeyM6bKLCHQBSwyDTyMLFaSjvsINwzmqrq+JWMmuJP7pQ2hoWclJ6ogx0I7o9wshLOcXBU5JstK9IN2enuORK2F6cFXNv/SIRTSoi7bL7BNH6ipDPAChQTeRDgcv3Av9ZCwbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXk0QY9cPABaW+W8dlW6HQoADOMpUCqfc85k/qhwTDg=;
 b=tmyND3L89CLdaMpV+9vqBMewPWZBu0otJFfj1AEp7LfFXFBR+FmDSGtmd7HPzSNpVSeVsyCR74VtGGN5yvhVCDwOJtktxaSOimN1bpwe0q6G6gFzXM1g9hDfD4C+b4cj4l4WeZYOHTp40r3QQXkfwi/pdTt8Ce9MjVl7ZBcmIdaNufa6pHkUFE1GYTqktBfX8InjdlxT7Xi94Tu0kb2Cw+rLZEWMkFYTcD9h6Gnvbvw1zt5Rb+tu6vcrDSRQsuLYuPmWvA9XK818yG+q/4h3OQpDS+ZWlnSddwsa7WxREK+o7QRZtv0RIpGjz0xlgtw0cwNx6L9NoJFc812gY2aYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DSVPR11MB9577.namprd11.prod.outlook.com (2603:10b6:8:388::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 00:16:25 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 00:16:25 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH v4 4/4] KVM: TDX: Validate userspace CPUID input for
 KVM_TDX_INIT_VM
Thread-Topic: [PATCH v4 4/4] KVM: TDX: Validate userspace CPUID input for
 KVM_TDX_INIT_VM
Thread-Index: AQHdRnUz8nVPI7bWj0qzURm5zjk5dLbbVJ4A
Date: Wed, 23 Sep 2026 00:16:25 +0000
Message-ID: <f4caf60832121805e7784cc8f2c533ae266acdc4.camel@intel.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
	 <20260917072548.2314491-5-binbin.wu@linux.intel.com>
In-Reply-To: <20260917072548.2314491-5-binbin.wu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DSVPR11MB9577:EE_
x-ms-office365-filtering-correlation-id: 9f1285e8-4520-4971-1367-08df1907e7ab
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|38070700021|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: J14bOPXYUI9AnbYFSIZL/2bZOxszxOdS0MsEhTbPaf3py7ciY+7jKg7S/kOwkIp6zpdl9wO7ZQfXFhm2BXeN9WIJDbQd3j5GUMJojMnlER/vT5HQF697Xez3vEA85UF1hQuipci6aRC6hNcz0EGIn/XRYCpf699ywepG/ppNGyzeex8+s+KiHFqR2syk9BpaS+BXJwiyfi8Tv8VWhfQOn2/uka6ETpd1WcGmaGYxxCDfnjKf1lq1Tqs7b3y3wEOOqYoWD64TAzrPR/OeHSUmQhnySqUMBBQMBTESe2sJsNVEYlr96/61mkbWFaBMlztvC17q3ecYqwtPiCQyQqYOdRRQYqjZLiTUlV21/mMmBw8/+y2MJc6Lelbmn9J3rrcNOtS2rDdtC66vbNJukjkXhHtAbicR+NUIuH+EAlQZqprqBzyWzsbFICZ6v1az3EXw0m+KJnTJ/QSqkKobv2q9tp429v5lPcJ3xgqPDYpXZUARldssCyIbAd0viiSNz2nyU3KE4qh9d/7bbVMxDJDMU+cx2ej4EOCQz0o64hHeZVue0CKb93GwQwTcpP6f7sIZy9D2EJkl6rhNRZmh1dWsILshZdPQya+mjTsS961ctPxpWytNltKQkilipHbBgCHzmYlNP8+Cvoa+xr45zLvsz6XFuqN0TwCyYCrYo6V5VFB1QW0pnN4NjMA52d8nb12r11Dk/laGY54daYNf2/cpTZfxTW2dk66+ACqfU/QhodY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXd0NFBjZXp0TkUvNXVRclNpcStsbkdiL295TVRib1Rhc0I3dllYNXpoYjZN?=
 =?utf-8?B?c08rU3o0OUtiNzYzSU5SaDBRNGRybmJyMFNpNjJTRlBtZEhlcWVZcEhxalBX?=
 =?utf-8?B?Q1VrTzF0S0lkeURUajVaeUZURXVJY0FlSndGS3lpZTVmbWNabFdPRmZyRXYw?=
 =?utf-8?B?QTR6eXZRWVRyZ1N3KzVJWlF1WEdJMnRpdmtYNDlSN09jMll1L0dHSEtpTkha?=
 =?utf-8?B?WlR6VHlTRHI2dlVjVGI0cndPeG43NnBtbVhsSTJTYnpmWWxvZ0Urd0JKVTQr?=
 =?utf-8?B?NUwrcEY4cVQ3Q2tZNUNLbzJjVGptTnpxZThMd0wzL2xXYmFwNGVTcitscDZn?=
 =?utf-8?B?YTR0b3pPQVBtNFlPUE5OKys0T0lDbXR0V3R1Q0tTUnRiSlhFV3I4bi90SXow?=
 =?utf-8?B?QlhzdXJBSVN1WHRkNGk3TjVUR3NDUE9rYS9FTHRmakYvMnNtVERGTm9GcWlH?=
 =?utf-8?B?aG10WVQ2cWx2ZFlhdUxpQWxtTEh3ZFVLRG4zUVFsR2I4RWpJblY0ZXhkSEE2?=
 =?utf-8?B?UnYxL2tPSm93UmNOa1Y2eld4RFpxdG1UdFR4M3l3V243cDVuWEZwbS91UmNi?=
 =?utf-8?B?Rko1eDl5TXZZVmMyenM1Q3oycGpjR0Z4Y3IwZEV5cFZDOTVSSjJqODRFaGgy?=
 =?utf-8?B?TERvcW4zWitlUTdiNDRVWmVmZ3VKUjQ4a1dIVnhWeVEyU2ZqdDBsTzJVRnBS?=
 =?utf-8?B?NTBUblJ2cWg2Z05qaE5mTXZRRmRVQnRTM00yM2lnWmFLOVRIRGFZNkFSOEor?=
 =?utf-8?B?bHFGaFlDV1BGVndiQWxCUFg5cGZWYWV5QTV5V2wyVzlDTDFWSzlOTHJ0aHJU?=
 =?utf-8?B?QkhEcE53c3N6bE1VTi81eWJaOVVyanpPbWlkSUY3TDdReTNzNG9ySllteHVt?=
 =?utf-8?B?SUMxanVWVDd0NzRuVFB2R3JTaTh0NnJBL2VXby9XaVNla0V2UmlRVHBrRW5W?=
 =?utf-8?B?bVNRZjRaL0hWcTZJUnppRmdxdWVPMkNnWWFFYUF4VmlrbmIweDhkSWU4YUla?=
 =?utf-8?B?cEx2MGpkWTUzUllSM2dTTTVGa2VuV1l4ajA4YitmSi9YSTFvdzVNTmhnb2lG?=
 =?utf-8?B?bnVPUTR5RDlWdm4xVVZRS3JHQnJOUTd6RXZuZlhlYUNnd21wTTVibFZnQkZW?=
 =?utf-8?B?cGNOdForYWdOUERKcGxnYW5lYUFldGJwd3NJb25uK0NSQ0VnNEVtVDEzSisz?=
 =?utf-8?B?aGkyV0o5WHV4cWtkd2w0YWlWblkvK29QTGRnZm5qeEN2ZzhBSGo4cW5Id013?=
 =?utf-8?B?K2pObWRycUVBTnpaemxYUWhEd2RFQ0pwUWFoV0l6b3pKaHNKYXk3M1k3eE95?=
 =?utf-8?B?eGg0QjlqMnp2QlhPRDYzTkhSNHpWLzEzZm1jUnpoc2N0MnZrN2luaUNKMm1G?=
 =?utf-8?B?dkhoKy92VmJ3UktNeC9pemtmek1mbW0zaVdOSHRYQ1BRZU5HN0RicTZxa0t4?=
 =?utf-8?B?Qnl0aHJueWF4YWhZMGVGY0wrWi8wTG80MmhKc1Q0YXVuNDRMMTJYT20yaFZw?=
 =?utf-8?B?MEI4OG93eWUwSkVjRkRzUGR2b1hGdWlJS0pRNjVwTmdUN202NGRmdzFUcU0w?=
 =?utf-8?B?a3Q1RGRsYVpBMmR2dlJjYzNackJBRHRKS3k3TGJjVlJoZ21qZlI4amlXQVdG?=
 =?utf-8?B?OFhRbk1lNVFZR0RtaVNDVndBZWU4b2ZwWFVKeC9jVURGaWRPblkrTTJnUXB4?=
 =?utf-8?B?K3pIcDRvSjRZd0cvc2w0akZZeXJJZUR1OVVrcWFpdWRtT01Oa0NTUVRFYXBJ?=
 =?utf-8?B?UUUzTHVEaUxWRzcybVBwVlBkR3RsZ3lXWXAvMEVxdTRRZkptcXBXVnUxaVpH?=
 =?utf-8?B?Sm1XVkRlWUtxTkVFMis5TjNnbGxPdDhVOXRnQlRnVVhOZS9Wclo5UnVDSGNJ?=
 =?utf-8?B?QzJMYXFXTTQ5QXFLdEJ0NnE3ZUJxOXFMZnhoUktZcjhYY3oyWEJsV0dHY1RZ?=
 =?utf-8?B?N0laNXVONjljeStLQmFTai9CbTNhU3p6TFBqYlg2YjBtdjlSNUVmNjN0Wk9L?=
 =?utf-8?B?WnJ1blVZTWlNdXhmcGRiMGg2bHpIMTdhUzlrd1pSeU1FNjF2amlVN1RJU1ZE?=
 =?utf-8?B?QnowOEl3eDh5MUd6TVY3QmtuZUJVdGlFaVlwQ2xNMDhuSlY2alc1UTFHTkRO?=
 =?utf-8?B?akRCS0szY3Q4NEtEMEFwOElCVzh5ZDI5R2JDM0VRZm8rYkFaaGhNRHgrR2RC?=
 =?utf-8?B?UUFmNHhsdUJLRkVHZWZiOWdtMmVPTE9TSVB3Sm5DOUZKTlMrU1BrckhsVC9v?=
 =?utf-8?B?T2NMVythRGdmbnpNQWY2dG9XOEMvN0w5a3J6ZTZpaGt0MU1ROGdIR0pMd2lP?=
 =?utf-8?B?SzJ1V1hDZ2lQNG8rWEFIbHJ4SUlPbWpGMXVSL2laYWp2MnVmSmwzVmMzV0Yy?=
 =?utf-8?Q?294Yk0JxaFZor+Rs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D921D3046CE21F44882B40D75836F498@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: E7uQC4ZpylRYUtF89bWKeGqodqGC81DCa+3UBSLh+PNe+Sog1/FMPXA3NF8MuNgft6j8f0yc4Z29B9N7vyBzgI0ZA+EslCaY5o7FTQHkVh64Buh+RwrnlWw9qn2lOQBORhsCK8jx2bGFEduQA+EWJ/QI81yQybJEJYm0E4gd5MCJ6WeSDTNLOQXPqNXzkK12N40cyYWnMIkUmaCji7OYJTBH9A5nk9hZtmiBliNIBNatlUlozcRNSGbJdvkdVIdN1CGYS7YlnUriwgFfpPD6FdKLeMbQXs1b6ZGpAwds8WKg3U6RcDB3UdoOd6UkBexetH8uVKFpCeOtyzyCTHpr3A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1285e8-4520-4971-1367-08df1907e7ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 00:16:25.1746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZcdpIY5aGAA8xdRwfUQ14FaXPxY+hb+BjnjqUGyZ+gXh40tYZl3OHhc0Dz0J+GN4iVlQpMG/NMqA+njDDAtYtW7YbiO3ZNkyg1GLEf+QM/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9577
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTE3IGF0IDE1OjI1ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+IFZh
bGlkYXRlIHRoZSBDUFVJRCBjb25maWd1cmF0aW9uIHByb3ZpZGVkIGJ5IHVzZXJzcGFjZSB0aHJv
dWdoDQo+IEtWTV9URFhfSU5JVF9WTSBhZ2FpbnN0IEtWTSdzIFREWCBhbGxvd2xpc3QsIGFuZCBk
cm9wIHRoZSBoYXJkY29kZWQNCj4gZGVueWxpc3QgYmFzZWQgY2hlY2suDQo+IA0KPiBUaGUgVERY
IG1vZHVsZSBsZXRzIHRoZSBWTU0gY29uZmlndXJlIGNlcnRhaW4gQ1BVSUQgZmVhdHVyZXMgZm9y
IGEgVEQgYXQNCj4gaW5pdGlhbGl6YXRpb24gdGltZSwgYnV0IEtWTSBtdXN0IHN0cmljdGx5IGdv
dmVybiB3aGljaCBvZiB0aGVtIHVzZXJzcGFjZQ0KPiBjYW4gYWN0dWFsbHkgZW5hYmxlLCBvdGhl
cndpc2UgYSBob3N0IHN0YXRlIGNsb2JiZXJpbmcgZmVhdHVyZSBjb3VsZCBiZQ0KPiBlbmFibGVk
IGJlaGluZCBLVk0ncyBiYWNrLsKgIFRoZSBleGlzdGluZyBjaGVjayBvbmx5IHJlamVjdHMgVFNY
IGFuZA0KPiBXQUlUUEtHLCBpLmUuIGl0IGlzIG5vdCBmYWlsLXNhZmUsIGFzIGFueSBiaXQgdGhh
dCBhIGZ1dHVyZSBURFggbW9kdWxlDQo+IG1ha2VzIGNvbmZpZ3VyYWJsZSB3b3VsZCBiZSBhY2Nl
cHRlZCBldmVuIGlmIEtWTSBoYXMgbm8gaWRlYSBhYm91dCB0aGUNCj4gZmVhdHVyZS4NCj4gDQo+
IEFkZCB0ZHhfaGFzX3Vuc3VwcG9ydGVkX2NwdWlkX2NmZ19iaXQoKSBhbmQgcmVqZWN0IEtWTV9U
RFhfSU5JVF9WTSBpZg0KPiB1c2Vyc3BhY2Ugc2V0cyBhbnkgYml0IG91dHNpZGUgdGhlIG1hc2sg
cmV0dXJuZWQgYnkNCj4gdGR4X2dldF9jcHVpZF9jZmdfbWFzaygpLsKgIFRoZXJlIGlzIG5vIG5l
ZWQgdG8gZmlyc3QgbWFzayB0aGUgdXNlcnNwYWNlDQo+IGlucHV0IHdpdGggdGhlIGJpdHMgdGhl
IFREWCBtb2R1bGUgcmVwb3J0cyBhcyBkaXJlY3RseSBjb25maWd1cmFibGUsIGFzDQo+IGFueXRo
aW5nIG91dHNpZGUgdGhhdCBzZXQgaXMgcmVqZWN0ZWQgYnkgdGhlIFREWCBtb2R1bGUgaXRzZWxm
Lg0KPiANCj4gQWxzbyByZWplY3QgQ1BVSUQgZW50cmllcyB3aG9zZSBpbmRleCBkaWZmZXJzIGZy
b20gdGhlIHZhbHVlIGV4cGVjdGVkIGJ5DQo+IHRoZSBURFggbW9kdWxlLCBhcyBrdm1fZmluZF9j
cHVpZF9lbnRyeTIoKSBpZ25vcmVzIHRoZSBpbmRleCB3aGVuDQo+IEtWTV9DUFVJRF9GTEFHX1NJ
R05JRkNBTlRfSU5ERVggaXMgY2xlYXJlZCwgaS5lLiBhIG1pc21hdGNoaW5nIGVudHJ5IGNvdWxk
DQo+IG90aGVyd2lzZSBiZSBhcHBsaWVkIHRvIHRoZSB3cm9uZyBzdWJsZWFmLg0KPiANCj4gVXBk
YXRlIHRoZSBjb21tZW50cyBmb3IgS1ZNX1REWF9JTklUX1ZNIGluIHRoZSB1YXBpIGhlYWRlciBh
bmQgdGhlIFREWA0KPiBkb2N1bWVudGF0aW9uIGFjY29yZGluZ2x5Lg0KDQpTYW1lIGNvbW1lbnQg
b24gdGhpcyBvbmUgYXMgcGF0Y2ggMywgdGhpcyByZW1vdmVzIHNvbWUgcHJldmlvdXNseSBjb25m
aWd1cmFibGUNCmZlYXR1cmVzIHJpZ2h0PyBBbmQgeW91IGNoZWNrZWQgcWVtdSBhbmQgcmVhc29u
ZWQgb24gdGhlIHJlc3QgdGhhdCB0aGlzIHdvbid0DQpicmVhayBhbnl0aGluZy4gV2UgZG9uJ3Qg
bmVlZCB0aGUgZnVsbCBiaXQgYnkgYml0IGRldGFpbCBoZXJlLCBidXQgaWYgc29tZW9uZQ0KYmlz
ZWN0cyB0aGlzIHBhdGNoIGl0IHdvdWxkIGJlIGdvb2QgdG8gaGF2ZSBzb21lIGluZm8gYWJvdXQg
d2hhdCB0aGUgQUJJIGNoYW5nZQ0Kd2FzLg0K
