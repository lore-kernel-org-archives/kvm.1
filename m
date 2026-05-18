Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DB3254A5;
	Mon, 18 May 2026 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090797; cv=fail; b=jPoUwaCQlQYPiTzRlqWyN021XM3NJLNCPro2uwU+2rusvzAgTl4oewsaBMbxGU0MJhW9w30HnXYdmSVXFUAe+zzSpAcaFArMcsYV0o/8mpCXS0f88IBWDoEJxUDYSkgndik1vM/YnV4Ryrcjv6i0VY5UWvbx35TfD1FS9eaSFRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090797; c=relaxed/simple;
	bh=ZtJoZSHIBeIVbvzsWN5ga0J03ij0lIg5YJdmGUdpYVA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pbH4BBhp2CcMBnA/9AlpcQcxkTqIlqcZYFVCMfKZpC3Vek3/gbmnOLe+KosxLiKJ01IhBGdMRGoy5WkkKxaNy2gG4530PBJHQqRMOYk3Lgec65PciNVPfqU/p8yhZgAwvvRCghx3ni5f0k46ONeNDSa/fnzSxlYbphwImhGMOII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/V/DKE6; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/V/DKE6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779090795; x=1810626795;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZtJoZSHIBeIVbvzsWN5ga0J03ij0lIg5YJdmGUdpYVA=;
  b=T/V/DKE6fNPYcVdvQL14cKu9nK3nxDq7MHgb44poBfr2jU3ILhm/YyrX
   +31LJQyAUuvpbhZvaFhReJU1vsHAxCTnyUTDF45XkVBoAIWse87P/NeAq
   KUQGAk1thT8XOKTIlHQRWs/aFqPml+30SsHYzN7rKtsYx2goYXwkKamzo
   FMJ4Nau2il0qff+lpsHXaLnPLNn5aK9JoAmoUfoXrFEVIQ5sw777x3Uyq
   nENiCRX8QheAV2vLZjtBlcCvD9by8BKhSgnp5MJEB+bLHCBJgFkjgoUWH
   wMWQkOJMOu2/6CaYuqu0ilMqJgybunmzvxVup1t9OIrZ/IH9KM60TvRMA
   g==;
X-CSE-ConnectionGUID: BCajiB1zQZavIXFE+auW+A==
X-CSE-MsgGUID: O2rkCrmvQLmz7Bc2yU3MUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="82501453"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="82501453"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:53:12 -0700
X-CSE-ConnectionGUID: sUVrttqrShqAGv2/wyrLSg==
X-CSE-MsgGUID: XB/6n+nbRkuh5PMDJMpZ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="235117855"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:53:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 00:53:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 00:53:11 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 00:53:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l18fgPY4MzApjOEVOPRBsxHWFUP9sxZEJ8MHPVlC6IqXUDqTB/GG/VqssOVx2MqavmkhVmHRrxJPTJWFZVqdV2HDLmK6WN3n9sLN4+sy4Z3lCKv07HzTG90sCyqZlgG2SwlMhbCRA2n7uU6rzpXeXT2qOMcTd8VrIIKGcDvXCGMvtl90QtQHYalvmaMhBLrz2Y5sZU5aCl+eKc8Zl6hTKR9TFvBE2iyCSuffdfAUr0gwH2JAd4asBypSS8K58sIs/EPo6Pd06pNjDumz9y4NilSgEQcaibrAJfrJDhbDeZAlhvK4CWTOjZwj7ilgTZFcDW0yYRRd/ZQrxBfZjbwUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtJoZSHIBeIVbvzsWN5ga0J03ij0lIg5YJdmGUdpYVA=;
 b=OmuvfWABw6xEb1afAEJSTpUxWTnPwkUGq4cizXCXskc0BNYC9RV8JW4iLLBryDaSPati4lKlzvThwKXbPDbsSKrZO61X7/YKZyRAreXMa0AGUG7w7fIIRBwG4IFzMh3CxZqOLBVlrv/hG39JXrA48snZnMcElApr6MEBsHJnj6VVqPkq0XJ30l3H1hC+ksMxDIfQhjS0ODjT1y/x7ELOfPA1bGyB1hWfVmY8E4QEwI9/4z3a9xDebmLHtBkm32yRxdSdNU6fLV+pi4pfnV1l7MOXR3U5R29QB2HbjuxG5V0DaVhZ251XxmpOjilyyiss8ruMpeWDhreAC0XvNy449Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by DM3PPF01A5BE19B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f04) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 07:53:06 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 07:53:06 +0000
Date: Mon, 18 May 2026 15:52:46 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dave.hansen@linux.intel.com>, <djbw@kernel.org>, <ira.weiny@intel.com>,
	<kai.huang@intel.com>, <kas@kernel.org>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v9 02/23] x86/virt/tdx: Move TDX_FEATURES0 bits to
 asm/tdx.h
