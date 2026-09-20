Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AD2432E60;
	Sun, 20 Sep 2026 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789909075; cv=fail; b=utnt0kRuzhzrFmFerJQfEZyYXnNWOL7f1LH7JpI+cQ0Pn9m4EM+OGsliiq9fQMUZjvn41KgmYknn3EDNRUAUQBaEIpWSbZByLAR4cLPcBS7mxPcTp/7NGmxkO1G73O013UPQZo5GGx5bcw1yK2HMVDLNvqrkYquuWkBY46REOEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789909075; c=relaxed/simple;
	bh=Yx3Fza93KS0tioss9QArF8DYXIlttqCys6BceLUFDLg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T9z1DNd3SyOzgw6uJDYFKFBfDdWXDvBDrUcFWwIQmCsidUaGb2RXTuKgvAWe3sQ50u8dsUTCsaTPrRgwwHnNgvepuIErZbUBC/D/INajt1anW205iwKH6au5AMEjWUnQQWTcrp5WW4OIDGtU4j0+IqMJSifmp2zy8RShB3QpEhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9cTZtM8; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9cTZtM8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789909059; x=1821445059;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=Yx3Fza93KS0tioss9QArF8DYXIlttqCys6BceLUFDLg=;
  b=M9cTZtM8KcJYw3K8g2W9o4l3t2hGLqdO4U2srP8kpi2XYsSinqmUXXZM
   9XpOJdc4P6sfPXSTWGXB0JoeX6Zeq4pkXWQ8VyYCkDMLjZxZ+e7D7Fz5a
   mlHVMFl7h5PNEyAt12NUFzxxD2tBvAaMnFN6yXovkGLxgbmDujWGjk5Mv
   RDSCvgUvDf+TIqDN2cKnt6e1+RORnydDII93aaRGpZnHg0o70wHF7nSU+
   nGP8f6lC+C9M3SqQqn+c2w1L1Vbtj7SKgMgTSmVd57GP6tU7tUzDIuDOT
   hSBPtVVw6wglVGK5Y/o9WbVrXwnVgTP9qgOCEWCXQR7B77k3ZySsdgbG1
   Q==;
X-CSE-ConnectionGUID: P1FiPPSSRIWu1EqCW30ITA==
X-CSE-MsgGUID: dmC0xXQuSnej/6avUrz/aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="101006351"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="101006351"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 05:57:32 -0700
X-CSE-ConnectionGUID: zx0ZeK75QdqPQRYui1JW1Q==
X-CSE-MsgGUID: FMQILm3ZRnGr2rFm+QuAdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="268821359"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 05:57:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 20 Sep 2026 05:57:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 20 Sep 2026 05:57:25 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 20 Sep 2026 05:56:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LX+H1YhUovyl4YJ9Pi0whR2zmu66ivEQ4FgnNQdSf6Yi7rnRWAwFQ59a2Jnkx8ckFbfpo69rKvlop+SCQ7rFuxDHDrFHU66i0mZwHgF2oFTQgJUv5BH8iPqAEyeDrQGuFHSG7sxTdejo1NdE8e+chUqFFSaJuAQngcXm9b/nw/v1NYUgiNVnfKuyeuB079NNm36wOxi48NDqfDnaYFnWA2FsvKeHT7ZCyAZ/mkN6urNDlL0Il/f8FVVUXQYeTSrXJi3DU8GWdh83ka7miPACRPbYsa3vppZSmYHRe2n7QpdJvlqmsNqxGdVzFVFYUOYo4pujTTOlTdn7XNeUk4/AJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mz6ld6TAk/24IjxZOTysBFFxCOCdNBa54CazwUbJfhE=;
 b=EkfQ3xW5apLqT2CDeJKx/qhpxAprVvOhT3Bs2NODjPXqqX3dCVdoKIvCzROZW8/6UiFAsCO8a/Kbd3+Bb4qt+mk+defhpC9kmJmwh4ugF5duDDbmX3adp+Mul3/fGE7GVTsjbRS9uF5FS6610TfK0sR72qWedUB0sSQl8I095HCmSQDV+lyhf3CUSUwbpjy49QriupbqRz29zMFpmsN4CqIuPWtjWYiANRlcqt3aYXuu9K6GwI+Uu2j+lqzpG7BXBcOQVja9L9CVOXqcjuILgRacvlZrOaG5/W+l8/OilPG3/e4NyCAO/42gIf20ukcvNYfJ2/swsw8P9/mtGOMpYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 12:56:05 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0428.015; Sun, 20 Sep 2026
 12:56:05 +0000
