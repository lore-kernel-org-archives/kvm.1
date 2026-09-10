Received: from mta1.migadu.com (out-133.mta1.migadu.com [95.215.58.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8AE380FF5
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789009582; cv=none; b=K/Dtd7vJ1spAUqqnoCO0JIRitfh5IMtQYqWakCYBkL0h/3ZxCq0d5Q6jv8uiw+BdLzH1lzZTfx48hEBXyDY/V+DBWGLRbDLkjFSE5HNupvAgId/8cnGB6WVpPshm33R2J2z5nYElt69ghOw4UKvU769BSUzDde1D+KcL469faOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789009582; c=relaxed/simple;
	bh=jF2jIwRiFm/34mwc93YKOP3RWvChYPHbleFmFoZs/g0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mKoXjl9EWnGn5N8sfkdZIuzPy1mMf+ZHuljrLrExGhSo8hw3558T1fn666nc0ufcC7ZyGMsVanHCKKD7GFPVoqh+xAIIdJ0n3ki6YBswtj60gTLHiMg49yCwcxfxRpmuGtcDhrQEHENn6E6nzPUhzn+aUZMv4I9fxwIc/bpJeWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vgH5wo9+; arc=none smtp.client-ip=95.215.58.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vgH5wo9+"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jF2jIwRiFm/34mwc93YKOP3RWvChYPHbleFmFoZs/g0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789009566; v=1; x=1789614366;
 b=vgH5wo9+oT82lp7DcDYEZ28+NtkZ3zBUXfVeeLjDtP9EZj9RY7L4h9OfFTEOSEbt+TkxIIYp
 CGb91tXW9QOAK7iX7NqiJQRm2OB20n2YO32itMwJAaUIPtEZq1lB41wZeZyRBbBr1pQ/TcGS8vu
 fKiP1LHXLEI6rGlBOajGnBHY=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 40f81e90980f7168;
	Thu, 10 Sep 2026 03:06:06 +0000
X-Mizu-Trace-ID: 40f81e90980f7168
X-Migadu-Flow: FLOW_OUT
Message-ID: <fb08279a-eb1b-44b1-b4af-f354fb81f112@linux.dev>
Date: Thu, 10 Sep 2026 11:06:02 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] LoongArch: KVM: Code cleanup with MSI intterupt
 injection
To: Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
References: <20260909083259.1910290-1-maobibo@loongson.cn>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260909083259.1910290-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Bibo

在 2026/9/9 16:32, Bibo Mao 写道:
> Here is to remove some unnecessary parameter checking when injecting
> MSI interrupt, include MSI level parameter and vcpu::arch::dmsintc_state
> NULL pointer etc.
> 
> Bibo Mao (2):
>   LoongArch: KVM: Remove parameter line when inject MSI
>   LoongArch: KVM: Remove duplicated checking with DMSI irq injection
> 
>  arch/loongarch/include/asm/kvm_dmsintc.h |  3 +--
>  arch/loongarch/include/asm/kvm_pch_pic.h |  2 +-
>  arch/loongarch/kvm/intc/dmsintc.c        | 19 +++----------------
>  arch/loongarch/kvm/intc/pch_pic.c        |  6 +++---
>  arch/loongarch/kvm/irqfd.c               |  6 +++---
>  5 files changed, 11 insertions(+), 25 deletions(-)
> 
> 
> base-commit: df2908090cda368b01ff43709f51890076c56157

The series looks good to me.

Reviewed-by: Tao Cui <cuitao@kylinos.cn>

Minor question: kvm_set_msi() now returns -EINVAL for !level instead
of -1. Since MSI is edge-triggered, returning 0 to ignore a deassert
would also work, though nothing looks at the return value today.


