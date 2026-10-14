Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA03D6CCF
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792020953; cv=pass; b=e9/SEHA/SO1mKtaUVNLce3Cugb3M24FtHqw6gxN69R2VLP9Gq1ecaIvLqbWJ0rsxxazvo6DN8sy4GF5HBPoofkSPtvLf2YjEstEQIZg8jk9ekFx2IIcd7ZTP2p92IXQUo0wcg8eo3gqVyNmEc0iBzwyUzY/2aUbhOCsjunYZvFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792020953; c=relaxed/simple;
	bh=0yKhwzqNgG/9SN/cpZkK6K7qmkrl/RC/A3uF/TuJVLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKeIDOUj/rm1TvV1vxsI5SsSz1TCGE77EtVmB4l1M0tKap0cfZrbFmPhPNnwjlylTEwuLJwIEgfkrBrHrEbFvrbEFR1dOJxc3xP3VNKkMd7Sn04barM6FB+FZkCFi5UcE+Hfy7B1jdpUv6LMZ8BZN818KACJFdzZdSFabmknBCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pMOkPojq; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pMOkPojq"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso1165a12.0
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 16:35:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792020951; cv=none;
        d=google.com; s=arc-20260327;
        b=RuQphvUj2TCNBlkCnerDsFYaRDE3XGldF3DYypEYyv7fv/BEry/AglcrOzqBw/rTks
         u5AXWPEtc4p//2tN4t1DWH20yi7JHFQTBOc8w7c20241JzM38K3IujnC8bpYP7z+mg1g
         gM+W+1J00QOs0a/H7eQm2pSWe3q/znCOcOzE7FwI99ptP12mttok38LaiV04WgAeEWF+
         6fot0cCqG9/OWYbi0nZJgnjmx/lO2LxKrtx4l0HUXSt56yy0b2CHhy3Bws073urhf0js
         1K10ylaEcqFI+/h108GX9sdBA6a8ZF6Js97B60htXlAoM/uEvpgkHBXRLADsXIV7Ly7k
         ZfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0yKhwzqNgG/9SN/cpZkK6K7qmkrl/RC/A3uF/TuJVLI=;
        fh=o1OZt/7jWXKnFydvM4UDmL4c5itllRE/x/Xm5yFuegY=;
        b=fMcrcUwK3LRWP0B896U8bG7byjdP+ixmb4wlLUdxAw3grBbIhAGDotQmeBZFIQSbfQ
         6Rn+q8Th4MUkInT5En8Os2CdpCWt9uHXHrLPyGCDO5TN+S7LyWswnwFGIs0bgCRjw1X/
         sec/UET0tdItXfRWtn+WZsfpuJzLyQaAQClxlSJcbs7lhqahdHlVgGwTxfrVQ49XJjiP
         p8Pkrigyn52Vb2zDYY9eISRafZBQ48xz3O0GGK+ZJGtahV7Hrdsuzsx3qoWTcNIxSva1
         LqBbghyWgkUbslKRVSf0/EqlQ9BHyRL3A4Xn7YJXmMPDpbqYOPQYHeWjNUdIztMVSUa3
         2wVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792020951; x=1792625751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0yKhwzqNgG/9SN/cpZkK6K7qmkrl/RC/A3uF/TuJVLI=;
        b=pMOkPojqivPh9Tx3iAbYQvyofZxKnOLlzLDo9j6tEYPbuABURRdrv4oLu16N+wsZ9J
         OLJsr+56wogXCRAnChTBQo77H/ycfImmJrJdc67P4zyVPa5cYbKpvXwVf4Ne/skCRQdm
         IkNHyUKMx6nh285tdLK8hjlIrTuMB8+W8TIycW9sdidlboaPwmtqfzl7JJ2NKBIowqTQ
         /ABi7u/i5e3ROd/FHvHYBf1aKiochyWyvt5BY+RqRHDOXgTrSzA8xgOXfcFgikVZHoNE
         U0TVbchnujQAPK5qMzE28D79iuPFkIcklBXnMkVF7v69qz1ufiCdpwe7939JJi2D2Paf
         lvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792020951; x=1792625751;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0yKhwzqNgG/9SN/cpZkK6K7qmkrl/RC/A3uF/TuJVLI=;
        b=OIpKwNkxJH+jidkYy5BbiYWv13OD7zoBXCwvwTtEob6ZTiu0LqzyDFmHXAml/SkWqH
         XWTrw9SJiT2Pca8edjGdFxsH+xj43Hpo/B44sHKC3GqdPtrfCG4FVO3bgeMvKGuHNL5k
         PSrSAV2peXTXQf0ut2ypq2fnGXoFZqL9U34M/RDNSZ1eR98SLxvvC7I1QngpRaZANoV2
         CPVnrC+1Ukh76X4ivB69H+u2Oz/ciUxK9r8KISak4l4iHQXXv0iE5xCSNayOKP7wEEVd
         7oQ01PGHcr9gfneBXx/0ZcS+KdPiym7vMpunAZEUF6kfMrOiVxYOZEUW9Q1mNgdtyjZH
         OLWg==
