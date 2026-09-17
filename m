Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328194B1CEE;
	Thu, 17 Sep 2026 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636593; cv=fail; b=nk319z/BO54WAaWqJHCa4gutIrYMfWW20ggRpHvmuL1UPF/qfDgZUM5n4apjqombrhLSff71QOnr/FqqsUpG8efd4vLBxl4dETB01fwFBsG07chW9LWyVpvYtUSVSDfW6+Q/vj8vKQmDZw5lpR+w3C/w2w/21YgKZXebfC/ksVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636593; c=relaxed/simple;
	bh=XtzMZQCdfStoST/v/aGb4G4xNH2gewiTSdy47DEcdEE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O7+Jq7wmBYku9moKUXiBiLY87AxpcgBuniKBuopvOuflMgN/DMSDB0hYi5lTmKg7E47IYcCMdvyR2BK0MQ5F8BzODy13RibiF97fJLK68FRfDXbmCYPiGovfzpTi27Mgxq0anG2CdWi40yjQ5a4YRQeJV8jAdSgC+8kE39eD27s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6nsF2ur; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6nsF2ur"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789636591; x=1821172591;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XtzMZQCdfStoST/v/aGb4G4xNH2gewiTSdy47DEcdEE=;
  b=g6nsF2ur4ZAXRvisz99lpKMSUavg6c48iY4m3dzgiW7+0CLci3zwAuXN
   eJPDsvNy3PqSXUQlP/r1PLo1QL8r0veE1zTOiHhWnKXixwtbi+HNo42Sd
   Ma+GCSdpyhSPxPC6qbDXNw+RB4dya7OByzY+fN15jxHo7KsU0axx76WPY
   hOEfzJfD7R8rm5LVztKLT/b1Src9RP5SoEXo28bq6YgDggJvRg0PVOoRC
   ukCI7Ze7Gve4DwDUht9ZGA77/UgbuFGbEuwcYJrODjdgKdV13yMXe1uoJ
   sDPGGqRjnx/wR1syasU6moDf4Hq49ZhiDGqaEOoXgZeKGDNVjzrDxfM57
   w==;
