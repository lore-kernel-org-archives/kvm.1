Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF984AD7E1
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150313; cv=none; b=PjH+uKnRUQe+khSbTyUdJYrxdJ+DyNRHw4ZlHpF/TLxp7sTtoOFPY0evSMkTqeTd1rmEuxN3ygZofeOqXGdWjrunxr2zmIXjduXsuYT6MxzjguD/PW1ZLCm1rJuERk3qe4xUb3bSGff1Lus+pCSkbQ5VPQgVPa7ZeLLyKYdjDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150313; c=relaxed/simple;
	bh=sE6IqNm0eNjLZiGeb14hQ02aeuDbUoYpdWyVdAixDAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mCNK57mVFNm37iBKcCfzBbhjg5ASEL90xtxdD7McUuubeBj4J0MOjwGlZOgPebhM9cdQh3DVTzuV6zNZhyLtECWiN1KoXe+LddWPZvDd179g2RdNff6XdolMb4gDYQGRJWSbu+B07EXf2hG5ZPr6UxLZqB7fBVWpA7qLloyI+zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qzCQ1ZrL; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzCQ1ZrL"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86917d18880so1691836b3a.0
        for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789150306; x=1789755106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iEMIdGg/YB8V9cg4K+t6F4JD1Ok5eW2E/bnA8PxZ43Y=;
        b=qzCQ1ZrLZCUcgZqzkWx36GidqraL4ehrrh05kmiY8KHSQtkS+BHyQYwgaLeNn/oRS4
         iOW5eCYbsewQRDvRU7j4CGKHeFf3rxdUFWzRIehmi7FDxOiiYZEU+sjIvzz2/rzL6bOW
         +6Wf5RAZ+P4j5EiJHmvj3lkGsE/sR39tkHwUNR62kFGVt1UgSSxVIUj9pEU4oh8uS/cg
         1/DOubYOw1cFwgvpXDDBu9Hh2U+8wBNlq2Th+7LuhE8oDvye8qCEf6Zfl0M4CDx2cgHy
         X7Vv7dalv/SoZJSPWW9PExLauYNR2C1BDuSqQ4yxoIUqUgdt7WeP5P/bAHzwlWwETEr7
         xptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150306; x=1789755106;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iEMIdGg/YB8V9cg4K+t6F4JD1Ok5eW2E/bnA8PxZ43Y=;
        b=j0rRMmPX107EopvplS2RLjxMREFZo58l6Qnm7TEgRUkIuYAkm1NqstEQtY0AmUnELk
         RS6cJcQfXY7zWEmE/oN8HARDG8myLPkZRnHMUV275eHocDEcZ7673lHVnjs3H94GuzA6
         lDyflSDFlZ1QGsgw43XDC7OCvtmUbZlnDjCj7DYmQl1i6pQYSBbnYrQr5BTXG4LLRizu
         AiKYGh80aIy0wp+CvW6scGp3J5UGAIfEzWWviLas0KRGDcsuwXnUpLvcU+4Xkh5eNige
         XSi062N1Nqd2ba4N1L8neI2+av0Qg3GpeDY+jjxAvWIY+zSi4dVBoXrwIgNZqdLz3cWq
         kf7Q==
X-Gm-Message-State: AFuF++kVuYOH+pJZxmNa2x8AKAujeS29pBM4ik/EmbQ+GYIN+cInBcpt
	gvNhIJLOHIJJDOvt+zjHnyNxI+Y/tff6O56uJ9Si3R67/jlEkNAXuley1XbBh1rArhlRjenkRk4
	1h5zVAg==
X-Received: from pfbcz23.prod.google.com ([2002:aa7:9317:0:b0:86b:a074:218a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e0e:b0:855:eb7b:5804
 with SMTP id d2e1a72fcca58-86b2eaf1a96mr8151161b3a.4.1789150305500; Fri, 11
 Sep 2026 11:11:45 -0700 (PDT)
Date: Fri, 11 Sep 2026 11:11:44 -0700
In-Reply-To: <CABD=WFOS4j4hDv+pW-eEM9HAM2q2GY_iYdAG+qvYcUEinUrcQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CABD=WFOS4j4hDv+pW-eEM9HAM2q2GY_iYdAG+qvYcUEinUrcQQ@mail.gmail.com>
Message-ID: <aqREYDrEyelD8eEk@google.com>
Subject: Re: [BUG] KVM: VMX: BUILD_BUG_ON failure when compiling vmx.c
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?B?UGF3ZcWC?= S" <spawel523@gmail.com>
Cc: kvm@vger.kernel.org, "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026, Pawe=C5=82 S wrote:
> Hello,
>=20
> I am trying to compile the latest Linux kernel from the upstream git
> repository (v7.3-rc2-352-g08df884136f1) with a custom configuration.

This is my fault[*].  I have a series to fix it, "just" need to get it test=
ed and
posted.

[*] https://lore.kernel.org/all/apYh4GDHD3Tdb8t4@google.com
