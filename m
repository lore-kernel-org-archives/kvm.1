Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B014B349CEF
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472227; cv=pass; b=ibQQHiN+FzSAbw16Lgu1UBCvERe409iiOQpIINUgyzn9CCQQzbBKSMPffn9tZM7mzvgqbmxRxPZdYsUCx6XZP1/FGSWcv4jPNMuIwdipObJO+Gjagvm5XsJLVXTTcgDBeaOmHfcg8Ul5Bv9fA1B6ReMP/h50DMvWpg60toCI9w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472227; c=relaxed/simple;
	bh=QtGnFGrJTBq3cSANlv40Fl4rQnbEqw91J+szuDFQOAQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOKd3wMU1thT8JN/mzhQ22WVqGZUAfFq/AyXCPLSOqOaAnl2gVmFp50QZ6l2H7wx8d5AV6tFyxLJffsrbbN1iEtNrQ0BDa7pZoOkn8DDHVO7KrGWrfgYIPP2YFF9AL9QLdSI6yKpCa+OcmYdTFX7QbwLLvQ2cUX4GAMdEhW7cjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jxRQREnn; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jxRQREnn"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-6329f0e0a16so4972962137.3
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 10:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779472225; cv=none;
        d=google.com; s=arc-20240605;
        b=jtwdwQ3sjN6lB7S35CwCObnLh/ZD+GGrSI4hkTreM6GNYcBtRm+spYdN5LcjIZo5cQ
         9BZo3botcx7GqBAgFeWSbRmSpJiPOOqjOTdOuqX+9GjAQKQWtrcrpN8bfSP3q7QClbba
         zqNZxEGwI0MM7XzgMp8WD07TDuGla28HI8pt/ckBbTVz3lrMT2uMZ53ZvtqI+VwnBCnr
         wNGu496q+6sbhUTLkcIz2tgME0kHgpSzFlfUf/oBSnuOfe0uzokWd5kI6uetEiRCIqEf
         nYQHFrze28X/2vXurC6nmitrsu3fxTZRZPjGUPFJbetflx2jCXjqBD4KfgMKURnlviZN
         v/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=QtGnFGrJTBq3cSANlv40Fl4rQnbEqw91J+szuDFQOAQ=;
        fh=mVakCq5KCWjzjBALrwiILUxswrLR3rjQnAUkl3LFTs0=;
        b=fnPApeDCxCJ/38BaJjHT6qqZoi7xHArulrX+6n9i4VfOzC5L3sIGen3B+0r4XU5RUv
         MQ3hsY1PESunaKl5/XLfBbkS9hIqkCQ2OcHri51YR5EDekyIgst6wahBUAk3AkyIE/lI
         M1cNDIOQPo8kLYBv8iB4QBzPnoxVsrc/weZlqmgCT6iPetwTwyoO2+1fHTbf9vNYvBq7
         RTSsrgV7WuDhjWQJ4E7jwugDs76vrw0ymGKM6s8tM/Mp271CDZc4cJrUTNhGJAibEwpe
         fMiS/u7wKjWbeZxr8I/JtbX+M/yGvynAcDmmC2cDoFFIxmrXU4XZfrsyX6oMwTT1m9Fb
         9AXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779472225; x=1780077025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QtGnFGrJTBq3cSANlv40Fl4rQnbEqw91J+szuDFQOAQ=;
        b=jxRQREnnETGVYg8wL/H1bV2tHVl+Mu/KB8diV+w7Txl2VnVzYGfvnhViMRKBPBdv++
         51QNsfNKfUJmmjovSSVWNVIHHiDqSEss3EZBkSJLUK+2I+kK+1xiqvG6U+VtLekq8ZQI
         409LISrBVro9WiMnQ3WXeQy7Xs2nB1MewIFOn5EVVMkwP+8eJun/6J+AwAzL7Gp/zUeO
         RAHq50bsv3wkxiDm3H9xZ5aJVYFbFW/Wkd2lIlmgSQHVM7WAPW8S0Ggd/k39wtuDY3mM
         PaIQDLH4kYqflWyAbshQU6uG92MckaKpF3/aG45j3oo2qDwO68nSnTKLIwPvBqgcxTJF
         Nkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779472225; x=1780077025;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QtGnFGrJTBq3cSANlv40Fl4rQnbEqw91J+szuDFQOAQ=;
        b=OmH74rFVYFovifhsnqvPhTcA4DoHd+Rza0A2pnabF/z7eILDFDke1ylxrfBbS3lcBi
         hRhvBXMtT5FNYQQXUKk5pMkQBPtPWeQg4WYpWozk9wqw55XSsmVWnCBlvUlgnR0DTw88
         OkOp6oLMkAFizu9DcYuJD58AGNNQMMOekd/pAyk66rMpwpgpKHDCB9NGtDysDIsxTkOd
         GMRFFPJ4yBNuDLWbTNu1nBL6D2sJiempTBaDWBI07vXMwXRm+pIHX1n8Z6v7jolkPq/I
         Cs+Iq9x2atH3MLZHzIRl3EeE0EdcySubr4W9jZUsMFaRjHTVmRaQjSWe+FTR84F/Ha4g
         cl7w==
