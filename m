Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3374A4993
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999640; cv=none; b=CGFO2CjScEkAde2jEMcgDRdClvnIS97yBCMSuJ3OSSUeysqq4FPwc2xjSqqWzR0k2/4OnVXY1UKxNkkYCFcUdvZDXEkmrUCBEEDa/HEVvSMJaXz8hKfV22Ao7YGGqvH6g+JKXemVb5mziyoUi4osuQf7wQSdAhiy9DiB7Pl5VFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999640; c=relaxed/simple;
	bh=KOZ0qB47P1ewJ3LD1bSwEcoCVnsnJF9mDPIxaNxavec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ABj21AskoV250vX1hv9X5bsD2Cpcrh2AKZF9Q9RaBiViWFC6oqt6jSCUE9zcLYBPPp1WtnVULLIDQnqHFzBOa0y65fNm02UzPnqClq4lj9b/8Upkmp70yvze63zdLSRObNzPHOpAJqkcntiDiYlw2r0uk+EmLAO12+q6FBa9KPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l51VD1oX; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l51VD1oX"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc52c77089bso4472547a12.3
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999639; x=1790604439; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2sMdkQ+BjHAUqyEvlsX1t+uQj30MsWabMHW4ps8eLKs=;
        b=l51VD1oX/m5tikehhVOkm+H0av9N+v099hDBXLuH2uyq/HXlNz3c9xkgjWQ5exqUXm
         3Fv1cAZxqEsDrIUvkkkE0zjDHMXR9KlW/yjAZ/DGQ1EiWD6HRmL57q5wLZKFq/IJgexL
         tUf40kE8PtPpCqyTrJhZqu4aQr0Uoa8mQFBVLVLohF4RDv63LMy7HbBf4jRX5P+bpSur
         B2zm8LRsD9PcKwUIEr9yprZEImU0pWHrSvDiQZRuI2lg7ZtVJSxefEU+wlLESOCrtWlg
         +WTwjXgZ4aMkQ4eKCVJQL7kDJRKpBRp6tg8FmX0QwJs8b9VNwJ7HrpSNPcEq35TR+GZE
         lPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999639; x=1790604439;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2sMdkQ+BjHAUqyEvlsX1t+uQj30MsWabMHW4ps8eLKs=;
        b=Mc1KO6JKXySFjwNJvjsMv5PLMk+iFPZacstB/jfAlK+vcUKiWc7g/mJsx0+KgOiw1w
         SXkK52Gn1eYiLkQDeR8jedwNza3KXu8kDzRmRrlU6exFv+3jJmPSgLANlQTq20pdKMAZ
         3Rgn68/U88/7ujZlnwd1erM7quoRHjVvi2nGbGSMksghxsHNCofExMtbuo61NVo+37Gc
         Zn5brdfYEsSVDh7XhBVh3SXLqz8oCH/rZ0YqhSSYL5YnW8eY7+y0KNtrB99l/NMD9mL1
         Mf0WPaFWxMBd2OY1yT5KY1+JsAtugbg+HII3BWwQV7WhGF5gYZ24Kd3iA1U4WEZYrakb
         O19A==
X-Forwarded-Encrypted: i=1; AKwUvBz0wMNY52YbKVgZCvFbVcezsyBDsbuabKZ6EFnfCQHd7Lw5P1Cb6mmkY6S9Nr/fc+DPFpg=@vger.kernel.org
X-Gm-Message-State: AFuF++kT+TCMp07OHorNOnXtj5Mz+nGxOWhmgQXYv9dW6O9NV9fz/ZCu
	2TOIJyvJXFhTQAEnCDfG6RE2SJVZ8yfJM9WBiR7LvAEr3FP3/KhfoyW3EpKlygXQIwT78wkprPd
	6QJatXg==
X-Received: from pfkh29.prod.google.com ([2002:a05:6a00:1d:b0:878:7d16:4125])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:4049:b0:3da:c10c:6aa6
 with SMTP id adf61e73a8af0-3dd8c2dc837mr19064460637.1.1789999638674; Mon, 21
 Sep 2026 07:07:18 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:30 -0700
In-Reply-To: <20260808061934.400892-1-gokul02k@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260808061934.400892-1-gokul02k@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999927506.754839.13676560116435386306.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Fix the bounds of the SEV debug dst
 buffer check
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Gokul K <gokul02k@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, 08 Aug 2026 11:49:34 +0530, Gokul K wrote:
> validate_dst() is passed a starting offset and a byte count, but bounds
> its loop with "i < nr_bytes", comparing the offset against the count
> rather than against offset + nr_bytes.  Only calls that pass offset 0
> check the region they were asked to check.  Every other call checks too
> few bytes, and any call whose offset is >= the count returns without
> checking anything at all.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Fix the bounds of the SEV debug dst buffer check
      https://github.com/kvm-x86/linux/commit/622a09f6deb5

--
https://github.com/kvm-x86/linux/tree/next
