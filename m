Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0C36F90E;
	Thu,  9 Jul 2026 02:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783565461; cv=fail; b=nPATDjUSUpWs/j3M02zjRUDC9YgxV/9O/jR18oLbG8eK+voxfvis+MjpNcvB4hcKi9zUX3+iI6MEqsN9Dgd1T33mp4ucZRA3n650YePStNcDORdNpUCM+D4o2a1+gCswXMsCpyAfZn4rnvFeQ6yi9WLDYhSFeTLb+Jw4ORJ/2F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783565461; c=relaxed/simple;
	bh=rHnDY6kIsHmrPcCuds6O6lgX7l6TC4lH6kw3KLKufHo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sa6ZHPE/kg/LisRKYEZP5Atu1U+88LtVFK4ovxF5qBhDhx20NI55cj4FkQQLMwMy5Y7cEFl3cdbpNMy1uZEgH79kCEYgaVAtD29byAQQ8XbL3E4Q82Yb1ttkDiw/lgdHhdyDAPvtq2Am5iDeQsrKxgVovJMx/xQjmPE+ab5aZ7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZt02/Y8; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZt02/Y8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783565459; x=1815101459;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=rHnDY6kIsHmrPcCuds6O6lgX7l6TC4lH6kw3KLKufHo=;
  b=iZt02/Y82drL3SfiEpAFVgxEZ7AiXe2c8iyuwzVCjyHVHwXkCg3nDnhs
   M9CBk9sYzjzlg4ibIKVPH0kgUe2phGFPProOumTPeGK30xfTpFsXfWOyE
   saYyav7syO8GdHMgy3Z3rgUP3FMMZy6hiIBiC+uVTaxTnMPRWZAH5A/ET
   o3K4mZVgJF2QY4iLDc8onJNGz+tybtzj3WbtD3O4UpHNKI1GYv3tHGKbT
   GmkngOlLQfgURpipjbKqHi49gmq/W35qkZScWM45mrc/HAnpRBsQCzL0/
   fjM6kkx2z91vrd4ohUcUkjMYxD9QvGm664kbQy4pY4l5TaPV+2tiI9viI
   Q==;
X-CSE-ConnectionGUID: M1aHqd/9TIi4VrPNu1acUA==
X-CSE-MsgGUID: o6P/RDQxQcivMv5wBLV6PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84431368"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84431368"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 19:50:58 -0700
X-CSE-ConnectionGUID: R/+m3ALpScGyFtA7URUpAA==
X-CSE-MsgGUID: I84TImDRR3iMvvfS08urqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259353911"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 19:50:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 19:50:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 19:50:57 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 19:50:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ovcb4Dx6Pam6a3y5xgMXN+7DzlH2SzLKp5BaaZqf2ZQ+XedMyPQt/iPejhBtkYfZ90yBexQWT3MIwua75OzLn9LcMh3SQ5ytfh0CLqAjA913QGUXYah5KYsHM+utLllD3Fn5QhX4lBlLKiVr+sjtLsc+98m76HZA2tMo4aOhiARN9yh7g1sIbmgg/cpPtPfPmHs5sO6Uc6PdYjrGCHmuhhlykxmEuiNl/81Alcyqv08npQML5sIw1m3MSdUpNOLqXc3YJTeXp+KpPaIkv1YjglmeKIxjgUpXeF3Up+fil1xxF5cW32HEOo7C3QxrPev2ilq+YzYFullzjA74edTpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQXzZFS6p+k+g/d2yHptacJ1/qZrxW98J/ZfuA1HjdU=;
 b=GWHboHLI01V/My5PIT56Hv3iSTMAvrfykMYvPCj5cnv/4ynVOcsWIIwf/pa3lm0SsFWFw+UGOyHW4ty4k+ZALCjjmqslD8OF30pYBwOi8+38EefHEtrqeAmoVEsZVILv0lC45+JraK20R92Iwzrsc8F+ohKt1kMSo1bjoKhL/1q/VSm3DZLLkOwyX+Q+4x53Dn1m9VZUWDkXg+LFnYw6kUz1gJr8XDMF13teM1OyxoAyICQZ38LOarVr7gJcH57+B0gVjiqohK7/lfbD8tgp8436ukJ5+qkw27vLTDnogi83SuF9v+/p8Jb9sSVLkFZtd8zOzQMv8WsNG3tv74GgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by PH3PPF307806035.namprd11.prod.outlook.com (2603:10b6:518:1::d13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 02:50:49 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 02:50:49 +0000
Date: Thu, 9 Jul 2026 10:50:42 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 05/11] x86/virt/tdx: Handle concurrent callers in
 tdx_pamt_get/put()
