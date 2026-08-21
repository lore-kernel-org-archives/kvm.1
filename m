Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BCE39CCFC;
	Fri, 21 Aug 2026 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345646; cv=fail; b=jYgESvsZ5SDJGpE3s7Y/dHM4Hv40AuXT7vZiQ6FpDlkKGwTZL6NGR0GKiRrAvy3qqQOEsr1U56jIBZgMiCaXlLPHkMRJK9cZf6QU/ECk9rIjUTjFQOMFnDjV6Khkybbx2yUSE1J6elGyNbf+bZb/dBZxYPRGeBBaiuo8BsX0Sbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345646; c=relaxed/simple;
	bh=ybQx0VelYrEI7f8uPvXx5njbPe2tw0mjWmJ9VirxJkk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jik0foJSiGcFTAqoOOLfzuKBj4Z2wwT/N4A8P8UURjsi/OyIB0gQwoZs2cyEc94KdeFf8jggjacKTd9VTmONLeB9bQHyzlbczhwRrGZh5m8VSRBF5t5i/PouuNBK3WvsCKfQW4VYCaGhh0HpgCfGFIjum125UCbIo8HrwHt6QMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DkZG53L7; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DkZG53L7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787345643; x=1818881643;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ybQx0VelYrEI7f8uPvXx5njbPe2tw0mjWmJ9VirxJkk=;
  b=DkZG53L7YJ+56hg72wrGrvRZas9eccz/PIu7TuY3YwTOuPzNXNTEMh0W
   O+7AciTuscMc91hUePov21AjGSJ3mNVvu/ffIa5vktc8XwZ5I01LA5VpP
   iDfN66ucrBXWyLbg6x7skkM2vQ0aQrsMGs3oZXv8WagiLCRxIqjyAsLBB
   sKx+jBLFFjPd6MOHsXH9EOllyyvvYPE02Cg/rr4fkjNFP7uN24j4+PeSl
   auErC3GSXuoMgBn/giZPaF1yA+UFyM3TBXSiaHvEZgs4hqq/bRW9Jud3Z
   If3ECV/kIClkiQ2SRSuRJIHKxVmCrrz5rs33vY7gTcNX2ntojckl1RAbc
   Q==;
X-CSE-ConnectionGUID: igpAdGzRQiGNoMOWu5/GAQ==
X-CSE-MsgGUID: 5Nt2+eiPT8epuSKEICX+RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="90415844"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="90415844"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 13:54:01 -0700
X-CSE-ConnectionGUID: HuON56+0Q/eoOEQ+EgeVLw==
X-CSE-MsgGUID: DaDuUKQwRnyyY9BcfTI9kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="262725185"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 13:54:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 13:54:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 13:54:00 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.34) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 13:54:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZttJcNPb+qzv78jMwdQ0QLWSYbNTJ+PysBnPGqboy19LHQBxCQAt0Mg7hoTpsh944NbKFqTDRFwwMnsV1I4/1ov5BrStXzLDTFhdI1DHdvvBXD6hitBmSCDhJ45HMd4joh6Ts7pi+BrZRp2qPoyXp05U9cEBkEXpZTN58vhEWOxNkeEya7W1E1ls57v9wbsHG3+EmdjgFJ+XEv/Hj/IBfNm7eRCEzw7t8/hH1z8WgQitiR9vgCsTrwmoZo8x/QIoRavPTz6NetIE0moCxvTpgHy7C6wIkP7v1CizLp4PqwQkw6qPhvY0+F3QfBbjdYeVluAnACqIao/GJEo9rVgbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybQx0VelYrEI7f8uPvXx5njbPe2tw0mjWmJ9VirxJkk=;
 b=LehNKfYSKtIbzZG+RZ3l69dGTU82gRZL+j5ysHUqXseApsBnu+iV9scHcQe2cuCG+WbGgIX9dlgkKrmNnRJb63sqwldt1wRA6YiwXRT3mcm/7YlUbJCj/Zh0wbbezVAYxhjWbu8NOVrOjYuvNS3PpvavKA1d7e7mc2hXa2z2neT6wMV5d6fJKMjws4SRZttDkumINX4WmW0JDtyyQK4yTBwQdD6TT9byxKbso9qewCg6b8HA2XaOnRoO5d/D6Ol9DwTpmCyJqVRJndC0PCvZbxdDge2JFw7vqU72XccZMuo0fj8GT3Xp3ufSvQH4dDH2bRiw0XOhBsT8MytMO28lbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by PH7PR11MB7987.namprd11.prod.outlook.com (2603:10b6:510:242::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 20:53:57 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%6]) with mapi id 15.21.0315.012; Fri, 21 Aug 2026
 20:53:57 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Maloor, Kishen" <kishen.maloor@intel.com>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH 1/6] x86/virt/tdx: Wrap TDH.SYS.CONFIG/UPDATE operations
 in helpers
