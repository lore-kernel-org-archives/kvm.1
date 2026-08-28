Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D033F107F;
	Fri, 28 Aug 2026 02:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882784; cv=fail; b=fhUNHf2nBPpB9PTFkb2ht0Yyd17QTCSGeZ8+sD/k0De4q4XO083uIqo7J7ZwdzLOXyBca9K5ZhrZZypOHiDxCP4bCNts64F95ccIU4m6mscE1CP5lBTUPjLvJQUND+h2BgfiB0lDMqTnrimYttpqtyZ1/gVMsU+nXwbyf+1QzLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882784; c=relaxed/simple;
	bh=TKa5bHrDyF70Zl3JGLsa2cRPvko12XAYkkpYB9h+OZ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oA47koXciLgCSKN5O+kEhOD1BxlKydVZrKBQspehSuPowHNU5phQ2zA32bkFtfCJ88/J45i06JoUrWUrdWO9HsfvFhObnWgwVSEYDtLtT9sJFQ+tlpPL02F8Bhq6QoyoV0jXugSZ6leJQNltz4ZFyYPIHfdaaLOCfe78y4oXWGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tl0Xu/jV; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tl0Xu/jV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787882783; x=1819418783;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TKa5bHrDyF70Zl3JGLsa2cRPvko12XAYkkpYB9h+OZ0=;
  b=Tl0Xu/jVvv0dMonsPf4hYv9t7wgh7NaLkVyUsBD3gBThZR+8wF5AVenc
   kxNSSHnZnRnTF3jZBL1Log5cZTsKO0R/y2dH5KXqiHGu2L3/XgpdfchJ8
   iAq5sAaiFp8xkmEtApnUEP6C5J3zy+sh8FozH5Zf9x+PW6hcz+VAytkvQ
   eYXCEBm+iQQTj0O/zqp7pdLNypNSfxW8xM5CsuDIZ4VmDigzFxsXkJsdY
   3en9gW5VLIEzf6cRDk68pnSD5VoQY/FiOogjhSNZd9K92uByh41Rz/LNk
   fYdCKo9rXrA/Bd5iibZhG4j/KzCpPEgVSqlJBjLuE2pb60DQT+sVTTi4g
   Q==;
X-CSE-ConnectionGUID: Ja1H+ftwTLy7QmvMAYPiHA==
X-CSE-MsgGUID: +1iAGHIKSM+D+FiaElitPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88409198"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="88409198"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 19:06:23 -0700
X-CSE-ConnectionGUID: A8fxGDqgSrmF7YKWxA6PWg==
X-CSE-MsgGUID: iPhgKtgwT0ekAWbR5O69AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="265426440"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 19:06:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 19:06:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 19:06:21 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 19:06:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avEYJk4pOHEVuosiFoPCH6dIt81RvOSOgc+8T3AWSd1gwQWnmIjsCZsQunWSSgc6aodfikg/qxpOHsvks4+Si3HxFwiiBPYBfS2dkw1XGlz21ZZlI0bgY7ILESm7tV2jsN5D2uTf6P2zc/LmN2ZPW+xjcCkxnC+152B6keaJpyzmSIyljdcwBNHq/C9UO9fICDydMp5/PkPNAaq3FAQkl7L6RRRXG+9JXdw5N51jjIsKDQatZyMjNH+iPgwxJ1g7XOcvvJxGVkIuhB3BoPQcPPvYR6AAYLhpJjJxkR4zWgzbmKVjWzChhSaK8EPohPiS+CmgEEdV26MQ56TUt3uHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgBk8f7Cq9tV+xwA6BF6BB5AhA4s7L3r7IBsLd4//1g=;
 b=vewmTx4ftG4WlwujmLZUwUsw7GxvsYBGgBhkW4MOGsI74E0soQXVXQWZKXew4+fwb3DLP9KEbN0HwLwEJZwGbw7BWacG+Dzq4/ZVGz/cwYnGX4ZFuuBVi3xif80nV67eIAzbDUg1uzehSbmsRFouov6TrMG7mrbBxZ3EGJcHhJ2noD4rHU3HWXm3iI/XLaDBBTq8vg/u0uLRn1hmtgBoICmm7JJzi1gycFqky6tkMhyG4CT5YlzLpNlCXvbg7uUjHo86oiuEra4qdbI8bHZygA9h2PzsDVJikgYXpZ8Q1ZHfWtH8ukuc0oIMab0zHMth/s4rUj1TGSgi4rheSprrpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by DS7PR11MB6296.namprd11.prod.outlook.com
 (2603:10b6:8:94::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 02:06:16 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 02:06:16 +0000
Date: Thu, 27 Aug 2026 19:06:12 -0700
From: Peter Fang <peter.fang@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
CC: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Ackerley Tng <ackerleytng@google.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>,
	Ira Weiny <ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang
	<runanwang@google.com>, Ryan Afranji <afranji@google.com>, Sagi Shahar
	<sagis@google.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan
	<shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds
	<jmcrey@google.com>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v14 21/22] KVM: selftests: Add ucall support for TDX
