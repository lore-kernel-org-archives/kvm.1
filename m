Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D50369D41;
	Fri,  5 Jun 2026 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669850; cv=none; b=JCyirLDGQwwAm9qqY4UtDGlAyyn2/747TFT2SbhkTAdvDGTrqsr7Jjl/fKIoxEx8lNLiy7azYLMSkr3Bjcfq+EcdoUwHvYNxvP9B4JiuraYF2Mon7GK1R1pwDkAM4knoMEJY+QMTbSGy+kcs/vZijMG6uI01CHHMjsw+oGSQDY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669850; c=relaxed/simple;
	bh=025sW0FGYjyVqoVNeJrYul48aMH/JEhkA5qcWuIYSdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntfRPXyNJnCm7ErSTSUJKaxGOtCA5sBTfkGf9NiUrRtHjwmVWJYBNet/mlsiiW37rAd3lGbFvxZ8CytoK4xUp9xeZONV9SMeM6O4+teVxTZ+Rd+7Yj2XeR3wNS711FnSsoMm2571o6+rbtFqfEQsfHsetsdmb8+S/I2p1CFeAGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LrD3psS4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LrD3psS4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bRR0kvtbCYP0k1nDOdZajZm1rJH8Z50FVxMF+nSNB9A=; b=LrD3psS4m6CmCAoZXQQ7OnSHhe
	9U1qXcqw6ZGFUDnnoROY+VVevitE4keD2+fg16L3wKruNGM8MUVmrRhUpsMkS8VtNSTR6an159NVO
	rOPNE4o44HvDAdxmLwPG3wu5k0F1U8dQigZvACJAzbqxT8RcN8DwgmNIbheJT7gqMVW010mtAK9eF
	6Pxhc4Ba+bpNu1rhgqSBJmFRnXbow5B3jtLBG7WRv29TAyi0nVSTvcn9u7DMf1OebxFH2v8znYw6m
	0LZ8XJSKUj3m4S+pNUupyV6XodQjL1unyKG3/7ThgMlWJgqERAsg+0uf0ZjVqJlkyvBNmftUzTfUC
	QFpawxGg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVVZE-0000000848b-22g7;
	Fri, 05 Jun 2026 14:30:37 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVVZE-0000000013d-1ocO;
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
Subject: [PATCH 5/8] KVM: x86/xen: Latch shinfo mode in kvm_xen_schedop_poll()
Date: Fri,  5 Jun 2026 15:17:30 +0100
Message-ID: <20260605143034.3603-6-dwmw2@infradead.org>
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

kvm_xen_schedop_poll() validates port numbers against
kvm_max_evtchn_port() and then calls wait_pending_event() which reads
the shinfo mode again to select the bitmap layout.

Latch kvm_xen_has_64bit_shinfo() once and pass it to both
max_evtchn_port() and wait_pending_event().

As with the previous fix to kvm_xen_set_evtchn_fast(), this is
harmless in practice for the same reasons: the inconsistency can only
corrupt fields in the guest's own shared_info page, and the same
corruption can occur anyway if the mode changes immediately after the
latch.

Fixes: d518b9d0fc80 ("KVM: x86/xen: handle PV spinlocks slowpath")
Assisted-by: Kiro:claude-opus-4.6-1m
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 60bdf65216c2..f9085612e7df 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1435,8 +1435,8 @@ static inline int kvm_max_evtchn_port(struct kvm *kvm)
 	return max_evtchn_port(kvm_xen_has_64bit_shinfo(kvm));
 }
 
-static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
-			       evtchn_port_t *ports)
+static bool wait_pending_event(struct kvm_vcpu *vcpu, bool has_64bit_shinfo,
+			       int nr_ports, evtchn_port_t *ports)
 {
 	struct kvm *kvm = vcpu->kvm;
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
@@ -1451,7 +1451,7 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
 		goto out_rcu;
 
 	ret = false;
-	if (kvm_xen_has_64bit_shinfo(kvm)) {
+	if (has_64bit_shinfo) {
 		struct shared_info *shinfo = gpc->khva;
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 	} else {
@@ -1476,6 +1476,7 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
 static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool is_64bit,
 				 u64 param, u64 *r)
 {
+	bool has_64bit_shinfo = kvm_xen_has_64bit_shinfo(vcpu->kvm);
 	struct sched_poll sched_poll;
 	evtchn_port_t port, *ports;
 	struct x86_exception e;
@@ -1534,7 +1535,7 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool is_64bit,
 	}
 
 	for (i = 0; i < sched_poll.nr_ports; i++) {
-		if (ports[i] >= kvm_max_evtchn_port(vcpu->kvm)) {
+		if (ports[i] >= max_evtchn_port(has_64bit_shinfo)) {
 			*r = -EINVAL;
 			goto out;
 		}
@@ -1547,7 +1548,7 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool is_64bit,
 
 	set_bit(vcpu->vcpu_idx, vcpu->kvm->arch.xen.poll_mask);
 
-	if (!wait_pending_event(vcpu, sched_poll.nr_ports, ports)) {
+	if (!wait_pending_event(vcpu, has_64bit_shinfo, sched_poll.nr_ports, ports)) {
 		kvm_set_mp_state(vcpu, KVM_MP_STATE_HALTED);
 
 		if (sched_poll.timeout)
-- 
2.54.0

