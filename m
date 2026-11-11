Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794381911;
	b=cX3c4bkaSoIuFNsA/GffGuzhaziIGMeqjO1UicWMnEHC56YQKp3Rbyl5SqLffHrXdfBi
	 hlOw2fdQYcJntRpBsBe1qvHfSFRXkMiUrIlqTyg3BXTUPJAzvD9sfvT4OP4uFTn1PXRn7
	 WnFJXqBqBsLcRow9GHOZstI7/IJV8Z8yERVuGcMikP9ce5GRTco8PXrfY9nW3mmKGyiyV
	 xpPlmsbNtuaIiPXD/Y8DtkV9YEx5F+ZcUZpS3r+au/7Dw7bGHxUYH865x7kYE2NmxHqax
	 LUgfWYlewDBxui5IxyqajPvEpxBEHX0Y5kAd68LB313Yrc6xGL7kJVzUbwTrrg89WIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381911;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=v9RcGRlxnphpW+NyisaoHp1xwjz835uJNujfbjZzgoQ=;
	b=Curu6E2boybnnM9GfgrOE1Fj3YGqsf8E4pWCvbDa+kunIYixgsd/ddOT4NL30iqSsrS3
	 8u2I5/akfQWNgRTMJsRClIqa6wJYES5lRB0Ieqcw0prvdhi7KBnXEBe1nSc3VWgPGTQeQ
	 Z9+DlIpof+TuSeeqFflblQTk3mlpne7rh74Eks4n6fPxypFCXJSI9I6TpmZiWYI/l0gsf
	 LEvBb634s1xx+ITgG5bj8rmHIRtKDAJHZi5/tJi0+E12sPqtHVm1F8w3SGhd+5dN7uZFW
	 TzfHT/9UsG7x5+BEsrp9chMKT/eloWXHls8nGfeJ5Vh65AIbMRyZEX2XBLrj7LnrNMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RkahbkIp;
	arc=fail smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3571606A32A;
	Wed, 11 Nov 2026 07:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3571606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RkahbkIp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794381909; x=1825917909;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O31UqqVGNDcrHiGeppNd9Tw0KlSinU79rebFJgp/RmA=;
  b=RkahbkIpgMJ7NMkYZY/o+skkpDyx6AJBPSy0LU4vam+niepxV+dEqsNL
   MmsJsPdtZAKVcvgBNRhFcQc89W+QkvrPGQOYrTA9s/H7bOoi/b2OuHbFB
   NE7iT9xOUtyuP0sU03a5nykvTO72U8KYbH3iDc2OM1G2PnrBewyq5wQfT
   GcDWgiEkHaIpOe+LyXLdK/e7CE+0934OvRCOU44lc9LhVDRG2jUJSqGz6
   9E0gE2TMii4C6o2qUn2sSM2w8OrejChjR6sIh4/ydCbZ1+DU36c8znWij
   tjHcoXb/Yb+/gzKOnU3hoMMrU2MI25O7nxOaIKgmsUnXtwlonb0u8NIAm
   Q==;
