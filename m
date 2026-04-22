Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012051.outbound.protection.outlook.com [40.93.195.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF292C3245
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837590; cv=fail; b=LZ3qZmjNy9so2HlnQbiQGqYG/jtBImj6cyih9RwwKigbIvM4lJnttBqNRAhQXrmBHQhnLIoYClrD9bnD8dRw+TPFwshoVtWYrf7qIAdfL7nTZNpxJ1NvRNet6P0I9v2DEsc9hVyhDZOwCFJV0fcDvY+SjmmvjvxRKYwDLgcCmZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837590; c=relaxed/simple;
	bh=x2EHhfgxdtdHBq2uYMDDNvfq2ypbx3DCOpoXqipmdnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j3Sp2qlaOel0sR5TS0E8qdmZuXWaJaUD9mtdBMParExjDVseXr0E7mw26su5plUZ4ozLI3iFBQZ//6VK5tV+Rw0i94AOCI2+8Gaw4pLIza+ZACIx4W9ZQIFogy+bLneL7RAzYDEpdKdIkhF3xCjgOlmh1zHh7HN9RRSQ01b1vx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ce1cJ+ti; arc=fail smtp.client-ip=40.93.195.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ce1cJ+ti"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5OBh/41WEn/I6MDcYUWaV8DVNWQZSbyUwam5CzLkkji4Q5LEOgzPyaYVKkhyqlbLvCLLLJyyHg+Z1/RsuS4YMAYF0vMP5cg6Fj65MnJCRJZhUIgWVi9NgUJr3FW4LBc8526mkReZLjEIbJHAYTPv9CHQa5UqJ3hjedSCzaICZdrblNsM2SoKrrY14AsPIWcGjges0pUI0PpBDa68omex3Y0O7hIurz2JC0h9Kgw72+/F8FTJcXZ5+UTay1+psV7tlIWzZ2JfC0WJQ6FCCa9Sa2kqC102u2rAqXF/c22W+nVOfVYiQlHIU1AcjwgJDXue0thOI7Fi2QmPns1GZ9T+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agOayvFZEid8inTqrRf9f3SHMMnuu8PEfU7ZNXVbqhA=;
 b=OoFkJF1kYRcAs/FOrQIkHUoR/EMkHOSovl6AeOYVVafsDUVrV07PYSHv29+QJxlXDkhJyrvX7ce4ZlCBnQn+Sjb+4+UDUqoB2Rl5nJ6ZCS4dPq3Nfr+4g8+aR/bN+Ju1GA7DJ3AMraTAZE7lImXX/jewH4VmPQI1OoOytt//TRlSvikGkNaRo7vRcw9v8SK+RfY2iwg8GkSybR1+1zirN6AsitSZ4s/kH19041dScUQBX2xzQ2ZnAtQXKC5/dKYFhm4c92Udyzk6IIaE3rbbLFFsyjA7JACJirYL0Ms8ji/ok5a2Q6lElszpYDgGXuIAZkFb7iK/QyMkqAjJeHN6SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agOayvFZEid8inTqrRf9f3SHMMnuu8PEfU7ZNXVbqhA=;
 b=Ce1cJ+tiH9VOfRtYDMhOdFSXCYDaJSSR92/QrNe0EONmtIQOXJhMdL5qrXkT9WioloV+pZzxl3RuUq033g0zaF/rV7SRki4YUoWCsc5F25YJYh3Gps5hfBtD8xlMCGmg7MC1IN3ZxdGxLv0+gBHfu+FsxbQpRnkMKY/hlY06KG8=
Received: from BN0PR04CA0187.namprd04.prod.outlook.com (2603:10b6:408:e9::12)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 05:59:44 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:e9:cafe::d8) by BN0PR04CA0187.outlook.office365.com
 (2603:10b6:408:e9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 05:59:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 05:59:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 22 Apr
 2026 00:59:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Apr
 2026 00:59:42 -0500
Received: from [10.252.210.85] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 00:59:39 -0500
Message-ID: <889e2e42-38b5-40c2-8ed7-f13346901fef@amd.com>
Date: Wed, 22 Apr 2026 11:29:33 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
To: "Huang, Kai" <kai.huang@intel.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "bp@alien8.de"
	<bp@alien8.de>
References: <20260407063245.2755579-1-nikunj@amd.com>
 <20260407063245.2755579-8-nikunj@amd.com>
 <34cfe5e8-756a-435a-a73d-54bf69801161@amd.com> <aeeS7LDPJ6NCy3Uw@google.com>
 <3e4641288d7791919abf1a5b02b80431285484e5.camel@intel.com>
 <aegWmKk8uK5r10dM@google.com>
 <977e805339a29ab789650aa18cd320dd1e9e0c25.camel@intel.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <977e805339a29ab789650aa18cd320dd1e9e0c25.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: nikunj@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: a75e15fb-e4b3-4753-052c-08dea034598d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3oWPXTXe4NczZ3s5dgPg/hCh1GH48fj6KJVKFUxqL58LnMQJ5Wa0c58K5iP37J627nybd1bW5R9tChUl+6n8QwMJsTcoQCXEzFf+PQzV3G8Tb801i/UhJXt5UPwTPohmmZ1GATvfPqY2O4uCT1DJXLbjua59FK9phrweER2A8QshcztkrrdiX1qHhdsOvmcvrl0fxajLkA5W4w++M8t96LgmBqw7HRfVsB148ZpV2FiOSQr9eDEPcQTocnqQZP7u3XaK43f9hBqAK48UQmpJb22ayBx2N74HgKhBYAtGoKJfKEA6xz/CuUPDJmVkd5OFAIeEWBJJSx8agNIs6BvEL8WMTSwjdR3/OnP1aiUEkm8G3qnFxZOPcaqro97qiHTZCF8InDenPC4EklIxUa8Apwu2s5hQGxdyK3ba8CZZ6zJPBHRk/L4mrYs53w6529Ry+UVybNbOgkRUjw2kCREt4A1VJvNzAUPTIiOsAILPYjX5FgUE3rZkf28hK3B0r45q3fB3JR67NaC61iazNcV1rd4srY3q5cOZw32Bx7lKYIKm8rc+2VfD8mGChA6Qz0kuGUxx8SW65VCylx10BRoZpfBAiRZIl+cZCbVC4/I4fT23uU++61vnG0TxwrF/layJ/zDdf5WXROzS6QJs79xfUrUGulPt1KWmPOJJHfs8kgvVCImfFnB7T4q60CoSPUOC7X7wBQw5ptOAe40TQL2nogH6qHVv1/YZfHS8H/pP76TLGdUdW0DR8fQXdBSMnmHmfXZsg8rTJl5wVGPDAGjAxQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gwFTcAGRSyszFFyGSgEHH6opuxZl7josrHA58iQI8Y8BFq0L0LNLEEQ8y7lO8Ph9AaM06rz6SvO/YLAnxzAD6kxWGAku7j4w2qY9pXJdnvuLbLZJnt0fdXdI67XzLiOc8tcDzrcC/7hIOQDXmN9l4Lj13w8r3KTsbA93OX0GlWr0eWdsGuodB4CH7Ioh152kYQUSHA6/2xYo4v+IwERoLBwthooWGxBrnwULG0WXDbD+QR+9NoHShNW5AvvaQieRoiaF/UpodtaBp102XI+47SAYiLaj2TaRIz/J4a3a3/Oz4s/jGZUBeH9MwfhxP44Tdq+xVZzq3QFjD9QdtXnVhEfeJHyry9W6DnT2v801vIcf2h5TOw6pphKh7U5osN2PRLPUveCNnohgTky6Cc0gdfWTRr+j/5rPYKkJ+fcuq69kOylXdq4We8Yuy1djWouC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 05:59:43.3926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a75e15fb-e4b3-4753-052c-08dea034598d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193



On 4/22/2026 7:12 AM, Huang, Kai wrote:
> On Tue, 2026-04-21 at 17:30 -0700, Sean Christopherson wrote:
>> On Tue, Apr 21, 2026, Kai Huang wrote:
>>> On Tue, 2026-04-21 at 08:08 -0700, Sean Christopherson wrote:
>>>>>    vCPU Reset:
>>>>>      vcpu_enter_guest()
>>>>>        ├─> kvm_check_request(KVM_REQ_EVENT)
>>>>>        ├─> kvm_apic_accept_events()
>>>>>        │     └─> kvm_vcpu_reset(..., true)
>>>>>        │           └─> init_vmcb(..., true)
>>>>>        │                 └─> control->pml_index = PML_HEAD_INDEX -- PML buffer was already flushed
>>>>>        └─> kvm_x86_call(): Next VMRUN
>>>>>
>>>>>> Could this result in the hypervisor losing track of dirty memory during live
>>>>>> migration, leading to memory corruption on the destination host, since
>>>>>> svm_flush_pml_buffer() isn't called before resetting the index?
>>>>>
>>>>> AFAIU, no. The PML buffer is always flushed opportunistically at every VM exit.
>>>>
>>>> Huh.  There's a pre-existing bug here.  Commit f7f39c50edb9 ("KVM: x86: Exit to
>>>> userspace if fastpath triggers one on instruction skip") added a path that skips
>>>> kvm_x86_ops.handle_exit(), and specifically can give userspace control without
>>>> going through vmx_flush_pml_buffer():
>>>>
>>>> 	if (unlikely(exit_fastpath == EXIT_FASTPATH_EXIT_USERSPACE))
>>>> 		return 0;
>>>>
>>>> 	r = kvm_x86_call(handle_exit)(vcpu, exit_fastpath);

Ah right.

>>>> Given that SVM support for PML is (obviously) on its way, it's mildly tempting
>>>> to add a dedicated kvm_x86_ops hook to flush the buffer on a fastpath userspace
>>>> exit.  But, I dislike one-off kvm_x86_ops hooks, and that only works if there's
>>>> no other vendor action required.  E.g. very theoretically, a fastpath userspace
>>>> exit could also be coincident with bus_lock_detected.
>>>
>>> Seems vmx_vcpu_reset() doesn't reset PML index upon INIT event, which seems
>>> to be fine since we are not losing any dirty GPA tracking AFAICT (otherwise
>>> we already have a bug for VMX here)?
>>>
>>> How about doing the same for SVM?
>>
>> We don't really have that luxury.  On SHUTDOWN (even intercepted SHUTDOWN), the
>> state of the VMCB is technically undefined.  I.e. KVM needs to write _something_.
> 
> You mean KVM needs to reset VMCB to reflect the architecturally defined INIT
> state for a vCPU?  Or the hardware itself may reset VMCB thus may reset PML
> index?
> 
>>
>> Hmm, actually, how is that going to work?  Dropping PML entries just because a
>> vCPU hit SHUTDOWN isn't going to fly.  
>>
> 
> Not dropping, but just leave PML index unchanged.  The PML buffer itself is
> still there unchanged, and PML is still working in hardware thus the buffer
> will eventually get flushed.
> 
> This is the case for VMX AFAICT, thus I wonder whether this also works for
> SVM.

Theoretically, while the migration is active and we did a fast path user space
exit and never returned, the entries remain in PML buffer. If we flush every time
on VM exit, as per Sean's suggestion, PML buffer is always flushed before returning
to user space.

> 
>> E.g. if a VM crashes while it's being
>> migrated by the host, then it could end up with corrupted, incoherent data on
>> the target due to leaving dirtied pages behind.
> 
> If we leave PML index unchanged upon INIT as mentioned above, I don't think
> we will lose any dirty GPA tracking.  But maybe I am missing something.

Regards
Nikunj
