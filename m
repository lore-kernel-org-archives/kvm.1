Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D2882899;
	Sun,  1 Mar 2026 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328675; cv=none; b=NYxtf7KdeMW6rGQMlt/Peh8bmGoIDdlmsfU0tFrMcLYNGYmr3L/XZExkMoqdtmAgoFt0M1fT1ps9ydG5YMOkATHhKKFNzQb3zf62EFzOIOE1URjHZ6uXgUC4C6nxF3GqdaDSREMnCDuVYL/ScZLbRmffvjjIDJ3UY3LE9EHu6Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328675; c=relaxed/simple;
	bh=8bb/Me4499dWoX8UJjOmDFjDFiMysoGa7pT3I9yCcas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=flZbOtmYKU2iMm6ON7RZhO7R85XcCAlvis5JulTahhWHOCp6aMnCOwDNuiIg0xWJ+Cv9K53QJ5eqj8ETyQCjMaWNi+Xg60kWrhBdmtvjMy6ikDWvhPcgwiP65uUmvC2Gep/92lCJyYWlcvffTyhm0T851gl27rtD0TZRboj+t4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDru5KG1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDru5KG1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90560C19424;
	Sun,  1 Mar 2026 01:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328675;
	bh=8bb/Me4499dWoX8UJjOmDFjDFiMysoGa7pT3I9yCcas=;
	h=From:To:Cc:Subject:Date:From;
	b=GDru5KG1KhLBjyPmW3o+wG0xIdYP25WMWCbWDROwwUo8Ubx74tmeUBQmkpd2bduxR
	 Vz12kFBZEfJBiO4e+YixflsCGLL6iZQ6B7QmhwFcX1REXi7iitE4uKtfAIsy5vW39F
	 H9OhjBCryTJHrAAprWt0lP5lvpFplyc0CbPCH8lONTjmhoxPYQ18EeYR3Ge4OdG+Hq
	 xtdy5K0iJz532S+X/rwJknIm3oSxYOno5vBMQ7gnnKAQucx942NC7F2sPAYGUi0oZE
	 c1zzxSUqVgQ8gJYQtej6IXWgFl9oThpFhu7YA7OKOZ5PoCqo43J5mfAoleYCjdr026
	 spiwnu1H+XX0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	seanjc@google.com
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	kvm@vger.kernel.org
Subject: FAILED: Patch "KVM: nSVM: Remove a user-triggerable WARN on nested_svm_load_cr3() succeeding" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:31:13 -0500
Message-ID: <20260301013113.1689664-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fc3ba56385d03501eb582e4b86691ba378e556f9 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 16 Dec 2025 08:17:54 -0800
Subject: [PATCH] KVM: nSVM: Remove a user-triggerable WARN on
 nested_svm_load_cr3() succeeding

Drop the WARN in svm_set_nested_state() on nested_svm_load_cr3() failing
as it is trivially easy to trigger from userspace by modifying CPUID after
loading CR3.  E.g. modifying the state restoration selftest like so:

  --- tools/testing/selftests/kvm/x86/state_test.c
  +++ tools/testing/selftests/kvm/x86/state_test.c
  @@ -280,7 +280,16 @@ int main(int argc, char *argv[])

                 /* Restore state in a new VM.  */
                  vcpu = vm_recreate_with_one_vcpu(vm);
  -               vcpu_load_state(vcpu, state);
  +
  +               if (stage == 4) {
  +                       state->sregs.cr3 = BIT(44);
  +                       vcpu_load_state(vcpu, state);
  +
  +                       vcpu_set_cpuid_property(vcpu, X86_PROPERTY_MAX_PHY_ADDR, 36);
  +                       __vcpu_nested_state_set(vcpu, &state->nested);
  +               } else {
  +                       vcpu_load_state(vcpu, state);
  +               }

                  /*
                   * Restore XSAVE state in a dummy vCPU, first without doing

generates:

  WARNING: CPU: 30 PID: 938 at arch/x86/kvm/svm/nested.c:1877 svm_set_nested_state+0x34a/0x360 [kvm_amd]
  Modules linked in: kvm_amd kvm irqbypass [last unloaded: kvm]
  CPU: 30 UID: 1000 PID: 938 Comm: state_test Tainted: G        W           6.18.0-rc7-58e10b63777d-next-vm
  Tainted: [W]=WARN
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:svm_set_nested_state+0x34a/0x360 [kvm_amd]
  Call Trace:
   <TASK>
   kvm_arch_vcpu_ioctl+0xf33/0x1700 [kvm]
   kvm_vcpu_ioctl+0x4e6/0x8f0 [kvm]
   __x64_sys_ioctl+0x8f/0xd0
   do_syscall_64+0x61/0xad0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53

Simply delete the WARN instead of trying to prevent userspace from shoving
"illegal" state into CR3.  For better or worse, KVM's ABI allows userspace
to set CPUID after SREGS, and vice versa, and KVM is very permissive when
it comes to guest CPUID.  I.e. attempting to enforce the virtual CPU model
when setting CPUID could break userspace.  Given that the WARN doesn't
provide any meaningful protection for KVM or benefit for userspace, simply
drop it even though the odds of breaking userspace are minuscule.

Opportunistically delete a spurious newline.

Fixes: b222b0b88162 ("KVM: nSVM: refactor the CR3 reload on migration")
Cc: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>
Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Link: https://patch.msgid.link/20251216161755.1775409-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index ba0f11c68372b..9be67040e94d9 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1870,10 +1870,9 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	 * thus MMU might not be initialized correctly.
 	 * Set it again to fix this.
 	 */
-
 	ret = nested_svm_load_cr3(&svm->vcpu, vcpu->arch.cr3,
 				  nested_npt_enabled(svm), false);
-	if (WARN_ON_ONCE(ret))
+	if (ret)
 		goto out_free;
 
 	svm->nested.force_msr_bitmap_recalc = true;
-- 
2.51.0




