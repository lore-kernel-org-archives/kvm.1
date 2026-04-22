Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3651C2E2EF9
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839220; cv=fail; b=XZOeXTagsdbJB95cGySJDvnN0JVvV8iSRXjfz8ik+7ATgQIz3J4qDW/z0Ipn1ugx9JXLSOrGfHgKSRoKZu7eSgHw6q3YLH+8M6ou67hvjhZcxJ8qcf/lMlo5gwcsswiLv+ezxkLXl8Ff13xbdsnwu/d0khznCkzm7a+2ZoM9FA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839220; c=relaxed/simple;
	bh=RXJsgLrqBbQnC70q3bPyg0m49T6O7jeB1MHGvt8Yarc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T4RjUiiCoqiQfPvqLPYyohg2qwa7u7RMkIcamGPn3ssFudEEMfy5x3k0pffD38Wvftw+hxNzjRQJ4ReysKak0/P3LABBMHZ+WlysaSZXNqvOVQThT3TB+dIANjLuq1+D0n1Ezn8D55xzSN8VlCpzSuxoxskYVve7yjFjYCDp64Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LdjW+J5E; arc=fail smtp.client-ip=52.101.85.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LdjW+J5E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnaY8pqmw4iTiVW2957pV/nr959eIafk5SDyFQYFGJuYeanPwdAoIJVYu90dp/3KMbQHiScxg4p7jlNC27plFnegY5Fzy9Qd5qGTYvYPcqkMtfrMF/wPeiw7f2BIYhfijo8VduVrMEis+xc6kRbwvdYLPDFBs/9dWt056fb7pkzUK7JQVe1wnay9dTPIkm75mzdQinU8Pnh+58saqeCucBef/k4LBplpI9d9cGrtxroDaojXDMjzfEwDGiiQTcHh11Mvi1/FU7WO9dc7UIDkD+j9hhtGOayVVKU/MkAGPHMW3vPcsEEQWk1+G2Pd1z6PWIqLfbOCuOUdwnUggbSYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qb4hkLjVpOSuOZG8Nj0AB1IdFIy9SP0Wls+OLBQryuk=;
 b=yFq14U17D4dLZ+60vYnG34vT6n9hECQ6MelmxFlPx/8WjJdH9bCPIU6fx/jmgYtR4SbxK53u9Xguc6chGeFKkeSA3QHRRLTbXZC38lKPVgjV6Dbw1fsEm1Wp0gMeGpCOB8zN5ty+7IIInRNq2XA85zy1wUTDEXCFHzDXPWAboPQVSp68RNMBxPv7prWwed5Oj+CmSpTvjrgPir29zjO2W6Tp4Z+KD3xxUYq89bqz7alp5s6TgmCH1cgS+RhMEotuamEivXCJ5Nv7J5Mwfbion8BccsmzZDWIC8PGq2UxbeQZBsO/68iT4/a5KctI/p165xCPzwqaSi/IiR8Vit3pjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qb4hkLjVpOSuOZG8Nj0AB1IdFIy9SP0Wls+OLBQryuk=;
 b=LdjW+J5EgLJU7FjfiPtTKf1EjoIBqa9JPvhH2om6Wm+n7HZgNlAoaYEg58CD3agOhNWkAHQSV5aZk1BmEGyNAmVs+lrexN5c12WwEIcA+wwA/urPqdbPhmgZbCHmv4TZ7Vg8D2cS2Ee0R8OYOmVhvp2qrhTXNqFxh/FxJ7TL9kc=
