Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090F34D90C;
	Tue, 28 Apr 2026 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777376692; cv=fail; b=aZO9aDpQUhAB7EYQSC8L2BR+IVur/LdX65KFX+BwgLQMJsLnCmX+HDU0I5JsyZ0TxSUUWBGStbIiMR+IQWfYs/I6kLsgWrQRhn4hRD4wtZ+pkVfJB4nJZlojTqnGuIjpXLX+UO9z4+ZxhQRq1g82PwOUPb3tRMudEnnsbvAXhGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777376692; c=relaxed/simple;
	bh=1lycd3jhdlSaPWQQIXnLCfbQEzNiu6dI2riGQC1eUqk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mtXqABbi/NHcgz+KAkvpyreqkRxuy+Lmdto/Z5PdoU758o44C8Xu1KcSNhLEQpccGJpMM6RM8ZcCoSLIEb2NDeQfkKm0uAKJVLNScu8Paee3SKici0l4oeeQc/8mwloTey+fQjGu8cBN47BX/mW1Yyvh0Y1VlRGzLjHn4gfn4Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B9CUjBGV; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9CUjBGV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777376691; x=1808912691;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1lycd3jhdlSaPWQQIXnLCfbQEzNiu6dI2riGQC1eUqk=;
  b=B9CUjBGVTHmIvxzn5GaRwC2Zsf074aHtZaQ430FkgCNtN+qSnWC7A8kw
   dVVir1JBFzi7EtYdQhumBT5MzQk3vS0CqhF5t25QsWS4diMJRjNV6M3ZF
   Mf7/D6Yw3TMt+Uh8hr79gcvH7Wdihnk7NYOJxr56S3s95VjK1DcjnMA+7
   zkvnZICJZYfLOSFgo57gULA/26IQFk/GmGOykJri9Uh+IwgcoNqM9SEaH
   4n4ZvCVdT2PhXsf2t71Q5lsaoWas3eS5po3WWBqE12XmoVw0waSefHdO7
   K0ZYNZmEfS2axMJD6BJI4YRKfXnTPROg7x3dz6uGoSPS36B7rfuBNbJ/3
   w==;
