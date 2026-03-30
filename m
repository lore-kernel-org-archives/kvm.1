Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7691028DC4;
	Mon, 30 Mar 2026 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774849233; cv=fail; b=bYq1P0WDlJH5ULj8/aVCcyb3RMlaiSWUcyoQw3tWAsL73ahl9DnRiddXfhaql5SUvMdzLzUOC2G+fgdQk/Md/2IXvt67ZSsrwad2Niqi3dVEkYp082l55VuPDblOEi++xtDm67yA9qmtdv3bz1K+XOaT8TZa9XLQyGYP4HNtXIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774849233; c=relaxed/simple;
	bh=nbXK2MZwzZqMtt1d0oguGv0/+T4h1d09x3HeJ3TfRBA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oed0SGsXyEa2EnAJSPu/h2Oe5BmD36SHehYHeIx8rpwT8rBQFWxYCxopbWDJN9UVvTC1tnJquYJFj3KcifmJ8ocvklF3GiKlAWzwIwr50IPmVEy6CBpbqm88jagPJBq3MhdzRzgz+RtF7IRkhLtPt2KkK65WXNsCv0EJz3UgYjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T50yInpK; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T50yInpK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774849232; x=1806385232;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=nbXK2MZwzZqMtt1d0oguGv0/+T4h1d09x3HeJ3TfRBA=;
  b=T50yInpKssfhdweKnVwthIYPWsIIPtw7TaBPOBTDR1uFYrQHnKm2KBZ8
   uH9rhVbpMcZiF4VmCRa2+5Je63oS7lWRC22DwbU3lL+dumbd2hfVufjFQ
   rGgzHZfZ/QCEjD3pQ4ni8Eod5nXiJApwbNV3yUrVBHC2mI/oTiDMTqSfr
   IgmwPM71QuI0gXxko/wO78mExU9Vwy4uKIA0EjYCTIujl/kQnUWZ9Q+Ds
   m8eiT93jGWjvJf/QQ1FUQ8jZ/Qm6qG9V7CUcMqOl5dWXSjoYIHM2E3OY9
   bu+6BFiObgTO8mDg0JavvU1LRMLu0JMx9BrhfiXV9pf4T0EZtdZBA/qTI
   g==;
