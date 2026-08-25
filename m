Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966448822F;
	Tue, 25 Aug 2026 21:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694845; cv=fail; b=SNBc9t+N3oZa6Ph63al2IJfvx+LMLS7Z8mU4xcXhlcjzfTQBYvGw9dPAFFGbklRB3PwRYxiireJxsaiQDGdCnaXCEDl4UcR95KEg5DeUSWpar0FNgKEYgJ3Woket4+U5sojbLGKp8C8uOmAmg/FMVms3jOXcG0rEC22eybMOXZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694845; c=relaxed/simple;
	bh=anLalQhTr0NMonUcpDSg8H2GJJCUBS3vUwi0cNXXV7w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uBFvp85AbQkmc3dFIQDA6orh3ix/4bUcd+yEkTzJtFyVR0php32pKE77aDJDu9s+/+WCwvple7Ig3ZXsnTks9f7z/3RF2km4sGHIGlmiM9IuG4a8gwJqA2NiI6GUwLizJdlxIoTtpdywccsm8MYKcKsqhdOY5M90YX5gxnKZjrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCxP7+Ts; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCxP7+Ts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787694841; x=1819230841;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=anLalQhTr0NMonUcpDSg8H2GJJCUBS3vUwi0cNXXV7w=;
  b=BCxP7+Ts9L2dbX8rF+HblKHZ9XIJZ4wVYtSLDKV9JcnADgvCbpVqch6I
   zgjmK0Imp3cM0DAh/WAPjbWFDSj2Gpw0oxPYjA1AOAnNS/yBTmosDCSbd
   spnI1idid8uSgBCmryBlw2zDYjGM70Tj2c/DE9y0A44CnCIn5Jau2aDwa
   rORumfZFGBPIf+o7smNcH6j3sLz4FBcC+DcA48GuLMFUS/QzagyLB3ks/
   vH2IdB6DionOJZMR02HcPuaHgDE2etAN45c6G/7pmLd4WWGIuVTLtybN7
   5+uBpIzwr1aAP1FIjxtwuDQwscswoLTGHsnMzJ9Y0qIQb3klth7pfHwvy
   g==;
X-CSE-ConnectionGUID: 8EPo26pARyWdnZiS/FGwJA==
X-CSE-MsgGUID: c6WPLCXCTT6a8NtJ76DYXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99329756"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="99329756"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 14:53:56 -0700
X-CSE-ConnectionGUID: QkQwriYsRMKcvTv7WZFfsg==
X-CSE-MsgGUID: SaUdDTV/RgOQlSRQtI1fgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="267974802"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 14:53:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 14:53:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 25 Aug 2026 14:53:55 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 14:53:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSyONoJEFmKO+Q2ov1svbnrDb7E5pNI1SSU79hUR7XUsxhpByuf3pZql8aFl1azAFKML382qCQiDtnSprpmAXN1C6i4ZFJRSXwVi+xK/nKSwwFiCZWzMYcVP7Q/l+UmwM773rOJJWnQFtMdLSXxHVa3InYMrKRZroBN1xxPvRkXA6ZyhYtlDl0Yz8wAI0OsjeQrvq2QaeZba4ixpiki/p4G6jnWjTDoWdGJEhMXglcM2Kc6mN2WHerHyYM40w5lbEKpjoXlRcBlybTOq8CKePAaUHxL4YJN9vAf8I5rpUJGIneWWsYgaC+I0L2GysYPKij7e3kcg8F8P/ZB93MM76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ph7lcgzbDQ1CECsjfqNtbI6AicHPtTPuJgrrvCKGaU8=;
 b=Sz4ddJpwqwZJtFQxWdQBP9PguqftZQ6xV7MRSHwiXYmhwjeSPaRdHDYha6F0vWJOOxBu+i7g7uJ8ei75cPRrG1wAcf9zriJ1Ndy1iOt41k57S8UwHwssV1U0rQrytWZVFakBJyfD78yzfbRYBxI+I7XQx0TRQ+iwsUdoNq28FOCPrcKCnGjSzkBgZHMR52FFTgSRC1cOsUpoc9hmFAg8qLvuZSsf0W7ZGZXXr8O4t7LDX0slDX9Oqedk6AkhxZKhDH/89xBgrRakWyn++ZsoVdzH7etsi4XcxtK/IsE+70OzLF0LE/E3fvSPkPYNQS4yaAm/I+joozyKRQHKFRxoVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by CY8PR11MB7314.namprd11.prod.outlook.com
 (2603:10b6:930:9d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 21:53:44 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 21:53:43 +0000
Date: Tue, 25 Aug 2026 14:53:40 -0700
From: Peter Fang <peter.fang@intel.com>
To: Lisa Wang <wyihan@google.com>
CC: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng
	<ackerleytng@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, Ira Weiny
	<ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, "Kiryl
 Shutsemau" <kas@kernel.org>, <linux-kselftest@vger.kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, Ryan Afranji
	<afranji@google.com>, Sagi Shahar <sagis@google.com>, Sean Christopherson
	<seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li
	<xiaoyao.li@intel.com>, Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds
	<jmcrey@google.com>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v14 13/22] KVM: selftests: Support guest_memfd in-place
 conversion
