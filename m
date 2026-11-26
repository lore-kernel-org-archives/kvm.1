Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795674009;
	b=0ifN3XdHqQ1dbkVCtpJ/vWK6SY4cRP++WAW3RKGTloFaRGM4v0etDo/cMkwbWTxB2J19
	 oHydCRxn7tgfwLaUA9tFGAlAeqGuhK1ntU5RE3VkkcaPFnyVL1bIzQ87ic3xTyj91VQUL
	 Yo/oVVr9bmnBG+E1XFYB+bqM5UgzYNr13PXBRqLXqHX7HPzAIok1S+i6t/GN9PeIxED0N
	 s62rz/d+dXLAtINZq99rgNUPCj39ZWxQghYwB0EuSQpFl3E/DE1gdEn2p5FiFrM85hMte
	 p+v1REhfpRdRh9buII+1Hy46Q9afzeHLNvpsil2nyEMTYq1dd+RFRCcwbj+F//6loYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=20hk+nfMYZ26edHCTo6znUbrjDsyrRSunBG5oc5JPOk=;
	b=nfGlTWdnL6JfShCqXc+6fYdqCvAJjqTjonTOu1/sfwOEZB6MiHGBQ2V5gbpDg15L3Rsg
	 WCt1HdMhJPJIAXE7ifd4KwLWWMWaQ/Qx8OQgsCOP1ln/zNg1hTKPINqhU/kCIfLBj6s/q
	 rs12L6jde//F7l4L4z1VKPjkjV6X9mlcPtnDYxHnbcRp4QgK/Ma+4hH4ovgGN4A4C4Lf7
	 RgrsRJ7MeNtBcEwEQl2+YM+hzxmusVlweWDNCQgGOCLbw95KgH0KJsgrn9ikbr1J9Wb0w
	 GhQb6CrqAmqppiL8q6mxsw0JhLzJxzb+BH8KlVOXtAOKyDRUQMwUiD5/xc8pidsbP/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="AKDX/AvT";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847C5606A31C
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 06:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 847C5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AKDX/AvT
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bba5e17728so13166365e9.2
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 22:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795674008; x=1796278808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=20hk+nfMYZ26edHCTo6znUbrjDsyrRSunBG5oc5JPOk=;
        b=AKDX/AvTLPPlNcyXQ5fcqZu+L+hz3RyqBo8suuSkeH6YeJcHy6nr7VwV5q8pp+ssPt
         gg7oHcTRAGtgHlQpcKq/USR0PadmZMHZCFE+2rpRITObxsTXOZUS4dPsqtQ6FADvYeVe
         qK4h2UI80hCkLL+DzkJOapJkuBgqVsTkFL3eIopzI490opa7vVSCHNXxiI2D4gqqQ2CN
         gycoLwYqrDPnCG20w0Rcj51x6Aa1fsELgqeHPhXgiZ2+mnKl3w2HJpC4PUTy32/oaTFW
         ABdT6KVOskPlR4H65B0b9Y0mOFL/SoTP8iee212jp+4Gq/Y6yzA3hlQc5TwNssGYypOg
         6hCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795674008; x=1796278808;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=20hk+nfMYZ26edHCTo6znUbrjDsyrRSunBG5oc5JPOk=;
        b=V7Yv7E1O9/zzgTYohRaoI1/2b59NdGWMcELHnwzPGShYvKnhpybUCtiHq9re3rzGsV
         n6q05wIkmIIcJkNLQZmzryxClgg2kPoHt4kX4hr0j1ySoL8lhO+wUkXA7jE+w6/7AgwD
         MP8nQ8H7y5FfNrCjYhQ381OXhxGQIjTgzCxX6CPDyCSfdJBTZcJJOgffF5goXCHivCTm
         teQZdUW0LJbijMyzSiEE4Wj7dV1Sr1iKdYNokIjBOhI+dhMkHmdA7ZlFEq8KKt6db4WG
         LzAD9fWRa0qkc/K0St4YV2shxRRcK0AFDY6D38c7Q+GIhAWvXKLsK0zF77KJ3OAzsG5h
         ktQQ==
