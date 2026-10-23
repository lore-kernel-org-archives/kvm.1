Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792726774;
	b=1m2RUysvr4qyBtd8qjXmLWm0yiuQ13BNklsggD1rp+da3IFPwSzlPPKPTqTvRsL03oeE
	 /t/YXaQYy3LEF9K8rej/xiWL3yEqND8gYiDDJ/M+hu+Rn9+817nVF/ekwRe6pXnJO+xZM
	 NbP7ybNwBS+rgodUfVHWA/p7Yg6VYbWF8WKyKgR6WN5g5sKatSkA3J2A8RIAqD0RcRWyp
	 Hu5RlntkKU3LLyQZwXOMo4n8uDJKyi4FT3FoBaLe3mLromgPF19XFj6+msBZFtkI1F0nr
	 r1mLtTDBTIU21JBFlxLqfOJxZHcr4rCGOZYE+ohta82W72/jfyoqUcz1kJZ4nm0srog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792726774;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=l+Iwg0KNc1M3NBFD617RMoc9SvyU2Yyv004M55CC9HQ=;
	b=a54h/5DPXdy55qyQsP9uwfck0H5ep/F5fSz5jG4zTz0O9PLcC3h3ZRj4/rs1e0Vrw9G1
	 fHet1XRoqwbS2qzkEurIt84dT3scYTZ2fhBZpabpuFng/EJVTiQP7Dvotmpm9BEyH6Ruv
	 G9JjEH3LrmRBiqVEcCiyebTxqdvaLc7ESUBEr2r/6mjT83CxTXLBZPQpw+32BZ4kAd2R3
	 zeGgSge/+RSEx/Nu72ebpccRW/bvhi0kK3EMlERskVRP+GqTj2ru3slRU2oONzwCOT2Ep
	 qEgV1Nt8tSc6dk8vm6miktewjupiLtgjvDV8VrDqnpR2ZLGRTqYt6/eT0cwic+67ffg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KwWjtqTQ;
	arc=fail smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35323606A319;
	Fri, 23 Oct 2026 03:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35323606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KwWjtqTQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792726773; x=1824262773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wIyXBZ0IE64Vfit9mIrRCysB1qEv1+CFF88Qfh8p6s4=;
  b=KwWjtqTQr068X/Jw2GLD1ElfY2BN+a7Ws961ew42O9K2BTD26viuu/8B
   CYJH5Zs6YS6QjuADRFSF0Zja5ToU16X5pzucTocd+TmvFOBzjsoK4BE3V
   xtNZaWqfrMZjZ16Kjvo0kmKrfIXIs88nRkPV729mwhWZ/1b5sW1uLsf4F
   NqKLlCSlwJSHugJ33CggWHXAgma/wdVNP82ANDkUFnTNXSZLbTrQrahD2
   6VCmOVrBlMxzhvpetF2WShocLK05ca+Hxb/3CkOsDh6vghwiNrRg2sl+2
   yI63dPbhZT927A76luOBXNqvpM7yDJeTvtlIXJG1wzEaigtlGxcY6W8sy
   w==;
