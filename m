Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B4D3B6346;
	Tue, 11 Aug 2026 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445366; cv=none; b=Q7PZJeEruTLxlcj6icPm+aGGVwqHo3iMzwTGfikQCLTwmFTLWbxWX9aV7IDF6rYOSjBi8PqOCA/V2WhmRaovtgfiJVyhQFyJ+nsUWI2V3UF1G90Vm6BAv9uA5YwqkZkQXMEVr6QoPdeBHlY713P0dnBYrwlXorPXaAn3UPl0UDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445366; c=relaxed/simple;
	bh=evDEYwD58eyvKVLHqE1JJJ6/5uvAVj1N5ZGj6tckCa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWzXtl69HZZrMwwyNpMAr3RJgRuOAOsMLv7cDlRMyMS1QARrAaZ0sKzBGuh66cNfr4AShWNZEwvNLSBSqJQB6DKToCmyNci+tmxSctzXTBIGvanQwZB78eSt2sYb5hoHe1IyZHX3rz/Jt2qeF0tAk2Pqwk1M02a4hHjbqPuMGEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sot7r9LV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sot7r9LV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Na/xhM+hWzJxsY5YVXVAzR7+i+b3B1RRwiuknTe5IXU=; b=sot7r9LV02XVQeTQ2XoyCbNBUT
	QIKxk6rsCmbMnbzlTZI6OVd9vvzthHMEeRhWD6RSlRr3riblYr6nl47/At9Ql2oT/oAaHfVXCJJAf
	BrQyGUy7+036CC0yOio/vHPn3Zx2xyE1IcGp9bjTTmu93W0iU8uxlYXti6Bvc2qmGd9vCmrLlt4w7
	X+idAr5ZVNK91Srlh4Ry+ptu/qeu0+esB6RtG9qTrPhJDXFtUhYwNl4+0uXDxu4/PpQ4KctQnKe6J
	gds6G7WzPh+yp5oSHRvhDr+G4d0P4H+zKP3S3LLLPSrd9GVLo6C/rUTkh8yNWCAmxguHhHXUj9g5z
	ypc42oPA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtj60-0000000GFnW-1SdB;
	Tue, 11 Aug 2026 09:48:40 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wtj5z-00000000PjY-40Go;
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
Subject: [PATCH v2 09/11] KVM: x86/xen: Use atomic*() APIs instead of open coded equivalents
Date: Tue, 11 Aug 2026 10:37:11 +0100
Message-ID: <20260811094829.98794-10-dwmw2@infradead.org>
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
index 419b07fdaa3a..99f3ffa64fdb 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -662,12 +662,12 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
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
@@ -675,28 +675,17 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
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

