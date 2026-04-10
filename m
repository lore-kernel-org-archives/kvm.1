Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AEB3DA7C4
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775859767; cv=pass; b=imhSwhrXIGg0WLYVavFl/O0IaXpgRzjCIN3gj46aew3X4FVoAV9e8QpKyn8eY50Rb8Hh0tKUZgV2JBBIi+ud/pE+U+Gv54lflGY9Ij4VvE6pcuF2+TkyE3NuqXmv7VNI9R2dr+FdOR6IjSxf6t3t11O9Cryry6hXuXj6Dh7DNMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775859767; c=relaxed/simple;
	bh=5sV0fyoVLne5Qen+WKeWpPoq7Y7uIPbrOFrfTyCf4W0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrPNJuS1efiR64aKqN1Gni+5y9zKPjy0Lg5/a7RNBM1LJ6QUaHJR1RPAhLm/nisUarH25qshuNk1DV2l/rhBC9xluY/h9QnpFqpriLS4SNnrKHjZkWJIgSegP7XHXXUT1RV2dvqJYDQ9CW7LDJx1hExmC7C56xxlrG/tux0CNmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WDZlEuRK; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WDZlEuRK"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67070d9ba4dso14736a12.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 15:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775859764; cv=none;
        d=google.com; s=arc-20240605;
        b=Gh/K7Y8eV9G+ERoAykPMSEn8ZTwBhj1O+YYFlYaZ+kaNsjW179/xQG2+fmXitO/O6b
         XY41n6iwF09hYsIjDp/8+PddNbErCbx5APH9s8nIoHUw4Q+bE4pTm93rveMaH0YwGGtC
         tgTwThMKlNjh5ijVDyuaaYAIkD6B3xhZkl/Q1HVdo4PtE7hbwsw+c6/RMQj6l8mcNzx7
         feZzL0NmBAuEOjsP4s9q2pxC9gdnNfhT0rGwbfsZ8n9TAT8Jrk9U6uS/VNEdoPOq5Lgt
         c9/U9gwQTdNRGEj4LPZUfDCIqEEG02uru07zgewNILgKfLo8N/esiWq/2YZxHY7OW/+d
         t9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dWxTs0UhFEVADlU47jI4rZxNB6bESY/XZWZ4wgzYH7A=;
        fh=crxF0BYBwzjLSjSSKnMXXUUTRuEyf/m+YJHGZs684Fc=;
        b=c9q2XhrShGvkBrJNGagbNz54uJhVVn46jL+6WJkvuZ4sB1Po8k1eBZlS0udoYl2gdr
         j0ISeV5vnQjxz3lDxEuu2dK/HfhBhkOEud/UhdQHkeYbZ4ebHnnkkVJE/sCM8qp+Gjtn
         a5i5z4oyw6Nhm//ndx78cG9JnmJqbahr0NcJHjzfn/ZlphoH8UzyRt4bAMP6mGxmnQCv
         NlD/sw7778WsvOO3sGPXBBUhp2bihysmHYfAWgIXZhFmX241BZI29p+hMUMP+QWI+ri1
         G9b9nyZ3+3JvTvjAcUPz/zR6CKQ2eZtqtaDnrmaebtsleagKAKL6vm/aGxD4Gk5hkoL6
         96Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775859764; x=1776464564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWxTs0UhFEVADlU47jI4rZxNB6bESY/XZWZ4wgzYH7A=;
        b=WDZlEuRKCHWZtApJFqjbxrC5o1Z6gtEfmcKS9bWKmoEZ6s8QBl2PNoWLMQA6o0ExVj
         aM0pZBMb8eaVbyIQmnAeVs8ba6fEqbgQe+Tj4C18+bIQnKGiY+OpyzZFkB/v78jJzjgh
         Wy285Ia7JTM3qHHUdyNNWneBnlssoB4EwtyK3b0VWHOv5qej4yFfZUVEB412iyxT/WkB
         k4EAGwbFpbpCxISURPAchBBgkLfu2+7Kp6qSbGld5Lv/ZJitzbsF/HzqyIcHyk+/magO
         GRHvWWS8D5mxeXdED6I00iIf6oqmWfaWmdki++2NFAzWTHXSquyG4aFsIHPLHBKFnCv+
         UH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775859764; x=1776464564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dWxTs0UhFEVADlU47jI4rZxNB6bESY/XZWZ4wgzYH7A=;
        b=glSD61IofJW4WOJsslbGBGRo+osv4dDoJpHg28xiixGJ9NCin4H4uDwnpQMfhVnulP
         Wf/6OKn3mH96i3jB+0GvNin0xtqLSbHjEEEcMjekhogdhZPprX1pq1TgOpty92yMTQhe
         v/7NMWrKblY7jDOkKp3P/NsUvaPSsUbowfuQT3iJcc6kUodxbls7YeGT8kCSktG/Cktc
         rJknNWcbDtq812E2YQz0uJuaK16N7ydZmwT4a3/TSoEu3hNmmSvKtJFza7x5lo/IiNGY
         RZNwCTiD9/joPvB5brZiCeNrwT/CPSZ24r1qTwv3brWpfzSzfIHNFJ4wFvkp65VaK2EP
         diXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCuDONXC0p0YuU2En3Aiy+HM88tEn++hH0+wZtSpAfpMJDJcFi6TiSgf5VyE4cytJ4gHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySz4FEdlRuZ+KToZiwt3xoAvy2q/Pz+zOnpbECdfQOB/8NpgMs
	6co/UobF6XwLw9M81L5pBcabyTDe3yDbkGjh45XNW5wD+4FSH96+6Si3fTL6xGnXfxvM1YIwhUL
	hvvdj1tF3GdYhpIhobCKoX9AaXP+ILnUbCjFVz5ln
