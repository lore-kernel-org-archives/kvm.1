Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=139.138.37.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794297690;
	b=b76207OeSacMUWFq1FZ+k6Ga3rnJJ2/4bprrBYgBufvt9YSM1EeB4FEJG8L5geqiUTi7
	 voaG3o1yOz2ENQXo8U4BF2MhlPsSp6vRkyNdVPz2PkIEA3wxj3pYiBOKqwBwT40yyzc2N
	 bpyCSz0xQqPgx9hGxQ0fpGWvESnJ2SHnLjW9t1+Ox/XDhdKaxyL+7B52gNjmOnSdgOayV
	 yEGkdfnlYUXdntcb1dXqWr8dJxob8GFIRVsH6V09gpOY1gINxklL1NZLsoIgjVutdv2Dn
	 yBwfwLMlIyuQU26yYzJzLFvYoDOKDlYjJa/rPutUPD7PrejBRdj+6p2bwDmSYiBExfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794297690;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=EWTKE+ZLWB32uGL6/q8gVNHo6hekPRzh8qz4Hg7d8RE=;
	b=cwQmKNR4s8+5bQs2pkcC7NyF4K3YuhwnJGzQT6e79E9OFHntFYu/qRxE8XXVvVoNjuzQ
	 sAywaViW50enR4hWzyORPAxk3hwCXh4Y4soq1a9v7EGpiwqpBesWG0pfIyXJLM7K3tIJB
	 r/ohWW/qQDbURiCaAwXoK+rXAPYHqPmhNUBoOvMS88+/l2xkzD/YDzUg/YyWzbXzJXJzq
	 H4tBtSwvfO16PpLdSDT3nQF/J+TXndb1DVr57bEODlHTj6Uw+edqiGN69gFQenlvAayy7
	 CPbGXfn1knUeOO9o6BjmjYTmFgrvIQ0kM7YJhdf/k14IWldD01zxR5qcBZwGjCST/2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=Uqu9dXO9;
	arc=none smtp.remote-ip=139.138.37.100
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B690F606A325
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 08:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B690F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=Uqu9dXO9
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1794297690; x=1825833690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cugudSijl4LAnjo9v3A+TESsLah8KfFEPIhngO8a6+0=;
  b=Uqu9dXO9VrhqTSNfw/DLgHgoJAlrZylQbskUoGjiLWdEOMbaw6IDZivp
   lhLkReTY3DoycIJg1OQJ+jpxPaUs0T1k6TsBCHybiKeByJluIVUA+Dg4b
   1nkluLeb+r7wN8WTcHHrnugvo4zOa5m6ViUzekfRD7wp4dDDi2Ul4oLdp
   wz7KCyVqaWlEe2gHIgUE88mLKEZpFYbm4yRIjHu/qKf8rCK6Ljf+sW+3A
   09QPcrBroTPRUo1l+BeWNkoegIRk+q4MKQMpQ2KvFWmQOukLh9T+mwXBa
   5SHYQL8b6JzRIlGqJmk8zLsIy+Ovqa2Wlhs9mnM7zUBUBoe18W86cIV1x
   w==;
X-CSE-ConnectionGUID: 1u2DdXDkTkWk/JfkfjnrCQ==
X-CSE-MsgGUID: K70WA2pNRxqR0/y2gyy4uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="238985092"
X-IronPort-AV: E=Sophos;i="6.27,205,1786978800"; 
   d="scan'208";a="238985092"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 17:01:21 +0900
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id B9B7B820409
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 08:01:21 +0000 (UTC)
Received: from az2nlsmom4.fujitsu.com (unknown [10.150.26.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTPS id 660F01400362
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 08:01:21 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.9.61.34])
	by az2nlsmom4.fujitsu.com (Postfix) with SMTP id D878C20002A2;
	Tue, 10 Nov 2026 08:01:15 +0000 (UTC)
Date: Tue, 10 Nov 2026 17:01:14 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, berrange@redhat.com, 
	kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, 
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com, 
	armbru@redhat.com, lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org, 
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 00/24] Add Realm support to QEMU-VMM
Message-ID: <avLM3UdwUcgUHLgP@FCCLS0092175.localdomain>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <7dea93a6-b119-4882-9c56-557a372b646a@redhat.com>
 <atkokvqTHygpI8dt@p14s>
 <5dba456f-26b4-4f05-9271-fb784736d581@redhat.com>
 <atvCNKxpCRRSFL58@p14s>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <atvCNKxpCRRSFL58@p14s>

