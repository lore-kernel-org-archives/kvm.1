Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F0537755D;
	Fri, 15 May 2026 06:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825133; cv=fail; b=lbItIOTEo5gkF5gK+4RRuYbj8o4BkZ+CfxEZUcbfW+hWaAXLxuoZ47u/tYYd/yk2NOaG+PrNy+C5rwhglAw1NvUL+Y6EZL/qMl02zcpWS/H15u5gmrm4g3KIAYKKvYF7+eQUsf4eXKhpm3ROoA8vbX+kLmUkoQt499v9OSacjqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825133; c=relaxed/simple;
	bh=AkLYuqaTJZUemQK6A5WzgRz7Yzcj4sj8lqQmjtYO7gM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uAOkvhJKnZh+AMtSNuLGAyU3I229ojbhHGT70ETcCQJhGaJmXowxkOKGuVx2d+CzebTAoDO+ahQ+6Xn9NqDGyDz9zb2MIo92zi7EfYuu2ZDFdxRLs/40w2ozQ+za/cbajUtxL5wa0pYGWmI8yAjOlA9BagBau9TQyXfkV2VVeNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZBdmQ1K; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZBdmQ1K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778825132; x=1810361132;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AkLYuqaTJZUemQK6A5WzgRz7Yzcj4sj8lqQmjtYO7gM=;
  b=EZBdmQ1KoHEKvRl9vR/iNjJ6Xlka965VTsdorsWR83nEi6v6c8+51on8
   /Ph3mK4RzjNXVo9ui6tmKF/lb5I0JqJ2wujk1QJ2yi31SRQ4jjwcoNToH
   6P1QSIPRrTF+TYRoEIjmhaHlR2ivaCKl90TOjifJS3uCuKUt3/jsw2zB/
   K9sDNFPJMMA/c8B40cIcj+6Towxubg9pfaB7ITFMa6BvZP58isU67Me3s
   i0hP5XdOGtYFLHmtbu5DP0wocHYvE1LVrZdZ/DOen7RjDqKJuFp21D5XP
   ZOOFLNtkINA8GG1KJRHB1NMvx+KEnGYjXCMP+jem9+s3NR/S1RUbzRI7M
   A==;
X-CSE-ConnectionGUID: 6xnYrBZIS1iN+xh8Zsv9DA==
X-CSE-MsgGUID: Z4nlhKUFRnSlzocr/2Z39w==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79898322"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79898322"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:05:32 -0700
X-CSE-ConnectionGUID: WCMpGZElQfyIxz2onx7/vA==
X-CSE-MsgGUID: jcAeHOvGQruEWpR3sH7YUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="240417217"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:05:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 23:05:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 23:05:30 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 23:05:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l10SG88DDLEIVSRTtqURLk2YGgokU9Qr4Ja58ydCMiOBTFLK9/FYLFDHJtziehVEGe50PBiSP5gY6JIogREd5rPkbCqpXN4v4t5Sc8wJ/iOi+fBJqaaR1gosatxxn0z4Lv9qk1+WFEGyZPwoGORQ2dv4/73B4McDTb2WELkFdvJXfDip77BtkXWd/AC+ig82rFEAXtmFEY3ZR/2pKVR+vDIuFTt0NKZlFVYzrUGpcVF8Qjw1IO4+1EQqT+dqhUujKISc2FOX0iaLtfjUG3LrMX+RCaPCvtJr8Z/ccVClKF415XxrIH8Dc0atWcn1pKDZAc9Z64NAJocW8a5AunOevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0nLwMgCNuzBCU7l4VQB1YpjY6xsLweAzmRJ/ZZ7PN0=;
 b=nkrFjB7RBIng3wSS3/jzkCcbg2XRoWpD+lKDg1yq3gT5Z1m8eaf3TRvgFZStSKO+ItQy519/1Mdb6XwZ1ci9fj9bkwAESdkbpxXB0DCrQRloobEcw4Ygcy3OcoGyOOCu8bi/a1rMd5BrvtQtBUGHV4ydUpg7aXjMYVD1sC5vCxB6vqtx+eGqLnlhyVYbcZf9zjIszRqBCfpfftUEtt6eQA5DvDlp2aUF+eHm41HEmynUE3tC+hMvhpNQjzKY0iwuOUihwZyFyYtTqb3a/WIo+saOkWI/uiF2ve3xT7q8/X3FDvJTJoXUFSmVDZbvh3JLTLZp91ueJCftqfoaSwaiig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by CH3PR11MB7322.namprd11.prod.outlook.com (2603:10b6:610:14a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.13; Fri, 15 May
 2026 06:05:21 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 06:05:21 +0000
Date: Fri, 15 May 2026 14:05:07 +0800
From: Chao Gao <chao.gao@intel.com>
To: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <binbin.wu@linux.intel.com>, <dave.hansen@linux.intel.com>,
	<djbw@kernel.org>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v9 11/23] x86/virt/seamldr: Allocate and populate a
 module update request
