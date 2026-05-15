Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2912F34D911;
	Fri, 15 May 2026 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856838; cv=none; b=f+GLgfBddSkQyJ3SVQeK2h3/mN9NRTSimpUPxLnp9ucXQHkkNPSd88LECjm2fcHk5L28lQ5FzJz9ipjz3kZOoayxMxfMEdl/HZ+IEVKnQI4a5G8L1aiIeV+ukpUqc0RtVIWkwlp6srarwjOAAzysTTOaXTsVr7RLr6xUY4OWILo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856838; c=relaxed/simple;
	bh=wIonUIIdp2YHfgf1ZJBmMi6LqA8jUQTnaIfUBJRkULI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjclGmEeMeHu9J4ROGGTCjhZnNDJKqfbwa0C9WXzI8HL+xr+f+o8DWPtS+BrkrH4sIUQTlsNL2ik/FG3pshwJHq7S/6zJRNfftBunWISicRgazpkQsv9+RYXU9xcELPKl6TMExZfZp35GOxGAXjPiKglwASLpy+rbT36QbQ7m5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D0AA2A06C2;
	Fri, 15 May 2026 16:53:44 +0200 (CEST)
Message-ID: <c5b71519-a129-4711-8f98-f05b3178a96d@proxmox.com>
Date: Fri, 15 May 2026 16:53:42 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/28] KVM: combined patchset for MBEC/GMET support
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, jon@nutanix.com,
 chao.gao@intel.com, Sean Christopherson <seanjc@google.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
 <85548beb-1486-40f9-beb4-632c78e3360b@proxmox.com>
 <CABgObfZ-UOjO4q3e9o5JGXXCO8VZ50vEZkjNMB44rdcCVxEHxg@mail.gmail.com>
Content-Language: en-US
From: David Riley <d.riley@proxmox.com>
In-Reply-To: <CABgObfZ-UOjO4q3e9o5JGXXCO8VZ50vEZkjNMB44rdcCVxEHxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1778856815114

Hi Paolo, Hi Chao, Hi Sean,

I have been testing the v6 patchset (up to 22/28) this time on Arrow
Lake hardware. My results suggest a kernel version dependent regression
regarding host stability.

Environment:
* Host CPU: Intel(R) Core(TM) Ultra 7 265K (Arrow Lake)
* Motherboard: Gigabyte Z890 EAGLE (BIOS F18)
* Host OS: Proxmox VE based on Debian Trixie
* Host Kernel: mainline with patches 1-22/28 applied.
* Guest OS: Windows Server 2026 (24H2, Build 26100.1742) with VBS/Hyper-V
   enabled.
* QEMU Command: -cpu host,level=30,+vmx-mbec,+cet-ss,+cet-ibt

Results for Kernel 7.1.0-rc3 + v6 patches 1-22:
I can reproduce the guest failing to boot. This setup causes host lockups on
my Arrow Lake machine. In some cases, the guest manages to reach Windows
Recovery, but most of the time it does not.

@Chao, in the first line you can see the hard lockup. Also have a look at the
hrtimer trap I tested below.

