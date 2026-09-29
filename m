Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4948B3A7F49;
	Tue, 29 Sep 2026 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667696; cv=fail; b=OQa2qzwVVJDbeTmHjI7Gs3/Bkr9zS+osYwyEeC5uDJSNZLn6tcPNdktzWdbjyD2Ew0EUWYb4hRnBe7GUSy7pgDISMR/mzqOLYwIwTqUVZG6ZUcBSQbkYvMtJnYHtHTA95wZ0AatHcDd9m4fQDWF0uJxfrMe2jRozXwxA2Evt0CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667696; c=relaxed/simple;
	bh=gSTYwFGIz/TvpqknU+4SVJq3RSunQ+gPnUTKSw2QiyI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DA7DsYuXlpKuIjuHKPC76Pz5lJHa5Lsfs9djOVIEzpNuOJJtzHs27E/vIQFFt7SL3RFdLCqrjN7wAR+89ygRyLZSBCdHW1Lcv9CAGkIqRdywDnPBkYVrvPRxdXuC0GbqGM9V/DyNAPl2Y8kAOHdG6S7DGYh08WxDqnAvcFzKarA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNAbVXWw; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNAbVXWw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790667694; x=1822203694;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gSTYwFGIz/TvpqknU+4SVJq3RSunQ+gPnUTKSw2QiyI=;
  b=dNAbVXWw3XYzLL8sU+p/3q0qafSQPhGSXOnbU2OOZxwy3ECe2Bdo060H
   CvFCR0mqXeg9kqn4UL0bmoIVeAIA2I3a6MZiy+cIvOsV7mW4QmOBULjV3
   hUYXHlQmiTWg3zKRhoDVXehxdlzDGVXFPdiFa/ZPQ43eXZxPMltGLClIV
   //+xu3RcAjTW6yNl4dGQ7/823LfM2Hwo6jRNWSnyYQKbDBlioGCd9LYCt
   w8vNytXDSJAgr6isLKCGAKwvSQfX1g1/GACmkEMqQ8rHJUpwMUzFy/wZj
   ThsIESsoV3v3zOOh20/ZLmveHOpXYzTxGjLGLUAojOqpIQD6RxYZZxS1W
   Q==;