Message-ID: <aga3k1JUe9DjC5/V@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-12-chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260513151045.1420990-12-chao.gao@intel.com>
X-ClientProxiedBy: TP0P295CA0007.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::7)
 To BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|CH3PR11MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 39978e43-764c-4b4d-9681-08deb247f1bd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|4143699003|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 79AWJFHILfuLBZGxMkTFoFq7O7vjlPdI0xgyKuFMdj7nmPeKNh3pRAeDaGALYrTh5oqq64maNaUHiT8qwd876B/V5T/4elGpygvrFaQuLoN/dNqXGhlvkLT3bauSBnYmcYso+x0gBozLs2qrCc3gK313isEgJuxRGnny/UvGnllyNbEIe84VqA7Sm6edBfqROgFyk6Ph7R6DhE/+793WqmR27V0T31muO9BJ/hyMgRn25kffj7cie7/GoZYgd9DKdpSjF8Q8P6dEmbKiKQjLtXvlEWus5aUUcNZxI+MHwbrgZRMJz1T2zuyba/e1RZIRQrZxaCYQi48tHT8pIeQPhUY0Yog2HnDvmupwus/MHCa+1l7kRddiHV38d5qH58He3WEpJpWTodR4k23WsgnPMO3/5mgm1Hdw+qsTIGAZdp72+OPUMkYcT4hSisxFjB8imV0fiPSEodQ9xX6wV/W0Q/8CbFiFGnJ7LYlGbLe4JA/fQwWnJxrVQPLqeeJkPlbD1ftPkVKhQMMJUWLIl3ntxBeEbaXQprfjNJo3aQTf+CXlRw9YO2qb40/F3c49bAL/qhdXMBlL2/FHwLcSeXbjvtup3UE0OUP6hNiKm/4A4XqfQtc95odLanoWo286MSNuKZjYuouGl7YtXOkNqk9WuVn2A0PVNSaXdJq1M/L3Sgyz06zzcz+augHnJDi//MuW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(4143699003)(11063799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EhZ76DqIhwzZECEZqlOHRto1xV1d2VMx4v0cSb/nVqFycoAFq7DbPQ2Y1gCp?=
 =?us-ascii?Q?PRzkIQsBqmd0Zmn1WcFQCUNff4mu6XJshVCNixWleQPo9BV08sua1h6ZOm5S?=
 =?us-ascii?Q?JtuL4/QMcesXIdDNCLp5RUz9574hWFRpLwWRLP2xG8ffVzFsXBAozVaHNgTw?=
 =?us-ascii?Q?+Q+Ndh6tW4ZyG3Q1xrNwHTvihoxLiEAlZW5iOmfk7QuDh/8GLcOqCxm/b8AG?=
 =?us-ascii?Q?kYU1kfJccUAj2aYDDv7QL2AV9tC3HGG6FEIYKCVtVUWs1JVMUi8xOrTYyX68?=
 =?us-ascii?Q?LE2Njfs9BcL1NYAs527+OWE4oJVQN1ooSw0ghdJOzECBjcMOyNfe4dmqEod2?=
 =?us-ascii?Q?CmqGjEXTFbbVSI0VHTfiFfVP7C8aQYAHGITcepH7mfPHTUroy2vwpTgOroxW?=
 =?us-ascii?Q?bTxzZjiqTwuoorP0nGkw17ZgUObzjO8RlZQln+o8V5nSfCHZuqlqWgxeVPsZ?=
 =?us-ascii?Q?MvMEygd8ybs7An+RQu8pavjcj+daCtH5zkZ7L+g+sYYKJ7M/NvWTSbsQRPC6?=
 =?us-ascii?Q?u6Zo6n6x2W7LycEsfMJuV0xMgB8bPVahV8raqnLm8qkuB1247ytIKo+YL7h3?=
 =?us-ascii?Q?ULE8PIbbb1Mn9VFXwK0XXtHLomr8JwfuCplD75aR2oS9qBuOyBLMXfPuTmiD?=
 =?us-ascii?Q?SBDKVhTs8U3A3JIHxm49XgT0akVCurjds0o4Q//WIFc8Y/b4HPfYDqR5yli1?=
 =?us-ascii?Q?vDnAJePBB5jxVPt86tDaJPOnY9Z9ugWORAHu2Eq50M/lIef/RoLmUOFcrs52?=
 =?us-ascii?Q?SAumB/SzCs3jFNbBjpdfYBrnrsdFVh2pGySw6706BRn4YO0OzcLCEXoXy0KM?=
 =?us-ascii?Q?9Ux2gqajlWemzje9zxpRsw9hLrHMR659EvVA2xytxe5OvtUSEGxH2O+D8JeO?=
 =?us-ascii?Q?VB0yvx9WdWE1RIp5DrU83bAisz5wAKWz6h7MlrKnyOF23Y+GZ++mg1NNDAeX?=
 =?us-ascii?Q?ZbMuM5r/aDJUPwZjwQ6zK1ajH/3QaX9Zflol+x+HM/4WpJ0le8dlidiHw5ok?=
 =?us-ascii?Q?0kRcT9acw9yNefOvvUJ/RGH22sOPX4h+KTPdbOMYzeQibY0A1mZvSPwrgPzT?=
 =?us-ascii?Q?VP/Mojg+HORkdYSCq2dhOpfTBCq9I9TXXjZMV9YTRDAZyu/aFKGdFhq+a5yd?=
 =?us-ascii?Q?EPnzFic/OdCnjnpIbOl3Cy/QJPZ1hcOTmFN8bOO+xJg91EnqCE9lrD2Nov8F?=
 =?us-ascii?Q?jSgmhRSK321zw5VUnZ5RuXOSjp39EGoyw7nR7DidpOpRL8iK8JN0lNzM0BcI?=
 =?us-ascii?Q?olZ1iyLET/csKqxlVzmFxcM8N61xbIPK18GbRLMab8rqp50hAYvC9xun5hDh?=
 =?us-ascii?Q?uo5+1EnDVfOOsd9qPSzVwgFv76hTDSJPl38PHeZ5fCDnTXbdZRwYBEFZ/P4t?=
 =?us-ascii?Q?5TkPvl16UMGX0Bj8+MhQLz3KxKWOk0wpaCz4lImtk4d7macUq/5vgNKzCGJf?=
 =?us-ascii?Q?GiQ3r/8mYGJ1Y9cZXkM6uk+yL8ZoVJn3ciiF0R8c6YwS2yzpqryfkG/cMg9o?=
 =?us-ascii?Q?kEE9cAC1cs1diH3ryWASTqC9w5yV+TvKh8Atul3oyDg1Vrc/L0H6nfKZea5t?=
 =?us-ascii?Q?+RlQd6iBRGZboz6d+3EQQ1wdIFn7TMoriNjmr6eqXqcYhSFJU8KcpdpBXW0h?=
 =?us-ascii?Q?wxx0mN21+kNak4nzxzZ9ppMdq4vqhrSvAb55ECS5v3CZYVoCYZkq4+WJwxQC?=
 =?us-ascii?Q?pTUecxMH1RO1Cohw2geMpjwwgA1J9AxfuJL9m3sJHoK3eF67EQ1u5A0IdCf7?=
 =?us-ascii?Q?s5Yp20KnTg=3D=3D?=
