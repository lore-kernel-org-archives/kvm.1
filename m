Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72A027A92E
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779847880; cv=fail; b=P9o+u4goaobuppg1uXYfpwaxkU+WFw9cmTjgBsUPIdZOju/I4K6pOHSgHO6I2Wy0i4s1W7YhA2dlGZQSE+lmRGxUr4hOeClRur3DW2q3gY9YZC0BXSffRe7KPOU1KR/cZJUsBWf2Op9fZo5O6umBpXv4ZRuCngU/u5asCpSMVYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779847880; c=relaxed/simple;
	bh=buEx83YiSSMjUOdvzg2V4gxS5N2w+ESO3GYX7t+Ru8M=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s7v7lW8h40LJzcICkifSTOR1Ocy0FmeUGiQ6Ir560cvDrhfasVtVUU70sgT8uAWK/QY3o8bD1rG/P5SFWZX+7PWRLAjh+NEXIUnFinTSvL2n7hwkNgRvALEAYSLueE5NF7/nXGvgARMEEgE3VLJ9CKi8J0ec2u9vzn5E5mVJcQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGZwkldo; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGZwkldo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779847879; x=1811383879;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=buEx83YiSSMjUOdvzg2V4gxS5N2w+ESO3GYX7t+Ru8M=;
  b=UGZwkldoxvzy35CXbEDbeHbYG1IFMLlQ8p80XnP0hPPWyVrdydq5N7dA
   p4ssjuKOHCB2u99EHb+vDLNF/mZj47gOrrNblM3QeuqokeOUaT70vUyHX
   PVZb8Jo8WTTMPMaQ18SI8h9n4ur9NKaPhRuE7h2dE1OgOvj84WnHwuV43
   TSjPxbPcKREDwnsFywXzqKp1VSCmKQXmQqqcTiFb/S2FqhCJrS39FeWBB
   +MUNppmigf5yB83SU3JbVvkGd8OzotFy8eUxl6YlXSnSJ3fwy8ov5XKAF
   Pp1ygd2yRs0CSvTY3XeuLc8rxd3kASSGi9CakADS6NFX1gUMgbiQbW0iO
   w==;
X-CSE-ConnectionGUID: b8dN+FeFRTqcjr2M0JE0XA==
X-CSE-MsgGUID: b6zJgJ6PSo+WFUMgMjAcow==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="91362661"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="91362661"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 19:11:18 -0700
X-CSE-ConnectionGUID: OBMvTuaIRpOvHfj8ldMJDw==
X-CSE-MsgGUID: F6Q3kHAiSoCvq7+x3gUCbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="239093430"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 19:11:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 19:11:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 19:11:17 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 19:11:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kL6IkILoBpfnP/7P14B795OynNbTYCGomao4oT4z3YaENwnx8SISqLcDe/0vDROzCEbLLf2vJeZc2PL/ruQuEDCbQkNd5GsZGm/ywscZ5JN7eXeyMQOptIGhMiAvB4fTsyHPeYlkBgT3l0sAEvT7k5cQRbJssabU3l83+/8VJuVUedUmeWILymlF0eKloUXhZYYySS81pOZFz01lqKfXutynsmklN5PJhpy7JHW831hPgljjeLDISqbZqfwT3+E9Op4YQL1dARVUD+re8Jn8R0zCCVtYxDPg27sEJ1aSCNztpq0vjGclViXgVMbfEKShKDJhdggqzq6mjx0seIweaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIYMlRZ2eL59d2xiT99E3+yLgq71DK60feGkN5tTQ24=;
 b=tIu9nFUkR9a//IGvOx2zcSz1zWFnskXQFynwqOMYJdLuHy066I0fWlKC0dTGtHZheMqzHFhvr0pSfIJEZGGUtPi7im44I9yffJ3Wjh/vSVFjdm2yOy3D6OiecTRXOtJ6eZV5MUD5JtK9cP616UmIvxL5/NoL3zgk2Qvu7Ea19KVLqHxw4rtmrfDDnWIYdQF89NNTk5afRTwHrl0tBbA7elwnKPBdlEvU59+mU8P+byFL2G6Y9yxf4mPSm1KIE2UEvn4makfD7XjV8IV/yLS336y+JeYvAFGMi7jZUCjTVCMJP8KRNvcE4CVSesPGqD84sr1FlGMu4TaKn39Bb4GNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 IA0PR11MB7403.namprd11.prod.outlook.com (2603:10b6:208:431::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 02:11:15 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%7]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 02:11:15 +0000
