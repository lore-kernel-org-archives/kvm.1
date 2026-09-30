Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB2A3A5E9F
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790806596; cv=fail; b=CYh7ZxxqpL4E01KYLR5y1XB7d6fPj+CNAc4hczYIduzqFrGPczs60kX1H/gnfxro0wJ2H3cdjY4CgqgumIbD4XSGUGdrMIzWlDP2RPl8Tk3h4vuS/v82+rILXJ7+t8IVXmY+/pDhd2ovnk64byP5aUKgDbNdIwRvCdsE2j6mJlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790806596; c=relaxed/simple;
	bh=GXrGDY8VZVMd/NMBuW6jLxXvFZqbtqQ78mjGLxnKuho=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PKcOC8ZXjg1u55T/rRvqD5MMieO0fupksgmJyVIAzXNWANigxoCM6YiodYuiv5iIU6SqMFnXOyuJou5xi9tcqjlBOp0009TIxaHZqx02Te+g1EUdqe5yEuv3bA8fjuNmOKSS56z1GlMrXTdtUOc3Wg4aBVu4E8Sibiz+TOG/JBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A7gqwnvh; arc=fail smtp.client-ip=52.101.62.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A7gqwnvh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxmAeRLiNmZKFZjz9UCA62gvn2PcYQwBA+te9jRAYzRTVwVOy3Wrmh/Xn+lOzvl1VaprHn/EKDFHkeOlwQ3Yy5pp+G46Al373w0OxtzsXBn7tKeoCBCcqHf6vdIarcUyV2HlXBS54dZUz/Vl9O1hOXlHAWvRqLP2I9sjhDgCC5gzNMJ6paWh53m0e2Q4opa/sN1jtqE8dB9tXg711Sh+LN9i3TFIAB1GG8xZYdqaBEwryUie5L8EWLWh05OI4J2y2dExULEnDdklaVkERIPkTUeHxOSiLF6Y7lu2FlmEz/7+0kL8QANvmeGPoVloiKYDJPQrd3AiPIfliq9wxEIhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ftn/XFBO8+ranBCMjhGQsx9WXcmOme9QO3KRVJNeW8I=;
 b=ROowJt6nDuwB0NJaCvaqdCyAw2rhRSbMmMq2rt0J55GzU4C5KMlj7ALMM1b5BUvFy0HH2cn+ZWdj03Apyozn+7Pjt1Uz7Hwr53h6MtFRvBW6EetPh9AIJ06HCK4VQn/8eBWhqB3XdiT4lpgrlA0fvpVp42xtWtiSE9MA1RX9lxzwdnqRyuf4+GhPW43WaqadgOD5YpBw4lZved53AgqCt+diflMu25i7YJqbLpl8MRbiFgun9IE3K83txyfnKJIh655wBfsBb2jFNp2dMUtOXiEZAmHdCeUvLKunr1sIlszH0NNI56KEvuZHXL0ttuc8GO5v+k5VA1TdUEDCoXDRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ftn/XFBO8+ranBCMjhGQsx9WXcmOme9QO3KRVJNeW8I=;
 b=A7gqwnvhmnqafTcnCM9q4Ev0e2mqrZILlOLMPG/CHea2uQ2g2FkfsVu7S2ftmdtQKFqIaMraGgSBPXU0XN7k5ptImFrNt3vCGl8D4VmcDN5wqJpVwqGO+JxqKk47dcetkM8Wc/79EK2jeq/RR2hgESSMVGBBpJ3Y4Yfh5OmwyQc=
