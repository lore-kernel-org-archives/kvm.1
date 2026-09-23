Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8553954788
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 00:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123934; cv=fail; b=XZGFFJ9bk8Y1TrUwAM7WdG7dXh2Nv8AOYlcxIJUAGqFg4iHpL5GvdVEygzMLceqlzu0vxiju+oFw4PAXOyKGYEgg6hLfm2SWgy8nDwIA0ZH+cqdlFmWIeouY8oXMSM7yAUqFctW5UD6C32I3zlRpZ8XpXhFfQPbkr7JXJB3wN8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123934; c=relaxed/simple;
	bh=Dsc8XPZ6CR9NnOYeP9P/IwAhDoEcXM3p9FyTdmLYWBU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rumjknpm6QQOmEqMaU6c5djBabwpeJ6/7Kz1gTeHP8OnbguLWM5Ehl2UQVsadIRnVvpB6CoRSnJiFMJ3OpD8c4YR6KV6XnnxG2yr00vO43qZGc02T6yGFsghmmB5ywe3jvah+ss2Pq4BLxqwXhLytXD2Tgu+hQRKrAcJxJaZv3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggpkl52k; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggpkl52k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790123933; x=1821659933;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dsc8XPZ6CR9NnOYeP9P/IwAhDoEcXM3p9FyTdmLYWBU=;
  b=ggpkl52kk4crk74vgkuoErqNjhZ+vQx5X5vxBP+kV+3E+lJH9VjRluvi
   4k4GbmMZnY2ZdjwHj02eXBLYpQURyqD6HGqRSJn558X+8t8+dlwdzayqz
   paj65agXmr8rjthzSE2ANZ/FDAtwUD97G9z+HPHizBuYBG3fdMykmGDSj
   gsERkhq0cjNnGTh3oz9t2eCAS87fTh1UEyVzP8f0GBPrakF4APKUSgqAC
   /QVr0rKxGVGJLyKg8rqKf2N/o//47MeqoyN+w2awSi9dql5glO92hx+Y3
   FGP79u+Vo3FeuQ2JuJX1XJb/8Rk3drQhqPq6YOyOB3HrmAAHayfbXWZHR
   Q==;
X-CSE-ConnectionGUID: rbEvZISnRXSBmdew7q0IIA==
X-CSE-MsgGUID: hIiZp3NwRkKEbq5gyBfp9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90646794"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="90646794"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:38:51 -0700
X-CSE-ConnectionGUID: HMTXeTwqROawehjmg17+Qw==
X-CSE-MsgGUID: Pn88+PXbQZ2d3uJ323sIeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="278123156"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 17:38:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 17:38:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 17:38:50 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 17:38:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jav9zdq6pDn3vJoYpCBms+29qf6PI7+9mZrzpFRGUnSIPWZRjO9p4+P+DW3cSG1vVaSRCOTP2AB/++KNso9X+RXOr5jDWcNXEEff8V3tDUWSGcimv5Q3GCi8awYRl1UZUcrljY9iSI6gPka2+znzeO2rW3Lwhw989VoQDljz/Y6iI2R2vmAEFOIudrWEefI6xH6S51NlIqoDu9y7t9UUioYhALldXSLg5XFvcVo0pF67BG7PINaEq6WmyfBX14KEXMfYot64hmyL6Wdq52cCkGneQz7mAvoyUI+zq2XYpzcLV8zm4F936TLFbxs356TmFoOqqjx0KNle1LXK4LcdCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xv4H8/n0PZsrZuDyTPOPOwASoC4hx3yLsWr1pOtYKzM=;
 b=y2Xb+x6ngnVffjt/bkDoGLGCisJwPINmmGteQLSFXLMQN3a4MWMgaWEo2pBW/eEuncdyqxMnB/yGWylb5dewsKfDrkaGn1yhFxIKTF8hWVI0pSoxiSmTq8r1etlO+/HeVP2CRW9lg+HaAYyB8ranxGbXZpOvFIjFekwGkhicLJXuf/cxQci5kl2g9ui5kZw0aHWvVKOUuwPsS5zCaJ7OItYbIoLHwFJe9yiCBPyHGunonDsL3Dz4exXm+7T+kjGkJQ5v8ZjBo0/TCgGt25TzZqhQe7rMuuN6I8YJ/ZsFnwsjQ5MjzR9P4i7eaA+VyeiuaDFpWwnWJzeSSFDQtdT7jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.14; Wed, 23 Sep 2026 00:38:46 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 00:38:46 +0000
