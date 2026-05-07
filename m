Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0873F074F;
	Thu,  7 May 2026 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160014; cv=fail; b=j/0ZI8q+FfZzIwdItF2/jRsIHPHWcT5fduJyKpAF/oUsh5MHVRxpdYf1sWqj+y2+r9Fzm5O34sBgffSC3fv1bDPqLU4JpJY3HPKpGo4EEiqeoPg72Vp889kOuteJ99QUHKUhLxD1uAv6UcJ6p7Nla6L/gQ1QZdukd4/hiU/tUzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160014; c=relaxed/simple;
	bh=NGzddsBA1qyf0C8kVUJLkIE89knK1zGUI+0+JrB48Sc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l076S2MEQXexFZnm9gDFon6vVQOCtg6VrSAqpzHEXnukCAOpw0r6MrRHxQwn4Mkhxd27HVlN7g/HyE4GGfhglZu8DBx8zw6Q5hDfGMF/HgvSz9ZEJYzTQ9ZKAetImQZ7slaVwsmA8taTCIeFtSPb1GqTPi0h8MosLNw+3BYfhOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPvFeA/o; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPvFeA/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778160013; x=1809696013;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NGzddsBA1qyf0C8kVUJLkIE89knK1zGUI+0+JrB48Sc=;
  b=fPvFeA/oJG+q3FVSxUktuEYH7gxpY/owgXcu0dD4F5jmDHIvlUpWAb1q
   JVZlrMeb0NurwyOQTUzJ4wzU8X2hOGa3GONBwo+6qGy0NVjiX1CVVPiS1
   cYjLSnuuuSrX5NvaUWZjJTRPsLPtr9hgdoLSiId3kQBDN+s2dC8VdUXRb
   XalSoDQgQxk+dSjBE4qLAuu9JqhPa/RMkcfoI0rNWkR5N93g2Fc/+u3M9
   ctOCKR5ZwQJC1vM4Bv6RxUddg9byDX9mD2dGCKPjSmG19Mlat34JncoNP
   Tz/PjhkpHtBFdgNhwiufrMHuaPSeOGNj8Oh4RNh4rqqDRbcBLMcPo3vYE
   Q==;
X-CSE-ConnectionGUID: ahUIyN9KTdi1/xyXcHHmxw==
X-CSE-MsgGUID: 5rTZlVyzSAiMz5q8ZA0QIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="66637030"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="66637030"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 06:20:12 -0700
X-CSE-ConnectionGUID: DMak/1d7QOiC16M75Y6lCw==
X-CSE-MsgGUID: /v0Wm4saQNWtaVIg/fIWeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="241466306"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 06:20:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 06:20:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 06:20:11 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 06:20:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4FdAsfCvkGHJ4/Cme7CfczP6Rc5VXSW4WMgitPMEmsgIJRkrJtJ9++TvJ2/C8+2xy0Eie9hIvCyu0u3vca+xtRl47vjeCbnM7XAvzc7+J+m51cqzIXxM1DyLslfhSXG3wWfOV3I8deANZ7P/iChBGvdYrT/eeaUgDdlOXHSpsjrXVFd1M6R+vTxpkmEqezlKpI4OBkqWWXJ/fz+v42b6zP0C0srxRncCh9wGhrvpc+M/dkN7fpJxTg+EukRN2jhsyCr1SBhsiPFK4iVuwHN23h6GWnP/S6y8flPg4j2Xuistj3SBE/k6XV73IXbBboDECrwGvfgokzodqftVRRB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICQTyFwbZU/nOl37lBhypWVNqO9R/GYJj1JccmCTThQ=;
 b=CeLWsPXKvw4D2qh425Md1bmHjx57XkuitdXBMzxKJRSr4ysr1fHI3T+FRqQVix1XohqQ/ucKzLKErRlMK12M27vgbbMlQRj3u5HphPfuf3cunfSA7xrOXKLBuPL2RGFbi7oDvmflo0/prqHIf++vpXxJIPovJzqoI4LD2hYsClDadIwOBi1U8XGpzXBXlZllijOxLoR+ltFr7w3h32tRJZyM09CcNRuL2MZ5rfbNaUXgHNp/gGrOrkx2uhCjN8AhsGzaElKI7vZP0HdYWFssr+etRWJhEXk8YsR66e0wdhP3618ZcI8nbex5qH8xhrmt5aXAF0yYu4toF6+su5ieNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Thu, 7 May
 2026 13:20:09 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9891.019; Thu, 7 May 2026
 13:20:08 +0000
