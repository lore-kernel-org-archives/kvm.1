Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21F0395AE4;
	Sun, 14 Jun 2026 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781436994; cv=fail; b=TR7dBl/Ldp1XzCAum537HvJi9m5phy7N46G1okTvp4yMQZ0IgIsHbJ5kFbJO2IciGyiXqaAW4ItG010w1znG302qMQXzTUM4bGXPEWW3tXiFTnPefxvTsj+rlqvhnDAJiZ96ozs1qdD/YHXihW3oHEL6g0VmT7Uawin76At7NmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781436994; c=relaxed/simple;
	bh=7lYcEeccVUlW68nJYdQL2AG/dnrLhNHDZNZWkyYOdIA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jmwv/ejhlcckpj5APYqQxQMfVFeecLwayZ5kxKt+B8DNHuY7IIAch2gQfrYwMoHa5NEOlagBLrOS6sf714M7PdqY1b90qY4Ytc0DWgNN++wcXACam8lia6ZbEuTHOgCQ9FJtj+0kewSRONgItF4jq5VRbUWMH90rU323/4J7Tq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPCsqjmn; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPCsqjmn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781436993; x=1812972993;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7lYcEeccVUlW68nJYdQL2AG/dnrLhNHDZNZWkyYOdIA=;
  b=bPCsqjmnTRH+06TmJJ5mA0HR94Eb9nwetGHUqwnBMU0r42HA7eZUL/aU
   4/olUYgkZz+JUxb3eDSetq0+nutWaTwdNXl7pIzlSHIakgFIKO+DebC/4
   lu4AWVbTXa6BmdHWsk2JhmZeVZZZlplvnjxlQZk9u9UxdPpeoOKuM4LL/
   dKyY8Eg4WHu6phIeWTI0ovMBeKOOW3lPQkIR2F3FSso8202oCOno2vOfw
   hEawJ/+eDJalSV+aOlTCeH8sedckzPaAdLBhNsosw/3/7g8vprzlhfDVo
   F8DZ0O02Mj5ZI6sxZXn9p3mK6x60zZh4pX5vgM+xijxeoWv2GQJH/wz5x
   w==;
