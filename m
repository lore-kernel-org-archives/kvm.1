Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B1E63B9
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 06:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923922; cv=fail; b=ifZUmFHuiNkMUBjlozFufqY3S2dAisNWMgIkQ14kdgpkXMFcl1PxQ3F4HMLZtac3m9/5ttvBDW05wx1ilaLhaW4VVcBRelaLE4JyCFgB95n5l6c4ZJji5ow650tiIS0Ll+P39VMeg265opuVOOQOtDD+4kN5hNYQEJ8VjRvDYDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923922; c=relaxed/simple;
	bh=ZwV1lFLyYSvvrryJdqusG3cfJ+7bUKwZ7WLrQlANMqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N5jwPKuSGNsgDM/zJBHIvDs0//48N5ZqbIeI0Ow7Kfe+PnAvwSdPr86ZwS8fHkds6Tf3EzQCKRJtXi5q/enNEaj64eTe/zfTBt0v6MrCkYZVq3hT8/92GaZoigWBTvgA35eShJGuqagVu7v6db5VyCeDbpgUZmwSRbpqbwuHn10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g6Y/WIKq; arc=fail smtp.client-ip=40.93.196.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g6Y/WIKq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJe4WswHbZi5s5OxdwwfRhw63JLIMG6/X7Tkj6T9Omi2mSdg2oOZDoyMMUTAG9PsTw0KXOYJ+21KF4kus0t3HfJioJhnic8N1ahExVG8LOgYzgfZPO+EPK9NVUNq4wes13akb3gqxl4eaVdeIT/WnOscfNl7wrKvQwZDRLmZFbdGmNafc/HRR0dK98I8YCJCX9I2ezC8jcEBcKlYq1S1X0XEdBiLhrIWBELDbZsruo4/w7CEEaFLyNKgQHRZ6Kq9jY+R+BSZBgh0ViVfWh+MdMEGRAoA8iSFM11HDuhRdgIYwLny77k5WIy2S9wQ03pk/TeqzVqvwnuBosmsYNWFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M+XjQ+lb3UZBO/rT/pvXRZ+sv5bMOJX2QT5e730J3w=;
 b=Qd31ZL9rrgSwyY8t+6Wot17RpS3eauucuFTDvDAVX+cMVrxFSvFhSE4WjO3mpQLXbyy1FXiOUwBf0nbgIUnr4Z5BH2rURsLeWQvnSezlcWu7cWBSG639SRmFVnnumjiwrSId9p3e1ynOL6P3qGTD8vtQe8toTDTzP3qTs0MBNHCwiOnraI3m6DkLaPhsDXfls3f6SdsOMi0T05PMf4FM2EyV923lVWoJFdmmtFH7AaUfqX1g097ns5TilTXluJSP+P2UlN3xQzTU1VzRvA3NKg4nuNLrvv/c+yCj338p4uj1hGXTOxLPxu6jB1FlUnBHlkQklMBTGmzMa85CoSpm0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M+XjQ+lb3UZBO/rT/pvXRZ+sv5bMOJX2QT5e730J3w=;
 b=g6Y/WIKqbDUXkSFG7A0FsTynl8Qi/FrVTMao/BRaVwa5A0g8kBMDYj4gBZaNhB0ARdY9hatQ/fZEMAfNkCb+bzHUqA2s3dSuOOy+lzgljzOW9K4j7Auak6No9nXWFV8Slvlwaqrk6zvXB9lpLdHvpF6RwbId8OyzHSepPQ4sI7c=
