Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF4282F05;
	Mon, 30 Mar 2026 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856465; cv=fail; b=k0tk+HwOh4dWbtMOz9V0JFmbpTKDjua5wOsWGcCpJ1epy0QkVQFc8rPrrHGufa5LxYHFl4EtkfwI4jFFQedn5RvRt9GGASh11aYpqydG8x9RGnZZ9e1I4WqIu5yIlQRYNVHoAafdUfFH+370nCFz7e7k1njK5kyx17TUhtM04Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856465; c=relaxed/simple;
	bh=GdhZYwqQiShqPasl+PCmoaypSLBfGvUeTaGf57MntUk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dbYK/3Kx6cgM7vWceRXzUQPa3vOCChw/WDMFuIi4Dpg3CUMJBSoH37+lHmJb4BZGsNmpiu8+2yIcdkZ4u4tO+QpJDpp5Ou8KTLe6AvJK/bHxDbenxADxpfVyRPsGJ0w0a3g4L1cx9i1EBTCi1ni7otuC1CBj5XlHw9zZ6d9ENe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K1VbXNMr; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K1VbXNMr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774856465; x=1806392465;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=GdhZYwqQiShqPasl+PCmoaypSLBfGvUeTaGf57MntUk=;
  b=K1VbXNMrHgow8cPEl7pS0Tcol7W60lNdvBpJCiF+14BaKfZGDwA8PsLI
   eMJH1n/6nhS9d3oFtvQJ1tTh5LDY2aq+CxHKBELZL6MIrkN6Dv/xOyKHI
   MTcVIi+6tD+zU4F3aygD/nDxs+rTMhynar0HzsRH3bQtS0PjaAefOY9XL
   wlWtnzSVRAcnyOJHc9CVEnLEojfXQ/9pwcLoJnosCB2NmM8hdpQQRcQIi
   6ti0ly1G5vTd8jCNzl8/8WO5nd4qrrLmBcwClJ5YxCXhnf/oiYEfaHz/t
   XW36sDsbOicGgxFH3mrnIrdoq80tZ1FXo2LNsqz9tE6BYUNfH+Z2M4gVz
   A==;
X-CSE-ConnectionGUID: utPvJ+S8Q6CwTdXLwc3h1g==
X-CSE-MsgGUID: pUSfQSfvQPyRb7+EE2KRvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="86145115"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="86145115"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 00:40:55 -0700
X-CSE-ConnectionGUID: 0Clg1RvES+u4PKZOJxRiBA==
X-CSE-MsgGUID: cNt4MP6hSdKXQHYdVZG2+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="230444115"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 00:40:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 00:40:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 00:40:54 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 00:40:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPwGN+8xeZYi0gC7q4x7uon+QQkYhkp9m7FnzfKhV4JT3AF2jfI84LYHbiD1zh/g1zm7Ucb5XdtGRdqL1597BIc85DFjVa8xWfKGn+JtrNFwXNALuPq234mKHBTWSRZuElfN1SxTA1jYpr96gR6GwhJYqZldfcTtW+9uFeFa/QpL41x+LRBQ9KuU9nxG352RekmfqqNzOXau8C3f5AjNjMbHnL4jkhEDfsjdBJJsU3cv4U9uAWXlO1jSaItnTxwP/ol1sNiSo0XmBFcqKUjYBzZsq81YItxyQvs3JAgG9ixSdnUUJvfc7bLIcB0+h27/ECSakLWIbzL9jZMCpBdPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVmw8m78SBvmf9LHlTOwcFXXA79tvwaTHEcuoC0O6Wo=;
 b=P1vRz57O6ZPOE6rOpW5qwtACY7cjpO4WixPrg7UnWRnKB0uN9GwPDun9P8jvzqJCVe5pduWi2lb1eJuz2iI1uF6/eVax8Odoj4LnpgTuL+9iGCH6R1cXDEeTZ8wzN0idr8vTRJu5Op1NkrrSYbqJE92YzhHXrMaGCz5cVr/XXwB1YFixYywRj+soWvz3Q2ujzhd1ktShMWXj2ZBGmoDgnls7a/pRljGkb+k29H9PK4zPAGCP56Evr5vBiuY2i6JUzHk4qLCfPnqT92K7bH3P1Y/47sJA63Jtz4bAO6GSlyJRxTCdz6EpTR+kcVSJDRAs44vVI51mj035VfDM0fFCNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 07:40:50 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 07:40:50 +0000
Date: Mon, 30 Mar 2026 15:01:17 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kai.huang@intel.com>,
	<kvm@vger.kernel.org>, <kas@kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <dave.hansen@intel.com>
Subject: Re: [PATCH 14/17] KVM: x86/mmu: Remove KVM_BUG_ON() that checks lock
 when removing PTs
