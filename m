Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794927836;
	b=k6sKZMl8ZcDac3ivPSB31o+votKzQ4l516G1SoW+XOfAQjZthzrehfLtl2CV5UIvBEzL
	 bhmgLtCi25QGAo1eNZKn/uTpRWvviFKD5ySKHVbmc2uI4TBnQal70VdvxKoQ3gt4IWvdm
	 btqGQlvh79x+jgQdL+fgDpy0gnhsFRGjpTD9YZ2El8x9L04/ur5yMb1a/kvwneTPHAJnQ
	 1nIJRJP5ySbqeL9P7bPnDNUbksA6UBfYANXkre/cE6Lu9qd/TccOuQlQYWcgt2QXU1ekK
	 u36e4jXn/ivTnnAh+7c4TOG0W4z3mYUE5+APmwe1cm/ZrwmTC2qmO2NnZgKlG97pGHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=UR0Gfgv/fdEsWHImhEXrlTh92/mXRBGXB0/jlnan5Vo=;
	b=vg4ZMqokYqDVvsFXWLyKzIZrhWigbsuatSE+EVGgHKZWdlifW9H1PzMCpT8q2/snrslK
	 +A9OWWPBFWlcU/2dsqVJ8O+N9vp4f7Rg54mFXHOsMUytm1ZVIxDEKjxNTzqgAF4IEA3uR
	 S9TyKH9Y8I6zwpHXbKwrksjjdWXeGCtuAXHWq6XBIOgiUMe9kzfSuY7ir/7115He2TtqA
	 YmxrXS/7yOkLHbOK3vPKvdK6DgBbSoz0shanzamxgaRk8E+Dpb1gkDvZcLWmYUAecJVV+
	 92CggMvRvbjWxMqq1rHnWGTEWtD/PJX5VDnvg/nFNb4JljiIA4j8w+SF/XtRnPE5PIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RLgZDS+t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87867606A330
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 15:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87867606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RLgZDS+t
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c14bc5a743so10198e87.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 07:03:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794927835; cv=none;
        d=google.com; s=arc-20260327;
        b=D2/e935EjFUiNg36ya8Ccjufay2uRDOgQIlwmwDaDiCazHfkqniOwJ0HVbTIlvoPFT
         BCT6tekQ59KjCItzM6gZfXXrWmqi+RtYV62grXSyeuednGm0PYx6edQ2l4AkOoeEWqjW
         Zjb46nLgMLP4cqdmRO+DJt7lYxonPTxgbS54tZUcEsrV8om7vrx6cAP7Ij2Tjos3XZdZ
         mGsCadBYEU5fXw44XdVYgfXD6AdkFLo/xlxBCav5BABAxS6AMfdagqW8UgGKkkrFwKZK
         CGcAmh0K09sLho0d6aSgD+k7Ne+ttfx6DDxuwYdUHCkRy5IPBBahvaH6nEhkC3H/qGya
         EVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UR0Gfgv/fdEsWHImhEXrlTh92/mXRBGXB0/jlnan5Vo=;
        fh=eX0UUv20AwtGz/6DjiJ0HF+j7ya/SvNd9lj9bQBJBfo=;
        b=Z7cDDxfMtrNOF/eGZMyVp8dGLPCafZ6/nTeIA7eulG5yrvF7Zc5ShfRaYUKExDM+2Z
         /YAxmx6wzVgzOggSlFpgQlRY0R9N2yohoUv9h6joPTVsaoKIawULOxo1EetXxm1Ze29T
         rHQoVv0pNb/qnBAPpA4pj7a2+Z8hr0dUYIomwV2ZNAhMn/XpIEQ6rndsDk4x7LtoRnUF
         IN1Vu+JVHm7TIT6PUTgeXrHWBCzCH1/dfp/U7flpUE/dn9y1Am0JiJ8maL273/d49F5+
         Q/PvKp0Icfvf8BlSG3e1UCVECWtJtrfpBxhRscg70T+KjbV4xNcQpq6ymn+IuWnaSQhl
         T6aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794927835; x=1795532635; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UR0Gfgv/fdEsWHImhEXrlTh92/mXRBGXB0/jlnan5Vo=;
        b=RLgZDS+tUgc+aaNm9VRRya/8Y5bVpU4/cnLDxlbXQR24Gg5ANKvAXTLTsFYt2NCIp0
         2jyd5aeguZJl1ctNFBKuwfCP8SbVTnExWnMKW3Fv0poSqRoXhOMUMcWnTHNuuPMkEZZW
         VTUXELdZNIIKZd7vVYOYo0ZBBmTopJdjskXM7GNk1gDPZZbSFJghrNYpil+4I2MCEzE5
         2PzAI+sGRJSChS27Q/oSTVEq3+DBnGcdSMXh01K9y7TcThm4Fkw4xVhjciQJ40RZVrcS
         L62FCt+c9SrrGjUIx3SR5Oom/VMjwoSwn1FAUhMKLgUr1NmtdvCAnJZM+Ieelqyj0/9c
         I4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794927835; x=1795532635;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UR0Gfgv/fdEsWHImhEXrlTh92/mXRBGXB0/jlnan5Vo=;
        b=g8jtEwDF/ZaDaLvvX0ZvUxq7nhNFCqJL2FG046u7SvLnhUgn3SPGziNIU6t9KNQpoW
         az8hzd0CxDbD3Nl7ph/HEWzxddkzlBxvLcsykqj9u2mOqPg+xftr9KuEfMbUHqwIfDWS
         Ey01jnv1k6oaIByuyZ3rnSBsynQcL+qqAlJwYqWJhU4JS/YukRN/RRiqlf5Ha/udvnHM
         HWV6z+qxyyGY2pV2haSBp8XGbigi+n0hS70w2vDI3qPVYaEvBTTAt4QN+L65UtnrO4lW
         ZWiF+7tygPcuaEcsPT6NLlqLrvuzHN5C5oVCKiO3psNLd/2dLJGyFe1R3P37PTbH8tzM
         HEPw==
