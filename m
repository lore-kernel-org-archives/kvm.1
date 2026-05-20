Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFF83A7849;
	Wed, 20 May 2026 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276217; cv=fail; b=bclRmLGbvg6ZDvz3FL6t5SdGqInLsEuLxVyp8HLFTyss9Nef59F12awH8gPsDINDhqok0NUZyP8p0xuZdjUvB+UHxlBA+sJgUwfdgakSIxfRtW/vsoO1cxDDgikHmBdwwHdk3XVjvaPsACMKg7UTlLP/Rc0gkUutTR7MfJ4feLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276217; c=relaxed/simple;
	bh=YZa5MOITnxSbeMAxDfSMIVEMIBGw3CKXnX2uDi/uUss=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YOOf04OA/XXcjhX/wgeiOmrKA13WGmUsILn5a0rPGLYzxyHjH6uX5Xqz+IUa4oR+r/kb3gMSYX4OiV9bWSM+Fh6fw/sECPzlJGUyebg+edNH/erNHwhTW54mMWLIP01yNLMUPEv8okqbNaAEBuQIefoMjvHBUfAKvcE3rV4oT44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPZA4+mD; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPZA4+mD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779276213; x=1810812213;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YZa5MOITnxSbeMAxDfSMIVEMIBGw3CKXnX2uDi/uUss=;
  b=SPZA4+mD8PFKgJet+mLroCDHCMLMKxHy4L04wQTmlhN1inkrvFvbkcke
   zkRkQT16rC7t8nLJIXg5NFGqv1kM+BwhL3KD9qK20UBOuavh5ZA3kQzeq
   Ah17fz5uK/Tafih2SBIXSRqvNVhAis98RIEnQ3Q9qt1QZ+NoqCxJBnCsm
   LB+BVbhuBw8eZgaV6HGz/kUEKRs8FW7WYynrOKQTPcdE+qOuGh2zEtYoQ
   tYQ1Xmx9IrxKi4S3htdxmDN4De1c46VbYecHcT7N+O5iQHz64vWDkXRdL
   n5O+hgnfOFHeSXDPG59+kjqpYkRxJvuu50cfzqh5GM55wjo7D9lB68enW
   Q==;
X-CSE-ConnectionGUID: lNb38ySHQVOjof9R9kgMXg==
X-CSE-MsgGUID: 44wQUQMSQNyWrmBwec1VCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80227047"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80227047"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 04:23:32 -0700
X-CSE-ConnectionGUID: x9ukyNYgQ4yw+WY22zrQnQ==
X-CSE-MsgGUID: dypSwXvYQkmmL5tGnAckiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="240003034"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 04:23:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 04:23:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 04:23:31 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 04:23:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxM8VPMyDhyJTZ3QAWqQuEHU6pRia6h2jS19kAwL4CJUYAIk5t1XgiHPdcmOp0IwjBXNvfYBKlAI/DGSyI+Fx0gQvsqfsEyQMB+Hsnph8xdx3TSUIZEI/AatfCOYQ+Ad9G0UZrvWL3pb2VAz+WAUtus9zLmoFyTNTwtEvzi76uBpULrk/QGay/BjuUfWyeizTGgR4NekfUo7urVWcWJdQRkxe5up0/a+VggLbWcE6euwtRve4JaaOZ7CjloEKTUvIkU3qoBJNMuVjxHMWJ9pScB5tTtbfuYaLqgLPTZTaRGGitMgJfO7p18ytERO67wD58nWB3uD7LlwfZwO9xMW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUw4zQwFPxhh692pFGLus1wuoa69b298+d9lqOPi+zU=;
 b=T+nlF1HCmfaGLO3VfJbLHnUL6c8VhRFGN0SlOHy8wxypx/hSGwmNLHm3strTMHcOIdH4Vqmb20MV27fGnkkGO50UZxp3ytF+eytMTDSbRhdKW48Y6bswlM9Xlyl26BXVReGvXyv3EXHTL9BHWinfkllqPOaTkaEUo/r3r5eNwyY81SCOatg2s8FMirF0l5yYsZNBr0sJKlMNZ+CT3NgR1zdewbB7JWu+NdCvd68bhJKVOnd4wBivFeIFgjrgT62PBqCPCjihPt7NdWSUwasQCwKPsIixdkecc3ooZuol8S/QX19V9EVeM0ZTc3SEOEEQNZfTC+WL4dd5FX6VDKl3Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by PH8PR11MB6684.namprd11.prod.outlook.com (2603:10b6:510:1c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 11:23:21 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 11:23:21 +0000
Date: Wed, 20 May 2026 19:23:05 +0800
From: Chao Gao <chao.gao@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <dave.hansen@linux.intel.com>,
	<djbw@kernel.org>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v9 10/23] coco/tdx-host: Implement firmware upload sysfs
 ABI for TDX module updates