Message-ID: <acofvYU6zlzeF6wf@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-15-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260327201421.2824383-15-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|DM4PR11MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 516b16df-3db5-4262-0d8b-08de8e2faa69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: XtIuh9tQoMCP8zfTsARdz048r5qDfIuqwhbJOkx7uH3EUZZwPUVhDroIuFK+K8jBZHMePXDuvAy+ZVHVKAWtCDy4pA4K2184jI6stMHuzYvQIGaoVS4Snstg2B0VktcI0JsGb8qN9EILU1xeYCfT5xQTicR2NwrXfkQQ1Q6iORf+sOT1DIDpQqB7y1EPK3TvncmyTueioT7BrOPx05397/0WPVcZG/OH4ZqMdjvd7VY6jmU4fgTOLPcb+6XEdEZWJJD77eZM8TLRYXWb3rB2INAMlzkO7wx+sfR3R2oaq/FVw/u4ffTjQOLJ6B+HlUOnjjbjq3jtl3hyhuWLwJpALv74hkTTEXSgHdzMRQT9qk6WxcTFZWeH0OoSOvr1yXdlhv/cYBRtk0zR0CG4QW/BLnpah3YqEEgvUZY5TbyGqHL274RyHK3BVV9UczhyFW8ufXV6F05Rbv5J3DntfSdUKWYiQhgM2wmOWID7XCD/Wy9zKAed2PrBvjE6HcJOwNxtwYWnrxiFAxe33lTt8HxvXi8mSOM6lJgetirUOFCRorTO6bxK63DmR4RSjnQ66qR8pQDv4VHBze0se3kZMf+Ul+DpSZ3cVo1XaQOrNxs/GKXGWZYRaCz+6vPHq/wqJ6Zm0c8/eh5feY168wxqDs89RJOvZuNVsfuDLkO5cd4af4GdMEpYnYOH9Xmz+NzlHoChZLRoPoRkV8e51wJsk5aLPp4GxqdVLwczI3XRtBfHrqB/jTLU7KCzSLgZ6sjsJ+LK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AKLbotUeidMYVVPSQZTpXNSvU7bpFlILmrWMqhzUW1OjKNyWg7PdzQopEH43?=
 =?us-ascii?Q?G24qR8rpMAr1HSnJbGwbfaWmJc4ouQZEK27RtvJH/2ByoPvP02t9z35QnWOC?=
 =?us-ascii?Q?b943Nr65Z4Ww4dt1JI36QZIpaVQCAO6cAZI2sjexF3dw8euHE91VNcMoa7D7?=
 =?us-ascii?Q?dOccM/G4Z137qso6kLahVlfE2HV0Ntadt4SJW7/EnnpNsuzl98Y3YL2DXbOl?=
 =?us-ascii?Q?ZsBY2AK++4DlTvTYNKQbUjtY1Yc0BbtGHgsrmP2BJJfGkPNPALi67mVSpB5A?=
 =?us-ascii?Q?mEQeEck2VxRUXFMu8h6m29yDp19hDAnFFu3vPu9RbfkUeE2zCoINuynLJXmD?=
 =?us-ascii?Q?Adq0JmHi7e50IENIj2wQU4Gfg9YCoOhhadoMx6lYf67/oraEQAfqr39MCr3S?=
 =?us-ascii?Q?S7hDG0Eu5GvUOpmMFW35Ce24v/tvKYJ2CCVxicaxUFKpORZXpYd1yvUczZYp?=
 =?us-ascii?Q?SxXPPWW8kCeUl4O7qRbdHp1V5oSVP+q79/auzMPQq4ORXKMy0Kjh9kxqS2Wb?=
 =?us-ascii?Q?raViuKpM5+qtUFdnnhTgFSG+m5/o4ycsPhF+zmGMghs0Sj2ikqjwFI6Zdwjr?=
 =?us-ascii?Q?TnM34aXhXe1Pbll1NC+yDJyXIuZdg/mVp8wNCnh8I2A0Yx19ZcaD0c0vEUPc?=
 =?us-ascii?Q?sKEJ/+6ENU+tiRzknTLVDQUrRvMVsS9NGFxGZrf/uP6fXwEjnvz8ncOTosqS?=
 =?us-ascii?Q?ihNiWkB5u8fXOHAoUG3jeMkyhMii3BBy1V2HPAmONisNm+OdRWdx3prrncfa?=
 =?us-ascii?Q?cDJ3SXrF/yI+etAm9Rx5vPKnZCOFoEZkyRE+k6IP5bwXE9XMtiEplnyrI+5N?=
 =?us-ascii?Q?8q+kOJFuTkVYKgVOSZprtNIFd9nM5SuawtdC6O7moeDPwBwUemT3f/t2K+a1?=
 =?us-ascii?Q?co6ZsPIDZ1/AwGdzRI1Y7lRDhQrli5I7tEXPy7H2JZTepcUTrsiFNf7lfCUS?=
 =?us-ascii?Q?NsoXkMMENVvuFkGmo2sboeBOePDecQU5tEvebsuDOMJpGoV1x1foklzWTZso?=
 =?us-ascii?Q?lC0D/5lmcoYdqgVEKZxeSoj55UoGdyUyzeBEXZ3KVksSRg68O9sFYktqyuBY?=
 =?us-ascii?Q?M+NJo0wfs+EPSyo0p8mwenOlO0vpqHy374amJ1kGz4YYC7Jw9RFUWFuW0HPh?=
 =?us-ascii?Q?5Dt9YtisFKpxLN9HO0brTEDaBsMqAdCvFAMcLPVwsqW46gyJVq5S6xrUY/R/?=
 =?us-ascii?Q?o33WJnkdRyokpTVjJN5yVUqVVVt/QW3tU1wOYSD7Eq+oKiyWaT0wWjCsG8mE?=
 =?us-ascii?Q?ChjznDDRQRKzN8yimEw7bc8NQlqaOWrMx55Al847xhRMEXzhoIH2XRhPHi8R?=
 =?us-ascii?Q?7kn+yG2Fvn+cNM6PJi5uPH1PnfEi1g3PLB72rDhH+HzqU+OtHw4ouZBDZWPN?=
 =?us-ascii?Q?zQ8h+RazU3AS2sYuj59Q2ek+SCBtpNOuFC2dwNhOMAuusvLYmU8rtLbb/L29?=
 =?us-ascii?Q?koo8G2bi8gei+cJVpYpvAmREU1anZvv32ZVJwKO04uveVIVIfnEv7HL7LnBG?=
 =?us-ascii?Q?ZiK2zJjMQPFQZVkbCNZpQg3fLgrtshcp9q3ewb8SGqIfzzq4AWUSMLtBW7VE?=
 =?us-ascii?Q?RdK9ZertbkkRVtEt9tC/N8ujRiEwX1GagLEvlZLHR1hviw9dgFAZpQ9z/cHy?=
 =?us-ascii?Q?CApwPA/WY400xdlb/l3Pj+8wokmsxz0JrKT/e5w7xYGCAMQXicoiFlxglMkM?=
 =?us-ascii?Q?WvLtjtLFrA85NWsWhDlcC3f00aYxlbeVr6HOrgkPc8xHE2c9iKhb2uL8q4HL?=
 =?us-ascii?Q?JcVW1aUDgw=3D=3D?=
