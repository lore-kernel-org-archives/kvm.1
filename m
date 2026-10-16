Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC1025EF87
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166488; cv=none; b=eMCb11m26Y3uFXGmRM9ctJ4K8E35PtrIFLllNLZfxsL7tLori2b34H0gEnJkKxbvwfuRe2iNBGvykyXbwLWOg1bEf4DHQb3XcQ3xlhlfBdN3AxHutbGh8cWXOAzcoU/9fXrOYv3/38iYol0CwAijMHQhF6JVK3BpbG6K8pbK4l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166488; c=relaxed/simple;
	bh=fhzcePjlzw9yVEu7oOj/cbwjemqzwf+zSSlTyISabsY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n5XNqgoAU3gIMIbmGgYgFuhW02uvrhTV8mcTEAAXIHgPXgHLgt4MX3B+oj6i9nJp0x/MpnwXFC8wQd22V0TLXq6kelojWOsQYi45PxJ0SyQgW5MjLAUX91vljY89EhzFiCW1XVmSeyx+o7ZeeFFcRTVUmh7dummdJJv+uk4ClnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g3ZGZEqO; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g3ZGZEqO"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab2395f104so102891a91.2
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792166487; x=1792771287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D1rfnYRO+IqRRG/ZwKbx1XrlNOfWSfXuey2SabsfEdA=;
        b=g3ZGZEqOeUpFoUdYw4L1Mldn2gb0NZUvKujoUmViPI9sGf5PNQXBTz4eDFpyf+z7Io
         DHfMrQ2lrLNq90NCMkkDPdVWSngwRP5/aSommwR0YY1JJdJOZK8AqgrP37owB3UXB8Lf
         3iSJXTBhislDDv7I2NoKisUGVitue19Z/On7qqgdgXX6oVpHycyXYaDWtCQMeK3DMgGg
         BgGVPktW4NJj1l86x0WIUK7wFWj3ekXe+JSvHPP5+xTe6FOtWcT7utX4pkyy5ED1QLBn
         XLEyyYetf7RE0kUnmUqaRSC5Ur+67nKhjF7zVQ4r7UyezxE8MY5DKzg+4hkYQeiQjTu/
         YoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166487; x=1792771287;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D1rfnYRO+IqRRG/ZwKbx1XrlNOfWSfXuey2SabsfEdA=;
        b=socsTvG1shmp51NBi5weH3RV26ggDcQCJ+OJPUBkJQick4FWCTvwGbEr6NgzymVcAw
         +OyJvyItGCbK7D51fohC45wS2VZ3ZVsxEWxvSHpPnMO8yZ8L4PgNKRPZ94aJkRmrsPtw
         eDKsbgUp/DNkGptqyDcQ8nNkvOm0zQP+K1ctMCm9VjcC70lTHBLbi4s4IqERN7ET8GWU
         I6NoYAR1IOzB48sFR0RImgIBmTB9k++PkmRKQx7uQpGf1oMu/M6Vwi+IG85F+B6EdxsD
         wVhMIkWtgQvUKTjqevxa2iSo+8aQKIzuYl2+hDjXrISsFuTh7/u1aGJBMXr15nvYHyy5
         QIOA==
X-Forwarded-Encrypted: i=1; AKwUvByt7Y4SBs3Ly/jBel0LmR7LqbJ0dGLLGUwnW3O3I+MPruGrom1m/X7xGvVymW1iaxdmnGo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdaADNXZ4vlj71KCKT+qhFf9PpBTMVT24F/Ev8/z2tsXFTU+oG
	6qEVcGsE5JHmbFsIr4AjOORN7jLlIJW2J96DGTi77bUX3tDWo94pv7MgYB0uilXgHvbA2l9oAKc
	CLxPT6g==
X-Received: from pgby10-n1.prod.google.com ([2002:a05:6a02:650a:10b0:cc7:b17d:4d13])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35cb:b0:3aa:fc22:8aa7
 with SMTP id 98e67ed59e1d1-3acef5c49eemr235813a91.53.1792166486289; Fri, 16
 Oct 2026 09:01:26 -0700 (PDT)
Date: Fri, 16 Oct 2026 09:01:25 -0700
In-Reply-To: <CALMp9eRkd-kgBpWTS4nYHaCuDH-PPgB-zvtomBXv-GS7G7M1tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310060022.15120-1-manali.shukla@amd.com> <20260310060022.15120-7-manali.shukla@amd.com>
 <20261008191950.816113-1-jmattson@google.com> <CALMp9eRkd-kgBpWTS4nYHaCuDH-PPgB-zvtomBXv-GS7G7M1tA@mail.gmail.com>
Message-ID: <atJKVRcCsAYewGl7@google.com>
Subject: Re: [PATCH v3 6/9] KVM: SVM: Add support for IBS Virtualization
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Manali Shukla <manali.shukla@amd.com>, pbonzini@redhat.com, mingo@redhat.com, 
	bp@alien8.de, kvm@vger.kernel.org, x86@kernel.org, santosh.shukla@amd.com, 
	nikunj.dadhania@amd.com, Naveen.Rao@amd.com, dapeng1.mi@linux.intel.com, 
	ravi.bangoria@amd.com, peterz@infradead.org, Sandipan.Das@amd.com, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2026, Jim Mattson wrote:
> On Thu, Oct 8, 2026 at 12:19=E2=80=AFPM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > On Tue, Mar 10, 2026 at 06:00:18AM +0000, Manali Shukla wrote:
> > > +     /*
> > > +      * When IBS virtualization is enabled, guest reads from
> > > +      * MSR_AMD64_IBSFETCHPHYSAD and MSR_AMD64_IBSDCPHYSAD must retu=
rn 0.

This is incorrect.  Hardware returns 0 because it (presumably) doesn't want=
 to
translate the address on the fly.  KVM isn't bound by such a restriction.

> > > +      * This is done for security reasons, as guests should not be a=
llowed to
> > > +      * access or infer any information about the system's physical
> > > +      * addresses.
> > > +      */
> > > +     case MSR_AMD64_IBSDCPHYSAD:
> > > +     case MSR_AMD64_IBSFETCHPHYSAD:
> > > +             msr_info->data =3D 0;
> > > +             break;
> > > +
> >
> > These new cases should be conditional. Before this patch, KVM synthesiz=
ed
> > a #GP for a guest without X86_FEATURE_IBS. Now it returns 0.
> >
> > But, is this even necessary? APM vol. 2, section 15.38, says that when =
IBS
> > virtualization is enabled in the VMCB, the processor returns 0 on guest
> > reads from IbsFetchPhysAd and IbsDcPhysAd and ignores guest writes to
> > them. Can't we just disable interception of these MSRs when VIBS is ena=
bled
> > for the vCPU, and let the hardware handle them?
>=20
> Doh! As I realized later in the series, KVM_FEP requires that KVM must
> be able to emulate reads and writes of every virtualized MSR...even if
> virtualization just means "ignore."

Not just FEP.  As proposed, the MSR is intercepted and so what hardware doe=
s is
irrelevant.

I'm confused by (at least) one thing: why can software write these MSRs?  I=
IUC,
they are outputs from the CPU.

If these were read-only, couldn't KVM use gva_to_gpa() with MSR_AMD64_IBSDC=
LINAD
and MSR_AMD64_IBSFETCHLINAD to get the GPA for the guest?  The MSRs being w=
ritable
is bizarre.
