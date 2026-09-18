Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF325B0BD
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 04:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789705961; cv=fail; b=AXGi9yTHOkRXF+VnEsQSc67X5d/3vM3dxuDRav9bIAVpgZxOobhOBpAe9AlcnyNznhpcFvJOSFazpwxcYTJcIHykPhziFh9IeNkwPddsCpZPW4BeQUzVw7We1LcLNCCItd0XGA08/Fx/omdlS1l79F0xmEL/twse6VBPLN5GnHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789705961; c=relaxed/simple;
	bh=q3oOEGtAg/NRaevI3EIFChNWT0EQNJZHmkE26rrUU4s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Takx+W+KiRlZuXt/O9c0JuHaPzVWfdPmdKTs7bJbd8+f/EKTWvBbZXe9BWca1b3GkXyP07ofn8/nSD/rXjoZkb8eY3oOQnnZp6ON7mJdedroKwJ572+BsLp5NBFiWxDPSzAwUtM4SGucZoegCHEkyoKw6kROzXaVbm9CPyo3I58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fAQc3MD8; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fAQc3MD8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789705960; x=1821241960;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q3oOEGtAg/NRaevI3EIFChNWT0EQNJZHmkE26rrUU4s=;
  b=fAQc3MD86msor+H2NAQCvNtyHKNftZ1i6+WcR1YJVtGmSMyyI2412VuH
   a4wA4hWBs0HO40TjSlORaUEJ3WZr8OCbz+U/xOqY39+ZquiXN/btu8iH3
   nN48xQVdroMmtlRWw2AbCdNAqxoxpN4cN4U7hL5QLWGgqC16wpgJKRB3c
   5DUrIazFx0+UHyGKDuwU2fsYJkk1g8oZ1YLfkqHXFjmx84sZMuaINuIPb
   icBINoIAve7Hcb48O7CpYoGEwVFxMFJUBSO+jY5fOKpxbuk6+G5WAg2el
   8UFKgAhucYhNokXSMYdxNlwluoBg5aFy4FBrF/lie5iJR8AA7mAMeE5P5
   g==;
X-CSE-ConnectionGUID: i+sAIcY2R/+y5HCM9kqSyw==
X-CSE-MsgGUID: OcLWfiA8Sny8m6EsqgpcnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100848709"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100848709"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 21:32:39 -0700
X-CSE-ConnectionGUID: KceHz8BkTTK3rY2fxD0veg==
X-CSE-MsgGUID: O19JmjfKQj++tWWC3ogvkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="279426826"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 21:32:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 21:32:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 21:32:37 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 21:32:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYzrNY0dJBNNNpd5uzueQKysaObkW/Prqob9Pa9hANfNJY6qb0q5gtO3OkAPkGsdLrOLZ2V2dYWrp0xZrP/bHU6hV8KU2uA+dLy0e+be+NTBVKcwKMS/o+xXD8qXloMEzi9ashxAmVFNcvVSic6uzBOZMZ42C6WfVRwkVTYr1XfE9ECLa1vLCJ5orPvfbWQkfJ5iOwIJL0Q4wH91frj9xbZo2euywxhEvZppFwa1aqXh5kQ6jnPiK97PYBLeuQdZaGP5CSDGL3fbvv1BcRhSeI6ZpTzBpOWVBMMUOAG+anvXSrL1dxDwug3fDtzdriHA/wxdSwiIVSRWiA+SrB8xGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jyllJsefoJtuXjXwqC/9RU/nIZ4C9BoxW6dc4e8Msw=;
 b=QK463ljSJ084dpNWgBq35xzRAIq6lDawf89SXKs699X4VU5xwDFLLAGZ9y825Rj1q7R0rN7XMdNnd0uTaVmm2sXKmz71B2EGQHO8aWm7bdf6e/urFGmAnt+zM3GStAV0o3qBnRjKBNWj/JP940Q0QY7/E9JYG/AzJqetN97HVPPtEv/Qz/jfkkAwNGY8KToLI8qUpUtapYH9iv3wfk/iJ7xRwpFoUhUfKvAQemJJSCcY8YBSf1Sg4khO+wl/LSa3xgr8xJJ5mdIZPfOFIDjy3LbwJ8BTQ+0VpK3aWJHIo5jkQNStbvNoARnnVEkK4ecTfRkY3IfxBQCX31cCiUSQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.13; Fri, 18 Sep 2026 04:32:26 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 04:32:26 +0000
