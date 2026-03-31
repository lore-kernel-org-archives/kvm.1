Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180C33A255D
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986138; cv=none; b=Kf2keJDgu6BUm3Rk0Jj2GFqIyTt2hhCN7nRqGsrjTRslqG3KEqPD201boo1dOfVJrVRWdZ2RamwmhiWFKVmlrahDgxapMjO+hiwgrQ9u1greZPItBe/pKNjVkJVjDfOUGbPMCNUA/xQCLH9TH8mZswqCFkK0cAP0juETO6YBVjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986138; c=relaxed/simple;
	bh=RsWz28mXJeJUgS3BcMK/BqnMF/erQFFQn8+hB3ZU6o0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CEV6cWblfgDDEq2DwCP4TlcNaCnjQaizV2s0gkMMPggSH/dS8BYKnQxZuEyTjTxMPYb/lhkJ66L/o52iIgvIW2CNJCSiEHUsFoMGZC02fdohRNe5PBoYZtKvxLZQX1eFyNBcTNWFdxtTT0218FTlYTJhaOJgdMTx+I8X3fGwN18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rauGcAv2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rauGcAv2"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b24a00d12cso35557995ad.1
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986136; x=1775590936; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=okyRWg6SJ1Nbhs5yC14NmJAon29R3bVuhvecgVY39ps=;
        b=rauGcAv2dxx1TnA+zEqQ5pUD5HEFazVrDzN8LOJ/vTtg/kIw9dmnTTDOmRqfTpZGXW
         u19Uu5f/9DveO3FpOtZvRq0RIVyxeUOljhAWX3rgELAi6UTI76J8CmT1Xih8LxEp30sJ
         kCnJ1lmp/jPj5VmPS0r+QDxz5eEXkfgShdEdwxGD8dnwjzbBc5SvAmKKGKwBvDr4jvKt
         H5MnZcHuW6vV7eD2Fdg8fKXpsbaN7fDgBJjCjP8f4z8dlYkUtG14am1YrdrDz4nSr7HA
         PNHmpNiWy8Z8+ugO+M3DWIWzqKwVgqcgBomh3E00DizGQ8E56W8d/tZ3JC8FUpTMJMwt
         cTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986136; x=1775590936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=okyRWg6SJ1Nbhs5yC14NmJAon29R3bVuhvecgVY39ps=;
        b=hwip+JqDbs1MH6UehTvyQQVYLhS+bv9HQritBsJg5eU3bOdJhcS2hAYvJ0s9+ij3QP
         SS9XF+kMW0VWbseL0vyeGwLulw+WIzEv3PDSbb2M72jI58oPyiDHFs2TDRNs/LzHxdX4
         8T4Ht5gJ9lcWJUhRy8DotS+k/fGbnTgc+UiHuV1w5JF25vd8EYE/X21igPUNJwKrDMKo
         4Gg1DzNALfF4QPdPinhRc7Ynn2TfuXHrOaECS+I7eC3Cpf+aAXhUht08WiDhE2tPnWHG
         UzOrAZzRa/ftSwMA50678t316UwzZtN2G+ABVohTFCw3zD+LwrIkoUWPMcwVpWw7w4bS
         OfpQ==
X-Gm-Message-State: AOJu0Yym0mQtcOMKy2O8MaPvamwJGdcJaX1CNyQtsfQvXB9Q8d0ueRnQ
	leDfvmdhYdafCZ5/myLvxI/86Ny9In/PEN77xNkZTOCFs8PmQ+8lbFdhc7So5R3fcyuauSH/6o/
	pbqt9KH83sccdtCUEKJHbE2w9o7/LwDuPHSQE20g+v39pCvO09xTj1osRIlCmGhMPy9KpkdM8SF
	uG9n2GDXWMfftIwc+8h0bknmo3bs0oySpzyY1BDw==
