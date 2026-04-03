Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6876C38F95D;
	Fri,  3 Apr 2026 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209540; cv=fail; b=rQvA6dOdgqnvwS06OD5//xHDA8Elrmaij0Yv5/rGMTcCEhwHHa/FEjiV2jhCrFxfkdoRW6HRnV6nSSaq9sJGChE+1eL6ZeqWBxMjMtfskY9W1g/mU7jw8EDzHnNj/l2fqRfzN/npKlg2ONs9dMfcRT2GRs5AX4PBj6PwZ1Ti1X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209540; c=relaxed/simple;
	bh=wwQsUp2XPzRHGcbBovt5CKAJV4u08Fb4YjRN/tQKKX8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cS6SE7Oqm7xjDX1rxPD/7GOs8S+n/1TLR1oH+APfJeAn5gCDV1uzVTskQfSmgvHp+e86skwksLM30rzFmDYVQd1++OIWYivLmHs0PS68Dn5nQpM4AhJTJoAlk8HN7RM0ZhieHgYIMJZ7hQrmw8Tbb8i/LvYjmPIkH+WNRIm8Vls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Os5zRWVr; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Os5zRWVr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775209538; x=1806745538;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wwQsUp2XPzRHGcbBovt5CKAJV4u08Fb4YjRN/tQKKX8=;
  b=Os5zRWVrUV5LgRrhdtlu4YHwRwA24Rw443t+xoYTCTZ/QHyAzo5q5lgT
   x2LBoj6pGDPgmTWKcBHVKMQCnWnxKGr2k+kn3BRqC4AwWns2ZTlkW67xh
   42B223eyDoecjLHOi4vXQnUO7nkpzfWeYNGA+QZD1QrhTwFvpl3Fnqtoi
   SC2LClnL1D5TqlsunsT9bad+WRxSGUwAckvwIoF7LN+2uH6fDnU6n4QAT
   35IL1xk+jvn9b0o2MVCz1u+Rs1Srmc9e+1wLjuAsJTkn1TJhcXU1bw/j7
   1DNaPD0gW5Lktxe+muv4SyPjpJDEL+VhOygqpvnoEfak4J9xTdeVlyICg
   g==;
X-CSE-ConnectionGUID: 3yQ31SewTju4KbAQeg/gHw==
X-CSE-MsgGUID: juC1hOHXQDmgfeHaIKV8zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75996141"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="75996141"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 02:45:37 -0700
X-CSE-ConnectionGUID: 440+niRMRwCEDebN6LDf4A==
X-CSE-MsgGUID: CpjJ5HrNR8CV0XVHtmP+CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="223959100"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 02:45:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 02:45:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 02:45:35 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 02:45:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQh8ZnIECfHgHUQpYBOaBWkdSkri17sOfJBazg9uZztkmDwiIfWxPOmLewuo1HyDHU8u/RzSrmTuS0YjaSiM2SVDdzg9pS6oIbCcWbMQJqxOOmfd9aFtc+jlzTFe/FsW/cVw9SzstfirBjjsAIby1URS60gp0PNwhVTy0jXvwxUTve7/uSSnmfUWzcb/Fy3+d7+/rKopohaZqXEu1RlS+61wUFNFOyvgbYoFaIPkjLOX2vciYwH6QjKeqjiitVzjYZ44m34Sjl0GNR3s3vF3v0Nf4d7jMTh2dW/8h3ekQs2IWk8oALk07Nr5y2rApa542zahcIxLXBe+O6euryrzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLL6l929p5yErvtO1QUsLrgWTqhZRdP1YHWM5mwtZGg=;
 b=DNpyqxhjLR4OA0GDLh/FGQMx4ve+XD5JkKZDkNbNBLp/Q/5EYqXo3ng6sXk3a2nrdcVyrpVvRpcXNKNwjRVE08BOh+bHpfjUx07RTBLLFAkkLbLcf+bhAiLaJ5ZIGyAclXLO0GY0/zAN5JF8BjWuK4UjCMA/2OPgk3d8kVauvBVR6qV7mfyxBA0id2OSjbcmflpOSga703bglvcqSvZ9NI9pN158S89eyWboUlruUn7wM1oJev5ELH8pEewWPhnEqMlAX6bR1EHtWI/d92bDTP1w+45NlLcMcfDWp/yPXhd1gUvwsUsvuTVcprvq53+mhZHptonSOakG3eMpm8M0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by LV8PR11MB8607.namprd11.prod.outlook.com (2603:10b6:408:1ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 09:45:32 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%3]) with mapi id 15.20.9769.017; Fri, 3 Apr 2026
 09:45:32 +0000
