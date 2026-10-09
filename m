Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5134A4EE2
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545551; cv=none; b=hOV5w2XfzChH02pzQDcDEcTOYRw9ixqMuI89gSClQIJw5M5KrsB4X42BStGJvXdgj4X/JYXoydcWfsMjEHxyaNcYRE+2ObCaQ4ymT2Hej61NPX1iW4uupkX3EIk1K6UOFUWHEVHKykBJXevVnmoukX/R7GNL0X8tF/gTdGh83JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545551; c=relaxed/simple;
	bh=JOfTL5sJbEeKUPqnV8GkeCHd+99LXw7TYpKTV4o3L18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FEHP0GrBnnXQC3HGYWS9E8HDkG80antJ2fIjfCApmEiMMPyP0aHhEzOpJXZO1hhobVhz6qg90LsURp82lBq6s2xnqNP8GgvGdW1PHpH+haidUyiytbX7u7P9OO1MgoB7PTUe0O1UnmuUsp9aEupRrV8Px2pOaoXNks/s2t+n2a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/eXhsNR; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/eXhsNR"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-34c4a0868b6so5778086eec.0
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 04:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791545540; x=1792150340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5bMlxewub9p/T2xvh3MjzZ66gKld4I4neePTrZHO9Yw=;
        b=k/eXhsNR+usBjAXoyI5R3hSe/Tls1hLcb1FDLXE8BloAjRwR9NnUoowy4K0J4VaY+2
         IPRF1OHh048i2B2/zHyy39954hSnu+A3kkF0or0OgBdkM0uKwI55NE7bMBEpMKcfXhe7
         cmGrnX/2bKOTt1aSnJN8WvB9dFrf1iamKPwQyExe8oY3q+7kwg4ZpGSwj6sdsoASO7DT
         EmHK4dQTchqXroWSTorMQEm2sjx/tYbC2lvvBmNVIbUMhpLWhaSmKt6/w2vaCtwfiDoL
         wBcKmliggW4a54Ia3Fvbxj2fd/vhNmAWgk2yWuzwd+w/ybh/qjx7wEX1z8k9MmJQlLh1
         inSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791545540; x=1792150340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5bMlxewub9p/T2xvh3MjzZ66gKld4I4neePTrZHO9Yw=;
        b=zQ4uqHrovAb8nOSiv/uWtNHne6A3DtckivADJTJx55gUcYMC6RKOfG2uQ+9dlYjrVZ
         BVLCPaBPZSfGwQS47l9I0CuiWRr94G1KQBBzNwn4mvr24ThqlysMvf1Nk36mOW9iVHZp
         S73bfQTnR70KmYzrNV7RmYo/qN9dk11TgQVA3UPRLgpevjf5b4qaSvzZYxtvtxyR5SMY
         Nl+SnqktH7OGiw9uHcsqAJGMWw+FyNHlrOf5sHewHVUvtDiHZ1IyPIHf7h/Or8lsRrfK
         V5kMjUGvcQjSeHJg2bLFuPd01buklAaiGA4ykUB4rj2AbGI2TqkoxzQiipnCi6XQKbkP
         At2w==
X-Forwarded-Encrypted: i=1; AKwUvByuQ5+hkUXKhgraugHjQbHO/MPtcEs4XC9PEDTFwgaeS5UKs6DkI9TK2c2mXqU+jKr+594=@vger.kernel.org
X-Gm-Message-State: AFuF++nM03Sk6xbtdMC+pL8cDOW7PrPXbzZSUnVS7FISLHzA/cwepnec
	Aw5XZNnSmGLV36wQxXEwQpUKFjlaoS4ByeTPxkng3RGTNN/5BSv5vxMb
X-Gm-Gg: AYBFou3AgXnuroISpr0tKionUzsZIWa8n0xrTF32GGqMO6TZqkynTxLwdsd2HerubtX
	mljsVt+k9Mx4nKQuUGBtassBPQlnIWDzE6UapfhcMPxJs7LlvHZUWOuPDBFsbWa/M1XhuyPyzdC
	fP5yiIfm+TvTdJhzXyTneXxfXF2FTsQI8WyWdJVGd4BmFy5i1Qq8wFYX28aX1K1upRjnutLDVdi
	18McGBbApuywIMzOGwQengXvGG4LWnINO853xrADNPWdHrN4ePhLAGZ82aHCSugxyt+wLx4SSJW
	k6NM8qqU1v1/xVk17ZUQLtviB8mKZsecURSNjZZ6/UNm2FWCqEEMx6dYc77UC12GJZa7vZJgbEy
	E+N4pfRQ+ifV9z0vrVf5gLiqwGRqREHFej/CrV9W2OqTkvLCBe0V7oR3gd817rDA80nOIIoPUo5
	xy4L0eKe0io/cT3hAaHj+AP2vB/2hisa7BNQJtdyGNf9ofRBiLTPvmQweS64n1f4UVaHHvKN3p4
	xsZXAlF
X-Received: by 2002:a05:7301:dd95:b0:353:58b7:b5fa with SMTP id 5a478bee46e88-3535f48136amr3132590eec.1.1791545539457;
        Fri, 09 Oct 2026 04:32:19 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cab27d5sm7529934eec.17.2026.10.09.04.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:32:19 -0700 (PDT)
From: Priyanka Mani <priyankamani2100@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Ivan Orlov <iorlov@amazon.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Fix ndata size check in test_mmio_during_vectoring
Date: Fri,  9 Oct 2026 11:30:17 +0000
Message-ID: <eef6bc34bdf7391c5d3eb4b1ba5e97819e22ae8f.1791542392.git.priyankamani2100@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_mmio_during_vectoring() verifies that KVM reports the faulting GPA in
run->internal.data[3] when an emulated MMIO access occurs during event
vectoring.  kvm_prepare_event_vectoring_exit() always fills five entries
(info2, reason, info1, gpa, last_vmentry_cpu), i.e. internal.ndata is 5.

The test, however, checks "ndata != 4" before dereferencing data[3].  That
predicate does not actually validate the array size: it passes for ndata ==
3, where data[3] is out of bounds yet is read just below, and it spuriously
fails if ndata were ever exactly 4.  It only happens to work today because
KVM returns 5.

Assert the real expected size, ndata == 5, so that the subsequent data[3]
access is properly guarded and the test enforces the exit's contract.

Fixes: 62e41f6b4f36 ("KVM: selftests: Add test case for MMIO during vectoring on x86")
Signed-off-by: Priyanka Mani <priyankamani2100@gmail.com>
---
 tools/testing/selftests/kvm/set_memory_region_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index dffe9654f45b..627ebc2ba024 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -606,7 +606,7 @@ static void test_mmio_during_vectoring(void)
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_INTERNAL_ERROR);
 	TEST_ASSERT(run->internal.suberror == KVM_INTERNAL_ERROR_DELIVERY_EV,
 		    "Unexpected suberror = %d", vcpu->run->internal.suberror);
-	TEST_ASSERT(run->internal.ndata != 4, "Unexpected internal error data array size = %d",
+	TEST_ASSERT(run->internal.ndata == 5, "Unexpected internal error data array size = %d",
 		    run->internal.ndata);
 
 	/* The reported GPA should be IDT base + offset of the GP vector */
-- 
2.43.0

