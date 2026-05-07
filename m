Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F622D77E6
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169482; cv=none; b=gOt3HZCDADHKB5nQN923fmk1hSuM8G6XImb7rE6obay1K8reZ3hWtolyFIleI2YWnMXjGOxM12YfReHJRZQHk4iCYhIKJrfJNAW/J4RpRspak5N1s3/0aHYU0jtXaAuZjnHKbe9NgzPX2fVxkuEiGXlRtgt63j6lhEWgbwF1qZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169482; c=relaxed/simple;
	bh=5Wivp9U2yCtQO4QW67/cjygZbRLiFs7wxrSWZOOZJ2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h+Sei0aJfoO67M/oF2h1nfoP3ZkPGNa9qPvww2w0gfRUFFzq2BMT2sGM0OyQ2T/MZUXITqmLT2rh9BBr8eW1axkwp0P9R0scYsXZjLNu/T1vUcDImLeI3SipFPqDly5S+NtKTj/Ko2Z7GT7ZVo7eBitYHGRacKIZpg5j5TxfziM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CzDHKBB9; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CzDHKBB9"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so625030a12.0
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 08:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778169480; x=1778774280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mSziYlZgd3GXeUVegM0+SSnBqSyCsBX7MEl0zdBtNo=;
        b=CzDHKBB9fQpGwcHCzqxfLs3Py1k3La2LiiTg/t3wIrF/1ZuMDwwzsJxIAjPxUtiScb
         pvBQjVRVvgAa9C2ZyZYM40pl2Mh4UZ9SGCHolX5BZiXToTJfwmHPNKVhZOzx59Nbhs82
         Fyd79VXJufFKTgMcTfPWN36UnOtl60Eoeyg0IJHU1LW+SLrez6lQjQt+wHyDFfyuhHcZ
         hG5Iy0tz3+XtTaGcn6XYysIsGKhXBcF4h2MqJn2pHFh8zYkSpixSSZ+xSjxhlNK5JjXa
         Sn8xHY4Crqh8JkwL9PyKLNo+iaCEDg2XbT00gikAhSnaM7MAZ+/LdeZtpAdkq63BUjh7
         o/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169480; x=1778774280;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6mSziYlZgd3GXeUVegM0+SSnBqSyCsBX7MEl0zdBtNo=;
        b=MAKfx87QA0+HzbZggiI8+31IyH7gAKUnPgojw4P6SBqVxgGf63BpOMWrGpCgDSZlRO
         cjSY0UoFIRdFlE/gSUQ9fqnnIHCqRBq9sxVcz40e+i4lvN+WwHsXUguOU66PPmn+H9A2
         eWnyuunjBg6mj+MzPUpSpLN4Uh4QSQi/XvJx2NEhvqBrdBQQbyxpUGYzXPH3dMxQa9Sp
         CIReGELFUH0I0rmZ8pwpbfwObcdYhl2QtwPLQ9QcwWpa9okD9yxrG483ND+pAy43fmwo
         ltU/HTmKXulHnCxVgCe+56hO4Kr5MuuGJyns082ykfLoTnMX9qXFfvBQNiBvvypP4AAy
         cFjw==
X-Forwarded-Encrypted: i=1; AFNElJ8HJpJK2jIFPPt4hctiNY5JWnrXTcGYa1XGxARB9h8znkbQJBAOXh6ZRB5sCn8R0t5N0ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIyo+Z2LeOPpkyVa59I9hWY1YXYoT1juG7WDYqGqprfUFewRHo
	anwwfLlLl9DY8XtiJfGrSp32bwbGVs3qc4OV2mxmVXL39gnfXdxFcxnMkGh+qMnPB9X/f9rRh8c
	QSn04wg==
