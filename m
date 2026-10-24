Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792851237;
	b=c0qlHdxlUvbwzrXusPNGuj6plcT9aae6ZhTw8o9HJaMR+Qz30QpkvOsIzKV0978yqhO3
	 1u5RnEjWgjfj4kzeg2KQBbzhNVLyyNGgJ5fLqtTeLBEyBdp9IUzieUGRRqplAVjH3l0pG
	 +VE8NgL6zqzyU/cXcKaBmhp6WOa8HSt6ciGWcfkSsBHhLOB42dBDKIuV817bSN//J5MDk
	 WQ91MVDNDzM+/bMSnFCl7zCtV9Ni2OZANrxADyHDRMjWSvP2dZunAm58UHRCQPRReV5ML
	 Cx7UAHct58v6LuuE4NfbbNKNNwN7YbQUFKoFfhhTixiISO6c6jvzUcCKvKCZ5t4WqiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851237;
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
	bh=WETvM4XgvEH9H1z2IswGX570YSIkvo3XsB9Z+m0Q4E8=;
	b=ThRsrgp6iEsik9MM97J35VP+3UzrUu4J/WQkykqU0P1b2NMfVVXkfujXMQNdHBhTdLkk
	 PPJpyxz+3pKXMnjGciAIp5qfe96wYyG7vRI73bPxy2kWyQmJScAOm0cddw0JkUSdj4VFi
	 ZMu9Dm5qLDIUO1sGZKuNIrfCXWTdIrTh8xZt0RgxPBqKtERbBVBi4V3JEqAw5zXZt06Ml
	 IMGqlc1uDSbvlWyGX2pIPkxRNmv5n4hu7H8NkaEQ7Wdav2AIwEXqNHyRstw08AfhIy6gn
	 erI9Y0F8kyk1eRPov8ZIHz+IfofcIrqeNEtmsIa6lnmxMyHWbmAbmSFrDpua/29Q0QA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=P3aPtiqa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.17
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013017.outbound.protection.outlook.com [40.93.201.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E364606A32C
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 14:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E364606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=P3aPtiqa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yd/yT94B/GXPKfwbUV6spypMFPclQpMwuXM/R4N+0Fi5tlaUmuC/ibeEC0VK8EpFCd9XPvNIwGjeIcdd4jzObz5VJdL9mWJpLrPP3vKM1TK7OSnn7G5V0P49xKYxZzw6HJ8yZ2EbWVOcLPDe3HzwEmS0MWtfMIEtrDOatDUMWrdUiZIxklvH1+SG0Ih22p3yDgnhvM/gUC6PRRshTCIOE3hkns3xf9fLncKjhGWznqYxUmV0ZUouB048S8XeqgIjSz4uX2HIgdkHg4dLgH5bnstkGtlTRxIS9xzBqj9ulbpPXYW4RXH0//xTJjoN3AxB0s67w7fimO8qJv2OHQiQoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WETvM4XgvEH9H1z2IswGX570YSIkvo3XsB9Z+m0Q4E8=;
 b=d8Ubf+VSvr1alDdXW1tQoNKNzkRZ0v9EIuY6H5TEkLSpXsR6T3rofVE+zK5Ojpn918+v1DfNheE3+2vbpQUJagsM1vxJ0KXpueCiLWvX5AWlx9xyaweQrC1sYuDFdhLPoPKcI6enSrTxbNwi72OXxtgDfdsuDtuqp+t1Z4durHVfFZpIH7fzJvWKShGU9MfedxBkmjtfRMDr+hQAkT4VpeOTZ8eBHLlz7dDukgepApvFhixURUmrBtgkl53pbQqmRMMo61nhcWutsA7a8KqQaZmYAHBhmc5ZbqXPwL7t/Lm4YtKq7g1ifD0IQhF1IrckyQiK/TaEzkXZJMDLcFP2yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WETvM4XgvEH9H1z2IswGX570YSIkvo3XsB9Z+m0Q4E8=;
 b=P3aPtiqa00AGDWFiTts4LNW88/cLL3Nm2BW8pAlVx6eML3ER/c/r+MbUDycsXrfF7DUk42bdPzhIpoU69CkQX480vdn92J0ClcKGM//6BhiKChVuDlDTTcfyHWdGMhosqmn9vD7wAagRmCAtxMt1RkjIkfpPsWdoAji/KuXsg/8=
Received: from PH0PR07CA0042.namprd07.prod.outlook.com (2603:10b6:510:e::17)
 by CH1PPF16C2BD7B0.namprd12.prod.outlook.com (2603:10b6:61f:fc00::607) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Sat, 24 Oct
 2026 14:13:51 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::a0) by PH0PR07CA0042.outlook.office365.com
 (2603:10b6:510:e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.21 via Frontend Transport; Sat,
 24 Oct 2026 14:13:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Sat, 24 Oct 2026 14:13:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 24 Oct
 2026 09:13:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 24 Oct
 2026 09:13:50 -0500
Received: from [192.168.1.2] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sat, 24 Oct 2026 09:13:46 -0500
Message-ID: <ac4d5a91-a3c9-4aba-92cf-5487dc264443@amd.com>
Date: Sat, 24 Oct 2026 19:43:45 +0530
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
Subject: Re: [PATCH v2 01/12] KVM: SVM: Add VMCB fields for LBRv2
 virtualization
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <peterz@infradead.org>, <acme@kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-2-shivansh.dhiman@amd.com>
 <CALMp9eTXz6vD9iUN0mXPjwbxK_ZnocL+BwS3qbphSUFXzmeiaw@mail.gmail.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <CALMp9eTXz6vD9iUN0mXPjwbxK_ZnocL+BwS3qbphSUFXzmeiaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|CH1PPF16C2BD7B0:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fa64c8-3263-4b90-4166-08df31d9076d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|7416014|376014|1800799024|10067099003|22082099003|18002099003|13003099007|56012099006|11063799006|4143699003|261009223027099003|261021121427099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	UWB0lvoiVfaTpSf6idrXbI1/bcKRQlr97HNDCtxeqS3lSS8cetU4UIVKL8mpscNYitrXUPCt0D7P81oeUa1Kfbm27hWI4iGn6jKfwlJ8bH0qTWBc05Te5R/mKVSvnBvLlqAN9xVbp+r9Ne//yPNxQ1MHX/Fx3AwaVQjnU7pX40q1ps4LCfi5gQDCskze7APQUxg51hDc+se8MVeo5Cx8QWgg2Aqt1Px0V6Nzrq5/H5C1OtlbIbnJmu7KfR303hHjjHVfdH9gQL7XD4w/1AcHKCkYDg8DOnattAOUT5BcpewP9FFEFgQNresQZgQd1sYJkBa+tucxwAgyjhEaNFLvxQ7MuI7gP8NDgumFxgWaTJrbtLd7t0vTHvYzNBQ6OUH0UET1JJJAbMXGOe9oUqQ7FURvC0Z42OHWP2qfWHQkR2j+4suy0dBmH/PiGmNIVPIeFPYHunISUL+E8DXULbBo/J9WmGZuEJ+KcNkW3Sc6Yo7M2MvWfjleTi7h4rlqMrok5gMvWaWWSagChqYx9USDDd/F5z5Th86QbQdR5qL9SijEYkP5bxocMHZLbezSTbdc3OwHJy6oOcr1/LchiaHs8Pm5gtGRGFV9oY67jQK4mM0F7OMiP4oJz2Y+pByIieeLM08yJU0DkVFHFa7294EbAs8YETD/whzew9tMK0UF1C8in8YQ0vmZ7robWlMU8MPlkAzg2RQ6MklhdRrBYSF9lA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(7416014)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(13003099007)(56012099006)(11063799006)(4143699003)(261009223027099003)(261021121427099003)(261022105027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sPNVQbw6noVjWa5juSMU0qxttMdwQJYhLt4nprvUpdTq7obvZk25Kv/ryqHHRh3/9k7ALAdfwpkmUbVCXDR+RdS+DVJpefTVKt1w2gmip3oiASph7fo+oz26mlh8mibMBR4924KBhZH3kI8vyOCWRmRkGD7KjTIHgzrg/fE7Sa/ig3Ah5RJiRZYtY0i6en8UxQlbL2tZlTzqPUwYcNQpTvnRfcbB724d1MrCQGmK96pF/wmGXu3dV5G79qbpevjRsWCoFsJz9UTpUQ/Eu3exbAzhV/PiwiEmsiX43twd9CbkVO2xNcfDPi0fQ4XWCH5g4u9RD5MW3M0L+1DNzun8KJKfentf5f3AYcurhUGd6gvoRp0AMutAQ5/+T4ERirdsPUduAXfOg4Kte08Zqi3Xncr0YNnh6esPdM+UzPhnjtpDYTYbv67CyYgnpevs0D55
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 14:13:51.0898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fa64c8-3263-4b90-4166-08df31d9076d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF16C2BD7B0



On 20-10-26 03:39, Jim Mattson wrote:
> [You don't often get email from jmattson@google.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Mon, Oct 19, 2026 at 2:06 PM Shivansh Dhiman <shivansh.dhiman@amd.com> wrote:
>>
>> From: Sandipan Das <sandipan.das@amd.com>
>>
>> Define the new VMCB fields that will be used to save and restore the
>> state of the following Last Branch Record Extension Version 2 (LbrExtV2)
>> related MSRs.
>>   * Last Branch Stack Select (MSR 0xc000010e)
>>   * Debug Extension Control (MSR 0xc000010f)
>>   * LBRv2 Branch FROM (MSRs 0xc0010300..0xc001031e)
>>   * LBRv2 Branch To (MSRs 0xc0010301..0xc001031f)
>>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>> ---
>>  arch/x86/include/asm/svm.h | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
>> index 83fd49b26a4b..d76844224745 100644
>> --- a/arch/x86/include/asm/svm.h
>> +++ b/arch/x86/include/asm/svm.h
>> @@ -372,8 +372,15 @@ struct vmcb_save_area {
>>         u64 br_to;
>>         u64 last_excp_from;
>>         u64 last_excp_to;
>> -       u8 reserved_0x298[72];
>> +       u64 dbg_extn_cfg;
>> +       u8 reserved_0x2a0[64];
>>         u64 spec_ctrl;          /* Guest version of SPEC_CTRL at 0x2E0 */
>> +       u8 reserved_0x2e8[904];
>> +       struct {
>> +               u64 lbr_stack_from;
>> +               u64 lbr_stack_to;
>> +       } __packed lbr[16];
> 
> Nit: instead of '16', can we hoist the definition of
> SVM_LBR_V2_STACK_SIZE from patch 3 and use that here?

That's a good idea. will do that in next version.

> 
> Reviewed-by: Jim Mattson <jmattson@google.com>

Thanks for reviewing. :)

