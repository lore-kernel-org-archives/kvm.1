Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214E33B9D93;
	Mon, 28 Sep 2026 22:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635682; cv=fail; b=bVM5sR2nxDOstsGRqNfLzMD1LHuDK+uuspmo1IMenL3/4vD1cpLfUHS2AjrALSZNS8ZQH+N0UzVBTZSvnaNW0atK+vGrZMB0M6gReyHpTJnGZFXL4OusU9LaPsyscrSedCF2lniFjIlGPf/8XHzd70j+a62JzIEiVifyKJ20TZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635682; c=relaxed/simple;
	bh=ljVEMJe5IQreaUgFIFnAxlPXYVp1U9vZJN8h9744xrg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mx/KsaxQWZKkZ9GonmNF6wf9r/qAY6N5Rg6dTRGKCWuyvyNn8AIq6STCV0sWZ+HCwiAeXfOHY872sTF5bTrkkCxzdJKqxleR7RIvRJogqZJ+ywZXXBFNHS4IW/UDgC+kY1by+j9tb8/ohGwgp434LF6WE31Zz8xANFnWcdzWEPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fm0DPU8i; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fm0DPU8i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790635681; x=1822171681;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ljVEMJe5IQreaUgFIFnAxlPXYVp1U9vZJN8h9744xrg=;
  b=fm0DPU8i3unVW3b9w6TZE/4GwMRE/ZE/5xxdVTLKEg+H3ffMiGuF52tG
   GMjPA7hDTQdeK0vjo40OOGCdZtoaOOe/w0OktFFF3ICR9THWmG8H8uv6f
   l/Dp9pHYqEPC9tmhp3/sw4luvACTcfY7Qsw9XO5WSz7iOBDslb27Asess
   eyxXuwxFTVpVUXUlNSTj53iseYKGc497Z/tG+EnVmCn4nYmY1xLzt2ZRi
   kq/VKFPSc5hERMgGroyXnktPrtIRTWsQR0jM2HfdjyhmBZ1yYK3nWnfjn
   PRKBK1WMk4hcuO+yZHSfldTVpjIlYDvfyHuiUjBYCtAdFbAF+b/Hghnbq
   A==;
X-CSE-ConnectionGUID: gGkvhzR8Q76h4bI4Tg2hLA==
X-CSE-MsgGUID: Wl5x0P+DT4yR6scCOWzr9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90565857"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="90565857"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 15:48:00 -0700
X-CSE-ConnectionGUID: sDTP9jgSSriaV6cbm1kK6Q==
X-CSE-MsgGUID: Rwm06MtqQvK1FS1+hBrLGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="275317857"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 15:48:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 15:48:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 15:48:00 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 15:47:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfPO3nIW10tI8EPosIppQKOWmWYKmuhe1B4JsBbr0AAAPsXvnKyJQjagOFZHfDwvDUvSeFXNEtvP+ey3tFT7AWTfGWFHdDOqwrhpqJKWzECipzNtbCZCpgydDA/Oo2s00sty3QnNelsUkEDWw7JNN+mDFeyRMTaMnaeHru1lP1EzLnh6gKc0xhxXDXwQLT5J8t8tzB2oWsJVNfDJxqIKx3iej583vcJYv68Arc5KeGiNOPCQjr8nR0GofKoBz64G4N8lurCfme2NjpuOdvUlz1oe6wXEpLU7Q5PcwaweCY/n2OIJOxPqP4nqADatRMLZjAPBPwKhnG7Df7V/FBsS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujYLN1JaApb6/OixiAX2uKNAVQcyzSmJR9bEduQxrV4=;
 b=hqq/RjjBR6EdSFhlv5pmciFXeR6P/2cikzGNSkLZbZw7U7VXR/0unaUHqwO1p9TZC50WZlir/ZPHY9W4F4q24bfk6c31SJFaW0IVZyr4lhkd46RwNIJKMRwZCDbTH5Z9sfzEZ/h4dI0mZGTK0gCA3VRHI/BYrXs0iyC4iVtY7IcRzRRr83fovDzAt2UzQu6HAMpbtK8KQEJtbf8AdQStEUynitSJDBrQvVhmMegwTDpegki/nIV0Id5hsB0Frvku13RoMMRUiTF66484mq0vtiWHfA+cSRtqzkV92NZX9Zc84PrVxJbMxLL4sSmnhyFi96PCquteKNWMtP3WhSJPjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by DM3PPFD2F4A0090.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 22:47:57 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 22:47:57 +0000
