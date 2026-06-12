Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D619139902D;
	Fri, 12 Jun 2026 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781241434; cv=fail; b=Y7qI9Tp4H96H4veP3iPKbJ38xmjh3ehvDLZaQINi5jqm+GrC5trpGbwHfiDLcJbRPwbbuH4U+lSBPNG83erIA7MeGyREfUgLxMwvwH7jJYqOoQ2Tnn7KQc+IsQzvfDFIVbsucy6e+GmlEzUZiyT1MxFxehb8aGK9W4Ag6hrxdy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781241434; c=relaxed/simple;
	bh=aPZg0gjW4nCCRhEvNPpWtDC7rmRfA3wxeBtJV2pPKUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ILjMZIajM21CQ0ovuInw5G1smIP+1QojILbz9YkieJTILGtz3qsuL34iGYEiONQxqetmyRnz6fvK5z8khHvumLWT8ZtnLBs6V80pSZBHYWSdRpNizWMKwPCy/gGV2TDx0s4HIEGkGW+RHK6SDw1vaZgSob3MEAecy1cA4Di7oD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=opNQFVXV; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="opNQFVXV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvSAa5XXFg2e3ZcLuoOmnpNhzCDmMwHko8MbcT7j+l57et+LrrbONf/vO3VHcPKs+jJqN8m6kPlTPoqAIOGsbvbyaSh+m8kW6zjG0GEGbCUOb/p3Nn6z3gI0gLv1YNFFzwsBNTT+XtICfzdrS8Hw6+a1eU1jcqcDO1pso1Jc2abd4K2EXee0REseceN8Vz3oqAWjnYHo/qFIOSjAvNgRQvTuYu3jLU7fq0w+ehdMazOUPbRCG5vnqjE/Vt2Cd1E80eBgnszGAJzQtjk9sSLYb2YlQsVDx1j8u1i8To+hup9gmivkcODLO9n3Gfe0zOxXXak26BKlEvIQL/5cynXH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5UK5Q3QIh/7eStEBJQCUpgxlxs1xfdO/+8Yzn3fvRY=;
 b=yPoqozf9lH0cLyOQ/WNjt+7aQVR7qWiYa0vJPmsDplhExbEJGkkwGGYBVVs7LyVEnAeUOX7gSv9IJKUpZ/Wd85D8ZEtvklp6l27Zdd5RbvTWHHy7RGwYvPc5ULCnETX17Fvv2B7atxpfguyk6rW9+nJNBlbkhwAE5TLdBxPH9vFYDT22z/vHpOIZY7spxX/vMGJ1ardlPunYi7yayyN384WL7eJR4Q4f56tyiKO7y67Mxo9H6H2yoIMv45AK2IxjU6a3AUAn3TFI0K1PZPaQwDASQTL4gCwH/w+szN0cnCax3NMfTmIyLV5HABPcvrsUeMYj2+TdS3P8vl0duOBYDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5UK5Q3QIh/7eStEBJQCUpgxlxs1xfdO/+8Yzn3fvRY=;
 b=opNQFVXVNgi+O1E2m0a1zW/Zds3O4AmyJ2tvITzEjPSD7julYmXiEYYXhnGY6UlCjN70tragFrzGqtw/jksgz0jGecLclW93HmZF3d13cYIcoenS4Q1f3J/SLTy6l2WIY+WNt3HM+f55EjYeVmWwhYkL7wouTUA8qF9lIDhiips=
Received: from SJ0PR03CA0079.namprd03.prod.outlook.com (2603:10b6:a03:331::24)
 by DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 05:17:07 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::3e) by SJ0PR03CA0079.outlook.office365.com
 (2603:10b6:a03:331::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 05:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 05:17:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 00:17:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 00:17:05 -0500
Received: from [10.136.37.196] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 12 Jun 2026 00:17:01 -0500
Message-ID: <69ef3757-fefe-4437-ac45-011f2797d865@amd.com>
Date: Fri, 12 Jun 2026 10:47:00 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] sched/fair, KVM: Semantics-aware directed yield
 for oversubscribed KVM