Message-ID: <b5906521-858b-487b-a262-7a86891a0731@intel.com>
Date: Thu, 17 Sep 2026 21:32:23 -0700
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
References: <aqEDQ5Qrv724gGzN@tlindgre-MOBL1>
 <0cf5b79e-521d-4c7c-97f2-673c51d42bbd@intel.com>
 <aqJPLEX51DSCF1zC@tlindgre-MOBL1>
 <be09b02d-c993-40ad-a690-753a7a50677c@intel.com>
 <aqOCPVoFAFMv8ZYo@tlindgre-MOBL1>
 <085c28db-31e3-4249-a9be-a2f9d7156719@intel.com>
 <aqjNFLv5VrmB_fdx@tlindgre-MOBL1>
 <e090caa0-be97-46cd-bde8-374f2522c986@intel.com>
 <aqoknAli8A0Mc4HR@tlindgre-MOBL1>
 <3ee06a84-2c4b-4b2f-9899-68fc92b6daf7@intel.com>
 <aquL7kNJsjnY0mJ4@tlindgre-MOBL1>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <aquL7kNJsjnY0mJ4@tlindgre-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:303:b9::31) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|MW3PR11MB4748:EE_
X-MS-Office365-Filtering-Correlation-Id: 637eaa95-2e4e-420a-46b2-08df153dd756
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|22082099003|18002099003|3023799007|11063799006|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 90i2UBFoIJUsSj3TcU3zR08CycRgPM8oIOzy/4/hYodYpn+adYm0/8SOMoeMVfJJN3yEIp6V4rvSAuWxTwH7WXbqWdKND74vKsjSLGXGSh5JdJHOGMWgz1+bmo+imA92ZUNigVv3MAlRzRN7tOXJXJLqtraC2aqSy8LEUXfXkUslKabLE9wVZzZC43AxIpjQ+EQBDy3+Kb/nEOIDexgO4OdSppUD/neX01zCkOldHzRN/SMpguknHPceaVVB7oJutmDYrcKfpIxO3p0w7D/jbaYIWAgJLzPYpvQLFqyFgIUny5KKKlCnMs9kyi/EMcVz6pmYO0tG0qOchnLyAXaf/wuBLcY7f94Voj0qCMUCHHSRtJX/038G4Pyuh93IE1OlDP8deja+4jjSshraPE5fqqHFkh70DQpcXVYGnjDh1Uj0WQmv/Q675tLRuUB9lwLi5wfmi7zpVdttPA+qM17AvhFApA3zqt5vnp0yMbpX03Gzfm35qANI5TMmCH5zdqxo0DyFZBUKkrvKKuBRpemZwbgPq5ILb//S9rtSXlmrLUiwS9xvV5xQUMeoKxHTLEcjHOWOt3CBqEEYjLoLeDMwf/M6Roqr0e7xR06eigfXL5JxkL6KzifGWq6aBrbFBiV71rI1PtoW8lsChnuSej0w5PkFosQTvboV/Q/TTcy6Ak8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(3023799007)(11063799006)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGpReS9RK3F0RUtiN3ZzRngzczdNSS9mY2JZbXVsS2tKNElURmltcVhJcW1F?=
 =?utf-8?B?TFBZLzVOWUlXd0xPZExFQlowbXJTS1FLN0RaNVNIak9hWDA3bEtPNFI5MVR2?=
 =?utf-8?B?RmNqcW9wb2NLNEg5Rm9SS0pQajJJckkreVhzL1dZcXNZVmN0REdpdkVITUZI?=
 =?utf-8?B?YUpRbXZkQ0ZlcHJaaFYwWG9UYXljTmpYeGhHVVNqVjNLNmtaRkhiNjlWOWZW?=
 =?utf-8?B?Mk5ITGM3M3dYekJOUnlrMlVzU09tbzg4ekQ3OGFNQ1hhdmRGUSsxMXNLVyty?=
 =?utf-8?B?RkkxL0s4dnBQUWxXcW9zOVB1TzFsTGJpdFYrZlJRc2N0MERwOVRUdzY5YnJh?=
 =?utf-8?B?L0dKc1JsQkpaU1pEeVg3L0lRblNNazJYVWRSaTI3QzEwYXVKZWthbjRPMXFB?=
 =?utf-8?B?MkVEd0JSMFBxVURoNTk5cHkwNnB3OHlPaHRzR282V0g0QXlJTjRCRmxsMjlG?=
 =?utf-8?B?Q2xma0dmY2dPNWp5ejNBNEJ1akxSVytjSVYvNEcrU1JvUDV0MFFIRDFwYnFU?=
 =?utf-8?B?emlKTVdUZE1BNS9XN0o0NkJXZW1VWkRPbkR1MGZRZHNSaWFJRE9QZ2piM05Q?=
 =?utf-8?B?YitPYWxkMzlhV212MlVOcnNFSVZidHFxSWM0UDd1SUhxSjI4L2xoc3RybThk?=
 =?utf-8?B?UmlKMHM4RWlPWkwweXdZd0xwVEVjZEZnT3V6eEsyemZjc21zWjVZWS9SNS85?=
 =?utf-8?B?cXRWSTNjRVNLMFFxdHV1OFBLVjFsYzNvTnFRSEhCVlRsTm5mSk9oa25QKzJO?=
 =?utf-8?B?MDFaS3NZdVdzNUQxcytPakp0QXlzYk5pdjdISWd2dklGcU40eGZLcnlMRmRz?=
 =?utf-8?B?b01MZ3pPWHBQa2I4aFFsdFZUVkhOU2VqUnN5bWRGdDU3YW1KcHBaSEl5RDRw?=
 =?utf-8?B?M3FZYUloRHZpazdnU3BtdWZmdi8vaXQwdm5hazJOVDNCRDVxaW9BUjdzcEFz?=
 =?utf-8?B?L0RSeHlOY2hpTmI4ZnVxT1lqYVpxTy94UVl5b25RMm0yL3NRenRvQXBoSjlh?=
 =?utf-8?B?dktYMUd5SmxpUHhHMzA2bUJXU2hwamNzOElaRUg0M2tJUFY5M0dmZEt4WU56?=
 =?utf-8?B?ZVVwVVFZd3IzT0F2cFRHOE5VODBlZ1JITDlhWGVQamhFNnNnWkZRRERxc3pu?=
 =?utf-8?B?T0NNYzNHRTBLYnVkTndBcTVGOXlXUmtJeCsyOUF2QW1WbVNad2dML3NwdDZK?=
 =?utf-8?B?aGpTcFVWa3JsdDBsVXp0M2xvQjMrSktsYjBaQktrT3lUQ2VxY0drbUNKYVVt?=
 =?utf-8?B?eWRMZ0hCaUQwUURtRmxaK05LMXk5cUJiVytGWlAwYzJQVlIveE4rYjR2ZlZv?=
 =?utf-8?B?YVRjcy9lbzBWR3NCaE5Za1BTZDRVWlc1RnBRNVhrNVJ0VmlKSURMWWp3MkFr?=
 =?utf-8?B?cEdKSzY0Y0V5aFp1Qm95cDkrOUZ6Ni9MVU1wR0V2TW5TSjlWcVV2TXVsQ2dR?=
 =?utf-8?B?T2dOcnFmTStzZWZHZnRSd2xETytTUmlRVFhSc08xREdXV0xxZVF3L2p4dkFr?=
 =?utf-8?B?aCtlbDRhbzVjLzlzV0g4dWJFWHBkdFdWbDF5R1ZlakpQalpHdDFUU1BnVWJ5?=
 =?utf-8?B?UW9KemcvUE1DT2QxalgrSDlyeXMzYkZLclBZK0NOa2U4SmVmcXlTaGRHNE1B?=
 =?utf-8?B?b1lpMHl0THp2ZXRzdVF5dU9lWHJyTVRxRlE3dUR5L3NVbUFlelkyS0R2djFG?=
 =?utf-8?B?T3g3ZmwzaFVZV1o5WHNwbUtsSnNKUnN0QU5Ud0RScTlOZm1lUHQ1ejNGQk1V?=
 =?utf-8?B?WUhBcjB6R3htMlk2aGlkQi9RRFZQMnB1aWhRSG9rUU5QU3IyTG83UVQyKys1?=
 =?utf-8?B?aVZUeHdMRUszQ0JDY0tjYkpkWlRRK2dMc0tZdVEzenB3Tkdjd3ZaaWdtQk5w?=
 =?utf-8?B?MHU5TUpEa1BqSW15dXFIMksxZGxQb1VDS3FQYTNIS2VRb1RDOHBRWWEzNjI1?=
 =?utf-8?B?aUh4c093Q2NERWt0UEV5MXF5QXNCeGN0UUNWVTF5N1ppMGxudGpGZStya05H?=
 =?utf-8?B?N0dTQ1ZJaVRvcitUN0xWMDhsK0loR0JTa0RhYnRGZ3FoNHV5eEIyTDBvNGta?=
 =?utf-8?B?MHZ5VUVZaVgyZ0VZZDgrWDhiSnd5WUZnOWd0c0hUek5sRTBSVVA5emJ0U0xS?=
 =?utf-8?B?bnJZU1hQR0dQdkltbFNFUGdvK0haOTlqemFtSEhsbzFLSFlJYTdOMEdkNWpG?=
 =?utf-8?B?SU1JVXQwWUlVcTkxZG1yRUtwdmE0cWI0cDA0czFPOHRkRVVUeGt3NWJlbXVl?=
 =?utf-8?B?QUJRc3VhR1R4dUZUR0ZrZGZhcjIwck1KTDRvcnRRSStTc2RrZ285WS9ac3F0?=
 =?utf-8?B?UDZKL3NiMGZMUTBMdUF1SHJGUjFRWGVZa3pGblBMcm5EaVFOWWR3dz09?=