Message-ID: <agrFTv8Lr3HeNM6P@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-3-chao.gao@intel.com>
 <c7d64460-d03c-4198-9320-8afceafcecb5@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c7d64460-d03c-4198-9320-8afceafcecb5@intel.com>
X-ClientProxiedBy: KU1PR03CA0033.apcprd03.prod.outlook.com
 (2603:1096:802:19::21) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|DM3PPF01A5BE19B:EE_
X-MS-Office365-Filtering-Correlation-Id: d635685b-d53d-488a-519e-08deb4b27eb8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|11063799003|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: Ttu+uyh2wva2XgErk+hxkS2D4VQnY2jbeyBvfOZFuXZawQVp3k5uHZ7sESqpfjRA3dADLn6sUpr8t9m3aNLGTQf8ZqPpUFQY+LW9M8PT1FwGCjpo38EhBCoKEVSLqgOLqAPRzUA7drXNoHk2URvXJe0d0/QtXH2whMyIlErMfLj3WeoDloxPUZLl9GRgxHSN7Eg9CUrORwAr0ZqGXAdgipX8Y7LnEebt68/IFThAV7OQ6OrPbK/GxfoNCJIrJIxDI8rEpPoE4pk4MDkbHzObI6LfVbY3MQWpBRicG0Y48n7qmqTdbm6Zz4IG7bfmRHVzU5dymlqJRO0IDZ+L3U4WZmk7CEdKman6eKPJPrz+uEsFpPGB9dmVuRYV361rGG2vEPkmDLGudl16mbJO8nB5LjBr1Seq/oUglYmd75amP5oXccDDNp5pZQBK4Z4dZ4lsBKSNQjMmCjH5hURXJiqdood93qLuvzLkQRvVr/AboBLv3mgp6WFSDe0Mfjgz88sSPG2if5udRVGkhH3COIkTzuiOScZjOUWeqM5RnGr5/ICb9tCd1mpcd8AwXQtG8TnQPsZCdq+KuhA/QJM2G8Y2QsbqXTNlci2D4vZp2N8GqMbQRcgAOPj0Z+F7E4baeJCpAytTGbiYhGqCcozEM7HaTWRpjM+7Pq1gIXiTto111u4vIHe/TrCKA540jrTkDwMm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(11063799003)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WRcnGTz+5fcjvyvzqAoNCgsqu2RxkGaQxQRICuiyHByJjLswesHaugKnyyBm?=
 =?us-ascii?Q?LvPBSiT6im4xQhKZEzJrI8HtAWwFX8LwhR4onM6An8JfCmMxa0DCDWIj8RTm?=
 =?us-ascii?Q?HMLo3ZGvGrVNOah251n+yVFKQokdx7hxZPRM2zrwGfQMsxzFOmOFGzNmP4DL?=
 =?us-ascii?Q?P4HR/YYiAwDzMJW9oHmXHF75xpwixeX2L7pEBsWw0JxCYFsHjXxY9sISMQfc?=
 =?us-ascii?Q?Yr/r/2k6BgmeZf/P9PWlcP9pSNc8ad9RLFVrkHY9B153agOP1dm+2deaOKTx?=
 =?us-ascii?Q?pptS/hxfzz+MNi+0S43elU2Ey/ooZOf6qNYe7MxyhIJJ62y0Fqam13cldjGL?=
 =?us-ascii?Q?Vqmyyxo7IDVOV+dXJ1vfRbs43sJf3J1YZ/QHlY/o9eigtiPPktCVrtP/hXHq?=
 =?us-ascii?Q?Pllu4vH73d3Z73/EQ0q8KvTexZ+yUnWfuliDKpJTwqJOcb6Wndt0YvMFS+W5?=
 =?us-ascii?Q?4CTmgW4ghGJ6oOb1n8yVrqOKVdQUpw94l/5CiFYZ5GHHJGNtP6hQDoN1tbVs?=
 =?us-ascii?Q?RYzgJ7A1KQqV1ziheqheJwa9LBE/nkV4d0rLxPbmLXE/Lvz8sYEdfHameGaY?=
 =?us-ascii?Q?QY7LytHuEgAuG7KR2LCtjY+RaGVxIH5KbAkrJ+vmCYZ4xNZZexHxRkmJgC/O?=
 =?us-ascii?Q?CFvBvf72tOXQ+8O8H/qkHjAlXOXjwI7Ih+WhhkpgkrJet/6CmzEFH7dxX5ll?=
 =?us-ascii?Q?FAtGUM7V28ZrIONqIgNwnIHNMXUpzj9G9T+BIRO4EKprJODjq4BH9OVnaOWu?=
 =?us-ascii?Q?4BylLuYz96WYIqjF1iiiIzJlIy/YMTa7xoEpK9SW10JEnQAuN9IXmzfnHv5+?=
 =?us-ascii?Q?fDA3mzaampU263IjG1BxtOyKUh1WWTxkbAbn4VmIkmzdLSSar2b3JeX0psVJ?=
 =?us-ascii?Q?RTW4DOSk4y31fceE9Ssxy+PlW8lxD5q4phg4J0u1Vsikz6dWoX9NtksdmsN0?=
 =?us-ascii?Q?6fq+tgTbdocjQFi47EENwNwuPheg2qKUlc2wva6iAJVyTPqld/jPlJrN1Mfe?=
 =?us-ascii?Q?NAp9jeBS+29BqHmn+V0g5U6W2BTj6W0jyHf8P8wMgoP/QTUrI+Sn8tghdb36?=
 =?us-ascii?Q?OvrEx++wJit97v3vkApiAk1gq0OAtC5ZvzzRuT9OjEM0MOux6hNhIXOQ0evg?=
 =?us-ascii?Q?L0zJfIx7kU2MbC1fmavaqUIaSLcnothwSXFWqwvhQdnS7mEuJgoT1uJUsGT9?=
 =?us-ascii?Q?lCMlaKepzlirFU+VJOApUn4Exny32rkNcOfJYA4FrSvoDD9lwM7SeGfzSIsl?=
 =?us-ascii?Q?JidZcPeARtWhE/Caw4pp3GHVT8bIP9PpsALDJy+/M3sX3RuuAX1M8xtA6Sn8?=
 =?us-ascii?Q?IBMazYTlOkVXKsgnkvtTaS1562TU7/x7bIplXsCoIHd/39V+1S0xLpByz3sj?=
 =?us-ascii?Q?XsHxb2e4bItpHl1Tdnbj9qtMKkw0Jfcvdz/xQFE/vdsXxNLRA8pVBzggK2Dd?=
 =?us-ascii?Q?KxMnVM3EYPVzu8dGFwto96xA1T5ch3ud2nxnq4zxfLzxqbr9Czyb49+8QnAC?=
 =?us-ascii?Q?eQIVhqE2Fs5wTbBt02Q8wU7bT9VLPN5aOIaS7tdxGoZZdE7T8PCkL799kcnk?=
 =?us-ascii?Q?pCF38Ab79sk17SrLyuMUMj225NpoEuDnnSa2FK44X1kDV0KDYoy9EZApc+EN?=
 =?us-ascii?Q?Yuq2+Rebj6C5KrVBR7Es+AmgEDcsknyMvzW6oN6GQp6utPy444qSfY7/tiEs?=
 =?us-ascii?Q?Ienp96fCHBOFiW6c0dRvh0NCUnLfgx36Wpy9avuGWeXFC54N5Ajsrj6ni1hC?=
 =?us-ascii?Q?Gh/SA+YRQA=3D=3D?=