X-CSE-ConnectionGUID: fyqxRMzgR5uju8IeQ1qxWw==
X-CSE-MsgGUID: 0fnXzNd8T1W/Ez8O/GQ4nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="91238919"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91238919"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 00:41:33 -0700
X-CSE-ConnectionGUID: 72sfCPidSPCIMP0tv3M4CA==
X-CSE-MsgGUID: EUxpfpzNSVu+tuDarPcYUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="303251137"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 00:41:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 00:41:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 00:41:32 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 00:41:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqbOtYXSX9W9wLEH10JN0OsorfVfqQI4/2551yVLt/gqptOiZRIyC/bdBzvRDn36WLGSxLugLVTvzKNpssW92zUFPYU0zRNvOEqsO5cMA9tKlbqAnd0Og6/zBzT5cr03aHWf3Yq1ltmCbPTwEDM/nL6GaE0GIiClZc9idDeDjaZI/fRkKc1Rga5/LLx6UdneeTSqTgPEpWzzpQRffYQvxAksxSUCggXY1KCjIeiYgpo32bmEv2OztJwgGmsMDCmkMrf9Z/rMV6plFMxuzaptkHpmYX+I710ea2h7rFsXCaAJWgbi7pYEb0zk1lI/D7cdcuyPl+2wIGH8Mwl+gDYHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT2/fJcO6Qd0xYTgC6V/+xidqhDDUCsdxeRPH8tm1p8=;
 b=DbeyUnNX04BsQ+MuFNpGgOxWpPtvDU6ZHeHnCqy7tE677gYstkvMSFW7xog35rEi5Mq/Dy0jNtRoNXiozqCe1sX2jJPjJNxNBq0ync9ywNJJsOr0pkJaVACini+1Sy3za1eh4ShtgTq6aBblsT1ypbXatmWEX7wrdwpCoNW9t0KHMFsl3otuVZtHWxMVopCLxrEkymmap+ycNU3jvEcNorXRhNiZ4EBzLusnVoZxsDcIq5Qa5LzCO/ucuBtmOu7oXVNvy0NaUxfAhOrL85mzfcCjZDgueBAkxT+BZ/h066hVajxRJINNwRE1aMHNbftz7GVslVwz4tYl3+NcTuhFMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by PH0PR11MB5878.namprd11.prod.outlook.com
 (2603:10b6:510:14c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 07:41:28 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 07:41:28 +0000
Date: Tue, 29 Sep 2026 00:41:26 -0700
From: Peter Fang <peter.fang@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Tony Lindgren
	<tony.lindgren@linux.intel.com>, Sean Christopherson <seanjc@google.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>
Subject: Re: [PATCH v5 2/6] virt: tdx-guest: Give the Quote buffer an
 explicit type
Message-ID: <artrprfgz7Q5CEz7@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-3-peter.fang@intel.com>
 <bd46aaba-2c07-4b4d-b76a-30a1dff21b0f@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bd46aaba-2c07-4b4d-b76a-30a1dff21b0f@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::34) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|PH0PR11MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: 462b9b83-286d-4a61-4a92-08df1dfd1287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: khMHzGXoxDh7Fki0uoJSTv0s1QrKuvBup0pwv4+damTNXmj5i3Rwtrqfmy2+RNxUwGn2PxiB98jlg7KQNc/pqGEOZlDb+WM8809SA7vh924urqHM2xQkTJHaCu9ifnK4n7Wh0FRAkAdQ3QHmwqtt+ephpjZ2Ibw8b70nIeoU2rCU6kolofuYIFDLpmOKWi+hAC5TYTfv46fbx7zxH1Q7MteRbRUY29kb71ud/4ajS87EH9JBAS7Y5+YNooC2f25WDUAxzO9XkUVvDYT6oPOLbyObvRjiMyoXQweBunj2WG338ohsCW1rAgXcPM90oDyGr+TAe7k5ajKv47bcM32Dft2se991Ra7V7/uLPzgqviyvUb89zhdd2Xzj+q+KOku7U+NsYmkmfkBb9rlEX16A9iw9dbjPyQWFlfrGKVkY8E99y8HO+HrpcL4gpZiCAol6JUCbWiNuieyMZ1+9Kylis1OaJ5Zf73nVlTuSzBC1+nKJRJyyvgo3qLUfa/vRU6NF3vBm9nCCSibSQ0Mb0PnmgBl1+tUOb5Xx/FX+8pguyPZ3oLrzC4IjfHnEC2kVFT6UqPFJqiiou8pGqLu0XkBp/VHeannhrcqX1uqZZqaqVADDZE8Sxh0gdcQf1RpHAJ3iDuQQuEElHTv4PSfOwSVo1+m9z/eLJbLbYLVdDiFpW0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ot34WJbw7w5285NLmtD3KtJupBxsEqLTYbdOzkPdfQxx9sIbRmdTmMNuEcQr?=
 =?us-ascii?Q?/P3m1iCL8qo0AODDpsBG0aO0NMV7IofEkqNkxIrYaxeeOTX/aIWfhtwK/QWD?=
 =?us-ascii?Q?xx7E8DLfibH1U0rIbcs3EuKwXMrqPFrfFXREH7tCfeddLTPNYto+cBGmNbY7?=
 =?us-ascii?Q?IxljJU6CCOneKjh/YYAYpLNPb1awsd5L6BVxVQfQ/hBZS1n8ih3ybAT2BSaB?=
 =?us-ascii?Q?JfFUKrIDkYW11+Vg1fYs2DtGI6IhQMMoY2xYDT7zk6gfrLZSlVejTxvUJmmf?=
 =?us-ascii?Q?wV5Wdiqt5QfjOM1wcjzhtp84/xn0NYoqgf76SksaqNAnwr4lUlQlI646ODvQ?=
 =?us-ascii?Q?dt6P3huZb9DVOIuLaDY8PAbb9oiK7pS+Ih9ntKX5+ik91KYHC5/O5MVeojTg?=
 =?us-ascii?Q?TOmhL7sHiaO9hFVQfmAqcV5xT6FDmt2kB4INEioXOOUgN+6EQU7lxT8OlDw0?=
 =?us-ascii?Q?AZxh/8ZSNS0kUwK3UgW88hE90lDTknovYp1ZIFUbkuFB6CeEcQuPVGl5mFO1?=
 =?us-ascii?Q?HJcpcAkEmBowvrGr5bC0KpcENf77bWepiNcXzwrr3dHnE4SXLlVr8B8vDnZ2?=
 =?us-ascii?Q?N1+vmlTAHHdtZMLRsRwDzd9lB2Q4a7ehfhiWoAAb3wavsGzAEDsVQJzHWzxR?=
 =?us-ascii?Q?Pi8k+2wx21xmI6F3orid6HGy3r/SULR7SXlXYUvWQNlleoPogJnG7ZWaUmDA?=
 =?us-ascii?Q?g2buBoGhxG39EWFpdKCUhRQWpSn9JG1vjuao/3LBNP3iIYSdW41q6r1bt6PL?=
 =?us-ascii?Q?XfkTqgTrCcMcxuPE8tcFbHMVbxOxT1L/AOYE+Md0yBzsEPevAlb67G/ebIR1?=
 =?us-ascii?Q?fs9OkMQdxBrZJHuSfHkrERlajY9nhjASFIn3w/43bUTIDPVS0+W1m17I9brL?=
 =?us-ascii?Q?RpyAMCJWvlakH4ALRKeaV2ciD6SdIHC2uvnNj6jSfcdgWZ600HT7NQGrRvd6?=
 =?us-ascii?Q?746h98t/raHHRPEZT57HOKpLy98Gf/RsPa8QGEfjhF1zzZrFv78MjWHx1gtV?=
 =?us-ascii?Q?kZNO72asneqw2B0DWfaS3XXy8w6b9Xg7ke+o0OChweKcKFjDWYt5uSC0iSz0?=
 =?us-ascii?Q?akvXgzdFtDEy2+2YO8MZSZy8mjVAdxxtbrv6aJRInof+NEgSi1NMGl8tvkl6?=
 =?us-ascii?Q?6mWf8b8nThkC1/K3+JKw45ZzFR2UU6lb6umqX3zHutX8W+4qY0o2kSxkK3Ds?=
 =?us-ascii?Q?yEYx7pCHlQqHP9P86e9xO0oHBMu+shUxxk5gXkuspENFswJwajXhgWF5Z4Bi?=
 =?us-ascii?Q?dv1kIhOaVbsjXHUCND2IHdmi0VqENqu/4CIt4wKhJsWVhBq7FELjUQzW6W3A?=
 =?us-ascii?Q?1SUE2/zM7iTQ9jI8vk+AShrQrkgBRB4IVm8WTq1niejqbpBCQ9YMfiHRMTAV?=
 =?us-ascii?Q?8z9WZ+A3maiTOvy3XX0gRtoPqKTGGVd/Qonk/Gg9fe2GXqk3fmRuYB/BKabs?=
 =?us-ascii?Q?cNwfrrzHvu6C4VniI58sAE8f0NcVMadVF/wKeKd/m6Yjo3CGF3lEup6NdJKR?=
 =?us-ascii?Q?t7b45Aa4E1dagRRzifMGA+i2i9V3xWTfpGt1/YwT6JHj39cDsxQXlh8gqPAF?=
 =?us-ascii?Q?QJxSb4VsL+SL0l8q4+VPluoUT5xPnDGLmAilsoedlO11MDP9W3k5VAIaeMBi?=
 =?us-ascii?Q?FeiFdBWDmSzT8kWJHzRB4kA5rWNO6mONCVqBWgDJk/oT5Scms08LEII8bz+U?=
 =?us-ascii?Q?ukHKvMLdX1H/B8FCyQWfORYb8bUIPJqcU3xs1al6u10VHWX7OXRShxiEqSTD?=
 =?us-ascii?Q?t4Zx/szyww=3D=3D?=
