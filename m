Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A220270EC3
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 05:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513724; cv=fail; b=KlXtc1Qd/32FphuIMTl2P+dVO7CrsnVBaJh+OC6t7MGEUrINw6zm/FDuDPt4/E0WBWRrpCQjVvlRXay69mdIEV2mMhxbDPglISW3DMSTzt3A+FI1X4WweHfWKx8xRmobHcCFydMU4MqWgshuW50oTBgBnXItyorlzLbcnw0VvdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513724; c=relaxed/simple;
	bh=NRe+fvF2vu3mneCd9BLilZQxEytE9+44FjOZHNfIlwU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VZCYZglxtqSQwDCYRX44uudqpYRcY28GIYxnjIrMqPi86J/nyKk5TUSKiR7VF+HRPOh+ryVd1AlFBvbIJV9YsXx6h1OFpapWj3l4u5v/FgfVSpGGO1m/2NNUhW30wqtJl+HPKf6ot2KAP6pbgdM7ulzQKGnh264oZq5vbCV7qY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tx9bal/T; arc=fail smtp.client-ip=40.93.194.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tx9bal/T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJzUhzsQrmibJdrGIofb5rPh7IBeqSNJVSt4POfD1Lj2xJp0fjgwLfrAOtsfvdaVTIyE3sT7aD1huiO9nWK0+YtFMzMnxJIAzRCDQ8eHUs6DNklAJNBXVFt+pytJOKzUAi8q2Y3q5GbQw3PE/y6M+G/nptLW4AAG6rD9TrX43kMUFavzvC2mfWM6v245aiUHAjqoFsUkCGFoOitROSRhcHFsqgEnejg55/zcArsVslC/E15gqk6yk3c8Vfq8TMwwezFb5YKT+l0gw1bjjlnLJCbO72IwELVuXJZEBqzDuM30VWNhKuJ/sg3/5+zGM2LoR9neDLJtOypdfz4xysyELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaPxlztw6GzFuf1mjagVRpaf2mNaO9weCCwhmujzoMA=;
 b=JogSwU4xbCZ47aQQr5rLWC23UH0a2v1zhTNp+l5uG1YP/TgY1Pg899X5lXQDocFswk8XREaVtNK9yRWLLt5Zh1XXy+GUC1fUmqFAwaWeGToVYYFVxns7oPpmk2rTmGrUgRI69m/qfKu24bbx7RLv/OBWpGRu8nifFufUyGq7+s4Rsh57Qa/l97Q1CrlyEWRwNns7xP6HPHrWg+VNavRdUCc+kgjeW6cWQPVgoloI2fA1b/JCSSPh1dIAuI8psmJQhfw/OO6K+gDclKdNZBkIUiQ1fEkEb5s7Q4AuVbkY++ky0fe3sDocyqGb3eBu9MK2y60Uglgiz7NN6BEVF25p1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaPxlztw6GzFuf1mjagVRpaf2mNaO9weCCwhmujzoMA=;
 b=Tx9bal/TF67n3rMtbFLEV2ulIWj1hN6khUBxtKlclxd+jqJ4ciRTy/vw/bWwQzFTQ+toPUtvuKIcmNL/jst6ItGvJ9honwYHh45BR7so9E54T5Z+NTEXDAMN2+u5YUg9OgoDdpluKr6kz9XQoCPzqUVMJGSRPZpbvNAXQ2TkC88=
