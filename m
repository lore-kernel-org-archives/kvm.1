Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3123C3A75A3;
	Mon, 31 Aug 2026 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212237; cv=none; b=KzA0s9BWaxQUVdJx6Z+b1WiRhUUfJkR2RXQQkSqTHXxxiyhGPnAs9x9hDloeOScSgzAZxfPlXPf1XXX2d4CUlawPqwlkBjqJ/5exDuPiOp0IhX3a9p0SN+LLwocUDsM6niNbTno5CBhLnH4HASaFJBDy/MpHhhDpfe2Zs/37do4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212237; c=relaxed/simple;
	bh=pQBUuzGBdhca/pb/CPWFjNdUuWtAlko9agi31rzEx20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4wBIjpz8DhyEmp7+lZCtc9XZrYQehK03c2rI5rsPsQgIU4lnzDtnN6rovNgxQXyoMpkn2541eMKzVRDnHNo5kZy/s3tN/UemR1eT+UJL/FqKg+WjzEbyzFLl0RzTqYL0XrFweOpJx0CW0O7bvM2+X+wsEEebIiX/7kN2Vib0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i6D0bKGs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i6D0bKGs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=k6ICnEzwlloF0OM4G600jQ5a0zbrsIa5Jjgjx0H/ZIU=; b=i6D0bKGsdiReePk+0/SPadyrC7
	6hF8j46QtxHiu4vDg79uZ1OFGkjvxJaKjVVG9COMZQvkCA1ZGNLUvwp2HGqYzMbzjRJMgwKOPRBMg
	dD9ySVJ02+hvRhIlj5Z3tywzOv4OS7BlV41U3NbvJmBiCJvyTYvnmJNS1a03QsevDnxz/r8pqk3ha
	XTSOUCKqiZ3K9jOwB1xcofHAFTIVy5aEPIRZXB5wj2KgNOI1hGmTvgywY1pzPhiZSof8kuc48fuOX
	d+liko3LLuOqis90gSvW/u0fDF3hnVAb1hrIKbNaE0W18mfSyNzRWzeq3CVB/Ol9NLfLtvRsaj8Kh
	HBjecBfQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x19gE-00000003sus-0Y2H;
	Mon, 31 Aug 2026 21:36:38 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x19gD-00000000LCe-3cZo;
	Mon, 31 Aug 2026 22:36:37 +0100
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
Subject: [PATCH v3 01/13] KVM: x86/xen: Rename 'longmode' to 'is_64bit' in hypercall handling
Date: Mon, 31 Aug 2026 22:26:32 +0100
Message-ID: <20260831213632.81023-2-dwmw2@infradead.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

Rename the local 'longmode' variable and function parameter to
'is_64bit' throughout the Xen hypercall handling code. This
distinguishes it from the VM-wide kvm->arch.xen.long_mode which
represents the Xen shared_info layout mode.

The 'is_64bit' parameter indicates whether the vCPU was in 64-bit
mode when it made the hypercall, which determines how to parse the
hypercall arguments. The UAPI field name (vcpu->run->xen.u.hcall.longmode)
is unchanged.

Assisted-by: Kiro:claude-opus-4.6-1m
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 998cdcb6aa30..8eda3a71462e 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1485,7 +1485,7 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
 	return ret;
 }
 
-static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool longmode,
+static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool is_64bit,
 				 u64 param, u64 *r)
 {
 	struct sched_poll sched_poll;
@@ -1497,7 +1497,7 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool longmode,
 	    !(vcpu->kvm->arch.xen.hvm_config.flags & KVM_XEN_HVM_CONFIG_EVTCHN_SEND))
 		return false;
 