To: Wanpeng Li <kernellwp@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
CC: Christian Borntraeger <borntraeger@linux.ibm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, Wanpeng Li <wanpengli@tencent.com>, Richie Buturla
	<richie@linux.ibm.com>
References: <20260612013355.59231-1-kernellwp@gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260612013355.59231-1-kernellwp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a28f08-b9b3-4e86-bdff-08dec841d867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|13003099007|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	C2kTlimp5B8ZAUEFzd//CO2oLCFjsknmJbVgvMh+NFUTt0xzCRtw8jfkidVHPAmC/MXN2BCkv158yy73Zw04VN9+JL3OmDi8ya6S7uS7LX5gffGIbFbmoCFJgHuJ5FEHvNL4QRp7kdVVrGREiRH2RXCrKxOG5+HpTc90RX4LuSPK/YPqcT6xEUm7aKWPkFbzWm9mAJEKukDOXsZYRvnVBHjP1WfnixloM88X3Q/uDnkRpNTZPIrZ+AGQ1EaK+B7SmWA+ZGxqoH4LzK71CZbCEj9AEzslgB55TLbV4zg295lZjVxs7jA7G/UiDEV8/dHQgK5xytawrt2+bYU1KiHQF+yYdm5ccCiSDrNQC19QUuB896p3Yi2MSuM8eXmbAcAl81BAYcuGubzLx8Go/MInXDCmpXFeZnj3ZKm8TsEb9auBg3iUh4rmRrKT/3IRy/WDQTMpxTplSvDJTUfbeyFnrA9zFtFlKISG7Ga9urQi7Wg6NNVxmf2N3h+EOBplDvEaRotbG5uxVmxn1GLppnPFBoZgUIfaSogwhK+zrYhBWVgh0sds28fVxpEP7lp0AZe4p4/LdqQaVvjF4HIhz7+odnHsUGMmyfnBt/NbH0JRD2v9OqRVPeUdgZcNa614F6JyI0Pjujo4hYpdeuBl8mMtZmwFHOhsUToY5WlR31G2b5639f4ThyMrFe7aKX0HAAjfBRu4ziSG2GKsMXqsfHb7zQTqEH+ow5+zYuUTDCXIKSo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(13003099007)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gPnIvnyh7YGsNzyz3nsKRj98/fVk/RjpwkysLCv/TIf4PjqZy9T752M/qkqn57omW7W8pxHtdVr0wmVnPR+96qPI7HHxTE3xsd9xJNDZpu8tl7QmcxOn+NVNJ4bNVwRmWsBghf+lxxMkjfVLkeOk/gvAahKf7BAMm2kp1a5HbiGML/EJNxAnClhvK/oA+vpsNMjmXxLa12DXdloezUVPax/1a3JV5Tp1zhCjuQqLhv0ZSn0BVFAU4CgshFtl0GCW8utpOsAeUJNvvwk1BAul7pmev3jwzHg+UrSUIcjhgFK9RgmuNfe/vZqVSGyaDTnbKgwrnt3yxTE1HiThP5nz+alcrj7KuzLRU1ZmkJdJGyF5xh4p4K92fIqNX0BuylLT9WIAVdwNKkB+5Iacnen987+meP7TFir7QuiC2ul49hznNYpSSIyfJWUE8wJNFW1E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 05:17:06.1565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a28f08-b9b3-4e86-bdff-08dec841d867
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605

Hello Wanpeng,

On 6/12/2026 7:03 AM, Wanpeng Li wrote:
> Part 1: Scheduler EEVDF lag credit (patches 1-5)
> 
> Rather than penalizing the yielding vCPU, credit the nominated target so
> pick_eevdf() honors the buddy hint.
> 
> The mechanism is EEVDF-native and cgroup-hierarchy-aware:
> 
> - Credit bounded EEVDF lag to the nominated next-buddy so pick_eevdf()'s
>   PICK_BUDDY branch returns it.  Walk the same ancestor chain that
>   set_next_buddy() nominated and credit each not-yet-eligible level, so the
>   hint is not dropped at the first ineligible group entity.