Date: Thu, 7 May 2026 21:19:54 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<binbin.wu@linux.intel.com>, <dave.hansen@linux.intel.com>,
	<djbw@kernel.org>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v8 08/21] x86/virt/seamldr: Allocate and populate a
 module update request
Message-ID: <afyReleDP93DSgQa@intel.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
 <20260427152854.101171-9-chao.gao@intel.com>
 <a52c4701-c99d-48d5-9b63-8eb1c0e589f0@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a52c4701-c99d-48d5-9b63-8eb1c0e589f0@intel.com>
X-ClientProxiedBy: SG2P153CA0046.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::15)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DM6PR11MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b11a34-5b37-4a73-ab8a-08deac3b5c4f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: DaW4i52K+5GYBXwhlwWcNX5jheqpqPWW99WUJtaRbmvVEFFI4zZLMxAUp1bUHzRldEJte4qaaGOoo/WhqfcdqgDDCBBfxxDnBi/1blGrADHqmvduLtVc/JDjVfDp0ITaDJ0vheeuaHj6xMcM8+b9SGYdtfIi4UxfjCz+jT3EF8P0LvzAIsrmuAN5pweg1kkzUdGkva5Trn26Tb/G92vylZC2MURgKf8SyM7RwSyMP7BMT168JbMGqjGlO+SFkHMyRYOtFn2N5L69/yKLI/CTzn4XcLMxWgZaP4+6rLEvz9v5OA3uIYdJGnUp71DeHrN35TYmhTvCD7ZQO3bClrlE5ZxePsWdJB7zrEjQdXhTjh5NL47sLMYN5tYEz3BO8KS/l70V6Z2td0tL4qQeO4nmFCsxvbV1eGBihKIHGxO6L6hZzOSG+zSGNP6ltu563kLlKbq6l+U0jzo3RqR9q6iOH0eFDg7/wVwIyfE0w+knZGjQCxuJqrtJ6NGqHfCyD4CdzNHk0Kr9s/1qZeJMnAmxjScR2hutjgi3hwkLHq8fbbppxe3RdgIQXs2LAqwdglpomLX7GlEud735Qiji1wT6Vnnl2b+v9RA83o9EeIT26zyMCS/4DNXdlfB/AlsXBSvY9kzkJiTD1SiCZoCAXi2pfLOe+N3EenVkA9QKrT6oVZQRuX018b6zNtVADmPOb8lp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RIFYRDzfFeN1VWSE397TfBCjQvSpUiJ5L5himwQzEitl55OUfkXFyCBf6OfB?=
 =?us-ascii?Q?QtTETQH1qkyTLFJNqzBPBAlmqydvo2ONjYcs4x0RNC9QRqS/kV8iDMyizyVe?=
 =?us-ascii?Q?9rz30xbrYiU4AatHys9exQmPLBXUJlNiE+2w5KY83THis/ImK2LAyeQnQ3lA?=
 =?us-ascii?Q?s4X8T5bjdf+1dmJo7zaBfXIcXuwdLZGe6NiMO3BU/LOL+J8kjNK4Z1S9M0/L?=
 =?us-ascii?Q?8Ne/75W+SnNXcOWQQ1kIRp4+eP3DfvMqcZvO8bwPum3gogVnb6bRfngFxQxb?=
 =?us-ascii?Q?k9zf2EesnqCRr/+cqshh4v0VTDRDcIAOgn+qoEdl0mcbtX26aJvOtUDuzXS8?=
 =?us-ascii?Q?mkhjVmVoCUFmAotkhp4foa9x55lFG5aGPCKO0DHWReDVTQX8/h0Mf6i6blBB?=
 =?us-ascii?Q?rnF58wrU/kYBK4Na8o283iRwta6NvJJybMxVwS6FSVLAwW7QnJV0EIRS7ZuG?=
 =?us-ascii?Q?zxdcsUPmAtwYjtqKr492wLqI/yuhZ08WFPJN3OIAydvoDXouOT/we8KTf4fP?=
 =?us-ascii?Q?nAfcFN0jLO74O80DikBGnN34oxe2o0l7kVMogf1m5JWLTWN0r+JDTTke9zKd?=
 =?us-ascii?Q?OaU7xp58yPwQ0dVz/epQQxRc4rMRX+WmKgTrPPhNXVYt9TisDIZ7H1KHkPX3?=
 =?us-ascii?Q?eYfx5IO+NaEHgO3McE9JOrVdMj1IQe3tsF1tETMK0Z2ClXtHwmhW9pYYBVnh?=
 =?us-ascii?Q?mIDStXC220NeWP14MVWoSjncUsUMqi3rE71ptwl+El5YdtY+QHWe/6LyV6RX?=
 =?us-ascii?Q?P/EshcTGsHjpL1SCSk6yti8iqk2Yq8G4izvadZscWFTAOVaD9pSNRfwK9bQ6?=
 =?us-ascii?Q?5DsDl+8zciEto6QSPG8MJly3DCmruZyHEdkXxBt5TZbrj7W9QS9IMQ3dwZag?=
 =?us-ascii?Q?2XK7svU2yf0ISE2/Zxf/n80FpuOgVs+kdFCYByHwg15TOuTaF3BWUQQoxbzB?=
 =?us-ascii?Q?XVxhQlK1bRIipM4WcRO3guI3DRvIANq/Y97W3gHNQsTAycbTH/E1S8o+sBMC?=
 =?us-ascii?Q?uf0lfTkLRY6hrCMObWnXzEmCiZcAIddHSzJnhKET23R9ZIjLZYuohXg0SlxO?=
 =?us-ascii?Q?vpgGIh+/ysvLfC9b9XkwecdrtFGSFZBQGQeOUHUtks5ZKDXSuMOZ5oXoHKqA?=
 =?us-ascii?Q?8U3rRxMp6k1WYUKXdiASD0E4jO+niPjIelINRZDOah6tjh2Rd4KCPp/DV8lj?=
 =?us-ascii?Q?YVH/7nRHBdEyoDULBTLKNMRbrXkICv/SnpL4ZfTnsYI25waMqpLp/Tr76kE9?=
 =?us-ascii?Q?Er+th4MkNE6oLEnN5t8vhBY2tsqzQq0+IDsMMlX4Caa9KzRQcAq1Axf12xmM?=
 =?us-ascii?Q?yNiLQJzvn0Ld1HgZcJ4mQ+PucdPsGA1lILm70JfJn7p5yRc1XnQLEpR/t7CT?=
 =?us-ascii?Q?RlzM8zu6AAUAVRDm1VtdO75QVnrBGkrrh4OjGFOWo7z/B08dBzQJEeXOzkV+?=
 =?us-ascii?Q?nhudtUaQb/H/flVN9ianHxINaVoLv+opPjudUxRIczR0I2pJcnPRhB5MZt6L?=
 =?us-ascii?Q?OcU0zabNOrErRGms4lHnE1Eeey5s00yIB1ZAORqLHRQVHks101bd2RaDZKlX?=
 =?us-ascii?Q?7fdxaCBwY+bMEQK90GDahzohHTdEHuJDzCz5ot6z7qaSd7lH2tXJWPRNnWF4?=
 =?us-ascii?Q?1DGNSNO5E5eBpgweMrzeAufNWdA/bsPmndkviS7nbGTsC39W0fm/oCq/kzXt?=
 =?us-ascii?Q?xN7oV0/OEYRAWKvXbiwS70fP0u5e4H6JBlxAOYc2wtnCIrVlf2e30gTqzEzP?=
 =?us-ascii?Q?jCKKRnTgUA=3D=3D?=
