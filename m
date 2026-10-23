Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792726051;
	b=EWk4AFqZtIKS8hPIG4CiWcwuZAwQ/dRLCDsDshn4QOMNuDv7lcjpUEyWraJu3eemoPRC
	 wVTB48T47CHFu+GVSShxUQ6meOOwVSQBzcW3w64DnHkVASX4ErqmUXprBRMh6mDa1qYqg
	 Og41il6R+jkTrc5MUZYLn6wTgLJJTT54Zn5HsDiGRumWWcqFXdfjBdoUYOE5KTwOVgjD+
	 kSwo+GYFnc+g9uCBoPOyN4OWAhQ7RtXaHiB6nU1DqI1KT1GhgW1kmYCP0BJj27+s9x4sh
	 8y6uwfBFDiyuHkir+7GUWuV8uWcgYUwpcQVud4y252Cgc8nO2YQtUG4V8KqwWhPkevA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792726051;
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
	bh=pDKzyKtyY3JJ7ZFj/EbMk3SEiCzG8Z6av05CQr4h8Bk=;
	b=Dz0/eD4sauCW0xLTFnbQS5R5Ix1jX9aKC8hrbGXwlfEX+VO0W5ndaNe/JdFRmaltOJdr
	 CUie3hfulk7FPBPswwFv5mE1Fs/4xA5pJLuPCys4Z9OC5yV+DNAyMzsWNnqWBG1x996gU
	 g5/6r0KVPoE+5Upqfhfw3FJUkgwwcUUW9YNW2iRKtn40Ah3/FfCJI+EpQmVsM/jp4lZTb
	 eBhAHo+a4SIOv2cmgKtIgAeHwA4C6sqN7tAICE+ztN/8LmuT7w4ovU/oGvBZJY5KO5UWd
	 UWTJvbRG8aChmpEbW49/8x4qdAxSp0OUDc7Sxt/h/3O+6x+icNfnS6G/roahk/j1mOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ghNnKKUV;
	arc=fail smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79496606A321;
	Fri, 23 Oct 2026 03:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79496606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ghNnKKUV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792726050; x=1824262050;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=niefGKFCSLpXmU2nW9fA8FqBLSEs9XnA6SPVXXwbxbk=;
  b=ghNnKKUVGq/PXM8yDQBVxzw2mykUAjwZ1iqSj8xKoE2S81fu4835Hm6V
   ZDvYls2pAZYrNYyHNRfGE0F85LHD8F32uceSEwRpY27F/zCvKuD7sVN1h
   DfmFHLAkwV+rahrhybnItMhNepzh1E2RAwir0g8+iqIfVO5ie4DmhtY/l
   tg46a+UPyjKs3fuopj+BnZ7+M8mmyP6yE4hS0tjr/nzSHz2cS/X4MGrcy
   166UhUZTHRNu5HaEA2d/IDyfmPT2pLAhedK2oYDVjx8PByltAlhLkPnnu
   yRrjXunuwBlCWVncjnmxHfx6leDl31Rtz1ybmlMr0s7q+Dy2vakWfM+kI
   g==;
X-CSE-ConnectionGUID: gi9miXlwS0uCaEfZv6oXsw==
X-CSE-MsgGUID: J1pADHEqTiioduzsjgDpHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1498578"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1498578"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 20:27:20 -0700
X-CSE-ConnectionGUID: zI/UvdrGSROzoABDm3mv7Q==
X-CSE-MsgGUID: i8CXXLbHQnipr4QNYuHfMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3434730"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 20:27:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 20:27:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 20:27:18 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 20:27:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvzHK1biDbKe09qWMUqpxUP7rHOVTy0FagqYB3DA23qixrNwALid5Xyxf5Nx2B9WSc3Rp920UOMixM9UfjazXCm6TzFg8+Lpy/XW1ho+V4aLsuZeovYK6hlirgKKZW+tU0KEilujmHHaE7Zc37mZ4cWMZfHCP0doiqmAKN47/VtgjNFsQbpJPclkl3+I2QxxHwy164QEXhcZgBevQCDrJyvNdnwMkgewtZ2j3Bk7L3zYbsL9JugkZfbodM4d1KNRoRjIOHR1ohzTgRzNEiMD2Ev5yieENmWFI8bZRVFJJmZnLbBlC7qgUS67TSm2kqufqPD/1PT6Q+iC4RovZDTIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDKzyKtyY3JJ7ZFj/EbMk3SEiCzG8Z6av05CQr4h8Bk=;
 b=UHZTBQMJergZkmcFTXC+2pjK+cCd1uQkti1yGAhg6WKPyr3bsiNmIXMDjv31iUoQuMHRegAOL7ABkPGuz93DwAOrdAfDR3mPeKzqYnP5/BBuffffJ0f8LhtYQ/lTfZZDdcIEBLodgANlNRiXWy2FU6uj0Vb+DPe9Jad1aElQf4jvWRi+ajyOzkT2ODR4Bw0trjj3sj6P7RuZcM6sIQpXPt8UdW9m6PaEDq2KWy1QUEru+5P1+xR4FltF0Sv9mp1z6Y/LuHjt6WMKIFOTFCMwOLgLpFCfwife8k2iuRwRKNMbjI5Svsjrp1kqdjbAt1VpMDwWkmlzhoVDBVGoDMVKuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by SJ5PPF20F246184.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::819) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 03:27:15 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 03:27:15 +0000
