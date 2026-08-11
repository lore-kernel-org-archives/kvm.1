Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500F443CED2;
	Tue, 11 Aug 2026 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445407; cv=none; b=UE4AwhShA55DPvtV5vbMnPXNyhqcXxEIweDzA8ToyA5X0VAScIywviK7kCCOWp14E/w7/YRicSKV9xXYxz/YPCFzYm/MQvn89HQMacypxBOnUL8VJmusHR6IeUgsfttM9qVPQFqDC37BxZf723mqSUVwyvbQIGAm6YylUXXbH1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445407; c=relaxed/simple;
	bh=gWgiawnQhvZW4FThCZKdr1cLrYD9u3vLWQKotfB1p0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ca40n4+l06sI9hOHxSFiUWABUHr+uAyHCtQWv010/NgI8+nL2+6dvAwRoMeCfJYfMTEsbVIYiE8PSWKyIYhlqeVOX8yHR49pIM1wii/3w2QmvmzaxJhRzlSmi9Fmi6OG7cJwA8NBUOgff2SxU2EfBs8W6NEP8aHp/SBJ7ViYo1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=evxAVjhz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="evxAVjhz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pyEs/Jnqe1H9I/J/i4iGoSnt+geI+86GQFWBwGlivrE=; b=evxAVjhzs7iFz/n9q9EaNxJ4S2
	Rq0DccOXTTP/yf2jBRMHxX1HXjeT711NBzZHcV6G356n47OxrdZiIp55b5wbqEdSbOGMLfTsn2AnC
	BbPuCk7loHV/nP++FYHXd4hBxCDyoPk7465TKSb5kMgCpX8A7jtsZz/DjETGoZnYIBF4hD3mEEa7n
	eQnrV/d1gHRigM0cS4YM+5XDNQwfvyBibwznDkn8IKKcIItq/9lTr8qk8zuDyJ+8qqWAUlyhEWuL9
	o9/jAfkvZ0vaVBcfVRAFhBcsZdKl1iI6BNgIFOrEHpcn9BL8CebKxxEnINRiXCuZiOC9usHnYqyuL
	P/TQtuBg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtj60-0000000GFnV-1SlO;
	Tue, 11 Aug 2026 09:48:41 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wtj5z-00000000PjM-3GOW;
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
Subject: [PATCH v2 05/11] KVM: x86/xen: Latch shinfo mode in kvm_xen_schedop_poll()
Date: Tue, 11 Aug 2026 10:37:07 +0100
Message-ID: <20260811094829.98794-6-dwmw2@infradead.org>
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
index 9edfdc585337..e249a1b1d446 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1436,8 +1436,8 @@ static inline int kvm_max_evtchn_port(struct kvm *kvm)
 	return max_evtchn_port(kvm_xen_has_64bit_shinfo(kvm));
 }
 
-static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
-			       evtchn_port_t *ports)
+static bool wait_pending_event(struct kvm_vcpu *vcpu, bool has_64bit_shinfo,
+			       int nr_ports, evtchn_port_t *ports)
 {
 	struct kvm *kvm = vcpu->kvm;
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
@@ -1452,7 +1452,7 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
 		goto out_rcu;
 
 	ret = false;
-	if (kvm_xen_has_64bit_shinfo(kvm)) {
+	if (has_64bit_shinfo) {
 		struct shared_info *shinfo = gpc->khva;
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 	} else {
@@ -1477,6 +1477,7 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
 static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool is_64bit,
 				 u64 param, u64 *r)
 {
+	bool has_64bit_shinfo = kvm_xen_has_64bit_shinfo(vcpu->kvm);
 	struct sched_poll sched_poll;
 	evtchn_port_t port, *ports;
 	struct x86_exception e;
@@ -1535,7 +1536,7 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool is_64bit,
 	}
 
 	for (i = 0; i < sched_poll.nr_ports; i++) {
-		if (ports[i] >= kvm_max_evtchn_port(vcpu->kvm)) {
+		if (ports[i] >= max_evtchn_port(has_64bit_shinfo)) {
 			*r = -EINVAL;
 			goto out;
 		}
@@ -1548,7 +1549,7 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool is_64bit,
 
 	set_bit(vcpu->vcpu_idx, vcpu->kvm->arch.xen.poll_mask);
 
-	if (!wait_pending_event(vcpu, sched_poll.nr_ports, ports)) {
+	if (!wait_pending_event(vcpu, has_64bit_shinfo, sched_poll.nr_ports, ports)) {
 		kvm_set_mp_state(vcpu, KVM_MP_STATE_HALTED);
 
 		if (sched_poll.timeout)
-- 
2.55.0

