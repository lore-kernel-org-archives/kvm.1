Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794593981;
	b=a13/t7YRKnbEJNC3gsglV0sipNKTIDR5ruC0Lq//8pm3pwc7OsKeHr39j1sMKO0g/Oos
	 Vz3RNmCaRPHWCxCYpGoB5osAkToHENmZSSocqvgLcSqg1xuzFZHNRlGHjZONwAnZdJIUX
	 YLVpVNlMJ44hH0XW5l1wh5syMM8A06KsSFv//GIQu5/mqEQVccY/EXdhkc873Hkx4vaeR
	 UaXoSz/XTX5j87ETMu+BN6uMuopKeYSGR+kffud9rzgvyD5JAt3bHALdXMtvWW8+ZhXZL
	 OfLScXVDcbeDbxnrqWzJpr/6TP9Fl9Czh7HZHsUC1lvABPHt9ClBMqbVgl49Aya8ONQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794593981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CENXtX1/W/MRp/DcAqbUbrZhUcyfT59CNNpcWDlZbsw=;
	b=nK7YaQY3P7JhoETggW7bZTpqMx0zXYdwRFAwpWyuR4DwLezX89Cfp/g/uksW9V/1PXMw
	 8yjlUgdAn6oeCFqRo53Y0U010S3a7r12UukDeB+pVGLzWuEbNjQ5Ae+FOD7t539Fcv9a7
	 lxWw0pswn027mPj4Ozfj+pglLj98572+N4zouulopJL2sVb+votRYkMSQjrHCo0MR/WWX
	 fS+4/skuhTKATbjYK9SiQBoVFDjLrOa+VR2BrjqXI4c5jpRreuOryMSgeqb3iN90I16uh
	 3N91cvhhywbVL8yomrkQrwNbiNdvgpaDAm7QgrILdjfKgyj9UILLUrvftL2aKffSqvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZBWNIUpT;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE41606A332
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 18:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FE41606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZBWNIUpT
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so22329225e9.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 10:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794593978; x=1795198778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CENXtX1/W/MRp/DcAqbUbrZhUcyfT59CNNpcWDlZbsw=;
        b=ZBWNIUpTzZN2uRy2q5KN3dzd4ycS0bX6OSapit7Dfuzls/o9BmSymtEAwV7D27WPTE
         hs2DUXs+VCbAkp8mweL3beZ0hwRFeg6YdlQ3qPGHYJZysT0eKtlw8Hqab+1yn94ijLx2
         L4jPimLmXFBPMhCSww94GpHH+C0XH4lY+Eeiajw9FWKnBPIzjFYP+yjyLxRSDfrN+lTR
         b7mAaD4WZ5Xun2QqTd8mkpXF8/f6k2en5DCF+g2y77HKoyldTdiei7mNxJiwSdi3TLvC
         TuohG4BTazDqiA7sQRueapEuMgTSes3gDb8c566mbYEbzV/i8BXGidgSzYRUbwJR90mn
         xTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794593978; x=1795198778;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CENXtX1/W/MRp/DcAqbUbrZhUcyfT59CNNpcWDlZbsw=;
        b=ExjZs3qzoIu4HQT2eKyoSKJnlfkLNpgNQGyDJW7d0L+DhG59rKVwjoevWMZ+HjdKjb
         vypHkJI/Hxx+rTbBDXAtu21QlLgJ7oR2G2aDXqX6TM0kgZY6XjbUiaBwY6dxTQmqW3CW
         7kDDeled3tpREoOV2BK6TQneBbECu0BA4nbFeHyiDD//Ypt4TpXnLGenv/lKiY39+LOH
         9BScKxbsFPM5P2w/stx+3UcPkVWU6qABVKBbRtTPaj+iY2bgbhF46SLer44GrhdndT39
         /MFHdakj5dpuLDooBqxV+A91WuHgzJPlB9FI+ziyPY/rAbFiPjwOpmXtU8PNDs5a7b0C
         cCgg==
X-Forwarded-Encrypted: i=1; AL+hErHnGs8+YUt2AbgWOpwD1FKLz1Zm4GeAI4w+wQkjoO/aCqs+b4HdyQhS5Jis0JDPr5n79YI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+51hR9GuslnFn6mI5u/Ll3xRPceN36ENjEkEAmJh/397XRmNhu
	ofmisHk1Nk66Emh6Yg2YiV5rBnm5nrxLoIFz1B90x0tNeM2MlueEsNlD
