Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB133382CB;
	Mon,  8 Jun 2026 02:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780887562; cv=fail; b=oXai0txwadyWYyP7JYAGpMShItNPdC0zUqvhKqYamsFlgI/Oj1jalKQZHj5U7zqDRzhMx2LlbFdZeLyfhQs+Q2hSc5wn0BJNVO2AZJIOXoJo2JJ7e/v9wLAAU7A1yy4ammjNGrF5K34JvA0rU3bbd/vldrqxqXPZFbCBa7NbIeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780887562; c=relaxed/simple;
	bh=0oi6qOb99W6/THpL9wAoVfHYN2A8+zcEF/xpiEU6OWs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BNPNvTWmVfGW2Ol/VRoIHazYpCCGyYM9gkgo90V79Hx8wM8Hzd2eDkEt3aHvdPY/NjLPjEYHDYnen2G/+aYEJbiKzApat1n+15kE0FgxvVyynF1DCOdpBAwZ5e/qgRp6aox/ApOWuC328UeOXYk4HydNaBfC/nd8PkCT7+m8qTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsw1FWVL; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsw1FWVL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780887561; x=1812423561;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=0oi6qOb99W6/THpL9wAoVfHYN2A8+zcEF/xpiEU6OWs=;
  b=dsw1FWVLRJmJoIKUPelYyisYro7vhsWb1VQXYJWBKITfjNWzYmcCiCXa
   Pn7vgRnaVULsccC+SyzMasCgf6aXWdg2ERO1hlj4s5OPJui0YAtRHSqs0
   CC4XCL6UHk5DJoEKj7kK8TzGsISJf8AVK0LKss3jmOi4LJ3HIcxFbmqCD
   q71Nq4KVQrcnBIyyqn1+2M54WjUtGHA84HC6+qp0oCos44+FD+pMIuKc8
   g0QT27TTadckkhAcf1O/zXJkiaMCyViCGtV7Q18PBFL72MbgmStZE3D2H
   8gk/eELbCfFqobwnOUH2tnfGWf5WUEEdd72eaeWa1VBfvSldbNbsmE8sr
   Q==;
X-CSE-ConnectionGUID: hVVcmZaYQG20+WEWz+3ZZg==
X-CSE-MsgGUID: iVNx7UbeRYuOE1sFxI+w1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="104276113"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="104276113"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 19:59:21 -0700
X-CSE-ConnectionGUID: iaxWrAt2Ts663AqXn3OgJw==
X-CSE-MsgGUID: ZlxVv5R8QVG2BMlOFG5+QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="247261958"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 19:59:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 7 Jun 2026 19:59:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 7 Jun 2026 19:59:19 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.14) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 7 Jun 2026 19:59:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N766sc9GLoUZZVd3Bo66YfTqrDUsWAXkRSfiKI9K7YUvpLMZgr/A4r51nGV6fuQsa7xO/7+0BPa0eUyWwhvfHvo+745pcsv7Q+esJEfAuanX1PCRplH2pGoZ8bZDHQICo8g7IE1seH7di22JdGN7UZwX9511yStvla6qrPCG6VijkKupsW9P7HBXuityCrjPaQIT7X99xYPrIkJmzyQdp2gBFP3cXuT3Lp/PodN0ziDCDmfExWL9u6uHSvode7KcFom3P+A0Ui5Qro1usCNdXVbt7udIISuSRth5ITU4wTATMMRT/QGaw2GHSSEJX7NLoBaj0K3X6SjKjqmBTgGg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ung0IytDl5dU9U80enJu55e+CoaxVblf+gGmDzpAov4=;
 b=d5fTTqLYKr92TONiDDwc3Gc5En4rjf4pDMN6wcQpySIhf4A3JwA5xuOjykOwifH53PN01jPBnqqFCkNN6SWIYcuYNaFuUoHFYfajMZaKo0uy//uw5/F8zPQGdhD9yHTg77/sQINC/Y52FhRD8vHwfW42D93/+l0wIZD1aBuS7ZoRcX34L8qZA/5IWvKw2FAh1BBjOfMdmoScVyS5ryqEhivbETKMcUwK6AaI1KFKuET013SKcKdi2M9R0b9CiAEDS2TACGtnULnv1WNwZ+ster/sjgwPfIPQsAokkf/gWQvUj5dji7eZakvf5Y0wc5cGFf9cqZg0AsFtft/WZoeHKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by BN9PR11MB5226.namprd11.prod.outlook.com (2603:10b6:408:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 02:59:16 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0071.014; Mon, 8 Jun 2026
 02:59:15 +0000
Date: Mon, 8 Jun 2026 10:18:57 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: Rick Edgecombe <rick.p.edgecombe@intel.com>, <bp@alien8.de>,
	<dave.hansen@intel.com>, <hpa@zytor.com>, <kas@kernel.org>,
	<kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <tglx@kernel.org>, <vannapurve@google.com>,
	<x86@kernel.org>, <chao.gao@intel.com>, <kai.huang@intel.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page()
 helpers
