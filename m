Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD732EDD70
	for <kvm@vger.kernel.org>; Sat, 14 Mar 2026 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773492968; cv=pass; b=TEAEsU0Nl13+bMEkXPxanQUpNg+tvpmbgG0T1phMa8fJU9/azzKoemoFKH03XRa0/RfNrUG8fLZP4QmcUNKiEj9XO08OTzYgSJDnDhysLnYFFa6R6nk4aDeQDHNnOOTYtkNAQlGTrdaEOf07TiIteKs3OHoI6H+OslA6ypxlV8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773492968; c=relaxed/simple;
	bh=utv8IhKd7Fou6eyiZdLwBBuEJoYGIdUwp5lYXq8aCKQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Vx9UULe7Q6KDApIbROv+WooOOX8UxgA6WZVlr5DDQmj9yQAua21budnljzd4dE888HqE1Lq1dMlo0Qk24E/ojr/k4FLzMrxvqmZC5UOQgilVCKEBtc+k8InQ302sLGionVDUls8u9D2V0M81/DgxDfie2KeStSfXxRtGK6UwfcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvu98Jyi; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvu98Jyi"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9795ca4e6dso52179966b.2
        for <kvm@vger.kernel.org>; Sat, 14 Mar 2026 05:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773492965; cv=none;
        d=google.com; s=arc-20240605;
        b=bkA2eYyCi1QB5zaB+ewxtBN2PdeBYmfq9RvDWDbee6M16ADBsAa6M0pgbIB0LMBSsI
         W/OQ1hvnXq/+uoj/uZp1x2d5F9ULGnqk+ibaFeteJPqDXZRPbLucTS1SpWC+Jy1Xp0W2
         zTKEXUfpWekumpjJGmrzxlBluILqSLW47XL+D5U2l386oZ21mgxI3fW/E9M415mTZlxK
         qoB8Jb32ySK8K9HSP/UaunV9BqfvMqB05BDJ1ISUwZmh/94+OR/6DLBT7b70qfahdz77
         wV+lGbbA99boBI4Q0vpp+HcfoSylKJtQ1SyRZEY0eFJYsah05i5eSoGfKJ1mTWbsMlBy
         OG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:dkim-signature;
        bh=sTbukaDNilm6gs9vONnxDRDbvaqyD/G8B7CgBtcozl8=;
        fh=dZxJWlE9O0BjFKjBBWV3mj0MivD9zKLBcb2lwEGb6+4=;
        b=Ig7jdClfIA73BoPxoM7GIRCRihANEpHc6NUwv0Y3YmoeFVx0uT24E1q1G82W8VjY5x
         gPHTLPse3RyRuc/+ZqITeQ2x+6hTTQFqQSTF08bID7bFt+f8sq9/hggQmS+2cqw0Laf3
         FN7MECpmpLl3edNxpD1dKxn9XKJIXDObX6ICu+IwZmnmmZJFduNARdazcNvrqMHCYbj3
         1CQMGCcEyRe1aGAtTb8exeQ5Ho+iUlrxKQSdu/Hzn3/bZZHgAsS6EjJfDAmez0qshSds
         WqIhcdUcrrPdDaijJZ7/fIGS03TyhZjR0ef4rDM7iBKmkO+BcVI5QMWofMOCx2JCIKxP
         ZzwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773492965; x=1774097765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sTbukaDNilm6gs9vONnxDRDbvaqyD/G8B7CgBtcozl8=;
        b=gvu98Jyiez/NJ5qKIL0Q0vUy4K+7ii4y3zYy5jpG4ECODBOq8d7oIs2OJFbKkfinNG
         C7xZEj7Bo7O9IWg23bBJVbBAFGuYmSeHq11/0vR3gQRogzHFID6qzZtscyUZfCURvc/9
         2CnqH7Sc6TrYqcHabvvi+pDJ4IuRAznIZUaDZOmKqZTA1gdbsetKTYo/tfxQVZ/XGlIl
         cVsae/RPLaburDhFonoss/MOdQ9tIodk+GjzhMCXnZw0m0+bX3rBTAxqyKuPbcQbmbUF
         RIyF2jNS6mfozqjebBTlsbRJJe6i/xR84F9nBcjT4+gBMLhp/roUAf1BCC4xEhkYGy3h
         +A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773492965; x=1774097765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sTbukaDNilm6gs9vONnxDRDbvaqyD/G8B7CgBtcozl8=;
        b=DD3K6fXAh4+Mrw03Orzciztinof0hSH7/2jiP+WM2tfOUb1zcYRL9RBPLfpQ1g2mN0
         mx+wKBnNTHJUsfpUBvTYplZzQYlij+MN1Wdxv6BCLlYVQxtIGHKkAm+otic4LJTCIsAt
         okg3y3S/HAe4miNxvPqboG3OlXyT4sWV+JHB2EH7nJo2QQxNjwx9f3wqX9zpGLC8lb4A
         YKdFiirjUtdpuaSK4K4xGjmMRmHn3/i+xDM/bCRE1Ejw+ETdf2/bBEUWEOJ+0Mi0bFcm
         UYiq/N4PehlGJ9WvKp6FzhlNHMwvlLnKatVebzaVQYHf9jAWHyguPfiXIooyv3ZEtdLg
         BVlw==
