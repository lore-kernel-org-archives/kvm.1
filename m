Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BE53A9D95;
	Mon, 31 Aug 2026 21:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212239; cv=none; b=noDKqJQwtyI5QES+VmdJPiUNFH+XU+41lXSIQ+c3d2CPdr0wrE3VaJw92Q8F7xESsyJtQHpIrfDNnvYTtCMvpayiKqXkvm65mCR44ueBOFlfSJA3ceFQcz7XwoO8pry7RjfzLO3078S7viJ9o1oGSN/mSiYXr10dt8k0/GnacjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212239; c=relaxed/simple;
	bh=FyY3uVamnpC8xVLC50YgBZ80X1IUdSfNKvwQfY5h108=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ceye5oIU8a8fpmMsKd0jj8kaFhFkbNbq4l2LyicrXfm8fHMRvs6sJmOe2UuiufrsFsfUiOaaRIct2Q2hC59YF50QXLZatiwq7+nhSXoiB4mlH+V5PgsKvws6VqybLnUKvZ5Y1rbIfZKbMtts+nBd/Irehnq2Ad9mbds5nMCs62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZYtYRckM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZYtYRckM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CpmWoYCHdJ/VH3IGPs4UcXurcmngqIaORNYAp84Yflk=; b=ZYtYRckM7nGDTMLHhO7W1JWAEg
	OmnapDJvvtUv23H6dd4/y+rOpTNy3F+S2FzRlweVGHT95TTUHJyTunZybvMTEKHCAGcxgZzQpupsN
	i8ZH03fmPoG70bOLLjww2dTfHqREu4PqBfm1m0LBBo1BaZHA7KsTI3ZG28+vhYIQ5IpLWqAj87oVv
	X2c5RnUOyTNxr2Yjq0vPn+A68u/W2UOyeqUx0BZBtVECgevtbIRvtNsyU2rgTPT5GVUgzfIrjS4sE
	GVV6VFl1TsJH/d8fAKyKbVeeBBi/BoG1iSQPfXhRi2SJ+4ToY5A4Fa9Pndi97jMKfvFf/blaFyQCY
	KNXFhaLQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x19gE-00000003sv9-33rE;
	Mon, 31 Aug 2026 21:36:39 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x19gE-00000000LDK-2ClL;
	Mon, 31 Aug 2026 22:36:38 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: dwmw2@infradead.org,
	paul@xen.org,
	joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com,
	ankur.a.arora@oracle.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	x86@kernel.org,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	suryasaimadhu369@gmail.com,
	lkp@intel.com,
	nicoyip.dev@gmail.com,
	frn1furkan10@gmail.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH v3 11/13] KVM: x86/xen: Mark poll_evtchn accesses with READ_ONCE()/WRITE_ONCE()
Date: Mon, 31 Aug 2026 22:26:42 +0100
Message-ID: <20260831213632.81023-12-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831213632.81023-1-dwmw2@infradead.org>
References: <20260831213632.81023-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: Chengfeng Ye <nicoyip.dev@gmail.com>

Use READ_ONCE() and WRITE_ONCE() for runtime accesses to poll_evtchn.
This marks the intentionally concurrent scalar accesses and prevents the
compiler from splitting, merging, or inventing accesses.

kvm_xen_schedop_poll() publishes the single port, or -1 for multiple
ports, before setting poll_mask and halting the vCPU.  Event delivery can
call kvm_xen_check_poller() on another CPU while the vCPU thread publishes
that value or resets the field to zero after returning from
kvm_vcpu_halt():

  vCPU thread                         event delivery thread
  -----------                         ---------------------
  poll_evtchn = port
  set_bit(poll_mask)
  kvm_vcpu_halt()
                                      poll_evtchn = READ
  poll_evtchn = 0
  clear_bit(poll_mask)

The plain read and writes therefore race.  KCSAN reported:

  BUG: KCSAN: data-race in kvm_xen_hypercall / kvm_xen_set_evtchn_fast

  read to 0xffff888112f55af0 of 4 bytes by task 98:
   kvm_xen_set_evtchn_fast+0x204/0x7c0
   kvm_xen_hvm_evtchn_send+0xab/0x100
   kvm_arch_vm_ioctl+0xb31/0xd90
   kvm_vm_ioctl+0xf42/0x16c0

  write to 0xffff888112f55af0 of 4 bytes by task 96:
   kvm_xen_hypercall+0xd8d/0xf50
   kvm_emulate_hypercall+0x157/0x1d0
   vmx_handle_exit+0x40f/0xae0
   vcpu_run+0x137f/0x27d0
   kvm_arch_vcpu_ioctl_run+0x5a5/0x970

The field is an aligned int on x86.  Access annotations preserve the
existing matching, callback, and poll-mask control flow while making the
single-copy access requirement explicit.

Fixes: 1a65105a5aba ("KVM: x86/xen: handle PV spinlocks slowpath")
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 871cbaf8b68d..d15c62ad7932 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1581,9 +1581,9 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool is_64bit,
 	}
 
 	if (sched_poll.nr_ports == 1)
-		vcpu->arch.xen.poll_evtchn = port;
+		WRITE_ONCE(vcpu->arch.xen.poll_evtchn, port);
 	else
-		vcpu->arch.xen.poll_evtchn = -1;
+		WRITE_ONCE(vcpu->arch.xen.poll_evtchn, -1);
 
 	set_bit(vcpu->vcpu_idx, vcpu->kvm->arch.xen.poll_mask);
 
@@ -1602,7 +1602,7 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool is_64bit,
 		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
 	}
 
-	vcpu->arch.xen.poll_evtchn = 0;
+	WRITE_ONCE(vcpu->arch.xen.poll_evtchn, 0);
 	*r = 0;
 out:
 	/* Really, this is only needed in case of timeout */
@@ -1822,7 +1822,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 
 static void kvm_xen_check_poller(struct kvm_vcpu *vcpu, int port)
 {
-	int poll_evtchn = vcpu->arch.xen.poll_evtchn;
+	int poll_evtchn = READ_ONCE(vcpu->arch.xen.poll_evtchn);
 
 	if ((poll_evtchn == port || poll_evtchn == -1) &&
 	    test_and_clear_bit(vcpu->vcpu_idx, vcpu->kvm->arch.xen.poll_mask)) {
-- 
2.55.0

