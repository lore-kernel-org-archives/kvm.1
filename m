Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D126A3D9527
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 05:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229230; cv=fail; b=rhZlm6tm/bI0uUenp/5HHR2SwIn2Id9HUhw3xnQyedJEV/ZioizKW8GYmOcxdxKK1SbzbQXQzbIINsSeY3IU0iMyYVSqj1INaeGsZ3db1tWIcg+P1gkbEXbjQL7Nfvt3KxwWw5Kp71gVpFzCBWrpb1vXUz2VyXEf/+CfxidAG9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229230; c=relaxed/simple;
	bh=vTQkeo1CWGzaKBYTGy8YKcAXpuBVn79F+WLneBej/I4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bQ2a7OACHTwhN65Y/bKha+qigmYYnlZqeCE0mzQ6z/qfEWtryePYxsfEQJyDp/RzzBHtoj8lDWaHsFOoX3pmbB7k7+D6JtNkvWmCpzPbMar3VvTunUiRImxFy+6C+lwQTw6WE/xk08jtRBu9ma6e6IlcOwrovU/e1hWk41Z6v3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/hI1kI6; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/hI1kI6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790229229; x=1821765229;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vTQkeo1CWGzaKBYTGy8YKcAXpuBVn79F+WLneBej/I4=;
  b=b/hI1kI6hvl9dHPTWE4KCtHcgInAm5oDKzQ0XSWzDhWciWMc1YOQBGZp
   yVWLTR9QhdxvJYBYTfHcVi4aLzko6ZAY+KXSUZqEMX6hzYs5wWtsqoMSV
   PzwQ12qZMuB/5fHvH0HmiURmjJP+3TyqCCHXBwr9lC+TlQXqeKGbP2XvU
   5L9w1pj4XzdLFG2LPTddWcCIQxSUwpeXEFzqPHTMXq+OzF+GsgfMjq3Wz
   RyiAZ/Y3YjTuSNMs7BVEPk79MFmsENkloEU4yFkfaVLZfL74OhEeuEmxe
   S7hqVTGjNeYv1a74zs3CqD5g4VtMAK9OpfAKZeOYYIM9hZfu2PcjeS6Av
   w==;
