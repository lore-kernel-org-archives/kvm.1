Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679070;
	b=y3vuq1bJpHpDZR71BkmXNeyva//ScAn3CxCoaG/emENz5OrB4sY+nA9Do8niQg0UGuuL
	 /Kw4jSe5xq90rCUHJ63f9xmSLEHPqp4Imx74h7HfcPh5A3A+QR2Pr8lxaDmLQVAyYHEmE
	 ft6ERfCf7GSjVkouWR+zot752+JomkOt8cG/etJImGnRQ01ZNDs2lTtRuXYJM4zw/RJGT
	 Y5HQa9masfyzG0m5vk4SPkCsamG1/Njd/+O+T8KdRFCK6mZeBRZdBcyX+/crE5a2jAKUI
	 YqmM1JVvdzVypgPoMiEya+0YCIP1CuMWISoicPOiPOIRVu6gYfYLFtiJ7myHcrMAuTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Oeu8fRL3y/S5bZyksCXvYqJHykgbAKegGBLalUwV/PE=;
	b=I70/VZJnaT6/DJEJQl6Q5nMS9QpFN/HxvD4WrmG47jSeR+yzh/Gdp77jLdWjiaxM4cvr
	 /4QCY51CxIJfKGDKfOLaRcaqEyGBTb9NHQl/MgxTOA0f3iJdu5T7CcuertiGfRfI/gfR+
	 ADjuSAzHhJ0DtNuz+yL2CyvrCxDgVgJJUR6/IE8kO4foHfQ7eZXznTJ7m/QbygG4peGg8
	 W4JUjS7EEzVZ25eZ1mZnmVMZYW7Fc60HEsI2wzyrLHxPbuGuUmh6O6Z5NGNH+eJnvljTK
	 4miuGh09SS96DPWRK91sI9pZa7Kn3BOwmA41mO6trKS8nEO53Grai4S02/dyEPPHkyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yiqucYiP;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324A606A327
	for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 17:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5324A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yiqucYiP
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so13482115e9.3
        for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 09:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794679069; x=1795283869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oeu8fRL3y/S5bZyksCXvYqJHykgbAKegGBLalUwV/PE=;
        b=yiqucYiPhicJpvweTW8QlOt990uPnzzoTAoTZKVxBSOsacWKJCWpQ6kmtpxXBSsmfZ
         dA6cccGEX/mnZVBztmMQ7K3lNMCn49Hw3Chc3oNrNoAuEttmV8Hq0pXNoJtUNlICfNd5
         Q4exnWlV6pKgguc+UIVvBeHb6EvYESUBPh7U6i0pUTsPofLsd0tgwU3MGh1vMr6TiDkE
         ydB3hF6LD2moJYc7fZHF6WvOD4j0MoXLCiq2qr53vdZSjyTYyM//XH/qKX7PDQbegzJx
         BZ0S3aMBxZA2FJkDp7s2BtJCAzhBgsnbngpjBomfr3OnGLtpG1bZtDUg541snvCJQgj0
         5PYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794679069; x=1795283869;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oeu8fRL3y/S5bZyksCXvYqJHykgbAKegGBLalUwV/PE=;
        b=wR0R/8U1pxXJpm6IgBRA17IvGoIV2+qImse0GbnmXSiDKCUhxS9I9Znp4+JGmzhe9l
         BsL7wPyBvo8LzHrtJW61m7hm53r20H4LDuSSK/zsD32AdMcvInWeYbj7x/58pkReMoxs
         yCGuZW4vVS0FyGxXYF7HwwIpbXDrkv9RnVFMKtuAKI6fGwUPUYH7J5wOiOuBj2IdD46+
         pFjbisSbSjrd0NsglRBDEaryAV35WFrxEf5RMYVocZz/7eBJ5KIVAeqYNlVsn9ji47l/
         8NvW4sfBaKce2CAQJVLsaGTnFDukHw2iViD+LjBS2mrqBkE+u1t0bwqK2eExzjysDPx/
         0Lfw==
