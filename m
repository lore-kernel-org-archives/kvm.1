Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1D38C42E;
	Thu, 12 Mar 2026 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333282; cv=fail; b=FoF7z/lJNgA4kS0gPPVN1xBgS/nSfKnFGe9WN6Q+qE79UjfiteMXPl9mCUQjT8mqkQPQ6KS7Sg2ymWjTDthx60uAir8XCjv2Go5rcaZXDUO4SJSMxgQ6WfTA+GDo2cC82qP6GCitOHh9xZX9PIAloicInnvdoq7Wu+0mneu5Ku8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333282; c=relaxed/simple;
	bh=Sh8aFiaW9qzEhLN4wmR/AXSx2ltiHenV5gV4qoq4Mfc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nzf5QyteoxAHic9Dd7R+WdyaUWdoaDJlVhPi/j/MC32nyjRUcEayAp+6pdZzfLUSLvsQUyd7QgF+krhGqnq3Pu2im8tE90eTzj5+5j28OfCzUe5P5MrGJEyjhMTMSvRH2jI7oqnwvY4fXvpUNwXZM4PzjZxa+Ns/iR3vFbNZXDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bwpj9vNB; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bwpj9vNB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773333282; x=1804869282;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sh8aFiaW9qzEhLN4wmR/AXSx2ltiHenV5gV4qoq4Mfc=;
  b=Bwpj9vNBAZrYoOOVKQG9olQvtZwKpTQoqwFAcD2aLNB8BW/5I7kAIIAO
   OH688tWpra6bkLxGjcf0mIhGqkj4Yd4fjPphgXCNcQ4361RMtLRIhjtug
   yZtpQALj3lrFynQM44ZOHrEotENG/fcyv9nCKaUXzSPHApyRafMcltdCc
   ynFY/EANFZycJ6T/lo64V12PhiQkW3CaEhoQc4R/lIgahiRFUJARMVdh+
   uuA2xHnQBzNpu2sz8mu64dg8r+LmjaW+3RNCWTw9SPvRNa/1HatUqbK9q
   RPP33GT8reIV7c1oss84QvMib/bWoCXTXXJvJE0ojiNZpLifoLmXpEvvN
   g==;
X-CSE-ConnectionGUID: W3wUo1lwQrSvlRsUv/ROog==
X-CSE-MsgGUID: dy3Gx9QxR/WY+zf0SD94MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74132596"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74132596"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 09:34:41 -0700
X-CSE-ConnectionGUID: RCEH7Bj+RDyIBGytU+kwsg==
X-CSE-MsgGUID: 1/jpVPqZT3GIG6/4RjdlcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="258787500"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 09:34:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 09:34:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 09:34:40 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 09:34:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYdQ0gAfzqa3Ag0/pvbw+HjZnHoKXHEH8l5APwnDVv4xH3d7lzFXlANnVX/La2SzEOxaE9jHnxk25YdRA+vuWcNEvdodGe4H3ym/7WaKcejuxPJ3wQbOUjk6QxJTaqnRx0RXIWtIlXRK9ira3FfI65vHhR6GZclrlKfJsBuLdOCxWOFLUq/Nm15sqZ7KWl5N/m80VIdcCHNGx3jkazxGq0uxqvD2zRzI++Fw3mWbQoibvqjQZy/n2Fbu2F4BGjQFtCyoIH3wLaXryNi5UXgqbW3Rw+kqlGrD6HtmHNcevoTJR7Ls3VAdr0ygAWZTcMXdW3jJFgSouCj4yEGZG0oLnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYXeMYBO3vZLaaIKIWPVXAT81e0iUqcMSYOdAqPw8nY=;
 b=bfCLd7DinKOxjyYVsLwXEJJLFKasOz0v3R3WHIt1WaCByqTRn8vMy4oBTH/NrWqn9x89ooFAEbPuRa8CpVoBQqp/mFfznGD+7SCVW6Goaqt4MSG19kA4/574nRKr1E5nuLY0WtsspM8IhAEuxONGB9h89F3T6xz//hd0NnrDiqFguSw1eIt99Yb8F/kgsJd4i4al9anaHRk465Aezx3duXGU/z7Io6PA4Ogv67oWCwXR2RLuaNENItUDir/ja2FuL5WGtLtrKfeHIHkvqY+L4pwNpPlgMBkiutPj8aP2aLtLrvmMZGEhLDanfq+A5HeSINVkYxTPUheNu7AL+3c3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 IA3PR11MB9086.namprd11.prod.outlook.com (2603:10b6:208:57b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Thu, 12 Mar 2026 16:34:31 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 16:34:31 +0000