X-CSE-ConnectionGUID: 19mNP0EwTTOjM25GlYuisg==
X-CSE-MsgGUID: q2QHaXNkSDqxu4UU4nrfSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89175656"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89175656"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:16:30 -0700
X-CSE-ConnectionGUID: jPm5sStAT8mG6WYl85zoMg==
X-CSE-MsgGUID: BfbGlwLhReSyuEucirI6lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2081204"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:16:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 02:16:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 02:16:29 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 02:16:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGgAKCSOZOwFtD91MZgY9pothPJNf/WJgS1WQYqohsbMCzoaNsjVbH35nqw034zkqslLYVxbnY7Vq7BXmi88IJr6Sz7i3vF4VsdzAcGXy43VYbS92TTWarRyCsvmu4fZc2Uy0LvLuhbWT0iM8Vf0bsWds5KvZY7qkM8SVoymIpb9Va6oTxhuxC3sQwVaF07atj5N0QVtRJ7UYPiVVvfxD5JxPyM6Pnr1/ps9U3IL0NHTnm2VCEdLTKxnWgNPch1WbF5x5z4nCAR1hdJdUDyG/7VlUPlPwSdgnLyH6BZxvqiiWtsgdy25eHs+JNkIWIkMz2femSLoYzqqVjES4vAltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eD62kmBjbCsBjfXZF0CptGSoNs7xgbAsLP/1mbl5VKE=;
 b=Qqa/Ma97bDnAwMESK128dXlFvFUrexRM5tYMO8hQ64xlEPMcLXM0hKwry2e+2HhUtsGNKTqgyolZ5gLGLke1nX1aMnyUVedBm9awJahmnI5TQqdkwfjsOiD7AjdE/NJV9EjPtsuyM3dMIWM0F6i/AFF1yH5oVAwU0D88fED1+W/Jrl4unJyLQ1yJmPC7+hGr4EohqIde4LpSU7KxNMcbqRXoiKHcTi1D/XQ7utfYn93BHQINWNSvil470XiZ5YEzrG8Ifc/IZB7IM7hLpnEZPBlXA1MAFNY9bd8fQUO3afzL4GP0RC2eGa++tKL3Mjj36mnZEswwIQSWFKOnDoDOfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by PH0PR11MB9521.namprd11.prod.outlook.com
 (2603:10b6:510:3b1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:16:19 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 09:16:19 +0000
Date: Thu, 17 Sep 2026 02:16:16 -0700
From: Peter Fang <peter.fang@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: "Li, Xiaoyao" <Xiaoyao.Li@intel.com>, Lisa Wang <wyihan@google.com>,
	Andrew Jones <ajones@ventanamicro.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, "Gao, Chao" <chao.gao@intel.com>, "Qiang,
 Chenyi" <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Aktas, Erdem" <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Wang, Roger" <runanwang@google.com>, "Ryan
 Afranji" <afranji@google.com>, Sagi Shahar <sagis@google.com>, "Sean
 Christopherson" <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, "Oliver
 Upton" <oupton@kernel.org>, Jeremiah McReynolds <jmcrey@google.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v14 19/22] KVM: selftests: Finalize TD memory as part of
 kvm_arch_vm_finalize_vcpus
Message-ID: <aquv4Bx0zynfQjSM@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-19-15ad654a50db@google.com>
 <0a08eab7-e093-46ef-97bc-531766cdbcf2@intel.com>
 <CAEvNRgHE-c09hdeLqkUfGdnrAUkENuSrdNqByXBYr3N=HSbB_A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEvNRgHE-c09hdeLqkUfGdnrAUkENuSrdNqByXBYr3N=HSbB_A@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:a03:338::33) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|PH0PR11MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae69195-34c3-454d-5e49-08df149c5593
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: Jbq3axVohaBxxp0Y14YuA06yonTOk6NfQh9yS4XgAOrqzNmvoEyVCQ4aP4XQ82Q97wwJ9eKurYGRWuSuSzbAzILJmUlUvVmshDs9lGAKai/wpb1vSDcWtApnJKWeUqBbkC4SSc/A9F04SOvb//FvPQzXdy2LiJxfdxg/0LEr5o6gQ2l6kj4LJ8VoiYdeipTqXpX/afgTGxpOV5k+AT7IWRi8HCn5/a5L/YYP+fWJ6cmsvF4XJ+VBdZX31sVdiokFIKl6q0tQnmENB/g2x6SwPSjsqZ0CBprO0ppTv17mW1NYtLEhcQn/6z+eVMC7ay3cSS4d7V2Zn+qiigX89ohb88wmm46eqVCRJIA/gVlHRPfks3BJI2+nTlpVioGLFLuWKaD25kJtW+Appq8ExMmy8nXrDh/Vk9Hg87JBvYMMriG9JpXM3C/J0VcwHOB9xnPYPGFTE5kIgZxJ+8ghuDgZTxFPtE6caKcIA6n0N8WcwbsUUr2SiSIExJpuWB1dXvM511NJrWNBqFaxxJgoLp3QwbBFd6um4KrUW5Vd9F0wyG5rGlpO39V35GDh5eKXvHxRkNnfy6xC/pWsk3LFdEK8k7k8FTcn4y3zP5byyoACs/VfLnuzyexSLyWpcSZc4JQqw/QQGMSrP1Eomq0jL21uBoSpwp074E/bUcf09WQ1tG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xrvCedwIbkvZWqHaYIzz3Xoz8fliiRl9/F7pH+l200qWf6OfiILvrQNCQjXo?=
 =?us-ascii?Q?OcZygbbUccmgEO8wtKYoFKmeF7T9P2RncIRjyBcSYQ4uoBJEdxtcCCPwdU6m?=
 =?us-ascii?Q?Z7ObP9vM+J+BVHDMVh/L3Rreg1OKitCN4pfUN5Zy7exE9rVqmOl+w69npDPB?=
 =?us-ascii?Q?esKeKiS4WrtduDdhHDMqSOLqlZmEg3XmDWJ15EL4c2SzcQZD0qB0tS2QuGUe?=
 =?us-ascii?Q?MoIFPWWVJLo6Au2cSoCgxW0CErgMFeRLKkEfmo+8y6yfY9VWWE2GaZRmysWy?=
 =?us-ascii?Q?LSvCxs5UdwbAz0A5PyD/Cj4wfgm3rXjyCHoOwFRNaz533v0MfFU6HHJm9X5E?=
 =?us-ascii?Q?ho3Qh8cw4kPJVgM+YW5BiQY+lQdUzpL6XEnybnZ1Lr2nZ9EWeKzBvuDE2hlL?=
 =?us-ascii?Q?/mHsaPan8X7Tyv5n2181IZCZT4m/+r/46h9q7skm+bPYlQBms803h+JOXIyc?=
 =?us-ascii?Q?qkW0HOGz5bskv4BenKbHs/sxQdNZgU42rhe3Fi7AxMue6koIykl1JkjaR77x?=
 =?us-ascii?Q?Ff7/x93k348rH6RzsGdp6yd6HluweirGXPVRtzWrGN0+GtmFmpiEJwBJ7W9a?=
 =?us-ascii?Q?cU2GBOVUUz+PT4Nr3yzuFIitwmwv6UKIYf7kOBD0AV/e0JnIfnUE6QbvmFgT?=
 =?us-ascii?Q?c9hej33v694TfnetJGC8jlIdui7ObNkXE0L+toNYk5bM/MYYtpwBRBOZT9tV?=
 =?us-ascii?Q?VSFlFWCHvZqmWOdsNFKdUBz10DnUDsbcCpLebjXbSerkmXaOzJe+TU6rt+Bg?=
 =?us-ascii?Q?AC4/Wu1bT+UI8GPWBDZdWgEYZ3DevrOau19hIy0hXrB+0Oplspnvb/X6tjGd?=
 =?us-ascii?Q?JnJCELLlhJ+P1egqZvE+Ph/GJULulE/hZAOsFGu+9vnvCuJSWvPBkFFX0udm?=
 =?us-ascii?Q?aKcRxpdbBnSMCu5EQQZIcsOFKlPZVZP0UgqIJlncn6yu6vz3cre8/fd37zpt?=
 =?us-ascii?Q?MjFX/RGEBUk8zZ/3VroDTuty0yPfrd66kRlyIg58dZki+a8maii/GujLFgbY?=
 =?us-ascii?Q?yfpP1N5qNhbAYpAwH+HlM4cuj5Irm8yLY8Flu4qQjKtOPk1JDkfvLlZxyJGx?=
 =?us-ascii?Q?a0Wbb0t7jbOFPFRzSiL+xlJAN6YNgpFBoR2I/W3chb5oK8y6pQHHiWUvfeVu?=
 =?us-ascii?Q?9cM5SypcAyksNKOye7/4/+INlPmgyKLwZr/qGSfmJkE8frjmE5LAI64CirNc?=
 =?us-ascii?Q?tu7f9aTKpKBJI90GzTBmaOAuiRRY5w/yk9mNsTwPQgLTTBaim7cVK/xyD5MU?=
 =?us-ascii?Q?N+UbjXw021PS8iZnZ7t+tbLDijA/zDjC0nQgR31NFqUxbhzE1cDdLZ+OHhhT?=
 =?us-ascii?Q?z/ZWxtROt46yFRuVElBV3HwTNRFwobHktXHJCgY2KTisI7J7Ra5XkOgEGZkX?=
 =?us-ascii?Q?XRg0y0+gaoHGPecWkoxyghvhAmLeWhAUWly0aNf5FbSv7766K8FoFg6XJgPn?=
 =?us-ascii?Q?HTOajlexjTcT8YMjpnS69mBglRwPWFAYtJ7B+Tp2rppBPbJJ1ltBcSeoQK9i?=
 =?us-ascii?Q?VokhTI0QFfp2PLZlCAX4IwumrUs5YOYH37AjHiw47X5oZt0hYSpMMDDUQtu1?=
 =?us-ascii?Q?wSQ45mKOUx52ohPS3Zy+XAOPT2YpRFLsdLXWjfC+d5st8PO5cfxIXeqeaWz5?=
 =?us-ascii?Q?WjeEnXTExu5oiWMUQe8I1v4ckH0nq9VQqNTcw+xw+Uh1nf6d4XVWAukAX0fx?=
 =?us-ascii?Q?N4YvI/ZwT8L8Zd/kahGEa2TYhLwL6qWzgbW2oLGOOpNXKqvFuAXBd2T3seQu?=
 =?us-ascii?Q?NcuvXBug5A=3D=3D?=
