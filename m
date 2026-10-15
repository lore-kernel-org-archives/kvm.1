Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C163A4EFFD5;
	Thu, 15 Oct 2026 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079378; cv=fail; b=UJF2STlhU+f/IfFmcHZ2dUWDWQeUfAG5Rv5ddK7COCL530fXwA/qTNNs9wSgdVFLFZDYOT7Kat+i9TkIn8S61geCH2942GNu3dLbNrklEWM5sXnBHq+oQ/foPoi4Jiejyws1sTibLCbDsVl2utBreUXwbSj/yKI3Jwhu5dF3DwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079378; c=relaxed/simple;
	bh=4jGnI6seTN7QrNsz/AY/IUGbBPEfCKEydmRkNdi9xng=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L1dJUuUzfHdwog3VZA8dK8Ag6yu5yWajTamyEWhwZtAT1fjhyyOgEZEMKXRcgmvXim4tZDGoR+MDn7lPPnAALU7GzHzF9jFhcmrBLQgndYKc0jEwmiV6tg9sY56VA7Rt9kXNhyJaQ7YR7HFWtHZJQZyz6v/xzQCOQswvI46WLPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HgxEgBR9; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HgxEgBR9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792079360; x=1823615360;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4jGnI6seTN7QrNsz/AY/IUGbBPEfCKEydmRkNdi9xng=;
  b=HgxEgBR91rKW1D72SJioyQyy+T/sENQP4oyC5IIIPHCKxUUWrUWU4ps+
   gswWTtneXbGCFl0ZBVnjQw4GgwcfFks5wAInxQ1WSLhcSehpOnXx7Tear
   Xeiya2loU4DlOOvTW13zDsbdEc9k/WHtikAYoz+yRi1ovFlV1MZ0miP1D
   CAHrN8+kYJrh6JkGPBeRxrfsvkKl/EFoBKLWC9+d8ATsMm4M946q1nnBF
   8190EHnvyGq57HZu2YM72XJEboalmJ1WhDm751qWFMgwrCB2EHRgicaxa
   5Ktkh3c2xyGIBPizqzfhLcblxwaGVWkpBwW5TkFloJLs8uCekBYbJ88PT
   Q==;
X-CSE-ConnectionGUID: j/tiLQEvQK6rJfOctdz7Pg==
X-CSE-MsgGUID: U87ADXlhRLS/rFanWXLdMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="958443"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="958443"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 08:49:18 -0700
X-CSE-ConnectionGUID: ZfldBHjnRXuvUp4TW27uVQ==
X-CSE-MsgGUID: kgiSqc7jREOCZlkWORDuDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2195149"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 08:49:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:49:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 08:49:17 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:49:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flBCmZnUSkBiwWHYaVXSLwFeGyBrSvszb3Bf9RQnZXw6GX4TPWL06Yux/YBd2AoEYLV2etCR2O6hi2tkhoVHBhyk2ZKyWe9fxh5aE5CFuuWadInAwi6tDCYQJX1YZy8dQyigD2/ahnb6hbizAW6NfT77bftjCWJ3n1EKEPnMvPmw5odMishAzqhVz/vYSe3oAZs6gHFMLVUz2+CEuqKrf6IgYTMQZCO3EKGtJXJqru9Fugmn2CswUjetz2qx2+k2WxqR+yqFAVSfv+ghObi7Ydxe1HY8UYgQkrototerATE2SSCRbdMDG+w1Xl54JQewp1aoEGmF3kth3WXCxYcWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4Q2I0rRg1sgfAXNAYZ8FcY/L6jBvVCpsNjDHt+/5b8=;
 b=wOAsaVkk+04QIEMnIMeeLO/59r5n305qHoIcl6Dsv6HgmQvu8TvtcTyrv2KgVq5Q8JQBnTCw3eq1jJihAdFpUaCNBt6hJzx2JN9YBEKAY9kwCebs5SLpW/JCG5ad7AnjNLFQh6E0WxEzL0osLtifr2r+zGHbHft/qagCpjrG2ixV1WMh3MNgk9L8YlHevu2K4umpF38FmsHW4w3pbV+mkvqBNg1uylnp/o5isSZROGUdEdwdt/0QdFTHARDzn1DK2O2elA1+llwMATPTVDiCgsGshk2urwphNLefQBK82XSnH4AePPFFoJZR0Wco0VvC6lqHPqZSxMixLSTDyripaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by SJ5PPF8EC896901.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::844) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 15:49:14 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 15:49:14 +0000
