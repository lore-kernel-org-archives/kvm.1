Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639AD239E6F;
	Tue,  3 Mar 2026 00:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772498081; cv=none; b=SGDGwFMkPVsBEhSzmnRb+62sO+KC8ykgGLaLJe2F4NsJoSQx+ZBlVq/2DgLK6IoNpQWGRC4y+96w6Ug/AhAL84dYbMgs5Wvvt/tMz9r4szHDOCD9tcy+tHFZMGXaZUvVSyUuKqDlihDLVgVXbqNZlaats7rUWqDYgBUHyowWvp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772498081; c=relaxed/simple;
	bh=nPB4lBnddVtLuKN1hae5RkAGRjj+yIg3+qfdTZt0tr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCortz/4g40dyrZ/S5m7PGyONeeBTIZyDdPAXKgHjiX3N86z9NwwYsZMQXe3CCQs0uuCGIZCcfiOSuTw/p+J1oa1N6Be9MB9/1kcJ2tfDRT92lO3j8kLnwLUeTdrZRjOpvPq77D02y/zqGgw+WfZ2fwnGFJAzyIHB7GrJwzDKRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEfoLaqv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEfoLaqv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0746CC2BC86;
	Tue,  3 Mar 2026 00:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772498081;
	bh=nPB4lBnddVtLuKN1hae5RkAGRjj+yIg3+qfdTZt0tr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BEfoLaqvY+IRd4lSHp/Gs5oiCl9on1w5wxUDi/YSmdez39v5zukg+QrAGAl6VZoPw
	 tGUFNU+W2eikOkoegVveLSWrswYtNrG57fxRDmK2PUYhZrOzkq8fQ0Gg5men2fNMrA
	 A/XatRBsyDL+y0yHTBQgdXPTiQ8v8vikYFyR/Ew7U1KqcA6t9JyfLC6Z8YRhVuo8Ba
	 1Wfzndr1QR4BUdWFqhnYcBRJKc+TphCz+C3es3o6CPXCVBNye7d5ZzxMi7uDbgtjag
	 A4xKu5cPZqzMzGd/luiiQvijYk+7v06B/wiwAUISHpVVayT5M0qdEe8tIsiH1f/q5I
	 w8Wc45182yVEw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	Jim Mattson <jmattson@google.com>
Subject: [PATCH v7 24/26] KVM: nSVM: Sanitize INT/EVENTINJ fields when copying from vmcb12
Date: Tue,  3 Mar 2026 00:34:18 +0000
Message-ID: <20260303003421.2185681-25-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260303003421.2185681-1-yosry@kernel.org>
References: <20260303003421.2185681-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure all fields used from vmcb12 in creating the vmcb02 are
sanitized, such that no unhandled or reserved bits end up in the vmcb02.

The following control fields are read from vmcb12 and have bits that are
either reserved or not handled/advertised by KVM: tlb_ctl, int_ctl,
int_state, int_vector, event_inj, misc_ctl, and misc_ctl2.

The following fields do not require any extra sanitizing:
- tlb_ctl: already being sanitized.
- int_ctl: bits from vmcb12 are copied bit-by-bit as needed.
- misc_ctl: only used in consistency checks (particularly NP_ENABLE).
- misc_ctl2: bits from vmcb12 are copied bit-by-bit as needed.

For the remaining fields (int_vector, int_state, and event_inj), make
sure only defined bits are copied from L1's vmcb12 into KVM'cache by
defining appropriate masks where needed.

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/include/asm/svm.h | 5 +++++
 arch/x86/kvm/svm/nested.c  | 8 ++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 16cf4f435aebd..bcfeb5e7c0edf 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -224,6 +224,8 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define X2APIC_MODE_SHIFT 30
 #define X2APIC_MODE_MASK (1 << X2APIC_MODE_SHIFT)
 
+#define SVM_INT_VECTOR_MASK GENMASK(7, 0)
+
 #define SVM_INTERRUPT_SHADOW_MASK	BIT_ULL(0)
 #define SVM_GUEST_INTERRUPT_MASK	BIT_ULL(1)
 
@@ -637,6 +639,9 @@ static inline void __unused_size_checks(void)
 #define SVM_EVTINJ_VALID (1 << 31)
 #define SVM_EVTINJ_VALID_ERR (1 << 11)
 
+#define SVM_EVTINJ_RESERVED_BITS ~(SVM_EVTINJ_VEC_MASK | SVM_EVTINJ_TYPE_MASK | \
+				   SVM_EVTINJ_VALID_ERR | SVM_EVTINJ_VALID)
+
 #define SVM_EXITINTINFO_VEC_MASK SVM_EVTINJ_VEC_MASK
 #define SVM_EXITINTINFO_TYPE_MASK SVM_EVTINJ_TYPE_MASK
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 97439d0f5c49c..7ae62f04667cc 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -499,18 +499,18 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	to->tlb_ctl             = from->tlb_ctl & TLB_CONTROL_MASK;
 	to->erap_ctl            = from->erap_ctl;
 	to->int_ctl             = from->int_ctl;
-	to->int_vector          = from->int_vector;
-	to->int_state           = from->int_state;
+	to->int_vector          = from->int_vector & SVM_INT_VECTOR_MASK;
+	to->int_state           = from->int_state & SVM_INTERRUPT_SHADOW_MASK;
 	to->exit_code           = from->exit_code;
 	to->exit_info_1         = from->exit_info_1;
 	to->exit_info_2         = from->exit_info_2;
 	to->exit_int_info       = from->exit_int_info;
 	to->exit_int_info_err   = from->exit_int_info_err;
-	to->event_inj           = from->event_inj;
+	to->event_inj           = from->event_inj & ~SVM_EVTINJ_RESERVED_BITS;
 	to->event_inj_err       = from->event_inj_err;
 	to->next_rip            = from->next_rip;
 	to->nested_cr3          = from->nested_cr3;
-	to->misc_ctl2            = from->misc_ctl2;
+	to->misc_ctl2		= from->misc_ctl2;
 	to->pause_filter_count  = from->pause_filter_count;
 	to->pause_filter_thresh = from->pause_filter_thresh;
 
-- 
2.53.0.473.g4a7958ca14-goog

