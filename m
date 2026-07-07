Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18322EEE61;
	Tue,  7 Jul 2026 05:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783400838; cv=fail; b=glny87oDXnOeAvnOMsXUF//ddT6/AzaC/Ac0xwr+aKql+DEccGQu62xsuLiwYjL28Wsuruq8rX26/AY6ksdfB636ssYGL3orO6WQTdXFabpiUKBEgkLMNUkgQODM4mxTOvYzKhqC/qu6VN42ijruL39Mv4gLHZ5HDh1ddA+gGeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783400838; c=relaxed/simple;
	bh=VfCqBrYkCjA9fvYUyd850M1Ub+cOYGoxw8rW5KLJRP8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NOkX1PKgqiXRu6O8UuUPbAONxHaK/M3DEPzRo0MjIdc2Mj20lcJ3jRiJFv/VcxKAYNKrGd9M5vw3tiXIm7VGuVsDbAlcf4aoSdQrOQTuun9Yl9HPXPZ7jc9TLtfvqGhDJfPDW4KW5HyK9F7ihaSmhBQxXxB2S+ZSKTrSvwdM8MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bpe5xLlr; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpe5xLlr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783400837; x=1814936837;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VfCqBrYkCjA9fvYUyd850M1Ub+cOYGoxw8rW5KLJRP8=;
  b=bpe5xLlrMRI9jFXCv430W4dlTWyX0oZhxDTELpwbQXJ6T0TMxSUFYk7/
   h6Mx53KyrigLO6WTaJrBPJM5VzaKYtXB4K6qU1uLJiSZcpVMZi3Cq2VQj
   U1ceGNK+Gc+zUYwMV8zWkwXpXzo5Tw0hsL125rHudnyKZiZUZyumnM5ad
   dhQ2S1nT4DfFYWi2T/L8GyDdgGNVM303zg9/u2ea2v1cf9XNgG4G/6bkn
   AY1NEuyyJczSDgID2HDRUJqVrYvSE6h35uwiuO9OppVpwr/J+NOdhyJXX
   vEOG5nU42lyQaYShC9OLFQKqgIEIaTXIi0tAitntUmfusOp1RyoZZ6T8E
   g==;
