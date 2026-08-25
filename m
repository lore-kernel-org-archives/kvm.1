Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFED37D11F
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683254; cv=pass; b=Emr9DqBjB2uuxb4I0c3DJ7Olo0yumiHD0TDsyw+99vAa/iMuZH/3XL9qLne3ISAlbOrXN1OjPLDtDfgs+JJkSllSBSlD7AGKh3PaLu4WA2eOLGDuwKYKaSj9nCOGm5TUoVcAZXc73cSWb1VlWBwfQWS9ySOLmDuL+SMmZ+a4hE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683254; c=relaxed/simple;
	bh=IvFl69wt8dBpBxkG539/Xp2+GpHoZasUiTDi4EJNqrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXg4SN65GMOcZ2cRPPRRKQrPp5pdOFzeSLIVBXDSBfQrD3or/l33XD9Pl/1N3UzC074jlv5xmpjxcAjWDSA3HtKPB2KyIpY0x1ZM4pae/F/bV2RwFh6QFk52CyZ0BJJJqH112P7Ve0KNy7JcGOYL6VZGrj/i6lydNvqFUDUq/vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMHPjQwg; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMHPjQwg"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69fdfd98eb8so18151a12.0
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 11:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787683251; cv=none;
        d=google.com; s=arc-20260327;
        b=UyAKUJ2dAZsaWo8zEA+gfFpUl0sZsIHz0utDudw5D8Uo52jy2fFU01VeT0Dcq+176g
         mgzmWChBeSp5MNkMewpnDpYwMn5nlA8asmem66sEdDDvWU5zAz8Dyg7BSs4Ty8OEFB8M
         lzvKQfLHm6mq+UpxdiXBznfnstNT/wPl/JUM7mcUJ3VKxfFKrGJiwFlp9E/zHr3Wh8kC
         lyyCF8WO2sbyS0Cpi54GGUYNO2EfQ7G3VR7ITArr3hsjRDW5VZKRvpAEgidncBzV8TkU
         ybX0spJNNVIq7ATECikM3v98PPRL0JFujb3po9smMZMhP2I+ZAhU3lUqZtX7EeEAqL0g
         e2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IvFl69wt8dBpBxkG539/Xp2+GpHoZasUiTDi4EJNqrQ=;
        fh=y/4UvktYApM8PDeARb560BVTeZFkYIvdm8TSNN+gXyE=;
        b=phA0p5QXMEkZJHVjR3kWALx891eJDuxC10Pl7yl0JYH6zxTh/FAKr2YQWHBA1rTc40
         g4cCgPfiQ521wR6VbJ9fjCuA2NzqFUwYGfiJrNXelLAFdpx96P+1M4vj78ct7OMVigzr
         Ogm9xS2XHb2sbn7vtFxIqHS5qAQWmBo2wv7VCqAscBu8qjxNfXb1UVApRH45H4pjGQhr
         qvLCOhg3+MZJWQm5nwFZ/N59UmVwJMQd8VfI3qt89bI7hRvKVz7NmgL5fqj7SNM8iy0b
         RFvuO2ZgSuPh0HNk5IvS08ZgdlxnXDqi/KVwbWvxpVCbEZsknVj1mb5x7ZdHuAsr1X8D
         OuSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787683251; x=1788288051; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IvFl69wt8dBpBxkG539/Xp2+GpHoZasUiTDi4EJNqrQ=;
        b=nMHPjQwg/Tc9TM1gAtXgxZ9idgVppuae/D++jetwnwuTayc5pTHXuEs3FMkDI3adOF
         gBvuQnxHTJmBmoGGjB0L1M+6isvZdU5fDAFjOw0Wn4cFMX6meotMP4IaZQreIsn6yfx/
         6cc2Kf+dRFMTzZ8ZcvUYmP/ZOD2I4BD2sqs9U7WxPWY7U0WEaW9hX6l89clzjjEf+4hP
         jdkwctf6yYmZhkrPRJtOe/Cg7uijNCNfyxpkvjHVyujwSzuiPjfFbAwj6www2JGccO/4
         eGF62KRn+pLaFXm+BXRwPjvBXQkWxCCqeh18gWs3cUsCJ1IonNCK3n2+h+DKZ86F2MhZ
         VJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787683251; x=1788288051;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IvFl69wt8dBpBxkG539/Xp2+GpHoZasUiTDi4EJNqrQ=;
        b=ZW8ONzeBFJZ9R9npjGdGo6/96GsK/zG/JGsTRmI8bmJQ1cACJnd1COnNZFm1dlaTdt
         QtLpbaLzhDwCuH5poYYyrXKUPDuZEn42J/sCwU0O1qCM/G3pnPTWppkY1IGG6SUlnk2i
         /1W1gro4VetIbyLXm0MIEshtIf8KqtZXaFEgCEqV/QhvysPxk51udf6OgQFUlRusPp6j
         U6MyeqQlBVdgHScpECvzxE7p6Ud2AxEfMdfTzG8mTtGkU6/M78JIcM0IkkJoxi3tqnVh
         6aPtbb+0zbzymhsfoPYor4Ei7EjNQVjZyAjker0i6/pXTa7+A7sTF5VBJ1kdYfj4lq4W
         XAoQ==
