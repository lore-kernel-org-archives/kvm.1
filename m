Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16DA29D291
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201997; cv=fail; b=ZPjDuzmhcJKHgVF6BWkULvkkBfgFHyhOKKuFc4yUkXza0Xf8xchIRhYnClg2j81DYDQlqQZ86TOhRuNgsQDmsv7kNai94oVRnizz8X0PEz/HBaSMDabsz6k9TxA9ZdPmNInhw8ULRc9FqAp2tOOD82ldwS6F7Re2wR3nhZVcRiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201997; c=relaxed/simple;
	bh=JGQnDszPMjTZOxQboUIgiR9cXuBdmnfW1oGraXSKu+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZJQ4cdtrd0LqieSd6737D9ZwSCLbF2sDK13yf4WG2oyO7xs833dR5ZkE6M8WvScHn96WdiJNbbouh1ZzcSmgKiJajyXVO00J1R0ezTI0fQkTSp0DJxkI6UMv6ZBpJOMMMZ7Lxf++zjGEptW7VmGEJ7TOSAZiao731TzPXv/ua80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OqkCr+8X; arc=fail smtp.client-ip=52.101.57.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OqkCr+8X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWBbkjCyLAE1H/O5gszq8jP52lkKucYaizBnVcUnnYg1NYhzrRgvv9cfq65GA84UbAMP4FCSk4H7Q5T5Gt3o0jgO7ICy5b5pt/YMsjmfxClk+cVKXLIROlIlYtpjEvIAsD/1eCX0w22tnErkAIoGZijP52uSqCj66vBHieP6HNQEM3Vg4mTlh+GaVlPkN00uy/1T6+CNMjelOAHVeEsa2NQqT83XBJzGB5dwNvKUqAys8qgbwQ85qK8eBMTfqUwTYzrTEzPPLuYuBVeZteJMZwFyYMVuAsy42RYbxQpmT5FANk1jREMmYQ38HcAMyfn4n95Vq/tHDu0CMPDtwR39GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSZ9yO7f2pU81PGSX3+JBeaHyfhpAu5ZtLMTbVgBoIc=;
 b=aSGCm/XAK07lUF9fHla5Y4vMTGfqr8i1c8pClb5hM6+i59FXqVbLOMeIrDUdFibX920X4zZgfHzI9kb6DYEK9fa0ffU/Hcsm/IIgQ5SjKP3LfWoRTQ6abpmRzE8s+5ejM1Yf/n+6zO4X/63EGPo1YXncw1u+izCSeD/g3jN7uVGE6KFhr9LVPZS9owmEMFVJMOGmyBPt5LL/VMdni30ST0Dd86A3M7pqB6UubrFkDN9ZNl+IWhA1xgRc6QS5+twXQ7ZdKdphhMhV3vPGQ/LkxcRslAdlE4tJNOGJ4k0++0FooAgS8DuFFp300WyAyRyHiq6oaIlWpzmpHwRzZ3kjkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSZ9yO7f2pU81PGSX3+JBeaHyfhpAu5ZtLMTbVgBoIc=;
 b=OqkCr+8XBvrk49fl521oG/ylQbWmm9Vjf/za/8luyBmvIEELfEgt8mqKwv29Rpk86DDtnOBqfVVk5IxGfODna6moIew73Wpl9ReY3l+aNqP7swYxTBU83Xyhzn6CqdgaNofEVhKyz1shxCnf2qHmGBzRZkJZmqTaNVUutMvJOgQ=
