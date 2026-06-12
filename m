Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE8430BBAE
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225282; cv=none; b=HnxOQbIuPQNpH3HFYdkXTPRJdczfgwQECltV6vwmHb2gCdNhAImKHlYH7kzJFtuDXljoeTA2YX4Xh4P3xxllXdd33QMKHjHETRQA+i9fPQM7/JLa+cYsmgMk8OEOQIUT8tVMGw55HIuexLoHUMokJO9Bs66ZVA9Olrk9k3/dnhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225282; c=relaxed/simple;
	bh=h577BVlhwjyZstuTojkIOjtR+O6WptqK1x/M0F8lpFk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f+QbnCbZpBCx4rAROxyuBm1L1ZQeKPDvk6P8sD98AolF8d4pRFwnIkQiauVz2aFnBZyTGWk/ro24bSCghIgIcDXY4V01hskz8ieDoghMm7gQKYr3EheZ2CDrfuRZUJ52FjZtzIklQPe2P7Xr3VYME8tt/V6fSgSMjwiczkkGiAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HbcA/ZEv; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HbcA/ZEv"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8581f7723aso194184a12.0
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 17:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781225281; x=1781830081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rzhWZbWsHS56Mtm1pqdd6qpzGzN/wkzZl+RW8jbUHfI=;
        b=HbcA/ZEvv79xfMl1jU1LfEoAqweC8CogPmi7h1qvRF7tsBKvT5d/sLWQY5CWwOb+TF
         2hUeZ3kZyIfZ+8VbO+v8vqzO39oAzd2aQd2nzoQfvUHZDsIOWAxqtyz+EsyquMUvcsto
         +rMz+FgXn8q5HhvxZfHojHOvACAvIyOjaGm5pSumTC1a7Q3xm7t6tY4zvWwoDklu+fQ1
         uychZzy9pnkIpvoK8APM6h2OTV3f7VAs6ZqGM61xH8x90SkZgx6nSLmVLAaDjMx1i8rI
         CeFMQ0vftyixQ+StR05oH7bKO4+SJbtD4Zb0I5vnSyiJm9boKkyIX1hrHD7jNY1s5tNX
         QhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781225281; x=1781830081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzhWZbWsHS56Mtm1pqdd6qpzGzN/wkzZl+RW8jbUHfI=;
        b=Oj6uBiedJjO8tpbtylTKn7txUiMz6BA3IqzWEKg/e9zf7YUOZlTa/9hg2xMANYP1GA
         7edL+UOER1SzT1qO0hicuW3hmUZUqe8QclXbK/WuhU9xZIhSrhnsRw71q/Ug5bVmaBvg
         h4fsSZlS5e0NRTLb3AbLQ1AQS21mjncJ10q2EZp+M0S/DwY4430ihHR3hfOCBlexvR2V
         6ZFC+wAfjoNm4Zt7FWmHqiqB0w+A8A6Usz0Q94FyCEORWNYS18uHCn3bNS6W6KpamWDQ
         MmgXdMg72K1s4nmFc1/eTPgoqrZPSsdmt66GqKTS417RvJbZI1SDQLaZwhBU7mBDMjvt
         /UtQ==
X-Gm-Message-State: AOJu0YxNPUETLJaiuSe7NtwQODCauh4p902Aat9M9Uj5YkoGsHSzSUT4
	OgSgmjCquhqrd3M8/6qMJ6a1ds8hh9iGdYK2mRQBfRdDR3TzFZ160qKfc1lcuKj3YEYnTGxL7VF
	pISvjhg==
X-Received: from pglx30.prod.google.com ([2002:a63:171e:0:b0:c85:78c2:3f99])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:2208:b0:39b:d5f1:4ff
 with SMTP id adf61e73a8af0-3b783bb62cdmr673696637.20.1781225280400; Thu, 11
 Jun 2026 17:48:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 11 Jun 2026 17:47:47 -0700
In-Reply-To: <20260612004755.349925-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612004755.349925-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612004755.349925-3-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: guest_memfd changes for 7.2
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a few bugs found by AI (mostly by Sashiko pointing out pre-existing bugs).

The following changes since commit b7fbe9a1bf9ee6c967ef77d366ca58c35fcf1887:

  Merge branch 'kvm-apx-prepare' into HEAD (2026-05-13 12:38:31 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-gmem-7.2

for you to fetch changes up to 48dbe473219832788c3940c84faa7f1df4375d5d:

  KVM: guest_memfd: fix NUMA interleave index double-counting (2026-06-08 09:15:43 -0700)

----------------------------------------------------------------
KVM guest_memfd changes for 7.2

 - Return -EEXIST instead of -EINVAL if userspace attempts to bind a gmem
   range to multiple memslots, and fix the test that was supposed to ensure
   KVM returns -EEXIST.

 - Treat memslot binding offsets and sizes as unsigned values to fix a bug
   where KVM interprets a large "offset + size" as a negative value and allows
   a nonsensical offset.

 - Use the inode number instead of the page offset for the NUMA interleaving
   index to fix a bug where the effective index would jump by two for
   consecutive pages (the caller also adds in the page offset).

----------------------------------------------------------------
Michael S. Tsirkin (1):
      KVM: guest_memfd: fix NUMA interleave index double-counting

Sean Christopherson (4):
      KVM: selftests: Remove unnecessary "%s" formatting of a constant string
      KVM: guest_memfd: Treat memslot binding offset+size as unsigned values
      KVM: selftests: Expand the guest_memfd test macros to allow passing the VM
      KVM: selftests: Add guest_memfd regression test signed offset+size bug

Zongyao Chen (2):
      KVM: guest_memfd: Return -EEXIST for overlapping bindings
      KVM: selftests: Test guest_memfd binding overlap without GPA overlap

 tools/testing/selftests/kvm/guest_memfd_test.c     | 24 +++++++++++++++--
 .../testing/selftests/kvm/set_memory_region_test.c | 31 +++++++++++++++++++---
 virt/kvm/guest_memfd.c                             | 16 ++++++-----
 virt/kvm/kvm_mm.h                                  |  7 +++--
 4 files changed, 63 insertions(+), 15 deletions(-)
