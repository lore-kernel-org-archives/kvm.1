Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF143F86F7;
	Mon, 29 Jun 2026 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727392; cv=fail; b=EOu2tYleuwt92ElZD0ZP1BIQMWkBTwkY23slH8RRL/HtXTDnMwa0capmfC+daLzcN76F2WfG8AyU4+VsySRT7K76Kbxbg+QR20dKMNfIyzgSZYwajWUGKeyZDgD+ZWEE6SEArZ+4zus32Cda4ZUuzYKRXrJfxSc2aYLjOk2txDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727392; c=relaxed/simple;
	bh=2Hepq+0WXeTYin4is0l3VOUS6xve/VA6qpcGnGa9TqY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CUPjk0C8m5M7dJ6YdwwHEdTP2EQLII7nB3pThqOIWQmEn/NoLBZXxBf6xzgfXovPYZvgel8x15Sj90zdHgKfDMDedk9DLBg9q3H9H1cIIJkBKD4PJxsjpwcaDIaxSjYllA7FfWwk4ey/bhep0TTnfMrwWfzmtwg/P7cPCgUQlN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDitUE7P; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDitUE7P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782727390; x=1814263390;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2Hepq+0WXeTYin4is0l3VOUS6xve/VA6qpcGnGa9TqY=;
  b=ZDitUE7PFa6iY5O8p1jWWT4uZ1JRtF5KJHlBxk7lCcDRwnFMOmd0DdAC
   7RjTsCgKadE5c7n/bHmf5XefE5Y+fDBmUgK37APG4DpgE/c1wgeeakCMm
   s3RCMJ5JSF/ZRLl3a3oDD/lwmYr+Epk5uwjdbK/JcplxMHcywmvQvZOgf
   oRFI0NfVN10wJSAe+4vXdtmCZIW+9KPUGLN/NTTAmcBJdMC8pHiUDHePy
   urXepKGQQegcM2LIYq7TtUOqSbnaHujL6DHKdMvATnJye4Q78zYX3pQfA
   Y3ofsoqaT7H8IAbOTHfqFC5eCpNjUZT2PBjCKmQYFQ+Xs5r2svNInZIqd
   Q==;
