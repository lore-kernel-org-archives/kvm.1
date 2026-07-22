Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC33233952
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 07:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704441; cv=none; b=feJpTnM9jry3FrHgx827kRti9DwkYW0qr8REZE4Q4IbIciuqtTjewrT61CMtGOiJcdi8nttI8peC4PpiTYji53SAH7F2QQ6UyTxmDa+8YYYJHF4GZFIXA8OkxQq+A6rR5QHv80CKqdchb/suYGHF6x/clrsUlZZCjRqag3lV7gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704441; c=relaxed/simple;
	bh=VS1dG5MsHD7o3mB5wLEzFVOavR4kyNzqFhj6lvRy4mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwGMDNLXDyvMeL1ds9T2dTx6X2AN+8UIWPumAqn6neoOrs6E4cWwQvpabSvaWOhm2Ma4segrvUZEMVymbDDoRcmOh3roEem1HcKHwCzobVFlyx3jCi+5DYhEK2JGQCIJ9iNjloHiwyIw3PQz/QFwAjsjRk9F3NRr41KRtpoN6So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwqfsfgD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyXp+RBs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwqfsfgD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyXp+RBs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784704438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7rw6w9ogoPhqjNbcM3z322xDGoJiejIRBqWFWI2tGvQ=;
	b=IwqfsfgDrczTXQjoUM8ei4ctymqeYUmJOeDyqTpbR7/saOtsIqKxRm43YRc82uJjcp92wB
	mCFAhI3FwLwfreyHO1nK5DkdU64g0TVsyUPqz9eyYG5ZwF8YnZdK724zf6wlQ3QZvwNTJe
	2jIOXhwU089eQygvuahLH4wgjcnN1m8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-rZt3wnv1M_K-Sj7QVVZ92Q-1; Wed, 22 Jul 2026 03:13:57 -0400
X-MC-Unique: rZt3wnv1M_K-Sj7QVVZ92Q-1
X-Mimecast-MFC-AGG-ID: rZt3wnv1M_K-Sj7QVVZ92Q_1784704436
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cec4226c70so198287655ad.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 00:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784704436; x=1785309236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7rw6w9ogoPhqjNbcM3z322xDGoJiejIRBqWFWI2tGvQ=;
        b=gyXp+RBsUgDtyaFLX62Ed4BB8lAaNPFRr+tEbhEYF7C60b60ubeYU3mysiLRafHwip
         BtFCwh/o6GrZ+qkue20YQ4Uu2hyVfVlxfNiD+tfc1HZ3UyjN1Izmu7tXe2lDALl51ChG
         G9EB4lfEp2qEc85CkywMSUOffwJujJFlvp0aoI6sp75RR/vTb5kF7TZvYtSJrWhbs+xj
         qLzVT+swqn2oaBHPmpRZoOoMif9tEwvD0mkUXBjbtrA1Di4AYFluPq8mjLpVh1OYeVwj
         nktUaCNhU4g25kPqGMR33c0pRy4BJKpI8Em770imgewF+/qcl+rCrGcHnuuQzKGPB6vn
         ++MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784704436; x=1785309236;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7rw6w9ogoPhqjNbcM3z322xDGoJiejIRBqWFWI2tGvQ=;
        b=ML8YhO06VFLSDaJPVSdNh3bndmUO20pu2/88sznQDbIc4hyKzuMecNJx9HVqxYnFfA
         Sub/AkKpqqUG3TLEa+T35DgjkqyxyHqDz/2TCDRTLtpKWiBrho9bhm9zRVHc4MeTKlJc
         htrONu4KsTrtedPqobpo0S0B3SCXyezK69rTzZgejdfDisvgPYCd81OJEHSktsq8+Fc+
         H41gRoPBv2JQDe/2YQqUayDnNVhp7zotu86TUWdWcm+OAmw8PeRsky5Yr/BqHXYYpVMh
         zSp2m0EcgvgQcDvhLbuMVgpE4SAMwls6snCAXygy8gS39ns7sEbycnRL8Yxh448Ezx81
         3Yvw==
