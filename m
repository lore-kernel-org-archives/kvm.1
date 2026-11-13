Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577964;
	b=0LvCIUzALostN3H+JwNjbNbrwr0HMWkC1RY7wDwr8HGjfZX/BOnlmMTEktUc3kjtjkMu
	 tRuuG3eN4g2cK+u45d05KLNBlMlRJpwXaIliUycxRRIPxiIjvVECmGbA5dAiov+pxCVyh
	 vMFFi+fOxPiLAPSIMTMbtTBRiHpFELyBeGmTMAy29J9DPjBJKubBFvanhsbTY+xJcqHT3
	 SX/cyETdCUwEKc7JjhWVG1b0QittiAwbTnbuEDvyFpLmokEFVAaYNgKuUu/kSk5QjMZa1
	 W82Nn1hIjL7Lj8P9fC57vjgqy8K23B9kH2H5QGK3NnTEwZLTuqrUobc8hxFCehW8n7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=xpuK5nOfiHWiGjl4bvVG9J9UfJEXUtj8MkaFIMn+oTI=;
	b=N03ln9JuB8oBiF3Kknb09zGCyGYWx8UUVBoSc7GFDX/y1MxWCUhfr+m5F07fyLx0U4pn
	 mgykDWdHXVPtjaZ0erExhNekCo5IcxhZWv9zi0QFuyXoukEk517EeMbYxl2nLg7AZ/F5S
	 P024jVKMVkOFIEjU9Mn56v1V9Rw7nK7f+X4aDWS37O1dAQBKjNsUHcViO92zbibn60Evg
	 5AYvWKNzFk2ANdHGxdtMxjveggdfNRULcZX2ugV8+/cZ5XVKsxIBhQJHjHPZnoJerGBYM
	 rS4N5noVBGiZX2qdtAfJ2p6WP1MhV00Ce6GwEjw+IKyE1ymzI6ydw97940tiHgOinsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o5EeEkb8;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91FF6074116
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B91FF6074116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o5EeEkb8
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b647bbf8a9so1260195b3a.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577963; x=1795182763; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xpuK5nOfiHWiGjl4bvVG9J9UfJEXUtj8MkaFIMn+oTI=;
        b=o5EeEkb8onlHxOn5Z4RoNud0FrJD/RiS3hA5MaTQnaSfU6kax4thFsUU9WkMTe0Ipy
         VfHQgeeyOryj1dpSbqEsU16sJM+IAULrxH35NYq63NBC9QVxrl78Z/OGXUMacPPRllpr
         jlxQvuriElKyAz5Rf39CIQMgeMw4p30nBMpp8GkR23xj9zZf0Cyqr3mmulDVezCd+0Ef
         YzihWnqYvWVk2wLsm3nPXePAlSPlIiL3ub4JLPcq+3jTCkFdD707DgCCcrspVaiwITpC
         dyGNQDiVVszr2zn8T5FDV+U2DL+QCkb15d4OzZPxZEp1mPCMZAFQHWmqz9Y5/XZ6bs20
         yvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577963; x=1795182763;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xpuK5nOfiHWiGjl4bvVG9J9UfJEXUtj8MkaFIMn+oTI=;
        b=yyqxya+v/n9iO3kGhCTnx2F24aSi0JExC2rFah+Q4L6t0PTuDJm4Z4K+4ZLJgpmbQd
         hjUscktLxn8xXNPeL14hTe1KbybqklKaR3No4nLDW+I/c+6c08uMdZ47oskVw+wvXmPR
         zr7hwqkLwMiF0o89oO4uKwonB5CJXR/DMohT8VH2UdR3JTSkvTNfU6df7x9px8EcqOKp
         N4PE7UDFip1hUf4zTTfc0Mgpk+QV725QpsI/P1CGb/VFQN66hFj1gshhsSTbQABqCTfB
         uW83YYAI76Ngon19a7iOVypzbqW+QB+8JHOrDaMJzesbsk2ggZe85f4YqWl5GQGg3csQ
         OgFQ==
X-Gm-Message-State: APuU4Z9FPdnYtlwkX7jstLoz6SakWt1bHWUA7hJYDR1nnRgtGiLfavxt
	BA27Uz6JlnBL8gUX2kIGTSEU6ebd0ugwbyZAZBPDqb/IEXPzztuKc9xgIvWsjMyMRGOyGMGYMt3
	lV3SlcQ==
X-Received: from pfej23.prod.google.com ([2002:aa7:8d17:0:b0:891:63bf:32])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bc04:b0:893:8a6:3801
 with SMTP id d2e1a72fcca58-8beb6a763bcmr3065371b3a.24.1794577962615; Fri, 13
 Nov 2026 05:52:42 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:37 -0800
In-Reply-To: <20261105190733.3741959-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105190733.3741959-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441816119.79635.11581719704964945613.b4-ty@b4>
Subject: Re: [PATCH v2 0/2] KVM: nVMX: eVMCS consistency check fixes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Manuel Andreas <manuel.andreas@tum.de>
Content-Type: text/plain; charset="utf-8"

On Thu, 05 Nov 2026 11:07:31 -0800, Sean Christopherson wrote:
> Fix two benign-for-real-guests bugs where KVM incorrectly performs eVMCS
> consistency checks on VMCS fields that are supposed to be ignored.
> 
> v2: Properly guard the checks instead of simply deleting the WARN.
> 
> v1: https://lore.kernel.org/all/f1f39118-2e1b-476b-9a84-ef7d56412bdc@tum.de
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/2] KVM: nVMX: Do eVMCS consistency check on secondary controls iff they're enable
      https://github.com/kvm-x86/linux/commit/2e38263fc354
[2/2] KVM: nVMX: Do eVMCS consistency check on VMFUNC controls iff they're enable
      https://github.com/kvm-x86/linux/commit/a90bf96f3646

--
https://github.com/kvm-x86/linux/tree/next
