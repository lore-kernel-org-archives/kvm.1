Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489920;
	b=fsqmaWAgF5EDYaVpPVFlnm26Pvxzec29ckYBaaYGMQ1QXsI6QWZWILW6PT9o5WxCaYZ9
	 Dbo3659tja5DXcUCtyiP2zExG5jN5VEUdGnoUqE3Yn5EtS5OzPY8ebVwiZbhw4YhACPUQ
	 ttTLLho9ZPeuP+4tiyrhU9emGcZDa6VMfKdTaB7d9X/OMv9ggBZMrEMDTz4ypqAgUVWuT
	 1YGbUMij7Y0YUUgfNMYC/TzM42F2mLNVkYGOV0Dodb4AgwU3b0EG/f4CAxTbenTzkj4gn
	 Fb3iEe5pk930m4DxvpVPy+BmWDfXNPjU4BVuVlpsZF6w1cNdlnOEgp1FPeuDdxxAsMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EK+8SMQbD6BCNXEB/btN5Fdx6HGhkX9byuug8RS/Ijw=;
	b=1wH2LANCwCk+7xZ0nwdxo517QyJ3LObt+Ld3qNvf2N1/iO1CQouEYT3YGj3f6OnwxiJL
	 FO8EYk3mUpmEfLmcDdVCcbJS58cTh9s4r3ey4b67Da5UjJ1zHDD1L9cZBFcNRp3cHWWhn
	 e6TRuTqR/wzWY3odmYjk9ZquZSbfZgJUJiZ5MXfZm0ltxboQ1xpZbjPdQc1sWM43xlmqQ
	 dyeOilEb0iSc+fkiRpa6t/G5COFGkTbd8ddmEi8dRFeAWticuFc7afK/KhE15FrrXCdLn
	 Djb4obCMenK4/dewKcUm811nC2rDFsd1MRtVaM7kfGtBKw6TrPfRSBthyWBla7/gKCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fUXpoxOz;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6390606A31C
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 13:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6390606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fUXpoxOz
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so2540395a91.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 05:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794489919; x=1795094719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EK+8SMQbD6BCNXEB/btN5Fdx6HGhkX9byuug8RS/Ijw=;
        b=fUXpoxOz/e9Byb2r/nTez6z2D7p5ytz3sLY838y2HCcn0SEzSRRSkX0MfZJliHpGqj
         3hqn6AlZrOwUYdDdp1sGTUjT/u9YktIde+UPCiejdNvh6OWGnWY4C49KHfDdSg1i7qcd
         LK15iWW+rJrQT7r89oO0Tljpvf22d8YHh57wJbVb4tkkwnBmPjbELkGHaFrOD1Aoubec
         vH95RliSOSxfcZh4woOCeaD+kdzC1H/dSp9D58l7mmjzSt5etHpdKRsw17NDab7/xB2+
         74PX9oisGyZCCNAiOzmCzUtploBivo+uz+xSZ1adqTsgZtm9C/ZpBKpC/8RV+10dbOy3
         46eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489919; x=1795094719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EK+8SMQbD6BCNXEB/btN5Fdx6HGhkX9byuug8RS/Ijw=;
        b=iHEV/5cgsSJvI6vBQ3ngFVx36TULBep0AmEYGBLfUqhdU0BMr/Ir16VEFsln/LGT+k
         kBcGIDs3euo77Tlv13MQwHpt3L4+Z31bpBNAF2vAzW29RYOX035ZpJkjvl5KegLn19vk
         sxF8hRt49UGa7ClEQkX4rAg168Z7o4dtIcO7cK4fpUcRJXaKjzs+Zarq+VCX7hZn0kJv
         3TrwqASpHboX1ahXWRUXxMvDUl8DCLfNYa11g9XZfiZ/mj0Psmi33fXMst3OcOTPTERy
         tD8WZ+l8BdYOr0O9d20YQCViNqSMkGVxuak6va6ZHztH48xMP3Oc87m+AM8OJ77hck4j
         7Yvw==
X-Forwarded-Encrypted: i=1; AL+hErFsQKGMm2oN2tcy1wNwq6Uhdkp6F4NfqXuxWZKnBmRcituPa0G2WRmNmMhpKtUm8vrJLok=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RflKguxESauzPlkaqPt6FNw9zYh3oXtTYGyWLwxNmnAgk7Cz+
	lD3Hh1L0a01dsqg5Velv5pVwRU5vLdZySNWjERJJ/diJlvcoLuqCZoOv
