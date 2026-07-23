Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1367D3803D3;
	Thu, 23 Jul 2026 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784794807; cv=fail; b=uskBjycjY6ris7ZZNSWQv3D+b5+2V01PgvMBi9cHlbgwfBlQOvJ780oYwkERXl3Gy4bwN0YHj6HnLhjZPaFMJ8wCUZ1KiGqkEpweWj+/YyaS/yPMMXoSMVhq9El8DmNgIikIdxXIJ10bzoJWh8ZaZN2FBkyYGIkNBAku/I1g26k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784794807; c=relaxed/simple;
	bh=VcGn8g5OCu3ecq+SZmdDs+FiJw7ZZbJimylaiQMiRxQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y9etFd2yn9ZeufHJNdx97UXr6mBgohZl10bUdKE4uj6Mk6fX2sdY3TxksWZpjIbweesY6hwtwpmkmN/vAUk5EhFxlmGFj7xjd0KAGeckwDDSHdrVpfCKkeZpKH63P8B7eDLy9ZvUG+RVAhGqqOBTp2gFAZDEDOZRx2GZEqof7QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aeE4usdb; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aeE4usdb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784794801; x=1816330801;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VcGn8g5OCu3ecq+SZmdDs+FiJw7ZZbJimylaiQMiRxQ=;
  b=aeE4usdbJDXW6HT+fSKUEnl8CfKvx/LV+C4pjY7r+q5tIgLAOv8bU8WF
   DfS5potXkkksVDGLpYE1gekeLGO1qPT5YnPDL6E8MU0s0dP5BKtmMCQG5
   U3rO6CeVKoR9cQUjQNDxYgNQ5SeprT5+KIUtkuD6QtliE7qPALM78EBfH
   I7IwA3v/XuasEF/IgaRBRM4sAGZbhFQrUR/gAPmLp2Jnpkfu06q66oujM
   RXLuM4KxrNuZE130xVXelqHIWkBJ8wUawapIQHGtRgdl/1CIvY3SJPflX
   WkTbIh/8aE7L4BnEuVYJz1Az3RqDAeqppwD1SbnpJtDD008XdkGDYfbHu
   A==;
X-CSE-ConnectionGUID: xH20ZqTXTy+uznYIisPsOg==
X-CSE-MsgGUID: 6fc4+qbwSEKyPKCkjkQrnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85388442"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="85388442"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 01:20:00 -0700
X-CSE-ConnectionGUID: nOPlgroEQgSRoGcQ8iNyLw==
X-CSE-MsgGUID: 0P6BXMuTTlGTd5uTlbjd7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="260305488"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 01:20:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 01:19:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 01:19:59 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.49)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 01:19:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVBmmawGwkdLISNy/EWUC5WDztB8xioSbYdat6IE+Q74IHcJW8F61qrOXBDArl2Rhp1KELM9B+cX8Q/+VkoPhlKrG1dRg+GLsrB14As92mq8N/dDOkhBuXdEMVuHJO7sWzuJmTr2HrYuB7g28kI3BssGx6UnC/kW6ch9JpZFo6lEAHGFKfIio/1qgWFj6hYAwfn3ItKRW860N0C9t7EDW7ERdjTnQDQWsLdo+HonT5IsbaYGBvFjhtv8kg9hUzHQTk1KdcnZ1wH7U3uYXr0AV+kuQmMifa3hYAsk1FQoh9d2UPMNmZV8wkOzYr+tN4GGvffaZF01N+4sNziF3/j/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZkxRtVwCFIa/W07S0N9wCeux2Tz5pMJW/+odORjJRc=;
 b=dSsi9krLTr19RbPZj7R0PNUk+R2Z63OuvZfb8seVuPP6trtyZggpFx4UDU3AEWPq/znyLfq0ityz9dQwOmKlpJOOkLJLEIy9J2uYeKhEySvttgCUea639QdIh/dcLt07xfEKOuJ/uIcezBDkT8LXC8CkcCA7+IySEig6ahvFothsPpIoxyF1k2UpQ9VcNyYA8viTnPHwaFJ/DqtUka+91VlrD4LmjSYIgHOaD4NjKTuPzHhfPd08MEowb/IpR3436SpumkI6cXwM6SevwAQKo5MfTyoxPNWGs25oCWJ+k1cGooLZYG8yHNKSF0oId1DFn6xQl2pHzBuKBFTzeOuxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SA1PR11MB6991.namprd11.prod.outlook.com (2603:10b6:806:2b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 08:19:50 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 08:19:50 +0000
Date: Thu, 23 Jul 2026 01:19:46 -0700
From: Peter Fang <peter.fang@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "hpa@zytor.com"
	<hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v2 2/2] virt: tdx-guest: Allocate Quote buffer dynamically