Date: Fri, 3 Apr 2026 17:05:56 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Rick P Edgecombe <rick.p.edgecombe@intel.com>, Dave Hansen
	<dave.hansen@intel.com>, "x86@kernel.org" <x86@kernel.org>, Kai Huang
	<kai.huang@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Message-ID: <ac+C9FdF34JRNLWH@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
 <acoUt9vy8OPU1SW9@yzhao56-desk.sh.intel.com>
 <8a107d4da92d4cf910f9a70991a0e67b42e04d4f.camel@intel.com>
 <ac3Ng7IZpzJczZ2x@yzhao56-desk.sh.intel.com>
 <4dfb4c106c834cd13da78872bfb262e98581fa55.camel@intel.com>
 <ac77oSNltyE6vkVD@google.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac77oSNltyE6vkVD@google.com>
X-ClientProxiedBy: TPYP295CA0042.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::20) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|LV8PR11MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc9ccac-15c1-4c16-c377-08de9165be86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: m1ZAukWYft6JN4javYpmfX+R7+V/TM4jZIlHdYaqVupAFpt+yylaGBv98JrfwchUu6CMHZAb68MiaJJwxVUuiczHCtA2gai1klVv48+zig7/abJsFHk1bkPpGDBBAwmRjBDhWE2LmZCdJakIhCH5ZDQLWUzOFx4cFAkuxjAY3BFS16eA2buCNe9zsyl4gGYkxJtMkOF3Q4LUTJTo2NPp/csKdZ5BoawNLwEZBKE//h1xpLxyEywQNdjWIrfpce9G+M0SovBDFh47x/nGOGZV4aVR+7Y6lH69+eRjfkLnUiB8PZJPNjG7HR9WVHAxR6SjWsTRT5q58Sw2a3s2DeH+QGLRlTCYFlECemMYRv/IOEoXv59zBucIUAn6yNFS7tBg2yca5ukC492BuD7klbm3eNgw2AzpC8vbIYlug+cV6R8BVY+eS/OSiqTTN1PnEy+g//dCKDZizURXIXaeWmntvDPBN5IZAonveCPqHb1fmPtznjSI9EHaAjAoCouiMhGvWhIvOVM0q/yUuLPqgJj0qiYVL9cjwx4nypSMdEWfwNKcd7Yely3nIu4a2CWJoxM7wmzFOOKg2Hb54PhpGkImepbeP1P/JEaiQdrFyfzvOF0mHrDpaPvVPcwl/nRO12/509jd4NhVzrR5jsTD2Kg4HoqQahk3LSmkAsdFeCUCoNycbhBY7lPc5IjFFkEIi1wVhSeArZvrwqehZXGYnAGFWqCcGqqmFXTFPzn0G1GBhuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/D8SCLcA0m6f3TDyFYP0zAJDi/Wgn3KjiR1CbGi52JMcDzkcrMIDiBAmso?=
 =?iso-8859-1?Q?PhKVienMzDrX0xBrWe13DujVoz2L6PHUn16vOKQPNDPKNcLfR3w7L0Gstz?=
 =?iso-8859-1?Q?pXsHfghMHjQbiAIR6jLanxlK5mPPKG2O513mk5D/xJa7HcOE8QVkYY9sEv?=
 =?iso-8859-1?Q?PnTwOmMKilcfPv2uI/xNgg0FYvW4HpDYcRwNM/k1HV8QA6DUWr8o6gf07J?=
 =?iso-8859-1?Q?mWhHTP7A0Zf8zxtUs0aw4CFwb8Hxqe1pE1OxvJQzvtDqCRg2QsPvoOUNH5?=
 =?iso-8859-1?Q?tKqWCh+kQgbF40/kcYCEYPHHFWKd6PShLKKhnfIt+m5MZW21zdnLKsfvA3?=
 =?iso-8859-1?Q?AfhpbkjSqSE1l5e8C0IxGmnDDRvihfsBAu8H4SuuiLPATGe3Zk3slnqDde?=
 =?iso-8859-1?Q?FRf8rCIpQ78B0Oc1AbLSPmMQzi4ldUGobyK1Hgo1gQL7CiVZtaZtP0HzNR?=
 =?iso-8859-1?Q?I3+egEveoMnI5MXFHgP6L5xaK/NPAHq1dIDcmNf2DAzobAfnC8E1oIXPJ6?=
 =?iso-8859-1?Q?07aD+MXZ2pIADC0SFBcHqlVl12hlJN4WG56t35CPoDk2oXh9k+xbQaOD97?=
 =?iso-8859-1?Q?a6H8CZ9JBc02njBZnCqkiTSsn6Ry6mejAJVZmkf4cK0MA2m96iU9DWzMed?=
 =?iso-8859-1?Q?Myem0TCwZOo2OjOrX+9w72NfYcQI0gRc/lYqcELaZiWGLgMVXKsy4Mb+m0?=
 =?iso-8859-1?Q?fN15Oj1LfVNa8yQDxiFeEI4AAbP9zSGhGA/GGzK2rmVdqJdeMOGZsy8FW8?=
 =?iso-8859-1?Q?9cCDhHghar5XKTvGMyAYeV9PX2JCf1KY2mBpAINaFcNe/vJjuaBwlfaR6V?=
 =?iso-8859-1?Q?gyhJVWZb42IZYrNCSqwemB+5jL/FjG4fpngG83/Lavw9rm5axNbkLoY09b?=
 =?iso-8859-1?Q?fgQGV00V84xXzX93uau7Gb7oOiSdvnnRDbUq+EbUxcmtGqzCuZNXFzaJFv?=
 =?iso-8859-1?Q?8zY8PgfiYbvd+7dZEVSgUUrl1WB594MlLk1M//8jl0qJxYjdCjbWFyG82Q?=
 =?iso-8859-1?Q?pRQ+YFWwhlgdQzNoOx1y2LwRhgQiJhtV7Y//DOatucSJDkNOvlDdqLqjtO?=
 =?iso-8859-1?Q?N2aU1t5OuQZcOQoZy2b7XLtesTHkDQdA/lZWyRgqxM9DRrHRf1LCOvtotf?=
 =?iso-8859-1?Q?qPHgBuq7xJPKy+1H3iQ/fy2eGtUCRsv/Gn0Uc9CZqxVwc9WKcSxLNjG2vb?=
 =?iso-8859-1?Q?Hz6+fXieQaUaEgJVOH9C4yuG16NMPgy4r1gRDJl4a/hs8jqlIMw2m8DktK?=
 =?iso-8859-1?Q?HVSaX0fFtZcfLDmUwf1qEFXQDr6Dyd762pGwHRuZFTrQ1iv0IuW1NSw7uF?=
 =?iso-8859-1?Q?DtrSR32n/A1SI341/MitxEXhWBeyvr/6mKHUMYgXMaTvW20aUiLXW8UPfY?=
 =?iso-8859-1?Q?RYAplNPhnjIha/zJVUNP+4lTn1TKk2YLSOUZ83qf/5dmE6G/njf6KfFZN3?=
 =?iso-8859-1?Q?lliOv1X4kchiF6HcuhTcp31BrAGJWB+LS8VnKoQpbdg9JEabQIqXvIRUHt?=
 =?iso-8859-1?Q?ATiYE3van4H0/lv/v+RSUNpb25Bs1jYq3e4Ax17CGxeeN/k1yfx6tYW+Nz?=
 =?iso-8859-1?Q?/UeG777iyU6bDNOeoyRH13S8bs9wVUw0ShPnymPflXhDR96rCmigzwzCn0?=
 =?iso-8859-1?Q?idmyttzPOPIRJdjpOdd6r8fxaHG/eCeORighiftU3uT0Rl0hXt5ivgAS+7?=
 =?iso-8859-1?Q?KfdzK2HWpnQciAeBnyqQe3YKWozUqFXvQF1IGHQhY5YsKEDvuAForqserP?=
 =?iso-8859-1?Q?RMqsp0D2bEX34rrp4+Vjqmug5GLDxB+s6bcU3KQBZ8o+bIR9ugHkM2BuSB?=
 =?iso-8859-1?Q?43rHPxBbbw=3D=3D?=
