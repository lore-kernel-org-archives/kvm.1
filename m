Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06734562A2
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855288; cv=none; b=u9SiFGkFC6NuOypJoXUEEB0Pak9Ogz9ku2kHxA2WKYNXWOve0IeBOaawbOqzp4aXHVcpkE+eR8aFGOSSSEe2TronybKgx+efrYfMSnd1HV55XWy4AoMtRNI1i1w+e7D+rNYlXitKweaFCuyztpi0qPcV1RFw0aQ22wkSve1QHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855288; c=relaxed/simple;
	bh=gcbq7gS87F6X2amgoOjqADD8qzSULoikUzvg0wE6tdc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=iAUUMorwa03R6GrXawZSWxXOpOAibRPE8zYtTjTsNmPpZqmNzJ9NnJ3dSENUocqCYMNsiR5Qij+WyOm5v+7bnQA/DXnRKbHJJJ9dqkgamvSLFwaqvMehUXFK89GOf4T+rmo65vfmCe0VvRtbudSxW1FsnLvUTCww/yUbJTkyp5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=RQ/lJbod; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="RQ/lJbod"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785855274;
	bh=xUgvBvReY4eP3SeenurPLuYL05CIYPmlT43QtAoByPA=;
	h=From:To:Cc:Subject:Date;
	b=RQ/lJbodvJ/hVTIGvZda1Am7L4UtU8nCJgXIxaFyYYd/IW89kDzjn9ltKbf8/eB7J
	 1oPD9nrny/8XyyV4UiXhWE78rPQ0M5W8CCI4jGGi4ehyCpyz4GS2JHSz+4eI2bSqpw
	 MvMYm3y40B2J/j9QKpatkOCLeqclpcbm6dhw+3wA=
Received: from VM-0-7-ubuntu.. ([101.35.250.50])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id DA084A0B; Tue, 04 Aug 2026 22:54:32 +0800
X-QQ-mid: xmsmtpt1785855272tnflqrual
Message-ID: <tencent_625C0F42824E542C72B34733392AF2C49709@qq.com>
X-QQ-XMAILINFO: ONXjbYTFhCz0Mmz9GHmO3LiWL0WjWei7ho60awZqrjeAxeqS0zBO0JKzV/4uOq
	 x7sAMaTH8iGGYSLnaZdVFdWbqXD36ycXRT1wO4u9nzPm5YMaSAg3d9tlKzQ7dli/H17HLtLz5HGt
	 s3Z6EpRjgH99FpIqKN6VyV6XZUO2XcFAezRv9Xr+nJ7N3IBt9D0OwH7PL+xTt8P9gpBhfSgyjQqd
	 7mwO/NCC400+WvdseJ4Z0dzjslIRYprn8KgFQyGVHxx/+UWBh+RGKDPmxdTd1SBanZGUAfLCe+Mu
	 FDmZuXWFLjLyMofZ45A4OiLzEBvNJ409axmowWcRj1j0cO2mjJJCSb8a/UiqSY6/vTKCTB7sTjG5
	 wtO1GH0ezC8XwLnfm5Mk03FHXhKDLU+oG8WBxs3ioe9adO5Op8ynwtKjkNLGSMpHtpCd9ZersnJS
	 o9oLC+4hOH08Ni7yqHALjNv0kjmgr2K5t8PdcrKWstlXERei+TqkkuQRRag8VaGoou0lotROTOPA
	 AAz1OmCXvOqT1uRsMs6gkdt3LaScq+iKhGK3hwje2frMLjtUZlfOwnJ1M9o0jkrhexBsFn5Bxyxs
	 5CNvkxtU65GjzYZuzzuuveyC6TLjGCfAp0dElkG7Q/NPNGY1OzFVhcvQRMWXdw+kclPuEzNP1G2H
	 U7G6dvWNk6SkiKsYW2sfM61rdbG80zA5nuog9D0JREFcP+EWCEgGVLnIZB9GCwXJGzfuUGTZGf2N
	 6hHSeZlsnuBM7yZpGMPVueyjNMn30YgSi/TUbXfh0NsdWw9qnKKmFOMswTN+7HXlKrwEg5pOZUkn
	 Px90Y1Jzh9oFr9N/CJIvqzpZAyGFBaGNrtA8gaEUUjRXOF6CiJcun7BnWknKn923FUp5EyyEFP0c
	 XCqJP83VBOCUQRogNw4rgw8CjoxHbFEIxBKqt6k51hGl8VmcFfXZXiFUjU3/zuliQ/XY8d7MTS9W
	 QCYwcmOrbj7wTFhNC10Q+RLHLoO3O4ude0ZzRd/Z0LYXqoip9E05uXmdtgIfOOyJSFKa9r/l02qB
	 TYOe2e383TiqhL8yxfna+fEt8DLemjMsWOhcOaeB0/Wc5PsudqV1U7p99seGxDViZ6PheGuCYZKX
	 OZhUulHXN70vQerX4mRAu9DXXcg8UrICKfY0E4t5p9airTOf0=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Shen Yongchao <grayhat@foxmail.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Shen Yongchao <grayhat@foxmail.com>
