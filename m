Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627FE40DFCC
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738365; cv=none; b=MFQN8RqcbPpGz+kIAGtqnwksohT+wjB2Ip8YSwJQDmU3b/dWKLXKNU3CFCEJjyhyYzev8oV1NsVMOnwc9vvtZY4bOxtyo+RkoiI4GjvQrWL0ycGtj0mP5PD0L+rpEQipPxVhQJ2Ji/S2SZ7SmGdCLFumvIyTeRRvrixgB5Z3zZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738365; c=relaxed/simple;
	bh=UwUhPjfmMZI9iLFHnFNzoObxJb+TzTAtGkD9V574OcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6XeZ+ObWhsFYBL/3wr+mbDFf/OhlUAw2aCv/xm6e/WwuKSy4E3apW/NPaukDElWlSmKQ+/IkmG/NRqPEQ+rljaoszk890EXOgdfapOWFdfUt6LbGA0ZpmICbmzND/BrMhIrKVUilxDiyN3b37y35CwzKNZb/jU8MQgAlTr5+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7HN2ea1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7HN2ea1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F848C2BCB2
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 12:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775738365;
	bh=UwUhPjfmMZI9iLFHnFNzoObxJb+TzTAtGkD9V574OcI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l7HN2ea1MLuNdXDAht+TXgBfL7JSSUQEmfcGOnX8gRVN7H2Rh+jQEYfNYJ57f87ya
	 q6jFodHCNuQ1lF5QHCvQHkQaGFs1MBzcjvUkKuYk7zPTa2huB208s3x6PH6C0qHfMK
	 UtMqD2wkpTZ1Vx84FkQhLB/sinFahrhJ8P310DCOwAZBbgFjKU3nA3WVxG26cvVR9n
	 NBXFHfxA+VhNBvihiGKGRuiccUAmG1zF+8y3OUTmueoKYao823beba9it8qRJxY1iB
	 llJ2ogWlHc4FoYrRPPXMshQGEx9scdSKrLMf88WEQ9kmYnXBzsSLSErZaeXaOzvJQB
	 9RAr6BNUjuB3w==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9358bc9c50so117777666b.1
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 05:39:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWcdCB/nEpN68MOFokMnnz6XnYyVPrwm7k4pLVdd5jsBW+sklMgauugannG4wD16R/eSDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoAUMNY8VFKFcas23BY8wjFqZYey6Ka/RXEpVHa8VKJjzEKvRl
	U8YSRO+X+zQhWZNZxbbxa2OSMhEI5D2tj242131IFdgyPnqR/hbZrrz922PcInsmeXwN9msmwdr
	GJYKZhFqdqGScfs0g9i83jG41aqYIF2g=
X-Received: by 2002:a17:907:9496:b0:b9c:cdd7:c8a8 with SMTP id
 a640c23a62f3a-b9ccdd7c8b1mr830640066b.48.1775738363718; Thu, 09 Apr 2026
 05:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409024215.136932-1-gaosong@loongson.cn>
In-Reply-To: <20260409024215.136932-1-gaosong@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 9 Apr 2026 20:39:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7JcTV9aBChaYnR4irFt8O3C_9cOu_q4Krc6Q1c7Xwquw@mail.gmail.com>
X-Gm-Features: AQROBzDTnYABuAC0gEs8s3rtk0L7CCCibPKg-MVoYAIBuFH7Xuoc13TO2pNT7Bk
Message-ID: <CAAhV-H7JcTV9aBChaYnR4irFt8O3C_9cOu_q4Krc6Q1c7Xwquw@mail.gmail.com>
Subject: Re: [PATCH v10 0/2] LoongArch: KVM: Add DMSINTC support irqchip in kernel
To: Song Gao <gaosong@loongson.cn>
Cc: maobibo@loongson.cn, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kernel@xen0n.name, linux-kernel@vger.kernel.org, lixianglai@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied with small modifications, thanks.

