Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688F327FB0E
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759524; cv=pass; b=bh0GUPqCKB7Q2hYVJCwuKYLJKUVMnT0V+JUU5sRvLJ+a1QDdRj/lTy4RjM4TgxovIc+CbbH1wVELHbyFJRPTqe4y0SvdTurax4cdPEe0YDLKTEgifLr8LYiJnh9InuUCIsANnk03Ubroo018avN71RDagWmbvgdZp1GkW+GAj3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759524; c=relaxed/simple;
	bh=0WgxWtB75A8+hitu+9AJoHCS75zaOAWuYOY7N2DSaQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDgCcRuXKuA+ZGyXKwJ/anjlrujcABp7hrvM9o6teLFjWpsd/iINdGtrMcok9lbazt28mCbQAVaSZxYjf+CGTb34nrmqU8RceGn92sfLN8K2cXVNVdspaf9HpX66UjcMtjm0TFo3aeYNygjVYCpEhK1nKCAfbcUNKHVwr4G8hzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pkDr9WRO; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pkDr9WRO"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-661ce258878so12097a12.0
        for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 07:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773759522; cv=none;
        d=google.com; s=arc-20240605;
        b=jPkNtj5bA6za1AxfhbgvL2pu2vEhc7JQfSPEdAyc5fEMSD6x43PBoVU4AHdHclk/FI
         ETLQadesdDUKW4vxX5KQLHH42RbB7Y+RQIp8XCOWEZs74CeGgrVeFSSvphduVHnvD2un
         Ujp/iKuMF4KyxFEA3mEajarNy5rCUcq3ES8v0HRNrT3gZgQSXY0brMzuqBTSCwNFjetv
         oR1Cf0rmkFAEjSlA3mwAWN6ZvKGcgsxqAkRW/6YUtjHlLKTXXiUrGa1BWmLOfkM2uaJ2
         oVJR5qbx8NrcEyg5KeMque7SlDYN/7GAqldrwAF48NDxkYK5sLueLZ5YS3Br3cphiTnS
         cmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0WgxWtB75A8+hitu+9AJoHCS75zaOAWuYOY7N2DSaQM=;
        fh=cSMbC63YHch+2DscszQMXTs99z9YxQeWPDxe7uhrX0g=;
        b=ArSCAlujT9Uu+VU/EbMDbjO1SjgfkuAikByVBsxazMMgybC2hQjwWpXsmAdMGzzr/n
         Ma2F4vo26oqSz2sAnQgpqXWtkc0jB4JT6xPwBPot+ln9GA1zjSV/9h0f0d5Kwpn4hEwu
         EXszMt1PP/kBPHhoLvEtBIwrvPy6f+wHqJdizh+qoVqUNNoQECTs38f5H2e9c2fDsTcf
         ErbeAVTohXQFDeUpxtvfYis0yDZfOSnejL79j/gvZulr2Eo3lBwuONu/+tInCUCL5XaE
         KHcOHPRIVo7Of8W4z1fpPhSYeay3gz3AHkeo79mDeTHTW31wG540Wmmf7KrIsqUHqzpe
         fvQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773759522; x=1774364322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WgxWtB75A8+hitu+9AJoHCS75zaOAWuYOY7N2DSaQM=;
        b=pkDr9WRO7zs2da3YNl+5H0gEz5NjaKkm7G905ZPWDw9CGU9kByIfGDIoyZ/Tny/hKv
         oy5At6E7BYarw0OcDKscjAf0BzyD6Y4KAeMBBX4f0hDJYI/yhZqR81ab1nwyuXr5sgiL
         qohUGjtPRISXqkR88umW2jAKg2WSePtWl75sZy9rPQes9d7eiICL9atyi0i4WSXiP3E6
         A7ou4BOMyQ+4Xc7wtEvrkGZRzJr7atk2CFItomCMRz9eVExSEzzN1oM7xS3gf5zA6Qx7
         F+F0sdJ0pJaQUoj4Vs+FSt631XsiRbk9tXDqp/7AQkhKqS9F9npSeYwFWzRqhIQn8Jbr
         23DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773759522; x=1774364322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0WgxWtB75A8+hitu+9AJoHCS75zaOAWuYOY7N2DSaQM=;
        b=FCP0FbiAUjN7roNwwWU5iXs9fPG00Tswgycmy7fXJyzrzCU1y52zE/63XAUWrWeA6Y
         EvNzUx/M+smXsXYljqWt73m4NGvvtb0kJ2iCyTl8LtseDgW4IYyaO2ajT/Y0OckJJukp
         9sbk2A22D4zzwfiByBED8qRI5+rq9HHmEFHfzym4iejMf/r/tE//IN/bEBnCREeGPmvN
         anBy10ryECN0lnh/5IxRLeOoW+OAK9UXtgKrTdHfPuTsE+n1+ZNotepwoJd+Q8WrHwyE
         t02wKEU5l//M4XEGhDAObUNQF4c7adrxb/bzW34hUrq1juFblMl0Ui8MTwKhMVuNA/CY
         6lvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4Dwo6eI+W9l8BH2CzXukjuFmYw8Ii/LkJLFjU0LsmPCeZ422rxmsQj1vwJPn1o6r1/SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ8DlK6/dWgKPV0Y1BaxmzquwScPXwyWvSUM6KXs8i1BekwnUA
	+xOX4AFlD+JgGb20dYw4xyeFoe5B5nfgZ05DJ2GsLs6Q02G2zG9W4iPMJWblhLP1GFBFUP0Cxnx
	ud41qW1F0SMz2jf0z4t49N7hfQaf8b16D3U9DMpeQ
