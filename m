Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214138;
	b=jh44QvSgxejIl5YHQXcA9uW2dKSbaAnhvHPfzoH4p6363p+B7ZLvQ0NlZSZuLhNr/59S
	 OgUfuhUUd7uJ22LN+XILCiYgLTTIwDlrNVVjO30MsJP4EnaIKwH0v6jKMXcmud2zeC61w
	 EzADrAs38X75Em3StMHcBjO8QH5yyVpBGWBy2plkgh98GfUGs5TJVVGDh9k47o39noTLs
	 vQdRDY8Rd+wfqkOljVn9qWcTTgWqbBQkAHZ0otui1516QcWkvvkkChQXr2Wy3+So5DgIC
	 Iu+ec/cKwL1DD2D1UBEG25r8Dyv+2KjBXjWnovpOIXnN2xJhxsRJR/tlBZOEz21qxnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214138;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9EDiuahpoC5a8fdBVjn+7UwWB1qVxtY459zTXN5uFBc=;
	b=3VL3sAin3UiLhFPup1EtGJYQ6THj0e1wlJx9SyKX2GLIRKEWsHAuwEyb0GUNW7FLF/Zl
	 hiHsCq1EGm4H1wFVt4xAu9LjMU0QgZATxEkE42zGk8f3THrd3oI4Uuqe0Ax1RPxyDgyqq
	 VoGp810qZoinp0FxijHwxNONcjcwBUjnimCq5AaV+H5ucn//1/6DsBlTDUgkvjykmLMbv
	 cxJ3GssIz/7YiO3PQaZtSDglcALVeJcPpSKvShMUKmUpCEmz6QqV5bCzYILfJv98uju36
	 CXWfYfBi5BDWweuMok8XJvYblnnlXN93qhW1SBXCqD9ZkIkp2UqOOk6UFJw0KNAQHJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aKniBgn2;
	arc=none smtp.remote-ip=95.215.58.94
Received: from mta1.migadu.com (out-94.mta1.migadu.com [95.215.58.94])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96C2606A325
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 08:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B96C2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aKniBgn2
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zpKaD0TgIJfqXkuMLyaymhMm6AH9D97hWArAafrSB6U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794214136; v=1; x=1794818936;
 b=aKniBgn25IHI6/+paezktja3kzUe2XHYTbZvR+c/c7IlRhOWL6NzzF3m11fb8KQs/r5okijz
 /HUM78yf3sesqRmdI2T9Ze8vyBoxAkGO0SMDUqxoZWloB6hglXKhuB9wlHE1fyeWgZUyqlOV3x1
 R8V3eI0h2bytT8Y8YlFyZWJ8=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9a819a32ecff5883;
	Mon, 09 Nov 2026 08:48:55 +0000
X-Mizu-Trace-ID: 9a819a32ecff5883
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Quentin Perret <qperret@google.com>,
	Fuad Tabba <tabba@google.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/19] KVM: arm64: Hide generic ptrauth from protected VMs without ptrauth
Date: Mon,  9 Nov 2026 08:48:36 +0000
Message-ID: <20261109084854.840576-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109084854.840576-1-fuad.tabba@linux.dev>
References: <20261109084854.840576-1-fuad.tabba@linux.dev>
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

A protected VM without the ptrauth vCPU features shouldn't have pointer
authentication in its ID registers. Commit 3d7ff00700d1 ("KVM: arm64:
Rework specifying restricted features for protected VMs") gated APA,
API, APA3 and GPA3 on vm_has_ptrauth(), but left GPA and GPI capped
at IMP. So generic authentication is advertised to a protected guest
without ptrauth, and PACGA UNDEFs.

Gate GPA and GPI on vm_has_ptrauth() too.

Fixes: 3d7ff00700d1 ("KVM: arm64: Rework specifying restricted features for protected VMs")
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/hyp/nvhe/sys_regs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 32e82653ebf7e..e5502d5651b05 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -157,8 +157,8 @@ static const struct pvm_ftr_bits pvmid_aa64isar1[] = {
 	MAX_FEAT(ID_AA64ISAR1_EL1, JSCVT, IMP),
 	MAX_FEAT(ID_AA64ISAR1_EL1, FCMA, IMP),
 	MAX_FEAT(ID_AA64ISAR1_EL1, LRCPC, LRCPC3),
-	MAX_FEAT(ID_AA64ISAR1_EL1, GPA, IMP),
-	MAX_FEAT(ID_AA64ISAR1_EL1, GPI, IMP),
+	MAX_FEAT_FUNC(ID_AA64ISAR1_EL1, GPA, IMP, vm_has_ptrauth),
+	MAX_FEAT_FUNC(ID_AA64ISAR1_EL1, GPI, IMP, vm_has_ptrauth),
 	MAX_FEAT(ID_AA64ISAR1_EL1, FRINTTS, IMP),
 	MAX_FEAT(ID_AA64ISAR1_EL1, SB, IMP),
 	MAX_FEAT(ID_AA64ISAR1_EL1, SPECRES, COSP_RCTX),
-- 
2.47.3

