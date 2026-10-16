Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E88412F585
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164342; cv=none; b=aIPrCKAyKayZSS3tlpnDepJPXA4bXN1F8hA4aqp1JPIe6AdEWimlgtTIVyxGt/YKvw1qO3JBoM6hQki50oaVR6qHPmC6RQ7TAhSo8eoysE4yMTnTqt7qBwtnu262RGpofyNjTOcwnFZ9gvuVaHH9sS27NBJkZm1MAPZ4NV4rjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164342; c=relaxed/simple;
	bh=0Q2F8eMXPptzTA6CFnPdDDK7WMX88/q6nK1Vu+WDDwY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cEHBvGvRVbR3p7aP0SZdJrr2v0ZISidP+XTK0GhO38yENs+rC6yJusZq1WtAT3iy7gjvhEXPt0Abbv0gtp2OZGH4OpbYRL0ZLM+B286JFv9C5y2cg8b7gYw3lkhgPbmaUrwTxxpB3sdfxuE9J8Xxjc5NmqvfKHAmmlaudzhi/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pzVvj23j; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pzVvj23j"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e94b4a6e8dso24486475ad.3
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 08:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792164337; x=1792769137; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iFPRBPV73hLcdeayNzC5abDouETyR83o00x/J8+4uxc=;
        b=pzVvj23jD51XeA1zquPCLrzDl/trYpH0WCtAKQD+R5fIAkllpwDVFgOniJvlitBjnC
         zNwrj1mHEELVqVlnBGqpRscrXiKAV60YOIlVAeKeWNSWU6soidHPgF08l8fQU5567GBW
         k97s/RO/MXUz+WwefuBi1dnQrJWxg8yj3vQizIu6uv2Ek1IieAz4JJqG62A7zJ/hKyYO
         0le4IvL6cwpbcS7D0rse45Mjqy+blNOC3N7mk/4pIEVtXRjdDIZIm9oCdGOBd7e1U5wj
         J2i/8hF9we8TU12gkh+E/DHdIDTuzyySUfvlmFcob7KuYJ7b0T++uPFdu9sZvgc20ltf
         UXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792164337; x=1792769137;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iFPRBPV73hLcdeayNzC5abDouETyR83o00x/J8+4uxc=;
        b=Zj1T3ZGM5gFHzYc4IXaPT9OjhXfrsuA4eOyQmRYH1kbbZHb++O6p/zY5TtZ9CETioL
         agg7wS8KT0wDwdEi33hRkxYGLNazjCo7iQ/Me4UENxtttVMjuK4v+4r3Oi9LF+bKEDtV
         IAqpelRgTdeYiJqxj8LU1JXdp57c6AXAd5cg02z9N9ELx35rtJc3ynTH99Q+2e5gj5cQ
         xoKAf85/WnrKkLe/5HEAUhnHm2ko6dOoDEIfE0nII5hPCGH6iwQeJ+ilLTl41rZ1D3vY
         rjsJBKNjQ1qY21x+9g18Q1VgIFYrGRIaJ/s+IxXJhaGV4cQHx/PvYG7YbXe81lST7hJz
         m/xg==
X-Forwarded-Encrypted: i=1; AKwUvBx9OWMUfvhUJoMhf5qRIt5Pj0kkJwENRXGYJbUBK9y/vMqB5rQoa7PzBTOXRFTk84/1clQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIJO51MTyzbgY34gpQw8Mo0sB0RbE3tvx+EFnO8gXdmgPAwzcC
	G5EIyE2R7pBLRrjvV2C0x3DkjGN+idIomEWlk7yv/0BX9LdgmixbaFBHfRIGnT2yW7egA2M8TfH
	nYQiw7g==
