Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D82472A2;
	Tue,  4 Aug 2026 02:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811106; cv=none; b=lzyybkf4rRQ8UM0VcIp5DFO/giqOp1sa6a3PQIuTIsUl7LLokuPgTE+hoCdPimnRI50eM590U/zxBXwTwGtm7SE03p5pFTo0MQdNGiDuvOMcuCbpiyZfPDRs2Uzi85TkSlHq2Jn0TDAlS5UTaHtfs3UDRwV1BLVRAyGQK3qMjws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811106; c=relaxed/simple;
	bh=C2C01QINdhhvR6FLTgLo8a14F9osuvoKNt5pPfqduzM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jKfFBbjsvuJi97WFG3HObPon0vaLdaDMssLjAJ1kW2VlDE98KxRG5tjqOOGHjQiHk0RupoUMgHn+75msqdmETG7LNRba+tIOrUjlZbIzG9/xTegzKakDpnGtt2CFgc24UX1wGvpbNebR0IPBstzXWK/yAxeEzxsDdWt/KcYCKX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; dkim=pass (2048-bit key) header.d=bosc.ac.cn header.i=@bosc.ac.cn header.b=qeKLnyPn; arc=none smtp.client-ip=115.124.28.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bosc.ac.cn header.i=@bosc.ac.cn header.b="qeKLnyPn"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bosc.ac.cn; s=default;
	t=1785811093; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=AstU9gZT3RaBuxw9uDri9Znkbk2eOHzmsbEMxKrjs14=;
	b=qeKLnyPnyeL45fYqmWmXCfxX8Vym28f1R94ZmehHmV87aNC3KKWJhVF7RBvINpFNhKPxirqbAo7B+gSeYsSDjxRrA3omOHaZgkPc+xqVoyrCqnqt1v+PHEE3A59uqS6f1pdVnH8DoSEIHGN0BIevpsf8mtvZIC/WuW3T7wweOJFD0CP980+q4XiPhigqDRiS/23XPEkDIai2/4o2oOMdop4Ee02g54tcNuLJ0tFEjO1R/3x+Z8cqcNGentFqjO2S5quUbGxlac1kIdjpoCm3BzgNNhhd3joBb7he4pk0Qf8zXQfp2Rkv5fC/OVLKodEbh0hUSRyMxAmQQAeJWCFj8g==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0743953|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.25817-0.0164646-0.725365;FP=16570213262202463728|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=guoyaxing@bosc.ac.cn;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.id1w.Hb_1785810771;