Message-ID: <1f481f4a-716d-47fd-97b1-8fa872d39797@intel.com>
Date: Tue, 22 Sep 2026 17:38:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
To: Tony Lindgren <tony.lindgren@linux.intel.com>
CC: Artem Bityutskiy <dedekind1@gmail.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
	<joro@8bytes.org>, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
	<farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>, Pankaj Gupta
	<pankaj.gupta@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, Marc Zyngier
	<maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, Steven Price
	<steven.price@arm.com>, Anup Patel <anup@brainfault.org>, Samuel Ortiz
	<sameo@rivosinc.com>, =?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?=
	<jakub.ruzicka@matfyz.cz>, Vishal Annapurve <vannapurve@google.com>, "Elena
 Reshetova" <elena.reshetova@intel.com>, Kai Huang <kai.huang@intel.com>,
	"Mika Westerberg" <mika.westerberg@linux.intel.com>, Peter Fang
	<peter.fang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Xiaoyao
 Li" <xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<kvm@vger.kernel.org>
References: <aqjNFLv5VrmB_fdx@tlindgre-MOBL1>
 <e090caa0-be97-46cd-bde8-374f2522c986@intel.com>
 <aqoknAli8A0Mc4HR@tlindgre-MOBL1>
 <3ee06a84-2c4b-4b2f-9899-68fc92b6daf7@intel.com>
 <aquL7kNJsjnY0mJ4@tlindgre-MOBL1>
 <b5906521-858b-487b-a262-7a86891a0731@intel.com>
 <aqzS_mCOT6YuHKxN@tlindgre-MOBL1>
 <e2f8b93a-fd42-4ee6-8b74-759d3052258a@intel.com>
 <arDUOl2WPKRxwrZW@tlindgre-MOBL1>
 <da65fe89-e7cf-461b-88bc-4f40f81a6ec1@intel.com>
 <arIRTIm4Q9ElodIX@tlindgre-MOBL1>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <arIRTIm4Q9ElodIX@tlindgre-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0283.namprd04.prod.outlook.com
 (2603:10b6:303:89::18) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|BL3PR11MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f57332-2d90-48a6-d6f2-08df190b06f4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|11063799006|10067099003|6133799003|3023799007|22082099003|18002099003|56012099006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info: SuBESsfqQVui0JIANTgi4lSTp6N61VQUqdjxbFEOFDB6BZ/3CZmssLakmBMZ4Rn/AsVzplKJ/eEV8mX0iOR5vem7UM3cGkR38sLulONx38VciCR9/JgrxqU56t0RkdK3eEuM0+xKACkpP6UV6USbAY6GqiWEo57mAkRb2JWEDTV6Ksb6pGn7y+nBK1HrIgg3SlUS3zyKEDvCPrnXudGHcLOR6oiW6ozcPjXYmwrsWvvgwyzSKwllta36zG4OuxyCSwCHelMzVrPAnUAGN74fmRefvs0vdaYqNb0NkaqSvxIYyKu7ZsAMzwixrPiS5WD2cHSE3AEyWC7QUqJLDxMXhwowO8wvtkqwnZKgOA/1AWyges4u5JYFTIF6UcSoV+1NJODAXghn4evtmxWCQs7BXMFKEqmylkw1qPt3ITpcCSsT0U6z0LKiUWPZQaRXus5sLyprb0OcFVFqNOx4imeO0TsCmXlytgbfZFiLP4ceFZ+xTKnJznv+mJ/wwMy3bsfrepIGm2Iq3mmwTwNhgthB2xpnQTXDHmRW5uNjyn6cNffo1wHZJ9ihev6/qB5XtDF7ZMkoz/MnoRaCJUYTVzCQpSOC5/VO0TXn9hTsc8KD0AR0ACJUDWun2vIkIq5RN/WTa1exLyjBB/N9PgN1cnVZMsOj8WHG1oTvocwqEo6HrVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(11063799006)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWN0QlB6OFd3NWtyZHZRbE9oMThiZnVwTFN3RGNmeExEdm9WU0dUMHd2RXo4?=
 =?utf-8?B?TUdCSnZRb1hhT2hKNm5kcllYaVg2aW9CT0R0S0h2UU9hMUR4VDMvcXhnNG84?=
 =?utf-8?B?cUNyUGZtMS9wQ0FyWnpGVXpNRjRybTN4N1d1WjJhNWJGWEtRM09sbmlEVDlW?=
 =?utf-8?B?ZWw1NmhMSE5oTjFXTzUrWUFLZGtyb0htODAwaUN1c0I3YmhxOU5XRWllMmc5?=
 =?utf-8?B?S0E1RHRIMGtFRjhSbXhlSUU3Q0lnb3JBeWEyZm1VaXJVVE4xN05jbGZZNW4y?=
 =?utf-8?B?dHNWV1lqZ3o1bE5pMkYrM1doZ3MvdlZETWE0ZStwQzhCSkRDOTlHcjRtL0x0?=
 =?utf-8?B?VTF2em1QcXhBNUVCTWpUN1VQK1luRkpodWhqak85Um5BMjF0b25WZS91aGtZ?=
 =?utf-8?B?WkxHdW41QUtJaTFVclRLeVpWcXMxallmay9hVk9Md2dyS0Z6d1RXbFRmbmc5?=
 =?utf-8?B?QTJRc2lkZW5hbkl2Y2FtMDBpS0kvNm1GVDE2bTY4Y1ZMQjNldzNILzBTSUpJ?=
 =?utf-8?B?NDVNR1pDVFlXeUhkOG1aRk1zMG5oUFpwdXZUV3BBZy9hcXZER1h3eEk5U2NS?=
 =?utf-8?B?M3ZrTVpRTjlvRkVvbkZLU0JURmZmb2VnaW5OQWd0Z2NrZlZlOTlXSEdOSEdj?=
 =?utf-8?B?dUorckFPaFpxZlhZQzVVTTdXQVNiN2l0UHhPa1REQVdvNWdxTHR3NlQ0YzJN?=
 =?utf-8?B?VUp6LzdUNkFHekwwdEtwbmkxQTdsRlhOVTRzQ0pQNHg4cGJxdGJVZnc4L2lF?=
 =?utf-8?B?V0lhTzVza3AyclVpNVBvVFREYldHOHNMUVVOTzRNNldhaWRsZEFaME5WVUNR?=
 =?utf-8?B?VFRKT0Z0REMza3NLNUVPUFJTc0pOeXpHYysyb3dvWks3UVh3ZG5RM2ZIbTJa?=
 =?utf-8?B?ZXhnNlp1YmhLbk9ha3diaDJzem1hdHpwNVVHaHNuMW9peEl4Qzl0ZTl0Z3k5?=
 =?utf-8?B?RzIyNUlBWm43bmdmamNmN1FvS1F4TCtHcW4wdUY0TTdzMnpvc3dYQTkzUldD?=
 =?utf-8?B?eGovd1ZmMlgvRmVwRzN1S0RxQ3M3QVFtVStMMExtWklXcG9QZVMydWxNVER2?=
 =?utf-8?B?NWdwMWR6dkNXaEVEL1A0RUVIbnZDYThpNUhTbTQ4Lzhjdm1oU09RZVFnNmJM?=
 =?utf-8?B?emxLSTZPL3dISUlzcU1HeVQvREdiL2d2bVg2YVo0SVlNWUhVUHJmaHdFM2Vq?=
 =?utf-8?B?eGFGTVM4dlVkTEczakFNQmlnYm5FYmlvTjBadHhMQXExQVBiU3dJTmlRZENI?=
 =?utf-8?B?Y3V0Y2lSb0ZuemYxYkhHNnE5VVJQcUNramxCNWpaTWJ0dlFTWDVDUURUNndz?=
 =?utf-8?B?Mm44VnZWVENPblNKRXMyWVZxbUFTa1F6TFFTdVBtbE9rVzlHZW56VVlPcFFi?=
 =?utf-8?B?ZGhYdzhXbER3c3U1MnJLcU9JNzhEVkd4NlRlakQvaUtGMW5saXc5b0IwWThV?=
 =?utf-8?B?L2g2K0U2c2ZjbmpRTy9PaHN2Wkh4aUNhYzAvSHdEOEdVRmp6MnhWS24xc0tR?=
 =?utf-8?B?VkthOExnSG5Ka1Vld25aR0ZZL2ZpLytJYXVRZ1NSYk00T3BZa3FvY2NiS1Y5?=
 =?utf-8?B?ZmpzaWNtUXJvMmQ0NncreHJIbWRzdHdGTVFrbSs5b3IrRTkvT3VONkhmZTJS?=
 =?utf-8?B?OEsxWFlsS0VaVStGNVU5ZHd2Q0JqM1pLYnhlc3pNTzhpUHJaRUVnamVTZHox?=
 =?utf-8?B?ODg2U0preXZiYVFteXkwOVlGVE51OVY3L3NaNEdJUlNvNnl2bjMzaW1DaTRK?=
 =?utf-8?B?WlB6Yk1tVy9ERlh3Y2VBVkZ5SkxIeGY4d21yS2VGa2ZCUnU3dDJacFEvTHBh?=
 =?utf-8?B?RGFiQkg2SkZnZVdSUU51ZkhROFlOTktJbWZ6VFo5MUI4Q3htTlFPZzNPMHRY?=
 =?utf-8?B?RFdJOGIydGp3ZFV2OXdsMDA4WDNaaGQwSWlLNk40RXRuT2thbk83OFo5K0Q2?=
 =?utf-8?B?bnovMkx6Y3BzUnljbDZjUWJYWUpLdzN2NGFXL2VYM0htelhrYmZ4bEU4WmV1?=
 =?utf-8?B?eHNrWGRIQVFsSDB1VUVvbC9kRk44eFkwamxqaldzMmxvbkQ0c0hLWnk5KzB4?=
 =?utf-8?B?cGlKbFdQOGRrMUVvSjMxOGRQcHZ0Wjk1M0llOVVlU1dFUVN0THBBQWF2aXhU?=
 =?utf-8?B?ZS82UWpTUnpwZ3pyNHJXTVhWNWxsWkxkc1k5a0tPNE04SWRNa3VhTk1Zakhn?=
 =?utf-8?B?Tklla1hQNVJxejc2RVF2YlRpakcvZkl4bml6WVg0ZGdzazV3aC9LSExWVkJK?=
 =?utf-8?B?Um1CWnJ5Z203TjlJYTJ2bXNVbmx2ZFBpbXlyWHUyaWVlUnRGTlU0eWl1KzNO?=
 =?utf-8?B?MkpkL2M0Q2pvTThoQW93MVFva2ttNVNKTFRVanZCSVZPZEtITW9BUT09?=
