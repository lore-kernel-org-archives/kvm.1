Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8142C4F8
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510544; cv=none; b=ihR59/s3HgVibOoVVKe5YSHcr1vLmMnzV1sNrA1xHvewC+C/4HbgqcdE5X3DP+fr9Mf2BoptPolBWzGcEpsRqmpibx79wmGvd8C3zfB5o1dD+RFfvqfQPvPQc+ka8ZUQQJiWYqBwIw4QhjUOiT6lC8tNn0WXTHGgA4L20GDqFgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510544; c=relaxed/simple;
	bh=PjftAuv2yr6Vjpq2LJcpoHcflcYedBC1wROWFSqGAD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWEox1X0YBo77JweMxuilObHtEbw5UtPQOJzjohi8q4XoPbKtjBWehX/FZ99PUJSwtXmSoms3yC5f3VHLs/ZGQiTCcFFHfwuGfxcZq5FEFB/Qhi3DjZW3rWSGndMjyaRzeCo0CBinhhVp3ts+K1QCicff2jGNmc6nkixan+QDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bec7yMKm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bec7yMKm"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47640541585so845843f8f.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 08:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785510533; x=1786115333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=08UPjSfOMysoSxYNb3E4BPj3tXXgH1/oLdaZMyb7X1M=;
        b=bec7yMKmoOZQrXSDvg/6fQwaPMw6x841jOAKcdFlX2ykP2QgkhX0YkcztjwwF1PPs8
         /bVyomgLmTRM1kmlXGtqWrxMd98VLFPhqaunHuRH4DkfPZS6sX2ViFxZMSHA9Zdnx5fz
         IdVc0uYPjlL0vaJ8kz1pnr2Tiz98JYEfTBNrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785510533; x=1786115333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=08UPjSfOMysoSxYNb3E4BPj3tXXgH1/oLdaZMyb7X1M=;
        b=ObpEUyFAsfiKdTXwspMtBG4jhL/ijil5Xe+Fowu461JWjBE5scm3x4kCMzFLuueGzm
         Lczt82kkunrA3q/tpZ0stsOC9BSznm0M2XGXRStef/go15R7M8uwa0pFG3srXQ/Gwweg
         HoaH7P2IPfhBtXVI6GLmOwgZ+67FvzUb8rEgYt4WcxhQ1Kkl2r+tr/zM6RnlCbhPnsRJ
         TBRW3GiV9hGnMkFXJqwU835mgL2xzjBvRZgOwVYKErHuKZPdMtJgEXEq9i+IhG74PbTy
         QpCW5tV34Kkn1DOa4+2qQMA5OtBKtbJ81fIXfn4C3m+zziNwczYtgn5OlG/hfnlHHmOz
         uWhA==
X-Forwarded-Encrypted: i=1; AHgh+RrK19Bd7gMrFDz4lA9tgUbDWDVSqTKwlIO6GCe401LAWz15VrpeVZ065sF7Ifc+kIGsUfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybbi7exboRRombzY9SLzIgIThBzp6B3JlOKwRB3jRQJ9nFY7LE
	hhJLAbp1rnE1X7ZVKyyHSMWF+/FrDjGMfWqFIbU+uwKKHOzklbuM45BLZNRTFXFlDQ==
X-Gm-Gg: AR+sD10uOwVvHuk6IVmQ6A9um3seFuoFPw3arAGHwWbjkojKM0zUCrtmM9Ev9BqBUyI
	uncpAXvWKEg7OnOBfWjmp3qNwKE2hWys0/bL8sxf6uytfYvvRymeatJWX2fcf7Wy/8PQtQUTsDF
	QEGeeQR9MYa8C4pYDqBCa1PMBLwQYGW0xBkQN5s1gSTctkIETzE9YCiQZoguhBo7OMAs7vmJ6g2
	cEbw9mNFhpJnTHN7zlB0NESpm8B6qsuAnb9j89svn7SmeyryBLH15GUrtYduYtoXbcvjU+CJHf7
	kMTcbmbIJC0SaUgdGp28ukyx7B1aEnupqPRqlJCrZpLpj0gdOByIB0lhmxJSqgK37S/HdgYyEsz
	sh5x2J23+ZONec8142VJHz0zAi5wvH7grl2ORvwOtTxaa6C3Sl185VgJZNfAdzHNvhPy2j9FDQP
	S+J1ExfbrdTVxMzhkjvTBKxnkxOucgfalCxWX0AAUhBm4Wsb5roNe7OVgJnxNAQjJFE3fWOaObs
	z2aY9ruCzfZiecIDJLAKPkj2h/0zix2hVcHgau1J1eH9ccwzFSfnbg=
