Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F833D6C7;
	Tue, 24 Mar 2026 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392712; cv=fail; b=HKF/vDT92CG8GBK23FYA+Syr33Cd9UQjXC0EHQpk4iV+6yRZuXmzzlmp5SeKAivAyDuPCPqPClN7ivmQipNCTCnqn+NmPehtEqWzbuoHsN07gIAkRfff3ucC8NbqWmBA3c/N6HvgTO7RDZXAUryhrpFg3f0a3vDuaXFZq65j1/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392712; c=relaxed/simple;
	bh=e1IEoJ+vxgoRr1fuaOyM5WmqHM0MjZ6Wo0rVfs4+TIY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sb0akZsQMozEC8HfFmiKoUt/Io07wB0VTJFQ9Dd+MMWbY6IpC6TI2+XqpiFNCYSUk8wBxS4roybxrrcdd0T4ndb/21mh92FWX3/cmNaVzuGfTj8wOhQSzV4MzUA3jStnt9WZFig9BG1kBKhmmcGskAnSzEiziEwB0dSIWMinCes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ehnODIDa; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ehnODIDa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774392712; x=1805928712;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e1IEoJ+vxgoRr1fuaOyM5WmqHM0MjZ6Wo0rVfs4+TIY=;
  b=ehnODIDaNFuqHc85bKabEkV663L8Z5rWg22GT7E++1gG51t+Pqn9UH8g
   eY8JlCjhcUUC8NFhwes2MctmNppx9SGVSEYyRZ2URXiqfbzHskg6H0AXF
   poObd8bcX9sLZ3IzfXPd/5x9uKnfDdDk2stzzLUsMFm+kz/HDxdg63Ab5
   enTMEeAyF9n8Uo/UOprLGPWJrk+WISNSGfs/tHeb9b6gMzBy89fH3nir8
   LkbmtTpnoUVlfJPJeKnNwEcgD8ePfA3mbLMSg9AoF/zHQrdqrU6Yc3cDZ
   MiE7eBp2MWbRMJ/yC7fZSHJ1fzoV000sRlxO5jFPXKasBmlzJJKQ16pK9
   g==;
X-CSE-ConnectionGUID: 1b+F8SjWTrKl/rgwVvUtxA==
X-CSE-MsgGUID: RcPEhs1uQIK16wSlhq8auw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86500071"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="86500071"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 15:51:51 -0700
X-CSE-ConnectionGUID: YzvceSE/RrCL/NV8Hu932g==
X-CSE-MsgGUID: 6F2l9FkfRqizdH6IPIsFDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="224759189"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 15:51:50 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 15:51:49 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 15:51:49 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 15:51:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2uqpiB4lTFjiezPe3VzE0h6TqZiMZxLXN7efOiD/qOCa6HaLQnLDQPcTK2GcKjZyEgHwJzlzLTvluqVG20o5feIvmXL+5aZmXosY2x7UkMFSF9PqzxSLcxP+vNZOcCg6MyMOvkDSsdAspcnJlLMk1t814bpF4DjM2XiVv/NU1VNHvrThV4OtW12fOBKPSStcWSHclkAGfEsyV3jz0fz1rf9cdKt6zHwn4aAzjRyJUgk7i49+HzX1VYzgbELlha9FR426VhHZwv4pW2A656Ttd3pXcn6B9FfXOfm7LlcMwPDq8XSk2UBEsSiVZye8NNUgSUM68PUga/tlHuFojTESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdVJ71Y8a+DsPhuJMRkrZE4cKtMVRe+uSWT1tfaTuDQ=;
 b=kiSfBM8UR/4QmMhWhOUfUnNy6Z8pPMhCgXk9EWmo9AYrEMA2hsT1i+h/C66fO6dPr13qDOu5VlvOjkRh4a6gVLI2YoIlguHkGHKJcCrXy4SknzsxsBy7yLk8VwyjvjBhvMfJCUbuQ2lLii8QSQemQLB+vrnnpwD3MJXNkpc5+ETKddhQETZe0RLI6nOqCAjWfXLc7uAyLzIeYeY42/6IMV43+mUkVYgmkBaSM1/G2dQCeh99XT2K3gMTMkdKZgHiCeqRkzkyE7F4h/LAkOr/mpbgy3AoA+i1xIUW1cWqOSRg8s8RmprzqN7ZzG3ItuwiZBlgUtnrwjRJ/nZH2RV0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 22:51:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 22:51:43 +0000
Message-ID: <57c72d52-e62a-44f6-a08a-891a354058e5@intel.com>
Date: Tue, 24 Mar 2026 15:51:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] fs/resctrl: Add kernel mode (kmode) data
 structures and arch hook
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <skhan@linuxfoundation.org>, <x86@kernel.org>, <hpa@zytor.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<akpm@linux-foundation.org>, <pmladek@suse.com>, <rdunlap@infradead.org>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <safinaskar@gmail.com>,
	<fvdl@google.com>, <seanjc@google.com>, <pawan.kumar.gupta@linux.intel.com>,
	<xin@zytor.com>, <tiala@microsoft.com>, <Neeraj.Upadhyay@amd.com>,
	<chang.seok.bae@intel.com>, <thomas.lendacky@amd.com>,
	<elena.reshetova@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <eranian@google.com>, <peternewman@google.com>
References: <cover.1773347820.git.babu.moger@amd.com>
 <c3381fbbce357b00895252572907645a92cd9718.1773347820.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c3381fbbce357b00895252572907645a92cd9718.1773347820.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:303:b9::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: b24abeca-9322-4d8a-b32f-08de89f7eb6a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aaOBeNDJvQDe4DrJozt3IHdoF0f92rnbnZ1p7hlxu4rquY+OSOIn/B+KRRhAKsSSG6a3vovl61gOOX//Nlp2iAN0zZ7dqXOY23D6fcx24ltdyk+/2Ofwgs51Ww8PqM1Koe0B9u4hwp17jhAbNB7kDoxjGPE+ilDqUNbogVortuGTsnX4UJaO+j7DpaZi49tJnNChkOWECdHREUs8TRzQZNKKQ8sqZoAgCo+KKmUvRKPTQWpSdymxITjm9T06/Dc2p0UnAi3fqbMmu1iXJNiJ5JU0V7iYzSXOxKjWRGK4MmmSXdDxPP5qx/BTzcZ7c3+u4n8ENm6KSVKM0xsK8q335phaes/PbcpOTYJXTHUhrl2CAgw7jvF46m4msT3vgPtoNN2LCobKBt5s1FQIdxJttKrDrZrBaRwQgUxKS+/YX8ZPHpGrCaoMeT5aD1dBSZ/E6bGXBw8+Ic3XZynKlbV5VOAILv/pnKl+QqLPFN2ejLS7t20JgDA55OEnO8Ndaruzg4HY9B7q9AKKkYeA/JDeM4dwRvd8rjQpBD8i5ud4P7wek17e16eBVJ9I1NPg6rPscd9Bt6Q7QpTR6Nv4LyVw4eJgxuwin3XvNHEbRiKYBj6HMA0AipiGCc6Bg07HJihA2mg5bP/O+iVZIUCIsAHiiXDBcIIEa/BMKZ54XLZw70+dmEpsxMX+4sEmoF5+lX9exAszRjpHttW2obOySTMWLRahq/7UIbYci7D0aauWjag=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emZhNWNrSnc3ZzRIa1M0ajBEU1dFNi9DcVgvMTRoK2hvUG5RMStnR1pmUFdD?=
 =?utf-8?B?bkRsT09TS3FuTzFaVm9wWTlSMU04eFJwNHZFL1dBMTF0TTlkb0N1RzJ6dklo?=
 =?utf-8?B?elFuY2pTUCtuTUJBajYrTm9BYnFERjhUN3RheDRkQWx5cW85dXQ3TmRiMUhS?=
 =?utf-8?B?SkZNbkpUZnQ2S0pBYWc0WUxzaEV4YXRqZ1ptNVlxUlhJUkVYZWdiT3kzeW9J?=
 =?utf-8?B?K0JUMzM5VktXZmZSdDBOK2ltbEw1OGlmM3RaSDBsRTZ3TXRJSWdrZGVKNlBo?=
 =?utf-8?B?aWoxd25EeWtIdk9IZnBqU2MwNUlGUlJlU29RUUdLYlZDZFA1bDZ6K1lpelJt?=
 =?utf-8?B?aEhmcXNjY295Q05iVkRkZzRKd0ZIOHZrWlc0VnZodm1xV2txZVRuZUpnQmI0?=
 =?utf-8?B?NEtEaWt5ekNJSVlVZUQvb3BVT1hhcmRjbUd0V1Y3VDBqRHN6N2pSU1NXY0JG?=
 =?utf-8?B?MEtIOGlmekppd24xak9kSHJpczcrMUY4bnNGaSsybCszZnIyeXNvZXB5bGtW?=
 =?utf-8?B?N1B1alBtT1lkdXg2TWVpb2ZMOGM2NTRjRzh0Q3pldFV4bjNXZUs5cTFoaEVy?=
 =?utf-8?B?TkY5MEQzOThtd2VFV2ZJQVJCc0RRSWNXaGpjRFVKOERaMjVnRCtWQ0ZpUnNG?=
 =?utf-8?B?ajFlbWUvaUJGTjl2OHRsZGtxZU50MWxSdGpmRkpWNVZLRnhuaW9GcnBwbVdE?=
 =?utf-8?B?MzNSN0ozdkJ5a1AwcjMxTHRvL2xPUHljeFZjK1lvQ1hGZHZqbEJuM0dvVS9i?=
 =?utf-8?B?a1VjYWpBWDA3VVd6OCtXY3d0WmJGRk1FTHJnbW1McFVFQ3VqcURybktYeUp4?=
 =?utf-8?B?K0gzcFUrWjA1eHlSYkYvYS8rRUQ2MkRqbS8zaU5tUExnWURsZHhOZVpzamFY?=
 =?utf-8?B?OXVBMjNKcXJ4akVQcU1DTDRWSFRTV3NtR1Z5QW1KemlpbzRYVDFhYnZ2M2Mv?=
 =?utf-8?B?bWxwcE9UWmlQMEQyOURmZDVNUXN5VDdTL1RCNWZqTHUrMjNPYjJKaHhCQlZk?=
 =?utf-8?B?b01NY2UxamtvZWlGNk9MaGxGcFZ2M0xwbWNueEpyZUF2cDhCS0RUUUs0R1d0?=
 =?utf-8?B?NFBuYnc1TmtzZUE2V2NhTmxZUm9nYUhENGJDdVNSVHhqWnhacGpKbGdGSldq?=
 =?utf-8?B?eXk4RnAxa1BTaXZ0bDVvMzU1L0dqRFl0Y1MveXBza2MwY3V1STFhbkI3Tmlk?=
 =?utf-8?B?S1lkNitSWFBHdUc0VUR0VzVFeC9HSkJkdXBQTFRlK3AyZ080ZDRQTmtoWDBi?=
 =?utf-8?B?VERNNi9jbkk4QXZwa2NONlhMdUNpR29DN3lmL3lCUHBvZFBHYWVES2QwMUtq?=
 =?utf-8?B?alB2b011OWpiVHprSHZNZ2g0dm1QaXIrM0xleXFZWld5TzBzQ1hWZ3o5VWN5?=
 =?utf-8?B?NDEvaEJMWnRlYjhkZ2l2ZWwxOVV3b05saGEzMlA5Z3hCMlFXdkVsMEE3MkR0?=
 =?utf-8?B?VHNDSDhDdmFaaWFrQkIvT09yRkE0a3QzYngvT3VEakUwbGcyQkhDdVlYODR1?=
 =?utf-8?B?RkNiaHlyTFU1c0Zxb3IvaUpuTXRQS0dBTXN0UHBRUGhXNjhySWVpOERZODJu?=
 =?utf-8?B?Q3MrWUlFZ1pod0Vpa2l0V3hJazh4UGxJQUJmZ1dEUlUxRGg3dmJaQUE2YzRT?=
 =?utf-8?B?ZTdFd2x1SHk2bjQ2anZLWCtGZjczNlRad2RXMmVUdktJNHNXcjUwLy8rOXdI?=
 =?utf-8?B?LzdCeUdxTDYvM1IwY3d6US9PeVdoZ2h6OEl2ekhMQWVYMkxobG9xS3Z0VFht?=
 =?utf-8?B?cjhlNWxYMHU4cmllK0xsK25JUWduUkc1N21ta2FMdC9OUG9CdjhCWm45NWhz?=
 =?utf-8?B?WGcyYm9MeHpyRVlRelNGTTcwaTBOK1lSOHh0K3NYb2doMzlJUHkxM0tKa21S?=
 =?utf-8?B?bTU5MDliRHpvdWJqUk1zcEVFc2NPT0Vqa3Q0VmJrM2NSY3haQVhkV1l2aXZD?=
 =?utf-8?B?TUJBcmJUbFBlemlLRGhKdmFPd3dKWUZTbnhuTUxxWXFqNWNabXNaN3JXWDE0?=
 =?utf-8?B?MVJyN1FZUzFEb0RjQ2VlTUlORGFpdENsWUhNMGVFQXFUeWllNVJxTENyVnlv?=
 =?utf-8?B?aGtaeXlHS2ZMM2IxV0VRZU1iZVZOY05EOVZZaFEzNUEwK0hjUE94ZmVwaTdO?=
 =?utf-8?B?Nnp5SVNzUjIrWU1mNmZyTTVEREViL3pvUDlrK3hxRmNqRlNPZmoxdzRSQkNv?=
 =?utf-8?B?ZkQ5ZjlZd0t3aHZ0TC9qUmx6SFl3OWE5dWw0N3laMDFHQXVzQTBBd01CZk1V?=
 =?utf-8?B?NkhwT0xSVkIrZTBxc3EyTHlUSzZiVzF2L2hCLzk3dWhYWWFhbVdVWGNyUEVS?=
 =?utf-8?B?NWF1ZUZBYXVBK2RlMnVXMXVFZEVCMU5FcktKRXd2aitEMUErZXhaVTB4dDUz?=
 =?utf-8?Q?YCzlTv0WLD6rc1V8=3D?=
