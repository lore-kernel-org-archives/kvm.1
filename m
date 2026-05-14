Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B222FE04E
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775793; cv=pass; b=pn4TkMBXsbXc87nBmR88rz7xhwWYFSMnT79OrBPWxtniYKNo0MWV3u+BG1LZciK+9FADs70eX56vIJy43x7j1LAqENiRH39NjoCy1t8rRvGvq73/R926Lez+NXTP5LQiUqbZwIqCpYO/b9Qm2qm4e9EzxsDkFbkzrHW0hB1Fd4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775793; c=relaxed/simple;
	bh=Q0ib4SDX/P+VFF7eKBzjA1FdrcNeZGq2xss6Iv0jB3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvrqs8a+9ug676aNpYDzGRxXrtadoLnKkn+ka5uMn0Vigw6D9iETf6NLhUmV5ULVjH0aRJSHbwuRwwFJmBPftBzKQcIIrs0ds3JmpsCjZ32uN2NZe2p26fSi8fSBmq3lTZTq2SlV0yDdJzWgtqG5ztMVFAMdKaV4gLi36FSqCOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qG/rwtGA; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qG/rwtGA"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso10684a12.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 09:23:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778775791; cv=none;
        d=google.com; s=arc-20240605;
        b=Ftnpw0jY07+MGWKnpxY3J+orEWPnS3NbUNdMwVVhsR6EMarbKeBe7CrOlIGrFrB1TR
         KUnuelv4eHLRORmoO38fuZB2cOSr/X+i75h/HffCV3CxM4LTVVzmp73tn6qgLeQhV1c2
         rGxfx7+DisBL6Gz6UYQdc/nwDh7nBxIrZQTpExsD41oLe7XuyNQXHI5LmOLH7Xlo/C8S
         e5gCKB77MtThvXCC9twB7Pa1Z+XtTd1xtEa5OZdq9tYCNGH8AJICCGG/i2/yZ34ZHDFb
         DNWWAK+7lJ2l9LXc3PXJrxTAx3w0vo3AHw5j45xiGB1qQp62H4mzu/Mg9ipfZ+mLPLc4
         aJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eBe4adX/bnjRGKzW5ohsf4TCpEbTJmEdSDad4e+lcVc=;
        fh=CaX0qZ9i1RTkpMi5wjDBmoVZHI/rMr/rqutgWeqaQ68=;
        b=gxA+l8ICMv2Zx7En3+PQZg4Le4RrK3oBugS7jdEe8+G5/+jgpIfDFDMQTCHT8uGpk4
         zKdGs+I+TmkJfDNS/AFFLHhS8ldPiyINgvYf9c0FAo3b90wy3E+XBKkdjoS2dxPMcsY5
         S+IiXjpB22AJ28jX+kwQRBdz8Gxlg9gzG7lWqxP3ELen642gO6/kDmvkxW9Lm+Dt/7BP
         MXV/naJN+XTWkmSqecGUwJPBr75tGkhxSuml7P7xYBaDilaBIxMR2KZJsCUXf8w7gTkM
         6luSfcXlDzXMk20k+tj9Gve8sOdNOZV2NEV7UBhDlxGCXpEJRzCnkywLqGBjM+oqJtyt
         SLqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778775791; x=1779380591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBe4adX/bnjRGKzW5ohsf4TCpEbTJmEdSDad4e+lcVc=;
        b=qG/rwtGAqKhn34ASB85AlOnVO+EbKJgG5JBDFa24VWPFjqpOHwbvPXYHo8UXhpJYYk
         7py9jdjUj0HG6N/uYxR5nKVyS01JJxRQ4OLegjQmwr7u7dZ1zXdbZ5c3E92KYQuI1ia1
         HFKzuRrFagbioZ5doli6J8A5yJ7fyQC9LEZ6CD0mhNTx4oBAhHYuck01dRwgmHmNxB/s
         Fhi1G8ZsyiQRe809Iz9/P/WBWHRJ23ICcqSmPzjeq9dzafSTxgZ3Bq7raNcE6x0uCqyi
         QEWmnZ8U1j1eyzQtEvi9mOoWMEiT4V6+civTHH2giGccDFe2xxqI414KkpY8qVXz5VRO
         C5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778775791; x=1779380591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eBe4adX/bnjRGKzW5ohsf4TCpEbTJmEdSDad4e+lcVc=;
        b=FY4WpdfsarYqbVqLD6UBJyoKnY9yZS40CwwNNzSeF0WAMydG0kcVqnrEqh0kQABvuP
         DdSE6vDdzRD64Rqf3Q8SByCbyyR22LUpvfk5YHzP/ZQcaVBLpiGtfTfBUCahB33kevEB
         nZRbQsPfGOSUjjhkePyXpkNKtaSz9FXQ2H0cB9LPlSptrlaH3SWXv8Ftk7Ar721ZPlu8
         6koNraoXtw3FhqLxqg2pbM4dp5lGF82MMdJ9/MzpAuBFvGq0jBfXmVzwIgd52vTrGahm
         gUTcHH7cQxPOG4S0PqA++WrNC3NlmZqzIadb4hOsa4G+yo3+3Xt6CQFHA7vWEFMBMTxW
         KGBA==
