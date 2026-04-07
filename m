Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1529352F87
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589875; cv=none; b=PFQ4diiOvClGI0pYwZbe3e3OWyRfGNEPyHfdiElWskxVxwLuoTD7yfdEguOBDZzPwxa9jMquKF8ljIiNRjl9myuobkN4Sxd3pzch9dK0ZJLAP7gwd+bih01nFj7g+SsCWit+LOjqh3DNvj0xMr1qIzdDEeP+wcR/fI2+JpetF1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589875; c=relaxed/simple;
	bh=dE58CN+5pXsLJfZ7un3dRhyZAs4NnQnCZRafu7/oZ+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OAIO7odJRwdYTz8YN3bENFIHTOAs9Kh3k7S/+Uzmin2vrtf84uby9ZGnaUC0melJtsd1tC90bcKS4tnMeMXNHQsL1l/hhOY2BbONDgrPyY9YWFCFz54duspK+Z9GPJy7nF+Jy/D3t92hu6m2EqawIv0cCV+4pEF0EEZoX6Zukn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u04P3Yjf; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u04P3Yjf"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76c60c74f3so2726745a12.2
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775589873; x=1776194673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7wtvvz53Lt7PgkZRoHfUIRVyXND3bHhDv8n3Lk1Ll8Q=;
        b=u04P3Yjf8H1IW9ka1QTHanRsghO0/EckAAmNRH1/lTjmLXL7HRhSoX4Tge3KKqdoKH
         LhEX5Mj2XvqDs9oiH7jMb3RmRojpN8clCPOFanXhKsSj/72iFC9SUSmqiqZ3LY8us0I8
         8OPEt+2nxQ8WuDy2Ac8EHCIoKt4lIx2gNZuguJRFr1WkxGW8zftUmAQFZXI02jNIp6hr
         41hVR9hVS9HAhii0MZmi4E8gToEVLovSEcY8dkoi4egwLgFyx2Jy30AKxQPIa9lP/9iP
         I8j/KIV0/J1rT9SV5HaLrclMbJLBOW4NYqZnCoJJfH+l8RHE9+R+HoGlpiT4A8tUpgu9
         jXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775589873; x=1776194673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wtvvz53Lt7PgkZRoHfUIRVyXND3bHhDv8n3Lk1Ll8Q=;
        b=YO2Wjvq23eP58vbpkK5Q4TEKvU1inMudTBQI2RollY8n4H2+PYn6lLl0IrIwhZJRJt
         D2IfzUL+u15MwaseW3jH8EJCdEPwrwSJ7wNAmU1QkSUMRzx1p3mwAhhu9tgfIuAykEmJ
         kWCzV/7wK6RcKX9MMj6VPDPHJQDLSi42cMzSsS1eb117MQ67/zaMcvY9RnO9nDpR3lOB
         2/Nlvxa0HF/vusuRYUEdgkLOsgCu8KFNP0rt4UA/UAND5tMxWZI4pURdkEAim7rPX6ut
         803wzKtZR5dKeZ2UImsfD2npuvfx2nVvzvjm40BY8THS0er1Nd9opxVCYWQ5otEet/3h
         0c8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGnBP4TwffYj00D+O/X8bwY8FjEEN2HXYFtNtlef0x5RnXNIH3hREtgo39HUuxgMPSEXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQHMBElJsTaGQm5mVLT3XBfqTUQB2aLc8nUPkIIMar66YkTYx
	5JeVQY94RSRr6gBrVs1k/7w3HzCzBSsSgfGgTF8H+fBXdUx9bjrOkWt2d5lImHIR3nVVV2DNFW9
	qEFbLvA==
X-Received: from pfqf9.prod.google.com ([2002:aa7:9d89:0:b0:82c:ed07:26b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88cd:0:b0:827:2ee0:411f
 with SMTP id d2e1a72fcca58-82d0da46a75mr16920069b3a.4.1775589873116; Tue, 07
 Apr 2026 12:24:33 -0700 (PDT)
Date: Tue, 7 Apr 2026 12:24:31 -0700
In-Reply-To: <20260407190343.325299-6-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407190343.325299-1-jmattson@google.com> <20260407190343.325299-6-jmattson@google.com>
Message-ID: <adVZ7-EiekghvDMD@google.com>
Subject: Re: [PATCH] KVM: x86: nSVM: Redirect IA32_PAT accesses to either hPAT
 or gPAT
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 07, 2026, Jim Mattson wrote:
> When KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled and the vCPU is in
> guest mode with nested NPT enabled, guest accesses to IA32_PAT are
> redirected to the gPAT register, which is stored in VMCB02's g_pat field.
> 
> Non-guest accesses (e.g. from userspace) to IA32_PAT are always redirected
> to hPAT, which is stored in vcpu->arch.pat.
> 
> Directing host-initiated accesses to hPAT ensures that KVM_GET/SET_MSRS and
> KVM_GET/SET_NESTED_STATE are independent of each other and can be ordered
> arbitrarily during save and restore. gPAT is saved and restored separately
> via KVM_GET/SET_NESTED_STATE.
> 
> Use WARN_ON_ONCE to flag any host-initiated accesses originating from KVM
> itself rather than userspace.
> 
> Use pr_warn_once to flag any use of the common MSR-handling code (now
> shared by VMX and TDX) for IA32_PAT by a vCPU that is SVM-capable.

Changelog is stale, but otherwise this LGTM.  I'll fixup the changelog when
applying (in a few weeks).