Date: Fri, 23 Oct 2026 11:27:03 +0800
From: Chao Gao <chao.gao@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <dave.hansen@linux.intel.com>,
	<andrew.cooper3@citrix.com>, <nik.borisov@suse.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <xiaoyao.li@intel.com>,
	<tony.lindgren@linux.intel.com>, <kishen.maloor@intel.com>,
	<dedekind1@gmail.com>, <adrian.hunter@intel.com>
Subject: Re: [PATCH v5 4/5] KVM: TDX: Report only KVM-allowed CPUIDs in
 KVM_TDX_CAPABILITIES
Message-ID: <atrUBx5IecGkKaaJ@intel.com>
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
 <20261016091422.3182216-5-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261016091422.3182216-5-binbin.wu@linux.intel.com>
X-ClientProxiedBy: KU2P306CA0071.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:39::14) To IA0PR11MB8380.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|SJ5PPF20F246184:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4ae791-ecf1-4f06-1d7b-08df30b588b8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|22082099003|18002099003|261022105027099003|261022075727099003|3023799007|4143699003|11063799006|261021121427099003|10067099003|261021123027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 8vT5WmNJmcNyAMyU8kkUD2Sy4sRMDi13wkI6TYWSerdd9ehGZLEEf4FbiR5AAKXDw+JwuhnL/jOj94XDmIqkHrkxvloUXCXf7wQlqiWNdzqbFmV/zSYHjB5MG2fgulwG3gBrvlZsrvAfOI6hKYlTqIudpVkes/a2vdalVco4UhZe4fRupD7FyrymLI1Y19TZaybgJsaOf+X16jHZ+fSKLbLvfcFUDzLLBhwl6tI1zcvEusq8Ng/bxPffdtmJWeMByFHH5zwMv8wvFDCtm/i71/EdtX3Pr86mqvW0l93GXrGoxeqqeSZXKmRZIBWOaUikp5PaRWLBvs4lHi24X2jJRQDXyw86k5QCiDH7rc1Dd8FZpW+M4pB3oAgfk+0OzCJS1RrSiGn9by0ycR1XIAYrbDPWKs3whfgNSMTAa0uB4JApwIcAwl9DsUXTmbINR5ek+HeJyp3S+Es/xHOgweEQA1AIzp2EZvd29mzdrXL3RIMF11pRYfEnZDBQRjD4t9yE2cnSTQ+sbvTbcB4RofoDmdwK6waxdPuRO4MtAqZ6tplyaUjmJj3kGTyAwO1OnbGNoODvEdwDsqr96O+RT93rMCImjcUH7ujUageXaF9tWF6p1ALl35dxfBmJ3huPhz6Z20imAERMpPno+PtX4AyfVBxaFDGFavs9asAqFDN5jf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(22082099003)(18002099003)(261022105027099003)(261022075727099003)(3023799007)(4143699003)(11063799006)(261021121427099003)(10067099003)(261021123027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1EaZBjvHhaGFH8OmBzMpRqL2d/WTLZyE02fD78nfQNihREtJyHMGWIfdARJG?=
 =?us-ascii?Q?Asc0dSf1SJAm2UPYG2TvAscJ18yHdCdqRioOWe3EwT0m4xX/dSMh4ybi/Hqr?=
 =?us-ascii?Q?dpeQPvateFNy2H98G9kFftqCiAuXrbABy0y//88if6Qv4J4DITcQTETKM+h6?=
 =?us-ascii?Q?mH6NX0TtbzaWFmSPHkotmkBjNw30lul00l2IL4JL1bVBwOKp5Rs3sniyrSn+?=
 =?us-ascii?Q?/QT5L5Q0nSOqS+2YvQd3+CphmkneMxm8tntKtOzMlByhc1kE1uHudaxN4dfE?=
 =?us-ascii?Q?IgCrHQegqjooRbS+IQcVj2YEhJOcOws9L0GZZ3PdZvydvGJgUQXM3J7k7bUc?=
 =?us-ascii?Q?TROv/gAe1F2ACBMK5HcAPQAhCzXd+jvGXNVK24Ayjm52fIrGYg5awuk+M+8l?=
 =?us-ascii?Q?f1PVmn6GOHLpdVwL9K5sbznq6pup7+z4i9ew7q6k67m1XZyNRTbbP7mStfOb?=
 =?us-ascii?Q?RLt5S5cMaawPkLoHKPAmmYOupHJxV542lLUbceUEMBP1hli6X9XqAadKi98T?=
 =?us-ascii?Q?XigQbDpQvDhPVxsagzL00tXxB8XYyVRDME4NVEKsxDrgTneFkKmXdfX5twSy?=
 =?us-ascii?Q?CP5zwza57NFGrsi6SfJeK+AEMhuNEvs3f4GNK5Y4vwsHip3fd/VhqqYGdKjB?=
 =?us-ascii?Q?mfzwooFsNJRqJoM3NwbVYbYDOL8d63+iJom808RhxLmyGZy726xhisJDYCnq?=
 =?us-ascii?Q?fRrJn5fyu4gBX4wnt/9DPpE2REfSs5VKNwmogk2F+HmNDNZfg0pBVZ8E9Ls+?=
 =?us-ascii?Q?wmoOJayCA6JdG33QqF430XIKYDJD0eUpbwNQVmdI686zMhTSWR262vdbaF3K?=
 =?us-ascii?Q?OYNHPBvXzKiSuqBDG05KgS59FjCxfASpC8vMHQaSSYGIM+Zkc21YwL6QWnoA?=
 =?us-ascii?Q?BWal/Grj0ycTidbbr28FE1R2A0cgmTfTDp/41hLjtQoNbR8/qZZpYgLVis8v?=
 =?us-ascii?Q?t9g5jxLWD41/tgSMKXtagHY3tM8nQ06PISA5H7a0xmas8eq6oDdyLa4/UTaG?=
 =?us-ascii?Q?ngKQ9no0ZPDzIop1RFUWCCJTUEYxLxjJrK5aEPxr+H6mZxU7fY7WwjeNz3rH?=
 =?us-ascii?Q?BPM+sMAZZK1yWu6N5Z7fPkZURevF6L/sfq3I+sN9p9iY5h+nNi81qHb/LNz/?=
 =?us-ascii?Q?0ils0GL06va5morw4J4G7VL7mCe9yt662jQ5H3IS5AlrKbYfexUeVTV9+z14?=
 =?us-ascii?Q?i/w95DITg42TazrpuxjXJt5BRKBUlaEKbS0Hi56Crr5iCXlylV/mULriIMfO?=
 =?us-ascii?Q?97TZJpkoz8FzQF0sbaxQPLfyziMtCmT8YlEAnIA5+NK0JcG62BDS2PvTiEoX?=
 =?us-ascii?Q?6mlsK2dYCyIfXo4kQCDBmOwg3+k31B1qdHvnw82kuJNjMxcRqyzY9rwo1PCo?=
 =?us-ascii?Q?kw9T3h6eqsabiIDuIxQXXxFf0LxvEakclif8d2j010o3AIAketP0v9zfYhzK?=
 =?us-ascii?Q?LEQwl3cT38R89/Y2czqqEbKqc9goYo38WUfW1wqBEGmPUFLmUsYHFYgHf6En?=
 =?us-ascii?Q?8ADMtj690gTFzQMY1WGxxgmdr/n2XDl4PizUhRLBjbUp5r/9Vszszv4DPWsL?=
 =?us-ascii?Q?uRYTAbgnzEjbTK0a96r1yRoF0r/yNLj14f7K+tWahsTpqvJU3N67iUWYClnz?=
 =?us-ascii?Q?xt4L87yMEq0GednXAUTl/spENgkQBoBZBJDwXAh49FpNs2vct33wfRlmdkQ/?=
 =?us-ascii?Q?CfIoI+Fy+68/YfQqhVJ/iVXfHA/9APaG2xkIDHSsoWwzIlvm1kuk4V3/FSBk?=
 =?us-ascii?Q?ElSKjirORQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 4DR4HlDNuG+cOHdpS3eqxm9FEx8hvjJ97x8aNFVijqZIftXiEvfpwK5clyl/yLoKoV0xPofTNp6U6OoePr2/YjznT7OecFrn78ZhPBp+lvx8vnQr9MkhJel9451abmrBFVKEHhlegVTsctGOOu8Uz6TgERjAWoeJIpRbLz/FV6IN41w5IK+hZBoP2jw82wuHZPD+2l4dEjUm+G2o+cNVlsSKO6NmcUeZLvNNeLAMvDSj4iZw7e6mmU4ZLDF0Lz7YeunjSeaKd5v5oYrm4gWdgAtTiBhjd8VSb3Mh8gzsapNIh+g/nHosnJ/dPHsRHQcpM4JgvChtcHbgwFceYitXtA==
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4ae791-ecf1-4f06-1d7b-08df30b588b8
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 03:27:15.3836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29ipFDvKtjYzIiLlvfD0HYsYVrIwr2RWbLHA/mAGX0yH0soL2UeRY9E45deeFbnBN6Ws+HWQBUkDMdCAOaxT/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF20F246184
X-OriginatorOrg: intel.com

On Fri, Oct 16, 2026 at 05:14:21PM +0800, Binbin Wu wrote:
>Filter the directly configurable CPUID bits reported through
>KVM_TDX_CAPABILITIES against KVM's TDX allowlist, and drop the hardcoded
>denylist-based filtering.
>
>The TDX module reports the CPUID bits that the VMM can directly configure
>for a TD, but KVM must not advertise bits that it doesn't support, as
>blindly exposing a feature that clobbers host state can corrupt the host.
>The existing denylist, which clears only TSX and WAITPKG, can't account
>for such features introduced by future TDX modules.
>
>Add tdx_get_cpuid_cfg_mask() to compute the mask of directly configurable
>bits that KVM allows for a given CPUID register, and apply it to every
>CPUID entry reported through KVM_TDX_CAPABILITIES.  The mask combines
>feature bits, taken from tdx_cpu_cfg_caps[], with non-feature bits, which
>are identified by function, index, and register.
>
>Treat CPUID.0x1.{EAX,EBX}, CPUID.{0x4,0x18,0x1F}, and CPUID.0x80000008.EAX
>as fully allowed, as these registers enumerate non-feature information,
>e.g. family/model/stepping, brand index, CLFLUSH line size, APIC ID,
>cache/TLB/topology properties, and address sizes.  Allow the reserved bits
>in them as well.  Though there's no architectural guarantee, given what
>these registers enumerate, the reserved bits are expected to be used to
>extend the existing information rather than to enumerate new features.
>
>Also allow CPUID.0x24.0.EBX[7:0] (AVX10 version), which the TDX module
>reports as directly configurable when AVX10 is supported, even though the
>CPUID virtualization table in the "Intel TDX ABI Definitions" currently
>lists it as not configurable.  The table is expected to be corrected.
>
>As a result, directly configurable bits that aren't in the allowlist,
>including bits introduced by future TDX modules, aren't advertised to
>userspace until KVM explicitly opts in.
>
>Note, the change is user-visible, as some bits that were previously
>reported as configurable no longer are.  The ABI itself is unchanged: KVM
>already filtered unsupported CPUID bits out of KVM_TDX_CAPABILITIES, albeit
>via a denylist, and the set of configurable bits already varies with the
>TDX module and KVM versions.
>
>The change isn't expected to break userspace or guests:
> - Userspace that honors KVM_TDX_CAPABILITIES simply stops setting the
>   dropped bits, and KVM_TDX_INIT_VM still succeeds.
> - CORE_CAPABILITIES, which older TDX module specs defined as fixed-1, is
>   still allowed.
> - The dropped features are either obsolete or unsupported by KVM, and in
>   the latter case, a guest relying on them would already have run into
>   problems.
>
>Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>

Reviewed-by: Chao Gao <chao.gao@intel.com>