X-Received: from plot22.prod.google.com ([2002:a17:902:8c96:b0:2e5:94eb:e1f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da48:b0:2e8:1ec2:a8c4
 with SMTP id d9443c01a7336-2e9a6c1b779mr3046575ad.14.1792164334914; Fri, 16
 Oct 2026 08:25:34 -0700 (PDT)
Date: Fri, 16 Oct 2026 08:25:34 -0700
In-Reply-To: <20261016091422.3182216-2-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com> <20261016091422.3182216-2-binbin.wu@linux.intel.com>
Message-ID: <atJB7kDzKsvzrMau@google.com>
Subject: Re: [PATCH v5 1/5] KVM: TDX: Check unsupported CPUID bits against the
 TDX module's subleaf
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	dave.hansen@linux.intel.com, andrew.cooper3@citrix.com, nik.borisov@suse.com, 
	kas@kernel.org, rick.p.edgecombe@intel.com, xiaoyao.li@intel.com, 
	chao.gao@intel.com, tony.lindgren@linux.intel.com, kishen.maloor@intel.com, 
	dedekind1@gmail.com, adrian.hunter@intel.com
Content-Type: multipart/mixed; charset="UTF-8"; boundary="eT79xhp2T0neg3Wb"


--eT79xhp2T0neg3Wb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2026, Binbin Wu wrote:
> Don't reject the mismatch outright, as the ABI allows userspace to provide
> an arbitrary index when KVM_CPUID_FLAG_SIGNIFCANT_INDEX is cleared.  It's
> userspace's responsibility to provide the intended entries; KVM only needs
> to ensure that the values it validates are the values it applies.
> 
> Fixes: 6d415778f106 ("KVM: TDX: Disable support for TSX and WAITPKG")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/kvm/20260604024927.E22311F00893@smtp.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---
> v5:
> - Split out from "KVM: TDX: Validate userspace CPUID input for
>   KVM_TDX_INIT_VM" as a standalone fix.  Sashiko reported the issue
>   against the TDX CPUID validation patch, but it also applies to the
>   existing code, so split it out to allow backporting to stable
>   independently of the rest of the series.
> - Check the userspace values against the subleaf reported by the TDX
>   module instead of rejecting the request when there is a mismatch.
> 
>   A simpler alternative would be to require a zero index when
>   KVM_CPUID_FLAG_SIGNIFCANT_INDEX is cleared, but that would be an ABI
>   change.

The even simpler change is to reject the incoming CPUID if userspace doesn't set
KVM_CPUID_FLAG_SIGNIFCANT_INDEX as expected.  Yes, that's an ABI change.  No, we
don't care.  The rule isn't "never change the ABI", it's "don't break userspace",
and there's basically zero chance a TDX guest can function properly if userspace
doesn't set KVM_CPUID_FLAG_SIGNIFCANT_INDEX as appropriate.

diff --git arch/x86/kvm/vmx/tdx.c arch/x86/kvm/vmx/tdx.c
index 75a86d64892a..7e0d81066420 100644
--- arch/x86/kvm/vmx/tdx.c
+++ arch/x86/kvm/vmx/tdx.c
@@ -151,8 +151,12 @@ static void tdx_clear_unsupported_cpuid(struct kvm_cpuid_entry2 *entry)
                clear_waitpkg(entry);
 }
 
-static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
+static bool tdx_is_unsupported_cpuid_entry(const struct kvm_cpuid_entry2 *entry)
 {
+       if (cpuid_function_is_indexed(entry->function) !=
+           !!(entry->flags & KVM_CPUID_FLAG_SIGNIFCANT_INDEX))
+               return true;
+
        return has_tsx(entry) || has_waitpkg(entry);
 }
 
@@ -2386,7 +2390,7 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
                if (!entry)
                        continue;
 
-               if (tdx_unsupported_cpuid(entry))
+               if (tdx_is_unsupported_cpuid_entry(entry))
                        return -EINVAL;
 
                copy_cnt++;

Can you test the attached patches?  If they boot TDX with QEMU, I'll go ahead
and post.

--eT79xhp2T0neg3Wb
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-x86-cpuid-Mark-CPUID-function-0x23-as-being-index.patch

From 73ab6386bac6625333526ab6b137c445d22ab5db Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 15 Oct 2026 18:34:12 -0700
Subject: [PATCH 1/4] x86/cpuid: Mark CPUID function 0x23 as being index

Add function 0x23 to the set of CPUID functions that are index, as per the
SDM and the many sub-leafs defined in leaf_types.h.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/cpuid/api.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 82eddfa2347b..25b22b173f2a 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -181,6 +181,7 @@ static __always_inline bool cpuid_function_is_indexed(u32 function)
 	case 0x1d:
 	case 0x1e:
 	case 0x1f:
+	case 0x23:
 	case 0x24:
 	case 0x8000001d:
 		return true;

base-commit: dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4
-- 
2.56.0.176.g3575e65682-goog


--eT79xhp2T0neg3Wb
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename=0002-KVM-TDX-Set-SIGNIFCANT_INDEX-flag-as-appropriate-whe.patch

From 90bd7cecc21de49fc30eda93de1d9f59d0c9a428 Mon Sep 17 00:00:00 2001
From: Changyuan Lyu <changyuanl@google.com>
Date: Thu, 15 Oct 2026 18:39:30 -0700
Subject: [PATCH 2/4] KVM: TDX: Set SIGNIFCANT_INDEX flag as appropriate when
 filling CPUID entries

Set the KVM_CPUID_FLAG_SIGNIFCANT_INDEX flag in the kvm_cpuid_entry2
structures returned by KVM_TDX_CAPABILITIES if the CPUID is indexed,
otherwise KVM could confuse userspace and induce a configuration error.
This also ensures consistency with the CPUID entries returned by
KVM_GET_SUPPORTED_CPUID.

Fixes: 61bb28279623 ("KVM: TDX: Get system-wide info about TDX module on initialization")
Cc: stable@vger.kernel.org
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
[sean: keep the WARN, don't key off KVM_TDX_CPUID_NO_SUBLEAF]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index ee1d412b0ee6..bcfecd2b1f31 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2,6 +2,7 @@
 #include <linux/cleanup.h>
 #include <linux/cpu.h>
 #include <asm/cpufeature.h>
+#include <asm/cpuid/api.h>
 #include <asm/fpu/xcr.h>
 #include <linux/misc_cgroup.h>
 #include <linux/mmu_context.h>
@@ -163,11 +164,18 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
 
 	entry->function = (u32)td_conf->cpuid_config_leaves[idx];
 	entry->index = td_conf->cpuid_config_leaves[idx] >> 32;
+	entry->flags = 0;
 	entry->eax = (u32)td_conf->cpuid_config_values[idx][0];
 	entry->ebx = td_conf->cpuid_config_values[idx][0] >> 32;
 	entry->ecx = (u32)td_conf->cpuid_config_values[idx][1];
 	entry->edx = td_conf->cpuid_config_values[idx][1] >> 32;
 
+	if (cpuid_function_is_indexed(entry->function))
+		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+
+	WARN_ON_ONCE(cpuid_function_is_indexed(entry->function) !=
+		     (entry->index != KVM_TDX_CPUID_NO_SUBLEAF));
+
 	if (entry->index == KVM_TDX_CPUID_NO_SUBLEAF)
 		entry->index = 0;
 
-- 
2.56.0.176.g3575e65682-goog


--eT79xhp2T0neg3Wb
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename=0003-KVM-TDX-Don-t-zero-non-significant-CPUID-entry-indic.patch

From c5cb713d03fa7cc41b999db8b014da6aa3d2a424 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 15 Oct 2026 18:42:36 -0700
Subject: [PATCH 3/4] KVM: TDX: Don't zero non-significant CPUID entry indices

Now that KVM sets KVM_CPUID_FLAG_SIGNIFCANT_INDEX when filling CPUID
entries based on output from the TDX Module, don't zero the index for
entries without a signficant index, as doing so incorrectly suggests that
zero is somehow special, which it is not.  The critical piece of info is
the SIGNIFCANT_INDEX flag, which tells KVM (and userspace) to simply ignore
the index.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index bcfecd2b1f31..75a86d64892a 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -176,9 +176,6 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
 	WARN_ON_ONCE(cpuid_function_is_indexed(entry->function) !=
 		     (entry->index != KVM_TDX_CPUID_NO_SUBLEAF));
 
-	if (entry->index == KVM_TDX_CPUID_NO_SUBLEAF)
-		entry->index = 0;
-
 	/*
 	 * The TDX module doesn't allow configuring the guest phys addr bits
 	 * (EAX[23:16]).  However, KVM uses it as an interface to the userspace
-- 
2.56.0.176.g3575e65682-goog


--eT79xhp2T0neg3Wb
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename=0004-KVM-TDX-Reject-KVM_TDX_INIT_VM-if-indexed-CPUID-func.patch

From c38351fecf16d9bbb694f3a08127ab90ae64484b Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 16 Oct 2026 07:41:34 -0700
Subject: [PATCH 4/4] KVM: TDX: Reject KVM_TDX_INIT_VM if indexed CPUID
 functions don't match

Reject KVM_TDX_INIT_VM if userspace doesn't configure the canonical CPUID
entries correctly with respect to KVM_CPUID_FLAG_SIGNIFCANT_INDEX to fix a
bug where userspace could bypass the TSX and WAITPKG checks by simply not
marking a CPUID.0x7 entry as being indexed.  This also sets the stage for
more in-depth validation of the incoming CPUID configuration.

This is obviously an ABI change and diverges from KVM's general approach of
"let userspace do what it wants".  In practice, no "real" VMM that supports
TDX misconfigures a TD's CPUID entries in this way, i.e. the probability of
actually breaking userspace is basically nil.  And unlike normal VMs, where
KVM has full control and thus can deal with bizarre CPUID input without too
much fuss, TDX VMs require extra care due to the TDX Module also reacting
to the CPUID configuration, i.e. KVM_TDX_INIT_VM needs to be more strict
than KVM_SET_CPUID{,2} to avoid creating potentially dangerous-to-the-host
setups.

Opportunistically rename the helper to make it more obvious that it's
checking if the passed in @entry is unsupported, as opposed to returning a
set of unsupported entries or something.

Fixes: 6d415778f106 ("KVM: TDX: Disable support for TSX and WAITPKG")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/kvm/20260604024927.E22311F00893@smtp.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 75a86d64892a..7e0d81066420 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -151,8 +151,12 @@ static void tdx_clear_unsupported_cpuid(struct kvm_cpuid_entry2 *entry)
 		clear_waitpkg(entry);
 }
 
-static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
+static bool tdx_is_unsupported_cpuid_entry(const struct kvm_cpuid_entry2 *entry)
 {
+	if (cpuid_function_is_indexed(entry->function) !=
+	    !!(entry->flags & KVM_CPUID_FLAG_SIGNIFCANT_INDEX))
+		return true;
+
 	return has_tsx(entry) || has_waitpkg(entry);
 }
 
@@ -2386,7 +2390,7 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
 		if (!entry)
 			continue;
 
-		if (tdx_unsupported_cpuid(entry))
+		if (tdx_is_unsupported_cpuid_entry(entry))
 			return -EINVAL;
 
 		copy_cnt++;
-- 
2.56.0.176.g3575e65682-goog


--eT79xhp2T0neg3Wb--
