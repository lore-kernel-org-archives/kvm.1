Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210F837CD53;
	Wed, 18 Mar 2026 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823858; cv=fail; b=JrqPK+BnyQFQUz9DVUCvOYyt78QLOHldoRAYQYnhrQWRf5wLJSBd/4i5E7mGWAVix/LFjHVo3r9J4fWc3uwnMIdWs6J2RAvwD5OVOP5PLYFOOkUg+KDSz7to18poFgMvoVk5fXaD+7DcAgHjzst3sYo6/sbp8bS354Kp4c05z/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823858; c=relaxed/simple;
	bh=g2szorfMEdyuzQsm4Ar6JtERejUeGf4dMCN47Lo8s1M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OpDJOMJVXML85cgDD8Al0p3loJldhakPjxmyrZmFGGotLUX/dZ18IyLpzwLIY2oS+62I8U99s+YapXW65r7kpSOcMzrJ/e7GhousyUdqNo/cdE3ir3y9xlhve3W4vt+5krbFA+t3pcDCkZ6ZA9eFVsDuGvfmIDEnfVmjMxczIpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NiOEB1qI; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NiOEB1qI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773823857; x=1805359857;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=g2szorfMEdyuzQsm4Ar6JtERejUeGf4dMCN47Lo8s1M=;
  b=NiOEB1qIq2XbJMJcIuKgHeXHocJ+FkXA7Nf8a2P5zfP5WAoduy3vQ/13
   7RA3F6XfNZKMSjSbHvXDzY6MPlipC/eXQ+j6mQPnSG3otMB2uTMEJLUUI
   XnG1y5G8ZOiJzRrv4V2+5tUU3sGjAtIBAdD7nGH4JyV9zQEQ7bcCI8sIu
   he2RptJMpuYTx54SacuiIcKLMFWHdlN4MZCCMns9Hk/72TJVCjwBtSCs5
   IpYBMPEK01xVHrpkZK5ZkEyZehSCir2OvKceVbilkufjQKbIYU2NltH1+
   XyublS9lHAmh+3FtWAn2nPOneLFPmJYUhuSPGe3jitFbPu5B+G5rzMnjN
   A==;
X-CSE-ConnectionGUID: K0dbVV3yQ+q4YQI4inpYUg==
X-CSE-MsgGUID: v2hcI/c9SwC0LfLQgO7c+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="75054759"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="75054759"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:50:57 -0700
X-CSE-ConnectionGUID: d5MlUzCGQIqLSwfZp3hwBg==
X-CSE-MsgGUID: szjtHEpGTsq+uohhEGsquQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="247082887"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:50:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 01:50:55 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 01:50:55 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.71)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 01:50:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcknERcoCb0fXymF8iluVBrGArZWX215x0Yre6jpAtzEVYUOOMRGj7NPK1ax5esEHK2/0aPGs3SpRwFQn2zczcMDy8VV3mmKCD+3t0JjqzjlrBg95bo2TXEdCF6YUrkvfjydh10p4KMQiqhNMuSjoUJqNRqfKvzDrIpVQKnXBl0r97yVfkPXUBCbK4jeAx6Qkl8BHgV5MEAzqam3o7HQ7RpX1Q2CcekwtQuGaYBvsZ5duHFiLGsYA8w6+i607/xf92uSaBdj4CN8Yon4dSLql7XGvoCmxh8CltB/qaMkoP5a19QU2tjp4Fl+0pWOSd/RRxNAWxcDHBAxMSgDBbqGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGvFMYmZB2VEHfV/pMYD1J+27jpXcz2nB7MaWFETj2U=;
 b=mk4Low8HaAybRtAM9R1ulet6N0TwmiFlTkQRIOgTP5hlq1c9zlVygRh+7A9VN889muvBfXVQR3cyrbC+orASi5CsU0wtzZT1R1a08imLTI0khr6SGP+tDH2ZdRBPZKzYfr+dGEjSTVAnA84zuKYL4dk/e/T1EzPeOsLXxrkC3keyQvzDPibfy21IJfQHsvDht3Hdi3rno8FqZWhfYgm907qgXu00p5EcvvjzF0G2Lqv30lifsro170ojKppeg7j/5Iw0wzX7dtF2tmX6vNWUtcshR89iE2yQBcxqLGrkxlUQnGKV+hx0251DKA/YQxFJsKXIrT7C1FCrKq4pfUd0rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 DS0PR11MB7960.namprd11.prod.outlook.com (2603:10b6:8:fe::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Wed, 18 Mar 2026 08:50:46 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::fde4:21d1:4d61:92eb]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::fde4:21d1:4d61:92eb%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 08:50:46 +0000
