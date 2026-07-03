Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4128E318EDA;
	Fri,  3 Jul 2026 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067194; cv=fail; b=H5ep7GBEDuFgNxxhUc40ijB2H6E7MJqNXf6wMjlPXM8fwyrLu7cBPgT2i3g2ttnvOEH2wxZIBZ8vDzAHi8gnpsmbRrMgvpfwjOmLHDBWKNKXoDC7GU71L9ComRXw7WZoq0HhAzbqaYLUCj2b/A/uEb9GCak1usH1s/lQlWsZ0Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067194; c=relaxed/simple;
	bh=mOB++efWtG+m4oyHP4jviXtb2M1pxEcHMxCpiKyrLWA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m0Z8Wide3Qw0dOgzfR1pc104AkW+ZtXe1taYuRVB9MZWs/Z6qvkVD3asuq48Q1gYAPGmh6ZD5jWwx6dcM0FNHpPEPAb/ofVkAJthWCzQdJHhQuJbx33VS/wIPgWsW1Xwp/cPpMV5Vnonkfg2AjhZkLLy3Hp+NJLIfw5zbeZl4ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKF9FAGf; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKF9FAGf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783067193; x=1814603193;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mOB++efWtG+m4oyHP4jviXtb2M1pxEcHMxCpiKyrLWA=;
  b=dKF9FAGf4XdXnGSzzdtsTOIIT2JPCEo7Y/25TR2HarWzlSMnEMUmCfJm
   w0pAhA8+XeAtIE1RXn3nlDNQsulcoGi54vECtqHW/8JLnGuLvg/8Jf50k
   FJwGhVDqrpKZhGndWXYlWqyOLXhIe8u43AhEmwFju4dBlZEtoX4J4wFgy
   ZXD8XKPoMHG6cJyTvzG7uFTBfnYcmGoiM94/JgjUAGSYlRxDI1a7ZyywW
   YIgGH7kUDD5SpdEOBmxfjYnlKKp8Q+FwxheRklj+L26pSFHlTq46PAWkS
   8x1kIFPsLC6pdsKM0LtbWa0RzZM7bNgQrJjZXvMxspeoFY4ciJddVppc2
   w==;