Now all KVM patches for 7.1 are applied here:
https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.g=
it/log/?h=3Dloongarch-kvm

Please ensure that everything works well.


Huacai

On Thu, Apr 9, 2026 at 11:08=E2=80=AFAM Song Gao <gaosong@loongson.cn> wrot=
e:
>
> Hi,
>
> This series  implements the DMSINTC in-kernel irqchip device,
> enables irqfd to deliver MSI to DMSINTC, and supports injecting MSI inter=
rupts
> to the target vCPU.
> applied this series.  use netperf test.
> VM with one CPU and start netserver, host run netperf.
> disable dmsintc
> taskset 0x2f  netperf -H 192.168.122.204 -t UDP_RR  -l 36000
> Local /Remote
> Socket Size   Request  Resp.   Elapsed  Trans.
> Send   Recv   Size     Size    Time     Rate
> bytes  Bytes  bytes    bytes   secs.    per sec
>
> 212992 212992 1        1       36000.00   27107.36
>
> enable dmsintc
> Local /Remote
> Socket Size   Request  Resp.   Elapsed  Trans.
> Send   Recv   Size     Size    Time     Rate
> bytes  Bytes  bytes    bytes   secs.    per sec
>
> 212992 212992 1        1       36000.00   28831.14  (+6.3%)
>
> v10:
>   *Changed from v8;
>   *Rebase.
>
> v9:
>  *Correct the incorrect parameter type and remove the function prefix;
>  *Fix a boundary value check.
>
> v8:
>   *Move dmsintc_inject_irq(),dmsintc_deliver_msi_to_vcpu()and
> dmsintc_set_msi_irq to dmsintc.c.
>   *Rebase.
>
> v7:
>   *Rebase;
>   *Fix a typo error;
>   *Drop an extra space;
>   *Move some code from patch2 to patch1.
>   *Rename loongarch_dmsintc_inject_irq() to dmsintc_inject_irq() and move
> it to interrupt.c;
>   *Rename kvm_loongarch_deliver_msi_to_vcpu() to
> dmsintc_deliver_msi_to_vcpu() and move it to irqfd.c;
>   *Drop loongarch_set_msi() and dispatch the dmsintc/eiointc
> paths in pch_msi_set_irq().
>
> v6:
>   Fix kvm_device leak in kvm_dmsintc_destroy().
>
> v5:
>   Combine patch2 and patch3
>   Add check msgint feature when register DMSINT device.
>
> V4: Rebase and R-b;
>    replace DINTC to DMSINTC.
>
> V3: Fix kvm_arch_set_irq_inatomic() missing dmsintc set msi.(patch3)
>
> V2:
> https://patchew.org/linux/20251128091125.2720148-1-gaosong@loongson.cn/
>
> Thanks.
> Song Gao
>
>
> Song Gao (2):
>   LoongArch: KVM: Add DMSINTC device support
>   LoongArch: KVM: Add dmsintc inject msi to the dest vcpu
>
>  arch/loongarch/include/asm/kvm_dmsintc.h |  26 ++++
>  arch/loongarch/include/asm/kvm_host.h    |   3 +
>  arch/loongarch/include/asm/kvm_pch_pic.h |   4 +-
>  arch/loongarch/include/uapi/asm/kvm.h    |   4 +
>  arch/loongarch/kvm/Makefile              |   1 +
>  arch/loongarch/kvm/intc/dmsintc.c        | 190 +++++++++++++++++++++++
>  arch/loongarch/kvm/intc/pch_pic.c        |  15 +-
>  arch/loongarch/kvm/interrupt.c           |   2 +
>  arch/loongarch/kvm/irqfd.c               |  11 +-
>  arch/loongarch/kvm/main.c                |   6 +
>  include/uapi/linux/kvm.h                 |   2 +
>  11 files changed, 255 insertions(+), 9 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/kvm_dmsintc.h
>  create mode 100644 arch/loongarch/kvm/intc/dmsintc.c
>
> --
> 2.39.3
>
