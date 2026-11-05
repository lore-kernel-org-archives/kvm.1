Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917806;
	b=n7Wy/Qsi/hC7EtQg0U6+5ts9X/KdTYZnz8SL6bfgobak79WJ3mS0uorQ3PX/LZriMkRw
	 siepfKFxeMx0NobU9bP83CCNJfH6oDbOyJHEVywb/XCfRTPNuxuc9VZjWd4paZwvie4F2
	 5c6CbQJfA6IM/YqkzEj9ilAumSNZJA73BvYjvD77x19kL3/jtu4c1UzJWBRbnfpd0gSkl
	 fC8jcgDKXPFD6Dx4XF4ehlLov1coX+GmyResgiwsHEOfMa6ymM4m9cL+vJgN0wEfkTNvl
	 30LXb83/zHhgkD3uFt7cmpAfrZB0Pr8sO+fO4lE2ji9oGTUZDycZCaW9sClajU9RvAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=6RccBScqvox0PQtK6ljXaLC+8XlIbIU61+oRhrEpvwc=;
	b=rIUo+UBzO645e29zXA21WXxBgmFoqL8CCGCrl99ibGJSdKKsEIH6jEoKuL8Nc2wD/Hgp
	 qvE22QfRpqfkeH5ozHzu3iSSp965PXT6lMDo/sI7g9YInTFf/ROmWIeQMQd884kQNz6tZ
	 6zGYPNCkD6JNmTYGAiC/EeZzeUF3/jziboJ0Y4GH1njM+XqQ4U58VcYeLzUGwxC2F2SSp
	 Q1OjlPDJWJZV8W+2Zz17FzWFqOIl3XIjqOhFP5uScZ4kqorCU9oN+lifa9ev3txQaNMNE
	 mecdPBVgaU/N+Cx9dFnKUKmB6C8QLE3hCyM/+4ftM3VUqNheyECvRprX1BKML0vJ4iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OvqWLWR1;
	arc=none smtp.remote-ip=209.85.210.69
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B5E606A328
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 22:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81B5E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OvqWLWR1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-83c2311eb1dso129434a34.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 14:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793917804; x=1794522604; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6RccBScqvox0PQtK6ljXaLC+8XlIbIU61+oRhrEpvwc=;
        b=OvqWLWR1KNUYYP0/8bQc2nDQaeuku4ZkjK4RHbXf827VqQ1GGHTVkpWnoghHBNUJDD
         q1ItZf2QrGLBb1POwB7jMCuxvRlcYqcfOaEPguBn+MFym4U38XSCGtIDMXlgmdJ3HYVK
         jBenfWhBJe8ForsxJHb+Gp6V0hz3q1ncAnuT6Bri4JHzeVRyr6Q0LmRukZKa5hOld0sK
         rl7DPLP7KDMImQIRbYdb0gHVGhJnDJrB6Xs+XTXNg6wpp1L4FbDIuaI2UPruWI+Ehs5n
         cvSeK9+UVu0w2X8TSG8rvd8wGKAMzY2PRgqXRUsg6cY4MyDP5CJkzxf11UWJStgpVtdf
         r20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917804; x=1794522604;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6RccBScqvox0PQtK6ljXaLC+8XlIbIU61+oRhrEpvwc=;
        b=Vx6q9Ug4/GIQuWODb9JF6Cpo9zHSgsKEMwVPRKBGk03DaTSHmQWG+JHCrYIrZecAyv
         ekVlNwsjJy9PGVlVBYulbmiSlSb59kh8biXsReL4WsMrPwTQGS6bVLevTi7pZeBrdu9e
         FnhmMnI+TwdqKy1BFKBki2ALxCumRCuuA/aJ9acHdsoWiy1RlddaL0cfa8uB9xbZYVQj
         S4JhgZerP3L6G9JPoU8pEO4lMRNrX/QERLb1ucvJtWe0UtQoWYkMPoAdhN7VCUhq6tOX
         D+qckdAiQSY7/1ysZW3SBdVqQzBp4HfaWgI5cqUX+TrXtS2mfSt1AUyzjniJG+0AEKWZ
         7T0g==
X-Forwarded-Encrypted: i=1; AKwUvByDVn/cdUy6av305yH1928pDQb2cwF3WocbNonnS9AZ/3ghWkyMdRY0/1hRbkO7mbNo9eM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DzhgFsMtpc0g1ERnwbMl8uUQfwtJ0KI+chNxwDDxoS32gu3S4
	X//9Edf6MAdRXnOx5/4dGPc1gzZ+8/6CQD5sPWPACWf7wY5T8KkwkjR+UyI0U1rt5b4/I2ux2k4
	wjhZRFcEV9e6DVw==
X-Received: from iobn15-n1.prod.google.com ([2002:a05:6602:c6cf:10b0:9e0:f302:3530])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:198f:b0:4d6:93e2:5bc1 with SMTP id 5614622812f47-567e1a16c8fmr547852b6e.66.1793917804196;
 Thu, 05 Nov 2026 14:30:04 -0800 (PST)
Date: Thu,  5 Nov 2026 14:30:00 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261105223000.3036448-1-jmattson@google.com>
Subject: [PATCH] KVM: nSVM: Mark all of vmcb01 dirty when restoring nested state
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Yosry Ahmed <yosry@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

When restoring a vCPU in guest mode via KVM_SET_NESTED_STATE,
svm_copy_vmrun_state() updates L1's save state in vmcb01->save directly.
Stale clean bits may result in the loss of these updates.

Mark all of vmcb01 dirty after svm_copy_vmrun_state() in
svm_set_nested_state() (cf. svm_leave_smm()).

Fixes: 7ca62d132250 ("KVM: nSVM: do not mark all VMCB01 fields dirty on nested vmexit")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 07554089ec05..0d1e4d624cdf 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2091,6 +2091,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	svm->nested.vmcb12_gpa = kvm_state->hdr.svm.vmcb_pa;
 
 	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, save);
+	vmcb_mark_all_dirty(svm->vmcb01.ptr);
 	nested_copy_vmcb_control_to_cache(svm, ctl);
 
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
-- 
2.56.0.455.g6c5a503b38-goog

