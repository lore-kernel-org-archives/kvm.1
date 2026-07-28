Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E529466AE7;
	Tue, 28 Jul 2026 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250225; cv=none; b=Yvulo7+sz5aI9JAXRuExg3H2htwlXzexhJDk1VF7gWoXhnc5yGMRfXsuy2pnVH5X564aJ/38iydgDCOhH8HFjewFiRNdfPWFOfs/y9u9iftpDFUiuluH47fOWWl0nUcw/t+1BDKPgNfRDFkdB3hXtXReEOBLd4wCjE6NN+4hEGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250225; c=relaxed/simple;
	bh=dgicJ8ND9Z3KMJow0H9LD6jSy5hYfn/p4DlMubpeHL0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KijFg+M312V9Uv/LZhTpyrRGhaFtgEDoPU5fSykIElg45RLk3WKGZ0IWtMYEdVt0X+PtJ+asFJvXS6c8YunAcNtFIzL7hX1OjATqojNiEfAHc3ijMgt/jQyQrdv91num10aiPa5PpIb24Yzj+a+LuYzExbTdKY29ccfloil/xDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V7Ehwcw9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V7Ehwcw9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=1Yco73wB/YAFQVFh4qtx3O3nsbhsRJaJSFcRl6aWB0A=; b=V7Ehwcw9eOAULq/s5oipFIX68F
	dC6GgzpKNZbbxDDcVdmqRpaKbDG4gz2XtW2HSqVZ59+FAUfV4SMVr79ynEcIBuzSnDaMD1w8p+d85
	5xjRhx74GdZ256bIKWGpLlkIkTnZMUXICHb4uBu1hs7UiJnYHK9lbmxxvqtFhiLcv7AhFgQ3FWjhp
	eJxe276SjXTMQXwuTuBWJEjs6vyOR4NpGWk6rUR7wx7HF8S6hgHkx6Qiu0Tpt4CzYc+xRXJaHbEdi
	nQIcA+ExBUQNC759eZc5Rd8KUb7Tho/WALx/OycRhV/GO22Au2ATGfiOx+720FIDv3AkvszzylVad
	SlXbDBPw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1woj82-000000052VW-34Y5;
	Tue, 28 Jul 2026 14:50:09 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1woj7z-00000001UXv-0HsP;
	Tue, 28 Jul 2026 15:49:55 +0100
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
Subject: [PATCH v7 02/36] KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
Date: Tue, 28 Jul 2026 15:39:42 +0100
Message-ID: <20260728144954.355376-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728144954.355376-1-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
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
 arch/x86/kvm/svm/svm.c |  3 ++-
 arch/x86/kvm/vmx/vmx.c | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d68cba12c772..d7fb98a2aaa2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5624,7 +5624,8 @@ static __init int svm_hardware_setup(void)
 				     XFEATURE_MASK_BNDCSR);
 
 	if (tsc_scaling) {
-		if (!boot_cpu_has(X86_FEATURE_TSCRATEMSR)) {
+		if (!boot_cpu_has(X86_FEATURE_TSCRATEMSR) ||
+		    !boot_cpu_has(X86_FEATURE_CONSTANT_TSC)) {
 			tsc_scaling = false;
 		} else {
 			pr_info("TSC scaling supported\n");
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e4b9ac7fed9f..d553537004cf 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2838,6 +2838,16 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	if (!cpu_has_sgx())
 		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_ENCLS_EXITING;
 
+	/*
+	 * KVM doesn't re-derive the TSC scaling ratio when the host TSC
+	 * frequency changes, so TSC scaling is only usable with a constant
+	 * TSC.  Clear the control here rather than in vmx_hardware_setup() so
+	 * that the per-CPU configs recomputed by vmx_check_processor_compat()
+	 * stay consistent with the golden vmcs_config.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_CONSTANT_TSC))
+		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_TSC_SCALING;
+
 	if (_cpu_based_exec_control & CPU_BASED_ACTIVATE_TERTIARY_CONTROLS)
 		_cpu_based_3rd_exec_control =
 			adjust_vmx_controls64(KVM_OPTIONAL_VMX_TERTIARY_VM_EXEC_CONTROL,
-- 
2.55.0

