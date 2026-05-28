Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B4C0323393D
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 03:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779938167; cv=none; b=RQ/PKL0h2zyF1JphtJnEYh2tt9YToB8QDhTBHDNGtIfUpP7BiqSECrMkRHguvZt1EMQ0IefmQVIgM7jaE/uzHGFD9zVIDjThcwv0d9nS+QKxa+lOVAA6RdpNXl8mKYSLKNUKKp/slADCeaqv/0fCl5k2wAmENFVQ0VdBHHS0j4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779938167; c=relaxed/simple;
	bh=TnN2BO3slTqKF7IC7z48aJoA7xog/D3wjztyDsgQV1I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GJROB4fCj9gyzz30HE+O6FYuVA8FMdBhYyfBRaMMZLq88DOmhdP1PzHsvFPhe0ueoFSvj7b8LqxF32vOLQYWDt6lHbJDWCrvz/PkfC3pKEDuWHTYp9FONF8dKMngCFjXQdzSSIxSpXd0+/xcYc25qfIotgfbmBU0cdpnlHQbrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=oV6dnWz/; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="oV6dnWz/"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, <kvm@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] KVM: x86: Fix wrong return value type in guest_cpuid_has()
Date: Wed, 27 May 2026 23:15:45 -0400
Message-ID: <20260528031545.1879-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc6.internal.baidu.com (172.31.3.16) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1779938157;
	bh=aIy0DvSDVDbVP8PKcJl3ucIz+RtTsOwelwN9/pPpDAI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=oV6dnWz/Ik4qnH+QERFFB/T3xmox/pk0+1u3WnGAtQXqK+npcIzXqqAVyAsZbd13D
	 Y/GTNNOs3J1yLiqMzeb4KoUhrQbwUGhUQvbnTNQNq8jHTy//CAJlC4NtCFy2wtS/Np
	 vi65104yByhz0ni5WtPE5OJw2DQSLH3dGfrsKVYUP/zGVLRLaJWnSbfGsoWHcy6B69
	 rDNrVxdiRT5iWJeCA/xa7LbAEY3+N8PH8r98uvITy9Y45MnmrWqlgpsCu3ZuSjuI4o
	 NYQF51LvcSWtoWLpw5X4oSWaXjJutCdJaJCtukJe0m/nNBvrc2LjRRt/m55oDv2a7q
	 UqZqGSIReAvdw==

From: Li RongQing <lirongqing@baidu.com>

The function guest_cpuid_has() is declared with a return type of 'bool'.
However, when kvm_find_cpuid_entry_index() fails to locate a valid CPUID
entry, the code incorrectly returns 'NULL' instead of 'false'.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/kvm/cpuid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 039b8e6..b0ca723 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -124,7 +124,7 @@ static __always_inline bool guest_cpuid_has(struct kvm_vcpu *vcpu,
 
 	entry = kvm_find_cpuid_entry_index(vcpu, cpuid.function, cpuid.index);
 	if (!entry)
-		return NULL;
+		return false;
 
 	reg = __cpuid_entry_get_reg(entry, cpuid.reg);
 	if (!reg)
-- 
2.9.4