X-CSE-ConnectionGUID: LlSDVHRvTtKjJ90d17qzug==
X-CSE-MsgGUID: mDmtGWRIRQWK4FawtlmlIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3041849"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3041849"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 23:25:09 -0800
X-CSE-ConnectionGUID: +nfXSzr+SVmWqobT2kYOmQ==
X-CSE-MsgGUID: +QQ708ZISoatGuupMXGxeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8330496"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 23:25:09 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 23:25:08 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 23:25:08 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.25)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 23:25:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioeMMuiTAFfXy/T4mUrz5r/Hk/pW/mQ9DBsKPMQNkq9mebShbjEARIHWycqqAQH7leiO5noPDA+FUUBT+bnRV1xB1oHUzk6FfzTMib83KZoM7ZecPm3Y1be8jurGkPkaDSa5yMdUNOQnlSFksdaMyse3utVb63inEFHG95qerqHr+2Eya+3G+tpGUBPj5HuouV2dWojtqBcqWY7L+dwSMYA9dtiD4xQUFXt4Z39rAl02xYFerCe3N/7qGvx6ws0L6t7ibgbIHrpumLJbr9TYAeAUkRQnMbd5cgP6XdkrP2FqQjfDXGfBrhZE1aTjRTKQuBqTYBBuvdzFannwg3d83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9RcGRlxnphpW+NyisaoHp1xwjz835uJNujfbjZzgoQ=;
 b=qETGAVW50hGGCT6rTcIRzUuY1UsSe+UQAHowvK/1LzQMndvwiD1Ru2NOMm6FjRD+F2D6TbayYE7lo1RiMlY9ftfh4s7Xa9E+gdpPOfg31CIRw5alkpLBQNz88/IwCzW/MovMc4zz9yXN7anx8sL5nO1T0vE7HfPFvup+CyTmpKqAq0U7jL+rSyHtukFIuszzdF09RvCsqCzsui4GOaKhQ7xYUwImYB/N0ANogjLyytJTbsg7RSW8t2IsL8Yh23jpCBJmLGVsdJl+uoRxdmXCHqdY6MfxML71nEoyjv3HTyniVEKIxXcTREd15XqyB53BbJRisDq8VOzYxc8EPvHmyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by DS6PR11MB9896.namprd11.prod.outlook.com (2603:10b6:8:460::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:25:07 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 07:25:06 +0000
Date: Wed, 11 Nov 2026 15:24:54 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Van De Ven, Arjan"
	<arjan.van.de.ven@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [RFC PATCH v2 2/2] x86/virt/seamldr: Support multiple sigstruct
 pages
Message-ID: <avQYRizeudYt-fbj@intel.com>
References: <20261106132159.1551365-1-chao.gao@intel.com>
 <20261106132159.1551365-3-chao.gao@intel.com>
 <91506ebc258a9db8b2aa47310a03b60e3c653314.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <91506ebc258a9db8b2aa47310a03b60e3c653314.camel@intel.com>
X-ClientProxiedBy: SI3PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::15) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|DS6PR11MB9896:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd5106d-cf9c-433c-97e8-08df3fc4e85d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|261009223027099003|10067099003|261022115727099003|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ISWx2Ak8LcCFp7DpC0rlgp87LfNyePBLXQdrmtdYAkn//MkeuFMQilY6zm8pIy+LL3I/uNxgBueA6BSpMLG0opAa9BV7Y/3mh4bxf1SY7wpQILyPYB8Dz6g1BvH5JzkBTfJBaeDU1jxA2E3tJr9vPc0Je2o/RjvHNvjKucd1fIVaA1Hw+A1Hvkxv6PxlJxp97ldeo3SBnNZ+KgjBc1XQK6Nf/2lOd626HESBs/X2l22Ag3c/GMU8gxPJTGcmBY3sF8IqXNJlkNRf4ATzdB0SAPyvU1O+zh5f3BUQSwo7/xWSzKedlJYwtOXRe5WGHXvj2Mac+BoinrK72pAOSNfFMMwHkai2jnAMs3Amy9YIhfzQ6r8zKeIYNei4qwgWrg8aeJgZKicMUYgc+XyUS8Tze6B9IKbctsx8TJYMkNP0NsJ12OaVKopY5VJWy5+Eyj+f+BbHDHqpjorFq4mMMW2nuiJuY3Viym+qjO7dRtPx68L88m0AYxu3GVVfXPHbsYIOEXqsvv5F9J4J/Rs4TRTUZgLRAMc3wECFJx0H2oq7yrFV2TlWirlXCyCGtjeQAszBBpDdVPIV1GsgY/z0fidKAHrt5CbTing0VG1TRQJZRt4h3ojfJEcKg+rzxkIpZYVlxyldZu8GQrjD/QzPtoTyjgICyaVvFhtFDx2Obim8DoQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(261009223027099003)(10067099003)(261022115727099003)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DVJ0hQNy6/oRJBaaFMV+A1f9ZX474DdmiGOqFANG4ebZsGpLTLEBbTSB9Wh0?=
 =?us-ascii?Q?SBD2LOPbYQQGX91M0iRC8fWetdkwNouNb0LwlF5cb0CIYbIOKlnLzeEPA2Bw?=
 =?us-ascii?Q?JEzbw+foHl5hBbSV8mu3c+/gf0K36W9gb7sN0SgfumQaknh2JyOqOb11nyxH?=
 =?us-ascii?Q?UmlZWIXDmh2RGMcSKDkhRRKLrwgeJb/3HeRlhiJRZvglwNKeuPMZcUvh+5wo?=
 =?us-ascii?Q?RRMIT2NSHLdLc1W7sXOEGtSiEt33dKkaVBB2SLeJu4wf6WjbR5cJ3rDysZhb?=
 =?us-ascii?Q?jQY0QcnYiX60hqtOjAv4gQLGJ2itMW7317g4h3ZzA1mlP6Um4UNiW1BbVw5d?=
 =?us-ascii?Q?vWgjQ746yD5HP5G8EETsh1WKyS+bSG6587pBtTAzgEN2ipIKcaL1nynDFfml?=
 =?us-ascii?Q?7KPfRU+OJ8Vhi0X6unhFV9AbJ6ux5KFSLNTpcGWiMDY9pUcnc2ehp8jW6Ylr?=
 =?us-ascii?Q?LmiDI0ZygW8mn2kztzBFtDuhs0FUzR6WpvH4wDAoE4pL4Kyibj3ISdlgAg5T?=
 =?us-ascii?Q?Qt1MQafwnImxXbXVZJtSNLVxR16UAyTDSVng6IxrGYKcOzp1gHuzQ7lSSkHE?=
 =?us-ascii?Q?1K/BrMzYWO+nlCMdHJoHFOH946Qtf9i0tV5bMc/TG3SvrpoFeBcAidPSFiMp?=
 =?us-ascii?Q?DpHmZJg/C7UddwICM6WcAZJHQvJfqczYV9Qm4WRj7hPT31TsSRk/DBrLs47o?=
 =?us-ascii?Q?WHuaykPB7uqW61zIlNTUBRombcbhrlX2xYiXTf5WVQ2peTGtFcLVqijR23F3?=
 =?us-ascii?Q?X3QUO2W0rl7sZ6O0T1q9Vs8o6GDy/GOZycKo2sCXMI5osYBebX9h3LfUAdrf?=
 =?us-ascii?Q?pdEVXReKFuy7L0WhWoEb0J3x9JijeoZP856MZGjWyftQ8FPDZC/v9ge9fMEn?=
 =?us-ascii?Q?UA5hlnz+GrghapMmkLvya/LgrU+27+6nKqTZ80XeC8VSQe9swcCmuw9yZ1Vu?=
 =?us-ascii?Q?ba7cv1GoY5eu+pFwv46K5PxhS9kdERB9gCEQUnG99hL1n/fFV6Qn8RGt7Rse?=
 =?us-ascii?Q?r5pwmuuQ0DIlRDrFzPfkSsXeOcIaeOrAgC+8KBmYeLMKO3u2I/+mGe+fWXDq?=
 =?us-ascii?Q?M8CFVzwgbZaNXc+EyHGSuEYtg94WBpPFLRwZSb5tfVVNcKQD9bru02kYi4l4?=
 =?us-ascii?Q?i5sKh/7vw5rMA7x0APQpScj/+nSG+L0QjlI471/5JSdRHi2aCsed08L1+zWq?=
 =?us-ascii?Q?iv0NPpDs+dhr6iIVIWHAk0CzZfIbceB46y0j43w2/sMFKALqpnsmcN+z1spG?=
 =?us-ascii?Q?HYx00gLzzAyeCOrmvr3Cc2wqibP8WGSgUBm0jhGPRWwIUS8O5Nfbd8eCNcEX?=
 =?us-ascii?Q?5dOxt0umygdMFo8F5iqdI6Pzdk04XTt9P1raoap9PK4FZ0DvDtx7YqJ7pDt2?=
 =?us-ascii?Q?Me+KlQALTeb7SvwB97Ih+5MyeLDxB1/wI1Zx/YKyGMC06qxjQXlBA+YaWV23?=
 =?us-ascii?Q?qDw+xKrEPdQc+PwWfhEHYHTRTJoLkBdrFXFQNz8K02BqpB6auxxh565XSHy7?=
 =?us-ascii?Q?wxleKfQ2c1UI09kwVS08LPCO9nsugbxVnkl4kqudVby9reHaI4rc1qUL4TbC?=
 =?us-ascii?Q?BELYUbPLDise1AA0LZbC7dOJROe1gcIUXrQWI9wrD8kqXAfnTFZ2UdNJC/IS?=
 =?us-ascii?Q?Ce8MvrgdT8R58avsLywGDW6F8j4ZUiG/D4/NGv+DF/TS11YFgOjf4F+PSHA8?=
 =?us-ascii?Q?YRL2FsBfeBZDu22T+qz54QfGASOCCx5hqBu7a14IFq25HwO2IbRWhsxsyaX6?=
 =?us-ascii?Q?NeHbfNInpw=3D=3D?=
