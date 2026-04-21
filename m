Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011064.outbound.protection.outlook.com [40.93.194.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7159C288C08;
	Tue, 21 Apr 2026 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784121; cv=fail; b=dA/LlEZFsB0ZnnoE+jSnrqeqtq+ESdp5cNPI/KmkDYPbRdrlnMB66tef0zo+GA1EVN6Rk8Bz+m/f45PElgsuuRcFhNDYSxrTH/+CtlZWYAvABI0zMExyihVkYCR+DARyk577MKcFrmrC3voA/u6YfM/R3L+V0PjhxMQ6auez+n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784121; c=relaxed/simple;
	bh=wm6tFnPw4syVVc8p5CnxCuCyBCR2mPndoEnzmBx2HJ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sl5VjBJ9OblppzUsVroJOtRzXOYk0UCz9T4N6sn//X/U/PeT5zFRG/+1Idg9xnTSInDQcCOdn3JOFa5GTYdudCRwyFx4SPFcsOmvJbjp415+sH24RDoAURQhA+sJO6YFfMWDuCCHLdHPGAQeSZlNNl4KRIWrv39kRNbAKYYw8Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ELVR5JOU; arc=fail smtp.client-ip=40.93.194.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ELVR5JOU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnD2rnq5Qi1leNMSEW7eT4X0yurrw5Ir9fjtvazPQNNEZyRPVgl2X0kmU5lhjLkW3+RTi2wQNfHsj9S5Go+njV9ZUq618RnMiod/mwADrMsw526TZ1snwtRtD7Iz+0oyHG2GnKW+B6nlq8ADJ9rGgPWBWUlb03jxaIzLB1NnnUwNDyZKqioCGUT771SLOsGOcz4gYuekxMDHBZ9hESf+zLnvJwSn5Cxv6fleCOFrguRCkmuNnYIsCTes+WgD6kxb8udrb3ITtdLNDiMJwtwS3tJdCHQwmII+XehvYNKdsJ0RySk4UmOfybG1wcy45ITqI3ORsf4e3kBWe+hcnv4l/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztSQAXbNEdCO+8IlHWWX2TBBCor695MXMuNXET9Hu2Q=;
 b=sN9nEfow8Y+Ig3ZAgofYt81iiDjwWkAO+VLxR49LAYK09lUV8fKUtQd2WFfOPN9L3q/g/plSZQqlLFaD4x/hCrSJ+t//Jp5knZwDMeZPKcfuqLZN2HDd0DIjZax9rKGq/Ij0RLBaB1AS4oj1W6dqwV23db0ADkdWlRHW9qOiwuwcBtYERy3zGkCFTw42ByAEgWcrBiDJzMJMcohC4lJb4VrsW2ZfDrsAfyRvisO22FMvaPXmpLYu8uPk5/A6juQydRsbyMvKlwVyD0TxPwtm4VOWo8X4P89dq7q5yYnVaRpT7YgfybDDsIhnOXSDLhfq4wsdPqZJLj7eklH97ofBEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztSQAXbNEdCO+8IlHWWX2TBBCor695MXMuNXET9Hu2Q=;
 b=ELVR5JOUcG2Q84Wh7qmiHOfL9unHEdF0P5mymhzFY8daRG6zii2k+/5yTT02JKSlyn1Deb+x6jY6aYzvZwvlSc3l0NcOqraZ5A+oYfV3wm1XK1I/Fb2nXpBUnetuz6eUStK8ZPoVnfA3hjoZL5WqsfFVBzgwW0bvB43TaE+7FsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SA1PR12MB7038.namprd12.prod.outlook.com
 (2603:10b6:806:24d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 15:08:33 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::ca9:67f1:6872:decc]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::ca9:67f1:6872:decc%6]) with mapi id 15.20.9846.014; Tue, 21 Apr 2026
 15:08:33 +0000
