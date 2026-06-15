Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B8119F11B
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781546688; cv=pass; b=Q+xWeQq/Ixivj3xEiy7AsFno6egt+0lQGeHPD/mgA7XW/Il/Vx5/yf/T1JaHpiUa6sHlY6gnkgCE/ZBvPcUZTCvsJUwAUrDQW0d890ORexczJeVFDMYxeQeDlGtWjrSZXeWx+Pp4RDLWyF7tOLmm4nOl0P2URixsVDq5DYiotH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781546688; c=relaxed/simple;
	bh=yWO46Jnak0UoHcKw8uhxtPIa9iMt4zx9wKhXJMnPQuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOkgHsuNlwh2DPSImhkWWaRO+G5k2YPLKBUbEu8+0mwYvqRpDfy4Sk1J/Szy3+fVy0E6W81MIsM0/c9QX7+55xinym8swXTDoYrHcWaFti8Yr16/xz6te+xmtYy6AH1MXJqJbXcCLqVMNXRewHdRVGsi72p/rut3M6yAd/mdnxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CacZFY7W; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CacZFY7W"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5177d1ff061so32641cf.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 11:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781546686; cv=none;
        d=google.com; s=arc-20240605;
        b=A2nicAqmOTt2CpfKbjKfOp9fM+cWAlWntJUCaDe/Br2qQ9d9kpnte8jjLpbB6Hl48d
         kGvxPJiX5YGrWNnZGuoPL+jRKJFeC1V/ObEljCUGuJGR+nGDRxHFxcPOxYnjOkcGO1XO
         6Jixzi2XVy2A3+Fz99oPcoXQI+1g4MGjWAbqesE5506JiNFKlofOO3QJHCp4GM5nvZp2
         7I/dYhLdFnQ3aOb7HVo1UPSwicc9j6ElP2He04zPrEvMAFDeAutqvcQbSzzR5E3IWT83
         1H4ECNfwIW8uyxvovBgepJaavXo861pL3VR9n39i4AarEjqdYzefH+4MqE6uuKWlOkqs
         hdUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yWO46Jnak0UoHcKw8uhxtPIa9iMt4zx9wKhXJMnPQuY=;
        fh=PaNWQSyDqfETqxFI6zR4VgoQMSr9sJ3OYTaZGWegZhI=;
        b=HE57b8JCJ1gsAi4Nq0FwUf5npOvjlXvDCpuPhrsRXlSZT6b44qe+WteawDWMyGvDky
         eNYrf2Yygve6paD5l6f2Tnt8BFrTRzAcWs8KN2G1+LNdAOIdRsDSdbTwUnNyxxuCNJtx
         AcQ6FTTzznOKrDGOSX6+mC3R5AK3z0t6AVXEA2ZABcV0hudc0/KQAhVbKzmginS2EWSw
         SrQ8oDmemw15/wl3AoX34sGMCL1I5qVvk41iiVueTRGI1HRKzt1MfnwEuHOIWdr3fKVa
         tw0SQ4v9GcCK9ul/83ML7bEmUKom1U85UbRnl/jPGfoWHdUK927f3beTIMW0YDP1Oz47
         7Q0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781546686; x=1782151486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWO46Jnak0UoHcKw8uhxtPIa9iMt4zx9wKhXJMnPQuY=;
        b=CacZFY7WmvAS8/5O/5NF2ZS+GPg7bA8cgws2x4wzFx5uEY2qqiw1N6+7OJg8cLf6X6
         sTWfZNHYMpNwxbCdd1podPoA0t1SYslsgQPv9lQRDHsNLXkyZ+2FburegjrTn4gGEi8j
         MvJMr9ocsJMRU41dZp3jTXiFmWpTBZQLgNXbMdtw6b+Yzaf0EkQGfTSDLARXDF9SFNv8
         9CZpUzwHZlcYUcLfPYPSk/akfQPJ2e40E3c5JEasW52YMxzVFSg9HPsfi0mYsOKMNYB8
         S/6US8Oe+0XAZmy6T5clFT6lm7FDCI0KKgw0Md6tFC/ntwZiqUe0Izp/0SzrhbpKpShK
         lWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781546686; x=1782151486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yWO46Jnak0UoHcKw8uhxtPIa9iMt4zx9wKhXJMnPQuY=;
        b=JB/CmjGadkTP2OVaObPCtDjzjQRDPkRrPo7D2lDaT1g0PrnvVM5R5p5WlxJTjV0Xc1
         3/8hg3p1wNm6bhlZFVqF3SPoPEsDMy5G7bojToo2RODLf31W141IC/uAX4ezdt/e8KKl
         bkp+0KSB3iw4cdi5SvAlm9N7o0yNr1e2jfEfwyuuTDoAtDW9Oeia0yFLmxhJ/y+ozj46
         leNUkXY2h0bQNbVQqHTGu3apKBEyp6Fo/TC25S5nuNAmEJ/LdASHuVi6uSoAVuIylKR7
         KVnUhmhXtA2KI6tzPFfz+71QQDLKj1lahCDOgpWGRpcSKboq91vRb3ietYlmNUHEtP2h
         uxxg==
