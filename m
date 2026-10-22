Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792660934;
	b=2ensdsuBJ00caO+rGaR65p5vHd510RsF06GYvanzs2KK7b/2bLzMKG0SgvhZXE+6zL4g
	 VdiJRQigyhr9XJXA6akGsio4NsprXEqGlJ7wcW1evXOhg11vG335P3/5gLR5pacVG9ETY
	 Uh4Gg95Quc9O9POy11qzGYUvOvlsM3+x/PJ8D1mUhQoHEMBHv++f2xUEZOj9tLt87VlyR
	 3JSWUBZC/VR1Vfvq77bgo6S0PbHRuHw0DPgpY4CMgzxVQSw/2zEPMq+hvdZN/tNRwHz3/
	 gFKbBe/Bmei1xK5oecgw03hKkHycpQQVBTaojyNKF7btrZFabaDg3MDYNninWkl4iKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660934;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 Reply-To:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=VTWTwtBXryjhdVqD0iP+76jkojPOiCGAHlwbCvl5HBI=;
	b=Ws02LVm6UDPoJbJ5ladLy8Pkm4vJrmPnF9MmPtjgo327iZurK9kZeaFWpHLVFpS6Z2Ql
	 KxG/huboxa0wjhRk+J30qDiRi0xqlgBT4xtefcA4EBA6Gj/QWzgdZaEPtgeTX41Tg8CSj
	 gHNxPIIMLtMKkPR1fneVNRgHRel9/579yRU/RDl+7Kp0900OmbCs2bbsHoVJlELohWn2r
	 oPM68Rcmi+ieDNA7v2T8z549byDVxhyiUkt+/EuoRO4GHiPW9FVwldhQHmOfG1U1LOWz2
	 DRIj9edb0gIBAOH18g71zpkk14fCKxXFQZQhK0o/i9mmLDK/afF+vFFviD5o3TgxVcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SzTaZRRM;
	arc=fail smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B414C606A319;
	Thu, 22 Oct 2026 09:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B414C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SzTaZRRM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792660934; x=1824196934;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=0QTf9Jk7up3ewOXOR9gUBsVxO67x8/9ytyaeE/uJf24=;
  b=SzTaZRRMtzVTNEXU3WqDT7VR4KlNWtfNOm+Pzv9AjVHXIQDD7cvzshYO
   vpdbOBnfWOwZw1UbCIAHxVz/LRMNrcK2kgQcRr0ub47o1DQEWcZG/H0E5
   wLQXizwT+xuJlZIe9WHnDUHo47IWD+uwWN8wJZlqQvDB7qhuZxpswJSSp
   MI6YP4Lyr0JqlFM+n07T+vvkWUK6kcyG4BCV5ijV+t4zIo2UnY9ZdgT7/
   WBCyI6bAMKnvaIPL+WG+dq1ycdNjk54UVkLBS5+RcnPCkD6Iy+OOYZfDS
   mVBeuMQjCP5iBLknVyGmqspQpv6/p4tZfzFWDzgN5yu25AvA4kVqU+nao
   A==;
