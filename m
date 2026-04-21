Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3247EAC7;
	Tue, 21 Apr 2026 00:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776729807; cv=fail; b=Ca0lQmUF6ZB7Ig0IFpWocJv55dqQWIozKyQqbbha6Y8z3DzdIJ4L/YPJV3JQMIWljahtnlzXDX4MJddkSw7XfmG2R6dUqNjaAPQaF/cNVEBDv/gmgffIw4hKcs8DLsoHlioKg+Hokca5p0jqGAaYo9aZ2EnayOE/LKH6bh8Tsv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776729807; c=relaxed/simple;
	bh=EEDlClUKPi9TGpYjGuOFn+PsKbM/6VY/zsccIuN+8es=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FfC0T8rOVwBoDdUoq5f/t+lh/ynJPxzJMeochrIbvXEKZM1fcyj2NN0C52+Ic1xINzplBd3uwZtQiaa98MGiAD5eB7hy/CfxraVgl7RwJH3PXmuiLENW1VIX4RLbA8OV8GVRw12W3X7oIrpBZuenZeAY2lGwqNet/OvfZzOtTXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0sIOUlk; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0sIOUlk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776729807; x=1808265807;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EEDlClUKPi9TGpYjGuOFn+PsKbM/6VY/zsccIuN+8es=;
  b=a0sIOUlk3Ph4PZO+64mg6ANGQwKyk7Z04r/vRfLEIYB0K40XcadXV5ok
   4MKEp/gV27wA952QDl+8KgyFEMLOx0yCjoT47jgMUH9hJfh2SObfTSOOh
   XfsIdIXc+DHMPg9aImJWooBwWW4O8+5ZBZG2/jWCUC8GxWXUEd4V9QCSl
   kshfMV70aXxp23jWKM8cyyL8IC5yOHV9BWNP+Zde9UQBjahwgBpdjtnwD
   wiJAuK36BVobHu/NCq7w0fTmW9YQy3HeqYlh6RAjnzQYcY5Uf8NMZ2nlL
   kW4Yx5GiN7CZ2/CAXDJYpYLdVBKJ6Ww8tm7TfinEF4uIL6QUKILauTcpX
   w==;
X-CSE-ConnectionGUID: Trnp33KdTXytgE5W1DLVrg==
X-CSE-MsgGUID: mQj8Pj6lTHeFANQNy5mXtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="65191197"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="65191197"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 17:03:26 -0700
X-CSE-ConnectionGUID: EHMYu0FST46HSyeU+5gdbw==
X-CSE-MsgGUID: x8eM5EVsQtqBicnxp08++g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="236844076"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 17:03:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 17:03:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 17:03:24 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.68)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 17:03:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoFijPplaG2Ndak3WIq/3cYfMmhHvxKdLO0L5IXQefZohJWNUJmQ+opS+nubmjrarjwuoFNDZzXYSNMG47UB0BB0tprGC0je/aImUxCB2Mw0+s9EDVtqOsdl7+H2wmSqL6T7Noye3cuLC3vKpGmf9lmuobFl8yAaZxgklmeuXyxzkwB3QaTJIpBMwEDdJ9EUoApD9Sy8Yc/KSbrkK1l2bLzAftTqZUpOVKnksuqT6dgaslMgeMpghSDwyWiD73ZIjq+eV/NMIwLPU4D1tCRok6g52tibBY7Vs/DQ0sGc3pfW9J16NzdmCIgb8aV0dOD4b0GJkzUNtzcsGvZPfYs0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2P0wPxL6rWjELm/Ft527BifCOGcEJQc2VnnmSbTAzE=;
 b=DNWr/5ZJDuaKDI++5a8eteknbcr7sHu3bxxlAZUu9+0djed/4VPhIF3Zc2v/paudSebPyazbO7/4lM1L1ZgJxrYyUUBIfPpR3a5UezTcGuRDmvw60GWpgZNA2pPyrZCsOT7YaBHeZceCiLe/tXtgZZ0qe85hy6Mz31K6DcWEWJKYxDDw+rCWKGGvTqBXZiVaOukcaPJHsv68hojgdtavokQzN5wDGErjwntXNuHzcgyNjCzN/W9E8ksaxswZOhJeJsC3WhnOEwKOM8s39cQmj0OSRfyGDA4gc0D720KPzMBXrS4D7MXWm9ntdEDcPC/YWe5BsIX5z1kzfMn3FnzoEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM3PPFCBDC4B878.namprd11.prod.outlook.com (2603:10b6:f:fc00::f4f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 21 Apr
 2026 00:03:17 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%7]) with mapi id 15.20.9846.014; Tue, 21 Apr 2026
 00:03:17 +0000
