Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920F72F3C26;
	Wed, 27 May 2026 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911872; cv=fail; b=HhhRQolmipDw2AbQ0AwNxB0tIJWK6XyKMqiBULdW1zfQY5mRJ7qbLvocG35upkn8cLj3+X2BxAkM9U189QfPvxKhh94F//oEQ6qOeOOfKuv9vm0Bopw5irKnGiWHCk7wg+d7tn/Hd9qoSMMky4iVTD6/QcGvz2qQI5dV9UcL39E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911872; c=relaxed/simple;
	bh=J1UuC2TAp10M6JjUKKqVL5lf7DdL5gUGF+sa5M6NnLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bCTDyS1RYnyodfRUt3dRKwXHUui0ceqydTlcybdTjq06vSbMxbgtAVIE6Kn8B6OHeBKrEOefIniBM2k6T8EFjVz5nnhnjCUGjUxDwTsGJI6ZHbRNx4kul7XSHUrctDRyNte0CWDBZNzabjx978VhMkgqxhZALYrBwgr3VFkUA1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtUKdDwB; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtUKdDwB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779911870; x=1811447870;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J1UuC2TAp10M6JjUKKqVL5lf7DdL5gUGF+sa5M6NnLE=;
  b=DtUKdDwBptFVoFY1bZwgbuOkwW35kI/o3N2qANcyc1zX4VesG9HyERi6
   T0XNifuCk/hsiNeyFIbshjxPbzUPiek8Tw1HOgrde1JYf4YznD+zZYlvX
   JdqcMxEZafm4oiwEA+HJwjAAvLLWjygd47jzMYZOMmEfaDJVkYI7w/8lD
   7IBPI7NRvOljbmgGrucu+Rl9UEzbssqCbS5arsS+IEZ9jzQOHUJMr0fB3
   kFWVUfHK/z27pz6Ydmxcg8xMYZ+Sh9YxcYo5PJFFoep28fUYLu/RZeW7Z
   IZGvMu2WvocIpbHxMQqVPwThc67/wSC3bxesAcTXHf+zrzRXdxJUc/QQv
   g==;
X-CSE-ConnectionGUID: Mza1wB3hSreqGQF9exTvOQ==
X-CSE-MsgGUID: HtTboSt7RbCpkxICbSGN+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="91060978"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="91060978"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 12:57:50 -0700
X-CSE-ConnectionGUID: UgiPg2mmTj+5rSC1JzQW2w==
X-CSE-MsgGUID: so5ZlobNSwqa6j3CGBlKuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="237909939"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 12:57:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 12:57:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 12:57:49 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 12:57:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvAn6BHDUR+152ajQl1PbJrLpb86I5w30XtflHK34tHdqmfqYw9wqbvhioVAQqkafIl36lWxeBq6sbAY/0hRuB4TbVLVZ/D5+hnaPaxvGmY+eOfxd7Kf5kb18yTQXruSllI+wTCHAn9H9DCu7lVsCaqTGvMEP9i1xd5ZbAYb4gSbxwC6jbb46UDakbYk2PKq95sOaASfdWMkXglDq8kPx5CN2ohGF3odSv7G0hs9yTT2B+uXNBsQz0tNMQ+Kaz7qKjPOlrky+sgAikmg08uLXOH1krhKR+0nZfO7b436J+mL9pWdV/UjrPoAnX0ztOiQrlvxjAS0dSkideKaQNJkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1UuC2TAp10M6JjUKKqVL5lf7DdL5gUGF+sa5M6NnLE=;
 b=Cdt1GhZr7U66R5nu55wQGk98Asa7nJBiEL11A9XFIRP/qb9WqzVdrZS/F9FAtyf8u6Zwb20PoOOSN0peHXsPKonbp3On3F/Y3eEk/2gDyUVUNwGR/s+mtEGIkgTq6O6LsG4P09AmvD6j5or22KBKV8P5t2tc07cNpk9D5uHbL7A55pteNvEDFwBQyFj+bi9JAr2Lfn5x4uFy94rWA7NT41BJjsL4uwz32aXxYRkG+DtFk3LbBvT4oz38pr36Yo8IiMu1OmGxH7c22THA2jlK4GWwOxfxqgrohWFfF8jL83jt3Icv/0ycnnyFpoIzVzrzuUTXrK88m/6JPlEDajdijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SN7PR11MB6972.namprd11.prod.outlook.com (2603:10b6:806:2ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 19:57:44 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 19:57:44 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "Huang, Kai"
	<kai.huang@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH v2 01/15] KVM: TDX: Drop kvm_x86_ops.link_external_spt()
