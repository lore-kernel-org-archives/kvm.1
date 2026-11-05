Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905656;
	b=Ighmbx0ID71OEwdFfnGf1/LULbT08Hq7HxShj8XwqRXojWxGDzLadjbkdZneo0gN97Ii
	 VvZeFEqWQ78OFmh7gCiXhyV3VBCnUq2sk4RRvMDznjWWeAvaHA4FcHTRDaWA9bOLS8Bty
	 NFwhcowCH455T0whIBTSuNEv7ecS79VH9ORdp8VC6BSUDwI36/XSU5dYr4l8Wz78wgV4X
	 RF5Zeyp18JD4qf/HE6BNDIQNVF+x2GPLcM7IMohx7TyS9nXR+VlsuQM3fYZQCEaSTH0yN
	 FpRNJ1MtL4uN9kmZxOgQbEx5+W8ov1quHZ4rieggpwDtYb2pQO6sX5WDVP7BKkv5e0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=yTiKwXEnXxeIRLFTsm6pyPXSdQ19stWeCj4ZNZtBtvc=;
	b=l1NBPzfPFC+XDB6szKCJhQWjjseG3F/agvkdrrwuwc2HUQ+ZDKLiQmWR9F/9CKru0TU9
	 FaMkY04vm46XhnWKeNB4ZbJ8yTkYnobteC/x56y+pauTGT6KzEDeJxhwrcII68PT0OVJy
	 XlgIrVPxm3mC7eRTWeeaUmbyXB1Iwg0ldo7inbveZAaCgB4xBKBpz9kAP/KGE93SxNgBE
	 aUokhvYtUFSs0akwO7zG2ljPn8laI4QRNhS1BCvMC0xZZ/fNUkv6YtkLvSivWWhi1AYpE
	 0U/Xr8JRszcCJjCk1/D9xMYSbBCgXmcKMAf683RqXWg8tMG3Qnz8/1IYFRCY77FsVvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j556zDUZ;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E761606A32E
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 19:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E761606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j556zDUZ
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3aed1b64104so3054494a91.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 11:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793905655; x=1794510455; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yTiKwXEnXxeIRLFTsm6pyPXSdQ19stWeCj4ZNZtBtvc=;
        b=j556zDUZZLkeXoLhiuhzLJ/REgnxdyh2p2h9Ll+wk9PrrYpw/mvLgYhAb7XcnW3uFD
         Z5PYxbNSsZXz2Y6xYfS4bl3SJxAIwp5EURlwfxs4i4Q5ku1o5HdVJG/A5SXJ5tb2uU1D
         WHfLVC1ZU34LnuPwkKdEpWGAZfX8EBi5R/oObwEvw8kEcP5YpDAqJ8r6bArrrIElh0Kb
         DYYwFMaG5XrWLerOGr+LAnY/PFbGnmb1SoZk/hPx3lQBFVhodZ9WtZl6dYS0nyS7MjAx
         E6/A80KQuiEjMg7qdb4FTPySIYR9zh7Xuanz8kaDizNwPttCmDVwNCQMvjOaFgNCo5EG
         kNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793905655; x=1794510455;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yTiKwXEnXxeIRLFTsm6pyPXSdQ19stWeCj4ZNZtBtvc=;
        b=nIsYkbmVq6D+02nKadrWtDicd2sUd79LSYPRccTD25vcG3/AZjRKwyVS7nCjkbN9KI
         WF2OUsp86QG+pjSmYIz36/XDw+RI59jA4oeYxx5Qt7y4irYT8MsCPYAcU+CqVUCS460u
         l/AyIQpQl46YWlfhg+xO0ETw+kX9va0yQ4a+FmLrlBCu7ckXSS67tOivfH4f/36dFxPX
         pZLhdraezAqtsnzujZ3mnz9OItGEqukztmmAi8OeaCQXGVvVyJhE/iK44XKhyk7Kev5l
         OelbFKZjCUYivo2s0zy+9huVjysClzQnKJFzOSiyTXsUUS8FOUDmxjbMG6o815kScrlr
         dqCg==
X-Gm-Message-State: APuU4Z9ijRkETnT02uPrqFLu2T5yKZ8BtQ1sk0vBOVskp4K+ogSSNTr0
	MiEYEcZfUFa7xyAsjV7KokNlzgZ+MT7kVoL8akH1EP25cVLiXiukjt7vr9LrChABXWT5lJo8HUS
	pM1+SpA==
X-Received: from pgbm12-n1.prod.google.com ([2002:a05:6a02:618c:10b0:cd6:a6ae:1ba0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:390c:b0:3ab:e588:c2a8
 with SMTP id 98e67ed59e1d1-3ae8985c4e4mr17141245a91.64.1793905655207; Thu, 05
 Nov 2026 11:07:35 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  5 Nov 2026 11:07:31 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261105190733.3741959-1-seanjc@google.com>
Subject: [PATCH v2 0/2] KVM: nVMX: eVMCS consistency check fixes
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Manuel Andreas <manuel.andreas@tum.de>
Content-Type: text/plain; charset="UTF-8"

Fix two benign-for-real-guests bugs where KVM incorrectly performs eVMCS
consistency checks on VMCS fields that are supposed to be ignored.

v2: Properly guard the checks instead of simply deleting the WARN.

v1: https://lore.kernel.org/all/f1f39118-2e1b-476b-9a84-ef7d56412bdc@tum.de

Sean Christopherson (2):
  KVM: nVMX: Do eVMCS consistency check on secondary controls iff
    they're enable
  KVM: nVMX: Do eVMCS consistency check on VMFUNC controls iff they're
    enable

 arch/x86/kvm/vmx/hyperv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)


base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
-- 
2.56.0.567.gdb80ae8cd5-goog

