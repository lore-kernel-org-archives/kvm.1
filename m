Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795525208;
	b=Cb+zCkRnSL3BM/ovGyo2igQyrtD/TA9W3vw/D+8ZtSVpO7YwiiNGvpHifs67VwvC7pXQ
	 dumagaGrU59GEY231oBphRwdu0safrYxA/CvPzKVNC1DpB94fi9DUWsjakMsJ3QtW38aC
	 ejMaKwl6tjKgz7vXBJAIyjkZYWVrDzlq7vdgxDmEmigP8Xki+Psbv1f0q68BNR7bvQ4TZ
	 aYhmag11TMaa8QyBIrOLXVn2hPyGwO7do7efsDVrXpUbh1CW/RBSwnwLWiaNm85anYAF5
	 zkGIsbf+iRAd2rYh+7SnDo87WPgqTRl7ATWjGIvd7Zkl9NR4ZrOyrFKC9I17cU/2sCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525208;
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
	bh=JyQ08esWWppFAlmYX+5MlnSIcrq84wfz4oH6mvrMVik=;
	b=iLZSUfAw5y5lDFawpUpEtpF1/BfIZHuI/JpmSgk4UhHywcB2Rxod6gUO7gxnOi5JhHLz
	 W6RhwNFJuYyOrRbkXM55xHqfI4JFlSfQ4S9cBGhTmKONNptLh5CmA5uSwEBPBwrxuW6K6
	 eLZydRt0nh1t9CvgbWVcJxg5xNgf0McMTJaHQ/bEcFPWPIi0vC43rmSscNnGZ297sZ3JI
	 nU0poRpvRXbV5SOd2k7i6MzW+/RunWIsG53mIQkoY4m/DiXp8bZMHA7ceg2J/F+7UYRj2
	 0WhCnFoiQWg/ju5qhS41OqQKnebWYW4WsE5lLUSJhcdYIU/OANi67+hGwdSFSXw9hJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sl19MfIw;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="TB2+4mj/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9D606A321;
	Tue, 24 Nov 2026 13:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14B9D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sl19MfIw;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=TB2+4mj/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795525207; x=1827061207;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EQ9zFe2Swkyw9jsBVqSi5ZMUM6rQ7P/ZhIRIz3MJ3qU=;
  b=Sl19MfIwPo8cVXkeIgaWZS9fvtNMOADH1tpoLQGo1d7bxUWQjTxEESGj
   N9SEGOllKTHop+dVTdbNF96uvVxbMeI77szbo6hoj3FxG7RsrXZ4/fxME
   R6XBCKTCONb+mxtmTefc87eIvDi4vKL8vM+WEVp3BQz/mKUD4BPs4A9hE
   EYxwZ2KKJnXoCuCNHsATQlkZgzCfTNkNjdOrm1KPCwJLMJS8HcSM7AQZ6
   NnbRyvUkapvOrg8luoT4hxCs7BBmdj9dDeGYgWh2rPk0TosM3veew7JfX
   pkq4PrnOwgYoI1D01j5P2rsiOSMyR9HCFGZa75Jsxcla8aZy0rqBHEAdu
   g==;
