Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FEE3AB27C
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860498; cv=pass; b=bWIgzCSVAwb3JmcPi5D38yYsoVaYWMaZvDRNf1MpQd/6syZtwEzvYz9XEKyYBLQqUFt6VfTksUS6NfyXzMuZx6s0vCpiIcZPc87jEa509fipAb4YZBdjNimkz/CgIS1cN0shnVRG8RKSmL9hfIP25jUtg6pbK6EIiMTeTLZDfDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860498; c=relaxed/simple;
	bh=p4F2tGl6BjjtVT2FvI94dQ3NiL3eberPlg3zemZbOkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLZIOD8xKnxYuXU9lbt945Q6iga5vGhJ8/CLfXS8WdmZ6JhidSeE0xw0jmIi4In5vh92oHebn8CkEqe9GBGaalrlbfFvCcfSmDoLPeQkQoy/j0xHQ5Y/56hoFO5iJP0Sr7t87ws7otPA/l1OU/r0+KtHn/klg7zp0hGLn+ai+sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=h3v7CzdI; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="h3v7CzdI"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a133b686f7so4916165e87.0
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 01:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774860495; cv=none;
        d=google.com; s=arc-20240605;
        b=RY99MdikdmNhA2O+vPuFFCfPeeg39IKG67WFQwleWn1QhWCzaWLIbkhAEjPIWwi0g8
         s+ckVqVxkFgZaNKhvbRzIqpDE80gQqBzQRRmSxBOovGtqd1MHLmIJv48uVvBbNyDpnER
         0qVIaIBuvqmSgkaVkNn2RHZU1MZI9UIF6FYo1yuunTIc+S5t4HDzdm2pamxQbYDPeO3E
         Gw+c45PO56pnTwdov5ttd0US9ywf90nkUzbm3Yg45ymZ/8FY1K5Ttg5sFjFF7vFyAULn
         18dLv7YdmKVk26e5SM+n41OUxTjpSUZt6o3p3DwEU0zW2Dow8P2vxXjbAmic/QiJHecm
         fYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tz/sv6XGOvreioGu+TkOdx3Hk3HFf92lQsBbbJLSqBo=;
        fh=BDn3pSsxOUIRHLDTtnaYhw7cl0VgU/GY8Rzsyf/gYaY=;
        b=DM4uBY3lJdrPufLirSsile8uHDb9RvaExRgksHCUWQy0cKwm4F16S3EFd+etZYuDBQ
         r0MOlhJiA6kScRFph+D8zOwIKqXC/Ozpx7fhP4jNj/BFgpHIEfZ3kof62WIa1P9imCMj
         KU27iD1Te/6NzIbsJ3BuXlzVTM2JwPAanDJxmA7PXtN4WuAjldqMBzF9ePVPZGRlDilp
         NxSVNZ5Z2FU++zAOik9hTssdtZ97OLwFvlGjuPjQ8awtE4a+ucZCGjeA3JBRpOMHuJv+
         290/8Kep9tvBMJ+F39in+j3FZnkN19NOBa5EEqIRbDBc8KGl4ihL0cl+YhNolh/o0VPr
         u8cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1774860495; x=1775465295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tz/sv6XGOvreioGu+TkOdx3Hk3HFf92lQsBbbJLSqBo=;
        b=h3v7CzdIPMH7k33MPJsNawH8qWA4CXqRAn/tzPtxax8NNtLKlwBmQHfobZiKc16adB
         4L2jka8/DIjLHTHCBym7Q3JWDRzrdlUn5E6sjDqOrfxACgGPJMTxHGmEzwmD035akaW5
         E3d6tsNFDzugYSUoCYIAea2chpofK6bKARX65xSbqByW3sL+qqfhJRipnrcZB+/pKdeY
         FL9yPGpF00vOgytlhunxkCjP8WiVsczYNLJglBB39xeUlaX3AQyO3GPEWvjjyBMn0/2T
         sQuQa42Jvb8IY1Pzf1ZNzivTgTGX579loCirUY6WJ1pWLqsY98tGLQJgEb+4cSwJ7Ik9
         LPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774860495; x=1775465295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tz/sv6XGOvreioGu+TkOdx3Hk3HFf92lQsBbbJLSqBo=;
        b=J5OxyYcXzQ7tfudYXRCVUtcbKMtUkS5FG3W+E6Jepz223mFiZc72sEL5Fhs7EkCEkL
         rBXemcI7jNUqR5SPXHBh4wEDPhC3z4Lmf9FkX/J6e+ESB/xHkxiXT+/yMW3bkoYId70D
         X5S7NG+O1RnHNDAKqeJ76poOyx5mpFed7ez2eA+ul6ZTl3DQjs54qQCb3Xvr7IqUO+gW
         rgHnU0mV9FcSWJouT8YrfCR7tBAhYZXzKnXt59KhwvBZN+w9IxAr5lFORjDZ7B9JjWY+
         NkBQ+9wWO9zKSkPCVJrUdq12xKn4TZTr89lP13TxEQjtr6GYgEMNzEVvwswJvqCFhfJU
         Tykw==
