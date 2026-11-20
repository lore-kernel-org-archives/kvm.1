Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162486;
	b=5N5rTdITKtMKIl2VBL++AKgTRDg6ZWY8OHspTcDQ0Uf3RfiaMZxDiYB+nl29NoOu9Kfa
	 FzYu7fnC1pTGrZbPNRZB5ixie8rMzb7zHKeP8rkWPW3AGe+YZgoe+BDNLVCxlEHys+m/Y
	 F8VXk6fkUaRezDL9S58vBB+umnpgftCqQPXm2++KKMehLNCQA8T71OHynDAKOWMftGRmT
	 QDbE8lwvUPhNaj2rL+lCFOpCfd4EXnckYRPzUqezRQR7GQkTLr6l+MKUrQ9R0cJpWdxyM
	 f1bceeH0CAMdE21rZKvynIz8tJv9G9bWK7n91b3m46a+bMwKKrCYRSiYWgvkd1doexQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162486;
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
	bh=gwhGX+6jLaXjV9nmDW2waxnGL9eq75CFSeHQUvx3oRY=;
	b=cvPwnaic9p+ePDl0D2Snz7R2bgi59CvbAHI84KNGYFkc3dhSEhWA/fqq3i2Mi6u7uvaN
	 0964Zo4FKEjKagAQ2densEftIz11YBD/NzHFYR4pfP3Jq1JfHQ8hXuXcVGy+cK9mgsXYX
	 XHHVWJYMPuUKj+FaoYGpJAyGjD9I47089U1RgUlGAJstoBdpu+/nclqmh07ruteiPKrc2
	 ywJ2QO/TpOMQcyc+5GZeIkJbDlBjWU0GFXPPhZvteOiQltMok7pUWZHdlLZ6Vni+RG0my
	 Uwn+o0raZ++jEZt45L3QdBBzDD1JeFTBTXthzJ9n1Eomd1VAYWClAreilHP/c858LOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VuVIX1nM;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gfkmQSXn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA0460A260B;
	Fri, 20 Nov 2026 08:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CA0460A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VuVIX1nM;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gfkmQSXn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795162486; x=1826698486;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k87G6kdFn9doEJFrqLvfj9ZMBDOw1e3N5cfxQyFUGMM=;
  b=VuVIX1nMYU72klD2KtHM71UnA3T1Avg/r7Q/Km9tE7yJXlbaUife6h70
   HDRKL0yY4+ip5DSCRHxOXYwroB8LcC2nzfAUd7zyZ4K5vA5YFr/msxA9a
   k5bRF3yisqvv9iN0kQFu1NO3xN7tZWJRek+2gkrLrVFHTadaPR/wK3ctJ
   RBGjzLqHCrSz2JDuBWKm3TckKni7thsA2VDYKEjHXfbS39tNSVdu6kJ5O
   XmJEMThJMOAlqOYq88SxutfxcPEe+qmCrrUdXJh580isHVfU28tK8P4JF
   LgwkGRRQf1tLGtvmEqHFsiohMVrj7XJKyzsq7nFdzNOYe3HS3UF+KqE0H
   A==;
