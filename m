Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927133AFD11;
	Wed,  7 Oct 2026 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791413287; cv=fail; b=ApUFz0sfZZ24l0eH6wMFlDeVpY+BZO5cykvXMZTPIvXkuLXmo7MwkGjwVZy7VXQgL+VUuzd68ggW9PQiBfSycYcLu6NDSCJnEXjI5yEqL6Vl9vENsaS6GG5vtcUP1QWJ2+oAPiDdT0/L0GT8sUnnYA0qejl/cLnjh7Qx4bb3lnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791413287; c=relaxed/simple;
	bh=FQNdjP9H8eKeVhcHMAI46rH2pQ4VuSSYpKEAkX+g/KI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eO2uvL10DYQ6YI4nMXRXAGGkZkFwq4aE+mSpRA7FYjwbRMKRoD/hn8RWV8BdDtjQNmeDke5VNXBmbX56f6Q8FnmCIYt0XIh5OTPQpS9oYzB8QtQUUfIT8cPiY2bdM30KN3jltCngmjt04WnXroxWdaVGtsY3FbnWJk3jXwm3Qe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqK5eO8R; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqK5eO8R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791413286; x=1822949286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FQNdjP9H8eKeVhcHMAI46rH2pQ4VuSSYpKEAkX+g/KI=;
  b=IqK5eO8Rup26jKk9cD1SQfLTn+2hQwAQHZbgDJmUnKyY1Iv7wDRJLCpV
   VQhIv4M0eeZAWeKfbbg1DBXD68UQbTxny2h7HYgkYjV8KySwMwkuEO1gD
   iUym+haCA2LNN+9hCrqGnjpag0mRByrqIJpZRcbEuYmnGllTVxlBEat70
   8/h0LgTR+3V7xZCB3lR4vYhS6s8Z2bOjnyt0wxBKDxXZ707aXmOsBC3pL
   ucTCvyAAU69YM89I6z54uxR5U95fzCKLrQwaeQhXf+6hTsac+wpbGHP08
   CUuElVTCu2uk9Yu5smQvVVUviteTQ4ge0ISnyCfNmKevis+l8SUSz14Gq
   w==;
