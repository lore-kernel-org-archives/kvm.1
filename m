Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013046.outbound.protection.outlook.com [40.107.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AE818DB2A;
	Wed, 22 Apr 2026 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776817091; cv=fail; b=RMLOSxol8yAatEkqqIujDwyayl0obLCjnYe01fV6Sr+XBm0S2hnvk0YWU9iGb6I6ErrOjStBBrBfPSR2+RARfc6nvXDIKRX14caIGwceJXbSD1ZTPSGFaur2zAQdgfi8JvBs7XVJnFBzKLGN6d88VVZtlmTBNpL1SWdcstNOTCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776817091; c=relaxed/simple;
	bh=DTtqFqU0ZLwldatbG5fkCJdqNwDADlJmr4MjQ6Uc/ks=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=upBe1WrTQIx89efXBLYLsm0ryd4fATSqsvM+Na+mFQEJFl527YwUCmDdWL6zTCWP7fy1Uf9AFBun2db15cTfXFSGjWu6MOmXnLKOgb1rpiKd3xcepBdy8FCYk0YAmUM2GWstyIqWo6eAkLcowurQ7eW+4bQSdYJPmUD5XoUErwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fQiQh2Kk; arc=fail smtp.client-ip=40.107.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fQiQh2Kk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3uMAfCZlA1z4IRa1/yz1x09KjqWHGOfcwdeka9UiL14A4o6qtbl5TQrqOtd7xzVfAkQymFAiz5DKUIyao19EdZf+BNNi62ijdWGzRfB1PuTYdoHQH0UH0xfNZWgSmdmvpCD8qvuWgW8r37m21X+oNiZFyZRCy7DGkNXlQ+J85vlgu9L9/+/jVifGLjbwfHU74NKFzzW9/MbASr4F85nJ7EQoKc80/3P7XS9IEL+81FHidI42UOWJEQPc0a1TnZ7tUkxffYltwPB/1YAyCqJuNhCADTXsuAMKIe+u7+lcDFwzCo9zMcWcWew5edGH2s+5hbXNFdF7G+CrT+OeH2jjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y35dCVE9/4xt1R2eZStHjHIAPI5yFxQi3TpMZ2wUJIM=;
 b=EyCNu7++rbgKz9tG5n53fmTKxGdAX6gbaPCxeLyHjzuE0j7/NvoATjXjgvICjvdKNRZ7Ge2GVqzi9lq+eXNfGOBvRgOjvH4OdM3GRXBL8qx4eC+f1eBTpzCXbIhR/gQMned13bv/jk9RA9aeHdRSfDuTQ+xGigyLQWWnpLx4WJcDWcQVuXSVGl36NtVYy+P4OmuCqqqcms+V8qT9tiLn/CJKdxjMwc94NRxg2Nb5ZyizMbjecz5Eps+Vc+hCSP4g9TB+754YUqJKwod0GOG5zVOgi7j2stPBYoi0r4bTNicBdycIl2R0c4d6EarWcb31AeJxeSvfjiFe7OUkEuNKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y35dCVE9/4xt1R2eZStHjHIAPI5yFxQi3TpMZ2wUJIM=;
 b=fQiQh2KkTAndyK1p8Nh292VkT6+XhoMHYCHFjLkJqJ417d1PX8Dja3+d3RCQ2WvbiQiYiE8g9eX8cK42ti3YRylseIYVOZ6MicyS6iWWbofO6S8d4yDAqprdHZN9VpppocG76b+GJ0XUUDND4l8GBUGovvZqBaT+TZL9f9sTBso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by DM6PR12MB4203.namprd12.prod.outlook.com
 (2603:10b6:5:21f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 00:18:05 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::ca9:67f1:6872:decc]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::ca9:67f1:6872:decc%6]) with mapi id 15.20.9846.014; Wed, 22 Apr 2026
 00:18:05 +0000
