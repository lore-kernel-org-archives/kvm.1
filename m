Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80515566C4C;
	Tue, 22 Sep 2026 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094021; cv=fail; b=SizzvLe2XH07bH62Vyw0GCLQecgELh9eMA78a/n4XuoVhgkYZRnvgZkH0+s4tHQp00jigcMsgxbcUYAemDaJbEoQ4GyzU+XcfdcTRIV421UDFEZ1rE5sRA/6mwK6eYzGpeBH9+4ymRhaD366wUcxNjadfvxkEevzCHN39x0cNK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094021; c=relaxed/simple;
	bh=ONBOvmjrdHAX/fHbzAMa9uUHSLdAESz1PecZpeA4kqk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hm3fU2RCRQ5hCN1gN8dfqo9AuC0pdKSgzei9XDm9DPfUNPoheFlcVhynqwRCJ/c+bgUTdTRmqMeHDAKQPTMAKfl5v2xtY3Q/isxR0I7Si19t9dO7IHaqTzuXpWfwsC3CmTVfLYbxFbQqb5uN6x4jMk0N0pMNrHglQLlY9IPz1nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYgdor4s; arc=fail smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYgdor4s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790094019; x=1821630019;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ONBOvmjrdHAX/fHbzAMa9uUHSLdAESz1PecZpeA4kqk=;
  b=RYgdor4s3Lv2kT9JMh1pUCxLDF7SMXLw9aAU8dfFvkVMM0/cQV8oT8d+
   PrQIIJW6xJ1Cz0ZHA+iQEdQifJTeDNAO84thgJk29P/TM5uCBT/t1hGZz
   B2HmlDK61c20IpGSvk7RbVZzvRThOqP2z1cE42Jbe+XV8qlNebhw5EzaE
   ycnhVkqjuspRx0OOzeplXCAAsRWUfjHG57lONohZnclZbz4T4L2dwupEG
   lJ9zQ/29MnwNQDyAB5/JKYkLGwvIpINYsU68k3dDeBXuVGbwkcLMJZBHb
   qtfvOerB1CuUS7HLA03Fk4i1pNn+Ce6ivw+JAybixO6Y89qk9gHJ6DXG8
   Q==;
