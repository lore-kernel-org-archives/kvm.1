Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D7A3A8388;
	Mon, 31 Aug 2026 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212238; cv=none; b=SJtqGUX5kXGyAu6Pgin2t6xRSo83zJHd0m/xVP0F7iNmnmB2/AiqvHwLqoeAn3tgCfoto08jVHoRAcB3vB2V11h+xA+m3/wE/bjSfNQCZNsnRmfqeL/ohkQySpty6Ou+sjAsUQX+gHBnwaktduZ8hKjsa8wz+quOBk60vIa1qVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212238; c=relaxed/simple;
	bh=H1SqcqpeOWKrv+XinTa3nvxDbyg9Po04MbvXYTArImE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIp0/U882sM4LD1Tv6YToPYfEmDTBt3uydD2D/adriRphjvMghn8agcEGyB4+oqsnlGa0j3DidZK+O+3V4yMUk0GCbMVVZ2Gqk65FdpSMH+IwzqLHwnQcm7kh3qFf7heYFn/4dHkQzSaqXyRw6w7H+eCBMNjpa9FtaqD0PaNttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TdMNvr18; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TdMNvr18"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=sZARku0DAHAEeEqj74AhfKgzx9LE9+6uh8lQto7IUNM=; b=TdMNvr18M57DP6Acu2PGWK0tBF
	JD1jtGD1t2oIe00ZU03XP9PJ/2ZtHQCCr8WnOO8yMJiVsfJosFZ2rhGECp9YZ43QhqMDs62Q0bdb7
	ZcyOaCMltz65F/794rxAPvW057AGE3Bq2+veBKX2nxEKI1sXQ9eGQfzeM4neW+zLctKb8SFrDDilj
	R3SkY/ql+38gcXr89C79BJ8UkwkMgEpz3fzGz/aw/ZHXFSaoSRbSZ/3uaq8v6Y8C/dH5/TVc2GiGi
	ZrgYba4+xv3hvnDeOjNTBB6HzwIU14BiTuvQu0jYPVU2VndanPuNrFfHDG/b0Q5k9M+FbVACTL772
	owB0D82w==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x19gG-0000000AKc8-32Bo;
	Mon, 31 Aug 2026 21:36:41 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x19gE-00000000LCq-0QNS;
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
Subject: [PATCH v3 04/13] KVM: x86/xen: Latch shinfo mode in kvm_xen_set_evtchn_fast()
Date: Mon, 31 Aug 2026 22:26:35 +0100
Message-ID: <20260831213632.81023-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831213632.81023-1-dwmw2@infradead.org>
References: <20260831213632.81023-1-dwmw2@infradead.org>
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
Closes: https://lore.kernel.org/all/aiHPPUk5DY7rH-zL@v4bel/
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
[dwmw2: Rework on top of long_mode/has_64bit_shinfo cleanups]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index be3c4dbee435..a528fdbf1b94 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1439,14 +1439,19 @@ static int kvm_xen_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
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
@@ -1816,8 +1821,9 @@ static void kvm_xen_check_poller(struct kvm_vcpu *vcpu, int port)
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
@@ -1833,7 +1839,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		WRITE_ONCE(xe->vcpu_idx, vcpu->vcpu_idx);
 	}
 
-	if (xe->port >= kvm_max_evtchn_port(kvm))
+	if (xe->port >= max_evtchn_port(has_64bit_shinfo))
 		return -EINVAL;
 
 	rc = -EWOULDBLOCK;
@@ -1844,7 +1850,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	if (!kvm_gpc_check(gpc, PAGE_SIZE))
 		goto out_rcu;
 
-	if (kvm_xen_has_64bit_shinfo(kvm)) {
+	if (has_64bit_shinfo) {
 		struct shared_info *shinfo = gpc->khva;
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
@@ -1885,7 +1891,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 			goto out_rcu;
 		}
 
-		if (kvm_xen_has_64bit_shinfo(kvm)) {
+		if (has_64bit_shinfo) {
 			struct vcpu_info *vcpu_info = gpc->khva;
 			if (!test_and_set_bit(port_word_bit, &vcpu_info->evtchn_pending_sel)) {
 				WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
-- 
2.55.0

