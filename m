Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0438739A818;
	Thu,  9 Apr 2026 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775778151; cv=fail; b=G4Genbd7N9aYSMddljcpsPizITlhksGLEHMOtC3dCf1VLZoFKtdR+iG4xeEPm7rtb4hmmAd4YywtMHSunJvYw+/oeQh4rP8KvMCQc8L/sLpvuWiD7yCOu2g4QPsChM5b6eLPDcghJLyMsOmh7rRf6wfDHOJUKjcuaGLlfNouDhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775778151; c=relaxed/simple;
	bh=6QRXLL+cSgnVMU+9ZRjXhoSTXWkReO1SBRumpeDHykI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GvNomB1AG4U4nbYZfuh2PaYzyX6ey5MiHfVeViV98MdnGignuwFpADFSOHxCuAs5sHarZ8jlMVVVckURgEr1erCxoiXphJ6MJMDkxb1s40xiAancBrkgsKJuAsyLVGxVXjc5UXKZsntjZ5VWozqmxTIltR4zWEyY2CyIHTKSlHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i3mbGrHu; arc=fail smtp.client-ip=40.107.209.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i3mbGrHu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5/BUjEYUwB8/xurznY4HlFnfi+/c+LmQnilpVm6tbnsFWDihb7250d27ueTRMdyUdlPNcKTVT54KTXXCfxp0tZdyLUerChHi2xL7zFx+rA/gBEXsLB+YP1U2+l64O9GWStT8i3xS8lU47o+/e0Wpa/lw1pU4whisNhHQrQOi4WZxetVKcLNXrqEKe3rnj7k11j/xOMygoT7f72ZKb2rRYWkoUUn+uwfq1Uau8fBQtaide/euor+MyKwelhWC7/Y/gJ6IQEHBrMhWUgb/WgIaJPN2e93oRM57AmSh9qIIu9OdTci6VxhRuPtCOnfT8NmjpVn9opvq1digPUNemxoog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahUDrnilsKteCXdab73s2Ov40xWjuYTt4pA7QN2ixaY=;
 b=b28IsrkQOj5vJHaFT3JV3vLEU7nLHf9lCFdfj2bKt7H85DejIH6N/mFwT3x7NI474o+zAb8zfoQZJmpWbTWyTXZDVz1Dd6Y6Srf55aaglathr4odjj47LBWif80Ri9gu3eP+ENrwQ4DzVOCcol5x2PguKzTii7bE1LoilRkkZIdLzAwn8EJoB4Blud31FoqCzeET5rGGeszl0CNHVwzeIIYrSPpb3eyxjab+vleork/FJI2RqbkLTvLA3c7tWuFw4zpgNnNdKfSf3CegkE6L19+EnHaAa6qbLWJ+eLCxtvDPeuGPhD2F1QZ2hrue+fppCqEJHyX9M8R68/N5or9QYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahUDrnilsKteCXdab73s2Ov40xWjuYTt4pA7QN2ixaY=;
 b=i3mbGrHu4UzcF8M74J3gV1ZKxziLJraX3tmLb8pBBJ/fISglpsn9z73DUR2sNGnfjbemHwwP/XYRxL8G1vyGpipkw+Vs8gIK1VFKxm0yzNW4jPfa0+dPlWb6pFYBRecsgu5N1Z8sTXehDIZ0fSMiWIgs1pu7AhyxbVBRDrKGp+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by DM4PR12MB5988.namprd12.prod.outlook.com
 (2603:10b6:8:6b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 9 Apr
 2026 23:42:24 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88%3]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 23:42:23 +0000
Message-ID: <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
Date: Thu, 9 Apr 2026 18:42:19 -0500
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
 <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:610:e6::8) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|DM4PR12MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 184db005-ef76-46f9-4b3e-08de9691a63b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|921020|56012099003;
