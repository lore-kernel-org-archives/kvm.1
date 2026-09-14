Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADBA38AC90
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789421709; cv=pass; b=WFhTfMr+8X0CHRJA+M4wTyB4yMlpZksOWhC826EGaLu9NEpCSkXctkgaGB/+0Ve1yBb65e7L7WMLP3+WjG8S4LqjVXA2MoY/le0i5vCS2XULyKsNj/BpBT24OLPhn7VEJbZa8r69mMDrLkicuDI/W+DC7dCQPzhTTTj2lm7/1ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789421709; c=relaxed/simple;
	bh=nD7LUp1TGjJhbOe9RG6LS0btJNgYnVlQKhEwxYeyMdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7KXWeOmoyMae+h1dyrq7MY23HhxhKMXv5pgrucyv3ogb3eqa+0w0q4Fp/jwhPr98NyEuVFCRzuhyXQLuB8GCyt6pqSNlAl3hZl/pia4UZJJR0RsG2nrEWc1lonTrq9uW9pRZUoShK1eD558PoBn9q14eI8VBTUlA8c13sEQxcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mfD9xvzy; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mfD9xvzy"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a5d8fd8d88so416a12.0
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 14:35:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789421706; cv=none;
        d=google.com; s=arc-20260327;
        b=ROPP+i8YExwBZ5ktCOq3s9YgULgb53oaHDRiTwIdDv5PUb6gbjQ94YHowiL1bbptgi
         oocSG4joH17azrUA7tS6NjnhN0LWlq49XzArs2TZ91GvjkjSiHDllG9pH2gb6BdTovt2
         dDbHJur1TJ8UOv6BQg3zpmKar/FxngahX+CVLPyihCOjyM1T0rAL83p5sLNHbE33PkgJ
         qpHmc/H+sBIz5jGVwrGVLvPbC2cTmsrQg/3RIrqhs7WWapsU+GqrWLJWRsP7oKY/OCzl
         stikhe2qshbocJw+tNHB/Y+N60K7zjPdcqBh1tOq6FZ0lOtxCWsVOqQbI+Aqegaz+jU9
         rS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z4CU8owMLFOiT53jD0/3aR022cej9IEBn58BpJ7gK4Y=;
        fh=XBIail14fw2wdcfHkD7fZZ+RgXoNmguk7plplPusIH8=;
        b=lwMYJHTYQpVsk4UJOuMAcNU4dPzhIFvKw4yW7gceVvtCQEb+g0LeWpieyFEaxUj6oB
         GrG3eEMV0/mFYlXYnlgyLA0jXxwJEnTL5+eyuysTnm1CejBzdqGzu6YCimgSkIS/Pl+F
         6kwwbfPXfP2j1nwqfBLaSmTGSJ6itm2lZFDxEK7RxeEuUtMJcStOY7i2t+ULvSL9hkk3
         +gmd2WIPZDKqDwQLiO8o3mjO4PCQ0VOqoWUvGEdVxIJOr2uGQQs3U4lo3hiST+RQ2coa
         HHzsESTRhn99whFKPKb26nNEppakGDTspDWbf2SA8R0S2kg4OZkPxgP2AQ2wXfAoE9J+
         Gp6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789421706; x=1790026506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z4CU8owMLFOiT53jD0/3aR022cej9IEBn58BpJ7gK4Y=;
        b=mfD9xvzyWJGAPeq+d9eQYU+2z2VTXEuL0D0i6SsclMnFbpex0Vt7qTMC6F9qgeGDYD
         dZbcUKnNRezlqh8MsvgSeqjVus/74loRon24EC4i1pq4GLqsljGK9bOdT+yS5O9PY83t
         3PfXQNQ0QvalKofpIBhIi3BGDiYApF100nOigLlt9L6P5qNeD1deVSfU88AZ0bAO/uIk
         T1coE91kDijzV+eszTYGqzTnkFmE4tbB57U2q5xxqyhxBZ8I2Bje+qerphnSAxriwNkz
         A/P6OJrKiXa6J/HnhcLQvjM21Ml5BS9s2OZBgad3C6LKIt1VzEqzWeoZXAk3c5by65M6
         IoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789421706; x=1790026506;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z4CU8owMLFOiT53jD0/3aR022cej9IEBn58BpJ7gK4Y=;
        b=Rxvc8w390PTuxELTlMzJwxkxRJqgLdge5SriOIhj32wQBPFlCZ+hu0EE9gk2xGoyWJ
         5ogioaR4N1JHDi4yuSxXQCC3K9RpNA+hrj+/Jvg1MaQJRHqpzAPnxAweX/7TKh1zSG0Y
         pBiboTGAcVruCj2WyVi8VNM8TS92j+V3TDPTIA4XTxgE8Vxfvv88sQQorDYefj7ZtcI3
         NpMuc1Oa0yNFeGwx1IB2JzZrHp0qzj7Qln0xzAOZyqwNw4SxXFIcICj230+U1bBIy/f+
         Md4ONY1RYwvRrwfwbHSB2tb6QCH3Wf9sArbfFCLsxcTq4KLIx6QL8hB/ljy7ncOALYdq
         b5WQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBCnD7l7S0Tj2CXbmQspqBP87UMPkHlI7zXF9rV4zweKrQU0Y4Nc8EXGf7+5tdImaKaOA=@vger.kernel.org
