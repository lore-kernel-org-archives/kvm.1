Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF0D34388A
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855646; cv=none; b=SvUXLPRQDyGQPVwhamyxygcz13ULxVMOnoES9YUzGfGA7XzFmBydk269suf2/DGZlK5uUn7Wn6z0g9B40CrtsTjAqkq0K4lyH/WicwIV/UtC+xPqfIDOWzH/EbhWA1VQGTxN673cnQQx0XKayJ5zlgGnDMS2YyoloJRpgBOKgrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855646; c=relaxed/simple;
	bh=Z45g6ghkzOYwxx5rhXxFjZaZo1MTdcv9qwbbrGdG5zo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=jQcMXRI5JuOmaONLfuf5JWPTHUlglhEDhLEY0EifPdU/n0rTZp40dGhVM7nAl7qbiW5aP5YDAh5qjfZ7r8m3YVg2Nk89TFKckzM8PlIDRdNAM0zEISrMdYyIsV/HlFqLZuhM8MU+FJ0a69CowlVqgMjyJ5AubGemS9dlaVMUENc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=KiPBHERn; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="KiPBHERn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785855632;
	bh=TpcfvrmAhefdvJeklAJjCf+ikb9KwpKOVaNJB3y0pm0=;
	h=From:To:Cc:Subject:Date;
	b=KiPBHERnho1lQQ5WEivIHmvLMii0+vNVjy6ld0+0tO9kflM7vUAhk0P6LC3MLPMvD
	 nSGdawtRECXK/M37G7/Xm4WjsNnK7rNXwxpcJwPANsa9IWNkHGBMLxElY/atmCoa9/
	 8gQIxk5JZcoZbLouzZ+PV9A3TznZcJ5vxq4cS3y0=
Received: from VM-0-7-ubuntu.. ([101.35.250.50])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 1EACA85; Tue, 04 Aug 2026 23:00:30 +0800
X-QQ-mid: xmsmtpt1785855630tkppyq45d
Message-ID: <tencent_DDC4E4352EC91CAC05A9A8F4E55E8C96730A@qq.com>
X-QQ-XMAILINFO: NnIX2CK8LSsJ1UtCVkEHblRA3yXj5OWPacqhtGsUt/8lRcihNok8+rcgTM1nxY
	 g9dd7L5f8TYHTs7lHaodiwQYkKz4lcYBe+UVVV4m9JzyRS+ycQuRakpjDcq4QXIFxBK+YiE9YeIz
	 ccWzDOy+TcEbgvNwvpkxPMIZTndGQfd6S9SkbX2TxD8OpWBS2CBRHo+lW4ujV4b7Ji9JsQINFDvl
	 HL22ingCtpnkhShWC2JFNxKOzWwBNttvmaa8WYDMcNtXlxbjfB7ejesaRlZTBOGnveL4006KIkey
	 m5WTjR5k5KwFBV3O1MBaOB0DNX4DvNAE2UkZ3wZftjmUWSIGwq/RrpZoJ272TaQd9ofTEPHdt1nA
	 mL9dmrH/LGDVOXFhH4bZuajcmn9iyzZnBM4jZNXx1qiGPXGirP6yqv/uQfMDlaiLcP76mOrmg2CD
	 ZZZaH7uQFS8/Cl27o7wW3wPOE0xmHkMmu3oif9RMANDDcG1q3/zN1MInaDeekHMXw/OU5pHJW6Cj
	 WRCV2zIZc5LYDvy7guED+Og/75y533IE3lVNsNTzaqNIr9Vn1baLgnIFCH7eivG6ufHQF7R+y+rg
	 TOgyOw9Ms4rxcs6SMkSFztuGWqdNHJT7j6/w0xHLycvTG4NMEfobXdbvkE0UaWGw05CgHMeVQxjq
	 kQ6EgLKeLFYtpqxIs2zgfROY+d31MTzJo3f/8rnvdYuCdWR/8ys2OxGhip6i2pSjKmjPghDAa9+s
	 2kl8/BNg++r4V9bAtDujBkyxmBkiKAvscsrWUjid94PvrTjau9W6sqk6sntUeLnjRlPhf/vJr9cx
	 vnaLBrJgO6TuhOuG0s5KMj6KzhGBWi5GlzQCUYUwC8/GJ8tEfpzLxOpsQUv3R5cElhEJL3FdLFhX
	 KUbIJEoPrki2x+xM4eKa4DYXYoVae228H/VEOIp3I//RlQAon0ihFryx7W64sy9nagLicRLDlBWh
	 KNjRwYyImtW+CnsLD4vfkgzhggIRVVBa4F4Ypi1x8M8tKd6kAtf0pQR7znqFzlH+Vkvl2zQlgD4K
	 jXvsy6YJAQeFNPAmAO3qKa3Phxc5YmwdnpdKTMyqv+cTsH0Kg74BKDH+y53y+/5Lyj18p+usMePm
	 CVA3N0wVDMuJ7+inZN4EqUuyOj473MOI/cJrtn
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Shen Yongchao <grayhat@foxmail.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Shen Yongchao <grayhat@foxmail.com>
Subject: [PATCH 2/2] KVM: SVM: Re-check enc_context_owner under the owner's lock in sev_vm_destroy()
Date: Tue,  4 Aug 2026 23:00:30 +0800
X-OQ-MSGID: <20260804150030.768170-1-grayhat@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sev_vm_destroy() reads the mirror KVM's enc_context_owner without any
synchronization and then locks the returned KVM.  A concurrent
KVM_SEV_MIGRATE_VM (sev_migrate_from()) transfers this mirror's
reference to a new owner under the current owner's lock, so the
previous owner can be freed between the unlocked read and
mutex_lock(): the mirror's final reference can be dropped while
sev_vm_destroy() is about to dereference the owner, dropping the
owner's reference count below its true value so that kvm_destroy_vm()
runs while the owner's fd is still open.

