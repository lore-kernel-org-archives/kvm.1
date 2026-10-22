Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635231;
	b=khbn0jFiu2IKkIP3rtG5Z2K9Vug87DmsGCB1iklK0WPMBhk5Vi7nhxFUIjUJwH8gGNg0
	 8dyw5xMJgcGc2pEZ42D+iTssJ4Ngi8QDSewuAc1akZyZz6X1pd93nDrPgA0cCmg5NnEp5
	 LJ4LWXN7d8ISoq7RpYcWKEISNbVL90fsZHiPbxrK/VGoSAwLedquFYljGp+x3j9wApx0X
	 CALx4DlwC+TEIouWhZCYZsa8I4FpUAzQav4J8kFYUaMGYcb9weo01Cbf9I3uGHVs9Ipm/
	 lTpUi8IxhI/N/n417ld94wLqCjXnGXNZBzOoz8NImdXdyik0+1s8AqEudOoRzN4BGZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=/wJuiP1qZkbrR2NFLc8u/Mum9d7IFT3TkfCuEIgnJGY=;
	b=qOmEFDrM1diYFRj6x0m/R+2PEVF1VWn4o6dUiaWM/LGMyocGYPWplH8OiJOVbi0oYoQZ
	 +nC1JzX65CcqmUMXtOh6IvPvXX5UjKCD/W1uXlhdX/UpY+2LQV5i6QFDUFLHCO9afxZPA
	 zIpCK9cUyRRPsV/8a4lbJJgDHaOSS9AYXQahUzmSNVEc5L51mti+HeZgoeVF0uH+aKHgX
	 QFGO7sEXESTpCyHagQv8u9LvLM3FqBy8daqAp6dp/ZjHfyxTRXGW5NK90tAjafPnmajH3
	 gFbMhBWuMddAaOpQKS6ImA5si7sMHX4CBnFjiLfCHtqNqc3rMbkQWsKwXg6I5GJhgpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=FBJ9e2oz;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87349606A31B
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 02:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87349606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=FBJ9e2oz
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ad3fc547bfso1232155a91.2
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 19:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792635231; x=1793240031; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/wJuiP1qZkbrR2NFLc8u/Mum9d7IFT3TkfCuEIgnJGY=;
        b=FBJ9e2ozjnDp6cRjfABGBDh3fCj1GvMOaEktIuewTRGhtR1i2TDXsuudvGzIWSfVFa
         3Q9+tRX7cSepeUuu/tGGKGJQRt/wq6iun+zWj0fNvGBHUsfb4GeBsSePFLHGPmYXuXGR
         6vQ9/P/snhZC4sIFr3J/whcVjwyuVPrsvGEZN7v+kFHNp3qhADeC4BhwdeSjJS1j1+K5
         tP+eV60tbGqOr3Dx8RAUWdAFgIRMP/zOTPFxJy86xBXIBeRYVfWkTYEK8gMXUm/DHNAO
         hw3DvxPI6CDNAxo9Fh6SZOE4zP5/Uh18PO/QLeClVY2tQ3XM6gap+LBFnzSMS+POR+M1
         a1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792635231; x=1793240031;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/wJuiP1qZkbrR2NFLc8u/Mum9d7IFT3TkfCuEIgnJGY=;
        b=MKiuJpuuLZWaRqUglVQhhK+KoaX5TJ+Ct6VS6BSCgBeEtaPLLB7JHDBsaUUQWc+3iR
         v5xAolVZCq9jxsZ/StjYTa/2akoyF76gxEZmSDH2kIB8OkigvzxThHPLq1deyYrB4acm
         XI76p0d2RDH6Wym1ySNvGKHIlqyD8dIPVBZP4EIZu19x+4uXUZKaIq47qhNcFXlQvbNZ
         CendaQj0N6raUJwlQUtBKEPEahZImkEAjggfWMiojZ2F3nHflQzFXXOhWLEQ7iQEes4v
         kpW0uH1XzhxmHlG3Cg7GTIr1OMVDf+QaYsM4nDqeKLk8mxMe+7pWKlOwVHobn6r7JdrH
         WOkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzzXRwCuViEkAM3jL+UF3tI3kpCqqsE+RVlznDqge3GgPzPhTjDaUmETHLa3qLADUEl26A=@vger.kernel.org
X-Gm-Message-State: AFq9FYI38hKOV9SduhTf+g4CZ/q7tkoEI9pURCnFMRsEJa/9LWjGEEWb
	IWpKphIjXsEUftxA61LCX4Pw+acbDTOKVCVuIPM9Iw3qpq7dAJUTkkqgLJWjPxLa7LYgmGkCJJH
	oF7+xdA==
X-Received: from pjny1.prod.google.com ([2002:a17:90a:8b01:b0:3ab:d5d:f278])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:39a7:b0:3ac:a1c7:20fd
 with SMTP id 98e67ed59e1d1-3ad86afbf3amr3409791a91.4.1792635230730; Wed, 21
 Oct 2026 19:13:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 21 Oct 2026 19:13:49 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022021349.296149-1-seanjc@google.com>
Subject: [PATCH] KVM: Don't WARN on -EIO return from kvm_arch_vcpu_pre_fault_memory()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+db7bd0f41c2a7e82d4ba@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Drop the WARN on arch code returning -EIO when pre-faulting memory, as the
WARN is user-triggerable and completely unwarranted.  In all likelihood,
the WARN was added due to a misinterpretation of review feedback, and was
overlooked in subsequent review rounds.

The WARN showed up in v5 of the original pre-faulting series without any
real explanation.  v5 did add -EIO as a documented error code[1]:

  v4->v5:
    - add EIO as possible error

in response to Xiaoyao's review[2]:

  > +   case RET_PF_CONTINUE:
  > +   case RET_PF_INVALID:
  > +   default:
  > +           WARN_ON_ONCE(r);
  > +           return -EIO;

  Need to update patch 1 for -EIO

  > +   }

but that review was just talking about the documentation.  And at the time,
KVM x86 already WARN()'d when returning -EIO, so having common KVM also
WARN() added no value, i.e. wasn't at all justified.

Link: https://lore.kernel.org/all/20240710174031.312055-1-pbonzini@redhat.com [1]
Link: https://lore.kernel.org/all/d5a6e125-bff4-4d82-ae65-b99d9cb10e90@intel.com [2]
Reported-by: syzbot+db7bd0f41c2a7e82d4ba@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6ac316c7.01314a6c.556a8.000d.GAE@google.com
Fixes: bc1a5cd00211 ("KVM: Add KVM_PRE_FAULT_MEMORY vcpu ioctl to pre-populate guest memory")
Cc: stable@vger.kernel.org
Tested-by: syzbot+db7bd0f41c2a7e82d4ba@syzkaller.appspotmail.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a97aa5b92616..af13d689482b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4461,10 +4461,7 @@ static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 		}
 
 		r = kvm_arch_vcpu_pre_fault_memory(vcpu, range);
-		if (WARN_ON_ONCE(r == 0 || r == -EIO))
-			break;
-
-		if (r < 0)
+		if (WARN_ON_ONCE(!r) || r < 0)
 			break;
 
 		range->size -= r;

base-commit: 814607cd40df80d5727957adaa857e0feca43497
-- 
2.56.0.218.g1ec904b173-goog