X-Exchange-RoutingPolicyChecked: 2OecawYOvVV9oTG+MFoHFnAIJTlDfmE++5ezeu+nJU1/nyqFShQWDRzQF2p4M7YoQw/lHLxfMaBhGFiLAT/6DGGKQWZ/lAm+Ws51wK8oQcOaOWSQpuajmS5owdRTn+T0wlnLVNDNm7zRJrXxzO2F8yqwsRpi1xtlMlsQgUw1BvuumcG2kBmE0qdD11C+4SUmKLqwCaCDGOF93ZqtXcqC3/stKE0+aS7wsQ3eUSYT/6GU3eh00lERYFfRuYHUi4wjRHfygktSqOU6CRlWUesH0P98+3WCqDMjSI1EpBll03qJjWd8sGh9n+UIPMjCIZrfBHl+S5D2JCEFwsQuPEJZfA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 462b9b83-286d-4a61-4a92-08df1dfd1287
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 07:41:28.5633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hDRzx49J8OjVyStX82Kuzxa8Gw2aScuMLkzCvey7gs9AynOttiHQoQts0duH8flZytmXX/VJPE1nL409FkibQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5878
X-OriginatorOrg: intel.com

On Tue, Sep 29, 2026 at 10:13:32AM +0800, Binbin Wu wrote:
> On 9/28/2026 6:08 PM, Peter Fang wrote:
> > The Quote buffer is always a "struct tdx_quote_buf", but its global
> > pointer is a "void *". A function would have to convert it back to make
> > sense of it.
> > 
> > Declare the global with its actual type, and give it a better name.
> > 
> > This creates variable shadowing in wait_for_quote_completion(), so
> > rename its parameter for clarity.
> > 
> > AI was used under supervision to collect/apply feedback, review code and
> > workshop logs.
> > 
> > Signed-off-by: Peter Fang <peter.fang@intel.com>
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

Thanks Binbin!

> 
> One nit below.
> 
> > ---
> > v5:
> >  - New patch. [Dave]
> > ---
> >  drivers/virt/coco/tdx-guest/tdx-guest.c | 35 ++++++++++++-------------
> >  1 file changed, 17 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> > index d0303e31e816..896eb0a09c4a 100644
> > --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> > +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> > @@ -192,7 +192,7 @@ struct tdx_quote_buf {
> >  };
> >  
> >  /* Quote data buffer */
> 
> The comment should be updated as well.
> 
> "Quote buffer" or "Quote request buffer"?

Hmm... I think with this refactoring, either one becomes kind of
redundant. I was thinking of adding something like "GHCI Quote buffer",
but that's pretty much documented by struct tdx_quote_buf itself.

How about I just drop the comment?

> 
> > -static void *quote_data;
> > +static struct tdx_quote_buf *quote_buf;
> >  