X-CSE-ConnectionGUID: 943DMWixTjirE8E/C7zjZg==
X-CSE-MsgGUID: o//00plzRvqgL1+0sO6HrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84016948"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="84016948"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 22:07:17 -0700
X-CSE-ConnectionGUID: tx16meJZSm2YhmQc8CSihw==
X-CSE-MsgGUID: PmAPkwlHR++7K+0L0DUtlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="249466243"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 22:07:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 22:07:16 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 22:07:15 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.18)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 22:07:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKXCqASY0WZorIvezd8lmJRJrXW5HSrnKBrpTcpJXAlMkat8RKBdJONXzR9rbv478CrC59Ng9645aEbrvyu2cf0Cwokc0+bQUmeZgcqSyW6G/t7AeGfOkemuRuZfYatLy0f6IN6M84Hi1pDL/GOiFmUy4i7GME/iJxgNw6qVw4+GbSgv6vA7cRdvPQiTeTf4lQo0JjzRx2soxTLSVPovb/wPjlbF8mhV/cLsvL1T28RIDIX6JtXfZYQZ5B5Jnhq+GckXt8gDItkgZ+Z01Eh2wPO17ezZFWWvYlL4UrBO2H4luaWxS9ZK6cI3snNQ9FpM3iJpLGqvodDbzX2guscZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31DsQA5nugOQF/qrAlzE1NQF7iEWWk2a0XyQkg0+20c=;
 b=mGmKQPwrkKEEOfuvUx/0u6CkrbIDdNrpYnsaGH6sP6ewBSsQ09kiwmFC5NUCswzkvgURAYDFYPEfgMPKy8uaWLPzMuarqllJ0+RsulAc+EQ8xLL13kQno/sROzaiu1BmPB3aKpH7LyVmoBe5gZHUaQhoKCGPnflE9+TJ+lRwzCsII4dolFBMyWVDoJLFi6eBnXeh0V1Hw7fmqaAxyp1zoxxH23etJ/yiWa/26xtILDWIXorJ5RYXKe42ggp6PGLo7CH0DPsbnmmEixyq7vlW4D9MbKkFpUI1FkOTp44fFIvxZYvvnEA++XlDdRUe0jDWOmHcKF4e2mUo/clixSuFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by PH8PR11MB6855.namprd11.prod.outlook.com (2603:10b6:510:22c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 05:07:06 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 05:07:06 +0000
Date: Mon, 6 Jul 2026 22:07:05 -0700
From: Peter Fang <peter.fang@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kas@kernel.org>, <djbw@kernel.org>,
	<rick.p.edgecombe@intel.com>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<sohil.mehta@intel.com>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <xiaoyao.li@intel.com>
Subject: Re: [RFC PATCH 15/15] x86/virt/tdx: Enable TDX Quoting extension
Message-ID: <20260707050705.GG2169894@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-16-yilun.xu@linux.intel.com>
 <15b253e2-1a2c-46b2-abe2-bf152d704523@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <15b253e2-1a2c-46b2-abe2-bf152d704523@suse.com>
X-ClientProxiedBy: SJ0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::18) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|PH8PR11MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: d76a1d36-b37c-4d8e-e2f7-08dedbe59713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: WX8YQq13hXQMvRwD4GtsQgpNtSmuOfzEYSUc2vc+afBzcpm7lIP1dut9VmnTN3PsNd+IKietbRot6337QtR5nExsKtDKIpIqZZOzj4kYot1B1Mp/EyJNeWzcLebH6GujBVdpzZ6rQGaq2ftJKRbU/g9hs6fEscf7Gd1oKrVyB3KyzfsOj9U3qgMsh44Rxb9iJA/xG/4igmWkxb6kmz9kwqAkuATVMIoc1vfO9SqXTGLRufncOVrkuowPb9nXjFnHXahJ7E1WwwaNTi8FMh0YaPlxAmGcVqFN3voSrijc8qBkLrLEHbcsnB8/+S5xT+vj6q45GYhXCHDweem5hhCzwvBO3z8WPRqGXIkWU/6rl01og/+W+Q8Gw/FAB20Xr70YhKBx8YmPkIuyyPe1h7Z3EtcHDjeXXHDccom/+nQYbld7cMl3zIjDC3XaQjwGuDSk1OPs30KSIx/rTt7oh1OLEqnc09KtoEVI074xD8Yk9g7BleTDYKnp9Avu3LOYdxNPVie6e/l9nYiNgHkGNdRM3q9QZ7qjJOGd4sSTXqlKMDXSfDsh5KHvgzlkZg5x//RXU8E0isUYNof3daJeVPegyo4QkK1E6s9tKAE/VqTq3sDR68jvcm4VxX0q9iindLo1oGorNqfDCJGf0ET0bnUyf9b1Ks5JPa0ykIQHA4Rs4bI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tHlWx8Zqh9Ax+I3rFaajEy8eHz/GjF84XsWm2JvfehtnprES50gdFFzBHR2o?=
 =?us-ascii?Q?xqJP+BEDCLqDV2wcFrBzbk69LvdQLxPoaRXqqSKZAtitUvdUPKoxQfPs+R/d?=
 =?us-ascii?Q?l313MCs3TZIDv3kwpTAb75SgLE1fuSm1v4MdHkTO/X6+0bmR0EenBmTfpbt8?=
 =?us-ascii?Q?NvsMHesP9TUeRG1/IqIXkMMsgPQ77G/9gII8pcK7b5iotbXFau6SpVoNq3oO?=
 =?us-ascii?Q?H12kih97B8U8CPpUGTKvkqsv5xf6MqohsLniq9O+6NxDN+cchzhaD/IN8QDF?=
 =?us-ascii?Q?eX7ss2ehzGwZzpH64jY1ZqrpPfQfhuhazXtFgDfBX/pVsveIvCfI7upvGsE1?=
 =?us-ascii?Q?eg411rUdpxDZbAvn0KqSdnvQJFIstLYqbcDWlO3Rs9CptnwLy7ucTqbSbQsh?=
 =?us-ascii?Q?P2cOp5qIam2aPBebmg1ugBJQ/RvFpvsAqqAiVV+KO95r4tHK0meqBVv016J/?=
 =?us-ascii?Q?bAH+NSRnRt86PrrdVcx/ZwosIW71iP0ajoDKBWJzWhChKe3mpP+bHRBiwwTC?=
 =?us-ascii?Q?76lXK/XwCRuOzZlzHz6Ljn8df4Fye5ysPji1OebI2TgDynLxL3aUrvnNGMzt?=
 =?us-ascii?Q?vJsJf+y5B2tBPcA4vZQfFFXfX6Sk8LMfWuoTS9FHznK4IyZ7Wah4fyA1grLw?=
 =?us-ascii?Q?ehVRdaJdQo5pSZ+EF3KdBSrWgHGTPRRO+krjXM6KaUWPx9ebsOo3MkoRQ2te?=
 =?us-ascii?Q?XVP6Fp5/hs0TTOJcl4chYHcB5Zdoy/XcIgFg7WPk3aOdH3mYLxTjkQXmwYYi?=
 =?us-ascii?Q?G5oPeV473L3zgjIg4oU/TkWvKFcU5/COFrrp+zV30QJVmEqh5Zg4Cx84dAmt?=
 =?us-ascii?Q?IwZmPL9nj0tFWYwAD56M1lvsBY6PzPGNBR1EEVZEnLbalWZFcetNvkaRfoCB?=
 =?us-ascii?Q?GDCG0Y+J5QQMtc6t5vEM4Iwg/5J20si9oWhqj+g4R6i102ZI7ozfSarDERq0?=
 =?us-ascii?Q?Bs0FRELSR2QRZYNLfN3B1OQkg1oKmijs6yx42eSRj03jyejJvOFMr2HFENHl?=
 =?us-ascii?Q?4F85fKxT28ddrRfDdtFNhWFpVqbkDJZMWAvusbkHSPkB0q4hQjXSNyp94g6d?=
 =?us-ascii?Q?tZX54BIjNoh5rX0moJiwNOdc08OF1wAklAnlIjVNDEd8YTgdewvMNfRv6jch?=
 =?us-ascii?Q?LwSTl8eBkEYculR3fnKsCFWWbSgyrwl7wtwM1blfJHc33hCPxx9wZ8Covqs9?=
 =?us-ascii?Q?J9MOUoYSKhLAFeKCjq5w6dvj6DLGZ6uJL+Q3Aye3LGycFkRs7Rxs4pKA50nZ?=
 =?us-ascii?Q?3sp+xrzJfxhBaFPa/pBjli9qFs8VKv8d2HMTxifEBNssVjTVBEMRfrPjAi+8?=
 =?us-ascii?Q?rh0/N/ktkZmhjj5RRhvhAwEQhKvqI3BniIkPa6xaZZdCLk13qhpNdLuFOuxk?=
 =?us-ascii?Q?z9GKbVDx0sLmbp3erzqsjvqoLynXg6QYCkqZLtr60EE/gsr0WMrIAdwpgeYF?=
 =?us-ascii?Q?bjRCkjz8sElLN6JffBuvs/ZCrjBUP2XZIiS7DRkbxRaSxuAgtIr5YK8LeBIM?=
 =?us-ascii?Q?/cR34wSuK0gXQb952ltq4fQOqYZx64IFSLuNOi7e3b9NmoX4/7YOIhVXeF6a?=
 =?us-ascii?Q?Ym1lrJsSZJbP1F4bGfOusTWpQVRvlvrxqdIVW1Acrr8JAV6bPVXGfdrX1dJw?=
 =?us-ascii?Q?ZM/fvz96sgn+SNKvtxxwZDiV9ouT0P96CqOzF3wt90gc2gyAz5t6Q7/CCS9N?=
 =?us-ascii?Q?tO54g3Q6GvY0JBENXWIV4NKptD6RdS7Vl/q1NMhdx3gDpvSmvIxfM79cgTYX?=
 =?us-ascii?Q?xOG8lCLKNA=3D=3D?=
