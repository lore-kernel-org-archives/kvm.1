Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AFC472079;
	Thu, 10 Sep 2026 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040363; cv=none; b=ioUjc5OtgYG9xVWkP4tpjJKSkzc+u5ufCopE1C+iQAIvvZSllR32UCYAIcTFvbuIMHFhfQRm4sxJ7AY22dc+zQEhnD+4gO2/saTyMdgmVyw4CpLEhMmJth9onihmEaCt87dGFgUfdCkAOI1BL/XIM5YD3eLgLQVjo6kQ+oaNXz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040363; c=relaxed/simple;
	bh=MJCokGP7zUNGImiOFAmdg2f9uLjAcaU0W2WGWAvvvTY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqJ3s0wWe/9OAlsIh+wer6oRRStSNe7+54legRPmdJyhb8yFFzTwRQmmpfOLfZgNqRqXbF/x5cQxMvFz+sP6RdvxEiFpiC/Ij53fiw8x4rKx4+wk7m5m6cuapKATkXrJF721pXaX0Gn11wTOTwHc8e20qFijrXtObUmPQ3LSjJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbL56m4RzbKSs8;
	Thu, 10 Sep 2026 19:39:09 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hgbL34NVFzbKSs8;
	Thu, 10 Sep 2026 19:39:07 +0800 (CST)
Received: from ewan-server (ewan-server [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP6074cd04769291751c80574647a050e2
	Thu, 10 Sep 2026 19:39:06 +0800
X-Eyou-Smtpauth: ewanhai-oc@zhaoxin.com
X-Eyou-EnvelopeSender: ewanhai-oc@zhaoxin.com
X-Eyou-From: Ewan Hai <ewanhai-oc@zhaoxin.com>
From: "=?UTF-8?B?RXdhbiBIYWktb2M=?=" <ewanhai-oc@zhaoxin.com>
Date: Thu, 10 Sep 2026 19:39:05 +0800
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Frank Zhu <frankzhu@zhaoxin.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ewanhai@zhaoxin.com, cobechen@zhaoxin.com
Subject: Re: [PATCH 1/8] KVM: selftests: Add Zhaoxin (ZX) CPU detection
 support
Message-ID: <aqKVohKiehUEhewl@ewan-server>
References: <20260730110524.2539316-1-ewanhai-oc@zhaoxin.com>
 <20260730110524.2539316-2-ewanhai-oc@zhaoxin.com>
 <apdrfkO8ALRz59yl@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apdrfkO8ALRz59yl@google.com>
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>

On Tue, Sep 01, 2026 at 05:19:10PM -0700, Sean Christopherson wrote:
> On Thu, Jul 30, 2026, Ewan Hai-oc wrote:
> > From: Frank Zhu <frankzhu@zhaoxin.com>
> > 
> > Add infrastructure to detect Zhaoxin CPUs in KVM selftests. Zhaoxin
> > CPUs use vendor strings "CentaurHauls" or "  Shanghai  " and implement
> > VMX-compatible virtualization technology.
> > 
> > Signed-off-by: Frank Zhu <frankzhu@zhaoxin.com>
> > Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
> > ---
> >  tools/testing/selftests/kvm/include/x86/processor.h | 7 +++++++
> >  tools/testing/selftests/kvm/lib/x86/processor.c     | 3 +++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> > index b161174ece45..9840b583877c 100644
> > --- a/tools/testing/selftests/kvm/include/x86/processor.h
> > +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> > @@ -23,6 +23,7 @@ extern bool host_cpu_is_intel;
> >  extern bool host_cpu_is_amd;
> >  extern bool host_cpu_is_hygon;
> >  extern bool host_cpu_is_amd_compatible;
> > +extern bool host_cpu_is_zx;
> 
> Please spell out "zhaoxin", "zx" isn't intuitive for most of us (I keep thinking
> it's a compression feature).
> 
> And do the same thing we did in commit 53b2869231d3 ("KVM: selftests: Add a flag
> to identify AMD compatible test cases"), and add host_cpu_is_intel_compatible.
> That should cut down on the number of checks on is_zhaoxin, and should help avoid
> issues like the ones Sashiko pointed out.
>
Agreed. In v2, I added host_cpu_is_intel_compatible
(host_cpu_is_intel || host_cpu_is_zhaoxin) and used it where host_cpu_is_intel
serves as a proxy for KVM's VMX backend:

  - kvm_is_tdp_enabled() now queries kvm_intel's ept parameter.
  - vmx_exception_with_invalid_guest_state now runs on Zhaoxin CPUs.
  - fix_hypercall_test now selects VMCALL on Zhaoxin CPUs.
  - kvm_is_mediated_pmu_enabled() now queries kvm_intel's
    enable_mediated_pmu parameter on Zhaoxin CPUs.
  - feature_msrs_test now uses the VMX initial value for
    MSR_IA32_UCODE_REV on Zhaoxin CPUs.

I left kvm_buslock_test unchanged. KVM does not currently advertise
KVM_CAP_X86_BUS_LOCK_EXIT on Zhaoxin systems, so the test skips before
reaching the vendor-specific assertion. That assertion distinguishes
trap-like from fault-like behavior, so changing it without Zhaoxin
bus-lock exit support would be untested.

The PMU tests are intentionally unchanged. pmu_counters_test explicitly
requires an Intel host, while pmu_event_filter_test requires either
use_intel_pmu() or use_amd_pmu(); neither is true on Zhaoxin. Some
Zhaoxin PMU registers and MSRs differ from Intel's, so Zhaoxin-specific
PMU coverage is outside the scope of this series.


