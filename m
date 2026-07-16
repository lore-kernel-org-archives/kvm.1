Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0623223DFF
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 06:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784182969; cv=none; b=brFCUdWgJ0gn/biJDbLec+5yI+V9yDCSPqKb61hlDYmlR5BPxitDND0vuHTgR0ElMBd0yS+TdUXDgCzmrsKftOY7QkU9yHpJHYpOUQyG+gWpKosgYZe2XKMTC4aZWiO9UbAcR5GlXH/dazQeGAlzEYEB/QBonTub4aOap8Q6dN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784182969; c=relaxed/simple;
	bh=xRnDEBlWCIFl2WCdNlTAWAbelcBLDP2ZuWJdJbE0ipc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Hg0EttLucLae7ZtOmP5mG26i+T8Dxk9QxiN+M0YF3bJb3AVePbitZvOQKzjcz7a0Rg1iekyGAbPz3UICDBFV9CM9df+nbfaozJUj6ScSWpLYq0JJ7mFv0foX0Ny7e6n+KUHLhWF0qbBv85R5ZahA9osVFjEg1m2b/FltI2fF2rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxCOuyeFhqxRcEAA--.16388S3;
	Thu, 16 Jul 2026 14:22:42 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxDceteFhq_q4OAA--.6820S2;
	Thu, 16 Jul 2026 14:22:40 +0800 (CST)
Subject: Re: [PATCH v4 0/3] LoongArch: KVM: Add PV TLB flush support
To: Tao Cui <cui.tao@linux.dev>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, loongarch@lists.linux.dev
Cc: kernel@xen0n.name, kvm@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
References: <20260615082154.42144-1-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <438d76ac-b447-1613-1c00-7c2186ac4014@loongson.cn>
Date: Thu, 16 Jul 2026 14:22:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260615082154.42144-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxDceteFhq_q4OAA--.6820S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3XFy7AFWDCrWfXrWfury5ZFc_yoW7tw47pF
	W2vFn5Kr4kGFyfAanrtw1Iqr9YvrWfJa13Xa4ak34rZws8Gr10krySkrykXF1DX3WfWrWF
	gF1kZr9IqF17AagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz2NtUUUUU=



On 2026/6/15 下午4:21, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> This series implements paravirtualized TLB flush for LoongArch KVM
> guests.
> 
> In multi-vCPU KVM guests, remote TLB flushes broadcast IPIs to all
> target vCPUs, including those preempted by the host. Sending IPIs to
> preempted vCPUs causes unnecessary VM exits and grows with vCPU count,
> becoming severe in overcommitted deployments.
> 
> Reuse the existing steal-time shared memory page by adding a new
> KVM_VCPU_FLUSH_TLB flag to the preempted byte. On the guest side,
> skip IPIs to preempted vCPUs and set the flag via cmpxchg instead.
> On the host side, when re-entering a vCPU in kvm_update_stolen_time(),
> check and clear the flag; if set, drop the VPID to trigger a full TLB
> flush on the next VM entry. No new shared memory page, hypercall, or
> Kconfig option is needed.
After a second thought, the PV TLB flush can only work on hardware PTW, 
there is problem on software PTW.

With TLB flush flow, the current CPU sends IPI interrupter to other CPUs 
to flush TLB. With software PTW, other CPUs may execute TLB refill or 
TLB exception with interrupt disabled. IPI interrupt will not trigger 
until TLB refill/exception finishes, however with PV TLB method, other 
vCPUs will trap to host and flush TLBs, and continue to execute TLB 
refill/exception, stale TLB may be added.