Message-ID: <39da36be-40a3-45cb-8e49-12dbb59aca74@amd.com>
Date: Tue, 21 Apr 2026 19:17:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc: "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
 "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
 "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "bsegall@google.com" <bsegall@google.com>, "mgorman@suse.de"
 <mgorman@suse.de>, "vschneid@redhat.com" <vschneid@redhat.com>,
 "kas@kernel.org" <kas@kernel.org>,
 "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "pmladek@suse.com" <pmladek@suse.com>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>,
 "kees@kernel.org" <kees@kernel.org>, "elver@google.com" <elver@google.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "lirongqing@baidu.com" <lirongqing@baidu.com>,
 "safinaskar@gmail.com" <safinaskar@gmail.com>,
 "fvdl@google.com" <fvdl@google.com>, "seanjc@google.com"
 <seanjc@google.com>,
 "pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
 "xin@zytor.com" <xin@zytor.com>, "tiala@microsoft.com"
 <tiala@microsoft.com>, "chang.seok.bae@intel.com"
 <chang.seok.bae@intel.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "elena.reshetova@intel.com" <elena.reshetova@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eranian@google.com" <eranian@google.com>,
 "peternewman@google.com" <peternewman@google.com>
References: <cover.1773347820.git.babu.moger@amd.com>
 <5a273b0f-8225-4e9e-924e-884183734659@intel.com>
 <73c46024-4cf2-4f03-9268-d4378825fa87@amd.com>
 <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
 <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
 <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
 <39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com>
 <b74cfe34-e23e-49e3-beb4-d5639d42d5cc@intel.com>
 <99a2da36-6a21-4a99-98e0-3c9a4cf7ecf6@amd.com>
 <741aa53e-461c-4a1a-a701-6060d42012f8@intel.com>
 <e8530c71-fde2-4522-8b46-a24efb13b681@amd.com>
 <71099958-1ddf-40dc-8a3c-aa13d0c56fee@intel.com>
 <e624f652-f0a6-4926-a0ab-c4486d41eb6d@amd.com>
 <8d969f11-4a7f-4e36-b85a-c3ed714fc603@intel.com>
 <a46f4f2d-e3f1-454f-b94b-c54e14e45a69@amd.com>
 <0334ba64-71b3-40bd-8cce-9f0f119e7dc9@intel.com>
 <d693f797-65f6-46ed-bd49-beaeee2da858@amd.com>
 <c9e10de7-f5b1-4a38-be1f-f75bc1ae7780@intel.com>
 <9d8a18da-14e4-4d90-a224-7d69d4daeb13@amd.com>
 <de608041-bc45-4ca0-81fe-423a5167d7d0@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <de608041-bc45-4ca0-81fe-423a5167d7d0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::26) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|DM6PR12MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: be17bd27-80db-430d-fa1b-08dea0049f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yjG1uzeq3Rwl4BiD05pvJS7pz1DyzKglemgbyTFsp4rRepVcYa9DW92CckBbMngTcy2kYrsgPK/c1On9KI6mEvLYTCok4EHrKXcMV9wPUWaaWVlB6qgNQp/a70SFYvNNk3CnCH/YVNTpWbvIjkt5x+yD1D3d7S+8swCP9sLmtWLnweGnrhmRmAwhOUzOtInIEIl7mi/OSCSM6AaBS+MfNvgKHdgaaHY0oMjsPasmMFWjOPSyWKW4z/wLCQo0H+mI2VbBKy0KgFwiQwM1lt965jQzNJj46EdnwJB/yW6DFcq7TYTWK/8wPqwEcEoc8z752Q/CpDJMOFyFbtdlRkfUcegtDDmAUzjdMLsoYuskFEutvIH8uTdI7KwivUE8X058R1HKuvM1JXeIkbIPoPPdUJ2y67efakIM/o2GnGFHcYTHTxG8920DxIcFDRjgVtOA9m3UMQuuDUaPR9iw4tVoL4iRn+mnENou5zBoiwYw55EcU0QeEAfw8yudX7oEzfam3Vjn77nCHw4dWwz8BmI1Ku1zJxRSc2SxPs9wYDkwU6yaYV/LMYY7IWc/3A+NpeyrHpN8agj45DRbaf2ay/SdRRcC6PAPwV2wTgQJU5kRFbRGXnttPEjbC2Vly1mOC+pCPwwAhcEY7j7VbiulFo2Hvs19LgWY+0+AmNt9CZ2Wd7SCZ6Ub9/GVJyGQB5f7dm3IsN4pVpe+RH/PnCQBCqkPxxcsozRwVhldz4rBySuarQk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXdRa1c0ek5YVUhuZVRrbDR2eHZDYmtVWTgrK2tvdzRtNkZOTlVGVWNiSVp4?=
 =?utf-8?B?TjBvaEFiOWtRSmdUSGUySUhZQnJoOUdIN1FhM2g2dUViNkV3RDZ5cmVsT0hF?=
 =?utf-8?B?Z0dSWHF0anJNb2JoZGZqdTZKOC96aVQ5NWtnL0pjdHZ3YkhiZlNsNFh4aVB0?=
 =?utf-8?B?THVjTURtRytDUzZLZFFRbGU1QUJPbThTQ25CQ0lMdnFNYVpPMDNEaWYwbXI2?=
 =?utf-8?B?eWwzY3ZCZmNnVU9CRkJNbkZrVEFidU91bFZwUjM4YktTUHFmKzZiSFo2SDVQ?=
 =?utf-8?B?NVEzT29qN1lmWE9INWhIZndMV1JEc2VHWmJnQ0wvSlFqcUVaeFJGMVZZUGxr?=
 =?utf-8?B?U1cvaFRpb3ltTGZlTVdtTThYWTE4RUlqdlJRTjA4NUNTOEZ0b3NPYzBuZ1J1?=
 =?utf-8?B?UlVIMitKREpNR2J0amVSSjQxbklLTlZFeXVyYUZMYzdtRFprZks0enFlRlk0?=
 =?utf-8?B?UlhBYWJmTFArMHprOVNXTnl4ODUwaC9XZithOVYzUEUxZEUra3RQL1ZZVElV?=
 =?utf-8?B?dzAxZ0FJZlpTem1XS3FUS0ZDTXdHeGlFRm9oQ3YzRWJ5MENtM25kbldjZzZk?=
 =?utf-8?B?aFA5UUVFcnNiYmJjM2FlMFFxYUtBREhZM015RUpVYzAvOEh1SnpWTmczQzZI?=
 =?utf-8?B?ZVFMVFVKSFdvclJsSHh2UUlGLzhZQVpsVkUyZGtuRGJMWU5NQzRnYy9NSGky?=
 =?utf-8?B?N1hFekNWOCtHMnpIeUM4OGw0c1F6WTIvOEUvSDc3S1U4emZQdDlabUpSd0pV?=
 =?utf-8?B?amVWSXpqeUlKQWRNMnd0NnhpVXUzOFZhdHp3UGlvOEo5akptU2c2UUlvbmRq?=
 =?utf-8?B?UDl4dkRITkJWcEZvNjg2cC9ZOG0ySTEyZ2JPMHV5QU1PTzZqb0FkalNNSHFX?=
 =?utf-8?B?RVBQc0FJQTNqTGp2MEVUa1g3UERyUitWUk5Fam1SWFB5Q1NDbVB3c2x3L2Z1?=
 =?utf-8?B?d3Yyd1VCZ2xXelNzR21KeUFReUV2UVB4WituanlFMjR6bEsvTk5RQzdYeVhl?=
 =?utf-8?B?SVRaZXN6enFRVGQ4QzNBOEdNVXlITFdkV0h5Zm4rN2lYUDN0VGFvVXVVQm9T?=
 =?utf-8?B?UDIvemJOTEJhV2dWMVl6cnh1ZzNKRWV3M2laaFozRWZDN09CSlJtK0gvN3lF?=
 =?utf-8?B?WlpjaVBjUFkveUU0N0Vwb3VtY25uVmRnYjIrR2x1SFkrN3UvWTFzR0ZUblY3?=
 =?utf-8?B?UjFML1lKRElxcDM2WE1nZ0svamJuN2ZOalRkTERvMWdYaGRHTXp6UVJ1RDRq?=
 =?utf-8?B?K0tYSENxQlFQVEJTQVNXTjJtMTlCaHVlUm5IOThEclR4djhmODJTMlZ4b1V5?=
 =?utf-8?B?V0VaK2dvNnpaUEFQbkJzSW5yNFUraDhmdFpPWUg4Sk1CR1BFempNbmRCc3Vi?=
 =?utf-8?B?d1RuNUZ3TExFT2xhVkJrSVlHaTVvUjdWY3ZncEthUVB1RmRrcGw5M0RtNDdk?=
 =?utf-8?B?cGl0bkkwUmFMTU1Ta2RHaFFXcDNYbmhMblRQNGRMbDNKdGVkWHp4dERTaENk?=
 =?utf-8?B?UnV0QWdXYjE2N2RnbmFHOVJpbm95ZmxpU2ZuTlZqYUpmblFGQ1JITHJlZ0Z3?=
 =?utf-8?B?MXlndmt1VzVzWDZjVEE0ekhRdUFkOXZMRWVWQ0ZXME9QZUQ1WmVRMjQ5aHFJ?=
 =?utf-8?B?TWNLSUVDK1ltRXhTM1hZakh3R1BNSWdrTUFaa0sxeGZ0aGxPRXpOeU1kTGR0?=
 =?utf-8?B?MFVRK1UrT1hPQzVQcUxyZGdQcjhqSkk3aTZFWkNKckFlVUxGcVBraWl1NTg2?=
 =?utf-8?B?RXVWbFB0UXUrU1c3THprd3FDRHV2TzlkRDlKS2VneUh4cHMwWFdrUStUcFZl?=
 =?utf-8?B?dHFzRU9HUFpoa0R1bE1tRXpPSnhIQjE3RGZ5MEJQeEhjdmFUZ1oydHg1bFFT?=
 =?utf-8?B?bE9SUnJpYWJydjF5dnpSOHBuektGRk54MzRBZ0NidlpuZHlUWk1nQ0Z2TXdV?=
 =?utf-8?B?dUZuQUt3ZnFISndQc1ZWY2lPWlB4dHYzRkY3cWY4SGhKVGtUVHhjamE1Uk5t?=
 =?utf-8?B?akJmQjFsWXdNVkpFRHc0cklqeGsvQjVZWktNUmFzNXI0NDQvTmg0L2NLWHkw?=
 =?utf-8?B?SmZuVTRmVGpZSDFsL0dYZnFzN2tXekxlc1B4M2h5bzFCWElOV2VCeGVoY0Iw?=
 =?utf-8?B?c2lPMU5uS3J3a2Z5U2VwTGZwV2tNSkFvclBhMk9vWVkxVlZQUmt4SkloSVA0?=
 =?utf-8?B?anZ5clNvTHZ4U2txUDk2V2t4d2JiajhQRE1FdHFjTE5kUzhzRFJJNmxIdE9Y?=
 =?utf-8?B?SldydTZsUzhSdElGNUI4U3FJQzJPWWRlSUFIWk1ONmJNVCtqQVUxTnpRanBy?=
 =?utf-8?Q?w9JoMCy/xP3TOWiMFZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be17bd27-80db-430d-fa1b-08dea0049f74
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 00:18:05.1275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCSYM57ldpHXKXJi4rzDdJB2hQaqdQ1aWirRYYphbr2TuqBcw+X79cb4JsJ+366e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203

