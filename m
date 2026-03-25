Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C1F2E401;
	Wed, 25 Mar 2026 05:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774416183; cv=fail; b=HZ0pbMS+cTdZByyiBWeAka0ZZgMn5cE/FUwWvJT2sNBYI0wD9Dnqi9MjH9pRwryNPa2Ju2ptb8v5DAf8UkNmxnq702opLkwO2Pkn57V+6CMte5WCuP+xzeolsncVbtiYf9JmVDhc5VZ2caP59LXtP9kHYLA2e1MqZhXB1Utsq34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774416183; c=relaxed/simple;
	bh=FHWlnez6iyf5+YCESRXOgQ4TorwZCGL7u6knB1iYTo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pgnpHtyWjKk3CeU7rOIP2aoiCnKg8tNlg817T+DnTeYLc5Bv8LBTAketqUXRZwG0mWkVlERkGwNZy6qnlQ6pajuqRR3xPiHP2gfNw+yWy3jKwiUip3H0C0AqOCctKl+5y6qZGCbjaTUYThjk21oFDgZx0wElX3IvzqImwlhIfRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A7yCy5GR; arc=fail smtp.client-ip=52.101.48.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A7yCy5GR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWtnMjJ30lGVXw7qRudszH/gNyPU+AWmJEb6mPo2NdS70OC5ORlWM+tm6oLpE5NdLOjhSN9RS8kg4fZk2qoqUqD9SVhNl2zPUrGUmJTGA2YXESpgOOm2E1wAsSixIqgbcdE3lwo/GbUxofWxLsNVEgYNMFkdVerOf3nrJpK6TtS/bVJO/Velf60N2GJTJ7VUsrsmDi9Kzz6GSQGrJQoMJX95ParUl2sylcRbNMZRYVGgzfXlIFA9NsxFfhB4I3leJaCbTcCcns0Lan4fGz9cqwqn5Snu59zwTJ1g0Dc66ybKZ+Wo1kG+uRrXX5mGlhRiKgAsQQy9QEJ7Pwr+U1t9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0g4CXs3qOOnGwCxdRdsN5M8/LrT7ynXzSAe1hpKqpw=;
 b=kkcJCvMnTTfrxDKELp9IXsz94H5+WOaBYJHjvI6oa+Sx+toadaARegneRSfZEM2As8CJ0O/vr2fa1C+8YEBvXflz9oD+qeX+wuaDgMfRM8SiRSAbaT9pKh6O9rmyxUnOP4dkRARI/N6ChrKh9NBp0pGaDVkOwoNBkwf6Lq2eb0joBDXcrM0JCkOD0YAY571EJXIFX7uM3Y+Ngg6oTpnRDaMBsbJTOldGgzrmUouoD+Cgl0djhXXZGUMakNJws9Q24q2jqFzuYgU+oACc7kWSUrkRyfXpn0qzidSahbLfxAdk+I0oztIrJ5R343UPAb7uBWRANC8TFuimE9Ikb/rQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nutanix.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0g4CXs3qOOnGwCxdRdsN5M8/LrT7ynXzSAe1hpKqpw=;
 b=A7yCy5GRF7Pfn651/FjECaYlC3Tuv4g9b30ug8qICigINHkCXnu4en7cgjOjD14fFnAHuU2WIDEPZgq+l78GeP/Ge3sFgXictHn3LtRZkWSzBqi23UVKlys4rPPPs25a1bx1Wx/TJ9GY9la2MxrAXxTNWMUb+xNExZIgIpJKKhY=
