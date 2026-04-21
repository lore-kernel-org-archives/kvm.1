Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010065.outbound.protection.outlook.com [52.101.193.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD95740DFC5;
	Tue, 21 Apr 2026 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776732079; cv=fail; b=PLUj5IoAM8l/yyWs3c9B2bnKm1obYRceybjHBgiCc5M17229lTlNq1ObRoYbpEAADpwHb3BlBGvvwZ7jM3vGD9hLD00vXmzRFjexm6I+3BIb7/v9qkW2Emmmd3xaXP5XrC1RfPSUAi8cyAcmsxt5XaBlqYMG3pZFcVq6mDT+8GA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776732079; c=relaxed/simple;
	bh=tjA2u4SHStKnpsM47jtf97ZypLiohDPph4HcM9Yy5ds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eMZH8rs02Obu4DzW10UQHFzvJB3cn26ztxI+jVp87kpZE0RtabBoq2x49wDcE9/fcmOFDRi2XnuwH7cUaoSBEB+alJwxzB8bpwboTys6GjsLOF3RIuedG2dxuD4/DZyxRgV27oip93xDuX1jUM8gqagqM6dUrLiISGVLUcaaczQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IStjVWjA; arc=fail smtp.client-ip=52.101.193.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IStjVWjA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxgP7446h7bfOx5vKjbU4YoBMtgf65uKDoZcKWtLBcBjAbRuenNDlXqdQCGnzwXjGSymNx5I9Sg8jUXKUpSL6bFD1UjsrH1XQOMKuEn8SEYsB1eluB/THiPUEom7hpR3xfOHKqtq6WMNFbT/c9EhKkp2f7s8rrhdfMnV6dMPlj2+WnDdZmsZJZdXuqjHYH09ayKMYXu0tt498weQQjHPykSvwx9d2Zn1t4xN0EtJ8PbB1VlYDzVdBNrq8B/UKXTxuZ6wkTCWnxSNIqgL8ECGRM6YGWLOW50JCp4d/8Sripz1Hv5lMVzxu7zgiHgEKOiw2kuZJrVzsVn4MrAtGwnfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5MsldANXIJb3GyBywprtmZyO5oF59fodOwdw5dopPY=;
 b=F+EkN1Y+7G3T9MNp8X3tq/lv82BKfdR3UuMvt/QpEOAZU3ygFRGJDOcGPtqp8GlXsd6kS8ShMwH0BmdlPzHTfIxzZMHteRsrkMG6julEMJ/J/6Z50+XbrKMQOdYfHFyV0F6DddDMr1TGYoS2M8PKVCTPoqvhYOXlVPJPOOzHMAgSyryzr9U5szZBdlZO52a8OImCekkX8QwlRBeUpttotxRRwck13seQXi1TMVYZba7AdDGGOop1bQFK9/5SPtmIzNtMxy5ryuP/RufMsvMJqe6yRGPc4rzI+2WySKpltaQwEqGqf53056WrMWMF9l8lX8jVz99ch2ZNtWsFFGkthw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5MsldANXIJb3GyBywprtmZyO5oF59fodOwdw5dopPY=;
 b=IStjVWjAtlGXZ4cF1oJnmEqX0XC2h2IUh3+5ePd8Y9hD8Pt0aQQAovblREl9zfKL/yygu9jPDEcZthx7iYnXecD4IPKDiZzxZDY5nqNnqqGqZivui2qBpL8F7sav0wNSvd3EpNUvEsA/q96TYHyj/7g1f/jOPe4V7gX86ZMmt18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c) by DS0PR12MB7849.namprd12.prod.outlook.com
 (2603:10b6:8:141::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Tue, 21 Apr
 2026 00:41:12 +0000
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::d03f:ffac:bea5:143c]) by DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::d03f:ffac:bea5:143c%6]) with mapi id 15.20.9818.017; Tue, 21 Apr 2026
 00:41:11 +0000
