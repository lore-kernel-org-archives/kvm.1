Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.0.225.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792464802;
	b=QST6HU6GQa97kbIu09EGYMpBydIRVo0KY5T540yrxQi1IMnxighzxRZcFVswrFYufXXM
	 +zxlSOfa7TzuEdIc+Pi9UFeitg9Wgl2segNJfNLSNwjUN/EA4IopgxdjFbfzQ9pLKi4c0
	 rtC9IzFuBZEuLPggUb8IGQk1UdkuuQK0S9wRTXrFOZH3f70iwrPNn7yB3Q8HgwygpAm3b
	 nt2ywHvMGesslg7aACI5YvvMx80BRJjJearjZUB6irjihh2ctbwmR3O7c7ilrhepsBlwm
	 ZEimO3B2Bc/J/mP0JdQRyiigFwgVs5zepY7AYkZJ7guj+Uk1HzeV2ZK7jY+XNFUEaAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792464802;
	h=DMARC-Filter:Received:Received:Received:X-Eyou-Smtpauth:
	 X-Eyou-EnvelopeSender:X-Eyou-From:From:Date:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Eyou-Sender;
	bh=Isam2qzXFBltZx89pCZ1QeUN4o0j6H71EtrOD9wZiSk=;
	b=yLPZ6AYdhhExr/fE8DClDOQakXRnXc6HPfzUOvXks9LG4QcIpO5M98sJexTxVmbxgsKk
	 to+/dnCYcjGDut8o+k/B0Vlse0iKeYgYT+amJETzbL5K42fM9Q4SqUCmFUBZMiKT14R41
	 /QGdLt7KkmNUOUOLAPIYPjdjPCKJqYxQtT70vs9RcOopcpEUCLOq6UpHKoYIqlXv64Q5X
	 tK9s0iFxLDLyYUwTUemhQvIzzIQVXnEek3Cp1ZDo3vIv3EyIbk5xwDypms89u9dnHVPHL
	 rE8uMkYt0TiLY1lShWo4e2lfU73h/m+BfOw0/0H1IgKQm0mmv9sYXJHNW1ZU4tBY5TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zhaoxin.com;
	spf=pass smtp.mailfrom=zhaoxin.com;
	arc=none smtp.remote-ip=210.0.225.12
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5370606A31A;
	Tue, 20 Oct 2026 02:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5370606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4j7xmm022Bzb0pbc;
	Tue, 20 Oct 2026 10:53:12 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.140.201])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4j7xml4GH3zb0pbc;
	Tue, 20 Oct 2026 10:53:11 +0800 (CST)
Received: from ewan-server (ewan-server [10.28.24.7])
	by zhaoxin.com (8.30) with ESMTP62f8ff40056a60f56e6be29f9128510a
	Tue, 20 Oct 2026 10:53:10 +0800
X-Eyou-Smtpauth: ewanhai-oc@zhaoxin.com
X-Eyou-EnvelopeSender: ewanhai-oc@zhaoxin.com
X-Eyou-From: Ewan Hai <ewanhai-oc@zhaoxin.com>
From: "=?UTF-8?B?RXdhbiBIYWktb2M=?=" <ewanhai-oc@zhaoxin.com>
Date: Tue, 20 Oct 2026 10:53:29 +0800
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Frank Zhu <frankzhu@zhaoxin.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ewanhai@zhaoxin.com, cobechen@zhaoxin.com
Subject: Re: [PATCH v2 6/9] KVM: selftests: Skip PERF_CAPABILITIES vCPU
 checks without PDCM
Message-ID: <atbVQZsuClHwaLGo@ewan-server>
References: <20260910115414.3015260-1-ewanhai-oc@zhaoxin.com>
 <20260910115414.3015260-7-ewanhai-oc@zhaoxin.com>
 <aqQqJysVQxS76YIE@google.com>
 <arHesdC4MieHtZUr@ewan-server>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arHesdC4MieHtZUr@ewan-server>
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>

On Tue, Sep 22, 2026 at 09:54:51AM +0800, Ewan Hai-oc wrote:
> On Fri, Sep 11, 2026 at 09:19:51AM -0700, Sean Christopherson wrote:
> > On Thu, Sep 10, 2026, Ewan Hai-oc wrote:
> > > From: Frank Zhu <frankzhu@zhaoxin.com>
> > > 
> > > KVM allows userspace to query MSR_IA32_PERF_CAPABILITIES through
> > > KVM_GET_MSRS even when PDCM is not exposed in KVM_GET_SUPPORTED_CPUID.
> > > However, vCPU accesses to the MSR fail without PDCM.
> > 
> > Hrm, no, KVM is supposed to allow reads and drop writes of '0' for MSRs that are
> > advertised to userspace, but ultimately unsupported.  I'm pretty sure this is a
> > KVM bug.  I think MSR_IA32_ARCH_CAPABILITIES is also affected.
> > 
> > Completely untested, but I think this?
> > 
> > diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> > index dd3bb04878ca..fa77cfdbda7e 100644
> > --- a/arch/x86/kvm/msrs.c
> > +++ b/arch/x86/kvm/msrs.c
> > @@ -512,9 +512,15 @@ static int kvm_get_feature_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
> >  
> >  	switch (index) {
> >  	case MSR_IA32_ARCH_CAPABILITIES:
> > +		if (!kvm_cpu_cap_has(X86_FEATURE_ARCH_CAPABILITIES))
> > +			return KVM_MSR_RET_UNSUPPORTED;
> > +
> >  		*data = kvm_get_arch_capabilities();
> >  		break;
> >  	case MSR_IA32_PERF_CAPABILITIES:
> > +		if (!kvm_cpu_cap_has(X86_FEATURE_PDCM))
> > +			return KVM_MSR_RET_UNSUPPORTED;
> > +
> >  		*data = kvm_caps.supported_perf_cap;
> >  		break;
> >  	case MSR_PLATFORM_INFO:
> >
> 
> I saw that you applied eight patches from the series to the kvm-x86
> selftests branch and skipped patch 6 as a KVM bug.
> 
> We are testing the change you suggested on Zhaoxin systems with and
> without PDCM support. We expect to report the results within the next
> few weeks.
> 

Hi Sean,

Frank tested your suggested change on Zhaoxin systems **without** PDCM,
using kvm_intel. The results support the fix.

MSR_IA32_PERF_CAPABILITIES is no longer listed in
KVM_GET_MSR_FEATURE_INDEX_LIST. A direct KVM_GET_MSRS query on the
/dev/kvm fd still succeeds, with the MSR data changing from 0x2000
to 0 through the existing unsupported-MSR handling. The MSR remains
in KVM_GET_MSR_INDEX_LIST, and the existing vCPU userspace behavior
of allowing reads of zero and writes of zero is unchanged.

We also checked the QEMU behavior. With the MSR absent from the feature
list, QEMU's supported-feature query returns zero for PERF_CAPABILITIES.
The PDCM bit in KVM_GET_SUPPORTED_CPUID is unchanged and was already
clear on these systems. QEMU filters PDCM out of CPU models that request
it, so this resolves our concern about the effect on CPU model selection.

feature_msrs_test passes with the change. vmx_pmu_caps_test is skipped
on these systems, and the other KVM selftests we ran showed no regressions.
Our hardware testing covered systems without PDCM; we have not validated
the change on PDCM-capable hardware.

One observation about the ARCH_CAPABILITIES check: in the code we
checked, EMULATED_F(ARCH_CAPABILITIES) already enables the capability
unconditionally, so the new check does not change its behavior.

Thanks,
Ewan

> Thanks for applying the patches and for looking into the patch 6 issue.
> 

