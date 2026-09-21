Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A72C47A0C2
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987205; cv=pass; b=SWkGpCRJQM2R8LNoeWqvENUxmOIFseLUfKgYwiFC6RpBuZhtYSvdp0hRt7F5q/CfNsY20uVGg00rRXmN94B3dAirLb8UmWC8olqPY0muG/RiN0Y8VyS7D8y91RUv3G6F/nCETnuIaV78Ccl9vjrUeFPYIm0QfVEL9lPWHpVMg08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987205; c=relaxed/simple;
	bh=hSJ57tN1U326keFM8PH3Y1VeMZ0Trn/0Q/pwnfxuOS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbRYLJgrNCg7UiLP7Y5LfzQLzuVpLxNWKg/fEf6gX1SVvPznDZtEf+FNabsFo7YRm0v4gyGR4FMwhA7tXyX71E0KJYuIKlfzp5Yq/nYwVuKp1K0sYUguHlvK/Il1+9H9gZtStRHUfRnD835aQVZaGoT8R51fRJBXv/cgE4ITfSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EeKVWMFk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2BBNVrJ; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeKVWMFk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2BBNVrJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789987201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lg6lUtI5rOYqzjiYwf3NjDcPU/fuxjGZBEmVSz69a4U=;
	b=EeKVWMFkG7evDnzor9tnjhvuPihSL0V+gqbrx2L9NC69hFPP9c3Y9PBF9IpM2++rHEjXGJ
	jaQR/Vhiu38hrg7YDmCHa0KN5sF+/UbWJLZ0UPMtPYv6+9lkzoFTMQe4TRIpeIyPBWdsUs
	3W3pnkQ2lSRqMVRfkjFTY0pn//w0YAc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-2kvuf6XfMdmr-OIgJuDTjQ-1; Mon, 21 Sep 2026 06:40:00 -0400
X-MC-Unique: 2kvuf6XfMdmr-OIgJuDTjQ-1
X-Mimecast-MFC-AGG-ID: 2kvuf6XfMdmr-OIgJuDTjQ_1789987199
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-486f3dbf7d2so2313104f8f.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 03:40:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789987199; cv=none;
        d=google.com; s=arc-20260327;
        b=gCB6X9y1TrihzEzmZ3rfxkRXikvRuEDQW9Ff8dsbTiBMt56yvhMv/zY4qY95+YvObS
         o9XbGqg1Lp1mWWs8+xkpiOmViD/f8i8NqyOs0ZkhlfWVZAvJkeIkK5KNHLQoz1yf6GPf
         DwNK3Iy0ERfksnOmFv3Z/UlZZyYn2B823SBtqWLKSDX85LAvFs/myEzvK2vb9NyVM+O1
         pRxeMlNFkBLK8SkL0eN4Tlhg9OBRztpLn245RhqkuKWjU+HBgXj/U3oPfgY3Qgg2axv4
         0dJl9kJmb5HT6FsSQyIsmUGLJ9ILXkT/LvHVDf8kNP6R28c/Q8gJ6w0WyLKycMh65mt0
         8jUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lg6lUtI5rOYqzjiYwf3NjDcPU/fuxjGZBEmVSz69a4U=;
        fh=vwAbE7zu0nTN4HG8NGWuMM5Ax4iH+dpcjwUQ3zMq/eo=;
        b=TqUznR4CgOMg8S/tKq2DDx4Lu+eRW5vd/eR3aUjVAyUuZledxohT4kiAND8OoRzv+R
         XlW9QIv3pSZdZhKItmwlFGQb/hyIXr+9Ma7UDG1Lpk8dV5xEQhM6IEzz26I/hYQbqKwO
         U2RL1OXY5fqYsKPE5zlIqBLsmS7x9rvnOKLvMEAg5NtlEnWSAhbIilTWRy1rZtDZOR42
         N47tjdnXKKSSiJDOksVegnwXnGn5KORg1wUQAijEhZ05occu63CFVM8cH0/QzAhFIWnw
         NajVgKtWQPbiC0jGTPmWYezBAGEoES0Hp4BzIhlklyPWbB+lQb4pJVbAhhA4k5SzJQDw
         hOjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789987199; x=1790591999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lg6lUtI5rOYqzjiYwf3NjDcPU/fuxjGZBEmVSz69a4U=;
        b=J2BBNVrJqwV0VSsKVg8Z+i/H2kiGVz32YAr/C7hL6Ui3S8F0XkfxYOQ7dFthJ5tSAg
         vBEgyRU7DN7rhIjiqfW8qUJw7wUn80p5hvUyYvfEQ7gCRrUXbDiT3B7AjCqem2zOtAjW
         AptJAPWXoWjgN7m5uWI2pS82CY8FB8f4fJBEjbrn1lCiV3ERShIDC4LoYDl7zqtddRjU
         O91tgCXBQR1VmANyuRXzEtpM6Ge9lTeDE1EmfinQHsqO2viMdw27qYcawNxBtg7W2EgJ
         ue7G5C2btFjHkAPlEjZNDhMjxVW8jrGKmxwSzCBgzfy/tT/19QcnL2uPXHiqTOuTjroC
         URUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789987199; x=1790591999;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lg6lUtI5rOYqzjiYwf3NjDcPU/fuxjGZBEmVSz69a4U=;
        b=2y57R2RbPmY0/wwFIW/JO4jk52nWYaAjscV1n2mhGrvW2jfo1DTfN8kIAuL22cyXKq
         RpkBmeqhc4yG51g+4FTM6nkJCk+Ph1wj1zp62IRvN44C6xVkPpd37U4RdZ+WD10SLuXk
         mGGp54oj1QKCLR+VTTXbQxGHwqSK7DhDhlKzXNsVYAAH28YzxedHBYMQlbx2/HvTxhgn
         nGLpTtQIOL1DmfvelqoyNmTxoVQ+toL6SkctgSfxzZRLu//SLxuZjKHsEA2sdbkFV6YW
         QrVpsAdPs6B2Y7XJbl7ack8GkQQ8Kn0jcoCL+6K3iuEJDxHhRdcWVnZ4ojGqTHX+6vnC
         foDQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPxEEm6uFKYjj5N7We+2McRocXf5Wc7biwkU1hzxwLXjWdy4rFDnRSc3VAwM6d5JokegE=@vger.kernel.org
