Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4156E2BD0B;
	Sun,  1 Mar 2026 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328078; cv=none; b=s/Btb0ZVPu5tIZpegKLOBSE8+Hdby+ZMCI4gDOAfX9buXU8hVCelX3ClD8TZvVQiG/CImcirrBfjooeA6HD0Xs3l4AcXTiHjCwW3JxA5YngtANKkqSIKu/UfEb1aP5+8t7eiTWfBzjWQx5KgXkOB+p0yM1ppeIUvWSDXKVMLfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328078; c=relaxed/simple;
	bh=pGzf6WhVMJ3tYTYuYC5AQtZVsJ240z0+qn4B7toQ81Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VIIyhMzMWmNdIVX6j6bxMe1kahfM2LmPAvIjmDBpgEqHsbedU34b1/+oPvcPbnvr5WSxEwNot+bQZuUdOGbdfXPJGiKc//dqn7ztez0Yj4NFvW0N45pjBiE4cgtUc2EfetfFdGWqufTOl6NwA/LIecMcprnRKCOE5LbJe+XC024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAD4h8YW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAD4h8YW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DF6C19421;
	Sun,  1 Mar 2026 01:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328078;
	bh=pGzf6WhVMJ3tYTYuYC5AQtZVsJ240z0+qn4B7toQ81Y=;
	h=From:To:Cc:Subject:Date:From;
	b=vAD4h8YW9orGgtq1aM51xTsAMJ+B/xMp4HrbYrfXOnU57eLkYlcBCcwcws5gdap7O
	 D7XKD2ICnsqOz2VutoR911q+i1VfTgszBOZhWxOT2NH2FZP7Re8rRLznPWrCvkwj6x
	 N/bkpQS5EL38gGkYYo4eve4TlRMB259RZgfs65qfQhfYEylkNGhu4H/MvbTWUv4iQw
	 fxgtwxRXNUIPVyHLkOYI/ClGRCM16DhoHSkdXmThgEAM9UdBpd4z5no3V4+y+t4yKx
	 3oUViG979Dp5XA0JRkj/KxnTANsjE9JAe54Ed/2dh+OZ1mGVgC2EMS5R9Nq5wgJLHm
	 xK9BBBEebmZbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yosry@kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Sean Christopherson <seanjc@google.com>,
	kvm@vger.kernel.org
Subject: FAILED: Patch "KVM: nSVM: Always use vmcb01 in VMLOAD/VMSAVE emulation" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:21:16 -0500
Message-ID: <20260301012116.1677145-1-sashal@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
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