X-Gm-Gg: AYBFou3i65NKAJiPfqubIv2fuU6AXoWjgII01Lf4B+4JQ99Es+PWW18l60zAxYF2x51
	mGEd//hsCM/Xhl7VaRjPwHI78g7Mosmxpm+A/noN+K9OVipe7zTkMpgmzaKMZ/jC/6b2/lZCgeX
	nM62NDN6MEJSTjBuXiryjChSX7ftJH7y8Eur/ezvQk1q+Zn05wTWE00VMWKf/kdetus06ADbHgS
	ghfqLzrZ3pkVAQIiMhiS3glIA1483qNQxCCPO3Tcm9b5asje/r6Qq5IMXdJjpNWsnrecbU/bPQn
	PpZGnSvqQSnxADHz9PwrP5voxxB8JGldfbrceiZV6war5l5Qz0hNJHh4GtPAXXOyxrvZRAF66bC
	FsWur4gzFyknC9bPYzfeaAndwR35sf+owPPzgzg/QIPTcLiBYr1yc+yQrt3JoIVIOYvN+eMU4UV
	dk5a24PqdgZh6FYf9xQeUfGmJ4LCp1lWsMD9AAPhGUdv9zJhpcY0z5AFRh53r0v+Qmf81t9P7S0
	mO1Zi6eVmQPzHh8yDvO+1Xta0SjPnSYI+IwwcMdRZlK2RGWUzL7UL5EZ6N9et1UHuTThtKyP76+
	2E8AMO743FlkXnujYtUwQSV0xVrpzFzOKhlmBch4khm7XKK7iLSk02FSt1y3zx3HdogKS0iV7qR
	irg==
X-Received: by 2002:a05:600c:34d0:b0:4a2:133:45e1 with SMTP id 5b1f17b1804b1-4bb55a59f41mr72807635e9.24.1794593978271;
        Fri, 13 Nov 2026 10:19:38 -0800 (PST)
