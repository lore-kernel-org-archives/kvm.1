Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A2B33D6ED;
	Wed,  9 Sep 2026 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788934876; cv=fail; b=khFxEfqL5lDoww+bQWovlkBIwR/QkNPjnIcBzEUAU9TFJCH6mWEXFlZNgDgfv0i+OnDexXYv2FIlxgAXZCBuNaVyfikwd4exxYecGPt7ec6miJSXLDe/LSl9bNshj9EGu/IlbWACNVxZHMmBzF3TOKNaVJmb4/VAyogdWUr5ZdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788934876; c=relaxed/simple;
	bh=HfQUNa92FH9bdrVt5BrsCQujVLFENhgfBeLwZGLyqNg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X3bYVrzs9Rq7jrJIGBYZhZNJPqd5H2+PjN35y97BwtJh+Rgcui9W3qu2zNHKiDtcl0cgVWLVBF9itieBCj4ztwQOYP4oQJL1YLcSf7i7f1Jn1uikTuNSO0xbcl6s3ies48c8k2w3JvQpW/AfQpNPAipGyJK5b2J3zojFcF5qGcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1gcLUuY; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1gcLUuY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788934875; x=1820470875;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HfQUNa92FH9bdrVt5BrsCQujVLFENhgfBeLwZGLyqNg=;
  b=F1gcLUuYcb2jXMQorGMHle+k1MPvMeFNi8qeCca9ZzN6tD3z4IPzUM37
   FaFcyfOEK85LjOx9TNQNnSMUGS4sMpvUZq4Ep9/tHorkGQReUojz+FLOc
   rqBz+gDb0rs2d4ddvRLts+8A/NtYvmFBL2ak/f8Mu00yS9KSmbzWe+ogc
   H01p/V/6RFpyt6ob0dc6GKwBy7nzvv/G40ORuBA0s+JyKE/UdlwIBn6Q8
   4GSfCSQnJG5cQ/SalMwiuuHFTw3c3Kr+JyYynXYRrhyx9JAEA30aiCR9J
   Mt9aYIxAzOg1W5om8RBD2k8PASytJw1Aw21bhdVLtfnBQoLo7H9FKsecf
   g==;
