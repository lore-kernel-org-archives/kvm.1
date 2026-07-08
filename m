Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523D3890EA
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518655; cv=none; b=laKQnxqtMs9kNxsuh+M96ISt+LDSHjnYRJkeN3gFwN54MSJ4OKWmeK2+KjnMbzy7FYfGRMJbOx/FieMpcGHtUM7IPlXuHgNMxtEQfd6Cs8rojTIX/D35SOwIjHejrwEbGoDhBr031uz6MarXV44dxGn61PbHdPg+SYC/Ke+jzi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518655; c=relaxed/simple;
	bh=L4uOmHG0PTeHUhBxML6aC54YVQjpmX+I1J6BRMZtbGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UzJIttval70hMgn21u+TbI4NjEu2s2dHExYShjT1i497opDh9Zc1ogTI5nEZByklxF4fwo7bxCVcGtcLhfCbeK9Y1mJPnYQdozI42x2pM0izPAPxonSaV3Ir3Q+WUxwRoxUAiVpcmjAXjEOJQ7J9Zw5e6vslNjANgUbnXNIY8aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nbKEx5Vb; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbKEx5Vb"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c889d1eebafso1473800a12.0
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 06:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783518651; x=1784123451; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/P+BMIT7lvEWul4mibb3YDGqVJ+qpjKUy25TjmR56qM=;
        b=nbKEx5VbtBt8u31XdApe1Yd2UA7q62wrsre4ao6ZfRGJtKsaidX6UZo9keibCUcl5o
         7chcTbw4wuRpKPHU9HQIZPKdVWyOt/DDKl3hncP807bd0GylcyE80jVrQ1K7Nqmm/sv2
         f354PRQ0BZ7f2ZIeNqwILjoLM0p6bXww1P7hrrveqgrGoQKrWHx22d1Svb5O2f2krX0t
         u8D20wKVa+id9mUT3yYxlWLVZV+Yvlve5YCp79JhjxX0BNYjQTrSvIRD38Ra8GIbZ3WR
         lMskYwNlHMuymmuhsCvhDMrTbSIpI4il37E2wyLU8azVDlZUZ8+OYQXxxOQovMxfs5hp
         dX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783518651; x=1784123451;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/P+BMIT7lvEWul4mibb3YDGqVJ+qpjKUy25TjmR56qM=;
        b=oV5wuubOs6/UQ+PSqIrKA2kIsriEjcMDLKg8M6WSQK3ixtjT+1Zm0UkW2gd3/cnFV8
         4RcnNlt2BYLyNR63ZJlJkoIPrKwC8ZxwMELcFT++vV4vouxy7mnS19HTNDDYDFs/Wkd/
         x/Oq3IOSAOUXscH3GsM1Zqi4c1pDYL0YbkjyiMOSBiUZYGp4TuWkDPMoEIcxkPFwqzcV
         QDNIYvM+2ByAnJdSVNOaeVI28KYM5tUmunbehgbHBQTbe5gh6uPhxgnAlxdK7GOKjIQg
         Md5xOLX5ETQqCrdwKmIDy5abGe6xz+lx8m4LDTB2003RKuhBUXfbXyJRc4qhDU8vKHDz
         ECgw==
X-Forwarded-Encrypted: i=1; AHgh+RrXT3bK80Yd+S9HuvmWuXFefOpYHWwxYPiALFNSL4lCmiRwWcbF7vHzAEJvlAfrtO9JpKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF87g9T77sjGYkCq+j5Td8gUZZcxa5jAZpuJxlueXWpzARY0or
	t+Pm46mVw8AgkL3ydR0zK54bzZQ58zCLfKP68RPJSRZ7j9jz7gmt/NGpJnwT9dLh+w90IxHd+TD
	wktlK/g==
X-Received: from pgjz15.prod.google.com ([2002:a63:e54f:0:b0:c96:acc6:54d6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d0c:b0:3bf:e449:332a
 with SMTP id adf61e73a8af0-3c0bcf15ddcmr3221863637.3.1783518651284; Wed, 08
 Jul 2026 06:50:51 -0700 (PDT)
Date: Wed, 8 Jul 2026 06:50:50 -0700
In-Reply-To: <20260708134101.1073574-1-jerry.lyu@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708134101.1073574-1-jerry.lyu@open-hieco.net>
Message-ID: <ak5VuvKjr8JqFOPf@google.com>
Subject: Re: [PATCH] KVM: SVM: Do not warn on IGNNE MSR write
From: Sean Christopherson <seanjc@google.com>
To: Jerry Lyu <jerry.lyu@open-hieco.net>
Cc: pbonzini@redhat.com, joerg.roedel@amd.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 08, 2026, Jerry Lyu wrote:
> Booting windows server 2025 on top of Linux KVM results in host kernel
> warning logs of "Unhandled WRMSR(0xc0010115) = 0x0", which is due to
> "IGNNE MSR" write in guest hyper-v. According to AMD APM volume 2,
> section 15.30.2, the MSR is "only useful if IGNNE emulation has been
> enabled in the HW_CR MSR", while currently KVM has prevented guests from
> enabling it. So change the warning to a stronger check.

Except the APM doesn't say anything about the ordering, and in typical APM
fashion, nor does it actually say what happens if IGNNE emulation is disabled.

> IGNNE is used in the legacy MS-DOS compatibility sub-mode of X87 FPU
> exception handling. Intel SDM volume 1, section 8,7.2 describes the
> details of this mode which applies to AMD CPU as well. The CPU selects
> this mode when CR0.NE bit is 0, and will rely on two pins (FERR# and
> IGNNE#) for exception handling. AMD later introduced IGNNE MSR to "set
> the state of the processor-internal IGNNE signal directly" in order to
> support the legacy mode without the dependency on IGNNE# pin.
> 
> The current KVM implementation does not emulate this feature, not sound
> necessary as well. The commit 82494028dff648c29e3a ("KVM: SVM: Ignore
> write of hwcr.ignne") clears the bit-8 value in the guest HWCR MSR
> write, making such field always zero, then the write to guest IGNNE MSR
> can always be safely ignored.

Well, yeah, that's what KVM is doing, ignoring the write.  But KVM is also logging
that the guest attempted to write an MSR that KVM doesn't support, i.e. this is
more or less working as intended.

That said, KVM does effectively support the case where #IGGNE is not asserted, so
I think we can simply do this to avoid the useless logging?

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e755f43f4376..a7efac3241c2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3205,7 +3205,8 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
        case MSR_VM_CR:
                return svm_set_vm_cr(vcpu, data);
        case MSR_VM_IGNNE:
-               kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
+               if (data)
+                       kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
                break;
        case MSR_AMD64_DE_CFG: {
                u64 supported_de_cfg;
