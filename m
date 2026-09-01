Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293D948A2CC;
	Tue,  1 Sep 2026 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284513; cv=fail; b=IGfOj1gCNNroskazno7NXueEPUow+XTXY6102pjfEXOoKFrt/lGlVVtfUI0niJqcRgCdvs/c4XbIGc0qwWc4Bt0DBZqav9F1xxWeCuVhalRWwvF8XdeVbrvRKzxOlyPfoNAloGVdFeZrj6xUN2v2mhfQQamSzWZruuecmhcE1DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284513; c=relaxed/simple;
	bh=4XXbjYX2k/bdMnFlEzJdRqzLSxR6BYHKcfLZavcr1ik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OvplOr04tvyWHEHU/9/mLoGk/qmUOz2ZLe8MTQOj39j/WbImCNE/tjKFUnax6po0OycjF5SXXLyH9cmTvypNlBb0ckM+pOJ0CJYQb5GqotJRsFq/emSREeri129eR4JmuAe2QeS9maag0tR5xSikRLzmXjttj/e3MBawBD1W5ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VhCWLgdO; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VhCWLgdO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788284511; x=1819820511;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4XXbjYX2k/bdMnFlEzJdRqzLSxR6BYHKcfLZavcr1ik=;
  b=VhCWLgdOyTt9cM9a/l7SPr85Mmwpu44fuJNIlsFsr34XzhsVEQqHerD6
   2mhUe3OGf9EPEM8LNjBJsV6LGE6M8fGXHdBlVW6mokLqKWWVaHBedsKWd
   AxFncDRZZ7KLy/Pn6G6iLy2B9gGOfJVpovvKEKfGrriYMGnvsHvIZqh6A
   jR7+SlCM/0ng9q6YhB6tL7iWMxFyPXY+e8Z1YFzQGhw15V5tqcroSNw07
   YOtHgfFEGWq/aPUXgNkxgCM9oquJ/Tv7zyiSfNwd00zoZCxG769s2EynY
   VswwEfEKEr6yHwFwXL8gp+a3b5+eR7TbWCfI/Ph7Mci0PVs7GxPglLa4k
   Q==;
