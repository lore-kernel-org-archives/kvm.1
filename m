Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795439427;
	b=JpsUGS7eB1TMh7q1T1/WkFrP/J8jqqMciF8A3eE/nGRioZkH/SVDSVllhxGLzEw8r7wF
	 z0UgIeBLbcLxwWjc/0XfsTEYgzHk1KF2ZaXGxpiXAPPl+coR6B0F7Xxz29j+eHz6OsZ2c
	 5YNCk2ONv3Oq3L8DRm693RLS0uCPA4Mv3irh4qEfCxo7zANF2MYLFasKJMANCoMKC53JU
	 HO3LOmNrWSSno08YhDw7yyD74RwcRsQXv0kpqG1i3XO6EfuyfjItKmnVGbn4M8uqgZawC
	 iDY2TjV7EAefKccw/vo4FrPFNBkwmDBS7xN3Wrtgde8JrDZNUwHesgFPxi6yl9MZ1YQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439427;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
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
	bh=zuRGWBM+ZUDWB6ViMPl05cY+4pBOo/9SflZ5cCKYLwE=;
	b=Cu8V3sP/T0IwnYY1zt8XdXczP3SUGVq2qsNGB6BRrorr2O2TsRu+OfQjvzkYkAFUNHLq
	 bqrTltgLJ++s/hUOgo/GGGt3ZSziwe54O1jKxMJFGBjGTvvIK1m6SPzKqQk8UmlmXhzqT
	 xyaL5diQSn5Xh2NDxorRLX/c9aAv29GRgfWFbRIDcV0cy2KUXnV9SHHBSXf7sG6Py6XPh
	 GCcYINApVdoksidE0C2CkSPco8+RNRwpI3LkTSoniTUd6lZZtSgHq5rMI387TYfvvaLxK
	 Ez2wVVllLmnQ3V65HH8xVPeUFL7c/mahSDG3+0K+4ZJtGtpRiA90A7XOOSsbFOz874A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xg3jf7qG;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=TupAXMyt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ACA606A31E;
	Mon, 23 Nov 2026 13:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66ACA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xg3jf7qG;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=TupAXMyt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795439425; x=1826975425;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7rXXQzvY/JrpCkNFZy3pA9SsdGoLyQNWuZbvEyh1huk=;
  b=Xg3jf7qG9yZ1x96VPOPSsyWbT8FwSsbVvCkwwfbFZPOpf41Pqa/fUVsf
   XiRQ1zzM43XJ+bj+4a5JW/F1UJ3VsV7P22iE442wqnLgf7PchodVvTbVZ
   odGbbTVHtm8YX3zSpOaNMBqm27pqmFDeCYjsKbd72jv/hdvgAJuK9ce6U
   h4SK2Ftzozcg9RWR7DBw0GUDWQtGkQSDpNxkz9jIHRHGL0286/AvRDpGS
   S3EPurWCyum8VWw9NxtnNOdogxvaLV1Qy6fzGGtQPzKdyRUBnXg7caUtk
   yTDZ1Nb7LxgsLmb/RqAY8He7ElOMPZfMnVC4UjJqxiBO0R5C9nRGsuz9w
   A==;