X-CSE-ConnectionGUID: cYUNIcO1RoiR6/LjJ5uKQQ==
X-CSE-MsgGUID: vg9N5ZF+Q+SOrJbDD2784Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4257277"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4257277"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 05:00:06 -0800
X-CSE-ConnectionGUID: 9UQdAtXeTR6EbSIAR1oKVA==
X-CSE-MsgGUID: conLUzBISzm77hBrmUDY5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11876511"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 05:00:05 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 05:00:04 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 05:00:04 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.38)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 05:00:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVurYgOBAMY3ZO8k1bxHaslCJt+cUMnn62n/p7pZQdkrASQSlfllI3zHfwoesTvKhUKl8EJsDcz91KAhUFo2KbAwJZkxJczw4THuICaa9WNWKrtK1pYnE+mvFmIZAro6dVGPQ1+PZUUgslqfjpJTHnEYxXMExzjfFk1sT74dzyWZtgxpXA7ZttQXOJLwhH67jpTnAk9gwKCLkwSQ5gGH2TkwhBH6Z/GmxKevlMv9prKvjsn+kHresPKAlgXnFmkiCdy0/DsKOXumGeDK4xTBduTsNc0dcDxGwQ2WsC2BgOKG132RswBHwddFNjptpZK6W/DQTdBUtoOlKvvXGLvUrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyQ08esWWppFAlmYX+5MlnSIcrq84wfz4oH6mvrMVik=;
 b=tpKNu//WDOR3FLtTPws+omqXAOPfxh8pfKDWEqpM3V6UNGCx3jI70l2DIH18Thn+G2fqVR9Gq0ByawV2VgfbAiAnwInVrHFGlleu3LJr7zSYdfeInZDffApZPHIk/sW1iNIboJjkvZLXFA79s7Bw4auJSGjEmYYcSMN+CByFE3C4S3SymQgm+IICgTk9FEDvn+sd2RzLf0hs04TQZ6EZedsV8AS6E6cZbt097IbFs7GCEKUAMiAQes9GuwZlZyMaHtVO/CO1qbJEYtQAbyTIxt0A8WTyeCfpZc83U99w90zLqJM/qt0Puu+Up33BOoAGqsqDXWRaV+z8A8QS79Epiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyQ08esWWppFAlmYX+5MlnSIcrq84wfz4oH6mvrMVik=;
 b=TB2+4mj/S/+t3iCQQTdGwSlX1czGHHi7EGXfSlaWaSxEu3gWJZ3DxjpT4OIZZrRI51T4P9zt4V6Re8kda0hH4bh+u2X8U8u8tkoFf1GY/73adlpSVsyYtFfCbAFqghVW5Ly4mJy2l/T2q+uEJcfx5jUEw0bQY8I/7OtW0rPzu5E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 12:59:59 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 12:59:59 +0000
Date: Tue, 24 Nov 2026 20:59:48 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "tglx@kernel.org"
	<tglx@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "kas@kernel.org" <kas@kernel.org>
Subject: Re: [RFC PATCH 2/7] coco/tdx-host: Establish an SPDM session with
 the device