Message-ID: <aiYmkfHBDHlqQI/d@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-4-rick.p.edgecombe@intel.com>
 <50566572-6379-4100-8845-404f695e59cd@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <50566572-6379-4100-8845-404f695e59cd@linux.intel.com>
X-ClientProxiedBy: KU0P306CA0079.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::8) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|BN9PR11MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: 615c35ab-31ae-43c9-ad83-08dec509ed2f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|5023799004|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: r1oDaoJclpjeY/4pdqnLreAJoDNv/1p9shwl7z4eGFxqT+gd0l+wW4evldpipGLTTUb0n0wGLfgFR7S0DIQfKTOzKEgKUNd4orLVn6FRCJB7q4y8c90ta4fu0Q7L7fBg5ThnOr6xBpJ1ThgXDKFqhh3fHvv6OhJLCZ+eiUtC+zPWaOKeVFW5CX0+hlfE6kVyMqCPpXPSCMNrMV4vw0i1u5nDLq4JAo0OuVxhypSGOYcz/kUvAoPyl1f3AJtohViqQYRboe/g7bb+pPdvc5jBEaXgcJ8pPwZyr1UXr+8w9R2Op0nqdQ2y6+2NyRZDCLlq+/LtZvYOSNPCdrfD6J1kXOGFac+IW0Aji48SEeozE8InlU08c0fjf+qa8sx1kikSLj+/TJBf5QFder1SFH8ORPdoZH6rfDv0o1gb7HOy+A98/5D0D7YR+QcCVFeV7nflmNyE2M/wccErkegbsyGbZuIeyeNE5tfEnyVABKbIQKSzrAQ5kkKiPxCjTG9RuEKu7DGLpk51+2on1Q343khkJc/UIGcVP0cmh54oJbNjw9Gjeu0fr7/WaqR+xy00iOiJvE6SIbwJYan80CE3x1VUFvL/nX8PHNEGV/1VB0dx9NaU/CE4LaNe7hCiT4oRi+FoEtuukfcWyj8Bvns2V0jcqT4eL+vnN1qg8lva+1LDH/Mq2Os83nzoqmn/Co8Y+c+A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(5023799004)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6HBpzvjRvevj9n9Z5G53JuB64p/+bi0mwazJqH99zSQVyUWqNK+6eaUcAbDh?=
 =?us-ascii?Q?Ig05PBqEfSoaQhK6R10N4RRmZoh5nT3mS+wp0hxIl3gkUzg5qwm8oLev2mEn?=
 =?us-ascii?Q?gOx2Nj8+0icRdg0A0NCjWllvVJyOFVO6/OPhFWkeyEOBN5w5ObedMYd7tE1P?=
 =?us-ascii?Q?k62Ue8yrqe+W1LnwEFSmgXcxa4V2jPGRM6rUXZS3fF1uwXG6xkxTEr4TkD5v?=
 =?us-ascii?Q?YXFiG7nWE0Hjuj+3mtFP1r0JKBdvf2f6PCIXHUMtXGsKI+tw3svi1grkoal+?=
 =?us-ascii?Q?xqVqM/wZ6oSEo4QF0TeYgUcdzM3EbBNf7gLbRoDWjaWM6eXZOhkk1qu/icql?=
 =?us-ascii?Q?OhXDMaWL4uzUBFT/gkUcKS4DnMsaLd0kLD2axYzIKcrvrlRotCYrQFlKLf2w?=
 =?us-ascii?Q?KuvX+FPaLsVRkAoRz4Hm9PxwsVtPdRRjywOALscebgU3NP9lD6t6VHo14a1V?=
 =?us-ascii?Q?TcfnRoHs8qKtf1PlDttztpwLfN6P9aE2lyP5WIcoC2Ok/X0oc20/rPqW2Qd+?=
 =?us-ascii?Q?/AXJ/6b7+KcQSThX5FGHi7azV/aAYDtG+dKnMHOv6kHs+IDOdEWbh/CAMWtA?=
 =?us-ascii?Q?G/Gb7Fhw9LeXmUm7ZtzjmZdYV9+LVQhcyRcpWRHFCDz2jGsSRp25zbu+FUbM?=
 =?us-ascii?Q?mtL2r3+Ms4CZgMQEnRPSjtkb7TjwRjAqDtwSb3ibffRBUlIk+8ecX2YZG72n?=
 =?us-ascii?Q?zBSv/iNjeM3ds1LIDaZrfM3k3H9va3hjdFe7UAlgwA/qgKILCMkNKV8j9hSo?=
 =?us-ascii?Q?oX72XmDTnUI1ypcxGzcEHXxxR5YcEXsLaeM9MB67SKxK5vBnHkGEAj6tpjtD?=
 =?us-ascii?Q?tXszpGei81WxuF8V45K7BwruKB1x7pJbsyUZ7iVr1luWzl92j4xZ8IDFLDVf?=
 =?us-ascii?Q?tD95EoKhx6z3afLF8wVvjEhREH7QrEZyGsISfYj0mb/BoKKaKgtWM2suZGV5?=
 =?us-ascii?Q?krazUUHtJ5Q388Rn1aNoaUjjEn3hSWyd8JaEZpWL2gH4lVSYl+YmDhKcE2Qu?=
 =?us-ascii?Q?YOATvLvDVF4Ap4O57NnYv76T2F0seGutoAW6UxpV733R5dgIsTQ1TtxnZR2x?=
 =?us-ascii?Q?VOzwglorYdpYklx+GbUD9g8ke8qrZb+nZxMprpUJJQTfQ8SW+xgHQK+JmNMZ?=
 =?us-ascii?Q?SpuNPoKZMur9/l+CcdL59oWA9wYsrcsQyQcH7cdD3AwP/IZol8xYbt19j2vn?=
 =?us-ascii?Q?l+ZjpPKuXVPEskC2oiOZNlT2OI3lRNmdEMpip5wCOrHGrxK6wpCamPci+S2B?=
 =?us-ascii?Q?/wfRs7B7keg2Ja5bioce2Uf6eTAQNlQ46KVup3kbkOWLtjdmJz0S7vPP8Aw4?=
 =?us-ascii?Q?ZCDKI1+3eSt0au6xQO2Uk7/II7J7lo40NbcNmfMosNs0xJen4kP2HoYM2NVX?=
 =?us-ascii?Q?w8ZSLmOGmOXJOn9r1B10T1jDMJmoVWoXMeJXqAoBpshrVYByJECzwtZkTKem?=
 =?us-ascii?Q?2UU5AxhkeV1R4qv3ms1CvtdwJ/AiNR7xXtzvcp6sKTVQ79UXDb2Y8HWUFuNf?=
 =?us-ascii?Q?mhh0xgH+6gqYcdv+9aBafJp3AtUQRNpJM0U/F/4W06BBIbit3Ew9ihNGehy4?=
 =?us-ascii?Q?sUj52fH2wFclPDezFeMCYJhM8JYpNuWccSsCQPOA7gYUlA2aIMzMkbxnOe1W?=
 =?us-ascii?Q?shBqteSrV7QUzW4VU6lZrPJMz18AHlm9+uiQUCjguSZJ7C576zslio37wiv0?=
 =?us-ascii?Q?t/giiDPckmkc0OAUh1FvZnq5ZoW/cQ2PpLeK8xh33CIFt1VxAgvyL5k9646n?=
 =?us-ascii?Q?MVb5lTopog=3D=3D?=
