Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012031.outbound.protection.outlook.com [40.93.195.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF6A34BA42;
	Mon, 10 Aug 2026 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351171; cv=fail; b=gm0IiGYQfAWbm33F3xSBL7DjuygxeGCyQ6QNQTsP0WtHPpErhy8lMNsXQuNlYdIoPi+fCwpivDPsVg4q1lU6doM7PAzZnIQtNLAWeAQE7rnr/Rpjp0y0zRcGKFQwAPC3D7t1NddWbm4gFnWwYzZOsWdJmoXIm2Pu3CB7mDEVIWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351171; c=relaxed/simple;
	bh=OcuYQ/xCd1j9SG/aeKHufgAlB6rkDqJ4wVY8mXbhYTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cCip6trbD5kpXALyR5+sjYS5igvXA+zNYCvRC0dNFIA4JO7qZes2lh91Y6Or7SN49PtRag3kM4t56rNqcqBnwDVMoGwuCO1zVudxMKhWROZaeYxv2rk2HLYXw0B+KCM1kC008p4Uks0z02htSsQTR5xIARoKCSshynPXwd/qIC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h2NF4IVh; arc=fail smtp.client-ip=40.93.195.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h2NF4IVh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+Tc/PC3jSy2m+LhdpgK4bV+P63PO/8k7Ter08yYE0hYO7d6lBoouPSw/D+9Pl3ELmWhpOd2kt4/BR1Go4aLXcVcACyYzTxWYYWAfcUr7oDnbBW+cZHxOta+RgZxj6B6XOdUwzXAinxNv1cSYcZcAVHq8HwrbpXK+MLRXnX1hlROQdbcK5J7CTTTseaeHiu3y1RKZGCsv923PF19fc6zEzIuOoaHwHYnLao58kfXq3AqMrVtJX0XvIwOcOOoje0EtBXFASE8+T5jgwzLii65jy4nlSkRWgK1Jr3f7AsjTH33ZegK13v32Tyy2UoHfRjnLjhX1ceHUbyYhts1quVfcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2K4Bu5rKGLItqX7NFd/3jAWcnfGqCp1kC7Gt2941Yk=;
 b=UpWrmrLlfY8H1RiEiAdiIXEZgHHk7QAQJVLsU0lf7EW28OyjsuaANEhJAtlxIwjeB0W2OBQtEluDDPD5mATp1t7hQEnEem7pyRW962Jtu1SEqlq3RUeUPzKMik+x6lx1JpMe3xva0EpAj0IjKNobdbMgHRZDBDeNVur9rgaOdhZHv/y9SxTkInPqYrgf/EeTOFKgvHfUHczc1i2FBz3k83cn19Ka9y5Hs9Y6LKqwHtc1MJ7sMlA4T5pNdUdSmdYIbFtf+/Q/nqPzL58iK3sK+xJRyHfDiW+SsbcX7tOC7iB0zEEGHb5BxB7o5lPdiXvLPcbExj77eeHDfPDEPK3eqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2K4Bu5rKGLItqX7NFd/3jAWcnfGqCp1kC7Gt2941Yk=;
 b=h2NF4IVhNezSaiE17z9KHxOsM0gIJrPdnPZ12VaF/uPCg9rY2430yJavfWSMK1cIi4ym4i/sIAFZfRfmn9N+umETPIBtrE+nEnInume2OK0V2HEM2HybLcVZ57zLmVJDHWM6oUlWqEsXEmdCUM+Ivcr3a1oTzEPOw1w11ZPZ2Jk=
Received: from BN9PR03CA0132.namprd03.prod.outlook.com (2603:10b6:408:fe::17)
 by MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 08:39:23 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::52) by BN9PR03CA0132.outlook.office365.com
 (2603:10b6:408:fe::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 08:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 08:39:23 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 03:39:22 -0500
Received: from [10.252.195.175] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 10 Aug 2026 03:39:19 -0500
Message-ID: <db768f80-dfda-42a2-8601-8d0af35c2959@amd.com>
Date: Mon, 10 Aug 2026 14:09:13 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] KVM: SVM: Enable save/restore of FRED MSRs
To: Sean Christopherson <seanjc@google.com>
CC: <pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <xin@zytor.com>, <nikunj.dadhania@amd.com>,
	<santosh.shukla@amd.com>
