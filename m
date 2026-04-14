Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2819C291864;
	Tue, 14 Apr 2026 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162370; cv=fail; b=s7idRjfdh3Ccsu1Lvs9qKI9g8VY1QaEI1LFSj+6CQPjfdQmJwYwi3+aLQo9q5ro1zI8sU+vejHLp9mVN6kH5ZLkc4itJvJkrHJX7XJl4nQrIEWkNXeVZphtkc74C8zjtzueOPxnaG83GA4emCqvOAQ+zM15ZNaiNAPfsJV/sOao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162370; c=relaxed/simple;
	bh=iYpO8QnsIKiIA3/ROEcGAlmq9bAjMbG8P5RGGgUEFMI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T0nPoZRjugeK5SzlJE2RAb8sCi5HTVdUmxX+qRy+RagJ8Ry9zzgpPvb2aY8OdR8IHUmX+zbGe9VJEOGYS9WvGK683Dw/ezOvZf1fcflq5r4lQUmNO1c4LVoXS9//okZTUdFHroaIGpz8E5ExagD45GKMMwyol7tRm0Z5jkHIzhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XRTmb+/7; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XRTmb+/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776162367; x=1807698367;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iYpO8QnsIKiIA3/ROEcGAlmq9bAjMbG8P5RGGgUEFMI=;
  b=XRTmb+/7nG4XBo6MF3Y7FMx/gFi2qDIPmLd1268V8vk9biELBIuoUE2C
   t9dbOFMByiubStpFbCE90d7Zh3YUMKt9d13dZhkWg1qtt3Vav/X25eusP
   HlrKYYQEsJOaynauxRUuvWd2VVaGKc2uWKLccs8G6poyFRw48TdBSrmD+
   2IYOALFl8BpmP1r9nKPqOBo5H/Gusf4+ckKhEvtN1mrJnpA3E4MFgUI9k
   vMfB9V1j6YhYJM/ojE9RB/pmmSP3bWdua1JkpRAnCj0uSxOkWovECgeIV
   evOekO9lzV8hMeIU9WomvOtTjA7IpOjOwrHVwHWG5lDwKJGc8Egoui8q6
   A==;
X-CSE-ConnectionGUID: 6ok+qFE5RHe2YK3STb5Npg==
X-CSE-MsgGUID: KPn5A+AmTCGx7P0YLor9RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="77020512"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77020512"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 03:26:04 -0700
X-CSE-ConnectionGUID: 5a23xf+aSriQkwBTKgv+6A==
X-CSE-MsgGUID: WA7ibH9hSzOFQtJkCnsEwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234452926"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 03:26:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 03:26:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 03:26:02 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.29)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 03:26:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9CgJ1i8VzqFEyPY180+ASzcNio/2cLhhB7kf4ESDKi+K21sX6xXyxBBlZ0xu6KN/rh8TemRRRGLQfOmbk0EQrta/CBf3gGlvSRRZzwuzB6OIrfcirN9OkOIcG/kPq95g5yXBq6k3IgXp91A8FcxLfsYbvUqlE6R7ZIawlt4XspCARd0jGEYPKrqYE6G2YqOhQGSRcQaeLUwKMyfRt56gdtO1yOenOS8XovQSuBnYtwFH9VqoWNc+Pw2lKCda6nZbRr+Nv0vsKLvMGMk69wENMQ9ZrEAsSTYXQU1NKxdmz6jbkzfoir08TZJhgBTNNUkJzJ/lmkuTFbt9gICoizoIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ac2AULBNv+0C+YYfNSLAeLHaYCs3RjKKczTw+/IS4I=;
 b=ETSbmsQPm/S0ab3YTbk7TDTxNd0SiQ2LxDLdY5a9xttntU26EUEv837aJIV5ifH821toe66amPo89ACmD1C6dE6DpPqOSrpDV1Eo6fTz+3ohOe8GEQPnHcWOpv3jhtcfihQMpjQRMMnBxnt+PNeikdBAbPI9t3+WvecJlAIrCq4xsGxgDPWHOVjr4q6tsXgx7Hgm8xRIqB6FmLM9JEWsEQDmT/bdmobr6Vvo8z8o86pYyEn0oxmgoOPMvG3RxVAZbEWAv94v4/2q7ufn1WA7/8nBA4bUuecG1aWTDTzxKObSNr7QA+7mbhTXnIIm2GMX81o6r0EC8pwJsbjZEn9xtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 10:25:24 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 10:25:24 +0000
Date: Tue, 14 Apr 2026 18:25:12 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang,
 Kai" <kai.huang@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 22/22] x86/virt/seamldr: Log TDX module update failures
Message-ID: <ad4WCJdJ2MrGvkWX@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-23-chao.gao@intel.com>
 <e4cdab7d83bfc1c7fe3b5759a987c71b922585b7.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e4cdab7d83bfc1c7fe3b5759a987c71b922585b7.camel@intel.com>