X-CSE-ConnectionGUID: CzPVDs3zSZiMXSIOlk5jmQ==
X-CSE-MsgGUID: 3WLa1fUORj6DZcZFHMWSUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1216613"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="1216613"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 09:20:19 -0700
X-CSE-ConnectionGUID: SuN88eYQSl28uGihHpxUUA==
X-CSE-MsgGUID: Em1tgWZbQ26SwjHwZtO2/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="4212589"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 09:20:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 09:20:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 09:20:18 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 09:20:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5KexMmvdsdyNkEDxK/tcVnDR4OLBCpfhAMALivegnq799/ygYYO4OIN/e9CmDTO7K0Or/ucjZ9dgkMIZx1VOff/QpfmNNyVl6IJlyi7moiwCULJHu5KpXiO1l/9faKTD75CKo+pXrBgmjFROSl0gzlTKlScgYt4bkadMDiszjzZgAGoVjaGbE8nj+el+rV31DXZg7Hmi9X4QNrtZhLJB0ZoEhOMXp3acod4P2eIR7hpmdHGjy+XSrSFd9cSZhbFQFoehiiUpGtvntVZ1XLroFScvxIMMTLb/6iO00yzgUsdwdEBUqTv9EBZPxFxWpG7dcI9kusxsZnsl3um5fgMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Skxwohu9S9G67PNy5atf0x3KI9bpFN3lGxohAoBMBr8=;
 b=i2jUASysco4gcYk2iwXnxePkodnV5d9XmLhufYnStyPwQBOEV7IXpyQR/K9AHAkTdHG8FvEiJPXYO3Slaxa6QcJnjElZEu5xMqLR2Hv/eH7IcdRsAyOxZ96LA1w1ytOevzR/fNDu33PMHpXX5CGbrB6Xftu0/SlFwcSYFiuHIx/cp3ok+oczymeTtBkCvdmU7rsxDcDdz/rH5nF7djvTe4lWHKE4DP/awSGeelRGHqEHWpxw3WU+jjZca9TjEhBYQcGxZ3nvs0CBllIgM7+JTPf0PPEyVRE92kG//gKzhx76xOXPoRKDJUHWFDxOg/vlpM5nsc9ik6Q1HMBfk4V5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by PH0PR11MB7471.namprd11.prod.outlook.com
 (2603:10b6:510:28a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 16:20:15 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 16:20:15 +0000
Date: Tue, 22 Sep 2026 09:20:11 -0700
From: Peter Fang <peter.fang@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Tony Lindgren <tony.lindgren@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>, Artem Bityutskiy
	<artem.bityutskiy@intel.com>
Subject: Re: [PATCH v4 4/4] virt: tdx-guest: Allocate Quote buffer dynamically
Message-ID: <arKquxrRpaKAUsHY@intel.com>
References: <20260915092632.2822169-1-peter.fang@intel.com>
 <20260915092632.2822169-5-peter.fang@intel.com>
 <c88327ac-6227-4e4a-85b5-0ad320871637@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c88327ac-6227-4e4a-85b5-0ad320871637@intel.com>
X-ClientProxiedBy: SJ0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::10) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|PH0PR11MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: af3231d9-de2d-4c0b-62cf-08df18c56287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2ADCGK1GjcaCfdUc7+vu5FgtUihgxzcH4ZguA4SGqK/qrqV4pc3e4J36UseFZyCdJy3bAAI703K8XIcpXXAdebIon4Ip6lTilGmKneo2g+pvhAoZeXvF1XT/8NCzGfy7uppi+ywTjAUftX7jrflU154q3Cakc4PPIus600oO59mNrAevbw/YhBQkfTr+GTuAANbB0Jt41hA770J9xgBjwkAQgmWo64E/8Tdeoq/LJ3ZfS2syvJa6tOMSuQmhqi84LXMD5kTmJFrpJ7Jtie1usYYPiFE0QY8LLA8T9tvsgxnEYr6DHadvWL3jLNjGl+5/lHj2bvtOD22Rn3kgCP3AYXciEnfXVfcLQqeJXmFvXINhyYBlTs7roq27Xhj1iU+l1yH/20OlJEZ/yYxncdRvFFTGYtq/Y6t4Pb3AOT8UaIpRp7R1yxumDNEyHXkL94p0nBUUKwISLyRD98LamlfnsQn0c4j1FOL6EetpCoPyiTh4GM2eTUyWJMWdrAzjpOtKqa2omwpGsOZZKhI4glrd4AW+QzDmEAzwQSNvy45rfJZ/nZilMRsw5qoo092c7gWvgV025xLnrzoRBInyW+5fV1O8ijtlgL0Hu9RGxCEwElKTZPkAGS/JI5KXDYkIOYZLhFJigTFfN3jAtCzrNpXTm8TUVmicheFIIItWMj5aak8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5EFOvV61eoJUoBWOjbcLT/kJCSOvgLJZlpzTRolCahVFLWp1XhqkAKxum8LW?=
 =?us-ascii?Q?1rBEnagqHrtXWzKLy6pV9PIJyGmXQzsktOec7SYe1eajxh9LHBBQnrJTS1ph?=
 =?us-ascii?Q?EVLED6lLiVoHHwzZodT70BsD6ie7rd1UlQJuesXsY15zU4ke4JUv/cp2NfKf?=
 =?us-ascii?Q?noVTEOI6NMzh8pCJBd/mvb3eB6vdMwLVBeAHbw3y3bIUw5tVvC6yN0L3slvy?=
 =?us-ascii?Q?Wk6r2cOuG6h2+N8cj+o9K5qsFnT99Wqr4uB4VRsqp0kGeWR6sTQrc6c9N0l9?=
 =?us-ascii?Q?O1vJMcVZRwkOjmPHQOID8P6hgOwinUS8o+L2tYedYYHmtqWP+X1KzqYTyqOX?=
 =?us-ascii?Q?GokFMftC6eJicEYa+SKzVUpXzzzvFsCx0po79LLyJc100Q4hisoLaweu/7jd?=
 =?us-ascii?Q?1HybQYFlqorjA1o0Gri/Ct/QRj542Y66dZjQ/B7oqpIiVlBrURSHMVvXzg/3?=
 =?us-ascii?Q?nhRDxGTEeg/JA0IKh9fZZiIQpOkAsTyXRYKMftI4ngOnlDvDxzPNRzFGs79Y?=
 =?us-ascii?Q?R1SKnUj4EVwDCWvmS3k3tof4SDlLEciEaGzc7m13y43iKtusNe1PrgfReoTl?=
 =?us-ascii?Q?U5oHoWwyUHKiFYipIUo2I2B4bn0Cns+uun0+6zD/EN1PTOiTqEyEXz1WRbeN?=
 =?us-ascii?Q?v8pe/1R6RDUUYIpSaSWXGVMA3CCeQj6tsHzSuSXU1nhvNvkxDKeTJWVi0I9B?=
 =?us-ascii?Q?aaDLwr4K+CJUqSElIILliFThKSD+VR/+oewdg0T2ODosRh3/1ong8AqLgTx6?=
 =?us-ascii?Q?QDlymzZ+Do1tl20a6KNCo85xqKsQ/l70wdNZHTX+3TERiyKcmeviuBsyqWhw?=
 =?us-ascii?Q?x6xLIl7aQdrZ1TyYCic+kJOEhWrlpg3Rn0hBlP901JJym/hETcvegj/xH+kC?=
 =?us-ascii?Q?u1gUhMZlcuSwf5eQti3GxJaLzw4ae4a4q7tlccSPHPQUIeOEFQe5b7iKN+Ev?=
 =?us-ascii?Q?POkux6KtIvvhZQkb1+PCeaUflXlkA9/SkU4Bmg1PaMQ9RyQosiYz1S+oqTiy?=
 =?us-ascii?Q?y7DxLdVuyolHpRWGun5VLd79+YJu+G0B9epAFs97AlfcskQyXJg9v8WL7AXe?=
 =?us-ascii?Q?4WLTdmRpQ7EOMHRwdVnbd6bahmXwUAJzD0ZzK/NgRPJqwwjNPB4afkcTorrr?=
 =?us-ascii?Q?3xufAdQmlrDiV+1zD6CbGOXhgFh5YEWm2PlTb4hmB45Hwyfzlj/LQepGReZK?=
 =?us-ascii?Q?P0AR1Vt9fKU8mCZI80R1vCgNy+7lUTLFIUuosQrXvOFP/W58bRu4MczpHqGn?=
 =?us-ascii?Q?Bcga86mq6T5q/CJ9Jg++pFGEYGxuEnWuk+T6XybTY/t06kcuNhJNu/6ujKUv?=
 =?us-ascii?Q?j9w8qdPRND2VPsj6RLIcgnGi5226QBHJa8+veaSGchGDyH9ye2UbxYYNcK0r?=
 =?us-ascii?Q?tvzTIoKpHt7DHDcDvEpWT3/zPFdaOV4ASepXICiwl3tX5BOkXZ1aEoAd3z3O?=
 =?us-ascii?Q?oArWuFqI/GF5krP/1XlihP+MMffd9RqUgyKfZeRZCHIiW/gMztrzustmeLXo?=
 =?us-ascii?Q?nhQU2piMnqRPK/onVWAKMjSvXXyf55t9SrfxTZyFJCOULfjr2XtvYn/Yiw/2?=
 =?us-ascii?Q?i5F9HepkIchBELYCTUQDAlKbceV3derFmruodAzqYwWXEo+NGK+VhKTV7V9O?=
 =?us-ascii?Q?0y2HRmcIVRJBhzKJhaHuF25Mu50Q74w+FO4NBq8ekHqKQKV1K8GLkhJ9pU3v?=
 =?us-ascii?Q?P80kJagwQDcIBufLp5kaBfxkKHGOLcd2kD66kGTBivSYkuktsLmXlakYNsT+?=
 =?us-ascii?Q?3zP5Vlphtw=3D=3D?=