X-Gm-Message-State: AFuF++nwBEJr0fj8ozW+8qGCfXx8w4lUf7kWnGg7KNHJQJRQ6dWKWzlS
	VYIQtFucfd2q+5TOLd/opKjxENRCUxqK36VSIJ1Ze6QkMFWZN8hFHTgpSFy2W5amMGmy4ch39i7
	aY9MUaG5eLuQMKb+SP6ozGSK7P+rBW1fm09rnCycr
X-Gm-Gg: AYBFou3+0JdWa5sXBkUBmdOHaUBGVd8zl9XGJ3BolpwPh6hu2C4/0CCozoOnaWP4ruK
	hU0JKJKwLxy7RpJFnpAYkMFqgBPUvkNktycZFCh+axFTVqICOb8KyuRiIq/0CRPAMHo9nuqsDfI
	9TgzXfkQ+VI5BDERroYkv7wmLI9k8KlQU/rqgD7n1VgXyaW4tGFk6gMEfTy4zuHLMyGbp1r08rt
	4/obB0tURQ3ELNejxmcyj18HgDf7v9nWAR98raGbbgqixDy/vEpVQJnf1Is+FzcBjinIeU76i6D
	Kx28FnuOkGrbm7bzFloHL87uxPbKRhD3q3LS67y0cKgtQr4FxM/NTR/gq6zdVzgRfw==
X-Received: by 2002:a05:6402:a6ca:10b0:6a6:f2a5:1b4f with SMTP id
 4fb4d7f45d1cf-6aa0435f63fmr15092a12.4.1789421705458; Mon, 14 Sep 2026
 14:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789281096.git.zhang_wei@open-hieco.net> <f991a17dc1833f94bd6b01a777ddbde1c934933b.1789281096.git.zhang_wei@open-hieco.net>
In-Reply-To: <f991a17dc1833f94bd6b01a777ddbde1c934933b.1789281096.git.zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 14 Sep 2026 14:34:53 -0700
X-Gm-Features: AcwNN1W8DpIFYqNLRxuWVsKDVFF3RdiLezPbxp2u-Etse3aKt2NiEhNr2J6UFOk
Message-ID: <CALMp9eQ4Kg=50BhBZHAQVa8BMsqcB7U3OGrUYqfZWxeqqFM5sQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] KVM: nSVM: Use emulator bytes for synthesized
 nested #NPF
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 11:44=E2=80=AFPM Tina Zhang <zhang_wei@open-hieco.n=
et> wrote:
>
> Preserve the bytes used by the emulator when synthesizing a data #NPF.
> Reuse the fetch cache only when the fault is the current emulator
> exception, identified by fault =3D=3D &ctxt->exception.
>
> Add an emulator accessor to copy cached instruction bytes, checking
> the RIP and cache bounds.  These checks alone do not establish that
> the cache belongs to the current emulation.
>
> Write the cached bytes directly to VMCB02 and fetch any missing tail
> through the instruction-fetch helper.  If the tail cannot be read,
> report only the bytes already available.  For SEV guests, retain only
> the cached bytes because KVM cannot fetch plaintext guest instructions.
>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Reviewed-by: Jim Mattson <jmattson@gmail.com>