Date: Mon, 20 Apr 2026 17:03:13 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: "Moger, Babu" <bmoger@amd.com>
CC: Reinette Chatre <reinette.chatre@intel.com>, Babu Moger
	<babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"Dave.Martin@arm.com" <Dave.Martin@arm.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "pmladek@suse.com"
	<pmladek@suse.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "kees@kernel.org"
	<kees@kernel.org>, "elver@google.com" <elver@google.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "lirongqing@baidu.com"
	<lirongqing@baidu.com>, "safinaskar@gmail.com" <safinaskar@gmail.com>,
	"fvdl@google.com" <fvdl@google.com>, "seanjc@google.com" <seanjc@google.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"xin@zytor.com" <xin@zytor.com>, "tiala@microsoft.com" <tiala@microsoft.com>,
	"chang.seok.bae@intel.com" <chang.seok.bae@intel.com>, "Lendacky, Thomas"
	<Thomas.Lendacky@amd.com>, "elena.reshetova@intel.com"
	<elena.reshetova@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"eranian@google.com" <eranian@google.com>, "peternewman@google.com"
	<peternewman@google.com>
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
Message-ID: <aea-wdaZAWl2Al1h@agluck-desk3>
References: <43880b7b-b390-4e7f-8c2a-46cde9e3b051@intel.com>
 <bb9f62f1-0c79-4d29-9866-c39d08c3a774@amd.com>
 <5a273b0f-8225-4e9e-924e-884183734659@intel.com>
 <73c46024-4cf2-4f03-9268-d4378825fa87@amd.com>
 <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
 <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
 <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
 <39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com>
 <b74cfe34-e23e-49e3-beb4-d5639d42d5cc@intel.com>
 <99a2da36-6a21-4a99-98e0-3c9a4cf7ecf6@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <99a2da36-6a21-4a99-98e0-3c9a4cf7ecf6@amd.com>