X-Gm-Message-State: AFuF++lmgOnla8M902uHvBTPeLmQsrhtyKSLOgg2ivYlrKvuToudw17V
	R6ADC130WqNibxscDpANyNXyfMSDYBqgN8WBfSvBlbbpXR12eeHg1xbPY76IeZ5YNhb0dXlvcSH
	cw4Wu3EQDy4J6hAR2NYBcvooFMbk6uBVlhrNmludhoVu0v+u9cSgXkXH1nr8Y/WbdvAk5NoimGN
	pzMLlWtHqJKLldJA5hN7gNrZqBV0+l
X-Gm-Gg: AYBFou0nOqKRWR4e8sLkrpLJfbpk68e35wEPEGkw3NoC7Jbl8fe1g3QCOLqGBtCwoKU
	qNV0dFvDfJqWgDIrRgvrIIc69rpaapy3JfRuL8l75Ja5cARX3kZ0EPxQNNdLKr62jO9YUXO4XoI
	RFFb7ZDNTES866JqjGgrIa42gKDjM+cbWH6Xb7cPR4m2Moj81m/xfTx6jI0VK/YnF9H47VvHBzl
	vFkiokGQRGTVFJN0pGZKcf8c+Y5v5IBJ/ZEl24waeVaTnHG/1gV+IfoSaFBGQ==
X-Received: by 2002:a05:6000:2c0b:b0:487:6f0:8658 with SMTP id ffacd0b85a97d-4871e36d031mr14452303f8f.42.1789987198935;
        Mon, 21 Sep 2026 03:39:58 -0700 (PDT)
X-Received: by 2002:a05:6000:2c0b:b0:487:6f0:8658 with SMTP id
 ffacd0b85a97d-4871e36d031mr14452275f8f.42.1789987198577; Mon, 21 Sep 2026
 03:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhSdy2MbSq2eGDZfh_EKt2S3OUEn7tJRWUgvncPsWNVR7vqeg@mail.gmail.com>
In-Reply-To: <CAAhSdy2MbSq2eGDZfh_EKt2S3OUEn7tJRWUgvncPsWNVR7vqeg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Sep 2026 12:39:46 +0200
X-Gm-Features: AcwNN1WJeaIYC81GTiQRJhjTHz-vJsYLRzgjmQPP8T2_2LmCGnbvuvv6NPrHA80
Message-ID: <CABgObfbL5QM0T-r1FxNsx_PEZwemk_ibALL60FdiTgpT5hX4bA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/riscv fixes for 7.3 take #1
To: Anup Patel <anup@brainfault.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	KVM General <kvm@vger.kernel.org>, 
	"KVM RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 10:25=E2=80=AFAM Anup Patel <anup@brainfault.org> w=