Received: from 172.28.113.148(mailfrom:guoyaxing@bosc.ac.cn fp:SMTPD_---.id1w.Hb_1785810771 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 04 Aug 2026 10:32:52 +0800
Message-ID: <0d15b098-b8f7-4080-9f33-e8c49c2331e1@bosc.ac.cn>
Date: Tue, 4 Aug 2026 10:32:51 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: guoyaxing <guoyaxing@bosc.ac.cn>
Subject: Re: [RFC] RISC-V KVM: guest local sfence.vma may miss stale VS-stage
 TLB after vCPU migration
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Hui Min Mina Chou <minachou@andestech.com>, majiuyue@bosc.ac.cn,
 linux-kernel@vger.kernel.org
References: <20260802050015.104795-1-guoyaxing@bosc.ac.cn>
 <CAAhSdy3QE6Fe_fanKOLHLjDCb+vsVax=wy18UxzR23XN7ggJGw@mail.gmail.com>
In-Reply-To: <CAAhSdy3QE6Fe_fanKOLHLjDCb+vsVax=wy18UxzR23XN7ggJGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/3 22:22, Anup Patel 写道:
> On Sun, Aug 2, 2026 at 10:30 AM Yaxing Guo <guoyaxing@bosc.ac.cn> wrote:
>>
>> Hi all,
>>
>> I would like to ask whether RISC-V KVM has a gap around guest sfence.vma
>> and VS-stage TLB invalidation when a vCPU migrates across host CPUs.
>>
>> On bare metal, Linux uses mm_cpumask in __flush_tlb_range() to decide
>> whether to send a local or remote sfence.vma. That works because the cpumask
>> reflects physical CPUs. In a guest, however, the kernel only sees vCPUs, so
>> from the guest point of view a task may never "migrate" even though the
>> underlying vCPU moved to a different host CPU. In other words, guest
>> mm_cpumask is effectively a vCPU mask, not a host CPU mask.
>>
>> There is also a related switch_mm()/set_mm_asid() aspect. With the ASID
>> allocator enabled, RISC-V Linux does not flush on every context switch. A
>> local_flush_tlb_all() is only done when a deferred ASID rollover flush is
>> pending for the current CPU. That is fine on bare metal, because previous
>> shootdowns are also based on physical CPUs. In a guest, however, the earlier
>> shootdown may have been only a guest-local sfence.vma and may have missed an
>> old host CPU where the same vCPU ran previously.
>>
>> A simplified sequence is:
>>
>> 1. A guest task with mm A runs on vcpu0 while vcpu0 is scheduled on host
>>     CPU1. CPU1 fills a VS-stage TLB entry for that mm/ASID.
>> 2. vcpu0 migrates to host CPU0. KVM's vCPU migration sanitization is local
>>     to the current host CPU, so it does not invalidate the VS-stage TLB entry
>>     that was left on host CPU1.
> 
> When vcpu0 migrates to host CPU0, the host CPU0 may or may not have
> VS-stage TLB entry so VCPU migration sanitization does the right thing.
> 
> In the future, vcpu0 may again move back to host CPU1 containing stale
> VS-stage TLB entries left in step1 above so the VCPU migration sanitization
> will cleanup these stale TLB enteries.
> 

Sorry, perhaps I didn't describe it clearly enough. In short, the issue 
is: because vcpu0 migrated away, cpu1 still has stale TLB entries while 
cpu0 has the new mapping. After that, neither vcpu migrated again, but 
the process was scheduled from vcpu0 to vcpu1 (which is on cpu1), 
causing it to hit the stale TLB. Consider the following scenario:

   1. vcpu0 and vcpu1 are both running on cpu1. At this point, vcpu0 is 
on cpu1, and a process on it reads a page, which gets cached in the TLB 
(let's call this the "stale TLB entry").
   2. vcpu0 migrates to cpu0, and then the process (on vcpu0, now on 
cpu0) does a CoW (copy-on-write) and establishes a new mapping.
   3. Neither vcpu0 nor vcpu1 migrates again. At this point, the process 
gets scheduled inside the VM onto vcpu1 (which is on cpu1), reads the 
same page, and hits the stale TLB entry.

>> 3. The guest later updates mm A's page table from vcpu0, for example due to
>>     COW. Since the guest still sees mm A as having run only on guest CPU0,
>>     __flush_tlb_range() can choose a local sfence.vma. That local sfence.vma
>>     only affects host CPU0, where vcpu0 is currently running, so the stale
>>     VS-stage entry on host CPU1 remains.
> 
> No need to worry about stale VS-stage entry on host CPU1 because these
> will age-out or same guest may again move to host CPU1 resulting in
> VCPU migration sanitization.
> 
>> 4. Later, the task is scheduled again while vcpu0 is running on host CPU1.

Sorry, that was a typo on my part. 'Later, the task is scheduled again 
while vcpu0 is running on host CPU1' should say vcpu1 instead of vcpu0.

>>     If the ASID is still valid and no deferred ASID rollover flush is pending,
>>     set_mm_asid() may not issue any flush. The access on host CPU1 can then
>>     hit the old VS-stage TLB entry.
> 
> See above comments.
> 
>>
>> We hit this on a XiangShan RISC-V system. A bash task in the guest was
>> scheduled on vcpu0 while that vCPU was running on host CPU1. A read-only
>> page was prefetched and cached in CPU1's VS-stage TLB. Later the same vCPU
>> migrated to host CPU0, the guest triggered COW and updated the mapping, and
>> the guest still issued only a local sfence.vma. The stale VS-stage entry on
>> CPU1 was not invalidated. After running for some time, the task later
>> accessed that mapping while running on host CPU1 again and hit the stale
>> translation. The data in that page was a pointer from the GOT, so it
>> dereferenced to NULL and eventually caused a segmentation fault.
> 
> The above example is already taken care by TLB flushes in KVM RISC-V.
> This smells like some HW errata to me.
> 
>>
>> I checked current upstream RISC-V KVM (v7.0.2) and I do not see HSTATUS.VTVM
>> being enabled, so guest sfence.vma is not trapped. I found
>> kvm_riscv_local_tlb_sanitize() on host CPU migration, which handles G-stage
>> VMID entries on the current host CPU, but I do not think it generally solves
>> the stale VS-stage TLB case described above.
>>
>> I also noticed the vendor-specific kvm_riscv_vsstage_tlb_no_gpa path in
>> current upstream. It looks like a workaround for a particular implementation
>> issue on Andes AX66, where the VS-stage TLB does not cache guest physical
>> address and VMID, so the normal VMID/GPA-based invalidation model is
>> insufficient. In that sense, it does not seem to be a generic solution for
>> guest sfence.vma coherence across vCPU migration.
>>
>> I am wondering what the right direction should be. Enabling HSTATUS.VTVM and
>> trapping guest sfence.vma would allow KVM to translate guest local sfence.vma
>> into the required host-side hfence.vvma, but that may be too heavy for the
>> common case. Another possible direction may be to make the current
>> Andes-specific vCPU migration flush logic more generic, so implementations
>> that need VS-stage TLB sanitization on vCPU migration can opt in through a
>> common mechanism. A third possibility may be to define a lightweight SBI
>> interface for guest local sfence.vma, so Linux could use it in
>> __flush_tlb_range() for the local case when running under KVM, and KVM could
>> then decide whether a local sfence.vma is sufficient or whether host-side
>> hfence.vvma is also needed.
> 
> Enabling HSTATUS.VTVM has a big impact on performance so certainly
> NACK from myside.
> 
>>
>> My questions are:
>> 1. Is the behavior above expected on current RISC-V KVM?
> 
> Yes, it should work fine unless there is some HW bug.
> 
>> 2. If not, what would be the preferred fix direction?
>> 3. Should this be handled by trapping guest sfence.vma with VTVM, by
>>     generalizing the existing vCPU-migration VS-stage TLB flush logic, or by
>>     adding a lighter SBI-mediated path for guest local sfence.vma?
>> 4. Or is there another intended mechanism to keep VS-stage TLB state coherent
>>     across vCPU migration?
>>
>> If needed, I can send a reproducer and the exact hardware/kernel details.
>>
> 
> Even if you share some reporducing code sequence, we still have don't
> have access to your HW so it won't help much.
> 
> Regards,
> Anup

