Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5967E36B04E
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 01:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789090817; cv=fail; b=WQdDQtctoRBUL9vXtgZ0C14rs3l0KjVQuOvsMxbOtKoJQlbLI4q5n8rRcU9bLzMYB0hpt3jbKt5LIw3v0MvCyJQvyk/cfXmy1cQ5f7L1U4NRbYaROICfBh3W/n+R6wgO83O1Uoi93eDYhc1sl5wdMz6lnq5HmE1HFNK1PTIvAJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789090817; c=relaxed/simple;
	bh=+qqI+h3gSHOvx244UimdE3PdVIqnjarrXUc/JHjkq4M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LKNesqWPGYDp/kWS/YS/VZg66fJM4kb+UtLLLCXkJn10D8xWGfvRPAevR0wp65zhEJvXwAweFGHvNWr64nNK12jVDiEvmgpJlDIfPsZESZFqI2X1OSXfPLfzcNgsSQNS0TZckSg04PlJfOaIh+eMY6NlxLoDUuf2gQrwidFB3X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iymfem08; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iymfem08"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789090814; x=1820626814;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+qqI+h3gSHOvx244UimdE3PdVIqnjarrXUc/JHjkq4M=;
  b=iymfem08qnXqhZOtdVTc9eVVpL75fQbWBlW8acVkmNqoCftUEnQdq+bE
   MsIhN9yprMGhLC3iSrctpLGmQZRt1Cwm3mRAhW5pqicosxh6+0EzeAXXL
   aJWi+eBajjf+1Mv0EZCwP/nAkt9JytovksZC+0fGlqur5u+1ExQfdDIz1
   ATGokBdPp5rwTJAzKAFrfW914L2lLgr+uTgcGAOY8/YDU1VyfsjFR9+Wr
   5EgI6Qj9FgSRpzx8hsfeX82asMPZLQVq+iLNbWJ+UDWv2Bdeb/7znhGSn
   I+M317O1+6AI6CwjfZm8ibdP81PY8P9mfVssaAG3XLcaUtugqt44rf5Nw
   w==;