Date: Wed, 18 Mar 2026 16:50:34 +0800
From: Chao Gao <chao.gao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 08/22] x86/virt/seamldr: Allocate and populate a
 module update request
Message-ID: <abpnWkENgaWoofZV@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-9-chao.gao@intel.com>
 <abkvOYQIi2RvEYh8@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abkvOYQIi2RvEYh8@thinkstation>
X-ClientProxiedBy: TPYP295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::14) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|DS0PR11MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 457ead68-5a0d-415f-d37f-08de84cb71e2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1uiZg1nAmj9LsMbPUa2Lk8u77utlXIL9uAA1/pqQ88XEb5GfJ6J3kdpCjrq9oTb4Kc2SqvXr3im75aKyHsQyXdPx52W4Of6X8Qj/zMFiTHvRTpRYG8O1lVAeqNWxbbxlHJrZKEiph4xIlqdeHKE+kuh0NSJ6Pr3fYhpl10xaFljpMswraYapjF53D8112yWFWXRniq9LC6Ir+ctBda48a6kpg1D/SQ++aerb95gCj70FEcr2Z6/XE75n3bU5JWRYLnOCIHieRGs2D7ezl/35tVx01Zxccw5JseNdCQ+ns1wVwLioKCFkP7fljTWotW2bZrxH1kHKLBGY622pU9kLFmHEzCBs43Q+kNMO4u4g5vWRfAEIZkxsF2fJ56IS6dKab7NM4lySqmOmgzL71b+eMwHXmSpw7Ab9b2PrgGZJcN9iikYwttRfMlGKvTt7oPLbu3boO1PzcqIg7eY3CuxM7qxZ/mWcYoVAthX6s5qJe9vUB611IUcIR1Q0LK1C0QS4x/p10twuSfUlDV78naVKhwxnRNIcjVYDtXzqvqPPDiM7UYxBYij2csC5OnC6g1RQPNQLPgSF9vDpnqClB02mhpBC2FEPWNJM5QfVbJJB2ViUB451AU8hmCokR7bOVIvHDS38gCN8IlqXTn9JFfXDyt2NtR5NabDYxTU0Sop9X2oh/S0WiLM2Eg+y2d9u/zVymVBl5jkHgpjyaaEPGU2jB3d9EpEPvyduB/EDEI/NziI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+mHXsBPKPyt81ZGPb0UlEXO7wpB3ZqPBP3aDTkxCU3hGlJ9N2xpZgjUnZ14B?=
 =?us-ascii?Q?hAw/bvRjKJHgfihw5dweZfd2SGOC8nUBbyrqoRa9ImhwozY/KiMVqaHJAopm?=
 =?us-ascii?Q?NYoc7F+T4lQSmbEpFrMDvLhC6qZoKennS6jEMYKLd/goUP8RQ+b8hPjS7HfN?=
 =?us-ascii?Q?J7nINHgyJI0XZw9x03XkfBJcyh15n8R09v6RUUPthdmSdAopIMqOpRA5vyp6?=
 =?us-ascii?Q?rcIU3bnM26dF/7yZnZ+kJ3yIpUz5+fkPEVZiyly27UM5MbTEwN3Wmx5hhlvR?=
 =?us-ascii?Q?BiayeLfFT0Kxxv9dxGsF82u3BXkwmOkT+PIokHb6YJWKhC8fpQMAJ9WYEpB2?=
 =?us-ascii?Q?tQcJmwmIgcdBL4aR+rbuEFulBQqH1JbCigAYyggk4oO12EeXkFSRo7azT7yH?=
 =?us-ascii?Q?tdSXANqfX610M0zRMckpSuZ9A64g6kai0qDlpYmHjhoNINcMbnfuoWtcmPVs?=
 =?us-ascii?Q?4sPWBXg6vQgPFr+73fbhIBlrKyxAuhVY+N5QcdQyOPfyNh9si4JtZnoQy7pm?=
 =?us-ascii?Q?kHaBWtdFGbHZ8Zi7iFGd8Z16SLBXCMd7mvUbxriu2k0xbbAn0tKcmj979wf5?=
 =?us-ascii?Q?zORgQYnIzrvQxqzufC/kJ8MX91d30TC8GllV9HC5xb2kigwUt0FV9m8ucm9H?=
 =?us-ascii?Q?flJ1UicQ71JSRuN+tjacsvyO4urByoBX6BXGNfByivsT3YsuoJrzDvroKzw4?=
 =?us-ascii?Q?+bBtfJiRNEANoKLXOUNEMOcxcC31N0Ihmhh+ABFVLyeizGk1XUoInd87pDKE?=
 =?us-ascii?Q?obaGoLKMsWenwRu65+T9aivN/o4/9/7T0GxHTVvsNBQFffyrke5OFfXeU5dm?=
 =?us-ascii?Q?kmx/0q3mPfLA2oyiuvv8qkpGCecK3OwG8Qj6yUUVD4VE/FkHuemOA4t+3w53?=
 =?us-ascii?Q?5XVC+Y/+ppB+cHjm2CZOGCWMsOnXzzsNJajXjWlTqgS5IBnXQG99xqU4bYlY?=
 =?us-ascii?Q?gecPbaECbWmJQ+GYgmdGJwO1/Cq6bJlNqXibJgNLUtNdLIFHqgDopGeLJUwz?=
 =?us-ascii?Q?anwx4MCEW2/VvChp/TyJ2ZgqDw5dLdvT+SRezZKKq1/cIIMaIrYTRhgpNb9Y?=
 =?us-ascii?Q?Ce7OTEmH8YelledxAfSrQL2lzQKODWtIStMng3L0TCSsA/QWQRTWSGhtAlAW?=
 =?us-ascii?Q?Qao+2+yykmAGHJLN6StUgivwd+lLEaRfqXlrf8d7Sxz6lit4+lFZnOafOkxK?=
 =?us-ascii?Q?dO6OYb/ivDSi272Q2dda5GK5yJ/SSOe4DgQoYodOR21lpTF62h26OM8v5NEj?=
 =?us-ascii?Q?uuucKF1tXN+M/iMjH0vTiRnH9ch2BwArLsu7ERfZlwr6NIBQBbPKaajbLFmx?=
 =?us-ascii?Q?/5/+qguTDOEHhkgJTfRNnQn/srzRRXKi5G8zQLzg5IQlwHH6OvgK3kNNWWay?=
 =?us-ascii?Q?hKlgDAw3ZAfdCqv/VmCNIoVl6nb0S6/fLtWC5XSlhqUcre2XdnEbQMl6iBm5?=
 =?us-ascii?Q?gPeuhtEPBZEEERsZdqkBZHZ8s1K11qN971O4jnFIKuydNyemqjDw4eQGqUcA?=
 =?us-ascii?Q?9cxUQjV5svn3QVQllevvhqlbb0V2DAJnEFk0BxWr6BYnGKYIxxs1ynMZ56Kw?=
 =?us-ascii?Q?zE/Yl1DPO1uC+jLND5CWVz6g8Me5LQWy5PnvHKWgKVd4a1iUHVfmzR9OB8Gc?=
 =?us-ascii?Q?RiaZ4ymnc/q3A6wMgsCP5YzPa7/bbNQPst7yXNXqo7PhR6z9554NydwAyIj7?=
 =?us-ascii?Q?5tE5FNugpotD/lgEBjJX/Mfzdf8N6xKT/mDve2BR7WwGw3SWl317lWxSU7ZW?=
 =?us-ascii?Q?6UzJ4QScdQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: QYS4NJKZjhvlHx2tq/Tm53kq/b7uiVFk6h6DMap7SSk4dLocwXkM+igzRx+MNF1jTz+NntlVUvKzO/dbaec5UN8GzeDrYAj5U8VepkjaqL7a4lJ6SauV4lmTJkW3QN6H4EBztddELGDTa4mwBuNrW4TIMoWk6HT6ixHNGkpwqdmadpykZ3HWA6A5mghJf29/QUip2vclIdJVF7At7zrUmjNLbNjRmmsf1USedD8xp2cFmyhGiHqXN5YMoW5xhiCSTiwq2r5/InyS2xYbAbysFlQtt4BKbYMEKmNf4+68EEpaml8Yqf3OvhNMOkTScpC0p0rMKe/zJ5pn+RF166jK1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 457ead68-5a0d-415f-d37f-08de84cb71e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:50:46.0277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZOcu5GXC+hMcu0YLweTeLS4DV6JkPQNFh8p+3h1Clxe9QZ49RqosjmKwE+DuCnCaNOFqB6kvkFcNmFOyytDsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7960
