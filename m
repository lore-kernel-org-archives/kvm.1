Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABAF3B71A2;
	Mon,  6 Jul 2026 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344184; cv=fail; b=tydxvSBrP0djr+oA/HdnXiFXdid7do2oVyX2QmZnIkuzn+MRYwV7v4dd6G9xCgjPaOsncx4JSrnD3wdpkEhuydzPzw64N5FY2JHZWJ4/j1xViQPqlKuVEKTTMsQ1WTzxVVUhnwh0WgTO6xr3cMnxCSc8GZN+gE8OOVlmuuhjcIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344184; c=relaxed/simple;
	bh=lAZgXTvPrn4yW54kvbX19iKzcc6OFLnUhxAJBfq4290=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jFxuGOOJZtKmyu21KXhHrjxchIMAqamnxBDxlJK8xpMW6GaJeawlURyX0J7XdPL9McYjgsFNcI1vvbXiWsSAUEi5lBQjvI1UaBj2AE9kgul3Vf6lybGUhWwSm7NxOV805noUDxZiBw33ZwxJh37YOc9SZCqjHyEpFqszwREG/FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUxRkKBh; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUxRkKBh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783344183; x=1814880183;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lAZgXTvPrn4yW54kvbX19iKzcc6OFLnUhxAJBfq4290=;
  b=NUxRkKBhbx/xKwOXAo69ODk/bTQsBPkwV0hCQud9sQOZiCUnnlKMMXJQ
   piS4WY3A8uKF4uthv1pnVsmMPnMwCqTLduz7H19gI6G/WF3KushzgQJ75
   1A0ZEMZNP3A8kxa1/jNcwGoFi80wc1FtNKhza17aFNoQj4KQKwE+qal9I
   PjTBetr+cmNFHasLay2Q51kQjZvMdOsKOqgXypN8r/aLnAlG9HRK1zZ4B
   x3+A4p/4nuyHSbDGuoxdQ6kJVp5Ags8aA7gy24+Zkl6R2GH2o0cBdlZXD
   dV0shdiMc7vGnpiJVAHCYTP/lMJDh/jZ8DLoL/gq476T9oSQ7eU+TO5bj
   g==;
X-CSE-ConnectionGUID: oYEYrtULQ/KoNkFqF9E/5w==
X-CSE-MsgGUID: 1eG85cUxSOaez9QgUVWr3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="84167075"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="84167075"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 06:23:02 -0700
X-CSE-ConnectionGUID: 1AbFaz9mTx+hJDzkNpjc4A==
X-CSE-MsgGUID: CHQ8BQciTnCNkm1inF+4XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="258614687"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 06:23:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 06:23:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 06:23:01 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 06:22:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUgC+ZOkJlhYlwYDHCwuQwRZFLgAdEbc7VhEsGtKWeAALqLI/N6SEA74Fh8xTY1OyAbWvt7LAPdJOn2CqvXFHDXdVzdUpXSEWTxSrNHZgSZUu8n/C3MGoKqegWVkuoPm6fLYJNqpTLp2MX8U35kiMH+8BXtxqcCSct73LQNCduuFzJjlSeRnpGeVAgLaVMG1t2jv2zm7/PlctmP+z08R3WrNghSI3LdLb0kOhzRBitwecnRpxHO0YMmtMtKtKx9vEgZ7AlePL9Tc+ouj3pY9LQJkRWakYjjnqTfylY4LnSUzi3OgKhJdRFCENbqxSZSN8PR1r75/rnGwqE4zIod/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vy0G+85m7gPddm040zxgxGKWG0sO6WrrF+p1ekR4hxg=;
 b=orJela0ndEDAXveA1aBPKlSyYUz8Ffq0HxcQJd3bmT4H7n/F8aTCNJo9necR+O3G+b238v5diLmwMoJSp9MeqtZ+oEzxYE6yS5CWtChZrYm5oE4CSdfelVoXpxQA/k1tJjk3ZlGlWsaG/e8vMWxT4a9eZZnuNZDHgk/Y2Ag6wHH2WuQMfTc1rFJU6N1Wy+FFNii6Wka0F5/trS3i/Of3dlwZoJIJ+r3igtqS6+POtbHl6NIgK8tUtflJgYuh7Z2iZ/VwSGgI6hRFoOSV0159P0zdEtuh83ocKXlZM9V2wdcvorEILpJIdtEiTCvDJXaciw1sIgiRu1cFwnxM29mTDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by CH3PR11MB8774.namprd11.prod.outlook.com (2603:10b6:610:1cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 13:22:53 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 13:22:53 +0000
Date: Mon, 6 Jul 2026 21:22:42 +0800
From: Chao Gao <chao.gao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <hpa@zytor.com>,
	<kas@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <yan.y.zhao@intel.com>, <kai.huang@intel.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 04/11] x86/virt/tdx: Allocate ref counts for Dynamic
 PAMT memory
