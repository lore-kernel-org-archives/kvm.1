Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6653B2D0D;
	Fri,  5 Jun 2026 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669849; cv=none; b=CFUKk325Vm3U1E+HG5wk7Lmaawc30+9REk+8uCP5U7RPj9q5HQEnZteKc42Drnc8TE3QoSvGNeIq9r/YGHS7KnLiCFJobnqaAij1k6S74MXO3qAAT3NgHTKfKsbq7GT870BdS2alYOa8JDqpQbPLAEIpt21A17MEORmC5I+H+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669849; c=relaxed/simple;
	bh=AuIY14KqiA9W3u1TFh2kocuQhHEOHteA96oXska4omM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvAK1nrSDiG157fAXsOGxmtHsNXFY9xtI6XDtl0Cfg0ldllC2cxJueusmxQPif0+mVwGXOviYR8iFTn8MhTgwuDiX+5REbBTEJCGCRL0Am6psRLQCjrByYmO3L3deZ7x1gf/6KNZDvSu32Rh+JAAS9spl9gBBrfGKx10u++RHs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ur83SHeg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ur83SHeg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HMHMnLtmFEnlXHeN04ELPbsc86c69hiUTB5mzlEYiuA=; b=Ur83SHegAnHFOaSy89pWD1Xt2w
	CMsOW06tEiYKjfo0l8xt/2WpVccZ2WJ0Q80LWIq/Tqq4YjvimVmv+Q4RmB1kqbHNlBzEVcOnaW127
	YGhjHxkIwWluaZ9Ch15O/xKR9D6hgzNDmi9UiOahJWHd79Z9thavcuRbW8ng6QZBWuThPJx5zcbOr
	90zALbdLsB0hUwo98dq7JxaSORyV47vOP4qdT6Flq9YXomBpAhUfMdRpRutu++1Tx2va7V2WVUgJ/
	prI/KLZq025wCnd7vCl/OI/h7vSFAApysvsgH8HTGlp9TNLD2FMN6rq6Yntru2nk+dxZI1zsyNQDy
	JlcDaXnA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVVZE-0000000848c-26Pw;
	Fri, 05 Jun 2026 14:30:37 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVVZE-0000000013P-0z7g;
	Fri, 05 Jun 2026 15:30:36 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paul Durrant <paul@xen.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] KVM: x86/xen: Rename 'longmode' to 'is_64bit' in hypercall handling
Date: Fri,  5 Jun 2026 15:17:26 +0100
Message-ID: <20260605143034.3603-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605143034.3603-1-dwmw2@infradead.org>
References: <20260605143034.3603-1-dwmw2@infradead.org>
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
index 91fd3673c09a..a7ab19f38b59 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1468,7 +1468,7 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
 	return ret;
 }
 
-static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool longmode,
+static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool is_64bit,
 				 u64 param, u64 *r)
 {
 	struct sched_poll sched_poll;
@@ -1480,7 +1480,7 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool longmode,
 	    !(vcpu->kvm->arch.xen.hvm_config.flags & KVM_XEN_HVM_CONFIG_EVTCHN_SEND))
 		return false;
 
-	if (IS_ENABLED(CONFIG_64BIT) && !longmode) {
+	if (IS_ENABLED(CONFIG_64BIT) && !is_64bit) {
 		struct compat_sched_poll sp32;
 
 		/* Sanity check that the compat struct definition is correct */
@@ -1577,12 +1577,12 @@ static void cancel_evtchn_poll(struct timer_list *t)
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
@@ -1601,7 +1601,7 @@ struct compat_vcpu_set_singleshot_timer {
     uint32_t flags;
 } __attribute__((packed));
 
-static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, bool longmode, int cmd,
+static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, bool is_64bit, int cmd,
 				  int vcpu_id, u64 param, u64 *r)
 {
 	struct vcpu_set_singleshot_timer oneshot;
@@ -1633,7 +1633,7 @@ static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, bool longmode, int cmd,
 		BUILD_BUG_ON(sizeof_field(struct compat_vcpu_set_singleshot_timer, flags) !=
 			     sizeof_field(struct vcpu_set_singleshot_timer, flags));
 
-		if (kvm_read_guest_virt(vcpu, param, &oneshot, longmode ? sizeof(oneshot) :
+		if (kvm_read_guest_virt(vcpu, param, &oneshot, is_64bit ? sizeof(oneshot) :
 					sizeof(struct compat_vcpu_set_singleshot_timer), &e)) {
 			*r = -EFAULT;
 			return true;
@@ -1673,7 +1673,7 @@ static bool kvm_xen_hcall_set_timer_op(struct kvm_vcpu *vcpu, uint64_t timeout,
 
 int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 {
-	bool longmode;
+	bool is_64bit;
 	u64 input, params[6], r = -ENOSYS;
 	bool handled = false;
 	u8 cpl;
@@ -1685,8 +1685,8 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 	    kvm_hv_hypercall_enabled(vcpu))
 		return kvm_hv_hypercall(vcpu);
 
-	longmode = is_64_bit_hypercall(vcpu);
-	if (!longmode) {
+	is_64bit = is_64_bit_hypercall(vcpu);
+	if (!is_64bit) {
 		params[0] = (u32)kvm_rbx_read(vcpu);
 		params[1] = (u32)kvm_rcx_read(vcpu);
 		params[2] = (u32)kvm_rdx_read(vcpu);
@@ -1727,17 +1727,17 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
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
@@ -1752,7 +1752,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 handle_in_userspace:
 	vcpu->run->exit_reason = KVM_EXIT_XEN;
 	vcpu->run->xen.type = KVM_EXIT_XEN_HCALL;
-	vcpu->run->xen.u.hcall.longmode = longmode;
+	vcpu->run->xen.u.hcall.longmode = is_64bit;
 	vcpu->run->xen.u.hcall.cpl = cpl;
 	vcpu->run->xen.u.hcall.input = input;
 	vcpu->run->xen.u.hcall.params[0] = params[0];
-- 
2.54.0

