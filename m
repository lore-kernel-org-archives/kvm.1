Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E2A27B32C;
	Tue,  7 Jul 2026 05:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783403678; cv=fail; b=oUUet2e7V6kasZVMkbtcBobqrUvPitTVsMVNhnYc52ulmDj0aDgaTi64Q/A+7nhVOrkmGPtya8gsM7nx4l6o/WyxcB8PsUQQpEDFGqClIH99mgQV92fblZYzckF83DvS117uGIfV6VqzibG11mz6I8U0DRy8gAmQT8oJjSDG0zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783403678; c=relaxed/simple;
	bh=RfHEcY0BkjKVFaUcIX+UckXRxbIsLay+pnfQbPPPUSk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ik2hbkKOtWZEsiA/cR+5HLAxAr+HA7rwXtPjK/Mst6tRJxgdbVWtEiOG5xTcA0gzSCZT9b+45TnWcWwCPqne/9YK24ZJu3+9wxDlmnqBHAUcGrUUGjYDtMRUen7XpLn9zyZYypuSiAB/+G2pDAuPX2Z0Ycfh+prysY+h19UM97o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWnuePMF; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWnuePMF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783403677; x=1814939677;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RfHEcY0BkjKVFaUcIX+UckXRxbIsLay+pnfQbPPPUSk=;
  b=JWnuePMFP06FC7YHAasguPq4FZMmcVn6GYpjfH9AogES2Ozl2H7Awul2
   azpH4C/pQLVWQhhXxygEwUZENc7j+ntMtrHLKi92T7CH/DX4S500sGLgj
   D89th1QW64h5evyxQVZ/zdMFXZbm4ZFHtzmD9dwytQeap4DdQbzXMweb0
   u0PngGJ/sOknHPE3uCS24bCx/lo3hoC/f9xYVlO+8XiZw0u5cxeV5RuYy
   nPSTg/Q1QeG1dxOFzFz1KyoDnkHp605EJZQMJlZ8ypsbSeiqwVMSPucr/
   cxcdGChD3R7X3PA30nzFEP7jhEeqJ76OMyqdoXow3nyoMG8XASVW1jAcU
   Q==;
X-CSE-ConnectionGUID: gZVZMg5NTq6O8qoy8/PFjg==
X-CSE-MsgGUID: YWteo1+2TCqfOAIG16d2Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="83151703"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83151703"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 22:54:36 -0700
X-CSE-ConnectionGUID: OZ4jwaH3QPub/ByJ9CxEyQ==
X-CSE-MsgGUID: axjisy8zRYqUcCoo+HR+6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="251234920"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 22:54:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 22:54:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 22:54:35 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 22:54:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRmdtbn3vl84aenNreP8NYOyfP57uVWfkuELCoGOYejSzqvEvrRAPIMUdEas3RpTOrboX0KzJw4xG9czdqOVEOL/nxp5D7Xx93emorkv7kEkAheQbyp+N/azo0x6SlSXF3iUVcqC8VYgDtkvyhHs8OQpCHNSvVwpKgALtWxKtkAef9WXV2r9IjC3WiPmes5Ztvs4RZMbnCLEPNeHGKaJ+2IgUwnDK+SOrfFYKPZ0XaMbLFuzcmoui1FM7Q4yIoYKQyxmpqvVLTIWEbX4EDzby0ICg/iyNIXd6AhgYdag2LUXKw2vVgZ/6zMmF9NMAUhirOrDaQjCSAMRrTmQA9boug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6PHtZZbxCtNqHidhq/hHsWED/RW/2lducHUIfIAqcw=;
 b=wr7FnLs4zC2FB06PzUfds96oeJBsQ0syOq+fbnvyrckCNzxOUB6B8WQlHAlEE1hQhVMsoudWINVOIIN4t5LfLVhxPLbTtCJkuXci0st9zi57BL3UP+la4GsCDViAu/UKn2RHWho3/bjvC8r/rx1cOWkBaWJxArvWuQJDwPjKV22tEGNHKGSzg/DinvRk3KRWoAYfpJTma1TDHvb+CeD1zzGWZn1BVfmsuI+7tr9aUqDJgDOdtC6fZsnhDpYjXcQrP1OSuvVgDZv6jSqvhlndimDh2ScvZCGnnZwfkIIerV2JCmfNe72rHQabNF27ADuebXn0XHi8tFrTCXav0UvlcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by CY5PR11MB6281.namprd11.prod.outlook.com (2603:10b6:930:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 05:54:32 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 05:54:32 +0000
Date: Tue, 7 Jul 2026 13:54:14 +0800
From: Chao Gao <chao.gao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <hpa@zytor.com>,
	<kas@kernel.org>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <yan.y.zhao@intel.com>, <kai.huang@intel.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 05/11] x86/virt/tdx: Handle concurrent callers in
 tdx_pamt_get/put()
