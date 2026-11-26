Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713293;
	b=nMu3DpSfF3FtmMyJUW5LMdLhoE7CqRFXDUhT8Qwj9Wi+TlttP+fWHkqwWu3bUMr0CYOp
	 D7lEFk6QUrgcp/BhZM0OfRthN0LmrCFntaH8dT7LhrfsEiuWV/6Ap1At8Nnm23WT8L0Ug
	 8wrMXWO3UV6aZEil1x5csnBqMcmWMnhgkRa2PKqcU9yIqd8PV518xSa2EXPtaZs+Qf6ZM
	 DzxKqFNeIA2r259j8q24kpEPj6dI1CQ2qkNDbsCaDCp74/v1aNzTuLAn7dqUzy35k5rz2
	 364t/RuGZh3rRIwB/CGzja9mYuiRXTqs2dcLkALcF8l9c3JddLiyoHYq0PLPeB3Pjxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713293;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5DknUZGW8VmSy7dz/YP97kler6j7MvCOz4TuHSjvK0o=;
	b=cik23yH5OPPOX7BgSFgFhx9oRSGWwlRdNBShzw8nJ56UfB2DVNUIpeiFAT58BOLqAqmb
	 ZvAz6dxTgGNiiMumYPt1sGG9tI9MfqD73RD7F91GpC32dyesiEUmiDNUDrbLWH1xVV7MV
	 iaQ50m1qpPR94x6zdu8jgzoPVVT39Xk463LIPa6jZgDUC2KiGwCRFZcl8WTGk9KFFp6b9
	 UIg6InOWvaD8dd+ctjrYE8yyCstA5IJPZ9+UI+FbVShrq6mVOeGscQAUVhYxmtvdrtpyu
	 L0qHZ0I4dCnUmve7HeFyE7dpK0J0StnL98rlGFOT47CMbPXr4URBD1T8K6uBa0AbUGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLXzkny3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87A4606A31C
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLXzkny3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41CE1F000C6;
	Thu, 26 Nov 2026 17:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713293;
	bh=5DknUZGW8VmSy7dz/YP97kler6j7MvCOz4TuHSjvK0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZLXzkny33Kei7WjYkwTM7CxRa3lRL6wIL9zswaH95hRL1gDz253e8VPLQgPTHRnpN
	 m+lCWy83y4xg/MkWOlp8QTth8atR5L/0SdL4SKManlp5GrfwtMJ2MPJYeTgevaditL
	 csy7oxiL9ck5ndNIOEddMjthvkjurLBkr+0GuZreuQVMlCpBOuyiIjGaVQKHiodXLk
	 SdPLynbsbGQAE2MQvPQoEHa6TgkMcVEaQy+5FTCUoxGGHDQ4ikYU8AeEqziyJ6TUhD
	 75uoko1M9+GMnGe/SWbmGwT7wm7/NXUnPiQoTvCuEpgsHZIv+C+Xe7f6hdKXpesWCU
	 YpX/ljGkMUoiQ==
From: Will Deacon <will@kernel.org>
To: kvm@vger.kernel.org,
	Dongli Si <dongli.si.linux@gmail.com>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	julien.thierry.kdev@gmail.com
Subject: Re: [PATCH kvmtool] x86: mptable: Fix PCI device number in source bus IRQ
Date: Thu, 26 Nov 2026 17:14:31 +0000
Message-ID: <179571132788.2965205.11864725175771331389.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111123133.1228125-1-dongli.si.linux@gmail.com>
References: <20261111123133.1228125-1-dongli.si.linux@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 11 Nov 2026 20:31:33 +0800, Dongli Si wrote:
> For PCI interrupts, bits 6:2 of srcbusirq identify the source device.
> Use dev_hdr->dev_num to populate those bits.
> 
> 

Applied to kvmtool (master), thanks!

[1/1] x86: mptable: Fix PCI device number in source bus IRQ
      https://git.kernel.org/will/kvmtool/c/2f3abe56dcd2

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
