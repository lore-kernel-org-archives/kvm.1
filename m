Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E191B4A1E1E;
	Thu,  1 Oct 2026 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859959; cv=fail; b=on/dnB4GttbVMCxKwZPpKYqeduBFA62B1gdutZRINPubXGL6mF3+Mg3mZBhlwgrsrcvxqtk2/xMlC7iFmNhg83o1KU/sAgCOXB5+6d1mNXKPb0CpQoJ7FjMvo2HLRzIJRhi+PaDFV0gNeOHHRctb2BU0o4qMNkb6VBNQK/Az9nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859959; c=relaxed/simple;
	bh=fXoMuOVOZsm1d0tZp5Vgq6AVXEcs90MRkQUastFACxc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L4kCQ/R7BWJm2f8CBhLoR5xRpwN7HcJfhYGhs1wQLGYKSeS/q97fX7mLLv2RSflZq0t1TLd4ELTCU9fxfSUGEnDr4D410Sy8fXz9of997rOkqakDXnOFXRQ+GfKmil7Uzl04IF3HEPEUZOyx/5zhNwUAL6cFI7qYT1QgMw3R9wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGjpCwqN; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGjpCwqN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790859958; x=1822395958;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=fXoMuOVOZsm1d0tZp5Vgq6AVXEcs90MRkQUastFACxc=;
  b=LGjpCwqNjmvXdLqJCqzsIMVOmgN3bZGjggL0qnuH0PGU2nq/8n21YxqH
   Y+CaMwM0pawTU9cS0yT8QA1E+6QBmv40iR+8hYiiosv8Pm25O/1PjThr4
   mNrCDJqKAAbFS8jN77hXdoxcVgKh5FqcmtMXsN0wWe2kqTozEI5YQNO9A
   TbQVFxQjU/ZfPx1aefcBDRMUJrkjUju4PUkFtaJsBhJogaeUNmFpArl8O
   8JCebkjKr7W4nGoD4/zWePQQjnNoUa91Ow2tjiqOdE9HQamFyaY/GEyv7
   phnnTDsQuOX7GkffqKm/Uuy2BgX4nyOPn927/PMgEgOZ7H0C89EkmHYO5
   g==;
X-CSE-ConnectionGUID: PXHuM8yfReiO2akmfIABCg==
X-CSE-MsgGUID: YW4g9np4RDmxHn7VkQontQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94096156"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="94096156"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 06:05:57 -0700
X-CSE-ConnectionGUID: sAywhZN6SsOlYSK8MUZ8/g==
X-CSE-MsgGUID: pKl+y6fVQSC6rO+fptL1Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="273810023"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 06:05:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 06:05:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 06:05:56 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 06:05:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDT/9pjvOZY/DN0FyMvY2lU+KyT8Q7aG3egRg/trxof1F3angzdLhqMQkfAR1a+C52GyYN6GicSbDWP+kyDRZY3Wte8TVrSBiVE3ovSlfWSHky0OSHDyXNILhsp2eAMd2jPxcFMPY+vc3bbgQsSRJUNyDyBovEKCoyMuETaVEStTdcWSzuiBufkPhMnKFOpcGpIzrDm6Oof6MW5eisC1dteahOY3wfT1BKSB7NHQtkcPlezXsN1Lakz3pBuiIi8021ke4zYU9WBlyBnlOZ0S3bI6hkFdS5RQ/mh4cML6dXV46IGveVbGYGecMtVg20qPPZXCZaAXJRDaNLI7A+Ur6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCBNdvziTX+MKkyR+QjLpzfvsX3SFoGGc1FOdAMb8dI=;
 b=Nqtj3Bz25I9POYVkxnXi6eVBzZSZyOCJ0ywC1YN4Uu0Ib2zQM+HOEA83nasEDXZYYbboUOk809wFjFN4/6r9hD4TP1etXq+9cIe96FzP589iiTYrU+WNEQxltZ/IaoPLDjWJnS9Sfo6X0ymWw2PtiB9Frgkkv+f07JOFPTqDogVgVEg7n4kxthFjdF0TjuZeL2qCr238TEbeEbrf/LUpO5MefQLBGz6FCHHC1No+x+ho1oLwfWs9GS4JbRqEWFGE5LYq6ZMNiEnNKNiIDIOVVgMQhyfHrWH58CpF1w3BMzcnmXjEd1Y33kouzhIN8azCVAAXw4ab9lSHQePM4qDs6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by CHXPR11MB9674.namprd11.prod.outlook.com (2603:10b6:610:2fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 13:05:53 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 13:05:52 +0000
Date: Thu, 1 Oct 2026 21:05:37 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 09/10] x86/virt/tdx: Use early returns in
 get_tdx_sys_info()