X-CSE-ConnectionGUID: mfUOfIeySMKsNTLPepZM7A==
X-CSE-MsgGUID: SFEGHgyyTQKEZ8iflezWvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1284965"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1284965"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 02:22:12 -0700
X-CSE-ConnectionGUID: EhTX0TZhR2SSd3fUfTECeA==
X-CSE-MsgGUID: DcxqbqK3RFyUmGEYiH5jfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3665118"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 02:22:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 02:22:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 02:22:10 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 02:22:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxuMPAgU+eka2sHxQCzedT5gVlzsWYTGDdEVx5nXMcoyMjThurs7S5O81a4BSLHhdxI4oXh+S4GqM3pulrxzS8TZgV6ZxoW9O7LrmjBtICxBYKdtzn5Dotbp7U6aKHWw8hQne+CkFVMfFu58dBajoVWqdsyU9ckdyQdYbNWj27+M9qVCAsh73p+6nCW5IQS9z3OZXgL2jCaQHl2+nK280akrHkMpmXBEgPB66APhhXkYuuzyxEYX5P/mBRfebU5YGnTH3HKyvVk8sXA5R7CX/gLAbk+eOdoAAOodng1tkPLVULDBCzuCNcwaJvupCrEBf/xafoJGnzG+kGPBeYsB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crT0Gywz/UrYUvzm7jovYddTI7CK3kQqG8PX7q8N7ts=;
 b=qDvzz5/u2JchnZCog4G03c+r4wx5tiD+OS7AlrPuE5k/reP+s7csDTQMdhwhD/AyD7cnsgcMXaGgnTdlX/GFkRVBBnMi3lutmcfgQ6CeDGB8+lG9eGqmIFSwGQs9+g+YVMSSM8qxpKgdqn0ytmRgctk6eLsR8XUt2jxDZLU1Sbn8yKaV9qV6Q6XctURAKYYSbqgysmxRe10VAIwHoQ77kJyQfydNpoL+FYRN6fci0V8zls9Z3zOI+o6mWrvlyswLOLRewp8d30wLU725v0b5XT+xZ7FlWZBzP68nv9i7/UPe3nmZ8GCH5n3H6hSJvdVV7kGxGlwTOdTkZcTSZZPXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by CH0PR11MB5217.namprd11.prod.outlook.com (2603:10b6:610:e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 09:22:07 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 09:22:06 +0000
Date: Thu, 22 Oct 2026 17:21:08 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kai.huang@intel.com" <kai.huang@intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"Peng, Chao P" <chao.p.peng@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 01/17] x86/virt/tdx: Enhance tdx_pamt_get/put() to
 support huge pages
Message-ID: <atnVhGt7LKTKLurI@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
 <20260928090808.15484-1-yan.y.zhao@intel.com>
 <e494996660b45273590860e961b36378c4099c03.camel@intel.com>
 <asoQ/P7sghrEVDQs@yzhao56-desk.sh.intel.com>
 <ea3584fd5613223ee066fbd368272dc7070bceec.camel@intel.com>
 <atBLdGBCsPwMK7Sh@yzhao56-desk.sh.intel.com>
 <896585225b67cb215db0ce66dece20ba8fbb919f.camel@intel.com>
 <atW6Il1yN85IA1Wj@yzhao56-desk.sh.intel.com>
 <ca949948073ba2079db578b7a27108db6991dc1a.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca949948073ba2079db578b7a27108db6991dc1a.camel@intel.com>
X-ClientProxiedBy: SI3PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:295::10) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
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
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|CH0PR11MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ce4023-4af6-4cd9-515e-08df301df0ec
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|22082099003|18002099003|261021121427099003|4143699003|5023799004|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: CMa8HPzF2tsrUcATtzyM36DR/Movkt6ZT5LEytiTqR/f4FwSx5re08OHrIKPnzaOBayGSdlhs/OzNKok5IuNM+64Wi4jo6Y6QbZX1Erm87zFaHMjYfDhZdKEOc/qOwPKGRqHUJzUSD9fNaGmWSZrNHXd/aTp7cfB3aoItQl0o5LcnGen2pbQNePDqGokVWa9q8lry3pK7jCZsS0Yidv6IP31IE8/TzDS4K1kdxXeGxsvRj5mI76LDrQsoIk+mVUXwPgVxA0oJMWWALi0X6k2LTWYSPZZuJIlCLCdoy1yBRXQFRqErRX2nKVaJdSGqr8UyuAaTuyUEypz9jnudBH2I+hISMmOkx3hqLNenGCT2L5NYdeNukaXU3xYBarAd2uxsm1WZCRkUIoiTY93lo9i8ZxfGOn30rt1XOrcZH8hKkVD4rnD2HVvzlxyVDk9aWoLNECHeS7wv4yYE0cSUOKRfr86TdSz1wW0lNzjDzK1+/IxSUsRxLB6SurDYv6cPCyrQGu6ytVfxqS+aMb8qqeauRBLUyOyGWbazcpXLaHaYM3Siz+LAu9AtB8Hlc1A4vWNlIdCC2FlzfpqB59YSXKcv9uZt+IzFnrFG2jujS8irow0XGpHKoQbutu7jmlVw3LJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(22082099003)(18002099003)(261021121427099003)(4143699003)(5023799004)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nuIeFIUocai3zE9tbL5Hi93N8WMtLh7VEsGgy89qCjptHrAAAJSjnZni6c?=
 =?iso-8859-1?Q?j1f7ktPf90nQ7czNZxAJyJsV0lyxztpljDV3O62K78tbNjJHGdS981VJkM?=
 =?iso-8859-1?Q?uZ6wj042Hox2MSMjaO+wtyIwuORU4GiZVayLYe09cdnvOftRDv8SXNOql1?=
 =?iso-8859-1?Q?mbekDp2yl5Q+Sxom+nSIHIyEOXOkoPOckPL8NUArN7IDfzPamoGqVq2ECC?=
 =?iso-8859-1?Q?aUEdF4j8kpF+Zo8xzRLW3TZ6g85X5In0f1HIrM32TZ1YiKlZ+0Lu2RARwR?=
 =?iso-8859-1?Q?UiWaOuwZqqHO9K/iUdkN+IvfLR7TpL7F4rB+pxEx949q8QoI1OsBt51lBT?=
 =?iso-8859-1?Q?zQyK/u0jUgek0V7WJUqPR6HpbgHl/AgdICikyP1AU13J6xu5h6tTszj5fL?=
 =?iso-8859-1?Q?lIDySgdYyPKbe8rNWYuECWrX97MHULVLKNOSBxfZX8RL1YYpipo2xOKA7S?=
 =?iso-8859-1?Q?x5GN/XswUAoXxIYLCLy4bYnRU8qW4D8h3jIFZTrkmqaqATo5agP9bg2P2i?=
 =?iso-8859-1?Q?AVqz+MrmVJmWdErIw3yC9NMU5edMVw/3TKYyFs4/b+BFKZjnHpWYJy9YIS?=
 =?iso-8859-1?Q?waApIgEuTm1x/Dn2WYMwdbGFh/spAatQMv4f0exQqeJKngByKryutgI6a+?=
 =?iso-8859-1?Q?F5CEy6LHjn6JtVxbFjOe/wpV6eI5lHdmrrMgPemIfUF3W1xWPBei15+tHv?=
 =?iso-8859-1?Q?eqahuBkTDJZFWP6pTr/RYurhEz2aqC2BaR9CxmrpByE8eMRhxh5pmGmR/p?=
 =?iso-8859-1?Q?SkjZiNBVvs5iPziOiBbsHhLS7S5s0Hzm9Fe5kXr7OJ2gfeWvQ5Qk50T0rf?=
 =?iso-8859-1?Q?H7s8EAgfSzPh3ElV1q99sVRqYhQwavEaIlR7MZBZCirnS5OeUDgqgL6lDB?=
 =?iso-8859-1?Q?jEfaw+qWdBhjerKzrHZS1F0Y7FdnuvxkJLG3z2d9DNlOGkC919fFnZomFR?=
 =?iso-8859-1?Q?BqotakUZbxhEKykDNRCxSN68YLtP4FVWsPiRtOUvmJTpKVoNPUKXZ65NsW?=
 =?iso-8859-1?Q?WR3NNmKPKU/YqOMD4Bf92nqeMZLZKzrTS1YsU7ARUUdpz8iMTsKkfD5Aap?=
 =?iso-8859-1?Q?tOMyFtl7IFRgpcSdkTSszCbvUVdv5hAGjLAtGoyqLRrmizttpS+P+P+FYf?=
 =?iso-8859-1?Q?90MY6aQaGOvgAP/thdblucqT4Ku2mLicpusXrZolDSiA/mEmnr1Dhgl2P8?=
 =?iso-8859-1?Q?1Oguwy7k7yyikEbjrKAwt8Ov1onAV5eDpSpMr6qRrSTXXrRgBAfyop655g?=
 =?iso-8859-1?Q?GvrOMTVhC3GKiZsY/AZB+wosejpW0/89s/2iBEbQy63zBFD2Lh2yenScsD?=
 =?iso-8859-1?Q?xPv7ZBz68E+NOKH5KlbxGH1WyaFupuOitTQLJsrl+0uFhOLbKGZwfsoLHF?=
 =?iso-8859-1?Q?JXSm3o/a2PbIaNw78LtlIF5FdXvmHeMQTANOURNyEMfa7DRV2mli+5GUqf?=
 =?iso-8859-1?Q?pS1OhwWMkYo8Qany/1FH+Am9YyVhp0OR+8AOMpYV6+cheJUiqybCsMxmUN?=
 =?iso-8859-1?Q?+/laIO3OdSH3yv5PdO3qQ12IlWIbqY9GW3CCpFS3H98/SqLiHIINbIogY8?=
 =?iso-8859-1?Q?v7bfqjmAb4sNrYIorXXTwXY3FHotTMNZbF79+++KBzgN5CvaTu+Q5TM/lw?=
 =?iso-8859-1?Q?q5yXzUdl8ScChK8hu5i6pmmhfDLLm6qD6rnPTdLu+j1+usdWMCMNK9SK5G?=
 =?iso-8859-1?Q?vGl36kWt1UvqvRGcLa18PbObgRd6z0IWHGGG8l9u1Q5fX2KBWCimWZJ3xM?=
 =?iso-8859-1?Q?UIR5s8r3TWWFsTqcEYE+Zj02s52WCRVvVt4mGf/2mCkTyZZ7VpY6JhNBQ1?=
 =?iso-8859-1?Q?tbOwIytaoQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: XjsIaWX/nBRveqb1/AuIfNcYDY+2+wG1KequUvkc0zpA7+rDSNeQhVrQMCJtB18/ssDYqnhHjhKwgVn+fOX5xqiM2kwwEtMMEunrDh0AJvNnPIUgpzYw0NY9SAzvnzw3sqpsidwZp1P5n2IOcAChv3G3+mfS8yXmZUVrO9ULRRWHjtpJHEB5h8da75U/v4n7ZGovLbIl0tqovxTT6AJTt1hn5q6AtNA9+qslxJGheRCfpOyTLcscn0cXNE1zxHdBjinDxLFdN9uNpT+pf+Mpdr+buwdWjEyDIg7yPMEUZXguqByIuYXe828mOQUzAjm1RC3luzzLpt4hZ30kI+bfgA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ce4023-4af6-4cd9-515e-08df301df0ec
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 09:22:06.8394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPU7zxIET6pGVegcOEgqGTUpkFrc33kbKH4Vdh4qNjlucPQATPbBqPQMJW+g0sY46KQJHriv81G+LsC9s6TS/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5217
X-OriginatorOrg: intel.com

