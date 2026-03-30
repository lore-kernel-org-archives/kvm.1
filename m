Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DAD314D13;
	Mon, 30 Mar 2026 07:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855384; cv=fail; b=ZAQUkVtN/s9g7ekvCWdYi0gTYqvIexJES2ZvzRNspMGYG/u7wDkSyfyfGS8WiAQ2clQAe2Sp82XEcOs6/orGnrxjExg+WXlGw/kSD6jNkK/sH2OLLOQORx7BOLpfYNisrO55rb79ZQfiel8a87+7AClLMM4HNt/d6NtlGJ9wp7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855384; c=relaxed/simple;
	bh=Q3QP1RXR5jpnjQFMCiz9LhYvYGZPoonG9vgS7SQQ/tw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lml+NZztzHVsDtzlL7DfxEKNAHC9oEt5rwXozcLw98zv99+e5crAgD47WV3P2y2mtetVZDQpYSlNKZMddsLiz5GnLO6w0DYZF8PVKyKvlb+9peytaxQe34wraJA4ydSDNYRmMg2zn1YIuoU7GDx7IFHINM4ITWYZ4N6OcOkjU40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWKafKvo; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWKafKvo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774855382; x=1806391382;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=Q3QP1RXR5jpnjQFMCiz9LhYvYGZPoonG9vgS7SQQ/tw=;
  b=DWKafKvoevHcQRkbi6SnCYQmx46pcoOAinAR3GrOat56ywpjJ1Io4kFg
   i3yf/ByN0tLWyvnvzgNJs8r0sM6XHkwCCE9Xj+fHPKIUSU0a73CLZ86+G
   9XSszCzmwqya8oERZaMsLQaRfk2s6qs+R0XiC2Fhlr7P4xBZFCelgzl/h
   iS31bxNV+Aw5M5kchim8VbOZ2NEibbv3ULjEahhxef/JDUzIwgo43RfX7
   rmR64XpE5l7olSKnslo2wxgsYK7zAAp7ZHqyVC6ZHkGWoTsaPuYaOOEvB
   7QvcZxvLVURpFSAd5oUNnN1fXXMItLWLpSCxx+zk4yerWchXU6QhCZXgt
   g==;
X-CSE-ConnectionGUID: AsHmFiwnR9mbTs48F48laA==
X-CSE-MsgGUID: ThXixVZORru54atsW7SWJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75736452"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="75736452"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 00:23:02 -0700
X-CSE-ConnectionGUID: aJWpUoNPRdSGrLXSWSjCzg==
X-CSE-MsgGUID: 0CsO81ebRYuhpEC8U1cMVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="230887413"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 00:23:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 00:23:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 00:23:01 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.64) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 00:22:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHhHXr2iRw1rXzVaj3tfiUiIuCm9JiDrtQBK3W/zaaSZCZZtTUUvmn++uFwmJ1nKy4rLnl7oH5gXJP20L09392/JrkAEz7DG7zFHAmi1y/AcRAJFtqALEyM60uAIS2SUwV+WZUZU1nN/usCIxQmePJK6HEc62h2gjEtS0Cxk5IQUWOjJs93T9hA92kY27o3t/Rc+eNTIWocvhN2uLig4j3J47wGG3Pb960Y+OfLLDLV+wzLPq09hf20kH2HRkP16hfmj1WTu5cX2npth3lrsI3W0HtyKd12uCuOI0jkXSVtQcQ1DamxCrbCIyyoXzMUt4zZYLJk17fBUY+LQFW+5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbDwkc7C3l20FcHv4q4zvJSeFisHLMcBDl0htt3UtKA=;
 b=astn7b2W+lfDsv2WRc9eK8JUCV2/lxbGtzREKbACcjdeyU6KMYKfpik69uBkWEUtPWuX7At4xAdKuJmQGZ5g1IESb+jTT+JEl4WSuzh0UkfJ/X4xazEUukZ6Z40TMBc+u04WxbzWf7aOpSq8MUBChcflPr9giSJHUk4DYVdXUhWVpAGVdiXygWxOPfA3Pqci19pq7L1EXIYsb35MBdJpptTuLNM1XaSfz0aEQmbDKJQdQoBiPjvi2TkMG+4Lfm0zMo+Jc/wBb4JVmeqLWwKJZuQUopaxH2OxdJfJ8ZkcihdhGRinpEyyFgkzbTZ4To2FOkoK1vw+X/JNUGDZ5YB+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by SA0PR11MB4576.namprd11.prod.outlook.com (2603:10b6:806:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 07:22:57 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 07:22:57 +0000
Date: Mon, 30 Mar 2026 14:43:26 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kai.huang@intel.com>,
	<kvm@vger.kernel.org>, <kas@kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <dave.hansen@intel.com>
Subject: Re: [PATCH 09/17] KVM: TDX: Add helper to handle mapping leaf SPTE
 into S-EPT
Message-ID: <acobjplac2phLTKO@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-10-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260327201421.2824383-10-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: TP0P295CA0023.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::19) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|SA0PR11MB4576:EE_
X-MS-Office365-Filtering-Correlation-Id: d1edb95a-952c-457e-d7b9-08de8e2d2a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: wk3DDZqXZo/4JyGp3U9UPvfisHo6uqEBQvnTv/Ai/PwlaWNJpCh0pRtOgQm/DYp615cW2TkRDSA5H5Pw24XQUKlbKt7EZWyfAl7J/zS9uAzSoTvsflL3XXXAWLzqwJameSak8Ciqig+Lg7qrQYA3p3ygYm5zs2/Fn32HE3op6Q6ihQV1qDbNApMA0WjwybUN+BXYaaSdmDuVmvSQAOxjeUPSvIEhf1YiOwU/Mk1J8RErj6xcqjruGxofQi3qC5/D2mitWdOHLUjrfh5ZvqfQwKroB9dDjiPt63BDLInA69S2kekw40sozuW+U1T4IXc4ODK38AE3QUbBS9/coR/iibeFxlnAqNRWGw9ZBT1wVlcknFuYElDGfnWjVKG942GxKqY2c2x3x65ogb9Oyz24BbRbKvjL0W6ZjobPnfciYBWQP64TJ35e1bseY4BN4ZSgx/3Vvz9yGvZMkUT8HpNpQ/B9XP4rB/LIhgOqyVi4ZUjRm/pcWDWoKpGYYIhR0RUtRgePybxl5iecb76pa6MgDwpEKvHoO908maJfnmFxZvUjgHYholM/N1wzD6BK5WC84Hhl8O08M3ElHn3Y3xhDa6SiLPIZIqAcj2B8Iw2DlN5TQ7E2Obew/VTCf15vJp2b0oUoUm413Cb8pOwyz0DWbZkOp6BPGFMcavdLqQ3ICizMjuFjBi7VmzLVbDjLdCAMsYTvDRZmVYUrFxRpm2vdrc/59rosGjqqH3AvoUfWNKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GTWXWnFW0Sz+6iHDBICyf/BTL16MK46B6y7bwiBhwfPvThpOiseXb3VOZKcg?=
 =?us-ascii?Q?x/LBQ0Em/YssJ0nkPfrVQVFt8SeOhNlqKA69EZhldD+vqU7bgAyRwVlLIPbd?=
 =?us-ascii?Q?YU22whp0qzZWPaDPWWS/B2ZkGWuCvgx76Ex8jX3diuv2W64Xn8FND3nmvRCi?=
 =?us-ascii?Q?xmTlGSQwA2JL9xuc39E9LiSWk62k65KeiD1/tvSDEI168d8T0cbsDndVgqex?=
 =?us-ascii?Q?fbWDw4q1O3ZuNEC2PN97DGwZZ+cRw/Qe6pazgTErEntCiMP4pyCQ2QEDiWWt?=
 =?us-ascii?Q?3OPrP+Eq1GvVs8vxeOWfyih2FVCTcIsdIASipVKNnUPhBv9JtacEjN+7WYE/?=
 =?us-ascii?Q?FZLkb6aZp8rWQi+fV1pELn/M29cLUC/y+/rg0C3RybqHrxzQ4cvhucR3eEh1?=
 =?us-ascii?Q?a+H68p02fGqaiBrdB2nsluDMZeX6HxFszv35sZD0FK+WiizXeAk/sr76MFJL?=
 =?us-ascii?Q?REMzYVMs3gjG/VGuRGUSs03IZO7dK+nkSkwz39pWxEFSbOtarLS5DxeKHSuu?=
 =?us-ascii?Q?pyY6U33VY2JnmbjHu2rUNtiLrVG0eFm9Iu2a9bo430aB1X2rzpQWDRSz8Kzz?=
 =?us-ascii?Q?PHE5CykbeQy0wobNILaulzZCHVwuy0Sqs5wFzSVJGcYf6qddgwmWyepl3qjK?=
 =?us-ascii?Q?ofXj9/k3/le0suxETVI8tlUTnK1bH3Kh4Z0aidcbEPoAHMsNjAxLtAYT9Xws?=
 =?us-ascii?Q?P3laX83gg8T4zEkUBsSmaHX9oASaeDuypDfai5HZt5PrHFq+0Wx+XMB7ZlHh?=
 =?us-ascii?Q?SsLhuJY3ObZJdoEl3jO6BYOWC7/+60YDGk7scU4U/h8reECRuu1WJlLGu6jO?=
 =?us-ascii?Q?xhonFcBSSzfcBNT/slOgHWldkjg12xevm+/wC7v6+tNFcvNFq2gyFQD2HP16?=
 =?us-ascii?Q?T/HAhjXntRRHp2JzOL6EVDMc8H9O6cvtgAFbXfF791kz8sXGP3ZW9VvAcFfv?=
 =?us-ascii?Q?giQlSkMAamOLknAsy1iSNHvLwnaV7ClgAOJD0lMN/XoTkQ0FLDJyItGtEh7G?=
 =?us-ascii?Q?giuGilAyAWc7GFnhqh0H3+nlF97KIWCHc6vwcUglLXcXC//mPfVIJjsQX//4?=
 =?us-ascii?Q?1nSAqFqS9a5W0S/wr4WI8MYUXXmn48/7vmY0Q94AUcRBoAAw66WjiSDMnWQl?=
 =?us-ascii?Q?BjU1hbX5exKm++XzyWPE5IC9gN7tXNt+39zS0M6jKL9qfLUokiyIXlluWhcD?=
 =?us-ascii?Q?TYtsGXRqH4zsfTZnCteokKJiUPGlSwW1XtrqAjEhrbe8zVYhbVBoEsjaicRI?=
 =?us-ascii?Q?wSLWSNFaKu/p/IU0SKklZ7C2ro5s5FItMmY+GPSw6V35K3bYA5EqIsgbCGQg?=
 =?us-ascii?Q?pwEllVvn+tIUSW5hzeJed2XBl5US0IpTshZJChf5PSBawgF+2eMWJ5Nc2Iv7?=
 =?us-ascii?Q?6Wh7lsTeSWMJgRTfryxlAC1o6ddylPz034Sxpbu+jLFi2mvMoPiLqN5grKr3?=
 =?us-ascii?Q?QehWOmd3HenjzhP9gzlTgzFu/EzA5XdJAg+Wwn70GzjGImGbwbfXlLKEjr4g?=
 =?us-ascii?Q?wfMFREk2Ry3tPY7IBpJPdlE+3DVjS0dVPHVVKdqvPjyYU2/dt8maptcVuI5K?=
 =?us-ascii?Q?12BZkEMjkPtc26PM+S3kDw8mg8gLlJCmP/yRu6JluhR9R7CQH6BzrBIe4bpd?=
 =?us-ascii?Q?CuuvYXiQ3fUn+DsDw+eHwZupWv1oObqzmgsN2fMNkkUy9sW9QsuRHjIjaIfe?=
 =?us-ascii?Q?BTvN/B3yCFb6Mb7i7C/VFuJiNTpRX7cBXzUofHyoBB1JrR5Y74vUEzTyE902?=
 =?us-ascii?Q?RUoX8T6iHQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: SPOelCTN+LMTZ2q6f5PaggiEj3uKkXykRB8o3ZRC+SI9L0OJ9rm0FmMmq8dVnHNHa4/6mONSzPwyuE+z6p4mL9A31lBWV6UbG77eteuLuPOgRVF08wUVLhvj0dEdeqiL2EAWjtLrSrNllyfLS7ksy4Zthuziefuh7v2wset/0rf0FU4HSRA5FM5K4SSsTdHXt2/z7wuQkCqc2RE+hwYZzw/XbffD+AILNeAiyIPnQSj/JMY8hMqzRXEZs5ezWRb00mtsWoYUwlCWQfEnU1WOiZg/w26+KBe8DOPpXnLrWuXJeGXknqVSfTxqKAuMFBxEC/PrqFs99SJmW0kllmZ1Wg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d1edb95a-952c-457e-d7b9-08de8e2d2a9e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 07:22:57.5206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3f64z7FvDKa5tP9uBzxzsTR18FakHDsMKIuDpsLQG8LXdvtjMmjy6hqpPOir7r6QU4ZH+HLbkZYgrglNGudZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4576
