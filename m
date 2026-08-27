Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1304306775;
	Thu, 27 Aug 2026 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817134; cv=fail; b=nChWyoCeBuzvTs0yhzmDxG83dItGy0KyXbnKr8ZHANbbJ4VHavRGWnRBhBJyFCKraOWstKxf93gnz/9VUftOMjQ97B7qGEdXMUrm/5wlUu6duZnQnoc+3JUSV4mzX4qlK9ThYAdXDdXl4FGVSlhIT2M7MA4YpNQHwYzbAItFDLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817134; c=relaxed/simple;
	bh=e6NnC0URXiMsNm17Jbnz10yzoBjM7hwjaNGKJt5Sj2M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xq8jpARAMlgTi42Qzptb9+xlWzU0qRYH1h8J8n6GkrBTJgPKA5wRAXNJEN1ehwCfvexgUb19Br+SrWGkNiDVB34we2YPU26IBhNgV0qVrQIwUmaWVJuSae4RoLAAYh18olCBQ/DYGrb18iaezmuQnVcrpZHSv1f6p7kalG0KIa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJnCaCmH; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJnCaCmH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787817133; x=1819353133;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e6NnC0URXiMsNm17Jbnz10yzoBjM7hwjaNGKJt5Sj2M=;
  b=OJnCaCmHDAEXjdJtkr/JxsT89VzKKhdh9wwOmdQ2Ksk/HgYSEvUDYb5b
   7d6v8QCJjcLiTGqIfvHgCk4tvv+JbLCFwaoz97DwsS7yaUBUwKdEvGeQq
   CQ4RJze5HhNAJIlHS2DcZz87Q0LHDM9mpMogjgIPrmK962gpqknNQ6Q7a
   vP1bP2of/Iu39ArEnR5L42HXsyzdFCSkJf3xxw6nduoTFn63GrYlhWOSj
   OaK/hWzQx4j/3MhGOJIPISR3LAlyRB2vrtfApkRl6kkt6BouGTo/OR6/o
   etB4mlx9uB1gf4EbQGt77SEfQ/F6T+Z71xOpqxmHd4hiAf2UW/fOlKoPr
   g==;
X-CSE-ConnectionGUID: wpH65A/CTPuzuaYgvVfPHw==
X-CSE-MsgGUID: ds0/op/UQsa/gpM/vcYH6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88188943"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88188943"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 00:52:12 -0700
X-CSE-ConnectionGUID: PCGum2IVSCGL+fb9gv5ajg==
X-CSE-MsgGUID: uTY4iVJuTyu/O8XDd/BNjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="297679546"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 00:52:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 00:52:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 00:52:11 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 00:52:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t40G2kJPbqz69UNNxhKjYwfHJFsNcNy5nOoWc0mCA6HbR5sf33HR57t13I13U7pzSaiBs1Ey8Edy7rjBTEc1D2ujfkGFFVYzdDFC4p+vl3E2LkL03VihnxpqJR7pDhbETPwAKA2QSm5mYfNfOQl2c20me/rndrSSDjUnWLE5jrva9NQMZxXbq3qlshyo1Vek8Dt1XEG7RJZNBnUjHNVrF58UdTqNbVL+Ii0GxNfZC2d0gFSZcvcVejEujJjsYPrDbTeFTeA2JS5NpkNyO8eUfwU/tvtJbysf0JXRqXXfwHpp+3jOVv04foyR7Z4oKIaTuwkOzIkmQycxE6HUQ2GMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7PrA4qC7Gm1ZbJsyOTPdn7TBVQHLJZ4iR6F55HF0MI=;
 b=Kk8y4MPa37FaooDVQ8uAn80Wd3WS59PJQcEuQNY48bhO+C255G57On4iVfV6xDoRTB02JWNgGTyLpHdT+q9tRaEKHbJLP5yKc9YJVV0AxDMcTPFYrWwEhrlQYIZ/wo4xsVOoTQWIsF9ZEgfjPdfJrWHwfCg11WxaobOe9kkWYZrNOLb+1ZgxJ8NtUe9bGy36NIGPyumRn3P7/JNhhXjnKiHJZX8WI0Vq/DEhGf7CYSBziHkiiYbBHOJRponrrndFtUmEoOefs+XznUa87HpfDsSnsiDhI71bHu4hRD1HHXkqsIaKAHIQ0FjpxbXKIEzLHpr9GlDXAfySBfQ2xOpB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by MN6PR11MB8148.namprd11.prod.outlook.com
 (2603:10b6:208:472::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:52:01 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 07:52:01 +0000
Date: Thu, 27 Aug 2026 00:51:58 -0700
From: Peter Fang <peter.fang@intel.com>
To: Lisa Wang <wyihan@google.com>
CC: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng
	<ackerleytng@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, Ira Weiny
	<ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, "Kiryl
 Shutsemau" <kas@kernel.org>, <linux-kselftest@vger.kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, Ryan Afranji
	<afranji@google.com>, Sagi Shahar <sagis@google.com>, Sean Christopherson
	<seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li
	<xiaoyao.li@intel.com>, Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds
	<jmcrey@google.com>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v14 19/22] KVM: selftests: Finalize TD memory as part of
 kvm_arch_vm_finalize_vcpus