X-Exchange-RoutingPolicyChecked: PcMBVfnPLjf5ymR0lA4nxdtZ0X7GwRY7TSljY3XtD+xi/ITHnPnteRS7Le4198glYEZTU2093q/vB68lPTszZvuit6OtXhmFLPhU5jG3xygcPVJyjvZHjTZESbHMebkhPsfvPYGaq90vyMZm856mjWNOYgdiyzBEbOfmJhMDwVCDkc5Um8NXZFhJbIwaFBND//gjkC3e3cJyraKEY/+62GDlOLMBCor9fv7X+Q1A+uoj3H5yDS6/jFVe/mmTsuhQjb0Q4I2GUgVotssjqIK46P9CRqO1VK6kZHELzjvkuk8qtMOhMkhbrobcxpBJP5EaA5EOA550oiqR1HO9p1aCRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b24abeca-9322-4d8a-b32f-08de89f7eb6a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 22:51:43.4098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcp0Fqgptj0GPvnTklFGu9d5aBbH6ScCvjJrIGMMlLVd0rYo1zso66R/cImIrFnYIfF0FeJXHhf+ppVjO0ISA2k9b005j4QgRDcwhBNXdlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7200
X-OriginatorOrg: intel.com

Hi Babu,

On 3/12/26 1:36 PM, Babu Moger wrote:
> Add resctrl_kmode, resctrl_kmode_cfg, kernel mode bit defines, and
> resctrl_arch_get_kmode_cfg() for resctrl kernel mode (e.g. PLZA) support.

