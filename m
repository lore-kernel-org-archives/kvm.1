Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A5402B9E;
	Wed, 23 Sep 2026 05:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139746; cv=fail; b=j7ZJx1WlHoWYJ9hLq8bs+Yxrh91YQ8lGlnhGcx6OYsy0MlQEBbGQ8iJ6mF6wphlWClvP+ggdi+SwnhOEo+Aq/NiT0NCzCdG0Wsi9VHXnx0wlCwRRJ2FuTtN4UhyXEFOoiTdC+aD1iH1w7qzpifP7FhvLMGpxQK3Ys80in4TZLZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139746; c=relaxed/simple;
	bh=FX4ocnSKZv69fdKqAVncsvfn0h0DyvY0ethrUIvMRVQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JbmK756wvLpINEqKI6jCXhIM7FpeINwqQytt98LueqboryDalSwEqQYzVqIJp7BNzNa/B4wjkUxgXinMnUfO/HNvjqevVmqQwgS1ZZwMvJGETPqgpCBKfTRrei9Nf/xS+SrfsSamkYnU/OKsIZPNVvVBZjbY+TKX6e4njxlIcN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oAzkZEDU; arc=fail smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAzkZEDU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790139742; x=1821675742;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=FX4ocnSKZv69fdKqAVncsvfn0h0DyvY0ethrUIvMRVQ=;
  b=oAzkZEDUshj45fP6siNGz7ZjHJlaTSNGZXTai/3MB/+QMoLWo+01HTG3
   y4FWnP6vp8aEXWevnvvh40oLy6pz5b+J+LJcbDxXMSowzUUT1t8aGfUR2
   jPOzOK3XE1TPrHo5LInaXer2E5uJZxBmlSCUAb7VA9IMEwn/37iqwRGTs
   /vrQmNHXQkpqlxqwvZRNP6Es4QeaopvF7pOPub5IEseIXF1bMzLt9YZZo
   o09+FuUhNaztm/V3RcwXXxAHDAQoQltYmgEWf9Okqr2SWzkWB1lfeQs7t
   MnXthd1iuIrZXHQ7X3QX/Cv4vsEzy2GY5LK6qwF3iQO7dDRy2rHlFg/u/
   g==;
