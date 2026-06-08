Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B12E43E9CB;
	Mon,  8 Jun 2026 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930538; cv=none; b=nlTMgHjLQG30s/SGlDaOpqV2++QZPOyk2iiRAL/ZICBMi4koHrq7XvDZLa9vHy2g2cDxtyOEwpbRh3i8A7cRG0nbnUx+0gnc7JKrGX1KaWZ9ddeu+x9DCu7EW6LwBXN5EjbGhe+yh6a19EzlOGGiLHThvUZOgeKDg8CVwB0FT9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930538; c=relaxed/simple;
	bh=7Wz8+VAwcDMp5FiEB9Evg7YVWlEd1Zm2fNwaWkDZSnc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z65fVnMpGMBj9/VIW6vpmNErZEt6aTJgA3REnqJfJQoe9D2t00Ik2NqYhqcdW+fUlQHl5zXLUIyd92L9A/mnc64NXlq5mMjaN5M45+3z4HlSgdkFXe+22mJuRDZaMHifFcw3itHVLmFGD75E1akbZmQYJWTIju+PV9aaP5RdrHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t9va9E+4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t9va9E+4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=W6KRWl5EKJVhKKJ+V1j8dnQD5A6yc6eAk2IU9lJn4Ac=; b=t9va9E+4WmvNE0SA7fFgnaHxAD
	7AhhRvH+95yZbHhxU70s20pgqCglU/2MRBf1gWeBjW9qHK7AGbJzeCPBsEqwAGYcYGBfsGKyUr0K8
	I+Kucvi+HCbxb6DqCmYG9QGa1BzBi/4nL3594Qqo4Fe9p0Bmocw0V0aKBMjgDXLqyVEvPUG5alwe3
	Gwm1fDNDHbc9FsARs4mHF2I3Hq5XuSDM8w1ZLNSPU2uby115X+7zeGiFO7d1bAmfZIfNETMCOZs3e
	wGUEret33AxsKpui8L7/TSjGwrWVDEn5pApD3sHs6Wl2fYTNj0aa5VWYwneoqHr3ah5Gg13o/A9mJ
	awCwVtvA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWbNS-0000000DtxQ-0eWu;
	Mon, 08 Jun 2026 14:54:58 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNS-00000000NFm-1WIb;
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
Subject: [PATCH v5 20/34] KVM: x86: Replace nr_vcpus_matched_tsc count with all_vcpus_matched_tsc bool
Date: Mon,  8 Jun 2026 15:48:01 +0100
Message-ID: <20260608145455.89187-21-dwmw2@infradead.org>
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

Using a count and comparing with kvm->online_vcpus was always racy
because a new vCPU could be created while kvm_track_tsc_matching() was
running and comparing with kvm->online_vcpus. That variable is only
atomic with respect to itself; kvm_arch_vcpu_create() runs before
kvm->online_vcpus is incremented for the new vCPU.

Replace the count with a boolean that is set in kvm_track_tsc_matching()
after comparing the count, and cleared when a new TSC generation starts.
The boolean is consumed by pvclock_update_vm_gtod_copy() under the
tsc_write_lock, which serializes against __kvm_synchronize_tsc().

Keep the count for now as it's still used in the trace event.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/x86.c              | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 59298a8f78eb..eb81f90284ba 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1492,6 +1492,7 @@ struct kvm_arch {
 	u64 cur_tsc_write;
 	u64 cur_tsc_offset;
 	u64 cur_tsc_generation;
+	bool all_vcpus_matched_tsc;
 	int nr_vcpus_matched_tsc;
 
 	u32 default_tsc_khz;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bbd642e0dc54..ac66f8e7116f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2651,8 +2651,10 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu, bool new_generation)
 	 * and all vCPUs must have matching TSCs.  Note, the count for matching
 	 * vCPUs doesn't include the reference vCPU, hence "+1".
 	 */
-	bool use_master_clock = (ka->nr_vcpus_matched_tsc + 1 ==
-				 atomic_read(&vcpu->kvm->online_vcpus)) &&
+	ka->all_vcpus_matched_tsc = (ka->nr_vcpus_matched_tsc + 1 ==
+				     atomic_read(&vcpu->kvm->online_vcpus));
+
+	bool use_master_clock = ka->all_vcpus_matched_tsc &&
 				gtod_is_based_on_tsc(gtod->clock.vclock_mode);
 
 	/*
@@ -2837,6 +2839,7 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 		kvm->arch.cur_tsc_write = tsc;
 		kvm->arch.cur_tsc_offset = offset;
 		kvm->arch.nr_vcpus_matched_tsc = 0;
+		kvm->arch.all_vcpus_matched_tsc = false;
 	} else if (vcpu->arch.this_tsc_generation != kvm->arch.cur_tsc_generation) {
 		kvm->arch.nr_vcpus_matched_tsc++;
 	}
@@ -3177,8 +3180,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 	bool host_tsc_clocksource, vcpus_matched;
 
 	lockdep_assert_held(&kvm->arch.tsc_write_lock);
-	vcpus_matched = (ka->nr_vcpus_matched_tsc + 1 ==
-			atomic_read(&kvm->online_vcpus));
+	vcpus_matched = ka->all_vcpus_matched_tsc;
 
 	/*
 	 * If the host uses TSC clock, then passthrough TSC as stable
-- 
2.54.0

