Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D379B2E5B09;
	Sun,  1 Mar 2026 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329811; cv=none; b=dBHKkdq6P0bTYa+GfywdVLxphoPsuygUANMxTHDixcKk14lGdlYoimehQI4Zqvmpj9L35wAjDNhcuD7VGAx1IZbYG1QhF52u6OmC7YRx6j1SaLiPdZZ3ufFqtv8woG5MtASlN8r3C8zk11tjCLwbdYvEoJlGP02rdDV6C2gmlBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329811; c=relaxed/simple;
	bh=X2vsebki6u29Q3pYe7AhkHhlCbtf/XQ2ge94PdFh/Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4jkMpliXBjerB9tS3LmEcDQIAAU+c2JsmsPBcG4MpBu1LYvRqXUQvOTmHQxwrjWP0kli7FIqIC4F+UBDGuWYSrW5cr3vnm9fbg9SIVg89teyEz0gnZDuLe8KJKBJEwcWINzexcMQcE3QTAZ+av19eN72mqq30X9v7fEtOI32mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auhU4LWr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auhU4LWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FF6C19421;
	Sun,  1 Mar 2026 01:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329811;
	bh=X2vsebki6u29Q3pYe7AhkHhlCbtf/XQ2ge94PdFh/Qo=;
	h=From:To:Cc:Subject:Date:From;
	b=auhU4LWrevFuZJ15Mit+uYFVwPc9Arv+Yvifqs5xJxDIae7D/X8qCiUyeCEo/mXh6
	 94XYp0aavivhxGu3iEWYQ+28CT8/7gRQodT/oaU0aVW/iYkOZ5TckVQiYJ0azwQpJm
	 iif+MEinD80RLnj0/UsYLyUbvUses3AX4jfeTgIkk+2XdcuVf3t2IhG6W8ZvqiK5gd
	 cvnGbWVvvqG4vi/rZEJeaPFs8q3GRhjK8XU6Ico+3D+FVKUDDyP1kp9O734Gi66Pf2
	 EzxVHJ0XNxPzokavv5gKFLEDW518vJ2eI+cXdrLq9b6Xfl6bz5voUIfaXM6B4jsKYA
	 2bUBi17CuVTPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yosry@kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Sean Christopherson <seanjc@google.com>,
	kvm@vger.kernel.org
Subject: FAILED: Patch "KVM: nSVM: Always use vmcb01 in VMLOAD/VMSAVE emulation" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:50:09 -0500
Message-ID: <20260301015010.1715987-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 127ccae2c185f62e6ecb4bf24f9cb307e9b9c619 Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry.ahmed@linux.dev>
Date: Sat, 10 Jan 2026 00:48:18 +0000
Subject: [PATCH] KVM: nSVM: Always use vmcb01 in VMLOAD/VMSAVE emulation

Commit cc3ed80ae69f ("KVM: nSVM: always use vmcb01 to for vmsave/vmload
of guest state") made KVM always use vmcb01 for the fields controlled by
VMSAVE/VMLOAD, but it missed updating the VMLOAD/VMSAVE emulation code
to always use vmcb01.

As a result, if VMSAVE/VMLOAD is executed by an L2 guest and is not
intercepted by L1, KVM will mistakenly use vmcb02. Always use vmcb01
instead of the current VMCB.

Fixes: cc3ed80ae69f ("KVM: nSVM: always use vmcb01 to for vmsave/vmload of guest state")
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Link: https://patch.msgid.link/20260110004821.3411245-2-yosry.ahmed@linux.dev
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e454ae095cf7c..f1a5b61bdb5bc 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2122,12 +2122,13 @@ static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 
 	ret = kvm_skip_emulated_instruction(vcpu);
 
+	/* KVM always performs VMLOAD/VMSAVE on VMCB01 (see __svm_vcpu_run()) */
 	if (vmload) {
-		svm_copy_vmloadsave_state(svm->vmcb, vmcb12);
+		svm_copy_vmloadsave_state(svm->vmcb01.ptr, vmcb12);
 		svm->sysenter_eip_hi = 0;
 		svm->sysenter_esp_hi = 0;
 	} else {
-		svm_copy_vmloadsave_state(vmcb12, svm->vmcb);
+		svm_copy_vmloadsave_state(vmcb12, svm->vmcb01.ptr);
 	}
 
 	kvm_vcpu_unmap(vcpu, &map);
-- 
2.51.0




