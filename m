Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278673F0762;
	Fri,  8 May 2026 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778250352; cv=fail; b=M6J9iaZi7TdZ28SKGcVvv5SgcZLrLWSK3AixGoCBc6TKAWukHg/iD14XAEULUbLgNOA1f/7wnqrEGUb3uLUAbUPssby+Uzjf/u23v0hJp0B6LyGp6QPv1ZXRLu4LfF9qU81/4tzGOhecuwzM0ksa9DSr4F5hUwUTIs5bLPsCbRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778250352; c=relaxed/simple;
	bh=neZGqCyzVn9AqHOE+5Fl1SeuL3KpbNxiUw/fMVBj52w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t24zYgCDQZJqSRU7K8GOmYvgG/Z4b5m/OUyBZ601YYC5z8oe6Sm/HKyfzDCD1LfJn6WAC2PQ08X8RMoiBPG1x9N+SEbyzyyBNtsArY83VZDMPlMw8GN1IGp8aO1wo1cVxXnBlNF7UJFb2TaIlSOvqiSXGTfMUOJAIpCeglHSyjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUTLgpOM; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUTLgpOM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778250351; x=1809786351;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=neZGqCyzVn9AqHOE+5Fl1SeuL3KpbNxiUw/fMVBj52w=;
  b=gUTLgpOMYY8nNZbvWSGFBeUeN1ELgRNjUg/DIQKYccBvpzR6YUv/hzRa
   YN4sv2CLmZ4xt1UPosEReXcpcXt9lrTHsWPVwaE64+B3bzjxhnG4f/A7R
   ai+Ltx1xifda8c6MukfwdkG3hOwHFCsAgwOVgj3wdl6H7RlpjA+Du9+mH
   D24KqBstaN7t6uvVawQz+ZQ/pBx4DPaUbxmOyrts53BIIoxt/jiqhIhOi
   bmmiCyHxj947y/qC2r68cUqEgpMLoLlrXYIdsLPdwqaOlneApqD/o5wxL
   pxnDxJ0eTzYr/yLA7fBWZYE6iRhkO67QlKxcn0v5gaGn/dmDWubfKS5yC
   g==;
X-CSE-ConnectionGUID: ZNIMi2mBSbeiSKybY10yJQ==
X-CSE-MsgGUID: fgYys7wxSy6VBdv55/IlnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="101892351"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="101892351"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 07:25:50 -0700
X-CSE-ConnectionGUID: M9kkFIpoSa6e+hjucBxYrQ==
X-CSE-MsgGUID: rQuamROZQ/q7aA4YYQPSOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="236895252"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 07:25:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 07:25:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 07:25:50 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 07:25:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zq/nHVJOipTBF6h3bwC7GJ+lVDmOZzmmoR4PB79TtNB36/apbSUjEwQXJbYEn3iYkLx9GVjdTIg0Ux8X2L7IBSMAISAm0IOADtcj5bySFPp+7ywUkWo2uzeUW/acm7EyVrHNuINr7fk2QKz5yNhraWoq8xht19IU9SQSOwePrN+abzZVjeoWtpY/vB0X7IV5nPJsETuxnkxmSHq+mcetk2CnfKXTIoR3Klaexw3DGHmAc1x70AvEnMWyGNDNFRxSyvMYWQM2wTsEos46aYUpZ22geZYU7UV5ZENwnl350KdV3OWIsvxSQoqfGs1sZONIls5HDp5I6DCXVS5apRu6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXlCKHIZI/OGeS943GfHuKO1Qu/4h18GoWxiHaX2V3A=;
 b=cyJ9BLdAGa1gTSfTgiEBDCEF02fp/A+TDXFoViiSsTwxQykEZAXjfi4YN9IYTFoJaRYUUTS/5sp4oGVBDd5S4HBo7/Tl7l79Km/rasCoXsaQqeI76Twl7sB/GM3+w91jLKSYqM2EgPzhr5bBez8WqCQcGJpmexupJ61Ycq+Sr6gB6GK5dYxli40CUI6FE0ahf5GZKeI9bPL2u3jKYdfcoT6OUAmVWjCwq7H7bQhu0gXZhggXpdEiTwBkGP8DiRmXJ6fbO/tOH90dA2pqafmNoB0O8EPJDJsoTvxTDZOGLf/TikP9am8rEqhsC/L2wGa16sl+BwvPhYkeNEG5qQ01OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3282.namprd11.prod.outlook.com (2603:10b6:208:6a::32)
 by DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 14:25:46 +0000
