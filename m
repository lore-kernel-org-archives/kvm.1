Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794601605;
	b=hwBwQzAVYpcnaBc0Cp2Bufmwp1pObhDHLHFfttDtzsDaNyf3Enh0oFeO8O8Hv3SvkZN7
	 A6RDmfY8OkIj7B//Qog3pucslMxo47beuzhPJYdFNManh4FWX7XvdJIgJvp2ohgaHp454
	 gIjLAdfiiLFQ+TE86Th8QZ+x7dUI3CyCIagkvHUefLOqPex7cOPGPcIm0pCJHfRs4m9BA
	 mnZ3wBnFFMELF9wZfbgc8otUunP6VkwsD88GsdC3KBbhwBW00Dh6vt9b5qcogi+lPEcP3
	 G/q2/U629uyjquI26VSxOlxItv8Vc8hb7BURHSIrlRV2qS0yHZsXUe/SfoR8XDi3YDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601605;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=QqIkYqZeSoc/2lcPZKMr8rJ9XJvrru+p2bZbCAPzEkQ=;
	b=KxXqb+SiJHRXvV73kh8sDWD6LXtlObqJvzIhVPh9hoejetyRHJiMThJ2vqE75n4As/lV
	 oHHVwQUdueIMQkZ0qSvh4pHXDJkK6LNV4sdsQovbUNjd0236GbvawG6z9kO79NlP6AU2N
	 Us+YHG59LTlerthmdROfhVcybfgC9jNZ4heoQ5soHGbkdu9DSURVhkbOFu1/A4fwQnIUj
	 r2juPoD1I8tjWq6u/uepeY5zuGhj9VkIm2AlmkhLXZdYiIb4E1ECXduomwkTOE2Lmi6B1
	 CAvV0pwa7X92AmYkDlaXhgKDbWShXnilJeFAu70gr/QaF+Ivb0XFxSLwz+WM0DtHn4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=d+8ngGUR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.60
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B2C606A334;
	Fri, 13 Nov 2026 20:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26B2C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=d+8ngGUR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7CgoUEgW+lGzZXgcd6JA03p5tIa3PNA5SwDGS+NHCM/fYj88fJ9lgEsGOj9KB0ucCipfZ9//Vyo5NcBQ50PxMp4l9qEnWMMhz9X2CWKj1XkT2cHs+M+5OxosnjNfygjEQOQCBH1lSuNd2EHXYhoJ/vK5QfPqdc6THZzdOLM7F/4DoCa2W2rFz/Qq6ZavGH9KGo8em/Vjh6bPxrtArLR1HiSxOE0NT5wd0X2NCWUS+uVgaPxoeyLZmtLJ9TegiMcBXO2rdgUotNibq+0JLSUAFmpymM4kIHuTF/RuWLc4AuCe4nDRg4Ln0aHcpltbbIiLhRSd/iLDRJkxTCjZKj/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqIkYqZeSoc/2lcPZKMr8rJ9XJvrru+p2bZbCAPzEkQ=;
 b=l/uW82JkJd9owNze0r3E4peJ3mnAhmFWt4ZOpKJ8zbOvkiqrCw51ngllAw6w7NI2WQ6zqbanUq6J54Ew2irJpU2q1hj5SCw+l+Aw3rNnrv6vddKIjgIEhiAnkPxxIWQm9kM0jRvNCa6rIu+gUwv+ok05X5ri+squDeYy5IboknrekEhWvIygfye2WJ0RvptoQLMhNmws3ASd2ogzxrqmDdBzK1PDeTvhKeyO6HWA2L4z6bB4j2MCfcbVnUHytlIrteUzFEwUb64A8/2Sw63KPR+nY5C0Gxy2tLBGq/gnWD/nL48Z6V8xhoRY4r5ia69WqvzW0oHXnK7yhJ4a47PLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqIkYqZeSoc/2lcPZKMr8rJ9XJvrru+p2bZbCAPzEkQ=;
 b=d+8ngGUR9XVN6DlPHXPZseQ4I8Hq3zYdL18Mz2k9rQYRKkejvsigYFFa3PdpXFftRJm1CpxRuayqhWBoRW3Pd7OGLJYrhdcyVrBInIPWj/XMlncP/SR7DbM6DmCQwXPDTwPdjJGIqL/rn34FrTWbDDnvgMdsydAgUkVTIlXt8ks=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5310.namprd12.prod.outlook.com (2603:10b6:5:39e::10)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 20:23:17 +0000
