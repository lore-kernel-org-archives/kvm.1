Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76057261C;
	Fri,  8 May 2026 03:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778211250; cv=fail; b=c6+7cJO9itmFetp/f64SaUHyxDbDeQE6+4fA49PBrSKWQxN8cDY4ndniwXZACr50wB/17owy/DPxBLiaYsRXGCH84FR2lGJif5GcvvfwUpTCh/LIdT9yYN+t3ZjF/UjeOfeeEnGMC9jWRghn/+QLSpD7RnHvkGIW/nIvTlPpiho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778211250; c=relaxed/simple;
	bh=2bry0o8brADDlkPeF+CvfmDWaZ7ouWUXS9MGpTekRNM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bg+4+SM9Y+aB3OKnZ8hybZ/ZTbyaRrZoXNhCuqhej1AIKU+eYVbnsedRSx2KZsS7QnCqEMzWmZtBWOD+Mu1LnMzwNf9DbwBLzAyxjgU4yQPjFzeAkgzm4loc7p1kCphXDnGr3mf7RaPWfgXlQp7c5qe8kccxHBvxSuphqRvfnJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRey6p4i; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRey6p4i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778211248; x=1809747248;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=2bry0o8brADDlkPeF+CvfmDWaZ7ouWUXS9MGpTekRNM=;
  b=nRey6p4idrJacsmat7DLyHdsqt6fk8RQZD+Ui08DOJZRXLbGGRf573Qy
   u24Av1ZOFD05GHqDyPo2ovcBdwqPx6uvwPNbnbCr1/qbEY/Ws0WcimzpK
   cJZNVBuzGuJNqVNw6kTBncO1rgulkWGLzGS/wA3qg99mzyCcCSYYTGax0
   6VbXT/BNJ3oDkZv8A4GKz3sgOenfqc4LkkLHRcdNA8vq8pyVQf7oAK7Av
   e65eEMjfwQdpS0DGVFvH92G9pI+1FCjQ7ILBE4Oxw7K3odJTTEowfS9ZM
   VVzPKS6oCwW732hlml+HEbTerII4X5XGiMfLThsNsGEK6XSfK9JEDy/P5
   w==;
