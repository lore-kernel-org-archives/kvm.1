Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB23B51EDEE
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789863; cv=none; b=HX8htbKByYW/vF60wNhJ+KOyKFzXtAaL0+Ulq1TUCpl97bcD5nKVRT1H0rAMHZLPanitUB8swNEUqup+krWUF0bZgGDSbTSsOl+yFtaHd8WTVyquFMll96+rzEJfnY3Zovz5Z0AK5x0HZZMz4o7f4B72xK2TOF941FLPE2M1NZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789863; c=relaxed/simple;
	bh=LJyZ3tVj8w6jPsUo69NAPyOWF+WrzCpi4R294IkW+Gc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BzEE943AbVK3GEc/wHvsxb2UX9EZ8T0iW0IeZSTf4/7Qm7cYmEMC1dDG3PO8NV7p+pV9dCrfk7dpo3YcgYqxsJn4cG1WPTRPZCo27KtyJgBz+sy7mQZ/cQxwdUvAxbyiUyMRXb+RtIQ8PKd/O33ZCzfgIXj3DJxKFhE9D6VVcWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfURh0MT; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfURh0MT"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc489e7a701so6836547a12.2
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790789861; x=1791394661; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YQI7Xhfv1l7vhAWmakkyx6EijkOgxOzytd1BuSHWhHU=;
        b=lfURh0MTgCh0hWNnc5A2sdHRIdNuozSR5Q2nMl7C9x981kJRQxYU4ucwrZJntTxcIw
         arZ961Y7u+O/9SKt+fH5AHQFWIylviy/NSh9hLvCWhcQUKd7jU6OdtmTQn9GF9vKXIzH
         D8XThl62hHY+gFkJlWSJOsRoClsnIkjSPodxFN4syuvYvuk/dEWRnN/SCjzbgdoE6N+A
         tLi7rxFtIQ/Jw1QZg25g1xOEBfLzh3uZorIpqyw6oB6XA6VjyvBwG976X36fBta/MWX6
         GlsKWdJSoH7ePuWBjUNeOoJ4rglex39Wfq3RzpYlNtvdqaWZrRqYpmby433jfGOQZWmz
         +5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790789861; x=1791394661;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YQI7Xhfv1l7vhAWmakkyx6EijkOgxOzytd1BuSHWhHU=;
        b=Ky9u9xMJs2yl9dsK2pboHKq3IOgFhNvi1fzW458QXehgWqFfcbWeEhMDRVair+h6oW
         RVoWwUhU4Mkd1RgorQOx2jTTWLyrrqJ3rzDypTN4cn6BTjW7B7DnkBiXf2DcNGXchNpW
         manQ/xkroX7XPa21NqpuPflzsLJAzPU9W6jnpwDSbEVXdS40E2br8qE6wKWJmDWcQUTf
         UZtm0XmEeV73YCKHAUr9zrOIVlf9MK2pn0k2qm7OTzOwn4TJas4zU/ZDJL+QpNMxruJt
         Vd5XQCSNbcs+Bs0+jdoLJajACep+lvOItzjT0FhXBxt3iBUKrAO6CMoLeDwcCLSy7g4T
         6+sw==
X-Gm-Message-State: AFuF++m+n+Y7qpUH+Bo8n+yOg+ibKheBSHG5jY5rGVwhQOgOWOqlG48b
	24svWdDLm9bERvREtJTZKLjtiRHAMKjDoJ0N2m63WbmXaFq4wRm9Q0bvvM0HPptYCDleh089Uov
	83BkNlA==
X-Received: from pgam11.prod.google.com ([2002:a05:6a02:2b4b:b0:cc7:9b02:9728])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a04:b0:3dd:a196:539c
 with SMTP id adf61e73a8af0-3de9e87dbe8mr2090543637.62.1790789860786; Wed, 30
 Sep 2026 10:37:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 10:36:17 -0700
In-Reply-To: <20260930173635.3362655-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930173635.3362655-4-seanjc@google.com>
Subject: [PATCH v3 03/21] KVM: x86: Allow userspace to set KVM's max supported
 guest TSC frequency
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Reject KVM_SET_TSC_KHZ if the incoming frequency is strictly greater than
KVM's max supported frequency, not if the frequency is greater than *or*
equal to the max frequency.  The effective off-by-one bug came about via
(dubious) review feedback, which also subtly collided with a functional
change in later versions of the original TSC scaling series.

In v2 of the original TSC scaling series[1], KVM set its absolute min/max
to [1, UINT_MAX], i.e. allowed any value that would fit in the u32 passed
to KVM_SET_TSC_KHZ[2].

  min = max(1ULL,          __scale_tsc(tsc_khz, TSC_RATIO_MIN));
  max = min(0xffffffffULL, __scale_tsc(tsc_khz, TSC_RATIO_MAX));