We should not have to start every series from scratch.
Documentation/process/maintainer-tip.rst. Always.

> ---
>  include/linux/resctrl.h       | 10 ++++++++++
>  include/linux/resctrl_types.h | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 006e57fd7ca5..2c36d1ac392f 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -699,6 +699,16 @@ int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable);
>   */
>  bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r);
>  
> +/**
> + * resctrl_arch_get_kmode_cfg() - Get resctrl kernel mode configuration
> + * @kcfg:	Filled with current kernel mode config (kmode, kmode_cur, k_rdtgrp).
> + *
> + * Used by the arch (e.g. x86) to report which kernel mode is active and,
> + * when a global assign mode is in use, which rdtgroup is assigned to
> + * kernel work.
> + */
> +void resctrl_arch_get_kmode_cfg(struct resctrl_kmode_cfg *kcfg);

This interface does not look right. Would it not be resctrl fs that determines
which resource group is assigned? This cannot be set by arch. Why does arch decide
which mode is active? Is this not also resctrl fs? Should arch not just tell
resctrl fs what it supports?

> +
>  extern unsigned int resctrl_rmid_realloc_threshold;
>  extern unsigned int resctrl_rmid_realloc_limit;
>  
> diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
> index a5f56faa18d2..6b78b08eab29 100644
> --- a/include/linux/resctrl_types.h
> +++ b/include/linux/resctrl_types.h
> @@ -65,7 +65,37 @@ enum resctrl_event_id {
>  	QOS_NUM_EVENTS,
>  };
>  
> +/**
> + * struct resctrl_kmode - Resctrl kernel mode descriptor
> + * @name:	Human-readable name of the kernel mode.
> + * @val:	Bitmask value for the kernel mode (e.g. INHERIT_CTRL_AND_MON).
> + */
> +struct resctrl_kmode {
> +	char    name[32];
> +	u32     val;
> +};

