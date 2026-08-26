Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A546EF77;
	Wed, 26 Aug 2026 21:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779363; cv=fail; b=Z80sefDotbOBWmLjbfB045IltMyB5ecnPEMyNjHMyOtpSasvJe6kgyVrWqyE6BdhYqDaJ9FxVnilGFShvAA3Kdq1dv9BrdOsdh0zTnUIRkuaUgWrX9N1wH2E1gTAI322o/lO+Q5n3CAVoi7qa0sxFrFCjcxrnlDNvk0nlAYNCdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779363; c=relaxed/simple;
	bh=gaRNPwJ2zqDYX88skkUB6dEAAenIM6wbnffeS4eZSwQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j58siqSLbeO31atZTgOWTXJB+V0AV17QkRsqu6FYp/1ABHwUd2DfmP7D7cpzJBsVpUpTqBBHHuP5dzm3NS1IjQo3myCpr+llbmQDhnyszQPZbAd11lAhwYmZJM98khE2lDHwLpcmjUwNUcmtudReT+vvzVzN2E+a3QKL+1PEPIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZtNCESk; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZtNCESk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787779362; x=1819315362;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gaRNPwJ2zqDYX88skkUB6dEAAenIM6wbnffeS4eZSwQ=;
  b=IZtNCESkiz8D+e+MN8e6OXqzFaIMz8xkkZjerp+evDRv1+dM4QPjE/fa
   HWszeva/cIXVgH+8QemWzWRA/353dCH9q5Jvd9UvxE9eWRpFLIEW46lhN
   gmE3hyOYcQlPekgbNzMxxUlCRG9Exa6fA8y4zA2WgysKIS/b33gfoFDVi
   zei9avE4ggbKjy5zV8onBr5U8kKQFmbPB55k7gBv7IAtbAos7kIUVQXwC
   65mYEclyxDdkeS66jjlf6ClDFz6cbvBpIm8RdMe792dD/o7SRb4Dhg04W
   oEnhFhqY8z1xSdfMBqX2aS4hEJe8ZkEdMmDsvEAkFSN8+6SFmYhElE637
   A==;
X-CSE-ConnectionGUID: 8a4RYyHzQTK2S0WC7pISOg==
X-CSE-MsgGUID: 6CtRsEheRWCvIcfEoRZ2vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88191763"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="88191763"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 14:22:41 -0700
X-CSE-ConnectionGUID: Kt+pNgcrQ7O1FpAKtaOB3Q==
X-CSE-MsgGUID: 7XFHKXp7QXq8ooA5vcV1uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="271484219"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 14:22:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 14:22:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 14:22:40 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 14:22:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TddRWeBskSn7g5fyF24fXnPv6dF+5+sI4ut2X6XGfQRwR7bKQ8MtPQDt6xy+xPy7agCDD6LwK+l6LjZoNiUUVi5YKh5axhuXgh1aQtxy6H1kYNytV+t4KttL93zJBrCaIOaL5fIXcik7kTfmCKTWzYcTJlt12/CQ0afhpcf3h4ZyBUoPqj2SvEZ7Ohxqckd4CQuHBb+ygn1khYGCQwgZqpdzE/slxgywYmteZbC77fOFAGDM/V9BWPepvCVOLE1MjLWJB66COeDD2F+ylSxNe8yDynrfaGCSa/eN4Cv3ppMSEbktlIp4jFMdBO4iI9DT2ix1BATZZnthG0DOcNw51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kU+JN3TiTi+NActjqkgpp05Juw262G5Bc/qjp9VLfeY=;
 b=bZman0UzrigqzNRPcG5mc050jklOZGXK6/wwj6+ToM5L/bvLqBJD6lFH00y3ocwrUgTWHoEeIjjakr13hFjDSNrOJ70ON3SleGz7NPTTpLgoz/bBIPOHbdlqGh/mvflf6BeUTqOQOH/Ch7Jz0oULkKxrCHarfIivnv9S8RchnLVrUWgdhE6zhgMBX1wnbxXxtvn8EbX9JJg9W7kPUcwoLtBVCn7AcnOmWRZLfYTus3Uh6XzfU7yOa54CTQCC65qAz/dfjgVXYUzi+knPCHcOd1U3HIAmg1UFY55LUrOXD4SnICfJCDpGWFTjtbNpAUV+NLRCcg1gp2QmF7FVCsR2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by PH7PR11MB6796.namprd11.prod.outlook.com
 (2603:10b6:510:1ba::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 21:22:37 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 21:22:37 +0000
Date: Wed, 26 Aug 2026 14:22:30 -0700
From: Peter Fang <peter.fang@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
CC: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Ackerley Tng <ackerleytng@google.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>,
	Ira Weiny <ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang
	<runanwang@google.com>, Ryan Afranji <afranji@google.com>, Sagi Shahar
	<sagis@google.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan
	<shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds
	<jmcrey@google.com>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v14 15/22] KVM: selftests: Call KVM_TDX_INIT_VCPU when
 creating a new TDX vcpu
