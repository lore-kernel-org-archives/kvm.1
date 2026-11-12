Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794442551;
	b=1BbUTyb9iaaK1S/mWO5ke7SVH/+tPoEXkWpWA2J58n7lBDUdwOee0h4gmyCidHJeXlDu
	 Jh5mLx52ctzkke1u87Vq2++s5y3H+6jyZWJiEPO8La9v8sNGc0wMBr1GSb/ZqGJ1DkXO5
	 UwusVSTeL/Gpg/qZ/MPOhHC1pTBGi8S1zQhhvUh0+QzgxoMYfT46p/EpXYctRO7ImMii6
	 8ElQYo577YAERb9JykUEeN7ZJmIHPsKpWz7Bbln7MufjXv68ywgr5XzEY1LSt/Maht9Iz
	 TnFlrVPHSGRqYwP5JXnrsyKKJtUt7g4NDjB9ZGvY0royAawqiMe9olj0hcFKLVjTsWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lUkgOmlD1qUG4Wcz7+Mcimn61fdye0spBX22Tw8NSx4=;
	b=qGrR3Kxezw8bucXv7M4DDDuVoamu770ALuQnJxyVSDv/K6jokbHVuzIk2xftdwLJo96S
	 5t8sMDf0P7z8kL6EMvIDmIf8cbV4CZd7+7DQZnFMsegz/RmfSj4E9sbqHhmo5CJNrwoYK
	 GiKYHBj+RiRiZXDlbxex4nZAguTDXFZHawGSNFBKdkv+qmXEUAyizduv01Oxp2RGsHhz/
	 w97OCE4gwerw2IhkGWt2hpNzQZWA7QKmO80HuklHhOZneJBGJKrJM1b3WgpXGLzICJ5g7
	 l7uC0y2zJSgqPhrDiItTZTyErEC61qVRlKWx9Yt00+qm7es0TwUwoQM1ziEV/UCUx4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="e/GCmCMI";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8732B606A324
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 00:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8732B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e/GCmCMI
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso2648a12.0
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 16:15:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794442550; cv=none;
        d=google.com; s=arc-20260327;
        b=Yp9Ph855i48iiWsl+gxqoYBAzhtKm5MWB5kOqG2VbqU5MkInXN3Ia3z4Z3xU52g9rc
         obFiqk9OdmZFNM8tz0WxvHi0WjvL7eizBLyKoPV9b1bv6HmdyNv0s0ikVuLkrDa0+wWj
         5y3PPOIaYkwoyONZtz5a14Bt9BZYELq3Y9qwbdzrNQsVExhBPFep5VjSvgUJlOcKrHYE
         YGn/z7LAC5USdCthmT9Pgjz3UcqMvHQnfyM3H9YoSBe715MhfBnbHxVxHFGC7aYaUib9
         hf/lPVus+OoHmzwnAP5NKKChjkO9KCS5g716pihByBZqYDEnG19FkCkP0mWtFNww52RI
         KVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lUkgOmlD1qUG4Wcz7+Mcimn61fdye0spBX22Tw8NSx4=;
        fh=KkZyjnn8jNIY2KtpxPhtjHIu5snE3PC80no3XdliwTQ=;
        b=PPDLw+X9Jy9ArNZBywKt3cEbcbQZFWZfBxrrOYPx6PK+dFPxejxYIc5CuePGFGfYcL
         yDuyR9Vp5r9EnoZB552evoqXX7y1O4rmDefju32JA3xRn6cRS58orZXvmcvSxqGX6Huv
         4gM4UUx7Rp24t58v1pKxBXeLEKied4UyE+R6W6Y8XnqmqvM5vKeruXpCg4Ya88g96rIa
         N2tOplWWKfmwxaPxCdELoYxnb/36gjLpQLAACQ9GAxnvabKMEI3aX3H92c1/GJWWp4vT
         oqbC3cML/FMe2cwJ5W94D0AxDWxhO/dn/61FUsjLrViq8xOhMy/YUFNmJEAhSlY+niXR
         zWgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794442550; x=1795047350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lUkgOmlD1qUG4Wcz7+Mcimn61fdye0spBX22Tw8NSx4=;
        b=e/GCmCMIh4d3cfq8R1z1xxauNFqtbohTNeCEpyA19Yeg8mtFZCVDn/8EpuaaxSQ2xV
         vbBPGzblo68RCg3AECof9kmex4/J+VkyTceo9nXKl6ACTagIa56x3pIFlQdvJ3TNGEKV
         lbW0PupZKpfTcaVvlxLyKn/NapgwIsK/dqB+YbvYIZtvioZ8buwyH3+bLAfsucQXI4mP
         XA1sVxTtDdszEIWtwZdBE6ccZnwWR5v3EHoerhw3iMc3XDdHWQwbBsHwXHbE5yH02AyD
         +XHfAVQ4L0fgwTbvzK7l1u6kW1g2ilWhONad9skjTyXj4xOpTwvt4tcoOFji34EMS49j
         8l8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442550; x=1795047350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lUkgOmlD1qUG4Wcz7+Mcimn61fdye0spBX22Tw8NSx4=;
        b=Q+2dSq1lUKI7m6vSjornoqAXZgT6/EhQVAvgZlWduoAWMZMNvKL+U550U5dPJUB9wQ
         6pUFN7+8D5l368VCTfJFfGEEDqG2Vh4HzBzt0Zh3a7pnDpRNjNT+2Tk8imOH+tmjNSpK
         I/5ZpCqd/amHHsfndnWWJvG8KiLLlEi57sDteUA6YyUYqqFj0fcwqjze1IMOVYhSeerw
         1j4MLzEHFc9A70CwfPUlgXwPQGTjVofFny+pK4mAuOuMxtMqA6dYkkF2HSuwpbemuu1c
         C76XW/dftc3ATKy/Jij5G+o00Gqziw8UruBZISaMvmCYgzeUscOzFJ8TTH2ZoOIVRm3M
         JHJQ==
