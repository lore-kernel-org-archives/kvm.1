Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695933;
	b=IrFCZnOzta362sKuVyvO252kQgcHvkSKw7sUJEYDNt93zdDq7Usx3bRxyd8sbqQCxQKq
	 JnuPVUdNR3ORNsxeMJZC3wMCssa6vRIP4ZCXmyBfhyQ6i/WPnRuh+7QkzPC6hOlX9YvgD
	 NTb9UX5DTJcOMH+Clfp3UyOx/GTtk566sShXKZMLsoCTJQL7Bbb9QQgIITM4LjvRQLPyj
	 u5KBuhgWsbRjU/SAZyB43hRPEKlCVGgXqvcHNaMK3V3PRo3kA7i2iZQYAXPpZNblyPPQx
	 AFEzEiyhYSurdyOqadJS7C6wJFgT1sCHIMRVHdYKobByZYy70YtdivWQvKKRxzBjy3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=bSKzXB4NLO5kv40pAwCTXZ306urEqJ2r+C8Y4J7qwDE=;
	b=utFHCJ5VafmTJ4gj6AjlNeMRGlQiof6A8wbwPzktmdaJJoY2tZKX0DH7K0OLSfebDrUO
	 Dcd2AE+WeBS/KrvLwPZ5lB2yhTRk2iPZyD9k+4mC61IfqWS9EUWMmGCZM9k1gU1as7T0U
	 AYrTmfm2HmRcM77xtdIh0cxgTD1LDKXPLoExf4rHOSlH5v8pOH0y2rufgp8ih+JTGayfj
	 GSUDBgw8LZsjb2mm47lpfuwR9VNLmHTdKWUxTPbUv3BcEcsntGIUWnHVGWWOjqHEP769Y
	 cR2yne/xLYcHxEt9bhCI4qXIQJw6gPyOOhnml4BJAKx8Ig0Jc7tie4FLsLbppM2wDng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TTZHvwxC;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0087606A325
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 19:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0087606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TTZHvwxC
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd60a365440so68271a12.2
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 12:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792695932; x=1793300732; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bSKzXB4NLO5kv40pAwCTXZ306urEqJ2r+C8Y4J7qwDE=;
        b=TTZHvwxCeV0S6xd1yoFOXssyFDfpjKTkmry19u6LNCVRbFBmCS6vCAGpTQ34sDuy72
         XaFKgV1e5xA/wEvSKRd8F30qwtcZMoCf6OlKC3KJOtQLn5shcx190SZGjzMks0eamIvC
         LAo1cKHzacz1mV/RZ58HbtVrnJA3LWqzXJtLa5FLJLOVQPfXAzSkdhwtsrl+hlmjK1VR
         BH+/qunKOL141QQRXhKaGEAQXges/qetn4PrwyRR9PlCsIE7H0CSWjXDLkxwsoBgOgwh
         r9fq7PfpavLZSnMqG89j93hNOFYge3nhrJWYB8rqB1/iNLRCzVZ8n6MDIIxFibfO4XSd
         mfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792695932; x=1793300732;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bSKzXB4NLO5kv40pAwCTXZ306urEqJ2r+C8Y4J7qwDE=;
        b=h6egvmRwZ5PhfRmRzVMU7UDCeni6w9OYd0r3MUy2tvR/JZWVolahVOW4gkOaVvttuT
         nVha0PPyuq+GwTLK/awOrjfzabZXv3NQyjb52rjWrWwXY4+FPIHKVDsHmkbQgxmpTpen
         Wb/YJPRCtqdqi0g2BLgp5deJps32KudmqS/t0MWQBg+W/WyFiH9sKqHRAhFiobQJNxgo
         zqo/X6as+tL4KFbS5qA21jdp+dUTco/o/QYFMUzTCkEySUwDF10f/5RvdppW2zbkrOpZ
         551i2nCZHEJbbcKh9w0yvHLizGwsFS41QFrWEzfB76JhjulyNULTQxenWOv8+I+fbBiY
         hQqg==
X-Gm-Message-State: AFq9FYJfrCzcOSk4k2CAhPW91uvfKaCKG3XrXS8Ugmcg1A36JpqoOI4Q
	KqyOG3dJB9Se5JVqSxffRN9gmXkx1aAUi+8pmPV5jVsPCHvxGJaVFNpK/YrAu8MeF0KbiwJ5a9u
	4nQjgAA==
X-Received: from pjpr9.prod.google.com ([2002:a17:90a:a089:b0:3ac:a379:dc7c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b47:b0:3ac:77c8:ac29
 with SMTP id 98e67ed59e1d1-3ad86cd5f20mr4685879a91.15.1792695931855; Thu, 22
 Oct 2026 12:05:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Oct 2026 12:05:28 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022190530.541789-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: VMX: Clear vmx->fail on exit to userspace
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot@google.com
Content-Type: text/plain; charset="UTF-8"

Clear vmx->fail before exiting to userspace to report a failed VM-Entry to
fix a splat triggered by syzkaller where the stale vmx->fail confuses the
force nested VM-Exit flow.  Found on a Google-internal kernel, but the
reproducer (will attach) works on upstream (but only on CPUs without CET,
because it generates a VM-Fail by injecting #UD with an error code).

Sean Christopherson (2):
  KVM: VMX: Clear vmx->fail before exiting to userspace on failed
    VM-Enter
  KVM: VMX: Dedup VM-Enter error handling for VM-Fail and VM-Exit

 arch/x86/kvm/vmx/vmx.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)


base-commit: 164405e8e9a0378c7e1aff2254625a6553a291f1
-- 
2.56.0.257.gf7497c7d27-goog

