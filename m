Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562582;
	b=uqrvYlp0AiXzIyS6x2s1912CJJKVmRJYHe+KwimRn/Cxf4UDa46L0l/wI8m7yANI/EXE
	 aJQ8f4BFn6iVOgXg8Y0BirnPWx2POCmQOHdAH364Q3khGt6ils/sPHF4tFJaMcczULiB3
	 2DyyLySoixR1iS1ZyAJ7noMvwGmSsOHAt9+fPQS4x6BiOFMO5aigro6tB7fkplivqczqB
	 wo7H6oKdbq15a1flP9rm+pmlUN8WSq6CR2PxXZKAGX3zVzb0hohPLLA6wo4AG+96/+GIZ
	 FS2CE6K/WC77rlSh/yCnFrr0KYOEJzpu6bAfe8hQz6swR3DOzft0r1G2PPDhLrgqyrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562582;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=fWZq+phibeUOAuCvTbIBUu8IYuUINRpE+QvToHPSryc=;
	b=InHOZf9QOXjt07BZuWt/VtvoYh1kKJzVUl8A+89mxFVj+GLqjuhOEd5Re1bPlR1+PHqs
	 2oEsCGaoI/CiexKe/zk1SWhucayp+T2cwDaMhWL8Vj/Pm9fp9IO/sYCryVcy7HE427Xgd
	 vU0pfGz55K61HeSVCj1yHeJNNfeHZT/MPGu620Q2biz8l0F5H3sgXg4E3wffXg6ZI4vMb
	 YD9mpyFvIqh4kz104i6g6iGBY+1u6vT6JtC5fC41CVuzgz/lRz6EM7LsuQRLDKUV7eCa/
	 0tqpCrUMgLaGJbu7lXgu8vuWrlZO+iUKa/rglaG+SSuTK18fRjPT1Xxs8XHHhRitYPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=olyREV0E;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C09606A693
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5C09606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=olyREV0E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fWZq+phibeUOAuCvTbIBUu8IYuUINRpE+QvToHPSryc=; b=olyREV0EM42s4OFSemiYPWrcmz
	nBl210NlEyXbsalTjLv/ZvSjQ9oY6zkhValMnTsqQ57gRPeEio/58Q3hOhBCPMob+Ion6pw7xgJDX
	HcGSqj1ow9xIy5yr4tWm4q9ItKtX5H7M8llT6LGfUdJX3mR//BoqU81QK0bHhbkPMNSVXF9rfMIaG
	HdFkc48goyA5+2S3JgsCi50vIQ/p4fRKaAIQelLGINLO1R5jKF3KUzxL4OojCMpxds+y8sevGkGQI
	GMFVYtm8Fko+PMVNXTHT3lu5luX7EWk/CmgqJKOl12szWx3+LN3wJdND7tlcIQlgFqnNFEjhCwPg2
	wxlQ/xIQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqc-00000004eUz-1kfl;
	Tue, 24 Nov 2026 23:22:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-0000000061t-1D5p;
	Tue, 24 Nov 2026 23:22:47 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
	kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paul Durrant <paul@xen.org>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Anthony PERARD <anthony@xenproject.org>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Hui Peng <benquike@gmail.com>,
	Mark Syms <mark.syms@citrix.com>,
	Feifan Qian <bea1e@proton.me>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v1 02/21] i386/xen: Don't resample GSI when per-vCPU upcall vector is in use
Date: Tue, 24 Nov 2026 23:22:28 +0000
Message-ID: <20261124232247.23169-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232247.23169-1-dwmw2@infradead.org>
References: <20261124232247.23169-1-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The callback_via GSI (or PCI INTx) and the per-vCPU upcall vector are
mutually exclusive delivery mechanisms for Xen event channel upcalls.
Xen itself will never assert the callback GSI for a vCPU which has a
per-vCPU upcall vector configured.

When the interrupt is acked, QEMU's resampling logic reasserts the
GSI if evtchn_upcall_pending is still set. If the guest has configured
a per-vCPU upcall vector, events are delivered through that vector and
the GSI is unexpected; a guest which receives both the vector upcall
and a spurious GSI interrupt for the same event can crash. This was
observed in production with Windows guests on a different VMM which
implements the same resampling logic.

If a per-vCPU upcall vector is configured, don't resample the GSI;
just deassert it.

Fixes: ddf0fd9ae1fd ("hw/xen: Support HVM_PARAM_CALLBACK_TYPE_GSI callback")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 target/i386/kvm/xen-emu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index 29364a92797..7337561b159 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -435,6 +435,13 @@ void kvm_xen_maybe_deassert_callback(CPUState *cs)
         return;
     }
 
+    if (env->xen_vcpu_callback_vector) {
+        BQL_LOCK_GUARD();
+        env->xen_callback_asserted = false;
+        xen_evtchn_set_callback_level(0);
+        return;
+    }
+
     /* If the evtchn_upcall_pending flag is cleared, turn the GSI off. */
     if (!vi->evtchn_upcall_pending) {
         bql_lock();
-- 
2.43.0

