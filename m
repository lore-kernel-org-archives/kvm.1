Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCC03EC2DB;
	Wed,  6 May 2026 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076327; cv=fail; b=B+nVlBhXdpDJ5kULewzp53sI55/Yx5eQsVQYNG8/JOGLlSRsgwkjfwEcbktkydxiCYh5vX/kbhD8cxUIJu/oCqIsZbGnOQwHxGO7wTNMrUHrv5sMTcLjZkHXr1P6gAg1UK+5fhdmIHoh2MdcIOLdLxF3g6V55Ontlt50yuJsNHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076327; c=relaxed/simple;
	bh=Vf3xEacFF0YCOMx8TuUQCjX0qSLkSFfICl/OSjRG+Z0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rLjLNhAQ/3CLz8/1bbSXTKwx2GhGRhWhQ3eM/YFMuJNNacGKqxDZkwvYbMQcQ+vJWYdbDDL2w0MNO6p/ScPvDysHtwJxUmk3a4L4PC91jFDyHidK8D6G7DfrCdK5+Y+2J1ygDxnvq06B4sTTezJciZMqIJhcGIs/3CFOcqjmYVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7mw3RTR; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7mw3RTR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778076326; x=1809612326;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Vf3xEacFF0YCOMx8TuUQCjX0qSLkSFfICl/OSjRG+Z0=;
  b=Z7mw3RTRuDUagR3+sbFbNX9BAQeFWFYHyh3NNrL2VuoTbqi3XiGR6NVZ
   iS1cZmJMVlK+Wp4+FbfA2E/VN1v71Mx76NN6PwIUABXYLxsttta/uS46r
   WNoWaeTWHy8FCDsQKG8XR47itq0VFwPabKnkui1kLDYzZAZm45zY703fT
   P3oSOb28DDS9YjgOth/gFwJTMnUGCyx1oBoVKu98OQvFlJiC4f60FbGRa
   rYW74clJUX3WGhKzMbNuB/TuitKpotKLbn2jeFJCUNSiMj4+Ngkz1Z2ui
   Bfx1LN2vyawBhXqhLoFpON54TP64KzY0YJSmO7okY8wogzaVB2invAkcW
   w==;
X-CSE-ConnectionGUID: z/NWQJdcRHWHOEYqRiE/vQ==
X-CSE-MsgGUID: pnT/TiL0TKOXq9Y52rUbdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="96576381"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="96576381"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 07:05:25 -0700
X-CSE-ConnectionGUID: D3NXps7HRuOswIht+SSadg==
X-CSE-MsgGUID: 0NVWfvMpRyiDXzBmvT/C2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="259579849"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 07:05:25 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 07:05:24 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 07:05:24 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.68) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 07:05:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUOaOLqbya3fs05LKKtAW7umGx8yhFo39wCxIyIfPKxYFxcuBCoYVY4f/SP8NdqnAQOWT4tdnX9yquFF9Ba/ssNiindwiBqbAEPFhTF9pierCRDMFjZUBA4l8a/fJIW61Ouiu2Whm1CFxn9w+7+QV4MKswDFI/yHToIrRyV8hwhZokmyrZpRGy1J4UflFtVn8c3dpdy2Hp1hrRnqsE7+n5TSAyT4SqKcuXlW0Gep05CfXbExuXJV0KogUcnAVeoJ+zvvb4Lx/Bfz7qHPiXR2AOy2anJVChReMVez5GhwYVfFtnus/a07iUW6mV5HWt6mIZVxHsG1t+EVff3aWXuy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldNQ5N/FO47QBpnxCwdtYwV8RQTVhOoEiNXPAUntPVY=;
 b=IdC2VlDbnFPno0QgmmG3X/3q/+o0vEqZgn/MTAEK2YWYfUBGjs3pi4iJsN4PJOZ8tu4FIBEb8BE4gZVoPiI9sZSkhudzQNDfFnAdURsdJqw12/XFzsvVO1HNG8JkkyZB/IALALjU4LWv6T2idL0NiekLA5mR8fjGkED5AL4MZU8fOf686pxZhtk/dXnIEBRIRKQ/M0Axn8VsmXm2oga8YsZjKuuHPvNWaEpwKa+GaQRn7RFZIKbD0GXTSdOdp7zOUwHf3fa/0p5rm9u9GEwVJjQjbluNYOEPbGyGo9YqxpQ6mB5gApns4dpJ1YlWgIkhNo+jjgo4eibk7+SKpJMY5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3282.namprd11.prod.outlook.com (2603:10b6:208:6a::32)
 by CH3PR11MB8094.namprd11.prod.outlook.com (2603:10b6:610:156::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:05:15 +0000
Received: from BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19]) by BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 14:05:14 +0000
Date: Wed, 6 May 2026 16:05:05 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
CC: Xin Li <xin@zytor.com>, David Woodhouse <dwmw2@infradead.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, "Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <chao.gao@intel.com>,
	<hch@infradead.org>, <sohil.mehta@intel.com>
Subject: Re: [PATCH v9 00/22] Enable FRED with KVM VMX
Message-ID: <aftJHjEQICFJlG-X@wieczorr-mobl1.localdomain>
References: <20251026201911.505204-1-xin@zytor.com>
 <7f93eb25874ddd13a1ad6e3c75785f11041c8b7f.camel@infradead.org>
 <DADE0E58-DD8A-4206-BF54-1DA87864117D@zytor.com>
 <afojoHJSlqqm2Ges@wieczorr-mobl1.localdomain>
 <f4cb5f8e-caf5-4513-9538-edaaea20de2d@citrix.com>
 <afpPt7gObsyFkPRy@wieczorr-mobl1.localdomain>
 <0cf63e0d-8983-40e8-bf0c-938affb73744@citrix.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cf63e0d-8983-40e8-bf0c-938affb73744@citrix.com>
X-ClientProxiedBy: DU6P191CA0052.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::12) To BL0PR11MB3282.namprd11.prod.outlook.com
 (2603:10b6:208:6a::32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3282:EE_|CH3PR11MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 3019a57d-7a40-4655-dabc-08deab787eb1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: G7qY5XhkUX36SWDnx6+Zcv2tm0O2+smbDnE7D9PuuRwroNMAC7L38a72aLjNzIzSq4zaUUCmNqVtwS718O/giXKLqG9KMhPK3WjmbdbAxOKPRm5YMpo1iT4MsMXoIExsRB86gr2us6HDTznMPr2WWWNZ1rzOZYiaRBbkaLCHnttCdrrAKnE/gDJD+OorsYrdFMKXYDrxVoDGGrgXcHxILxRMXK5FE8PyEQuL985iOdPje9iVVN+hci836qwVFQNW+LAUDRuNM5a4JtshNi/t/2ZYm/0Dp05hmKeS94yc7llmzpWnj+RyBS/LGHpoCLJ7Y5h3/ndBnklbKrM1rGrjXlabmqzNjIQX6KZOzEco1Tf0/Rv615sXEfIwWwcw04qwXbNuZjAg+ZT7NMnGayd8rL8Wa5b2b7Zi6PgB8OLfzCf1+ekpG4PW++2mDtJyadIIbEBlxpTwzHD8LqjH7pOqMy2vDZbruFMyUmKklntym15y8f3SyTTQlIZFiD4P5ye7DCX6lA1pjlZCSVIPqAbUZEKVUKGCJuAAv7v22KTrkcpbNCIW9EHuvIT+U76BRvMb47J4Ll8Wkz7ePLig+JVoFGiZ6ULfJjPNGOFIosBwaMxHZRomLeVU6lq7f44/6ttjKY/G/OmwGKt13+y7YC0DxwZ7LmIIbLwRpCVRa0Jth8PwC7cKN23VDHmzuYQwIn6t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3282.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?jAPSunb0eQpDglyJgZVDKOcaxNdNvSrzVr0c23qyVXaoWqqZan7R0qHSGb?=
 =?iso-8859-1?Q?x+peBXGOkJTMzXMnpMf1BaMquwmuEzW1/7s0x+L7u06McNENm2rl6pNBpZ?=
 =?iso-8859-1?Q?IRNz4YOmY+pQti2Mp0Cc5wwSnwL2ol2Knn92FiuiphAD9k57SOEAMa9p39?=
 =?iso-8859-1?Q?rzVPxFlqRgsndXWSGb4rC1Qkxq3j9aB2pPK7xnvtH/TRJARM5bf+biXILb?=
 =?iso-8859-1?Q?6f0eZZfYc1jRpXJFwOVJ1aSSzWx/39//6PpxHkw7j+8BggyL5knneR5fMN?=
 =?iso-8859-1?Q?i5i66bmlUw4KwsFJwCqzF4GLoINhOwOxzRTNvzYLg/e2AhVHCByagmTQhy?=
 =?iso-8859-1?Q?lpAyKQ/bUH6GP5U0SkVUDVo0oSOSQ3vZoFBXAIQeHDbp0FWHWD9X0ZAhWN?=
 =?iso-8859-1?Q?GeGIQCVC956SmIWP4fa4jJ4vex3ucLl9LBFQU6mEXheD/dnA7o1ZIJIWUy?=
 =?iso-8859-1?Q?R8wX6jfhzQtZrfYgk/C6XYcEIP2ryRd2y4Qb+tDkLksKmo8xACp0bcTYHs?=
 =?iso-8859-1?Q?4rg2QeoKck4Jy2fC6wvLV8T9OtxKnt2Ujkj1hig3JmSG4sRaF0nw4hogQ0?=
 =?iso-8859-1?Q?KHSJEXOutowJL94KTjXrBPi5+TY80fez0b6wR4rNwEomZpLCcAotBzYoTz?=
 =?iso-8859-1?Q?nmYoZw2eygxOp3bylz3JeEYe7hg8GL1b6/gwYJeqaFAXxh9E5dx+qxgPZK?=
 =?iso-8859-1?Q?ztld+vud7h20VZrLOjY68I7VbXoUsmd2BejAkB0q22koElOlzpb4+9k/O3?=
 =?iso-8859-1?Q?xXoUu+JKm/7/R4dmVzYUKR+2pdpPGzM0WcAP73JMt6COUgJ9kAudUQV3RX?=
 =?iso-8859-1?Q?bL7cuJKAcRj3fgJcEn7pIMVa9JPm5GKV807eCg2W4GaMjW+ionX+AfPEoC?=
 =?iso-8859-1?Q?PKsLih1uOks6b9cg0JUw2HIo4vPT5XYRX4qakX/kfHoTJcqrIww3aIw7Fq?=
 =?iso-8859-1?Q?e69NQ4XKxSdwBqv1Y7YhtG5yOrY+jGhtLyVLy463WV/08pWUSYvngVhOYF?=
 =?iso-8859-1?Q?XM66LSiiYkfRNKvpyvH8U4V9pfiLKY9vwwFKm+7s5tx7EGDt9WPa+lZlOM?=
 =?iso-8859-1?Q?dKcFJ22ESi8uDY2B0/blA1wJptNj1r8W+H0XxG+Od2eCusiCcPWiWfonet?=
 =?iso-8859-1?Q?5DOYM4Tl+67AEA0qo0OsiE4orf3wjLGNbTlgiK99m7JvH9bwRKdJWPbXcl?=
 =?iso-8859-1?Q?uN/YrGJGCD9Bwq3eZgR0Da82q0ZPFxYgSYK3E3swQVMriArJWbG6FGJ0sj?=
 =?iso-8859-1?Q?O3yPTEJZj21SCrR9bLVig4kJeleXuP2ncYWsihupVooUrcbCele+sq2G8T?=
 =?iso-8859-1?Q?IYJ8pDo7Q6X6MD7u4OZaVSKwMJQ5XlrvIqmAlNVpnc2FnOVh2otO53NBNp?=
 =?iso-8859-1?Q?ehRAVEx1lEn0vodxm97NokhwmiaBqke04rFD53RwYWYDfoFaiEEWmro7OR?=
 =?iso-8859-1?Q?RlLoBHf/IK5bIMzX6fnpLu1D2j13gCu/7WxyznUHU/ygmmU/ALs36qmvtt?=
 =?iso-8859-1?Q?CDaeJ8dqAaoULg3tOvi4jrEJLbFM98/jfMM3mjL0eSLtziX9X1HL22/Lni?=
 =?iso-8859-1?Q?mrUl6BHJ+NPdarMTq7MK/BWcwl88fzVnGXfit6u7qHip8MGTuEmY8f7l+L?=
 =?iso-8859-1?Q?c9JsQZ9ogpJJLOdJM0tbgzrB/ElNqKSMSKA9p3r2CjCCEhskwDejJxBWV3?=
 =?iso-8859-1?Q?+I23KAeF/mxeVrOTkcYmi1uuNYZW0J58p+7TPaFGSSWwGn7/r/0PO2EDJl?=
 =?iso-8859-1?Q?2IFP1o3Il4XUJ8iC6vHzZJCRJ/RvveP3AvYdw0hv4NQ269y0IrDSFIvsX3?=
 =?iso-8859-1?Q?m8ea88Z9vOiee80ssq/03ydacGl71e1l0rH5gKi2LsOdOMDYQT+C?=
X-Exchange-RoutingPolicyChecked: jODq4T68d7pYcLrkHrdlJm/QxBn7u4nMzbE7gsST7yjRu/Mjy807hiV9kwTtGLWgz3MSele9cwhXwUKJTFvmmmsktM8FkfQH0DXvKZLM8xHRUOuZ6y2zIKVOBpQCsgZzK5sXT2MKoqtu0yKyh0SJfgmdbYSxjGlrEnIPUqDeRVkMBVdy2247nLTUEUzwNMaeRmygMLzJncBzPdjgCxwEOT5nHaj0V1BXSXjJ5ImzKGVP0ZnpJ50/t1nJBRPAoA3jEpT7FJtvt2QCK0zmNkE/CY2CV00pNT9uJNgfBORxRXZoCJbILVWai2thDicab6cl7jtsF1WPssV4NPzs0CsuEw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3019a57d-7a40-4655-dabc-08deab787eb1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3282.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:05:14.6364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUGadLZ8IwtFj24yDWLnrOTGzewgdr1uZadmkL28HWJtsRKGL8NEQ820SSTxQaurHmXbxhaM+dXbzqcv0NyoWhijZCnekT5jvia4xbUZlS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8094
X-OriginatorOrg: intel.com

On 2026-05-05 at 21:27:12 +0100, Andrew Cooper wrote:
>On 05/05/2026 9:20 pm, Maciej Wieczor-Retman wrote:
>> On 2026-05-05 at 19:30:21 +0100, Andrew Cooper wrote:
>>> On 05/05/2026 7:04 pm, Maciej Wieczor-Retman wrote:
>>>
>>>> I think you'd need to add another check in vmx_inject_exception() to handle that
>>>> DB_VECTOR too. Simply changing the event type if the vector is of DB_VECTOR type
>>>> fixes that problem but then the selftest fails in other places (assert
>>>> fred_handler_called and saved rip vs expected_rip). I didn't yet have the time
>>>> to figure out what could be wrong there, maybe you would have more of an idea :)
>>> #DB is intercepted to mitigate CVE-2015-8104 (systemwide DoS).  But, to
>>> start with, check that the test passes when #DB is not intercepted. 
>>> That's the basecase for architectural behaviour.
>> I take it you mean dropping the ICEBP selftest test case and just checking INT3
>> and INT $0x20? In that case the other two tests pass after a minor change -
>> namely in guest_code() the expected_rip needs to be volatile as well. Otherwise
>> there is a RIP mismatch.
>>
>> Or did you mean I should check something else?
>
>The selftest is correct AIUI.  You should be able to prove this by
>disabling #DB interception, and observing the test to pass.

Okay, I commented out '(1u << DB_VECTOR)' from vmx_update_exception_bitmap(),
and booting with that and applying the two changes to the selftest that I
mentioned [1] it passes as you said.

>Then, there's a logic bug to fix to cause the test to pass even when #DB
>interception is active (which is necessary due to CVE-2015-8104).

I'll dig around the #DB thing, maybe I'll figure out what's wrong there.

>
>~Andrew

[1] Changes being making fred_handler() non-static and making expected_rip
volatile.

-- 
Kind regards
Maciej Wieczór-Retman
