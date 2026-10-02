Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F22738C2A0
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790973133; cv=none; b=HtP4hHaAcRZaCLbaKFBR4HIBzDwHBUjoWE4EKc8hVOpLqEolMZQP6CwXCzhp1tOK4LIzpjLYiKPgY+AVGbF9qhW21O8acd9tFiHUh9L6obDNK9blRj8bJEKI/8HmdCFxBkWB3ldWdBUc7Wol6N/9z1hjajJMv4SKKy27LEkeVTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790973133; c=relaxed/simple;
	bh=SFyOd2vkZjcbdu1vC+nhjYpGxr1Vl0rloh9U+JXOlEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUKtK7BEbaa9yHfFbor/tFRHxs0HitH05y/OC1L8dEuPRi/vTOxAPtGlLWP7rUgsN54WvmFSVFBAel1xj1m1bYVJUe0IaQ/FoyqmhWOzopa5xrF7ZJrQAEwcRR50x0f0vPyz41vKaaddlMzAeRo+2ZSw3/WEH2lQ+7lvJ8nw9zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dKWlh/Fo; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKWlh/Fo"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc02279so258796a91.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790973122; x=1791577922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AHlsWKhIYMSy9PPscT7uDOI5j2DOuLJafaW6vdba0Vs=;
        b=dKWlh/FowWUnMOvIjw4Lkmpfj6SOkwUnGQMSeJJWuLJ3MrpAeosKGjrRTkf8vFGHT5
         Nsgt+Bdp74+BwumtTj1NdSpBNm7FleTGqvu6LGnSNlxmxrMw+3lB5lRW0H8KIVSjAiyY
         hLJfSwYd2NYxjXK3PnKrKOapeYHvi+oweZxGZWYVHWoMquC64JL4dXk/iX/Z4i5pDbCL
         zuWOul0r/XtqpUyBxWaRVMtlrXsoyT1fmR2u2trtZ4h8Kb60C25KOz9McTiUGD47t68p
         Vd1ktNUv4nDr9ylkiKj6LrqNNktVyuNf7aj9tBqrfr8oUqbXMRiVyPIqvm3m7yHAgfFz
         ZAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790973122; x=1791577922;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AHlsWKhIYMSy9PPscT7uDOI5j2DOuLJafaW6vdba0Vs=;
        b=BEOLuv+12KtYHpRigBMcmDgM1XNtOeyFkbZ6MiTsJKztPOCL03XHP6l7T/NuV9oCHF
         yPlTOSYYkfEeHa0MLYLjQialMhpClz2bUPAr0ySQ8m39cR6lpGzoQO66UC1FoRD8TI4R
         Pg8VvRGMbAfX3JwpjlL2Yn8Z3hPXBMsKiq0Xy3WJWqqhfZat299lq1l0WR5UpX8lC3xz
         f5aWEppr8F2WLy+VnLpU3OivkywITRt7agTXu/yeXsVEaHYa6CfqLtEXUsVBaRDOmiJY
         nfXOWBcyZ4Z+Bja62pkx+OgOudancuFiEgZSi5HwVm5AcLhHZfYWSKMdmT6mF+pgsjql
         nVJA==
X-Forwarded-Encrypted: i=1; AKwUvBxROAQ5eYa0yNLEwAprD3JMLgtVnqlnTyAona67EUs2SztEtLIPX1bm18aTTQKKVPmuFao=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBAVshd/4O4/Alsyti0zWHlMda6SFoln9c5pPmIC2RFLUJhrwr
	E5yULsl8BmSAvBpcp+TKuQiRPkl3/qJ6JKM+2DaD35IrqlhX1UZsIzWGIOt5DuWk0ZYDaIyjClN
	I0LZS
X-Gm-Gg: AYBFou3wp644AegzNtxVOfSazILVK9p/RZXA0tQIdvaN09BJoAqpiYHsn+AtIFsWycq
	aiRH65/jczs28Gs5sU1NIIWcFwUMkGwTX7zafSSFtP8YL5ZRvVkEZK6ju91HkUVUPir9gRE0tCS
	kPYv1hoVr7Vco+dgzTViuTN1VMHgGeXK8hNKxPrJJN3OJgomqJKM8J907pEWWqlC6FvuxuWRZZF
	MVfaNj4KR1nSa2m/QOVMLjvtTxyCUUrmAMUtuv+PC5rDLWb/ihvjSWh03oIJB8VrBu86K6L8Fdv
	5lKHbDlj6kABW0gnD+b/4CpSIuS7RS7guDJVCXDJoRE3I+X4yzgaugZhBPWgSy76KHkxKyZHOv/
	OpVIKgtrAMveDNbVLusmZBzgxGiyBDUytQ3OTWi8LApiSnLm8AgC0reWC5A6WJ8aHbbukp3j152
	qgbLK2MGq/fyi1iFDrwDx3ARwTzlWKNk54EfkP6xtYou17o84t379OF9NpJjt3kjeJywvW07pEk
	w==
X-Received: by 2002:a17:90b:2251:b0:3a4:7195:ecbc with SMTP id 98e67ed59e1d1-3a6ce791dcfmr3533567a91.29.1790973121660;
        Fri, 02 Oct 2026 13:32:01 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f471b16asm10533783a91.9.2026.10.02.13.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:32:01 -0700 (PDT)
Date: Fri, 2 Oct 2026 14:31:57 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [RFC v4 00/24] Add Realm support to QEMU-VMM
Message-ID: <asAUvdFhKSAi5QhE@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <7dea93a6-b119-4882-9c56-557a372b646a@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dea93a6-b119-4882-9c56-557a372b646a@redhat.com>

Good day,

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

Thank you for taking the time.

> 
> [1] https://git.gitlab.arm.com/linux-arm/linux-cca.git  (branch: cca/cca-host/kvm-v19/integration)
> 
> Note that the host is emulated using qemu (TCG mode) via 'virt' platform, using
> the following command lines

I am currently focused on the SBSA machine but will try to reproduce your
manipulations using 'upstream-v5' that I just posted.

Note that upstream-v5 doesn't address any of the comments you posted today.
Since upstream-v4 was based on v16, I wanted to send another revision that is
based on the very latest (v21) to keep pace with Suzuki and Steven.

I am off to Linux Plumbers next week but rest assured that I will look into your
comments (and the content herein) when I'm back.  

Thanks,
Mathieu

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
> 
> (1) qemu is terminiated on qmp command 'dump-guest-memory'
> 
> (qemu) dump-guest-memory -p "/tmp/mem" 0x40000000 0x10000000
> **
> ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
> Bail out! ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
> 
> (2) qemu emulation can't be stopped and resumed
> 
> (qemu) stop
> (qemu) cont
> Failed to set KVM_REG_ARM_TIMER_CNT
> 
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
> Thanks,
> Gavin
> 