Message-ID: <e8530c71-fde2-4522-8b46-a24efb13b681@amd.com>
Date: Mon, 20 Apr 2026 19:40:54 -0500
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
 <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
 <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
 <39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com>
 <b74cfe34-e23e-49e3-beb4-d5639d42d5cc@intel.com>
 <99a2da36-6a21-4a99-98e0-3c9a4cf7ecf6@amd.com>
 <741aa53e-461c-4a1a-a701-6060d42012f8@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <741aa53e-461c-4a1a-a701-6060d42012f8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR12CA0016.namprd12.prod.outlook.com
 (2603:10b6:610:57::26) To DS5PPFCBA542BC8.namprd12.prod.outlook.com
 (2603:10b6:f:fc02::1c9)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPFA3734E4BA:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2065c5-a781-4da3-3c38-08de9f3eab4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Xjoyqca00BvV7cVYVjL1ahCLue8vOvWfa9u9SFw5OX5w5CcqonnOoiv2hAVPA4p17uhIs0VTod/dPWRCzP7pBicbxalC4qWiASpER+ZR8hy8ms2iVq9K0kiTkvOkGmwkHXhBxqdDsThICTm/Bd8YjCFbF/a9SCvwaL5QhrHdhDLkElmWXRbOHQjl+54C3aKa+QohGme/0nndwH94GN04Odgar+NHhK5v5Lo1MG8yOuRCJ1GLw1Rgp00guzKok/dX1zGXQtIkSTe0U6iPH9tfe0i8PaW2KipCFhpJhGB8lfvMYHlPJ1oPgrg6xdWe9kbMfcYTPms2KFdIoLFxCAxT9Ovh8MhPJskJeIW9xxWKh8yQFJGkbH24ugaG8mK9VneVGMuSGwsCZ6buEWpRUSiIRIffaSe7rCGqafD9A/RGaql9pK/FxtO/02gA/94OfcQKy/ZlY0WncdAoVAZC7zMhpbN0UuZLUskIvOO5WKFkGjd3qg67QtUvq1w8RXDdwB1HnNSwGutEkCdJ2+U/hAhGR/zhtoSHzCpFCDsQrrH7NFwGDH9zuV6fDJvhPzoJ26HbqStSqOGyVRMcseFnJMsm0evrMoA6v+Lf3pbNq2mYQ2uiXA1axMMKx/r6x87TN9KZ5ZXmVuQzV4RB6GcK5b/Yt6erxwCHpGVQGKFICexSFkc7YatpWfas8p800a2hfERzEQ7DGLCY+4ykULeAOUp9onpII78Meeq4xSz982F3ptc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFA3734E4BA.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG0yc0trbTM4TktjWkptR2hjeTZ0cm9iaCtzazJPdlJTZ1d2YWVvNExuNC8y?=
 =?utf-8?B?Z0RBRm4zN0JjZVhVcittRnkzRzIxaTYwZzkwRWlTc3F3L2VPUXJkMTQvRG5E?=
 =?utf-8?B?b0dBRERuRnpoQTczN1NhdTRrNUdwNEZQbVI3dXFXYTJVZjB3azZFMmhXYUxI?=
 =?utf-8?B?VE9wVnc4VHhraFlCZ3pXSlV2bDB0dERYV2h2QUlHWm96ajJyL2VlQWFhUmc3?=
 =?utf-8?B?aklDdnFNTkNvQSswZVhuWFhIVmxmK25xd2txelI1TlFtMDE3ODgvM203U3RB?=
 =?utf-8?B?bFFHRmVTZEsvcWR0T1ZjcWdxSmczVlVnU01Oemx4enBxMnhEMmkwM29Fb055?=
 =?utf-8?B?bUwvQ00ybVRDUDRvQ1pWSS80TSsyR1liTDhZakdPRTh5dlJSOFp1MCtaMHJC?=
 =?utf-8?B?ZmlCdHY1M1EzSythNW9rT2N1WVhyUkZ1UXhSUVdrY2Y0TXV2eHEwc2w3L3cz?=
 =?utf-8?B?OWpLTXovWEhVblgvZzlveGdOd0R3bUhpNzdCOWhMNlhUZGJXMXlIMzAzNTdW?=
 =?utf-8?B?RWd0TW40NTNiSUpEaFdpNExoWmQ3NDd2Y1EwS3VFREhlS0tmKzVmbzc3b0gr?=
 =?utf-8?B?ZFNLcDlmRnJRcmxJTW1abTh1UnZCMm41OW1VV2w1MHVmNU5Sc01EUnRtdVJx?=
 =?utf-8?B?a3dxa1ZGdXdiQ25HVXQvem1KRlBNS3Q3bkJjbFdQbWsvazZ1WStrK3d0RTFD?=
 =?utf-8?B?QXh1dzUvNUZXUTA2bmY3UXhSVFpVWFVuQmxxOWR4M0t5RUpGUjZ3RWZWQ0Rx?=
 =?utf-8?B?dGVXeksrQ2VSUjN1MlcxY2lxN1ZDV0R6Q3RPRzhQalBqR3Nid2tHSXpaZmZL?=
 =?utf-8?B?TEdrRWNsK2N4WS9DSWZVdWd4azNoUlhmUHFLUkVjSVdFdW5uK1YxZE5DamVF?=
 =?utf-8?B?ZWFmNzMzU3VqemtLMGNDVjFaNHlWTGhxTEgwSW05TmFaQjBGMFFzNW92bUhM?=
 =?utf-8?B?TUZ6aVBvdkZxU1BtWHJydGtYVEIwbzlFSXNMOHZQd0tReE0xbzVHTEFUb294?=
 =?utf-8?B?NFBURlU4U1B3ZlZtS0V0YlZmdU5TV2lSODEwck1tZkxQeXJTZWt0LzUyT21S?=
 =?utf-8?B?eGM0aDlISXNOaE9jQVk2Znl2QjVjYnZWTUo5ZW5tNnRoMGpacTM2SkVodjB3?=
 =?utf-8?B?aGwxeGtiZGpTL0lnMGk3bXo2NmxPdER1aDZsMlRpMDZvRW1IWmVXUFRWdWFS?=
 =?utf-8?B?SGhxWk5ETGhzRFFsazk3elIyR1R1RWNLN3FGQTJ5cG5rTkV2R1ZFQS9jRXBX?=
 =?utf-8?B?RjNCcGpQa0t1aU5kUXRUa3pxYkxjemVCNmZqVkNwbHAwOXlXamJnc0oydXky?=
 =?utf-8?B?WWhaZ2t2M1UxQzkwWC9EQlJNVGFqVThkUUg5RGdVMVJpRitJWGZGeC9TTUxY?=
 =?utf-8?B?MzRGNVlLL2loU3ZCenpLSTFJejhvUjVzTnFuWTNYbkJPSldkTjZEeCtUQVhY?=
 =?utf-8?B?dk1QMlZma2pLUEplamZ3R1BkVlRlOVhtVEdqM0p5WiswUjNtNi93T0JucHJB?=
 =?utf-8?B?YXRBWlhqNVpidDdKektoWm9hOWwwcTJKcjR6VG9ENDFWendCN3U0ZEU0d2pM?=
 =?utf-8?B?REtXU0VjVEtOREZCT3luVnZQd2xQQzRWWHhEd1ZFWGt4Yytlc1hRQnpRY0Zq?=
 =?utf-8?B?VTRvVkw0djMwVkl3d2htT0JBTC9qek0wVGpndHN5MGM1THBYd0gyV2FWMTRX?=
 =?utf-8?B?RktwR3MyZEtuMUJ4amhVVkFuMjFrR1NqSFFvQ0lIVzlZVW5iUzNGYm9FeVd2?=
 =?utf-8?B?TkUxVUNzQUZSYkRjTklNbVoyVzQ4TnBCelRGNEwzQSt4bENtN2RWT2d0d29P?=
 =?utf-8?B?dFhYUTRxK2kwMEo0elRvTEdTY1FKWTd0V01FSTFaVjRYdkhYbG9VV1FOZ28w?=
 =?utf-8?B?c3NIeXl4OGdpMm10N1hWVE1CS0hmYUpocmtDQmhabXZ4STdobVp0VmRKYjNZ?=
 =?utf-8?B?MkJhdStsZHFFczhOOVNGV0ZaZmdMeTdvRUc4dlhwSmlocTczQnh2MUhkbDdq?=
 =?utf-8?B?bWZmWjF2OXE1ZVdHRXVDOVJDQ3plWWlMWWpEZWN4U2F3NE5ESVBZckVvSmt5?=
 =?utf-8?B?ZTBVOFVxMHdwTVpvaEFhU2N0U3AzT1NVc2NHbk5zZ25sbGhobmQ1L0JMOVda?=
 =?utf-8?B?Z094QWF6clNOMmV4RGxEdTduQ1JjMVkwVHB1ZVVCQXUyMEtoWnNCQURxNVcv?=
 =?utf-8?B?MzJsMEgrYUNkUTQ1SGdUdW9NQ2JBZGdQd1E2UXphMzhkRXlHSTVFRk9WSUVY?=
 =?utf-8?B?TDhpaGxIR2Y0YzBhK1RkajF6SHB6V1pCaDhaYnZOalJ4S2YxdzJhdnhjS2l5?=
 =?utf-8?Q?euRpcLWnPLPCLNBgVH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2065c5-a781-4da3-3c38-08de9f3eab4f
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFCBA542BC8.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 00:41:11.6143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQqliwcc0gHZK8RgKFYcFJmtccna6WW/QXkMi7airiP5IzukV06Q6bZh90nQ7/aG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849

