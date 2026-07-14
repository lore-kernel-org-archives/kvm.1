Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E84941F351
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057496; cv=none; b=sqcJ1h90/wCjIaYQcuxO2e9Vc2F0fcRsZ4fdVXOJvOzMFhcw4XsYifNiW/FWZbzaAEXZhY5aoydQzOuFeadPqL4+2YWcz1QHLVbJZSTl05aHPcSKNAhpKandF97/Z93P7AZWXD1rR4j76YnAeoOX7akLTk2qRpj7LP0z+pCJ7Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057496; c=relaxed/simple;
	bh=yKYyJufk0DZgbqc54a045Oifs7/u51YlboMgpl/phOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y/u6E96AUs6QUc0RYJAEJ2MtTHTqK/3t2AOvIfB3AJZFQ6U671Ld3EzSvz84j5FRS8hmxlwYTLtbgvM3lZFnnthU85UTwTdr4bz4+v3c8eZxrApHWeyfgW8okvG62HbRAdZ5ZFzW4dw1Fj7WpGs0RvIVnqEWjtYdxbWz/xb29Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEYxfSbP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEYxfSbP"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-380a638fb5bso1762339a91.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 12:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784057494; x=1784662294; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2zI1T86I1KeRqO6hJyqRu37Z534dn4W4XWxtwTQzoak=;
        b=nEYxfSbPiL207AVGgFdWCXzqW3EG74qWw8vQJ7eHy4E/4wkMvXOTrzdqA9X1wWdiqw
         cQjP80MnaoX+HA4VNOrarHEpUNYfoN76CgaH3t8x+jT4L3IaDg5V922IfEY6Cl7Rz5X9
         IHpikafAy8xdmknGDyA93/pdmKytfTHLXDo/ryV/O0jbP1qJNLHB0eck6NdHA9Zbm+ca
         RsDiMvR5TVxqQjD0Gk94K4RWiUpM0Nle2TfmaTz/5qZDYPoZoMRoLlf6LO1GYzmhrh8D
         Mz6aBf1egDZRWoI1Ed/dCn5OJ+YfcapP3K+MDjyluMR91n048j3AdgEFDhgkBVla8MSj
         6AzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057494; x=1784662294;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2zI1T86I1KeRqO6hJyqRu37Z534dn4W4XWxtwTQzoak=;
        b=SKjF7Au7gn19sp9RNNujuI4Wzfq+6/siHVXo3xUUut9UqleB9hyLDWiWdWj/NRPF0B
         ZPDBYQ43DuxhXTHP1BMzagqqe9OpnHkkITvGZ8SN+6jsPMCAWqiI4ivhBob1M28iXJ7d
         ymDbiOL+6m3NB1OTGIXwobI6tMJSSvBItchSa8m13rE/JhFuqKzjh8ZrY6vibcQ4E2VV
         s/BmkxiO1V5krC6T0IQ9rfa4Ty8BfeyFbqK0Mvn2vWuNKZFaJH1ec9ee1A8HBeLiJNQE
         PVLJUNESZuNn84OuEZOnBsb8BFusGBtZjJkw6FbF4YiHsY2Lo6sNvjbeCLDy+W1bCWK5
         ATSA==
X-Forwarded-Encrypted: i=1; AHgh+RoeW1VM07pyTLHzn+qLIGYYvk7PZW5aJuKn+O5c3K8aF/J28Du/IXEZ5lz4TadubYCpkqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBeUkaCgbhiG/gEi6qjRMG3hJIxULEcdoZ5pKno/3PiKO5DEW9
	/0ZOLSQ/nq/oqHZgQngUTQCPA6CHIUf+Ly3lcx9/PSb59qYKW3S+72E0vsih3kaYnHYbhLmPlJg
	XtPckJg==
X-Received: from pjnm21.prod.google.com ([2002:a17:90a:8595:b0:383:c59b:fc00])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5583:b0:383:f52b:d616
 with SMTP id 98e67ed59e1d1-38dc75e3a5fmr12946540a91.10.1784057493565; Tue, 14
 Jul 2026 12:31:33 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:33 -0700
In-Reply-To: <20260616214652.2157032-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616214652.2157032-1-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405410379.3133317.1863414549561024437.b4-ty@google.com>
Subject: Re: [PATCH 0/3] KVM: nVMX: A few TLB flushing fixes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 16 Jun 2026 21:46:49 +0000, Yosry Ahmed wrote:
> Fix a couple of issues surfaced while working on TLB optimizations for
> nSVM. I did not add a Reported-by tag for Sashiko, because in both
> instances Sashiko did not report the problem (or the nSVM equivalent),
> but it spit out a false positive that lead to finding the problems (and
> I don't know how to capture that).
> 
> Sean Christopherson (1):
>   KVM: nVMX: Decouple INVVPID operand checks from flushing of vpid02
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/3] KVM: nVMX: Always flush vpid02 on first use
      https://github.com/kvm-x86/linux/commit/f0772389413d
[2/3] KVM: nVMX: Decouple INVVPID operand checks from flushing of vpid02
      https://github.com/kvm-x86/linux/commit/32912404b4b1
[3/3] KVM: nVM: Ensure INVVPID is emulated on the correct physical CPU
      https://github.com/kvm-x86/linux/commit/6d00e67326d8

--
https://github.com/kvm-x86/linux/tree/next