X-Exchange-RoutingPolicyChecked: OoyxKCcg9AQKB0tdp1+kw6ceQWF2a8qRsYP7T+nMv+yPf67Qil2ND7ZJy0EMF5r/RYuT5fAZxaWbKHCJU91nuPDgE7n10038HE/wuoFkhmuIgeGZKHAfkNXvmAUlho0Si0NsxdEW4AvYLZyAddUw/Dtv7PQ4590qE6tqLUIzGQQLY+ObC/As4FNc/n9n7ba147QAJ46e5HtljzzMvQIGdXq3r1tEpTJOqry/VOpkMnMElIrta98t/7NCF9vHBaFjfbjnHXJsblrjklL4ZUK9I+RFjWceMpHJ0su37vpPjxGk1gKr5BEk5K1oXSwhqxdW0V6GKZ6Sy7Voxa4V+uQD8w==
X-MS-Exchange-CrossTenant-Network-Message-Id: af3231d9-de2d-4c0b-62cf-08df18c56287
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:20:15.1486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX3AeenhuIaiWtt5+BlsBFSFAiACiHdkVim3q3KbKqNI8XICy3bGVclzA7tQPR6qgR5Sg9bCdIyu2fIfRbdHVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7471
X-OriginatorOrg: intel.com

On Mon, Sep 21, 2026 at 03:47:02PM -0700, Dave Hansen wrote:
> On 9/15/26 02:26, Peter Fang wrote:
> > diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> > index ec886c401fcb..7224a66b65d1 100644
> > --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> > +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> > @@ -162,7 +162,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
> >   * DICE-based attestation uses layered evidence that requires
> >   * larger Quote size (~100K).
> >   */
> > -#define GET_QUOTE_BUF_SIZE		SZ_128K
> > +#define GET_QUOTE_DEFAULT_BUF_SIZE	SZ_128K
> 
> The naming of "GET_QUOTE_DEFAULT_BUF_SIZE" is rather unfortunate. "GET"
> is a verb. It is for functions.
> 
> Isn't it "TDX_DEFAULT_QUOTE_SIZE"?
> 
> I know the TDCALL leaf is "GET_QUOTE" but replaying that naming is
> horribly confusing.