X-Exchange-RoutingPolicyChecked: eoZGyBxwGUi1wCoghNH61mjZ0tfPtrp4oh9GUHf73IivmyT76SlJjwUqI2qH8sVavliI2jTv31tenLmV0H3/X74GEwEqp8KAf5oglczs6T780Rx66e8GOuvUlOfhagOUL9Fx47kOqneeqHsfChtsljr2JSZio2n2of+mNien6Ml66lxMneCdsQeIcZ74X4A5MAYh8SJISiDiSXVDW8VKL9Bj4Ryo9D6nq4MqjB4GxF2+ygaBgtr6wA3SUXShAsI91puQIqTVYjhPDDkElRhUqVAJgJyBURU9eOdz2He/j7j2TAl4P/fNmp/u1DEiekkjJ9NSdD9a7K5QgM+pjLNCDg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d76a1d36-b37c-4d8e-e2f7-08dedbe59713
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 05:07:06.7739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnCMU1tInV80kqEBDTPeYp3XBuvJeI01Bi+VOqobDUIF3BpCoEg/fetbMYdARvRWZyiAlOI3EfZOFkMdxFk/CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6855
X-OriginatorOrg: intel.com

On Fri, Jul 03, 2026 at 10:57:01AM +0300, Nikolay Borisov wrote:
> 
> 
> On 5/22/26 06:41, Xu Yilun wrote:
> > From: Peter Fang <peter.fang@intel.com>
> > 
> > Enable the TDX Quoting feature via TDH.SYS.CONFIG when supported by the
> > TDX module.
> > 
> > The TDX Quoting extension generates TDX attestation Quotes via a
> > SEAMCALL, without using a discrete Quoting engine.
> "Quoting engine" is a new term, introduced here, better say "without
> involvement from the VMM"

Yep, I'll remove that term. Thanks.

> 
> <snip>