X-Forwarded-Encrypted: i=1; AL+hErFUVJSheEjj+o9w7xZ+s7Gwv30UFJjwk8mxZZ03wxmnClyniMEr1jhwubnHgxUQy9qsUSU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8q46h0HYD+v8kVMD0j+O9KpyZBA7WI8hk6g7CEmHN2QPGza/Ji
	QVT/XdK+ygbzYkrSHoKuTHuSmCIUE3P8nVqIOBE/2JAUNsKfURjafL3avfvtwYYw1Os=
X-Gm-Gg: AZFdTZek3TuzJF+le2vpUvr5XK5sB3daoUUrMRyZP1oJ91chPwo7q1C4fmO+vL2ku+o
	dnc7SG/VGnYbVi6D9BEwnhqLlCcA8PWBaG9o7xMzpHlWWDgEnMw+m8zPvinU6++nrmtdQwIRGaI
	LNZIkNZ1MIVO+TzOxJ+CbGFxq6kHXXh8PmJ96SZr5Quh2Fn0LJe0fOfzhSgeCfiJf4mkkktP8qy
	zDlwLwOtZh+O2ywTXJJgY/G8dMj7MFu1tPhwLHg4YKUJytzT0VTIKQc4o8HElsY94IDHPSTiTST
	bgYmTO9yw1Uwrp8xQT32XadJeq6KgDjjDi6vhZoIdiZVfsY7M4KOxnpcaSbGok5FkK4PBHxPe09
	kEeov2+I44OaiRBFaK1Mo4nseJTO2RTjGt0KJJVvNsU0OFozRd4BVsn1FwZVytLNYYDYmCHGV0/
	xUhj1UeFP0Bf39KRTV88ab6Hsyyf6EDICW4uMWCYVf7+x1z7bcqUetg3tBmXfYBcO5BLCIdOvin
	56LMf0G69ux6swLgTlghtdmpJpq259lN4XEBGdZYVtEhXp5U5B2TYXImq0m0sXPSRZYI8fBM4Qq
	7vcS9jK+W01nsarTW/pkb9mLUbmiECYPjVz8Z+CVUa7pXnGfah1Y7xlG5ilgHRXi/i6M5h0eXlu
	HjT3fwk3I/IQnkAZ6bolV9uai
X-Received: by 2002:a05:600c:468c:b0:4bb:6d61:af7c with SMTP id 5b1f17b1804b1-4bb88944bf5mr391819155e9.35.1795674007829;
        Wed, 25 Nov 2026 22:20:07 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884865b1sm580133385e9.5.2026.11.25.22.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:20:07 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: Haseeb Ashraf <haseebashraf091@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	Haseeb Ashraf <haseeb.ashraf@siemens.com>,
	Eric Auger <eric.auger@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: Re: [RFC PATCH v3 0/3] arm/kvm: select an nVHE-only EL2 with SYSREG_ID_AA64MMFR1_EL1_VH
Date: Thu, 26 Nov 2026 11:20:02 +0500
Message-ID: <20261126062002.136401-1-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8A57A0C8-9E85-4BAC-803A-DAFC6DBD6612@nutanix.com>
References: <8A57A0C8-9E85-4BAC-803A-DAFC6DBD6612@nutanix.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Khushit,

On 26/11/26 11:38, Khushit Shah wrote:

> There are many such fields like PAuth (APA, GPA, …) and SVE. They are
> not part of the SYSREG_ framework as there already exists boolean
> properties for them.
> (Another way to do this is having -cpu …,vhe=on/off property)

The v1 series was closer to what you are suggesting: it added a
standalone `vhe=on/off` property and used it to select the
requested KVM vCPU initialization mode.

Could you please also review the v1 implementation?

https://lore.kernel.org/qemu-devel/20261121095636.289814-1-haseebashraf091@gmail.com/

I changed direction for v2 following Marc's feedback against adding a
separate property.

Thanks,
Haseeb