Message-ID: <20260828020612.GF33657@pedri>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-21-15ad654a50db@google.com>
 <6f89fc78-0344-4a7e-bbd8-ac201b8f845a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6f89fc78-0344-4a7e-bbd8-ac201b8f845a@intel.com>
X-ClientProxiedBy: SJ0PR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:332::26) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|DS7PR11MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf872e3-12cf-4b46-445a-08df04a8f178
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XZ1rOnQW1Xnvcj+a/lleQbsAxPHl0ahssCLA+zNQSrNmtncUjl/58qxC7VuywefskIJW61ueiK+BPc3q0xCYa4ZTpaV2aZYeRLIypp3jSSyKrzP1M+Yh10pRzw2kcmqtjH5wv1/k2Stb6ERdbyeTD61a2u0sogAKnoygBtnfQswvFFGVp2rYb5nwyyYWHE7cSuE/O8gsRZ+mhJNJ5G8JcBZB7XGeBeH9Q8LBi8VRltDReqpIODZ5CEraYHXCGtzBktLoyHeH2qYog7buK5ihA0GdDjuuejKxOKMg/SYwrrWvQUM+r9Cm9kXwVE2t/6CFCdePS8c5uOEpFovQWCtLb/lEBTJYhWwHZNVr7mziq37yUREsVpeA6wbH+sYV40pYO/QY4QWks9WPWOBlj5P1eWnEe8Ic39N28YFM/ZZP1OT6sLkD+HmZmiUCh0IfA1V/ZM5xLZ4P2R9cul8fV25WRxBUaLICM47q6IGDK8x1R76yhMEX7T+Yy7hH+Yf0M4g3+3vJwg8szJXW0uplkPz+5E+nbLcOFgefeIoOaQvb1rrOeOtvTWAN/wwTF8T1kLPozzUpQ6gktUHlAcdWGuHRr2CXW+BWYe+lZHcRPJ3BQplavxiKmSMabn2FitA0dzELW0E6qjf7zvO9irS9Fity524k+U8+i814H9CE+5GjwHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X2zk/655LNvBszL1UlCPS5mDw2/ShWPCIBrTp0muaoMOq5XB9CJGXANmWyb2?=
 =?us-ascii?Q?b0irF0eGJ2Cyon9Z1rce8CxCuVUPgAigQIOTOMwvH0qRMjd6MZ5Dj1jDXbWi?=
 =?us-ascii?Q?ENCGScikYUigoiTSe56+fibF4F+IO35nPbp/42990ZGY8ybacjJcZLppXdI8?=
 =?us-ascii?Q?tjQBNDwO7bXqGgXN+d09GZ1B0Dh6Eu3a0/d8oPIs+5vXL+MgyG97O8NreEqK?=
 =?us-ascii?Q?WIfYK1FVYpHrglR49BdKhjxTcarIE31U1slyvxJSM6taoJx8qbUW9qShtR8P?=
 =?us-ascii?Q?PlZLh0hP8L46FA4q1Ld4fer6Xo0CuTFUEHFhKS/FqZ+xuktviFdm+Hcv+e3T?=
 =?us-ascii?Q?0OAxU2yMATpoElWSHY7lQ1ZJZTmC6hDxDpiQgg5AXnhd5FinT1tEabKS48FH?=
 =?us-ascii?Q?c37ry3fwZ23NEMygS8nNsyCmkK6bvZW1yMCL+xPvX81jkkdCSfth4ukD0jWg?=
 =?us-ascii?Q?6dNAfaoA31NcxgvLpul65KK2QPJnSnVyU29vCrIQAgSRjcyIvjiJO4HaDxAR?=
 =?us-ascii?Q?Tr2jLkXueONogDZtFcrpaezq9g9Xg/9x65WOyv4Z3bZis64XDt8EM1AXDo7q?=
 =?us-ascii?Q?+IALU2kkqNoPt13SOQ+cwsKB7z2OyUw6xdCfiuYlEbn6i/OwSlJ3Iw2WXQKP?=
 =?us-ascii?Q?A2tYDoqGTIxYgG2YiT+F3r9sbw97L6uHAV9mkH/BCkUSCSM2XMJR/TWA5adn?=
 =?us-ascii?Q?UtpxlAg7uZ0jZnpnoNiaLjiUHDwPf3oXzN2SP2lNmGE9AyJuJL3EDXMFSYGf?=
 =?us-ascii?Q?SOOpfH00Nmpp4UuOeUwsurz7aMV24dywDVeZTHQyjbqqs+7iCc1YKHZBKPgr?=
 =?us-ascii?Q?HK0f/z2zmsmGWrXrKl8X4Sbfx6IeR/QOvm+7VUgXgvGbJSzsmk9vhFBCgPn0?=
 =?us-ascii?Q?KzaJh29L+Ah1O7XfOwT/78mjMgEgaGK8uEtU0bP7epOCSc4zysX6BjQ/lK1v?=
 =?us-ascii?Q?bkeesAXsSKl76SxEGIlVtoFhOMgNsrOh1YyqR1cVt2WowW+mH0HxY/WPy4xp?=
 =?us-ascii?Q?JXXvz4feJ2UQ1kSZaU5U+96MZtnQ8a+XAJhP8BogZAG5fDpERHsnhVU+8L4q?=
 =?us-ascii?Q?yIPsfZq0YPpvWrtH3BtGHrXHB4Ga96cWlk8ebLE02hbU77z4pOL+/Mx07Hdh?=
 =?us-ascii?Q?fW+TKUpo3CR+BYEpT9XxfayQaKjT+QgrEaWf7itDTnkDZHaTXw4Q8moAMHEn?=
 =?us-ascii?Q?9LR/F8dA5EK3NKon8ee/m935+Znxfb03q/ZECtBBXCmQL3JCwvaHtEYh9E3Y?=
 =?us-ascii?Q?n7BfaITjUITjW/ey79oPmyfONfHm+8mc2Y+S03hrUw+WQsTNchei9QWpBBP2?=
 =?us-ascii?Q?h9oswIf6T16c7QrRjF4SGH3WKW2I7E8R53ghhAQ69MujVtQn8AEbqNl8nZBr?=
 =?us-ascii?Q?bZLc3EHZsXyLD8mQLEV4qOKbsfc1eH2sE+IHbPX9Gqh8JcHwxZr1Ki7ytWFX?=
 =?us-ascii?Q?4acJ/hbFTF834wiNFwr9ulLN/4let2xEZf0PU7S50XKODsEvLlx/ES96Vvft?=
 =?us-ascii?Q?Qw1d8VFeP+rZEobJdJO8Gvk6shKx8X0saEipz3ptQiyF+HJv6dNdFqtaK74B?=
 =?us-ascii?Q?eGZHHghCPKg8wmnBp7Hj28C+m0WZ0AKqXBd0bAsytD8KXbsN3k/KcXa5CxQe?=
 =?us-ascii?Q?pbmheydXMFJkRMmDFKtv/DJ3p4KI1+b47NYMjfVO08PTOpOBM8EFPcypfAxA?=
 =?us-ascii?Q?ptp5d8ddSvf+cRjzY0ve2F8PX1MrIz9pvMr97D8aIjRxNHPag9mVQFkf3lK2?=
 =?us-ascii?Q?+g06L2N4aQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: t5eUvEmYi77twfCDchnArriwakc9kTpo9z4hVOOhtdodpfmtDgru2YlxA/tBBb5RpgaID9cRtJ/wRte9eSVzMcxTCMQfSyIH8jC01jY0xsNXDL4JZiIb/1BjS7JqMe+JZOI8n8Nw4ZEQ0JC5ub5o8gY701qHqctdb2Q/t9xOLE5YIhPvzH/R4Q3lA2VVs5iARV2Dtg+dQboTxU9AvJg5RXWXpaQO6gJ3sLx8DHPo/KRT339xNE3I5SVQ9xLDvSw/PRr5hZnvow/d4ucI34wt1iQpUuheNxJmtV+QmmcLBJearCKcvsTCZ6LUH/k5Y81HSVMqBKIQzOP4p+bFV2Grdw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf872e3-12cf-4b46-445a-08df04a8f178
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 02:06:16.3054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhflaIEmPXesfO560SKU1bGRruCYlNnbrL5D3weorjF2ZwKWNvSRHJ1kV04JX7hq9FtrB9eF41fZ2OMnvJjJiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6296
X-OriginatorOrg: intel.com

