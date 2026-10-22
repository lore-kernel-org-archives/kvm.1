Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792658859;
	b=y1qgSpxXzbZOIVZB1f9jI5o5HMGrPqTNcY+Ahu9PJdbDi9BXAFS+13GRKkrLaXWtVXkq
	 1E/mFf5Uvg4rgDTRJSFG1Og7fqVtqp2vfX7MVAPpCeGBJIz+Ez5Xk/qcj7QxYGgkXrLzy
	 gA1o5LnIwfb/pI8SuCnkTWIH8pWLBBrPBDBC9o+ZIVLh7LuRgR1dC4AkZlbqk+NjGPMjP
	 tmhOnqdnjJFh0QJN9xCNDiB175x2bO0XjzPEdvHT343uFJwU01KbCo9FC62mY+KbM5yIN
	 LEfy47NZ9Gn/HmAk9b+qprACBgsXcgCEcc3pOle1k3bOgtiOuOA/oQESL6eo8fxBd4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658859;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 Reply-To:References:Content-Type:Content-Disposition:In-Reply-To:
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
	bh=a6YkkxqOvDIGjOiFCupXP2wmzsBTI2SoFQAgeLkfB1I=;
	b=5RfXYUz0mvippuXs6zdZVxbfZIJc10hgrFW8MA/t5LpkwQ3tcw9xhAqvRlT/j1DBraIs
	 qdNpen5qMqEHVIJnCdvPUEtXNIm0d/AonEgRU2q3tUaJJT0BAPiCWug/pmiDlxBW2stx/
	 CdY84MXhqzu+PAvGHAtUzxG+36crXby8i/sh6FMPrTaeiLLk8sSxzK68MS/R8Ba5GD167
	 SV5wn2gt54AYlAw48ac1oQEdJuRp3PcixvHBDxSjXF7+gvu4wyOBk0X44w6oV3SbH45jQ
	 dEUVYpxYHMncPS0yosIpLkbh+v1+DDIHkCVo9C/nqHKCnj7YKwr2+fY0eQOp1voc9/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kjb8CCpw;
	arc=fail smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C01606A319;
	Thu, 22 Oct 2026 08:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07C01606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kjb8CCpw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792658858; x=1824194858;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=iOSatl4bZcnaoWlYbRZ3L5wQHZx0868uBP5f9csMwYM=;
  b=Kjb8CCpwb0hPBEyP7loY0Zc+gaWfWz8Xj3ej1j2tgcMoUMv4PhFLo86/
   MEBnWdFwB/C1xkqxpV8qZ7JC1ZYIS3/kCN/y7MRoSyyKgawEH3C6apsgS
   ea0/kW9sdyzv1+R/sOPrQ0VrTi2B8I8o2TaCbJkiRt4ubqjeGMGBolkBG
   qXiWyK5sqB4MGlIyr5lbrLg6PcZwDjnKPwtPVUtWHxcWzsv49KKzfHw+M
   S5KUu4ws1BJLAr5jFtR//XMcdlth8nFwPgy8uGmy7eI0RYopCmstuQ/Yu
   TXK7hAP0qMJlG5Cs1posnLYo/ZD0QWsiVL8Ygzh3IunBwqTy8fvuc1qAL
   w==;
X-CSE-ConnectionGUID: AyohQ5KsSAqRPtsc4dwzlw==
X-CSE-MsgGUID: lkYVaJCuR8Sj8JIXwnPkKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1505569"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1505569"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 01:47:37 -0700
X-CSE-ConnectionGUID: ZpAWk2vkSl2id2gbf0WkOQ==
X-CSE-MsgGUID: SAWgTHDRR5KnMsalZW7PuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3702703"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 01:47:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 01:47:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 01:47:36 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 01:47:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GL385yTNlX0Y7XBnZhbz0NeYvb8Tt0oOAf83jff6wy6lRt66MAbbH7GQ/l0ZbG5pGqtAwNopLs9o6udzoUym0j2mNtNvcBs8dEpKTAwWIU0WlO+S6eAS9f/tFv3M8wuv9FWcHR14DyJw7b0iTOdaw93gpEB6yhXx/UvaqT3ojs0l/sL1aL29qLO9MISsOghVfHCp/3yRiDuKzF5iQzid+/SxsSnPzyTb5CRzIQtprR/xtvrs/l3FYr7620lPlOz+irkerd98IQ/xhOxsvJDP8jqJm2PYNAzcDdK4kMnO0JTq4mdGX1lEIcFmUyNkl3ff4kh6IBZ35j2Ah3WNiFFhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6YkkxqOvDIGjOiFCupXP2wmzsBTI2SoFQAgeLkfB1I=;
 b=bCFNz+ozEkolLFp5H7a3jw3tXfnNbztpfaD5PEszDyXLkU+KN0PjgBUexblDyA9cSLVnbV7Yisq6eWu/xXyyg8KG/nlQ24AhNoK9dgRa4w5rxDWGIbleIv77Oek0nzLtoyMxgh7KP+8x9gNv1W5XYe52rndsD7lL3pMR+WLGqVrYYuXDJlp1FQtcrZY6S4espy60eyhQj41yYhq+FBZAblw1JXkKDX6fI2sEWzoOrzy4Ztfwc50WKhxZnZaNjaSgdOs6qZwd+bt4VADDMjtGyCAYiqPxzLYRbwtHhkK/bDjv9QR3uMQR0mkQX6eQkGfROY/OfBU+yeaXxkdCHu6BgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 22 Oct
 2026 08:47:28 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 08:47:27 +0000