Received: from SJ0PR05CA0039.namprd05.prod.outlook.com (2603:10b6:a03:33f::14)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 14:46:19 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::ae) by SJ0PR05CA0039.outlook.office365.com
 (2603:10b6:a03:33f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.13 via Frontend Transport; Tue, 19
 May 2026 14:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 14:46:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 09:46:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 09:46:18 -0500
Received: from [10.252.210.85] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 09:46:15 -0500
Message-ID: <77f1f310-d789-427e-8c10-bd6ac4836add@amd.com>
Date: Tue, 19 May 2026 20:16:14 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] KVM: SVM: Add Page modification logging support
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<bp@alien8.de>, <joao.m.martins@oracle.com>, <kai.huang@intel.com>
References: <20260518045916.2988667-1-nikunj@amd.com>
 <20260518045916.2988667-8-nikunj@amd.com> <agtGh82vLu4G6pWI@google.com>
 <agtgltn2wLNFrS2f@google.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <agtgltn2wLNFrS2f@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 6621addc-6d7f-467d-92b1-08deb5b56335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|56012099003|4143699003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	vKZHZwDyi++47wxrFmMHY/CwPvmPSvhWOKbxkSQM7rqTln72J4QAZqIH+k1H1McVuk0uCj/MIGUj0jjaYQkZTZ3DBZQRFu1ipZk1/1ViMgBdCSiwHA1FZyJxKcjWjbUt3BxMLdU3gGpbM4YtvZ4iUhFjCtow3tWtI36nI23W8MS7ttUQGpdKr7DzKPuY56EYBZB8NgZ1B5nwiVidHnD5oW6Dl4jRbVgEeOdgyh3rLQSQPpdp4qDpnYLYMnghhT2zJObxTiBwFYhqNQAx08W/KLXxiafRGXxlNOB/OfJC3O9UUkHc/aMB2+MXHz1IdYAjOZ3b12gvW+fVIMRnrcJXGcSrjZyr75Ht2u7lz6VuEdI5FdeOslm0f/GSc95Hv0zz9BH0OtUnOKbv//J8VzORDWrztLfTVNwCZEj+ZcSfChlIoHQK7NxbXQ4HZE89en48cRIgngX7MuEwzkypWVb8gvo17LAAu2pJpcBb9O3/bQdN1cqtVOwnWS9V/VjojC2wHzsQ6jN/91lJABgovf4Q4jUYXjJDwwB1EFn7Uv84NokffFBCTHxDXgwqc361hGxyqLKaAZh/uN+sm8K6B8gNMgpJ4RvAX/lYUKsaO/JjG0j1Ht4n59cy5dZepFruruWB1kgXPNmmeNtPeh4isxGerHSiVCuVOcpCemJw4VZ3GHPkMUcjnpruRSC5s/vWdSsAvbIMlVvd7OMR5CylK2olBLsc74oke4qUDdAtrKM6wNA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(56012099003)(4143699003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8HNJixy19GCW5Yo85EI/+8XcCrqbA39S1hmM+0yRC694grLM7viisIz2qivrRFDauU7qjXkj8njMbDhvpUMrkbuzfR1sj97oGcVfoLBK90YZkAWKvCyCyfN5KdokVKYnPj1TIb8DzV/G8aV/aSM1Iu2sfs2O8PhgLO8EY6H+NfnWB3sefD5qFDCqxxU1mqw6NRN8fIKQ9/SPtfCUuNt9cEUILjUibHhCCY9zf+CrSBa71JM+jz9wGsopvneEtwhQemOocQx/aLmjwMQvjwXMGdicc57Sx9Q6f0Q/X21bdSdpILPgvxeomIJKT5XIoZXpXsVspZaJpyagyqOoRojkx+3VT2zb67ghgq5rPUSVbjktif23V5qeruRgh4356K/l6U4TqagcqaIf6Ll2JNAiJmbMVUotzeWXN7C8CKqe24SvL8QlEu6kV+xoelkQMFoH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:46:19.0130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6621addc-6d7f-467d-92b1-08deb5b56335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257



On 5/19/2026 12:25 AM, Sean Christopherson wrote:
> On Mon, May 18, 2026, Yosry Ahmed wrote:
>>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c

