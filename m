Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41424448D0C
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203846; cv=fail; b=Zuy44dEbm5dNZA27MFVPEY1V0YFYNUX15zC/RNEbdee/vaRjFPQBhNvOZf2i9lTRO/tnXcsI2ycoBVVOeMrw8UxuFSIcgwWePqht+lVi3+suXReELZHjHxMyjZ7GINPCRnrO62e2XHwhgsw8k6Kls1YvrEB3bzcvH00wzm7997Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203846; c=relaxed/simple;
	bh=/Zi4SYLntelQA0B5hl+U1WpYI/+8/DAbfwNMd7K9uKs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NSq6iV26yWRQOTSHhA6OFO0EdJG0yXydEdUBP/cABswnUsF8dFg6+dniZnCQAw4L/v+JkAJclFnZpSfV3CeAvyLlsLcBuUp471NW00SnSbSDOvz6tvwBiJvHafc0E6yNAepofnFJn9vz//elLxFZL6V43DKRVjuSJImKJrk0MLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAkJDF9v; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAkJDF9v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790203844; x=1821739844;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/Zi4SYLntelQA0B5hl+U1WpYI/+8/DAbfwNMd7K9uKs=;
  b=jAkJDF9vYKAd3sYroFne+p+a5uvHQbfGYfOpUKgWLe/I1csQwIvh0lp2
   366Eajp9FIiSAXwuGfBQLJWZYcl3Ypa2yAC+34IUpXT7fNq3enk/xS6w1
   UUvWDtwQ3RQMioqjQJc0j8unO6eEBf1G1RXSDoTRW/LQF2Gw/aDYQQP9Z
   3rpIlW9XYbhYX6o0XkPIj+bC3FuMRiw+ggnCqnUsevDx9yFS3tM97JU7l
   yry8+RSb9JP6AUuXrVyBISvy7TPYG8a+IWs+tJb2kAbm9RQaDlfbtJp8y
   XtH1jw2YnzJY3wcTE4aVyzGUSRdiO582BKpQs9p39chlbitsMJK85AO7Q
   A==;
