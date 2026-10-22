Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635511;
	b=nm46D7Zy7MbM20+3XZauZn14/nFSxU2WhYbA1hF7s10q2C9+vL58Xl++JJhCdfwiZ9Um
	 CZagS3eV/ncvbh+xXVqb2JBEP2hRqTnsxJaDP+anAc7el0I2l6W/fO30/hI/160WEYHAd
	 qpcbQqXVNPQPDpP0ZSSTJaxolwHmD71V8fbQAB/lpb3WQ2HsFgDFKpigYfRVgOhNuhCPk
	 +xkWibI7OG8Zt9MluMXkZMpq0a6C4lzrmUQQh6UQEgNlC0lFbhazqD9TTX4QWoIQ7hgzZ
	 CXRUTOd3YHapfy3AOrE6znemZfSgvod5XoYQd/jAFPOHl1ugZatUPsax8DSpfFJTC8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=J9kW36jpIXb4stgoGGP0Gp0ZwbkfanWyIdpTcVbnUYY=;
	b=aZtclXSHnWXFMq1GTAX9zs+VRqIo5TWDfaGjiLJ7uHXWD6XU2V1vurPCG2WGIe0iM5SN
	 XB1MVS/G5OK+CW4TT70xkx1uGR/iAeK4lBFTva0fW4+byODsdm8jo9he4KEAmkWuHPML5
	 XQwjqW87Vqp3QXpZf6C8yoTHMFCIRS4asaPQqjHgpJjqFvSr2dXUBhlE3uwN6nqtu3WJK
	 aOlvI+ZCdRmNZiRSOuL/rFCNdGbFhrJeDE3t6DSuZjyj7i78K2QcjR4THH1GRDdVdQrnW
	 Vu7iKoZ0mgFPNOrZMo57qbQ0C8SXsiZw5GhUECM57YutwfbiPJ1EZzGsW637sxTF6WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tN8zjtKn;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E5A606A324
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 02:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66E5A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tN8zjtKn
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2df8d1e91c9so20545295ad.0
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 19:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792635506; x=1793240306; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J9kW36jpIXb4stgoGGP0Gp0ZwbkfanWyIdpTcVbnUYY=;
        b=tN8zjtKnrxmH60eZP+AG5yFA0/zSgEyLu7otlHRJWxasnE/g8VJ8pTXVwowmhzxLJ4
         Ks04S8zPT91QGgMxXyDEQpbb74INyDzb9pJBt2Cxgb+iOu2iid2lkWrdNYGT1j/jaUxP
         BGjl3HVQZ10nYgUqG2lQTwrQLo/0hWzUMt74/YAW8QeBnCkPLYGFOMTW7Q83bHYLN0cm
         Idy00fQ5dh99+lTI1Lecz5QREQjKHeJB5cdhXrpkInm8tlUooeGXFshkZf02U9uCBEYg
         FH+IOc7sqR2IgG2t521UkY6W9jF8ySufftX2WcjUSaZZx2MP9viyEp7bFRSne8v2H9zg
         e47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792635506; x=1793240306;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J9kW36jpIXb4stgoGGP0Gp0ZwbkfanWyIdpTcVbnUYY=;
        b=THF650z5heEw/u8qUgjZYqRJrFdxRy6F5QYaUj5o7t5IiG7QutSBPqkVBpT95agAIo
         6PutJ/SHbrDynmdwWZhQ+vRZz02sLN1MzggnzHsxFqfRsRNOn245ScZHNWjC4kGwJ1R9
         HPJTeD2yKBNQ6p2SwLv1y/RDvQtolZBI3Eo0r3t3lChIxMv0TwwxS5+DacK9I/+6o5jm
         WF6833OqAc7kP9XYz9n+14HEZbhO8BqdXgAAdOR6g6E1o81TSyychDIa+zYi8X8/n1qm
         4QKBXRcQzn/3VUq81zYmSPNvuzhK/2J6U2f9NTTvqCH21aOYV8hwiorWZCRbMTNQCnwa
         pyfw==
X-Gm-Message-State: AFq9FYLFjDO1nL8YKfCpnD4qx9zLChsTI3rf2WqnvSRfHTSnFKu1e4QI
	0o+xQKSq8T3VN1McLu3uysRG8lF3OwbfsE5bZWL3kXwuSVZtnK7g42/Ac9mRD6IYiicuMOFLviX
	3zP5QVw==
