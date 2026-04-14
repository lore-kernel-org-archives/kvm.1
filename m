Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6024130EF64
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776190077; cv=none; b=A4GnGdNi7Mn8Ryu2vfHi99C82VnWx3yJYWKA1WtrWVWTtwxa7kCMOGeVtoBtV5HGef53u3lGoNgIv3Qog2l7Z7lxbQqonrQkWr4uwLQzseK4oKB4rYMhyawVx711atvZq39s5OIsB/Q8KCd51EDUav9N7Mn4OBU5izT+q8hTYJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776190077; c=relaxed/simple;
	bh=HTjhb+sVf7p1WQJwLx9AKzwTwsQ8f1NUTKutpCod60M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bwTEcBDthiiRrRplrSC+PMwrhAKhd4ROFzoW7uXStsmdlHAXE00T2wLau48dkKPxM6FNDKN6Nn5oUe/W4DF+GC6VDWdbaCvJssHwsq/RM1btUtZ7MQpK7yoVldHRxB1PZ612ipZQEYsJYGPxJU2MMzLRG5qN37BNzfbHivkX/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CJcv8tsX; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJcv8tsX"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354c44bf176so5521528a91.0
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776190076; x=1776794876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=khThBJkPhi1xf1CIxaRjVLJbrDnS0/dRBtMlj3Iqt7o=;
        b=CJcv8tsXdYtfsJ8139NpKeDqjbSXwsSk6TYsa0NVpvWW6CukIuGDgA17Nbm9pZHEbJ
         BieivVnIcj2/CUn3iQwBJ1N6CwIr89qNsSDmBzab82m/IVc+erWyRR4Bu3w97TbvCglA
         YwtXcTQsFiiGCy5bBZv3MfbGfztCsFetBRvsFx+J3gdhB3V0b9oIUezinf1c2a9Xr489
         uOq+hI6kSF02IlLzOMU5DPhh2SLE9hrkTRAPVSKOiBqzcCx/JzGBnXDk/ka07h7OjpJL
         0n23vn7zzi42NyBiWlS0uFKXGEHFrlL9PNIvEzh3EOO0yPpWf8Z2Mpy1/NrlRAVgrDJW
         50Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776190076; x=1776794876;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=khThBJkPhi1xf1CIxaRjVLJbrDnS0/dRBtMlj3Iqt7o=;
        b=U8G8y2+4ZSdv5wCjeLQfQtz6SxihfczzUjPASIMefvJFkjBbAoyYYyPVi7c8+0o9dI
         BtVNtfcq8myF0iH868A4EH9Kdn9UjJWwAE+0PgZ8CWHu4QNQuzaUzpBjM79GvFkVGa/2
         USNupHB8VpmbN1a55btHnlb5yxVFS/tsrteIYy8IXJAPkzPRaQ2RxHqEPyIUuBB5giVT
         yb2hsttSr5JvaZl3tF6D97chYC2hb2VQy3BscyVrsA/eaujreE+PqEXHJ4YUUuJqljd4
         FWGkpBxv1HaEwHoxKesCSYhBZLSApnUuctehFGa5q914bLNz2NEL1CjHrAvP92MyKJap
         TZSg==
X-Forwarded-Encrypted: i=1; AFNElJ8ivbknifTV4C5HmJKMGxxaLQrh1CnogTaHyFnt/QGe1yyCaIfn2x38iTuR0/QNTpKvueE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0nGLjvWsmB8xpvk+VNgoso5rS/jTaMbAgXZovhuUa3tERtrLY
	1UMBYmOMW3c7dYDo0h5n4NsFqa2oURJ3/8GPQoLkytfCYVhquTU+7eo/mlHco0wc4j3P0uDFYV1
	M8Spv/UvbfEC8dyZL9OTbG0DHCA==
X-Received: from pjbgj20.prod.google.com ([2002:a17:90b:1094:b0:35d:9018:737])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2686:b0:35e:5b19:234d with SMTP id 98e67ed59e1d1-35e5b192575mr9144017a91.7.1776190075498;
 Tue, 14 Apr 2026 11:07:55 -0700 (PDT)
