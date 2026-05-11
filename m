Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D937266C
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499483; cv=none; b=Shx5IGYZno8rdsYjJhKqwjy5P8z1zQh21rMRcfGXzOrR6AarKHilSTy06iD+LkWkl2WTAtfTyrFUvYC3x0+SropWvhrYc0H+8jV4nFibimW5QlQS8KVtKvRjk2rLd6VZ9fXCOjhfeWkEuWCB2mQdNvTM8TZM3laYfzZnUZlRNQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499483; c=relaxed/simple;
	bh=0P+T7rPCjs7iIgf5SQUmV9PTFlEQbO/0gyt8XtRwZXs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PYXx0P6xnUII5OgPTj/4pIkmTGeJp1M/+yZ4hjYkHY+Sd+eJgFhXMv/v7V5BQgNz2tygrQvOTiHKc2/Wc7DJ/yCqugSquNSsR+1dNIlIzeUZxkWlWGJ2nx1EF48DROooK8AUXw38d/zEeIkcqxmkbWRZEAPPw7tp5wHeXUdy7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DYEyEQcm; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DYEyEQcm"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48e5dfa8ec7so22510875e9.2
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778499481; x=1779104281; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fboe0jcENvd9dSVpqW0NTYIFHtH+nnd298gI3HalAZs=;
        b=DYEyEQcms/cRq1l3AIHofOMy1lNk0pE4Kjzr/clmFZyKRY0VvYbUi5gYIV1E+4Sta6
         oSXLmj9wIwDwbuXIdttNb1ezrGzcWkqHoH4IgQJxbYwpN+FQ87nmGb6RZqgkPcHrmgbl
         seNKWxuAqGq0JxssBJdN1zfbDuoEQb4EuMaxvT88c9owiko61T12MmJLhXHbx7p3t7TA
         oCfgnk6kR0iAHof3AfI4eCtVVmoCkH9VUlkiFRPuaRLaAtEVM3b0VBqlpRWcta6H4Okb
         /UQGly6/tkgvRoleBnBICjFbHS8d9vBrjsWqyLlQwXid6L4E1hSJ7rJy2P1I3njNHOq/
         tzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778499481; x=1779104281;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fboe0jcENvd9dSVpqW0NTYIFHtH+nnd298gI3HalAZs=;
        b=fUgsOOoFbnFD5mxkeLYcGEs1MbO/BLxZr4WtdSq5YnO/pgNohq3uQVO2J0FwB2BYBz
         gWPFU8S4tznrfahlYtI24ELoj8UkhfqwlQPRD2Sq6c0hobxcrqFiHYjFwiaNDzob8TiA
         1DXO0V2JJvlLJgk8HJkROld3u2Iy+00O2rXPN3ZoP83aRszpN6nSTG4s4YV9z2rCm6Ge
         N5Us4EhgBIJp7AcPIVuZFfc8u7vcK+F/PUCiWSQfVfteyiaQ3//xqx02WA/aaXKZ6y8X
         bA8Seg/tNRyZWr8Jm0RsGt+2sLVnCeM5SzzOE964oVJlM13ORAX0MbEjEO1R7YY5+C68
         wWWg==
X-Forwarded-Encrypted: i=1; AFNElJ9I42N9QkNf09yZ7ORhBOoYg2vcITPISCb6aPIphlRWLMg9iAGT58L+0wItKagwJ81adB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLypzX6DuXNadknuHbNXTz8V2VibwKabHDpe8xUZ9Ybexp53vv
	DhkNQMo+Wm+ZQtmVZcxUM2Y9cMxtvKPi3H06msTjumTjreogDv26MBX+O6flkR16rgNc83JN/dq
	Ynw==
X-Received: from wmow11.prod.google.com ([2002:a05:600c:474b:b0:48d:e8d:3bce])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c094:b0:48a:8b02:ae91
 with SMTP id 5b1f17b1804b1-48e51e20638mr261622845e9.11.1778499480533; Mon, 11
 May 2026 04:38:00 -0700 (PDT)
Date: Mon, 11 May 2026 12:37:57 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511113759.610924-1-tabba@google.com>
Subject: [PATCH 0/2] KVM: selftests: Fixes for guest_memfd_test and FD double-close
From: Fuad Tabba <tabba@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi folks,

Two more patches, standalone KVM selftests fixes that I'd like to
land before posting a pKVM selftests series, a follow-up to Will's
pKVM infrastructure series [1].

The first patch fixes a build failure I ran into on Debian Bookworm
(glibc 2.36): guest_memfd_test.c uses MADV_COLLAPSE unconditionally,
but the constant was only exposed in glibc 2.37. The fix follows the
established selftest idiom of providing a compile-time fallback to
the kernel-ABI value when the libc header does not define it.

The second patch fixes an FD double-close in kvm_vm_release().
kvm_vm_free() calls kvm_vm_release() internally, so a test that
calls kvm_vm_release() and then kvm_vm_free() without reopening the
VM in between double-closes vmp->fd and vmp->kvm_fd. Existing
in-tree callers reopen via vm_recreate_with_one_vcpu() and do not
hit this today. The double-close becomes a hard test failure for
the pKVM selftests I will submit, which release the VM and then
inspect host-mapped memory before freeing.

Based on Linux 7.1-rc3.

Cheers,
/fuad

[1] https://lore.kernel.org/all/20260105154939.11041-1-will@kernel.org/

Fuad Tabba (2):
  KVM: selftests: Fix MADV_COLLAPSE build failure on older toolchains
  KVM: selftests: Fix FD double-close in kvm_vm_release()

 tools/testing/selftests/kvm/guest_memfd_test.c |  4 ++++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 10 ++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog

