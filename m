Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE04F33A9DA
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780159679; cv=pass; b=qIv/bfDHtgFxZ6gDXYboquNTBg5f066gi9fybZ1XX+plq2ApHmKEiaglIFgP90fplMtLqOOsQt4zwHMl09Yb8bL52mQyJo/L2/sR+cT6WuF/RCSyXsJG+J8bTvmwWPFLFseBMC1XbBJ/N1HY0fvxA5XhfBCoq0v6Rm9Deql2VyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780159679; c=relaxed/simple;
	bh=NO55GTUIErfjMW/u3wp6zeJt9pZ5TEdqDypSXTrdktw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DWr3jmBjGRU9N46pCwEhEK68x3rfAB96OzvYRNDFJfcZ5BGqDaReR6CJOElaLiGdvmiKVTuothBY8tYX4Mh47ZEvzv0PHkymdXQ47dFW5PW8BH6f6eWUj8BsJcu9xMDIP3e9aD5TTeZmQBxLar4ng+k+xyEhs7uB1Lg2HO3rzbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0Zm66aS; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0Zm66aS"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-beb8a08a6c8so50214866b.2
        for <kvm@vger.kernel.org>; Sat, 30 May 2026 09:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780159676; cv=none;
        d=google.com; s=arc-20240605;
        b=TMo1pNFaWt0g1prdpFiS7X4IAdzyfnu7BsEA9RJcnGwv0gMMaATKBkk17zVwPoBDIh
         /ssBYFXx30n0emfx/LxI5oBjoW1cXLFT8vgS/lBjK86lcMXiVWDjh26Dv3gnkl1VI7yg
         KP6Rj0E5U5Tga2WoB04ptSoUSZ2Sno2UDdtqK7lL6yCfEpO9qcWfEfOUb6jJ2VnRPcQC
         SToka7E8+t7sOWPADhAkXDxmeJ1KnYSyOgTRIiGvZmVVUlxVg3dsaGgS/yw8AKERdyjf
         +CazImtkGpPKsLADPTS1ftj66GMpEPBauTWTUyik87/lewiS1g0vLmhCZn4wsQ8s5jzD
         02DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :dkim-signature;
        bh=uDjMWTL59bSew6EuBBjyiKQsK4J1StRuWvcVY3hIZ9s=;
        fh=HW0QhUdwPrc4o2773bmxaqBMQ16CmYmYyqHFwHmoweU=;
        b=dHvzP+84PVRUQpNIBLUiPTDAroZf7f8xrCa0nnjRXpe4rutIPOEo2M6aKOAPw1Wk0E
         RxYpN5l28FjQUKuX6jrX8qj/9MPJb+Fk+hQLpGU0zUKd0lvLTt//qnMRTpNefeVcqa4N
         1zh704tTJgVjKGjIR29SMiWGZ3wiZo50WXntUR5uvan8wdxr5ecYFuUsD0FWlt7ZzNyg
         WKwgZfJYZzfeJuItOu/jZoKUsauFxwxXTSChKHIhC7QM5ZeyNcFfI5zf1kNEGFu9Yv0Q
         U6dTYRO+Nnd6FhTDiDIN1el1hAdaSODH+BvDWwwZfj11nbaCu7AlHsR09zADJ1/iO2R2
         yaRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780159676; x=1780764476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDjMWTL59bSew6EuBBjyiKQsK4J1StRuWvcVY3hIZ9s=;
        b=T0Zm66aSY3sD9Rf6K2p8uIg8DeLbBuEr0xEiATqw1pUjw1ctLRW/CAwskT19nTHK0I
         uhva0xhmzKgtjI2R2qv7Z5tDk5QCud4UE1KceuCb9j4RoXobIUCtq5dA+C44ICUpFeBd
         aO7T8GCA7Wxugn0PvwdzAEva/MHS7CHSa+kRtY6Sljx89GweUMD6mGyz/9vTld0F/DYZ
         vBysRfjz2lwMqEo8gh7bqebfRA9r/XqWzGB/uCR9TSW41Ld66pzE4OqamBvo0mOuegeO
         K9y2O7LkDlnQYTKLMF60IkRAKVDqNhVQeHb/lJGMWV5EZN1Zs9Z4dSI2juefl44lwyOk
         81rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780159676; x=1780764476;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDjMWTL59bSew6EuBBjyiKQsK4J1StRuWvcVY3hIZ9s=;
        b=W2037FrWDi1FqfAqoxeoc0UsxXaqzHId/cwTqioub6BwFC4OKIXP4VNpzANZhc3JJU
         ASyOpSQdnSLy1TNMMbiWRqIQp+AdGQPe3hgrfpNJn5nGsUIboC4JW3f8Z7VtuSJYyMT6
         o8KpWtCAP3HI/EKawR8pblEFGat+vDxmeSZKo3injLzmA5pUTYqtuWiiVmA8n44E3XlQ
         gutVkScdr1aRJFRwiR9FGBgMyxiUmODEig7KWo+BParDCJ9n5UVlpys1tjyzfXw6YKRt
         fYfh8DFl1evJ7nD11z5+2FIwWxwsGfCBmB4xeeo/16yZmzjmawu+3PvEg8Wke2AtM5NK
         96Kw==