Message-ID: <e624f652-f0a6-4926-a0ab-c4486d41eb6d@amd.com>
Date: Tue, 21 Apr 2026 10:08:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: Reinette Chatre <reinette.chatre@intel.com>, "Moger, Babu"
 <bmoger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
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
 <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
 <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
 <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
 <39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com>
 <b74cfe34-e23e-49e3-beb4-d5639d42d5cc@intel.com>
 <99a2da36-6a21-4a99-98e0-3c9a4cf7ecf6@amd.com>
 <741aa53e-461c-4a1a-a701-6060d42012f8@intel.com>
 <e8530c71-fde2-4522-8b46-a24efb13b681@amd.com>
 <71099958-1ddf-40dc-8a3c-aa13d0c56fee@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <71099958-1ddf-40dc-8a3c-aa13d0c56fee@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::32) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: e773abcb-48d3-48cc-bc46-08de9fb7da5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|56012099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	GApIARQ7nm+YhBAz2rdtAnEcvOYvt1fcBdVtps19kBEtLKjlHjdageDHblO7sWIPhavp0K2B+eSXwAG997EsOY32Xg1IdKmJ7KiZHOTeCM91607otVfwcQRybSj4n/F5tCHdp6w/EzU6vQMd1/nE7YAJgdNMXQx3M7rG3j5uTpHGhkziMWW0VngxUcXgm2fdc6kV6HWb16Ul/9Pp3z18ZtYsvu0iHig7hxf30CXXAOdyAl85NszwT4g4Vdm6OnHtFOb+2UB4f8ncUBJUWJoIT19ebZ9wVUxohUF9PTyE98EM9ufrCbRQn1n+1SD3kN2BH9J4RrjDWpMlBg2Qk1DNZZgx9JrMNtS5Q2Xf0Dnx8mSBvF3tyCLdroByyIdss/cTg6SSL0vJmdfoap4AQECqDG0xgq1SiPmMN6O8WUINu4yeTpl42Uw++Jn9voK+Br8Q/pQexc3FUz18MMUUz4TziwTyofZ0fua0jLWZhT7KPEqePRmWnku13AcJVbkqKX4acDSqmDQ8KtRXoZVf3OJOJhQXIUXJ67GgSmnQa5oKg9GemHDolPVUUADlJxE2e2swX5ABdVctTiKvnMoTT76jT8Kdc7X1OxTs4mPEsNCWKRup5evOzZRuz5+i2k3jDeMhPRU/MNWQirN7WdMU+3HVIsPTrUAGR/Oyu37yvJEcy4Av/dcwA7BBg6NzRNOXdfyXBz9Mnba9Sr3YrMgruGlUs/gziKGzPhynNmbfowLIAjDzEt4BHJJ/hDg/9Iv7eTEs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVNRbDRtazlraW10WHN3OVVrRU16bXQ1blRPQVJvZ2h1bVdDQmhkVTJXd0Uz?=
 =?utf-8?B?NjRERnJuTGM0RHNDb09wRVU4R3owVU9Nb2pzdTM0VEZNOUZtaGMvZmQwU1dk?=
 =?utf-8?B?Nm1Pd05DWXRKNy9nWDV1SnBLc1hyaEJRVmxQVWVnS2FucmZ4RDNJQlkxVTlw?=
 =?utf-8?B?Q0tGZnJoYzhvRlEwWWRjYWpSSFBsaXh2SjVQN2twVUlNaEM2cForTlk3YXc3?=
 =?utf-8?B?OVhEK2VDcG8yQWU3YmZTWTQ0NjVJTkZsUmtNTG9vTWVqVnlrYW00SFAwNk1E?=
 =?utf-8?B?b1JrWHA2bFIwaHRqOVV6dEV1TGpmYU5QdGVoZDhJNUJ3OEdvQ1lhOUZ4Ymt5?=
 =?utf-8?B?QzlRYmIzVGdUaHNJQThDeERnMk4rTkw3dnBGYW1SNW03MDVvVm9iZE90NGZY?=
 =?utf-8?B?dSs2RlNNTk5TNkN4R0VIWVU2ZGQ2aGl6RFVyWElReWRGMkdWNkhyMjNYQVF6?=
 =?utf-8?B?YUpRdzQrNlN0VzM5ZW04UUZPbHNoZjc2ZklGOHhLYWVSbFJQeG9WUmhzd041?=
 =?utf-8?B?SFg4TEs2ZnNLOW5IZGhudFo3R0h1c2RZamt1b1dva3dLQW9uMkpxRlkxSitX?=
 =?utf-8?B?WFhnbnhSVjRGRkpyU096WFdNeHNjWEpId3dZaDhXNXR6R2Zrc1BCL2pza2M4?=
 =?utf-8?B?dXNnaGFoWjVscHFoejE5V3lIbE1Oczg5V1gzcFI5ZGNGZlN6M1BSVm5SRmth?=
 =?utf-8?B?R1hxblNPa3dXK3luUE5RcTVpNWxETXN1ZnZselUzSU83cTZLcGtteTBRNzFF?=
 =?utf-8?B?bHVUNCt5dlU1Ky9CcVJCeUdGeS9ya2lxZlUxSVhVcDJKRGROdk5ESXF5ODlr?=
 =?utf-8?B?WXRQQlJrOXRZSXFYcFFtWnlRWTVISFlNRm0rNlMrZlVvRVlPakZIclk0SlY2?=
 =?utf-8?B?SjNkbmdKVDNhUUhyeEJlRWQ5bnA4UWFKSnZacDJnNGgweVhwYVRHZHM3S0p1?=
 =?utf-8?B?UUUxczRBRU1aNnpOaWlwSDd2dkNUdjcxdGxSY3E2cnlWNG01WXRQenBiMWh3?=
 =?utf-8?B?cUQ3MTBlMjh0V3FaVnczQWYvbHNsOGUzTEZZalNkaFMySnRzSjBqM0ZDaGRS?=
 =?utf-8?B?bXpZVTJJcG51RGdGajlGTEUyZE11dUZoSngwVFhka2dWUmlmakFOODAxbU4v?=
 =?utf-8?B?SG5TV01ETDl6WWVlVHY3TUFJQlJLbHhhc1JjNGd1UEVXWnVJUDlFL0ZVWlFn?=
 =?utf-8?B?UkNQUDNZTFR6NXVkQ3kvQUs0ejBxbmI5bmVLK2piMmMyWS90ajBGNjl2T3BB?=
 =?utf-8?B?U0NodG9mT2Jjc045UWdIV25sdkxKcVdRVlR5Mmt4Mld2Rmpva1YwaFBDdWl6?=
 =?utf-8?B?MG5hUkdqRmpBR21OcFVUUnFWbVJibExmZ2RWNVFRVkNFbVdyb1N0TnNXSW5h?=
 =?utf-8?B?QjBTd21TU1lNejU4djk3aGFveFFqL3l3b1BqVVpQMkNMKytVa2orL1gzclB1?=
 =?utf-8?B?T1l0OWZIcXArZXZ2YWhPeUlwTWgwSG1ESG9IMWNjUGh4dUxYL3pXYzZneUQy?=
 =?utf-8?B?cU0zblF3S09Ma3FKT0NVWFpNZGRCVlQ4MWNsNUtEcTFudnNTVkNrR3pXL3l3?=
 =?utf-8?B?YUJnMTF0L0VVcmhYMENETHNnMnlzS05ad1Brbm1FRllMWlh4VXlnb0k0OWw1?=
 =?utf-8?B?OUZXTEpxVEx5SDBMNnhCbnlBempLSU03OGswNVJ0dUdWWE5PTXJzODRvQ203?=
 =?utf-8?B?NDRMYjBCa3Y4SUs1ZnY2NWJQZUgvcEJqeGZjdDl1Z2tUcW85SytuNkRNamor?=
 =?utf-8?B?akxQMUJxZEgydjYxbGFoYjlMNlQyZVlyWnBaR3N1ODZ4V2RFWlF6QWpLcTc2?=
 =?utf-8?B?NGVwVDhsNVpMVzB5elJDSzdSOVRQUXljSk43MVZBY2VtY05kbnNUTGRYTFBS?=
 =?utf-8?B?dEtqM0xsMnE3ZDBkQk0xd1NzRk13THZsVkhwOEM0RTdlQTA4NVVNa0poanVa?=
 =?utf-8?B?dzh5RzJ0RGJvZmNIVVdwNnV4dnkzeC9xdzVDVlVQSkZ1aHZQaTlHRW5mcUFz?=
 =?utf-8?B?QmIwejFwdUt0RVIweEVuM3JWMHFJNTg2Si9uZmZLcS9aUXRtdHRxTmdRTWxm?=
 =?utf-8?B?MkVKdGdSbzJRTFFOMWdWeDJLTXR6VkhDbVZOZzIxSUUxTUhhYUg0NFkyZ21P?=
 =?utf-8?B?d3FQanRWZlJQVldUZjF5L2NCbzRsdmRodEZSNjZTMVNucjRnUVpmRVB2YmQ4?=
 =?utf-8?B?WDVGWS90RG56Nkt1Tm11Z051L1ZHdWdBd2VMVFBGUGRCSnAxV2VzelVpUVRr?=
 =?utf-8?B?RVBIRkxZUzg2aE5POVpuSEtwVTlFOWVsWVNRRW9hZm90cDgyM2RLWnNjRkRM?=
 =?utf-8?Q?lV18x1AlvuH5JSfJA3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e773abcb-48d3-48cc-bc46-08de9fb7da5f
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 15:08:33.3776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MK2ZfgpcMjczIfjm0cdP/35D5FztZ4JNP9Ue/divxX8clg94tkwezXcM5IGLfEly
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038