X-Forwarded-Encrypted: i=1; AFNElJ+Rb5kl84U3L5McR+C/PrjcHGkiHZecvfQ2jin4WNHwRboNDWBwjjiRC27eRhnAyVTb7dY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6WC1CDqpyx9MfwzeOrxvUl8SG6yHsBltSXVo5ubuYePczV6tG
	FQGbJAoi0Pyfx81pHR2FW/olzJNBWtHXLTnI4dZzPCe43ZJH80CJM3p/pqSa7MMzQzNmiCIV48Y
	PoqCHQtyZ9G10zSwPaDwPNH7tcIBcKj7iu6kQ39wq
X-Gm-Gg: Acq92OGCe0gtcbv2nHfyFbP1crWm/ykU623KpnujvGFWoVv1JGOnCXVuWgmkZH2Mn6n
	AB0wgL8y6+GCufb86uUi2tx3lKc+bA3NezuoMJNK1ZH6pJbD1lgEVOBkZi2SBKkZbeQ6P2zyEuZ
	27cB3W69g77NLtApVEMyCPE2qc8GL6LISu5g8kkhwdBGgpucEnnGNS5WwkYJUGxxLetK3+tF4NK
	fzgof4sbuHWPXpi2a/xu1R5cn6NXXDQhybayyyB4Fn7A+5aNYqiYDt0oU2qMZc5UdGu0D8gg3Un
	XEfFGvg=
X-Received: by 2002:a05:622a:248f:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-51990508158mr456321cf.3.1781546685387; Mon, 15 Jun 2026
 11:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com> <20260612230113.684301-4-seanjc@google.com>
In-Reply-To: <20260612230113.684301-4-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 15 Jun 2026 11:04:27 -0700
X-Gm-Features: AVVi8CfrBwBTb1esmNKgov5luvxpT8CP9_uIUecYHNcKu1mYxhW5-0-P5yNb3v4
Message-ID: <CALMp9eSnB1n5pfUCrRs5Ye5GqT+T+X8mhR7qs0Uhc0Jq0+Pu-Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] KVM: x86: Manually check DR4/5 write values to fix
 SVM intercept priority
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, 
	"Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 4:02=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Manually (pre)check the values being written to DR4/5, i.e. the DR6/DR7
> aliases, instead of relying on ->set_dr() =3D> kvm_set_dr() to signal a #=
GP.
> SVM unfortunately prioritizes all exceptions over an instruction intercep=
t,
> i.e. nSVM is relying on the emulator to perform *all* exception checks
> prior to attempting to execute the instruction.
>
> Fixes: 3b88e41a4134 ("KVM: SVM: Add intercept check for accessing dr regi=
sters")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
Reviewed-by: Jim Mattson <jmattson@google.com>
