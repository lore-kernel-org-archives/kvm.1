Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DE0388384;
	Wed,  8 Jul 2026 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783543810; cv=fail; b=ada6Hv+fdG0oYNcXirW9D5o/5cQ9M/QTMuJTK48PZEcAEOeLReix1+5PQlvigqQFx7oOO/0hy/B+NtTKEc1ynhZX3Csj/05g35gR2QzLpoVizv+xvqPOz/fDxmP3vNFP3KBGmG9h+CGK7YOkqNt5jDgsLTVuEtZONUjt8eNUnXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783543810; c=relaxed/simple;
	bh=eMHnK2fdTJ7xeD0OODy+S0l5TBglLxvtpLoHGndd89s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JDWxg9fWcOBhymjrOXBbGx+1sKYs1wIaxB+t0APudDG3P/CHZ7OTUkwa9yflOvwHp8Y36JQDtfU0DDndRyMvc/VK90CXPkz5xVlsXOpN5t1dMFq5Yz4yi6bhJzr0C6fGhI/W2HOn8fZIoQYBimrrMNGbFPzdq3aTAgX+wuvDn1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fhhdfARd; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fhhdfARd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783543808; x=1815079808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eMHnK2fdTJ7xeD0OODy+S0l5TBglLxvtpLoHGndd89s=;
  b=fhhdfARd29m1rl8NUcYXLHgkvUBcidCPggXqw2xniimVA9BZZu289pt7
   PEUZ6fsAgv/b+ELoOi8YRSv/w5Rm98lOUo73J9X+i27nVaoHkbE/58S7W
   YjsCWkbEDAB+6o4guVsvGKi/rXPHyteUCaa/3uJAgrDdtQXYvrpjmJR+0
   DzNEYR2Dd3GVEZHV0Qfr/Bnqc6iFJX9osawt9j+K5flun7gjA0aY9ZCVf
   vrgukd+7fh+o7N79SBhMRLZMVbMf4cgM4LhV0y95NSKXWBCPuGfUZwdmj
   m7nE8Yicv6fzENu0N21A+uWkFKlCu6PjN+RZkmmcOzF2v6NAsCqaPguxu
   g==;
X-CSE-ConnectionGUID: ScnGXSQkQemOVV9YdYJKUA==
X-CSE-MsgGUID: PC2Ppo6LQtSRSmc+WDVJow==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95594884"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95594884"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 13:50:07 -0700
X-CSE-ConnectionGUID: gj/2VEl1QaKu4Yfzm840pQ==
X-CSE-MsgGUID: cvCmB/JJTQmDK4OT521Zyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="249971926"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 13:50:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 13:50:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 13:50:06 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 13:50:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUofdSUZ17jOrSckaQSCv+kCDCuGpf0hh3mq5ymb1cTFSW3PhR4eqZo2i2/DIB9bV3MN9chyM3ZQzkoiMTyJyVeY0yczfM25cz4urRmjYNvPsKSnWhKuOdHBsCtktfALMvs3pmIYvKD45SUWrMgO+It1Q2URuHfFWwkB8THwoapzk4NAEaa3S8ukvri9yYr18IQa6rOjGN74tzQYdWBqfF/7C11EaWYO1FDbMpptX3CvdjDngzjDpyho1meoigaiymy/k0j2vioFoOoRUu7cV3ZO2gGUiQfGUykbjV9KM8HOb1yxgkwcibEVtjCPsjfI0lgQLPsZO4/+95pgZ5Id/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMHnK2fdTJ7xeD0OODy+S0l5TBglLxvtpLoHGndd89s=;
 b=QMixsDoEwS1K/RaZJvYYpS4D+pEMb4yxV41nEokoDmeRys28s8YhozJRxSuqlhEuL+x5X6XfP9qUrXKCo5DB3/Jgr9XgqrYevOCkl8p4H+1SocvFHK/YrTXm54N1hVCrStCJChhwYbIZiBNoU+I1fPIUOkUcVd8gWLoFqWjJpnfLA/IDqWgYp/9jFA6P2SiZqoELwYyOBXveIjFGJ5ht1c/S1f1nzJm2TYxmn+KaeXYd9OD4Q7VkC8iqtWC4iE/M668yo64AcpQxfvWXtSmMaYEQkHLYYC2i81vemBhoCEKGgXQpfc4NTLcZTp+npfwYbkLxPp47zT//9rGTf9LA6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SJ0PR11MB4894.namprd11.prod.outlook.com (2603:10b6:a03:2d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 20:50:04 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 20:50:04 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "tglx@kernel.org" <tglx@kernel.org>, "Mehta,
 Sohil" <sohil.mehta@intel.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v6 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Thread-Topic: [PATCH v6 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Thread-Index: AQHc7LhSIZlCRlcQpE6fbqoCJ0ANmLZjDbSAgAAVzgCAAADYgIAAF9sAgAEhDAA=
