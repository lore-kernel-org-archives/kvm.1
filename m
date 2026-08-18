Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD6938B15B;
	Tue, 18 Aug 2026 23:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787096815; cv=fail; b=biEbVw69/9OpcyMe/qXHNBUvCgOyT3BH7zCnHMydDrWAsgcvhgDA3v/pibr4qFtSWL4RdWAoL/PX/PKi+S7L8PzqO3SL4zipxinOFn8fLqDWnGJRCOiPXtuqOngkIJSjdpura/XUgpR2YoNNa+OWhdiwygXndGqaymfQx5xDK4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787096815; c=relaxed/simple;
	bh=JOeeRHtRSeCK389Gj6GWXEOKh4oNknOTXes+8asfevg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MZIQu4X07OvOmnPYnhHtyZhkQYtcsxsg5dRPqW20drzoey3Yhe9HwDqrGHlPeJujEI+gWBU0X2P2fxXzJTpNuqYwOX+4/t7DTgFylENKie7ntGfuZYDvCAJbDtXt2XBGgQeOhCMoGnWAXka8fYJtPuQitUan8k0xvACGINPkZfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOIT9vPY; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOIT9vPY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787096813; x=1818632813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JOeeRHtRSeCK389Gj6GWXEOKh4oNknOTXes+8asfevg=;
  b=LOIT9vPY3obwH4gRpFTn4CvgMALfH7nc1oHifpdVr0hQt4nHKHonbWM1
   nBob9frlHwmSfBR7Ce3BK+R/F5ILwqAzqEJMDc3jRCQbwHg/69k+uPR5R
   6Glvb1hGV+61VBmOPI/DWHvLMRKpdZa5UwXjiuxPrdKch3MA5P+9W12nV
   VaQCkWVT8a6Vyby3b+b+EOHfXQKc/JfEElGLlvaJsV7JD9X5Q2O87uqKl
   yMANjOdgYHJ2Wyywmp5V0FAxv6m2DqH4BlWMar+aYEoFxVm9fCeaUEIgx
   M2Nqi8I9KdHHazxZAbm1mQK2ym310d+cfnTqYlX9RXuJXfkbv1qT7oOhM
   w==;
X-CSE-ConnectionGUID: MpvpZRARRRSibStXI1GqFQ==
X-CSE-MsgGUID: OEIiShiZRcaMo+3aM12yqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="98193166"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="98193166"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 16:46:52 -0700
X-CSE-ConnectionGUID: fnU/E93MTCe5bjtP6AG0ZA==
X-CSE-MsgGUID: EtytBMT9QK2/kCRQKGUxug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="288883530"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 16:46:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 16:46:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 16:46:50 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 16:46:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpfSgzhbrYewTDlk9paQ4yeo6cTYjr1cIEOUTl00pwOSsEoThZJaFNSIucTBGe0QH8FEwScInomKPuOMfINhH1+5otYYywhyMxOq1IcsEN5Ui9TYCQPTHmTE2f5YZqLDU+U7LWmU6PK4IPYJwIF+B9KFKzs2rIS24sEgIJ+nTi+JlxmQe62uAdJnK2Wtf5jPAPE+xleCbKGMxBm69S+RM73Mkfre2DdF1aQvREYC5kU2N+XN0deLERbGiTOcxuIS0rmmy5DqFu1oJcAa+t0p0Yu5ivd+2kpre3OR1QUzWn0m4fTdK7vxNDmpK7yd4PQeBnl7yVWt2+t26vyILdZa4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOeeRHtRSeCK389Gj6GWXEOKh4oNknOTXes+8asfevg=;
 b=k6Uj8F7XMUd0l00Z8RCbE8hd5/Yuk7OsSh9NNTAjl8UILzRC6YWoN1Cj1cUfgCVyJ6uSX1tab9QV4/wTAIyIcqLdeHh2WVw4i/QSbj4q9dEkGrJytK/VAJzNrPboS6w6pNkV0CUfJHQYy0Tahj6GXIndFGhGaKmbj2N4B9Sd8cWqn9C9yam+g+GTe67a+eLgIOwnTCp7W4I6XgR29KhcqDnqpVAG6ToZCzqPKz7OZNALNIe7FQJ4hjo6NjiClgYklpasBmYAbSrkJeSDVT28UC0aa7OjwoM+3j57gGs4wt3gJ0xujPF5tyKAs/PaF//+34QZn7+wrPoQCWBb/eEZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA1PR11MB9520.namprd11.prod.outlook.com (2603:10b6:208:59e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 23:46:45 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Tue, 18 Aug 2026
 23:46:45 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dedekind1@gmail.com" <dedekind1@gmail.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "tglx@kernel.org"
	<tglx@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Fang, Peter" <peter.fang@intel.com>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Topic: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Index: AQHdH1YE/ME7/hSMIEe/+GB5P8Iam7aFAbAAgBSEcgCAAQNDAIAAIM6AgAAKnQCAAAuxgIAAVwiAgAAC5QCAAAZ6gIAABW8AgAFP5gCAB+3uAIAANccA