Message-ID: <ar5aoYtcYMtmdFYK@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
 <20260930053901.22528-10-chao.gao@intel.com>
 <e23181da9391a4e07437da8ef5a88420f2a3279a.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e23181da9391a4e07437da8ef5a88420f2a3279a.camel@intel.com>
X-ClientProxiedBy: TY4P301CA0093.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::11) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|CHXPR11MB9674:EE_
X-MS-Office365-Filtering-Correlation-Id: c74f6870-ce1a-42bf-1f73-08df1fbcb8b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|1800799024|366016|376014|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gV2QC9P+cIv6osmMBc5Ia1p6YTP+0sSug1fBx3TVxnEca4ykZNPws5r+QtrE+8DDiIg6bbidXTpHeguyvUxrgVuhCa5LiZgmRbhppNUg05SVQEGQffhTJFlc+EeRs870eKlIUcpFYRVFo2O09q6+zKDAUKE5Vx8pwh2psN2WfZsl1AsZ6/O1bAFkSnJ6CCh0T9R8AqBFKkXJ2O6/geFBMSPZHkfn78JVgu0z5VKZtah6H+T89LIpoPp4pqVcwJC7VxGjiKTlRZi96xbex2UK89qSSdf8hYT9HaOaITYc+XmHAnCFhmDJa1he8Jb00Dm2OiqRRuDwx0ex+i8E5/QbsToAYIUKTnrUBoPLis7zoxslOjxSdQOzIBtAV9LFOHzpPmxwElswjVMkkHTmgxNltGILXk2wbIUfaUSvko4roJ/NvpFI69HrK4g2pgvu9FE8xZhWfvIEsfWuQ8wSHvz+smNGuNW+FgkFSbEr5FFB7iWsbLjT+s8sH42eteVvU4MSLsg6+mBimJd7AWNkL4XfNQrOg4BbWiFsSycrcpg2jUfHpRUcGXnk3f3jM2nDsfdc9TTkGAtY5cJUJGLNr43ITwGbixThec6zgoYwYfJ6Fl318Nds8VPsKSi899X2czOuPN6C8snAHlFq4xXt940V/gfoX84pZ1nfHX8c3MH7QkA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(366016)(376014)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Gv2k2BD75lxlsAEY6K7RZtKxB5gPd6qPyvqM43Vyr7O5Lp/scWUCws0eAx?=
 =?iso-8859-1?Q?vweD8UEIrVWGfXK9Jqxw/JJ2yqR1EHliJuh6yZBG001KGogje4Gk6imzVW?=
 =?iso-8859-1?Q?kF6mTu4XpUGeeIFhiCx6TdtHYXQH1czj9xB50p83uzuKmzM9lJDyDzGvXg?=
 =?iso-8859-1?Q?80p+5OkvD+np+LqPg6k24Oo8+oTtlFMv96dHUYI40qO26Mgt/cwhR6FmAd?=
 =?iso-8859-1?Q?2zypn6Ru1g6Ujed0oaqSAjjl/YPLsryaX0iJHEVr0GLRIFt9eIXBY8D3Jf?=
 =?iso-8859-1?Q?YCmXhWxoZS8z0dflqvy3bML5jYu7GsoD4pNj2xXQrNm6AYdCRC+CG2w8bz?=
 =?iso-8859-1?Q?d0NsLbbFJDQbRBYdYV4huqCVZCZI8m618TxVeU9DBNrJsvYhPYfC5GWx1A?=
 =?iso-8859-1?Q?p3/OLrqhNs3PnZU1bx6FkEp0UfwLGlOWVKEDqsW8iqoP9AhlU4S4hxXdnf?=
 =?iso-8859-1?Q?zpNXfjpZhNW54ZePpVbg9HuKljUg65+3qcDkCTbVCv+eSfcvKR+/S6Jdjl?=
 =?iso-8859-1?Q?l51oLZqP/oyVQvbU7ty4vvIwW0ZiX0N7jOE+yjF4i6mn+zyluJBtNH9y0A?=
 =?iso-8859-1?Q?c37jYwDwg4I9w/inhq9K+SbQhRiBfiVWqHJRTxiCf2BaLrZv/wgm04spSr?=
 =?iso-8859-1?Q?0t/PWfKnhT7zElmyUKDiZZxBDXTc/ri4maHpZ0wik7z+J1LUWYftBu7elz?=
 =?iso-8859-1?Q?fBWZ+b5PM77SHC6hKXyEpyB9yOZBxeLZfh6hqo/8hXIFPUTpzoLucIOIrF?=
 =?iso-8859-1?Q?35AdujWQkuwWOxBGxh/+7YQpeD+MGuLp3Wpq+L5II6CBQnKSmfhIOKS2Hg?=
 =?iso-8859-1?Q?YgPo8DafeXvj1hGKSslasBacSMaaMpnDT6vYQqZ4F9fATNKnDYy/Yry3WD?=
 =?iso-8859-1?Q?zIn5tVexQPxfhofQWTv9wNEw950Rb8k7Ev4H0TVj8brXHHlL+8taS/QwBM?=
 =?iso-8859-1?Q?QrnbDVydLJUmWH+71w1YS5x6VLNKBavlJw8aoS9tz/5n+/HYM2A7xmhiuN?=
 =?iso-8859-1?Q?4p/wD1PDaRnZlhNquEbcUTjkf7Tdo5hFgaHppxmjBf9U6APBUsc7MjEBiP?=
 =?iso-8859-1?Q?/ExBFZnTVg5623Bn4n154ChbIwAOTNI166dK0JQJE19sip6SqgFYfAcCEv?=
 =?iso-8859-1?Q?LjHkJtEiO1lBd4zANfBB4Ic+hhGDdcQwrHeFze2i6D949xe0oHybiLHW/Y?=
 =?iso-8859-1?Q?AQwkKlHFjSIFFEOh2ViGcGkRNQ+RcynkdDODZx7gxfaZ160Ou1QOIVo/Go?=
 =?iso-8859-1?Q?YcGU+pZZ6mZ9uGvEmrY5D1O77IAa2yIuJy090aUEsWGsQj9EhqWb3QqcNx?=
 =?iso-8859-1?Q?5imR947/gdYbMPexJ0J9hbUCXTpiyukp0HtYzc4ULW31HnporDvu9KAIlj?=
 =?iso-8859-1?Q?k9ulH5+WJTfahwaLB6ywj6v5No+TNb7jSAaHRt3YOefvBVxpf7JSSTqAUY?=
 =?iso-8859-1?Q?7Y8mM1eKQWhciSBJQV6GJwlObKkJgXM+HGZLe2glegXs7t3Qo3yOJEbGZT?=
 =?iso-8859-1?Q?AAQONThyv/x9dxMTDhcV+Yd8xKFjYePeOG0VQJpZYhvTJopDZ/KtcXdpqG?=
 =?iso-8859-1?Q?06wEP6iIDh/NBsbiCjWjrwR3ZCGBFMT1Ssgxj09dV1gMhEMKrGgWpPm2Um?=
 =?iso-8859-1?Q?MJhxydJwO1qFat/DqYKPWKti7sS945DiAovu3JL/+sKn+Iis8E/BxThT19?=
 =?iso-8859-1?Q?N8PsAGIeLFnUNu7eF92l9VSKh7424zFVPfkhu0z46ShdL0ezHfDabXukVZ?=
 =?iso-8859-1?Q?HYQYNYPztAnAnQP9/0hf573V8tABTvM5d+L3D49c+p1p+d04Adh5BDC6SK?=
 =?iso-8859-1?Q?OIUa6TOx/w=3D=3D?=