Subject: [PATCH 1/2] KVM: SVM: Serialize the owner's mirror list in sev_migrate_from()
Date: Tue,  4 Aug 2026 22:54:32 +0800
X-OQ-MSGID: <20260804145432.759798-1-grayhat@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sev_migrate_from(), when the destination KVM is a mirror, the mirror
entry is moved from the source's list to the owner's mirror_vms list
without holding the owner's lock.  All other writers of the owner's
mirror list (KVM_SEV_MIRROR_CREATE, sev_vm_destroy()) serialize on the
owner's lock, so a concurrent COPY or destroy can race with
KVM_SEV_MIGRATE_VM and corrupt the list, e.g. leaving a dangling
mirror_entry that is later dereferenced.

All kernels with SEV mirroring and intra-host migration support
(KVM_SEV_MIRROR_CREATE / KVM_SEV_MIGRATE_VM) are affected.  The mirror
list mechanism was introduced by commit b2125513dfc0 ("KVM: SEV: Allow
SEV intra-host migration of VM with mirrors", v5.18, 2022-02-18);
upstream mainline is unfixed as of 2026-08-04.  Triggering requires an
AMD SEV-capable host with CONFIG_KVM_AMD_SEV and a local user able to
create SEV VMs and mirrors, racing KVM_SEV_MIGRATE_VM against
KVM_SEV_MIRROR_CREATE or mirror destroy (instruction-level window).

Take the owner's lock around the list operations.  The lock is taken
after sev_lock_two_vms() and the migration_in_progress flags prevent
two migrations from interleaving.  The owner is a third VM whose lock
is not held: the destination cannot already own an encryption context
(sev_vm_move_enc_context_from() rejects SEV guests as the destination,
gating on ->active), and a VM cannot be its own mirror owner.  Hence
SINGLE_DEPTH_NESTING is sufficient and cannot deadlock.

This patch was drafted with AI assistance.

Fixes: b2125513dfc0 ("KVM: SEV: Allow SEV intra-host migration of VM with mirrors")
Cc: stable@vger.kernel.org
Assisted-by: Hermes:deepseek-v4-flash
Signed-off-by: Shen Yongchao <grayhat@foxmail.com>
---
Reproducer: static analysis only (no SEV-capable hardware available);
no reproducer has been run.  The triggering sequence is described in
the commit message.

This issue was initially reported privately to security@; Sean
Christopherson OK'd handling it on-list.

Mitigations: none; SEV is an optional platform feature and the attack
requires a local user with SEV VM creation privileges.
 arch/x86/kvm/svm/sev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 944aaea6501..4fa4e9bf408 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2050,8 +2050,14 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
 	if (is_mirroring_enc_context(dst_kvm)) {
 		struct kvm_sev_info *owner_sev_info = to_kvm_sev_info(dst->enc_context_owner);
 
+		/*
+		 * All other writers of the owner's mirror list (COPY,
+		 * destroy) serialize on the owner's lock; do the same.
+		 */
+		mutex_lock_nested(&dst->enc_context_owner->lock, SINGLE_DEPTH_NESTING);
 		list_del(&src->mirror_entry);
 		list_add_tail(&dst->mirror_entry, &owner_sev_info->mirror_vms);
+		mutex_unlock(&dst->enc_context_owner->lock);
 	}
 
 	kvm_for_each_vcpu(i, dst_vcpu, dst_kvm) {
-- 
2.43.0