X-Exchange-RoutingPolicyChecked: bbT8n8JCBDe1gkkIbk08yjvmzYA7qPzVlqLeWoZ8zg36cw0cN+xUaf9vpyJfdujhCzmKgdwATuIB2bZcYNOFYwgTH6j7nKLux/zLmxtEiQpHU+2FxV7hkZLu9shMEUq7nPu8Jn/TS4JHr/O8xNaN3ewiH7AB4Er9aULrR6GItChfpgNJfpFobQLeizN+bo37pY2xlRgUPe9u+5P+AJHfXT3JGhcNFhcJjDY3MiOsGoImQkvujZihzkp1yDgJy9MIizaRxZai3+1ChSP6bsIf65YDlq/oCwa0yzVUvncuoVIbZdO2AgLtGcK4Jlw2h2DAQsJBYY5O54xNzPrMpp2ceg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd5106d-cf9c-433c-97e8-08df3fc4e85d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:25:05.9050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+MTux9yDQVQ21uhyZXc03RbyJYPHkZ67yMADRZDnipjpg86M4gbxKlhjVqrZz3Wrhv2xVsBR2w4ELEc/d3ReQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB9896
X-OriginatorOrg: intel.com

On Tue, Nov 10, 2026 at 06:12:32AM +0800, Edgecombe, Rick P wrote:
>On Fri, 2026-11-06 at 05:21 -0800, Chao Gao wrote:
>> Each TDX module update image carries a sigstruct, which is passed along
>> with the module binary to P-SEAMLDR. 'struct seamldr_params' has a single
>> physical address slot for it, so a sigstruct can be at most one 4KB page.
>
>"it" could refer to the module binary or the sigstruct, until you piece it
>together at the end. Also struct seamldr_params could be introduced. To answer:
>Is it the TDX module ABI? Or the kernels internal struct?

