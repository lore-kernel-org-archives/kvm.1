Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C023A18FDBD;
	Thu, 19 Mar 2026 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773924820; cv=fail; b=K5lx0oGDYIm2QmxAyveQlsOFP/mE06VODOyYzQs1pxfET+NDQLzIqERfa3M0kaIR5m7Jw8PgB9Hga6yivExelDAaIjX3JKnIIZxg2YschtK0bv7Jqg3WgqryxS6wivxgO428fG/HvaQEJ0/1L4yoeCHK48L0uKy8tsPXSfBD1vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773924820; c=relaxed/simple;
	bh=PrsROBIHwggpUyuAsXIOSVkuCiBSDy8HFnxYat3w0ic=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R4rIPRKcBzhO2xjz+NpdxaYf8x9VV2fvrgB4tlOQ/jhACoJkpjm+4qOroKDiQGGOreZWp4areLdS42ocOFZFXbP1ptIySmjUcOc9txapNcD82O8msY41UVunW9J33xKNzeYRXwLuETL1S/lLVafWywezMjH+1gKi/U5DHET5lmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lh5mDFbW; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lh5mDFbW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773924819; x=1805460819;
  h=date:from:to:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=PrsROBIHwggpUyuAsXIOSVkuCiBSDy8HFnxYat3w0ic=;
  b=Lh5mDFbWk0hXPLdumHe7Zbidg39o5EhG706GO1oIR94TBNjxAPJ0cEeU
   81dEvSPh4hobt2PU3MW0a6iZEivKbGz9MdRrTVI0juC6DKJX3UHsZUlWc
   FgPgQAUF7rLIcrPHaY8dBlBK/qNwRtsh0U8aEuKvWGKT404/NKGzs0MR2
   iivCMbyqlsxIDxNAPXUquIPFjgpiZciqwtdFr6GWw6qn/efGfg0Bwsk/l
   f6ScDgShuoB3nGgdYT23TzJM51uOcpBrqB6cPaXfjddRFfKbOccE/dtbw
   8WNnLAqpnCyAoCKVk9WZ78sX7ANZaSPKn9zMy+3ft8RPJexBfk7s9ijDW
   Q==;
