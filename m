Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793941230;
	b=Fjs9qXMcwfD0EBfVZuF+vCGxXiY5NooyTUiCs+Y50OY+iyHJ9o65/ZhJmB77kYx3shlx
	 dWrPOM65dA540xQIvt/a+ySDMA6wP0Rb8TclwnK8Oo7oBV1HfsWrAW5AmJxcxfunFe1h8
	 EgAKzH50zbNYSYV20/XQuGToRsRpBzwzgXHX1rwburrLwzuyLbKXPiMjrD6XDqmaw2ejA
	 2nPlbbQej7Wz1AUxZzRGsWMWPGPh4c9d4ZyZ2I76X50irv0azGpG6lYrB3jqj5BTHnMds
	 twIZL1aZfcxCMPzmZz1PekpgoHb4o1B0oUWMCvXNm42bVaMZurCxrKRWva7q5wDY2PQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=476k4UWO4hCLUtWW9nGRjKZYF5O3zRuAKrFSRe5j/zY=;
	b=ITq03EpzWwk+dJXVEThXH0yX3Y883vgAam33dZ4VxsXBramKtqMTTeYe24RacAGlwjVI
	 GWq68r+y6txV+iSzFJKmyqOl+2ir0BBIY6UlDVUorjXNe93QG8RyfgeRg948gxEz9VWub
	 +QfUJcYNH2SSY+uVKXVf7ktU44SEWrCLpLmQSwyuNI2i3BH8K8531Cd2auqVbAuzLGuTh
	 8K1iTj8fdFzcfMd8epY8CeG/zFPjd8KHmoeo6eBytGOuwKevEwy8ISk9i+Bo9ENxx3lXL
	 OCzS6UAmKSDcT4Hc8gQJ1AYATNNhpU3n5CeSm8jaDQRvjeJJpZWZomx+xJ9d68ZXzjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FQFVX3J+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2F1606A328
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 05:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F2F1606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FQFVX3J+
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5383c97c8cfso27901cf.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 21:00:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793941228; cv=none;
        d=google.com; s=arc-20260327;
        b=prC9k1RGHpBb67IsOPYAeb5banvBPXBbHtd+wK8BNQIbeN0IdHPuci08HLsU6jusDF
         WjPd0+7y/Mqcf1030fJyQcnUNXmAeqBeY9ZkH9MVjiCb/RbJuzD7jX9zbMZrpUtscuxk
         SRhxr75dab3JdSejAcsItZISd3SRMj5gbp5zJgpzfGFszNW1dgdzWpI/K/2tX0bhF+dv
         a4aQT4+eRIULTeMxjSRU/Xo1GpR2+BYjMhguOBnlthxz/IMn/tcosAEaClgjEdZoJxIN
         xvA66YHcH1zhAx/e4fX3+pqcEFmj7Qt1VyXVVzOYbcvlyNygemGgkkQBrx7EGiQdKO2n
         raaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=476k4UWO4hCLUtWW9nGRjKZYF5O3zRuAKrFSRe5j/zY=;
        fh=eLJhT4lCJDYjKjSf6z6zYLkWwIUBMt05I+0IqC42peg=;
        b=IE/8z2IySleHlHZngEvUuwbe6enXUPq7h4AJNiRqO8+D9CSQunZ+7VFR1uo2SUhGdB
         rCjk+l1A90xn5PJ+VyYvrB75Q6i2paEg+Hu8rD1iy8cTxv+uZyCrvInFpRLIoIfcWBCA
         xiEwzmYchq4eR942/d3yH5PlTLonK4nPXTQZimZwE76oB2O8y7umDM/t6VvUMDD6yj6f
         I2gt9gUUulh5PZgdq0ZcrIpQIBnm8mYE64I+ZXNH90Ps8XuPp1Z3jAPG8fTjpLKz6Vl+
         MUg95Z9SzsTANRJNWPV1i61t8ZiMmhm8Hg6VIKZUKtca1QiUb0XWZ5Vh8Q5glXrCcyhB
         7TEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793941228; x=1794546028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=476k4UWO4hCLUtWW9nGRjKZYF5O3zRuAKrFSRe5j/zY=;
        b=FQFVX3J+kJaq8/nyvHvnkV2Oo4Li2PH3c6+MtKS4UsoUejN1Gc1gCG7ikMSMYaehVN
         BkvznXO5+RjoxaB/rTzkfacEsYOvte9Sgvkn/+fJ2Ewk5WpkTUD3WfmlPKFMkRzgMPw6
         MIOFgjoG5Dqh1tJFA0BMhFgMN38tj6Bg44ib28DSNZBMhPGI1yh1P0OwaqnKtA7WYWAb
         x3sKvz2l6CWM64JgcUB18hBBM3rxpBSFpCZ1Z1X8HSrBsXtU/XCXSSM/7nH8JUAbVaZv
         LRXfNUXR5edDTgKfKyVOBE0ThdOOfuHlK8N7iJoh79Bma2V+PwX0hhtzUYEYRj9BblG4
         5G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793941228; x=1794546028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=476k4UWO4hCLUtWW9nGRjKZYF5O3zRuAKrFSRe5j/zY=;
        b=l55UTayh6/TLUrwu93FNnDeGe+6PAJPABo+lVMZiBJNAI6jOb31zzM5P6/DePbzV/e
         9C+GD/ZD4KkauaeTvMBgA34qXDLKXYYYvFd1o450VDQFStwrlxe4L2s7mvZ69Lz7fDh6
         W/VhYmroTsucu2SaF5TtsIrpXuVu+c/oyyRfLxPaGfkD2XQjk3sYvmZJh76rulb7jsxU
         Z2LrZI2Wj7z0Rh0vufMCJdU/mcMC9SKZfrhXGiOWaukpJdeixnrZFMcOoC4ERUvy3xT9
         A9uTP6buqCzA12b7lOKdSuvBOfYnnK3+43pdyyl6Tthtni89Uu4GfoJSIH8ZEnaCfeZX
         Zx3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzJzsZj8yaWRJpbAIDNvETgmxxQNHosE9Yg4riyK1syH3fPZVQUM1odyMVs7ZWg3BYOW+I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/Bhkrz6nMJ84gl94Q2kdMaLj1aOcyKwPNRZmuPRaLC22oirxL
	VuGrq9u979scqvNUfith1dLzKIOwIoV1zJKoUlib615lT3AQcDkmErQR7rGyJWnKk8kbcQlR/24
	NPdBygTzYThuUi272/X7j3JBXKooOEtb50otiQV5F