Date: Tue, 18 Aug 2026 23:46:45 +0000
Message-ID: <a764973b285a3bda0c803432dab36e839ec30ac2.camel@intel.com>
References: <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
	 <anxvwV_Pz4UYaxxt@google.com>
	 <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
	 <anyiwqi9i0NSv0QW@google.com>
	 <ed4891a59096c59e43a893910c9f17d0ff6086b8.camel@intel.com>
	 <20260812223707.GD1013044@pedri>
	 <6191a69559e58e04c8e3f1efa776e9639796af3d.camel@intel.com>
	 <anz9b6CDkhr5D5RG@google.com>
	 <c697ff1d97fe62882eaf3bd86a4213bf2e79fc09.camel@intel.com>
	 <98dcc8a12f117745a1cb9981dc8f0f1548e9c96f.camel@gmail.com>
	 <aoTCmJXjQQbXRKqv@google.com>
In-Reply-To: <aoTCmJXjQQbXRKqv@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA1PR11MB9520:EE_
x-ms-office365-filtering-correlation-id: 5f1f7edf-de27-486c-4559-08defd82f636
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|22082099003|18002099003|38070700021|10067099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: dqrDtb4iqpRfg5FzZa0M0VCCylOMu6t4iyY4al2y1rrlTMoDxnxIxf2eghEfNJGIgpatFIDVSxtDFZTz9cT2mOTZxsSewsY6ARePALsD2S4aW6JkvT89YR901FWTxEUzc+pJvj5erZbImmfX310o4nR/q6Tun5tUe6x6kmRF88UWLsO6tKPayhe+jASFYG4kafjZR72dePYL98icJ90/vGBldG+E0nVy/mv1S1jZoYg5tyir6NSUVKmlQuy9K+fvLc8c5NgCi6bO0NOogrqFAECjsn5WhmWohLfyZzgnZSq1LRX6uMCd5oOl906KPEDfVUMZCAcgpnjaJCYJoVxf4kbCLzpYXb29qd1vYoc64U4RFmfhe2R/11Ji9fYsmY3qI+0Yv/Fec44aOK2BK+mx9JKlWT8hwslIokDky2LFFsL4Ye+LnaLC8WlPz+xQFOBgTpdT3bdCykNJgtOkAIAYAbyheLvSkl9dW1buUoj3VsY7XV5EDqD/LfPlZq1BCXrVvDYtFOA029fxA1DR5DxQY6YzDmaHezn/Wq8RpnHWgcMMFta7HzCZ65xRPuohyH4GIOkogDULInRXwFTpmSs1yqxVdhj/NyZXHZoFKtq6vpCCwyz+FJA8ijjNWaLsuFuyzul3yyOGUhBSzekv3XlE3gtRs/Mw/LKkzGv4rDuQrsRdMn3MEig1nBvUTOd2O4UBdTtC2ONvoLRqBrFK6u1ZQX6fxVrLy1rWOUPU5ymCT6k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFZWRWtKK01GUnl2ZFdxcjE5SjQ4Rk55eHZ1OVcrOGZpM2hCd2NLNml3bkEv?=
 =?utf-8?B?ZEhRT3BrY21GSGpTUFFhWmJBZXdnUFZVYXlZc0M5b2U4NWs4OGdCR2N2Z2FT?=
 =?utf-8?B?QkxzTnZlc3pkRGgwd1hFMHFSOWlSc3h6dmw4MVE0STFyT1VXMnFyMnBrL2NZ?=
 =?utf-8?B?ck1jS2NFcVJMYk4zM054RmZCNnlDZVNibG8rb1hpLzhGc0RJRU4rY2pWMEVB?=
 =?utf-8?B?YSsvU3AxV2MwWlhEVDhSTzRRcjl0M3hqSkdJQ21DR2lOTS9ha0x3eFRBbkVZ?=
 =?utf-8?B?TWhWMUJSUnlTSC81bUp1Lzl2SFlITmoxV3o5ZURJbThqRGQ5a0JORTdwK1k5?=
 =?utf-8?B?V2x4VzNjQjY5RER5Qm1OMlBCK0hGM0Y3Zk5hTFA5ck1VQW15T1d0MEJkRVZw?=
 =?utf-8?B?MUVtazRUQU12blg0aWdjWTU1UzR3a3JtUU4xdUk4V0l6alVhY3Vad3RIcjF1?=
 =?utf-8?B?bFJOTVpJRkdGUFNJdUQ2dVRPdEdybC93UGtZbFAvMldrSTViS2MwNWVLVi9x?=
 =?utf-8?B?d3l4a2tVeUJiZXFFdUszUEF3Z0FpUjNab3paTHJXY1V5MElXNWNyWmVLWlF5?=
 =?utf-8?B?VUxwYUFtcTRjUzFMcnUwNEtmSEgzSlljVUpRaVJRZlkwVUxncXJJekJBaWhB?=
 =?utf-8?B?a1NRd0p1R0lkK0NhUy8xR0pqSDdoazlYdVk4RTdMUk1RUlBTTGlpTUZlY2pM?=
 =?utf-8?B?SUgvaUw0aTR6YlowMXorYWRyRzVLT0FDTEd4VzFPNER0U3NMRTJ2MEI1THdY?=
 =?utf-8?B?UkplajVvOFZTb2s3VksrZ2l5OTFKaXJpSWxpZXM1WkJaRVFOV3lTQ05ibjI0?=
 =?utf-8?B?b1VMb2ZlWTNHK241RFdYeVBENG4xcHpLUFU4OFZzMjdQYXdhYXUydFdPRW5J?=
 =?utf-8?B?anY3VnhlaXhmRlUyL3B0RmhLaG5IT1hsc0hWU0ljUHFOcDRVcDJZc2VaTER4?=
 =?utf-8?B?dlcrRmo3anpkdTFrZ3RHKzB2ZUpwN2dlV2xwR0hqV0JHK1BqVkpLVGplSTkz?=
 =?utf-8?B?RG9HL3g4UjdlTVBJd2ZiNk1CQmRNeVlFUWJFZVZ6eDY0SmRacUdkV3F4UEMy?=
 =?utf-8?B?UTBVSUFxd1NXczNlYlRDbWNrQnJKTVN5ZUtDTjJKNFM2cWh4WVFndzJ4NE1p?=
 =?utf-8?B?QW8wKzBNZVhud1NXT3pReXgycE1BdjRXRVdYejVvWVBPRm9wL1F5NWN3OExs?=
 =?utf-8?B?L2RVZi9jY3p1YU9xMWZCUkNpZkhFNGh0OXlEUHFtcllZSVRtMHIwMzR0Uk9v?=
 =?utf-8?B?cEVJZ1B6elR0WmswenpCZ24yRFM4dE9mZG9ZMzZ1SURyRWFldzcvU3prbzh0?=
 =?utf-8?B?b0FsdHdGamNuUFhOelV0Zk5YK3ZBQ3VGdjdnWHZmeGdnVVgrM0FpNE1lbmw2?=
 =?utf-8?B?ejgzcEc2aUJwZHp2L0dNZ3BXS1FRWnVHd3FmRHk2Wm5sR0M0RXhYQklCSkp1?=
 =?utf-8?B?Um8xYzNrU0Qvbld5VHlNQWQ2KzBPNlowNjhhMW1aMVlQQVY1WHlmTXZ0Tjkz?=
 =?utf-8?B?bEc2SGdYWUlGcW1kbnFIWXYxUy9zTmJSSVJ6NlBhdWZzejhOQ3ByOGdGbzY4?=
 =?utf-8?B?WVVUQUliNUdMRnlLT09SOEdhYzFBTE1TMmliWDNvNHFWVkxIRDdlL1RkWHRi?=
 =?utf-8?B?VkVUSFZmQ1dDbW9uSkwrb3NNWHQxK0JHeFRqRkN3Qk0rYTFXNlZQcm5XWUl0?=
 =?utf-8?B?UHJMdnM0QWErWW53enZuaXg2M2FyMmVqRjBGMStya015RmtZRldaWGFmWTZF?=
 =?utf-8?B?MjNQR0ZXRnRkNFB4NVJ3ZUhxR2hGbThacWhLY1VwK0s1MEVUdHR3VjhtZFNF?=
 =?utf-8?B?ejk1VHQ4VHNhMW5OUkdVZDIyV2ZydGJQMk5YQjBNOWRZOGJUUnJVcWUzN2JD?=
 =?utf-8?B?cWpSME1ySWUzQXVxOUJRZWVXODZQaGt5VWROQU5EdnBIeGRCYi9pQStud0dt?=
 =?utf-8?B?emN1OGVUZFFLNEo3akZCZTlkZEwySG5kZ2I5cVNTRXNYMElPWVI2aGNyeXJy?=
 =?utf-8?B?ZUxRVWo5NVlSVHdhWEo4TkVKK2IzR1N4ZGNJclB3WUpRVEhzenloQjlJUG1k?=
 =?utf-8?B?cXl4N2tCd0VVNXBsZDhMbXl2TmRIMHN1NTkrYWhobFZ1aU0vUVJrMjVlR000?=
 =?utf-8?B?akRhQXNBTWVtRTRoeFNFRGVISGhxL1BNQldSakFNT2QzOHdQZVBXZUFUanRP?=
 =?utf-8?B?WFRUNmNEalhIbGFzZ2hjWTRUSHBlL3hjTVdhbTcrT3B4aEh5Um12a2lRUlRH?=
 =?utf-8?B?WjJjS0ZTRnNzRFoyOElsbkVnZkhRbis2ZUJVYTJZVk1aM3lzMmFESnN1Tlh4?=
 =?utf-8?B?S2k5VVZwRHlsU0xOd21PY2hnVXYxZlRNdWpsU1VKOU1rTWpqS1dqRU1FcE5r?=
 =?utf-8?Q?++u1nfe/LBrkk1c8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F81922C96775B440B1B906CC92CA8D0C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: njLuS2xY5/vZoFQA+hllueoUK5lb4Vpiw2wbmBKQxOGZJgHfrNjYTbBthhVEckldXDfX1OYjo4kmwIp/UtItfEW6ZXQC6OapRQimZfTVNEK/oBa3ABhXbXtNAa9lGrBMXWGGLLs3DPP/nJVL6vgfX6QaFPfmZ9X8Kd6RnF3fQxPZJLgNyEK+GXkbCmwr94QSM37aFDPlKih2mq+oVwhvf+z3gIwcXEVVhOIjLSfWVkPMV+PeggsJS6gaCRxKpUNhL9ByS8mmIJfiIXbEWysHXeMDXUOGpW5snNU1a5/to7LFnH0y1KOJ4JHvFi0BbqwuTB42FKNG0rh2fSxZmmZkSw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1f7edf-de27-486c-4559-08defd82f636
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 23:46:45.0958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6AInK+nqJBVEvASxKyhD1+16EL5sGIQOcklx9Q5R0W/3MiDsj1bpjm1+MQrHAtlLL6kg1C6lxdhocsaax6Jax/qJiv7lsfifFvr29yGIY2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9520
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA4LTE4IGF0IDEzOjM3IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IDMuIFdoeSBmcmVlemluZyBURCByZXBvcnQgc2l6ZQ0KPiA+IA0KPiA+IExpbnV4
IHN1cHBvcnRzIDEwMjQtYnl0ZSBURCByZXBvcnRzIHZpYSB0aGUgYFREWF9DTURfR0VUX1JFUE9S
VDBgDQo+ID4gaW9jdGwuIEl0IGlzIGFscmVhZHkgZnVsbCwgbm8gbW9yZSBURCBldmlkZW5jZSBm
aXRzLCBhbmQgY2hhbmdpbmcgVEQNCj4gPiByZXBvcnQgc2l6ZSB3b3VsZCByZXF1aXJlIGEgbmV3
IGlvY3RsLg0KPiANCj4gU28gaW5zdGVhZCBvZiBhZGRpbmcgbmV3IHVBUEkgZm9yIHRoZSBndWVz
dCwgVERYIGFkZHMgbmV3IHVBUEkgdG8gS1ZNP8KgIFRoYXQncw0KPiBub3QgYSB2ZXJ5IGNvbXBl
bGxpbmcgYXJndW1lbnQuDQoNCkkgYWdyZWUgdGhpcyBpcyBhIHdlYWsgcG9pbnQuIFRoZSBmcmVl
emluZyBvZiB0aGUgVEQgcmVwb3J0IHNpemUgaXMgb25seSBhIHZlcnkNCm1pbm9yIGJlbmVmaXQg
dGhhdCByZXN1bHRzIGluIGxlc3MgZ3Vlc3QgY2hhbmdlcy4gSSB3YXMgdHJlYXRpbmcgaXQgYXMg
YSB0aWUNCmJyZWFrZXIgbGV2ZWwgdGhpbmcuDQoNClRoZSByZWFzb24gdG8gbm90IGRvIHRoZSBx
dW90ZSBhcyBhIFRERyBjYWxsIGlzIHRvIGxldCB0aGUgaG9zdCBjb250cm9sDQpjb250ZW50aW9u
IG9uIHRoZSBxdW90ZSByZXNvdXJjZSAoczNtLCBldGMpLiBBbmQgaWYgd2UgZXhpdCBvdXQgdG8g
dGhlIGhvc3QsDQphZGRpbmcgYSBob3N0IHVBUEkgKEtWTSBvciBub3QpIGxldHMgdXNlcnNwYWNl
IGRlY2lkZSB3aGljaCBxdW90ZXIgdG8gdXNlLiBBbmQNCmtlZXBzIHRoZSBxdW90ZSBleGl0IHdv
cmtpbmcgYXMgYmVmb3JlLg0KDQpKdXN0IHdhbnQgdG8gY2FsbCB5b3VyIGF0dGVudGlvbiB0byBz
b21lIGRpc2N1c3Npb24gb24gaG93IGZhciB3ZSBtaWdodCB3YW50IHRvDQp0YWtlIHRoaXMgImtp
Y2sgb3V0IHRvIGhhdmUgdGhlIGhvc3QgbWFuYWdlIGNvbnRlbnRpb24iIHBhdHRlcm4sIGlmIHdl
IHdhbnQgdG8NCnJlc29sdmUgb3RoZXIgZ3Vlc3QgbG9ja2luZyBoZWFkYWNoZXM6DQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9rdm0vMGI1YTI2NDkyZjM2N2Y3OTNhYWIzOGU0YTBkOWQ2ZjM5ODM0
MGY1MS5jYW1lbEBpbnRlbC5jb20vDQoNCg0Kc25pcA0KDQo+ID4gVGhlcmVmb3JlLCBmb3IgRElD
RS1iYXNlZCBhdHRlc3RhdGlvbiB0aGUgVERYIG1vZHVsZSBhZGRzIG5ldyBURA0KPiA+IGV2aWRl
bmNlIGluIHRoZSBxdW90ZSBpbnN0ZWFkIG9mIGV4cGFuZGluZyB0aGUgVEQgcmVwb3J0Lg0KPiA+
IA0KPiA+IElzIHRoaXMgdGhlIGNsZWFuZXN0IGFwcHJvYWNoPyBNYXliZSBub3QuIEEgY2xlYXIg
c2VwYXJhdGlvbiBvZg0KPiA+IGNvbmNlcm4sIHdpdGggVEQgZXZpZGVuY2UgaW4gdGhlIHJlcG9y
dCBhbmQgdGhlIHF1b3RlIG9ubHkgYWRkaW5nDQo+ID4gc2lnbmF0dXJlIGFuZCB0cnVzdCBtYXRl
cmlhbCwgZG9lcyBmZWVsIGNsZWFuZXIuDQo+ID4gDQo+ID4gQnV0IG9uIHRoZSBvdGhlciBoYW5k
Og0KPiA+IMKgIC0gVGhlIHF1b3RlIGl0c2VsZiBpcyBhbHJlYWR5IGEgcGVyLVREIGRhdGEgc3Ry
dWN0dXJlDQo+ID4gwqAgLSBUaGUgaXQgaXMgaW5oZXJlbnRseSB2YXJpYWJsZSBzaXplIGJlY2F1
c2UgaXQgY29udGFpbnMNCj4gPiDCoMKgwqAgY3J5cHRvZ3JhcGhpY8KgbWF0ZXJpYWwgYW5kIHRy
dXN0IGRhdGENCj4gPiDCoCAtIEEgZml4ZWQtc2l6ZSBURCByZXBvcnQgbWVhbnMgdGhhdCBhdCBs
ZWFzdCBvbmUgb2YgdGhlbSBpcyBmaXhlZA0KPiA+IMKgwqDCoCBzaXplLCBub3QgYm90aC4NCj4g
DQo+IFRha2luZyB0aGlzIGFyZ3VtZW50IGEgc3RlcCBmdXJ0aGVyLCB3aHkgZXZlbiBoYXZlIGEg
VEQgcmVwb3J0P8KgIElmIERJQ0UtYmFzZWQNCj4gYXR0ZXN0YXRpb24gY2FuICJhZGQgZXZpZGVu
Y2UiIGF0IHF1b3RlLXRpbWUsIHRoZW4ganVzdCB0aHJvdyBhd2F5IHRoZQ0KPiBzZXBhcmF0ZSBy
ZXBvcnQgZW50aXJlbHkuDQoNCkkgdGhpbmsgdGhlIGZvbGtzIGluIHRoaXMgdGhyZWFkIGhhdmUg
Y29udmVyZ2VkIG9uIHRoYXQgaWYgeW91IGRpZCB0aGUgd2hvbGUNCnRoaW5nIG92ZXIgd2l0aG91
dCBTR1gsIHlvdSBkb24ndCBuZWVkIGEgcmVwb3J0LiBCdXQgeW91IGRvIHN0aWxsIG5lZWQgdG8g
cGFzcw0Kc29tZXRoaW5nIGZyb20gdGhlIGd1ZXN0IHRvIHRoZSBxdW90ZXIgc28gdGhhdCB0aGUg
Z3Vlc3QgY2FuIGtub3cgdGhhdCB0aGUNCmdlbmVyYXRlZCBxdW90ZSBpdCBnZXRzIGJhY2sgaXMg
Zm9yIGl0c2VsZiBhbmQgbm90IHNvbWUgb3RoZXIgVEQuIChPciBzb21lIG90aGVyDQpleHRyYSBn
dWVzdCBjYWxsIHRvIGNoZWNrIHRoZSBxdW90ZSBhZnRlciB5b3UgZ2V0IGl0IEkgZ3Vlc3MpIEEg
bm9uY2Ugb25seQ0KInJlcG9ydCIgaXMganVzdCBsaWtlIHRoZSByZXBvcnQgaW4gdGhhdCBpdCBp
cyBzb21lIGJ5dGVzIG9mIGRhdGEgdGhhdCB0aGUgZ3Vlc3QNCmRvZXNuJ3QgbG9vayBhdCwgYnV0
IGp1c3Qgd2l0aG91dCB0aGUgVEQgZGV0YWlscyBpbiBpdC7CoA0KDQpTbyBnaXZlbiB0aGF0IHdl
IGhhdmUgU0dYIGxlZ2FjeSBzdHVmZiwgbGVhdmluZyB0aGUgcmVwb3J0IGFsb25lIGFuZCBoYXZp
bmcgYSBURA0Kc2NvcGVkIHF1b3RlIChLVk0gYmFzZWQgQVBJKSBpcyBxdWl0ZSBzaW1pbGFyIHRv
IHRocm93aW5nIHRoZSByZXBvcnQgYXdheS4gSWYNCnlvdSB0b3RhbGx5IHVuc3VwcG9ydGVkIHRo
ZSBhYmlsaXR5IHRvIGRvIFNHWCBhdHRlc3RhdGlvbiwgdGhlbiB5b3Ugd291bGQgb25seQ0KZW5k
IHVwIHdpdGggYSBzbWFsbGVyIGJsb2IgdG8gcGFzcyBvdXQgaW5zdGVhZCBvZiBhIDFLQiBibG9i
LiBJbiB0aGUgZW5kIGl0J3MNCm5vdCBhIGh1Z2UgZGlmZmVyZW5jZSwgc28gbWlnaHQgYXMgd2Vs
bCBsZWF2ZSBpdCBhYmxlIHRvIHdvcmsgd2l0aCBTR1gNCmF0dGVzdGF0aW9uLg0KDQpCdXQgaG93
IGNhbiB3ZSBjbG9zZSB0aGlzLCBhdCB0aGlzIHBvaW50PyBUaGlzIGlzIGFsbCBiZWluZyBoYXNo
ZWQgb3V0IG9uIHRoZQ0KbGlzdCBub3csIGJ1dCB0aGUgaGFzaGluZyBvdXQgaXMgbG9uZyBhbmQg
c2NhdHRlcmVkLiBJdCBtYXkgYmUgaW5lZmZpY2llbnQgZm9yDQp5b3UgdG8gZXh0cmFjdCB0aGUg
bWluaW11bSBjcml0aWNhbCBwb2ludHMgdG8gZGVjaWRlLiBXZSBjb3VsZCBkbyBhIG1vcmUNCmNv
bmRlbnNlZCB3cml0ZXVwIGZvciB5b3UgYW5kIFBhb2xvIHRvIHJldmlldz8NCg0KIA0K
