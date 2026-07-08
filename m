Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA343332906;
	Wed,  8 Jul 2026 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783548570; cv=fail; b=Cj9mQk4AVjI9PoGm3TGjfyRX7IxquiNV98RbWQg2B2W7CLpJYEvOSz+9kTPGA0QywVWtRv9dPQ0GDnoI3JPsfkdjhrqPjNgG4MHdtVSUGT/K6ah28C6CGXUt2kXXqMRIWAmtO+b6CdXdn36hnNqBn35LPON/pz6zHpIilSXVQZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783548570; c=relaxed/simple;
	bh=WyWalUk8uBzk9fGajVzlXANny80NbpkH2fKC2/pi99k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m16F6+mjGoqmLjjQUYeKVwHwO5m0f9m19Qkpcq7RlLjH2Xyiw5rFkTOpXVaMuBydk0M55DU1ol/p5oVCHtAhMejv8g+C4uhBem6AjFG2nydTKZudnv0JL8dRC7dq0ocndcPKxYfvuwXMDzzKHNwSyAUcsJ1wH3wECU3jK86lAY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VL7ZZYA0; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VL7ZZYA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783548568; x=1815084568;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WyWalUk8uBzk9fGajVzlXANny80NbpkH2fKC2/pi99k=;
  b=VL7ZZYA0IDz96xMLjmWb7AcHIVNizDe57KjlJiKYUtqOC8jPw9/jWjr0
   +HDEM8cM7hUMXI6Y0n0RLJOF8oS6qbjy6dFfNG4awn5/3XODEMMLSYA/R
   jDG5pRdmJHDxxjjKLWGe/XUv/fWG80znUS17kSwKFkvFalwaFiS+W8sEv
   GCTHSTNOJJL6zIf4IDDQetq6A4YAg56TFxKAP9sUgm7Y4NAETVdN3l4o/
   +6UMKIhTQyKihQfTK3Gb8ToxVarCg156ThJ0QfVLi0BeHOJUaW0TvhL5G
   QQuxrdpAtbRIe/cHmTvQs3Zo5D39LFa1oFDVwwFdx+7oOpWai7QwdbG0w
   Q==;
