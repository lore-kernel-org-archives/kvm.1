Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F1377003
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700236; cv=pass; b=Y7ARo2XaG4HmJqJqfF53uePssiTHvPYfL8IDFZLnRjNjxfotu+TSs5SHos2xm4F/FigcRyRxUhPjE/Fe8mMMUCB3hta8ZBrWP3RR5uWx55mLLR3QAR8OC0KgZDg4+eEh61Bn+0S5HM272g5on9pPmJZ2gUNvrFqG1J2FOc1ROa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700236; c=relaxed/simple;
	bh=zOX//qQWt0hksu4DcPXbpgchK0aDuV0IDH++kKVCMlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIF7P39aSI3WxTQFslT2d05hbIWRZUIwEwENg0pSySfvwBlGPv+EdPGxbcZgQ799DxCexrEQsnKQ7ZHEfkmdyNbInJTUSKpXCLggNbegE73c0Nkl9c5hFd/KpiRSeHxtT+MxJY17dhxRBjO7UlDwGyk6xfGLdXToozDYs7Hltnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WMfuqqTD; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WMfuqqTD"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a1307438ddso5068502e87.1
        for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 15:30:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773700233; cv=none;
        d=google.com; s=arc-20240605;
        b=OP51XpSxjOMUE3qo9RxfTwwO3UMBefp+lKXUXJNsCcEPCMSPGekbCUp0TvcCl7DOxS
         PjFHu874GoRb1/nBN/fhuq673oNVPZawbOF25Xk/GpPClJ8y96pKoznWQGxO81EzVkCI
         LaafQAV1f9XODul7mXFe2IUPk4zHg9PKYEROCyElnJRIq2eRbTWUewuMP97uzZ2lIKEy
         9JJWbwnV9eU3XFFyGPrhar9zqrjEVFvOfBLHEjVYZXWTzQwjhRN2OP+NX1RxiqQF3ZZr
         IGBXeEpeux91Yt1bOBzVjZ7g7paR/J/WWK8TxsJMWCUPsaR00xfAhBn975eqQ2yVb14G
         sk6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NHBApg3dIEw9R1t5Yh73owWQt2Uh584izEOKgKc7ZzQ=;
        fh=t5xrcSplfoQsNb2W6WrxziBfOqc9YNiMbHYFxC6GL6k=;
        b=ajTsKM3EAUTHeETvZ9oglZzm8xwP4BkShjUJSjVF0a1CGmBhELpdv5JRgqyXPesnzj
         7Hkz9udJfiV2RzhZyIChqH2ICZsuiYhAoGApvXuGzMxstvb2gph2d+miZFWM8XGVxWrt
         1O5z9Cb91diD/ljsnJGkHdE9/THVoPT5N8o4Uiuht5xCTpamcpy6l+CCAMxb+huI54+8
         Onkd/Ii6sAqQOU/Nvc2Z7JJnRJgdW7n1LYqncy/4oN67XkjU6+bgnRHMY2KQ1DZPV/W9
         CwplvgdCTrQxUh9gUM2sD+tnhL2CytHJ8Tb/sY8Ug0SgDI+ZVEJMUB4lEoQdI15bUZDR
         VHlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773700233; x=1774305033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHBApg3dIEw9R1t5Yh73owWQt2Uh584izEOKgKc7ZzQ=;
        b=WMfuqqTDLL/yLcZuYeXDe8rqLTF/n9QO0SN2cRWtdKn9roMyUx7mQpwKKOc9BmqOHE
         e33hGIYh9KYRbFpNjVgL4CF+bc885lSaNLcl9upTY1th6/ksa7bnko8bH4pG950uz26j
         2OfQhJwp6wLMP5dAthhyvJ3qlGuPGWn32xMGKkCOoiSdu2oNA3D8V+Ovrv/zUy42by2l
         2CYutEqxXE1VSYu10FEapN12CRPttYgbLzDB5p3w1X2obKZlV9j4C9iBD7dHQF4cqrqP
         gsJRgsEAPxld9ck8Ex8TQmuSUkyKoIXncGGKTTir2EYv7eEeh68o/hX60wWFcCwk9Tuw
         vtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773700233; x=1774305033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NHBApg3dIEw9R1t5Yh73owWQt2Uh584izEOKgKc7ZzQ=;
        b=F3QCem0rCAthCqIdGkY/YEJTREeVKPmS/E48kUDbe+KxkuBlwUrja71jjBkK0jtcgL
         v2k+EDjJwxDma2zz/J8uSevnlDkJGV2hfO9sIWpmz+dhyoX3gWzaOYASvuB4fA4Z7H0O
         nnYcsxRiTrlrrWTvbuDBCFhEdF27q4BSl6D4dZ9B9AtBUM+CFGUvQafNXyVgj4vZNHCl
         290wUzF+cpl4S0bFA3aPcYT5mV7/pA8Nc64BX/pazv32DR21HY5xuiof8byQ9DoKS6gU
         Q9Fp/IMSoini6lKa9lz541a07vq6BurR9EPlJdHfmS3ZojRiwwoR08RxhLbWX9Kb8S/X
         OnCg==