X-Forwarded-Encrypted: i=1; AJvYcCXtlTb/JteDcomy+Q54e0RCUjohU2kULwsMkQGjhAVF4wQL2qEWdL4E4A5e75fahlDoJ+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxklL9ljZ7XLRc5DJNm1BTjC1n8dc8el8Zgi1Tzg1VpLpELFIlE
	fsEFCo0KEOZ7F94zMbk20VNiLSEYVKR1LmcDKdMG33IMr+i+kt5Ydassgu9ZCkArjCPJ7uE4gO8
	nbVfOlsaimw0gU02Tv8v0d5a3KfC4i3MYRONwZjb2Fg==
X-Gm-Gg: ATEYQzzfPyX9ajXFOiNeJp2JEsVYX3KC3laSxl2hTQr1gRrnZx0Eyc7nQPcl/6qhhkQ
	EK7Gmm+klm3ic1KH8A6eLgeEc3TQ0Egi9uBWE2K0rMEY7fAfohtTInzwI2cPg354gpEtGqaszdM
	LYMqYBWRsmPcFI9rSW+U4tHxW7SKo9PyoJrVkSNF5gMUqotgnSlEo9x6r/mV9DezsG7Njd5RWHV
	HQ1qCgc1tSuF+xCgCR9LS1Jc4xx4A5sy7GdHqvdrbJkBSVmZXaRpAfGeqLTwiTl6ZTp18LBOy2t
	IEq8YscfGqg01kthvmZaDpEshzgltelY2ZGUbuEj
X-Received: by 2002:a05:6512:108a:b0:5a1:4158:ea9b with SMTP id
 2adb3069b0e04-5a2ab92066fmr3681883e87.22.1774860495167; Mon, 30 Mar 2026
 01:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202603301608170032mtkGKX7wRcAkPKDQ5I-F@zte.com.cn>
In-Reply-To: <202603301608170032mtkGKX7wRcAkPKDQ5I-F@zte.com.cn>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 30 Mar 2026 14:18:03 +0530
X-Gm-Features: AQROBzB63KEV8P_Bg0QV0rJAUrTlF3dz8GKfngYrRvwbEkxEjBtIO9GeL0HwnZc
Message-ID: <CAK9=C2Vb73snLT0uEY=5S5dQc6VXc_u4S60+9+sCLpyXZnHTWA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] RISC-V: KVM: Fix hugepage mapping handling during
 dirty logging
To: wang.yechao255@zte.com.cn
Cc: anup@brainfault.org, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 1:38=E2=80=AFPM <wang.yechao255@zte.com.cn> wrote:
>
> From: Wang Yechao <wang.yechao255@zte.com.cn>
>
> This series fixes an issue where dirty logging fails to work correctly
> with huge pages.
>
> v3 -> v4:
>   - Squash PATCH2 into PATCH3, and adjust according to Anup's comments.
>   - Link to v3:
>   https://lore.kernel.org/linux-riscv/20260316141234007qSAOsesu2cSQsj-LA-=
qq3@zte.com.cn/T/#t
>
> v2 -> v3:
>   - patch01: Add reference to the specific commit being fixed
>   - patch02: Fill the page table entry before replacing the ptep value
>   - patch03: Add handling for dirty logging disable to avoid memory leak =
in gstage page tables
>   - Link to v2:
>   https://lore.kernel.org/linux-riscv/20260304172139131ChDubMSpGDUB03lY4U=
CbK@zte.com.cn/T/#t
>
> v1 -> v2:
>   - fix the lost write protection on huge pages
>   - split huge pages before handling the write protection fault.
>
>   - Link to v1:
>   https://lore.kernel.org/linux-riscv/20260226172245358qVZavIykLL2QC0KoqT=
O-I@zte.com.cn/T/#u
>
> Wang Yechao (2):
>   RISC-V: KVM: Fix lost write protection on huge pages during dirty loggi=
ng
>   RISC-V: KVM: Split huge pages during fault handling for dirty logging
>
>  arch/riscv/include/asm/kvm_gstage.h |   4 +
>  arch/riscv/kvm/gstage.c             | 133 +++++++++++++++++++++++++++-
>  2 files changed, 133 insertions(+), 4 deletions(-)
>
> --
> 2.47.3
>
> --
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv

Queued this series for Linux-7.1

Thanks,
Anup