X-Gm-Gg: ATEYQzwqTN6yi2/FHXtmQU1hXaShn/OtJm+9KH+8m5JvL7ax0PEH+R1glxQjzYejV5v
	ZhIFi1BcKdiuKnobx3kYj8VW/XrzJ3k5iADrG0mzszqPfXbj24ye8nlPBZM6cgB6OL3BGCpjeox
	qe+3oI9PRCtWEqLrQSF824LIA4f/P3wO3sxX2u/1VM1l6paEuN4pv4Cfr7WUJAAPBjmO6m49TUT
	AYHZWJhMApWKN0oG7QPe6ZRqHXBE+A9KK7mj0QWgiG8e5gqT9aQI0YoxyungI6PTReU6go3hPBD
	0Owkz9c=
X-Received: by 2002:aa7:c745:0:b0:661:f987:357b with SMTP id
 4fb4d7f45d1cf-66714cc391fmr46438a12.14.1773759521286; Tue, 17 Mar 2026
 07:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313001024.136619-1-yosry@kernel.org> <20260313001024.136619-2-yosry@kernel.org>
 <181d8563-14a2-4429-9e18-ede7a6aeb030@redhat.com> <CAO9r8zMxLx7fGGp1JPWatGNauY8fZvSECNGzC+o-p41BZrRGFg@mail.gmail.com>
 <CABgObfY__euhy8YRpWbkVW8V2q10HS0nXmRQrfPOkt5iENbCGA@mail.gmail.com>
In-Reply-To: <CABgObfY__euhy8YRpWbkVW8V2q10HS0nXmRQrfPOkt5iENbCGA@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 17 Mar 2026 07:58:28 -0700
X-Gm-Features: AaiRm535zsRDeMjsC5nsnYfeEReGD4FgoPcdrIp2lHv4FbXQWFm0Bp3FfnD6X0g
Message-ID: <CALMp9eR2rAcr6OnmaHfiDFzSdDsGpWEPqNV0xf6OfSFPnEYU7g@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] KVM: SVM: Drop RAX check for SVM instructions from
 the emulator
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Sean Christopherson <seanjc@google.com>, kvm <kvm@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 6:15=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Il lun 16 mar 2026, 14:49 Yosry Ahmed <yosry@kernel.org> ha scritto:
> >
> > TL;DR is that the emulator support for VMRUN/VMLOAD/VMSAVE is
> > broken/unsupported anyway, beyond checking for intercepts and
> > pre-intercept exceptions (well, even that is broken), and the RAX
> > check should be after that architecturally.
>
> Agreed about that, just ripping it out completely would be fine. It's
> only if the emulation happens that it has to be complete.
>
> > Given that the goal of this series is actually to stop injecting a
> > non-architectural #GP when KVM fails to read vmcb12, I didn't really
> > want to derail it anymore by making it emulator-focused. We can
> > probably do a follow-up on just improving the emulator support for
> > these instructions as I mentioned above, as that would take its own
> > series AFAICT.
>
> Agreed.
>
> > The only reason this patch exists here is because the buggy RAX check
> > in the emulator results in injecting a non-architectural #GP on 52-bit
> > MAXPHYADDR platforms (the #NPF scenario described in the changelog).
>
> Yeah, that part was clearly broken when physical address bits broke
> AMD's 48-bit limit (and I don't think the details of what is
> considered an invalid physical address are part of the architectural
> description, for example some SMM ranges are carved out by the
> VMRUN/VMLOAD/VMSAVE microcode).

IIUC, VLS is broken because it applies the host's microarchitectural
physical address restrictions to untranslated *guest* physical
addresses. Is that right?
