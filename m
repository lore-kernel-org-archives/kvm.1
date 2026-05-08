Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14FF34CFC6;
	Fri,  8 May 2026 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231841; cv=fail; b=e5P93L8hwX9+LYx9R8WAtiFIBAH0qNP7peiQ2SOYtgXvAYXwk+7t50Urg5fi9pQewS8u3p2mUDu4s/0Tp73a0GqPTMSBxt03O16V/yeRrC/It1rxMud4RqmJdRSGjuAw2sxXOPq6MemCzzXPp/pWw1zVZFgs1UnkQnyi79HNx8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231841; c=relaxed/simple;
	bh=OBbBXPX0clnszuMadIEyNe4arI9IpBiq+1Yh9qUYUk4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kSJAsOjzaIhsPFj8p27fT64dSbD6xsPBhWPzbLE3x4evf0ICwpudZFF3lNJGyquKblidaic7jkyF5E7jthR353t1ZPWDLDncYdDD30oIN2J9MZZ3tQ5sdrNEi4UpIxGv5etfbKAssBmfuO/fYSy325zoC6vl9CVcN7PzZ588g+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcfK1Ao1; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcfK1Ao1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778231839; x=1809767839;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OBbBXPX0clnszuMadIEyNe4arI9IpBiq+1Yh9qUYUk4=;
  b=gcfK1Ao1yzzv5uWbT5qk27kH8j3bk8+N699qyE45t9DRrgKAtDJaXkvz
   kD3DLB/yBBBjXdXBNh0LS9xnGye9lixhxpN3/a2kREOuDISG2Ze18Gbuu
   Fteov/STfS1cc46Z/4vqOm2sdIsBU0bplHhxSRfPXEkl+k+GOtYu7jpLy
   PhdlFAdz3FoH9WkAyUkwF5Cu8IfHByWIZy2KOeDeDR7cKPI6lbREh/BNj
   UiQmY8s7lTr5dDXG26LXv6RTchKFHJNR85ysySMTkFk9B8q2y0SGguhvu
   AbvjBlv9ZZi/qaiCoIpPZN5EQwryMnjIK/Dy2iY9OtjZvKNaiLWgFOa1j
   g==;
X-CSE-ConnectionGUID: 1//sG4IgRNCJYdYCg0OLvA==
X-CSE-MsgGUID: 0Xmz1yQcQkiBeS9gGJJFpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="89505543"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="89505543"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 02:17:18 -0700
X-CSE-ConnectionGUID: SA97YkFtQsWLyYGetecUjg==
X-CSE-MsgGUID: 5V2O9tBpSbuJ25bwFSm+2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="230323557"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 02:17:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:17:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 02:17:17 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:17:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxLeiYfzrNXog9q2z/Mb0Pfyqu82yP1P7jbbYPxy2+3LLxSBhQ1pNCyB7R5eSINS2uhy9CpnBUHu+2VMFtoZnFY0ZisD3fbIxq0jkdKdckOHKplcQolFk57jCchdJHlwP3lh07RuSMuVdaBE6OILybpUgy8jJUpbrhnI+65F5e0B+98b4+D+2qeeliPf5yz120Af7WiU2IJfGN4NZ0cqte4Jzpyk2NFWorO8QoHuxQCKUKZEJFaPbE+PB3/ixVZ/F6eX4B5e6jetT7eqdjZ6OI4u0QQijejGlaA95wZn6Fk9fwNReMPD9ruDcOTGB3WWAbJxaREliuB83PON4GO34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqM6x2u/DTM8vnRYiFETaXQ8ED1YBYjPHIg1k3RJG/s=;
 b=kqkj6acXyvd0DDee6djOlBKAKM3FakWXg79Vp7qT2KkBFqYm5PK+cAEpcs0SOEfk7+Vusfw0rfCVsIWfAT5hR9tv4BGaD4oaLageHCTgscxlVnFJINswF2/Vod1t+6qTkfYx+fPUuwXAlSuJVWUqRT5kQ7ksZaoG5woKp6D0ssZsty9EGvf+mqtRstKdQPvQpxKMCwarSkPhl4ViIf+KZdMqWcFDkRZCNwiaN9/RCClOFq2nYV1Rauwqc1rzA4GYIhgSP5oxh4WImO2hbszhZn3NVc4YRP4AjnzaVyfMz6dTXtBYc2hm8+utzOgLuuqxIYPguuKuX4RPh5xb6KD0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by IA4PR11MB9347.namprd11.prod.outlook.com (2603:10b6:208:565::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 09:17:10 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 09:17:09 +0000
Date: Fri, 8 May 2026 17:16:57 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<binbin.wu@linux.intel.com>, <dave.hansen@linux.intel.com>,
	<djbw@kernel.org>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v8 17/21] x86/virt/seamldr: Abort updates on failure
