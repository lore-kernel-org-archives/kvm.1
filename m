Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C657F3BFE33;
	Tue,  7 Jul 2026 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407306; cv=fail; b=AVkhcbrnfKk/2HWQE+Zo4QpeT//OU2jfas+i7tSGEqHv0YQhJPT5d6vHQQVOZleHx4iPW/UXP7TwP3CKiPRXOx9axLbo7SBE0/MNpAV3XgKAkHfwbFyOWo66E3YT39D0CGDeByCso+ef8BFqIRaH0I42K9bSvnublE+0W/V+qFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407306; c=relaxed/simple;
	bh=VBIs8GKVPlqrvX1qARiu6NHl8Qa+CoGiPxPazAHZ/bc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TCxkuM/IplFOjlgoh2Ugkubpm+TcOh80ZSrjoNxdWS68EfraNPgQg3C5upWxhcMPqBCoQK5Pq34tug3SwdrE4cMjo2E7ELxKaxxwry+yetV0WW8n0M3/q+YkR5GoVt4I5evfSKAXiZ1Sc+LkqIm+N/6u55xOpSjBcp+uG0T1mYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1MLAASs; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1MLAASs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783407304; x=1814943304;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VBIs8GKVPlqrvX1qARiu6NHl8Qa+CoGiPxPazAHZ/bc=;
  b=a1MLAASsrzY5AkTzaBmhWqmHm3/COupDUCq4mGL9XpYZSeTSSjN7DQTW
   JVcN0oV/VxmARDj7B21DQD3SNBPpvfVrtwwGpvZUFxKgxQbL6WT1s3u+T
   ub3qKrbcqiSqDsv85YuhRdimYyCFJuZVxLXprXz8CfPzTlcclFvAgGJd5
   4o+55G+/q8enfdZTG1hinyolsHww1DCiUsPbbZ/IMtoqmD8WGxJnE+b7z
   1XX8bmjCnu31grxsUTamv+WD0iR+3jlXgrn8WNCpewTKFslGTApVFEdwC
   aEQHu84f4F4jWs3AaqbTsRkDPzQ6h39pa2WncqO/FWRNgL1uk59fiDRfR
   Q==;
