Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4E6355F2A;
	Fri,  5 Jun 2026 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639002; cv=fail; b=Ein8wH42dsKeROoauTbCcJuA4fsODMnFKqsdqx6F8k9d1HzsClnlptqeHQ9RBTCmw5Y0Vf8lzo+w5IPJ1UJe+dsqymWLvIbVUSzaKI3YGlR5ayP5eCnqPRbm1E1gD4HL5/O1en+uAuBU1jxM6P6qZadj9eKt4IAx0aRiob5LSl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639002; c=relaxed/simple;
	bh=p2Gp1kHy8YJVQZWTXMJP+oCuGh9vgGduFoSzr6Q248o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=smoCeNEa9QpeVxccMveRxxHt59RTu6cSAgTa07p+eQYr4jTiN8gscQxRWF7/GNVUYAE16+Ua4O4ODXaSguCS6SiaHzjkwz4VdT4jqloKuvyNkkEMKQKzzgIZvD/sVIhhJtEzCXI307Kb7nHZBvZHJqUHyHMh0lvpLi6l3UGLJ5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGAuARLM; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGAuARLM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780639000; x=1812175000;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p2Gp1kHy8YJVQZWTXMJP+oCuGh9vgGduFoSzr6Q248o=;
  b=MGAuARLMY774GiqCmE9xea/paR8KWB0rX0dj+aKs5xwDJMRDwWWolqqq
   MadGsMNc9oi95zUCeQjzjuNSLEV9/oHdjyeGVtG05iYlRin2NvRbgx5nE
   kDOR4RI1GX9bQ5ut/KoYapoUBjklQBhEaGH2vZZkOhIcxGYIau1DvMYsi
   IDx+zWdPj3PLkuDQkJAcFFtDAUrPQrF4dXwNR/KpWsHMXwpQi8xXuNX2J
   Ll40Oe1EvLnVH/2+Bte3N26SE9c7T8pqPyc+H1ShkOS8MGPiecIZgl5CX
   0Bm9obXKM+OjBC7RDoMrG6dTnhM97T2Ih00wX0hprpxAhCw1xFuAIsVOz
   A==;