X-CSE-ConnectionGUID: f0qEmwVmRliHG07jO7JVCQ==
X-CSE-MsgGUID: /+KLzFtjShuS539X6T8uTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4257698"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4257698"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 05:10:24 -0800
X-CSE-ConnectionGUID: 1csxLiXYSkCCtlq1DDxT8Q==
X-CSE-MsgGUID: E0W7wnICTxSQWcOAGsTcSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11610029"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 05:10:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 05:10:24 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 05:10:24 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.56)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 05:10:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBRVV5sBEN+FjPFL6jYa1qBdfYN+e+Qi+bVjfEhi1tLiYnb3ApHa6Ri4PpaiMVeXiLYDTz+ciSMU1M9RIqiqEndsdxJyD8FB/1pr6tFHugLYOI8oCjBYaM00kf/iSsDLLper0FTQagVmU42JanrE8NjTuKeBIKF5ar6DmQveLjdGc68jnnYsEUUbhNCLkr8NNMjQLpvjxKvvqiQcLm2BmVcIwXjO97wdq/2O2kekSDi536YepokBemCX7gEgC/fCBNfF7aS9v9KOzxlge3PzgdJNbt5do7FXvdvLWoeHue2w+9QMfMI6ifhLf1M6TazruJjTzFwyFEdviWXMkffDuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuRGWBM+ZUDWB6ViMPl05cY+4pBOo/9SflZ5cCKYLwE=;
 b=q0DKmIq0Md9/dllIe9t37VZ+GK9rgnrgEN04XwOgzmtGTfJjKNnx4chIKTBlMLvRpLumSHRvnFx6IvxbLPDqVlQlmX4KVhr6TupE2/PbJEiFIC+j5GgyikImIYRppA8y9j2eH8l6CM4yicK8XtqZLi4xBLs2rfcENA+D3/b6wzJ1NwsiuzhM+YOPZYvlHxxEEmUcAOQQZ5mSu24pBKhRBmHNMfuyQ3Hh3tKOblN9SnjW46OTZlOXm7OUuCf8kkPJXU5mz5XUW2VcUPxJZupYKkTNR6AU/vD6epqLMAUMZVM914DHaeYnuhToeDTixScYyQDlQuzRqXUFJIfUAOim6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuRGWBM+ZUDWB6ViMPl05cY+4pBOo/9SflZ5cCKYLwE=;
 b=TupAXMytzsE+3JdJ4PX7135BjiqBJ3Bc3Kct4Viu0I2OVKavIGaxZCaGwTW1wxLTwwIKeSBPEn4bC2A4pASms3I5CfnNgU+lTrCRkMMArcQ2K9s/FoJg9GZ7GxP2vOB2jLZ+/Q4odt3m87WE6Nky4xCYZrCPsnD+m68peypWZCE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by DS6PR11MB203949.namprd11.prod.outlook.com (2603:10b6:8:49a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 13:10:21 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 13:10:21 +0000
Date: Mon, 23 Nov 2026 21:10:09 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <yilun.xu@intel.com>, <arjan.van.de.ven@intel.com>,
	<binbin.wu@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v3 1/2] x86/virt/seamldr: Support large TDX module
 binaries
