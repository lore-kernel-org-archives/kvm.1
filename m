Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201843A5E75;
	Fri,  3 Apr 2026 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775211515; cv=fail; b=lRMyzQ54mVrWfneVGp/MG7w3iSSI6SJN+ONnCsWdulah3ITyTeXz6EfsqeiOqeu1WiSJaVAiZByuWR8gxj++3dA8qgixUsUffjEyYcoCjFRxjOd3w79JkH5RGV24/RIKl8HNnag1JL7Z5oowoGj2KuFGQhwUoBd0XLSyHJo5VwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775211515; c=relaxed/simple;
	bh=/bix4SwH+cVDBOv8T6wQFx2kY0jjpoCzzIbNi/8GEZ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tkxHAM1biwHbmJoh9Z4pxNSmPOJ5uLbKwB2EF006cqLJ63yb+GMZsr30heI9crQ83poGDmr2Qxm7pCOddpRyBtK5lxtuyoDG5ImkfA3Jq0rOyqvHKr8KYB+z0TKHoI3hgjU1F4soBO52KXHGnr8AMiGniFNy5NxPvu0ong9jr6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CP0B9Mte; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CP0B9Mte"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775211513; x=1806747513;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/bix4SwH+cVDBOv8T6wQFx2kY0jjpoCzzIbNi/8GEZ8=;
  b=CP0B9MtedgmldE06JkrfeoS6P44Jj2f9JVATaRJR61Wko0+iNTWaJme2
   X2eWfOcH1WLVUiNubMofLZzkF4i/LfFRNoeGye85dDXR3F91yotwYWily
   i8qi0lGkhIzq19ZASEYGdQF9TDCX3vCqLz2zgY3NFr6XSqG6DmNn6O2gP
   75Ay6bjZFc//FfhAnQWGlafRiV2gQ9jDw5IM3gIXuAiF7NvPklVUS41y0
   otjEHnci8eXjJtyD8QeKogg9ZhCWMLoFsQDSttDxphk28Gg/rBvw7TclP
   G47TfS+BbBZMwZk67aDt7pAK+7fuAeJBfZMpIN7yGYdualKO4QzHyxCFY
   A==;