Received: from BLAPR03CA0130.namprd03.prod.outlook.com (2603:10b6:208:32e::15)
 by SN7PR12MB7810.namprd12.prod.outlook.com (2603:10b6:806:34c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 06:25:17 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::9) by BLAPR03CA0130.outlook.office365.com
 (2603:10b6:208:32e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 06:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 06:25:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 01:25:17 -0500
Received: from [10.136.45.190] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 01:25:13 -0500
Message-ID: <eb51c52e-5b58-46df-9b60-0054851a38cd@amd.com>
Date: Mon, 13 Jul 2026 11:55:12 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] KVM: SVM: Refactor svm_update_lbrv()
To: Yosry Ahmed <yosry@kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<yosry.ahmed@linux.dev>, <jmattson@google.com>, <thomas.lendacky@amd.com>,
	<nikunj.dadhania@amd.com>, <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
 <20260709082953.69434-2-shivansh.dhiman@amd.com>
 <CAO9r8zOE6m-G8fmNSTnCcvXpzYvR8Egx3PkM2uSaJcZj8PVLqA@mail.gmail.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <CAO9r8zOE6m-G8fmNSTnCcvXpzYvR8Egx3PkM2uSaJcZj8PVLqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SN7PR12MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d24b9e-19f1-4c6b-480c-08dee0a781e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	xY4sSrTeibuPSTuSd3nVb1bQQoFquYDx860bxtvm2/8uhhF8S7pPXoVpol24RkypkJLU0D04eUYKU2Dnl470yXoIAYHx+6qxkRxfsx1tqADrQaYjv/GJ2QJ/9B5Cs+KJ42mnweYxuvml7IylGCwIwDWMb8sVf6lLBd7O5EKel0BIxJ5auRsStWLwebp/hE59lzHoBuZAo/GxYR6b+/Lzj9+uAStd82/v4kLroANgcYkRX01KrjbjemGo2tUDaAcFk0MDmjfDGgKF5bEWGe7UuC3bTSkf4wBuJEIUuznVJKR23OQElZGx2p7kSApl77iCMwQ4WD7fBpQNHIlb/XAXS2R0C+Uqaa3sig2B2KABvhUzUo9BzXPtb7COOt6vGJPoQLleSaMu5hRHP0scresx8wBLbfguO5xDk6XPv1kvKB55Wh8UXVd9PX506MoWohylmxLxiY7DheuIxqDjOJXDRy5C+Lm2mlquQetiJt1lgXNLXEqJsGkjodflX8ZSb53JnJQ1SWnakWzMfFrh9kp5/4Wc+FblY3TZBtpPHDwY/Zq0FM9xXygrxX3i7fRvPhTnHVF2Ce9tB2quH36WUdLS+JALRdPXYK01u7Pac2648umDLV8wswjPUhlx1eb+R2pnE2jtpn2ux2A4AzMhy4EsAVKpOXdfHLyzQ4IDoTcuhHq6GEsflchn+YKkeprfQZUVuxy0rVr1+7QK8ZYqLBcXGA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7YZgpMmpyJ4NMSVNwdz/oQpmH6TjCfXlbIEbex3+6fzVkf87Bun4oxGQyP3zlSIqCMy55ZLQBGjho1hR06NWXV6sEJ9n1KfICTK1b1/prv5y9KpEYEyPb271z3saeO9xi8SoaD83PmcxCCgkD26NDkychATtmhCE4ad9q6o5rm92JBHrE9/bHF5YboOaD1YDL9vWMd2cxymJd7jDmWzVRsUHhY7WYF4zZoIuQcd6iefZ0RJj2MzSTiIV2qkqgsfXYTfmB6gXgqPcebB8wsEbkYfQFuHcoj42arLUvZYBTsnnSYj1JT4oVzDThDuZvkmnJ4T9N6Za/i3h09nDi2EAeVVTee65CjZF9pQnQioCHP1BvLcDFC+zN5Cx5MXdsp8vkq3Ugvf9gm5iSsuPizH9TY4A9hhZhqS8tRBIGwVJsZXvoTTjOZOjy+1+u4yze9me
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 06:25:17.6131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d24b9e-19f1-4c6b-480c-08dee0a781e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7810



On 10-07-26 01:23, Yosry Ahmed wrote:
> On Thu, Jul 9, 2026 at 1:31 AM Shivansh Dhiman <shivansh.dhiman@amd.com> wrote:
>>
>> Rewrite the enable_lbrv computation in svm_update_lbrv() as a series of
>> 'if' statements, and use nested_vmcb12_has_lbrv() instead of open-coding
>> the nested LBRV check.
>>
>> No functional change intended.
>>
>> Suggested-by: Yosry Ahmed <yosry@kernel.org>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>> ---
>> Changelog:
>> v3:
>>  * New patch.
>>  * Refactor the enable_lbrv computation into 'if' statements (Yosry Ahmed).
>>
>> ---
>>  arch/x86/kvm/svm/nested.c |  2 +-
>>  arch/x86/kvm/svm/svm.c    | 10 +++++++---
>>  arch/x86/kvm/svm/svm.h    |  1 +
>>  3 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index c1485c3e691c..d3df6b22bfef 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
>> @@ -736,7 +736,7 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
>>         return 0;
>>  }
>>
>> -static bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
>> +bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
> 
> We might wanna rename this function now that we are exposing it
> outside of nested.c, but otherwise this looks good to me:

Agreed, will rename it to nested_lbrv_enabled() in v4.

> 
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>

Thanks for the review!

> 
>>  {
>>         return guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
>>                 (to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
