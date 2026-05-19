Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3539405C4C;
	Tue, 19 May 2026 02:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779156935; cv=fail; b=btHeCcYWkBeB5cY4xVcyIwnyHWxq/Pgm+ZDcA7WBXBYuzEB1ktWLFUgrvVT4voxJjZugFsnJHLFR5Uwh8zalXhCU0Jo00Hx6tasgKgPKP1B1Wa+VQGL48Orx2zVKo67wcGdAqIGeB97KlHAY8vWwiTzhq2fW0E15eitheK9Mw5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779156935; c=relaxed/simple;
	bh=IsoXXINzjVMpkdhFk3IMfvk0RKFYQGyfKfsdcUOv1Vk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tubawv82Yk6EyNtwx3Datvrx52ePPianscOoNSa2Q+aTBDAwj10iG1rxelnnhZxXHdGFaCdqE6SiXvlZOxlyyRLVi+K5fD5lanCerHUeBFFkfyrB2lTQhqIYVCCALvT14KZ5Ucugu+SzzgCH9umdS83wh0yCYg/ChopcHjYTqz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZDZfE79; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZDZfE79"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779156934; x=1810692934;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=IsoXXINzjVMpkdhFk3IMfvk0RKFYQGyfKfsdcUOv1Vk=;
  b=dZDZfE79VwsP8ZErstNRe7uDuHDx1AsXm5eg4/1t6tEoKJCBRruyWs0p
   Gm1goAwT6ITlthhs2jBb4yuOzcOQ0saT/sP8oWsPUcJX335aEStEBl7q/
   Jctrnkj19YdPI6PuPq2XpCQg1alX05E8TYZMYAI9fWS2PsM/1ogltCh+1
   Tk00JaxSYjwMZSs/dR1TDMuyKkCwm5Ll8I2/qWB9OPnaxgySfUK9qWGRy
   r1IbPu5ikEOokWNJ8cDtOvSpdCumJ6FP60vkoBvN4/kWzmFh26+2CiWKH
   rsBhYMFyLxfJAHvBob5t3lWIiqFAgHm46N7oCcCHjISr0yhZGCC+uFoZO
   Q==;
