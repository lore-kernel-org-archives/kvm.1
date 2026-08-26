Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C00B5733E;
	Wed, 26 Aug 2026 03:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787716226; cv=fail; b=rxTRC/GySwtIOFHlSa8hoWqHTBT1iRWVeegf6elRbkK5sAHpiqXXchT+1U/WrVAVg6z5nYg0wBJgSzlLeKbnLCof+PARjm9Eh59C2zUrz0vhVH/DvWTCJSmh2C89ScZlfWjWKFAtrWLiaR5lJmKSIltewOUVf19wF18fKdzdQbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787716226; c=relaxed/simple;
	bh=ooVNXu4ZY5FgBjZJNtspaWqr9I7H367yRwSRx6miDCM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dzg7Z0OJP20C5IWh5GcFnv6rwZzxbWveDRjkvpvjI1FrFPbu1ZNypk1+zX9QGAK+So9uGoZwt0bC3GCcg3n2y96SVFHD9wmCrMj2/K6uO40P1L21fNReuF9ftntXpD4HG7dv2Nu3VfkNYdzDmGTM5vHneMtCJwNAofSndrH2OrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSKMMyGb; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSKMMyGb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787716225; x=1819252225;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ooVNXu4ZY5FgBjZJNtspaWqr9I7H367yRwSRx6miDCM=;
  b=PSKMMyGbNTGY275RSq4Iapf4ULr0kE3VZFqmb/hoxUS3bBPJ2jmyi6IQ
   Zs+ATfpRyztjKGkY//6qplGGyK/F8ba6sA8yL4hfnJnKrXgaCaKzWyJqW
   clAYWaT0fV7EE1YN3bASpgyJo/GpZRPIsOxBGruTSp6eARwtXeZVM5/IT
   pS1+xhGXFbRx02KSwev2kbbP7OgxhHxRavYS4dzdKdnQI4/f5l3+tqdF8
   L2awWJYE/u+Ezlj5+4U8pf5lYXMaSshXx894qLPb7/iQgYmh2VXkz4HdB
   nAgrVi7qx3RZcwtc/2x/dk1EVz1xWuGPTmCWMjt2va0VnGaFGyvtTbzvf
   g==;
X-CSE-ConnectionGUID: 4IoZTf1cT76b8570/0Xc7A==
X-CSE-MsgGUID: A+REQWjmQkOcxJytdozAPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88218228"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="88218228"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 20:50:24 -0700
X-CSE-ConnectionGUID: yh3AihUeSz+LpD1Sb/VtBw==
X-CSE-MsgGUID: fZ3Ylnx3QQWNfZiLIymM+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="265669056"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 20:50:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 20:50:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 25 Aug 2026 20:50:23 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 20:50:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2R8pxCkk+wFG1qjjNgv0E2rZNlpfAjS5k0jdjEeTCKfU5v4Kyjz7XP/bwqsLssFWegZJEoXlxHqEqoq+XEkmx4s9JNX6R8oszzPAXn11X9gQGObYfuvDRkrXbpH/7E/oW147igx5M+r/7i6tXZVE4+HxobFdFglJ46qcUfcdcEt7J00t6bkkqVHkzrlLlneAb7dX3NxUz2e+IBDTzruIov+3GzqZbmB89Tvm3O9gGaaWy3oLeRIaOe/S1wPxc/rdGjBtr1jh2nDL6nyGDfmDSKoBT0dbgc3hNzTTe3Jzvt9tIJU51e/748P27XROh9RZZ0PT+ElCHkuoB+jOtYQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXlJO5egHr1A0kq/2PZk1g3fgrsYig21EhDYsYG+So0=;
 b=QSvnQrzx5XATODM+oBm75eJVvzfg5wNaOapTxFB3zn5uOycdrMTNHxdnaBh7YY4rOcHJwxv3sNb6y+4UqWb4YtAv0dJovs2us3WTBCcDBt/+YHXnj1Y0ZPTziqj9L02EMLyZWOAjPIwW2x5AOUJO/bebTlk8h9rIEO7I6bJ/uzJiJVHwwCf+eyBTuMb6xVrCP93AYvJiIx1G5ytkfpEyUuEbXrKPdLGVScPOpLApcE4EUclDYUoZHuj3QVDHsu8gsnTpugkFdwd89bGZ+WpR3PNBzt8bcPoVzQ587kShE3AVvvL5vprOT3qbAHXBtwFKON69GOwFDloGMBzNgH8/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 03:50:18 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0339.012; Wed, 26 Aug 2026
 03:50:17 +0000
Message-ID: <5d04e5d6-6a8f-4bc1-afe9-195310bae909@intel.com>
Date: Tue, 25 Aug 2026 20:50:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] KVM: x86: Add LASS virtualization support
To: Sohil Mehta <sohil.mehta@intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Shuah Khan
	<shuah@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, "Chang S . Bae" <chang.seok.bae@intel.com>, Kai Huang
	<kai.huang@intel.com>, Fuad Tabba <fuad.tabba@linux.dev>, Chao Gao
	<chao.gao@intel.com>, Yosry Ahmed <yosry@kernel.org>, Claudio Imbrenda
	<imbrenda@linux.ibm.com>, David Matlack <dmatlack@google.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <20260806011536.4172258-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0187.namprd05.prod.outlook.com
 (2603:10b6:a03:330::12) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|CH3PR11MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 195cce53-33e6-4da7-3c12-08df032524d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YZkTzquxzah8Z1ssywho6awByTcEg5dCxVh3+bCs1LMmeEhsxWcRjP8Cf0eX6N7UMI+LhxaN+8BNm92ZKWYqtwxbmisLuh8PN2fwld3jAs7/Z/acPZSHjiF8DyqUslpzDthabVFd7UWfAG3sXr6lrumIT78MFyXQZoHPJ/XyoNCXwzLBT+RxvjlD1BRIfBhmHZS/IaO35JoZINR6eOhKPXpiigoCVeh5axFfTP37nJLH4F+xWX7vX1Ll6KLaLv1gJamIgyAjkbcewDVKSB1/SxodZiHY/rArfRIn2GszOwKIA9lotjBtYGUPoClYtsu/66tD2l5r4JKRXodrTO/pMhanDG00NidNQMLMB888UNQEeWUYHg3TsArEM/dk6Vy20rv7BnVC+40Z1qcRDvhnEvx6htiXij0zfU2JzzsVtoQP+mGsxSxeaNvAUK2sDCgIX3tKXCY4o2FwEbelRNLa5nTFrMc4ikGVuaXetWziqNEDUQjtRGvhxSuW+EUirVU9w0ZwS6GeH8h1bfjhhG5qIIH2ajMIGGmZ/0I62q2BL8X3S6y/JsSNczANKS+6Je12yn4S5GNXf/2QMwW+dUgIs+X3AoF0j2iRyK1Qevd5rbrWwpEqBssMvcz4Icl3oS+e7rm3qcUri/Pz4ctFPcURZab7JbmCGJMwWNceF1MC5Q4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2lrNXkwMy91dEsyQTVxL0NiUEc0YUh4b0NPQU1jTjQ0UlBqYVFGTjB5V3Ft?=
 =?utf-8?B?QnVBNHI2RHQxRnp3NkxlV3Q4bW9JV1FIN1hNeVY1YzVCbjVsbDlwUFl6aTV5?=
 =?utf-8?B?eFNWVXlobkEybDhZenJoMFQrR1BQamNkNnlqVkZUaDJWblRUVGQwTUcxdCtL?=
 =?utf-8?B?b21BYXM0elk4aldpUjh3Um9CZCtxSVM2emwveVZnOW9XODNTbXZOSUFYYWQv?=
 =?utf-8?B?ZGdyMzdPNTRJRldsOEw3OU9FVUJMdUVsWVlGTWdYYVJLNk5Yc0NzaTRGTXFt?=
 =?utf-8?B?MkVlR0hNYTBpVlIxMXRJSWdJbVJ6L3FJcFoydmV6bk5IbWJaSHVJR1JVRUR3?=
 =?utf-8?B?UDlWTmd0NzZtZnNIUGQ3NmlTVG9IeGMxSk1vSkVoNlFRdE1lVzRsK1BXMGlh?=
 =?utf-8?B?VGpQK0pWQXNjZm5RdU8vdzRvRDVOSVhzaG5kUDVDd0pVKzYvb3A4aTdZTXRz?=
 =?utf-8?B?UWJXNThvTUNmL0NDTE1XQmJOQlB5MjkrcHdZRkZBM3IvT0NWeFFIRGtQL0l6?=
 =?utf-8?B?REFnOFVXem1xUzJQUlB2LzBkN29GVGdoTWRFOU1HeHBWUkRtd2tUdVhmUE4v?=
 =?utf-8?B?SnJpdExrc2ZGQlA2NkU0MUk0SWExa25LcFNSOHZmMm5WTUFJaW1oWHF2cm8x?=
 =?utf-8?B?aWNjRnVHWWlPcjYrdVk4VHFTeDUybmEwRS9ZdmdTcWMxSXFTNlRvWStjcy9q?=
 =?utf-8?B?dEpZU216emNucnZVbnU3TXlYRmVmRWJBMldYRXpoanoxdk5BZno5ZWNaSDlY?=
 =?utf-8?B?S2lZNFRwNUVoSGE4SWhlUTVvaVRTYS9KdHF1cnA2enhCMUtMaGRiNjNVTG43?=
 =?utf-8?B?WklDTGNjRWNpRWQwWTI0OGk2bkdFcGFwR04vUlZhZWsycTZVSEVteE1jVTVo?=
 =?utf-8?B?QkM4a25pU3h0c3VYamhQYkkweTdjWHJFaHVmSFZmOWtTb0ZHdDRvYVFLU3NF?=
 =?utf-8?B?MDRNc1ErN0c1bC9Db3MvVHh6Mno3VHJrWHljUHpOeHpJcklYZSs1bTFLVlc0?=
 =?utf-8?B?YnJkVkh3UGRHNkVyZkdvS3ZQazBsRXpISjYrOTBxbmhmQTB1Z1VBN0kzeTZa?=
 =?utf-8?B?OHFaR2FNQytmVjNvQ0R4NUtNZjZVRE1BMk0vOHdpbGtnQ2xNcnZsekhteDRu?=
 =?utf-8?B?UldXV0dqczZBTGswVWplbFFRRWREUnU4T1ROd3BsY2dvVFM3YjFjUWs2OFlR?=
 =?utf-8?B?YXFBbTVhYVBxNEhEcHRFMWlaczNLdVhnY3g1OHhxY1dHeVlGK2lxWFhyQldN?=
 =?utf-8?B?M2RPbmpyUkVma2h5UEs0L1M4M1oyTDhwckpEdFJGZERGUjNETVhvajA4dkk4?=
 =?utf-8?B?WEFSazY5V2NCRGNsOHd1d2xHR0hrc2pJNHJpUVM2TmNwT2U3MWhQWHA3em1T?=
 =?utf-8?B?U2pQdW4vMEJXQmdUTGZBVU53V1E1NXNqdjlYNDEwYjZhdGYzQityemF4OXl0?=
 =?utf-8?B?ckczN0dqdzlhcDNCaDRKeEVaQy8vRUVFWnM2VE1IQmthUVRrT3JDV0twZFBQ?=
 =?utf-8?B?UFFBTmFBN2I5NlFTTWxSTG1wRWxTamtnWTJRMGM3RnpyM015MVNmODBoZDI3?=
 =?utf-8?B?VzhHSGxrby9iZVNRMUNMVjgvL1BMalpEQ3VnQzk1QTFCdS9Vc1dxQlFMMzlF?=
 =?utf-8?B?Um4zcVhVeXZBWTM5RnJDdDVXZWg0cTBVM1ZyNnByaEorUnlZSmNrNVhzeEg3?=
 =?utf-8?B?eUZkQVoyTlpXSkhHd1B0WjFHSk1JbS9QWFRBbEVCMXU1SHZaOS91cnpHUjhN?=
 =?utf-8?B?aGE3alFSdmZzdktIMlZ6eXZ5R3BWTWEydFBLOUpTR29YVjNRL0JZVVFDVDlq?=
 =?utf-8?B?b1ZWcVRnV3JLeGpWRzBYQVAwVmw3TWdHSElOTXBrM0UxczVBRm9Yc3V1THZJ?=
 =?utf-8?B?aHg5aFVKVHNheXRrM3FxNzZKVXdZbUJTN1ZiNHlzNUdQVFg1OGk1eFFHSDd5?=
 =?utf-8?B?Ymp1SEM4OGFpZHJzczN4RW1UVDFFMzBXMytHN1U2blY1RHdSUno2WGtFc3I1?=
 =?utf-8?B?MDF0NWdGVjNhOWJiQkRYWm9hZjlFNGRqYWlVTHFzL09naFBJRWRGOURMRlNP?=
 =?utf-8?B?WWMwZ3g4U2o3R2FwdG9GdU5FZ3FEZ1Q4dURYYXdXTjRzNGE5NWFGNTVGK01Q?=
 =?utf-8?B?SnNxY1hqSFIrVUFjTkxwVWJYNmJIcXgweEhqUnN5WjlLM01BTlRUTmVMeXFL?=
 =?utf-8?B?Vk5QU1NURXY5VjVXeXlnNTFVNjh6bFc0SHZWM0xEVFlDWkgrWWFRK0Vkd0dT?=
 =?utf-8?B?K3IzcjlBM3ZPWmJBcFNQK0xmOW8rVktDUmN2eS80K1J5VGlNRzRtTGV1USt1?=
 =?utf-8?B?YXF0aDB0ajM4eDJZYWZXK0pldFhPY3JYOGl1OUhKWjZyOXVCb0N3dz09?=