Message-ID: <ak8MghJ4OKmsXAWE@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-6-rick.p.edgecombe@intel.com>
 <ak3ySL89u5+1oCZB@yzhao56-desk.sh.intel.com>
 <9aa0694b9f0e2057808ed7c69ba6796a1d629bf7.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9aa0694b9f0e2057808ed7c69ba6796a1d629bf7.camel@intel.com>
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|PH3PPF307806035:EE_
X-MS-Office365-Filtering-Correlation-Id: 0867019a-2035-433d-7bb5-08dedd64e1e7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: hqX8gkjdPDTFmW00ftLm17DrQdaXyPL6TVUB5qfMVkmCd4duXge/LreGpzldiiw+LwZEKAPOCteDX4t8qfg3BFV8BrcyKYCjpABk4rhGoIO+C3j+poCCn0UW11UkjyxdCvFkwl24/YJ/05fULO6V26h+R+ABM4dWfzWXeZTcw2oud+mopke+7LRZqEZlP2jqLAHtQqHdSx+RLAtLk0qARZihA9aBI1b4CG6de96OZdlc+Yigt7sH9sJRBli7oTIGJqsesy+XMdFZXryObDblZuicN6Er4D1Mk8RaNN5aQ3Tg70wunMTLhJCoGOfIFyyli+TgO0Zk95tox0Ff0Lxd7JjOzxLuskHnqMdodnpQAmJJeipfUjS/ypvD/Ud8ylJIFciIZyciEKIYFpQjTGIoqpUoByXv9MLgycGumhF031YjFtrDJA/5N5yZEMDwJ8UERGsvsF6VJVBrfOdk5/Bw3ZtPBenUZPHve3uCJnm/MNmN5rjs8mi7+gqRUqB2SXTMkWmDxmgxiDE5aeyvRyG01ll5Ku5ulK9nd8Di72PP2oVI/HQ+Tjb0NwILhTHSuV+hqOIpsMStk1HrjcvGB9LVIEfgvYGK5yV4rw2SiCz9Ws4Ds4oz+r5M1uAK00wiD70FOf0dfH/fRl2FIeSuBQM8emzTsU+OrOHFIKvQVfj8IFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w4umfpmvJSnktDgYxDlF3wXlT+EPVE6UXm8PkuPcr2myU3rL47+b8EdNuPHn?=
 =?us-ascii?Q?BNSyIM+83fawH1JlhSwmz6PF7ZKHwlYZhllMjSvnWUybrHMpXwtgAreMwCMK?=
 =?us-ascii?Q?7FY8PRhjZj/3lIpm2w6VvTaSD0BR/D0jdc/1U3M9WDHaVsyHlU58OlJv2I8x?=
 =?us-ascii?Q?6LyIUzxUEwrq0cSPpm3XcFUPSi+7q6OmIrjDIjR52OMGqYh/7mNPAtXGsp2m?=
 =?us-ascii?Q?TsqDQRNoJE/j0R7b9CWtXq8obrI4UpnQGc2OrhbRS+2qaOef67vl2lPAj1Co?=
 =?us-ascii?Q?pW8gmDyxEHR2Zq+4ihpofMhNSUwbMZbHEd6qYQAdc5Bz33sYpq07ogTS4SVg?=
 =?us-ascii?Q?yS99hkK1hMlbMqwuOitUxMdL11+8FecvrAcSfE6vbDQmfhsPupkF7UQLe+bn?=
 =?us-ascii?Q?dZTAi8VOkdVAIriTkoC0AVDdtfuJmVHOJp3vAcwl6Vtk/CJ3xtLL2h4PgV3D?=
 =?us-ascii?Q?WXX8IgAxSIKKrB88HC5H1Vq0wlN876cF08AesoTU24laGYsgUFXRGqAWCkys?=
 =?us-ascii?Q?kXLgPyhlNnqno0ulUmFg8IRX7jrnMnuv8sQzImL0NAldOI4oJ0mWBsPYq0RV?=
 =?us-ascii?Q?ggz2fSxZZ5IG6kUpzuQWdDm8Pw09ZDP5T0Dkur2rOcfFRsoceFr/b6kA4ykR?=
 =?us-ascii?Q?+5e1KibAC4y2wEbHHZtk/DqD6lwee5niuMu60MN+5g+3hocoRI4WYMAhhaey?=
 =?us-ascii?Q?1kF9UmNskYVimt5Fi+HAx85dM+t57ZUOPRnsazw4+F3UvZuvJIn4Zcni7LSq?=
 =?us-ascii?Q?vB8h2OhdDTK0XHgUgcluhPS4FUDXvp3SsE5J6Z5qbYoZBZTkJsc+riZmk2sY?=
 =?us-ascii?Q?i1EE3qwhMlO4k74o6g6JEloQzDowfVKEd1a/7XH0OJPY6qwBjusgwwnNBajG?=
 =?us-ascii?Q?18fMAYM8NbgD4DGY1WBT6kZ01NWEAj96OB/iApyt5/vUhI52kYB3jis7JBtt?=
 =?us-ascii?Q?kayEqRx27W1wrE5JopKar8wNsgpbeb0RwtGEE4F3qgYjIop0eGjSAFrqnpTQ?=
 =?us-ascii?Q?BwpD+K5lWxjrypKaH7DBqxgOJLzJkmpjSDIFmO/wdWvz2i71B2zfrxM1uDLw?=
 =?us-ascii?Q?Ov8yWnBHqY5z0FF3mBNIvwgCLdrSQBB63d4HjJkm5Co2qwW1JxVOshu0fiek?=
 =?us-ascii?Q?PW0CpqgeWeMQqV2noi5fN+jf4pZtxqMnzwtvlf2n5VOAlW76vB5YHWFMJJiK?=
 =?us-ascii?Q?EaBjrTsykls7VrkBkqExip2H09KBZlwO5ybcrLPbX9ss4f5cKmimRdz+uXb1?=
 =?us-ascii?Q?JVZbNSqZZIZtI0T67+nIEZijVUcaa9EkISuoV12nn+inNiPftvAx4ugP9Ep/?=
 =?us-ascii?Q?9hGX5KFBfWu5mKaXFQP7kyqcC4a90LxUK7e0E98G/xOYUsu2TTCTn3YP2Ob+?=
 =?us-ascii?Q?TJjTK3wV0BuFE+MNL7aVAt0f4ywYzwM7LupEpkoX7mUWo/cUuw17jIVkO3fz?=
 =?us-ascii?Q?Lq0DvwzRzAKgnvELgcm1YX8A6RnawVI2+E5pXFkVcXgS+XeAMPFM+AqKZ8lk?=
 =?us-ascii?Q?F5HjA6E0TBXFrMsAAtE6A4IypzLO6iLVM6UabqB0gl6w+VsR41Rl/YYjIbXp?=
 =?us-ascii?Q?XN2XsclQewl5KuR58KBNSV4GG2f1tbGoHffWVRQ36iiPUZWAJFRAcMFs93T5?=
 =?us-ascii?Q?vxVF8ZMwDGyxca6dIXZ/8BG95J0IPS4AXuhSv774yzkWTZv/Gokeekl2V/td?=
 =?us-ascii?Q?BkCOja7kBIwaTpr41rsJbYqvPoFVVsMLpf+D81U7EwfmmwiaaTR7RkNN8b5T?=
 =?us-ascii?Q?j+CGODCxtw=3D=3D?=