X-Exchange-RoutingPolicyChecked: U43QLswlZhFCitFZ6HPNFsTYSRcdQgdNa1loTTcmxXaLy3ww1CjEJjHwNksIO9P8gjqMb8jlrF6WMkilOBmhrp1OmhlqdqJqvnIoPq8Zv3fbJI6yXADqtk1uWFe03qpwGPY9QcttgG4hrgcYCRcF+JvLcot5ZXSvdxe4zDrPtetlQt8y56MIuOJQpofre3bqCNsN4AzXnFpgvsXb2sRWehA0NyZzBEyxk0r87uu/Ep9bKEY77tworx9C4KfoslkPwWBMl1+Rxfh9QvqTkYVsOI1u2WJbQc465yA4P1UDbkvz985uxyMZH8pHDwtJdbEeApS11+hu0y7E3ffbPG2qIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f57332-2d90-48a6-d6f2-08df190b06f4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 00:38:46.4155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtwtV2RU5ddDnwUzp2oPECLYUFKaEIK6/tbJYPJmUXCL+F2eIeM8j6Y5ZQEP9U356Y0iQVT8MYmXHRRrJYKHdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6435
X-OriginatorOrg: intel.com

On 9/21/26 10:25 PM, Tony Lindgren wrote:
> On Mon, Sep 21, 2026 at 08:57:45PM -0700, Kishen Maloor wrote:
>> On 9/20/26 11:52 PM, Tony Lindgren wrote:
>>> Then for KVM tracking the role, I don't think we need it with the two
>>> above. The role tracking can always be added if really needed. Any other
>>> opinions on this one?
>>
>> I do think it's useful for generic KVM to track this role (1 byte).
>> - It lets _TRANSFER_ style calls dispatch directly to import or export 
>>   callbacks based on the role.
>> - Even if we don't adopt the _TRANSFER_ style, it enables generic KVM to
>>   reject mismatched calls, e.g., KVM_EXPORT_MEMORY on a destination.
> 
> Having KVM do generic checks on the calls is a good idea. There might be
> a simpler way of handling it though. Rather than having KVM track the
> migration state, how about we add a function to check for the migration
> session state from the vendor code?
> 
> So something like this for the states you suggested earlier:
> 
> enum kvm_lmstate {
> 	KVM_LM_NONE,
> 	KVM_LM_SOURCE,
> 	KVM_LM_DESTINATION,
> };
> 
> With something like this to get the state from the vendor code:
> 
> enum kmv_lmstate kvm_arch_get_lmstate(struct kvm *);
> 
> For x86 it would end up calling kvm_x86_call(get_lmstate)(kvm) and for
> the TDX specific case tdx_get_lmstate().