Date: Mon, 28 Sep 2026 15:47:40 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v5 5/6] x86/tdx: Add a helper to query maximum Quote size
Message-ID: <arrujB9jBePsfhLs@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-6-peter.fang@intel.com>
 <bd235459708f5233444f31270d8785c0818c107f.camel@intel.com>
 <arrYlnkCq4GDIG9M@intel.com>
 <dec9a448fe5788b748ba616074270242fac5fa79.camel@intel.com>
 <a2fb22dceec6d7b75445ecf0a9ef6ac238eb5c78.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a2fb22dceec6d7b75445ecf0a9ef6ac238eb5c78.camel@intel.com>
X-ClientProxiedBy: BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::9) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|DM3PPFD2F4A0090:EE_
X-MS-Office365-Filtering-Correlation-Id: cea8a54c-3a6a-4456-4784-08df1db28a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: B1Z9MPXVkotYqIefeuVGHAhWnw2sfqH9KGRdltq+LduXrFCwIh3CpWaEmsY7tGpriuzzC4WD6qAfZTK/fVqLOK3p7ifS5LbqOYjCFQzjG9P+nIpqpL9lnJhOHciAY4IAGWRsFXRjnjnFV/TmCwMU7SJF4fRsHV3v5VZsh3SyaAa5ENVgyjvPkwxmei48q3xgZ0RHYgSEL9Kwk3guQCxtKIUvbFNRbT7+qMVezq59u21alGZsgMNRZnsudVPdbQfz5eGec4/8lsn5Zp7C5lsKSHr6l3dzgHvfPqq4BTMxtP/JvLiFNKM32cJMTbNqe9zumDpRKwxeZ2QcrxHQUR+qDro4shWWVPw15SjoerG8ISIVzjvUQlztYlY0nAoSi4keW2eSY5Sctq/iBIIh/O8BeIX7KrXI2NG6eYsQTXyMbbAsmYTH2w2Ydk3Clrhaq+MsnjIhHvCxZISmNMVYCyQkq1coU0iuGcB/X77c3Ol6W7Q7FMjY7agUJGwTUPhtshceDXjknthEKJEG0qU5emYNyYKcI90opxzvvpF87irTMzL97eLwavWNDJmQodWqgRQCpLAP7aDy8giDck83wRDSuDW5hPGT4e5MZoDfnqKvItG+MBlQ/Mc7eGbQE83hsfG0ObmxLNLqBONFtAL4oy1J4pArOzFy/Gn7FFCoI6NmSnc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CTHrjw3xdHIB35awjPMexe1kmtvvU9oJLruST1Dl4LSdMynhBBIsVtzjRdno?=
 =?us-ascii?Q?tzQWIaE6L6X5syakUQG+dxS+Z6o4z9P9VSmlnN4jnQe/0ULLQe9x0lhcdu0L?=
 =?us-ascii?Q?XesO8mPKH4hMPkSmyLE2AjNCzFMW94jJx8NudqvfL+jJpvxUkAyGXkFUKJXn?=
 =?us-ascii?Q?ZGdNvluuCFwo1q1v8jL/p8y4MS2EeExkp3yBbt63QzMbuuskMYLUxp67jstR?=
 =?us-ascii?Q?5gABCTkO8W9ZrmsfO4zPEilhqChxE4KPVD2uuXfgcHi7T0B2POZqX/r2aPmt?=
 =?us-ascii?Q?jOeDTWPz0jQUngLyn22j3Q4L2Qv/RNCCYKqVqnmzYRX6Qdmfm0sjBb/i3lwU?=
 =?us-ascii?Q?ZXzs3etJSoYQ3dInMyVJDUf8t+iFNw37lCt5ae7nk48kWEkuhmNKTpgCTGRG?=
 =?us-ascii?Q?iuODtdNtuB5SwvuEG70P60dZlbN17iLMh8X0hecCXyj8BVpkb2QI6K7DEvpf?=
 =?us-ascii?Q?a3XPM+lFQk5g+gruwtbVrGORXQX8vvQ7utxz8e04mtqY8g7pGnvwD+SCTP5l?=
 =?us-ascii?Q?XhoClUxaUCmqByDnbeA1Pi00R6l6Emp/TzH5LBUsrK6wsp18cmtLFf7//nAv?=
 =?us-ascii?Q?DIVdnrlCwGH7d6c1lceWIq6tF7ePkyOvygY4vt/wx0Fg+bLJhSGmRNm6f7+N?=
 =?us-ascii?Q?Ed4b0U9IJ0buWG8ZNbnv+CI83vmncYRl7dgCxFfkO+ezxGcf8izqWjKkS8FB?=
 =?us-ascii?Q?2lCLlMprE0jfWtTWO2teLjSFZssUladyUaQTUp3D9/Y2P7ouxaBjI5fGDi6p?=
 =?us-ascii?Q?DtTyvg3m73lhi+Zq/vcEEHqGxuYXKHIs6b+MNb2WkO40ll++5dPIeGw6d5Vl?=
 =?us-ascii?Q?hL2IvTyI/ETfW7A6nMP/o8JU+5qFCikbOdfKYZFbqx+Un5C/TM2BweCJ6DW/?=
 =?us-ascii?Q?iIOBbL2thFNphYcKSaqg/jk5u56T572WFt7Hd7b+yT+kEEW5RBuOhrcWvhMM?=
 =?us-ascii?Q?ER8PAU91tSl3Nu1Iou70E1wdED9Kr3+dE1Om7aUP9qmwIlFJZQwfTpUBzzc9?=
 =?us-ascii?Q?RukIzKo767tUAXx8BmNN3psHkTseIbO3ahb0p7PSHmJuY4+JEktwznWQ5QVu?=
 =?us-ascii?Q?ZnhtKMu80Gxg5GkFsYMzrdM4Xmp9jdxd9pmPKq1FbXi18TTEVBHvaxZ4AvN4?=
 =?us-ascii?Q?4y13RU41b30VQUQNJArhkpOET7+Va3vlFOLGQDJiQQwtu72M3KIgRFnfZvIA?=
 =?us-ascii?Q?8IiIQBHMMTZZyrm8riZELJP9jBe1smL8mJb0daOzomOqf6UM8BGAWCijrDI/?=
 =?us-ascii?Q?3g+H79PWwOjPpuRAzfVZJYJFqSwuzW0Jnu9gbHynj6cGf/ul4CTd6dVppt9E?=
 =?us-ascii?Q?hmyqS2u7fyo6llnLBeIK9uwU1XoOUV2nlBk5wTPbWOrtz/IRk2CkXyasfH03?=
 =?us-ascii?Q?5cj2RaQ5ZyjmMMUrwkJuzpX60Tf/muEovohYba1xZlZuJtuUtTWw8R3iP6sE?=
 =?us-ascii?Q?vodjfFT5pi7CUoF95DboSDW3aZiK8IbFqxHibTCeEis2Zz6ZLHFJUnAF44f3?=
 =?us-ascii?Q?QeQwabMtQzYdEJD9NIfA3d8fS15UG/BPBZ36Evcq5jKLm48h6Pz/ryB8jFRi?=
 =?us-ascii?Q?ww7EeBiTj4i511FCS6T0FrPIzf0L/iM2GgPt248Hnix6h3EH7B+a2L1VJmkr?=
 =?us-ascii?Q?jwRR19hXXt9R6P3PVT8vgBpyDIFtnN9ohaKSdkdcq8HSdZd/PgL1pUz0v9Le?=
 =?us-ascii?Q?H8zmM3rvwLpLGvwE1107CuF64T0L64YKmZi8ee+F7wAGfilTrWM7aSHOVhv4?=
 =?us-ascii?Q?qpsOMbYi4w=3D=3D?=