Message-ID: <ag2ZmQIUiAjNcfyt@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-11-chao.gao@intel.com>
 <804827af-f094-41e6-bba9-5f57d0e35cd0@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <804827af-f094-41e6-bba9-5f57d0e35cd0@linux.intel.com>
X-ClientProxiedBy: SGBP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::34)
 To BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|PH8PR11MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a05095-a937-4556-34cd-08deb66232e1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 1tnHRHqWX/RBiDj270m3++Z5P07Q3WRwpwWCkse1qVcuAUFfLoe/FbgEbkDCJ66jJDl5hhXdI+kLpq/EPUE0w8dFegYZCQ7917ZMUuNMreXOmxQW7Bh64XrJ/bKnN/mXCuoLoy9fo9SNlpDxmfpyWaV/HCEQgbN3cZPtzqAPil69T8wJw4FQYtG0zl1kLHB5IdM93KEILlWBLTJxI+pA/OiZOP4WFULg9qNqHMq+Ymrax90HKBVy+a7Ih3CgNijn/kG6GoK8HPXA1NsdFwOVKJPQJPh9zIIiZJIKbMCeepDB2agkJEXZbL/jVpVM6EJU+HToIHLOIO8nSf9wSzobqiBYppC8ka8MtrTWbtIK/p4pG084LHrsiKz/f6PQLGOl+f5gdXdrWOaNtUNvOdaUeOBUYctOR/lxnxNXTfrF0UL18oSVCj7trt08qPR9KBruhVEAJa8vqwG1JA7aImxYH+xOnr2joTwWQTNvIv4CPCPBpiGhurhqtYtA8pLtwozsXS3XWXGnQKcxams/it9ocxEDBW8slR/ZzXwHjnxpDbyqE95kGKNlZOPWLEHzYb4eiLowQv1+EU3GKnIBRDB278ef2Ee9Vg68QPR3+VCBVpE4L9AnRTDo2D6mLGPcf/0l+OVJjWwcCYHk/E1GwajO+wyLLHDmjBE/5IHDa36b0u+mRCfu0eE2y+G4Qc403icR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5PuUVx7HrMVUHGcq37wXT87epLvIH+GX8OmN/h7BovIC8Ed/5pX5kgtIUG3Y?=
 =?us-ascii?Q?9qRlk3ZBIQxIBLZ1aa4CrP8bdAit7kxQ3y6r/IjYbrL36KY2hn7LgCs/lgMB?=
 =?us-ascii?Q?Oi3K3Jjd8f9r+OkH2a3kjznaKOGtdGgTZ7FaBTHK6oXGUcCl1zpbRX6fJKWc?=
 =?us-ascii?Q?VoZGGKF8rfB/OcX0xWNdguiGD9sjK8lXOOk6XIhnxfVcauaf1xdaBIa87QI2?=
 =?us-ascii?Q?T43jZkIKn2dSLmiEILp8xhbkejPdhKS2HPpCc3nF4GJrHQADwuEmovnK9D1H?=
 =?us-ascii?Q?7NKG0t++1VTqsVdgsmuF/z8ZBcBsIEEiWeDKlLxJaP4S6Cbr2LHyUuPt3HwW?=
 =?us-ascii?Q?y+Px35yHw1ZEbLxcLS6CE9Mwltew96Tg/zNV8ZIqb7sK6YjKn3dZbs6/Xr5H?=
 =?us-ascii?Q?CUApmG1PfTGsu758e1GpBkjgQhhJMeTo64Layss31dxmPNbdljGff0Fz8Jhh?=
 =?us-ascii?Q?oEvA7usDyD+CMdgLJHUfCvC/SuMGc8ZYc2bwE2+nSesL6ZNLZWrRdAQhkjm3?=
 =?us-ascii?Q?lPQua7JJ0XR7H7a+46Ry05/dhzlR9F2slyxmT/SR4qJTNKvxDfdW3JXHUajc?=
 =?us-ascii?Q?Yzt5+HzjsPEW6d/6x0W0bDpx4etmgoDufnEIHBsBRA+PoiKC5FXjfKwI8VKJ?=
 =?us-ascii?Q?NB1iDlszyJAR5M3Q+qKLKt1tGZVsl+kxEUkxsmDmYikKkSPH6x5qkYPqHstE?=
 =?us-ascii?Q?A62Q0d+888sEu34TFkHD/eSbW9CiI4g7ETeMW6+CduBWt/CYP0YaK6aUvGvi?=
 =?us-ascii?Q?3XflzuD81jdz1uTLUb5iTw0TMiT8zHekYL1qZ2KkQGIguFX2DCrs8Doagh3f?=
 =?us-ascii?Q?7PQs0Jb6aWCbyvEzAo/587aXQ/XY97ZmQGmrWA0qLpfIFOotDtRbC2piOO35?=
 =?us-ascii?Q?zzA/0lbiYATY0z5BTgWLdDwfPf0PbKBRPE+whwvagTlitF1oyG2WwdHyVVvx?=
 =?us-ascii?Q?BSTL1hDMfUtCFzT0p6+xS5kMQwpTUkTPbJRFsF6Qfs9MoGV1vn7hux/X+wVy?=
 =?us-ascii?Q?Z6YK62jA5r0heTidEEvUX+toleLRVlF4kf5fCvz/n52hlNXPEQvbJo3ZDI0L?=
 =?us-ascii?Q?ThWmfn5K3OyiveERVq9ZwcDDXcli/cxeeGEmgkw/iPAR/kZisboquFP/uzhL?=
 =?us-ascii?Q?uyArj0C+iAAaaow8lIFNG2qgHI3nkzSQVKmU3OK1QIXYlnwQrQyIC9bcgkfZ?=
 =?us-ascii?Q?IEvw8oMWfTuJH/2K+HHK68FEgIkT9ed2riQ+xxR9PkZa3uDl4TtPrgsrMr7B?=
 =?us-ascii?Q?hjTtVhPQ/qfsYS4h3nQpWZ4lNiG6rJQYgcPqRK9LT4i2sH3x+RkG97dvxZDe?=
 =?us-ascii?Q?sWF/20roGTPToInwsJxnkRgwORA76CpnNXo1A8Wq/s4I6+vYGglboWdSQ6q+?=
 =?us-ascii?Q?lxC0qWRDfnuBbO5OKlshM+pIz3HrVug55KfqNj8Dj7Ip4Mqnaiixipo4MbaT?=
 =?us-ascii?Q?b2UhWcN5eRx39sGPRSgUhUJSrHdZ58S0s3Zig7/CKCoAiZQ6IMINGlTjPYYx?=
 =?us-ascii?Q?cqWLdtS4fZuvsC3dYBOb+0a9Li6xnbf590waYJwSjy/8fKQPLa/IY8iAvmPf?=
 =?us-ascii?Q?Q8g7H5IZWPoTHM/Ks8rwXiMkWh4nG2efemgUSAnAXYajkVJzx8d0yKv4eMhS?=
 =?us-ascii?Q?4LBx5aTRcX1yyj+YKulXss1WTwQRY8uYuna8N5hDarZ8BkSd9QhnhqKCshhJ?=
 =?us-ascii?Q?fEtv3rkK1Y9lLjw8lyDHRMVS63QpH8Yts5pY9uBggIy3j+Jw7XeEZ5P2BgP2?=
 =?us-ascii?Q?xz4wuDfN6Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: aM/68ChJswx8SemcrEhlsv5ZtTDzl8uOn3E0BPYYYjidQbcWTzpI6UBANDWTLlmmVTTRSi4qrpS57zWQ/I3jq/vMgsd5foNvBr/fyQ+kjuG9BIhhVkqOmLUf+H+U/tSqTzHbS5duZbUZXQPuAt+VDBA9QxnAmP/d1UPIH3+vYxwuY9jX2ZZ1U8qkaY2d5T4q/uOGL+xQSmxBXsIKLeZSfEpZQttTquZ4+7HNun/kn9+EOuv+zKiHFR4JG2DbmbyUhuJ0qiOl+aRlEqThY8P5O0jJnaXq4yQyv2PJSCoJrttxTHJUaV/5l/IOHqixQjvH1phjaetiCv5X8LiEKbv7GA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a05095-a937-4556-34cd-08deb66232e1
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 11:23:21.1531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwtPR3dl+mE6SQvksmZ2lShkQjMCvCT4b6P2eRwJWWirqFJ55FR8EqVwyUWQHnc55L7QXmh3UdRA05L2huRdGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6684
X-OriginatorOrg: intel.com

On Wed, May 20, 2026 at 05:18:03PM +0800, Binbin Wu wrote:
>
>
>On 5/13/2026 11:09 PM, Chao Gao wrote:
>
>> diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
>> index 7269a239bc22..7b345000d7c3 100644
>> --- a/arch/x86/virt/vmx/tdx/seamldr.c
>> +++ b/arch/x86/virt/vmx/tdx/seamldr.c
>> @@ -6,6 +6,7 @@
>>   */
>>  #define pr_fmt(fmt)	"seamldr: " fmt
>>  
>> +#include <linux/mm.h>
>
>This is not needed in this patch.

Right. linux/mm.h is only needed for vmalloc_to_pfn() in the next
patch, so I will move it there.
