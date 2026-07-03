Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDFB35E1B7;
	Fri,  3 Jul 2026 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113874; cv=none; b=u27FmcUGzXKTZL6rtNtf+vigMLxM0cFRWFlXJLV+x8ya1qRqr3MqO1lOlnQDeE0a3z7DQw0TEijMP+NEbJadjNVRavsu+VuoLwiers9oz5bz43QP55HiWsfYUals7Yie3EvToOwHXqGro8zyDm7XuXuGAlzOBVW8xWXbDh1KTVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113874; c=relaxed/simple;
	bh=eIhV0u4PZdmT7HznEbGDYiMctBb8jGIoGHYtX4odE28=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmp5H3O+sBks2QJRvqjYfElwLes/ezLZ7Zmh9bfnRALtkApt0KBSbuKr2hTBHwjOv8ZEUoYCUPx85Iyv1ClqQDf2NQBBCgdEJCsLzVi9+KZIloze2t027PvnURBil/pZZrl/iXl3EaLrzwtT3iRd9SVD4Ig9FDEQu9P+b1FHa/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=apbGiZMk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="apbGiZMk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=cd7ADB+seora88pbKs2aD/tIbj9VePpwMwSL1OtTGjc=; b=apbGiZMkUWlTVRA2dMsajeQnJ0
	RhOJ6E89Pg9nZWfqc1RytnC60PxmSbLIc70g2wiX9+ooo+ZTGG+wuRG28iqP40gybMT4pWEYVKG45
	IVR/hQwGVcaV0h45HGBgtN2qd4s+8dCM8XetiqvJ905knza/omAjyD5QDeKL2kLEu5tSs9t9rUG0C
	pUge3V166Jv7ecOVz6xHEpZMkC/QA8i04z7CCvmXPW7GybxZC1kDSoXQr3x1//zaHva65YLoum3ha
	jySMWli1TzgZTW4U5jDjlS4f0GHvt/pA6S68YpOLver+gZSd/WhlFkM4AA9b5RT7qhPBtTqlM1su1
	y/Xr5sFQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKe-000000059OC-0v73;
	Fri, 03 Jul 2026 21:23:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKX-00000001RPn-1wE5;
	Fri, 03 Jul 2026 22:21:49 +0100
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
Subject: [PATCH v6 30/36] KVM: x86: Re-synchronize TSC after KVM_SET_TSC_KHZ
Date: Fri,  3 Jul 2026 22:18:09 +0100
Message-ID: <20260703212145.343527-31-dwmw2@infradead.org>
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
 arch/x86/kvm/x86.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 80fe69974ded..37a768b2fe16 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -206,6 +206,7 @@ module_param(mitigate_smt_rsb, bool, 0444);
 #ifdef CONFIG_X86_64
 static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp);
 #endif
+static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value);
 #define KVM_MAX_NR_USER_RETURN_MSRS 16
 
 struct kvm_user_return_msrs {
@@ -2584,6 +2585,7 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
 {
 	u32 thresh_lo, thresh_hi;
 	int use_scaling = 0;
+	u64 tsc;
 
 	/* tsc_khz can be zero if TSC calibration fails */
 	if (user_tsc_khz == 0) {
@@ -2611,7 +2613,17 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
 			 user_tsc_khz, thresh_lo, thresh_hi);
 		use_scaling = 1;
 	}
-	return set_tsc_khz(vcpu, user_tsc_khz, use_scaling);
+	/*
+	 * Read the guest TSC before changing the ratio, so we can
+	 * re-synchronize to preserve continuity across the change.
+	 */
+	tsc = kvm_read_l1_tsc(vcpu, rdtsc());
+
+	if (set_tsc_khz(vcpu, user_tsc_khz, use_scaling))
+		return -1;
+
+	kvm_synchronize_tsc(vcpu, &tsc);
+	return 0;
 }
 
 static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
-- 
2.54.0

