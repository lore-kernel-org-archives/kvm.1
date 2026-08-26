Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4D22E764D;
	Wed, 26 Aug 2026 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750959; cv=fail; b=QMXMsXEkn2KUdkuxVNYaqqp2Jl9tIWmUl5yNldL1lRkzepwarpfH8qmcJ27XUWoaOs0LJ25pax3KEEIVVoylgCNZ/VD12gxgv/fY7iGCFqivywFXc5JCMjhwqbkdoGU6VpnAbrA9Z0ppVtlcbwNzo2Qyvvw1EirsxwzBJ/jkyiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750959; c=relaxed/simple;
	bh=L1o6PoCHfW6Xahekt0SXm1X5VXUdYWUtzgMU9r01Ja0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ayu6btEyn90iD14auJ7bnaEjqXafKkfMkcwgzDtgbk5hl3sISkozXKIURj2w2zNFZt3y38NsgItGsCsIjWSHFyxvAxgiP4AreGxXVxlZyCDGoFTMez8AIFgygvej0aHY10f6nVKHEymgwDZJvCTXYabX4D8qiULL5lLKU67Kq5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b2+DnNXH; arc=fail smtp.client-ip=52.101.61.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b2+DnNXH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSjjDFFHabQsZYInkDUKCwDr+ROSLdthqmaFDTnk8CFF7HTnEaioy1D8OiILS5M7YemutGxnvH1i7M1Eq8IosnVomtKVjfhZbQHj3MNkdpdDovTalURk683pXTDv3BgBwmcn5Ez50QMYblYYsuPTWWT8PNhDn0BabtZgIbbm6/idtAFX8s9gUFVRXXt3I/DM5/0w0ipV3cLnIaCd9WPr3LoFzc/ZNgYCNcKG530sdEwrcYV1islL5qI2nK8eNrWLWyJ7651rN4IIJJmAt1abL88Uc8IyvYFR1c9LbSqUMUC5Afel/8gWqpRoZm4ANUc4EBYaICtwIMTbMl4RVbZZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLEsmlzofubr3j/KzHSnAbcVGamqpZbfsjQvdhulaQo=;
 b=rli98Xam//NCRB8hvXYcgyn4nt1Jmzr6SS+6An7/xcjlfFMzQwxfTNGjt5YalH+V1qcQb1XYVLIdh+CxW5MCvPrfVpYeWtgDiQJcj4zvxflH/cflKxiWCAnB0CztvZiCVtijSCypvO/8rd0OK9kCl+TdxW2Q0DkXWyB2ySOsG/JhQoc0bIf9JZPoYKLWElG7kFpZLSK0FJ7uLTCA6WzXPEPvH3+TGGl31BiMLu0QRjxhXNEIMMXQNypt85qDvNlS9w8SK1mfWevHSmrGsQvVEdzaS6ODOCrWVcHZvoK6eyAmJUj6s2po/eB6OAAbux6nJrc31zwxdp0cyKzmoixruQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLEsmlzofubr3j/KzHSnAbcVGamqpZbfsjQvdhulaQo=;
 b=b2+DnNXHynLLPMRAzaiIcaYaiVfHcEOD0oMMOr2jPZPfPznvpWvanofvIz/yvM1Evxd2QnZMgnrYR0rmOvqH6gtYqb4ZRYE206M+sCiBVHGN0BOhBINIXmb5rLQpxZaT4KnK4167NCgGpDcjZqjc8101eGlYDVA0QGPpqNCPwaA=
Received: from SJ0PR03CA0267.namprd03.prod.outlook.com (2603:10b6:a03:3a0::32)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 13:29:07 +0000
Received: from CO1PEPF00012E7E.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::23) by SJ0PR03CA0267.outlook.office365.com
 (2603:10b6:a03:3a0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 13:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CO1PEPF00012E7E.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 13:29:06 +0000
Received: from [192.168.1.3] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 08:29:00 -0500
Message-ID: <bd4d5aa3-43c4-4792-830d-ca6c58db2dbf@amd.com>
Date: Wed, 26 Aug 2026 18:58:56 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra
 (Intel)" <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, "Thomas
 Gleixner" <tglx@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>, <vasant.hegde@amd.com>,
	<suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v3 1/2] x86/uaccess: Extend CMPXCHG user helpers to
 128-bit operands