X-Forwarded-Encrypted: i=1; AHgh+RpxbZdA5a4luoX89IoZH5Ed1KdKEmgA1zXg5s30PoTWu85LM2aNr+A7VEjt9MhWaT+Za7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSSRkXLYEt4O01P0UgDBE28LvfhKQF3e1Au6xBCXTZ1HFWC+W7
	0rYGoOAGJjCMQKll8sgXvMh5LM9XoXjeUG7q3KAKOzOFV9vfvnl5CE5rKh+D4dQc5YPwhxFBMbT
	WXloK7dfSCf79K1prcEOtK4Dzzy3iA0bBID4/2x2H0R+ZFAK16+F6WQ==
X-Gm-Gg: AR+sD12VF/5maR4hwMjLHL/SJZp40QpCK8wMDaF2lBlg1VVESNNZkue7FITyqFcd5xm
	H8d1jnNEb/7h5GZSwsFB4S/0rDKUl6b7AagMpOOatTV0judijQfuDZwpsx3AVId4kXv33CyYfxA
	pxvtSbxlCBGCttIzM67GpdXxCS/VhawOkYABS85TK5wtpBKUXH2tUWzwdudXUvWxskEYb8fXgyL
	+R06EjlSLAEF/08PSFUEEsKsmXYKMv60tqASzxTuHUYZD2TigeM+6EqJI2pRdArGLpOJbiBbQgW
	xCwJIZL87F3Qo24Xy7+hHMvzC3XhNQ+zoHc+bFg/pYyFuRABh99v9MEE9as0pVeOXYBbqo6UKIp
	y3QTXNRAKnx3j3EFGFMPfLLaCPVWpDWLYP3Uss0Vx/bE=
X-Received: by 2002:a17:903:2986:b0:2ce:b7b7:30e3 with SMTP id d9443c01a7336-2cf348575cbmr251669615ad.17.1784704435785;
        Wed, 22 Jul 2026 00:13:55 -0700 (PDT)
X-Received: by 2002:a17:903:2986:b0:2ce:b7b7:30e3 with SMTP id d9443c01a7336-2cf348575cbmr251669305ad.17.1784704435251;
        Wed, 22 Jul 2026 00:13:55 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f3b7c9dsm9207365ad.83.2026.07.22.00.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 00:13:54 -0700 (PDT)
Message-ID: <97a0e92e-ddc7-4eb3-9fcc-7b05bea8b220@redhat.com>
Date: Wed, 22 Jul 2026 17:13:46 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 00/25] Add Realm support to QEMU-VMM
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mathieu,