Message-ID: <af2qCU4mH5BV188O@intel.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
 <20260427152854.101171-18-chao.gao@intel.com>
 <fc27ad0e-fceb-4eed-bb1c-dbfb5b913bf6@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fc27ad0e-fceb-4eed-bb1c-dbfb5b913bf6@intel.com>
X-ClientProxiedBy: TPYP295CA0028.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::17) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|IA4PR11MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b11cc5c-97ed-4406-f90f-08deace294fa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BKtsMTfzYZ8Ef+QFF/bd9jTfVqeTSc6qE2I0FexylWMXYaYedtOR5aEWbUjHtfPtyNCh3Iv1LDfheUhWsXk94Wk0QBn80P1xaUDuCNn8MIgPvGW+8u3p1bCEK9u67SRNVfb7KVJYHyTMknOu9LzxpLmc2GB3JG+dyXSs8GdYB/gtqOQOITTiuoDzjZQUBGcbHhZNqlXttwXrI/5BzfPgqE9RANSHFTTi6nPrQNBc11ecUSvR38i9uceZa2+EGM35wdVEnIWeWypc38iUrivsA4Ke8Tu9y2Ee1Ok5mhrY32bQYikHMzEXE1eK9YJv9WziXDzbWLJ4N3lXRdGaKV5jPrnwZcqRmYiKkiGzGxAVX8zSgDDI6lz4HURPm3tPe3CqaPNeHJBvQSXCcBAfRFpfAoq5YMHWZA6A6ZEc2q+8oehn63w/BV+XXJVwLhU8VMWI6PHC0iQ4ScQJf96GtuoZwdWdflrTW8M/f5WOW2OMuzue1ZnswwU2boxDVv4LFks3VaJnGKoSavIbmjAxJ38O7zwaU8apJBsBe2j5CnJuJ2lylKqwjo7NRUGfr8IvEPmIuSDK2s+CvNffvTYg/fIaoGsODKTHtB8v+lbAai2S4ZUmfjT5ifRHlAdIPfQjtEwcD1FTDIOikoiHqt37+g2QScRish2/IZGyb9tBfKfVxIdH/W7hfHKojCbsHKPDSuha
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?++by02p6GdyoLv8rF/bOxjgfTFpRaIBFuylmc13kWzFoPy5nPz50bZMPJExi?=
 =?us-ascii?Q?a2T++kuWaNRDYC3P7mY8kOGqkBQd86RhI6ldyAa29xOn9TQeX8oWaMEB00et?=
 =?us-ascii?Q?5XcBKy44nK/QXkqyLmIfP3jbxygyo2JUhVLQ7522CPblAXQ2ae0ywShgiRzo?=
 =?us-ascii?Q?bz/nTljQ8iCMM82WYHPA/EWybblj7XIXTbu+VzQq4pwBVdM0+sadEZRyv8mN?=
 =?us-ascii?Q?PkBeUh3fUBDcbEZCGH12a7hyWgRIhcopWNJjZqOQAXzOvlQHh0k0Othec7Wn?=
 =?us-ascii?Q?v4Umdy09OnXYeoSSDbpvBNTEWum5qGHX5/1tq2f1IGaSUIRI3dGX5mKSIgu4?=
 =?us-ascii?Q?+c7K13os5m3eQrE7P/uQBXoWUb1e5SaI3z/i7C23IighcOtJSCITEiOtRMuc?=
 =?us-ascii?Q?vZihzK+GLUMoAzUvQ1XCJh03yai0A9G738BTiKnih1U9lagdp11OVjRs8oGr?=
 =?us-ascii?Q?GiDN4WVnQuJJ8gb33DIsp/TEKqLKJX2hLIVvIXwhIG19qRRgu4Hy/mwM3XNF?=
 =?us-ascii?Q?QlU9x0lDufmy8v/BoQ08vqiZE2V5EshjKba7yO6UQpTwFYEaLrSt31WF+Twk?=
 =?us-ascii?Q?YQZNKGJ0NnGMLvJe3JA2DZ4u8xdjHJjfb0Tn09OqBPiYPiHHYV9sNIEZnyyx?=
 =?us-ascii?Q?6TZfM1CykRGZ1JT1AkvsNVBEq/XKJYJOCnVROqwoKKCZx6u6vR9OJQArkSd8?=
 =?us-ascii?Q?OClW8PmnEhkMQTp4wul9nV9beLReVfqWu67burYwvP7N8KfBfqsBQw75/SmX?=
 =?us-ascii?Q?VskGvsKtRilD3WQ7fB39dWtQSf05pI92ETaxLbTYsRG2WskjNzweQYBsPoVL?=
 =?us-ascii?Q?zQ4PdR3KXpupTpqcQ2xmeN6Gq7UFgdrlkPAKLzUhXBoYrOKLW1kTTVpjhm/f?=
 =?us-ascii?Q?DJmeD+IyIpAJjF9GUqAQTZ6cuYDZMgpXlD63M+CbXkorvT42MaDDoFrybMEp?=
 =?us-ascii?Q?KN8ba2Y2zkL1Et/gFhKR9f3PVQ4nA/Oo1deokWbu830O2Gr4tXsB+h37MBLY?=
 =?us-ascii?Q?R2cyLLC0XtR9LO18+3k929n18wDcZvZH+06y6pFc1Sb0Da6i2w4rCF6MZmgi?=
 =?us-ascii?Q?0ba4RuZ06m3RQItoIr273B8AqS19S12TEPfJWCSSz6qKR/ta669yrBbSXtUh?=
 =?us-ascii?Q?iVuEm85yRaUgrx5iWUWKgPxa4knCg92DSUQR6kGrjXxCNw7S9hfay7F/+ai1?=
 =?us-ascii?Q?PWHSuI8foX/vqRr0jdp3JvHhmWaSWPf7uq3lgtNLmsYORJzvzUi50PG7SMXR?=
 =?us-ascii?Q?+ZN69kt86R2AEprsAsm5ywlDXTeBskDjM+gmkk39BPwfmHuFJHbpyRE3Wwfj?=
 =?us-ascii?Q?LconT3SZjrjFjShvYDoXSZhy0rsOTvlatGRL8J2vtArnWFHYIvVEldfqB07O?=
 =?us-ascii?Q?Om+YmBYi2RlGRFrqYEpR6boQgBtopDDY/Ve2qvTu7C040wfGJI0KO+/iRxbj?=
 =?us-ascii?Q?TzNWbMIoOrZYfmN/YSgHiWdhczeM3maSMDkRLVdNd1I8/vYn2FI19DS6DIKT?=
 =?us-ascii?Q?waXuWNkqHDpzrm46GLDUSeoNGJuJnCQYu6zVWve81LeCSPFdneCkYKMuIIIi?=
 =?us-ascii?Q?WfEdDUSS1T7RVSQ8/tGvi2KjxoFBBxuKJ3jnWHMzW61LkSAYO0yLKttH40yX?=
 =?us-ascii?Q?TtYzuZ/wVjzA+pRVFeRAKKcCD1fuA6Mra6/rb8bFXUA7+WHF2XOa3R/wJmFB?=
 =?us-ascii?Q?DSJDyAPGtV9HUlKQt3OJznaiWV5pNJUkFjqV8rD/6br7v2+eixFD5/DznpoA?=
 =?us-ascii?Q?n4mwYyVd7A=3D=3D?=
