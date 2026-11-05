Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793922773;
	b=NecooB5c0oyL//UIhPdKi6MJsIm+b6pPUVzpptyCG2r33eq8AxIb95q+Nmk9Cb4evRmj
	 AXI4KBp9NfoT8ecqSWCSzWBhDoGD1j7l2Q1xIPckkwFhRLdLGImhJEAVDn5hW/UwmOq4i
	 fUVJerqGg6geYCXqF4pz4daSvPIuiop0mVwVnK35dSesKSVHgTDnYwtfV843rt8yiXo2y
	 M7cXErkc5l9o55oSzrReSWwZTACFeYCJPnfLAJwnsRqcIO3y1VbmMEQ6FY3M1R7t4kx9c
	 DRy3cNoste8Tv2Q0+oqySCoY5eN4NDjAR+sx9hR4C3Sz9MXnzhfN8/6FWD0D6lRAtfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gyTUMZMCRBB3NFufCxWmPinuLT4dvHJtRVbeflStz44=;
	b=1KtGfvPtImHGuAeXuyADHxo8Dh2MQ9u6y1kpGM2nMAEhfHceTqdwxqOwCZwn7CxZSHG3
	 AYN+yKNqnydqoSf9JCPoh/Ca2RaNEbu87A5V0hnkoFDLDt+ObPUMADZcBPU5vK1dd+VwM
	 /PHcqSmO9i4CktIbeltpt2kZ6IunsCHx9eQIfGAQwVZB4grR11j690x0qKnLbHlGyphAP
	 MMvFwquwGbxCnBoqSA/WutS6Tg7Wgs6QO+cZ7SVW98m5gnB/6Jp2d1VRBtmTNU5xE5xQX
	 iGvl13l9FVevCRNsRRPeF9GX16JLLBXjCV+IfWrgScFgl6E69+1T90GnaAI3pzZLvKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h2dtoYhn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5724A606A31B
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5724A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h2dtoYhn
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso2130a12.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:52:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793922772; cv=none;
        d=google.com; s=arc-20260327;
        b=GLFk0PMIiMujJ51b15eNuTG/AbvQJ/2hm3XtfiTHRtQAp6eGpbZwDgnG+2fDk4p2O5
         kcaIBpHoYMkC1Ma1LGU7EuCqJ9AbWL3A6aJjSZF3fP5hd+hKS2SdZfVWovY/qQa8/vfs
         QMgWalzbZ8ACZAEyc7gIif2OdW5O7NGNDk4CL8XM7Qx/B/vLTBIwZeRLgK9eEU4vrM61
         nltryDvVkNrVDKPSPDkChcRbi3577it/EhRj+KWA4omkxlYSU7sNEMnLaHohGjgLs3yR
         O8zIfIXRhGpKE0yl4I92smwTM0DjTxIO5tJB0LAtOniptrxWrF3p/0F/IaiHhlhlLuN+
         pSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gyTUMZMCRBB3NFufCxWmPinuLT4dvHJtRVbeflStz44=;
        fh=TkKB+rzmOzA0711OZa/kwgLH9vRwpmfzaY2bG/491tY=;
        b=Sl+aVFr6K8lLhJKEPnml2lDdJCz1bnLnCaN2eLxKQ6ozLrKFNlhnx2K/SXqhOahZHn
         AkO2ciMUmu2pikGEcXSvxvssWEl1DuLj4+zUhVqSIshC1BeBzHRb0bYbkWx+85iOkflo
         /v0aJaQWZ5UJgV3oe0L/pozPX1Y27TuwccttH9zbjOR5hMmtERietl/O0JbmDruK6M+X
         gEFpI8le6miBUp3bxauN5RXODRofECIlTt+ShiTOCOwydqd/c5wH821nYs7IhPrlS/Dj
         LhTHAY6AcEwPbt/6iiqkh22mvvmY8nmmQ7Fpnz4+sNp61zMBPD6AyiAUIDKGUaI5Yihs
         RZcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793922772; x=1794527572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gyTUMZMCRBB3NFufCxWmPinuLT4dvHJtRVbeflStz44=;
        b=h2dtoYhn7JloPa+v0QpM3KuxwFVtrCd9gU1Q15Yod2dQLNvhwTdBTwtW46BbJMwBIk
         6FM2Xp4GTJbYHGjAgt/y+fGgkMiEULt1cBwH18pBa9xW+M96YrrSi3Ab4EgeGgPwwYEm
         NUFyPkcrWugPXd+BhWfUG2txfEF7u9EZ5EQIQ8bDhKblqdQX8/urD5awRFh+PcnkVlh2
         64WjEUBzmBIDoiDP0YQiwB9qkhevf3Ivq20P8Icx42dvimDvG9wd3XKVFHanIzNEuk88
         /ultylEwcwm8i25T4QJ1Tb99cBeCokW2wBRgLVF2+Yv30LwJ/pbj1yL8bevA3rLj1lmw
         E5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922772; x=1794527572;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gyTUMZMCRBB3NFufCxWmPinuLT4dvHJtRVbeflStz44=;
        b=FfNa3IFIIppyR9zwIKBwSetnHFIrqUKgN++hRG8wNDTZ+5XA8Ajay0DJktyOO66J5u
         nCuee8lUmSf/Ry0AQ+IK4vbyDMvYbAmMIYlR69c60pj42KXxtYL3Uh/ueCGTcHK8quRL
         wO1AJo2oRqooP3H9r7afbGsoeUKU7jzIACRsPDiy9HtzQNb3SJJApQZywOG6so2aDpoe
         WEfhtboXFKyCC+hgHdxXGpROptBQL1EF6j2OJ8MMCK+hrJoke5Xsqd4EzthQOcQma2Ou
         5N8xTmfFuE19x07eoUUkcum5cptMuAA4V0xq5+OO5v3oVtqpQB3Vf2khG4pJl1yemMmg
         8y2w==
