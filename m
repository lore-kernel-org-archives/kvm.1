Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1489378803;
	Fri,  3 Jul 2026 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113850; cv=none; b=Vvla9mCOpdWTOGfH70hBYGs2X68GEn7YEIaesfeNbqmUhqwtRf+ZMogpZwCstisgT5THPX6p7uJu7FozwWYZ28nD1OJmNopS8UU11dM0n7zjjnsd7Ly/VhFsrz+JbYvU6hwfB4JRuh7Rennr0h8fKpCrcJZq3r2nRkbK/Jvoqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113850; c=relaxed/simple;
	bh=EnZ6Qpl6P5nc/alG5pV5NVNkUPONyIkxolF+yuBoKxI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W08Iu6x6GbCe5CGUB+fScsAVPhOcRnIR4jsfYmz1W3lxX1cFjmBujvwgzDnJ5Bt7MBFR8Rwhf+nLysMEzHooJh58tIsA1OcubVHLd0Eh02c/f1oQVW4Sep4UUfx4rupo0PjbE2dfZ0XE7E9kw4eRvYikBUy266qnJ4SDVRxYkts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qTsfnPqY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qTsfnPqY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=pFpNlCE+MJW0eKcLFgCCZwMvqjxRJ/tMcKVjrR0U73Q=; b=qTsfnPqYdMDx4eUygFXJFljz/J
	HPP9ML6utEPbyFF37E1VztfM6jgMhMBh95PQ1lNByOYWgIaCp6JWwXn4CRiSdDQFDIubsZaIb1glB
	Pu8lGpAoP1cmJkXCbNxwxUkWPL34CuBc3XRH6b6uwshPpJHdqsbbOUZ4TmvT2K+ejBCcOwlpZY1Jb
	GjvaQoRWKExUh3UM+KhXoM+5PJv34XQ5X20qE921jQFhjoHQPWuJAMkL9/oLGBiIyvViWkFfekSOH
	a1X/CfCJ/Z+HF+xC8jpSbTeTXXtYydVpu1qQp7aurcyiShWJWGhkMCvXINe0EysHUaf8mOrj5+V/i
	2xt5dohQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKd-000000059O3-3Oad;
	Fri, 03 Jul 2026 21:23:38 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKW-00000001ROl-2MEe;
	Fri, 03 Jul 2026 22:21:48 +0100
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
Subject: [PATCH v6 15/36] KVM: x86: Fix compute_guest_tsc() to handle negative time deltas
Date: Fri,  3 Jul 2026 22:17:54 +0100
Message-ID: <20260703212145.343527-16-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703212145.343527-1-dwmw2@infradead.org>
References: <20260703212145.343527-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The compute_guest_tsc() function computes the guest TSC at a given
kernel_ns timestamp. When the master clock reference point
(master_kernel_ns) is earlier than vcpu->arch.this_tsc_nsec, the delta
is negative. Since pvclock_scale_delta() takes a u64, the negative
value wraps to a huge positive number, producing a wildly wrong result.

Handle negative deltas explicitly by negating the delta, scaling it,
and subtracting from this_tsc_write.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 376b8dc2ade9..55fb19fb7a88 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2588,11 +2588,21 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
 
 static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
 {
-	u64 tsc = pvclock_scale_delta(kernel_ns-vcpu->arch.this_tsc_nsec,
-				      vcpu->arch.virtual_tsc_mult,
-				      vcpu->arch.virtual_tsc_shift);
-	tsc += vcpu->arch.this_tsc_write;
-	return tsc;
+	s64 delta_ns = kernel_ns - vcpu->arch.this_tsc_nsec;
+	u64 tsc;
+
+	/* Handle negative deltas gracefully (master clock ref may be earlier) */
+	if (delta_ns < 0) {
+		tsc = pvclock_scale_delta(-delta_ns,
+					  vcpu->arch.virtual_tsc_mult,
+					  vcpu->arch.virtual_tsc_shift);
+		return vcpu->arch.this_tsc_write - tsc;
+	}
+
+	tsc = pvclock_scale_delta(delta_ns,
+				  vcpu->arch.virtual_tsc_mult,
+				  vcpu->arch.virtual_tsc_shift);
+	return vcpu->arch.this_tsc_write + tsc;
 }
 
 #ifdef CONFIG_X86_64
-- 
2.54.0