Thread-Topic: [PATCH v2 01/15] KVM: TDX: Drop kvm_x86_ops.link_external_spt()
Thread-Index: AQHc346Y3p71AI4IxEOCUimMWbov37YiTcgAgAAZQ4A=
Date: Wed, 27 May 2026 19:57:44 +0000
Message-ID: <bb2a3905fb2fefe815ec482b7eaed5f7d7bd2a3d.camel@intel.com>
References: <20260509075201.4077-1-yan.y.zhao@intel.com>
	 <20260509075357.4113-1-yan.y.zhao@intel.com> <ahc3hmTa3TiOTZv6@google.com>
In-Reply-To: <ahc3hmTa3TiOTZv6@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SN7PR11MB6972:EE_
x-ms-office365-filtering-correlation-id: 040483b2-9689-4329-9eeb-08debc2a37b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|3023799007;
x-microsoft-antispam-message-info: pVDmb48OI1kovgRLqNLPSm+WOTTyAVra2fK2qNpzTwNyZj+Sh/RD/3rxa8K2xFn7eKusrdhVIlJrkUz9zeuFiCF+67jCZbpPeAW2jagWyZKeTb1wZwHT6UsXMQjSk5oYyZd0uqxb9sKC6Kmx+AggfFfvW9r9fUtXdQWzTYvbadx05pce3JbaDtpd4zjlgBnpOhGBK8ri8jlVnatg6kA9QCT6Rj7OfZUs/qKnKMlEW+foS7v/D0yzwhq69bjlh2HBuq6JdSjFKwZjAdgoHWH2fNaVZzET9XdN8A0QxfYNBowEQZQZF2B88V/G6GqMQ1qEJMXwXVvOiTRX9e8hD0BGPfTzVNoOXJllaByDumOZKek88Odv5XRnmggkLOnz8MfZrMp9VvmzA3+L1Yz1lozlJy67By+ykT2rA0xEIHKAqFTcJ3NWY5CydOtf2IUrK8phbnwM+Sr/ybXEJ8jQGHRI/dHTX6fDhU4Zz7JYgSXHi2f2UVDAOckVDgdOL6Yuzj7ulETh0OlFpG9i7FRrGyfYEeWOBcnu/+yA4U5s0YJh2gvcOdJW2f/2kaEoCAxs3ibXEGBElTVTDygu1WVebtafzA1Lhj4ao4BuxebS5je3eppEyyJYgn7F4+kwYDtxy5WbFEx/bykf/GscLbYjizKdaT7NMkkN7O4NdFFAx9lovOmGQ6tnADGflZiYONXKtElV65JkIOVkxoay6Vwo+l5QMndcjArD42ulh61Xrc9wNN4LUDDAmjykaO+gTUfZQLuz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTFHSWRqMDRJbXN2T01kL1hTSTVva0hidUhjM1E5dnk2MjByVE1DRzJ2Nytv?=
 =?utf-8?B?bk9HaENNMnE0YzR5azN0MFNKZGR6MG9kaXpkZGIzYlZJWlc4b0lrQWJUZDRh?=
 =?utf-8?B?TkRhNkt0c21ISkkyRmlaSERheXRHd3hBYmljd1NDUUVPNEt5Q0dDV0tieGNr?=
 =?utf-8?B?MUM0NUYzdkJnNXB2ejRiYWVpcCt6ZytIUjY0L2hDU2VkL0prNlAxWGJDSi9H?=
 =?utf-8?B?aFZocURZcVdIZ2pIK0xFOTloYWU0Zk4zcllxZ0RVZEhxYTM5UXZoLzhWTVVB?=
 =?utf-8?B?aDFFUXVhbHFSYVNnMDBUbjROa1hTU3ZncWt0ZDdGaVFvbzY5aTdYUjlyN3A0?=
 =?utf-8?B?UFdJWE9yamtld2VvV2d5Tk84b3lQREFDcU1vZ0dwczZLcm85ZldJYjBFTk5k?=
 =?utf-8?B?Y0R6RC9FdGUxZXl0Vzh3ODlkRXczbTh0aDRtWmxNRmFWRXl4NHFaWWJFNm9F?=
 =?utf-8?B?dFFhRnRqMk1BbW9DS1FhVGdGcGtGNmF3MWRQMGFrR0ZwbUFiUGNCOTVaM1A0?=
 =?utf-8?B?a3hEbjJlNVlMOGQrUWgrb0YvK0szeGwzOVBvL2VFY2tsY1I1Mk5JTHJFc29N?=
 =?utf-8?B?a0dROWpMUjBLR3hWMVFaVk1pZGhyMlEraGJVSWVCNTZhZDJUQzFZMDZIT0Rm?=
 =?utf-8?B?VEErSWFDdG84RWJwMW9HUHhEdHM1cGtXSVBJN1luaVZRc2lUOEhoblQzM1JB?=
 =?utf-8?B?QitodHNvVkhTa3ljUTNYVlN5SjRPTDBIQTd2YnVBRjRWazQzQXdiUE5TZk1B?=
 =?utf-8?B?R2hLYm1pc3Ntb2lKamQxT1R6d0VVb3gwR3o0RW8zdlJJb1g0V29zdzRYY2N6?=
 =?utf-8?B?SytMb3poN0d6NTZ3bUoxeU5od1l1TjBWanJyR2VpZjB2bHhlK0psdmt6Y000?=
 =?utf-8?B?eTJGU1E1Y3JXZ2J1WGhXcDUxTG52VEltbmlrNEo5MFhSd0hzejRDbFNCakhh?=
 =?utf-8?B?ZE1OV3p0UTEyQ3ZwSDhpMkZNQ1hvZ2dGM0FWdG5OdTF3alhnYXlzYTJwZzBV?=
 =?utf-8?B?ZHRBWXQ2K0JyVHBKVXdNcW1qcjVYTVZMdWxVNG5BREpvZVNXUHR0akJDa1BS?=
 =?utf-8?B?YWt5S2ljUjBmOXd2bmMzRmp2WVpXcWlESmZycWNyR2xaR2RaZHlPR2dDRTFW?=
 =?utf-8?B?bFk0RXNXaDNFeVVXeC9TN1BydGZ4S1ZQSmdMaG0wanVhYURvbjZwYnJhREUv?=
 =?utf-8?B?WGIvUzJZcVVnR1N0elFZT0MxeXVRbEtSK3FvVDlxU0JFQ1U0RU9MK2pyaFFO?=
 =?utf-8?B?akUybDMxc3JhZ1FMaTVlcng3NGN5UkZ3amRXK3hGbCtNeXhhY3JtL3NBSU56?=
 =?utf-8?B?NzNHcmFvT0I0UnJGR296dWtjK0tCeXdDRlpOeTIwMkg1Q3FXQ0thRWlvLzdL?=
 =?utf-8?B?RkU2SU9sTnpjeC9VUUhBSlZKTllndVduY3d6NGtiN0R2ejBvVlBsN0tXU1ZO?=
 =?utf-8?B?eVJQNU41cldZUnBZaHRvVktRSUVzdnNLNmZJcFJhYmRqeTNwTDBOenVoSU8x?=
 =?utf-8?B?enVhK1FQS2x5ekUxa1RBejNUSC90cG9XSTFjQnU2bXhVd3VQckRHSXJMQmx2?=
 =?utf-8?B?OTB2RUpuSmt2a2p0UmFCZFRrNUljVStQT0tBc2NJaGlhaGVLdGZCcXRxQnR0?=
 =?utf-8?B?OGthb2R5dUNVNlVQT3p6MUJCMzl1V2dqS0tyWVM2UXhhN3FpazlKZFNEckhX?=
 =?utf-8?B?eDROeVZYazdTS0lDaWFLbEhvaHlyQXNQRkZsV2xVd3VUZ2IzVWphN1JnOTlj?=
 =?utf-8?B?YVMzbkQ5SUQvZzI0RjZ4U2Fqd0tWU2l4Mk1KMHRwZzdHK056ZkQzUVAyVzQz?=
 =?utf-8?B?Nm40TUhtYmJtSXVRK05XSTlkSXUzYjBjNko4SktLNzNxUkZENHpLQzBzQVFV?=
 =?utf-8?B?T2lXbU5FeFcvS0doOXNSSVVKU0RrYUtLMGh5L1NhQUNGaFoyeUtlNWQ4U3lD?=
 =?utf-8?B?NER1ZHp5NnN1UVRvWCtVZ3ZPMGZpazBya0J0YWdhYjBTQ2x1aVg0S3dZZ0lN?=
 =?utf-8?B?Q3BIb1hDeVRxVFN0VlRvRjVtbEVSaEFLWS9hRDlDdVA1bFlOUWRBdTM5U1NG?=
 =?utf-8?B?TnNvcXRSL0dqMXV5aDZmVE5QSjhyRUJDN1lydFpZQXA0RDBnczFpcHB2U2ln?=
 =?utf-8?B?b1EzSFZrNkRUcXlUMElWL2JLT1phOUNFOUMxa3k2TklzcE1ROTE0S1RIYWtr?=
 =?utf-8?B?UXFrZlNIRUNGL1hSbUpYU2N5YUxZeFdPQWlTR3hUODZFdTFMNjVaKzAzTVhV?=
 =?utf-8?B?ZmpOMFA4MUpqd3VpejJLeGRLV1pKYitsNnpXdzdPYTcybGpUWUNNQVUzOVFj?=
 =?utf-8?B?R21Ua1dzNExjQzNCK2FSQTZVN3VhQTZCVlloRHlGUHBkcjFIZTdlV3NEdXdT?=
 =?utf-8?Q?JX41+WB0GjX1P5VI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E30D9E07E75634B9DE88F8132B2B5B7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W1PPkvgxOkcW2R7cVeMg3qUVNGwT3WK5dT3I4/m4KuED+ROXFWJMbN2x2+qBzF53woLs+lJRi29KTJebCwimmVV2X1+bQDrc02AO12EVJ8GOTWdv5L2yQzGInSbO3R1xsAAbI06F7As4sTY827nNVK4GVc52G88PU9ESjG+lfTO6wXXfsMHYyowjmeKK1Egce9dPJp8UdJxFDc2yEBPRm4i1tpdGVmiIrtCRSnANSb+xGbLXarbjwBggvdtQteFhNwnzL1kU4NcvmOoL0vT4K6iuHtEzy3P8j0HgEY2KEBywbGpDmvh38wvPPcRCmefXi5C9/qTVN5XOc5HL0alrQA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040483b2-9689-4329-9eeb-08debc2a37b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 19:57:44.1975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lbxJfYcWlbJo0ecmuzPJsXRMpBZzgXGQdnxRQRbvX47+QZxsi7g62r6ndTIg9TZhd1xyqaIwjmuJ4PZrE6+LaLBfnPUNo1jdaV+9WfGUf24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6972
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA1LTI3IGF0IDExOjI3IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29n
bGUuY29tPg0KPiA+IFtSaWNrOiBhZGQgaW4gdHJpdmlhbCBmZWVkYmFja10NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogWWFuIFpoYW8gPHlhbi55LnpoYW9AaW50ZWwuY29tPg0KPiA+IC0tLQ0K
PiA+IE1NVV9yZWZhY3RvcnMgdjI6DQo+ID4gLSBNb3ZlZCB0aGlzIHBhdGNoIHRvIHRoZSB2ZXJ5
IGJlZ2lubmluZyBvZiB0aGUgc2VyaWVzIHNvIHRoYXQgd2hlbg0KPiA+IMKgwqAgd2FybmluZ3Mg
bGlrZSAiS1ZNX0JVR19PTighaXNfc2hhZG93X3ByZXNlbnRfcHRlKG5ld19zcHRlKSwga3ZtKSIg
YXJlDQo+ID4gwqDCoCByZW1vdmVkIGZyb20gX190ZHBfbW11X3NldF9zcHRlX2F0b21pYygpIGlu
IFREUCBNTVUgaW4gYSBsYXRlciBwYXRjaCwgdGhlDQo+ID4gwqDCoCBhdG9taWMgemFwIGNoYW5n
ZSBjYW4gYmUgcHJvcGFnYXRlZCB2aWEgdGhlIC5zZXRfZXh0ZXJuYWxfc3B0ZSgpIG9wLg0KPiA+
IMKgwqAgKFlhbikuDQo+ID4gDQo+ID4gTU1VX3JlZmFjdG9ycyB2MToNCj4gPiDCoCAtIHJlbmFt
ZSBleHRlcm5hbF9zcHQtPnNlcHRfcHQgKFJpY2ssIFlhbikNCj4gDQo+IFB1dCB0aGUgdmVyc2lv
bmluZyBpbmZvIGJlbG93IHRoZSAiLS0tIiB0aGF0IGRlbGluZWF0ZXMgdGhlIGRpZmYsIG90aGVy
d2lzZQ0KPiBgZ2l0IGFtYCBhZGRzIGl0IHRvIHRoZSBjaGFuZ2Vsb2cuDQo+IA0KPiANCg0KSG1t
LCBpdCBkb2Vzbid0IGZvciBtZS4gVGhlIGhpZ2hlciAiLS0tIiBnZXRzIHBpY2tlZCB1cC4gSnVz
dCB0ZXN0ZWQgb24gdGhpcw0KcGF0Y2ggYW5kIHRoZSB2ZXJzaW9uIGxvZ3MgYXJlIGRyb3BwZWQg
YWZ0ZXIgZ2l0IGFtLg0KDQpJIHVzZSBmb3JtYXQgWWFuIGhhcyBoZXJlIHRvIGtlZXAgdGhlIHZl
cnNpb24gbG9ncyBpbiB0aGUgY29tbWl0IGluIHRoZSBnaXQNCnRyZWUuIFRoZW4gd2hlbiBzZW5k
aW5nIG91dCwgaXQgYXV0b21hdGljYWxseSBnZXRzIGRyb3BwZWQgYnkgdGhlIGZpcnN0IGFwcGxp
ZXIuDQo=