X-Microsoft-Antispam-Message-Info:
	mSGGKU7Z6OWNZ38qBzuHdzAMOKvS6LWI1W4CMnnp6/3MQRySHg/BuJ+JXCbW/4+K/4vaynPGzHdZ4SaisxmrX/4gAYubO5IXToSJbN12JZAvCnMprDjEBZSmHR6q3NSZ73bffpow0DFDEdNrDUvO9gaYLTG/WZz0g8jgLTuahr5jCEC8Gyy0Nbg3UGUzHrW+D8cDxR2BkoroslwCiIhKrC0l6ZwGK4HC2bpUn+HYD29CB0hxb0ORlAEVQ5VKpfId/rzwfZl1C0D0ALEiK1Y+8mEX50Y5Dsl2T4Qp0Sofku300kM7KKlJxOn4ONgYaoKNsbFm4yDkL3kzC/Y0cLGe74Nzd35NDheH2C9AjbX6u+/H3xc3SNg9P0Lsm0NOwInQOcsVN7Yi+asXj9RHlkfsqvbh7GbjhSXGRv16jzMwjV/0l2fUe+9n8KUO/MZhbPstTHemRKBX7uCD42cPT3xsFXM0dethF2yqoLo2HTHUKBMd/CrzwPOJSwaZKEzl5I2VW3LPS438rT+bWlUGlW96b5FBg/4jVhnE+5C5H2fq/rVKREpxZYYOODc/F5AkNu7kL1+0eI4TlYAUhC/5QNcgaJbBoU0am21/EG1SLBMVTybmRdhSoRoFHeUW84GP4s3zU1iqouz0DokgJZvLyVi5G0C4eWwu3sR7b6r41wsooIZLdkNwEOzrAlxwolURXlxjM6A14JA9th0Jw1xa5Sr82EXCVbbOpMssKnVeruHcbJfr/DJ8z63IEbRq+xjuKf0m+xgkIUSAE3tmb8u4fbZm9w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(921020)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjdFRiszMEVqcExLR2l0RytCRWE4ZE12Zm9KL040bEdXOUUraE9rNVR6Tmw3?=
 =?utf-8?B?ZWlmckpaVHNyb3kxT2RMajNpVnJTQkFyQjNSOWFwNGRPOGJMZmdHckJoa3pq?=
 =?utf-8?B?cXBhSHdsS0s5MDVSSHR5V29JdVcyRUQvTlZXK210Y3YzT0M0d1VtZEJCNHhF?=
 =?utf-8?B?aVJVdklzVUVEdUFCeGNtMlZWWHpobjBjVk9CQm9Qa3JGeUU1WlBibGZTSjVy?=
 =?utf-8?B?SCtQWkdtOW04Q09zdG1TTjQ3KzFlWklxN0J3d0hIZStkWG01bVF6dzlzNUdP?=
 =?utf-8?B?T1IxZlNwclE4Zng2R0h2WHB1OWNDb1pjbVB2UWxydWZyUWtlSkRWK0s3dVh5?=
 =?utf-8?B?ZjlhUTJRR0FEeEg3RWhKUEprN1Vuc2FaSnIrWmhocEM1R21MUzRSSWhtWkNJ?=
 =?utf-8?B?dzUwUURydlM4OERyMzBDUjZYYm0vcnBlS1I1N0c3M0U4SmxIZzBQbnYralRN?=
 =?utf-8?B?aGoxMmxMWHNoK29Bd0wrc2t0STdBcG9wM3JERzg2UjNyaFI0MkxvQ3lYMGk3?=
 =?utf-8?B?UHJSdjRzc0VGNm4wcnFlSDBIbVpDN2hLVlp3UEcrdmFNWk84SlNPaUx6U0RO?=
 =?utf-8?B?c3BESDZOb05WbEdQcEhIOWJyQnl0Mkh2Zk5RbUFocHV6Y0VHcmY0L2J0cWpY?=
 =?utf-8?B?Y3JKV1Y2UEJUcHRaVEMzRGtYUGhXdE12SXJBUWFjV2tRcytLNjZ2ZW5Ra3Rz?=
 =?utf-8?B?OXVrdUwyRnZISDFMQlNhWEtMb2djOGhxQklIc1N6NWt6Yk5nV0ZCNnFRbUlG?=
 =?utf-8?B?QndHRWNWSTdXbm5jeWdqTmlEeU5KV21uczdqSUxTV1d0a3k2SHpoTmM2QmxR?=
 =?utf-8?B?L1dBaUEvVHd5UkVvbTRIanl0anh5ZUZhaklONnlmUXZtbzA1VzNLWnB5eEo2?=
 =?utf-8?B?QWgrMzVDWndRM3puTDZQWE9DcHpySXY4NzF0VWVmSkhtakoybWQyeFhVd1pK?=
 =?utf-8?B?a1JaZWYvVWMwZnY2WGpTMmtkSDNDeUEvaFY2WmxrV3RKdURRWjNqK1cranNT?=
 =?utf-8?B?NTJPQy9RUVg2S1BzeC9salcvR1hIcTlmTzY1RTlSNDkrY24zNWp5YUh5NmZB?=
 =?utf-8?B?SkJZY0M4bThhQnBhelNqWEkyRkhrQU1mUUFmUzhibHdWS1VNZFZ6NDJDdlR6?=
 =?utf-8?B?NmsrWGlkbGtCS2tEdGdtVzRKTitiMDREcnQ1UXAvNElnRm1QTEpkTjgxUTQy?=
 =?utf-8?B?cW8xM0FrOWdXeDRHSFpDVVdaQmpQWXpBek5CVnRZblA4M2I1bW5jcno4TGpz?=
 =?utf-8?B?VFZqdW9wS0hmR0Q3c1cwcnp2RkhXZkJEaDlKbHM1c2JLWS9YaS95cjFRZWgy?=
 =?utf-8?B?MXUzR2NoYWZTdUw2bXVJbXl5YU1vNWNSc2xBUEJ6c2d6eWFIcnBMb3FpQ0ow?=
 =?utf-8?B?a1JWL2M4QldtRTFTaXFHeDZ4cjN1TWZNZTl3NSs5TjFTczcyNTVoVzhlQnN5?=
 =?utf-8?B?cnBOMFVkSGw5ZUtsS0o4QmxweHRxbHJwdmkzSWVqOHJmaHNZMUd6R2g2VDIr?=
 =?utf-8?B?UlVOUGpjczFIOFQ3V0ZxaEhlYy85RXJZTEkrUmNYRWdEMWx4TUVwSTB1LzZ1?=
 =?utf-8?B?bnI4WTN5aUNNbGRYUlUyMFg2RFB6Y1JmOXhoblRraVppcGJ5dVIzaDZsWHNm?=
 =?utf-8?B?WFJmVGw3aE1FYUlGc0dxOWlzZkZFai9DQ3ROamlCT0J2N3BURUJCUWdrczZK?=
 =?utf-8?B?N0p6b1VISFNGdTlPNDNFT0RiN3I1R00wUmlQVHRDRm5yYzhjOEx2NVBYYXQy?=
 =?utf-8?B?WWh3MWQydm5xMHpKSHFGWlFLNjhSTGZ0U21zdjhpbXlDbFZRdTdrTFZxZVYx?=
 =?utf-8?B?OURjSERWVmtkNlRMQjBZZHY5RnYzZFkzczJGMk44cnpVd2lTdDFkcXowNVR5?=
 =?utf-8?B?WHFxMjQzTWtJbzNlMmxFZUdsMWpkcnNIVU9VUEJoRjVLTE51VUhNTmFFQzVS?=
 =?utf-8?B?N2hNV3o5YnJjbE1CbmZNYjRTSUQ5V1dQelkvVC93eUt6bWZ1bC93L1Vzc1Qy?=
 =?utf-8?B?cGNBQVQ1aGI5SVdXQ25CMDllK0tvWU5YVG14dU9CVTc5R2ppbE9pamI0Nlgv?=
 =?utf-8?B?V1VKVnozSE9YWTlXSGQ3YTQ3cE0zdkJabHFhcWRDVFJ3a2doL3ZHRm1Jamhp?=
 =?utf-8?B?Z3B1RTMxc0Fwc0V2cGV4NTBNUXk3N0szUmVUWVlDMVkrR1RZME1YZEdzZGVP?=
 =?utf-8?B?b3RkZHRhVHMyZHFGekp4UWxEYkdhTTBNdGxIbEdjMWs5dnZnMEFORFh6RkdI?=
 =?utf-8?B?SDdibDdXM2lvemZPMlZ5Qk5OVWdJREhHckgwM3ZaL25yZUxtYm44WFY2WW01?=
 =?utf-8?Q?+cQTfYK5ye3xFDN09y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184db005-ef76-46f9-4b3e-08de9691a63b
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 23:42:23.7898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IO8bLeJL7xUX5KiiDqTvSh8tPCwR4fMv5C9sBB4gQZmgN4Jr1sbZdZ7uiXx5Qkp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5988