Message-ID: <8853f8d5-57e6-4ea4-b9b5-8a0182d0d012@intel.com>
Date: Thu, 12 Mar 2026 09:34:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] KVM: x86: APX reg prep work
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Kiryl Shutsemau <kas@kernel.org>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20260311003346.2626238-1-seanjc@google.com>
 <7ec084f8-812e-42f2-8470-e416fa7ee848@redhat.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <7ec084f8-812e-42f2-8470-e416fa7ee848@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:a03:100::15) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|IA3PR11MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c85637-e1be-4cf5-fd71-08de80553c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: daiwyLyyuO3dua7hWNlcV1425Ev5JIyvSIyilEXS3CrCvBmR3b24HKVjlY3xBjRuX3ACTviYh9BOgPIq100e0VIGyB5pJwFhnRYIEvnX5IWjwa43i1VMxRw+8hUmGpTTBXEhllrboMtG3EYGcP+DppeDbmFOe7tvK6E8rpjmKpveiQbAskYH5xTHQ2DL68g3O3ZYuJ2WNmBWRnemwnfmLEDkQNWheKCBlTECARMyYm98NpdEcwf/PhfJiyozTp3ZXbhpXIXNCXOQjLirujp7d7M1dIYDOaG8WGZpcbfBL8iFjfZV5wFhsdroSL6coOtT0piZhqF8Cu0IVnfCTYT8VNjNF8acQMH21p/j7Ut+sGUFbn24FS/Vj3S7i/Lx6iIHcjf6PxxDww7QRRPWWvrvSAMNNAz8zlnqxCji5O6uKW2RStiZkDOczm+k3u6DSGxkSOJ81M3bOPyfOUVln/RNSWsrqeWKWENtgAf+rW5oNcJsI4OLe5zt3fWLmYgAqxSKCGu7QSzoibd3HIm8TkJNH+LPqHmr8OTony0plwKyKCsRw0WkEsmZYijxsxCx53GGkzAX9dIISuVMAyTer/yEmluPfIXOMT82MJ/RJHd/nRDbCuSaiRQPTH+7q+lVhvfiGbbosmGYUhHY311v/VHebzpdzyKvoyCtynXZeHNQrg+OlIXQdoXWxcVRa2lfnFzcqa9PAbXJoRdq+GJDEFLBFLUhcd3Ol3W0uD3aK/UXnMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3JYUGRFZC9xN1FJN011b3lCRzhyQXp4K0hZbTFJTFNtNjdWb2NJclowbXl3?=
 =?utf-8?B?NXZZVkUranl3UTM1TEprQ3Y5UjZQVnEvNmRnK21hOThsTzAzSFFaT0F1bXpo?=
 =?utf-8?B?QldWcFdTZmF1TFlIcVVmelZoeWtlaGF1d21qZTJzWkJTVy9RNW1DQzlWaGJk?=
 =?utf-8?B?VC9RK2ZlMGhSb1hHSHg5WitRNk5MUzZhdE9LcUljUmE0MlNuaUNOakZtQW1j?=
 =?utf-8?B?VWpIcEVSUkR3bGphdkJ3WkpxZXl3b3R3eTF3M2VlWHMzVS9ROEJhTmZLdzdl?=
 =?utf-8?B?RDNBRllRWm9EL2hsSmFZTHFCM2FnRlV6Y3VuenJDSTJYWDQwTkU1TFpqbkl1?=
 =?utf-8?B?YlY3T003bHlwMUVjTWdremRVeDJRUXd3TlVFZjg4UXRObXVpd01yZ01wWi83?=
 =?utf-8?B?UEt3cytDWTVzQlZuTURrbjRibGFzb0RRSW5jbXIwWWxJRHVYcGFkN2poOTBa?=
 =?utf-8?B?YnJTZmMzU0dWQzVoRkZmdW9kekpCcU9sNWRLQVI5SkVhN3FGU3M0VEJyYU5P?=
 =?utf-8?B?Y3ZmT0R0NnB3UE9xQkp2Z0lERUs3WDJZYldqRVl6OGFBdS9kZFl0NUpVY0tY?=
 =?utf-8?B?ZmFWU0pDUnhyWG9WQVZHWWJUMVNnRnF4VXVFVC9nNTJkZ2U5aWtra3pEVWk0?=
 =?utf-8?B?RGVvZjRiM2duVFAyem1LWHJEUm5YRVhBRjVucEZnc1dISDNYS3o2ZDNJVXF4?=
 =?utf-8?B?V0J6WURyYUN6RzFEMkdJK0RMVlg1aGN2d1BFWXVWdWYvTFVPb1lzclgxT2x6?=
 =?utf-8?B?bCtXaWcwSEdXVGlpYnBMamp3Z01nN3hmdzdEZWZ4Sk8yTkc4V1JhQk5zRzAx?=
 =?utf-8?B?Q3E2Tzl5SUpoVnNSMTNINEFyU1N6M3daeTFlYjZnNkUxWEg0RkpmUE1qTk9W?=
 =?utf-8?B?c21yRzFQQ2xjWlBvMUcxTnBwRWZEZDNKdGprQUJvcUd4UGdPczlGdmQzV0JC?=
 =?utf-8?B?UWt3ZnRISUV6NlZLcFkwZlR2Zm9zbS9TRTRWVDBsV08rcVhBTHd6T2M3N1gw?=
 =?utf-8?B?aGlOUTVKT3RINGZlcVZiVjNaMWtPNEZuMXUrVy91UmdOSi9OTFhUd3lHVGNj?=
 =?utf-8?B?MWEvZWIvZjN1SitKNWJVM1k0ay9MNksrWFZDNk1SLzlPTEtuUVBtTkNOTU8v?=
 =?utf-8?B?N0tHazFlSC9TS1h4YUhya09QOVVQTlJpMWlPN0V1aUp6YlVrekVEWitzbWJ6?=
 =?utf-8?B?TjY5czZIZUduRXlWYjh0WFduOEZ3TzVDZ21HTDVDdU1vS1I5VzUvTTFOQU15?=
 =?utf-8?B?YWZGTlJTSWNwa09JSW9sWk9UYzJFTndBT1BZL0VjZmxwRUFhUWNSclo4S09u?=
 =?utf-8?B?TFMzank0Z3ZGMS91QTNHTHpoZEpKbzF1bUVSRDlyNnBLejR1RDRvZFMvOGNF?=
 =?utf-8?B?WVZKZlJxOWo2QWM2WXU3V1ljZThoRno3RGcrYzBjYTN5VjZFcSsvT2tDMHV1?=
 =?utf-8?B?TkhzSTdBL3RuQVZDRXlNUEJkT2pNVENGVG5HdTRLbDFwcUpSUWJOUjM0bVlB?=
 =?utf-8?B?Q2V5YkhGTWgyL3lQd3d0Y2RvbHZrTiszRUZCMGtvOUk3S2xvQXd0V0x3am1J?=
 =?utf-8?B?SGUxbHhYNkRuZFFVSWN4ditZajRMa0lkRU9NSmR0bnVkd0ZFdWlJOXMzdlVs?=
 =?utf-8?B?NnR3cTlwT0tXUndLc1dPK0YrbGJuU2c4Nmg1SHpaZE5vNFBEeXhhWFoyNDFT?=
 =?utf-8?B?RUhoYklpT2dQMm1JaDNHR21QbFR1ck1FWE9ma0wxd09FNk83SU9IQjFXRzRO?=
 =?utf-8?B?SUsvVG90d1BwQnBoRDA4K3QvM0twWnk1eHd6WWowZGU1a1ZnQWMrWi9VUFFj?=
 =?utf-8?B?aUZiL1BYdjg2YWNnc3Vib3QwRDJ0VmlxeWZuZEhHV0t2NUNINmRRMWdndDRZ?=
 =?utf-8?B?ZGFGa2dkb01QMUhoaElPd1gvcS9SZDNqV0tlMGlSTWFpSGk1K2VBeVFNTWxT?=
 =?utf-8?B?QmRGQkdkVFc1M2RvaUdCakpQMUMwKzhyaFF3ajM0WFhsZzdwL3B0NnFBSk13?=
 =?utf-8?B?QzNMVUhpTW9udm8xUEhYbkpiVnlSUnFkWTNkWTF3YWl6MlVGdTNHTVBLZ0lW?=
 =?utf-8?B?UU9veGpxMmVtd29iWFBJUkU5aEc4N2NZTkUvcVRwSW9XNGh6d0xmcmRRMzJ4?=
 =?utf-8?B?YUd5b3ZCWXZtb3VKR1M0d0ZWZ0NZbzRxdXlQNUUvOHFkT0s2QnMvM05ETjFq?=
 =?utf-8?B?R2dCMXBoZUxrQW5IOHJCOGM4aFN1dVRINUQreUhqQURnQVpnQzZheDVzUnZy?=
 =?utf-8?B?bm9Wem9wK3E0MVdFbnF4V3JYZkdZaU1UWVJGdXNFV2tKcDBFUEdaNlhEQjlO?=
 =?utf-8?B?Q2lyUHdXRk9YdDF1dXBmNFBCb2FFd2wydzhEcmdZTi9vL3BkN3FkZz09?=