Date: Sun, 20 Sep 2026 20:55:28 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vishal Annapurve
	<vannapurve@google.com>
Subject: Re: [PATCH v2] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
Message-ID: <aq/XwK71uNfLvUux@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260826165647.769231-1-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260826165647.769231-1-seanjc@google.com>
X-ClientProxiedBy: KUZPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:d10:25::7) To LVUPR11MB9589.namprd11.prod.outlook.com
 (2603:10b6:408:3a4::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|PH0PR11MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c55307-fe5d-431d-c414-08df1716874e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: ARv7LaQZhCdD4QCnFsVsu6GTlccPWHQxToeDd/A/+iVjJ9O+HaY48W1mG1QwGOcxSCkp9+R1goHeOfkh62+MoYg6dwKTgM3xkcYcd/UyUEjq8Sr/R/Paq9OHN7Ww8uSZLdqpX4HChud2Piz/XIaoT57BFd5zvEFXarfLq24Y8l8z+eDPjDZSTQclmfqee7UmsKWbgPmq0wmNHXY72tj8qsgEFM7sqfZXvWU9G1BXz+vsUJyQUe3lUQcXlLidi2o6vNWq6mhQN9+0uisFb600hb8B0oxcmMUfuZYpVcZJ2UVpm94d7a/qE+0LXqZAiRykNfVWFRsmn4hEzmOni/J+lYgWwrxShTEbxevqRzjj0oI7a8zVuF1vASL62NNXFJrJNwM0Icqe+4ruR5KBtCoFwFxGEzZKk+xz01XSTA/nh9GJdis1A5m/CFiVL6UmY9x/wWRv9csNm/xq3fsfrB3K1f4jy4R20f4J7ePCGSN2pxYox8IKlgEQ0LsSL2OR83au/dJC4l9tUyxTdYCZ0UVGK5orYhHVpGuiVA8ZmZu8Pw9nhW0kat/ixD0w9Y5NUWAnf5gGxwovvMyDWVq8NDAfs4ne4bp4BS3G1yR02xIK2Q1Q8j+gmM+hMkYz9ovHh7Op
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sNoX1FI/vPSU/75g8x3S5AxEwOGxVRM7AvAahVUBCvrMMDrZcW7oZwGKAAtj?=
 =?us-ascii?Q?Yy/thO1TrAnelHQaZlQV4C32P5UQwfI7XF3zUiWWLHEmVZWPaGl1cvml5a/L?=
 =?us-ascii?Q?qJKLj/gcNTMim65HYjheiiIx+kOeOmX87bKU6p34IR2coVWtT/z9VKiw+MiB?=
 =?us-ascii?Q?5y+EpGgT2yK1xDAe7eNGofQ5ZHzi1mJq/KLWBLlDLXjGHHfFrAPZIMzQfuu9?=
 =?us-ascii?Q?hBX8dcNALtz4armwbpe+XlpK6nO5armIAErLkUWN9fu2sLMBA/6SPFyi4/Gb?=
 =?us-ascii?Q?KunHbmwa0Jk3KmQ9zeC6pgp6HRkvqi09SaAta4g6HyMcQjcaqOL1FFCQYwju?=
 =?us-ascii?Q?eKJLIjRQuKn/ZJ4LIpN4KymZOzOA7wh/eAGn8PR4eQM7YGsW2KZmMcSGI65r?=
 =?us-ascii?Q?dizqpwEbHlrBTFdHpglttGeXGLpigplsUKw5aYCECw9iJ0zentjaoBADn+DL?=
 =?us-ascii?Q?WpF0DCc0JrovatcvuKgnziuv/mPR/fPWnH2IGIUNVS+Gom5mZ1jmtXJ9s42a?=
 =?us-ascii?Q?9Ii7kjPzr3kimiJJdCtWRdSeHaZ2C05RAKZRxfB8Cs1fjPrl9MQsbrTt9rZK?=
 =?us-ascii?Q?2qv/G05NRRcXBAXCwJaqpa49CaBWQwuFTomi0xhnExGliqimmwp3Z/oDJIoc?=
 =?us-ascii?Q?VJyzLNW8Biz2H1oQVuvqERNaHuNTsN5Dzofi2vT8OPJwRx1p93+aqTNoriRt?=
 =?us-ascii?Q?eb/mnU4hIGID29YvEmo+JQGx8rZ7pJff80n6JU7cmYtTCV3VMx8RxMC1osys?=
 =?us-ascii?Q?wPVCLK0ceiPojySAiYqLxN63dR9D1XJrJpwGc3ck1+zR2TJSBTECj9lyerpH?=
 =?us-ascii?Q?HQXFswjSggpXeBiLkSMmn005kQHfDy+tdqoXvcZLlDTuaz5CowOKqFy5CRS6?=
 =?us-ascii?Q?OxVtur3YziZwI3/elJsRjoWNLaZ1s4X9u7gG4tvJPVe8f8U7yXROgWhzEopJ?=
 =?us-ascii?Q?fhD2lje0Ro+dALTW9zSDrTykhxrYhraP2gPZ6UEP3chF/FdR1RF2OPkD7Nrw?=
 =?us-ascii?Q?/p0CuNoY91RAr+gfTauMP2GgY4YPl9BCVt2mJh+5+vaWKMOKvzWPB0GwfDBq?=
 =?us-ascii?Q?Db0f0whDCiE+HvA3AKkVS58BzAu6bZhP+FpQzYx0i1KfABAVfjT9RU75tyk/?=
 =?us-ascii?Q?GXrYoRHclJCWD+i33qPSs4HTQcTmlWhzzS7YQN1btgd9MopHAk6dOc1KtUhL?=
 =?us-ascii?Q?Xx6mfPhU1XMNR63sp7bwLBQFdhA3EZxF6URWVfq3Nk7R47vgDGtnF/lx3eD1?=
 =?us-ascii?Q?SP/MqFgPeZ3wfpL4oJeZgBDHqhBxhRvFiPSmERlGgnnoWWBD5VIu4JztEiTM?=
 =?us-ascii?Q?oq2xynavpUxRkcMEFjakioTi3Nv0PrqxQoSKsGiJDJctfMROMePnxzBfXVkK?=
 =?us-ascii?Q?n267WbYZ6I7v9cscbqohQ/1V5j+KdgzgFNngVSiPog2YQZMPDpfxyg79gwnb?=
 =?us-ascii?Q?0kSx2s8iXBUXORuAhzGw9/GOzW9QaKxdlB0111y3BoGDLV/nc8ludG0qFK4s?=
 =?us-ascii?Q?7SdCFoP0RMXuniBhSWJq1rdWWdEdz/q+6nCequc7sOWJ0SuTw7gweYovWALg?=
 =?us-ascii?Q?9kVfRNTB26+wHibWO9zJ3NaA8QMCCx1tlKQNv7vMpK5zZzvcvtm84xHmiBmc?=
 =?us-ascii?Q?GYms3PBHfgq57PtQxU9N1OS2LtLTfa772AyWNqjUgwJl3A+FToD6/A/g72Sa?=
 =?us-ascii?Q?IxardTmXgUWFFsZO/7tGDphDYwS+UHBGapn5nLYutJJreiCsvoTgmL2yEkir?=
 =?us-ascii?Q?kBiunAdrAQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: xFHnNSkDHRMzWM8OoPr5DrpHczRhvxb3Y/HlhxN/+dcHlD1eF04BnVs1MxHnYGwogGsYOnOHGjXgTzKh7w3VODiUCrwfUvnFcu8YT8a6pF7GGU69tPzM7/5PMCBToGSW17T4505k4gD9z0yZAiXK3gxeBo18nsQmHHv+RZz0WQ2aZ+2XaS4uyGg7h7+U05MVYLWWUgpS2jvJdP13VWWQ5Ki6ZbiSXaUEJCjlabmRI06ENZElGiAPfuGbFHBj68m1NvjekW8WuFZYlfqJkL8niHKtLf5BUlSF8Gqeq+g8+C6h1FflIfp7wLPu3tu3G/BkKJ5I/SgwFDomNXghknaK3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c55307-fe5d-431d-c414-08df1716874e
X-MS-Exchange-CrossTenant-AuthSource: LVUPR11MB9589.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 12:56:05.1045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: me7paNzx0QeHGeBLJI0AM2QF192PaEhY0Z00ISo5+rubV8O+Jr76fUAaOrh4U+r8YA8/LMV2mRiSnVR+Y8mXpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5112
X-OriginatorOrg: intel.com

On Wed, Aug 26, 2026 at 09:56:47AM -0700, Sean Christopherson wrote:
> Add more context and information to the comment in kvm_gmem_release() that
> explains why there's no synchronization on RCU _or_ kvm->srcu.  Point (b)
> from commit 67b43038ce14 ("KVM: guest_memfd: Remove RCU-protected attribute
> from slot->gmem.file")
> 
>       b) kvm->srcu ensures that kvm_gmem_unbind() and freeing of a memslot
>          occur after the memslot is no longer visible to kvm_gmem_get_pfn().
> 
> is especially difficult to fully grok, particularly in light of commit
> ae431059e75d ("KVM: guest_memfd: Remove bindings on memslot deletion when
> gmem is dying"), which addressed a race between unbind() and release().
> 
> See the extended on-list discussion[*] for more details about exactly what
> KVM guards against, and how.
> 
> No functional change intended.
> 
> Link: https://lore.kernel.org/all/CAEvNRgGmyd1yqQXsnz5hWRZpBZUs%3DpiEWbEaqP9%2Bcz9ZqEMQ6g@mail.gmail.com [*]
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> v2: Explain how this all works in even gorier detail. [Yan]
> 
> v1: https://lore.kernel.org/all/20251113232229.1698886-1-seanjc@google.com
> 
>  virt/kvm/guest_memfd.c | 50 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 44 insertions(+), 6 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b596486d184c..7f1c6a0f8039 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -300,17 +300,55 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>  	 * dereferencing the slot for existing bindings needs to be protected
>  	 * against memslot updates, specifically so that unbind doesn't race
>  	 * and free the memslot (kvm_gmem_get_file() will return NULL).
> -	 *
> -	 * Since .release is called only when the reference count is zero,
> -	 * after which file_ref_get() and get_file_active() fail,
> -	 * kvm_gmem_get_pfn() cannot be using the file concurrently.
> -	 * file_ref_put() provides a full barrier, and get_file_active() the
> -	 * matching acquire barrier.
>  	 */
>  	mutex_lock(&kvm->slots_lock);
>  
>  	filemap_invalidate_lock(inode->i_mapping);
>  
> +	/*
> +	 * Note!  synchronize_srcu() is _not_ needed after nullifying memslot
> +	 * bindings as slot->gmem.file cannot be set back to a non-null value
> +	 * without the memslot first being deleted.  I.e. this relies on the
> +	 * synchronize_srcu_expedited() in kvm_swap_active_memslots() to ensure
> +	 * kvm_gmem_get_pfn() (which runs with kvm->srcu held for read) can't
> +	 * grab a reference to slot->gmem.file even if the struct file object
> +	 * is reallocated.

Nit:

Do we need to update the code comment in __kvm_gmem_unbind() from
	/*
	 * synchronize_srcu(&kvm->srcu) ensured that kvm_gmem_get_pfn()
	 * cannot see this memslot.
	 */
to
	/*
	 * synchronize_srcu_expedited() in kvm_swap_active_memslots() ensured
	 * that kvm_gmem_get_pfn() cannot see this memslot.
	 */

to align with the above comment.

> +	 *
> +	 * file_ref_put() provides a full barrier, and __get_file_rcu() the
> +	 * matching acquire barrier, to ensure that kvm_gmem_get_file() (via
> +	 * __get_file_rcu()) sees refcount==0 or fails the "file reloaded"
> +	 * check (file != NULL due to nullifying the file pointer here).
> +	 *
> +	 * Unlike most other users of get_file_rcu(), where callers don't care
> +	 * if they race with a write, only that they have a reference to _a_
> +	 * live file, kvm_gmem_get_pfn() needs to get the exact file that is
> +	 * associated with the memslot.  Without the aforementioned SRCU
> +	 * synchronization, the following could happen:
> +	 *
> +	 *  CPU0				CPU1
> +	 *  kvm_gmem_get_pfn()
> +	 *    f = X (from slot->gmem.file)
> +	 *					kvm_gmem_release())
> +	 *					  slot->gmem.file = NULL
> +	 *
> +	 *					kvm_set_memory_region()
> +	 *					  slot deleted
> +	 *
> +	 *					kvm_set_memory_region()
> +	 *					  slot created
> +	 *					  slot->gmem.file = f (alloc the same object)
> +	 *
> +	 *  get_file_active()
> +	 *    file = f
> +	 *    file_reloaded = f
> +	 *
> +	 * <KVM does weird things with an old memslot+file>
> +	 *
> +	 * Obviously KVM would be broken in many places if the synchronization
> +	 * were omitted, but it's important to note that get_file_active() does
> +	 * NOT guarantee a reference to the correct file was obtained, only
> +	 * that the file doesn't point at a reallocated object.
reallocated -> reloaded?

> +	 */
>  	xa_for_each(&f->bindings, index, slot)
>  		WRITE_ONCE(slot->gmem.file, NULL);
With the nits addressed,

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
