Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE0C368D76;
	Wed, 13 May 2026 01:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778636017; cv=fail; b=DdsX5/e0oRfeJszWskuoYXjDzLK2dOZXMxZUSloxyA7sweNS7xlHz5sywF/UyvlsBrZAhn8VFapIdhOEjt8jFSlxvZg1OUfnfWVEQJu6z6M4yYvQDEsMsCo9YwUg6FkLSUV81QYvrKZtaSE1Z6c4K2ixggJ4FQyGhE2HEuS9Sik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778636017; c=relaxed/simple;
	bh=XAiKimretpNaOEiH+DsCdpONIBONc0mF/RFJaHTYRC0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GewdQ693qmxEJlG9w9/oHUyQHqrMnfFPzLa74QatW+zD77okQ51aZZoPRreFMtaJuR9749S2vZPaf0o7b+zJ/D4TOl8dFv0Y3jvGukev8e6W9yhyRJ4MntY+HiTs5UMA3sTil82JKV1OOZmHaZHdPffBl9vjDxZkBqlOYkmeI3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVTvKqNf; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVTvKqNf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778636013; x=1810172013;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=XAiKimretpNaOEiH+DsCdpONIBONc0mF/RFJaHTYRC0=;
  b=TVTvKqNfiQ30aZP4o5qI1SriXuzQeBx2tmNDnpBRV40uJ7wo1dmOG5XI
   aLjuclrzDbFy5FqiaSXPYoArq0Ftj1MtU3CwDO5s2tgx1FcPhrxcfp+2z
   VafOpwbR0UOpz9wPoWq2U0RN2mn+pJhnA7lObOHH8cZab36+PeHV2qzqj
   u85HKv/U21T3LjdRg4N4YfJHgK+51gvfpN7iXHqEH3CCQgEIRc8AhDzhy
   wvpb0eNhxnrsTBhxdr3N2nwIvsXyw3ARVVpyY796+wnQcsV0ufTy77OKu
   8yjQ1p/M/kBbjjEHCIpf6Loo+WfmFuPPX9b7MXNBSYfqmNGOSosJTg8WX
   g==;