X-CSE-ConnectionGUID: iAYkgrbHQEGnrrhlUBdOqg==
X-CSE-MsgGUID: YRD7cWtITD+DjoyYRadeEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="101567275"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="101567275"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 22:53:45 -0700
X-CSE-ConnectionGUID: 93Kd35kNQTW/rmKR+Zk7zg==
X-CSE-MsgGUID: t5OTBh5kQwqhuX5uGippjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="277681463"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 22:53:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 22:53:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 22:53:44 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 22:53:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qw1JEtB/+wU++uBsBspuWoft6GVS+xJi15qY/4loOXRGPAt3+J7ysESZw7rfkiiVVyYV5ufxC6ZnhkdpWQDbNpdymFjO2xGBgyEzHw5g+EZyis8Jq0NQEtzcnwR15HOAI7Tn6fk3mcJqRaDXkxRJxKa+6ym6Rtgyy4dNjiEQL0tRSpkV7/gyYNuktilUNWflosxA4BBwCMTAuz5VABxq0ZqOF0rVbi7XP4tzxJ7elMm3hkhy71f+3XEuRGrX/nYshcZ9cxLKttwGHEXVOzgNG8L+tUHZ99h8NwVVND4qG/FIWjlDmih0MoAJ64MGHnAN9tBCzkN8wfDWOg0C+H6IIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peornj3bbYsFzb3fJLA2wnfOnsORGwEh8CwzUqjO+AE=;
 b=WdvJjzD+oGd2w6EU9z0iVG5k+JC8GB8U8Y2JeZJsp3FkJ9ZkJvwK1xxsu+zt4or0hjPKCbSg784JsOpSZtXxklPFQyhBgdIr6dW/iTb++H9aNDb38s/cZkgzYks2Svq0kTNkshoAQ/hHGeHNjJw2A7VTOeI9MS6ivSMVuCXpmaiKiL9wS8Msrc8BMbeYXQg2fccHzpfP/JJzbSwIMWDToujciEu5ZhbaZizJCwMP+NAybpyh6Y4I4QOeaNYuEYX/BvHsvljcTdjvvc8uRc2LMb8fkFsQUbsmQdIWtWxw2IaQvCtT1PPGsayas550vhdk4AihgipygOAUpvNF/+KXFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 DM4PR11MB6240.namprd11.prod.outlook.com (2603:10b6:8:a6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.14; Thu, 24 Sep 2026 05:53:35 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 05:53:31 +0000
Message-ID: <21aa5868-b8c3-46a8-a6cb-61c164fd55de@intel.com>
Date: Wed, 23 Sep 2026 22:53:28 -0700
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
References: <aqoknAli8A0Mc4HR@tlindgre-MOBL1>
 <3ee06a84-2c4b-4b2f-9899-68fc92b6daf7@intel.com>
 <aquL7kNJsjnY0mJ4@tlindgre-MOBL1>
 <b5906521-858b-487b-a262-7a86891a0731@intel.com>
 <aqzS_mCOT6YuHKxN@tlindgre-MOBL1>
 <e2f8b93a-fd42-4ee6-8b74-759d3052258a@intel.com>
 <arDUOl2WPKRxwrZW@tlindgre-MOBL1>
 <da65fe89-e7cf-461b-88bc-4f40f81a6ec1@intel.com>
 <arIRTIm4Q9ElodIX@tlindgre-MOBL1>
 <1f481f4a-716d-47fd-97b1-8fa872d39797@intel.com>
 <arNr18dSS5P6Kf4e@tlindgre-MOBL1>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <arNr18dSS5P6Kf4e@tlindgre-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::14) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|DM4PR11MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db12aa3-fba5-4c54-0e5a-08df1a0029d4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|7416014|11063799006|6133799003|3023799007|10067099003|56012099006|4143699003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8Et4FTsZLwvSmuAO85gAuQZVNrBqWu030AOCOLhbGN70gg1D2gKHP5Yws/1hx7eKzuAJ061MzP+PK20tmk8TY7sVcgD61IAzfcBwR5XfV8dGMuG5avaRfJoQnouozNOMFyrXiyavoZG27dDlc1AkVTz9QkS0zQqmDFODkHcB/qama0EcQ6P40HSuuABneCDlnYIzxAtrBpskZ9V3KZvrB2F8993WeMelizi2itu7MqmOLul/wC295PTbQjzghZ0KfTKpSsig/w1qK1LxrOMjIzX/EriubvmCHEOoTamBu5bX5L9V0nAHj1t2jkPbmzuzZvInL8SSTCaIFDfqXFvA988J7yqLxu6vDJe5xqP/IQeNgCJ7I10E8gvH5NBO/7tljskNftErL2xtuNJisTVmFox92aoWsyrK6e/3OdqYNHnCREAsok77YxMm0hbMU26cg0r/cdtFUs6DkKDq//GNK3zE1VtIPTZndiVHY+mumZqzKOXc+TUO3/lgHWT1vdlLRva3g34XgCD+mOQmaAnUI7NH2qzRl+ccGsUBtInCsRxnOaTaCaHJ1Sw2t6r1hAQlyb7YlSGfxvQJwuQiiMos93t97a4Bf2TO64+/FnEwa/Z4Jxqgwfzorz7lQ+Lnz3hmcn5Ft2tG9gA4dzbEntDElU1UpGweTp2KKFgmfu+/Yx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(7416014)(11063799006)(6133799003)(3023799007)(10067099003)(56012099006)(4143699003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L05IMWdHalNNNlB3d00rdHYxeHBzZXB0MzgwU3F5TUtXWFN5Um1uK1JJVWJ5?=
 =?utf-8?B?TGFmelZEYTg0cEU0N0pwSmlHMjlVVFo2WmtJTTk4amFXN045Tkd5a2JUWjlV?=
 =?utf-8?B?dThpTkU4VUpEU084WXo5bUxocnY1aUZxRm80YW9mbFpnR2Zwa1ZvU09IeVJH?=
 =?utf-8?B?dXdnTlArWGloeHl2SlEwc3dIL0NTbHhpNSs3T296bEtKc3BENHBUS3JzWFo4?=
 =?utf-8?B?WUNsL0txdnlTa0NDL0hKeXFLZGM2TTBTUVVpNU93SW1XYWdTRzRtWXhYKzlS?=
 =?utf-8?B?cmVhWTdoY20vWGJuVUI1WFAzeGIwdmF0dE9FY0RoWTkxZFg0MTh1eitTaWRw?=
 =?utf-8?B?RS9RTkcvak1OMTluenh2MWtnbUNmYVFLa1BDaE5pUU5hUVlMS2ordmRyS0Fa?=
 =?utf-8?B?aDdRblpLTk8xektTci9hUERQTlc3QkZHOWw2OTV2YW4yZXNDN2libjdsa2NG?=
 =?utf-8?B?dTNXRFNDZjdqY2NjSytkemR3Q2twVGl3K3psQjJHcHZXaTB4ZUg0c0RaZWg3?=
 =?utf-8?B?R0c3ak16ZzhXeDduU0tVTnJ1RHFyQ0VqWEtva2hvWUR6UjNvankyMWdBa0hE?=
 =?utf-8?B?TEFyTkpMLzJIUnBmNTRKMndJNzRqY1ZQZDV4SE9GUmloY0t2eVlpeGRJVVE0?=
 =?utf-8?B?Nk50OXZONmhDS2ZSdGhHM01vckJSUXMvbEJ3cTZRZUlVZ0hwcytzN1hIM3FY?=
 =?utf-8?B?cXBLa1JDRXFjQXNmRWhZdndKZUI5SU9CVHBGSmc3dnlwSVZKTnpXZ01mMUxN?=
 =?utf-8?B?WWJ5QVVJUHBFSmlPTTRwdlZ2ZHk5c1RHQUYvN2JsdmVRR1BlbEZud08vd3ZF?=
 =?utf-8?B?aWRnbWhjOHJaamtKTWFIMUZ1RzFLK3l1Yk1pTitBTjZ1bmlqOU0yaGFSWTM0?=
 =?utf-8?B?b1VmalNZRGU4dVdHWHBGamVvNDRMNDVUL3l0OWQ1QURQbjM1eGtKaUJsRm1U?=
 =?utf-8?B?Z1ZYeUROOUdYTXFCdHNodUVHdzZNTXhpTGxNY1l2L214OUZTdG1TV3lnYXpL?=
 =?utf-8?B?ZEhTTGtNNGlFK0tDdUxQc2dwR0xsbzM4RjFPSk5tMEFNcmN6RjZ6UWwyWjNz?=
 =?utf-8?B?aWhVNXg1b2hRZlVtMDNyOXNZb0hxNzVpNG81bkppVzM5dklwYjJUQTBHeFFv?=
 =?utf-8?B?MlpMR3QrRlZCN0Y5OUpMcGJWQ1hkMnhWSmJpQXFEU2RtcnFWbXI5T01WWU9B?=
 =?utf-8?B?ejR6RmVhMWZlVWQ2WVM3bzI2aUFndW4yb0d2aTRCdWRLM2FvT0M0ZEloeHFq?=
 =?utf-8?B?WXdvKzBjWFAxczB5eG42Y2tZUTQxd1gwZXo3NE5PaDRONC9NWG44dDhRdEdr?=
 =?utf-8?B?OG9COGlqTExTRDhpM0l6NDh4d3dPRzRNSFRCSXUzYkozSW5Ta09YT0sxWFBO?=
 =?utf-8?B?RFZjRXVPTm80Tks3VzJaeER3ZSt3YU5pdTM3RmFpRFRqbFVVNkVtNGRWSUNG?=
 =?utf-8?B?aFBTTW42VEl5NUV1UTBNVnJrelhnWjc4YkJSVXFlaFA1RXNSOXJCVERtT2FY?=
 =?utf-8?B?NEU3dWRvZ2hWOUdXTVltMVNqQWVJbWR2R1BYQ095RFRhWEpBbXZoRzJHYjI2?=
 =?utf-8?B?UERhcEJKRjFuSisvd0JzcUtxVTN0VFE4Ti9QOGJkVXhxMHJveFZCZWhiS3Zx?=
 =?utf-8?B?R245TG9pZ3RnMjh1RWVNdUFjRndUVnVmWmNrSFNndkJlcERJNklrWUZFV2VG?=
 =?utf-8?B?OGZXZ2xDQW41YkZ2OXRRczRmdlJTVTdxRUhobkRyQjJEYTRTSGxudExHU1VN?=
 =?utf-8?B?NXFyWDV2ZDdGUHZMSi9hSWgxRmdNMllBOWxDd1h1bkc5TlVDTlZ0NjQyL3dP?=
 =?utf-8?B?bDBqK010RzhQV2lHUStHWklmd1AvS0JZblpaVmxobVJXZlFTSm5XVnRqRkVa?=
 =?utf-8?B?K1pma3RIZWNYYUdUcWhBWGk5L2FZRTRQZEhvUXcySnlKSGZ4WnNKbGRRampE?=
 =?utf-8?B?eW0wTnhYWXgyeURsckVZR1REQ1I4eERkOStaUG1lN2pZT2pjUGI4elV3L21G?=
 =?utf-8?B?MjZQYUFQTzVYL2cxd3MyWTlPNzBHcFNvcVRIQTFaRUxiK254bVFaUEdXV1Nt?=
 =?utf-8?B?ZmxhYlR1aEdNa2MrNWtHVWNpb05zYzFtSkUwa0lmczFPVHhVOFp2RkZoRFVm?=
 =?utf-8?B?Wk9ibWNJK1g4RzhZRHpVU0o1N2M0aGQ4RTJ1cjdLNGZjWG5ZWSttTkphaU1i?=
 =?utf-8?B?dGFNZjNvL3FlMUVRVUtKWFpHM1FTcTVRMFV5aURHV1JNcTNDb0d2OHc5K3lj?=
 =?utf-8?B?blNEVEZsZURBVGJ1cTIwYlRrMHBYdUJRQnVRUmZpWTBpSEt6UkNuYU1ma0Ns?=
 =?utf-8?B?NE9LRHBUa01rd1J0akJWVDVJWVZkOHhqQ3NhbmJNZC85MHVMWmhLUT09?=
