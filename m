Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795785076;
	b=i+jyV3u+4Wea+hae0grIovo0SnSC26/gSgYg1nK10DcEnXYi/ww9PS8dToucEGdshOaP
	 XQYtjRS/qBu47LXxgCmzp8C7a8ITKVwCb1uIt7GsOd99ga4e3Y9A5aD05KyABsuVyMRFm
	 tiMe+/vKMeiG1kitVeJPTkysvcaENuKO0dl6tVdi823m3VaMDEKGSvUm7O1KT4ypMhp8j
	 Zz3x2DPDNzBOUbCDb/YZa1pTVxKkV3CA2tA5VZfZBxjwkWqsdjWtbz3yDZSefXNv32Cl1
	 6ERjTHW1rDxaeAHL5teC/zuo20sHYlqjpcX5QQT+PdvfGjX88pz4mutXf6iRvpF0dtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785076;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=xjKUP9AknZthWMDW4B+VkLH6A/Liu4JS9Wqwar7yjbY=;
	b=QO4bD13wecHkh0C9G1j34bzwotcjmHvlRDmVTSUWGCbOt/gfPEzWhVvUJ9TBCH3fe5Ru
	 QYV+YAO1U41eROYnRcJ2CJpFr/Qwcb7ZjGHyckTv5wy/ZzW+QSe4UD8RwQbSs89DaB+od
	 4HIy1hYwH5mmI9dlXMVl9sIz/yO9HoQm01dj9d4D5lq5o7UnhTLIJb9O2pnGdgmh2dX8H
	 /0Hlwj8IJR5lUcDu4SDIOYAquiOX7O8VzwawpLwUABuHvpt/weDOnrYO6tc09jmpAR+I+
	 iGoDwZrHTjF539EaAEz8oadZgtkfrJttqso1oIP09HqkPiZLTRTijRLPz0gdwXoMm2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKyonTN4;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0963606A31E
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKyonTN4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795785076;
	b=oIeXLKBddiJHRE+eLs3bJCQGlawYHZBw0O4dWQtGfL4GhQYGqdIv9DHr+Fdj17UVjR0L
	 0XThe40OFoT0+oVsY3BIb1g02cJ1DFmQfPXvQzJM8b/ZPBhj/En/dnLqqgl10o44scnBi
	 OpbgvebF65HkIhKL63slrlwmrXoexUWlTuXOfChyGSxbfi9CElQApm6hAQb5+Txd/okf/
	 5N3WS8UenjoZf5zSQ2wB36YSfAaawnorEblaVj5wzxDsdyotgyZjC8ZUJlJIln0XOW3Yu
	 FFKP75lxrbrzI0LZ0tYSa4SzYCvCB+BnfOZWEe38kzw7tJSAol12Uhy/0FtEQVa0mdQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795785076;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=xjKUP9AknZthWMDW4B+VkLH6A/Liu4JS9Wqwar7yjbY=;
	b=JgsmFpfxAvJaWszjZGBXT/oMvgVQ4I1S/ylqXJFRcgkymyEG0bzRA2+VJFYMa/6nUPA0
	 8TakXHYtAjTzOjoqvk5w2XiWeVxZsLyRaFZEcQ+eNs56PWQQD5+Bp70xq8E19UMfD8bRq
	 5QArYBBXPmbF1Zl8Nj5H3Mnu5jMRxsPs/0dp3pbgVwEmkpYjqtoF5PZvczTCPEqFL1g9V
	 1XgPpTL2bp7QKaFNMuc0coNKzwTkwXdTcMp7SCTvNhDxfP19XU+gdJ62IFgHAeS03VXEU
	 MYgSpONHGyI02JdekwsUsdi8QQlzYnIyfITBGOZxvVRrHthL0w/C/J2fQizs7mu38hw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AAF711F000C1;
	Fri, 27 Nov 2026 13:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795785076;
	bh=xjKUP9AknZthWMDW4B+VkLH6A/Liu4JS9Wqwar7yjbY=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=KKyonTN4RTJPx32wFYQKG2MkRXG28evql/mhVrL/sI/3/WqT5qim7NBPqecq1Ld7q
	 2uC/exLgS43NbyR9K9o33QReftuA+8ED7g6prBsnGk7RlrUcC6gEKhW0DbeQX9KiVm
	 nl9ybdNzY5kqmbEXWWbN18tHV1pXvxYAHbLSuokWkDrr/pFgOp/82xNjwor0FkDG3k
	 hFcl3FrZBMJIkgE0C3G4+tyGqPC1Bg+VphrkpYwPtFSOVVlcsbdqETpRw1QqkWSO9N
	 b06tN2bi0AIO1NvRBYNfMMzhUN/D+334zbwrouabH+c9fgXHxQ9XERuWJ2B67yd6zw
	 HKN1/j17+oogQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3CACD4B7D6;
	Fri, 27 Nov 2026 13:11:07 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Fri, 27 Nov 2026 13:07:17 +0000
