Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B2F449980
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975360; cv=none; b=Sgpnbj/4wZ+qDfYsZ4nnDfITtAn4DGNcSYnAEOWASwItST8IX6yGtaCo+KIZm9Wl9q1636nv+7deyGstRTrLEnakGkVFRYqATYo9pvqknG9JeXL0ChZ7Sfal7YW+GvHX3uwHNCMraKzM2WmCV59ymOQbAH9Nnk63OaUaZcGY+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975360; c=relaxed/simple;
	bh=tCY/RlBxMskON99FWJlblL0Fa7FssjrtmOU1z3zUJd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ar+iiYX1m2I5MMTS08TYEMsuD7/Chd4ZFZmiX1WOHc6Tef4FhV1nVkEsVjyxmQFzD5oK/2zTv2Sh68QnnlTJw3hjWgd0whp60lvv2uw28Yl5ClHAH+PVvyomqtsEiJ/+2JE2okCtl5AmJa4WyB8RAlOxj8Rew+zUk7tq1K1KZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I10pO9CY; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I10pO9CY"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so253931a91.3
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975359; x=1791580159; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JfRigtawTV1xiVSKrBXG4LDPUMAAVG23PEtxzLYUdpE=;
        b=I10pO9CYbW4+KIF5GW1Qw/oY3he1WdlNpMF7hUKU9NNpaDP91ZPmOeIhhDEx0yw9hu
         n+a5pa5ndZ/qzo28uwyJItfP49kuYJRx5BWFfN07oQRVGBZBzlB67u5DXZhVkdlUVuko
         oTxC2Fe9dR8uJ6pdDLWCA2hZ2yeK4XuOkjUfmvQR+nSdInUVPrLW7xE5a4X0DaStXUbW
         VEsFEEOAANV7ifxjkulsRtsji8jpZJ3SpwY7OQH9Y71rvAJ01D+zs7UZ4jb2n4cjWQLW
         a7IeTALTDAQKNfBmbok0qB6lfTe8gQiCwCcG3e6rqDJmec9zOMRjnuOd0+X9D6tKexSw
         MX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975359; x=1791580159;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JfRigtawTV1xiVSKrBXG4LDPUMAAVG23PEtxzLYUdpE=;
        b=MgssyEkxERMZ+9CpW4+ra31+WRKQgsaT6byD5wxbTu5UW/JTTUYasJ+S5tlYre/bw4
         e9rP6BNK8mouWov4I98P5JNSfa/upVrvrL3lKDwk1iAQh3Fq2/Pv/+Trvo49GwT8NNhq
         4jyR0xKdrmXXYBUJ5OLQ/jWDvvF7wC3X69j6AiD7RNA83cuIStjeF/0tAhRtFXOCJBg4
         xQ3T8XfrkIFz1WWExQtDX6v8SLcAnZC/iOfvp+7h8fePeNlmwkPJRmNFdqsXFt/GYlbX
         E7f4jEyn6iY/XywOq5y6Ih6rIF5v7kLZo5Urupp0NuKbAGmKnDtrhT4bnWCeGKI5yixI
         PN5g==
X-Gm-Message-State: AFq9FYJfSYNhuY16suuXBXg5Q6/CEtSmVfI5WHHKxcmBmfRx4R6fQDc6
	mh3gACv1KbsUAc7ptzW1RVXamfHC/JNi99mhYEbg6vejlPMCH3hCohiXnrIyLKUxt7gjmaVvU3+
	aJSYEoQ==
X-Received: from pjqz8.prod.google.com ([2002:a17:90a:b108:b0:3a7:197:5a96])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:518d:b0:39e:6c69:34da
 with SMTP id 98e67ed59e1d1-3a6ce978d01mr3463500a91.62.1790975358319; Fri, 02
 Oct 2026 14:09:18 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:16 -0700
In-Reply-To: <20260925230003.2362261-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260925230003.2362261-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179080255776.3490406.14920675653539341747.b4-ty@b4>
Subject: Re: [kvm-unit-tests PATCH 0/4] x86/debug: Add Bus Lock Detect coverage
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 25 Sep 2026 15:59:59 -0700, Sean Christopherson wrote:
> Add Bus Lock Detect #DB coverage to the debug test, along with coverage to
> validate the semantics of active-low bits.
> 
> Sean Christopherson (4):
>   x86/debug: Set all active-low DR6 bits when resetting DR6
>   x86/debug: Run the "debug" test with the host CPU model
>   x86/debug: Verify that KVM correctly emulates DR6 active-low and
>     fixed-1 semantics
>   x86/debug: Add actual test coverage for Bus Lock Detect #DBs
> 
> [...]

Applied to kvm-x86 next, thanks!

[1/4] x86/debug: Set all active-low DR6 bits when resetting DR6
      https://github.com/kvm-x86/kvm-unit-tests/commit/731af2c08851
[2/4] x86/debug: Run the "debug" test with the host CPU model
      https://github.com/kvm-x86/kvm-unit-tests/commit/7d2f9eee0c2a
[3/4] x86/debug: Verify that KVM correctly emulates DR6 active-low and fixed-1 semantics
      https://github.com/kvm-x86/kvm-unit-tests/commit/2f605826aac2
[4/4] x86/debug: Add actual test coverage for Bus Lock Detect #DBs
      https://github.com/kvm-x86/kvm-unit-tests/commit/eae36be65d13

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
