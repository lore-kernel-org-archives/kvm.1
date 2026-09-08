Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1D7513565;
	Tue,  8 Sep 2026 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863626; cv=none; b=NvqGx6PYCxYG5WKWRaDYOqol547BnPvgcUp6Byp0RD1dOwxMbO+4SG4ADL/SYqzGWnnTkIQKJDnqs11cUXjTuacOF39rXGEeNtSQiKEOTnxIMCccX2Eqhb7rcifDQKaoqhQcL0nXvkQEvPKmkI2xVN74lGSTMfC5NjObOSPEt94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863626; c=relaxed/simple;
	bh=3U1p75q0QikEpCOFC6SMg7yKgMt6FVSnWoRhJCHVLQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HriadWktAVALVzYz7c7BdxdfBGyYG/70ipG+KBrumrd5SOyzOK8WFnUNVvkbJNp1g/E4/K/JXcWN3Dy2K3Az6t/j8jtRjtNrrZNYEbmIgCvSPwqznboLDA8gR7Zt+QgchWM/IW5p/x7fMLAoNcrYjwO2gQV1fEbm1idg1zoNpfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.fritz.box (p200300f6af085a00d84fb33a51badfd9.dip0.t-ipconnect.de [IPv6:2003:f6:af08:5a00:d84f:b33a:51ba:dfd9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0C42F20A1D8;
	Tue,  8 Sep 2026 12:33:41 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Michael Roth <michael.roth@amd.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Ninad Naik <ninadnaik07@gmail.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	coconut-svsm@lists.linux.dev
Subject: [PATCH v2 1/8] KVM: SEV: Document SNP direct VMSA userspace ABI
Date: Tue,  8 Sep 2026 12:33:31 +0200
Message-ID: <20260908103338.427254-2-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908103338.427254-1-joro@8bytes.org>
References: <20260908103338.427254-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Document the VMSA launch-update page type, the vCPU-scoped state get and
set commands, and the VM-scoped direct-VMSA capability in one place.

Describe the ordering and argument requirements for enabling direct-VMSA
mode, and contrast its VMSA allocation and measurement behavior with the
legacy launch flow.

Assisted-by: LLM
---
 .../virt/kvm/x86/amd-memory-encryption.rst    | 66 ++++++++++++++++++-
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/x86/amd-memory-encryption.rst b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
index bd04a908a8db..427b673c3832 100644
--- a/Documentation/virt/kvm/x86/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
@@ -536,6 +536,7 @@ Returns: 0 on success, < 0 on error, -EAGAIN if caller should retry
 where the allowed values for page_type are #define'd as::
 
         KVM_SEV_SNP_PAGE_TYPE_NORMAL
+        KVM_SEV_SNP_PAGE_TYPE_VMSA
         KVM_SEV_SNP_PAGE_TYPE_ZERO
         KVM_SEV_SNP_PAGE_TYPE_UNMEASURED
         KVM_SEV_SNP_PAGE_TYPE_SECRETS
@@ -544,7 +545,68 @@ where the allowed values for page_type are #define'd as::
 See the SEV-SNP spec [snp-fw-abi]_ for further details on how each page type is
 used/measured.
 
-20. KVM_SEV_SNP_LAUNCH_FINISH
+``KVM_SEV_SNP_PAGE_TYPE_VMSA`` creates VMSA pages as part of the measured
+initial image.  A request must contain exactly one 4 KiB VMSA page, but the
+command may be used multiple times.  Creating a VMSA page does not associate it
+with a vCPU; use ``KVM_SEV_SNP_SET_VCPU_STATE`` on the intended vCPU file
+descriptor before launch finish to make that association.  KVM treats the
+VMSA contents as guest-owned data, but requires VMPL 0 and a ``sev_features``
+value that matches the VM's configured VMSA features.
+
+20. KVM_SEV_SNP_GET_VCPU_STATE / KVM_SEV_SNP_SET_VCPU_STATE
+------------------------------------------------------------
+
+These commands get or set the VMSA and GHCB addresses for the vCPU on whose
+file descriptor the command is issued.  Unlike the other SEV commands,
+userspace must issue KVM_MEMORY_ENCRYPT_OP on a vCPU file descriptor.  The
+capability is reported as ``KVM_CAP_SNP_VCPU_STATE``.
+
+Parameters (in/out): struct kvm_sev_snp_vcpu_state
+
+Returns: 0 on success, -negative on error
+
+::
+
+        #define KVM_SEV_SNP_VCPU_STATE_VMSA_VALID        _BITULL(0)
+        #define KVM_SEV_SNP_VCPU_STATE_GHCB_VALID        _BITULL(1)
+
+        struct kvm_sev_snp_vcpu_state {
+                __u64 valid_fields;
+                __u64 vmsa_gpa;
+                __u64 ghcb_gpa;
+                __u64 pad[5];           /* Must be zero */
+        };
+
+``KVM_SEV_SNP_GET_VCPU_STATE`` returns the current addresses and sets the
+corresponding bit in ``valid_fields`` for each valid address.
+
+``KVM_SEV_SNP_SET_VCPU_STATE`` sets addresses whose validity bits are present
+and invalidates addresses whose bits are absent.  The command must be issued
+after launch start and before KVM_SEV_SNP_LAUNCH_FINISH, and the VM must have
+enabled ``KVM_CAP_SNP_DIRECT_VMSA``.  A valid VMSA GPA must be backed by
+guest_memfd and populated.  The GPA must be 4-KiB aligned.  A valid GHCB
+address is copied without inspecting its backing page.  Nonzero reserved
+fields or unknown validity bits are rejected.
+
+``KVM_CAP_SNP_DIRECT_VMSA`` is a VM-scoped capability that selects direct-VMSA
+mode.  Userspace enables it with ``KVM_ENABLE_CAP`` on an SNP VM before
+creating any vCPUs.  ``flags`` and all elements of ``args`` must be zero.
+Enabling the capability on a non-SNP VM or after creating a vCPU is rejected.
+
+In direct-VMSA mode, KVM does not allocate a KVM-owned VMSA when a vCPU is
+created and does not generate or measure one at launch finish.  All launch
+VMSAs are owned and supplied by userspace.  Valid VMSAs selected with
+``KVM_SEV_SNP_SET_VCPU_STATE`` are preserved, while vCPUs without a valid VMSA
+have no runnable VMSA until the guest uses SNP AP creation to supply one.  If
+the capability is not enabled, launch finish retains the legacy behavior of
+generating and measuring a KVM-owned VMSA for every vCPU.  VMSAs that were
+measured but not selected remain ordinary valid pages in the initial image.
+
+Direct VMSAs make the launch measurement independent of KVM's selected VMSA
+GPA and of the configured vCPU count.  This gives VMMs a stable launch
+measurement across hypervisors.
+
+21. KVM_SEV_SNP_LAUNCH_FINISH
 -----------------------------
 
 After completion of the SNP guest launch flow, the KVM_SEV_SNP_LAUNCH_FINISH
@@ -572,7 +634,7 @@ Returns: 0 on success, -negative on error
 See SNP_LAUNCH_FINISH in the SEV-SNP specification [snp-fw-abi]_ for further
 details on the input parameters in ``struct kvm_sev_snp_launch_finish``.
 
-21. KVM_SEV_SNP_ENABLE_REQ_CERTS
+22. KVM_SEV_SNP_ENABLE_REQ_CERTS
 --------------------------------
 
 The KVM_SEV_SNP_ENABLE_REQ_CERTS command will configure KVM to exit to
-- 
2.53.0

