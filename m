Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0D379C32
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436832; cv=none; b=h2z+e/Ef/V6HjWL+zy7LIkSF21JaJsv45NHU/zH/WD10+FFNbZTUcAtvsle36jsCOj13AhrnjXjQukeKD/CplhAiDvDq3izvuORjif1qCM0M0SyEQV+iDjjB44TmVjY9AubSw1rUbOvz9HdPP1BeuDEIZsY59RNPKX1WEqo0iNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436832; c=relaxed/simple;
	bh=9erd4cBVBJa3uEIr029+1/I9c1eDfRkoPQMBOKO+YAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oXmyqiAO+eKwdUGQEhWbzfY1XElZvcWFtEV9G2wKXhmM+FNPxiZcjIK341sRoc0tnbxrc6/rNcT7ApiStsY1IRi0AqKlssPefeBOzi5KBYpm5Ziua5UdpR/CIDvFygBZvKEakozbechIJy6o5rMBzkFH1U5lt92bYO5RmwP+kIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fievwXAJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fievwXAJ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ccbb61893fso19913755ad.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783436829; x=1784041629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Mkd+w35bwKfSW2jKiuODwkfo0RpVyNUij/RximFBPg8=;
        b=fievwXAJsOvwEzxg5s2SGp1wGud0YNJcbsklUK99KzxfSRc4bA5f3OgxKj2zYjby52
         pTb9+gKWSO0B0w1+fKKFueQG0JjIWFet1gj/PZFFe0ZlztjPDyDxvMt4VPvWYi2ui4Us
         5XsjlaUIk+YODMurrIvdBmV6vbtpZA8j5i5KhCxdwyPQ5fEAemENtHxivUcuMtg1glCI
         ZKi4JHreQrQZzIt9RMYEKlh2NctosdpCnYKk+8RDCxLJQ8tqeycEcUCTwzmYkTX3boNk
         vCHG6x/yjCz88rzm3KS4e3VgijxmKUmE+JCPN18wv06j2i/lf4alQwOunT1h1Cea6ID9
         ybIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436829; x=1784041629;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mkd+w35bwKfSW2jKiuODwkfo0RpVyNUij/RximFBPg8=;
        b=cXDH69B09eqQCe2GQdDjUlfBjqxC4Vo6kS4DHS/EZxN6t8DJ1OdNdFd56U9GlqHbSW
         kxlRny0rlQh7eggUwVT9eyNAZMK0QX4ydV/Jw+boc981RjcM2DP6Uy8wAHXIfib0ugeO
         0UKvuRML27roWte9uvSkvZgzMqQD6mBNFHjQakKAZk7isPX/HGGnu7kB1mytuePPXDm9
         Wm9btJtceAfCyz360gqrEfTnauF0WITCudDo7Oi9XT8i9CAWxQuDxOvx6GG/K6IHjQI5
         L/2Gq83t0OrQFIlHlVPJ9NwGWuB3AHRJyJmS0LC9Ihi7KC0qeIJ2v1LNpgvtoX57SuLe
         XtgA==
X-Gm-Message-State: AOJu0YwOMJlUUqTHvzpxbzFEqyL4dljed1oLLm3WwgmPMrsq/eS29v9Q
	CKJ9z01yDCvMPSs/DVdfDmStyfFgB+TE8hJxebZCTD6kvuw0EXZYdN65sRIi7t3paRGfRM1V52h
	N5E/Eqg==
X-Received: from plqu8.prod.google.com ([2002:a17:902:a608:b0:2ca:6d6d:5267])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3845:b0:2ca:ed41:d337
 with SMTP id d9443c01a7336-2ccbf189068mr56784025ad.43.1783436828897; Tue, 07
 Jul 2026 08:07:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  7 Jul 2026 08:07:05 -0700
In-Reply-To: <20260707150706.1198541-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707150706.1198541-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260707150706.1198541-2-seanjc@google.com>
Subject: [PATCH v2 1/2] KVM: selftests: Drop superfluous use of pthread_attr_setaffinity_np()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hisam Mehboob <hisamshar@gmail.com>, Aqib Faruqui <aqibaf@amazon.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

In the steal time test, don't explicitly set the CPU affinity mask of the
worker child and instead rely on the child inheriting the affinity of the
main thread.  Per the pthread_create()[1] and pthread_setaffinity_np()[2]
documentation, new threads inherit the parent's affinity mask.

   Linux-specific details
       The new thread inherits copies of the calling thread's capability
       sets (see capabilities(7)) and CPU affinity mask (see
       sched_setaffinity(2)).

Out of an abundance of caution, assert that the child did indeed inherit
the CPU affinity mask, as the test will hang indefinitely if the system is
under light load.

Dropping use of pthread_attr_setaffinity_np() allows building the steal
time test against non-glibc C libraries that don't implement that GNU
extension.

Link: https://man7.org/linux/man-pages/man3/pthread_setaffinity_np.3.html [1]
Link: https://man7.org/linux/man-pages/man3/pthread_create.3.html [1]
Cc: Hisam Mehboob <hisamshar@gmail.com>
Reported-by: Aqib Faruqui <aqibaf@amazon.com>
Closes: https://lore.kernel.org/all/20250829142556.72577-4-aqibaf@amazon.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/steal_time.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index 76fcdd1fd3cb..a244bf9f701f 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -508,7 +508,6 @@ int main(int ac, char **av)
 {
 	struct kvm_vcpu *vcpus[NR_VCPUS];
 	struct kvm_vm *vm;
-	pthread_attr_t attr;
 	pthread_t thread;
 	cpu_set_t cpuset;
 	unsigned int gpages;
@@ -522,8 +521,6 @@ int main(int ac, char **av)
 	/* Set CPU affinity so we can force preemption of the VCPU */
 	CPU_ZERO(&cpuset);
 	CPU_SET(0, &cpuset);
-	pthread_attr_init(&attr);
-	pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), &cpuset);
 	pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpuset);
 
 	/* Create a VM and an identity mapped memslot for the steal time structure */
@@ -558,7 +555,11 @@ int main(int ac, char **av)
 
 		/* Steal time from the VCPU. The steal time thread has the same CPU affinity as the VCPUs. */
 		run_delay = get_run_delay();
-		pthread_create(&thread, &attr, do_steal_time, NULL);
+		pthread_create(&thread, NULL, do_steal_time, NULL);
+		pthread_getaffinity_np(thread, sizeof(cpuset), &cpuset);
+		TEST_ASSERT(CPU_COUNT(&cpuset) == 1 && CPU_ISSET(0, &cpuset),
+			    "Worker failed to inherit parent's CPU affinity");
+
 		do
 			sched_yield();
 		while (get_run_delay() - run_delay < MIN_RUN_DELAY_NS);
-- 
2.55.0.rc2.803.g1fd1e6609c-goog