X-Exchange-RoutingPolicyChecked: EiqEtGQ4t0GxvtH3jh140qxotzGOYG7RIJWAIl/MzxzyNXRI3+43i7tA38Yk/vNoFvoKfin8Iu0EXSoT5OdytXcCPWLTV1N8yz9V13r6I4orL2nTqgAUMzrk4iGbKuJNpH5JEbM7Wf68rthmzCmq41ieU30Yy/FjNm7meSxvA0cj8CbCTavQMLh0nJcHpDY2sH86FBymEN7OM7nRnUiwVm5tMtb0VQ6VWz/SGcx+4enssADEzUrn+Kdeir2pOkJmiuTnsuzhhg3yZFI7hMPaBOCWnxN4Egts8pUP25LfJC+2B0f73a5CS0Pg5XDmZDBWFMvoWVZnLE1EzxUTu0rpKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 195cce53-33e6-4da7-3c12-08df032524d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 03:50:17.8143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhYkTF5KkZe6l8PFGm+tYZu1KxuUUyA4kVZbiJkKEhdI612FCzIsQ+xf93JQt9urvYcq04IFNrPejXDSp2tlyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8660
X-OriginatorOrg: intel.com

On 8/5/26 6:15 PM, Sohil Mehta wrote:
> Linear Address Space Separation (LASS) is a security feature that blocks
> accesses across the user/kernel boundary based on bit 63 of the linear
> address alone, before any page walk is performed. Host support for LASS
> has been merged [1][2]. This series adds the KVM virtualization support.
>
I tested this series on Sierra Forest, using the QEMU support linked
below to expose LASS to the guest.

Covered:

- Guest enumeration of LASS and enabling of CR4.LASS.
- User accesses to supervisor addresses on hardware and under
  the forced emulation prefix.
- Supervisor accesses to user addresses from a guest kernel module under
  the forced emulation prefix: reads and writes, RFLAGS.AC suppression,
  SMAP=0 behavior, implicit descriptor-table accesses, and violations at
  a branch target.
- Nested VMX: VMCLEAR with a low operand address, taking a #GP at
  RFLAGS.AC=0 and completing at AC=1, via get_vmx_mem_address() ->
  vmx_is_lass_violation().

Not covered: the TSS I/O bitmap paths in patch 2, and ENCLS.

QEMU changes to expose LASS to guests:
https://lore.kernel.org/all/20260826035734.114685-1-kishen.maloor@intel.com/

Tested-by: Kishen Maloor <kishen.maloor@intel.com>