Message-ID: <akyUhlnQR5payN7R@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-6-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-6-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|CY5PR11MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b0753f-ee28-445a-563c-08dedbec370a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Gia3HbgC8kB7x+FriSYGlpTR4Q5unG2150Vft8FeIzaZrPV2p1Tzai64yYFcTosnkVfMH70/p7BCO4L7gNEy0m1KwH5nITEqBGUpbL4HULCOz6Bvm8b93Fo8bKXw0PJc/faF+/gka4nHC4Of85UuhwqNsmynovQKVnOBXVBf3wxuvcrBTXfmPjCgwow0sOBPSEZ71pDloVic6oZLqTr8TWVIaWwb222Z4RT6Oq5dfdwmYvNezr5teSUWyh4i63G9se0w7zbNP08kty/OyU7YdSMeABWCCZcA0OfD0sp2SJ7a4Dvt2Sa4vSu+L4iLjgnLN15tmUz69Syfq94dCVFgfYNSOw+4WxBShQbIHXsMb4V2DcSkItYowjJbq3MdqxJpVuoVyAxkQxeYl9/1IiNttQ7rQbFfmSuEZHhW8e/AJ8f0Nx+TD2zyqsG6Bt8X5zt9u5vRga1RJ0CtMXXOve3wspN6e+ak4ap0Hsj6kLrt0sKcBQZFG+wDhvAeoqRlG4XTRbbhc+T1TTUPtXvaAz+u3yDK1a58TTymIm77P9Kx1vPKTDZGGmpG/aFrU7kqr3PXhBDn9Afjhjk2KdeEeoC8HfyRYVsSilcoc5p12IbHLf0FFcJk+/bKr8ILlK1xopX2nuQXs8poXKzRGXybzYXVwOdECADBZr7QiIJTjpyOrKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SEUOSJoAvKt3qBlRb1DZmDITQDeIlnY9D0Lav+IqngXcNDS49A6p3a4inFs0?=
 =?us-ascii?Q?ra++odQ02e/JDqOniM/UXku/veh9chBp/C99m4UhM+cb0dV8P2OyDF1DXuwz?=
 =?us-ascii?Q?gWwWgssBMlKOqbbA/3dh9V02ZfoM/QvhhinWnXUm0gIZ2/yPu3dAZpIyiFbn?=
 =?us-ascii?Q?4aLysenH0jCEulXV1D1oZxmZcGWUdMf2INHILfyUu6y3vFH3ohkfUaa+N+E8?=
 =?us-ascii?Q?lIvkucbe9FfqgcvaOpRxX2NM0pGWXMhyf2tIN1+92thTyqu/XOM3kw+ZiSg1?=
 =?us-ascii?Q?Lh3diDoaKfoZkVSE8hFIafAD2yzPVUeKLHASEwVLD17ooavsRf7Z9fVuAqkk?=
 =?us-ascii?Q?+zdgIpNts3WnHoCctgVwQ6HKoDlXFeSnlGLS1yPKzv9c0DqiunH/mkD8w55D?=
 =?us-ascii?Q?doX9xm8zw7jgZn1NfvnTAFYjvaWEyhwy+/s5GMxilVRr89x9dFoGPCLKekEd?=
 =?us-ascii?Q?vfQ3eZm70DDdyEsjQ3QU/PPJxZcpiVGeCTSyMMzykmGZVClAHbPviat9Ad3z?=
 =?us-ascii?Q?cdrID29b5EmNAyKGxuHmGC4JixutzsUHB2P5JZTNkpYnspFEU26TipzgZfwr?=
 =?us-ascii?Q?nFd4DlJsVx2NdVO7+AxPZBkU3meUPjOVUwYFi4N2dtZ6S4+yt68PsqPgszNf?=
 =?us-ascii?Q?3960W6NWXchpd1PInhN8eXxssoZPiimai+COf1ajbsCAPBSzqRHzeUPLqN6o?=
 =?us-ascii?Q?ZK71MnYoS7O0pG3Z2Td1SnxguQGwjneapx2VqSgXD50w5Fbb9VPX6cHTQAfF?=
 =?us-ascii?Q?fW9RAMGkmoR8YJyf9Vimujan4JsLmjjbndOmRP+BdMgssTkiE6DPjfDM8qGV?=
 =?us-ascii?Q?Shn8KBytHytyYOffmR+/JoHpO3q3N9Py2Ts2z3Vt/mO/Ah400w88q1gp1X7q?=
 =?us-ascii?Q?j5YLUxpFigUMp9H0duFpFmocUta/bAhO7my6QWkyYIxqiDhnDo4IU74NAogb?=
 =?us-ascii?Q?SN+X3rjYKFhFxWpgWFf8P/XrnRxCtcMwN8uPNl9Ck7y+reTVKbOSlnlmYX8R?=
 =?us-ascii?Q?I0oto1k5mgCjQajVFmJKBYdU3kvH6biBY0us9ovPG8WIqPcihK1PhQZqBems?=
 =?us-ascii?Q?qIiwA37X9bgfP2xz3iivER0L4hSTuYzGJAWPdyToeK+1Tmw3Guevn63P9H9q?=
 =?us-ascii?Q?8kWnk8JTYh0kEUuc5uAEoznhS+YgDIohYD9K9laMVqIcZ+C4KvNC2HPaFgXA?=
 =?us-ascii?Q?eQtC9ElK+o11757aOd8jrUXyF5LYjZ6Ensz5qpi+/iZgmUiZW+apQp5dD9iw?=
 =?us-ascii?Q?q3El9k867Nr98tqC43KdLKCaH92/bsJKk1SC/aJui9QDl48OekP7C1mEN+He?=
 =?us-ascii?Q?C7shOhB2oQefomobWUYUH+z5udcvK0R8oZHz7NthXDC00j7CwVOr/EPeusrI?=
 =?us-ascii?Q?j/ypAnd795McrcnoRc2c3GNLsOnK+eEX/abBL+vcpcBHJ62u6I7FzNUl8Zdq?=
 =?us-ascii?Q?UHAhWmVNn6rd2Rln0dySY4Hv0sIHNI/Vy6Nv5CQZa/vCaPOHG1aqjCIW+ojm?=
 =?us-ascii?Q?ScR5DBKFAJt8tVlo/QLw1Fuvbg07TxXqgDzXDCb/jVwdK/yXBH8QDMGxfP8E?=
 =?us-ascii?Q?i1RcbA3nvN8YXLQnEQi8M3QI4Wzx1B4lul2/eP4nnaTdXIKWUChjylxIkdT0?=
 =?us-ascii?Q?okXF/4nQI/SmtVHk/PRmWRY4bOMlYn1z2C0HV9Tw/f2sSHZSrtEy1EfsXURX?=
 =?us-ascii?Q?nmu0cPYOVyo9bx2pYf9TxCrihjaTU63l8E8kzBXYPDc/Tw5c6Z4e9hRidGD2?=
 =?us-ascii?Q?qtVLwAbjAA=3D=3D?=
