Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51683EFFC3
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929047; cv=pass; b=h/wFtaCG9YNMbAeTHXBapFN9KhZu/FStMfb+gcKDkmP/pe/NUURC5n4hj6BehnRjnlGd4mjkfQnzhFnNoavUtbh3L+MZ2CYBDJnURVyxXM07SPTs40MezU/aR4zu/8S5e9NVhzZSeFu6lU+3UjNGLdoV2KtbfdStiQsZhUBuzwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929047; c=relaxed/simple;
	bh=loSSuZHP2tWK9ldq20kVsRCSVM/sEnLsRupLeL/hgAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvuOF+gBJHgH9RXjPWSMsLskP5D+4H3OQdKXWEGMFdovr0vx3odvX+ndP79S95BkzSQAyHy+ahlcf8O48YW3ks7rW7KQ90CTRlooIwvK5W1aJfpwALkKCF4WSGmAu3R8K40SrvSCvB6StAhKkHKbnvNukDPt3h2RGOVrk88ufSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f1NTYBDu; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f1NTYBDu"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso1236a12.1
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 14:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784929044; cv=none;
        d=google.com; s=arc-20260327;
        b=XW5BveRXQCY6smWSG5U1EplKChW+QeY905Zn9mV/RcwD+/c2Dnz2SgHC24zMXIl3Mz
         r3VmXU2MbDbV/dvKbbxqK0OSHOF/UcoTIvU0YgL0f3mVzilxVD1cxPrB+2c/hRjLkySK
         9p+sZVCf5ofSe0FiTfkSHZ2VW7f7AYj2WdkUQprQtcXnP7cpbd26y3WFq6wR1XhN85Z6
         Twp1Lt3CKMhntcHujXe69Duc6mmpSbKx2GkYsEjVR7n4ZKW/2ne9x5lpGlCq2KlU1g4W
         SsGtnNp2Hx12Sh6plp7mZUspmhKA+5/vD2rVfiJPmOAmBIXjm6Yi7RFb4hPJ+wdd+KWT
         F3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=loSSuZHP2tWK9ldq20kVsRCSVM/sEnLsRupLeL/hgAI=;
        fh=iI+lsBNYSIFGIUuLZbPV3hHQujOf6vx7/lnYVZOah8o=;
        b=AtOV2GMy3IkaOUr1cMogCdq6NFGjtlafBuG8f2Z9K306YRYdGd+6sWgJI3zB6adqtm
         AuqDh33e34KPnfNa4us8ko8dM+rAXbi3kpI0m/VJgIqp//4SfBfDYTID1wiy0VAWC/ZJ
         TS6yDaG3QcLKvofY4spphlzVNAzdq4ysMhf4dZ1BN0E2IqfY6sjnLHkG70tojnEswYuv
         5qNXBzj2Czfk4KQ/BsuTFD3wJ6R7DcBMd4ZXd5ZcU4Qc9hfi20l+7hEyisK3aI+7wBMz
         flzCY2l62IXC1QXXJei57Q7qz8i4WIakALs+Q1AaJ28ArXyrHW0uJgXGoOwYu2m7l5c2
         q0LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784929044; x=1785533844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=loSSuZHP2tWK9ldq20kVsRCSVM/sEnLsRupLeL/hgAI=;
        b=f1NTYBDuokfppJIOK4KVU4DjxFhoVdABWRHvDVRulMljHjzWJ+7bEXY2kcIyB7MSkF
         wRyEGBmnQ3iiOOFTHYWFxb6WYiWVIoFfRQBllQQir8djhFp9FDM82nbbMohjpwdzdTqS
         1Z+qOShXSpbsFMIj7+obs8pTgt6JXAxQXRunZwS4wZXYMEm51Nq4JFjgE4Z6crVBY2C7
         VDqQPMAfNjpPaN3KzrV1fmSeBIYmI5UBOoGCRSQSo0CTgJo0GWkrf58dccVDbydyZzDO
         CyYjFAedfXUyeSuzfR5IWzJ4045GcMBgIEnFOThEVWIhIu4Ih47ceWCpahmj9gN1LnDf
         MntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784929044; x=1785533844;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=loSSuZHP2tWK9ldq20kVsRCSVM/sEnLsRupLeL/hgAI=;
        b=EvLizePiNiJfNGrOo9kFwFzEPCXQUWN/2u5CH+GZz8nBReCKu15CZxD5hXkQA2FEkU
         ALctIugxkER/w0b5hNOvONbwDqBzipBwla+EWlOp0gMsgZAiaVK9iwdSj9xpdjjf4sDf
         u26gNhlHuUJMnubZD/4X3g5AW73yTMyk+6Bd64jWfnzWNi2Gssn8pVQg0nYJ/for13Mx
         VO/kD2sc62PvjPGBj69NcFMmPgOnBaaETPpRH/UKlABBZURxRENUSpdE/oJhkowlfbtB
         DCP4h5gWubTmZGnFEaHXak0LZs5XLhfxg/Xh27dCxJZzF0nR+J5saRr9ZpbWu15RkCrV
         DoXg==
