Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427102;
	b=SVUuoo/Iyw4+gtoKKLk8BuK2C7sXT4AahdHW0MjNsFoyax8VWoGxC9enXIf0SXcROX8k
	 44B84730O7GBiRqBlmUj+C5+RE1yFvAOXSpKA8CFes9KHE7Hv9fPLjkm4rRZnhTmxJlhO
	 JpBBSYkDEeJUJDC2eoJUpIU+2SpqIomGC6wjkKPTrMrC3YCUMQFywp7n5n+Lod6W6iyMq
	 6eWwqvqWVG51VrJnjaesxCfPnKa8xLLseQ3f+9FL98uOn1Qme6ZgdL95WGlcJAlHJcuQd
	 3OLDdq3S6FBrZdomBlN3YY6q11i/z/vYT261+B/TztJpKCBnVl+fhRIcqc+h5Kd5mvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427102;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=ClGhwyKqY7iwWEkCZXSiNmWOQpf0ARU4x1WgJZbziLM=;
	b=hRr1McrAnNDJs4wPPFZWEtvX92BTS//Qv4nEHqn9SbaDs1t2GoPjzFcJKZYo16FseHdt
	 C1yGQiyNfAvzMgaFrQEGOZb44nhXB8pM3zdTasHjTa7/OukuB+aD6UKxiF9cYBkZi+xLn
	 f4MDEwTvKP50cSiFpag6jxNTUj/h/nW3dgCvJbRjVBoLGKrYdSmf26xXLYDsFXM81ltDL
	 05jvC5H/giZhnuHQVz5SoyJDJVhUWpwKk7933j9eufb4h15eGf8Rfzb88AVjtvRN5uiBa
	 99dPFsYyi2r7kCu0Db3bhN2G6uGrLaxcqL0uJRQan7YMol/+bp/gaK8WLvUjZoZ8MyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB5606A31C;
	Mon, 19 Oct 2026 16:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ECB5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=ClGhwyKqY7iwWEkCZXSiNmWOQpf0ARU4x1WgJZbziLM=; b=rqPGk1ZyqMHVRJ2mLi9534HZ6q
	qoAbnLcPsFHTJ0iqU0QvZKsfebtfUpqERF4auwpDdB2tHMBm/y0tFSLPdb3RphFnFVbt++kl/oDxM
	NFRnaKHDJCG7THzwzKzuXWyJ+t7Hs7+OHpp5aDIrUSXUZs0gPjHXhl9J+L+gqUkWXUAdY3VfVpvXe
	lC34BJFGmF01zniQ3Qhs/8o9U+Os+/H3Gg0OIkhlUtjmGeGKBv7rKJ8AyIMeIv7uCydHmsKoZ3Acx
	9Z0Zck40pS+nkBp1SMA/fjCcLJc/3K7XLAYquGqGji7gjiTBra4OQQqtKRCtDNfzMETObl3WDsT/+
	nFaq1sQg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIqAI-00000009VGR-04z3;
	Mon, 19 Oct 2026 16:24:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIqAH-000000009hF-3Uzn;
	Mon, 19 Oct 2026 17:24:45 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v4 12/12] KVM: selftests: Fix unreachable timer recovery in xen_shinfo_test
Date: Mon, 19 Oct 2026 17:24:43 +0100
Message-ID: <20261019162445.37219-13-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019162445.37219-1-dwmw2@infradead.org>
References: <20261019162445.37219-1-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The final phase of xen_shinfo_test waits for a timer event while a
worker thread repeatedly deactivates and reactivates the shared_info
cache. The guest polls up to 100 times before asking the VMM to re-arm
the timer, documenting the recovery protocol for kernels which drop a
timer event that cannot be delivered.

But the poll has no timeout. If the timer fires while the guest is
already blocked in SCHEDOP_poll and the event is dropped — which is
precisely the case the recovery exists for — nothing ever wakes the
vCPU, the 100-poll loop never advances, and the test hangs with the
SIGALRM watchdog disabled for this phase. The recovery protocol is
only reachable when the drop happens to occur while the guest is
awake.

Give the poll a 10ms timeout, as the TEST_POLL_TIMEOUT phase already
does, so a dropped event leads to the documented re-arm protocol
instead of sleeping forever. The window for the drop is vanishingly
small upstream, but widens dramatically once cache deactivation incurs
a grace-period wait, hanging roughly a third of all runs.

Fixes: a51abbbf2531 ("KVM: selftests: Add tests in xen_shinfo_test to detect lock races")
Assisted-by: LLM
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/x86/xen_shinfo_test.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
index 3b11d0ee253f..729c0ba9ab4e 100644
--- a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
@@ -350,7 +350,14 @@ static void guest_code(void)
 	p = (struct sched_poll) {
 		.ports = ports,
 		.nr_ports = 1,
-		.timeout = 0
+		/*
+		 * The poll must have a timeout: if the timer event is dropped
+		 * while we are already blocked in the poll, nothing else will
+		 * ever wake us, and the recovery protocol below could never
+		 * run. (As with TEST_POLL_TIMEOUT above, KVM treats the
+		 * timeout as relative.)
+		 */
+		.timeout = 10000000,
 	};
 
 wait_for_timer:
-- 
2.43.0