X-CSE-ConnectionGUID: YAv8QyaURnOUD+2jjRodjw==
X-CSE-MsgGUID: VifVqEptTaeJ4xdIxRhULQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="92523485"
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="92523485"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 04:36:32 -0700
X-CSE-ConnectionGUID: 2Y0fSlq3TKOZ3CLt1oCMBw==
X-CSE-MsgGUID: zFq5z+fiRMW0pmcqHx7VpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="240875513"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 04:36:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 04:36:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 04:36:31 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.33)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 04:36:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Saq6Ufru3uh2dvpE+YS0bSlcmM9sUL/WpHKrzW3Vz+2Z3E8u8J61RzM0S4mFSe+gJBoMdCAyvyfCHSqilQUfeFEBqAy3gSyty5aBLc+czXGKrBjedI+89vxWpLDUDAdaZ+DufrC1rSY6hT8sJ3YCaPjDhTs49Rb3wzW1Hm2gTUeLvmxECuF0Rky8z72UEmpHNS2ye547lPeGQWjLhmk17ybwbkQ5Xh642xUvNPzfj3uAoYHRn/o5OJ6vsTMCizPTkhRjn6M4HaOaKO76Gd4ZB1vuUykM7Hm5sCuAQTygyAxYSfu1h3MCiwwbuYafPMxRVGy5F0hkTlrpKsT9TQ+S4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWbTFWNb4AhWN3rcCeR+reNTewb0xOp06QsnT4W+oCE=;
 b=vJfEkuvvFAUicjniMM1MliLv9hr2u5kFdL4va/kynwAcmhpHQjApVxg4nM7WXQ7wyBJyLKz3/XMcme0YTRI5PgS6XHmz/kBQs8GEWuLNPs64X2SalpAg8G611W6f3Qtby/pF8EJit1iZsYYvEdqgvRgVW788qhJPtMMcJqnaS7Sd8jgAacaV5sXvyjz7V1fdrZeg0JKEQ9bLBCk7nD/91Sjjqg64kN/fjbgzNpK1PFdhPsXEiO2Zfr5/02CtzaMbnqC3yk3+gnf7PBXkCj9td3PPYv9FNeTaNhXVHQRYgoZshhJpFnZ4RJeo5rYHpHNTSaiOOwtjyiZP1rnU87UGwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SA2PR11MB5131.namprd11.prod.outlook.com (2603:10b6:806:116::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.17; Sun, 14 Jun
 2026 11:36:27 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 11:36:27 +0000
Date: Sun, 14 Jun 2026 04:36:26 -0700
From: Peter Fang <peter.fang@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<sohil.mehta@intel.com>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <xiaoyao.li@intel.com>
Subject: Re: [RFC PATCH 09/15] x86/virt/tdx: Add interface to generate a Quote
Message-ID: <20260614113626.GH3200182@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-10-yilun.xu@linux.intel.com>
 <7c7d21c6-1f8a-42c6-a950-8fd61d702679@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7c7d21c6-1f8a-42c6-a950-8fd61d702679@intel.com>
X-ClientProxiedBy: SJ0PR05CA0129.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::14) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SA2PR11MB5131:EE_
X-MS-Office365-Filtering-Correlation-Id: 836c0284-f316-4f37-11ee-08deca092bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 6lNjwaKV0uUfqdNRjVL7xa+K9bzIpks2bD51r4/H0OnYuKyyGrmK7F/8SY0GHaF/bR47P5QZKZnPked/EPimIjM0h6/jpatVrlSMg5w4cUDIgpc8fCpEn6JAd4j68+B/bjGwdLSCYPTOTVBDshsyuFCzPt6gns/XDdlKpjGUIbSuFj912LvI1UHoiBzH3MFnCH5SIP7nBXv4FAZO/pG56uRLIqis5iOMgYDl2P+c86kGG8jkVuVvEeXqCl0SP3UZqUtw4YGN5fDOzAQt0Gw0xtv60e1dGwh4cwxCI7VU2BUegDkidc+0mPhclnYNNka8FW3RPoJtwK4f6qOtcxrs9hOpxWhJrVtmN8JIgdEst9lh7lnxfOCH6rRkECqMbWQ+htpYcS1HjVgsYPh8uKGPwQrx+SLlpE+3pHZrqY/ViLurTPfTwtdO4k0bzCcOxfmzG0GCQwpdY72C6Z0HMrxj1fwXwDzNm+3pyli+DdB1PGG0pkUuLc9ZTCQIFmcSSDW1EPE5r1Eak2UWsxa42tp8k+4r0GI7bQikIVz8sLr+R2lRXsRzGURvHkPcVF4yGgaofLoz5kWfLKXyRFSHGX+4u2brZeHToA2QgbejoyyCscX48QY9YiJ2RQidfmObPFlqTtu7bXBh2G1LPL8J1GIOq1McMP3ATY6pMo4HjqFV+0vZm/jIRbNQCWdVsbooo9gN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g/zxlV3kHkXdBKro1nEW0ofuZVbHGqTHcaULGwLUylB+LChLg+5UKgRIm2Ew?=
 =?us-ascii?Q?ucygXjeWUhLSqcEMv9YEb/pSEJBQ+3VQwQ5rM8M+X7lxEn83mqE0Jq+RWBuY?=
 =?us-ascii?Q?7CgvpEWWy/+ssuFQQyFGp8l/7hZSbAWnyFUtzgLzyHxQgfvV4GLnsroA5hhQ?=
 =?us-ascii?Q?SRHl/kep10D+xiC8kIV3Xw53lcMyY35cIsQh0tE2bv4nFOSusvyZHLrMEGhG?=
 =?us-ascii?Q?MYXZzmmaAyhsB4DwMzlBInTOlwysUvl1kym+XHjSHF6fH5DHrXAmPT9B6M+a?=
 =?us-ascii?Q?vJar5+GPhJW4u6K7AvqNBm4P2mty/7HzlTY2e6TDmchwjnDfhsP8nLF3p8Tl?=
 =?us-ascii?Q?psEn3hglgvKfkpatbqgqRNk6GKw8hBO8mJphcLnQcLVmxGWd+35J63JF3ArY?=
 =?us-ascii?Q?9u5SW2wTt8ZJdyn1TKs1t3cYdiz1tPAvQFHo0CqSbmxrxMADYC2L3L/OSf5d?=
 =?us-ascii?Q?TE0yDK7Ky2Ws4kvf1sW5yZiuQiu9bizh25pA3kFcT+6EaVMgRJjqbkokELKo?=
 =?us-ascii?Q?NTbZzSlTfP2o17JeCd9cSYyfT0ugQAofC9RgAN47Tkdqipevgg9laj7/67e6?=
 =?us-ascii?Q?0etflWN6vqbYSHmSstzGS/Exkkfb3G4k/90RvSt7HY6V/FPX8XW6YA8VwV6X?=
 =?us-ascii?Q?WVuzyAGQj6hYRpf7XR6czZkmmKDJCkbzubPhD3I0/Gmh3oZxU8QVYt8E2x6k?=
 =?us-ascii?Q?qoSE4ehdexkEEtNaspZeuLES67bxVAXZpAiaqVnVL66BDtcvzj7/8QKwtza8?=
 =?us-ascii?Q?Sai5r9ZicK+n63SifwsyO1UNSqkZWWMT9UHn1RkAoRaj3k0RqZnxCpOnAUuw?=
 =?us-ascii?Q?AAC++41NsNuosJq7bRtADPx0FT5QPG44/+bSizSU5GO/AQtHyFkxR6sVSWJJ?=
 =?us-ascii?Q?qFaoaKQSU8g/0Hxzre+DvXqpkMMRpwlOS5aS09dd9VT8zRdCriDaxy3rlZFc?=
 =?us-ascii?Q?Iu3OFVe+FKwRCq8HPWr1Ty0pqnm/Nk4dnfrEpckkoMx/8N49vOpriUc1GBEE?=
 =?us-ascii?Q?3LMRpwEYW4yRKxd6iczRRMpAf0R1lPreFLwe9dzyEMvz9yh7a5KHZL0AMk+E?=
 =?us-ascii?Q?eMj4iNj2XFQdcZg+a4KBHeVIyvhbnQ4McPYaCrtrDlUjJTExqi9Ztsw++/yF?=
 =?us-ascii?Q?jSQTL/B++9WYhTLIDPU0gV1wDJTMot7QxPuWin+l8RLcZXJSB6WFHsp6KUyS?=
 =?us-ascii?Q?Z5HR7epqjkyk3cK7P+2n5vSTEQiW3jrsF6jPWVtBPbaeu6W+XybUjyUppz/C?=
 =?us-ascii?Q?ebkLyMzHTR+zU1EmPU+uRQd2L4P1ru0nxdhb8DxvjvPVpJI+4VGL5uQgHZVq?=
 =?us-ascii?Q?3FjHAa5GrzddRCzYNJl91olHskA3ntc9zhxhK+JazIwRB7XSsVJ5bMSpaC9X?=
 =?us-ascii?Q?UEpYLrDqeAqqG4ini3oSAi0/WKPxL/dWG5K1DU2L1yAkMFg/yK5KzeFXGknn?=
 =?us-ascii?Q?gEUd3djcxX5BPDIF4+xa5I5pOFSDUw1ygGtmI1Ea2rp6T3nXIc+Ku7DQTmeQ?=
 =?us-ascii?Q?X09tbM6E5czGVOcDODuhEhuWX35eL35umz+gjWP1n0HdgPDXSBS29ivUCwKl?=
 =?us-ascii?Q?Z7FUQLnhjQKTfyuZYpyGowBK4rDQHe6l4qjmKMBb0Q3aUEtXu8LULim02hgl?=
 =?us-ascii?Q?lqE0nyUK48gHbmsb1d9p6mtQDlNOr3V76wENrl8/N52rkEFMK2y8iP+WqY9V?=
 =?us-ascii?Q?VkR1IfHp28fuHjl8aqQbdn9Mg5Z/w4zz6V53+SJwpfciRN2UUoe1/T99+QYa?=
 =?us-ascii?Q?PYRmuqc38A=3D=3D?=