X-CSE-ConnectionGUID: OVd/fozcR7SusgF7MT/ZWQ==
X-CSE-MsgGUID: sjW4G96ISMmn/xZQ1I3xag==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89318727"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89318727"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 18:40:12 -0700
X-CSE-ConnectionGUID: e2sN0CWRRQm+Zi2O6oPvQA==
X-CSE-MsgGUID: vXcaMASaR46at/ykg1ekuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="275311856"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 18:40:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 18:40:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 18:40:12 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 18:40:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jp7USUDU7FUtOltfsQO3URMVIF8jb/OIFx2q48MdALNCNrhozcrC/A0q99D0Zdae2tjNDTi3XFTwlzdsungo/vzhxobJ6lMGr/HZ3pB77tA55AwoKCsXrsMcrldU6qroTMvhcl2914NbhIAGVyJ8wXyP4tHMRSLFLn93HXaWPEeu817Mma6Uvu6+0NnoMmUOG5fl7XukxK5nbd2lHRZO8lBI9+O+AsN43FoDG7qp8RxF5ofkz0xdYH/zsMXeTzkwvWSwPeDlcbXuiAvPzw85xHwFNTdS4gn+z5ba1zbMAWRIGTpiLSAnzQx9orAe3//mYXV2T1eF/gwz9sn/oSM74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEpACy4E7gO3iwqkbjibBk3fYu264NRqYkRGjClV9HA=;
 b=HVDCMPECpIhT/5yP4+GxezEDulsdX8ih0Jy04pyKKESfOjMGHNOWM92QVKQZ35mF8YLNgxattvNFFUcxR/EPwg1CiuKHXOnKx4hlJTtAecNIuTCnzXhqwziEFawi+EXAk0b/QS1VEQPNkk8gbCsGcrxZi1nDsmMJsZE56/TOkBbUhvY6c8H4ki62f1fFudzLz9Z2Yz0UaU+MX/qn8bINU0XifLiK0sNDLvuOdm6gAek8JlkXZFRNuBDcWloBdfCxcojdEMn3MeafXCKmuXsRrdiS0wbbagLzO900ygXNVe3upRDProaii5/2lMnspoMhy73zqieGfI6OHeK6SmQBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 DM4PR11MB7349.namprd11.prod.outlook.com (2603:10b6:8:106::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.9; Fri, 11 Sep 2026 01:40:08 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 01:40:07 +0000
Message-ID: <be09b02d-c993-40ad-a690-753a7a50677c@intel.com>
Date: Thu, 10 Sep 2026 18:40:04 -0700
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
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <ap6loazXtvSCqmpR@tlindgre-MOBL1> <ap64dFXpiDb_Hqxl@8bytes.org>
 <d25d652c34dedc209ccb3b758e7f624b9125eee5.camel@gmail.com>
 <ap-SihGd0fk02QV8@tlindgre-MOBL1>
 <4c07e70e-7639-4141-b602-1c09c9c7510c@intel.com>
 <aqEDQ5Qrv724gGzN@tlindgre-MOBL1>
 <0cf5b79e-521d-4c7c-97f2-673c51d42bbd@intel.com>
 <aqJPLEX51DSCF1zC@tlindgre-MOBL1>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <aqJPLEX51DSCF1zC@tlindgre-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0292.namprd04.prod.outlook.com
 (2603:10b6:303:89::27) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|DM4PR11MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f880656-b12f-4eaa-b650-08df0fa59c2e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: vE8PmvDMLr96QXuqPD5M+NS01IQ8GeVleBaT4HZukMt4aFV2ccLgV9c3eJaIOggXstsI4HsF+DJwrHGCqHrnRtU0TEIzagyabJdh3uNDG048nCKb2cQoJfayLT+mS+rFKgxi1ivO4spLfCQm3F++STMo7ufSmq/Lc4iKmRNBqN3ByzyDr8LYSRMuIawGg4VKO7tFmuSVQCZonFkAjpGyHSlC5m+8WhWRo9PNAy3xSkZ/BiF8yEWSV82lVR/5+Z4JvRlAnV93gNkYZXa2jO3khTHOdUHqjbMu085O8gO0G8nS7TbwgV+9vBQlHNyuvdscFGDFEBZAPaonBfFScC0kQ27dGh2Vmrryakwku9OWcgBvSezgEFkVhOmyErx0ceqWFrqtNsqQvG3wpwF6Oa+l71osXlLSP+zGpxAEhONVyU1y0I4L4Uff6T/NIFBKaI0fbKGTdM3/YY6ztQECR+rM1WE/GNv701//oH6P+r/mlOEKDiGKxLFXBtVSSOQnU9Gl+IzuWahMiDpewAGdPQiKpycVIA3ADOAmgF2GBfqQR1Di8b3GRB3EZfcW0GXn8mu1g2CyVz677MiDdJvJeySt1FDl3ItZKQ6uyJTiwNgK8rp1aL9Ix/zJN2djquP+sQwqPCrFacizCymz7d6pdK/ux6bDEXyOO+DoB7a31z4lR8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emRQWER3Rks0TGJUQzZvVkFMbVNjWUg3N2h1SnZaU1lpSjZyL1BqM1VHQkxo?=
 =?utf-8?B?SDgybDlKNFR0WndWdGUxV0hoYVpQVWNaMVFra3hTMmV6K2NnZU5uWjdmbEtl?=
 =?utf-8?B?VHNSMklrSEV3TTBqcjVzT21UN2pIQ0tPbWNvZHFIcjZhLzU2ejkzNFlLTjFX?=
 =?utf-8?B?SE9ObjFJTWNGM2puYUFBdlB4ekF4Zjl6YStBemt5elNhdHM2Z1JqWHNKTzkx?=
 =?utf-8?B?TGQxV3gxYUpZekdNdGs1NlBuOWZCVHlJU1g0VUhYN2NzTFR1aUxZVWlTbTRH?=
 =?utf-8?B?cHc3M25LTk5nT1BjOWhDVXZkSmdLREt1Y0lCQ2poa20vUndVakpNWUpneUdS?=
 =?utf-8?B?QnFxUkF5NWw5RStvZXpPYUdocHlvdjJsVHN5U3pib0x1Yk45Z3piSWllbzBQ?=
 =?utf-8?B?VmVwdDl5bExUbVB0a09iZm5acnNiZWdsbm5zT2I5azRqMk9nNk1VRXhiWTda?=
 =?utf-8?B?bmI0c3RFQW40WkNlajJ3T0pQak15M21ldzJ6djdMZzRnVnpCL1VQYVVuTUhI?=
 =?utf-8?B?bFNqNzQ4REJYTzRIR1pHQnBJNUVpS3JlMkhjWU9OclhRSlJudTVhNXZMUTJi?=
 =?utf-8?B?MndtdjNraEN4OEFnc0owNzZzMlMxZmZybGJUalRuZU1GYWUzWk9rYVlUMkJB?=
 =?utf-8?B?OW04eFU5WmNSM1BnVEVGSEtwSmhwRzJSRVp0U0RjMVJPWmNGeXRsRmtJTStQ?=
 =?utf-8?B?VzBMS1hyanZKYlNvNGZhUkNjM21nSzZYUCs0dEdCN2lJRWtBWGdOSStXcjlL?=
 =?utf-8?B?YjJXYzlJSXJ2dmJIdVRZTjZIZ2ROUU9QaDhDYmR3QTBpSi9RVEdMSVE3MVZh?=
 =?utf-8?B?Zjh2M1RBSFFRRER0NkZrMENLM1hRVnlwWGw5OHlIYkMvdTVaWVoyYTRFcmVT?=
 =?utf-8?B?S0YrV1JWd3o5V1k0bkZkOEZmSzVLSi82SWR4RGlKdWh6emFhOWJGbzRiTWtw?=
 =?utf-8?B?eXdEQ3JlU3Z5Q3BKaFdDV1VYeFZlMUpBMnhXRkxZNENGSU05L1JtUWduMlY0?=
 =?utf-8?B?WDJaMzhVaHRnNzAwdTluS29mblluWjk1OXdWdkZaNktwN2NsSExKVHdBMFR5?=
 =?utf-8?B?NUUza0ZYRklMa3p2cXIzYWxLQmhRUzF1NElXZUEyekZOVHFKb2VXMzRaTmpM?=
 =?utf-8?B?N25DWFZJMFBTcU8vOXptRG9pOGxiblozREo3dmM3emloZnl6a2wrSG1DaWdE?=
 =?utf-8?B?SXZwaHZHZkUzN0VOVWNwTnFMTi9CY3VBNVNEWTZLNE9CLzRKbGRWeW9IWkc2?=
 =?utf-8?B?ZGJrYW5oSHM1WlQ4L0ovbG9vOXBiQUlZdHNiY0VPUmE2R3JHV0x3WTNsV29x?=
 =?utf-8?B?WkZYSGVta3NtWGVyNWNoR2lzNVBkUzV0ZDREL0RrR1RFQnVPYW95MytVaFUz?=
 =?utf-8?B?YVpubndUMWltVkFOd080OGhHNzFqUUczWWRJU25QWnFQb2hQQjc0YlczVFFq?=
 =?utf-8?B?azBHbFJLSytES0pmc0psY2VYcnFYMGR5K2t3RzBWK28zdm1yb2FEL3N3bW1x?=
 =?utf-8?B?cDhQSWZWR0NZUlRLSzRaTW5sS1J2T0FEOXJLR1VNZmE0UTdQRU9iZ3BnclZv?=
 =?utf-8?B?K1hDcWZYV1ZaSnNuZGlHY2NOMkxMWEU4ZytrS3lvRXo5bVdyTm1BUEZISEVh?=
 =?utf-8?B?N0M0K09OSmtQZUU4VTdhZGQ3L2x0UDIwOHhUNGo1YWFkc3dmT05iUlhqb0VN?=
 =?utf-8?B?Vys5QzlVVlU0ZW9hZC9waGViS1IzTEJSelBLR1ByL1VHVzR6SGZReWowMlhB?=
 =?utf-8?B?ZTFwbUMza0UyeEF3bnM3QTdKSW91ZFlNYjNIbFRmUFRvTkd0N0xBMmNLeVQ5?=
 =?utf-8?B?bjVaOEVYWEpXUjdSUHBGcFNzL2lSczRLU0F3UzZKNGR0WVloclBxZjRxUmhX?=
 =?utf-8?B?YXRkWTl1NEFQeENlL29xYnVoL2xSVm1FWnlzbDdxWHkzYUZLcjZEWUlKS3ov?=
 =?utf-8?B?MVBxaUdxOHBvSGo2bkMrcklrRzhYc0ZFTElRdWlCQWs1ODNGeXZDa0ovMHFU?=
 =?utf-8?B?dUZzOUd4Q0x6UkxOZWxyeHloYmNYRUlQMHk3cnlXUVZ4QVJWVW1CTS9GSXpQ?=
 =?utf-8?B?WllEZkwyaWQ4blM2ajJXV0tmbkNPK3ZDWW42OHNVcEgzSnFCQnd4VHdjeWVj?=
 =?utf-8?B?WlNJaHo2K09kUEIvcGQ2ODNvNTAyRTJXaVpyNWMzaVlob09QamxzZFVTaTVF?=
 =?utf-8?B?Q3dGUVRKWmRlQlFsTWgyWmtmUndWY1VlNU5JNkdHMXBVUUkyODlLbSt3bHRZ?=
 =?utf-8?B?cCtxTmtYMVI5K3NQQTRTU3ZxUnVYUXFyVG80NEJqM3NKbFN5emdtNlpEVFJq?=
 =?utf-8?B?NXEwMGhGMERURUo4MnQvMmJ2TVVQMGdITTlDWDhRRkdxUnNIb05GZz09?=
X-Exchange-RoutingPolicyChecked: 0TSoLTXho3pQPR7hcvhE1GpL1c/mPN6lwpsxe+QPzawVAA1YIFg//27t4MZPwLh+wfWhq19cKeRadSa4PE41A+GgFoKRfvla3pWLnniv22mRjy8bcs6KAKNT7GYjbeaayFkT+gH2vih2pCqOTAxH/Dh0/aqMWYMld9aHzMeyFwaTIS7YGk888gaBT3PgwkAfv5mVrnOAF77fseciezV1u1IMxofnA/7pIdmat3GzriPldCXSfwIAhKMxlkuYtYhqTpIqiEP7FcqsjZ/SdYk6HKUGZyD/hUym4ePScifStaytukoigy6Fp0r2xI92lVIEWtwmspN6cuevgpyq4WT7fA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f880656-b12f-4eaa-b650-08df0fa59c2e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 01:40:07.7973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvdVW0wBMxXwR1ydtpoRUYvdQ2jfKyETA9O9NQF/irb2cQIEqaT6ZWo7oMbSzpD1lAspG0EjnBTo+D9gpX9BHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7349
X-OriginatorOrg: intel.com

On 9/9/26 11:33 PM, Tony Lindgren wrote:
> On Wed, Sep 09, 2026 at 06:11:11PM -0700, Kishen Maloor wrote:
> ...
>>
>> As mentioned above, that is a destination launch time directive that we needn't
>> conflate with a migration/transfer session role.
> 
> It's still the same role though. Yes we can set it on init, but would
> be nice to have some generic way to do it for qemu -incoming.

I'd separate these.

On the role: it seems we agree on recording roles per-session. My only point
then is that a VM created through the delayed_init flow doesn't additionally
need a destination role recorded for it if SETUP will assert one when the
migration is kicked off.

On generic plumbing for -incoming: is this about KVM_TDX_INIT_VM_F_DELAY_INIT?
A generic mechanism would make sense to me if the flag were consumed by generic
KVM code, but that isn't the case here. Userspace has to make a
vendor-specific VM-init call like KVM_TDX_INIT_VM anyway, with the flag passed
on that call. So I'm not sure what a generic version would add, unless you have
something else in mind.

> Just brainstorming.. I wonder if we need two things though. A source vs
> destination role. And then at some point possibly later on also a data
> transfer direction enumeration similar to what Linux has in
> include/linux/dma-direction.h.
> 
> We already need to make use of the QEMU return-path for the migration key
> exchange. What if some hardware needs to make use of KVM_TRANSFER_MEMORY
> from source to destination, and after that back from destination to source
> to ack the transfer? Sure this is just speculation, I'm not aware of this
> need right now.
> 
> In any case with handling the source vs destination role, the enumeration
> for data direction can be added to the transfer flags later on as needed.
> No need to try to stuff the data direction flag there until really needed.

Agree on deferring such an enumeration. More generally though, the session
role determines which operations are permitted, and it seems like vendor code
could be expected to handle those in context.

The TDX architecture already has a destination-to-source example:
TDH.IMPORT.ABORT emits an abort token on the destination that
TDH.EXPORT.ABORT consumes on the source. So KVM on the source would dispatch
to its export-abort path and let the vendor layer decide what to do with
the buffer. This doesn't require a direction flag.

