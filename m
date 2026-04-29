Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE403B47D2
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777457572; cv=none; b=KpfgSx1RciOP7y0r3v01zI5wbM0T5fqQxg8LDkv7z8ZijUrIw22GKIBm7qVCAzyEFYl+hejsSacNLM50BOZ7qk7eeeLVq5zNbrJWtC/7jxtIib38HtNUjHhHDWWC3rYkTGZmJL8mZqKb2FbmWhkIZMfazY0xQ17uheWvYpkZDXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777457572; c=relaxed/simple;
	bh=WmBRG7ybVpEVt5f1Yz8SeR7dvYo1ePWwV4o7bJ6Ib3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjjpBazXofOZZWZ8i83VzS4ZKgBRAnWkl1kMMTX4UHq9j7Cl6RQehr0U0TBTTXcryFrRnB/ZpV/tbqtpqtYI4HWlNHMzRD6krinOD3D6cecdpzLfDiMfI6YarpK6ZHsFOfWCR/NhvYZ5Qc/O794JUcEuiLndF7NkKJQ3bTGkYAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOkvuMrA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOkvuMrA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEE0C2BCC7
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 10:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777457572;
	bh=WmBRG7ybVpEVt5f1Yz8SeR7dvYo1ePWwV4o7bJ6Ib3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VOkvuMrAFbVvOrkIm2EYoRN7uZHwY3rP/qWKL5riKuQ2obF5xEP5E3g7rLHwPkXB4
	 uPQ5Bw43puqAG3Jf7mY8sZubBHBf5qxdNK9WkcvUySo09qd6UW3UP9U3wohAC1bbcj
	 MFOi2xxEoIePQoGRZ0unPi5ad7ALnefx3NHDu5EX//O8xvyI2rcoC3CzN+ai5fORIp
	 bkPQkMVWvbVYLpcN5max55FriEbKb6TfLxixok8O0PvSCV/QIAS1my+gfjkEYxwGm2
	 mJaSa2gxP2MwhUC4dJf/k9EmGnnhYIN71L7l5cXc/DRbV/KgmDdeFTd1dXE2NbPOQ8
	 bDNN4d3WzPLOA==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-672c12e95e9so17327059a12.2
        for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 03:12:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8JNIm+USK+I04TzG2Z4wQ+rGvXEq+TJuPcFCW1HJu908C4mY3AKOpQloBe1dVZGSfXgQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbBNnhWrF9kxcxAssuth1nsJ4+OGsFrwOWVbTlo3R3FWgQFv3g
	K47UpFDO+CZkpzUmOeZ+X42Ca6pHcXevi2s6wWKp0M8IhHekNS/gmkpO7JJ2vS4Y4rK/bkyEuR5
	XsDBPzInb3L1kv6C/rAcDX2IEATf/lGI=
X-Received: by 2002:a17:907:874b:b0:ba6:8a6c:f91d with SMTP id
 a640c23a62f3a-bb804537cffmr412174666b.36.1777457570525; Wed, 29 Apr 2026
 03:12:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414072313.3801110-1-maobibo@loongson.cn>
In-Reply-To: <20260414072313.3801110-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 29 Apr 2026 18:13:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5+mR5gnd6x6yUEFK7ZnWyYQVTiE6C=enk7bHxe2Mo2Sg@mail.gmail.com>
X-Gm-Features: AVHnY4IE7b_uD3Pu012Z-8FrM3vF54CDje-BOBCpe2XN_WV3r3i-oCnlJyOGEcE
Message-ID: <CAAhV-H5+mR5gnd6x6yUEFK7ZnWyYQVTiE6C=enk7bHxe2Mo2Sg@mail.gmail.com>
Subject: Re: [PATCH 0/3] LoongArch: KVM: Small enhancement about timer
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The first patch cannot be applied cleanly, I adjusted it and applied,
hope it is correct.
https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.g=
it/log/?h=3Dloongarch-next


Huacai

On Tue, Apr 14, 2026 at 3:23=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> By running LTP stress test cases on VM, there is an RCU timeout issue on
> some vCPUs recently. The problem is that there is HW timer interrupt lost
> issue when injecting SIP0/IPI interrupt from KVM hypervisor, this problem
> is hidden because the KVM hypervisor will inject spurious timer interrupt
> if emulated timer is expired. In late the spurious timer interrupt is
> clear if old TI bit of ESTAT register is not set, so there will be RCU
> timeout issue with LTP stress test.
>
> This patch set fixes the HW timer interrupt lost issue, also this patch
> moves unconditional delay in timer interrupt clear scenery, which happens
> seldomly; mostly the timer interrupt bit is set when it expires.
>
> Bibo Mao (3):
>   LoongArch: KVM: Move AVEC interrupt injection in switch loop
>   LoongArch: KVM: Fix HW timer interrupt lost when inject interrupt from
>     software
>   LoongArch: KVM: Move unconditional delay in timer clear scenery
>
>  arch/loongarch/kvm/interrupt.c | 37 +++++++++++++++++++++++++---------
>  arch/loongarch/kvm/timer.c     | 16 +++++++++++++--
>  2 files changed, 41 insertions(+), 12 deletions(-)
>
>
> base-commit: d568788baab24875604c231f723dbb72387fb081
> --
> 2.39.3
>
>