Message-ID: <93ab2feb-52c8-43bb-9a72-826e3df344c9@intel.com>
Date: Wed, 27 May 2026 10:11:08 +0800
User-Agent: Mozilla Thunderbird
From: Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [kvm-unit-tests PATCH v2 4/4] nVMX: Validate DEBUGCTLMSR_LBR
 states during VMX transitions
To: Xiaoyao Li <xiaoyao.li@intel.com>, <kvm@vger.kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>
References: <20260526031704.109102-1-chenyi.qiang@intel.com>
 <20260526031704.109102-5-chenyi.qiang@intel.com>
 <d4c1baac-f81e-4ec7-9d57-be0c51640d2b@intel.com>
Content-Language: en-US
In-Reply-To: <d4c1baac-f81e-4ec7-9d57-be0c51640d2b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|IA0PR11MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: b17fc0eb-9e2c-414e-2e95-08debb953b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099006|11063799006|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info: FHsNitGmmLrfmAMLSLPl0yNQaNqsDVL53QM0oEuY7wdEJ/r6DQyzw80x+QHdi1ZvLUSrQEHfl5YmvQu95nFRHjD7W3WGWJdg2oMx01/Zxe9a7kE07lNidNg0RcXZVDF/hQOhXgDCtD8uFXzZPbwuvOSDY24cB4QN0+tEq5evnC/PDmD+7dhxaW1GS8x3kyF4waAa/xnmMdzPTeNb7pccrY967nmjhT+pANyDUlO0snaHh2RPsvFWA5rHoqA3w5aWfnKHN4CJFZQUe1CEA3e8kMHTajaRjUG5/DNyXW9wqkRJHeQoYfbtCk8irx/yYJAu/QRqA9ZX3LwJnnRHAFc/Y07GCA5m//Ast1RxrLIHtITJMO4SuI3YIKb/TJSy47LfMdwnTY9cT4XKsF+u2hsqxcJs6MEsLpGIc11mcYvX2Qr3ROBzzStqlx2s7rySbypul4TqYtckH3jvg+DsYXm4srBJRqu2N1HtKgHwGtc05FRnC7Fw5b4niFCpRxYNgTLbbLW3/veDge+BjDpUbf0XWfsSNURIbNJQpkFI5gtXba9WvbnkljBWmS0c7O+D8tDlye1z7XACMA0Vd4m62G00krg3ZVPmZU8A986MUJH1ykQleI73cGgFfuLjbma0h7WBxTqpTgRp3mMl2lTymuDWHck4RPoQltLO6fb3GJPMEoc4DM/EuIoXZV8B8tfSncZB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0NNYmFPVUlzY0FPNXYxdVIrNmY5SC9teWhTaHMrSjhxRVlKVnFIaVVtby8r?=
 =?utf-8?B?YS9zTDVLTUo4bkxtSnRCeS9hQlNRUUxyaWtqNnIxSXMwUVozNklGb3lKQWhF?=
 =?utf-8?B?MmNSVzBHcWJvMzdrUGFhYlZPdlo5K1FTSkJ0TFg2bkxEajVHQmhsUllBWTM0?=
 =?utf-8?B?SnpBalJqUkhzQVI3OGxMR3NVY0hPd2ZseFg2OGErUG5BL0YzZFRQc3BGRUxK?=
 =?utf-8?B?amYrWTkyQlNjMWc5MHcvalFrRmxzVlJRckF5L3o4WGJlM1NPRjE1ajdVcXVT?=
 =?utf-8?B?N2dwUitXWHAzbFp2Um5LbnFCcVFzRHFwU0NyVk1HUm9SOENSS0luWEpsYysr?=
 =?utf-8?B?RDlPRXU1bUprays0UzE1MkFKSkxrMmxQTUtQQWxyZzIwUkhHS2lPMTlKU2NR?=
 =?utf-8?B?M0Z4ODJMS2NkSVd1MWJFWWdKYmxtZWtjY3hkQ1RrS1pGbzhrOThrZUFrcFZp?=
 =?utf-8?B?YllBS1QzU2U0QWpSV3pTRWJSTXAxSXllMldneU44NHFESFZBSDNETU5nVDN1?=
 =?utf-8?B?MTQ2WmxFUTd0MlJIYlN1aDEyeHhDaklXOHRNdXhOalk4Z2cvS2VlUU1lZWZF?=
 =?utf-8?B?eUFRQTNFVE9VcWg0blc2bUtTaW92WTN4dmE2ZndXUEVKTTFoOXR4Nkp1aHVv?=
 =?utf-8?B?Zjh5QXVDY0lBNUxHa2VoWklRdXh6N2xPUlgrR3VnOGlERWY0V2tmK3pJcGxv?=
 =?utf-8?B?VFBqY0ZGVHIzZHdsZ2VhdlpteG5PVUdoYUJzV2sydzRlZEFSejE4T2s0VVRE?=
 =?utf-8?B?QnppYzJhbGFnK09SelBtdFpxRHR3amMvS2NROHREQjJnWlBTV2VMZzVoMWhL?=
 =?utf-8?B?UzNNdUxCaWUrVmhsWTc1RmNKTmV6TkFzRUlUN3NLMFJUNW9tRk1VSzl6alJX?=
 =?utf-8?B?VU1aVjdFdFdidkRrVDFNZ0F1SVlkRk12aE5Ba3g4cEs3U3VTYnphRytNVHZF?=
 =?utf-8?B?TGFidHlxRWxsNVNPWUcvUGpIeG9RN0t1MnZENzlEOGgvcVdGQWkrak9KdkZl?=
 =?utf-8?B?dVpIN05WTWRJM3pTYXJqcnlRNUw0MjZpYmRJVENXZ1dNK1REMDh4QTdxQzFS?=
 =?utf-8?B?V1BoMHJ1eUJLSm1jT053VUxaYjZXTVp6Tjh0UE1UdjlaSmhxZzJPdFVxSmk3?=
 =?utf-8?B?dmY4TUJ1dzY4cWxZV2xONEttVjI1bzd1dy9BWkNSemJtaHRoVDIvR3U2V2Qy?=
 =?utf-8?B?MUFZWUh5eVlySTFWTlVGakJVRTJmd1R2UjI2UHp2N1UzTEVqalBqSkxEc2dL?=
 =?utf-8?B?b1BqUkVYeVVGMklpZXhZNHlUdFFncGVFLzArWVdLMW92MnRYamErUThTSEov?=
 =?utf-8?B?bUQxQTk5YUpScVB5YnhyS2JQQ2lUSEdNRTlYY3NkZDhNbitJV0tpQzFvalNo?=
 =?utf-8?B?TkRZa05IbjVwRW82V3huS1ZGRCtzVXJxTXRDa0MxWmNyNmJDZ09zdGROdmpr?=
 =?utf-8?B?VFIvamRtS1kwdjYvWnd3QmxBNDFtN3FMalFhZlg5ajYzbkJIUU5Ic3ZnR0Zu?=
 =?utf-8?B?L0lQdmtJbWtHaENVNElxemZXUDZpM3d2Q1NhS0ZwQUhJaHU1cG54QWR3VVZj?=
 =?utf-8?B?THk2aTFtbWFYU3MzUVE4QzJsZVFzS2I2Y09kY2h3b1hmeEVLY08yL005cXZ4?=
 =?utf-8?B?aU9YMnliTndWZW1yZGhGNzR3S09Lem44Q1RCWmpZYzlUMGtaRXNtalBuaDE0?=
 =?utf-8?B?UmNZNzlRa3lRckFuci9hcFlEbzhZZmNLWTFLVXYwU3hIMk1wclliLzUwYnpT?=
 =?utf-8?B?ZDZPYzFpRCt5Z00vc0QvZGF4TFNhTll2OTdlL1FpWllCVHdRbjFndkJRcDlX?=
 =?utf-8?B?enJjeHVBTDhFTEx6WG45djhYU3huazEwZjRFWnJaVWN6TVdpZUdLNVNPODBI?=
 =?utf-8?B?TWM2RGV2NnQvL0dXMVBFVitidTlkay8yT0VWcy9xYXVzdlhuVHpLMGtMbndZ?=
 =?utf-8?B?K1FqMU1OT1dFU2kxTVMyZHh4R3lqWk4xM1lzRFViUnc0VjJNN0UwMDhzVmVr?=
 =?utf-8?B?akE0VjJ3Nmwzd3hNUEFTZFRYRXk5Ky9HSkN2NklIQ0ZHM3d6ZmV1d3h5akx3?=
 =?utf-8?B?UUpPUCtXLzk2UmRvMW5SNVprWTNzTjcrOXV4WDlvWEQrOW9TWkxPbTd6N2tQ?=
 =?utf-8?B?WHZxMWI2MlJNUmFIbmxWQVZEQXoxb05LUFpmaG82K0YrbEZZb1hSQllSeis1?=
 =?utf-8?B?ejhUZ1l0UVBQZ3VuQ29IajQvWUdIVVR4VUFXbEdZQmVqcXNJcXhPT0hEUkIz?=
 =?utf-8?B?SWkyRVd2NlJkc0YybDFCZVlDcFc2VU9UU0ZMT09sYzBNWHk4WE90eDhRbGdN?=
 =?utf-8?B?SGJ2RkdYbERSRU85QkhKUk14TTlLTGtVVDBlRlEzcDZtZUpCRUdmdz09?=
