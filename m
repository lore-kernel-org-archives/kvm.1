Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D1018AE3
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558281; cv=pass; b=jtetzIsnXmsGIHG1kRIr8eusgS8pDuceBEXrTCUH17tmQn7Fynh4WRfxqw6USRD866MlrvPu6oBc+LHjwZpRA5WKCUWbHw63QHgaIMyJk5HCrFASpruAisFzmh04jotglQQzAYf+ox9tO6eyUnVlprwx69l6UK7lG4gmwOpPbdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558281; c=relaxed/simple;
	bh=0nqgAkzlSPgwqtDRRuI4+mfAWTF0IX7tVXYBeqoqGII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKtzUzZvxngfW/ym8E11HFMkPSJqdwIfNes+3+8zrjh7L/ODHtxxrqDzDlUnBEKuOzV804OZeMhMSLiXHN3/FIjD+VnRetgx8jk9zHqKz+nwD7wbSA1vfO82P27g9rO/oW3Gly3W83+apvZ0ynF83xQHXTLd9CYalvYtwCi5dEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGKI6jg3; arc=pass smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGKI6jg3"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a2adb9bc3cso345757a91.2
        for <kvm@vger.kernel.org>; Sun, 27 Sep 2026 18:17:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790558276; cv=none;
        d=google.com; s=arc-20260327;
        b=cZULkVLq12t9t60AnqqDF7OObOF8lUwDINN2FsNKObcNc+9YzUoTOB1VdzTyG7t9Wf
         BJbnkf+GYC50+g2A7ZyRIVoSovBcuUhWskmUfu7ym0asDnAnhRByx0zD7WJalMEoJsBo
         06yZqRMWZ8Gts5nF1h9mRYDDjH0TCte4zjyuKUN2GZF1qXFUgYUeuyjaey7vRXx4xwuB
         nE1RnSjxk5AwLzaYrTjWE2OlO294xl/uplMQT6TT0+/IanspiUsYzBvsoBzLfQbPtXJO
         FcrUokpe++CzKf7dyNIBXCF0+4Q/h+yJvokl7S5qRBeYk9EayFdgzrTZ6Pb/5zNqGJut
         e5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0nqgAkzlSPgwqtDRRuI4+mfAWTF0IX7tVXYBeqoqGII=;
        fh=pY6kLu6DaIvlgJAKRalUHEYT6QD5wYzt7o2cNpKKbVk=;
        b=mggZDdHHZVkEOyOo56r9e2JwagotPssCg9dE6GDc8chdQwuYyY71KOdscMpzHe1Rwi
         RNPv7zmClvzbX9+8nCUE92GYOUTK/dmSfrc5EKKDSEzQj6dtHC0fZgk/0vnDeZar04OX
         oLUXdTid/niMDpv6VvZiT0X5ghdQqpF+za7VcN4AGEETvOTM8F+q8DTj3pW7X7n5zqPp
         IMQYfqYwuQtG8cFwVOTWVy1/Y3hnZhZ2p60EEW/XmOIhjkE4D0dWR5Ucm5vchh6WEubl
         yQxjAkEJNJW5dol58UdgJzysIvqQoS2H+4rEbvI6EVWBpP/4tab8wJSCOprF1F54mSkR
         3mBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790558276; x=1791163076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0nqgAkzlSPgwqtDRRuI4+mfAWTF0IX7tVXYBeqoqGII=;
        b=JGKI6jg32qU7HvvlSYoxFjnAvByO+mb43g3GWBjUljo+LbdH8TCg/qZlan0cz0AYUK
         TuzS6cwINsUtf+EVB8QQC3JROVY2K6RkKqcMkH01GAdG3EbIsqR06ZVNaqnowGLGJs3c
         kdL4LJA51u3244uNESzs8J3djYiq1FDkkGNucwPkkuPD7l4Eyn+j+NcOVxmLa7nTjyKK
         xm+LjCTUpx/MNBG1ybaRFLKke8q+/58UPs2nqR8K+InKNrWfqOFrMtnL84nGGSyc9dvf
         stQ0QaXg4V1wk4NN3aFWpkta1JH+I/vH986ITm4d/f30QCd6iAKyHj6bo4afoaiuBV3u
         XHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790558276; x=1791163076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0nqgAkzlSPgwqtDRRuI4+mfAWTF0IX7tVXYBeqoqGII=;
        b=m04U5F6MKS4QGjcOAUQyePXe6VtIc9w5IehM6KPSYSl/q9FhvcCNrJNe5pF4QU/fwy
         tfhDxook8X/YSZ0JpkKClLnYmYZ/2rD221f/0D7IXd8b40yLZvRKHdVVd/eAD9T9XMaA
         X0OjDaCwjIrHOjXXJ0HbSbxVUcvYQqyh5ELsJlrTJIBjdi4C+s0Cxho8UjZZbH7dcKju
         fDmUPjEMOb0oKmjutZvxrW5u6m467+fXNRCh3c96MPW+5m6XtZlkMqt5MRX8siBd4e4j
         IGpWK6dNqrG/cLDgVb4gwbv5ZmGeVLfDuxNbXe0LEKvcbQKjM+tLirMkymMb8cd8vj/o
         PJSg==