X-CSE-ConnectionGUID: u6xnzy5eT1e4u9wJI7Y5hw==
X-CSE-MsgGUID: 52C5PkaRQZawzf7esLSxRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84004488"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84004488"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 15:09:27 -0700
X-CSE-ConnectionGUID: ZgfvBLj3Tqq3sAVewhfjnQ==
X-CSE-MsgGUID: HkjZCBb0TteRDVqoEPSRWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="253922062"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 15:09:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 15:09:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 15:09:26 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 15:09:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBE6Ob+MFYV3H1MFl01uuhqQVwP2bnr6Eh1ovaMFG7ullR43IJyQnP1ovQJLBn9OvTmElvueB/+6g3rOwrGR9CkR9ty12q+rxh9MjFK2yVyh2sn+7CmyTRFtmlrjOcnmuwk5iaZA5tqmIahbGzavCyqmLuRpO2yBHCxWTwgAPKUNd/JZkuxf8iUn3GjqwpQb5glPigZ9p0dnwLdxiF4eWvVh68Ku+Ihas5FzMRTtKDHJC2Yi37BUUy/eP1/TNkGo5nlz7K3/njx4h3y6N5TnmlaeBgzwthxO+tqBsOwDF9jKPXILkwQpz5Z0FTHf7kJPUkGgzX91JyKE8iZz2J1VJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zrV9oEXFEY5JdZc7eteSeJCE7lWgkzohMcf8BKScxY=;
 b=X7or2GFvVYSc8Y9qEpDCU353o/st2Lp0v1eczOfW8xWXZ1VJD+aEyDJCTZmizdjTCN85olNhHLf2uznQ+e1A7QzUA3yapKhB3hRc4k51o962/vfp2MR3EselAxOhHuafGodRad9vO9rkKCu65uOp15Bum4L2WvxBkW2nyDyZFWBQ32PSdBIRdv17EWP8dh7mZlfpLiUbSM0+0iQCRQdXnTFuWk/QJitIPu2czprzvFB00zpzFPqYuf8T5dZAmsxzTXj89ocsxNSOmqsvOG0zpFgq7ENI1YnOew1mvxBX0NYLdiuniHETyrYs3xC5PqyGEEVggUrzE+xYRfOR9Vohdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by LV3PR11MB8530.namprd11.prod.outlook.com (2603:10b6:408:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 22:09:16 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 22:09:16 +0000
Date: Wed, 8 Jul 2026 15:09:15 -0700
From: Peter Fang <peter.fang@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Sean Christopherson <seanjc@google.com>, Rick P Edgecombe
	<rick.p.edgecombe@intel.com>, "djbw@kernel.org" <djbw@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, Xiaoyao Li <xiaoyao.li@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, Adrian Hunter
	<adrian.hunter@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, Yilun Xu
	<yilun.xu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Sohil Mehta <sohil.mehta@intel.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>, Kishen Maloor
	<kishen.maloor@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
Message-ID: <20260708220915.GI2169894@pedri>
References: <aj1tFuwZWdPGfUoG@google.com>
 <20260629100301.GA1743876@pedri>
 <akMQ3J6fK3DUBsPH@google.com>
 <23a9173f6e278ca7dfedce3374626c6ea3e1b47a.camel@intel.com>
 <6a445e4be6b12_3a3568100db@djbw-dev.notmuch>
 <akVNdxCzk-n4bgMv@google.com>
 <9df36c49e6be69dd9eece71f70a404a84b1563ab.camel@intel.com>
 <20260704054342.GB2169894@pedri>
 <akvsgVjwb00P1EuA@google.com>
 <08c9bf2f-75be-4244-b99c-153ec1f604ca@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <08c9bf2f-75be-4244-b99c-153ec1f604ca@intel.com>
X-ClientProxiedBy: SJ0PR05CA0185.namprd05.prod.outlook.com
 (2603:10b6:a03:330::10) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|LV3PR11MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ecb0df-badf-46bf-72c3-08dedd3d8d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|23010399003|4143699003|11063799006|5023799004|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: U5dKp3iMUHjoX/SUNxxPgsFio5YweEDJE3iuPsoq5XVvU4mODjaqZvtCtXCkxLQ+YYyywmj+FCe1VU5xSObRcX0X2m5PSxPorxsfsW+HOh77Eu7wn6ZmCl6ePGydQweiR43qUIlTZs8fJcBEnr0LkUOumB0J3tTWgEypxk8CYK5wVef4JKXaodB++LxUb0bb9hrgD/0LFSptC6H5DmU1p2x7BbRAbsb9XOdhRHoMA68UH90urM7TdjERqzKP+uCmZo2qX+r4hJHZBoEmniNM2QicHOAbyOjF7G0a32VlJW2qHIj1xtjEp5GUAsINCYvajPwRK48vowKoaKU1Nc/xgHD/Xsc1l/7y4aZ4Oy58GpaXg5EWp5sj/2Zw3NoMkqWWzKpb2VWtDDnygvQoxbrxnuvJyjmhGme8bdcNHnnyMqz4QP2dfNU9tSayjVNQaFQgmzyJRbuiuB8CpdeA2BOtFPKI0tYqXWkPy3E7T4CACr5pgz46P9QWjDSgYVzl4B8vWT9/z4XVoDc9UqvmbwPCWZe6ohZ/qmgVQSOkWmAQAcH9sdVqWjisKghdAINf3MC7XCNWqvN51qYAvGl+U7OBwYUIMNRav5YD7KCONIGocm16w2XSU/GyfB6nZeTGbVucoJqqahED022bwXS7iPUxOsR1f66Nf1TxU4qTMv/9Tb0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(4143699003)(11063799006)(5023799004)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lSeAiG3cwQwz0/Cjo9cBy5sbShRqrLVcuST7u40/OUhlMQ0cBvMOMXbecmtO?=
 =?us-ascii?Q?lX3hasbX5bh5uWDbBBOogVhih7qpvIvTpdQj/rl2oRZSLXY1WWzW0Q86CkYU?=
 =?us-ascii?Q?NO9/cp1ELZCCDdyBmHt097kVLkPg0HJESRYE7MF9qikHd84Satq04PINP2QK?=
 =?us-ascii?Q?d/C/jua7KsqRCHvU9D1wXcaN17yrmsyJsPNGSG3qZiHfcLbtwCxGIJaAJniI?=
 =?us-ascii?Q?QD5AGQ3WDVpsXwq4zyLE6MNrvtdNSP5PLh9fFv2w8oPMWm3Wz54Bx+ko7KN/?=
 =?us-ascii?Q?OMh+9IDbKV9C4bWQIM6kzM304t1q1LcSsVEpYf2PzrcQUiA5hVorA6nVmjNy?=
 =?us-ascii?Q?lQGRbie0NQAmc//vkl7nugZVwJqBEJeGAaA8H290xR0m7Uoh4CNzeIVQFEAp?=
 =?us-ascii?Q?SemdK/6R0QLAPCDP7BjVtXAnqmxUXdeB67hvjWmXjMnWNmBcGniqrMD2yw2D?=
 =?us-ascii?Q?o+iHcY0Q1DV8gX8gd8nfcSqh65cbtbgWLNPtAI6I2aoIAt2z3EbNrUvOWBqu?=
 =?us-ascii?Q?7kRc40TAHKG8bNkHptvOv8zwc1xGzo/dRCCSQoI/J8x4fX4R8zjWB9Rt6OJy?=
 =?us-ascii?Q?VchUIdzzPHHasRox6mNGVduVXQcJPCfuuUdR8W3zKRwmqiTt4C+hT5eAU2r8?=
 =?us-ascii?Q?sPvnEx7hzYQVRmi4QuOPY3UIqgaQICJ16rohUUY3czSsXuQMYrqMz0EgZIeb?=
 =?us-ascii?Q?ak6wJmJcDLmLenH/lsEl7+xulzUr/DwIl8f7P7pbb2W9qUQNdOrw6M5D0DH+?=
 =?us-ascii?Q?9QPvvrV+i8273c41ZY9sf5ERmQVqWh1YSN7toA3dhldLysHFWg41njcMshCz?=
 =?us-ascii?Q?uO4NQrTqTC45NnoLwTvmvhHHUj1kHrNqDD7w2RaazdBAN31p6/DhMdjTyDBE?=
 =?us-ascii?Q?1oEesIHM+esYnIpp/rj10Zf7q4p50P/ML5LFx3yUzbGPYDYSMWHpvj3dTpqy?=
 =?us-ascii?Q?5iqlRkM0eHGaCJwy/Gs+kujXHY0DXZ4o69Gr21t+gnvwtfy7nO8S+ugxI4Ly?=
 =?us-ascii?Q?W9st6u31nMDUZY1tKjyhzJOEl8QP2INMZmFUziLy6qOZuJWmo5UZQABcfuzG?=
 =?us-ascii?Q?ZjWyQrUzQPNnilADs89aE6i6DoOSC0k/0WtR5//FSp9z9+6YsJkJ1Jq5/vna?=
 =?us-ascii?Q?jhoytBdK27hAg4VhYEcxnfri6DMttPf9RBJCDfr9zeeRVxCtDA/RpBDPjnJs?=
 =?us-ascii?Q?m8RPGXbqXfRRAZ1UI28BDz9rCylaoIAo5gMoGQGX6jj8Ka9NFlbBgMcBU2lY?=
 =?us-ascii?Q?XQ+BGo9xUClKMAb0rySm4mQdepvX1WZxD53NENRxjRv1Y+bh1EDcOlNeb2Sf?=
 =?us-ascii?Q?bkm25G7cRBaA54CYefZMNnJNwSpNTYSg4ljXDFyjT/DsaW8hGl13cf3yiaid?=
 =?us-ascii?Q?2f0FdYCfCL3g+qJXqjGGyG3yPAqI4CIqvjPWAc+T1F7AystFS8zoboVWi5eG?=
 =?us-ascii?Q?59/sT+A8BJ1OzDR4BYL3ETNSAR6aFrlf17VT4nji48kTH6JrCtZs6t6cavy+?=
 =?us-ascii?Q?l9F/ywfD8Rd5E4n8ruvd4TBYVTXLKogkKE4JwIHxKSue2SHsMyzaIowf1Amk?=
 =?us-ascii?Q?ZaHlxaw97IKX96pi6EcqPfwDZuK7fUFRiz7RYLseZ74yyk65lS24rhc3L/40?=
 =?us-ascii?Q?v6FHNscAt8RnJ4W3OcDp7w/NPctZtl6Al8NBQ54rgnH9K2fI6rjkR6fm/A5/?=
 =?us-ascii?Q?WoIU1EftN22L/nzc6JFZ9dtqaZiLcUhooHit7cELQhjajzcEEAmZd2TL/U1z?=
 =?us-ascii?Q?0TJGjPsCLw=3D=3D?=
X-Exchange-RoutingPolicyChecked: lClazy6EXn6S51KzpmpgakZcRLI6VKgNBA7nIias8nGs+ZkJeLoeh2SDyR3V9AssyknEtoWPtVWFKYpGzZexNC7r3Kz1RJCwW5nEQN4I8zv2CbWJGWOW+h6yqIWhXYmgQwbf+21rW6qMUzcKy0bRpU9AqH8zpMIAmP4pFzZImB6O37oR+xvC6Hem/4MT3cZpIwYT/O8cgoX2HZU3bEbD749Gls+jwgcld6/S7ejUug7byLHee6vZ0Mk5I2Mgrm/AADYY6bUjievcRJpymZ0lYRSwpAxD5xsaC7YR7siHWUWkE6cmcPvXVhfMGKWCT5712xhsQcK4izV8E0WPXKZNbA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ecb0df-badf-46bf-72c3-08dedd3d8d06
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 22:09:16.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9H45U/vmFc73+9ZHTQeARkYzI5ITrokNQdpvGRrj5p+vnUWNQ2gWI2Qs9wjLZfnErB6XRp7rNWrZ/F0A/nY7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8530
X-OriginatorOrg: intel.com

On Wed, Jul 08, 2026 at 01:47:29PM -0700, Dave Hansen wrote:
> On 7/6/26 10:57, Sean Christopherson wrote:
> > What is "the S3M" though?  Is it a separate chip a la AMD's PSP/ASP?  Is it a
> > per-package thing? Per-core?
> I'll give you my rough software guy mental model of what it is: Each
> package has its own S3M. They are microcontrollers which are discrete
> from the CPU cores. Each S3M gets some CPU physical address space routed
> over to it.
> 
> > How is it accessed, and what are the "rules" for for those
> > accesses?  What types of latencies are we looking at?
> 
> As far as I know, the latency for one round trip to/from S3M is on the
> order of a "real" device. It has a physical address and when the OS
> wants to talk to it, those addresses are mapped with ioremap(). It's
> similar to any modern I/O device control plane. Note, though, that for
> TDX, there's no ioremap() because the I/O is hidden in the TDX module.
> 
> The real overhead comes because the I/O window is essentially 4 bytes
> wide (IIRC) and all the data that comes in and out of it has to be
> squeezed through that window. It reminds me of a UART, but with a
> slightly more arcane interface.
> 
> For TDX, though, the craziness is mostly hidden in the TDX module.

I'll just add that this design decision comes from the fact that we're
looking at different kinds of future attestation stuff. Some of it is
quite complex (like post-quantum crypto). Some of it may even require
more complicated interactions with the S3M. Hiding these details allows
all this crypto stuff to look like just another TDX module release. The
host kernel shouldn't be burdened with attestation intricacies, and the
TDX module should just make sure the new module "works".

> 
> > What else uses the S3M?  Do we have to worry about contending with
> > non-TDX usage?
> There _are_ different users of S3M. But each of them should get their
> own I/O address and S3M firmware has to handle talking to those
> different users at the same time. The TDX I/O window is owned
> exclusively by the TDX module.
> 
> So, while S3M has and long and growing list of jobs, the random software
> (like the host kernel) poking at one I/O window doesn't have to know
> about the other piece of software (the TDX module) poking at another.
> 
> I'm sure I got a detail or two wrong in there, so folks that know this
> better: please correct me. But I think that's a halfway-decent 10,000ft
> view.

This is pretty spot on based on my understanding. Thanks Dave :)
