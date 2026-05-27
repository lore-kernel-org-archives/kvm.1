Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069BB26E6F3
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905443; cv=none; b=cW7dHDLRZz2qrlEOtl2j+NPxxI3PSjnZfxYGNr+TJKHTaKMbzlDR1lG5anGi8rVehRRVFLjp8+n7ZuYPMUdPh8xyiwVfiUAeSfMBXOoBcmjGaHCBzn3o4mhk8l7QRnUJW0l1i80XEkrFMXCArqxx3bVneuz50hJNoicLLzdG0sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905443; c=relaxed/simple;
	bh=vD7Z1uwAOOj8HLA3A0R2R+pDuqKqPQO3hl9mNhB+z2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N5PKvHF2OzG77i20Q38NKlHgPXWZp8V4WNClpjdoiS+gLysxxrbcrgdd/OIjji/nwzQVtXpxt/xvkmWVrPohukX5OcpWH+CE5ptly0A7qDyHhbTIRgYv9JD9eSMJ0SI5SYit3IkNW9Ih0mfOP1twjl5nMl6KCRPH1MojVlVV/dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XupS0I7z; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XupS0I7z"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8525f0807aso7187973a12.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779905441; x=1780510241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Np/OItuQ6m2jiaq8oFExsRdWTtB2lIJ4HzLREe1aTCQ=;
        b=XupS0I7z2VeuD5AyLb4iQrNp8k5+xMf+QrAmE/To7A7bAola0azCYRdkufHVOx69vF
         AN/CGnvAQHIqiRqH6g5TzoPlYUxFteKdpw91o1F8RRNsfne1ze79SpFDGdQzdU9xwo5K
         NX9lGLQ2q/6NQ771VRdVo95T/r8jHpnRKn2wwyb9otVDMqhMH3P53uNePbXZccjqSG5l
         /HhyVRP5pMzIbHjZgP/BrCCASL/XyRZIUJKsw4a6XoKk/QNz4LgzYMJ7JtkKzmcbG0Wz
         pgyKrPXo/RiysUz4UbMnjfrNl/M8EQtTgbCdZ2LAXRFzLxCa/C57SZHRu3wxBzxrSJj7
         hnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905441; x=1780510241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Np/OItuQ6m2jiaq8oFExsRdWTtB2lIJ4HzLREe1aTCQ=;
        b=fNs8MFX2sRfPLf5A6G2VG7wY3DD0wlhb5XsKh2t8H3X8RXDbcYr366VX4vUw29gK/I
         3psiBz9B+MnpVQMlhnx1mrPfSUy8m+AUYm/E41nqgz6YboIrGyz0av4X3abnpwH9BNw0
         06TCRsu/mzDKarZHMQasnr91631lUJFr3fK3Xp4U/rF/ORgoP4YuulmFgR7mhaaEouzV
         6TerpPYeFAY89KQdzSht5PK5SlhsSn1xmTYzFpZcftrPIWS3VQUfV0ZPm4oT4w/bnmu9
         Ii724Ookgi1rX809GXe0tqpFbLVcF3FHsapFKtmGh2N5ItUTp8MonYp64JZ2uZwrCdME
         hLPA==
X-Gm-Message-State: AOJu0YysWvl+XSAee4vsL1R2uk8aDzbJay6IgoimSsABGm3l5/SI3Hrh
	iDS6FdGy1wb2R/3kRU+09Bx2qZLNS5WfuuTawBZ/yT+aHgaG9dOt+p3lNXbHa8n9veJANEcu62J
	c6J6xEA==
X-Received: from pgjp1.prod.google.com ([2002:a63:e641:0:b0:c85:117a:2b31])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e545:b0:3b2:a8cd:ef4b
 with SMTP id adf61e73a8af0-3b328e5ae80mr23811804637.25.1779905441022; Wed, 27
 May 2026 11:10:41 -0700 (PDT)
Date: Wed, 27 May 2026 11:10:04 -0700
In-Reply-To: <20260520144244.2657106-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260520144244.2657106-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177990533846.4122380.3451229061654828513.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Remove unused X86EMUL_MODE_HOST define
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 20 May 2026 07:42:43 -0700, Sean Christopherson wrote:
> Drop the emulator's X86EMUL_MODE_HOST #defines, as they have never been
> used by KVM (they were likely copy+pasted from Xen's emulator).
> 
> No functional change intended.

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Remove unused X86EMUL_MODE_HOST define
      https://github.com/kvm-x86/linux/commit/5aeb1e35a421

--
https://github.com/kvm-x86/linux/tree/next
