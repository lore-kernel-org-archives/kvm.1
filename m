Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B303B4E85
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565243; cv=none; b=htlIXg+IY5NoCbFtbQWKKZZklCx0kJmyOFVU9zwPCOz9jpm/aJHWrrFFhA7ho2SUj+o0cloukGJoGHHLvK2toaQ+n+ITM3aNhwQq5Az1BbVTi2O4lVrICy8DWw103hd/zHG0jypJ7LV28jxSN9zJU/5m9xi9Jey8lyJKSFBU2p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565243; c=relaxed/simple;
	bh=VEMlzOGb1a/HxHduVMiUFvzh5xYiP4iFFkRq1PGdLTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EB4wQ9EcPzogegjbYDbqX3ogxXqixfhRdio+G2r4ZO8BOIOzU9fRtSia/EZ+8OPZmzIJRPxGxCwpF/BBEJD8QTEFa5xY/UXIJ2ZLWpkg+DLcUiHse52qOVRTCqejiw7HvLV8gpX59GnuxORha2zmVahc+Gz7MrLLVMOkNk9eV6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3/TpGYi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3/TpGYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86235C2BCB4
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 12:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775565243;
	bh=VEMlzOGb1a/HxHduVMiUFvzh5xYiP4iFFkRq1PGdLTQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k3/TpGYiFf5GCJGMwz7Vd7/GPmXqUSxHxdBYcSi+9pB4phmHA2uc8X+ODktOt2elm
	 CWPPeeafakspYSGJKyHFTIorSR6KR7bRV/7HkbIK/MXLfWSRMj9Hi2v4xofWnCKo3q
	 W/e5qKm8Sb8zLMpY0ZFnV3Bc22DaJYG+j199hfc6ybPk39BneK6XixcJa4gvUBAd7x
	 RH6teZjoEA93Xzkq6A/cmJq6HNSTapWWpCyiI3hSojbSAsorl7d5mQcySYp5Fbg51x
	 axnlMoLN4WaZKLfJxLb4qjMWgI3WCgdeT697FDbyb7+rF/t5UvG+iDU5eg/Ur2wh/j
	 n2vXlb+/uFIbQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66d24c6963bso8866484a12.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 05:34:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVyk16Ld1bQyvzgdMAbT48H3Ip65tDX9NTJbkMlURlXt/iAPzmMlsVvoGpLwA593wA/ILU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqrXUmsCYP86M3ZpvYM9VelVItX5NCcEr9OaPgEJzjUx2h7g8D
	dZsdXOu2o/mW2LseCgdvTKbJPfIG9sC2Gu4HUEFvrCbgKX4k1RBNamsL7XtwTMwzuy8DTWWTw4S
	ORjbPL/eryjhr2ZiFlVKaosJnIXWzpS8=
X-Received: by 2002:a17:907:2d08:b0:b9c:bc08:7a9a with SMTP id
 a640c23a62f3a-b9cbc087b43mr467336366b.10.1775565242030; Tue, 07 Apr 2026
 05:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402124237.4174550-1-gaosong@loongson.cn>
In-Reply-To: <20260402124237.4174550-1-gaosong@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 7 Apr 2026 20:34:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7K8ayLGFMhPwp8uqr3JHdpL1dWOvo2zuVj_3fB2CWPeA@mail.gmail.com>
X-Gm-Features: AQROBzCDTq69_5d4U4HXwKjMWiUAKrYN4_1kN5HH5qhNbW4mJm1Ti6IjNhRyEMQ
Message-ID: <CAAhV-H7K8ayLGFMhPwp8uqr3JHdpL1dWOvo2zuVj_3fB2CWPeA@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] LoongArch: KVM: Add DMSINTC support irqchip in kernel
To: Song Gao <gaosong@loongson.cn>
Cc: maobibo@loongson.cn, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kernel@xen0n.name, linux-kernel@vger.kernel.org, lixianglai@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Song,

On Thu, Apr 2, 2026 at 9:08=E2=80=AFPM Song Gao <gaosong@loongson.cn> wrote=
:
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
> v9:
>  *Correct the incorrect parameter type and remove the function prefix;
>  *Fix a boundary value check.
It seems your V9 is changed from V7 rather than V8, why?

Huacai

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
>  arch/loongarch/include/asm/kvm_dmsintc.h |  23 +++++
>  arch/loongarch/include/asm/kvm_host.h    |   3 +
>  arch/loongarch/include/asm/kvm_pch_pic.h |   4 +-
>  arch/loongarch/include/uapi/asm/kvm.h    |   4 +
>  arch/loongarch/kvm/Makefile              |   1 +
>  arch/loongarch/kvm/intc/dmsintc.c        | 117 +++++++++++++++++++++++
>  arch/loongarch/kvm/intc/pch_pic.c        |  15 ++-
>  arch/loongarch/kvm/interrupt.c           |  37 +++++++
>  arch/loongarch/kvm/irqfd.c               |  48 ++++++++--
>  arch/loongarch/kvm/main.c                |   6 ++
>  include/uapi/linux/kvm.h                 |   2 +
>  11 files changed, 251 insertions(+), 9 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/kvm_dmsintc.h
>  create mode 100644 arch/loongarch/kvm/intc/dmsintc.c
>
> --
> 2.39.3
>