That prompted Avi to suggest rejecting the "equals" case, presumably
because the check would always succeed given an absolute max of UINT_MAX?
But even that doesn't hold up to scrutiny, as allowing the actual min/max
isn't inherently unsafe.  Regardless, that feedback was taken and applied
to future versions, but only for the maximum, not the minimum.

  > +
  > +		r = -EINVAL;
  > +		if (user_tsc_khz<  kvm_min_guest_tsc_khz ||
  > +		    user_tsc_khz>  kvm_max_guest_tsc_khz)

  <= and >= are probably safer.

v3 of the series[3] then also realized that allowing UINT_MAX would lead to
undesirable interactions with KVM_GET_TSC_KHZ, which returns a *signed*
32-bit integer that is implicitly converted into a signed 64-bit value on
64-bit kernels.  I.e. allowing a value greater than INT_MAX would result
in userspace observing a negative value when doing KVM_GET_TSC_KHZ after
KVM_SET_TSC_KHZ.

 /*
  * Make sure the user can only configure tsc_khz values that
  * fit into a signed integer.
  * A min value is not calculated needed because it will always
  * be 1 on all machines and a value of 0 is used to disable
  * tsc-scaling for the vcpu.
  */
  max = min(0x7fffffffULL, __scale_tsc(tsc_khz, TSC_RATIO_MAX));

  kvm_max_guest_tsc_khz = max;

v3 also dropped the explicit minimum tracking, as both AMD and Intel
support a minimum *fractional* ratio of 1, i.e. AMD and Intel support a
minimum frequency of "host / 2^32" and "host / 2^48" respectively.  And
because KVM_GET_TSC_KHZ (and KVM itself) only supports frequencies that fit
in a signed 32-bit integer, even AMD's more coarse-grained ratio can scale
down any host frequency to '1', i.e. KVM can always support a minimum
frequency of 1KHz.  Rather than explicitly reject a frequency of 1KHz,
v3 simply dropped the minimum check, i.e. ignored the "<=" suggestion, but
kept the ">=" side of things.

As a result, KVM now has a bizarre uABI where KVM_SET_TSC_KHZ tops out at
INT_MAX-1 for no discernible reason.  Fix the off-by-one flaw to provide a
less weird uABI, and so that KVM_SET_TSC_KHZ accepts the maximum possible
value that can be returned by KVM_GET_TSC_KHZ (without running afoul of
casting issues; KVM doesn't actually sanity check that tsc_khz fits in a
signed 32-bit value, which is a non-issue in practice because the units are
KHz, not Hz, i.e. KVM_GET_TSC_KHZ is fine until CPUs with a TSC frequency
greater than ~2.147PHz come along).

Note, in practice, no real world VMM is likely to care.  As above, running
afoul of the off-by-one issue would mean trying to configure a virtual TSC
frequency that is three orders of magnitude greater than what current CPUs
support.

Opportunistically explain *why* KVM restricts KVM_SET_TSC_KHZ to values
that fit in a signed integer, as it requires far too much spelunking to
piece together the connection to KVM_GET_TSC_KHZ.

Link: https://lore.kernel.org/all/1300952424-32014-1-git-send-email-joerg.roedel@amd.com [1]
Link: https://lore.kernel.org/all/1300952424-32014-7-git-send-email-joerg.roedel@amd.com [2]
Link: https://lore.kernel.org/all/1301042691-22929-7-git-send-email-joerg.roedel@amd.com [3]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 037c7ea5c5a7..1d25ffcf9273 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3718,7 +3718,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		user_tsc_khz = (u32)arg;
 
 		if (kvm_caps.has_tsc_control &&
-		    user_tsc_khz >= kvm_caps.max_guest_tsc_khz)
+		    user_tsc_khz > kvm_caps.max_guest_tsc_khz)
 			goto out;
 
 		if (user_tsc_khz == 0)
@@ -4685,7 +4685,7 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		user_tsc_khz = (u32)arg;
 
 		if (kvm_caps.has_tsc_control &&
-		    user_tsc_khz >= kvm_caps.max_guest_tsc_khz)
+		    user_tsc_khz > kvm_caps.max_guest_tsc_khz)
 			goto out;
 
 		if (user_tsc_khz == 0)
@@ -7174,7 +7174,8 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (kvm_caps.has_tsc_control) {
 		/*
 		 * Make sure the user can only configure tsc_khz values that
-		 * fit into a signed integer.
+		 * fit into a signed integer, otherwise KVM_GET_TSC_KHZ would
+		 * return a negative value and confuse userspace.
 		 * A min value is not calculated because it will always
 		 * be 1 on all machines.
 		 */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

