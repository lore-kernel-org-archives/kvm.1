Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BFB39891E;
	Thu,  7 May 2026 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778143714; cv=fail; b=jIAyXrrMbjIyQGuxnJjNf+4Lid6tKrsTGrsB0ShNxqKZ4XRVMgv05PR9uFo4tjiZvGyKxHlajPU61sbp47BgJQxr5XtmiLNV6OMCIpKbXr4MrIH4pOhDEr3tWLfGAtid2JutwComkD3mb51D1Uw93OS7gdtaDfYF+IBPbfUA7Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778143714; c=relaxed/simple;
	bh=Ggmud+2TFupnAdVvh3Zm0Xnzuo2VFVHAyPjYOS682mg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FKo6JZKfE2xfJbwUBDoV4nFfd5N65XomIW7tsK1rr5QGB9j3O/kKtz1vIhL3sduxYlxwNFXTm9Ay7SBBAvSWLU9LoRB4sUtUC3D37Aapjd1E7IDwKuVizlsUnaghHW7LARekhOeoQE+ggNzwRusA4acBg7GOGEaNajkI/Ehs0pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWVqp+lv; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWVqp+lv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778143711; x=1809679711;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=Ggmud+2TFupnAdVvh3Zm0Xnzuo2VFVHAyPjYOS682mg=;
  b=cWVqp+lv4meTOwLpv8wuGGXA282sSkfaemk0fPe5MfjITY22YV8c+kwX
   8WIpJukqWTa9bQS2XAVryBIAXFxQyEys7V48ZtKr6CFR/uI8poNMhxgPY
   us/iV8fT7ZRrZ2u4swNDOgoVzkgq/en87DWl2+0JiMJZE/aZ90OTrr2zB
   pRfWknpgpBIltv1YWJOMvGNwzNHAniDdM4XWMKbkg8PfT9C1mocaVwNiz
   znR+qi0iNV/gQZNOJ4XOjIHYQ/Dgy/fHZCPdq5pDGO7ibq3GWl+9eqfwb
   wTs+GcTOvi5+bQas/ZTOYlpxTf1pmrcIOYUADx/0KD+M6TMzZHhr7T5n2
   A==;