X-Exchange-RoutingPolicyChecked: PP7k7jMJk0VGwlt80wPJqnqp3Qn1V+ICYUekSk/MwrIIvAs8Ec2QLyDsYvzTbbWpXy3Qnr4ZDO8y8ctaVGx8QIrSpoxJZ1NwEYI2UV8Fj3g3cV/cVUGTcbVKuTcPXL1hNoY1ioMM9APjPbZyqmu2Spwj0bXrDvW7fDtk7JkBEX24+H1D6EBGpkqaLjO68vtZ8w7E9D5gDxzfAao4hxwODFpHjHBzwZeKZLNRAkrJW3UEtY4FcO/WCUVWmPTXSJp17FhUTKPFf7ls5/dJx0YTGWZ+qh6gystJrsXnOvTPCHvGp/Mt6E8IO5w9nmZCXL6kUvccl00Qt763wyaX1QzvDA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c85637-e1be-4cf5-fd71-08de80553c85
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:34:31.3179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5j91ZwbfuMPFiTZ2st6IXUAZID4krNNL2ToJgzCZG2L2fvZk2DB3iUZ42lyPXiY3n1kKslnAgVVIswwScfsQr14ACrH5LpzmW+ejklLbts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9086
X-OriginatorOrg: intel.com

On 3/11/2026 12:01 PM, Paolo Bonzini wrote:
> 
>   On the other hand, the extra 16 regs[] 
> entries would be more or less unused, the ugly switch statements 
> wouldn't go away.  In other words, most of your remarks to Changseok's 
> patches would remain...

I think so...

If the host kernel ever starts using EGPRs, the state would need to be 
switched in the entry code. At that point, they would likely be saved 
somewhere other than XSAVE buffer. In turn, the guest state would also 
need to be saved to regs[] on VM exit.

However, that is sort of what-if scenarios at best. The host kernel 
still manages EGPR context switching through XSAVE. Saving EGPRs into 
regs[] would introduce an oddity to synchronize between two buffers: 
regs[] and gfpu->fpstate, which looks like unnecessary complexity.

So while ugly, the switch statements are a bit of a trade-off here. Also 
bits 16-31 in the extended regs_avail will remain unset with APX=y.

