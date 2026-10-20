Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503572;
	b=u/RBWYE1imdYBoPtufCd846KaWBtnpdNJESSmZ9nA3N10HdKSwx6cRTh8Qbx7wQDpJKK
	 VxWpshJ82CNTxIaZYYaAuMeH0Hf+eWDO/r9TsKoMdqBxhr5Is5SsFvSvmiI508uOUmeve
	 n1uRVhwcC1DrwolAN5tL+4hxx/RMILkzQExcBNp8iy7KB2Xg1OrzkIkxmvNFhMtm0gxb2
	 vrtTxuOWSAYyuV00Z1nye2lFStCGlIKr33TZ2SxaiQgWgYCwJkp10akR+TG3mQXo9aj8U
	 MhFSS7oUwCWN8ewEr48CrPCOXAor87q+FbWwQxxrWsbswtzGRCvZiM2b2WiG331RBvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=YVuH6pbzYAqeG9iP/8Zmro2Blf6sH5I84xRb+j7spVo=;
	b=EqsxYFOYJaQQqU7n80GSZQFtEtEHupLrIiz5OD0C6ihiAlxPEMMxnwQ9sTP9vYo8SauM
	 xtq5+T0r7hhGXQ4/Iqer9+j9L+2Ie1QKCqBrDeYjuaIVxDRnShnMHjRyVtFmMUYg0AVBg
	 IlfOuXIrC5W+18JH+lJ73XLcrVKNO5QNvfWsrtLrgaXgV0k6r2A+9mEZ7yLcWU0iN6Unp
	 JGL8huSdiPJohTqEaUzCPcnrquOszbsYrWJ2vVMn31jVDMX0yccv0Xw7Zxnkq3hHFXuB0
	 BqQs0XdDXSR6Nv3BHog4EwrDs8Aun5vxEyzDu+BjkMWMIyBrRL+8fpr2Dbk1kqUxrAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fmU0ZcVh;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1493606A31C
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 13:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1493606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fmU0ZcVh
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a05c820ecbso3535691b3a.0
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 06:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792503571; x=1793108371; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YVuH6pbzYAqeG9iP/8Zmro2Blf6sH5I84xRb+j7spVo=;
        b=fmU0ZcVh8Aih620NGEqDAw11wPgtvMOIQOuJ/iL2VxWw/epULVWyVfUII0d3qHLUX2
         FxpXk23Z57zsAxnRCymuKfzsBOVY+a3ys9z7ZV0vJFLQeHNms3I3016NPqXSEGfqPGfX
         qYtOeEKALd8gEXWXTQ4vNg3aXpH3GptZxcYBAV6s0Mjq5hRBOJi5TjpQDvR5FXceaTJb
         v3iaOnrsPF9a5YvkC7BpJ47fb5fCWb7yMK9p8Wvg3Q1s79E95adZ3BAa680SgmUoh7JF
         gKiVUChU8yw1KdxfJyxi+aOdrK2Krt3I9lK6uAxpEZsM0jXGwdOCUMBzWAMwpJOq5QuG
         RO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792503571; x=1793108371;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YVuH6pbzYAqeG9iP/8Zmro2Blf6sH5I84xRb+j7spVo=;
        b=HeF9w57w9xz+HIALU/hnI9NXEq7EK35PhHZcIUqEdFkVqSGnqyTQ6eRZMXnugLtVLW
         O0x1XCOWJ0MGW6U8ws3ezmEdoqGGMH2ob5a/3sxQ19ck6l5XPGKz80OgJ13C5hEg+scz
         n+oe2mLgaV5NNiEre5ONvH18K+EyybgVj0htKmLWZisCqVcjBUhMCde4hN5B5Ch2QRWt
         HihbQTP0Aadtj/aoSjnMMgfrmkOMPdIu0YNunsz6UjPlfEEqItEsmBgUUovYn2Izxz7k
         CbY0vpACRcRhP+mHnMouQWKesP9g2HUOGjcLJAGGGaxWQgcv8CSl2i1rbmhiKRHu7YSc
         ZpKQ==
