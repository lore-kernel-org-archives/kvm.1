Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3802561A7;
	Thu,  2 Jul 2026 04:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782966731; cv=none; b=Etq/fv9PF1yP5gC3rfN4128NWOVy5xAX5oTlLcIXFm1BK/XZ5w8rRUOkSMXmFvANA8AIUTWAcgu2gMpiLFmVGIjoX38WC6bOIEfeXXrWnbB0YD0ip6O+GBekun69S30KeT1EP9++TLK0zTOG3MmlHSTngZm+sW5V6UweY3zyuxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782966731; c=relaxed/simple;
	bh=+6t54CnyWkrk3NC6Zr7M4fy9ez6xhOpejeAXbB965i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4cupszH/1WOebEf0RYGJeWUKrUbDrrrWV40wHzwa7MGZZmjRV/dAHe85LL2WMD7ZQ5+7GYmLTCqM9HhUHnzft0w5QtOT/Un8y44MTL5EiP6C5PfhnQPdkTyP7zREwIaY37IYchbZHmBwqayYmsj52c1siACxcHMH2I5ofkn7ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kar7o7Pa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kar7o7Pa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811A11F000E9;
	Thu,  2 Jul 2026 04:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782966729;
	bh=nLUl/jbyoKwaqRwS9kndZwOcd3w22X0CRG0BnXEgle0=;
	h=From:To:Cc:Subject:Date;
	b=Kar7o7PaydN1XsUVbo8bTM0AgaNQ+GZMI2keT5IsQ1DnHSuh1kpXP4r+0/jm/p5uW
	 ifUzZK/FvO4Ubn99CW8tOI2kfDB8o7zvQZLw0rdZ1KmoVqCseVI5evTe+YGZJQ9xvR
	 s2ti0yTmOiplwIg28nVVdhsxhQwQBqfkRyJ0e1RFeCdx71hFKSsdvm5YGDFClynblQ
	 W3d7ScdjG1hTXSU6tOhG9dDc9a20kX1H3HSfInkdkWmTpXNGJXf+/lqDyqQ6z6RUAe
	 aQmvD9sXp2wOoIbwWl22hmInrIqq31vSYC1li92PYHaio0R8YYZBEdX1uTz/AnHSFz
	 M/FhsD9t19KGA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: seanjc@google.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH] KVM: x86/tdx: Do not print error message on non-present feature
Date: Thu,  2 Jul 2026 06:32:04 +0200
Message-ID: <20260702043204.81741-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before commit 165e77353831 below, the kernel did not print anything when
X86_FEATURE_TDX_HOST_PLATFORM was not present in a cpu.

After the commit, this is emitted to the log, with the error level:
virt/tdx: TDX not supported by the host platform

This is disturbing as it is not an error running CPUs without the
feature.

Drop the error message completely to revert to the state before
165e77353831.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Fixes: 165e77353831 ("KVM: x86/tdx: Do VMXON and TDX-Module initialization during subsys init")
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Chao Gao <chao.gao@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>

--

Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-coco@lists.linux.dev
Cc: kvm@vger.kernel.org
---
 arch/x86/virt/vmx/tdx/tdx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 42df8ea464c4..bdfc3bf12a9c 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1228,10 +1228,8 @@ static __init int tdx_enable(void)
 	enum cpuhp_state state;
 	int ret;
 
-	if (!cpu_feature_enabled(X86_FEATURE_TDX_HOST_PLATFORM)) {
-		pr_err("TDX not supported by the host platform\n");
+	if (!cpu_feature_enabled(X86_FEATURE_TDX_HOST_PLATFORM))
 		return -ENODEV;
-	}
 
 	if (!cpu_feature_enabled(X86_FEATURE_XSAVE)) {
 		pr_err("XSAVE is required for TDX\n");
-- 
2.54.0