X-Exchange-RoutingPolicyChecked: o3lJ8F7IQVexoDq+tzOjLXAjh9KENdEcOpegdoDttXuyZmrIArZc9Rgtwu8E515sMhy1NUYXy6yPCUr5SAMj1s+5EI9DNbI6x3A6b+fr5LHo5yYySr/8FanQtpZFKQkDoG7QcmQZlq5syLN6G32YzotIBrKe+ApNpf7IwX6KOokVlXH+cPqo5NNDgsNb48NZF2NgEPUK58o5H6tKSs/p8JoDLUbj05u+O3poxxkJ2IW9/3zXYc5qUNyaRHpBjNpArL5HJXj5c5t8cvkEbtNUrrw7eiTQBT6rJdwP8CWNa3idJOypgufezHwazvJNOCNo/Q1Ao5xXj8NxxMLBrnfG/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc9ccac-15c1-4c16-c377-08de9165be86
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:45:30.9749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdPVtIMiXPjZ/6XsjkpCiSaNf/Khkklo83x1ZYA8M5W6Z+bL3LCIQxwp4u4TenBLd5QyH5GoO71F1h495OgZOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8607
X-OriginatorOrg: intel.com

On Thu, Apr 02, 2026 at 04:28:33PM -0700, Sean Christopherson wrote:
> On Thu, Apr 02, 2026, Rick P Edgecombe wrote:
> > On Thu, 2026-04-02 at 09:59 +0800, Yan Zhao wrote:
> > > On Thu, Apr 02, 2026 at 07:45:54AM +0800, Edgecombe, Rick P wrote:
> > > > On Mon, 2026-03-30 at 14:14 +0800, Yan Zhao wrote:
> > > > > > +	KVM_MMU_WARN_ON(is_frozen_spte(new_spte));
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Temporarily freeze the SPTE until the external PTE operation has
> > > > > > +	 * completed (unless the new SPTE itself will be frozen), e.g. so
> > > > > > that
> > > > > > +	 * concurrent faults don't attempt to install a child PTE in the
> > > > > > +	 * external page table before the parent PTE has been written, or
> > > > > > try
> > > > > > +	 * to re-install a page table before the old one was removed.
> > > > > > +	 */
> > > > > > +	if (is_mirror_sptep(iter->sptep))
> > > > > > +		ret = __tdp_mmu_set_spte_atomic(kvm, iter, FROZEN_SPTE);
> > > > > > +	else
> > > > > > +		ret = __tdp_mmu_set_spte_atomic(kvm, iter, new_spte);
> > > > > >   	if (ret)
> > > > > >   		return ret;
> > > > > >   
> > > > > > -	handle_changed_spte(kvm, iter->as_id, iter->gfn, iter->old_spte,
> > > > > > -			    new_spte, iter->level, true);
> > > > > > +	ret = __handle_changed_spte(kvm, sp, iter->gfn, iter->old_spte,
> > > > > > +				    new_spte, iter->level, true);
> > > > > 
> > > > > What about adding a comment for the tricky part for the mirror page table:
> > > > > while new_spte is set to FROZEN_SPTE in the above __tdp_mmu_set_spte_atomic()
> > > > 
> > > > You meant it sets iter->sptep I think.
> > > > 
> > > > > for freezing the mirror page table, the original new_spte from the caller of
> > > > > tdp_mmu_set_spte_atomic() is passed to __handle_changed_spte() in order to
> > > > > properly update statistics and propagate to the external page table.
> > > > 
> > > > new_spte was already passed in. What changed? You mean that
> > > > __tdp_mmu_set_spte_atomic() sets iter->sptep and doesn't update new_spte? If so
> > > > I'm not sure if it threshold TDP MMU.
> > > 
> > > For mirror page table, a successful path in tdp_mmu_set_spte_atomic() looks
> > > like this:
> > > tdp_mmu_set_spte_atomic() {
> > >   __tdp_mmu_set_spte_atomic(kvm, iter, FROZEN_SPTE); ==>sets mirror to frozen
> > >   __handle_changed_spte(kvm, sp, iter->gfn, iter->old_spte,
> > > 			new_spte, iter->level, true);==>sets S-EPT to new_spte
> > >   __kvm_tdp_mmu_write_spte(iter->sptep, new_spte);   ==>sets mirror to new_spte
> > > }
> > > 
> > > So, the tricky part is that S-EPT is updated to new_spte ahead of mirror EPT.
> > 
> > I still don't see the point. That ordering is not new, and this patch actually
> > adds a bunch of comments around the operations above and below the
> > __handle_changed_spte() call. If you think something is still missing maybe you
> > can suggest something.
Hmm, sorry for the confusion. I didn't express it clearly.

