Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF78037C902
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595105; cv=pass; b=LunVo6IKHumosEfZ59JCJIWQl0WfvT5VCtLkvSe2pzRCwGBqjl5iT2AdqDW/+MQV01/lnJpOyj9Swm8QCDzXYUYRBn5FCboLJBu7k6EF349SSbAvMpc+oJZ/kWo8XMmZPES4waeQL8QW8iPhgfmKIxN11LF8SM6t9zsiXUKECt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595105; c=relaxed/simple;
	bh=UKFKl2K9g5nLNYroyFHhTqW1OKJRRkzZweDAzieN/TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEYgWSV/SbTJP1zJMZLw3p3bmjQTc4FOxXT5Tcw/4e9Q5fyDyZh5Z+0Sz+NDDqL4kiJlaA76qN55vX4KgqIb5L2/f7G9tpQ6jKJjwJOcN4kfZJhbuQahG2TOYrdHpaHKt1mYg7YMhvi0ScZcSNQLOgs56W09UtMIbK9BpqJRQ9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hXP0526t; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hXP0526t"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66bb7118c96so3826a12.0
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 13:51:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775595102; cv=none;
        d=google.com; s=arc-20240605;
        b=hc5mCVvk9RsJTXDYRY0ZCdIRAzRRhmUHOitBohSFET3SIm+F0Hp/4w5zvxouEVgqRJ
         J9+THXejCCeHU2rWV+9WoSrHExa1QtKfWgu2eOzIu3hOcfKL2xLjQJXxntyH3Gd03Vn9
         49/kyMNmcutA8TD8xLnL2+c5sc2mCZCzMvEwEraBBV0phbq72kP4Kd1jmfhEzL9Udx1+
         Ai4TkzSGuDJ62iWdx2/0KX1lBwcm3HkA8j2BI7X3txwCymV7jNmDYdSImZyNpErLsWJn
         uF0x6XW8yca8Kb9lo3AQ3QbDRK82Eq3+8VajSSmIVcAwlkyEvDq2qZwSVlgo80f4Rldw
         rl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5dd0gkp5i82XLUviXzsklqgxc4prB+yOLI4RE0RGdmk=;
        fh=z21LpRinl1Z9XudLhVpRB5sQr94BOZKLiQCgNhdq1/s=;
        b=BVnquYWM6cgfK0rtHkL+BfmYPOZoFTV2SlHFYGzwZy4mF1He4YyPtNwJimMZgmwZv7
         gOvSqY6j0D3i0XEkjrK9ssvqA3qAoNlAQ6KieUojyqcRkVGDIJp14UqbsB+M2WRh2UQw
         QdOovxyGX1nY9bIvo3gX44hhzrvpZqoE2RHLDaSB3E8n5RiUWhBHDhzfp9ktkfItuaYD
         QDsgy5IZaCaPi8JrHtXvIKGQVe9BsLvtPUJvimpPMFKQBnfF0SjJezMh339/ug1hs0eD
         GYUYYjhLL2OLNmL3NrUhHvoUCbfNNrTFDiKAvu3JkazU0MWu2wuRQapn0xNnpUsucHRr
         d+bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775595102; x=1776199902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dd0gkp5i82XLUviXzsklqgxc4prB+yOLI4RE0RGdmk=;
        b=hXP0526trW3C3w4WklAEDNcGPccrqGBJe+1c0pNp1RGOODgLAsdk3Vmj4Unf3Wn+Rq
         tM7vG+xbAKAtQ1q2nsBFZQcm7MulAtdPTRrB6/QSJnLt0TaL6OZtzWuf0rJ0ddq0tSE1
         PO6KSBPSGepW2xcOpOWzegRfe5weeM6XEkQfoU/XqkZLBPIjpsyTVwEy0VpDbl8J+0W4
         8+eSNZyEMB1WpCTlWdQSfURGfp+lpC/rBFmyjTPEMmx9xob0g2Kijhg120L2hqU8cZZb
         l5UnflRDVv6tomPCBDeGIa1rsw/jmPEyHHejTKTKUcq9CyK+AagLkA82lX4t109tBGD6
         oDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775595102; x=1776199902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5dd0gkp5i82XLUviXzsklqgxc4prB+yOLI4RE0RGdmk=;
        b=Jv3QGl8AiGY5RTQycaRPYMvtoKXuojMPJ1Dx/0nfTS/6e2rrZAF2SUtJ+xFqSO1Xpt
         2anq+ebHUZIeYA4d6yJp8eu/Zb8evMrF0uW60Z7AZv2neYBHIs/rQqMdW8JGP5Tz/z9S
         RKghSyb/PwgBtYgFHGIBuqWxLKqj5zeik8gwp9z0HgRtdEny/FFq7j+0MHcLGwsoK1TI
         kU5HMx2YfajO9jsQLMa2rkaxB2cJW1yOSqc2C/OdWXZOBFeHJGn3dllJIcO0zHOaq1aM
         nGpj6UsPI+030QdY7HcMVul0SlM3QMF3ul+cR/zVE6KlEta5hfDHaVkAa55oCMvHH1cb
         tkoA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ4D7b3/PXjolbvm0qH+LsyJ8Hl4jG8ZkmCYrv42ToPwPgrQpvgOIVSMN6jNhnKoMIFm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVeKGszAOp/MLu1lwZWxsthE1FRLnRZXxQCPv1RZzSgDxpLRQN
	oY1pCIyzwS6dG/JVBcaLo2IPj6IPKqwx9/jHTUESYFeb3CXUx+o1dS9PrEHc7wMaWsPWIgSV9A8
	Cr6nh8Qlfkyu17AwXnlAQ4PK8z2CxwHrYN+BVVz2F