Received: from DM4PR12MB5310.namprd12.prod.outlook.com
 ([fe80::1bf0:6a94:a990:14f5]) by DM4PR12MB5310.namprd12.prod.outlook.com
 ([fe80::1bf0:6a94:a990:14f5%6]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 20:23:16 +0000
Message-ID: <43616e23-cd28-4017-ba12-1a0eed4cf05b@amd.com>
Date: Fri, 13 Nov 2026 15:23:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 3/4] x86/sev: Add guest support for Enhanced SMT
 Protection
To: Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 tglx@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
 pbonzini@redhat.com, thomas.lendacky@amd.com, kim.phillips@amd.com,
 nikunj@amd.com, michael.roth@amd.com, ashish.kalra@amd.com
References: <cover.1794244450.git.prsampat@amd.com>
 <c64b614ddc83eabc6bb1bdf288272110df04256a.1794244450.git.prsampat@amd.com>
 <20261112184929.GGavYKObGQNQ0wbDpD@fat_crate.local>
 <avc-5lkQhoR6US9o@google.com>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <avc-5lkQhoR6US9o@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:610:cd::23) To DM4PR12MB5310.namprd12.prod.outlook.com
 (2603:10b6:5:39e::10)
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB5310:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a9c86cc-86a1-4ac0-3caf-08df41c3f348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|261009223027099003|56012099006|11063799006|4143699003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	OfA9z404ZwcAQ3DQo5fGG3d1McD4pG8fgcH5UHjgAk0Q6Ie5EwXrGROM9NxrrrcKVosF6zBFjJY8f3S/JcolFiUciEytl3gQjK5AhP7C2kZVj2XcxJsiISgN0tRn5B6DX334MQYGbCVmETWkCw7NP7mrrWwqIWobXI7pHzI7NbAkaYbt64jLNicbuwEiX8op58B3GgXyzUGi+2nvuAxz49bP284fbhhU7I3FR+/UEu5Kk/7oyVeLk0nBeDG6F15y+0wq1ezSMUDuUZPblvtxje81f1bnB7q4EZrdcW5Yh5u24DSwe7Gq+n4HnRHawDboSO3RTaILzRIblpiQErUZf5rWwm4RYTH7RHDVGGOfsm0R0o3E02R1lWlIBtR7y0ApDCJgqN2VtPWxi6GpXFGaCYg6VXr3Ofk9Kt+U1YwhpUmhmcjp9zmU8m02nvPy6+7xmN4UOrxy3vtJ5ziyq6IDuf+btIXKdx7EpyBikdqeMYR+KGwxQVdsNgoQI04dslFkKYmmsqLVUux/Jdg4bz/EHwhLlefKSY9is/Bl02Cxkr/qdDMm5FMGt9SypYEdjlLZee4EIJ57M2sg5yC+hBuIJ19PmS56XLd1AAwv+6Ns3+KnJR80i6qJKzgLa5dpvyIVsqIGcDRo+/ifwZ1v4DYwOj+E2ccV3H65n42ERTSuQ70=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5310.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(261009223027099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjdaTituV0wyVndSdEw1bi96aEZPejR6QjN2enhyaTRVb08xaldXNzdUbStV?=
 =?utf-8?B?a0hNbThxVVBjNE9ROUlpWTZkWVFlTnlrNVYrb0kxV2wvNnUxTGw2dHAwbTlw?=
 =?utf-8?B?UnFRTlczcFBBSm1ZL1FmVExsbkFPaldNV0lHNjVTM3dPV2Y5QW5PblVFY2Js?=
 =?utf-8?B?SjR4N09IQ0hoUHErUzJBaFpDRkplMTVGL0lmd01XZHlPaHZ6eXZpendpKzBz?=
 =?utf-8?B?TjBwRUE1MVFJbDhDMGs4L1BSRDQzOEh6U3gzd00rQmlwY1JJUGxRMnhJeE5y?=
 =?utf-8?B?dkRGV01VdXFuR0R0RHFsV3J4b1Bjd1FwR1REbENMWHJtOXN4dUp5TktsWGl0?=
 =?utf-8?B?b1oyM1JQYXo4YmtiTk1JamdaK0VRYVUvVi9Ud1hkdUl1V2tGTENMUEUxNE10?=
 =?utf-8?B?bE9KOUo5bGdkT1dlMGprMzJhQU5WMkdpTzhIVTBPa1pFZGJNdzdDQUE0M2pn?=
 =?utf-8?B?aW5GR0dLOFpuTDM4MXBzcU51UDVaRlh3RktyM0RFQUlqNGZtVHJJN3hnUVVs?=
 =?utf-8?B?YzJjL09XcjR2Ni92OFBMWERUemkvQ0c1ay9ycmJFb3gybTZ1dkIyQWtUY25l?=
 =?utf-8?B?L0xZbnZ6ZENwbjJmd0pUcHF3ZlVkZmFtSzc0eUZwUDZwQ2tzWkRlbEc5UFl6?=
 =?utf-8?B?N2htakI2UUZub1NpVjRYTUtpTFU4U2YrOGhSQWUwN0toOFR6TjR5cmtaYnA1?=
 =?utf-8?B?WFVXSGJzM2JnMTZKcDUydVJyTkdMM291TnJwTHdzbHRkNGdQRFR5elovVFFQ?=
 =?utf-8?B?dXUremo4b2ovR3RZUktKQlE3VnR0SUhGbjNKUzVZVHExT251d2pvdDRzR2xp?=
 =?utf-8?B?SUVBVWo2eVIwWmtDZ3JMTENrNUQwb3MzclkwbWhWZkE0ckxYdEZEd25JN3Qr?=
 =?utf-8?B?K2dYQXVyTThkcDgxK2lHZHZPdy9hU1ZlYVprSmJ5MnhhcFErZlJreGVIMkNO?=
 =?utf-8?B?VXF6YWNQMm9BYTJKbTRGQlVFMFEvUEhCOGN1ZnZtYStDMDBydjFGeVJ4ZXly?=
 =?utf-8?B?dnYyK292MnRTMGd1WEpkNXN5OTdnZFRYd3hqam51YlB6YlVHMXVRTDJtQnk0?=
 =?utf-8?B?YzVSQW5SaVcyWGpzVmhCc2hXR0lXcU9EZmRHR2tBSU0zd3A1NnBqSEphUFZQ?=
 =?utf-8?B?bGpKWjdmYUR1L2dwK3ZvZ0NodExBQXBGdUZYUFIzWmVaYlhnOHVCMjFaeTB5?=
 =?utf-8?B?eFYwUlV1blRVZmRhc1FPakZrWDk3UzNianBESExrRjRxUjVqV1FMb2NMb3R1?=
 =?utf-8?B?YTVZWUtoN3prMENQL0RhUm1wU2tRY1UwNzhXM09OenNyQ2JqN3c2MFNlUGI2?=
 =?utf-8?B?YWV4OXdNRFV5L0YyM1hNYTdIUDRiV1dtVkNYc2NIOHFXWm5FSFRQVmNoVldn?=
 =?utf-8?B?bzdobmlzZkZKOVh2ZWF3TmlTNEhtdGtpaXF5aVdlRFBDSjd5cnpCUlVia3NQ?=
 =?utf-8?B?TjVxSFN1NS9MVkd4aHlwcVdXNkl4c0E4RXpWQ1ZOZzVZdHJESlo2SjJlQklu?=
 =?utf-8?B?SURNK1pyLy85VzN3WWgydTgzTkxmSWRCYmdZL2Ntc1NaWldJaDhvWTg3V2Vy?=
 =?utf-8?B?UFNieHRuZlhUd0V0WUJMQ2p1bXVFRGJHSTA0VDJ5VURrdkh2cTFrNkhVOUZG?=
 =?utf-8?B?Y1lRN3l2b1lQa0ZsNmlMVHZXT0k5aDR1OVpiL3BCRkh4aDV5bzV6N0FQa3ln?=
 =?utf-8?B?eHdLS3JwejMvM3RxWENaTkxwbWo4UmdpeThQNG5tWVRxdFhmREtVNDQ2OTh0?=
 =?utf-8?B?ZUxWK3REYXN4bjRhTnBJRTAwQzg0YkZXRUQvZS9YdXp5ODRnOFo0WG9VNkZO?=
 =?utf-8?B?TmpydGpMbG53bG50RlNQQk9iZTdDQVZJODhHNXFoK2xyMXludTVaL3p2Y0N5?=
 =?utf-8?B?dE5wVnptLzhkejFFYU9NeStQY2QyVjh3OXMrc01qdnNBOUJkMmJ4bDRiVElY?=
 =?utf-8?B?VStIN3JBbXN3VExMOWE1YkJwYjZNU2FVWEtGSmRLUnlNNERoWVcrMXVVMU5i?=
 =?utf-8?B?Y2hiNDFHaGJqR291NStDcG84NTZsbXVsM2Z5QVZLb05hS3UvaGZzVlNNYnFC?=
 =?utf-8?B?dTVpckIwWDg0di96eCtWTEVwSWlpclphcWZEZmJkQlY1V05nYUZBZnJkak9L?=
 =?utf-8?B?VEtQSWFLMXpKQTNkWUFDQzhCUXd3ZVJySmpKSHp2L1gxL3htbnFvc2VIa1ZV?=
 =?utf-8?B?T0h0b08rMEZjRGNIblFNeHdqMzlDVmdGOWxXZnZGVVdORU1TeGxoQkFoS1Zj?=
 =?utf-8?B?L0ZDUllBUDkvSC9yYVExalVjWk9ibk9scnk0S05uSWhWNVB6NG55TUVaM1FG?=
 =?utf-8?Q?IeuwJ0NlkLriHhcTPr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9c86cc-86a1-4ac0-3caf-08df41c3f348
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5310.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 20:23:16.8432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30iQfG3SPlhqY8weLk41WQT/UOuskd88OuB0fofuHVxCWa0rRUlr9GcUCcNJwjHcLmaZMKV3/joFirQ9S3BF4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

Hi Boris and Sean,

On 11/13/26 11:46 AM, Sean Christopherson wrote:
> On Thu, Nov 12, 2026, Borislav Petkov wrote:
>> On Mon, Nov 09, 2026 at 08:35:13PM +0000, Pratik R. Sampat wrote:
>>> @@ -849,6 +850,18 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, unsigned
>>>  	vmsa->vmpl		= snp_vmpl;
>>>  	vmsa->sev_features	= sev_status >> 2;
>>>  
>>> +	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED &&
>>> +	    (sev_status & MSR_AMD64_SNP_ESMT_PROT)) {
>>> +		vmsa->vcpu_id = apic_id;
>>> +		/*
>>> +		 * The mask fully set puts every vCPU in one group, so any two
>>> +		 * of them may be co-resident. A legal ESMTP sibling must
>>> +		 * also match on ASID, so the sibling of a vCPU in guest mode is
>>> +		 * always either another vCPU of this same guest or idle.
>>> +		 */
>>
>> This comment doesn't belong here.
>>

Ack, will get rid of it.

>> In any case, this set touches multiple trees so I'm open to suggestions from
>> KVM folks how we should do the patch merging tetris eventually.
> 
> Post and merge the guest patches separately, and put any architectural collateral
> need for the guest code in those patches.  This is not high on my todo list, i.e.
> the KVM patches can come later.

Sure this makes sense. In that case I'm thinking of splitting the patches by
flipping the order as follows:

Series 1
  1. x86/sev: Add Enhanced SMT Protection fields to the VMSA  (new) Moves the
     vcpu_id and vcpu_sibling_mask VMSA definitions out of the KVM patch so the
     guest side builds on its own. 
  2. Current guest support patch - no change, minus the comment
  3. Hyper-V guest support patch - no change, may need the blessing from Hyper-V
     folks to merge

Series 2 - to kvm later
  1. KVM: SVM: Re-queue events that were never injected  (unchanged)
  2. KVM: SVM: Add host support for Enhanced SMT Protection - Unchanged apart
     from dropping the VMSA definitions now in series 1

Boris, series 2 still carries the X86_FEATURE_AMD_ESMTP/scattered.c entry and
MSR_AMD64_IDLE_WAKEUP_ICR, which only KVM uses. I'll keep your ack on those so
they can go through the KVM tree.

Thanks,
--Pratik
