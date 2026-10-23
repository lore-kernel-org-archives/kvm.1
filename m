Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753227;
	b=lDE/IVBZvjG9anihClpQD2JnaOfbUM/Inz+GzvtOQABVrBWV0vP9hsM+Mrc0srbOwnfY
	 uBYtS02y+jMzxdKIIIHmZeeC0azs94eEaPqXwhIaSixH8NQZU2MKPQxs0TuggObfg4vAg
	 SuLQqwU3W8dud4NL4osCEqFEVkFxE8Ih83V7eR3y8fJ0PR2ZQuSXTA5YZDra/bl3utn6s
	 J55rFbyGLgGN13RWBr70J7j3S8JygLvde3oa8BQRgt2ZHGME6JYAn6xOoJVwhaBjoSxQx
	 bkpIvWeyY7/zHhOnR2y+u4VbWvrSlcnk1lhb5QrwtjZ82M4EpXe8t2VrJXUCTGtqJhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753227;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qrZL2f5o4+Xc8gq5VwaZW1aKtNUxwAJ20SUnHLccVwE=;
	b=jXsS8LUH0bo2TqSl6drxDjceVNvJ035+BAkpygsmyCcWxDE9qdjFtxRDxN5BM4y+k+vC
	 8neJXg/p7DyU2abfLBbRWXTcDEW4VW/gJJBzpMG4zQTlpd5oyPy/4wWwIQXWK1dprbo68
	 euupKcyvgfptGrmn/weNO+NKgfdmBe1yJsPcfskyJicHzTTLH9qJ0nnQOUah/Ixm77ReC
	 wHrPJr6+IMth1iN/9hUWXHJ5W908/V8+kPV9OyDVP46DAHHkztkmhyI26VVMpjm13bxAY
	 PyLyIoGYl2hBjL2IspcEJpdAvd5FodNHCV+6rrUAY/hM7ACP61gd7O/P69puANOPr+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WtfO8CzN;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RZspV6kk;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFC3606A31F
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 11:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BFC3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WtfO8CzN;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RZspV6kk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792753225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrZL2f5o4+Xc8gq5VwaZW1aKtNUxwAJ20SUnHLccVwE=;
	b=WtfO8CzNtxOv+X6Aot1F7mzOr4zSjiVhO4wY2wNTa5KIw04QlxsDRybrTTdaTQpmFJltfB
	b0WavOapbfMtwpq5sME43X1iQs4KcIhxS22eYmHbWCWoHbRtc6/WDV/7lHRP05DfNfgQu+
	AESx3vWs6AEdeCYm7qJ/qLpRpe9AePo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-IPVLo3MYMIytXY1NdqnUpg-1; Fri, 23 Oct 2026 07:00:21 -0400
X-MC-Unique: IPVLo3MYMIytXY1NdqnUpg-1
X-Mimecast-MFC-AGG-ID: IPVLo3MYMIytXY1NdqnUpg_1792753221
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad7030e886so886489a91.0
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 04:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792753221; x=1793358021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qrZL2f5o4+Xc8gq5VwaZW1aKtNUxwAJ20SUnHLccVwE=;
        b=RZspV6kk0wOf3Ghz8hPe4S5v/VoaFlekpqWhx61SDLJ5ap1zJzGjPNVXEEE2uXX/sa
         gzbQ6dDUwNhhStd/UN/Y51lZjIE5u9Ua6Gi9lW6vhtOJbFvhbY9dErc6T7vcP6sRZr1K
         RMjrhXShoJ2Ht/BjCQq/YruwusI1j/z3tMc90+MgbGWS1H1VL+FuJfLCmPW94GyW0kgM
         vBfhn1fM8NTtCgapW8CJ8+IiViyMEJ4Jp19Nfrt/lrZVJLxyJMc2NniqEw4YnLl7Ca96
         hqpOtaAAAzAwMoCGcDRctW1afsC5RO4DtCv7Xc1G5JhYFXtcTu+K9901qVqXydN5xtqP
         RSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792753221; x=1793358021;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qrZL2f5o4+Xc8gq5VwaZW1aKtNUxwAJ20SUnHLccVwE=;
        b=jn+Hfbd5et/u4479L9JrBCqEwrDsStTwmqS2WxAhPWcb/Y65Tqp82aD5eccbO3Mds5
         84tTdgvUVmE2XtdCfRolS0kPg7gV0d5pW37DqQ46yHuE1s9HzACFAx0Vr7fuo9Dsi1cs
         wlR1iLquC3NHLciyPgQelZ8ZO31/QQdeoPrl8/BOebffnWujwK7uxQ1IPy5GSZpwt40d
         0OCKApvd0crtw1TawCc2K5dE69COdeDZab0v6I3c98Vvl5YFtIwHIZXPGJ0m6WuBpwu3
         OK/I8NGHxUOr0LaNrK5r17LpsLjFa5QYI3PawIwuf9bjm+PzaJGK1SMXpe0SfuMWBPPI
         GGgA==
