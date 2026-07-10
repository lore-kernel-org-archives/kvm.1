Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CB33F6C5E;
	Fri, 10 Jul 2026 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687946; cv=fail; b=BqYmUfPCuMjo3W8ds2KaXTSdx14TuD0Dxp+HEjrOd949Vx2CZO7yrfVWUrEZk2T/OXd+iIPmzD4FKIuiUTi8i6Lnc7L0Ml7v5eOfP5ZvHsUeOh2xb8kwU2pfotrZWthD2xNYIsQO7HcSwc9t5fExgQLMrEfBo0SmmzLV+yHzAkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687946; c=relaxed/simple;
	bh=6zv8nMjyf9SoqJH83LeOElufhwuKkSqm3JCCCnjpzuk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dy3N9mE9jAF0yVb4CWSBMpMD/+N5e/FXr2HPKMDx9tzwwYpqVqJx5we+l1yz+ky5qBKK/OMIbInWe8nttrBKoBRN4v5oMXJbmQvDj7weORkfXad5I74vV7fmMbUUmzfmq93ELw3uhWamo3BsH6J8DwGt0rh4QFSqoa3uXKbABcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2/20AeG; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2/20AeG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783687944; x=1815223944;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6zv8nMjyf9SoqJH83LeOElufhwuKkSqm3JCCCnjpzuk=;
  b=U2/20AeGHLugirRab8HPugUli+yLk84l1/3XDIKn9+tRvehRo2ZTDiJ8
   dOg461xAWjr8sJ/IleG+VT6M4rbjMU2/s9gOeSnglab7Ne0gRl5D1eIYe
   sPf2vw/btLTER7qWhEApFOy2TglFkwD7b80S+zGgJf/HKcn1QVHA6oawI
   o7N1RL5Z0a7XO4EleTcMfyRcCGvgqMoRj9ZFFcxvMEfiMpnRWde7mtv4u
   3qsJSVDdvM+s3la8h0s+eAMMzCUrYLNXdGbeHWej7t0pomvf5SyqhQQUy
   hOTCCePOH2yD1HAu0bLwSJpQsN6DCe4RUW+eCJf9TPIjSMyDkRhPlE+Ql
   Q==;
X-CSE-ConnectionGUID: /q/mKrISQkSOeRnPD7HmmA==
X-CSE-MsgGUID: 0tyXeK1KRpOf3rRfRL9qRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83503416"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83503416"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 05:52:23 -0700
X-CSE-ConnectionGUID: Z09pPQ29QyOqp5wjPUiLBQ==
X-CSE-MsgGUID: vFuMeWe4R7mKvueMY2hCqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="250465914"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 05:52:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 05:52:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 05:52:22 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 05:52:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kvg8J5QagEqrwAX6gaecURejyUFI9Nc8LxYI4yDXufECoiHrz/BJcMEck5NpBfa7tJwfXAwotb/p5YbGKnCZGxRpI1kDuzxZXl7eUOxx+jA+Z/JOXhgCodo+jln8OHSo/y2zJW1v2UGMDxsKNxPOlpxFvT7X2NTTdg8ad+zaWs54PyaFsFTqZwoY5WdzfpyNu5n+qP5EgcS+ieoYI0zbO7BlzAqnUjimGHmkDKzeE33s0dBYraZfoickNhRZca2rV3KO0hBgBypAIRhX1q6cNUkjFSo226WkiCLV1Q0N8ZbZTdxVGN7yY+2Wx4IeW4B3Y8JdYbzE2RJ72du+lcZbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLx1819gBfla5foINAn5m83b/8ogXfXWRyMUMSVcFX8=;
 b=Tr3AVt/qYXQ+E6avVB8RgX9emLSvGnEZ8KtEo4y1iVZQ1MZwxnBj93mx7p+h37xTyOzJhxTSeamkCkyWrpSqZvQS91tE/iwFybq6OmzmwHkWJ+w8JYNU8jQVLZuLEAeaxhxB+sLPiPgsCye3bqzLKg6EdH58foYvOtGnhrW9quBEDKb9hgG+e38XPVYEsWG58tjdf8U3Ctv9GJO/xND6XDKjCYrK2amMFtmgf/tLL17GMaHJTZEeKjxefbeHGwJ/oUV7p76pEzK5vUzrOYnLdZFHa0+x0k68Eug/jXWHJqgIp1wTpRZ+kdDd3JFzi7RmnpZqB3nSwHOD78ENvGGofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SJ5PPF89507EDE4.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Fri, 10 Jul
 2026 12:52:14 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 12:52:14 +0000