X-CSE-ConnectionGUID: yahRqzQESqKTLheGzZ1rQA==
X-CSE-MsgGUID: cBL+ydXrQ4ORNs3+r4e/9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4034646"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4034646"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 00:14:45 -0800
X-CSE-ConnectionGUID: WCHRfQvMTRucNKpUOU4Q3A==
X-CSE-MsgGUID: 3L+hj4gBS/iwfdJdciRYKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10724215"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 00:14:45 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 00:14:44 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 00:14:44 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 00:14:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVEOIvXo6X/sBXszojhGUpmrTWTuD3v0xdPZngAtLbuHZW06aZDD+nv+zRqC9mWD8J8CNPpfJlbnS4Wu+lS8hv+KnXrodfwNb9kIXjBqGFF1/HSEhDjUPD5p2om/g8sAaDzHXNA4+s+ByvAoSsmIl04Q62tUqFHw/4F8XeIeOhQtB93Jcsuydme4mJU/c2+uoeRf3as1F/HZG2mMKPKb/ToL11sO4jCQekyIVkyNIqo5FLy5776AM7LCqKm2X7+slauXgPre6c0ksJqoTeyVZ7hH1lM1Gy1LFEufylcJqi4TboI6J0Zj9sStfGa+awHxhltDhyUWpQ3yqeanC64BJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwhGX+6jLaXjV9nmDW2waxnGL9eq75CFSeHQUvx3oRY=;
 b=wd//Ue0hIKCOP0pGVBpQAvqbEfeV2TYtwHZrUhg+xXCq74VHMJzm2ipff5/cCgB0YhDbJACRhpN6ivtzVqyD7xKnXfJXUdcj1uRdd7Ecjc32uAFBzdOGn+qys4qYYHLbal7WYehwngbRBbV3DAHZAfGiGBQd01Daa6qH61GbxHKKsZctwtCEry1oHN53gwG10qw2koLfdZscDu7qIya9yOg8LvybiZ9tguZc610rm3YDK3jGvcN459kI7fyS8ZqQXXl6wbtJZaaIwVHxAc4Lv06YrZK7HsHwm3rIbR0MA+DZZLxLAUAmGtBUF50SvW2Nc/wpPr/656dNuCdHQY0JWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwhGX+6jLaXjV9nmDW2waxnGL9eq75CFSeHQUvx3oRY=;
 b=gfkmQSXn6wBsa2MZuYOlzEMwAUu0JblJBKVA5ZcfbfplABHlG3v0SqpqoU/fsTVJ8ayzxklXklUtUlKbixAS67A9ZGHF4kjIr1hrgDVfwIRAdVVMIip3B/3Esi6TxuvhROZXLFtRWFYcYSoYlg0Cq700eWVPPRLC9/wMXpsaxyE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by DM4PR11MB6432.namprd11.prod.outlook.com (2603:10b6:8:ba::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.12; Fri, 20 Nov 2026 08:14:42 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0615.009; Fri, 20 Nov 2026
 08:14:42 +0000
Date: Fri, 20 Nov 2026 16:14:31 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
CC: <x86@kernel.org>, <kvm@vger.kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 1/1] x86/irq/i8259: Ack PIC vectors in the LAPIC
 ISR
