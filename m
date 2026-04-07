Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0855139C00C;
	Tue,  7 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553245; cv=fail; b=uxK1QsFCPKXGythUkVuI1w1vo3bwbOxXbhqpUvJUYSrLPYjwKrXPywxhuKLCd2Sz47YK47XLDCSwYEpumcI3CMZimKBXOlAGwjVhbx64hbAKx1fS0Taud/rai3zGA1cgHVN+kxNTMrry5/hHR6+yQDhh0ccnJEovB+x7Ik2Nn4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553245; c=relaxed/simple;
	bh=XIP81ng4jaa1lw22HVVJDpwq09qKm/9+CRcgxf0DyBo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RDzRl87XQ+NNJBR0joxPKTzlt2OLj9f84veldGEJNUKtm4b/7k6wIGD2fZuaGNC4XPW2Aru9/t2h4C57qrMV6g0tcE6hSU1yKAdylnoVTXNmF4X+uO2fRNFx01pnCGLoGPFOGTZc2Pf3t9WyvEt4Z7aBzRsi2M9eTdwfPtT3Al8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AA8YN4iL; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AA8YN4iL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775553244; x=1807089244;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=XIP81ng4jaa1lw22HVVJDpwq09qKm/9+CRcgxf0DyBo=;
  b=AA8YN4iLOPPOPxmCx7tzynXaSNjL6R2urL0YBLo1jzntU0w33idRi8PM
   5LtkhS9tMC9fz+c+D3z4pe/iLEItLLJrnxqU1gvDV4Fukd/ozznnD5TME
   Z58TNBii9d2TIbs6F0aptkL3RphASnsNr8Go5GrH/UqqSM+sklIeHELn2
   Z+XivVqSGQyLnGOI8sjntRn/tQ5tGwx0HwGDH3H4R80CYP2fgSmkCRVls
   VPDZQTO6EXIkuMJGaZLbKPD28wugi/Qce4jLB4wJaFT+OIw9DvmnnntKN
   cNAIfE8xYa2gObgh1vmSesM8EiV8Sdgd83qTzzYt3CZl9H5a01a9Tdu/1
   g==;
X-CSE-ConnectionGUID: un25L+mESFaoIVehOY/8YA==
X-CSE-MsgGUID: ME0nzzzpQgWRDQRIhLgY4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76407878"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="76407878"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 02:14:04 -0700
X-CSE-ConnectionGUID: 4bvKlOUiR7+5f9W53rxnIQ==
X-CSE-MsgGUID: h8M0uwp9QKG1wxdS4u9x3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="225365140"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 02:14:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 02:14:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 02:14:02 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 02:14:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iklbDvxGTsRZLuDQZ7bX3sqYXJ4P+rHx//ZMdt/5c8GGAva9UCYA+h0OTAmgIcC2c2N0/JNwd5nlpFWvsazixvUilICQHLdPGkiPEXPXJp6RxEkcEnuN8Wl2yrvtrr9DuRhAW2iBkNyi50ltsrS7vYUmgDtruBCeW/vmd64mR3nUKc+eEsgUlp3dm62MnOyQocuV191vOlV5NqxEndj7SWm+zSWtw7pDYIKvdJTouzQY8r6mPdV2lLuUUrwsmJV96Ei9mPzJgLFuTguX5Nai8skqu7MYwBQAtQmlWW5780f0ZM/KG1vEZA+l8OfVo0orccQrVXsBuZcs2dFvNFzuog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VYABHYKNeXV7JoWsXFmJEmW+QN9HzLKgwpnErRnoNo=;
 b=Z2CtvVvfcrMtGmS+p75BLdMIxjqPKxw03fjR041oRLjEkYmEggEaIGRi+f5KnMCbxfsL5ic8T0Lkpqr1xD3mllhIoROM+C24Z5Mdy5r9GQ2DI1ZJZEHoy2HKKOrTNrrFglaEeqkkHgkDEV5bq69Y/VPA/9vRdoUAdoppCfTplIEc5uKKbdZF7aDLyU4ermhXD9ZoLAcQgjBREibBUhEm0kADlXmfvkLhc4U/vYYASZYog2bOztDGvYW6bROL2BdzxPp4WPE0rVkeVstqYq+srRatI5gdtRGLySNMPUs33mdC7fqlNqNMUODQphCofc4bpCChmB0N/rNKAqMVy7zRkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by DM4PR11MB7376.namprd11.prod.outlook.com (2603:10b6:8:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 7 Apr
 2026 09:13:57 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%3]) with mapi id 15.20.9769.017; Tue, 7 Apr 2026
 09:13:56 +0000