X-Exchange-RoutingPolicyChecked: ONVh2Agq8P4yUHf2w/FOjWUv0qSkZrIvgOUmzIiRZntMR59tgIiavrVuMsXOcCcV5z5mK+RWt3JSTKKVqzOn2kpYEVwboSan4L3VXkh0r61aVfsoSZIa4s2ZuL5j2VezLleQr3AN4/CbwiTbadt6rZfw4aZ88v2Rpm3XNRmyK6eJVUxzbZ+KF1uCfMMVBkNJ9CCaoZGJ11F9UsFwLSxY1sae9DYqi/oVlGY09C8WxnRrtFjU8f9Exuyk+QDbiNaryZPNXYkceorfJs15jFFhG5V2GIsqQIjVvuHXZJZBuLu2y2YdmvNztk5roQIXCQwavd8rfCUfmWNN4t+TGmYpYg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b11a34-5b37-4a73-ab8a-08deac3b5c4f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 13:20:08.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcq1Tkk5HtKf5RzZZ8PUrPvbXaiQnkkswtRk617lDiC0ka02QEzlQ7XvC8lBu6fyOb/ACkr6OnWcsKD8vepdPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4545
X-OriginatorOrg: intel.com

>> header is consumed solely by the kernel to extract the sigstruct and
>> module, so validate it before processing to protect the kernel ABI. The
>> sigstruct and module are passed to and validated by P-SEAMLDR, so don't
>> duplicate any validation in the kernel.
>> 
>> Note: the sigstruct_pa field in SEAMLDR_PARAMS has been extended to
>> a 4-element array. The updated "SEAM Loader (SEAMLDR) Interface
>> Specification" will be published separately.
>
>These changelogs have all the right info, but I find them really hard to
>parse. For instance, if you're going to have a 'struct seamldr_params',
>then just stick with that name. Don't use the "SEAMLDR_PARAMS" name too.
>
>Start with the data structures:
>
>There are two important ABIs here:
>
>'struct tdx_blob'       - the on-disk and in-memory format for a TDX
> 		          module update image.
>'struct seamldr_params' - The in-memory ABI passed to the TDX module
>			  loader. Points to a single 'struct tdx_blob'