X-Gm-Gg: AeBDiesXnsgp8LT9lr2klbV59QTVAfvkq7dhRfCu4WiaOsfxgSRFC8ouFPQQYjmoekP
	9oKx77Rr9NYGis7MmEcFzeY2b0XhtID2f8kcSLBc+0DR2zY6spS1+lCoUpbL1orqZcJqFMfVbfD
	zMiZ4Sq8sjQFqnS1/6+U75LPceyjYFV0+kCs+62s2V6Zi0CuJ6gqHQkyK+ft4wRj/XtjqCiIejc
	CgjBV27kouqfy5iO9axvYE3uTCxgo07+r0cLyPtmp//gmO5G3HDyJFzm7pja60GJQy4zkyB3sTc
	MWzc6tGTzFjmWVRV7yU8LGX4Y6dP
X-Received: by 2002:a05:6402:26cc:b0:664:eadc:7262 with SMTP id
 4fb4d7f45d1cf-6701e2ad1e6mr149856a12.13.1775859763640; Fri, 10 Apr 2026
 15:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402223108.650572-1-jmattson@google.com> <20260402223108.650572-2-jmattson@google.com>
 <adl30JQXxxQGmHvj@google.com>
In-Reply-To: <adl30JQXxxQGmHvj@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 10 Apr 2026 15:22:29 -0700
X-Gm-Features: AQROBzBPJqBkmwQWBKn_x66e1ny7Ah7maxTYcpMJflkeizG3bpZTClRBQ8ejwG4
Message-ID: <CALMp9eRgF7+99P+-jjROastwJyfHEQE60pa=guFvC0KsDoHeEg@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: x86: Rename supports_cpuid_fault to supports_intel_cpuid_fault
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Clayton Pence <ctpence@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 3:21=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Apr 02, 2026, Jim Mattson wrote:
> > The function, supports_cpuid_fault(), tests for guest support of Intel'=
s
> > CPUID faulting feature. Rename the function to supports_intel_cpuid_fau=
lt()
> > for clarity.
> >
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> >  arch/x86/kvm/cpuid.h | 2 +-
> >  arch/x86/kvm/x86.c   | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> > index 039b8e6f40ba..51cbe67c992a 100644
> > --- a/arch/x86/kvm/cpuid.h
> > +++ b/arch/x86/kvm/cpuid.h
> > @@ -181,7 +181,7 @@ static inline int guest_cpuid_stepping(struct kvm_v=
cpu *vcpu)
> >       return x86_stepping(best->eax);
> >  }
> >
> > -static inline bool supports_cpuid_fault(struct kvm_vcpu *vcpu)
> > +static inline bool supports_intel_cpuid_fault(struct kvm_vcpu *vcpu)
>
> *sigh*
>
> I was going to suggest supports_misc_enables_cpuid_fault(), since KVM emu=
lates
> the MSR for all CPU vendors, but the enable is in MISC_FEATURE_ENABLES, n=
ot
> IA32_MISC_ENABLES.
>
> What if we just drop the helper?  There's only one user.  I.e.

My thoughts exactly. :)