Date: Fri, 10 Jul 2026 05:52:11 -0700
From: Peter Fang <peter.fang@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <x86@kernel.org>,
	<kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <djbw@kernel.org>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@intel.com>, <xiaoyao.li@intel.com>,
	<sohil.mehta@intel.com>, <adrian.hunter@intel.com>,
	<kishen.maloor@intel.com>, <tony.lindgren@linux.intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<dave.hansen@intel.com>, <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
Message-ID: <20260710125211.GB2816371@pedri>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-17-yilun.xu@linux.intel.com>
 <ak7DMwbF4viiVoO5@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ak7DMwbF4viiVoO5@google.com>
X-ClientProxiedBy: SJ0PR05CA0185.namprd05.prod.outlook.com
 (2603:10b6:a03:330::10) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SJ5PPF89507EDE4:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7de9bc-cbb2-4e59-7b71-08dede820fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aNwzDmHjBmDKI/GxkFVpAHFV1w9NtCEcQ27KUazt6SRra0AN5d/4x9O5tlUO9cXoUTsb6NErJib3/AyFmwjxdkfT+1FXX5QKlLPftEqcrb7dy+UqdObne7co+lPKtHXeyB/A0meVvwsvhpq5cI1bRqi3QjjKRmfeJa6uiJ9S4cjZFTKLURkxImitMCWg8p8BWWJWcgIarc+IX9fV/OnCcVyFftZ6vWRdEGq023enUjp1zKRL2oAcA2DXfOH/CVg78aT4VlGO8ZB+YaRrioOkwOAShFjsLC1Jtks4ADTgQ8O8sAcaq5De8eTZZFn40heDDf28C8uDgOR6ncoCzt+XQdzPBKBlgcKPoAYhoWRf+QDXWCS3KbfiT2uIJuvg4P/CPkBuWS6L3smdoGFizCxegGkFWRQBLXKpc+2jpz2P9qBi9mmhc4B/ewBg0xL537iabVv7rj4GTA15mDAvf3fFXgJDiMst1Ji86YDlwhQWmhpYnP22pXV7yMsgYP3IjrUO6EtHBm61BSXRPdFxtDYBiLaoCNfyaeSCin7lnxEDI489l1EgJS5PEK1rzcKUjjAgxf1yQ5xSbxvwR1xtTsQfBhPXT5SpRBSigkdbpGB9LU4fkp3n1S9x3x05AabJHvKcXa07qR13x5FTblJgiK2JFiyeDXETlmaMiIFWRwP3lzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?danK5Ha+XSUOskeq+xoPjw3Kh44ln2yKeCHmCrK257dqhyslylvjJvIvz6F/?=
 =?us-ascii?Q?NcXvrhiQkTnMH0MetMidAsvBde8G0bcR5HKdBrF5nVOXLQHFZLmnxL9kL3wl?=
 =?us-ascii?Q?Zd2wK70GqNjnSKPXQSmuGwSsyeR5+qsnY9qoGG2GtD+fzZFOpB2oxzB6pXQK?=
 =?us-ascii?Q?O7CHsxiC8LZYmoneo8O1D9XYnIhTpnojI3kmNXitTNsI2Nb2GXxpreaZDzrO?=
 =?us-ascii?Q?HWqwpdf5h8FawkFuR2npCDircVHYTNJtbdnRndowI9LLWFBxhO7eqSeh5PPX?=
 =?us-ascii?Q?IUGsrIu5rg3uu8ZWTJMrjnZVnuiOdcH67e1gY2geQUo87cFigXM5F+4Y0hpB?=
 =?us-ascii?Q?5WbhbUheepgQg6IQMQJkPAU9//2bF63394yhvMMtOzXGyeVZ3ZPPoBTfpJXd?=
 =?us-ascii?Q?Ea2AL5HJa+dfcfuhaFTnNaatH0UbPWfsdoiqdkqTUtK4XGwjEcfdhkJjxzTm?=
 =?us-ascii?Q?Ionn96NKyf9IruomoHM237OcOFxrfEFpYj+Mt/PmJ3lhOcu9+9KynuLCSZud?=
 =?us-ascii?Q?ZMieA81EigK4aS7hX+SABRljVhxmEMS0hN9tMotI87HMxpeAVimpsDncjRr6?=
 =?us-ascii?Q?F9yZXbuMk8g0sw53bawrbu94PUPIhoGndPd0bGmriWca1urv4dvOX2BDlgzh?=
 =?us-ascii?Q?P291yRFOx/fvuStrgXHobD3yCkLDKc3Enk5d3Cn5GP16Ii/ryVuTS6JqvVNl?=
 =?us-ascii?Q?zzGQYmKejhFFvY4QWN29wNd/cqVmK6iRaZOISNEWWzvLGLMSw+iRodrApLt2?=
 =?us-ascii?Q?gCKDMbfeWh8O7ophP2sAbvvAcUtHpFhGRv+PVSqEpC4OdTAhfms58yivmK/q?=
 =?us-ascii?Q?oLulkR4mKfGbShu2TZUzUoPbM6uTjtK1isM86BGqnuAiSf69gjxcJym66f1h?=
 =?us-ascii?Q?eKpjgTRTUwxKPWz+ms0wSmUHFs9nrZSeT2RbE7kICtl9F4OXd8Br+ZtHkXiG?=
 =?us-ascii?Q?0e22BLbwNjOGZuZeivhaXvBHoHKoKS+Be3Smnb7P//ye2/X2SjB5axTB2tb5?=
 =?us-ascii?Q?pksmx/6NC3UGyVKKLu69Qv0/rQug5DOvNxHI+CkB7hYI1OO855TeeySn28WB?=
 =?us-ascii?Q?pUN8mQUtfAoIlBuv5KHJUiX0XJARDswySiLohexyLjBV7UDd3WquIegImhhE?=
 =?us-ascii?Q?oDHdKdTxOlE11i5v83UuL/A8RE+X7qszJQdUUa83SgLmSLsf1HywDzhApME2?=
 =?us-ascii?Q?lg+lT0q3NyV+28AaOF4ao/2f8WC9I73j2vnzZeWU2tN9USL4KoASbTW0qtbk?=
 =?us-ascii?Q?4up9TUFVUYdzwpbQsCce+VgC69/ghwBmbs1iCR6MQ+mzxXtOE1m8yYa/rFHn?=
 =?us-ascii?Q?AUtQ1FHW+XHcc2vnYuduzQPJl/kKalxmwV2mWEhq9I9qaRGTt+3+yf8NRRv3?=
 =?us-ascii?Q?HOKyNH7ifhsLk+g5M1FI2Z1sh93ksb8CC8bCiacXMJ9gX4FlXMxwvHv2O9f1?=
 =?us-ascii?Q?r/eQ1Pf+mdNFH012cHUC2BHzOASUqcr9AJBIn0LuAQgadmO5Q+sSFapVXeF1?=
 =?us-ascii?Q?BOL7Zx2Csihbbsk7zhd74GlO/5OoYmclFG7l17FFztCVXlG4LEm/AnVhlmvZ?=
 =?us-ascii?Q?fKEWKeOeQnGvHIc6v/xLzJyuiHNnWvIJkJrqn67Qp4qcpWKEm9L3lwijAB1h?=
 =?us-ascii?Q?netifqO5IZ2cBy1UOOptxPRsuROdzZKISw425rD/2G/wJ9zUkDV6VGhfET6p?=
 =?us-ascii?Q?tTosWcn0r9rmJgite0npQtwpgDabptPEzOV7WuMnRri/LlkZDTFT/4+SyQET?=
 =?us-ascii?Q?uO6WarifOg=3D=3D?=