Message-ID: <20260827075105.GC33657@pedri>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-19-15ad654a50db@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722-tdx-selftests-v14-19-15ad654a50db@google.com>
X-ClientProxiedBy: SJ0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:a03:331::27) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|MN6PR11MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: e972fc4f-9aee-4c87-3ff6-08df04101407
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|6133799003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: mZGBJzPt37nmhvdXlD1AmEx2UqW7Q4NQVg5sLBd8Tbw3lIRU3IRElA2aGqou1NRJt20v90j8+X7XQtw1klJvPaja4I/Lw70Gu9vER556WdXhKHsDFlMbyaPUqQAhjW2dwtdE/cB7Viz+nTngErgOMl+szlwH1eL1HJhIMvWQjmknFQsF4AqGMKgn7yo/DqTi2We6fMvX2hhVXclwrTNpt90X1bHENnCo6kgHCTYjVrAnBl0UO4BAmwWZ3bY3iPr8bSCtHhSBZs0/LG0DALVmRGZE82ogoMa9J0AJEBpw8RJlednm4ubeHwkFlLLgr5p69Z7i0gPjSR2XDfKQmNdOYjI+A8NYVR0UL+N5MT3v9R5JwDwXH57Kgk/2488oc17QVpeB7reKzT27jwkQxQOntCugqklhbVdYATYQCmoPDzU+/gTWMWw6TRxq524zKsd+S17Ivcxr/CtTe3bj6jXkKLroPrko2nfNG1JRpDGexu+lHHYd8obnegJFqkxVJ1KFvTKITI2eQ/4tRY7sANr1G7eqyayLnd+fN/FHecBLimD6CF/bvgRzqJ1TXrkeTxQr1uwWdByhdskDHzB6OmZSnBP3iZYMpRiQETUXZHzT/REvT4b1wYE7nI1nYFZJ6QEkP+Tc9b9ylz4oxvrYY9nO9WvDhWtWW3qTwflsppA8sWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rNPUr6e4ZqiM+XDtCB37CxEOLj0uAxExrpKodFDtIgCtv9mJ6LeDdmeKt/Uh?=
 =?us-ascii?Q?7S4vBF1jbG1BHQUALBlJO/gCFlaMraV7eIpy01jB7gntx4lOfMGjhw1g7Bkk?=
 =?us-ascii?Q?MzV0vejOVGycxs3W6sSVVLlYzOOzqrQPCKiaZDLIjISqeCtA8+/yHLMFAxUl?=
 =?us-ascii?Q?BDLiv7DvlqMKLMP3uwSyFHKdf5y6aI5JxRrj6BqQDSakqWYRB38gyVl68FTs?=
 =?us-ascii?Q?n6NJ+gN+x6QvnlQnfS8oxZmED0g19rK0b99biVzcWXwO5FIJv4oqBR8IpOnG?=
 =?us-ascii?Q?9Amt6yZhn9daKFRLUqvbPgk83SATB0M30SoxzT262pIvwS3koJwc/JHImvrA?=
 =?us-ascii?Q?lbOp9jeUacsd9cv1NRCfo5uEJUQz4Mz1SZ5aJ+68z5mfVY4ZPABKTnxGfHc1?=
 =?us-ascii?Q?7Y5bypnxWrLD2PMinEllo5tyPRyj2P19N7eH2XtmeSSgR8kb4cIhk+b1fVUh?=
 =?us-ascii?Q?MzXwtMXoEaGbZtS+bktDnTGLD8bqy3j6Tu770CF8lJGSMdqZ9t7VkKJ7wQhP?=
 =?us-ascii?Q?e3kJwV8i1jA+ZT5LqcV2mmHLBak+x3u3RPnis3xrCIwCY9DXT4a2lmqQ5D2z?=
 =?us-ascii?Q?ESS91if316E61OhxV5nVUbbru0FHFXvfx6mrVfN13uIKgbS0Dyv8Z830bqzR?=
 =?us-ascii?Q?B4vRWa3zrKJaCfkSqgi42H+WUhs1UaYiP+pMtQdpdB2eZGuWQp2DhgmXlR97?=
 =?us-ascii?Q?OEgNFNSb+EvTC+cbdOLUzR9HIPsOaQiEblVovxxkkv96n9e7pwvw8Wv61Qvb?=
 =?us-ascii?Q?pEMno8wtYUHV97CXEqkSWLA+MedJhEDIWCg/WNZrNkLxn0uNu9YZmIo/fqPM?=
 =?us-ascii?Q?HhRr+vTyACPUwnokK4tvJmfG3qiFtGEMP3FA2kt14KRlqMBddJBqavvAc/yZ?=
 =?us-ascii?Q?kbImWb+EChMin9Cm3GysIpRyjH6JevBzKl6yYlfrTvyxjaJ2aqtSKmY1kx9l?=
 =?us-ascii?Q?uDRsTiBwqbaYS5efV/mv0jV9SayL+g11VFasBDGjgBqxJu7zjvrRrZD7wqm2?=
 =?us-ascii?Q?ofcu+GVyT7QdEPOr7HSA4P8wdEem8/G72voVAULpotL5MDPI9bY48ncPnXJB?=
 =?us-ascii?Q?RuLo8g/m8FwdkaOVA8l8AhzZ/KAJG8hL5SolsC4uUuQHehUTl9cZSkIXP6fM?=
 =?us-ascii?Q?yjXox5AqDwTEuFdSOE5ZBtEsEjdNVDLjIMKe/3oKoJ7lQe90Zn6NOfgVkHTD?=
 =?us-ascii?Q?ysRx5XpRYOUfhc1oPpwV+5RQDul0tZHrt6B4nB6ly8fBUzTGwnRV7W9xfp8b?=
 =?us-ascii?Q?sgCISqhrSlzDvk7OYiqlaA8axpPpw3p/ncSoyF67qYGvaTNNspYOlmMH1LzK?=
 =?us-ascii?Q?Ty97YEV6iJmlbH51SnFGWO4iAiQpxo113iqI24ouHgcjhpRaItwzRiw9KCjW?=
 =?us-ascii?Q?sCv49Y9FGBgfonAZC3HAWVXZf0Oe9+XCHDBcs2/SHHzOajx6Fgn8jhDJ5TpE?=
 =?us-ascii?Q?K9HQdXGN9u9WXVmEE1rQdXZUZiV+gcsxLmmE3PI0jbfffxgmG0p/67nWlH7Q?=
 =?us-ascii?Q?ON7+MWNSTlrdpoBhlTbrxkAj647Qmx7k0MWnrOdM8rgg7WzU5D8nLAOY9pWO?=
 =?us-ascii?Q?Ldtw8Ea8aZM5wJT0tSD6H65CLlzL0ZTA1wGIB0ZyjC0AJKCWTjgpUHH7JWHO?=
 =?us-ascii?Q?gd3NUAaZfBkvGaWFJsQfvPaLln1EsbUjp5tbTqxvkjQhwmkAuZboIMAOphZF?=
 =?us-ascii?Q?CeWbA04sJAlAN8ODrIe0nBx+9ds8CL/kzxJz82uAAtCPWT6+90Inikpdq8qe?=
 =?us-ascii?Q?QM8NptGacw=3D=3D?=
