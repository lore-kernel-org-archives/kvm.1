Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A90A3D3CE2
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101775; cv=none; b=MvD4M6/b1Dlfy0ML4Nnek0CXYaz+nJkRTfAwsvPOJyuOC4DyTfipchTtXJU7OekReig3OyigeF+H9gTHk5TXfCJLixkod45hv/D5cCR0rWTCHEu2EOXwPOMcdR48EKxa2mgd6W2rcnJ+sWcuxtm7I8j6fAw0u2dn0jnn9oYATFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101775; c=relaxed/simple;
	bh=9SAVA5mG82KIJnNzTrkIkFNNxhz7HJOIVyBGo3z7EM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YnzZLXeOQxBBGPGnq9SqauG24DTuEVsGL6UAURLxOGaXVOq37ORREWAck5mRbT3X4fFQftyiNU77Mk0LDiWe8FsolNAKP+drq2gV8lGvDp3wZRYKz/cbsGxnMl+O1FwUd+t7g64lh0COwcTwejws0oa7Q3Z0ZTMpfoF9a1fAoEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKyzHp9E; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKyzHp9E"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04f7f2so158834c88.0
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 11:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101773; x=1790706573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w4tObarZqWzLfPDYSwGxwQwAXuFMWWhRAhqBOMQynsA=;
        b=QKyzHp9E0+LMEgyi4nDuk3XEMwN0/OcNrdZSGmxBgs9YSsUW14Lzfl9Ap9jjgq9yAQ
         o98eJC/OvmsBk4wYic1OGftyBTCC3z1wwolnp6382VazYoIRSizQuWteTWyNaZgvMScP
         T2HaBpt704z5iXwkkMPSN2Fmfwn+5JS9WPduOsjcSC1nF46Tz5lDzxf2O2mqC0MIqc/+
         A5bmpM7hljJ6fd+Pw9ywoiZfJABsNrp4zpwdCHECTwHPqAdm4kYyw84b9BrMpnFH+8Er
         rU+Lt4iYk4jOyOV0cMsB0dXGxMieGxwzlcWT3rRg4QT4gP7h0UYNvDfZuDNiLFOJvBf7
         2lAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101773; x=1790706573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w4tObarZqWzLfPDYSwGxwQwAXuFMWWhRAhqBOMQynsA=;
        b=vaEnoPIl5ctC67pkdxq3+QyHop3c5Xdby6hUqgBUJXteLH7S8AwCEx8gRos+4Xa4I4
         sTkiyuAJNL9XrYc1TUOaKp8vdl7rCeiZdg1yt5FB1nPbZnNNLN1P+eUkasGTviS6j21L
         hk3gUC+8TsfYMnUkjrKO1PUstMbnXypNsgDW+Jqgu5KurtHAX5IesZvxH78VrqxjTekY
         IAiqILoKwj477Op6aJ82toOLDmgxNjnU1nvDHMqa5/UR7xQhX3zVAQM2FufGpGnjMwXG
         bn5oWi3gR8KchSQMKkzrIChUi+iVVTZLTNHsQTZ4ErE7hdRLWquVsvuORk577DKnPY6Q
         sgjg==
X-Gm-Message-State: AFuF++kiQYAD2gns2KRA2vgu1sdZZx21VCLFT7i48B5gfVpWi5Te9cCS
	AoXU1bs5dKnS52ewpMoOahPk4j3BojegcU1nIXbkFNhClxE0LDotx0LBhSvMaw==
X-Gm-Gg: AYBFou130kZO8c+j6WLMHH9NlIxb6cWbWdiJSNRSdRAIyA8miFchI0TTMLKHQXGbo60
	qKAAg3YhZrYv0/3SBiSt4+NMF/An4HnMU5LHRpS/Ea0Bl922gE0s+cLG2iEE6Q6/gFfsxgdlHQT
	8AcfOKs3eLaJmUPJc1tIGuX40L8bpaIzx2QIW1HErHvr9hSn5PpO2om1SJvRRm9cn4NNthxF3io
	XredjZ+1wqoOfKoPjkskqAoArh/ka8GD8NJ0lsLaHpLdZ1XQgYbPTXeKuALDmuuEufD2N60nHkj
	qgLivDgCTh5/Rd981Kw8xgsVrVC4edcyFb0OfzPcEISBeHQRA3iPyZnzpg/ztuCkMKzAkHTEk+F
	uoDDky2P4Ppsw5SyT5lMVhAcN/HgUtxeF0/GFjvXbIKuM6ZE+aUZm48udbWwfEC+0waKyFijabh
	WHvTfonAXs6kCqGNpqpxhoIlj0+4AIQNyzYXLnLf76BqdyMOPQWOlmHK2JJGp3fO4Wt5bJtd6AA
	TKm+yzldWJy7P/oTT0njKjWqeNIzpEXVJkjWlMgWSu1/+JQZcOXS3IEi4ZY
X-Received: by 2002:a05:7301:2421:b0:33c:e8f:5701 with SMTP id 5a478bee46e88-33e8e1b3d3amr121483eec.34.1790101769713;
        Tue, 22 Sep 2026 11:29:29 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm154315eec.3.2026.09.22.11.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:29 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v5 3/9] KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
Date: Tue, 22 Sep 2026 23:58:47 +0530
Message-Id: <09b1330bb7ef56920ff451af15f98ea468899209.1790101179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790101179.git.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dirty_log_test already has BITOP_LE_SWIZZLE helpers, but they were
compiled in only for s390x, so every other big-endian host used native
test_bit().

The test fails on big-endian powerpc because it treated dirty host pages
as clean (because of the endianness issue)

w/o the fix the test fails with:
  Clear page 1 value (1) >= iteration (1)

Fixes: a049a377164c ("KVM: selftests: Enable dirty_log_test on s390x")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index af5eb0334a74..8189eaac713c 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -44,8 +44,11 @@
 #define TEST_MIN_WRITES_PER_ITERATION	0x100
 
 /* Dirty bitmaps are always little endian, so we need to swap on big endian */
-#if defined(__s390x__)
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 # define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
+#else
+# define BITOP_LE_SWIZZLE	0
+#endif
 # define test_bit_le(nr, addr) \
 	test_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
 # define __set_bit_le(nr, addr) \
@@ -56,13 +59,6 @@
 	__test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
 # define __test_and_clear_bit_le(nr, addr) \
 	__test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
-#else
-# define test_bit_le			test_bit
-# define __set_bit_le			__set_bit
-# define __clear_bit_le			__clear_bit
-# define __test_and_set_bit_le		__test_and_set_bit
-# define __test_and_clear_bit_le	__test_and_clear_bit
-#endif
 
 #define TEST_DIRTY_RING_COUNT		65536
 
-- 
2.39.5