X-Exchange-RoutingPolicyChecked: rLSswiieUq7oS8rTBlmjjadbLSdPKHx0qeqSs+7Qs8YPhfywEhv+2CW7rSAwDByDtcWkPUcvWwQWLLVvcCo5mQsSYwH6dCDLpVw4AUjH+4PCl/UdL+Oy5iUMdBD2jy2oqJ/2WjECa4yTEaGupKUOWC89IMvVXqu8j7aPIx8DVh2WibnpmHx7qzwi9cpBL597bv1JZ68UCf8Kgs3JDuHbpqOYrORzK8efExMEG7bd38D0AvuBtD4htyixwkZZ3BSWY571Ut1tosdn/xcQWPzq5BrGC3V8BZ8OWiqJ7ReDF080lMsmQtdyceq9LPJMUCMYJ0cqct2nbZ6JNNaHNw5rQw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d635685b-d53d-488a-519e-08deb4b27eb8
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:53:05.9975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXGeWAcVncNmEUYyh7utO+v017VGtig113fvddfXj6+pGylSlPJkL9+wfeNkWUTjp+F1Xt5+HTo7nhjh7/mWvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF01A5BE19B
X-OriginatorOrg: intel.com

On Fri, May 15, 2026 at 09:15:47AM -0700, Dave Hansen wrote:
>On 5/13/26 08:09, Chao Gao wrote:
>> This prepares for TDX module update [1] and Dynamic PAMT [2] support. Both
>> add new TDX_FEATURES0 capability bits, and both need those capabilities to
>> be queried from code outside arch/x86/virt. The corresponding feature-query
>> helpers therefore need to live in the public asm/tdx.h header, so move the
>> existing bit definitions there first.
>
>Please don't add unnecessary changelog cruft. If you need this move for
>this series, that's enough.

Sure. Will remove "Dynamic PAMT" stuff from the changelog.
