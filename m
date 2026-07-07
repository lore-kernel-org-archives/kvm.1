Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B8346E56;
	Tue,  7 Jul 2026 04:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783400036; cv=fail; b=Dq4HN22kMgZZyhfxkWpFDQIiySD13eEfe/2rWLGo6flrQfxJsr5/0jwK3V22QMG+NMUXw8DV7AFvPTJQwpctkfUDUUUGk7cCSAKU4SU3Ia8YD959rDZW7eCymQA9f5ORFCdP2Bvtd2ryU0kd1pnYLRDCqZSGCOsq+1HnQWqG0zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783400036; c=relaxed/simple;
	bh=iwOF/+szV2BeAsizAo/7R5ntEnso0SMCq7Pa2BhLKOg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yz4foSHGH2adaUH2DaM9V39mdPMVuDSIn/y9CY8Yp7xXlZDLetRgNJJgDmAJ2XPC0fwUMCdgdangHTXfITAWYorB4JaNB1OmRVXeg7IsfqDQOYpK61y+HofWFywB99eqnfw2uV5Pv8PUeq4O/EbBfNiT5Sow+KXjx9/O3kgkdqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bAg+2Vcg; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bAg+2Vcg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783400035; x=1814936035;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=iwOF/+szV2BeAsizAo/7R5ntEnso0SMCq7Pa2BhLKOg=;
  b=bAg+2Vcg21SA3gygTSf2Kqe0fgKkMK1nbyQdhR9OrgNfp6r0kEY5eUpW
   vhyYdWkGOyb7d4DxaBBBAne2OMuSVG8tX5X/qFndNPLqcfzJI++MSA5Vl
   4/HTuuU5ss4sZussiYeDokaKFx8E7huwld8jN5WnFWNstPBz6BfXgksRE
   SAdDoWMw/IlmC96/2pSvn8fd+Wr4ZCljn0Fk/CCBq9lrHHMdpm1zuOH1K
   lslEQqBMsZf4m281NBEyLJoz1EzEoIWyP2dI3cp2mxKFfIqHsIaMeDSx3
   5Kv566ybjC4JuvqG6y5nFdKTMAkeAQRWAB1KykFaTNGubX586yOFGdq38
   Q==;
X-CSE-ConnectionGUID: sxrThUOeT2eZ73IiaxPdXg==
X-CSE-MsgGUID: lzkAtGQsSx+lNWQQoBM5yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="87721034"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="87721034"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 21:53:55 -0700
X-CSE-ConnectionGUID: D9dT0NeZSGO5t7wpYlqWaw==
X-CSE-MsgGUID: vE6N+AaaTEy5GiRzfgXZgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="247521145"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 21:53:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 21:53:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 21:53:53 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 21:53:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZ8GMv1PZonxfziezMQxroS/mMwCi8SzPqEk1pq8kxc/nXuGvaQHiPb5T08VLyIgTOKdlU0mlY3Qouz1bH+Kh0M4RaLqPUnukvmgjjfSiS40tYlzJO9BU8WOQ23wjwHEOYA2XnD5sn1Lktw9hw3upAPuQFj9jgEVecbIHn+B7WunPBLQluyqmPMYfUFwV7zuEhBjZ3nsJRG3lIesUxgr9LR6n9VK/FkHwxfxnmcAV1rNPVTb7mHCYkCXDQiCOn93Hle1xVxrTbw+lHVcvrqubIXoAnEsutN1UpKVq3VsOEPif1I82CHwTtCwRLt+ykDU9Cn5itagf0y0H8bXBfCXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/uB1ieX47JxAmXhAMnJhEYYrzfA1JgfmlqE1Ba3eqM=;
 b=la0b5FChuRyM0A1AHslG8HzH5lPte3NTwsQ8Xt98LQu1hvsiKm/TzhQ00p/HOT7gJcyvx+Tr06rjJJSZHef6YhjMK0C/9GCiqa+pbc6Q+tmuG2njoKrG/Hzcrv9+YgtaRp2LKT2RUOe3h/kabO1TL6Fk5IhgBspo8vYkjSvijaP7jXsB9Hoz0JvmKeeLzxTZ2KVTRnCSk4/VdaZYSmgM4g38FHFPh6Obna6ympbJIJofEOYdzfhC3BYUwRp4/waORumAHBe5omlANmBmPiMX6EUqvknJ7155fkjOUS1ai0GQp0xYXdw+/LvD5ej5Wy5FcnH4PEd8uRPhvpifsA6QKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by MW6PR11MB8309.namprd11.prod.outlook.com (2603:10b6:303:24c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 04:53:44 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 04:53:44 +0000
Date: Tue, 7 Jul 2026 12:53:40 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <hpa@zytor.com>,
	<kas@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <chao.gao@intel.com>, <kai.huang@intel.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 04/11] x86/virt/tdx: Allocate ref counts for Dynamic
 PAMT memory