Received: from SJ0PR13CA0036.namprd13.prod.outlook.com (2603:10b6:a03:2c2::11)
 by PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 05:48:37 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::4e) by SJ0PR13CA0036.outlook.office365.com
 (2603:10b6:a03:2c2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Wed,
 12 Aug 2026 05:48:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 05:48:32 +0000
Received: from [10.252.200.247] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 00:48:30 -0500
Message-ID: <09aaceca-c01b-41d9-9f87-4ee6a3a4800e@amd.com>
Date: Wed, 12 Aug 2026 11:18:27 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <sashiko-reviews@lists.linux.dev>,
	<kvm@vger.kernel.org>
Subject: Re: [RFC PATCH v3 5/6] KVM: SVM: Add support for AMD IOMMU Guest APIC
 Physical Processor Interrupt (GAPPI)
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
References: <20260713105033.15405-1-sarunkod@amd.com>
 <20260713105033.15405-6-sarunkod@amd.com>
 <20260713111119.EC35E1F000E9@smtp.kernel.org>
 <6adaf312-84ff-4fea-b072-61588fd73b40@amd.com> <anpvbdzUIE_JtVoL@google.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <anpvbdzUIE_JtVoL@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c436d32-b334-4ae2-b54e-08def8355819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|22082099003|11063799006|56012099006|6133799003|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	9fpJHwqawXND6WKcw457Ots/CNyMVwlmLOvlYm4eSKZwxGtt98NNp/N5ZwpCXToT4NCJRZWlstS8T+CTuDohJehxP3488GKnH3EJM8t1e309+sFx+97ctaDgWbI1LiM7XWbsfbBwGBEqw9bxPhnvMpiPGl9/jD/PrJH8FI2t3cyS6f5u2SSe3LPhN9OfDo/el8FsywHNfjtX6y17s1vin2r8QqRkOO37hzvkpd76UABrAwXLFFJatOaJ5RSNki7BrkVP7L8UWeOh08GpKmbWyi/LRPQIWJmwMNeZYPNbeF7lq5YD13VerlXMnn/I3nU0PxYQLJbgqBcHQ7jnD6AqlrTxZaabLu0oIaCmBXGQtaUhV81uQ2w9nFr0GBAjHUjzeyG2yNGXCYpOSyKLqZclXF46uxAfPtXENA7wvBIOxGsYl0pJIy1HPC3rnugkYM4rRsb80yHa1qYOCUjnK14ZSLajr8SfrWXuwEnaVj8byk24Zq05NxIcHXf0SU1An0xdhZeXV3fx6TMojyUvREufMEIoLOojDsZHL8Hld2KcIqfubM9XR03I8F5j9xIYz+Iv2Ga4kAiyOEj34mTEeh5QPreE6IJWnXYhjdlYR2T3BEKwQIRzTQcOGY369/NX7/ygiOjCB9w8fDahdnBlGPcccJFA47pTMSGf95DkfoyDYveH3B0wKZy+w8+UF05rcv2ziThAe+TJQ3sIc63IV0++1w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9OXdqJfZK0YVylaC4GEF9Vo2sOxQSi8r5hzo+lbGMc6Sk5FCTwd9dVCpixfT3DR5JICzDrKOYZt9crMfPyk9qaT/BcvPAOnnV9Dkmsr7GhtehnfaINgt7k+8RPDPuhf0jCXhy15aSDySjsmQdTBdfoYLZ2JuKYqvhdIECwNqucDKfJ0BCOpqycPgsiFJ9j9GIgdZJiEQl1+pqgc6hQ6Vuc6gx3mF5wsQIrPuWMuMeEVU7xq31vvTBkmu22uVyM4CogXY+axRSBMCjka8P10iV+AdHBHghOZ49s+2Asspi7/ZhePOEke3CKKnaMuUKQ4FMuXsIztfrNL5We6XdHcsxb1SbX9j2jC3TYDMp6zZ179B0nMqW0lWzqO/rmh/cTZ5W+mGZuCDOonC1uhb3GgQYt6vdDdkmIHgJ3+GLr+5xr1FLcen5p/9r6JVRJgw9b10
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 05:48:32.6877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c436d32-b334-4ae2-b54e-08def8355819
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974



On 8/11/2026 6:10 AM, Sean Christopherson wrote:
> On Mon, Jul 13, 2026, Sairaj Kodilkar wrote:
>> On 7/13/2026 4:41 PM, sashiko-bot@kernel.org wrote:
>>> [Severity: High]
>>> Does this lock ordering create an ABBA deadlock?
>>>
>>> When a vCPU is preempted, the scheduler executes kvm_sched_out() while holding
>>> the runqueue lock (rq_lock). KVM then calls __avic_vcpu_put(), which in turn
>>> calls avic_add_vcpu_to_gappi_wakeup_list(). This acquires the
>>> gappi_vcpu_wakeup_list_lock, establishing an ordering of rq_lock ->
>>> gappi_vcpu_wakeup_list_lock.
>>>
>>> Conversely, when a GAPPI interrupt arrives, avic_gappi_wakeup_handler()
>>> acquires gappi_vcpu_wakeup_list_lock and calls kvm_vcpu_wake_up(). The wakeup
>>> path then attempts to acquire the target task's runqueue lock, establishing
>>> the reverse order: gappi_vcpu_wakeup_list_lock -> rq_lock.
>>>
>>> This inversion will likely trigger a lockdep ABBA deadlock splat and violates
>>> the scheduler locking hierarchy.
>>
>> For this condition to exist, Following two conditions must be true.
>> 1. avic_vcpu_put() and gappi interrupt handler() must be on same
>> physical CPU.
>> 2. GAPPI must preempt the __avic_vcpu_put() once it has acquired
>> gappi_vcpu_wakeup_list_lock().
>>
>> The second condition is not possible since __avic_vcpu_put() disables
>> the interrupt while aquiring the ir_list lock.
>>
>> Hence ABBA deadlock is not possible
> 
> I wouldn't be surprised if you need to tell lockdep that, e.g. see commit
> c0b8dcabb2cd ("KVM: VMX: Use separate subclasses for PI wakeup lock to squash
> false positive").

Will do this in next version.

Thanks
Sairaj
