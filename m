Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BAC3A4F25
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986134; cv=none; b=IAK+LqEkUj4wLEhwYN1+txYsfrHIsi7heP62Sv3fMVfWFT0Tm6ZX3/WORiRFS15hkDaO83h/TaYJ7QIIqE68EUYzoR6v+NepZNY7KVWqtFlYTWjOIfd1AcyPyX3aje91hxPTZ08YNZbaBHc4zVKKVISJSoYYPeKW9wfImehVeW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986134; c=relaxed/simple;
	bh=A8z4+6cIylVs1ax2H5EYgvCtrBN5P6YTJNVSPCHZ23w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nlB5Nyx4mdnYtaY1NL1KMEt4WcVVA3yW+DA//WHiB2XhtOKmJUSoFuC8N29zJmepm8WQCbFqtxGWmhVWMGEKqZkPLnKxQuGW87F4JVntPjMaKpTLQcDmxd/RlYlcEDZTidcRHVCdwghEw4LcYzKoJwi8CQ9gHIKF9tuBrdQmZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=skPl1LVz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skPl1LVz"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76ad3b732eso2605295a12.1
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986133; x=1775590933; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jSJ9JEryhSvGPhJKGI1u0Qnqsdu8hhpgpJnk/hSuiNY=;
        b=skPl1LVzOu+bt2eA/eSuw8NNXIK1Qjhq/LF757/OnbCTNBV5YQSrbbMQSF6FRRXXUt
         tFwRSSlnqbI+NV+YYunQJqM0VqbXVn3YljioixtxpB6GjFVDeVW779M3JRMJx6ofPf3J
         rWXs0D5S3bHG6Qer5jBfvxdA6Ktk7ATFqev5biwM+KhQPK/iAKJC7+K22QkwYmfI9REa
         AypqOxAJt1wlcLxeAJmbDDf0s4fvBSRsexSMEK60SXuN8Q1wTz/+ZD/2T4ML8XIB6/lI
         xmNvuZkbh0OVWF4Hlg3fz6YeZv4OJJlxzfXh+J1EsnmlD7Je6NEcxpu3JIssY2+kP9jT
         rDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986133; x=1775590933;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jSJ9JEryhSvGPhJKGI1u0Qnqsdu8hhpgpJnk/hSuiNY=;
        b=S6LNOU8WaL0QgC5tFfX5SAmb92pPLmiNRDY1bp4OcTkGz38TaoYJW/mz0KSR205lGO
         yFJg0vJtFq7o6zyJiQDzen/t9cIx15vSE/K9TqIMnfdIOpRAz9kKt+wKK1WP/hoiCygl
         ASNwCwkBJx5wSt1gZ0LAtmXjrmqD0oItfZEq9MEPPb2pm1QtU7nw27ziZINjBokRVZob
         KcxBuMaCq+sDtz1hpvNydZ26zF9SVadlAFjxBXklClalW8zivst9yQChFEl5lgtTd/Tc
         FMTYSpuUVjA71b8mKJ2lhEaz28f5QliHmdwbt3ofwdS61c38SpoEXHHEtNHTo5wGDYkd
         +L5Q==
X-Gm-Message-State: AOJu0YxXLgwz+hQkgubppVAuKcIC7GoS4l/OQtmofhJW211uKtm/Velx
	7hNsPXo95tHpe4NEtIL3j9zqN1yScvgxXQTrkdkA5/w1c9dNDVnEaLJgbGOBxwnmFSx+7NwuLpH
	OF+2/1LqgSAeOa99fQjjtSK15kWLLAlkh7VUs37e10ZjREEU+3IpEpjNRDU/hatdapGHisrOkzE
	todcVmnf6RbdN4uRls6J+ulCfGABU0wcliH8NoSA==
X-Received: from pgah15.prod.google.com ([2002:a05:6a02:4e8f:b0:c75:7a93:9b8f])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d88:b0:38b:d9b5:5de2
 with SMTP id adf61e73a8af0-39ef7792bc2mr470704637.50.1774986132379; Tue, 31
 Mar 2026 12:42:12 -0700 (PDT)
