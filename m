Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149773CF678;
	Tue, 23 Jun 2026 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204268; cv=fail; b=ATj28CBrh4d/VH0ZhSBsszg5Utg48CCxHYCQBAta6iP67mHOo4u3p+6zfHk3s0kxWTXzwWyC2tto/22ECUx9Q7txEjekNwpiu3GxblMiSFZtT87q5FJng6j3OeqzOAvQC4qN63b/k5/7YL/6kHd3x6G7mZY0wEZVLcP6wJvN/wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204268; c=relaxed/simple;
	bh=jgy3LzKopwzzIsYUV+IOapJsWwrWXda2unIWJeFfGwU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hng8p5MEuLFtxZDtc/7whk7vY6VDYzoQcg9jL7+pBOGqGY1H2LrqZhTi4L15jUWYOZUJpLivqzsJRHqbaG5ACFMxS+bD7miHWwO1LzuYCJff1SPPaASusoM2yWyZUCSfYMY053CKlsBT/qiz0knMipBrhDNAIgtYyH1obt8djCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bE+YdMem; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bE+YdMem"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782204265; x=1813740265;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jgy3LzKopwzzIsYUV+IOapJsWwrWXda2unIWJeFfGwU=;
  b=bE+YdMemqHE6WVLUQPxC27WTBHlushnOfdOn9nvnnOjH5T3jarbjOs45
   orvWMq5+iL4wSyiItRPSL7h87JBQls4Aarcl4r0AG/ST+ul/JgDIhViFz
   5aBCht2imIIk9RDkc3ZfcS0QVhrd09b+MUCkfmzQ7wpLvSLc1wktvsH4W
   wDZKThI6SnqvKKtGCk9yKOo6213I7gDJddmeEOIDQMWnH9Auw3hSoM8O/
   ID2ZC1jIYgvcfahvEketv8LJqHF6R6eFtZMSpLamu9Bc1JF1164g3d4po
   TkAx3bcWaXcyn+90RBUCuqyxF43fBJF80z6bzamLZJOydRlE338MnkWpw
   A==;