X-Forwarded-Encrypted: i=1; AFNElJ87BDGOcTb8eOqz6lvHrvg2AN2ch41YzUw/lT91iQz3uFiPy20sEK85b/xYwzG8eIZNbbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSWE4htnkKiJkOLWXLedLL2rLo+FG52TrN58DiDuuGmT83fEbe
	2Z50+uV+byNBE2UUoLQJIvueymAjbxeGvowbh92C3VtExfdGq/TFQPvFtMEBXarr04FCk2N2gC4
	rM9PfzNM9fgwJoHr93JlMsJweR37in4ZMhXJoyOkN
X-Gm-Gg: Acq92OFLWe2LIqPBNvhk+vVEvlvhtMayUtnf/I6AVRdjvJ3vAJLXU0p8tPZaKHDX5r+
	F34g4dgeyQp71NSOwYzRucKu3t5UZ9QnNjOMfJUBPh67+VHANHsl1t2htyrinmOf3wcP2+SLR8+
	YWLQ8xYq1fLuurs7gPaO0tBPzPhCzhZK7Ya/u9Xa5FedylDsYRukM7IT7hWlJTFpyZCdvHPpK7Z
	iiemjEsfqM1M8LREs/7zh/zX8s/wr5VjPz+nwFGAE11HxHQFnQDuUM45CCrdnOGV2ZMidWI1mN4
	WDgAoncLrga1fdcOmg==
X-Received: by 2002:a05:6402:a547:10b0:668:c2b6:9fa2 with SMTP id
 4fb4d7f45d1cf-68326bd4ba1mr41151a12.7.1778775790450; Thu, 14 May 2026
 09:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513224608.1859737-1-jmattson@google.com> <20260513224608.1859737-4-jmattson@google.com>
 <CALMp9eS4s9tsOmvDUDeqS7oph0mSHyhxBiULQdwHVaG+7gXLSQ@mail.gmail.com>
 <agXcKDjnJc9DPcyr@google.com> <CALMp9eS831M153QmAgjzJcR2dFY_wCCCzDisd7_T6GyS3-gAFw@mail.gmail.com>
 <agX2SJF3rJSkIqDe@google.com>
In-Reply-To: <agX2SJF3rJSkIqDe@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 14 May 2026 09:22:57 -0700
X-Gm-Features: AVHnY4Lsmqlfaqp7hEXV3B-RlTugrnhObbgCElgWlD60p-logKCtI0xa4Zqrmow
Message-ID: <CALMp9eQTSxFkVf4vV83yNYvv2AjseHYiD3M68mcc951L4U1Jxw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] KVM: x86: Virtualize AMD CPUID faulting
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, shuah@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ctpence@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 9:20=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> Oooh, this is based on the generic CPL rules.  I didn't think about it fr=
om that
> perspective.  So yeah, addressing that does make sense.  What a pain.

When I fix this in version 4, what's the correct footer for Sashiko attribu=
tion:

Assisted-by: Sashiko:gemini/gemini-3.1-pro-preview

or

Reported-by: Sashiko:gemini/gemini-3.1-pro-preview

or something else?
