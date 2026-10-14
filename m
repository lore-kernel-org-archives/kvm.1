Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0935B4E36D2
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982481; cv=pass; b=kI9hurdCn/s6OtUDJjZSvM5cHsy02NT/SPSEYCr7Aoucko/dv3uv1h5SFiv8YcljOspBvrVPl9/0epR7JmcuSS2Yfy9+WdkqS7QUj04CvtwmhzHCSvuA+MZ2jkwn0WSC8VhwnZp17GEvrqrpzlpBFzuPerMgZCtd2OiL1+C3afk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982481; c=relaxed/simple;
	bh=KYS/c54vQeVbWBTD+IBBHhIs4+bHOZYRw7A3ClKDlRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2mvWLCWlAzd807wvcUNnVmJNiV2ihk0HiMYlKjJThANa+HLcyCTfEbzevw1zPMyePn2i2YQ8L8w9LMmBn6U7KbO8Flhhf4Z8BGMN48n0UwH13sgVzTD28y/KOIWvE0RYk7X7IVYCVGvFVC0mDAILqDJTrVe23t/6WTHIgHI35w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GhGkwpJT; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GhGkwpJT"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso38187a12.0
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 05:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791982470; cv=none;
        d=google.com; s=arc-20260327;
        b=Q2OqA7fMVRCTkMEnrk80MOyBum/YomNNu7GExVy4rPPHsPgqVpFn9P3XfmOOYLr8ua
         zKr5jvySJoOhiY2WKLQz1LIvvTjL+IawJ5BIKj0HPVN2ulNZgQXbyJgULD8+RRDhTAlx
         S+MdG16GB0Glg1GzyIlipc002hL0DJ44A8Jv29UExzYMg/Ow8Cx1m8mH+tBHHMap5MkW
         G0h90UoICVjAZUiUV8iiRR+28Y6JOplVOx5VHiUs2i/nxMsTXLnt6V3oiMv6DjtJ1tv/
         ZMYsYlQu/mL0d1MhphlQWXSYDncu8WOrW/Srqkuuh6kVfUfEvBBpqV5ShSHTzac3iMx/
         781Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KYS/c54vQeVbWBTD+IBBHhIs4+bHOZYRw7A3ClKDlRY=;
        fh=U1ZKYwUFmHur6+ssgsdq5bDtjGOTFDlxfEDPqYm116w=;
        b=SYyWKxIogWKw98IkYc28IQsuqQdxKbgOGvIdhOBpwx8ccH0y5Ho89p2MnCTBvYzKT5
         h/tMBdM0raSjNvFI2pRWo+zvWUdSjCL+LHfnYjn4+Pdti2yl6NptMIoF8zPZTvOFZFPm
         IPyTCPh8/p1tN7BZxUJZmMj9ZsFsYiiPFiR2atBzGx8O7CqeF2k7wf525snlqDj9VoCy
         gXA2d98V8PvX7NL6pvuC5Zv4I8iXUWpq+FaGsdVjUIQucV2fZ22N1l6yimCC/qoi0RV7
         Cjr+tgMAJbmIeAD0xIeZInp76aKBQUAZ9VBgv0fJWZZOXuO9NraAE/KoncwmeAVfnJsN
         9GSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791982470; x=1792587270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KYS/c54vQeVbWBTD+IBBHhIs4+bHOZYRw7A3ClKDlRY=;
        b=GhGkwpJTT6fXiF9yrbpcPpLZFt8cagCklO27tAT0GOlKOZd10Pt5nn2X1ARx/ukQ/0
         5MGj8JFAUPzR/X6RJDy0A7B9xmrxOP7FNsGVL950MyNWwmqTQKvmH2bilzrC4KPSFWQh
         +/8p25SEMCixJ9FCt3tfk50NMJPhfsf2m5ezWVA39gXJPC9GgHm3Vs0U+ZLVX5ZB+IJ7
         aUrmRaRnNhG41Dq8PlivhI0WZ0WR4Szgy9m5XpYbsKeetYowEMLxy/JkCC65WublRiTm
         LQXjmw+pZIuW64Onl2Zos796QocP86vo7CFhe5oCbBXxaE46ksmfhod6kC5xzBKUPqYu
         HuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982470; x=1792587270;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KYS/c54vQeVbWBTD+IBBHhIs4+bHOZYRw7A3ClKDlRY=;
        b=1Wrdmh8TyTF355kUCobQTK1vMorVaKwgLw4H0KA/D0/KctmdoFyictFuKBuF+yVMRI
         m2iDXA+ZliTglqTMvAv68dUvUDSxhURX99uvI6sRhntO0RJFbfnNDLumDab221kBRe7q
         ZNJSqnW3Qnf4gX6zzIu0aEEUAPEy8P5ah3KKDn4LtmRYBjUXYht1VM5CDcOap5Nhh/WT
         QoPhNk90xHFxef9sQt362Kx15XqnNVh6zHJH5uWNQaPFe7dBSgF55h8a7GjBIdYCedF6
         erUX36Bg2bNgLatY2h1ESZ9jyJwC4azMlcskv5mDsBzgkLyVtJzbzP8at+nbdw4UtyJ/
         Nivg==
