Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9443246EF;
	Thu,  9 Apr 2026 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767847; cv=fail; b=AOgu+KzAHTAe4rtyCYnb6K5joJgf6UnlAGp1DZQPvQO7AVnAbf95ifqyM9XK2qyO59xWL64cquC1ArrUMXVbkPkF+OgCc8gN2+2xx+h6fiBXJVxzwv1Wbck6gnEzOOC82e4ClEgspTTyejIfAHWm/BcQ/yDaA5quv3sLvlsZ2pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767847; c=relaxed/simple;
	bh=m9S5L1tSrX4UdUC/kxa/a9HzJLGrJHPgLVHYWYcSCds=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QNdidMBbTOSD4nLdzodGvxDRlsN/Nv7gyzeqfcwGbxxLgTMheQZ5sxCxc2ISkFFNsawD9t9CN40ZiCVeh6DXu5pzwuwGK1FRHHLQbpMHSKbV+3bzc1qlunt9hrfY2zvajEUJs0YarBCBT1yH3uywf80fEVey4mEcUD1oKyeAHXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=idVPNngI; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idVPNngI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775767846; x=1807303846;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m9S5L1tSrX4UdUC/kxa/a9HzJLGrJHPgLVHYWYcSCds=;
  b=idVPNngIgI0AXUGjzhbAgBIlRuz4Nn2MaHe52dPQWl2+CUfV3lebn3gC
   Kw5DNElQeHAX3etUpoFvXbcK2FlGxeejM22hI0rSPqwHKZFEL99/e82iM
   gPa3cLmpR0unfDLzyoWlDqo75y4OfoSqPlpfqXn9OqsCXu2GMZj5lA63r
   cNwWqPTwKd3RGCP7x6KA2KVGLZFf7c3PUy7uMD4IJtZH687oESzxY+QQX
   0KkYgmZg1yQvDXC873FUB6FNkBSn1wVQy+Xod1YeX+A6yg0qVBtBL2tmX
   0GJPMGPNC6rDN2UzreY7rv091eqD8bayJ7wCC3grSK4LOrT2qALuM+JUH
   g==;