X-Forwarded-Encrypted: i=1; AL+hErHLKt+QYYZATKdNvbXJFv8wMPKvlCPrG48emXXYsPRvTmHeLS8sI2lb2RibvxzAq0yewjs=@vger.kernel.org
X-Gm-Message-State: APuU4Z83ZWvTOlgb7ngMACJqQE0JLlDiiOsCQsx4vD7+oZv6H7S+g12P
	0mYBqjHKkHfQBiiIkPuBC89wXgHLaXTIo0D7MNHNNsbp0S+rzKGPEMeb
X-Gm-Gg: AYBFou2P6UozSYzQp+OLgpju7jT6SbxMv8keI+0WZFaTQ73jI01v8dpGGdkynpOzlqn
	ao3PnCdvt2ItansqI51E3jCsqGc/NlzRFuuWpFUVHJ5s3YZkTn7a9JcGyFA2I157i3OPF2iOIW8
	HYfVteyVpXp3PJeJyZr9O8T0xJYGF2LB2ioLNhkKu+77chyiMeywx7Bfha9M2tr8Tzd7E6w2xIz
	ZPC87ZH1ky+WrpkaTa5qGTKtt0v+FNh1F7c/oQxrxg411t5wFmad5/DwkfC3NcW4nEf5i+Y6+9F
	kxt/C2YXhyf6ZSnXDyA21kCRy/PKFROEQRfF+T8JX3bFpjbQG7d/Ggpq0fQ0Dy4Yj2Lp9YxrnHD
	FP6DmQ3ysggpgbkxmvmx+S0yzDHtmAmK43PPjJSbEjWk/XhqXg/ZqzXcz0yA32IX8wE1MHEi8pI
	t21GTxrUxtBgR2YeDA3STl16iiHFbFy8fNieo4A3zbgR5Le9TkVzqIvGT4BbLKK3NYRd/8Atnen
	C2sS122x+s6Brj/jIVQLZ4HEMpLVLl9mQCKAUJt+da2yUK6175GcNGIYa55gHzn2TgTJ74axEI0
	C9ZTgSnHs2CRyJBMMpWVTV0H9miN46jpQGzU/GJVbSGSnNJgM+x7mNN0d06n0igDTaMjsg+Gf2V
	kUpE=
X-Received: by 2002:a05:600c:b86:b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4bb55a67c61mr134469755e9.26.1794679068535;
        Sat, 14 Nov 2026 09:57:48 -0800 (PST)