X-CSE-ConnectionGUID: nt2gCfx4SXysua2ZGVtYyQ==
X-CSE-MsgGUID: xjWo9LBQQ/2W9vMorB2Vaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="185002"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="185002"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 15:48:05 -0700
X-CSE-ConnectionGUID: jMTGvwiNTP27tLq7Xs6dZA==
X-CSE-MsgGUID: xUm2ew+pRKqgmQSyUYSlHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="275365180"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 15:48:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 15:48:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 15:48:04 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 15:48:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebjGXk/xQszkcqiF4UuaCTBqFQ/YmO7/yDgWniF75RZOUhZPNa84A9LMTRL/zSvzs3M99njX0H5+GW7N81AJJETDoOqsg0nK745CathAqWMWcsB5y2x48WpqnVyGE6xD+kDVmbCxVMHuk74ydjxBOtunCfUddEzqog8OUb1LOYDF9wDg5jCyYfGmxCa39knmyYnzcqNEAgOi3w7XaXd7a64q7+F3VEEgBHaq37VVPM8knacsH2RSNht1H378gQLgFLhMqU8dgbuEv3dX6vIcz1UypKgOFn8Uy2pc0IbIcMZchC9NUKm6fEPtI1H0fZc7OZuv3NVvVudUiQDH3Eo8Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQNdjP9H8eKeVhcHMAI46rH2pQ4VuSSYpKEAkX+g/KI=;
 b=TzCWffnYO6o/GbqP8/CBMXlKEyINHkRfIHHj6WEWsPmr3WKq+AHrobOAkMiUP1Ei+1ZZeEjBqaqklPbav9t/EuCA5lqAxq1mP2isVtgrv2St/DFbCKquCJ79rSk0HvrlNF0+y/69HjFXTp+7tTsYHLAl8oMe80mwNtG/1HB6tShmiWKm+1ebEJvSepxKY1EzVqaMvcT30Y4WAUnV2ARq7elUBiDbgCFu49Ev9teNvS9HTiK4f3bvfzG7Z2LqrDnNaHIpwae99IPBdpg3Aab6SFZW63xI+QMkPpVZ3AvZI5z9MNKNdDeHFYkwaxI4cMwJZUX9T14v70xzXzUbJeAl7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by MW4PR11MB6837.namprd11.prod.outlook.com (2603:10b6:303:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 22:48:01 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Wed, 7 Oct 2026
 22:48:01 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>, "Zhao, Yan
 Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "francescolavra.fl@gmail.com"
	<francescolavra.fl@gmail.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Thread-Topic: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Thread-Index: AQHdTylT2fDCHY1RikeRNXt5wj90e7byvXkA
Date: Wed, 7 Oct 2026 22:48:00 +0000
Message-ID: <6ac2a1ffc4a860e71e63c068b33dc7644e65401b.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928091035.15599-1-yan.y.zhao@intel.com>
In-Reply-To: <20260928091035.15599-1-yan.y.zhao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|MW4PR11MB6837:EE_
x-ms-office365-filtering-correlation-id: 5f4adc12-5168-4b45-e7e8-08df24c50a4b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|38070700021|56012099006|5023799004|4143699003|11063799006|6133799003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 1rw7Q9qMWtCqQoZVK0XbieGyRsc7M9/dTkZSF8UW/oj1vcdgEN84fhsY+fQ3GZdunurzzJunZ+Z8EYa0Hucz1rOnc8fjnqdbCirxmHklQ/dBe+YAvjr0vc59clAaqhPTOJiYWnn9duUQ0S7RQYpU9W4Wb+7Mpf6filFmRFgJCJgx3+f4YPMaiPP/6WTOeJpJGC/87dvqsnEMh9mO7PWbuzTMViq03A1fKRX1Pz8C+CdYoAvP5phqdUpHq0+7x11sew9jfWLB4NiJV+axL7UEqJhif1kVOdpxZCzfkPj2ekbFLvqCcylh2qkDmX9/LM6XMf6tWQKzMl35Z1LoNYuR1WbqPIvA9TTB0A3LuCs1ARP2gzBm3a1X1sAW6Z5+nfUoE0gLjOfOusTxFv1FW9gBTRMKhilSaAOtIwHcjwggCwafBpG4LL9XqcpOPReqCbwwQ/lgM71Zxbq6v6E2QMtjcsNhVcvIdceoM+g9iD1Y+8/G/+EYo2G8IaYczKLW5lDflQHlJ613Q5AKuKl9eLLB7mFCSiO5+wSvRZURFup0HKxT6gbBykCgrEhgmL5Qci1Zn7pGFhZiSezYo63lyh4+/BB44bqmv/sA8lw3DPTW/UJZWQFAOh5DADeVdW8h1FKvNsnnoRFlJk2MadUlyI2lDx3Na/ePEbRnbQknO+p+HsDK8JHFSVBncO3Z3kCjJxSK6hDINfF/M4FoR5F9mWgaygEiXNRfxAhN2hiAV0vNQ+c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(38070700021)(56012099006)(5023799004)(4143699003)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmo0ZElxOEdVSGIraVRHWFRrbHUwU3dEY29tc2wwelZJNFdzUThHMy9Qck1n?=
 =?utf-8?B?TUU3SUlUdzVuQVlHRXdWU09qaFR0Q1Z6YWpXTDVPMTdUNUo3aTl5d2hrOE9F?=
 =?utf-8?B?ZkM3aWpubTJoamNCZFB5NW5Nb0MxbUhqSGU2QVp6akZic3ZBdmxBYXNsbk91?=
 =?utf-8?B?TmxIZFZmcDIyYUFWTFpOYjFiV1BUSUtMT2JoSDN2b0dzZ0RQUVYzTFREdWdj?=
 =?utf-8?B?WTZweFNUWXArM00yOHhZbkkrbkNsQ3o4S2NPTWZFa0NiRXZ6MFZHS3lTYXBj?=
 =?utf-8?B?MHVVd3dFOW1GU1Z5THg5RnFTUGU5YUNGN2I2WHIvT0lTeVBOYlBYTUN5R1hz?=
 =?utf-8?B?VnN3aXdvSWpXUjRPbnFDdyt0ZmhWWENpZDV3N25MMWhxQzFMdUhGVW51dlV1?=
 =?utf-8?B?UkhWbHZXN2hRbGpDOWxTYnhobXNyNVdRc0F6aDZaREM4WkJiTktudDNvRGcr?=
 =?utf-8?B?TU1JeUtmVFBwRTM4VitwNkxjWWtaQUNwZHRWTTI0M0REenZiN0JvaFhZeDFH?=
 =?utf-8?B?Z2lzU1gzaFc1UWxDUkEyUHpROWk4L0lRRFVsRTNkcTlaRDFOdUkyT3NaS2c0?=
 =?utf-8?B?UFJna2JRdUw3V0drWGtwMWV5dUJiVitOMU9jR01pN3JZQUhMUmhaRjBzQXps?=
 =?utf-8?B?bE5VVHNUQ1p4UXE2ZUFoa1hMbHUwSG5tSlRLUjhDMk9OWFhqMVVjdEllNE1P?=
 =?utf-8?B?c0hyNHUyU3hucjQrL3BSZS8raHkzM3U5bml3NzlBeXlwVThYclF5eVdtSTJm?=
 =?utf-8?B?U09KQ21KNU92QXhRWm9FcnlMbWpWa25JcDVSMGN0cmhVN0RTRnNnRXB1eW03?=
 =?utf-8?B?RGxTUEY4U050ZGdMQlptQVlGT0x2YWRQSnJUYTNnay90dXEzdTdUN1FrbWxX?=
 =?utf-8?B?ak9nTi9jRTZCVnQzWnRocjdDUThtQXpwUnJkMFhmbVRNR2tiaUpaTE5WNjBB?=
 =?utf-8?B?d3hEcTZnbURuM0FrMVpLc3ZkTWhtei9FZFozdHZHYmRtajg3ZkJjdk9IdGl4?=
 =?utf-8?B?Umd5SXBRbHM0WFVZSk42VzRwQVRvS25jZS96MHJNeU1JV2Y4L2dBUzVtMlJU?=
 =?utf-8?B?enRHbXk5NUZZZFZSKzgrTlZCSEJxMjl1aWh2VmxPOHVoR1ZESTZWcXNvQ1ky?=
 =?utf-8?B?eWMwS3o2U2dhWTBYNzAwTnJUUVo5M05RU2VvKzZyRGVFdWJOc3NVQ0VqM01O?=
 =?utf-8?B?YUNtUlFDMmY2K05rZFRnYjNWMnlJNlhpV1dGVWZBVm1LRzhuKy90NDBMVFNH?=
 =?utf-8?B?VDVNbW9VRGE4OFJuSkZEbmNMclVqejJoNEN5dHVxL29oUkNhVGIzdS9CMWhC?=
 =?utf-8?B?cFhrbnpYS1ZhWVhzU0VPaTg1OGpON0M0M0NpMjZDWG5BMFVsdVRLSDUrLzAx?=
 =?utf-8?B?OHI2OStKU2pza0kvMHQxL28yaWJtNkwxeENHOC9qek5Pcjc3bVo0NWM5Q2d4?=
 =?utf-8?B?dzl0eGxQNVJhcytyRlJqWTVjWUZBdERpaU9kdGdqMFpVaDUyQnBOZll3aVBR?=
 =?utf-8?B?ZmxUUTJJdzdDWkdJOU5DT1BtbFdYQTRldVdMdGtpNEExQjRiWnlqNnRIdkNZ?=
 =?utf-8?B?ZC9QZDR1V3Q0WXNNeDBiTGJZelM5dmJoVVVUY0llMzhQOTVLdWFCVXUxMnM3?=
 =?utf-8?B?L25RUzJnc2hqdCtlcXNYSmlqbXExTlJZWDNWUFVyZEFSSnoxc0dKU0tWb3p6?=
 =?utf-8?B?c2FRa1BhN1NrRUl4RWxRMGhTRnRNK3BFY2tTTVl5RnJaZkd2SmFPZzhyKzZY?=
 =?utf-8?B?TTZwd1JLREJ2TnBwMFRSL3VQYi9mUDdCcXQ4dEVqaXRGcm5iMWxQejNCMHg1?=
 =?utf-8?B?V3FFZGFGTWNNZ0JXNTNOSWdYZmN2d0I4cHhnTDAxeU9Ma1IvaUZ6bkVKK0gy?=
 =?utf-8?B?NlpGTnUyWlF4OSt5NUp3YVNNbjU1MVZmRkt6UHRsRyt3WHFDVmNhdXUwR05L?=
 =?utf-8?B?d1M2N0YzcEhHUW4xNG5KWTBEbVlCcWsvRXhrclZ3TkpWdVZLbEhXM2xDYnRp?=
 =?utf-8?B?SFduZ21CVzZEeEptWTBYR1pnVUpuYzYxcWdWSWJDKzF2blJ3d1FRNkovaTZy?=
 =?utf-8?B?WGh2YnN4aS9sQkk4ZDJYTWFwTjhDQnFGcFh0MDhCbFNGc29MM0pwaDB3NU51?=
 =?utf-8?B?Rmk4TkhLbExJK2xZUnVJVWNHZHN3WXprUGVkZ2hzQXB3cGU4bjJyZnBVdk5G?=
 =?utf-8?B?QjJIN0FVMDIzWUdURHEybTJCT1VuT0RjU3l1VVFtSnczcDdOaVl3a3RlZFFh?=
 =?utf-8?B?NGY1L2cxOE1SWUVwWS94Y1U0a1BsL09aM2g1cStXNFN0VXJ3cDQrZjNDT2xs?=
 =?utf-8?B?blFhV0ZnLzlxT1FDdzNERFNvZmlCUEdVNVNhcjM1VWZUbit2dlg3Y2I0NGQv?=
 =?utf-8?Q?4gfMAuk+Jp81y8Qo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E13B2F0683A8D42B9C452DD9EFCC980@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OxULOSQP3XDaSBsngYJQZAobNTzWRNy2Zgor1iX4PKH2xayAG8p6hitdMDzK0WAGRpZcU3SPa5xzUA/z0kyLFlhNTUIpdqUheak0BmSglmURVpZzA2siPzmOgyhtib18JAnsvFZAHWEhxQfAK2jYCvSGhYCo8T8Gngvry8eE111bCsPiOtseyDM1/Qn/ORFWEgb8pmU1JLIrWxvqi71vFxkYcfMLcKoLTo6IjPuAHtetr4BWzKEWHv+Y9ctwsAi93JYNEJWdIFS/PkvuBtnsc2RlnOpIQTE08orSoBzduAimwpS9eJH6fJOnKZHQ4RMuS6bDHN85unSu3w/eBRXH7A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4adc12-5168-4b45-e7e8-08df24c50a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 22:48:00.9762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PGqZfgGRp70YF5evXJuZCg/T4MNoyWEz8T3A4se7MPOlc2vsswvZ7yRN9GH1lWHRZX4uElVEalPyJLOarnnoPYNiCniq+BZfmwTpBLycH1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6837
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDE3OjEwICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gS1ZN
IG5lZWRzIHRvIGFsbG9jYXRlIGVub3VnaCBEUEFNVCBwYWdlIHBhaXJzIGluIHRoZSBwYW10X2Nh
Y2hlIGZvcg0KPiBjb25zdW1wdGlvbiBieSBib3RoIHBhZ2UgdGFibGUgcGFnZXMgYW5kIGd1ZXN0
IHBhZ2VzLiBTaW5jZSB0aGUgRFBBTVQgcGFnZQ0KPiBwYWlyIGZvciB0aGUgUy1FUFQgcm9vdCBw
YWdlIGlzIGFscmVhZHkgYWxsb2NhdGVkIGR1cmluZyBURCBpbml0aWFsaXphdGlvbiwNCj4gdGhl
cmUgaXMgbm8gbmVlZCB0byBhbGxvY2F0ZSB0aGUgRFBBTVQgcGFnZSBwYWlyIGZvciB0aGUgUy1F
UFQgcm9vdCBwYWdlLg0KPiBUaGVyZWZvcmUsIHByZXZpb3VzbHkgdGhlIERQQU1UIHBhZ2UgcGFp
cnMgcmVxdWlyZWQgZXF1YWxzDQo+ICJtaW5fbnJfc3B0cyAtIDEgKyAxIi4NCj4gDQo+IFdoZW4g
c3BsaXR0aW5nIFMtRVBULCBtaW5fbnJfc3B0cyBkb2VzIG5vdCBpbmNsdWRlIHRoZSByb290IFNQ
VC4gU28sIGxpbWl0DQo+IHRoZSAtMSBjYWxjdWxhdGlvbiB0byB3aGVuIG1pbl9ucl9zcHRzIGVx
dWFscyByb290X2xldmVsLCB0aG91Z2ggdGhpcyB3aWxsDQo+IGNhdXNlIG9uZSBwYWlyIG92ZXIt
YWxsb2NhdGlvbiBpbiB0aGUgbm9ybWFsIHBhZ2UgZmF1bHQgcGF0aCBiZWNhdXNlDQo+IFBUNjRf
Uk9PVF9NQVhfTEVWRUwgaXMgYWx3YXlzIHBhc3NlZCBldmVuIHdoZW4gbGF1bmNoaW5nIGEgNC1s
ZXZlbCBURC4NCj4gDQo+IEFkZGl0aW9uYWxseSwgS1ZNIG1heSBuZWVkIHRvIHJldHJ5IHRkaF9t
ZW1fcGFnZV9kZW1vdGUoKSBhIHNlY29uZCB0aW1lLA0KPiBjYXVzaW5nIHRoZSBEUEFNVCBwYWdl
IHBhaXIgZm9yIHRoZSBndWVzdCBwcml2YXRlIHBhZ2VzIHRvIGJlIGRyYXduIGZyb20NCj4gdGhl
IHBhbXRfY2FjaGUgdHdpY2UgaW4gdGhlIHdvcnN0IGNhc2UuIFRoZXJlZm9yZSwgYWRkIGFuIGV4
dHJhICsxIHRvIGNvdmVyDQo+IHRoaXMgd29yc3QtY2FzZSBzY2VuYXJpby4NCj4gDQo+IFRoZSBz
bGlnaHQgb3Zlci1hbGxvY2F0aW9uIGlzIGFjY2VwdGFibGUgc2luY2UgS1ZNIGFscmVhZHkgcHJl
LWFsbG9jYXRlcw0KPiBtb3JlIHBhZ2VzIHRoYW4gbmVlZGVkIChlLmcuLCB3aGVuIG1hcHBpbmcg
aHVnZSBwYWdlcykgaW4gY2FzZSBvZiB0aGUNCj4gd29yc3QtY2FzZSBzY2VuYXJpby4NCg0KVGhp
cyBpcyBhc3N1bWVzIHdheSB0b28gbXVjaCBhYm91dCB0aGUgY2FsbGVycyBhbmQgd2F5IHRvbyBj
b252b2x1dGVkLiBUaGUNCmV4aXN0aW5nIGNvZGUgYWxyZWFkeSBkaWQgYnV0LCBub3cgdGhpcyBp
cyBqdXN0IHRvbyBmYXIuIFdlIG5lZWQgYW5vdGhlcg0Kc29sdXRpb24uDQoNClF1ZXN0aW9ucyBi
ZWxvdyBvbiB3aGF0IHRoYXQgbWlnaHQgYmUuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlhbiBa
aGFvIDx5YW4ueS56aGFvQGludGVsLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3g4Ni9rdm0vdm14L3Rk
eC5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
MiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2t2bS92bXgvdGR4LmMgYi9hcmNoL3g4Ni9rdm0vdm14L3RkeC5jDQo+IGluZGV4IDMxODZj
NDgwOGNhZS4uMzk3YTMwOGI4MzRjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rdm0vdm14L3Rk
eC5jDQo+ICsrKyBiL2FyY2gveDg2L2t2bS92bXgvdGR4LmMNCj4gQEAgLTE2MzAsMTYgKzE2MzAs
MzQgQEAgdm9pZCB0ZHhfbG9hZF9tbXVfcGdkKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgaHBhX3Qg
cm9vdF9ocGEsIGludCBwZ2RfbGV2ZWwpDQo+ICANCj4gIHN0YXRpYyBpbnQgdGR4X3RvcHVwX2V4
dGVybmFsX3BhbXRfY2FjaGUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBpbnQgbWluX25yX3NwdHMp
DQo+ICB7DQo+ICsJaW50IGRwYW10X3BhaXJzOw0KPiArDQo+ICAJaWYgKFdBUk5fT05fT05DRSgh
dmNwdSkpDQo+ICAJCXJldHVybiAtRUlPOw0KPiAgDQo+ICsJLyogRXhjbHVkZSB0aGUgcm9vdCBT
UFQsIGFzIGl0cyBEUEFNVCBwYWdlIHBhaXIgaXMgYWxyZWFkeSBpbnN0YWxsZWQgKi8NCj4gKwlp
ZiAobWluX25yX3NwdHMgPT0gdmNwdS0+a3ZtLT5hcmNoLm1pcnJvcl9yb290X2xldmVsKQ0KPiAr
CQltaW5fbnJfc3B0cyAtPSAxOw0KDQpPdmVyIGFsbG9jYXRpbmcgYSBiaXQgaXMgbm90IHRoZSBl
bmQgb2YgdGhlIHdvcmxkLi4uDQoNCj4gKw0KPiArCS8qDQo+ICsJICogRWFjaCBTLUVQVCBwYWdl
IHRhYmxlIHBhZ2UgKyA0S0IgZ3Vlc3QgcHJpdmF0ZSBwYWdlIG5lZWRzIGEgcGFpciBvZg0KPiAr
CSAqIERQQU1UIHBhZ2VzLg0KPiArCSAqLw0KPiArCWRwYW10X3BhaXJzID0gbWluX25yX3NwdHMg
KyAxOw0KPiArDQo+ICAJLyoNCj4gLQkgKiBNaW51cyBvbmUgcGFnZSB0byBleGNsdWRlIHRoZSBy
b290IFNQVCwgYnV0IHBsdXMgb25lIHBhZ2UgZm9yIGENCj4gLQkgKiBwb3NzaWJsZSA0S0IgcHJp
dmF0ZSBtYXBwaW5nLg0KPiArCSAqIEFmdGVyIGVhY2ggdG9wdXAsIEtWTSBtYXkgaW52b2tlIERF
TU9URSBhdCBtb3N0IHR3aWNlLg0KPiANCg0KV2h5IHR3aWNlPyBZb3UgbWVhbiB0aGUgQlVTWSBy
ZXRyeSBhdHRlbXB0LCByaWdodD8gSWYgeW91IGRvLCBjb3VsZG4ndCB3ZSBmaXgNCnRoaXMgcHJv
YmxlbSB3aXRoaW4gdGRoX21lbV9wYWdlX2RlbW90ZSgpPw0KDQo+ICBUaGUgZmlyc3QNCj4gKwkg
KiBERU1PVEUgaW52b2NhdGlvbiBkcmF3cyB0d28gcGFpcnMgb2YgcGFnZXMgZnJvbSB0aGUgY2Fj
aGU6IG9uZSBmb3INCj4gKwkgKiB0aGUgUy1FUFQgcGFnZSB0YWJsZSBwYWdlIGFuZCBvbmUgZm9y
IHRoZSBndWVzdCBwcml2YXRlIG1lbW9yeS4NCj4gKwkgKiBTaW5jZSB0aGVzZSBwYWdlcyBhcmUg
bm90IHJldHVybmVkIHRvIHRoZSBjYWNoZSwgdGhlIHNlY29uZCBERU1PVEUNCj4gKwkgKiBpbnZv
Y2F0aW9uIHN0aWxsIG5lZWRzIHRvIGNvbnN1bWUgb25lIGFkZGl0aW9uYWwgcGFpciBmb3IgdGhl
IGd1ZXN0DQo+ICsJICogcHJpdmF0ZSBtZW1vcnkgKHRoZSBwYWlyIGZvciB0aGUgUy1FUFQgcGFn
ZSB0YWJsZSBwYWdlIGlzIHJldXNlZCBmb3INCj4gKwkgKiB0aGUgMm5kIGludm9jYXRpb24pLg0K
PiANCj4gDQo+IA0KDQpBbm90aGVyIGlkZWEsIGNoYW5nZSB0aGUgb3AgdG8gYmU6DQppbnQgdG9w
dXBfZXh0ZXJuYWxfY2FjaGUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBib29sIHJvb3QsIGJvb2wg
cHJpdmF0ZV9wYWdlLA0KaW50IG1pbl9ucl9zcHRzKTsNCg0KTm9ybWFsIHRvcHVwIGNhbiBzZXQ6
DQpyb290PXRydWUNCnByaXZhdGVfcGFnZT10cnVlDQptaW5fbnJfc3B0cyA9IFBUNjRfUk9PVF9N
QVhfTEVWRUwgLSAxDQoNClRoZW4gd2UgY2FuIGNhbGN1bGF0ZSBleGFjdGx5IHdoYXQgd2UgbmVl
ZC4gQW5kIGV2ZW4gYmV0dGVyLCB0aGUgZXhpc3RpbmcgY29kZQ0Kd29uJ3QgbmVlIGEgY29tbWVu
dCB0byBleHBsYWluIHRoZSB3ZWlyZG5lc3MuDQoNCj4gIEluY3JlYXNlIHRoZSB0b3B1cCBjb3Vu
dCB0byBhY2NvdW50IGZvciB0aGlzDQo+ICsJICogd29yc3QtY2FzZSBzY2VuYXJpby4NCj4gIAkg
Ki8NCj4gLQltaW5fbnJfc3B0cyArPSAtMSArIDE7DQo+ICsJZHBhbXRfcGFpcnMgKz0gMTsNCj4g
IA0KPiAtCXJldHVybiB0ZHhfdG9wdXBfcGFtdF9jYWNoZSgmdG9fdGR4KHZjcHUpLT5wYW10X2Nh
Y2hlLCBtaW5fbnJfc3B0cyk7DQo+ICsJcmV0dXJuIHRkeF90b3B1cF9wYW10X2NhY2hlKCZ0b190
ZHgodmNwdSktPnBhbXRfY2FjaGUsIGRwYW10X3BhaXJzKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGlj
IGludCB0ZHhfbWVtX3BhZ2VfYWRkKHN0cnVjdCBrdm0gKmt2bSwgZ2ZuX3QgZ2ZuLCBlbnVtIHBn
X2xldmVsIGxldmVsLA0KDQo=