X-CSE-ConnectionGUID: ektkZOsuS++6REwxK6l6eg==
X-CSE-MsgGUID: mC8kH3+RS7GcktHuQrP4RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76804798"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="76804798"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 13:50:45 -0700
X-CSE-ConnectionGUID: Dly5ddJXTdyu+AQjwR/mUQ==
X-CSE-MsgGUID: unl0PZoEQV6Mnhuyb4prtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="226154633"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 13:50:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 13:50:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 13:50:43 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 13:50:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cV3EOydPBfSoobvnlW0zfrkKn3vNvz/4DLUDHPTD25rujn+9x9HQNQ8e/tyPnSKZEPWUP34rSDWPjhXVCHetJoEIRt5CQ/Hj48nJ5HTSDP/Y3GiTUx0dsNv8EfErYpjZnmi8NPWGWaHxFiPREurP6TOq42/4wo2wClHJx2mgIJ2elZ624kHR4sJvz5SUDnW2jnfDUHuBX9teWiavpUjlN0Uf711cgISD1Y4rhuGD/Kj8uWcwKMULyVz3GvdGDZLOrNBzEdYn0p2aaXYW+H2KMgvzqwVDi4x7fEIFMmduMUVGAsRtrd1nVC0HRnrzQyDDelkBE7EzgBLSMQLKadPFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJajUpI0Ra/ZgNBbHIAMvXpbpNutQT0emRaEj63ewNc=;
 b=FmN9PBkqEC0D1nSL/yvKi0Z3Qsi/vVm/fsPZFxJH6C5ovFyF57Ghux9BZS7+SjbeAB2sncpmf/4onNaJjuB7ZQz9PCWodeUZhaoqUkxqCJ7iPD80H09+D8rFs0rD08sJRHMLHtbMaacTYn9IW9rX5euLGKSf7kVcgJ0qES9uOxz8e7Ov+NkPp6B1kr8CgDW/O3aynnzZUIqEfeS74bJUWaOwvQUC/d2p1z2zc9g2EscPe4637phJN98dstSf1nhbPDirzcJfwoF02QzWwXy4XNasLAzCtee1dJ6WZX9KiDlzoNwLq8e0FIIVgmPBgBmwqcLfIZ/OZ+gLXztkezI3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB7908.namprd11.prod.outlook.com (2603:10b6:8:ea::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.34; Thu, 9 Apr 2026 20:50:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 20:50:40 +0000
Message-ID: <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
Date: Thu, 9 Apr 2026 13:50:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: "Moger, Babu" <bmoger@amd.com>, Babu Moger <babu.moger@amd.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "pmladek@suse.com"
	<pmladek@suse.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "kees@kernel.org"
	<kees@kernel.org>, "elver@google.com" <elver@google.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "lirongqing@baidu.com"
	<lirongqing@baidu.com>, "safinaskar@gmail.com" <safinaskar@gmail.com>,
	"fvdl@google.com" <fvdl@google.com>, "seanjc@google.com" <seanjc@google.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"xin@zytor.com" <xin@zytor.com>, "tiala@microsoft.com" <tiala@microsoft.com>,
	"chang.seok.bae@intel.com" <chang.seok.bae@intel.com>, "Lendacky, Thomas"
	<Thomas.Lendacky@amd.com>, "elena.reshetova@intel.com"
	<elena.reshetova@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"eranian@google.com" <eranian@google.com>, "peternewman@google.com"
	<peternewman@google.com>
References: <cover.1773347820.git.babu.moger@amd.com>
 <14a8ad0a-e842-4268-871a-0762f1169e03@intel.com>
 <47c0db32-d0e0-4c53-90bd-b74863d233dc@amd.com>
 <88eebfac-5286-4788-b244-911c659c0439@intel.com>
 <30deeb5b-d2ec-4f85-aa4f-c21400df3486@amd.com>
 <83ae0c18-5c5e-4b52-901d-4126fe7c141b@intel.com>
 <5a740f47-d3f3-45af-9d8c-ebcf3dd89c0d@amd.com>
 <3305c18e-9e50-4df0-b9f1-c61028628967@intel.com>
 <c6f574b7-fe5f-49ae-9865-0e4dbb2f9803@amd.com>
 <efc269f8-bf98-4f12-8d76-1fee564be84c@intel.com>
 <0ae2b267-4527-4251-9136-6afdc3fc97a5@amd.com>
 <72297351-2954-4318-81b6-7de409e5552c@intel.com>
 <20aaacfb-9601-4343-a5d5-f3df6152155b@amd.com>
 <43880b7b-b390-4e7f-8c2a-46cde9e3b051@intel.com>
 <bb9f62f1-0c79-4d29-9866-c39d08c3a774@amd.com>
 <5a273b0f-8225-4e9e-924e-884183734659@intel.com>
 <73c46024-4cf2-4f03-9268-d4378825fa87@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <73c46024-4cf2-4f03-9268-d4378825fa87@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:303:16d::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: ef051dac-c2e2-44f9-8931-08de9679a8bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: TFrH6VQlgrG/s7S7OUw3XJAbi/vGsyt8HnLr0h7H/BoDrvdITYJnt3y1P6lQXFnVMXtH+NHZTak18BDRQEZzu0I+bid/teEZAMJG09Aph3kpz9DXHigYWsJMgG8r1XbEgSDixbsStrBZ9pz5SUrtCh8KasKQkD4SuWgovRHRmxx08D8mrK1ufhsM+ZvRO0m/wZ5crlppBrsGVSU60A86NdXXtK9UgzNLdxeb4mvPhZQbci9zhSwIcbPq1rzUApwV8QGUWrHnH3Q9doso6WwUF0VXLYRd7QM7vqqghSMpSVTi1Fl4zTwMLlJa6VgH5gy0VrRy3w1SCNuTUwCb5dmlHyenCL6gcwim9hICANkYw+3aSjYIyXPakqvn7pXNYYZ87hShi2bc8+80YrIlko1eVRB2T3l0JbPkw26NTgzykTLqSYpwvLnD6I5JM3fnSntgNUU/FZsUxLqQanvnSwQ9XFpiysZz6ZCSzqVzMZ0sJr/uqGCLFuW1ywCoAgRen/56ITLZVZ9JZWvDd4ajjcSlN7ErHcZ78FwPBYHUntxZ5PO4XvTY0yuMEYc99Mt7DEfuIlAmBSdbR6UBZkUNxZcKNptztj+JlPrPrxt12GH3zxiW9oypg8Odro5e5KWG00i4wGWl+JAuyXIbDTz8jWMZ/3ytfSKoBEM/rbJjmZUxLbvkJx8zngw6cWJ/RTiT1hcQ212HjvpTQS4ACHgSycQAZODUnLMHYa09JBm5ASqH11o0oN/PVhWWCwxe3K+zcmmAHnoFB/dUwVNcZLTkBWIuyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm14aEJ6MUo4cE5yMi9XZVJQVXdzbEEwZDh2Y3A1cWtVUi9sc0Rld25QbTdy?=
 =?utf-8?B?UElrb3BwcFFiQUNiMHBYeU1rajNRSzBqWGRQek1EUDdnQVlkR0tzc0ZEMTVj?=
 =?utf-8?B?SEw3Qm1mL3VVUnBwQW5rT2ZlQXlkaUZsb0VZeU8zK29MOWZOaDUyazNJOTJ3?=
 =?utf-8?B?dk5Ib0tDNndYeE12czMrUU9rTFJDbFNrYUdwUXYzeDg3U2RaUnQ5U2xlRmdW?=
 =?utf-8?B?bGpXQVRuTTQxbVNNZDEzVjNHTmFWelVHSFVab0V5Q09xc2hzY2E5SGV5aWxi?=
 =?utf-8?B?b2ttWCs0UEtKZDliUkMyZGdPb1lmNHZpQTc0WDIyVjFWTkJwY0QrMTB0VURs?=
 =?utf-8?B?YjMvb2MwTjdISkh5U3hDaFdGNm4wSzNjTDQ2THdyeCsydjM3TjFGMmFzWnRu?=
 =?utf-8?B?YmVuU2NsaFhJaWNOamtQV3VuNi9lVU52N1o3R1lyVXNvVml2b3dCSGl1SHdI?=
 =?utf-8?B?WWxjWHRsUUpwQVAvMnZVbndnN3VzZVQybGYyRk9mY05RRXIzbUdrM0lYdHlj?=
 =?utf-8?B?WFBLU1V2R0lDeWQxMDVDWjVuaFc5MWR6YXNxalVTR3NxdWppRlRLbDdwcHd4?=
 =?utf-8?B?TVVnbkFPRkh5cTIwSkJOcHJzVW5HNlk4N2xrdmdPcWVFQXVmT2dkT01FVlE5?=
 =?utf-8?B?SjUwYWIwRlZSbUdhdlIvUXhQUjJGYUVtRHR2S2xXeHdaeGh2VkV3RHMzTGtw?=
 =?utf-8?B?SlFGSi81RUpmN3VFSzBDSndPZ3RPQW9vNTdVMWVGV3NqSXQ0TU40dW1FdWV1?=
 =?utf-8?B?TXBEV2VKU2dpRy93NjlBSkF5MmVKbzExZG1sZHhiUW1OQ1MyTFZ4dHdDYXZG?=
 =?utf-8?B?N0xuV2lPcmtEaXF5dHYvQkdrZTVWTUZTeUtTblhNSE9zcHkvOUhzRFRWU2NB?=
 =?utf-8?B?TUtYclpJQldrd0Zud0dReFk3YXl0SWJKazlNNHlRN2ZnQklIWXpTMEl5OEF1?=
 =?utf-8?B?STI2RDBjZTVhT1R2elg5SStrWERwMGNjTnFBZ2xwTUhBM1lhcjY2K2c3QW4y?=
 =?utf-8?B?dFhHdTA3V0hpeEJRaDlkQW9ZWkJIdUJ1NUxtOGRYQi9EZ21pUkpvZmdMZjFZ?=
 =?utf-8?B?MXp1dGNXeEZnU2NGaE5LOHBoQ0JmQUJxZXVZQ0RnWCtDYkNwZnBpRnVpQUps?=
 =?utf-8?B?ZkdxR2tCVXg1SG14TE9iTHJXa2Jjeld1ajBHN2Q2UmkrQ3dJVWlBVitpSmxQ?=
 =?utf-8?B?OTQzOUZQWkN6NVlCNXpDOW5KK284Sit0NHVOTy95UWtMUTVQRWRLTHdpRXEv?=
 =?utf-8?B?Z1hVL1VLRG9mbEl6YnJpdGtoNzdpVTg4ME1VV2JJMGd5b3hEUW5rOSsrc2dE?=
 =?utf-8?B?blVKUTZWQ2x4bVUwbWNraEFuNTdVTmN6WTVYUTFpaFpLMmE3QmpNb1ZxL0ww?=
 =?utf-8?B?cVcrRGFjSXdKODZRbThSaHZUdkt6UUdSS2JSM3J4bFhoY3FyM2NTQ0xyRFVv?=
 =?utf-8?B?d2sza0pYbHplY2lnRmFlUk5hcDRSL1RnelNxRUxydkVUMEVqcjdUOXludFdm?=
 =?utf-8?B?dUZFRlo2dnNoZWlqZnFDMm5pQmtWek4vbG9CUWhvZzFaV0hhWVY1WVBQR1Rm?=
 =?utf-8?B?blVpT3BZVGFNazlkUjJtY1hHc0V2amE1RFI1M29lYmxaNzdnZ0YxYlBpWTZG?=
 =?utf-8?B?eDF4ZGszVFVtVGJJRmNuSU9UWEI2b0hJWTUxMkxaMGN4UTdCSklycWJoSlhF?=
 =?utf-8?B?c3crRDI5T0RaZC9maTJBK2xKRGNva0l6eEdsYjFnMG5JOTViNjNsZk9HYXFC?=
 =?utf-8?B?OVRYS3U3VGNFSDZZamhOcU50WWJxSkRqQml5T1QxNzhBSXhxenVrRitMRUQv?=
 =?utf-8?B?eVlyM1daSmMwaGlkSloyUTg1WVVEZERIWTJTMUJPNWhPYnViOUhUcHZOOGM1?=
 =?utf-8?B?Z0JteTlNNVhSa1g4dFBTQ0xUUysySlpjVWFQaStaakxFUjJIbnFpbUpMSm5m?=
 =?utf-8?B?RkZmZFpVT2w4bkpwTnZ3QXhydldTalZISGRUREZVR3IybUNkZGlvZS9KTHVt?=
 =?utf-8?B?RUs1M2orcStzcUtZQUpGb2tjTlR1ZFdzUnZ5TjdTbmhKT2Y1dFB5dzdCUEdz?=
 =?utf-8?B?T0o3ZzJpZTF3aHNQYzBTNWFkZytuSUdQcmhkU1VtNlFoTDhYbVNPOVJKNW9C?=
 =?utf-8?B?VjliS0pscDlscXZSbE5zbUkzS09RbVZSY1ZZU1dEZXVzSFlhdkxQamRtMmV3?=
 =?utf-8?B?QkJLaUFNOTQveHdEQWtsUm5tNW1wTFdrODJDMDk5akF5T0Vybk9EemlwUlVG?=
 =?utf-8?B?QVlTYzBHZ0RxVWlsTjRGYWdGMzN6UzRBRm9TY3JrV0tvL0lVaktzS0pyd1Jx?=
 =?utf-8?B?dXRrSWxmYmxWRlZ3amdDd3JQRGt3UTViVW5RRTVxN3JJV3dBeFNZMGc0TU5F?=
 =?utf-8?Q?1Yq1CTZMBGa1Stg0=3D?=
X-Exchange-RoutingPolicyChecked: LnSNIxJlH9G4a9lzyB3eQ/+mcEcmCE+YkD3Ubmk1EXCrY5Xh1Rx+6diqto1i5I8qXsv4yCkoCt6BW0x4KIWf+HdhKJCfAaG42Rp/B31wR/QQjEeVH9vN30pvEPsyvdKVE7fiqeDM5nqIUXiE+pSzpdmzIjM/H1NLs/LFCo9t8+JErNBdZwxeEah24GpRgwM6QFSdfHcLBgoUvx7l5TM94FrXmoGp0UT9lijIci+bEXUF6SdFiCg1lhRsLapo6r48LJqBIRqTvyk8vcTG6ystOC3s/a28fB364vUiMNRZsM+WzKQc6+1s04wuCEf9m363huZWueSv+AJ24zegsCwPbQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ef051dac-c2e2-44f9-8931-08de9679a8bf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 20:50:40.1053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgLqDEKNF878w8ZAe4ypcCnVrkauGbc6hMYvcMWbCtc6IIfViumrcxaognW44Ceo6djmxVvUXpwK2NfTIf3zumkZomMDKHEELKe1l6skVmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7908
X-OriginatorOrg: intel.com

Hi Babu,

On 4/9/26 11:05 AM, Moger, Babu wrote:
> On 4/9/2026 12:26 PM, Reinette Chatre wrote:
>> On 4/9/26 10:19 AM, Moger, Babu wrote:
>>> On 4/8/2026 6:41 PM, Reinette Chatre wrote:
>>
>>>> When the user switches to either "global_assign_ctrl_inherit_mon_per_cpu" or
>>>> 'global_assign_ctrl_assign_mon_per_cpu" then "info/kernel_mode_assignment" is created
>>>> (or made visible to user space) and is expected to point to default group.
>>>> User can change the group using "info/kernel_mode_assignment" at this point.
>>>>
>>>> If the current scenario is below ...
>>>>      # cat info/kernel_mode
>>>>      [global_assign_ctrl_inherit_mon_per_cpu]
>>>>      inherit_ctrl_and_mon
>>>>      global_assign_ctrl_assign_mon_per_cpu
>>>>
>>>> ... then "info/kernel_mode_assignment" will exist but what it should contain if
>>>> user switches mode at this point may be up for discussion.
>>>>
>>>> option 1)
>>>> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
>>>> the resource group in "info/kernel_mode_assignment" is reset to the
>>>> default group and all CPUs PLZA state reset to match. The kernel_mode_cpus
>>>> and kernel_mode_cpuslist files become visible in default resource group
>>>> and they contain "all online CPUs".
>>>>
>>>> option 2)
>>>> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
>>>> the resource group in "info/kernel_mode_assignment" is kept and all
>>>> CPUs PLZA state set to match it while also keeping the current
>>>> values of that resource group's kernel_mode_cpus and kernel_mode_cpuslist
>>>> files.
>>>>
>>>> I am leaning towards "option 1" to keep it consistent with a switch from
>>>> "inherit_ctrl_and_mon" and being deterministic about how a mode is started with
>>>
>>> Yes. The "option 1" seems appropriate.
>>>
>>>> a clean slate. What are your thoughts? What would be use case where a user would
>>>> want to switch between "global_assign_ctrl_inherit_mon_per_cpu" and
>>>> "global_assign_ctrl_assign_mon_per_cpu" to just switch rmid_en on and off?
>>>
>>>
>>> This is a bit tricky.
>>>
>>> Currently, our requirement is to have a CTRL_MON group for
>>> global_assign_ctrl_inherit_mon_per_cpu. In this scenario, we use the
>>> group’s CLOSID for PLZA configuration, and RMID is not used (rmid_en
>>> = 0) when setting up PLZA.
>>>
>>> Our requirement is also to have a CTRL_MON/MON group for
>>> global_assign_ctrl_assign_mon_per_cpu. In this case as well, the
>>> group’s CLOSID and RMID (rmid_en = 1)  both are used configure PLZA.
>>
>> ah, right. Good catch.
>>
>>>
>>> Actually, we should not allow these changes from
>>> global_assign_ctrl_inherit_mon_per_cpu  to
>>> global_assign_ctrl_assign_mon_per_cpu or visa versa.
>>
>> resctrl could allow it but as part of the switch it resets the "kernel mode group" to
>> be the default group every time? This would be the "option 1" above.
> 
> Other options.
> 
> Allow global_assign_ctrl_inherit_mon_per_cpu -> global_assign_ctrl_assign_mon_per_cpu. As part of the switch, reset the "kernel mode group" to the default group.
> 
> Allow global_assign_ctrl_assign_mon_per_cpu -> global_assign_ctrl_inherit_mon_per_cpu. In this case switch
> to CTRL_MON/MON -> CTRL_MON.
> 

ok. Could you please return the courtesy of providing feedback on the
suggestion you are responding to and also include the motivation why your
suggestion is the better option? 

Reinette
