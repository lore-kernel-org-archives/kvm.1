Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A74236A73;
	Fri,  5 Jun 2026 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669851; cv=none; b=oEogP1QrnxgG7lpaQeS8dH3ElObVy+Y3/W1fA/FVZkrF1DGyce9oaV8WNeWRo/q+qiklBBo9heIoonJYbqPJosP+lhUQtjDF59eMpEpIa4dQCTJ6qN48lzJV60vgptHjSoNQTSzWHWDW0k8pd80SLE0c7gSr2icQSKLi/G889Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669851; c=relaxed/simple;
	bh=h1GHtxQ2LS2GyBG7+ZY/ckD9ZkHuCv1h4k2ZvsUyPMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbqR9v2oUdVSEqNKyWfgG61L2P8KDDZWNGREaRAI23JLkH6ID1IZBpPe+pVX/UmUz6A4GOMoe2LEZHvcbmCvwyMPlnvLHhb4Q+Kl0KWGrJynpY2LXVq9RDQAHuIZK390KfbJ6nJ29kmjQ44TCxY7Ye1+R5NmgYnt35bXgQEQBw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SZahnms7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SZahnms7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=ziIt1x1rqMK84pqdnMq+0P24wyN4pQRHLv2MTtM/nxs=; b=SZahnms7Njc9oh3KqoyBJd0PmX
	aOSBZTwIwgRSieDnTsIlnBe64jEG2xCll+r+rrWKN0OSb1QZBiTZikEDD/AqyEl7kkbxprEvIJQnS
	hDgysIIM/THhTyDwNNn4l9Xl6WxZ0WAJvWj+2fBYJPP95lwt+gYjKmmeKXI4Pv+PicMif9QqnZKe3
	N4GYIMGnb+YWyPOtHPhrhIFhM6nch6mTtExsf9RQETUz5BJjnJNXwz5HzKSrbS5fJeqdPsj70BOBI
	H5A5xbLFwEvmgiC0nWdxijNCKgoyLm2YOv8i8pXaDMq6O2upz7399g/n+CBmE54aC2xAZ9Pp4A3Tc
	FqWn+99A==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVVZG-0000000Fhrm-2HLN;
	Fri, 05 Jun 2026 14:30:38 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVVZE-0000000013a-1ft5;
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
Subject: [PATCH 4/8] KVM: x86/xen: Latch shinfo mode in kvm_xen_set_evtchn_fast()
Date: Fri,  5 Jun 2026 15:17:29 +0100
Message-ID: <20260605143034.3603-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605143034.3603-1-dwmw2@infradead.org>
References: <20260605143034.3603-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

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
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
[dwmw2: Rework on top of long_mode/has_64bit_shinfo cleanups]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 2c432fcfab15..60bdf65216c2 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1422,14 +1422,19 @@ static int kvm_xen_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
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
@@ -1792,8 +1797,9 @@ static void kvm_xen_check_poller(struct kvm_vcpu *vcpu, int port)
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
@@ -1809,7 +1815,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		WRITE_ONCE(xe->vcpu_idx, vcpu->vcpu_idx);
 	}
 
-	if (xe->port >= kvm_max_evtchn_port(kvm))
+	if (xe->port >= max_evtchn_port(has_64bit_shinfo))
 		return -EINVAL;
 
 	rc = -EWOULDBLOCK;
@@ -1820,7 +1826,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	if (!kvm_gpc_check(gpc, PAGE_SIZE))
 		goto out_rcu;
 
-	if (kvm_xen_has_64bit_shinfo(kvm)) {
+	if (has_64bit_shinfo) {
 		struct shared_info *shinfo = gpc->khva;
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
@@ -1861,7 +1867,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 			goto out_rcu;
 		}
 
-		if (kvm_xen_has_64bit_shinfo(kvm)) {
+		if (has_64bit_shinfo) {
 			struct vcpu_info *vcpu_info = gpc->khva;
 			if (!test_and_set_bit(port_word_bit, &vcpu_info->evtchn_pending_sel)) {
 				WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
-- 
2.54.0