The ordering inside tdp_mmu_set_spte_atomic() for mirror root is:

Before this patch,
    1. set mirror SPTE to frozen
    2. invoke TDX op to update external PTE
    3. set mirror SPTE to new_spte or restore old_spte
    4. if 2 succeeds, invoke handle_changed_spte() to propagate changes to
       child mirror SPTEs and child external PTEs

After this patch,
   1. set mirror SPTE to frozen
   2. invoke __handle_changed_spte(), which propagates changes to
      (1) child mirror SPTEs and child external PTEs
      (2) external PTE
   3. set mirror SPTE to new_spte or restore old_spte 

So, the step to propagate changes to child mirror SPTEs and child external PTEs
now occurs before the steps to update the external PTE and the mirror SPTE.

> Ya, I'm a bit confused too.  For me, the "tricky" part is understanding the need
> to set the mirror SPTE to FROZE_SPTE while updating the external SPTE.  Once that
> is understood, I don't find passing in @new_spte to be surprising in any way.
I still find it tricky because it seems strange to me to invoke a function named
handle_changed_spte() before the change actually occurs on the SPTE (i.e.,to me,
the SPTE has only changed from xxx to FROZEN_SPTE, but handle_changed_spte()
handles changes from xxx to new_spte).

Besides, another tricky point (currently benign to TDX) is that:
before this patch, tdp_mmu_set_spte_atomic() cannot be used to atomically zap
non-leaf mirror SPTEs, since TDX requires child PTEs to be zapped before the
parent PTE;
after this patch, performing atomic zapping of non-leaf mirror SPTEs seems to be
allowed in TDP MMU since the above step 2.1 now occurs before step 2.2. However,
if step 2.2 fails after step 2.1 succeeds, step 3 cannot easily restore the real
old state.
So, if we allow atomic zap on the mirror root in the future, it looks like we
need to ensure atomic zapping of S-EPT cannot fail.

