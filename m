Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC412367CF;
	Tue, 17 Mar 2026 01:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773709572; cv=fail; b=evTBXHovj67jPXg5b6WDB2x6fc4ESMNBaYjnVz8eY8YdLQ3k/dCpmqK74TlCqyRab0rbnuLijao8vwf6u3tN4Gb1G8sKOw2G0Vp5g+7+4emLUWHNPMFxFNh/qc+1088Pz2zyuXX+SoxpiU85OraujkoVXj3UMfLaLKd6fS+PuiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773709572; c=relaxed/simple;
	bh=qpPZgExkzBtH3lMPOIEQIri4X1TMvNbG7ggZBb1QXEA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rSPS8oAadsU+zbE+VMt3qMkQjYohamKGQlyK5jW0f9ZhvHIK/vk1J8lRxb4ZICNCtlsYVpp+2Pg/hUmNPGZmXlxbL11usBKqkcqDVPjPo13zWI5iy8AV0XFrCyORL9koJbJgWuuny1fgj9Y7qpQ1+i7/X0WqRU+g00O4sq6/7sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6p+XC3U; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6p+XC3U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773709572; x=1805245572;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qpPZgExkzBtH3lMPOIEQIri4X1TMvNbG7ggZBb1QXEA=;
  b=i6p+XC3UvFD9DVQdjEDOi+sF1Xfk0C6zU3ZxERlIsy4FFuxVJyeu3Z2S
   Xy2nvrls7y0CW0v+HzlS+s+t2X3Ujf8v86l7rvAtfuU1zkdvvH3Ig0aVH
   g/1YkBN9U7X1KVXk58pfo0h85m+WAn4pRPo4od7KndIBm+cDwYhaduLWF
   F0tAmuYSpDOcU5hznAFhbBNuoa47gsCYrYi8xC0oJY/BTPqwqlizeMjnE
   W7uuohEktRpkeWtVzJMq6bR3oijGO/v6V6W1DDsx5D0Td5wOl/wW7mQUZ
   ztTtKevR1toZ2zlCYVRTjOQFVs15Qwo0/JubNRCSSUU07PKwIVSUznJ/k
   w==;
X-CSE-ConnectionGUID: cw0sgFMSSsyZvVYPLMyONQ==
X-CSE-MsgGUID: z//4HPBLSHS0hj3VyevhHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74439344"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74439344"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 18:06:11 -0700
X-CSE-ConnectionGUID: TBUxLnL/RkujdRGHKgToiw==
X-CSE-MsgGUID: vNg/BWyjQLS2JN5vfK8cJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="219237535"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 18:06:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 18:06:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 18:06:09 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 18:06:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wo/1UPguxhke3DNfs9xqMMN9+oB54pMPU2q0lWfjBQVvnUpPTTIFlUcisC9BXbpKS7pp56+B4VoWWzA+23aTN+RMyEela5jUHWd6WFptqvguxjKM3XsMcW2QWEw47VqIsb8DD80SnVSk3KrcYYU4nhZuP6rWqU4D22rgdIaZ2eZ1/PvmPUxGB/K2/1B5yOBWXfVPEZKXjCKQIgyX4Rhpusv1I7YOSd5nwxacBFEZFlRQpZK/XNJVWlwcYOxzSqFe5z8o6ncDXI981QRzEC9KPanyn342RUFwJemGy/H4aTRA+Q9shCqEUjit4/N5VeMEsnf0qjs4yzb2qttisHO2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdnztJ+hdRBwflLpmTdeHUU8KxC0jdNzfQoVvzY2DdU=;
 b=HlWC1BMWyCf5zJMdaAcwFXnNo9JXG2l/JoTQyQYhVd2W4rM3nXUCSUPF84sQbtbkwbDv9ZL/6C2eCDiy5gd5Qwpx+1XYL4MDk+hI6gADypAl8o4xlihW5/8wO4MprRjBLsRz1YGUunaE2cmRI45Yc/RAHRTekm+2h33xQB9Q77z7qLNDjbz7I+/a4cQtDggLyHzif7Yah13y2rgEuBFimO12FaMVGkyJ5R2FHLO6pg5Do529gQAnjhZ0M9eVIjiqzs92LPOoFk03+9CTMpuqfVbj6tpLH2nSKMfrb0dOdlua0+ed1M5kty/gucazlkoBUETqyv+g3B5ZQPhSjV0WrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by IA1PR11MB8197.namprd11.prod.outlook.com (2603:10b6:208:446::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 01:06:05 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 01:06:05 +0000
Date: Tue, 17 Mar 2026 09:05:50 +0800
From: Chao Gao <chao.gao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>, Farrah Chen
	<farrah.chen@intel.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H.
 Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 05/22] x86/virt/seamldr: Retrieve P-SEAMLDR information
