Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795501546;
	b=vBSLBSVW06CD743LiQ0baZ09AzNBIrsNzuCgR6op5PFref9+Ra9rIZh4ZeVgL+NkNego
	 lMxjglqd11qGN6JgJbHeA0DP3AB7f9XGgapM6CZfiHZYAWiJIrzSD0Msh/esdpkqP+gF7
	 oybQ58vttSiGsLI88wsg5qqPw7VQQwE/gXpVYpaJkF0iIX+RTwUmvgPXMYuwhte5ev6fM
	 y0xABma5lCUbE0o1cIOuEmfuRAIuAx1M+BQXOYXcgiGPpz/bekN9sQbCtFSIaoagR3OM3
	 OjWJZYKw/dtB6nsuKPzcPA+mwz4EBIwWkPcbKAQyFRGTHodKBSWtM73ORyfM8b6gmPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795501546;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4jJX4/LDDDz9epcWOPp9tiP7S5HITTL17Uf5A7DbzqM=;
	b=Pa/xOMzHvYtuhnOPw3gy08sONM7XGEHdYq6jCPuAmRROY9fOdWix8lBdpI8xjUxzk7i5
	 nBCqtvmGxXPBwDsiualpFsDSBAT3ZL32h72dzH9/HoqJTZ0GbMFxKXdZRAP/3vUrBxbGM
	 O67mHGsp3lzOk0oF3Yo0TglXEvlIgJoBV+k2EtaJ2SvuMEt5AVMNefSqvfAu8L3e01mP6
	 zne2NvlgVErN1pAGA9GatfY4BXUn4waLQQ5WhemUAchm79gJkN0PL0AXkiWo7dgxV52ZZ
	 MlSvc74260iwPwYT/rhwEZ7szLnbJHgztQrjJnR5Cct/z8ymep2OFEYA2fq2rPpzKwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XQk8wyMG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.33
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD383606A321
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 06:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD383606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XQk8wyMG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqtsVVZ8lIcN9VhgBQIbJ4oA76gZRD1hZ7WOLFEygGgvKo+sQy5/C8xGBDBZhtj5WG341k11tOlKtKXLBsvlvickVf4crBvtatVjwSaUy6u6fFUExdYCnhMo48XEP/KqnQm+cy/1SFMxgJce5VzQcmlXufrZCbtZ3QqdCNSZHL+yMmKPNEhB8TFYxPSvoOoaOXfPDt+EXGyswN5U5Xf/UlA1dwxoVv3wehB+AOrF2eBqSV7ADHRh+d1JF70BVTb5saGszthbVMSDAhTD9/SLjWCAL6PJTRtYANdWvSxC4sbEmbhJxEFM4K+hvHch/xSNsxrZWZS+L9JWEkE3cWBLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jJX4/LDDDz9epcWOPp9tiP7S5HITTL17Uf5A7DbzqM=;
 b=LOsWQeF/BRkGpUnUmd2O5iSOlTWVnxMcLOXLLPaBsBXC7DTXhjhXbHDpRLL2UTaj2YqRnyFpjlGrMDeIeb1K/yJ6GbUxK3AirjvZm0nUQZPTO/NDyGnNnmmr1I3XuZ/jCY9ThSojLPU/8qIrYMgHwOCCRZsISGZTCoMKsTc+9zDRV1+RToN1Fxu7/tozr0p8Q2OXr7JMF5lzhJ57aAeQUxyrb2UY6dz22j1biBDLwP02mqTA8G0t2CWMHsgef5RTOKg7DqI2A/rqtPgiojGm4SIM0t1Ikl9UkQit0IMdkkCQngoGd8PrNtCkyPjwyBFPuxdb1YO+5AbKPZ9ojERDhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jJX4/LDDDz9epcWOPp9tiP7S5HITTL17Uf5A7DbzqM=;
 b=XQk8wyMG8C883LOB4bu55bpFqPBGrd8roWPtaLHmxlyOiuJI5HY5yIWVejI1RfbVKMiYcisUkVznhoGkesn8cfzy8X/x7VFQKUl1fixQENpzcPOcVEPWSjR4j86gi6WF/VnoQwdtKdcbaBlY5lpQUocTOmQhqvjSBYZcWvpViQk=