Hi Reinette,

On 4/9/2026 3:50 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/9/26 11:05 AM, Moger, Babu wrote:
>> On 4/9/2026 12:26 PM, Reinette Chatre wrote:
>>> On 4/9/26 10:19 AM, Moger, Babu wrote:
>>>> On 4/8/2026 6:41 PM, Reinette Chatre wrote:
>>>
>>>>> When the user switches to either "global_assign_ctrl_inherit_mon_per_cpu" or
>>>>> 'global_assign_ctrl_assign_mon_per_cpu" then "info/kernel_mode_assignment" is created
>>>>> (or made visible to user space) and is expected to point to default group.
>>>>> User can change the group using "info/kernel_mode_assignment" at this point.
>>>>>
>>>>> If the current scenario is below ...
>>>>>       # cat info/kernel_mode
>>>>>       [global_assign_ctrl_inherit_mon_per_cpu]
>>>>>       inherit_ctrl_and_mon
>>>>>       global_assign_ctrl_assign_mon_per_cpu
>>>>>
>>>>> ... then "info/kernel_mode_assignment" will exist but what it should contain if
>>>>> user switches mode at this point may be up for discussion.
>>>>>
>>>>> option 1)
>>>>> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
>>>>> the resource group in "info/kernel_mode_assignment" is reset to the
>>>>> default group and all CPUs PLZA state reset to match. The kernel_mode_cpus
>>>>> and kernel_mode_cpuslist files become visible in default resource group
>>>>> and they contain "all online CPUs".
>>>>>
>>>>> option 2)
>>>>> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
>>>>> the resource group in "info/kernel_mode_assignment" is kept and all
>>>>> CPUs PLZA state set to match it while also keeping the current
>>>>> values of that resource group's kernel_mode_cpus and kernel_mode_cpuslist
>>>>> files.
>>>>>
>>>>> I am leaning towards "option 1" to keep it consistent with a switch from
>>>>> "inherit_ctrl_and_mon" and being deterministic about how a mode is started with
>>>>
>>>> Yes. The "option 1" seems appropriate.
>>>>
>>>>> a clean slate. What are your thoughts? What would be use case where a user would
>>>>> want to switch between "global_assign_ctrl_inherit_mon_per_cpu" and
>>>>> "global_assign_ctrl_assign_mon_per_cpu" to just switch rmid_en on and off?
>>>>
>>>>
>>>> This is a bit tricky.
>>>>
>>>> Currently, our requirement is to have a CTRL_MON group for
>>>> global_assign_ctrl_inherit_mon_per_cpu. In this scenario, we use the
>>>> group’s CLOSID for PLZA configuration, and RMID is not used (rmid_en
>>>> = 0) when setting up PLZA.
>>>>
>>>> Our requirement is also to have a CTRL_MON/MON group for
>>>> global_assign_ctrl_assign_mon_per_cpu. In this case as well, the
>>>> group’s CLOSID and RMID (rmid_en = 1)  both are used configure PLZA.
>>>
>>> ah, right. Good catch.
>>>
>>>>
>>>> Actually, we should not allow these changes from
>>>> global_assign_ctrl_inherit_mon_per_cpu  to
>>>> global_assign_ctrl_assign_mon_per_cpu or visa versa.
>>>
>>> resctrl could allow it but as part of the switch it resets the "kernel mode group" to
>>> be the default group every time? This would be the "option 1" above.
>>
>> Other options.
>>
>> Allow global_assign_ctrl_inherit_mon_per_cpu -> global_assign_ctrl_assign_mon_per_cpu. As part of the switch, reset the "kernel mode group" to the default group.
>>
>> Allow global_assign_ctrl_assign_mon_per_cpu -> global_assign_ctrl_inherit_mon_per_cpu. In this case switch
>> to CTRL_MON/MON -> CTRL_MON.
>>
> 
> ok. Could you please return the courtesy of providing feedback on the
> suggestion you are responding to and also include the motivation why your
> suggestion is the better option?

Yea. Sure.

We need to allow the switch between the modes. Otherwise only way to 
reset is to remount the resctrl filesystem. That is not a good option.

Allow global_assign_ctrl_inherit_mon_per_cpu -> 
global_assign_ctrl_assign_mon_per_cpu. As part of the switch, reset the 
"kernel mode group" to the default group.

This option is same as you suggested.

Allow global_assign_ctrl_assign_mon_per_cpu -> 
global_assign_ctrl_inherit_mon_per_cpu. In this case switch
to CTRL_MON/MON -> CTRL_MON. This option basically disables monitor 
(rmid_en=0). It is less disruptive. Move is between child group to 
parent group.

Thanks
Babu



