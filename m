Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616599;
	b=4DTtsuFiRZXvDxbDNCRfuE1NKDMcN5h0zORfz8vs5AiiIewazKh1lWqSu7C8qTsRUuHO
	 6XrStmiHWJwIgsfk4BheIeN0hvLHufsETFqfn7/3URaZrVGsM5wQtLFxLjLwtBH9G7B/o
	 1IBRBQQyFc6qh33pdBmjmcvaXY0v+hjWB/ZbUhEUEoQOwtT6mVL8WvGG49jHSWCoWAOYe
	 X3890G7wtgj+fd+obtL+bKWwooaf7chu7AK+CChEImyR0h277YvVQYh4saEkAphh4aVmj
	 Dh2nq73xd8xkeLWWDVnpJo7swmKTiT6ls0XfXulA/aqengRxoQqAo9szCTA4LidDxjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=WQT0qPzr3Ls1jasnVTpNHtajcbGWRZOPvuwt8bwWQHU=;
	b=arPQpBmRka/XNVkdBWR14eFx2eqkOmLU/xHRmb3SLIfhfua23ugPeIXc8qyk+k+bGqe6
	 mCxAk5o5Gh3Pfwb/HjQBhMRQHVCxkG8wJFii0V1aUvnnFRiovtgYBcjUiNjURocyitCdl
	 1/a/GiQdGfXYGhDoJp4fScgO/VyHNxyBP4fJMQQIvrSTPkyeETBspCmjX+RaxXBMfe499
	 kJ1hU59qgcXCwgNPk3sbcpGyoQGarQFVey7UmmGSCridZ2s1OrkzVlmxNGLRtUfer7QiK
	 uzrvjPpPHPh/x/RwwF4DuUWCpgXr9IB1T3lcXQfLA2v9BkvWr4B61Dg42i+Z7HaEnTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=an9b1da1;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9619E606A31B
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 21:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9619E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=an9b1da1
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so1065634a91.0
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 14:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792616598; x=1793221398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WQT0qPzr3Ls1jasnVTpNHtajcbGWRZOPvuwt8bwWQHU=;
        b=an9b1da1vl2QSKguB7Yye/6/4B04odtWHOMG8VBMABbPGcSg9pwJ2nq5b/cvBIMqgh
         hL2JAxV0E37N2c5yDRcwya+r9lnetqzzRlB7IvqqlomqZQeqYVhm/wMxRE5ZJdxi9rPB
         dQas9pPHrMzPpEuWg0LbFVMwXmbFS8nWZQKG7PtMcV9u7mFaJwMWN90Tst+dMirgQUxv
         f11S7PFqxZuqMWcMRG8dt6jq8t4azQucXQqJMzK7+eBIuBvMjSV5YPeV8DwQ6hh4RaLi
         SWHo8J6U4T4vsIdZ/FCbxwFjOH7qxhrFP757G7lpooEFSczhnx7JLHpYJ753hu1oYa6z
         oqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792616598; x=1793221398;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WQT0qPzr3Ls1jasnVTpNHtajcbGWRZOPvuwt8bwWQHU=;
        b=lYc7p9RHQ8mFYd9WAEH3nnOFRO/J3GGmq8G1/SkuVDMvHHz9YW0Kn2uPEwNNnchaLM
         Ym1p2Guerc0lAg7PvUZS04ihEeke0wIuefIW6PBy7T35YIsBkOb0Ka8KZIPK/9FcdBd1
         Ycgdmszxus6e9qwBtHmX3L4u6xRgzg7XFIx+G04vSG68Th5cYn9+a0y0oM31ShyZHEqJ
         RvfAblGc23sUAtWDS4f7tFXnSQ1dmP80cmHlz3V5SlRNPi8usTyKZW2f1GoL3p0qDxqw
         MGlC0UAb1g7n3Y4HKIXZxXb6flXZa46QRyhDAGSqFoUfbZiFxQhMgQ6LNfGDgFhK1lfH
         32LA==
