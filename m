Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577776;
	b=M8WQ+ET7hLhV0VSQ9GBx7UT+HRLyznf7xC881bRfJuk7GMXg/ixiHzzQS4+2bGYmym8K
	 qG1zhRmkrXDIYuqUyZMFAj5ULFoTgizIqjumTlIgYo0xbJuk45LtmWc6j5FSuoOJgFfk7
	 k7KUO8FfBVWeTvmywOJGsyQ/W/uKg9zcOulmMZDNvuinaNJ+4dhrZhU+JzOHeRJrVudt5
	 ixL5MCCDs2Ie2N8eC9LV7FyvgrrWjiI6p/aD0k57RxdQBqOcMO2sGdvcTg9qaK4C4HbAK
	 tvaVnYqMF/PL29bjpSC3NARa548AZA5fU1fPrjvw9kNR1bZNPAQVbP9Or1XZoOPR+BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=UMb2NFxmC1W536I+xEiSuulbMCGZAWVT/hJMtcmN9sg=;
	b=yVSk9WREXqm55IzSG9ih65y/RuleKUTKgzmmgBibQTTu7oz82mSF4AvYHBoOvqV0Uku+
	 fZjW024KsRLcqZrTgwI1klePzVHrWlvHlpZNXuNQNJgNStUq6FIAysRlz4Ya1OqOYjExz
	 Zltogn+pmM0lMdpPgpIPw7TkZp+0igvoXPI3J0GmsZKS5IBsIR0PTxD8HG/lCT69k+nnv
	 GP0V/8BAjNiZswVsoLZWt54ic2UuJ+gF9xjn09vLuZOO4S1x8OnLmZv25gvvc2+yXNz/c
	 m9X427bSotR04aM1qdIZbTNJufMM4xzW87Qh7wNNYG5q+J5Q7hTRLTVCjLYA6506kBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bcsW8lDh;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9375606A338
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9375606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bcsW8lDh
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdaf2073b0cso510511a12.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577775; x=1795182575; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UMb2NFxmC1W536I+xEiSuulbMCGZAWVT/hJMtcmN9sg=;
        b=bcsW8lDhGxxv89mDQTbjcds6SoCyum/T2FWzxYNVAh1dSLF5s3XZdYQvnqvnhO4TNB
         SZi0fvC/A0qNxz/6WBota3XdpYPBWUU1yLMDTBjLPV/uQHPQZi+Vv4IA8kyPa5UI7H2z
         9aRTyi2MlblJzowjdJ2M6ciaK1J+x1i9cyq0odZUAcgnO2kbSFW3XUlI0F5pumvQsdfc
         yWdVSUxm4mz5Ur4hn3xwCgLIGFZxe/6ZnLkyI3yk8d0CEojEgaIl/WNioBbFYgShhOVM
         WVZ38/KMWyZfqyruyQv/6z0MSp2hy4HvR4CH6UJDhH0B8JLElm++YpaAo8av0gIlI95F
         9fJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577775; x=1795182575;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UMb2NFxmC1W536I+xEiSuulbMCGZAWVT/hJMtcmN9sg=;
        b=xPV6Eq11NLSHVLj8rbAzI4cbPwqCyLbc/nwT0pBDCVyElPTOR/7cCWwwp9hlnMfzju
         YWxU5qEJ88Drg6m0MGoyhsI8iyDyhSYWXXFFyd4PSB0dFs9t4Cnsb0qOU9G5u/aiUTtk
         e/R2h1O40+SxM59HIwJf05ktn/pb2TdQDEF092PratzKKYRhwVvD7mY1vsrgunkSLwzZ
         HPWVe3tO7KGYNgs2yMZSuze11zNTQ3MIThZFpzbDMTtV6gfKDhkd8qlVGRJKQziSuefY
         9dF8CPzwjJnf9hhLrSs6Dv+JIIioiLyFmkN+m5cxzVeDM/ZV+EdXqKR66WBGMaRcmDCD
         6ZrA==
X-Gm-Message-State: APuU4Z888KE7HV5xyLQyag/NkU1NSp++AKrUw0CY7d/LTgvwjucM636z
	RUI1NEu/EhRdgT9BsWyF8jXgQTnumtZ/y/QcANlK1gFdN4qELZndFgPNtRSX9N9uS/ZUdLKqvIm
	1JgXjYA==
X-Received: from pjvd14.prod.google.com ([2002:a17:90a:d98e:b0:3b0:9569:4e9a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3889:b0:3a7:f4d:b23d
 with SMTP id 98e67ed59e1d1-3b1b0b9f024mr2434653a91.52.1794577775185; Fri, 13
 Nov 2026 05:49:35 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:42 -0800
In-Reply-To: <20261016065729.85873-1-flyingpeng@tencent.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261016065729.85873-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441760468.74868.12150652348243797638.b4-ty@b4>
Subject: Re: [PATCH] KVM: x86: Reject KVM_CREATE_VCPU when the host TSC
 frequency is unknown
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, 
	Peng Hao <flyingpenghao@gmail.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 16 Oct 2026 14:57:29 +0800, Peng Hao wrote:
> If host TSC calibration fails, tsc_khz stays zero: tsc_init() marks the TSC
> unstable, clears X86_FEATURE_TSC_DEADLINE_TIMER and gives up.  KVM has been
> papering over that state since 03ba32cae66e ("VMX: x86: handle host TSC
> calibration failure"), but the guest cannot actually run:
> 
>   - kvm_set_tsc_khz() computes thresh_lo == thresh_hi == 0 via
>     adjust_tsc_khz(), so use_scaling is always true and set_tsc_khz()
>     divides by tsc_khz to compute the scaling ratio, i.e. #DE in host
>     context.  This one is reachable from KVM_SET_TSC_KHZ alone, no guest
>     cooperation required.
>   - kvm_guest_time_update() re-requests KVM_REQ_CLOCK_UPDATE and returns 1
>     because get_cpu_tsc_khz() hands back the (zero) global tsc_khz for CPUs
>     with a constant TSC.  vcpu_run() only breaks out of its loop on
>     "r <= 0", so the vCPU thread spins in the host kernel rather than even
>     failing the guest.
>   - Everything that converts guest cycles to nanoseconds, e.g. the lapic
>     timer advance logic, divides by virtual_tsc_khz, which is zero as well.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Reject KVM_CREATE_VCPU when the host TSC frequency is unknown
      https://github.com/kvm-x86/linux/commit/687fe634b54e

--
https://github.com/kvm-x86/linux/tree/next
