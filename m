Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E3337C902;
	Thu, 12 Mar 2026 02:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282952; cv=fail; b=otW+lbvZkoYYwo5n1hicFqzaeFkkGxTc0u5GAnWuxsNxAkJOd6pyRll1km+4rCX+y6CFo9ziy6LVSx5YGAPkPUET6t2TYtFa/ma13a49cHmHTTdaywXQh4gCCY274zRc8j9REOYbfQB/76QjsQL9su/1lPIoJmPDC21UAltyBhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282952; c=relaxed/simple;
	bh=aHA6SBWX0Un2hNwnOI6RR4zi8LMc2RQnvQKvMKm4JvQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kv5YoOL8uxcMUpybV1NiUtt3UKAoETgsbFdygyP6mW+pcc6XaZMZRiU1LYuJTluasOBllwAo1VuJDXc7bo7UZQjIZYu/JUWHj3pUJUgV8tpEGQ3hRSJDSHwdpIqaXr4GUz4Dq65YlRVoZUWRidelD9Q7FAEtHr3/Uu/+E7lZ/UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OIBfqlVa; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OIBfqlVa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773282950; x=1804818950;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=aHA6SBWX0Un2hNwnOI6RR4zi8LMc2RQnvQKvMKm4JvQ=;
  b=OIBfqlVa9WkXLvqOSsRjn1J3w0oRkD4vmOYhrkw3/60Ux3h3J+uqiTxv
   ADzzQoBiBETkWgCEJSifwNv/Vi8JqAfm7SEepZKklpkBZ8HlBGVaHqp+p
   Z18aUWyPlABuzEkCuLDmohbKNc1LUad4yv0Ivtbgma5y4RtxkyevvYF2G
   7LgpdSkgYb/2x9rEV4PpiONsNhSnQDA+nwkXu7x8ze59CXLAQY8d+/4Za
   D2YVBfq16rkp6Cg3J6xGU8Kjp42bGm1Zyv2g716x9KRyj8TwHSeKA4vtP
   zMkpeb8MN4MHLprzngWSeLAkj+6mOeTD0QNEL2soX+S9Yt86swDFaTyFM
   A==;
X-CSE-ConnectionGUID: zjRdmw7uTTmnb5MecTHcTA==
X-CSE-MsgGUID: 2AYsG82GTNaarPBHycypoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74407674"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="74407674"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:35:50 -0700
X-CSE-ConnectionGUID: SzXY8egvSSqDp+F13hTuWg==
X-CSE-MsgGUID: yd3G/sZkRPqJG1cuQrMFGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="219939104"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:35:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 19:35:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 19:35:49 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 19:35:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZfHn8oCDAOubh0KcCyttzKrCqdxamNjJMiPEQqC02FFckVv9O33m6VZRAP2ZbBS9gSgKBq66ZexJJfOSixDWKnSMYzZCzizTTH1t2a2cv+A3bMBhRKRh/g9fQfbIqzLP6PmDleNIwk8H6kz3MKhO48qS9Ig3oA+aRVlw7uO62bECVoeROVd6z0f3Pb2scTx+viCL893uZsuCdIhFH7yXekhl0xnWgkm9BQ8MHMJGIV+S0ojZvTBhGCxFHRBPcIOw1WcirntX8GM9ye47vpcLQ1PMbg/RXgOQMb8COY9gewLtzfJBYUMywWaSBeT36mCJTq596jv54gCWqrTPNseLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZPp5TeXFGZQ5BXLjq2yQ3VjpkDs7j0P2bw6KISlcGc=;
 b=dbp/182cm0ZLqMOeeK5ogNcTSMdO3PdcFldjcCVuCNdNzUkCG8k2CL/X/rfEx2nYExhdyE7rX2l4zzUBptojtEWuSXMoYGqycyl4eSJMRav720d8oFGSi/fjuCGE0sF9pgugKe7zy5TyIfUFku6Qyy9lhwoNpVdM7KD5QSYm1wEwIDavZ0Z4VJzmV7jo7nQMGJGWdzezze5XL0GAHcZShQA7gBRMOqL/XXU8axp8viD6FomKB+Oq7NQG0d7Uca6Wu8nKXiZU6yc+kCv7F/qkP4+sPtBQhSa5LInC4//n5aTo3dz7rnpr/6Vd/Yfg+SxnQl4cTOoI4uVnlOWLlC5z8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by IA1PR11MB7342.namprd11.prod.outlook.com (2603:10b6:208:425::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 02:35:40 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 02:35:40 +0000