X-Forwarded-Encrypted: i=1; AKwUvBxzR55NN+5sosOKz5Uaf381Zl4THD1/55Rfh/O5Uf5uiE5Erx+A/7fj6863yrYI0V2uXCY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJl185lQZ6FKo2HTGwnJDgu61KARlb5UN4FNCbDenMAWYolBAmU
	W9d5WF1ph+zvR38CzMUhY9xNVu076blb4ZidpoNSS29R9CiD0ZFmPYAujLO7iJIjBUk=
X-Gm-Gg: AYBFou1FYF7KvW6qkC1tXDoDQ0Tj8h0SKlQf2w9KWg0N3N0gV7M29Fy/4TijK/nuWs0
	4PsrbNGWquMjS4sOv5S0H4C56bpUHQoMTd4JKXjA3fdcTOzgqeukLrOexIK7HbWrsHPRR89ALxP
	fwk41L9wwY7230a+bXsh5DM1nTTtJfjpp6NAp8v0Aa4cpHSpyunbZXS33HfaSx5K1wcTP10JH/j
	Wz6auoNuXowpdOJS9mvfzg8vCpFTaA2Lj2kJ0aFTZTt15P4wFxsRHEbS9/d0RgTNQ7jOpVgFntG
	gR5DBvg9vkp265uv4JN1VxG2uGtsH0cEC52OQf4+9tswO/TQHK/HF6z3LxSie4x5ycbmJ/HcdCc
	OgLJ6ys+NtaqjhLdDjsDmDlQVuyvB4ScmjtQEdA17dmFKiWaN37+IZscU7cFUAy/T6vekeXQYeJ
	nuzZnQQWfbk3vzMHnpw1AQuCfeqUz0uYrE5gawrxdv+sfiOfTimZDtmK0VOattyFQtyFsWPUgtl
	hi7He4HuMvi4Iw3Ti2toUUH2J/PiugN3pXm/VNRGREbMteZYHx6bPpyQeA=
X-Received: by 2002:a17:90a:c887:b0:3a7:9413:cfae with SMTP id 98e67ed59e1d1-3ad86f36215mr2395188a91.42.1792616597688;
        Wed, 21 Oct 2026 14:03:17 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:8e8e:37a7:da6e:5dab])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada49544f1sm975697a91.16.2026.10.21.14.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 14:03:17 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:03:14 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [RFC v4 00/24] Add Realm support to QEMU-VMM
Message-ID: <atkokvqTHygpI8dt@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <7dea93a6-b119-4882-9c56-557a372b646a@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dea93a6-b119-4882-9c56-557a372b646a@redhat.com>

Hi Gavin,