X-Exchange-RoutingPolicyChecked: fvarTiWrA25lFciNZtriULcbSCNMeKWC/yCmZ93vE+IGvHP7MimnNkCqHiz8nJWjT+a/nZr2n1eKeLhtTGALVAp1oOjfVMMyu7opVyx7NjzB6F3YuANma7cEt9OQuKOir4lvft2s+pbNbQyuwC1cGPkgR8YYfN9lO0zzzlYupNujO1OC0q4TbTsAsUOw1Q8TOQj/SOj0Qe4tVIPjz4kzQnvlc/TPPQ8qQeutIn9ny4TbkAeA0CWA/ZNJeFfF3TZhcqcxeXQRlysug27SV6WKypvhHa/mQFoRMCbm75KD+ms75sedkhWrbjq4gzGU5/cFYdjVi3n+b5rd6vIyBUr8zA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b17fc0eb-9e2c-414e-2e95-08debb953b41
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 02:11:15.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POm1EMLhIVMXGMIKJn9yX/zXSZliGWf2pXqwn5yh4M0kluR6EIsV9+j9BSyi44APD+jNenJ78rxgDVA0dQRA2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7403
X-OriginatorOrg: intel.com



On 5/26/2026 8:34 PM, Xiaoyao Li wrote:
> On 5/26/2026 11:16 AM, Chenyi Qiang wrote:
>> Add tests to verify that DEBUGCTLMSR_LBR state is correctly
>> handled during VMX transitions on top of the shared helper.
>>
>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> ---
>>   x86/unittests.cfg |  9 +++++++++
>>   x86/vmx_tests.c   | 19 +++++++++++++++++++
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/x86/unittests.cfg b/x86/unittests.cfg
>> index 78c15e2b..d089c86d 100644
>> --- a/x86/unittests.cfg
>> +++ b/x86/unittests.cfg
>> @@ -487,6 +487,15 @@ arch = x86_64
>>   groups = vmx
>>   timeout = 240
>>   +[vmx_legacy_lbr_test]
>> +file = vmx.flat
>> +test_args = "vmx_legacy_lbr_test"
>> +qemu_params = -cpu host,migratable=no,+vmx
>> +check = /sys/module/kvm/parameters/enable_pmu=Y /sys/module/kvm/parameters/ignore_msrs=N
> 
> What's the purpose of checking ignore_msrs here? can you elaborate a bit?

This check is mentioned in pmu_lbr, and I followed it without giving it much thought at the time.
After reconsideration, this check is not needed in our case. The pmu_lbr requires it to ensure that
accessing model-unsupported LBR MSRs generates a #GP, but DEBUGCTLMSR does not need it.
Will drop it in next version.