X-OriginatorOrg: intel.com

>> +	ptr = sig;
>> +	for (i = 0; i < sig_size / SZ_4K; i++) {
>> +		/*
>> +		 * Don't assume @sig is page-aligned although it is 4KB-aligned.
>> +		 * Always add the in-page offset to get the physical address.
>> +		 */
>
>I don't follow this. If @sig is 4k aligned in VA, it is page aligned.

Dan's concern was that PAGE_SIZE is not guaranteed to be 4096.

I agree that PAGE_SIZE is 4K on x86 today. But to address that concern, I saw
two options:

  1. Add WARN_ON_ONCE(PAGE_SIZE != SZ_4K), or
  2. Handle it as in the code above.

I didn't find existing code using option 1 in x86, so I chose option 2.

>
>If you want to handle case when @sig is not 4k aligned, than this is
>broken. You need to bump ptr to the next 4k boundary, not by 4k.

@sig is 4KB aligned.

<snip>

>> +static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
>> +{
>> +	const struct tdx_blob *blob = (const void *)data;
>> +	int module_size, sig_size;
>> +	const void *sig, *module;
>> +
>> +	/* Ensure the size is valid otherwise reading any field from the blob may overflow. */
>> +	if (size <= sizeof(struct tdx_blob) || size <= blob->offset_of_module)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (blob->version != TDX_BLOB_VERSION_1) {
>> +		pr_err("unsupported blob version: %x\n", blob->version);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	/* Split the blob into a sigstruct and a module. */
>> +	sig		= blob->data;
>> +	sig_size	= blob->offset_of_module - sizeof(struct tdx_blob);
>> +	module		= data + blob->offset_of_module;
>> +	module_size	= size - blob->offset_of_module;
>> +
>> +	if (sig_size <= 0 || module_size <= 0 || blob->length != size)
>> +		return ERR_PTR(-EINVAL);
>
>Maybe add a comment somewhere that block->offset_of_module is relative
>to start of struct tdx_blob, not blob->data and blob->length includes
>length of struct tdx_blob.
>
>It can be either way and it is better to give a reader a hint.

Sure. Will do.
