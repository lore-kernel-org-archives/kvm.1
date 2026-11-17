Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950958;
	b=ra0i2p4oqpYX3wpJ6q7Us216k8B3pE6W2ED4jgnmG78efSgFD81aTXcsHjD6gP7MOCwq
	 QWLL+cgfvmAiCugwwOoKwLGkBYZZol7jX5lwAlMZ3hpwoKofB7q0/+eF/SQJDNagW9hzX
	 jIKt+rJvbzR+ye8hlKKewewMnZO696QCloCq9US3MZtP9zpxATA1+0qa4tcD1C6gmwOIf
	 BdUl6hyJkUCb3DnEtTnIAJnPNaSND4aO/zHBmIvf87jHGxePHMggn9/C9ynoOhF33WqiP
	 uyBuri+/sn2Q2IxnZXVwjDftWDarSC9XDOSHDBOM+4t0/ayR9O4GUGYFPbQ2xkXYgLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=WphzloPQaUB2SK64BZ8Vq9XA7Y4dmee73grGXDhb+2Y=;
	b=DoeSjSk4SvQ3W0RSxa2pve3PViCYHDu0UgAyGp9vdbWLC0R7uJrsWDHQvg56C+KZwHdD
	 CB3DCJURSdig/m+k35Mo1xtIPsjjmk5ste2k09UHj4AZumr/UJLrkUWvGisSJzWSoZa10
	 fW+SZsv31fJI+y9u2oD3ZUZ5Sa+DdZ9YHGo4VOHJE6MS2H45Sq6PDaEDifDYkLBJSTWIe
	 RKkyhWHSIGy7pVxje+Zr6jXYGzLrBWMeh9P9glM4it7yVd5kXIoNQPhoosgSDTUF5azDu
	 XQOCjAIxp0mbgndrHrC1cVFZvLQQLJGFojdRSV0WLyzZYTOwhBKV39obyhGYBoQDCpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=niP99IO3;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A48606A8B3
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 21:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35A48606A8B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=niP99IO3
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2efdd509c6bso2871015ad.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794950958; x=1795555758; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WphzloPQaUB2SK64BZ8Vq9XA7Y4dmee73grGXDhb+2Y=;
        b=niP99IO3V9pa3YBQ51sNf2lmdb5ZTqQyst4/bUd4Sjdm2QKHzUkenwz/3Csp6NuMTg
         Jb5isjYckJ6HYFGE6DQ3p+rB75C1mN2yQ4Cz/uO7EPV66bw4R3/ctJEt12J3to0572IS
         dlZyGi6HsnInKD4KNSSJ6KueEUpkkxImuhscYnJcYgyDU2EQZRPiV2I3URXONnjpVd4I
         eFTnBoRX7WZ6rz2vHJqSO1KZRBLBBqMrCywQFdl5KoFSy18j8cPNLPYoCC3vdxTrGZ4D
         Q21kH4vlh4fvuXmi1g4Be0zHnyBsRaoThHlQTVMM6QjaB2OONICookXyKmWjxKOwct3O
         t6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794950958; x=1795555758;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WphzloPQaUB2SK64BZ8Vq9XA7Y4dmee73grGXDhb+2Y=;
        b=Oba9swcp14Z6DP99jHy/yBf+hetyumB67JRbsw5JA73RMuOxuk2G1nLKeFftYmXnaF
         4nQWRoNJG8kWWygiCQKjqzQ1WfyzLbBcJvF+36QcRLfsY6MlX4c9Z9cBQvsuxN1DZet6
         F2sz6WtuEAszR6lmFfBIGzYUkNs8f7RF78vKTzUJBK2fA0oANJIznKgSXSxcb92QFOtp
         +JAuJYehKJwKE6vthRaih3wAkRBN4RSf3rY8vKFaqyozK6x7XYZyqFCOBTjjNwxO+vf5
         tqSQUZFtElOW2cvAlqVomdNLB57r7U/vo0KSYYjGUAhXio8kzy4twIMa6hesGVJHB0mj
         JdOQ==
X-Forwarded-Encrypted: i=1; AL+hErFqjCjxEifxWyzZuAqYOCqX4pSaDDMuQ2TbyP9k6VnekirF+cLKAL5SQHwwDZM1yx47wbM=@vger.kernel.org
X-Gm-Message-State: APuU4Z86IzHT568Q6FrNUSyMFB/j/K0y3MluLjCVFwCEhs38vk33ffb9
	gnFExl0hWRULAHMUcpYGTL5CsglazxOhe+VPcPeW9qdZdi/vCbXdr8BBQS5nxwz3V1ZJKJJsV3n
	sDdwEX+gmDueCx0gux5ljsg==
X-Received: from plhe14.prod.google.com ([2002:a17:903:1ce:b0:2ed:de1d:fc13])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cf4c:b0:2ef:effd:4606 with SMTP id d9443c01a7336-2eff70fcedamr5695715ad.2.1794950957476;
 Tue, 17 Nov 2026 13:29:17 -0800 (PST)
Date: Tue, 17 Nov 2026 21:29:13 +0000
In-Reply-To: <20261117212913.3634487-1-jthoughton@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117212913.3634487-1-jthoughton@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261117212913.3634487-5-jthoughton@google.com>
Subject: [PATCH 4/4] KVM: selftests: Verify KVM doesn't reset unused dirty
 ring entries
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+55eaa971f4924b62c9a5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Before running the vCPU in the dirty ring test, mark the first two
(unused) entries of the ring as harvested and verify that
KVM_RESET_DIRTY_RINGS doesn't reset any entries, i.e. that KVM doesn't
advance reset_index beyond dirty_index.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 8189eaac713c..96a40488eccb 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -375,6 +375,21 @@ static void dirty_ring_collect_dirty_pages(struct kvm_vcpu *vcpu, int slot,
 		    "with collected (%u)", cleared, count);
 }
 
+static void dirty_ring_reset_unused_entries(struct kvm_vcpu *vcpu)
+{
+	struct kvm_dirty_gfn *dirty_gfns = vcpu_map_dirty_ring(vcpu);
+
+	/*
+	 * Mark unused entries as harvested, and verify KVM doesn't reset any
+	 * entries, as KVM hasn't pushed anything to the ring. KVM will
+	 * overwrite the flags when it pushes to the entries.
+	 */
+	dirty_gfn_set_collected(&dirty_gfns[0]);
+	dirty_gfn_set_collected(&dirty_gfns[1]);
+
+	TEST_ASSERT_EQ(kvm_vm_reset_dirty_ring(vcpu->vm), 0);
+}
+
 static void dirty_ring_after_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
@@ -687,6 +702,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	TEST_ASSERT_EQ(vcpu_stop, false);
 
+	if (host_log_mode == LOG_MODE_DIRTY_RING)
+		dirty_ring_reset_unused_entries(vcpu);
+
 	kvm_pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
 
 	for (iteration = 1; iteration <= p->iterations; iteration++) {
-- 
2.56.1.708.g77570a6a1d-goog

