Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E131FECAB
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613318; cv=none; b=HJFiBS5T0HhU95jGpEYcUT6RC5nrwZ2TGguYQZcHfBJLywwVFgwysUdwJe1h5J/n9MEpnfbJszLTRs0Kx6GRCcQrH+PM1hnYdO/dYtjjOTtFfotgjnm0x7xB39JFgtYV6x7c+dBmtUCstap+e8IWx65oPV2bZI/o8cGneSZQ8M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613318; c=relaxed/simple;
	bh=ETdUkWmUMOLSm7TtxUX69mqgYG8eFTikRfIxPw/5Ih4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=MRcHDCoQBob/ukg6DtmSlbNqmOylXLcvoyRtCu189R4ccr5Pw1GsOPakJXMLF8A7z7QKlRMEwZXPG1XCGGobPjeaHvL5Qo/tUvSV+rxT1TXa/UMux8GgFjcs6AdlMJ2cFikamBSZMlmAmBQheV6G5lw8wV2pqPtSlbFa51WBI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FM/NYQm/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM/NYQm/"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84237c55ef9so2830440b3a.0
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781613317; x=1782218117; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BAYzqTyjLrIOI8jk2lCoOCBWo5ysdxV0s0gT6irQrOA=;
        b=FM/NYQm/8LrA97/fvrCWZk6U4G4g4e9p9Z2mftaAOAGbVgp/b6qPHOYV3eNbgb68rv
         cUn0vjocNW2krYtwXTJO7XdKyKBuMdTtHXgWpyDfOuU2eYYjdMtFCywmtqPai4FVp9Bk
         bislPeYh4C2Pmaqfi/0fEFKsd1+mXYNg0noye+YUZw9vXSW4z6/a+PQdRcTxFgj+5XRm
         x4aHkNcIxIvNr/skAae4XqqjQ+GqyUgFYyuf56QGKquUQSpkSEbBZEAaPG/4ZfS8KaET
         isFV9ERBHQXhhMsLvJfJZdUPpSlabN7gT6MoppR84l3KUhHrmX9lh8eTZz5oLzT7ozbZ
         MNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781613317; x=1782218117;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAYzqTyjLrIOI8jk2lCoOCBWo5ysdxV0s0gT6irQrOA=;
        b=FOWoWdhx7ZhXQtpxpfdvl+px/BooWZrYGIg5GcUKzhLRJrqn69je+ijQBeXf2N9UXE
         EVCRz3nKzmF3KPfXA3SzABf7DKg1FU75c3miAjxdwSOR8m2HkLdd4GzjxSgTQ7CTdW+U
         bJX0Qb3Jzgcic/vCvzYJVkpQjOSkfLSkTenV9a0gkjNJi6l2fYEVJ8HyNRLmavkQxB4z
         hsujFk0bW1vvCFJM+n0NYTJiA0ellzm6LCFPn0xLNOCZiVrx73PpBXxRH+hf5ILKlj4O
         kkrEtzy2ykPdGwX4eLm65b6xrrcYaoZ84zutPoZtRPIElJo44hWFu16egvb6b9AqKrQY
         3PuA==
X-Forwarded-Encrypted: i=1; AFNElJ/e1zhLLRbq8jqcWx9DMhlwh+xlcZFcol0Ge88Hzdav5u8sLZ4WZE8IP0Z/870pixdiPmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ruNR3gMLeWhtTEcRBLzJ2sGy33WkQWCuKpdUo3tbjsF/pLxt
	ZukdfephS15A5W5PC3hRPQXBcYmX/kySx2hJYOY/cacX70AApwxzoDCP
X-Gm-Gg: Acq92OH/DHBfooTkEQQmdQmza1KrG+jgaMmZlRCFwgJlshuVTm9d2PXNU/r+3DJVhrN
	RMvhQkI9EqivLKyLq42V4V2qYxKvNqmEAmvTGa+GGPAs/0sd++3xo/HimV2jz7vRzPWfGxo9rYY
	03DzcMlndqtYTML8rPz8Uh9kCVv6g2WmFrWrdk+CIRY3pvYRuDzeiWVGvP8s/KR3g7lgubmuE3H
	eV0vtmmjB2LqJzgDMGCYJIzgFU2SDVQ/2UTYbvzwklZeFRmMf8OpOWxO6NG83ehuFcOLGEcZB1e
	ncgWsOKnRB39+PIXTfLDZJiUHRxwlN1LPHpHJC/nA5n33wJk+7sIKWHmGxXOAxRm7ClnaKgky94
	3RmRqjBVCOs8oEY/Y0tztbpxqd5F7y4paQrVrNbBcGdABZ7dJdTyYK9zZfunrKBYY42xXCjvoC9
	JU6OOmz0OXzlktfGdDZ9qwyp/oDA==
X-Received: by 2002:a05:6a00:8d6:b0:842:688f:3089 with SMTP id d2e1a72fcca58-8434ce832c2mr18655919b3a.30.1781613316626;
        Tue, 16 Jun 2026 05:35:16 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9c4c0sm11794275b3a.3.2026.06.16.05.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:35:15 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <20260616161011.835c90f0-38-amachhiw@linux.ibm.com>
Date: Tue, 16 Jun 2026 17:38:37 +0530
Message-ID: <a4suelh6.ritesh.list@gmail.com>
References: <20260609053327.61563-1-amachhiw@linux.ibm.com> <cxxqerzk.ritesh.list@gmail.com> <20260616161011.835c90f0-38-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

>> > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>> > index 3449dd2b577d..7472b9522f71 100644
>> > --- a/arch/powerpc/include/asm/reg.h
>> > +++ b/arch/powerpc/include/asm/reg.h
>> > @@ -1356,6 +1356,7 @@
>> >  #define PVR_ARCH_300	0x0f000005
>> >  #define PVR_ARCH_31	0x0f000006
>> >  #define PVR_ARCH_31_P11	0x0f000007
>> > +#define PVR_ARCH_INVALID	0xffffffff
>> 
>> Logical processor version is defined as part of the PAPR spec. We should
>> ensure that this invalid PVR is also documented in the PAPR spec.
>> 
>> If you have already taken care of that, then please confirm and feel free to add:
>
> Regarding the PAPR specification documentation: The PAPR spec documents
> the valid Processor Version Register (PVR) values for each processor
> generation (POWER8, POWER9, POWER10, POWER11, etc.). However, the
> PVR_ARCH_INVALID value (0xffffffff) introduced in this patch series is a
> KVM implementation detail used internally to mark invalid compatibility
> mode requests - it's not an architectural value that would be defined in
> PAPR itself.
>
> The validation logic and the use of PVR_ARCH_INVALID as a sentinel value
> are documented in the kernel code and commit message.
>

But that still worries me on what if PAPR wants to re-use this value for
some other purpose in future. 

BTW, thinking more about it, if we purely want this to be in kernel only,
can we instead add, something like:

     bool kpvr_compat;   /* Does kernel supports this PVR */

rather than re-using & overloading arch_compat which has values that
comes from PAPR spec?

Thoughts?

-ritesh
