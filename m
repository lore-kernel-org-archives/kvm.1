Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5C43A9616;
	Tue, 19 May 2026 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186050; cv=fail; b=hrNWopGONi+G+7m/fmWuRjLn4EMRj74dIEzWBpozr98zq7E6UGzixfqRNT2HJ/Y7eajes5vcjgccP1O3gPlNNQFXuXHUcze16Bh76gJzlv5IWn5yVQyqPD88AtwbboE4cD26v6Bp2j4z+f1MkkTQveZ6rn0Nfefrvf5lEwbNh1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186050; c=relaxed/simple;
	bh=0e5uRaf+xr8eOUatujQRJSWfadQjYzA83nauYFwFR3g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z1l0yfYkNFq82DvkExGhI5CK0IIfuo8xI76AkTRILRjFIpn1Eoid355flycC5Lk0iMTGKOK/DYVnImk88bgkjxUgMY2WP64p7iF9kKq7XEux3G7nWosyXI03bg5ePKoTPtDY1N3WtDgRn/B0jOb2+GuVwfgpkwSHaLX5363hUAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FelaWCLE; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FelaWCLE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779186048; x=1810722048;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=0e5uRaf+xr8eOUatujQRJSWfadQjYzA83nauYFwFR3g=;
  b=FelaWCLEY94zwVekP86s3Hequ6kDXicZo4wjebUvGihXHAk3kAX9McYy
   0KmsTzruOxr2z0JgMv5sl+q/x8P5VbFUzVgsKZp4jW/CgLcGJdrWwslwo
   uHjrI+XnoOjIyjSGawTqmPp9aC7PiKkH987Fj5+09Ra8OE7C7EdNT+Z6l
   ykU3ritQjRNxhLfrcEXofO0OzVX2dBzkn5gyqfE4fDmgGrYI4NuzNiLZK
   dLnS2UYclUAsqEwOWRzOpqHLeg2knbkEQ7Gk8bYch1KwG8gTbxr+J3qGs
   PM6GYn4HycP5VpSMTV7fyhzHhLJiRIz3V20cjWR7qS+kkYpQIQTi8YD5Y
   w==;
