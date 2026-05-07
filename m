Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA4C386C0F
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778162884; cv=none; b=f7miJDNTYT/U6cRdWJpBvwnwd/TFHXa15b9aAe2sFF+dzjOCvqfYzjxcIFRGq3VNYHZINUEyfy4IFoorQx9V/2KsN11+1o9PNG+SugHaf3kBRTf3R/BjDpwmy10uGIjyu1smKJpgDOplvzpLpeVIsz5XF+QCMPcNG0r6IO9QdjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778162884; c=relaxed/simple;
	bh=W+3hLwQ0hj3qVORYRs5AQRweLebKBlAvazuaaX7+sK4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tdlpfu0KpMTG/k5SLQStXyEEMdsrj5h8dWAJO8KZtFIWgF2olhhSav31VNW6puB//rIiD1Q7j0c25wPjzkp22uTQ0foe6awtycu7lkfz/20PIWgYZvbveVWEmLpE5viUCBwCqHovDWZPElRFe7wxlm9s6K4Kpbt3CXqOsKLot4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KalME8XP; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KalME8XP"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c822ebaa40dso509328a12.0
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 07:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778162883; x=1778767683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zsPYNiTO0d4dTuGIfilD1PNNAucYT/R7gdAoYKJvfdM=;
        b=KalME8XPcZqYn98z4fA4p+PVvSKWMgDz5wrgcASx/mHqhg3xozdPHx69TZ8Z+wtDZo
         EO7Kqg4q+rlKda5e6IMB0hM5mkKoXKfW27adYoLHwSVcv9Mx/IZdtKx69KUBC6q99BAo
         82IAPc7oksvFmIR6uMq3Z9/hKjmv7qM0Q7kLU/+wXiXu93Bs2bl763ysn6fr75EHXIID
         BSdWElp/aENoy1btSgbpOlOiz+ukBA8N8kNJQEjO0CDvTQ8Owu/jsUeO7ugGCe5MhRg/
         9ibPYIAFRi8ytCyXmIYmHBgTd7TvXeGizeezt3yl04GmdovEK3fjMaeyEtqD64mLHVp2
         tS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778162883; x=1778767683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsPYNiTO0d4dTuGIfilD1PNNAucYT/R7gdAoYKJvfdM=;
        b=kAWXI/C4lDElO31mNxN+K31DHHiE0bl5S30iWpnMMzgjpg0jV91UDy/C2+n5ALtA5h
         fDzj6zQF0OHsl/SgVJLwSxtF6wOQYebhIFN4P6rUQnzaykGcwGEugDN3HzZCVphvj+oi
         CaJvdULm1/e8qMzBMBvgwXcicDUUwIZEAbsYddzmxPQkQDTwTe1UzsP/NiL44ZP6pTRs
         2n58Pz7e2+oifiVCtNq7ZgDva4jJISt+BUKETYOuLGXzHgPBRTRJdB3A4HTKUM5c6+Gt
         WxxgOq6c6csZNSqLPixnEkfISR4m58gXZhMSHVwQekSPR3xkAM7iHtjX9k1+y4pg3snK
         EJDA==
X-Forwarded-Encrypted: i=1; AFNElJ/FJ81piVAOG1PlWcP5/YhHxdLHx7azeCvtIWAoR0cC1UZRQtNt2ahGQg8JPT5UOYvPdjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaejHwoehKJ/Eyb0sHMR58glA1F2RGh4YIjjYvWit4xUSzFqDr
	dLL43BwnRqAIRJ7KyaBdlSXLILtnWi5g1HFCt3q477W5Xhi9pFIDqKkIazS/0AEUCKd3qGJYo/d
	DiR8fvQ==
X-Received: from pgct20.prod.google.com ([2002:a05:6a02:5294:b0:c79:5e8e:1248])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a11d:b0:3a1:ed2a:1a4f
 with SMTP id adf61e73a8af0-3aa5a960e38mr8783458637.16.1778162882616; Thu, 07
 May 2026 07:08:02 -0700 (PDT)
Date: Thu, 7 May 2026 07:08:02 -0700
In-Reply-To: <e03f092dfbb7d391a6bf2797ba01e122ba080bcd.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <e03f092dfbb7d391a6bf2797ba01e122ba080bcd.camel@infradead.org>
Message-ID: <afycwi4KT6xrQhMX@google.com>
Subject: Re: [PATCH] KVM: SVM: Always intercept ICEBP, add INT1 selftests
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrew Cooper <andrew.cooper3@citrix.com>, "Saenz Julienne, Nicolas" <nsaenz@amazon.es>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 07, 2026, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> ICEBP (INT1, opcode 0xF1) generates a #DB that is architecturally a
> trap, but on SVM it was not always intercepted. Unconditionally
> intercept ICEBP on SVM to match VMX behaviour and ensure correct
> event delivery semantics.
> 
> Add two selftests exercising ICEBP:
> 
>  - int1_ept_test: verifies that ICEBP works correctly when the
>    exception stack page is not present (EPT/NPT fault during #DB
>    delivery). The IST stack is evicted via MADV_DONTNEED before
>    executing INT1.
> 
>  - int1_task_gate_test: verifies ICEBP delivery through a 32-bit
>    task gate, exercising the legacy task-switch path for #DB.
> 
> Tested on Intel Sapphire Rapids and AMD Genoa. Without the SVM fix,
> int1_task_gate_test fails on AMD with EIP pointing at ICEBP instead
> of after it. With the fix, both tests pass on both platforms.

Hmm, but KVM unconditionally intercepts task switches.  Is this effectively working
around a bug in task_switch_interception()?

> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kvm/svm/svm.c                        |  21 ++
>  tools/testing/selftests/kvm/Makefile.kvm      |   2 +
>  .../testing/selftests/kvm/x86/int1_ept_test.c | 116 +++++++
>  .../selftests/kvm/x86/int1_task_gate_test.c   | 298 ++++++++++++++++++
>  4 files changed, 437 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86/int1_ept_test.c

int1_host_page_fault_test?  I definitely dont' want to call it "ept" since it's
valid for both Intel (EPT) and AMD (NPT), but int1_tdp_test isn't accurate either
since the test is also valid for shadow paging (at least, as written).
