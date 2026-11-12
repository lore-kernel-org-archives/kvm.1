Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794442511;
	b=jpCPzim6QvpFJkmt4RSksLUpLzIJTvRIUyJR66VxLPaS1talBPQU4ZhEmZXdBh2wydNa
	 1bnFlBS/vdESjiunvR+duw7sI2j1ac+ARTU/WvFk8G2o65o3hnorIb1uWFgTe7AkIiY2H
	 0gnU1nz+WjlwrGXIyihKHlh7T14YayTaWVfx73bFyL28X+FHNRNIe6+/yrbFhNitkllnc
	 ORaz6AzB4pzDyisILQxacSQ3vUrrVtx6jgMYl0Yc+W3+h+MtYOKBnooBPHDQ2nWKfp/8Y
	 zgNBtNtP/ZFC6fC2SJO5IVMc71iScSRmAr/MoO8N2IjxcCJUI1MDNAjx+p4nSF5EibQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dw1WUYLsTA9Q/qnezh21Fe6yq9ZjLtY8qDqIN1OSww0=;
	b=qYMkv5NCB56iPXY0NCzkJZzYqqYSjZSCv/n8zybdvGP51J67gldlZbJM8bosHf37CLUH
	 2v2dcp3x/rcvYxk299rGsPklv4wVYIKGDin0KJJRffuEElW5MQ6HYTC5T8NY5JS5x11CU
	 REr6qFcPSMMy3AMxEe5w9UBKI3H4H/iT8JOERp1ilntOnt+oXEMEAmAbQUfRg5vhjF7pv
	 PhpHpST5q9XJNMC04gxKTRjEnBpdwN6GKtmpql3THOAqmnnueWOBbqM/KDXd1rEAILLoE
	 Nw0lYb8DqdPDU52A1UkIzXUml2pWwfpQNR2+J/r8ra49IwbGew3um7/h6YzzstQY2tQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PeXxi254;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21FD606A33E
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 00:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C21FD606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PeXxi254
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso2628a12.0
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 16:15:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794442509; cv=none;
        d=google.com; s=arc-20260327;
        b=lX+9Tetb2sTz1LPZ5nX2r+X0dY6hHvAKuw1DAfVjDMS/mJ1ZejflDNRnb7GFYqddx5
         rOp/xw/kGoUNCtkl2CNPGcZQ48SAvFRkmE3LuzQKwzOXuHwehZVAOfnUG7nuA1Ajdj4q
         tQoku+VG8It3vMPL5wOxo8+af6qsS/MVL/rMZd/MNqHpo0Zc87M9lTaX8yGjAhpItWmC
         J9YSOXbKr+v8QIUEaZngQCGJYECEDg8B9tG9kUsozVhUZv8lG/KEl4Ko/O65yXFqzYp/
         29RWvas8VQ4cxT+FaKPkA2xaMgarfMgqSjJuXOiD6TExrCz2gq4VEL8ktEqRDPNoS9Pd
         NP1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dw1WUYLsTA9Q/qnezh21Fe6yq9ZjLtY8qDqIN1OSww0=;
        fh=hOuo8s/Oz3O7k30UAnx3NaCiD9/jvCLxkGVL1pGmtQQ=;
        b=I9ADfHaxbYhnyPzPMEqH1kwk0dOX/qvBXGl/9LEWEajuyAx19R6sQNXHwGsYG46iwt
         jbv8Ho5kK1Ju2THB8Gxwlw2pFiJ6VvHJkL90cFkMwUx2hFLA6VAwaxD6NtA34I2mTtCc
         ux29PCW4/Jy7veCHa3I2ejq6UNkbpeAezr/ePrYf+bWNRY+r3cOovGnE9DB51uHRrUJ1
         5z9352lSGcNCBkx2uKmj6cT7HHuVsmRbOelANjFgdpVlIiSv4PAZ+Li6OPxY60z8nS94
         sABOwnhjuPkG3R7Rw0KYWWP3Bz4ANXnY2xxbIWWWGIn7JguPuQWyMl6PoTBucovoiM+m
         0aJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794442509; x=1795047309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dw1WUYLsTA9Q/qnezh21Fe6yq9ZjLtY8qDqIN1OSww0=;
        b=PeXxi254jVjJacLsg6c1v/0BankO6tVHFh6AbYJLckSeraKvBRZxAmvwufFHuIVvYD
         jkbmKo+FCqg0SBryL3bUXvdBw51kokdvPo2t6gGxmjYdEHwSqQgDRMyLkfxw6Qp51+n6
         ds9EgQSzXH+7ac2mHfXsp4u1eSCMlEnVwNktB8TG93pvpqlbZBzyalG5b9BR63ygTWb1
         54jvVxknikvPOoIpc0TQ+p4Y/l5uIhkotGtCrINmedkhL7tPKuRHQebn+aYEdDwEO9WT
         RBjg4bOD2siCWSJ9hGnHGD2RvFWe4jctIyHb7Z/Vd8399Z05QaZSbFC2/xwSG/vqhQC/
         fReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442509; x=1795047309;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dw1WUYLsTA9Q/qnezh21Fe6yq9ZjLtY8qDqIN1OSww0=;
        b=FRnN51/FUXSuXSwPpcvYgV0OpwiZ7Z8f/OTXL3Z6cvPBDwyIaqhq3J91CKsr4hKChE
         ZosUnjgr3onfnyTsI0draTSVu1M2Wy6Mm4IZByZKY8VUhyleMinXS3/FJbUclWr2es5j
         C4AidLkIu+7VskfyWzy0S560piW/L5OBMZXW70k+NV8+P/LhtQoB1VFCTvac5at3hOY4
         UwlAab7Jnp4C9j/rZbDfUp9aIP7OlA6hZno47YPT0J+Cg78MUB8Xc4jnYYQJaL8BtU2t
         BwUx6SDARjilT4+Y1cf+1Ndcp+dqe8nwhsoQqagT+gfNYcXrPdMwNUCiTgciPHWkys62
         TuCw==