Received: from BN9PR03CA0541.namprd03.prod.outlook.com (2603:10b6:408:138::6)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 22:16:12 +0000
Received: from BN7PEPF0000009D.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::3e) by BN9PR03CA0541.outlook.office365.com
 (2603:10b6:408:138::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Wed, 30
 Sep 2026 22:16:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN7PEPF0000009D.mail.protection.outlook.com (10.167.248.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 22:16:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 17:16:11 -0500
Received: from [192.168.1.13] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 17:16:08 -0500
Message-ID: <cc237101-8b1d-413c-80a0-87dee6edc6a4@amd.com>
Date: Thu, 1 Oct 2026 03:46:06 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] KVM: SVM: Refactor svm_update_lbrv()
To: Sean Christopherson <seanjc@google.com>
CC: <pbonzini@redhat.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
References: <20260721050600.87268-1-shivansh.dhiman@amd.com>
 <20260721050600.87268-2-shivansh.dhiman@amd.com>
 <arav9aN48nEZTv7V@google.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <arav9aN48nEZTv7V@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009D:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 800f6380-70eb-49ec-7960-08df1f406fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	bWmlbkpwbKUnmXD9rI+x+TEHdvJf3iQ8q1LskpXb/IOlm0xi/gdiiRxUvOEBqKL6EYN3DiPpACVyOOKVpTi/fV+rsP6R2TldUZdD5VtU1J5SjcrowKWviotLejxrdeQ4IAFzXAH69OQc6IBPLbEPyO1IJdwVZITHqxstyzMOkdA5/SEm4MtjpKgMYBvFiz55Cc2qAhaOlABtRs50CToDzXOu2PrWRvMX+7Ud/aBov7xXu3ActW1TdBAgDcQoW00ezebYzatCMdaUe3MBiFhEcBjnR47I4h7Eb/ZS7qVpDPlUGtf/ADZcAZfz91AYr6OIAN4KRMrFWK/UnLjxSaOnOYrPe/iOomlmQeytAA9s87d8pi0Vd++KZNde+Keb0q3jczSGI4wzm20PSAzPm94Uxz9vafSeWEr/uLl/1qcWlRyv4I2NbYjjFxzITMsDKR14pc3OiYpfUBSpI9ixJw2KcElPYPok56uXV0/rbIyuXuartaTpLC/2fS6iBxTIyhfO80985DI1bbvA3H0CDLD0F3XiptOZ3iyuUCrqcFFIYkPRawniZXC11PKCNrFtY6n4mJHN5F+bay7ikk/OlEifJg3EAm+dv+lkcc+W0768wqiFjzINI1vgqydMLIPjWSdMfVFB9gtwaJzhiIdDPFxhUvBlvRu11niYAHANfWjAB+KvsgZ+gPaF6KW34nrm9hwD4P3osgiMz1tdrEpkU21PJA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Dl3xte63a+J4m8Oni4e2/gHDeBaOUsUNCSicAcLYfgSuSRKSNQZvKmllK0Pd7Ad5zw6JX7U7IjLkNRKhnrTQX5uEfY1yFZRJKCNVvqMQmnbDI18Cllt9RayPOP3L/ZsV1xG/20i9DdM9mcobmPP39D3OvoXshoxLOdmYKJIjkw2qZXoF36A5DuXR9BUxIqgtpVCQhIrlkA4z3sak633q6XLTpTk9N0uludYrk3T4X3xXOghezobnOyJtWrSJDdwy/wHPyVuz5EAWrnOa2Cygx+jEijL+x5pnlYjweLDzvkyXm1v7CdVrARE/qfh7FSj8WUozgdY5zXLdwJ+vy1b5W//vafOl1bHUKDYcLzwajlb+Gx4e9/wj17D879jq2/2hTXGRm/RM1sgLaUM7IJimorwNy4L8saAcbMGWeM9/UNUPEnbEWIjLv5HJREgRA5rH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 22:16:12.0626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 800f6380-70eb-49ec-7960-08df1f406fa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF0000009D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733

Hi Sean,

Thanks for reviewing my series. Replying to v4.

On 25-09-26 23:01, Sean Christopherson wrote:
> The shortlog is effectively "do work".  Be more precise.

Ack.

> 
> On Tue, Jul 21, 2026, Shivansh Dhiman wrote:
>> Rewrite the enable_lbrv computation in svm_update_lbrv() as a series of
>> 'if' statements. Rename nested_vmcb12_has_lbrv() to nested_lbrv_enabled(),
>> expose it, and use it instead of open-coding the nested LBRV check.
> 
> This is super duper obviously two separate and *barely* related patches.

Makes sense.

> 
>> No functional change intended.
>>
>> Suggested-by: Yosry Ahmed <yosry@kernel.org>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
>> ---
>> Changelog:
>> v3 -> v4:
>>  * Rename nested_vmcb12_has_lbrv() to nested_lbrv_enabled() (Yosry).
> 
> I don't like this change.  Unlike nested_vgif_enabled(), this is *only* checking
> the effective vmcb12.  Once the guest_cpu_cap_has() code is moved elsewhere, I
> don't see any point in keeping the helper.

Ack.

> 
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index ef69a51ab27f..e9f2456982d4 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -880,9 +880,13 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
>>  {
>>  	struct vcpu_svm *svm = to_svm(vcpu);
>>  	bool current_enable_lbrv = svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR;
>> -	bool enable_lbrv = (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR) ||
>> -			    (is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
>> -			    (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR));
>> +	bool enable_lbrv = false;
>> +
>> +	if (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR)
>> +		enable_lbrv = true;
>> +
>> +	if (is_guest_mode(vcpu) && nested_lbrv_enabled(vcpu))
>> +		enable_lbrv = true;
> 
> This is begging for short-circuit logic (which was kinda the point of the existing
> code).  An if-elif is silly, and I agree that squeezing everything into variable
> initialization is hard to read, so I think we should do:
> 
> static bool svm_need_lbr_virtualization(struct kvm_vcpu *vcpu)
> {
> 	struct vcpu_svm *svm = to_svm(vcpu);
> 
> 	if (svm->vmcb->save.dbgctl & (DEBUGCTLMSR_LBR | DEBUGCTLMSR_BUS_LOCK_DETECT))
> 		return true;
> 
> 	return is_guest_mode(vcpu) &&
> 	       (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
> }
> 
> 
> 		bool enable_lbrv = svm_need_lbr_virtualization(vcpu);

That looks cleaner. There's another series I've posted on SVM vLBRv2 which will
benefit from this refactor. Thanks.

-Shivansh

