Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153993FF1B5
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570330; cv=none; b=FQq3s8aFDM1YNw65cDCyPWnXRsti8WWCm46rDe8RUi+LpkS9/zaQ2nYkgTgA3WbEUHGrLucr0sGBvrombx3AxlAuhKZP+xF49PT3/mKtarPSS6zGbxUdYSaB9Mw7b5eTOZRyl+W5LPBXDNYDYLRUtz68rBt1SuX9iDA3ra4cs1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570330; c=relaxed/simple;
	bh=kemoY3aQxOVUdDleIsI+onpBuAIPxc53kVK7/nXwoGQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XpC7uHJLB7Elf1Mntg0tbi99LlA/tofOFwEWhhBNyfo7cs+NL/5nCTzqcRNgwFRKomc0ThkYmUYiJuOkyTOv6WXKAruzi0avT+JxIvhn5FyOPrzSPbqY16T3tMsxTByfuQSuNz2aK51kHday1ZPWGaSYmSVFghRwXz+rtK7mEoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TgNEREgJ; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TgNEREgJ"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c856470fe9fso1060619a12.2
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 14:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786570328; x=1787175128; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZuaB1aoPua3m6YDiQH6bIb12xUUZmxga9nZo2Y6efJA=;
        b=TgNEREgJT92NX8Yl2WRh/BcT/vsS6gybaULiywQe3H3CovRHk/rvNqb7BiMpp6Psg2
         SSiFvuYZZcz8RV6zSS6bulAmWhmy/xDn4KbFi0lZx3NbUt31aFgPJ3aAd6VXBiXuRg+m
         A4Xt8t93NW3gCGUTKCRI5+maPOJCeVESLiP8wQUByzC4i5P2VMmyD01WGkMh/0wqBK0o
         NGFW+667pU2oqEHM90gQBdt1TUAwxODtSWz62QL87+xoJtYuBiPjZnXO6ch9yTN7QmNI
         Y7kkt/peAH4nk17ZC2SEaPkQ9t9VgTVfZcUTC+/pOrXUyUil6bIyqYfBj3/+HLWw4IDk
         16mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570328; x=1787175128;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZuaB1aoPua3m6YDiQH6bIb12xUUZmxga9nZo2Y6efJA=;
        b=HbbgGa2EB/9WKkuh1RW91wGufWPY+dtrMOMxyj58KKocDqhUXTpeOL26KCoPN2VDPA
         o/CigbWOuuHwvgEo+hgO90XxCRVgG98DKHL9eXXkAl6zEZlLqxa4sEZt8G6wF5zb52IF
         G78mU1HISYsjC5M489rdyluUOgw9zNmVFtI03izEtq8wXnSfhVMrT7zLbPWqV6PlpA7R
         Cp2EZq5PFWpLdBblAR5IUKYtPjpt6ddkLEjLCKRJZ2bB535paPbd4U2A8tE1lkU+wG4z
         ZuZ69ujW3rKOrYAPQKY9SFL4KkltzNrAro9/YMQ7FPnbvVL3MctpF5yuGmsHxqRqGs19
         KdJg==
X-Gm-Message-State: AOJu0Yz1y/YBcR1fzt88i3vsrxkpVerPOe+hIDeh1kFSPYnPwxIJrkiV
	hz7Ifi5UcDG7xqeYfFGnf6Cc0ZU6hbsiI3RdJLkSLZmlaVLlUtQjvCCUprBsNRIneWfjn2xZWJg
	OT9zUaw==
X-Received: from pgvt22.prod.google.com ([2002:a65:64d6:0:b0:c93:72f7:5d59])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:728a:b0:3cb:9594:91b8
 with SMTP id adf61e73a8af0-3cc55475441mr1461297637.35.1786570328198; Wed, 12
 Aug 2026 14:32:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 12 Aug 2026 14:31:55 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812213206.1564354-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86 pull requests for 7.3
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Nothing super unusual is cycle.  I did manage to end up with two selftests pull
requests, appropriately named selftests and selftests2 in the spirt of KVM uAPI,
with a minor conflict between them.  I originally created a dedicated topic
branch for the new irq_test to isolate a dependency on the VFIO library, but
then realized I really wanted to use some of the new infrastructure APIs in
other tests.

Assuming you merge selftests before selftests2, the resolution I've been using is
to use the kvm_ prefixes pthread APIs (which assert success), but otherwise keep
the functional changes from "selftests".

diff --cc tools/testing/selftests/kvm/steal_time.c
index 92e7ffcd68b7,83a1e3aa15cf..6e9cc0e34ec0
--- tools/testing/selftests/kvm/steal_time.c
+++ tools/testing/selftests/kvm/steal_time.c
@@@ -553,11 -553,7 +548,11 @@@ int main(int ac, char **av
  
                /* Steal time from the VCPU. The steal time thread has the same CPU affinity as the VCPUs. */
                run_delay = get_run_delay();
-               pthread_create(&thread, NULL, do_steal_time, NULL);
-               pthread_getaffinity_np(thread, sizeof(cpuset), &cpuset);
 -              kvm_pthread_create(&thread, &attr, do_steal_time, NULL);
++              kvm_pthread_create(&thread, NULL, do_steal_time, NULL);
++              kvm_pthread_getaffinity_np(thread, sizeof(cpuset), &cpuset);
 +              TEST_ASSERT(CPU_COUNT(&cpuset) == 1 && CPU_ISSET(cpu, &cpuset),
 +                          "Worker failed to inherit parent's CPU affinity");
 +
                do
                        sched_yield();
                while (get_run_delay() - run_delay < MIN_RUN_DELAY_NS);
