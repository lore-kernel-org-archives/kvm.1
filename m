Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9343AE71F;
	Tue, 24 Feb 2026 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972473; cv=none; b=CtmxmgWcCLg1J6Xfk2qZnuKdXhgHZV0ICK5EJry7BcLHnzPgjYHs0WkI0Sy/Xep/1HQHnDwmJ2ru/DwnCBOSlUc9C3P5iOG04MlQ5LvoT9Bo9vLyucc/MN42X9+56zDFer6QAM7iVQ2sTNFgQQZeNj1s7Nudz9YJj4AhsdCELqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972473; c=relaxed/simple;
	bh=RBpKxUYlziCfgALtI3kgPDKPT9IypbTvVuebfGkC5nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0WqSDhxuOLJ/oH1bBEz3Bi2O8GlEQYG2hM5gHmWFgHM+lipCVf+zu1jfVWoT0WDsd2Quc8IgCoC0lbPHR+aaJ/Mwt89PAgvXUMVay3pQ0tCVH/umWw4w/cv9W6/GHTsb55xWiEYXyI0jpEMySzE5CpkfqWJ6pkiQDxdNlXMH3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6iNaEbp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6iNaEbp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1533DC19423;
	Tue, 24 Feb 2026 22:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771972473;
	bh=RBpKxUYlziCfgALtI3kgPDKPT9IypbTvVuebfGkC5nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m6iNaEbpSWxB17i7feynMWeE5Id58o6QEqE+A+OnWKGdKHcy+9Jp2btVriIPbwEAa
	 wLBYhfoTWeo2lHZ8FHWzE62/qwYkPAGqXyitgEzfTEwnR2lbvRn4OinmEYX/YUCGql
	 JprvzYAsoO/8FX38aB5bCMiRucXTyuJ2ZCDJt4/+8yUAZ/XgYv07oahaSBcSD8Ixmt
	 HpYQYkCf9YK9PfMn5RdwMoO8sSyPmUW7R75BTEitR9gZjaRxtbTf865KCc4ssnC8sL
	 00gCgEDehgGJwL6sZT+lbVUpt6Qw4voCJOZWHxQ2pP8KekU2g64QjCmOXnL+jArn5/
	 /k8Pewe/3MaqQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	Jim Mattson <jmattson@google.com>
Subject: [PATCH v6 30/31] KVM: nSVM: Only copy SVM_MISC_ENABLE_NP from VMCB01's misc_ctl
Date: Tue, 24 Feb 2026 22:34:04 +0000
Message-ID: <20260224223405.3270433-31-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260224223405.3270433-1-yosry@kernel.org>
References: <20260224223405.3270433-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'misc_ctl' field in VMCB02 is taken as-is from VMCB01. However, the
only bit that needs to copied is SVM_MISC_ENABLE_NP, as all other known
bits in misc_ctl are related to SEV guests, and KVM doesn't support
nested virtualization for SEV guests.

Only copy SVM_MISC_ENABLE_NP to harden against future bugs if/when other
bits are set for L1 but should not be set for L2.

Opportunistically add a comment explaining why SVM_MISC_ENABLE_NP is
taken from VMCB01 and not VMCB02.

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 6dd31ed2bed5e..acc213e675ac7 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -852,8 +852,16 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 						V_NMI_BLOCKING_MASK);
 	}
 
-	/* Copied from vmcb01.  msrpm_base can be overwritten later.  */
-	vmcb02->control.misc_ctl = vmcb01->control.misc_ctl;
+	/*
+	 * Copied from vmcb01.  msrpm_base can be overwritten later.
+	 *
+	 * SVM_MISC_ENABLE_NP in vmcb12 is only used for consistency checks.  If
+	 * L1 enables NPTs, KVM shadows L1's NPTs and uses those to run L2. If
+	 * L1 disables NPT, KVM runs L2 with the same NPTs used to run L1. For
+	 * the latter, L1 runs L2 with shadow page tables that translate L2 GVAs
+	 * to L1 GPAs, so the same NPTs can be used for L1 and L2.
+	 */
+	vmcb02->control.misc_ctl = vmcb01->control.misc_ctl & SVM_MISC_ENABLE_NP;
 	vmcb02->control.iopm_base_pa = vmcb01->control.iopm_base_pa;
 	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
 	vmcb_mark_dirty(vmcb02, VMCB_PERM_MAP);
-- 
2.53.0.414.gf7e9f6c205-goog