X-CSE-ConnectionGUID: S0XMZdWuTZmB8Lg014NY8g==
X-CSE-MsgGUID: r/nWW4mBQYiEs/CpW2b6Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="94417654"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="94417654"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 01:26:33 -0700
X-CSE-ConnectionGUID: L9UN1gdSS4m4gRPMfbqhvQ==
X-CSE-MsgGUID: /OSr4K32TYO0kYM067kfYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="253717354"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 01:26:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 01:26:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 01:26:31 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.52)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 01:26:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOWGvRPOAXT5Z4SFu2JEaxlkJ8fPxQ6Q9cp+5tSXu79bYB0xja2ZNstJer7CKc1baGBajunGVBydJ5tz3iZ+CbADRsToRYqyCuyj6bjs+XpZ8kNq5yeuFT6azCHBTkmf621SIO8oK9bO4kc6ZssPXPuSQM1pYiSnNkbTOkGGs4H2RAiR/lIhjdiZVOBjbcCaIStMTpJ/ydd4pPfoBYxcVM/DMHz841wSDQH0rWNVSBrCfrRiGfOnsvMIE6fIuQpM96Q7PDTOmlup/3wQlBvOZg6cqXNR2AQYWdOIcR3gb+cOwrbwGyi3hG/clAXptKeUf5DTEjW1tbo+j7rXAxUZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOB++efWtG+m4oyHP4jviXtb2M1pxEcHMxCpiKyrLWA=;
 b=qfjdOCzQzkiHl1Q8K8MRRITTIDGxPGcDdJGWgjlx+nfQk04Y1Eewo8QVwjBaIyvAItQPShWaFYDN8UgiO5X2R53P+IulMGla+Bh3KkykYcUjX5kqI5BgtCfS9eoAKOlTp2FYNGZ6C+yVn6mBhGf/aSNKGLukLs6qzmb8QKt2wxoswlaLRYXt4RR1QBp6VN234pHFKTqXPBwBGjEfb/yZb7FcGNf5ijp1SrnN3X8ix+nO96NWOFAtCJAj3jyWQdypHm+Ctqmhq/FtrUgffSsbKXg/8pMtk3r4nCxHiSEYb/iOaAkldW1NcgqkqNC0Wnw7VIN4U/fyuz9kMNgk6T2ryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by PH8PR11MB8257.namprd11.prod.outlook.com (2603:10b6:510:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 08:26:24 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 08:26:23 +0000
Date: Fri, 3 Jul 2026 16:26:01 +0800
From: Chao Gao <chao.gao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <hpa@zytor.com>,
	<kas@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <yan.y.zhao@intel.com>, <kai.huang@intel.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v6 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Message-ID: <akdyGXZyt8uNfayV@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-3-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-3-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: SGAP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::23)
 To BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|PH8PR11MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd11c36-09a0-458d-d052-08ded8dcc417
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|4143699003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: l+mXfNg9KOs6+0T0W9Cy9CrAVRnGOlwD2tTRvBv4oXmVfUhH/0/eEb7FagR/QkQicH0/YclVyEwLzlogolgVvhIyPVg/js1gJIpJmJDfYCLBHqQL372dJGGlSYmURaMxJLvpLqKCD+p4jVvZIhqLCkuCEjG79O5pTGeaY4KrA4DhpXqlSjTc2Bp8Pa88F1p4AtQwHFbWa41d8Y/pmBEtyAjLLTQtQS6Ppxr2pydDcMbDW1rQfmAyLUh/OparxZQJa1teRtahSfbCfwyKf3Wk1aEa5lAjnlawim+Gf7PjkG5APBOdf4tmBisJNYexc10HHmV8x99vbcvLNQRpe0UQRoWb+DG+Sw5p1vRjDBMAC+2Mw7tkOD+O/5r7CBlbOHMlr1LxKhyji+QJomGDE7CDqXEwAdwZUwnVgZ1yCtEgLbyt0IhciIzqDR1nyxHD2ZQNayI69Eke+Cm7T83FXrcEtOQXVKD6Cukl5I+SswLRIt2nVswL9zFGSLeVmNb24exW4U6aJ9jx0SNyqOV5CPSL+wvMKnzCNICzYgx7tC5tDlZtlW8+pckksvHcv6ye4adYKzi6CPuQQ2B4bPxBl134OVTudkIc9vQcgoVEcrm7QPfWrnH3kvVRxoaqjCgiwTYpnoXc8wuHEM9kD0y706usBJe2P8rRVinE3vb+SORJpHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VELG8nzdwRSot44+jiKmvRotOF5P1JcdlUaaWOU0+/BJqYcpLbmuCTD7Lgxf?=
 =?us-ascii?Q?Tb1cHyqQfpuZbjZnon32FSH6Vq/YuM2UGOJq59qFUuFiWqHHuUjrxWsywWx5?=
 =?us-ascii?Q?FezuD8x9mLcKprHfENSBA+hfbzsj/8d4CaUlJvrzf1nCOa2pB/aIo9yOzdhH?=
 =?us-ascii?Q?e6+x3TEw8MyO7bkWEcJAK7SD3wkAzoPesEUvSrzcHB16RBcL7DR5WzRoTpb7?=
 =?us-ascii?Q?af39+2AyfGcnP8pXIQ18x3aq5goHmtDkxVEpytOd1CA0tE9kJz43STsHvqIG?=
 =?us-ascii?Q?OEdnoMXTBTobtA5uUVVglCUw90VwEiYQgUPuyXZA6l6f7CC7g6Lu9ckPAiw3?=
 =?us-ascii?Q?P5JD/rmRIkpJ8SJAaXTYE5yFSkQsiBW2eLpC3vMW5AF07jmxhgoVPaE67wh9?=
 =?us-ascii?Q?jz9VZY4LHliUfDdcH4ov8UDZ8lmSbisrvIayGRNh3EUG5ms/iA261OALbFUf?=
 =?us-ascii?Q?j6wbgxugDNy2EumGnwOtQMWJKi4fULprHl5AsgHbtPDLfPoGiu15BJkU+sPw?=
 =?us-ascii?Q?cfs68q+/7oMDccrAAjhNzBuMG2jimTRwR3jKuDEr882LuSzANfA4fhpy4316?=
 =?us-ascii?Q?WFg7THWrgtCuWdWtqozwzPhjdjsT/SgDW8vYQfV9y7+DUGf37Gbyq7s+Vmkx?=
 =?us-ascii?Q?C6+fHezIk2yNLtI2N4Amrxb7kzBQW4xuvcKVgJT1InrKgmKV1UbUYL8ffk6L?=
 =?us-ascii?Q?NUaXAsRCL1PoMPyn6A+giShkNBzi+BcjAKaM3k56D+s8Wf0WmtFDh22EpqL7?=
 =?us-ascii?Q?65qRckey+Wvf7VXURz0f6kLeddz7SzhOj99yN5Stvb2DVP/cvwYUqe0xPnFn?=
 =?us-ascii?Q?UKGa7ibSUw2tIZisDOvQWpMClpt5OGu2OK4d1SnfocYJX6DBB2LMc5xCteFZ?=
 =?us-ascii?Q?t0iO2EblDfzo0UH/meqS25eEsz/zkxpl3pFNBAGaEfi5cVuFlrNRG1eszdZH?=
 =?us-ascii?Q?JJGN4o0yt801FfMQxmzrBR776TG4Dp7+rN4eoIXXlP19qO3m7t5WqKmEwhLl?=
 =?us-ascii?Q?Dx7drC3Y/n/fldJkh/EwMdQXOnKP4jvSZ8dYloGUsN/r5dGZrb7F3HhqSsZ/?=
 =?us-ascii?Q?TFNvaT2sUlOZEQvfza2NwMVy+V8Rz2QEdrwRxyanC34l3QwI9DCRGuNNrpdJ?=
 =?us-ascii?Q?4373vC6WNiBehVaQKMa52jHafL+sS+FbZ9UYJ7ELvOrPf27hDHX1wvBaAxTL?=
 =?us-ascii?Q?5lax/vcFroXpeMZ5FKMiTfF1YZbgsH0LriBF8qhnconDNmFMi/pmb6Yj82r6?=
 =?us-ascii?Q?rNDhAAcl9vR2SSOHoab3bxn9idzzuf61KqslCp8bfbKJPDWmKqCsoYPj5yto?=
 =?us-ascii?Q?DIpTuMMZB3QXxkdCJaTFowFvvYDVCp26FS379imVJ3ZDo3SfhViScjZrSk8b?=
 =?us-ascii?Q?Kn8FK+rRb/d4bqc+a4pX97BDb43PprVNqyHqM5h574TAfd1np79dTZC9GSLT?=
 =?us-ascii?Q?9U7C3jJQv7EP54V3bigQa4N4nP3A6owTznFt54HErR8CaqR4PjsTA05KZUYk?=
 =?us-ascii?Q?4rdDEKksm15akR2KpnrzFCVuz/UFe6cOujfqxBkxlLJ4efzDzLYg4viQqfV1?=
 =?us-ascii?Q?BtZfdxFODy/caMqUtI0JAxtJGEFO1MQodL2X3aL4yxCM2TtEOOdpt1WQdNkr?=
 =?us-ascii?Q?PI0N894qi7XxWIFeHCJVqCtvFQj8ZweVrCmgTHJSWqjjfwlbS9VYWtoc8jrn?=
 =?us-ascii?Q?8wk2xy+LwI+cu4aX0SBUMJYrxqS4GqemkBgmTErZJDFeYADLEs7+62VZDm5x?=
 =?us-ascii?Q?7a5kA57F6Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: kwkl56I9oUTEirpOWntUFEWp1HRvuD1nNbVda8oscFok6ixmE8W3L8ruBUMKHSDaYbFWwtd0+NVhddwag4F+x+LbDgIihqpkJxhLCaugw8yGLTWcA+i22mkzFiYs+kWZXB3N83Drgn2CyefoaZPC6S4AdqrMe8Q2NPvoPCF+LGvtCGyXIlPWUlLrKpoZ5DVhbA27Rn4poG0/JeLdYQN5moJ8anqbbVCoaNAkNs54siWMH5H5NO/reRype7Xnfda6Qb28uVSc0PsphI1pRs20XsXaVyIBI8XsyoPEnY672nFvoPiGLZ8CG7TN80FsRHIrRCRvyltXZ5VnMXv45cK+Zg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd11c36-09a0-458d-d052-08ded8dcc417
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 08:26:23.5395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Quct1LTfTtflF9UTmGfI/r6D+pJY/cKJzO90wO1Y3mpHZE55bBWlxoIcvAGCGZ+lS/NujAvUF6268HNIGXmVXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8257
X-OriginatorOrg: intel.com