How is this simpler? It trades one byte in a KVM struct for a new generic
enum, a new kvm_arch_get_lmstate(), a new kvm_x86_ops entry, and a vendor
implementation per vendor, plus a cross-layer call on every command just
to learn the role.
Directly checking a stored byte (0=unset/1=src/2=dst) seems simplest, no?

> It would allow KVM to do the generic checks for the migration related
> calls you're describing. And having KVM start tracking the state can be
> still added later on too if it is needed.

I think we'd need to pick one way or the other before the UAPI settles
if we want generic KVM to reject mismatched calls. OTOH if we want to
defer this generic KVM validation, then yeah, it could be settled later.

> 
>>> The transfer direction is there with the EXPORT/IMPORT naming. Maybe
>>> just let's keep that naming for easier readability rather than try to 
>>> switch to TRANSFER style naming. No transfer direction flag needed.
>>
>> I can't say I have a clear preference between EXPORT/IMPORT vs _TRANSFER_.
>> If we keep the EXPORT/IMPORT naming, then consistency would arguably call for
>> splitting MIGRATE_CMD too, which makes it 6 vs 3 (or 5 vs 3 against the RFC
>> as posted):
>>
>> EXPORT/IMPORT style              _TRANSFER_ style
>> KVM_EXPORT_CMD                   KVM_MIGRATE_CMD
>> KVM_IMPORT_CMD
>> KVM_EXPORT_MEMORY                KVM_TRANSFER_MEMORY
>> KVM_IMPORT_MEMORY
>> KVM_EXPORT_VCPU                  KVM_TRANSFER_VCPU
>> KVM_IMPORT_VCPU            
> 
> Agreed we should split the MIGRATE_CMD too. Probably the number of ioctls
> is not and issue compared to following the KVM style and better
> readability. So my vote is now on EXPORT/IMPORT style naming.
>  
>> I guess the main benefit of the _TRANSFER_ style is reduced duplication. 
>> Each EXPORT/IMPORT pair takes the same struct and differs only by the role
>> that the session already knows. Merging them gives one entry point per call
>> type and lets userspace drive both ends from the same call site which could
>> be considered a win. It doesn't reduce kernel code though as the top-level
>> handler still branches internally on the role.
> 
> Yup not much of a win for the TRANSFER style naming.