Date: Tue, 7 Apr 2026 16:34:16 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>, "Huang,
 Kai" <kai.huang@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Message-ID: <adTBiKPanE15vtjS@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
 <acoUt9vy8OPU1SW9@yzhao56-desk.sh.intel.com>
 <8a107d4da92d4cf910f9a70991a0e67b42e04d4f.camel@intel.com>
 <ac3Ng7IZpzJczZ2x@yzhao56-desk.sh.intel.com>
 <4dfb4c106c834cd13da78872bfb262e98581fa55.camel@intel.com>
 <ac77oSNltyE6vkVD@google.com>
 <ac+C9FdF34JRNLWH@yzhao56-desk.sh.intel.com>
 <d4319635e971e38534509b7424c6c08fa729209c.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4319635e971e38534509b7424c6c08fa729209c.camel@intel.com>
X-ClientProxiedBy: SG2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:3:17::19) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|DM4PR11MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a447808-9743-453d-b525-08de9485fe76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: b1E05SfOpH87sweBqbJjDXq9QkJHG6U/2nS6yWRvtIwzkk3gKhjlAyznNKo3/kuuaFOwaJEmPHEBflYafa6decqLCta4vDV3t789v0DIPtPaY93zTpbsK42XXWZV2F/CmWlPNB4oDe7wh8ks8VO5WOD3Rk6znx6sMhk5M+1SvBw5Y2vsCmxitNJit7hlkeLIGBZK6jGqx34ZkbjykWONB/8faO44QanPm/fnwk9bnAvyHnoAo0slQWB+v2tl+Te1nEjV9wXKyuMrxQREXo+GphI0RQaAzHTRajRUDA1zm5vNG4ZsQ5tUYsWFE1Jr/HF2JnlkKOC3/dLX566i/PpizdQ6xMDX9WS2GQDZL2hHcVwgLbvZghlO3EyeI/lx9MEl4QnSSBDSd+7ChWmo9CHwKDt01fooNH7l1HbKGScI0d68qnlqfkGTOmQfaM0ZW2SYRHJh1GPTPOKPn43cltrj6tkMGidIoIXqVODJmDrNkRvR/jGnMtJ7Ws69QjU9j646T6u5FPhTx4KkxeOJ+7aQyZN1m3jnjSu5g54NVG66mJIFuRz47agiRjwmNeHYYZ82MudWbi+2pnXT8qzf7WfGrC3/AouIAf7BVJpAqnkl1Qx/mvU6YcAcF4AEp9NvBJgIqxgmq4dlF0+92omlWe3/nbB+d/hL9jHVUmFRUNYXNtw9Lo2HRizQZZ7BvKUZGjSdXz0dEYJ/GV6OuPIGkRAavxAXNvbVJybmSQvux9EJeT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+2j2WLohMGhb8V9kv0df1KfXTxOOr8KJerkjNvU8IKRDtMgRUMhfwwY44d?=
 =?iso-8859-1?Q?7SNzez9Gh4PiIe75p2Vtrt3k99z6ZchPXbHAwzW1VZDLbMRnRaxLSt7TGs?=
 =?iso-8859-1?Q?QMelcu5uTykhndQX4wKkcH5cCs8x67GIUkAj+zr9GOx83rA+jcD9pSG0N5?=
 =?iso-8859-1?Q?rAkrGq5Z4k2VaVq1zh2NA1ANY3+QhdQvJEWtG3fzlrf0SNbDEx2BIxQHhv?=
 =?iso-8859-1?Q?/6fHRA4q8tK+sg4q8NBHieSS4A5oMJSOG1qcnt8f9keMJNZUqv+9otPNJr?=
 =?iso-8859-1?Q?DzODvpNC8+gxHIPm0T/AqSlWIbNZi67EPsyMR8tAkPYho6Cjkk6py1bhFh?=
 =?iso-8859-1?Q?Mq34tjyfZDpm+KdyIoXRT1rO3sgDjRHpjC+KeZxGuDnLqjaf572sk93bTN?=
 =?iso-8859-1?Q?DmGwv2ex7NmmWi10sPhpWbXRKhb1t4PIt8lQCizC7wks0ddOHIGf79f7kh?=
 =?iso-8859-1?Q?euxDGOldVpzTYNekwnexPVO/Tspxz82wDnM/vizfqnvqW9Vz/bw/3Fem8v?=
 =?iso-8859-1?Q?lu52BvJ2323GVd6tVswMYbeIQVnF+6pQNlwOuqmMcVsifz5eelPA5yLiSE?=
 =?iso-8859-1?Q?65OJG3fg3ZXnRE4vqAfmFM+ExF2505984MZvtjUK3jPmkcv+8pRvUoaxlM?=
 =?iso-8859-1?Q?5rN0xcSHzl3DfLZfTpgJegMI1mRZV7N08+r5mmZLQ7jkNvaZ6Z+xN6Sear?=
 =?iso-8859-1?Q?CiChVKs/tmeMLTtHlldbBsbmEC244nTKUqANwIJ1mnskP4rlexXoMmssQK?=
 =?iso-8859-1?Q?MDo2UgwY86gvMKY/VNZvlNozX1vQs3tB17J/bqPXkgwh+wjCxZl3ES9Qg8?=
 =?iso-8859-1?Q?OlrLSesZ1X532vKQbEh52sKdCo35vlff8CX5JH3U9qphHX+SsJriWQ0O9Q?=
 =?iso-8859-1?Q?5u8O6sWd79ObIPeOz+g2ge4o6BxE1Rp0j6y0xpj7+uWX3yX7CYTmP2nrkl?=
 =?iso-8859-1?Q?zpPkh3hhbePElXJ5hR+INOlYZZVGvQqyXBwRdzpDrjG2D2qzlo0hLpzOwO?=
 =?iso-8859-1?Q?2+O3BAwe0i1X+pKghWLXyMbev9L/cAAokwDjD3aK07sOKaA6uGvcPoQa5L?=
 =?iso-8859-1?Q?zQQZ78TpdVyim1cacSkF2fV5g7I3MNyNydVrcWCQnQKKNq2ON1OqVBCYtW?=
 =?iso-8859-1?Q?hJ402bVCBUBTdmmxo0hMLdfbPwcGi/w+14iEnpXo1oa9BXBunpkrTVwHsK?=
 =?iso-8859-1?Q?1Pbe4J0SR22nPfOqToFtpC2jmUXhV7eJkuHWCSNa7Df8S/7O/aLPSLWSr6?=
 =?iso-8859-1?Q?MgZ7VIHqSagSPc6EOb61AWqz3oaumkGnjnh0noyfNBjAbtpsA3wiWpfEOJ?=
 =?iso-8859-1?Q?Ni1YtGbu1Usx/h0i0cumc3eYLp9Rd8X1jRTI5HHjtrX3kqTgpK12Co9eTv?=
 =?iso-8859-1?Q?tA7ZMpDC3mtrVGJngN0T/qM27pw+UMiua02B4XQvpNE54uGkFzODveQ1q4?=
 =?iso-8859-1?Q?9CmDhJqkLSm6KeMXB8R6C+yAq/2vHJdxkc9pFIv9vpjsEuqo3XjNuEUQ/C?=
 =?iso-8859-1?Q?h4CfQ3qvIXjyAmyL6gC9wRkmLO/Is5DWCAWU3wgCHKr5IXJX1FGLHCcGDG?=
 =?iso-8859-1?Q?WZPaykHs6ndXcMDF2wPjsTWkRJd5Npd9MuoyqntITt2v1+xQJ2KI/KFWfX?=
 =?iso-8859-1?Q?D35QlTT8eqTHTPUShnXhI6wWBYSQjv3p4KoajPIXazQkK2deCoUMgXs2A1?=
 =?iso-8859-1?Q?nZWOlbd2Q+EzsvsZylTcMHjxyOxXHo/OqGsZtVJclZ9pYdK1zBe4Tp8Ajk?=
 =?iso-8859-1?Q?7eWMuvY6dUF+8WPq7mkf14u59O91EnniNtXNLfw14mhfRczH+9uXvYe08m?=
 =?iso-8859-1?Q?i8a5ge0TRw=3D=3D?=