Message-ID: <awWKRJQ3_rIgxJVC@intel.com>
References: <20261116111037.3478844-1-chao.gao@intel.com>
 <20261116111037.3478844-3-chao.gao@intel.com>
 <ac7befe5081a489172d87402e55355852a9e62ac.camel@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac7befe5081a489172d87402e55355852a9e62ac.camel@intel.com>
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|IA1PR11MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f21187-26b8-4ee1-bfbc-08df4a2ad891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|4143699003|11063799006|5023799004|56012099006|261021123027099003|261022105027099003|261022115727099003|261021121427099003|261028144727099003|261026121527099003|261022075727099003|261102123227099003|261026140227099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: LgNyrmQxx6k/PIucv0BUA0uF/7ZJHZqvXhri8CoFji9RwSAIbzsHuQ8pI26S+VUplfEb47ZO24JH2Chwe8h07REs9r4ZI786eRqVc3TRpSvqmHUcLBwbbSMyjcYcFiPwCN2FKw6Uy6orrRs+guoTc91+qzAkG06b1DOHwbuEoHkXuHjit6qx8q6z8muGczKYGuluYJ/HT0XFK+bH6a5kiOiwAq3ZBIbnXrXQDiH1pfzTa9ygDx9DrMB1EWHhBIefAtMUMBIDvXVxDkPySq2dwG6bO/DiwO/7wyuk6RAlNvXiFqTBEtjnD10D7qE4r0IYeU9aSwi1bDnSo2+XiFM3NOC0rXMXw3/0ui9mOFTDysBKAHKt80/cQOOj45dT6T3aI2RkEAqDpR12GuGNOEtR5iP8Btb15xwESupjavoj01+C/h36bD0K1WNDCo5IqclWmjw3xTcNnR+0ti3gLWcuO18wn7f4VyUXGJZMvOWR0E6qtnS1sSYH9Sm3HUIKUhNB17UPKEoCwaBb2ehyJ6lhDIoCi9Ki433pELPPD054m6Paxm6da/Tg/D3IYhXgDTY0h3W/z1Q6+b9ckbIbigc578bB0lAIGWyDGa4QSTuAKwKHmwsOPbit1bIJ8N7BJ14Zw6edZxN2ixaCQFTPeYD6vJQyHiRmKI5wFRoEK5UNtZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006)(261021123027099003)(261022105027099003)(261022115727099003)(261021121427099003)(261028144727099003)(261026121527099003)(261022075727099003)(261102123227099003)(261026140227099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VGCLp44yVmSJNkTmMzGzsrj95qYBjpcj3bHgPhn7gM825Z5HVemwBCw8EmBz?=
 =?us-ascii?Q?+5MGFbaxnFf2z/lhnAg5tM/swRIuZDon83KtJ1lcs2hcIWyyDN9MQxPhId5c?=
 =?us-ascii?Q?/wpbaznUoDAb8nR1KQ+kJng+rJKYJ8FJVQvDgz8bOK+Phcnc90Niy/Cdm4Q+?=
 =?us-ascii?Q?BDZX0uRzCdIofsNSg9/haWHOMDJyZ2BBt6sLbWZu0S1Pfz5stZJRRz6YuoB2?=
 =?us-ascii?Q?eSXt0y5v83gEEHH8+qPFXnOGi6rhHSb3+ZxTtbPYMfO1l6eSjaVeos2H33eX?=
 =?us-ascii?Q?5H+Djpsqo88ecIxiuE+8SQ9XQK4Qvf0YWbuf9M8yi6IBNO9pcRQOmN5xjIR9?=
 =?us-ascii?Q?LJJ8W0y9a75oNDSsx3+P3OQi2Ws7fb5jBYl6v5quEl3B9mmyX1jnBcUgTZ7v?=
 =?us-ascii?Q?UKGqfE3jylnYhF54ubhCNvmaI5LiuJ+ziAEnNxx/nMzqcVBLmI4YdXXwnbKL?=
 =?us-ascii?Q?XhI1Maut/2w7z/UW0uln41T8dYhMaHPAsalswVyuwgEoD5dP9TTSo5n4Wdjw?=
 =?us-ascii?Q?X5zBMMsIqJ2H4ZdpMxSnNiC0eD0lumWg15pDL9WZrD9ClHg2ObGCB3RFEbjR?=
 =?us-ascii?Q?loRBJk6HfUG9YcdvP9uu85WykCBkWnlyc7aaKNAhRlKqMNlYKepuRzluh8qf?=
 =?us-ascii?Q?qrktDKB1KWwCSa26Ilz6ryrlVxqfr/2thVyS2C//3SySOifEHYY3dkN9z//U?=
 =?us-ascii?Q?Jgji8FqeMwlZ8h9rsI+0/cuwK5gML34/uZyfAtJyN5tnYXMbHzb1KtewoMSB?=
 =?us-ascii?Q?xSvlxt659qhGH2LI5nwxPYhoZY4LNHa4z8VC3ysQ62EYUbvE861R99zO8OEg?=
 =?us-ascii?Q?hmgzZiPbDY68Atv4mhYAy8pGu+kFD90Rtxs63Tgt0qIFeJgVhfrhlMoIELfw?=
 =?us-ascii?Q?QDtp+gJuwuZebACrYEgw/kG4oy1uexKB6kidZy4k4Ua6p7aetrF5/Zjmm5wA?=
 =?us-ascii?Q?N9e5TvH32j2CQn19sMtTSzO3/HGuJhvZAAb8uNYsvMw0izNidVjqTRsABWqk?=
 =?us-ascii?Q?Ni0tf0txCmQWlxN1sWDqhOl9KVFxUpLcfI6ZaFbZEYK9Q33yYDyKz4eLPWs5?=
 =?us-ascii?Q?5vO6MnVi9xUYRoHp6ENkiO+569tJUdLKZ1evdXGKhvY6VsZwpn6F9ziAgugi?=
 =?us-ascii?Q?CExH877mBOxCzTinbqzyWwl9FAdqx5H4MIrci4XLNq1ODeP+XqB3YGOD8zw0?=
 =?us-ascii?Q?/TlcTEzGsAyfaiMJdaSw2fMliD+04nxgahpGyE5BfxaNMSV8vhjvJu0YkJ83?=
 =?us-ascii?Q?9slhCxTANGxdChaXg4qIGhChjWkKb1Ike/a0LnZePgZCTFwLQEs1my3WHMQW?=
 =?us-ascii?Q?VIDxpDGHBA+6r9zN3vGEPAW3KZkw9AOG5ppL20O7EplxITqVvL+SNpfdxXl3?=
 =?us-ascii?Q?oXnZD8W6uqczTY6RH0STJShZ84IGW9/4pTu6yq9woChqKMP9M2LsiVbj/Z9q?=
 =?us-ascii?Q?Lbvmio4fELwKxdCV5hEjLPDwBsjuCfluRJH89Vp5TFdAqqikg981wMC7Ds2F?=
 =?us-ascii?Q?Fntl8DrYTel/TEXYd76H6RFqN72H4TKCQDJCg0MtvJyjJmadAafRt4RuqrqP?=
 =?us-ascii?Q?HejCyBEj7xrrkdyU+Bp/mz/wE+NwRtOdQdrN/mpbNPac8kSodGkKzcQEj89+?=
 =?us-ascii?Q?IzRZzidxsbFWvWUD32+pAPkJpBSlamfzACX+HWcYeOV1DMtmwg3X9pVa3x4/?=
 =?us-ascii?Q?ftvyQirXXc5DiDsxRxyXfb3rK88lSXUlmhh1Wuv3im21eCKlli0J/no8BaBB?=
 =?us-ascii?Q?wyIJWzOu/w=3D=3D?=
X-Exchange-RoutingPolicyChecked: LvumflkIW1lBUJ/B1RZJefrvQM6nM7jHBu6RXl3LOxboYelwAKHqrx7+4IbAHHlzf2ADuSpMUVOgP8HudunCw9KH7Zl0vLrT/Wc2xE/L88061UcEYsr/vzg9+KdVXdnAJqZS6QXLTc99wMQ13p4f8NzJ92Pf3xEl2Tb4hcVPmZcq1N1RnPy3Qw6rpwY83VMJEc7mygzktPTttXOGqQRsJnvJjmCLXq8hA3O2f0n1QF/HdQwqPRJUoIMB5htZLqKxErULYmACDqzBlJGM73PjdO4wqeLJqMxF2dUgJwlBO/eBB5KjH9UI8N3XOqK7u6GH5PuzE1KFHtH/28JphK6sLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f21187-26b8-4ee1-bfbc-08df4a2ad891
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:59:59.5662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtibD+Un4fKmt8wMcU1azE7cv7V+hbKwht6XqNKgifp58hFAiASlXSkysk2jOxljBqWx6bDKr08Zi+ZhYebWxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-OriginatorOrg: intel.com

On Tue, Nov 24, 2026 at 07:23:09AM +0800, Edgecombe, Rick P wrote:
>On Mon, 2026-11-16 at 03:10 -0800, Chao Gao wrote:
>> Setting up PCIe link encryption requires a secure channel to the device
>> to exchange keys. This channel is an SPDM session over the device's PCI
>> DOE mailbox.
>
>Probably SPDM and DOE mailbox need some 10,000ft summary.

Does this sound better?

  SPDM is an industry-standard protocol for establishing trust between
  components. For TDX trusted I/O, the TDX module uses it to
  authenticate the device, collect its measurements and exchange IDE
  keys with it.

  DOE is a mailbox in the device's configuration space, through which
  software exchanges messages with the device. DOE is only a transport
  and can carry different protocols. SPDM is one of them.

>> Whenever the TDX module has a message for the device, the SEAMCALL
>> returns with a dedicated status code. The host sends the message to the
>> device and calls the SEAMCALL again with the device's response, until
>> the SEAMCALL completes.
>
>SEAMCALL completes? Could mean the full extension operation or a single seamcall
>execution.

I meant the whole operation, i.e. setting up or tearing down the SPDM
session. Will reword to make this clear.

>> Call both SEAMCALLs in such a loop. The DOE transfer itself is a stub
>> for now.
>
>I'd put something higher up explaining this is laying the ground work, rather
>than announcing the gaps at the end.

OK. Will add one sentence right after the background to say that this
patch lays the groundwork.

>> Pass the messages through two pages per device, one for each direction.
>> One pair is enough because PCI/TSM serializes operations on a device.
>
>This probably needs more explanation.

Several functions of a device may want to talk to the TDX module at
the same time, and each of them may need SPDM message exchanges. But
PCI/TSM serializes all operations on a device, so the pages are
allocated once per device and not once per function.

@Yilun, let me know if this understanding is wrong.

>> +#define SPDM_CAP_HBEAT		BIT(13)
>> +#define SPDM_CAP_KEY_UPD	BIT(14)
>> +
>> +struct spdm_config_info_t {
>> +	u32 vmm_spdm_cap;
>> +	u8 spdm_session_policy;
>> +	u8 certificate_slot_mask;
>> +	u8 raw_bitstream_requested;
>> +	u8 reserved[4089];
>> +} __packed;
>
>This looks like more SPDM specific stuff in TDX. Do really know other vendors
>need it? We should at least group it in a header such that it is clear which
>things are SPDM spec and which are TDX.

This structure is not from the SPDM spec. It is an ABI structure
defined by the TDX module, and it is passed to TDH.SPDM.CONNECT.

But yes, there is some SPDM-specific stuff in this series. I will try
to separate it from the TDX stuff.

>> +	struct page *in_msg;
>> +	struct page *out_msg;
>
>SNP and TDX both have the DOE mailbox shuffling done by the host, right? So why
>doesn't TSM allocate and provide these buffers?
>
>Oh looking at the code I'm now very confused. The request for SNP is in private
>memory? The SNP commit has very little info to explain what is going on there.

TDX and SNP have different requirements for the buffers. TDX needs no
special handling, and both pages are normal host memory. As far as I
can tell from the code, SNP makes its request buffer a firmware-owned
page. So it is not guest private memory, but it is not a normal host
page either. I guess that is part of the reason why each TSM driver
allocates its own buffers.

>> +	spdm_conf->certificate_slot_mask = 0xff;
>
>Can we not have the magic number? I guess it means any?

Sure, will remove the magic number. 0xff means getting the
certificates in all slots (0-7) of the device.

As a heads-up, this code will go away anyway when we switch to the new
CTLV attestation framework.

>> +	do {
>> +		mutex_lock(&tdx_spdm_lock);
>
>The fact that TSM protects us from the buffers getting clobbered by another
>request, but we still need the mutex only around the call is a bit hidden. I'd
>think it at least needs a comment. But since the tdx_spdm_lock is really a TDX
>module specific limitation, why not put it inside the SEAMCALL wrappers? It
>seems more related to core TDX module setup type things.

I like this idea. The concurrency limit is on the SEAMCALLs
themselves, not on the SPDM setup/teardown flow, so the lock fits
better in the SEAMCALL wrappers.

>> +	ret = -ENOMEM;
>> +	in_msg_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
>> +	if (!in_msg_page)
>> +		return ret;
>> +
>> +	out_msg_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
>> +	if (!out_msg_page)
>> +		goto out_free_in_msg;
>
>Maybe dumb question, but why do we need two buffers for this? After we post the
>request can't we just read it back the response to the same buffer? It doesn't
>seem DOE code is setup for that though.

pci_doe() takes separate buffers for the request and the response, and
so does TDH.SPDM.CONNECT.

>> +out_spdm_delete:
>> +	tdx_spdm_delete(tlink);
>
>We might some basics explanation of the SPDM operations are. create, disconnect,
>delete, etc. What about adding some comments across the patches that make it
>clear when and where each needs to be called?

Yes. Will add a high-level description of the SPDM operations to the
changelog, and comments above the functions where needed.