On Mon, Sep 21, 2026 at 02:05:19PM +1000, Gavin Shan wrote:
> Hi Mathieu,
> 
> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> > This patchset provides minimal functionality to start a Realm VM
> > from an Arm RME capable host using the following command line:
> > 
> > qemu-system-aarch64 \
> >   -M confidential-guest-support=rme0,memory-backend=ram0 \
> >   -object rme-guest,id=rme0,convert-in-place=on \
> >   -object memory-backend-guest-memfd,id=ram0,size=1G,share=on \
> >   -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
> > 
> > It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
> > back.  It is compatible with Steven Price's v16 revision [1] of his work adding
> > CCA support to KVM.
> > 
> > This revision is based on Michael Roth's work on guest memfd in-place memory
> > conversion [2], rebased to QEMU master.  I left out the AMD specific changes
> > from Michael's work because I can't test the result.  Other than the
> > modications to the linux headers, this series is identical to V3.
> > 
> > It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
> > here [3], along with the TF-A [4] and RMM [5] for the SBSA machine (compatible
> > with Steven's v16 patchset).  The Repository for the kernel [6] is also
> > available.  Note that for the latter, defines for
> > KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES and KVM_CAP_ARM_RMI have been modified to
> > follow QEMU master.
> > 
> > Instructions to compile and run the entire stack can be found here [7].
> > 
> > Device Assignment is not included.
> > 
> > Thanks,
> > Mathieu
> > 
> > [1]. https://lore.kernel.org/kvm/20260803134403.80630-1-steven.price@arm.com/
> > [2]. https://lore.kernel.org/kvm/20260528000416.8161-1-michael.roth@amd.com/
> > [3]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v4?ref_type=heads
> > [4]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
> > [5]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v16?ref_type=heads
> > [6]. https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v4?ref_type=heads
> > [7]. https://gitlab.com/Linaro/cca-public/build-instructions
> > 
> 
> Give this series and (v19) arm/cca host series [1] a try, and found the following
> issues. I'm sharing the found issues that I need take chance to look at them
> closely in future.
> 
> [1] https://git.gitlab.arm.com/linux-arm/linux-cca.git  (branch: cca/cca-host/kvm-v19/integration)
> 
> Note that the host is emulated using qemu (TCG mode) via 'virt' platform, using
> the following command lines
> 
> laptop$ /home/gshan/sandbox/cca/host/qemu/build/qemu-system-aarch64                 \
>         -M virt,virtualization=on,secure=on,gic-version=3,acpi=off                  \
>         -cpu max,x-rme=on -m 4G -smp 8                                              \
>         -serial mon:stdio -monitor none -nographic -nodefaults                      \
>         -bios /home/gshan/sandbox/cca/host/tf-a/flash.bin                           \
>         -kernel /home/gshan/sandbox/cca/host/linux/arch/arm64/boot/Image            \
>         -initrd /home/gshan/sandbox/cca/host/buildroot/output/images/rootfs.cpio.xz \
>         -append kvm-arm.mode=rmm                                                    \
>         -device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                       \
>         -device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                       \
>         -device pcie-root-port,bus=pcie.0,chassis=3,id=pcie.3                       \
>         -device pcie-root-port,bus=pcie.0,chassis=4,id=pcie.4                       \
>         -device virtio-9p-device,fsdev=shr0,mount_tag=shr0                          \
>         -fsdev local,security_model=none,path=/home/gshan/sandbox/cca/guest,id=shr0 \
>         -netdev tap,id=tap1,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown       \
>         -device virtio-net-pci,bus=pcie.2,netdev=tap1,mac=b8:3f:d2:1d:3e:80
> 
> The realm VM is started using the following command lines.
> 
> host$ qemu-system-aarch64 -enable-kvm -object rme-guest,id=rme0,convert-in-place=on \
>       -machine virt,gic-version=3,confidential-guest-support=rme0 -m 2G -cpu host   \
>       -smp maxcpus=4,cpus=4,sockets=1,clusters=1,cores=2,threads=2                  \
>       -object memory-backend-guest-memfd,id=mem0,size=2G,share=on                   \
>       -numa node,nodeid=0,cpus=0-3,memdev=mem0                                      \
>       -serial mon:stdio -monitor none -nographic -nodefaults                        \
>       -kernel /mnt/linux/arch/arm64/boot/Image                                      \
>       -initrd /mnt/buildroot/output/images/rootfs.cpio.xz                           \
>       -append earlycon=pl011,mmio,0x10009000000
> 
> Found issues
> ============

I was able to do the same manipulations on my side, but using the SBSA machine
for system emulation, with results as described below: 

> 
> (1) qemu is terminiated on qmp command 'dump-guest-memory'
> 
> (qemu) dump-guest-memory -p "/tmp/mem" 0x40000000 0x10000000
> **
> ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
> Bail out! ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
>

On my side this command causes the Realm to abort, as I expected it to be.
Realm memory should not be observable from the host.  There may be a debug mode
to enable this kind of operation but I will have to look at the documentation
for details.
 
> (2) qemu emulation can't be stopped and resumed
> 
> (qemu) stop
> (qemu) cont
> Failed to set KVM_REG_ARM_TIMER_CNT
> 

That too I was expecting.  Anything that can comprimise a Realm will cause the
HW to abort.  I'll investigate the "Failed to set KVM_REG_ARM_TIMER_CNT" error
message though.

> (3) qemu is terminiated on qmp command 'system_reset'
> 
> (qemu) system_reset
> cpus are not resettable, terminating
> 
> (4) 'reboot' from the guest doesn't work
> 
> root@guest:~# reboot
>    :
> Requesting system reboot
> [  123.264893] reboot: Restarting system
> qemu-system-aarch64: cpus are not resettable, terminating
> 

I suspect 'system_reset' from the monitor and a 'reboot' from the command line
will, at some point, end up following the same sequence.  I need to think about
the 'reboot' use case further. 


> (5) Incompatible to virtio-iommu-pci. The realm guest doesn't boot up if a virtio-iommu-pci
>     device is specified in the command lines
> 
> host$ qemu-system-aarch64 -enable-kvm                                          \
> -object rme-guest,id=rme0,convert-in-place=on                                  \
> -machine virt,gic-version=3,confidential-guest-support=rme0                    \
> -m 2G -cpu host -smp maxcpus=4,cpus=4,sockets=1,clusters=1,cores=2,threads=2   \
> -object memory-backend-guest-memfd,id=mem0,size=2G,share=on                    \
> -numa node,nodeid=0,cpus=0-3,memdev=mem0                                       \
> -serial mon:stdio -monitor none -nographic -nodefaults                         \
> -kernel /mnt/linux/arch/arm64/boot/Image                                       \
> -initrd /mnt/buildroot/output/images/rootfs.cpio.xz                            \
> -append earlycon=pl011,mmio,0x10009000000                                      \
> -device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                          \
> -device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                          \
> -device virtio-iommu-pci,bus=pcie.0                                            \
> -drive file=/mnt/disk.qcow2,if=none,id=drive0                                  \
> -device virtio-blk-pci,id=virtblk0,bus=pcie.1,drive=drive0,num-queues=4        \
> -netdev tap,id=tap1,vhost=on,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
> -device virtio-net-pci,bus=pcie.2,netdev=tap1,mac=b8:3f:d2:1d:3e:c0


I added the following to my Realm's boot command parameters:

-device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1 \
-device virtio-iommu-pci,bus=pcie.0 \


>      :
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> [    0.000000] Linux version 7.2.0-rc5-gavin-gf5098b6bae76 (gshan@nvidia-grace-hopper-01.khw.eng.bos2.dc.redhat.com) (gcc (GCC) 14.3.1 20251022 (Red Hat 14.3.1-4), GNU ld version 2.41-65.el10) #47 SMP PREEMPT Mon Jul 27 02:29:03 EDT 2026
> [    0.000000] KASLR enabled
> [    0.000000] Machine model: linux,dummy-virt
> [    0.000000] earlycon: pl11 at MMIO 0x0000010009000000 (options '')
> [    0.000000] printk: legacy bootconsole [pl11] enabled
> [    0.000000] efi: UEFI not found.
> [    0.000000] OF: reserved mem: Reserved memory: No reserved-memory node in the DT
> [    0.000000] NODE_DATA(0) allocated [mem 0xbfbecb00-0xbfbf09bf]
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv1.1 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
> [    0.000000] psci: SMC Calling Convention v1.2
> [    0.000000] RME: Using RSI version 1.0
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000bfffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
>      :
> [    6.664423] Serial: AMBA PL011 UART driver
> [    7.151312] 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq = 13, base_baud = 0) is a PL011 rev1
> [    7.213181] printk: console [ttyAMA0] enabled
> [    8.536454] HugeTLB: registered 1.00 Gi
> <...The realm guest stops here, no output since then...>
>

On my side I get to user space but virtio-serial and virtio-net don't work.  I'm
guessing virtio-iommu-pci does the same thing as this patch [1], but virtio
devices are disrupted because it is not configured properly.  I need to
investigate to find the best approach to follow, i.e implicitly use (and
configure) a virtio-iommu-pci or make sure that [1] and a virtio-iommu-pci
device can play nice together.   

Thanks,
Mathieu

[1]. [RFC v4 21/24] target/arm/kvm-rme: Add DMA remapping for the shared memory region


> Thanks,
> Gavin
> 
