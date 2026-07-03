Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C1F32143D;
	Fri,  3 Jul 2026 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113726; cv=none; b=lm4B8y6L+bb7nmhK9IvAvTgtcCYBszcXG3Nl+Cc07HxtsiXV6EZVCms1yJ9yJ9awIFIoLpjG131cfXTEISfmZCeHtuIY7bYpIBdLz/+5Cx7WeubGaKRIBf0213vbnSIaq/3gChTpqbn6clFyVaaYxwo4v5DjAVVG85jcBvnj7K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113726; c=relaxed/simple;
	bh=lEF++bOI9LQfD57eTioGvJkH8QvoBPOp3vTuT0g71Gc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYRIYVKNt0bdvkCIpvSVgMXNGbjpMVsIGX9iEB0vbX+L2tBV6j4XIQSFBYncoxBzyqMJPFHGznNxnU92VHr/E+QEzfCkvUmgkUjX5xI6VXVkAnqJFtKY5oGvjtkC2v/VEz3qzNy3YMuAUEGDR8GsIiPPJaOlcUV74l5IuILaqwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fcUVvHAI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fcUVvHAI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=9YLu6jUxizeyw6FPvXNgLWAHtpjzd7Ja/IQI9k+fk+s=; b=fcUVvHAIPPdYkE7/dYS8PsNO0M
	0l7rKpCfaWyv7qnO627IUm/45JZzCNXpKFxdSx3aOe4X/asoyK1w+W3ZNk66BM8q3BbjYRzGNQLNV
	FIOdbKNq2+NaKcooJ/SV2aSPahIzidPDXtyB92+iE1701oAJYZIobMAgIC8rg0p2P6qLAa9eY/PVl
	/pGKXDoXfX1z+5rZmDtJJ9Wv34vMFTG3iFXgK7vu2PgYTbtbFTcJhelUV/ioie3vUIgVLGidMeVnR
	PeaxJ2Y8zB3aSgCvh1ZPeMDKjka+OYRslMm979N9HKfPZmmsO4HL0U8OnTYlA/VVYGrcVlh/JcdzD
	AnicB8aQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wflKX-0000000AsYS-3lGH;
	Fri, 03 Jul 2026 21:21:50 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKX-00000001RQI-3LPT;
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
Subject: [PATCH v6 36/36] KVM: x86: Activate master clock from kvm_arch_init_vm()
Date: Fri,  3 Jul 2026 22:18:15 +0100
Message-ID: <20260703212145.343527-37-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703212145.343527-1-dwmw2@infradead.org>
References: <20260703212145.343527-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Initialize the TSC generation and master clock state at VM creation
time, rather than relying on kvm_update_masterclock() from
kvm_arch_vcpu_postcreate().

Set cur_tsc_generation=1, cur_tsc_khz, cur_tsc_scaling_ratio,
cur_tsc_offset, cur_tsc_nsec and kvmclock_offset from an atomic
ktime/TSC snapshot. This establishes a coherent epoch so that:

 - The first vCPU synchronizes to the existing generation (getting
   the pre-computed TSC offset) rather than computing its own.
 - pvclock_update_vm_gtod_copy() succeeds immediately (no zero
   tsc_hz from uninitialized cur_tsc_scaling_ratio).
 - KVM_GET_CLOCK returns valid {host_tsc, realtime} fields as soon
   as any vCPU exists.
 - KVM_[GS]ET_CLOCK_GUEST works without a prior KVM_RUN.
 - No O(N) iteration of all vCPUs on each vCPU creation.

This replaces the kvm_update_masterclock() call that was added to
kvm_arch_vcpu_postcreate() to work around the missing initialization.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro (claude-opus-4.6-1m)
---
 arch/x86/kvm/x86.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 58016af64932..d35f2ac3ef49 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13161,8 +13161,6 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 		return;
 	vcpu_load(vcpu);
 	kvm_synchronize_tsc(vcpu, NULL);
-	if (!vcpu->kvm->arch.use_master_clock)
-		kvm_update_masterclock(vcpu->kvm, NULL);
 	vcpu_put(vcpu);
 
 	/* poll control enabled by default */
@@ -13572,6 +13570,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
 	int ret;
 	unsigned long flags;
+	u64 kvmclock_host_tsc;
+	s64 kvmclock_ns;
 
 	if (!kvm_is_vm_type_supported(type))
 		return -EINVAL;
@@ -13603,18 +13603,47 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	seqcount_raw_spinlock_init(&kvm->arch.pvclock_sc, &kvm->arch.tsc_write_lock);
 	ratelimit_state_init(&kvm->arch.kvmclock_update_rs, HZ, 10);
 	ratelimit_set_flags(&kvm->arch.kvmclock_update_rs, RATELIMIT_MSG_ON_RELEASE);
-	kvm->arch.kvmclock_offset = -get_kvmclock_base_ns();
-	kvm->arch.all_vcpus_matched_freq = true;
-
-	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
-	pvclock_update_vm_gtod_copy(kvm);
-	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
 
 	kvm->arch.default_tsc_khz = max_tsc_khz ? : tsc_khz;
 	kvm->arch.apic_bus_cycle_ns = APIC_BUS_CYCLE_NS_DEFAULT;
 	kvm->arch.guest_can_read_msr_platform_info = true;
 	kvm->arch.enable_pmu = enable_pmu;
 
+	kvm->arch.all_vcpus_matched_freq = true;
+	kvm->arch.all_vcpus_matched_tsc = true;
+	kvm->arch.cur_tsc_scaling_ratio = kvm_caps.default_tsc_scaling_ratio;
+	kvm->arch.cur_tsc_khz = kvm->arch.default_tsc_khz;
+
+	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
+
+	/*
+	 * Establish the initial TSC generation for synchronization logic.
+	 * The first vCPU will sync to this, starting its guest TSC at the
+	 * number of cycles elapsed since VM creation rather than at zero.
+	 * This ensures coherence with the kvmclock epoch (also set here)
+	 * and means the master clock snapshot taken below is immediately
+	 * valid — no need to redo it at first vCPU creation.
+	 */
+#ifdef CONFIG_X86_64
+	if (!kvm_get_time_and_clockread(&kvmclock_ns, &kvmclock_host_tsc))
+#endif
+	{
+		/*
+		 * If not simultaneous, we want the TSC to be zero slightly
+		 * *after* the kvmclock is zero.
+		 */
+		kvmclock_ns = get_kvmclock_base_ns();
+		kvmclock_host_tsc = rdtsc();
+	}
+	kvm->arch.cur_tsc_write = 0;
+	kvm->arch.cur_tsc_offset = -(s64)kvmclock_host_tsc;
+	kvm->arch.cur_tsc_nsec = kvmclock_ns;
+	kvm->arch.cur_tsc_generation = 1;
+	kvm->arch.kvmclock_offset = -kvmclock_ns;
+
+	pvclock_update_vm_gtod_copy(kvm);
+	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
+
 #if IS_ENABLED(CONFIG_HYPERV)
 	spin_lock_init(&kvm->arch.hv_root_tdp_lock);
 	kvm->arch.hv_root_tdp = INVALID_PAGE;
-- 
2.54.0

