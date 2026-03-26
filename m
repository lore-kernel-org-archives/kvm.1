Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9B51CEAC2
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 00:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774486140; cv=none; b=djqCSfXejeX843odjbUDvWf1B9WKqghqHLvjrXX6r27jANcpHADD3NJueWiOwMZSPDV533cfc4L/JJuXYWVhvHv5DYVHH2NcLG/AVa2PNXChnisESz3QWD/Kc474eB/ue8JQildFz500L1Nsm/fqrMW/KGoWdy1NjZZOsp4Zu4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774486140; c=relaxed/simple;
	bh=7kaLwUO0ndW82zmJFnv547UOGhGY2wLv2BFXA/LGN3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSTOMpX/OYT1dKAZ41hmszwfXEmVKZcPkRCwt6Am7SYCHDmQLIdMVsaIlmwE8qj1ww2GonQujDzAMHq2lb/xgT69VmVxyigTvw2zE6lmBH40c6ebz2DK/b5EnNZfrgq3qMOjeWrR6YS+uqmbwrcsXpY+qP2GaZl7ksdhFbealfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcGK7cXq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTnaI0j5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcGK7cXq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTnaI0j5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774486137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ls8wjcbdyWhGqHWxekvGDwcUF0lyag9U62sJrXk3qX0=;
	b=QcGK7cXqc5HI1fLf0YxeZVuHTmOdfJexf+Hq+vpKjRwIpmUU1HAHkE/0Yg2BUGWwR3xj4t
	/KAnI7BOY2pCxw+2/UVeppyhBJDF5BKsfYheQlPA9xg5GXr3Etm8shnUsXnBuLXQ8XjyC2
	8xJaV1sNSlALpmAj1jJx0NP+zSr1rN8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-28L0hMXHNu2h5dmvIXemmA-1; Wed, 25 Mar 2026 20:48:55 -0400
X-MC-Unique: 28L0hMXHNu2h5dmvIXemmA-1
X-Mimecast-MFC-AGG-ID: 28L0hMXHNu2h5dmvIXemmA_1774486134
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b06b68783dso4856455ad.3
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 17:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774486134; x=1775090934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ls8wjcbdyWhGqHWxekvGDwcUF0lyag9U62sJrXk3qX0=;
        b=hTnaI0j5aZh2jyHI2/ck+S4+RvNrw8tNm27+vODFnBkefFWCHHN4OHS2s5VhUow/yB
         AyoypX+2Uqq1TP/+ClhqicSkpdHySkGlH/8ByjXihimlzrE3y3Hg3KtSc33hldhPjZzC
         BMYyIMU5z9Uem1s5SixqTtemAgjNMoqPwVr4/jwi0xsWmZGfiJUnVjS0AAs51BT4COIJ
         HDqmxaUPQjyPlMN3oNQnucqGP8tldO+d2Z9uCC2RcIJBFsyb8ttbam9b8RgdRTPW5EyT
         Ta86T5wfspV63yvkXZKJzmPTANRmeYXQKWWZL/1vX0oiYgXLQjeqI+koRKIjedWWxK9W
         Reiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774486134; x=1775090934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ls8wjcbdyWhGqHWxekvGDwcUF0lyag9U62sJrXk3qX0=;
        b=WH2rJkeK+Z67smfWJwrpX6FzUiCJU7/I+ksa2ybiqqdkcPVKRilKquddIOLf1zZrlz
         8sgy81W/g9t2GhD1/PJaqyImTRSCc1a2XtBg2eo1hHH4n3TCnucdMAZnyNyGKF+9ttkS
         VIw/0vi1ZJZ3cynfW8PuP+cL6aLUYF6ZGTPbqCOr6B3kd2AxYEgAfvp85PamtIAD10Ec
         FkNs8bXL9fs7CcxVltgQCyOOpO9QIj+tYkk3wIkBWt5uZdkdWkl5YJ5kXNyH4dbduHus
         LieONiJJQ407bJBtmYzcpZDAZkxXQHhsQIG17LlWDwXPyOZH//CfSfD9zDQkSDVJYydh
         G9RA==
X-Gm-Message-State: AOJu0Yz3JdBi9UW45AcinoKv1v7uckB9LXn18NpDlQW29ZnnfXK2Dlow
	07lgG8tB+0c1gKF/xVLRWvST5voGNGrMlKw5Qm7SK1168s/wCyBQ9EYGUBjSsrEvO4NY6i/CbYK
	DNCNmZYBOXzY4yBLLFi+0nEQxy/o52hznZj7KjBbd6iipwqRxNkYneA==