X-Received: from plmm4.prod.google.com ([2002:a17:902:c444:b0:2e8:31af:11b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c405:b0:2e8:1f8a:9113
 with SMTP id d9443c01a7336-2ea43cecf95mr35738395ad.40.1792635505357; Wed, 21
 Oct 2026 19:18:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 21 Oct 2026 19:18:20 -0700
In-Reply-To: <20261022021820.298886-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022021820.298886-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022021820.298886-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: selftests: Add regression test for KVM writing but
 not reporting vmcs12
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When saving nested vCPU state, verify that KVM didn't write any more bytes
than it reported, and add a sync+save point in the state test to trigger a
save when L1 is active with a valid shadow VMCS.  Before commit <TBD>, KVM
would incorrectly save the shadow VMCS into the userspace buffer without
accounting for the size of the shadow VMCS.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/lib/x86/processor.c |  6 +++++
 tools/testing/selftests/kvm/x86/state_test.c  | 24 ++++++++++---------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 8374afd08baf..976d53af6de7 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -1282,10 +1282,16 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vcpu *vcpu)
 	if (nested_size) {
 		state->nested.size = sizeof(state->nested_);
 
+		memset(state->nested_, 0xaa, sizeof(state->nested_));
+
 		vcpu_nested_state_get(vcpu, &state->nested);
 		TEST_ASSERT(state->nested.size <= nested_size,
 			    "Nested state size too big, %i (KVM_CHECK_CAP gave %i)",
 			    state->nested.size, nested_size);
+
+		for (i = state->nested.size; i < nested_size; i++)
+			TEST_ASSERT((unsigned char)state->nested_[i] == 0xaa,
+				    "KVM killed the canary at offset %u", i);
 	} else {
 		state->nested.size = 0;
 	}
diff --git a/tools/testing/selftests/kvm/x86/state_test.c b/tools/testing/selftests/kvm/x86/state_test.c
index 500b09762555..5bd9a04a3911 100644
--- a/tools/testing/selftests/kvm/x86/state_test.c
+++ b/tools/testing/selftests/kvm/x86/state_test.c
@@ -60,13 +60,13 @@ void vmx_l2_guest_code(void)
 
 	/* L1 has now set up a shadow VMCS for us.  */
 	GUEST_ASSERT(vmread(GUEST_RIP) == 0xc0ffee);
-	GUEST_SYNC(10);
-	GUEST_ASSERT(vmread(GUEST_RIP) == 0xc0ffee);
-	vmwrite(GUEST_RIP, 0xc0fffee);
 	GUEST_SYNC(11);
+	GUEST_ASSERT(vmread(GUEST_RIP) == 0xc0ffee);
+	vmwrite(GUEST_RIP, 0xc0fffee);
+	GUEST_SYNC(12);
 	GUEST_ASSERT(vmread(GUEST_RIP) == 0xc0fffee);
 	vmwrite(GUEST_RIP, 0xc0ffffee);
-	GUEST_SYNC(12);
+	GUEST_SYNC(13);
 
 	/* Done, exit to L1 and never come back.  */
 	vmcall();
@@ -107,15 +107,17 @@ static void vmx_l1_guest_code(struct vmx_pages *vmx_pages)
 
 	vmwrite(SECONDARY_VM_EXEC_CONTROL, SECONDARY_EXEC_SHADOW_VMCS);
 	vmwrite(VMCS_LINK_POINTER, vmx_pages->shadow_vmcs_gpa);
-
-	vmptrld(vmx_pages->shadow_vmcs_gpa);
-	GUEST_ASSERT(__vmlaunch());
 	GUEST_SYNC(8);
-	GUEST_ASSERT(__vmlaunch());
-	GUEST_ASSERT(__vmresume());
 
-	vmwrite(GUEST_RIP, 0xc0ffee);
+	vmptrld(vmx_pages->shadow_vmcs_gpa);
+	GUEST_ASSERT(__vmlaunch());
 	GUEST_SYNC(9);
+
+	GUEST_ASSERT(__vmlaunch());
+	GUEST_ASSERT(__vmresume());
+
+	vmwrite(GUEST_RIP, 0xc0ffee);
+	GUEST_SYNC(10);
 	GUEST_ASSERT(vmread(GUEST_RIP) == 0xc0ffee);
 
 	vmptrld(vmx_pages->vmcs_gpa);
@@ -126,7 +128,7 @@ static void vmx_l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_ASSERT(vmread(GUEST_RIP) == 0xc0ffffee);
 	GUEST_ASSERT(__vmlaunch());
 	GUEST_ASSERT(__vmresume());
-	GUEST_SYNC(13);
+	GUEST_SYNC(14);
 	GUEST_ASSERT(vmread(GUEST_RIP) == 0xc0ffffee);
 	GUEST_ASSERT(__vmlaunch());
 	GUEST_ASSERT(__vmresume());
-- 
2.56.0.218.g1ec904b173-goog