X-Exchange-RoutingPolicyChecked: IQOzkkies+DtluiK2F8b54z4rKe01j3gRcznwrVLEjbte2LYIqdu0Ng22cjFsQCIQ9wsN2P9y1E9/Fx5w8/Oo53fUnN7O+30wHM2AsUB4C27kv/zoALgZ4vyT+ojTX6DVusKxpF1HdxkzQRjwFt2zcXSodVRTbXWcaymyrSbMFh+/oqpftzPRNgBXPzh2XfTpOqM4ewo3PyBWOy9PFTPLIvSSlP7Y5GF7gCiFXpXVTXluxjpd3xUnYTXzh1c4GTcufmyla4SN9PQ2KXnVBKlRd9imOaA4M0pjgk0BlxfdOGqB5uC+xfbxFjzhDZY1Sax003mBE+xUHgvrTWtbMZuIg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7de9bc-cbb2-4e59-7b71-08dede820fcd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 12:52:14.6368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RM5qncjPSKbk7nQwz6eF5GVGnTuqCzl786wlHk2x29D86uQI9d2FwsJV+B5qlmhT/xEsPqyZmz0SEh1FIElJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF89507EDE4
X-OriginatorOrg: intel.com

On Wed, Jul 08, 2026 at 02:37:55PM -0700, Sean Christopherson wrote:
> On Thu, Jun 18, 2026, Xu Yilun wrote:
> >  void __init tdx_early_init(void);
> > diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
> > index ac8323a68b16..5e4b3aee0577 100644
> > --- a/arch/x86/kvm/vmx/tdx.h
> > +++ b/arch/x86/kvm/vmx/tdx.h
> > @@ -47,6 +47,12 @@ struct kvm_tdx {
> >  	 * Set/unset is protected with kvm->mmu_lock.
> >  	 */
> >  	bool wait_for_sept_zap;
> > +
> > +	/*
> > +	 * Whether to get the quote directly in kernel, without exiting to
> > +	 * userspace.
> > +	 */
> > +	bool get_quote_in_kernel;
> 
> Why is this cached per-VM?  IIUC, tdx_quote_enabled() is constant after initial
> TDX bringup.

Ah you're right. It shouldn't change. I think I did this because there
was an older version where quoting was not enabled during core TDX
bringup. So this was an attempt to make sure a guest doesn't see
tdx_quote_enabled() flip. It shouldn't be here. Sorry about that.

> 
> And is keying off tdx_quote_enabled() and only tdx_quote_enabled() backwards
> compatible?  How do we know that cutting userspace out of the loop wont' break
> anything?

Yeah this needs explaining:

The guest-observable difference between the two paths is that it sees
quotes in different formats (the TDX module uses newer formats of
course). And an old guest must be able to continue using its
TDVMCALL<GetQuote> interface for quotes. The guest sends the quote to an
external verifier to authenticate itself. The verifier (part of the
cloud infrastructure) must know how to parse this format. So in other
words, it's the verifier that must maintain backward compatibility if it
wants to continue accepting old quotes. And it needs to be updated to
support newer formats as well.

> 
> 
> >  };
> >  
> >  /* TDX module vCPU states */
> > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > index 9f7c39e0d4b5..20558b0185b6 100644
> > --- a/arch/x86/kvm/vmx/tdx.c
> > +++ b/arch/x86/kvm/vmx/tdx.c
> > @@ -1538,11 +1538,133 @@ static int tdx_get_quote_user(struct kvm_vcpu *vcpu, u64 gpa, u64 size)
> >  	return 0;
> >  }
> >  
> > +static bool write_quote_status_to_guest(struct kvm_vcpu *vcpu, u64 status,
> > +					gpa_t gpa)
> > +{
> > +	if (kvm_vcpu_write_guest(vcpu,
> > +				 gpa + offsetof(struct tdx_quote_req, status),
> > +				 &status, sizeof(status)))
> > +		return false;
> > +
> > +	return true;
> > +}
> 
> This is a completely useless wrapper.  Actually, it's worse than useless, as it
> inverts the return value from the widely used kvm_vcpu_write_guest() API.