Message-ID: <akusIp6UQW/pIDc3@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-5-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-5-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: TPYP295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::7)
 To BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|CH3PR11MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b5f562-40f2-43ef-817e-08dedb61aecc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 5uUSESOyPBFT5u8S3Vmp7yb3aO5YoZ9MR3xul4tA16BfJKGS7nbEUUhuzyXKX4MDX4yx+6CcpXxvfnKWlRkVH540MqieoXtR/ZchHGO9vZCJXU1FsS0+U8+kP/Eb906G3sQme/0zTAlRjQT35XfPtzxt0viVUzdJV9Z8K5XhLrUpzzhvvW3xBi6SPGc81eMvCgUusvTds/2LLl4ymqUYDNTtcLEviFqE/dWx147Z1GcKwzP5hJHrRP/VYwUsOFBcLgE4Et5hFFRrKTe5P4jlBc1/FKj6SecQYvmXEpNme1gM+Lk4nSoqtJEptsr1BpfoFvdLuxF+UA7sp4hs8wesUdRoAOM6npHToRnDDFCU2ZoRsu8u0SBZOp9Ph8n8gLADUMLDRVy5N9X3r09RqvZMenXQie3BWdUuuMT2Imi8s64Ewp++VuvxectCq8hJZFRXYFu47Pz5ZAr0nXELMsZExS4BH+3QeNL7ODrlNOEoMj0/TbAY3nYrFsfkCmeWW51W5z2lxeVvddNvli4LfB6vpZagsm7rzMjC6MQ3aeXPfJlcl0USXIcTem/1z2PmVG7JTTFL1M1rtjDQ/sjsz5BlZ9+o2Q7My/oOgrKzaXRYAONrAokNJSrtyINicjpmxu5PPPa95oKd+5WqEUshZJndlkqD1xSg2y2rbFE5JZ8Wjqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VvUj34FxxIJp8XM6fLSQgFPzAjAE2NDkTX9i7uL6vuuZZP74rzpYn/TbNFQI?=
 =?us-ascii?Q?HP39FhV1ucuJWOeVIJBVgAxL7s16shg+1+/sJURJIwMmd1uHSzBriqW1k8pY?=
 =?us-ascii?Q?reMY5j+1RWmSFihzJuQq+s3lhNTYdQqpP/fRBZhrk89kJk/2Gw6JFQmi8ysl?=
 =?us-ascii?Q?WH/xDjK//HAvO3S6F7Lt2ywmTPi5hZQrIdh0RAIY3lF+CW/B0IsGSmzTNXS8?=
 =?us-ascii?Q?FlBJyZjm0rG0RG8Vb/4c9qml3TeEF49rdZo2c91JkA/0TRKBI5+tu5oni/pS?=
 =?us-ascii?Q?azmyzZhdYghJyBxcBTkAPfEAbCI/bnqQuxO0H2TVCEP5GJvAyWRzy5gmC9N2?=
 =?us-ascii?Q?4mMSs8TS3BbmyB+T1ON3LPT4Ocux+NdnLyAXvt9wDHMEpMI3CchYJIiysp7x?=
 =?us-ascii?Q?F2pfZzBWMrUQBeAnq92HL7IbeeIKciOKtFh9qyza+bveANm2Hf/Pc0FFMA9r?=
 =?us-ascii?Q?fmlP+/xY5pbTXDpvXSaQEn2pzwbyC2K50J1cuKG8v65r85J0g735gMG2UCyf?=
 =?us-ascii?Q?Ei+Cd4Kb4j/gri8+v5IRf+NlZ40Jt5WecOhb73mdyzU7eDCzsrCrhblu/WZE?=
 =?us-ascii?Q?IwGPBA6jBATfHRixnE94grH5HlpIb7Xjrg9IhN9CiAOrquZ12QWmZpB1Nufy?=
 =?us-ascii?Q?tShD6I76MLjGMZqp7wVWAFAAnuryqK2w3Ktd7sSoPMp05wiLLEQipdrtj/lR?=
 =?us-ascii?Q?+zq4w3ruI2IN+YTY+YzEHVoB5FZ1dPVbmPY5Q6Dp2YSg1jrXXR0Ng3+/tVil?=
 =?us-ascii?Q?z2Jkxsm+UQ9El8CxbZO4pUArICoNKoTQNZPgckinKJfCzRDVQZbgOUrP+4HI?=
 =?us-ascii?Q?VVV2i8D02aMxCjI9RJmPb3f8GpbBii8d8Cf3mYkUPqE9nP9/KTy4qNpUy0Rk?=
 =?us-ascii?Q?SUpKBOESEBPc7dtGksyU7br8HsuAQKjabwwzl0ff4CBNVUiL2f7YpUjfCb+N?=
 =?us-ascii?Q?1rBfU16CHrck9NkpThVX/9TJ7e1T8Jr/K8mN7td0avy9P0TUbXfkcByJzKdD?=
 =?us-ascii?Q?qNi7wBHSgKzATFWjnkgj975w3isHQCJNtWrT7g+gm/kT0I9YyO60xNrBLqPM?=
 =?us-ascii?Q?nVSYX+YnjlbNwEqpYbMvvwwNVhO8X34NzlDF4YFjehwRo+CsZ56y1shSaXTZ?=
 =?us-ascii?Q?1cuu4+4+XIkWKggz8U94Es4WRfXDybn1v2RJGMFs4F9nB3sPJY85tO0oNp1b?=
 =?us-ascii?Q?krIlJNbXGui1vRvJcpTK5+KuJPKx/k6+S8H9Z2x8dv7AJw3bBwJeYFzqUIHt?=
 =?us-ascii?Q?qrhIH/O4TbrBGRk/nog2ccLe+fQcdiSYUbkOel8ITA+79npFi14AqjJaomAj?=
 =?us-ascii?Q?H0JyoKuCI7+Xtw8TkbNkB7vM9Pcfq7NJvdUA3cSNaqPln2GCKV/1UOKZW0LW?=
 =?us-ascii?Q?Q4kAMiAWpumkRmMk9ISTgzwBdSbSeZMPEKp1fIfca5iNH5oFVUn3ecS7CNkL?=
 =?us-ascii?Q?WA+w9Q9ptKTSjCRbwN18SYNl4jrQekiYH34TX3eoxBSPPD4QdiIAjOZKOt4o?=
 =?us-ascii?Q?X4Lyt3I3tqyfzrpAjqHL480QvcU5FAFoY7RuBFQeZ48poN1U7IwfvqpT2lR4?=
 =?us-ascii?Q?u65LBUGscUbEp9r4iRNvHV1Bp8VCEt+3lo8hZd3fdWxXV44lOGqTn6qkPm4K?=
 =?us-ascii?Q?lJ9oECVXAX98KjYvt2U5SD5uNdBElE9Qz5Iu2B0euSoCsDp/CEMMW9HO1L/M?=
 =?us-ascii?Q?X5wpgJR5ULCstunO861wT6VBlBZGbs99aT/WzoT0+hsvm6EURZPLbPL7bcFy?=
 =?us-ascii?Q?0+h8yxVnHg=3D=3D?=
