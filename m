Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3862026A1CF
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782251013; cv=none; b=CBtJYalxlWqCwjXQdVPfnacZa5EQHrOmIPgHX/BKa8msx2SubaaZG8cRiA97qLGgXjTyMA+38O+sJ403LrN9uQfJw3RgRUq8nTtdhZ+kkRQ+GeOQoEQ0CKb/Gg4NZe+1iD5EWLgCheN4s2XqbPbo1sCn9ad98c8kvBy3y6hHrfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782251013; c=relaxed/simple;
	bh=KYkOXRc6PtHkDuTF07+UlSONzn0N44Bv/OO52rl5wU4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C9ybaXOz8mNaKU3E0TXmSr140S9YHJ9t3k7ARmqTd56utZ+2FrqosEuPNVKvjsI+e5lE3xpRbfPwDC6azhBgIo/hmvhZrBVy0Lyzd3IgMAPdXm57+4cvk4sjftIPQJsVMpie2QUBzWJHPrDeXuKej/OG1F8nHZt1k0BAsiki7I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A2YrBtsF; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A2YrBtsF"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-845317fa7e6so421294b3a.3
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 14:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782251011; x=1782855811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BoYHhvq061mNBm0pBIKHfokYEtu2W0R/oyRcYiSNgQ=;
        b=A2YrBtsF2/inaAesRTPk28HkxZkGiFAQtw9o7cJaTzmDTOuY/8tQbPX2PsKe/1I6py
         s6Nhw0ZAf0YHywLCzD8gwORdrittCF4m2F7ZGhGq3Im9KBsIjWXOa0soXW7olirI8JE/
         nvgF1Wwh2RW7M/YXnzsEnBGlxF+QtNKxJo6KCyWsLmkkNYyQFfLYKbceCrEnModzfg85
         N/JO9hdHmDgEGlmuqeLZ3hqfl5gwlB8vAdeuHbyRrGxB+KdTlPnqpfxOAVvuS5pMlkpc
         ryrBiXhsN8qC5hiEw1fREIEujR2nr1CpWBYCSusYWwcH6TlcfV1LiBu+q+qEZkdTlqkW
         XDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782251011; x=1782855811;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+BoYHhvq061mNBm0pBIKHfokYEtu2W0R/oyRcYiSNgQ=;
        b=g04Jgd8u+SSKwrb61pg8qOd+bNwsnOmgFzcEtgCj7Z6eUylj8XN86a6J2o0yRvB8ms
         LUqLXD1BmQLUtf82s/xw7MXK0r4YpgFvThlJB1jV3J5ejvHeLTIfjb9HqG2B5qlMZqq4
         AHyJh/AHHvYDtjWkPpoqQiiAI7/1haJvUE4Ti+03U6tnRCt7g1JhlQ3jM3zT/9brL7G5
         J+wQcELUyco7cwSfsvEewZwQp64RN7U+xrmNZIETQCmsnKC9YvAZExkblBFiUTjeu/tW
         SD9NaG/FvKBQQYnZIlIPVaVzAjeO72R3YmPtvs4M0wS0jtIZ58feZpR0qat+ZdKWC+qM
         NMkg==
X-Forwarded-Encrypted: i=1; AFNElJ8tKhznJ1QVm2Y/QEXJr4cxh4yJwg8F6S0H3DDWiJsBWhq4Wl9TZk0pQQCr2kq6bLL0ImE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNjH07cxGwyj8HzAzsk7rH7V+okYPfSvbjah0wXm89KZ6DX6We
	OeRUHCqfLPtfNVVuR2Z5rMfDuZAwEzoR8nwWPp11x8oQdHlcTRbh2w/7T9ItZHMeHc96bNUu89B
	V+vVg7A==