I'll remove this. I got feedback that tdx_get_quote_kernel() was full of
kvm_vcpu_write_guest()s and was hard to read, so I tried to break it
apart. Looks like it didn't help.

> 
> > +
> > +static bool write_quote_to_guest(struct kvm_vcpu *vcpu, void *quote_data,
> > +				 u32 quote_len, gpa_t gpa)
> > +{
> > +	if (kvm_vcpu_write_guest(vcpu,
> > +				 gpa + TDX_QUOTE_REQ_HDR_SIZE,
> 
> This is unnecessarily confusing.  I had to look at the definition of
> TDX_QUOTE_REQ_HDR_SIZE to understand that this just writing to tdx_quote_req.data.
> I might not care if this was the only write, but then the very next statement
> writes to a field that isn't obviously in the header.

I'll fix this. I can just spell out offsetof() to make this consistent.

> 
> > +				 quote_data, quote_len))
> > +		return false;
> > +
> > +	if (kvm_vcpu_write_guest(vcpu,
> > +				 gpa + offsetof(struct tdx_quote_req, out_len),
> > +				 &quote_len, sizeof(quote_len)))
> > +		return false;
> > +
> > +	return true;
> > +}
> 
> So is this.  There's literally one caller.

Yeah breaking the kvm_vcpu_write_guest()s apart didn't help...

