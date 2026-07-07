Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06173F23B7
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436832; cv=none; b=QwCQxXr6nT3JSlFESy9UIMPgMvvwUYW1HW3uUszeyj/HL40xDZL6qbM9igGGFEmLjaF0wxIuQrf+k/IgsPkw/GsZrkmOTx8pB+KGnEmDBEGHH9/OUcAU6+j/ZiY0g3+itdK0FLd1eUxPuDyzYfGIJ2Hr0lWpaqtdMGKWYMwx2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436832; c=relaxed/simple;
	bh=LhiThOmJWwd310uCyAblP2lzwpwUlerjiRaIWhug/Cc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JhFjeFDb1Lmjno09mE4hkRc3Rc76ChrBqPCMbEpdY6Cxi4O+qGihNMX81T4koX6qIFptRMIgmLMgkMqshmtEQXk1JbpoKJKAQP6N2z9B64C33DTEeuOufL6QvMnGewwtasCmazeGJGo6r3rZn70Xg0HJwRJZ9Reb6/yZkDqRjuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHGyF7sS; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHGyF7sS"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c9667280edeso5325018a12.2
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783436830; x=1784041630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=51Zf3IDuE4sypJ9regZpschxKTWWYvVW10OTQEtNGg8=;
        b=MHGyF7sSm2ED38gonfeFGjNHIuyt2I6L5JbbA6O3/4mSO5B95j5Im25659Y0eiTlNG
         GWDrQLRkBwGAEkiWd6hz7I6S0pIrL/mn3MfhJFAX6VV9vBvkMvEgsNHAlRHtQkcChhss
         JVDiRCRaFa2dnJwZyX1k4smVrxq/z8KEErAGOMBJwvhieA1ciEVa1bS5b6F28Iurb+/z
         vSnxXaLYtmz5Z9c/NI9Fr6QTb5OzD8HP9xVpUk1gIY3QFTTrRMnjWsW03Hgpby7wMlZm
         rtIIoKr48VlY5w7OX6uZL0SeuMYSuC9WJZtbGYbWHPCDGiaRR858/WyeSHr5Qs71vOVV
         yO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436830; x=1784041630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=51Zf3IDuE4sypJ9regZpschxKTWWYvVW10OTQEtNGg8=;
        b=GwHn5Z5qJRYxUMcx11Gz0EbOmCGqwms3nP3mMAlcPlCYoq3qkKvYPbD/2xwgKQRKFu
         keZLRhlFW1TEIjYOlukmX/cuGGpwqjtJsPGwA/NfTb/HeUvFqlwXPz9kloqq47aPd+bU
         vGs2zSN7P4DixfMoKf6LOZRxm0GRiazwFO/BWcJd9M7k6Rh2osyoI/d4xs0aSVCdIMWH
         F3mL7MmT2w1pYOp5qBcU74oNIx1w9H79fiiouPBRP5FeJNRrDIPi6Vx8QiPVaL/QsASm
         ZJGJ+QWj6AkECsh8c3AEAZydFqI0cd4fdTIaYOmFeVVoGz71spHNbB8zX/JzQ5hlIvCx
         S8Yw==
X-Gm-Message-State: AOJu0YwtNNiuk3fj6Et+Htf9REu2UTsjQ2wBmi34VY2VOhCMoEKMNn3Z
	Sgnz5/0MjzIt0KykjP/yQzT9SzHE2Hf+p4PChNqFPezK0KriiLeIDrAlXequBiWLeopSwz5IgM/
	OQuxJGA==
X-Received: from pgae25.prod.google.com ([2002:a63:3719:0:b0:c8a:604f:6851])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:430f:b0:3b5:4fff:fa0f
 with SMTP id adf61e73a8af0-3c08edb2694mr6942467637.14.1783436830098; Tue, 07
 Jul 2026 08:07:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  7 Jul 2026 08:07:06 -0700
In-Reply-To: <20260707150706.1198541-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707150706.1198541-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260707150706.1198541-3-seanjc@google.com>
Subject: [PATCH v2 2/2] KVM: selftests: Randomize pCPU in steal time test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hisam Mehboob <hisamshar@gmail.com>, Aqib Faruqui <aqibaf@amazon.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Pin the steal time test's tasks to a random pCPU in the system instead of
hardcoding the test to always run on pCPU0 as a cheap way of increasing
test coverage, and to do the "right thing" if the parent task of the test
doesn't have pCPU0 in its CPU affinity mask.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/steal_time.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index a244bf9f701f..92e7ffcd68b7 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -514,14 +514,12 @@ int main(int ac, char **av)
 	long stolen_time;
 	long run_delay;
 	bool verbose;
-	int i;
+	int i, cpu;
 
 	verbose = ac > 1 && (!strncmp(av[1], "-v", 3) || !strncmp(av[1], "--verbose", 10));
 
 	/* Set CPU affinity so we can force preemption of the VCPU */
-	CPU_ZERO(&cpuset);
-	CPU_SET(0, &cpuset);
-	pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpuset);
+	cpu = pin_self_to_any_cpu();
 
 	/* Create a VM and an identity mapped memslot for the steal time structure */
 	vm = vm_create_with_vcpus(NR_VCPUS, guest_code, vcpus);
@@ -557,7 +555,7 @@ int main(int ac, char **av)
 		run_delay = get_run_delay();
 		pthread_create(&thread, NULL, do_steal_time, NULL);
 		pthread_getaffinity_np(thread, sizeof(cpuset), &cpuset);
-		TEST_ASSERT(CPU_COUNT(&cpuset) == 1 && CPU_ISSET(0, &cpuset),
+		TEST_ASSERT(CPU_COUNT(&cpuset) == 1 && CPU_ISSET(cpu, &cpuset),
 			    "Worker failed to inherit parent's CPU affinity");
 
 		do
-- 
2.55.0.rc2.803.g1fd1e6609c-goog