Received: from MW4PR04CA0264.namprd04.prod.outlook.com (2603:10b6:303:88::29)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 06:26:54 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::e5) by MW4PR04CA0264.outlook.office365.com
 (2603:10b6:303:88::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 06:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 06:26:54 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 01:26:53 -0500
Received: from [10.252.210.85] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 01:26:50 -0500
Message-ID: <4c977b79-e93d-4846-b57d-e63ac878dc5b@amd.com>
Date: Wed, 22 Apr 2026 11:56:43 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<bp@alien8.de>, <joao.m.martins@oracle.com>, <kai.huang@intel.com>
References: <20260407063245.2755579-1-nikunj@amd.com>
 <20260407063245.2755579-8-nikunj@amd.com> <aegCKy-4wxRq2jou@google.com>
 <aegFDBWMUvhR53c1@google.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <aegFDBWMUvhR53c1@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 865c78ae-a3da-4b84-7897-08dea03825a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	HJ6YzQfo811rxktKAUF9An7kCQWwhslK0E8JLqUyV2z+ie7kZPy3POvFU+YhISAj9LpBREkVri0Vk75xuQURwnMMnjwIWuiA25kjCmGaCptcBU6hGq5Nan+Efvq6jzYqnS2JwPtNTm1N5d3FPVjhke25ObXBi4DVTKURVx5HRfj+llQlhukfwGKFPBCp88QZX1KPlyk2pi3Vuan23K9nbHlFX2QDhz2o2rTfh0AkITBA++e8gOMU39SC6zmoekMVVqgQxkbMaY2fJLwxYrHL5pk6MHqo8UbO6kl50DSgym9GZcX986+fc7SYBjyYApFzcuz85PsmQBeQUYU2qXLlohceNmEJ8wKpobexylVulRYrjdMb/McMNcedTcreMGd6gnntdfI/xA/+JydK90ttjXjaTWa0qRfI7OcmKT3LZz1ZTgT8ixZyZLpeOSl4RoFWSzgiV9bLalNUlQh91Ity/QrhpuJNceLZvQEkawhaoiVZEyHtgCnLz2hBhMSzIE+TzhA9oI/jgfj5e4RQrOxERfzO/YYOiqQ/otiDRRtakdA/EyuSci6JsCjPKfrm+j/z/KjGNk63qivuDQmM4iHFo+RMqA3SLbgbjnXpfLXoQyFnhp41uIRtBPh8B3+W0aouoi3Lwdg9hqoD9RP0kD+dfp7QK+Xrt1UfhY/VAZ54tIl7Qm/VZdW03OUIkBfxBfInnVzTYOuNSKyfLupLARerJ3tp7bczjnX9jJeMXGVG0MBIMvdfJNloV/IrfUeAueSSCLZxnF84N/ST6bQAssyeng==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SoG/fG/mKdlQa4bVrk8OXmstzJnYhtQa89p5vnHLypbh/G0ffpFkGLhAUaDfFvfEdHkANQ/w1cAi+tPO2EBh8X13exOg8mEfdy7IkABW72WwMEcZ4QeOG1I6XIz3i5s93A5vL714+YoOmmVsMeQeGomTGh7TjtAODrBU1H57gZNi/OWIbq9EsqXCQrdDLaIONibSFzp0fn5RFwO8lvFNDwW2sgqO2OH5shRraL1xWVO11gMokrGRsHqI7GHDTeB2gG8y0VkjfsfRoqXp9rmPfavlJnd9EsCITxzzS2/N0tW5u2hXmF99EP88UzGGHQWdVWMuFWLC508egL+guX1Qwr7NbH4O47bp+/mMiXQgoT7pBL87LQUJeT/nNN11WXUf6vnc0xY3wxJWCqh8+PpmPLKCg0vgc8uQ6Jz8FZ33Dn1Ta0RMUYa8ir4yOn8uNele
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 06:26:54.2203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 865c78ae-a3da-4b84-7897-08dea03825a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773



On 4/22/2026 4:45 AM, Sean Christopherson wrote:
> On Tue, Apr 21, 2026, Yosry Ahmed wrote:
>>> @@ -3253,6 +3278,54 @@ static int bus_lock_exit(struct kvm_vcpu *vcpu)
>>>  	return 0;
>>>  }
>>>  
>>> +void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
>>> +{
>>> +	struct vcpu_svm *svm = to_svm(vcpu);
>>> +
>>> +	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
>>> +		return;
>>> +
>>> +	guard(svm_vmcb01)(vcpu);
>>
>> Why do we need this? Why not update vmcb01 directly below?

Are you suggesting something like below:

void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
{
	struct vcpu_svm *svm = to_svm(vcpu);
	struct vmcb *vmcb01 = svm->vmcb01.ptr;

	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
		return;

	/*
	 * Note, nr_memslots_dirty_logging can be changed concurrent with this
	 * code, but in that case another update request will be made and so
	 * the guest will never run with a stale PML value.
	 */
	if (atomic_read(&vcpu->kvm->nr_memslots_dirty_logging))
		vmcb01->control.nested_ctl |= SVM_NESTED_CTL_PML_ENABLE;
	else
		vmcb01->control.nested_ctl &= ~SVM_NESTED_CTL_PML_ENABLE;

	vmcb_mark_dirty(vmcb01, VMCB_NPT);
}

> 
> Yeah, I don't see the point of patch 6.  guard(svm_vmcb01) doesn't exist in the
> current code base because it's not needed.

Sure, I can drop patch6. I wanted to keep the code similar.

> 
>> IIUC VMX needs this because it updates the loaded VMCS, but the VMCB is
>> just memory.
> 
> Yep.  If VMWRITE could target an arbitrary VMCS pointer, VMX wouldn't need the
> helper either.

Regards
Nikunj
