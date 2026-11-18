Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795043045;
	b=VsliNZ9qU6HOutVY8yqlYNODd9pY7vac7R0WUYoy7ZTnQmDJB9AkEsxsHGZJ27V8lAR2
	 ao//WTqjkKPifNVM0XpE2tfqv+T+XWRcITgzQMhWyA7H83rLH/D/G5Az1uQ00ym01gUn4
	 EnuueU8j6U/HT3T8cJFFhDeWcd/QN8MkwHCxVcWmliKFUgyE1ZjOWb2uEtcjf1QYBnpzr
	 bWAf0iwM8PfIfnsLvuxyAQOAGmFxTqH7Mz9D9vJQp21+P7E+g98umxYPe0cTlS07HIDEC
	 jwmUuWPkoPaR9J4/ZRcAiA8Vl2Ykkhdr/aLjypQaO0HwqGfEZFuFtsxN+fdKrt/DqmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MAi/zi144A7lSdUiZW35UwZ1ctSLyO/1ahXdrUK3rb0=;
	b=qcquB/AaiZIxhTgkuczXFY8vz8Z2FOS0SINMXZ392eBPTozxakiKcQ+5pJ5RnHiii2wd
	 YaXP1UIGL4KwCZLMvrEjHlX1A7+Y7k9kiJi27wUHuxqBPPD24vqjCntYqMpA+Xw/nG2S6
	 80KLShXRRRWzBqDzw11AK9ihoU3QO1NdO0YwWjClW/u9sj3FXAxz1OtvL5wabYj4v2amk
	 4qufvEB9OKOLkEBOHZVbHl2M8zUE/cfYxtuK4CU4z1TQPzkr1sCHEAb88+yCQj6vDzC27
	 piXONvtYq37Hz5SF9aPyN+wI8MaG1QMKiaVN8b4si76gM/82sC5Uj+SwIzFZFjGDDnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LLjGUmcb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B0560A2618
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 23:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2B0560A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LLjGUmcb
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b869ea8224so5805a12.0
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 15:04:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795043043; cv=none;
        d=google.com; s=arc-20260327;
        b=o+dnm3Nq0PMloLE+8mGf+auRWxoeFFCslaUwIT9r538W7amECSnY6pHg2y6Dwt8Qa/
         zLMx8U8NHqhKjsI7iGiZjSDiXbAus8ko4tKlT9Z911/XknOLBFs0V1oOOr8NMruvKzjR
         EqrhPoTaLbvu6k2erMYx7mUt2vUXIOvKQ3CjCQ6tUlibnoPGkWI9OV5n1Ekd6aOyV1Ms
         4a0cdcgBR9RYMJ1mcNtbW1YaF8x1/9E1nufQikDsHed+eke83654fOH0+twiIsZ0sJtY
         GVgJ77nN6SajRUR0jnhbCN30YS4gqYzfM6WLqEUv3DzVauiWeXxI22zc7tNPnX7zbvZr
         TYAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MAi/zi144A7lSdUiZW35UwZ1ctSLyO/1ahXdrUK3rb0=;
        fh=rIx8ZcGWuJ+FixWH0sgIgY6Ps7+Ze6dT09MErm0cdpY=;
        b=RMephP1QNOf3Nd22zYfh59Wf5dIepdZhRcmz8Bj/42WyVacF31LHWuUHUUuBh9wtsD
         V86GxH6S2hKq0xdfRN1eL0GMkbGdEtCUBtX54NTi7N0EpdQEOafyv0GSNnrddRCbJjXG
         I0FVOjW5fLFJz8zS5URWYNwISXoYW49GnfDeHIietnT3S0RPYsS0f6Rch6RysVbVJqra
         AjlBTrsDUB9Nc08HfiMBXjlcgJv2CsggltVxx4brOFiRSZyea78xRhyT4upb9sG6+6Uj
         SRYUaBybksNeLqCIPsXJhv+5GI3sK65PJptln6wtL7pVIg9WfpBEKvEJnSjPVGi6/wYR
         Xdjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795043043; x=1795647843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MAi/zi144A7lSdUiZW35UwZ1ctSLyO/1ahXdrUK3rb0=;
        b=LLjGUmcbxb2iraEZrpFIRA7nRWNm0jyt9aglLqdnlM9xepVF+60SGZlVX3J9ieOcya
         SX93ap5ZDbALGsrUarU2TAR0lnWC2WxueUlotkOa3iPwcM8tk/KudierNYQo1qFHF+jK
         lvfyHIEJwktft3MACLylYzuf1gIaaSG6xQmXL4PFnngvoCatQg61hjYKgqdYx3PuzFko
         9W9fjTmtCYllchJzpYbJafRaKepBI88Uv+IpSceGaA351NMSVdRoiojRPdorJDtITNW6
         aJoo1lBkB1GKkm768oU/dnM/rrnAoSOwYRi8mPXVJFnQaAaWojO5luTxVgSL7FBWDa3e
         kDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795043043; x=1795647843;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MAi/zi144A7lSdUiZW35UwZ1ctSLyO/1ahXdrUK3rb0=;
        b=mizb9UT/1om8yI1Il9lVIsj5b1c8RzFyHVUU3PNvsNNSVsuvLjmMtmkVuR5xYu/e8M
         xEVEt4HK/tktfA2jOnUM9ElUsLUP2vZFGpvrL9pKITgP98B1pJttk78Z3uZVEpeYXSOh
         rbOBh47KXtaI7wH66ILYHavaC5EYJocvdNFBz+H8Xlw4gf0u9yQls1CtAblaVaNY/eVu
         unnfu/eWP0eV/SeuFojUQhy4+DieAD7Zl6L+Wy0ugFlYVU6kRF5UJmBXZt5wNO56xRV9
         iyaI2P9YzRPSNPjltkLNi4ic4qdqf2Pd0Ia7NP1FNg68X38vtG3Zodcj0SPwC1tK5Nhp
         6/1Q==
