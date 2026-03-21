Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAC52FF657
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774101260; cv=pass; b=Ceo1JdsHl0bKXDJA8sctbmos7RuIPUHz6XfNfTl+IqkZ/M3uDouoItDr3WSK2HUOjQOLVwY4EdZnMlM4m5WE01Nq5r5/eatdRz6D7MSiijYYKD5DRx2JcT6S5fHF3lgqwjcMjHjq7rT/JpnmI+N0RrGZ0BNYcLKCD6sQSeG9siI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774101260; c=relaxed/simple;
	bh=lZSRidiKqkKK0b7nf2ld5vWn51snx5OdbWOXwxFQLfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGkcALeQtbk/0/9j/jUEBFjNuCZpN9gbjJUJ6NJMM6Cyg54sNRZaZsQ7c99XrKHfB2iGvnYUyX0HinG1OKXPQgEfH4wgaskYqAyfzb8cVBqb6eTgNEXvi5TNmKK4ogRlXOaeTNR457PPuVCcI6pzNr/vWaVlKBXq2PFQjaJffBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YMw9VCiG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKDd52i6; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMw9VCiG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKDd52i6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774101258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLPB2Mfm1Q0AcQe8HguTctjxf/NDB8pAUyChv+UAeMg=;
	b=YMw9VCiGFaYoavVTp3fbfQIyUuYYe5UEWCPyjfk48RQpjqPAQx7tIXB+5Il/r58N+asGDL
	+eN8kxCLPtxssXITySohDalOfrMDFn1DL0UICwW76QE4/GGQvtXhIn3g7+xaqanZPWHm9r
	jlQwQ07JjFTYSMIL8O2JTKFJKgezJuI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-0Jj6TBqTMIyixZ_Qv_6KgA-1; Sat, 21 Mar 2026 09:54:17 -0400
X-MC-Unique: 0Jj6TBqTMIyixZ_Qv_6KgA-1
X-Mimecast-MFC-AGG-ID: 0Jj6TBqTMIyixZ_Qv_6KgA_1774101256
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so37398425e9.0
        for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 06:54:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774101256; cv=none;
        d=google.com; s=arc-20240605;
        b=CXSn5j4QHPaCsRN7f8a3ZzoexnXDctu12RfOL6w7DnoTF0ESYc9YwK7XGUOlZhTbYv
         d1ZHf300P8Aw+FSaxc1v7NhM0adIcNR6D/ZWz1gl2jgPyjlk5MX057scMbJrkZYLmSIv
         ACuDXNXrEmCyjxqh5OEQHFdSnhy4+XOOpBSqu97JLYZLDPC2zx8s5tDeg/6Y9mpSAsSV
         3+ABniTtLUbEP72Ws04BOGKleh3FN0hvJDAzIBfAiuhNjOWy7wGnc0pgA6E46I+W4I4Y
         VZJ8FfBX7O6TcceJuA5bSwJJwq2gOT6vp7Doe00SxGKutMpWAOCaf4kEcq0Jb9E9ZM28
         psTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wLPB2Mfm1Q0AcQe8HguTctjxf/NDB8pAUyChv+UAeMg=;
        fh=mEsYQ91rwTQ7qJ/Ka2e3ONntC3LfAXQYlWHLGeXU3AQ=;
        b=gPpuNdGLCac1AnpLQRgjf891Gh/35sKZVLd62EXMMNTUP2q2t3UVD0UX9p5I2UgtcQ
         xBR1a9w3xLU/rsVvtE4G1P3KQe/czqpbz/3RL/VkMUSeilYX2thswWW+hhv9UEf/nccT
         xqeyG46vgqNz2V/TGzxzlwVALklxLX/UaFiuCZAVCrHd77Fc0QyOiNegN5K83n7Sewo3
         op6WTRT/JourDKiLNoibDHAdXuDpoKw5pQvb2e8PKOjf+wPNNOiOAoguSeFmPoFyFeCh
         grr1PJbw4iipGe3MUVXjVjkmsax3OcQeYp+RI+ht1lpgKvnl57bJPfRLbmGWLgWFMzBR
         hxzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774101256; x=1774706056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLPB2Mfm1Q0AcQe8HguTctjxf/NDB8pAUyChv+UAeMg=;
        b=NKDd52i6uoE+Z8sJga91mi+t9Dx5D7Gsy25WX2cQ2eRqCWtczp6WUgNw1oqoTE29Sz
         n37DpeDRdx64ibRimnhYtLpL/NBxR/OzHX6uBxGYkE7tQdr8j/yNHqq4HfSYuagBler6
         ubemM2YhthPi85Dz9TJhzzXEXmRwit8aRvnCleMtbi7COzdxZI03GYSUkJEVSdFpkp7M
         7N822Q5Wz2qOgohsgxbYyUUfmipAhV5gj+tCrmPaXRjviNP0ypxq1bAgQalUL5x5e7us
         vxhhdMZlP59iZ//UVPYBYh/XDXgr5gmcmTPVhXxZft6aWLy/hwoiXAt407GNTg/YqBWn
         +AVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774101256; x=1774706056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wLPB2Mfm1Q0AcQe8HguTctjxf/NDB8pAUyChv+UAeMg=;
        b=Mww7nf7Ch+z3x2dxJdIGA8hNBYZXVVKhEGKedG05nrRpVh1RHaLnTgdS+RDW4xevgh
         PX3hYReo+QUW4KXVLsfBjy26OMGi1Vq44/qRtYiS6ZsOK/6oDpZgfeeAfKJmhkTDFxbT
         UGt4VcR04u+NGZDdtDJPeKa8AkbW4g4OQovEZPSSzwvf5opv0fQO95EUuiPgYi7oLr2n
         VeXSRjBYDjAj0GrsTXz0qCjRv2QfqraQfeMmLi7g22wA+ZQVmz5IPp8vruULcTJ3vKQA
         c9Vg1DTCYqLXVQPNN7r+FhDklqq+9aDXvi33FN9266Qt6kz/qJMnQS6PIBDEavPrZtOP
         w4Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVSfl8eivpqOk6gEanN0uUJRf5gr2uPn3mKZ9X/ECDnrEhm5kQJ2FNI7KZbL5l14OmTnfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+W9tlL5kGh83BQfIgPwrjFg5cBKPOnhKYUNOpZwzbHCNy1AhN
	/2im/Da5PxRy+h72jETS1czd1RWGGTBJDWB7ljbd8mav6xJaOvSJ9e/y24nip7iIWfJHJyvYksr
	io95eA1szrbT0fzkjEWVek0g1KcQxBUKkP2pJBh2XyWTQogpP5M+Be6+UPNE6KSixtay50AAayk
	jifEm95amCIboryMM9/oadpM/WSPAp
