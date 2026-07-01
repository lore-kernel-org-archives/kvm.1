Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE418408002;
	Wed,  1 Jul 2026 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946299; cv=fail; b=Q4/AmpYZRIhsygS1ict6SFGUr5W/q/t2dIwrXVmU1OBM/2pBSmMs2hvaY+3u87eSyzZZWugftcTwAKXqPGYznnRwHPGZY9y4P7s9Rsen+GAX8ppaFQR1cBCMCJT1lWnM7Fh/3C/NHCwXRjjIaejDuBVZWyxqOUDC3mHEbXYPFyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946299; c=relaxed/simple;
	bh=bUHjmCj4iXlHWKsnQVoWrgpxrzI5Cvfjx+OSP4EGu9U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIpfW+dXHcLIqA8NjV6b7ogKOdJQBMbxKkQkwEnkftOQXQJiAoo9Uhv1Ch6xekL8WpnTVc03L/vrR9vweWtgdf6n2orXVhlVPNBcmKldIaSnAqD7T9YVR9R2fIPHgi80iqUmF3OY/FI1FceyvSxZ41Z5LfuhYaNfYRIvZWGLIC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UKuCZeBY reason="signature verification failed"; arc=fail smtp.client-ip=52.101.85.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UKuCZeBY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9iWe1eqi8n1RgFN5aQKd9jFkI6k1OuffaUMkaQUT+Yb9o8xSHFdCKbLZnXmGmhIk3ZpoVeqtTWSiC9S5S62NAI4H9m5vJwx/aeq9uJrQCqchd9BRQ2lfOj3J9JLCISiF5zAOErOti0xTmVxcNVa7Q/veIJqkiVQTHqgmDnlnvyoK8I1H6E4VdQo7NN6k6O3d99ugRgjTbSVmJEcwq3Uq2zslpafUvwVmKkdZ1BeYAXlQDZihISH3sZGTxMQcp3adYt9pWidV9goE12hnC1k0UQsRz+cJmXCzFDbH/1uYkJoRKkksGMfhNaiVi8A2cunDjBcHYMcpC9EcpXO/bPCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJ4deSkOZjXdhG3rW41boybE7/GwhISFKD2UZ60qKPc=;
 b=tQk0xSIvWQST1QcqfKV/XE58PdfJO7f/6CJS1O1dcZj9hpFjr5IkSXsAoUyF4SOn4aWKwkObQC9tOtsAEwzmJVZAiWztEv6l9cQBAXExYIQ+hpcxG+Z0OKatxdG633kvjxab/A4CjkL9qqtv4F4ESjFrTTxwxjUJeedfz7aGy50zYW+oSisxR6jzwPnRSWUocMpWjRiwlElR05fVRG/eczga1+/GTQqNhyiXsVYUu0SkltzMPQITFItvSV81K8ZmhMefhDi1Nor7KFn/EGxMflkmGi2nUf6ZkvCJJV283TUlfZv3Lc7kBYsvXphADZgMi6HeUg0apW4vVVyWYS3HSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJ4deSkOZjXdhG3rW41boybE7/GwhISFKD2UZ60qKPc=;
 b=UKuCZeBYRW+qm6WXgn5ccS/Fzhe0Mmbo7O44TQsX45K91ex3Ow3twU9MsuD+vLReV9QE9nCT36A1QPMTPkoGWYF3N48zOWG6KsqU8fa+aUHM62+lUbnpr/gdCdKTMjccp3DyFOflEp8BHwNJ06fbctfzb4/7oD5JyzUz1TYgcxU=
Received: from PH5P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::6)
 by DS4PR12MB9793.namprd12.prod.outlook.com (2603:10b6:8:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 22:51:26 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::28) by PH5P220CA0008.outlook.office365.com
 (2603:10b6:510:34a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 22:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 22:51:26 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 17:51:25 -0500
Date: Wed, 1 Jul 2026 16:56:56 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v3 10/12] KVM: SEV: Forcefully invalidate SNP VMSA if its
 backing gmem page is zapped
