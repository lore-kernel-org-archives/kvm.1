Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320D046C83D;
	Wed,  5 Aug 2026 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927858; cv=none; b=fuCyyGcwPgAzcKiaKoYlJZdpKhNKuBoEtl1ksCijxYWwueWO6cOC1/pPcgormkCSzzPsTMwECsuFl4s+Fti4Fh3HDmjIKqfGrZYYD5bUmHwHAdNXOy5zGmHOBiEoK94hFmEWVE3sdDuFtcMBX6hoDOw9+u5v2/5Rzv+DzJGVWzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927858; c=relaxed/simple;
	bh=GAHxE0g1mYsfBXyYnq1OjQb+2BFDikwZ76iBdw1352s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mr8JtAPr4t1UeTbvhZzTB4d+5qG9LoearPGp03NeThJzMg72fcAHWysJGv++P6K+w5j4Hy+48vNZXnCoZQ7ZxNS4R7atmxkakVQ9534uFLn2qg8oZugWO9ezAUnklhoqASPNhPZTxo4EDxhkD4b+4xISkMTswXoVo4PNC9vI7W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K8Z83p4x; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K8Z83p4x"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 76FD220B716A;
	Wed,  5 Aug 2026 04:03:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 76FD220B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927835;
	bh=MHHLJUnI1oOnr50BM/bsHyy7S5l3AfW3+3Y7ZXO6LCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K8Z83p4xJKlsVl/kF8Jo2P9VGweUXgwE9Y9Srnefmcu4/DwQTPbpPWJJdxhBH9l3J
	 3u8mhfl/4Q14nhYM8Jvc7DZK/T+KLJkMJ1q+W8hvaIQGOKialBoiaSkp6vKUSUY9nU
	 5UlL5u8Gj5iwG2qZK4b0W4mCw+0WfRE2QHChDbDE=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 40/42] kvm: x86: use kvm_vcpu scheduling-state accessors and struct stat fields
Date: Wed,  5 Aug 2026 04:03:22 -0700
Message-ID: <20260805110324.25067-41-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110324.25067-1-snambakam@linux.microsoft.com>
References: <20260805110324.25067-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Finish the conversion begun by the kvm_vcpu_common rework: read
wants_to_run through kvm_vcpu_wants_to_run() and account statistics via
the embedded vcpu->stat.* fields (not the removed vcpu->stat-> pointer)
in the SVM and nested-VMX paths.
---
 arch/x86/kvm/svm/svm.c    | 4 ++--
 arch/x86/kvm/vmx/nested.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 73d80f442a49..44abbd629a66 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2816,7 +2816,7 @@ static bool svm_pat_accesses_gpat(struct kvm_vcpu *vcpu, bool from_host)
 	 * KVM_GET/SET_NESTED_STATE are independent of each other and can
 	 * be ordered arbitrarily during save and restore.
 	 */
-	WARN_ON_ONCE(from_host && vcpu->wants_to_run);
+	WARN_ON_ONCE(from_host && kvm_vcpu_wants_to_run(vcpu));
 	return !from_host && is_guest_mode(vcpu) && l2_has_separate_pat(vcpu);
 }
 
@@ -3240,7 +3240,7 @@ static int interrupt_window_interception(struct kvm_vcpu *vcpu)
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 	svm_clear_vintr(to_svm(vcpu));
 
-	++vcpu->stat->irq_window_exits;
+	++vcpu->stat.irq_window_exits;
 	return 1;
 }
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ddf6df7bee93..2f504fa2e09a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -619,7 +619,7 @@ static int nested_vmx_check_tpr_shadow_controls(struct kvm_vcpu *vcpu,
 	 * and only perform the check when in KVM_RUN, to avoid a false failure
 	 * if userspace hasn't yet configured memslots during state restore.
 	 */
-	if (warn_on_missed_cc && vcpu->wants_to_run &&
+	if (warn_on_missed_cc && kvm_vcpu_wants_to_run(vcpu) &&
 	    nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW) &&
 	    !nested_cpu_has_vid(vmcs12) &&
 	    !nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES) &&
-- 
2.55.0

