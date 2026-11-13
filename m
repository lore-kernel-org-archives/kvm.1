Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577954;
	b=eGhBYWPs5UPTk7rZx+XeEHmL6hLxyaOfcaEL2vBkDM7LUwCu4EC/CtQEKFTOl5mJ+n27
	 AjIVIker/yhwCmsmGJACaICieWtMJSOZ5XkIt2CQKGzPbWMIvB7q84LtmvsLen6WW6JCJ
	 /PMOyeGR4UbSBvOxHev/nK3JGTumzQW3JXwbUHjWQaHYmX5PXpZd1HB+BViK5F2WV8mE4
	 pylshGrHLEGFfAtYIaZgiA8z74L7PvMGuHe/2p5IoWFJdzZarYRU7nGPo+BpL9cwGh5Wa
	 rhxeRRGzk/3qJO8Vpj+jD00E2t8Ty/w8VsR3ke+otynbHcBYbaxjBnXIe9oxc4LWvlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=o6rNxavkVSPGD6OXC5QlYB6spVgGCDdLKxziIS1EaPg=;
	b=3p4m6uicNIB3xpvNqyy5cHvGuiwNJ1GifUx4RzrcA/1RepeFH1Nr3h7XhJ9+QPeprwlO
	 bESw9UVZ7RULUd+T/TwgT04QMsd9+Ki3LQRKnIwAiZgXwEZJ1r2V85YvgsQ5pcBxqW+yp
	 +RtkOh8JuthI5WKAo9faKml7QXtRQDeuCMS77ToMGvgs69K3KHfe0lFQw93h6rehMzof2
	 PY4D1Ba2dqUjZmTQgFCWSjdFhxHKZc7qqVdPFRtB7RN0jDl1XJ4MsPnDj3rMZQ57YJHLj
	 KnSxEd3ZfybbMwpR4E2kuRSM2Aw1NeovN0aSITm78Ix0MAPx6xoJERsVn5Ls3IBF7mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZTJ4mr1d;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A393D606E0C8
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A393D606E0C8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZTJ4mr1d
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b175a69ab8so1469476a91.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577953; x=1795182753; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o6rNxavkVSPGD6OXC5QlYB6spVgGCDdLKxziIS1EaPg=;
        b=ZTJ4mr1dVqcq1v73DSTZKzsy/Yocu/xyn4OjwBRY5OjWoByLoi+loB3b/JXDEyhGwh
         wLMMYIoV14j4dZxikyfBpe3EplpOJ7GeOGiiGRKLpvYjYhUYiih0nUc77rEvMmnVTGeZ
         gbNmAAt1mOjUM8FUSKWWReIM8mtP5T89xQq5EkB3YCLGzixnp/+Q6IhdN1VATWFcvyNZ
         OiHJvqw29MLOKu58Iwd1pS9xxJu5MPCprjo6hWLv7jTxo5lQLsUsl51Ttjk9c9tsFImF
         tIS20EfAPafTvuxCRP9HiTfSg+LZeSIDDBOeT0fDYsXFOidoQiQoJYlnJzte4ou4MMxT
         yMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577953; x=1795182753;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o6rNxavkVSPGD6OXC5QlYB6spVgGCDdLKxziIS1EaPg=;
        b=0j2toQJFuUp2hvMg+mQDZgJa9zh6R77ysI8uQbfaJeTQRdHNZa0G0cB66JOK5krtt9
         BV8sn5KpLiaCkZGR1v0ST/+GH9OR5wcKrVtVCgIOasvvJWzumgZlcrQf7EvOZpAdF1Be
         WdrxG2m5rMS+OlCCbE2buQd7gKNQL0jkLDKd1E2RrIyMHSff0QEUN6Qv4LP4+GYLblDg
         NpRcRPtHH2NXu9kkpDQPMxZX+rdzRM0C7Sp6joVIzuWW1cUGcH5w4x9kUfpbQdsfzXIM
         3fuDPBTZCaqbA8pjHeCFt/uUJaUYLH2+tOgWpUg2BYQXag5msMmgv0H2rRaI0veuIGbK
         M83Q==
X-Gm-Message-State: APuU4Z+7HzvanZ6zFr/0OVyb7VXdqrs6wKxWqz/bgEyskW8Soi1ZhV6k
	vspK7QP9vecQmgINVGeVBQuRB2CHqn0SaiPeLAAv3+L4CFQ0G0IfN7aDGZdliHwudQq6Z4IwIbj
	88SJpPw==
X-Received: from pjuv18.prod.google.com ([2002:a17:90a:d592:b0:3ac:a379:dc7c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48c9:b0:3b1:21d9:4c3d
 with SMTP id 98e67ed59e1d1-3b1b0cc8744mr2610201a91.39.1794577952603; Fri, 13
 Nov 2026 05:52:32 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:33 -0800
In-Reply-To: <20261022202734.592745-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022202734.592745-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441776265.76316.16672462680333919952.b4-ty@b4>
Subject: Re: [PATCH] KVM: nVMX: Nullify cached vmcs12 pointers if entering VMX
 operation fails
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset="utf-8"

On Thu, 22 Oct 2026 13:27:33 -0700, Sean Christopherson wrote:
> Nullify the cached vmcs12 pointers after freeing them if "entering" VMX
> ultimately fails (because of an allocation failure), so that if a stale
> pointer is consumed, KVM hits a NULL pointer dereference instead of a
> use-after-free.  I.e. crash the host instead of providing a potential
> guest escape vector if KVM is buggy.
> 
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: nVMX: Nullify cached vmcs12 pointers if entering VMX operation fails
      https://github.com/kvm-x86/linux/commit/7597bc333891

--
https://github.com/kvm-x86/linux/tree/next