There is no reason why this needs to be in a central header exposed to archs. Could
this not be a static within the only function that uses it? Something like
rdt_mode_str[]?

> +
> +/**
> + * struct resctrl_kmode_cfg - Resctrl kernel mode configuration
> + * @kmode:	Requested kernel mode.
> + * @kmode_cur:	Currently active kernel mode.
> + * @k_rdtgrp:	Resource control structure in use, or NULL otherwise.
> + */
> +struct resctrl_kmode_cfg {
> +	u32 kmode;
> +	u32 kmode_cur;
> +	struct rdtgroup *k_rdtgrp;
> +};
> +
>  #define QOS_NUM_L3_MBM_EVENTS	(QOS_L3_MBM_LOCAL_EVENT_ID - QOS_L3_MBM_TOTAL_EVENT_ID + 1)
>  #define MBM_STATE_IDX(evt)	((evt) - QOS_L3_MBM_TOTAL_EVENT_ID)
>  
> +/* Resctrl kernel mode bits (e.g. for PLZA). */
> +#define INHERIT_CTRL_AND_MON		BIT(0)	/* Kernel uses same CLOSID/RMID as user. */
> +/* One CLOSID for all kernel work; RMID inherited from user. */
> +#define GLOBAL_ASSIGN_CTRL_INHERIT_MON	BIT(1)
> +/* One resource group (CLOSID+RMID) for all kernel work. */
> +#define GLOBAL_ASSIGN_CTRL_ASSIGN_MON	BIT(2)
> +#define RESCTRL_KERNEL_MODES_NUM	3

I think it will make the code much easier to understand if the different modes are described by an
enum. For example, 

	enum resctrl_kernel_modes {
		INHERIT_CTRL_AND_MON,
		GLOBAL_ASSIGN_CTRL_INHERIT_MON,
		GLOBAL_ASSIGN_CTRL_ASSIGN_MON,
		RESCTRL_KMODE_LAST = GLOBAL_ASSIGN_CTRL_ASSIGN_MON
	};
	#define RESCTRL_NUM_KERNEL_MODES (RESCTRL_KMODE_LAST + 1)

The supported kernel modes can still be managed as a bitmap with intuitive API using the
enum that will make the code easier to read. For example, __set_bit(INHERIT_CTRL_AND_MON, ...)
or BIT(INHERIT_CTRL_AND_MON). The naming is awkward at the moment though, we should improve here.
		
Reinette