X-Forwarded-Encrypted: i=1; AL+hErHipRFuwdaPNjiTDQmUislp5fV/4Ruia6xTOs3o7LkBg/gI8wcEPXbGdeXXsLpLB1vRH7A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zlXfQZ50i9+gIwb1E6ewZ7Gs0Gvg3tku9Rr6MSHlHoakMRwTk
	MroyunNs3xeKoMTTQQiUB2rvTnApI0cHhvSrOrsBtgK3b6Lcwq7H30NlDTAHcZLkXs/8GNXhYl2
	GouYGZ8XYbXqVsk9VRBBCE6GkpYVXXOzUIWQHwVyu
X-Gm-Gg: AYBFou2wmsWxLr6xPodC4DGQRcmEvHuk58rOuwf82TK6q851/2uuUiKOnPnfvmiCSSF
	kFQJPiIFHSKJWwc50QIgStMkoSunKM6iY/mgChSQiBcqbnxrxmBoffSh3+m2wbZah1JqeUNxS6l
	L32q7XiyA2E1ctqglihzDeFhWP3ohftOL98DxVqvwFJinr/IP8PfGFUspcF7In6//Gnaq1lDNP+
	YBevsNKYcBBolQDf584eZ3WZjGfxeFMCs+wbSPmWVxnhxq9xnZ6nnNbSTWpgN9C7Vp8CM053Xkm
	7COp6ytzxu3HLQs6X0mvYqmIXqCx70B7asMXWpxK7Y9ljC9NqQlNRorqWxsZZSWJGp/EdgFR1+m
	w+p6MElgcPI32/AAx1H4RFJSh5zhXdWgmHi0m/Gxot5RH3GVDn7R/+QzSuhjSnmq2tNUt6MCvlJ
	T1IubmWzp+NhLo2cFQ4w==
X-Received: by 2002:a05:6402:a3cc:b0:6b1:b3bd:1576 with SMTP id
 4fb4d7f45d1cf-6b7a29ac02fmr15840a12.8.1794442508697; Wed, 11 Nov 2026
 16:15:08 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794374897.git.zack.rusin@broadcom.com> <76008acc660e337e7bbeab3310623a87046ac70d.1794374897.git.zack.rusin@broadcom.com>
In-Reply-To: <76008acc660e337e7bbeab3310623a87046ac70d.1794374897.git.zack.rusin@broadcom.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 11 Nov 2026 16:14:55 -0800
X-Gm-Features: AclHuK87L8uvSccN7ek3E-oclf6HfrUbptT1NvBilCQRrlrDsTQ4W7H0chAi-Kk
Message-ID: <CALMp9eQQG5U1JUbAiYBTaSRysux=F6VS8vra2KpJaEy=L6vBKw@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] KVM: x86: Encapsulate VMware backdoor checks
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

On Tue, Nov 10, 2026 at 10:08=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.co=
m> wrote:
>
> Add kvm_is_vmware_backdoor_enabled(), kvm_is_vmware_io_port(),
> kvm_is_vmware_backdoor_pmc() and kvm_is_vmware_backdoor_opcode(), and
> use them instead of checking enable_vmware_backdoor and the VMware port
> and pseudo-PMC numbers directly.  Make the module parameter and the
> pseudo-PMC numbers private to vmware.c, and take the backdoor port
> numbers from <asm/vmware.h> instead of keeping a second copy.
>
> The next patches make the backdoor a per-VM setting.  With every caller
> asking whether a vCPU accepts a VMware interface, instead of reading a
> global, that change stays inside vmware.c.
>
> Check the enabled state inside the port and pseudo-PMC predicates, so
> that no caller can treat a port or PMC index as VMware's for a VM that
> hasn't enabled the backdoor.
>
> No functional change intended.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Link: https://lore.kernel.org/r/aIEgVpjXDR0BXgHq@google.com
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
 Reviewed-by: Jim Mattson <jmattson@google.com>
