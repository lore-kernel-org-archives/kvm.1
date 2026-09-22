Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9425353C3D9;
	Tue, 22 Sep 2026 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078052; cv=fail; b=JIswuAR1p0GDdBVakmWjk2P4VvQXhmEf4oVJekhUs7JzxVUVC8NDtOlX/mBfwTJJQJnDXericbMYTJq/fGhSj5tlH3hVGvLpePz5VY4LCYD2xr2gGxhILFHMMVfHHSSHkIC5u9vVvxl/yKarnq0qpdTZbHHL1Xu46GGE5wtrxbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078052; c=relaxed/simple;
	bh=I+sejMm5vLXM4FHtjbEnsl3TMzDBf+OMnbqAHMwnPIA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=klAQu0hQjtgoeKUUjI4VDvcSQHdb6PYtpyYXwBrvKpdAj2jefdty/DQv6MvJHuuPzsaMRcWfRVqoTcuPbN4b7guDsaKC4rBsJLeYoR2o5GQnysS4TqWv1tI12T8vvFi7t+4g2gjSxXSWBFkj5KI0mFR3bGPL9oYN/FF4a0VnjP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jLa1a194; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jLa1a194"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790078051; x=1821614051;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=I+sejMm5vLXM4FHtjbEnsl3TMzDBf+OMnbqAHMwnPIA=;
  b=jLa1a1942KExpF9Y3Bbxineg+61wa+Xmg9XmDqdK9ogdyKqwPPWm6Amq
   /8GEJd4vPEyfqYUylcpvo/+7FkhAOV342Rg5MbkYXmZMBLfEkhFNcRgS9
   lssa4n58mGx7z2NkAghTOd2c5fO54H+sqwucjTo4X95PLp4oTmoKP188P
   F19S5fWqLDUxe/+Iy4EhhzvPeKh/6yMK9ddbx6jMbSZsKFSQS8Ry7o8KJ
   xcGLWMgeo6wM+hP9+JqRNrRDKPZnHvIOQiXlATKh4N9k0RynL7ZoFEfgU
   uIGqeyWCpHRUx/l5Ibm6vvrMQEo6LoA8py7eh+yxo9L5Lnak+PFTAbgPX
   w==;
X-CSE-ConnectionGUID: dMgfgCGuQVm4eArQikTHnw==
X-CSE-MsgGUID: NdUFZ5NBQz+AhzOB4gjBOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="93174069"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="93174069"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 04:54:09 -0700
X-CSE-ConnectionGUID: LyHa/iv1TQGW3IDaWmqSXQ==
X-CSE-MsgGUID: 3vK8JfaIT3eaDAmSJjaALQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="271660621"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 04:54:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 04:54:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 04:54:00 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 04:54:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZQxth7yAfvwCPC4FE10EPSHImDuYWM3N+gUUXVuXg6Z/ltpYvBMS8htlFgISDuZpSRtoANmp/oEaU8XJbs8YuMBSyC3SFjhLfmbq/5rg45VQxZ77CwitElPECOSwGKOJb/yXi9aBOlNgIsYQ0zivrmRlG9spimEZyv8MvpuAKbtcqeZqi1cDxxOxoeTm31Fcyfm38xWP2gm/7Kk6u6h0Eb4bZwmrQkoYB5cq1JX9BqpOSlJJM27yOg7gHREg6qDYd3Q792NLnoAvg0v/p0YxWcQDOuJrmpQJ5QSg+HHyfp80hFqBtmbuYH/Cz3iZzyTBj7jahVz0vt4mLTaH3qLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eVFFANDez+O27CJdPU5d0aZmgf8EoZix8Eeh9ti1Yg=;
 b=f1RuQ6fTpTQRvFJgADZ0RKPTDsYEHG18Zvh7VgGmg84J/PNOhw8f5fEoW3GFJkEyvMeB+Kl9SVQJ33jJ4CZqOMxupeulwHHbiGq9rXLtNyAkTF+ww8HHvQSSlJjfYocrpx6ExhRK9zpcfHydd3TAYfvtvY1sBxuzGiRVXKXZxnjeJaVFqH8hlW62sGmgXH8bpsbimpzosAW/uT15SWVro9Kqswx+YsegnRp+ugu8hPOkj7QrPIvTtzma2GAb6yOKwBxmRaf/ffWnRnK63MfsBo88/f7MTzPEWXKWLD0SyswnrIomRVThU05N4A2vPSXUXKF/oUIFtISdzy7cyUFxPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by SA1PR11MB6568.namprd11.prod.outlook.com (2603:10b6:806:253::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 11:53:55 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 11:53:55 +0000
Date: Tue, 22 Sep 2026 19:53:12 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Stefan Teodorescu
	<fane@google.com>, Dennis Tighe <dtighe@google.com>, Sashiko Bot
	<sashiko-bot@kernel.org>, Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH v5 6/6] KVM: guest_memfd: Drop superfluous WRITE_ONCE()
 when binding a memslot
