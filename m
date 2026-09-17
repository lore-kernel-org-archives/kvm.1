Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE4F4562BD;
	Thu, 17 Sep 2026 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636341; cv=fail; b=iJ1fs2CkOlHC8R/yT4AHRMM9oD2HKHwA04ET033Zdp343qblt05Wc3bevBPs7ozYtC2zGZv4EPl/ZQ6mYVZ4/LVzr9VKC/qUW4kSmWcV9jyu6zfgNMvA9vqb8E/kgMKecUfo6wcsEb0lqD+Qcy1p0sMU3SZfRlZGlYJ9+4LOo1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636341; c=relaxed/simple;
	bh=roesHI8hZEu4r5HSX/OQ6rkqkHLU+oRtpF3fBJFYwsI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=plJ5bz/vU6BDRE209g9Nqo4Kn+7wZIDtBr4MHumFXfYlhC4KUw+OHcmoYwTroPzuyoE2p+5gGvszCgQaaxzdnfaVScKClHDMEnb4POD6y/Lcypd9UtNo3x8kaoii++IhpA4xjkeZLH9z4R/WB3zpl4oREIBBj1+ifx8o+wyrKB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWePF5K+; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWePF5K+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789636340; x=1821172340;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=roesHI8hZEu4r5HSX/OQ6rkqkHLU+oRtpF3fBJFYwsI=;
  b=dWePF5K+XRYyFBcs16BddeAQcZ6/6KROb+/txrvBNiUYcqm6ILGzMiJD
   71g65WC/R5nlHofPfvaEppg9u3hRiFPNCWrEcZ9aqUWzLjdli6LBmrXEv
   tJNI0izrYRz2UHSF3ll4SbpKDnR5XgfmILKcqESeGWuMPoA2IYDxsjSGd
   LzpQ6IF+Te/B9z1rb4ILND3xpaQc0Ith4ZRs5GFUm2vJb3UM3zUHW4GGP
   LSGGZLgD2Z61Zi46jabPLkWNJgm92gM4N/xAJ78FP29fBuXrcAwhO+gtD
   esDOE8bK3dF+VbpxVlmR+6ZLuF2E0Jrx+A86gam/2be9VExVy+q9ezp7w
   w==;