Content-Language: en-US
To: Uros Bizjak <ubizjak@gmail.com>, Dave Hansen <dave.hansen@intel.com>
References: <20260826070004.8100-1-sarunkod@amd.com>
 <20260826070004.8100-2-sarunkod@amd.com>
 <e32c1437-44ab-45d9-9534-124a9e09f029@intel.com>
 <CAFULd4YFphkN4M0a_gC=vxN8Xgh4WWBGPo8dO-o6A3v9RGX4_g@mail.gmail.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <CAFULd4YFphkN4M0a_gC=vxN8Xgh4WWBGPo8dO-o6A3v9RGX4_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7E:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: efd6b4bf-c140-46f3-6e56-08df037600de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|30052699003|7416014|1800799024|82310400026|36860700016|18002099003|22082099003|11063799006|56012099006|13003099007|3023799007|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	dQu7J4Feuq0kU9CC3mlOZDVi3FyXhkqmJ9Us3TXlATJhUfPjlsMLk5/pophPoJA7Nz5Ry++UCS6K7SQAgxEVv5MEt5BmETaOj72k/Ode86k4dQ/oC1b2JP9K/GjdPDuWedGSmpuXTHXe/+5dlVHbHNZVR2Qkz6FKwbAeRIY9ZypBsP0cVW/3YkeCrZlkxD9tbZtPb9zE6HQkkVXbCONEE++bzBoq4mCVkThdkLEhLeDj+EsajJRGjblnW/vOmuhO/NTOC8D5mc2qcxYuJ7wZG7OF9XD6TRzuKRFw+L0GrEaOZwFBGVr2Gh5A8/dS7IJoL5E8xLYoL9OzujAlS+aweinXWEAVIW/k3soNUeAconrtSg0nIkGK+xklkNqrfjoj6uTBa2bW1mCyMGnDotp8NdoJ60nvxYSRvqXu1bPWwd8IhcOSjLLPaPHH0R603NJmB1QFc5hgbRbw0SWhLRHDaaJuDM/JSLOkK9yo+e7IfnT7Het7uVH4C579Y7yqLdu/xGQcEen7nGVZ4zHgeNrWYf1UADzSobxrbjn2Y2kU4nr/Mj1aiDiF6unArFmYx3lKR1Szejt9STemN7xOuYjrhtVWthX15em5Y4CTSkzmTwyoIQWYYjmnwQ5StB3QSfpDOyTFNYTEy9DPdC548A798w==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(30052699003)(7416014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(13003099007)(3023799007)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EUbkR+OLeKchLVI/LtHcziOvnmbuHKy0eUYecobG/Ae8Y/fw1yOaug3lVCL3s8oIuYiP6ai2yTOAI9TN9WozzbpgRI+yTEDSVtdG2D3mZP9dRd7J7KUF0j/Zlyh8WnoTcFWVOz4fcPZq555WkQRdIGuVZpMGj7t3s7PvjYUyCabtmprXEfpKaBau3KnAzSY8XcYOwspqhzhGMalA3Xvm5eZxbaXbS5zk5H+xeKIb+pzIfQ2RPJhhDBKAFBQGqzafpTTmYslpX645Sfu1qtySDfw0/qpp1i/pPoIsDBA2Rxx3FG0wAuykUeiwoKBek2T7ZTfyLWuohfMzf2VDMdnfjNuYYUozXi2PZxEBMi/01+QbzGb9zQlUhETC8fnNJOT9v0+MCe1UeJxFrg+wmns3zC4aTbEu4XYYPATY6HsijIpBMjy5wGkkbXXc6Iw1Hjxx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 13:29:06.4215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efd6b4bf-c140-46f3-6e56-08df037600de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729



On 8/26/2026 6:49 PM, Uros Bizjak wrote:
> [You don't often get email from ubizjak@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Wed, Aug 26, 2026 at 2:30 PM Dave Hansen <dave.hansen@intel.com> wrote:
>>
>> On 8/26/26 00:00, Sairaj Kodilkar wrote:
>>> Extend the existing user CMPXCHG helpers to support 16-byte operands on
>>> x86-64, using LOCK_PREFIX "cmpxchg16b".  This mirrors the existing
>>> __try_cmpxchg64_user_asm() / cmpxchg8b path provided for 32-bit kernels,
>>> where KVM needs an atomic compare-exchange wider than the generic
>>> cmpxchg helper can provide.
>>
>> Please take a good look at the Sashiko review:
>>
>> https://sashiko.dev/#/patchset/20260826070004.8100-2-sarunkod%40amd.com
>>
>> It looks like the "A" constraint isn't one that you can cleanly mirror
>> from cmpxchg8b => cmpxchg16b.
> 
> Actually, "+A" will work for 64bit targets, as long as the variable is
> 128-bit. The comment in asm.h applies to 64-bit values, where on
> 32-bit targets they fit in eax *and* edx, while on 64-bit targets, the
> 64-bit values fit into rax *or* rdx.
> 
> This is documented in GCC documentation:
> 
>      ‘A’
>           The ‘a’ and ‘d’ registers.  This class is used for
>           instructions that return double word results in the ‘ax:dx’
>           register pair.  Single word values will be allocated either in
>           ‘ax’ or ‘dx’.
> 
> And can be confirmed with e.g.:
> 
> __int128 val;
> 
> void foo (void)
> {
>   __int128 _v = val;
>   asm volatile ("" : "+A" (_v));
>   val = _v;
> }
> 
> which will fail compilation with -ffixed-rax or -ffixed-rdx.
> 
> That said, the approach with union of two 64-bit halves can lead to
> slightly better code, because the compiler splits the value earlier in
> the compilation pipeline.
> 
>> Uros, any chance you can give these a good once-over? This seems to be
>> just the kind of thing you've been fixing up lately. It would be nice to
>> get them right the first time.
> 
> Based on the above explanation, these *can* be copied from 32-bit asm
> patterns. Even "q" constraint will include all integer registers on
> 64-bit targets.

Yep, this is what I was trying to say in my reply to sashiko. Basically
+A can be safely used for 64 bit values on 32 bit machines and 128 bit
values on 64 bit machines.

Also if you prefer split one, I can do that as well.

Sairaj

> 
> Uros.