X-CSE-ConnectionGUID: UiGvN5QVQuOBZMT50QaZkA==
X-CSE-MsgGUID: bEuRESD3Rym3M6/sHRnNnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92845983"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="92845983"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 22:56:39 -0700
X-CSE-ConnectionGUID: 15JH4wpdQ/a3uczzx36R8g==
X-CSE-MsgGUID: u4l40wDhRQC21kUhU5VIDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="268688613"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 22:56:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 22:56:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 22:56:38 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.15) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 22:56:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4B6bzSV+yotW535H0xxIRVIzp1VO4mz8smSJ7XU5JBmszN/Ypu8NCiDaoD+66lSrtLHUJYFDyp+c+NWZI1NLT69nhcDfgoZuWP2AyQc01/dUikNLm16XmNDEbZ0ep4h70rrW3dYZEI/APSsYBDkT/QvA4PtIG8DmIXY9C0CAsqdIruai16mD+yT8v90V8OAJ+ojywlpTmopAHGzpcDAOMwsfesgYvh2ZRNlglCEOICOVsS8dMQBxkxsNeNi2Bb7/VkwJqF5UVR7nYc5W3DbrwE/dCFexAs2n+jeS8yogLkASVtnxGCLXtTNjLLgplGTW6OSC5AEnGdfx/lgQhL3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DQfawqqxqCGtn2phCGj+/P8mrkA5zvMaoMOB2nl+MM=;
 b=f2APQtVUjDcrUWmDjwUCFYa6dKCSAUHJPL+wp/Nlkh2uxgSCH1OlpRB57Clu8sCqA1+zVFVIYEnzIu06qy1TS+YY69aySPWfVpePE6lF2EWJCI+f4sQCzFqtFMeK2a5l64Ildg/frPa2Jii7QKLCq9xQMyZHFE6K6pZE3Bm/iAgsd077GxXk98BbcdebDv6R+WE5g5D4ZMdSH86wtTSuHzkTAQKYBGXlfi+/0XukTJNfrsZSKnihfh2qpzjbvIYG7IJh10R+Thc1C/ZbpcVKz/cPRVQvbYn2UWUIIToT8CGRvoWGUc3LcwucwnmfkNUWZieXUef3Y4vkHTzMQTj8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by PH0PR11MB9751.namprd11.prod.outlook.com (2603:10b6:510:397::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 05:56:30 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 05:56:30 +0000
Date: Fri, 5 Jun 2026 13:56:18 +0800
From: Chao Gao <chao.gao@intel.com>
To: Jim Mattson <jmattson@google.com>
CC: Sean Christopherson <seanjc@google.com>, Reinette Chatre
	<reinette.chatre@intel.com>, <isaku.yamahata@intel.com>,
	<pbonzini@redhat.com>, <erdemaktas@google.com>, <vkuznets@redhat.com>,
	<vannapurve@google.com>, <mlevitsk@redhat.com>, <xiaoyao.li@intel.com>,
	<rick.p.edgecombe@intel.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chenyi.qiang@intel.com>, Yosry Ahmed
	<yosry@kernel.org>
Subject: Re: VMX Preemption Timer appears to be buggy on SKX, CLX, and ICX
Message-ID: <aiJlAhqnU0lwOAcG@intel.com>
References: <2fccf35715b5ba8aec5e5708d86ad7015b8d74e6.1718214999.git.reinette.chatre@intel.com>
 <Zn9X0yFxZi_Mrlnt@google.com>
 <agPUfzbMzTU1ebii@intel.com>
 <agY6JuEJRhwpwlRL@google.com>
 <aga+jCVUW0d4GufQ@intel.com>
 <CALMp9eSqqsEzd5MSeO46EdC8aOwhyhU7e2bOW2LSdnDQGXEVpw@mail.gmail.com>
 <aiHY8cWZYZNb-DED@google.com>
 <CALMp9eQ17UaAje1DQ7v24U7iKujvnOknY4itQjSqOaKSn_FqBw@mail.gmail.com>
 <aiI6xge3Ev3PCpUV@intel.com>
 <CALMp9eTXLcDNAjjcsuo_nqjowk33yA58fjYZbz_Lqytn07RM-g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALMp9eTXLcDNAjjcsuo_nqjowk33yA58fjYZbz_Lqytn07RM-g@mail.gmail.com>
X-ClientProxiedBy: KL1PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::31) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|PH0PR11MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c0636c-a82f-469c-bba2-08dec2c730be
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|6133799003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8Bzk3ghK35US1BVr9FifIoaY1N0aH9IVtNxxmNO6lnvkApHAoKfRNVGNUyJIiB2BeYWKmi08ir7ICVHPfUs54+VaAQtH+MfxkdDYlaSTK2oeojeKcwv/qHklQoIG//8Nozb3MF4OgRIc/E24OEI3Nu0jpIQnMQioBnFtRT1fuqMMi2JaHsTmlrzUnN05CYSeNWpkcQX9gVr0+pFnlSVxXOxl8Ryem9JWPY/jCWdES8mwl1+6qoaxzv5uoue4y0sVlyHyTeU+6CiG2PfUZYy7tK5XHlSBgwp+5mbd0cLtTMqmaOWskuLg9Z0SWIFDMGXF27ZtTmk8+B5Hx3stuELDxLK1HOrr3jOlUxJn2Sk4mb3ZSg7MmvuVY9JZgOmUjAwuMyv9k06xGRZAsQ1d9bEPYmboPTAlicNUSne8m8SM1naladdJJhplj5UIySrXsd5/J3SBlhtdLTCo3342Hfx7vvcwp5LWiz/GDmVghkdcyLAX95tIiUkk+wmeeHD8XpQpEcwm3wMBmdrXnBiw4sbxCQkBNrQ0B2qZ4qr467ZidMtaxEZP9M1NsuSXgG6CMokI83/DDjwCqHJGBFfaWEzDGwEWmlMj11WY+d0RG5zp8h89+AwprJOt1vRNTjz8ljajfpzOo9NdNfWR/yyU/E8NzIT+77YXhPgnLgFPAQ5DLb9xv1fx14JPnlsa4kYUjfwF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HXPsXCToHNkqbEMsw94HYmeDKC1fxFzg/E7WZnpIp/lbIgoPQ8jgae4bQvWu?=
 =?us-ascii?Q?izdZAdwjadWxqtIGhuFgv1BHyeBRW+fBZRvd7e70zw9OSAKXB2g30qv4SKbW?=
 =?us-ascii?Q?vH7MR9pFjRhe0Fn+1k0e9C7+F3UjCsoxsthgMJdVuAx5oYAW37o2Af5eetCv?=
 =?us-ascii?Q?Rlnneq4oZ135jNYSi8WkC/AcDG4fwey+z9Lzwykj7HOby0pqT8abrGOM/MW8?=
 =?us-ascii?Q?EYuq31f+0J8f49PEbLUieT8QFm+HmogVrrWzY4OUC2ic2o1G5fOPx3GwLqKu?=
 =?us-ascii?Q?SdkFpcq5Q3troBMaHafxL543BS4dMI7p7loZhMDaObf4efjj+jlnSu9O92Y1?=
 =?us-ascii?Q?6mLOb8xT3IOejupFI5Y2Wu8cL449FvaQP1mNzAAU9hAK2P5Rj+0ByZ6Lzt7d?=
 =?us-ascii?Q?IRkUMn0Uxx/lwnBxA/7Cx9DTEi6XTonm427e8W3nJkyBHk0cUXc+TCijUcUO?=
 =?us-ascii?Q?Fo+2wWsnyQJs6xWEgCL7RFR9mFWjNKBTRDkOjyQoUrIAIGKtdWe3Ish/Be30?=
 =?us-ascii?Q?33SG7Cv7pWI75NLlBxyQOin2z7y9tyJ+UP01r/0yTYhQ2jYMewH20tMwj+O5?=
 =?us-ascii?Q?T7ZLQ0nMDJvV8EDkHMLnVwnNi0McCnIQciFPF9hYiCJtty3VKs0sXMKP6c+H?=
 =?us-ascii?Q?foMkOWkfUt7WOcJlZ1loMW6ijeC3hFCB0/KkpGiEUkhNXm9ATncYrnF0vnNL?=
 =?us-ascii?Q?Ea46nHKEjJ5PMDx+7LzmXmFIG/PeMt8JKmNR8NHQxlKsX59K9nN5tyx2wswu?=
 =?us-ascii?Q?1M6ohNWXje6lZecWMYwX8es6wP0qFHiPawXtdAY4VfBvaH+qFouPRY2XfBPx?=
 =?us-ascii?Q?YK1FQJh5GZu4gJ360eV1vVWcqCQIWXC9RldIWiK1PnGRJOLeaPJohb8KthEX?=
 =?us-ascii?Q?zL4EpcvDDAQ21OPYsEKtNKcNZ0DU1boGliBANwnSl7uKGGHRjnrjRJ4Q3rM1?=
 =?us-ascii?Q?v767OnTW9x3Wm75bBLEv+s37Xn5c+YI6h+ZTFh0cTEiO/HbkXNN04AMBhgk2?=
 =?us-ascii?Q?ntSfOhYxO6tL+W+WoDDNNKGoppb59ZIpRQHORIz7eKt08ZxsplAohuH2wSAX?=
 =?us-ascii?Q?JE0/UJRy8m9MSDLzCUicMrdvWa2IfgCvnInCc7nMui3JlUS4kKzLaUU9VV+6?=
 =?us-ascii?Q?kS9sy/+y/57Etk5qOsZqCuQiirAgR9VNYrxravALr0BqrEZWFqgPaWF9KwMI?=
 =?us-ascii?Q?VEelGP47aYDo4F8/PxIg0bR4KHoAPA76a3BLd0iBVq5sgOQWpeFZSfkMb63f?=
 =?us-ascii?Q?R4U7x2JjT5ntaMd87gtw2YtW1imjJ6vmfvJINMLQDNUZEf2tF/fmKzbRrIqZ?=
 =?us-ascii?Q?s/Xd2LITh+fdkNy4+kLrxHJgHadboZKVIrfjGg/0mL0gCqUQns2GdEG3bHlI?=
 =?us-ascii?Q?EAoKMINvfQvnmUI5iU2j60epWkPxRkR/gyOZ+rFgacMTpJsWfV4qITT90jB1?=
 =?us-ascii?Q?6ocwWi3CtE0MCrG8lvV30L+YD+DQXIO5sgxm9P/GqRY0I36gpJ7NYpGcgPXw?=
 =?us-ascii?Q?KjiGLELxjeBF/2wiilvOUt9uk+Sq96qdXfEifVH+vdtTpgIet0Q/6RV2vloP?=
 =?us-ascii?Q?8WOsjz/BDLaULP3abLuWtDmwZsWT9Nc2kwT4yP29BeCFVpYsBUSwNkMgPRjA?=
 =?us-ascii?Q?XCBktWQZc1Ys/3CKsAQLAQutFjyZ3aujgU1H63fEh6jSYuyk5fOefOo73mpM?=
 =?us-ascii?Q?RQz6kVXpkDIvXDy6SqJ4EGZt5vgZs2DykIkuE0jFsmBuMa4Djwydoo9vMlSq?=
 =?us-ascii?Q?NqbQ55hGcg=3D=3D?=
