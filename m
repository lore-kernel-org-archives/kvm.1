Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794386773;
	b=lZB083sbWuamvy1IHnaBbuFl/tOCvtG1GHx3HmTX3fyfLs6BnfSyKEiY+ePuoCYNG/Kd
	 +W7S2zzFajiTaJw/xZ8tCplYr20M/pV+r3zmDkxTYMoPGF3BkMTNLzkxh1s3RpiTf6mty
	 v+SN3zjwmYdkop1J7hSN2L/qK808X48foo/NBclvtFsIO7Cc270phmevRcd9+0xCISIzs
	 gV4pOoKXlmjr2sS0RbZCI8v1QZPzDtIniQzD2jnOOyiVG7mybAYYZAL5jcNB17UJCizsI
	 qGpFeoyoGDpOPqiatoH6iRIS8gMAmJSTHQWelHOlJNeN/gL55KyBL9cX/0w8VlhPn3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386773;
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
	bh=S8H52j7m/Y99NanXvrKsgMwIF3oIhzf54jzkrfllO2o=;
	b=qN6sJl8IMbbOMoNYo8jJdv4l7klOrCRkGcqgJoaiPJQ7qdhfT9q+n871PVnew9g6dL6P
	 PAyCv+tkiRoNhNkG586uYYNCZAIeeaPi/kJg8gBs2YaL+65V0MbiRg0uFXFL9stVQVSUT
	 E8/u4kAKbfRzWjMKSbUBa1dkxCUjeXFMKhPO56ahlNafGvkwk//JX0OENOHk2x/j5/Z5W
	 KEvcThrSAvaiNiFUAwiCOJmRCoVd9s7yz35IQw20xE1AFJGllZOJlbOQswDMLs4Ee10Cn
	 dIMU9PsW292PS9Oysz00dR80WBkbMwMulRr75L00SDjGKfHxl6Z+uMUcasrKc+344mQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hKLfQSHJ;
	arc=fail smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B412606A32D;
	Wed, 11 Nov 2026 08:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B412606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hKLfQSHJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794386773; x=1825922773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ta0BH50H78xHnOVAtVBgMei7eUfte2clVZ3U+HO5qpk=;
  b=hKLfQSHJZAZq5lnBFI03PAExUFmHQyDDZxMJxBiAAIdAvNYeJL5edlqE
   zKGmvmvFS00s1rA/GWkjQeukj86VSmwjSnvktytmLTOiKiORWKbApD5QX
   TJIbSPSGIdUSugVcpEEeqoiltb2cbDlQi+pVOOldcgSesLxIwfDz4Agf2
   JuN9yB1bImhZN0JvMPM0BJmwGnRMKbX8o19eDiC3ufRLqzqBUUL+6Ph94
   I0FXzZTr6EiGZVjlmGxiGloCwOAj1kP/DvUdO7/KceNhfnhetVEQiV3ok
   LuM4coPwb5SHOR/BEq287Ibm0cgsYXkn6m59YWE4xeobh3VUj0f/uQfpi
   A==;
