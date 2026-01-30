Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CF22EB85E
	for <kvm@vger.kernel.org>; Fri, 30 Jan 2026 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769738903; cv=none; b=su0IF8e7iZ+0UdAjekIOdzV4jsGFYhxxqAkUKDw+cQlrXtVXMpw74ld7T71zBr6JQWQEvxx2KF6MFyJeb77OwGSBoi9rndT9Lwar5XSm4HbpUZln9ZHcjyux64mHjDIMNhuBTiwvwvlPLE2Gy4paia4jHZSt/TXIwg9WzUigVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769738903; c=relaxed/simple;
	bh=m9/zeSNq14CxyVs51HJh4An7BZ1Ecba7dMEw86U27pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o52CnCzwLdIbqkicsq98xymxLbW7F5pkERu1/CvoobkLnjApp2rzON9NtXBv9zMd3MKZZ2H+EvrmI95Od+1qTS1ZoaKw8u+Ps5uPNDNhzRt3wfDXiDAP35FOVjvmMx95mCIVc9BfwWwuz+oUibK1Su5xqu1gR/rAFxU7zhm8Mhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xnsj8Ic4; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xnsj8Ic4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769738900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wvS3fiEQ8H0qPwvR4JG9T/NRRh+U6aRn0/0hOCj+hP8=;
	b=Xnsj8Ic42LQx/7P+RiebCfmUmnOYFX1mqolXFg4Fw6jcabhIhbHwlbAv5jUU4WZuqgcPFo
	YJgH6U636muJlp6hGOWVh6TlkEFgU7jfSjBzcJyn0Ue/sa/GBL89J/JhwR/8whMgNPmxCR
	6HG3B+fnIyQlGa/4zEnUaQj7mbnlzM4=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH 2/3] KVM: nSVM: Do not track EFER.SVME toggling in guest mode
Date: Fri, 30 Jan 2026 02:07:34 +0000
Message-ID: <20260130020735.2517101-3-yosry.ahmed@linux.dev>
In-Reply-To: <20260130020735.2517101-1-yosry.ahmed@linux.dev>
References: <20260130020735.2517101-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

KVM tracks when EFER.SVME is set and cleared to initialize and tear down
nested state. However, it doesn't differentiate if EFER.SVME is getting
toggled in L1 or L2+. Toggling EFER.SVME in L2+ is inconsequential from
KVM's perspective, as the vCPU is still obviously using nested.

This causes a problem if L2 sets then clears EFER.SVME without L1
interception, as KVM exits guest mode and tears down nested state while
L2 is running, executing L1 without injecting a proper #VMEXIT.

Technically, it's not a bug as the APM states that an L1 hypervisor
should intercept EFER writes:

	The effect of turning off EFER.SVME while a guest is running is
	undefined; therefore, the VMM should always prevent guests from
	writing EFER.

However, it would be nice if KVM handled it more gracefully.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/svm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4575a6a7d6c4e..eaf0f8053fbfb 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -208,6 +208,13 @@ static int svm_set_efer_svme(struct kvm_vcpu *vcpu, u64 old_efer, u64 new_efer)
 	if ((old_efer & EFER_SVME) == (new_efer & EFER_SVME))
 		return 0;
 
+	/*
+	 * An L2 guest setting or clearing EFER_SVME does not change whether or
+	 * not the vCPU can use nested from KVM's perspective.
+	 */
+	if (is_guest_mode(vcpu))
+		return 0;
+
 	if (new_efer & EFER_SVME) {
 		r = svm_allocate_nested(svm);
 		if (r)
-- 
2.53.0.rc1.225.gd81095ad13-goog