Received: from BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19]) by BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19%4]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 14:25:46 +0000
Date: Fri, 8 May 2026 16:25:36 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: David Woodhouse <dwmw2@infradead.org>
CC: Andrew Cooper <andrew.cooper3@citrix.com>, Xin Li <xin@zytor.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, "Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <chao.gao@intel.com>,
	<hch@infradead.org>, <sohil.mehta@intel.com>
Subject: Re: [PATCH v9 00/22] Enable FRED with KVM VMX
Message-ID: <af3x4nukic9smHdX@wieczorr-mobl1.localdomain>
References: <7f93eb25874ddd13a1ad6e3c75785f11041c8b7f.camel@infradead.org>
 <DADE0E58-DD8A-4206-BF54-1DA87864117D@zytor.com>
 <afojoHJSlqqm2Ges@wieczorr-mobl1.localdomain>
 <f4cb5f8e-caf5-4513-9538-edaaea20de2d@citrix.com>
 <afpPt7gObsyFkPRy@wieczorr-mobl1.localdomain>
 <f4650572ea8277dcde8d68e4fa5317e1abdb988c.camel@infradead.org>
 <afxm400MglHAjoje@wieczorr-mobl1.localdomain>
 <1146015e19d441f135d81f376c158c938a7ba340.camel@infradead.org>
 <afyXgQdzdTr_JNXf@wieczorr-mobl1.localdomain>
 <e2c20e1773b9579ea4cea3b26d7eec02671757f8.camel@infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2c20e1773b9579ea4cea3b26d7eec02671757f8.camel@infradead.org>