Received: from [192.168.1.6] (user-109-243-65-71.play-internet.pl. [109.243.65.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb68c00b10sm14350715e9.0.2026.11.14.09.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 09:57:48 -0800 (PST)
Message-ID: <a5170ee5-ccf6-4f19-8ecf-1bc82e3d54d1@gmail.com>
Date: Sat, 14 Nov 2026 18:57:46 +0100
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
Subject: Re: [PATCH] RISC-V: KVM: Order IMSIC VS-file write before releasing
 vsfile_lock
To: Anup Patel <anup@brainfault.org>
Cc: Anup Patel <anup.patel@oss.qualcomm.com>,
 Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261023142550.148604-1-oleksii.kurochko@gmail.com>
 <CABBgwmuBBbyBytwRBTeAqF=0c1m+TFK8E3yPopGNQAsrMFO2vg@mail.gmail.com>
 <7e634bef-6d23-4a57-b3e6-b5585045ca19@gmail.com>
 <CAAhSdy2cL6u_pAinYFU64nfqespQU+2x3GTeiqvjFUbJyYLLMA@mail.gmail.com>
Content-Language: en-US
From: Oleksii Kurochko <oleksii.kurochko@gmail.com>
In-Reply-To: <CAAhSdy2cL6u_pAinYFU64nfqespQU+2x3GTeiqvjFUbJyYLLMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/14/26 2:35 PM, Anup Patel wrote:
> On Fri, Nov 13, 2026 at 11:49 PM Oleksii Kurochko
> <oleksii.kurochko@gmail.com> wrote:
>>
>>
>>
>> On 11/13/26 9:00 AM, Anup Patel wrote:
>>> On Fri, Oct 23, 2026 at 7:56 PM Oleksii Kurochko
>>> <oleksii.kurochko@gmail.com> wrote:
>>>>
>>>> kvm_riscv_vcpu_aia_imsic_inject() writes the interrupt identity to the
>>>> SETIPNUM register of the vCPU's IMSIC VS-file while holding vsfile_lock
>>>> for reading. The lock keeps the VS-file from being switched under the
>>>> injector: kvm_riscv_vcpu_aia_imsic_update() and
>>>> kvm_riscv_vcpu_aia_imsic_release() take it for writing to move the vCPU
>>>> to a new VS-file or to the SW-file, then read and clear the old VS-file
>>>> and free its HGEI line.
>>>>
>>>> On RISC-V, writel() is followed only by mmiowb_set_pending(). The
>>>> trailing "fence o,w" is deferred to spin_unlock() by the mmiowb()
>>>> tracking, and rwlocks don't take part in that tracking:
>>>> queued_read_unlock() issues just "fence rw,w" before the AMO, which
>>>> doesn't order device output. So the SETIPNUM write can still be in
>>>> flight after another hart has observed vsfile_lock being released. If
>>>> the old VS-file is read and cleared before the write lands, the
>>>> interrupt is lost. If the HGEI line has already been handed out
>>>> again, the interrupt ends up in another vCPU's VS-file.
>>>>
>>>> Add an explicit RISCV_FENCE(o, w) after the write to the VS-file, which
>>>> is what spin_unlock() would issue via mmiowb().
>>>>
>>>> Fixes: db8b7e97d613 ("RISC-V: KVM: Add in-kernel virtualization of AIA IMSIC")
>>>> Signed-off-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
>>>> ---
>>>> Why RISCV_FENCE(o, w) and not mmiowb():
>>>>
>>>> - Since the mmiowb() rework in v5.2 (e.g. commit 60ca1e5a200c
>>>>     ("mmiowb: Hook up mmiowb helpers to spinlocks and generic I/O
>>>>     accessors")), mmiowb() is an implementation detail of the spinlock
>>>>     code. Explicit invocations were removed from drivers by commit
>>>>     fb24ea52f78e ("drivers: Remove explicit invocations of mmiowb()") and
>>>>     from the documentation by commit 915530396c78 ("Documentation: Kill
>>>>     all references to mmiowb()"), so adding a new direct caller would go
>>>>     against that.
>>>>
>>>> - RISCV_FENCE(o, w) states exactly the ordering needed here (device
>>>>     output before the store that releases the lock), which is fine for
>>>>     arch-specific code, and it is the same instruction mmiowb() expands to
>>>>     on RISC-V. wmb() ("fence ow,ow") would also work but is stronger than
>>>>     required.
>>>>
>>>> Scope: this only orders the write before the lock release. Whether a
>>>> write that is already in global memory order is guaranteed to have
>>>> taken effect in the old VS-file before kvm_riscv_vcpu_aia_imsic_update()
>>>> or kvm_riscv_vcpu_aia_imsic_release() reads and clears it is a separate
>>>> question, see https://github.com/riscv/riscv-aia/issues/172. If it
>>>> isn't, these paths will also need to drain the old VS-file, and such a
>>>> drain depends on the ordering added here.
>>>> ---
>>>>    arch/riscv/kvm/aia_imsic.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
>>>> index f17dc559a709..807bb73a129a 100644
>>>> --- a/arch/riscv/kvm/aia_imsic.c
>>>> +++ b/arch/riscv/kvm/aia_imsic.c
>>>> @@ -1056,6 +1056,13 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vcpu,
>>>>
>>>>           if (imsic->vsfile_cpu >= 0) {
>>>>                   writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
>>>> +               /*
>>>> +                * rwlocks don't participate in mmiowb() tracking, so order
>>>> +                * the write to the VS-file before releasing vsfile_lock,
>>>> +                * i.e. before the vCPU can be moved off this VS-file and
>>>> +                * the VS-file read and cleared.
>>>> +                */
>>>> +               RISCV_FENCE(o, w);
>>>
>>> Another fence after every writel() is a big hammer in the path.
>>>
>>> If the intention is to have correct contents when VS-file is read then
>>> better place to add a fence is at the start of imsic_vsfile_local_read().
>> Thanks for the review.
>>
>> I don't think a fence in imsic_vsfile_local_read() helps here. The
>> problem is on the writer's side, and imsic_vsfile_local_read() runs on
>> a different hart.
>>
>> The SETIPNUM write is done by whichever hart calls
>> kvm_riscv_vcpu_aia_imsic_inject(), which can be any CPU (irqfd,
>> ioctl, ...). imsic_vsfile_local_read() runs on the old vsfile_cpu, via
>> the IPI from imsic_vsfile_read(). A fence only orders the accesses of
>> the hart that executes it, so a fence on the reading hart can't make
>> another hart's MMIO store land.
>>
>> Without the fence, this can happen:
>>
>>     hart A (inject)            hart B (update/release)    hart C (old
>> vsfile_cpu)
>>     read_lock()
>>     writel(SETIPNUM)
>>       (store still in flight)
> 
> Over here the MMIO write targets hart C IMSIC
> 
>>     read_unlock()
>>                                write_lock()
>>                                switch VS-file
>>                                write_unlock()
>>                                IPI ------------------->
>>                                                          fence  <-proposed
>>                                                          read+clear VSfile
>>                                free HGEI
>>     SETIPNUM lands: the interrupt
>>     is lost, or ends up in another
>>     vCPU's VS-file if the HGEI was
>>     already reused
>>
>> Hart A's unlock can become visible before its SETIPNUM write has
>> reached the IMSIC, because read_unlock() doesn't order device output.
>> Nothing that hart B or hart C does afterwards can wait for that write.
>> Only hart A can hold back its unlock until the write is ordered, and
>> that is what the fence o,w after writel() does.
>>
>> With the fence:
>>
>>     hart A (inject)            hart B (update/release)    hart C (old
>> vsfile_cpu)
>>     read_lock()
>>     writel(SETIPNUM)
>>     fence o,w
>>     read_unlock()
>>                                write_lock()
>>                                switch VS-file
>>                                write_unlock()
>>                                IPI ------------------->
>>                                                         read+clear VS-file
>>                                free HGEI
>>
>> The SETIPNUM write is now ordered before the unlock, so it is also
>> ordered before everything hart B does after taking the lock, and,
>> through the IPI, before hart C reads the old VS-file. It can no longer
>> arrive after the read or after the HGEI is freed.
>>
>> About the cost: this is the same fence that every writel() under a
>> spinlock already gets. On RISC-V, writel() only sets mmiowb pending and
>> spin_unlock() then issues "fence o,w". We need it explicitly here only
>> because vsfile_lock is an rwlock. It runs once per injected MSI, and
>> only when the vCPU has a VS-file.
> 
> I am still not on-board adding a barrier in hot-path. Also, any barrier
> we add must be paired with a barrier else where with proper comments
> so this single barrier anyways does not satify this requirement.

Oh, right, I missed that.

> 
> Instead of this, I think a much cleaner approach is to convert vsfile_lock
> to raw_spinlock_t. The current vsfile_lock being a rwlock_t is create other
> issues as well [1]. This will also allow us to use writel_relaxed() in the
> kvm_riscv_vcpu_aia_imsic_inject() since raw_spin_unlock() will take
> care of draining the write buffer.

Totally agree, raw_spinlock_t will work here and will be cleaner.

> 
> I will post something along these lines.

Thanks!

> 
> [1] https://lore.kernel.org/r/20260925155116.465203-1-andrew.jones@oss.qualcomm.com

~ Oleksii
