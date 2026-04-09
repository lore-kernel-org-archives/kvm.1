Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010032.outbound.protection.outlook.com [40.93.198.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E537C2C3266;
	Thu,  9 Apr 2026 05:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775711553; cv=fail; b=uGKVV3jscR41f/w0ZsEmiBy/zsB39xc8WukKQ/ijeWKmJPagw2jwhfTyCaQSDLlSMEAJovT6KG0/+Oz4BIuKWZvltBxJyqcxiAXEUMDMAoDvpd0vYo6y5bYPH8qvxhvY+VCifJvSl7u9kXsmS3CBWmzX/K8SUwngBsG1Oky/AA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775711553; c=relaxed/simple;
	bh=uMvGhDBBIVNLe+MlMPzJBg1dIzLfgRxsSwOcT26TTYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GY7OiLSwwL1LL4n7lgSumkpBf9ANsDDNKDOhisNzYEnqaR82/uB+9Xp7+16bANuKZ3gtDIqUP7etbIO+Vq5ROZgE9en7C4IP9v4d1AixlRL2eOAo4IYpcSgsiFgZo6SVs1173e8UspmUGvYZAErb8VBzsbaLEG0u5+66o5QcaiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yjhk7SRS; arc=fail smtp.client-ip=40.93.198.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yjhk7SRS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQZ+RZrAekUqvfZ/q1dst+RP+r9rztE7gai96jpGPxy+3Ga85h6XTP3jL9CoNAkVmhuu1gVdfsxzvgMKZTCoEoSHaZX24hvgu/ITgWBtnelycFA0bXmGN6RvZkx6J5iEJNZ2dkXvlN1BW5JgXn0XZECmRS13uQYAqRzVARVp+HLLcJRtR/xglOaI7AQSblz1nrpQEHCIYHTSmOQUlSkJlURGx+PdMPKNcWt2fjhdXJRfNcCOW84Mbvw8ZD7488CF2CueerPYjJaIj7DSSGVIJLNhDBlRc+Kbfe78FKIZTAIc2b8tXinha2FHWSyoQZi3jVGvZw3qcR7ZsDHc2/4BJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyNhX+nBKNW12jtBg4iJ3RzvfgK0k2jiLr+K3GzEPQ4=;
 b=YRelX+bUeLihMuCWlGh9fiFHKzouBYJpW0kFG/Xv3tmp5M33q/coPCdRYGglAPBubz8Vce8dp4aT7ZIiFd2fmyyKAp4+d8jdFMHQ415G5SepKgI+jGoiQCkTzTlM2uHGtKxdhBK89961uWnmgX9JfavWhQqjaxHZR2loWFhQD2XUn/xACqnj4bnMTMsAwXwYjCN150eKpAhjr2sI0EY/mnhFoIKA0dmOYzltV9gqKANLPq26Pe7TtrfHO/9OH8VNrisDZGvOkQJsDFAf+NuMVSnVlcw0eHt0ONIIhEa+o9rYNvfhq7dhnEhJXujRLLxH+QW39ZclnIwqJSaI80mP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyNhX+nBKNW12jtBg4iJ3RzvfgK0k2jiLr+K3GzEPQ4=;
 b=yjhk7SRSwxy+iRpew8/jC0j2a8PAnBgdDtA3az+qGV7829dg9Q2cB6N0ePNulT39pJ2cGXfslFGSFtcZnqCDaIZNhTFldytIyb4W00zuQHugvgxBDsg7ccM4CBMOKq+N7CdVl7S2jsAUr9x2nWYKNIT94izygC1epeK6xVnY/B8=
Received: from BYAPR04CA0034.namprd04.prod.outlook.com (2603:10b6:a03:40::47)
 by CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 05:12:27 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::e5) by BYAPR04CA0034.outlook.office365.com
 (2603:10b6:a03:40::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Thu,
 9 Apr 2026 05:12:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 05:12:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 00:12:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 22:12:27 -0700
Received: from [10.252.193.70] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 9 Apr 2026 00:12:24 -0500
Message-ID: <723b6ba2-b4cb-47f4-9cc9-530c0ece1cdd@amd.com>
Date: Thu, 9 Apr 2026 10:42:18 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/21] KVM: SEV: Lock all vCPUs when synchronzing VMSAs
 for SNP launch finish
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jethro Beekman <jethro@fortanix.com>,
	Alexander Potapenko <glider@google.com>, =?UTF-8?Q?Carlos_L=C3=B3pez?=
	<clopez@suse.de>, Thomas Lendacky <Thomas.Lendacky@amd.com>