Date: Tue, 31 Mar 2026 12:41:53 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194202.1722082-1-vipinsh@google.com>
Subject: [PATCH v4 0/9] KVM: selftests: Create KVM selftests runner
From: Vipin Sharma <vipinsh@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Cc: seanjc@google.com, pbonzini@redhat.com, borntraeger@linux.ibm.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, anup@brainfault.org, 
	atish.patra@linux.dev, zhaotianrui@loongson.cn, maobibo@loongson.cn, 
	chenhuacai@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	ajones@ventanamicro.com, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

This is v4 of KVM selftest runner.

To recap, KVM Selftest Runner allows running KVM selftests with added
features not present in default kselftest infrastructure like
parallelism, user friendly output, saving output hierarchically, etc.
Check README file in the patch 9.

This series is also available on github at:

https://github.com/shvipin/linux kvm/selftests/runner-v4

v4:
- Copy runner code and default test case files to out-of-tree build
  directory.
- Added comparison with kernel selftest framework.
- Added python minimum version (3.6) check for the runner.
- Bug fix where runner was not handling the child process output if returned in
  bytes instead of string.

v3: https://lore.kernel.org/kvm/20250930163635.4035866-1-vipinsh@google.com/
- Created "tests_install" rule in Makefile.kvm to auto generate default
  testcases, which will be ignored in .gitignore.
- Changed command line option names to pass testcase files, directories,
  executable paths, print based on test status, and what to print.
  Removed certain other options based on feedback in v2.
- Merged command.py into selftest.py
- Fixed issue where timed out test's stdout and stderr were not printed.
- Reduced python version from 3.7 to 3.6.
- Fixed issue where test status numerical value was printed instead of
  text like PASSED, FAILED, SKIPPED, etc.
- Added README.rst.

v2: https://lore.kernel.org/kvm/20250606235619.1841595-1-vipinsh@google.com/
- Automatic default test generation.
- Command line flag to provide executables location
- Dump output to filesystem with timestamp
- Accept absolute path of *.test files/directory location
- Sticky status at bottom for the current state of runner.
- Knobs to control output verbosity
- Colored output for terminals.

v1: https://lore.kernel.org/kvm/20250222005943.3348627-1-vipinsh@google.com/
- Parallel test execution.
- Dumping separate output for each test.
- Timeout for test execution
- Specify single test or a test directory.

RFC: https://lore.kernel.org/kvm/20240821223012.3757828-1-vipinsh@google.com/


Vipin Sharma (9):
  KVM: selftest: Create KVM selftest runner
  KVM: selftests: Provide executables path option to the KVM selftest
    runner
  KVM: selftests: Add timeout option in selftests runner
  KVM: selftests: Add option to save selftest runner output to a
    directory
  KVM: selftests: Run tests concurrently in KVM selftests runner
  KVM: selftests: Add various print flags to KVM selftest runner
  KVM: selftests: Print sticky KVM selftests runner status at bottom
  KVM: selftests: Add rule to generate default tests for KVM selftests
    runner
  KVM: selftests: Provide README.rst for KVM selftests runner

 tools/testing/selftests/kvm/.gitignore        |   6 +-
 tools/testing/selftests/kvm/Makefile.kvm      |  26 ++-
 tools/testing/selftests/kvm/runner/README.rst |  95 +++++++++
 .../testing/selftests/kvm/runner/__main__.py  | 189 ++++++++++++++++++
 .../testing/selftests/kvm/runner/selftest.py  |  99 +++++++++
 .../selftests/kvm/runner/test_runner.py       |  83 ++++++++
 .../2slot_5vcpu_10iter.test                   |   1 +
 .../no_dirty_log_protect.test                 |   1 +
 8 files changed, 498 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/runner/README.rst
 create mode 100644 tools/testing/selftests/kvm/runner/__main__.py
 create mode 100644 tools/testing/selftests/kvm/runner/selftest.py
 create mode 100644 tools/testing/selftests/kvm/runner/test_runner.py
 create mode 100644 tools/testing/selftests/kvm/tests/dirty_log_perf_test/2slot_5vcpu_10iter.test
 create mode 100644 tools/testing/selftests/kvm/tests/dirty_log_perf_test/no_dirty_log_protect.test


base-commit: df83746075778958954aa0460cca55f4b3fc9c02
-- 
2.53.0.1118.gaef5881109-goog