X-CSE-ConnectionGUID: 3jeYHrI1T3WLTXy9vuZ4Jg==
X-CSE-MsgGUID: vDxl1dnlRgmXcctfOLYWWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="89662680"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="89662680"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 04:44:50 -0700
X-CSE-ConnectionGUID: zW2iDSauSlmXQhwTLsHG9g==
X-CSE-MsgGUID: xs0pSCiKRvm/KW0QSJYf3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="233806052"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 04:44:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 04:44:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 04:44:49 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 04:44:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1mVMebjo6+p+qkLVhvixeyYRLokEv5EWo5hM7ImcfCQ8ynO/QeCGz4L5DhANs8qQMJyPmAqoQ0mKhkeeI6tL+yGazvlzRhTpLmvWYmaRsKOJ97Ah/cVxXHwBCJguCqjLKvS8F8ZZF6ivcNJ1nNhYgNY83A4zf3/SCt/mPDlerKGH/dNrqJGLu6o12q+DfuLw0Lfma+kUq9QB0KHfQ1iJUdpKtQ8VzMzjqH8Aq42UJYx0DrFFdKY5Qamax6P+Hb9kA5IV2dbUZL37/RxMbaIsZRkpiXTtNf6If/HYVA6U3GK4ESWuU/sEx+BhhYTpxqigdadib51dEI+v4LipRU3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWsiQx/9qjV1L7FcEoDWsvW4rc0cG8C6xPAPDjUTRoU=;
 b=nxLllL9pNMpdaylowLQ6oubdZu2eEBPnucNNLNXLCuIXrhdRR9rPF2UKMoXepU9b/F++EsizsmFpY88AzvzF/0bTstkveVrCkngjYo6w/YLMRF8lV9IV9vT6/+WGVMr9pCL5b/sDKTSWdfh6+fivY2oioAaK4UpolP4Ezd2EEIA0z1Tc4I1W1DABBTbtF0fid8ghN9LYDXnivnQVARv6BjnZvrTBmJgEnkTT5pY2aK85frxL2xRWtuU3S9z5V9smeafNTAP5meVRZhfUtBoix5shyjd5bZctEOmC7axH2VwyJskd5ZA425ufOpeq4nFXYcSRP3G9yWtDb8VyTBXl7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by LV3PR11MB8765.namprd11.prod.outlook.com (2603:10b6:408:21d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 11:44:44 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 11:44:44 +0000
Date: Tue, 28 Apr 2026 19:44:34 +0800
From: Chao Gao <chao.gao@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <dave.hansen@intel.com>,
	<kas@kernel.org>, <rick.p.edgecombe@intel.com>, <vishal.l.verma@intel.com>,
	<xiaoyao.li@intel.com>
Subject: Re: [PATCH 1/2] KVM: TDX: Allow TDs to read MSR_IA32_PLATFORM_ID
Message-ID: <afCdoufK0D+1hKAR@intel.com>
References: <20260428024746.1040531-1-binbin.wu@linux.intel.com>
 <20260428024746.1040531-2-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260428024746.1040531-2-binbin.wu@linux.intel.com>
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|LV3PR11MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 345ec126-2c12-49e8-af2b-08dea51b8abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 0RgtJDLQGBxWEfIxxaj1Z1pFFCrD06qgieeAotn9ETBZywh1PgIdsCIxk5c/Ffw8h/NM3PkG8+KM+PXwwpwbMz8wz15qNpDEOhtefArwoTZcP6A/rsJAIFuAJVO9um6B9QL3+//fiPj7LSkeDgZvrTkjYT5VQVD6zzkSy5TW8BU5mKl5zECT77SGJuAmKSaDqSI2xuraBZc+wNKtxXKv4vT6A+zXxegF0sTjJnPXGY5jUedtR+I+y/ce9Ytu/UQM5f9EdP+jy/sdqj6nWikCvaXkL4GWNTip0H/xPFOUud1Db+z5W5dKsou4r6uqoV8y2rXv1eRIIZiSX84k5HT26xJ4ca/pMo3PZgfSoixMqsvNV+gmMMSbZ3TbxuFxaut3JdDGAavj1x2VQbfyqEreBSVc9mp7wL1/WjbA9cqxT1lIR4eFmy/LiuuUBsnAFwytg5Pz1RPULKq2V8WwYJ8pqAFLn9ht6s0Ppb2leS0EHU3WXS+LvEdhqesXQkeTrhp6As4Blwr6qlSdXAw/B1UW+doSC93vjO+MvPt9KhHxXPSbsYmzaunruohu/C6rHeCgToSTXpbCVgeXOYnHj//cgQeZkRxLNuzyetN76ADOxv4LJQbmW4acfvvXIjafsUeHgtk7G/1NAJXgONpZO3rGKT+GxiOAq2W5+gWg36e3cVAY36rWd1mvi7WbXnmJeO3cJNcP5M+ePhbeZ/1VBmEoUmocMP9V2E1L9sosKmUQ5tQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ifJtwn29BMyqyvXIthjLDKqBcksEyyT+AGTz6abPTdiPKCm9exMnbN2z6vdk?=
 =?us-ascii?Q?zoYE4NOSJeFeWKKLshnHnonJZvS8JKwi1aJowmjyhgtcwpiJAUscwJTBhs7A?=
 =?us-ascii?Q?tYKY0dldAmwER5eELdc+Jf0Lok4wfRjbtvYJ4L/4Jxv9b55lNyfVkLv4fins?=
 =?us-ascii?Q?MSf9B+MrJGdd+cVIWSCTi7+m+XdNYcG1Z90t+WIBkGnJ9OjKrMbI657q3Ido?=
 =?us-ascii?Q?KID3n6KAD9T4KwLPgcOBFnGczzx0P/ta6HTsAS416Gg45nk/AlL8KeZ9fvbl?=
 =?us-ascii?Q?qX9T4Ac9vMpH/1BZ3dKpaVaZCFj6LFSq0XMPwmioH7uZBq6qrFRdoK8G3GGe?=
 =?us-ascii?Q?BYp3fQXFz1dOJjKgBAkJxv9JVz2Ced3bK9Q5EExCLUg3VjwaD2wkUC3NJpBs?=
 =?us-ascii?Q?i0jjqAMOkZCq7NRlRbdeclGbzBRzwRay5W3qGNzBYDoKkyYTVt+cd/B4xsir?=
 =?us-ascii?Q?jZ+XEcRmQUnIVt7IPYkyefIDksBl+zbLDVMqYbL9el1sbNuzf6RnlTqETSP0?=
 =?us-ascii?Q?p3+oLujsj5CIjLA51lSQhlejrBxalG8juzNCd/+Xg3My+ZtDF6CTGPyNPw5h?=
 =?us-ascii?Q?ZxbTDe50f2yInQUygp2gcTv8Z1QRQL6hEei1gsW5RDTSqJqw5Jz0ppJ7aWFe?=
 =?us-ascii?Q?zhfICJ+sFaxgB5XSkxw7fva9aqwD8G5IXppni4/pmYSLZ0xIQa8sy69/XpSA?=
 =?us-ascii?Q?M+PCo9Ru25OuDauZMKiCpDOSH5ouD3eGyLXO0RjB2Qg5IS5QhkL76MQz5zLG?=
 =?us-ascii?Q?ZNUK1DjJdtIqnFyZc37r1wh8YvKsmLLcfHYpSYTdn0I/1umCDbVMxPpI/GoO?=
 =?us-ascii?Q?gj3JFHCm8w9ZpO4IYgLhwgLu9gd4nku2Jn0HtgU5HcIMyRvJJOxeFbSUNv00?=
 =?us-ascii?Q?klWOKcehT3YZb6/O6zR9lTl9h/4pt+1ZsEYEDe2dT/iK4JnWqFvLhExmoFeE?=
 =?us-ascii?Q?DCnSlpZeeU+Q3aR+j2P8TPNJD8RklZG9HJuGqxEkTj9Pfpq23PvDMlpjpNBR?=
 =?us-ascii?Q?/u71X9fpHY9KmeINmh0t1OOTKs1Bln3LJP6l6XIb4tUYAEPE3ooAs10cwhY0?=
 =?us-ascii?Q?qw8dHUr1F8QxgFhxzJTYzmlXO3oAz/Is6TZ9CgWBX6CMShNis7y740Y2gWFS?=
 =?us-ascii?Q?CNHPcksaYtpNYTcgKaOYD2eEWofAD/wVU6mbFPCiOhNRBGNWn4jBukQUf6ni?=
 =?us-ascii?Q?/HhhbkY4zOBFehNmc4MtTuwI8ZPu7RAljgyy/PHWWfI2d6ABQzqyh2K+0oNJ?=
 =?us-ascii?Q?KB+KC5U7QcCNdL/lzLd6weTfn8zLteighyZmpudFURrmn12HMTahHLfrAKPY?=
 =?us-ascii?Q?OfvVzEo3btSptkfMTZXwJryuEMYfa3pvs51ScSOjOlByWHTm+pFwAj1a+7Fx?=
 =?us-ascii?Q?5hQrHFTBC5TWChmIpNEIgoGtBoQsn7FcJdVpwy4CZtglIdgOokQi0msardc+?=
 =?us-ascii?Q?KQabc1GI0nzXfD46S9VZWkp/eMBW/PaQHRk+WLjVxaJEWHHx24hpPBAwk8PS?=
 =?us-ascii?Q?lSfGzCCKsEnBbQGPDWK7L0bYxJWgtrNcC5yAdDujLY76XGeZqiwz/nb5nkMY?=
 =?us-ascii?Q?GiAZiFsM38yvo0CoRzkV8mxN++ADgQg+h48zPmlxlLlVYef2qHs/JaM3tNLa?=
 =?us-ascii?Q?T3Px28/L/k74NaV2jO3br37GhwLZGo2K9vT8xz9lDhjYLwbl4tiM6NF/79md?=
 =?us-ascii?Q?R9S+NB5qtskpCwaouuS+L2v8Y8DM42dT1FHZOfli9J3+JNrEQs/kjb0rxlRw?=
 =?us-ascii?Q?mJ52SWqppw=3D=3D?=
X-Exchange-RoutingPolicyChecked: brKNalvUkAV7YUYWqi5+5b8avkkg5t8nSEIScEqpWeEGfdBXyFcJ/SyfXf0A6WxbWpIOf8XagjCc/yLuFxI2IybHGZr9UwZEW4TWm5jCQP//ogRYJjYhfFyOrcgqq5YcJxvkDYXaj0NoeOzPl0FnVQA+rXEaa/56yAntrN8YgCa0X0XIF1Vi7tKevttnclQXlL1A6AJyWu5Ew11ZqUPDXmJq9VURCVWWWIcfgx3uX6UYkmyNlu8KGe8bAgaoGG7lz+uDKJb4zwudUiEXKAU9vygYbL24oSuun15+CmNO5tTAsZ3IJ/sP67XMufKnAWY2+UkXQLQ6cNY2uDAsA5Zw9Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 345ec126-2c12-49e8-af2b-08dea51b8abf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 11:44:44.5813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95O3LHO8ZT/XbiSrnhD2hzHZcDC0Zey7XEMboaB2yz7EcAt+tbBOT/TE0LW7mjUYfngve2xD/CLBlayGVIRu6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8765
X-OriginatorOrg: intel.com

On Tue, Apr 28, 2026 at 10:47:45AM +0800, Binbin Wu wrote:
>Add MSR_IA32_PLATFORM_ID to tdx_has_emulated_msr() so that TDs can read
>it.
>
>Linux kernel reads MSR_IA32_PLATFORM_ID during init since commit
>d8630b67ca1e ("x86/cpu: Add platform ID to CPU info structure").  KVM
>already supports this MSR on read for normal VMs by returning 0.
>Without support for this MSR, TDs get unchecked MSR access errors.
>
>    unchecked MSR access error: RDMSR from 0x17 at rIP: 0xffffffffba38d6fc (intel_get_platform_id+0x7c/0xb0)
>    Call Trace:
>     <TASK>
>     ? early_init_intel+0x28/0x2c0
>     ? early_cpu_init+0x9b/0x930
>     ? setup_arch+0xbf/0xbb0
>     ? _printk+0x6b/0x90
>     ? start_kernel+0x7f/0xaa0
>     ? x86_64_start_reservations+0x24/0x30
>     ? x86_64_start_kernel+0xda/0xe0
>     ? common_startup_64+0x13e/0x141
>     </TASK>
>
>Add MSR_IA32_PLATFORM_ID in tdx_has_emulated_msr() to allow TDs to read
>the MSR.  MSR_IA32_PLATFORM_ID is read-only by hardware definition, i.e.
>KVM should never add it as writable, no need to add it in
>tdx_is_read_only_msr().
>
>Fixes: dd50294f3e3c ("KVM: TDX: Implement callbacks for MSR operations")
>Reported-by: Vishal Verma <vishal.l.verma@intel.com>
>Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>---
> arch/x86/kvm/vmx/tdx.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>index 04ce321ebdf3..812ad99b11e5 100644
>--- a/arch/x86/kvm/vmx/tdx.c
>+++ b/arch/x86/kvm/vmx/tdx.c
>@@ -2094,6 +2094,7 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
> bool tdx_has_emulated_msr(u32 index)
> {
> 	switch (index) {
>+	case MSR_IA32_PLATFORM_ID:
> 	case MSR_IA32_UCODE_REV:
> 	case MSR_IA32_ARCH_CAPABILITIES:
> 	case MSR_IA32_POWER_CTL:

This patch looks good to me. But the rule for which MSRs should be emulated
by KVM for TDX is not very clear to me.

Maybe we can document the rule here, if there is one. That would make it
much easier to tell whether future issues like this are guest regressions
or missing KVM handling.