X-CSE-ConnectionGUID: DMMzM/8vQkiRlT0vBdWoqA==
X-CSE-MsgGUID: iqAoTuJBTV+UublNKR5VoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="91018672"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="91018672"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 18:33:29 -0700
X-CSE-ConnectionGUID: R1IzWxONQzWFcxx5YqIsgg==
X-CSE-MsgGUID: VqkE0DMKQBSQFP5yLa7poA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="238032765"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 18:33:29 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 18:32:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 18:32:14 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 18:32:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ig6bKk11pnKiGknvUXLwbU5iwNnIqAq9wAgjOYJWazd5HEoS2AhjeAiHNlf9H9MLMABvCZIKK2CU2shTfgKf+G+haozvyAWEyr+RtBo2m60b2VGigvp5F395EKnZwkXYN3MWMV8oKd/TczW2UOh87T4v2HWiZxJ5rOb6GAz9LDVa0Rd+fxgGq/H/5+ry7JItRiw5remzzuM1P1gBRpLcclnS8tJeZhbVAD2TFgisJf7JSNa1RXzp90Qp5fPruKIrIVqNnIo1AC19GG16HhDNu5BTl6EKf/8U+aHUA7xoLPV07yD2Lxqp5MKDZOULArvAwyIlrtPSflm6vMpACqBFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4axHMHHzxY74dxOpuPxjAb45ddBzmvG3hC8L1Eat20=;
 b=P1BexD3geGayGLAjI+scTVh0jelYwUUYTcs1ABaDQRZPMvWJQxDHZhsD6SsKhUBBpmAI+xcLDSy4PoUYNINCjrfb8/vltCHYZaFjlqoOqvDXjXoqP3y8ZZaU9TUtyda+FhRMFVdrjG7Vxx/bWPqFiPO7tbyl1Xw1YOkfLTNMInzYjRVlNXhbGGAAYeHP54YySgUlQA+Y4cbKqH2Sw4fPaSlrik0LxBWRHIUGig5VpmC1C+A3NKdYSgyuUSW1aDrMN/fvs0/AEhOtz/7UThGewjh/2/knIwRswD6MAB1H6+EJm7UTnTT6kLwgufU2kAlQkgVoqSUtD+Bcud80jnZNag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SJ1PR11MB6154.namprd11.prod.outlook.com (2603:10b6:a03:45f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 01:31:54 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 01:31:53 +0000
Date: Wed, 13 May 2026 09:31:43 +0800
From: Chao Gao <chao.gao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Reinette Chatre <reinette.chatre@intel.com>, <isaku.yamahata@intel.com>,
	<pbonzini@redhat.com>, <erdemaktas@google.com>, <vkuznets@redhat.com>,
	<vannapurve@google.com>, <jmattson@google.com>, <mlevitsk@redhat.com>,
	<xiaoyao.li@intel.com>, <rick.p.edgecombe@intel.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chenyi.qiang@intel.com>
Subject: Re: VMX Preemption Timer appears to be buggy on SKX, CLX, and ICX
Message-ID: <agPUfzbMzTU1ebii@intel.com>
References: <cover.1718214999.git.reinette.chatre@intel.com>
 <2fccf35715b5ba8aec5e5708d86ad7015b8d74e6.1718214999.git.reinette.chatre@intel.com>
 <Zn9X0yFxZi_Mrlnt@google.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zn9X0yFxZi_Mrlnt@google.com>
X-ClientProxiedBy: TPYP295CA0006.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::16) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SJ1PR11MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 698e9f47-ddc6-4417-d057-08deb08f69d5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: o/bbhncMw2aWfcPWhU+PRwhA9UwQls6ZNPI3l26OT98ygDwrUxnRUlWuxi2MeddBrKICFiNJSL6pl7QUzjRB2/RpsG93//9tWzJjnHZ/i77YjF7BwAUtwIvkLg55M6PaWtN/eu7zyKRyJFollC8tYolWVi2XU06j+q5WNsH9FB9XKZ+4UPQOeAXAFAoRh7OD9vhCijC5s8sgSMjWYTbyO2m9v+yXFudlhtbNef0TA0iNZXiYw2kuQkS1UNK09UJxxNvPVjyY+plA0rdb6HYmvW8COYj7XH20RCV6qfxvl14U/1n8Q0l1ZDY6hWhDDCtdG7kVnhV/269VVCrzsPI64qE83bgiBaPdquaMOuIc+mMM+2IWR/uF8IkQlmymVOKaplvSA94KEyqbV35B1IQy5l+EU71dnZrPttsE35CRsFiL/O01Aahie/pQkyLi2gxTuKMyEdwdDrOugracF8sXhDlwiN8XlXMA/NqpZrtxYz/q16c/CWny8BqsVHI0NsJn9uqvZAfjOuq0XcZjDY0ry3QKprj+bktlfjG8RRSInshFzOp6efmedz+fL8U9HzjokOz+MC9uHnz3MlMwmZlXyRQ42DDUSqDSIkldv02EOXw2KlHBqmY1XgYUNTD1mSTxzYz6rqZyBpDeB7YoAA3Rz6dRaiNEn7yBQ3h4i2OyWIW4nCqp+9OvCD5gm3ReBg/2LncCtcpg3ZWn3MlIBr1dTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yM6MitBj1k3i/Ic8OiOAgekX8nePaYwELkWmr2YnEjxFbgx49HwZcRk98J?=
 =?iso-8859-1?Q?2O180OxH/7HDSQjX1lRXTsPIeElMFRwkzTCjuV+XiyyydDLPiDmmsb82Bt?=
 =?iso-8859-1?Q?602265+Y9JRG/ocPjPsZCQ+j6yidrhZO07ko8qVuL6nNVVhiDhqWdRIwx0?=
 =?iso-8859-1?Q?qfh0+8VCJ/xcSCEcXdUklGdk3x3CyPfHvUlZNsZnKIokzE4FOFxf4XYHbZ?=
 =?iso-8859-1?Q?chtHuJlqA5SLEjrwRDqB2dHUqL0np31VcOe1XzFj1Zm/UnedD5Kv9f/WpG?=
 =?iso-8859-1?Q?PtWXA/d5ZSOr0Q4LB/lDOGobMIlG6BVEBPQQfnJacBlqG6j0izNKRdzOUB?=
 =?iso-8859-1?Q?RiECTsECWIH2HqpiDz4oMBaoqFCjjcg4QVDWTdrSPZoMxpe4EXO0o0eN9E?=
 =?iso-8859-1?Q?TqyXj3S05HYIt+MqXOIuSpC9zPJJzW/GB66cBET2+suzPIW0hRKcM+T5Cb?=
 =?iso-8859-1?Q?c8NJiKYoU3QA/Q9bDw4e8FeDkzE6DbIcAE5Y85rTMoi07d3WDfID/y3Tfc?=
 =?iso-8859-1?Q?2HqZ/siD6w2d1mzyLnpmYnWs/5D/qeo5sB3COiqzTpQjLZIf7NOoxjJfVD?=
 =?iso-8859-1?Q?yhUYWi9fIetRmBpMFaY6YVYuUx1dlAcjCmMEfRqbQbiV8g0FjZpB8k5EvM?=
 =?iso-8859-1?Q?ofoSiaD8GHzymR/ZGj7qNrbxGpZ6ujjhtSGVb8gpSTog+1jyX/0zUxhEQA?=
 =?iso-8859-1?Q?DyjzUcI/cT+Aga2Sn9loxiNsGKyxIXwPvgHtVqWs6iYtHcUHkTC3LWhcJf?=
 =?iso-8859-1?Q?V4tMrBgJP+DUipZvqw5fFA+U6F1iMy5G1EkYRFmwo7qv6skk4XiC69tmCE?=
 =?iso-8859-1?Q?2bPWuOgGr9HDUAHJm232ItLjLrSqCrLjXjrqN9dc+YrXNVEsE1f2JZ9b6Z?=
 =?iso-8859-1?Q?XRF0XmwNgqaDROFDS7+SlkAJveLrm179RhC+5vQ2ySPUBKvjiblxqJXMFJ?=
 =?iso-8859-1?Q?M5jbkqaW9iKzJ3L3Xue08topmKS1288Gi2bVRnrOnx1fiXBFHNTo3v7omo?=
 =?iso-8859-1?Q?SG9oTPHm5+/kH0rU9aNtsv+AekajGxxfPHRoPO1v1AswBWp31bY3OFR4M1?=
 =?iso-8859-1?Q?pMUl60/dzUN9HqS7FWD2nX/XJ3NPljrl6x/9LYziMGIusCpHOB+vyDgJ33?=
 =?iso-8859-1?Q?qFRGSrTSmT2CE/4dbxBdd63B62ZOnApHsIi7Hpa2mdQGQ2F5jG/itMa1P3?=
 =?iso-8859-1?Q?UwIuz4H/EfyZluRXHuRRK4LoCInx4DO4qGja3WRE+RWBG1p0tXS8M+pKEJ?=
 =?iso-8859-1?Q?aTDOAvfv+emuNkdCaLt8mLdeZpPY4cq9WOQDvTd1Q8JZZhF6w0aKatwkF3?=
 =?iso-8859-1?Q?2nYTeKlW27Bq9iX87FKSX47J3Dbkynz7IJVMhQRJlof8nuzBoqEGUinShw?=
 =?iso-8859-1?Q?ndzf7xJisYn/INpzpyaGqzFPj1VTUKU11x4xU0SRFHMECw56gx1lejTqUk?=
 =?iso-8859-1?Q?3ZyZ3hshQ3SiDHFQTgqFJPyJdVx/wvXNVSXcHC6JcHw/DqndH98ATplQmH?=
 =?iso-8859-1?Q?sCkT6r2g99tf9BVI/fvpWN0w2guuaIpz9hVWJRh80oy3OvwSIgqQHQa5nV?=
 =?iso-8859-1?Q?mb3Z2dD/Qw2mn/qWcXbPeSBRf0yZh55HpKCbbQHBtT/LBQF4cMIiCjGXtZ?=
 =?iso-8859-1?Q?QEl4/FLKRPO1NAJFTDjE41kD63dLOvN9N3kL6Sm0ULTrsLy7DJZM0CtygP?=
 =?iso-8859-1?Q?gMbHtNfJdUneI0P+97RuU4HKG0Q7/qN2w01rsO8uDaTpM5dXX41Ik6IYj8?=
 =?iso-8859-1?Q?Cv0kWXQhBmDD0k4Uebg6P9rSQtDe4kpLvuO7IcVf6AEOAbBEanDHRUk8Bn?=
 =?iso-8859-1?Q?UkSg5mvPgg=3D=3D?=