X-CSE-ConnectionGUID: t7WDFDchQC6GKpX8AdBAgg==
X-CSE-MsgGUID: jLRJS9a1TeGhHffGPXtnnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="83881302"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="83881302"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 19:15:33 -0700
X-CSE-ConnectionGUID: rR42/gBhQvmvjpjodKhL9g==
X-CSE-MsgGUID: bT6KUF7fS+S+AaIadPTBoA==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 19:15:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 19:15:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 19:15:33 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.62) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 19:15:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bz7zfKtA7qckbN4QB4j3rWFgSqIrhmsMaIj//GnH1L0wCUG0O8F10fYAwW+zZ/wUHNJCJRxkYS0H3E65Cw9mF7whwGUYqk+bQT+CnsQg8dh9/eAMuaUG86mT2HDDlwulIzRoe5wYul+hsnWhXyGG31huF2muwZtQ0QwxFvrpC0GdoB/kdTtpLAD8EOFN5B6CR1+28h/OQ0zhbz81zbV71a6yyNpC+9tou+8M0Gwt0+yn8W+pubpUXQjJxgC4kTKeDaoPaWReSBxvWfDlcWgt/5YPvtZOxBikfdvrbqNIuPDZyYnJW3FIAsEnHYcMqt47D1xboKp6Y96kuqXtZnpDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hg8YgcHhb4O/Vul4xhFumpCJWhygKhFGbZNTZ19rKP4=;
 b=dWV9G+KKGsoN1bayHVRxrPzMi4LxJFI2LcfDVDN2pGS5v5d2easKqK/Frl9r+JhPYYrcD2MtXV05pKwj9czLX7hAmzu8lGEd04IXj2Vq2AGNpAWmqi2J5iMZzkQRQ8+tdON5rumHBFnu6305/NEugT0+ob4js3o7TjErqmCEL6HojRIoLh5zTTNS9YJGOG1LNJL9yI/AZB7eVzQBEwPVm6Dfc/mF/LZS0XncPhwYwjyDX9U0Veuvs+6q9wBjXv2Gjxjp0YtFaENEEVJydSGAJeoSfURgCCIuvDLpVJ7P84EpHB0TsIsgXiHSxLtCihZeLSb7Euzo7j/OsMpsRkRTBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by SN7PR11MB7668.namprd11.prod.outlook.com (2603:10b6:806:341::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:15:19 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 02:15:19 +0000
Date: Tue, 19 May 2026 09:35:14 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<rick.p.edgecombe@intel.com>, <kas@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <dave.hansen@intel.com>,
	<kai.huang@intel.com>, <binbin.wu@linux.intel.com>, <xiaoyao.li@intel.com>
Subject: Re: [PATCH v2 09/15] KVM: x86/tdp_mmu: Centrally propagate
 to-present/atomic zap updates to external PTEs
Message-ID: <agu+UsizlbUYsjp6@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260509075201.4077-1-yan.y.zhao@intel.com>
 <20260509075634.4274-1-yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260509075634.4274-1-yan.y.zhao@intel.com>
X-ClientProxiedBy: KU0P306CA0055.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:28::17) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|SN7PR11MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: eda3de70-5993-41d2-290d-08deb54c7975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|11063799003|4143699003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: bQsd/GqbhrTQAkhEBhXdASlZS48z0qukAsyT2Esf9m40aMyFuf9BpTPgiTPN0I3p5gaYsixb3Y4FZEwgK5QHHW86Yxpn8Zwabfc0RLs0LSvI969HolkLiQYUWN1fovaJwQpqlmmkeKEsip66uRs+NHpCf1ln3UCmqfLulfbtzH/V2w5VTY0p0/XgnSCXGEpgoUNUaYHJ0cSaBnFwwn7/+roedJCXcjAtCLSsrCEuJ20IKXP14ywmhMTIp7M1ZjzXqUFKlV9/TNC4pzDYRPv2UIiMohXeGTP3UlHpjiizr6eRnj46o3wkvkZEJBVLeh2LB3i2fEbxm9jHDNns2ESODJVUZatw7n/Dk+ZzgH47b0OuXRthr/jDxLRX4SQXPvdfYGjAr8H4XcsNpwPY8LMISk2l/nW1gl2DXWE4xn1+9Ymv45UHrJqhXYgLkFpijRd2fB5x/fJZOQLTVmKNWR0g0soxzDUcvN6Jt70iEJSx7gYOkRxHbp+Z8zJe7lGmX/tYCh2VvLYIYUPbr6nDYKQ6JWRRNjF19LYlx7OxsnByIeXVsBoEpQo/p28AnblN2+yZ+7BsMZUeWkX8BtKde7aJpHOnvIPhf1qNRnC0jcyi7Rlq16BExfDri/XsjIC5zSbZWhnZLfgnTkYbxJ4M7P93+MoxKefmcpq9Scm/kIG/8tzA992XxoC+lodzKwS6v59w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799003)(4143699003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l83w4L/7AWCS/Q+XT/JQH78rRxMbdwz/l5QImwKchPSB7lZNLZevvd/mJgUJ?=
 =?us-ascii?Q?Tbi63BRS87JPJrb31X+6MN3df7P/hUL2djkEvY/f8Ph9ZCO9uAoqlsyyycJU?=
 =?us-ascii?Q?d+waQkGUxnQHiLfsLntp+jlWLLCy/4wagbllH/9X1VhlW+dXInk0Q77ir/78?=
 =?us-ascii?Q?FuZxjqsu6SoWxEiMDsz6CV45REme5q8ZWCAnk5m0Agc/4AmOevO97UcmNJSt?=
 =?us-ascii?Q?Z6VHKYcNZhWTLC8YoRJBvHxfkkR8slyVMLRoGW+sqT8F9AYbGBc4oMvaQjwr?=
 =?us-ascii?Q?qYNzodL2OE7AmKk2hldj9lEHB91xLikdMVSMPD6L88LWrxmGXkwEtO4ADyWP?=
 =?us-ascii?Q?84Hco+0NTqiWOGqKuExTFeAdm8hi28DaKWbahJpoIns6MwZNWf3uW7MxEI9S?=
 =?us-ascii?Q?HVWzmr8us6DKO17huwTC+wJ51jf2Cn25LssKVYubhKkyJT5q1K9aHiEYwKt2?=
 =?us-ascii?Q?QuwrhYzr5bt4xJQmoralp6h36Ie9io+1baJwhdVssMSgohaXXBI2xrKNW/Rm?=
 =?us-ascii?Q?NnOXI7BQ91+4y1MRTVhj0ZcuSnyAq7DsMHSPj7ZgX68B8t1LR+v939NHxKOR?=
 =?us-ascii?Q?thKODW2Aee57mSbPKS/DZIGFk/2a7kRrp3dnelsLWQUNxfBNRkZ6Y6iUArDW?=
 =?us-ascii?Q?ZiGTxa9n3ZiQIHhLUkiJA9KChALKH5kJcDuF+ANyzE54mxT2ArMyAR4Qju+p?=
 =?us-ascii?Q?C9dwHFKOCW4quYrRlMOxoKYjc2xk/j8ReBjAxcTG9a51+5aEwapm9A3gWQvH?=
 =?us-ascii?Q?WInykvJhnZ3n500RqnGmNBG687bt+GIv4eb5AjbvALajG/8UKi3f1ltImDHo?=
 =?us-ascii?Q?qMi4orhzKANAdpKE/RIsJa6073wjY7WXjKzRPVjIyW429mBh/rnYUXJp0KJ9?=
 =?us-ascii?Q?rW3dJkKs0L+dLjukZu2PZ5JdVBLHDaJ/26XfSswpCKluZlFUEbjKqeQA6xy1?=
 =?us-ascii?Q?nPcflrGaDu81P18N01H5kskPYRwr+NkzA87Da5T42SXEM8QaQ2ypEQpa55ni?=
 =?us-ascii?Q?BjfE1MojGspn/MjdqHNfGmn4K0/gMmsVoP5UEj4gBCEpSyiBeWWXoxbrZuet?=
 =?us-ascii?Q?aol8CX6UNkemxAeFjQVs/gPzJrfrXuKDYTBzENI90MbUU28PWEUSt13wRcHv?=
 =?us-ascii?Q?n0gA7OdeJHy5wRIuqeAHUbSs//wyFF81IrZAgR0GB1fkSagg6D6pKL1hWLkY?=
 =?us-ascii?Q?JXn7UwfK0P0dMEBmPxKSUG4rRQGc/IOn3aQ0L0FAfbLVFEovjPXSF6cJTPeJ?=
 =?us-ascii?Q?rst3TlURht37+l2BzxHoAFZzjDAGiDDSYwjlcP3W3hv5M+MI0TVf3BQvJ5aF?=
 =?us-ascii?Q?MyTzxVyR0TrYAXVJlHF6ypN2ZJ8OgZ37hKV5McrBEw80eBUCmv0QcDRypf7Z?=
 =?us-ascii?Q?7GmIFUxxTTcVJ2VNvv+smeaghc66nNwTL/CKLvn3Z8V1nwrRIVRVZ3LzizXH?=
 =?us-ascii?Q?biRD8gXgvDWglg91aYmFZ7dPUeP4OSZY+AECF7A4pYdpQcd5Ov/MW/hh+5n1?=
 =?us-ascii?Q?DA01RItWkSNLKbgwqACp+DKI/YftrbKZcin4WD7wSNy/1qFnO4yqIb/xMUeG?=
 =?us-ascii?Q?hx9sisYJKYN09E/HmNZTa2kVfG8GskLn+x0AWxWZrJ/rVQO/vFPtQOxE1RKm?=
 =?us-ascii?Q?gr367toowNdouDGySsUVEUP1nqfxHjga8fbkFC8A6DQlnbs08yyWxtSauUEE?=
 =?us-ascii?Q?9WtkudDDbo+yTYghsJY6wpIhlxS0+opOBVGoDAAzR3sJz6iSec2UZj0OI7B6?=
 =?us-ascii?Q?e5cdqSmftg=3D=3D?=
X-Exchange-RoutingPolicyChecked: hRxgA7XzDuIe+83zgzINLo1a8cJDx0JyyfsFe+xk1PAeDZs+OK7edQG3zGClzfe15gxWFKUO9lN95RiVSjUJyNZut0Z78Jw/QAV2c+roWS7aONQ3lpr6U5WCWIVaNMpeVP7s08HSGiGwJZc9bDlfagf1hDvIirpOGJjgCnu+5oEFhBLxJNSAnEmMF0wn30OgwEjLY7ubQwb0YZmgDFwkONb4+wDEt+k/XKR79vCkYoYZOFpZ9tpPYQJWuUiL4V/Z0aV5No0g9F8JrHCNOA1Yn3tM218b5NTBPmu6OX78fn/7/juaF/tR95asx6UnbApQth+Fltkiz+0r+gEMe0jYKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: eda3de70-5993-41d2-290d-08deb54c7975
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:15:19.5462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKPJ1LxGKkC2OKeB0L4N8BIypwBHOBpDB4L7o+ofmj6/rep2FypNPpkIjrD9vRsyXu9JpYtjxvDkj8fjPTt/qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7668
X-OriginatorOrg: intel.com

On Sat, May 09, 2026 at 03:56:34PM +0800, Yan Zhao wrote:
>  /**
> - * handle_changed_spte - handle bookkeeping associated with an SPTE change
> + * __handle_changed_spte - handle bookkeeping associated with an SPTE change
>   * @kvm: kvm instance
>   * @sp: the page table in which the SPTE resides
>   * @gfn: the base GFN that was mapped by the SPTE
> @@ -510,9 +510,9 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
>   * dirty logging updates are handled in common code, not here (see make_spte()
>   * and fast_pf_fix_direct_spte()).
>   */
> -static void handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
> -				gfn_t gfn, u64 old_spte, u64 new_spte,
> -				int level, bool shared)
> +static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
> +				 gfn_t gfn, u64 old_spte, u64 new_spte,
> +				 int level, bool shared)
>  {
>  	bool was_present = is_shadow_present_pte(old_spte);
>  	bool is_present = is_shadow_present_pte(new_spte);
> @@ -549,9 +549,7 @@ static void handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
>  	}
>  
>  	if (old_spte == new_spte)
> -		return;
> -
> -	trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
> +		return 0;
>  
>  	if (is_leaf)
>  		check_spte_writable_invariants(new_spte);
> @@ -578,29 +576,49 @@ static void handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
>  			       "a temporary frozen SPTE.\n"
>  			       "as_id: %d gfn: %llx old_spte: %llx new_spte: %llx level: %d",
>  			       as_id, gfn, old_spte, new_spte, level);
Oops, this patch needs a small fixup (the internal sashiko found this issue):

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index bb18e9e61542..e783886296c1 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -535,34 +535,36 @@ static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
        if (!was_present && !is_present) {
                /*
                 * If this change does not involve a MMIO SPTE or frozen SPTE,
                 * it is unexpected. Log the change, though it should not
                 * impact the guest since both the former and current SPTEs
                 * are nonpresent.
                 */
                if (WARN_ON_ONCE(!is_mmio_spte(kvm, old_spte) &&
                                 !is_mmio_spte(kvm, new_spte) &&
                                 !is_frozen_spte(new_spte)))
                        pr_err("Unexpected SPTE change! Nonpresent SPTEs\n"
                               "should not be replaced with another,\n"
                               "different nonpresent SPTE, unless one or both\n"
                               "are MMIO SPTEs, or the new SPTE is\n"
                               "a temporary frozen SPTE.\n"
                               "as_id: %d gfn: %llx old_spte: %llx new_spte: %llx level: %d",
                               as_id, gfn, old_spte, new_spte, level);
+
+               trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
                return 0;
        }

> -		return;
> +		return 0;
>  	}
>  
> -	if (is_leaf != was_leaf)
> -		kvm_update_page_stats(kvm, level, is_leaf ? 1 : -1);
> -
>  	/*
>  	 * Recursively handle child PTs if the change removed a subtree from
>  	 * the paging structure.  Note the WARN on the PFN changing without the
>  	 * SPTE being converted to a hugepage (leaf) or being zapped.  Shadow
>  	 * pages are kernel allocations and should never be migrated.
> +	 *
> +	 * For the mirror page table, propagate changes to present or changes of
> +	 * leaf SPTEs to !present under shared mmu_lock to the external SPTE via
> +	 * set_external_spte() op.
>  	 */
>  	if (was_present && !was_leaf &&
> -	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed)))
> +	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed))) {
>  		handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
> +	} else if (is_mirror_sp(sp) && (is_present || shared)) {
> +		int r;
> +
> +		r = kvm_x86_call(set_external_spte)(kvm, gfn, old_spte, new_spte, level);
> +		if (r)
> +			return r;
> +	}
> +	trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
> +
> +	if (is_leaf != was_leaf)
> +		kvm_update_page_stats(kvm, level, is_leaf ? 1 : -1);
> +
> +	return 0;
> +}
