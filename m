Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C5738C40B
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 22:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775516043; cv=none; b=opg3NXL8eNSV2TP07/23mR5fbFLxXYmYZaACfXWSXCFozRrkdMTd5J7WQ5ooFk8Ay4WZ21wnwNeRxC9DAZwd/GX/2MeOEJ3ntm9Qsut0eRaa2fEZQnzX6ik/5+5qUIrASX7IDJf6498oRMvvgzxdkUgl1JfwFb8aOdtkN+nIXSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775516043; c=relaxed/simple;
	bh=06P9q15/FPA2GSndbioqzjnIb527Mu0WRuyilzLtqeQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SBis/r5QkWJ9K5lTDz6WfwVxB5tIgZWqF9YadQOkHfaGmMb6nXUnH7vXTlWHS6HhwS+r40qQJ6aUDrn8avkPFWfTvCiD24J9mcZMPMCy6etb1PrjBnK7wRBM/0ct6CbU6VkMzd0bsiUfwcQDONBVF7Xea5/1eOschCPlgXZlCzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUGEY2sr; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUGEY2sr"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so2537953a12.3
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 15:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775516041; x=1776120841; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDZE8VzW2Z4+joQrGqpIORY8M+mNdqUKKJqTkYw/+YU=;
        b=VUGEY2sre3TYiZWKGVryyf4riGus9YesCCc+qDFvv+1OlTGpcnkU7nl+tFa6TgcTRw
         8XgPBs4UF9mtYg5Ljm+VJfwtJiENGsIiUIkwW0zm+pOlwclJ9LHpMKcZLGKbbjI4/rO1
         fn/rbzH7M4IipD1WYZe98KRS9mvU5mKYkrVp0aXaedPsHplML0n0zgsj9WtwkDJZVbmf
         p26acPOtcelFUJNjw2Yne1c60+4mo2xK0hgPjvhGHfs+t5D98wpWX/LpESDeEl7X15us
         EeTjoa5D38AWpjfW7q0SH4pt/FyPdpusj7nfrPZnwPyVVaVEtRGlCbHV0lO6LgUrzpkA
         Qcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775516041; x=1776120841;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDZE8VzW2Z4+joQrGqpIORY8M+mNdqUKKJqTkYw/+YU=;
        b=in+G2kfKqeKgnRVxIbnSvkJxbwpQhU24n83XWKk1DMbQQ9+RNfHxdRCiAhTAaMMSk1
         GG2s4JZlY5isWLOcZask3p4OHg1vX/yzxbXmzhDg0fApGQp6DjIB5aKiIgRuRSnXaZaH
         3iQhn3wZ5XY3dajLYNinc3LUO/BmHyChHpLebG6fa/QCrxqwE8rigZa5pEiInhmdu9yC
         8XEnYxiKG+6Zv1hZCSzOTSicjq3xhuCsKD/kOGlfNS5F8RWe9DZ+ERbxnE+lTEIEZfNu
         adpJD+Qcai0aQtVYNV66XEYTpJdBt6/Em9u5z9X8xmJ+O4iiin3UCFFE7zp/0fGvqqwZ
         RoXw==
X-Gm-Message-State: AOJu0Yzh+9cQbgml1eiAc9vr8OcIPSReZg7QY4zSxaufuKYHqTA1jcrw
	okcyPQ9BiawGpOYch5oZ2X+6Xq6N2NXCsj8eRwpUwvTABldTxRJZXa6ZWlHS06Kg6CkKdjfFq6v
	3rM+rJg==
X-Received: from pgbdo2.prod.google.com ([2002:a05:6a02:e82:b0:c09:15e9:db4e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:5493:b0:398:89b6:1b39
 with SMTP id adf61e73a8af0-39f2f3a7b17mr14353172637.60.1775516041105; Mon, 06
 Apr 2026 15:54:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon,  6 Apr 2026 15:53:55 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260406225359.1245490-1-seanjc@google.com>
Subject: [PATCH v3 0/3] KVM: x86: Async #PF MSR fix and cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Ethan Yang <ethan.yang.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Fix a user-triggerable WARN found syzkaller, then clean up related code
to eliminate potential stale data usage by removing what are effectively
duplicate fields.

Ethan Yang (1):
  KVM: x86: Don't leave APF half-enabled on bad APF data GPA

Sean Christopherson (2):
  KVM: x86: Drop superfluous caching of
    KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT
  KVM: x86: Drop superfluous caching of KVM_ASYNC_PF_SEND_ALWAYS

 arch/x86/include/asm/kvm_host.h |  2 --
 arch/x86/kvm/x86.c              | 33 +++++++++++++++++----------------
 2 files changed, 17 insertions(+), 18 deletions(-)


base-commit: b89df297a47e641581ee67793592e5c6ae0428f4
-- 
2.53.0.1213.gd9a14994de-goog