Regards
Bibo Mao
> 
> The feature is advertised through the existing KVM PV feature
> negotiation: the kernel exposes KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH as
> a VM-level capability, and userspace (QEMU) sets
> KVM_FEATURE_PV_TLB_FLUSH in the guest's CPUCFG_KVM_FEATURE mask after
> probing it. A corresponding QEMU patch ("target/loongarch: Enable PV
> TLB flush advertisement to the guest") is posted alongside this
> series.
> 
> - Host side: only trace a PV TLB flush request when one is observed.
> - (Carried over) Host uses amand_db.w to atomically read and clear the
>    preempted byte; selftest gained input validation and failure cleanup.
> 
> Testing: the PV TLB flush path itself is unchanged from v3, so the
> benchmark numbers below still hold.  Note that, unlike v3, the feature
> must now be enabled by userspace: run a QEMU built with the companion
> patch (or with -cpu kvm-pv-tlb-flush=on) so the guest actually observes
> KVM_FEATURE_PV_TLB_FLUSH.  Boot a 32-vCPU guest and run the selftest
> inside it with sleep-idle (PV helps) and busy-spin (PV cannot optimize)
> modes respectively:
> 
>    qemu-system-loongarch64 \
>      -m 4G -smp 32 --cpu la464 --machine virt \
>      -bios .../QEMU_EFI.fd \
>      -kernel .../vmlinuz-...-pvtlb-v4+ \
>      -initrd /tmp/ramdisk_test.gz \
>      -serial mon:stdio \
>      -netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
>      -device virtio-net-pci,netdev=net0 \
>      -append "root=/dev/ram rdinit=/sbin/init console=ttyS0,115200" -nographic
> 
>    # PV TLB flush enabled (idle threads sleep, vCPUs get preempted)
>    guest# ./pv_tlb_flush_test 1 31 50000 0
> 
>    # Baseline (idle threads busy-spin, all vCPUs stay active)
>    guest# ./pv_tlb_flush_test 1 31 50000 1
> 
>    With PV TLB flush (sleep idle):    ~152,285 ns/flush
>    Without PV TLB flush (busy-spin):  ~481,045 ns/flush
> 
>    Improvement: ~68% latency reduction (~3.2x throughput increase)
> 
> Tao Cui (3):
>    LoongArch: KVM: Add PV TLB flush support via steal-time shared memory
>    LoongArch: KVM: Implement guest-side PV TLB flush
>    KVM: selftests: loongarch: Add PV TLB flush performance test
> 
>   arch/loongarch/include/asm/kvm_host.h              |   1 +
>   arch/loongarch/include/asm/kvm_para.h              |   9 +
>   arch/loongarch/include/asm/paravirt.h              |  21 +++
>   arch/loongarch/include/uapi/asm/kvm.h              |   1 +
>   arch/loongarch/include/uapi/asm/kvm_para.h         |   1 +
>   arch/loongarch/kernel/paravirt.c                   |  60 ++++++
>   arch/loongarch/kernel/smp.c                        |  30 +++-
>   arch/loongarch/kvm/trace.h                         |  15 ++
>   arch/loongarch/kvm/vcpu.c                          |  34 +++-
>   arch/loongarch/kvm/vm.c                            |   3 +
>   .../selftests/kvm/loongarch/pv_tlb_flush_test.c    | 194 +++++++++++++++++++++
>   11 files changed, 362 insertions(+), 7 deletions(-)
> 
> ---
> Changes in v4:
> - Drop the "Preserve auto-enabled PV features on userspace override"
>    patch: forcing auto-enabled features back on is migration-unsafe, and
>    for PV TLB flush (which cannot degrade gracefully) a missed flush
>    would corrupt the guest.  Enablement now follows the usual KVM model
>    -- the kernel advertises KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH and
>    userspace (QEMU) explicitly sets KVM_FEATURE_PV_TLB_FLUSH after
>    probing it; a companion QEMU patch is posted alongside, and the
>    feature can be kept off for an older destination
>    (-cpu kvm-pv-tlb-flush=off).
> 
> Changes in v3:
> - Host side: replace amswap_db.w with amand_db.w to atomically read
>    and clear only the preempted byte, preserving the pad bytes for
>    future UAPI use.  Issue a normal load (unsafe_get_user) before the
>    atomic amand_db.w to avoid operating on stale cache data.
> - Host side: move the pv_auto_features OR operation before the
>    compatibility check in kvm_loongarch_cpucfg_set_attr() so that
>    userspace does not need updating for pure kernel-internal PV
>    feature additions.
> - Selftest: add input validation, error checking on pthread_create,
>    and cleanup handling on failure.
> 
> Changes in v2:
> - Host side: replace non-atomic unsafe_get_user + unsafe_put_user with
>    atomic amswap_db.w inline assembly. This fixes two issues:
>    1) unsafe_put_user failure could skip the TLB flush entirely
>    2) non-atomic read+write race with guest-side try_cmpxchg could
>       cause FLUSH_TLB requests to be lost
> - Guest side: consolidate two separate READ_ONCE calls into a single
>    READ_ONCE to eliminate a TOCTOU race where the host could clear
>    preempted between the two reads. Also switch from byte-sized
>    try_cmpxchg to 32-bit try_cmpxchg on the aligned word containing
>    preempted.
> 

