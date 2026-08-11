Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69383126D7;
	Tue, 11 Aug 2026 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441762; cv=none; b=oeTCxhb5tLY/CwHvjchFSqaPDQWLlcXhLNWhg/NAm6Tjc5dRGokoz/NfqoAuNH9pccE7mOq/OH0wzjjcWCboyj3k0bg6mX0hYaX2419xqNnevzcUtsFjthcHsIb5CZH6JfKX8rQjucIUtdOulwvaDnxtNRqhIy9nbUlbB3PJCFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441762; c=relaxed/simple;
	bh=YQjZRqd9me+k049knZXJzmBtE9xWMwP42jyAsPl5tR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1sQAskUDwmxjWOZusGJTAOh72aWtnASC8BiDyJ4N8a4cizHDk0KLmdF/+Z13vietyBEON3CB7INfSZ7EavRgRwq6ShJIllr+hteFh2yDqK4ei3gWyLCnb3HFvRS5Re2N6KUVplOx+Ggy6GmQovh+laTvXSaXPVo13ahp9q5okc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VtdqW0r3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VtdqW0r3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kpe59k50IQP+BIttRK24gQPQ2oNpO8XFaqOyaurDCoo=; b=VtdqW0r3D7WPZ3Hxc4qGBdKklz
	oo2cIiHzQRxI1f1wbSHPicSq3g9UT/asElnwcwMuKXywit0NA9D0WaicJ60GWYRTmlIhXlOmFTqhz
	m5wHTPkZyXxFFqaap5H/9kfdUsK1QNSnRlPfpCfgkL0M/L/oI1KEw+7MP4oQCeczBpjkO5i7fHxNA
	Zv7bRJyi730AUe6EwHeFDa6x3+FLDOnRZ5CGVfVLgqTJuD/QYTB8AIqGJScTAQWT+sAIjitlMjakr
	7dNaei7NgwCl+QE05vFhhJJ4w/5YslFgGrtpkuO+rHtpweHx5jfhm0aglpXWSmKI7oAtkfw5XPu/d
	YhyXAKGw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wtj62-0000000EU1Q-46LC;
	Tue, 11 Aug 2026 09:48:39 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wtj5z-00000000PjA-2UWe;
	Tue, 11 Aug 2026 10:48:31 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: dwmw@amazon.co.uk,
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
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/11] KVM: x86/xen: Rename 'longmode' to 'is_64bit' in hypercall handling
Date: Tue, 11 Aug 2026 10:37:03 +0100
Message-ID: <20260811094829.98794-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811094829.98794-1-dwmw2@infradead.org>
References: <20260811094829.98794-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

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
index f2c6757fc1fa..09f4e154e6b8 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1469,7 +1469,7 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
 	return ret;
 }
 
-static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool longmode,
+static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool is_64bit,
 				 u64 param, u64 *r)
 {
 	struct sched_poll sched_poll;
@@ -1481,7 +1481,7 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool longmode,
 	    !(vcpu->kvm->arch.xen.hvm_config.flags & KVM_XEN_HVM_CONFIG_EVTCHN_SEND))
 		return false;
 
-	if (IS_ENABLED(CONFIG_64BIT) && !longmode) {
+	if (IS_ENABLED(CONFIG_64BIT) && !is_64bit) {
 		struct compat_sched_poll sp32;
 
 		/* Sanity check that the compat struct definition is correct */
@@ -1578,12 +1578,12 @@ static void cancel_evtchn_poll(struct timer_list *t)
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
@@ -1602,7 +1602,7 @@ struct compat_vcpu_set_singleshot_timer {
     uint32_t flags;
 } __attribute__((packed));
 
-static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, bool longmode, int cmd,
+static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, bool is_64bit, int cmd,
 				  int vcpu_id, u64 param, u64 *r)
 {
 	struct vcpu_set_singleshot_timer oneshot;
@@ -1646,7 +1646,7 @@ static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, bool longmode, int cmd,
 		BUILD_BUG_ON(sizeof_field(struct compat_vcpu_set_singleshot_timer, flags) !=
 			     sizeof_field(struct vcpu_set_singleshot_timer, flags));
 
-		if (kvm_read_guest_virt(vcpu, param, &oneshot, longmode ? sizeof(oneshot) :
+		if (kvm_read_guest_virt(vcpu, param, &oneshot, is_64bit ? sizeof(oneshot) :
 					sizeof(struct compat_vcpu_set_singleshot_timer), &e)) {
 			*r = -EFAULT;
 			return true;
@@ -1678,7 +1678,7 @@ static bool kvm_xen_hcall_set_timer_op(struct kvm_vcpu *vcpu, uint64_t timeout,
 
 int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 {
-	bool longmode;
+	bool is_64bit;
 	u64 input, params[6], r = -ENOSYS;
 	bool handled = false;
 	u8 cpl;
@@ -1688,8 +1688,8 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 	    kvm_hv_hypercall_enabled(vcpu))
 		return kvm_hv_hypercall(vcpu);
 
-	longmode = is_64_bit_hypercall(vcpu);
-	if (!longmode) {
+	is_64bit = is_64_bit_hypercall(vcpu);
+	if (!is_64bit) {
 		input = kvm_eax_read(vcpu);
 		params[0] = kvm_ebx_read(vcpu);
 		params[1] = kvm_ecx_read(vcpu);
@@ -1735,17 +1735,17 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
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
@@ -1760,7 +1760,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 handle_in_userspace:
 	vcpu->run->exit_reason = KVM_EXIT_XEN;
 	vcpu->run->xen.type = KVM_EXIT_XEN_HCALL;
-	vcpu->run->xen.u.hcall.longmode = longmode;
+	vcpu->run->xen.u.hcall.longmode = is_64bit;
 	vcpu->run->xen.u.hcall.cpl = cpl;
 	vcpu->run->xen.u.hcall.input = input;
 	vcpu->run->xen.u.hcall.params[0] = params[0];

base-commit: 51ba04112e93ac6e04c627eddcea5caf9cbc0134
-- 
2.55.0