X-Exchange-RoutingPolicyChecked: ZhQqxoT3IOLuM3zDue5Rg1NM48YDZTGwkANbHSNY+IpSTo0prKTa9YGDn5SOCbezFV6PX0mHdGQZbbsdxsR5ElAflYwtg+0M/ZkgEwXMVEonTG80xHJWtwCZVHWHcv3oK5FHJriUtdsaXpNALNi9Q/DuzFKJXn5mYWJ/5r6xpBvHsIpgzNTH0+J4MLGPdHgZNzBnA3jvzOXJxwc5GXgy4RTXVvL++j2WaEDfisnTYlaQc1AoIX/he4Py4dj9lR1c8RawdXZK1iIj3WIIfiZH9z91ByEInJu3sFXEJ6nkGj1EYGAp+3w2Ey56WNCCP8w7YLYguomRHOW3lm/sZnXJ5Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b5f562-40f2-43ef-817e-08dedb61aecc
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 13:22:53.2311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfpvS5tMouYKLmfHnvRHBOPuz5k8OjB3Zuu1f7kjWvvg0v0NYublxu034GhM2QIP8XEDE9K5gyVyPtz2PCykRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8774
X-OriginatorOrg: intel.com

>+/*
>+ * Allocate PAMT reference counters for all physical memory.
>+ *
>+ * It consumes 2MiB for every 1TiB of physical memory.
>+ */
>+static int init_pamt_refcounts(void)
>+{
>+	size_t size = DIV_ROUND_UP(max_pfn, PTRS_PER_PTE) * sizeof(*pamt_refcounts);
>+
>+	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
>+		return 0;
>+
>+	pamt_refcounts = __vmalloc(size, GFP_KERNEL | __GFP_ZERO);
>+	if (!pamt_refcounts)
>+		return -ENOMEM;
>+
>+	return 0;
>+}
>+
>+static void free_pamt_refcounts(void)
>+{
>+	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
>+		return;
>+
>+	vfree(pamt_refcounts);
>+	pamt_refcounts = NULL;
>+}

Both functions are only called during boot. They can be annotated with __init.

Reviewed-by: Chao Gao <chao.gao@intel.com>