X-ClientProxiedBy: BY3PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:217::12) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|DM3PPFCBDC4B878:EE_
X-MS-Office365-Filtering-Correlation-Id: 09bc8cde-9348-4fdc-a2e5-08de9f3963b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: CSvv9DnxQZFgpWCVftF05yvxpMiN9sxxEeavhyNx9KVOQojlJUWq9Hst8iEDHI16N0l7WEo6EblB7D7ly6C9MsRAKTlDcguY8fqTy3f78d5g1n3+9r/8dfqzrU2OnPJjFKV/iRpGsY+CARx//YSifY2IvQU6Y+qbh9JXJT3PbW51s9vTW72pLsz8qKcJ91oaRO6JiiSg1BWVngdAsLFQHVlafbmqaYBUG1n40l6XjGg8jwVn7SqvPrCzt30cSTvb8dW2CWyfahE8/NIEuuEVMu6HxvbX98ediFMpyimZrVhkLaVzPuB4gGUvJ7Qg9r1IodMHIKpBHZnmVwLkSQf/wVHAff7Gt9+sG5Udf32bErKGXFsmhhtf6kci1elCBiDnpXPjcBUWxIN9UykbXrjw5CnQDJja9xwRVNVP8b5bRL36US3GeolkL76jOus5nS6uoyb58qXd7jb0uj4UOdzebjROEXuofDxq+D1uyT6U4UdwhvwwY9gMm3dsYaqH5MVCDN+lU6mO+7MuFgOSRhHWqdJWPOFHCoa+RG64i8k5S7ozNJbxYMPhl/7RW+Oz0gN/uEipulIPoF7IgQUD7eIhwUJVKtswgb+7rtCWjiTDbPA/IRWzaFxsv+H0T+r2cxryS59LR3OQiMjslB4KC00u7Z9KrnGf/2URRoXj3bxkql2drl6lKhYT4ofxlOGcWX0ddTlFKrK7KLO3Txu6ue+vrHRn2df13EloH6HjACnTfjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AxlF1k8BdWZLy63nVWScpdXx11Jk9v69CghlgWY972b0ltv1laHKlwGxdiJ6?=
 =?us-ascii?Q?usVpwGbTHDxxxf0Z/hgWvNZtBvrH75Pj9HAaG470soZmUVerYqQh5+8ZT7tc?=
 =?us-ascii?Q?f4UAMcxuzvuYcAPdWci2sD82YP4xl2Gq8x6VcxVI2Kz/EwLrZRbkbmte4BBp?=
 =?us-ascii?Q?XThRVIRJ/K7X1Xk7HMYXW002uGm+zzNa9Ki8IH7R7d3M0xKYN+yHF7LiYN/M?=
 =?us-ascii?Q?gGquCKjLBv4OmxyIxtSXLhbgAbopSeYxCpqij9Am/h1GMtCaZv/7wy0I98y0?=
 =?us-ascii?Q?AE66XI4uQJ4w0kGri78PiHIjJrjC6ZYho/g2T+8uf0wYL8JXPV3SMcQNP+FX?=
 =?us-ascii?Q?IRd7yUlWyPIOlElrwvi4CjuhJ4SqkE76l7nKtXLgdHauirxAepgb/nYZIriX?=
 =?us-ascii?Q?8Cv7r9iT0X15rIhtfeqOm3s11rROx7VWmTkVYV5qb3lTzFJxUUBLGPMove5Q?=
 =?us-ascii?Q?n6nscI9Z0F8CMIYZqxnHMjQMAwtpe/sV1A02MnKvmILpug6UBzk8bH5WPd/n?=
 =?us-ascii?Q?Y3s6dFP373+/X6YaTFp2+H4YLLRr+CDSk8SSeFgn1/0tzNfTDJR9v1Vh1qbw?=
 =?us-ascii?Q?4SKGM4X5V/A8Vd8KtNptd50RXZnsstbqfLh11L2pJzC351o5RbDBKMOFqA/m?=
 =?us-ascii?Q?Bh2X7MH4Sq2bGhIUun27yhLDQ8DzjY/ZbJF9u6zhx+o6vzjYIHCNiQxDKzy8?=
 =?us-ascii?Q?BD0hvUVAw/E2nSwGZ45zZrLgo65+MisMWu2b7eVUZ1ztzMJml+7MbauXzE/n?=
 =?us-ascii?Q?iDwXiv1DoefY+gN+P264MEd5lgnVQaiKBRI0Vxg3s8DD+ZIasu3ul2vzNdTq?=
 =?us-ascii?Q?XNcxyfC4bbHmIfJtgaaBLMi9ucLv7cn/tqEeXUpILXcGzDIjtTIpWhlLGDwX?=
 =?us-ascii?Q?kwyhYhsTLSI6enZixv4gMcpv0ef3xpeQA/fosym7jzbPc9wxQgcB7gYiVvqu?=
 =?us-ascii?Q?fwbbQVgedwfj8TyfsMfSLTefjVNha7D874FJut2jsIdEZkZFft9ZoCWYJqtH?=
 =?us-ascii?Q?YkRiQcxW1WJu4aeQCNFwKx95NrQ0enlNIf8atr0NxcO/CmtL7QdpMBydr5+7?=
 =?us-ascii?Q?kR4gm6cFQvnL4z4gLvBp2ShJyfeydEVs3IyfXHz7eakXJz23R8OVWgK2jGeU?=
 =?us-ascii?Q?+fu58bdyuisVIFhhxGLcU5Gb0L9Jx4MOmCEn+cGNGuzOdJiMaaXS0d+G4s5j?=
 =?us-ascii?Q?oyfNsTZBJSzR1N1Aag/B3QhPLlRZyCx9x4MUjjYF4rSnuyaTQvMTpefm7pVG?=
 =?us-ascii?Q?iGOsWYtJUKuwpFzZg1tvtI3kQiDioGfdqqrZVhmt3WCdUdjErvZwzrmH809g?=
 =?us-ascii?Q?BVl/WVrOKcW5DtNLBg6yQcO6L8St/4ahavE107P2Kf0HiKsVJ2BdmQTPXVWy?=
 =?us-ascii?Q?IXYmDzXEJzResIB+oMGsQ5yX/lRRb4/qYkcCox0KtYi1L5qY5xMIsyXouBD8?=
 =?us-ascii?Q?3PlE39DdUMNvw6E1lez8cF/wHeIa1pJ071AfZoj23SzsqSQfptN6TGYvOCt5?=
 =?us-ascii?Q?WHxK8Bkl3fAHoyzjoZ9Z9knTaY1OFyuERhTAWg5Lu5yohw8CihrmRPBj2wXd?=
 =?us-ascii?Q?wDE4Ekvj4AyCh0As1T02D4JH7W76zg1A66k6m57VmbBK/O7mMLVcuib0xXHN?=
 =?us-ascii?Q?BliKP0quqU2o9AyKoSoNT7EQEIaXtuoQcDli0NUwuzd4atLTiR1On1cfjg2h?=
 =?us-ascii?Q?v3Ad/9s28rsTLM4drxk/zJHUlYUaafYYkqwHpsdy+eX9NV6YfrMaq7W8AiKS?=
 =?us-ascii?Q?rbKNR7RcSA=3D=3D?=
