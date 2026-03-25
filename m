Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192523FB05F;
	Wed, 25 Mar 2026 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459286; cv=fail; b=Y1SRrs5JZgTdcEzwexwo2dKXs+DBsecWvx+VeabozQbmXEQu0kXkKOFu9uFy1dnm1dCQcineRh7fwDMMimKMGGvQuqEDmdp0PurH8SXAQuwTb1TjkJ+nDf+SPhahi4jPVZi62AkP9GHWfmURCj2KcgPIBVc/+hpJw8IosJa2Nqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459286; c=relaxed/simple;
	bh=yNCjTmyOVpDELH/nIAMWt2/RdzcxEOFoYj5SJyVpHO8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dtAFEwtxU1PsovKLdGxebCqPUKPDYya6J4yAt0X7eAchNdDiOFo8lSk7jjmGBhrDlw5P7fPUq18pbGlyCevABwHIj/HA5LJ9reNA43gj3tN0NmeYpZAIgZn8oAIyWQHaa00pCmr1jd1txUMZHhKQWkbBTAAJpDBO4gXau0anMnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkA6g0JK; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkA6g0JK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774459283; x=1805995283;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yNCjTmyOVpDELH/nIAMWt2/RdzcxEOFoYj5SJyVpHO8=;
  b=bkA6g0JKLXCeWEznGDw2MkAp96W18l3tIE6qSPVkUvSMKjNFoy6x2FFj
   1dBlvG8Wg38Qak9kjL/DN9x9l8g1TswF3woX/F8fCB0J0RSa5Rjun4ofp
   kFDGlXCS3664CloW+7/bqSlSVU/HhDKHDqDkslT28Krt5DACl/trsm/fe
   AhlkDmJnr/5pSNkgyeNcu7QnMEUrIdvSwBolwjk4QZ54jdsMG1kAIyHYF
   0OIueb2/Mfbw/vrTsx3dZmeAGQSGnEwIVhh9jZpAA1O+R5AgrF95umOfD
   MJBySef5SixjaCRQzkBqzllcjOq5PAMJjqmm35u/NxdHVFouy2zMAnvL2
   Q==;
