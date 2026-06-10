Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4381E2BCF46
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 03:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781061492; cv=none; b=J1vqgQJ4kZKzhzHJl95eA34nXL7eMmHTvhnOvCG9uHgNvWeJsYByywAVZscOAHmGG3x0mrm2FHDzusgpHkNb4A65ibQtSsGTzjNXrFqxQWxbb2f5J32VYU74j9HtkbtsuzVy81VAQp3jzPkHsayH8syKKFgIRU0LfusWM19Znr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781061492; c=relaxed/simple;
	bh=hl7seAN7FAeAknkeaOkMZMH/DKFvK5ydQO7UdcfJZXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0mwLl7qusPdfLKVVkZRxDhjw9g3oVGEpijNzPyr1IuepITYoDTlHld2PEk1qViZFzEocaasiL/qXQnfgneqFXhJ75KQT6DHYn7ajgOZLHim5NegpZ2PRymhIm3RPIlT5mM/0DFgeYTR+iMClDdWyXyZaHzh1m7ZTa2QygbIsWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxoTk+Wt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxoTk+Wt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4EE1F0089A
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 03:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781061490;
	bh=rYEOyf8S2GNd7k/qbqeSQ56NQg1v22wqgzWlZA54PBg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PxoTk+Wt1xw7Vc7FCdyhpdOIHsoffwP2S1tGTw0lMOuF1gQJcEfdg5ttTxDy5BcS2
	 0WuNxM1SoKKcIMoI3kT/GAd0Endwia+JzBB643dHwT+9mmIIMoP0G4n2IdEPEHlnEU
	 WqNL6PSIMzo+11zsOsSRX7E0U0rkeIy9rqrHvj3K8MMb8pgXqrxwMNx4uv7yd+vcd2
	 4tsojouhjzWSDQaJZw4apMLD3Yd66pIfkSTKOpf5zPXz38zY81OGi+EB4l/tql7OWq
	 yBL22YMa/Exd0uDE2rj1DRCpJtuxE9F7hPhLIkxP03ykUbd+uIkFp4/Cof6CP1GpA0
	 uUMlwxkd8IOxA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68d232ed3f9so10540008a12.0
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 20:18:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/5Q+8f7YtFdoQD0IJndSYpp0kkwnngDZ91emu9lh9SULjunoWtx4qaZ+aQPng0CoOgaI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxBDQ8Wu59Kv/fnxgY9xblQWlyDDLCP3RbfJbL6xwOAh1b9G6d
	xdrcIKWtxtC+pcpGAGWcFxXLCHxJ8jNooxcZAGimNL2kDLefiZ0sSCj0sgD7H57Ets1Tff3Y1y6
	0TCnCUGRYmez6OABFggUqEKLxx7rVVU4=
X-Received: by 2002:a05:6402:5519:b0:691:7054:8c6a with SMTP id
 4fb4d7f45d1cf-69170548d49mr7300002a12.20.1781061489578; Tue, 09 Jun 2026
 20:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608013222.375257-1-maobibo@loongson.cn>
In-Reply-To: <20260608013222.375257-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 10 Jun 2026 11:17:57 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5mZMciE5YY8MA-OW5+CTzjp+qsPDkHHuEdwO+3xFiWJw@mail.gmail.com>
X-Gm-Features: AVVi8Cf-r8ZZ0hYGCUbHisWqv0SrYRZnMLYzqCj6eomKOSfZmvJutaV1znFw0Gk
Message-ID: <CAAhV-H5mZMciE5YY8MA-OW5+CTzjp+qsPDkHHuEdwO+3xFiWJw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] LoongArch: KVM: Set max VM supported FPU type with
 FPU exception
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Mon, Jun 8, 2026 at 9:32=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
> With FPU save and restore, the cost is the same with different FPU width
> 8/16/32 bytes, whatever from CPU cycle and cache line impaction.
>
> Here is to enable FPU with max VM supported type, for example if
> VM supports LASX instrction, enable FPU with LASX type with all FPU
> exceptions including FPU/LSX/LASX exception. So if LASX is enabled with
> FPU exception, it can avoid potential LSX/LASX exception in future.
>
> With context switch microbench which touches FPU and LASX, there is 9%
> improvement when halt_poll_ns is disabled. The command is
> "./context --test=3Dpipe" and source code located at:
>   https://github.com/bibo-mao/context_switch/blob/main/context.c
>
> Original     Wih patch      improvement
> 75232        82440          9%
>
> ---
> v3 ... v4:
>   1. Fix one issue on patch 4 with function kvm_lose_fpu(), where flag
>      KVM_LARCH_FPU is checked too early so that LBT disabling is
>      skipped, since API kvm_lose_fpu() implies kvm_lose_lbt().
>
> v2 ... v3:
>   1. Merge patch 1 and patch 3 together, patch 1 adds KVM_REQ_LBT_LOAD
>      type, patch 3 renames KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD.
>   2. Merge patch 5 and patch 6 together, which remove aux flags
>      KVM_LARCH_LSX and KVM_LARCH_LASX
>
> v1 ... v2:
>   1. Enable FPU with max VM supported FPU type, rather than max used type=
.
>   2. Add new request bit KVM_REQ_LBT_LOAD for LBT restore
>   3. Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
>   3. Remove aux_ldtype and KVM_LARCH_LSX/KVM_LARCH_LSX
>   4. Remove middle FPU state handling in kvm_own_lsx() and kvm_own_lasx()=
,
>      directly enable LSX or LASX from FPU none state.
> ---
> Bibo Mao (4):
>   LoongArch: KVM: Add separate KVM_REQ_LBT_LOAD request bit
>   LoongArch: KVM: Enable FPU with max VM supported FPU type
>   LoongArch: KVM: Remove some middle FPU states
>   LoongArch: KVM: Remove KVM_LARCH_LASX and KVM_LARCH_LSX
>
>  arch/loongarch/include/asm/kvm_host.h |  6 +--
>  arch/loongarch/kvm/exit.c             | 21 +++-----
>  arch/loongarch/kvm/vcpu.c             | 78 ++++++++-------------------
>  3 files changed, 31 insertions(+), 74 deletions(-)
>
>
> base-commit: c10130c234c81f4a7a143edbf413080235f8d8ce
> --
> 2.39.3
>