-	if (IS_ENABLED(CONFIG_64BIT) && !longmode) {
+	if (IS_ENABLED(CONFIG_64BIT) && !is_64bit) {
 		struct compat_sched_poll sp32;
 
 		/* Sanity check that the compat struct definition is correct */
@@ -1594,12 +1594,12 @@ static void cancel_evtchn_poll(struct timer_list *t)
 	kvm_vcpu_kick(vcpu);
 }
 
-static bool kvm_xen_hcall_sched_op(struct kvm_vcpu *vcpu, bool longmode,
+static bool kvm_xen_hcall_sched_op(struct kvm_vcpu *vcpu, bool is_64bit,
 				   int cmd, u64 param, u64 *r)
 {
 	switch (cmd) {
 	case SCHEDOP_poll:
-		if (kvm_xen_schedop_poll(vcpu, longmode, param, r))
+		if (kvm_xen_schedop_poll(vcpu, is_64bit, param, r))
 			return true;
 		fallthrough;
 	case SCHEDOP_yield:
@@ -1618,7 +1618,7 @@ struct compat_vcpu_set_singleshot_timer {
     uint32_t flags;
 } __attribute__((packed));
 
-static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, bool longmode, int cmd,
+static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, bool is_64bit, int cmd,
 				  int vcpu_id, u64 param, u64 *r)
 {
 	struct vcpu_set_singleshot_timer oneshot;
@@ -1662,7 +1662,7 @@ static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, bool longmode, int cmd,
 		BUILD_BUG_ON(sizeof_field(struct compat_vcpu_set_singleshot_timer, flags) !=
 			     sizeof_field(struct vcpu_set_singleshot_timer, flags));
 
-		if (kvm_read_guest_virt(vcpu, param, &oneshot, longmode ? sizeof(oneshot) :
+		if (kvm_read_guest_virt(vcpu, param, &oneshot, is_64bit ? sizeof(oneshot) :
 					sizeof(struct compat_vcpu_set_singleshot_timer), &e)) {
 			*r = -EFAULT;
 			return true;
@@ -1694,7 +1694,7 @@ static bool kvm_xen_hcall_set_timer_op(struct kvm_vcpu *vcpu, uint64_t timeout,
 
 int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 {
-	bool longmode;
+	bool is_64bit;
 	u64 input, params[6], r = -ENOSYS;
 	bool handled = false;
 	u8 cpl;
@@ -1704,8 +1704,8 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 	    kvm_hv_hypercall_enabled(vcpu))
 		return kvm_hv_hypercall(vcpu);
 
-	longmode = is_64_bit_hypercall(vcpu);
-	if (!longmode) {
+	is_64bit = is_64_bit_hypercall(vcpu);
+	if (!is_64bit) {
 		input = kvm_eax_read(vcpu);
 		params[0] = kvm_ebx_read(vcpu);
 		params[1] = kvm_ecx_read(vcpu);
@@ -1751,17 +1751,17 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 			handled = kvm_xen_hcall_evtchn_send(vcpu, params[1], &r);
 		break;
 	case __HYPERVISOR_sched_op:
-		handled = kvm_xen_hcall_sched_op(vcpu, longmode, params[0],
+		handled = kvm_xen_hcall_sched_op(vcpu, is_64bit, params[0],
 						 params[1], &r);
 		break;
 	case __HYPERVISOR_vcpu_op:
-		handled = kvm_xen_hcall_vcpu_op(vcpu, longmode, params[0], params[1],
+		handled = kvm_xen_hcall_vcpu_op(vcpu, is_64bit, params[0], params[1],
 						params[2], &r);
 		break;
 	case __HYPERVISOR_set_timer_op: {
 		u64 timeout = params[0];
 		/* In 32-bit mode, the 64-bit timeout is in two 32-bit params. */
-		if (!longmode)
+		if (!is_64bit)
 			timeout |= params[1] << 32;
 		handled = kvm_xen_hcall_set_timer_op(vcpu, timeout, &r);
 		break;
@@ -1776,7 +1776,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 handle_in_userspace:
 	vcpu->run->exit_reason = KVM_EXIT_XEN;
 	vcpu->run->xen.type = KVM_EXIT_XEN_HCALL;
-	vcpu->run->xen.u.hcall.longmode = longmode;
+	vcpu->run->xen.u.hcall.longmode = is_64bit;
 	vcpu->run->xen.u.hcall.cpl = cpl;
 	vcpu->run->xen.u.hcall.input = input;
 	vcpu->run->xen.u.hcall.params[0] = params[0];

base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.55.0

