Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792788626;
	b=SecBuBckaBO2Z3ffBDEMjdx3nZGiPbp619EGDmtQVaZ0ahxkclh4xZKaMENO7kUrLmRP
	 JlRnbCAYp5h1YjXEvxtc/6DeOkTHKEWvLj63IkFAQpOeYmqfFif4Q9cLun6w3BzKK4C8F
	 ku6csm/3b4cGORKYWhrLXnrlZO7cxt+X9psXzbdIL4ym2LAQzNfk2VigSSCFh37W8Fq+6
	 YDtvUKNzLwtBO94S/2O/tAIqxR55mxWLob+GIEW2SLQgRPrCQtPrwwI+zSOvCsokvSdbW
	 jNe6wzJtbPDKPMF89F4PqfrE0NKNQ0LqmVoYWMwOB08CA/x4GLSmaY8nAp9lAZah3uA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788626;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:To:Cc:References:Subject:Content-Language:From:Autocrypt:
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
	bh=Ia5tWyLV6/Psp4G4ilsi1BxXmFUMqlclhF8Oq9n+Nrk=;
	b=sOkrkoeq0ZnB772Pj5jT6/2sV+sRfAm5wsHxs+REX7jfcA5/6BlvEQ5zQzWRCTnHM504
	 /J8nQfvh4/VzuQCnGrSG+Jic7XhlmSIMkvxCfZXHt9oIjrQ7Enb32vGWLTbDSEQH9tcfU
	 nAwAcTE/QNXlA30kpexvDqWiXpByNuA9FI2Smzl+QuFy0pBoHZF4ViANaupIFxqGxgjaj
	 EmpvuPj3GNsax12yvnMsZtfuENqkbT16G67860KAfKUGtNluYz0UuW+9W2x6DhObnoChU
	 IqWBMq5Cvb7kBQ2AuWLuKSky1rFcB7aF8/h/ONSyAZhznQrS1Bx0/J7tk5Q7eRBe2bA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=citrix.com;
	spf=pass smtp.mailfrom=citrix.com;
	dkim=pass header.d=citrix.com header.i=@citrix.com header.a=rsa-sha256 header.s=selector1 header.b=zFFppzpD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.63
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88432606A31B;
	Fri, 23 Oct 2026 20:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88432606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=citrix.com header.i=@citrix.com header.a=rsa-sha256 header.s=selector1 header.b=zFFppzpD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/eXyctVpYUEfOG1kXGjh8WJm6754xjlSc/l1nzh+wyM4pCIhY9CIyMiMP/wXemTJ14+gaEMeplI4PU+87sYpDeQhhG4zItmGnmVy5NgnmuBi5FkCYYkfcWBGRtZ/pzKkzAPxOlOoZq/hR0XWrM1Hty7QpG41TSQLWsVpk52zNUzVGIxeT9PZGl0e766MjnivyQ995PpjBCM/EUkzaOBsOm3oP4KC9+oYAZVEF6+N3JmEnv2ao6TTfRSIRls9yFIOppc/KvpAUgPA3Tb6HJN60Ix/825dDan+d7oLCSlI96HULJ5pLcIzrOHG71mfbMoF7sW0IyH32+2a4ZJuS17fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ia5tWyLV6/Psp4G4ilsi1BxXmFUMqlclhF8Oq9n+Nrk=;
 b=Wh6ZwEvFJC6WIKQAQsSeVd8WvZgTx9u1EanN237sS0gqPDvrAwOmNY1Z6fNG11cbqpKuQR579xeiBV1nx1cc1hEMabFjJ0NKeiCshPgXo68w54Mq8bo7nSypSaGkpWXo5hCxY/kVYAslyJd8VKbIt8KzyTe54C+FfY+TJKPrMTI/r8GiKOPoFyeFmKolAQgsW3LUBEFvtLofkG9JkXIKZ4F6pWc6sxahp7teWNn7PQ/KFYxH1u8SiuJsF7oTUrjJdAX5hFhwUoLbPb6hQX0J3VysRM2EO5hXfSl0wxV3nEJGZ4drnKgn6ok5U3m+7tjFdzr25LXU4odTe7XoE0ttMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ia5tWyLV6/Psp4G4ilsi1BxXmFUMqlclhF8Oq9n+Nrk=;
 b=zFFppzpDSw6M5PkUQZkm1bRmo5q3d7JyHCJYb2TYkov9W3hYNFG8aVgBU8GaiOinVmWu7fx9jtdOlI9sN2LM40Tkw3+3bpDrS4ryCTmO2LTecNywqDr/C3pwyGsmarqbMdw3tpwLCnkqJRpJf+WaZL1QFEcyzTFLASN835JJ+Fs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by DS0PR03MB8246.namprd03.prod.outlook.com (2603:10b6:8:297::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 20:50:23 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 20:50:23 +0000
Message-ID: <9e3c40e9-d211-432b-ac1e-19cd878257e6@citrix.com>
Date: Fri, 23 Oct 2026 21:50:20 +0100
User-Agent: Mozilla Thunderbird
To: seanjc@google.com
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, chao.gao@intel.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com
References: <YhekNhrK7VKW1jDV@google.com>
Subject: Re: [PATCH] KVM: x86: Do not change ICR on write to APIC_SELF_IPI
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <YhekNhrK7VKW1jDV@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0026.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::17) To CH8PR03MB8275.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|DS0PR03MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: 931e72f8-6fdd-4eb8-5371-08df3147424e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|261022105027099003|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	MUEma6eWFtemutxX0A/SBgqSeKaJ8alUDvY+ZHJJxbIgNJu2B6+1ZjMfEfxpOBvHJgW0+YjTLxTMtVOzfSNt7h9oRmyiU+OlSc7uf3k+lefzxEwLUJm2iRWMzrUf28wc0vuhXsIB8C/QEBrkevpX+YeE4u29reJvF4V44evuYydUV5LZDL0/y58Ssx02USev88J86c7/x9UYDQGFOuTsQL1h68yUVW+K69+Z8U9MzyMHclv2f1QDautry/74h0d/duY85JskW4q+60dOGeoZtGru9oURafhSqii2PH/cR+AX5or3MKzBEoQCgf8Brs7ouvg09487BywnmIn+KhBvKcAtiCITXXKZ1Dvr9/ZzRTu+6BqO65KC2jCTqEGv6ZX0a6/ie5RBeWg48QGmBFIVDNGfYdWJ7YjwNDgdA6OqVf7Sih+MFW8yrCdQYLcp3Cu9rb/KyTN1+sO3JMpsIkpDeqa61tZ1onoDANxqWwVRFpp3/VQg2cf5t0GHOHVzH5mCJLxpIpaqZtGUp0Szz7tnZ4wsmyTgx1Q+tDrUNkW/tg2EpKJfU7oFGFjqARuR/lPMK2lSPlmv9ay/PMxpWeuY4JOHOdzKADMKJ6GAuNS3F44XNMIK3c58oRaJ/DFPlzX1I9Nzo2c6qaYLk6jbNhv00w0ic+AcuqTcqlFRifEgTVE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261022105027099003)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1Z0R2MrVjROZzZIS3FYcG1URFRpVFZhZ1hIS1pJNlpUVTNEUG1Wd3hydElK?=
 =?utf-8?B?NzlKeHNHMkJKdGx6QWJsalg1ZCsvejR3TGdJb0F6bXBrZWFhbWhmSmRqNmx0?=
 =?utf-8?B?S0paNDJFM04vWUhuUjFnbWIvMjRyZUY3WWFjSVZxL0IyN3V4R1g5Qk9IOWFr?=
 =?utf-8?B?TTFPWkU2WWN3eHA2RmVhMks2Z0hjMWVTZFBBeDlIWVFISTJoUGFJQ1ZXejZY?=
 =?utf-8?B?S2lMeEpycGtBVU9WWG9BRDRXRm5mQ1JodW9oTDFOMk1sVnpDd1dwdE01T1k5?=
 =?utf-8?B?bDlPODd3T3ErdTQ1Tjk2ckN0bTRQUU9KcDhvTGxUNWlWcjJBUGZwcWlsZmkz?=
 =?utf-8?B?RXFmdklIdzZiem1jSFFna1VzSjBIQ1M4c2piS1J2V0FNZlFYT1F2NHluQnR5?=
 =?utf-8?B?ZGxtQ1V5ZjY2NWdFTW9nQ2FRa0JyakRzdG5GUFVMQUNWYU1JYmtncG12cDNO?=
 =?utf-8?B?aTVjWm9Ta3lKQ0FPa3NHTSt0aFpEdFhrTFUvRDZRa1E1dXRiY1RxcUduU3Ix?=
 =?utf-8?B?a3FBM09McklJeXRaejhjS0NiOEp0MHlSR0FBTkhNVWpZNE9Xa1d6MmJ6SDdy?=
 =?utf-8?B?b3g4ZTJzWGVoTy9zM0U0R1I1ZWxGSnlFdVVFY01zRlpScHdPVGNUYWZVTG9l?=
 =?utf-8?B?M2pTSUZzcksyWENWcW1ZcXkwN3FjR3l5bmZhVkswL0FMWm0wNXZKZ05YTncx?=
 =?utf-8?B?eGtNbVZvMUFVcUZnWUVpUC9BZVA1Q2xqbXoxYlF2OEd5NlErdHZtZHFSczF2?=
 =?utf-8?B?S1hFZEdFOVdZRnRtbzRDVDhmWDRLOTRBRVFtQUg5Qlhsbk1sUTRybUp5aEow?=
 =?utf-8?B?V0NiaFVXMmlHd0E1K05XOWVMZStkY2RjY2FaM1lIaWk5MklGQW5qdzlXR2RG?=
 =?utf-8?B?RCtjd2RJaGJLeFIvWkFKdEMwNE1SUVFySkhJaXZ4TUhPeHZDenlSVkN4SWcr?=
 =?utf-8?B?MTNqK1ExWXNaSStYY1hQdDMyeGw0NlhjUzJxbnpkQjdYQjRqWGxmWEN2M3pX?=
 =?utf-8?B?SUQ4Vkx5eFBLQkYvaEJ1Z1JQNjZKTWFaVHQ1dXc4bGFGUVMyaXpSaDdJTWU5?=
 =?utf-8?B?YU9wUCthSkVVQzBVNjRyNGJEMmNITnl3dDV6RVJaZUxEbTF5Q3MzNDdmdXpG?=
 =?utf-8?B?ei82eWxBT0hMOTdNZjg0N3plb1FMWGNGNFh0WEs5VUYxZXdEaVM5LzREOTNs?=
 =?utf-8?B?b1FxdVNhK0liN0w0c28zSmxrdm9VKzZlQU1uVzRrd3VNWGhMWGk2RXFCOTZo?=
 =?utf-8?B?NUpDdnZGU3JMWVBKOUJud3QwOWdnME1OTHFUdkx4a3NXVU01RjlLdmduYVAy?=
 =?utf-8?B?ei9uTXVxRmZCbmpINU81VzRJNFVJdWpMQ0hEN29ZUENaVmFVa0x0NHZhUzNS?=
 =?utf-8?B?eW9xWStUSGIyYmMvQWkrRjNvbUtEUjAybnhkaVJMQ3lpYmZqa2ZOZE1OOFB2?=
 =?utf-8?B?b3pZVi9CM0VBcTNJS2srL1NXVG5vVExWaGxjNVJ2Q2NZYUZJeGpLYUtPR1gy?=
 =?utf-8?B?Mmx1a1lLSTNWZ1VsbEd3dVBmaldlenJHekFBOUhReGZRUjRwTHBBNFpMYWNi?=
 =?utf-8?B?QTRzQm81U0Y5a1I4cGsvQTRpUmJQZTliZlRLWGxobzJTR0c5UENvRS9hQkVE?=
 =?utf-8?B?UG16N0FwTjVtSU13WU5BUWt0TG1BQWxLYkR3dHRUblVWeUJWb2MzMVZvcFBJ?=
 =?utf-8?B?RTZRQWkwRTRQWUJ1ZFF4UVRZMUZ1ZkdwbkZkQTRDYU5KdmVHVXFwU1VVdXBZ?=
 =?utf-8?B?SWtMcjMzRXUxQWQ5SDFXdDNtY2VrNkV1MEd5b1gwWFZLRWV1OVh0WW5VekFR?=
 =?utf-8?B?OTRlc0RSSTZhNGZBT1djNWNDSVdjT3FqN1A2WitzeWRWT2YxNDJMMkJPNFVq?=
 =?utf-8?B?NWdNNTVHS21HS0k3MEdoUmIvVXhLcllLcnZGVVR6SURabDlKUWpzSE5JRVRk?=
 =?utf-8?B?YXBIb095ekxaWkdMR3B5WHVEWEFvU1dMN1JHZkJUV0wzVUZPU0prL1JJM3Nh?=
 =?utf-8?B?YkprOEVTaUNWZGRtVWRoTjIraGl5WnZkKzdmTjlHY3hsRERTbm0xQTVGeUtS?=
 =?utf-8?B?M0VMbGRkUXR2eGdXUUdGYVo3TExWc1FZU1d3OVJjcmVCNGZQbG9BRk5QRmt1?=
 =?utf-8?B?VjErM0Q2LzlwK2FHRzZYaWtjM3ZJS2hqNUxJc253bzJPRnlXdytPS3dRZGZG?=
 =?utf-8?B?ZE9haEhTYmJ6SkFodll5M21rZFRuMUtibEpVVjZSQ3J1dTJYdkVSMkNLaC9R?=
 =?utf-8?B?S1kvVkVZWE13bkh5a1AzSWZWMFZ5aEIwRm9RMmwyOENpVUE2aDJkUnViR0tl?=
 =?utf-8?B?UDZDWVlqbGRFWGppMDIzcW9paEl5UlRFUkk1enJOMiszQktzaVVVaVFLeWts?=
 =?utf-8?Q?o0VCN3rG3VXK9P48=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931e72f8-6fdd-4eb8-5371-08df3147424e
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 20:50:23.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckVEqBDMrhLXARcNGGaNvVGS7UCTOeKjTuYLMXN3C+3fuT6IaToOZkRFrE8vX3FQ/+fy2UOQFsVN0godI2ZVn3vvVdEii9T6bXjHAA1mPf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8246

> On Thu, Feb 24, 2022, Paolo Bonzini wrote:
>> Emulating writes to SELF_IPI with a write to ICR has an unwanted side
>> effect: the value of ICR in vAPIC page gets changed. The lists
>> SELF_IPI as write-only,                                                  ^
>> 					         |- SDM
>>
>> with no associated MMIO offset, so any write should have no visible
>> side effect in the vAPIC page. Reported-by: Chao Gao
>> <chao.gao@intel.com> Signed-off-by: Paolo Bonzini
>> <pbonzini@redhat.com> ---
>
> Reviewed-by: Sean Christopherson <seanjc@google.com>

This patch was just attempted to be ported to Xen.

Contrary to the claim, Intel Core (P-cores) really do overwrite ICR when
processing SELF_IPI.

~Andrew