X-CSE-ConnectionGUID: vcSFW4kRTGWLAN58EiDaVA==
X-CSE-MsgGUID: W3jEYUuTSIK7ueaXyc/3mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="78896990"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="78896990"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 05:53:38 -0700
X-CSE-ConnectionGUID: Y4sWW+zVQ8aRq2EC/DUhwg==
X-CSE-MsgGUID: J3vgFH6LR1inmeE3Y70OQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="218863340"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 05:53:38 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 05:53:37 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 05:53:37 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 05:53:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRq0zToVieLAnVDZ/kiOxximfzVHcTeTTaYffnZRO2JYXX5KAJbRw94Rv+A7Ehuj7wGXHaYsvHNdqTUmv2pjtaWmS44g0tH00cxNky+3i/q/WK+iMH3433u/R/3rUIU0Hn3oxaJACTrSOQQEPyieR6ePbVlA4QPdoVikPNwhW663RnStVxfv+We+uXjI3PUUe8NQl9K7t2UOdsCIJnjSdeMf+eu88Jz3G+F/Wd6gvEI5YdSryT3X40R8EJqnfmjhzpeszW2O1qYyCDDYPkhYzap1VN8+LEtKKXNUMQZ5GHO7Vdg0E0lexynL+nXX+1JU6dY7ZR1VkhHNUvq5BY/srQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvY4MTJAOznB5lafCxG7xHHcFqklHnKX2MiNYxRN0tQ=;
 b=WZjUbwzS1HnoKF9wPr6Xc0DJrZKQsgU2WQbMK0e6rwwZl0659Ibnchxan/0PXfsxbQBmnwBTjS1JkXuT1dbNAU/Ol3zUD5cEQ3Gq6yoXEnJZjOUEZVqqoStY5PE32bgGVBJyLLgItJoCXFh8hTOb6piQ5UcQaH6HgobQ4LqVHCmXJenfPz0k6G7vbpQ6zMtMA0YJPxpCnahzNBoBGct9Rp2fM+H5jQDpz/0vy0RV4BNaNXl1z9c0AF62qYvkv3fzsU2vtKH2VyjpaSLZYZaUzuvXg4HH9YJJraGLwe8TYWJOJsnWz8SokTFsC/gben+DxoxEzR/Vg017uFrRn/YXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by MW3PR11MB4732.namprd11.prod.outlook.com (2603:10b6:303:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 12:53:32 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 12:53:32 +0000
Date: Thu, 19 Mar 2026 20:14:03 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>, <seanjc@google.com>,
	<pbonzini@redhat.com>, <dave.hansen@linux.intel.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kai.huang@intel.com>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@linux.intel.com>,
	<vannapurve@google.com>, <ackerleytng@google.com>, <sagis@google.com>,
	<binbin.wu@linux.intel.com>, <xiaoyao.li@intel.com>,
	<isaku.yamahata@intel.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
Message-ID: <abvoi+nZu17+N2tV@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
 <20260319005703.8983-1-yan.y.zhao@intel.com>
 <abvR2A19S4ZtpAli@thinkstation>
 <abvlOcnY4assk8DW@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abvlOcnY4assk8DW@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|MW3PR11MB4732:EE_
X-MS-Office365-Filtering-Correlation-Id: d6541536-3d88-4cbc-4851-08de85b686bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wae5yVmHIpwKrt0sM0YViSh1z2bcVbiR+2NigCpFP2ILb+ryjD3c62ntjSukrtqS+MULkqaFAEWKItrK/FrDQCYdBz0foI2JRfojxRDss9JbcifZF9pP3T4UwcvFsPnxLQIu0a9gAE1ZZmDl1Bh5j7UwSQPvG8R4GhZcwnplVp9T1blyEDKidmGO00Ie/9fk8YKbWcamWM0cKWlp4tdKlOdK7oSTxc7M7ktDRd8trc3VoXV66I82akyHYtkSsMT5TY9Ol0E2sdd7v232dwa2lLrri6jZ20lDJfMGi0RR95hqWalGs8dENp3DspFK1pgtxo/uVQNUyZUe3qYMgtdumJa9ZOFkWKW0KIAoF7LU31qiI0qZ71kQQmArHbUu9lSwOz+gWfLk3dgD2umMbpGe2hwSEXWQJ5l/vbkiKbBR+JGQTHBNBzvewPR4XSTxiKAxo0hE/RG+I3bwqyzAIqxXEKkRvabsfqJhV86bWTQf2dpKYrMJBKqP6tlC38BKp/I950HV7Rie1VfHpCY6NEiV9WqiRpwgwjIdAOcbZySpXErYHKXYAkcjZTvqAiqMXUhrCNUNr1UducN/yLaoEgN4rV7oOvw15VAx9yBq+B84iemdFKQtbjTB9a4A7173CXKR8J1fU0LJ6zgyS1OtWMZh7r8fNL690G5Laa6CMzpX0SrMLiYNFmDvcJJPpTHpOwtrNEX8elurVUAPnRCx8tRIA8Mrmaj+RzHcrtIBfQqPTQFigoN5xztu1AcIMhEhjAEQsLg0IgQZd2p8sDv3sd2I52550j1ES5TS5zizet9RsOE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g4sCrgwLPdqii81cM59QjZ4jtbRIWj0XMglCBPsBWxcLBaZIjzJ+GY6rvHml?=
 =?us-ascii?Q?7FlkWK95mUGbAwAI3swiXINrLuhqEbj/aFH7B+4NZquvtdoBI+0Ee5LzYzf5?=
 =?us-ascii?Q?b/2f3oxwXprejXTDOpb6RxLGaQhrpCw5YEO7L5TEvn4wdFLA/azUq+0M6mUV?=
 =?us-ascii?Q?SLzb4yFH6TK1Ayu4Dq230y2tOrMVQg8kyJI2nWGw0ZXVVUxMuhGG+RMSG0wX?=
 =?us-ascii?Q?w53dkpVxX1Z5KqjDHC66RFvq/WB6uhcgyGqEnCChPV5Hbq7KJai7Y3nG+xlw?=
 =?us-ascii?Q?e/fsUjQ0gLExBwhlC5cN6rcOIIWAPdrWprA25fcbTuqHOaObTDqrNcEQEct+?=
 =?us-ascii?Q?x/jK1V5z14797M3MFsWPJFpNlTi2hbTScRe0awF+eIjpkWpWpowU7fXtTUUI?=
 =?us-ascii?Q?SVXtuhzkNLpyRWgsoZtYbjfMgmpxNaV5qsj3rr34Q5Q6TFPOFZNAPN5YC7lG?=
 =?us-ascii?Q?G6ylkJLiW0PMNUyBLdwnWXvyDHGJ1K4chtPDOSMZa2Uiej2Nt7bZvb1wqaLJ?=
 =?us-ascii?Q?qlUndhLLZaHcOHBUzpMSnI5Asn1cymZtKBPqwajPfFRc9sxEQXzJG0DlzF5A?=
 =?us-ascii?Q?jMpJNKNkn68V102LdRC7E8lvloF4s2cTfVWPLyPwlX7kTr+IpJ65tnhpy7Ep?=
 =?us-ascii?Q?2uG03VWMv6n7EoisPRbnj6eixpf2rh88+3FNZkwgXTu/ONNqCkXhaTbAQiSC?=
 =?us-ascii?Q?hFnDTH1mrLeoOdFLDd1R3GdXPAvK6+VfU5OBTAsg8sEr9qagrFI/byfnli3W?=
 =?us-ascii?Q?iHvWM1yv8ITIvyKn3H1d5iFvWSBQAzZijeVnnG3RrnWjWyy/4k+661o0+Ihe?=
 =?us-ascii?Q?1pjktbK/bHD16s/+ALRSKca8zqmhL9eU51yjZapKfBSzrrtW+NVf6hElTvxJ?=
 =?us-ascii?Q?WXMRMPb2oQ3lbZAa6nk+9XZdlM5NInaFUhpbd2HWUtzIFu3AJ6QNnNYHHj59?=
 =?us-ascii?Q?0h3iHFYPpRIvNF544n0lQsPmOUdgoFJ4Lf6qPvQY56QcaI9gFMsWxRtr8HGI?=
 =?us-ascii?Q?DduXHVxnEx713aleBeGhv1q5VRw+qF6Mz8upanBY91SqRyb3rbiIZu7Mj+7W?=
 =?us-ascii?Q?Y3XaqEqL2724EIDzabqbl1WPIPCWMm5qI2J6n/e2j82J2M7zN7AEof1lnVBh?=
 =?us-ascii?Q?daWedZYtbbExG/dgIHMzVOeV4HSteVSdl9RbEuKv+PPHhpcbx4FhsmAwIwX9?=
 =?us-ascii?Q?ceKyp7w8Xk3PSdLDRyTz3yDw8n1aYw1hSZH0QhfcdCRTfc980wzp0SOQwt64?=
 =?us-ascii?Q?QkfQB8MQ8BMrhGvYLjPVtlWvxI789+Afn2NgFEVle+DQj3ASXm/RrWcKvRVz?=
 =?us-ascii?Q?R8myQEJa9tXKJYo6wEPSy9PUivgYudM9BWRiwAIKF4QPhqH7AlVf9QANChuo?=
 =?us-ascii?Q?S10RKyKI4RF+6HFKbbJy8nJrKXzvOjUzopFJopEyXAj/Nt3OVueqje1f0PdF?=
 =?us-ascii?Q?H9DgCg8f7ksry/KxXcZJ6QfWdquwhjB2kTlgcDQ54LB5wNjPLbu+Q/SW5FhT?=
 =?us-ascii?Q?Tg8ZQaIAQ0zeEowVuKLK/Mm+sZIFfAa8+AbZveVzVlJ89guc74q+tdf6S4K+?=
 =?us-ascii?Q?BVqBbEP9maCE0W6IMJSB7Q8AeruadFoCKXNZyjrGDXh5PuwPtQM5ZeC+7B7X?=
 =?us-ascii?Q?ZWwL8BmtKHHfJc/XoarUgnFx751UxcdlvGRjD1BpHOMiCKAYMAoqsCeyR1Um?=
 =?us-ascii?Q?FAtcnMCNnLbAcr7Qf5w8OFdp8U3tkStsZ/jm3FVDxfdfZ8GZMN21F/L5K9ej?=
 =?us-ascii?Q?53Txu5eXJw=3D=3D?=
X-Exchange-RoutingPolicyChecked: BXPeFi91KXhUE+nQUCfnQ2EvedHgbSOcEOj8M146xETIIU2nJ51Xv/i4s+qxQV74ToE6UE4/wtrsngvpBKHa1Mlm/kZVZur/ExLG8a00Oefy+Fj83rV7PkZihAW+ipMLr0hlWmkJcISZWBzuf/s9R4uLhhqh7xqzpMFI2wjHEUzfWtwWx54Q3d6Qizp9eqYt/X7jFxx8EX/IGSmj6ekH9oqtERctOQ0hakj3G3Fqz54ESUWbCXeSrAD2R0rAw6kGRiRAuq02fXTE3CNrgD9ne42Q8K2pKjXX/qNhSYewdkg53oZO773RyWe11u+Gg116Q9nxrsw0kvu2ZIFiGHC27w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d6541536-3d88-4cbc-4851-08de85b686bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 12:53:32.5762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yA+QKomJDxLVBH6kGGLKQaBoQ6MZE1dqE0y6y/C5nPIFfL/h68Xos6u8tdhCkHL4d/1Md+QSNavrWJH1U1wDDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4732
X-OriginatorOrg: intel.com

On Thu, Mar 19, 2026 at 07:59:53PM +0800, Yan Zhao wrote:
> On Thu, Mar 19, 2026 at 10:39:14AM +0000, Kiryl Shutsemau wrote:
> > On Thu, Mar 19, 2026 at 08:57:03AM +0800, Yan Zhao wrote:
> > > @@ -1639,16 +1644,17 @@ u64 tdh_vp_addcx(struct tdx_vp *vp, struct page *tdcx_page)
> > >  }
> > >  EXPORT_SYMBOL_FOR_KVM(tdh_vp_addcx);
> > >  
> > > -u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, int level, struct page *page, u64 *ext_err1, u64 *ext_err2)
> > > +u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, int level, kvm_pfn_t pfn,
> > > +		     u64 *ext_err1, u64 *ext_err2)
> > >  {
> > >  	struct tdx_module_args args = {
> > >  		.rcx = gpa | level,
> > >  		.rdx = tdx_tdr_pa(td),
> > > -		.r8 = page_to_phys(page),
> > > +		.r8 = PFN_PHYS(pfn),
> > >  	};
> > >  	u64 ret;
> > >  
> > > -	tdx_clflush_page(page);
> > > +	tdx_clflush_pfn(pfn);
> > 
> > This is pre-existing problem, but shouldn't we respect @level here?
> > Flush size need to take page size into account.
> Hmm, flush size is fixed to PAGE_SIZE, because this series is based on the
> upstream code where huge page is not supported, so there's 
> "if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))" in KVM.
> 
> Though tdh_mem_page_aug() is an API, it is currently only exported to KVM and
> uses type kvm_pfn_t. So, is it still acceptable to assume flush size to be
> PAGE_SIZE? Honoring level will soon be introduced by huge page patches.
> 
> If you think it needs to be fixed before huge page series, what about fixing it
> in a separate cleanup patch? IMO, it would be better placed after Sean's cleanup
> patch [1], so we can use page_level_size() instead of inventing the wheel.
BTW, the cleanup patch would then essentially look like the one in the huge page
series [2]...
[2] https://lore.kernel.org/kvm/20260129011517.3545883-27-seanjc@google.com/

So,  if a cleanup patch before the huge page series is required, maybe just
adding WARN_ON_ONCE(level != PG_LEVEL_4K) in that patch?

> [1] https://lore.kernel.org/kvm/20260129011517.3545883-2-seanjc@google.com/
