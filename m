Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E62D8387;
	Thu, 19 Mar 2026 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773905120; cv=fail; b=RX77eYbY3+79Z/hxZObi5nZ9ANZTSwHxxS9/oMNEl8dR4RSVf+ylBhQipiLpt4gN60GDL7KTmnkwdhXrphHNxbW0rGyD5fnnhdB/8lbcCckryOji22yoalwLsT4ljIRiwTbxJo6CMcsWX8phV0mzoHVAGSl2rjOl3jOmQrdT0jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773905120; c=relaxed/simple;
	bh=NEq9P8s/dVSan/2klSquxMAFbyGjag33cS+TImBNPic=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=phGzHdRyjyzUhrLjK0t1Z/5ChUwWgaCTQTuJAHg1tzI210rrF38Ryz5BSjw/Dfn1Ke2v6k+1r+R79bGI3vPFqKyGOGsrqUT0IX8z4FswAsmLTwqigSxTnxXSNIQpbDzCFkAyrfGzZyr83dEYtGPA61q0uXG0c5W5pWAfrBsEOfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBefZa0Z; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBefZa0Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773905119; x=1805441119;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=NEq9P8s/dVSan/2klSquxMAFbyGjag33cS+TImBNPic=;
  b=cBefZa0ZjAm36A9dof0bBgOALgW0sHxH/be4esUJFo300t71dbqW0upG
   NgkYTRnZWs3V/LlkWiKIfw756nqUmmcwiJ8Uf5Py+hKIpPmgyuZjLULiN
   LQLLa/fFEK0++jdKyyz1VvezCV4G+ykyaEPFowh3Gq2h5d3lp5hLXZHYL
   vQ4qpojNINzDXLE1q5yC/3fhbTiEnnNiO/zVZ5jalk+Rua9Oj2c3WppBL
   UO4r8J9QyNFxgWAKFCVQlhYipH3gpKoKYuKDGqR10RqzeLY3edZ+6xQ1n
   GtkmGq1u7E8zLPz38gj8Wgce7BG+Ni4Lr05srzAc9tSgSim7vivd5bAOd
   g==;
