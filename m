Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47BF485CF9;
	Fri, 16 Oct 2026 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162613; cv=none; b=pPe9TsQHdqfOpHTsz0q77Bn9tpJEnBY8MwXyTnbYCIUgV63Fr7PdSNICuG+VTwEKYm1hIFYVC/+eH2uKOrBsXr6qSXyQORUB2YCkwtWpdS97AOsAne54GZl8XNKcYqbcKucR79MHhJpcN9poHLqDWTL6rN8DCftYqz643i3+lug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162613; c=relaxed/simple;
	bh=51lN2+sP0NCduoUbZkvkLXpM2cIIsh/He5h9EK/+jDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7BzQ410tHguiSdecDvqwcnTvnGYQ2tvF9tT1d2ajQ1p0YiIXg2jMa7qZq98OTnrbRfutBSXoEGD+j0w45RutlkZt3bc/ZYvpGmOHVbhyunft/lwMFfPShHeJtvrps/f3Z8jZ18S28ouzy9wicNKiNch37f9cWTu7acpfEdrHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rJcHBGQY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rJcHBGQY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=hOs19fObtan0szeKOzKz6BssF3NYcCFtUFQyxZ/f684=; b=rJcHBGQYNmkOzrpgbrcUneK38D
	Hg5L7uqPrnFmZm9i9mN3yrf0jRWYIAZepKjtJ2vYguabYWEy+Q4VUC+pKKfscTKEkH0LJCNN/17Ok
	oMz2hcpQttCJgZVXPQBUvQRiDkhg2d4aaOzbREOWZDrIdePsKgDl/Its4WpK8rbmU80AFArh806pp
	BIM8ZdbDblnf85RPu+t6Ec1PmWYYi2QRCCyF53oMxj34teyHxNTzP7RJAhITjjztNyWCtegrqUDG+
	aVSjtC3+n2p+PReD3emkP6r7uG0JN0nJiPJVZ711Hpkf5nEdN5Hjw3AxSDXx4wpnsvdHq7b+OoVv/
	PPZpydhA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHjMV-00000004QIu-0xGB;
	Fri, 16 Oct 2026 14:56:47 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHjMU-00000002QjV-4BNI;
	Fri, 16 Oct 2026 15:56:47 +0100
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
Subject: [PATCH v3 11/11] KVM: selftests: Fix unreachable timer recovery in xen_shinfo_test
Date: Fri, 16 Oct 2026 15:56:45 +0100
Message-ID: <20261016145646.579369-12-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016145646.579369-1-dwmw2@infradead.org>
References: <20261016145646.579369-1-dwmw2@infradead.org>
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

