Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62547AF5F;
	Mon,  8 Jun 2026 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930548; cv=none; b=raWP95LCyngQZnykd2brTkmAf0yrHh8foWtZt3bjK4rGmwOXlb36aDnXs7fzMnhWRiVKaMYY0aIPdBvpWEj8YGwTMWKk97B5sdXOXOS5OdWILfBtTPHvQsmEP8kx0jovgRbPT2m/shaNVpA8RbqAl2Dzlz+PeowH+Yn67JyEeD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930548; c=relaxed/simple;
	bh=BRryjkqi72CYtRIATe2RY4Jwi1R8kuHW2WgrK3EhjY0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uq83Md3InkvqwcxKLSkEKNJS/dw9VyUusaRBYmgJmm100lVdECUP5h7z8qJzDjGZDNq3Oiht3tEq71jFwpIT4LrBhXxUbOoiD6aXiwT7b4UH+sg7ue5/iwJtS0M++F+U/rumnWJocitg8ccxyDRI38vjRXUYl4zqcCT79d3S+IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ni9Ilvbw; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ni9Ilvbw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=2HLSLUjeLQsW5WrqM21C7HZ/xT6pine5iDmPQ6igVxE=; b=Ni9Ilvbwo7oIrKnHzDrIZAX3F2
	RVmRXimMBpSXsB/PuaSbg7zYWlWsY9UbP0wfNf5MjypDK+kBFRkXsj0vr9rZtr0xBq0N4u3z84LWb
	RkcALGmd1E1iTn/pYRHEwvY0rIcfjeZ4m/iW/CXynbM0G8e2Xw/147pFKI0z7DMnFZi2ZtaxDjJwQ
	2TTQpAps1eMGFLa+LHQAZI2lhKXsKQNZoAMimSnbZozldFTFmjECb4y0D8gAkpJV1zRbGQDWWgoDM
	hvapc+bDfQtP6TDe0mL9HqbqDIvgaulmjVRM8bTdK+Aw70gqrKAi9unsKv9TS7s5FTmPCuB3m/JzY
	8exJbhGw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNU-00000001Ag1-2Lkb;
	Mon, 08 Jun 2026 14:55:00 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNS-00000000NFW-0Spr;
	Mon, 08 Jun 2026 15:54:58 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	joe.jin@oracle.com,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 16/34] KVM: x86: Simplify and comment kvm_get_time_scale()
Date: Mon,  8 Jun 2026 15:47:57 +0100
Message-ID: <20260608145455.89187-17-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608145455.89187-1-dwmw2@infradead.org>
References: <20260608145455.89187-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The kvm_get_time_scale() function was entirely opaque. Add comments
explaining what it does: compute a fixed-point multiplier and shift for
converting TSC ticks to nanoseconds via pvclock_scale_delta().

Rename the local variables from the cryptic tps64/tps32/scaled64 to
base_hz_u64/base32/scaled_hz_u64 to make the code self-documenting.
The "tps32" name stood for "Ticks Per Second" but was misleading since
it held the shifted base frequency, not a tick count.

No functional change.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 arch/x86/kvm/x86.c | 55 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 92e32d720523..a6c31a0d9955 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2472,32 +2472,57 @@ static uint32_t div_frac(uint32_t dividend, uint32_t divisor)
 	return dividend;
 }
 
-static void kvm_get_time_scale(uint64_t scaled_hz, uint64_t base_hz,
+static void kvm_get_time_scale(u64 scaled_hz, u64 base_hz,
 			       s8 *pshift, u32 *pmultiplier)
 {
-	uint64_t scaled64;
-	int32_t  shift = 0;
-	uint64_t tps64;
-	uint32_t tps32;
+	u64 scaled_hz_u64 = scaled_hz;
+	s32 shift = 0;
+	u64 base_hz_u64;
+	u32 base32;
 
-	tps64 = base_hz;
-	scaled64 = scaled_hz;
-	while (tps64 > scaled64*2 || tps64 & 0xffffffff00000000ULL) {
-		tps64 >>= 1;
+	/*
+	 * This function calculates a fixed-point multiplier and shift such
+	 * that:
+	 *   time_ns = (tsc_cycles << shift) * multiplier >> 32
+	 *
+	 * Where tsc_cycles tick at base_hz, and time_ns should count at
+	 * scaled_hz (typically NSEC_PER_SEC for a TSC→nanoseconds conversion).
+	 *
+	 * The multiplier is: (scaled_hz << 32) / base_hz, adjusted by shift
+	 * to keep everything in range.
+	 */
+
+	base_hz_u64 = base_hz;
+
+	/*
+	 * Start by shifting base_hz right until it fits in 32 bits, and
+	 * is lower than double the target rate. This introduces a negative
+	 * shift value which would result in pvclock_scale_delta() shifting
+	 * the actual tick count right before performing the multiplication.
+	 */
+	while (base_hz_u64 > scaled_hz_u64 * 2 || base_hz_u64 >> 32) {
+		base_hz_u64 >>= 1;
 		shift--;
 	}
 
-	tps32 = (uint32_t)tps64;
-	while (tps32 <= scaled64 || scaled64 & 0xffffffff00000000ULL) {
-		if (scaled64 & 0xffffffff00000000ULL || tps32 & 0x80000000)
-			scaled64 >>= 1;
+	/* Now the shifted base_hz fits in 32 bits. */
+	base32 = (u32)base_hz_u64;
+
+	/*
+	 * Next, shift scaled_hz right until it fits in 32 bits, and ensure
+	 * that the shifted base_hz is strictly larger (so that the result of the
+	 * final division also fits in 32 bits).
+	 */
+	while (base32 <= scaled_hz_u64 || scaled_hz_u64 >> 32) {
+		if (scaled_hz_u64 >> 32 || base32 & BIT(31))
+			scaled_hz_u64 >>= 1;
 		else
-			tps32 <<= 1;
+			base32 <<= 1;
 		shift++;
 	}
 
 	*pshift = shift;
-	*pmultiplier = div_frac(scaled64, tps32);
+	*pmultiplier = div_frac(scaled_hz_u64, base32);
 }
 
 #ifdef CONFIG_X86_64
-- 
2.54.0