X-Exchange-RoutingPolicyChecked: SlqQGZWYBG2MSjhV8Fp8DZxe1RQa/jLnIkYL6Ix1M0ctjLI9SaUQYW1q3jUfsWjdKLAyWr7JMONb/meErrjia0hkVr293XYFEiFKU+tzvdP+vQx7tvqmB2kkVt8RiNVuCX4VbjBd7kbgTwXWVq8/OGMW3frH4EZ3/YqLL7DMQXNuNTJsS0fEwdAHhfEr2WdGTVinWzakn6wvYWdpJ4DAhzt0tIJ3tdTS8wWKt4AGZROqeNK0qOKtNY/OL0WbN35XQDOxH/O2TZyWFeCD3mGpQrlEgREhjwQu8wAHm63wghMaS39BQvBYffn8VADfxdQDHdp36WJvtBTbbZALrQsp+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c0636c-a82f-469c-bba2-08dec2c730be
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 05:56:30.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcSqCV+REyR4g4POKZP2/F+77nrzAMLygJlWOG4VvuhDjjXj5sWuvsnukUGYDpcseJe17yrvwsHJYWBr9zYZeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9751
X-OriginatorOrg: intel.com

On Thu, Jun 04, 2026 at 10:34:40PM -0700, Jim Mattson wrote:
>> >
>> >I think vmx_set_hv_timer() should return -EINVAL for values impacted
>> >by this erratum. However, the only documented issue is for EMR, and we
>> >have not observed the problem on EMR. That's unsettling.
>>
>> Could you clarify what tests you ran?
>
>Just tools/testing/selftests/kvm/x86/apic_bus_clock_test.
>
>It fails on SKX, CLX, and ICX. It passes on SPR,  EMR, and GMR.