> 
> > +
> > +static u64 get_quote_kernel(struct kvm_vcpu *vcpu, struct tdx_quote_req *req,
> > +			    gpa_t req_gpa, size_t total_len)
> > +{
> > +	struct tdx_td *td = &to_kvm_tdx(vcpu->kvm)->td;
> > +
> > +	/* Only support version 1 as defined in the GHCI spec */
> > +	if (req->version != 1)
> > +		return TDX_QUOTE_STATUS_ERROR;
> > +
> > +	/* Header + input data must fit in the page read from guest memory */
> > +	if ((size_t)req->in_len + TDX_QUOTE_REQ_HDR_SIZE > PAGE_SIZE)
> > +		return TDX_QUOTE_STATUS_ERROR;
> > +
> > +	/* Caller owns the requested quote */
> > +	void *quote_data __free(kvfree) =
> > +		tdx_quote_generate(td, req->data, req->in_len, &req->out_len);
> 
> Am I the only person that finds the __free() stuff to be difficult to follow?
> I'm sure there are flows where it's a big net positive, but IMO this isn't one.
> If the *unnecesary* layers of single-use helpers are stripped away, I suspect
> we'll naturally end up with a goto sequence that is more obvious that using __free().

The main concern I had was that the guest could give random message
lengths and mess with the host's memory allocator. Core TDX has a better
idea because it knows the maximum possible quote size through a metadata
field, so I just let the API return the final quote from the TDX module.
It's a bit annoying that the caller now has to free it.

Several folks suggested letting KVM allocate and free the buffer, so I
think I'll do that. It should make this easier to read, and this
__free() can be replaced with a much simpler pattern.

> 
> > +
> > +	if (!quote_data)
> > +		return TDX_QUOTE_STATUS_UNAVAILABLE;
> > +
> > +	if ((size_t)req->out_len + TDX_QUOTE_REQ_HDR_SIZE > total_len)
> 
> Can we really not pre-check the size?

Yeah like the response above, KVM doesn't know what a "sane" total_len
is here. out_len comes from the TDX module so I used it to check against
total_len. If we let KVM allocate+free the quote buffer, then I'll also
let KVM get the maximum quote size from core TDX. I was trying to save
some code in KVM but looks like it's not worth it.

> 
> > +		return TDX_QUOTE_STATUS_ERROR;
> > +
> > +	if (!write_quote_to_guest(vcpu, quote_data, req->out_len, req_gpa))
> > +		return TDX_QUOTE_STATUS_ERROR;
> > +
> > +	return TDX_QUOTE_STATUS_SUCCESS;
> > +}
> > +
> > +static u64 tdx_get_quote_check_args(struct kvm_vcpu *vcpu, u64 gpa, u64 size)
> 
> Adding single use helpers does not make the code easier to read.

Yep. Will fix.

> 
> > +{
> > +	gfn_t gfn_start, gfn_end;
> > +	u64 end;
> > +
> > +	if (!size)
> > +		return TDVMCALL_STATUS_INVALID_OPERAND;
> > +
> > +	if (!PAGE_ALIGNED(gpa) || !PAGE_ALIGNED(size))
> > +		return TDVMCALL_STATUS_ALIGN_ERROR;
> > +
> > +	if (check_add_overflow(gpa, size, &end))
> > +		return TDVMCALL_STATUS_INVALID_OPERAND;
> > +
> > +	gfn_start = gpa_to_gfn(gpa);
> > +	gfn_end = gpa_to_gfn(end);
> > +
> > +	/*
> > +	 * Reject if the guest didn't explicitly convert its quote pages to
> > +	 * shared.
> > +	 */
> > +	if (!kvm_range_has_memory_attributes(vcpu->kvm, gfn_start, gfn_end,
> > +					     KVM_MEMORY_ATTRIBUTE_PRIVATE, 0))
> 
> TOCTOU?

I struggled a bit with this actually... I can't just grab
kvm->slots_lock here, and dropping kvm->srcu seems bad because the quote
will be written to guest memory later. I settled on the idea that the
guest should make sure these pages are converted to shared first. If it
tries to convert them back to private after this check, before this
TDVMCALL returns, then it's kind of a self-inflicted race and I don't
see KVM doing any self damage in this case. Not sure if this makes sense
to you? Or maybe I should just drop this check and go straight to
kvm_vcpu_read_guest()?


Thanks,
Peter

> 
> > +		return TDVMCALL_STATUS_INVALID_OPERAND;
> > +
> > +	return TDVMCALL_STATUS_SUCCESS;
> > +}