X-Exchange-RoutingPolicyChecked: o87ZHl5E8SooRNuENa9yLDNwCOLms2tc5KvfKekFFwWkzxd6FjvyM5arWmL4rnH9FBVPQBUrKs/mcDDv7o4YsD4drtqAffVmN3uGRDTr2o20GJ5zqv8MJL3Ib9Lv26HxgK96Q7u9fOJCfIri/dpDWRH0VD6W/KjkFnYcOuZm7VKO5d7JkFGGXfGulCCb4LsRmzr08UtJPgXOLVoJPMTuT0oH9ieszKbH/XbJWSe1PjXTU7XuJpwcp7g2j2CeL5/r+ZbrFp0TfjchLZt68bkNsLURstvX1Sa7ZGth9I2qwQ0rLDCSJKAvGoai1ZkqCRt7uxbRoH5yHRn08BFV38G7kg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db12aa3-fba5-4c54-0e5a-08df1a0029d4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 05:53:31.5464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmm82C92yPXXQM2JOpgF4vImrSysvXN0NbN1ry5Kv0WvuwM+GlQIK5+nlHX2O46f4rBySkJqYqm39TJAfsV52w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6240
X-OriginatorOrg: intel.com

On 9/22/26 11:04 PM, Tony Lindgren wrote:
> On Tue, Sep 22, 2026 at 05:38:43PM -0700, Kishen Maloor wrote:
>> On 9/21/26 10:25 PM, Tony Lindgren wrote:
>>> On Mon, Sep 21, 2026 at 08:57:45PM -0700, Kishen Maloor wrote:
>>>> On 9/20/26 11:52 PM, Tony Lindgren wrote:
>>>>> Then for KVM tracking the role, I don't think we need it with the two
>>>>> above. The role tracking can always be added if really needed. Any other
>>>>> opinions on this one?
>>>>
>>>> I do think it's useful for generic KVM to track this role (1 byte).
>>>> - It lets _TRANSFER_ style calls dispatch directly to import or export 
>>>>   callbacks based on the role.
>>>> - Even if we don't adopt the _TRANSFER_ style, it enables generic KVM to
>>>>   reject mismatched calls, e.g., KVM_EXPORT_MEMORY on a destination.
>>>
>>> Having KVM do generic checks on the calls is a good idea. There might be
>>> a simpler way of handling it though. Rather than having KVM track the
>>> migration state, how about we add a function to check for the migration
>>> session state from the vendor code?
>>>
>>> So something like this for the states you suggested earlier:
>>>
>>> enum kvm_lmstate {
>>> 	KVM_LM_NONE,
>>> 	KVM_LM_SOURCE,
>>> 	KVM_LM_DESTINATION,
>>> };
>>>
>>> With something like this to get the state from the vendor code:
>>>
>>> enum kmv_lmstate kvm_arch_get_lmstate(struct kvm *);
>>>
>>> For x86 it would end up calling kvm_x86_call(get_lmstate)(kvm) and for
>>> the TDX specific case tdx_get_lmstate().
>>
>> How is this simpler? It trades one byte in a KVM struct for a new generic
>> enum, a new kvm_arch_get_lmstate(), a new kvm_x86_ops entry, and a vendor
>> implementation per vendor, plus a cross-layer call on every command just
>> to learn the role.
>> Directly checking a stored byte (0=unset/1=src/2=dst) seems simplest, no?
> 
> It would avoid dragging KVM into the "track the migration state" business
> at least for now.
> 
> I guess the question in general is: What does KVM need to do with the
> migration role beyond generic checks on the migration related calls?