X-CSE-ConnectionGUID: UF/vbDHnRfeff6oGSnB58Q==
X-CSE-MsgGUID: mORYuoAxROeY9JhRKsvVMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79735901"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="79735901"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 22:40:31 -0700
X-CSE-ConnectionGUID: kweiWY8CR0WuqfDhfES8qg==
X-CSE-MsgGUID: y8aUGAqwRQK0FQUa0Ddz4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="249140382"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 22:40:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 22:40:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 22:40:30 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 22:40:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiJOILAZHhW2Lmlo/M0Nrctn3obdkW8CMSvVK2PUj+9/tWOX2wobG3n5GASaQEHIx8h4Ku5fe2tKxqHLIbQhSL3k1cPDDvCsuLdDhqHE3jsF1VKZhwPEmiQt61NfNgYUECu/XSQt4KjWkqhyWkFVK+y5loFDV2+Yzml34oNaHMItnIkULS6gmv7J8YmetrkwEYPxJxtgxrwmSDP6ZOr2MD0Yznjj064XWVP2ig7G7ncI/tWrqa8fnWiKrR1ihxBwNM7Ox7XnUkDyShcwpgWj9EtaEIFBk42kXlVxuqw/SHswrsw6hiCzUtwvBXLszwzdmWcaMTLpHyPGszdIee+qLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2UYMUAhr1Mg3md1sgJJ9jpP17s+xfSDH2PPPVbIyqE=;
 b=aZd+GmLU/vrWCCLkwfjs2k4QQszDr9BBgkbdv8sFYHZ2Rnz6P3ve0cdxuoqTdbMElqAuQ91bi6aFbqbZYjEjqeutjEICf7myyPiEG4e/Zzv/AJN8i++PPhqWZliLUm6+x86zwfUMr1WGRTZCZnttEyVFQHd0ERG4CYoiI+cFLg36WC6UV5XwiFiPbVdlEWLGT2xwNrNNU/0q5DYKr8LvmruZX3LAoQK4P3EzVwGXMS+XzdhpuxC5Fs9YV5ZfpQVbQ5LlrFwnzwrARn7sGJHs1CS4Wqepd8VqLTG0tW+gPHXTGbBY7AIgefZocmYN/IIyyI/RhiMaB3j/zeU5lkHwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by CO1PR11MB4898.namprd11.prod.outlook.com (2603:10b6:303:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 05:40:26 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 05:40:26 +0000
Date: Mon, 30 Mar 2026 13:00:54 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kai.huang@intel.com>,
	<kvm@vger.kernel.org>, <kas@kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <dave.hansen@intel.com>
Subject: Re: [PATCH 06/17] KVM: x86/tdp_mmu: Morph the !is_frozen_spte()
 check into a KVM_MMU_WARN_ON()
Message-ID: <acoDhjbA0xIycCJH@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-7-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260327201421.2824383-7-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: TPYP295CA0006.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::16) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|CO1PR11MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d9e8c1-af61-421a-aa0f-08de8e1ed808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: nqg/yBukZEvE26JXJUoYEO6THTbvMA4+wcb0D9oEXHYoFV8gJq97NPWt3OgQ+dLj6sf2ZJ2AomPKmIPpGtj36BAcKaXVFRqsTsDlV6SebZh/epS0q+BJm5aciFQi+zFNFY6JgvKwSlU4rhcYguI5zMfQ7QoJ5ZA/x1xRSDOia5JFwT1ZyzQXQ4hl+FD6UEE7CBR7xLwiuQRFXK7g8CPWDeEZ9Nhd9qxQnd87weXJIIJvVaPgiX9Dwjv/3BRbQmDzfDMGmUQyABWKEOAoffnDppKC++VOpRdrKZf64T/IoDXrnuUiXwQ+aZ6tOZXuMJxI5tsPYLkY6uuyqqdvuqd+6DVMLO571q7Pf5I22h3px2JZx1vAD36HW2eW2EpKEAh+QDFHbv5bvmcDfMzibbw0zMUYl6knIzIom0TI2yr8KQIoIICtf20pLjQzVVSvPNnA9r2N+FrpDT7aE11G6YJHhNfmjQM5dmA0zaol90LLFaCE40yi7DhYfITFalG/7WA7K4GKu9gWANmrD5CNscn4rY+rw/DOx+RZ7EyR7bMARS56Jm07I8EcFNqsscAMaBRymzYUAeG802eySlKEsfdST+aNWx82XxGkv7kPf2IlpZk5p+q1QEqHUjBaQnlJ4GkGxFeQTxsANek2nqZpVqKVzpioEZnjy3XUIL4rc46R7bDShcMpjhjzxA8bx7BjV2I0ywmG7ggdTCuHTu/gkC5WsrOW2zxRkkDNCGyAdQh2pSo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kzIWwK4eHdJOc9ig7Vvm7ShTYNCFBuhr7pf/x0ipXqkDj/2bw+0Vw+hj1duV?=
 =?us-ascii?Q?3UtBYALMbPiUwNEunvpi/cIb1X5s+HvgeuiBQJxGmG24UGS64BHbKefu2FPz?=
 =?us-ascii?Q?pFswVTTghdbnByXpsoaVFZUaT3Ii1xgiHLi7KGCupgUrhQuvg7GKpReyXFSI?=
 =?us-ascii?Q?IxDpzfDd9SRg8hYfQeph1izwdL1K+zQRPbHMZgavy5YDPBhuGRD9XSbE7POC?=
 =?us-ascii?Q?h8fVzpfcZ8RwknzYa8ipK8QRFJ2K+MTwxwPfXrPmQnsHLcIOK0VABkND/Vpx?=
 =?us-ascii?Q?Nzt0JORdefeEtgnAGRjDLCQN0ePPmgtTpR/l8RmLgSvj/XGUWHyZneoGBQJo?=
 =?us-ascii?Q?j+yE4X/La2hUQ7JaK+BAae6p9SHLDyDXNWCJwol/WHP+gT5t6mfMllVbBG7S?=
 =?us-ascii?Q?CntanTUPZfldjkHcJNMo6/qP6c91wt8SKlOqijRJmEIZ69jAY056KoVl/FuQ?=
 =?us-ascii?Q?fZ8wqYt2atlkpKcCNGQwkT222mvkWb9w/EBCYCrfkGQR4i75uKVeI31+12Ut?=
 =?us-ascii?Q?UKeJo4DA/C6XB62b2Ki9fG/VWT8kUoShIcMvojGcQHX5upwdx67pUvc3drwe?=
 =?us-ascii?Q?ohnYzMTWgWsaqYyTr3LvWXTockCszIemie9E6qidrmdxJrGcNqeMUjMcee2j?=
 =?us-ascii?Q?zM5qaaW7SOfKSXQcWoqOKPUWluKfw/dAjwfSFGmKndHtK4UT7PtnpblHnUki?=
 =?us-ascii?Q?C3rSonI+G8PYuuio99xkrTuFslqt/zTgkdd/JuI2x0/28GA0D+smMtHIKXaM?=
 =?us-ascii?Q?ZQ9WhWBzVKhI2kLBDl0F7ihO0JKuO/ldkszGtYbtzMYQcSbiaI0H5lhz6PX4?=
 =?us-ascii?Q?zQxwFsnaJNAiIBgNV0/FgjkwFzysCqxjP0hfCMjkavp5kzGp11xjLCw4+pCH?=
 =?us-ascii?Q?3c2LlgPqy0bmjxFIUQpAHbcXGlIfhrrqL3E/xbDoBz0ev7Yu/t380DjuTPCT?=
 =?us-ascii?Q?Zzta2YaH8qh8qIYPsY3nhOr0k9X4kjEWnz/QoD0jxQA6NsQcsUK8FyfMe+KN?=
 =?us-ascii?Q?FGTFcrypJ0en65GgLMyS8oaMR10Tu2A9nnz5Ws7Xyik1Q9kzGsFlU1vsRv0G?=
 =?us-ascii?Q?VdQuCkoem9Rq99rc4MqTGNSDahlYWf6lYSiPm9t+cjtH2tkK3LIdI8V8o1+j?=
 =?us-ascii?Q?zPi6d6ULBvJI0kHqOuvybdnSG7c/V5EbeVdYktkI8N+kEd/AfDGMyUIhAobG?=
 =?us-ascii?Q?OcOMkMSc9EAo8kGKvaYejCdhFl+RqO2lNf1yLuDGke8YRPkZ/uDbIaqdaNzL?=
 =?us-ascii?Q?zQpUeIzcBuxnGby0qEeTpUYT3EH1IMiRGIMwP1WsGWmqK1trMgH3AeWl2yWW?=
 =?us-ascii?Q?OIP8xhLbOeztC9Y7qe+weNVujxfwaFpLSsE1L5hspBRgxDsqev6JzfCSKmPk?=
 =?us-ascii?Q?gXlCoferf2qnrUkk80/RRh1E/TCmZjij69vG9jaojRzcpxjhkt5Es6bXOe/s?=
 =?us-ascii?Q?pQEsPqf/ovL5nW4BzWPzmmipHDA3L7DHl1eBKmbBGeFkavzNpvzvvKffG/wJ?=
 =?us-ascii?Q?hgSCiwchhDiTVpo/PGoB6DY4eJvHgKB6kbjHQE4myG/J9adTYcAjUJ8BN8Pt?=
 =?us-ascii?Q?F5WS7nTTGghbraSFUltbuscs6yWvquCrimEubnEweH5xzFqzfvbrtT7O05gp?=
 =?us-ascii?Q?hPJ5QDVr1e6vGdQQ26G5lc8jcrxhWyXtvNJDqjNyTPWnUD604Hs3x2I7gWfc?=
 =?us-ascii?Q?agp/it74+eQcpMcjPt7SGiHNaZ2nF6dbyNfHQeYCe0xVaO2Ns2eFmGbJfWwc?=
 =?us-ascii?Q?KUApb103+Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: sNSImHaXLI7ZoLScYuwQFA5vxfoyuMQ9Z9Gn+MQMHtr+23oRd0fVxsn2/e9BsJnxZ/pKPAxd+ZpDpT+FTn9Uo03+KFuIy9vaviu1eTa+/y3JpnV3HPMos2QEf4u5+hR4vraJGYrM6ghJ8yNyz5MI+O5a5xLiveRl9Z6Muftc0qnQvYGuWTqbqEObxHHmRVDs6TJDIUw6CkLVMS1iE+IeXGuawEAWfZceHeSwzwEmmx3wwU2QTtFi+xn6oBEvcKPInN8/jurXm94C9agODXy01EfO5Zbcxf5oUsMI0rcJTntJQAtmdks12Hjzy6DnECmpmkWQI5R5wcTWpxWNSx577w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d9e8c1-af61-421a-aa0f-08de8e1ed808
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 05:40:25.9347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idWMsjOfekPnIwjDlUfHdwMnQ0KyBpcdf41nsbetiIO7gnHWhGPIjyj0dBdcmXbq6t2dVg6Q4giaw40W/qTuSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4898
X-OriginatorOrg: intel.com

