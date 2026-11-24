Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795563022;
	b=Yzo12MnalNMc1CWYrPQqnQuB3uPMOUIBbBWT7jPlPoNMv+3/yFoO5idvJKUhDZFplMMj
	 GsQgEV1ODw74rddnwfMVK7+wrWe+Q6+uwrJkP3IScrwVlcbjr5IgYS7KpxIwepzl8k47t
	 gQ1caU4mGpQPC681L24Pea01fM4c3YPV+iDIfCZyUKN2Og3uE7BykShtRGpYICZFBBZ9m
	 Kb1/KBgL2sTDpoXHPt5KOkSGmqUVAWDmBEQt7O+NX1e8WdNEp7kgjvWGRYf6J+aNAh7vW
	 b2RVKQkxuKRxS+kGx4JZih0UJS4kM6IiFSdTmbtkpXFZ1JpNr0/Mdm2ok4vl439Xwfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tmoluJRxJ9HN+1c8Y5zGpOvMcLNPpYDSuvXeIRfQoGU=;
	b=3jfNvffpMsXjS2KhNR+KehJ4TloT3UVI/gs1uv977m2bVZHj53XlF1SYoThalo64RCUn
	 ErOBPOIG9Ye10N1qoMbVOcD7ZSb1o5xOxakerQWnDVulCFOAt+F8ruurCFexv2vhwpioW
	 j05opfcaSn+ImG+XIX1yERPPR2c05n58Eg6DHyd2CzwWsVH6gOvnZEL3VkU8wsIqv9JnC
	 NXauBpfqq4xJ1Sg9wBnLSX/+zxQz5SozlrsFQC1nCnjT1W7v5RUOkSl1SGBo+IkuB4KZ/
	 m1hciiznLW97H5PaIKL03HZje7tKjwY5uqIBoIBsyUORkuScDWz3ra6U1Y/Y2A+GB7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DHry630C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C830606A32A
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C830606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DHry630C
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-9215934a14cso26852746d6.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 15:30:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795563021; cv=none;
        d=google.com; s=arc-20260327;
        b=kWqJGZVgANpxEXNYMc12ChkMO3djB/3PB9wGzEMVtS0r9BL67WpauPk8dsLYDoxftM
         a+yWWTUlWo7b5ETvqwP8QocQDhEA/ddCsiDzgZc1f7eN9/G8KG7r6Tk/O8qcG/1wguhC
         IOal7mOquHT7N6DjXolvbaadTO84WKksR4X2iQzvVPx426qwIICBuGCDQR2z6hfcums6
         SiXI9zRo8ROK4ZhSR5pbJsW1DwFIAY8fQEetI8du7gDSRJ8EYEyFc3OkfqHn3k5rbLhQ
         botOdQt0WO89XLM56fsXOFQcuyb1ZWVJKCPyr4Q0AKqQHVuAoJ5HuiAaHcIWYzH1+H4N
         62Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=tmoluJRxJ9HN+1c8Y5zGpOvMcLNPpYDSuvXeIRfQoGU=;
        fh=GLbNY86NzXU7XZDuHPGuw2eoS20Iy5Bf7cT9x5CrvL8=;
        b=pQkcMw0WnjQrVqzVXQbRIl3KdX3OUWz++GR7RPaW+cccQ1UELRrzOvk330ebFTkGQy
         fO6cFXerhy4qJhAJO0/Tfg5H5moSx4pi68M1A7NcQkOILWu/P3Y1Fi/P61SeLWPTY05h
         5UL+PYj4qvHLWyJ0vEJYF+8YKRYeX8tWqDEjcw1vtqCz/caLCucxaL8CSo3kbBjQov1K
         ppXZgs+axYBqua9+OTCBBgPmF/4lNa/qQCRx0GRt5FXFpHwYbAz0WpJKghe582s+T0B/
         qmIEJwRuxb2Oh8f9cHwaVq20oSG25f9xg6X0XE2a2rxT6W1IMNIF8RTnCx88E1ETpfev
         8v7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795563021; x=1796167821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tmoluJRxJ9HN+1c8Y5zGpOvMcLNPpYDSuvXeIRfQoGU=;
        b=DHry630CFkgg7Meouug6MnkV4CymgbB1zgWtIxMwOqbS7dqL3FbBpc0WAEp8rJzaYl
         OHot43s9miXqu11twtgj/5ReI+PFrcF9ZgTENAqvnn5bRHKWGLtj45VhnnXSPnB8VdFV
         R8bn5vPaasIeYv1BsZXjEU4lXrU/5ChjGLNxkfk1QgZCIvro1vqcK4olj2Dn6afh3my8
         jbS6cM0tfdMyaAGnSpcs0XH6Q3z1kfDMKzMx7d0w8Vuv5ngYO9Wd0Ucq7f3Trk6zQP9Y
         PDbHbcEY1CpcScOYY32/evtDi+gAa7CMItg4HGnbAGf7oa5gMXkMR/76o4AIZFJ+lSGy
         Z/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795563021; x=1796167821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tmoluJRxJ9HN+1c8Y5zGpOvMcLNPpYDSuvXeIRfQoGU=;
        b=XLkoj+C/dXqVeLxo6ljN86j4glRDnRea1Yd/K6CFYKNbPWHMJ5+Y8ZPLK+vjSEegSo
         YgmFWyDxkex51ipJ2oRqlhC2gG//HeYfdRFe7HjGHWHg0B0RdTrqF6rRDieNTBB/DC1+
         qZsFNbVENYzeGkAIJ6CBIg+4fGKla3iCoEr7h+3d9BFwdodJgOzR7j1Qlu+NeEatVAYV
         n0NI0KwpZKK8qdoFee6CYGeGdrS6IGeoR5Lcqd3iCrsr2ITlpYPGGCr9MyDEczwRve0m
         HDCWZduZiyrv8N+CiW6yHU4Ff19xLEHyVuzNXEXrRelKgpyLuBABE3g8qzUWQghpTKvM
         r6xQ==