Thanks for the thorough review.

Your comments all make sense to me. I just want to confirm two points
below.


>> +	/*
>> +	 * Don't care about user passing the wrong file, but protect
>> +	 * kernel ABI by preventing accepting garbage.
>> +	 */
>> +	if (memcmp(blob->signature, "TDX-BLOB", 8))
>> +		return ERR_PTR(-EINVAL);
>
>Is there really no helper in the kernel anywhere that can safely do the
>8-byte compare against two known-to-the-compiler 8-byte-wide fields
>without hard-coding the 8?

I couldn't find a helper that automatically derives the comparison
length from the operands.  'strcmp()' is not suitable here because
'blob->signature' is not NUL-terminated.

Do you mean just avoiding the hard-coded 8, e.g.

	if (memcmp(blob->signature, "TDX-BLOB", sizeof(blob->signature)))
		return ERR_PTR(-EINVAL);

or define the 'u8 signature[8]' as a u64 and compare it with a constant, like

/* Little-endian encoding of "TDX-BLOB" string */
#define TDX_IMAGE_SIGNATURE	0x424f4c422d584454ULL

	if (blob->signature != TDX_IMAGE_SIGNATURE)
		return ERR_PTR(-EINVAL);

>> +	struct seamldr_params *params;
>> +	int module_pg_cnt, sig_pg_cnt;
>> +	const u8 *sig, *module;
>> +	int i;
>> +
>> +	params = (struct seamldr_params *)get_zeroed_page(GFP_KERNEL);
>> +	if (!params)
>> +		return ERR_PTR(-ENOMEM);
>
>kzmalloc(PAGE_SIZE, GFP_KERNEL) will save you a cast.

I noticed that 'kzalloc_obj()' can be used here, which avoids spelling out
the size and GFP flags explicitly.  So I ended up with:

    params = kzalloc_obj(*params);

If you would prefer 'kzalloc(PAGE_SIZE, GFP_KERNEL)', I can switch to that.
