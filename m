Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27C3D1715
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790885944; cv=fail; b=WZBbmTgoPPSg1FUhxOE/5KahKMCnQNwiaWBvjuPpbVuw79rrRsxwhU4+ce6OMjnJE9bVFQRyQ8ABar4q5vKefxS2Vziel8JcwAQRkMIGwJl3JZNTgHTzJjisSnXUu6cGTx6UsmNsbCuGH9O1BlXoxmMlAY2J/+C6RQylBuHcg9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790885944; c=relaxed/simple;
	bh=v5/FCi3YU3ANTqJ7B5aokjuDx5tVm4ov+DM5bOF1qKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iH3bPI6ZpkfMiIhRKnT7RxrHYIdxmNXcAePTdiu0PsC1GQzHaPjVWDsxQVsuAYYo60g2/gWHhvFu7wjFO4+2Lv3caO9SwaGPm2VH46QbOVK89+G1Htf6Sw4BzNGZC7SVo63dzpongoJpdUfU/XNZ5zg8Ezn37LacOEHcbPIvNK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pmhappJX; arc=fail smtp.client-ip=52.101.193.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pmhappJX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFroOWIOiRCcGp1528IyvcYj4+1+g/kbMPaeMepUhFUDWUY/wsEO0OiilfupUeEFzxRqVqkV2ZgdvXmkjrIYcA4rPe3cbKwyyn49yJwv8EgEi0aUOxETvW+QDDn3meJ1M9khgAlovmh2k/9iCy9XoQ4HwRbnxE0+zXBdWfdYP0+wNKiwF25AFi6Y1CozjIM3HCWM2/u+7l6gKyRtlRXzizLY8NhkuYTojcu0XTZ8eJ3L5R4DugW26KzRy6n0yvtrICCOk93WorNNXihNk6fOQiPChEqIMf3L1iNHeyzI0LG1V1Kl7fvuvu7Hgbq/U0s5QzNhJ32kQzK4ZnPvO4qxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEha6aVrIh4PvXkKXDi5BOvauzvtd40276mgr/wRxvk=;
 b=R9JSI2TYGA0fKGQ2ob4dmct/GYLNzxWyGikyOiiSeIY6hWM2QqQGz8ATI3blkLoWw9tqb9Gh32AWjHximcDsb1Ym+FyIndKsCwr0h7sAlZrGc3IsvPYJCGa6tymbBvklE2yUlmOm+493gHTo3UmJpJ1XWihVi1utUoKd4YixeHd8ByUk0dD5z34GCBcsLd596t7JI7WukfIHFxgBQvJpJ4bp5tR/8wIock41gEWEpsnZndgjG0DP0F6/KGnF39Z7UxkyqyIMxLLpDqVciFiuzKp+2+9vGrKue16XoHmrgb1167W+H6kyV8s/WR3hXOSOTPb0I6fTxEvAiuQ8hZHVHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEha6aVrIh4PvXkKXDi5BOvauzvtd40276mgr/wRxvk=;
 b=pmhappJXN7CXr6uRuM3Bc1Cv2e9zUSeZBvJftvG4SnPz6bxaMenpbptlEUcabTaOHXkmsmfSlXHVvmed4sjy/o7d66M1uGvWx+WqqktT4EmPrr+uCdqo8UO5AONwKQFb95hNJvFYzWwehNBMy4ncdOt6g5wA9SGRQcxQgk7sgno=
Received: from SJ0PR13CA0092.namprd13.prod.outlook.com (2603:10b6:a03:2c5::7)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Thu, 1 Oct
 2026 20:18:57 +0000
