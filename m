Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8362230569F
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975304; cv=none; b=Fvy8IH87kHE3418QwBhvyENcquSuGnb8ziM/cbFQcmIunX4GB/eZEtpovgMUuWGD1OhM+IsjrCh/NG/aUPKSGx0d0DcZZeWQVofU7v7hxfKRE4bWK03JiCCeimyNFp6uS9Vz0ywUSJzQqhqzTgQ29iMJIE58AJGl8RO9Ju2MKUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975304; c=relaxed/simple;
	bh=ZN/SEyMkSoiX+Q0hOx6LzmukQtaFtkrIbMxkCmPRUww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=coRice8+Vfgjybit0a6pfquRqdzhYq188TZIU9jm8eTDrUEczYAaTL2/Sn89CnQgQ/ZRFhIeDVNBDZE9j2bL2z794MPST+mcYuqxoDpQqNbbC7otgNLPWEse+T0mMLvmmauFZCyr3RdsUfCCJ1mWCoqxY3cLdAYl7h4w1rzHQT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H9Hr5gK4; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9Hr5gK4"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso34348a12.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975303; x=1791580103; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dDYkUWbg+LQ8LTMVPUG7v2Xn0lV/WcTjTYf6ZHUcMLQ=;
        b=H9Hr5gK4TwH01i6qmW4HhEl1dcDJiESKcwx3TL3uwasAvw0ro9UuKy3al5+2KFugRD
         YBZUEdETluhEpCIOWQUMEJ1e2TIb9t8V3klJym4ECgEGnYyzD8h4z6UjtNvOcWMeiQ+b
         /9MB0aVP8/1svgMV49gWIQWP2pzrKw2xaflUTe8tR6nQ3jTwefAheMtkhuifGqgQajUV
         9IZNQagpGIfyevgiNov+tGoNJaMliWfImFwmQLxiInNJtM7Ek8hWu7xEh6/x2QdBuLgb
         6RxmBoKp+RQzXcsQ4fiq3IYr64UyE+o+hFLk3KJBnnz6+FXBXniMtpni1Z/6m28rtIxC
         pd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975303; x=1791580103;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dDYkUWbg+LQ8LTMVPUG7v2Xn0lV/WcTjTYf6ZHUcMLQ=;
        b=olG9YRlPowEkGxz6kAR2CaVNr/mvGq1vv0aeKbesdKf7pkfIOE17cEVBcaCKhNR8RJ
         6sfAzNyiD8iiekEQq2+acwh0SQxqjHBJwAdPqG9G9fAlSVMuJ6X/i2HqfbOq3Oatbj9l
         QD0KXYdAR0SqXZPyeChbQdu8Wmiv7xQpKaB0VSJRPQw7fzrSUr0ToGXjI51eXuWioTjy
         EUHuTojOHB51+F0rqQz0ahN9qcxFWJTBuCacELy9WEZcxv1xZuCgf/5swqg765abiPqE
         r2fNfS65GR8LL+u1OMnRPuEuKJ5/mdD53FwyT8oIV/BJb8BDKsGoMqj5lPawqTQLTy7z
         mciA==
X-Gm-Message-State: AFuF++nWVLyiMVa04Gf+qGstn/fVeHNOOb58L4+zyhg80Fd9RX70c2Wp
	8OyjQ29Mv6ZvWd6+BoU6qoRi6dA5WhoTKdH6ph97KrZNkW/YFMklEzXc9t+7uH+6DXfrpNW9cqu
	gLkvGtw==
X-Received: from pgct4.prod.google.com ([2002:a05:6a02:5284:b0:cc7:b5cc:f08c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a03:b0:3de:48e4:c37d
 with SMTP id adf61e73a8af0-3e0bcf1beb7mr3750036637.26.1790975302708; Fri, 02
 Oct 2026 14:08:22 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:06:56 -0700
In-Reply-To: <20260905091008.40802-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260905091008.40802-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097515355.4084473.2237695462271714219.b4-ty@b4>
Subject: Re: [PATCH] Documentation: KVM: x86: Use struct kvm_clock_pairing in hypercalls.rst
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Karl Mehltretter <kmehltretter@gmail.com>
Cc: kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="utf-8"

On Sat, 05 Sep 2026 11:10:08 +0200, Karl Mehltretter wrote:
> struct kvm_clock_offset does not exist; the name is struct
> kvm_clock_pairing.
> 
> Use struct kvm_clock_pairing.

Applied to kvm-x86 misc, thanks!

[1/1] Documentation: KVM: x86: Use struct kvm_clock_pairing in hypercalls.rst
      https://github.com/kvm-x86/linux/commit/07de87723b6f

--
https://github.com/kvm-x86/linux/tree/next