On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> This patchset provides minimal functionality to start a Realm VM
> from an Arm RME cabable host using the following command line:
> 
> qemu-system-aarch64 -M confidential-guest-support=rme0 -object rme-guest,id=rme0 \
>          -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
> 
> This set is a refactoring of Jean-Philippe Brucker's initial work dating from
> a while back.  It is compatible with Steven Price's v14 revision [1] of his work
> adding CCA support to KVM.
> 
> The RME capable host it was tested on is the QEMU SBSA machine.  For convenicence
> a repository is hosted here [2], along with the TF-A [3], RMM [4] and Linux
> kernel [5] for the SBSA machine (all compatible with Steven's v14 patchset).
> 
> Device Assignment is not included.
> 
>  From hereon I will keep this set up to date with new releases from Steven.
> 
> Thanks,
> Mathieu
> 
> [1]. https://lore.kernel.org/kvm/20260513131757.116630-1-steven.price@arm.com/T/#m06dd14216aaf76acab65b0a76fb84653141ea64f
> [2]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v1?ref_type=heads
> [3]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
> [4]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v14?ref_type=heads
> [5]. https://gitlab.com/Linaro/cca-public/linux/-/tree/cca/v14?ref_type=heads
> 
[...]

Gave this series + (v14) series a try and found the following issues so far. Note
some of the HMP commands like those relevant to migration have been skipped since
we know the migration isn't supported. I list the issues for record and we eventually
need to figure them out one by one.

(1) qemu is terminiated on exeute qmp command 'dump-guest-memory'

(qemu) dump-guest-memory -p "/tmp/mem" 0x40000000 0x10000000
**
ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
Bail out! ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
Aborted

(2) qemu emulation can't be stopped and resumed

(qemu) stop
(qemu) cont
Failed to set KVM_REG_ARM_TIMER_CNT

(3) qemu is terminiated on qmp command 'system_reset'

(qemu) system_reset
cpus are not resettable, terminating

(4) Incompatible to virtio-iommu-pci. The realm guest doesn't boot up with
     a virtio-iommu-pci device

host$ qemu-system-aarch64 -enable-kvm -object rme-guest,id=rme0                \
-machine virt,gic-version=3,confidential-guest-support=rme0                    \
-m 2G -cpu host -smp maxcpus=4,cpus=4,sockets=1,clusters=1,cores=2,threads=2   \
-object memory-backend-ram,id=mem0,size=2G,share=yes                           \
-numa node,nodeid=0,cpus=0-3,memdev=mem0                                       \
-serial mon:stdio -monitor none -nographic -nodefaults                         \
-bios /mnt/edk2/Build/ArmVirtQemu-AARCH64/RELEASE_GCC5/FV/QEMU_EFI.fd          \
-kernel /mnt/linux/arch/arm64/boot/Image                                       \
-initrd /mnt/buildroot/output/images/rootfs.cpio.xz                            \
-append earlycon=pl011,mmio,0x10009000000                                      \
-device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                          \
-device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                          \
-device virtio-iommu-pci,bus=pcie.0                                            \
-netdev tap,id=tap1,vhost=on,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
-device virtio-net-pci,bus=pcie.2,netdev=tap1,mac=b8:3f:d2:1d:3e:c0
         :
UEFI firmware (version  built at 00:09:11 on Jun 30 2026)
         :
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
[    0.000000] Linux version 7.2.0-rc4-gavin-g1590cf032971 (gshan@nvidia-grace-hopper-01.khw.eng.bos2.dc.redhat.com) (gcc (GCC) 14.3.1 20251022 (Red Hat 14.3.1-4), GNU ld version 2.41-65.el10) #46 SMP PREEMPT Mon Jul 20 06:56:20 EDT 2026
[    0.000000] KASLR enabled
[    0.000000] earlycon: pl11 at MMIO 0x0000010009000000 (options '')
[    0.000000] printk: legacy bootconsole [pl11] enabled
[    0.000000] efi: EFI v2.7 by EDK II
[    0.000000] efi: SMBIOS 3.0=0xbff60000 ACPI 2.0=0xbdee2018 INITRD=0xbdd94f18 RNG=0xbdee2a18 MEMRESERVE=0xbdd94f98
         :
[   18.374507] virtio-pci 0000:00:03.0: enabling device (0000 -> 0002)
[   18.594890] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   18.651840] Serial: AMBA driver
[   19.669576] software IO TLB: Memory encryption is active and system is using DMA bounce buffers
[   35.021315] Freeing initrd memory: 5772K
[   40.984997] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   41.076752] rcu: 	3-...0: (77 ticks this GP) idle=aed4/1/0x4000000000000000 softirq=83/97 fqs=2365
[   41.210687] rcu: 	(detected by 2, t=5307 jiffies, g=-1079, q=352 ncpus=4)
[   41.311646] Sending NMI from CPU 2 to CPUs 3:
[   51.631564] After 10 seconds, these CPUS still haven't responded to the NMI: 3
[   51.739789] rcu: rcu_preempt kthread timer wakeup didn't happen for 2685 jiffies! g-1079 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[   51.910690] rcu: 	Possible timer handling issue on cpu=2 timer-softirq=2168
[   52.014654] rcu: rcu_preempt kthread starved for 2756 jiffies! g-1079 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=2
[   52.169468] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[   52.304725] rcu: RCU grace-period kthread stack dump:
[   52.379337] task:rcu_preempt     state:I stack:0     pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00000010
[   52.542813] Call trace:
[   52.578516]  __switch_to+0xfc/0x248 (T)
[   52.636293]  __schedule+0x3a4/0xe68
[   52.686511]  schedule+0x3c/0xe8
[   52.731765]  schedule_timeout+0x80/0x120
[   52.788489]  rcu_gp_fqs_loop+0x110/0x440
[   52.846921]  rcu_gp_kthread+0x10c/0x120
[   52.906472]  kthread+0x138/0x150
[   52.955082]  ret_from_fork+0x10/0x20

(5) As reported previously, 'reboot' on the realm guest causes the termination of qemu process.

root@guest:~# reboot
     :
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system reboot
[   61.874435] reboot: Restarting system
qemu-system-aarch64: cpus are not resettable, terminating
qemu-system-aarch64: cpus are not resettable, terminating
qemu-system-aarch64: cpus are not resettable, terminating
qemu-system-aarch64: cpus are not resettable, terminating

Thanks,
Gavin

