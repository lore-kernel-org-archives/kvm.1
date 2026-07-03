Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E4378823;
	Fri,  3 Jul 2026 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113851; cv=none; b=WfZg2dhmWdHIrXqAUjY2CmmRk5AcB+pmPMvLZa/9u8bml2AySDKInIuX6iZ/YTt7Oq5p4EzGcTZxgx9oT9sgJeQ0nskFhLKW2FQr1wncigmx6o+8381L8Cf2ePcg+8WdAq2PInsWhXw/Hw7ttnHAUIkneRSk252cLruqXclRugc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113851; c=relaxed/simple;
	bh=5XB+J5ywatugNxZFwR7i7v9emIB74TN16yRrCdND+WU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6NdLbXKsswoZHg0i9r8auVaNmyjz8hreoYcb+eN1iDqPBaqDjQEyuqPQMN7BBIM2r3d0D1gBJZnUvdlBylhECXRI+tjww4FdFjcynRFyMcdkZ5y40Lq6tTc4KNg1gRYlMCx69Wbrr6oWd7ouU0hynPNoxeaY3PK1XFPa/rK18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L06h6XB7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L06h6XB7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=XAeJCQ+9v+mDSYHMRAWw2uzIOBs6a2aQ/+qu99zPeWk=; b=L06h6XB7ChTw5JFuRa1oGPYKJD
	pa/C7Tzgjlg4/j8Xcz0xLWravurCFkrPEx8W3oxblz5pXyRuuOucw0AfVSQ49G8Z2gokwtlVqRpUZ
	76hF5gEabMj2GhEiYzS+cxTluSHaQJf3VqmfsdAaBGUby6HcIzGDTJx1nTtkYwrlAiBOzKKn/OJLk
	NsB+IqXwT26+U20Jo6IPUmvncGBzgomgyfc+lfqu+HJCe1B3oMqqyDWXnWGzjpdTw3Yw4pvvAdIDe
	NWCOKCuauAg+5mLGmvv2MuV/AJ4pY0kVq9SZWRoaSGeGhhLb4lcny8uw6kw5j20BInWSG2/SHbvPx
	3UEsgyoQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKd-000000059Nx-0xnf;
	Fri, 03 Jul 2026 21:23:38 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKW-00000001ROD-0TOT;
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
Subject: [PATCH v6 07/36] KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
Date: Fri,  3 Jul 2026 22:17:46 +0100
Message-ID: <20260703212145.343527-8-dwmw2@infradead.org>
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
index e02a38da5296..c46a34aeb3df 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5557,7 +5557,8 @@ static __init int svm_hardware_setup(void)
 				     XFEATURE_MASK_BNDCSR);
 
 	if (tsc_scaling) {
-		if (!boot_cpu_has(X86_FEATURE_TSCRATEMSR)) {
+		if (!boot_cpu_has(X86_FEATURE_TSCRATEMSR) ||
+		    !boot_cpu_has(X86_FEATURE_CONSTANT_TSC)) {
 			tsc_scaling = false;
 		} else {
 			pr_info("TSC scaling supported\n");
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b9103de01428..54e92d94155e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2792,6 +2792,16 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
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
2.54.0