Received: from BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::8)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 05:22:58 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::10) by BY1P220CA0018.outlook.office365.com
 (2603:10b6:a03:5c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 05:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 05:22:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 25 Mar
 2026 00:22:56 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Mar
 2026 00:22:56 -0500
Received: from [10.143.206.35] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 25 Mar 2026 00:22:54 -0500
Message-ID: <c8304536-3274-4f6c-b844-04d6e30bc32d@amd.com>
Date: Wed, 25 Mar 2026 10:52:53 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/22] KVM: nSVM: enable GMET for guests
To: Jon Kohler <jon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Marcelo Tosatti
	<mtosatti@redhat.com>, Amit Shah <amit.shah@amd.com>, Sean Christopherson
	<seanjc@google.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
 <20260321000931.1947084-23-pbonzini@redhat.com>
 <721959CA-F869-457E-A410-694D205E8F0D@nutanix.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <721959CA-F869-457E-A410-694D205E8F0D@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: nikunj@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 59563b7e-17d0-475a-fedf-08de8a2e933e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	INe33133dHVhgld4hB9GuxpFkzaYa8Vf58w/AJWk/PRwQOZjceIDCTg88z/0kDikWFLYaDFYA8Ra5i0cTcHiVMB1LrAbyjXp/m6HTWEZ63Q5GFcyrlCNkaX9vVWDPfIESHvQxQa9v8jMxHjfqD7bzARwhXx1BnepXpHqFFqw+NCCLnlzltG3Vion3ZlmIneNw/05QsRFoZPrzqeNWAyLA/4LQT3Voto2tULuAIbL8c9luq46E6jpXIZ+UXVofTv1ty180sejd6loEZPC6NMWd2GGXa/fCCBgOGWxZfSJicZsmT/e0z0D3kBqlLjuz9gCsmxgFalK/Z3Z33Yo5xwbYmnzaMBtNspGCFe/xbv5sURzVaNE62kegj7WfyISnUkyalEN0QHknGIoo4Vi7KoP/xfQn32Bu9GHVBQPUizHjLpi5xX0ViDTr0ElDD53ud9XOjYfhzQudvLOgRWXTVIR3ia3RhshSca7wn1E52cHhobmCE88BBA+lTdF3/prn7551J5+y1vhsfUSQjmyYbjOqrc+mw19wcOVQwlnPb5BkHomsB1epiLSU3dwj6jLh6AofGe017qry9Me1EHV3fb5baNTlP7Oroe7/1rZrALtDGrtunrDoLQyyDlMwv02QbAOHx4wKVXDl7CeQ/tg0Jch5Re8CWk9ILvEBoYTlmUOsPSIbsqH+DE+lfZUlR4PSqNEU/AYXB21VI6pq9BEuAwIlaAk2lwzzDYELpju8X5s4uxrTMMPspkodxx3SNlkpPPuUmcL/Vzkz8JqR2+BbaD5Rg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FRuP8nGFveVD9PPmKlVslaZGNpeW7vbptBKjoJ2vROY5Dd7v65XrPYjLEkFWjvpRTtTEog2uIDRVf6FDJfeV6TWlFZxNT1MwcXz0ZLlCM68bxnjnt3i9C7QEvF/+znYit8z5LI/nEIEFafBB6yBFF2MeBCOfkMuxGXL1DDvbVXavDhijLqWchhKSdGru4OT8EXXINP3aUwcTcfAeFuDnlZTTa2cgcA2rHPyvFNCkH8H/Re+GVbbogM/EBXZ2xt0gFqRetKVm3EebXZCHKFnOmGfNfckH7kp3NjG0C/wOu50ZHr545Q2T9ESr/OwDaX0tKYoXw364Z846zWGojxCvKFPFuns4qhiKUbHFloltSjV925AIZthQ+nk08AbGrF2WX+eGLfaCHMngSYmY3rSQSszPvZN99+o+jgY65MZxTl/JSVao69Ft9OWU6n1JgLPF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 05:22:57.5347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59563b7e-17d0-475a-fedf-08de8a2e933e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813



On 3/25/2026 1:27 AM, Jon Kohler wrote:
> 
> 
>> On Mar 20, 2026, at 8:09 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> All that needs to be done is moving the GMET bit from vmcs12 to
>> vmcs02.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> arch/x86/kvm/svm/nested.c | 3 +++
>> arch/x86/kvm/svm/svm.c    | 3 +++
>> 2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index d69bcf52f948..397e9afecb78 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
>> @@ -774,6 +774,9 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
>> vmcb02->control.bus_lock_counter = 0;
>>
>> vmcb02->control.nested_ctl &= ~SVM_NESTED_CTL_GMET_ENABLE;
>> + if (guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
>> + vmcb02->control.nested_ctl |=
>> + (svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_GMET_ENABLE);
>>
>> /* Done at vmrun: asid.  */
>>
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index d3b69eb3242b..4a0d97e70dc2 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -5294,6 +5294,9 @@ static __init void svm_set_cpu_caps(void)
>> if (boot_cpu_has(X86_FEATURE_PFTHRESHOLD))
>> kvm_cpu_cap_set(X86_FEATURE_PFTHRESHOLD);
>>
>> + if (boot_cpu_has(X86_FEATURE_GMET))
>> + kvm_cpu_cap_set(X86_FEATURE_GMET);
>> +
>> if (vgif)
>> kvm_cpu_cap_set(X86_FEATURE_VGIF);
>>
>> -- 
>> 2.52.0
>>
> 
> When I enable gmet on the guest, and try to boot with memory integrity
> enabled in Windows 11 25H2 guest, the machine does not boot, but rather
> gets stuck in an NPF loop and does not make any progress.

Same here as well, trying to debug

  kvm_nested_vmenter: rip: 0xfffff8148793c2ea vmcb: 0x00000001087fd000 nested_rip: 0xfffff81487993d90 int_ctl: 0x00000000 event_inj: 0x00000000 nested_npt=n guest_cr3: 0x00000001087ce000
  kvm_nested_vmexit: vcpu 0 reason npf rip 0xfffff81487993d90 info1 0x0000000200000006 info2 0x00000001087cef80 intr_info 0x00000000 error_code 0x00000000 requests 0x0000000000000000

This seems to be the first entry into the nested guest and nested page fault is on guest_cr3 page

  kvm_mmu_set_spte: gfn 108600 spte 39ac00ee3 (rwx-) level 2 at 3012b1218

A 2M page is provisioned in the NPT

  kvm_nested_vmexit: vcpu 0 reason npf rip 0xfffff81487993d90 info1 0x0000000200000007 info2 0x00000001087cef80 intr_info 0x00000000 error_code 0x00000000 requests 0x0000000000000000

But the fault keeps hitting.



