Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C7241F37C
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057521; cv=none; b=hqQ9LBwBZZgNyHsJen0uAkWGP5xaN3x+/TE85aTsAg4G4g8EpCqxied0/vUJs7mTclHsKyakhNL6k8AT8tytts3wOy+xGZzXlCoutjuAnLnlfy2BwMUdCsOL8sN0bTsewyUZQEPxgBnZ2uQz60xELkgUIh1LdE0kB0T8WoSn4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057521; c=relaxed/simple;
	bh=F66BGJJepm15Vt1vWRJ2sR/Ffrl3D90qFzrapIANysw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tLe53engSkUsb4NA6O/k86eVwMQDtLMUj49cRi0ya73CsSbd3jeNX3tI57yCCGWilWpPTf97vKE2spsy2q+nQXzR9tkGcZAz+NJXGm/0cafp8jGcid/AkEiO1QedXK8luk8HkQFSIRBRZfmVZxKml2ZvdOBdSRB0jXstDQ8Jqbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TWAUKvTf; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TWAUKvTf"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cc8bde6318so86729585ad.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 12:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784057519; x=1784662319; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGVfUSApWjO/eH8a9SrBYnNEpKJ6pyr9g97HeXSs/os=;
        b=TWAUKvTfXRV0P66/YMKpUkk276V9WWiTOZE3qcCFIbhbzfBCBEmoWHFvZyQnJAQTFP
         7UIxbAbil2S3cfIa0CZsL2RxTB89TDugE/GbqQQ7PACo/NGvBcChOanwbGJJkslSw+64
         DoDVKTQT7LsKZG87fV6deptrV36ZIUOz13Pp0c4OrNaEsoVxpQqPSDQ78ojcFrLAMBsC
         JjbTajbwgVQ6gZJAbhoNOMhN6VSSNSM5kF/wI8BXSk577QIssLHp+tXaHrliXKHj283z
         m0f/APki2JjHM/32W5zCRlDf34jfLemqvw7BM2PPUcQaPyT4YAb1KhKzeY10079uSiCV
         buLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057519; x=1784662319;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IGVfUSApWjO/eH8a9SrBYnNEpKJ6pyr9g97HeXSs/os=;
        b=qRNHgkKNyi7vM/AJaroTxTK9tewb52u+bWzOXHSL3LDtuC47NXv0JdYKCwoXzc2FOt
         EYaq5/Wc/hUf9Sz87jJRguQsRR6UY3on3MK5WmtC7+rxgqpNTT413aT5uiM+CVmhW14r
         j+LsccfBsmWMoNg+L3NY+7UYRcCFfq+Pm6bAfx7LCH0h/8eBYOxikMddywE3GrLwtTpS
         rFd9qH95zox6mKihPuF6M99nDA/JB74GB4BrKgXCNMVieXi+yxXDYWKtyEcS3z5S5RIR
         Nm/jDYSdn8XecHQh6RWEzR+CsCnDEmP0w0MvziN5Gm+WqG7Vi5Xe8+MyqJZkvK1aRKXA
         n7zA==
X-Gm-Message-State: AOJu0Yx9OE7TMqrwfECJdHXMsU0fBwT/lBCPmfsbK3GBsY5SpSwvMhXA
	iDEHfvFggw/J4wbFXuBcMGsOiNH+HqQL2W/aEvZWSdG4BcW+UmCGMPykcjk8X9C2rAHfAbyKUPn
	4uvt1/Q==
X-Received: from plem11.prod.google.com ([2002:a17:902:e40b:b0:2c9:a5a0:a677])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c7:b0:2cc:aa38:4df3
 with SMTP id d9443c01a7336-2cef11ca8eemr37631975ad.13.1784057519330; Tue, 14
 Jul 2026 12:31:59 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:43 -0700
In-Reply-To: <tencent_A78DC401911634111A3391650CB00FCD0409@qq.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <tencent_A78DC401911634111A3391650CB00FCD0409@qq.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405355529.3121073.10852331459307922259.b4-ty@google.com>
Subject: Re: [PATCH] KVM: VMX: Use cached vcpu_vmx pointer in MSR and segment helpers
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, zhanghao <76824143@qq.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"

On Mon, 29 Jun 2026 14:10:41 +0800, zhanghao wrote:
> From 3d30672f614d0472bf15ba9dd1efd085cddd5a93 Mon Sep 17 00:00:00 2001
> From: Hao Zhang <zhanghao1@kylinos.cn>
> Date: Mon, 29 Jun 2026 09:52:32 +0800
> 
> vmx_get_msr() and vmx_set_msr() already cache to_vmx(vcpu) in a local
> 'vmx' pointer, but a few cases still open-code to_vmx(vcpu).  Use the
> cached pointer for consistency.
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: VMX: Use cached vcpu_vmx pointer in MSR and segment helpers
      https://github.com/kvm-x86/linux/commit/6978adcc3e73

--
https://github.com/kvm-x86/linux/tree/next