Message-ID: <akyGVOzkHBkST4hK@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-5-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-5-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: TP0P295CA0046.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::9)
 To PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|MW6PR11MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e395e8a-069b-4cec-5c5e-08dedbe3b90f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|22082099003|4143699003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: QT09Ks+plTkqZwb+ShLw0puoPCu9v8RivTQk/44BC1UQshUrdhJ94EekKoOLrTO1kMkWRkqsZFC48aM7oQYwje9yYaezZC60wzF+ip2C3Q+PMiaYgblivH/N3zGOaxXidzCJgyVYY4Umg8ry4IOLdjl8t9y8Txb0FXJxf7P6TkqHHEyU4J6qV4Eym4EpORF5y+OulGQT+qIDe135RbfDs3N4dw5Msv1h5EmJ4ktCghLCo04lYh2fwFNLCTyPx0qHRobpHRcp7QQj3h5Vb2dZ79dMvIghOmrFalsig5WJ8vvmxpICLcSmw20l+fJ6hPn1dMaby3BqKLthnlVPVuofJNb6Mw72/mN8wXfMnjL/x92XRuBFlVMb8gAlfmESWkewA/kHO2/1RjqvpNe3OK6+0nka2VhNeqFgvJlgftseJWMkPpIO1m+jh/iGsyVvvQXBeiX46rf6wkLJgc8W5CXjJ6MmNqgAs0eaolQxqoWzZpdOhXylcqvVxpeeTnLq681NKVtf/ICd8Tgljh7tcZC+/lTz8vPK/iRKjY1kVUsAsBFhW2bsEugrPKG1O9uH8dsBWL+Ep41EH04y6OnkWUl/MI5kW1anEkRpdiO++zKw6yw+b879PBcQGG1rtYCCkQYwM0rR5bGKhlfClSrS5+hh/A7szW656GgzyGYxFDKmRP8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(22082099003)(4143699003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sehXJC9QmMNXDGIU9eYLwEDu/eYp1AAX8yk1fg4wXufrQFIeNkuHGef61+8Q?=
 =?us-ascii?Q?3gcmHk4hyvC8T0qlNkQphwOju6YKrbmDIiVhp4tsZ+55Hu8Lb2caWPsjqP5D?=
 =?us-ascii?Q?PJMjk3WswtXAm4L/i/3HcZ5g4ZZ7vbL7VcQ/da29rZszW1fygOVxs/X1yih3?=
 =?us-ascii?Q?I53rf9x1KVGuXDxwXjBys92UXzUkR+iUXYf3IFPGgTzDYhbJQjeMUS6cyqtG?=
 =?us-ascii?Q?Jp2osYsue6NbLBM9G71GRf8edqRK+bDwRPkkerN768PwxXz2U71Z+4Rkro+F?=
 =?us-ascii?Q?0XDAii+QWBeGXVzzhQyzYTLEfHQ/hImepl3S3C6Vo9UxcMkVbBxldTbTy9wl?=
 =?us-ascii?Q?PFPCPsILZ+vTJGupBwt9vzEJ1hyphPNxK6TBHxCUKV9NEZVft6qb1c/qpGWy?=
 =?us-ascii?Q?pkxcPyu9ojiTFoUA0yg4SQLyvgTcpf4i02LXdp+1Pjt/xG9eRNEdqqeyKeh7?=
 =?us-ascii?Q?ANopaTCX+TQ41OBZOnif7OzthDBHwnPTlGJVzGZ9FM/k1E6h9HOvKp4DGYlj?=
 =?us-ascii?Q?i7QPdm5Btlx7JbIvUOcGjqspLAkQZv+UB9sAozEiPkgfHKcga9RqHzjzn+WO?=
 =?us-ascii?Q?lG6NdhEUrdLk84uYLa4XNlU6B/lM20f9+DpW4MpNGQ8SHj9uGGkTGJGDa8PM?=
 =?us-ascii?Q?L5GFZ4NJrCkXV26o3lxV/ovdhppCr2tAu5fJmHejwF4tYNSM3hRZoW3itTSG?=
 =?us-ascii?Q?JPlsoIjPlogqiDbFOqRW+xWTrMbvx+tIBgkxPr3UcG/BGb3vVG+UPfPV5kwt?=
 =?us-ascii?Q?qV2/K/PQCoyu+jw8Tk19TC48le+/0sKU01NkLNb1P+nm2SpCG89JMG2SMY7R?=
 =?us-ascii?Q?WnYh6n+niMSNILrxnvQjreRyS9AEz4VKn9BVXAotlNxg1oXVTrPO6/adQBWA?=
 =?us-ascii?Q?0SS7AQAxjQUE6zoUQCbu3IlJVk0nHnhxy1bffw7FkKPJP3OMdgFNM9JHQ3lr?=
 =?us-ascii?Q?WhVciume9FVDTsWCzGQoz6gNd860CXAyazT639ow3kjMzrVgCmyEhB3tGFus?=
 =?us-ascii?Q?0RKw74HvJ5tJEMZA7zBX62DD8BTJ5N2J1KR4gKn7wW3mHvsEdpZc3MQn4e+U?=
 =?us-ascii?Q?IM7F3oUeRo4fMHCKNLUMe9IF6S3mOBtTrnmwgbRdFkG+edQ1yhapoT2R65Dn?=
 =?us-ascii?Q?7FNSdQKgJOuoEPHySM+H5q+qNlqERknmR2zGQwafzxADIYkjqcKN77/K+INg?=
 =?us-ascii?Q?WyY0eOedS+Pa4oMzYVBa5mqF5WMjiIK9hqzQGrL/AcBTdnz4ivnRvydQUNQ+?=
 =?us-ascii?Q?LHThu/qygplZ6BS8jq7wUDAZBvmQ519zqa76PrRbinWI7M0L1TD0j8Sw2GKJ?=
 =?us-ascii?Q?2IlsY7AomEZe1rSTiatmpT7kRPQDiSi0mDDMmmZYX3DcCWHGCtBI7LF9ANzW?=
 =?us-ascii?Q?elBZ/p6lcNNYUngx2uHDU103JCX9uARLL3+jMyQb023q8LTWZkASRxOwNqNe?=
 =?us-ascii?Q?iwxBfTbuY0a+b0/4VtMyiLBp69Vk96o8m1tKnfoKIDOhmxNLCtxhUvRswsfM?=
 =?us-ascii?Q?b9PxjmyiFqgbTPYXnuw+DN7C7ug/lKfTjxWloDI4cvduaEep9cBMqQczNTas?=
 =?us-ascii?Q?ZSdBjeOhIq8mVmojOPWN2bG7Cfa/H9/CxMbI4+4iPIlTn4tZy3apSTy9Pvzz?=
 =?us-ascii?Q?BqLB1TI61og1A0U4yhouUmUtimSxSFBhPp4LVhYasOwmnhJmQ6Pii6fHsbsx?=
 =?us-ascii?Q?hHCseYfvlDMYsaRLaI9BR9O8UH9SaJSDgGjV4FAlDMbGhWCgR4Fbh5NeIZNG?=
 =?us-ascii?Q?bXDzLh6Dsw=3D=3D?=
X-Exchange-RoutingPolicyChecked: ZcoSJlKYAQYURVnE4RhGL3u1PwnOIkl5un+PoczYMSAMvZBPPeyyJdubiOoYNh549FZHwzis6TtKQBIo26gYS5Z1REWjXRkroHS5AV4r8sgDlvrls1/VgQWa2WrDxYHRjj5cVLGBz2fuZq72lixdDG/X2CM2JVp7D75zhM9htHyigEBk3KyJcawW1GAOf3NtnFNe6vaExRHxY7p7H/wQTvFGlSML4wpLNh5HUzSnFSg6OdllXCqQ6Ol3d2DJbVLWetBg+A4SjTdp8CHGs7BDGW/fwIoFHoGXswVHHmlofMIojyhN2ojEcObm/cXl3e1zW/ThMp8zDy/kis5vgyz8EQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e395e8a-069b-4cec-5c5e-08dedbe3b90f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 04:53:44.3083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbuKCP+R13oe8mFyiRpBZeX0/ySlluv3ieqx5QqZMIdppQP552/WUwjwmrd5cSFHEhWfR6Uw5sw+lbK9nP6UmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8309
X-OriginatorOrg: intel.com

On Mon, May 25, 2026 at 07:35:08PM -0700, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> The PAMT memory holds metadata for all possible TDX protected memory. Each
> physical address range is covered by PAMT entries at three levels (1GB,
> 2MB, 4KB). With Dynamic PAMT, the 4KB range of PAMT is allocated on
                                         ^level ?
> demand. The kernel supplies the TDX module with page pairs to store the
> 4KB entries, which cover 2MB of host physical memory. The kernel must
4KB-level entries ?

> provide this page pair before using pages from the range for TDX. If this
> is not done, SEAMCALLs that give the pages to be protected by the TDX module
Nit: > 75 chars per line.

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>


 