Agreed. How about:

Each TDX module update image carries a sigstruct, which is passed to
P-SEAMLDR along with the module binary. The P-SEAMLDR ABI ('struct
seamldr_params') has a single physical address slot for the sigstruct,
so the sigstruct can be at most one 4KB page.

>
>> 
>> TDX modules are moving to a post-quantum signature algorithm. Its
>> signatures are far larger than the ones in use today, so the sigstruct
>> no longer fits in 4KB.
>> 
>> The P-SEAMLDR ABI was extended for this. It now has four sigstruct
>> address slots instead of one, for sigstructs of up to 16KB. A new
>> 'version' value of 1 tells P-SEAMLDR that this layout is in use.
>> 
>> Extend 'struct seamldr_params' to match the new ABI. The sigstruct
>> address list is already populated in a loop over all sigstruct pages, so
>> raising SEAMLDR_MAX_NR_SIG_PAGES is enough to fill the new slots
>
>Missing period. Also, the existing loop is a bit strange. I wonder if it needs
>to be explained, but the explanation is probably that it was not adapted
>properly after this change was removed from the original series.

Will fix the period.

The loop was intentional. Commit 23a81e6cce15 ("x86/virt/seamldr: Allocate
and populate a module update request") kept sigstruct_pages_pa_list as an
array because it was expected to grow to four pages. This was called out in
the changelog of that commit.

I would add one sentence to say so:

  Extend 'struct seamldr_params' to match the new ABI. The sigstruct
  address list is already populated in a loop over all sigstruct pages, so
  raising SEAMLDR_MAX_NR_SIG_PAGES is enough to fill the new slots. The
  loop was written that way in anticipation of this change.

>
>> 
>> Set 'version' to 1 only when the sigstruct spans more than one page. Old
>> P-SEAMLDRs reject version 1, so this keeps updates with a single-page
>> sigstruct working on them.
>> 
>> Do not query P-SEAMLDR for version 1 support. Userspace selects the
>> update image and is responsible for ensuring the module is compatible
>> with P-SEAMLDR.
>> 
>> AI was used under supervision to review code and workshop logs
>
>Missing period. But this phrase is starting to become kind of boiler plate in
>all of these patches. I wonder if it's still needed. AI review is now the
>exception. Maybe move it below the "---" for this time? Dave can move it up
>easily if he thinks it helps.

Will drop this phrase from both patches.
