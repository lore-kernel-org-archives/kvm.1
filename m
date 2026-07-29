Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE2143E9FC;
	Wed, 29 Jul 2026 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785315555; cv=none; b=s6vhjX1GcVEkKr2nXVNxFYhL1VbfUB6PAP86wl13P8eq4OGEJ+pKJ5V9nWaDusvlm4LPe/GH1QjNMc+M7p+GkxkQ1XCwIHkL8t+WZXzY1bsXp6/UMaEvf8C4kLLnhZz9joC7dUsVbXK2Rj7p2nJ0q71VHZqsBNZelEpYJ9jDVdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785315555; c=relaxed/simple;
	bh=hxwZjKOn/TBNGoe7/3imekWCFiZ3wSYyShtq/ljKMWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JhKHeOk3kUUCRp7HnIU7EXItA8xS8VKNdeqSJjU3MQSSLOezhnhS9Z/EkOH0UDkZO1+yhG9Yk4pUYiD5yTSxn5c7HKbRpkzAVF+DWU0Jv2F7MXloGLDCnUR6ZygKQt/06VnHMeQtnPpJMPyXyhP0T/83tvsXWuDVV43bEoaihz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaQx0/6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaQx0/6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF74E1F00A3D;
	Wed, 29 Jul 2026 08:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785315553;
	bh=V7SPgTjpadTddm90Yl2brgoxMMyY+1mGEVs9Na3E11g=;
	h=From:To:Cc:Subject:Date;
	b=UaQx0/6C/mDA8gcx2Yy/0K0MXmmsKdbclMdIVw0uZTBCo0BG3xAiocP8JwZ0wnXEA
	 8AboPboEiFoRwtCzJyOiezhD3W+Nwl0+AnkbFGX1C2Cc+Bl1boxchcw/kdAevYljkV
	 JgRAUPVaqWkYDkdbycWNR5PHa1xQR1xiDObIeS7cpykMDHvFtJXtNdQPRaTYiuDvzE
	 9sAxeMG6KGiR8OT7Q4GmFP0va0L/oimnJzNOfjb57YNgS8LfWmmPckr8/C9L6hBmKi
	 IyaRTpwYKcj9CSxmX3jMUm0TzqooDM73H3qbMfcOKtjuQfWK6s31qYyvR/B8cDO+zp
	 ciNIspkJNTf8g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: seanjc@google.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH v2] KVM: x86/tdx: Do not print error message on non-present feature
Date: Wed, 29 Jul 2026 10:59:08 +0200
Message-ID: <20260729085908.21368-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before commit 165e77353831 below, the kernel did not print anything
during boot if X86_FEATURE_TDX_HOST_PLATFORM was not present, unless TDX
enablement was explicitly requested via a module parameter.

After the commit, when attempting to load TDX automatically, this is
emitted to the log:
  virt/tdx: TDX not supported by the host platform

It is emitted with the "error" level, hence it is disturbing. It is not
an error to run CPUs without the feature.

Drop this silent-boot-breaking error message for the automatic
initialization path.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Fixes: 165e77353831 ("KVM: x86/tdx: Do VMXON and TDX-Module initialization during subsys init")
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Chao Gao <chao.gao@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>

---

[v2] update the commit message.

Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-coco@lists.linux.dev
Cc: kvm@vger.kernel.org
---
 arch/x86/virt/vmx/tdx/tdx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 1b9ff749dd8e..e5fb0d382c4c 100644
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
2.55.0