I haven't thought of any other uses for it. But if we do want those generic
checks, I'd still lean toward the stored byte.

>  
>>> It would allow KVM to do the generic checks for the migration related
>>> calls you're describing. And having KVM start tracking the state can be
>>> still added later on too if it is needed.
>>
>> I think we'd need to pick one way or the other before the UAPI settles
>> if we want generic KVM to reject mismatched calls. OTOH if we want to
>> defer this generic KVM validation, then yeah, it could be settled later.
>>
>>>
>>>>> The transfer direction is there with the EXPORT/IMPORT naming. Maybe
>>>>> just let's keep that naming for easier readability rather than try to 
>>>>> switch to TRANSFER style naming. No transfer direction flag needed.
>>>>
>>>> I can't say I have a clear preference between EXPORT/IMPORT vs _TRANSFER_.
>>>> If we keep the EXPORT/IMPORT naming, then consistency would arguably call for
>>>> splitting MIGRATE_CMD too, which makes it 6 vs 3 (or 5 vs 3 against the RFC
>>>> as posted):
>>>>
>>>> EXPORT/IMPORT style              _TRANSFER_ style
>>>> KVM_EXPORT_CMD                   KVM_MIGRATE_CMD
>>>> KVM_IMPORT_CMD
>>>> KVM_EXPORT_MEMORY                KVM_TRANSFER_MEMORY
>>>> KVM_IMPORT_MEMORY
>>>> KVM_EXPORT_VCPU                  KVM_TRANSFER_VCPU
>>>> KVM_IMPORT_VCPU            
>>>
>>> Agreed we should split the MIGRATE_CMD too. Probably the number of ioctls
>>> is not and issue compared to following the KVM style and better
>>> readability. So my vote is now on EXPORT/IMPORT style naming.
>>>  
>>>> I guess the main benefit of the _TRANSFER_ style is reduced duplication. 
>>>> Each EXPORT/IMPORT pair takes the same struct and differs only by the role
>>>> that the session already knows. Merging them gives one entry point per call
>>>> type and lets userspace drive both ends from the same call site which could
>>>> be considered a win. It doesn't reduce kernel code though as the top-level
>>>> handler still branches internally on the role.
>>>
>>> Yup not much of a win for the TRANSFER style naming.
>>
>> Yeah, my goal was just to enumerate alternatives for consideration.
>>
>> One other benefit of KVM_EXPORT_CMD/KVM_IMPORT_CMD is that the per-session
>> role is implicitly conveyed - in other words, a successful KVM_EXPORT_CMD/SETUP
>> (for e.g.) would indicate that this is a 'source'. So, we wouldn't require a 'role'
>> field in struct kvm_migrate_cmd to explicitly assert one during SETUP.
> 
> Yes good point with the KVM_EXPORT/IMPORT_CMD, that sounds good to me. 
>  
>>> Trying to summarize again after we sorted out the direction flag issue in
>>> the transfer:
>>>
>>> role            per migration session (cannot change during the migration)
>>> direction       per command, EXPORT/IMPORT
>>> hardware state  set and tracked by vendor specific code
>>
>> The 'role' and 'direction' as you define it above are essentially saying the
>> same thing - a source only invokes the vendor's EXPORT call, a destination only
>> invokes the vendor's IMPORT call, and the role doesn't change over the session.
>> If a destination needs to send data to be consumed by the source, then that
>> still invokes the vendor's EXPORT call.
> 
> Yup.
>  
>>> And checking again against the dmaengine analogy:
>>>
>>> Compared to dmaengine, the migration role is modeled similar to the dma
>>> channel configuration.
>>>
>>> The migration direction with EXPORT/IMPORT is modeled similar to
>>> dmaengine_prep_slave_sg().
>> I'll leave the dmaengine comparison to you, I don't know that API well enough
>> to map it properly :)
> 
> Heh just a sanity check for trying to relate this to something existing.

