Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A43B28D8D0;
	Wed, 24 Jun 2026 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339044; cv=fail; b=rOK8mHpDz/piHxfC1b1b+qSAW7gkpeyNyYxvKqzNRIISCt6/QGBK/r4tQTiwl3dbo8splLDxzE8nYTe8eaOvI3kVMNAF+GkceIxZ3wStrbibuqkD4f0MqXye/0lUzp0/hPopUaDZa9HcN1KFOuTny2yHQmIw6minljYRdAx6Ak4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339044; c=relaxed/simple;
	bh=piNYazHoVK4/r5SjmUMnmgJuhwM6LoW0opVD99KIfCw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LNaPrNq+XnTuz/qCcCTXQQbo1QU9ZhaDeaj0lHtMNobj6hNcBALV8xCoWGoEmsw/nGlKMNCuHf0GzOkPkErfOXJhDLfB2fWjX+HSuS8ERyQ/zc5qAF1ONohzmrz7uT5MgpszuTTT2x0g+X9dKqFIaw6cjpo/3I86ffgZe9BPKZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+a2asbB; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+a2asbB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782339044; x=1813875044;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=piNYazHoVK4/r5SjmUMnmgJuhwM6LoW0opVD99KIfCw=;
  b=B+a2asbB+b4oo5ZIMr2YY55ewtqTSEnMVFlaUFdFX4/ItHnB5xGvVZwB
   5eQFz3d90Mox9TwPg52EA/7/MSO+YxP8vhajMPAF3oM1It2pG00IBA5Ev
   zZS4nzDGAoBz7QWxzKGXkt5YL0/AZBX7tTuSFx42Wc8SqPCdtanBLHyNx
   syw3qcSgKDmR0sZCuSrkX+YVnvRSkN3gwTiolJyBmHFKXrEmHQJ0PYdnV
   gCKEyFoalq1vtNS7039WOvKh7JEa+6gKH8BrmVe4RjJi7fhNl74f1IMDW
   L9r/TYulqTt4301lxf8nKJk1IkST6ltkFz4TOmq42n6T/rtIRCCLkkIQQ
   g==;