X-Forwarded-Encrypted: i=1; AL+hErHcVpxneY2hJJnEXkLtFnh+hg6vrCcefEO1j9IT68ObMEvwk93la2ECiLcZEgBB9RFXpQA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Jbk2EMhlWwf7c5uCc9+RbtrKWtN2nNMK+nvUht0SRTxTDoCfG
	LmSroFEjxs3n1VtuEgM86FE54zHiXUy9Wd3xO2g9ajm1xMBqBKCMB3UI3f/oOcSynkGY5UFtHWt
	voPL04d4LQbXC886HDMZp9k6Rvx7OEhJrBwTT/HNj
X-Gm-Gg: AZFdTZdSht2WNQBKWLEgDFlpXzAgj0Kx4YWN6++ZXVJf1PiSGKgveHPVoe+Z1aUMlWP
	Qh8qY6cHe4DcKWOFxJSpbbE3k499jTP2NmjFns2fny/7ZydNriHdToJCKeQXjgo2EB8zgqB2NHR
	nKImMOcDwPqgYp+Ojw06lFoiLZKpjVW5Cc64pMLx8VlMIUvFdMJrDMPBEi+gpb9Wus262z8Ctsm
	xrlRau3aIRNcGoLVQUdlmO2R32b+iA7cEgljcGyEEdAnfPNc20K4DH8VBpw6HW3CWJJY1cECjCi
	AOhrcWTOfS78lzwedx3DoLlsjvATxUKiG7f0eN6BpUh58ynAZ2f0q5dxHNzBdJdWM2Iy9NZWWvB
	JuFzznF7Pgs47sAx+r6KyfsGWhP9DiQXIXEwfBZKyx3leed146c1rZVqGmk15sch+xSuZ/98oDy
	DWYs++Hbi9G1lRtqZJEuDcgcw=
X-Received: by 2002:a0c:f412:0:b0:921:541:246b with SMTP id
 6a1803df08f44-92134a9123cmr301795036d6.38.1795563020302; Tue, 24 Nov 2026
 15:30:20 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 15:30:19 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <sashiko-outbox-229096@kernel.org>
References: <20261123104233.95710-1-steven.price@arm.com> <20261123104233.95710-2-steven.price@arm.com>
 <sashiko-outbox-229096@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 24 Nov 2026 15:30:19 -0800
X-Gm-Features: Aa3M54o433xbzGFqcKUYR3R8okBny6foO_6QsBRN_-OVy4JGrTMEGT43jesbap4
Message-ID: <CAEvNRgGU+z609edF+Mw8xQ0NDUDKn9jjxJjJWTyUqJ0N2BGEHQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] KVM: arm64: guest_memfd: Check mmap support when
 preparing memslot
To: sashiko-reviews@lists.linux.dev, Steven Price <steven.price@arm.com>, 
	kvm@vger.kernel.org, kvmarm@lists.linux.dev