X-Forwarded-Encrypted: i=1; AJvYcCVuBWdQJTaUPzSatsWUvS9KJ3rTdk1krKuHXlfUTu0g9+Hfu856b26QA/IGRq/At1+/AFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyniTYZgtC8IY/MtOA6hitP2aHEM4M67xmbI3Xxv6pfOd6kqXZI
	+a1OdzkVCeImZia0GvP9uo6jo6KZCsj59NLpZlmu4guavefhpeuTafee6+ZQzaP9aIIThjP1j17
	2zrj1kVvjDbPtWlXl4PYq33KmZLF6ulY=
X-Gm-Gg: ATEYQzzmQ0UaFa6bsnXuAIePT4hK8wuSInEzS9XrEQSsEjgRYQi+WrZEg+6SiE/wFmo
	g3eCcZgab8eAW97Fy66CwYV2/VIWWy3KYMAJSSXC12UqfH8xvyYPJXXppPA9iKoHrjtrR0enpPP
	UdZDo4dDvukR4Y+6cUBFNLdj3htsz0ry69lPaRKkzzWJa60aKpDonSawsFk4xB/20DJbz0RfMe3
	W3z4FuOK8b7rb6eC2iHGLLYIxdzFPhNe/1pC9i+TkWyCHg9s7xgdvQ1TAg3CxTtuNFlFGLk16H1
	Nz0/2J0qADhdsgUiIOS1RkH2SWlBWLuWOZYfWtXV
X-Received: by 2002:a17:907:e2d2:b0:b94:c55:81d2 with SMTP id
 a640c23a62f3a-b9764f4bdf8mr352343266b.1.1773492965182; Sat, 14 Mar 2026
 05:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Sat, 14 Mar 2026 05:55:54 -0700
X-Gm-Features: AaiRm5285X-cxB4czVf5eF4LxVnJQjobQcIV7NNd2_9cNHkuQ86Dx1n2u3-7Rts
Message-ID: <CAKSQd8VQfopKppypoUVhOYNPyvGhR=664aEKcJ7Vu00NNaoHug@mail.gmail.com>
Subject: Re: Re: [PATCH 1/7] KVM: SVM: Initialize FRED VMCB fields
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, xin@zytor.com, 
	nikunj.dadhania@amd.com, santosh.shukla@amd.com, 
	Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>> Is this architecturally correct?  I.e. are all the FRED MSRs zeroed on I=
NIT?
> Yes that's right, the FRED MSRs are zeroed on init.

Ahem... citation required, please.  :)

Because the FRED spec certainly claims otherwise:

  "The RESET state of each of the new MSRs is zero.
  INIT does not change the value of the FRED MSRs."

See SDM vol3 #325384-090 @ end of section 8.2.3.

Getting initialized by INIT tends to be outlier behavior
when it comes to MSRs =E2=80=93 MPX, CET, EFER, FS/GS/
kGS... but afaik the rest all remain unchanged.

And yes... this will need clarification from Intel... given
that CET_PL0_SSP =3D FRED_SSP0_SL0... and it can
not be both, unchanged and set-to-zero...  8-)

--
C.