X-Gm-Gg: AeBDieu3SwRH2Ma0K4fu5BLLpsVXx/UwV8yWEd206jcI/iJMmV5cIe4Kex5sDceIQIp
	UUgRab69DCGVLMaT7sKd9UZbDZdd5R/QXbi+7ShtZr5xAxw3n68RCIFFXWR5MX6gqK2FPMLxEV8
	uDkmRHoWzCe3SuJbfUMS4yyJGWsZ1WhcyAO4EZk+ijk02d56drgPwnHkb3d0+aKvHp6oFg6jdYO
	k6AEiEmRfNAGOHNmxqpyDTsglZwohLLnTPAP1pFME3UrKnQcOcGBlcnUy5I7hkdtYEjAgm0FWE7
	ze7VNhg=
X-Received: by 2002:aa7:cfca:0:b0:66b:ed69:a85c with SMTP id
 4fb4d7f45d1cf-66f9f2d5956mr111a12.7.1775595101713; Tue, 07 Apr 2026 13:51:41
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407190343.325299-1-jmattson@google.com> <20260407190343.325299-6-jmattson@google.com>
 <adVZ7-EiekghvDMD@google.com>
In-Reply-To: <adVZ7-EiekghvDMD@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 7 Apr 2026 13:51:27 -0700
X-Gm-Features: AQROBzDnmmB-4MNzWe1dBvIEm3CwTAGcs8zn3JWqymGtmB5CgLW7VbbVHZEmPDU
Message-ID: <CALMp9eS+XiJ=u2618Hke9ePyzeTuChU=dLt+e=x2nXLTMVH5mw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: nSVM: Redirect IA32_PAT accesses to either hPAT
 or gPAT
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 12:24=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Apr 07, 2026, Jim Mattson wrote:
> > When KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled and the vCPU is in
> > guest mode with nested NPT enabled, guest accesses to IA32_PAT are
> > redirected to the gPAT register, which is stored in VMCB02's g_pat fiel=
d.
> >
> > Non-guest accesses (e.g. from userspace) to IA32_PAT are always redirec=
ted
> > to hPAT, which is stored in vcpu->arch.pat.
> >
> > Directing host-initiated accesses to hPAT ensures that KVM_GET/SET_MSRS=
 and
> > KVM_GET/SET_NESTED_STATE are independent of each other and can be order=
ed
> > arbitrarily during save and restore. gPAT is saved and restored separat=
ely
> > via KVM_GET/SET_NESTED_STATE.
> >
> > Use WARN_ON_ONCE to flag any host-initiated accesses originating from K=
VM
> > itself rather than userspace.
> >
> > Use pr_warn_once to flag any use of the common MSR-handling code (now
> > shared by VMX and TDX) for IA32_PAT by a vCPU that is SVM-capable.
>
> Changelog is stale, but otherwise this LGTM.  I'll fixup the changelog wh=
en
> applying (in a few weeks).

Oh, crud. This was supposed to be 5/8, but I made some changes after
checkpatch.pl complained and then tried to just regenerate this one,
but I totally flubbed it.