X-CSE-ConnectionGUID: xirIeQjAQYKtfR4A+QNlxQ==
X-CSE-MsgGUID: 5nk9TeHlSo6FNGaZKbXdNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85288450"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="85288450"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 00:25:18 -0700
X-CSE-ConnectionGUID: +IxlETsNTNKrwA54kT1O3g==
X-CSE-MsgGUID: Fp+QTwbuSHq0+VNRPTc09w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="260777357"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 00:25:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 00:25:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 00:25:17 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.48) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 00:25:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTtYico4QNTfsIfgEb/ElJ0pq1Pq7VqKAVc7aD+XHjxk4txWgBfgcCNq/rvEP46bj7hxUQVCN9Riiko33pUUi9X2mpE0mBDBY7ZmTEy/xI4JYPG9H8S7JwJb0k/zI5fP0W99ZakUQt/dBKHbADBhEpicGZKCVU3aUm4Sc63rHbqYSGCPyGTgNArpElecApuXboz9GePhUTA1jkGvaiXm8/yD+cWW62+5/x2DNevpXF3XIkczlVE/BfnPJEJaV/mq2bPmS25D4PBx6nqwMDtD8DL5YKgfqsers7TFGW52NN6rMKx/gJdCvmDhvx62YafIxyOHDj+ijrMNWxWoYWZz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyxvltyAtKVYaNJW/Bh461Hmipk5Eo93qGV7CS0KiFQ=;
 b=O+ZBZpknQ2RXy4xC8p3ozqQlhfZMq/mJhC8rkzyXAqhRzqBu4e8CbdZCOjx69iamg51cCYTvJenTkIvUrtDtqTKEuDr2aGYyCe3Y/L2N6Xc9cdQSjXwcFCiXOiT0Hp0NYS+T/lu+vGacuJhgl+yy/rnNMm1IbT2ndymSzavOjOq7V4CG1F/GN2PwhF9vfbZRb+0TSW1CYDRAOIkKVdxYSLAeQpcbiagpSEEF5bEm7KsKm2Uu0P8if2dyxeqyZqSlg0etKCK8+5kzVXjqRwjjy7aY6qaPWV+EXAFOcFbgbBzE+MKSR/FI0hErjBCpwL6vNXbwxr6JIVSOVcm1Lf4BHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by SJ2PR11MB7476.namprd11.prod.outlook.com (2603:10b6:a03:4c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Thu, 19 Mar
 2026 07:25:14 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 07:25:14 +0000
Date: Thu, 19 Mar 2026 14:45:46 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <dave.hansen@linux.intel.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>, <kas@kernel.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kai.huang@intel.com>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@linux.intel.com>,
	<vannapurve@google.com>, <ackerleytng@google.com>, <sagis@google.com>,
	<binbin.wu@linux.intel.com>, <isaku.yamahata@intel.com>
Subject: Re: [PATCH 2/2] x86/virt/tdx: Use PFN directly for unmapping guest
 private memory
Message-ID: <abubmi7BjMwgnrvC@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
 <20260319005808.9013-1-yan.y.zhao@intel.com>
 <623ac08e-07a7-4823-bd0a-777d8df5c128@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <623ac08e-07a7-4823-bd0a-777d8df5c128@intel.com>
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|SJ2PR11MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: be2c83ab-8158-4271-5c78-08de8588a9a1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: QPtHWlvSN6ujlSISC4hKytRvrsyzI6GI4UaOvTBfFmYL025larVLKlCLfuTcgTBo3Dm11HAsEvOEXjPikjJsyMSqEwkFovgOnQGaYR22V5VPcnhYo+LHTVtmpxqBb/Ltvot/JlqnqOe6WoaGwtY1fP/rY4qWDZb3ORxxpbFkzb+mAgVQnsi46G/ECwB0+kAsCVt9/Bi3QItvQ2KDdZMMzbVX2F3x9KQyUPb8fN4/JVt+hM8ZsyakA7MBAJdCD2L9U+IJutQuL7yK8nWWbevGJRkK0iMWBMV1HMdDuVBmmULwA1CsRnSIlDAjR4AKrmD1YVzcCW2eLRHz5C9wEEc0gHvLeRQ3q/PO71yeMY3+31rMXTtnBAftDty7tb/Z7URkOkjxHyQ+yTrrmguE8m1980bjJ8FZ8BwYM/D1NEc8GZ8HK5VYh3Z4jtFkkLZZCQsEPjyjgfhoPAt1kd70t4u9ReqBDuUsqCd23LHJ7Kl563w57dnNIPlmcvCck3X39lvea4qYcZmCZovx12EAgxfxccOi+93k0q7mmG7OqyyD2Gp6d2oSgEJ4U/Qttd/AxUwt2o1WuHmW0Dat1x76y4ctJ0vnQVt2klMKgYVmV+yr02oQg4ON8dADR5SNTUjQZ/gnnJf7dPMQJD8g975972Em6GUUE0u/LxJPgfe9SyEVvocFxR5WYoRt/bttfGEDjy8lDaGSx52EIcCMQ3RQqaB3+iU+FQTK854jLDYEnVXcaOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V4pEUY0HzkrmYVmClo3el7b9//BgAVgw2NO+dP5i7cVPYFCmO167VjaDuue2?=
 =?us-ascii?Q?JQPYRY+1/pk3IKGcZVT+qMeRlDV7zHPGj06siFCRD0JdknsxGgFP/W4AZB3X?=
 =?us-ascii?Q?1LYKSMIayXln3BPKv/KSZY40y1aIbQFIpd3yF+iipxr2/piBdaNHvg2losjH?=
 =?us-ascii?Q?ykQXTaqWm/abkyHsOKSAr9zgqlZdnAYR3Ui0fRnueP7Auz0QPWT6qVkCt+Zb?=
 =?us-ascii?Q?H5rcXUMSlAob4OzFTmcaaZQCrrO7Q9TRiQ7EJoa8h3awE2PYVIqZk9y7gopp?=
 =?us-ascii?Q?Z8Jeomfn513KAb4ozLiLFWixKe9i9s/gKpWTKkZQZjLJ9akMYnAkEkmrvo7x?=
 =?us-ascii?Q?5sJ3iyAPJwDLnIzXDMepz/tmokV2/pEzVHCF+euZvt2LcCQJvHO3JUCSMDVy?=
 =?us-ascii?Q?AAqud7YIJw4KNW3K6c7I+VHY4u6xsT4irTfE9AH3KQjsWbchNAXNqoS/IAV7?=
 =?us-ascii?Q?PvDF2F75cgbUPCDSvB3QJ5mpEAQJ3O6ds5nd7yLjzQg+KIYngCLQBo//qr+h?=
 =?us-ascii?Q?X02houQDFUaDxW4cx7ZCmhx7s+d5AU0keatY8botMS4q5U0y97Jgp3oi6mSs?=
 =?us-ascii?Q?y+lxTpYKpBZZ+kjxToA/Hkpxd90z/cuZlF+3+DpS07gdEZBZTKyqnrVv2+Sd?=
 =?us-ascii?Q?U+zTWzM/xSQ8S0p9sl1Tw6WDpoRJlyTaqesxA+uKc9JmraHsHXVIHyPzXuaE?=
 =?us-ascii?Q?yOoe8efEmSUZiDBBa9UzLGuSZjFhRqxOaUPLQAsjb+aB4MgUYnCnqcA65+8W?=
 =?us-ascii?Q?y18OmKxBlRkmJgVQKSvEuYrm3p+Jj6f1jezLMZaxAltvqOqx7tv+MPqbD5CG?=
 =?us-ascii?Q?LTVefD1B7VkRUBUQAX9/soghg7ghhNYYisoHR3pSsPmauzMfhtrJMoXhJ1lB?=
 =?us-ascii?Q?3IIs4CxYMg5mJBAOB5qZ8eIsbnSZhRvs8shwfzyXo9UxzOVaaY/rrMnFrcYJ?=
 =?us-ascii?Q?9e3TIqGMiMrPc2qUyjig6aGcnNEtMZRa5aepqnxQRszMBG44jhEA6i5Rx7eW?=
 =?us-ascii?Q?wHMjpok49dpyXZIuDX2pBbynPifnUFMX5F81YWabuYE5l24x0TAnKOaDDC4e?=
 =?us-ascii?Q?MGP8TOGA4+cefpSWjssxjfDJam/CoI0y4VD9mF5ICrITv0eKIIY91UZulT+K?=
 =?us-ascii?Q?zxzrjg602VW8PoZYqijNIQbFJjKk9fdI8vdgkS2ngG+p3KUzWwYfJoDLDyrG?=
 =?us-ascii?Q?ohpu3t+Q5kA5OIWUQl/hMDrTPlZw8/dKqKa3j1Z6AgcQ/ipPq+E8bUsm0Nld?=
 =?us-ascii?Q?lS7rdFOFM4MQl7k/ODR1NY6/5zzXDyESOidm/2NjrcKXVtt6VyB01BjAhld8?=
 =?us-ascii?Q?frZbR8POLenJsZTFuExZL1wFqHD3LaUfoRerzICExHtUEzXvV4j4k1rWuoT4?=
 =?us-ascii?Q?9ORBqCAWJp8xW+02cpxpVabvb9wUlZA58eRV3b0P7or77g9qpLcX6+dyETLp?=
 =?us-ascii?Q?dyTWIIviV7dH0u1m4I3YZYKSnE5/RLKxiybnp5mGMKTcyfbosnQlwoY5UvSL?=
 =?us-ascii?Q?6TrgoV81N1ZP7oR1Cnlnf0wjIbrvMucsvXSctOUzTiiMi2+wYf3lzDocI2cM?=
 =?us-ascii?Q?m8iSbBd/C/0Vx8ugr6HhbeGUEwzKcZAbX++G4kInUxVqq0tWVH/8jX9abzkc?=
 =?us-ascii?Q?iMfUirMCmXmJmttdxqkNocEUYr5i5oWHTwb2L5frNgzO8TPpz3LOURceH9Ey?=
 =?us-ascii?Q?f2tJPUTtHwdr4SawONE3blTXvBLh2Ux0gpxOJ8AVBFMXtT2MN5aeviHb5PNj?=
 =?us-ascii?Q?evz3ZlzN6A=3D=3D?=
X-Exchange-RoutingPolicyChecked: dvOJI8kYoZ9RtX1KP0c5WjA6VIGDcNt/jRea6FPQrA9junC2X4aaAauiRKucFaurldbjqjENw2PyLS5VDa0wDia7PY3XWvsSBm5g16DHrd397UcEaUjSKGO0PaiJGxN/no0ozpz/ddHRtnL6pQ/tPL4qL39X9TvW3L24Wx3VndTRL9Aix7Oz7oXA/zUA6blLy2wGltLdumpigBtcyQt5M9Oy4RaIGHquy8/Uis0NQKO13TdFOG7eR+4lsXdX5PX+QxN1VMNMCIKJJWf5g0Ri7PnEUo+SjaLpaYpavMNTkStwp4gqKsdzL1z5iaj3MFY/p3Y5HfpteJuIWuays8XxLQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: be2c83ab-8158-4271-5c78-08de8588a9a1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:25:14.2852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bo3bzOA0PWZnQ4wAT6cFno1ngufA/ezCgu079a8oVr8n518t81gRY5Tj8JiAiVu2+Lq5JL3YJckg1+fbPpYwAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7476
X-OriginatorOrg: intel.com

On Thu, Mar 19, 2026 at 11:20:48AM +0800, Xiaoyao Li wrote:
> On 3/19/2026 8:58 AM, Yan Zhao wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > 
> > Remove the completely unnecessary assumptions that memory unmapped from a
> > TDX guest is backed by refcounted struct page memory.
> > 
> > APIs tdh_phymem_page_wbinvd_hkid(), tdx_quirk_reset_page() are used when
> > unmapping guest private memory from S-EPT. Since mapping of guest private
> > memory places no requirements on how KVM and guest_memfd manage memory,
> > neither does guest private memory unmapping.
> > 
> > Rip out the misguided struct page assumptions/constraints by having the two
> > APIs take PFN directly. This ensures that for future huge page support in
> > S-EPT, the kernel doesn't pick up even worse assumptions like "a hugepage
> > must be contained in a single folio".
> > 
> > Use "kvm_pfn_t pfn" for type safety. Using this KVM type is appropriate
> > since APIs tdh_phymem_page_wbinvd_hkid() and tdx_quirk_reset_page() are
> > exported to KVM only.
> > 
> > Update mk_keyed_paddr(), which is invoked by tdh_phymem_page_wbinvd_hkid(),
> > to take PFN as parameter accordingly. Opportunistically, move
> > mk_keyed_paddr() from tdx.h to tdx.c since there are no external users.
> > 
> > Have tdx_reclaim_page() remain using struct page as parameter since it's
> > currently not used for removing guest private memory yet.
> > 
> > [Yan: Use kvm_pfn_t, drop reclaim API param update, move mk_keyed_paddr()]
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> >   arch/x86/include/asm/tdx.h  | 15 ++-------------
> >   arch/x86/kvm/vmx/tdx.c      | 10 +++++-----
> >   arch/x86/virt/vmx/tdx/tdx.c | 16 +++++++++++-----
> >   3 files changed, 18 insertions(+), 23 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> > index f3f0b1872176..6ceb4cd9ff21 100644
> > --- a/arch/x86/include/asm/tdx.h
> > +++ b/arch/x86/include/asm/tdx.h
> > @@ -153,7 +153,7 @@ int tdx_guest_keyid_alloc(void);
> >   u32 tdx_get_nr_guest_keyids(void);
> >   void tdx_guest_keyid_free(unsigned int keyid);
> > -void tdx_quirk_reset_page(struct page *page);
> > +void tdx_quirk_reset_page(kvm_pfn_t pfn);
> >   struct tdx_td {
> >   	/* TD root structure: */
> > @@ -177,17 +177,6 @@ struct tdx_vp {
> >   	struct page **tdcx_pages;
> >   };
> > -static inline u64 mk_keyed_paddr(u16 hkid, struct page *page)
> > -{
> > -	u64 ret;
> > -
> > -	ret = page_to_phys(page);
> > -	/* KeyID bits are just above the physical address bits: */
> > -	ret |= (u64)hkid << boot_cpu_data.x86_phys_bits;
> > -
> > -	return ret;
> > -}
> > -
> >   static inline int pg_level_to_tdx_sept_level(enum pg_level level)
> >   {
> >           WARN_ON_ONCE(level == PG_LEVEL_NONE);
> > @@ -219,7 +208,7 @@ u64 tdh_mem_track(struct tdx_td *tdr);
> >   u64 tdh_mem_page_remove(struct tdx_td *td, u64 gpa, u64 level, u64 *ext_err1, u64 *ext_err2);
> >   u64 tdh_phymem_cache_wb(bool resume);
> >   u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td);
> > -u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page);
> > +u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, kvm_pfn_t pfn);
> >   #else
> >   static inline void tdx_init(void) { }
> >   static inline u32 tdx_get_nr_guest_keyids(void) { return 0; }
> > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > index 1f1abc5b5655..75ad3debcd84 100644
> > --- a/arch/x86/kvm/vmx/tdx.c
> > +++ b/arch/x86/kvm/vmx/tdx.c
> > @@ -343,7 +343,7 @@ static int tdx_reclaim_page(struct page *page)
> >   	r = __tdx_reclaim_page(page);
> >   	if (!r)
> > -		tdx_quirk_reset_page(page);
> > +		tdx_quirk_reset_page(page_to_pfn(page));
> >   	return r;
> >   }
> > @@ -597,7 +597,7 @@ static void tdx_reclaim_td_control_pages(struct kvm *kvm)
> >   	if (TDX_BUG_ON(err, TDH_PHYMEM_PAGE_WBINVD, kvm))
> >   		return;
> > -	tdx_quirk_reset_page(kvm_tdx->td.tdr_page);
> > +	tdx_quirk_reset_page(page_to_pfn(kvm_tdx->td.tdr_page));
> >   	__free_page(kvm_tdx->td.tdr_page);
> >   	kvm_tdx->td.tdr_page = NULL;
> > @@ -1776,9 +1776,9 @@ static int tdx_sept_free_private_spt(struct kvm *kvm, gfn_t gfn,
> >   static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
> >   					 enum pg_level level, u64 mirror_spte)
> >   {
> > -	struct page *page = pfn_to_page(spte_to_pfn(mirror_spte));
> >   	int tdx_level = pg_level_to_tdx_sept_level(level);
> >   	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
> > +	kvm_pfn_t pfn = spte_to_pfn(mirror_spte);
> >   	gpa_t gpa = gfn_to_gpa(gfn);
> >   	u64 err, entry, level_state;
> > @@ -1817,11 +1817,11 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
> >   	if (TDX_BUG_ON_2(err, TDH_MEM_PAGE_REMOVE, entry, level_state, kvm))
> >   		return;
> > -	err = tdh_phymem_page_wbinvd_hkid((u16)kvm_tdx->hkid, page);
> > +	err = tdh_phymem_page_wbinvd_hkid((u16)kvm_tdx->hkid, pfn);
> >   	if (TDX_BUG_ON(err, TDH_PHYMEM_PAGE_WBINVD, kvm))
> >   		return;
> > -	tdx_quirk_reset_page(page);
> > +	tdx_quirk_reset_page(pfn);
> >   }
> >   void tdx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > index a9dd75190c67..2f9d07ad1a9a 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > @@ -730,9 +730,9 @@ static void tdx_quirk_reset_paddr(unsigned long base, unsigned long size)
> >   	mb();
> >   }
> > -void tdx_quirk_reset_page(struct page *page)
> > +void tdx_quirk_reset_page(kvm_pfn_t pfn)
> 
> So why keep the function tdx_quirk_reset_page() but expect passing in the
> kvm_pfn_t? It looks werid that the name indicates to reset a page but what
> gets passed in is a pfn.
I thought about introducing tdx_quirk_reset_pfn(). But considering
tdx_quirk_reset_pfn() has to be an exported API, I'm reluctant to do that.

Given that even with tdx_quirk_reset_pfn(), it still expects TDX convertible
RAM, I think having tdx_quirk_reset_page() to take pfn is still acceptable.

We just don't want KVM to do pfn --> struct page --> pfn conversions.