X-Exchange-RoutingPolicyChecked: lbzNPd2n3DZFX8cIT6KnTwD1+t9CWlv+4nAhHlUxRlRsKduqOgxOjI+r70pJazBQuwFz//WvxAn6WfCyBXHs+QyX1wiJy5o25ouS3smXs2ybBu4ZKmO17LqzhtzFSVHz/EyFOdg8Xg384BGIXMyTkdVr3Wi69np7gt+LaliuOuTNA924uo6TqD7kzgRrKyFX9NHGrRZr0hUG0s2FEts/Yt8q3ajrSODOHLuJewHpBfUywBjLM3LjPr/BrPj5f7j6BOkztn2kwIF1Fa8USh+i3LqEsfa/QfGW/ohDVwG6JSfG0X1XAPdcrRJnBMXHb6HQL4f7PJU0xgTDk0KDbUrKRw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 637eaa95-2e4e-420a-46b2-08df153dd756
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 04:32:26.1785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMiUQoTPsSXx5oq09/c/HAT5hEBkTsfm12AIf6MPpGWxsUoAgUm4CabHVDe4jUjH4gaMutDINUU5Y7OHyhFQJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4748
X-OriginatorOrg: intel.com

On 9/16/26 11:42 PM, Tony Lindgren wrote:
> On Wed, Sep 16, 2026 at 08:31:32PM -0700, Kishen Maloor wrote:
>> On 9/15/26 10:09 PM, Tony Lindgren wrote:
>>> So trying to summarize the common flags for the role and separate vendor
>>> flags:
>>>
>>> struct kvm_migrate_cmd {
>>> 	__u16 command;
>>> 	__u16 flags;
>>> 	__u16 vflags;
>>> 	__u16 reserved;
>>> 	__u32 reserved;
>>> 	struct kvm_transfer_buffer buf;
>>> };
>>>
>>> Is the above along the lines what you were thinking?
>>
>> No, I was suggesting a 'role' field carved out of the 'reserved' space,
>> like this:
>>
>> struct kvm_migrate_cmd {
>>       __u16 command;
>>       __u16 flags;
>>       __u8  role;     /* 0 = unset, 1 = source, 2 = destination */
>>       __u8  reserved[3];
>>       struct kvm_transfer_buffer buf;
>> };
> 
> OK yes thanks for clarifying, that works for me.
>  
>>> Ah OK, yes that would also tell "the hardware has been initialized to a
>>> certain migration role". That seems like a usable common feature.
>>
>> Not quite. It tells us that userspace asserted a role for this VM's migration
>> session. Whether a TD was created for import is a separate, vendor-level detail.
>> The generic layer only needs the role to reject a session that never stated one,
>> and to pick the export or import callback. That callback then knows which side
>> it's on and can reject an incorrect role (e.g., if SETUP asserted dst for a src TD).
> 
> That's a good point, the hardware role may not be set yet.
> 
> I'm still wondering if there is a need to stash the userspace set role in
> KVM though. Likely only the hardware specific code can properly track the
> state of the hardware and adjust to the userspace requests. Seems just
> being able to pass the role in struct kvm_migrate_cmd should be enough?

Passing it in kvm_migrate_cmd is enough for SETUP itself, but the commands
after SETUP like memory/vcpu transfers still have to reach the right
callback. So KVM would need to remember what was asserted so that the
generic layer can dispatch to the export or import facing callbacks.
We've been sketching (on this thread) an alternative UAPI set
(3 vs 5 ioctls) for consideration which this stored role enables:

Proposed in the RFC              Alternative
KVM_MIGRATE_CMD                  KVM_MIGRATE_CMD
KVM_EXPORT_MEMORY                 
KVM_IMPORT_MEMORY                KVM_TRANSFER_MEMORY       
KVM_EXPORT_VCPU
KVM_IMPORT_VCPU                  KVM_TRANSFER_VCPU

It's just a record (1 byte) of what userspace asserted for the current session 
at SETUP. Vendor code still owns the hardware state and remains free to reject a 
role that doesn't match it. It is also what lets the generic layer reject a 
command to a VM that never set up a session.




