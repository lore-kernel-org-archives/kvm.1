Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793208283;
	b=5gZgNGPeKbczVu18AjKKYdza727dG6HgMl9H8WNsOAsPRKKNHqVO8Pw5mrL3FuSLdtGy
	 94kZlpw84MhdzdNY54tzDiwW5tKov5plifRBMHrr0qy93IV7xpBI3bhQofI7Lfei2jGPL
	 XAiIuOZ/66jQd5J/w9z+45Ax/abZV5zvJABoP38lyL0QExstMwkehegJ6n8I3I+ptQG+K
	 arOeFw65wPVLfeu9fwWvUV0DqR5pLTgW2F0T7h3sGkWw4JMK3J7Ik0Jvjh4z87rrkwsuE
	 DGErPlsbiaKtphRyKSgyEkJFN8MSMUqFlw0Xv1afpQze8JLMgYQjYRdgBzFX92t4v8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
	b=dJP0+U4VwfrL96hX9Ji6nezuO53BMZK59nE5Bbgil/tzxB85ySnCQlCiZM75F6WwGDy6
	 KyRE/0Gl4TQi4KksukfMIg05Uxdysz8BXQ+SzyRDgu/xd+x8QpAJaRO9CQ1kY13tPS4PA
	 g8FHYAfrErE7InCFKWbZAP3LPMAiR+SeXhmmnHGDujv+KbDWb+Ra77ldWVu6Wn0HhmNOJ
	 EBjadW9eJalps1NyLt1nHfHHhqKHAIQF2nw8+bdxZiYXJElI8nl2CkLZZIw3LpqvlmI8L
	 MvjJKBiR9CUw2k/wGWo6YtM4FCAs3iVU4xUBG+TxdTSfHPUty+/IrDQ8louYkElCT7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YTEmwqKv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA13606A31C
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 17:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADA13606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YTEmwqKv
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-14fc585291cso1102410c88.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 10:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793208282; cv=none;
        d=google.com; s=arc-20260327;
        b=bP94s5qyZaTnoc+JlGOoAppIbhkAupqQshChZdpbdQPubz0XqYsVeargqHpO/0KLqW
         zA0H12Td9oEoLasb18LezKOlPgxaqiTGLYNs0k8SfpH+3/69Oi41+Uengc0rQzQtQvSY
         RundB89O1ufOz5gE/Qekx88CppzapJPrRSNwU+Mj/aCMZG0j5OapK2dPRK1UoDY7husI
         Rb9JoJ5r6S/6X2gFNog47etnrOofGOs2lnCylAgX2/15UHooATBUvMby/6Z9LuQkpDpE
         6ji8TPW4arIALdl3yA6VUC4TUND7sz9HzrvYCBQZI23s069yvxXwD2vkrqc9V3VfAG64
         udZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
        fh=4bfS4BQTchBBBx4OwR83+WTs4favM9Th8VzyYOYQppU=;
        b=koAYDN3wrJ5BoDkbui0Edn0K3tbDM2wI0r2D/0E2UV5NIes39CLUNZsHEUx890afrY
         HwNbS7DytMkj4/CQc4bRAS9brOx0YKQcm8nQXu8ysA8TaH72jPi1E1zRDejsVlS6dhGP
         TobAwwLKoAHvKbu628LPV67Rh947yXexLLGpnh0VchMYiAdTcwn0jUR7a5Aeffyl7ttg
         lryiD+Fr/ykUuJUgQg3gvgIADGkstqBCtndjDGydP38H0JEIzBtelcfUmEXzX1F0DQXW
         BvaHmAMM1iVHmQ4KtBpYpJZn4uwwxxQ67SK+4WKx4RgONRlo71KN4Ph5R4kfGVsREbYP
         bzmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793208282; x=1793813082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
        b=YTEmwqKvUSdnC+hS4b0vibOxIpmGakM3GonBTipKjmgXAv02ptb1Vy8uP+4aUMBPns
         gZNosqX3uAXrNbcVQ8R9hdrBtd3oSu13hrmentv85sdRt33GEt/KoljlvKtg47NP/Gt6
         AhwUwVhxCmN0lKLj30d45Ypyo+T0SOx/hytd7VYgp+RromGQBh6bOr4sl1ec9H9aPPZd
         zNxKiJQ2yUaILf9HYEMWLXSrH3c8SJZ412vkomzSiqQiIESjeTooAznhU3TUiQlkczP8
         qFKV/bpX+B9T8G7m+G5/evMF641ACRS1xaFwPNKNFPNhiI/zMD6BE/r9ssZ5f6gTi54J
         0QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208282; x=1793813082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
        b=v06o5IlqOdRuJn6CYjI3NhDbFCTYv/B5aG3f7VizYa+PZ3au0krKz9Hx9KCYBNQF6V
         2UisfqBjoaiQV4BTnRvb3iPjPniHLYtDr8zCjw/cnrpi+npDgVhgYEW37Yay0CnqMtgU
         9SLCzSkbwrFovaE8xgcxydSlotLIPK58EhPBaWKgkeqA5UKkfov0po2BzCS0zvHw52nb
         fAe4iZ//1KYauB8gNGLhoCMkLehYuBl+lMnBeyUQqe5QZpx+4Q7zt1IQxW1KcQJ9ndp4
         Ur1ADieoCmqeGqMfASorfOO34FTzzZZyGhbSzTTcNg6k7/NNE0zSub6lApQN2tlVAS+C
         BwGg==