TDX_DEFAULT_QUOTE_SIZE is much clearer. I'll rename it.

> 
> No, I'm sorry, that's not how we do multi-line if()'s. Brackets please.
> 
> I'd much rather see something structured this way:
> 
> static size_t get_quote_buf_size(void)
> {
> 	static u32 full_quote_len;
> 	/* Size of the quote itself, no header: */
> 	u32 quote_data_len;
> 
> 	if (full_quote_len)
> 		return full_quote_len;
> 
> 	/* Ask the module for the max data size: */
> 	tdx_read_max_quote_data_len(&quote_data_len);
> 
> 	/* Fall back to defaults on old TDX modules: */
> 	if (!quote_data_len)
> 		quote_data_len = GET_QUOTE_DEFAULT_DATA_SIZE;
> 
> 	/* Add room for the header metadata: */
> 	full_quote_len = quote_data_len + sizeof(struct tdx_quote_buf);
> 	full_quote_len = PAGE_ALIGN(full_quote_len);
> 
> 	return full_quote_len;
> }
> 
> Having a static function variable beats a global every single time when
> possible. This way, you can (guaranteed) see 100% of the code that reads
> or writes the variable. Anybody can muck with a global and you need to
> grep or search to look at all the other code in the file even for a
> static global.

This is much better. I'll rewrite it.
quote_data_len doesn't change at runtime, so this pattern works well.

> 
> Also note that it talks about quote data and metadata instead of just
> "lengths".
> 
> You also have a mess of naming there. Some 'len', some 'size'. Pick one.

Yeah it's pretty messy. I'll clean this up.

> 
> >  static void *alloc_quote_buf(size_t len)
> >  {
> >  	unsigned int count = len >> PAGE_SHIFT;
> >  	void *addr;
> >  
> > +	/*
> > +	 * This fails if the requested size exceeds the buddy allocator's
> > +	 * maximum order (order-10, 4MB).
> > +	 */
> ...
> 
> I don't think you need to document the buddy allocator's behavior here.
> 
> Why did you even add this?

I'll remove it. No need to redocument the API. Thanks.
