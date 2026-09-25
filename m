Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2229501F49
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377208; cv=none; b=Vk6q0cALWo155kuRwMdzKHJ6g/zYQDKT5gK2hQucqAQSawoxUdGGDUXyEzuyulmF/RcZeb5jyzW8xQlw/g7z/QrxzN986FHRBQwTb/Qpo/XNpNPv+xNjTMyaZUrnmdfobvsnT7gMrdxdKa1eeThphrqmWrkbguQ99ipEXGULq4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377208; c=relaxed/simple;
	bh=oVPeQELjmMrVUatpXY2Zh1ESbw8UfX879RBaopfMaj8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Dfqp5ZCv8Qbs/XW83GJgEToO2w7gpNuppefRmw709bg90l6uRiMXuoj63Jmqjy0PFtA1rqhpS+sHsVrG4BUWSPjjf32L5zen1OK1zJqUc/9H62b8iVvG7eA9sJU4TO5zuWsR/VCRnvKtVKw1zb9q8PmWIEjN/mwN9DdHdKg8la8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YwjMlhI5; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YwjMlhI5"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db8c152622so8405495ad.2
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 16:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790377206; x=1790982006; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rT1sSckP6p6eW1tHu13LQG6LMd9qhzwtpx1gDdsXPNY=;
        b=YwjMlhI5yxToN+5EHhq0KN9M34lXiJImXWg4/cFYx+lCRkTzhaeXBJNeW0Y/b6r+ES
         NAyJ8PrXkFSNv9rVT+a/0H9y2p2v3QeRYCem9/09IC1nhVqcRrgwyfzEY2PCG81lStTU
         ScVBGtR1rvyEDiXmuQtXGYzO6Cmr4Xvnbt6KSixiQGwwAnm4skgiAEfprSAEobiJMuyA
         gcaA7zrM9zjz0Fyf9vfZSMo3SFrw9OZ/LcN36BESmLorP1Glw74TffhdRwNLALcZPUtF
         Dcsj4Lu1dTRiqKJlh7sPEv/tinczdlEthP3ODL2uqbWYbanGZUoxj/SdCUm37lrExvAH
         K1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790377206; x=1790982006;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rT1sSckP6p6eW1tHu13LQG6LMd9qhzwtpx1gDdsXPNY=;
        b=RcrcIpRkYhxCRri5xqW4ZZbtL7JfPmCx9Z6443Zcy+TBtUlUdyGpH7We1iSDQiExDB
         VefY1UYl45RrYpE2mbQFCgjDE6HCur/zJF7G4aSdZonSz8yGRiMVjxeFhK9r6DZ0U2a+
         cFSZosGFdlJOX8NEj+VqbKHJuL1PCiBny1Zg5Brr6eoU9mTNm+WkWeQKJtMHLLn3nRKA
         0Usl/J4wDPLA7+89aYMlnFPTogg6Jgvo7xLpIozVkOnLKubhsmj3ZA5EXvhtbBC/TjXb
         MOP/yQo4jPKdYUgQaIcz1hq4LdNIgDAYXJdYGHzAbYKqE50Bd0UHlyzbCuTYtawyJiAw
         JjnA==
X-Gm-Message-State: AFuF++kdOSB4SLbKLjHjd4IzBCIz9OJFRlscQaY4SnqBkxzZhKN6MBoP
	OQo6R7+PtxG3nEEYfreEflU8oXm5nbRYC0jcsBFtymrEwNu+/h9dL6MUDEW18Ch+Lb8hyzDjGbD
	ut0Ee+A==
X-Received: from plap10.prod.google.com ([2002:a17:902:f08a:b0:2dd:c160:878b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:26cd:b0:2df:a06b:6b95
 with SMTP id d9443c01a7336-2dfa06b6ce1mr14234415ad.6.1790377205533; Fri, 25
 Sep 2026 16:00:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 25 Sep 2026 15:59:59 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925230003.2362261-1-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 0/4] x86/debug: Add Bus Lock Detect coverage
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Add Bus Lock Detect #DB coverage to the debug test, along with coverage to
validate the semantics of active-low bits.

Sean Christopherson (4):
  x86/debug: Set all active-low DR6 bits when resetting DR6
  x86/debug: Run the "debug" test with the host CPU model
  x86/debug: Verify that KVM correctly emulates DR6 active-low and
    fixed-1 semantics
  x86/debug: Add actual test coverage for Bus Lock Detect #DBs

 x86/debug.c       | 162 +++++++++++++++++++++++++++++++++++-----------
 x86/unittests.cfg |   1 +
 2 files changed, 125 insertions(+), 38 deletions(-)


base-commit: 5ce4dcd089c1729a66cb318c80b06fd84efee38d
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

