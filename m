Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420569;
	b=LcbdKGC7K3OQuLelVIda+UEJyjXTPS8tjRb7yc9A4cD8qwvf64u2uD7WS7cKB2RCKd0K
	 cO9HhsF2+EGlFzADxx1fEKuBZOPosepBfGcyptWggbxQ+N/nlTMsqzMUbZF7q4aPHKy5j
	 Btti+okFBwctCzQ9X+8Q/Ij7RwE/wNqD5+wyUX8HegVABr/vMLagDvZkobTA04KtgdTqn
	 a8A1Y1JMOhnOLnbv3yLVSHYU7D9KzOuodL0YuZbpovjdIBIAbaGG8iBWpZQ/I07cmWPEh
	 w+O0RYBIoDWmUqNdNrGuBc4hf26sQ1YReRepzYvzPQMbT80X9Xw8VRw9LeFCYfAQfyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420569;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=CwMbftQQz760x46CNDvM8hDlvtc6TEl7MUzV2LCVoJ8=;
	b=nfHdygxqCwmpuYBUtRh86oeXq6ieXH7zzcRtln8BCR1jtWzjgZJaUy1yz6Fvf7q/BkqB
	 jbQHKtWh/kDrEkBeL+lUmXFtQfC/m/B81q3LS4bGkM9lVodfEPPqhuwrl6DEvbowpDyd6
	 luQ6ukN+iCIprDu0oReXVLwl4CucJeGs6mMAbyuKjPK7ck8K/rrZ8R59rUQsOuyPNZWJF
	 YBPAmQzT1J7HvJVyFU2eK2t9WhSuKBey43wBz3Jg6xXbdh1SYgO11zfmw2NwUWOI4Hz30
	 m/ovFlj/ql3GcRWLMpFYBAALywaXEUwoN8Whbgi8qqpmO8f8PkuhMZ18ZwcyQGtRyxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="m1HC/fXW";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6752606A32E;
	Wed, 11 Nov 2026 18:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6752606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=m1HC/fXW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=CwMbftQQz760x46CNDvM8hDlvtc6TEl7MUzV2LCVoJ8=; b=m1HC/fXWMOhVcPBaVX9ACJgkhP
	iXh3emo0NGR0nWK2rwd8+E0IrGrZxZBfaiw4HEggmHieFrvcE1iFTJ0r3byuFZqxXgg3YEMPS7FOf
	eIJJGd0Fg4BqDjuNZx3szMRg0+whVz6xwejmjhGhgfBlc0ZPmCi4LM2+o62EOfOCYQ50V3OgHWH/w
	5E0bE/PoUaTZKSRAJOgjX5olCtGmil9IVoA9yDoWgBPqYJslPFpa5FWtDhqbyjsMZ+GFAfFHFkDaX
	nIVhEMQYFKCx0bcKteGqzwYhruC3nsiI5wnrAmHKfBZoS5Sjkm2GdsYEF1fP/BX7xIwd43vBWVdY7
	RmVqXlYw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRCl9-0000000CKvV-1Puz;
	Wed, 11 Nov 2026 18:09:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl9-0000000HWsa-0a3H;
	Wed, 11 Nov 2026 18:09:23 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	joe.jin@oracle.com,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v13 09/26] KVM: x86: Stop TSC catchup when a frequency change no longer needs it
Date: Wed, 11 Nov 2026 10:09:05 -0800
Message-ID: <20261111180922.4177927-10-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111180922.4177927-1-dwmw2@infradead.org>
References: <20261111180922.4177927-1-dwmw2@infradead.org>
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

On hardware without TSC scaling, KVM_SET_TSC_KHZ with a frequency above
the host's puts the vCPU into always-catchup mode. Nothing ever takes
it back out: a later KVM_SET_TSC_KHZ restoring a frequency within
tsc_tolerance_ppm of the host's, where no scaling or catchup is needed,
leaves the vCPU paying the catchup overhead on every clock update for
the rest of its life — and KVM_HC_CLOCK_PAIRING stays disabled, since
it rejects always-catchup mode.

Clear the pairing whenever set_tsc_khz() succeeds with a frequency
which does not need it. Only that pairing: tsc_catchup alone also
serves the unstable-host-TSC compensation in kvm_arch_vcpu_load(),
which must not be disturbed.

Fixes: cc578287e322 ("KVM: Infrastructure for software and hardware based TSC rate scaling")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0b3b04a156da..1d4b66257b35 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1031,7 +1031,7 @@ static int set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz, bool scale)
 	/* Guest TSC same frequency as host TSC? */
 	if (!scale) {
 		kvm_vcpu_write_tsc_multiplier(vcpu, kvm_caps.default_tsc_scaling_ratio);
-		return 0;
+		goto clear_catchup;
 	}
 
 	/* TSC scaling supported? */
@@ -1057,6 +1057,19 @@ static int set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz, bool scale)
 	}
 
 	kvm_vcpu_write_tsc_multiplier(vcpu, ratio);
+
+clear_catchup:
+	/*
+	 * A frequency which no longer needs catchup must also stop it: a
+	 * previous above-host-rate setting on scaling-less hardware set
+	 * the always-catchup flags, and nothing else ever clears them.
+	 * Only undo that pairing — tsc_catchup alone also serves the
+	 * unstable-host-TSC compensation in kvm_arch_vcpu_load().
+	 */
+	if (vcpu->arch.tsc_always_catchup) {
+		vcpu->arch.tsc_always_catchup = 0;
+		vcpu->arch.tsc_catchup = 0;
+	}
 	return 0;
 }
 
-- 
2.43.0