On 10/23 14:23, Mathieu Poirier wrote:
> On Fri, Oct 23, 2026 at 09:00:12PM +1000, Gavin Shan wrote:
> > Hi Mathieu,
> > 
> > On 10/22/26 7:03 AM, Mathieu Poirier wrote:
> > > Hi Gavin,
> > > 
> > > On Mon, Sep 21, 2026 at 02:05:19PM +1000, Gavin Shan wrote:
> > > > Hi Mathieu,
> > > > 
> > > > On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> > > > > This patchset provides minimal functionality to start a Realm VM
> > > > > from an Arm RME capable host using the following command line:
> > > > > 
> > > > > qemu-system-aarch64 \
> > > > >    -M confidential-guest-support=rme0,memory-backend=ram0 \
> > > > >    -object rme-guest,id=rme0,convert-in-place=on \
> > > > >    -object memory-backend-guest-memfd,id=ram0,size=1G,share=on \
> > > > >    -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
> > > > > 
> > > > > It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
> > > > > back.  It is compatible with Steven Price's v16 revision [1] of his work adding
> > > > > CCA support to KVM.
> > > > > 
> > > > > This revision is based on Michael Roth's work on guest memfd in-place memory
> > > > > conversion [2], rebased to QEMU master.  I left out the AMD specific changes
> > > > > from Michael's work because I can't test the result.  Other than the
> > > > > modications to the linux headers, this series is identical to V3.
> > > > > 
> > > > > It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
> > > > > here [3], along with the TF-A [4] and RMM [5] for the SBSA machine (compatible
> > > > > with Steven's v16 patchset).  The Repository for the kernel [6] is also
> > > > > available.  Note that for the latter, defines for
> > > > > KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES and KVM_CAP_ARM_RMI have been modified to
> > > > > follow QEMU master.
> > > > > 
> > > > > Instructions to compile and run the entire stack can be found here [7].
> > > > > 
> > > > > Device Assignment is not included.
> > > > > 
> > > > > Thanks,
> > > > > Mathieu
> > > > > 
> > > > > [1]. https://lore.kernel.org/kvm/20260803134403.80630-1-steven.price@arm.com/
> > > > > [2]. https://lore.kernel.org/kvm/20260528000416.8161-1-michael.roth@amd.com/
> > > > > [3]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v4?ref_type=heads
> > > > > [4]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
> > > > > [5]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v16?ref_type=heads
> > > > > [6]. https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v4?ref_type=heads
> > > > > [7]. https://gitlab.com/Linaro/cca-public/build-instructions
> > > > > 
> > > > 
> > > > Give this series and (v19) arm/cca host series [1] a try, and found the following
> > > > issues. I'm sharing the found issues that I need take chance to look at them
> > > > closely in future.
> > > > 
> > > > [1] https://git.gitlab.arm.com/linux-arm/linux-cca.git  (branch: cca/cca-host/kvm-v19/integration)
> > > > 
> > > > Note that the host is emulated using qemu (TCG mode) via 'virt' platform, using
> > > > the following command lines
> > > > 
> > > > laptop$ /home/gshan/sandbox/cca/host/qemu/build/qemu-system-aarch64                 \
> > > >          -M virt,virtualization=on,secure=on,gic-version=3,acpi=off                  \
> > > >          -cpu max,x-rme=on -m 4G -smp 8                                              \
> > > >          -serial mon:stdio -monitor none -nographic -nodefaults                      \
> > > >          -bios /home/gshan/sandbox/cca/host/tf-a/flash.bin                           \
> > > >          -kernel /home/gshan/sandbox/cca/host/linux/arch/arm64/boot/Image            \
> > > >          -initrd /home/gshan/sandbox/cca/host/buildroot/output/images/rootfs.cpio.xz \
> > > >          -append kvm-arm.mode=rmm                                                    \
> > > >          -device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                       \
> > > >          -device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                       \
> > > >          -device pcie-root-port,bus=pcie.0,chassis=3,id=pcie.3                       \
> > > >          -device pcie-root-port,bus=pcie.0,chassis=4,id=pcie.4                       \
> > > >          -device virtio-9p-device,fsdev=shr0,mount_tag=shr0                          \
> > > >          -fsdev local,security_model=none,path=/home/gshan/sandbox/cca/guest,id=shr0 \
> > > >          -netdev tap,id=tap1,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown       \
> > > >          -device virtio-net-pci,bus=pcie.2,netdev=tap1,mac=b8:3f:d2:1d:3e:80
> > > > 
> > > > The realm VM is started using the following command lines.
> > > > 
> > > > host$ qemu-system-aarch64 -enable-kvm -object rme-guest,id=rme0,convert-in-place=on \
> > > >        -machine virt,gic-version=3,confidential-guest-support=rme0 -m 2G -cpu host   \
> > > >        -smp maxcpus=4,cpus=4,sockets=1,clusters=1,cores=2,threads=2                  \
> > > >        -object memory-backend-guest-memfd,id=mem0,size=2G,share=on                   \
> > > >        -numa node,nodeid=0,cpus=0-3,memdev=mem0                                      \
> > > >        -serial mon:stdio -monitor none -nographic -nodefaults                        \
> > > >        -kernel /mnt/linux/arch/arm64/boot/Image                                      \
> > > >        -initrd /mnt/buildroot/output/images/rootfs.cpio.xz                           \
> > > >        -append earlycon=pl011,mmio,0x10009000000
> > > > 
> > > > Found issues
> > > > ============
> > > 
> > > I was able to do the same manipulations on my side, but using the SBSA machine
> > > for system emulation, with results as described below:
> > > 
> > 
> > Thanks for double check on your side. Just a head up: I will re-run the broken test
> > cases with (RFCv5) qemu series and share the result. I expect we will have more
> > discussions on those broken test cases under RFCv5 series if you agree. I don't
> > know when I get a chance to try RFCv5 series, but hopefully next week or early
> > of the week after that.
> >
> 
> I omitted to mention that I used RFCv5 for my manipulations on SBSA, so I expect
> you'll find the same problems as with RFCv4.  No need to rush to do the test
> since my next revision will _not_ address any of those issues.  For RFCv6 I want
> to concentrate on the other comments you and Kohei made and keep the bigger
> issues (the ones you raised here) for future revision.  That way we make progess
> on this patchset and keep synchronized with the KVM patches Suzuki and Steven
> release.
> 
> We can discuss further at the KVM forum if you are there.
> 
> > Cheers,
> > Gavin
> > 
> > > > 
> > > > (1) qemu is terminiated on qmp command 'dump-guest-memory'
> > > > 
> > > > (qemu) dump-guest-memory -p "/tmp/mem" 0x40000000 0x10000000
> > > > **
> > > > ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
> > > > Bail out! ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
> > > > 
> > > 
> > > On my side this command causes the Realm to abort, as I expected it to be.

Hi Mathieu, Gavin.

I've tested RFC v5, and I reproduced issue (1) on my side as well:

    (qemu) dump-guest-memory -p "/tmp/mem" 0x40000000 0x10000000
    Failed to set KVM_REG_ARM_TIMER_CNT
    ./qemu-ram-realm.sh: line 21: 77580 Aborted                 (core dumped) $QEMU -no-reboot -M confidential-guest-support=rme0,memory-backend=ram0 ...

This was resolved by adding kvm-no-adjvtime=on.

> > > Realm memory should not be observable from the host.  There may be a debug mode
> > > to enable this kind of operation but I will have to look at the documentation
> > > for details.
> > > > (2) qemu emulation can't be stopped and resumed
> > > > 
> > > > (qemu) stop
> > > > (qemu) cont
> > > > Failed to set KVM_REG_ARM_TIMER_CNT
> > > > 
> > > 
> > > That too I was expecting.  Anything that can comprimise a Realm will cause the
> > > HW to abort.  I'll investigate the "Failed to set KVM_REG_ARM_TIMER_CNT" error
> > > message though.

kvm-no-adjvtime=on also resolved issue (2) above.

Setting KVM_REG_ARM_TIMER_CNT for Realm VMs is not allowed, so we should
either add this option or consider making it the default for Realm VMs
in the future. What do you think?

Thanks,
Kohei

> > > 
> > > > (3) qemu is terminiated on qmp command 'system_reset'
> > > > 
> > > > (qemu) system_reset
> > > > cpus are not resettable, terminating
> > > > 
> > > > (4) 'reboot' from the guest doesn't work
> > > > 
> > > > root@guest:~# reboot
> > > >     :
> > > > Requesting system reboot
> > > > [  123.264893] reboot: Restarting system
> > > > qemu-system-aarch64: cpus are not resettable, terminating
> > > > 
> > > 
> > > I suspect 'system_reset' from the monitor and a 'reboot' from the command line
> > > will, at some point, end up following the same sequence.  I need to think about
> > > the 'reboot' use case further.
> > > 
> > > 
> > > > (5) Incompatible to virtio-iommu-pci. The realm guest doesn't boot up if a virtio-iommu-pci
> > > >      device is specified in the command lines
> > > > 
> > > > host$ qemu-system-aarch64 -enable-kvm                                          \
> > > > -object rme-guest,id=rme0,convert-in-place=on                                  \
> > > > -machine virt,gic-version=3,confidential-guest-support=rme0                    \
> > > > -m 2G -cpu host -smp maxcpus=4,cpus=4,sockets=1,clusters=1,cores=2,threads=2   \
> > > > -object memory-backend-guest-memfd,id=mem0,size=2G,share=on                    \
> > > > -numa node,nodeid=0,cpus=0-3,memdev=mem0                                       \
> > > > -serial mon:stdio -monitor none -nographic -nodefaults                         \
> > > > -kernel /mnt/linux/arch/arm64/boot/Image                                       \
> > > > -initrd /mnt/buildroot/output/images/rootfs.cpio.xz                            \
> > > > -append earlycon=pl011,mmio,0x10009000000                                      \
> > > > -device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                          \
> > > > -device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                          \
> > > > -device virtio-iommu-pci,bus=pcie.0                                            \
> > > > -drive file=/mnt/disk.qcow2,if=none,id=drive0                                  \
> > > > -device virtio-blk-pci,id=virtblk0,bus=pcie.1,drive=drive0,num-queues=4        \
> > > > -netdev tap,id=tap1,vhost=on,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
> > > > -device virtio-net-pci,bus=pcie.2,netdev=tap1,mac=b8:3f:d2:1d:3e:c0
> > > 
> > > 
> > > I added the following to my Realm's boot command parameters:
> > > 
> > > -device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1 \
> > > -device virtio-iommu-pci,bus=pcie.0 \
> > > 
> > > 
> > > >       :
> > > > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> > > > [    0.000000] Linux version 7.2.0-rc5-gavin-gf5098b6bae76 (gshan@nvidia-grace-hopper-01.khw.eng.bos2.dc.redhat.com) (gcc (GCC) 14.3.1 20251022 (Red Hat 14.3.1-4), GNU ld version 2.41-65.el10) #47 SMP PREEMPT Mon Jul 27 02:29:03 EDT 2026
> > > > [    0.000000] KASLR enabled
> > > > [    0.000000] Machine model: linux,dummy-virt
> > > > [    0.000000] earlycon: pl11 at MMIO 0x0000010009000000 (options '')
> > > > [    0.000000] printk: legacy bootconsole [pl11] enabled
> > > > [    0.000000] efi: UEFI not found.
> > > > [    0.000000] OF: reserved mem: Reserved memory: No reserved-memory node in the DT
> > > > [    0.000000] NODE_DATA(0) allocated [mem 0xbfbecb00-0xbfbf09bf]
> > > > [    0.000000] psci: probing for conduit method from DT.
> > > > [    0.000000] psci: PSCIv1.1 detected in firmware.
> > > > [    0.000000] psci: Using standard PSCI v0.2 function IDs
> > > > [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
> > > > [    0.000000] psci: SMC Calling Convention v1.2
> > > > [    0.000000] RME: Using RSI version 1.0
> > > > [    0.000000] Zone ranges:
> > > > [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000bfffffff]
> > > > [    0.000000]   DMA32    empty
> > > > [    0.000000]   Normal   empty
> > > > [    0.000000] Movable zone start for each node
> > > >       :
> > > > [    6.664423] Serial: AMBA PL011 UART driver
> > > > [    7.151312] 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq = 13, base_baud = 0) is a PL011 rev1
> > > > [    7.213181] printk: console [ttyAMA0] enabled
> > > > [    8.536454] HugeTLB: registered 1.00 Gi
> > > > <...The realm guest stops here, no output since then...>
> > > > 
> > > 
> > > On my side I get to user space but virtio-serial and virtio-net don't work.  I'm
> > > guessing virtio-iommu-pci does the same thing as this patch [1], but virtio
> > > devices are disrupted because it is not configured properly.  I need to
> > > investigate to find the best approach to follow, i.e implicitly use (and
> > > configure) a virtio-iommu-pci or make sure that [1] and a virtio-iommu-pci
> > > device can play nice together.
> > > 
> > > Thanks,
> > > Mathieu
> > > 
> > > [1]. [RFC v4 21/24] target/arm/kvm-rme: Add DMA remapping for the shared memory region
> > > 
> > > 
> > > > Thanks,
> > > > Gavin
> > > > 
> > > 
> > 
