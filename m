Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1803A2DECBA
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904210; cv=none; b=WXpYPw+lwyxn+WLvVpLWbpFQv4TglmLeBxHbd9JK4ihanEFnvyzaEDH0j4VnIO9AuCHiu3eNGRCdldkEJX8P2QPOo9AmmC8EpvTX93dR+vqFch9i2Tw5a/l78eHc8evLihNmuybajRX9/nYIHnP0N7+aSYEnAK1UooEk8vDZWDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904210; c=relaxed/simple;
	bh=1BW7r9KqtnIFi5kuh51qWD66P5FNa6siBZkCD4Jlpgw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kQV+jeXdlIm/2kz2xVAhxkw/E0zN3vMju7PjYhH020sUxCVRFKRaT7Oe99vGbj7/qkCAS1LLdNe0+xEiZu99dfgCEfpovcxadfjQDLbFiTYnqGn413Sez9tTpv/9Odc5af5mxG3qTR/fQUgqxeZeU2afdOyPTv7+/SyjASRx9eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mw288/9B; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mw288/9B"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-366122e01fcso11426237a91.2
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779904208; x=1780509008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qTKqrTVvlKxeIIRWyVuq2MiHyfMURoW7pbpRw8A7Aiw=;
        b=Mw288/9BgSmSGvY9DYTup0xPgG39W8qZXz2D7ZspDdjOyjsB6aZhVn64k1dRR81OuK
         aMV3GnxrVcdWU1rXb0NDqzlXHLgNewous9GGVrVv6GuD1N4YJAktl9ch1Fn1u13FtMKQ
         WZ1YgpBjjGBXOUFt4Ts6WOxzZBNDC5wO42W71rkx8uexyK0+A6a/1ooU4xLJaFFMSUW+
         FD17NuCrLkN0Lywfw9/AHLMohk/VOoZNL9/0m4PXf26O/G/cI8X1JXeZXaFIX2bw5Lor
         deUXprNgC0L5fEnnlyTZLeL7b336TXFbUOu0xqeQHv/ZEE6yVEWBmbxndh0vwFm4WRd2
         LYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779904208; x=1780509008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTKqrTVvlKxeIIRWyVuq2MiHyfMURoW7pbpRw8A7Aiw=;
        b=WLV6ZPd0Pz/cwRo83Lvuvr7P/YOfBAEDs7NMNUKs7BXvw7YEdFd5VMR0cf/zhcrX0Y
         CU6tGlYYRTmxFuRw3HUrEw8ASVqpr2iCuAFJg+zu0ZF0h6X4HKCGeA5gZFOp4lkFbrh7
         elD/9bokln/D6Jt783WFDiW+MVtq3oF4/v9IYDU3JXPJ4HrUSjtJVdLu+mruIEw6H69S
         IjQ5jC3w+1EbBqlDyVvIBuutQje+yarJOyShQhl6/IX8BVfVcGoxoivaw4mcAbUQH+Uk
         0Qc3Y9XCnrSy38M2yaMNHU+PaJkE2cMfa57ifq4n8M/kIlOTF21LImPqkp63FnhXJjZi
         mTOA==
X-Gm-Message-State: AOJu0Yy7KUCdA15m+io17Lfn/xkterc3xINWnvL+oJhmpZFy/hYJXJHZ
	f2lpymT9xLYq/XigVxLv/CCG6TlXhE/5/MPEXjbZnfVpEYfMiwvL16L1M4v2eiRVMIYGyjOjw2s
	QorfnLw==
X-Received: from pjua3.prod.google.com ([2002:a17:90a:cb83:b0:369:4e8d:8e72])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d2c3:b0:36a:6ac2:8bc8
 with SMTP id 98e67ed59e1d1-36a6ac28c1emr13071593a91.14.1779904207799; Wed, 27
 May 2026 10:50:07 -0700 (PDT)
Date: Wed, 27 May 2026 10:49:16 -0700
In-Reply-To: <20260514211510.1630673-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514211510.1630673-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177989674287.4072527.76629190729560025.b4-ty@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86/emulator: Add testcases for ENTER +
 emulated MMIO
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 14 May 2026 14:15:10 -0700, Sean Christopherson wrote:
> Add testcases for stack pushes to emulated MMIO via the ENTER instruction
> to validate a pile of KVM changes needed to fix a use-after-free due to
> KVM referencing kernel stack data across a userspace exit.  Test that ENTER
> is handled correctly if it splits non-MMIO => MMIO, MMIO => non-MMIO, and
> MMIO => MMIO pages.
> 
> Opportunistically add a comment explaining what the collection of pages
> are used for in the emulator test.
> 
> [...]

Applied to kvm-x86 next, thanks!

[1/1] x86/emulator: Add testcases for ENTER + emulated MMIO
      https://github.com/kvm-x86/kvm-unit-tests/commit/20693e433cc1

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
