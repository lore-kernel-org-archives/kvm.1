Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE26930F7F3;
	Wed,  8 Apr 2026 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775683467; cv=fail; b=m1OB93NrcWpowHN1bXEEu8XfMswtRFCqD3oMLqMTMm32FmB8/IM2YA5F2m0qL+8HdL9/Tsz6oHqERZhcWn7uW0HvKLnbyKFXdIF/w4bckMOqRH61Q7UPHpcyZw1KAymv4IrqhLgPVQxMau9/0bl+ixBoGToZEFayhzLPsiQSC8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775683467; c=relaxed/simple;
	bh=hg20O1HfuZxk0AESBR7c4/PW4upM8fHOnz3uEFTJDkw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W5qAatlzMFh5etjihdNwnepy5vuOPl3zX/5Cuf9zURPeLcmkEFRorj/CCksMtADMJlivT3rNasDsWodIaOd+dB91bzkL7fU0L4Lhsgz64TgjV7MmIEXl4E/Eo5ZRCnSKEBo7Wo4i13/MtGASpDOuTmQ3xbDYSo2V+zm789GaB18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JulJb1Ee; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JulJb1Ee"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775683466; x=1807219466;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hg20O1HfuZxk0AESBR7c4/PW4upM8fHOnz3uEFTJDkw=;
  b=JulJb1EedqEOe+bsiR/TaCIcAvxMYDF/m0lkZe/ZDikvoQu7DqZ8xfrf
   G7tCXUDjUrdiXmFkr/D5Us5zFFcCAvQdK33YCVPR42tWfFi49C4waIjGP
   HSp6A0uSCmZk+tay0RRCv8/yNOWUBlzuDlDFGzvsB4LX/VStwBzqaMa/p
   0NuOvx4tWWMq9WKLX4Q33/5vKYslSS7BNjtAs4zbJ7uHI6LxGEuHXidXA
   lYc2AZe5a5rMMDLdN+8kudUIQNFdHwkmotSQd8870OBh0LKtA3/NxR5AR
   2/7UZnnYFJR1RzkSLuBNtQrXQKNTgiXhAPnZw4/84UrTWjlGrYsLA1PBj
   Q==;