>> So maybe something like:
>> 	/*
>> 	 * PML is never enabled in hardware for L2. Make sure that an
>> 	 * unexpected PML write would trigger a PML_FULL VM-Exit.
>> 	 */
> 
> Hmm, I was going to say we should drop the code entirely, but I do think it makes
> sense to set PML_INDEX to -1 to ensure a VM-Exit occurs.
> 
> Actually, even better idea, at least for nVMX.  Rather than write '0' for the
> address, which is what I really dislike (bad past-Sean!), we should write -1ull
> so that unexpectedly enabling PML in vmcs02 results in VM-Fail, i.e. don't even
> rely on the WARN for safety.
> 
> If SVM has a consistency check on the address, then do the same, otherwise I
> guess just go with setting pml_index to -1 and WARNing on PML_FULL?

At least the PML spec [1] doesn't document a consistency check on PML_ADDR
during VMRUN.  I'll confirm internally whether one exists in hardware.

Till then, will go with the below:

	/*
	 * PML is never enabled in hardware for L2.  Make sure that an
	 * unexpected PML write would trigger a PML_FULL VM-Exit.
	 */
	if (pml)
		vmcb02->control.pml_index = -1;

If it turns out a MAXPHYADDR check does exist, we can switch to -1ull for
pml_addr in a follow-up.

>> Annoyingly, the unexpected exit reason handling is in
>> svm_invoke_exit_handler(), but the guest mode check is in
>> svm_handle_exit(), so if we do that we may need to move some code
>> around.
> 
> Why's that?  Oh, if we want to reuse the unexpected exit code.  What about this?
> 
> We don't even have to document the same thing in two different places, because
> the reasoning for nested_svm_exit_special() can and is different.  E.g. even if
> we decided to utilize PML while running L2 (which would be possible, we'd "just"
> have to translate the GPAs), the exits would still need to be routed to KVM.
> Ditto for if we did actually enable PML in vmcb02 on behalf of L1: we'd need to
> remove the check in nested_svm_exit_special(), but not the check in
> svm_invoke_exit_handler() (though the latter's comment would need to be updated).


Will add both changes and add in next version.

> diff --git arch/x86/kvm/svm/nested.c arch/x86/kvm/svm/nested.c
> index 4ef9bc6a553f..401a0ac44018 100644
> --- arch/x86/kvm/svm/nested.c
> +++ arch/x86/kvm/svm/nested.c
> @@ -1782,6 +1782,13 @@ int nested_svm_exit_special(struct vcpu_svm *svm)
>                 if (nested_svm_is_l2_tlb_flush_hcall(vcpu))
>                         return NESTED_EXIT_HOST;
>                 break;
> +       case SVM_EXIT_PML_FULL:
> +               /*
> +                * All PML full exits are handled by KVM.  KVM emulates PML in
> +                * software for L1, but never enables PML in hardware on behalf
> +                * of L1.
> +                */
> +               return NESTED_EXIT_HOST;
>         default:
>                 break;
>         }
> diff --git arch/x86/kvm/svm/svm.c arch/x86/kvm/svm/svm.c
> index e74fcde6155e..6bcb191d725b 100644
> --- arch/x86/kvm/svm/svm.c
> +++ arch/x86/kvm/svm/svm.c
> @@ -3635,6 +3635,13 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 __exit_code)
>             (u64)exit_code != __exit_code)
>                 goto unexpected_vmexit;
>  
> +       /*
> +        * PML is never enabled when running L2, bail immediately if a PML full
> +        * exit occurs as something is horribly wrong.
> +        */
> +       if (unlikely(is_guest_mode(vcpu) && exit_code == SVM_EXIT_PML_FULL))
> +               goto unexpected_vmexit;
> +
>  #ifdef CONFIG_MITIGATION_RETPOLINE
>         if (exit_code == SVM_EXIT_MSR)
>                 return msr_interception(vcpu);
> 

[1] https://docs.amd.com/v/u/en-US/69208_1.00_AMD64_PML_PUB