X-Gm-Gg: ATEYQzxd0W9SBSQ3/ZXUEsP/4SYbds30n63gIBsUn1twOA+WZFvD02dW8N0z5k1Vu0K
	JWGdnt4o/qqEs2hR3ShhDiGYzKMlvsHk0oZgqmOxT15IvTtaPyIJyc/YhUIHJWz4E5wIlwfx/XQ
	ieGSuMKNQG6RX/6tMnjoJAxqJCeGG4n1LJsqHWyaHW+aS5uo14skbJ1txysCqHtYyOyWImiuux+
	vzZQu75gEhSHMqpzJrudc33WXytkj8BGVxecUY1T0CN0HQR/GcKZYnHuNX9CrSjdhhmu3wgsw6I
	Q9I1Lf80tJ1IkPp0lSXlRviLvFvQjM1F4jeWcnecrRsBtJDwQLbC/Frpj69cRqKDdS2hECD92w5
	ZaX0EGaTYzr17nHJ3Sy9yvFUDNS6pATWUxxA6BEmbKAPxFFShJdPjnjlZn4F3iv+A
X-Received: by 2002:a17:902:da91:b0:2b0:6e4a:1c1c with SMTP id d9443c01a7336-2b0b0a1554dmr62523275ad.19.1774486134081;
        Wed, 25 Mar 2026 17:48:54 -0700 (PDT)
X-Received: by 2002:a17:902:da91:b0:2b0:6e4a:1c1c with SMTP id d9443c01a7336-2b0b0a1554dmr62522885ad.19.1774486133511;
        Wed, 25 Mar 2026 17:48:53 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76b6casm11221805ad.16.2026.03.25.17.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 17:48:52 -0700 (PDT)
Message-ID: <807b844c-32f6-4094-8c24-15d7eb1d3638@redhat.com>
Date: Thu, 26 Mar 2026 10:48:41 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/48] arm64: Support for Arm CCA in KVM
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Steven Price <steven.price@arm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei
 <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Emi Kisanuki <fj0570is@fujitsu.com>, Vishal Annapurve <vannapurve@google.com>
References: <20260318155413.793430-1-steven.price@arm.com>
 <abyAbPIkDn2bGZwd@p14s> <37bc1222-6fc7-48f0-94d3-6eaac420aa55@arm.com>
 <0b7121e7-3c74-4303-a200-01d2b7c535ce@redhat.com>
 <9247d9ea-64b4-4e8e-81f8-3c8e00750acf@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <9247d9ea-64b4-4e8e-81f8-3c8e00750acf@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Suzuki,

On 3/25/26 8:16 PM, Suzuki K Poulose wrote:
> On 25/03/2026 06:37, Gavin Shan wrote:
>> On 3/21/26 2:45 AM, Steven Price wrote:

[...]

>>
>> In upstream TF-A repository [1], I don't see the config option 'RMM_V1_COMPAT'.
>> would it be something else?
>>
>> [1] git@github.com:ARM-software/arm-trusted-firmware.git    (branch: master)
>>
> 
> suzuki@ewhatever:trusted-firmware-a$ git grep RMM_V1_COMPAT
> Makefile:       RMM_V1_COMPAT \
> Makefile:       RMM_V1_COMPAT \
> docs/getting_started/build-options.rst:-  ``RMM_V1_COMPAT``: Boolean flag to enable support for RMM v1.x compatibility
> include/services/rmmd_svc.h:#if RMM_V1_COMPAT
> include/services/rmmd_svc.h:#endif /* RMM_V1_COMPAT */
> make_helpers/defaults.mk:RMM_V1_COMPAT                  := 1
> services/std_svc/rmmd/rmmd_main.c:#if RMM_V1_COMPAT
> services/std_svc/rmmd/rmmd_main.c:#if RMM_V1_COMPAT
> services/std_svc/rmmd/rmmd_main.c:#if !RMM_V1_COMPAT
> services/std_svc/rmmd/rmmd_main.c:#if RMM_V1_COMPAT
> services/std_svc/rmmd/rmmd_main.c:#if RMM_V1_COMPAT
> services/std_svc/rmmd/rmmd_main.c:#if RMM_V1_COMPAT
> services/std_svc/rmmd/rmmd_rmm_lfa.c:#if RMM_V1_COMPAT
> services/std_svc/rmmd/rmmd_rmm_lfa.c:#if RMM_V1_COMPAT
> services/std_svc/rmmd/rmmd_rmm_lfa.c:#if RMM_V1_COMPAT
> services/std_svc/rmmd/rmmd_rmm_lfa.c:#if RMM_V1_COMPAT
> suzuki@ewhatever:trusted-firmware-a$ git log --oneline -1
> 8dae0862c (HEAD, origin/master, origin/integration, origin/HEAD) Merge changes from topic "qti_lemans_evk" into integration
> suzuki@ewhatever:trusted-firmware-a$ git remote get-url origin
> https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
> 

Thanks for the details. It turned out that I used the wrong TF-A repository. In
the proposed repository, I'm able to see the option 'RMM_V1_COMPAT' and the EL3-RMM
interface compatible issue disappears. However, there are more issues popped up.

I build everything manually where the host is emulated by QEMU instead of shrinkwrap
and FVP model. It's used to work well before. Maybe it's time to switch to shinkwrap
and FVP model since device assignment (DA) isn't supported by an emulated host
by QEMU and shrinkwrap and FVP model seems the only option. I need to learn how
to do that later.