X-CSE-ConnectionGUID: zve2R2KpTv2W1lgtghEOpA==
X-CSE-MsgGUID: FWcRe0UwQYaoJzkDDzOosQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="83938965"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="83938965"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 03:20:47 -0700
X-CSE-ConnectionGUID: ScQ+vgKlSxOfMPmHCi+Nsg==
X-CSE-MsgGUID: CdbzBlxhRFaJZvCXloO5tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239972944"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 03:20:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 03:20:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 03:20:46 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 03:20:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZztTP0cPB9etZi+uKGgDM36zI5FErw7sVVlCNIfSDCZI9LO7FJH3k3qO5DJBuIOy1QgpGCPJP/DiXNR0KtbsOQBQZayAU8GlOOH6vCM1UXYWkqdep43ON/+OADhfRJqWsvUWDOzSpoL2iDCnUDzptI9GniPF4Xb5Mx2qOAUWL/NhAKTEGX4Ls5cyYMBjvMOvRcxq/hIfrnM3tW95kAc+TrcV5cDb8rl/t5NgavaWVC6QgleFQlP59s2hHekq+JDGAEYoUxo/NxHH2edIwuYDr7mK0+I66pDr7P0rX7/nN4WEmyYxm4Eh1/t+hhRz3tnmUjzYQLg5mScVsTgIJpcSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daRYEfO4JEYu47IGhW2nMjko3fAe356bVuH6L3ndUGo=;
 b=B6GbjYml+I1ynpPQWIQUro6HUBKKjXekOMa6vlIaKz3sKX/tKF9O5VYIRKXvmTppfdOZunSpWw8O06jxZQa0luRry1jdgJtnz1DSkmEe3YKdOtOqCxFiC+srpjiFf7CCTna0CfZgjwUkrhZkkeFzkuqt1x7NU9UmkNaRMNKics12eTG8hGxqIOmuvvZfwNsOLMwOZ3TFVCnY9qtUzhYimIpF+m94Gh+u5Naxrx0GV5uTkWjC7WIrImRSyTR7UeshQAZEwIbJAP4EXzBCPa4PE7sbjV2cFvoI0TC4/D/57UQblhrNuOHNaM6CnQJzhmZWQv4z4iMlous80Me7YKeskw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by DM3PR11MB8714.namprd11.prod.outlook.com (2603:10b6:0:b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Tue, 19 May 2026 10:20:43 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.20.9913.009; Tue, 19 May 2026
 10:20:43 +0000
Date: Tue, 19 May 2026 18:20:28 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang,
 Kai" <kai.huang@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "Shahar, Sagi" <sagis@google.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v9 13/23] x86/virt/seamldr: Abort updates after a failed
 step
Message-ID: <agw5bA4+355hQrt2@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-14-chao.gao@intel.com>
 <c0c5edb3cf4dfeee986a478aa3db886aa8d5db38.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0c5edb3cf4dfeee986a478aa3db886aa8d5db38.camel@intel.com>
X-ClientProxiedBy: TP0P295CA0044.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::6)
 To BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|DM3PR11MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aafc986-f3de-4b03-f4f8-08deb590482f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|11063799006|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: q/ydezkQKQF+hSPsNou6GKE036f+CeD04/nT5f6QExUJObqdcmqoCnHIytam5+X7SwW/+MRbJ8QLxCmnKlMJkB/ILUr71Ja7FVagt6Nkp4MCPoQxw0vHqWIg9Aiwtz6h/nkaIkntEyG+cR2cxtnhaW7b3M5DKIRIA6VDwAdoOyyjr58U9FTLuc77N78hrWYJ9CJ6UnAaarpy4Em0BmlORFaq2UUiLW8CabBeLRXlv78c2D9Rz+r94hZ0iAo4ds7J6aLlcKxZTwIiOC3dKGavnPbe0Xp09+qsMo3wso8AXnlac9jfS40VyCtg4rPoZQK86hSHQpDDtAJNHCivren1NGiDfAC2pAjHbs/ewPvEyez9ctut/m0VqsU6lqlkvsWTFsPKufId6XegCAyH/O+RFy7fRH9h9VH8Bf9X99A+eMjDjLgT6jtG+2iAOm74EEBcdbRaiXVW7Vj/L2KQ/UD5OHeQNC0jAniUtRbsjYHYP6lcGiv/3qeQesvgZfRRVbdJPnVrZCf4GHJoyVtyh4l17Wzg8SfdE2vjt/DkCveruii3c4HeV29/I4pSJz0r5l9JdFf0gD3T3AGwyGoyOGEfF+9+HYTtvK5r4DSiaumzpnDww+DtmxmarNWeMOOMd3GK3jlOK9XvggyNVrx8pGtLWb1cz1mA+wc+pd5v8CqK1tBxQgYh8YaomCX8h10yhcycjKJWLBAnBRPAQHXNe5MgYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(11063799006)(18002099003)(22082099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9iW6XYmCwtpnke6V4H5TR+aFjHfnLNrkpnAaCVsAIeNC+KRohConaXJpx6?=
 =?iso-8859-1?Q?IimZIoTs1Jo7vWBZOIBSD3vgmsKNcG2uHCXH27Tgz4fNF0ojZBfimAVpKG?=
 =?iso-8859-1?Q?YYUdu8BP+tR9XYWZRcBmRkGaZks0i8YCgcKosKqoEfPuTgyG2BKjtlKbjD?=
 =?iso-8859-1?Q?45Hs82Qie+BZLDhorNk1sO5Th7j8eFPr10Rlka+LTMJRMjmNvmy7017PD1?=
 =?iso-8859-1?Q?zg4/TvcQyZuQ7qUN0SDAdAJrYZQvMRwD5ME0OhwG1NN7ayVAjDCjDSg8Th?=
 =?iso-8859-1?Q?3AUVLjczBLsMwszoeLVmHFi9XtklV8YFhNP3UpumDVdpTOMdZ/F9rSXwbw?=
 =?iso-8859-1?Q?NZDwepOHCjwq0zeFL/iF/C3e1N0ZVT6ePWKcvJ4K1+3lgjaUlTiwS3RrYD?=
 =?iso-8859-1?Q?VoMX97gmAYYKiWUNfneGoI+YN9nSxhOZ1tvagN42ipx/g/8cg8EabuirRO?=
 =?iso-8859-1?Q?ObsNK6x2Fc/q31Oq+oX/pwPYgr2CmaHV/8afh05XmDGp8IEJUDLtRLQagD?=
 =?iso-8859-1?Q?eCPAIHLQxd9s9cKWPpQTg606SKZMHsr4gbcHpDujbbS3eVJh++PW+L+csX?=
 =?iso-8859-1?Q?kdYQ7Ew2wCrDHyTVyWZ70h7D31tCcCu4PCOMq8Ryt2SZNo4AvZrBymveOs?=
 =?iso-8859-1?Q?3DmuyhQQmAgFl9UfzU6zTZZq0sphr1HiwPeH9LvIxkd1CZlj6h5qrqsQqF?=
 =?iso-8859-1?Q?79oqb8hT0Fa4ZGBFoEiJFx0GYRR7fqOF3k408D+VJBJCNlCU4nqXvUvzMX?=
 =?iso-8859-1?Q?c/a+xRNnhWWZ/eJGJc4Z81zJdbKwWFcRRkmA9oTCYn6HdWDA/TqSD9vgOU?=
 =?iso-8859-1?Q?g7ywO4eELWMNb7PNvI1aFQCvNUKGzIhYSWGv6Yh7wOJEsJEpTFCNGel2k4?=
 =?iso-8859-1?Q?e5MDIh6vgBQxuspjbcjKcGFZWWca0LXiipClSinAGMJ46YaWlOoZ20UXR8?=
 =?iso-8859-1?Q?tOQxuY2cQPFh+NO+BCs+9rimC+d2mYj8Y1s9mjW4JK6rfZBe60p4HZi90Y?=
 =?iso-8859-1?Q?hHySHaJ6uzrNZJoeZNja4Tr/+tO/NCT4Z63DhKauQ7JOitVZT+xsEnnxHi?=
 =?iso-8859-1?Q?qQMshdZlF6aQHkMKbOFGsIAgFzj2nZtt79oJKNYWJfU655XGcGtbI1e5PV?=
 =?iso-8859-1?Q?Mqfl8GKSYyaCa2U0ZnU9z60zYRKwKWpaT/xXmRnCh9PjKxbaiZyH5pcqpG?=
 =?iso-8859-1?Q?RqC1nLfJk3ev6HcTWrKU2QRM9fsvvHie/WzIG0hS9mFhTra9kjXvUzGfhl?=
 =?iso-8859-1?Q?zgc033oXXT+2NEUGiFN7baA5+K4KPcdc29NHilkFFZ7o3vhHbRAQxvIANA?=
 =?iso-8859-1?Q?PlmcZ7jiG4+AOj5V+CUAHICJXctMmJMolCimRh5YgLXFLVK30bWcAEBIq7?=
 =?iso-8859-1?Q?/HbECi36FQbeWAlBN7DYa6z8Sch4XGh7Zqj98h/YXqcT7hrQ/Wt2zTzYjt?=
 =?iso-8859-1?Q?efhImHY5k9NdlfEaCo5Bgoj/zSkeh1SXH9lwfBUh3T7qzPMptzwGnoEOtQ?=
 =?iso-8859-1?Q?+G+7U3WCpkUPkdCkgZRTQlp4E9AHEqho139YM6uxXpsNXAc3nkCPzXYqDn?=
 =?iso-8859-1?Q?clmwtTFnvU11eZcp2IW4rQ1CaKv3Q5fzfLATumwgzA0C1X1dFsRA9eEPBX?=
 =?iso-8859-1?Q?Blc+V9H/CeMzhZNaX9LZ5c2j0nZnT5FYPKaN5YfcdxsYQD562VgfN4tjoZ?=
 =?iso-8859-1?Q?m7jjJcYYM/Xaudq6gMnigLjyEbFTVEUrNb6hwWPBCQgZNzAZ3TtBHbxlh/?=
 =?iso-8859-1?Q?pfFsaXYswW9V+Pdx+NL/Pg+ND2k7d05ySccwd9Z+aT6ZmeboGQyGNRbsdR?=
 =?iso-8859-1?Q?VyDTb3CNaQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: B3EkRKAq41/Li5BPKbfrR+ShScq6uA6Hcd5r1/XuabeYJJD9XGx+sDgCrKEis7L7G6Laiv8k61XxtGJ2xXthcD94rdEPlMwqZ5+PyQ9qzZfWc07MfcntBxeHI/8JgpyYthqmAcIYESKNtZpslkIJuA1VHyvQF8IP43Kr+ez1e047MSDGRWfKkpgOxHV5FThs5RHPHIqtQMjAYUe7wYAbOVzq7IdoJFFV+EJ8QdsC6NfbHVFY9uyErRBHHeTTiTJYnY8Vc6y02Zcjz41efAZ6t+HuoiIGdiLAo5LrHbfS/pw0lIpsY2cvbuxPwP5GWZmcL11QEVqEQqfpJxwEtwSEig==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aafc986-f3de-4b03-f4f8-08deb590482f
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:20:43.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YI6jFeJ16G8/uXv6KGU2+/dmqVoWurGt3VeIIzeIXSbDYdcEVoKqSogmR0A7mzp/EP+PGSYYSf2RJ3cjBYSycA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8714
X-OriginatorOrg: intel.com

On Tue, May 19, 2026 at 10:34:31AM +0800, Edgecombe, Rick P wrote:
>On Wed, 2026-05-13 at 08:09 -0700, Chao Gao wrote:
>> A TDX module update is a multi-step process, and any step can fail.
>> 
>> The current update flow continues to later steps after an error.
>> Continuing after a failure can leave the TDX module in an unrecoverable
>> state.
>
>I get what you are saying here, but "continuing" vs "leaving" is a tiny bit
>confusing to me. Maybe: Continuing with subsequent update steps after a failure
>can cause the TDX module to enter an unrecoverable state?

Yes. it is better.

>
>> 
>> One failure case must remain recoverable: update contention with an ongoing
>> TD build. The agreed kernel behavior for this case [1] is to fail the
>> update with -EBUSY so userspace can retry later.
>
>The link to the discussion is nice, but the explanation of just that there was
>an agreement is not saying much. But the reasoning around AVOID_COMPAT_SENSITIVE
>*is* handled in later patch. So can we say future changes will want to return
>errors to userspace for certain update failures? Then we can discuss the
>specifics when code is actual error is added?

yes. the main point is certain update failures should be recoverable so userspace
can retry.

>
>And why talk about EBUSY specifically? It is not in this patch. Stale log? 

Sure. there is no need to single out EBUSY.

>
>> 
>> Abort the update on any failure. This also makes the TD-build contention
>> case recoverable, because that failure occurs before any TDX module state
>> is changed. 
>> 
>
>Oh, maybe I didn't get what you meant above actually. The contention case is
>only recoverable because we detect it at the first step? Does "Continuing after
>a failure can leave the TDX module in an unrecoverable" really mean that any
>failure after the first step is unrecoverable?

You are right. Any failure after the initial module shutdown step is
unrecoverable.

> Or can we put it in some other
>more specific terms like that. Terms which are more specific but still not
>overly complex description of TDX module update flows?
>
>> Apply the same rule to all errors instead of special-casing
>> -EBUSY.
>
>It seems like actually it is not special cased...? The error returned is
>whatever is returned from the step.
>
>> 
>> Track per-step failures, stop the update loop once a failure is observed,
>> and do not advance the state machine to the next step.
>
>Hmm, so this is actually a bunch of generic handling for each step, that really
>only works for the first one? Is the generic handling really needed?

We could special-case the first step, but that would add step-specific
error handling to the update loop. I think the simpler rule is to abort the
update on the first observed failure, regardless of which step reports it.

how about:

A TDX module update is a multi-step process, and any step can fail.

The current update flow continues to later steps after an error.
Continuing after a failure can cause the TDX module to enter an
unrecoverable state.

But certain failures during the initial module shutdown step should
simply return an error to userspace, so the update can be retried cleanly.

To preserve that recoverability, one option would be to abort the update
only for those failures, since they occur before any TDX module state is
changed. But special-casing specific failures in specific steps would
complicate the do-while() update loop for no benefit.

Simply abort update on any failure, at any step.

Track failures for each step, stop the update loop once a failure is
observed, and do not advance the state machine to the next step.

>
>> 
>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>> Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
>> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
>> Reviewed-by: Kai Huang <kai.huang@intel.com>
>> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>> Link: https://lore.kernel.org/linux-coco/aQFmOZCdw64z14cJ@google.com/ # [1]
>> ---
>> v9:
>>   - Avoid nested if/else by deferring failure accounting to ack_state().
>>   - Reduce indentation of the main flow.
>>   - Convert the failed flag into a counter. This avoids a conditional
>>     update of the flag; the counter can simply accumulate failures.
>> ---
>>  arch/x86/virt/vmx/tdx/seamldr.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
>> index 7befe4a08f33..48fe71319fea 100644
>> --- a/arch/x86/virt/vmx/tdx/seamldr.c
>> +++ b/arch/x86/virt/vmx/tdx/seamldr.c
>> @@ -170,6 +170,7 @@ enum module_update_state {
>>  static struct update_ctrl {
>>  	enum module_update_state state;
>>  	int num_ack;
>> +	int num_failed;
>
>Was there past discussion on why it keeps a failed count? All we need to know is
>if anything failed right? So a bool is fine too?

Kiryl suggested a boolean, and I used that in earlier versions.  In v9 I
moved the failure tracking next to the ack counting in ack_state(). A
boolean still works, but it needs an extra conditional to latch the failure
state.

static void ack_state(struct update_ctrl *ctrl, int result)
{
	raw_spin_lock(&ctrl->lock);

-	ctrl->num_failed += !!ret;
+	if (!ctrl->failed)
+		ctrl->failed = !!ret;
	ctrl->num_ack++;
	if (ctrl->num_ack == num_online_cpus())
	if (ctrl->num_ack == num_online_cpus() && !ctrl->num_failed)
		__set_target_state(ctrl, ctrl->state + 1);

Using an int mainly to keep the failure and ack tracking similar
and avoid the extra if. (I put a note under --- to explain this.)

If you prefer, I can switch it back to bool.