Thanks. In that case, that test likely does not trigger the issue.

>> >2) Is there any compelling reason not to simplify the limit to 2^25?
>>
>> We can use 2^25 as a conservative bound, but it is much lower than necessary.
>> The current bound comes from theoretical analysis and was validated on multiple
>> platforms.
>
>Yes, but how often do guests program their local APIC timer to fire
>more than 2^(25 + IA32_VMX_MISC[4:0]) cycles in the future?

I had interpreted your earlier question as referring to the erratum write-up
itself (i.e., why Intel did not publish 2^25 directly as the limit).

If we are talking about the VMM implementation, this should indeed be rare. I
do not see a strong reason KVM could not use 2^25 as a conservative limit.

>
>> >
>> >3) Is it just coincidence that 25 + IA32_VMX_MISC[4:0] (on EMR) == 32,
>> >or should the limit be calculated as 32 - IA32_VMX_MISC[4:0]?
>>
>> My understanding is that hardware scales the preemption-timer value and
>> converts it to a 32-bit core crystal clock counter, rather than directly
>> using a 32-bit TSC delta. IA32_VMX_MISC[4:0] likely participates in that
>> calculation.
>
>That doesn't definitively answer my question. Let me try to rephrase it.
>
>With respect to EMR, you wrote previously, "A mitigation for this
>erratum is for software to program the VMX preemption timer for values
>below 2^25 * CPUID.15H:EBX[31:0] / CPUID.15H:EAX[31:0]."
>
>My question is whether the exponent, 25, is a fixed value for all
>CPUs, regardless of their IA32_VMX_MISC[4:0]. It sounds like you are
>saying that the exponent may depend on IA32_VMX_MISC[4:0].

Let me double-check this with the internal team and get back to you.