X-Exchange-RoutingPolicyChecked: Nd9TBi1utv6pvIwgUDblyUzD/kEa+c9/6aBIBGdW+oPDaqhomM63NqihHtULt6V/7yYcc4HfELkxt/OE4r+FZGj6tA3bTSks57RX/VDkbdfb5F/p2FbqOepLFPew4ofGTLfKmrAVDBvs1UmZ4Ut8Eu1x3WmZQn/dK/fqQpS2YxktBLftiT9M2NPMcVCqB9YPtREoKSqZNB01XYG69z+4ysXQBz/c1r1NV7Y5Y5Juh579Puf0gXdVIOkIrUNEiKGQq+2fe74yoUneFdJP7kHlmd59sB0VX5ZBoXFigPcM/pCKIy0kIo2WYEQZgw/OWOLxXb6CGOvfRA9oP9ttaxw6wQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 615c35ab-31ae-43c9-ad83-08dec509ed2f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 02:59:15.9024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lfYyIY3xOsNqv/jU6UG/E1mNeUDl/f2Q9LZhfWlQmDWUTpFCfltv2AvMhDRMhK8uY5Wd1n6LUtpD5oAFB0fBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5226
X-OriginatorOrg: intel.com

On Mon, Jun 08, 2026 at 10:11:58AM +0800, Binbin Wu wrote:
> > diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> > index 82dc27aecf297..74e75db5728c7 100644
> > --- a/arch/x86/include/asm/tdx.h
> > +++ b/arch/x86/include/asm/tdx.h
> > @@ -37,6 +37,7 @@
> >  
> >  #include <uapi/asm/mce.h>
> >  #include <asm/tdx_global_metadata.h>
> > +#include <linux/mm.h>
> 
> I think the header is not needed here.
Right. This version does not invoke page_address() in tdx.h for
tdx_alloc_control_page() any more.

Also no need to include mm.h for tdx.c (which has invoked page_address() before
this patch), since tdx.c includes memblock.h which further includes mm.h.