On Mon, Aug 17, 2026 at 04:38:49PM +0800, Xiaoyao Li wrote:
> > +
> > +static u8 vm_type;
> > +static gpa_t ucall_mmio_gpa;
> > +
> > +void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
> > +{
> > +	vm_type = vm->type;

vm_type is u8 but vm->type is unsigned long

> > +	sync_global_to_guest(vm, vm_type);
> 
> It works and it looks simple. But we have the architectural approach to test
> if a guest is TD guest, by checking the CPUID 0x21.
> 
> Since checking CPUID 0x21 is not complex, and as a bonus it can help test if
> TDX module behaves correctly for CPUID leaf 0x21, I think we should switch
> to use CPUID 0x21 to check if it is TDX VM in guest code?

Hmm... This makes me wonder if vm->arch.s_bit below could be replaced
with the same architectural approach. GPAW is available through
TDG.VP.INFO or the initial RBX value. This does require a bit more
plumbing though.

> 
> > +	if (is_tdx_vm(vm)) {
> > +		ucall_mmio_gpa = UCALL_MMIO_GPA | vm->arch.s_bit;
> 
> So the passed-in @mmio_gpa is not used. Why cannot use the mmio_gpa,
> 
>   slot0->region.guest_phys_addr + slot0->region.memory_size
> 
> chosen by __vm_create()?

Looks like this was discussed previously [1]. Maybe at least a comment
here would help?

[1] https://lore.kernel.org/all/ajGaMb6Lrk3OS8B4@google.com/

> 