> > > > > > @@ -1373,6 +1396,9 @@ static void kvm_tdp_mmu_age_spte(struct kvm *kvm,
> > > > > > struct tdp_iter *iter)
> > > > > >   {
> > > > > >   	u64 new_spte;
> > > > > >   
> > > > > > +	if (WARN_ON_ONCE(is_mirror_sptep(iter->sptep)))
> > > > > > +		return;
> > > > > > +
> > > > > Add a comment for why mirror page table is not expected here?
> > > > 
> > > > Ehh, maybe. Thinking about what to put... The warning is kind of cheating a
> > > > little bit on the idea of the patch: to forward all changes through limited ops
> > > > in a central place, such that we don't have TDX specifics encoded in core MMU.
> > > > Trying to forward this through properly would result in more burden to the TDP
> > > > MMU, so that's not the right answer either.
> > > > 
> > > > "Mirror TDP doesn't support PTE aging" is a pretty obvious comment. I'm fine
> > > > just leaving it without comment, but I can add something like that. Or do you
> > > > have another suggestion?
> > > What about "External TDP doesn't support clearing PTE A/D bit"?
> > 
> > It sounds too close to "TDX doesn't support..." to me. I think I'd prefer to not
> > add a comment unless you strongly object.
> 
> How about something like this?
> 
> 	/* TODO: Add support for aging external SPTEs, if necessary. */
> 
> That makes it clear that this path is supposed to be unreachable because KVM doesn't
> yet support aging external SPTEs, while not trying to say anything about *why*
> KVM doesn't support aging external SPTEs.
LGTM :)