X-Forwarded-Encrypted: i=1; AKwUvBwZ8wd60DWvR9Tn3SR/brP8wbnksl9Ve78iq8p7IZYBojX4JKNV/q9lG9mBKZu3698P7Iw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHzaDOyh/sx7dd4fPpSnjyZMzDJ47jo1m6Op+E3Z7hveA0w0Yg
	zin1ckcHSKUtxB7EshEow5qY/8Q/m5p33cDtjrsS8g4hsw20h7UCxzPMp8a2prDCoFwr/OkFc3R
	WRwgWyaXG13LaSxIxfYDPtBaJMHj4ZTmGsUyxk5p0MD1tKxI+hNElPQ==
X-Gm-Gg: AYBFou1g0AxEq6Z+u7AFQGApB+1vtq+Pc7Zd/IOaY49a8EGRPP2X+eAFRfiHQYGuKFk
	jnD59NWbw954k4b18AY4XSd+ScnEGRZCIYlTXupyj6B861/zn1XtHheMt2BqxOEy3n2mmngfK2z
	PXyT48YtRTbDOQqT+4Ifign4tJhLNPTDBLHI2OsurxZgGdBJQ2nqbzLKKIStgXTj1d5xKwRZK1J
	a+e7r1JqMewqINYchU+oIfz+t2KvnpMzXKoV1edlGsNPbGHZkJZQysaO2A757K+Pyh9cfu0TA02
	mntJi3bOsBn0BWgYC1mbKJbtbSCD1ssmZXnHlDtj1DqaRqlgfhKtfzAva5smAcVWw8dSQnJEYsS
	R9j7zNVKw5nTYCV9dGiUFkhNd0hgS/luUadluI9B+7w==
X-Received: by 2002:a17:90b:1a84:b0:3a8:2c7e:8986 with SMTP id 98e67ed59e1d1-3adce02dfe4mr1512126a91.17.1792753220284;
        Fri, 23 Oct 2026 04:00:20 -0700 (PDT)
X-Received: by 2002:a17:90b:1a84:b0:3a8:2c7e:8986 with SMTP id 98e67ed59e1d1-3adce02dfe4mr1512066a91.17.1792753219495;
        Fri, 23 Oct 2026 04:00:19 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb0a11fbsm3206800a91.4.2026.10.23.04.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 04:00:18 -0700 (PDT)
Message-ID: <5dba456f-26b4-4f05-9271-fb784736d581@redhat.com>
Date: Fri, 23 Oct 2026 21:00:12 +1000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 00/24] Add Realm support to QEMU-VMM
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <7dea93a6-b119-4882-9c56-557a372b646a@redhat.com> <atkokvqTHygpI8dt@p14s>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <atkokvqTHygpI8dt@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mathieu,

