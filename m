Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692053F23BE;
	Mon,  8 Jun 2026 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930520; cv=none; b=Tcf9ae5cM424Q6So0PFS+WOcUVEF7jaP4B+Bw7Iv7owUJbNKlIMNJFdBSfSPgNCU0PFVBZVzXOWJXZ1ugC9IxGPgBkyQgleljfiw6k5xDf2crwHOeAr1LSiaeixzhyFlCBpQ+g7GDj5HXRxGiEtzkBGYcyPrv7587Y/6sREGg0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930520; c=relaxed/simple;
	bh=r3kwd9Os0PCA9RvG9bKAmDRSaB7VpLbvOmwkWVnLV+s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZgGPy5QMYnEupkNevTrpAuYxKemrzzuncVX86IxNvVSBeWCqt2s//YjkcTqrXyFsHHqzHmFa9VbOSB5BB9iyvc/CFaPJkui2F8loIjS/KKxnUTOtaEnV30DRv6fbYbt21OPS/Fax8Kz2es4vwbRc6XNo0Aqi5AfvYvbIgQE7ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kld3KJEK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kld3KJEK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=mXbhskdA++vhUDI1oas++LQ6MKrW1eT7EmECWvGk1MU=; b=kld3KJEKyVhgHwNB9MXsgtFGHM
	NRk8kDLq4sjWFPSiEYCazB3mLYrvTTJPUeVyZ8Adpmnt0NNFfaZoiBsBTHBZiMcMB/VwcWUxwxy7g
	lNILHXZ/Blw5vKOImjaz2dxZqvHuPxZKmZfM2mAtOIsTRmAupSROxT8IOZPNFf5YWr8Aqcjni3HSu
	Tm5dD4wjccOy5vGXBPeqCifw70AHNUqkba5MbwYlq1/G6tBhhz1sBC19DaWllKo9KdUR/kDGv0bZD
	UP7MppcYr9VAmJQO2gCb91fWtWdSBSqhI7QLwJi8L+i/vREiicZBMMi+ceG/pcLoDUSrhXoBZt8ha
	9XciMkyw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWbNR-0000000DtxG-4BPF;
	Mon, 08 Jun 2026 14:54:58 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNS-00000000NFa-0ldF;
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
Subject: [PATCH v5 17/34] KVM: x86: Remove implicit rdtsc() from kvm_compute_l1_tsc_offset()
Date: Mon,  8 Jun 2026 15:47:58 +0100
Message-ID: <20260608145455.89187-18-dwmw2@infradead.org>
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

Let the callers pass the host TSC value in as an explicit parameter.
This leaves some fairly obviously stupid code, which is using this
function to compare the guest TSC at some *other* time, with the
newly-minted TSC value from rdtsc(). Unless it's being used to measure
*elapsed* time, that isn't very sensible.

In this case, "obviously stupid" is an improvement over being
non-obviously so.

No functional change intended.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 arch/x86/kvm/x86.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a6c31a0d9955..bce4c7a6a6fe 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2693,11 +2693,12 @@ u64 kvm_scale_tsc(u64 tsc, u64 ratio)
 	return _tsc;
 }
 
-static u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
+static u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 host_tsc,
+				     u64 target_tsc)
 {
 	u64 tsc;
 
-	tsc = kvm_scale_tsc(rdtsc(), vcpu->arch.l1_tsc_scaling_ratio);
+	tsc = kvm_scale_tsc(host_tsc, vcpu->arch.l1_tsc_scaling_ratio);
 
 	return target_tsc - tsc;
 }
@@ -2859,7 +2860,7 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 	bool synchronizing = false;
 
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
-	offset = kvm_compute_l1_tsc_offset(vcpu, data);
+	offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
 	ns = get_kvmclock_base_ns();
 	elapsed = ns - kvm->arch.last_tsc_nsec;
 
@@ -2908,7 +2909,7 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 		} else {
 			u64 delta = nsec_to_cycles(vcpu, elapsed);
 			data += delta;
-			offset = kvm_compute_l1_tsc_offset(vcpu, data);
+			offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
 		}
 		matched = true;
 	}
@@ -4155,7 +4156,8 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (msr_info->host_initiated) {
 			kvm_synchronize_tsc(vcpu, &data);
 		} else if (!vcpu->arch.guest_tsc_protected) {
-			u64 adj = kvm_compute_l1_tsc_offset(vcpu, data) - vcpu->arch.l1_tsc_offset;
+			u64 adj = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data) -
+				  vcpu->arch.l1_tsc_offset;
 			adjust_tsc_offset_guest(vcpu, adj);
 			vcpu->arch.ia32_tsc_adjust_msr += adj;
 		}
@@ -5279,7 +5281,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 			mark_tsc_unstable("KVM discovered backwards TSC");
 
 		if (kvm_check_tsc_unstable()) {
-			u64 offset = kvm_compute_l1_tsc_offset(vcpu,
+			u64 offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(),
 						vcpu->arch.last_guest_tsc);
 			kvm_vcpu_write_tsc_offset(vcpu, offset);
 			if (!vcpu->arch.guest_tsc_protected)
-- 
2.54.0