X-Exchange-RoutingPolicyChecked: kiLUuIfuV7KJiKm4bAqZLFXq2rhsWZhEg+wvqzFIXk+3HuRPgB5jNpJBI+K2oGF67LI4qB5HJsrVP3qo4C0r0GgBm+KZu/7mXNfZ03CLOPcmcvNINfEUAIPGhyjCLa14R2sLVXKGX+BW+ragm873TqLfBBgsaPsEus5+Ap2OSiT6aLIkOiO56WIJdLKfbXNeGPDqVrtpF1iAfq3516yE1UxPvAKsweua2ottBt9+LsRZt/gpxlQ1QmWuVDjb68WIlxFAIpYMKkUBYFjJfdFdVGis4SIRD+uUf9uWJ0M3M2phzxesMpWlLLZcNK9QUtbK1MgYcY0ulqocXvZQIWK2dw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b0753f-ee28-445a-563c-08dedbec370a
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 05:54:31.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4op8CS7FWJRzssp25Y3Dtl4kvlZdP2q0WSlyhImUDEVhb8HChTaZSBY9E113Uw23q5LFZ4f8p9pSZQQRMmKWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6281
X-OriginatorOrg: intel.com

>@@ -2057,10 +2061,26 @@ static int tdx_pamt_get(kvm_pfn_t pfn)
> 	if (ret)
> 		return ret;
> 
>-	tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
>-	if (tdx_status != TDX_SUCCESS) {
>-		ret = -EIO;
>-		goto out_free;
>+	pamt_refcount = tdx_find_pamt_refcount(pfn);
>+
>+	scoped_guard(spinlock, &pamt_lock) {

I am assuming you will convert this to plain lock/unlock as discussed.

With this fixed,

Reviewed-by: Chao Gao <chao.gao@intel.com>
