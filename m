Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185DF3AFB01
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684321; cv=none; b=oQzKCuT31OyDIXjBL7vW20Ip/7rpzuL1dd32nxtrioFMKVIhkjFJOfXgrKCmX1GOXgJVMA8EAAsbUivNUeH4K8ecrHTWba1TOgVm2aG7DCF3YLoZIOUgH/xB+zWLsAtJ5SIHVr5XMimNOk4Acx27YVowsFtXwLdqA9Vp1TXxfoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684321; c=relaxed/simple;
	bh=h1uO+UwCN9osMLlz+hsu6T9Tr14vL1WnClKmjxiFFls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rSB1HsqN1tHJUYmp5B1I8M6HhY8OB4fjEzmdkjCVtlWcCbylUo1iaRmu963Q1OUXWktsWWJ1yoppDeeDOY+beXNVoywInQgpoBZfXZxTyGoU6l3F53QI/SWsow5oiN1h839oNspHB6a379Y0uoICn3oT3+npb91VBctS5Tb+Vzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zvalsahq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zvalsahq"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d97a4e08fso2010487a91.0
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 11:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780684318; x=1781289118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMM/qVdN6yslCE4UmqUVSXzNE90XmcXlaODXcTeCPPo=;
        b=ZvalsahqAHYeWHmBtAwja1vBvPk4oXoublMzQkqRfPxYWfRVR0yxUjKlhdhEwYXngf
         gbX6dfUsdJuedFeIyXwfb7TrhHkDBDpKwaLwTFM12kxcX6VsD/wVMYw0lkOj7jprViRV
         Fts6PPHToUMDp7qcOG2JZdom6flnX1ZMlYy2+7CyTDHWF9zIY2KWKe+u0tcjfpYl97m3
         Mh6mwDSSGWSlQO81YyNZlnI3fzzPJhZW2I6//g8VsISYkfRojHfmbnWVudHyIzohCgTQ
         f3tBzrXvUFWM1f7TBJ/dK0yYlwAEHwBS7Yd3a6Htwz4rb9kL8oG5OpCr8rZs4sEXRfO7
         dvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684318; x=1781289118;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IMM/qVdN6yslCE4UmqUVSXzNE90XmcXlaODXcTeCPPo=;
        b=NuN7RIFFCeGy7zpeJEGxqtFA4LzaEGtQMmBC4KP+gzwDf7fwmu1G+eIeyNz0Da2Rmv
         MeBO4uhS65YHUxTuNd8QJjUx44BRd3p7II4MTbvLRdticDk/g7iDNSj1iDgGSaSFJxBH
         qX/FrO4tlSHDKCmN6HsDegJ2dnL2iIU0d7OnGZ5rq7z1uC1Phme5lHo/PpeXdM99YCGy
         CaaogfAcLRwMnoFezRyqoUXAZobUperMtq8OXkE+nsDw1AAjsdRaYZI6SVnvXJ6yLDIW
         dG1+fiRQw09HTu7QfllJSCGIinjRsS9RoKc4fFq/q53dqniW7ndWP039dBzwoM2INTxy
         opwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/EcqcOow85uL689xsyY4ea81ZaaD8j0z/Jcn8VPo736ks0BVeMfolkh/BtZP0w+KpGkrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl77f/zqllQJKrzJVoIA9+psTqdNr6U6UWYcE/1ZZypW/YXsho
	EUzgW+OSRl6IsTzM107odgKRujuxjmKDAg0jMVK9eX39GIpyczF/WSyEgvoBRspDNfI/w/NjAhR
	iLWxy+g==
X-Received: from pfbhx14.prod.google.com ([2002:a05:6a00:898e:b0:835:4568:a5a0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b:b0:367:bc89:546e
 with SMTP id 98e67ed59e1d1-370ef2ebe43mr5407314a91.12.1780684317996; Fri, 05
 Jun 2026 11:31:57 -0700 (PDT)
Date: Fri,  5 Jun 2026 11:31:41 -0700
In-Reply-To: <20260529140013.14925-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529140013.14925-2-clopez@suse.de>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <178068424104.2236513.15503873032757397710.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86: Take PIC lock on KVM_GET_IRQCHIP path
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, pbonzini@redhat.com, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "He, Qing" <qing.he@intel.com>, 
	"Yaozu (Eddie) Dong" <eddie.dong@intel.com>, Avi Kivity <avi@qumranet.com>, 
	Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 29 May 2026 16:00:14 +0200, Carlos L=C3=B3pez wrote:
> When userspace issues the KVM_SET_IRQCHIP ioctl to set the state of
> the PIC, kvm_vm_ioctl_set_irqchip() grabs @kvm->arch.vpic->lock before
> updating the state. However, the KVM_GET_IRQCHIP ioctl to retrieve the
> same PIC state does not grab such lock, potentially causing torn reads
> for userspace.
>=20
> Fix this by grabbing the lock on the read path.
>=20
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Take PIC lock on KVM_GET_IRQCHIP path
      https://github.com/kvm-x86/linux/commit/376e11855154

--
https://github.com/kvm-x86/linux/tree/next
