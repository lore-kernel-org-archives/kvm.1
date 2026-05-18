Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D754379EF6
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104152; cv=fail; b=bGQjaKpDQJYCkB6fBTMsGU6t1Y18vdZjUDNDvHjcemgIRfWk2Yy38H7DcVkyXeIdKpj6KZqqTH5M0h6g6BDNfwAevDzwqggncD7VnwQ0ssSvbWaN0y/n/Br5Ajuv3lfdwTruHdRY5uii/jKqI/+l5CtQxhj7LBPI0tZNx+djyhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104152; c=relaxed/simple;
	bh=fIP289SlBh/U6Iyn8mK4uBbS1WeENU4vr+++KcaOpuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e4dM/4M0zz9pXlMVBwbkM2Ro10k6alJ79CnoHLD7LDfmYxHDKih2erzRnNhnYlaaGUnnyU2RUgbJ1p0RsYzCCqbpS48Lt7vRwnSM+9Byn+gNLcRKrcGi+Z5cZkX/y8Jm/uHWVF2kjNFgbyurZIOl0GlMlPndTEfNG+X1j/xEJ18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Me/mK5gi; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Me/mK5gi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779104151; x=1810640151;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fIP289SlBh/U6Iyn8mK4uBbS1WeENU4vr+++KcaOpuc=;
  b=Me/mK5gij6WxJUbvf30XrVswaigja37iyANTs5mWNqq6XjwfFm/SlHbR
   fp5JO++L/hGBXKoEKqlEeFrtFwrdWb0wzBnuHK4D6vqtAZCzqEuD2eVPO
   t/GXCfponE6/xRJvR+E/YwuAmeaUym2Wp/yvN6UwNEMF9jQgJyT0DKCdL
   sgYnfmDbTEKeHyrvYp0oEdVIjeJH7EcqP8JeW6uZYzWMLLdKLqS/Jacoo
   StVKNa9V8WCQyQRyGYSadbqIdUMWiCWY82I/HRu09i6cqKkNvPT/ELXcW
   BudYYCA7+GD5MjwPd+LRIeEL/Ann3K1gPDVZXj/89NO9M4UBQmipqmvCg
   A==;
X-CSE-ConnectionGUID: M0x/SaNGSRa7f9eII9hP5g==
X-CSE-MsgGUID: s2hHBOEAS9mER1CEphQBjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79853593"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79853593"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 04:35:51 -0700
X-CSE-ConnectionGUID: hUsfucwzQwSkCZa4oVtrcg==
X-CSE-MsgGUID: teM5AqyYSfWMoXVsLgwbOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="262920103"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 04:35:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 04:35:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 04:35:49 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.30)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 04:35:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZX2Px13VbxgG3dIhhDJJbrL2iuTlLlevBwOtGqB8xWndNN8sr5F8vzYpu6hkYMu76FEhrUj0Hv3mXttVhhNQd5V3ECamAaDcI3sisQYTqO5+6lAIp+2PBE2TWPJnI72qMrWGoitrk9A9DBp39RuotaAiMhQuDLbvIHFGEeTbaxEM5bH+s8s/MvQ55vEXvRAI2GJSKD/EoBac+5ewSKoyNKNo9yPMpyrepFoD5iuJh4BpH/nGQ7IieC0lSOs7vkx6cLgPcV/r+QCF6emhIBTCV6tXJBkAfeY+b0DoN4jDmtA3AHazW3UIFi+64GzZnYZSiCoupcaLID9gznj/Sku2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIP289SlBh/U6Iyn8mK4uBbS1WeENU4vr+++KcaOpuc=;
 b=LIEIoRATsZgeSn6B5Jb9E0v7Yybb3PqA66EbO54gN519GvmtilAocClMARrSeQPSE/S0tgUOxK7tNvq063DyGTIezwerSZiKOTvj8+s/xOsV/F7YpGqgkHI9i+jd1bYjt0XavhAag+voyyOr3OmqskHr7kuLdW7U5PSMHjwaJKu9nKeTEvytMBw664dVY6QHI4KXV4lzxfkyzCkMkaDLXNv0PADooWTOxCYAhW9hdT5UhSiiJPvfNx2YPuN0W/wnCxKXBqr3Gq7zZiWmsQv9oZQgsyWokjtIle1Gmz3gnk5bA0aQRVwaUyt8ovtN9UdEpOAEaUkm1IMUY1cCF2a08g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 LV8PR11MB8606.namprd11.prod.outlook.com (2603:10b6:408:1f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 11:35:42 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0025.023; Mon, 18 May 2026
 11:35:42 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>,
	"nikunj@amd.com" <nikunj@amd.com>
CC: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "yosry@kernel.org"
	<yosry@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v7 1/7] KVM: VMX: Pass @vcpu, not @vmx to init_vmcs()
