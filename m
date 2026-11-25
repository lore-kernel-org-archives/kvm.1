Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795585810;
	b=mC3pKZoMojvPgWerOMOsLsODIUgFqqlZCBaWLk6JDyJCSA7FF/E2MiDRngeU7SRjXN8Z
	 uNLLlGyrRbHU3ZWEvjm1Op3uXDL1v52iNPOOywKoG7Lh/lMD3DZkvGSHD7t77uf9jvlvX
	 TJDyDqbp5mJIzYRSgicnCPsobBJq2zihtUemC5OQMRI3bIOCyNNdEb8D5TWbf0TI2CP0M
	 NzuoHVxYyZiQKiAO38IhaLiJXSxBSvctttrX11BrCJLnIO1/AK/o3lsRmytdc4J4lg+Y3
	 9Nzl8d6DGugdzaaRzvx7KgGFff18JDUofb8btADrXZfGBdRSG+WHuxRL6CkaKef/qDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795585810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BpPvj0nWvmhIzxo1GF3DFVFg+7nJdo/Em/Vn4/tSVqA=;
	b=YPepxXzqeIZTOCAKuQgmmlz3aFc8MgwKS3opFLj40M16lBD6uU0DBIRSApeERKE3Rz4+
	 M5BBsBgAsJxXzSpXGMX506Kiak3SuA54YdeAWXgQwDblMPC2iv9Fg3fVrLO0rMvzPnMlt
	 V5BiQ5/A9XIdtEmHTgcqvCJKujiuCtrMBfaAN/CzTxzyObWCI9tdoukP6WU3r/3ZjIqE3
	 p6MdQtNK+0MRO4egaf9ghjSkml0HDIx29hxMjjaYs1z233/y2MAUlEhwQDMr2REg9Wol7
	 yVydV3/gunTz+eTEDLY8u51O3g2N7hGaC7NhlkE4GTroeHkgQIkjSIsIZl7PimEhp7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=bnPlrbv1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E493606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 05:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E493606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=bnPlrbv1
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so48755445e9.2
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 21:50:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795585808; cv=none;
        d=google.com; s=arc-20260327;
        b=l8EWtASdHLoZOQHNJrSX5yHdt0rAhv99/34W+QKzU8mLf/wx/d0luW/KsamtI1J6lL
         ROmpDXIUYdP9ATRPGlNmtSiivI3DYqv14itA6q3Agvw5mNpAQNb9zamwabyqoCJnN+cC
         MIAkLeBida1X8DgCfq8TaRz5wiM5C5yzFfkl0Wmi7zCKI9S73d54wSLTluNRNTcWy61L
         aCwqKsD43wuzT1rIOKFKAQo1A8K87dW06CXP+oMe6q3WYQrbVbD/4v+78UDym1AOr/V+
         Gi4/vDzzvBqir/huiqCcVWuIH5MipgdWk02k4BFf2ftn633OCJyqKAUQSBkDtw3icyaF
         RCdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BpPvj0nWvmhIzxo1GF3DFVFg+7nJdo/Em/Vn4/tSVqA=;
        fh=K/oGyomqIVA6bmESAaDublbRoVzSA0ERjUhkAIZEiME=;
        b=BQM6nNuvPV6sQakx4YE0heOFNHWrCexR6idVsqe3YMBWUliMbjhA73u55gTYRCYLaK
         kkEFOdx5AIRfdvvbpywX4KLtB5/+QmTi0kVwFV35t6rQqjA5gQyWzZT37FRZNbp196rC
         S8HRDyYMkpP3qNjajy+VthZpNv/eKUN1sc67XxBpdms/76SFGmrIl2P/Xdxkz70uHIFQ
         4k8Dq6P7TlDDvRGu9zjh9q5bVPJznwG4G0+WWAJEcLKStgPZlEtpCVwssijM2K9qFz+e
         jz4kXxMxIQLvXiEwIlbSwjtOB4WZtwhwV8+oVGIXt7w8A4/0TGZl1Tn8aj5Vfvtp6nbT
         CF8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1795585808; x=1796190608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BpPvj0nWvmhIzxo1GF3DFVFg+7nJdo/Em/Vn4/tSVqA=;
        b=bnPlrbv1Tv2qN6z8HRl2pjw0ILggVDP3fGye9E4RcaEqVAyd6WJ2hZuKVSJox+Ib6j
         bKAdNeAmqlzWvrtedLIBnqiFdzbGX9EfvOs+7gv0/isLfXRdFyGkZedi/twgEMXA0e18
         TGZEnt8CdPla6Blyz8WrbwVVywXMTn6Re8PBoVzAFOjgC+Cgc+dyoktfsLvl6c+pXPAX
         WehEviufV1a9aUiTNzGhG5EYHC8m74yQQoj8VfDVAATuUiI4xf0GVJMNReINdqOy8hha
         AxOWsSHncbnt7Uzzb88b7uDyLkyYvD4z7RbB7+2iqhxU6nLWEo2hZd9TK2uddYvxk2X5
         QOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795585808; x=1796190608;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BpPvj0nWvmhIzxo1GF3DFVFg+7nJdo/Em/Vn4/tSVqA=;
        b=mshoh2f7zsDIUYOEbnhHbw2VzCWsrfsEJKu1z4OKPD2fwuaMMD3Z3HyDIIojnFbhOv
         AhGpUNfzLzA1PiKJyZZKwarvHB5Cfy9DbXywiB0yH9tcIKYPOr7YQAAo8zVTjNIb99d4
         diEqrg/7IGFu/nBBJ+c+EL3Ia8yfPF5sIPjXinftq9Xo4isifQbQvkZMhfgfyqRtFBso
         StTaPDsgOkVbUU+mXrxUrsjFMlrJ/gOJFoq/kjyejOxryPd9Hcf1kYTwcWCqqwb/0ivp
         39sU75npv/R1qG+zK/HMoJdt3wGlU9E9a+sqsp0M9T75PZ9xXKcLbbYk0ahgpRTL9H37
         kJ/A==