Yeah, my goal was just to enumerate alternatives for consideration.

One other benefit of KVM_EXPORT_CMD/KVM_IMPORT_CMD is that the per-session
role is implicitly conveyed - in other words, a successful KVM_EXPORT_CMD/SETUP
(for e.g.) would indicate that this is a 'source'. So, we wouldn't require a 'role'
field in struct kvm_migrate_cmd to explicitly assert one during SETUP.

> 
> Trying to summarize again after we sorted out the direction flag issue in
> the transfer:
> 
> role            per migration session (cannot change during the migration)
> direction       per command, EXPORT/IMPORT
> hardware state  set and tracked by vendor specific code

The 'role' and 'direction' as you define it above are essentially saying the
same thing - a source only invokes the vendor's EXPORT call, a destination only
invokes the vendor's IMPORT call, and the role doesn't change over the session.
If a destination needs to send data to be consumed by the source, then that
still invokes the vendor's EXPORT call.

> And checking again against the dmaengine analogy:
> 
> Compared to dmaengine, the migration role is modeled similar to the dma
> channel configuration.
> 
> The migration direction with EXPORT/IMPORT is modeled similar to
> dmaengine_prep_slave_sg().
I'll leave the dmaengine comparison to you, I don't know that API well enough
to map it properly :)
