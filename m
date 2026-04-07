Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618FF38758D
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775605954; cv=none; b=ZlzUsMSEBG+hQ+P3xE49KW2C3z9pOv8pmdhILgBBhdj6udultuT0F5MpnvrGnZIC00e9FDeoC21fQnqeBWm4puGCW/DS37nrqrsTd13XZvC/6i1zxA0nuCCO1qYFESqDYSNvmyrL3qG3prRns8qp1TfbosgYDT1Kr/DtastwSHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775605954; c=relaxed/simple;
	bh=SdsNngXjH3hSHT9gMgfDRt8l0hAzE4oAuI9Clo4mOaQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VPRW0XYZGI5U6ADsQ0rFC88o2hlG2q0P/oZ69787Phsj7Yr5E9daD04BrXw3Ai9Va2jhD21NtAg1xtWghnJEqr6Icc+5DJarHeBTzpcidIQPkpS0OagjGh3aXPu2rh+MF3OsxOtbE/dCeZQUi93DLHMqApUOyfS2zShUpw+cIIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fjJdjc5M; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjJdjc5M"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82d42b6f2b0so1296437b3a.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 16:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775605953; x=1776210753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iz2WszebLY+x/oGqa2xe58ntUzkUx8FiRFvZTUBudmU=;
        b=fjJdjc5MzbX/wpI0xFIRK4XtA0SHAzoxMdD4zA2T/S3UpJH6QLjgsSiHAe/PmUZ3wO
         Meh4NpkvY0RcQb4i/ullE9Vc+MTdQ2EX0M3BbX5yoJ+FzmrNItpoCuDiCSA+Jcy+V7yc
         pYSjeZ6+pcc3S4/uj7N+vMliNISfvRrUT8O397+ipuCIcHIRBOeuc2Ne/jBc+k/saLN9
         B6e7a4S8t6wzpJhWqZyD+YsDW66QC//ha9DegQyp/zMM9/6Pl9I4mK34WrrjeajNxVMU
         KuTElwBcffFP+HpdrQmlMQrWIXuxs65sgjJHZDBdTAcTN4+d19D9fO3u4i3XeyGS7Tr4
         r4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775605953; x=1776210753;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Iz2WszebLY+x/oGqa2xe58ntUzkUx8FiRFvZTUBudmU=;
        b=e92Tu7OU8t+xpYrlH/JWKj2oVsP57IyyTXRMmbNWwsUY0M8IVlPLvMSgjWDo8s88vM
         L7YmmSe86/QYS1Qbpj+Q9ukO+yHAhEG/GXFmXJtaorqO39d7+QMQ0Aooy2mHg6IZywnh
         SHr3x5Xvb9QJ0LRElprWJb0F6axlUJN0HjZFb+/JY8mJfBMtABGh1YOIdYuuBp0yc9eF
         +Xyp81XS2a3dfLsQYEa3dVcbA6B/GYqapF6cMhqTEK7vySNOg135XdpSYwlhAKNtHq0S
         Bn4/geB2CwoVji1udSVo/yEIHk1AYodGwbsbXL7J+865InX++YW9RsGp1dNZK0qVSQmj
         zG1w==
X-Forwarded-Encrypted: i=1; AJvYcCUD3HldL7fbSKEOf1CWtWZb4HibAguPwGVmwRz6GoYTUSsd3qRwQ97WdaQM5e9A+FNjBv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOEQBq6K9mIcfjva2stig8CCMCu4T3korLsVwySUPkyu+QnqQJ
	5IsTaLy/M4E0udYeje4Ms36XjsBISuXjUFHYCPVxpMzloiCVYrnzjJ5vwN7721iFE3zmsau4zPZ
	gQVUGag==
X-Received: from pfcp1.prod.google.com ([2002:a05:6a00:a241:b0:82c:5b7c:f4ce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c14:b0:82c:2480:4e95
 with SMTP id d2e1a72fcca58-82d0db4fcaamr17900679b3a.33.1775605952332; Tue, 07
 Apr 2026 16:52:32 -0700 (PDT)
Date: Tue, 7 Apr 2026 16:52:31 -0700
In-Reply-To: <CALMp9eS+XiJ=u2618Hke9ePyzeTuChU=dLt+e=x2nXLTMVH5mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407190343.325299-1-jmattson@google.com> <20260407190343.325299-6-jmattson@google.com>
 <adVZ7-EiekghvDMD@google.com> <CALMp9eS+XiJ=u2618Hke9ePyzeTuChU=dLt+e=x2nXLTMVH5mw@mail.gmail.com>
Message-ID: <adWYvwA2BzEj7eDE@google.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2026, Jim Mattson wrote:
> On Tue, Apr 7, 2026 at 12:24=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Tue, Apr 07, 2026, Jim Mattson wrote:
> > > When KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled and the vCPU is =
in
> > > guest mode with nested NPT enabled, guest accesses to IA32_PAT are
> > > redirected to the gPAT register, which is stored in VMCB02's g_pat fi=
eld.
> > >
> > > Non-guest accesses (e.g. from userspace) to IA32_PAT are always redir=
ected
> > > to hPAT, which is stored in vcpu->arch.pat.
> > >
> > > Directing host-initiated accesses to hPAT ensures that KVM_GET/SET_MS=
RS and
> > > KVM_GET/SET_NESTED_STATE are independent of each other and can be ord=
ered
> > > arbitrarily during save and restore. gPAT is saved and restored separ=
ately
> > > via KVM_GET/SET_NESTED_STATE.
> > >
> > > Use WARN_ON_ONCE to flag any host-initiated accesses originating from=
 KVM
> > > itself rather than userspace.
> > >
> > > Use pr_warn_once to flag any use of the common MSR-handling code (now
> > > shared by VMX and TDX) for IA32_PAT by a vCPU that is SVM-capable.
> >
> > Changelog is stale, but otherwise this LGTM.  I'll fixup the changelog =
when
> > applying (in a few weeks).
>=20
> Oh, crud. This was supposed to be 5/8, but I made some changes after
> checkpatch.pl complained and then tried to just regenerate this one,
> but I totally flubbed it.

Huh.  The patch shows up when I grab the thread via b4 mbox and open it wit=
h mutt,
but b4 am skips it.  I'm guessing there's version-based filtering somewhere=
 in b4.

No need for a v9 on my account, I can splice in 5/8 when applying.