Message-ID: <20260723081946.GA482062@pedri>
References: <20260717214349.4075994-1-peter.fang@intel.com>
 <20260717214349.4075994-3-peter.fang@intel.com>
 <51059852-9a10-4735-a81d-003b4b1963a6@intel.com>
 <20260721064907.GG3178326@pedri>
 <d88fe58e-5963-49a5-86a4-6a9779d06109@intel.com>
 <741eb8b8b83dd10d39f304133a7625f4232ab793.camel@intel.com>
 <amCv00f5Q6QlztyY@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <amCv00f5Q6QlztyY@thinkstation>
X-ClientProxiedBy: SJ0PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:a03:338::32) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SA1PR11MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c905aa-2a09-4612-bd45-08dee8932a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: OBZgObOFrVxhU3GT8L9HiKpRdw41iCS4Fcai4/WcMmlFrpx7QMS3gd2FV3leyBWsjCIO2s/7qVpCKUqom3wKaq36Qos3q3FJ4i81qU7tZx6EuUYCj/63CCZdhKs5hl9s5juVIxIQN9VVl8r/SDfPFIRIiUA8BNvz1+UM5aEzcRugYjzRy4AH5P8ZPbAweIgb5bQ24i5tSnDBdocjjbR2trJDMESKj/8fxlIPJO+MXgOCJTgXOWETtrB8+pzl3yJtpayGNqlFuCa+KRfgeZ1jsTsbGCOjocjtZinyazk2XO3UYoEMnw4LC+yO3pWW+DzSCvXhIUv31ENpIXlTl7eWaJcG+7ftA4WrN5RQCMsqJDmrpw/G7B/TDN4XawOmxVn0rGEOrv7VhN6FCUBobMb3lP21icaXcdWPKgLcH83HnFHNaHEjPkoDGM/sApNfx5r+ah61yANEqqI2OQg893xkVsKZ3agF2Z4AkBAB6k71MhOBcJJmT3YRsCK+JnEKpiJo2gcbDrRNfJ1ur71W35TDsu18N+g8SbYDAjk8JbH9k7fyUfveVaPcv1jOjpS9PlTlTxtqgdoCdKZbfQ9jtHN8migAn7Dn1yuMn4J02JPndI0wQN/0PflT+cUyh4RN9iBmZtSlKxRUyj0Din20rkOu+8BBbyw11a1YUKMw62NE6cY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r3G2MUFwiT+xLADe5zazsvQe8d8hhQz823Nc3T9apU9DZAQ28VjBochfqF4v?=
 =?us-ascii?Q?Lh47bOWhBTMszS3p9OV38VKQeg7OtfDRiKgJpNxGE7v4JRH917iWhYrItqsU?=
 =?us-ascii?Q?VBlnDNa4ScCtYAL9PAeyioUzsanms7XTuV7td5RmTNV8fLYf492E+3O29hzM?=
 =?us-ascii?Q?USq8fmenG5QVjCbcDIgc1bz36FuiSOzHemtDbEKRgMvtLGXYR1qD0m4wSfhJ?=
 =?us-ascii?Q?P2eGNiQZnyH81rqdWxcGdpE3peEfwnbUqBbWEIy23KVCt8y5HWYKXYb1+Y5E?=
 =?us-ascii?Q?ZOYuLzkXbtWkPnE0s1vv8uj5hbPTg5DD2AOZ8DiomeXDLP5af4xzUa+06BF0?=
 =?us-ascii?Q?ugI6ZIlcBiXEGTnf9cf3bhlK06yd7rlPMBAaGDE3XphwEMGtuIxqCMO6AQAw?=
 =?us-ascii?Q?ptDbSLG94iVU6MBTfnlLIbPkAKYn1y712FUzBty3js0BLlTylcEwIcrSt9JL?=
 =?us-ascii?Q?oxB61vIN+4ZxULbEkk35FEEEu888nBj26QB7X5E1bAiAn7qEpMWV2VIXrm7o?=
 =?us-ascii?Q?kfKWQqGMDYu7X820/qN8BwkCbSgJU6WQa34/6QXEw5qD35h/G5J0JJr8/92J?=
 =?us-ascii?Q?468QhuQi5OdDHhVAX0upomDLm1P2GqIBUU5jHvPBbLgBfBr9q9zlFzi1MeZX?=
 =?us-ascii?Q?8ePBJmSb9oyfcvI/7789agZX8h4seYUewMWgvg2ZQnUUwWo64+SP6MI6rMaY?=
 =?us-ascii?Q?aEFa4JK1BNGUztZqe7o1+RYxjjaK4im0VkCJdchPViCRh1ulFAyJzxR+pN87?=
 =?us-ascii?Q?esRHkxUv11HmLK0IaVCWGe+Jys9JNlBuqKZUaxJiazfOif1U6sapW9YzgOmL?=
 =?us-ascii?Q?w/VWD7G+IYPLxhXIFP0+r/JqLeHzagIkuz8uBrjhHP8EJwpEH58sRcrFju+G?=
 =?us-ascii?Q?z9tZ2XyJdQSIu6PThV5XLvOq1PyngtjH7kLpVonI7seA3GbG+4wg4ssP4dnD?=
 =?us-ascii?Q?rZVqj0L8Vc5AnoSt7Emz0hbQ71sp12exfPF+mnjazQrsfh1ISeJ/ipHoEj8h?=
 =?us-ascii?Q?p30dcU0cy4BZBu0XjuOWj9CP/Wu9wOwmdQiyTapl3IHoEHkBc20H8YYTAXqO?=
 =?us-ascii?Q?2vyTXaKdYyat5gkwx71mlinjgo2C4Kr4VfuXNkk6BNegfAueLweTDzEMcbhQ?=
 =?us-ascii?Q?9JSQ/6UJ+cexkbtLmgPS2lO+rWm13AonIPRjodem9diHProf392oIS0pk6/K?=
 =?us-ascii?Q?UBtyR8AJs3FN6JFJxGgJfrsy+QzJtTd2v/aJNXbObIuMcKOLtvuMzF+9EIFz?=
 =?us-ascii?Q?r4+mOFprKIbeawwxgC8HQnTBA2AsOvT4EfXONV4ZYkw9j3IXVEupt557g2da?=
 =?us-ascii?Q?TpOlgBPhhtm5CckgH0wuiJZvUXCO/XKt02/+wQemDQlt7Qq+fwnYUXIvVL9O?=
 =?us-ascii?Q?e+/s0VjnMlhxP82VZ2kFnYyZmkM95ajidlYRxj2yEqaClIg+PTeqMxy2ivnR?=
 =?us-ascii?Q?ecxJmzmh4kl1M5EaP90qPiGdeWnutOUwssaWXNzf/PONkRHkXABeKUW14xN0?=
 =?us-ascii?Q?8lSYUO1wiAFHW/C30XQX5x1/W9QzLzSeVnUOpjzuMhpJIv3G8EG959G9Ni4q?=
 =?us-ascii?Q?mW4cUJdMnFMY+g3/j5/Wkdey/79JAlF6Z7langTPUs8bgWFaPLt8YLJ2j1VT?=
 =?us-ascii?Q?HA8W7k9Tzx9VlJ15zxtBnfopC5aHaDGjuvyzSIeMvqA9YhydhuoPqfwv/jMz?=
 =?us-ascii?Q?CVkJpRoyc9uo4vyg8ay6n7yWElRXSUSYofPT99ii2ZzF4qVFBjN3J+dz1LJd?=
 =?us-ascii?Q?KI+QOIcGhQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: A6FttBnFv8XVzT+vUjOu8FoHY5d9BAMgnZL++U+RRo1da7Wz2XFmyw6G/VbDYNtPkbdcI7NUuiDPVjzOYMYsEqX54A7pWQy89sREE9CleOAf3C6nEK7K1VUyBBdC3FF6G/e3cEjYANO4iM0aXqUqPWiMVFFDhLgNJTIgYt5qnbZ5D9oQv0nB5ufArFe6CbBoWWNe3gvg3WpnNLaBAOcowJT+A9fz1CxT6wPeTn8FoSn7wzJiczu3kvJDq9/WAW2C5KuFerFt+ffycd577oYnMDecWVhcBEagBSN3+ceq7qfY9np6ezIJPm6qUdwVPhLcQ4hFj6h3/BI9LJuOWgBb9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c905aa-2a09-4612-bd45-08dee8932a3c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 08:19:50.6230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQOVJA2q6kcSvcmtwiM0+akvsMSr4BkZAOddGx2/iIhsNgTHPRPkgeost2D9qsdqEUS7lszipuIZDX/S0al7Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6991
