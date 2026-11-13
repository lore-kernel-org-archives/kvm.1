Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577787;
	b=s6MfJv0XZGTfhrhbeBo67RuJ0rKMoCwTK4oZS/W8dZnU0dUV8BUeai8N/EKrVRqUanXy
	 EQGilbIjlT8jikCMp1OJJfbjk8zHmVPwIv7v3Q/E/hEvkY3ERGfkeHp9gr6hUcUXx522U
	 9UW1LFfT2pxWjdba2CZrzwEBhb1W23ZSy3cj+Ur5DJUNlVnV91ez2vCrrEGrFmsVhl7fR
	 cNdv06oOC3NYzidpFz5iauGVERH4gCEsaPfe3w23vZu77BpMI/TnKfBGJ3AFXUmQ9ytej
	 u7kfd68IRiJIEt7uHsOump6tDlpYiU1IlqgjP6hC6UOfiVttGwmou2RRF1dF5N3+wuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=JhiXYpkQzjLGTthVjpwYYHAyy2NJiDkV7bui1K5fAuo=;
	b=AFRWbtULFO3yj0dStoD6r5PWkELi0rJZwJjc3neQM1u0Cf5jHz7niFxJS0oiTkpg22D7
	 omS3RqUV0Dcyt9gbF9kO/H/EjEQ8AjkoleaOjCb7h2FYIvvlU5nFDCGlgrTk62ryBHmQM
	 MbMFPB5ZwdyFkCNiCWHlNckSpzVa3/abw6Ozr1fV62hFKioMMrD2otNaieuWNrWoKku8N
	 6j0mt1sik8CuQ8czCigWUkNos99IuHher1SS5kVdr6d+SvNFqPAM39OzAoTbYfMbYyiG7
	 sYVwQQyfvq7TM6dlhvWOTWrVbjw/NfW3FmQZRa53rhX3podhpKykGli5gjh2TORleZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Zog8kNj/";
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757BA606A338
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 757BA606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Zog8kNj/
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ed2803f863so8244325ad.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577787; x=1795182587; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JhiXYpkQzjLGTthVjpwYYHAyy2NJiDkV7bui1K5fAuo=;
        b=Zog8kNj//F+tJ47iZ4rd/vRdwfHcPmZr5PIpEYASYfSU0uIpdAaAQbKb2iSjKuGrJC
         LmUEbEK0fotsAIirWG4OVuVjWqDlP7pjuqWSA8ipK/qrk7DYRZNuaVDxOvHgO8kfS5gP
         iAjTP1uaV81zzy4WrR3/1ArFc86+k1PfnfcpRkgSeqWInm7zP0pERW/SD5cgU0GHTp/g
         QLtTRskr0/3u+qWWtQxU1Y2cafkDY01Es0N0hG0T1L7SoYF7+CpvMvrqir+NdpRFWV0W
         0f7V7cL5Svjza55mLbBuxfs/sAB4CwLy/CiFck2gS9zBwaFsk35GRMhzzzKtluEwoiP7
         jd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577787; x=1795182587;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhiXYpkQzjLGTthVjpwYYHAyy2NJiDkV7bui1K5fAuo=;
        b=uQbB02GlJvvN1G2jI8bq5ZdQexzWQ4kT64V3ArYUoqBfvt/e4stBCS0k+2JrI/6Sjm
         vKDrcMjkiHcpiqqEOyNBkJ+phunr/TWK4iqfpxRR+tH6zBnYFO5FOv0Kj2Hv/8BtNvYy
         0CxviwiC6wb6xcnEl1guLy/Nf2zuXs+BVi+FyCteLCEmNgIcDCiv38G3tugpgRHHQlF/
         6i0DfvxoBBu7oemZfXyJqx6I5k5zSo+DJjWPPeokZotntiv21Bp7og09ZliJeG62t73l
         5+2WqXyo29klHMy9AyrFMhUtLe69cG1mX8WGaJrNNYTwPn7cB7QxihKpgdvUfbJhSMJq
         9iZg==
X-Forwarded-Encrypted: i=1; AL+hErGKiWYNYF99ikWL1Dq2ZrnNPbj54N41C1ZmU+0/E5rtgwyAgi591kRYSmkkFELRBhQgwuo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PkIh+PrWxeMt9/yQX9gDfoxTjA9PppX1U02Ha5T1MzB9dm0vu
	+KwII2o9fZWWnynbaRyEwqlofd5rsXm/TO7TQKwTXaJkYkaIQdg0uW6kttQaYs4g5HCaCcUJ9c6
	p1woqfw==
X-Received: from plnd4.prod.google.com ([2002:a17:903:1984:b0:2e9:6b18:1067])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:eccc:b0:2e8:e17d:c8c3
 with SMTP id d9443c01a7336-2ee0dcd18admr25455115ad.62.1794577786632; Fri, 13
 Nov 2026 05:49:46 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:44 -0800
In-Reply-To: <20261027001600.2742995-1-ingyujang25@korea.ac.kr>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027001600.2742995-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441787804.77218.13995076862430553653.b4-ty@b4>
Subject: Re: [PATCH] KVM: x86: Move PIT existence checks into the PIT ioctl helpers
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ingyu Jang <ingyujang25@korea.ac.kr>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 27 Oct 2026 09:16:00 +0900, Ingyu Jang wrote:
> kvm_vm_ioctl_get_pit() and kvm_vm_ioctl_get_pit2() always return 0,
> so the error checks on their return values in kvm_arch_vm_ioctl()
> never trigger.
> 
> Move the !kvm->arch.vpit checks from the callers into the PIT ioctl
> helpers, so that these error checks handle the missing PIT case.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Move PIT existence checks into the PIT ioctl helpers
      https://github.com/kvm-x86/linux/commit/9e03a08bda04

--
https://github.com/kvm-x86/linux/tree/next