X-Gm-Message-State: AFq9FYKp6PISbjecijOqk3QT7hVSw1OOk0h6/r6iFS4pXFIhlYkDbZPJ
	FOoaxBRefK0n8QK7BtRMYGSmTtj3wLgyIC5OM1NZRZaoN8mB6Ieq/It5CjCBwZ8G3QmjocJeLao
	/Q6LCWXrIBUwEYavzzyz8unLa1H1305XCe6Lr
X-Gm-Gg: AYBFou1nPjAS2RxAypf2g9e9he/yMB3DyrEgkgyv8aqIZ5lGkwjiFCCQqwfmram4bLt
	6tYiJ4lhjbGWOIjYkP1/9RGsSP71SEb9ML7ixkLTwD41eg/WRkQP/DYMtZ2DS/PE/r7m3yEP4eN
	icikBTg/sVtuUJMjggUr8GM76ZwpU28z+vDjOAkT/LJu1v+da2vKhBwv/Ua8oaiwca5K9myMO3/
	wtx9hR7N7yq16xxmtNFJOfgZN+BHFQffpE6audZAjuvrMXR7n9FWSQtvLHGd60j6EFffEJg1ETV
	2FptiFsb6KcAxRn1HkBIwZ9NKCZP8ES+IW+jI1xc6015dXNgxhN5BmkViKedF+Nqvr+mrOM+OZ+
	diDboRyHwE6yX
X-Received: by 2002:a17:90b:4b89:b0:3a0:cc3f:b93a with SMTP id
 98e67ed59e1d1-3a0cc3fcbf8mr4139825a91.0.1790558275492; Sun, 27 Sep 2026
 18:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807112818.958190-1-kimjw04271234@gmail.com>
 <CAH+3ta7b7MudRedhFG4xQH6-3ZK9gfkcEPy_aHsAHBwjyK81+w@mail.gmail.com> <apcj7xrcIhEw7lCl@google.com>
In-Reply-To: <apcj7xrcIhEw7lCl@google.com>
From: Jinu Kim <kimjw04271234@gmail.com>
Date: Mon, 28 Sep 2026 10:17:42 +0900
X-Gm-Features: AclHuK8uKM50viEvYvH7gJtUCOdNx9kwbsg5nfa3655kxX2O_gRVG_nRjZ7rjkE
Message-ID: <CAH+3ta7zvKzX=8nQeDSE3rz1i81=C5mSCRiXtQuoKkKcw=M58A@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Use active memslots for the per-vCPU MMIO cache
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, security@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean, Paolo,

Thank you again for confirming that this patch was on your list.

I know I already followed up earlier this month, but as a few weeks have
passed and I haven't seen any further updates, I thought I'd send a
gentle ping.

When you have a chance, could you please let me know if there is any
update, or if anything else is needed from my side?

Thanks,
Jinu

2026=EB=85=84 9=EC=9B=94 2=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 4:13, Se=
an Christopherson <seanjc@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Sep 01, 2026, Jinu Kim wrote:
> > Hi Sean, Paolo,
> >
> > A friendly ping on this patch.
> > I originally sent this on August 7, which was fairly late in the 7.2
> > release cycle, so I held off on pinging during the remainder of the
> > cycle and the 7.3 merge window.
> > Now that 7.3-rc1 is out, could you please take a look when you get a ch=
ance?
> > Please let me know if you'd prefer that I resend or rebase the patch.
>
> No RESEND is necessary, this is already on my list of things to grab (or =
to make
> sure Paolo grabs).