X-CSE-ConnectionGUID: 3f2b3VU6SmKbN3mQov2KXw==
X-CSE-MsgGUID: t4zt7D5TTjCt2O1pnyLSEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="94231298"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="94231298"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 15:10:43 -0700
X-CSE-ConnectionGUID: BYM9YlWBSXaJY+w42Ktqug==
X-CSE-MsgGUID: Y1bzruzRQCCLoh0FPP6NGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="247687093"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 15:10:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 15:10:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 24 Jun 2026 15:10:42 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.21)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 15:10:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuwdL8+7C3hcvlq1dGfmZK/mUlllMDzrIQ3LWcV/jQbJfNgowxW6hNGWCarGnHXpdi/dRX5l7v3SdYmCB6BbKrrlqLfF/3QZLW50TZEhf7AGu2+Ui72yFj/kLvBiKQRzK+2sGIPDsLOmwJn51tFvnvkz9BJhIIslCSqRqpbF8Il1xtLpzhwguKlN0+kfRcAOdw7vrfTzo/PVS5rZGFhYcks+BOW8bkOLQ9R2tnQ1huiewJxJ2d7xCOxRyYa7bg6OzZDHLuVfU4MXewfXr0I7+FYJhyC+9nwORyUIm7xrMy1cqjXL9fR3jpqZ1hVJMqWzAOxPW/cEZm2+iMngTghsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c05NloiM7nSJ35D0bc4N1GfUSvSBQKgO24lzqVDRyLU=;
 b=QZHb4NjuRsDqXCalYvpSnteKTeYj05WG8KfE+Fw0tcNGRDA7sXDogFPwCEY6FMgnyb8il+QMLTFwnWShFNak20qdDH5RRTUNeMLiK2X5oHxBiRlo5xDhWzT92HBGUzxs7PJvnAA5J/i8zoloEb8ZL4sf2mFR/+Jytgh52ab4EZcxFLvZnCAew/m05IgcQZ+JyFX3y93SlfP437b2ibrzeyKjJFy1D0DX1FnthfRMA2q5dgaoTeif6zmluBCCjFi12cK/CObB5MRdCk7bdAC9ZXn8fm5AUkn83+LNtjgW1Vhl6/0kvQKJTiPbqrD7q/c++csQPulOf6gdHp1J4nJkTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by CH3PR11MB7201.namprd11.prod.outlook.com (2603:10b6:610:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 22:10:39 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 22:10:38 +0000
Date: Wed, 24 Jun 2026 15:10:37 -0700
From: Peter Fang <peter.fang@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: Dave Hansen <dave.hansen@intel.com>, <x86@kernel.org>,
	<kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <djbw@kernel.org>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@intel.com>, <xiaoyao.li@intel.com>,
	<sohil.mehta@intel.com>, <adrian.hunter@intel.com>,
	<kishen.maloor@intel.com>, <tony.lindgren@linux.intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>
Subject: Re: [PATCH v2 02/17] x86/virt/tdx: Configure add-on features on TDX
 module init and update
Message-ID: <20260624221037.GD923079@pedri>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-3-yilun.xu@linux.intel.com>
 <4f4b0f29-424b-45ed-8cfd-c77da2ea390f@intel.com>
 <ajvG54UMcf3vbJez@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ajvG54UMcf3vbJez@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: SJ2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a03:505::6) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|CH3PR11MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bdadfb4-65c9-4007-77e7-08ded23d6c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|22082099003|56012099006|4143699003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: YQ6vuQgyugsbfZo4WJd4JmDBLKyc6/ErknWY/FubSyhsn/66Sw8jV8lxMbBTr6ZE5SPeFxDzUtlSafIhEbq7X8/Fvza5vMAx2CvjMWxfLoTfgezcjquE95MkJuHcFBJz82okIcHZc6mOKBjj1jQSx1J1qoux6hSYpTjRBfm3f9rl1qDJXadjNmkt1VfHIdY3510U6ls7DYVJ46d8nL2OWtyXRhEeqblEwVX+SztKnvT5Qi8hu4xgLa80QCHDaNdHd9YxvW1zOhYYCUaierIaB90+QqFb3Z4BpD2puXWFX1oXNrERwI/o/wUiEf+dTvbU5T6LCr3iUe46Wb2KsHu/I4W4/4oYx2hcJbe+ZM7dB9S2fsT/yPv5XQ3UxIrMpQeomxtsTVi+ETMltodwu9DRc7whQVx6WkMLPjmqoJ5kqv4q3UcF48l6hQM377ZObcshCpu7xRDdH2BoPps5O6XIjIaE2fFx8gRbsvwkQBSnVi8fdUeaaMPclJw9VxRs8/PnDwI2ffXYswmWANXI8+grvUipgW3azD++fnMYH+kNsw7VbkLL722U0zJpvyhPZR2M4S8VQTFmSJ6JoM62pBdjX+QG3QX+OfchwqiDYJcMO994H3zdrrgGrV218myHNZkcqFkjPG17+N0h+lH1XQ+p2d3d/pS5yVFWp4Sk4DH9GCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(22082099003)(56012099006)(4143699003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VtngqVTkLwjNZQN59h2JaQ5pv7o9ZkCouh195furDUR7nZBye6Uzcn5uks2x?=
 =?us-ascii?Q?bO9RXgGTeJgXeCZxTXMZLzCdzsdDwxw5kBuDpESPxRymvo0R22HJO/kI5zEE?=
 =?us-ascii?Q?EuPyVbyV/87n90JnRFoi6TWe29EW12QKMuOvEe0RwxAo1GqXPxtLknl80LDx?=
 =?us-ascii?Q?QkPsVGpZuqIBYvWFQhjLe72qxGBmrcTGSa8Xi9k4prV/gZD5GBETzYv3MfWA?=
 =?us-ascii?Q?VcUvPDiNbSdrXqgwg2D2IXwkCzafzn9trfy6Hvw/qsC+gVzpcoNV08RVxbSb?=
 =?us-ascii?Q?C1t6P2W9hmhNKD4vWwBQf0u49iG0zpB+od8HdH+HFSLurWfRTlvaou+FUi/s?=
 =?us-ascii?Q?8CflWkiDtGJP3xtiFxmdAmbH5miLLoPFy8YX2Mmg3NtGH14DKsP1WCAdem2t?=
 =?us-ascii?Q?gIsyuml+2Frl2bKdZ1PAtBjZtwYhQlMnoR9BVHvPQ6DeBv4s1Dm7vtvGgXNo?=
 =?us-ascii?Q?bZ982ENpW0tQ78QPEhAUauEUDmDJKI4L6FxO4NwGlvqLNpvs+VwFr+WQf7K3?=
 =?us-ascii?Q?UQqaUp/IAY3Bg7phrXnG985Sez/KdQox+f0Gc6ttpZRMMEFzDj9bsj2KzQGU?=
 =?us-ascii?Q?UXKIq4K3vz06s9iX/NRMm71hZ6GqtvtHnRXpX6tKGwaTwr3felkCxFmiHmI3?=
 =?us-ascii?Q?jP/aLJ9U+mRJRxdOV226JwKTAkutIfR8mky2dSSRk4bnhetp1vnQtImEpIJH?=
 =?us-ascii?Q?aI8Vdak9AzEZ+llKNi7sPUOWc0GPt00yQMVQ3PuvYtOCbgzJns6ziTS4Wyk4?=
 =?us-ascii?Q?WaSGpJXCm6WfMupJw4+tpHTxd0SCVmxfIbIRRpnRDfjOmrfshPGtZZ3s5fBL?=
 =?us-ascii?Q?SaL7VeU62NOJpeaD7w9mpK7DvUE++adcKFoo1JnJHVvANGvXvuIgypJyeFcs?=
 =?us-ascii?Q?sdtByB2vEiuZghQzXGPG2h4xlu+ekrF2ExzSBvKf40JD3Hg6No9eIPCP1nkh?=
 =?us-ascii?Q?Hhz4U7kjyDMdWUZdtWGy3UKp3YjOxjGdLN0XKYXGNB72/ZwjMTG2a1pmJaA3?=
 =?us-ascii?Q?goznCVKzucrJheFy3L89H4d9Gp5oclrAHuFAuLHTX2VN31I7JB7AafZTbvEv?=
 =?us-ascii?Q?eCNnPOxVNNjMurS72nqgdzCfkIFyaGjzFuuoyTUm4c6EuMKgEorSwASUaMVV?=
 =?us-ascii?Q?gNmvYGhK8Rc2C4cpPjGXmJVVZWbeQtpQ8I6v7wJc0XfGXn3NRWOhgp/hYabe?=
 =?us-ascii?Q?ycPZY1cAc7EwnRkyAlXY5EZEMsi1iU9GNTOzikbZeomQ8pnjxOgRJYKoibn0?=
 =?us-ascii?Q?8C3VNKMRWZqx1262Aqxhzz569XZXFkwPL8I16YMLSlqYHCAtG5j9t/etc+WG?=
 =?us-ascii?Q?bdeXL9Z5bBDY3fV1Ecn3xjSyRQtsr5502c8Kg84wvvpVDatRw77/Lb1M/aa+?=
 =?us-ascii?Q?7aWWQj21M9BIYuqlWhwPQfCERHBiaGwf7/JdW/aoorahrD6LGYeigjXizvGA?=
 =?us-ascii?Q?j5sJlCwg/KL5nC0eWRD6FRGK/yGImHyvg3WPeOK1smeamj1xzGuN2Mer1ikN?=
 =?us-ascii?Q?bv5CmpEo8R9EXxU4Zvw9NTzg+nf7ffKWs3/AJWqqwKjoDqLCunBHbaaGKjkP?=
 =?us-ascii?Q?9d9NDuTPMmMdME2dB6p3OwSGD4yoIulAJIezBWpcjpWpQP3BmvDit+uhHEdX?=
 =?us-ascii?Q?cttI+oVFIp0UkJiOB4FBBrlMuq6NIrUVze55JY6vnx8Gqv5rwFcf8U3Cxd9r?=
 =?us-ascii?Q?CwQCYwDzerH6xV5yISJd1MISe0gPPO+/WthCdOgA0BXe43YWt/F2DxtL26Iv?=
 =?us-ascii?Q?el2MXILwmQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: TsEdSp7ykdNl/0n+jSRm/C+REJzfqXp/3/BqHTUFww3qSvVYqDBI+jxo76nCHcOrImBRag6mf+yZJP10Jy03grXzS1GKkUrKKEKH6lpAF2gz/7kGiBQ11aBQPBRQjbAiYrXOLf/9Af3yLudOXirXpa3jRAzMS2Eli0iGjW6Owdezg+Gl0kD3AByJ1scscVvrvFn43QIfCkx0R/vMZQlBvcn+5iurHlKV7++MIJmomTWliqV/6T6O5gI7Yr5kPJHTSdIT+R7/eU4xkC/AZ9cEIy6g8MagOtaIRCSd11pJuyLr/6Ff5HXaidSCCJLLe9U3KN4q+3VP2qHA1NgPUjHOJg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdadfb4-65c9-4007-77e7-08ded23d6c66
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 22:10:38.8317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWpresVdQtO7oXuKQzTZRp5FJ1A4GYBTfRpljwm5Ie0v05MYj6rEOhk1263xkRzDv3/q158T8oT6fQKi+tiklA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7201
X-OriginatorOrg: intel.com

On Wed, Jun 24, 2026 at 08:00:39PM +0800, Xu Yilun wrote:
> > There's also zero stopping us from putting version in args:
> > 
> > 	struct tdx_module_args args = {};
> >   	int ret;
> > 
> > 	if (tdx_addon_feature0) {
> > 		args.r9 = tdx_addon_feature0;
> > 		args.version = 1;
> > 	}
> > 
> > 	ret = seamcall_prerr(TDH_SYS_UPDATE, &args);
> > 
> > Eh?
> > 
> > That gives args.version==0 in all the normal cases which just happens to
> > be the exact behavior we want. It also avoids having to plumb version
> > through all the seamcall*() wrappers.
> 
> Ah, on 2nd reading, I'm pretty sure now I understand your logical argument in
> patch 1 and 2. It's good to me. I append my diff at the end.
> 

[ ... ]

> diff --git a/arch/x86/virt/vmx/tdx/tdxcall.S b/arch/x86/virt/vmx/tdx/tdxcall.S
> index 016a2a1ec1d6..d1d3d40c5614 100644
> --- a/arch/x86/virt/vmx/tdx/tdxcall.S
> +++ b/arch/x86/virt/vmx/tdx/tdxcall.S
> @@ -48,6 +48,14 @@
>         /* Move Leaf ID to RAX */
>         mov %rdi, %rax
> 
> +       /*
> +        * Extract the version from 'struct tdx_module_args', append it to
> +        * RAX[23:16]
> +        */
> +       movzbl  TDX_MODULE_version(%rsi), %ecx
> +       shll    $16, %ecx
> +       orq     %rcx, %rax
> +
>         /* Move other input regs from 'struct tdx_module_args' */
>         movq    TDX_MODULE_rcx(%rsi), %rcx
>         movq    TDX_MODULE_rdx(%rsi), %rdx

This approach looks much cleaner to me. Would it be better to have a
small C helper to encode the final RAX value instead of operating on RAX
directly in asm? Looking at the May 2026 edition of the ABI spec,
SEAMCALL RAX encoding is starting to get quite complex. Just thinking
about this from a readability standpoint.
