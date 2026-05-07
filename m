Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5FF346FBC
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166974; cv=none; b=tl9WWju/1BEJjdA9zoCL5pArrtJ6LKPSAEYeix7JHAZwOZI+n67iIH25h5jlCU9FshN1sPnzW21pYV1WeylhSy6pcRjb/j/NtHqDZ4ylkvDUC1sT4crk8O3BR8d/pi/IlaMmd9lwIQhWlfJLIrdrOp5J/uApHZXBQ0xxsVtjF0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166974; c=relaxed/simple;
	bh=rTCe/spzl8sWpB3JyRf/iV71VHlHbV7Vj/syx8S65PM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aHOqdOnhppHgJH75DVF6XULFlAAJdXArTGcGTudGOnxNCOby7qfkScx1DCNmAZWDiRx/+Rcb4tQOLAbUuAt7JOOf3t+OC2On/jihj34sB+T8EYqpQfB4KGipoupY/exq7JZ/NtVdTT8K2DqLtMZJ32i8MZ3V9ToEs2vpA9tKrbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eHWLxclP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHWLxclP"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2adc527eaf5so8637785ad.0
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 08:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778166973; x=1778771773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEFnU0WkIB6rhSU+Wp/xuz/eWKdC0rOvy0WXKBVzD/Q=;
        b=eHWLxclP0nDHJN3WJlYk0E6f6vpqi0w3eW3J6CrCHKMyJPst+ab0Dip+ZYIDJwmlyw
         lalZazT0dU868342fwQSSKaWOK4cT5oN03RJZv2Frn9dvL/h4PUQ6JhMqYnGebUuKHN7
         axdJRqOXC3qVfuiB4+U3gjAAgybVpieNBtvBvmFiD6h4O0cCM5cnTBkWaU7o765YPzIk
         sc9TgRQU/Ks8jL71HD1VtQgtsbhGLjqqM1/ysDhIRCfb7Lqx++Afd/dEvktANyzZIC7q
         Jbd+uC4JQ+fMTat5FjFHyZIC9A0b2ECVCQHkUlx8S0B7T5j+RPgkMn8bA/XU0MCtbU6/
         br7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778166973; x=1778771773;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AEFnU0WkIB6rhSU+Wp/xuz/eWKdC0rOvy0WXKBVzD/Q=;
        b=Qr48zShomsCqPbHWCRLg/NuihpV8SxTXFBDzNlfcjc5swh+epD2rPdB9lKCg3z+VeM
         WCNU/dG0EQWi7bqd6CfjYg6MciVgk0Xd2uEWXAvc5+ZpF2GrYU4AWlmeSTtrdbF5/C5T
         LVGuhh5c8NuSMZHnH3jP8e5F83oAKoWam94ToT2myPw/Ff37NfuP0KpJf8hBTlVfsXmh
         Qop112+vJuBR1f2rcKjQPpJpyEemDGGDoy25FBUuFNJXcUcT2EIMZFiAKi9z4ZvEHffH
         H9sLXQluBRdKytU/L0FpgGxeZ7SZjsXKp8TfpE5OCcGaPTW9RrhTPP4dywwzsnrWB3IR
         SJHA==
X-Forwarded-Encrypted: i=1; AFNElJ8cHs96yNX9aGPwmApXkKnaC1RymttoQx88SCyuJo6yLmd9vBQ9sJtEc31ggUMKTakLAoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI0kovp1xHY4F5r7DOxIT2lPOKqQt8KwQEB77xsCZIbNkxQYdV
	R7CCMJXOB13rLn2reDEHHPTwfoGBxJDzZc1mZWAlPfniJ4ewzbn56lAf8vZ2JXf/LdsIAMFIG1u
	UWNlE1A==
X-Received: from plpk14.prod.google.com ([2002:a17:903:3dae:b0:2b0:5102:ab9e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f78a:b0:2b2:4cd2:e16c
 with SMTP id d9443c01a7336-2ba798c165fmr85567325ad.20.1778166972445; Thu, 07
 May 2026 08:16:12 -0700 (PDT)
Date: Thu, 7 May 2026 08:16:11 -0700
In-Reply-To: <beff5bd9-ae7c-4f2e-a718-7c8e92e78e4e@citrix.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <e03f092dfbb7d391a6bf2797ba01e122ba080bcd.camel@infradead.org>
 <afycwi4KT6xrQhMX@google.com> <beff5bd9-ae7c-4f2e-a718-7c8e92e78e4e@citrix.com>
Message-ID: <afysu56g2dTFla6-@google.com>
Subject: Re: [PATCH] KVM: SVM: Always intercept ICEBP, add INT1 selftests
From: Sean Christopherson <seanjc@google.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026, Andrew Cooper wrote:
> On 07/05/2026 3:08 pm, Sean Christopherson wrote:
> > On Thu, May 07, 2026, David Woodhouse wrote:
> >> From: David Woodhouse <dwmw@amazon.co.uk>
> >>
> >> ICEBP (INT1, opcode 0xF1) generates a #DB that is architecturally a
> >> trap, but on SVM it was not always intercepted. Unconditionally
> >> intercept ICEBP on SVM to match VMX behaviour and ensure correct
> >> event delivery semantics.
> >>
> >> Add two selftests exercising ICEBP:
> >>
> >>  - int1_ept_test: verifies that ICEBP works correctly when the
> >>    exception stack page is not present (EPT/NPT fault during #DB
> >>    delivery). The IST stack is evicted via MADV_DONTNEED before
> >>    executing INT1.
> >>
> >>  - int1_task_gate_test: verifies ICEBP delivery through a 32-bit
> >>    task gate, exercising the legacy task-switch path for #DB.
> >>
> >> Tested on Intel Sapphire Rapids and AMD Genoa. Without the SVM fix,
> >> int1_task_gate_test fails on AMD with EIP pointing at ICEBP instead
> >> of after it. With the fix, both tests pass on both platforms.
> > Hmm, but KVM unconditionally intercepts task switches.  Is this effecti=
vely working
> > around a bug in task_switch_interception()?
>=20
> Not really.=C2=A0 It's a bug/misfeature in AMD CPUs.
>=20
> When you get TASK_SWITCH (which always has fault semantics), you look at
> the vectoring event type to decide whether it was logically caused by a
> trap, and therefore whether to move %rip forwards before entering the
> new task.
>=20
> AMD CPUs don't distinguish instruction-induced #DBs (i.e. ICEBP) from
> exception-induced #DBs (all others), and also don't report an
> instruction length for an ICEBP-induced TASK_SWITCH.

Heh, that explains why I couldn't find an equivalent of INTR_TYPE_PRIV_SW_E=
XCEPTION
in the SVM code.

> The workaround is to intercept ICEBP unconditionally, handle the
> FAULT->TRAP conversion in the hypervisor, at which point the #DB-induced
> TASK_SWITCH occurs with %rip on the correct instruction boundary whether
> it was instruction-induced or exception-induced.
>=20
> ~Andrew
