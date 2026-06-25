Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E8A3254AF
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782412640; cv=none; b=QiVup/9vqe+jtMa4BqN+lRmVYyNMD/+bsvC7o9kUFcp5WDRIYGSmqinTGwiNjU7Sbwh6FNnvo5hgsEpWuZhd9KWzHfLjlrvpIC2T4pGqno4WgZRNL6LIGydSYGdEkaZ4nqscIu+w5ndLz+9CcITedN+5tsG1EeFSa9f6r/3DPrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782412640; c=relaxed/simple;
	bh=XGF2VYl68rxHrrb3+celOOH/NDrS3MYyMHWdfsQBzvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TLjiWuzRyWqTrTgQNIkMo6jaO10aMV2SE8Ct0NQMU9ozR8q6TbYmrqS+VjxXplk0IJBqJgVvkAFUAiuC8H3OoewOtkmrUIOqaN2IZBXdxnAMS/t9G3aWiU3No3j02PJV1phy02BEA2mwwMsi/paPCjKrqcisnfqy9R9XFz3+al8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X8aWhkmN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X8aWhkmN"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37e09f9c4dbso112245a91.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 11:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782412638; x=1783017438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1CLBFjHRtepPsR7OTGTpvVtcvQrDt/pUW+o4gNlp90=;
        b=X8aWhkmNeHj5B+S2ARCMB1eYjl8r4K4etZG/HFXM6FdnlaRlqdY4o98YfqE28CTDcR
         h/5o4uydtcCJZiCzbK9sKcrbpGEB+T9aiDdWY3gbAEdzDlZbZa/q2KSuRVZ+rLox9d3p
         G4TtUWznQjge07RTSOIla9Pcp/rxD06QJ6XKnXaUvB6LS0sDQD0KiwbF/nSfSJ/UctIs
         eiYqmaiFp2MeO9M8BJQa/JwucCl/DUMXIcHS7haA2iKr7vI3h4lbwnYwrAqjdla0TWWq
         ju4VtRWlsKfyNNN3B70xbms6qUr002QyNhVZPOSpZvIhg13Wsch+aShIcJyNNQcyyMMd
         Ol+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782412638; x=1783017438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1CLBFjHRtepPsR7OTGTpvVtcvQrDt/pUW+o4gNlp90=;
        b=m96HO39WU0MhGYzjiJsKtjlLdYR5X0BQ3Gdmid2mCbb9ZqkF8EAbPeYci40vGUWilg
         PcBK1KU2DUtVqUUqCvEdSZg+MkE5alEOKQ2C4CgK8KE08OWpn1z/FOk+qJdoncZ89mrx
         GGBhTfY4HlioNfP5qNfdDFaK+v6vWv1fLZwRbZFXn/hYzSB/n5HQEuI3P0iFZi5ERVDm
         BemDFyeIrtrNMetQBQnwYl2tL1j+8ru/KtXh88eYxnVc/2YzVUOG2DPuW2DoNG8IXOt4
         Rj5wU4Vnd+UJrHijncOL3G5HsYjrrq36VAKWtEx8VKLaHTRErYIk20bpFE1DmYf7rBIV
         nBYw==
X-Forwarded-Encrypted: i=1; AFNElJ9yLSW++1q8jNnc/NKBkYusrmDVi8Gg7napSKLIFFH0s2yNYkHTVTgb6jXETzj7SH8FD0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/SvHkiW/TnpAQmDpkssMusicNnC7C7J0b3YPzBhWzV+uwWvP
	zElLSzuwVmssbxW4el5nEckvAYECoAUcK0CuhkJOXP7kvR/gti0/DcK3GVq+4Vy+xn9LWa9ZJSu
	Gy8u7oQ==
X-Received: from pgab3.prod.google.com ([2002:a63:3403:0:b0:c89:356d:606a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b04:b0:3b4:8aad:6337
 with SMTP id adf61e73a8af0-3bd4ac80c24mr4406701637.15.1782412638064; Thu, 25
 Jun 2026 11:37:18 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:37:17 -0700
In-Reply-To: <20260527-kvm-locking-docs-v1-0-4fe8b602ff47@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527-kvm-locking-docs-v1-0-4fe8b602ff47@google.com>
Message-ID: <aj11XdftC_WAf6Av@google.com>
Subject: Re: [PATCH RFC 00/12] Document synchronization used in managing guest faults
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Fuad Tabba <tabba@google.com>, vannapurve@google.com, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Ackerley Tng wrote:
> Ackerley Tng (12):
>       Documentation: KVM: Elaborate comment on kvm_usage_lock
>       Documentation: KVM: Consolidate notes about cpu_read_lock() and kvm_lock
>       Documentation: KVM: Consolidate notes about kvm->slots_lock and irq_lock
>       Documentation: KVM: Turn - into bullet point
>       Documentation: KVM: Explain what rule the exception section is meant for
>       Documentation: KVM: Have actual headings for exceptions
>       Documentation: KVM: Drop mention of kvm->lock in SRCU documentation
>       Documentation: KVM: Add example for kvm->srcu in relation to mutex/lock
>       Documentation: KVM: Document synchronization for managing guest faults
>       KVM: guest_memfd: Clarify comment about gmem.file vs kvm->srcu
>       KVM: mmu: Point users of host_pfn_mapping_level() to docs
>       Documentation: KVM: Focus acquisition order section on preventing deadlocks

Please split these up into standalone patches or small series of patches that are
logically related at a finer granularity.  "Here's a pile of KVM documentation
updates" is not a reasonable level of granularity.