X-Exchange-RoutingPolicyChecked: oKydf1SKJq1Wa0JzPNAEzO/Nt/CVFTLSiprwJfv7VsEwFDKttvqIZM1G8NIOEOldUh6qmih7kqTORgLfUfdqG4+qOpweU/SaKzCZ65MkQX+y7qUM+xeR/DaJsKO7tT4Dooc/OojIWL/sehKrScKhvw18nM3VKfYYbMLhf57xSgK/cktfrjlt1BLI4uTR/7qi8KuNP72c6cpBHShbiaOgQ1x//u/YCJA7/5evd6wc52j7oniToyIKp3xCAW5EsfIQvlIs8LAcdJ7YMlS4P4smjMd2P6/SuDf0YFU7oUvUxBEFMGu3u/TgleYH14wgw8mpTzlPHowN79qq7PaI667qeA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 698e9f47-ddc6-4417-d057-08deb08f69d5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 01:31:53.7290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HEgQFEHbfwD8p9p1Q1t3tbuCoedtc1DvN5DSL2gRln2St74ZiQuVYXTggwAl0WiAbGp43136KVNYE2gR+YyNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6154
X-OriginatorOrg: intel.com

On Fri, Jun 28, 2024 at 05:39:47PM -0700, Sean Christopherson wrote:
>This test fails on our SKX, CLX, and ICX systems due to what appears to be a CPU
>bug.  It looks like something APICv related is clobbering internal VMX timer state?
>Or maybe there's a tearing or truncation issue?
>
>As mentioned ad nauseum at this point, I'm offline all of next week, so hopefully
>there's enough info here to get a root cause...
>
>
>A spurious VM-Exit will occur after programming a vmcs.PREEMPTION_TIMER_VALUE that
>shouldn't exit.  Every observed failure occurs when bits 27:16 are zero, with a
>small value in bits 15:0, e.g. VM-Enter with a timer value of 0xe0003bf7 or
>0xa0006db6 will cause a near-immediate VM-Exit.

This behavior is documented as a CPU erratum. See
https://cdrdv2.intel.com/v1/dl/getContent/793902

EMR158. VMX-Preemption Timer May Expire Earlier With Certain Large Timer Values

Problem: When the VMX-preemption timer is programmed with certain large values,
the timer may expire earlier than expected. Actual values vary by platform and Time
Stamp Counter (TSC) frequency.

Implication: Due to this erratum, software that relies on long duration VMXpreemption
timers may observe VM exits significantly earlier than the programmed
interval. Intel has not observed this erratum with any commercially available software.

Workaround: A mitigation for this erratum is for software to program the VMXpreemption
timer for values below 2^25 × CPUID.15H:EBX[31:0] / CPUID.15H:EAX[31:0].
