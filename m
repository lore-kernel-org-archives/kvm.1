Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB71E4A3F35
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999575; cv=none; b=jZ20icWZS9BRANkxO//VpOWUyskLv7gS5dlllgLKbOzgJVyT62mdUOvCXUD4gqcCnrhM8aadj5SGQ8kHm8K3y2+IFKzF/VKKuqzFSE5FsnFjON6DGeGMVYVQxs2ckbZvINvIf7hb0x3cG81NBbr9QAI/wWs7+ZyLRPyqJ5Vw6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999575; c=relaxed/simple;
	bh=BsBZnoxbbKq1suIDWVmF1JJHJzf7YBDwbEkm0uAUQRk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sfvgn9LIddZdqGY4phvq6DSbkSP4Gh1KOF9j4QC6VBDY/lWUUk/T7k6PnUgcibZ1MwROJ8QCbrwf8EW+AaF1q2K7NBBjimY6ZrWb83MQHp7ZFwlzJcVf5qUg0yCOagNNF+AeUUGlEm1xLhaEVOWtPoOestjm7U3r0IzZxi3crak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZH35jzf9; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZH35jzf9"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8696b921ac0so4721722b3a.3
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999573; x=1790604373; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LfkcibDbvPwEwIV5L6JZPa4fCG3Ys7MAQp2YxLFKsNE=;
        b=ZH35jzf9jcB3R7eIkdE3VTJTw8BzOXY/TSRbiSsnug8FWLzppZ95IpzJAPE2oaQrr6
         oK1nOhYANWbCZmXSsbukBnq04kQaj77MMwmhg4gE0HgfIj+g3a7hXRWIfq/Hzi1Rp4Mx
         1jo+gQNwzphj5v5TMchPFPkLQ0rGrzkimJXK/RcEXzMfX0DW5cUEKjYJHlQi9vGyZU6J
         2CIW0uM7KYMAid6EOv1ppV7xCa8Tvw8uCkN1vLpdZ7cBgnH2iJIEgyJD+tsB0fNNJAf4
         VDasQzSS0Y8ndUcpBhH3eCRzBqQFWCZZcDZXIvAqJSVmW0TldZ+TDi+fSc+AEPcr6HDm
         TdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999573; x=1790604373;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LfkcibDbvPwEwIV5L6JZPa4fCG3Ys7MAQp2YxLFKsNE=;
        b=uhm3lfUgmwtSrEOYYoWpQGizk4kAkYDvPARwDEihLwNhKM2dTaaJOE27ZPiNFJukVD
         rRFotvSK/9fvvCGWxKvBnQvpTxBCy6vlDy+qoE+F/4HXct3CxPmS7zdb6CTtx+fnqkKn
         /hj8qTG+qGlBe7JzcFr6xhxxNmt/kQ08PpjxGushU4carfHLthz47eNILrIaSSwWrXel
         A7eC1k4RVHWddreYtGCk05R2RiHtpJSy2J8tzESjoyaKVhC6KxrkVwwl2Wh2Rg/gDP68
         jWRlfeZpDJooT1B5qsE1sX6Uik0/tf8hQNcQCFNyY0RZOUHb1FzJTyeN6IOzDWLBSH90
         JqBQ==
X-Gm-Message-State: AFuF++kDhovkdWZauup/ADhxzviAoYXasX/LULHleyG0p7eVadT2Q6T0
	1T8LpdvOx8YqCrog7Y8pGoyYpjOwzttOjaeyU9hPp5NWBIPpRp8mUk4EwHEhNU7h9gDZkidjtKf
	EC0ladQ==
X-Received: from pgnn17.prod.google.com ([2002:a05:6a02:4f11:b0:cc4:a477:43cc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d86:b0:3dd:a006:ed93
 with SMTP id adf61e73a8af0-3dda006ede6mr11000416637.41.1789999573086; Mon, 21
 Sep 2026 07:06:13 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:10 -0700
In-Reply-To: <20260902232028.2767071-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902232028.2767071-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999880807.740627.10732799189062157932.b4-ty@google.com>
Subject: Re: [PATCH v2 0/5] KVM: nSVM: Disallow bad L1 EFER for KVM_SET_NESTED_STATE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 02 Sep 2026 16:20:23 -0700, Sean Christopherson wrote:
> Fix a bug where KVM allows userspace to set an impossible EFER for L1 via
> KVM_SET_NESTED_STATE, which ultimately can lead to KVM misconfiguring L2's
> MMU (yay, NPT!) and overflowing the guest_walker arrays.  Then, harden the
> MMU against similar bugs (hopefully it works this time; nVMX also had a
> similar bug, but the "NPT uses L1's EFER/CR4" wrinkle rendered the existing
> hardening useless).
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/5] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has EFER.LMA=1 && EFER.LME=0
      https://github.com/kvm-x86/linux/commit/5dc500a354cc
[2/5] KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when preparing L2 state
      https://github.com/kvm-x86/linux/commit/1c4c84a643b7
[3/5] KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels than the MMU has
      https://github.com/kvm-x86/linux/commit/115f9405a2ed
[4/5] KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with EFER.LMA=1 && CR4.PAE=0
      https://github.com/kvm-x86/linux/commit/34dacbe7ae93
[5/5] KVM: x86/mmu: Convert MMU walker's bounds check from BUG_ON() to KVM_BUG_ON()
      https://github.com/kvm-x86/linux/commit/47b437b2d903

--
https://github.com/kvm-x86/linux/tree/next
