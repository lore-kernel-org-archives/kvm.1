Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012042.outbound.protection.outlook.com [40.107.200.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825C3FB7C7;
	Thu,  7 May 2026 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163687; cv=fail; b=aZN32TljmdtSfNu4U8RCYMyGsLLCqapxqDHdTgVJ7z4+aAd+Ej7uMZB2vwXsAtM80D0x4RVzviI7EWXnylWmLbwhfmlMjw966XyRIA5Csrtr2QidTjOLGXDTkAlSmOnJ+zW/Nkt3O3EFTuVvWAPkP156McjYVDQ0SdNn5g97Bog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163687; c=relaxed/simple;
	bh=CDXu7Yqoae7+y02LpCRS4iNhUgy87EW8lEOmC+kTZwk=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oIqsVMOn+av9TQlev53Uc03xUXMLnwjRIFMRWKTMGyoc7Ccn6N0kRDHbBcrY8fVkwPHQXoLIxBrFWCQZj1WUd1KDXHRDz2iOACzKqCP2J6pV3pVghIHImP8xbmG+zXJHdKUaUr4QzLwUD/53whbpQrOJw8snbZN9ewuX+g1a/F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=XuCTvhA0; arc=fail smtp.client-ip=40.107.200.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="XuCTvhA0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEEV1Qr5/m8iorIhD+VYKWG5iaKpeS80ItYKP+m8McFsL6PYg1EgJQ7kiraNW1xc3HWhyiRpMKqKmBM1Tt9temP3XSTJWkn7mSz8XvRpgvZfan166zw1Nfv8cYiSFR2kI9LczvJEeiYSWJbXKmPxu0SvzNK4P5vdX+vr4x8XuYWfmJDXWEPUEda+f/3vw+r982FEy9BOq7m0pVaFv4Na244EpEWd/iDd6Z7DaI2XVIQPVOpSqlkBYY0ZNQtkSNwdzguskoqtrlPwsaTeEh/wvPx8ckRXw9kGiM5tE8/hY+bQ3RroOFR9yvpoWpyHDxwxxkok1FyJLRjnxBo1jjsKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqRadwHnpLtcVdTebzHrEoqWz73Vv10bSbK+D/9c8xM=;
 b=nFY7gAI/pK4Q+sSd0UK0QaVwLfwse1VkweOQNegCGYJ0BBPCUfnoOQtvocUgOQoA/stbzgMtLiSjm4yKEtkwWWvbibuCwqVJNS6P2YyAGALmMaEIAcm35NYJH+Kjv93lcp2fr8/gBpDBwZjqfn2K91iRcOyGCyZq+Bp2vnwOQkDQxOA04bv7kRsmLR23pw2CkLqmHqzag7kuJK9kkfmovs8tz1uG6S4NYJxqsMz1uPW+tt6KmBaJSFyd5qwYrzBLE55JQFBfwhNp8opaVkhpXKKOlBrkhyd8gLHjbQuxnmA0Cb3pr0PTKlmm5iak4HqYc16o/tUQrtHpzEPtNNjAsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqRadwHnpLtcVdTebzHrEoqWz73Vv10bSbK+D/9c8xM=;
 b=XuCTvhA0wIPWGMqDrbKVpxghnE1SZ6F2RNWBiRI0W+62lduSqX9FNfFPdol5aJ+djh+wvvufUpiAE6/6z+uCLqYG5Y+Oj4CiCnEBbC8YLdwkRL8d/82ex2ta6bJPD6P7qX9Y7BHSfKUubtCd6Y5ONciR/PNg/xn3hoFT9CBGFZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by SA2PR03MB5772.namprd03.prod.outlook.com (2603:10b6:806:11d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 14:21:23 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 14:21:22 +0000
Message-ID: <beff5bd9-ae7c-4f2e-a718-7c8e92e78e4e@citrix.com>
Date: Thu, 7 May 2026 15:21:17 +0100
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "Saenz Julienne, Nicolas"
 <nsaenz@amazon.es>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Subject: Re: [PATCH] KVM: SVM: Always intercept ICEBP, add INT1 selftests
To: Sean Christopherson <seanjc@google.com>,
 David Woodhouse <dwmw2@infradead.org>
References: <e03f092dfbb7d391a6bf2797ba01e122ba080bcd.camel@infradead.org>
 <afycwi4KT6xrQhMX@google.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <afycwi4KT6xrQhMX@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0042.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::16) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|SA2PR03MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 421eacbf-c995-443b-56d9-08deac43ea03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|3023799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+TaHD/w3/SmDsEQUSqEI0bP2T9lAULmnrI4xgMoDSkw/Cr3moUBwcgOGPVmMnTqpkaCRC73nQLg6kjiWw6liiuxE2JrT6aB1zxL01WHLyUojHILIcadHoOOZJd4B5FhiUnnWFdWI5TlX9LiaoWATVSUN0qUG2Imd0SIBZXP4RfH5PT4Qw4ak7iVxobTajxr9+9QvsP72EDSdsZJao66wb+UYFHERf+BeSuMoGSaogHBtA1nNSCF6V0TsAmo3u20JzKGEMaZ5rsg0JwlUn+NffvM9kuUfgwJwq6OvEX7HSzt/ThKm5x6RJHxKjEEpJCNwHNuew+5sSroDkMJDW89UwuxL0jJ0WLfE1Z2ZIf14i3CO7ErQykGFwD3FiqwI0g258luIsTMWJIH7IqCIR48yZSiKvmyjGmVVwsM2jogSkg78L3UC0OlioHbHxi8SSR1eiJWb819BwSbtLVL/rgYki+4H0pw6s3Es6JsUQYrBaZBe7QH2b5NhYZz09jcdaEibwjOnGNPlCkRLUfcHxg26geICJzy7tuNrxL9HwPztc/Hm6GoqN8su/A/SIzE07KnHKCoAJjkatTeUE4YrX7u8CJxNszbpZSbTnHi/GRO6nvMmPserM3Wf8z3KKRjzJtlMIssM3ZkzPz2fyoj/GzHD6hYvpx1kR+C5merVS1ay4VVXEjIvTUV7xsTycO9FSx/q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(3023799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjIwTkRuUzBqdjdoMnVXYjgrcnQ3a3IrZm5nTElYWjZ6bTRDcGFKKytMbmFp?=
 =?utf-8?B?dEhQeDJ5dGdtY2pEbzcxZmw0VmRoZm5GNE1oOXlDVmkzbzYvdXpsTlBBME1Q?=
 =?utf-8?B?VTdRelV4Zy80MWE2VmhPemg4U3BTSTZVak5OQ3JjS3pvVC85dXFBNy9FcTNj?=
 =?utf-8?B?c0VCYXVJWDZNbFB6TVZLWmtlY2hsSm5OMk1oZ0RTcjhXdkNuQ01PK1ZCM1p4?=
 =?utf-8?B?elRaMVBuSjNMV0VxS3hIVkRPbk5DY0UyWk9KZFZXdms5Q3lydFBMZUxQeHlr?=
 =?utf-8?B?ODk0UW03eFgvSktheDB3S01sZk9wNWRNVFBMMWlrRnUzL29UQ09YcjUvVTR4?=
 =?utf-8?B?Znp2dm0xWmc0VktPMFFLWk82REwrUXZ1cm5MN2FZVCtKMHQ0VndacnMxMlhT?=
 =?utf-8?B?U1dtQzhnZm9CbklYQTBjajExSFZpWTduUFlwWkFFbm9ldytxSkF0ek5zbVF4?=
 =?utf-8?B?R0tSWkhDSW03eTdONWJYS1BqMlpxWmFORWVyR1dTbjRvM2kveXZEeTRFSHFP?=
 =?utf-8?B?cVd3bWlxbHg1Q2thV1RoZGt3VDR6UTduZDY3YlFZK0lHd1VXeHJld3Q3dkhJ?=
 =?utf-8?B?S1hnRXFnRHBMbEJmdm9HeGpRQTBNOGV0Y0NnVHEvbGl2ZjJxaXViWWYzMjY1?=
 =?utf-8?B?NllNVUtnNGpQWWtWRE9TQ3JwWjZySzJUVTZmeFlyQU4zMjJIVTJ3emFPdnQ3?=
 =?utf-8?B?eThKVlM0eVdBWjNpZDRVYUJpZzdhaXpCc1EwTXZ4R2s2N2k1QmJsVVh3RzVN?=
 =?utf-8?B?bG1yZkN0NUdFbENpYmV4eWhLS0xXR1p6VEtOdzhvY2RjVm1YNVR5RHF3ZEQw?=
 =?utf-8?B?aXkxV2owdk1GbUZkWXJWSWNsSEJrMlppSnNnclVJRGw4NVlIZE1yUVZpMUdD?=
 =?utf-8?B?YjVObng3UmlSTU1yZ3pxUk1YQUVoV2RvQy9uK2M3M1dBNWlzMm5BVkswbFlr?=
 =?utf-8?B?Ly9WQkRyYXY1Z3A1ZDBnRXVpMlBKZjlaTUlwMGZ3bEdjSmhZeXJjWGZ3cVRJ?=
 =?utf-8?B?VTYwTHJZVEdJTDJ5bit5bkNuYXBuZVBYZnFzekh1UVNxaG1NZXBkeUdkUnhU?=
 =?utf-8?B?R2tMOXFGVGJNQjdaOTFab3ZVRmNHVUtlV2I0Wlp3WXMzcUt4N3BjN01sbXBM?=
 =?utf-8?B?N1MyQjgwdXJoUk5Ea3lQTElsVzl6aGFYOUwxNlJzNVJNRmNyQUhYeTJZNFlJ?=
 =?utf-8?B?N0RDTlArQU1seDA2VlhSck1ydTVJN0dISkNwdk9XTmxYVDk3b0pVQ21yUEFt?=
 =?utf-8?B?am5BQU5BMURFTlNVSFpUcFZuU0tkVVVUZ3ZwdVVVRDlTQ0RlOCtxTnpyR2pF?=
 =?utf-8?B?ODM3aXAxMmpzeUc3ek8vNkI0QURDVlQ1MjB5N05hQzB3aW9zN3hMRmFhU2Yr?=
 =?utf-8?B?ZnV3aWl5bDZXM2c5NmJ4N0s1dFpnMWxUQmw3YTc3OXRrMUtjY2tIT2VpeUxu?=
 =?utf-8?B?UlVRaDlmMGVNOUJGZ1k0Wlh4eUQ0RzQ5YXFocVJZYXpacXVvZ3NDVmwvS0ZB?=
 =?utf-8?B?bm1yemRWVFpxaUpqYnFmKzdoRytlSzNOZ2lCR2JNTFJMSG1Fc1pNazVPd1B3?=
 =?utf-8?B?L1VnZk90SG90RjZQV3l5cDFYTWFZb0RYYmF6VERNTUpaclkwalc5dEJRZ1Y0?=
 =?utf-8?B?T2pUNmIxYWcwNWdyRmRtYzZFdVVVMVNGWit1a1o1eHd6aEJheWtKRmo1M29y?=
 =?utf-8?B?RGFwNzZQdUNSUFhQNGV6Uk5mT0RiY2tac1Z0R3BkVldIVGZSWUpaaDBHUGNZ?=
 =?utf-8?B?MjArSlRxU29RSGV2U2x4bXdVdnQ4empIbTJ2UVpPWlNhRUUvaGYzOTRXL1dV?=
 =?utf-8?B?WXpUZVMxZGtQTUdhbm9HcXZ6eVpsTlBlaXpxRjkxM0h2bmRZdEVRYXgxSjBJ?=
 =?utf-8?B?bmhwVUpVOE82ZmZIVjM0TXhDdnE4bEhNQ1hGRVN2bXlGWUpZZTI3aXZPYk1G?=
 =?utf-8?B?SmtJeUpUMXVUc1hwTHBIYXZXYSt3Qm9uMVBLMVlNYnl4RW9wZzREajc4QUNS?=
 =?utf-8?B?cmg0U2NLMTdqKzQ5TUVVaFQ5a3pKZkxwMXVndGRCcnF2R3hzbzdtQ3RaZWNi?=
 =?utf-8?B?dEFQUStIR0VvT2ZDKytBMzc3SW82cEdLMHg2TXk2M1RIQTlOZytpN0VRSmZp?=
 =?utf-8?B?NnpqT25lWUNJYUhPYWNmVTEwWTBkZzBvSzRIMWRtYjhrd2VRQ0Urc2t5UjdO?=
 =?utf-8?B?QTIyU3N6dlBLT2hoZ05ucFBpYzVWTFM3RjJyUUt5TjJiL3ZRMkhGZlhDOHps?=
 =?utf-8?B?YnpMWG5uTVgrUEt3c0Z5M1ZNelJYdjkvTTJlYkI3SXMvYVhvaHQwa3BLWm5P?=
 =?utf-8?B?bnZSK3NkQVNPeXVYbWJtZFdHdUJ2NkVzdUFQVGhYWkhOdkc4eGxqT0NHWVBF?=
 =?utf-8?Q?G9dvQuSIEC7qpvoc=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421eacbf-c995-443b-56d9-08deac43ea03
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 14:21:22.5399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFVzTCeGr9G366V8fhbR95lNWvT8IOVs8J6bGcp/jBJTkPg8wFPg/LRXDcuEmoBv2LC0tMQyFWQots+KLmlXgdaV0R0+ET/paXQMkd1Z19Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5772

On 07/05/2026 3:08 pm, Sean Christopherson wrote:
> On Thu, May 07, 2026, David Woodhouse wrote:
>> From: David Woodhouse <dwmw@amazon.co.uk>
>>
>> ICEBP (INT1, opcode 0xF1) generates a #DB that is architecturally a
>> trap, but on SVM it was not always intercepted. Unconditionally
>> intercept ICEBP on SVM to match VMX behaviour and ensure correct
>> event delivery semantics.
>>
>> Add two selftests exercising ICEBP:
>>
>>  - int1_ept_test: verifies that ICEBP works correctly when the
>>    exception stack page is not present (EPT/NPT fault during #DB
>>    delivery). The IST stack is evicted via MADV_DONTNEED before
>>    executing INT1.
>>
>>  - int1_task_gate_test: verifies ICEBP delivery through a 32-bit
>>    task gate, exercising the legacy task-switch path for #DB.
>>
>> Tested on Intel Sapphire Rapids and AMD Genoa. Without the SVM fix,
>> int1_task_gate_test fails on AMD with EIP pointing at ICEBP instead
>> of after it. With the fix, both tests pass on both platforms.
> Hmm, but KVM unconditionally intercepts task switches.  Is this effectively working
> around a bug in task_switch_interception()?

Not really.  It's a bug/misfeature in AMD CPUs.

When you get TASK_SWITCH (which always has fault semantics), you look at
the vectoring event type to decide whether it was logically caused by a
trap, and therefore whether to move %rip forwards before entering the
new task.

AMD CPUs don't distinguish instruction-induced #DBs (i.e. ICEBP) from
exception-induced #DBs (all others), and also don't report an
instruction length for an ICEBP-induced TASK_SWITCH.

The workaround is to intercept ICEBP unconditionally, handle the
FAULT->TRAP conversion in the hypervisor, at which point the #DB-induced
TASK_SWITCH occurs with %rip on the correct instruction boundary whether
it was instruction-induced or exception-induced.

~Andrew