Date: Thu, 12 Mar 2026 10:32:15 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Chao Gao <chao.gao@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <reinette.chatre@intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <dan.j.williams@intel.com>,
	<yilun.xu@linux.intel.com>, <sagis@google.com>, <vannapurve@google.com>,
	<paulmck@kernel.org>, <nik.borisov@suse.com>, <zhenzhong.duan@intel.com>,
	<seanjc@google.com>, <rick.p.edgecombe@intel.com>, <kas@kernel.org>,
	<dave.hansen@linux.intel.com>, <vishal.l.verma@intel.com>,
	<binbin.wu@linux.intel.com>, <tony.lindgren@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 10/24] x86/virt/seamldr: Allocate and populate a
 module update request
Message-ID: <abIlr/gnH/Emc/9X@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
 <20260212143606.534586-11-chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260212143606.534586-11-chao.gao@intel.com>
X-ClientProxiedBy: SG2PR02CA0109.apcprd02.prod.outlook.com
 (2603:1096:4:92::25) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|IA1PR11MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0e4a8a-a6cf-47fe-9b6e-08de7fe00cf3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: eb6e8YkfSXipVsEBUz+VWkwMOb1pEiHox3DV5h0+eBaSVeRLA/OjBJtAnQTthtjy7gaiK/sga+EgII5+qzEDj9nTa/av5jQA3U7YCaRDRXs+OdttJP4RQzOpk9nZr2oOvTPMCgt3UiJuIlmP7aIq2SAnxHfqDdmQE2+rIEq6Wtbh8dkaAgb08tX7/S5hJaZlVx4yNLndEla7wyoXl0Jmgm2ZYmqI4vSPMJgotRcAmWmFMyr4X7mR3yrrpoEUEPlrR45mRikLTce5PGWXm6HHVhtQjuoYU6lbUn6EOEmG+UL4OJlkZccmJZXiYTzyOkLPwqZBuVB4r8tCbMQ0J6w7DysVH8pgp8jf3EQu06ENMoHAI0G3rfezlxxkqJgQRmLjx+BNBAudiVtKbWMg94y06V5hSO50d+1PTVI9yxQ/SXPMiiuVby16mwD3xZFjrE5hzzm5oj2fxwGiV+XJJtVHbVDLweqfMDPDSYXrJutMfCBQy0R2RinHhqXOYHgnuev2sfqoh6icPqHGTC+hNy15jqK9gcm7uk+bSlgjLE/cKKqXI+H5cboYYS74tlQ/XLNOSHczC/UPOoFU+n0ZwqV+OuJxCzTcRiII5A+hUEk1W5nS+iDaZ1RR7mO8RdF6K5NCoQEcHZGVn618jZGQI34yY3TY0dx3J4lulyFTyYE+v6PvU29ilNwv5gsuom3bUA5oLLlB8iCqeXk0Xn+SyKljow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OD87Rn2mLzjbohGokQhh4kM9W3+bJ6zYN1BQ2L72F7kd0QAzC+nsNQ+pxALO?=
 =?us-ascii?Q?I/hGodz2np7PtVeABhoCMo3ugzuWMIftsY+uwPt1dAJHSLB9v1KbCUTsXvj6?=
 =?us-ascii?Q?Y3Rr28sPd07xQkDwaTguB0GnJO9k3hrQexaO0KNLw3Lo1FLrxkNvJLkLlfk1?=
 =?us-ascii?Q?RbeDxMxJiNWo9TpwaN45h1on5peVJl+ykJJskw72ViZqcCygcK+XFu7NiC9H?=
 =?us-ascii?Q?o+Q26B/G77jdQoQuyWwqLSf8pzAhBGcIRn/Uj1marBbsWAf5+Kcm6qyYuuj8?=
 =?us-ascii?Q?SSxzVRFbklFCVbmB2wPzZ8AAD9sQmCSwLv0gc64Pq9x3bLb0X6+g5pHGfa4Z?=
 =?us-ascii?Q?EDX/tQyb2JEyaZ0S/WGGAwGgeuXKYe7WBnHYGqtkPpYITOK+yWWa0t+E9efr?=
 =?us-ascii?Q?byVR/EEy+udEPjzZWrcbjji95Wv4+eB/9RHHmL1H3Z+9oXivjO3/pRjCwe+a?=
 =?us-ascii?Q?7WjlU8FZwXT+Du+KVKgpDNX01pInsqUGP2CXNh4JPiVKoCQZGw7byZzFOqU8?=
 =?us-ascii?Q?IeIJTF8NmCVq0Mg3MQErZ21c8jqi9eozCMDCtqEVU8KfAkmIygF/EGNisMIw?=
 =?us-ascii?Q?azK9ThMa1pNyOyKqFIguokSuFkbcfQ4GfDJMurlVgYgsqk0GLVb7xpg8l/kE?=
 =?us-ascii?Q?nf4wb8XHcGVWuQoywR9r+/C5uTFs61fimg87IPEunHDFoFLMP8kdA5he4cHN?=
 =?us-ascii?Q?W5jD6qnBwNiUQ0RqYmH+YS6OBcy8aYRTTyAE1FfNRLQPPS3soN1nuwZzBqrT?=
 =?us-ascii?Q?/fEPJzRq6bcHEgPCvOrt+uY4uE+DYgJvZBvYLtnRgg7YVxIhSHvBWbx9zzPO?=
 =?us-ascii?Q?nFvYJ6CgDmbrpkz0qdpcysBQBg/XH5mW7EYxo9ajZacve3rLJPw4DY2pxkee?=
 =?us-ascii?Q?sNIFOntgVey34dFj6MJoUuDfMcS0pESea/gd3A7h1dQ9nTkU1CM6ZtIwHzGS?=
 =?us-ascii?Q?9bxMCoq4hdcix16cAdTkv7nfrBejvX2RsUPXWl3AmVO5hasce7eH+1la3vIf?=
 =?us-ascii?Q?UuoRgNRT0NMVGoNOnUkQdYIQHZy2qzfg9kRYItTvMU3hE95vAs+weolGTSWo?=
 =?us-ascii?Q?JA4tfzCJvlsJ7TMSxacSLeL9fddfJYk/X6cSYKSWV26goKqTI0NPJcWNlNuv?=
 =?us-ascii?Q?FEGHi46cgG2bMLK0Z7BzSZXCs7/DqZNtjJhO7S8tB8NtrzJy+NHzwMaoDWmg?=
 =?us-ascii?Q?OIvE0UrDJZ5x2IN3vTxaWKs60rIOgoXVJOx4L21LnFwYbsLusD15NjPFm9g2?=
 =?us-ascii?Q?AV5EmvvOzfY4vhtfuba5cz1JH71A9TUXjxTPkT/P7FvmmI/stY/sO+g5uX93?=
 =?us-ascii?Q?A9MYl/h8aI4/ivqqkeCELyY3Zug3t2wCbIXlskemm3LzMA9Mm9eEAF9iTD3I?=
 =?us-ascii?Q?8XV1pymV/KIq55TMhlNR/Sh7zSGpm/QeZMYKyXflX/V0uMA0dzjDoQSiB57r?=
 =?us-ascii?Q?h+o5bHu+XmCUr28N6gXtaHUkfjBj9gJhThQ/CEYz/B7EvYsowrZK1WJTOlm+?=
 =?us-ascii?Q?gFZChag760KMcDuzbmk9qyb0LdVE0Mu/5QVZZtADMfdIv3Isuk7MtoMK2iCE?=
 =?us-ascii?Q?ECt4KR/JwiUOhmBnFA50a6/mdt03XGL7efAGLcQZprP8Im8/as5Ii2xdzPJn?=
 =?us-ascii?Q?gtZFOWRfXknph53e4X8P0c5CqVxO7wO5NTg5HkQK9cLQAhcUBA8iGvtd+p7y?=
 =?us-ascii?Q?2dwexGGXAg8SBxJqJd0I0p67u4Rc3Y1axxb9sXy7+OPsiFUG0d7pSUK0e++Y?=
 =?us-ascii?Q?gabOgMH8KA=3D=3D?=