X-CSE-ConnectionGUID: d4NX2wSARCCqT/dHD+1wSw==
X-CSE-MsgGUID: Plzs0nnSTGShXwBT8m+7EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88487111"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="88487111"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 10:41:51 -0700
X-CSE-ConnectionGUID: xTkQRBiyReaO2g5rZ1Kl1A==
X-CSE-MsgGUID: FYuNyOQgRzeJx3gVebGppA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="272664925"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 10:41:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 10:41:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 10:41:50 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 10:41:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEXK/Xz9bAFvVyYDasu4xyI4WJLwjP+Z3mwQqyjys+g/RC6QE0wfOpJrlT7XtyuSuOM3WfD5GZOVcOtxPODwqkEOybvA3WSaUyPVeArFneEyjCeMvy4y8fjsoyR2EZUNrlDI4JmPNHnilLwavHV7IJtqEw2SDhUPEmje0s08le9PEOUwUHXOZAsZsn5irRPUYzS6lp1/zkUTnNreSYg76v9GHEzapYx74Cv1UumCanJckja08Eo+KCumaFRZb7KPmPLD6zY21062o7vVg+WZ3o4YH+KKlIDqqsrlQGSjEyt5HMzuoP7lRRlFl502cPKEsRZo32sz7sg/BYmUOCNwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XXbjYX2k/bdMnFlEzJdRqzLSxR6BYHKcfLZavcr1ik=;
 b=ayHwugxfRjvFIT+RcNQ3rFhJ/vxE1lEeAzvJCbw9mdV4NiSSrijFlGNYWljitwmjs1dNR1RITagn6at7cr5fBlsdPWkC2kMaHX85GDPSxtnkzJid94oTIFUph9wiEqpCgALDFlHQVq1UNwjC1Ol4/CoISuarxFXoDe/WB2y4s9YirBFtBsuJD5O4VXRVTLAH3quuqdjJRT3ZvznfMxshhHTZMCFW9K225JK+fPUDQOXoX1AZT6pEaLTgwZC8WumlsJBnkUCocKGmatkGbLnsJ/7Os8st+RnNon/Zpv/AoICMX7c46I/pWpqpjc6DW0MJXLaN9Oew+z8hyGnhYkAkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB6943.namprd11.prod.outlook.com (2603:10b6:806:2bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 17:41:42 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 17:41:42 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
CC: "nik.borisov@suse.com" <nik.borisov@suse.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "Gao, Chao" <chao.gao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
Thread-Topic: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
Thread-Index: AQHdNdIhqH6lArRWVEmiaZbi1C7mgLaySiAAgACCPACABrNBAIAAhwqA
Date: Tue, 1 Sep 2026 17:41:42 +0000
Message-ID: <69c42183261acb4150961cabf6318b92765b6562.camel@intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
	 <e2f8f7976ac6a54e0bbda0e65ed9990940d9fef3.camel@intel.com>
	 <d2efe512-e4fe-407f-96a8-b274fef23382@linux.intel.com>
	 <6f8f2c59-3336-4ed8-837f-57cb706ece30@intel.com>
In-Reply-To: <6f8f2c59-3336-4ed8-837f-57cb706ece30@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB6943:EE_
x-ms-office365-filtering-correlation-id: 99af9508-1a17-4e7e-9f28-08df08504925
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10063799003|18002099003|22082099003|56012099006|38070700021|6133799003|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: OwLYUqfFn5B8kBcdJ1POp099BFMpHrSNPeD+QuLkWaMIjOTTNhy/Doq0Aprf9NvCf9rAZGvCmgSAfp7INiD4L3HusxQ5WDVpKnXTa+dUtVOFrpSGGsvNMkiMh3p7t9cH1KmXS+QN19NVbv2NaUhyPVQASiSuGxiqdjyQEDqFcS07/5QiLB81EUfUqbkVTyp5o7RKgVruS1oCBWT2bVloVfBbCRGBDwIzKb5sT0vHHmPrMRl9ywhgpuDMHC20WCgSbPjkiToNhjeyOnCREN5KIMXlLYz8Q3itcdt0SmhNeZw7ZCQrwc3kxmh8LpN3iXjVxSP/Y5V7MI7RxbgORzSxJ9Znkz7/0cq3eIinqAlx2OlHtHgCO/ECibO600zwPxWsTFM4dNwOiQtf0ejUJdYxy9HNtzUv7sswbNfNyLzqx/xAdrKfS8Uu3+14HkkS+uchtwO2fapElWQm3QG2EZRe4zwYPlpAHnsnIPesiQzXuovBdRVhvbyFpg163o4LTrMGcyrhE6QfeRisIV8cJrnBZM2zhaQVYEnXdSKdwh9tPWpgDN9HBbjSGYp/eiLONx6jJqiX3gdu+97ztgzTUgd7Adtu6eCi3qMdQbfeOkZ+jZaefoyM6C5mNvB0FXxoHBTCVP5L/LtNBBj69nnspPq942//AHG0adxZMlRWjvDrEloJLqNYphChTuB5rmv6nKWiPk85bGoPehBmT+g0bbcgzwSAV83j+9e7eww2Q9slpVU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10063799003)(18002099003)(22082099003)(56012099006)(38070700021)(6133799003)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHVxbUhrWnBBQUNLY1B0V0VBRnBVM294OTIvNVlLbTBZL2hlWHY0UTZOSGZ1?=
 =?utf-8?B?dU80M1ZMS3ZUVkkreHlnWjVRNTVxS2ppV3g5S0ZBK2VvZ0N5UXYwK2RhRy81?=
 =?utf-8?B?Z2YyNmZEdHl1NGRqMVAwVW8wQThoSk1abUY4cFYrZHBlV2lpbVJCTFRDc09B?=
 =?utf-8?B?eXVYVkE0SDVEclkxSmx3R1U0aUY2RzRpdm9WbTdVblMxTHprT1kvaUQ3VTAw?=
 =?utf-8?B?c0Z4UEhYRmpsa3JuSzI0V1BoTFZBT3NrdlZ0OFVIcUV1a0NJbW80SXBFT2d4?=
 =?utf-8?B?T0pMek50c2JxVGVyMEVjbWNuZ2FVd1ZqcXUwSHdkYUZrWkhRYVFDMGhnZTE5?=
 =?utf-8?B?OHJLRkFnTkJZdXF4WUFMNFMrVWF5T1ZlZzd1dGJvZ3FQRXJsdXRyMnF5TTFh?=
 =?utf-8?B?ODN2Vm1PNDBUT2tHeXNmcm14dVRWd1VmRzJDdEFGK0xRQmFtUnBsWXVmQU5y?=
 =?utf-8?B?NEdDNEo3Rnpmd3JTVWlEU3c0a24wOEhmOWJFWkxkVHB5VzlZc3hBSkxVY04r?=
 =?utf-8?B?OUpZYmo3TXlqUmpIUHo3QVY1Q25VOTFURW1uSWx6ZVJYd2x6Rm5zelJSbjZH?=
 =?utf-8?B?M1VDeDVkQWRRclA5ZUFKMEFxQXdmOGxYRTBPUVZpOXZDMmZpbFd2dUNpRjQx?=
 =?utf-8?B?NlB4SEl3QkFqVElZVll3Wi9tQUk5bytHTk5rWi9kN0gxREpFNjFJVVNheU45?=
 =?utf-8?B?OVBNUXNXalVvT0Z5a1lZb0NWZFZaNU9kRE9FMWJtSE41a2Zyb0tDMGF5Ulk1?=
 =?utf-8?B?NWsxR1k5UnpOeUhWYk5rYW5qNWpuWFdjMlVMV3hVUjVhUWlJL3BJekpIdVdF?=
 =?utf-8?B?UEh6Rjk5N1o0QmxBVy9jTjAvUnlSMHRUYnNVdk8rMHZJSTAzWW84Y2tZckNi?=
 =?utf-8?B?NEZWeGhma2JodDlmbVQ2Y29YMzBvNmxJSVk3VWYzZjcwNzFQNlFtOFBUVVhJ?=
 =?utf-8?B?aDcvZzRoYkd2SEh6eUdjV0cvdVg4OEVMSHNWN1BLYU54R2lFeFFtS2dOWHRl?=
 =?utf-8?B?amNTZVNmUzZrZXJMd3BreEo3RVlIc21Lc0JadDU5NGppb1RaOHpVaXJyOTB2?=
 =?utf-8?B?eWVHSEtXSjR5RGZQOGZmd2RSNVFrU25YRU05YmNzNktIQ1hCNmp6d3k0ZGhU?=
 =?utf-8?B?b2hyUnQwS3VtSnhYUDc5WmJKcUc5ZmEyTytUR3lZak05Ui9UZWJQSEE2eG1X?=
 =?utf-8?B?SEZyaW9kUGhSV0FteFl3SWliN01hZ0hJZ09CQXpNTlhuWmhGSWUxWlNFSmhU?=
 =?utf-8?B?ejJOU1RPUmxURlV2RmllSUJDOU5DVVJGQmUxcDRKRlNwV0F0NjZoQzFqN2tI?=
 =?utf-8?B?TkhvYm5IOUVWQWZaQ2IwaU00dzgzcEpINk1hWWZmWVdGUHl3TGtSdkY3dmxX?=
 =?utf-8?B?YnhkMlRzSGZacTFZRnN4bWlMdFFKOU1JMnpPU20zTzFQbEtwMy84Z0N6VzBj?=
 =?utf-8?B?NGtNbXUydkt0VHVOQXJablh0ZW15NWN5WUU4Vk43dnJaSldUUFovZ1RRd3Z0?=
 =?utf-8?B?VEFZbzdCY2xZOGtTQ2pvazhITHdZcUgvdW1vcENQMjJyK3M3R2QwSXp2bm1k?=
 =?utf-8?B?Q0xBdFFZSzVRKzBtWGNteHVqYWIrcEt2MlVkQ0F0RXFWVmhlT2JnMGlqbWdX?=
 =?utf-8?B?WTRxOVdBYnlkb3laUHVwUkJpemlQRDJMVmN2cnJYWVFTbVBuV1RoM3J0TnVT?=
 =?utf-8?B?blg2bFk0NmxOVHNYZGRVUkIwak0wSDUxOStLTFNoMnZMaDBYQzdtYzBPeTdN?=
 =?utf-8?B?SE5seFNlN3gzMXRKUkZtV2ZDeDY3UGZFL2hjaDBWZmNkL280dHpZN2dMOHJt?=
 =?utf-8?B?aVp5WlhUNHF6NDhLdmxSTnkxNU40dWtVeUlqcVBaS0ZIYnp2d3pXNXM1bjhI?=
 =?utf-8?B?UjJ5eXV6WTlCOU1WeWNqRmN3bGluTGI1SDlYcmltOC80eTNzN2Qyb1RQT3hI?=
 =?utf-8?B?T0NJcmZwR2VLRXJOWGRoTjJDa1FnRURnaFJBOURZY2hzejgyWS93ZHYxU09J?=
 =?utf-8?B?bU85YjhIVzZsbFp1c2R1U0xjK1FqRzh0MVZCR0RHZUppakYxencvWjhsZ05H?=
 =?utf-8?B?YkYwRTdoUVJlM0U5bnVFWDYrUmhoRHgwYkE4WVdvaStlVEo1VkIxYnZKeWNB?=
 =?utf-8?B?Q24xLy9ZUXZGRGNIbk0ycVhZSmw3RzVZYnZzdjR4bHBqVk5JZ3FydWZxQm02?=
 =?utf-8?B?QTNiaVc1WmNJZGszRWo4T3dmSGdBcUxkZHlOWHRSU0F1VWtyQ2hTMG5yV3VG?=
 =?utf-8?B?aEZPYzdQQ3RHSURNS2FTd0JnSFFvcHg0Mk1DK0ZJbU9JSWtyUzhva1VxWjA3?=
 =?utf-8?B?bitzc05MU05kYXZjeWxKZmwwdnU0MWM5L2ZuME91MThGV1VhSEVPb3VwRDA1?=
 =?utf-8?Q?KgHH6DUxsfwgrcIU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C52385E4FEA4054C9CCAD957BF2EE7D9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2LIykJT+tjbcvjzSmstrfWb4RRQ8jd88EKiZgsuMy2GYaPMwcC8qYOD6ljbmZ3al8onUaF6PXAdcyIpsyg5hJCX9gGPrsLIZYA6YXZFVsZMQR+/dIgJN+Tc0/ClWzb4nr5VZ9ohTT3Gmgt0yV9z9FvnhalGOVHaZQB+rr2EgmGS9fFqbOJvO/qnckjfHCMa9pY7yV0IIBPkyOrWgiMUIewpQryjdGWu8VXinhMOszVFZv8/WId83lMtMPPFPiRvr6tKCSUXlSAfYLqDhaWGQJb27jwag6g8CuaKSV9sW7ptX98nkL73zn37Qg9EkERfzMotnVjpfaI2nluy8JTMSSg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99af9508-1a17-4e7e-9f28-08df08504925
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 17:41:42.6389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +dm4dZYSu5ptV5etq6+YYmn2lov8YqbAoPkDLRcfmuesS03yAp4fRwe/RDyt11X42QYRaUXPR7mfcQi3C5dH5aEajH6jGk2TL/hgpsyd7Jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6943
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTAxIGF0IDE3OjM4ICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiA+
ID4gSWRlYWxseSB0aGUgVERYIHNhdmUvcmVzdG9yZSB3b3VsZCBzaGFyZSBjb2RlIHdpdGggbm9y
bWFsIFZNcy4gT24gdGhlDQo+ID4gPiBvdGhlciBoYW5kIGlmIHdlIGRvbid0IHNoYXJlIGVudGVy
L2V4aXQgcGF0aHMgc3VmZmljaWVudGx5LCB3ZSBtYXkgbmVlZCB0bw0KPiA+ID4gZHVwbGljYXRl
IHNvbWUgc2F2ZS9yZXN0b3JlIGluIHRkeCBjb2RlLg0KPiANCj4gKENvcHkgdGhlIEZSRUQgZXhh
bXBsZSBoZXJlIGZvciByZWZlcmVuY2UpDQo+IA0KPiDCoD4+Pg0KPiDCoD4+PiBGUkVEIGlzIGEg
dXNlZnVsIGNvbmNyZXRlIGV4YW1wbGUuwqAgVW5kZXIgVk1YLCB0aGUgRlJFRCBob3N0IHN0YXRl
IGluDQo+IMKgPj4+IElBMzJfRlJFRF9DT05GSUcsIElBMzJfRlJFRF9TVEtMVkxTLCBJQTMyX0ZS
RURfUlNQMS0zIGFuZA0KPiDCoD4+PiBJQTMyX0ZSRURfU1NQMS0zIGlzIGNvdmVyZWQgYnkgdGhl
IFZNQ1MgaG9zdC1zdGF0ZSBhcmVhLCBzbyB0aGUgVERYIA0KPiBtb2R1bGUNCj4gwqA+Pj4gaXMg
ZXhwZWN0ZWQgdG8gcmVzdG9yZSB0aGVzZSBNU1JzIG9uIFRESC5WUC5FTlRFUiByZXR1cm4uIA0K
PiBJQTMyX0ZSRURfUlNQMA0KPiDCoD4+PiBhbmQgSUEzMl9QTDBfU1NQIChhLmsuYS4gSUEzMl9G
UkVEX1NTUDApIGFyZSBoYW5kbGVkIGJ5IHNvZnR3YXJlLCANCj4gc28gdGhlDQo+IMKgPj4+IFRE
WCBtb2R1bGUgaXMgZXhwZWN0ZWQgdG8gY2xvYmJlciB0aGVtIG9uIFRESC5WUC5FTlRFUiByZXR1
cm4uDQo+IA0KPiBXaGF0IEkgZ2V0LCBpcyBub3QgbWF0Y2hpbmcgVk1YIGJlaGF2aW9yIGJ1dCBt
YXRjaGluZyB0aGUgYmVoYXZpb3IgS1ZNIA0KPiB3aWxsIHBlcmZvcm0gZm9yIFZNWC4gVGhleSBh
cmUgYmFzZWQgb24gdGhlIGFzc3VtcHRpb24gdGhhdCBLVk0gd2lsbCANCj4gYWx3YXlzIGVuYWJs
ZSB0aGUgc2F2ZS9yZXN0b3JlIFZNQ1MgZmllbGRzIGZvciBhIG5ldyBmZWF0dXJlLiBCdXQgSSAN
Cj4gZG9uJ3QgdGhpbmsgd2UgY2FuIGd1YXJhbnRlZSBpdC4NCj4gDQo+IFRvIG1lLCAiaGF2ZSBU
RFggc2ltcGx5IG1hdGNoIFZNWCBiZWhhdmlvciIgbWVhbnM6DQo+IA0KPiAxLiBpZiB0aGUgVk1Y
IHVuY29uZGl0aW9uYWxseSBzYXZlL3Jlc3RvcmUgYSBzdGF0ZSwgdGhlbiBURFggd2lsbCBkbyBz
by4NCj4gDQo+IDIuIGlmIHRoZXJlIGFyZSB2bS1lbnRyeS92bS1leGl0IGxvYWQvc2F2ZSBWTUNT
IGZpZWxkcyBmb3IgYSBzdGF0ZSwgdGhlbiANCj4gcHJvdmlkZSB0aGUgZXF1aXZhbGVudCBwZXIt
VEQgY29uZmlndXJhYmxlIGludGVyZmFjZXMgd2hpY2ggbWF0Y2hlcyB0aGUgDQo+IFZNQ1MgZmll
bGRzLg0KDQpXaGF0IGRvIHlvdSBtZWFuIGJ5IHRoaXM/IEV4cG9zZSBhIFREWCBtb2R1bGUgaW50
ZXJmYWNlIHRvIGNvbmZpZ3VyZSB0aGUgY2xvYmJlcg0KYmVoYXZpb3IgZm9yIGVhY2ggZmVhdHVy
ZSB3aXRoIGxvYWQvc2F2ZSBjb25maWd1cmF0aW9uPyBUaGF0IHdhcyBzaW1pbGFyIHRvIHdoYXQN
CndlIG9yaWdpbmFsbHkgZGlzY3Vzc2VkLCBiZWZvcmUgcGl2b3RpbmcgdG8gdGhpcyBzb2x1dGlv
bi4NCg0KSSB3YXMgdGhpbmtpbmcgaWYgeW91IGNvbmZpZ3VyZWQgYSBmZWF0dXJlIChmb3IgZXhh
bXBsZSBzaGFkb3cgc3RhY2spLCBpdCB3b3VsZA0KYXV0b21hdGljYWxseSBzZXQgdGhlIFZNQ1Mg
c2F2ZS9yZXN0b3JlIHNldHRpbmdzIGFzc29jaWF0ZWQgd2l0aCB0aGF0IGZlYXR1cmUuDQooVk1f
RVhJVF9MT0FEX0NFVF9TVEFURS9WTV9FTlRSWV9MT0FEX0NFVF9TVEFURSkNCg0KVGhpcyB3b24n
dCBuZWNlc3NhcmlseSBtYXRjaCBLVk0ncyBiZWhhdmlvciwgYmVjYXVzZSBpdCBjb3VsZCBkZWNp
ZGUgdG8gbm90IHVzZQ0KdGhlIGZlYXR1cmVzLiBCdXQgd2UgY2FuIHByb2JhYmx5IGdldCBjbG9z
ZSB3aXRoIGEgc2ltcGxlIHJ1bGUgdGhhdCBjYW4gbWFrZQ0Kc2Vuc2UgZm9yIGFsbCB0aGUgVk1N
cy4NCg0KSWYgbGF0ZXIgd2Ugd2FudCBhIGhvc3QgY2xvYmJlciBpbnRlcmZhY2Ugb24gdG9wIG9m
IHRoZSBiaXQgZmlsdGVyaW5nLCBpbiBvcmRlcg0KdG8gbWluaW1pemUgVERYIHNwZWNpYWwgaGFu
ZGxpbmcsIHdlIGNhbiBwcm9iYWJseSBhZGQgaXQgbGF0ZXIgZm9yIGZlYXR1cmVzIHdlDQpjYXJl
IGFib3V0LiBJJ2QgdGhpbmsgd2UgZG9uJ3QgbmVlZCBpdCByaWdodCBub3cuDQoNCg0KDQo=