X-CSE-ConnectionGUID: Q67aUQQdSlaYF7F192M5nw==
X-CSE-MsgGUID: lv5XKqynTI2DbSMZYrMRqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="93083144"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="93083144"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 10:21:22 -0700
X-CSE-ConnectionGUID: TXLNsfl5TXe5F/PjJHV+XQ==
X-CSE-MsgGUID: Blw17u/rTw2P2WeXqXDcow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="255241121"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 10:21:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 10:21:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 10:21:20 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 10:21:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcSuDjXORq5fGfnJacd0Mi1Rfd7Y0htxheCRwhfQekfRnuMU0sHtxuR9jFn2SbcZWrw34/w+kBxS8wqz9yICxY81h21JA03tU2yMd9Y3TQrSx+2p3Q7diXrPVDIHGKTj+TBd0eJV6SQmXrxxrrmq9IM92gddaRKJsTaLACn23EV7gsDLyEQ0gW/DLrLrBF/DkRRDbbH4Y3XLKHsKNLmBZcZBnR6mfQh6HyKBOGXheGAn6y/EtqOOcCBm6Cvk+dJyyaSSejBQFhqCqhTkKGZj8EdU/wvV0msK2H18C0dsvFOx/iuswpCSEFvKLyqP6hHA8yp5MaxY34+XN+xH1EGteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNCjTmyOVpDELH/nIAMWt2/RdzcxEOFoYj5SJyVpHO8=;
 b=cIWy/TbyBtOQV8gmauydIXceqds0uZMn0ttwtll5Uy1yw1beB3QtQ5tyJdTr/jrPLlwT3ps3FX8w8PP1i0CdJHGMLdHUetfts6B6pSYBktuHc76JRBfhZtEg8OwoqsTn9ddzlgIn2dTZZ/iGI1gZUWClGiY1XIQlBNEJm75bc7cvbyeGUqgzqufGBaNHUMeOmLLJZ9uRDYYq2AAMTlSVxU9OxvKQ7HlMWU1k8UOG8TcPUt5ndyQ2KDLK+dQ5LSp0j9h/v1EKRDwfOm9L5FBjXFHBzo1nT74ESthnKZ9FPuSWUlDfLeJWYCeXuUiCnLHhDAfKBH6aWcMwH2rGtZj6kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA3PR11MB9375.namprd11.prod.outlook.com (2603:10b6:208:575::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 25 Mar
 2026 17:21:17 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 17:21:17 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>, "Qiang, Chenyi"
	<chenyi.qiang@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Topic: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Index: AQHcu6ISxXKhFiWKBUuIm+vE1xtYKrW+PPMAgADQbgCAAHNtgA==
Date: Wed, 25 Mar 2026 17:21:17 +0000
Message-ID: <7802b50589c80a7276a50cc473c1aa579750a30c.camel@intel.com>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
	 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
	 <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
	 <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
In-Reply-To: <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA3PR11MB9375:EE_
x-ms-office365-filtering-correlation-id: 726c4a71-2229-47bf-18cc-08de8a92ece3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: vAGAoVl4njuU8nSjkFiTDqKOUsI5EgYSIpH7phOnss3WuQvZDqymGEzgWalURVuwJhWxxZ4aiBXet9np8cHr0oKJXQ+ThXaKXSUDCDHN/roGq6x3XMb10nilu0GptvkSAUg4hv/Op9fE4QDJA0KGn23oViY5VNF/1RZjfXm7iCbBZezHtISsbOlTTpvmG2rNQeQYVj3OB2N9/6/WusOYMGiBXBBm++Wqh7Fy7NydPkcJN9IMHRiooFJR5VV37pe73rxhnK/uWN/4/oa7rER3w4Qw9mnrGabC3GBbPi7nU0UsfwI18WUDf9gG3ozCaNpzO3d2BZho+wGSHzPGDIwUYpB2eLGxIZJJspbRKbe1KP+a+v1ZS1lI6viWehuVJjIm0vxSSICvoWQijsvDER/S53Rf35rqPiyqAg6YKkVSZyiqo7yPVYURfrYC42IPAWwOgac2zfGDziwW89UT1vagEQ+Njf58nzUv0xv8vtHCZfo6FjukxFh4jK+qKMksKHv44rPjalR/KN6asY6GOeLSX5efq7Xw6UYyDIn4tAFR9fyDRStcLoi9jHIYjXWW+W0/E9z1uq6cAsVgT7P5IGAHQD+XaFmXYm6Sm0KniAF7SEpQmbYWZi5siEthlzAxx3Hg2wszpZiRrp7JCgLqjxkaIicoLz+wD6+BoAcfmzUgqrf/ckWyfdj4T+0kPDlRItCEbFwmQk5KiQPZlwKx1W019nXGpd2S9n9HrS94U/0SeozcE9/3ac9Pj41HJO6uIhTBzvz1rsNffC+pGbuADCDdEWfPKAPD1nA2HMi+p6CQnNk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlZOMnJCZXBMSTdocFc1MHBJeUREaysvMzhsUUFNOHRIaVJoaUhMa3dmbW80?=
 =?utf-8?B?UmRYRkx3SVBzbHhzM1NPZnlHandwKzRKd1JnNXNjZ1hESWM3bENsTWN3RkZi?=
 =?utf-8?B?dndPaEc0SWJVSlZ2WkNZU2NtQVZDMHlrRHZNekJVYXd0KythdzJNTzNZRlZo?=
 =?utf-8?B?Q0xoNWE4Z0JFTmJPVklpMGYrL0pmS0d0MndVdkt2ZGV5TXlMYjZPalNVOFhU?=
 =?utf-8?B?bnRYWGwzdkNTdWFka09mbTFUWUZYR201RHJvNUh1ZDBhTHVoV0dUbE4yb2Fq?=
 =?utf-8?B?MEtjM21xWkNBSkZ5ajNXaG9sd2tza3FKK3dwV0x0YU1jY2dMVVFlazd0ODZ3?=
 =?utf-8?B?bjJSRFpYQXRVdythZm1ya0t1MTBFOTdLM05lbVRadDhNT2lYK0RLWkNaMmJX?=
 =?utf-8?B?cGgxakwyY1c3OFFOaVl1S2k3QVdOVmc2T3RLbnVHTi9tdWRnSW9heHpqbzY1?=
 =?utf-8?B?RmlqV1dTSWVkTDFNTHFTQ0ZZQjNENzZWYWZKZlcvQ2hNTU5GOXlvZ1BJRkFO?=
 =?utf-8?B?UGpDUmdTejJjY0JrcjkvWEZabW84UUxtSE1pNXZuTHV6Tm8xazZaWGp4U0hZ?=
 =?utf-8?B?WlkvQ0tvZ1R0Wm5vN05TL0k5K3JnWHRhelNxN1dTRm9laHdjYkUzc1RPRk9T?=
 =?utf-8?B?QWFkY3hZRWtTeGpDa3lXZjZidk5WWU9YbzFWblMvUUNGRmJ1bHhJdGZ0OWJt?=
 =?utf-8?B?SE9Bak93SWpFUVYvZ05leTBTN0xPdWhtMGN5TElYYUFGcHROc1RkeENCWjBk?=
 =?utf-8?B?c216OExPMVpsMTh6U3lRaEFqbHJPQ2VkWjNzVlFkWkl3UlFvUnlhVDBYUWc4?=
 =?utf-8?B?TUVPK1N1RVNsVEU4cXY4c0dqaVdWQ05sVU55TmNqZEVlQzNGWitHMXdxTnJ6?=
 =?utf-8?B?ZlJZOG9Ia2F4dzZpZTh1dHlvemlLV3VvTU1yVlRMZTN6TWpQQWlNZWJhSnh6?=
 =?utf-8?B?TE5ockJCMisreFI0cTNRMko1blBpOFZxWnhPTUFsc256cjlpSkNVZVpyQ2dp?=
 =?utf-8?B?c1MweHdXczFZTi9JTGs2cEFqS3RsQ093NjljdmJzeWlyenRmUTE2OURLSjRX?=
 =?utf-8?B?NlhGb0gxcmhaRU8vNW52UndpZXAyVkxHaHdNVlB0MjVraWdrZFQzclpNR2Rl?=
 =?utf-8?B?NU1RQkI2YWt4amdqeEJxcVNic2FZLzloR1lReTF3K0o2TGVEcXBadlJNM1ZC?=
 =?utf-8?B?UXlJekZMNE1tUU1hNFhEN0I2SWpwVTIwSDdDeGM0dzBuaW5NdVVHa3FSV1VD?=
 =?utf-8?B?ZUJIOTdRclorUHFmWGE0Q3hMaGVpclBmaGgydExKSlZpTjU1WGdPK2pBK0NI?=
 =?utf-8?B?RFd2bXhxWmVjTDJFRWt5VExkamJCbEs2QnZTeEt3SFpkKzk0VFF3d0xaQlVW?=
 =?utf-8?B?YmxjRDNtTitTZTdrVDFyYmVVQzZidUJDRXVQRDlOLy84Ynk1VTk3ZkxQSUVN?=
 =?utf-8?B?TkRhM0l6TzV6NGhESStnRTdZL09TczRHWDdpMFdMYXBEQlI1dVJJV1dBaEgw?=
 =?utf-8?B?eDRSOTdkQjJ1d25mWU04ZEIzalp1SWNJbTR1Nms4YndscEpKYVdrUTJtek5H?=
 =?utf-8?B?NW5QeE9VMUJqVnF3cEZlWTVuZXBmd084ajFlL1Z1Rk1WY1Z0bUNwQzkvNVhY?=
 =?utf-8?B?K1BLZDh4UmVMNys5ZVRTQ0FPZlJEK1pTRUhLVGwxQmd4dExoYnFkc2JTa0V2?=
 =?utf-8?B?RXVwYVhtN1Bld1hCNGhjQUtNaWZJSnIvay8yK01TcmNXY09QSE9Pc2kwS2lD?=
 =?utf-8?B?SzhxOXJFTUhyNFoyUjg3S0FmSVJIL29wZmZHVVowUWZFWGp1Vy9BTjloY3pa?=
 =?utf-8?B?aVRmbXV2bWVMTDVqazhoOWo2bEFUbTRoblVxMGJ2V2hLcmJBMmpvb09WeXlj?=
 =?utf-8?B?QTRYU2JDSHJNam11L09pa0h2TGJtY3hPblJTclZSMWtXaTh6UnFkZkw3aW5l?=
 =?utf-8?B?NXZPRE1lbXA5ZEtRL044bmZlZFlzY1E3MTY4V04rMjIvRjBTVjhNbnI3OWlq?=
 =?utf-8?B?aitQcmNhcStaSDZhNCsyZmFEOTF1SnFuZ0VsaHR5eHQ0emJueHk1SVJ5dDJ0?=
 =?utf-8?B?RHc3VElIS2h1dUg0TnZmL0QzbG9iUUFwV0NGT2dsOWZPUmZiVGRtVUxDVzJC?=
 =?utf-8?B?bkxqYTQralZoVERRZ3JjWXU2NDhiblRZcUp4cEw4RFBITVI3N3pCN2l6ZUlr?=
 =?utf-8?B?WlpWSTlZbkE4cmtSbHN6WGFOOHdMQnZtb3dmaGFGZVp5NXNSZXg2SGhUUUg2?=
 =?utf-8?B?Uy9tNkFCaWVsdDZCUmlRMU5LekltRzlPcWp2cEJHYk9tZThXVXZEY0VJLzNC?=
 =?utf-8?B?RlBrRTlEMk5jeldtbGdjZlAzTm83enV3cmluN042SnBBeHBKLzZvMVdOOU5E?=
 =?utf-8?Q?ln7F5hYYYaAl5CiE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39BFD29F4A73A64182FB53D7A22F1272@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YN+RmWzYjOj9VY4jRhJ2VOHYAegKM+BALFU3h5ZGRO11hrZTcrpa0/YtfiYv+jvccKgtBJ/ja82k+ynMOKlp5DmavmviXve5wcHCHY/N3I/GU3kqLetEy4qsYEvBGI2bSMr9VSHuqqlvub8IFHan4y9qdiYIytI+pEb4AiRXyYoEDrpJaNhz7YVobLufWxKblPlI1jYrDqMfpsMKGBGPGrMcaASi6gzxelqg1e2WIyiq8w/Hwk1WZ8J6N6reeCV4ZrDxw8SNryyik9/U4JBGIDfIUyj2t8xuDBQ3cMdZoYOef6jm4fvQwaLBpgA72WKViDUB0+JvNwS12acSc4JO4w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726c4a71-2229-47bf-18cc-08de8a92ece3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 17:21:17.7100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5OraFnAGvODv3Dq9HxvTRkNXYM+NDFbmwU6R4QnF88xktxf+GpHvnqPnnRjo3+J/wdpxyLklKfjXbYOtnBM8sphxjhO5OtD/RJ7UnmWnZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9375
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTAzLTI1IGF0IDE0OjI5ICswNDAwLCBNYXJjLUFuZHLDqSBMdXJlYXUgd3Jv
dGU6DQo+ID4gRG9lcyB0aGlzIGRlcGVuZCBvbiBwYXRjaCAxIHNvbWVob3c/DQo+IA0KPiBZZXMs
IGlmIEkgcGx1ZywgdW5wbHVnIGFuZCBwbHVnIGFnYWluIEkgZ2V0IHRoaXMgd2l0aG91dCBQQVRD
SCAxOg0KPiBbcm9vdEByaGVsMTAtc2VydmVyIH5dIyBbIDU3MDcuMzkyMjMxXSB2aXJ0aW9fbWVt
IHZpcnRpbzU6IHBsdWdnZWQNCj4gc2l6ZTogMHg4MDAwMDAwMA0KPiBbIDU3MDcuMzk1NTgzXSB2
aXJ0aW9fbWVtIHZpcnRpbzU6IHJlcXVlc3RlZCBzaXplOiAweDANCj4gDQo+IFtyb290QHJoZWwx
MC1zZXJ2ZXIgfl0jIFsgNTcxNC42NDg1MDFdIHZpcnRpb19tZW0gdmlydGlvNTogcGx1Z2dlZA0K
PiBzaXplOiAweDJlMDAwMDANCj4gWyA1NzE0LjY1MTgwOF0gdmlydGlvX21lbSB2aXJ0aW81OiBy
ZXF1ZXN0ZWQgc2l6ZTogMHg4MDAwMDAwMA0KPiBbIDU3MTQuNjc2Mjk2XSB0ZHg6IEZhaWxlZCB0
byBhY2NlcHQgbWVtb3J5IFsweDEwODAwMDAwMCwNCj4gMHgxMTAwMDAwMDApDQo+IFsgNTcxNC42
ODM5ODBdIHRkeDogRmFpbGVkIHRvIGFjY2VwdCBtZW1vcnkgWzB4MTEwMDAwMDAwLA0KPiAweDEx
ODAwMDAwMCkNCj4gWyA1NzE0LjY4Njk5N10gdGR4OiBGYWlsZWQgdG8gYWNjZXB0IG1lbW9yeSBb
MHgxNDAwMDAwMDAsDQo+IDB4MTQ4MDAwMDAwKQ0KPiBbIDU3MTQuNjg5OTg5XSB0ZHg6IEZhaWxl
ZCB0byBhY2NlcHQgbWVtb3J5IFsweDEyODAwMDAwMCwNCj4gMHgxMzAwMDAwMDApDQo+IFsgNTcx
NC42OTQ5ODFdIHRkeDogRmFpbGVkIHRvIGFjY2VwdCBtZW1vcnkgWzB4MTQ4MDAwMDAwLA0KPiAw
eDE1MDAwMDAwMCkNCj4gWyA1NzE0LjcwNDA2NF0gdGR4OiBGYWlsZWQgdG8gYWNjZXB0IG1lbW9y
eSBbMHgxMzgwMDAwMDAsDQo+IDB4MTQwMDAwMDAwKQ0KPiBbIDU3MTQuNzEwMTQ0XSB0ZHg6IEZh
aWxlZCB0byBhY2NlcHQgbWVtb3J5IFsweDExODAwMDAwMCwNCj4gMHgxMjAwMDAwMDApDQo+IFsg
NTcxNC43MjI1MzJdIHRkeDogRmFpbGVkIHRvIGFjY2VwdCBtZW1vcnkgWzB4MTMwMDAwMDAwLA0K
PiAweDEzODAwMDAwMCkNCj4gDQo+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBRRU1VIHNob3Vs
ZCBldmVudHVhbGx5IHVucGx1ZyB0aGUgbWVtb3J5IGFuZA0KPiBQVU5DSF9IT0xFIHRoZW4gS1ZN
IHNob3VsZCBUREguTUVNLlBBR0UuUkVNT1ZFLCBidXQgdGhhdCBkb2Vzbid0IHNlZW0NCj4gdG8g
aGFwcGVuLiBJcyB0aGlzIHN0cmljdGx5IHJlcXVpcmVkPyBBY2NvcmRpbmcgdG8gdGhlIHNwZWNp
ZmljYXRpb24sDQo+IGl0IG1heSBub3QgYmUuDQoNCkFoLCBJIHNlZSBub3chIFNvIHRoZSBwcm9i
bGVtIGlzIG5vdCB0aGF0IHRoZSBrZXJuZWwgaXMgYWNjaWRlbnRhbGx5DQpyZS1hY2NlcHRpbmcg
dGhlIG1lbW9yeS4gSXQncyB0aGF0IGhvc3QgdXNlcnNwYWNlIGlzIG5vdCBhY3R1YWxseQ0KcmVt
b3ZpbmcgdGhlIG1lbW9yeSBkdXJpbmcgdW5wbHVnLiBIbW0uIFdoeSBub3QgZml4IHVzZXJzcGFj
ZSB0aGVuPyBJZg0KdGhlIG1lbW9yeSBpcyB1bnBsdWdnZWQgaXQgc2hvdWxkIG5vdCBiZSB1c2Fi
bGUgYW55bW9yZSBieSB0aGUgZ3Vlc3QuDQpJZiBpdCBpcyBzdGlsbCBhY2Nlc3NpYmxlIHRoZW4g
aXQgc2VlbXMga2luZCBvZiBsaWtlIGEgYnVnLCBubz8NCg0KQW5kISBUaGlzIHRvdGFsbHkganVz
dGlmaWVzIHRoZSB3YXJuaW5nLiBJZiB0aGUgZXJyb3IgaXMgaWdub3JlZCwgdGhlDQpndWVzdCB3
b3VsZCB0aGluayB0aGUgbWVtb3J5IGlzIHplcm9lZCwgYnV0IGl0IGNvdWxkIGhhdmUgb2xkIGRh
dGEgaW4NCml0LiBJdCdzIGV4YWN0bHkgdGhlIGtpbmQgb2YgdHJpY2tzIGEgVk1NIGNvdWxkIHBs
YXkgdG8gYXR0YWNrIHRoZQ0KZ3Vlc3QuDQoNCkFub3RoZXIgb3B0aW9uIGNvdWxkIGJlIHRvIHBl
cmZvcm0gYSBUREcuTUVNLlBBR0UuUkVMRUFTRSBURENBTEwgZnJvbQ0KdGhlIGd1ZXN0IHdoZW4g
aXQgdW5wbHVncyB0aGUgbWVtb3J5LCB0byBwdXQgaXQgaW4gYW4gdW5hY2NlcHRlZCBzdGF0ZS4N
ClRoaXMgd291bGQgYmUgbW9yZSByb2J1c3QgdG8gYnVnZ3kgVk1NIGJlaGF2aW9yLiBCdXQgd29y
a2luZyBhcm91bmQNCmJ1Z2d5IFZNIGJlaGF2aW9yIHdvdWxkIG5lZWQgYSBoaWdoIGJhci4NCg==