References: <20260310234829.2608037-1-seanjc@google.com>
 <20260310234829.2608037-6-seanjc@google.com>
 <177b405e-87f7-400f-a783-adc7c20bef89@amd.com> <adahqilc9IrIpIvr@google.com>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <adahqilc9IrIpIvr@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|CH3PR12MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a5fa03-30ab-4f82-7974-08de95f697d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EgxP6Ff/72UliAcedn3PRcB7ncGOFiCIi752SwQd2yvVfriewuZlE/eZNVyStzHrVfmzodQj+il5OBgWRlToQ777Cs2WxzwuPBbBfnxvcZwaf0uxGbGd9ug/oY9IF2o3I6NY8QHjbH3Hc2+XmZYTgz//82nLdaoFbH4+85aLOz0EZsHtkZrtpQV2omwd7j2O1uwW45x1V/6X7dGUc8BGP1mn+SRMxOZzkigq9+9KOlF7a0D73Uvu1Lel/1iDvPVSvxt8Qn1Z8CLjPIlHrH2ZT++kVsDrjUQTZyHf3ft5v0YaA+cY0M4KC8Gft9kKdMz5r28ZmjClRHwIvOWg3iOOy8OJYiCopSbJnx50eSAjzgpypOWSg1Gwf6v/LuvW4bFRoOa1JanBmDBljgziL9KZrvtuxkGDNiKwavSlasbvUB2MA6Sr3N4Adg7ZMBvAKU4pV542L1uyyCme2/HQk3gtnnp1+czCK+Myj1K4iz8iXg0wy/kt52GhqRWLpXMHlfGJSXX6RIPwUNi0tO/0lgKi8kZBNuOoi1XByttImQsnsWgthrsVNXSx1wHuXp0vZZz9akX/qX3NZ9Ejhmyr9rh+lOtzltuEu+N55eKCu23YOyaZvtyLAXgRVqzJQHlNdNFLU8ove+HCts1cO6rImtjcrwPl7ZB/JZyZfqEV3sQS7eC9Dh8LDa7D6Lqa1X8WoS/h+dkgqBkDySKWk6X3UXuhy/6OV4cxbzVwGSmI8Goi56j6CE7zyryiSgPjhpgGnQQdZ/IJgROmLL1n7tJg4uiXFQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cxOe5Hg2CgN2XprO1FTy0PP1idlg9ySN+tymO/SZ8+6gLa82xKBqYMYuXlordYR9K8WOFjOIfdaAG8DyxHj+1fkA7xMuz/4Tn2+VpRUCWQJIt1te/PI3D9FkW+JxbhB02tJXsZkHMHodfbij+AKbqyflqpUQhccopy/Wm0uN/L9wI6FRXXhmKaYp/a+Aw6oCrFTPySHBdeGkyq6XtgeOLgM9oXn/1hmbimRco3ciQh8qMpnp2KRH3v0WzHngzk4YaJdrv0QSWkagwQldoBiCD5Cmwt0ySRqN/TMrSSe0R/p9qfPPjPsiH1XUamt/bU/a0HXr3JZKijY1mNNJ60lwptkL3d3zjmQR9gbG/fR12u8uGuhjotNzOVgAMaqKvMFjTaCFe8EKdjZZDSgNZDD+Y0oEXALm9N3pxh3kc5ru2XhDVV6TH5k6/DxYjWD1u6u0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 05:12:27.4228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a5fa03-30ab-4f82-7974-08de95f697d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9193