X-CSE-ConnectionGUID: k8iq6tk+QDmbwi/jlnL36w==
X-CSE-MsgGUID: iN19/LOhSo+0hX2F/86ygg==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84071104"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84071104"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 23:55:03 -0700
X-CSE-ConnectionGUID: XvCy+CgqTCKRBQXhA5b7LA==
X-CSE-MsgGUID: jS28QfJVTXWfW1Ogmv4lwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="252845321"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 23:55:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 23:55:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 23:55:02 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 23:55:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcnK/r6kvHJVfxZVDL1rtfjrVLrfXtxAL9tkjoMhX2/q4n8+ECxGHTMRP1DEyQpNneIomuy4wcp+qWde4pibgINz1yp9k4YkB2rdX3RN0ptaFTQznSpSjcS0/bp6+EuSFH6UpTkxCkveIZ5sQNXqtmEnY5MDSTJGSw3DIja9lrtLjp+fK9x84X9zAUDstbEzBPgNaRO59gZjjGuNnM43e+UC1cFiez9IVHZ/S3W4rLEfRS5w16ilgLRKS4O08foY5CInzN0uwCgVsP/hYtXJ0+AiAonBNK+vd3COpfKlb494sz+hpOHdWFrlISsoHvAd1yMmQi2O7eVFAFZdsMX54g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBIs8GKVPlqrvX1qARiu6NHl8Qa+CoGiPxPazAHZ/bc=;
 b=gqvlYjZGlcsPH12aZKeodME+HGko57zel+J04sXe0qyDe1LdQedULWWXJBkGK+mh57kV/OI3PAIRcUUsKvGjF28POCikylnFG3wqzgWyV751pZgShyd/EVpb/zhj/3WJMQppkVz93/QF1p1OdNBwIuZZ9LebYAJKA+L5lqI5wLn/ozmyJF3fjB2wdDsC9e56tA/j6VVePYnYBh9eBs4U4Z5KTuAZrnYb6hRYMprIMritydgpZgGzYhhuLlMkVFHUNsVmwmS5B944lYuViZ5yMtwEeNU/6mKlVSAOsfON0/OWkE6+0K5kHfizaj1AUImeDEFAql8V8xLMH6glGeeIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by PH0PR11MB7660.namprd11.prod.outlook.com (2603:10b6:510:26f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 06:54:59 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 06:54:59 +0000
Date: Tue, 7 Jul 2026 14:54:48 +0800
From: Chao Gao <chao.gao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <hpa@zytor.com>,
	<kas@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <yan.y.zhao@intel.com>, <kai.huang@intel.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 07/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
Message-ID: <akyiuAfTSciZyGpB@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-8-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-8-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: TPYP295CA0057.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::8)
 To BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|PH0PR11MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a1864e-59d3-4e49-c886-08dedbf4a97c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: nVD5t5BG6C4yY3eRYD4Yq+ASEMSU+E77ww2Lpf1t83RlDS7MmwhkwTPM5XUJu3V24KrD86mjTyD1xcOq476m/FjNlf03Z3wecMJceYvhFEgnX6eWNcYHkcUeVu+m3ZpTK2W1lIzrP9ldR7cQgaeuiLMrViVduvY4lITpQnKDLPVa9en/CrV09W0OgvFNDNC8MCQBFmHxk+nlkdH9Ox00LJALC+cK6jmDWxe8gYs3fLhcKz8szvrE3Sq5y1EU90lwEzmkwpmZqMVoV56MBJNwpBa9FkOS+x3OJ9nGZzn3dWzpTSIctFA7TbEr6XxyXw6JUSlWORDmcj5PF8ooyPDTEW+9goOYjGZd6+V6EbIj3coHONXaHSNZqRjfXeeIk0fq9to3hM+19sT0qw7Ofb6d6OX9xO/m6IHQe8mbrnMLrXhFlvpck8zCCtGHlOVY6q9MHxZv8+885HCJzSzYP868S/zAd/QqybxOSvtYAk1j2M1slG8NbS5bQIF1nOBwGTjam9O2DXQ7HERqRxsSGi5yug6VCXE9RJGKV2e5Z4/FV9P0afdU5Dpc/vneTXD4kbMo0c+1M9A2n7CNeK3K/6IF/tLVLThVTackGr3nZjGvpakbvXdhpk3MYLqTXZWBi8/RsLnihXFm/uz5MzTg6dYLLq+Q/qQQAtIshjXyBkfjIXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gJQJpjJHrbcRGqLRKgbCHxXulN1Kqg2SUw4rOvoYLRfHcgOeLM53FgkRGFdl?=
 =?us-ascii?Q?q6PISyoTc4eYgSZtVSjQ/dPx08Ey0a/LgwJvVwWHtMy21c3+KpyuyVThz8jZ?=
 =?us-ascii?Q?Uz8EycJe2rvumTcGJvmlaE7+w5TzU9SL6MkaKJUlwTJcuieoIuRrybw8D+c0?=
 =?us-ascii?Q?VeD2NrYifTDx92EWg7bTEaG76MmtAg8PloFJ1VjjgEb/7Z4ImnnLeeqQ1LBJ?=
 =?us-ascii?Q?CReAZJfOPpiM0Xo5vHq6E/djVIOEyPP3q5bKSPpXLkTAP1Np1jXI+40iEiMd?=
 =?us-ascii?Q?1zD7S3wlbqZqnVIHHsSzHZc1BZ+MvgWfcWef7znh0CUm6qtKMe3G15adc5dX?=
 =?us-ascii?Q?iY1cbOfs0+CfNDJafRuA9aAzIAXhNQrI07diS4zILe4omdKtE226a+pkxvtN?=
 =?us-ascii?Q?4Gv45XthL2Qz50V1Z0NY7vbXFM6oQOPC1gNvkLYyMGq0G+h6/pP86IZrsIG8?=
 =?us-ascii?Q?4e/F6sdejEVJ5Erx6AhhPRXAO7KjfIP0UfgiyC+EiWN1n3Qe1PpEfZ3IQbqB?=
 =?us-ascii?Q?aTGjGJU4hiDeK3QjioX3tP5EGiSaZSbrzHY5j9Fz6Ok20v27jFbN3V+wkGWB?=
 =?us-ascii?Q?S0iKIRtOqORPntHtk2RHJCyzhLu8Dmvr6HN6QJpf871zlDsyBZ0zKLIRKuns?=
 =?us-ascii?Q?JACdeFVfJ+MlVVnwEoDGt0hgmJ1omW6cvriFrJa7Fi9B52LGZ5JSBzJEnfNk?=
 =?us-ascii?Q?bYfM9bKfk0Lu3W83qWw0FQfKitg7mKdIE6++CzxRV8n2GEnZyCohQjDQ8Tdk?=
 =?us-ascii?Q?A/axOOlVXNOVIES+vRrMZ+X+u9rCa/o2N1dPNXT5VzZdw1mxGE9CxUDZdfzy?=
 =?us-ascii?Q?saafqH/GaGVkZQu0s+QeC409tROh5VfzAkaczpyOw3DSrKSzv9v+6ucbnZea?=
 =?us-ascii?Q?HI+2guNdfNtODNlPwDpZHCkrxyXTrQPzuw8CY0s9tDJ+V8fM8aAtnm+IIRy1?=
 =?us-ascii?Q?IlrETVCTUQLzg68i5cIeCsfjOe6Ze79ws+C6bvbtvAc4NNC01+6247qkemBC?=
 =?us-ascii?Q?gg1jl7vbNqUdL0P8eerLXuO1Ez7oCh0TjIq/oCMLiBbXmGpg8hkqcgv0bnen?=
 =?us-ascii?Q?/tm9ihlERJGEh2P+xBhGyyEidK+4qqMz9PP3uQw++cwdbh017+qAsJQNsUfO?=
 =?us-ascii?Q?nebskzbZXkv+3lgPAZ7h0KdKdY2BVdr+gnSdYeNND+2B4VYEcHVZz1oXmaFu?=
 =?us-ascii?Q?1ubM/ZtfZgR2swTNcfcC5LXYv/gf3vCbHiocKIl5hby/RzWVmBbHXJFwFV5f?=
 =?us-ascii?Q?axmDz1/Y8n7EHT22t0qNJsASy+nJep5jliAWcAjMccNZy7TeyJqofUuCn5Ls?=
 =?us-ascii?Q?aZjlXgG4ZzUpYGm7z/5/VsYWvW6gV9k3H5pyQC+8esuBuabsPnvgAVNg5B9B?=
 =?us-ascii?Q?S3+TaMA2ozEh9pTAvitNjohh1mvC0glcouEqLNVibWPbTO3qk3JJFus4YtWE?=
 =?us-ascii?Q?tiSCzO/SZjGBoxZNz+DdRTR78kYKhztspCeBq0wTbdhm+8HGzo/dm3biX43y?=
 =?us-ascii?Q?FLvaKOQo1QPov0O6xDFZP4edajIGbS8YzZe5bdOVlwspZ0hyFH+G6LzPwHrc?=
 =?us-ascii?Q?Y3oG8uMTQel60NXmYANkGDLULrqkS29Nqc0TS28ylwqd2JrznnvmLD0rvJQS?=
 =?us-ascii?Q?OXzXmgPC1/bAaXZP0cdrE45hvDeJrMTljL9DXVtRk8FwTp3OYb7gpNNHYJ9L?=
 =?us-ascii?Q?Cowkq7vI9l5IeqslCPX3noeP+CdvRJoKHJZXIKNUZ+fKbLQLOJSsPGmutqI2?=
 =?us-ascii?Q?vxdbEQBrXQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: SFsN3VMtDrawT8SI8Pr0OUPnXqv9fu0Fn8TSwaOTXvN9ua0M0+Nfk35bJiOGos2tRwHRhxJJhRCx3uT6uRPNknmaiI+LVSOsnfecxVC15VByD+QDwjLjpERyZoVl42AR5M6/YLqdN74OElOrXK4s19o/ESt2K8zIfV+RGjz8Matv5G8WFvGPZPobUloeLm4dg7XdFr3lQq4n5DmB9l+7FRk+80N/7UgZoTEXOwapaJU+8R4k67DSA8d00Q9MmOTgubLIcsQtj3YN1s+ROsCwdbIPG4pZ/wJq/SeaVkVK+SziI38+4qu0hiVLP6hnjFJ1AaHmtg7PkuuKXOT2ICVg9w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a1864e-59d3-4e49-c886-08dedbf4a97c
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 06:54:59.8563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zLjSPHDJjzSPXlOTF1ZkcQ02BbkyRFAZfHXh8wolQr+XyIKD6C7bUs6BYM2jtTc/NIeto/rLPz2FHXUypLp0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7660
X-OriginatorOrg: intel.com

