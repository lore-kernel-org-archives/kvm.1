Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBF8372675
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 23:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381048; cv=none; b=ZBCQeDUYbrecM0SKkuS67okVmXVehF5fbifUdqa9Ok5kC9wtP2RNGOEVyyECyU8hy62a57eTWrv4wQ881fHW88z3w8matcBjhmZ5M0muVKrvZjySVQ3Jy3vVZ2dtABTyYB2LYOIMxOch1qb6JU08DruBr3lnhVH5OvZPex2yquc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381048; c=relaxed/simple;
	bh=ibo7CnpGrpha454UaRPW1hlDSh9CFygz1tm8RvNj3qM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Tw9P/snb3clW5yOhOdkP1NIs5GpIli1tQCFnk0Lp+sG+mBD4NLfvStsjNswGgLqUlGktZ+37q3u7DhFqCmBxIWkgtq4IbzBWYeqczXnUlLzjFcWVbeEVOw4ryHy4iYc+Z38Cq8M6ROllD2ppfVJWjDtUBAgoY299+00I5P0s9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mIlSw9WB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mIlSw9WB"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b24e9b4d82so10743265ad.1
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 16:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776381047; x=1776985847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XjVnvrOeT5QzD9aDDSLvO3F2NHdXn3jVsrlD8MBG0k=;
        b=mIlSw9WBJEWyyJEKItEIV6u6U6pwIzFCMOcd5qL6jiX9csz0ecZdfa5P317HH20gI5
         h99wOKxPJUQ7TzRef7YbtkFIVXQQgCPtnrnFn3++VyHJqWUWFb6ICI4U/7voo9G58WGL
         ocDE0Ag1FyLeJfaBgGFWVG37zYPiBIPaMIW3fpBTv6CdrfsGRV8B+HrVrpv3/yeO7l/L
         GwwVIFDXfhQnBSgyiQN9HQMHx4UUyco14yFvU5gvnEVdGFTE3wFtn1tF91S1sPU8C3NZ
         hgBFfOMnQlzBKjFN04vJ0g2biGbBtmJb8DU/IhVChPNOnK/kdTcbjbSaWwl+J95huqvx
         +xCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776381047; x=1776985847;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5XjVnvrOeT5QzD9aDDSLvO3F2NHdXn3jVsrlD8MBG0k=;
        b=itxCyubdIkcxw3aRfLxu/17El2/zZDh5a0SUDVfgEd5bJ7SiKoD4CXpJrVtWfjGSUi
         WXDg9AUa1wXXqCrWi3/v93SZS37LKcCuDxE7P7kQiRXHHB1BBtD3A0zIURkmBg+4JO97
         RdCFLDZaYq27QIrD2bC4cBMNyBJrXbsIUYa1UhRFUDpysGIWCKSXx3ipqbUprhSoTppt
         lagTzWWsB6JBQ9Chj1dUCv9v9BbxvonS6Uc7N+Ya0htk+w9chaPo81TPK+3P38HC2pj5
         6sicu3a2XFfP/gu1fUfKsmQi/tbcWdyE7HEEbnRHHuC2SW3r5biLIa714twHCYFzVjlF
         5M8Q==
X-Gm-Message-State: AOJu0YxgZdtZcy8GdozjzvkwTa8fm5XrL2zOz6wEPuAC8kaKP+VtNymW
	uaDqOuY+OMTaPr36oX4ULbKBiOMshqzagsRPOypWm6NVlJhxqa9IUpdZ8sBxAqWmw//Uc2u2MdN
	2x4uuYw==
X-Received: from pgno29.prod.google.com ([2002:a63:7e5d:0:b0:c79:607e:269c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3381:b0:37c:b74c:d8c7
 with SMTP id adf61e73a8af0-3a08ca7378fmr298045637.22.1776381046879; Thu, 16
 Apr 2026 16:10:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Apr 2026 16:10:37 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416231043.3402410-1-seanjc@google.com>
Subject: [PATCH v2 0/6] KVM: SEV: sev_dbg_crypt() fix and overhaul
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Ashutosh's fix for a heap OOB/UAF bug in the debug {de,en}crypt code, now
with a selftest to detect the bug (and confirm the fix), and to validate the
functionality.

The rest of the patches completely rewrite the code.  When creating the
selftest, I did the silly thing of testing arbitrary offsets+sizes, and
couldn't trigger the true badness because the test failed long before it got
to the larger sizes.

Specifically (or, at least) the current code fails to handle cases where an
address and the size aren't naturally aligned.  E.g. when encrypting 9 bytes
at offset 8, KVM needs to _decrypt_ destination[31:0] into a temporary buffer,
buffer[31:0], then copy 9 bytes from source[8:0] to buffer[16:8], then encrypt
buffer[31:0] back into destination[31:0].  The current code only ever copies
16 bytes, and bizarrely uses a temporary buffer for the source as well.

A wholesale rewrite in a single patch isn't my first choice, but the existing
code obviously hasn't been tested, and it's so bizarre and unnecessarily
complex that I've zero confidence that an iterative cleanup would be a net
positive, especially given how many hours it would take.

The initial fix is 7.1 material, the rest (including the selftest, because it
won't pass), can wait for 7.2.

v1: https://lore.kernel.org/all/20260410050854.2463447-1-ashutoshdesai993@gmail.com

Ashutosh Desai (1):
  KVM: SVM: Fix page overflow in sev_dbg_crypt() for ENCRYPT path

Sean Christopherson (5):
  KVM: selftests: Add a test to verify SEV {en,de}crypt debug ioctls
  KVM: SEV: Explicitly validate the dst buffer for debug operations
  KVM: SEV: Add helper function to pin/unpin a single page
  KVM: SEV: Rewrite logic to {de,en}crypt memory for debug
  KVM: SEV: Allocate only as many bytes as needed for temp crypt buffers

 arch/x86/kvm/svm/sev.c                        | 423 +++++++++---------
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/include/x86/sev.h |  24 +
 .../testing/selftests/kvm/x86/sev_dbg_test.c  | 118 +++++
 4 files changed, 347 insertions(+), 219 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/sev_dbg_test.c


base-commit: 6b802031877a995456c528095c41d1948546bf45
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