On Thu, Oct 22, 2026 at 05:28:32AM +0800, Edgecombe, Rick P wrote:
> On Mon, 2026-10-19 at 14:35 +0800, Yan Zhao wrote:
> > > Then the contract is simply:
> > > 
> > >     There are only two possible mapping levels: 2MB and 4KB. There is a
> > > refcount
> > >     for each 2MB aligned range. The mapping level will be 4KB when there is
> > > any
> > >     refcount for 2MB aligned range.
> > >     
> > >     tdx_pamt_get() increments the refcount
> > >     tdx_pamt_put() decrements the refcount
> > I think refcounts should not appear in the contract. What is meaningful to KVM
> > is not the refcount adjustment, but preparing and unpreparing PAMT pages for
> > the physical page KVM wants to install/uninstall.
> 
> Well get and put are already refcount associated terms...
> 
> > 
> > Whenever KVM invokes tdx_pamt_get(), it wants to ensure DPAMT pages are
> > installed before installing a physical page; when KVM invokes tdx_pamt_put(),
> > it wants to ensure DPAMT pages can be torn down correctly after uninstalling a
> > physical page. So, perhaps a more accurate naming for
> > tdx_pamt_get()/tdx_pamt_put() would be
> > tdx_pamt_prepare()/tdx_pamt_unprepare()?
> 
> I don't see a reason to change the just settled pattern. It went through many
> rounds of reviews and no one ever objected to the get/put pattern. AFAICT the
> only scenario where it doesn't fit for huge pages if it is changed to accept
> args for other levels. But as before there is nothing to do for those other
> levels. And the callers already know this because they have to top up the cache
> appropriately. So there is no benefit that I can see. And following from that...
> no need to rename the functions already.
> 
> > 
> > The refcounts are internal implementation details of tdx_pamt_{get/put}() and
> > are hidden from KVM. It is tdx_pamt_{get/put}() that decides to use per-2MB
> > refcounts to track the invocation count, and ensures that PAMT pages are
> > (un)installed only once for each 2MB range.
> > 
> > The contract is therefore simple for KVM:
> > whenever KVM installs/uninstalls a physical page, invoke tdx_pamt_{get/put}()
> > and specify the physical range by providing the level.
> > 
> > >     tdh_mem_page_demote() increments the refcount for each 4KB page
> > Since tdh_mem_page_demote() only splits the mapping level of an already
> > installed physical page (without removing any physical page), KVM does not
> > need
> > to invoke tdx_pamt_{get/put}() for the guest private page. As refcounts are
> > hidden from KVM, KVM is unaware of the underlying refcount adjustment for the
> > split huge page.
> > 
> > On the other hand, since tdh_mem_page_demote() will install a new page table
> > page, KVM needs to invoke tdx_pamt_get() at level 4KB to prepare for the new
> > page table page (which is 4KB) before invoking tdh_mem_page_demote().
> > 
> > >     The mapping level will be determined by the refcount after each
> > > operation is
> > >     complete.
> > > 
> > > If you want to pass the level, somehow it has to be clear how the refcount
> > > and
> > > mapping level will be adjusted for each combination of operations.
> > When a level is passed to tdx_pamt_{get/put}(), it indicates that KVM wants to
> > prepare/unprepare PAMT pages for a physical page at the specified level.
> 
> As already discussed, there is only one level where we would need to do
> anything.
Hmm. Ok. Let's drop this patch then and have KVM check the level instead, as in
the v3 implementation:
https://lore.kernel.org/all/20260106102304.25211-1-yan.y.zhao@intel.com 
