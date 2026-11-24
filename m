Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562582;
	b=ax5HPPvBdWtD8XPtxvmcfvvNEuWpMKQb/Z8NaEzv4YIHFFY7Ej5qV5hmsyo72Rhy6vZE
	 cpBKNYzD1/nZuyWM0v1o5BG/uzvLHqyhmEeJaEEGW88zCMFL6PA/ZkpYs/q1cKq5+Wk2j
	 iQtpCg/225wNKH4/4vtk8L8m1FCA8VBtR0rZ4dgynsZguDUbEUAUaqd+OkSOLV4i9HH3Y
	 m9cU9dNPLMbyhAHZpKZLyP+GMQxVLcIA4gzBBghpTssqdRUnvj8zf208u5gbJwrZ6F8BF
	 LZJlyKij4gTNCmYAuqJ1e+T4aJzzLezkiz8Gyjw7pYBNPjFTiGkiSscKN0myIjIpTQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562582;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=MDCkWo+nHOFblog6Fg5H/nm5g/v+HbobXRCSG92qh9s=;
	b=KzHP/fh4nXVAyC1GSscEDyiMiHTo+uqfR7ybit6ous8QLrzIOeYZ0XW3pm7SddJhaYSc
	 xEjiAzduI2qD/gVdYFpJmPs8mmEq+mCGTgv/5rXx7UbpHkEPgijgY3ikw6O7tj8zKY+P+
	 dC+PrmSftR7S1BpDnEA0bVmIAgohaj5bm95SzT35f/TtCmFfB73IGNgWO8/pQiGJb8JQ+
	 ikBEqSO7iR5LLs0c71Smws4A/VLHIlxJRsywNcRDaPFUmETwjMn8h5O+BlLPdJZpBHxdR
	 VpYEJoZPhknMMtq6pDQ/0+TjUbenzIirmkU784j5vus5qjb8WWx+gPFTRP80eaaw5Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Zq7cPI53;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3905606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3905606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Zq7cPI53
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=MDCkWo+nHOFblog6Fg5H/nm5g/v+HbobXRCSG92qh9s=; b=Zq7cPI53+tBAGo6VNkPs4NDpZ2
	TwiyB2pDIjyTWWTbrV+195ZYzLUaIEKjeK/v0lRKzfM82s0fHTlTz+xSKU8kKOG89uYuhDw2/j/Op
	wOiP/Nc7S6N1ITosEx81Sjr78GWy3NN9p4CyO/OEvh+hD3nXqn9lf6lH+WLYjC2KQpBC8MXltG/0N
	ED+KkdlzSglKlu1LgcuSX1XEwo2BtaXW0O0izBXJUaBjkZK4J7LyXcWczg8h0jbItMmFs0ZE1Hz7f
	gyDJvEvcLyPy7C/gVnnYSmsNlHeNaoU1qAcl597E6U1PhZhgXBle4Su8Bnf8aCvUr99WgRy5dApgM
	bdtC5QVg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqc-00000004eV2-1kzL;
	Tue, 24 Nov 2026 23:22:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-0000000062Q-24a5;
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
Subject: [PATCH v1 10/21] hw/i386/kvm/xen_evtchn: Reuse existing backend port in find_be_port()
Date: Tue, 24 Nov 2026 23:22:36 +0000
Message-ID: <20261124232247.23169-11-dwmw2@infradead.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

After a guest soft reset, close_port() clears only the guest side of an
interdomain port; the backend handle still owns its be_handles[] slot.
Binding again then allocated a fresh slot each time, leaking the old
one — and leaving a dangling entry if the handle is later closed. Reuse
the slot the handle already owns.

Fixes: 794fba23a53a ("hw/xen: Add backend implementation of interdomain event channel support")
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_evtchn.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 7fd8c3f3182..e2803cad0a8 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -2052,6 +2052,16 @@ static int find_be_port(XenEvtchnState *s, struct xenevtchn_handle *xc)
 {
     int i;
 
+    /*
+     * A handle may still own a backend port from before a guest soft reset;
+     * close_port() clears only the guest side. Reuse it rather than leaking
+     * the old slot and allocating a second one.
+     */
+    if (xc->be_port && xc->be_port < EVTCHN_2L_NR_CHANNELS &&
+        s->be_handles[xc->be_port] == xc) {
+        return xc->be_port;
+    }
+
     for (i = 1; i < EVTCHN_2L_NR_CHANNELS; i++) {
         if (!s->be_handles[i]) {
             s->be_handles[i] = xc;
-- 
2.43.0