X-Forwarded-Encrypted: i=1; AKwUvBytDp49yZSQ8WQAxi7zQA51SWyRhz+OlVph59jqFtXtZ3Ho6aPW+cc0pbq2a0mPUIwp3+E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLW2vptwAk4hkaxJ55cCcE7LaoGISRf4k/nO/fv9AAE9A58uT29
	ZD+KCFY8cGWRMJ6bIFWoqwLEybvrsjQe2y/7uuXiqDtlnM6aCpMHe4E1r2ng8y92BhEQNQFtBEM
	IMLyMkg==
X-Received: from pfbgc8.prod.google.com ([2002:a05:6a00:62c8:b0:8a0:7c0e:8263])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:429b:b0:8a0:1889:9685
 with SMTP id d2e1a72fcca58-8a04be2a1a0mr7544270b3a.28.1792503570714; Tue, 20
 Oct 2026 06:39:30 -0700 (PDT)
Date: Tue, 20 Oct 2026 06:39:29 -0700
In-Reply-To: <20261018115222.315090-1-pablo45154@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261018115222.315090-1-pablo45154@gmail.com>
Message-ID: <atdvEa033Z67gym3@google.com>
Subject: Re: [PATCH] KVM: x86: Clamp guest MAXPHYADDR to the architectural maximum
From: Sean Christopherson <seanjc@google.com>
To: Pablo Azuaje <pablo45154@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eugene Korenevsky <ekorenevsky@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Sun, Oct 18, 2026, Pablo Azuaje wrote:
> cpuid_query_maxphyaddr() returns CPUID.0x80000008.EAX[7:0] as the
> guest's physical-address width without any sanity check.  KVM computes
> the reserved GPA bits from that value, e.g.
> kvm_vcpu_reserved_gpa_bits_raw() is rsvd_bits(maxphyaddr, 63), and
> rsvd_bits() returns 0 when the bit range is empty.  A VMM that
> populates CPUID.0x80000008.EAX above 52 therefore makes KVM stop
> treating the upper bits of guest PTEs as reserved: reserved-bit fault
> checking on guest page table walks silently degenerates, and garbage
> nCR3s/PDPTRs are accepted instead of faulting.
> 
> A MAXPHYADDR above 52 is architecturally impossible on x86-64; clamp
> the queried value to 52 so that a buggy VMM configuration degrades to a
> (very wide) but still meaningful physical-address width instead of
> disabling KVM's reserved-bit accounting.
> 
> This is hardening rather than a security fix: the actor is the VMM,
> which already owns the guest, so an over-wide MAXPHYADDR is not a
> privilege boundary crossing.  The motivation is correctness, not
> containment: a configuration value outside architectural limits should
> not silently change how KVM validates guest page tables, and clamping
> keeps the degenerate case well-defined instead of subtly disabling a
> whole class of fault checks.  The unclamped read predates the
> introduction of the cached value; no Fixes: tag is attached for that
> reason.

Unless there is a danger to the host, this isn't something I care to fix.  As I
said here[*] and in many other threads:

 : In other words, userspace owns the vCPU model, and for good reasons.  KVM needs
 : to allow userspace to define a sane model, but with *very* few exceptions, KVM
 : should not try to "help" userspace by stuffing bits.
 : 
 : Pretty much everytime KVM tries to help, it causes problems.  E.g. initializing
 : perf_capabilities to kvm_caps.supported_perf_cap seems like a good thing, except
 : it presents a bogus model if userspace decides to not enumerate a vPMU to the
 : guest (Aaron was allegedly going to send a patch for this...).

There are myriad ways for the VMM to misconfigure the guest, and there are also
legitimate reasons why userspace may want to do something that KVM thinks is odd.

If for some reason we do need to "fix" this, I would want to reject KVM_SET_CPUID{,2},
not silently clobber the vCPU model.  But that's a big "if", because AFAICT there
is no danger to the host.

[*] https://lore.kernel.org/all/ZQ3Z25cu5gnsedqr@google.com