X-Forwarded-Encrypted: i=1; AL+hErFLxO61k3IAzMsRAP1w8hUHpE2LRw3ZECRmgT5tRgdD80+NRBfN1NT+/lzZHiLF/KgCogk=@vger.kernel.org
X-Gm-Message-State: APuU4Z98+9LpRevaYOiWs1pZeoRkcBTnzgiUKuvMcKQCzX4YzpE4fbXs
	kWAt8bJw8AL5C4ldEGVSyP8/pNKbwqwG+wyESE37Q0585BkXSBxDYpDL/DHig7g0naky+dmesoM
	xKLU0rFOA/GS5xZUsBGe7ibwbe9GCbDQfdZ0VURtH
X-Gm-Gg: AYBFou1LPxW0f0sqVOE+J4VR8u422bvU8xjqgx5Y4XBT+ljaJ/AOYP+GHdK6Pu4Qj80
	wNtnGghdij/scNFxvbKds94m7MTn7P6Vkl44k4meYEZPpV7cHcJ1bBRaCWTSuHwwt5VPEaZHJOz
	7nXCv0nqXm+jnjKiBg/uQ5+si+5h5BysLEey7lBvFA1a55HnM8KZI0sGdMXuyabn8G7nxfCpQix
	N+4phVV6QC+JmbuhUhAnCB4OepLK51KioJ2A/9hS4GQAU7h4UJRPc51EYbifMo+MR9ntA5zzvDd
	kdRXWxfMZWH7MDpG1zUtu0eBEqcD/mpKYKpwH5UxjZc6pNJcRBEMiYrYczXkCP3EyO0a4x5JM0x
	aCPAJYuON9UsqkrRFXpFbl/EdEuyUcULdIg4WpN/9kOUR4vrF+DjOFfQtAJ0t+lQcqjubhjOtvK
	TklZwCVKo10kqwQUD3FzK6rIaTDiCDcEBAkl7FfB14NHzldAzy/JcrEA==
X-Received: by 2002:a05:6402:22e9:b0:6af:afce:184f with SMTP id
 4fb4d7f45d1cf-6ba0372fb5dmr32913a12.3.1795043042870; Wed, 18 Nov 2026
 15:04:02 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117180310.921701-1-chang.seok.bae@intel.com> <20261117180310.921701-14-chang.seok.bae@intel.com>
In-Reply-To: <20261117180310.921701-14-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 18 Nov 2026 15:03:49 -0800
X-Gm-Features: AclHuK-dozZ0LhHAkPXP1vXJkCKgeOKrdvRN-Wa7AZzg9RaoVZ1EP292gx5gh9U
Message-ID: <CALMp9eShHKZ9xUUo-7TRwJ9LRpLDBG2sRERZG8_amjphjSvoPA@mail.gmail.com>
Subject: Re: [PATCH v9 13/20] KVM: x86: Support REX2-prefixed opcode decode
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 10:32=E2=80=AFAM Chang S. Bae <chang.seok.bae@intel=
.com> wrote:
>
> Extend the instruction decoder to recognize and handle the REX2 prefix,
> including validation of prefix sequences and correct opcode table
> selection. Prepare the UD opcode flag explicitly with Undefined, instead
> of zeroing.
>
> REX2 is a terminal prefix: once 0xD5 is encountered, the following byte
> is the opcode. When REX2.M=3D0, most prefix bytes are invalid after REX2,
> including REX, VEX, EVEX, and another REX2. Also, REX2-prefixed
> instructions are only valid in 64-bit mode.
>
> All of the invalid prefix combinations after REX2 coincide with opcodes
> that are architecturally invalid in 64-bit mode. Thus, marking such
> opcodes with No64 in opcode_table[] naturally disallows those illegal
> prefix sequences.
>
> The 0x40 - 0x4F opcode row was missing the No64 flag. While NoRex2
> already invalidates REX2 for these opcodes, adding No64 makes opcode
> attributes explicit and complete.
>
> Note opcodes marked NotImpl alone end up in handle_emulation_failure(),
> but that will inject #UD eventually.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Link: https://lore.kernel.org/CABgObfYYGTvkYpeyqLSr9JgKMDA_STSff2hXBNchLZ=
uKFU+MMA@mail.gmail.com
Reviewed-by: Jim Mattson <jmattson@google.com>