Received: from SJ1PEPF000037AF.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::9c) by SJ0PR13CA0092.outlook.office365.com
 (2603:10b6:a03:2c5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 20:18:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AF.mail.protection.outlook.com (10.167.244.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 20:18:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 15:18:54 -0500
Received: from [192.168.1.13] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 1 Oct 2026 15:18:51 -0500
Message-ID: <e905df55-6d91-40f1-8761-6bcf600d8b7e@amd.com>
Date: Fri, 2 Oct 2026 01:48:49 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] KVM: SVM: Add Bus Lock Detect support and refactor
 LBRV
To: Sean Christopherson <seanjc@google.com>
CC: <pbonzini@redhat.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
References: <20260721050600.87268-1-shivansh.dhiman@amd.com>
 <arazNV7Y93gnflU2@google.com> <arb9YBIW8C5KXuXK@google.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <arb9YBIW8C5KXuXK@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AF:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dad58f8-9946-4634-9ac9-08df1ff9382c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|6133799003|18002099003|22082099003|10067099003|4143699003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	2XKjGizSV2w2K4g/FQiC22M2WpBZEdOVmy4JWLMqdqoZRfj5euKZSOteJC+yRR3Xz6ISTaXKSiuqHj+5Y8fELXTSnS2YC32+JUdt74CZOcAW2t+Q/4rdCF5UXxiUsy2NfiH3j74uiINy5UrEjx6CMqVGW+VeGQ1XA+EHyrHRI7dIU6kibRnS/Rsbly4U8moWCztsy9aFmM5MuJA3wiyVuIc/Axat4GRL2M5Y8mCYR2K8uPnDgRhdFUzHGSDMVKkD+SoQe7wX5zAv1cPMlAffAwmf/5tVP0J90BE8pguYMSBtCaNk29pa5Jz+Unw9Yrb6MrigVcVtVb2ac9e8Eo6Ekzc9m4M7H66E2qyylRqucOgMiOZECNwu1f1vRVSsAYTcq6pDdNSQVtaHzDHQmKdwYWEncm8znGInsMouZQEeZwtKEbCjheNvPu27shzM+z25fttWcYMfQe6RdI48tbdX4hvpVDki/x79QKrTf9GKKE3vug55rOuCVA67nxreTECTSrpsSYpzxtWFrRfEhkmfyOAiTTIW0MLy4ZULlNRs+JGoK6wT2b+KiKP5WI/9+BeVZ9ELE6mDOeQGAjcOqN7ue5F2kuz89wT70fzEupNzbOYCqsnTripnI7cm6qwCNDRqHel7ykzDoRu9AmU254vkeWTl1ZdJt12ZWzhvhZ/UYunFXI72nVZFo7cj4QNZ1XSBz4losqTRUPbqpzdLfpOghw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PmqnXG/bw4RyTvdEveHepooUQVJdqdSvoGUxWtxcRDBUblxeLAwWCNpnqTgZoHyP2UjkMPLzFpllhMBuKV6O7tWm1uxPDpDc2izrOS3/g4AHegi7txjSG/mX9t8+trxyog2/teNvQdM8ljsLC6CSX1n0U+NZ2/BeN5jqW2nW5mJRSPzBnOG2fdDtoadn7GJElAOL7tA8YyvvgL+KeU439N/pPQu2KKF6PEEkpQAz1S/EvAVhl8SHgy0r+Q3kCOlwnkVZCkbqX6FUvwatqu1c3cSdo4kl6HPi8B0ekQdp/B/em0fIMKCd+83PIDSAyLgvWsXV648Z2V3PC92kXQmcsDGok5Z0tzK07rmONa6a5Ls99KUe6pUMO9UNIediEzfw3VQp1z4ROMDyFnmnJAHd3X+x/AuIsP7rm+p9J8PGsCio+tfsW2HaocksBm5eR7Oj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 20:18:55.8408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dad58f8-9946-4634-9ac9-08df1ff9382c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536



On 26-09-26 04:31, Sean Christopherson wrote:
> On Fri, Sep 25, 2026, Sean Christopherson wrote:
>> On Tue, Jul 21, 2026, Shivansh Dhiman wrote:
>>> Shivansh Dhiman (5):
>>>   KVM: SVM: Refactor svm_update_lbrv()
>>>   KVM: nSVM: Disable LBRV in nested control cache when unsupported
>>>   KVM: nSVM: Sanitize nested DR6 using kvm_dr6_fixed()
>>>   KVM: SVM: Turn DEBUGCTL_RESERVED_BITS into a helper
>>>   KVM: SVM: Add Bus Lock Detect support
>>
>> I'll send a v5 as I have variety of changes (I already responded to each patch),
>> and I'm not in the mood to deal with another version as I'm quite grumpy that no
>> one bothered to follow up on Sashiko's bug report, or to write tests.
>>
>> I'll also post a KUT testcase, which I created to verify the bug Sashiko pointed
>> out as well as the fix. 
> 
> You know what I *love* doing on a Friday afternoon?  Debugging ucode bugs because
> apparently hardware engineers are also allergic to testing.  Or maybe the APM just
> sucks more than usual.   But the behavior fundamentally breaks virtualization, so
> IMO it's a hardware/ucode bug.
> 
> On Turin (the only AMD hardware with Bus Lock Detect I've tested), hardware/ucode
> forces DR6.BLD=1 if DEBUGCTL.BLCKDB=0, even on software writes and even on loads
> of DR6 via VMRUN (this last bit is what really throws a wrench in virtualization).
> 
> Software can still read DR6.BLD=0 if DEBUGCTL.BLCKDB=0, but if anything touches
> DR6, DR6.BLD gets clobbered back to '1'.  E.g. if the guest gets into a state
> where DR6.BLD=0 and DEBUGCTL.BLCKDB=0, then AFAICT *any* #VMEXIT will end up
> setting guest.DR6.BLD=1 on the subsequent VMRUN, which is just a wee bit problematic
> because it means asynchronous #VMEXITs, e.g. for host IRQs, clobber guest state.

I reproduced this on Turin with a small KUT test and a trace_printk() of
VMCB.DR6/DEBUGCTL around VMRUN. In each log, the first #VMEXIT (0x26) is
the read_dr6(), which re-executes after the VMRUN.


(1) BLCKDB=1: DR6.BLD=0 is preserved

	wrmsr(DEBUGCTL, BLCKDB);
	write_dr6(0xffff07f0);		/* DR6.BLD=0 */
	cpuid(0);			/* unrelated #VMEXIT */
	read_dr6();			/* -> ffff07f0 */

  #VMEXIT: exit_code=26, vmcb dr6=ffff0ff0
  VMRUN:   vmcb dr6=ffff07f0, dbgctl=4, v_lbr=1
  #VMEXIT: exit_code=7b, vmcb dr6=ffff07f0

As expected.


(2) BLCKDB=0: DR6.BLD=0 is lost

	/* KUT test continued from above */
	write_dr6(0xffff07f0);		/* DR6.BLD=0 */
	wrmsr(DEBUGCTL, 0);
	cpuid(0);			/* unrelated #VMEXIT */
	read_dr6();			/* -> ffff0ff0 */

  #VMEXIT: exit_code=26, vmcb dr6=ffff0ff0
  VMRUN:   vmcb dr6=ffff07f0, dbgctl=0, v_lbr=0
  #VMEXIT: exit_code=7b, vmcb dr6=ffff07f0

KVM loads BLD=0, yet the guest reads BLD=1, so KVM isn't the one setting it.
The VMCB still shows BLD=0 at the next #VMEXIT, though.


(3) BLCKDB=1 again: DR6.BLD=0 comes back

	/* KUT test continued from above */
	wrmsr(DEBUGCTL, BLCKDB);
	read_dr6();			/* -> ffff07f0 */

  #VMEXIT: exit_code=26, vmcb dr6=ffff0ff0
  VMRUN:   vmcb dr6=ffff07f0, dbgctl=4, v_lbr=1
  #VMEXIT: exit_code=7b, vmcb dr6=ffff07f0

At the last #VMEXIT in (2), KVM saved VMCB.DR6 (BLD=0) into its copy of the
guest's DR6. Here it reloads that copy, now with BLCKDB=1, and the guest
sees BLD=0 again. So in this sequence BLD=0 was "hidden" from the guest while
BLCKDB=0, but survived in KVM's saved state.

---

I wanted to understand the practical side better, since I may well be missing
something. My reading of APM 13.1.3.6 is that the processor clears DR6.BLD
only for a bus lock #DB (so only while BLCKDB=1), and that system software
then sets it back to 1 before returning to the interrupted task. I'm not
sure if any software is intended to work by clearing DR6.BLD themselves.

Are there any flows where a guest can end up with DR6.BLD=0 and BLCKDB=0? That
would help me understand where this bites.

-Shivansh

> 
> I'm still going to post v5 because I'm fairly confident the KVM implementation
> is correct, and the bug is easy enough to workaround in the testcases, but needless
> to say, I'm not happy at the moment.