X-CSE-ConnectionGUID: o/I05+WISWSfj/kZLtZp/A==
X-CSE-MsgGUID: 7SPDntMKS/Wv4IEaFa6QDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="70459127"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="70459127"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 01:44:24 -0700
X-CSE-ConnectionGUID: EaIagTq2Qn24pWIou/bzqw==
X-CSE-MsgGUID: UDa3CqkKSgOCJaGRLezecw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="247116443"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 01:44:24 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 01:44:24 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 01:44:24 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 01:44:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAoUBvd5cYbkv4tjDoTg6wveZUoQxvyMm2PrEokPHjSB9CSJxBm1S8D7FBBW8z9JRsccRojdxVkvR1IcM9MSjIFnmNJLn1sGfFtGOd9m+KW5HKQEp0IvaoX44baZkdHmUKys+Sjw0DSYSHhpL4SIV/jMrfT5UJ7kFcLug77d2eZp9nrkxBRRviTPUTWOaCU2GJ715cWx7I8xQOk/qj7NJvwdigbsII5cDtTs6wQhvxvV5nDL9WJzcPMZwcMj96xsRRFhTm6nVgckxpUt/wvANwoeVRL/EfBusjgGTomQnu0YnsrAOoHdUUle41lGpyz3hKpcuxMymZDo+gj+LY4xLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXUw+XU/6s4cTDIZVtKepwFjauLL8rQpKpRBMDYqvwM=;
 b=xkXtW8Ki0TNDe3NaPOzwnIUC/HQjN5SB/gzc7CFtY08mKXadLk590eYgrBRKmxX9p5a6EL4dsvfet9A0UKDrnPMjbH8bCSBSDf6B1Fs+8QP2jszMXGlT175JiH4WoneDzx6Q4i9aYdWeBw+Y7RqhiOb0oz8n5WcXDdtMMQQd+qHvCL0eHbb4GddQrxGCFB0bWlC9PYFpMcitKuoyxLJaHJGVL+iWQjKpNPKuhisWDkuSfGEfv/WdVcwjU31ZgcrQ3N6Hw8VmoZZc8id200OsLHdV/CKm58ViSlEhJELbhj6W483Q0BZuTNO2XtVMU85iS3pNJHnsVukBLBczXNfB0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by CY5PR11MB6341.namprd11.prod.outlook.com (2603:10b6:930:3e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 08:44:20 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 08:44:20 +0000
Date: Tue, 23 Jun 2026 16:43:48 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <x86@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <djbw@kernel.org>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@intel.com>, <xiaoyao.li@intel.com>,
	<sohil.mehta@intel.com>, <adrian.hunter@intel.com>,
	<kishen.maloor@intel.com>, <tony.lindgren@linux.intel.com>,
	<peter.fang@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <dave.hansen@intel.com>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>
Subject: Re: [PATCH v2 02/17] x86/virt/tdx: Configure add-on features on TDX
 module init and update
Message-ID: <ajpHRNaq+z5bdn+R@intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-3-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260618081355.3253581-3-yilun.xu@linux.intel.com>
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|CY5PR11MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d046952-9f20-4c6f-f4fb-08ded1039df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|18002099003|22082099003|6133799003|56012099006|3023799007|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: d0r4M1s74nQZAw3ZdGu8QOMJ0K7U98lCCKoJJ6tTtHdh3saFMiI0Vszk2UaUvNufFASchRH8oRW0W8kp28wIIR6FlXKIUwRLldphTp2YtrDaoeFQQQpMVUdfntL5aeyVhBlN8RCq8mqEauU4qCXVJEgEqQxrqZr8oWnzN9p8fbZoqJ5SoMdX0zgMN1B1d+KnLvxBOrVcnFRwON8A8w8anAMt/NXsWNJgFcRy7ywEEvekmOBJ96lbTMs3Aaoz+z9TopPM+9I+K2AXOh7LgM/eu89XWg0PlrwgnmHCqO6cZ9dq8YaFgh1bwQVsMLvRzaiYZk8Om80klK/4QVL0Ah1ZXruS8914L/P9Q2gOcEFSeIX1s9/DV96r7EKlSlOVzXHcosfP49FWs/GHevFGiXz7gXpYAQ1Rc4Z90bcUgB0nDHpmbWMt4ouOTzujlApeZOMW0scs0GV9Z8yXLVxulcOT7OtH8UKYfBPzNgyAXF1IVo+z0bPT4asm1IvM2NO15mfp7GLVOHKsVWqlE6FfuH5hrwjcrSLd0tiH6CHL07QeC/TCfEBE1JDq5mmcJLcR6Qe3R/Mzg9HRR46RS7o2MNMIe0xBOAZxFCEkRtgAL9yeC75MqMPZcu4M+UUlRxHw8K6nwxpfZainX5RochmRnoJnewkIBrY3aZ5/KHp3z2yOkg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(6133799003)(56012099006)(3023799007)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4zCzZ4xK874ErPdoASkisgQe1kSgGnxn+DR/N+d6Xk9A/AIxQtO1SPVQ5aFF?=
 =?us-ascii?Q?9jYDjtNTgR4ASxXGPz4OBKAl2uFv7htCIQ8uKIvFDjISev57HllXZg5i1SsF?=
 =?us-ascii?Q?7gH6XfthllV5wy8PH/9YgqYqyysjHLEwGo7cbIgLvG0t8evfwmqd0Zl1jB/T?=
 =?us-ascii?Q?xJvOIX1MmgxXoq/1I7xVHraQZ6n5Wx7HuB/u+apCyfmlu329F9hUuVabnCf6?=
 =?us-ascii?Q?NRzZ9E0LI9oqJvG8mdunDHOWUQ/3eoDkM8kMvfeLa1vlwnuw6mSXodoX3V6W?=
 =?us-ascii?Q?VYkngo3nlUFe6Z6O5Bo+3swj/MgDQbLxPa+zzcq2BOmJ4IJ8LPMzGoMCSTWF?=
 =?us-ascii?Q?8D9/jkPhOjI0kVmmjqF5HvRCMntE4qqRUiW2smBTj0dBDSvBO+awpGyyJnXm?=
 =?us-ascii?Q?RvIy4qx1rPw27BnQvxXsrVqDdVVwQI61VmBEOm+fIlN+F/4CUh59OxI6vN3h?=
 =?us-ascii?Q?jfuNFVPin5A2A16eW8n3DcqwpLLcX26XKRSKD0v1yk3YI6vk4XaGU4PJuKaA?=
 =?us-ascii?Q?n146PNw+zreS4iIQcL67E7u6VfyZqHeHaRwgi44mEhMZFVCG2d+GKljrTeBp?=
 =?us-ascii?Q?N2rXzVYiObpIQIJuARO/++gPsZjyAXdao/Rce/s3r2K3M162ukZHmfRaRz5W?=
 =?us-ascii?Q?+kCapZXj3lBuRR+rnbFoyjuvu0HuwacQU7KO9zzet6QT+oQfr8FB9/0h8G8g?=
 =?us-ascii?Q?CEvfAoNwQ2/m2PTKRNBcaUCf/QUmMjo/wlpSESrRmg8fKI2SpPsmZXuHYebJ?=
 =?us-ascii?Q?By2+pOrMuFTomMueDHsHwHezZcESYp2OjhgtCmNIL/RTc2V93R0kp0s7G8LX?=
 =?us-ascii?Q?psXXBSoi9yVTWODMfGe9K/wOguG6QYIJ3dwBnc49GfCa48VWd+3V8XPWUGGi?=
 =?us-ascii?Q?Bg/TZoiHWjuw+k+DU6qW2gKBW0YZZU+pKEgsG0RN2escgPQL1PLmpgmwZTj9?=
 =?us-ascii?Q?BjJt3230j1IHN+IGGuSLkpNl2EJdFgnAgt4Dt4J7bXxXfgKvsV+0TKmBHkUW?=
 =?us-ascii?Q?t1Iv5pkedlp/h69wBDwCoQxcWRz8NTkJh97D1U12ee1Gcz0JXesmRaHAOke8?=
 =?us-ascii?Q?5kHzI5SmS+rF6w3d7gxP+HKDHYeW2dmayciTl2WKxoulEklqpZLzjmbxLWM/?=
 =?us-ascii?Q?YAvd0cODQdAxOnYz9kzxMU4QIx+eYkX5XCBEW7Oz05YTUyTybXYTB82U3bY9?=
 =?us-ascii?Q?eVYxSbgF919o0YTGvRTOfPbm4GEgO2xCKT9g5TXg/M7LEYlCNzFWcKglmZbX?=
 =?us-ascii?Q?mdN4l4GoLAuiLZ2+huGPfjtUgvJSgdewSpgrA7clr8VctPQF0n9eXkMy8yqP?=
 =?us-ascii?Q?Ywc5gRj27gGGzJHGsB08Of0J26Xe71iB4sK/kVJ+fort7lMygmFmXUXj2gEh?=
 =?us-ascii?Q?ocFKDJNDd1Cxt9Q2we4MnmVp6P6NcBOUakEwbrlHcOmTxMgyT+AKtaKfjWae?=
 =?us-ascii?Q?YqkFsNQsCOjzvYsKAt6X7/JWYFnxhqy7XGiNQ8OXdGV4CshcjpEHTNIsbO5o?=
 =?us-ascii?Q?N+W0C4/EJWBa9OT7w0R93Tdd9a6cIFHBWqZ73jsWgv6NyosdrACc24u3cqFs?=
 =?us-ascii?Q?xuWq387sm8N8wNEGbuHrjLLykQ8IZyEQOYWJN32v+rm+nkhgQeYUSViaPsaV?=
 =?us-ascii?Q?warrInbYDbJb6pNAPZege0nXIfxYQUKH3VjOsLXSt05XfoYzs7bMRrhBUK6P?=
 =?us-ascii?Q?r1iW5FRT6LohJROraTsYO4s1aUs61UV8z7lSxWghQHt4IBgn0Dw3h2AE2VC6?=
 =?us-ascii?Q?QlmkIpQrSQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: NKPa5NmbkUsxcU42skD2neBB7MM0DJdACovayFRRLv+7dWbOXvn1OQpD8BGxRzBRjqukA3s6j1rjvab6eaYXZ5LiOe3X/rIlqhecVh0U+lZtRnQOlqXaheXphLstpn3go4TBAuGyo21GTeb7HbA9OiTtSCIFVyy3XDzzS0qK3ANmToVWQahAldWcQA6l6C2xgMcbTiPrrTwgPopMhyjh1DN0U/XWwr7E98wrrw65/V5rxMhYSouKn1DuV9AwonV1eErHGk/P5EHOTGb475jPwqdhhBMqJb5QA1NEVxHFqukS9bXZS3pTUxp+lmihu3jKY7jE6eR/csUMYU6qBtib5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d046952-9f20-4c6f-f4fb-08ded1039df1
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:44:20.1093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4u/NimAkh5KkD5cLhgfaPuYw9m9GfQj1azVrCccj4aUpeuRUCCif6Udzwkjv7KIDkUp6pbKarsfbAHy4AKrwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6341
X-OriginatorOrg: intel.com

On Thu, Jun 18, 2026 at 04:13:40PM +0800, Xu Yilun wrote:
>In addition to basic TDX functionalities, TDX module provides add-on
>features that can be progressively enabled as the kernel supports them.
>The kernel should explicitly configure these features at boot or
>post-update initialization time. Configuring an add-on feature, such as
>TDX Quoting, that uses extension SEAMCALLs is the prerequisite for
>initializing TDX module extensions. TDX Quoting is the target feature to
>enable but defer it for now until full kernel support is in place.
>
>TDX module extends TDH.SYS.CONFIG and TDH.SYS.UPDATE with new bitmap
>input parameters to specify which add-on features to configure. The
>bitmap uses the same definitions as TDX_FEATURES0.
>
>For runtime update, Linux applies a policy that no newer features should
>be added after update to avoid disrupting live TDX operations. To adhere
>to this, TDH.SYS.UPDATE must configure the same features as the
>TDH.SYS.CONFIG. Record the kernel required add-on feature bitmap in a
>global var so that both phases can use it.

Actually, we do not need another global variable here. tdx_features0 is cached
and is not updated across a runtime update, so the derived add-on feature
bitmap will be the same before and after the update.


> static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
> 				    u64 global_keyid)
> {
>+	u64 seamcall_fn = TDH_SYS_CONFIG_V0;
> 	struct tdx_module_args args = {};
> 	u64 *tdmr_pa_array;
> 	size_t array_sz;
>@@ -1032,7 +1042,15 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
> 	args.rcx = __pa(tdmr_pa_array);
> 	args.rdx = tdmr_list->nr_consumed_tdmrs;
> 	args.r8 = global_keyid;
>-	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
>+
>+	set_tdx_addon_features();
>+
>+	if (tdx_addon_feature0) {
>+		args.r9 = tdx_addon_feature0;

How about moving this r9 assignment out of the if block and placing it next to
'args.r8 = global_keyid;'? There is no need to guard it, because args.r9 will
be 0 when no add-on features are enabled, which is perfectly fine.

>+		seamcall_fn = TDH_SYS_CONFIG;
>+	}
>+
>+	ret = seamcall_prerr(seamcall_fn, &args);