X-Exchange-RoutingPolicyChecked: CwGrKQsxgloRLXd+GqOffoYdF8DNBgwR/2RPPTvKJ8+0YFqimLoOVmn9yN2My/htgrUlZnTpz4GGNmN/InvyWkGDRLrm3iIXH87lJlJz7HRgJjpl2+ZV4VY2/SyhHx3S4cIbEzLlweVM4ucMlqmviZeiURz24iURJrUqBOFT2+675f1L0sdXC6eHAbtBgl6PX0MQbnj1wrEiGR9dHZVKJQrlphCWGj9I2TQwx3xzZQi/BXHK17tmziCM1m8ePEI392ocB3Aaf+y13IMJGn2qdon2YNItdPZ12mXoHQF9LvKNOcc1QBZmmgrkLlAfkWJh6back1LumcW8rUyDnKEuSw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 39978e43-764c-4b4d-9681-08deb247f1bd
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 06:05:21.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHbbyhlS4eRXLRcGOiwZ1k7sTquFkcaqXLRW8jQ1M+xn3y/SdeuMxP88y4T+U7BlXQS430hJmbmsS+/11AKSsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7322
X-OriginatorOrg: intel.com

>+static int init_seamldr_params(struct seamldr_params *params, const u8 *data, u32 size)
>+{
>+	const struct tdx_image *image		= (const void *)data;
>+	const struct tdx_image_header *header	= &image->header;
>+
>+	u32 sigstruct_len	= header->sigstruct_nr_pages * PAGE_SIZE;
>+	u32 module_len		= header->module_nr_pages * PAGE_SIZE;

I looked at Sashiko's two reports here.

 (1) The header is dereferenced before validating that the input is large
     enough to contain a full header.

 (2) The page-count to byte-count multiplication could in principle
     overflow.

For (1), I agree the validation order should be fixed. Even if the input
buffer is page-backed in practice, the parser should still verify that
size is at least sizeof(struct tdx_image_header) before dereferencing the
header.

For (2), I think using u64 for the derived byte lengths is sufficient in
this case. That avoids overflow in the multiplication itself, and the later
size consistency check:

	HEADER_SIZE + sigstruct_len + module_len != size

will reject malformed inputs.

Below is the fix I plan to fold into this patch in the next revision:

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c
b/arch/x86/virt/vmx/tdx/seamldr.c
index 58ce39315b60..9f4350079477 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -148,8 +148,8 @@ static int init_seamldr_params(struct seamldr_params
*params, const u8 *data, u3
	const struct tdx_image *image		= (const void *)data;
	const struct tdx_image_header *header	= &image->header;
 
-	u32 sigstruct_len	= header->sigstruct_nr_pages * PAGE_SIZE;
-	u32 module_len		= header->module_nr_pages * PAGE_SIZE;
+	u64 sigstruct_len	= header->sigstruct_nr_pages * PAGE_SIZE;
+	u64 module_len		= header->module_nr_pages * PAGE_SIZE;
 
	u8 *header_start	= (u8 *)header;
	u8 *header_end		= header_start + HEADER_SIZE;
@@ -299,6 +299,9 @@ int seamldr_install_module(const u8 *data, u32 size)
	struct seamldr_params *params;
	int ret;
 
+	if (size <= HEADER_SIZE)
+		return -EINVAL;
+
	params = kzalloc_obj(*params);
	if (!params)
		return -ENOMEM;
