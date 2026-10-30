Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386247;
	b=UlzZhehHAehdNZooUk2l+YYlaSXldkEdI/XgYlJmUZKCdpaGxXzXOmUdAErPZpV/i3Fa
	 ZWF1BVveFimbCksisyybrb31JwzIskz+TjJiS6NvZLnoGnEGqCy6G39v8RbDINdGeTerL
	 3QND22aprNQD0LPfOv/DG9mPg8wbuYDDpqJuiDfGh0kCwn7agElRjGxpgLAGmmI5R7ELd
	 7iRyf4lz3ylmsSgPkjTiJ7Xfhs/YdZuLTzjs08cVYeVRTes5rgwW0E4qYmrDXJxSrvavE
	 rRtkkVd806zXNX2LFEKtY5gn/FleVPDtHMo9R5dsjT0+kltAhKQxcwGngoahRqyEWrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=35Nd/v4AiZNRM04W1nUZxXcF7X5HwhWNtrnudrsF4gE=;
	b=xxBxWf8tkAUgW09TxhnUlGtc8qWn0TIV1sp9zgNlhCWMGzllMcPvbNy5WqU101joNB30
	 drbSaHUAatC83Yb2Ohn038dJAw7F6HbIO2BZA8aAT1I5XRSU+5az5CmyMvgCCtLHkLHnL
	 8JXFPEuVDVv7vYEAtYzuuw+0HZWaeml03g24cjHX7I9X9jU8m2+/BmVkKFGRBurJG6OSI
	 IIiHuyIZ+2LCraHzAP/JMJas/D8PNhnNCJjM54DGPbjLdm3vly+E3Uq5excmNAHWe2BrG
	 sblF2XrPcevz5lf3nGS79J4o7jYvhcQYnFzhXye5D/lUHSC4bW5UQFndV4s7zTVCmgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i809iUWR;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194E1606A31A
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 18:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 194E1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i809iUWR
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3adf71ee6a5so1365402a91.2
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 11:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793386246; x=1793991046; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=35Nd/v4AiZNRM04W1nUZxXcF7X5HwhWNtrnudrsF4gE=;
        b=i809iUWR5+5KDqhWfhVE9dHX1JnTYhGiAxMAr9AMPXZy1cnNvI8H9Rya6or/Lgj5ms
         WA7fK5TkK6/wavgmBrhVIw29knodchEhXotj6nrzUqcCT7c7A0nQShj01GU28WvQfVMV
         SbuusefLcf+t2WlEgtvZ6a297o7Wmq0HGBnACj9iayPi8orct7IrtqaGkjjIgHCVXxDs
         cdkUMRkuP45qsPB1pbzI9iLXBULqi7RSpmoSgzgTOGAxynJGkTngSoErCgpRxQ1pBK2x
         bqqSTCan78vjREP3COyRjkcav0doaYAJeQ/o5nsqoQTLX3HTTqmp4W064m9xC1n7ObEY
         xkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793386246; x=1793991046;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=35Nd/v4AiZNRM04W1nUZxXcF7X5HwhWNtrnudrsF4gE=;
        b=zf7UBXMeGXoJS8TpSZs2HRg4H/URC7norRcnucC3WJDVSeRC47JYqGmIouNpmVIH0Z
         9p8iMp3Hco9szo3Fr7UERFMNwC9dlo0sYSmCmNeIKgugy5n5kX6hunUK2FmrxozdJpYv
         KYYO3Oq5NKq6qHnnqZ0F39sQ3j0W6AfG77UF3zBokPDuAyrDFesEDlk+ksv9AXDzWZiI
         ogdj9MgNk+MLxC998Wuo8VhHrtZe+XIcNIwAtm8yX2ADhpe2H55NIacsLt3RzPkPCj3h
         so7f1Fh9kx+uEgKaZfGLME55+hw+014iLRDcY0Vk+78xkFpluwlMkgcq+kioIBtxA7Nu
         DXwg==
X-Forwarded-Encrypted: i=1; AKwUvByYN2UR/qUQE3iO8FyymsLHAPQYV6XEPeuwAN2XHnQsj4ABn6RsqZGxPLB5gJDnABcHH2I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4Swa3PZ4aF7xHvWBv+hFNuKgoITXeFb/RnawuW/ZS+a9qc72J
	hwGvQFWD33M1raPQX7CZgReWO9/+ixTraGdK5Wfsn0Nkufo4sakQRhIv2Ja2q7kZXb+bBOeSgFe
	7SIT0kA==
X-Received: from pjyt8.prod.google.com ([2002:a17:90a:e508:b0:3ae:7abe:56ae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5250:b0:3ab:d45c:59da
 with SMTP id 98e67ed59e1d1-3ae897936f9mr2730232a91.40.1793386246143; Fri, 30
 Oct 2026 11:50:46 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:50:45 -0700
In-Reply-To: <20261030032937.2813-1-ma.mandourr@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030032937.2813-1-ma.mandourr@gmail.com>
Message-ID: <auTnBZMSHWKL4j4b@google.com>
Subject: Re: [PATCH v2 0/2] KVM: nVMX: Don't let L2's LMSW modify CR0 bits
 owned by L1
From: Sean Christopherson <seanjc@google.com>
To: Mahmoud Abumandour <ma.mandourr@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 29, 2026, Mahmoud Abumandour wrote:
> When L2's LMSW exits to L0 but not to L1, KVM emulates it with
> kvm_lmsw(), which ignores vmcs12's CR0 guest/host mask, so L2 can change
> CR0 bits that L1 owns.
> 
> v2:
>  - Patch 2: order the CR0 store before FNOP and check L2's whole CR0.

I'll send a v3, I already spent an absurd amount of time figuring all of this
out.  I really hate x86 sometimes.