X-Exchange-RoutingPolicyChecked: gAE8sGII+M9fzzgJ9list/NiNYmIycDlNhwyut980OZ8G00MfOro5uSHnKeakHdNmEwneP3hi11X5gvKhU+UZqSIMsFDSlgs+6WEKxshxnbwjoFbwvzjzuMmSOcrmad+nbjJo9kAgf2ErFWtajvaiHdae0sFWZKXFZWo4G/5Tp4nn4lTwtZqKeRp4jWdwwG78yd6Mo+Y8RNCFiugUr+VBsBKUSydx0DHO896DiTXyNHbLCjIhMUqphYKvsF19GGAG1hKqMz8ZRhgHzSZ3WXgGpqnZW5N4PE2X7lYZkPI/A3Ag2DqkHbeSz1WH0lOkjNFfs6K0OwFzmxgvK6umNATAQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0e4a8a-a6cf-47fe-9b6e-08de7fe00cf3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 02:35:40.2455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2etQF0rvHp3fOuxRzqc+vwVy758h81rJvTm2TdUYPF4elAbhvzikYmArrAyDIHF1K8Ktfi7lIi8Jcv9lAOWhlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7342
X-OriginatorOrg: intel.com

On Thu, Feb 12, 2026 at 06:35:13AM -0800, Chao Gao wrote:
> P-SEAMLDR uses the SEAMLDR_PARAMS structure to describe TDX Module
> update requests. This structure contains physical addresses pointing to
> the module binary and its signature file (or sigstruct), along with an
> update scenario field.
> 
> TDX Modules are distributed in the tdx_blob format defined at [1]. A
> tdx_blob contains a header, sigstruct, and module binary. This is also
> the format supplied by the userspace to the kernel.
> 
> Parse the tdx_blob format and populate a SEAMLDR_PARAMS structure
> accordingly. This structure will be passed to P-SEAMLDR to initiate the
> update.
> 
> Note that the sigstruct_pa field in SEAMLDR_PARAMS has been extended to
> a 4-element array. The updated "SEAM Loader (SEAMLDR) Interface
> Specification" will be published separately. The kernel does not
> validate P-SEAMLDR compatibility (for example, whether it supports 4KB
> or 16KB sigstruct); userspace must ensure the P-SEAMLDR version is
> compatible with the selected TDX Module by checking the minimum
> P-SEAMLDR version requirements at [2].
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Link: https://github.com/intel/confidential-computing.tdx.tdx-module.binaries/blob/main/blob_structure.txt # [1]
> Link: https://github.com/intel/confidential-computing.tdx.tdx-module.binaries/blob/main/mapping_file.json # [2]
> ---
> v4:
>  - Remove checksum verification as it is optional
>  - Convert comments to is_vmalloc_addr() checks [Kai]
>  - Explain size/alignment checks in alloc_seamldr_params() [Kai]
> 
> v3:
>  - Print tdx_blob version in hex [Binbin]
>  - Drop redundant sigstruct alignment check [Yilun]
>  - Note buffers passed from firmware upload infrastructure are
>    vmalloc()'d above alloc_seamldr_params()
> ---
>  arch/x86/virt/vmx/tdx/seamldr.c | 152 ++++++++++++++++++++++++++++++++
>  1 file changed, 152 insertions(+)
> 
> diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
> index 733b13215691..718cb8396057 100644
> --- a/arch/x86/virt/vmx/tdx/seamldr.c
> +++ b/arch/x86/virt/vmx/tdx/seamldr.c
> @@ -6,9 +6,11 @@
>   */
>  #define pr_fmt(fmt)	"seamldr: " fmt
>  
> +#include <linux/cleanup.h>
>  #include <linux/cpuhplock.h>
>  #include <linux/cpumask.h>
>  #include <linux/mm.h>
> +#include <linux/slab.h>
>  #include <linux/spinlock.h>
>  
>  #include <asm/seamldr.h>
> @@ -18,6 +20,33 @@
>  /* P-SEAMLDR SEAMCALL leaf function */
>  #define P_SEAMLDR_INFO			0x8000000000000000
>  
> +#define SEAMLDR_MAX_NR_MODULE_4KB_PAGES	496
> +#define SEAMLDR_MAX_NR_SIG_4KB_PAGES	4
> +
> +/*
> + * The seamldr_params "scenario" field specifies the operation mode:
> + * 0: Install TDX Module from scratch (not used by kernel)
> + * 1: Update existing TDX Module to a compatible version
> + */
> +#define SEAMLDR_SCENARIO_UPDATE		1
> +
> +/*
> + * This is called the "SEAMLDR_PARAMS" data structure and is defined
> + * in "SEAM Loader (SEAMLDR) Interface Specification".
> + *
> + * It describes the TDX Module that will be installed.
> + */
> +struct seamldr_params {
> +	u32	version;
> +	u32	scenario;
> +	u64	sigstruct_pa[SEAMLDR_MAX_NR_SIG_4KB_PAGES];
> +	u8	reserved[80];
Calculate this size (i.e., 80) from 4096 - xxx ?

> +	u64	num_module_pages;
> +	u64	mod_pages_pa_list[SEAMLDR_MAX_NR_MODULE_4KB_PAGES];
> +} __packed;
> +
> +static_assert(sizeof(struct seamldr_params) == 4096);
> +
>  /*
>   * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
>   * interact with P-SEAMLDR simultaneously.
> @@ -42,6 +71,124 @@ int seamldr_get_info(struct seamldr_info *seamldr_info)
>  }
>  EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
>  
> +static void free_seamldr_params(struct seamldr_params *params)
> +{
> +	free_page((unsigned long)params);
> +}
> +
> +static struct seamldr_params *alloc_seamldr_params(const void *module, unsigned int module_size,
> +						   const void *sig, unsigned int sig_size)
> +{
> +	struct seamldr_params *params;
> +	const u8 *ptr;
> +	int i;
> +
> +	if (WARN_ON_ONCE(!is_vmalloc_addr(module) || !is_vmalloc_addr(sig)))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (module_size > SEAMLDR_MAX_NR_MODULE_4KB_PAGES * SZ_4K)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (sig_size > SEAMLDR_MAX_NR_SIG_4KB_PAGES * SZ_4K)
> +		return ERR_PTR(-EINVAL);
> +
> +	/*
> +	 * Check that input buffers satisfy P-SEAMLDR's size and alignment
> +	 * constraints so they can be passed directly to P-SEAMLDR without
> +	 * relocation or copy.
> +	 */
> +	if (!IS_ALIGNED(module_size, SZ_4K) || !IS_ALIGNED(sig_size, SZ_4K) ||
> +	    !IS_ALIGNED((unsigned long)module, SZ_4K) ||
> +	    !IS_ALIGNED((unsigned long)sig, SZ_4K))
> +		return ERR_PTR(-EINVAL);
> +
> +	params = (struct seamldr_params *)get_zeroed_page(GFP_KERNEL);
> +	if (!params)
> +		return ERR_PTR(-ENOMEM);
> +
> +	params->scenario = SEAMLDR_SCENARIO_UPDATE;

