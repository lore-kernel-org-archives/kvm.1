Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515D12C21F7
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975499; cv=none; b=I6LMTfan4j0IM42KqDAqji5qY3cWGEHwoPNDcXz8g85kOoGDV+/mnZdc5T+x84IOqw5IElElQhWNxdpqSZJWvUKXS4e5ewjEou10OD/+JlfXwH+0YbcK3fRFyA3a6mT5y3kHXcij7SAkXwwwB+Nl44EseWVzV6HgUO2UVSu+qbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975499; c=relaxed/simple;
	bh=SbeoSzc8717QD/IqpcZd0l46LWnbezvyajiiws+1ApY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G4VSDCCsKfvYdDucGPj8XWT/RKLkqvFfOOiaVWJ4Y7R0TNlgO38wgl79KNsypmV255vrw68wKCjKOHVLICcfLawTbc3Aa9NtrtDrAi22LmcLw6ZmPj9j5By072bh9lzHTnIoFThpeGhQXkhehwjnLrPlshkbPhYQiimSb0dvDZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oFV2swOR; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oFV2swOR"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cca35cf9f77so12755a12.2
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975492; x=1791580292; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wShwsJKvODsiktjEQtwHrAPB94R0KVRpk+BGj5cEKBU=;
        b=oFV2swOR/Zcywc8myCyZ2GnQmITK4lzFf4CizWfJzJZ3x7DFkCVoPPRvQcZP0N8jCp
         1JP8uv7WfZzK5sBU64OofXfEExyLrLaokCFB6h1ibJeHR2GEKPQhKOJ0RxSwDwuHihyQ
         V2MhfnhcGYdR2CrObdMIPG6GGEUuUxUU5tpzXNWdDoOmzG88SIz4PDp8aUVvrM8gRxT/
         AouP7CiKNU99kIuLwaMR6tVCIr3r9G4/8YcUgQ4GwY376LpBff4pk5fenip+js6R6kf6
         UYh1H7b0dpRnWNCYbzpZvcfxI/lP/ljxAIqk/xR+NhL4pUeNgLC5fXcFZEbyDvVYIzvQ
         pzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975492; x=1791580292;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wShwsJKvODsiktjEQtwHrAPB94R0KVRpk+BGj5cEKBU=;
        b=WJYV4rtmmi0PnXU9IUvviIDSM58LlS/sA3oy/d1KpwsSdy/UlXPkG5H45Bdm57O24D
         lohO4qexGUJv+C+YonaJIxo0lru4sBq9TfTpO6B7rJCxAlfInyfrTsbt6nMq2Sgr56KT
         Dm7j/8fjgBUmifkY8e9YDs+mw4qvImCMLWWp3ktkiZG2n9tlkMX6R1wdn6T4ctyjrpcb
         0oEWIpnOHvjDQ+HPORYH2YTA7GT2IKdl+iRn5id5aYDkiMQ0IHUXwBrGMmQASp8I6has
         JHIDF+YeNxQhN43+FW/LcL9cIoz0rXVRe4x8Va34QRxjH00J1DTym3Easq4RYRQ1Gync
         2kzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPkNvY2z5UpD5k0ilVqEMoRH3v+Py51fDcUPfokb7uDPOfiEcezN3lgxVvrLIMemjSqEs=@vger.kernel.org
X-Gm-Message-State: AFuF++k14siMi0ttQWivtslWfSdFlo30Ull7mnMzRpVAxI1S5ml3WbIi
	zsMRU0tiW1bMkIMNm+k/7fk1kD7m9P3yN5vUCXcVIoNEyq0X8Tm4dWf9MhBhjqpVC8DpnJAFlaV
	30lpsZg==
X-Received: from pfme28.prod.google.com ([2002:aa7:98dc:0:b0:885:6385:6167])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4516:b0:3de:61f3:33f8
 with SMTP id adf61e73a8af0-3e0bcf64e6fmr3964720637.43.1790975492097; Fri, 02
 Oct 2026 14:11:32 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:34 -0700
In-Reply-To: <20260903223258.486034-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903223258.486034-1-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097499601.4081097.16696339000915079689.b4-ty@b4>
Subject: Re: [PATCH v2] KVM: SVM: Trigger new ASID allocation in both VMCBs on
 pCPU switch
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 03 Sep 2026 22:32:58 +0000, Yosry Ahmed wrote:
> When the pCPU where the VMCB was mostly recently used is switched, reset
> the ASID generation in both VMCBs, triggering new ASID allocation for
> the immediate VMRUN as well as the next VMRUN on the other VMCB.
> 
> The ASID is shared between vmcb01 and vmcb02, and gets flushed on every
> nested transition. However, since pCPU tracking is done per VMCB, it is
> possible for one VMCB to allocate a new ASID when migrated to a new
> pCPU, and then the other VMCB reuses that ASID on the old pCPU. This can
> result in the same ASID being used by multiple vCPUs on the old pCPU.
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/1] KVM: SVM: Trigger new ASID allocation in both VMCBs on pCPU switch
      https://github.com/kvm-x86/linux/commit/bf260dc9e7b8

--
https://github.com/kvm-x86/linux/tree/next
