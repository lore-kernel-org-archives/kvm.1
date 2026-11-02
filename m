Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793602304;
	b=Zt2YD5Qd811rtzZM+88WN1+Hs6GiM9zAah6lbIp96nfP17H/oaIMbXEYiHbkb+PLgHGC
	 E0gF6svQGJZuYx0PZfdjgXt+aDObVysWlKDA53AN6KFTqquNXQt8C3wrTevPbenupqFkC
	 x17uH5imY80xLIsm/LPNJjOpU+iJSDiB9R1N51qyG/iN7MghoaILmZ37nmz+Qxwn2wxTw
	 CMG+k0OEq4zCWnRnC2OfbsfLAnyGfNyOuTY17hV+H9/kboKWy27DL120zflOrnbtS1hNk
	 uvSLNJ4vv8RZczD0eeonjmI4OTU9TR2cnRqI4v5POg5HYv03W6JOysV24ZXj/EYjqnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602304;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FR3UiyaSHlkxp6xWAqbVQ4BBB6v1t+2E2Jo22ZIjrS4=;
	b=AV6iAM5qeMYwmHLEs69TbSqnWDOpS2zj+Vp81hGcCne9RyEzkFRmKVqajUf10QCCu4BH
	 Jfj5DB4kGtTcscutf4OL0R63vcuiR+gD/JYixvC9P7p3y0D7HP+T7e9Km7ircKOW4Dmku
	 lgorH7TWj3SgbrMgmmrSbTi7OWErq+SMUGNG3BAFq3hxKYxode3byUc1ABBt5+SSFVA5x
	 uP0T2NYu0aDQiaswt/nQYNUOEk58Y0tXGhwWRk6BqfEPhGyA5oQzP0jvtO5HhPjSUqKAG
	 gs4xBDb0GFQtxfiQenvVgUBTdyc+A1ZnC7oKQUwFa8oWz3Ry4Cfg8mYtrsV9aN9xV4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVOks+dI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5880606A324;
	Mon,  2 Nov 2026 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVOks+dI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075E91F000C1;
	Mon,  2 Nov 2026 06:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793602303;
	bh=FR3UiyaSHlkxp6xWAqbVQ4BBB6v1t+2E2Jo22ZIjrS4=;
	h=From:To:Cc:Subject:Date;
	b=nVOks+dIwgWZK+5TVKuV1WwNZ85TghKB2OlvPfYUMolT1hAosO31QRcmEOKS/VkrO
	 5ODqJUYgQQDfhCu2pblvmTccR6sZwJcjlRZWczTlzjAXJuGZqlbQcv8yNudtn6r94i
	 D9F6cyMhB31VCuGRBfnZjk2iWMq862ptJnVJh/TOHG16mIl2Buqr1+VW1uvhnR/q66
	 XwH7Yz26DVFU7xkrkEqEn3C7PMVTjbbphKRrfIbkyuZst8wsgU9oQQFyKNQzwPwWbB
	 7TzLkLwWUwnOaPvoBMJVrg6joMLmzJMyhfHfVniYI7JcoH7d0KlKXNvCYd6cGIpI27
	 jFIzFTMPv9kQA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Sean Christopherson <seanjc@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH v3] x86/virt/tdx: Do not print error message on non-present feature
Date: Mon,  2 Nov 2026 07:51:38 +0100
Message-ID: <27b6d824f7aee7078167944ce96d95676eee25cb.1793602266.git.jirislaby@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
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
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Chao Gao <chao.gao@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>

---

[v3] add reviewed-by tags and resend
[v2] update the commit message.

Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-coco@lists.linux.dev
Cc: kvm@vger.kernel.org
---
 arch/x86/virt/vmx/tdx/tdx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 680e5178a86f..d910a290ac50 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1276,10 +1276,8 @@ static __init int tdx_enable(void)
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
2.56.0

