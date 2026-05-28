Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12194347C6
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984488; cv=none; b=lGa/zaxgs6yuLZQc+Y8IdluUn4wxr89O+x+MOqwkY74RMdRnknMA9Lg7iAkAn6xubEmkLe3/sNBFYhz3Q9IlHfnOPuKl7In+prlA1ER3T3B0aDngfXUntAJcq5SlqLa6acLZg9d7slCse2i3QyfQnhKCsFC7yuHatqmbiFjI2cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984488; c=relaxed/simple;
	bh=BQEMwhyrh8A5haXsBbov37wycYsrn1vSMAyk8OB4dPY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d4lJfMuyBNs/lf3rCZ/8+8ncJoR92LI7AzxY/qCapP5hweq3skySsa/+r2N3KN1S4S/5TE6KydL3O4k1p9NT2TXhx9FQYJv2Oslaq/ookHdNPfHwoo3a3ul8gCIn6ldOprgYiUC8s1+w8OZnzD/w+QnpQAEIwKc16hgpRFjdmFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jSup77r1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jSup77r1"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8294d8c48eso8414036a12.0
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 09:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779984485; x=1780589285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ek22Fd3FycfLolcYwfif8xkvFpAFlov1T6Xslq0mpiw=;
        b=jSup77r13GYL5o+H/Z5T7BAOwQZT7t9eOkTo+JNfKA062PI0/D+Jdb7hWhi+Ehspqc
         LcV/Njs16iOMLPTZIPIKHfpjvDMzntY6NnNHC7PM1dmGc0bIzwZbyvs1vl9tyPxc+hnS
         rKJ1bHvhzRLDEBpW9FPHylTHLqV5yNokGigyJSVl2SrU3WOaUN4ejfBvbxmI46QSkA8J
         5fdfzt9+0lU11XQuQ4LyAAkWnlcj3s6+xalMsze2v1HGA8OwNAw72DYnvDZk2BWhZMm9
         oVBNVr0ieBrBj0oNkmL+ML6YgBKMGErIVMP26IPxfbMLsPIPHULopbxQOf/IYV+VPPq9
         m2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779984485; x=1780589285;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ek22Fd3FycfLolcYwfif8xkvFpAFlov1T6Xslq0mpiw=;
        b=IBaas6RTzD6abKtBLKZpSXQvllbh38xptL8CXHFHfGIgJJrukbAaKEf/YjZCj+PIg/
         PAGs18pUUIgXL0DnkqO/TfNeeNTqIqhLYQyg7ObkS+3O9Blf15ubKgkWldcW5mEnlpEn
         2x9LtFO4oieymCEe1ZspnekS7rjHHkfe1nrXelOGqhCasGgseFXCDvvc3DvMMSR46++c
         gMV0cwXxgGu+0a2zIsh5+L2icTSZ7MRLsugfSJrYZz4KhNcI3URcWD/Om9GRj/ICxEIS
         cTarefG0arUGPPMNiHFPDJ2g6ik2/OizvIEr6PufAKMFOpS4hqgBELhXssNHtOBOMLOA
         NztQ==
X-Forwarded-Encrypted: i=1; AFNElJ92iI5JuxE0mZNH6ahDwNtYmDXGpZl3N3n7tUx17hHRRf+ibAohc6vRF69U2WlAqbLyTnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhXKiSpUj0hhD2A/RIpw9Up/jrThZ6+/V0LAlVk1OC5s0/2ujH
	N4C8OY3cFmuOGSIxGy9vp/LTe3tNhOgdFnXRTRb5w8NvmPm2J0Ja8u9MbF9ysUO+YhhyrmM/g5h
	ukpgizQ==
X-Received: from pfnp18.prod.google.com ([2002:aa7:8612:0:b0:835:4c30:5576])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bd8c:b0:82f:b0:28f0
 with SMTP id d2e1a72fcca58-8415f544527mr27982787b3a.34.1779984485130; Thu, 28
 May 2026 09:08:05 -0700 (PDT)
Date: Thu, 28 May 2026 09:08:02 -0700
In-Reply-To: <CALMp9eS5xT2PKHW4RWNsY0d9jKpA_xOrOpyZjY8CT6E80W-42w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527174347.2356165-1-jmattson@google.com> <20260527174347.2356165-2-jmattson@google.com>
 <20260528091357.GB343181@noisy.programming.kicks-ass.net> <CALMp9eS5xT2PKHW4RWNsY0d9jKpA_xOrOpyZjY8CT6E80W-42w@mail.gmail.com>
Message-ID: <ahhoYs4B-VUoqhTq@google.com>
Subject: Re: [PATCH v4 1/5] KVM: x86: Consolidate CPUID fault handling for
 emulator and interception logic
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, shuah@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	ctpence@google.com, David.Kaplan@amd.com, binbin.wu@linux.intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026, Jim Mattson wrote:
> On Thu, May 28, 2026 at 2:14=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Wed, May 27, 2026 at 10:43:43AM -0700, Jim Mattson wrote:
> >
> > > [jim: Add EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl) so that KVM vendor
> > > modules can call kvm_is_cpuid_allowed(). Fix typo in commit message.]
> >
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 1578c0ecbbd1..72bd3cddb026 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -151,6 +151,7 @@ struct kvm_x86_ops kvm_x86_ops __read_mostly;
> > >  #include <asm/kvm-x86-ops.h>
> > >  EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
> > >  EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
> > > +EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl);
> >
> > Are you aware of the distinction between EXPORT_STATIC_CALL_GPL() and
> > EXPORT_STATIC_CALL_TRAMP_GPL() ?
>=20
> I am now. :)
>=20
> > Specifically, the former allows modules to do static_call_update(),
> > while the latter does not. Whenever possible use the TRAMP thing, this
> > allows modules to *call* the static_call, but not to redirect it.
>=20
> Sean - Can you fix this up when you apply it, or do you want a v5?

Neither, as detailed in my other response, using EXPORT_STATIC_CALL_TRAMP_G=
PL()
requires switching kvm_x86_call() to static_call_mod().  We can do that, bu=
t I
want to do it separately.