On 4/9/2026 12:12 AM, Sean Christopherson wrote:
> On Wed, Apr 08, 2026, Srikanth Aithal wrote:
>> On 3/11/2026 5:18 AM, Sean Christopherson wrote:
>>> Lock all vCPUs when synchronizing and encrypting VMSAs for SNP guests, as
>>> allowing userspace to manipulate and/or run a vCPU while its state is being
>>> synchronized would at best corrupt vCPU state, and at worst crash the host
>>> kernel.
>>>
>>> Opportunistically assert that vcpu->mutex is held when synchronizing its
>>> VMSA (the SEV-ES path already locks vCPUs).
>>>
>>> Fixes: ad27ce155566 ("KVM: SEV: Add KVM_SEV_SNP_LAUNCH_FINISH command")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>>> ---
>>>    arch/x86/kvm/svm/sev.c | 16 +++++++++++++---
>>>    1 file changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>>> index 5de36bbc4c53..c10c71608208 100644
>>> --- a/arch/x86/kvm/svm/sev.c
>>> +++ b/arch/x86/kvm/svm/sev.c
>>> @@ -882,6 +882,8 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
>>>    	u8 *d;
>>>    	int i;
>>> +	lockdep_assert_held(&vcpu->mutex);
>>> +
>>>    	if (vcpu->arch.guest_state_protected)
>>>    		return -EINVAL;
>>> @@ -2456,6 +2458,10 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
>>>    	if (kvm_is_vcpu_creation_in_progress(kvm))
>>>    		return -EBUSY;
>>> +	ret = kvm_lock_all_vcpus(kvm);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>>    	data.gctx_paddr = __psp_pa(sev->snp_context);
>>>    	data.page_type = SNP_PAGE_TYPE_VMSA;
>>> @@ -2465,12 +2471,12 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
>>>    		ret = sev_es_sync_vmsa(svm);
>>>    		if (ret)
>>> -			return ret;
>>> +			goto err;
>>>    		/* Transition the VMSA page to a firmware state. */
>>>    		ret = rmp_make_private(pfn, INITIAL_VMSA_GPA, PG_LEVEL_4K, sev->asid, true);
>>>    		if (ret)
>>> -			return ret;
>>> +			goto err;
>>>    		/* Issue the SNP command to encrypt the VMSA */
>>>    		data.address = __sme_pa(svm->sev_es.vmsa);
>>> @@ -2479,7 +2485,7 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
>>>    		if (ret) {
>>>    			snp_page_reclaim(kvm, pfn);
>>> -			return ret;
>>> +			goto err;
>>>    		}
>>>    		svm->vcpu.arch.guest_state_protected = true;
>>> @@ -2494,6 +2500,10 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
>>>    	}
>>>    	return 0;
>>> +
>>> +err:
>>> +	kvm_unlock_all_vcpus(kvm);
>>> +	return ret;
> 
> /facepalm
> 
> With an assist from lockdep (see below), I forgot to actually unlock in the
> *success* path.  The failure manifested as a "guest" hang instead of a deadlock
> by pure dumb luck: kvm_vcpu_ioctl() uses mutex_lock_killable() so killing QEMU
> still works.
> 
> I'll squash this (assuming it fixes the problem you're seeing), and omit this
> entire series from the initial 7.1 pull requests.  If everything looks good, I'll
> plan on sending a second pull request for this series after it's had more time to
> soak in -next.
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 2010b157e288..770f7dfc0e5c 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2512,12 +2512,12 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
>   
>                  ret = sev_es_sync_vmsa(svm);
>                  if (ret)
> -                       goto err;
> +                       goto out;
>   
>                  /* Transition the VMSA page to a firmware state. */
>                  ret = rmp_make_private(pfn, INITIAL_VMSA_GPA, PG_LEVEL_4K, sev->asid, true);
>                  if (ret)
> -                       goto err;
> +                       goto out;
>   
>                  /* Issue the SNP command to encrypt the VMSA */
>                  data.address = __sme_pa(svm->sev_es.vmsa);
> @@ -2526,7 +2526,7 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
>                  if (ret) {
>                          snp_page_reclaim(kvm, pfn);
>   
> -                       goto err;
> +                       goto out;
>                  }
>   
>                  svm->vcpu.arch.guest_state_protected = true;
> @@ -2540,9 +2540,7 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
>                  svm_enable_lbrv(vcpu);
>          }
>   
> -       return 0;
> -
> -err:
> +out:
>          kvm_unlock_all_vcpus(kvm);
>          return ret;
>   }
> 

This fixes the snp guest boot issue.


>>>    }
>>>    static int snp_launch_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
>>
>>
>> I am seeing an SNP guest boot failure starting with linux-next tag
>> next-20260406 [1].
>>
>> The SNP guest hangs during boot.
> 
> ...
> 
>> There are no error messages on either the host or guest serial console when
>> this happens.
> 
>   WARNING: Nested lock was not taken
>   7.0.0-smp--36ad607330fb-snp #112 Tainted: G     U  W  O
>   ----------------------------------
>   qemu/39235 is trying to lock:
>   ffff8d0e590c00b0 (&vcpu->mutex){+.+.}-{4:4}, at: kvm_lock_all_vcpus+0xab/0x180 [kvm]
>   
>                but this task is not holding:
>   &kvm->lock
>   
>                stack backtrace:
>   CPU: 123 UID: 0 PID: 39235 Comm: qemu Tainted: G     U  W  O        7.0.0-smp--36ad607330fb-snp #112 PREEMPTLAZY
>   Tainted: [U]=USER, [W]=WARN, [O]=OOT_MODULE
>   Hardware name: Google, Inc.                                                       Arcadia_IT_80/Arcadia_IT_80, BIOS 34.86.0-102 01/25/2026
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x54/0x70
>    __lock_acquire+0x7b9/0x2900
>    reacquire_held_locks+0x107/0x160
>    lock_release+0x177/0x360
>    __mutex_unlock_slowpath+0x3c/0x2b0
>    sev_mem_enc_ioctl+0x3c9/0x400 [kvm_amd]
>    kvm_vm_ioctl+0x57c/0x5d0 [kvm]
>    __se_sys_ioctl+0x6d/0xb0
>    do_syscall_64+0xe8/0x920
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>    </TASK>
>   
>                other info that might help us debug this:
>   no locks held by qemu/39235.
>   
>                stack backtrace:
>   CPU: 123 UID: 0 PID: 39235 Comm: qemu Tainted: G     U  W  O        7.0.0-smp--36ad607330fb-snp #112 PREEMPTLAZY
>   Tainted: [U]=USER, [W]=WARN, [O]=OOT_MODULE
>   Hardware name: Google, Inc.                                                       Arcadia_IT_80/Arcadia_IT_80, BIOS 34.86.0-102 01/25/2026
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x54/0x70
>    __lock_acquire+0x7de/0x2900
>    reacquire_held_locks+0x107/0x160
>    lock_release+0x177/0x360
>    __mutex_unlock_slowpath+0x3c/0x2b0
>    sev_mem_enc_ioctl+0x3c9/0x400 [kvm_amd]
>    kvm_vm_ioctl+0x57c/0x5d0 [kvm]
>    __se_sys_ioctl+0x6d/0xb0
>    do_syscall_64+0xe8/0x920
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>    </TASK>