Date: Thu, 22 Oct 2026 16:46:29 +0800
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
Subject: Re: [PATCH v4 02/17] x86/virt/tdx: Add a SEAMCALL wrapper to demote
 a 2MB huge page
Message-ID: <atnNZWj1t9aiOF84@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <asyo+Pr7aCje1AZ6@yzhao56-desk.sh.intel.com>
 <94e930e88046fca1f53d2234d581aae593367d95.camel@intel.com>
 <as9OHnM4mceEre/2@yzhao56-desk.sh.intel.com>
 <a0936473c0ac5a2ca0cfb30bc61c9d5c374c712b.camel@intel.com>
 <atBupzmYqvnB0Qcu@yzhao56-desk.sh.intel.com>
 <atCcvJoCwQyP1z9e@yzhao56-desk.sh.intel.com>
 <atChtNfitK1PJCqJ@yzhao56-desk.sh.intel.com>
 <ce6a1dde0089b0d357b11e58d2771596943c1239.camel@intel.com>
 <atX5JpdqDJIrue4v@yzhao56-desk.sh.intel.com>
 <19661a3ed2089304fd69ab4ca117eca7ceba425c.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <19661a3ed2089304fd69ab4ca117eca7ceba425c.camel@intel.com>
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To BL0PR11MB3236.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|DS0PR11MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: a12ae930-8b35-4de7-b58f-08df301919b6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|6133799003|261021121427099003|22082099003|18002099003|10067099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: mmrl9W0org8zEAlGFEMo8vtjnr8hULTz5dwsxHSD/dRnIYpd1lKeVqHztNnB8jUjULlhK3fQnJgGnUiyatlBe9cXqFK3C5NCBdDSl715Ge7R4rVecoM2vgwLHHMSnfXdGm7kWfCWpPGpmeFaSp8nLamqoZOYAnuh+nowhm7A2A3+4/C5xNQm8fgqlJROAIJht6fBNl6E2C4UR8GQpfl+49gj+gdExgRsEhAgLYthjBDIv+aN593arKuWETUp8wnje2YM2RUyZOPVveeDsW8O4Pv/NXx1dPo3KuWCT2q7yirg6dnvK0Izq8UqWxQQWwvrC+S1IKO5YqvHTlekm/2BC9pxEb/UOo1XTefqwGne46fTIcBDRBLqyC6hkLXVux0POw7rfCzoprem4G4UQjKyqv5isZPK/qM1nZ32HAALHl2MEu/lGb1Cjo/pU8Nrir9RuQbnGOrXDn5gzV7za7nDwY9r15J9uw8A+y1W62whvvPWoNcVNsrh0kx2rQubArsbTdKwAgtHPveAFY2mj9qWWdlO16kSVzLLDoW/KxF9sGmbJGZpeo3hAwdNzKxRy8Rls8W1h3NWZoAVbBMsrnngKguZiveWVBuYCQv+hlfOpL4c86J/fRrByIQkXCtLIrEEAocZcQ2RrjN0eiJYiWzwtctjEH/JyAMTTu9P0dEYM10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(6133799003)(261021121427099003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ojZhVCswUodiMmjRXVNq0RgqCoCPE7z7eZ/ISHlgvS6ZWRx9aeaiE3rQDkFZ?=
 =?us-ascii?Q?SLxCBOf6cLuvWVHxNqThCdu8zZiopMroiQUEY22qlGvV/2SNntc5Ev2I3IZG?=
 =?us-ascii?Q?7liQgnzMcyxkgElCReq5j9H841zz1NGWF/GYMzwrq36lfRIxbYTM7cOy4YHP?=
 =?us-ascii?Q?6ylls23b8wRg9zsiO/0MZBuzT+pgmyaQ6tUgC7RRfhMXwPQIQmHBw0yP1M1p?=
 =?us-ascii?Q?0ucyidtme2haTXSui5KfQMCzxQy0xzONnPUIT9uPqYD5tyt3M4Eko1zPOiVt?=
 =?us-ascii?Q?qWrIEJdPDxcifH1+0nVwJKS/DONd3x1MXPPhrzrBgqs7hqiHUYk9e375/9uW?=
 =?us-ascii?Q?XqCHmEnPvrfd9L5McelVyaEsFpN95p5hG5y/bZ+w1GQI5WvnTgLhJ1ExsEAU?=
 =?us-ascii?Q?ClwFanfXWWvSbWfeg58FRNv1bLwm67bY9q9SY0HekhD5rDHxhLLY6qjzI+x8?=
 =?us-ascii?Q?7C/kqJSLgCp9NbxJo8SxBK6ZyzTMeBffdnwd54ZDBhAponZImC4M1DPgfmeT?=
 =?us-ascii?Q?IX7NSxwbuSQuTIhnbST/YcwV6I9vS9FnK/1cFcxhzlTLMvWR2z7pvxoys/2k?=
 =?us-ascii?Q?wHAeagKDSJ7Fa203CVhM0T8w4HD8xxnyQupOJHrA/QK/ODkL4y5M9Wlk2FiS?=
 =?us-ascii?Q?3jY9Cn5/xT6TsgV2AX3yOUsHNw6omeDqeNOsuSE3jBhb3krmBfWjy1XjO46W?=
 =?us-ascii?Q?deeK3RC3XA17jHWPPV20sjRPisw5f2+AqarMV2lbJ3lD8bX12Q+4pwXHlh/R?=
 =?us-ascii?Q?TKR7+jKPKXD4Yw434zCuSGzUdi/8v1IV0u8C95EEY0sd0MHG3zMojQQJQcJz?=
 =?us-ascii?Q?ty7MHK4GVjLYoAT9Dhgpr31VJ69fuMgOFXKiKPmd/5m3eK7mgVuf1QPLfh++?=
 =?us-ascii?Q?NPzETCA9m7IRKFKd9zSFKV+oRu1OxvaXZUq/+WdAoFOmt33G9vQSfjf+tcJG?=
 =?us-ascii?Q?H+LQbJxBrjC8bHarj37SVy1ICVuWFQpGpXecyih00wNu/Q1sYMmzzCm4E5G4?=
 =?us-ascii?Q?q3T9+kBkoWdldi4cWIwhqNvdI7s7SCYOjXuIRFw5/m0Z5rV5R3TRIwhAZfDX?=
 =?us-ascii?Q?sRMIW3KraykJgGhg8ezQGo8TgPAWETcJd/oJM7dA748qjziA3kQn0ZCfkmVR?=
 =?us-ascii?Q?uZBvzpGzgDFoEiw1WC81fkuc4aCtawo9SHDhtnREZaQs2SguizSlb1fckDXa?=
 =?us-ascii?Q?n7NdE+HhAJW/NMVY8W9nmLorNdJkLiIA/EGvy1nNh5+ITieTzJ1uU+n1LvbU?=
 =?us-ascii?Q?oEmOToO3be0yOA2zoWY4U42h3DyA9KizHja/h7awoOvSkaXCP3q+f4jNIM5l?=
 =?us-ascii?Q?3Ba1b/fBr15bAA1WqnMJjE1eALzgbLGYzh5b0W8sfoiPEs4Qf7ojbqx+RiH4?=
 =?us-ascii?Q?RabMftc4luArEDJ6uQI/XxUXKcmq8GzA0dj1VmDyyb8jAhiPeznHmFWjxjJm?=
 =?us-ascii?Q?kZj1juh5o4xG5N6SEhu4gweFvg6Po0lBLnZeCC8AAG78NyFNkmxknk70FeTB?=
 =?us-ascii?Q?IvW4VrSaR1NEeYcZ3eb9R1358DwMDmshpS8vACPRuA1+GtehG3pu8YNivFd1?=
 =?us-ascii?Q?AD2u04roVzyRPhEFEn37e2geLWzGomaXQ8LQ3XfOM0F4ksAIhXZW71bcu1JT?=
 =?us-ascii?Q?Hs9dMiclibwECjd3KPPgVIrlGp1kc4LES7oT7SeSOWqtcPD6UzJpMPOVPOtW?=
 =?us-ascii?Q?HR3Ocuauazd5UZfhEUhth1Ellp+YAoD/UkD1aHcp2Xkm0Y91fR0ObiEo+2pm?=
 =?us-ascii?Q?+WdbWOBmdQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 1axu9A2ONieU38srYuq/Cpo0XQ2TP1c5uVwMSHkrGDxsweXLfUFF5A3RRBgRxJvaXdr8Wq4Z445aURkxe9ZGuyME36UfcPTZF0Ka9WnZ6YdzkbsMToCoibu9J7+Wk6t/ZMPzX2qTKGl86okIxEalhzsRyGXX3KfzHA9R6OwSeT/QSm0SR60XNHYs3jWuLWbIzI/7fgUPz3R5eEVi35P01+8pi75wRJBYTE43s6ytsJVcrn6wRhmUWRV1HMSxGfdtudOQLEnyrI07jBBNjnKMpyrAwv+Lvq8M0ZBVNR6o8zBMd+fEQCmxJdIMBwWmQKDCkvIyXzKoJXEVQcdPcaDtEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a12ae930-8b35-4de7-b58f-08df301919b6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:47:27.7593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: At8fbRYM/XV8NPR6vuZbPhfRH4nHPY34HFnl1XlcNJgT6SsnSRXz7K2GWzExWRv4A4nd/Md2V4R3Vhx3cz35MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7458
X-OriginatorOrg: intel.com

On Thu, Oct 22, 2026 at 06:02:18AM +0800, Edgecombe, Rick P wrote:
> > > This patch will end up getting stripped down the minimum we need for this
> > > series. Any new functions or extra code will get scrutiny.
> > I agree!
> > (my only concern is the risk of NULL pointer dereference).
> 
> As above, let's just match the existing code. Otherwise I think its just going
> to get questions and not merged. We want this to have as little to talk about as
> possible. If we want to change the defensive level (I don't), it is going to
> need a bunch of prep patches instead of just embarking on a new paradigm for
> additional huge page functions. I don't see a need to do that, and for the sake
> of getting basic huge page support, I think that is a good thing. Right?
Thanks, I'll follow your suggestion.

Does the following code look good to you?

u64 tdh_mem_page_demote_2mb(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, struct page *new_sept_pt,
                            struct tdx_pamt_cache *pamt_cache, u64 *ext_err1, u64 *ext_err2)
{
        struct tdx_module_args args = {
                .rcx = gpa | pg_level_to_tdx_sept_level(PG_LEVEL_2M),
                .rdx = tdx_tdr_pa(td),
                .r8 = page_to_phys(new_sept_pt),
        };
        struct page *dpamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
        atomic_t *dpamt_refcount;
        u64 ret;

        /*
         * For implementation simplicity, only support demotion when
         * DPAMT is enabled.
         */
        WARN_ON_ONCE(!tdx_supports_dynamic_pamt(&tdx_sysinfo));

        /* A NULL pamt_cache is unexpected, so failure indicates a software error */
        ret = alloc_pamt_array(dpamt_pages, pamt_cache);
        if (ret) {
                *ext_err1 = 0;
                *ext_err2 = 0;
                return TDX_SW_ERROR;
        }

        dpamt_refcount = tdx_find_dpamt_refcount(pfn);

        args.r12 = page_to_phys(dpamt_pages[0]);
        args.r13 = page_to_phys(dpamt_pages[1]);

        /*
         * The dpamt_lock is used to avoid contention between the
         * TDH_MEM_PAGE_DEMOTE and TDH_PHYMEM_PAMT_{ADD/REMOVE} SEAMCALLs.
         */
        spin_lock(&dpamt_lock);

        ret = seamcall_saved_ret(TDH_MEM_PAGE_DEMOTE, &args);
        *ext_err1 = args.rcx;
        *ext_err2 = args.rdx;

        if (WARN_ON_ONCE(ret != TDX_SUCCESS))
                goto out_free;

        atomic_set(dpamt_refcount, PTRS_PER_PMD);
        spin_unlock(&dpamt_lock);

        return TDX_SUCCESS;

out_free:
        spin_unlock(&dpamt_lock);
        free_pamt_array(pamt_cache, dpamt_pages);

        return ret;
}
EXPORT_SYMBOL_FOR_KVM(tdh_mem_page_demote_2mb);