X-CSE-ConnectionGUID: pYRysGtbS0SPgiQSD0j67w==
X-CSE-MsgGUID: jruL2B6NToeRkHHDUwv+LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76162420"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="76162420"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 03:18:33 -0700
X-CSE-ConnectionGUID: +3ukwKtnTyijl2PbkuhRXg==
X-CSE-MsgGUID: 6PUGrCL8QjWyVEoFlu+lyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="231619249"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 03:18:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 03:18:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 03:18:31 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.37) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 03:18:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9Kdr+/eD9oFCb4tAn54ZQ9Q4FfuPIPngT6pKnkoY0bG0eC/a4fui6pEPKrp+HpGsN+8zCHEP48HhCepdkOijf4e+RzbuF2eQyFOfEHY3NWo/ajMAiL2m/ctvXkjiplUMZJ0gQV9+fmaoWQIRrdzCEpvW0cU1uDekk2PEWO8o0FYUKB9AuoBCiXTq1qbinCOsWl5qdgwXyZE+t44gCxHrqYeF2/BxKJ4a4r2SMPls5PsBvluBTObpV3H0sO071HMiKdVTcfU4Y+aUzSeILrqBQA+vzyxDwR3Ec6KMRpeV1QsYWu7cRlPXGGukAOJ7wYzjZvbdNIe3iHCZILkK1R4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XExWi4pOWGBbFeKE1cbrWgwBqFQC5brhDUaEI16h5I4=;
 b=B8JYl6T+ARpQpJEBXUB1z91NeI/oe+wPNZPyp0iAPfAk5rwIjSQCtNuXQnlOVKE8DXq9DeW7xeDmX8h571j/5erTJkxbAqq/KjXIe4EfyRwLzmtB2M34QtrxYJDezIxW6bB5jT625W11AAxyHJx03HEqY5fGBhMPnwqIAGn5JKFc1vM3HEQdgqPw/pVEoKX6SSNrgh2pm2y0f3nNCk3oWeii1qcbR4TxZH42a38DAoA4in/z/mz22Nc6obIY6ufnsCcVXRky1eC6xWC0q7QkTd3mSibfIrsavy17zOY3bYeHvf6/WQUpUJjRGNNH0S881cFoKI6XvPN6iOz8hHmbUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by CO1PR11MB4916.namprd11.prod.outlook.com (2603:10b6:303:9c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 3 Apr
 2026 10:18:28 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 10:18:27 +0000
Date: Fri, 3 Apr 2026 03:18:23 -0700
From: "Fang, Peter" <peter.fang@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin
	<npiggin@gmail.com>, <kvm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, KarimAllah Ahmed <karahmed@amazon.de>,
	"Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>
Subject: Re: [PATCH] KVM: Fix kvm_vcpu_map[_readonly]() function prototypes
Message-ID: <ac+T78h8hA1iwoqh@pedri>
References: <20260325092001.613025-1-peter.fang@intel.com>
 <acsvbxIdtlQzUw4q@google.com>
 <acxjMsx/UixNa2R/@pedri>
 <ac8BOGXIPMnJ7kIg@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac8BOGXIPMnJ7kIg@google.com>
X-ClientProxiedBy: SJ0PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::32) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|CO1PR11MB4916:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b3464a-cc84-4d77-99d3-08de916a58c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eihmQWhQ6LMkoxmWkbTr4RtqAIP3Nm6Ykn3U311KtwYXroQIvg6YHlxRblRsFQj27ZZCD20KMJR9rnv1qSzciQKOY5IAaZlerrtM6Kr4TgLGb9QM+GySvBD+Lm0CMb/+WxdjzIwFEGF8pDvs06ig4hJYx7cKB5ptmsBaWsHliiGFr+eTe58WiYNQxSmxvljEsJTkm2y1owVCIeDbmJG8VJFc8etzpt0Trt+rBKtn9Wr17mkXWvqxomd7YWLqxDchnkHBMukI/UCudNOYXWF5ntIKy+lKgpY8q1FPul6j+WaCTRy3Rt0+S5t0SQi5PMArxNSXR/mCxC1eDcxaXYsIfusoZWCYinfrsWpZGRl9oFL/W8WjYA5bd7a1S7aQhDpUcww4Lp2Xw026p0fWby0MG4EdX5lmAV09p7xvOEjQdgpnojnYWb5tMR3qeafjVeJ3O4SgAyL28OZiWHFEDEnxG8K8iGPe26f8X2EwXCHUD67GN3PY2MT7kLtu6t1TXRy+KMS1qqt1gKaYCiOUp0EYU4NXrJV8LN2NDg6sNKsbAFG+U94FKzZ+SRYQtFJwFeAbz4CEkoPUUbz9I4XvT/Qh+PzqJYI2BukwOnrcq/NaZY1BmGe2JHh+zo/7SQP68MYi9OtXRrFBXQMLWA68JbQZ04YomCA5uGRJsJfVKo3zFfzZUkBYfp43DrdD8/8BG6TOBXNv5rywX7vYD67vcfBd0YFhAAG6sU2bKQv5b3s1x8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l53uTvCFWuet+RenT0RzLs9CL/sJJDtD4k/xOUfa2NUTaVx6WRT8Vbl74bIv?=
 =?us-ascii?Q?NBRtzm4bvVznRjuMnUde/7P4LusDu/e/htKz8pm/cZekYhH1dMGVnfc4nTjY?=
 =?us-ascii?Q?jhzCBRu0ceZCBLhismX9bf/UGhjsO0YpxS1aDgt8lP6Pvdm8uIe09cUB1Iwd?=
 =?us-ascii?Q?eC5OF7cEQC9fcMyGqP0rL4B3eBI3dmhKNTxVQBKKUNswjlY0k+ITyBSFLW1y?=
 =?us-ascii?Q?6ETEBmCznNo4BC0vaJqSLBsi3BiPG3EJMRRdUmih4X1XaMAXwOMwfVlVQg+S?=
 =?us-ascii?Q?BoY9gjqjwWm3shzttle6BNkrW33o4H/H0ftrrYIhFUtbRg2pprLklLKjEYDU?=
 =?us-ascii?Q?y9qMjEsvTSIGS7cD0dZm8/q4/LRdzFu4iCrND3XLeT9OgDmMgvRlQOHOCbKI?=
 =?us-ascii?Q?Tqz1VSwjLZBYucQEoZjwGWO/4zHXHqAOD9ISfTLOzS0qHistopVO8vObsD1I?=
 =?us-ascii?Q?YpLtjM+NMpguRkC5wf5/T8Z3J/mPLZ5vkVr7u9kahXIRJ+7CXqhknCaxvB7I?=
 =?us-ascii?Q?EmoVfWskCBccjhD/TcWAf6kPvT0ZHf4t7vuEAsz2MH3UXBzTQukJzTsePlri?=
 =?us-ascii?Q?KGcSNYHphtf6gQz+dt3h9pWjHgzT+ULBvAFEIOwYjrLhtw0P0DOJuqyzA0gf?=
 =?us-ascii?Q?evA3u1GTcH53NtrqCqr1k53MiaeTfAWyzNSX1TZfXKlqHOwGsrH11uoeZlhY?=
 =?us-ascii?Q?JBYhMNDQasx4cYTWwbhx4KrYDFFOtR4oVDYpVC/HIeEKca85y8/2sDFYLllh?=
 =?us-ascii?Q?5Pm50jC6U4+5CLJrw87EwRO2x66guw+FiSoFQBwMhYrgun/+ppPhz3WS35ag?=
 =?us-ascii?Q?fwUwYZr+DEs5IflpO9WGeb1o1zuD8CdMErddvNrW0KyutaMOQFRlKqrw5eoK?=
 =?us-ascii?Q?80/QwMrWHz+y3V7VX3D4+93Y7ASAPEUp/uWVaK4eN30YT4IgtF1UoWG9yBpc?=
 =?us-ascii?Q?ytoOLQMxiKz2U4qvVy+uz6gjI1CoheHhtZZN4k0cz+jvh3fUPz+DOYHg+wBY?=
 =?us-ascii?Q?aMgvq7Vh42yFqxe0FXmF7KylaqUNXVWMtT79hgwMA7hB8lolzC6+xAnh68vF?=
 =?us-ascii?Q?I3BAl5qsUVF/P+Y5Ba50baSQB+wkmKI2RXSsfcPEjfc3Z5J76ha6bJNAd05c?=
 =?us-ascii?Q?WTf7RgsY7mb5VypddYzMCfnBhujSOQSXrY5RLXAuhtTpkPNdXcFGHKqzNA7N?=
 =?us-ascii?Q?k4vx/jzEbtpZ07QeheazA6BchwrdLXhgNWm4Cv7TMgUZIdabHN3CzpyVsVPu?=
 =?us-ascii?Q?pcVTTQT/bUU4bAs65aJ7CLdYvAquxaJD4/l1fuCIpVkP9RxIdbTIquqFdYQS?=
 =?us-ascii?Q?43TeHks8usj6aFXeE6AQW3Sr8wNPUGNxjKDkzY3Z8/iVXARwRqF7r4X/czW0?=
 =?us-ascii?Q?gGpFXFCG7ybh0Izjt1Utf8994uZUAXZpT3nwI1d7F5xE/U9Azi0wmmSnMKvr?=
 =?us-ascii?Q?R/xvjDSagLb28Gmqef1EiHnXxsKuKI4wfJJqZAqhDDycyg4DrIP2pZTKo+lF?=
 =?us-ascii?Q?sq/+jprWkHWCkjJUJ1e7gPT2q1GW0miT0m7Q94/s89lO+ZAlAt/EdUJYNCVH?=
 =?us-ascii?Q?65DVafqLHLBgEyYc4BmOUTmMXdmXhwacBeGVWZuBVWzuVSuAVbHLO179ZA9j?=
 =?us-ascii?Q?sSWa0dHeTH2ZqjY1WeGbCrPQn9EaxvfkTozfMmjzuJ3RHm8KQqoT62ia0R3R?=
 =?us-ascii?Q?XGSN3BFKvWm/1tKn+tCuBPtauHdgYN8Ba7dBaC9HcmoFXq+JIxJkUcnbIoCK?=
 =?us-ascii?Q?IzQeTj5DHw=3D=3D?=