Hi Reinette,

On 4/20/2026 6:34 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/20/26 3:59 PM, Moger, Babu wrote:
>> On 4/20/2026 5:03 PM, Reinette Chatre wrote:
>>> On 4/20/26 12:38 PM, Babu Moger wrote:
> 
>>>> The current mode change behavior is very restrictive.
>>>>
>>>> For example:
>>>>
>>>> # cat info/kernel_mode
>>>>         inherit_ctrl_and_mon
>>>>         [global_assign_ctrl_assign_mon_per_cpu]
>>>>          global_assign_ctrl_inherit_mon_per_cpu
>>>>
>>>>
>>>> # cat info/kernel_mode_assignment
>>>>        ctrl1/mon1/
>>>>
>>>> In this state, we cannot change kernel_mode to inherit_ctrl_and_mon. The expectation, however, is that inherit_ctrl_and_mon should always map to the RDTCTRL_GROUP.
>>>
>>> Could you please provide details behind the "we cannot change kernel_mode to
>>> inherit_ctrl_and_mon" statement? Why is this not possible?
>>>
>>> I do not see "inherit_ctrl_and_mon" to map to *any* group though. Expectation is
>>> that when user changes mode to "inherit_ctrl_and_mon" then
>>> info/kernel_mode_assignment would become invisible to user space.
>>
>> Ok. That is fine.
>>
>>
>> Sorry for not making it clear. Let’s consider the following scenario.
>>
>> The system boots with these default settings:
>>
>> # cat info/kernel_mode
>> [inherit_ctrl_and_mon]
>> global_assign_ctrl_assign_mon_per_cpu
>> global_assign_ctrl_inherit_mon_per_cpu
>>
>>
>> At this point, the interface info/kernel_mode_assignment is not visible.
>>
>> Next, lets create a new control group:
>>
>> # mkdir ctrl1
>>
>> We want to designate this group as the new kernel-mode group.
>>
>> First operation: Change the mode:
>>
>> # echo "global_assign_ctrl_inherit_mon_per_cpu" > info/kernel_mode
>>
>> At this stage, only the kernel mode is being changed. However, there is no way to know which control group the user intends to assign to kernel mode. All we know here is the selected mode.
>>
>> After this operation, the info/kernel_mode_assignment interface should become visible. But the question is: what should it contain or point to at this moment?
> 
> This was considered as part of original proposal per
> https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/
> (search for "default value") where the idea was that the group
> should be initialized to the default group.
> 
>>
>> # cat info/kernel_mode_assignment
>> ??
> 
> After
> # echo "global_assign_ctrl_inherit_mon_per_cpu" > info/kernel_mode
> # cat info/kernel_mode_assignment
> /
> 
> After
> # echo "global_assign_ctrl_assign_mon_per_cpu" > info/kernel_mode
> # cat info/kernel_mode_assignment
> //
> 
> (although this is where previous discussion comes in on how interface
> can become inconsistent depending on what the previous kernel mode was)