I believe Peter is planning to flatten the pick by v7.3 so I would
suggest you to test the flattened pick series [1] which is available in
Peter's tree in sched/flat branch [2].

That should get rid of the need to traverse the hierarchy and
should solve one part of your problem of yielding to vCPUs across
different cgroups.

[1] https://lore.kernel.org/lkml/20260605105513.354837583@infradead.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/flat

> 
> - Credit to a small positive-vlag margin, not merely the vlag = 0
>   eligibility boundary, so the target stays eligible across several
>   scheduling decisions rather than a single pick.  The margin scales with
>   runqueue depth and is clamped to entity_lag()'s legal positive-lag bound,
>   preserving EEVDF fairness.
> 
> - Handle both the off-tree current entity (shifted in place, carrying any
>   vprot window)


Is this even possible to yield to an out of tree entity? The core bits
in syscalls.c already bails out for:

    if (task_on_cpu(p_rq, p) || !task_is_running(p))
           return;

and the early bits in yield_to_task_fair() bail out for "!se->on_rq"
which makes me wonder when will we ever have the p->se as cfs_rq->curr
while holding both the p->pi_lock and the rq_lock?

The task must be on the rq while being preempted for yield_to to work,
no?

>   and a queued (on-tree) entity (repositioned via the
>   canonical place_entity()-paired requeue used by requeue_delayed_entity(),
>   keeping sum_w_vruntime consistent with entity_key()).
> 
> - Force a local reschedule at the end of the credit path: cancel
>   RUN_TO_PARITY slice protection along the yielder's sched_entity chain and
>   resched_curr() the local CPU.  Only this forced preemption is rate
>   limited (once per 6ms per rq) to avoid excessive forced preemption on
>   PLE-heavy guests; the lag credit itself runs on every directed yield.
> 
> The mechanism is gated by SCHED_FEAT(YIELD_TO_LAG_CREDIT) (default on).
> With the feature off, yield_to_task_fair() keeps the existing forfeit-only
> behavior.

[...]

> The gains stem from three factors:
> 
> 1. Lock holders receive sustained CPU time to complete critical sections,
>    reducing lock hold duration and cascading contention.
> 
> 2. IPI receivers are scheduled promptly when senders spin, reducing IPI
>    response latency and wasted spin cycles.

Looking at kvm_smp_send_call_func_ipi() in arch/x86/kernel/kvm.c, there
can be multiple destination vCPUs for the IPI. Why does it make sense
for the sender to yield almost all its time to the first vCPU on the
mask then?

And do all IPIs have to spin? Can't they be async too?

> 
> 3. Reduced context switching between lock waiters and holders improves
>    cache utilization.
> 

[...]

> 
> Patch Organization
> ------------------
> 
> Patches 1-5: Scheduler EEVDF lag credit
> 
>   Patch 1: Add the eevdf_credit_entity_vlag() primitive and the
>            YIELD_TO_LAG_CREDIT feature.  Handles the off-tree current
>            entity and has no functional effect on its own.
> 
>   Patch 2: Credit to a persistent, queue-depth-scaled positive-vlag
>            margin, clamped to entity_lag()'s legal bound.
> 
>   Patch 3: Extend the primitive to a queued (on-tree) entity via the
>            canonical place_entity()-paired requeue.
> 
>   Patch 4: Wire the credit walk into yield_to_task_fair(), crediting each
>            level of the nominated ancestor chain.
> 
>   Patch 5: Force a local reschedule (cancel RUN_TO_PARITY slice protection
>            and resched_curr()) so the credited buddy can be selected.
>            Activation patch; rate-limits only the forced preemption.

I don't know if it is just me but this structure made it insanely
difficult to review with unused functions and callers being only added
at Patch 4 to understand how it all worked.

All of this will require rework with flattened pick but I would suggest
adding the simple lag movement bits first and adding the
eevdf_persistent_margin() magic later on top.

-- 
Thanks and Regards,
Prateek