Hi Reinette,

On 4/20/26 22:17, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/20/26 5:40 PM, Moger, Babu wrote:
>>
>> We already discussed moving back to the default group on every mode
>> switch. Doing so here would once again cause extra MSR writes on
>> each mode transition, which is undesirable.
>>
> 
> Needing to avoid extra MSR writes in resctrl is not so absolute. Consider, for
> example, how resctrl initializes default allocations when a new resource group is
> created. resctrl aims to initialize with sane defaults and the user is expected to
> follow with desired allocations.
> 
> I am not against optimizing, I just want to be careful with such general statements.
> 
> Considering your proposal in https://lore.kernel.org/lkml/39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com/:
> 
> I do not think we should make info/kernel_mode read-only. If I understand correctly
> doing so would accommodate AMD PLZA but it ignores the discussions on how resctrl could
> support MPAM ... or do you perhaps have proposal on how MPAM can be supported when considering
> your proposal? Even if you do not want to consider MPAM - what if the PLZA_PQR register's
> scope becomes per-CPU in the next version of AMD PLZA?
> 
> The idea behind info/kernel_mode is that the active mode it identifies indicates which
> configuration files exist to configure the active mode. Since the mode may not always
> depend on global configuration, for which info/kernel_mode_assignment was created, but instead
> rely on per-resource group files, I do not see how resctrl can build on a read-only
> info/kernel_mode backed by a mode and group change via info/kernel_mode_assignment.
> Specifically, MPAM support may not use info/kernel_mode_assignment at all.
> Instead, MPAM may use something like described in https://lore.kernel.org/lkml/aYyxAPdTFejzsE42@e134344.arm.com/
> 
> Could we perhaps consider dropping info/kernel_mode_assignment entirely for
> AMD PLZA's global allocations? Similar to what you suggest, the mode and
> group assignment could be done via the info/kernel_mode file instead?
> 
> Thinking about this more since the CPUs allocation is global, these could *theoretically*
> be included also (but see later).
> This could mean that "kernel_mode_cpus" and "kernel_mode_cpus_list" could be dropped?
> Although, this may complicate the interface since user space may want a convenient way
> to modify just CPUs independently from needing to repeat the mode and group every time.
> 
> Consider, for example:
> 
> # echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/;cpus_list=5-8" > info/kernel_mode