Thread-Topic: [PATCH v7 1/7] KVM: VMX: Pass @vcpu, not @vmx to init_vmcs()
Thread-Index: AQHc5oMu/h7WhR2srkqyxAhi07DoQLYTp+EA
Date: Mon, 18 May 2026 11:35:42 +0000
Message-ID: <4216e3964081319b668ddecd33d1c774254291d2.camel@intel.com>
References: <20260518045916.2988667-1-nikunj@amd.com>
	 <20260518045916.2988667-2-nikunj@amd.com>
In-Reply-To: <20260518045916.2988667-2-nikunj@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|LV8PR11MB8606:EE_
x-ms-office365-filtering-correlation-id: 5635c352-1a10-47fe-3dce-08deb4d19839
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|4143699003|11063799003|56012099003|18002099003|38070700021|22082099003;
x-microsoft-antispam-message-info: 1abX9k+y7Zo+/DQDKVCoJr+hMS5Mf0VB9e3SHYNnzRCQk6itE7eDtKOQHF/FnEFR/jmLEhgAp3NKif9wALh/Irbfph4aLXN4PTTu8MBk3BvZTN9pC66Zaz36V1EJdorHWgKDkr4rI99ZqAFK2wk+agILsZ/Bqx63MQ7fsnB+R53KExvGRLQly05DwN/mljqwx+NXtstASiAu9beR3/NXhdSpDQxZLEosntBmLC95I1niBO4oaApQ0dITyobWrxGgLDDLeUE5wKDRhkT47oczceBEvUnw/voO5UKSFKWOEde2Q9XvQGsNeGOa0Jc4ZpgcU8yBI+A6TeDnggT0FeJJBXHjo5YcpPNmX0/TvaEMmJBQtgcjlbH7JsAlTf9hIfJhhaqVw4SrBetGIOCk/g+zt+S8HjW+EvI7DQbJDkClZkEUF0vRR+u1TK6Irxdq/5sQcrE8JhcsbiMuvbdVqU4x0wX9K4CrBXCDAO0yr8vxBn3p2TnV/oW/dBARDSVlOFa8ANor/O4QnYXkLHh+kRJrLCC3FiuqkVX8vAPUvixRy3VeFJbA/BYQ8VoDrIolQ4sdf3F4TDBDq/gHiuI2vrh9JUo6R6ZRxWzV5ofCR4PEQjaGMcsy4mK2CTsHrKAkuuJ6RgPPMxxc1XSJf7laJ/Br8oUyLhX9c39YVIbC6MkbVNyp1ijxwsDRBWmSgq4hLp99xIebqfAG/jU6HxPqexc8ib5FtiqtPl25NKrr8G5VHJaE5GY0KyHCNcdILz0+6Ifi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(11063799003)(56012099003)(18002099003)(38070700021)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVNLVWNIZ2hPWWt0dzc4SVI0U1BjYXdieUNwRGtJbTMxRisxeU81Sno1UmZD?=
 =?utf-8?B?cXNkWkYraklWcTVPK0ZYSFRRb2NVUUpJUWhWNTc5YjFnMWtHS1VEaXFmOWpJ?=
 =?utf-8?B?bEtlR3c4Z1JNNXAvM29FT0ZLWnZwY0Z0dVZBc1ZWSjM4RmZjQ2dSVnBvaTFT?=
 =?utf-8?B?a2loaDFCdXlRempDay9VYTJ1ODV5Z2RoT2x5SXJwNnBHL1dIZDQ4R2ViWUMx?=
 =?utf-8?B?RWhvbGY4LzVNZEpoeWxBK1RYY1lTSWFlOFp6YzE1cDQrdTN4VS9IdmRLTHQ3?=
 =?utf-8?B?azFLdkkvMCsrSWdZYStyaU1Id1pJSko2dmJyZ0NGQlY3SkFQQlh2dEZLbVNj?=
 =?utf-8?B?MU5qT0dyRzZleHVsQllkMjk2VXVQN2ZEUUhVenYzcVpnbUlYNi82ckowMGNo?=
 =?utf-8?B?UEgxRVBVc1NHMHJBVUpScGNSSmdFUzBNdVYzMFYzbDE2dStqaTR0ZnV1cm1R?=
 =?utf-8?B?Mk9jK2dHeXo2QjAwa0FLRUd3dW91MHhzdFU4eEF2aGhIQVBpTTYraXg1Vnlo?=
 =?utf-8?B?bkxlQzhRUGZmRzhsTHdHbHc4SUljVzJXMGlZck9naEYydDhtSDdIVFlmTHp2?=
 =?utf-8?B?aS8rSEtCc3pJdGsyTzRJL0hPanE3ak1Sd1lIM28zNHl5QUxpZEZPQndlZjJx?=
 =?utf-8?B?aVBHMFhEV1lyYlE4N0hsSE5NWVpsTG5LdmRsNWRpaDJuU2hJL1gxSGZuSnAz?=
 =?utf-8?B?YnpaT0dwdlhlMzliWXVUcHFZZjM0MnBvdDVNQzdMVnJ2eVQ5TlhLcWpJZW1t?=
 =?utf-8?B?cnJJK3Exa0dvZWNVdW53eGpja2ZCeVVOakFJejV3MEdpVDJNRGZTYS9EUmdK?=
 =?utf-8?B?ajNOQ2Z4TnFpcDZGT3I2ZktzT0Q0dTNqK3BpNDFoN1VwaHVEOTA4ZFlacTUw?=
 =?utf-8?B?SHZMUmpkMHNsUE8yT2hieUdTR1lMN0w0Y05nRStHSTd2Z1E1dkxsOUR6SjZx?=
 =?utf-8?B?WXFRaDNiZjJsL3lmd2VDbDRwQ3JkR0NpV2JhbVVaUVY4UG5KbXR5Z0J5UkMy?=
 =?utf-8?B?M2VoVkpPeTU2c3N5K0lpc2ZVb2NldGpDRU1GZkIxbEozaGZhMWE5QnV0Rm5Y?=
 =?utf-8?B?aXlCUmpOV25pWWJMb0RETUE1YkdGM3BMd3JKNDQxT2w2K1FvZGJkN3RvVEs1?=
 =?utf-8?B?ZWxMNFl1a05wREVyZmkyaGllS0NjaXQ5dHNRMXhwK2FGeFordXVuNzAxOFo1?=
 =?utf-8?B?TkViZ1hkRm5JSkVUSVdQYkZJMG50cUFyTjArUFNOU1lkSHgrSUpzdjI0Smdr?=
 =?utf-8?B?ZXllZE84RjR3YjRTd0c3RWZPNDZwaXV5eVkyWWdlaHZ5eSt5d2U3S3NjaDln?=
 =?utf-8?B?ZG1WMXNOZU0wMjllNkJmR0E4S0p2ZXM2Snd1Smc2Wm1Kd2dLOEdUakQ0RnJt?=
 =?utf-8?B?TWRiZ0dkUE5RTmRoNllVK094dDdmVUpjdTB4V3Z6dTNrZitaUGZRNFZMckpk?=
 =?utf-8?B?RFFzK2V5OERSQ1gvNlVTR1FsbzNmYUpUOXRhbXZpNDhEd1RQaVNWWk91V0R6?=
 =?utf-8?B?REpkbzMyMVdpaXIyZDVSdDEvNTI2UmhuWmRwVm5lU2k1SkFsdmFCYlpZdy9u?=
 =?utf-8?B?aExLVEVuRm1keWdVSjQ1NThsVWo4QzNTb1Vub1hMNDUzNzBmbmMraTFFcU9I?=
 =?utf-8?B?ZnMwa2drUGtaSnpSeXJOL21jRmowSk9lZkNiUk04a3Q2Wnlmc29JU1dNbDR2?=
 =?utf-8?B?OUhUdGRoU0hSY2pCQWRsWE1qZlNuUEdyNVdpZTlWd0VocytIQ1VFdkMyM0xT?=
 =?utf-8?B?UTFpaUsrMUxRTmU2NTUrbU5kWGIwa2owQXBjeTlsNFBwQmZTUUd5TjVpSnAr?=
 =?utf-8?B?THFyMkRUSFJyZXRQWDZiWXUrbWJJM0NDREcvM0JjQTdLTDN2MmVWenAyQXR0?=
 =?utf-8?B?cmFnTjlnc2lOZElrV3Z2K0hRNnJwNEZUNDhwQ3NaT0hpUkZuQTFwT0hoUTJQ?=
 =?utf-8?B?a1JjNEIra3BlWTBzWXYvTy9EWkxVTERsbkpWeThKbEd3MXJha0ltY2JGWExT?=
 =?utf-8?B?anhCeHlZWG95emhValB5SkJEanQ3SGcwTkRhMS9WYk5PanFZZ3F3WnZaa0gz?=
 =?utf-8?B?N3RaL3J4bG5iZEcxclpsYzFjRjU5WlVWRnpFSVVkVks0WlhLMVVzemdTWWts?=
 =?utf-8?B?ekJQZ2ZCVTBGSUdad3J1c1I2QUk3MFFuclNJaDFFRzhoWmM4SlNLMGkvMVlo?=
 =?utf-8?B?anFKd0drVHFMZmd1NU12OERTa01laVJvNStWV0thRVFEY3dtQndiaVE3UFVo?=
 =?utf-8?B?bEJ2cWtsNUFJRFg1amgrdkpla2FPcHBmbGFNK24wWDM4U3E2OW5lcko4RjlU?=
 =?utf-8?B?S1luVHd2UVcvN0FZN2M5UG1SRVVwL1pHc2p1VmxkZTBVbFUxWmFmZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61F574AB0021434B91FDE8A2E4F66B28@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F8x42z6Oj9bE9hsLLNXWRvNMgve+HR5Mvi83TvLWHE6rvVkD5oaXCQKa43WafIAUUN1qEpA4uoYcOgRkvxBS7/zGTkBtqhn+dltqPxA1Ce3JinMSpfggMaDsZ5dR9jEq94dboRC/9Xzni2i3Maso7a10cZmn+u2q1cvtSZXMDjJWS9d9FborRGQA26z48NBykKjyLp8k6Om7RMT14maf9EOL9UgvYn7b6WUeWw7cyI8RGZyDj4LNQHMkjxvqTEB+/z2i+XdnC8BzTHdHMYvpkDCW5oqv1HRKP4a52QsowrPH0lWu5owOwA5Ws/BuEB6AVrjCmkPGFwAFnyBQmGLImA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5635c352-1a10-47fe-3dce-08deb4d19839
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 11:35:42.7148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4s5vDvdygwZvXhnwkisCJZWa3iLiT6xdmKAjlSrr90L0jaVVkT7dhkl2Yk1E5xZMB95ymqxUCo6fa8vtROamIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8606
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA1LTE4IGF0IDA0OjU5ICswMDAwLCBOaWt1bmogQSBEYWRoYW5pYSB3cm90
ZToNCj4gRnJvbTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IA0K
PiBQYXNzIEB2Y3B1IGluc3RlYWQgb2YgQHZteCB0byBpbml0X3ZtY3MoKSwgYW5kIHN3aXRjaCBh
bGwgb2YgdGhlIHZteC0+dmNwdQ0KPiB1c2FnZSB0byBhIHNpbXBsZSB2Y3B1Lg0KPiANCj4gTm8g
ZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENo
cmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTmlrdW5q
IEEgRGFkaGFuaWEgPG5pa3VuakBhbWQuY29tPg0KDQpSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxr
YWkuaHVhbmdAaW50ZWwuY29tPg0K