Subject: [PATCH 5.10.y-cip] KVM: SVM: Inject #UD for INVLPGA if EFER.SVME=0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-cip-svm-510-v1-1-a9cc8da73701@certik.com>
X-B4-Tracking: v=1; b=H4sIAISACWsC/02NSw7CMBBDr1LNmilJpFLEVRCLfKZ0ECRVplSgq
 ncngQ1L28/2CkKZSeDUrJBpYeEUi9C7Bvxo45WQQ9FglDlobXr0PKEsD+y0wkDBGN+7Iw0KSmP
 KNPDru3aGrtWqfVceLr9Mnu5Gfq5zlXZWCF220Y/VEophTumO1d//3cC2fQBA6w6bpwAAAA==
X-Change-ID: 20261127-cip-svm-510-ded22c7b8ef0
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@nabladev.com>, 
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, 
 Ulrich Hecht <uli@fpond.eu>, Kevin Cheng <chengkev@google.com>, 
 kvm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795784836; l=1964;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=UKLupv1I54lhHtmKvF2aNY9MdYYKj1h36BecxzAIQ9k=;
 b=ianuIF86t5yrt1iLKHDJIxEKIqrxzMI8OAsLc3N7S9iijcYpvnHzfwjd4+8R+7rAbTKCb/krL
 7SZXCim+GAxBnOgc44fnOoFEuE63qj8hdafdPtaB+rKPcfEcRXpIVVv
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

From: Kevin Cheng <chengkev@google.com>

commit d99df02ff427f461102230f9c5b90a6c64ee8e23 upstream.

INVLPGA should cause a #UD when EFER.SVME is not set. Add a check to
properly inject #UD when EFER.SVME=0.

Fixes: ff092385e828 ("KVM: SVM: Implement INVLPGA")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Cheng <chengkev@google.com>
Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Link: https://patch.msgid.link/20260228033328.2285047-3-chengkev@google.com
[sean: tag for stable@]
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ adapted to 5.10.y-cip: pass the vcpu_svm argument to the branch's permission helper ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
The 5.10 nested SVM permission helper takes a struct vcpu_svm pointer.
The backport passes that pointer from the INVLPGA handler.

Tested on 5.10.272-cip79: arch/x86/kvm/svm/svm.o built with W=1
before and after the patch, with no new diagnostics. The same paired
build passed on the 5.10.275-cip80 tip. On v5.10.275, svm_vmcall_test
passed in a QEMU TCG EPYC guest and skipped in the Intel/KVM guest.
The runtime test was not rerun on the CIP tip.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.
---
 arch/x86/kvm/svm/svm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 41a4ee2aaa4c..f7862a5b686f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2162,6 +2162,9 @@ static int invlpga_interception(struct vcpu_svm *svm)
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 
+	if (nested_svm_check_permissions(svm))
+		return 1;
+
 	trace_kvm_invlpga(svm->vmcb->save.rip, kvm_rcx_read(&svm->vcpu),
 			  kvm_rax_read(&svm->vcpu));
 

---
base-commit: bd8b111cdf1d9897bf4d826b7305a9c16bfe5f71
change-id: 20261127-cip-svm-510-ded22c7b8ef0

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