X-CSE-ConnectionGUID: BfrkuFm+SHmh1Tz/Bkj9WA==
X-CSE-MsgGUID: owcByllHTcyS5zr98QWXVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89904821"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89904821"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:12:19 -0700
X-CSE-ConnectionGUID: FWfgx9r3THOliHT6iOAPCQ==
X-CSE-MsgGUID: 4qb0VP7uSSCCzac0Pe3aiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="278891113"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:12:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 02:12:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 02:12:18 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 02:12:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3JQuJhLz0z5taCRmsOGhP65ecaH/8yssyjll4zpkxQbblKiWFDLEHGrS5V/dchnwX708PIbRVDo3CXrMW9J/GCV8ieh6WvDJAlmKm8fEeXFbXx4KwBVAWxOrV4egkyrMG0YLBGZ+KT17nSR/GiTdgECfl1g0YPB50lawobkXAvZW17MDI3NkIi7RvHPelmAMpCb1XhCShjlCjNw2zSOiPORcdzPtEW3xxvaPm9pICpGcQz4zCjviM5/rZXepsLX6EUtsb/DRxe+iMvA4/9KfD8UWKM+Vz3tLo9PLBShN0dziBrDsMD8OiL3RBWz8pHX8FKS2TQQlhJU8I6q0uXlZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btEM0NCG4DQ1TfMtyaOOghksF/Nblxq5qH0CiOdBd0w=;
 b=HWpOQh5J/cj9a53P6GubX+jcbuYysy/qrzpNoMYBlvH+R9MLH8Y/WHN79hlLCgI/l7Ag7Ar/HCwvLzEZuecQC/hy5o7XA/yYFOXu/MdVm9pFRetsRVBaURnRwZBmN50FWEaDq2WW58oHiZPYHHsVY6+/e26TuNxUwiIOAULggqjLxqQuoxYyXsYbU1l6yR/636JOYXcKruc59cqCb4dAX54SSQluCRjbC6twAmzYAKe5Yq7CVDvqZy2YG+1dThF1+puPR6LA+Jbs/o2EgRjNxb8jfoVvFjBI5hIGDmXW/aSMpBHqRTBztlIQkNv6kmiaBAsXLk7Wa2iQJNcO9om3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by PH0PR11MB9521.namprd11.prod.outlook.com
 (2603:10b6:510:3b1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:12:08 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 09:12:07 +0000
Date: Thu, 17 Sep 2026 02:12:02 -0700
From: Peter Fang <peter.fang@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"Qiang, Chenyi" <chenyi.qiang@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "Aktas, Erdem" <erdemaktas@google.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>,
	"Kiryl Shutsemau" <kas@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Wang, Roger" <runanwang@google.com>, "Ryan
 Afranji" <afranji@google.com>, Sagi Shahar <sagis@google.com>, "Sean
 Christopherson" <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, "Li,
 Xiaoyao" <Xiaoyao.Li@intel.com>, Oliver Upton <oupton@kernel.org>, "Jeremiah
 McReynolds" <jmcrey@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v14 11/22] KVM: selftests: Set up TDX boot parameters
 region
Message-ID: <aquu4uMyWHnhNsaZ@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-11-15ad654a50db@google.com>
 <20260825081448.GB3694338@pedri>
 <CAEvNRgHiQ5g94SQ8S6CTyTmEOguQqY9GmQUu1K8ff9L1pALpQA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEvNRgHiQ5g94SQ8S6CTyTmEOguQqY9GmQUu1K8ff9L1pALpQA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::22) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|PH0PR11MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: 64fd8634-b9d9-4d4f-4742-08df149bbfa3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|18002099003|22082099003|3023799007|10067099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: /CRHQSD1CWek9KfB/s+gdfKtc+v33GCwvE52eM2FjP4i12VSTfOD5ijbqBzKjlgsXFn3n4p9ZEOPAUKsGmrWM3GWGTuQB+fMiVR9IKc/WJ3TYFVi1RsNk0OisJnqmuZle8tu8cfceuwIMPUW8XyjPsp7yQMVdEy9x/5aui6shOFsVMRqkuZHpHnk6UhdWdlvPTkn/bGm8+QAimKMdG/YYlKxLlt0PsnW1wfAemur2ogkGT8tGTF0J1VZ1Xme2PbU5+XJKPncOLNxEeyYX+y4YsccK1J/MntDRRKULHA1vov9l39aqc64GP4wcZZZytqvlhPRJCCXYsDiSLjAPTxS3HcJzabc7O2Rhfkat/pHjU5BtdZboAQTdlepQAg6C+QyhyTnDvW7fg2YPPAeFEXqG8mWUp5r7wG4dYK64VCkJN2K7ZMBmbpuV9yAHvIMzEzFFovbkn7FSCMdTeFlEtnlVZdmj449GwjN0JrSIAIkYswELufQqwbXqC4+lFfXjU1GmG07gCy6pfpNuOJtCeMAfyRricjxEbTvFjk/DUCcVHCgiB9OjHOcBqJtt5pNCdFkVMXxMiTJfyvhQp1kPCZCz/dAAOMmx7w0ijlhfDNQl+Qs/CbeFNJZXtO6SGnW2eXHSd0D2d1DLvJskFdYwPbzYRwSVBQGGRm0E6QlnwUDIaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(3023799007)(10067099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xylg5TIr4XrLvyBZpjTnbnlbK0zEGAwpg6mKCr6KzzEoc3CUyRTBXxfr62xh?=
 =?us-ascii?Q?RxgH5FsJcsL2CmgZlCrLsroasMzACqy6UxYUjhS4Bx3xO62lmFG9vl6lxtEW?=
 =?us-ascii?Q?FRfLhMzlsftxYjLUPxKX3SMvzAW73r8leA2sq8XCWard7peiR8UnIgs4cDFT?=
 =?us-ascii?Q?3Ozac1ETBdCYkA7debafaOv3Ca/yZq7V2Taq8mj1rz8M7U2dIGbc/BVG3rLV?=
 =?us-ascii?Q?3swIozBEzK6KS1l1NR03atUZ7a1Ciu1f1YsLN4mlUjI6w+0Dq7Bld+mDY6TY?=
 =?us-ascii?Q?l54OgWTy7Oqqisxmub+WRHnQnV7O6r6e+uM+pEri3YMdH/dddQFtUmrbUz8R?=
 =?us-ascii?Q?Am4SuOA/edFbyu8sO9IylbyFSx7bIDRSnutB3xxxK0oCYs8aWN1mN/3IvWYh?=
 =?us-ascii?Q?FRPw+xh9RIWM6QA2aOWCzYbHYCq1siU5DMit3HnZzTq9DP42CUkLbPJA3WUE?=
 =?us-ascii?Q?k5fbQYUAEBAQ/A+Uyg6ID93iGXzqBI4SFgL2cWBuSMiI3wBpzmLguTg9Qsub?=
 =?us-ascii?Q?ejaMdEvMRV014YI4E48yW21F0qmVV2mR22pwxKMnNusbXgbsv8X/GW9AvP5t?=
 =?us-ascii?Q?DXFUEZ27ZGmcGfavxnnRLGM3/DeiSgpGdbZFhxM9t7X4YuDTBXAMgNcB+Sqd?=
 =?us-ascii?Q?7MKC9An4qroGjaFs1Dp9zzZozLlr6zO6AAIUXwACgYSQJUSS3PUlcUBAFu03?=
 =?us-ascii?Q?KKnX5tVqhFy2aqyEjjMk60UclWQTWvr6OJ0dTLvxVQtCaSF00SnTGfRNHAKi?=
 =?us-ascii?Q?Rmxmm43ucGHMtBVaLtIUenjAX/HViODwgNMCm0f5eWrNWAofSMwPWs8k95Gr?=
 =?us-ascii?Q?trloMrw+dmgNbeBM1IQCdsgo4LSLAaOAFq95zhNovBCA/wx+OsmRX88V3A4a?=
 =?us-ascii?Q?52WH1pzfX0aJF4EhDexUh9DiOensdsYPxXnd8t2CjIKMOP68W+LC9mRVXFnV?=
 =?us-ascii?Q?FtNWfKhICY9u2p3wzd1G8D7kL4NN19RfAzroBHIMGiYGpRu6R3XaHLeGBYMq?=
 =?us-ascii?Q?IyDNPrjSB5z6yCyo+R7NBCan79Y3XIMm4ZwgOABCGLsAUyORVbXddQg3OG/A?=
 =?us-ascii?Q?Aqpk5Hpezauq7CxAh1m39vse77WOJiTdkokFHsZEYu8CNrjwTqSxa21bGPQj?=
 =?us-ascii?Q?bBURGG1y0C1DCWy0nvGAzuDdjCiJDxsoEufm3Yxl2XdiQ6Vt3pmuDP87C3TJ?=
 =?us-ascii?Q?d2bmKK2LQNtDOLW/JXVTyXlcCqm/JcGL4decaQEuu2ZdEwdJw9hVsjF//a7C?=
 =?us-ascii?Q?OIkcKNO+3f2nmLPheTfVMRzdRqcYzqv6OnrUWm6YuOik+ZBxrhg3wtHk3p0m?=
 =?us-ascii?Q?S412zlwUHituVZtp0+QH6zg18VA6qkN1+Z6iZDFdk5VoLnyQXjzOfxD4dtma?=
 =?us-ascii?Q?4EyxyWdFHgKaCWmVA/hVOaI1t7rVzMlU56jEJ8/cp2W8fsmaUW/cgRzY8sg+?=
 =?us-ascii?Q?3O8N2rxR3OWSP7jv42Nzkki79otw1iMTOErmnlNBK6kQCn4moR0A3cs0r6/L?=
 =?us-ascii?Q?4xla0eBXLLM+z2KsD+hyuXgds8qVxHX0tLL8aOqzBGgolssnxXTix9NRgDyl?=
 =?us-ascii?Q?nFa1x2JiUrXXU8X0jblnPSwH8EMhZijR3YTL61Hv06opW5AucUfFvKJ1C6QQ?=
 =?us-ascii?Q?ZjaXDFYbDGtZ168uEbAZSeNmn0nFXf0HNwXI4gnFwlb0QB9Xh4qLvV9Ramp4?=
 =?us-ascii?Q?YUQTzmZK8PiLFEqeF8Wzy8FJkdqtVwdzDTBj9quRvMg9qS/p2gPWa4gEauZN?=
 =?us-ascii?Q?wlRL/AFWaA=3D=3D?=
X-Exchange-RoutingPolicyChecked: 0yZBRGKVgn2uSdyyQv9FckbjBSWIFokih3ZHxlPC5OWTO/jb6L/pJOP1rFb29rtFrnCI/2VgKOrW26xvxpXBjVOhDB7EkarCu0zBJy4vUVTVrxSkoAdAjE4SM7OBHJ2+du/eDHoPvz5tfR8peN13HRPIt6uVLeWUUBIE47LH7gH+p0874788AhFRxdavHG/J4fRA9x9cwQY7R47aeKuEN3LzuvvFoHtFVDtp6ntL1FdPgJekhV5ZMre2vGnEu9mKTktRVUgxD0Hlnr4l98aMmliIQuajBklJYFyZwqUFH3+5tQBO1d5YvuIoCbB+0RplQ9cwID6lA+7uu/vwdFxIOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fd8634-b9d9-4d4f-4742-08df149bbfa3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:12:07.8618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuQW6/k4FcfL4ZkswVpYlLkzx6+MgLhc05iUcanCdfhVQXLzQcCU8JOsflx8DZ6A1hWZHgRBG5jcrh7O5qUP0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9521
X-OriginatorOrg: intel.com

On Tue, Sep 08, 2026 at 12:18:38PM -0700, Ackerley Tng wrote:
> 
> >> +	cr4 &= ~(X86_CR4_VMXE | X86_CR4_SMXE);
> >> +
> >> +	/* Set parameters! */
> >> +	params->cr0 = kvm_get_default_cr0();
> >> +	TEST_ASSERT(vm->mmu.pgd < (1ULL << 32),
> >> +		    "PGD must be within 32-bit address space for 32-bit boot code");
> >> +	params->cr3 = vm->mmu.pgd;
> >> +	params->cr4 = cr4;
> >> +	params->idtr.base = vm->arch.idt;
> >> +	params->idtr.limit = kvm_get_default_idt_limit();
> >> +	params->gdtr.base = vm->arch.gdt;
> >
> >         vm->arch.{idt,gdt} must also be 32-bit addressable here, just
> >         like vm->mmu.pgd.
> >
> 
> Something like this?
> 
>     TEST_ASSERT(params->gdtr.base < (1ULL << 32),
>             "gdt must be within 32-bit address space for 32-bit boot code");

Yep, looks good to me.

> 
> 
> >> +	params->gdtr.limit = kvm_get_default_gdt_limit();
> >> +
> >> +	TEST_ASSERT(params->cr0 != 0, "cr0 should not be 0");
> >> +	TEST_ASSERT(params->cr3 != 0, "cr3 should not be 0");
> >> +	TEST_ASSERT(params->cr4 != 0, "cr4 should not be 0");
> >> +	TEST_ASSERT(params->gdtr.base != 0, "gdt base address should not be 0");
> >> +	TEST_ASSERT(params->idtr.base != 0, "idt base address should not be 0");
> >
> >         Making sure that cr0/cr4 are simply non-zero feels kind of odd
> >         to me. And cr3/gdtr/idtr all came from memory allocators with
> >         non-zero minimum addresses.
> >
> 
> I guess I intended these to be sanity checks that the caller didn't
> leave these unset (defaulting to 0), for an early warning to the
> selftest writer if something went wrong. I'd prefer to keep something
> that would retain this early warning for the writer.
> 
> What would you replace this with, to provide the early warning, or would
> you rather just remove it?

Hmm... In earlier versions this was:

        params->cr0 = sregs->cr0;
        params->cr4 = sregs->cr4;

        TEST_ASSERT(params->cr0 != 0, "cr0 should not be 0");
        TEST_ASSERT(params->cr4 != 0, "cr4 should not be 0");

Which made more sense because perhaps @sregs could be sanity checked.
But now the assignments are all in the same function:

        cr4 = kvm_get_default_cr4(vm->mmu.pgtable_levels);
        cr4 |= X86_CR4_MCE;
        cr4 &= ~(X86_CR4_VMXE | X86_CR4_SMXE);

        params->cr0 = kvm_get_default_cr0();
        params->cr4 = cr4;

        TEST_ASSERT(params->cr0 != 0, "cr0 should not be 0");
        TEST_ASSERT(params->cr4 != 0, "cr4 should not be 0");

This makes much less sense to me. It looks like sanity checking
kvm_get_default_{cr0,cr4}().

So I'd remove the two asserts for cr0/cr4. Keeping the ones for
cr3/gdtr/idtr is probably fine.

> 
