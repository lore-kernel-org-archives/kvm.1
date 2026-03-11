Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA20D2652B0;
	Wed, 11 Mar 2026 04:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773202363; cv=fail; b=OYJlD/ifYQ5ZbtLWdLVYnPvISN/Vuav8UmOPZA1HC8/SA+LSzfgTwkiV3R/1YGjhv0cqRUlWGCNb6e9S6lk7zxydBJJB4JKVX0Hnvp97IclnXvg/Bjpq0LBFIVu9WJh0X/TDdZNZLuTOHGqbAj8+bVIDgLxuuCqAcaPXMZau7Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773202363; c=relaxed/simple;
	bh=hznfktvU/LQCOMfrxPADlleX4Iv+hDCr56NXc8Ywu1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ClQfa/K0XqAu+r9juoI3/ZMIlERMQ1gs3xnQEFOAEO4iWu/RCNtyOaNg063qFgPROyIC9SZ5ujwpDe0bkUWNNzXBOxPqUonC68RtkggiUczyvJXCFnW9t36VqOYPRv0c7dM1f99j2U0sDqkQb1i5l6PKmCPdJNB9yU6+pWPzyeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aEiKjCGT; arc=fail smtp.client-ip=52.101.56.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aEiKjCGT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+WXPShgtW2Ai7k8g6pbB5CZPZWoFOV59ASbOI63ncvZbljfQs2qdMUAFB8xXCyXWVfLMRr+AiJIzq+j7M9q2eniMIQXXAazyB4IC1U+MJaPQhclvnHiIyTXmzr5hhzQJOmJCGIyOF1PUqBuz0TuyZYCrHUq05A6yTf8Y47wTG7e2z3/lAsXNNiw9VTeqfL0X24GHQPr6V4q2ypDVbr+ysoh1o+m9G4Hkk+T8TRBmFtRXTmxrSaESdv+GySLLsHaJyNV5zBw06KnhJZysBEKC+w9KKLRUFwZY5BgCIUASYNXaBzcGhuvUTaPKKyvRMyPnOUovhmLAIWRB4r4MMEAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+76GbIle5Cf0+TO8A2qlXQcXRIp/F6a71rWU/d/zSk=;
 b=Rh5uzhL44VeIoubrH8oZjiISVMOGolntorDHEt3fbpe6dmw50NmVGNuyXK+ounR0rlruSZUK8Iks18UyQKYzNfJfqYgrlbqdWYjtm2ccGfzPkmn7XlwN3tb0cn7G2INzEEQDbZ2l5dg3CVFiIKBubdeVwoGdiEjADeDZFm9h0C3vVi6h0JVqHJGv5+MC+xvwTRBGP6rJuTu37Rxre69+dl1XJgF5zl/ScI3k+xu4PP6UiymGoczNOmVS7qdhWsQd3LLFRXOVTifgGwQ6Qtu54S560dtksSUoUxZZdaDxtU2mJ41h1RtFQrBuxwz1C30Qjhohqmjj94JhpdXmQ7sAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+76GbIle5Cf0+TO8A2qlXQcXRIp/F6a71rWU/d/zSk=;
 b=aEiKjCGTYWRW1L+jCnA+1eIecxsBG3q5dxAYKnLc2z4u9M8doc6faZsMm4fcu5XNQxbpV4k58cxNwSx7W6a4FH9H/nlGu19EouXiknHM1V7ubeoVw4m2ITtdO5T92tcsyb6IiEK6xWT2iDs7M6GeVYuHjbyyIq728Qdxa6pnq6Q=
Received: from DS7PR05CA0081.namprd05.prod.outlook.com (2603:10b6:8:57::6) by
 DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18; Wed, 11 Mar 2026 04:12:38 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::e1) by DS7PR05CA0081.outlook.office365.com
 (2603:10b6:8:57::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 04:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 04:12:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 23:12:37 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 21:12:37 -0700
Received: from [10.143.207.7] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 23:12:32 -0500
Message-ID: <68b25792-051e-4b11-8e53-ee81d90bb969@amd.com>
Date: Wed, 11 Mar 2026 09:42:30 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] KVM: SVM: Support FRED nested exception injection
To: Sean Christopherson <seanjc@google.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
CC: <pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <xin@zytor.com>, <nikunj.dadhania@amd.com>,
	<santosh.shukla@amd.com>
