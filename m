Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFBA36EA93
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596598; cv=pass; b=XVFZ+Hn7eL8eKXKlBIyk+g6WB1/kcJ22jF4guwIMQRC4rFygGlfB3+ibjWes3NI+Pdod2GZemph3Bgkgsm9fJfWpV0Zb9YOuqLhH3qkiAnIgZZHnmFF+XLNw6rNLPbJxHlZrAzQZxAyP7MtpOTKIyTgoy+Jol/05MlA3s+8LJu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596598; c=relaxed/simple;
	bh=HVHaPjzedSH+A7UKsiQfgfXYyVhy763aHowGLa5asuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMSshj5zGoXEOGSDLkxhDk0E+fwVfWKuRk7I+AAXfyJM0jjn9rmnyMxrif2JdVS668LL9OjopbkaKgf0vStkt1gaC0hLmiJ86KhHvso0kzUymny2g6LAm9JtPJOAblYZ6/nDNXl2uOyNtaRrDrTVIqbVYlfboB9iqBoydDMpJpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rh3ODkMU; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rh3ODkMU"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so3381575a12.1
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 00:29:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774596585; cv=none;
        d=google.com; s=arc-20240605;
        b=EeEtXXBMd352eVY5f1skfmtTcxBAO39W/228J3aThz/4Jf7Vdun3qaEtpwu8QflWVE
         gpXE5P/M0ap5AQBbPgdpzwxgaJZOfQChiXwbBWxOwbSe5/WYjl9aiRMOuXs6m+Y+zMBB
         QJsrCW58146E3ARm9a9ar2CbSBY+lVKhRTljva9UUxZqPqjE3zUGRSMObBAZyk7d8E8t
         wVPPqGhqoQrB2Ngd/Wk/0vsYqmFYP4VFBOE0wNFFPSZzP0QTnoQlssFxEML7qDY0avW1
         xkxvYeUPsrMOMYXu7sCUM9m5bOo1+339IhWnYRJeURW7A14hjhruXq62MeKWFKn0B+b2
         9W6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=pDYjlHi/DMuI060zzKusoG/XnJTOuQ8NiP//dO3aFhA=;
        fh=hmGhDjtFTZG2TMIp2X9yQXu+mg13flO5Gy6DMSvs+LE=;
        b=bYdWdEm3JqXWY/Qv2SL5ZZuJ7JG9EsVD1X/bS8Zh6Ihmt6rGM55+zaaAvyz6Urifn9
         shxThSSVXrKDe3FMQW+sMeucIlB4jqKpK9lFcH6cDZCNQ2Qe/hzKbAw9mdcdJPzruDNL
         Rw33MV9MUciFPWF5lPdmGEuAzvIDVyagZ0dR5jYX3hbnr6wS7WKQ2p+nBaXccRQb/7jB
         w/pMt3IC00/Oy5BvEn5uyqfP5XT1ZLpTqyAuqrGe3EASaGb3JtFsN8J4H9DpHwJwwYgw
         SaMwv8Vp7GhzPLRlm0CvsFSI324zSKfAZ7DjJTskBkIePKVH6z1C0LfWF2JjwjSTQ+/o
         XUsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774596585; x=1775201385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pDYjlHi/DMuI060zzKusoG/XnJTOuQ8NiP//dO3aFhA=;
        b=rh3ODkMUi1utUDwMpKZG7VkhcaYdAwJMNkQn2tnDYZASE9db65ZkzzbPF3/OwLAQ9N
         nye+42Oyk9PJz/4U0K74lOMJqMXm9OvZxYemCJ0LNsM/uvYkHVeQ5YVM+3EK0C9P+DqI
         aSYqy18Q2QP/6m/MvWKqtA5jZhSdN58gnra/4n0uPUwU+kHsbiWJMD2GUqNQz7AjbnO1
         1gUsmAjkxEBLHwtGD0Emy44AA4Ai7oLXlwoK313arHhC/4SG4jia90KLj3Z4hX4ZdQai
         V6LuxcNkTBXZqtz7GrjEZeJOrW1mtGX+BMUMee27EgfMTMUCPqeeqB1yE3m57vtkM31X
         UPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774596585; x=1775201385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDYjlHi/DMuI060zzKusoG/XnJTOuQ8NiP//dO3aFhA=;
        b=Gq90swHZsd01AMG0X2W01ZVdqCBhPpjTGGC9GbMQXpubM9UpxR8NkEO4n4EnCFeVUx
         gSAmQcpxqk+pV6qmo5yr06DCffjoJE897lgFOB116XK43cFRnXd8iJUuAFjbyFOk1mip
         S0lJNsvE8lSeLmp0VQoETeANQiPMu8n481deTlgvBChWDIwCTmh0ERZTD8xPBdj0DtNH
         lPms5gRa24rpFMWqU3QER64HRfeXbCCQhjgd7qtEFz0VD6jJU5HNOTEjhak65gqCr+Uj
         3WvrtHWJyWDXRVE1rh8+1jKoFUBKu6hhi3NHbgs4DflvWEjZHXwqFfMRAFDEd52kuSXE
         ry8A==