X-Received: from pfnj18.prod.google.com ([2002:aa7:83d2:0:b0:845:47bc:59e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:39a4:b0:842:1052:5fe7
 with SMTP id d2e1a72fcca58-845a26a23c9mr1038347b3a.6.1782251011259; Tue, 23
 Jun 2026 14:43:31 -0700 (PDT)
Date: Tue, 23 Jun 2026 14:43:30 -0700
In-Reply-To: <0657500d-a8bd-4dec-80a5-807e857a4306@fortanix.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aiqwjn2DVOumfr3T@8bytes.org> <ajGOELiYwKByXbVP@google.com>
 <ajJAYZAPxNrrsiYp@8bytes.org> <ajKadxZEMI253AoT@google.com>
 <ajKe-oboTRowcO_i@8bytes.org> <ajKjMIBb21qB46fh@google.com>
 <ajKnKeo1FV3zbjEt@8bytes.org> <ajqMvQLMGONiLn1S@google.com>
 <LV0PR21MB6859D1AEF99FB84228C23620CAEE2@LV0PR21MB6859.namprd21.prod.outlook.com>
 <0657500d-a8bd-4dec-80a5-807e857a4306@fortanix.com>
Message-ID: <ajr-AigoW2cJY5k3@google.com>
Subject: Re: [EXTERNAL] Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA
 at SNP_LAUNCH_UPDATE
From: Sean Christopherson <seanjc@google.com>
To: Jethro Beekman <jethro@fortanix.com>
Cc: Jon Lange <jlange@microsoft.com>, "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"thomas.lendacky" <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"coconut-svsm@lists.linux.dev" <coconut-svsm@lists.linux.dev>, Joerg Roedel <joerg.roedel@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026, Jethro Beekman wrote:
> On 2026-06-23 16:51, Jon Lange wrote:
> > On Tuesday, June 23, 2026 6:40 AM, Sean Christopherson wrote:
> >> On Wed, Jun 17, 2026, J=C3=B6rg R=C3=B6del wrote:
> >>> On Wed, Jun 17, 2026 at 06:37:52AM -0700, Sean Christopherson wrote:
> >>>> Ok, so it took us a few times to learn our lesson.  I still don't se=
e that as a
> >>>> strong argument for new uAPI, especially not for VMSA pages.  I am v=
ery firmly
> >>>> of the opinion that letting anything but the host kernel configure t=
he VMSA is
> >>>> beyond stupid, but unfortunately we're stuck with AP_CREATION.  Expa=
nding that
> >>>> surface has a very, very, VERY high bar to get over.
> >>>
> >>> The strongest argument in my view (and the main reason we are doing t=
his) is
> >>> actually the predictable launch measurement. On SEV-SNP this is a req=
uirement
> >>> to use platform VM-identity features like the ID Block.
> >>
> >> And I'm saying that unless KVM *can't* provide a predictable launch me=
asurement,
> >> which AIUI isn't the case, then the launch measurement *must* be stabl=
e across
> >> kernels because it's part of KVM's ABI.  So as I see it, the issue isn=
't that
> >> KVM is inherently unpredictable, it's that we lack tests to validate a=
 thorny,
> >> subtle piece of KVM's ABI.
> >=20
> > Joerg is suggesting that we need a launch measurement that is stable no=
t
> > just across multiple launches on the same system, but across multiple
> > hypervisors.
>=20
> If this is now suddenly an acceptable argument, please also merge https:/=
/lkml.org/lkml/2021/4/12/625

No, that's not how this works.  Dave and Jarkko both have unanswered questi=
ons
regarding the use case.  Answer their questions, and I'm confident you'll g=
et
traction.

 : I don't believe we necessarily *WANT* or need Linux to support "all
 : possible ECREATE, EADD, EEXTEND, EINIT sequences".  Yet, it's what is
 : being used to justify this series without any other justification.
 :=20
 : It's going to be a different story if you bring me a real enclave that
 : *REALLY* wants to do this for good reasons.

and

 : What specifically are you referring as the "rest of the world"?
 :=20
 : That would be mean that there is reviewable workload "out there".

The start of that thread is *exactly* what's playing out here.  The big dif=
ference,
and why this one's likely getting a different result, is that Jon provided =
a very
thorough explanation of exactly what use case Joerg and company want to sup=
port.
The only "assumed knowledge" is why it's desirable for the measurement to b=
e stable
across hypervisors, but I'm comfortable stitching that together on my own.

In other words, they aren't asking KVM to support every possible way/time a=
 VMSA
could be associated with a vCPU, they're asking to extend KVM to support a =
concrete
use case, with meaningful real world impact.  In fact, I actually think thi=
s series
is *too* narrowly focused on their use case.

FWIW, KVM_TDX_INIT_MEM_REGION has almost the exact same ABI that SGX has: p=
ages
contents are measured immediately after they're added.