dmesg output:
[Fri May 15 13:07:37 2026] watchdog: CPU1: Watchdog detected hard LOCKUP on cpu 1
...
[Fri May 15 13:07:37 2026] CPU: 1 UID: 0 PID: 3327 Comm: CPU 0/KVM Tainted: G            E  7.1.0-rc3-v7.1-rc3-v6-p22-00022-g9ba8d1bdd861-dirty #31 PREEMPT(lazy)
[Fri May 15 13:07:37 2026] Tainted: [E]=UNSIGNED_MODULE
[Fri May 15 13:07:37 2026] Hardware name: Gigabyte Technology Co., Ltd. Z890 EAGLE/Z890 EAGLE, BIOS F18 11/27/2025
[Fri May 15 13:07:37 2026] RIP: 0010:vmx_do_nmi_irqoff+0x13/0x20 [kvm_intel]
[Fri May 15 13:07:37 2026] Code: 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 48 89 e5 48 83 e4 f0 6a 18 55 9c 6a 10 e8 5d cc ca f1 <c9> c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90
[Fri May 15 13:07:37 2026] RSP: 0018:ffffcdf58fdf7c28 EFLAGS: 00000082
[Fri May 15 13:07:37 2026] RAX: 0000000080000200 RBX: ffff8baa8a6f4900 RCX: 0000000000000000
[Fri May 15 13:07:37 2026] RDX: 0000000080000202 RSI: 0000000000000000 RDI: ffff8baa8a6f4900
[Fri May 15 13:07:37 2026] RBP: ffffcdf58fdf7c28 R08: 0000000000000000 R09: 0000000000000000
[Fri May 15 13:07:37 2026] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[Fri May 15 13:07:37 2026] R13: 0000000000000000 R14: 0000000000000004 R15: ffff8bab70170000
[Fri May 15 13:07:37 2026] FS:  0000756cc330a6c0(0000) GS:ffff8bba5a58a000(0000) knlGS:fffff8031fbbd000
[Fri May 15 13:07:37 2026] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Fri May 15 13:07:37 2026] CR2: 00007fffffff0000 CR3: 00000001152c2001 CR4: 0000000008f72ef0
[Fri May 15 13:07:37 2026] PKRU: 55555554
[Fri May 15 13:07:37 2026] Call Trace:
[Fri May 15 13:07:37 2026]  <TASK>
[Fri May 15 13:07:37 2026]  vmx_handle_nmi+0x9a/0x140 [kvm_intel]
[Fri May 15 13:07:37 2026]  vmx_vcpu_enter_exit+0x18f/0x300 [kvm_intel]
[Fri May 15 13:07:37 2026]  vmx_vcpu_run+0x1d2/0x12c0 [kvm_intel]
[Fri May 15 13:07:37 2026]  vt_vcpu_run+0x1a/0x40 [kvm_intel]
[Fri May 15 13:07:37 2026]  kvm_arch_vcpu_ioctl_run+0x69e/0x18e0 [kvm]
[Fri May 15 13:07:37 2026]  ? fire_user_return_notifiers+0x37/0x70
[Fri May 15 13:07:37 2026]  ? __x64_sys_ioctl+0xbf/0x100
[Fri May 15 13:07:37 2026]  kvm_vcpu_ioctl+0x312/0xba0 [kvm]
[Fri May 15 13:07:37 2026]  ? __x64_sys_ioctl+0xbf/0x100
[Fri May 15 13:07:37 2026]  ? kvm_on_user_return+0x4a/0x90 [kvm]
[Fri May 15 13:07:37 2026]  ? fire_user_return_notifiers+0x37/0x70
[Fri May 15 13:07:37 2026]  ? do_syscall_64+0x396/0x14c0
[Fri May 15 13:07:37 2026]  __x64_sys_ioctl+0xa5/0x100
[Fri May 15 13:07:37 2026]  x64_sys_call+0x103b/0x2390
[Fri May 15 13:07:37 2026]  do_syscall_64+0xe6/0x14c0
[Fri May 15 13:07:37 2026]  ? fire_user_return_notifiers+0x37/0x70
[Fri May 15 13:07:37 2026]  ? do_syscall_64+0x396/0x14c0
[Fri May 15 13:07:37 2026]  ? fire_user_return_notifiers+0x37/0x70
[Fri May 15 13:07:37 2026]  ? do_syscall_64+0x396/0x14c0
[Fri May 15 13:07:37 2026]  ? do_syscall_64+0x9b/0x14c0
[Fri May 15 13:07:37 2026] entry_SYSCALL_64_after_hwframe+0x76/0x7e
[Fri May 15 13:07:37 2026] RIP: 0033:0x756cc783091b
[Fri May 15 13:07:37 2026] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[Fri May 15 13:07:37 2026] RSP: 002b:0000756cc3305b30 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[Fri May 15 13:07:37 2026] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 0000756cc783091b
[Fri May 15 13:07:37 2026] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000020
[Fri May 15 13:07:37 2026] RBP: 00005a973691c030 R08: 0000000000000000 R09: 0000000000000000
[Fri May 15 13:07:37 2026] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[Fri May 15 13:07:37 2026] R13: 0000000000000001 R14: 0000000000000608 R15: 0000000000000000
[Fri May 15 13:07:37 2026]  </TASK>

