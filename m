Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E7A489FD8
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999542; cv=none; b=fta3nrLFBkgQUr7Qx8cN+T84KAoW3VEyb7dt2LUHEt231ekNPHC2y0q5WAWmG6mctLKOTy9tbdn1eSdw4ByxSZWQ9UFuWAbWUI5+BP5xoaa4T2KUw2qB5B/nW9sb21vvYxEPHGyKb0edygQk94GY8eFKD7mzZHJBGAJDmMlDTHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999542; c=relaxed/simple;
	bh=ehiR32Gn7n/lXSBdkqVIOBvCJF2Aoz0ld9K8B3T6mdk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DhTD0VQzCjTqgySV236WPnhQ+tGKrmgXIKtTEyYehZYYashzfEK8xJdipgQi4ssvn5O21pi+WuyUwPSPXFWrfE4werozhz6Ip5Dson8yvmgwNEMoCh21iDxfdwM06kIAWyOByz8Q1XeYSemmIetOKGDACreP2CktnrHTzaA9crM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W2ihu4ju; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2ihu4ju"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-85602449126so6308708b3a.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999540; x=1790604340; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y1UYnXCxuzBYy7emDqeed9xrR2iKFbDHhQtYLJlfFEE=;
        b=W2ihu4ju9WBD6VyEQRWsSCSn5mYyronVRuDqiE6pJ4FQ6KHQk52E8vGyh1q451PK8C
         22e/GazJkrcX7G6fS0nibfBMk+dxbaJjaVWUFqyHDgm6luTW1Gzg34ApEaAfSU3mvDKI
         wIFtTD7nKg/RIOc+asV6AKUAjerRm9dwMphO0sfoH5drZBL67UBAzODt534Q4CMuY9k6
         IFCZd72kYhkvdRIL/feqCXF99VA2o/51ldqczbpeAdkGxRyCkn545+Hr2+oAQ3tp+PKG
         DVv+82+kOJtOZHDY17ay2a+qkySgjNIwJXzNUe3RSJFJOO6ukFM7m9rEmopfwPM8ea5o
         sZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999540; x=1790604340;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y1UYnXCxuzBYy7emDqeed9xrR2iKFbDHhQtYLJlfFEE=;
        b=RzQCSnC14czkXnJj8WfYBhpLpWyVSd1g8ZOq2BRxld+Ul8vguilhH+k2vlxx+3RsKF
         qJmNIcjTxRKHL1Mv2bDSPpHCxL+BXMWxyknob/sOnPG32Il5XdxUZIg07I18/PbKB74i
         sEcaqJg8mCiyqpGSgT3peaK7OYkkJg8nVcg7j0+iePtuZ7wharSLeLgPY5SbThNHSLJy
         simLZQtzAvCfuTrGrTbSUcn0GWHOZ45T2UzrMOFqN4Wgv+FalZKFKrfEcxrYTbd4PWRj
         P1PXdAAwl2PYnB8jaJIy9UxFWFXty8+a6B9ObiudVWE9BL6BOyZWxORuVTZmJYhMrEzJ
         f/9g==
X-Gm-Message-State: AFuF++mYcbqLu30HG4ax0FLh50gc4jpaBCwN/Abd3A0e7d3Oz7szYf7r
	lgkfUUtipa+1FjdBM2aPrXBMPj1qKnSdPLdafaC3HQaliln3GcQ2GVWd6P4YMouX8eZQh2DrDuM
	cvvgwlQ==
