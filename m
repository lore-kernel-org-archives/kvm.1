Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BC5342523
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271225; cv=none; b=KLr/Q8EK2UCHcuGdJXtsi3dhntA9nB9oJimklpjRz0eHkNkvhULNzo1jI+pPbdGHzh8CZQBpsxU5u9y2EdkkdBFw8UZlWUPCbqCBCWfYubEHJZ7VQzNfwtYEWGIN3m0nyuCV6Lo0dIORyX/D1l+KNR8tdO9SYx5mfazUpfJJyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271225; c=relaxed/simple;
	bh=7zSCmVvcdJN9JJIRTV+6p68FH+VvUtu135WEelO/CBg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NFqMS9XeIPzwlYfwL8GngX1vMHpGC+dBYxGihTAnyomFkAAcNBBLyUlPzlyO2hjoXIgFTySo7pNOIEC6Nfov4Ne4i4cdFuiskleeSaotxySR46YZI+O5pm/Odbxoxh+KY00cyMujI2b9e56KptpPgSScEBfTf3yf3iHhy34pkpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Dxtupx0Vlq8nYEAA--.17855S3;
	Fri, 17 Jul 2026 14:53:37 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxTOVw0VlqqssPAA--.14928S2;
	Fri, 17 Jul 2026 14:53:36 +0800 (CST)
Subject: Re: [PATCH v4 0/3] LoongArch: KVM: Add PV TLB flush support
To: Tao Cui <cui.tao@linux.dev>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, loongarch@lists.linux.dev
Cc: kernel@xen0n.name, kvm@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
References: <20260615082154.42144-1-cui.tao@linux.dev>
 <438d76ac-b447-1613-1c00-7c2186ac4014@loongson.cn>
 <0bfeca34-cdfe-4b05-a216-b57f3d00ed7f@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <ec45b752-630a-a6cf-3f27-e330a9c4204d@loongson.cn>
Date: Fri, 17 Jul 2026 14:53:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0bfeca34-cdfe-4b05-a216-b57f3d00ed7f@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxTOVw0VlqqssPAA--.14928S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Aw1fWr48tFWfJw1DGr43XFc_yoWDtw43pF
	WvvF1rKrZ5Gr1rCwnrJr10qryYyrW8Ja9xXFyayFyrArs8Jr1j9ryIgryv9F1DXw4rWr10
	qFn8XrnxZF17AabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8q2NtUUUUU==