X-Exchange-RoutingPolicyChecked: FZpY59gg9moZpcNOaz4AIjseXIQJ1hmujad42/9bKg9lpFn9D5pvEbLSF5e/qGkJxDB8QbTlNmA/3oB/ztIcCtHFKkbLN9vagyuPdoejWlKPDI4myWs4ohP/qVSxSvzLK+zgDTRjV11HsD8D46J3WNYlgJ8udpRH8VMDcFXFFSnzdzON16lAkO0y96FsQhSWWoZvApylEfD1A2+l9Qeu2ANyRcNGT/ZKRqCMoOsSycv7uCcSluCVJSFL7pnGcI1hjj0DeLxqzHFS7mizmyHWGbxPgtCyf+DdAijyEZHwX1Jd+cSob9i3tB7FBfIrXB36qp+yk7wDpButCpa14BJkJw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c74f6870-ce1a-42bf-1f73-08df1fbcb8b2
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:05:52.4394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfbBmn+6LpilJEFHUjGjXuIb0CXaDxk/++d9dxx4pRWWTWCZ86+87SpzT7XUZ09IlSFD5FEoMFWFB0BvKctzeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR11MB9674
X-OriginatorOrg: intel.com

On Thu, Oct 01, 2026 at 08:30:05AM +0800, Edgecombe, Rick P wrote:
>On Tue, 2026-09-29 at 22:38 -0700, Chao Gao wrote:
>> get_tdx_sys_info() was generated by a script. It chains its metadata reads
>> with:
>> 
>>       ret = ret ?: get_tdx_sys_info_foo(...);
>> 
>> The function is maintained by hand now. Use conventional early returns
>> instead.
>> 
>> Print the module version only after its metadata has been read
>> successfully. The "ret ?:" chain had no early exit, so the pr_info()
>> between the reads ran even when the version read itself failed, printing a
>> partially read or all-zero version. That isn't considered a big problem,
>> but early returns make it easy to avoid.
>
>Nit: The reason it is good to change it in this patch is because not doing the
>early exit looks very obviously wrong now, where it didn't before.

Good point. I was struggling with how to justify this change, and your
reasoning is better. I will add it to the changelog.