X-CSE-ConnectionGUID: E7VK4tZ6RUK630yfYKrWmg==
X-CSE-MsgGUID: veNkBNSeSRuitMolKboC8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="88285531"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="88285531"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 23:21:12 -0700
X-CSE-ConnectionGUID: 2nXG2ifQTriopSysY8VBrg==
X-CSE-MsgGUID: 7NMElcW1RK62XPSdeFdewA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="269472193"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 23:21:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 23:21:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 23:21:12 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 23:21:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKwZdCCarTMwkODGuDB94mTf478JalV9JK67PI9yZAXrp9z0uOkpUv3HKBVvL96jJLPwTqWCi5fi0nQITCdTaGc/o1xh8rodBnwbm2rhLuucdYmnfnKkVt8FcApIyyhOAG/N+3sDIF3D21/x8Xb6R9mwdc8r+Lv+0jD7caE2/4MTFTUdE6SwV8dpWy5GA4y56AVTtKSFrYdUVjVtnOf0xyOVg2bCwkHVNKzv+HfWyRcWDxs3D6CbOLa0klqVFIMyD6ZueD5xzjv/vc6ynFENG/tafFHYxG0rlxBgVUluxDCwcASq+bh+QxKu8LZq3R6wd0/NW51/W5Ks5UV3VCuZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VREMmq3oWJPr1nbPj+rM0djPygSnnJP4G05c2OyerQY=;
 b=lIoZBPzByyyF6PrRlVk0a3VbKMEGysUNWU27oR8pXbIttSrGFTebImYTPK5tMDWi/D2Frzqwhycc6OGavdl2JIYb83cZ0Wk+1tPNXUXopXcLC++sJSvBXHk637e9gfIvms+qoE6NLWKaIrKTpB1091br9StCqB44IIopFtyGtIX8FGVgj4XLDDdmhTszZEXXa7wzH8DDdBODRpXjVFUZybNs4IW/XHmBlPrlJhY1NweEe7u8z18aCwq8EgY37zfDBq/HfIYzf9OxIv4UfuZO9Qtv52GL7nRpzisBZMKvNSgAr20dsrmAu9ELEqh5fxW7A5dvT0ZJXk5dpjffkh40vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by CY8PR11MB6818.namprd11.prod.outlook.com
 (2603:10b6:930:62::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Wed, 9 Sep 2026
 06:21:04 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:21:04 +0000
Date: Tue, 8 Sep 2026 23:21:01 -0700
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
Message-ID: <aqD6zcjUDeUnOVBJ@intel.com>
References: <20260717214349.4075994-1-peter.fang@intel.com>
 <20260717214349.4075994-3-peter.fang@intel.com>
 <51059852-9a10-4735-a81d-003b4b1963a6@intel.com>
 <20260721064907.GG3178326@pedri>
 <d88fe58e-5963-49a5-86a4-6a9779d06109@intel.com>
 <741eb8b8b83dd10d39f304133a7625f4232ab793.camel@intel.com>
 <amCv00f5Q6QlztyY@thinkstation>
 <20260723081946.GA482062@pedri>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260723081946.GA482062@pedri>
X-ClientProxiedBy: SJ2P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::6) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|CY8PR11MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 140cb85c-7484-4883-3a9e-08df0e3a8696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xD2l9cE+0fQ9Ql2s7ETOcAat7aWSxGjJAz4dM9ayCLGp8gZTPTaQeWioOLcUu7O4951Bz1ntGO+qaLDuArfTyCj21qX84wF3A2Pb794VE4uvgfhWbChEfFelHwWcEoDe8DYHbERbGVjPXBxLV9PaDJXO7kgym16XsyEKlkfUU5EfVJTJwMb0TnUfgf4ADLSJlCDwH1Kv4CLLIBJsItBzLKJhABbO9m8T5qTnBz3mssgT8Su1r2E+cWq4YK83lP4+3SN2/nuJp0ryMUNr0TmPz3czeWuIKAxP/jruJuInRJjfFu6fXpZbN8XGc9RzW+6b1PZhSfXV+US1nEfcYuWlKDcOQuKAcIMyugpba1dseWw5v8TU6cmvKv0+ztIJMWtc8006yaiKxcOHyN9JTxpgkUZyYEmPSmpkQG7IGnnxZIGLYu71kFLYoEf8OmD/QY0VLuC/3XmzQrRRGc4J+s6nqpn0wBRCA7Vj6QaWTLr2GNu7zvnpvIcuK4DjoF3E7hhZ9NphYxK6TyZzOO4szsRmpHd7wwhmx6kwtSGVXnwbQr+xMJ25fr4ARpCR7TzLfLc5T1QRw6cqXG9QQ1t7KLhrwM62GyOQvifLypmFphJ3JGNidXHANBRfuVMepcywLsYyGpaKk1YAgpcJ/wCBpWjsReB3vb8Gd5ARRCK9KvOz1dA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TA7HRQTIDo35qyiySNgzKgfMhYz/RDuKf9xm6Q4wd5GQ4wx/kRxVWQFgeLK3?=
 =?us-ascii?Q?NMKiAGJ4rZgtfUiPNbNEGGmNgbzWqQSm09GDb7anmXfzdYGyH9cNnuCVvwkc?=
 =?us-ascii?Q?2UNnYbfxEB6M2bXvcFpqq0/EJAOAHvI6WGE5MgG33mRrjaLcrEulVYNYOkG7?=
 =?us-ascii?Q?7Qc7kY0jO0AGMgyL7bS/U89WliSMKnXScnozVVSU00JX/eQxs/jWLLh/rueF?=
 =?us-ascii?Q?BFKVOYqYLVCLV4dJdbTvfkexYAOIpc+XON0nwjUV3QGSEAsMuGn4GQSSy1gf?=
 =?us-ascii?Q?452hpsGV+K9g3sTMYCUIR2u7Zq4EFOIdmCZNBB7ZCIlbUPSrtBCjWU607eMp?=
 =?us-ascii?Q?Kyrc45YjuivdWN9L48ofJg/5U0zH85eSgpzf7gC/2+nj9Y9xvU+HVdd9Np5C?=
 =?us-ascii?Q?If8i5/pBnjzKAYSI+sG81k8YwJcF6fYuU3x5L0iI+zUelaEmk0/NPQ5bAZrw?=
 =?us-ascii?Q?ltEiOY3Ycrd4F0IYMoILS/3jqjs0AwIssIs6e6mV7tt3WP1A8SWGRvki1bTx?=
 =?us-ascii?Q?FtcILB6OX5DQ88FTqk6OPm5DFgHozrayH+12pN+/yxvFEVyku1plMP00o+f/?=
 =?us-ascii?Q?N7i+QJYFp7//7ayvgBLazINsLpG4jdFuGIax8uqQPwA4pFuPbEvGh0qJ/Kzd?=
 =?us-ascii?Q?LozIjOzDz2CPUYx5MsP3D+5+mKBDM6xT52ICeGew4xfbX0zHnsS+FLaGG+df?=
 =?us-ascii?Q?yJHux9f1SpW4ke42/5nL+Fi/UYEvma8rInWbzhrgQPfJm8U4MSSt3TvhvUiS?=
 =?us-ascii?Q?CcWpgHKZiVsP7rAZ+NHxtz9j86khayGTr1yspXpFYX1d4gaNkcoYxqjx5AOJ?=
 =?us-ascii?Q?zIS+TWVHczEaeeM5hhmuLlWlW1ExI+cHgZxOrv0JpS7ArD/QrVXH9mWymwFL?=
 =?us-ascii?Q?3cw27Fbu2+xciiGj7Oh07F/uzKOZNPSWiBIAaKmVw2kAWjUVHQeqYPeOnbMJ?=
 =?us-ascii?Q?XGOFJAx0FCf3VXw5tzwvO3Gx/dplTq5uL8uiuo0yvzZFc/fy2VybtLI0TAvG?=
 =?us-ascii?Q?Rqr6J+HmssB+8fxfZXGz/VHTVw7r0rsp1im6PkWrpc4G/3bYGh7kICF06Ivv?=
 =?us-ascii?Q?9RNlKb2A+mH6eDaUrCb/u4ycO+JJpOPSzbMWCe5EuwWjrB6iqtWofakgC6qA?=
 =?us-ascii?Q?RlgsUqmh7aO9plN4h7nRMDRl1/xWemSs6tZJ+ok/wCgD7ETXSpqF98bFD2ah?=
 =?us-ascii?Q?tCm23+BwfNMF44qhLrtlg7GUrAmb+W9IScSFevh+Au4wA43GdwOKFLEJWMa/?=
 =?us-ascii?Q?3BL2Gyglg/JUKZNzvr3InZFGFptyV2G378YRXiRqP0yHPKkyIk4bIJVJw24+?=
 =?us-ascii?Q?LSzV1NPhMHgT4k+EbEfjZGJW069VMPAyGWxaiDwd2yNvEiYxK0UQ/i58sNfd?=
 =?us-ascii?Q?Yz/k36+r3CuzKaVJKlwimJVAqJIOp28MRfce5sQbFqP4j4G976KzIw8GTZBc?=
 =?us-ascii?Q?bpYTKL7rsudrGUVOXwgKX6ZeH3JrAsJYv5GhI4+v9aFvCqEsrGl9Wbdhx4o+?=
 =?us-ascii?Q?rWRVAMCY+TFlu57fdguhdyQFUVdHK0MACicJH8fZguicASdfWv7QC/FdHOGr?=
 =?us-ascii?Q?tCCLNS2zzHMjxd5blfzqdps3KNkVwxAqQYHK2Sy+p3Tl2UR7rTJPgWXvGSmt?=
 =?us-ascii?Q?kDDCC2EWOYtOX1jkuwWb+vZdwnlGuIsaVFcr0uakibDkfhzK7AS08NMousK0?=
 =?us-ascii?Q?c35OXxIApsLXCHa+A3DUfWQ06YCkEduvQ2lugTJjwlaU3UBw6YYjrWyUMk3Z?=
 =?us-ascii?Q?o3Ym8FAjFA=3D=3D?=