Message-ID: <kpmoqofdihxpnhj6yxkuppaepy432h6hh4c53wzptbilzfvqa2@vwboboldkb5x>
References: <20260630222607.497895-1-seanjc@google.com>
 <20260630222607.497895-11-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260630222607.497895-11-seanjc@google.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|DS4PR12MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: abc54fa9-3551-4b42-b3a4-08ded7c34827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|3023799007|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xN4hZf9+vGm2vK8pLTVofm8Y0MBhxq4mZ+Lqq8CbJE5DkpBhQjvo4iodnEMlPGbLdOD/9DfXpE5Cn/BzD1xqn5eaeCIPXe7oRQsLbyFF6pZ/oP0P2fE21bVMCoKZD8UHIxy5r4wRj3D+75qGyFB0SVhoCk+KZOk8shBWKic5PIVdfAdijPcwOG40erJdIEv5uwtq6x36xFfBRYCXHHAfFZBONFZkro+kLuwOM9snST4Rl9M6q10G063MapEdNmC+e2bXKR4OeIFvRWCrkpLopjylDn3QDhylKGECAhgLfcjMiI/S2PFiB9+P6yV/gM5sBHb60zR+Gvs7ShZVgLSmC8Bq7Wr5Q8JBrftPQyQH8EoTQQPtQfkyqGnBQm0KT8Tku8FspIBVCss78Orxr7y+2yUnyuKzkftOY43+MMTvPKzvkBvrAMPGzmwdaPHCop+AdLKsAc2T/W0N3vYwt0qlRiuRRANEW2m9r2glzYg5OU80zXesdn3aNg5BaBwAqb6IVrfl3/WmweUlGg3989sFN8Nb5d0dZOQukyHlqYMSag59mL04ck81x2Wrx6JAteSISA7qmaw86Ks2DbFfq0DJ4bdRRoAzAWu+8HR177GOzj7IDkgF/5tho2MNx1HijkBEbgidiQBM8QgJ2ubgWxT7ktlK6YVMzDyOQd7zdn7ci+6ilIU5kBXwAXQL/kaZXd9oGmwCA5K/bRhrNeYY2de4dQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(3023799007)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zISlm6nCUK9X2YtZHHx+JJWm9B0JcKGHbTtC+Tgs9vKLhfuMgBelcSzHZyczmRCFPTFfhdISPQg2+h8GlGA9t5xitRF/JpQCX9jLg5wiDaP9CLKK7poM4RkQTfhV3d4M6kqwUPUCyeuee7ZmdzJD4SSpPY9J9/nHDVe7dzF7go828kAbkkskA/8PST/bnP0PYssWEZU2iAwjhkQlhyZ0vLpI3MyGigo40iee+VfXON66hQHl9V2qNUDUaiN3QQSVWL6hNOOS76WcBecXcxaP6iiJZoM3hbsXoPDE8MsdrcnDQGMZV0/Q8c7dOwS/qIcbe1AfvUoKcM7LCihcY14JqYFZZyLk0P5mIaZwj+2oq4/nzGnAL66V5oI3f5nE2IKkzruUcDoE8kupfkiu7OkOWugvTZa6sC7vi/LNNUj2Rhw4fTsYXjwC4u/M22stb4Hz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 22:51:26.1710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc54fa9-3551-4b42-b3a4-08ded7c34827
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9793