X-Forwarded-Encrypted: i=1; AL+hErEw+fYL0bE0TwLIx6W8+PFoIHJF6v8eD9fikmPoeNBpGKI9rW2kMmSpKwQH1qK5V7SklmY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UXSD9kESYihaFeYCfl2KL7iVuzRDwtsfpx0UYJ3AFD0nClGJY
	Ch0rXh/ITe6dU7nM3RE7capS3o/JpgtqYcjIjqIY+NgX8vBsMFMDHCoUb09sQtWnlZbWByrwDyv
	q2gwV9o+FUSzgwRvHll2KoCIWN7UngP46L9Ib+506cw==
X-Gm-Gg: AZFdTZeEJUEpDfTs6nIcMN6LBc4iR2x5NPBXOIhd33cunVeZveF5xzB3AyIuGVpXCod
	WFTbfAQqfMG3Cv+4j0N2xl5yefPXnTEiuI2sjEVp/ivqFz57m93nq0ehttFuipCo15YWN64jpV7
	T5n2kY7hL7cieCU3uCvI1vt/fvdFFeLWFH1ZkZDiVo7d9jKjbiVhOzuuexejqvlk2K7rc+lJeXf
	2tqaFhEqw+itX2oE2zEqqn6Cy3c11RjBZro/Zlztdn0a9gg6DupsjGWMd4jJyDopp70wgEJElb/
	IWIlwcLiElkQLNCQ1gx6eXTkVvMmG5w9WwGkRc3Q9bJ8rN8NilMKRhWmM5XqoRGEvcHvoW/LIW4
	7/STXWX8R42/Nd9uJjjRFVgATZZWbd2GIxWhrU3xBqSpqX28D3cvuJ6/Oop/KpL9LRAdDB+ysdS
	Bxq7G7BbKhBC9L+UrxmNDRM0iDl8lI4VckmCaTsw95l/M4biUBfNcwz18=
X-Received: by 2002:a05:600c:1d29:b0:4a9:2a92:231f with SMTP id
 5b1f17b1804b1-4bb88804d4dmr362487905e9.7.1795585808512; Tue, 24 Nov 2026
 21:50:08 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260921111402.120911-1-suunj1331@gmail.com> <20260921111402.120911-4-suunj1331@gmail.com>
In-Reply-To: <20260921111402.120911-4-suunj1331@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 25 Nov 2026 11:19:56 +0530
X-Gm-Features: Aa3M54olVHavWeAlguF4P6c6438TRdv0cvM9VsXLh3lRZmC_JVPz05hHC99ALdY
Message-ID: <CAAhSdy0Ev2MKxS6J1OrD+mHKMw-izwi5ywHLJZT4fN0K-U-CHw@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] KVM: riscv: Write-protect G-stage PTEs atomically
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Jinyu Tang <tjytimi@163.com>, 
	Wang Yechao <wang.yechao255@zte.com.cn>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 4:44=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.com>=
 wrote:
>
> GSTAGE_OP_WP clears the W bit with a read-modify-write of the entire
> PTE. Lockless aging can concurrently clear the Accessed bit, allowing
> write-protection to overwrite the update with a stale PTE value.
>
> Clear W atomically with test_and_clear_bit() so that concurrent
> Accessed-bit updates are preserved. Its return value also preserves
> the existing behavior of requesting a TLB flush only when W was
> actually cleared.
>
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