There are two issues I can see with the following combinations. Details are provided
like below.

     QEMU:      https://git.qemu.org/git/qemu.git                            (branch: stable-9.2)
     TF-RMM:    https://git.trustedfirmware.org/TF-RMM/tf-rmm.git            (branch: topics/rmm-v2.0-poc)
     EDK2:      git@github.com:tianocore/edk2.git                            (tag:    edk2-stable202411)
     TF-A:      https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git  (branch: master)
     HOST:      https://git.gitlab.arm.com/linux-arm/linux-cca.git           (branch: cca-host/v13)
     BUILDROOT: https://github.com/buildroot/buildroot                       (branch: master)
     KVMTOOL:   https://gitlab.arm.com/linux-arm/kvmtool-cca                 (branch: cca/v11)
     GUEST:     https://github.com/torvalds/linux.git                        (branch: master)

(1) The emulated host is started by the following command lines.

     sudo /home/gshan/sandbox/cca/host/qemu/build/qemu-system-aarch64                  \
     -M virt,virtualization=on,secure=on,gic-version=3,acpi=off                        \
     -cpu max,x-rme=on -m 8G -smp 8                                                    \
     -serial mon:stdio -monitor none -nographic -nodefaults                            \
     -bios /home/gshan/sandbox/cca/host/tf-a/flash.bin                                 \
     -kernel /home/gshan/sandbox/cca/host/linux/arch/arm64/boot/Image                  \
     -initrd /home/gshan/sandbox/cca/host/buildroot/output/images/rootfs.cpio.xz       \
     -device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                             \
     -device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                             \
     -device pcie-root-port,bus=pcie.0,chassis=3,id=pcie.3                             \
     -device pcie-root-port,bus=pcie.0,chassis=4,id=pcie.4                             \
     -device virtio-9p-device,fsdev=shr0,mount_tag=shr0                                \
     -fsdev local,security_model=none,path=/home/gshan/sandbox/cca/guest,id=shr0       \
     -netdev tap,id=tap1,script=/etc/qemu-ifup-gshan,downscript=/etc/qemu-ifdown-gshan \
     -device virtio-net-pci,bus=pcie.2,netdev=tap1,mac=b8:3f:d2:1d:3e:f1

(2) Issue-1: TF-RMM complains about the root complex list is invalid. This error is
     raised in TF-RMM::setup_root_complex_list() where the error code is still set to
     0 (SUCCESS) in this failing case. The TF-RMM initialization is terminated early,
     but TF-A still thinks the initialization has been completely done.

     INFO:    BL31: Initializing RMM
     INFO:    RMM init start.
     RMM EL3 compat memory reservation enabled.
     Dynamic VA pool base address: 0xc0000000
     Reserved 20 pages. Remaining: 3615 pages
     Reserve mem: 20 pages at PA: 0x401f2000 (alignment 0x1000)
     Static Low VA initialized. xlat tables allocated: 20 used: 7
     Reserved 514 pages. Remaining: 3101 pages
     Reserve mem: 514 pages at PA: 0x40206000 (alignment 0x1000)
     Dynamic Low VA initialized. xlat tables allocated: 514 used: 514
     Invalid: Root Complex list                                         <<<<< ERROR
     INFO:    RMM init end.

(3) Issue-2: The host kernel gets stuck in rmi_check_version() where SMC_RMI_VERSION
     is issued to TF-A, but it can't be forwarded to TF-RMM because its initialization
     isn't completely done (issue-1).

     [   37.438253] Unpacking initramfs...
     [   37.563460] kvm [1]: nv: 570 coarse grained trap handlers
     [   37.581139] kvm [1]: nv: 664 fine grained trap handlers
     <... system becomes stuck here ...>

So my workaround is to skip fetching root complex list from the EL3-RMM manifest data
in TF-RMM::setup_root_complex_list() since it's not provided for the qemu platform by
TF-A. With this workaround, the host can boot up into shell prompt and the guest can
be started by kvmtool.

     host$ uname -r
     7.0.0-rc1-gavin-gd62aa44b2590
     host$ lkvm run --realm -c 2 -m 256                   \
           -k /mnt/linux/arch/arm64/boot/Image            \
           -i /mnt/buildroot/output/images/rootfs.cpio.xz
           -p earlycon=uart,mmio,0x101000000
     Info: # lkvm run -k /mnt/linux/arch/arm64/boot/Image -m 256 -c 2 --name guest-163
     Info: Enabling Guest memfd for confidential guest
     Warning: The maximum recommended amount of VCPUs is 1
     [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
     [    0.000000] Linux version 7.0.0-rc2-gavin-g0031c06807cf (gshan@nvidia-grace-hopper-01.khw.eng.bos2.dc.redhat.com) (gcc (GCC) 14.3.1 20251022 (Red Hat 14.3.1-4), GNU ld version 2.41-64.el10) #2 SMP PREEMPT Wed Mar 25 20:28:05 EDT 2026
     [    0.000000] KASLR enabled
          :
     [  267.578060] Freeing initrd memory: 4728K
     [  267.921865] Warning: unable to open an initial console.
     [  270.327960] Freeing unused kernel memory: 1792K
     [  270.669368] Run /init as init process

Thanks,
Gavin