X-Forwarded-Encrypted: i=1; AKwUvByj3lR1VVAS8yuOWZhuyQ314BU0QeWzAgadhHpUXDK7ZwFJ1y/ybFeR0eHvoO76lrORMZU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qhxYpF4p10PNdd6Doc2mEodQvr2TjCXOWi2hGmOFkqtZ+OYOY
	WT1UT+Q1Cbc9WwuwsvWvLsjPpnnAy4DVHJuk3eH8/7OGSBiEs6s4KMjBepd7MYnaTsJmh3A2RMD
	nHhFMp+dGMJn+R6L4iANli3gPZWBflxthnhcLhQp6
X-Gm-Gg: AYBFou2+/nnPf8ZfbEl/6MXoGiINDGNwPH2wQdTNGFdoshvpmb/eyXK89p653WAoHPW
	KJnuIapEQj2x73Q7RBnEy549xFiD+p43kbGAch+xvcNE/0SnzKzGPQeG6qCmCQr9A8xKXMRZ6f+
	wDw5AmdUhG20B8Oh8WbUzT/a3LkpTuX3aGoq4XeidkZG5VRSE9PCKXTtp7w70Vj8woZNi7jZeI6
	kwGtv8ql1A5MMAaarCgPS3CTSNfkQlEBxecfz7628H7SF6Wt3xOuS0z/hFPDqpdYQaDrrCaqWIF
	T2FnQdmztv2n2KjK03FCuZ0Avp9mlFiXewRvi6ZR2GLvWfdge99dAKgNw4zMOunHKX5rQvOETf4
	REPuzfARnYlftl7vnq1jpxPvFEDveZk/ED/T1sbiHjL5lb/pJV6IqjWdMYOKefoDoyhBmqAjnck
	UkTDr9cdRoVN144+9YVB4zd9I+
X-Received: by 2002:aa7:d958:0:b0:6b5:77a4:e7c9 with SMTP id
 4fb4d7f45d1cf-6b597591551mr33247a12.2.1793922770998; Thu, 05 Nov 2026
 15:52:50 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-3-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-3-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 15:52:39 -0800
X-Gm-Features: AclHuK_hZNLLfvoDKX-PNoVckk9K3ZWiYV2R_2Vomf-6kb2jS7CQyCf_jEgvZW0
Message-ID: <CALMp9eQibSk_SOG4GBybgMd=uOwjVfjLsx+Hxsm2thg-qwNBDA@mail.gmail.com>
Subject: Re: [PATCH v8 02/20] KVM: VMX: Save guest EGPRs in VCPU cache
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:35=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> Save and restore the guest EGPRs on VM exit/entry if the system supports
> Advanced Performance Extensions (APX).
>
> There are two possible ways of handling EGPR accesses: reading them from
> the processor lazily, or switching them in the vmentry/vmexit path and
> accessing them via vcpu->arch.regs.  Prepare for the latter; it does not
> pollute kvm_reg_read/write() with conditionals to treat GPRs vs. EGPRs
> differently, and it allows for future usage of APX registers in the
> kernel.
>
> KVM intercepts all XCR0 writes, therefore XCR0 cannot change during the
> execution of VMLAUNCH/VMRESUME. Thus, for a guest that does not set
> XCR0[APX], the EGPR state does not have to be loaded/saved.
>
> The register saving path is placed after SPEC_CTRL is restored, so as
> to avoid any mis-speculation into EGPR accesses when APX is disabled.
>
> While saving may be skipped on VM-Fail, it is not worth the added
> complication for a slow path.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Link: https://lore.kernel.org/adPRA4ZhnvbaXSn0@google.com
Reviewed-by: Jim Mattson <jmattson@google.com>