X-Exchange-RoutingPolicyChecked: Sck5Rlfv9aR7LZBbge7nDGtZFmD9nRfuhPwcC/Wwvxj47dNuGEE5HSMMA4D/snxhQ5V01L4eIqv83LPEir7xLBNC3w9uhylvbrjmrjFFJ6m4aSjW0xwp70R70PzuJrFkyqU9gpqDueTBnvHE91GQZXVrtJ8D2XWgiU7VEIsiTo/awnCtLRNWrY/xfm7DoxzgWH3awBWZfLZaAA+e9srWY0P5vda1g5Nmu74U8MyiPip1RiK7koB4is32MlcWNoS3BFsc/cPccrhHYNXxZJ5YRZy1EagX8ikrA/I/Bblnk0MaWRW1urWxUNVdN2YS+wxNPghU//wri4TQvfdyr8V8qg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a447808-9743-453d-b525-08de9485fe76
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 09:13:55.9503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgPOYL/Fh2fm//w3xnHOZ3Hh0ZHi2MOkuUPIkRXKKI4Q1wBLFhGsDyaSDH1TlYfSWHqYDj/l1A7KdHEChyHA7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7376
X-OriginatorOrg: intel.com

On Sat, Apr 04, 2026 at 08:15:16AM +0800, Edgecombe, Rick P wrote:
> On Fri, 2026-04-03 at 17:05 +0800, Yan Zhao wrote:
> > Hmm, sorry for the confusion. I didn't express it clearly.
> > 
> > The ordering inside tdp_mmu_set_spte_atomic() for mirror root is:
> > 
> > Before this patch,
> >     1. set mirror SPTE to frozen
> >     2. invoke TDX op to update external PTE
> >     3. set mirror SPTE to new_spte or restore old_spte
> >     4. if 2 succeeds, invoke handle_changed_spte() to propagate changes to
> >        child mirror SPTEs and child external PTEs
> > 
> > After this patch,
> >    1. set mirror SPTE to frozen
> >    2. invoke __handle_changed_spte(), which propagates changes to
> >       (1) child mirror SPTEs and child external PTEs
> >       (2) external PTE
> >    3. set mirror SPTE to new_spte or restore old_spte 
> > 
> > So, the step to propagate changes to child mirror SPTEs and child external PTEs
> > now occurs before the steps to update the external PTE and the mirror SPTE.
> 
> How about I add this info to the log. I think you are right, it's an important
Ok.