This looks reasonable.

> 
> Having named fields (a) makes this extensible, (b) output does not need to be split among files,
> and (c) "inherit_ctrl_and_mon" can continue to be supported.
> 
> The named fields could be made optional, if group is omitted then it will become the
> default resource group, and if cpus/cpus_list is omitted then it will default to all CPUs.
> This may not be intuitive since a user may expect that not mentioning a field means
> that the field is left untouched. Have you considered this scenario in your proposal?
> 
> As an alternative the group could be made a required field and "kernel_mode_cpus"/"kernel_mode_cpuslist"
> can stay? This may be the simplest approach.

How about keeping a single option to update the CPUs using 
kernel_mode_cpus / kernel_mode_cpuslist within the group?

Should we consider removing the per‑CPU extension altogether? By 
default, the mode already applies to all online CPUs, and any per‑CPU 
requirements can be handled within the group using kernel_mode_cpus / 
kernel_mode_cpuslist.


# echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/

Why do we still need to keep the "inherit_ctrl_and_mon"?  By default all 
the groups in the system falls in this category it is not plza enabled 
group.


System boots up with following options if PLZA is supported.

# cat info/kernel_mode
       global_assign_ctrl_assign_mon_per_cpu
       global_assign_ctrl_inherit_mon_per_cpu

No groups are associated with kernel mode at this point.

# echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/" > 
info/kernel_mode

# cat info/kernel_mode
   global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/
   global_assign_ctrl_inherit_mon_per_cpu


# echo "global_assign_ctrl_inherit_mon_per_cpu:group=//" > info/kernel_mode


# cat info/kernel_mode
   global_assign_ctrl_assign_mon_per_cpu
   global_assign_ctrl_inherit_mon_per_cpu:group=//


How does this look?

Thanks
Babu