X-CSE-ConnectionGUID: 9k4T+H3BS3qQIBhh86qpuA==
X-CSE-MsgGUID: nJLSkrvTR0CCRBcfTXrR9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1591376"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1591376"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 20:39:33 -0700
X-CSE-ConnectionGUID: orJRkUbDQmKfOo6lXSnYkQ==
X-CSE-MsgGUID: 0EaAfLCwSf6KZqcqAVujWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3650960"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 20:39:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 20:39:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 20:39:32 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.62) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 20:39:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quJt+4lltXs6FPxxIboJdh3wQkYYGpmFv9FPJch9B1aaT2aw82TlNpPCO7+thDekbdnwfDhfOw2y7WsiwJ6DPePEXP5xdcCC0P6FLKONqNQalhmo1hoxjcgrSpPLefy64U6cu5mkSVrky+SOfrxJ0X7y/dp9Aq5UWEak9NIEw8pFeWDCBcD3CIlECrTALTVcOfYP9oXA8/6XBllfnuGTjhVI/meUlPAJ10pGXRxVAyOc7glA/mMZD+7RF2lPJ5X1qU921lj5sU28i2hqYMErl9kxRdDfiiWqSj7Wy5qdw8O/HQCSNxQtPHajfEIaXzkuGSayRPIV0fSA3jtqIEw/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+Iwg0KNc1M3NBFD617RMoc9SvyU2Yyv004M55CC9HQ=;
 b=oS8YMmoIs+UdVC/Z5CeGIMKel17W6lFQ8Wq9w1Jh6ajhJLWRSrnckB5RKjgcAXLG48rrPUIy3YSl1r20w7kB52uwnTl0fhQsRA8EYhaPsJoiaqwuaCmDiQhFM4s7HtcCZ1oUhCTSPWH9TSTNx7NXdxvzHR3oBKffyT9HOXQBXySQD+cBtUW7m64jfwNcVVXeiaWBVl6jTjR5r5qeczAC6kv8uxlG/aX+YkD83XrdeMlbX++yDhAIwQJW9HOpkL2PBNbS1uuSjdasu0yTsNQmP8nsXH5Rcf+r3qJDSx8v5F74fQb66EuCLIz3Ma83ByPpMzUD2JXD2WVMcw/s6gx90A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by BL3PR11MB6458.namprd11.prod.outlook.com (2603:10b6:208:3bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 03:37:46 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 03:37:45 +0000
Date: Fri, 23 Oct 2026 11:37:33 +0800
From: Chao Gao <chao.gao@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <dave.hansen@linux.intel.com>,
	<andrew.cooper3@citrix.com>, <nik.borisov@suse.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <xiaoyao.li@intel.com>,
	<tony.lindgren@linux.intel.com>, <kishen.maloor@intel.com>,
	<dedekind1@gmail.com>, <adrian.hunter@intel.com>
Subject: Re: [PATCH v5 5/5] KVM: TDX: Validate userspace CPUID input for
 KVM_TDX_INIT_VM
Message-ID: <atrWfXiDdfC_QIxC@intel.com>
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
 <20261016091422.3182216-6-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261016091422.3182216-6-binbin.wu@linux.intel.com>
X-ClientProxiedBy: SG2PR01CA0188.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::10) To IA0PR11MB8380.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|BL3PR11MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 031fe5c3-2c5d-40fe-306e-08df30b700a3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|22082099003|18002099003|261022105027099003|261022075727099003|5023799004|261009223027099003|11063799006|4143699003|261021121427099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 6t85Jixe5TNE8jjcOUjVczCEKQSG30WO0wNT1AQQcL3qQbF6vrp7+o+xNzo/nHlfZ/zY1cjxqn9FYJW3DLrpG02e786EdepiVZwjuVc+VAzOfRAeYwhpRnlkGPrZNInLp4PPVRPp0/COzTll69AT2uvY1AqlCgbq20XRcdUJ01dimH1RjUgKUGVfNJbioQgjawDrXqOAtwrjSG+DKmY6Rp3DRLjCkrkHU7hQUeK4A+7V6rOddInyi4NU+HduEMrAHJDGh1P79tappPzofdaaI2fGl5wk7j0aCZzajuShaZpssMqp/9nXISBFio4gbrGNIivK1qajVe1GAm4VhDO25kkuN+ioLE8UCOUipbgaEGRnJdW+0YOvcflaK9vFehgwaWkohF3wLvGQk2ny01yhNq5fyssWgMtvQ0UrcyRYWSTns7DTt3s5bdBJYJCDJWawkj+xoi19o4OmaMuZ4x8Lckk7KngddwXsLUbTRtd9RSC5D5SPQg34VmZeA9mkYcn1Pi5pnCSsclxA6vpy3ZDXW7NR6oKv4ZAPeRMTpH6WJUuzUFoy3RgjdkuOLHI88pkaxmjEXcSUdmTvTYbf6JiWZo3u4eSgjkYlgsVOgLEqCP8CNgPyH7Q8rtfXZtMlZuGtR8ovxnF0OzegPNjNKOf/yTPkULhhucOAPujBNqgse60=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(22082099003)(18002099003)(261022105027099003)(261022075727099003)(5023799004)(261009223027099003)(11063799006)(4143699003)(261021121427099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0TvbEO6DN5Q3Nreu2Q7yMVxFx2qeRj6UD1Tst39EcDxo4t9yfJSxe/c6eZsG?=
 =?us-ascii?Q?MLc/Aai7AZtzMs62qvZTk3LQ1fQq39LbS+vNsToD7uAlZdP9eSgV9F3UdIr+?=
 =?us-ascii?Q?QKpP1yMrChpOFTwsNUdMJl4dqTNlXhdYJju7aVXfoD9rYv1+d4iaCYEx5iaK?=
 =?us-ascii?Q?yj/Ri4YGh1zNOJxsRRcXoOcAABzOVtX24/TeGRBxlAg7smmvBM/7s1di/ALn?=
 =?us-ascii?Q?uxgADFheWPyXLl9O0YMVKLbS6tGr2BgMYQE51R61nq+rpDhIVcql55h50g+X?=
 =?us-ascii?Q?LWSkR7Y8FnVJjycVWsPAeSBIB66QMP1QCu3tV7CnFXQHNCfGr/K7v+H3mNmh?=
 =?us-ascii?Q?Dew4BtGZkNbeu4UzFJlUjvJvJJwRpiBP2e4AH1rRiSndM6F2HBMN65pag6hT?=
 =?us-ascii?Q?/IM+soYGsR7skrOpqlE6sX00nwXrVJoI9YlfHISwv+1g/x6CASMyn54xAiuM?=
 =?us-ascii?Q?zln1T5trQ/MvxtwEgognHsFEq/NeVZvu3quOJHzmRCAFWRQzTn+41wdkb6NK?=
 =?us-ascii?Q?GP2XNxVWUXf99iSb0H7SrgzQZryzL/WJSNuIw9PbOsiyfvn7stWc/x2tI4iN?=
 =?us-ascii?Q?AYbtV9vAoUQZOURIoTQXPYl6b7MjFh3pS6u1i1W/X2T2wTtYHHXDQXHhAV9q?=
 =?us-ascii?Q?9EYh3PcTeeHuoafzW+bM9yowwKAKoUNtMUAF7k2l/n6wew31jGfIwAZ+XvTr?=
 =?us-ascii?Q?MRfpFp4InakW4c/Y5nRNgpz6qRmX6BKltGGVB0KyAZ3cEgduzKh8XmbjzSZp?=
 =?us-ascii?Q?pxNbn8Nv3aEzSzz0FZddP2XKiBl/nPiP1cVd0TIWC4ZtMihTu6uGvxQh/5X6?=
 =?us-ascii?Q?dPmkhQ9zkX0r+qgBnPBGAGp+rOBBBBGXyqnDinXjwQaOaTi5Ibf8kVI/edQt?=
 =?us-ascii?Q?PMQLsnjTDXUDXYbN5kxnDZjc6aoNvRQKCAQpu9c2F3Q1RJCm5OcrxX498oAf?=
 =?us-ascii?Q?jobNGZiyFTGtuQTnTYTnKeR/4ZmVDl4nwPbvTx/jDm2OQjY6oJvM7digXged?=
 =?us-ascii?Q?NwTNNl4cdWyUVvq2gHk3RkkCHTIUn58xwxAFzhZCQdSa0xBiCBrBm42Gh889?=
 =?us-ascii?Q?+qV46swWB0Vxq+myNCM0JrMbXu+WhkPX/i7yF+U2tgN0XzLG4nADlNjbA8RS?=
 =?us-ascii?Q?tVRiKl5clOzH45wE/oImgDemv/A7KHzjXuu9isYZkSW/gQHtMv60LXwsiIOP?=
 =?us-ascii?Q?2OAE6xtfbehWetWQWpPhcdip/Y2AACHraasGjemEv5JTEF1N1Wqgzacsj4bW?=
 =?us-ascii?Q?ugSjtlwJC8t+af605wEFOPS9jJ60bmUT9/j0xlFRF3TdDsckUSNpJMxHThHq?=
 =?us-ascii?Q?AHnuQHhmOT0Q2yVbJTwMfCVLAZyQJcx7QAj2KKAPmD51bQ771oFxCtBUinEY?=
 =?us-ascii?Q?5IeoZZAHecaz2mkJHpvqupiUTlTKCM2j2QO8OejXPmq2pDtjXL/bXcvl0V/l?=
 =?us-ascii?Q?OzhQLWEn7YixwJoTf3icD+7UlZoGFE9Z0GAxHdVWrNLS6fJN6aBFL0i6sQVU?=
 =?us-ascii?Q?lO+boJ/MoYrHCQXEmGRagPkIgFwAJ9o42X1mjCEyBAAp5Nn2ktgnUf4qrGoh?=
 =?us-ascii?Q?8X+Sx5r6dum/sfb52g6v9A09mGyQbeBlUySNU8G2Oyen3Jc7ugmSVYNg/jep?=
 =?us-ascii?Q?VuRbvXcfplZjtENptGfFAh76sEBqi/Vqwc8LopUwRg6xsq3U336gsxO0aT6i?=
 =?us-ascii?Q?wpV/Ep6+Z/yo2eW1Zqhz/UPDxnGR20Ro0t20F0Av1e2Uu8cgeC86g9Y6Pf0x?=
 =?us-ascii?Q?8Pa48CO9pQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: PzcSXiNxY4X3NxNYSf3p/hp+Qzrsrm73pzDUpFHHrbRn7ZLeG+t6GKOjnqDIvzzdHX9zflg3jKQcwqGVvMNPHhaDPyc104oTKsqZ96yAxouLx3XIeISKSn/Ok09BuexRH9DjfhnIbfbGHJlB+nCewlRmi3oTqHSciM992boaG5SvLfWTuLHNTZOt7o7eIBhF1AFaYzJ/BMy/AbNMlhnR/CQp8x+2MR6h108IC2fVxJrMln77MvduTjyGE6K0Z+U/tFD3fT/c66KAunRXE1duLwuKyd7z4ciRLZRO9fwWuBcltMgLpkIUVRzsJzBplJQpbN+eiasWpgg/xPnmpnRWAA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 031fe5c3-2c5d-40fe-306e-08df30b700a3
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 03:37:45.8594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HfUvMIOxhCAf1WGSUTgdz5xOIu3h4Gn7ZPqo6p6ZTIQvQuKcPaWIMrkb5SlMAP4IgFKGdBgco7hDv+Tsjo7Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6458
X-OriginatorOrg: intel.com

On Fri, Oct 16, 2026 at 05:14:22PM +0800, Binbin Wu wrote:
>Validate the CPUID configuration provided by userspace through
>KVM_TDX_INIT_VM against KVM's TDX allowlist, and drop the hardcoded
>denylist-based check.
>
>The TDX module lets the VMM directly configure certain CPUID bits for a TD
>at initialization time, but KVM must strictly govern which of those bits
>userspace can set, otherwise a feature that clobbers host state could be
>enabled behind KVM's back.  The existing denylist rejects only TSX and
>WAITPKG, and thus would accept any bit that a future TDX module makes
>configurable, even if KVM knows nothing about the associated feature.
>
>Add tdx_has_unsupported_cpuid_cfg_bit() and reject KVM_TDX_INIT_VM if
>userspace sets any bit outside of the mask returned by
>tdx_get_cpuid_cfg_mask(), i.e. the same mask used to filter
>KVM_TDX_CAPABILITIES.  Don't bother intersecting the userspace input with
>the bits that the TDX module reports as directly configurable, as the TDX
>module itself rejects any bit outside that set.
>
>As with the existing check, use the subleaf reported by the TDX module to
>look up the allowed mask.  For leaves without subleaves, the TDX module's
>"no subleaf" index is normalized to 0, which matches how such leaves are
>tracked in reverse_cpuid[].
>
>Note, the change is user-visible, as KVM_TDX_INIT_VM now rejects some
>input that was previously accepted.  The ABI itself is unchanged: KVM
>already rejected unsupported CPUID bits, albeit via a denylist, and
>userspace has always been required to consult KVM_TDX_CAPABILITIES and set
>only the bits reported as configurable.
>
>The change isn't expected to break userspace or guests:
> - The newly rejected bits are no longer reported as configurable by
>   KVM_TDX_CAPABILITIES, so userspace that honors KVM_TDX_CAPABILITIES
>   won't set them.
> - CORE_CAPABILITIES, which older TDX module specs defined as fixed-1, is
>   still allowed.
> - The dropped features are either obsolete or unsupported by KVM, and in
>   the latter case, a guest relying on them would already have run into
>   problems.
>
>Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>

Reviewed-by: Chao Gao <chao.gao@intel.com>
