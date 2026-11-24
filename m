Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562582;
	b=3Aj+UfGy5wrVp5gCnLJtfext4TRrxy+GAEr62QwgSKlquFJNpWpEWW1qsEHcYtFdJIoR
	 rxStNuF7XrjS3xHKG373IkdghK6lyq9aMSfF5v++8wbQeY3YFN915k9QeR68K7KsQgytC
	 sFl9QK7th6QQf/PZUDHUCDNPNSessoa4AEb/hh3CMsvFWWu5BhKwF4A8dFlnbuy0ao2+S
	 Leq9hA6S7lA9CeGnPqLMh138oWtU3K9VzXY78u4IBS/dRZpg9m2M+L1wgQPmZG2o3aYiN
	 8G4Yp8fA/yXPcfHyZc29O3tzJfXl9HbbEXh6aBvfm0lanSUnauVDf6AuKhRJmRnPBBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562582;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=hzcboM0ohMmWlISO8riHLJaSzXAdnFAI55ObPeXkb6U=;
	b=Wl8DFOab/VTU1khwJODHUC5PnQ6Y9TKYVUjADcjXoK3eWZ7NbfQk4fWivSWRKk2lV5c6
	 bj5UPPN8lsvpz4YddUGEvzLOox3nBDJxgZWxktzZS21KKK4Bh1tWX/T22vA/DGAgcue2v
	 5VuFXCirIlMOvx+oqA6fRwN3KOSM43toitG9sMXe82QSyOEMWIAwtI57jApMUL9RTllhx
	 +KZuxH+hMu3aFjFCSO7aUJTvdgIA5FWTg9Y8CnANqJpNFWU4ymor8yN22fymtgRXnLACf
	 D8b/1qdPSNdqTS6RrTsI5bL9/CI8J//HTqzsWL+zzMtacHJJ0Ihi3/D4N+FiOJl45gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=WhbF2j+f;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79B4606A69E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 23:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E79B4606A69E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=WhbF2j+f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hzcboM0ohMmWlISO8riHLJaSzXAdnFAI55ObPeXkb6U=; b=WhbF2j+fLNR/zARIW1zGydVvN2
	/HzwKcdAx1+okK2juHfpid4TxC+8CtK36eJS9NKfzJvIzW0hUXqa1rdwjO9szuwcqSPoLExAlBVpo
	mDhswuUYwQ66qfwFE8QHrKOLsFPACPGdirUvEziVxZWVw7IFifTnLlYY+aG4oBSyiCEw6RWiX+XEx
	9lOOcYbykbbwdZYQfvO5LJ1XhHwK7Y1XoNQxh0/WNxvD4TnVCofUSY/xV2GS0XryNyGBUnxyTA1d0
	gXvOW90ENXXl/Wwf9b2J8wsHsI/R9TOP/nneCdtr9N/crar/VoiymUACDjejI/N3detNVjiLtEXOx
	Hn0feDQw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVzqc-00000004eV1-1qbP;
	Tue, 24 Nov 2026 23:22:57 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xVzqZ-0000000062M-1y4D;
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
Subject: [PATCH v1 09/21] i386/xen: Don't inject event on invalid port in qmp_xen_event_inject()
Date: Tue, 24 Nov 2026 23:22:35 +0000
Message-ID: <20261124232247.23169-10-dwmw2@infradead.org>
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

qmp_xen_event_inject() reported the invalid port with error_setg() but
then carried on regardless, passing it to set_port_pending(). Return
after setting the error.

Fixes: 507cb64d6e66 ("i386/xen: add monitor commands to test event injection")
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_evtchn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index d0807f5fece..7fd8c3f3182 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -2342,6 +2342,7 @@ void qmp_xen_event_inject(uint32_t port, Error **errp)
 
     if (!valid_port(port)) {
         error_setg(errp, "Invalid port %u", port);
+        return;
     }
 
     QEMU_LOCK_GUARD(&s->port_lock);
-- 
2.43.0