Message-ID: <20260826212230.GA33657@pedri>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-15-15ad654a50db@google.com>
 <31ddbd64-eeb4-4008-87fb-ff57de93635d@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <31ddbd64-eeb4-4008-87fb-ff57de93635d@intel.com>
X-ClientProxiedBy: BY5PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::36) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|PH7PR11MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a0fddc-9369-4680-daee-08df03b826dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: PO9Ehqm/RIX+St+P1nHHOJXS99jbF1lz+1JQHglnKxO0x7dnp3Uzv2uckBYz2i09fRBdcTWTj8NQIDYUSJVWhH5TVCXnK549d/PbVjtyi0d6xY9zSTls9cNL6UtVyaKXuGHlH3lb5tgEJdpshLodw5Ub4dveHdjyP5/MR7vRRRltWJUKj7HQfUUt7ldDOK/YJ3t+JkTmPfGYi/P4k1OKsWLhLzZg/5LvuT7AMquVkdlDhxBO0yt2fVnnJEWKVZRwZCm6xFyHJOmTRLM6e1jlkpqhTqazwC3OT+edDljli53+PFnptsBaoPYRG9cY9xxcS9PA4plaCT15ecO78dChHj9aepLZ/lz7Npf0lWoIr0LRSDxID6je1H5PuqAMJR8XGwMlVYuKBqpXLj94Wyx/hBMHXhBVWFkrJc9bJdZukUgocmWhlaE0+RuSHdpMtwuH0Zk/8dfO3jy0qtbKvpuAE2wUuOtCOeZAED4MT7CLEQkJZQ20oGmHAH1N5d97CK2gK91dzl5v806Df6KQos+9btXaqBQLhcPfD7C8dNNO/ZLkjXT0a2rmGDRyGVVeeEBaae+yCvHsG7/zvbJCGejSP8cpQjPxyKBue656VqijuO+Ng8dC0luRgDrScuK4YaC54i1sm49/6HUhOBhs65eLvrN+nM45SHHRKumB1WoUj10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?unWx4ojFhTGWhty9uAlZMtZ0BVcJovBMG82+otsi0l8XNzZ0GahF2drfOvwi?=
 =?us-ascii?Q?A/wxkxf2owwEEVb1a6yzoF2Gg/I1iW6kX1KCCWfnHo3aykgg934E0RBO4cNn?=
 =?us-ascii?Q?0USxMiE4k40ycqvfn+nGN2owJ7veA5Dz+4eTwPQVMpA+84jv3iGESqesrG5+?=
 =?us-ascii?Q?RzQMEeA8hN9nHC4K5GnqnWMK068v2VjDOS0ROvqILIHuSUpyA9pe5moOhOXK?=
 =?us-ascii?Q?Jj27KWk0GeYz5zIC7BlyAB9Y/KfyVaffG8PQJbdDXoCLva7qreHHrF28DLpj?=
 =?us-ascii?Q?KPGF7x+QS69eRTJVF1XW/QUarRgtdKy4tRSNBSYSrDtoUBlM/ZtLzDcmgnEM?=
 =?us-ascii?Q?cJietiGE4gPb7EKjPUN5gwqZpX2la0j+gyqKCukYXgjZ1hOYLf76QYjw4Rw1?=
 =?us-ascii?Q?PyzjsbgTkCteq/q1NCtXKcPzBQnfbDa5LiiKk4osPlZbo8QCb+n2vevl+osv?=
 =?us-ascii?Q?pcPibs+33zlfALuwmQnlZH9e4ZW4vZvgEOKcdSGW0Y9NgKcrMdNksAXdmnwE?=
 =?us-ascii?Q?k3CsqAjdlX4L8eHQIo3lwsWizSiiU91Zw0cRmJM06YH7AZ4HFwaKeEd7ZjbG?=
 =?us-ascii?Q?wqXAwMF8Bvv+UkqnP/HBE9ZfWR87/wndbC3d0ovZVsx2Su3Uf0D5/5IqPPOw?=
 =?us-ascii?Q?LoYrtRqzvas6irdGJCj3efyO1GcKWK0/5U/nlqW7vg9MXbmsyzjD/B4ktusf?=
 =?us-ascii?Q?eDbZQvMwapG3XPCryf03XAqM5SnKpbofIhG2BLqfBgY+Kcqd0+Z5nI1LEZBG?=
 =?us-ascii?Q?44HaPNBcg/Td1nIC9M4j2EZl06UY0MZVAuVY9aZduFB1dEmo97t1tPZl2WcY?=
 =?us-ascii?Q?u1dbcbylolUqH3qiyzlSEfG/g8sXK0jUryz3hQDu3yZiNtwXTBaSnq/N8rP/?=
 =?us-ascii?Q?+ryA93EiOmP2OjD84Al54N1WULOMCpraa3qY0p2a9KcXgjqNtzD/Cbi0TUYI?=
 =?us-ascii?Q?NXW59R+aT15+fVVaHDbI8JjlbWYNCKaYJoBE9Tg+UTVUaNply/qHgv98+QCR?=
 =?us-ascii?Q?JCGqIzn9BIboKoRiDZV5Scl/BveVw2eXUB5/EzFb7qVsxCrmDQHOKvfg3dGI?=
 =?us-ascii?Q?m78rO1ps2lb6UtJ2ZzxljOOu7iwrPArrEcWMDZ+FelYfJP649I3a3qTDomRw?=
 =?us-ascii?Q?yyQgb7B0h60MGIeSu3x4kTYhVNNyXwTzMJUm4VDmooMtRNvdo1Cfk3C8jucS?=
 =?us-ascii?Q?+dFVDcWsSQq1xXp+dOnixLAKbYAT+9juO0P8E8qaxXZo6L0rvQiG1vZbgHXP?=
 =?us-ascii?Q?h9QR9tugOYNvZSqIoSYMLmTZYk9mSG+ZJ3WTloe/rcEde0NdxpLcDtKPwae+?=
 =?us-ascii?Q?1H2wvxmwVsj0ZALZ4Z3Ynjbfj3iWNKQFqtiR9JT/l57Td2mS3ACaXG4TRTkg?=
 =?us-ascii?Q?sU8LqYzd91A81AO4j6ASd0FqiVkSpPMNK1O6lAl4pVFk7hUGBcpA4EQlDyHI?=
 =?us-ascii?Q?XBAtasWVy4mPouRXf7sDbnnZ0kFOc2m/BgiXhbU+XsQi54Sgt/rd9Dwih6oY?=
 =?us-ascii?Q?SmbPDJPo2iEq/zNm3qXbxEnmug+D5jVIRzMJa1HsIGaizeys14+jI3M0tW2J?=
 =?us-ascii?Q?L+KSvvyrQHVQ8lxa43VHY3lRH7zBLflECHzovmC0jVPci5weAhov/BpFUO2L?=
 =?us-ascii?Q?qoQviLpxaHY6E1ci+2obQ9TR8KpnwA2lCu1klDRIdPDN/2ld2xXj+9NzfEj2?=
 =?us-ascii?Q?zWyjY9rFY0m2z4qQ1MuDt/eXaJ/MTlkVTvPex0Qtn8Dz2+ixL3A27UtEUeV8?=
 =?us-ascii?Q?+rFv8dkYnA=3D=3D?=