Message-ID: <bf296951-e4bf-41f9-b12d-3c20930cbd21@intel.com>
Date: Thu, 15 Oct 2026 08:49:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/18] fs/resctrl: Reject mode changes for groups
 backing kernel mode
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <fenghuay@nvidia.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <ebiggers@kernel.org>,
	<seanjc@google.com>, <ewanhai-oc@zhaoxin.com>, <binbin.wu@linux.intel.com>,
	<peterz@infradead.org>, <ashish.kalra@amd.com>, <superm1@kernel.org>,
	<chang.seok.bae@intel.com>, <prathyushi.nangia@amd.com>,
	<kim.phillips@amd.com>, <ackerleytng@google.com>,
	<elena.reshetova@intel.com>, <naveen@kernel.org>, <darwi@linutronix.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <d0392cc08e4bf28998a4815943525a0461003801.1790867441.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <d0392cc08e4bf28998a4815943525a0461003801.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:303:2b::26) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|SJ5PPF8EC896901:EE_
X-MS-Office365-Filtering-Correlation-Id: 5947bcf2-b2f8-4296-2075-08df2ad3dcd9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10067099003|18002099003|22082099003|3023799007|11063799006|260925021311599003|260925021911599003|260925022911599003|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: vstTcVo2fK0J4ntRou6iZS5zaxMSOBPw0RpVizYp0GERWepbbCcTA3Ue+aHBWZhcDDqT2OijJxOA12n/ys6zNstffhgvdS2wby4kixmsvbk1RoTsu8JFF9rc5W9EJffdN4h/oq6hpLghfYH8MlQDZ5Mkoty5PN/WHxKG36Eqc0jDGiiOqhmkZACV51/FvfD3uhmLtyziiMZwpEGA+fYBSuGKRZ1wAdanKe+p6qOK2A5+OrYYzgG/XqjR+nj2jLuM4KOXgxT4j6lJDrelmye/Y9SKEfQYK9fgJ6Sm8TtRgQSWrz80mXnhOea7M1cAOaIo7tUpxBIZBipqD+H7VAh38O80LXo0fptCIws5MYCjIsekHw2kslo7HsoRI8FG8S3OpRfOyr+xwhZWrS534eJZC8OqeAnrK+Auc2B0VKVpCxXi6n1M7F9ZEJtNzG+qgodBSFIByt49CYmyUF+uHzemZ38EB3MNGAJj8sG355LO0q2+9J7oi9JO6Bxltqw8T435ay8tNKG+IzQvRSDZO/Mk+4OcWl6JQciNWV3ha7kK+WLF6EFTSQ79Z2iukhxK42UjyMKv6f3x5MiP4y/c0RV/10HTGHV3dNCxP86cWQdl2X0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(260925021311599003)(260925021911599003)(260925022911599003)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZThMV1B6NmlkRGVSdTBJT1BoY05idmxEK1U4dk5WWlMvTnd2NVFIRFArYTNh?=
 =?utf-8?B?ZHRqZ2UvRkZIVGNSOTRSSFMvMjVvRTZvME1PSVJyanhhTk83dlR2cW1EYk5k?=
 =?utf-8?B?L3FkbVJYU2ExTFEzTlY1MEh1WVJBWm95Nm82SHdQTEkxRWRrVnNTZUpGQXM4?=
 =?utf-8?B?aERNT25ZTGEwMXFMVjB0QjMrSDQzTUVQNGhrNW40NmRUblNMMEtKN2hDblk5?=
 =?utf-8?B?eVBOTjl0d25vQ210ZnNtQSsrTWdrbjBIblNsZk8vZHQ2K3dNNWswa2JySWhH?=
 =?utf-8?B?SUpsa1ZYV2llVzVXcnBiaWF2L2wxYTYvNmxNeXc0eDh5SVM1VnNjRzV0R3Vz?=
 =?utf-8?B?YTJaTkNKNHhFdVQ4VFJQcFN5c0s0d2xQUk1CbDJDeUVhajcxSi9Id0lxQmpw?=
 =?utf-8?B?SzR4RTVXcStnVVIyaWlGdmJ6emE5ZUsyWHVsY2prWlB5VkhJd0p0WHBLN0Fi?=
 =?utf-8?B?bVBNUWRuS25mblZxQmxxWmJ6OTB1czFqakg4K1lEQi96TnlkVUFxR29HM2Fx?=
 =?utf-8?B?MmNKaTFKR3NJZzA5ckZFZTRnM3ptcGRKL2lVQlJmSkFnQzgvUmdWdFhGOGI2?=
 =?utf-8?B?U0xSeUpyTHBXWkFLOG8yUDdQaWtWNWIyaWcwR3I1SVIvQkZlcGp3QXFWSEQ0?=
 =?utf-8?B?enVZaHBlQk9uQXVScGJnYXM2Tzc0TjQvT0trV3FFbEo2OVFINTBzRUhRVHlG?=
 =?utf-8?B?eUdKRkJFM1JzREJMQXBnWXRmU0psM1dxVXNWQlkwN1NhTWhURGZkcFlUU2ZD?=
 =?utf-8?B?dll2VG0xb0tLZ0loMkNST0VkWGlQdHZ6enAremkwSGpsMWM2cy9XTTFaRWF6?=
 =?utf-8?B?MFlFcWVELzhGNDZHTktncW1GaElBYy84OXZNaDk1dERrMTgrb1M5cWNnY2tV?=
 =?utf-8?B?Mnp6UDM0dHVpNTByallldko5aGdLWWE0Z1dYc09zRFl4TmVxY1FKSk5DRnYz?=
 =?utf-8?B?YTcxQmlpSTc0RnhWTVdMcHRCNWxYUU8rdHpxSlBrTTJhOVRCZUxoa3B3emVi?=
 =?utf-8?B?MHQ2cHVxaGJjZUtaZjkvWDl0WGkrcUZnMGhRSkhUWkMwTEZVWTlvRzE0QWxt?=
 =?utf-8?B?U2FTRHlZKzdpbTNoOGU0Wk5ha1Q3ZFdNWmNvV3BDNyt2aXc0b0c4djJIN0V0?=
 =?utf-8?B?MGE0bXZ4VG90TExSWXdvZFoxYXp4NUZ1d0FaSG95bTFlMWJPUkFTREtsVlFW?=
 =?utf-8?B?UUNrMUlwdXhtR2h2dXh0cS9VRzlYeE5rQkd3NW8rMVV2aUwvbGt5eTFtQXBN?=
 =?utf-8?B?c1UzeXFGOWxYVVIvTUtkRXZoT0lYTmhHdGN3RGVUM0hURnA0ajZkYS8yckJr?=
 =?utf-8?B?Ym5oMm9jbkxkaGwyeDBIL2l5a29ISWlwa3BybEF1d21NY2J2L050cGpHSzNm?=
 =?utf-8?B?RzFDcTFNalErVnJQZGpiQjJVdWhKbkZDb1hpU2ZqbFNqYUhZUjYyeEEvVDIx?=
 =?utf-8?B?RFJaeS9HTFk5bE9WaGtFQjhGQXpieHpicnBGYnNrckZnUlZrSGNZcWgyeU1O?=
 =?utf-8?B?ajdwbi9vRnIvemJCZ1crcUpPM1BQdTJmOGJiOWV6MnBSMEdkejFYcU9JeW5E?=
 =?utf-8?B?SGRBRG1RVjVOZzVWTXJWdU9PUE14bDMzUENvYnlTY2l2K2xFSFRibWRheDRu?=
 =?utf-8?B?djNwaTFrV3R2L2FpRUxid2lSME00ZTQwbFJNL1E4M0tWYmFiaFQvWnl2VmFa?=
 =?utf-8?B?dXZFa2IyTmZTZmJIR1g1alJuUCtVRndnV2M1UkkyTVVPenI1a1dNRlV1RjF1?=
 =?utf-8?B?NUV1Z2IrT054bFIxL2c3MVR3L1FXbjZaQnJlUngyK1IyOThEblhDRUlKWFdk?=
 =?utf-8?B?NzZML29yUDVBQzcwa2xKVUQ1ZUxDVHdLR2ZmYnEwSWpnTCtlL243blA1dUgw?=
 =?utf-8?B?WlkzczY1bnkybmw3SGhkYzRXVExNZk5Vb1ExNkZKZ0tCQUFEajRlekdWeVIw?=
 =?utf-8?B?V0xDVFVBQkJmclNSL1BrY2VLL1BDakhBYzlLUGdYM2RGekVHNzQwTVIrb1pZ?=
 =?utf-8?B?cnlnZm5OVTkyQzZaZTFzajUwWXFUekJ6WjVJSmFBZzh4a0YzL2lxRVJ4cXlO?=
 =?utf-8?B?SlRoN29USFVZblp6eklIT2RudmE3OFh6Q2MvVWIrZFJKNnRZRkgxQ1lzLzdr?=
 =?utf-8?B?U1FFdUljWmJNeUZuc0NCcHY2TGRtYU85MmhocHVhWmRXR2xpczk2b1AvZisx?=
 =?utf-8?B?WlZwRkh3b09mN1cxcGxqRkUvaUVReDlOalN5enQ2VFpJR1RBcjRQMGFLMUJt?=
 =?utf-8?B?VmI1OHNIZUFFRmRnMDRvVThZbTQrREQzVStBMTFvRWpFNDhSdStEemJHK1Jy?=
 =?utf-8?B?Mmk4aFVxRzkzc3I0RDREeWNHV1FOSmM2bXA2R01QUFNpSnJEakRPVXFVaGtO?=
 =?utf-8?Q?A4enBEomFgyqNr4E=3D?=