Add a comment for why params->version isn't initialized explicitly?

> +	ptr = sig;
> +	for (i = 0; i < sig_size / SZ_4K; i++) {
> +		/*
> +		 * Don't assume @sig is page-aligned although it is 4KB-aligned.
> +		 * Always add the in-page offset to get the physical address.
> +		 */
> +		params->sigstruct_pa[i] = (vmalloc_to_pfn(ptr) << PAGE_SHIFT) +
> +					  ((unsigned long)ptr & ~PAGE_MASK);
> +		ptr += SZ_4K;
> +	}
> +
> +	params->num_module_pages = module_size / SZ_4K;
> +
> +	ptr = module;
> +	for (i = 0; i < params->num_module_pages; i++) {
> +		params->mod_pages_pa_list[i] = (vmalloc_to_pfn(ptr) << PAGE_SHIFT) +
> +					       ((unsigned long)ptr & ~PAGE_MASK);
> +		ptr += SZ_4K;
> +	}
> +
> +	return params;
> +}
> +
> +/*
> + * Intel TDX Module blob. Its format is defined at:
> + * https://github.com/intel/tdx-module-binaries/blob/main/blob_structure.txt
> + *
> + * Note this structure differs from the reference above: the two variable-length
> + * fields "@sigstruct" and "@module" are represented as a single "@data" field
> + * here and split programmatically using the offset_of_module value.
> + */
> +struct tdx_blob {
> +	u16	version;
> +	u16	checksum;
> +	u32	offset_of_module;
> +	u8	signature[8];
> +	u32	length;
> +	u32	resv0;
> +	u64	resv1[509];
> +	u8	data[];
> +} __packed;
> +
> +static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
> +{
> +	const struct tdx_blob *blob = (const void *)data;
> +	int module_size, sig_size;
> +	const void *sig, *module;
> +
> +	if (size < sizeof(struct tdx_blob) || blob->offset_of_module >= size)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (blob->version != 0x100) {
Do we need a macro for this 0x100?

> +		pr_err("unsupported blob version: %x\n", blob->version);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (blob->resv0 || memchr_inv(blob->resv1, 0, sizeof(blob->resv1))) {
> +		pr_err("non-zero reserved fields\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	/* Split the blob into a sigstruct and a module */
> +	sig		= blob->data;
> +	sig_size	= blob->offset_of_module - sizeof(struct tdx_blob);
> +	module		= data + blob->offset_of_module;
> +	module_size	= size - blob->offset_of_module;
> +
> +	if (sig_size <= 0 || module_size <= 0 || blob->length != size)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (memcmp(blob->signature, "TDX-BLOB", 8)) {
> +		pr_err("invalid signature\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return alloc_seamldr_params(module, module_size, sig, sig_size);
> +}
> +
> +DEFINE_FREE(free_seamldr_params, struct seamldr_params *,
> +	    if (!IS_ERR_OR_NULL(_T)) free_seamldr_params(_T))
> +
>  /**
>   * seamldr_install_module - Install a new TDX module
>   * @data: Pointer to the TDX module update blob. It should be vmalloc'd
> @@ -65,6 +212,11 @@ int seamldr_install_module(const u8 *data, u32 size)
>  	if (WARN_ON_ONCE(!is_vmalloc_addr(data)))
>  		return -EINVAL;
>  
> +	struct seamldr_params *params __free(free_seamldr_params) =
> +						init_seamldr_params(data, size);
> +	if (IS_ERR(params))
> +		return PTR_ERR(params);
> +
>  	guard(cpus_read_lock)();
>  	if (!cpumask_equal(cpu_online_mask, cpu_present_mask)) {
>  		pr_err("Cannot update the TDX Module if any CPU is offline\n");
> -- 
> 2.47.3
> 
> 