X-CSE-ConnectionGUID: zdSpS/wPQEKqT+HmtHytlQ==
X-CSE-MsgGUID: VUWNeExBR9atPMp0R0SmGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3186249"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3186249"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 00:46:12 -0800
X-CSE-ConnectionGUID: g8KFQPksRuufFbrLnp3o8w==
X-CSE-MsgGUID: 5NZgkUaTQdyhPkdlhGeaSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8550832"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 00:46:12 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 00:46:11 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 11 Nov 2026 00:46:11 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 00:46:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysWvqjXUDyU/Gke7nQ1ZEomI0qw0BbeiNdw83K/OkG8DpMJNcPIV25OkWDeEEQ/Lf0TgDpJGAjg/Exw09w8/04U55zbzH8lXVQKZELlb1cRODPVMSPAGW3lnkvWRdaS5gpyC87qplmLU2JW9LTsK87kFoqyl5VCS3pyZsIO0NsztR9O9xY86CFmfUol6pu54/tJQhoKkZV6AopgAFbO6VfwRWpOJjABQxb6Nq8vUKDxzOLen7MQRNwSG9CCymhXW22H0kXxYIJugjawBFzwX+KSPeRZa9xNshbaOgYvuDIrpOwKTEkkQFd3aK3MyaSc1UM44R1vv7D84dF3TyP00IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8H52j7m/Y99NanXvrKsgMwIF3oIhzf54jzkrfllO2o=;
 b=O/RV8IDAfHza2zcVmFBhcW5szUeBSuu8p9dKWiJyAuch2MESq3ynbf9VqDdQol3wQiOY+DOcYn4erLFE9oTXLluQkNuU1nW9gZsJ2IE4+LrDxOKlj+ZuHJ30QIkWC4wtE8stmz1NhdUQP1rcMzzgQab+3K9gyh40tC9DrRKtwsVnSJGeo/FZ8GmyYkGTFsmDKDupJ8Y+R55D762IXvdfPybx104wcgw8QvSrDgmIq1OTd+Lsbtcf6gMrVWab76y+GGyhRezeic6qA9/A+zG0yzcFeUFRNtgnRMD+Ghah994Q+eHLZL89fjkham9rGHQiP2sS+PKVLnxoEwsWpfX23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by SN7PR11MB6994.namprd11.prod.outlook.com (2603:10b6:806:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:46:08 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 08:46:08 +0000
Date: Wed, 11 Nov 2026 16:45:56 +0800
From: Chao Gao <chao.gao@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Van De Ven, Arjan"
	<arjan.van.de.ven@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [RFC PATCH v2 1/2] x86/virt/seamldr: Support large TDX module
 binaries
Message-ID: <avQrRFuTOMcDUbqg@intel.com>
References: <20261106132159.1551365-1-chao.gao@intel.com>
 <20261106132159.1551365-2-chao.gao@intel.com>
 <0ee3d9592e4e73bd0e5bedafc836033fdfc9f120.camel@intel.com>
 <dc2d49c8-18ac-4f24-bd49-1f81ce300562@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dc2d49c8-18ac-4f24-bd49-1f81ce300562@linux.intel.com>
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To IA0PR11MB8380.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|SN7PR11MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 8961dc4c-d21c-4c92-e034-08df3fd03a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|10067099003|4143699003|11063799006|261028144727099003|261022115727099003|261102123227099003|261026121527099003|261021121427099003|56012099006|261022105027099003|261026140227099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: QvKGHRTold/1AR+UNQd5cWpdwnW9Wuo3T/ZYXHAAmk7XJHDovBmRtlgehd4H2Wgs/fuG+Jo5tq8/6rmwfFFWPBQkk8txHF4+4FkjYe2DqSguMvSHCb5GMBkwjZhlWUuRkTS1EQdQuThnAsTDLFP6HSwEfo2A6AjZxBRTCpKTphq4SihhfwBuTKOnY+47QOTG7LA9wmOXDegq78GWKCcLDE4qIYnATLpFayy4ZbF/T++LN2teIaSnF5kf06/acWJMMtSzeZvyf5ACVyviymv18gr2REiniQQk+fV+XwBz/ypEKlpqJJVKKNHZ6xiJD9YWKXHdrzCjR2IcowK7jOXm5aybl5cHJJ8EywrXAxk3/owmDPn/8V3QtkmWZPGiII9UX2yHkwF5tyK+gZNMGEGldUnIHAR5fJ2jOehcNBRJC8vKgDE1yHrd5LEJeBv94LSRDBhtvNNHGXNvW9FF7yIt6w+/4S3Ntc9A6uotNGuwJLNs0KKtctgwkgN16boCmn73v6oXMcy1JrgOopB0D04yVxN+2QD8kcWrunByZzjqj1MVO2IDjazPz0QCax7dWqe+BbLCpgmPFxzq8NcqCcwt9nLz/PcfJBCr3uSOXGHfkAukYkZeoX6kyujgTpNNP8wU3bqkQK3zRbQL1XZW5yMXwM5csOhDjDymF+72Le9GJ38=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261028144727099003)(261022115727099003)(261102123227099003)(261026121527099003)(261021121427099003)(56012099006)(261022105027099003)(261026140227099003)(261022075727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3yrIOXTvmdk7e3dIojlfhdMh4MUig4uP4mjCb1c62iyqLW0GLJoSNtybqLja?=
 =?us-ascii?Q?WNyHSbzIpRbbf6X3MI2AYttgFAycrisgBSRPzXZ14V2EcotVhivwXWU+BZT0?=
 =?us-ascii?Q?RFULYvM/opsmIKOhkQi/+0shUpnG+jRjdVm9vxSTqWNFobleGsRwNwQDv0+e?=
 =?us-ascii?Q?ToQ6hUrxuQLwZ6ZBDDOJde0HLMnzE2nONKHPw9InNFyvfQO0FHfKZkpFZd/j?=
 =?us-ascii?Q?x4nQo70nkeQUYTASkVMCiMqOIN35VnUA/l17I0ja66CMWBohfkMnmHzb6TB7?=
 =?us-ascii?Q?8g2pP9V/XJgb5Y7ZJYK1MdO8AJl+LZc56CZW8/8jy8MI4ApBpuqtfwLr8KK3?=
 =?us-ascii?Q?255bJRoiRn9A6r4pqeHFEJ+PZPYLz+M+IMbhs/1AtZtLI9Ty/waTpPTaNUoe?=
 =?us-ascii?Q?w+XBAXQ2MSsmJbHDiF0uXo3POnYwgt/BNpAm+0LJujoxrYY2P0Qe/pVmdR/x?=
 =?us-ascii?Q?ScDENQj0wCqjU1uNBS8sZ2tHVMat9VZbE3ELOPoH0G6rq7hh03V7I0cye2r/?=
 =?us-ascii?Q?n/Hg/gO9VdMKufLJ0WeSdzZDBj1TwMBBozcpFGe6HoaH+/2FbxXudlZYOsQ6?=
 =?us-ascii?Q?v32WeS+BGDOrXLLyMbyzAxCDrZmtcfwOaLBtGpRMH7pqRFF8ZZnJRGrAw4yI?=
 =?us-ascii?Q?WLya0ZCRGgaCYGfuocQZHdvIpbHlTngPhxXP1EMSZtvsWjYzoMQvxGeDLk8Y?=
 =?us-ascii?Q?vbamYH7PCSpNYpluPt4nQPDnp+e/ntW3pD0xfiB8sjJRaPDEqqup1ushMD3o?=
 =?us-ascii?Q?02kfseLWbHjz3f+wdAP5B6DWfDyZtE4g1sENC0XKRYnwwCVbzMJQ9T8iFrgr?=
 =?us-ascii?Q?a7+3scNQLYF2BkHL745gjyGXLaEN1kViIPOMYOxy829HuN0FCZCna1SaOnbR?=
 =?us-ascii?Q?1id3RcOeoLvz+7iQ7T4zUKh2KEoxSpVDffcMaDVlVdH9Zb7I681MiIfX5yMI?=
 =?us-ascii?Q?NMJ1QJaSa0xgc98X9yfFVOQB1s64j/OVFmpY11ifm1bL4v+uFVXSsRj9jxYm?=
 =?us-ascii?Q?KNve1vzrD+qdiayo3CvC5OgF1A0GBb5KOg9ULRNjDSawb4IUoUX1GXRmeTx4?=
 =?us-ascii?Q?T97cCBsA8webnE6fvuyRUmCovKEtnz4NLFELUttsK5zJsRSsYzWLZCRV7518?=
 =?us-ascii?Q?p0uRNCqCJenZQomqn5MXux55Ez1f+O8WJ6Y1erUt7Wd7FB/jmCM1XJ6BBbck?=
 =?us-ascii?Q?iI09GTk5YGU9qQmMyk1Q9YUggf9V0pUH5po1w8tULU3usn4X6I7Es0l+f8BQ?=
 =?us-ascii?Q?CtWXEFFd9FB+I569krBv8ecj4SGJFYgMZw0+QTqEmiR2Sz/otqq8vhUtru+B?=
 =?us-ascii?Q?tbceF2vLTOiRR1OjF6742wIUPM2XIbyNs2uwupRRJ0Jkks0/fLgq6TLYlPj4?=
 =?us-ascii?Q?Ph9Dfmhw8sMH/djE44cjtmIQSkSxExn0uG0C4wsrANcOLF5IQtz4/uOfuwOr?=
 =?us-ascii?Q?L7NdqrTGIiBdrjuzy4b/HnxdvtNufZBdEi+iQOc2Mi5C1dJ7ka6zWupuZPz0?=
 =?us-ascii?Q?eEZNCZET9cQZ4sqxNF9KwGscNh3C3yuA8ZjVAZ4CKXZRy+8G5K1OGb79eMkZ?=
 =?us-ascii?Q?dtUB5eOuTZDj7BuiVaHFzUr11JhnfieS5X9my5ivh3kxW95w6HuTVyA3hS9Q?=
 =?us-ascii?Q?nv6Nnpqdrkaptx01xbsNlx2KXwhB+jcTrgpFmJOm942hBrboNq3Di6OKSkuI?=
 =?us-ascii?Q?/sAaRVhk+QAwcDRGYP4CvR/nuA8WURik5b/7E95k8v4W5E5mhWJEU09Eg5gL?=
 =?us-ascii?Q?a+YYv6psZQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 05eHKLPSX/r+s+jOmcd0r/zXWFHB7qv54KlYlfOV7TqRY2cXaTOum7+29CMocy9v72XNEe1CK/tKXkRNrEXUpAR/ajFWX2W9ysyLbLGUU+j6jB7cTdW0NRkF1sXYRjKo0UQZM8dlGvrddCQ2/3lCAT88A6cRsQhU5F0ZYekjkC3EXePM0+5wrvxb9H3yhrE6AX4Zt2R72GJNj+U2Ubxw+vaX2kRr3fEQI5P3HwAd/uOJF0Ai2dDwouv32x5SLlkNr6WCWF+/yWO+xKp6KRVFxgpQSJ9UOPrHxxkOwetZNUkjv20DyfQ0C8KhEIkS8KtQJ9WHhyiWBXdtUbNKX8jaNg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8961dc4c-d21c-4c92-e034-08df3fd03a6b
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:46:07.9643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYiOvSrQXukp+jppNFhUj3Dq3TUgL5LyHBDhkYXL7HJpegp5tCYMcIvZn57I9q5KfwqYJpsLM0f4zJ9UApXk1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
X-OriginatorOrg: intel.com

On Tue, Nov 10, 2026 at 02:34:17PM +0800, Binbin Wu wrote:
>>> pages. The last entry of each page then points to the entry right after
>>> it, which starts the next page. These link entries do not hold module
>>> pages, so leave them out of the maximum module page count.
>>>
>>> The 16-page size is somewhat arbitrary. It fits modules of up to about
>>> 32MB, far above the roughly 2MB of current modules. It wastes 60KB for
>>> today's modules, which is fine because the memory is freed right after
>>> the update. Sizing module_pages_pa_list[] per module would mean either
>>> moving the allocation after the image header is validated, or allocating
>>> from an unvalidated page count. Either way it is more code churn.
>>>
>>> Do not query P-SEAMLDR for chaining support. Userspace selects the update
>>> image and is responsible for ensuring the module is compatible with
>>> P-SEAMLDR.
>
>Although the change log above has mentioned "For a module over 495 pages,
>...", a 496-page module was compatible with the P-SEAMLDR without chaining
>support, but now it requires P-SEAMLDR with chaining support.  Is it worth
>calling out this change to userspace?

Yes. I will call out this behavior change in the changelog and explain why
it does not break backward compatibility.

>>>  /*
>>>   * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
>>> @@ -129,17 +140,24 @@ struct tdx_image {
>>>  /*
>>>   * Given a vmalloc() allocation, write all of the backing physical
>>>   * addresses to pa_list[]. Caller guarantees that the array is big
>>> - * enough.
>>> + * enough. If pa_list[] spans multiple pages, point the last entry
>>> + * of each page to the next page.
>
>I was wondering why SEAMLDR_MAX_NR_MODULE_PAGES	is not
>(SEAMLDR_NR_MODULE_PA_ENTRIES - SEAMLDR_PARAMS_NR_PAGES + 1), since I thought
>the last page should all be the addresses for module pages.
>
>But I find the code below always treats the last entry of a page as the pointer
>to the next page, i.e. SEAMLDR_MAX_NR_MODULE_PAGES is indeed
>(SEAMLDR_NR_MODULE_PA_ENTRIES - SEAMLDR_PARAMS_NR_PAGES), but I am not sure the
>comment is clear enough.

Right. The last entry of a page never holds a module page, and the last page is
no exception. I will call out this in the comment below:

/*
 * module_pages_pa_list[] has 496 entries in the first page and 512 in
 * each following page. The last entry of each page is reserved to point
 * to the next page and cannot hold a module page. This applies to the
 * final page too.
 */
#define SEAMLDR_NR_MODULE_PA_ENTRIES    (496 + 512 * (SEAMLDR_PARAMS_NR_PAGES - 1))
#define SEAMLDR_MAX_NR_MODULE_PAGES     (SEAMLDR_NR_MODULE_PA_ENTRIES - SEAMLDR_PARAMS_NR_PAGES)