X-Forwarded-Encrypted: i=1; AJvYcCUYfA2eGyJQoJxcIGEqvKL9A2HgwMfv0n+wvGn24DWL7mzfY0Cf7jjcusohUaOHVJgarG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH/133ni25QVAth1N6MSU/mqeMm57JATY28NuI/UQ7xiBvk0jp
	ztKFDwoQbpLP4x6WiVBwLJ1e/QAVaEQGBU2xBTqrDnVFUCjkOl4irrMatM5YkYsNg3FmOkj9QoJ
	FLfbqYYO3IW3YQutMZ982weOpiL5b409Rcn7/U5BE
X-Gm-Gg: ATEYQzwB28oMZG8hCS/5f/TtWo2h1a9wWVsyQ2B7ah5r+3uu8QwSg0sweLpENT2C7jD
	7hGeewtlevc/zm7Ek959JIZyjKmmB/FTEK4rF61Qe9TccVcAEeIS4mKEHNDpTOLW1uDi2AdjZzY
	Kbe5pfojq/m2iqYrkvJqrLenOWsBTrF2zuTkP8Vj7L+yFGC6oEgZqrDb6MmlqRabmaR124+Nyp1
	PIVkpp8cBvU2IpjxK4KlLw1UIv30Hx1h91otsFUw+OpnucrAh/A+fhwvQUcyIFlAJOTM4/quN0y
	9mRvYohtjlutrvsc8vQ=
X-Received: by 2002:a05:6512:38a4:b0:5a1:2a64:202a with SMTP id
 2adb3069b0e04-5a162706bf5mr4418611e87.18.1773700231818; Mon, 16 Mar 2026
 15:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-12-dmatlack@google.com>
 <20260316215056.GC1846904.vipinsh@google.com>
In-Reply-To: <20260316215056.GC1846904.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 15:30:04 -0700
X-Gm-Features: AaiRm51TsPFqmaxXeg5vtHycDWCNAMtrDhfsa1Ts3dgQ-gFDNbzitmE0jWYnMy4
Message-ID: <CALzav=eKbTiJYz4mCWTmVghnwFLHZOY096Pf=1GYpO_UBixozA@mail.gmail.com>
Subject: Re: [PATCH v2 11/22] docs: liveupdate: Document VFIO device file preservation
To: Vipin Sharma <vipinsh@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 2:55=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Thu, Jan 29, 2026 at 09:24:58PM +0000, David Matlack wrote:
> > Add documentation for preserving VFIO device files across a Live Update=
,
> > as well as some generic file preservation documentation. This
> > documentation will be extended in the future as new types of files are
> > supported and new dependency/ordering requirements are added.
> >
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  Documentation/userspace-api/liveupdate.rst | 144 +++++++++++++++++++++
> >  1 file changed, 144 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation=
/userspace-api/liveupdate.rst
> > index 41c0473e4f16..dbf1e4aeddd7 100644
> > --- a/Documentation/userspace-api/liveupdate.rst
> > +++ b/Documentation/userspace-api/liveupdate.rst
> > @@ -14,6 +14,150 @@ ioctl uAPI
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  .. kernel-doc:: include/uapi/linux/liveupdate.h
> >
> > +File Preservation
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Should we use the existing way where documentation is written in code
> files and referenced here? Maybe luo_file.c for this?

Good idea. I will look into that. It would be nice to also have this
documentation in the code.