X-Forwarded-Encrypted: i=1; AJvYcCUk6i4WyNbRAuiKwvD8krXTejlTxb8i7csuT156izVDJVpEsQGXgiFDMbSsZUC9vek0BG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzrCe0qAzwsuHafYY5Q4bi6X9xKCY3QnDSvioc6sDEtVQh0pXJ
	WdxIVeY4gk0OB6D0nAyuWV2qCECmPeBGDkVtaJPEJWy9CxqRrL+hooidmQhiEA0apzj2xoFVU9l
	JxlSc9ANHjlQEdIBcX/AHh+sGPYqUMbA=
X-Gm-Gg: ATEYQzzX/SBbzxoU+Wro/WHfjQs9U6frsFvpNgBtXvfsw2PqT2f8lfPrNkFu/OrEs2I
	D7jHJdSseYJGD34aRudqmdJRQSqZnJNbIF52mhTj77/vmBJ4OuZE5la+AjdXgzQmTwugpwkfULv
	x9NsplsD//y0HbUcnCCh+P0c/XxebXWy2a2tsKhb8UMqXs5II20ovPiASzXqeZ+XtjralzbLmcK
	TPU4sLPwY5eMleDfsAk2ZYqhy7ced+zDnJ2Gb7PAlDVhe62bcd5uBcpp8li84Wyt7Z8PBl+kFyZ
	BpPIgFbtG9vwV5J0putoZ15gJVyeCjp20Gb6
X-Received: by 2002:a17:907:7a89:b0:b9b:1e97:f25d with SMTP id
 a640c23a62f3a-b9b5090d893mr92623866b.40.1774596584590; Fri, 27 Mar 2026
 00:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKSQd8VQfopKppypoUVhOYNPyvGhR=664aEKcJ7Vu00NNaoHug@mail.gmail.com>
 <334b098e-5ceb-4a50-a31d-882b64582679@amd.com>
In-Reply-To: <334b098e-5ceb-4a50-a31d-882b64582679@amd.com>
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Fri, 27 Mar 2026 08:29:33 +0100
X-Gm-Features: AQROBzBnzuraj_qn06L1EPtEGc9xim0kkxmovMA7W7xYoL3GCl6GO60Nc18qywA
Message-ID: <CAKSQd8UUnXRZMi3-9jA5RFH=97A_O4mK9Sw-qPusEENQMbM3Dw@mail.gmail.com>
Subject: Re: [PATCH 1/7] KVM: SVM: Initialize FRED VMCB fields
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, xin@zytor.com, 
	nikunj.dadhania@amd.com, santosh.shukla@amd.com, 
	Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 7:47=E2=80=AFAM Shivansh Dhiman <shivansh.dhiman@am=
d.com> wrote:
> On 14-03-2026 18:25, Christian Ludloff wrote:
> >>> Is this architecturally correct?  I.e. are all the FRED MSRs zeroed o=
n INIT?
> >> Yes that's right, the FRED MSRs are zeroed on init.
> >
> > Ahem... citation required, please.  :)
> >
> > Because the FRED spec certainly claims otherwise:
> >
> >   "The RESET state of each of the new MSRs is zero.
> >   INIT does not change the value of the FRED MSRs."
> >
> > See SDM vol3 #325384-090 @ end of section 8.2.3.
> >
> > Getting initialized by INIT tends to be outlier behavior
> > when it comes to MSRs =E2=80=93 MPX, CET, EFER, FS/GS/
> > kGS... but afaik the rest all remain unchanged.
>
> Thanks for pointing this out. After consulting with the hardware folks, i=
t
> turns out the FRED MSRs are left unchanged on INIT. I had mistakenly mixe=
d
> up the INIT and RESET behavior. Apologies for the confusion.

Thanks.

> I'll update the patch to only zero the FRED MSRs on RESET. Will address t=
his
> in v2.

Thanks.

> > And yes... this will need clarification from Intel... given
> > that CET_PL0_SSP =3D FRED_SSP0_SL0... and it can
> > not be both, unchanged and set-to-zero...  8-)

Intel folks =E2=80=93 can you please state the CET INIT behavior,
for SSP as well as the 4+1+2=3D7 MSRs, at long last? The
answer I was given years ago was "like RESET", but for
at least PL0_SSP that doesn't match SSP0_SL0.

--
C.
