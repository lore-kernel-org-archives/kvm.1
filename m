Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2896934D3A9;
	Sat,  9 May 2026 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366930; cv=none; b=MvmdxwVnvjPizEvmCk32+p5WOoWpJVzw1/4yA1mJHvJ7HJQIbhVOyDa8tsPTYL7q8GN2Qq2KXxI3LonIjL/0179FwD+1GPXApagg+0RYLjG4dUMwiY/FYpIoJ6ZXSwHly6R46R+zpiH++/H1TXMPfdoFte8hiSlPjRYw6MusNtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366930; c=relaxed/simple;
	bh=68ZuhRHOpmR44tlPr41ZyQTbnc5yvw6IttFCMGmogW0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNCkcBXLRw6fvyHNANq0GRt0OtvNzONhsyqcA1WS6q325o35GPT2n+AX5LE6mUL5PZiOXZEJ9dP2qBufPw41Dd4zi2vDJcENFkXeGMaHtoHRFTm0tum/KL1Ldmei3gVM5vXsiwCCQYYFrguFtwiqUq7IKa+kFiLRRQ+23y5EvA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NrR9w8Kh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NrR9w8Kh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=D3ZD9svrsYhkrCggc0KSRTT7FBRjbp88Q/98SjyDptU=; b=NrR9w8Khx8VGuwXJ3A16aybrkh
	ouMjKpQP6w9R9TcqzykS72xA/q0gH4AnT/doDfI3e5MH+ZYve9uiC4MpDjdR9lV6ySGhrydJumLyu
	NRE6qOZhbMnyVxh0P9LHfCe6NExErdMqYT1Nw3g8Wv/ITqy9kuvgl0DnJY4N544z/iucLmfyYY4c4
	YfuyAi3lxDKP1xpkaJePxhXdW73RHEX+f4rOvW6iiVc02rg0BLNX/qjWlRfklA0qK5eTITC9i6vD3
	6pSwy+DBngCkFGmK2VnZxRsO13YK8EaftPUcsEt0y86xLTVynuB/ogM2Ne36wGplkptXKQWhZVUSB
	R/Rz284g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLqTD-00000008wzH-0U6f;
	Sat, 09 May 2026 22:48:28 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLqTC-0000000DhID-35Yi;
	Sat, 09 May 2026 23:48:26 +0100
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
Subject: [PATCH v4 15/30] KVM: x86: Fix compute_guest_tsc() to handle negative time deltas
Date: Sat,  9 May 2026 23:46:41 +0100
Message-ID: <20260509224824.3264567-16-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260509224824.3264567-1-dwmw2@infradead.org>
References: <20260509224824.3264567-1-dwmw2@infradead.org>
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

Change the return type to s64 and handle negative deltas explicitly by
negating the delta, scaling it, and subtracting from this_tsc_write.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2bbc2c7ac449..e281c49561fa 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2586,13 +2586,23 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
 	return set_tsc_khz(vcpu, user_tsc_khz, use_scaling);
 }
 
-static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
+static s64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
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
2.51.0