X-Exchange-RoutingPolicyChecked: A/QZRgZdufznLWGHpXVvyRfjTtC9BoihWvWJ+dCX5hiBo/rh3wNmtZUoUvi7wlglQGVkym44CE/X9bf6wo8yyuc0T6y4C5E06M2lJC2hKbKj/bCAEk/6/gl1JZ24I/C3fb9uVAAhReXvw9UKRFnauCllZnqv/OWyf20cDnU+HpA9vVNyHcxPCnsiG9tZcIyar+DDGZDqUeh7plKuWWNSMIr6479l+2vRiOb/4D+AbTsQld3a6KojbhK9OJ21VDtb1U3g/YZgVpcaJletMsZZaZfdaCqEnMGEGiB/KhChfsjvFyb4HqA7wF39vbWXUMEPSS3pCMP0k61bNgIVQU+0Ww==
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b3464a-cc84-4d77-99d3-08de916a58c6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 10:18:27.9157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIWvlHcSShE7s22fJbiM4qZKjSFbAupqourbmTQz8u7+TLV3YmzDBl7HItbRsKBXtlXXvAT5Qu1TnBBK/sdecA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4916
X-OriginatorOrg: intel.com

On Thu, Apr 02, 2026 at 04:52:24PM -0700, Sean Christopherson wrote:
> On Tue, Mar 31, 2026, Peter Fang wrote:
> > On Tue, Mar 31, 2026 at 02:22:47AM +0000, Yosry Ahmed wrote:
> > > 
> > > Most callers are converting a GPA to a GFN, I wonder if we should make
> 
> Not most, all.  The two outliers just do "gpa >> PAGE_SHIFT" instead of
> using gpa_to_gfn().
> 
> > > the function take in a GPA instead? But then we'll need to the GPA not
> > > being aligned to a page boundary (either do gpa_to_gfn() in
> > > __kvm_vcpu_map() or fail if it's not aligned).
> 
> Just do gpa_to_pfn().  If someone gets confused, we can add a comment explaining
> that kvm_vcpu_map() maps the entire page containing the gpa, but that should really
> go without saying...
> 
> > Thanks for the feedback!
> > 
> > Mapping guest memory into the host feels more like a GFN-based operation
> > to me. struct kvm_host_map is also designed around GFNs/PFNs so I think
> > using gfn_t in the function prototypes seems more natural. The caller
> > can handle the offset-in-page cases without creating a lot of complexity
> > in the APIs. But I'm happy to rework this if there's a desire to make
> > them more GPA-friendly.
> 
> I vote to rework the APIs (after first fixing the prototypes) to take a GPA.
> I agree that mapping a page at a given gfn is conceptually more natural, but
> as Yosry points out, requiring literally every caller to convert to a gfn doesn't
> make a whole lot of sense from a code maintenance perspective.

Thanks! I'll prepare a v2 series to clean up the call sites as well.