Message-ID: <awQ7Mb0atIOtP1D9@intel.com>
References: <20261119074925.3933804-1-chao.gao@intel.com>
 <20261119074925.3933804-2-chao.gao@intel.com>
 <bed831ec-b4e8-4762-83e1-f4a72075fa9a@intel.com>
 <av-3OatHEGZXmWr0@intel.com>
 <c5940627-54df-4ce7-86fe-f73520b61791@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5940627-54df-4ce7-86fe-f73520b61791@intel.com>
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To IA0PR11MB8380.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|DS6PR11MB203949:EE_
X-MS-Office365-Filtering-Correlation-Id: 35dfce6e-a62e-418a-88ba-08df496320da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|3023799007|261021121427099003|261022105027099003|261026121527099003|261026140227099003|261102123227099003|261022075727099003|261028144727099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: R2SJ/I7fxPp5CNGXGK8X3V9sSCdXi3RBjp0xgqK1npbhMylANAfrx7urMu4yHU6uNt6Wd86YtsaAZ8jzRd5rTLHBK1EZs2rhSMneoJcQq8hJFNbtmcYIpimPvuN4eqjB/LIdhADlxVC8aecOpZq/2gJ09tBGB6Ndm9BZ+PTT+nRIfacJ12z3lE1YTPrOh4L2BspnzRxBXf7GVdZH9FgD5HEJUJ6rC3D2TRb778aqXtZt8R5xo8wk4zLNnaYWlaKRpWgAOl4+K1zi0ZYgDdDv1hWLQa2SRuBbMB7izMew3pufZzWO5J0uBlmC9hL49tJqFfAdMAI0vYsARUtslS/5mcrVWdfFZA6I3IT4c5CB1ZQjDHDOm+CzNFZf6zvjgU4wjC6RcblTULnVhJ79vmCJpM0MRW4gS12RzfeKsG3zYpvSJUVkpwshqLo1nIgm6ItJEZWmO/Y7yz0kWzWN//J+pGgfy7+KCBjqD3mH/tBfgOQMSvAVm00W+KqAoKVdO3dqkuW8D4hjNQRbxGDfJ28FA4YWj1wLl4UvXr4fucJOKY+ct0NPIgt/rSCzfD2GJFB8Czkc3cZCMasjgXztYIzRL5I7JlkSxOcFht718luvFR7VRVRfT/ZRlrmYgtjQgruIDkFJgl1250elc/5B4YedAVZ/qskTGjK4uF+lBQyYt1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(3023799007)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(261102123227099003)(261022075727099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iacf6LxzRoIn8kZsmflEWbbHfMXt23bzbXHc9BHXX/EEXBiPVcjIH/At0F5B?=
 =?us-ascii?Q?4b713YZ5KU9LSLfufLl1Rt4D2AQXEU48h7Cu5AhH1W+7dEPJl86iwdByERs9?=
 =?us-ascii?Q?qg68J5Fdfv8PTx+jjAl5ayXSN89+onxsTC+TI3MofufHDYgEp+eTsBUsjglB?=
 =?us-ascii?Q?Rjv6H9yKzE81meZ3qQ4qblcMGopWX8GVfCMsmMZxQBpCG+8yCpAtSkfuH/1v?=
 =?us-ascii?Q?YcmPUK/wttRlHe7b6wou9rDM+vBaMi4/9bLmQLTxEajFpUiAZNqNxVhhiUlZ?=
 =?us-ascii?Q?PKMRTZlTV7YK5GSgXAujuQh6bZW+7H3NgceB8uCnRqlLHku92td/lG269sdc?=
 =?us-ascii?Q?a3sEOMp5O3tIWDr4ucjI1zDJ11dzSSi2IO+XaR+SCuafNaeI2kseSCbUu7bd?=
 =?us-ascii?Q?gC2VnEOyjJDf4SY10UtWBA9uTZVeTBWZIKsDPnxrawkYRe5YYLcKZTfV+KP7?=
 =?us-ascii?Q?P0e+Js5BOdZ7RUhmMWGxp+NyHj8RTA21p+YYMa9tsWJosarQ/GRpS620vV9C?=
 =?us-ascii?Q?JalEeqdWKQURscsPJQf9z5NUBRK9lTCQ1MNpo62BxEZXDhVSNWllDh1AeSRX?=
 =?us-ascii?Q?XgjpFI8B0HE5GrZl7lSebMcyzU4c6ghBfY1Gy3tMJPFbe4dVNPd563/uLR3M?=
 =?us-ascii?Q?zZSiUUT1hC6UJ6T8QO85ZKNHqHjw6Bjc/u1qocTjgelNo+cJN//rWjn4N5EQ?=
 =?us-ascii?Q?fXfVNvLj+wQIIUm2X3noiOOEr7Tka4+TxQ+zrqogndyFMaOiXuDPiRk+5W2b?=
 =?us-ascii?Q?RFzxJN/5t6TPgFPrY+qX2qfVmAe/BMk6KN3yb9mrm2gL667RXL+D5NwRiMg4?=
 =?us-ascii?Q?oQjGefEB+BX+TtAwwUgfLnee9TFo7WYl+af3nX8HeQDuQ3b0hYTTLPZgk/5m?=
 =?us-ascii?Q?okSZVM9C/JLpKHpbuxsKSUrJOlv4PXX52IzDSm3xWwrUtonUcejJ/+ihbqvr?=
 =?us-ascii?Q?BmJb2oZv5ne+wKpx8Rt0eL1EBmXxJBk5IF1t/7HLOZddHjnFSrerrLruVBoY?=
 =?us-ascii?Q?GMFMOVY2mrFvnadtN2mYjIsoRVZToDgA0ANzqAw2sr78b72LaWWq841DGUkt?=
 =?us-ascii?Q?DHNTvvB/UKZAB/n9ptJSV9IvhyO6WfGLryNybf25/sn00GkWj0C8umQ1icfB?=
 =?us-ascii?Q?KYOT5EP9iN6EuaP4Ktfc5H6D4qbTm4EdZZ3j5JXU5l3xxRu29vG5x/Wefv9z?=
 =?us-ascii?Q?2KSAQJ9he+Kzi5exPE/GRQxncbANLLuLkS3xFfaG049JimJ/lpoI/xWAdfTM?=
 =?us-ascii?Q?m0qDtH/oVUPS19k+TtKWPIZYQPPBXNF8yI8H/sO7e9EXFvzzZxZ1/zJ7TKJJ?=
 =?us-ascii?Q?rzGD3dFH2ARClobPdWUSSGdbra1RQGVJNBvYKuan0n16sYo3GnMG4Ej2BHLZ?=
 =?us-ascii?Q?h//qWQYtpyjEsPg+/VzDY3tASdbICDPOUvqxlnKBVSddq/gHJplvRn7fBxj3?=
 =?us-ascii?Q?8wJBtGQT0ch5ZXX4Wance2Wf5IKiWvkhWR9mY7S2I38Z2qrNIMxPUOaHkLfe?=
 =?us-ascii?Q?kan9VVmqFWNxs4lp31216A352xiZk+SB7DDqNUxJJOfGcrYoVwA+p2fiptXD?=
 =?us-ascii?Q?GkuYP206GIIJ97z0GoaVCdncIvX4yAqwomiyBhiNcTPPi9ch54OwyGQrfQhD?=
 =?us-ascii?Q?NwYafBLUK4tlkncdKWRGivmImlrmVFqcLLuX0ZtsRfb0M83qP6kdYJwsSf5a?=
 =?us-ascii?Q?a7X+2T+ahdsXcOe7Onruj80hihCdtWWh8VAl1bLZ6iCqlUql7c+IG8XFzDqE?=
 =?us-ascii?Q?uMM2hJofBg=3D=3D?=
