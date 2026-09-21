Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E36B4A6899
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999634; cv=none; b=R84yywnpLyQElbPfMrnlI4TPprgLWC2+nolDPqAp/mBdpokd3Vdj/qnuueccBm8836NTjdeM68SRb/nyhQp10xTv9D/hYgubMPgdQ6ZBpEIdHFiqaS11+7EeFTrbQ6/bqMh04+Xxs1UX+/XhLcA+pRs5d3rqSV/hrHNS0nLcE40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999634; c=relaxed/simple;
	bh=i/UcvAt/YkZtUZDVVXvIhetIhWdvHwrWBqqKlaEfp7s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C7jhCxmX4AF1sWdPik6UOHW6VPMf2xocPO0ULOrmaPVlV33CYKjXBYtUk26qAdRHEbaZWzMVWiVGA5pke/v7/KIWlhmCPTDOf31/VC1dszDYkzdvSQlRkFCB1zZYSZ36Hi8k3AKzZBK4w6y9LpXt2YcA1pzyWmlOKEl1FjiiIDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lv+yMTvG; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lv+yMTvG"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8627258ef12so6730843b3a.2
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999631; x=1790604431; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qlm967+2DqooBSKAh8N4dzu7et0Jh35p2pRDxfJUbO4=;
        b=Lv+yMTvGEZfv7WEgk+VT97WGMKUJerUtbPtUneCsRKMJoFdViRBiLna84fwuhpNoeV
         ujW7BbeCGysqMqJh2n1+X1S0GRCr3HosZ/a8YCEfPlTQTccaqiFdvwdxcYwfKcklxPmR
         V2RMav3EfwvQW1otJcSdwBElimmkgdUiAIXXXW7/hwbBafWJDA4xvqOSRAgJLU2F5UWo
         ArqCx90Ys8pcdRlyaCm/jWZ8fqwyR8zINH96qgEIjG3lRZu94Q1CMEwfbtqZ/z+6rwwa
         qzdSK1FyKX3HERyDa00I3xujHNJnLiiBreZmmdnOvc8ApkkzYC1gm3CRloSsKV7aVT+J
         5qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999631; x=1790604431;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qlm967+2DqooBSKAh8N4dzu7et0Jh35p2pRDxfJUbO4=;
        b=wAZ6KVoxqkpWI6rW6aqy+pWTvnv4l70ILG67dJ6KbKB8eXtmpl3STDpFiezyCy2anb
         8D6NrSUje8a4UfeEsCeZ7jJDHtoG1aXSeDYsesrTN/mzspUIDR42JiBBO8WzZtej2v6B
         6c5ZBKAUm125rhj4aVd0jsdiBPMTMG7QbPi4O2I/de/8pyawN70rpWfdg6bTWKp3eR43
         oyNdmZZel1GOmBu5lWJzBQB7Twum4ybd9IyV6ovRCDYlI3/xozqi4ZcZPI2JCfgCHCQm
         jP/TkRVx3kBGErrI5PzDw3rtMFfMkBdSuYvwoOcHItqFai6qFkLhXx+U/Lu9MbOyAP56
         QVGg==
X-Forwarded-Encrypted: i=1; AKwUvBx/qoSq7VVzFxxz/jFh5qOZHaA8l//vP4RUhlhJPTWMsjWmo5TWcdBPcsEdOVeCxK6RBww=@vger.kernel.org
X-Gm-Message-State: AFuF++ko34RzXKMzWpG+vJeWurrQBjMKSEkA7G1R5G8oHMyk4WLKApm9
	udsL+5hgokEzpKU8FvcTUpQWpvmZSlmnJVuDUdAn3xfdP0cOG9HHi0udLVXwrysBjlI+xuGhSQW
	GEdPg3g==
X-Received: from pfrb16.prod.google.com ([2002:aa7:8ed0:0:b0:86b:edd5:baf2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:44cc:b0:874:708d:b63d
 with SMTP id d2e1a72fcca58-874defffedemr17206570b3a.30.1789999631279; Mon, 21
 Sep 2026 07:07:11 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:28 -0700
In-Reply-To: <20260910115414.3015260-1-ewanhai-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910115414.3015260-1-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999920500.751128.15894438912016690895.b4-ty@google.com>
Subject: Re: [PATCH v2 0/9] KVM: selftests: Add Zhaoxin CPU support
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ewan Hai-oc <ewanhai-oc@zhaoxin.com>
Cc: Shuah Khan <shuah@kernel.org>, Frank Zhu <frankzhu@zhaoxin.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ewanhai@zhaoxin.com, cobechen@zhaoxin.com
Content-Type: text/plain; charset="utf-8"

On Thu, 10 Sep 2026 19:54:05 +0800, Ewan Hai-oc wrote:
> From: Frank Zhu <frankzhu@zhaoxin.com>
> 
> This series adds Zhaoxin CPU support to the KVM x86 selftests.
> 
> Zhaoxin CPUs use the "CentaurHauls" and "  Shanghai  " vendor strings
> and implement VMX-compatible virtualization, so KVM handles them via
> its VMX backend.  Several selftests currently assume a CPU is either
> Intel or AMD, which makes them misbehave or skip on Zhaoxin hosts.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/9] KVM: selftests: Add Zhaoxin CPU detection support
      https://github.com/kvm-x86/linux/commit/d80ddf303f3a
[2/9] KVM: selftests: Use host_cpu_is_intel_compatible for mediated PMU
      https://github.com/kvm-x86/linux/commit/9bb23b9e85ea
[3/9] KVM: selftests: nx_huge_pages_test: Add TDP detection for Zhaoxin CPUs
      https://github.com/kvm-x86/linux/commit/54edcc375a46
[4/9] KVM: selftests: vmx_exception_with_invalid_guest_state: Support Zhaoxin CPUs
      https://github.com/kvm-x86/linux/commit/7610139e1ab7
[5/9] KVM: selftests: fix_hypercall_test: Add Zhaoxin CPU support
      https://github.com/kvm-x86/linux/commit/2625a21954c4
[6/9] KVM: selftests: Skip PERF_CAPABILITIES vCPU checks without PDCM
      SKIP: (this is a KVM bug)
[7/9] KVM: selftests: feature_msrs_test: Extend MSR_IA32_UCODE_REV quirk to Zhaoxin
      https://github.com/kvm-x86/linux/commit/658d82c07e78
[8/9] KVM: selftests: nested_exceptions_test: Add Zhaoxin CPU support
      https://github.com/kvm-x86/linux/commit/1a0abfad6c80
[9/9] KVM: selftests: vmx_apic_access_test: Check APIC virtualization support
      https://github.com/kvm-x86/linux/commit/0d5c14800de0

--
https://github.com/kvm-x86/linux/tree/next