Message-ID: <20260825215340.GC3694338@pedri>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-13-15ad654a50db@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722-tdx-selftests-v14-13-15ad654a50db@google.com>
X-ClientProxiedBy: SJ0PR03CA0389.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::34) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|CY8PR11MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0678bb-53dc-463c-1cba-08df02f354e0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iVbKwAPZRpxlEjabzTzNHg6GlDnd/9qWUAAvnS4j5XDzlO/WflEUtk0snKeYowAURRfdM/0RIwMkb03YeLwMfxGuaQHhKlhKbkMRcbWezQa4JCRWSJsYLJ1YlBQTnBrcr9Mo2FJpIzD6Rrfl1bpkInPTlwEEL9H0xhAHb33H0eY/Cb9xEOUb5GJjRv60N0IClBpr7JQpRO3h5nDJjURIMnCxSKTr+7G4pnAQiSOyziwABSbUTFP6wfawuX9UAtE1ehBq9Cv0CamHjX2dYrKsvMTBOq3VC/rWbyjGaU5CnbKplvijlRLx58c3ouSxGE8xH7g2Z6lnyTQ6p7X5pCl8blcxokgwUPqILGmN5hZkPZRU7rNJ6CiIgwqq4WnfYplX6rb9hT3DThcVAv8iyqp4jXNkxcwyej1v1cSJ7IhWuhPdBvnI5XuX6BDLYhEvdnqpNoPdsmpFw7/6Pf6mlaMj+0ML9Z0kzLoaDrH5yXTIXLPG0bVD7BwD5cbQuklXxStM182AQjcN0Siot87o6SPtxY1UWnNiOiUYCdzXG4FOq/v2SCFRLZwMxIq9DzJb0M7BCzINx0BvQZNuNPZU/EJXvmguHZFsi5nNbZJCRj1tStsTywQibj1zQh8FIdLb57SYPK1u3DMS7at1nruqhQfVUm9jvZL7EKOU3QMtZUE7eDs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Amw6CYgWszknyucEYCJtI9gZwewL52afNrbeGH+/MI/HkXduSg9vcPpXStsf?=
 =?us-ascii?Q?xqzxuFAFV8O8VIWQX3UI8kcURSPX8S10vYnsX+MF9kMXEBN51qCYedipzNWc?=
 =?us-ascii?Q?oDrCjOhbKJTouPGz8cZG6A+TbhFx0b64inLPf7dtcMvnmfTd6CXtb5YK4wHu?=
 =?us-ascii?Q?hCdKIDQ/TZhUCaN72rmTM6tLrMPvf3vfOr758zulqQVRG91Mh9N1YX35p+eE?=
 =?us-ascii?Q?++9qZQfBcPEjfsytBtjVOES7qCm3mEt2jUXhSHEQnBrOctElnZj/9/XqLyme?=
 =?us-ascii?Q?YMvXEcQPfy70TwEX96hLtf0RU+qoapk5bgKVK8bv+rRSUAKD6erNNFfGds/X?=
 =?us-ascii?Q?nVonwsVED3csBHRq14Qb5iVN1YVx8XGDkTKur9FKjy7Ulixfa5iL98e5G10W?=
 =?us-ascii?Q?rEf7bT+Q2GWbOlJWRFUQo0X2lgv7U3CSAWmNPeS2RpjkrkOj9Ba/EvUZ4CJv?=
 =?us-ascii?Q?fzy6iVzheS7mtfOeafuE6a0v0cym0ld7eHbMSNb2vDP7TO6jade63E/7MiAJ?=
 =?us-ascii?Q?It3SSIMwcDSpEjNu8ydIbuF6deHOimagJgqTcpsp3cjccDu0CAsFF7Z6P8mL?=
 =?us-ascii?Q?3YGb4wJCgVT2XUoU4jwfiPnpFlTfh2YilItkJwT+BKxnANi+B2TpVM+pXfbt?=
 =?us-ascii?Q?7AbO3fuvxeHJxQvgmIsYtBt56OkFJwte93/TyWhDH2UJP8aH+F5IcKUok8lb?=
 =?us-ascii?Q?J0d1e6vo6hxiTqrW9clZzxY/FzponFn91xYFsyrZ1SFNGs00Rkld9sMPGiRh?=
 =?us-ascii?Q?TaF5CBR/v/4xeR9gCbdSe7/VgX0xcMLLeCCPYinakuekUYSclE1onUDMA843?=
 =?us-ascii?Q?weq9Av/m4mIDRLyeiH00xLNX/ZMoAkozrJMOtVaXZv+iZbhaqoO6aBDGc3ya?=
 =?us-ascii?Q?gqF/ZXPO3z13Cz5ME/E2j+bRjrXj6nTWd+nqln4105jKeYhW/5SAvObfutLx?=
 =?us-ascii?Q?2Tw7dipToSO/1UW/VmvdyiIZolnx/c61EwBeXBOv9h5c5c7nJGU9eW2emSot?=
 =?us-ascii?Q?QVsnLy2hhQ4EPg89VDT6M/KkxQllcGdIPIEyBliHSHkoLW0t9oAaZQihlGzJ?=
 =?us-ascii?Q?MDTI+I0Gnszs2Ppp2UuK2MpYySOe2mZc4reFfM4bM5YLuupzelIY9QG4+E+X?=
 =?us-ascii?Q?glg0SbQRNUUCiz/uG/J2IJq8yhJfySgpkEm93NSJKjX3KHCvQRESSg6sXiI2?=
 =?us-ascii?Q?T+ZlXuCbYP6sMMkHR2pr4QodExQZARUaN1T0LLGW1ZPvOtGdZSg579Xdh51L?=
 =?us-ascii?Q?vASl7jx2ka8yfGN9Ue/hlfZhbVhvAikIUWS9l2jpv5ii7v3Yk7aj6nx11tc/?=
 =?us-ascii?Q?X4Ys4X7ZYaQlbc8gQWHYKR1jt/OIIeKDuszy+o8toRwQAMIsq9xWOaqr8wwW?=
 =?us-ascii?Q?EkW6j+ejORSZO1ESIe2cFh4YUxrm+4ie3sdvRa9DnCRpN8DG8U8fOpatU8qu?=
 =?us-ascii?Q?qYoxoh64Ufs5NdflG2HRt32ZWDQ7Sw3yUD10KhfrmaY7gLb9X6NvH7Eq2kJR?=
 =?us-ascii?Q?GIWovvxObYq7DU67jPJYQKOriLZH/9SfTeoX84sf6ewGcu1o1JCCTHCjLsGA?=
 =?us-ascii?Q?ijVdhjc36yTTOA3iEgKZTqC7ddKUv9xda2U3A6MK/6/YHxM5234lzRfZ9RAZ?=
 =?us-ascii?Q?dqeiT7dk7J5WSaGr61Zbz8SbX4lHsLJCt/++sbUa/yrlXTD9dmYcXYKN0s6/?=
 =?us-ascii?Q?IM6ek7VOe7Gt6ZNsjDhmncFRae6y+Fkzauqgv3BYUAahd4vnZulfZJs9g+A9?=
 =?us-ascii?Q?e1AfHT1QbQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: EUyfQxlTtEww/gla151j/2bkvgxO/a9Ngjz1GJhNFZyFFUbkUn4OU1MKNkRCyKr7+ccLedlVsN6JUkER4zt4PsqUdPvzBz8fk6xMOKf2dUkZqq7HBJ3AV/OBCesYolR/iu6FFFgccDMau6wntY91g+9+Jfeky8qHjFKXLCldlEpDwjKSDhM6RDAaCxsdNcrn8iEU0LLEvYo8m8qRzv+brFwM7jhNtaXctZPFIN5bqk41mx1FkRAQYrqKdSkquPXIjJwA2e8OMhcrpv0+soTf/jor1Ve+/7ZanQllBLLacutnxeYEc229fBt3yOsNnQ7hUlOBA4ij6kcHptD/WEACHg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0678bb-53dc-463c-1cba-08df02f354e0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 21:53:43.5207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/lTz2OUrcq8RHAenkSgMBaTQKo+cdB36pQAeHGO2qVOklgvwCR3yEB3ob45s3+46Fxe7nlm1MkaC3l0r1zt4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7314
X-OriginatorOrg: intel.com

On Wed, Jul 22, 2026 at 11:13:18PM +0000, Lisa Wang wrote:
> Set the memory region as shared if guest_memfd in-place conversion is
> support, so that the KVM selftest framework functions can populate
  ^^^^^^^ nit: supported

> mmap()-ed guest_memfd memory the same way memory from other memory
> providers are populated.
> 

[ ... ]

>  
> @@ -495,14 +497,20 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
>  	vm = ____vm_create(shape);
>  
>  	/*
> -	 * Force GUEST_MEMFD for the primary memory region if necessary, e.g.
> -	 * for CoCo VMs that require GUEST_MEMFD backed private memory.
> +	 * Force GUEST_MEMFD for the primary memory region if necessary, and
> +	 * initialize it as shared if in-place conversion is support, so the
                                                             ^^^^^^^
                                                             same nit

> +	 * selftest framework can populate it exactly like other memory
> +	 * providers.
>  	 */
