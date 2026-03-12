Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED74364955
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325134; cv=none; b=UYk/3Bq/K49eOx8bXpH0Pm4PMj7MCwxeWBHUCFVLMVV9B8DIHvQR31v77JBtVPyGMun1QowHaFLvFSmQh183VlmAkWfLgO1JTmgUpIjZWzcK9XO+UzQYr88ap0D5+OVXRSR347B0LWGuDZbRGqEhtFQRAVCUjAIGd0zhXJPcSs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325134; c=relaxed/simple;
	bh=hGqOf/D1n6zt9lKMaVVi2J90hy3UfDgGbEzRXmPo8f4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QNVNmE4Vsbt4LLZo9SO5pOlmeKczrMffLERK8x3l6/YCsa80Ie6dIlIIeYkb3Nj13tlrw2AlS8+sAh7KY1FK9/7dWPkfjLJqu2NAJBCfd8Q8ep3gEnIwSf67o/L+88/1PbebGZMZ3nya/UsdLpJJqNKVuSjvgCCn6Y5m2l3QKpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zIRO2fLF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zIRO2fLF"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae502a1dd9so14123025ad.3
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773325132; x=1773929932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGHhfsi37Eu9JZy+ZrD+abK1cZRx7y4LPxRTu6Z/szY=;
        b=zIRO2fLFZ8e/BuXXMmXcD5Id9aKnfv2bfW3j91XlmiiF9ymZe9xH6Rrz9hYF+C91V1
         +D9sqfAlmx0znVUq0pKcMBdn/kkUN57w80vqCQtFkqX/dOyRjk7qNnwXInGtIau5gIm7
         xA/4a9PSQqZ6ZezrobM+ROJ7cTdlx9kdZK3YQcFKcY8T6+o4FtDcFVahvh1d98r9AUuI
         34p8nz6F1g/uopRChP82ngwWqbCqu51laXZ+9903nMTCNdvs8TWhevxkNmjqOtDPKr//
         ztJTMSeEWmBLrNp5e6in5DMtMww2qJO8Wyd2Ft/waA3asO8y+YZyMTp0/b1KbqpAzNxX
         iB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773325132; x=1773929932;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gGHhfsi37Eu9JZy+ZrD+abK1cZRx7y4LPxRTu6Z/szY=;
        b=UdDLAS3ApUTlMOZ8jy8zZFMEKu3ZtZ2f1SblfgdcF7kNfc5+hhcR/aogX3rOFBVcXB
         4lGPzREm9JsYySW28JBzw6HyO/X1zG4OHcefHpoIOI8CK8Z1zWerq5NDJ5mLImRFa7qV
         TqhkWtoKlF8K/9HmUw3ywRc1AcohrNB4r7IVCbu9zDpL6Uce8lVclkb7EGMRlc32VNja
         unuRQ4zhTDK91p7UER6PRlD+zKulQJ6v5DNLNtiuxYcafYvHgzOt/3b3URpl5MnvPGk/
         cF8QDFpeZw+Cmwnho09sCMUOD6wVWq9FdN5hJw5pz0J8FHBsTFqEoQJwrvk3wqpswODN
         qfNA==
X-Gm-Message-State: AOJu0YwDY2YbZYQ4rGYl+mnVFcK+yPdWZuIjKSwspySuoEMvcP16CT9N
	cPWSu4n6idNPF78MlwSh6qaLO9d92a80D6+7kvPORali3t6uYzHFLA+oDsOUOlHiQFd0qrFCgSE
	ZjUtzIw==
X-Received: from pleq1.prod.google.com ([2002:a17:902:f341:b0:2ae:c5fa:9706])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1c3:b0:2ae:4fb6:bb21
 with SMTP id d9443c01a7336-2aeae7e7939mr65856815ad.15.1773325132299; Thu, 12
 Mar 2026 07:18:52 -0700 (PDT)
Date: Thu, 12 Mar 2026 07:18:51 -0700
In-Reply-To: <CABgObfYY5GVF6iubP70jmCYj+3cbsYc7DCxiRsPRr=JDbZjQmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305193053.1643463-1-seanjc@google.com> <abCLG4axO2gmpBb-@google.com>
 <CABgObfYY5GVF6iubP70jmCYj+3cbsYc7DCxiRsPRr=JDbZjQmg@mail.gmail.com>
Message-ID: <abLHkWQ7ib8m1KhV@google.com>
Subject: Re: [GIT PULL] KVM: x86 (and a PPC) fixes for 7.0-rc3+
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026, Paolo Bonzini wrote:
> On Tue, Mar 10, 2026 at 10:20=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Thu, Mar 05, 2026, Sean Christopherson wrote:
> > >  - Update CR8 write interception when AVIC is (de)activated to fix a =
bug where
> > >    KVM can run with the CR8 intercept in perpetuity.
> >
> > ...
> >
> > > Sean Christopherson (4):
> > >       KVM: SVM: Initialize AVIC VMCB fields if AVIC is enabled with i=
n-kernel APIC
> > >       KVM: SVM: Set/clear CR8 write interception when AVIC is (de)act=
ivated
> >
> > The CR8 write patch broke SEV-ES guests.  If you haven't already prepar=
ed the
> > PULL request for Linus, can you apply the fix directly?
>=20
> Done.=20

No?  I see the pull request in kvm.git, but not the below fix-to-the-fix.

> > https://lore.kernel.org/all/20260310211841.2552361-2-seanjc@google.com