References: <20260129063653.3553076-1-shivansh.dhiman@amd.com>
 <20260129063653.3553076-8-shivansh.dhiman@amd.com>
 <aauJ80pZrw_SfF31@google.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <aauJ80pZrw_SfF31@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: 535dd5d5-8ec4-481e-7074-08def6bae0f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|7416014|10067099003|4143699003|11063799006|56012099006|5023799004|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tvbXwOiRi51iTawMTp9tNe3mIBV8ABJCFU0+BlDyqSbzCuzRNAxWqHuISn0gg7VVvpaPVTNqULmOzFwVSHQAUqdO6aEGHmSTuUGyms/Yp5OsPgs51BQoNaGhpcX2wsvvnwGc/ZezKJcJtjvDI+dT7V7nlUg1MNE6IlpUS8njUkQcp9tMI2qjapcz4hfXIHlQgNzkDmkEqYpb+1kZXyXfFXzb/O6xGG0wacQr2L3bf+Rmmn3tU1Rm1FBPoA5eWYH9gQkDXBbOZx2M0+46FNK3Z5SVCcK+GuJ874OlA3VEV9hcBMsH3hKiV1oP/+mtcXZWT9OSoX7/AAr1/0CB6p9T90DZTvH8f1T30stKR486BzF7HBksgQoniI4fG7Y9JD4kEuYCYNyUuGr4UGbSe/OMJxlcGoSQyv4A9EqzdbuYSDWmYqryVuHRbihpvvraVlzwazW8B6C940sXTmeqqeXzvJfeIH2VV6pTI3TbgZpCm0xVbgYobasStvqiHgzcGmE6kuh7Nsav8wUbkrOYPyyjCKSlIexyK1jj1z2TbE7cy0d8cRxXcgggvgcO8cYQCHQgm53Uo9s/lsPuoRnZKkuYAT7VRqFXxhjBdIp23BbmeWbnt9qq8iOjiBf6rNT19MTEB4gScHlQYyEfOf/KPCRcoS2bxaotkGH52pJoczKlHe8iUmJQl2C1Dcq1HYotbyad
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(7416014)(10067099003)(4143699003)(11063799006)(56012099006)(5023799004)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	A5PU6Fi2z2fn6Tu+3qa9ldXvZcz3DfAGw/JwQxVVksp6beQZNNDq92gaHtO3O13ua4kqZebtQp/hKqq1mrjnEIMZc3erTbJB5OJyItXUup3q0XL6oth5Kw2ih9cRS8HaCxVA5LufEEsdt7BhFM/GOq9vFd1R29Y/rUnhYD59CZG29RitBpD7sWr4ppyCMULJo6sNHWeDWtcsnXLroxQjJCi48FX9YiFvMDg4VINrCxUVfO3NiCXaIRiLhAekXMkJO9TZNUiYfr05Cv1B/sr/ljFlwPh+lMOyl5jT7068G7vxYFBL4yYhi477fN6XCH35P/7tPHZhgJoVjxlDr8kPZHUOtuwfsHU6unWZkJasQEbjpr66EWZDzHjpVfKYFeJda2PHzsMdreklvU+3Q6HdrkgF+GuiSlNVJ5OcsLEnfpZtx+0mhEMkgcriXtc9PmKC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 08:39:23.1046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 535dd5d5-8ec4-481e-7074-08def6bae0f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980

On 07-03-26 07:44, Sean Christopherson wrote:
> On Thu, Jan 29, 2026, Shivansh Dhiman wrote:
>> Set the FRED_VIRT_ENABLE bit (bit 4) in the VIRT_EXT field of VMCB to enable
>> FRED Virtualization for the guest. This enables automatic save/restore of
>> FRED MSRs. Also toggle this bit when setting CPUIDs, to support booting of
>> secure guests.
>>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>> ---
>>  arch/x86/kvm/svm/svm.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 954df4eae90e..24579c149937 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -1144,6 +1144,9 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
>>  	save->fred_ssp3 = 0;
>>  	save->fred_config = 0;
>>  
>> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_FRED))
>> +		svm->vmcb->control.virt_ext |= FRED_VIRT_ENABLE_MASK;
> 
> This is completely unnecessary, no?  CPUID is empty at vCPU creation and so FRED
> _can't_ be enabled before going through svm_vcpu_after_set_cpuid().

Hi Sean,

You're right for vCPU creation, CPUID is empty there and the hunk does
nothing, so I dropped it in v2. While preparing v3 I hit a case that does
need it though, a triple fault:

 1. The guest enumerates FRED, so the FRED MSRs are passed through and
    FRED_VIRT_ENABLE is set in virt_ext.

 2. The guest triple faults and KVM intercepts SHUTDOWN.

 3. shutdown_interception() does clear_page(svm->vmcb), which wipes
    virt_ext along with the rest of the VMCB, and then INITs the vCPU.

 4. init_vmcb() runs, but svm_vcpu_after_set_cpuid() does not.

 5. CPUID still enumerates FRED, so the intercept recalc puts the FRED
    MSRs back into passthrough.

 6. Nothing restores FRED_VIRT_ENABLE, as only svm_vcpu_after_set_cpuid()
    ever sets it.


So the guest ends up with direct access to the FRED MSRs while hardware is
no longer context switching them, i.e. it can clobber the host's FRED state.

Setting the bit in init_vmcb() is the smallest fix I came up with, so I'd
like to add the hunk back in v3.

Would you prefer it handled in svm_recalc_fred_msr_intercepts() instead
while setting intercepts? Or is there a better way to deal with this?

Regards,
Shivansh

> 
>>  	init_sys_seg(&save->ldtr, SEG_TYPE_LDT);
>>  	init_sys_seg(&save->tr, SEG_TYPE_BUSY_TSS16);
>>  
>> @@ -4529,6 +4532,9 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>>  	if (guest_cpuid_is_intel_compatible(vcpu))
>>  		guest_cpu_cap_clear(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
>>  
>> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_FRED))
>> +		svm->vmcb->control.virt_ext |= FRED_VIRT_ENABLE_MASK;
> 
> The flag needs to be cleared if FRED isn't supported, because KVM's wonderful
> ABI allows userspace to modify CPUID however many times it wants before running
> the vCPU.
> 
>> +
>>  	if (sev_guest(vcpu->kvm))
>>  		sev_vcpu_after_set_cpuid(svm);
>>  }
>> -- 
>> 2.43.0
>>