References: <20260129063653.3553076-1-shivansh.dhiman@amd.com>
 <20260129063653.3553076-6-shivansh.dhiman@amd.com>
 <aauIc-wOXr__Qn1u@google.com> <948e099c-ae1c-4586-8aa8-ff4946f47e18@amd.com>
 <abBE5GC0QhaoWDVb@google.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <abBE5GC0QhaoWDVb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a86a3fc-64e2-414a-526c-08de7f246e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|7416014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2KkWRJDEVqIWFl5jXNlW+ZorJOWz/vNJTWKAO8sw3EZyEfCBanBa4p7yRbzeaC40AAbj0Yosg5tQ+SYB/H3+mTj8qu2MrrmCJyD0IyWSYtaRp55g8UrFDaT2PoRr/j7wLz/pCHmNkcTluD//jGCeild45b21ilRUZ69OTyW/UEA97JA1T2q0xrSR/K3NwQ3kZeUZ1OcUvu5RfKro5Aj6Xr4Mh5lXHYOaSy6TzoP4QXJWrDSVEiU/yxtybtk0Z24UMdyxi7PbxwKai1T9igMAnyVHsCnJCMTZRLtlmnSyX7VbCHfvEjB/Pg9vnHGZbPY4Ul30wsAX0PDDY70IVqs3B+nNDBG0ASZmjcbOOz+9dk+2ITC2dbz+rc8xPnA80tuk5BPR8BTUeQvcD42KorhScIwzCM0TtkTwGbedNnAOTVm1a+ENnumFIZDvzN1hpnir9hfm6zDLvq/8AiojVRiFXOxLBuQTJ1uYVwQbP2c626Z+GE4QX5/VaDL/TsGOM66M5EwPVZDIWdrGkGAZDhDpztOWHTi18kv1BOb7JUlvi33RfDwhvpQAzzzBVo4Rnc1l8l2oryAG7XFMoIi/QQ18RUvV4GA9f2f46Iie9ArrYO+ApB97QiCDjw5CpouBI8JJY5qGt1B2Q8RUy1AJ0jB48hNsqzh26OCqRc1oyrtHvK223/HmLpzK94Cueh2y4oJCdgtzL+4mGyEY3Pp8ZOTlqqsKb9o/Cgmj+sYLRh8pk/HOIeEAUXcWDmXwwciuI4DOT7fpis3SZ7qFy//uAiyoLg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(7416014)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8YacC4hrEkbfVNgVB5Bh6lBdrROQ3i73dK/K89pMJjJdVe98Q94xh8QuwqC93Uwcv/gbzg+dyJZuFCaQ4o/57GTlGt1w0InJDx/lbrNV+Ajl3pyPOPN43ihfBdQY3xP6YKcNcAeWqTI0kOWBFr2WkhxPQ3YcGO8jlKZEgbjP/BWbOIpnxPA/RygPe0v/aokzQt51KiEO8BnNE1KnapvyXQyQscw8VLeYcsJIHT45dqVpkBk06aovAodd2KDPQQCoP30XViKweN2p9y+UMPFHFpLu/xoXc740jHr4zOwoAGj1PBYlm/ZQhiRjfwsNdE6+QqNhG6ttFk9ZX30xHlaw62YNR6SsP9iKM12m/juxLei+PoVeSL3P0styrLljnc9LM1Xmpis4V9h6rk0HUy+4fXy7SBvj5MlmqnEXpQjj31KgNG1HkfLG06S6Vz7MRDJI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 04:12:38.0661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a86a3fc-64e2-414a-526c-08de7f246e6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564



On 10-03-2026 21:50, Sean Christopherson wrote:
> On Tue, Mar 10, 2026, Shivansh Dhiman wrote:
>>
>> On 07-03-2026 07:37, Sean Christopherson wrote:
>>> On Thu, Jan 29, 2026, Shivansh Dhiman wrote:
>>>> @@ -363,6 +363,7 @@ static void svm_inject_exception(struct kvm_vcpu *vcpu)
>>>>  {
>>>>  	struct kvm_queued_exception *ex = &vcpu->arch.exception;
>>>>  	struct vcpu_svm *svm = to_svm(vcpu);
>>>> +	bool nested = is_fred_enabled(vcpu) && ex->nested;
>>>
>>> Reverse fir-tree please (swap this with the line above it).  Similar to my comment
>>> on the VMX series, us is_nested to avoid shadowing the global nested.
>>
>> Sure. Adding is_nested() helper should be a better choice. Will do that in v2.
> 
> Please don't add is_nested().  In KVM, "nested" means nested virtualization.
> I don't see any reason to add a wrapper, it's a single boolean.

Ah, I understand it now. Thanks for correcting.

- Shivansh
