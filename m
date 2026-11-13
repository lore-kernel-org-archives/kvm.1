Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578003;
	b=LbRWXOKOd/79Ov+171BMHxMx6rjAQixUBUQCb7pqq/sarnploiwO1OHYAJfPOiGq4+YU
	 yqqZPO7ATKgSEXZTLEpaMxbvUwyn6ujDTdDoVlyygOszZWQOfp1Js91lpQvl8DKfiI8jc
	 JO+QBs0PrrgOH/Ok/8bkyGXdo0eLh9M5l21pBKZkt/8eyYaeePAbj1jZMu2N+jJBzAXB4
	 fFBxfV0rP53ngwm9szNkRQO3K0/D9v4FCnzOZYeq/7ZMxiLTaOvdFaLv+spH+SA2+a3tw
	 Z0wmJwSiytAC2RHovDdu6H2ejBOx0BnUN1PJpAHd6219u4IWDQFrWXAIYhCOeKsGskQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=dlsL3F8sYJVmEsiFaoMpY1LBlwOoTrnSEiIx7tFA8jw=;
	b=1j0oQ7p2FS35N6fhwLNj/6Dr/Oonymoae7rkGXTaztRs+y8xMVh1r2cB0pCoLi61zyTC
	 dpBMG8gJcPFTFjhQkQWKzTFy88E/gpHo54xsFxSnMA66fu/sS5mBSPy7+mwTpcq3NmFj3
	 YHU6IYbSVaiqgbTsQjh1SJPIaMfO57GmP90qvgmpqm0wf4DZDqaEXP1evhsUNIuqwtt1C
	 OIgEunphQQIl9V1q/hde+BnEmeuuT3Gt7dYqQ04VgUMf1TP40JfooqcmfFLKOT807IDUS
	 hqSiERweCkgxyOBCTDQBjxh1Q5uXlWkjAvKGmmeOt+mwxxUZu0serdlILfxRaPEvIlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mxlhe+Qt;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37059606EB38
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37059606EB38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mxlhe+Qt
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8b8cef34b43so1464109b3a.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794578002; x=1795182802; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dlsL3F8sYJVmEsiFaoMpY1LBlwOoTrnSEiIx7tFA8jw=;
        b=mxlhe+QtvpmAYIZcVFMh1eKW1qV6yNglG0IIW1nW/DD8LmyRUmO43Zejqlym9ykpz1
         9QhFn5wny5QjsvrZ9SGPq+8qEg9lDWsnLVH46VaicYKY7hmXj4PdQsGkWeSMTi9q7ag8
         E4/FLwAtjAZhYo+6ROn7RUCBF3kHFkVuy9egxa/sUMu8qoPJNN5wh/8R8T7Os2qFqlKX
         lF58GPs5YPVM979ApTLkJ1GHepac3VXfEIUVREoXwJbDlSxVQxOGhgwprCjZ+u/JmwIa
         DTTqM97kce1wnbt2LM0wRwXPoK9MQ4uKiuVNmhgwgJoXe/XmKvvzQR71X/j9aO8+UfG6
         LBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794578002; x=1795182802;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dlsL3F8sYJVmEsiFaoMpY1LBlwOoTrnSEiIx7tFA8jw=;
        b=0oLsvOI4BIB9cA0+CRbbV1S53IZhwLuEuPSvI3iWZVmRt8HVO6gQC62Wwij/mwDcwq
         DxvXreQDV98uT6KiJNuKc1JBTSCt51dmQRko8GkvdJfsuD/Sdk724hqrE0hh44jchC47
         ON+gpRPgq4jAka9MR3Oa60mBDNRS1GARcDldfPp6Z/U6xUX2MYwwDLw7cbzde6rzTSn1
         wDRVecKth6LK2XE6ZlmlDEO2tctwAuUTM8OvGiD5D8HwW6HLA0+QHp15r932Uaj2t1Dz
         i8sUIFscmmKovpYYCwiqd/qpEGiUxowSXFgpDwTYGlw2jjsJ4sVFQ7+N7apMsfGQ69kv
         +X0A==
X-Forwarded-Encrypted: i=1; AL+hErFbE9G24eLgj2Ni7AAYFX2j84pDZ4+MrMBz9dYfRz7M0JdcfO6vRpHBNy2P6RtQociYl0Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9PDoA9tbDO1bOQNlRTEPQlM0y0ka6bTo0OD1hm5LruuMIsaZ4D
	TZGQk8/RPDyjbfg4csDykZr6eANw8ES+p8aI3WXAuPMFw7vIuAVnOR/7D+hyDQbdkHDDTByj3By
	kLWDM4Q==
X-Received: from pfew6-n2.prod.google.com ([2002:a05:6a00:c1c6:20b0:8b6:29f9:ce4c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88cd:0:b0:8bd:281a:5cb0
 with SMTP id d2e1a72fcca58-8beb3b3ccd9mr2811215b3a.6.1794578002302; Fri, 13
 Nov 2026 05:53:22 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:41 -0800
In-Reply-To: <20261022210134.612848-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022210134.612848-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441778800.76592.3104502166440669144.b4-ty@b4>
Subject: Re: [PATCH v2 0/3] x86/cpuid: KVM: TDX CPUID fixes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, Binbin Wu <binbin.wu@linux.intel.com>, 
	Changyuan Lyu <changyuanl@google.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Thu, 22 Oct 2026 14:01:31 -0700, Sean Christopherson wrote:
> Boris or Dave, can you grab patch 1 for 7.4, ideally sooner than later?  That
> would avoid having to carry a stable topic branch for a trivial change.
> 
> Annotate CPUID entries that have a significant index when reporting TDX
> capabilities to userspace, and enforce that userspace honors significant
> indices to avoid creating a misconfiguring between KVM and the TDX Module,
> which in the worst case scenario could lead to host state getting clobbered.
> 
> [...]

Applied 2 and 3 to kvm-x86 vmx.  Thanks Boris for fast-tracking the CPUID change!

[1/3] x86/cpuid: Mark CPUID function 0x23 as being indexed
      [already upstream as 108775fa28fe04a16f19a828a779689f3d0ea9f0]
[2/3] KVM: TDX: Set SIGNIFCANT_INDEX flag as appropriate when filling CPUID entries
      https://github.com/kvm-x86/linux/commit/bfce14e80e89
[3/3] KVM: TDX: Reject KVM_TDX_INIT_VM if indexed CPUID functions don't match
      https://github.com/kvm-x86/linux/commit/c576a80cfc4e

--
https://github.com/kvm-x86/linux/tree/next
