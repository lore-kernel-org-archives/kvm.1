Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63A41E6B0
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057511; cv=none; b=VBR8p/4VRoGKPwM/WIC+lBrX2fawxN/iQYvCPjuvqRJH6QE5pZ2I6GkTFIaqTy0re+h6fXMz/NJQaD0s50ZUpR//AOXS3NDrENimtmshdOlGxboimkcM99w+EpxDUaO1uh0/O1jhTNpb3dn4p/VMDCCI/1J7eU59noGb4bgwSQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057511; c=relaxed/simple;
	bh=zBLrKk2/S/Y/gwTKhwDvV/XWHEBjV9TpmE5jgC/YnfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WwpXz40zdJBtEGXJKuyFGjpgNS4ZIKdpy2TxMoW1NE6xcPi9n6aPfDmj2tVDHEvA8Y0vI8VJ46jLC8LX82IQuT63FF481UqNkWXjowKbO6cJVf4oaWIhqVfq4iuBd5vzCe6tXEhvWXOOh16DMIWL/dX+H7um18AiYwMHFzrSoZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ukZIK1qH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ukZIK1qH"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cec4226c70so49764475ad.1
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 12:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784057510; x=1784662310; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eR/18zsrMMGcldE7ilLicCKB2hwhDLFoEZeran38Faw=;
        b=ukZIK1qHwaG2U1FQAIKcBi5a1Niazr/filjxeKSIkK/2HLMqzFeRZMUU3dSxKHHyJe
         3yCP2+0tzlP7Bzq3ngs1SuVZ79+6e7l9WqMlxVGVJCTWdJZMBVOTcFkpA5c1ISxxBhvI
         B5yIGkrtBYc6SjttUypAY7HuMs7NOWvrfxRh6R3ubdaa0r0w3punChH314FpO1sAw+N0
         qkHKGkv5SGXxdjS3yZ426EE1ToneV3BibquqEXglMquCK3Btwkbj7Z7VqhXvcfRgqEXX
         OYvQfZsrp3UhoHnzemp5wwH3TiAOhHsKmiJa+VYwa2mSdEOFYeVDNYD2a4xbqX7ceBrT
         iQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057510; x=1784662310;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eR/18zsrMMGcldE7ilLicCKB2hwhDLFoEZeran38Faw=;
        b=ldZZX3RVWuVF3UomDKvnPHKBSFrPaG8apy0e8pCrw0RtQazi2+Hcanyxr2f5DdmqFU
         ioY4Vx9x92TMzearuC/qrk6HSmWjq6oITaz5KNCYIykOEUw8yC44V69cuD1ENKOQl5Mv
         XKPiNErRz/TaZF7lnDz8/OuUwdPaTwYp6/3v9ZjgirE2Au/oq5ZYaarI11yWfRxG4SH4
         SAND8n2EkwMX6n+XDyICRgml3heIjAs7CaVNDn3Fj3tUFAmhOWrMEQF5fcEnUbDm5HEq
         vplYjXLJ8LGCyQ6TqnxQhmn0i4VI1sWwTe9oxhgnllXie7ic5XFLcgjDZ3z++ktdgO8h
         nr0g==
X-Gm-Message-State: AOJu0Yypj94yhxM4KIPfIUAmaiely89OwY/N2N1ohwWZK9PzCyF5LlkU
	+DcmtESvJRGGN9VbHLap9oPAHyA39r5opfLvqhlJDJq3YnYrI+wc48WYjjgPZ5G0301qLWh7Yz+
	3YaWAFQ==
X-Received: from plrt4.prod.google.com ([2002:a17:902:b204:b0:2cc:89b8:4244])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19c8:b0:2ca:feb:303b
 with SMTP id d9443c01a7336-2cef143a620mr49401805ad.25.1784057509680; Tue, 14
 Jul 2026 12:31:49 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:39 -0700
In-Reply-To: <20260618085217.3934985-1-maqianga@uniontech.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618085217.3934985-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405353092.3120562.14765440294938889890.b4-ty@google.com>
Subject: Re: [PATCH] KVM: SVM: Remove redundant ret = 0 in svm_set_nested_state
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, tglx@kernel.org, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	Qiang Ma <maqianga@uniontech.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 18 Jun 2026 16:52:17 +0800, Qiang Ma wrote:
> In svm_set_nested_state(), the success path reaches out_free with
> ret already set to 0 from nested_svm_load_cr3(). The explicit
> 'ret = 0' assignment before out_free is therefore redundant.
> Remove it.
> 
> No functional change.
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/1] KVM: SVM: Remove redundant ret = 0 in svm_set_nested_state
      https://github.com/kvm-x86/linux/commit/bfafeb04a040

--
https://github.com/kvm-x86/linux/tree/next
