Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793037473;
	b=v4S+54BFIVP9giLEevnukPjpnVEUzKMLXlg9r1lf7Wb5eUa8l7FgeONEM1N+G7IUp9Vr
	 ykALFXnFPebzfn36aQy+NzPymQL7VPvgfW0iKz0PdlPEj068YT26nDY36AV4fPcGWnsOQ
	 raVNYB0amQWpdS2i0rOL2On/8QPmdRyKbHb2Sc8z0N2yyJtBOka1XN08UDZEjVPlkg8YE
	 +Pa2gIQjBma1DFnLaPTuO7rjIpLLpTltsW4p20b3NivqPBJ+3YZzYTyCWjpQTCSuikMfd
	 6DB3Oeqsnzj5wSxC7P/VqfktZ9cHSAbpLERnT3ku3vdWFG531udxud1FCNxb2fGffaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037473;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Cc:Subject:To:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=z2eN7oGh6/M4SKGgWCqlThPYUwLS+DZpgVfSwR083LQ=;
	b=ZMeiL0TDIIgyyKIMxZ+Kgy7+jMtbYWB3gbePjJPhP+iIXEhrvQvk63D3Xmjde5QiyTYg
	 aQEingXFDsmdmIvGzePLMb6ycGXVxrzWfISWKTh8tTQxcEbBrKPOIPP4GzqNfniG+pAW7
	 z0UPv/nxk+jVfSdNtyDgtQuBr9jjRo79Cv5cIOO7KS1Q8u/62w3OtnfOdQt6JKSo+pplB
	 kPWE+OPLqN+QJjEgGF9rQsT30tghRTatBHDL5NVHzPwGlRgHI4raLjzuL9F8S5Qk8Lh6t
	 46m7KmFhcnCbOvWEt/mDmfZ4ju4OMV9p/goXmPD/4TqkU+EsBXpXLwjcjkMOkvdlJZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=citrix.com;
	spf=pass smtp.mailfrom=citrix.com;
	dkim=pass header.d=citrix.com header.i=@citrix.com header.a=rsa-sha256 header.s=selector1 header.b=KEpT6QOH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.0
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427FE606A31A;
	Mon, 26 Oct 2026 17:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 427FE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=citrix.com header.i=@citrix.com header.a=rsa-sha256 header.s=selector1 header.b=KEpT6QOH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+tBWRUG/vrH5yXOO3YGDFKU+ZYo5K4SsdqUQ8q2MUJOojXWNfBl0d0OFAe4cB4jOvZOeVeBkgNC3/m3dgPO7IyxPq2lXzCecjJX9Y0AiGrd5bzEREl9WceMOfnr00ReQ+BCrmKZDDMBaibTd3UU1vXXLJwVCLEZukhv2Vdv9MvLklkGtLwuSBqfV0uhDiU5W3ZPjHFy16TrUVUOTXofLjUJsiogocBRszhmTCElzI/SHHCioa5lRlsT+XqCWUBoOAULA90oJgom84c8l3mvtU7P0gWpEUCfpeD0m/UYxl2uxj2zP1ZV5TQkB7fCxOaCzXnTrtw//BzJlsuIJarmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2eN7oGh6/M4SKGgWCqlThPYUwLS+DZpgVfSwR083LQ=;
 b=n/+jebUpWlZ4AKit6Q7XMIToWjkCrkCAUWqyTQok2bFgI6elS+3Zk+jN2SZJXrVOo2fGMf9bR11fNWhLk0zMavo/Eiv4jteHrBtQxO0iOrZlIRQbwIdyEgkOCaEjvUO6I7Hrk6rxmdSLGOI38w25L79PZ6UMPylW3vUPKq1WWeI5IXomtawLA6kB2sgF+K9m5wlFkqE0y8nXnf+1ZGux8rKxDJeThDlXpSK14/+zvciorBAgeXMlwz29RhcpGWmtZooMXHZjlNtecQpMrqQOOPvKAUXM9fFg1DBp2vIj3UJ4MnNiOox1OOdLS+rBuyFF39/0EPGJq1Hzwwo51xSjEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2eN7oGh6/M4SKGgWCqlThPYUwLS+DZpgVfSwR083LQ=;
 b=KEpT6QOHYsiIqEWLDt/zvlReTUjOMdVOisIsH17bxHhYiFAKy8X6q6QP6kDJOXeTE12zP2G8T+8az3pqx9Sg5aDyIh7AzhRrh7zKs96imC0HG4OAKxKbk0nWlY+X/bh+Wzd2MF5+7quUfG7P1wxBlYwuJdBDB3Xtwt8s0B7I+n8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by SA5PR03MB8451.namprd03.prod.outlook.com (2603:10b6:806:476::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 17:57:47 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 17:57:46 +0000
Message-ID: <40e998b5-3238-4adb-9b8f-1bffa0b48f9f@citrix.com>
Date: Mon, 26 Oct 2026 17:57:40 +0000
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: Kernel Shadow Stacks Versus XFEATURE_MASK_GUEST_SUPERVISOR
To: Dave Hansen <dave.hansen@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yang Weijiang <weijiang.yang@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, John Allen <john.allen@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, peterz@infradead.org,
 kvm@vger.kernel.org, binbin.wu@linux.intel.com,
 Thomas Gleixner <tglx@linutronix.de>,
 "Bae, Chang Seok" <chang.seok.bae@intel.com>,
 "Mehta, Sohil" <sohil.mehta@intel.com>
References: <2f0560df-69fc-4fc1-81fa-447e289ec2df@intel.com>
 <bd608c7c-676a-4b65-97dd-626d0e8a5514@redhat.com>
 <5c74f231-46a7-4f37-8fcd-bff84842a923@intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <5c74f231-46a7-4f37-8fcd-bff84842a923@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0002.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::8) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|SA5PR03MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: c18c7516-5d3f-40e8-db8a-08df338aa467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|921020|261026121527099003|4143699003|11063799006|56012099006|261021121427099003|261021123027099003|261022113327099003|261022075727099003|261022105027099003|10067099003|18002099003|22082099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	2uERw+NU/JgQFICwW2Da2ZMP/H80wdgXm7nIfAPm43ao7yhUyn8HfY8aRkgbW2gqQtEBV1V9lTQ+F3m7DRSJXb3HlMULN0tGWZokthQIvLRlhdqj/W0jECkbnMH9Fe3mwWCuc+V9Na1vrVBH5Ik62UUmXHjaPr4/DOtQpL5dAQ8VNXwcz30VuP9DK++Te03viOP+z9eGchW+HLd26hpejNe81v7IyA9XmK/gCyOH1TsLpj8dU5iXbWublS+lEsuiI3hpnHtsHZLsXJIhU35LYINS5GlkVhAKY0525kTcU1MHLtAHOJ4C/ixBAA7sme2fB83sUH7KmAcdAoem7gIJY06hXlVUFlMm/1iddoqC/RAsGB/InlB+jwEkP1xX9hJFIEIif1tTpixuRhMAqdB9EjFw7lTmn5uCceUwCcsHnUAfUeDHPD2fMPoy7HACK3VCfu8eHnyoBn3xipF30VvNJSplxvTvJGUv141N462jnSR6CZQ9RaX7Kfqz2dnoIu0739zqSd0FwWBZTsXlW9nRaabiftHGQd7ynXam4k/lxSRkdHtE3RlMfos2XF7DamQ5cvTlMNZhsSEU0paPeW9K/xZ+Mml8FnRN4Ml0mf7mJt4VddqZIjK7lP1WE9rZ1ur/dCdIL1C6Dp+wDsy00glpLhbu3ChFBUSPbO54ibdHprfwQk0jWrVfBepbq0tQpWJ0Q8w1//EwM6eyExDNl1GXkw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(921020)(261026121527099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022113327099003)(261022075727099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlFPSkpZYlhOTHdXOVVkSkZYVExtekpycW9xM0N4c2p4VGlQckNsWnBmUTE3?=
 =?utf-8?B?MVlGbEhOcTIwaVNwTXNmSTA3Sy9icnkxVWNvUHhQMjlySDVuY2UrSVhqQ0Z5?=
 =?utf-8?B?a1Y1Y0Z6aHdjc2x1YTFaZXllRDR1VURSTlNPaEF2TnVibkxCZzNtdG44WVNE?=
 =?utf-8?B?ZTBiSlZoY3dBNEc5Ky9rcEpqMG1CMDl4c3c2VE9HekZqc1N4dG1vTjQvS0dB?=
 =?utf-8?B?aTYvSGtYSEN3bndlVnhOcndtRXRZNU5hSm90TzgyY1FhK3BEUDJqTG1LU1d3?=
 =?utf-8?B?MHBkM0JyNDhnZzM4eUdPRG14S2VHeXBsTWZBNEt6S2tVVHZVS1plSk14WFRh?=
 =?utf-8?B?bkRmeEYvQ0F6NWROQ1F6UU1nemV4QWZaOUNvdUFEUk1MTlU1WGJsTnlTYzZY?=
 =?utf-8?B?aWhrSEZJZVZDK3VlLzFvYXlhOTYydkh5c1ZhOUhMWUdYbEJ0VXRxOTh4OGtq?=
 =?utf-8?B?ajNPN285aE1HRm1hS1VTREtNQ1hwaE5SdnZZczBDU0NGa0xnZFFUSnFlS29R?=
 =?utf-8?B?NWgyL29IZ212bDBLb2pocDNpR2RSbjA1V0xqS0hEMlpHRDNiYS9BVWlDU1RD?=
 =?utf-8?B?NEg3ZVdoVEpkM2JSSHIwanQ4R3pZYkVBSUttQ2hJYy8xYlVQQ1FTMWVtRTJE?=
 =?utf-8?B?ekJhSzFscmRWM2pWYkJwMmY2M05qSjdNUGlHemNEU1ptYUNoTC9HOVVBY1Jh?=
 =?utf-8?B?emwxYWZkS3Brayt2dU1ONDhBTmZ5SlpmbEcwcFh3NHQrNm54eERlTHRWY0tq?=
 =?utf-8?B?TTZiT1NEVnUzYUkxcFhRMDFKV25zVE5WeWRuSFJoVGc0Z3ZaSzljb0xxSStT?=
 =?utf-8?B?eG5KejRFNWFlTWpWSHREN3V4eXVUWk1PL3lRajRKQld2dXFHREUxNzFham5M?=
 =?utf-8?B?TTNtRk5HTy9Nd0dPNXhxaGFRdjBtMzBQQ3JrQTlEZUV2Q0RjZU8zYUlzOTB2?=
 =?utf-8?B?TXhISGljSENZend6aEFqSzQrdFk3UHV4NWh5WUwvWldreFJLNkZ1czlwR0ho?=
 =?utf-8?B?Vkg5SUgwOHJrSjA1MmY2WnNMTHRPMlZUNDYrRmRBQy8rbnZNbzRia2RoRHdD?=
 =?utf-8?B?dHhlb3p1STZFRkwwS1h4S3pJUC8xTml6aTR3aUYxeWloc254UnIzbWt1eGJo?=
 =?utf-8?B?dGV0aTdKekxDY1RRNm1MMkt5UnpLMWxHQTdENkp1TG1RcGYvUGg0RGZGczF6?=
 =?utf-8?B?Z0ZpWDR2T3VUUEx3SjBETU5UcGZkRDVCejU3RmUxOEtQdGhudWNIT05xYzZT?=
 =?utf-8?B?ZVB1SGNSYTFyMDlZYnJXNm5WazBqS3UwVWNWcHVsdEdGbE1GSmxSaitUSlNV?=
 =?utf-8?B?cmZVc0pDQVZPYTBDaUhUT0d2RitHTVRsQXRCeU1MaXlPVkJoS25UaTBTcVFq?=
 =?utf-8?B?UzhZaldPb005SFVKYzVqVTJBUDhJWnVlN0pkWVZvSGNkK0l1TVBaVzdUTHhN?=
 =?utf-8?B?cEU0aUNjY01RU1VPUGVlVDdJWU5nMEk0MEcwY3d6N3VNQUxjdWV3SHJyYXB5?=
 =?utf-8?B?eEo2Mm5EcEpSaW5tL3B0czAzR0ZkRk1TMXF0QUpCbldkYVE3b2hGa2NyajV0?=
 =?utf-8?B?dDZUWU1HTTlKRDREUkNYalh1a2Q4Z0lHOFF2MDFNWFdHdTczWXNzN09abWk2?=
 =?utf-8?B?V0ZNbFFoalpnZ0xRYXdPMnNKWEg5M2gwMXp1Y1ZoblJ4QXBoeGFRMkUxVlBi?=
 =?utf-8?B?ZEhnTzd2TmN3a3dSRURKbFZOWUFGNDJJbi9sblFHTmJQeUUwVzJNRFVmV2lF?=
 =?utf-8?B?eEZLMk85UU53bXJ3R2xOOEI4Q0lGMGFSYjBUOEMyTFRvejBYcElLbzdJak4z?=
 =?utf-8?B?RlVVM0dMMHhwcE1UODkzTW4yVjZlRmZnRGRrN0w2NXRKeXp4QWsyQTcvaDlO?=
 =?utf-8?B?YnNaQURVcTFyL0Jnd0FTZVFubmlJV0QrVTAvaG11SjN3TWFQTlRZZEFITHpl?=
 =?utf-8?B?OXFuZlRndG9mRjhraEhaeXl1cmdHT0s0TGdpMSs0VTM2RE1uRTU2bkt6LzVs?=
 =?utf-8?B?SzVKMHk1UFR5WHl5NTB2aW9tWGsxOWNacnphUmFzSjk5SzN2M3FrYTJTdk5Y?=
 =?utf-8?B?V0NCUExCcE1Qc21nbXBmbE5UbGQyblhCSFdXWXlJU2l3dW01aTVZR1VJbGxk?=
 =?utf-8?B?U2E2V2RDQ0t3SUhvTE5ESGd2VzJ0TjUxeDdQRmpsNmlPMnFUaHNtQTJEL0FC?=
 =?utf-8?B?M0xLZWhBcExRR3lwZEhrYlpOdXE1cE8rcnRsU0RmdUJwbm4zU1dHK05UTGFw?=
 =?utf-8?B?bDR3dFdvRGs3T092M21aREZYbkVyNitYbDBsbncxQ09tM3cvck5yT2p2bEUy?=
 =?utf-8?B?NFRhRXBsVUZnU0JPQ28wZEZyRVpQVlNhdXhGYnVIMHViV2YwalF6dz09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18c7516-5d3f-40e8-db8a-08df338aa467
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 17:57:46.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/WwOPmUp+zKKn6+AFZJerEZwKFBTpYlRgnqijkVto2jqzd6hP0adf1ackTemcVNeIIH1ic2noTg/E4TjumDLw+De/w4ENOoOB6AjQXnq6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8451