X-Forwarded-Encrypted: i=1; AKwUvBx8OdmDdsJcveToLANDLmLUh864xM4fnuTa/sKCYvRYmJFRvapuQTqL61H7RR1J+JDkfCU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZ86W/xn6HCHwzfJOE3fUw+scmYPEzNOt4A75ld2HF9C4EziA0
	kTV5bAmOPcaQIu43TaR4lbE4LUbL0eZ5rTUgzgMMUTJfgxg0e0l9vVQXj2q/cH3xFMPOKGmfpjS
	mfwZQrqKMjD77pB0RL96C2e+e7lypDislndS3dMtW
X-Gm-Gg: AYBFou3iSnvTCIMxfYxy4YMgoLY07VNjbdW5+tUGZwsmMZxyw0AG3rGgeAAuHVbfKHA
	g8t8JVy878g8sDzr5PAlWt3FQR0/WVqYvHmIaBYB2gE4FimK7clScpirTlBnw+4zCaN566Wo+GV
	RLkcUR7QHxpmqKnM3+eGuWslBwnO/JQ5Bx/u3GcXqr0MD33F63PU7O82nuVHtQK0a75v9dOjOEl
	kt/hHvVY+pc+iUeL7H85Mx2rlc1higCsjhwTufqt9Zhjm/4ryGDhAd6VCgj1MWsgD1c5Dm8jLSm
	OA9OrCBOVC/ELvcXTuTSOlOgD7ge2CaU/p1p0bXArAZTx9629Dhfkgs=
X-Received: by 2002:a05:6402:c548:20b0:6ae:1503:5a27 with SMTP id
 4fb4d7f45d1cf-6b20aae063bmr28860a12.8.1791982469402; Wed, 14 Oct 2026
 05:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013231728.883001-1-yosry@kernel.org> <20261013231728.883001-3-yosry@kernel.org>
In-Reply-To: <20261013231728.883001-3-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 05:54:17 -0700
X-Gm-Features: AclHuK9rxlY9ryi2n9m2aAdyaSNARNmcvyrOyG0s9ziCGiHhPOebsZRxyO6FDgo
Message-ID: <CALMp9eR-CPo2n_7uN7paJQZvmPXA6=7Fpo0xJePeadXwuD600A@mail.gmail.com>
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Drop for_each_shadow_entry_using_root()
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 4:17=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Drop for_each_shadow_entry_using_root() and open code the walk in
> __kvm_mmu_invalidate_addr(), the macro's only user, in preparation for
> handling failure to initialize the walk, e.g. if a cached root was create=
d
> for a different MMU context and so can't be walked.
>
> No functional change intended.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