Date: Tue, 14 Apr 2026 11:07:47 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHOC3mkC/x2MQQrCMBAAv1L27EJSo4JXwQd4lR427aYNpGnJL
 lIo/bvR4wzM7CBcIgvcmx0Kf6LEJVewpwb6ifLIGIfK0Jr2apx1KJyCsiiOafGUcGalgZTw5m0 wjpy5hDPUfC0c4vZfv+H1fEBXpSdh9IVyP/2uM4lygeP4AoqJ8VeIAAAA
X-Change-Id: 20260414-selftest-global-metadata-7b1f04a405f3
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776190073; l=3162;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=HTjhb+sVf7p1WQJwLx9AKzwTwsQ8f1NUTKutpCod60M=; b=24cCm+kgO4kLJABeH9NYnAfq2j/dxpLlthjoXrzxEqz8m11r819Gzh2Y07Agg2FF4AqVp2bMJ
 0sK35KlNGTACngnr0CKfoJ5reclepmXGqrB4Vy5kTS+e7JYZr6WG4T+
X-Mailer: b4 0.14.3
Message-ID: <20260414-selftest-global-metadata-v1-0-fd223922bc57@google.com>
Subject: [PATCH RFC 0/4] selftests: harness: Provide global metadata pointer
 to allow clean teardown from selftest libraries
From: Ackerley Tng <ackerleytng@google.com>
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, thomas.weissschuh@linutronix.de, linux@weissschuh.net
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

Hi,

The common kselftest harness provides nice features such as tracking the
number of tests, common pass/fail printouts, and setup/teardown functions.

KVM would like to benefit from the common functionality provided in the
general kselftest harness, but KVM selftests are dependent on a selftest
library.

This selftest library provides common code for setting up virtual machines,
and is designed with assertions within the setup flows to reduce KVM
selftest developer burden of making common assertions.

The common kselftest library assertions (ASSERT_EQ and EXPECT_EQ) are
dependent on access to the _metadata parameter. Any function using the
assertion macros must be parametrized by _metadata.

The KVM selftest library has many nested function calls and it would be
impractical to pass _metadata through all those layers of function calls.

Without _metadata, the KVM selftest library can still reimplement its own
assertion macro (TEST_ASSERT), but it cannot perform teardown on assertion
failure.

Sean suggested using setjmp and longjmp [1] to back to the top level
TEST_F(). I looked at [1] and found myself wishing to use TEST_F() the from
kselftest harness directly. Also, setjmp/longjmp felt like it was
introducing state that could be messed up easily. I also found recent work
that removed setjmp/longjmp from kselftest harness [2].

The kselftests harness is running tests sequentially anyway, and the
function pointers in _metadata wouldn't be changing all that often in most
selftests.

Would maintainers be open to having the kselftest harness expose a pointer
to the metadata globally?

Another option would be to expose the current teardown function pointer
globally instead of the pointer to the entire metadata struct.

kselftest harness macros ASSERT_EQ might also benefit from using the global
pointer instead, which would open the functions up to calls from nested
functions without needing to parametrize those functions with _metadata.

[1] https://lore.kernel.org/all/ZjUwqEXPA5QVItyX@google.com/
[2] https://lore.kernel.org/all/20250610141252-1ee7ae72-dbad-4a80-931c-5b4b14fb07ce@linutronix.de/

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
Ackerley Tng (4):
      selftests: harness: Move metadata structs to separate header file
      selftests: harness: Set global current_test_metadata for each test run
      KVM: selftests: Do teardown from kselftest harness if kselftest_harness is used
      HACK: Show that the teardown function is called from KVM selftests

 tools/testing/selftests/kselftest_harness.h        | 51 +++------------------
 .../testing/selftests/kselftest_harness_structs.h  | 53 ++++++++++++++++++++++
 tools/testing/selftests/kvm/Makefile.kvm           |  1 +
 .../selftests/kvm/kvm_test_harness_selftest.c      | 34 ++++++++++++++
 tools/testing/selftests/kvm/lib/assert.c           | 16 +++++++
 5 files changed, 110 insertions(+), 45 deletions(-)
---
base-commit: 5d0d3623303775d750e122a2542d1a26c8573d38
change-id: 20260414-selftest-global-metadata-7b1f04a405f3

Best regards,
--
Ackerley Tng <ackerleytng@google.com>