X-OriginatorOrg: intel.com

On Fri, Mar 27, 2026 at 01:14:13PM -0700, Rick Edgecombe wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Add a helper, tdx_sept_map_leaf_spte(), to wrap and isolate PAGE.ADD and
> PAGE.AUG operations, and thus complete tdx_sept_set_private_spte()'s
> transition into a "dispatch" routine for setting/writing S-EPT entries.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/kvm/vmx/tdx.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 92a846b91bac..361a75b42ae7 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1689,18 +1689,12 @@ static int tdx_sept_link_private_spt(struct kvm *kvm, gfn_t gfn,
>  	return 0;
>  }
>  
> -static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
> -				     enum pg_level level, u64 mirror_spte)
> +static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level level,
> +				  u64 mirror_spte)
>  {
>  	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
>  	kvm_pfn_t pfn = spte_to_pfn(mirror_spte);
>  
> -	if (KVM_BUG_ON(!is_shadow_present_pte(mirror_spte), kvm))
> -		return -EIO;
> -
> -	if (!is_last_spte(mirror_spte, level))
> -		return tdx_sept_link_private_spt(kvm, gfn, level, mirror_spte);
> -
>  	/* TODO: handle large pages. */
>  	if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))
>  		return -EIO;
> @@ -1725,7 +1719,18 @@ static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
>  	return tdx_mem_page_aug(kvm, gfn, level, pfn);
>  }
>  
> +static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
> +				     enum pg_level level, u64 mirror_spte)
> +{
>  
> +	if (KVM_BUG_ON(!is_shadow_present_pte(mirror_spte), kvm))
> +		return -EIO;
> +
> +	if (!is_last_spte(mirror_spte, level))
> +		return tdx_sept_link_private_spt(kvm, gfn, level, mirror_spte);
For symmetry, what about renaming tdx_sept_link_private_spt() to
tdx_sept_map_nonleaf_spte()?

> +
> +	return tdx_sept_map_leaf_spte(kvm, gfn, level, mirror_spte);
> +}
>  
>  /*
>   * Ensure shared and private EPTs to be flushed on all vCPUs.
> -- 
> 2.53.0
> 
