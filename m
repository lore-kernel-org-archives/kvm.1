Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A50326A1AC
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781546881; cv=pass; b=rvVwU9/l1wXNy+O2/Z5ozNhbxybgl5vWEPCEZi94QYV3IsCuiEOfSxvuOoq7A0RHS69ngZ4iINx2SKDrX+eaagSe3Ptg80mUsFpXufm+O/fcOwJ7Il16qby4SRmNpqN89oHcRuFiOch+CAEpbscpWlby6h5QLVVbL1xFSPpGBlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781546881; c=relaxed/simple;
	bh=DlnCk256T3pqD6JOxuV7yZ6rNjvVbspDC988eQBiaRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMsO9TMKODjxxSodtiTrPzQQZ9/zNvfn/jYP2ppdPEoc5gAL8XTrw8aaBoaiW0Jp+2VKiYj4ZZfqHsrpb6gFO2RysezPr7kJ1hdxnC5NAVEFKc71e+12akwrGKYtz8p+ULwSn1bxj9wMEID28xOxSelzl7xZYlDeAC3VT+wmjFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SWMaXsuS; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SWMaXsuS"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51765331535so37551cf.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 11:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781546879; cv=none;
        d=google.com; s=arc-20240605;
        b=GI9qTT49/BX2XWG6OHPCSBTLuYOafwXWA59QDeKJhNEzQmwqpWI9klUyhrzE4/NCGA
         XN3i3VeeVJRh7ASqKQXCzyJdbaROeVj4/WA0jOcLcSYOasJXQFLszQn2DxMDEFBPGJpE
         24a/1K1CnA6jsf/yVs/2SSQ/m2Nv9zgZx4ydAc3cu2fSA1hlzqdsc5Nfdldm+vCkiR2r
         Gqzxjvcnm4cJ0WD3p8Wci3qCxqD2Y01+Xulh8KwPXE/3gkRL91BAINORHanG9qHE7ioG
         yr8lb6lNBT4Z1K3gjUx/dBJSNu1lkFFJWZoPjVLR4PBBifS2488N924CSDdVpgkfHB0s
         edSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DlnCk256T3pqD6JOxuV7yZ6rNjvVbspDC988eQBiaRQ=;
        fh=oktYpAQxcYgQRWBopYAPtYbZxh3p0hIhQ/vJqtLBQHU=;
        b=dDN8FMC/lzQLxm8imkzKfvztP//ZwI+DxKbua+8+oX3f+2nwurNdjEKQZ0wmsnl0j5
         SFoZ/7TpQyVxtJT9fQ7N3k12fNNRxApnY7qLkcje71su3cfQImkPdup23ZPAqV105BGC
         UBtAKlj16DW5O5pHC2hW59tuuXrJpghB8ubmQHG/1u9bDIhvsrV/mF7Vpzk5wVO9mZY0
         wqj7t5eGCUgvRnaHKE0aHJGZhuBhPGcc0kR4q3df+dz2DtjoDoGg8S9EwuSqI2uQ8lk8
         sk87tSYudsG1xgvxZy1nNhhlpqbd6DhM+9VEnxYDQUk8I3VRmxjBplNSHa6w3OFo36eb
         VlVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781546879; x=1782151679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlnCk256T3pqD6JOxuV7yZ6rNjvVbspDC988eQBiaRQ=;
        b=SWMaXsuS/Uxd5xZF93U3culAd8SYBC56yCRWspc2K/0T7wS0MA50uxKSV3Nj1Vh/Ha
         JUI1OfNJEkGnSPyuEZfbh6Jh0f5HHrZfJlNrX/C8UyQj2nP0I5q3lmtTsmKlpPsVZGA+
         gWiyWQvypThX7zhnkLciuEI9sbthocezXejNUMvb5plAZVkNW3pJPl3/0DfRhHoN0uTf
         oPRTuqE0jlaEYaVnWRNbqv5bdnHlW0GFCpJrxHYQFrzqFOndHE3r/47syTlzBIMjWakV
         qykY0qPaDUaggkkmjNDEUYvWBwRCHuAOEaaKxjQT1v1jLWmlmhgZO0kVXYaV6los4Ccw
         0f7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781546879; x=1782151679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DlnCk256T3pqD6JOxuV7yZ6rNjvVbspDC988eQBiaRQ=;
        b=dFxoSztZlFKNqlReLWIKm/88jwKzqxAt4DZLrJPaHSEvHYJTxqkK/NWhO4xNUCxy1R
         UQj/MZwBHUVXDd2swi1Yd2gee/v6N9LroJIS8uFHM8G3/ojcEKbBGCERHr+6jcgS391K
         +GkXVspGqgyE1q3Z5GoQGfMFevL++jXsrKqv/8jLdtH0PXBIAlpFRORUVmv5mnfeRFEC
         PLanBK5n6A0lmGWB0RYeO0sIYDKvjlVoAD9evB7zRii6yATTa/uuAkq6Doud+bgW25Yy
         BCJCg1zYeAOiQN4A00kO5ziybl97WcTSokC9sJicb8GpxnRXKSEtcikEj8qS4dqljJRe
         sVFg==
