Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B508F43E9F6;
	Mon,  8 Jun 2026 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930539; cv=none; b=YjvCUK9Rd2xmxke7bLp3jb0Y+PdZJD7DvmsqcE2Shp6eID0MFT+Qby4D5ov4i/rdXakwtWCI5XLMqmeJl/aKiGy2S/+wCblExJRi3XFW95mG5Htn1WahbmCihx4Cm75vb+Zopa9LuuRz5QtBpaIc/FHNpAJJxt1/w/YX6rGV0m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930539; c=relaxed/simple;
	bh=Hf8VHEZ8O2Jy3Wzguw0b7iQtLmsQiNi/OCpzE1HUF6M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUfxeZ/vJfceiJbu6DggAzkc+vVkZlS1T8pDYmfTm03Chuy9jJZ50rxB7b8QoBLT2XUlFTv2z3GVC+Irln8+je1Ccjwg0N1Fbpi5uMDxBesQSGbmM0U6QJPpDkAoULqdVbWHCVsdpHoSHYfkuH8o/6ojsM7Dm9oFHBUSxl/i8MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wRwgQ5ZG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wRwgQ5ZG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=lqNX+TXIvKbp1pjqN/ugyzGv3kWdP4RiL9hc1KXGPRI=; b=wRwgQ5ZGbWhFRFS/ILi+ryrW8z
	RCJJgbqOfBEBjgKSKCcCoDW2seCAXJOVkJsIUjpsZTFf3ZwwW/r/LBoRg3GcTDegI9Om9buMxnXSm
	ol4oIqjGlb4+UjznpTA/wrrDb9iKy8EBM/hG8vEG7tlKR+JP/4yLfX9N3NkyF9T370tZRJwZjGk+d
	HgwTljMZ5/hOowc/g8+thNhKsZ2enCaTJi9CEaWb230kQ4ycqvj9pOEWkLhZEyZr0PfWYT9G+NitC
	bu20HsuDZZ1x7G+uKKJk8yolRz05c/6kBD7WH2e58bwup4UlWMqcQw5MeXhriW5XlTXpV6fs8IKUT
	sbgyowbQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWbNS-0000000Dtxf-2ZjW;
	Mon, 08 Jun 2026 14:54:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNS-00000000NGR-3GbY;
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
Subject: [PATCH v5 29/34] KVM: x86: Re-synchronize TSC after KVM_SET_TSC_KHZ
Date: Mon,  8 Jun 2026 15:48:10 +0100
Message-ID: <20260608145455.89187-30-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608145455.89187-1-dwmw2@infradead.org>
References: <20260608145455.89187-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

KVM_SET_TSC_KHZ changes the vCPU's TSC scaling ratio but does not
update the VM-wide cur_tsc_scaling_ratio used by get_kvmclock().
This causes get_kvmclock() to use a stale (default 1:1) ratio when
computing the KVM clock, leading to drift between the host-side
kvmclock and what the guest observes.

Fix this by calling kvm_synchronize_tsc() after changing the TSC
frequency. This:
 - Updates cur_tsc_scaling_ratio (consumed by pvclock_update_vm_gtod_copy)
 - Ensures the TSC value is continuous across the frequency change
 - Triggers kvm_track_tsc_matching() for proper masterclock handling
 - Allows subsequent vCPUs to synchronize via the 1-second slop hack

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 54d4b1b3cfe4..96250264d403 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -206,6 +206,7 @@ module_param(mitigate_smt_rsb, bool, 0444);
 #ifdef CONFIG_X86_64
 static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp);
 #endif
+static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value);
 #define KVM_MAX_NR_USER_RETURN_MSRS 16
 
 struct kvm_user_return_msrs {
@@ -2611,7 +2612,20 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
 			 user_tsc_khz, thresh_lo, thresh_hi);
 		use_scaling = 1;
 	}
-	return set_tsc_khz(vcpu, user_tsc_khz, use_scaling);
+	if (set_tsc_khz(vcpu, user_tsc_khz, use_scaling))
+		return -1;
+
+	/*
+	 * Re-synchronize the TSC after changing frequency. This ensures
+	 * cur_tsc_scaling_ratio is updated (used by get_kvmclock) and
+	 * the TSC value is continuous across the frequency change.
+	 */
+	{
+		u64 tsc = kvm_read_l1_tsc(vcpu, rdtsc());
+
+		kvm_synchronize_tsc(vcpu, &tsc);
+	}
+	return 0;
 }
 
 static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
-- 
2.54.0