X-CSE-ConnectionGUID: S+pq1ixOStqQetgzQZtMsw==
X-CSE-MsgGUID: +GJYdLmJTPiRjROsCmkZQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="102311781"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="102311781"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 15:50:40 -0700
X-CSE-ConnectionGUID: COf6DWEgTT2JaOOcW20QjA==
X-CSE-MsgGUID: BvVODqCHToOCN/8PSqVXjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="301763072"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 15:50:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 15:50:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 15:50:35 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 15:50:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSDsLS+Jlpqvnt+agMV6aC6ND/VUFymFqCg0sScagKJtsH1luNJcbXPUg0u2Aj6uCSLt+FZ9w+PXH0PHZn5hWsQIW3pqXQmpNQFQwgQINhZ0SB8iQfI6JbtS9as8zBEkBC1tMJVM2oMmrXu87nuY37gYl+sAEtic6jN0RNTPvuSghRHC0FCh1aIcZQzUq7Oagx5rrG3pR+8buSZbsnf/7QcvA6MMXIzfq1//e8wdc37bho0j1l5pfYC+U7sdBHyUGIhLnTgCWARGtbpp8XfgGHwQ5Z/g9yHIwpB0ubrtNL4P1YwS9V2U8Sd9NiDounMJzVc8ZmgSeooZA6YzeAPNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+q7q4S7VZ1tWHCwWwZBwwdTruOaCn1hcdVN8hgPR0Y=;
 b=V3Qh3Jt/3BXGAGyCNrED45kLzctACrSRWH2ElkAjdAP4vwsDxP9DgO6GuwNjsgCHnuu7qCAXIAa0E0nFqzHplWJVS/YTTnbEANkVtUIv1zamBX6RmKHkp3JdIv2tqJjGXh9QH6B9lcM61T1BA1kMASc/F+45Tci/FNP5RLOj7/8Choa+NDbQ2AaUcfVgT1RLGwaLCvkWJxgz8grI0mfPUaQqkWeT3YMZoxSuHWJ343lDSkIwAf/OdsHG8HFHKDkGvQ2IQXFj9yx3idNUaRfSR59YrQJF2JXIppRTe6omLCdUbyCdNHl63IMhy+Nwg7A7w9vSJekZoZUE/YEKjkyhXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by CY8PR11MB7946.namprd11.prod.outlook.com
 (2603:10b6:930:7e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 22:50:23 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 22:50:23 +0000
Date: Wed, 23 Sep 2026 15:50:18 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "kas@kernel.org"
	<kas@kernel.org>, "Wu, Binbin" <binbin.wu@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Subject: Re: TDG quote analysis
Message-ID: <arRXqpG_4hCrhQLM@intel.com>
References: <7d40bcd97e01390a345ce1dbe26264e7b064a619.camel@intel.com>
 <aq2t5wJGLtsltMza@google.com>
 <de659c43-4121-483b-acbd-e1c4f89e4e80@intel.com>
 <arG7delLjerkKbYQ@google.com>
 <2df88806-4583-4bf8-b699-43eb6217399b@intel.com>
 <arHB1SACk4Z9kJq3@google.com>
 <07297a47-9dc8-4e46-bb5f-fb228ba6447f@intel.com>
 <DS4PPFA84FA90FC58F88D79B0EF19B34596E7832@DS4PPFA84FA90FC.namprd11.prod.outlook.com>
 <ede520b24753e086dcfe73f11bb93cca7b6e5ad7.camel@intel.com>
 <DS4PPFA84FA90FC61E43D50956C3226AA02E7822@DS4PPFA84FA90FC.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DS4PPFA84FA90FC61E43D50956C3226AA02E7822@DS4PPFA84FA90FC.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|CY8PR11MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 1679104b-3d74-409e-7c41-08df19c50d65
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: pKlFkkXx2hx7HftAP7yLt0DvsHDVScHpVSbxVeEYfyeaM7bbfVKEEwXriiekAeOKXZN9CKGfuX9oRNAT0OR6Rymv871fMXrL8oJQPTDo4W9987i2srDGMpziD3Ve68xrcZAV7BgRJYSjvZX0Wwrwi7nLXeyc3784GRXX+NEfNsLSxFl6CUZahIq4w9WmA1/FvdYNmXjXsTx0e5Hh+2RZWeZyklBYRShwYwpY4EpEKMNYoG4qTDhR/6Sl0ucQ81xGi2VEdEfPb0jPTrol8UaTYm6cAgm/BRZ1Z2ZDpLOzwBxBR2QcM6EWNBgktowvhjL6ajzfp4RoeDN3gx1QwCdvJSN5bYzdFnsiuRL6x7akuCVywIn0Goem92ITkE3uMQGmQp6T1UpC+rsBBhpZb/RO/Y6ymvGII5pXTM3gu3Ut5nh8JYL+2doTFJ3c0v2suub2dtisFHl5pTr2NqrDBSRqLZxmuur+Tqxn9TipCgr+FBPWDtYDjXFXQBVAAsdWNFVYY0NON54RAcXpnipRm6EUXcqswRBHtwsUmYRgyBag3e6OHfFbPFi3ah6lV2Z2psbX5TPB53TsQTw3gBVPB87n5Qi6lLoHU4F45UkwHSDZbeaYISTFw1YkoI2hj7FUb9B4Ll+3SJ9wBMrWFTuanG9aqVA01kyx/fyX6rBdNHWDRGI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GxuL4y21AfsrJhSTz8tSZfodvQmk4ekF7iPWCtDyphh8ziMmynMb9I/dvZvd?=
 =?us-ascii?Q?trStUdo356mT/6unwPr3/gSwQIm6dzhhKuGsP5Luy0nbh7dmmwECV8gRoiQ2?=
 =?us-ascii?Q?Ouh/e/GfqPwIcfdZU98DPcOG8seRM0IwqmsP6+uJ8wAi0wPeqbNKZaqwMFl4?=
 =?us-ascii?Q?1UKMpDOTQlwPOr++cMWzPJOL4IT3MbTikKYBu42kOLnr0UsH13/Zo5sYB4dH?=
 =?us-ascii?Q?pUIftygOwQxOLAK3hoVfAMpvyqiXhxsd4dJ13llZcyFGE6jZMGFHX4y7TA5N?=
 =?us-ascii?Q?qaPjplYFCLKuECp8ZhZY0CelZtYJ6V43lmFm0VJ8wkQndSw3GLdZUzaBk9Z8?=
 =?us-ascii?Q?3kwTKcA7A7VvOxPfpMzQ+Ef4zHmPQwnKG4RfcFlZ6kAQ70seZGd53X4eZ0SH?=
 =?us-ascii?Q?iGe1idXlGb8p9Nry1TX8GAK51761y2k9+wJNpMfk0H5LXMsclSvbjX7cpzQI?=
 =?us-ascii?Q?btygjvc6liFJArl8EzhHmQCjBy/CByGIKkK9Y6VmIREwePN7Clrq6KEMWlz1?=
 =?us-ascii?Q?hOeN/IzOjl5eeT0Lt4iQdbS00hOUTsFq6cji/YSh8+m7S2efe52UrnaigrfM?=
 =?us-ascii?Q?NlCdu7WgGDHkCOfcBisdhV/RXoC2m5jHHGFoHPBvNgjjJFMQDCufvDVYB0Zt?=
 =?us-ascii?Q?DhiIBCQcgDJUU3Zqcxwk8KKjPgL+1RZUWI1xCe6lEfHILEsM0z+1a0u74npp?=
 =?us-ascii?Q?uttdcrHe0DhU44mIVcNFTLd6m4NCRXL6VOvAm6J+2iJNid0x+EJkBYcI3GQZ?=
 =?us-ascii?Q?MZHstJZpeSfLd4D8tOtUL6JjOevJwT4wHkMILOVrdiM6yfB/I7c/GxKRP5MK?=
 =?us-ascii?Q?vfbsdRknuhDcb3cD+/3+iT42bpxCeDoVvoXNL/cjt6gkXct4ZscuKpmTMVZh?=
 =?us-ascii?Q?eECMSyx3jcm9kgmx/lHeAyAZPD7ohRHnFtTCBNbt/zKrY4F2Tb87ulEuYYUE?=
 =?us-ascii?Q?G1ZEVgUh8Zk5Y1xurAN+7075DbuHJ3mLvqpHjayDpz7CosezlOTPkSrhHMZ6?=
 =?us-ascii?Q?FF/kGejDEovhvNf2wJLkPmoSiphQKNC40e2Co6dRKJ05CAT6bnFyAywv+ZCV?=
 =?us-ascii?Q?743uAZOKda3/5tY+ja/6XM52Q7bPUfR8x4lpWjDRB58BTC0SmuDJdAHoO+Vr?=
 =?us-ascii?Q?rAEQp8epGpN79AQY4zBeOi0ClgRvWAC3UapdOy8biw/t3R9z4CSriKPXgF/U?=
 =?us-ascii?Q?SP1rcSOyhMXwlVTaPMn6K1olHJCVQWDOA9X9BTz/v74vzkLVZRyNDp403E9M?=
 =?us-ascii?Q?E+Le3X70kJWW3/vIYfWuOZX52OR6Ox6o5HPBXcPUCKUrGT2Gf6S53GYK1v0x?=
 =?us-ascii?Q?zwwAIJlKXwqEuuzlEayKobr7bOX7gJwl92muDeCQIipyRha0vaxkrXu2UFxv?=
 =?us-ascii?Q?leSnBRsbMutSjVptpDvCLfOgMVcwhx4bFftuIrzsL5FUrbwNj7qCGLkwa6ps?=
 =?us-ascii?Q?ufNeh0NiLMQCQIMFcv1I/HVlmTKs+JclcJ3IOOuDtVHXPQPclvXh86H5vJrd?=
 =?us-ascii?Q?gSLotqxF1TJCXMn7nBMKgScPFzMe+AZQFvUwScfPpD/9vYlywXW3wSIH7H/I?=
 =?us-ascii?Q?JOK3Vp5GbNYe8rc6SnAHIsuRBVcbnMQoN1S04r1/dW0DpVrX6EgcIzl9VmiG?=
 =?us-ascii?Q?dq4V4Yvz7b2gu79QudxfOIJKRBzxiCOqT96z/b8CEtEPCslNBF7C+OSlT5+j?=
 =?us-ascii?Q?lNm1A/Tmht0E6FB6cWHeJFmVaTCe+MW5qsNpMw9wx9soVihFPLNVT/YT1vbc?=
 =?us-ascii?Q?jEijH/v6Yg=3D=3D?=
X-Exchange-RoutingPolicyChecked: lkgV3fj5tNmjumiWEpTvPEI8uquvxzBJd4Xxmm2WSdpf/1z5+Rg8e/5uMAaZeJnvGcCPRQ5fgKjXntIK13D2UDEByHd6z/TvXNyBsOUEoZlPbVWpZ4i3hnsq3D1NcxwsiQtMJ+wXi8V256n/6kV6hzmuNdyoTjOGtcoHrZFKfHoP1q4P5JR9r3Tf8IAIPrIC1YNlCUUsutxEI4XNkjBc7nVrCyWEVqLkjWu3QZ3LbRkfClxVnbzULC1Okl7Ea6x+lo7v/R3gDSBDTaiJhPFmgJMfhnJxgPTxwYGSC2NQokVfUAW5p+e8WEQcyjaDY4n4S1nVb8xSqpoKC9TCaIbh8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1679104b-3d74-409e-7c41-08df19c50d65
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 22:50:23.4956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQRRqGO2/FjWFPcX6nMVorJ5aqaCUf8GeIdelfWMb96cmaq1cxZ3sj53X/4GWMiBTAguZtF/4Lf30EhZXFqhoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7946
X-OriginatorOrg: intel.com

On Wed, Sep 23, 2026 at 01:50:17AM -0700, Reshetova, Elena wrote:
> 
> > On Tue, 2026-09-22 at 06:48 +0000, Reshetova, Elena wrote:
> > > Hope this clarifies how to calculate memory impact.
> > 
> > Sean is suggesting to have some save state area per-TD such that each TD can
> > get
> > a quote without interfering with the other. I think this is saying inside TDX
> > module you need a "vCPU" and a "session", at which point you can execute
> > independently from the other quotes. Together that would take:
> > 

A recap of the PUCK meeting discussion today:

1. The TDG quoting idea would make things simpler for the host, but at
   the cost of chunking up and disturbing crypto primitives. So in the
   end we all agreed to keep the original TDH direction.
2. Use concurrent TDH quoting threads (number of physical cores).
3. Punt on the S3M-based quoting for now.
4. Use the existing mechanisms (polling or async notification) to handle
   quoting completion.

Please feel free to correct or add to this. Thanks all for the feedback!