X-Exchange-RoutingPolicyChecked: RT9+T9VO9dmKHi5BAgZDger3UxOKX/K0dyx48ZWuWpQTE9CmbMm9AlYMPC3hrZqZymcXQOv2cjCSkj3FAQ+MIDvGwLVmHLjl3iwKQZG6d1f5X7Ckf652+Nmr6mRGkAgnlw54Zj2lVEFPu+c6+Pt7ft+YfGNjXeNrw/xQtS+fDI3pCrtYePeQh7Y5RmOIHUBNc20WRM2gHXsWdBJ4+DEDm+F2o8l/h/AdUf9HNOI5rjbMA+k2H2ADso1O3/CFuRf4+mIgvZz6xuQZpFOmVQOr6YNummGx9bntumtVBdAs1gqopJw7rNdd3tdlRhqujRDOJziHgq66jlxKKzL5KS9o4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: e972fc4f-9aee-4c87-3ff6-08df04101407
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:52:01.2839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LirK3a/9eO32bkIYUtGetyEB6OXmtlAtCnUAtLdakT66zKTis+CBpSCRYli4u41PAIR7m+Q1xLh/0CgfTLSq8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8148
X-OriginatorOrg: intel.com

Nit: use "kvm_arch_vm_finalize_vcpus()" in the subject line

On Wed, Jul 22, 2026 at 11:13:24PM +0000, Lisa Wang wrote:
> From: Sagi Shahar <sagis@google.com>
> 
> Finalize TDX VM after creation to make it runnable.
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>  tools/testing/selftests/kvm/lib/x86/processor.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