On 10/22/26 7:03 AM, Mathieu Poirier wrote:
> Hi Gavin,
> 
> On Mon, Sep 21, 2026 at 02:05:19PM +1000, Gavin Shan wrote:
>> Hi Mathieu,
>>
>> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
>>> This patchset provides minimal functionality to start a Realm VM
>>> from an Arm RME capable host using the following command line:
>>>
>>> qemu-system-aarch64 \
>>>    -M confidential-guest-support=rme0,memory-backend=ram0 \
>>>    -object rme-guest,id=rme0,convert-in-place=on \
>>>    -object memory-backend-guest-memfd,id=ram0,size=1G,share=on \
>>>    -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
>>>
>>> It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
>>> back.  It is compatible with Steven Price's v16 revision [1] of his work adding
>>> CCA support to KVM.
>>>
>>> This revision is based on Michael Roth's work on guest memfd in-place memory
>>> conversion [2], rebased to QEMU master.  I left out the AMD specific changes
>>> from Michael's work because I can't test the result.  Other than the
>>> modications to the linux headers, this series is identical to V3.
>>>
>>> It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
>>> here [3], along with the TF-A [4] and RMM [5] for the SBSA machine (compatible
>>> with Steven's v16 patchset).  The Repository for the kernel [6] is also
>>> available.  Note that for the latter, defines for
>>> KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES and KVM_CAP_ARM_RMI have been modified to
>>> follow QEMU master.
>>>
>>> Instructions to compile and run the entire stack can be found here [7].
>>>
>>> Device Assignment is not included.
>>>
>>> Thanks,
>>> Mathieu
>>>
>>> [1]. https://lore.kernel.org/kvm/20260803134403.80630-1-steven.price@arm.com/
>>> [2]. https://lore.kernel.org/kvm/20260528000416.8161-1-michael.roth@amd.com/
>>> [3]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v4?ref_type=heads
>>> [4]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
>>> [5]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v16?ref_type=heads
>>> [6]. https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v4?ref_type=heads
>>> [7]. https://gitlab.com/Linaro/cca-public/build-instructions
>>>
>>
>> Give this series and (v19) arm/cca host series [1] a try, and found the following
>> issues. I'm sharing the found issues that I need take chance to look at them
>> closely in future.
>>
>> [1] https://git.gitlab.arm.com/linux-arm/linux-cca.git  (branch: cca/cca-host/kvm-v19/integration)
>>
>> Note that the host is emulated using qemu (TCG mode) via 'virt' platform, using
>> the following command lines
>>
>> laptop$ /home/gshan/sandbox/cca/host/qemu/build/qemu-system-aarch64                 \
>>          -M virt,virtualization=on,secure=on,gic-version=3,acpi=off                  \
>>          -cpu max,x-rme=on -m 4G -smp 8                                              \
>>          -serial mon:stdio -monitor none -nographic -nodefaults                      \
>>          -bios /home/gshan/sandbox/cca/host/tf-a/flash.bin                           \
>>          -kernel /home/gshan/sandbox/cca/host/linux/arch/arm64/boot/Image            \
>>          -initrd /home/gshan/sandbox/cca/host/buildroot/output/images/rootfs.cpio.xz \
>>          -append kvm-arm.mode=rmm                                                    \
>>          -device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                       \
>>          -device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                       \
>>          -device pcie-root-port,bus=pcie.0,chassis=3,id=pcie.3                       \
>>          -device pcie-root-port,bus=pcie.0,chassis=4,id=pcie.4                       \
>>          -device virtio-9p-device,fsdev=shr0,mount_tag=shr0                          \
>>          -fsdev local,security_model=none,path=/home/gshan/sandbox/cca/guest,id=shr0 \
>>          -netdev tap,id=tap1,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown       \
>>          -device virtio-net-pci,bus=pcie.2,netdev=tap1,mac=b8:3f:d2:1d:3e:80
>>
>> The realm VM is started using the following command lines.
>>
>> host$ qemu-system-aarch64 -enable-kvm -object rme-guest,id=rme0,convert-in-place=on \
>>        -machine virt,gic-version=3,confidential-guest-support=rme0 -m 2G -cpu host   \
>>        -smp maxcpus=4,cpus=4,sockets=1,clusters=1,cores=2,threads=2                  \
>>        -object memory-backend-guest-memfd,id=mem0,size=2G,share=on                   \
>>        -numa node,nodeid=0,cpus=0-3,memdev=mem0                                      \
>>        -serial mon:stdio -monitor none -nographic -nodefaults                        \
>>        -kernel /mnt/linux/arch/arm64/boot/Image                                      \
>>        -initrd /mnt/buildroot/output/images/rootfs.cpio.xz                           \
>>        -append earlycon=pl011,mmio,0x10009000000
>>
>> Found issues
>> ============
> 
> I was able to do the same manipulations on my side, but using the SBSA machine
> for system emulation, with results as described below:
>

Thanks for double check on your side. Just a head up: I will re-run the broken test
cases with (RFCv5) qemu series and share the result. I expect we will have more
discussions on those broken test cases under RFCv5 series if you agree. I don't
know when I get a chance to try RFCv5 series, but hopefully next week or early
of the week after that.

Cheers,
Gavin

  
>>
>> (1) qemu is terminiated on qmp command 'dump-guest-memory'
>>
>> (qemu) dump-guest-memory -p "/tmp/mem" 0x40000000 0x10000000
>> **
>> ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
>> Bail out! ERROR:../system/memory_mapping.c:215:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
>>
> 
> On my side this command causes the Realm to abort, as I expected it to be.
> Realm memory should not be observable from the host.  There may be a debug mode
> to enable this kind of operation but I will have to look at the documentation
> for details.
>   
>> (2) qemu emulation can't be stopped and resumed
>>
>> (qemu) stop
>> (qemu) cont
>> Failed to set KVM_REG_ARM_TIMER_CNT
>>
> 
> That too I was expecting.  Anything that can comprimise a Realm will cause the
> HW to abort.  I'll investigate the "Failed to set KVM_REG_ARM_TIMER_CNT" error
> message though.
> 
>> (3) qemu is terminiated on qmp command 'system_reset'
>>
>> (qemu) system_reset
>> cpus are not resettable, terminating
>>
>> (4) 'reboot' from the guest doesn't work
>>
>> root@guest:~# reboot
>>     :
>> Requesting system reboot
>> [  123.264893] reboot: Restarting system
>> qemu-system-aarch64: cpus are not resettable, terminating
>>
> 
> I suspect 'system_reset' from the monitor and a 'reboot' from the command line
> will, at some point, end up following the same sequence.  I need to think about
> the 'reboot' use case further.
> 
> 
>> (5) Incompatible to virtio-iommu-pci. The realm guest doesn't boot up if a virtio-iommu-pci
>>      device is specified in the command lines
>>
>> host$ qemu-system-aarch64 -enable-kvm                                          \
>> -object rme-guest,id=rme0,convert-in-place=on                                  \
>> -machine virt,gic-version=3,confidential-guest-support=rme0                    \
>> -m 2G -cpu host -smp maxcpus=4,cpus=4,sockets=1,clusters=1,cores=2,threads=2   \
>> -object memory-backend-guest-memfd,id=mem0,size=2G,share=on                    \
>> -numa node,nodeid=0,cpus=0-3,memdev=mem0                                       \
>> -serial mon:stdio -monitor none -nographic -nodefaults                         \
>> -kernel /mnt/linux/arch/arm64/boot/Image                                       \
>> -initrd /mnt/buildroot/output/images/rootfs.cpio.xz                            \
>> -append earlycon=pl011,mmio,0x10009000000                                      \
>> -device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                          \
>> -device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                          \
>> -device virtio-iommu-pci,bus=pcie.0                                            \
>> -drive file=/mnt/disk.qcow2,if=none,id=drive0                                  \
>> -device virtio-blk-pci,id=virtblk0,bus=pcie.1,drive=drive0,num-queues=4        \
>> -netdev tap,id=tap1,vhost=on,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
>> -device virtio-net-pci,bus=pcie.2,netdev=tap1,mac=b8:3f:d2:1d:3e:c0
> 
> 
> I added the following to my Realm's boot command parameters:
> 
> -device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1 \
> -device virtio-iommu-pci,bus=pcie.0 \
> 
> 
>>       :
>> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
>> [    0.000000] Linux version 7.2.0-rc5-gavin-gf5098b6bae76 (gshan@nvidia-grace-hopper-01.khw.eng.bos2.dc.redhat.com) (gcc (GCC) 14.3.1 20251022 (Red Hat 14.3.1-4), GNU ld version 2.41-65.el10) #47 SMP PREEMPT Mon Jul 27 02:29:03 EDT 2026
>> [    0.000000] KASLR enabled
>> [    0.000000] Machine model: linux,dummy-virt
>> [    0.000000] earlycon: pl11 at MMIO 0x0000010009000000 (options '')
>> [    0.000000] printk: legacy bootconsole [pl11] enabled
>> [    0.000000] efi: UEFI not found.
>> [    0.000000] OF: reserved mem: Reserved memory: No reserved-memory node in the DT
>> [    0.000000] NODE_DATA(0) allocated [mem 0xbfbecb00-0xbfbf09bf]
>> [    0.000000] psci: probing for conduit method from DT.
>> [    0.000000] psci: PSCIv1.1 detected in firmware.
>> [    0.000000] psci: Using standard PSCI v0.2 function IDs
>> [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
>> [    0.000000] psci: SMC Calling Convention v1.2
>> [    0.000000] RME: Using RSI version 1.0
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000bfffffff]
>> [    0.000000]   DMA32    empty
>> [    0.000000]   Normal   empty
>> [    0.000000] Movable zone start for each node
>>       :
>> [    6.664423] Serial: AMBA PL011 UART driver
>> [    7.151312] 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq = 13, base_baud = 0) is a PL011 rev1
>> [    7.213181] printk: console [ttyAMA0] enabled
>> [    8.536454] HugeTLB: registered 1.00 Gi
>> <...The realm guest stops here, no output since then...>
>>
> 
> On my side I get to user space but virtio-serial and virtio-net don't work.  I'm
> guessing virtio-iommu-pci does the same thing as this patch [1], but virtio
> devices are disrupted because it is not configured properly.  I need to
> investigate to find the best approach to follow, i.e implicitly use (and
> configure) a virtio-iommu-pci or make sure that [1] and a virtio-iommu-pci
> device can play nice together.
> 
> Thanks,
> Mathieu
> 
> [1]. [RFC v4 21/24] target/arm/kvm-rme: Add DMA remapping for the shared memory region
> 
> 
>> Thanks,
>> Gavin
>>
> 