X-CSE-ConnectionGUID: uRI2K5jrQW2ypm4i8KF28w==
X-CSE-MsgGUID: 9dSGn1UbQ6Oyrm0435D+3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="87103972"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="87103972"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 03:03:10 -0700
X-CSE-ConnectionGUID: ICTB6W8hRm+I6jVi5tK0Fw==
X-CSE-MsgGUID: XcMNjkQgQzqpoDe4WKLJcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="250225941"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 03:03:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 03:03:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 03:03:09 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.20) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 03:03:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zR53S3GasOnQra3XNmoRb6sbjvlvuTXCd2ILFbHF/CCv73oXESM6sFmqLtkpu8ydtIL+upa+nMuMYKzpZBJv92x66JwIbFw8DSKZtxRhzKjVOrWhWBz+poC0CQRByy5P3U0DE/rsNu4PEzcR/YaF5P6w2B+ssLstGql5j4hP8LL16i2DYFh33C3sTL2f1kNDaeQYyooUADO233Ikr5Bgo6rU4i36fDY7/yBqj32NpufDZB4LoHqycDTNak0mdYqFc272TioUtKYISZQfhFo78TQ3XVcYK8YybV2MVl0XidwiEgHGoeFlUyLjMsGrB1hfBQgNRwCh/+g3k7CWTjJu9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nJhancy+hZ4ZmroqGiuvmdTnHIG+32rjSl5VN+0wDQ=;
 b=qTtZtblQiHfeQFPAdQNUnZfvv2KqB1GkSDYb2Wqt/dXn646Vnnn4l1brA/4/aHafWx1m+niEvPft62cNV/wyZmbgLkm+Wn+QLf81V6lzxBjA4ouXJmlI2I/AqjNRiXLYuWR3+2mxTqn+CMpkgOauPb2L+CRfVQETsegjQfqc/YSxoAGPnflVxjx9OklJCKqHAziBkReD/5NLyqIcATvEOmBb2nsLm9jvZucP4DwAgOUw04QeXhqsTjGyJvjSI17jfZqk9uEWUp4ZknYm42ZRU4x4zEYJF+iEQVPimIaYbbzrmW9wgMLnCyAA+EMviStCyMzMjmee6hsJOuXJGd7Mcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by CY8PR11MB6892.namprd11.prod.outlook.com (2603:10b6:930:5b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Mon, 29 Jun
 2026 10:03:06 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 10:03:06 +0000
Date: Mon, 29 Jun 2026 03:03:01 -0700
From: Peter Fang <peter.fang@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <x86@kernel.org>,
	<kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <djbw@kernel.org>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <yilun.xu@intel.com>, <xiaoyao.li@intel.com>,
	<sohil.mehta@intel.com>, <adrian.hunter@intel.com>,
	<kishen.maloor@intel.com>, <tony.lindgren@linux.intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<dave.hansen@intel.com>, <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
Message-ID: <20260629100301.GA1743876@pedri>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-17-yilun.xu@linux.intel.com>
 <aj1tFuwZWdPGfUoG@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aj1tFuwZWdPGfUoG@google.com>
X-ClientProxiedBy: BY1P220CA0042.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::17) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|CY8PR11MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: d8426523-feaf-4588-d28c-08ded5c59d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|23010399003|1800799024|376014|4143699003|3023799007|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: PITIFqE8jKdjH6wIjOtymJ6DBnXQ/t7GZF5Cq2Lvjmg5kWAWscvecaGcdODlH4YAPJGRiqlBIY4o3f2+uJRgIx9ZdPPxCxAnvpfbZ4zW1uxsmovrEYGoxLvt1sl3Zqn0tgvI950sYNQTMkuxzqvaZddtszPnwq8otaul0oPmMcGGNu+7ien/UKxyhcy5uAvghWPleXndKoZ0kLSNLo5c77T0s1gVMyDc8OY0CQZRdu7p8y1UXxes5X3de/eYvW5ef0z+vhplfSf7oVtO0u3Q4CMENCNdh9JySzBdqwwV+eVmt0Yo+ay2EIxtcKF6kWI0KKL/v968uGyv3FKBSHN2Lb4WnH4E3IMKdHg3gmoUvvGBWTsEvjbBumMQZkHeocrrMKjCIFaXmCefbBMeugkLZs/wRFC5wLXlk0d2UPmakY5rPOvI2cY38cJ/5m841IMrfAn7/qnzOh3IAKetOrRfgSnkNcwiNiAp1t0hal7TvvefgNdc4YNRrCpDEENgkr8T8LOKJyAadUQ3BconoIHDBZ6v5Dy1WgNjFVXWB/fJxusrOw+hGazh1W7zn/28858ZRVsWN74witmfPThgxji2Io3ZK0zHxMFY0sLJvbLgIqk6DjxC2rcOaJ5L07AITggNqE6bjF4YiPhh8FfFxDtH7gJbRG9yh77EGSsAzmjHo+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(1800799024)(376014)(4143699003)(3023799007)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mb/qLDxbOLnl0jujWCx2TnnYbL0AknKZ27MXcuvHPl2UUogONfK7U32Y3EXJ?=
 =?us-ascii?Q?jAnMiT99HeULJtvcgKjGObsdjTn3YOh6mdP+7RaxM5QB9fVpIXlqT39PzByX?=
 =?us-ascii?Q?iWibbD6VNdHdW+Y0MO1E/8rMZKYqeBdsWzJOjrp3R2XRym6XES4vojuUVyNd?=
 =?us-ascii?Q?oUl0HUsLCsaSwDokQWGrRm+9Cq0P8clNoo7Qh4rCgSi6lokEfuHho2eOeRo3?=
 =?us-ascii?Q?DXs4mIOGFJOMKUPoxzvVKuL8AtI2Gv8ey2PQb+KrhG7ugzr1UVUdMCD3c3jZ?=
 =?us-ascii?Q?LyW38GCHgHsZtwZyUOHNFzWVAn5fWqUWBZ3iIjohmbQABOHTWb5vHr5IAYda?=
 =?us-ascii?Q?JYlhc0TMRQ1JHu5YDUcaH1vlgzyb5hXzWuwEjf6iIT62d1Hh2RoySGPGI4dF?=
 =?us-ascii?Q?Udnql0jHdBeqGWzJswouGKfGnpkSjnZkjBVYadbqY5rfxt4wF5s/mzWgEuHK?=
 =?us-ascii?Q?VuDOUIJ7QwEMaoCdvQCv7zNBhhK1YeheEh0/MDmNKtnN+yncLwnRE4rOjEAe?=
 =?us-ascii?Q?wifeVqhk805KYgdJOE6ehgQmxS2MAtGmJclfUMrobaOpFFRcfN2a+/atgAJs?=
 =?us-ascii?Q?c4kyjLHARyxJ0xSl6Q5rtgksq6NvsGh6OOvtCwp7NnJBA9Hg58rSWsk8+CY/?=
 =?us-ascii?Q?EYfK3JY4nmNGiJDWkMQXefhFG9CSjL2ntlYd4Qx4m+29y9hQtHIZSEqLlKb9?=
 =?us-ascii?Q?jxsPjJjNCvm0CclIyDpvK7TNBtD6orO7gkwl8JpFtY4QyNE1ugJsl0Psa1o0?=
 =?us-ascii?Q?l4fFWmjktEUt+GZRUTpGGoWUKxAuNOnsDhCVC9OprEX3xFeF6YVIZGotSxlr?=
 =?us-ascii?Q?wVBF4y+RjvX1sQwN2LvbBeJr+PyvI6K8G741iYDqY8jIFlYbg4BepcmSXEJF?=
 =?us-ascii?Q?hMFUHLJ75t8ijB39WV9l3J6A5qQNqJOZYR7Dbj/99bvNq0wRbwoGQ1Cb80M9?=
 =?us-ascii?Q?Ybd3azF/nQKo+N66VqTDb1kVHgIHcpnbPwK9Ju/2lLFvir+h3zAbcI5uYVPI?=
 =?us-ascii?Q?z2GbKjW1VahiHmXZoAXACe5YNZAkFV0a1OqLhSZ9tbRJlswkX56ViI70s3UO?=
 =?us-ascii?Q?SJ1qVRDMZcna3asCSyQ5LQR+iudDln+xjOTBsXH+0KdsfzNEkDe2rsI+kMS0?=
 =?us-ascii?Q?kF0zngPxyv0+RPSUbRjhBaUsB5wP6CuMRjvY5/gnXx5mcHSWXvCP72DlDDnl?=
 =?us-ascii?Q?WBSCeoJpa/FE7s6wA2YtvcdVQ2HZJ9Ijkg1HmosH6BWM5Ug7VXtLnnNbGShL?=
 =?us-ascii?Q?1mv7BsbrmrAN0aGatR5W3IwqXYomrr1iv3Cu2yNmPiC6QLD8Zu71WYSaWPzN?=
 =?us-ascii?Q?TFFWXXugvD0OLILdVf2n08ACLNBEQErle1t9MKusj8F/gx6tARaUCCKkHceR?=
 =?us-ascii?Q?RN6wh8KA/TgwnLMb8dd2BijSjz/qfzbDry/ZG2FQdDEjYUtCYfp5QZVn2kIP?=
 =?us-ascii?Q?m+UeXU2/d/BeT3Pegr/0+hWpga52ALJjU/qiM4g7SQ3WXFPSobnihUkfaETG?=
 =?us-ascii?Q?UDd1iOsnkKCKh53/nqJses8/92gg9FSNkjXhB2Z2myvJCdqyElisXYJZMuSU?=
 =?us-ascii?Q?h2GJqa9TuvyEPtLKNlBs+Akn1+RSstWxbAHt3Lbvm1i8KQjo+ZmDd7iT0Fad?=
 =?us-ascii?Q?2e8tkPnMtMilzOkzkUY6zsskBGgjNOWauw/CDSvwhApser0F5kWXiceWaIw7?=
 =?us-ascii?Q?RXvqqATIh6+g35SmUU+ZGzXhRvCq3hlPD4c8u/jPfAZ3YgIbLiAzI3Un9Gmp?=
 =?us-ascii?Q?98MCNCn2sQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: NExUcc1etW2V31efgFJCc4kRrovWCYv98UuY0TpNyl/xxq9ivO05hFHVPGKj8OUEjzZoNquIhWrmumfWwOox45oAN9l4AU+sNAqnHEmjyBWtgEztaBHDmr5GKKee94zlXlEEjECEG83DXne5jqklYWeT2wrJlm/Xi6TGMUFIO4mG8R/heXXvfnY9B+mXCzZdj23W53B1hHd+Zyofa7KqWhfT5t6uo5sTMwnozpizvfrayQ4q2NR/piasvmaD0aryJCHpz5U1ZP/mY5in8E4ZJwfvdje/zaMRMAJfA/2Uj7yYBA8ylzOp1A+pzsu8Cn8iXZb+Fkgop8QwSgQ3Zk7X0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: d8426523-feaf-4588-d28c-08ded5c59d82
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 10:03:06.5605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPaJtp3SWJIEzT63zBEUHxcy3qkIBMaA+MhLtCE/rdN3vijHm7Rw6dPolNKPmo4ORxF307cDsrwDyNCzoFMFrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6892
X-OriginatorOrg: intel.com

On Thu, Jun 25, 2026 at 11:01:58AM -0700, Sean Christopherson wrote:
> On Thu, Jun 18, 2026, Xu Yilun wrote:
> > From: Peter Fang <peter.fang@intel.com>
> > 
> > Provide an in-kernel path for Quote generation when handling
> > TDG.VP.VMCALL<GetQuote>, without requiring an exit to userspace.
> 
> Why?
> 

Hi Sean,

This is mainly to avoid a round trip to userspace for the GetQuote flow.

New TDX modules can now get a Quote directly via an "extension SEAMCALL"
instead of exiting to userspace and using an SGX enclave. Exiting to
userspace for GetQuote no longer seems worth the overhead/complexity.

The first half of the series enables extension SEAMCALLs. They implement
simple APIs for higher-order security protocols that would otherwise need
to be broken into smaller routines. For Quoting, this allows KVM to get
a Quote directly through TDH.QUOTE.GET. The TDX module needs only the
input data from TDG.VP.VMCALL<GetQuote> for that call.

Thanks,
Peter
