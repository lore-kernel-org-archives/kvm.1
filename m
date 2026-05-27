Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7D0466B5C
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905418; cv=none; b=aN+F/hD+k7/LyVd9FEoqGYmK57Sl/kevADUJceh1asOWWDKuQfiQDrc2SalBri05I6fG677ZDdQtHYX/w5YFdQP1o7kKo5nbsjsnhNhZGz1pQkjZf/0Vt3gQGyOiYtK2z8jzIw0Cnfhy5Ai0ncJcMDiCDUsDLtlNe/5TJXwTL0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905418; c=relaxed/simple;
	bh=qcoe4XBnhTqijbcRrIZ9ewSZixDRZUg2U4Pb6Qkk5w8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Si/3eu5nSo2ytsq0yVT7Stlo94Xv/T2wGIO8PFcRm7WUocSqj0s1XLL1DOfv69fNjsNQ6gbkFdGQU651mFoYPLYn3r5T+axotW7VGlDvn31+PjlKtCJEPONHHGtg6llATQfFBIuF0AeSUSED1T40CLDtcX624xDnh0JMMuWLlPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=btbgbW7C; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="btbgbW7C"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bc977e6aedso129581535ad.2
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779905416; x=1780510216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz5V2AnkDInQJ3fl7CYRLzB5u3WBTi6kbMPgGiC65kk=;
        b=btbgbW7Cd4MhVdXB7yiRCrJfDZTvC/B9YKTeD528Z7CK1J/4s5f6wp5ZstBAtZOJJi
         jcgZxs+cfaIbqWhMfK15w3Bj7pK0oiDG65kaahI0eBkEzoi+UoDGnLvs1dq3pVFsYsn/
         vdIjYSitU6IFHeGh919wnFQnX2kJn2VoViuS13QjHFBj1XjoNTZstPUxrKw+Mz/Amou0
         m3lCxZ+R0YoqTE6Gx4ZdBrEBvqRrOAZFWdFBYacIwdoj0+NH/KmYJZSkU71+BkZSL9oo
         JfL8U+14X+pEtdoIOcPyyiPD7FsJBd2ELXmtsHJpu58dSsJsvcAzdhTN2YubThc0r29/
         7djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905416; x=1780510216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz5V2AnkDInQJ3fl7CYRLzB5u3WBTi6kbMPgGiC65kk=;
        b=TkgJa9NZjmLgGeeapfnsIaghTiEA0fNPLd1+Qsr1J1IxRbXCc2gO0d7pdoQcH8Ce5h
         yDj1SX91pdKlrD8vTSKIB3JR7aijBVonxVYNlu2+S7G7UHTTDQQ8j63F2pNmS6AsqgP0
         y9xsCabByThxZvJ9GV/4F5afeMYERP9+og+jeSOa2Brr4MCMkscDuEAeheK/m5T+0FBr
         v6/GsryrFNcFmgSUtxOQ//m7uXCy76Mep7zSID3wweloV86xn+2cQCXBmm8ETbs7Eju1
         u9q62ZxAzN8SpznhK/aw5rwr9qSXFLPJ0ddkzSkMOxw88cYJP6a3D9b8B2ccgABGB9lJ
         LU0g==
X-Gm-Message-State: AOJu0Yz93Rzgs5ObF27nt4REveYddipxbwaSK82wPpvRttqT2We23sVG
	+OcpHMwkOMMe0kHRSV8aafQWdDNmQwGWsOH4nC+v+Yy/B2CUsvfzEhYZAFfGKBjdBYFNB0Ypppp
	lqB0m2A==
X-Received: from plbjc14.prod.google.com ([2002:a17:903:25ce:b0:2ae:c329:bddd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e74b:b0:2bd:9803:9304
 with SMTP id d9443c01a7336-2beb06cae35mr257998605ad.39.1779905415688; Wed, 27
 May 2026 11:10:15 -0700 (PDT)
Date: Wed, 27 May 2026 11:09:56 -0700
In-Reply-To: <20260515171536.1841645-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515171536.1841645-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177990537439.4122707.14200674992574317584.b4-ty@google.com>
Subject: Re: [PATCH] KVM: SVM: Flush the current TLB when transitioning from
 xAVIC => x2AVIC
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Fri, 15 May 2026 10:15:36 -0700, Sean Christopherson wrote:
> Flush the current TLB when xAVIC *or* x2AVIC is activated, as KVM is
> (apparently) responsible for purging TLB entries when transitioning from
> xAVIC to x2AVIC.  The APM says a whole lot of nothing about TLB flushing
> with respect to (x2)AVIC, but empirical data strongly suggests hardware
> also does a whole lot of nothing.
> 
> Failure to flush the TLB when enabling x2AVIC can lead to guest accesses
> to the APIC base address getting incorrectly redirected to the virtual
> APIC page.  The flaw most visibly manifests as failures in KVM-Unit-Test's
> verify_disabled_apic_mmio() testcase when x2APIC is enabled (though for
> reasons unknown, the test only reliably fails with EFI builds).
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: SVM: Flush the current TLB when transitioning from xAVIC => x2AVIC
      https://github.com/kvm-x86/linux/commit/a9e18aa3263f

--
https://github.com/kvm-x86/linux/tree/next