Hi Reinette,

On 4/21/2026 5:44 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/21/26 3:04 PM, Moger, Babu wrote:
>> My bad. My only motivation was to keep the mode listing display consistent.
> 
> The listing display is already inconsistent since the different modes have different
> global properties, no?
> 

Yes. That is true.

>>
>> That said, I agree we need to support this. Without it, we won’t be able to move the group from PLZA to non-PLZA.
>>
>> # cat info/kernel_mode
>>      inherit_ctrl_and_mon:
>>      global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
>>      [global_assign_ctrl_assign_mon_per_cpu]:group=ctrl1/mon1/
> 
> Like above where the listing is inconsistent. Is this what you mean?

I meant the listing of "inherit_ctrl_and_mon" does not have groups while 
other modes have it.

> 
> sidenote: Should the last line be "[global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/]"?

Yes.

> 
>>
>> # echo "inherit_ctrl_and_mon:group=ctrl1/mon1/" > info/kernel_mode
> 
> This does not look right. Why is a "group" property needed here? Can the mode not just
> be set by itself? Specifically, why not just:
> 
> 	# echo "inherit_ctrl_and_mon" > info/kernel_mode

We can go with this based on your another comment below. While changing 
the mode use the defaults if properties are not provided.


> 
> This reminds me that there is still an open remaining from
> https://lore.kernel.org/lkml/71099958-1ddf-40dc-8a3c-aa13d0c56fee@intel.com/
> Specifically this from that message:
> 	The named fields could be made optional, if group is omitted then it will become the
> 	default resource group, and if cpus/cpus_list is omitted then it will default to all CPUs.
> 	This may not be intuitive since a user may expect that not mentioning a field means
> 	that the field is left untouched. Have you considered this scenario in your proposal?
> 
> I think this needs some clear description of behavior wrt properties, for example:
> - Is it required to provide all properties on each write? More specifically, can user expect there
>    to be "default" values when a property is not provided or is user required to provide a value
>    for each property? We need to be careful here because we do not want user scripts to fail when a new
>    property is added in the future. What if resctrl specifies that if user space does not provide
>    a property then resctrl will pick a default. For example, if user runs:
> 	# echo "global_assign_ctrl_assign_mon_per_cpu" > info/kernel_mode
>    then resctrl will switch to "global_assign_ctrl_assign_mon_per_cpu" mode initialized to
>    the default group.
>    I am not sure if resctrl needs to support re-configuration of modes in the future where the
>    mode stays the same but a property changes? Consider, for example,
> 
> 	# cat info/kernel_mode
> 	[inherit_ctrl_and_mon:]
> 	global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
> 
> 	# echo "global_assign_ctrl_assign_mon_per_cpu" > info/kernel_mode
> 	/*
> 	 * resctrl switches to "global_assign_ctrl_assign_mon_per_cpu" mode and sets
> 	 * PLZA group to default group
> 	 */
> 	# cat info/kernel_mode
> 	inherit_ctrl_and_mon:
> 	[global_assign_ctrl_assign_mon_per_cpu:group=//]
> 	# echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/" > info/kernel_mode
> 	/*
> 	 * resctrl stays in "global_assign_ctrl_assign_mon_per_cpu" mode and sets
> 	 * PLZA group to default group
> 	 */

I think you meant "PLZA group to ctrl1/mon1/" here.

> 	# cat info/kernel_mode
> 	inherit_ctrl_and_mon:
> 	[global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/]
> 	# echo "global_assign_ctrl_assign_mon_per_cpu" > info/kernel_mode
> 	/*
> 	 * TBD: should resctrl switch back to default group or just keep
> 	 * group as ctrl1/mon1/ ?
> 	 */
> 
>    resctrl could thus specify different behavior for switching to a mode where all properties
>    not specified obtains default values and re-configuring a mode where only specified
>    properties are changed. That means, the "TBD" above would be that the group stays
>    as ctrl1/mon1/. So,
> 	# cat info/kernel_mode
> 	inherit_ctrl_and_mon:
> 	[global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/]
> 
>    What do you think?

Yes. Sure. We can do that. We only have 2 properties now (mode and 
group). We should be able to handle that.


> 
>> # cat info/kernel_mode
>>      inherit_ctrl_and_mon:
>>      global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
>>      [global_assign_ctrl_assign_mon_per_cpu]:group=uninitialized
> This does not look right. After switching the kernel_mode to inherit_ctrl_and_mon
> I expect inherit_ctrl_and_mon to be the active mode?

Yes. inherit_ctrl_and_mon should be active here.

Thanks
Babu