X-ClientProxiedBy: TPYP295CA0052.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::18) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CO1PR11MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: d82e1906-af16-4156-91fb-08de9a1023a4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YYNYxihxwTkTfhGEBvT4sU4ZszX4L30jvEHCtegbmZj7BOKmq1as1waInUbiVHuNwAWSICE0Rc87h9s0oE3NnwcLGdNm1VGcFDsJmNt7eCbnFQ0rWr8wVCJIjOvSBJoouksH1FC0AfW8ROqWl+V3L5a+zABMl+l9lLjrbMPHVfIisqE1CvMy3xTiv4yIGQ3s2C0sOzD+Kof1OihXxGOuaNjE+LAm/6+8hKnAqQdseNpE9TMkRqBSBTJnrpqgNHvPEs2TCoYS9h+KQOvYm8NDdH5V8KUcfhRQVgf+hmeDg67nLfDdEgnZLZtzkBd4LLzItMZRR5DJ6ht5dPuftUdJMO449RuZsgPiodyyiLZkVtgnUs9dVyCYE9cn2lqfdtL/jUG5ST3xKEidPML7P/G9GQZK6B6GLCNK2gNnbysKrnaZuHpuLLZvJuJQDhk5KBHZC4/iv9Y8tBBuuVRI25UicjVmjU3Rr+EodCciURD9ont621bezVE3CMN37pLlkEfOnfOxilsK3obUc+0Z+XnhJjhwOIwXjoLIUcUK97NdzKvG8qPzw+wmviRIgD+mKJwKoPe38RPFU7wH8yOZboh1YZ0YAIzuYBuGWss8oTYzlVGKAc/80Tg2Y1mSULwYVNFSwTzLOOjPnRcRKEJxNj0rFOWG8Tt0kUZASgxv5XMFwvTBeO3wG3W2kQ7tSoN7xKC5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?drTsJqRDCgT2KsQm8GoiXuMfdk8kJunbOuWvRAziUp6vVrFP559Or8CNsldK?=
 =?us-ascii?Q?5G8EQJobjJq0dMW0dg//IWDwMMmi8ztrQqy87VdSd9xu51KeTaeEWdUEgDVI?=
 =?us-ascii?Q?5t9bmBraX9PC63RtEfhXAVeiJx6JmkGNBhazSmzfjBKrfLhxRCQUzm2N0y4Y?=
 =?us-ascii?Q?MOXpcs+L/7AdxjiOviAiet5dBIaJ+N5P/P5PdklDA0gEIjNltVdf35mLFQu6?=
 =?us-ascii?Q?SBNX1bJNdlHPaXvaRxOPI32JwD9SzrwDyjenIkxn3lsx5r8SGencytoSGzRk?=
 =?us-ascii?Q?SQ404BxJ4SGydWhaMDBZlqgSxtTviTQl1cjENXzQqpPJ+B5eU/749nhJd8Tr?=
 =?us-ascii?Q?LO+iqVL0H3OW4mdbW69YYzVuep1I+03rwjgb/E8ROfmGRhaiEjFR2+xRma5P?=
 =?us-ascii?Q?PPpsL/Q5AH4K4v5Pnc3ZvO1Ko3wJZk1vhI9hZ9XITAYHTkx31Ptf4aF3hr9Y?=
 =?us-ascii?Q?Zb/hybAKHKhXw2pMVevX3SbhajBKCTrE5MfjnGzd+CgJqCHdozIRV9lYliS6?=
 =?us-ascii?Q?k2DiU0xF6hUom5F2S6V3mR/iMFsUJhCwLBaK2vlRpqeH0J1I2C4o8+SbOe1P?=
 =?us-ascii?Q?UFSgn+vCYhUyC9QWcOqfEuJPI8N2zUOWbxb4Z/h2Mu/jy76No9b5hamPMvBY?=
 =?us-ascii?Q?9iaUdgyT7efCep090MjDaZSZfVhQDCs/k1haZFWRpMHtRony9KAJ35rFE9SP?=
 =?us-ascii?Q?kqPQRPzGY3Cfs6tHnwu4x/rY5TcnLxvXjkdnC0+gvPVp2Oc5slBeh2Hhlrwi?=
 =?us-ascii?Q?Sf8n+IYL2NREHH1jTKnWdRRL9Gv3WQP/Ayt564JrI4P5QiD2RMgH/pF7lfor?=
 =?us-ascii?Q?TPwyHstwaVQhu2o29fEDGqogsQAh7A9DEfdO5mmHb5YL87GiwFhiB6DRrUke?=
 =?us-ascii?Q?MXpXPsxnVI0q1FnQQ9cpZNE4F+BTO0czRyagylwHJITvlmTNG9Jp54bqXqBf?=
 =?us-ascii?Q?15mwyrmioDF4nkiCruY+kWl+33Tz0OcaXIR8OXcIWGal/9yX8gAa8KFsnr0u?=
 =?us-ascii?Q?zPv6MNNjRcF3y0LgjfqCJxlUCYaJ6T2LTpUTtoNutLeZJ01G5KOnLiMPyj3D?=
 =?us-ascii?Q?bB74RSGyOOA7Xi2sRAIgL9msMbVt8DneI9qt7l/X/GyUhUpG6zFK6xx6SAlG?=
 =?us-ascii?Q?MODyPJmltm4VuOSAX/ttmNjAfhVutPP0HoftqqZX5yOckaTTl/mQYhLLgyll?=
 =?us-ascii?Q?R2Df6xilBeJ/RWkElVDSk28pJDSvRIWYG9CCbtSZHCkZE0mpsM6/q/o4owhC?=
 =?us-ascii?Q?QOJlAw9bwC/MOEB1z7a0x+F/nhmt+svssxgdszu/X0JKG770FDBomtuwBVsu?=
 =?us-ascii?Q?/hOQ+EWCQEflnetqHyMaFpkl9jD8D2qqJOFi3aaLtqzh4dRD8ZmZXLEk5mpj?=
 =?us-ascii?Q?HKMWwEpy5EArnjnr2LzFmaYorGXzfspRb19elCfvIvbk/NLwubGQBWArB/Jo?=
 =?us-ascii?Q?wmcuxGsm9fP3EZ8zxKCvai+qmcI2chafOGhE/bPo2GJmw6LWBEInkvNt2Nkc?=
 =?us-ascii?Q?vGex/gKdvgVjGj1qRgjs/925B+FVqEp0E1PyHQlQk6brVL11H/0vdEhZkzLE?=
 =?us-ascii?Q?zsVTo8MNYoikJv8kIt1UzeJlTdoWjF7jjYdWHqj0j79rditqeJvvyaXSEruk?=
 =?us-ascii?Q?Vm2z4W6xYHGe4pqJ/lT4kkPbaSKU1fp8NeY/MduSTctU02du8VVFrcLdIs3t?=
 =?us-ascii?Q?JARpjPFpBzerStAqQp/ojxXhE0KGxPopeSkdFZqBAfOzymlsO+5UJXPwqWZ5?=
 =?us-ascii?Q?3dLIngmimA=3D=3D?=