X-Forwarded-Encrypted: i=1; AHgh+RrazHoKjWScMdvUpSuaFJUw/uEKwwHDGiy6HpE5bmnt0Igs5SQsGzn0k0I+jVegyiukU0k=@vger.kernel.org
X-Gm-Message-State: AFuF++noaQFpMK1QKqTmbE5lCGYXUjDcfJ4Iq3oGjmYqVNl1vyhhg8WM
	UtrAn3LzzuVIofbor6WCWZxwxp6fhlZceRDAAVqGu1VK4GAw1CV/pUvWxbZxpur80Iv0w2MKPBV
	EJEnPW7oXtQhnmSsIII9OUofn6hOqZJI=
X-Gm-Gg: AR+sD112hUfeOsRX+br7vMGeyeb0/RCLPXbzqMfkooE8mk+qvL48ZMfxh/bYGV56jMF
	ToU1nrDSCvt6ct/8E0gxipfKfOBA12xq2jfwVtVrkHejRmaUf1rtSxIsXQtrDVjuDqzHfRwxcU4
	H3F5L5G8GgHCNcPO+xEzgGKbGQW9kjzCbUeVcO9IiJlR3WDhj9myXAzY9Tm/5lC2FQtRU891aYw
	B63QQp6i8ND3yWhwCmk/5d+qhDIeZ5Ae6sXDrhIJ6IvjN7p7h3MAWocP+tj6eB3ObHJH37PVym9
	ykoYrTSNB71eEhvNlc6kwVYmfQrR0QWdKwvYd4n+tzWsEYxe5vc3UJhNaU06wvUqTv/tgH053ZQ
	=
X-Received: by 2002:a05:6402:254f:b0:6a3:fee5:adc8 with SMTP id
 4fb4d7f45d1cf-6a5df324b31mr685775a12.0.1787683251228; Tue, 25 Aug 2026
 11:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822190224.3788887-1-nicoyip.dev@gmail.com>
 <aoyEMBz-SYLigbGp@google.com> <303eb59af516335e288647c19254928f89fa833a.camel@intel.com>
 <aoy8Y19RV_Dgm7Te@google.com> <78e381a95f36b5a9325b1742b8f013e62709fcd5.camel@intel.com>
In-Reply-To: <78e381a95f36b5a9325b1742b8f013e62709fcd5.camel@intel.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Wed, 26 Aug 2026 02:40:39 +0800
X-Gm-Features: AcwNN1VFyaoINwHFhJ9pgQfZFVn3Nk9TtsIN2dFauboqEZrJ71ScNpYuf0vLE4k
Message-ID: <CAAo+4rUbag3g+w3yK0OzLKPWDttQ_3KzsxAcxhPy7FsGqo+1Og@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: Protect noncoherent DMA zaps with SRCU
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"hpa@zytor.com" <hpa@zytor.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Thanks for your review! I have just sent a v2 to fix as the way
suggested: https://lore.kernel.org/kvm/78e381a95f36b5a9325b1742b8f013e62709fcd5.camel@intel.com/T/#t

Best regards,
Chengfeng