X-Forwarded-Encrypted: i=1; AKwUvBw0uxteu1BcGd3n132alEZlrqu1Td5P53siiDNUOLUl47tUJlWCaUbyEmreiBbK+nOo+2I=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6iixtQE6lyxffQzpEMPw1uR3bpseJXexpYgCjmC8mIh1yILFf
	9Rl1onpKP31nOyCxraqOcOr4aI8oypx4mOKuQMEl0xZQWcOF4ThUy65krBysXRMpdHhxsCjifmO
	1jwn0uaGiUVSm4k63/NB/lxnLSI5/K0vRfkdUm3WXKrrA2H8m30CHQ350
X-Gm-Gg: AYBFou1qwnHRXMHmusHDTuk4CNF6BxalwB9Q2/apf1VsRpKsoWM4k8f3BPoVj7AdAzo
	ghE1uQ51iQF2RLoUgDiayK8nhny1AcR835FciaiKaUD06hjTwevVMt76qCL72g2XZC68Y71EleK
	W8UTl3m6102hz1Ny3LOwRWuHhKynADcprSIZ81P85vbjVKjTweZvXt3VriY1tLscdetT1etYg9Y
	X1ev31nrkxKcTNxJg/3duWCtvVEoLQLHC+Pmn0Sibz2Sq+yoGloJtEEF7dO9Ra0ZotTbYfLePgK
	P89dd+D9AKzZK+dxGcynudHf35iwwCTu93e/NXB85anOksChlR2vUCY=
X-Received: by 2002:a05:6402:20c5:20b0:6b1:bc48:2238 with SMTP id
 4fb4d7f45d1cf-6b333845c12mr1302a12.11.1792020950237; Wed, 14 Oct 2026
 16:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-10-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-10-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 16:35:37 -0700
X-Gm-Features: AclHuK_FXjJZ3HVfOv9pAjNjOL2oKXm2cI4TAVw_4LY2M-i3V-HQJYD81Lzkplk
Message-ID: <CALMp9eSJThPYPrmtnu1kQ13Pq4V=heMNj9PCJLng0nXuC+28pw@mail.gmail.com>
Subject: Re: [PATCH v3 09/27] KVM: SEV: Explicitly initialize the per vCPU
 ASID on SEV VM migration
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Explicitly initialize svm->asid on the destination vCPUs as part of SEV
> VM migration, before calling sev_init_vmcb() to make sure the per-vCPU
> ASID is initialized before the VMCB. This is currently unnecessary as
> sev_init_vmcb() initializes the per-vCPU ASID anyway, but will be needed
> when the ASID initialization is moved to vCPU creation.
>
> Add a helper function for the ASID migration as more changes will be
> needed with incoming changes.
>
> Note that svm->asid is left as-is on the source vCPUs, even though the
> ASID now belongs to the destination VM. Clearing it would be a nice
> hardening measure, but it is not as simple as clearing src_svm->asid, as
> the source and destination VMs do not necessarily have the same number
> of vCPUs (e.g. for non SEV-ES), so NULL-handling would be needed in a
> couple of places. Leave it alone for now.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