On Tue, Jun 30, 2026 at 03:26:05PM -0700, Sean Christopherson wrote:
> Wire up a gmem_invalid_range() call for SNP VMs, and use it to force vCPUs
> to reload/recheck their guest-provided VMSA if the backing guest_memfd page
> is being invalidated, e.g. is being PUNCH_HOLE'd.  Use the same core logic
> to handle invalidations as VMX does for the APIC-access page, as the two
> concepts are nearly identical: shove the physical address of a page into
> the vCPU's control structure:
> 
>  1. Snapshot the invalidation sequence counter
>  2. Grab the pfn (from guest_memfd in this case)
>  3. Acquire mmu_lock for read
>  4. Re-request reload if retry is needed, otherwise commit the change.
> 
> Note, the re-request action in #4 is necessary as KVM's retry logic is
> fuzzy, i.e. can get false positives.  If the guest_memfd page has been
> dropped, at some point a subsequent reload will fail to get a PFN from
> guest_memfd, and KVM will fail KVM_RUN.  If the retry was due to a false
> positive, KVM will retry until there are no relevant MMU notifier events
> (and will retry in the "outer" loop, i.e. will drop locks and resched as
> needed).
> 
> Note #2!  Take care to invalidate the VMSA when a relevant memslot is
> DELETED or MOVED, as invalidations in response to PUNCH_HOLE are predicated
> on memslot bindings (KVM doesn't know what GFN range(s) to invalidate
> without a binding).  And more importantly, the VMSA mapping requires a
> memslot, i.e. must be invalidated if its memslots disappears, regardless of
> the state of the underlying guest_memfd inode.
> 
> Failure to invalidate the vCPU's control.vmsa_pa (which is checked by
> pre_sev_run()) can prevent KVM from properly freeing the page as firmware
> will reject the RMPUPDATE to reclaim the page with FAIL_INUSE if the vCPU
> is actively running, i.e. if VMSA page is in-use.  That in turn leads to an
> RMP #PF on the next use, as the page will still be assigned to the SNP VM.
> 
>   SEV-SNP: RMPUPDATE failed for PFN 78d198, pg_level: 1, ret: 3
>   SEV-SNP: PFN 0x78d198, RMP entry: [0xfff0000000144001 - 0x000000000000000f]
>   CPU: 3 UID: 0 PID: 31345 Comm: sev_snp_vmsa_pu Tainted: G     U     O
>   Tainted: [U]=USER, [O]=OOT_MODULE
>   Hardware name: Google, Inc. Arcadia_IT_80/Arcadia_IT_80, BIOS 34.86.0-102 01/25/2026
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x54/0x70
>    rmpupdate+0x12c/0x140
>    rmp_make_shared+0x3b/0x60
>    sev_gmem_invalidate+0xe0/0x170 [kvm_amd]
>    delete_from_page_cache_batch+0x1d8/0x220
>    truncate_inode_pages_range+0x120/0x3d0
>    kvm_gmem_fallocate+0x19a/0x270 [kvm]
>    vfs_fallocate+0x1bc/0x1f0
>    __x64_sys_fallocate+0x48/0x70
>    do_syscall_64+0x10a/0x480
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>   RIP: 0033:0x496c7e
>    </TASK>
>   ------------[ cut here ]------------
>   SEV: Failed to update RMP entry for PFN 0x78d198 error -14
>   WARNING: arch/x86/kvm/svm/sev.c:5160 at sev_gmem_invalidate+0x126/0x170 [kvm_amd], CPU#3: sev_snp_vmsa_pu/31345
>   CPU: 3 UID: 0 PID: 31345 Comm: sev_snp_vmsa_pu Tainted: G     U     O
>   Tainted: [U]=USER, [O]=OOT_MODULE
>   Hardware name: Google, Inc. Arcadia_IT_80/Arcadia_IT_80, BIOS 34.86.0-102 01/25/2026
>   RIP: 0010:sev_gmem_invalidate+0x12b/0x170 [kvm_amd]
>   Call Trace:
>    <TASK>
>    delete_from_page_cache_batch+0x1d8/0x220
>    truncate_inode_pages_range+0x120/0x3d0
>    kvm_gmem_fallocate+0x19a/0x270 [kvm]
>    vfs_fallocate+0x1bc/0x1f0
>    __x64_sys_fallocate+0x48/0x70
>    do_syscall_64+0x10a/0x480
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>   RIP: 0033:0x496c7e
>    </TASK>
>   irq event stamp: 20689
>   hardirqs last  enabled at (20699): [<ffffffff8e76092c>] __console_unlock+0x5c/0x60
>   hardirqs last disabled at (20708): [<ffffffff8e760911>] __console_unlock+0x41/0x60
>   softirqs last  enabled at (20722): [<ffffffff8e6cd74e>] __irq_exit_rcu+0x7e/0x140
>   softirqs last disabled at (20717): [<ffffffff8e6cd74e>] __irq_exit_rcu+0x7e/0x140
>   ---[ end trace 0000000000000000 ]---
>   BUG: unable to handle page fault for address: ffff99a64d198000
>   #PF: supervisor write access in kernel mode
>   #PF: error_code(0x80000003) - RMP violation
>   PGD 13eb001067 P4D 13eb001067 PUD 78d1d1063 PMD 1184e0063 PTE 800000078d198163
>   SEV-SNP: PFN 0x78d198, RMP entry: [0x6030000000144001 - 0x000000000000000f]
>   Oops: Oops: 0003 [#1] SMP
>   CPU: 3 UID: 0 PID: 31407 Comm: highlanderd_hea Tainted: G     U  W  O
>   Tainted: [U]=USER, [W]=WARN, [O]=OOT_MODULE
>   Hardware name: Google, Inc. Arcadia_IT_80/Arcadia_IT_80, BIOS 34.86.0-102 01/25/2026
>   RIP: 0010:prep_new_page+0x67/0x220
>   Call Trace:
>    <TASK>
>    get_page_from_freelist+0x1c40/0x1c70
>    __alloc_frozen_pages_noprof+0xca/0x1f0
>    alloc_pages_mpol+0x10b/0x1b0
>    alloc_pages_noprof+0x81/0x90
>    pte_alloc_one+0x1b/0xd0
>    do_pte_missing+0xdf/0x1020
>    handle_mm_fault+0x7c7/0xb20
>    do_user_addr_fault+0x268/0x6b0
>    exc_page_fault+0x67/0xa0
>    asm_exc_page_fault+0x26/0x30
>   RIP: 0033:0x4a6b1e
>    </TASK>
>   gsmi: Log Shutdown Reason 0x03
>   CR2: ffff99a64d198000
>   ---[ end trace 0000000000000000 ]---
>   RIP: 0010:prep_new_page+0x67/0x220
> 
> Drop the pseudo-TODO comment about needing to pin the page if guest_memfd
> every supports migration, as integrating with invalidations events means
> KVM will Just Work if/when page migration is ever supported (assuming SNP
> hardware supports migrating VMSA pages).
> 
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Closes: https://lore.kernel.org/all/aimMWzAf5b3luM0b@v4bel
> Fixes: e366f92ea99e ("KVM: SEV: Support SEV-SNP AP Creation NAE event")
> Cc: stable@vger.kernel.org
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: Jörg Rödel <joro@8bytes.org>
> Cc: Fuad Tabba <tabba@google.com>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

Small/optional nit below:

> ---
>  arch/x86/include/asm/kvm-x86-ops.h |  2 +
>  arch/x86/include/asm/kvm_host.h    |  4 ++
>  arch/x86/kvm/mmu/mmu.c             |  5 ++
>  arch/x86/kvm/svm/sev.c             | 79 +++++++++++++++++++++++++-----
>  arch/x86/kvm/svm/svm.c             |  2 +
>  arch/x86/kvm/svm/svm.h             |  2 +
>  arch/x86/kvm/x86.c                 |  6 +++
>  include/linux/kvm_host.h           |  1 +
>  virt/kvm/guest_memfd.c             |  4 ++
>  9 files changed, 94 insertions(+), 11 deletions(-)
> 
...
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index cf7c1a437f38..123e7bf687ef 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -996,6 +996,7 @@ static inline struct page *snp_safe_alloc_page(void)
>  {
>  	return snp_safe_alloc_page_node(numa_node_id(), GFP_KERNEL_ACCOUNT);
>  }
> +void sev_snp_reload_vmsa(struct kvm_vcpu *vcpu);
>  
>  int sev_vcpu_create(struct kvm_vcpu *vcpu);
>  void sev_free_vcpu(struct kvm_vcpu *vcpu);
> @@ -1009,6 +1010,7 @@ int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
>  extern unsigned int max_sev_asid;
>  void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
>  int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> +void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
>  void sev_gmem_reclaim_memory(kvm_pfn_t start, kvm_pfn_t end);
>  int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
>  struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index bc0c3163f4a3..0bb50997c0e3 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8170,6 +8170,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  				goto out;
>  			}
>  		}
> +		if (kvm_check_request(KVM_REQ_VMSA_PAGE_RELOAD, vcpu))
> +			kvm_x86_call(reload_vmsa)(vcpu);

VMSA is SVM/SEV-specific, and while the event/handling might be SEV-specific,
would it make sense to make the kvm_x86_op generic at least?

'reload_guest_save_area' maybe?

Thanks,

Mike