X-ClientProxiedBy: DUZPR01CA0251.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::23) To BL0PR11MB3282.namprd11.prod.outlook.com
 (2603:10b6:208:6a::32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3282:EE_|DS0PR11MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 24857ccf-607d-42cb-9dfd-08dead0db177
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bXtNjFOPNEmK4jQwK5px9x7bEY0DXpc3Rf7LwXPVsHbZZXc6CuBQDCpO/M+YMKOlqAIH6iXegueY7FYZxBvjcJCpUZmMr/EAFEs7gnYYk8hfEAKfJ2hdJj2wjcm/GhGsm4DF7OSMRCIv/h8yrHrr8QvjFKLQlN1oVD9rhkbIhHWqUSZ5s/AslYijVndf1A3yQUNt7E2N8tOHWGGn6uVUFzU/48MdVf4eUHqpilG9HlvVRZTT0tIHqJCGEXPtVo22IIsKD9EIxKVv3eZJpx/vlb+wTuJAel2zCNH3dnnvwkFxkWy0vhxCHEwnQ5dmvkxeHf6F4HC4xCtzq+GA/pz66/9TKP0B8eh95dgHXTlLSf+65SMY7m/ZUBCEz21MQAaEdaVRxnEPWjouVK+Hc7AT/1BvwxPW6ZukYVoldNBsgacTTTpOMMvPzMB4+c9kezCnphVWJypJItZfrLCcr3aUUda7KKNqUJ+SmvGyysWmdEmmRVeM4CiP9AYrL6eaBsypXGkDKcE6JyvRLbco+Dect934IofUa/BrwNh0tudiXzlhQ9xBpm/QVe2zCyAoDAj/Sc12Hsyr4XnANe/RjzRnplGhPJGTkREaxyZzQl3G4nvjdADJJ9ICnbjrLKZJcrHazI+y/lsYWv1Eh2mEUgvu/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3282.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?PnGFx0CWMIQcmyf5lH5/Hk8p5hiCSnehri0fhdlKmWDKq489ZEXUI8qdZ5?=
 =?iso-8859-1?Q?jlH74LoPk9bUdlOkD6hS/OoXo81qTd0MYQ8rdGVmMf7qIHdBrPCapdWCPk?=
 =?iso-8859-1?Q?LSVtta4qOYgTXUETWwJguvWSAfrtv2qHP42JF+G9II8B6CezBad9kjhlnR?=
 =?iso-8859-1?Q?2yqQLHQEdK+ppjHVdOjcjJyoq6xFxv/uM2XTKqh+WZjqa/V1rjFQ/rlGmq?=
 =?iso-8859-1?Q?RRMyXxQr8sxonHdxIte4N1R/5PFAugoHfWuAA4FVMhHlXvWKwBlkAxfgHy?=
 =?iso-8859-1?Q?+uFQaViS+nX9zZLEljBQ+0JiuMawCLhhp6h2AFRQkAzh+GJBZ5uxl6KFdY?=
 =?iso-8859-1?Q?jsPq3X87ZjVNpFls21TdNtZkIzhsq+LssfFqJgOuOuADs1OXBQB/kl/fvQ?=
 =?iso-8859-1?Q?cp99QuCtlkv4/+zTX3ILWE5nkVXW8zkQv1RzDA4oXv1lX+ekpaWzx4aRbh?=
 =?iso-8859-1?Q?vhGhRIVxYXgUU5VusYY6Zh2sZi32vov9L7jZ1BQtaDb0NfkaEN7Fvmr9o5?=
 =?iso-8859-1?Q?rnJOjSc9w0GdEWpzSvAmfsfKA0RJISXBxeeTbW5WPpXsnfl2QHmZuqyTUr?=
 =?iso-8859-1?Q?ctWRLOiXyBvd2LZvkY/qQjJKsph4De1rg9TZrA8zNHCPQjYusoEi3HwwR4?=
 =?iso-8859-1?Q?eMhXIZx/NzYXJYp1lyYmgHv6PYamfsVGFaejo21ayLsbRcV6dkdRvhuAhD?=
 =?iso-8859-1?Q?1twfy/Grt1o5usxxxjC+1GxMG1ny2F6PFCpfQkWXvLUaF5OjCe38/ytKVp?=
 =?iso-8859-1?Q?kgjs+aTG1Oj8N3LKew2UbYE19cYrI8rysJoxjwZrWM9xoZZ8cHYw8FmmsB?=
 =?iso-8859-1?Q?Q9naAKIPmOCYbXZRPUP3TemGFkREzbPSU9eZ8MPriiemrwGUVMr5NTYPST?=
 =?iso-8859-1?Q?V9HhEdqBfwnzU+xKR+z5kqa5shOIj/ze7oZm4tk33H5lUuSzHzK3y++y/G?=
 =?iso-8859-1?Q?m47xtfdGMlNkmPqVx6+OqT7cddg3HKa2uC3tdKhEZ7H6SB11suCVABhv0a?=
 =?iso-8859-1?Q?4QtE15T6/RNJGe7kJS5gw50LnmnCxoYU8SCqy65qzMNObuFqDQ2bdtVv31?=
 =?iso-8859-1?Q?nTTcjVcM/Kr9aYU6fu2R02rFrmitWig/jp9neiDBaokjeOeiYol6cT1PbI?=
 =?iso-8859-1?Q?uA/Rm407d8oCGg/ae4sos94nde/XD4moL0WB6sw/1rN+rNGpvU66XpcQAn?=
 =?iso-8859-1?Q?gNg8ojF9U33vURWFi4MZJMbCsGHZCNmJ2MUv1O0SC7ANnDBdooNowPW+uW?=
 =?iso-8859-1?Q?+4OTdGmG7nO8s/CRq/C4Uo6KFT39I0uITsUQldvipX/QwYOpturXFYQix6?=
 =?iso-8859-1?Q?PH/oNzXqgQ7XOw/c/nPBK6uP1jVCgbYAADWqXUo/0wNS5s2V7pBLF7n8zj?=
 =?iso-8859-1?Q?JzMFH7FvoMM3ts4UiTQRQW8oW/KVXN8ty7QPWXruKardT9qMIlaNVqKBAF?=
 =?iso-8859-1?Q?4cOn0/NcH0F3IXTV03Sgx1J5bLDZz1z22mvRJy4xgTgyGjKL8RufddrPGZ?=
 =?iso-8859-1?Q?UuBWbDkOckxet/Y7o8jR6LCpIGkTb7Oys2/xg6mIEz26o22D4S7a2hTilF?=
 =?iso-8859-1?Q?kr45DNgXpJccS0IMVTmLjG29w2AwkjvHKx796WmRkgRKcmsqztblqKe1de?=
 =?iso-8859-1?Q?GMBkoEZQ9xvKnrVJsEJ/aRi8IAtWpJMGieu6HDwDYoPAseogINXSI8he0c?=
 =?iso-8859-1?Q?Ba6QpF7gk7aSw+NVO9+gtC1aW5o9NvF7rfaoX+kKkCNYInfbuYMdUkrf6s?=
 =?iso-8859-1?Q?8Few+uZq6V5TmsZoDLmWZ30oiNKUMo9TpZ9+SWSkgORNUmlIoXT7mnX4AO?=
 =?iso-8859-1?Q?DYDZ27Ht5cyWUm11KnphSXbXM3OGcn5v9z3NmywBgSLLpAppl4Vm?=
X-Exchange-RoutingPolicyChecked: dlvMQ7H5mw+qoQHwhzc+3XinXMk+yrAdZ9xs1WyfTUpHg7wlJVui2Tm/0M93AKgEhLaqlYJfhlLQTx1Av9US2hRBzeUvJ7jZ3aruI1AtTsUBxHS1WhldQh45zrEbibWh+DcgqdA0tStYfZXzcpvZBL0aHCnrDNxVh9pVvIf9j5lmnHo2xx8xHvE3BlWNPwA8+iWg7QbLvdphpRcBp1XfZYGi4IlhjyksXw400+hBBmbGTsGVXW/EGH+jiyxIpRk75wz26FyBs/J6a1GX+2puQ+aGGApNVaCdhhItNcSi2jlPcx6/r5mg5DkBXHCqLN6RWtepFfl5FKxyEbro9m6V8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 24857ccf-607d-42cb-9dfd-08dead0db177
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3282.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 14:25:46.2104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67OzxoE9OKFA3s7TR3S83vJFhlyA4qazjzMERDoCy+kRjpNCo76VjN7U+bgOQjNYc0Ts6rBhaixu7ziTkrUBPvV6ogJ56sx/tSjY3GD/03I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8182
X-OriginatorOrg: intel.com

On 2026-05-08 at 00:00:21 +0100, David Woodhouse wrote:
>On Thu, 2026-05-07 at 15:53 +0200, Maciej Wieczor-Retman wrote:
>> 
>> My theory is that after 'int3' call the FRED event is handled elsewhere and %rdi
>> is not preserved. So the original version of the assembly looks okay but I was
>> thinking that int3 has side effects.
>
>Please could you try the version at
>https://git.infradead.org/?p=users/dwmw2/linux.git;a=commitdiff;h=fred
>or this incremental patch:
...
>

Just tested it and now it works fine :)
(aside from the ICEBP thing of course but that's on the kernel side)

-- 
Kind regards
Maciej Wieczór-Retman