X-Exchange-RoutingPolicyChecked: l2UG/5n39J23e+Gu4xfEcPgfYP9qmAwstAcK3lWNs//v9Hjh3w21Nv1dGPG99tX5yuji6XKiMeZ1rrMXb2vZAewL8FNWd8nP9iWBybhaEqyT7VWFGTprGuAMfFcEuDNXua+UmHIioJJhVHe4j8HdthSlFcEESugME7jnyyEdm1XUBmosNNE7mDAZ7yhND0YB4LMsDKPvSDdORMvF4RMJ9xY9814XZlMoyXJwtKsP090JJwiIUWRWzrD6THx7u79WPNXJIm2v2D+Bs7VUswIQPOUnHMKAUv4wvD8R2hBYsRFQJQ97jWYdhxz0ow/CEG7tvdDwao8FzkP4PGT18Bijzw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cea8a54c-3a6a-4456-4784-08df1db28a42
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 22:47:57.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aQ4Wo7m7TqmuBUyTaLA2wRFJ9l+DE/2hfeNQWUgsmJrSl7iMqQhp+dLPVnWo0VHDil8s9cwiMmZD8YNokAK0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFD2F4A0090
X-OriginatorOrg: intel.com

On Mon, Sep 28, 2026 at 02:25:48PM -0700, Edgecombe, Rick P wrote:
> On Mon, 2026-09-28 at 14:25 -0700, Rick Edgecombe wrote:
> > > But even if the reported size is always page aligned, the driver would
> > > still need to slap the GHCI header in front of it, and that would make
> > > the total buffer size again not page aligned. So would it be useful in
> > > the end?
> > 
> > Ah right.
> 
> But that means the memset length is a real functional change?

In a way yes. Previously when the driver was just using the 128KB
constant, there was not a need to explicitly expose this header math. So
the 128KB implicity considered "header + actual quote". Now that's it's
an ABI, pushing this header math into the TDX module would mean less
flexibility in the future to use something other than the GHCI for
quoting.