On 23/10/2026 10:21 pm, Dave Hansen wrote:
> On 10/23/26 14:00, Paolo Bonzini wrote:
>> On 10/23/26 21:03, Dave Hansen wrote:
>>> Any thoughts on what we should do?
>>>
>>> Actually context switching XFEATURE_CET_KERNEL seems kinda silly in a
>>> lot of ways. PL0_SSP can always be derived _and_ it isn't actually even
>>> needed at context switch time, only when running userspace.
>> True but, just to understand, what is the performance like if you
>> actually use XSAVES/XRSTORS to update SSP0 on context switches instead
>> of WRMSR+cache?  Hopefully the microcode does a bunch of optimizations
>> as well.
> First, we can use WRMSRNS for this MSR, so it's faster than usual.
> Second, on kernel=>kernel context switches that don't go out to
> userspace, it doesn't need to be written at all. It's kinda like the
> user FPU state. Third, I'm actually reusing the fred_ssp0 cache, so
> further reduces the incremental cost.

XSTATE_CET_S is a weird thing.  It contains MSRs for PL{0..2}_SSP which
are the shstk equivalents of tss->rsp{0..2}.

The Ring1/2 aspects are practically useless; CET-SS was the thing which
finally caused me to put Ring1 PV kernels to rest.  All of
tss->rsp{0..2} are switched together, so I suppose PL{0..2}_SSP were
grouped for the same reason, not that 64bit OSes use task switching.

Windows uses %xmm in the main ABI, so already need to XSAVE/XRSTOR when
switching between kernel threads.  So it's "simple" to add one extra bit
to RFBM while doing this.


VMMs probably want to use XSTATE_CET_S simply to have the guest state
held together.  Even then, it does feel like a waste; PL1/2_SSP are
going to be 0 ~all of the time, while PL0_SSP is nonzero ~all of the
time in a CET-enabled kernel, so you can't even rely on the INIT
optimisation to speed things up.

Linux obviously doesn't want to do an X{SAVE,RSTOR}S between kernel
threads, and isn't using Rings 1/2, so the WRMSRNS approach seems fine. 
And I agree that it only needs to be good at the point of returning to
userspace.


> Fourth, it's not _really_
> context-switched. There's never a need to read the register. It can
> always be conjured out of thin air.

The requirements are different, depending on FRED or not.

Without FRED, PL0_SSP must point to a Supervisor Shadow Stack token. 
IRET marks the token non-busy (squashing any errors), and IDT delivery
checks it can atomically set the token busy, yielding #CP if not.

With FRED, ERETU checks that SSP == SL0_SSP and yields #CP on a
mismatch.  There are no checks on entry.

~Andrew