X-Gm-Gg: AYBFou0HkSweWrnG5J3uDAGumRuPG9Wx+kOcFemFLMcf21Lo1awvEqiEcaO01Fkpi71
	X3cGEhYkgpcDw3drG8qllOWarDA6GMFQ2xKCtt4tAsFVcJkSaCxQ2osi0znCMB+zF1Xhb/9nDAi
	ujTSv1N8chBSwXvHtqio319XcUQv6UIHEDJUbVJ79nA+fJrs/tR5pDzMr4Jug4mxS+OzI1Lc8ai
	TxyhHY1GpfUmlqDd5o11Xk2PtbubjjCI/KBIA52cWx72leeY/rw+Lb2vkMlvXZdHrg9mxghDAYH
	/7H/cCRyyTHXA2xV7YXDPEjhWHLtDPW5OKQMC32JH7+a7mMjO53Qp8YRqdcbcMt55lX0P8YQy/m
	mmsvFMtJ1zwLJ6wfmF43AW4gfJ1oSMG7NHRoaizmSg9YGH58iZsNgqQhHpFEaYVI7xtGMv2vjvh
	broU7/nOchfCuTPJQRF1WEOA8ufv0X0UcVUcxtw+fLWzg9Aw==
X-Received: by 2002:a05:622a:4894:b0:534:313:9b4e with SMTP id
 d75a77b69052e-54e96052d51mr2155131cf.5.1793941227739; Thu, 05 Nov 2026
 21:00:27 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-16-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-16-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 21:00:13 -0800
X-Gm-Features: AclHuK-ONvtswf74Bk4x5GIzd_0Y6c_P4oOC_oEKOJB8KY16SmIA-q6ZE1FOnK4
Message-ID: <CALMp9eQBuQms_sTjc3w70BQ9GVgCDB5gpj3+-ScJM40k9MOpdA@mail.gmail.com>
Subject: Re: [PATCH v8 15/20] KVM: x86: Guard valid XCR0.APX settings
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 4:16=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> Prevent invalid XCR0.APX configurations in two cases: conflict with MPX
> and lack of SVM support.
>
> In the non-compacted XSAVE format, APX and MPX conflict on the same
> offset. Although MPX is being deprecated in practice, KVM should
> explicitly reject such configurations that set both bits.
>
> At this point, only VMX supports EGPRs. SVM will require corresponding
> extensions to handle EGPR indices.
>
> Updating the supported XCR0 mask will be done separately.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Link: https://lore.kernel.org/ab3f4937-38f5-4354-8850-bf773c159bbe@redhat=
.com
Reviewed-by: Jim Mattson <jmattson@google.com>