X-Forwarded-Encrypted: i=1; AFNElJ+ZPuPm+BRPk1okrkY0bC4TcBYkZ6Xhrf1J32KxJ1Sl2lVRulP6XWUgxRByuTDG1HxzwNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQ7qw4GyENvNLn3bVV3dwqIZ9/NLKO+5UfT6eRdR+d8CFt8dv
	b3r7QNJKa21+lO/CcBIDZ3BbUJ/W2M15dvZtoX5qIOvtnTpNQfd4NnYKg46bROlOuYyR0BZ6efQ
	bVlIIwvT9RIo2VfrAaTJcSCpkKikwVGpd1wb1D4Yk
X-Gm-Gg: Acq92OEpjiMfbKFTEOqirURvo50zdex5HAipseyM9PbrDLXXwrlN9puM80Bmomyfq1g
	mZv281QnBvsFo21TIKUnZEJU+5X0jN2BolczUoHsZuuonlFMIhsKW+51zxFN5frG3Nh3JAMC9Wc
	fkDJsxJ59Uhq3PSWZyEmCLvuTXcvp9ZYLAiGTI5UYShws7bnbUEPEsY7Qj3Q+1Lp/304ekC4Yp/
	kSnVw5sT5Zg5HUZgDSkegVl1sHPzoGxjE7nLM3hmm0+u2jilTxBREcECBIuvwuRjEy2hH+mto+x
	jTA1fXk=
X-Received: by 2002:a05:622a:2589:b0:517:6010:7c71 with SMTP id
 d75a77b69052e-5198fe8ce06mr767891cf.4.1781546878798; Mon, 15 Jun 2026
 11:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com> <20260612230113.684301-5-seanjc@google.com>
In-Reply-To: <20260612230113.684301-5-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 15 Jun 2026 11:07:44 -0700
X-Gm-Features: AVVi8CfdOCYOC_E6aY3TINSWnyqZVxgHqoD6nImLX4zHKhNhcYzD09Li17bwpcM
Message-ID: <CALMp9eR4EnZW1TYDDhMgkLVD+kdaPyM6HY3wy4az5YQedddnaQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] KVM: x86: Prioritize #UD on MOV DR over #GP due to
 non-zero CPL
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, 
	"Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 4:02=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Manually handle the CPL check for MOV DR instructions instead of using th=
e
> Priv flag, *after* checking for #UD scenarios, as #GP due to CPL>0 has
> lower priority than all #UDs.
>
> Fixes: 1e470be5a108 ("KVM: x86 emulator: fix mov dr to inject #UD when ne=
eded.")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
Reviewed-by: Jim Mattson <jmattson@google.com>
