Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41113CA92
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 05:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338429; cv=fail; b=jvfJHGVTpJhxUV45w4y9aqYEI+JrqMTjz5tu+mskpv1KBlLMkc9cEfycj7hcIgNgXTmegrX/NJdUApaIXICkTdUOO0B74SQgNgNv3sXY5c1jrEePQeQP2gK4Q5fsgO5tXGvVXqxM2kLdkOeonHFjoemrOiU8O5X0f6zWnALOp7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338429; c=relaxed/simple;
	bh=tyUCARY7Aa4CpHP5qnlHygJDAPl4TIm5uZ7bDNIxx/o=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VXJ8yFkoFZd3JhDYTv486s0278bOe9wTO9W/3/oU1Kh9mZXazXz0vW4CzplssW2DepgKHf0ld3eRVSI5M0DvArn/H8GGUMUWUXXKxZET8wm4qn5ZzBp9MYTM6fhQmfQ0ZC5411ZoRQR1fTgF6jsKcDaRviLozDCQEDI0GRPN8HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hn5hnDAW; arc=fail smtp.client-ip=52.101.85.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hn5hnDAW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbC6fKnAQvOV917Yn3RKicbVEaAvZgPAft+uYbueCH12r47zBs8Pc9J6CvomAGJ3qCH1oUHNWTvSrhMgGdgUGMPvGwdsdra6hrljGq25+q0rKOMo0mKbYXReqe4B+UOSRkzTmz+sa0C+K49e9DKjE2l8aKFNPkRO96s5OINMdrpPNfkE7O9WgjgQbfrXWlhIEgjnMLh7a6WAeuE+cGUx+yER7iGbmMRIAmHqrd5MwPv6ayG7KUiJhhxvvB+hn5yYj6Oc6sasVqZ5wtJ3zdmKJA+TYFi86Bqm3Y0w6UCpUa+kctbCah5zChXcrun7pk5074jkUX3e5dQjGg3VT/SB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRT/FMWkdmp1+4+lHhLRS1tBWPKE+13jVZCKh6dwLU0=;
 b=oQgg9YLbpGZE+v2O9AdVf1d80mScNuRCpidcsxIsizckmCsIIRqn88+skxB+O8XABJqLrr1bNsYntzF2MRDCO8wxjD6F6TDjnmb2FKCbRBYzOr0kpou+MiC+8HWCscQTErmjyRL4GeelhT5RtK7JC2zfh+eYosGNFrcVXcDrkQlcF8RClyD/ABHT/D7vey7Vvhft5mN4Tar0BM3qS8fLbKbfJn4mPcOq/vXfg3uUX5G8gWcu7xxDS49TuWJTB9fqFuVKTPZfX16xifcU0YHmN2kq6osZYvJN4zvyuRB1xvyiSpxQGMySjyOLQCyWXcv2Dpm6V3alh8ZHtl1j56tksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRT/FMWkdmp1+4+lHhLRS1tBWPKE+13jVZCKh6dwLU0=;
 b=hn5hnDAWhZVMqRIA+laP5o0Csq2oBIAjhshUcN7J3DAg7CiZTpuWiOhsOichi1XlgASG9lVwUtFTbhSMQ7mSlYhvwsnMWeOAnfNlFmjZ+C16Y9Fa2qPGZ5629Dc0UEqq93aeO4eJhfkg0gCqx1NoIKvNz6dDhUjkcMMYRWdLyt4=
Received: from SJ0PR03CA0213.namprd03.prod.outlook.com (2603:10b6:a03:39f::8)
 by PH8PR12MB7206.namprd12.prod.outlook.com (2603:10b6:510:226::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 05:07:03 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::4a) by SJ0PR03CA0213.outlook.office365.com
 (2603:10b6:a03:39f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 05:07:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 05:07:02 +0000
Received: from [10.252.200.247] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 00:07:01 -0500
Message-ID: <6a742247-ad0d-41b2-8bef-19ed342ec57a@amd.com>
Date: Mon, 10 Aug 2026 10:36:53 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH v3 3/6] iommu/amd: KVM: SVM: Add explicit vCPU running
 state to IOMMU interface
To: <sashiko-reviews@lists.linux.dev>
References: <20260713105033.15405-1-sarunkod@amd.com>
 <20260713105033.15405-4-sarunkod@amd.com>
 <20260713110858.EAEF31F000E9@smtp.kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
Content-Language: en-US
In-Reply-To: <20260713110858.EAEF31F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|PH8PR12MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: e369e38e-49c6-4e0b-9170-08def69d3729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5brMQslWrHAj90PRdE5MlQpYp2dDyDsKFQ+DGRmHb+/0nI7eIxl4oUMHS3zLXjO56UEo3n4RqamnwSZytdBWtWSE44yfFXemUeGzir+3V01Kwg8z8aKdZsec8BFlXtBUfkUpORKUKGUYEhmbPb0maghmtiM5TkhA19TQ74CWZc/eTZ12ATZ4uGJgCQ5e2czpVrxZcO5wuEdeWdKzeDyJt7WB1P4TSyH6E+irJO/O+UfNSmIZlc/bCuyiv8BgPb/0Z0dz1CiTT1f56g9j4hicOQxZRlCNGHhhdta1gl7zlpWzPF/HBgUt+Smi1pysCN0KJeMlEm9PvUpVSnK6gDUSb6me+uP6dFya+h0Zo0NnlOd2CI4DQgEcJidUKVys7uu8HYZSwqJMN9o/LQbJLcCFpAU2skD9E3un9pkA0VrHxeEZMPB0H0AiNVNT36FGwckpY6Fr1t51xSRihnZNni//v6Sgr13Faspx1fYzkruEBUyrDhuYA4egTrCTKGpd/3I/WC7kcYSIZHYSUeN4y1YbEx6S8mLZ39S7MfHBxGXAOrTONCyqKz4EYqiuOSORHfljae+hbfNUJg7lnUqC6IgTtHwIOQULVuIRUuydaqUucr3KrwNweWMfFZkvXtaOiAUn4Z/6z2ufVaI6OhmNepqlA/RCmoP8UhJ2YebCNkvd4BuSJUXH9AVHrAbUtCns3AsNwWyz6WUKftVS2wb5rhiQ9A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NGQ2aHU5ckDjKqylGNDL6Bx4cxV+f080oYpmbIcIvzMzLx3fQxR3PVw0m4t3MwFnwWje25jRGihNv6MwANQPGUvw/v2vpWPEmhdxSKCzCrQkasQgEngshik1LrjDMD5gZXkbp+Ev5qoiXd92RE2FR4vV65ejfAgn7HX2x6Cz76X6r4yyOYRpcMRklamHC5wKi5W2yZuers/9lgjOskXDzcT//+qJDVTe2VoQnYkZTre0FVlD5KCBLURAPjZnPuaGJz9OBTL6oFQRUWVajZN4PkOWCiAlC0kEFaUcIvUC26/GjxGuV8HC0/COoHJVaARdf4WKgukxN+KDw6LrKumcf7x7MGmXfjsSLyqOCWLTrw+9c1K+9mRHVE2sLMt+NNP/yMMQezXdB1t6LHSdyERxC7+qYTyHKSnVOFZhBUCWlkc1yz9PPr2RBTF7AdGDm8wT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 05:07:02.7845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e369e38e-49c6-4e0b-9170-08def69d3729
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7206