X-Exchange-RoutingPolicyChecked: kIvASO/Q37E0yffLaXclG0TaOrmGbNSAkcUuN9kDyJ2EUoXROXddl9R2hK1pENcsRszfFey4TxfXPZ4UCOpNX1169004hkPZULu6SF8Sf9t1l3g9qQj8oGwsFvgGqVeIu4zx2A/51jupJM/8hnBBkChpMcTodouFfjivyvpfkAdzsiUlokcU24tRDFVooeNtZlo4ce1kJ4WcYoM9hzQSwwOA98rCopufGUUu5DEuVyw11nzDe/tEF4M5adAPpkw45+hiyAt0C7CxzDkUKSpV3N+FxAWEIOZoC1gIQhfh2cBUrQhaM7yVq1uFPeycCDqNo1aV5EBMVf4QWPyFOOsQkw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bc8cde-9348-4fdc-a2e5-08de9f3963b2
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 00:03:17.1765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32W2Kob6m6j6t0AOylSI1Ex0A3OxIoUgKunKUG9iJ6piwXRAVe77bQ3Xz9qU1j8fJK+vHjJA2RjZ6coLSLijpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCBDC4B878
X-OriginatorOrg: intel.com

> The system boots with these default settings:
> 
> # cat info/kernel_mode
> [inherit_ctrl_and_mon]
> global_assign_ctrl_assign_mon_per_cpu
> global_assign_ctrl_inherit_mon_per_cpu
> 
> 
> At this point, the interface info/kernel_mode_assignment is not visible.
> 
> Next, lets create a new control group:
> 
> # mkdir ctrl1

This allocates a CLOSID and an RMID for this group.

> We want to designate this group as the new kernel-mode group.
> 
> First operation: Change the mode:
> 
> # echo "global_assign_ctrl_inherit_mon_per_cpu" > info/kernel_mode

This mode needs a CLOSID for PLZA, but doesn't need an RMID.

> At this stage, only the kernel mode is being changed. However, there is no
> way to know which control group the user intends to assign to kernel mode.
> All we know here is the selected mode.
> 
> After this operation, the info/kernel_mode_assignment interface should
> become visible. But the question is: what should it contain or point to at
> this moment?
> 
> # cat info/kernel_mode_assignment
> ??
> 
> Next operation: Assign the group
> 
> # echo "ctrl1//" > info/kernel_mode_assignment

Now ring0 code is using the CLOSID from the ctrl1 group.

But the RMID for this group isn't used.

Are we OK with "wasting" an RMID in this way?

Maybe it doesn't matter too much for AMD as you would just
avoid assigning any counters to this group. But should Intel
get around to doing PLZA-like functionality, that's a real
loss of an RMID that might be useful elsewhere.

-Tony