X-Exchange-RoutingPolicyChecked: Mv3b7NGx/EMKDFM9GU6mC1/npuWIraPAP2Fsr2lIqEKRP15vG9zKMzNr4Zgvy5QEEYqd36G4I+PD6G6CWpsq3Gs7U6QVgy6mPwh846PKhsdobjVGy5PMEUnZhof6EYU/dDwbjZ1nWG2kgIR2hJ6ngfwABDmbxa3/OliZ18gN74ZE1HGjysTYEhy0QJYNqlUyANCPp11lkVxkchvwL5od6HLVKkmrfr4XDFD7/ARJmBD0lXl9HdUfwBLoSTCjms4fId4jz1YjU5v6V+zi52vaXh/IAK4vyVAoDmJieAcrovONwcIaa6pNwgxf2e5ZlB+KUfRZlkmTGLKff9BgI9k0og==
X-MS-Exchange-CrossTenant-Network-Message-Id: 35dfce6e-a62e-418a-88ba-08df496320da
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:10:21.5320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eniRc1hVPiNsOU8XUAmql38as+cfHHzPG7AGdjxj6Scl/nW6OzioBzmMbAqAf6+p3AVmwvJ7b9IBzdspw0hiuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB203949
X-OriginatorOrg: intel.com

On Fri, Nov 20, 2026 at 07:19:07AM -0800, Dave Hansen wrote:
>On 11/19/26 18:58, Chao Gao wrote:
>> I tried to describe the ABI structure briefly in words, but that was not
>> clear enough. Here are the before and after data structures.
>> 
>>     Before (one 4KB page):            After (chained 4KB pages):
>
>How is it that the ABI supports this? How can the module tell the
>difference between a chained and non-chained one?

It doesn't tell them apart. A P-SEAMLDR that supports chaining always
reads the structure as a chained one, and a P-SEAMLDR that does not
always reads it as a non-chained one.

Chaining support is enumerated by SEAMLDR_FEATURES0[11], a new field in
'struct seamldr_info'.

The only difference between the two is the last u64 of the first
page. In a non-chained one it holds one more module page address, and
in a chained one it holds the address of the next page. A module of up
to 495 pages does not use that u64, so the two are identical. They
differ only for a module with exactly 496 pages, and a larger module
needs a chained one.

>
>Why don't the data structures look like this disagram?

I started with data structures that look like the diagram. Three
simplifications got from there to the current code.

First, make the pages in the diagram contiguous. The diagram shows
them apart, as the ABI allows, but we don't need to allocate them
separately. It can be just a single large structure, and the existing
allocation code is reused as is.

Second, use a fixed number of pages. The ABI allows any number of
them, to support a module of any size. But modules are about 2MB
today, so the structure is just 16 pages, which is enough for a module
of about 32MB. The number can be raised if modules outgrow it.

Third, don't define the entries that point to the next page
explicitly. They are always the last u64 of a page. So the code that
fills in the structure can locate them as it goes.

Defining those entries explicitly would match the diagram. But then
those entries split the list of module page addresses into multiple
lists, one per page, and the first one is shorter than the others.
The code that fills them in has to keep track of which list it is in
and how long that list is. That is more code.

If you think any of these simplifications is not worth it, I will
undo it.
