Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931D331D381
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 03:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260598; cv=none; b=P/bsvLaEjD2WbFYcU0f4ITH1Ke5mz3Oexx0fkOI/SXvTzAyJm5LhXZxPYLeUxcUQKHVM3JCfMfUKfk3StcbMDmtpxiC6a0G6aBTwBbDAGbOYo2NqFFFQgnI9rWLewdBSMxm4p8W9Ti5QVvKgNreVGyBuZZvvUjFgNnCrsmv0oIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260598; c=relaxed/simple;
	bh=LLSZBIItncLT1iUlCPGpnHKLAV2kP9fcaP7JuuGGMNI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qwqsyreh90obAxa/WDbTt78Yn07u5HHFBs2OOCycvrIbXwPQLjeGo02q37XnOvTi2fraogyZlcsqj4GzmMbOFNJTIBvt5ClLAUVYrBkvm57vNMptC7m9OTtG2Eo4G4b+J6Y7lLZkHAF1UZ4qYRbKGwss6la5WhNqj6E8MAnmHyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wfdvMSQA; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wfdvMSQA"
Message-ID: <0bfeca34-cdfe-4b05-a216-b57f3d00ed7f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784260584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z272v53xlK5duJ9auTGDKTNLFATzwCEZcMiF1eHGdcM=;
	b=wfdvMSQA1+4SHUilEN7yxR20jQKblFQ7TW9E0TvR7fzn0ywQrXgBoS/gfODnwPqfOF/ETd
	xS9oDdAzyCQWjZ+wnB9ZLu2wqcm49DVAAfwIBhEZivPE/H6Yu0bz81bt1avTX3R+zdfWLF
	psJI6p/j8h8bX9WKJRkJEi/E/UHjhLo=
Date: Fri, 17 Jul 2026 11:56:10 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, kernel@xen0n.name, kvm@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v4 0/3] LoongArch: KVM: Add PV TLB flush support
To: Bibo Mao <maobibo@loongson.cn>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, loongarch@lists.linux.dev
References: <20260615082154.42144-1-cui.tao@linux.dev>
 <438d76ac-b447-1613-1c00-7c2186ac4014@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <438d76ac-b447-1613-1c00-7c2186ac4014@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/7/16 14:22, Bibo Mao 写道:
> 
> 
> On 2026/6/15 下午4:21, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> This series implements paravirtualized TLB flush for LoongArch KVM
>> guests.
>>
>> In multi-vCPU KVM guests, remote TLB flushes broadcast IPIs to all
>> target vCPUs, including those preempted by the host. Sending IPIs to
>> preempted vCPUs causes unnecessary VM exits and grows with vCPU count,
>> becoming severe in overcommitted deployments.
>>
>> Reuse the existing steal-time shared memory page by adding a new
>> KVM_VCPU_FLUSH_TLB flag to the preempted byte. On the guest side,
>> skip IPIs to preempted vCPUs and set the flag via cmpxchg instead.
>> On the host side, when re-entering a vCPU in kvm_update_stolen_time(),
>> check and clear the flag; if set, drop the VPID to trigger a full TLB
>> flush on the next VM entry. No new shared memory page, hypercall, or
>> Kconfig option is needed.
> After a second thought, the PV TLB flush can only work on hardware PTW, there is problem on software PTW.
> 
> With TLB flush flow, the current CPU sends IPI interrupter to other CPUs to flush TLB. With software PTW, other CPUs may execute TLB refill or TLB exception with interrupt disabled. IPI interrupt will not trigger until TLB refill/exception finishes, however with PV TLB method, other vCPUs will trap to host and flush TLBs, and continue to execute TLB refill/exception, stale TLB may be added.
> 

Sorry for that.

This is indeed something I had overlooked -- thank you for catching it. It
is a correctness issue, not just a performance one, so it has to gate the
feature.