> change to call out.
> 
> Now it's making me think... Can you (if you haven't already) scrutinize for 
> races/reasons that may trigger the KVM_BUG_ON() in handle_changed_spte() due to
> BUSY or other? Like in the handle_removed_pt() path. I guess the write lock
> saves us?
> 
> Hmm... zero step?

Below is the list of all handle_changed_spte()-related scenarios.

Legends:
NP: !shadow-present SPTE
P:  shadow-present SPTE
X: Yes or No.
shared: hold shared mmu_lock or not
valid: valid scenario in TDP MMU
mirror root allowed: could this scenario occur in the mirror root (after basic
                      TDX huge page support)
KVM_BUG_ON() hittable: is KVM_BUG_ON() in handle_changed_spte() hittable.

Scenarios 1-5 are for mapping,
Scenarios 6-10 are for shadow-present to shadow-present transitions.
Scenarios 11-14 are for zapping.

                                            |mirror root| KVM_BUG_ON()
 # | old_spte  | new_spte  | shared | valid | allowed   | hittable
---|-----------|-----------|--------|-------|-----------|-----------------------
 1 |    NP     |    leaf P |   Y    |  Y    |     Y     |    N
 2 |    NP     |    leaf P |   N    |  Y    |     N     |    Y (a1)
 3 |    NP     | nonleaf P |   Y    |  Y    |     Y     |    N
 4 |    NP     | nonleaf P |   N    |  Y    |     N     |    Y (a2)
 5 |    NP     |    NP     |   X    |  N    |     N     | warn !mmio_spte && !frozen_spte
