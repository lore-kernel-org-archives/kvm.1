Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013061.outbound.protection.outlook.com [40.93.196.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACBE441607
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111294; cv=fail; b=bDkPG626bmiG8uqat+kdB6efTuE2bthx4w5FoacAHIFvtsyOY8ethkxTwz6kpuo52VYsiJP5LFE/IJrpKPiU8AiTrlJEQjJchJ+q8DZldvJ+2r2pbX/LCxFMvjUQv3UKErvyh4xqMouCy3w0/9TDw6B1eVe54xlJMOAE9x8pUew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111294; c=relaxed/simple;
	bh=IIr3pOhaJaPdXg7no0YghhX7E7mdYW9JdnAf5hw6m3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pgoTaDKzQMIRu/SpJMgwfAV+La9wAz+5vpYW90sQyyaOPCcCghDVA3ya2glfK92BHQkPJKSS2Fphrws56FFVR4rTT/vBIwTEC5YWtnSraMCwAAiCdCcPZ6XyXdGvytprKuf5CNUFwxYwxw6fWJk1hLIKhbrEIBBphszu+pXMKKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V0p2tEAy; arc=fail smtp.client-ip=40.93.196.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V0p2tEAy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeFXjvaFmtGhch+H5JpM3ENZiyjA1ksQkCNz90Y9AmS0KQQ3bqC8JdW8LNbtq7Np/FP77fOYxLwYW2Kmw/LEekZ0BkRW2+KejDNfJ0BtOIrWWYG9UeSwO9KMTB/zMMaRK3mJe/tPmf1AbZul9yIzdejDM3PDRv39vFscpsfOq7P30urexZe8mxW2VGKpgfj902XI4p48/9Ahu81+83RXDm8tS5tYd2KeMU8bYt+88HYXknSAbqcKCVnNyMVpj4PHZbED/qqssUzSFiquw6Uf5yAmATDCJEIVixgasTPGDNh2MN7x5293zI5CSSz/nAYXgeU/NMiS1suHk9hFYol3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1DlAiGu0UEfWnUiLVqO0sZNvL2sqe6Au74KffuNmpw=;
 b=NJ5RxE3TzC45wHInuer/beGLYl5AQBh26D1RqZRl8GLY7riKzzTo1Oa6AL9BiAqU5YJAH0iRXt9ttbWLp8ZrgcI9oxuuNo/nUOOQNUo1TlJ4PFBY2TkIpzsGw1czZ5D5JbfAPLJfDfz9iohxuTY2AOXDCGE3s+s/1ifNVmRcvOCTMe3mFB9WsyEj5cVrs8t+kV8vtly+HwBQzgJ/McOa4zQ25bShUwN8JrsMER52v3ph9Hja+lwIlo2XevPCIuYth2A9QVAbOuh0Puk5VqSZTiX940SgCUS/SMWjRKYd7176tfSE8UPo0SXYLksgUrkhqupfLkUF/nmjNffdp9LERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1DlAiGu0UEfWnUiLVqO0sZNvL2sqe6Au74KffuNmpw=;
 b=V0p2tEAymAaFQv+Fn8z8aqFJngiLlZGA5GdeFCV8MxTlVfVlq8T7+pg0gsNMaG0qvTi7xXiNYv1Hjz9u0SKbutUtJDOmmHuXRcMb43RhgsaPuMB8/+OzogUO6oJVHZ2uNikah0x8kM7XpdD+Yf+bl7A9RO/CLA0cIH/ige2GgT0=
Received: from BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::31)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 10:28:04 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:2c4:cafe::8) by BL1P223CA0026.outlook.office365.com
 (2603:10b6:208:2c4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 10:28:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 10:28:03 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 05:28:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 03:28:02 -0700
Received: from [172.31.178.83] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 05:27:58 -0500
Message-ID: <7044cd1c-8f3c-4428-9fc0-b940b05b202d@amd.com>
Date: Wed, 15 Jul 2026 15:57:57 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] KVM: SVM: Compute DEBUGCTL reserved bits
 dynamically