X-Gm-Message-State: AOJu0Yx1Da10Txv0ANFReQafYFjBjwKwO+/dxFlIQBkwhf1lF3O0P4BJ
	R7Yxn7vafHOFHhjLSpPLCheAXC6xX0hKmnc0tB/UKiX0s4ryjQGYPXRJrNYyNh6kSiDxs90eoTJ
	GqmaTU7zaZk80+nlcQFIaYtz6OrA+aJmw68VoYy2C
X-Gm-Gg: Acq92OF488AE8xBZB8elrZjTGLNORQPpHxMqzSfMLZRHHZerY9llJmTwDkCP3rV+gV1
	/NVUBy9ghzpfGwKww0LaYFEzucXwQb1i5OErcEcRL/fv/AMb0Ob7M6ZUJuYBMV4mx3dM1HKxX3G
	e8jHpAG2prPkiOU2axtEAutpU2k1MMEwyxM7uNIa40m5Rcnowqjf8rOaXuZVVGr0mM/R66A/JMb
	7zLYdkmxRddQKVAFS86OZR6Srnz4OPjDfiS8+FkNroliq7E+W81WXrtazm9l84kyP/Kbtafc46O
	bPEBG4ag1+DDl4R3VGmElghy9uGJnTy3B5goWgZQp1YJByyDH6OceVLzNCGk0KVCVFNl2Ufn2U6
	wo9Bo
X-Received: by 2002:a05:6102:5ccb:b0:631:b834:e051 with SMTP id
 ada2fe7eead31-67c7d977c2cmr2934980137.12.1779472225066; Fri, 22 May 2026
 10:50:25 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 May 2026 10:50:24 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 May 2026 10:50:24 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260522171535.3525890-3-seanjc@google.com>
References: <20260522171535.3525890-1-seanjc@google.com> <20260522171535.3525890-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 May 2026 10:50:24 -0700
X-Gm-Features: AVHnY4JghhdFYRuUUfTSQ76oPHlndxQKHRLoOmZQMrlkofDXzB5q7N8R8CzcqpA
Message-ID: <CAEvNRgEjcARP7P2bW80qM6BmHH97WSg70+=EMPw7jT=KtpPK8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Add and use kvm_free_fd() to harden
 against fd goofs
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bibo Mao <maobibo@loongson.cn>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Add a kvm_free_fd() macro to close and invalidate a file descriptor, and
> use it through the core infrastructure to harden against goofs where a
> selftest attempts to reuse a closed file descriptor.
>
>
> [...snip...]
>

Thanks!

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