Message-ID: <abio7iAJhGdeEEcE@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-6-chao.gao@intel.com>
 <abgBFmEhlsdmxa1k@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abgBFmEhlsdmxa1k@thinkstation>
X-ClientProxiedBy: KUZPR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:d10:30::12) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|IA1PR11MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 06933a41-c8a9-49d7-4a7d-08de83c15d41
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: t8Ff0wniC4UP8wVBc756ZoNRvXrbJF35gt1Gz5outm5SWUT2GNZbYksctNpGwIuoDc0JpDJMYOHcnxcoLCrUQhteqWFr9rYW5CEPqNI4a68JN3jrsypiJJzSKdqSCOAcuTw/RQJKvb54/a1fKV/lMq4fBt5NPtJQkNxwWU+YdPBZOBsB2XK66R9o6RkmOYxFexbQnKJiUihZ+uoYJ4/a4sPs/WhD5ywxaisQFmJf5w53JarmQuRe6ubyyf0rzJSJ4GbOGb3Vqw9QqcrwnRROE28y8rNKHxzgKrQXBD01r4DvNfPOvV59g5jZjkNVxeKuZNJrf/DBUSFR9PjPsyBdLW5s4O6P039l9fWwyQhwOowrj5EfO9MfaIK9DXADvQRL2ogS0oY/i+LKE2RzkZAjW/JjKxA73dcC4EYoBeaqWhydxvwDR2a8Tihmtuoptff/V48re5tjRRu3jwzB+1AjeLTc4okzqERaoelLTYgpZxTJvZOC4s8u4mR4jJ3CRiRLtJ0ti1Jc3DO8qPpYlAzb6b+XS59IbPy4C47QS2heW+zFK0iFLBYqxkxPcfqXWmckq8Dj1HhBp7NlZFc2kYTLiX6LrXmCDkJuUoiVXrXLklDQIE8Jv1nLeQsX44o/9j4tJ1V+Hze5nq6/GXMu+FTbSoHccKEj4sKJQdssTmq7eUQvrBir7T+W8zrK4Xza4x81XnBccoNJozTMoymoD9dvOd2OXCTkTcEo3aa7UtGod08=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OzwF5R3ePGJakfyZWU4expUriDt92JPW30l/+TCgRhtQmgoA/9Uz46vBBIN8?=
 =?us-ascii?Q?FfKEabETmT7dJGQBjm/noP66EfJVHflX7DLQgBA5CAW5G3NJCfd8uMC5KmX3?=
 =?us-ascii?Q?rimmrOiYGwF67SIPEBWWxtO1lC/HQ2PoUZ8ljuxEnX2O3Y2YMqPdWyxeG2Ba?=
 =?us-ascii?Q?g4zzTStSkMuf+t3u7SZCbxW9wHl8UUmOkNa8R+GK9GJvXkULghE5WvHWCL2x?=
 =?us-ascii?Q?4b5dU7MyDf/Tz1K4moT4qQoSxdpHXh4Dcs9LP3S91R2eSIMjWxupNVGUGeS9?=
 =?us-ascii?Q?yfSEqA6BHDOYb+/5GXzI+2whNvSQHvFqazwQI5/04bduTi0rA4xQC/vTTqoO?=
 =?us-ascii?Q?npuJA6Px46NT0u1Ws6Tseotf3suxW+NRbhn/4anxiwNKYdQsKuf4Kaqy66hN?=
 =?us-ascii?Q?0hrtUmPLDw8qYVjINRHqfJyi0QOHYN0d6i0YSlX6XyTYMN0uobbKVsuSpF1G?=
 =?us-ascii?Q?GMoqlhzXeoHwOo0hb3yu3itYQCewHlYW5vLFPPeiHRpHgccOhuoN+nIJ9O3R?=
 =?us-ascii?Q?UXs5q7R5EBkqYY1fsgdUMT1sa0ep1YyGLvxhrymeaYjWKPonTco8fmhNZ2pf?=
 =?us-ascii?Q?eB0O2oIVnUMwN00ikQJayXsfaVCQuiA00u6F0ZCub0fwR61GlM27YU58yAUo?=
 =?us-ascii?Q?F5aKFY8Ai85exqZELDZQa4k7Vro4K3ryEBhCKNmTk3DW/94M8Xx9p6+M8FJ+?=
 =?us-ascii?Q?4axN0EFPDx1VflpkXu+D87EaBvB98215Bp2eSiDmV9NgeQ9sb4SFc3UzpSxz?=
 =?us-ascii?Q?Og0XHOUJayssMqWzgsVGtZBh2W7RX5QWr97L2UITXb4Tgs3/b3CHGFqDs/JB?=
 =?us-ascii?Q?4RJBFMJUNoE4pdNJlMRjALGrMEvSsPNy696KDQyTaHl9pFxXJEEMAIyiW3ez?=
 =?us-ascii?Q?SV1Tzw6T6bpW9XBwr/STUae9HzwD5nYxZjZLDexvALFUnNOu1Ta4QI/RVnEj?=
 =?us-ascii?Q?LkGcW8BhAA34BaFmPKSa1j+lXfVfbaF4cffPBR3hMLzzqBZJ6kS8bjefBvPA?=
 =?us-ascii?Q?FdjuRXXTvGkLrShjieMGtfrai90QbpGvu0AFosM/g7lDUqQzMgYA3D8J86ON?=
 =?us-ascii?Q?/zYv36FuqZyYGSSfKdJ2NGApA03m6ghrGpfZIrr9VwX2TaR6y1fqIRERa/Pf?=
 =?us-ascii?Q?YruK7l7Z9VAEyXexuJ5J0YbKmjgpWd6vDxPwGyh0mdMy0lFB5JDpmNBDHoMd?=
 =?us-ascii?Q?Oh5vct8rJskErfYaZ0A2R0dyRKT+5Gt8J47D/4G0xjtBCe3+8vGi1VSMVehr?=
 =?us-ascii?Q?gxyOjNa2YJVqQnT+bEwGX76OK9LL0xsMUoUqemgHPlLqhmMPQ6s9Uk08uskq?=
 =?us-ascii?Q?pW9uhCl93XtVg5m+TN9R+VZ2KElmNHoOfk2vsbsycirgBhcoAxSD8kpljWyQ?=
 =?us-ascii?Q?CDc0J9rf26Tkmm9EdYRa9VAt2ClqMgC2euVgxMBSWb/ixO8jnPs81NlA4bbU?=
 =?us-ascii?Q?qCGDtmQEbqjAlFggF65ywgEkSIRkZWXnz4+mA/wUy/PBIS/n6y4O6KbDS0Ph?=
 =?us-ascii?Q?ceKUUjHbdvkHTBFZzRYEhcr0hE86/W7vigqRA6kspphKB4PWQJJjgNgyp4NL?=
 =?us-ascii?Q?ebziMrsMcwU9sde3fm9Jq4hdldQGyqpD7XN9lH4qCKVijBqTL8C1eaLQKqkT?=
 =?us-ascii?Q?5O4B62kL2PmDOFQpZ9+JkQeWz/Nr605pvC0j+SV0KBVeNCjkquw9WQ1UmRWO?=
 =?us-ascii?Q?r+7fsNqLsqeNnP0+2LgsvXPdXbhSn4XORXU4+rId2ok7lV8QTMsf/JdJcphY?=
 =?us-ascii?Q?zBt35vCIMg=3D=3D?=
