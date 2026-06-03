Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B65271456
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528749; cv=none; b=mPCLALnkHBvOYSK7MjosAZwCkXMdhaP8RabQ8KE11uHaM68YENeEihl8s+RjUqSm5gjnkGskWDHaEFq9PHpOeorAPQ5/6w37BxMwMbTjNRtqENNHhiR/8kOERWXkKrFQhv9K62A1xXM+SDsh6Hixa7eMn7odKuixTzuzFp3lnVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528749; c=relaxed/simple;
	bh=0o3VyKqMCokKcTRoNlA9m25FO5FusfhnD5XbdjaRIx8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QLcHso/IIT6Dqi72r/rAVwCYolqF57vQgJAaOhBEvk1TLaPf+mE7kandx6UY6YfZsEH3VWbvW5zCS7Q2PhLrwLXmA5BWouxSi6WMSYNZEr53dn9Z0RdMh7qWPV+MQTpl9k7/W6TOImzDvc1a2hdS+ONFfBCAk2j+fqj6o6Gvlf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cpdepPGL; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cpdepPGL"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d6389bbf4so46028a91.3
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 16:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780528748; x=1781133548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtcSJVizp1/yzTQIdMGpi8uK9vGLqH+Ru/8ronaIaqs=;
        b=cpdepPGL3WNHiGTwSG9DYJFNUN70H9RuENmBCWxepyr/aGrS8CV+uw0knu3xkcmbnZ
         z0YwzPdhvvvBZ2XMDYGq4XolmU0EKmPsmne0BAq8ziG5epYSlgMcXxsl2uedDNaW5+OL
         mbjBj8jiU4n+7NIRqyGx/X5MSf8RpgkvLc1qpWeiXZY/rzPboi5J9+yKereLf6fHLZRy
         1vo0xP5Ql8msVrdybnoqH21nII+FkeCg5oZ+u+sx6S/dHCn2qHn5RTDbV546S+ssNU/o
         TvZTkd+en9R6vAtvVB+YKbg9SRw8Ixzasv1tFaIihx3Pw24WwV/uz5me0jd0EYbQg9hm
         2Ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528748; x=1781133548;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtcSJVizp1/yzTQIdMGpi8uK9vGLqH+Ru/8ronaIaqs=;
        b=Azf6h9NpjujmzZHDHJ1EWsNwnbb2UNaBnLbKZ31WagT7mB501uo1Vv+3nnH4AiUnmw
         sEebY2x9eCdFJtYqKVLmdjkfEMv7wndOn5FJaeRaBO7FBVq1VVGtpfYlm915uSqG6Fxs
         +HXmiBCwHh6jzCNKPq9Wa8XGVRmMmp9TDnJEFrol5py50PoW3vt0wCL8N69Wl/vsFnQR
         ZLQvl8N6E3l9r+Lf5b2X6WQ5mjQvsT1lX6bSUpv4fqUzwlvHaJkTjGLxpDxGHQkDItuh
         X7MZCWYIfCjawwB+XqPYwAgJhdf1a2vR9zyt0vMIcn6ex1oXnSmZTViknLXEyoIMD4XM
         ylUg==
X-Gm-Message-State: AOJu0YyMlb4H6m7GhFp9kuouF9w6bPX978AiGk1pzyALhXiq39PQg3aD
	a0/L4UKKoLnhFlFZYyeJEuU9euRGkW6XrnIpLKD9JZL7aUNhMjxL/IBO29JZGmBWF5l68tdOd0e
	MiOqdPA==
X-Received: from pgnp23.prod.google.com ([2002:a63:7f57:0:b0:c6e:288a:3ab9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5145:b0:36d:8e6f:8d94
 with SMTP id 98e67ed59e1d1-36e32285a0fmr5338840a91.15.1780528747539; Wed, 03
 Jun 2026 16:19:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  3 Jun 2026 16:19:03 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260603231905.1738487-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: x86/pmu: Fix a fixed PMC event filter bypass bug
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Fix a bug reported by Sashiko, where KVM will effectively ignore PMU event
filters for fixed counters if FIXED_CTR_CTRL is changing, but enable bits
for denied counters are NOT changing.

Sean Christopherson (2):
  KVM: x86/pmu: Use hardware value when reprogramming for FIXED_CTR_CTRL
    changes
  KVM: selftests: Add regression test for mediated PMU fixed counter
    filter bug

 arch/x86/kvm/vmx/pmu_intel.c                           | 10 +++++++++-
 .../testing/selftests/kvm/x86/pmu_event_filter_test.c  |  6 ++++++
 2 files changed, 15 insertions(+), 1 deletion(-)


base-commit: d4bfaa66fa171089b9b9fb2dc17af9245f2b9b34
-- 
2.54.0.1032.g2f8565e1d1-goog