X-Exchange-RoutingPolicyChecked: CYL0e/O2kYLbyoQ16VK+7uDHGtb6wjCQz92jftzEiA5R/YCldFcmvdrMheniTJDHLdp0tECtZgDYAJlM03lxa30RZq2JPBhZd56umrew8hPZkxrI/kLcu5I41dpW5o7qI/S3PcBcyomIis5M39YqRcu5sPwmZLGw+XPNgCh87FtdiurvxC+c0JPlWfFBiaJsXqEJgTiPKEhNPDsvxCfdS4mIySsisP9Bdq6ClLJHqy1pjCQPdGb/s6rKcm3klPfmfNXSBGPffJOc6woI0DFZGyi/60PVGunL4vzR3kPEYi0p6akB/AeBDVTrf0QUo1Hj02+JYRVAd+63emQAGu5xug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5947bcf2-b2f8-4296-2075-08df2ad3dcd9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:49:14.3752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5CeK2ziHc4GBgAyl2zf6+FEru2u7FoZVR7iK4mPSz0icGPly6D0VTgRMS2hpcOaQGCK8lTnlez/TBcwPVSsCfhiJzjb81gwQ0SH0CuPrLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8EC896901
X-OriginatorOrg: intel.com

Hi Babu,

On 10/1/26 8:10 AM, Babu Moger wrote:
> The RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode can be backed by only one
> resource group at a time. The active kernel-mode association depends on
> the group's mode and, for a monitor group, its parent control group.