Cc: Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] KVM: arm64: kvm_arch_prepare_memory_region() rejects non-mmap
>   guest_memfd
> --
>
> commit a0665f8dc612d05686ef019cc8462841573fe88c
> Author: Steven Price <steven.price@arm.com>
>
> KVM: arm64: guest_memfd: Check mmap support when preparing memslot
>
> This commit introduces kvm_gmem_slot_supports_mmap() and uses it in
> kvm_arch_prepare_memory_region() to require that all guest_memfd-backed
> memslots on arm64 come from files created with GUEST_MEMFD_FLAG_MMAP.
>
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index 1db10d8d6db73..2825fccd2a197 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -2839,10 +2839,10 @@ int kvm_arch_prepare_memory_region(struct kvm *k=
vm,
>>  		return -EFAULT;
>>
>>  	/*
>> -	 * Only support guest_memfd backed memslots with mappable memory, sinc=
e
>> -	 * there aren't any CoCo VMs that support only private memory on arm64=
.
>> +	 * All VMs need mappable guest_memfd memory, as the memslot's HVA may =
be
>> +	 * used to access shared memory even if guest faults use guest_memfd.
>>  	 */
>> -	if (kvm_slot_has_gmem(new) && !kvm_memslot_is_gmem_only(new))
>> +	if (kvm_slot_has_gmem(new) && !kvm_gmem_slot_supports_mmap(new))
>>  		return -EINVAL;
>>
>>  	/* guest_memfd is incompatible with MTE. */
>
> [Severity: Medium]
> As reported by Suzuki K Poulose on v2 [1], should
> kvm_arch_prepare_memory_region() drop this guest_memfd check altogether
> rather than rejecting memslots backed by a guest_memfd created without
> GUEST_MEMFD_FLAG_MMAP?
>
> Both gmem_abort() and realm_gmem_abort() fault in guest_memfd pages via
> kvm_gmem_get_pfn() without using new->userspace_addr, and
> kvm_arch_prepare_memory_region() does not verify that new->userspace_addr
> maps the guest_memfd or any valid VMA.  Requiring GUEST_MEMFD_FLAG_MMAP
> here fails KVM_SET_USER_MEMORY_REGION2 with -EINVAL for VMs (such as
> Realms) that bind private-only guest_memfd instances without allowing hos=
t
> userspace mmap, and on v3 the guest_memfd maintainer noted that this chec=
k
> is unnecessary and should be removed rather than exposing
> kvm_gmem_slot_supports_mmap().
>

I agree with Sashiko here. I traced the history of this check:

    if (kvm_slot_has_gmem(new) && !kvm_memslot_is_gmem_only(new))
        return -EINVAL;

In [1], Arm64 guest_memfd enablement, !kvm_memslot_is_gmem_only(new)
meant "this guest_memfd does not support mmap()". Arm64 had no CoCo
private-memory VMs yet, so guest_memfd was only usable for shared memory
where the host VMM needed mmap() to access guest RAM. Rejecting
non-mappable guest_memfd slots prevented unusable private-only memslots.

In [2], pKVM support was added. The v1 of [2], [3], says pKVM uses
anonymous memory. pKVM doesn't really specifically use gmem, so there's
actually no change, this check doesn't really affect pKVM.

Conversions [4] made stage 2 faults (mostly on x86), always get memory
from gmem. On arm, as long as it is a gmem memslot, it already always
got memory from gmem.

Now that ARM CCA supports private memory, we should drop this check
completely, I think David noted that right when it was added [5], and
that's what Sean means too [6].

If userspace sets up gmem with a memslot and doesn't set up mmap,
userspace probably won't be able to set up a running ARM CCA VM, but
that's userspace's bug imo.

Imo even back in [1] perhaps the check didn't need to be added, it's
just a userspace bug to try and set up a memslot with gmem that can't
really be used.

[1] https://lore.kernel.org/all/20250729225455.670324-21-seanjc@google.com/
[2] https://lore.kernel.org/all/20260330144841.26181-1-will@kernel.org/
[3] https://lore.kernel.org/all/20260105154939.11041-1-will@kernel.org/
[4] https://lore.kernel.org/all/20260910-gmem-inplace-conversion-v13-12-dd6=
fbf94f4e1@google.com/
[5] https://lore.kernel.org/all/2195c01b-3a17-46c5-a013-66922e8509bd@redhat=
.com/
[6] https://lore.kernel.org/all/av8No1rvJLXwciId@seanjc-mac.roam.internal/

> [1] https://lore.kernel.org/r/26a29420-8d27-4069-bbd5-28692c9e8542@arm.co=
m
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123104233.95=
710-1-steven.price@arm.com?part=3D1