X-Exchange-RoutingPolicyChecked: Bt/Us88gm5uwM5SqF5iPDpJBibJutDbbu4maq74cj2UtMTkv8njAzTmWlhIPqIBdpKLCm6xolDqWnaLMhfjfxDb6g5ImDrHuwqCwUlQIzd2GBYEOvLrnSJHLapw0Pm52tCzPJ+2p/brm/T/ZJuv1dL4u33HnPA3DaQ06FfhNw4HtFDgLHPpX01cMn+R2pi8eJYv52cmYZ7XfeeevPwEG6T0o/TdDDFiDWD1oOIgTcPINm4eCR1NOVgluvNGHilFGdzM0c5PtlyFZH8wYmAQ0WTSEXIVlCjUKknwoAcYBEzvImVxvqVZVyD3y5D4lXVCo+Wk5t2E9fW3pnPRh9o+91w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae69195-34c3-454d-5e49-08df149c5593
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:16:19.4064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGJYQo9TqgT9sl8BnDTOOAIDJ2UIdaMU68gtrMHALuFdjKZP6xWJibjAU5RpvgvOFKjZtXmp63UbvHkN5trGKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9521
X-OriginatorOrg: intel.com

On Tue, Sep 08, 2026 at 04:24:38PM -0700, Ackerley Tng wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
> > On 7/23/2026 7:13 AM, Lisa Wang wrote:
> >> From: Sagi Shahar <sagis@google.com>
> >>
> >> Finalize TDX VM after creation to make it runnable.
> >
> > The changelog is too weak.
> >
> 
> Some other points I can think of (Xiaoyao, please add on!):
> 
> + Why was kvm_arch_vm_finalize_vcpus() was picked as the lifecycle hook
>   in which to finalize the VM? (See comments from the earlier revision
>   from Sean) What are the rejected alternatives?
> + Expand on "make it runnable": finalizing also performs measurements
> 
> Just confirming: Peter, you meant to add the () at the end of
> kvm_arch_vm_finalize_vcpus in the commit subject, right?

Yep correct

> 
