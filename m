Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E002F24E4B5
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225279; cv=none; b=Qf3KkUn2n9SVqBFzYCUcDCIqeDORpu1oHquAqiSF2amjVrd8iKsE0Gft44aAUSMTsYmha2GsQnDZjUlGQbxPmnPhKCxKPr8mBpkwhw0WhWrpL4+2q239BJyk84gabhVL6P+vYRw15VPXmFvXJZFBe5a73LZ8HkIVXUmQZxjOU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225279; c=relaxed/simple;
	bh=fNExGHKRAwNDwQlGvZ+K4PtZPYA6o4Hcsorch6x4W2U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m0GqIvoPwhpMtCHtRlauvSlXf/IDBBbBRc9gZ/+bRMvXtAPLzUINEFykbh5rFtLap0zFcJpNGAXavoAt8MlUYp8QEdY0SNls9pQ2FIJz/estnSyVyij6sDkDKhNeKTS/fIyPpNBC3fed+sArG7a8FAYZeLxghPOUjyEBAk4XPdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VAaglxJs; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VAaglxJs"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0532a6588so3960535ad.0
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 17:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781225277; x=1781830077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKVLVWa1wCgaJK8vzzm5ZBtQNyVkPteH1/bU0HT2Wa4=;
        b=VAaglxJsa9UyjooVKj/lwjYkOJRmiIqTeVFp3JNgSAomDHDPNMRFvvWeufHzXfvGLE
         s/LiLpwcjh6YeGZkQ23CXtU/bP3mOmRXRwQODhwOY5akjEM8p9juJ4pEexIRe6mqJBPv
         sF8S4gIwsaXMKR8fRmRbGNvhfOJ0KtOFI6p3fucujh5UTV/B9hWmp0F8Ud9+N4HSmA3b
         8G/c7brfLjpmgJ4YBRtcTokpJJOn/iOZDQdNZSPASfIbeVFpIji3y4rQM/Pkmh7PyoPG
         EwNV1pQxZUTmTnARWkO2zeTitO1cF7EcpHCfP3RvSXPbAywRZfsa6P4K8hgxINlbh4B6
         jXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781225277; x=1781830077;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wKVLVWa1wCgaJK8vzzm5ZBtQNyVkPteH1/bU0HT2Wa4=;
        b=UKnIK41+21p6cBJrlhzdyY4cXfQ+5Dc6l1dvlfBfMVaEgMe3Jb1WALFkfFu5/uBtGO
         HLDyKTswZzqGao8W9DSLlPQPblhetImPvOy6JH/0d4IcT/1tNP/woxQn6yhZfyokU35k
         c7Vjkf4jXmnZ75a82GXWcHayf5UfK0mnTObvLLYtxzQ/Hv1AeAJT3oOymNsccpyZlUtv
         Ih+qqzVUIaThJ94uusc3PB8h0S2H53VCHXKL5uqJcIdMFuPrDH3B/uhG06EI+fFkt5a8
         AZB5zR8MkrV1+u3wVXID2t84FKRUP005j5fuhsDU42pjKrX+FIQ2z3VYH69hbqN1dljC
         X+jA==
X-Gm-Message-State: AOJu0Yz6XDX3MYDBbmY57pArkEFTFIMQfkxJQnX46UejGmGs+UsYB3na
	Olka4T2EGDBwNR4yL9K6duFndTXT8PsYmhxeOOw8yWu532jqdque62Kdi0PuUAK/Soaynii4wne
	q0rUT2A==
X-Received: from plxj17.prod.google.com ([2002:a17:902:da91:b0:2ba:f5a6:38db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c401:b0:2c1:6020:7398
 with SMTP id d9443c01a7336-2c410fbec97mr7649995ad.12.1781225276988; Thu, 11
 Jun 2026 17:47:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 11 Jun 2026 17:47:45 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612004755.349925-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86 pull requests for 7.2
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Sorry for not getting these to you yesterday.  I was all prepared to work on
them before meetings hit, and then SQUIRREL!


Outside of these pull requests, there's a set of five selftests patches[1] that
I have sitting in "selftests_l2_stacks" and fed into linux-next.  I'm not
including a pull request for that branch, as it's deliberately built on top of
all the other local merges to avoid a pile of annoying conflicts (the changes
allocate a proper stack for all L2 vCPUs, and so touches every test that does
anything nested related).  If you can apply the patches directly after merging
the other pull requests, that would make me quite happy.  Alternatively, I'll
send a separate pull request once this batch is merged.

[1] https://lore.kernel.org/all/20260610003030.2957261-1-seanjc@google.com


There are two conflicts I am aware of; thankfully both are fairly trivial.

Internal to these pull requests, "misc" and "svm" conflict on header includes
in svm.h: take the incoming headers and the kvm_cache_regs.h => regs.h rename.

diff --cc arch/x86/kvm/svm/svm.h
index d013a5ceb62e,87c6b105deef..000000000000
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@@ -23,7 -23,9 +23,9 @@@
  #include <asm/sev-common.h>
  
  #include "cpuid.h"
 -#include "kvm_cache_regs.h"
 +#include "regs.h"
+ #include "x86.h"
+ #include "pmu.h"
  
  /*
   * Helpers to convert to/from physical addresses for pages whose address is

Externally, the "mmu" branch will conflict with the tip tree on
arch/x86/include/asm/tdx.h.  Mark's fixup in -next[2] is what I've been using
in my local resolutions.  Basically take the KVM changes, but keep the
void tdx_sys_disable(void); declaration.

[2] https://lore.kernel.org/all/ahb-PZwR5mEd8A9W@sirena.org.uk