Thread-Topic: [PATCH 1/6] x86/virt/tdx: Wrap TDH.SYS.CONFIG/UPDATE operations
 in helpers
Thread-Index: AQHdMR1MqW1dX0WSCUCflaPWcj2XSrao/CIA
Date: Fri, 21 Aug 2026 20:53:57 +0000
Message-ID: <8fa5f9faf6ad6d432dcc2cf12f5bff03c17147a9.camel@intel.com>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
	 <20260821032920.256225-2-yilun.xu@linux.intel.com>
In-Reply-To: <20260821032920.256225-2-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|PH7PR11MB7987:EE_
x-ms-office365-filtering-correlation-id: 8119f66c-4b27-448a-d986-08deffc651f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: hGrt4gJlCAiDkYYBeX4nHTEOZkRyN8AuJX8UrwGH8mdEqaEjWL8+pq9qY8UgdpS4KPY/AVc5mtVW79Y9Zgue5OarVv56d+BvrFgYuIdOWIJiwybyCuPs0Hjo4Y2OllA2T97y6DBVRMXHFSdQ4dmH9HkwXL5c7NBw9S5sKAUb9qwd9/AfAcQV3axgzGxfUOmSLC3PznFPy8pkDO17gzrrphaz8kRQAXm23oGRS4dFn/Evm9vBHgWQqFv7FQPH+BoY5u/u7rTOL3jXxI/QFUYMfgP1EfBeDf6Ij2c9QoTfJB6GjjaaCRp/fI5X/QYrBg4ifgoE9W3zA/R5Axchf9x7uULjzThrnPnjWWoX2sjZWpztxJEk/G6O0lJ8GvCq0fdtSZBNOPGQJNz87ssuLGw1+MWf0Tpru0/YPJ0eRtDrVFUxY43rO5imeaSPLgQzdS+Hyi3plTDrpjYkqMFrvMVCo14zyE/KYzbhle48dIcqnBcjSephjQvpJlvwDuULVXoUQsL3gXQr2UzxlhrO5yNbZkB337FPweKLwUMja97W0aQ+8+9XsJL7G3DI1Ysak2sAlHfLBWJybJE4+CYc10u+gN4CZmIDSUoo/Sof0Vee2oQhs5hLs7F8vAVMajfSFbSzbR1Fi4hPsT9Q9NNV8gU5iLYflOnB+pyx/7UszgMS6+M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm83RldPTllyUzlDTEV6OXkrb0krVkdJamFnQ3FFVzdnS0xqNlV6eXB0UEdj?=
 =?utf-8?B?aW1XR3lCdlNRYnp1NGxia05wdExQbno4RWdYaHpiNE5ZMDMzcytGeUhCRm5X?=
 =?utf-8?B?RjYzVm9pV2xGU2FRNDE4L3hubHJockk2eVRzeXNZZ2Zoa0t3Rms1TjlXbHhK?=
 =?utf-8?B?aXZpaGRlbG4vSUkwODFhd1U1NUg2Q3ZJRnVlVUZlNlNSNEpIQ2VaT1VvbkdK?=
 =?utf-8?B?a21FZGppdGFWaUNrbDNLTG9xOVlzU1huTU0rSUpVNFZTc3R5aHU4ZXl4aklL?=
 =?utf-8?B?RzNNcHk4aXN6dEI1VjliQkdtalN0VUozRjFLNXREQVAxN2tzNmh3M3I3c2hu?=
 =?utf-8?B?SUNWM09Zd1pzNW9LYmtqWEF0VTZ4bkp2bVZMeXZiblZ4c1Zob1J0MlZGWXlv?=
 =?utf-8?B?bzA4M2VBNEVSd3VyY0xTMmNYN0drOVNueUliQUdpNGFhNWdtOS9obmVkYXRt?=
 =?utf-8?B?Y0tQSW1WSkhMemgraWNWMlgwdktOaVloSWdVVnBoOFVhYVMwOHhQQnBoMDRS?=
 =?utf-8?B?OGczaWZrWG1BUSt5d1BmL212WWcyRmpSUEV1N3JEWFcrU0tzeXgrb1JVeDJJ?=
 =?utf-8?B?MlZkdm9MdFpPVWprK05HWk5QWUFhRVZPc051Z05UWGlXK1B3RW5CZ3ZpVERl?=
 =?utf-8?B?OUpCdWpYb2phNkFFRTYxM0hVditaSGZLT2R6ODd4VHRqTzdUTnVVL3J3WjRx?=
 =?utf-8?B?MnFNYUpFVGwrVnZJUlVFUFRRcEI4eUdsWkRGOHhTTjhhREdSY1ZTdFFPdHpN?=
 =?utf-8?B?VnplQWhmUmJySmNNZkJ0TjZzSk1jbDVLS1FZVDRVaThsb2ZLZkRxeDQ3YVY0?=
 =?utf-8?B?NzRicnZTLzJjYTN3aU5YQUhRWG5KNDBlVjRaK2x4eTZud2gyUEQxWi9VWDdW?=
 =?utf-8?B?bjViNEFaeFYxS1Z1R3FYZW1nZUdMeVpzcklkL3gyWFJIeXVTbitEdjZ0bXVV?=
 =?utf-8?B?aTAxZGJLNWxNVkZXQzU0Wk9pYWJQU0FGTFZHUnBScFBwV201TGxJcmloOEw0?=
 =?utf-8?B?c1I4bG96NUxqZlNPYVRHMHRIRVhWSThBMkZ2NVZMRktrTmkwQU5EdU81dVgz?=
 =?utf-8?B?RlA3MzMzd3pGdFY3bnB2K1d1MmJ3cmhwbWx4SFNRVlRqd2hzc0EwN3RPZDZK?=
 =?utf-8?B?Z2FUQUhiUEJuak5namFNOUEyWm1HT0xPM0MvUE5tbjEwcFZQU3llWUQvdndU?=
 =?utf-8?B?cDVKOHVVdmdxUFMybXNSclVUSC9tVUl4ZTYxU1J5Smt1TU11OE50eTU4NjBu?=
 =?utf-8?B?QmxsQ2dwMENPWVoxbjByV1dQV3hFMkY3WHRMRmNMZ1hHQk1MWUp0M3d6YVFP?=
 =?utf-8?B?NXFFcWtUTXNsYlM1S1g1L3VVem4vZTVQVDVTRHVMTWdhMjlpVXRHRkMxYkNS?=
 =?utf-8?B?RjREOXVoc1h4S2UxdnN2T2xwemgxVmpLVGMvbTdSL1U1L2lZVGRwQ3p3QVc3?=
 =?utf-8?B?aEQ4bkFXbFQwVWZFdEJsK1ZaVXpqcW9wQ25odS8wMlBwMEs1UnhhV3NIajdP?=
 =?utf-8?B?V0hqR09TNk5nby9KMkxvTGQxVWlCWkRNSWNxNnlOL1g2emdXcUNEOXNHL2dr?=
 =?utf-8?B?VDdVUDUxVi9JNWdudU5ld1pINEdkR2pvSlI0WnRhdkdhOFBlcnM3NURWVmtI?=
 =?utf-8?B?RHdXL0hqRWRxMUpxakdVbXlRMUFLZHFObEFRQnVjbW5lQmY2Z3JVOVFnOFJT?=
 =?utf-8?B?RUVYdzZKcmR4SWpDeUNQUjRRQjJYVmZnOXQ0M1FXQmNaWS9BRjVBQXJSaU1i?=
 =?utf-8?B?S01Pbkp2UW1MbVJYRy9UZEEwY20rbmZXeEQrWVg0SG5GbVl6dm4yaFFTekxT?=
 =?utf-8?B?bFhrZTNSTEo3OC9yM2ZKaHhlK0g4OXVGeWpaSThvOTV4MkRBNytsWWZVLzBm?=
 =?utf-8?B?ZzVYc0JjS2NQSm1QL21UaHE1dFc1a050ODN3SW5RYU1GNXdpdkIyVDJOcFRk?=
 =?utf-8?B?RXZJMStxajJ5OHluL3VBTnlaSUQvTENOYXJrRUI3eC9aM3ZQZFVaT1RHaTZ3?=
 =?utf-8?B?NXlMUXRCYStzUTJQSVpXZDE2L1NmbHVwaldxd2dMS3RESExxS2J5c1U4NE9Q?=
 =?utf-8?B?STV3ZTBRRFJCUTZ5bnd0MFJjTEpTdXcyeCtmK2NNeFJCN2I2a1RmRkVITU15?=
 =?utf-8?B?U0gxelVVQis5akxnbTIzNmJsWmFUWUJXZ29LcUltYjllc243QzZhYmQybURN?=
 =?utf-8?B?YWQ0eW1idmFJV0RrTnExYm1MTjdKWEU0cHVIYjBUalBJM24vT3g1ZkZUZlRt?=
 =?utf-8?B?TVY0bEQ2UWN5bjFlNUo1MjRKR2ZDZXNlbjQ1WGhJalMwd1AzYzg2cmZzRE5E?=
 =?utf-8?B?Q29tb2NlRitzUWJiVlY4cXRMOWJTN1ROeU5BYUw0Vk41b1RXREdxNG1WcWs1?=
 =?utf-8?Q?yfFigB1+d0stsCxE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA77EB8E11C84B46B9BE318F694E3BAF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UJHg71VqEBtUp1kI10Qg00xLkGL9Z7e0kRfBgrQbFV4qG8ndewzPGCvRgsZB6bziacslOc5tvXPFVKkkT6681+UHR33zIDnZqMdRQ2k5BK/ZqgTTGXl+gI3nfkadvQSfLbLYOk5hlCDI9bLQGaR279BHBWJmWeeHvA/RTcupPnkTTEEySGp1/i2nHcC0I6zl1WKdZZCX1WCOSep22wq4kaCH/XCP+ci3v42VGdgC5myMNduBdUK+qbE0L/iOAKaXdtH1MiRSU/suxZtYouEqE0e32ozvWD8sBrj5E3X8JO0cqaa1dFjoJVjIgJGxHlWK1X1EWtEiQJ0UOrjzs7WN7g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8119f66c-4b27-448a-d986-08deffc651f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 20:53:57.6428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYHISr4Zm4ezgy3utpuFznLt7EBgcy3UCjf3hWMnH55CH5LXxfs0OoEwrpSpgEYIP7fKvtrwTXlm2p8KitEGEUxLjxtOM0jCSc7sqHVztgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7987
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA4LTIxIGF0IDExOjI5ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gQXMg
cGFydCBvZiB0aGUgVERYIG1vZHVsZSBpbml0aWFsaXphdGlvbiwgdGhlIGtlcm5lbCBjb25maWd1
cmVzIHRoZSBURFgNCj4gbW9kdWxlIHdpdGggc2V2ZXJhbCBpbmZvcm1hdGlvbg0KPiANCg0KVGhl
IHRlbnNlIGlzIHdlaXJkIGhlcmUgYXJvdW5kICJzZXZlcmFsIGluZm9ybWF0aW9uIi4gU2hvdWxk
IGJlICJzZXZlcmFsIHBpZWNlcw0Kb2YgaW5mb3JtYXRpb24iLiBGb3IgY3VyaW9zaXR5IHNha2Us
IEkgbG9va2VkIGl0IHVwIGFuZCBmb3VuZCBhIG5ldy10by1tZQ0KbGluZ3Vpc3RpYyB0ZXJtOg0K
aHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvTWFzc19ub3VuDQoNCj4gLCBzdWNoIGFzIFRE
WC11c2FibGUgbWVtb3J5IHJlZ2lvbnMNCj4gKFRETVJzKSBhbmQgdGhlIGdsb2JhbCBLZXlJRCBm
b3IgcHJvdGVjdGluZyBURFggbWV0YWRhdGEuIER1cmluZyB0aGUNCj4gY29uZmlndXJhdGlvbiwg
dGhlIGtlcm5lbCBkb2VzIDIgb3BlcmF0aW9uczogY29uc3RydWN0aW5nIGtlcm5lbCBkYXRhDQo+
IHR5cGVzIGZvciB0aGUgU0VBTUNBTEwgbGVhZiBhcmd1bWVudHMgYW5kIHR1cm5pbmcgdGhlc2Ug
ZGF0YSB0eXBlcyBpbnRvDQo+IHU2NCdzIGFjY29yZGluZyB0byBURFggQUJJLg0KDQpXaGF0IGRv
IHlvdSBtZWFuIGJ5ICJjb25zdHJ1Y3Rpbmcga2VybmVsIGRhdGEgdHlwZXMgZm9yIHRoZSBTRUFN
Q0FMTCBsZWFmDQphcmd1bWVudHMiPyBZb3UgYXJlIHNwbGl0dGluZyB0aGUgY2FsY3VsYXRpb24g
b2YgdGhlIHBhIHZpYSBvZmZzZXQgZnJvbSBzZXR0aW5nDQppdCBpbiBhIHU2ND8gSWYgdGhhdCBp
cyB3aGF0IHlvdSBhcmUgc2F5aW5nLCBpdCBtYWtlcyBpdCBzZWVtIGxpa2UgYSBtdWNoIGJpZ2dl
cg0Kc2V0IG9mIHdvcmsuDQoNCj4gDQo+IEJvdGggb3BlcmF0aW9ucyBhcmUgaW1wbGVtZW50ZWQg
aW4gb25lIGZ1bmN0aW9uIC0gY29uZmlnX3RkeF9tb2R1bGUoKS4NCg0KV2VsbCBJIGd1ZXNzIG15
IGd1ZXNzIGFib3ZlIHdhcyB3cm9uZywgYmVjYXVzZSB0aGUgY29uc3RydWN0aW9uIG9mIHRoZSBw
YSBrZXJuZWwNCmRhdGEgdHlwZSBoYXBwZW5zIGluIHRkbXJfZW50cnkoKQ0KDQo+IFRoaXMgYmx1
cnMgdGhlIGJvdW5kYXJ5IGJldHdlZW4ga2VybmVsIG1hbmFnZWQgc3RydWN0dXJlcyBhbmQgVERY
IEFCSQ0KPiBkZWZpbml0aW9ucy4NCj4gDQoNCkluIHRoZSBjb2RlIGFmdGVyIHRoaXMgcGF0Y2gg
aXQgaXMgc3RpbGwgc2V0dGluZyBhIHU2NCBpbiBjb25maWdfdGR4X21vZHVsZSgpLi4uDQpzbyB3
aGF0IGlzIHJlYWxseSBjaGFuZ2VkIHdpdGggcmVzcGVjdCB0byB0aGlzPw0KDQo+ICBNb3Jlb3Zl
ciwgZnV0dXJlIGtlcm5lbCBjaGFuZ2Ugd2lsbCBuZWVkIHRvIGFkZCBtb3JlDQo+IG51YW5jZXMg
bWFuZGF0ZWQgYnkgVERYIEFCSSwgc3VjaCBhcyBzZXR0aW5nIHRoZSBUREguU1lTLkNPTkZJRyBs
ZWFmDQo+IHZlcnNpb24gdG8gYWxsb3cgY29uZmlndXJpbmcgYWRkLW9uIGZlYXR1cmVzLiBLZWVw
aW5nIHRoZXNlIG9wZXJhdGlvbnMNCj4gdGFuZ2xlZCB3b3VsZCBmdXJ0aGVyIGNsdXR0ZXIgdGhl
IGNvZGUuDQoNClRoaXMgc2VlbXMgbGlrZSBhIHN0cm9uZ2VyIHJlYXNvbiB0byBtZS4NCg0KPiAN
Cj4gSnVzdCBsaWtlIG90aGVyIFNFQU1DQUxMIGxlYWYgaGVscGVycywgd3JhcCB0aGUgaW52b2Nh
dGlvbiBvZg0KPiBUREguU1lTLkNPTkZJRyBpbiBhIGhlbHBlci4gSW50cm9kdWNlIGEgbW9yZSBk
ZXNjcmlwdGl2ZSBrZXJuZWwgZGF0YQ0KPiB0eXBlIGZvciB0aGUgcGh5c2ljYWwgYWRkcmVzcyBh
cnJheSBvZiBURE1SIGluZm9ybWF0aW9uLiBUaGlzIGRhdGEgdHlwZQ0KPiBpcyBzaW1pbGFyIHRv
IHN0cnVjdCBzZWFtbGRyX3BhcmFtcyBpbiB0aGF0IGl0IGlzIHRoZSBjb250YWluZXIgb2YgdGhl
DQo+IFBBIGFycmF5IGxheW91dCB3aGljaCBpcyBhbiBpbi1tZW1vcnkgQUJJLiBTbyB0aGUgcHJl
dmlvdXMgdTY0ICogdHlwZQ0KPiBmb3IgdGhlIGFycmF5IGlzIG5vdCB3cm9uZywgYnV0IGEgbmFt
ZWQgc3RydWN0dXJlIHByb3ZpZGVzIGJldHRlciB0eXBlDQo+IHNhZmV0eSBhbmQgc2VsZi1kb2N1
bWVudGF0aW9uLiBVc2UgdGhlIGRhdGEgdHlwZSBhcyB0aGUgYXJndW1lbnQgb2YgdGhlDQo+IFRE
SC5TWVMuQ09ORklHIGhlbHBlci4NCj4gDQo+IEZ1dHVyZSBrZXJuZWwgY2hhbmdlIHdpbGwgYWxz
byBuZWVkIHRvIHNldCB0aGUgVERILlNZUy5VUERBVEUgbGVhZg0KPiB2ZXJzaW9uIGZvciB0aGUg
c2FtZSBwdXJwb3NlLiBBZGQgYSBzaW1pbGFyIGhlbHBlciB0byBwcmVwYXJlIGZvciB0aGUNCj4g
Y2hhbmdlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWHUgWWlsdW4gPHlpbHVuLnh1QGxpbnV4Lmlu
dGVsLmNvbT4NCg0KVGhlIGNoYW5nZSBsb29rcyBnb29kIHRvIG1lLCBidXQgSSdtIHdvbmRlcmlu
ZyBpZiBpdCB3aWxsIG5lZWQgYSBiZXR0ZXINCmp1c3RpZmljYXRpb24uIEhvdyBhYm91dCBzb21l
dGhpbmcgdGhhdCBoaXRzIHRoZXNlIHBvaW50czoNCg0KICAgV2UgaGF2ZSBTRUFNQ0FMTCB3cmFw
cGVycyBtYWlubHkgdG8gbm90IGV4cG9zZSBicm9hZCBzZWFtY2FsbCBhY2Nlc3MsIGJ5DQogICBl
eHBvcnRpbmcgb25seSBhIHNlbGVjdGlvbiBvZiBzZWFtY2FsbHMsIGJ1dCBhbHNvIHRvIGFic3Ry
YWN0IHRoZSBzZWFtY2FsbA0KICAgcmVnaXN0ZXIgQUJJcy4gVGhlIGxhdHRlciBpbXByb3ZlcyBy
ZWFkYWJpbGl0eSBhbmQgcmUtdXNlIGZvciBzZWFtY2FsbHMgdGhhdA0KICAgYXJlIG1hZGUgbXVs
dGlwbGUgdGltZXMuDQogICANCiAgIFNvbWUgc2VhbWNhbGxzIGxlYWZzIGFyZSBub3QgZXhwbGlj
aXRseSB3cmFwcGVkIGJlY2F1c2UgdGhlIGxldmVsIG9mIFREWCBBQkkNCiAgIGRldGFpbHMgbmVl
ZGVkIHRvIHBlcmZvcm0gdGhlIGNhbGwgaXMgbG93IGVub3VnaCB0aGF0IGl0IGNhbiBmbG93IHdl
bGwgZW5vdWdoDQogICB3aXRoIHRoZSBjYWxsaW5nIGNvZGUuIA0KICAgDQogICBGb3Igc29tZSBv
ZiB0aGUgY3VycmVudGx5IHVud3JhcHBlZCBzZWFtY2FsbCBsZWFmcywgZnV0dXJlIGNoYW5nZXMg
d2lsbCBhZGQNCiAgIHNlYW1jYWxsIHZlcnNpb24gc2VsZWN0aW9uIHRoYXQgd2lsbCBhZGp1c3Qg
dGhlIEFCSSBkZXBlbmRpbmcgb24gVERYIG1vZHVsZQ0KICAgdmVyc2lvbiBzdXBwb3J0LiBUaGlz
IHdpbGwgcmVzdWx0IGluIG1vcmUgQUJJIGRldGFpbHMgdG8gc3Vycm91bmRpbmcgY2FsbGVyDQog
ICBjb2RlIGFuZCBkZWNyZWFzZSByZWFkYWJpbGl0eSBvZiB0aGUgb3RoZXIgbG9naWMuIFRvIGNv
bnRhaW4gdGhpcywgd3JhcCB0aGUNCiAgIGZ1bmN0aW9ucyB0aGF0IHdpbGwgZ2V0IHZlcnNpb24g
c2VsZWN0aW9ucyBpbiBzZWFtY2FsbCB3cmFwcGVycy4NCiAgIA0KICAgVGhlIGNsZWFuZXN0IHNl
cGFyYXRpb24gd291bGQgYmUgdG8gaGF2ZSBrZXJuZWwgZGF0YSB0eXBlcyBmb3IgdGhlIHNlYW1j
YWxsDQogICB3cmFwcGVyIGFyZ3MsIGFuZCBoYXZlIHRoZW0gbWFyc2hhbGVkIGludG8gU0VBTUNB
TEwgQUJJIHR5cGVzIChvZnRlbiB1NjRzKQ0KICAgaW5zaWRlIHRoZSB3cmFwcGVycy4gQnV0IHRv
IGF2b2lkIGR1cGxpY2F0aW5nIGFsbG9jYXRpb25zIGFuZCBjb3BpZXMsIGRvbid0DQogICBkbyB0
aGlzIHdoZW4gY3JlYXRpbmcgdGhlIHdyYXBwZXIgZm9yIFRESC5TWVMuQ09ORklHLiBJbnN0ZWFk
IGNsYXJpZnkgdGhhdA0KICAgdGhlIHU2NCdzIGluIHRoZSBhcnJheSBwYXNzZWQgYXJlIHBhJ3Mg
d2l0aCBleHBsaWNpdCBuYW1pbmcgb2YgdGhlIGhlbHBlcg0KICAgc3RydWN0Lg0KICAgDQoNCkl0
J3MgYSBiaXQgcm91Z2gsIGJ1dCBhcyBhIGdlbmVyYWwgYXJndW1lbnQgZm9yIHRoZSBjaGFuZ2Us
IGRvZXMgaXQgc2VlbSBiZXR0ZXI/DQoNCg0KDQo=