Output from trace-cmd when the guest gets stuck:
        CPU 0/KVM-6610  [001] d..2.   709.333183: kvm_apic_accept_irq:  apicid 0 vec 209 (Fixed|edge)
        CPU 0/KVM-6610  [001] d..2.   709.333183: kvm_apicv_accept_irq: apicid 0 vec 209 (Fixed|edge)
        CPU 0/KVM-6610  [001] d..3.   709.333183: kvm_hv_timer_state:   vcpu_id 0 hv_timer 1
        CPU 0/KVM-6610  [001] d..1.   709.333183: kvm_entry:      vcpu 0 rip 0xfffff800b49020ec
        CPU 0/KVM-6610  [001] d..1.   709.333183: kvm_wait_lapic_expire: vcpu 0: delta 460 (late)
        CPU 0/KVM-6610  [001] d..1.   709.348806: kvm_exit:      reason PREEMPTION_TIMER rip 0xfffff800b49020ec info 0 0
        CPU 0/KVM-6610  [001] d..2.   709.348806: kvm_apic_accept_irq:  apicid 0 vec 209 (Fixed|edge)
        CPU 0/KVM-6610  [001] d..2.   709.348806: kvm_apicv_accept_irq: apicid 0 vec 209 (Fixed|edge)
        CPU 0/KVM-6610  [001] d..3.   709.348806: kvm_hv_timer_state:   vcpu_id 0 hv_timer 1
        CPU 0/KVM-6610  [001] d..1.   709.348806: kvm_entry:      vcpu 0 rip 0xfffff800b49020ec
        CPU 0/KVM-6610  [001] d..1.   709.348807: kvm_wait_lapic_expire: vcpu 0: delta -1624 (late)

and
trace-cmd report |grep  -e msr_write.*da0| sed 's/.*kvm_/kvm_/' | sort -u
kvm_msr:              msr_write da0 = 0x800


If I run:
sudo modprobe -r kvm_intel
sudo modprobe kvm_intel preemption_timer=0

I am able to boot into windows sometimes.

And other times it enters a endless loop:
boots into windows recovery mode:
        CPU 0/KVM-18245 [001] .....  2628.320804: kvm_fpu:     unload
        CPU 0/KVM-18245 [001] .....  2628.320804: kvm_userspace_exit:   reason KVM_EXIT_IO (2)
        CPU 0/KVM-18245 [001] .....  2628.320805: kvm_fpu:     load
        CPU 0/KVM-18245 [001] .....  2628.320805: kvm_pio:     pio_read at 0x608 size 4 count 1 val 0xe1d664
        CPU 0/KVM-18245 [001] d..1.  2628.320805: kvm_entry:      vcpu 0 rip 0xfffff807c131bf36
        CPU 0/KVM-18245 [001] d..1.  2628.320806: kvm_exit:      reason IO_INSTRUCTION rip 0xfffff807c131bf35 info 608000b 0
        CPU 0/KVM-18245 [001] .....  2628.320806: kvm_fpu:     unload
        CPU 0/KVM-18245 [001] .....  2628.320807: kvm_userspace_exit:   reason KVM_EXIT_IO (2)
        CPU 0/KVM-18245 [001] .....  2628.320808: kvm_fpu:     load
        CPU 0/KVM-18245 [001] .....  2628.320808: kvm_pio:     pio_read at 0x608 size 4 count 1 val 0xe1d66e
        CPU 0/KVM-18245 [001] d..1.  2628.320808: kvm_entry:      vcpu 0 rip 0xfffff807c131bf36
        CPU 0/KVM-18245 [001] d..1.  2628.320809: kvm_exit:      reason IO_INSTRUCTION rip 0xfffff807c131bf35 info 608000b 0