On Mon, May 25, 2026 at 07:35:11PM -0700, Rick Edgecombe wrote:
>From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
>Use control page helpers for allocating and freeing TD control structures,
>such these operations can work for Dynamic PAMT.
>
>The TDX module tracks some state for each page of physical memory that it
>might use. It calls this state the PAMT. It includes separate state for
>each page size a physical page could be utilized at within the TDX module
>(1GB, 2MB, 4KB). In Dynamic PAMT, only the 4KB page size state is
>allocated dynamically. So the kernel must install PAMT backing for each 4KB
>page before gifting it to the TDX module, and tear it down after the page
>is reclaimed.
>
>TD-scoped control pages (TDR, TDCS) and vCPU-scoped control pages (TDVPR,
>TDCX) are all handed to the TDX module at 4KB page size and are therefore
>subject to this requirement. Replace the raw alloc_page()/__free_page()
>calls for these pages with tdx_alloc/free_control_page().
>
>Switching between special Dynamic PAMT operations or normal page
>alloc/free operations is handled internally in
>tdx_alloc/free_control_page(). So don't check for Dynamic PAMT around these
>calls. Just call them unconditionally. Similarly, drop the NULL checks
>before freeing, as tdx_free_control_page() handles NULL internally.
>
>No functional change intended when Dynamic PAMT is not in use.
>
>Assisted-by: GitHub Copilot:claude-opus-4-6 Claude:claude-opus-4-7
>Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>[sean: handle alloc+free+reclaim in one patch]
>Co-developed-by: Sean Christopherson <seanjc@google.com>
>Signed-off-by: Sean Christopherson <seanjc@google.com>
>[Rick: enhance log]
>Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Chao Gao <chao.gao@intel.com>