X-Exchange-RoutingPolicyChecked: Loa8pw75G+qP/ooOyjsv/FFu/Cx/bKGq99iR23ObH2/7kQbGlJxnIvoihgWdy4ko2xsTKjgG8n6YM/ncqDl0PUGj5pTJeyK8Qbhy4j+jfyjf7T9J/X4AYWNlMxC9LXFoyBh3/sTmYGzZyHTusqMasoqO/cJyH+ocKU7sdbgY4F+mjWjWDlM03Ma5wfEjS2WKJxwjSThXvAWDFksmfXaB+s4O/prFTGjpLiPnrbXycXnFh6nDFgtj4oBGgRuTNB0YtFcLZQ6ehSzId9J/y7lFEC76fHSNfKpYGVVGXOVl3WfBjcBlogDDZx4Er1bzh4igKCgaAht1PmH4bOXlHLFYZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d82e1906-af16-4156-91fb-08de9a1023a4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 10:25:24.3384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uoFd5+kX1OM03VYppP7RgcEBiXZfEcNzbjUTMVJcaZa+AfKuKjis3CzTJ4nUHLhpu7KDMb64JLrovLXKcNaSow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-OriginatorOrg: intel.com

On Tue, Apr 14, 2026 at 04:04:05AM +0800, Edgecombe, Rick P wrote:
>On Tue, 2026-03-31 at 05:41 -0700, Chao Gao wrote:
>> Currently, there is no way to restore a TDX module from shutdown state to
>> running state. This means if errors occur after a successful module
>> shutdown, they are unrecoverable since the old module is gone but the new
>> module isn't installed. All subsequent SEAMCALLs to the TDX module will
>> fail, so TDs will be killed due to SEAMCALL failures.
>> 
>> Log a message to clarify that SEAMCALL errors are expected in this
>> scenario. This ensures that after update failures, the first message in
>> dmesg explains the situation rather than showing confusing call traces from
>> various code paths.
>
>Why is this patch at the end? Is it not valid initial behavior?

It's not strictly required for the update to function. It just improves
debuggability by explaining expected SEAMCALL errors after a failure.

I placed it last so maintainers can easily drop it if they consider it
non-essential, similar to the guidance in *.

*: https://lore.kernel.org/kvm/63082cd1-15ab-4aaf-83ad-f72d94b9bb8e@intel.com/