X-Received: by 2002:a05:6000:29d7:b0:475:3a97:8e3c with SMTP id ffacd0b85a97d-47fd72b08demr21668f8f.18.1785510533265;
        Fri, 31 Jul 2026 08:08:53 -0700 (PDT)
Received: from dmaluka.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm5647974f8f.34.2026.07.31.08.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:08:52 -0700 (PDT)
From: Dmytro Maluka <dmaluka@chromium.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mathias Krause <minipli@grsecurity.net>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH v2 1/4] KVM: selftests: Fix treating KVM_CAP_MAX_VCPU_ID as inclusive
Date: Fri, 31 Jul 2026 15:08:42 +0000
Message-ID: <20260731150846.1728164-2-dmaluka@chromium.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260731150846.1728164-1-dmaluka@chromium.org>
References: <20260731150846.1728164-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM_CAP_MAX_VCPU_ID is (confusingly) exclusive, i.e. the maximum allowed
vcpu_id value is KVM_CAP_MAX_VCPU_ID minus one. So in particular,
setting bsp_vcpu_id to the value _equal_ to KVM_CAP_MAX_VCPU_ID is
invalid, it must be strictly below KVM_CAP_MAX_VCPU_ID. Whereas the
corresponding test in x86/max_vcpuid_cap_test mistakenly assumes that
it is valid and expects the ioctl to return success.

Fix this, by changing the "semantics" of the selftest's internal
MAX_VCPU_ID constant: let it represent the actual maximum vcpu_id, i.e.
the KVM_CAP_MAX_VCPU_ID value minus one.

Fixes: 4b451a57809c ("KVM: selftests: Test max vCPU IDs corner cases")
Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c b/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
index 7e2bfb3c3f3b..47ee14967873 100644
--- a/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
+++ b/tools/testing/selftests/kvm/x86/max_vcpuid_cap_test.c
@@ -36,16 +36,19 @@ int main(int argc, char *argv[])
 			    "Setting KVM_CAP_MAX_VCPU_ID below BOOT_CPU_ID should fail");
 	}
 
-	/* Set KVM_CAP_MAX_VCPU_ID */
-	vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID);
+	/*
+	 * Set KVM_CAP_MAX_VCPU_ID. Note: KVM_CAP_MAX_VCPU_ID is a misnomer,
+	 * it actually represents maximum vcpu_id plus one.
+	 */
+	vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID + 1);
 
 	/* Try to set KVM_CAP_MAX_VCPU_ID again */
-	ret = __vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID + 1);
+	ret = __vm_enable_cap(vm, KVM_CAP_MAX_VCPU_ID, MAX_VCPU_ID + 2);
 	TEST_ASSERT(ret < 0,
 		    "Setting KVM_CAP_MAX_VCPU_ID multiple times should fail");
 
 	/* Create vCPU with id beyond KVM_CAP_MAX_VCPU_ID cap */
-	ret = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)MAX_VCPU_ID);
+	ret = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(MAX_VCPU_ID + 1));
 	TEST_ASSERT(ret < 0, "Creating vCPU with ID > MAX_VCPU_ID should fail");
 
 	/* Create vCPU with bits 63:32 != 0, but an otherwise valid id */
-- 
2.55.0.508.g3f0d502094-goog