X-Exchange-RoutingPolicyChecked: jpFDe1+XZuT4Ul9yO0ec39mHd799H6YUVVa+oHAvAWjXhbDXiP1Ic0/FWBTZNP+hwt2qEjaDWm1ukobFiEpolHmF5xSNPtR7duCX0BBSmh+W+FHyeoWUbBQIRWzl/yKEV7PAtCbulxG/Z3BpJ/8Q+OoFlQIE2tS3prkcEokUYHhbnu9AgcGMzmJfvnleLNeC8BhGsQ+IX5JsHNEACq5emm/X+HLTtyQXSuqPVcGvUHUdfKBlSPOKZIDC6brq4oDAVtWLN1AtWZKt8t19Tu+kjQWdMaEZlGP2Xxo/WA5Jru9psdyi207E/s7mGaGsZBGMgEqHeFt7c4P5RCOSACLkng==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b11cc5c-97ed-4406-f90f-08deace294fa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 09:17:09.7973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pw7y9OVPHUxUBw/If15tH3sL6Fm9fKhUQnUoYG01EnazM2w5X68S6kLfiWwdoc8nqpzDKqJIycPfVUeUCgkZjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9347
X-OriginatorOrg: intel.com

On Thu, Apr 30, 2026 at 01:06:38PM -0700, Dave Hansen wrote:
>I don't like how this is being done.
>
> 1. Introduce this do{}while() loop
> 2. Do 20 other patches
> 3. Introduce a thing that can make it change
> 4. Change the fundamental flow of the loop, to fix #3
>
>I'd much rather have:
>
> 1. Introduce this do{}while() loop
> 2. Tweak fundamental flow of the loop from the last patch when I can
>    remember it. Allude to future failures.
> 3. Do 20 other patches
> 4. Introduce a thing that uses #2