Message-ID: <awABZ_BucR628XHj@intel.com>
References: <20261112170604.1971438-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112170604.1971438-1-dongli.zhang@oracle.com>
X-ClientProxiedBy: SI3PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:295::12) To IA0PR11MB8380.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|DM4PR11MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 070a941c-0207-4837-3131-08df46de53b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|56012099006|261021135927099003|261021123027099003|261021121427099003|261102123227099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: ujxkiGF8ZO2i+T728m9dOOWMcO+jTe+1w6FRxcrzbPDA0vzmPLNOr0o8FQvWj3sTAK5EBWRvtT3pPLRwPEWeRM2U/CMUOVwA7uSoWsv3uwbXluVFo/8suWNluz7M7C4mv/nBozd72h6xEJAh7g8j7UfAgFUgD9hbGNOUrSs6qLkALVkqqhUauTYXWtqFg/ZCIYyIMbADgI4HWofwo2yZ2jjjdfYbex7mPI4ZdWr1kzp5ml6RFPGiN5mhvwEm3ojp96MQP9PrFftHQxGn/quf7JBHmV0bxvg9FLrv7c/lbRmuGCfHo8gh/e8SMMwjHUHZkGSpJPTY/43KR/5gd7HHakgK+0xhdYTvW2i8XoKLVmVA22M7wfqjwaof05bH3UWwYIYWpmG/Jhd6HWguaQ6yTXiBLxvranbytgzd0iKo5nOVCyPaQR1CRw4q4/QGwXcB5D2RCJnWoohWkYBYXjxB77NNm8/pXKh2rmB26+xL5jLV4S7DCoutv8epKw8JfuiLp6R/lCu9CwthiufN4fR43qdHKm5s444tlgPKO3xRJFTnwj+34FFPd5woxaPAFGX/mSK7E5Ju2Fn+7MUDL2WFHGW8KgBdokKzr00LRMkahKvs80V5BO7Clg9Zi18EeTjbq2/53MwXIBa0ZQOoHHinTiSN5/TcRMIEIOkg9x5kOds=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(261021135927099003)(261021123027099003)(261021121427099003)(261102123227099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C9I4Dqsx+W5kmf/XAwbSM4HIAWuBPrrVN3tAr03K6oKfqRw1ACEBJFPxRTrV?=
 =?us-ascii?Q?NKUB5xhQsLvyKNnAHopezwANYf25CfGAa0w3h2k5TV3yBhoApOFtx6akxH/M?=
 =?us-ascii?Q?vwU0YIXAhI6tXOq/8Rj1JLwe/RPyEesu8p6jt5NObPLAbhR9qalwPeREiDa/?=
 =?us-ascii?Q?o2w4/med2ILFPz3XE2nhOMv9l+9GwDTxlMNBV7K0oYz1S/M2RSRkJTeu9+pH?=
 =?us-ascii?Q?QSPy5EqJKmESgm5E3shQBoLNPbesA6bMTSyPq+x2tVt+omo05hdr9slYc1zE?=
 =?us-ascii?Q?TX7yK4CsJW7SaS0jVDuhVGYb0ugYtV9nXLlNVuYgsQyCZkGMIWUoX4nb5GhV?=
 =?us-ascii?Q?iYIVIpMr2K1e8Q74k4z8hdLFfFqbSXg/iodegrN2EzHhAN3I5F3jytnjDiNM?=
 =?us-ascii?Q?XMdl4nQ8lN74QoxhYqZiz1pX5G8L6L8bXaB43tppgJKBK29OUzWL1UqV7k1S?=
 =?us-ascii?Q?VLIueYL+XBOqCVSYq+t02zf/IUWkIIywWiB8qIjE+444W8oFzf/FKcSqkPF7?=
 =?us-ascii?Q?RKNOcwM4JvBdOoNxPSjBX/jeE52IndeJ4JNaWAxVwO/cEvtU8jvz7dI3NUHw?=
 =?us-ascii?Q?FJ8kX1cDwiaQdrmEF2KD/mI0SP8upSvNuUsSSosCo2bLhn0HOt5OJ5NSxw+f?=
 =?us-ascii?Q?M8vTGJN9cT4FwKSMj8RwMKqgzSVzdxsq4XaFNAEAUNGunFfD5N52iAcYmyqB?=
 =?us-ascii?Q?RmnmIdWYgYBXm0WGJd81/FUOhmPX53F9WlFLNr1rsbXP4pUpvrMADCjlrbnX?=
 =?us-ascii?Q?3ITq33zVlaRWzaNqO6xuCHYQF+gym5a0k3I/CYnNd6Bi/2Rh2+BvrWdSzZKx?=
 =?us-ascii?Q?w9Vk4r+/n1VTBnKqFaajRcD6CI6R9ANFl7yH6U2ixT0hliuadkvH/fT/ox9s?=
 =?us-ascii?Q?5n0eL+OsCb/NpUX+fweFyttvg2FOYnEYgxboL0MNC9vmBALy2f0rQf5jYAbK?=
 =?us-ascii?Q?f+wwpew4UALqu3fIOUZlQlcF3MEPReB0IFNeucH8KrT+EFfwFfgQhHG7Fad6?=
 =?us-ascii?Q?htIFOGNGV1KzMynOjFZZOXQ2Bwe/y2QZ2ctVA15Gs4jJ1Sn/DjEgW0JZ6YoH?=
 =?us-ascii?Q?HT46d/rEelaP2SjdKmcIOM4GFqdhn+tIThOdmPjIzzdN8zyhBknFr3QXcaji?=
 =?us-ascii?Q?Vv/4DRHtA13dfP/XJyiScDk0tn9ic5Ck2E1QM9a5LB8WO1uZV+7bU7buEB04?=
 =?us-ascii?Q?uOC42Re2Ki+Y5co/JIy8VRn84ZMDofo3ZSv19gtbMNsrdqgF1HV6VLD6suTR?=
 =?us-ascii?Q?8ZQp3odpnxoP2Jgv4Z7yb1FhE3Kj2xbXC3YfDJO1fMPOxC1GyZSEIUHCN4lm?=
 =?us-ascii?Q?9tU5S9Ph4YWYdq1rslabPa9lHxh5ZS8pb88XmimFI2AlqGlcRzxDGejdbWXM?=
 =?us-ascii?Q?ZAr1tREuY4PAOcT3RjI9++dwt3GN6YhOedDbbTfgh/sELtdvfS5JPqqtbdN3?=
 =?us-ascii?Q?IAM5b9lWFfmS+P/RRk35GM0dSk11quYLbJysOZR3NVLNvZWRYC1l6Zi9Ebbi?=
 =?us-ascii?Q?exDnuP7eK2N675uk2TwjUXrlit5FhRRyoagAwuVKm114d1XU92nK2GF/lkA0?=
 =?us-ascii?Q?2ykNmdbKaw8dC+2ah/L9YHksqD/hk8qLoHlpdzg1oxR2rSBKANRdNCE7cZj/?=
 =?us-ascii?Q?CVrtQPLtpW0kJCwCzx5E6lqO4WCuJDFXbTDJlj8jGrLtZOS0Zzj+PM8500MB?=
 =?us-ascii?Q?tU/EDixa+Xb9OuhWUNtNpAGFFtaLEpQ4PRThJ0+dLs7z9eO/nXsnMM2Izjo7?=
 =?us-ascii?Q?Xjb5Ehu74Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: OX7e+WMlw3TxVEN1bHQtgNUm9BQesTrzleKyrJ/KghP2r6q6QWjF/32ETW2NUbw57/SCJG6T1C75X/drxmf5W5f+a+R2/bVdr3kRLMYQUpOuUB+e4qqUBVF+dAvn+/RJjN0ABQ8hFMIVrAbUhvl2a+73DrhrG2KOjK5SNSmq3t07UezKbSbUD/sMhyzibdaxMP56bBcCF/hkPAclTk7PvFY1d97becgavMBiMii6LI26lPk3OcV37Oj2jCxnW06XzDkilDGlndf3JTCzASixC36sdthH3b25Xs6s4SevknKuu99xrWIaKr2xP1l+0eC7Qyys6NedT3TwobJqFdK1kA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 070a941c-0207-4837-3131-08df46de53b7
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:14:41.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shgnqerwWRHn9tjk6wjQM03w72M3joqvxei0+HrwJiitEJhnHuFFhTYaQ/DuDI80OEudO3OcM4uc449HmtxJFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6432
X-OriginatorOrg: intel.com

On Thu, Nov 12, 2026 at 05:06:04PM +0000, Dongli Zhang wrote:
>This is to fix a LAPIC ISR stall that can happen in a kdump kernel, but can
>also happen in other scenarios.
>
>The issue can be intermittently reproduced in a QEMU/KVM guest when there
>are large number of VMs on the same host.

Does your production kernel include commit 1b558e14f3c1 ("x86/apic: Make the
ISR clearing sane")? If so, can you reproduce this issue with it
reverted? It looks to me that the one-pass ISR clearing doesn't clear all
stale ISR/IRR bits.

The changelog of that commit says

  2) If interrupts are enabled, then the APIC propagates the IRR bit to the
     ISR and raises the interrupt in the CPU, which means that code _cannot_
     observe the ISR bit for any of those IRR bits.

Your analysis shows a case where this doesn't hold, since the 8259A
handler doesn't EOI the local APIC and the ISR bit stays set.

You can certainly still reproduce it by injecting an interrupt manually
after the ISR clearing. But I think the multi-pass scan may be enough for
any practical case.

>
>Device interrupts can use the PIC, IOAPIC, or MSI-X. Nowadays, most x86
>device interrupts use MSI-X or the IOAPIC. However, the PIC handler does
>not send a LAPIC EOI, even when the interrupt it handles has set a bit in
>the LAPIC ISR.
>
>For example, suppose there is a QEMU/KVM guest using virtio-net.
>
>1. virtio-net is about to deliver vector 52 to CPU 2 (APIC ID 2), but the
>guest suddenly panics on that CPU.
>
>2. The kdump kernel boots on APIC ID 2, which becomes CPU 0 in the new
>kernel.
>
>3. Suppose delivery of the interrupt is delayed, so vector 52 has not
>reached the CPU yet.
>
>4. On the new CPU 0, init_ISA_irqs() initially sets up the legacy IRQs to
>use the PIC. Vector 52 maps to IRQ4, which is normally used by the serial
>console.
>
>5. Before these legacy IRQs are handed over to the IOAPIC, suppose the
>delayed vector 52 arrives through the LAPIC and sets its ISR bit.
>
>6. The new kernel handles it as PIC IRQ4. Since mask_and_ack_8259A()
>does not send a LAPIC EOI, the ISR bit for vector 52 remains set.