To: Shivansh Dhiman <shivansh.dhiman@amd.com>, <seanjc@google.com>,
	<pbonzini@redhat.com>, <tglx@linutronix.de>, <mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry.ahmed@linux.dev>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
 <20260709082953.69434-5-shivansh.dhiman@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260709082953.69434-5-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 16474339-765b-491e-e650-08dee25bc0d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|10067099003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/ve/CiyJCurNhTa4lStRUW4cbk3ct+nI6GJ7RHwqemAnUAL0MolbkupKvy1ogDjoIaLzJkNTBGe7ZjyRxgEiJhTE58a6u96Enj4vQlEKb0MXn3GNRl9g3G0OqvRS+jJjlcjSmN/CAUOxU3h4ZOS/VKEhhmO1pdzg7i6Dd8YAbCqtA0YKW5iDnKaw8O+sTQ0m7lrh6KZDAY3qE7znwAWYk2PyXNHJAHrGaovvD+byNpExQaPnJtGksNRQB0qL6MWY/jgOLlVGQrcYoEcnsIxh/UizmM8cNfhua1E+qbQBHNJOGjvqkRFE81J3LZ4SJjqs2uwf43oQorlxsbRWt6v7FcGwwLUU8Jv8Z6nMb43qwtADfe/K/J0Ljw3K3yXmQyA6VoqpLig41xas/I7kyZMplG+FnfGjsfo62M7y+IyXv65HkB2LWSpK2UPYlEqXb8+siWLqumVJRizZru2O9juVsmHb8eD+pUg+I/GCrJTVY/CkdCYMPXj7wCA65K7WdLDdUtqzgq5tyWfqWwYxC52CpkXLGutdcNrJr2CjW7J498Dugw1EEiKoIA8biuNFAYvdSgEnHvJnTF6QYoL9sphafMh0bu57aAI+rbgoP3zto7FIKgMRcUBpQ1WZFPiZM/c/bVm4Kry1AYk88dBAKpH29ojZw99h+lR1yCGl/CAsvzAt/Viumf5WDdH1F/S4ET5PIl7B51xINz30///WzRAZbQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IGDnOHbz4D+SENpCSxeOlsIyxlBGXEvtXJ+4K6VAbgKkCNet72VpShO6faPi80v6HQquQ+wvaT0JwpUEgVa/k1k99g57nCQUK7pvF9gaIR7bJpeeajSukO0EYg7+WNa4KGI8ewEkjBR0N1vhDvv62/jVlrfRUtZeKCBmxWyVuBpj2DeTPWh9ZDUpCnhZ1BvnHI4xzJDUbg7d8Vpvq/WNCc9NE4NtOPHwcyeaxBRnwSBwsdaOjaF/c3rF/fOavcE1SHU+Eqh/a8dVOEaJ4B2m/IhIRscRsthtN4jBhJakUEqUt0Q/At0sgtrLggwZpE4bb3NAwuZm6ov8p0KyHw9RFsvr+rWBFwSddm1WwEeTcabKMZVj5V4nmTAihWUBgjtN2DXJFvFmWUM5DQKyaY56uLLILXsIKykdm98fT/Qom2jJP/pbGoK4xpCIiqQnhWfc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 10:28:03.7664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16474339-765b-491e-e650-08dee25bc0d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886



On 7/9/2026 1:59 PM, Shivansh Dhiman wrote:
> Replace the static DEBUGCTL_RESERVED_BITS macro with a helper,
> svm_get_debugctl_reserved_bits(), that derives the reserved bits from the
> guest's CPUID. This will allow DEBUGCTLMSR_BUS_LOCK_DETECT only when the
> guest supports Bus Lock Detect, on both the MSR write and nested load
> paths.
> 
> Plumb the vCPU into svm_copy_vmrun_state() so it can pass it to the helper.
> 
> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>


> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 8d77c10cf4f6..402a827f622d 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -783,7 +783,15 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
>  BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
>  BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
>  
> -#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
> +static inline u64 svm_get_debugctl_reserved_bits(struct kvm_vcpu *vcpu)
> +{

How about just 

	return ~DEBUGCTLMSR_LBR;

here, making this a genuine "no functional change" macro-to-helper conversion.
The BUS_LOCK_DETECT conditional can then move into patch 5 alongside the rest
of the feature wiring, keeping patches 1-4 as pure prep/refactor.

Regards
Nikunj

> +	u64 debugctl = DEBUGCTLMSR_LBR;
> +
> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))> +		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
> +
> +	return ~debugctl;
> +}

