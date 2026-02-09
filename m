Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25026B95B;
	Mon,  9 Feb 2026 04:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770611407; cv=none; b=kaKAeH1Ya0NcIvYlpZFTg1YjILiBJ3VGrZ5xerrIDaxsXXGdCrb737cy9kE7f78Lk6wwNHsAmwMp92eynZqD+Azgg9CpsAHosn5S0RAWbDqSi9Oiyr319AWR4F/3TKSxzsUTGh0y3jjJs6vg0qJMAUgjt96VLTaWGmW8UXkPKMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770611407; c=relaxed/simple;
	bh=c7YoCkM2BmZJdHk5jLwsWyiMECmd1q2WP5rs2cebOqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrDm1xusKIut7ENUl/j22hG7iy7iKFh8v7oeLa6NADXfUWyB7YmNEsxokKZyYW5LymbTU3h5TlwwuWmKPJTQjdHc8BjFMvfobkwT/jLHuzIKiqvSg1PMJhJCLvTPX+SRide7hpswMlKcBIaoOEOCG49hJvlPzuVZoYgYBDJAMX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HtxkG33z; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HtxkG33z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=wR
	rHYlhhICurRuaTmyvIiO5aCoWfhZPWn5WuToLYHEE=; b=HtxkG33ztbKbHKsY74
	rID1tGVXD3YA2NI41GVML+QKE9N9bwH4L4gDRSr4AaBkwvIVZkw9Pkf66FdNLRdj
	dqeURzAmAn42JmMjKY+CzB7Mls8Crtfb9gl/HmsqVMAwqwHwhrDYmxqif3l8cg09
	nTKzk6Wocrpjf54Um0Lw/oSsw=
Received: from 163.com (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3F+yvYolpOQZEQw--.25673S4;
	Mon, 09 Feb 2026 12:29:36 +0800 (CST)
From: Zhiquan Li <zhiquan_li@163.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhiquan_li@163.com
Subject: [PATCH RESEND 2/5] KVM: x86: selftests: Alter the instruction of hypercall on Hygon
Date: Mon,  9 Feb 2026 12:13:02 +0800
Message-ID: <20260209041305.64906-3-zhiquan_li@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209041305.64906-1-zhiquan_li@163.com>
References: <20260209041305.64906-1-zhiquan_li@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3F+yvYolpOQZEQw--.25673S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ury8XrWkKw4rGF1UZryDAwb_yoW8AF4kp3
	WkJw1FkF1IqF1aya4xGr4kXry8GrZrWay8tw4IyFZxAF17Jw1xXF47KF12kasxuFZ5Zwnx
	Z3Z2vF1Uur1UJwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRHGQDUUUUU=
X-CM-SenderInfo: 52kl13xdqbzxi6rwjhhfrp/xtbCwhCBammJYrCJQgAA3A

Hygon architecture uses VMMCALL as guest hypercall instruction.  Now,
the test like "fix hypercall" uses VMCALL and then results in test
failure.

Utilize the Hygon-specific flag to identify if the test is running on
Hygon CPU and alter the instruction of hypercall if needed.

Signed-off-by: Zhiquan Li <zhiquan_li@163.com>
---
 tools/testing/selftests/kvm/lib/x86/processor.c      | 3 ++-
 tools/testing/selftests/kvm/x86/fix_hypercall_test.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index bbd3336f22eb..64f9ecd2387d 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -1229,7 +1229,8 @@ const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
 		     "1: vmmcall\n\t"					\
 		     "2:"						\
 		     : "=a"(r)						\
-		     : [use_vmmcall] "r" (host_cpu_is_amd), inputs);	\
+		     : [use_vmmcall] "r"				\
+		     (host_cpu_is_amd || host_cpu_is_hygon), inputs);	\
 									\
 	r;								\
 })
diff --git a/tools/testing/selftests/kvm/x86/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
index 762628f7d4ba..0377ab5b1238 100644
--- a/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
@@ -52,7 +52,7 @@ static void guest_main(void)
 	if (host_cpu_is_intel) {
 		native_hypercall_insn = vmx_vmcall;
 		other_hypercall_insn  = svm_vmmcall;
-	} else if (host_cpu_is_amd) {
+	} else if (host_cpu_is_amd || host_cpu_is_hygon) {
 		native_hypercall_insn = svm_vmmcall;
 		other_hypercall_insn  = vmx_vmcall;
 	} else {
-- 
2.43.0

