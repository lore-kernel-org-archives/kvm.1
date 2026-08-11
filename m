Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B3D438FF3;
	Tue, 11 Aug 2026 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443355; cv=none; b=pdAcUQnGbj4m5XS5dAPFOiIbyN5vJ7Nd7XEe3PDVMe6qJAPCtjSl1wror4RwDwMWBWG05afFW4kRtUo9DvwoeKGYvidgrHryHLQU+h1ExBLbWaImjH5CMheM/ob/nrjOsmpR1I4aE034KiWh42VqaUBp2CTLfMBl7u742WB3iiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443355; c=relaxed/simple;
	bh=DGWjPLJhKAHD+YP8/zJi5RapzCJoPLj8jy1KcsBwfEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YL00dM8byAfQZjchSJT/GE/pQPaynvSfxFHVOQuPAmcD6IOLObqp1/ZNePdt3gOaZTo2RMh45Qb/xwYQ1vVLN1lNRWioSPikgUkUbTD1YD006tYuI1J2vHO6JQFXPi8n4Q8O3QALrQtf3b7WFJ9atb0S83uagY2i+oCt8E5H/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C+aahvhe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C+aahvhe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=wAdCPHnQoZ+4/m9bjBDY7pqq+MSFVECL1AbZ2EiP2MU=; b=C+aahvheYFVHjTu7GEj16sv1ge
	MSESyGTe4gl30BuNbk14UbHv0jba6BfBLiBzP745iKsaE9j9vhNY6oEh4OUyI4IiVM77/P8ktHkXb
	RsNdPb2oiHU46hNpqPaX8ZXt6zPeMBvPZwqoryTQGlEuvciH85XJES/e6DTHru4+Cr4kj9QEQ19eE
	a1DoLyFkiaSuQ9ElpytMHY5pIfOREi4y+9C0sn0Xtb0DsZC3SXFK04FMoknh8NF5FOCq9W5ryRu2h
	FMcjWjs0nZjgrC3BPrLyLFwftIgiW/c2ribW1BT6C+AdwozFmVZxj/GNjyY6+pg24LAD306htQkdz
	CpOUeHqg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtj60-0000000GFnS-1Tir;
	Tue, 11 Aug 2026 09:48:42 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wtj5z-00000000PjJ-36AO;
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
Subject: [PATCH v2 04/11] KVM: x86/xen: Latch shinfo mode in kvm_xen_set_evtchn_fast()
Date: Tue, 11 Aug 2026 10:37:06 +0100
Message-ID: <20260811094829.98794-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811094829.98794-1-dwmw2@infradead.org>
References: <20260811094829.98794-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: Hyunwoo Kim <imv4bel@gmail.com>

kvm_xen_set_evtchn_fast() assumes the port range check in
max_evtchn_port() and the bitmap layout selection observe the same
shinfo mode, but each calls kvm_xen_has_64bit_shinfo() separately.
If the guest changes the mode in between, a port accepted by the
64-bit range check is handled with the 32-bit layout, and
port_word_bit falls outside evtchn_pending_sel.

Latch kvm_xen_has_64bit_shinfo() once on entry so the range check
and both layout computations use the same value.

In practice this is harmless: the evtchn_pending bitmap is at the same
offset in both native and compat shared_info layouts, so a stale mode
just results in setting a bit in what the guest (in its new compat mode)
considers the evtchn_mask, wallclock, or the arch_shared_info fields
which follow it — all of which are in the guest's own page. Even with
this fix, the same corruption can occur if 64-bit mode is latched and
the guest switches to 32-bit mode immediately afterward. Like Xen, KVM
makes no attempt to *convert* when shinfo mode is changed. Only the
wallclock field is updated in the new location.

This fix is for internal consistency rather than correcting any
observable bug.

Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and event channel delivery")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Closes: https://lore.kernel.org/all/aiHPPUk5DY7rH-zL@v4bel/
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
[dwmw2: Rework on top of long_mode/has_64bit_shinfo cleanups]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 00894afea9be..9edfdc585337 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1423,14 +1423,19 @@ static int kvm_xen_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
 	return kvm_xen_hypercall_set_result(vcpu, run->xen.u.hcall.result);
 }
 
-static inline int kvm_max_evtchn_port(struct kvm *kvm)
+static inline int max_evtchn_port(bool has_64bit_shinfo)
 {
-	if (kvm_xen_has_64bit_shinfo(kvm))
+	if (has_64bit_shinfo)
 		return EVTCHN_2L_NR_CHANNELS;
 	else
 		return COMPAT_EVTCHN_2L_NR_CHANNELS;
 }
 
+static inline int kvm_max_evtchn_port(struct kvm *kvm)
+{
+	return max_evtchn_port(kvm_xen_has_64bit_shinfo(kvm));
+}
+
 static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
 			       evtchn_port_t *ports)
 {
@@ -1800,8 +1805,9 @@ static void kvm_xen_check_poller(struct kvm_vcpu *vcpu, int port)
 int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 {
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
-	struct kvm_vcpu *vcpu;
+	bool has_64bit_shinfo = kvm_xen_has_64bit_shinfo(kvm);
 	unsigned long *pending_bits, *mask_bits;
+	struct kvm_vcpu *vcpu;
 	unsigned long flags;
 	int port_word_bit;
 	bool kick_vcpu = false;
@@ -1817,7 +1823,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		WRITE_ONCE(xe->vcpu_idx, vcpu->vcpu_idx);
 	}
 
-	if (xe->port >= kvm_max_evtchn_port(kvm))
+	if (xe->port >= max_evtchn_port(has_64bit_shinfo))
 		return -EINVAL;
 
 	rc = -EWOULDBLOCK;
@@ -1828,7 +1834,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	if (!kvm_gpc_check(gpc, PAGE_SIZE))
 		goto out_rcu;
 
-	if (kvm_xen_has_64bit_shinfo(kvm)) {
+	if (has_64bit_shinfo) {
 		struct shared_info *shinfo = gpc->khva;
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
@@ -1869,7 +1875,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 			goto out_rcu;
 		}
 
-		if (kvm_xen_has_64bit_shinfo(kvm)) {
+		if (has_64bit_shinfo) {
 			struct vcpu_info *vcpu_info = gpc->khva;
 			if (!test_and_set_bit(port_word_bit, &vcpu_info->evtchn_pending_sel)) {
 				WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
-- 
2.55.0