Message-ID: <arJsKA8MkSdpQxNm@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260922001332.1121266-1-seanjc@google.com>
 <20260922001332.1121266-7-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260922001332.1121266-7-seanjc@google.com>
X-ClientProxiedBy: TYCP286CA0352.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::19) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|SA1PR11MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 074bb5bc-538a-4918-728e-08df18a02daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: jEBcu15UdcOiIPgOxuUMQLFFlmPSJGreGUBA7m/VKeBTfcj/hJJIlqSL+8Qr0oXdYid1IsbkxHIZP/8LvH8NrGNmzb0noLWSnkf0alou8C9FRVnoptNGpNqlqwGJD3BXvUyKSjdzxrdZUwUbxUHbkhim9yMRuUHe6Avk3kJm0SOa8X35Wgjw0MigjUhj6wMUgB0X7tE/kGsAeodpmGRBSuqbP9+0lCIetuaK1QnIFExryT63DFVpTsFyhQNDftq1bPH+chOSLjhGHVR21mQGLc7sV5QVCIFJoXbOFS8Lbz3aqIxAFBGk8zUdUoANXrf7v5KQXN7wh2Pjv3rhFqUUSw7lDd4od+d4SEQ54MDOodffZioM3U+JfDkf6i2dAgMqhzpejCxjHbWV8bMSkFBGgriFjQ8W9cFWYrpYRwqPNjQir+JAR495oDf2qfNm5KmCcSxsHHof23XgWPCRCZlXOrV4KMhjtm2WVidSw+044CPewTUh5sLGCro8Qpy8P8wz6GxH5H65si4B1s4donTqtFvG5hz7uPFDfCaE3Djf+DtqmCm1vaIJyO636Qc/HtWSs19sF8bO/GhwXABi0XKVSWm/k8/wiDLx4fUDFjETujAr8MVPOZxpOGdN3SfrpnVGuM6rYb8Pxw6DPPkvuxME2XbwvlD6z2aC/IWCuxyerX4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DQFs31kly8gMZJQl6JF5glhy+EQJjNg/u1wukQNvOTrdDjdnDzvuuGPNvBLx?=
 =?us-ascii?Q?QZEqkmBs2QvFvYbRnbOn7qGfKbQk6WPfv00rE7aKRPr0k6zpAFvp4Tw/anzv?=
 =?us-ascii?Q?isZ+OdqCQ6a7wBzFUfL61XLxE0nSeGUmas29ElKonc+yvyYgiGdAKxw/yJiN?=
 =?us-ascii?Q?1uWtOyKI+OZtHpkJaWt6x7L9HQgoD7sLoZiz7TAYfOBBFG0cq7lrYTIGPULD?=
 =?us-ascii?Q?209UlKa1roD0r85FOZ4CrjFyC+0KBEh8DSA3t6QhpQPoCnmlUAzV2ocdMa48?=
 =?us-ascii?Q?YAdUNBbOYbTel9vdp1pKdEVqipJ77GddS3xjrIlQ0hP9clUuEO90sHKVoJMU?=
 =?us-ascii?Q?YOVyfiDpfzhCK5mfg6qAsTFM2xifnwkP95lt9qonXGPSW2wKCXDOxdAek8G0?=
 =?us-ascii?Q?Ie8kHI2N/xLKCQDQLt8BHDj70mbMzKdWklk9EMfsV4SnxMQAoHnqjsdZoIF2?=
 =?us-ascii?Q?0n/TNBSAAGh/5Qufxw+k/PcSMEAfVbmTcoM8AzPBa0TQtH8pqQ56YDHE4n2Q?=
 =?us-ascii?Q?FDSeUdfs8bFW4CTKiMQc+VcBqRgeOzBIJruXESkH4YKBHGG4NyvxiHANX4ra?=
 =?us-ascii?Q?pRfU1+HvO/GD0CBWW2xgq2yw+21NCuWes7n4jQASp5bGA/Rr88Scxdsx04I1?=
 =?us-ascii?Q?1PRrvePHDWi5yuBPhO08FxXWaysxzhsnsvZ8M7+m6QPwyIly4ZY9YIKgaICs?=
 =?us-ascii?Q?RBnYeHqB5l8C0UAQiiXgAw7hSnMzEhYmYkqx+DPtEzBZ9MJ27V1arARoQjnD?=
 =?us-ascii?Q?P1IcCyAKdZX2qa61WZ8KqR1hAHSrli6GEyBglMgNPHuxhjBADF4XlL62jHNM?=
 =?us-ascii?Q?UZzrijRr+L78WOQJtw/yGqVdHeInOLmRiyXGS8oFNufpeAZvd/PPOf/mniG9?=
 =?us-ascii?Q?0lFUhByRL8wTDuYKmjJAdhy3JBEnXVAiDt0BSNeON3wzaCwPLCM1rMBSznz3?=
 =?us-ascii?Q?dlSG7+yXOP17RaRKhXmoFo/t8fXCSMLL8xBqoaOJ/Jan+HZeQo4+RY74DiSf?=
 =?us-ascii?Q?quXvbe9rnL2QOTIBq5UXvJQzQd8UEIqSPrNIc3v2nj7brDJg9E4dD3phpalE?=
 =?us-ascii?Q?3BK9A8QPRKVV8xPVGvkdXHbLUjUbEzv3VquFdfGketxndqCt8rSc3Bt5/U2Z?=
 =?us-ascii?Q?e5tzebK9MbE72t/s1ByIAu0d3DEzaXgFulCl5VY5+M2IGItS4wUCTj4FNzUW?=
 =?us-ascii?Q?8aqvpfteDmwucyBWAFTPf1Pu313+L+KgVLW2Ht+lCd/d4LxbOxMiTbV4Dmav?=
 =?us-ascii?Q?ou/dIA4ZRcpMwwOF4OgoOJNR7oFnOKNdd0xw8dcFHzkKz+/9PI1VB9eYz1Rj?=
 =?us-ascii?Q?oRrMUAylwV5JkGsd2kytlqLKL2bdItgIm65+0GQFR8OkLGtysnquR1+yr0o9?=
 =?us-ascii?Q?wt0WsZIYDkDMBrRFkX9u+IaTO8/m6jEgkooT1ak+i1poNXuIjleSsOBCJMAe?=
 =?us-ascii?Q?NtoNEvRuWjgkgh5IiN+YZEAT5JWjiK7puHhOApddzJhCqzvGsr+MZex54S5m?=
 =?us-ascii?Q?r5ejjtX0OBUOHjpQq8qydQTtXwiFbyeyWzjOxpIAXn017c9BX8CxLjaaSXyc?=
 =?us-ascii?Q?WDqietxZvnxxxdgX9kpFd3isUqLvAVl+ZshwoTiJATUvcfUQJ8CNtEO14sKb?=
 =?us-ascii?Q?YlQJdxdH4U5PiNjXgWwzs8ZJXAT8ngQbxz8R60fMrQN4WFjloG8ZfToaCJta?=
 =?us-ascii?Q?8iPA1pqtTRCZ2odcfLzoavHBOJcugugg508moj5DWQdmi+jGyblWft0a1GMj?=
 =?us-ascii?Q?9dfVwJO/PQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: JlOkqifHER6NOuzlGXGSTPb+pIR25yqrTzt0OivPuBNLwDGJLge2ThLFxM0uXlCfFI5KgKnCv5zq1mDZ0c7E2JaRuFxus71mLdTsH8w4/1jBd56Qef0dSl7iYvgj9ZV6ibGHonYYqpq8bT7pPWpdddTn9AZKwxQnsbpXXNHmJi9DWm5UJ04snBeErS4Yd8gcnNuReQ9FWMmcAK4dv3PNa5OQmXRLEoQb0liZod9yO6nxprCXpKptlINNT+xq23zIsrPlgmreq7VQLLRGzEOOsnPopfnD3OS3wMjI1Pvfl3qA4DRZUD4w7NsCWRpsqZL9o1tL9LnHCgQL9/ns02DYEg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 074bb5bc-538a-4918-728e-08df18a02daf
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 11:53:55.1360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 044cJsfsXimUU00IVgjD0N7ZC2guhxt/0P4lxOBs5WlGP02KI3NaCdT3rZmwlg3jLV+IWn6XyrvHTDYzlhgznw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6568
X-OriginatorOrg: intel.com