X-Exchange-RoutingPolicyChecked: pC1kbxWw2WV3x5bag9d+XxUx6/gmpmzJFfp57t3g+Wpz9dD1sCCwKDEIBpTn8oTNSO5rAwLOD6U29AO0eA5UAZRGQUiVCqPFdd4WVW31Yq2Vfp8NcFTtHQn9ViGxiBJibmzWCDDIQItHr7gml/cRPNOV1ynNu/RhDInB1OfGNaZWoZ3s5qsFaoqo1rJ2YIi7mbJcBrZOYucE2HpNxhiofNPPAcqB3SELztg49kHBzvEUTQweShJsKfSu0S/1KZvf62ycThaNDO5DR99hv33gVX9UeqivDCbrAFmcYX5WS2bPPnh+QSQgm46NROrjg2JZJytIPEOmldPiztqdMR82dQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0867019a-2035-433d-7bb5-08dedd64e1e7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:50:49.1028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBEwN/h9PFJLz2bGI7wgIeILbjcZLHr2JyMg6zTj/b3Lnlb16jJvKYEONyt6aizCQOGETJVKiURAqaaN5OvytQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF307806035
X-OriginatorOrg: intel.com

On Thu, Jul 09, 2026 at 08:33:40AM +0800, Edgecombe, Rick P wrote:
> Thanks for the review!
> 
> On Wed, 2026-07-08 at 14:46 +0800, Yan Zhao wrote:
> > On Mon, May 25, 2026 at 07:35:09PM -0700, Rick Edgecombe wrote:
> > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > 
> > > tdx_pamt_get()/tdx_pamt_put() unconditionally add or remove Dynamic PAMT
> > > backing for the 2MB region covering the passed pfn. However, multiple
> > > callers can concurrently operate on 4KB pages that fall within the same
> > > 2MB region. When this happens only one Dynamic PAMT page pair needs to be
> > What "this" stands for is not clear and a comma is missing after "happens".
> 
> Really this is not clear? The previous sentence is all about a senario being
> possible "multiple callers can concurrently operate on 4KB pages that fall
> within the same 2MB region". So I thought this would be clear.
Hmm, sorry for nitpicking.
But the previous sentence says "multiple callers can concurrently operate on 4KB
pages", where "operate" doesn't necessarily imply allocating pages. However, the
latter sentence assumes PAMT pages need to be installed. That's why I think "it"
is not clear.