X-OriginatorOrg: intel.com

On Wed, Jul 22, 2026 at 01:00:35PM +0100, Kiryl Shutsemau wrote:
> On Tue, Jul 21, 2026 at 04:43:57PM +0000, Edgecombe, Rick P wrote:
> > BUT, is this number coming from the untrusted host or the TDX module? I cant
> > find TDCS_QUOTE_MAX_SIZE in the docs.
> 
> I cannot find it too. Peter, any pointers where it is documented
> publicly?

Gosh sorry I missed this. Turns out it was not fully published due to
some internal error. Yikes.

This metadata field is documented in "Intel TDX Module Extension for
Quoting", Section "TD-Scope Metadata" [1]. But the encoding of this
field got missed in the June 2026 release of "Intel TDX Module ABI
Definitions". I just escalated this. I'll come back and give an update
once it's fixed... Apologies for the oversight.

[1] https://cdrdv2.intel.com/v1/dl/getContent/874303

> 
> > If it is coming from the TDX module then
> > we are not talking about security considerations at all. It's just a functional
> > "do you want to know if things are failing". Not sure why this one would be
> > special in that regard. If we think it will fail so often that we don't want a
> > warning, then we probably need another solution.
> 
> Silent makes no sense to me. We are talking about attestation. If
> attestation fails the TD is functionally dead: it cannot obtain secrets.

Yep. I'll remove __GFP_NOWARN in the next version. Thanks.

> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