X-Gm-Gg: AYBFou31MB5Pzw21Kl71QWDQ/34lYGdTrQLcUp2NOJLpU73Z0zWTLJYJYc52kJ/Sx8u
	dDHxgt/8UV28/45Bo9zJ1gGP8AzEm1zhbWW0XznilTLIP2yQlP0NqnpgEgRqJGiuS7/3R23edRj
	zAXuwfwddJOcv+J2Nvx+jKfXc+WSmkj4bNa3+/VORevP/ww51kx5+ESxhGnkrTWAL85aixKq/zK
	f42YoiIR0czBMQiydqld8zNQg4yNletQneFk4egkDLgc51nGvOfLUUk5TMt2hTKHijzkk91nG5M
	7tTj51VZOanpnSdcQQOuhuLhcTAtuHfNgEN/mQsHbp8h/v0CiOAE1u2Ip0oE7cnrTCRo8ZrmnJ0
	9HFoMl3RvD3GG7nrUm+icS6dY3mY+b9htDnW7RQOA1ySahzb+WQINhTmCODzuGXAryvkj0zWRza
	DpGYBwb0F8hhe7tMtSEGjKWIat1rcmAzyQxMHT9xkRGDghQDPMNqTEqV/ze2n8zzZEYuH/rX0Pa
	Oj2C9xZloPdqdpAyTYueMf1wPdBZo6N0sZ0ZGg528eozcwmBTtZa3Q0SBa9oSCB+MhAl5thLUCp
	hiuuorBJ5AUkTN3geuvBDLoK/JSeLwKTSgASrswNbeaqc7M=
X-Received: by 2002:a17:90b:1647:b0:3a8:c0cd:57f9 with SMTP id 98e67ed59e1d1-3b182f26a0emr5570553a91.25.1794489918695;
        Thu, 12 Nov 2026 05:25:18 -0800 (PST)
Received: from LIKEXU-MC4 ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddbf3c0f6fsm54468a12.5.2026.11.12.05.25.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 05:25:17 -0800 (PST)
From: Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Oliver Upton <oupton@google.com>,
	kvm@vger.kernel.org
Subject: [PATCH] KVM: x86: Don't patch L2's hypercall if L1 intercepts #UD
Date: Thu, 12 Nov 2026 21:25:12 +0800
Message-ID: <20261112132512.68348-1-likexu@tencent.com>
X-Mailer: git-send-email 2.54.0
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

From: Like Xu <likexu@tencent.com>

The fix_hypercall_test selftest fails when run in an L1 VM on an AMD host:

  ret == (u64)-EFAULT

On SVM, L0 always intercepts #UD in vmcb01, so nested_svm_exit_special()
claims every #UD from L2 for L0, before L1's intercepts are consulted.
L0 then emulates L2's VMCALL and, based on the quirk that L0 userspace
configured for L1, patches it to VMMCALL. This ignores L1's decision to
disable KVM_X86_QUIRK_FIX_HYPERCALL_INSN for L2.

Synthesize #UD instead if the vCPU is in L2 and L1 intercepts #UD, so
the nested exception machinery reflects it to L1.  Keep patching L2's
instruction when L1 doesn't intercept #UD, as existing userspace relies
on it, e.g. nested SVM selftests execute VMCALL in L2 and expect L1 to
see SVM_EXIT_VMMCALL.

Fixes: f1a9761fbb00 ("KVM: x86: Allow userspace to opt out of hypercall patching")
Signed-off-by: Like Xu <likexu@tencent.com>
---
 arch/x86/kvm/x86.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2cd9ee316aada..8c1ae90f1f4b4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7507,9 +7507,15 @@ static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt)
 
 	/*
 	 * If the quirk is disabled, synthesize a #UD and let the guest pick up
-	 * the pieces.
-	 */
-	if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_FIX_HYPERCALL_INSN)) {
+	 * the pieces.  Do the same if L1 intercepts #UD from L2, as fixing up
+	 * L2's hypercall is then L1's responsibility; the #UD is reflected to
+	 * L1.  If L1 doesn't intercept #UD, keep patching L2's instruction, as
+	 * existing L1 code (e.g. nested SVM selftests executing VMCALL in L2)
+	 * relies on it.
+	 */
+	if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_FIX_HYPERCALL_INSN) ||
+	    (is_guest_mode(vcpu) &&
+	     kvm_nested_call(is_exception_vmexit)(vcpu, UD_VECTOR, 0))) {
 		ctxt->exception.error_code_valid = false;
 		ctxt->exception.vector = UD_VECTOR;
 		ctxt->have_exception = true;
-- 
2.43.7