X-Gm-Gg: ATEYQzwPwwO9MpX1vYoQrYI60i06vYFTJWeu+WOVFGZCv5ya6A+ctiZm3gJEQvzu9vg
	IBEdjSFzpQ2LVyZhoMyT/SKladKi5D8c2vEM+nhM6GOEChVkjDhCU9nCyPL+ruP56x8fsKKeNxs
	x7vhI4WbkBgRr1eSsQrPZmcVmA2NBMfs2o7yyuhVU49VJa286PGcejsih3AG3w6z5lUW5U2cplw
	WesDvn1vKEvgnXMbUtTrOmBSv+kydiwKGCQJRSoODQc/iua6ViINyDShheZxJGjHgKCNlh4OlXA
	B+zZ
X-Received: by 2002:a05:600c:a201:b0:485:39b9:9680 with SMTP id 5b1f17b1804b1-486f8b86e3dmr111458995e9.16.1774101255920;
        Sat, 21 Mar 2026 06:54:15 -0700 (PDT)
X-Received: by 2002:a05:600c:a201:b0:485:39b9:9680 with SMTP id
 5b1f17b1804b1-486f8b86e3dmr111458875e9.16.1774101255459; Sat, 21 Mar 2026
 06:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321000931.1947084-1-pbonzini@redhat.com>
In-Reply-To: <20260321000931.1947084-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 21 Mar 2026 14:54:03 +0100
X-Gm-Features: AaiRm50kozouQjnSmGr6yEHc5DPn76n2IcYhW3LdJhLH4o05k3MmSa4vZTI5FAU
Message-ID: <CABgObfZOmtF80M+P8guKkD0oODzJRvN+FxCjnx-7FRKa9p1JBQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/22] KVM: combined patchset for MBEC/GMET support
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Amit Shah <amit.shah@amd.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 1:09=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> On the AMD side [...] the page tables have to be created with U=3D0.  For=
 now I chose to have it in all levels of the page tables; I'll probably cha=
nge the code soon to clear the U bit only in leaf SPTEs, but I'm leaving it=
 this way because it makes patch 16 easier to understand (it's a fix for a =
latent bug of sorts and I'd like to include it anyway).

I added this as the last thing before sending and it's wrong - the
*role* needs to have ACC_USER_MASK cleared at all levels, which is
what patch 16 does (propagating down from the root role). The SPTEs
however only have U=3D0 in the leaf; make_nonleaf_spte() leaves the bit
set which is the right thing to do.

Paolo