> I could say "When that scenario happens..."? But trying to keep the word count
> down.
... 

> > > +/* Bump PAMT refcount for the given page and allocate PAMT memory if needed */
> > How about
> > "Bump the refcount of the PAMT page pair for the given PFN and add the PAMT
> > page pair on the first reference." ?
> 
> I think I see what you are getting at. How about this instead:
> Bump PAMT refcount for the given pfn and allocate PAMT backing if needed
Hmm, in this patch, "allocate PAMT backing" is always performed.
Only "add PAMT backing" is "if needed".
That's my reasoning. :)

And I can understand that "PAMT refcount" refers to the refcount of the PAMT
page pair. I just thought it would be clear to call this out explicitly.
No strong opinion though.

> > >  static int tdx_pamt_get(kvm_pfn_t pfn)
> > >  {
> > >  	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
> > > +	atomic_t *pamt_refcount;
> > >  	u64 tdx_status;
> > >  	int ret;
> > >  
> > > @@ -2057,10 +2061,26 @@ static int tdx_pamt_get(kvm_pfn_t pfn)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > -	tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
> > > -	if (tdx_status != TDX_SUCCESS) {
> > > -		ret = -EIO;
> > > -		goto out_free;
> > > +	pamt_refcount = tdx_find_pamt_refcount(pfn);
> > > +
> > > +	scoped_guard(spinlock, &pamt_lock) {
> > > +		/*
> > > +		 * If the pamt page is already added (i.e. refcount >= 1),
> > > +		 * then just increment the refcount.
> > > +		 */
> > > +		if (atomic_read(pamt_refcount)) {
> > > +			atomic_inc(pamt_refcount);
> > > +			goto out_free;
> > > +		}
> > > +
> > > +		/* Try to add the pamt page and take the refcount 0->1. */
> > > +		tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
> > > +		if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS)) {
> > > +			ret = -EIO;
> > > +			goto out_free;
> > > +		}
> > > +
> > > +		atomic_set(pamt_refcount, 1);
> > >  	}
> > >  
> > >  	return 0;
> > > @@ -2069,26 +2089,46 @@ static int tdx_pamt_get(kvm_pfn_t pfn)
> > >  	return ret;
> > >  }
> > >  
> > > -/* Free PAMT memory for the given page */
> > > +/*
> > > + * Drop PAMT refcount for the given page and free PAMT memory if it is no
> > > + * longer needed.
> > How about:
> > "Drop the refcount of the PAMT page pair for the given PFN, and remove the
> > PAMT page pair if it is no longer needed." ?
> 
> Matching the above:
> 
> Drop PAMT refcount for the given pfn and free PAMT backing if needed
LGTM.
 
> > Another nit:
> > How about renaming the title from
> > "Handle concurrent callers in tdx_pamt_get/put()" to
> > "Handle concurrent calls to tdx_pamt_get/put()" ?
> 
> I'm not seeing a benefit. Just because it's shorter?
I previously thought "callers in" sounded odd.
Feel free to ignore it if it is not :)
