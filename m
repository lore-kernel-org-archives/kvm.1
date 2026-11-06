Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987891;
	b=jVzqh1oW4iAmt+gqh8nMJH54KV8vg0yDeqsS2wnTWCC65GLus6hcPNPz4JxPDzBhCE+A
	 ZDbHQjC6ACLIwx7GPkYXZt2ZHioW3kQ2z1FiqYaUxdiM18xYardjDMNW7J0b5AczvNqzf
	 YPtAI5r4A5/OW2IGftnotgKi3O0kAapll9Ft8Hd8Pl6HQACUjSI4jZIQSSWzSOq5TesuE
	 89eyZeMkE5680+fMI/v/FxVi2vShrRqVRqRQwYtna8LrF7eH04wyXRQ9zmIU9V4q6EDg0
	 Fesbp5n8r5iZ5zx/mJb+RTIEpqTL0IfQCNQ0J5PK57zWNrnA9ekJdnxfKcQjSjGf97g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=QgfTA5a+5MMLBq/A4jGpp86Ey0W49QUd8AMooz78Jz8=;
	b=Y6pg5PziLCbp5D4sE0bQIgZABg9Pnuq9xeAj/18wvsYP0JjVH5rxO8lnko+8Qg9U6V0c
	 ENgm9vPN8DVtfAGcy58fO8NcfNDQw8mvzKYvfIQIH3tvyfirhM8euH4mEbEe7ml4GWQfa
	 xgwuZ9nHCxWwL37RFV370tFu5iOCkKcU72EBy9RVSkpdXw4IXvbGmarFINHhs2AFVK9cR
	 ESDylY0xs0tXSNvApcvO4ww3h84/WfnCi4CZmA3Zy0EwTuYHGIykInDTujU0vLLu87CcZ
	 00cWh5w2xArReg0VcIhlQQDKnh6fTEyohWp3M4voBJYPL6yDsF3bTiTzFkH5w7NaR0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="CqxfqR/c";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41699606A326
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 17:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41699606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CqxfqR/c
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a214af2076so6669935e9.0
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 09:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793987889; x=1794592689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QgfTA5a+5MMLBq/A4jGpp86Ey0W49QUd8AMooz78Jz8=;
        b=CqxfqR/cUh8AJlLzkvgITLK1SmDNsBsLrV18EJse3aq9MPyMMqMXPA/aQCg/BBDu3d
         yD7JVsBVbsDJen9/Uu0++vaTAFbuawnR0dBqvCnRsqNlIrRwNzTmiQ0Ecf6Fz1UfLpEY
         MaFcUNJtauJ0cBjE6SdlDoe6+B7+/f6ewtoi7IaTPQiXP2BYBkMQ6/UVS5egaYIT5BDD
         HD4th9ehFmy6QK8FUlQ3grqD/xZcClhNQo+MS98mVLq5iwwPKoI0EsF9rfkKzInXHtiH
         GR+rJt1g4ar8ympxrmUW7IWuH8kbrNgOXjkLQKI9WdSMB/VzXAXW2nzfZzsmi+LY8MlY
         tL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987889; x=1794592689;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QgfTA5a+5MMLBq/A4jGpp86Ey0W49QUd8AMooz78Jz8=;
        b=m0+Tz3BWGxhVAKnrvwze/6qU5AP0/dF68V726jez6hmp1qUMtVlcIg3RRuGqZZ4J8b
         4GKwX4HMD/8k085qPu0wuWpxTwc0EWv9lsPvjta0NPYQmK7XWmP5lbGHcBwWQHYsX08W
         c9eJ/dMI5MRNvQO+rooGYKhfI775Ve0bfCtGqo+92pJ1ApvaiGsiLlYifh138s7TVtmH
         VvVq+3Md/G18VOHaGi9DgwCRC4DHzIFoMoFhosRazGY45X1wJXLZN6sL2/UJosygnAmb
         a6rGG6+uXS2fKUxuWmgqIWRXbtSO5mkPeCCmJBEo4b1owsxbckSw+RJw8cpy42kNAIFP
         Ex4w==
X-Forwarded-Encrypted: i=1; AKwUvBzMKFvhyFv/k1Ku7ME3uvlOdaOA+bBA50Wxr1iQOUG+eVX0c/pAbJDLDzMVrsvGfDoKAo0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/EYuUWAWWDpTD2YGkhRkZxoVaoygX3IR4nVkAjg8G6SvLIi1Z
	x+TR79a56A87RvyPH3SdB28p3nM0DIa4+rz0nMhjB22xQmZ4fGxbTZlpYoNWNEKEng==