On Fri, Mar 27, 2026 at 01:14:10PM -0700, Rick Edgecombe wrote:
> Remove the conditional logic for handling the setting of mirror EPTs to
Should we unify the terms "mirror EPTs," "mirror TDP," and "mirror page tables"
in this series?

> frozen in __tdp_mmu_set_spte_atomic() and add it as a warning instead.
> 
> Mirror TDP needs propagate PTE changes to the to the external TDP. This
Two "to the".

> presents a problem for atomic updates which can't update both at once. So
> a special value, FROZEN_SPTE, is used as a temporary state during these
> updates to prevent concurrent operations to the PTE. If the TDP MMU tried
> to install this as a long term value, it would confuse these updates.
> Despite this __tdp_mmu_set_spte_atomic() includes a check to handle it
> being set. Remove this check and turn it into a warning.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 0809fe8e8737..338957bc5109 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -656,7 +656,13 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
>  	 */
>  	WARN_ON_ONCE(iter->yielded || is_frozen_spte(iter->old_spte));
>  
> -	if (is_mirror_sptep(iter->sptep) && !is_frozen_spte(new_spte)) {
> +	/*
> +	 * FROZEN_SPTE is a temporary state and should never be set via higher
> +	 * level helpers.
> +	 */
> +	KVM_MMU_WARN_ON(is_frozen_spte(new_spte));
Why is KVM_MMU_WARN_ON() used here for new_spte while WARN_ON_ONCE() is used
above for old_spte?

> +	if (is_mirror_sptep(iter->sptep)) {
>  		int ret;
>  
>  		ret = set_external_spte_present(kvm, iter->sptep, iter->gfn,
> -- 
> 2.53.0
> 