On Mon, Sep 21, 2026 at 05:13:32PM -0700, Sean Christopherson wrote:
> Drop the superfluous WRITE_ONCE() when setting a memslot's guest_memfd file
> during initial binding, as the memslot *must* be inactive and unreachable.
> The superfluous WRITE_ONCE() was added by commit 67b43038ce14 ("KVM:
> guest_memfd: Remove RCU-protected attribute from slot->gmem.file") to
> maintain rough "parity" with the existing rcu_assign_pointer(), not
> realizing that the only reason rcu_assign_pointer() was used was to make
> sparse and other checkers happy.
> 
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  virt/kvm/guest_memfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 80932f4ec4a3..826d26036926 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -677,7 +677,7 @@ int kvm_gmem_prepare_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot
>  	 * kvm_gmem_bind() must occur on a new memslot.  Because the memslot
>  	 * is not visible yet, kvm_gmem_get_pfn() is guaranteed to see the file.
>  	 */
> -	WRITE_ONCE(slot->gmem.file, file);
> +	slot->gmem.file = file;
>  	slot->gmem.pgoff = offset >> PAGE_SHIFT;
>  	if (kvm_gmem_supports_mmap(inode))
>  		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
> 
Thanks for the fix.
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>

BTW: some questions regarding read/write to slot->gmem.file:

The WRITE_ONCE() in kvm_gmem_unbind() and kvm_gmem_release() are also invoked
when the memslot is inactive and unreachable -- are they also superfluous?

Do we need the READ_ONCE() in __kvm_gmem_get_pfn(), considering that other slot
fields (e.g., slot->gmem.pgoff) are read without READ_ONCE()?