Received: from CH0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:610:76::11)
 by DM4PR12MB6615.namprd12.prod.outlook.com (2603:10b6:8:8d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.10; Tue, 24 Nov 2026 06:25:42 +0000
Received: from BN7PEPF000000AB.namprd05.prod.outlook.com
 (2603:10b6:610:76:cafe::97) by CH0PR04CA0006.outlook.office365.com
 (2603:10b6:610:76::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 06:25:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000AB.mail.protection.outlook.com (10.167.245.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 06:25:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 00:25:41 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 00:25:41 -0600
Received: from [10.136.18.146] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 24 Nov 2026 00:25:37 -0600
Message-ID: <e0c72f4b-53b9-409b-97d2-f95f006a6f32@amd.com>
Date: Tue, 24 Nov 2026 11:55:37 +0530
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] KVM: SVM: Advertise LbrExtV2 to userspace
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <peterz@infradead.org>, <acme@kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-8-shivansh.dhiman@amd.com>
 <CALMp9eQmOcq0Edb6Txfe1NPASbY=3u=NSkQrVAbtqtecr6WWqA@mail.gmail.com>
 <cc34f113-d67c-4c9d-875b-5f44ccc5c5ab@amd.com>
 <CALMp9eRs85yTG-wgtv2S+eVCwWt2SmjH4OAOPm5cQjQB8yv9tg@mail.gmail.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <CALMp9eRs85yTG-wgtv2S+eVCwWt2SmjH4OAOPm5cQjQB8yv9tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000AB:EE_|DM4PR12MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b491bd-5531-44b4-d2f3-08df49f3c3a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|7416014|376014|36860700016|18002099003|6133799003|22082099003|11063799006|56012099006|4143699003|261102123227099003|261026121527099003|261022105027099003|261022075727099003|261021121427099003|261026140227099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	TofyjBsYCt/GhVvlfhFGvTqubOH+4e1YaGp2fJVO/5KgGpzeSkj+Wj7Mkuhcic1v6Q/fFD9YhwjY7VycyfHYDn/h5RCpYX0ofX2/thwwcf5p2XSEQbtXH3LAAFo6d0l74Xg95n/7Wpp+RNy2dDumbvjlP2stQsQYij8wy3+DJuRbs0+aMvkU30gUwttR5ehjeIY0We0RMX/b0Q/MxJa56uv1YjvSmqFEeEXrlMZS3z2rvCkk+vgof6FU0ZoXQwVCX88S6x6rfPT1LW7dALLOi/n+MLzn7liWX6fAMAtTJO7AIVoGu9cx6+mulusucMx3KbUM5Gepjjxmd/tmQYGY+1sVBFbYUxlAB+DiCDj+9ot9Wv20xRqOCRB0lCWGUzzvAoyNGMfujCM1UzOp/21wKdZn7Fk6UxVJp5TX73jEXi1ps8Ly0+1OkMIDrIOjNHCKJFrYdiGRqNLoKEiPuEGpL1xpOKaZV7de77jUjKmbyLArfZ1ln6e0xDsCVsK90WsZRXjHx4aDU+AJnT9uGm4OcwT27LR2KENtQoHryMadsL0HyNoKGpIIoE87JTNB63r5g1I61RPZXVhS9fdEHcHmnqs7zXTzLGY8vx3jLwvddWrjj9SFARKXbO/Ys71BZUN2aCc6eAyC5G3tTPHBmBpykp2lNRsxbHceShAelL/IDnkwrqN5sX1raz3W9wiC1EI8EOhY9jar2gR8STTw8n8mfA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(7416014)(376014)(36860700016)(18002099003)(6133799003)(22082099003)(11063799006)(56012099006)(4143699003)(261102123227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dvEafmpmdHpLpNVRD/IiekpVWSncnHONBSvlxvf7KHe56kySiTxxq8XsSSc8bpjyTIQJdvyNzNFiH4ma+z7mFYADOWPmj0N2vyPynO0lMSDMac31d3gbmCpVv+Qof+OJ7TYqxC2HqqGf3I35Amr84QqvMJzY0D65FsAnRKQiOqZb726I/C0KKgk1bCb9Wiz0zbIzCIAi0eGEnSXxHxZ4zJMliqkS78yO+rMhf52S4ry4qhlU/ahLDLZ1slJFw54VQDMx9U1A9nSi4xDLvJPPg/Y9/UMLqX0u06jJWleP9G9cRegpT0ymo86RotIUaurUeHEyo72AleOPnyI1D1BAR6WvxpcLgiMRhbe5tmMU66/qh/eNAVepPPmvl8RpVKmd+PIcJk8TdSb8Bu9V/znuXLG0ge63AJz1Ut4QiIiTG+vcICIDy/b7RX/cXOH9vwZz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 06:25:41.7574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b491bd-5531-44b4-d2f3-08df49f3c3a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000AB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6615



On 20-11-26 03:28, Jim Mattson wrote:
> On Wed, Nov 4, 2026 at 10:42 PM Shivansh Dhiman <shivansh.dhiman@amd.com> wrote:
>> On 22-10-26 05:19, Jim Mattson wrote:
>>> On Mon, Oct 19, 2026 at 2:08 PM Shivansh Dhiman <shivansh.dhiman@amd.com> wrote:
>>>>
>>>> Now that LBRv2 is fully virtualized, advertise it and report the LBR
>>>> stack depth in CPUID. Gate the advertisement on LBR virtualization, the
>>>> mediated PMU, PerfMonV2 and a 16-entry host stack, so KVM never exposes a
>>>> configuration it cannot faithfully virtualize.
>>>>
>>>> Co-developed-by: Sandipan Das <sandipan.das@amd.com>
>>>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>>>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>>>> ---
>>>
>>> In addition to what Sashiko said, I think this needs to come after
>>> patch 08/12. Ortherwise, we can hit the KVM_BUG_ON(is_sev_es_guest) in
>>> __svm_disable_lbrv().
>>
>> Makes sense. In next version, I will put this patch after the SEV-ES
>> patch. Thanks.
> 
> Please put it after the nSVM patches (09/12 and 10/12) as well, so
> that KVM doesn't advertise LbrExtV2 to userspace before nested support
> is in place.

Ack. Will do.

-Shivansh