X-Received: from pfmm17.prod.google.com ([2002:a05:6a00:2491:b0:835:38b2:68c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a90e:b0:82f:51e8:b38e
 with SMTP id d2e1a72fcca58-83bb8499969mr2962562b3a.24.1778169480294; Thu, 07
 May 2026 08:58:00 -0700 (PDT)
Date: Thu, 7 May 2026 08:57:59 -0700
In-Reply-To: <afysu56g2dTFla6-@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <e03f092dfbb7d391a6bf2797ba01e122ba080bcd.camel@infradead.org>
 <afycwi4KT6xrQhMX@google.com> <beff5bd9-ae7c-4f2e-a718-7c8e92e78e4e@citrix.com>
 <afysu56g2dTFla6-@google.com>
Message-ID: <afy2h3RxiKSBh_Ym@google.com>
Subject: Re: [PATCH] KVM: SVM: Always intercept ICEBP, add INT1 selftests
From: Sean Christopherson <seanjc@google.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+AMD folks

On Thu, May 07, 2026, Sean Christopherson wrote:
> On Thu, May 07, 2026, Andrew Cooper wrote:
> > On 07/05/2026 3:08 pm, Sean Christopherson wrote:
> > > On Thu, May 07, 2026, David Woodhouse wrote:
> > >> From: David Woodhouse <dwmw@amazon.co.uk>
> > >>
> > >> ICEBP (INT1, opcode 0xF1) generates a #DB that is architecturally a
> > >> trap, but on SVM it was not always intercepted. Unconditionally
> > >> intercept ICEBP on SVM to match VMX behaviour and ensure correct
> > >> event delivery semantics.
> > >>
> > >> Add two selftests exercising ICEBP:
> > >>
> > >>  - int1_ept_test: verifies that ICEBP works correctly when the
> > >>    exception stack page is not present (EPT/NPT fault during #DB
> > >>    delivery). The IST stack is evicted via MADV_DONTNEED before
> > >>    executing INT1.
> > >>
> > >>  - int1_task_gate_test: verifies ICEBP delivery through a 32-bit
> > >>    task gate, exercising the legacy task-switch path for #DB.
> > >>
> > >> Tested on Intel Sapphire Rapids and AMD Genoa. Without the SVM fix,
> > >> int1_task_gate_test fails on AMD with EIP pointing at ICEBP instead
> > >> of after it. With the fix, both tests pass on both platforms.
> > > Hmm, but KVM unconditionally intercepts task switches.  Is this effec=
tively working
> > > around a bug in task_switch_interception()?
> >=20
> > Not really.=C2=A0 It's a bug/misfeature in AMD CPUs.
> >=20
> > When you get TASK_SWITCH (which always has fault semantics), you look a=
t
> > the vectoring event type to decide whether it was logically caused by a
> > trap, and therefore whether to move %rip forwards before entering the
> > new task.
> >=20
> > AMD CPUs don't distinguish instruction-induced #DBs (i.e. ICEBP) from
> > exception-induced #DBs (all others), and also don't report an
> > instruction length for an ICEBP-induced TASK_SWITCH.
>=20
> Heh, that explains why I couldn't find an equivalent of INTR_TYPE_PRIV_SW=
_EXCEPTION
> in the SVM code.

Dragging in a comment/concern Andrew raised offlist.  If AMD doesn't provid=
e or
*allow* the equivalent of INTR_TYPE_PRIV_SW_EXCEPTION, i.e. type 5, then wh=
at
happens when KVM needs to inject an INT1 #DB with FRED enabled?  Per Intel'=
s FRED
spec, which presumably AMD is following, the event type is shoved onto the =
stack:

    =E2=80=94 For INT1, the event stack level is IA32_FRED_STKLVLS[3:2]. Th=
e event type is
      5 (privileged software exception) and the vector is 1.

But if SVM doesn't support SVM_EVTINJ_TYPE_INT1, then realistically this ca=
n't
work (no way in hell is KVM going to emulate FRED event delivery).  Does FR=
ED on
AMD even do the right thing for INT1 without SVM?

> > The workaround is to intercept ICEBP unconditionally, handle the
> > FAULT->TRAP conversion in the hypervisor, at which point the #DB-induce=
d
> > TASK_SWITCH occurs with %rip on the correct instruction boundary whethe=
r
> > it was instruction-induced or exception-induced.
> >=20
> > ~Andrew