Received: from [192.168.1.6] (user-109-243-65-71.play-internet.pl. [109.243.65.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5667a8aesm54253275e9.1.2026.11.13.10.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 10:19:37 -0800 (PST)
Message-ID: <7e634bef-6d23-4a57-b3e6-b5585045ca19@gmail.com>
Date: Fri, 13 Nov 2026 19:19:36 +0100
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
To: Anup Patel <anup.patel@oss.qualcomm.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261023142550.148604-1-oleksii.kurochko@gmail.com>
 <CABBgwmuBBbyBytwRBTeAqF=0c1m+TFK8E3yPopGNQAsrMFO2vg@mail.gmail.com>
Content-Language: en-US
From: Oleksii Kurochko <oleksii.kurochko@gmail.com>
In-Reply-To: <CABBgwmuBBbyBytwRBTeAqF=0c1m+TFK8E3yPopGNQAsrMFO2vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/13/26 9:00 AM, Anup Patel wrote:
> On Fri, Oct 23, 2026 at 7:56 PM Oleksii Kurochko
> <oleksii.kurochko@gmail.com> wrote:
>>
>> kvm_riscv_vcpu_aia_imsic_inject() writes the interrupt identity to the
>> SETIPNUM register of the vCPU's IMSIC VS-file while holding vsfile_lock
>> for reading. The lock keeps the VS-file from being switched under the
>> injector: kvm_riscv_vcpu_aia_imsic_update() and
>> kvm_riscv_vcpu_aia_imsic_release() take it for writing to move the vCPU
>> to a new VS-file or to the SW-file, then read and clear the old VS-file
>> and free its HGEI line.
>>
>> On RISC-V, writel() is followed only by mmiowb_set_pending(). The
>> trailing "fence o,w" is deferred to spin_unlock() by the mmiowb()
>> tracking, and rwlocks don't take part in that tracking:
>> queued_read_unlock() issues just "fence rw,w" before the AMO, which
>> doesn't order device output. So the SETIPNUM write can still be in
>> flight after another hart has observed vsfile_lock being released. If
>> the old VS-file is read and cleared before the write lands, the
>> interrupt is lost. If the HGEI line has already been handed out
>> again, the interrupt ends up in another vCPU's VS-file.
>>
>> Add an explicit RISCV_FENCE(o, w) after the write to the VS-file, which
>> is what spin_unlock() would issue via mmiowb().
>>
>> Fixes: db8b7e97d613 ("RISC-V: KVM: Add in-kernel virtualization of AIA IMSIC")
>> Signed-off-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
>> ---
>> Why RISCV_FENCE(o, w) and not mmiowb():
>>
>> - Since the mmiowb() rework in v5.2 (e.g. commit 60ca1e5a200c
>>    ("mmiowb: Hook up mmiowb helpers to spinlocks and generic I/O
>>    accessors")), mmiowb() is an implementation detail of the spinlock
>>    code. Explicit invocations were removed from drivers by commit
>>    fb24ea52f78e ("drivers: Remove explicit invocations of mmiowb()") and
>>    from the documentation by commit 915530396c78 ("Documentation: Kill
>>    all references to mmiowb()"), so adding a new direct caller would go
>>    against that.
>>
>> - RISCV_FENCE(o, w) states exactly the ordering needed here (device
>>    output before the store that releases the lock), which is fine for
>>    arch-specific code, and it is the same instruction mmiowb() expands to
>>    on RISC-V. wmb() ("fence ow,ow") would also work but is stronger than
>>    required.
>>
>> Scope: this only orders the write before the lock release. Whether a
>> write that is already in global memory order is guaranteed to have
>> taken effect in the old VS-file before kvm_riscv_vcpu_aia_imsic_update()
>> or kvm_riscv_vcpu_aia_imsic_release() reads and clears it is a separate
>> question, see https://github.com/riscv/riscv-aia/issues/172. If it
>> isn't, these paths will also need to drain the old VS-file, and such a
>> drain depends on the ordering added here.
>> ---
>>   arch/riscv/kvm/aia_imsic.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
>> index f17dc559a709..807bb73a129a 100644
>> --- a/arch/riscv/kvm/aia_imsic.c
>> +++ b/arch/riscv/kvm/aia_imsic.c
>> @@ -1056,6 +1056,13 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vcpu,
>>
>>          if (imsic->vsfile_cpu >= 0) {
>>                  writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
>> +               /*
>> +                * rwlocks don't participate in mmiowb() tracking, so order
>> +                * the write to the VS-file before releasing vsfile_lock,
>> +                * i.e. before the vCPU can be moved off this VS-file and
>> +                * the VS-file read and cleared.
>> +                */
>> +               RISCV_FENCE(o, w);
> 
> Another fence after every writel() is a big hammer in the path.
> 
> If the intention is to have correct contents when VS-file is read then
> better place to add a fence is at the start of imsic_vsfile_local_read().
Thanks for the review.

I don't think a fence in imsic_vsfile_local_read() helps here. The
problem is on the writer's side, and imsic_vsfile_local_read() runs on
a different hart.

The SETIPNUM write is done by whichever hart calls
kvm_riscv_vcpu_aia_imsic_inject(), which can be any CPU (irqfd,
ioctl, ...). imsic_vsfile_local_read() runs on the old vsfile_cpu, via
the IPI from imsic_vsfile_read(). A fence only orders the accesses of
the hart that executes it, so a fence on the reading hart can't make
another hart's MMIO store land.

Without the fence, this can happen:

   hart A (inject)            hart B (update/release)    hart C (old 
vsfile_cpu)
   read_lock()
   writel(SETIPNUM)
     (store still in flight)
   read_unlock()
                              write_lock()
                              switch VS-file
                              write_unlock()
                              IPI ------------------->
                                                        fence  <-proposed
                                                        read+clear VSfile
                              free HGEI
   SETIPNUM lands: the interrupt
   is lost, or ends up in another
   vCPU's VS-file if the HGEI was
   already reused

Hart A's unlock can become visible before its SETIPNUM write has
reached the IMSIC, because read_unlock() doesn't order device output.
Nothing that hart B or hart C does afterwards can wait for that write.
Only hart A can hold back its unlock until the write is ordered, and
that is what the fence o,w after writel() does.

With the fence:

   hart A (inject)            hart B (update/release)    hart C (old 
vsfile_cpu)
   read_lock()
   writel(SETIPNUM)
   fence o,w
   read_unlock()
                              write_lock()
                              switch VS-file
                              write_unlock()
                              IPI ------------------->
                                                       read+clear VS-file
                              free HGEI

The SETIPNUM write is now ordered before the unlock, so it is also
ordered before everything hart B does after taking the lock, and,
through the IPI, before hart C reads the old VS-file. It can no longer
arrive after the read or after the HGEI is freed.

About the cost: this is the same fence that every writel() under a
spinlock already gets. On RISC-V, writel() only sets mmiowb pending and
spin_unlock() then issues "fence o,w". We need it explicitly here only
because vsfile_lock is an rwlock. It runs once per injected MSI, and
only when the vCPU has a VS-file.

The only way I see to keep it out of the inject path is for
update/release to IPI every CPU that might be injecting and run
"fence o,w" there before the old VS-file is read. That is much heavier
and moves the cost to vCPU migration, so I'd rather keep the fence in
inject. Let me know if you'd still prefer the other way.

One more thing, not directly connected to this patch: could you please
also take a look at https://github.com/riscv/riscv-aia/issues/172?
The fence makes sure that the SETIPNUM write is ordered before hart C
reads the old VS-file, but hart C reads it through CSRs
(vsiselect/vsireg), not through memory. As far as I can tell, the spec
doesn't say whether a write that is already in global memory order is
guaranteed to be visible in eip at that point. If it isn't,
update/release will also need to drain the old VS-file before reading
it. Such a drain would build on this fence rather than replace it, since
it only works if the write is ordered before the unlock.

~ Oleksii