X-Gm-Gg: AYBFou3EuJ2NGY6rAzMGR2M5UyYpzA0doE5nXiA9ZwVIW7/KIe4wxMC1xACAzNkopeC
	0OD8XnQOq34q7BhyY3Sf1XgJF/COkLjlWXPDEYY0v10McKuxH21SQcFSzuMgghr9n+payRRDeHs
	TpR4dhJlzr16hCVefOFG1BlALLwxO7E+7/fmP3NDWB746Q15ab2upJJCjjBKCkgc/TLIVamQd3l
	FBmXYxpj2EsHbx/1WmCW/h45LD6QD8MMYpsCWHkOfqCo4zrEnm0v4AdNdVoLDEOEOaL6jESRjvH
	3Mt3hCrH31vrLB6ZLV0lWHU1SABfoeq3IHZzQPltHiUaXsviDpJcta6rZTd37mFZF2oWxt/LniL
	ScFD/QppgpudFPppXIkOOKhXtZMrLIL4a3w+W0gPtxeGvQi/j2902LHkuURkXvQpCsoEwi2ZZ6d
	fpaTk9OYWl2+jVthxxd77FYjt57WxBBeQdGejc2bzQLC8w7gUogkUqGUQus2SECWqRbcbSJCk3c
	gpWQKg/C486ouSHZ0ewNhRLZaFODBWzQOj9t207UmAIjKMQNZipQxg5Qu+QwKUt7afgL4EL6TBN
	A2g8ObxXim1sVnP7QXRMUhbRkdr8ARBoyTofA3qHPETzk31cgvapJngzWr3ii8OUMhXgID4ukjb
	A1rvndFA48g==
X-Received: by 2002:a05:600c:3e08:b0:4a8:f2ad:a9e5 with SMTP id 5b1f17b1804b1-4b6db4a9ea1mr49691395e9.3.1793987888277;
        Fri, 06 Nov 2026 09:58:08 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76cbd082dsm8048725e9.1.2026.11.06.09.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:58:07 -0800 (PST)
Date: Fri, 6 Nov 2026 17:58:03 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Fuad Tabba <tabba@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] KVM: arm64: Support SVE in protected VMs
Message-ID: <au4VKxSnkJgDtcpG@google.com>
References: <20261105130456.1617185-1-fuad.tabba@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105130456.1617185-1-fuad.tabba@linux.dev>

On Thu, Nov 05, 2026 at 01:04:52PM +0000, Fuad Tabba wrote:
> Hi folks,
> 
> This series adds SVE support for protected VMs. EL2 allocates a
> protected vCPU's SVE state from its own heap rather than pinning the
> host's buffer, so the host never sees the guest's vector registers. It
> then advertises ID_AA64ZFR0_EL1 to protected VMs, and routes the SVE
> trap to the lazy FP switch. The first patch is a small tidy-up of the
> pKVM FP sync code that saves a guest's SVE state.
> 
> v2 of the pKVM selftests series [1] will add a selftest for this.
> 
> Based on Linux 7.4-rc1 (6628e7d4c6b25).
> 
> Cheers,
> /fuad
> 
> [1] https://lore.kernel.org/all/20261104084842.132944-1-fuad.tabba@linux.dev/
> 
> Fuad Tabba (4):
>   KVM: arm64: Remove redundant kern_hyp_va() calls from the pKVM FP sync
>   KVM: arm64: Allocate a protected vCPU's SVE state at EL2
>   KVM: arm64: Advertise ID_AA64ZFR0_EL1 to protected VMs
>   KVM: arm64: Allow protected VMs to use SVE
> 
>  Documentation/virt/kvm/arm/pkvm.rst |  6 ++---
>  arch/arm64/include/asm/kvm_hyp.h    |  2 ++
>  arch/arm64/include/asm/kvm_pkvm.h   |  1 +
>  arch/arm64/kvm/arm.c                |  1 +
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c  |  4 +--
>  arch/arm64/kvm/hyp/nvhe/pkvm.c      | 41 +++++++++++++++++++----------
>  arch/arm64/kvm/hyp/nvhe/switch.c    |  1 +
>  arch/arm64/kvm/hyp/nvhe/sys_regs.c  | 22 ++++++++++++++--
>  arch/arm64/kvm/reset.c              |  2 ++
>  9 files changed, 59 insertions(+), 21 deletions(-)
> 
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> -- 
> 2.47.3
> 

For the whole series

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Tested-by: Vincent Donnefort <vdonnefort@google.com>

-- 
Vincent