OK, that makes sense. I'll reorder the series so this patch comes immediately
after the skeleton patch.

>
>
>> diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
>> index c81b26c4bac1..9b8f571eb03f 100644
>> --- a/arch/x86/virt/vmx/tdx/seamldr.c
>> +++ b/arch/x86/virt/vmx/tdx/seamldr.c
>> @@ -220,6 +220,7 @@ enum module_update_state {
>>  static struct {
>>  	enum module_update_state state;
>>  	int thread_ack;
>> +	bool failed;
>>  	/*
>>  	 * Protect update_data. Raw spinlock as it will be acquired from
>>  	 * interrupt-disabled contexts.
>> @@ -284,12 +285,15 @@ static int do_seamldr_install_module(void *seamldr_params)
>>  				break;
>>  			}
>>  
>> -			ack_state();
>> +			if (ret)
>> +				WRITE_ONCE(update_data.failed, true);
>> +			else
>> +				ack_state();
>>  		} else {
>>  			touch_nmi_watchdog();
>>  			rcu_momentary_eqs();
>>  		}
>
>I don't like how this is turning out either. I don't like all the nested
>conditions or ack_state() that hides its mucking with update data while
>its caller mucks with it directly. It's just all hacked together.
>
>Defer all of the acking, and *failed* acking to the ack_state() helper.

OK. I'll fold both normal and failed acking into ack_state().


>
>Also, I'm kinda peeved that you copied and pasted the  		
>touch_nmi_watchdog()/rcu_momentary_eqs() bits and none of the comments.
>This is a rather subtle use of both. If you want this to be a normal
>"spinning in stop machine" idiom, then create a helper and put the
>comments there.

Those two calls were added in stop_machine() to improve debuggability.

The issue they address is that a stop_machine() callback can hang on one
CPU. Without touch_nmi_watchdog() and rcu_momentary_eqs(), the other CPUs
that are merely spinning in the wait loop can also report hard lockup and
RCU stall warnings, which obscures the actual stuck CPU.

I agree that this behavior makes sense in stop_machine() as common
infrastructure. But this update path does not take an arbitrary callback
function, so that that debuggability is not strictly necessary here. I'll
drop those calls from this path unless there is an objection.

>
>Also, this is a case where:
>
>	do {
>		cpu_relax();
>		newstate = READ_ONCE(update_data.state);
>
>		if (newstate == curstate) {
>			// can cpu_relax() just go in here??
>			touch_nmi_watchdog();
>			rcu_momentary_eqs();
>			continue;
>		}
>	
>		switch() {
>			// state changing here
>		}
>	} while (...);
>
>is a much more sane setup. You're not paying the if() indentation cost
>for the entire state transition block. You're also putting the "shut up
>the warnings" code out of the way where you can forget about it.
>

Agreed. Will do.