On 2026/7/17 上午11:56, Tao Cui wrote:
> 
> 
> 在 2026/7/16 14:22, Bibo Mao 写道:
>>
>>
>> On 2026/6/15 下午4:21, Tao Cui wrote:
>>> From: Tao Cui <cuitao@kylinos.cn>
>>>
>>> This series implements paravirtualized TLB flush for LoongArch KVM
>>> guests.
>>>
>>> In multi-vCPU KVM guests, remote TLB flushes broadcast IPIs to all
>>> target vCPUs, including those preempted by the host. Sending IPIs to
>>> preempted vCPUs causes unnecessary VM exits and grows with vCPU count,
>>> becoming severe in overcommitted deployments.
>>>
>>> Reuse the existing steal-time shared memory page by adding a new
>>> KVM_VCPU_FLUSH_TLB flag to the preempted byte. On the guest side,
>>> skip IPIs to preempted vCPUs and set the flag via cmpxchg instead.
>>> On the host side, when re-entering a vCPU in kvm_update_stolen_time(),
>>> check and clear the flag; if set, drop the VPID to trigger a full TLB
>>> flush on the next VM entry. No new shared memory page, hypercall, or
>>> Kconfig option is needed.
>> After a second thought, the PV TLB flush can only work on hardware PTW, there is problem on software PTW.
>>
>> With TLB flush flow, the current CPU sends IPI interrupter to other CPUs to flush TLB. With software PTW, other CPUs may execute TLB refill or TLB exception with interrupt disabled. IPI interrupt will not trigger until TLB refill/exception finishes, however with PV TLB method, other vCPUs will trap to host and flush TLBs, and continue to execute TLB refill/exception, stale TLB may be added.
>>
> 
> Sorry for that.
> 
> This is indeed something I had overlooked -- thank you for catching it. It
> is a correctness issue, not just a performance one, so it has to gate the
> feature.
> 
> I understand the race exactly as you describe it. With software PTW, a
> TLB miss runs the guest's refill handler with interrupts disabled, and
> that handler may already have loaded the old PTE into a register. A
> native remote flush sends an IPI, but the IPI is held until IE is
> re-enabled, so the flush always lands *after* the refill completes -- any
> stale entry the refill wrote gets purged. The PV path breaks this: the
> host flushes the target's TLB (drops the VPID) at an arbitrary instant,
> then the target resumes its disabled refill handler and writes the stale
> entry back with tlbfill/tlbwr, and nothing flushes it afterwards. The
> same applies to the steal-time variant if a vCPU is preempted mid-refill:
> it is flushed on re-entry and then resumes the refill. Only a hardware
> PTW is safe, because the refill is atomic and always reads the current
> table.
> 
> So the feature must only be offered when the guest actually uses a
> hardware PTW. The real condition is on the *guest* -- a -cpu la464 guest
> still does software refill even on a PTW host -- so the host gate alone
> is not enough; a non-PTW guest must not observe the feature either.
> 
> For the host side, cpu_has_ptw is the natural precondition, and there's
> already a precedent in kvm_vm_init_features() where
> KVM_LOONGARCH_VM_FEAT_PTW is gated on cpu_has_ptw. I'd wrap the
> advertisement the same way:
> 
>      if (cpu_has_ptw) {
>          kvm->arch.pv_features  |= BIT(KVM_FEATURE_PV_TLB_FLUSH);
>          kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH);
>      }
> 
> For the guest side: the guest discovers the feature by reading the
> CPUCFG_KVM_FEATURE leaf, so if feasible I'd mask KVM_FEATURE_PV_TLB_FLUSH
> off right there -- in kvm_emu_cpucfg() (the CPUCFG_KVM_FEATURE case in
> exit.c) and the matching one_reg getter kvm_loongarch_cpucfg_get_attr()
> in vcpu.c -- whenever the guest's own CPUCFG2.PTW (vcpu->arch.cpucfg[2],
> bit 24) is clear. The equivalent could also be done in QEMU alongside
> the companion patch, since QEMU already controls the guest model's PTW
> bit. Both look implementable; I'll need to actually test them to see how
> they behave.
> 
> On the hardware side, I checked the box I ran the benchmarks on. It
> reports as a 3A6000 / LA664, but reading CPUCFG2 directly gives 0x7e7cccc7
> with the PTW bit (24) clear, so it has no hardware PTW either -- likely
> an early part. Your 3C5000 is LA464, which is software PTW too. That
> means the ebizzy and tlb_bench numbers I shared earlier were collected
> with PV TLB flush active on a -cpu la464 (software-refill) guest, i.e.
> exactly the unsafe configuration you pointed out. They show the mechanism
> works and its direction (hypercall ahead of steal-time, and PV preventing
> the overcommit collapse), but they were measured in a correctness-broken
> config, so I won't use them to justify enabling the feature on
> software-PTW silicon.
> 
> For now I don't have a PTW-capable machine to test on. My reading is that
> a software-PTW-safe variant isn't really possible -- the native IPI is
> safe precisely because the flush is deferred past the IE=0 refill window,
> and a host-side flush can't reproduce that ordering without effectively
> becoming an IPI again. I'll spend some time confirming that, but
> unless I've missed something, gating to hardware-PTW guests is the
PV TLB flush is a good technology, it can be verified again when there 
is hardware with HW PTW supported.