X-Received: from plbmm7.prod.google.com ([2002:a17:903:a07:b0:2b0:4b14:f0e9])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fb0:b0:2ae:5eee:7a5
 with SMTP id d9443c01a7336-2b269aca7a0mr4064425ad.12.1774986135979; Tue, 31
 Mar 2026 12:42:15 -0700 (PDT)
Date: Tue, 31 Mar 2026 12:41:55 -0700
In-Reply-To: <20260331194202.1722082-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194202.1722082-1-vipinsh@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194202.1722082-3-vipinsh@google.com>
Subject: [PATCH v4 2/9] KVM: selftests: Provide executables path option to the
 KVM selftest runner
From: Vipin Sharma <vipinsh@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Cc: seanjc@google.com, pbonzini@redhat.com, borntraeger@linux.ibm.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, anup@brainfault.org, 
	atish.patra@linux.dev, zhaotianrui@loongson.cn, maobibo@loongson.cn, 
	chenhuacai@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	ajones@ventanamicro.com, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add command line option, -p/--path, to specify the directory where
test binaries exist. If this option is not provided then default
to the current directory.

Example:
  python3 runner --dirs test -p ~/build/selftests

This option enables executing tests from out-of-tree builds.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/kvm/runner/__main__.py    | 8 +++++++-
 tools/testing/selftests/kvm/runner/selftest.py    | 4 ++--
 tools/testing/selftests/kvm/runner/test_runner.py | 4 ++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/runner/__main__.py b/tools/testing/selftests/kvm/runner/__main__.py
index db87f426331d..9b6c78e69c64 100644
--- a/tools/testing/selftests/kvm/runner/__main__.py
+++ b/tools/testing/selftests/kvm/runner/__main__.py
@@ -31,6 +31,12 @@ def cli():
                         default=[],
                         help="Run the testcases present in the given directory and all of its sub directories. Provide the space separated paths to add multiple directories.")
 
+    parser.add_argument("-p",
+                        "--path",
+                        nargs='?',
+                        default=".",
+                        help="Finds the test executables in the given path. Default is the current directory.")
+
     return parser.parse_args()
 
 
@@ -87,7 +93,7 @@ def main():
     args = cli()
     setup_logging()
     testcases = fetch_testcases(args)
-    return TestRunner(testcases).start()
+    return TestRunner(testcases, args).start()
 
 
 if __name__ == "__main__":
diff --git a/tools/testing/selftests/kvm/runner/selftest.py b/tools/testing/selftests/kvm/runner/selftest.py
index 5a86f9ceedd4..c1720897c629 100644
--- a/tools/testing/selftests/kvm/runner/selftest.py
+++ b/tools/testing/selftests/kvm/runner/selftest.py
@@ -28,12 +28,12 @@ class Selftest:
     Extract the test execution command from test file and executes it.
     """
 
-    def __init__(self, test_path):
+    def __init__(self, test_path, path):
         test_command = pathlib.Path(test_path).read_text().strip()
         if not test_command:
             raise ValueError("Empty test command in " + test_path)
 
-        test_command = os.path.join(".", test_command)
+        test_command = os.path.join(path, test_command)
         self.exists = os.path.isfile(test_command.split(maxsplit=1)[0])
         self.test_path = test_path
         self.command = test_command
diff --git a/tools/testing/selftests/kvm/runner/test_runner.py b/tools/testing/selftests/kvm/runner/test_runner.py
index 4418777d75e3..acc9fb3dabde 100644
--- a/tools/testing/selftests/kvm/runner/test_runner.py
+++ b/tools/testing/selftests/kvm/runner/test_runner.py
@@ -11,11 +11,11 @@ logger = logging.getLogger("runner")
 
 
 class TestRunner:
-    def __init__(self, testcases):
+    def __init__(self, testcases, args):
         self.tests = []
 
         for testcase in testcases:
-            self.tests.append(Selftest(testcase))
+            self.tests.append(Selftest(testcase, args.path))
 
     def _log_result(self, test_result):
         logger.info("*** stdout ***\n" + test_result.stdout)
-- 
2.53.0.1118.gaef5881109-goog

