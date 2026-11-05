Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893809;
	b=N8bA+w3+eJSScFsiOnCqWZLDKbi0Van5+65HypfVI1vKQLAwLvyXmVV9nP+1/OC8XyRD
	 d0Xfz+Apn4wu7ahyzY8IY/WbC1Q95QJyjD397gaZ5dU0JB13GQby2C7kXmkokbwAgPUsC
	 9LWgYGRoXYoZL/XyqYMNfu4l6sokY2lSjIypDRpozUn6JBM+oHKRkOGq6Y8K6pJOaJxnG
	 CkkhAUYnWrkWSRA+4m1BV4/q15i38Sj+3MCxui5I8nGDQtYhHbOEbIwQEYxXuc32o1JAH
	 wlHfFNlyDZ4qywGHIRTHrUncoN25ed7UzaRNrK8YOefdOZxmwOXobD2MxfuKZm70Ojg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893809;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=g4JrrC8CXxAVCwMpD677FP/zgaKLwH1jqXxuO1KGNO4=;
	b=wTqqDZ6LMS5h1koWK2OXzQ0n4JAUQdXougZdex6OyXcQNxcaKVAfwRcMQ6oFLNj0StCI
	 ocB0qNufBCSufSghxs13CwqvUV12NZSMC3p67N0mqSFIs/6RJFhpSipZ+q73Roy1vB080
	 rvE23q+6xH7WDtKsstsn8MyEnqkilfYgfCChYgKW0C69zKz/ZbF8X97ZDWZZyb+SR7jKT
	 g38KhKpoLBUuQFTuDZs0Bhwili6wavgT083oDDDYHRMOZ/yvbTxMHuhSFHmtJf1Bkv4hJ
	 COzWtZdkFuhFwzEUJL0U3g5hm0Iq4rYG297LFCV1vMIYEFLWKMrfrszlZtZDjHG9bpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=kWaXj1qW;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B216460A6F7F;
	Thu,  5 Nov 2026 15:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B216460A6F7F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=kWaXj1qW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=g4JrrC8CXxAVCwMpD677FP/zgaKLwH1jqXxuO1KGNO4=; b=kWaXj1qWvUaOw0hNDCygBmKS1q
	K4x/XgGfqV1DVd9theLgpetcA5eckMwSt79lnDyhjAxtTsbYGNMFFiG3EeHXxNtVJZyf0R0XA0iqV
	TMh5OHPG0uTH9cp76KMrlbkAT1h1IhXnLfOdWF4S2sHAZwg7I1zxMdWlzayqJFvfIfXJKKqmYk6K3
	+x5YJbjcSX0nQUEry1LjqLlKWXOcYYOIbF+ATAWjDlywsZu3PI3Y8FTm7ZoWEcKXeCpKREwUqYHYM
	nJx78wIyYh/Uz0UyZiZwgNXPSrw6LrrJThCGA+U4rPevxsy0QWzf7QpflFuILzEQNV5fxnyHe3fCS
	0vxBljtg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOzit-00000009aok-3qxv;
	Thu, 05 Nov 2026 15:49:56 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOzit-0000000Aaz6-2zW0;
	Thu, 05 Nov 2026 15:49:55 +0000
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
Subject: [PATCH v11 06/23] KVM: x86: Avoid gratuitous global clock updates
Date: Thu,  5 Nov 2026 07:49:37 -0800
Message-ID: <20261105154955.2525419-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105154955.2525419-1-dwmw2@infradead.org>
References: <20261105154955.2525419-1-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Eliminate two sources of unnecessary KVM_REQ_GLOBAL_CLOCK_UPDATE:

1. kvm_write_system_time(): The global clock update was a workaround for
   ever-drifting clocks based on the host's CLOCK_MONOTONIC subject to
   NTP skew. Now that the KVM clock uses CLOCK_MONOTONIC_RAW, the clock
   does not drift with NTP corrections and there is no need to
   synchronize all vCPUs on boot or resume. Use KVM_REQ_CLOCK_UPDATE on
   the vCPU itself, and only when the clock is being enabled, not
   disabled.

2. kvm_arch_vcpu_load(): In master clock mode, migration between pCPUs
   does not require any clock update since the master clock reference is
   shared. Only request a local KVM_REQ_CLOCK_UPDATE for the vCPU's
   first-ever load (vcpu->cpu == -1) to generate initial pvclock params.
   In non-master-clock mode, keep the global update to synchronize all
   vCPUs.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/msrs.c | 7 ++++---
 arch/x86/kvm/x86.c  | 4 +++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index e91650af44c2..a2dffa1c706f 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -1285,14 +1285,15 @@ static void kvm_write_system_time(struct kvm_vcpu *vcpu, gpa_t system_time,
 	}
 
 	vcpu->arch.time = system_time;
-	kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
 
 	/* we verify if the enable bit is set... */
-	if (system_time & 1)
+	if (system_time & 1) {
 		kvm_gpc_activate(&vcpu->arch.pv_time, system_time & ~1ULL,
 				 sizeof(struct pvclock_vcpu_time_info));
-	else
+		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
+	} else {
 		kvm_gpc_deactivate(&vcpu->arch.pv_time);
+	}
 
 	return;
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4c3fce29e2af..e3618d82c099 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2702,11 +2702,13 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		 * On a host with synchronized TSC, there is no need to update
 		 * kvmclock on vcpu->cpu migration
 		 */
-		if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu == -1) {
+		if (!vcpu->kvm->arch.use_master_clock) {
 			if (__ratelimit(&vcpu->kvm->arch.kvmclock_update_rs))
 				kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
 			else
 				kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
+		} else if (vcpu->cpu == -1) {
+			kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
 		}
 
 		if (vcpu->cpu != cpu)
-- 
2.43.0