X-Exchange-RoutingPolicyChecked: rdg2K0rShaLIHQ0aPKiUal3q7xppJop/yyn5unYxjK9MQg2KcmJKDqUiadkJ844Agbuj3SDhLPiYI50PoLc62GqBJGPSbXkZvOup0i7XLqzHNn9stWiv7g+bqTbwXeDXVLx5i5Gg7OyS3mMl7iY3GQZ/YJernfsEtgtL0d5h6QZpku+LbxqC9nOT9KIr49VLYrDedGm28+A8ejhbFrJtrl5tEVQCiju/SqcrVbfOYBFCLBtJtSw7RjNL/9oC7VnXPOLgaMxaBVz8lks8ocKO9dVAgB6j42o/ub3byFlaEg/UUhQbxLRxzFkcucuTsuu0YjY1H2dnC7xWCS7oTXfqww==
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a0fddc-9369-4680-daee-08df03b826dd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 21:22:37.1857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5SuIoT1pmGgTz98/HcgtbthNRYmuf+qITOBzz8o0uSk6JVX0zVfbO/xujaUe+5945qbE5BYR260l13PN/YRDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6796
X-OriginatorOrg: intel.com

On Fri, Aug 14, 2026 at 04:32:59PM +0800, Xiaoyao Li wrote:
> >   	}								\
> >   })
> > +#define __tdx_vcpu_ioctl(vcpu, cmd, _flags, arg)			\
> > +({									\
> > +	union {								\
> > +		struct kvm_tdx_cmd c;					\
> > +		unsigned long raw;					\
> > +	} tdx_cmd = { .c = {						\
> > +		.id = (cmd),						\
> > +		.flags = (u32)(_flags),					\
> > +		.data = (u64)(arg),					\
> > +	} };								\
> > +									\
> > +	__vcpu_ioctl(vcpu, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
> > +})
> > +
> > +#define tdx_vcpu_ioctl(vcpu, cmd, flags, arg)				\
> > +({									\
> > +	int ret = __tdx_vcpu_ioctl(vcpu, cmd, flags, arg);		\
> > +	TEST_ASSERT(!ret, "%s failed, errno: %d (%s)",			\
> > +		     #cmd, errno, strerror(errno));			\
> > +})
> 
> It doesn't handle the tdx_cmd.c.hw_error for vcpu ioctl, but handle it for
> vm ioctl, which looks inconsistent. This at least deserves a justification
> in the changelog.

Looks like this assymetry came from a v13 comment [1].

tdx_vcpu_ioctl() actually doesn't write back hw_error to userspace like
tdx_vm_ioctl() does, so hw_error is vCPU-scoped only right now. This is
a bit subtle so probably deserves to be called out.

[1] https://lore.kernel.org/all/bc8b458e-7893-4ad4-89a7-44568c227d32@linux.intel.com/

> 