X-Exchange-RoutingPolicyChecked: Zt5MXcWx+kGL/IO//Rjh716jXG9fDBSo2C6FrwT5WyeQFqGBagJvdPHKuIQq5DWahz57imIMEJXWDPdbanC8svzcGld3rxqhBmvZp2zRqQOqmtWX9AuAN33HPQMOoFuaYr2Z1A+pfWLmTOLIqy//xSCMAOHx8OuiMPLvP4YlDLhTYp+em1ffFH1tJ081cS96dlocFXOkeI9MuHJgQ970h57AK+51AWnvAQZ56EK/52g2V2yYGxClYXXrVF3IbhIlFhwgr63v5brnAMduDzSq5Ze/yHHlgtgg/eFVGGXu2EVWJiCkE0VnSm2Stpggybl68BS2NSvEhw2V0/vETB0cdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 06933a41-c8a9-49d7-4a7d-08de83c15d41
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 01:06:05.3747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pr5Unog/CEyZKwpY+ELZb97YyC3hINoC7PPwxBIR8kHmxQP79S07vpdF/G7WjpPJMTdSmqpSV1Z8U+TPTdkNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8197
X-OriginatorOrg: intel.com

>> +
>> +int seamldr_get_info(struct seamldr_info *seamldr_info)
>> +{
>> +	/*
>> +	 * Use slow_virt_to_phys() since @seamldr_info may be allocated on
>> +	 * the stack.
>> +	 */
>> +	struct tdx_module_args args = { .rcx = slow_virt_to_phys(seamldr_info) };
>> +
>> +	return seamldr_call(P_SEAMLDR_INFO, &args);
>
>On what condition this information can change?

After each update, the num_remaining_updates field will change.

>
>I see the next patch calls this on every _show operation. Would we
>benefit from caching the response?

Yes, caching would save a few cycles, but adds complexity. we'd need to keep
the cache synchronized and invalidate it when values change, likely requiring
additional state tracking.

Dave recommended allocating the structure on the stack [*] when I raised the
caching idea.

This isn't a hot path, so I prefer keeping it "simple and stupid".

[*]: https://lore.kernel.org/all/56a62e54-59f7-4423-9f01-4472d5c3815d@intel.com/

>
>> +}
>> +EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
>> -- 
>> 2.47.3
>> 
>
>-- 
>  Kiryl Shutsemau / Kirill A. Shutemov