rote:
>
> Hi Paolo,
>
> We have the following fixes for the 7.3 kernel:
> 1) Synchronize hrtimer during VCPU teardown
> 2) Fix the conversion between vsip and hvip values
> 3) Serialize IMSIC attributes with vCPU migration
> 4) Release unused page after MMU invalidation
> 5) Propagate interrupted G-stage faults to KVM user-space
> 6) Fix NACL hfence entry update order
> 7) Fix sdata leak and stale snapshot_addr in PMU snapshot_set_shmem
> 8) Preserve firmware counter value across PMU counter stop/start
> 9) Report PMU snapshot write failure to the guest
> 10) Fix perf-backed counter accounting across PMU stop and read
> 11) Fix HSM hart status error propagation
>
> As you can see, the fixes are all over the place except quite
> few of them (4 fixes) focus only on SBI PMU extension.
>
> Please pull.

Pulled, thanks.

Paolo

> Regards,
> Anup
>
> The following changes since commit fd73f4a6659897191fa0d40695fe370925dd37=
80:
>
>   Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-riscv/linux.git tags/kvm-riscv-fixes-7.3-1
>
> for you to fetch changes up to 41e81f7e3ef96594fb840445343c0ee7723aa550:
>
>   RISC-V: KVM: Fix HSM hart status error propagation (2026-09-15 18:55:51=
 +0530)
>
> ----------------------------------------------------------------
> KVM/riscv fixes for 7.3, take #1
>
> - Synchronize hrtimer during VCPU teardown
> - Fix the conversion between vsip and hvip values
> - Serialize IMSIC attributes with vCPU migration
> - Release unused page after MMU invalidation
> - Propagate interrupted G-stage faults to KVM user-space
> - Fix NACL hfence entry update order
> - Fix sdata leak and stale snapshot_addr in snapshot_set_shmem
> - Preserve firmware counter value across PMU counter stop/start
> - Report PMU snapshot write failure to the guest
> - Fix perf-backed counter accounting across PMU stop and read
> - Fix HSM hart status error propagation
>
> ----------------------------------------------------------------
> Myeonghun Pak (1):
>       RISC-V: KVM: Synchronize hrtimer callback during teardown
>
> SeungJu Cheon (3):
>       RISC-V: KVM: Preserve firmware counter value across stop/start
>       RISC-V: KVM: Report snapshot write failure to the guest
>       RISC-V: KVM: Fix perf-backed counter accounting across stop and rea=
d
>
> Tan Chi (1):
>       RISC-V: KVM: Fix HSM hart status error propagation
>
> Xie Bo (3):
>       RISC-V: KVM: Serialize IMSIC attributes with vCPU migration
>       RISC-V: KVM: Release unused page after MMU invalidation
>       RISC-V: KVM: Propagate interrupted G-stage faults
>
> Yicong Yang (1):
>       RISC-V: KVM: Fix the conversion between vsip and hvip
>
> Zongmin Zhou (2):
>       KVM: riscv: Fix NACL hfence entry update order
>       RISC-V: KVM: Fix sdata leak and stale snapshot_addr in snapshot_set=
_shmem
>
>  arch/riscv/include/asm/csr.h       | 20 +++++++++++++++----
>  arch/riscv/kvm/aia_imsic.c         | 11 ++++++++--
>  arch/riscv/kvm/mmu.c               | 10 ++++++++--
>  arch/riscv/kvm/nacl.c              | 20 +++++++++++++++----
>  arch/riscv/kvm/vcpu.c              |  3 +--
>  arch/riscv/kvm/vcpu_exit.c         |  2 +-
>  arch/riscv/kvm/vcpu_onereg.c       |  8 +++-----
>  arch/riscv/kvm/vcpu_pmu.c          | 41 +++++++++++++++++++++++---------=
------
>  arch/riscv/kvm/vcpu_sbi_hsm.c      |  4 ++--
>  arch/riscv/kvm/vcpu_timer.c        |  5 ++++-
>  tools/arch/riscv/include/asm/csr.h | 20 +++++++++++++++----
>  11 files changed, 101 insertions(+), 43 deletions(-)
>