I understand the race exactly as you describe it. With software PTW, a
TLB miss runs the guest's refill handler with interrupts disabled, and
that handler may already have loaded the old PTE into a register. A
native remote flush sends an IPI, but the IPI is held until IE is
re-enabled, so the flush always lands *after* the refill completes -- any
stale entry the refill wrote gets purged. The PV path breaks this: the
host flushes the target's TLB (drops the VPID) at an arbitrary instant,
then the target resumes its disabled refill handler and writes the stale
entry back with tlbfill/tlbwr, and nothing flushes it afterwards. The
same applies to the steal-time variant if a vCPU is preempted mid-refill:
it is flushed on re-entry and then resumes the refill. Only a hardware
PTW is safe, because the refill is atomic and always reads the current
table.

So the feature must only be offered when the guest actually uses a
hardware PTW. The real condition is on the *guest* -- a -cpu la464 guest
still does software refill even on a PTW host -- so the host gate alone
is not enough; a non-PTW guest must not observe the feature either.

For the host side, cpu_has_ptw is the natural precondition, and there's
already a precedent in kvm_vm_init_features() where
KVM_LOONGARCH_VM_FEAT_PTW is gated on cpu_has_ptw. I'd wrap the
advertisement the same way:

    if (cpu_has_ptw) {
        kvm->arch.pv_features  |= BIT(KVM_FEATURE_PV_TLB_FLUSH);
        kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH);
    }

For the guest side: the guest discovers the feature by reading the
CPUCFG_KVM_FEATURE leaf, so if feasible I'd mask KVM_FEATURE_PV_TLB_FLUSH
off right there -- in kvm_emu_cpucfg() (the CPUCFG_KVM_FEATURE case in
exit.c) and the matching one_reg getter kvm_loongarch_cpucfg_get_attr()
in vcpu.c -- whenever the guest's own CPUCFG2.PTW (vcpu->arch.cpucfg[2],
bit 24) is clear. The equivalent could also be done in QEMU alongside
the companion patch, since QEMU already controls the guest model's PTW
bit. Both look implementable; I'll need to actually test them to see how
they behave.

On the hardware side, I checked the box I ran the benchmarks on. It
reports as a 3A6000 / LA664, but reading CPUCFG2 directly gives 0x7e7cccc7
with the PTW bit (24) clear, so it has no hardware PTW either -- likely
an early part. Your 3C5000 is LA464, which is software PTW too. That
means the ebizzy and tlb_bench numbers I shared earlier were collected
with PV TLB flush active on a -cpu la464 (software-refill) guest, i.e.
exactly the unsafe configuration you pointed out. They show the mechanism
works and its direction (hypercall ahead of steal-time, and PV preventing
the overcommit collapse), but they were measured in a correctness-broken
config, so I won't use them to justify enabling the feature on
software-PTW silicon.

For now I don't have a PTW-capable machine to test on. My reading is that
a software-PTW-safe variant isn't really possible -- the native IPI is
safe precisely because the flush is deferred past the IE=0 refill window,
and a host-side flush can't reproduce that ordering without effectively
becoming an IPI again. I'll spend some time confirming that, but
unless I've missed something, gating to hardware-PTW guests is the
answer.

Thanks,
Tao