X-Forwarded-Encrypted: i=1; AL+hErH5whO0on3xe1ixbrXpreRuvxNVjRdy5B2f9MhLe1Rcp1S47MWxcU+jn/csNZqZzq25rAg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Oh03OOoj38HTdQ/wnLIFJH2Sg956UA1UpzXW2926e5vt+BTkb
	u/tl3gAA/5m2gQuNalJMSWveQrbqQOu7UAT52KgGVNygJKYDiBOTQPSPXozmXK8EffvMh7vBHN2
	hlEq18Anb3DPjLPqRJTJGn+QXaXWjTw89hPp47NT3
X-Gm-Gg: AYBFou3VQGeItXC8SRXb8592FzQLLuIXVA4xciLhmsbzt28iKBcgU78iaeRJwKWOJY0
	B5nwaEkK/LWOzZtsmQo2eZZNSeywcmrKfJSYNrQfcsy2u5gEQR7H/eRnNlnYSycjStUu1sLFCqX
	xr7oqSoIUob5G6fO2hGHFgfj1CX+nrEDBBxT4IYJZwSKJcfLfvyGbd+cpj6B6zs0oBJXrePEGGb
	3McgHruRDj8olUsPVrMh0248ReeZR7Bcy3y+mAKvcPK1wPnjdjtGaJAm3D1Dph6hs8VybkU36gF
	d4pJLnQUusfQvMcwOGLTSjCbW8rkGoId3MNFoRu7sF3gsHbYpUqAj7TI+FvmDEnp5LdmL2SaEV8
	KxZzDwNnHhP6VwnC0NbhMRy576EcMMj25BMi+bnHW8UnBW7vMOMXgtwxQJBKiYgb0VwNCEtjy+g
	==
X-Received: by 2002:aa7:c242:0:b0:6af:afce:184f with SMTP id
 4fb4d7f45d1cf-6b79f5c8602mr22296a12.3.1794442549332; Wed, 11 Nov 2026
 16:15:49 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794374897.git.zack.rusin@broadcom.com> <f58eca0b702b6e57d87ca367a7693793e619d3d1.1794374897.git.zack.rusin@broadcom.com>
In-Reply-To: <f58eca0b702b6e57d87ca367a7693793e619d3d1.1794374897.git.zack.rusin@broadcom.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 11 Nov 2026 16:15:37 -0800
X-Gm-Features: AclHuK8BRDjHRWgUjUQI_bBfAQydWugPH1spbS9sNXXgu0pmOPALjqQkmfs2iVc
Message-ID: <CALMp9eTcUkG6wUaZXHSsGmz9Rm=MwYgrA8DfCuwUV1c1Hp_f=A@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] KVM: x86: Add CONFIG_KVM_VMWARE
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Doug Covelli <doug.covelli@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, Xin Li <xin@zytor.com>, 
	Francesco Lavra <flavra@baylibre.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Liran Alon <liran.alon@oracle.com>, Arbel Moshe <arbel.moshe@oracle.com>, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 10:07=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.co=
m> wrote:
>
> Add CONFIG_KVM_VMWARE, defaulting to "y", to control whether KVM's
> VMware emulation is built.  When it is disabled, vmware.o isn't built,
> the VMware predicates are compile-time false, and the
> enable_vmware_backdoor module parameter doesn't exist: a
> kvm.enable_vmware_backdoor setting is ignored, and modprobe warns about
> an unknown parameter.
>
> VMware emulation is only useful to VMware-aware guests and to VMMs that
> offer VMware compatibility.  Let kernels that don't need it, e.g. to
> reduce the attack surface exposed to guests, leave it out, as they can
> already do for Hyper-V and Xen emulation.  Default to "y" so that
> existing configurations keep the backdoor and its module parameter.
>
> Provide __always_inline stubs for the predicates that gate VMware
> behavior, so that callers need no #ifdefs and the compiler drops the
> dead branches.  Leave the operations behind the predicates declared but
> undefined when the option is disabled: a call that isn't guarded by a
> predicate then fails to link instead of silently doing nothing.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Link: https://lore.kernel.org/r/Zy0__5YB9F5d0eZn@google.com
> Link: https://lore.kernel.org/r/e3f943a7-a40a-45cb-b0d9-e3ed58344d8b@redh=
at.com
> Link: https://lore.kernel.org/r/aIEmawm9gLflg8zt@google.com
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
 Reviewed-by: Jim Mattson <jmattson@google.com>