X-CSE-ConnectionGUID: fuTNq+r+SrSZGpB2Ppr1UQ==
X-CSE-MsgGUID: tgyA2FnjT0OE4zld9AP6Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90278322"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="90278322"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 20:34:07 -0700
X-CSE-ConnectionGUID: ymDRynHGToCQkEKgInWpiw==
X-CSE-MsgGUID: zrm2kVmZSzWHUACbYDw3nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="236764525"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 20:34:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 20:34:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 20:34:06 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 20:34:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVWcA43IgUaNwyycqiEVKCKwwCgGhpZm1S8uwuNAmOEnTpW9JfxP/9Ew8VZagYNTeVZOuemaRbCn/NP5hiz6vbybWZ7qeg0VWWTgdQHJ3rJ9VxpIIz/ul7H+N6t2khVO0/JgNp5x3vjBk9smivIxKKRkK2RAYTLRHQCmlK+BtmT+ZY6D4mPELWCcKYgdXTi2d3ld6oj+h83Zl6Rb8T0ahADwt4Tn6g7f09j6QPXmvRSZXHRN2ZU9H9VABhu09mJmXbBkbczSi3zg/m4yBtXONSClksLSoRbRk3y0wpojywJPTgMSP1l9Bo/HIin1SpoI+LaRsy0LniiOQtJXTZpgXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahkmhU1Bx9hVX5sT7BqzK2XdmfiBTpRuRq+4QxS/Fb4=;
 b=Ala9uRxiL34nUPKg24VX+gav5mq8urM5NW/CL0/xoK9OHPVepm0WRwDjioUiYyL2MFLsXx3+GSKcyNQCmALmHsHGhIlNFtWHHxLZkcPZS66EthETvpfM8EdF33+jtOuvxYGl+S1ct9DIqsn/NOd7TSvPZV9a1jxwi1R52VhyLVtqPMu7kzXHCdfmvzEOC1lJ4uqpCL4XVvRKMpzkIgEWQKAt8ago/E9NYdcI+N1bC0dxbKTjFCBn+ZosiOzTv4Aj36QbfBoVmc6Pw5G3aYjGWXLvrKJyG+w+wMbO7WD8QLtKtUBHyqYc9Tgg4k+Zb2DzipRhe/b9ciGIaq3KacVQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by SA1PR11MB8859.namprd11.prod.outlook.com (2603:10b6:806:469::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 03:33:57 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 03:33:56 +0000
Date: Fri, 8 May 2026 10:54:00 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <tglx@kernel.org>, <linux-kernel@vger.kernel.org>, Sean Christopherson
	<seanjc@google.com>, Jim Mattson <jmattson@google.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Vishal L Verma <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Rick P Edgecombe
	<rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <bonzini@redhat.com>
Subject: Re: [PATCH v2 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into
 x86 core
Message-ID: <af1QSIqNLlADZa0+@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260423155611.216805954@infradead.org>
 <20260423155936.843498069@infradead.org>
 <20260501203717.GH1026330@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260501203717.GH1026330@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: TP0P295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::10) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|SA1PR11MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: b412c18b-75f4-4422-6a88-08deacb2a22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 81LJNOj8SyQ35Lly7VNmADoTtORxJMEzR2IhyTkQbqfYX/QkWrbSLwdQxfZbY7EeuOmrsgMQpl5Wr7lShV5FynKPVunliIlLARALhzibLGz2o7yFKNU80AlWzFSNOke/wVifoyUWm+eXIKCzBRoDneyCO9zrBi15rHSL6s87/+cvc3cPtSaAfx+R03TUN3yvWRnjF9k1EqmnjL5JiGUt3MYj0J/lKwdm+ntKxZHjNWYocEt7VM5lad8Zn1VaHdUpyFTkNoVXEHG/gDRYUQsg2sC/IcplPryjOzMsrS3znemQ+Uc4uXtusoqSgGZ+4HN/WbmZ3UvYCKterzrnAysythZw+YTxObC0r5sz6ZjT1jFNI38EQuoI3IWltPrgQRVptjPHgxhkaov5DK/raiwqYW+Pr55lgXs1aeXgTLL5LB1QsLBSA8uhFUrW4XG0Fq67V/2WJA04qDiBRI1NOeQ4wIU71y1wZcL5oJaBuXfM2fVXKqtpPx+Md1sqJ4tyd+QyoB7JVO8xj9+lzOGd54NFfj+Hyk7xryX2zLC1z7/tUcDucDo0zkGjGof/ulC7p7tFtFiBlwAF+RVZQYs3n2Y+VH/UY6SV+Vj0U/7yL52BU1wSmAQyd+TVOnpdCPAJ4pUpFZ0m3kOTUlmcP1Qb7v95TXqBzp8JtMTAjbfrhjF7QSU9QZGmXpCfxsCX2RIPT9If
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6yOBo02F8fOWU21bn0loNisFZXmFYOpT3TYbnVdbzuSZGNRsi7+YghAJeJfC?=
 =?us-ascii?Q?FklnZfI1vqpUf2B7Vqjalzjs9rHSlOB3xdI7e4vcJCPgWv34tdfw07uQynl6?=
 =?us-ascii?Q?0GqBw9E8l2JshG17Xpcg9mRWTpELs6CHOaxTJA8ylYNmcPUicIgCjqRwJ86c?=
 =?us-ascii?Q?lfw1xwH5QM/OdM3H98t8+zT5akjcjF1FA+YvHkRcpvngulD7eHU0r5C99zV1?=
 =?us-ascii?Q?h60SiOosool2Uiq7Ku1vSLiU4OYLHN1+fbHQN0IeRaR7pKHeBifNoScKmQ1J?=
 =?us-ascii?Q?++j9dJ7ia6ot+kQdWS5AVj5RCFpP38Wpp8j/+4PZ0itxU4kbtHdKph8Yb7sI?=
 =?us-ascii?Q?pxIKBC0niN6tGcXA2lipPrIkQXuWzGBPe32MeptEPbKt+Mrbq1AxlucOCw/f?=
 =?us-ascii?Q?7Jtho8Jte70Z5ESRC7LHcatYfTZChTMI4EZ6xorJfw9K1AxpJaPM4Zyx0C2P?=
 =?us-ascii?Q?S++IQvDNDQvzfsl1MJFxWgC4FyvHHn9pkUNVSmbgVLP6Dw61RvmzHfOAcMEc?=
 =?us-ascii?Q?d/1d6utj/2LJ7mFYOnugYsRLi0qqM1EAVI9t8N1NJ1ZNmGkHyeZtmilNplcn?=
 =?us-ascii?Q?J15Jooc9SzPl3tSBkfDD/cXwHI/14H8TbbcUuy6HDmJ/T41jmwNlo9tNrwRS?=
 =?us-ascii?Q?3px3ipO27uYj/yumIRTHsnPY8Uw0wh9Bz6AVglKG7t3Js32dyePX82vyE9ce?=
 =?us-ascii?Q?SYwR29UcsW95pSvwWvdpVO0fKvwDd6Y5qZquWXQ1gqD1UgkJU2Irg7V29TTq?=
 =?us-ascii?Q?+KXKVsx+lu7yQsIqA0S4chKPa8KTv1upRVV8/tQ7nPyZswQluYtONAao2p49?=
 =?us-ascii?Q?pnJyP1Mlk6VDWumINRKnnkgXNtjQTCPz1J9JGdp1blyyOPaLxwEHVe98vMWA?=
 =?us-ascii?Q?Lnx6n2rcfTmjV61X2/dUrzzdErV5OdxSeITnMOgr3Huv6LexcDYdD20PPZL8?=
 =?us-ascii?Q?F8C0b0DDWiBheUGFCsOZ3wxRq6P1xxzIDVLkPM0sMEO5rbrZiHEdo9Pas0CF?=
 =?us-ascii?Q?3tCA94crPdYMl83oxYY0yN2BzdCrcUjFzkD0WYvfG9Jb4jqIScH1icTR9Y5b?=
 =?us-ascii?Q?DpLPEGS61Er0eBlgMad9HWxOu4zAPVzPL6j7Ad9Ntj5M8IwGIB9/ElPiJPnF?=
 =?us-ascii?Q?7ciR3ySYZMnWrxbBM6HqPjv7/kXnhNgd/8fJ0Zms42/n+J5hxZuI9t9izuQ+?=
 =?us-ascii?Q?+0cUirNNLys1sUklHjVCmqHLBA6xOw7YfBPYaMxquCpcAAQTFqb4Fbib/XBY?=
 =?us-ascii?Q?veqZzselhA2NdGNz5owbIECZd+ofmyvoaYbYUKNoBeOB2lLIAj+Gfx9QWcuv?=
 =?us-ascii?Q?gO9Q5Czaqq5Z65h3aOWnTieVhvcC51yK/afnh9cKspsgiiMEM+JulO/385hM?=
 =?us-ascii?Q?ht/ri398+f7vUL7PfoKqsbPXRbJTmLiShh/TNdp1sW+uG0q7PCovl7ArUhiV?=
 =?us-ascii?Q?frnNu2oYEYH4VCLRYjeKiY3OD7R+/gfohHo5b6eLv/1b8jHTwZT//Ctrju64?=
 =?us-ascii?Q?umz94XHB0k681opE7ShL3Yt/Jyf07Os2FhhHqApWU1+E6fsPunUeB3vV3xy8?=
 =?us-ascii?Q?saULHCjFidnSs088hc0WeVzlRjQUfy7rAKcufgO1bK3ViZNvNbU5DGaJ0GQd?=
 =?us-ascii?Q?43kzvajt+R2H0zAjFZKD3p4ncCCCxfhi2xMqml6efUob5n3ptKFx5+n1xSRf?=
 =?us-ascii?Q?xYSV6YG9ij2qMLLnrE2p7DX2yQ3JxoerahJSPr7kQcP7UQ2xlj9Dxd+VOzpd?=
 =?us-ascii?Q?QBpKPjxB7A=3D=3D?=
X-Exchange-RoutingPolicyChecked: I0Yn0LTZ+HkZiqfSDnJN0Jei+V4dvXIpDc7NQSLzXlakZFZmh1+QrPQnswoSW9aKqcN/s052CDq7eQmjKOrSLEkowWt5vdCX/vP5i2411Vwvs4fCLHSQoY39lVlFLcAoyNcPitxa0p4DAxqir9tHAPHN/Subaahn02tt9NAAHwIuJKtUFhDRN6y6a1xW1oRhpYwJTzQNhQlfs5DxAvFU0mHyIwijjb7kcYtfQcYrs4CTNmNoGreWP3DETEF/rQ7Ry6rqgtOc1egViIV1BvqxgwjfAf4livjonV8ilwrs5g1zIz/8pootAG9tqL/37tu74DragZ4urj0KFbKuM/DDuA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b412c18b-75f4-4422-6a88-08deacb2a22f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 03:33:56.0088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4v/zy8rWDXqkzDUhH3JXUJGM7UKth7MyLXDRR/hsMRi2NfIWYBwQEyvmO/nqH3GKpTubM1owxI77UDxyUNwsLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8859
X-OriginatorOrg: intel.com

On Fri, May 01, 2026 at 10:37:17PM +0200, Peter Zijlstra wrote:
> --- /dev/null
> +++ b/arch/x86/entry/common.c
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/entry-common.h>
> +#include <linux/kvm_types.h>
> +#include <asm/fred.h>
> +#include <asm/desc.h>
> +
> +#if IS_ENABLED(CONFIG_KVM_INTEL)
> +/*
> + * On VMX, NMIs and IRQs (as configured by KVM) are acknowledged by hardware as
> + * part of the VM-Exit, i.e. the event itself is consumed as part the VM-Exit.
> + * x86_entry_from_kvm() is invoked by KVM to effectively forward NMIs and IRQs
> + * to the kernel for servicing.  On SVM, a.k.a. AMD, the NMI/IRQ VM-Exit is
> + * purely a signal that an NMI/IRQ is pending, i.e. the event that triggered
> + * the VM-Exit is held pending until it's unblocked in the host.
> + */
> +noinstr void x86_entry_from_kvm(unsigned int event_type, unsigned int vector)
> +{
> +	if (event_type == EVENT_TYPE_EXTINT) {
> +#ifdef CONFIG_X86_64
> +		/*
> +		 * Use FRED dispatch, even when running IDT. The dispatch
> +		 * tables are kept in sync between FRED and IDT, and the FRED
> +		 * dispatch works well with CFI.
> +		 */
> +		fred_entry_from_kvm(event_type, vector);
> +#else
> +		idt_entry_from_kvm(vector);
FYI:
I can met below error with "make ARCH=i386 allnoconfig" or
"make ARCH=x86_64 allnoconfig".

ld: vmlinux.o: in function `idt_entry_from_kvm':
(.noinstr.text+0x1618): undefined reference to `idt_do_interrupt_irqoff'
ld: (.noinstr.text+0x161f): undefined reference to `idt_do_nmi_irqoff'
make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
make[1]: *** [/home/yan/kernel/tdx-upstream/tdx-kvm-upstream/Makefile:1335: vmlinux] Error 2
make: *** [Makefile:248: __sub-make] Error 2

So, I added below fix:

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 0e8fb61f63ff..7bcf1decc034 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -268,6 +268,7 @@ void __init idt_setup_early_pf(void)
 }
 #endif

+#if IS_ENABLED(CONFIG_KVM_INTEL)
 noinstr void idt_entry_from_kvm(unsigned int vector)
 {
        if (vector == NMI_VECTOR)
@@ -280,6 +281,7 @@ noinstr void idt_entry_from_kvm(unsigned int vector)
        idt_do_interrupt_irqoff(gate_offset(idt_table + vector));
        instrumentation_end();
 }
+#endif

 static void __init idt_map_in_cea(void)
 {


> +#endif
> +		return;
> +	}
> +
> +	WARN_ON_ONCE(event_type != EVENT_TYPE_NMI);
> +
> +#ifdef CONFIG_X86_64
> +	if (cpu_feature_enabled(X86_FEATURE_FRED))
> +		return fred_entry_from_kvm(event_type, vector);
> +#endif
> +
> +	/*
> +	 * Notably, we must use IDT dispatch for NMI when running in IDT mode.
> +	 * The FRED NMI context is significantly different and will not work
> +	 * right (speficially FRED fixed the NMI recursion issue).
> +	 */
> +	idt_entry_from_kvm(vector);
> +}
> +EXPORT_SYMBOL_FOR_KVM(x86_entry_from_kvm);
> +#endif