X-Exchange-RoutingPolicyChecked: W+PAwl/ywU1+1D2AikELyCW61jY5CpQWazsuw0gOiCkFv2wPKhImDH96S09D8HAT8s6d4sxoRDE6Za37gTXc3Kico4n/ygO2nmSPAEIN05gufrhYSbdMHXpkHRRMnfaeDyQ4tajgjtEk+j3th0yFRRVeZiFanUNNo1csGaFWsKsdxcvQl59gPbHu2S0dX1WvnJdQvvv3HhWvDyqmHVf+0ZfiQgqXnoZrR9RNQwrT9CqJfFdJMFXk1l9rtOWrjTUuJDsWCm+9JcOT5rKyORHuKGbKUHKASEeJws2dFAUZqzZ2IOflTEYRUZmr/JGsdC8TZcki4EKytcjhVEhGJeqzLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 516b16df-3db5-4262-0d8b-08de8e2faa69
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 07:40:50.7882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmV/U8LXw9goM+8Z5Uyf+85w3AGFNf6dNyWuwiWNcwYgG4rDAgh3P32MQifOcQHCRlxkeJxG+PnMcSFh6Q4ksw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8179
X-OriginatorOrg: intel.com

On Fri, Mar 27, 2026 at 01:14:18PM -0700, Rick Edgecombe wrote:
> As part of an ongoing effort to move TDX specific bits from the MMU into
> the TDX code, drop the KVM_BUG_ON() that checks the MMU lock is held for
> write while removing page tables.
> 
> Future changes forward PTE removal mirror EPT updates into the
> set_private_spte() and let TDX code parse the PTE to decide what S-EPT
> operations to take. This operations does not pass a shared bool for this
"operations" --> "operation" ?

> KVM_BUG_ON() to use in the logics future home.
By "in the logics future home", do you mean "when this logic is moved to its
future location"?
 
> But even today there are already MMU write lockdep asserts that mostly
> cover the case. Since the KVM_BUG_ON() is already a bit redundant, just
> remove it instead of trying to plumb the bool into TDX code.
> 
> Link: https://lore.kernel.org/kvm/aYUarHf3KEwHGuJe@google.com/
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 991870789863..5dc9633c866e 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -473,10 +473,8 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
>  		}
>  		handle_changed_spte(kvm, sp, gfn, old_spte, FROZEN_SPTE, level, shared);
>  
> -		if (is_mirror_sp(sp)) {
> -			KVM_BUG_ON(shared, kvm);
> +		if (is_mirror_sp(sp))
>  			remove_external_spte(kvm, gfn, old_spte, level);
> -		}
>  	}
>  
>  	if (is_mirror_sp(sp) &&
> -- 
> 2.53.0
> 
