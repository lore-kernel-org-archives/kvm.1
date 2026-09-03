Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2972426C3BD
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 00:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394598; cv=none; b=eazmYODPC8Vily4eBRG0n4+Ph+fPtxKQD/nHz4mY/52LQR1Trfo2EGV5hJXAWAl+0KNA8DpnBc0CwY0ocPnECa5dolCbZp8UcOp+Issx0qinsp3h56ZUmTPzDGBBZN7bk+F/LqO3zsDH9kp2pJJYA4zGEICLwQxs09uobhMBlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394598; c=relaxed/simple;
	bh=VNMxHfCF57rf4sPCMaN9jxnJIYNyIk4cK2dPfuDaUq4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u4Z6NpReiSW1cMPTXPL/sMtuoFUPTB7Cff8R2egOn4rGndJ7KzI7jr601Wd5RTxnVJb/xQF07b3fQ4NoscHQ4EExnFbg2UDmz0nZPB2bRYc3C5wwtfP8XoU5cEsQpi6JV/Vblxq6EmmMPr9BXN+UgKoH7p76oZs0Z0Va5WawkR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uMTUihBa; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uMTUihBa"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d6f710f066so4642215ad.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 17:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788394596; x=1788999396; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qVz8wagzKyX46SkkmDSLmjOUaaJbINqolgjBf3c/QvM=;
        b=uMTUihBah3GRyzOAU9EZIXHtUGM72Xf48JaoS7QJyLVFQ7X2EBAyWAN1kXxHu0JqRi
         vHWQPMJvSnfU/R0lJBFqAsx01c5htp2XpJfEZRN2fv73RA6rHyQMlEkei8QkuYC8/QZD
         DL4zJQgKn3HSxKQ6mwTJP2cW+nGFqYwuKAaR1EM1dLochnZmvMZDNLYsAkLsuCjnR+KF
         bmopTVkPCj0GG2xlph5lYnT1ObUWroMpwIQejuh77arodZ6XUAhQn6CRwoukonSSCs3P
         ze4FhqyVPhRMGD+Xe3w6fRuac+Th2WQQiEj/BbgNNUsR7wRyBf4+/GkK0RwjUCiL9b8n
         0a7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788394596; x=1788999396;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qVz8wagzKyX46SkkmDSLmjOUaaJbINqolgjBf3c/QvM=;
        b=R45CCcZ9OntP9gAIviQiiWK/cJ+FpRiMaBUNQ1dHICwX+ItYoDaneC0cyiWegxf4ZG
         gPyEK8oVRi6a/vs4gyq+oy1UNArC0g/XW1ALtQxqypTi2b18DkXWxtiXHib/3TDJ2G7A
         FhJPaFhY2eLAcqNAuifSPKFqAyfXoypsZKTn+/KluHKie3QIC21aHS0cINmepeTJ11FJ
         Zo/GidD7NRRfXaiTQY2hMLjJu2ktBywHnqUetXFHqfA+/SMkP1ZdbEagmFPHvLkJSgvu
         ClPWoLyd1xClixgyTMLdQjwzxw+H4xowU7FhqYyaUh19Bg4EN0X0t19AB2AAXeVydXDZ
         /kBg==
X-Gm-Message-State: AFuF++mweJvTXeq6PVJZ/pGqjfwLGTvTLO+xTpyGtveH4DnB5jddDHun
	Dk2WLyD4Xb2QiDP62aOo7YuWxHgaNZOOC4X0KeppTVTHZZhezT9WbNGOqdZSlUmVYXLBGXWzDQr
	6b1aiww==
X-Received: from plbli14.prod.google.com ([2002:a17:903:294e:b0:2c8:903:9ae7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce8e:b0:2d8:d4d2:d138
 with SMTP id d9443c01a7336-2dafb136d0emr20975865ad.20.1788394596052; Wed, 02
 Sep 2026 17:16:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 17:16:25 -0700
In-Reply-To: <20260903001625.2792367-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903001625.2792367-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903001625.2792367-8-seanjc@google.com>
Subject: [PATCH 7/7] KVM: selftests: Skip xAPIC IPI migration test when forced
 but unsupported
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shivank Garg <shivankg@amd.com>
Content-Type: text/plain; charset="UTF-8"

Skip the xAPIC IPI migration test instead of failing outright if migration
is forced by the user, but is unsupported due to lack of NUMA support.
Failing the test is arguably "fine" for opt-in behavior, but in practice
doesn't allow running the test in forced-migration mode in any kind of
automated test environment.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index c5b506eb5e7f..2362bf272e80 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -469,8 +469,9 @@ int main(int argc, char *argv[])
 	if (kvm_get_numa_memory_nodes(&nodemask) > 1)
 		test_xapic_ipi(run_secs, delay_usecs, true);
 	else
-		TEST_ASSERT(!force_migrate,
-			    "Did not find at least 2 numa nodes. Can't do migration");
+		__TEST_REQUIRE(!force_migrate,
+			       "Need at least 2 NUMA nodes to do migration (nodemask = 0x%lx)",
+			       nodemask);
 
 	return 0;
 }
-- 
2.55.0.970.g62bdec98f9-goog