X-Exchange-RoutingPolicyChecked: HAsPmgf4gzgMbJknbmohTEuntfBGIPsCL4bXtIwuEMrI2BUFg9jUFhod8nIdcYKDlX7HZBLtxlGhpr5Hx0kKQNck1Ov83kjHHjhtjTo+TDEIvxBpXP/re1Bfy+NuRJRfO79/6FzPAUW5YqiNrJjcsEx9AdZnrDgAIiHWKZaSiZVD/S9t0+eFxfp9Qdq98KqCaYkOdcq0Lluk0eStQykNYajNZX/POeM60Qi/lOSSzActN1rCVwowzZbPm8VTqYiUcN5McZqw1/njxRHzqCuJGBfrpUgo4WaEDLo28utgNf8DvKbnL1DHsDthRMhwuHIrTmIoV4Hl21mcB1AKJL9Jgg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 140cb85c-7484-4883-3a9e-08df0e3a8696
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:21:03.9599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMKBTkdSag098VOiE9pnhs5hCdzz1khbp7L6gFQuApB/vQiCG0x0QI/sinRmA3NiJAvaDJNBp0L+muuzcSlDOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6818
X-OriginatorOrg: intel.com

On Thu, Jul 23, 2026 at 01:19:46AM -0700, Peter Fang wrote:
> On Wed, Jul 22, 2026 at 01:00:35PM +0100, Kiryl Shutsemau wrote:
> > On Tue, Jul 21, 2026 at 04:43:57PM +0000, Edgecombe, Rick P wrote:
> > > BUT, is this number coming from the untrusted host or the TDX module? I cant
> > > find TDCS_QUOTE_MAX_SIZE in the docs.
> > 
> > I cannot find it too. Peter, any pointers where it is documented
> > publicly?
> 
> Gosh sorry I missed this. Turns out it was not fully published due to
> some internal error. Yikes.
> 
> This metadata field is documented in "Intel TDX Module Extension for
> Quoting", Section "TD-Scope Metadata" [1]. But the encoding of this
> field got missed in the June 2026 release of "Intel TDX Module ABI
> Definitions". I just escalated this. I'll come back and give an update
> once it's fixed... Apologies for the oversight.
> 
> [1] https://cdrdv2.intel.com/v1/dl/getContent/874303
> 

The latest (August 2026) release of "Intel TDX Module ABI Definitions"
[2] now includes the encoding of TDCS_QUOTE_MAX_SIZE. There were some
internal design changes that updated the encoding from
0x9010000200000008 to 0x9010000200000007, so the next version of this
series will reflect this change.

[2] https://cdrdv2.intel.com/v1/dl/getContent/917473

> > 