X-Received: from pfbgb5.prod.google.com ([2002:a05:6a00:6285:b0:877:1a5e:530a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2450:b0:878:34d7:6a32
 with SMTP id d2e1a72fcca58-87834d76df6mr8044053b3a.38.1789999539608; Mon, 21
 Sep 2026 07:05:39 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:04:58 -0700
In-Reply-To: <20260826213303.914988-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826213303.914988-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999887060.742658.18392421628866750785.b4-ty@google.com>
Subject: Re: [PATCH v10 00/21] KVM: x86: Cleaning up the KVM clock mess, part 1
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 26 Aug 2026 14:32:40 -0700, Sean Christopherson wrote:
> Part 1 of David's series to clean up the host-side mess of kvmclock.  The cut
> point in this version is still quite arbitrary, but what's left for "part 2"
> fits nicely into 2-3 buckets:
> 
>   1: Masterclock overhaul
>   2. New uAPI and tests
> 
> [...]

Applied to kvm-x86 clocks, thanks!

[01/21] KVM: x86: Update "last guest TSC" snapshot prior to enabling IRQs/preemption
        https://github.com/kvm-x86/linux/commit/ba78382f34c1
[02/21] KVM: x86: Improve accuracy of KVM clock when TSC scaling is in force
        https://github.com/kvm-x86/linux/commit/d4f54ed48e00
[03/21] KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
        https://github.com/kvm-x86/linux/commit/dd0a8675f4ba
[04/21] KVM: x86: Activate master clock immediately on vCPU creation
        https://github.com/kvm-x86/linux/commit/7254e09bb5e9
[05/21] KVM: x86: Compute kvmclock base without pvclock_gtod_data
        https://github.com/kvm-x86/linux/commit/7ffdb9d111c3
[06/21] KVM: x86: Avoid NTP frequency skew for KVM clock on 32-bit host
        https://github.com/kvm-x86/linux/commit/4c710e8182f4
[07/21] KVM: x86: Drop unnecessary CPU pinning when computing/getting kvmclock
        https://github.com/kvm-x86/linux/commit/796b73bba577
[08/21] KVM: x86: Move "no master clock" fallback from __get_kvmclock() to get_kvmclock()
        https://github.com/kvm-x86/linux/commit/1a926fb39304
[09/21] KVM: x86: Wrap all of __get_kvmclock_master_clock() with CONFIG_X86_64=y
        https://github.com/kvm-x86/linux/commit/8e7e24b88e26
[10/21] KVM: x86: Fall back to non-master-clock if clockread fails in get_kvmclock()
        https://github.com/kvm-x86/linux/commit/25f75fb43fd5
[11/21] KVM: x86: Fix KVM clock precision in get_kvmclock() with TSC scaling
        https://github.com/kvm-x86/linux/commit/abdef42276d8
[12/21] KVM: x86: Use get_kvmclock() in kvm_get_wall_clock_epoch()
        https://github.com/kvm-x86/linux/commit/c56419275caa
[13/21] KVM: x86: Fix compute_guest_tsc() to handle negative time deltas
        https://github.com/kvm-x86/linux/commit/d9173f59df3a
[14/21] KVM: x86: Disable preemption, not IRQs, when getting TSC+freq pair
        https://github.com/kvm-x86/linux/commit/917a53a4b461
[15/21] KVM: x86: Make master clock logic in guest PV clock updates 64-bit only
        https://github.com/kvm-x86/linux/commit/f21b04302404
[16/21] KVM: x86: Upscale TSC to "now", not master clock when updating PV clocks
        https://github.com/kvm-x86/linux/commit/92fac63cc739
[17/21] KVM: x86: Simplify and comment kvm_get_time_scale()
        https://github.com/kvm-x86/linux/commit/2918af628d0d
[18/21] KVM: x86: Remove implicit rdtsc() from kvm_compute_l1_tsc_offset()
        https://github.com/kvm-x86/linux/commit/d4bbf2a8eb82
[19/21] KVM: x86: Use kernel timekeeping snapshots for getting kvmclock time since boot
        https://github.com/kvm-x86/linux/commit/ef7d809987c9
[20/21] KVM: x86: Use kernel timekeeping snapshot for monotonic clock
        https://github.com/kvm-x86/linux/commit/0a0ab23b05f0
[21/21] KVM: x86: Use kernel timekeeping snapshot to get walltime+TSC
        https://github.com/kvm-x86/linux/commit/d7841275e1fb

--
https://github.com/kvm-x86/linux/tree/next