On 7/13/2026 4:38 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] KVM continues to infer the vCPU running state via `is_running = apicid >= 0`, completely defeating the purpose of the newly decoupled IOMMU API.
> --
> 
> --- Patch [3]: [RFC PATCH v3 3/6] iommu/amd: KVM: SVM: Add explicit vCPU running state to IOMMU interface ---
> commit bbb2175fc26e0d5c105e610aeee4bcf1fe796a2d
> Author: Sairaj Kodilkar <sarunkod@amd.com>
> iommu/amd: KVM: SVM: Add explicit vCPU running state to IOMMU interface
> 
> This commit adds an explicit is_running parameter to the AMD IOMMU guest
> mode interface. It states that this decoupling is necessary for GAPPI to
> pass a valid destination apicid when a vCPU is not running. The change
> intends to allow KVM to pass the vCPU running state explicitly rather than
> inferring it from the apicid value.
> 
>> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
>> index 8e87a7f2f64f7..3b2d92a587098 100644
>> --- a/arch/x86/kvm/svm/avic.c
>> +++ b/arch/x86/kvm/svm/avic.c
> [ ... ]
>> @@ -1008,6 +1010,7 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
>>  					    enum avic_vcpu_action action)
>>  {
>>  	bool wakeup_intr = (action & AVIC_START_BLOCKING);
>> +	bool is_running = apicid >= 0;
> 
> [Severity: Medium]
> Does this assignment defeat the purpose of the API decoupling described
> in the commit message?
> 
> The commit message states that KVM must supply a valid apicid even when
> the vCPU is not running, and that we can no longer derive the vCPU running
> state from the apicid alone.
> 
> However, by defining is_running as apicid >= 0 here in
> avic_update_iommu_vcpu_affinity(), aren't we continuing to infer the
> running state directly from the apicid?
> 
> If a caller attempts to pass a valid GAPPI destination APIC ID for a
> scheduled-out vCPU, won't this helper erroneously force is_running to true?
> Because of this hardcoded logic, other KVM paths handling scheduled-out
> vCPUs would be forced to continue passing -1 for the APIC ID rather than
> a valid GAPPI destination.
> 

No — this does not defeat the API decoupling. The change is that the
IOMMU driver no longer infers vCPU running state from apicid.
Previously, __amd_iommu_update_ga() used apicid >= 0 to decide
IRTE[IsRun] and destination programming. That breaks with GAPPI, where a
scheduled-out vCPU still needs a valid IRTE[Destination] while
IRTE[IsRun] is clear. The new API takes an explicit is_running parameter
so the IOMMU can program both fields independently.

The is_running = apicid >= 0 assignment in
avic_update_iommu_vcpu_affinity() is internal SVM logic, not part of the
IOMMU API. That helper is private to avic.c and only called from
__avic_vcpu_load() (running pCPU APIC ID) and __avic_vcpu_put() (apicid
= -1). Within SVM, apicid == -1 still means the vCPU is not running.
When GAPPI is enabled on that path, SVM derives the GAPPI destination
from gappi_cpu, substitutes it into apicid, and calls the IOMMU with
is_running = false.

Scheduled-out callers pass -1 to this helper by convention; SVM
translates that into (valid GAPPI apicid, is_running = false) before
reaching the IOMMU. The inference moved from the IOMMU layer to SVM,
where vCPU lifecycle is already known. avic_pi_update_irte() follows the
same model: it sets is_running explicitly and fills GAPPI apicid
separately when the vCPU is not running.

Thanks
Sairaj

>>  	struct vcpu_svm *svm = to_svm(vcpu);
>>  	struct kvm_kernel_irqfd *irqfd;
>>  
> [ ... ]
>> @@ -1024,9 +1027,10 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
>>  		void *data = irqfd->irq_bypass_data;
>>  
>>  		if (!(action & AVIC_TOGGLE_ON_OFF))
>> -			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, wakeup_intr));
>> -		else if (apicid >= 0)
>> -			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, wakeup_intr));
>> +			WARN_ON_ONCE(amd_iommu_update_ga(data, apicid, wakeup_intr, is_running));
>> +		else if (is_running)
>> +			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apicid, wakeup_intr,
>> +								   is_running));
>>  		else
>>  			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(data));
>>  	}
> 

