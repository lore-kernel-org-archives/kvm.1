Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C816451354A
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025374; cv=none; b=HaruKxMm2qR/c2/gwbfPXFBsqIOg7ak0gol04LXKqRUMaqSgXED3pqlSQKbAphAR0yLI7RLWZ5wxVtVSncgJtdUNXeBI87GuiDPiVA/VOLyA4k/ywocFdLLRV/PkjmNnJ2dAh2t0GaabBLsaO+Ztuuob72fdMKfrjBqZ1eubsxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025374; c=relaxed/simple;
	bh=pRV+4Yz/MRvphetpcx2XfsYCtav+An9pfXk6M+2KL+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cjGssFWUW0o5cE0wwTBOL17kaf6Zb5jKWAG04mmKps8ZiHpCuVl98V+8JoNqrtMTNtkUR7X0VhkNREOXESeyvjaK2lgjO+SStlazZBqt6jgY7u7UnJjd0IPblMRX4LodRleG0XYdoBc5+uCB2JPnpo1/mIyLQVG31AF5fail44I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nYHmB6PT; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nYHmB6PT"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so11360659a91.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790025372; x=1790630172; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cljxKoEkJHuB8e5gB97za3SJLDV8TCYQCWMWqDIf1FI=;
        b=nYHmB6PT8s6j2TfY+J6qs2bNq7T2p3V+fTw0BRpknmD28vIzwmOZnseQXu3L67iD/y
         Bl/dYv2SHg78sy4J6xcva9d93tg8NKfp1Kev52JGXFn7oxntcTgIur0pUG8SIyJIFEIW
         6IYdN4UhQLww5KFA1cGtXiHfWSKZMVyQdqgwi8fR/4YoJrHAoHHAddIvij8SbELux5LH
         g2LeWyToXTkDP3Q9H6IjthX3pPYZQWwYMJLnlVapahFXEQ1p0G6lfI64CHV4eDh0Kph+
         AzTfyYzOp7vJ/MkiT4eBpES0/w+EU43zk1ARxrvEZMOqTKevQmfeetdzOgwbUDdkPKtk
         j2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790025372; x=1790630172;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cljxKoEkJHuB8e5gB97za3SJLDV8TCYQCWMWqDIf1FI=;
        b=DiMK6BEyHyv93NSD4UraBJ97sEbMmm/E1lnc96z419ug0e/tJBFcsCzFDcvpd+U8KM
         52kP9aA5dEsY4Lcd+PNNJlXkvmu6ZeBVO1HKAnosPsUx9T75lM5Eg0Jug6PBR5H3mID0
         eVpw8MvycrSky2g7Y9QAgZjWoytRPqz/CaShADIjvJDZLjyMGgd/dHpDMe0XUd4pbtAQ
         KgR3W8wqmfTHCh+ZAbmyKrt0IuuliylvE94RF2og4QGszgrBJ4omrSSjmMbWs4IjYSZF
         MMKJMrh3EXH7z7x6CC3DE7bA04bIcUc4lA/7pNTkEGfdlA5jjgoDnw13S/1Yyy0xC982
         Paww==
X-Gm-Message-State: AFuF++lcdkwH0Zmrrv1dV3/bReadqXo+lcX3IBsHPlKGtD1PuKQiuB1f
	J8uUEF+udKzTMXwvJxJuj2M0P4O395oEiY7EYkZjWhvechOCOvgtnyswZXBWBolDnyqYvz0r97S
	1VwHMUQ==
X-Received: from pjqx12.prod.google.com ([2002:a17:90a:b00c:b0:3a0:525a:e19f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:39ad:b0:39e:6c69:9b95
 with SMTP id 98e67ed59e1d1-39e6c69b29dmr10920170a91.58.1790025371869; Mon, 21
 Sep 2026 14:16:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 14:16:07 -0700
In-Reply-To: <20260921211608.1030158-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921211608.1030158-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921211608.1030158-2-seanjc@google.com>
Subject: [PATCH v2 1/2] KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting
 said pages fails
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jinwoo Lee <rkskek9254@gmail.com>, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Re-pend GET_NESTED_STATE_PAGES before exiting to userspace if getting the
nested pages fails in the KVM_RUN path.  If userspace re-runs the vCPU, and
vmcs02 holds valid PFNs from the *previous* run of L2, then KVM could
re-enter L2 with stale, unpinned PFNs mapped into e.g. the vAPIC page.

Note, both SVM and VMX (as of commit 11722439fb20 ("KVM: nVMX: Ensure
KVM_REQ_GET_NESTED_STATE_PAGES is cleared on VM-Exit") ensure the request
is cleared on VM-Exit (including the "forced" case), i.e. there is no risk
of double-mapping due to emulated VMLAUNCH/VMRESUME/VMRUN *and* the request
trying to map the nested pages.

Fixes: 671ddc700fd0 ("KVM: nVMX: Don't leak L1 MMIO regions to L2")
Cc: stable@vger.kernel.org
Reported-by: Jinwoo Lee <rkskek9254@gmail.com>
Closes: https://lore.kernel.org/all/20260813043932.3214460-1-rkskek9254@gmail.com
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index af3ceee714c9..3c5d3e19ec99 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8024,6 +8024,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
 			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
+				kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 				r = 0;
 				goto out;
 			}
-- 
2.55.0.1082.g2b9226bbc0-goog