X-Forwarded-Encrypted: i=1; AKwUvBxWdFRLJE8Jifm0XkkVguG3jN+zrfb39jl/Rzh1YIgLMKqElk52BNKTTCj1Huxo6RUk9ZY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUsfBr1yZVoXZbw5r4VHdBdrCow1MEhO0ufnC3i0OgZgbkeydH
	MvV+duatymor9k9zPSLIyeguOcDI/xo+ni+dnBBg067/xUxCRsbhJB4TxeK2NLDYXz0oo1RX2UV
	3BM0MfjDELbGA2PbwKolG4pbxKW8GgVOoLYaruXM6
X-Gm-Gg: AYBFou2s7J875TDsVvBKVV5EXMKYIXnKGT1yNpswHubAwztw/CeXywvzmWBKOwcRB/R
	tCvXRFyjJl7TjTO/Z3OCGF6CiwDwD+wx2WggR1GPbtyGuY3c/55f1kABW38IesYBiD8RCizUAzv
	K2xeEYxWHmBcNKpYCJkr2Xuv4qgtQy2Ed5ZGklFg8vxE3puLlQ85uWOQt/ggGWl2C/E1Svoy3i6
	0R0u6dYqeekO6/UpnafihIjBZVwFk1mVJw8EM9jxy+L4HE7vHvR7Y/eA15Wzmwo58/vSpZ1hIRh
	5+iJW8Y9/0hg3M0HYTiKjErAtqvjh0n3AH9QoVgrLzJIbTowBcgrU2meqkNzdyXTJAJUf9Eq2Ul
	zlGphaxm+Gnk6aMIrHQ/7yIFoxepqPYr71Aptzg==
X-Received: by 2002:a05:701b:2813:b0:143:6525:f9f6 with SMTP id
 a92af1059eb24-1a6cd3a1575mr3454907c88.13.1793208280541; Wed, 28 Oct 2026
 10:24:40 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <atlKsD-aJB3mJr2j@google.com> <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com> <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com> <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com> <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com> <2vxz8q3hoicx.fsf@kernel.org>
In-Reply-To: <2vxz8q3hoicx.fsf@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Wed, 28 Oct 2026 10:24:10 -0700
X-Gm-Features: AclHuK8mtDBrFSk6j3m-QjfmBC0Hg3WdAbJ_jeR4OTytlWOkEsZuDbAniPHpdm0
Message-ID: <CALzav=eG5j2n5omO2Mxqw8xA4sZLduxdbBYFcnHpPn0PDpt9Hg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, tarunsahu@google.com, 
	Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, maz@kernel.org, arnd@arndb.de, jgg@nvidia.com, 
	robin.murphy@arm.com, loganodell@google.com, oupton@kernel.org, 
	kevin.tian@intel.com, alex@shazbot.org, dwmw2@infradead.org, 
	pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 10:17=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Mon, Oct 26 2026, David Matlack wrote:
>
> > On 2026-10-25 04:38 PM, Pasha Tatashin wrote:
> >> On Fri, Oct 23, 2026 at 9:50=E2=80=AFAM David Matlack <dmatlack@google=
.com> wrote:
> >
> [...]
> >> The reason I care about keeping the header compact is that we are
> >> defining a foundational kernel ABI and want to use this header across
> >> almost every serialized data structure so we can evolve them later
> >> without breaking compatibility. While some top-level structs are on
> >> sparse folios today, other serialized structs are tightly packed, and
> >> we are looking to add KHO slab support in the future where tightly
> >> packed allocations will be common.
> >
> > My intuition is we will have a small number of headers per preserved
> > file and per preserved FLB. One for the top-level struct and then
> > optionally a few more for sub-structs like arch-specific data. That is
> > why I am less worried 8 bytes per header, even if we fix the folio
> > problem.
> >
> > Maybe where our visions differ is when there are collections of
> > serialized structs, like KHO blocks. For collections I don't think the
> > elements will each have their own headers. Otherwise the elements could
> > be different sizes.
>
> kho_block today doesn't store entry_size in the serialized payload. It
> relies on its caller to do so. With extensible structures, this can get
> messy. Sure, the owner of the kho_block_set can track the size somewhere
> in its payload, but perhaps we should store the size in
> kho_block_header_ser to begin with?

+1000

KHO block should track the entry size automatically and not rely on
the caller. Otherwise every caller is going to have to store the entry
size in the struct that owns the KHO block, like I had to do in the
PCI v10 series :(

> Anyway, not a problem this series needs to solve, but something we
> should eventually do.
