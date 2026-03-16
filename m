Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778243F074B;
	Mon, 16 Mar 2026 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692865; cv=none; b=O/aa1HxBUROjC4Rxek2HsSdPlj83XfTvM6lqTZYioKL8kQF3BJQz99fOOTgUA14+TvuDteGo3yZ/KKsaDY7VhZe7U7zHwkQustsmALlqFn+xepGBcZZg5oUwr2VMKeA5XjgIrI8pUQ1acAF/N5fQSXy2l5N0vuTlN8q2odBtEVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692865; c=relaxed/simple;
	bh=L7Px9mnJqTKTfoyK3Xxj13rrvwtzzkeIkI41rSDLyGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L60ejZaHDTD/h7MSHKlW4EKm2pfzm78tALbGXYqJssHobTB/hSPu5XMsKzuKyQhddoCytCh07x2lHLWAw4He2nuStArDBPBJwzjYsurh520d9O0FTa2xF+OUsbUDJ8UPxkH51LtKAcCVzKhnjnMxVbGP+InwjY1EbqcRLLF4nG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWBw7rTe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWBw7rTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B0DC2BCB2;
	Mon, 16 Mar 2026 20:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773692865;
	bh=L7Px9mnJqTKTfoyK3Xxj13rrvwtzzkeIkI41rSDLyGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QWBw7rTeVsxVJraYC4EIRv5ZYPyr/c3JlUHcHghEwrxG/gb8LQq06HX8sidfXqEoK
	 pBWpWmv1s4oy79fQJq6xitJDHY349rKD30UlV51vlkHf8yOxYDtUjvPgUaiPhISvjr
	 TfqKHm4wlA++TsSUg5NEwnO8isCE1xnSpWFbkQKe9EejW8Uu7GIKq35lVYXxa4AtQu
	 n/rri4rr75TIOW3ag70hGgRszLsUaZplAXoDeVSUqEd20M8IqWjpmtXd4g5upAmcVM
	 nmTaC0dOZj5ZACTUku2n1Ly9uUg0nZtleEiwcsdqgwSLs+Z+amGJZGcueHih8h9ZIw
	 VM5IwU/zXeE+g==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 6/9] KVM: SVM: Treat mapping failures equally in VMLOAD/VMSAVE emulation
Date: Mon, 16 Mar 2026 20:27:29 +0000
Message-ID: <20260316202732.3164936-7-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260316202732.3164936-1-yosry@kernel.org>
References: <20260316202732.3164936-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, a #GP is only injected if kvm_vcpu_map() fails with -EINVAL.
But it could also fail with -EFAULT if creating a host mapping failed.
Inject a #GP in all cases, no reason to treat failure modes differently.

Similar to commit 01ddcdc55e09 ("KVM: nSVM: Always inject a #GP if
mapping VMCB12 fails on nested VMRUN"), treat all failures equally.

Fixes: 8c5fbf1a7231 ("KVM/nSVM: Use the new mapping API for mapping guest memory")
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index bb0bb0f9c858f..9f6f60fc8c133 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2201,10 +2201,8 @@ static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 		return 1;
 	}
 
-	ret = kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map);
-	if (ret) {
-		if (ret == -EINVAL)
-			kvm_inject_gp(vcpu, 0);
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map)) {
+		kvm_inject_gp(vcpu, 0);
 		return 1;
 	}
 
-- 
2.53.0.851.ga537e3e6e9-goog