X-CSE-ConnectionGUID: QR9JTlzzRhWueQg5wz17sg==
X-CSE-MsgGUID: oU5yV1XPQYewGqIUFXtDMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78986195"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="78986195"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 01:48:28 -0700
X-CSE-ConnectionGUID: 5MJSwPd9QBGAQrgBUw9OmQ==
X-CSE-MsgGUID: HTKJaMvwRUC77LzozRdvIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="240733811"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 01:48:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 01:48:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 01:48:27 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 01:48:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0Xzq8/TGbtlRuBjdQikjaPbGQNF00xRbx0aNYPx7LOrBpDtfrKoS6GbOXedHFgn4NmCG/Cq7m82ED2Hx9t4j7IVjuhMVnsP7eaqHohh+rj90Y8dJwMNi5UlbFJb5bBKhCnRtr5Kuau23RX3RNVTIGuvDeFvS9vRh6d1IwuST1XuNNJu87girUyj4aXWzXjD/pAIFvdF0DUEJeYWk/0mIxMFlb+3NIY2GNSPVW6HQPnPv88Lla/w/G193JIaJJ7I8JzIEAAOJe6MqmAgNtB3NK35r8wrsetRn78lyYkDEl9xte7aWE6NskGeCi9w6qBLqO7Zx99zql7pUpps6uCLag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDFpKNv3Pr41FwR1AhaRrdVvfhyVrjCieOnRoEr+Z5M=;
 b=GsgvxE07gjo0bvT88LGJlXBl+XfX0o/qg/mt5o5TeOykcVOfI5UIJr/Zu2Q1jAtjJ+7nmj4ZbWVh+mOvBReljd/ntDMGMzYDYwUUsAPVKC18mOUkLWIcfnyhpco1m2KURbxruNURy9i3V1cNxnI+B9TwBLvknWceI2ZhSQdf2TA5j2qxjzkEWx/Kq80U7yyBrqnKN53coww/Lh0Sp9VLz4cKcgPBy9+Q0xJnQ5u18tEEpwLBq4PLhGybjfDcm9O3sZRfKAyd/lADsrYvPQDAkhsPbVCf1SE2LnQ5M+sF212QWDb1n+2Wy3wNOCs2Eqf3Ck7CJ014bryj4cVLzvcQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by CH3PR11MB8315.namprd11.prod.outlook.com (2603:10b6:610:17e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 08:48:20 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 08:48:19 +0000
Date: Thu, 7 May 2026 16:08:19 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
CC: <dave.hansen@linux.intel.com>, <pbonzini@redhat.com>, <seanjc@google.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>, <kas@kernel.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kai.huang@intel.com>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@linux.intel.com>,
	<vannapurve@google.com>, <ackerleytng@google.com>, <sagis@google.com>,
	<binbin.wu@linux.intel.com>, <isaku.yamahata@intel.com>
Subject: Re: [PATCH v2 1/4] x86/tdx: Use PFN directly for mapping guest
 private memory
Message-ID: <afxIc/0qNvwcr4VQ@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260430014852.24183-1-yan.y.zhao@intel.com>
 <20260430014929.24210-1-yan.y.zhao@intel.com>
 <28c8d380-d2e5-4f70-96b0-00225e0ea86d@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <28c8d380-d2e5-4f70-96b0-00225e0ea86d@intel.com>
X-ClientProxiedBy: KL1PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:820::34) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|CH3PR11MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: db05632b-344e-476b-f97a-08deac156383
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|3023799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: h+UAoXRu2scwE5fyhSoP7rEf1C1BDrJSz+fLwR2F6JlHGqKxCcR+C14KoZvXV2zz28bQHkOXvZ/d8f7nbKgIxraBTrYHkuKiU52FFf8ymX4R061P7iNFePUaHb5rG+3kxoPtJ+3PJs2skFe9A1WHoZFowV/7PVH3xZxVpnGxXdtq42cnqnD2cmd2ZxfIRa6LkSEUcJ37dKYV/br0mfQciWZXGb8BEWTRK4WaUQGYWB8HB1P0831pGigHE0DxfClBrKjLMaS7ZQ9hjbPfOCFEntsbIJkmeICoCUvavOcQpXHl5/tiiggS6GRjXZ6iXgB/W118Fpzx/wVdyV7BjDobul7Ju0CkgQpEXRtUDVdPInNS0vuNwyzwKHJKc0zbM2kxuwOgu2u0y9XreQSa1hjZhSwD6YlA5m9fvZ9uzLJRdT4ECgTL9NdS0XbT+K+mz173EIf6ZMOk6BV6YQtnnd8jPRv73Odd8SxvO/IrLq+MT3177bYG4UhS6AmRvgMghSpfQa3XAYHt4v48ZKt/utWcsPEOcN2ZI50V2rret/JxOOrkqeWwf5ZjaZgLto5p6aq3bpLS94bd7DFsbu1YQWOrkE3CmBwpEXDJkpbaGzY3Wbn063tHWXud/fVHRoQFzRsV30rR7l68UvlrCeYYFwGDIAve4JMF0XZO9uds0tnF0Q7jUuPUSNz11HnZbuos5IVTAKD61qDWNbuqkYk9tRF4XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(3023799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3YToqmAT0PIHhIGkN5Kkax7yk+pJsBVJfuZBvdIOdhSsVUFOBYaW72BI38gS?=
 =?us-ascii?Q?yoNbE05MSN95GYdblYzKNQxwyhMFZxt2tk8mxk0l8yX8ejdfzbVuNkURnwAd?=
 =?us-ascii?Q?yHWkxb2FdxpxkiRXCcW3sbZ/pnGb9wEBLpW1FFkF8OV3VSJwQJr8hDoJVisz?=
 =?us-ascii?Q?1Gh+NyuCc+850yr++Urj7emsmvE54btG/QHbTsM9jLnCUlQu55d1u6UZNrYi?=
 =?us-ascii?Q?zkJKoMdKLEQk+Ck2Rd7mlm7iN3H2iGoDS8QnEl86nzlyZ8OSaTAXuu8PIChA?=
 =?us-ascii?Q?jhsRUhFShBuQ8x1ivxHae9h50jZ9/agTkGRmtxs05AEhsI/MoKUBBnmiUVGW?=
 =?us-ascii?Q?tbhKz+c03HEb3T9cz8aPpjMNstw7K53TKE4i1sM2f7sHIROuzOZVjGoOKeby?=
 =?us-ascii?Q?07R40DdACAuQ+ml7amFmCWqPwYh5Nbh2SBebL1y+J+jHJsqA6Ma+i6Mzry2S?=
 =?us-ascii?Q?Xqb8wxL6mxhbUlppMj4HKcnf3XLotUYW3XS2RXqd88t6tK/HkPg7DYRRhEI1?=
 =?us-ascii?Q?vj8LyTjTp9j2bA04hZYNbrbdr+0q+2EXtIe99zyH0gMyT7XhVPIl/tWYOZQc?=
 =?us-ascii?Q?fcTLJXT2Ei0P57x9elXRST5rCJqcVU01K3jzQjYLr8PSKQyEWLjtQPF6xpA6?=
 =?us-ascii?Q?d+VoYxnd3k9V3XqxtKHjMCT6SBPql8QnNg8HebwsBFh93mOGH1lm+e26ESh2?=
 =?us-ascii?Q?SQ8KNLubpxo7Wdr+qxzZlimWc7uvIWzpebuaTm5qN56+nq2G6+/Ygdx72JwG?=
 =?us-ascii?Q?r87YM609e6SEMI6VxJzL1zfhOnL1rE/W7R3awctas4kfCBAthjbIBIA7CZ8S?=
 =?us-ascii?Q?ogs4ylOI4qtoDc0hT2H4vliP54rUjLn8lj6FWI+N85IlnD3W5CfUlBcEouOI?=
 =?us-ascii?Q?D/CEMSoODHCZug3yQtANpW7Xc4G5UlpDjJiQ+USwEbjIu8CJBkqDw3dHA/yj?=
 =?us-ascii?Q?by1zmduXeZj2ebKw8aVGRzRPyBGXz6dmJ+UfZ7gXjHLVfTp1nit0akhy80//?=
 =?us-ascii?Q?qhrhVm0k5u1Xgys5J4wN+/K8A3QNaZbaNraqYky4uU9dIEQddvih6bEET6J9?=
 =?us-ascii?Q?xfhzG+ppaYjQV5/Kl90bKaOHkNx4NzvVXiIzXNm73/p51n+4RCAZ9ovzPotl?=
 =?us-ascii?Q?KhretXtso4fRSP4rq/TKlTcXBi3S+lxpMYYVUoDydqZ9OAUctm0A+S3jmLJh?=
 =?us-ascii?Q?PihAWHiN/9/Mns9XwmRWmLAdMmwHizCYOGaQDVXfqkLaIgbuux6yoXcdZ93v?=
 =?us-ascii?Q?mvdoT5rXjBBAZqazAop3igIHSYmDqTSsuoqUPNQmUUJvuHIF5nntF6Im5oJS?=
 =?us-ascii?Q?vC6CTZXmVnuizCEjKob9zlXKzKPTfu/PQq/LhE3upzNHuqmFO7vU7ymvPN8l?=
 =?us-ascii?Q?V19xjgk+5TRe/Mhd6mA3B7rtMjezs4JHsMyv/EaJzftp+oIqFZwQVnkCdRlu?=
 =?us-ascii?Q?/cuspxDkemh7N31XGdYnmCgPds1c5ShZItZ2/Kh4GuIYkQB+fWrVDYlGZWRH?=
 =?us-ascii?Q?GSmBJlo8vxkLfEVzBtCJgdmzyDEOJY0iNQY/W5B+EnjTB9rU61AMxx0fXDtP?=
 =?us-ascii?Q?t1iU4NNlE7S1IE2rQDAMDvgCKJKssXe4EIeYzHQpA+llykvbQS4sAdTDFSRc?=
 =?us-ascii?Q?Kw0gYgeJD+p5CUT0Lk2ab+3GKWynIofv/BMT61Gk3Wf4u9WNNTn3jMSdtwhy?=
 =?us-ascii?Q?9ujZZZ15TG13vA4v2ZCYcAGkPMasyOHZEbweBgZX3uIHSdi4WrJjvwi2xEmo?=
 =?us-ascii?Q?GgmliAvU+A=3D=3D?=
X-Exchange-RoutingPolicyChecked: Iv/4PsbW1c6CnGIJqbo/sQRQHwfK+I/R3Mmup31l75HMXoT4Y1QQFGnkyio23OcgdypIl5YF+ON2AsAUKZSnzz2MaVc8FQRkDWavKOa/60uIrl35DIbHnDfA/d45qL7Ye8osppWmw9j+KMO8S2A8QFMA4yme6QwmTnM8ddGcvjEIqcBlVdDVVUZaIOQaj0Wu468Ba+lLa6FRu4KVM+aBtdwNfZMvnFwk3dOgu/GKZQAGBrNlrxpSdsSOCMxPafFEJEOxGhIBfzl0vIDXsraHINFNBa70HtcBzoAIgmbkFowe9VrKPW91zua/hnVo5g9EsK3WnnjsISnBGhAMqRpo0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: db05632b-344e-476b-f97a-08deac156383
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 08:48:19.8325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLONMYvvPHpe1mh93b6EB54zlwYiVyW+lT7xVdiBSzBS0j9NNkA1sYyC5+OOvJp4D4bEP+8GgmrEadQR3PJHtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8315
X-OriginatorOrg: intel.com

On Thu, May 07, 2026 at 03:49:09PM +0800, Xiaoyao Li wrote:
> On 4/30/2026 9:49 AM, Yan Zhao wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > 
> > Remove struct page assumptions/constraints in the SEAMCALL wrapper APIs for
> > mapping guest private memory and have them take PFN directly.
> > 
> > Having core TDX make assumptions that guest private memory must be backed
> > by struct page (and/or folio) will create subtle dependencies on how
> > KVM/guest_memfd allocates/manages memory (e.g., whether it uses memory
> > allocated from core MM, if the memory is refcounted, or if the folio is
> > split) that are easily avoided. [1].
> > 
> > KVM's MMUs work with PFNs. This is very much an intentional design choice.
> > It ensures that the KVM MMUs remain flexible and are not too tied to the
> > regular CPU MMUs and the kernel code around them. Using 'struct page' for
> > TDX guest memory is not a good fit anywhere near the KVM MMU code [2].
> > 
> > Use "kvm_pfn_t pfn" for type safety. Using this KVM type is appropriate
> > since APIs tdh_mem_page_add() and tdh_mem_page_aug() are exported to KVM
> > only.
> > 
> > [ Yan: Replace "u64 pfn" with "kvm_pfn_t pfn" ]
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > Link: https://lore.kernel.org/all/aWgyhmTJphGQqO0Y@google.com [1]
> > Link: https://lore.kernel.org/all/ac7V0g2q2hN3dU5u@google.com [2]
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Thanks!

> > +static void tdx_clflush_pfn(kvm_pfn_t pfn)
> > +{
> > +	clflush_cache_range(__va(PFN_PHYS(pfn)), PAGE_SIZE);
> 
> If the pfn is not in the kernel direct map, we will get #PF, right?
Right.

There's no simple interface like pfn_range_is_mapped() that tells whether a PFN
has direct map or not if removing direct map is supported.

So, as PFNs not in the kernel direct map are unexpected for TDX, this series
leaves #PF, which is obvious enough for debugging.

> There is on-going attempt to remove the direct map for guest_memfd. The good
> news is TDX is excluded. [1]
We can see if any code refinement is necessary if TDX is included in the future.

 
> [1] https://lore.kernel.org/all/20260410151746.61150-9-kalyazin@amazon.com/