Date: Wed, 8 Jul 2026 20:50:03 +0000
Message-ID: <64f1cebe15f013fb8ca11c8133d416e97c2ba001.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-3-rick.p.edgecombe@intel.com>
	 <efbff823-7b4e-4349-bdc4-72a244699d76@intel.com>
	 <a724bce3e92e8a8dfb04798bc21860ba9be786d9.camel@intel.com>
	 <818e0de368588836810718106e3b592323aaa0f1.camel@intel.com>
	 <a058a3e9-711b-4034-b9a6-28444aef3b5a@intel.com>
In-Reply-To: <a058a3e9-711b-4034-b9a6-28444aef3b5a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SJ0PR11MB4894:EE_
x-ms-office365-filtering-correlation-id: e97346ee-e4ee-4134-3b29-08dedd327c80
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|4143699003|56012099006|11063799006|22082099003|18002099003|6133799003|38070700021|921020;
x-microsoft-antispam-message-info: TA/+F7qYiNX64xaEZz7T4wEZ2JdaaaWLlKvlc5cnUV+PCW1J5wrmnrEI1RwYc1TFtCRRRLq7j416fOa356rsJG5GAIIGTXq+f67cKfH6mR7HJDb5N3krPaDoXd0zIHnwMz8r/gp+b400ahHrczyCqXlxy0r03htTivY812vSqjz9ZUKwotfGEUZMYBf8UQDg42p8CSfWrsEtzTiNKyPi3z25cqtook1GA8qAxNER/xGoHNRHqIfRgx6cPl/TnEad/f/iGnzGr/JTsW+jCqLu5nKRpwoxy0BxZV9p58kLOsThzQAcBcUksEIHZU49Emn3jvBONYwFZyBQo0D4DYuN7WJvkjcMCfEC6hIOqfygFpCDNocf5xOX9l6TRpOY70AsG8H4C8rT+OTtp25MDDYSrfDnU73JliNjYWyMQX5TrwQLn24aCtXe+9QjSxBVLoHV5gfGWX2fImh2XJzSpW5ZUR1iHWfSurDwkIbNo9HpCO1ml2BRornAr+EJPe5Z4vpjeDdqk2CLLx1VadHLUDnUMdtvTyIit1nH57C3E+GjnQP0EQHsNaqzi/36SuvEggQZozoxKf/MuaSVGe2BH4SUp0pvdjm3XDUkbfLr/UsQDl2x3SSDmoVlLtO/QJubJjUL5OSytquGvlZjmvKAZ+1XAomcYbnZuepRrZSpy25fibgj/I+3pLfvottScdOnt+0GfKec31itAcKVcCcd1S2NPQmp2P5hj3oJvrV5cuMC5Fk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFByU1RZWHN4V2IwMmdDUXFCOGo5Zmc2SHlKdDNBMVZzQmh0OWZOYXcrSXhP?=
 =?utf-8?B?SG9ZVnZQclg3aFBNa0F5dEMxNktXZ3NxUWlUV3pzQzE3emY5TTdxbmc0eUVy?=
 =?utf-8?B?MlNjcm96akhQNDlBR25qbktpNGlzOUw1K2ozNzFzcmR2SkppeEpaZG5TbjBm?=
 =?utf-8?B?VHhDZkswaXJmUW9saWhkclYrY1hqMXk2KzkwWkFEUkY1Z21JWElDeEs5SFlR?=
 =?utf-8?B?WVJkK0drK1FGR0svdjQ3bEoyWUpQQmtkVTQ0N253eG1MU2JmVGZXdHozOWlq?=
 =?utf-8?B?cStaOFQxeVl6QUloQjl1elVTVHlnblRtb2xmOWZ1WXBCVHNZYVNQQUJjVmdF?=
 =?utf-8?B?RDhFTG1uZDA5ZmhkRnh6Q2Z3eUdSQ1IyQnlSYzZlWnNZOVJQZmFGbG0rUXp5?=
 =?utf-8?B?QnJxZEtOUXE4RjJ2MWd0SElTeXl6NHFvUHBiRFpmN29LYk5UNzZERDZML0FQ?=
 =?utf-8?B?cUVtVFA3OXVkdVBlZ2hBNEIzakp4QkpneEluSS9VazA0cHhnRkIzTm9FS0NE?=
 =?utf-8?B?OElhWm5yN1JacU5oWnVEeUpBZk1ZS3dLbE1MWm5aWWdyNmFRTWwrV3pNVGRU?=
 =?utf-8?B?dGF1N0lZQktyQytmbWVrVC93aHI0LzIyNDY4MnljdHV1ZUpMc2loTTF1NGdM?=
 =?utf-8?B?VWNiZ2tqdzFNcEJ2SFJuRkJvYmNES1BNdUVoSGlDUUxFTGNFWGRtNmJQVTdu?=
 =?utf-8?B?ZlJ2VUNVNTByaDFQRzRyTllTN2RaVzJqdk5Ldm9mUk03cFhmY3B1SWdWeWVN?=
 =?utf-8?B?Vy9lNVVoTk9NYVJFNWhnbmU4clNpeW9sMDg1SCtJNS9ja3NyM21JMzFUME5q?=
 =?utf-8?B?d3d2bnk3QncvUHRPbEdSRUxMb3djTS9uOTNKTmJNR2pHMkZsSm9BdjByUUY1?=
 =?utf-8?B?MVRvK2xSZ1VwTEVOcWtzNHJ1RHd2M2prTTlPTzYzeEsvLzl4dDdwVzAwMS9V?=
 =?utf-8?B?THp2alJhTG0rMElzVHZyd1lZQUJpMVE3b3NYOGg2aVZldjFtSUVPSFNXYTFP?=
 =?utf-8?B?eU5Nd1F2MFNMMzROYjZjd1pDM0xPT2tzVzlHR1dDby9DWVVNcW1LRmdwWnlJ?=
 =?utf-8?B?R0JSYzIwb09YNWRkcldQRnVLM0RFdnYvRXdyRUYrZDdWMkNRRnhtdVVQbC94?=
 =?utf-8?B?bTF6eHNta0lzWTJWWFJDMUlEaEwrV1VzV3F5SFJvU3RZTDdDR3hKUGQwMTNP?=
 =?utf-8?B?bDFoK0o3QVNvbTQ5STNUTWxodFJyYmhJZHF2emdPUnM2YUR2WE05ZlY3Sk9M?=
 =?utf-8?B?RDM2QVg5bkJjVllSOUFQZnRsaG40SnkrdE9GUm5HVVZFampZRDdzSkJ2V0Zp?=
 =?utf-8?B?RXh4WVlNZC90aS9zMGJ1ZmluaVBWMGN6c0pYeHo5ZWIxVXBxckRpODdHNEM2?=
 =?utf-8?B?OEprSGdacGtoTGlNRTVkeU84K0pZTlZYeEd3N2ZaN0YzN2lPQjRKcWxpVDRl?=
 =?utf-8?B?UjQ4OWxWRENuTjFWaVZOdHIwdUkrVXhlbHVDLzRBcTBFVTE2Y2M2Zy9zSmM3?=
 =?utf-8?B?Q3VhRjdPREhENnUvbGFWWjN6NFlVRWFxbm5FTFNmcTRub1hkSlpRMm5USmp1?=
 =?utf-8?B?R2k5aW5wbGwrVFVBbHgxQ1d0Nkp5L1hZY3ZOUkJYK1VSN3hKMVlTOUsvcFpQ?=
 =?utf-8?B?Y2h4QUJaNWpwZzVVL3VrdFRzVkJlZE14L0xNT2ZSc2dhNEpSUm9TYXVYSUJk?=
 =?utf-8?B?UE9ESDRRSm9Fd0dSYzVOejl0YTgxMlpOQ0t4aXZsUEJxZ252eG00L05nVitj?=
 =?utf-8?B?aEtiQ25tMlpmaWI4NWVPay9NUzZNZVU2NDNxZml0bzNPR3dLeUdkRWphL3VK?=
 =?utf-8?B?Y3VUcDhUSEk4djE4Q21jWGhQeFhXc01XR1N0ZUdtWElLdkdVWTJQMEdObTA2?=
 =?utf-8?B?Nk50V2U3SWpzTFRLcmoxZ25JcHJHOG4xY3hocW5paGVDSEZ5aGh6N0ZHUVI3?=
 =?utf-8?B?SVZHUWQ2aTNqQVlZNVl3aFVad0VpMlV0ODVGSndMQlpNaEdRRmh0UkxuMHl2?=
 =?utf-8?B?V2dJSWcwMVF5SFpaOFdvbVdhaGhqQmVYYlB0NGtFazc1ZE1IZXlZUTRISFY3?=
 =?utf-8?B?dTJCVzZiNjAzS3VDcDJzNnhKNHV2eHlJcitHL2FraW04UTc3TEdDeTRjcVpv?=
 =?utf-8?B?UUtocStiRVBYZEt3djd0eUZUNmFTYkVxcmx0WDB1V0NUZ3RnNG9hQThzQVpH?=
 =?utf-8?B?VTBnVm9SdUtUanhyaGxaUHJOSnBMZjZQNWtSZVNVSG9TcENRY2FzN3F6bENJ?=
 =?utf-8?B?WURMdUFWL3pQWjBPMnFPczNEbWRRRVpZQzNCNmVITXUxTDNIdXJZaXU3ZzJH?=
 =?utf-8?B?L3dxWHRMNWx3VjUvRDFhVWJEV2VPVEovUkowLzU3WFBYd2VMQlV2TmJXR0lo?=
 =?utf-8?Q?gfqSAZ8chy/kBnG8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2453819C19FCB84A991DAC1721C3FA2A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pxJKD3zIO0+Q6SZ6utIt35Mwd0Fwy5jphrQhPwmr6FPXBqvvY4sFMuj4QiKE0T8hGXwWR/ta/R632EyhN86ABT0YHCkOkF3qPzm6G+k5FqIxaFA28+Ioy28OmTKkhwQ4Os255PEJW76o9BIB4Ofp14/Q+oxK+pm3OLmlBuFaT/jAb70TNqzJUUc8ts6jIbphl6XtrjToTfoCMIs5sOPzJVo9WSBek6A/NSbbStNOboVYhxqU4RKtVyl4PcDMlcsQ79TV1wXOfaCe4gVVKgGEjm4FIiERdKMjRuCr3TYCsVCpu5LnWZubah8MEeFMEs85ERr+5Eood2dC+bXwpoOgYw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97346ee-e4ee-4134-3b29-08dedd327c80
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 20:50:03.9331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1O/E+8FbGcrxvEPy0eiCCMDt6XSJGDo1SB1MsPO6HsvdP+KuXVLSA9NBBwznOH9Jn0endLJ2S5PwNW7Osls7KsoEmzsViajzkSlUN4rVr/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4894
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTA3IGF0IDIwOjM1IC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
PiBJdCB3aHktaWZ5cyB0aGUgY29tbWVudCBtb3JlLCBidXQgb25seSBnZW50bHkgbW92ZXMgZnJv
bSB0aGUgYXV0by1nZW5lcmF0ZWQNCj4gPiBwYXR0ZXJucy4NCj4gDQo+IFN1cmUsIHRoYXQncyBm
aW5lIGlmIHlvdSB3YW50IHRvIGNvbnRpbnVlIHRoZSBzdHlsZSBpbiB0aGlzIGZpbGUuDQo+IA0K
PiBCVFcsIGRvIHlvdSBhbHNvIHdhbnQgdG8gY2xhcmlmeSB3aHkgd2UgZmFpbCB0aGUgaW5pdCBp
Zg0KPiBnZXRfdGR4X3N5c19pbmZvX3RkbXJfZHBhbXQoKSBmYWlscz8NCj4gDQo+IElzIGl0IGJl
Y2F1c2U6DQo+IA0KPiBJZiByZWFkaW5nIHRoZSBEUEFNVCBtZXRhZGF0YSBmYWlscywgc29tZXRo
aW5nIGlzIHJlYWxseSB3cm9uZyB3aXRoIHRoZQ0KPiBURFggbW9kdWxlLiBJdCBpcyBiZXR0ZXIg
dG8gZmFpbCB0aGUgaW5pdGlhbGl6YXRpb24gaW4gdGhhdCBjYXNlLg0KDQpUaGUgcmVhc29uIHdo
eSBpdCBkb2Vzbid0IHRyeSB0byBoYW5kbGUgaXQgYnkgZmFsbGluZyBiYWNrIHRvIG5vcm1hbCBQ
QU1UIGlzDQpqdXN0IHRvIHJlZHVjZSBjb21wbGV4aXR5LiBJdCdzIG5vdCB0byBwcm90ZWN0IHRo
ZSBrZXJuZWwgb3IgYW55dGhpbmcuDQpTdXBwb3J0aW5nIGJyb2tlbiBURFggbW9kdWxlcyBpcyBq
dXN0IG5vdCB3b3J0aCB0aGUgZXh0cmEgcG9zc2libGUgc3RhdGVzIHdlJ2QNCmhhdmUgdG8gY29u
c2lkZXIuDQoNCkkgdHdlYWtlZCBpdCBsaWtlIHRoaXMsIHNlZW0gcmVhc29uYWJsZT8NCg0KCS8q
DQoJICogVGhlIGtlcm5lbCBzdXBwb3J0cyB1c2luZyBURFggd2l0aG91dCBEeW5hbWljIFBBTVQs
IHNvDQoJICogYXZvaWQgcmVwb3J0aW5nIGZhaWx1cmUgaWYgaXQncyBub3Qgc3VwcG9ydGVkLiBE
b24ndCB0cnkNCgkgKiB0byBzdXBwb3J0IGJ1Z2d5IFREWCBtb2R1bGVzIHRoYXQgYWR2ZXJ0aXNl
IGR5bmFtaWMgUEFNVA0KCSAqIGJ1dCBkb24ndCBleHBvc2UgdGhlIG1ldGFkYXRhLg0KCSAqLw0K