X-Exchange-RoutingPolicyChecked: oSH2IoVSlkp1rP/tCPB9WhfP8lIDzwzTrKmPxVt4H7zz4mGj5Q8mUOFIH/hmIS7NdmLtfchodRljIrkJ49v5H/l1Rz6xRd2xSP94HreOd4P033en/3Ix9B5IkygADAH9bR9R5qPvab6AAeh4X3LB6m1vszZYGjWGjIS6iDLBiVcVPAeEDFxmIIaovLvhdGGPfdmdEYHN/y4P4h4DK1BMOZAuTIY93yvnhiklvLsujA1B2vRi6sbf1TdCP+hy5Di8IL7kaJWh8fXWgCjVd2WLNy4kgwNLAhwhSyQM+E1bUX/XFvFzvEfVbl6tf9Pc/gEym9cHrfaP/Ecpxb5FCMN4/w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 836c0284-f316-4f37-11ee-08deca092bcc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 11:36:27.3116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3PQOprftlJQ6qT+UBDENEzzUmVOUqyNg2UTglc7Y6IqZmiMPAGUlnb196+kEHRR9RBBH2i9nXo9LxHV7hj1YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5131
X-OriginatorOrg: intel.com

On Thu, Jun 11, 2026 at 08:15:50PM +0300, Adrian Hunter wrote:
> On 22/05/2026 06:41, Xu Yilun wrote:
> > From: Peter Fang <peter.fang@intel.com>
> > 
> > Use the TDX Quoting extension's TDH.QUOTE.GET SEAMCALL to generate a
> > Quote. Since the interface is shared across all KVM instances,
> > serialize access to the SEAMCALL buffer with a mutex.
> 
> Isn't the concurrency configurable, so supporting only 1 instance
> is a decision of the software implementation, not a TDX limitation?

Ah yes, I should document that. I'll put that in the patch log.

> 
> > +static u64 tdx_quote_get(struct tdx_td *td, u64 in_data_pa, u64 in_data_len,
> > +			 u64 hpa_list_pa, u64 total_len, u64 *quote_len)
> > +{
> > +	struct tdx_module_args args = {
> > +		.rcx = tdx_tdr_pa(td),
> > +		/* Don't bother specifying the quote id */
> 
> Need to explain why

Will do. It's because we use whatever the default Quote ID is.

> 
> ...
> 
> > +	r = tdx_quote_get(td, quote_data.hpa_list[0], (u64)in_data_len,
> > +			  quote_data.hpa_list_pa, quote_data.buf_len, &out_len);
> > +	if (r || !out_len || out_len > quote_data.buf_len)
> 
> Is r != TDX_SUCCESS more consistent

Yep I can fix that. Thanks.

> 
