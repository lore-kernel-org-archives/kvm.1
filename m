Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793110753;
	b=Bg1KGZ4cYT/+LPsSS57vJOq4V5VScrRaKLhdZkRJFdu2CbMkDh2m4jlZoMPjEbMzQCyt
	 5teYL0bZGGtL/4GtK0r0za5G1w3t9NmOewShnGGL0TwYWb9IA4dpDd5bfCnUyCZRYYbu+
	 fYoJAEpRtO/i6TWgoK40koQVKnVDfplWz/HEZNIKa0l+KcqOjuHqJ68FofB4mOTja0bhH
	 vMxy1tYgOi9IfBXZ7mlp+RU/0b5bcqqHS5qTWFld+cFwx7F4td+TgpZC/gqjhhLADvO0D
	 WbikrH3FCqWrhJhFbe2dfZhZt8RUj680jQxPG3QD0lxgtESc6Au93cFepVfqM7ur+qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110753;
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
	bh=7jjmns7/OYP2v5VBkRQ88E+lFI5dmG1iw1Xx3FMiVcE=;
	b=16pxihnL2jejD+/QkTYGw19Pqzxdu7iaCNj592G9M92xcR4YyJqwQgetK/+nBn+9jBMO
	 /AdlMftKTMaO+b/aDP+6S+JCAgjItK5f/84NcvqQe7B0llItY6YYNrIvd6SUJyroBDv1m
	 KuTYStHg+uRm2xFEOxoPB5aUm90jZRp1yTQyg3f/t2wAfAvbo9Ywm6Gd15aZRLY4EWupJ
	 9Pc05L1tpp+wKXBIg4DsRFsP0OTV+F1V5cTlXbGjr1PFHLo+urJWLBS2IZ7SabAjvBAXD
	 /wjLru1OiHmfzTlHkUXBO6LrvMZX9sX70lqZAXU8heK2QzReSz2YHcne7NgDRzzIHZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ghCp1Yum;
	arc=fail smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10D0606A31A;
	Tue, 27 Oct 2026 14:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A10D0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ghCp1Yum
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793110751; x=1824646751;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zte+tiE9b6lIH0wG5m2Ng0N2MOnOdGTfzNeqtR097bA=;
  b=ghCp1YumensxtgsXxcyoXNnzIYiipnuFaZzEh7lvIuSTLgsYti7Lth8L
   JcnRxfw7Fa+v918D1bWj+xYZZP0f2vNnFdjlSjkb1KXotq00rEPYY3TnX
   HiJLtKq+Lf9N/r8DCzbBjWbloGP/lzcsBSZf1DPDzOb29yR5sqCaJA4zG
   GBIfPzkHHfj6FbrGOwo6OLakP6R2F3DAX0l31SZC2CtPCMJRJRLnJYDz5
   Rgu3EIBap/TueN8HyzsrIJyriO14ptdqLrp2tR931pfnsVNewxv71pxQy
   D6tePFan5kZgw8XXXFUjMVMC07UO8GMrAgf5SV9VGwTWfaldR9CA6Ecnw
   Q==;