but I also observed this (Windows is stuck in the boot stage):
        CPU 0/KVM-35230 [001] d..1.  4945.511627: kvm_entry:      vcpu 0 rip 0xfffff804b53020ec
        CPU 0/KVM-35230 [001] d..1.  4945.511632: kvm_exit:      reason EXTERNAL_INTERRUPT rip 0xfffff804b53020ec info 0 0
        CPU 0/KVM-35230 [001] d..1.  4945.511632: kvm_entry:      vcpu 0 rip 0xfffff804b53020ec
        CPU 0/KVM-35230 [001] d..1.  4945.511634: kvm_exit:      reason EXTERNAL_INTERRUPT rip 0xfffff804b53020ec info 0 0
        CPU 0/KVM-35230 [001] d..1.  4945.511635: kvm_entry:      vcpu 0 rip 0xfffff804b53020ec
        CPU 0/KVM-35230 [001] d..1.  4945.511640: kvm_exit:      reason EXTERNAL_INTERRUPT rip 0xfffff804b53020ec info 0 0
        CPU 0/KVM-35230 [001] d..1.  4945.511640: kvm_entry:      vcpu 0 rip 0xfffff804b53020ec
        CPU 0/KVM-35230 [001] d..1.  4945.730129: kvm_exit:      reason EXTERNAL_INTERRUPT rip 0xfffff804b53020f7 info 0 0
        CPU 0/KVM-35230 [001] .....  4945.730145: kvm_apic_accept_irq:  apicid 0 vec 209 (Fixed|edge)
        CPU 0/KVM-35230 [001] .....  4945.730145: kvm_apicv_accept_irq: apicid 0 vec 209 (Fixed|edge)
        CPU 0/KVM-35230 [001] d..1.  4945.730146: kvm_entry:      vcpu 0 rip 0xfffff804b53020f7
    kvm-pit/35115-35236 [012] .....  4945.730212: kvm_set_irq:     gsi 0 level 1 source 2
    kvm-pit/35115-35236 [012] ...1.  4945.730215: kvm_pic_set_irq:     chip 0 pin 0 (edge|masked)
    kvm-pit/35115-35236 [012] ...1.  4945.730217: kvm_ioapic_set_irq:   pin 2 dst 0 vec 255 (Fixed|physical|edge|masked)
    kvm-pit/35115-35236 [012] .....  4945.730217: kvm_set_irq:     gsi 0 level 0 source 2
    kvm-pit/35115-35236 [012] ...1.  4945.730217: kvm_pic_set_irq:     chip 0 pin 0 (edge|masked)
    kvm-pit/35115-35236 [012] ...1.  4945.730217: kvm_ioapic_set_irq:   pin 2 dst 0 vec 255 (Fixed|physical|edge|masked)
        CPU 0/KVM-35230 [001] d..1.  4945.730559: kvm_exit:      reason EXTERNAL_INTERRUPT rip 0xfffff804b53020ec info 0 0
        CPU 0/KVM-35230 [001] d..1.  4945.730561: kvm_entry:      vcpu 0 rip 0xfffff804b53020ec
        CPU 0/KVM-35230 [001] d..1.  4945.731559: kvm_exit:      reason EXTERNAL_INTERRUPT rip 0xfffff804b53020ec info 0 0
        CPU 0/KVM-35230 [001] d..1.  4945.731560: kvm_entry:      vcpu 0 rip 0xfffff804b53020ec
        CPU 0/KVM-35230 [001] d..1.  4945.732559: kvm_exit:      reason EXTERNAL_INTERRUPT rip 0xfffff804b53020ec info 0 0
        CPU 0/KVM-35230 [001] d..1.  4945.732560: kvm_entry:      vcpu 0 rip 0xfffff804b53020ec
        CPU 0/KVM-35230 [001] d..1.  4945.732934: kvm_exit:      reason EXTERNAL_INTERRUPT rip 0xfffff804b53020ec info 0 0
        CPU 0/KVM-35230 [001] d..1.  4945.732935: kvm_entry:      vcpu 0 rip 0xfffff804b53020ec
        CPU 0/KVM-35230 [001] d..1.  4945.733559: kvm_exit:      reason EXTERNAL_INTERRUPT rip 0xfffff804b53020f7 info 0 0
        CPU 0/KVM-35230 [001] d..1.  4945.733560: kvm_entry:      vcpu 0 rip 0xfffff804b53020f7
        CPU 2/KVM-35232 [006] .....  4945.893095: kvm_halt_poll_ns:     vcpu 2: halt_poll_ns 0 (shrink 10000)
        CPU 2/KVM-35232 [006] .....  4945.893097: kvm_vcpu_wakeup:     wait time 8589893724 ns, polling valid
        CPU 1/KVM-35231 [008] .....  4945.893300: kvm_halt_poll_ns:     vcpu 1: halt_poll_ns 0 (shrink 10000)
        CPU 1/KVM-35231 [008] .....  4945.893302: kvm_vcpu_wakeup:     wait time 8590000199 ns, polling valid
        CPU 3/KVM-35233 [011] .....  4945.893332: kvm_vcpu_wakeup:     wait time 8


