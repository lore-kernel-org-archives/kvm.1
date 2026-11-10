Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794310233;
	b=ZzodYwGt+CHSy022FhNYWqxUPRJNZXyiCUN60YOjLXHn3khJ5fsYFFZwsmJ1QRUvgkFY
	 Z7s+8HihC1S6GTczaaT5L/vFOIqDTrVGxUBUfgvrs7N/aV9tTdQkCvB0MuYa4ggbqwadL
	 N6p6pzcHoC7y+UFQS8ELjMn9qSrWDwUR8txF+KzCZqqJQMleB34QnUgELjtBuow88z8OD
	 SzUmUBTtjFZHotBlHIZV6TVzSfAM6WwRBESQ/sbSK+FsmeF9UvurqujMmOyuoNoHh2xB5
	 VTkpA7y9r9d1NhW15nzkIXPDf9H5amfNiJux7TY5Z5xxI47psXab4myrViJ8MZo7fTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310233;
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
	bh=bLz1iOD0oef+Yz6taD9bKYocjt3emrbb+TnfFnOafm8=;
	b=qIWLVXntjxVoeSRrSyWYioQLFnFoC8gWgaW4B4OgjhJRP3R50199p1NNSU8Scx8XdLqh
	 jdf7Gr8G56k3EOSY0Ap+LhZJnd7loIB5fZXAtSX0m0AMGvrcUYFAd7OB4Nv4R+h3UgB2H
	 G8QtVV+Em+7+4gPqEWc6p2e3/IZvnPtEURzLnZx3+pej5+2nWTuW1dJ0GH+/xdNQXV9p6
	 6ZKVG/PxD7Cg0aU1hfmmEkx90tNwDzRNSlmVVc98wLoveOTQDQgdFV71OUZdKGVwD4AJ7
	 wHsv7BY77zVTw9rOwkacejA83Y9U4lbSDq1jPIYt75K8rrM0JN+TIEIsF2exB1KtbUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1rqEntWq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.5
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011005.outbound.protection.outlook.com [40.93.194.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E4460A2611
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 11:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6E4460A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1rqEntWq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHj1Ni5mrUKMxoWACXCpbRZvkTkL2r/WwORw6PvRX4v2O1LgpuxP7r6Hwk9oozZLBg1e3EUgyXbwAIaS7yk0A3U6gtBjExAhPqTNAFO1lmaYNo4j82PPE/o1g1GvjRCGFcDwWKaSQ+/5iTvBdceSymwg/DhITG1M7r/lxUMGGQG3XE/AMxOzlY3iTkQqlGBCPXOYJj4DO1EN4F/23rTdCsgi2rylXs3BrS/0jMhcxIEaZwEyq4UJn/orFM9I45i6dITBXHHnNKq5UwlpYlAkLmMCn+sjZ0PhD4rZHEy1UcvoHD9g+AxFWH1dD1ELo+58MyoMwOhIK/rXcdPkSq7fmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLz1iOD0oef+Yz6taD9bKYocjt3emrbb+TnfFnOafm8=;
 b=a2tBBzIG8Qbwbl++ga7dYmaNns1NwtEuQ/D4b7iHBqDVVafarqQz45/mC2lJ6KJa6LW42DlJhDcIrTvZ0cWDyVAPAJmQXxNHCrb1y5QLBqqppfeZdaNGeJo6P3zq9MZMDSc8ZOhS7leZZs5L1a99JJhhu/EqxkJHN5RJOSXfPgXM5QC2BBivhAcOXTqnhyylw7qXQrS0Tr5baXxZoQ3Y37wxJPNbgoQaJd7DIyUf0h1v9N9Lsrmw0OVHwgUqUQjJT9yHdsXdelKiridXas2IodEDV50iQtx3pOLjHijz83Qcd/WmkLDdmZP/npvSosoAQWkK2C6hHsmch3LSpPEfoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLz1iOD0oef+Yz6taD9bKYocjt3emrbb+TnfFnOafm8=;
 b=1rqEntWqGzGmESgwZqIy68UivZm4/B0Wta/c4uB+SbjKo1gMYwrKFhFYou+4AK4n8hb0wVyQMtjGJQZlsRNZ5YJ+5Ckg1m59QCWdSK8eYCTYHgHFsFX/Wi03Unav2gujggLAmy4b98QMOVuPwDAI3/f6JmUSvxUF1g2AS3qFSHk=
Received: from MW4PR03CA0252.namprd03.prod.outlook.com (2603:10b6:303:b4::17)
 by SA3PR12MB706199.namprd12.prod.outlook.com (2603:10b6:806:53c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 11:30:30 +0000
Received: from MW2PEPF00014674.namprd04.prod.outlook.com
 (2603:10b6:303:b4:cafe::ac) by MW4PR03CA0252.outlook.office365.com
 (2603:10b6:303:b4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Tue,
 10 Nov 2026 11:30:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW2PEPF00014674.mail.protection.outlook.com (10.167.249.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 11:30:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 05:30:28 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 05:30:28 -0600
Received: from [192.168.29.87] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 05:30:22 -0600
Message-ID: <a156f924-a430-47ff-9fb9-22723acccdfc@amd.com>
Date: Tue, 10 Nov 2026 17:00:21 +0530
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
Subject: Re: [PATCH v3 6/9] KVM: SVM: Add support for IBS Virtualization
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <mingo@redhat.com>,
	<bp@alien8.de>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<santosh.shukla@amd.com>, <nikunj.dadhania@amd.com>, <Naveen.Rao@amd.com>,
	<dapeng1.mi@linux.intel.com>, <ravi.bangoria@amd.com>,
	<peterz@infradead.org>, <Sandipan.Das@amd.com>, Yosry Ahmed
	<yosry@kernel.org>, <manali.shukla@amd.com>
References: <20260310060022.15120-1-manali.shukla@amd.com>
 <20260310060022.15120-7-manali.shukla@amd.com>
 <20261008191950.816113-1-jmattson@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20261008191950.816113-1-jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014674:EE_|SA3PR12MB706199:EE_
X-MS-Office365-Filtering-Correlation-Id: 5528f4f0-3e3d-44c3-97a3-08df3f1e0654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|36860700016|82310400026|11063799006|4143699003|56012099006|261021123027099003|261022075727099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Adtwqgw05vSZ0fR354YBMr5VSlEH1xgyAmc8gI8oiDsy/KKir32g5DA08MeopBPuElBiKfp3DB+m/1C5Fha2g2THi7vlOyUJnOr56YVhusHHtPHIgNGxO8HMnZK/OthkW2wql+z4wnRKZL4XnQrT3plkczKt6GL/POS7S48IgiPCB/Ldf09sY65eDa5RaxHG5706lz237y8bj530h6TIN6rZs/afjZXnvg7BSomIhUWrR4MtBt7d6mHUL+QyQ16ysZk3C3pkLZ7Jl81SXiP3QBlCmtdTS9joYIP8FXAFvqTLm4TtCbiCNXi/gjU5LHueC0GB19vdPtQ5meEPbQ4Sf0A0aNbngratPnpF2YHSwgoBqBhDhGQWL7Zftvb0u6Xql0eo9vW8KdG79Mi/FgFXsmpN2dhO259AOr3cCJD+oRD35m+8/mCTqTPmwUQQnJHzvdVzd/lD5ykAgJNIzYrdfuzLU1n8OHVymRuxBYYTXSfXiOK7u1HwP6baymSU/UKc0j+zQA4XPYdQT2YhcoG0x8Xj/Ziha62OuEP8VXhRgfh9F/1+IATFKnid6d2HYWKrWrkoAa1mNE1apHqKCdz8wbLTTSRuQesOhPc4cYRMQdnrd2fpj4zwcv8w3+rp6vZg96MnPQHLkk7fniK5BluGfw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(4143699003)(56012099006)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3UawY6VRqtOS2fZYSfKbMnIMRe0UMYCSn3CdE1gOwY1Kx/iPstdo5MjsPUPpHB4h1UcIr3h8BhCF7kA566pjd2akHD8GdX8Cst4KbplfOcQBZQgunQDY1EYd/Bpkir3zEVGig4Aevtd8lBqnbGhmy9MViE3eajuyU0zhpsCN9u1tVnETxTltznLEzpMr6bckNtEos1wAytj5mOfL95sRG+x2+RbYC4YNZCX6OfBNouA6N3zpHohO4VFkwcOBt16+lyeEXRx1bWGo4QCwNqGd8BN8dt2VL9+9Pks/AkGRIrntILE6lihW3LgOcyJT5I5OnAojGBd5xJKR7VNj//KhafRwWLD4IOSGye3Meqf+EndYcy+n2WBYz3KddLow+9mAtCSAoZ6kW7gTFs1gx0QlYDywRoOUdZ22V5AFZk3KKIsIdFCkLgFl9Y6kz98lgJxz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 11:30:29.6313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5528f4f0-3e3d-44c3-97a3-08df3f1e0654
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014674.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB706199

Hi Jim,

Thank you for reviewing my patches.

On 10/9/2026 12:49 AM, Jim Mattson wrote:
> On Tue, Mar 10, 2026 at 06:00:18AM +0000, Manali Shukla wrote:
>> From: Santosh Shukla <santosh.shukla@amd.com>
>>
>> IBS virtualization (VIBS) allows a guest to collect Instruction-Based
>> Sampling (IBS) data using hardware-assisted virtualization. With VIBS
>> enabled, the hardware automatically saves and restores guest IBS state
>> during VM-Entry and VM-Exit via the VMCB State Save Area.
>>
>> IBS-generated interrupts are delivered directly to the guest without
>> causing a VMEXIT.
>>
>> VIBS depends on mediated PMU mode and requires either AVIC or NMI
>> virtualization for interrupt delivery. However, since AVIC can be
>> dynamically inhibited, VIBS requires VNMI to be enabled to ensure
>> reliable interrupt delivery. If AVIC is inhibited and VNMI is
>> disabled, the guest can encounter a VMEXIT_INVALID when IBS
>> virtualization is enabled for the guest.
> 
> APM vol. 2, section 15.38, disagrees. Without virtualized interrupt
> delivery, "an IBS interrupt occurring in the guest will not be delivered to
> either the guest or the hypervisor."  The only VMEXIT_INVALID that section
> 15.38 describes is for VMRUN of an SEV-ES or SEV-SNP guest with IbsFetchEn
> or IbsOpEn set.

This is what I have observed: when I tested IBS virtualization with
kvm_amd.avic=1 and kvm_amd.vnmi=0, VMRUN fails with VMEXIT_INVALID
whenever AVIC is inhibited. The APM might have missed mentioning it.

> 
>> Because IBS state is classified as swap type C, the hypervisor must
>> save its own IBS state before VMRUN and restore it after VMEXIT. It
>> must also disable IBS before VMRUN and re-enable it afterward. This
>> will be handled using mediated PMU support in subsequent patches by
>> enabling mediated PMU capability for IBS PMUs.
> 
> On hardware with IBS_CAPS_DIS, perf_ibs_stop() does not clear IbsFetchEn or
> IbsOpEn. perf_ibs_disable_event() only sets CTL2[Dis], and
> IBS_{FETCH|OP}_CTL[En] stays 1. Section 15.38 says that these bits must be
> 0 at VMRUN of an SEV-ES or SEV-SNP guest with IBS virtualization enabled
> (otherwise VMRUN fails with VMEXIT_INVALID), and that they should be 0 for
> other guests, "to prevent host IBS interrupts from leaking across a world
> switch."  Section 15.38 does not say that CTL2[Dis]=1 is sufficient. Is it?
> If not, the host must also clear En before VMRUN on hardware with
> IBS_CAPS_DIS.
> 

Yes, Hardware checks the effective IBS op and fetch enables in VMRUN to
a SEV-SE/SEV-SNP guest. And it is already updated in APM.

https://docs.amd.com/v/u/en-US/40332_4.11_APM_Vol1-5

>> More details about IBS virtualization can be found at [1].
>>
>> [1]: https://bugzilla.kernel.org/attachment.cgi?id=306250
>>      AMD64 Architecture Programmer’s Manual, Vol 2, Section 15.38
>>      Instruction-Based Sampling Virtualization.
>>
>> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
>> Co-developed-by: Manali Shukla <manali.shukla@amd.com>
>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> ---
>>  arch/x86/include/asm/svm.h |  2 ++
>>  arch/x86/kvm/svm/svm.c     | 73 +++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 74 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
>> index 4296efc1dafe..17aa6bf76bce 100644
>> --- a/arch/x86/include/asm/svm.h
>> +++ b/arch/x86/include/asm/svm.h
>> @@ -226,6 +226,8 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
>>
>>  #define SVM_INT_VECTOR_MASK GENMASK(7, 0)
>>
>> +#define SVM_MISC_ENABLE_V_IBS BIT_ULL(2)
>> +
> 
> This bit is in misc_ctl2, not misc_ctl. Please name it SVM_MISC2_ENABLE_V_IBS
> and place it after SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE.
> 

Will update it in V4.

> [...]
> 
>> @@ -779,6 +782,26 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>>  				  MSR_TYPE_RW, intercept);
>>  }
>>
>> +static void svm_recalc_ibs_msr_intercepts(struct kvm_vcpu *vcpu)
>> +{
>> +	bool intercept = !(guest_cpu_cap_has(vcpu, X86_FEATURE_IBS) &&
>> +			   kvm_vcpu_has_mediated_pmu(vcpu));
>> +
>> +	if (!enable_mediated_pmu || !vibs)
>> +		return;
>> +
>> +	svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSFETCHCTL, MSR_TYPE_RW, intercept);
> 
> For SEV-ES and SEV-SNP guests, section 15.38 says that IBS virtualization
> is enabled by bit 12 of SEV_FEATURES in the VMSA, not by bit 2 at offset
> B8h in the VMCB. This patch sets only the VMCB bit, but it disables these
> intercepts for every vCPU that has X86_FEATURE_IBS and a mediated PMU,
> *including* SEV-ES guests.  IBS virtualization is not enabled for SEV-ES
> guests, so they will be able to read and write the host's IBS MSRs!
> 

You are right. I will fix it in V4. IBS MSRs for SEV-ES/SEV-SNP guests
will be passed through only when bit 12 of SEV_FEATURES in VMSA is enabled.

> Since nested_vmcb02_prepare_control() does not set SVM_MISC_ENABLE_V_IBS in
> vmcb02->control.misc_ctl2, nested SVM has a similar problem. If L1 does not
> set INTERCEPT_MSR_PROT in vmcb12, vmcb02 uses vmcb01's msrpm, which
> disables these MSR intercepts. Because VIBS is disabled in vmcb02, L2 can
> read and write the host's physical IBS MSRs.
> 
> OTOH, if L1 sets INTERCEPT_MSR_PROT in vmcb12 and clears the IBS MSR
> intercept bits in msrpm12, nested_svm_init_msrpm_merge_offsets() does not
> include the IBS MSRs in merge_msrs[], so msrpm02 still intercepts them, and
> L0 injects #GP into L2 on accesses to IBS_FETCH_CTL, IBS_OP_CTL, etc.
> 

You are right. Both the scenarios are not handled currently. I will fix
them in V4.

> Furthermore, the guest's IBS state is in the VMCB save area, but userspace
> has no way to save or restore it. The IBS MSRs are not in msrs_to_save[],
> and svm_get_msr() and svm_set_msr() reject them, so KVM_{GET,SET}_MSRS will
> fail. Hence, the IBS state is lost on suspend/resume.
> 

Right. I will add the IBS MSRs to msrs_to_save[] and handle them in
svm_get_msr() and svm_set_msr() in V4.

> [...]
> 
>> @@ -2880,6 +2904,27 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  	case MSR_AMD64_DE_CFG:
>>  		msr_info->data = svm->msr_decfg;
>>  		break;
>> +
>> +	case MSR_AMD64_IBSCTL:
>> +		if (guest_cpu_cap_has(vcpu, X86_FEATURE_IBS))
>> +			msr_info->data = IBSCTL_LVT_OFFSET_VALID;
>> +		else
>> +			msr_info->data = 0;
>> +		break;
> 
> Before this patch, KVM synthesized a #GP when a guest without
> X86_FEATURE_IBS read MSR_AMD64_IBSCTL. Now it returns 0.
> 
> The condition should also test for kvm_vcpu_has_mediated_pmu(vcpu).

Agreed. I will take care of this in V4.

> 
>> +
>> +
> 
> Nit: there is an extra blank line above.
> 

Ack.

>> +	/*
>> +	 * When IBS virtualization is enabled, guest reads from
>> +	 * MSR_AMD64_IBSFETCHPHYSAD and MSR_AMD64_IBSDCPHYSAD must return 0.
>> +	 * This is done for security reasons, as guests should not be allowed to
>> +	 * access or infer any information about the system's physical
>> +	 * addresses.
>> +	 */
>> +	case MSR_AMD64_IBSDCPHYSAD:
>> +	case MSR_AMD64_IBSFETCHPHYSAD:
>> +		msr_info->data = 0;
>> +		break;
>> +
> 
> These new cases should be conditional. Before this patch, KVM synthesized
> a #GP for a guest without X86_FEATURE_IBS. Now it returns 0.
> 
> But, is this even necessary? APM vol. 2, section 15.38, says that when IBS
> virtualization is enabled in the VMCB, the processor returns 0 on guest
> reads from IbsFetchPhysAd and IbsDcPhysAd and ignores guest writes to
> them. Can't we just disable interception of these MSRs when VIBS is enabled
> for the vCPU, and let the hardware handle them?
> 

I agree. This is an oversight from my side. I missed to disable the
interception of these MSRs when VIBS is enabled. I will disable the
interception in V4.

>>  	default:
>>  		return kvm_get_msr_common(vcpu, msr_info);
>>  	}
>> @@ -3171,6 +3216,16 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>>  		svm->msr_decfg = data;
>>  		break;
>>  	}
>> +	/*
>> +	 * When IBS virtualization is enabled, guest writes to
>> +	 * MSR_AMD64_IBSFETCHPHYSAD and MSR_AMD64_IBSDCPHYSAD must be ignored.
>> +	 * This is done for security reasons, as guests should not be allowed to
>> +	 * access or infer any information about the system's physical
>> +	 * addresses.
>> +	 */
>> +	case MSR_AMD64_IBSDCPHYSAD:
>> +	case MSR_AMD64_IBSFETCHPHYSAD:
>> +		return 1;
> 
> Returning 1 does not "ignore" the write; it induces a #GP. But, see the
> point I made above.

Ack.

> 
> [...]
> 
>> @@ -4678,6 +4733,11 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>>  	if (guest_cpuid_is_intel_compatible(vcpu))
>>  		guest_cpu_cap_clear(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
>>
>> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_IBS))
>> +		svm->vmcb->control.misc_ctl2 |= SVM_MISC_ENABLE_V_IBS;
>> +	else
>> +		svm->vmcb->control.misc_ctl2 &= ~SVM_MISC_ENABLE_V_IBS;
>> +
> 
> The condition should also check kvm_vcpu_has_mediated_pmu(vcpu), as in
> svm_recalc_ibs_msr_intercepts().

Ack. I will add it in V4.


-Manali

