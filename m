Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A43A7597;
	Mon, 31 Aug 2026 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212237; cv=none; b=Ji0DjkYPB0w0VLKWxcBhlEHk7Vww1Aw+x055Bg+4A74FUmDXnINiVi2n2pdaYKmQ8oYKwq9TqgZjAQAr72kbhVF8bCSXQ/GS+TIi+CfsI2mgcHABiDKxrbGTYY5zgPJwRqsJYDxfuFaxVzHcgPs9zNKukkHbpzN472G9i8o5lUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212237; c=relaxed/simple;
	bh=KKqRKdmd58EkLfgtjVmlvPoRaggSqSe+NQ2QDTFZcbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/Y5CCldwxqawEvnihRjQL4iNHh53Qk6xB+14MlEfGlibH6sOpY6gJIBIGH/9ZIXyjiKhJWifA+qWPkN6liufNiBRnRohA1slAPOLkRUthksBX7AIrlXHTCD9KfkqROE9vsv7VvN5zWvKQN66fz6AKkEjNKrpEyd+VWCcOWoJAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rht/s6V4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rht/s6V4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yQ1Q5gkYyftokVIZKCHSOmJ2q7pgQ/Q1NoKezDC29Sk=; b=Rht/s6V4rlJ10Mfjra/dJbfEcM
	lHUt1DNloiga06X9KUydbsqmqeZff4Gaa8Sw0QXfFXtXoFtPkvHj5mABbCiFqbsv/nCeps8fFi6sk
	ogIqcZyH6R+BdmaYwdfIMUqbRyucdNDAqT2J1NeB06wJW4SX9661+R1LG2Ulgj81gJmTW0Z2pKfBz
	+cStLEDtG5ltt2xqjc/hy1utWxncBfylafuvMgKvLPyygx/rYCq1YsX54C5GV1Bpct7bHNL4z4HDY
	WOq6TUl/SReAxK4vuHzCXhaS6RSREVfnDawjanoA/yPVFaxrLsgfIjGYQvxL4cKO6TJDpm9m5ZcIB
	m9UYvXBA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x19gE-00000003sv7-2j7L;
	Mon, 31 Aug 2026 21:36:38 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x19gE-00000000LDB-1mf0;
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
Subject: [PATCH v3 09/13] KVM: x86/xen: Use atomic*() APIs instead of open coded equivalents
Date: Mon, 31 Aug 2026 22:26:40 +0100
Message-ID: <20260831213632.81023-10-dwmw2@infradead.org>
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

From: Sean Christopherson <seanjc@google.com>

Replace the open coded atomic asm blobs in the Xen event injection code
with equivalent atomic{,64}_xxx() operations.  Casting the event channel
to atomic types is ugly, but not as ugly as asm blobs.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index b0fa74f2cbee..f8730ee48ab8 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -678,12 +678,12 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 	/* Now gpc->khva is a valid kernel address for the vcpu_info */
 	if (kvm_xen_has_64bit_shinfo(v->kvm)) {
 		struct vcpu_info *vi = gpc->khva;
+		void *vi_pending_sel = &vi->evtchn_pending_sel;
 
-		if (IS_ALIGNED((unsigned long)&vi->evtchn_pending_sel, sizeof(u64)))
-			asm volatile(LOCK_PREFIX "orq %[src], %[dst]\n"
-				     : [dst] "+m" (vi->evtchn_pending_sel)
-				     : [src] "r" (evtchn_pending_sel));
-		else
+		if (IS_ALIGNED((unsigned long)vi_pending_sel, sizeof(u64))) {
+			atomic64_or(evtchn_pending_sel, vi_pending_sel);
+		} else {
+			atomic_or(evtchn_pending_sel, vi_pending_sel);
 			/*
 			 * The cast keeps the shift well-defined on 32-bit,
 			 * where evtchn_pending_sel is 32 bits wide and this
@@ -691,28 +691,17 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 			 * kvm_xen_has_64bit_shinfo(), which is gated on
 			 * IS_ENABLED(CONFIG_64BIT)).
 			 */
-			asm volatile(LOCK_PREFIX "orl %[src_lo], %[dst_lo]\n"
-				     LOCK_PREFIX "orl %[src_hi], %[dst_hi]\n"
-				     : [dst_lo] "+m" (vi->evtchn_pending_sel),
-				       [dst_hi] "+m" (*(((u32 *)&vi->evtchn_pending_sel) + 1))
-				     : [src_lo] "r" ((u32)evtchn_pending_sel),
-				       [src_hi] "r" ((u32)((u64)evtchn_pending_sel >> 32)));
-
-		asm volatile(LOCK_PREFIX "andq %1, %0\n"
-			     : "+m" (v->arch.xen.evtchn_pending_sel)
-			     : "r" (~evtchn_pending_sel));
+			atomic_or((u64)evtchn_pending_sel >> 32,
+				  vi_pending_sel + 4);
+		}
+
+		atomic64_andnot(evtchn_pending_sel, (void *)&v->arch.xen.evtchn_pending_sel);
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	} else {
-		u32 evtchn_pending_sel32 = evtchn_pending_sel;
 		struct compat_vcpu_info *vi = gpc->khva;
 
-		asm volatile(LOCK_PREFIX "orl %0, %1\n"
-			     "notl %0\n"
-			     LOCK_PREFIX "andl %0, %2\n"
-			     : "=r" (evtchn_pending_sel32),
-			       "+m" (vi->evtchn_pending_sel),
-			       "+m" (v->arch.xen.evtchn_pending_sel)
-			     : "0" (evtchn_pending_sel32));
+		atomic_or(evtchn_pending_sel, (void *)&vi->evtchn_pending_sel);
+		atomic_andnot(evtchn_pending_sel, (void *)&v->arch.xen.evtchn_pending_sel);
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	}
 
-- 
2.55.0