Results for Kernel 7.1.0-rc3 + v6 patches 1-22 + hrtimer trap:

I used the mentioned trap from [0]

Before booting the VM I setup tracing and verified that it was on using:
cat /sys/kernel/tracing/tracing_on
1

and after booting the VM, which got stuck again, I checked again and it was
off:
cat /sys/kernel/tracing/tracing_on
0

I have the full compressed trace from this trigger event (captured with the
trap). It is quite large, but I can provide it if needed.


Results for Kernel 7.0.0 + v6 patches 1-22:
I used the same:
* Guest OS: Windows Server 2026 (24H2, Build 26100.1742) with VBS/Hyper-V
   enabled.
* QEMU Command: -cpu host,level=30,+vmx-mbec,+cet-ss,+cet-ibt

This also results in the Windows Guest getting stuck but there are no
indications of CPU lockups.

A trace-cmd shows that the guest is stuck entering and exiting:

        CPU 0/KVM-14938 [001] d..1.  2355.384828: kvm_entry:      vcpu 0 rip 0xfffff805879020ec
        CPU 0/KVM-14938 [001] d..1.  2355.385826: kvm_exit:      reason EXTERNAL_INTERRUPT rip 0xfffff805879020ec info 0 0
        CPU 0/KVM-14938 [001] d..1.  2355.385827: kvm_entry:      vcpu 0 rip 0xfffff805879020ec
        CPU 0/KVM-14938 [001] d..1.  2355.386826: kvm_exit:      reason EXTERNAL_INTERRUPT rip 0xfffff805879020ec info 0 0

And in the trace report:
trace-cmd report |grep  -e msr_write.*da0| sed 's/.*kvm_/kvm_/' | sort -u
kvm_msr:              msr_write da0 = 0x800

Hope this helps, feel free to suggest other tests that I should run.

Best regards,
David

[0] https://lore.kernel.org/kvm/70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com


On 5/12/26 4:30 PM, Paolo Bonzini wrote:
> If possible, could you please check:
>
> 1) whether 7.0 + patches (up to 22/28) also causes the host to hang?
> 2) whether 7.1 + patches (up to 22/28) also causes the host to hang?
>
> to understand if this is a) something caused by our different setup b)
> a regression in 7.1 c) something caused by the last 6 patches?
>

