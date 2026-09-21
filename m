Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE2C3ED5DA
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999669; cv=none; b=AyKHCoZPQYQuxAwbhg2VxU8mx3QWp/worDXqije1jZN/OWmcLWjKLX1+qJXxqBQYwdNs6crFZo0w/r1/9FoV+dj7s6mRxg9ei2xH65/8p0xW9OqKADXkmmVdSkOGl6oikLSZcp9D5uGPAZhIqQNkt7ZWF/EQYkUWnAiv9Oz+KkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999669; c=relaxed/simple;
	bh=PnTxVapAI072TI1mWddiiW06LTNn+rrIrioNwXne5Ow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ih9vmFVV7LMhg0LSwbWQtD2gRUCCKBShq/V+qT5WNONTAb59CNBRazy3ofajIg1erYw9lVovYUwxCjaGVwFmBAOIXPGlUTIloR6zRSunvNLXw/yNUyAflc6nUr/ie4Xd9pTLF1qp+AaDaLGzqO83SiRuaQkl0UyYG4G3ZKxCvL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UXVeHLp8; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UXVeHLp8"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc51591102fso4399763a12.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999667; x=1790604467; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bnx/BHDMvq/zoLxBByuVjVwNb3H5wxZ7w/D6NMBnNTk=;
        b=UXVeHLp8Aftj5lTQpTVB8NyFGA9aCsY7v0KOezMTfGOEU7MSbu9k3b5iK/LjMefntL
         CgPSO59i9ffJM0AwN6z+EK/LHL7RHIsoDW3GbkbZ63Uooos9JqhT1dihZecgHo+aMO4+
         eHQ8Pmh9sEukQlD3F9s2aVvklstlneDj+tF9clXZriIdsQU7R0ZupRm3+d3ZJerjZjYZ
         b+c5F/sgDew2ImaPFdoU2Bvz8EVsKHGNT37vkVa/QaDevSqGF0qKxUgdjetQrIR5M285
         tINUeAXuW/zmIM1bTmXfDFfxXbBY9H1byZp4OtDV/ET4UeSc9MruOR3UfiiU5vg5Fy/v
         Qe+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999667; x=1790604467;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bnx/BHDMvq/zoLxBByuVjVwNb3H5wxZ7w/D6NMBnNTk=;
        b=1X/ib7XOCTT9jIIL0+Fwz/fr3pKpilemwLowb5PlNOV5PA5dwaTLkQCE3OACSHwEV+
         aQ36BMls0t0Kq5fd5OPc3KjA+EhXOC3qih/FRSGkeh1tpSwsurcgnuGmrlRUP/sYDEUE
         /2H8VIrzy7ErXFvsANc0kYWBaaJl2pFSqQNfAqNhAsvxid9tQ1ww+7WhYaAmMlUoEHKU
         HHwigIEyRdKiYn69ANJKP8cBvjD15X+UcTlG9a+UwvoA5CtSFRhhlSgLy0B68WoApaXt
         zHInLUmI6z2knEVejmCINnIyveK6fmxGes7ifyXbM1voeWA8F/GKuujNAw8XBReVaMfb
         FfDQ==
X-Gm-Message-State: AFuF++lZBrsV7eDXw2lvmND3+527Gks09VJgJ5XfymV6xG5cUf2V0MQv
	4CzIIZsSEmT7mlp1MH15GRITU3xcfqCmoeBpF1IlhJQrxhx+d3IWMwJNFuqqPxFksLUMDUN7ey4
	/OcwXfw==
X-Received: from pjbbd16.prod.google.com ([2002:a17:90b:b90:b0:3a0:5e07:c6cb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57e8:b0:39e:6c69:34cc
 with SMTP id 98e67ed59e1d1-39e6c693638mr11049201a91.48.1789999667184; Mon, 21
 Sep 2026 07:07:47 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:42 -0700
In-Reply-To: <20260903001625.2792367-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903001625.2792367-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999926338.754170.2692559524716409337.b4-ty@google.com>
Subject: Re: [PATCH 0/7] KVM: selftests: Fix maxnodes bugs and cleanup related code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shivank Garg <shivankg@amd.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 02 Sep 2026 17:16:18 -0700, Sean Christopherson wrote:
> This is a spin-off of Shivank's series[*] to fix "flaws" in KVM selftests
> handling of @maxnode in various sycalls.  In quote because the flaw is that
> KVM selftests followed the docs, and the kernel has a longstanding, poorly
> documented off-by-one bug.
> 
> Along the way, massage the xAPIC IPI test to automatically run its page
> migration testcases when possible, because that's the entire reason the
> test exists.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/7] KVM: selftests: Account for kernel's off-by-one bug in NUMA node syscalls
      https://github.com/kvm-x86/linux/commit/be3c6888e1ab
[2/7] KVM: selftests: Fix maxnode argument to migrate_pages() in xapic_ipi_test
      https://github.com/kvm-x86/linux/commit/8883d2410c45
[3/7] KVM: selftests: use BITS_PER_TYPE() for NUMA masks
      https://github.com/kvm-x86/linux/commit/d2dde5c387fc
[4/7] KVM: selftests: Compute node masks on-demand in xAPIC IPI test
      https://github.com/kvm-x86/linux/commit/3a2a37d2d48e
[5/7] KVM: selftests: Add common helper to get mask+number of usable memory NUMA nodes
      https://github.com/kvm-x86/linux/commit/0be096bbc9cc
[6/7] KVM: selftests: Automatically run xAPIC IPI migration test when possible
      https://github.com/kvm-x86/linux/commit/92ed4d5c78fd
[7/7] KVM: selftests: Skip xAPIC IPI migration test when forced but unsupported
      https://github.com/kvm-x86/linux/commit/d5aa06fbfec2

--
https://github.com/kvm-x86/linux/tree/next