> Regards
> Bibo Mao
>>
>> The feature is advertised through the existing KVM PV feature
>> negotiation: the kernel exposes KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH as
>> a VM-level capability, and userspace (QEMU) sets
>> KVM_FEATURE_PV_TLB_FLUSH in the guest's CPUCFG_KVM_FEATURE mask after
>> probing it. A corresponding QEMU patch ("target/loongarch: Enable PV
>> TLB flush advertisement to the guest") is posted alongside this
>> series.
>>
>> - Host side: only trace a PV TLB flush request when one is observed.
>> - (Carried over) Host uses amand_db.w to atomically read and clear the
>>    preempted byte; selftest gained input validation and failure cleanup.
>>
>> Testing: the PV TLB flush path itself is unchanged from v3, so the
>> benchmark numbers below still hold.  Note that, unlike v3, the feature
>> must now be enabled by userspace: run a QEMU built with the companion
>> patch (or with -cpu kvm-pv-tlb-flush=on) so the guest actually observes
>> KVM_FEATURE_PV_TLB_FLUSH.  Boot a 32-vCPU guest and run the selftest
>> inside it with sleep-idle (PV helps) and busy-spin (PV cannot optimize)
>> modes respectively:
>>
>>    qemu-system-loongarch64 \
>>      -m 4G -smp 32 --cpu la464 --machine virt \
>>      -bios .../QEMU_EFI.fd \
>>      -kernel .../vmlinuz-...-pvtlb-v4+ \
>>      -initrd /tmp/ramdisk_test.gz \
>>      -serial mon:stdio \
>>      -netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
>>      -device virtio-net-pci,netdev=net0 \
>>      -append "root=/dev/ram rdinit=/sbin/init console=ttyS0,115200" -nographic
>>
>>    # PV TLB flush enabled (idle threads sleep, vCPUs get preempted)
>>    guest# ./pv_tlb_flush_test 1 31 50000 0
>>
>>    # Baseline (idle threads busy-spin, all vCPUs stay active)
>>    guest# ./pv_tlb_flush_test 1 31 50000 1
>>
>>    With PV TLB flush (sleep idle):    ~152,285 ns/flush
>>    Without PV TLB flush (busy-spin):  ~481,045 ns/flush
>>
>>    Improvement: ~68% latency reduction (~3.2x throughput increase)
>>
>> Tao Cui (3):
>>    LoongArch: KVM: Add PV TLB flush support via steal-time shared memory
>>    LoongArch: KVM: Implement guest-side PV TLB flush
>>    KVM: selftests: loongarch: Add PV TLB flush performance test
>>
>>   arch/loongarch/include/asm/kvm_host.h              |   1 +
>>   arch/loongarch/include/asm/kvm_para.h              |   9 +
>>   arch/loongarch/include/asm/paravirt.h              |  21 +++
>>   arch/loongarch/include/uapi/asm/kvm.h              |   1 +
>>   arch/loongarch/include/uapi/asm/kvm_para.h         |   1 +
>>   arch/loongarch/kernel/paravirt.c                   |  60 ++++++
>>   arch/loongarch/kernel/smp.c                        |  30 +++-
>>   arch/loongarch/kvm/trace.h                         |  15 ++
>>   arch/loongarch/kvm/vcpu.c                          |  34 +++-
>>   arch/loongarch/kvm/vm.c                            |   3 +
>>   .../selftests/kvm/loongarch/pv_tlb_flush_test.c    | 194 +++++++++++++++++++++
>>   11 files changed, 362 insertions(+), 7 deletions(-)
>>
>> ---
>> Changes in v4:
>> - Drop the "Preserve auto-enabled PV features on userspace override"
>>    patch: forcing auto-enabled features back on is migration-unsafe, and
>>    for PV TLB flush (which cannot degrade gracefully) a missed flush
>>    would corrupt the guest.  Enablement now follows the usual KVM model
>>    -- the kernel advertises KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH and
>>    userspace (QEMU) explicitly sets KVM_FEATURE_PV_TLB_FLUSH after
>>    probing it; a companion QEMU patch is posted alongside, and the
>>    feature can be kept off for an older destination
>>    (-cpu kvm-pv-tlb-flush=off).
>>
>> Changes in v3:
>> - Host side: replace amswap_db.w with amand_db.w to atomically read
>>    and clear only the preempted byte, preserving the pad bytes for
>>    future UAPI use.  Issue a normal load (unsafe_get_user) before the
>>    atomic amand_db.w to avoid operating on stale cache data.
>> - Host side: move the pv_auto_features OR operation before the
>>    compatibility check in kvm_loongarch_cpucfg_set_attr() so that
>>    userspace does not need updating for pure kernel-internal PV
>>    feature additions.
>> - Selftest: add input validation, error checking on pthread_create,
>>    and cleanup handling on failure.
>>
>> Changes in v2:
>> - Host side: replace non-atomic unsafe_get_user + unsafe_put_user with
>>    atomic amswap_db.w inline assembly. This fixes two issues:
>>    1) unsafe_put_user failure could skip the TLB flush entirely
>>    2) non-atomic read+write race with guest-side try_cmpxchg could
>>       cause FLUSH_TLB requests to be lost
>> - Guest side: consolidate two separate READ_ONCE calls into a single
>>    READ_ONCE to eliminate a TOCTOU race where the host could clear
>>    preempted between the two reads. Also switch from byte-sized
>>    try_cmpxchg to 32-bit try_cmpxchg on the aligned word containing
>>    preempted.
>>
> 