On Mon, May 25, 2026 at 07:35:06PM -0700, Rick Edgecombe wrote:
>From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
>The TDX Physical Address Metadata Table (PAMT) holds data about the
>physical memory used by TDX, and must be allocated by the kernel during
>TDX module initialization.
>
>The exact size of the required PAMT memory is determined by the TDX module
>and may vary between TDX module versions. Currently it is approximately
>0.4% of the system memory. This is a significant commitment, especially if
>it is not known upfront whether the machine will run any TDX guests.
>
>Each memory region that the TDX module might use needs three separate PAMT
>allocations. One for each supported page size (1GB, 2MB, 4KB). The
>TDX module supports a new feature designed to reduce PAMT overhead called
>Dynamic PAMT. At a high level, Dynamic PAMT still has the 1GB and 2MB
>levels allocated on TDX module initialization, but the 4KB level is
>allocated dynamically during runtime.
>
>However, in the details, Dynamic PAMT still needs some smaller per 4KB
>page scoped data (currently it is 1 bit per page). The TDX module exposes
>the number of bits as a separate piece of metadata than the 4KB static
>allocation for regular PAMT. Although the size is enumerated differently,
>it is handed to the TDX module in the same way the 4KB page size PAMT
>allocation is for regular, non-dynamic PAMT.
>
>Begin to implement Dynamic PAMT in the kernel by reading the bits-per-page
>needed for Dynamic PAMT. Calculate the size needed for the bitmap,
>and use it instead of the 4KB size determined for normal PAMT, in the case
>of Dynamic PAMT.
>
>Unlike the existing metadata reading code, this code is not generated by a
>script. So adjust the comment to be more generic. Also, start to adopt a
>more normal kernel code style without the tenary statements and if
>conditionals assignments that the auto generated code has.
>
>Assisted-by: Sashiko:claude-opus-4-6
>Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
>Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Chao Gao <chao.gao@intel.com>