X-CSE-ConnectionGUID: x1K/0WRXT4OxSbSHk6lUlQ==
X-CSE-MsgGUID: UgkTv3qYRR+aoeHRoHb20g==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1305055"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="1305055"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 22:02:18 -0700
X-CSE-ConnectionGUID: thvfU+8dQbq2WWBGht3A5A==
X-CSE-MsgGUID: 88xWzfxdQJKNcPbM1IVIOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="272932879"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 22:02:17 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 22:02:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 22:02:17 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 22:02:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F77calqNlpv7An5Y2IdHmvO6aw3OY8iCfSBpb3EENi87SEgC66PWfEicqJZwLGe9idgPabhoJuXUBt8LAniQMedWfutEuEhAPtoCPz6U7qqv2WTlrcdQOLKHAPQm2aXVY+907Z0oo9+QqbBKfGSAeKt/nQcLGyOSaC404papm3z7pkx0TtHZx/v2KMthP634oZyUVbODP8tOMP9uMeCQ+Pdw5ROWXxqtnJbS3K9SR4kxZ3JIQ5HekRXkiu9SkE15WkpTgVVSB/OZ+YARb0faEmDT4zL49MHojH0YDceyNABai2RD7ZjtRezrp9xutPwxY2yF2eOq3GjGFV6GPMQZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjWhiPF3x2004iFHuComWooyGlrqcK1m9SQwvuDL25E=;
 b=kSShIk1kyX3xAbpEr5eweriHf3oJAEp5adua83M+d5Rao0MP2nkYJCj1f8ehaxVfwD4xXGzDct3KCW4SnvNBWPiU5bkXn2U20zb+v5sCspvWQ+8T3Bt3TwhV1I3kwrx/nUaFVkAiL78DwGScPLaSsR9eIdHunKV/HckPZlmT3qD0GVNtz3F+LdgiaVhgcU2pok680RkE/f0nXQZdSi1yU0KVyv1FoGi2EfOT4XZngkOZAtE1c0xQ25us/xpcUdZTReOZOFzrDg/0bcinzuk7yku1tsHabE3uKDaK8Rtjz6/yzOH+hUZk0qesYcjLJyTe4gQXPYlZk6tMJNXBcuNnEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by LV2PR11MB391849.namprd11.prod.outlook.com (2603:10b6:408:410::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 05:02:09 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 05:02:09 +0000
Date: Wed, 23 Sep 2026 13:01:35 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vishal Annapurve
	<vannapurve@google.com>
Subject: Re: [PATCH v2] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
Message-ID: <arNdLw7Us/cRs7Ce@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260826165647.769231-1-seanjc@google.com>
 <aq/XwK71uNfLvUux@yzhao56-desk.sh.intel.com>
 <arEzv8b2IMHYcHsZ@google.com>
 <arH581gvxmSMPSKA@yzhao56-desk.sh.intel.com>
 <arKPLKedX4fs8Zef@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <arKPLKedX4fs8Zef@google.com>
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|LV2PR11MB391849:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bc1d9d-5bde-4cc8-2055-08df192fd226
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|10067099003|56012099006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: yaeqSGnCYyz8cOH3Q2w774CImcHuQ5iP847No3AyGi4nRecPlYZivoiS+LXCUGJQ3Cu7I0ywXbuDxy8pyrEdWmzhqmd3o2SHEJwBx46LVvwtvuenPm9cM3oOy2c73R8XHIVeLDX2UvDQ75MpZOx6/JoeFGurf2K8vbH1PGkZELtoaGTIpQC70SASCFOVfAaKdoM5JUA93T/3sMkrDacEd8V4Aa0NoN4M0B3xKqXWXVMPOn56GQQlFOOxtvTPW0gt3hqeto/JxNo4rX3asz89kdUJi6jiUwq2Ss/EiJLrdoE7hDfJYD7wG+RvmI1sIh/MXexDIdniR+qpZezQEJv/t2J+FgHFhorPs5bh2oE3qkojVZooH6dWcKomF2VAWWbqEEfVmRL/OVlR4LBTEgHtcaAdASaqiTgvGHCcz8Omo5VDxIFWmEZaG1xOOpNikBq08+jajdd9CsenCjjbhwDM1tAYDP2za5gjJYmu/OjB2EVuiGlJGbcfN8ZLaEzIKVbRZ3Y32godCP13tGndN1KbIOzmy3V8at9fBB4BIcDTjjRP8tRab0zSbCP+ouLzS40+4v6PB/mTCSrswJ5mNSlzTeODigjCJhPn1y7V10dx1a1frGJs5uKhHTyNiZPAWDe60bUeTidxcXusHqLi84AL6Vggyi/10/6wgo64RoZNMQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ja6DP1NfOn2LJr4AkmAbC+eBIgBrbI2mi9PjoUWicdrmwbL8fw6AzdChNACO?=
 =?us-ascii?Q?xp/wmuAZ2RE6dD1ct8ZraO6f9SAZLKhsoUzPtG3HYW56yqKLi/EG8TaLSn4X?=
 =?us-ascii?Q?KYrmd47ms6/drDiKxa+k8C+0m1qvNNZAxKCEok86Avl2Jf5dTTkYf5RCtCah?=
 =?us-ascii?Q?QuYR3PDXAX9qJFJucZHnuB6Dth4X3iU9lFaC08mpPp4Hg3/qhbNyqZmPr3g4?=
 =?us-ascii?Q?lRp1oUgcuXVKxgsto9N5KBROs0jRE8JqviEhIhDxRygJRRVWDPXFPbO8IDzH?=
 =?us-ascii?Q?m1fcwYZsyPJgQkw2TPzjZecICBDipI9YIma0ZtFeU6E4x7sgOooHcrYguQGg?=
 =?us-ascii?Q?EfP4Osl+moEF/LCdIraLp6vmMAWj0t6qj2Exgap95ClCilHN70E1GupB+vd8?=
 =?us-ascii?Q?bXQjF+01KMEQCB9nEPP11Yo04BIjQzmepcsHXfIzn6076SUI0v4igkOgTfWJ?=
 =?us-ascii?Q?how1ygG8i5gdEgPSGIXOXsp6fi1AlaIHx98q2652tLOthimmy//YFEbVTc6l?=
 =?us-ascii?Q?ASMVZjRIbp54jsKmC+9H1vn6oBvB7QP0VN0X07WKcKyHRFeqzfc86AM2C/4t?=
 =?us-ascii?Q?w8kpydmJkqCPSXQhROynS6fj1vaPk6JJzCffGcCdFgSxWNMfiJJvQZRmxqf3?=
 =?us-ascii?Q?gR9bq/elM4H6oZjsrZwcLh1W6A312/KH59gSJPOY8mWo4I4mgKFpR0bsSEyP?=
 =?us-ascii?Q?1CynfYbUEB+wRHYZ6yYEPcgHmWbltAoHcsO9B4WGvQVtPmD6SBYaH5DIXUcq?=
 =?us-ascii?Q?vuHQvlBzEQCGK+xuJRB+Da6LH1TF+Lhy7tOF2lw8cJe2DyJZHPVF41ev4P3M?=
 =?us-ascii?Q?UQ1BvC9q9maBGituz2AOwISqICPXh4YGjpSvo45zMo8kAjmBs+SRqzwNK14L?=
 =?us-ascii?Q?kI9+RQyNrkjL9KuKdlT8i4q5/WE8sS8znkl+LDpNmJZFv6AfrgE64i26q+WT?=
 =?us-ascii?Q?i3FEnRaa7AnPuot04nK3LJr6TZoz5dCuBAS+E1+EXrRIewNXd0KObQP0ohox?=
 =?us-ascii?Q?QXS1lDshHPs7Em0VIvZQfvikzPWkJBLWSnZVj+wVNiLZW7vtCwcRNpW8wFTF?=
 =?us-ascii?Q?ItETIGEKd1l2Y0Yg6HQNVUTVkQw8+27mhFr28LLInbRaANJlksfycngHrnX8?=
 =?us-ascii?Q?+c9W+wwpd3ju9dwEHJy175GsA7ptsdViy4HSK9/Bw5WA9s1fcKGL184nxMxG?=
 =?us-ascii?Q?2gRjTh0zaz4EYKa6fV6xjAh+36O4jpKEcOgQ6YQmC5eoZoIGcsyLbFaqZE/C?=
 =?us-ascii?Q?1+EZyy6P9MLyKi6j9oPh+/oxkPzSUuPNOrba9lSPvmxD6c1d2p+aqr3ax28A?=
 =?us-ascii?Q?L/0msuewMjM15HQ50cGLzXQ3+AWhyjUlsItQOt+hxiiLl5syXtu74LHAWTys?=
 =?us-ascii?Q?1v0XUzR2y/c6w0pUOprFiZYW9+YxhKP606y8G86Se9qZVWtkked9jDl+DsQk?=
 =?us-ascii?Q?2Jqr/Cn3CcJKCg7njndbyJkzkwGgsfJcnAVKge9TFYKwaB0/zweNoV1r5sFH?=
 =?us-ascii?Q?ACaQNJOEpuHuCnZOa+KQdid3B+CZcGhK6EV9HTnIjcAdhjEjbcvlSWBipQ6u?=
 =?us-ascii?Q?zdIxuKrgMXFbRjKngyyVjN3Z8vWPRWqiYh2BjDif/rFCnDJePHijPQ60z/zp?=
 =?us-ascii?Q?PfLjkDnNAn+OXa8O1KqrENKGMVb8WrMYI7XXLvQnJ37I4rK52bLmGcx+104V?=
 =?us-ascii?Q?xk+gtFhlbb2NOC+ggXvaOpRMRXcAewaL/4xHdN2Mm9JJVOb9xzFfTnF4JUve?=
 =?us-ascii?Q?YAuKH/nL7w=3D=3D?=
X-Exchange-RoutingPolicyChecked: PaONPJrAC9zHjULkw4/z1VFdYRhFHnLp7j+vBN2AkBJQvCvSIKtoTNnyltkGW50URAq0wIOhUc70GVfILdk1a1nzHA1FSw2CKpHrnEn785ri7jldS7fy4abjJCpNjzAaq7G9zbmdtDbmVDT2xAg1JpHLZMjo/1y8rT/sKxPQGikxw15wQNKoCGnbc/dFCnc9f5bx/ow36MVYCwqY7ka8iHdmPso/h2g3HewEbZU4Vr+5tiUDpmCD4ZERM5V9z7ERmqCIkpIjm2WcLuIBSn4ipllNhYZBjCtix0+lLLa1p6rRy4evP4hPNSTqBS6IAoX8+8WLqokbgrN+VBQ553334A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bc1d9d-5bde-4cc8-2055-08df192fd226
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 05:02:09.1676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oycx/bMsfmz19zVHdFpcgoaFORGLpnCCXz3QvCqKJszoyVx1XEYdkeE2LKdTyneyQRvblSXTX2YTHqgjUQ+kyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB391849
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 07:22:36AM -0700, Sean Christopherson wrote:
> And the whole thing as a diff:
LGTM.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 9a112daa5df9..483998f0df58 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -312,7 +312,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>  	 * synchronize_srcu_expedited() in kvm_swap_active_memslots() to ensure
>  	 * kvm_gmem_get_pfn() (which runs with kvm->srcu held for read) can't
>  	 * grab a reference to slot->gmem.file even if the struct file object
> -	 * is reallocated.
> +	 * is reallocated (for use as a different file).
>  	 *
>  	 * file_ref_put() provides a full barrier, and __get_file_rcu() the
>  	 * matching acquire barrier, to ensure that kvm_gmem_get_file() (via
> @@ -327,7 +327,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>  	 *
>  	 *  CPU0				CPU1
>  	 *  kvm_gmem_get_pfn()
> -	 *    f = X (from slot->gmem.file)
> +	 *    slot->gmem.file == A
>  	 *					kvm_gmem_release())
>  	 *					  slot->gmem.file = NULL
>  	 *
> @@ -336,18 +336,19 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>  	 *
>  	 *					kvm_set_memory_region()
>  	 *					  slot created
> -	 *					  slot->gmem.file = f (alloc the same object)
> +	 *					  slot->gmem.file = B (alloc the same object)
>  	 *
>  	 *  get_file_active()
> -	 *    file = f
> -	 *    file_reloaded = f
> +	 *    file = B
> +	 *    file_reloaded = B
>  	 *
>  	 * <KVM does weird things with an old memslot+file>
>  	 *
>  	 * Obviously KVM would be broken in many places if the synchronization
>  	 * were omitted, but it's important to note that get_file_active() does
> -	 * NOT guarantee a reference to the correct file was obtained, only
> -	 * that the file doesn't point at a reallocated object.
> +	 * NOT guarantee a reference to the "original" file was obtained, only
> +	 * that it grabbed a reference for the returned file, i.e. didn't grab
> +	 * a reference for file A, but then returned a pointer to file B.
>  	 */
>  	xa_for_each(&f->bindings, index, slot)
>  		WRITE_ONCE(slot->gmem.file, NULL);
