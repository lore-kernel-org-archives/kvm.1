Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF61F385530
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528658; cv=none; b=PJBIMDijHy78IcSggM0Uo+zlPQ3ZcIMTHY3c2br3DUx2kzDJPnqolrf5agXnLNcsHB0gsWrVYZUR09c7VQUArUd7V5ssuzLW5/TFHWT+zPvJuVN4X/C1Yvqj1QTVJZ+Wk1RgrsQLO4FKuJQFg1Tjumfm1Md2d5z9CFao2++Izjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528658; c=relaxed/simple;
	bh=0YJ+Imb6MMLrpHArDPEdRZTyZvm5JMEt63RJIStma/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jdwVqQfuNUjRDBJAhiNyhoyl1EINP7uQmuNZ1UzIk4gE0YeAKqEjNmo+Npu8vPE6MW9ISKiwPrIFdI5cMpBCfzJ/K+XJXz083h6UgkjxAW57ZGhOB4wCnKnH0gY/iYClBnFXI60FamcA5jS/9Xz+wa6fP0lcWXdpajlFoOZfPM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQq2CcnE; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQq2CcnE"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e6d253330so1555275a91.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785528656; x=1786133456; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ug8EC72oYv9Uk3S+lb2rKIVYDWGcSfJv/EsBvS8i0c4=;
        b=cQq2CcnE4cfQk7ru2zB/CTeEl8Ltx5FPkIaxBZtHNtqybIKunoAoMG9q/nVESYsQsl
         SB4QmaNyqnOivN2k0QNGmhD3K9mpSnFBGa0k27p+FGOAyYHusngCyc2Sva2lLeti5JqY
         j4Vj/aoZ5hKxup70tmyV+/advHPw+TYOIAL8dGxm3YHle3EuecCRGHTZxWs+Rp5cIlNp
         6oSBhrB8u8IZZuGaw/BD9l7AWqkJpu580bZSyXzi6vz5frj+5YCH2eH/SKfiPfhhfg5P
         tqCMi9g678lg9nJoTcm6v0OpQiWZ0Q5zmNs0QvuOul1LCGe62ngeIQLFVPUw1njlks22
         KDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528656; x=1786133456;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ug8EC72oYv9Uk3S+lb2rKIVYDWGcSfJv/EsBvS8i0c4=;
        b=ZZOgQBF/wOtaRbiO+FlMGDW8BeUoweZc6/IlxfMH48ChuLOhbkByNOKR3HyTTQJr4e
         Zt2dAEVWP4qaoioYFJgQ5fpeLyW87V0wxBy6FnKntfobEgsLi6PwbYShFoxXubd3da9E
         dcIQR9t4XiQzc/w5a3qd5usYccPy3wmifTRvq6r+/++s15bmiafP7oZNpEB+U+/osw8u
         TbyFs0ZqbltJFLnluTLWt45rhOvSx43H5XvqlJP6vWJqNk8rMgxvWNrrBTzm5nQU5cCz
         U1EyyY/oWmikQVj5sEOJnpt14kB9RN6ssdU0zfSXaC6+dnzdPqgcRSgDtWnA5Lz485gV
         oSjA==
X-Forwarded-Encrypted: i=1; AHgh+RoIpYJJjcmyhY6+ZwhxE1jAOr+6HOjJQxr/OWLF9wW/02LC93DwFqSjLPMLSsnHOJAxQjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGHE1RFzkQMa7iHNKAcm/TIicKPbX7jFD6Jr+ZqOk3LbUFfMV
	ik1OVzgseW48OfhzqJLkrfzBAGn4vgRKUDUVwssDZnyfWZ14Z1kWYuny5mIqViFcGnn24R60Qfb
	BupvbxA==
X-Received: from pjha5.prod.google.com ([2002:a17:90a:4805:b0:38f:5ab:e679])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17c5:b0:387:d5bd:622f
 with SMTP id 98e67ed59e1d1-38fbcae2162mr628087a91.18.1785528655813; Fri, 31
 Jul 2026 13:10:55 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:09:58 -0700
In-Reply-To: <20260713180153.2728382-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713180153.2728382-1-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <178552843381.2713650.10861326020016504900.b4-ty@google.com>
Subject: Re: [PATCH v3 0/2] KVM: x86: Fix missing EFER validity checks
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 13 Jul 2026 18:01:51 +0000, Yosry Ahmed wrote:
> v3 of the EFER missing validity checks on KVM_SET_SREGS* fix, split out
> a larger series of EFER fixes.
> 
> v2 -> v3:
> - Split out KVM_SET_SREG* fix and selftest.
> 
> v2: https://lore.kernel.org/kvm/20260706195413.1966458-1-yosry@kernel.org/
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/2] KVM: x86: Check EFER validity on KVM_SET_SREGS*
      https://github.com/kvm-x86/linux/commit/184bd464bdb6
[2/2] KVM: selftests: Extend set_sregs test to cover EFER
      https://github.com/kvm-x86/linux/commit/e43a21553ac8

--
https://github.com/kvm-x86/linux/tree/next