X-CSE-ConnectionGUID: HPNuzP/UTqepop4tVy7FkQ==
X-CSE-MsgGUID: ubGIZtaqTCSI6JMacsVDiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76800965"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="76800965"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 14:24:25 -0700
X-CSE-ConnectionGUID: DWMcUTjSSTmM6NkyV96XXg==
X-CSE-MsgGUID: sti46GukTiaHOxvGcmSghg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="232962463"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 14:24:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 14:24:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 14:24:24 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 14:24:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbdkY0dHa9xFHFHc2YLLa7Rl4LQCmTGj3VhPMK9qkKqRUf+O0+vQrDY+3Xr46GezkT43/jmZUkB9SBOGMe//LFrBgEJZiYlPgN9Pns8laPQL5/wqtbreOJlRPxC0Sa+iUiv+OStAhGYBUO7x8IpyDy/IBUeoSf+HRnVCKyyvfNT+ZvjUZvuOXfBgdTAXz2feqAk23tZ4gacb9m/Qqe6fI+Pfb4niSzjm+sYaUXGyNi8OhCrT3iMtFvtOdX3OevrPJezkQyZgX2Tk5j4gqdNBwp4qP2h4cNEqdxEpYp0eGZWAkcCChxeDbmtCNeu9vFF4LFnVCAR4wzFeM0PXmBa75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB23CDQp3S03xU7I5aGKu+mt3Y1aH2bvmD9nhknI+TA=;
 b=ocZh0EBXCqe6Khg0Gccs93nmfxy5npqHqo3rRKpXQnC+fRmcebsZuFyIe6lwZwsPSsib2X5+cHwQeqLiediJtuzhjbwjtxvZsEkOzIg6PoXg4eUGg3edu0DodCIjaZUihPBqpJ/A/HHA9Bk5o3RFAQCGphX7fqFVtduOn5HLYeq1FdIFZWum+D+89ZGyyP+qbj7oIXS1wafZAOKe4KL0TeVsqeBi8ePWhp66Jwmg1A6avSMg34znlckhT/aHjMZxAmMffLsp9OKiyeoECTtyIzZTX85j2in+pi8OatG+lEV/xLS2FNYiz2m9c7vWeb6OI9FBqb1m3QdzXemnbWnTCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LVUPR11MB9857.namprd11.prod.outlook.com (2603:10b6:408:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 21:24:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 21:24:12 +0000
Message-ID: <72297351-2954-4318-81b6-7de409e5552c@intel.com>
Date: Wed, 8 Apr 2026 14:24:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: Babu Moger <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "Dave.Martin@arm.com"
	<Dave.Martin@arm.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
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
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <0ae2b267-4527-4251-9136-6afdc3fc97a5@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:303:6a::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LVUPR11MB9857:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c16297-31fe-47c9-1e57-08de95b52db5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: FcRmcLzt3l3jE3FaHu86Kwb9btDSsrpU5x7HsFuCQQ+FqDgFDJK2Gh6UMBjpkdrKFrn8B+dC2yKNFIdg4OptssNzAlKY+iNf0uYyiKX8PxVcTUOWlOZyB7aYsBZvR7OMF4HWYYbYtxTABknVi7rAz+MUwAzLk/woALITxtTLPvsJEW+HDj5y4dkXz74VVNMV2yVstAXv/xCWiKZcimbcH5TRu18braQpAQZ6hB3yZsAydbcRtHxAOFz3dvWadQARQC+09OM3sIJ0figDxpfVk5ezfVFgVNEQw+01dQSl6BYd4GdZpc6WHuJNxfCv+H7u8ciP7Cm4verLMORJN2lKRYJKapTdwi8TlZ7O7WwaDev12ZHua9c3HQKz5wGqUGum+p1KKlaQ221pSPo3B4EselFCsV+Dz67FmyMbIaiLpn1c8vsofOycmzCREqSHNd3HMsQhdiouAHVIianc53/YBChWydAWYrqRUMk0c2480mpqU9TuawE+GO2k4o3WwDWF5xP9coTKzHi0UCfx+4tZDfPNvwd2NGKzvf4ebKqaDrJIwRK+qX1iUk76P08ypT0O8cMW5RSDu7YB3DCf39oAXU2mAWFF8QUn6gXyogkIARLa5sxkG1wbxzit0wT3n/hDOsZTYMClJ7PPqg5PwHkaRM+kS2W9QUnA3qNks47940Zr7vNhAZSCBMa9A/HXXCTM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm9Bb3RSYUsvWituV3JsL05CaDNNUmhldmlxZlBVbFRpNHpzNEpiS3ZDTmdP?=
 =?utf-8?B?WGVaTFZLcEdsdGt0Rks0SUVnUm9xL2FmYWFickhEbXhDTDBTSkh4cENyTEJR?=
 =?utf-8?B?WkcrUmgrT05XZHRubmRsaElPdTdRbGRRb2JoUGdUTXdpbkJ5L2p6SzNkWGxa?=
 =?utf-8?B?Y1ZyRE5JczJ4L0RkOUIwQkNtbmFPWlRaU0RPMGtLWURaOEhhNjg0dUNQMmlK?=
 =?utf-8?B?VXBiNGRtcmRZNHhsMVFaOFh5OUJYWUpuTnVqV3RRK2lsRXlCeGtVUXd5SHVl?=
 =?utf-8?B?THhyUDdUb0lyWXZyZkhGdkJOeDVZTVR5dU5TNjJvOXo4NHdjMkRNTjMvSWVR?=
 =?utf-8?B?S0tnRWVRc2RCSk9ieEFzY3RXTzZsdTRWNVVrckNvOHVkbE4wQmoxdm1iRzlq?=
 =?utf-8?B?TjB5Yys2SDNTU2ZNekNmKzZHTmhZQTV3STB0bGUzWUUyRzBKQkxUWE1ISmhm?=
 =?utf-8?B?V2c2TG9Pb0xYQlZlVjlSV3psdGVEUG0zWEZIRnZ3bkp5cUFLek0vZmRpRVhk?=
 =?utf-8?B?K0krMHlSUC9oQTNEZjc4Z2FYcEEyUlJ6QlV4aHhUZU1vZWM0VW92UG51ejdD?=
 =?utf-8?B?NUQ4THRRU1o3em5IN2E3VVJNOG8xQk1KenFVR25jL1lQVFUxOHEvc1Jzb2JZ?=
 =?utf-8?B?clkyOCt4L0dCbTJRUFFxOTA0cmY0TVZLb284Rlo4dEdnU1BTb1lMcTJTcDg4?=
 =?utf-8?B?VDVxTGZkUEVCWjc5eGNRMklPOUVwNVhxd21hWEV2bUpYZVdaYlovb3VZSFF6?=
 =?utf-8?B?c3g5WnRaZDlsVUJMTHR3aDJZNzdaNGdublRqL3RmNkpxbWtvbnNTcTdIMEFT?=
 =?utf-8?B?TGhCc2s1R2QwR0MvSWtIc29yM2pIMVZjc1MxQ0lNTHlIa0VTazQ5NXhoNTV6?=
 =?utf-8?B?VVFPY2U5UU45bGV2N0NsMkhWaXFSMVRsb0d0Q2hkNXdGbGg5bndqc01ab1pr?=
 =?utf-8?B?SXRJalh4V3ZjWElSeXN5K29qS1lHOERibnZWMFZYRUl0RGtSRmZkTjlwZ3Zi?=
 =?utf-8?B?cG1WaU5USVh6R2wva2U2SHlsR3p1QmphRnkxdWQ3SVcyUXZTVXlUaEl2MGxz?=
 =?utf-8?B?SFkrSmgvbTJ5aXVzSDJtZDhDODhMb1RPM0dSNG55ekJtZlRHcXFFQmFxSEF4?=
 =?utf-8?B?V1pmK1l5WU9VdjFRaTYwVWsvQWZsM2RUVnZEZmd6QkQraXYvZW9namlORWh1?=
 =?utf-8?B?RzVBTDFRTkgySDBSdWRxUU5ZYU96USt2amVteUMyOG4wSGFKMDJwN1kvSGdZ?=
 =?utf-8?B?RU1mSVBYVTJsMzFCdy9HMXV5TUlsZDFSaDhkUEZwamFLQVAyQm5LcEhQWXdp?=
 =?utf-8?B?S3BscWhrRy9WQk1wQmJ2ZlE4dUliTGNEd3drdktTano2SzBDeHYycWtOU0pJ?=
 =?utf-8?B?Q0QxcFM5NXFkQ1BwV3BjQzFMa25yMzc3Z1FXSkZBOWdwUFViTngzL0VkbW9k?=
 =?utf-8?B?RmVHV1p6NjVuNmxvbGV5bFh2dzIxbVFZUmF3ZERsMzlEMEF0NXNDM2E3WUFF?=
 =?utf-8?B?VDRRN2RBVlVndG5UckZjY1IreHhqTWlDRXJvZGpIS055eDlrZkZYdWQ2TGFI?=
 =?utf-8?B?WWs1b3ZUTjBwYTE3Q0hZOE5KVlB1SXNQS292ZjFySVc3Wmo2M3dvcnpMTUZO?=
 =?utf-8?B?VWVqL1MvODhYVmJDcUpJZkcwbWV3bTl6bVJxUU1ndWovemVxK2NGSTdRalVZ?=
 =?utf-8?B?UWhhVGx6QlhIQ1hNLzJuZXdlN21hUGdGZHZaUTYvd1BKQldYYk5tOHViVUFy?=
 =?utf-8?B?cldzNXU0WHlYREJrUGRCcHBaREZheDhvWWs4S0J5UTh1K0lRejJ6OGQ5bWMx?=
 =?utf-8?B?cGFVTGhZYU9jMUVLUHBuZHNuZWdMbUwwbmRhRGFQRXBMUTRnb0hDVDhDb2ly?=
 =?utf-8?B?SGFhNmZMdW9sMjZlazl1RnR5VDYrRzlybzdxUDJSejdXNUw2cm96RmoxTVVI?=
 =?utf-8?B?N3pwdStaSXBUTFVoRVlqZHIrTUNSS0QrMStjWGt0aFJXUnpoNW9GWUZBcDBv?=
 =?utf-8?B?dkhTR05FVkFMTUNRbUFFUnM0KzBMWGpvSGM2aCt1N3B2YVBUd0FCNzYvTE1z?=
 =?utf-8?B?alhLZUw5ODByb2ZQUWtnUjNINlVobDR5MlB0YUlGWmVQbXZhZGxPcDcwcjZR?=
 =?utf-8?B?K28wd29CSkFkNGN0T2pHNkQvN2UrRHJ3WWFYNUVJdHVsMHB4OGdZRkRzMlN0?=
 =?utf-8?B?SEVBeW9pUlZ1VHVpb3dKRXJiUzdmN1diQmtVbEtVZHYvNHBkWDZ4cElaQUVJ?=
 =?utf-8?B?c1JKUmYxbHRrQ25RNnZsY0NmcXA5MjRjZ2I5QnNqUWpGTml3eFY5RWJjS0RN?=
 =?utf-8?B?THpVSW83Tkc2ZnhudVVnamQrYnVjTm91RWUxcXJMQzRIeHVISTRBdFNDcFJu?=
 =?utf-8?Q?bdG7vNy8y10E2QLQ=3D?=
X-Exchange-RoutingPolicyChecked: dyagTDB91TFM8mJfk40brlgDcB9tgUC6BYh6aqOfxCikNlKc+sWkqrT0fsp1DRHJpncYM7rS9c2bUY0EE+nVkjzHIxSu1A5lDWwsi1kR4wxOS7wwpb0R7RTLoGUfCKivDfw7q3ynciQt7U9nZdbtCV0n4Zc1e8XKgJmLxd9uJHFVH9pj+TWPFNkmZ6etX2BBzIC73t00zBbuHEOZrCseYoiv7qgS+YaUeu2uQ7R1eEwhx6LQtB42SeFiPCeyyScgEbjEchRreLpn+WXix6y/jhK5yG0OCNdjS/OeLziJabjefJVb9mWn22i9W7k+QeFWLm56WsFgHElcp2r+zMoudw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c16297-31fe-47c9-1e57-08de95b52db5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 21:24:12.3286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xQ97zHjNcgEWWG49MJL7V5xnU3upuoA3SZcb6i+vItcFFOLGGWrCazLeLKn9spetrhIJglNdvKVhQFGMbP6PPleJ9JhSeZYr9TPkgcJWPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9857
X-OriginatorOrg: intel.com

Hi Babu,

On 4/8/26 1:45 PM, Babu Moger wrote:
> On 4/7/26 23:45, Reinette Chatre wrote:
>> On 4/7/26 6:01 PM, Babu Moger wrote:

>>> That said, I’m open to not having a dedicated group if we can still support all the features that PLZA provides without it.
>>
>> I find that enabling user space to share CLOSID/RMID between user space
>> and kernel space to indeed support what PLZA provides. I think I am missing
>> something here since below proposal again attempts to isolate a resource group
>> (CLOSID) for kernel work.
> 
> No. I dont want to isolate a group just for PLZA. All I am saying
> is, we should provide option to create a dedicated group if the user
> wants to do it.
I agree. I do not see resctrl needing to do anything to accomplish this though. If
the user wants a group dedicated to kernel mode/PLZA then all that is needed is for the
user not to assign any tasks to this group, either via changes to the group's tasks file
or via the group's cpus/cpus_list files.

>>>
>>> The mode can simply be determined on a per-group basis. We can
>>> introduce two new files—kernel_mode_cpus and
>>> kernel_mode_cpus_list—within each resctrl group when kmode (or
>>> PLZA) is supported.
>>
>> I think having these files in every resource group is confusing since user can only interact
>> with these files in one resource group for current PLZA. Why not *just* have the files in the
>> resource group that matches the group in info/kernel_mode_assignment?
> 
> The default group can also serve as the PLZA group.
> 
> #cat info/kernel_mode_assignment
> //
> 
> At this point, the (kmode_cpus / kmode_cpus_list) files will exist in the default group:
> 
> Then user changes the PLZA group to "test".
> 
> #echo "test//" > info/kernel_mode_assignment
> 
> At this point, we expect the files "(kmode_cpus/kmode_cpus_list)" to be visible in "test//" group.
> 
> One open question is whether we should remove the visibility of these files from the default group. It’s unclear if we can safely do this dynamically.
> 
> An alternative approach would be to always keep the files present, but allow access to them only for groups that are listed in "info/kernel_mode_assignment".

The files appearing/disappearing is just how the user experiences the resctrl fs interface.
Within resctrl the files could indeed always exist but resctrl can use the kernfs_show()
API to show/hide them as needed. Similar to resctrl_bmec_files_show() that you created.
Allowing/removing access becomes complicated because user space can always do a chmod
to change permissions that resctrl would need to handle.

I do not know if there are sharp corners here when thinking about strange scenarios where
user opens a file before resctrl changes visibility or permissions and then user space
interacts with the file. This may be worthwhile to test to matter which mechanism is used.

>>> Files and behavior:
>>> - cpus / cpus_list:
>>>
>>> CPUs listed here use the same allocation for both user and kernel space.
>>
>> Both user and kernel space?
> 
> As it stands today, the CPU list is written to MSR_PQR_ASSOC, resulting in the same allocation for both user and kernel within a given CLOS.
> 
> Kernel-mode allocation changes only if specific CPUs are included in the kmode_cpus list.

ack.

>>> There is no change to the current semantics of these files.
>>> If these files are empty, the group effectively becomes a PLZA-dedicated group.
>>
>> I do not see it this way. If the cpu/cpus_list files are empty then it means that the
>> tasks in the group will use their own CLOSID/RMID for user space allocation and
>> monitoring. What allocations/monitoring is used by tasks when in kernel mode depends
>> on whether the CPU the task is running on can be found in a kernel_mode_cpus/kernel_mode_cpuslist
>> file. If the CPU the task is running on can be found in a kernel_mode_cpus/kernel_mode_cpuslist
>> file then it will inherit whatever the PQR_PLZA setting of that CPU which is the allocation
>> associated with the resource group to which that kernel_mode_cpus/kernel_mode_cpuslist belongs.
>> If the CPU the task is running on cannot be found in kernel_mode_cpus/kernel_mode_cpuslist
>> then its kernel work will inherit its user space allocations and monitoring.
>>
> 
> Yes. that is correct. I think our understanding is correct, but our implementation ideas are different it seems.

While we have been sharing different ideas I have tried to be clear on *why* I made
certain choices and attempted to provide specific feedback to your ideas. If you find
your plan to be better then please respond to my feedback about it to help me understand
why that may be the better solution. If you find your solution is better then could you please
describe it with detail? At this time I do not have a clear understanding of what you propose.

...
> 
> Let me make sure I understand what you mentioned earlier. Copied the text below from the thread for the context:
> 
> https://lore.kernel.org/lkml/3305c18e-9e50-4df0-b9f1-c61028628967@intel.com/
> =====================================================================
> 
> Please consider the intent of this file when thinking about names. The idea is that "info/kernel_mode"
> specifies the "mode" of how kernel work is handled and it determines the configuration files used in that
> mode as well as the syntax when interacting with those files. By renaming "kernel_mode_assignment" to
> "kmode_groups" it implicitly requires all future kernel mode enhancements to need some data related to "groups".
> 
> In summary, I think this can be simplified by introducing just two new files in info/ that enables the
> user to (a) select and (b) configure the "kernel mode". To start there can be just two modes,
> global_assign_ctrl_inherit_mon_per_cpu and global_assign_ctrl_assign_mon_per_cpu.
> global_assign_ctrl_inherit_mon_per_cpu mode requires a control group in kernel_mode_assignment while
> global_assign_ctrl_assign_mon_per_cpu requires a control and monitoring group.
> 
> The resource group in info/kernel_mode_assignment gets two additional files "kernel_mode_cpus" and
> "kernel_mode_cpus_list" that contains the CPUs enabled with the kernel mode configuration, by default
> it will be all online CPUs. The resource group can continue to be used to manage allocations of and
> monitor user space tasks. Specifically, the "cpus", "cpus_list", and "tasks" files remain.
> 
> A user wanting just "global" settings will get just that when writing the group to
> info/kernel_mode_assignment. A user wanting "per CPU" settings can follow the
> info/kernel_mode_assignment setting with changes to that resource group's kernel_mode_cpus/kernel_mode_cpus_list
> files. Any task running on a CPU that is *not* in kernel_mode_cpus/kernel_mode_cpus_list can be
> expected to inherit both CLOSID and RMID from user space for all kernel work.
> 
> ======================================================================
> 
> Let me try to get few clarification on things here.
> 
> # cat info/kernel_mode
>   [inherit_ctrl_and_mon]
>   global_assign_ctrl_inherit_mon_per_cpu
>   global_assign_ctrl_assign_mon_per_cpu
> 
> My understanding of "inherit_ctrl_and_mon" is that the kernel
> inherits both the CLOS and the RMID from user space. Basically both
> user and kernel uses same CLOSID and RMID. This reflects the current
> behavior (without PLZA) correct? This would correspond to the

Correct.

> default group when resctrl is mounted.

> 
> The modes "global_assign_ctrl_inherit_mon_per_cpu" and "global_assign_ctrl_assign_mon_per_cpu" represent the actual PLZA modes.
> 
> Both of these modes introduce new files kernel_mode_cpus/ and kernel_mode_cpus_list in the resctrl group.

Right. To be specific when the user changes the mode to either "global_assign_ctrl_inherit_mon_per_cpu" or
"global_assign_ctrl_assign_mon_per_cpu" the new files will be created in the default resource group with
associated setting applied globally at that time.

> 
> When the user echoes a group name into info/kernel_mode_assignment, PLZA is applied globally across all CPUs. This is default behavior.
> 
> If the user wants PLZA to apply only to a specific subset of CPUs, then the kernel_mode_cpus or kernel_mode_cpus_list files need to be updated accordingly.
> 
> global_assign_ctrl_inherit_mon_per_cpu : The group needs to be CTLR_MON group. This mode uses rmid_en=0 when writing PLZA MSR.
> 
> global_assign_ctrl_assign_mon_per_cpu: The group needs to be CTLR_MON/MON group. This mode uses rmid_en=1 when writing PLZA MSR.
> 
> Did I get it right?

This is my understanding also, yes.

Reinette

