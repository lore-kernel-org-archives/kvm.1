Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671A443D4F8;
	Mon,  8 Jun 2026 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930538; cv=none; b=hts2ien6CHI9a4OypQzJ0Fqkkocf/BREfgP4GoR4TEL2rxzlriI4eKUgek5McilHvhxxZf/owjKYD8BvAxH6sEbyM4AEuOcTng4/5Xp1lLV5yyjy+TatYenWHLDUJ+1K9SuKH1a7eU3931PTdiWLrAeb9179sQh2ViDeyjfEpYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930538; c=relaxed/simple;
	bh=3PF+I1mGpZzeyNj4qFTXaeBU3x3qjVckxT8pulPTQ4o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chmgYFLDSRWrmM+NH2IDWffacqDqRnLysLKoH7gtsjvpD4fjiHHTTslhkvlCR1xfvhFEBbhAkd6D2X6+GjNiAZiR5QSLryuWuxtasubV8sAG3FI9Octk5it6Jc4td9xU2E/J8SepOzfACc8TCoaAgWPm0RBx4K6HweJRWCFGeLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=upKvM4mr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="upKvM4mr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=kmXiitnSRUwEV6tPjvXxCrsAzGUuV+8SMjnRuSsAfbI=; b=upKvM4mru9iTXS4LtuodoQr3O7
	eH8eJEEzfTSmKawhDNYywuN5Fc+EhdCFOZOLZN41PAS1m/7o4wybNoX2pVIq00YYgtNjOdpjNk/bT
	w6xZK5J20UhUOGa4ConrVw5wGP3C2HNrg4KzW9s2aLdaFB7Khb7b8kLJWIF9+0wHXhd/TZVw9H8eh
	jkdEWjp9iKK4RBFT0WMlVBBzUK9zEglvNDtbkGVBwAdqHWIbYxuFk/wrCP/Zk9Siw0RrGEMps/jDV
	LoyxYP549CTgy3caIpf36/2b9QoFEhgSAgOMVLGyR8f22DTiCK1aZ7z8BFlOEyRcYetYtTNrRQviN
	21Ox5wOw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWbNR-0000000Dtx8-31m6;
	Mon, 08 Jun 2026 14:54:58 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNR-00000000NEn-2XC4;
	Mon, 08 Jun 2026 15:54:57 +0100
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
Subject: [PATCH v5 06/34] KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
Date: Mon,  8 Jun 2026 15:47:47 +0100
Message-ID: <20260608145455.89187-7-dwmw2@infradead.org>
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

KVM does make an attempt to cope with non-constant TSC, and has
notifiers to handle host TSC frequency changes. However, it *only*
adjusts the KVM clock, and doesn't adjust TSC frequency scaling when
the host changes.

This is presumably because non-constant TSCs were fixed in hardware
long before TSC scaling was implemented, so there should never be real
CPUs which have TSC scaling but *not* CONSTANT_TSC.

Such a combination could potentially happen in some odd L1 nesting
environment, but it isn't worth trying to support it. Just make the
dependency explicit.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 arch/x86/kvm/svm/svm.c | 3 ++-
 arch/x86/kvm/vmx/vmx.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e7fdd7a9c280..7817752533fe 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5546,7 +5546,8 @@ static __init int svm_hardware_setup(void)
 				     XFEATURE_MASK_BNDCSR);
 
 	if (tsc_scaling) {
-		if (!boot_cpu_has(X86_FEATURE_TSCRATEMSR)) {
+		if (!boot_cpu_has(X86_FEATURE_TSCRATEMSR) ||
+		    !boot_cpu_has(X86_FEATURE_CONSTANT_TSC)) {
 			tsc_scaling = false;
 		} else {
 			pr_info("TSC scaling supported\n");
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a29896a9ef14..ed207cc7692d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8672,7 +8672,7 @@ __init int vmx_hardware_setup(void)
 	if (!enable_apicv || !cpu_has_vmx_ipiv())
 		enable_ipiv = false;
 
-	if (cpu_has_vmx_tsc_scaling())
+	if (cpu_has_vmx_tsc_scaling() && boot_cpu_has(X86_FEATURE_CONSTANT_TSC))
 		kvm_caps.has_tsc_control = true;
 
 	kvm_caps.max_tsc_scaling_ratio = KVM_VMX_TSC_MULTIPLIER_MAX;
-- 
2.54.0

