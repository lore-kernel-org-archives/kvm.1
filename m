Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511794A2063
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143594; cv=none; b=sYkYomBHv/TwJZSxaqIOQU4QV9Ymd3p3nRngJnhJ6gvAVm9oD9ChwoW/IRiSyj2AlmSGKWp9Uv2ZPEBu8Bxe+pr9CnzgDwpXbto6zZNGq7LOlgJpDFpEqmcSfOiwSHbJpRhDk33/0osgRB6nUhf2qzUBw4z+Xlqy+OQoGh57wFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143594; c=relaxed/simple;
	bh=0VmX/bfbnx2c4Jtg8/vIZoW31/wztFQKeXEmNZ/1Tso=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zo257NNHkitn8xw6Gj2sYvLfOfxGi+3jwgnhYU/DU5kCoeHnqFfBo2YHpyNNqQ0UIXFZv26H+GdvLwumrJdBkL16nP93W4BEHMx0iCXaEO+MUI+oRkJvjawADiFgq63sdVLHfwubus6u/J57T5A/GV5K/I9MacuMIwV3vVrs2pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=doGOexev; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="doGOexev"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso1539515a91.2
        for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 09:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789143593; x=1789748393; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L2XnLpR3B7NyNraeHl2CA87GE+9itrvfOuyFtdLAXmw=;
        b=doGOexevKxiQ6mnifRQU2B7qaewmsY/ed5Fi3YDfRsgDhihvu4hihst7WEqGz7jPtv
         eb45YjSAucN99vjdw3gKmHTk33ImgdodS0b87fLYHqqKDBFO4ekAEJ0NDoR7MsPZuWip
         QxiuTO8D0x2e3pK7xFMS0xMmZdcQaztiytg+dLTtnXtYf5ZQy/Cp8aIPxDvSoeHp0tp0
         oK+fiFYnVp4oOPCZlLoJucze4uTk9DctHdetJn7ZegJAmTq+DUelcZRTj5l19M+J42Vv
         CSYUy4t559GtjtRCWA8BgQ07kg5Bq3tCCJqNyPQFNJ6+IczXLSFmSM+TrP5aqCsR4FKi
         7USQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789143593; x=1789748393;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L2XnLpR3B7NyNraeHl2CA87GE+9itrvfOuyFtdLAXmw=;
        b=c9LelJmZpY4U/Ct0eyTrgU0LNsRYVgl9h0lF4p2ePgIEkrHgfQKJ3O1xY2NePhKo+A
         x4HRIos01PjcwEPQn3GHQbB0cGE+b736Sm6SudemKbTKugvb6YaoZcTwOnIZyuMqSCkz
         qmTyDMCenFRyIorh5M/NkUtaVbI/GHYulfEQJiihHVR/2ilqBJ5Kbt48JqQUkKVeJBti
         OzczslD5G94nIgbon1/dLBe+jgOQMKSLl28/5DrNFT2U87Qf3ExsnRXJuGNV29sx15QF
         I7i1KmUqSybs2k2A4radestljPFqi5DHHlOyHfGWPXHP9A6ifJ11I7+J0Avxmq01bVlE
         kDuQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUVTAwgX1bYoe6ExlCyrjc6j3/3Hka+mMqzY1o5+AwSmxg6ttcGywjViw1F+6k55waU28=@vger.kernel.org
X-Gm-Message-State: AFuF++lw7UNzsV6xkb5LgNXG0lrjKQJcd6qw3wsqAhorkf5YcVRxnpei
	66ZdqPgzf59Uz6VLu3db3aaxjCm6FRQcGLHqZ79/TqM+Vde2i27AXcfMGYNN4uGuhJQKHldvmGU
	8jATvHA==
X-Received: from pjbmr15.prod.google.com ([2002:a17:90b:238f:b0:39b:411f:f252])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2741:b0:398:e436:384
 with SMTP id 98e67ed59e1d1-39d9bbd7b60mr8793864a91.1.1789143592529; Fri, 11
 Sep 2026 09:19:52 -0700 (PDT)
Date: Fri, 11 Sep 2026 09:19:51 -0700
In-Reply-To: <20260910115414.3015260-7-ewanhai-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910115414.3015260-1-ewanhai-oc@zhaoxin.com> <20260910115414.3015260-7-ewanhai-oc@zhaoxin.com>
Message-ID: <aqQqJysVQxS76YIE@google.com>
Subject: Re: [PATCH v2 6/9] KVM: selftests: Skip PERF_CAPABILITIES vCPU checks
 without PDCM
From: Sean Christopherson <seanjc@google.com>
To: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Frank Zhu <frankzhu@zhaoxin.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ewanhai@zhaoxin.com, cobechen@zhaoxin.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 10, 2026, Ewan Hai-oc wrote:
> From: Frank Zhu <frankzhu@zhaoxin.com>
> 
> KVM allows userspace to query MSR_IA32_PERF_CAPABILITIES through
> KVM_GET_MSRS even when PDCM is not exposed in KVM_GET_SUPPORTED_CPUID.
> However, vCPU accesses to the MSR fail without PDCM.

Hrm, no, KVM is supposed to allow reads and drop writes of '0' for MSRs that are
advertised to userspace, but ultimately unsupported.  I'm pretty sure this is a
KVM bug.  I think MSR_IA32_ARCH_CAPABILITIES is also affected.

Completely untested, but I think this?

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index dd3bb04878ca..fa77cfdbda7e 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -512,9 +512,15 @@ static int kvm_get_feature_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
 
 	switch (index) {
 	case MSR_IA32_ARCH_CAPABILITIES:
+		if (!kvm_cpu_cap_has(X86_FEATURE_ARCH_CAPABILITIES))
+			return KVM_MSR_RET_UNSUPPORTED;
+
 		*data = kvm_get_arch_capabilities();
 		break;
 	case MSR_IA32_PERF_CAPABILITIES:
+		if (!kvm_cpu_cap_has(X86_FEATURE_PDCM))
+			return KVM_MSR_RET_UNSUPPORTED;
+
 		*data = kvm_caps.supported_perf_cap;
 		break;
 	case MSR_PLATFORM_INFO:
