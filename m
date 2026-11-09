Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187289;
	b=YMLh+ep7ZwcZF55K6WpNTFSlf6hT4SyCbDGwJFE2FE8r5uN21rve4TLibNQUG/rEK25n
	 7nFMCzB3caZYhgGiQIaL9r3i7ExHbJofncGI0ovlEstNux2LSHgk9cZ0V5tzhtg8bnRwl
	 vETsGjBe6OF0pG2YCe2fmYzGSrNCS6CeyaKpC0wTjb80qtqWO73rNj2rOtTU0AkdkSqfQ
	 0X0eyl8a4w28It8P6fUq883ARzyTRk6naCj9QBasG73i30TuKvwEbqdKIfBI6Un34SreB
	 4csxRSvv7JJLrM5PTfhySeoY6vMX6RdtH/h8czH0mu0da645aHzKMJ3WCGMvXTenMig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187289;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=SR/76Q1Z57YyfL7/pX6GVKGYRXjznlqWiAUlX6lozs4=;
	b=R7pqFEFTKzxkY3XJsR+t8lbTgsW3u9/hiYylA5rHPNeIj6NT4z2kgBSpaB8cftbWv+b+
	 sxkcKN1VnQUU7G8TqOwyaiiEVvWeFhNvoJCu+JMYRTjHnF+fZt/1AZe8Tf6EZukrqxrJw
	 tswuhToIv2pKA3JfHgi/X78mWlsFXySOvTknJFMyq2r0aZqAp+OQhUZnWA/LfFAJz+HCl
	 47oJZOD6I6BPeTBnkpoUCulvUiraB9LD+6OH82yrqEbBz8Da2YszA+uABKTAYgzCgViWi
	 1E+KuB9g1OUvzesCYdJb+625pw//BFsC1t3Heivb5MIzaQTXDRVJfbHIBelIsXL3V5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=qecoNL0Y;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C9606EE90;
	Mon,  9 Nov 2026 01:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D0C9606EE90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=qecoNL0Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=SR/76Q1Z57YyfL7/pX6GVKGYRXjznlqWiAUlX6lozs4=; b=qecoNL0YT9N3J6QDcfhdb3CYLK
	M3y0Heu+j6haI2EszDlWoo82TCSq4n2iLg70sWTKEu7zisutAr+uhXQ1Az335/sr9Q+4x8ULz83nm
	pVkh2Hh+OvFaTkEtm/UsR9FNc9CzVBO+2C3ZNji0cWFORzcGeiS4UoddbMjWe4020idoEx6sJ7sFR
	4RC16nYhEEMl/azSuDUYfzB5AoRTHQaNtsMxSqUHlRMbv/wPxgBONjX7AGoGxMmsQ20fG1dluSdS5
	0UVORl+ivp+eQdNIRTSuN3pNo+H/VT50AzCTRnKGFmt7YsUOS7+TlNAQOyMDW0GLXlmgay3ZhOX3i
	o38HU/fg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQE4Q-00000006AY6-27Ls;
	Mon, 09 Nov 2026 01:21:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xQE4O-0000000EKU7-1pEh;
	Mon, 09 Nov 2026 01:21:12 +0000
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
Subject: [PATCH v12 01/24] KVM: x86: Improve synchronization in kvm_synchronize_tsc()
Date: Sun,  8 Nov 2026 17:20:47 -0800
Message-ID: <20261109012112.3415328-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109012112.3415328-1-dwmw2@infradead.org>
References: <20261109012112.3415328-1-dwmw2@infradead.org>
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

When synchronizing to an existing TSC (either by explicitly writing
zero, or the legacy hack where the TSC is written within one second's
worth of the previously written TSC), the last_tsc_write and
last_tsc_nsec values were being misrecorded by __kvm_synchronize_tsc().
The *unsynchronized* value of the TSC (perhaps even zero) was being
recorded, along with the current time at which kvm_synchronize_tsc()
was called. This could cause *subsequent* writes to fail to synchronize
correctly.

Fix that by extrapolating the generation's TSC value to the current
time (data = cur_tsc_write + elapsed cycles) before passing it to
__kvm_synchronize_tsc(), so the recorded {data, ns} pair always lies
on the generation's line and the one-second matching window slides
forward with each synchronized write. When the TSC is stable, reuse
the generation's offset exactly; when it is unstable, compute a new
offset for the extrapolated value.

Furthermore, there were *three* different TSC reads used for calculating
the "current" time, all slightly different from each other. Fix that by
using kvm_get_time_and_clockread() where possible and using the same
host_tsc value in all cases.

Extrapolating the matching window from the generation's origin at the
nominal guest frequency means that, for a guest whose requested
frequency is within tsc_tolerance_ppm of the host's (so hardware
scaling is not engaged), the window drifts from the guest's actual
TSC line by up to 250ppm — crossing the one-second window after about
67 minutes. A write which then fails to match still installs the
exact value with a freshly computed offset; the cost is only a fresh
generation. The previous code re-anchored on every matched write,
which bounded that drift per-interval but recorded values the
generation's line did not pass through, which is the bug this patch
exists to fix.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 arch/x86/kvm/x86.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba9..7a2b0b99373f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -210,6 +210,10 @@ module_param(pi_inject_timer, bint, 0644);
 static bool __read_mostly mitigate_smt_rsb;
 module_param(mitigate_smt_rsb, bool, 0444);
 
+#ifdef CONFIG_X86_64
+static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp);
+#endif
+
 #define KVM_SUPPORTED_XCR0     (XFEATURE_MASK_FP | XFEATURE_MASK_SSE \
 				| XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS \
 				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
@@ -1374,14 +1378,23 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 {
 	u64 data = user_value ? *user_value : 0;
 	struct kvm *kvm = vcpu->kvm;
-	u64 offset, ns, elapsed;
+	u64 offset, host_tsc, elapsed;
+	s64 ns;
 	unsigned long flags;
 	bool matched = false;
 	bool synchronizing = false;
 
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
-	offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
-	ns = get_kvmclock_base_ns();
+
+#ifdef CONFIG_X86_64
+	if (!kvm_get_time_and_clockread(&ns, &host_tsc))
+#endif
+	{
+		host_tsc = rdtsc();
+		ns = get_kvmclock_base_ns();
+	}
+
+	offset = kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
 	elapsed = ns - kvm->arch.last_tsc_nsec;
 
 	if (vcpu->arch.virtual_tsc_khz) {
@@ -1424,13 +1437,21 @@ void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
          */
 	if (synchronizing &&
 	    vcpu->arch.virtual_tsc_khz == kvm->arch.last_tsc_khz) {
-		if (!kvm_check_tsc_unstable()) {
+		/*
+		 * If synchronizing, advance the reference point to "now"
+		 * so the matching window slides forward with each vCPU.
+		 * Extrapolate from the generation's own origin: 'elapsed'
+		 * is measured from the most recent write, which lies on
+		 * the generation's line only for the first matched write.
+		 */
+		u64 delta = nsec_to_cycles(vcpu, ns - kvm->arch.cur_tsc_nsec);
+
+		data = kvm->arch.cur_tsc_write + delta;
+
+		if (!kvm_check_tsc_unstable())
 			offset = kvm->arch.cur_tsc_offset;
-		} else {
-			u64 delta = nsec_to_cycles(vcpu, elapsed);
-			data += delta;
-			offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
-		}
+		else
+			offset = kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
 		matched = true;
 	}
 
-- 
2.43.0