X-Forwarded-Encrypted: i=1; AHgh+RoQuylhTRJAi9+7I3f8nTl+bsHKVuFUiiEIxVAWHxPC8mfHAkXZ+nbouuiy7Kg2bz1d19g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/7c43m4UDFeNrJ2Olpzp8V8tkzYTlbXTTjsjJU8vWbhS5s75M
	mYn3MMZcthz+pVhrEektcSU48cMAoiD8FFie26ZTnFFCmI9ye0gOPDYKaiUzIw5bz/xyxc1cE+g
	vFHAARc7vViEQIRuSFOmE1Ihyx1/m70pKZswZHqcl
X-Gm-Gg: AR+sD11JkqQ3Euast9/D/v1YZmDLKBaqTXYu52RjUPOu/nnYhJknAWeZp/8lcugpee8
	yKQCbjs0YitvHNWgkJ1qc8ZjLRyxRPB3pGXyB7x4VvBQlSwa5rFmjf14dnn/zaOlEhFK2PnY6oE
	cOISjOp8Y5IYDjIe1jb9lzbiX1Tz+78TE5aE6ZXYWGOdfpIavUAhzer9ZmjRwWiWFRR98i5yUM9
	Bi3y2nAOcBX6B3+Fm8250nU/IyH0CEPFtXeE/iUfJMfuRm/wqFYOxC9mR/3wDM8LJDpJG7eSUnM
	6z/v3i2AaTxZywPCTEjXOrSu98cu2Q7N/aXAYBr6wez14ozeIPM2wrs=
X-Received: by 2002:a05:6402:5290:b0:69c:83f3:4831 with SMTP id
 4fb4d7f45d1cf-69fbeef577emr9795a12.7.1784929043430; Fri, 24 Jul 2026 14:37:23
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-6-zide.chen@intel.com>
 <CALMp9eQv3Z8w2UoxDFMyb-zpSAD7RpL6Bzc9kfk=oGpDF7VySA@mail.gmail.com>
 <6fa18abe-4cb0-42e5-88f6-880a9ecaf769@intel.com> <CALMp9eSYcAoKR+ZiSe2R1-Oq1SAEfHJrHSXKzSvvyzcZUMTdHQ@mail.gmail.com>
 <e0862d9b-a1b5-4f99-bcd5-42f23b368a7c@intel.com>
In-Reply-To: <e0862d9b-a1b5-4f99-bcd5-42f23b368a7c@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 24 Jul 2026 14:37:11 -0700
X-Gm-Features: AUfX_mwZ9_2Mz6QMHNK_mq2BBlzqfCx-eNOgZE_KUVxABxKXrtVE-JhFbN3G-sc
Message-ID: <CALMp9eR5nDOgJoLh14Q_t_w2Ea25QP-74DdgJ93J2=CAS3O8Gw@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 1:47=E2=80=AFPM Chen, Zide <zide.chen@intel.com> wr=
ote:
>
>
>
> On 7/23/2026 10:15 PM, Jim Mattson wrote:
> > On Thu, Jul 23, 2026 at 4:44=E2=80=AFPM Chen, Zide <zide.chen@intel.com=
> wrote:
> >> The SDM guidance that "fixed counter 3 must be restored before
> >> PERF_METRICS" appears to apply only to a running PMU, which is not the
> >> case here.
> >
> > That's not my reading of the SDM. There are three bullet points about
> > save/restore at the end of volume 3, section 22.3.9.3:
> >
> > * PERF_METRICS and fixed-function performance-monitoring counter 3
> > should be saved and restored together.
> > * To ensure that PERF_METRICS and fixed-function
> > performance-monitoring counter 3 remain synchronized,
> > both should be disabled during both save and restore. Software should
> > enable/disable them atomically, with a
> > single write to IA32_PERF_GLOBAL_CTRL to set/clear both
> > EN_PERF_METRICS[bit 48] and
> > EN_FIXED_CTR3[bit 35].
> > * On state restore, fixed-function performance-monitoring counter 3
> > must be restored before PERF_METRICS,
> > otherwise undefined results may be observed.
> >
> > The second bullet contradicts your claim above.
>
> Thanks for pointing this out. I followed up with an internal ucode
> expert, and my earlier explanation was incorrect.
>
> The ordering requirement is not dependent on whether the PMU is enabled.
> The relevant recalculation happens on the WRMSR itself, so the SDM
> guidance to restore fixed counter 3 before PERF_METRICS still applies
> even when counting is disabled.
>
> That said, for the code path being discussed, both PERF_METRICS and
> fixed counter 3 are written with 0. I was advised that this specific
> all-zero case still converges to the intended hardware state regardless
> of write order, so the write ordering here does not affect the final resu=
lt.
>
> Sorry for the confusion, and thanks for the correction.

At the very least, the reliance on an undocumented exception to the
requirement stated in the SDM warrants an explicit comment.