X-Forwarded-Encrypted: i=1; AFNElJ+r6aHgIrzSFUQBUiJGUix2YyQ/mINGFSusG8kDmeLMRhltqWrL8Wd3Hg6FqECaq2Jel1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW31O0tl5+tpDK4O4To+un0L1d/ZEvvYiSDN/JtTF50RaUsjWB
	v5etNNq6ZZ6tf4i+GN/xvf3R5yuJPiSggH7v5mrmnL2gINlfHGkzbUamU65LioROjP4++u/bRaX
	CrUjkYXt2szNBykgb585VUIDv741092k=
X-Gm-Gg: Acq92OGIDNxgFn0WlszRujxWFWIdVZs/if9SF1/w0ofY3YkfFmy3V6Vp59BQtVWYEoH
	LAec8fThFNnhmcM1g6Rzglw9JPUkUViEBrUy3kd9Q7jyosVB4QvRN3c3Dd2H8TnloNKxMOtIuVK
	gqXEEYvChv69Q9DkPHcBsr9+4GilJTO0CortB9QvbMTPehe40iJwRVz+P9niGM1fWf+0lQAuA3u
	lZtymuLGy88NkZIcgu5x2Z/RssY23OY7DMBMzieMo1mxs17GJdqlMZ4kO3wsvr1DJHxXoicJkui
	R1A1X+YAPxlmaSKswJdmPxO0oY2tgfZpIy8Mpqvp1XcJvpAanA==
X-Received: by 2002:a17:907:80a:b0:bae:d29c:4e28 with SMTP id
 a640c23a62f3a-beab3850c0emr227580166b.12.1780159676193; Sat, 30 May 2026
 09:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Sat, 30 May 2026 09:47:44 -0700
X-Gm-Features: AVHnY4LzRI4mtM2MVMA9vVPgTReaIAtSfV8wr74SnOQ4vnVCBcmxdNjiRFE8TOw
Message-ID: <CAKSQd8XBoaUf7MyvPJCv_DHeuEd-DtRYb5GnAofkbJTP89LLMw@mail.gmail.com>
Subject: Re: [PATCH v4 15/47] KVM: x86: Officially define CPUID 0x40000010 as
 PV Timing Info (TSC and Bus)
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	David Woodhouse <dwmw@amazon.co.uk>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw2@infradead.org>, 
	Michael Kelley <mhklinux@outlook.com>, Thomas Gleixner <tglx@linutronix.de>, 
	bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"

> + *  # EAX: (Virtual) TSC frequency in kHz.
> + *  # EBX: (Virtual) Bus (local APIC timer) frequency in kHz.
> + *  # ECX, EDX: Reserved (must be zero).

Can someone from Broadcom please speak up as to
what a non-ECX value signifies for their HV? (Asking
because I see a value of 2, not a must-be-zero.)

--
C.