Regards
Bibo Mao
> answer.
> 
> Thanks,
> Tao
> 
>> Regards
>> Bibo Mao
>>>
>>> The feature is advertised through the existing KVM PV feature
>>> negotiation: the kernel exposes KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH as
>>> a VM-level capability, and userspace (QEMU) sets
>>> KVM_FEATURE_PV_TLB_FLUSH in the guest's CPUCFG_KVM_FEATURE mask after
>>> probing it. A corresponding QEMU patch ("target/loongarch: Enable PV
>>> TLB flush advertisement to the guest") is posted alongside this
>>> series.
>>>
>>> - Host side: only trace a PV TLB flush request when one is observed.
>>> - (Carried over) Host uses amand_db.w to atomically read and clear the
>>>     preempted byte; selftest gained input validation and failure cleanup.
>>>
>>> Testing: the PV TLB flush path itself is unchanged from v3, so the
>>> benchmark numbers below still hold.  Note that, unlike v3, the feature
>>> must now be enabled by userspace: run a QEMU built with the companion
>>> patch (or with -cpu kvm-pv-tlb-flush=on) so the guest actually observes
>>> KVM_FEATURE_PV_TLB_FLUSH.  Boot a 32-vCPU guest and run the selftest
>>> inside it with sleep-idle (PV helps) and busy-spin (PV cannot optimize)
>>> modes respectively:
>>>
>>>     qemu-system-loongarch64 \
>>>       -m 4G -smp 32 --cpu la464 --machine virt \
>>>       -bios .../QEMU_EFI.fd \
>>>       -kernel .../vmlinuz-...-pvtlb-v4+ \
>>>       -initrd /tmp/ramdisk_test.gz \
>>>       -serial mon:stdio \
>>>       -netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
>>>       -device virtio-net-pci,netdev=net0 \
>>>       -append "root=/dev/ram rdinit=/sbin/init console=ttyS0,115200" -nographic
>>>
>>>     # PV TLB flush enabled (idle threads sleep, vCPUs get preempted)
>>>     guest# ./pv_tlb_flush_test 1 31 50000 0
>>>
>>>     # Baseline (idle threads busy-spin, all vCPUs stay active)
>>>     guest# ./pv_tlb_flush_test 1 31 50000 1
>>>
>>>     With PV TLB flush (sleep idle):    ~152,285 ns/flush
>>>     Without PV TLB flush (busy-spin):  ~481,045 ns/flush
>>>
>>>     Improvement: ~68% latency reduction (~3.2x throughput increase)
>>>
>>> Tao Cui (3):
>>>     LoongArch: KVM: Add PV TLB flush support via steal-time shared memory
>>>     LoongArch: KVM: Implement guest-side PV TLB flush
>>>     KVM: selftests: loongarch: Add PV TLB flush performance test
>>>
>>>    arch/loongarch/include/asm/kvm_host.h              |   1 +
>>>    arch/loongarch/include/asm/kvm_para.h              |   9 +
>>>    arch/loongarch/include/asm/paravirt.h              |  21 +++
>>>    arch/loongarch/include/uapi/asm/kvm.h              |   1 +
>>>    arch/loongarch/include/uapi/asm/kvm_para.h         |   1 +
>>>    arch/loongarch/kernel/paravirt.c                   |  60 ++++++
>>>    arch/loongarch/kernel/smp.c                        |  30 +++-
>>>    arch/loongarch/kvm/trace.h                         |  15 ++
>>>    arch/loongarch/kvm/vcpu.c                          |  34 +++-
>>>    arch/loongarch/kvm/vm.c                            |   3 +
>>>    .../selftests/kvm/loongarch/pv_tlb_flush_test.c    | 194 +++++++++++++++++++++
>>>    11 files changed, 362 insertions(+), 7 deletions(-)
>>>
>>> ---
>>> Changes in v4:
>>> - Drop the "Preserve auto-enabled PV features on userspace override"
>>>     patch: forcing auto-enabled features back on is migration-unsafe, and
>>>     for PV TLB flush (which cannot degrade gracefully) a missed flush
>>>     would corrupt the guest.  Enablement now follows the usual KVM model
>>>     -- the kernel advertises KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH and
>>>     userspace (QEMU) explicitly sets KVM_FEATURE_PV_TLB_FLUSH after
>>>     probing it; a companion QEMU patch is posted alongside, and the
>>>     feature can be kept off for an older destination
>>>     (-cpu kvm-pv-tlb-flush=off).
>>>
>>> Changes in v3:
>>> - Host side: replace amswap_db.w with amand_db.w to atomically read
>>>     and clear only the preempted byte, preserving the pad bytes for
>>>     future UAPI use.  Issue a normal load (unsafe_get_user) before the
>>>     atomic amand_db.w to avoid operating on stale cache data.
>>> - Host side: move the pv_auto_features OR operation before the
>>>     compatibility check in kvm_loongarch_cpucfg_set_attr() so that
>>>     userspace does not need updating for pure kernel-internal PV
>>>     feature additions.
>>> - Selftest: add input validation, error checking on pthread_create,
>>>     and cleanup handling on failure.
>>>
>>> Changes in v2:
>>> - Host side: replace non-atomic unsafe_get_user + unsafe_put_user with
>>>     atomic amswap_db.w inline assembly. This fixes two issues:
>>>     1) unsafe_put_user failure could skip the TLB flush entirely
>>>     2) non-atomic read+write race with guest-side try_cmpxchg could
>>>        cause FLUSH_TLB requests to be lost
>>> - Guest side: consolidate two separate READ_ONCE calls into a single
>>>     READ_ONCE to eliminate a TOCTOU race where the host could clear
>>>     preempted between the two reads. Also switch from byte-sized
>>>     try_cmpxchg to 32-bit try_cmpxchg on the aligned word containing
>>>     preempted.
>>>
>>

