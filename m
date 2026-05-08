Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060B2402B84
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259382; cv=none; b=C5N5mmBXsmZFDc34RD/bzdAYqUmpS07x5SGLzlnowW4+YgODYc7DUkKK6tpBRZFvsQ8IdxOKZXClVpNccOvp92ZSfqiUgL15P5ySHdlOrjW7/3Zc156FvqYddQP6yuBFziGogHkS+d5L+3WC2WyWLVmz+504liRAl3Qrp4c6Mv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259382; c=relaxed/simple;
	bh=66xQ9hvgPBkJ3px3dbJV8/A2nMv9gis7LD/9zeIwN0s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fbzJwGzf6r06lzV2wbQzzEdqwlTr5wzBo2BFzbT+6JAhluXcs6//48rpbAR4KIpvDmLzvhSchwhPaYHsNqVRi+0qKzbJMquogqg0fr9hK4qSDH+EedFSACgiZS6PTCWcMA4DKLV3AzYHlM/KYMwoNf+Z9Y4SGXjZQgZTi+gPfGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oyl7ZXXQ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oyl7ZXXQ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-835444b6ce1so1689641b3a.1
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778259380; x=1778864180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kPUg8AJeQU9327pVVJCUJnpHdi/ApUr9lgKthU63V1E=;
        b=oyl7ZXXQxL7cEC/BHpm6kX0yZ6euVkkg/BIku6ZGQT6by9Wk7sUr11IlZVIiR8OaKt
         r04KgF4IXP5XDaCt2EvW6mrqE9rZFodSKNe3b5R95pdGyvxS5QHFCHhlVYcFsmaJ0oZy
         F60KhymSnc5KGI7Aj1Mx+4WOJ7o0v+A5XqpDQURgN47ehh7J/w26gSzBet5YSp9gIZUH
         QUna5H2AeE4eCSrBPngjOWCxF8knooqMGVXfw58VFd9pa5mTNaTXzAHX6SgGxwC+MCGW
         dnmwaIs21pqdJGrnXgjx0sL7tyGd69pKKzNaUGwX+UAOtXj7k0Q+8+GJZP4euO/PBE9g
         W3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778259380; x=1778864180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPUg8AJeQU9327pVVJCUJnpHdi/ApUr9lgKthU63V1E=;
        b=UKGjF/qBK3U1n44P9gpjrCkVOdGSy/tyblDcu6Kd2s3Vzz5+wJ1DA9ZuUt07/AUqH5
         xfXP3w01NWrH48RB21wQxDzTwZZOCuQv2X46cCt6qcJcDO2vJh2YOeHClAZa5jQx4ia1
         qEgmR18q7E+ndxhHRqQEPRk+s7m5h9pA7p7duLTkYUvfbGCpcdv7zzy3LIpx/2tc1niM
         apqwUwdUeKtQQS1DLG1gSeExP9EIL+KGb49cS66M/pi0u7xg2BzlXR9ITsKQQzRNcvhH
         0mb+fd9Ud7hlYjm8445VanlCDIkNNj8jW79q5gdOSBDPr/sDxHL4zFiOl+vT7QlaWwyb
         qQnQ==
X-Forwarded-Encrypted: i=1; AFNElJ//dPYJBsFthQHSRFa0uwmE65T3qBpZDLNI4DbtuWQJqrLXw27hyOaz+6RCfprM9wSgKHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSMKIGVlQNN73eol3TblghpQ0+Tc/5yQgsjhdod17Hv6noQ3JX
	ByHdWZPPqdHxRbjN15GLUHLieOS8I7LNSjq3A/KBG4eMtMnXobJEwWwJl//jV+6l0ToNyDk4IwC
	1QUGF/w==
X-Received: from pfwy14.prod.google.com ([2002:a05:6a00:1c8e:b0:82f:6658:1e84])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4d98:b0:83d:632e:a8df
 with SMTP id d2e1a72fcca58-83d632eac6fmr1943881b3a.40.1778259379933; Fri, 08
 May 2026 09:56:19 -0700 (PDT)
Date: Fri, 8 May 2026 09:56:19 -0700
In-Reply-To: <af4Q2wkQPtYhwC1n@blrnaveerao1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506184746.2719880-1-seanjc@google.com> <20260506184746.2719880-3-seanjc@google.com>
 <afyfFRkUIHuodvG2@blrnaveerao1> <afyzRvFqb19Kodej@google.com>
 <afzZR3S43Ebr4khL@google.com> <af4Q2wkQPtYhwC1n@blrnaveerao1>
Message-ID: <af4Vs5PHGOeFm5DW@google.com>
Subject: Re: [PATCH v2 2/5] KVM: SVM: Always intercept RDMSR for TMCCT
 (current APIC timer count)
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 08, 2026, Naveen N Rao wrote:
> On Thu, May 07, 2026 at 11:26:15AM -0700, Sean Christopherson wrote:
> > The only reg that's at all hot is Timer Initial Count Register, and (a) it's a
> > moot point with TSC Deadline mode, and (b) the cost to program hrtimers is so high
> > than shaving ~10 cycles is completely meaningless.
> 
> Thanks for the checking this - this was something I wanted to check. And 
> I agree with your assessment. None of those registers look to be 
> commonly written to, and ~10 cycles is almost in the noise. If we ever 
> come across a performance issue, it should be fairly simple to pass 
> additional registers through (with good reason, of course).
> 
> On a side note, how did you measure this? My naive attempt showed a lot 
> of variation between runs.

I hacked the x86/vmexit.c test in KUT, and then ran it with and without x2APIC:

  ./x86/run x86/vmexit.flat -smp 2 -cpu qemu64,+x2apic -append apic_wr_lvt0
  ./x86/run x86/vmexit.flat -smp 2 -cpu qemu64,-x2apic -append apic_wr_lvt0

That test super useful for micro-benchmarking single instructions and/or short
sequences.  Even without pinning vCPUs, it does a decent job of generating stable
results.

diff --git a/x86/vmexit.c b/x86/vmexit.c
index 5296ed38..1749cbd8 100644
--- a/x86/vmexit.c
+++ b/x86/vmexit.c
@@ -22,6 +22,7 @@ struct test {
 
 static int nr_cpus;
 static u64 cr4_shadow;
+static u32 lvt0;
 
 static void cpuid_test(void)
 {
@@ -447,6 +448,11 @@ static void tscdeadline(void)
        while (x == 0) barrier();
 }
 
+static void apic_wr_lvt0(void)
+{
+       apic_write(APIC_LVT0, lvt0);
+}
+
 static void wr_tsx_ctrl_msr(void)
 {
        wrmsr(MSR_IA32_TSX_CTRL, 0);
@@ -501,6 +507,7 @@ static struct test tests[] = {
        { mov_from_cr8, "mov_from_cr8", .parallel = 1, },
        { mov_to_cr8, "mov_to_cr8" , .parallel = 1, },
 #endif
+       { apic_wr_lvt0, "apic_wr_lvt0", .parallel = 1, },
        { inl_pmtimer, "inl_from_pmtimer", .parallel = 1, },
        { inl_nop_qemu, "inl_from_qemu", .parallel = 1 },
        { inl_nop_kernel, "inl_from_kernel", .parallel = 1 },
@@ -618,6 +625,7 @@ int main(int ac, char **av)
 
        setup_vm();
        cr4_shadow = read_cr4();
+       lvt0 = apic_read(APIC_LVT0);
        handle_irq(IPI_TEST_VECTOR, self_ipi_isr);
        nr_cpus = cpu_count();
 