---|-----------|-----------|--------|-------|-----------|-----------------------
 6 |    leaf P |    leaf P |   X    |  N    |     X     |    N
 7 |    leaf P | nonleaf P |   Y    |  Y    |     N     |    N
 8 |    leaf P | nonleaf P |   N    |  Y    |     Y     |    N
 9 | nonleaf P |    leaf P |   X    |  Y    |     N     |    Y (b)
10 | nonleaf P | nonleaf P |   X    |  N    |     X     | warn pfn_changed
---|-----------|-----------|--------|-------|-----------|-----------------------
11 |    leaf P |    NP     |   Y    |  Y    |     N     |    N (c)
12 |    leaf P |    NP     |   N    |  Y    |     Y     |    N
13 | nonleaf P |    NP     |   Y    |  Y    |     N     |    Y (d)
14 | nonleaf P |    NP     |   N    |  Y    |     Y     |    N


Currently, only 4 scenarios (a1),(a2), (b), (d) may trigger KVM_BUG_ON() in
handle_changed_spte(), but none of them are currently reachable by mirror root.


(a1)(a2) May hit KVM_BUG_ON() in handle_changed_spte() if
         tdx_sept_set_private_spte() fails due to contentions. e.g.,
         tdh_mem_sept_add(), tdx_mem_page_aug(), or tdx_mem_page_add() may
         contend with tdh_vp_enter() due to zero-step mitigation or may
         potentially contend with TDCALLs.
(b) Promotion case. Currently unreachable in mirror root.
    Need more complex changes in TDP MMU if we want to support it in the future.
(c) Will not hit KVM_BUG_ON() in TDP MMU, but will trigger warnings in
    tdx_sept_remove_private_spte() due to lockdep_assert_held_write() or
    TDX_BUG_ON() caused by concurrent BLOCK, TRACK, REMOVE.
(d) May hit the KVM_BUG_ON() in handle_changed_spte() due to failure to remove
    child S-EPT entries and will trigger warnings in
    tdx_sept_remove_private_spte() due to lockdep_assert_held_write() or
    TDX_BUG_ON() caused by concurrent BLOCK, TRACK, REMOVE.
    May also trigger TDX_BUG_ON() in tdx_sept_reclaim_private_spt().

> > > Ya, I'm a bit confused too.  For me, the "tricky" part is understanding the need
> > > to set the mirror SPTE to FROZE_SPTE while updating the external SPTE.  Once that
> > > is understood, I don't find passing in @new_spte to be surprising in any way.
> > I still find it tricky because it seems strange to me to invoke a function named
> > handle_changed_spte() before the change actually occurs on the SPTE (i.e.,to me,
> > the SPTE has only changed from xxx to FROZEN_SPTE, but handle_changed_spte()
> > handles changes from xxx to new_spte).
> > 
> > Besides, another tricky point (currently benign to TDX) is that:
> > before this patch, tdp_mmu_set_spte_atomic() cannot be used to atomically zap
> > non-leaf mirror SPTEs, since TDX requires child PTEs to be zapped before the
> > parent PTE;
> > after this patch, performing atomic zapping of non-leaf mirror SPTEs seems to be
> > allowed in TDP MMU since the above step 2.1 now occurs before step 2.2. However,
> > if step 2.2 fails after step 2.1 succeeds, step 3 cannot easily restore the real
> > old state.
> > So, if we allow atomic zap on the mirror root in the future, it looks like we
> > need to ensure atomic zapping of S-EPT cannot fail.
> 
> I think we shouldn't comment these kind of TDX specifics. It won't confuse non-
> TDX developers working in the TDP MMU I think.
Ok.