This operation effectively promotes the default group (CLOSID 0) to the 
kernel-mode group. Consequently, MSRs will be programmed on all threads, 
which is not the user’s intent.

> 
>>
>> Next operation: Assign the group
>>
>> # echo "ctrl1//" > info/kernel_mode_assignment
>>

Once again, this causes MSRs to be programmed with a new CLOSID(ctrl1) 
which is actual intended result.

>>
>> Now the intended control group (ctrl1) is explicitly specified for kernel mode. In summary, changing the kernel mode requires two distinct inputs:
>>
>> - Selecting the kernel mode.
>> - Specifying the control group to be used for that mode.
>>
>>
>> Hope this makes sense.
>>
> Understood. Could you please elaborate what the problem is with making it so?
> Are you trying to eliminate one per-CPU register write? Is this something that
> ends up being very expensive? I assumed that a register designed to support
> modification during context switch should be fast. Or is it the IPI you are
> concerned about? Please help me to understand what the actual problem is that
> you are trying to solve.
> I think it is reasonable to start with defaults when changing the mode which
> I do not expect users to change often.

Note that these MSR writes are not occurring in the context-switch path.

However, every time the kernel mode is changed, we end up performing an 
additional set of MSR writes, which is unnecessary overhead.

There is also another issue, as previously discussed: switching between
global_assign_ctrl_assign_mon_per_cpu and
global_assign_ctrl_inherit_mon_per_cpu, and vice versa.

One mode requires a CTRL_MON group, while the other requires a MON 
group. Because of this mismatch in required group types, switching 
between these modes is not possible.

We already discussed moving back to the default group on every mode 
switch. Doing so here would once again cause extra MSR writes on each 
mode transition, which is undesirable.

Thanks
Babu