X-CSE-ConnectionGUID: bVQrPOAwSFe8J79O/CzAcw==
X-CSE-MsgGUID: 8+XFGa9ySVKQAq1fxbcnlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1833357"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1833357"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 07:19:04 -0700
X-CSE-ConnectionGUID: 7iChTUBxTpmSQ3fWXBcXBw==
X-CSE-MsgGUID: lfgFJnmSQyyraT36i/raog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4634791"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 07:19:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 07:19:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 07:19:03 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 07:19:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YP/3VKPLwk7qwpnL5H+uJfbACSWHO/T1qByfV1oDMg99dgOCo8jei21Fvk1bnd2gYtNLk3O0UaJHA9XlaHGfr2LCCzL5nG2bDQNPzhz0bK888qgGcnqw8RcvNqbl97bevCkamw0i7IN+6btHfYzkq2e0y0uQpyZJqzmzZ1TxsnzJl5UeQdUKzoNhIXcE9fP8XkEkyBYV9cIEUopOVDQGWtpP3RTbPBb6U+Rtqg8OaYLV/pd4kyzIgvtLdATix87/3X3jPwYjNS9f5rqgYo2LvRXj6tq9iY0Tn/rSmfgm8K80SMbl/DFkuPdAtqihmSee7y0aOarIMQRSviBQvok1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jjmns7/OYP2v5VBkRQ88E+lFI5dmG1iw1Xx3FMiVcE=;
 b=kXAJ2hjQOUryBFdXQBZufqMblEo23nIZKq98DEztzg4p0T1ehERIuvBpq5oYA1myKwEelZbHBYTiuvTXn4SXj+uqNqZ1ZyfzFZTbI76TjYu9vQSe8artR+ChZG+jfVPB19ZeF/DHI3EK3vPX6msL5QjpKai59wKgn8jvS9UUQxqRJNGdDLW7xp5sanNxCnsk0GxgrU+IXA7G4yND8dXcHhBQbdFwY10i4RLEDG12BDNU81Bk1MibR2+1RpVIiRjGvPjeYuPmApkfGLR/sa0zjvUTaCxSgXfZ71hDzUzwduWhwTevWB0DBmtOnK8HpsM8FMuqsCzKS9W/kj0hNCQnrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by FT1PR11MB129532.namprd11.prod.outlook.com (2603:10b6:170:3b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 14:18:55 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0546.012; Tue, 27 Oct 2026
 14:18:53 +0000
Date: Tue, 27 Oct 2026 22:18:41 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Yang Weijiang
	<weijiang.yang@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Maxim Levitsky <mlevitsk@redhat.com>, John Allen <john.allen@amd.com>, LKML
	<linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Thomas Gleixner <tglx@linutronix.de>, "Bae,
 Chang Seok" <chang.seok.bae@intel.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>
Subject: Re: Kernel Shadow Stacks Versus XFEATURE_MASK_GUEST_SUPERVISOR
Message-ID: <auCyweUI3oWPN1V2@intel.com>
References: <2f0560df-69fc-4fc1-81fa-447e289ec2df@intel.com>
 <bd608c7c-676a-4b65-97dd-626d0e8a5514@redhat.com>
 <5c74f231-46a7-4f37-8fcd-bff84842a923@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5c74f231-46a7-4f37-8fcd-bff84842a923@intel.com>
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To IA0PR11MB8380.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|FT1PR11MB129532:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbc138f-0f7e-4ed5-f455-08df34353a5b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|10067099003|22082099003|261026140227099003|56012099006|261009223027099003|11063799006|4143699003|261022105027099003|261009221227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: 3ooSYXTANb8hrDccuh1oHNRFmfcbU+N/+t/niX31LYECfQDX7TArv0Dfd9GRyEq9xWWLVUEXBruV10zzdrv/YLCZpKc0+ph8KUpuaoOsvB3ATJ7znyY47n3kDIN/p88smIz/M6OXeGrPla7sg3PmoCPhGRuiUa/UJtoGy9ac9kMS5rQaW6TScOtM/dufEZ+beNf8sX0gSqrvZSPK3Dqt+o+5kAn6cIHwV+pJn4w8D0azOpjmqt9B9vgUX71ADiPWypfFrCkDInC3WjzCHv8axfp9JRBpv2h14+7LEIsbiGBULNtQR8v2Vpx0wEkphBG4F92V7cHDTT/8Qc701q8ZdYCnyDiqXDhqJeFqgFs5QKbmfIhwRVa55Jx02C0W08aIpOWrRRaftpW35AuCynWMbRnWZbOk1B7tkMB1LrKRX3t8tUv4bTQDeDagi8fC5DFuVv13Zs/3tBlH3pIbtHL4wml0SgHI2JK6olGC/ROiug/DwIXQxIWVWIWn/PXpi101zMs2jEmtuc+oaxVQLSTorcOqnjZN7maka97J7PTNVIv+2Ionz89qhz0TMsONiMGVdajfhLWyxmqg8dryos8BM8hIih6yeJvZwdKCtL59mBJ2eYtclPMy1jX+Mzlw0g/I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(10067099003)(22082099003)(261026140227099003)(56012099006)(261009223027099003)(11063799006)(4143699003)(261022105027099003)(261009221227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D2V1LABlVrjQgyzUyl77cEBOhYVzxGKgWNvjv/cQEPK4LRhNd1XUU4eD/G3t?=
 =?us-ascii?Q?aWa8HgvFSioIKqZilkieCARbZ0dGFKPlVoWd1zdKbTIl40UxUctGpFEzaEUq?=
 =?us-ascii?Q?71Mvf/Bz44fLNER+VdpmsmrUBg3hbhQku0mBpS2RHdev2eFXDQneg1FxsK6l?=
 =?us-ascii?Q?hob5gbrfAYep/KxFpZ27d618cH9Zg1QkvA433yy/47ZZZPlZmH23a+wxLiwh?=
 =?us-ascii?Q?WOl0RgzwGKSIMEjdV5zVQaE+1sWLmB6XoXz2F7aj+xW7WfQF+sGhRGZ0L6hT?=
 =?us-ascii?Q?fPfg6ozIZo4NuF0nhrThJXE6xeKzjH7x80whFCQ120kBoLcwNTaEbIdczz+/?=
 =?us-ascii?Q?eCaaWDrnvTzVDaDrXCvFuNOYKPsW0rn4PNCVws9R6U5BNAbhMHUygR1V8kE6?=
 =?us-ascii?Q?Dj5cqvbFjJtaehquaTr2kkp5tUQ1oLOBhtUwjcyc/2osXF5vfFhuyhpisg8q?=
 =?us-ascii?Q?Mr2MmvPdmHF4Wl6Um6eQ+HN83Rf9OVXFS0zftkjxULq3Gt6fvI2USanGmEWV?=
 =?us-ascii?Q?NQncNFRxDcGqU4n3nXUTypcM6dVmWTIU6sWCSsTkeEIfIA2uizFxqs4gIXvf?=
 =?us-ascii?Q?hsDNpuKmbxI5Umm3BG4o8U1vbKd62wue2JMcIcMudISmQ0N4qUh1gbpw1SnN?=
 =?us-ascii?Q?3glqDVhcGzwnQJNcGvoHAWuijQndgfs6P4ZmRja96qKzM5b8md+XWwecDkGV?=
 =?us-ascii?Q?PSCWIrrtzQqjawxldwJ70/p9UmxRbbZzGURcfrPi67pKqlxi2nMsjuZ+MqMO?=
 =?us-ascii?Q?lhx9r3Q/1Ieb2/F+Nu3QwVj9nQTkLCVr1es3f5Oap1ZR5D39mvF7wxK7flVi?=
 =?us-ascii?Q?DS5Bw+Bo4ePfETO9VJCbSzz6lj3DK+eMS4mArWJqDORQ+LcOwsEgY49W+VAg?=
 =?us-ascii?Q?jzEw/g0I8njkWgnyBkaYgrCrFOWy3Cy7eQ55+F83ysRNRg7mxmiiFrHzt0xI?=
 =?us-ascii?Q?Mf++CdpwIbsjQLWW+NIKNAqILRPbIlc/UxkJhk9fo+N8Qp2HrSO9jwkX1ysy?=
 =?us-ascii?Q?rlvtEDfHI64n+w4wzCYGNZSlqsGSgN6elRKrWZ63hzrU2Pl6FvtmSwL5B+FS?=
 =?us-ascii?Q?oyDsIpD4biJLMTywpwt+kYGE/ivU8AYDw1HuxbqZdPbOkSoa7YAqcx94NvWH?=
 =?us-ascii?Q?WNMUZkjGiEcOGUxZn5AbmVVVRY7iobUl47U/TM/9NtQ3Ii3YvrCZt4lmT2D0?=
 =?us-ascii?Q?TNf8VhwfZlrIeX4VkvhAp99DBqSuxjjoI8tBCMMcftfG8pSEbS29QmDmByWG?=
 =?us-ascii?Q?a7FPsKnifeD9Y76DXGaAFMewBBr7+8N6yWr/EmglYA3O0oFAR5sJXXSa9W8m?=
 =?us-ascii?Q?Lk5dCbtVqFxHdgxumBjKz8yEVj7g/YE8/YOjcDE28NX+pRmu7jc4mlH1GGCh?=
 =?us-ascii?Q?DUnhntINuQVnisM+IwctkKBNpoW25U7Uz9ib+FasofVG2viDHOmLZhZPut4n?=
 =?us-ascii?Q?x/4CtrT9x6LC+p+M940rVKxy5wOlQjtd6LT0a7arhGToxv1BMXlMbuRVELhl?=
 =?us-ascii?Q?xiiga2VszlUUQMGjH50Uvh231gONJKiyr1nVYLiN6K2+mDkeNUxpjs3JlQLF?=
 =?us-ascii?Q?9W1jPADh0f+y9gTKuP2okpJocEUzYlpYkkFkPbZnjZmSLNVR1EvYHmtaAGB1?=
 =?us-ascii?Q?wg1Fvy6okou95/Vk/y735fOKq8kfI0kW4zgu29fq1kyfL3meUUBZcbixSsiT?=
 =?us-ascii?Q?4rl4fzAsDo/ARpw0XdSM/hLL4iI9NDfefW9d/7lid0ZZc7KyGBcCMcjx+IJt?=
 =?us-ascii?Q?bCZl/cRAjw=3D=3D?=
X-Exchange-RoutingPolicyChecked: Qr5ZFiaJPlEkAQxMFIO53fMGLmdhYj89RZVjcxNatm4XC8WRSsw8UQl+M7zCwSeidsv0ic6c24GM5TU1T70yQjiByT48qWJhL0aHu3C0Lzph3TJeI4mXJt5xX4fdULAHpLqsjzVkUqemnB1Cfayo7KSzjln9OO92Yz8SD9luarq0xGs+dkD75CMFmD+hnOm3ABpcrYqmtdPMXUvoVGqEiOwBtnM0BOxBMLXIQSUhWssFg7QXDS6knu43s7O6IRNbFUjr03p+RcSgjN84r1r4mSa/iDKSSNTBMCloRmfjNOE/qi5JUVArvIufztNp4dmXzmHSV3V8u780yuSEbrEtOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbc138f-0f7e-4ed5-f455-08df34353a5b
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 14:18:53.0484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MGB8TzxP6CJN9BlqrZcOBTdOTk/rKh2Hj7iXP7xEOwNGjweo3UuMU2bNcUBsGTz6JMoPM4/tImsdmYmblawWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR11MB129532
X-OriginatorOrg: intel.com

>> Can you replace fpu_kernel_cfg.max_features with some fpstate->xyz
>> (sorry too late to think it through :)) that has CET_KERNEL for the
>> guest FPU and not for the regular one?
>
>Sure I can give that a shot.
>
>There's one minor issue in that we need to init dynamic features which
>_aren't_ in fpstate->xfeatures when context switching. There's a little
>note about this in restore_fpregs_from_fpstate().
>
>I think what you're getting at is that we need _something_ to say that
>KVM fpstates should muck with XFEATURE_CET_KERNEL and task fpstates
>should not, even though the task ones have space for XFEATURE_CET_KERNEL.
>
>That's certainly doable.

Sounds like you are talking about something like this, which Sean
suggested in [1]:

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1015af1ae562..8e7599e3b923 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -167,6 +167,16 @@ void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask)
                 */
                xfd_update_state(fpstate);
 
+               /*
+                * Leave supervisor CET state as-is when loading host state
+                * (kernel or userspace).  Supervisor CET state is managed via
+                * XSTATE for KVM guests, but the host never consumes said
+                * state (doesn't support supervisor shadow stacks), i.e. it's
+                * safe to keep guest state loaded into hardware.
+                */
+               if (!fpstate->is_guest)
+                       mask &= ~XFEATURE_MASK_CET_KERNEL;
+

We first looked at enabling CET_KERNEL for all tasks, and that version
included this optimization so that restoring a non-KVM fpstate doesn't
touch CET_KERNEL.

We then switched to the guest-only approach to avoid allocating CET_KERNEL
space in non-KVM fpstates. The optimization could still be applied on top
of that, but it was dropped after its benefit was questioned off-list:

"""
1. It hacks in an optimization with conditionals around the edges,
instead of integrating with the way the rest of the FPU works.
2. There is no proven benefit of this narrow optimization and x86
maintainers are already skeptical.
"""

This optimization can be added back if it benefits kernel shadow stacks.
But os_xrstor_supervisor() and os_xrstor_safe() would need the same
handling.

[1]: https://lore.kernel.org/all/ZM1jV3UPL0AMpVDI@google.com/