X-Gm-Message-State: APuU4Z8KRXSzLDFXq304v20xYnRK/LxBJQ8GD0crbJyhwXYoJ9HLtK71
	zHliGGyoUX6tpw5cAgOK4pJDAhzYIbfWXaN6FkEQZ2/Gix8yRco7tmj52mxw8+B0NrMnqZcl6i7
	nHaqYxfPL93DfUD6pW8qzuvSkgj+QL5QbCBBMV7hp
X-Gm-Gg: AYBFou1ettmVm/6mC1nmHH/9TuPJ6tqRLRo2ZF/zqcK/e7jJJ9CNsc8oYClKud9fiPZ
	9k0t+LIsfA5NYKLxiVTZabcKNdv1wEgISREj3IGh2uxij3TsV6v0STfJCOZX2/84PjPfzYNUz8z
	OuJvZlUdhj2CF3OjbQeV1l3lYrQqQIIjWAHHY64c4gK/D2NilT90mj2Jioz7VxWNsxE/2kCccCZ
	SADEeIAP6a2daCOagOIz8SoV3UkXD4sI46ZXWgsk5N8+jh0ROTNwleTpIVBxoayZKc29rKMfHH7
	pNpiL0L8XFbYhLD3aTrp4D2LG0kSeF9EEzVY/Pg2ZPaZA3gkQRkZXG5RIho07Wac/REwEd/FA6a
	TQpQv8MphE2SHlsgIXPdQ8TWjAtkEpXmTjCR7GyWGEqLShGq1Iex4z+5RGzKZyFXepMQH6PJhe6
	SzUoxPGsygxxN8Yi+wJ6yTEzCl
X-Received: by 2002:a05:6512:2249:b0:5c1:543d:2e3e with SMTP id
 2adb3069b0e04-5c1a2166b35mr171174e87.7.1794927834031; Tue, 17 Nov 2026
 07:03:54 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116164358.142785-1-steven.price@arm.com> <20261116164358.142785-11-steven.price@arm.com>
In-Reply-To: <20261116164358.142785-11-steven.price@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Nov 2026 15:02:00 +0000
X-Gm-Features: AclHuK_cslY3zjG6J6IGbNXJdnealsL3yNGOi2bev9GDyOWEmQLYI5dVsAlimaY
Message-ID: <CA+EHjTy-0k08Ukyo+4mmzqVn9UjRnvhy=BQT9kxSj7CBzzwO_Q@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] KVM: arm64: Dispatch stage-2 destruction by VM flavor
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Kohei Enju <enju.kohei@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Mon, 16 Nov 2026 16:43:56 +0000, Steven Price <steven.price@arm.com> wrote:
[...]
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
[...]
>  static void kvm_stage2_destroy(struct kvm_pgtable *pgt)
>  {
>          struct kvm *kvm = kvm_s2_mmu_to_kvm(pgt->mmu);
> -        unsigned int ia_bits = VTCR_EL2_IPA(pgt->mmu->vtcr);
> -
> -        /*
> -         * Realm RTTs are inaccessible to the host and may contain stale data
> -         * after the RMM has released them. The non-root RTTs are explicitly
> -         * destroyed through RMI before the RD is destroyed; only the root PGD
> -         * pages remain to be freed here.
> -         */
> -        if (!kvm_vm_is_realm(kvm))
> -                stage2_destroy_range(pgt, 0, BIT(ia_bits));

Could this patch go before patch 4? Then patch 4 wouldn't need to add
this check.

Cheers,
/fuad