All kernels with SEV mirroring and intra-host migration support
(KVM_SEV_MIRROR_CREATE / KVM_SEV_MIGRATE_VM) are affected.  The mirror
list mechanism was introduced by commit b2125513dfc0 ("KVM: SEV: Allow
SEV intra-host migration of VM with mirrors", v5.18, 2022-02-18);
upstream mainline is unfixed as of 2026-08-04.  Triggering requires an
AMD SEV-capable host with CONFIG_KVM_AMD_SEV and a local user able to
create an SEV VM plus an SEV mirror VM, racing close() of the mirror
against KVM_SEV_MIGRATE_VM on the owner (function-level window,
deterministically reachable with a close(fd) primitive).

Take the owner's lock and re-check enc_context_owner: if it changed,
the migration already moved the mirror entry and the reference to the
new owner, so retry with the new owner.  The owner cannot be freed
while the mirror holds a reference to it, or while a migration that
takes the reference over holds the owner's file reference.

This patch was drafted with AI assistance.

Fixes: b2125513dfc0 ("KVM: SEV: Allow SEV intra-host migration of VM with mirrors")
Cc: stable@vger.kernel.org
Assisted-by: Hermes:deepseek-v4-flash
Signed-off-by: Shen Yongchao <grayhat@foxmail.com>
---
Reproducer: static analysis only (no SEV-capable hardware available);
no reproducer has been run.  The triggering sequence is described in
the commit message.

Mitigations: none; SEV is an optional platform feature and the attack
requires a local user with SEV VM creation privileges.  The list-side
window that remains when a mirror destroy races a migration of the
owner is serialized by patch 1/2 of this series.
 arch/x86/kvm/svm/sev.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 4fa4e9bf408..9cae4c1eeda 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2969,9 +2969,31 @@ void sev_vm_destroy(struct kvm *kvm)
 	 * Note, mirror VMs don't support registering encrypted regions.
 	 */
 	if (is_mirroring_enc_context(kvm)) {
-		struct kvm *owner_kvm = sev->enc_context_owner;
+		struct kvm *owner_kvm;
+
+		/*
+		 * sev_migrate_from() can transfer this mirror's reference to a
+		 * new owner while holding the current owner's lock.  Take the
+		 * owner's lock and re-check enc_context_owner: if it changed,
+		 * the migration already moved the mirror entry and the reference
+		 * to the new owner, so retry with the new owner.  The owner
+		 * cannot be freed while this mirror holds a reference to it, or
+		 * while a migration that takes the reference over holds the
+		 * owner's file reference.
+		 */
+		for (;;) {
+			owner_kvm = READ_ONCE(sev->enc_context_owner);
+
+			/* Defensive; mirrors always hold an owner. */
+			if (!owner_kvm)
+				return;
+
+			mutex_lock(&owner_kvm->lock);
+			if (READ_ONCE(sev->enc_context_owner) == owner_kvm)
+				break;
+			mutex_unlock(&owner_kvm->lock);
+		}
 
-		mutex_lock(&owner_kvm->lock);
 		list_del(&sev->mirror_entry);
 		mutex_unlock(&owner_kvm->lock);
 		kvm_put_kvm(owner_kvm);
-- 
2.43.0