I am not able to parse above. The second sentence is difficult to decipher.
Apart from this it also assumes reader is familiar with how a group can
back the global kernel mode but this is behavior that does not exist here.
> Prevent mode changes for a resource group that backs the active kernel
> mode. Also prevent mode changes to the parent control group of a backing
> monitor group, and prevent a backing monitor group from being moved to a
> different parent. These restrictions ensure that the active kernel-mode
> association remains valid and consistent.

"These restrictions ensure that the active kernel-mode association remains
valid and consistent." could this be more specific?

This patch does two things:
- prevent user from switching the mode of the resource group backing the
  global per-CPU kernel mode. Why? The reason for this is never given and
  there is only a hint in the *code* of the *next* patch that requires the
  resource group to be shareable. The next changelog does not mention
  this requirement either. 
  This is important to highlight since a resource group backing the global
  kernel mode would have all its resource allocations shared by kernel work
  done on behalf of *all* tasks. This makes it a clear requirement for this
  group to be shareable and for its mode to never change. 
  This highlights that there is an ordering issue with the patches since this
  series establishes the requirement after it enforces the requirement.
- prevent a monitor group backing global kernel mode from being moved to
  another control group. Why should this be prevented? Could the global
  kernel mode not just be reconfigured, just like when user space
  provides it a new group? This is a design decision that is never motivated.


> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v6: New patch to fix sashiko feedback.
>     https://sashiko.dev/#/patchset/cover.1787772750.git.babu.moger%40amd.com
> ---
>  fs/resctrl/internal.h |  2 ++
>  fs/resctrl/rdtgroup.c | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index 6b8d14c4bd83..84238e9e8e15 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -462,6 +462,8 @@ ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
>  void resctrl_bmec_files_show(struct rdt_resource *r, struct kernfs_node *l3_mon_kn,
>  			     bool show);
>  
> +bool rdtgroup_has_kmode_global(struct rdtgroup *rdtgrp);

Does not look like this is needed, can this function just be static within fs/resctrl/rdtgroup.c?

> +
>  int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file *s, void *v);
>  
>  int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file *s,
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index 98451b417fe3..dcf9f26540d6 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -1738,6 +1738,27 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
>  	return true;
>  }
>  
> +/* True when @rdtgrp or one of its monitor groups backs the kernel mode. */
> +bool rdtgroup_has_kmode_global(struct rdtgroup *rdtgrp)
> +{
> +	struct rdtgroup *child;
> +
> +	if (!resctrl_kmode.rdtgrp)
> +		return false;
> +
> +	if (resctrl_kmode.rdtgrp == rdtgrp)
> +		return true;
> +
> +	if (rdtgrp->type != RDTCTRL_GROUP)
> +		return false;
> +
> +	list_for_each_entry(child, &rdtgrp->mon.crdtgrp_list, mon.crdtgrp_list)
> +		if (child == resctrl_kmode.rdtgrp)
> +			return true;
> +
> +	return false;
> +}
> +
>  /*
>   * rdtgroup_mode_write - Modify the resource group's mode
>   */
> @@ -1778,6 +1799,12 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>  		goto out;
>  	}
>  
> +	if (rdtgroup_has_kmode_global(rdtgrp)) {
> +		rdt_last_cmd_puts("Cannot change mode for kernel-mode assigned group\n");

The messages to user space also switch back and forth between kernel mode and kernel-mode.

> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>  	if (!strcmp(buf, "shareable")) {
>  		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>  			ret = rdtgroup_locksetup_exit(rdtgrp);
> @@ -4697,6 +4724,14 @@ static int rdtgroup_rename(struct kernfs_node *kn,
>  		goto out;
>  	}
>  
> +	/* Reject moving to different parent if group backs kernel-mode */

Comment states the obvious. Could it instead state *why* this is rejected?

> +	if (rdtgrp == resctrl_kmode.rdtgrp &&
> +	    rdtgrp->mon.parent != new_prdtgrp) {
> +		rdt_last_cmd_puts("Cannot move a group that backs kernel mode\n");
> +		ret = -EPERM;
> +		goto out;
> +	}
> +
>  	/*
>  	 * Allocate the cpumask for use in mongrp_reparent() to avoid the
>  	 * possibility of failing to allocate it after kernfs_rename() has

Reinette
